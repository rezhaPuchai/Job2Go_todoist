import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:todoist_project/helpers/Const.dart';
import 'package:todoist_project/providers/ProjectData.dart';
import 'package:todoist_project/connections/GetApi.dart';
import 'package:todoist_project/connections/PostApi.dart';
import 'package:todoist_project/providers/TaskData.dart';
import 'package:todoist_project/providers/TitleData.dart';
import 'package:todoist_project/views/ListTaskProjectView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String TAG = "LoginView ===>";

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  bool isLoading = true;

  DateTime currentBackPressTime;

  PostApi postApi = PostApi();
  GetApi getApi = GetApi();

  int _projectId = 0;
  String _projectName = "";

  @override
  void initState() {
    super.initState();
    print("$TAG ${Const.title}");
    _getProject();
    _permission();
  }

  _permission() async{
    //await [Permission.camera, Permission.microphone, Permission.storage,].request();
  }

  _getProject(){
      getApi.getAllProject().then((response){
        if (response.contains("Unhandled Exception")) {
          print("$TAG == $response");
          if(mounted){
            setState(() {
              isLoading = false;
            });
          }
          return;
        }
        Provider.of<ProjectData>(context, listen: false).setListProject(json.decode(response.trim()));
        setState(() {
          isLoading = false;
        });
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<Null> _refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = true;
      _getProject();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProjectData, TitleData>(
      builder: (context, project, tData, child){
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
          child: WillPopScope(
            onWillPop: (){
              DateTime now = DateTime.now();
              if (currentBackPressTime == null ||
                  now.difference(currentBackPressTime) > Duration(seconds: 2)) {
                currentBackPressTime = now;
                Fluttertoast.showToast(msg: "Press again to close app", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.red);
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: isLoading == false
                ? Scaffold(
              appBar: AppBar(
                title: Text("${tData.getTitleMain}"),
              ),
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assets/user.png")
                                )
                            ),
                            height: 70.0,
                            width: 70.0,
                          ),
                          SizedBox(height: 5.0,),
                          Text("Melinda",
                            style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      trailing: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        project.setIsHomeView = true;
                        project.setIsProjectView = false;
                        tData.setTitleMain = "Home";
                        Navigator.pop(context);
                      },
                    ),
                    //Projects
                    ListTile(
                      // trailing: Icon(Icons.add),
                      title: Text('Projects (${project.getLengtProject})'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: project.getLengtProject,
                          itemBuilder: (context, index){
                            return _buildListProject(context, index, project, tData);
                          }),
                    ),
                  ],
                ),
              ),
              body: _body(context, project),
            )
                : Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }//end build

  Widget _body(BuildContext context, ProjectData project){
    if(project.getIsHomeView){
      return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: Stack(
            children: [
              if(project.getIsHomeView)ListView(
                padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height/8)),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/home.jpg"),
                      Text("You Have ${project.getLengtProject} projects",
                        style: TextStyle(fontSize: 30.0,),),
                    ],
                  ),
                ],
              ),

            ],
          )
      );
    }
    if(project.getIsProjectView){
      return ListTaskProjectView(id: _projectId, projectName: _projectName);
    }
   /* return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Stack(
        children: [
          if(project.getIsHomeView)ListView(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height/8)),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/home.jpg"),
                  Text("You Have ${project.getLengtProject} projects",
                    style: TextStyle(fontSize: 30.0,),),
                ],
              ),
            ],
          ),
          if(project.getIsProjectView)ListView(
            padding: EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0, bottom: 30.0),
            children: [
              ListTaskProjectView(id: _projectId,)
            ],
          ),
        ],
      )
    );*/
  }

  Widget _buildListProject(BuildContext context, int index, ProjectData project, TitleData tData){
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          setState(() {
            _projectId = project.getProjectModel[index].id;
            _projectName = project.getProjectModel[index].name;
          });
          //Fluttertoast.showToast(msg: "$TAG $_projectName");
          project.setIsHomeView = false;
          project.setIsProjectView = true;
          tData.setTitleMain = project.getProjectModel[index].name;
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 30.0, right: 18.0, top: 18.0, bottom: 10.0,),
          child: Row(
            children: [
              Container(
                height: 17.0,
                width: 17.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.primaries[13]
                ),
              ),
              SizedBox(width: 12.0,),
              Text("${project.getProjectModel[index].name}"),
            ],
          ),
        ),
      ),
    );
  }

}
