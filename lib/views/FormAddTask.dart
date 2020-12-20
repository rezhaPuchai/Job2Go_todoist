import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todoist_project/connections/GetApi.dart';
import 'package:todoist_project/connections/PostApi.dart';
import 'package:todoist_project/helpers/Const.dart';
import 'package:todoist_project/providers/ProjectData.dart';
import 'package:todoist_project/providers/TaskData.dart';
import 'package:todoist_project/providers/TitleData.dart';
import 'package:todoist_project/views/HomeView.dart';

class FormAddTask extends StatefulWidget {
  int id;
  String projectName;

  FormAddTask({this.id, this.projectName});

  PostApi postApi = new PostApi();

  @override
  _FormAddTaskState createState() => _FormAddTaskState();
}

class _FormAddTaskState extends State<FormAddTask> {
  String TAG = "FormAddTask ===>";

  TextEditingController inputTaskName = new TextEditingController();

  bool isLoading = false;

  GetApi getApi = new GetApi();
  PostApi postApi = new PostApi();

  @override
  void initState() {
    super.initState();
    print("$TAG ${Const.title}");
    print("$TAG ID: ${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: InkWell(
          onTap: (){
            // project.setIsHomeView = true;
            // project.setIsProjectView = false;
            // tData.setTitleMain = "Home";
            /**/
            // Provider.of<ProjectData>(context, listen: false).setIsHomeView = true;
            // Provider.of<ProjectData>(context, listen: false).setIsProjectView = false;
            // Provider.of<TitleData>(context, listen: false).setTitleMain = "Home";
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeView()), (Route<dynamic> route) => false,);
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white,),
        ),
        title: Text("Add new Task"),
      ),
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Project",style: TextStyle(color: Colors.grey, fontSize: 15.0),),
                        Text("${widget.projectName}",style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextField(
                      controller: inputTaskName,
                      style: TextStyle(color: Colors.black, fontSize: 19.0),
                      decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)),
                          hintText: 'type here',
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: 'Task name',
                          labelStyle: TextStyle(color: Colors.black, fontSize: 18.0),
                          prefixIcon: const Icon(
                            Icons.work,
                            color: Colors.black,
                          ),
                          prefixText: ' ',
                          suffixStyle: const TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(isLoading)Container(
            color: Colors.black.withOpacity(0.3),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(inputTaskName.text.toString()==""||inputTaskName.text==null){
            Fluttertoast.showToast(msg: "Require task name");
            return;
          }
          else{
            if(isLoading){
              return;
            }
            _onClickSave();
          }
        },
        icon: Icon(Icons.save),
        label: Text("Submit", style: TextStyle(fontSize: 18.0),),
      ),
    );
  }

  _onClickSave()async{
    if(inputTaskName.text.toString()==""||inputTaskName.text==null){
      Fluttertoast.showToast(msg: "Require task name");
      return;
    }
    print("$TAG CLICK SAVE!");
    setState(() {
      isLoading = true;
    });
    Map data = {
      "content": "${inputTaskName.text.toString()}",
      "due_string": DateTime.now().toString(),
      "due_lang": "en",
      "project_id": widget.id,
      "priority": 4
    };
    postApi.postNewTask(data, widget.id).then((response){
      if (response.contains("Unhandled Exception")) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      var data = json.decode(response);
      print("$TAG SUCCESS ADD NEW TASK:\n${data}");
      getApi.getAllTask(/*widget.id*/).then((response) {
        if (response.contains("Unhandled Exception")) {
          print("$TAG == $response");
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          return;
        }
        Provider.of<TaskData>(context, listen: false).setListTask(json.decode(response.trim()), widget.id);
        Navigator.pop(context);
      });
    });
  }

}
