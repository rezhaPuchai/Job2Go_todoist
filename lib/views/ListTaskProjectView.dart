import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_project/connections/GetApi.dart';
import 'package:todoist_project/helpers/Const.dart';
import 'package:todoist_project/helpers/ConvertTime.dart' as convertTime;
import 'package:todoist_project/providers/TaskData.dart';

class ListTaskProjectView extends StatefulWidget {
  int id;

  ListTaskProjectView({this.id});

  @override
  _ListTaskProjectViewState createState() => _ListTaskProjectViewState();
}

class _ListTaskProjectViewState extends State<ListTaskProjectView> {
  String TAG = "ListTaskProjectView ===>";

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  bool isLoading = true;

  GetApi getApi = new GetApi();

  @override
  void initState() {
    super.initState();
    print("$TAG ${Const.title}");
    print("$TAG ID: ${widget.id}");
    _getTask();
  }

  _getTask() async {
    getApi.getAllTask().then((response) {
      if (response.contains("Unhandled Exception")) {
        print("$TAG == $response");
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        return;
      }
      Provider.of<TaskData>(context, listen: false)
          .setListTask(json.decode(response.trim()), widget.id);

    });
    int list = Provider.of<TaskData>(context, listen: false).getLengtTask;
    // print("$TAG LIST TASK ALL: $list");
    // int count = 0;
    // for(int i=0; i<list;i++){
    //   if(Provider.of<TaskData>(context, listen: false).getTaskModel[i].project_id==widget.id){
    //     count = count + 1;
    //     Provider.of<TaskData>(context, listen: false).setTaskByIdLength = count;
    //   }
    // }
    if(mounted){
      setState(() {
        isLoading = false;
      });
    }

  }

  Future<Null> _refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = true;
      _getTask();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: isLoading == false
          ? Consumer<TaskData>(builder: (context, task, child){
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 200.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/ic_task.png", height: 80.0, width: 80.0,),
                        Text("List Task", style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: task.getLengtTask,
                        itemBuilder: (context, index){
                          return _buildListTask(context, index, task);
                        }),
                  )
                ],
              )
            );
      })
          : Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget _buildListTask(BuildContext context, int index, TaskData task){
    if(task.getTaskModel[index].project_id==widget.id){
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){},
          child: Container(
              margin: EdgeInsets.all(7.0),
              height: 80.0,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Checkbox(value: task.getTaskModel[index].completed),
                        Text("${task.getTaskModel[index].content}", style: TextStyle(fontSize: 20.0,),),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Create Date", style: TextStyle(color: Colors.grey)),
                        Text("${convertTime.toFormatddMMyyyyhhmmWithT(task.getTaskModel[index].created)}", style: TextStyle(color: Colors.blue),)
                      ],
                    ),
                  )
                ],
              )
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }

}
