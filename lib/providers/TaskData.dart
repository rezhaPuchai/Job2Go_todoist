import 'package:flutter/foundation.dart';
import 'package:todoist_project/models/TaskModel.dart';

class TaskData extends ChangeNotifier{
  String TAG = "TaskData ===>";

  List<TaskModel> _listTask = new List();
  int get getLengtTask => _listTask.length;

  void setListTask(List<dynamic> list, int _id) {
    print("$TAG list: ${list}");
    _listTask = List<TaskModel>.from(list.map((x) => TaskModel.fromJson(x)));
    // int count = 0;
    // for(int i=0; i<_listTask.length;i++){
    //   if(_listTask[i].project_id==_id){
    //     _taskByIdLength = count++;
    //   }
    // }
    notifyListeners();
  }
  List<TaskModel> get getTaskModel => _listTask;

  int _taskByIdLength = 0;
  int get getTaskByIdLength => _taskByIdLength;
  set setTaskByIdLength(int value){
    _taskByIdLength = value;
    notifyListeners();
  }

}