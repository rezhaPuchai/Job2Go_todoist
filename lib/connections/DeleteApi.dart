import 'dart:convert';

import 'package:http/http.dart' as Client;
import 'package:todoist_project/helpers/Const.dart';

class DeleteApi{
  String TAG = "DeleteApi ===>";

  Future<String> deleteTaskByTaskId(int _taskId) async {
    print("$TAG deleteTaskByTaskId: ${Const.BASE_API}tasks/$_taskId");
    return await Client.delete(Const.BASE_API+"tasks/$_taskId",
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${Const.TOKEN}'
      },
    ).then((Client.Response response) {
      print("$TAG deleteTaskByTaskId RES code: ${response.statusCode}");
      print("$TAG deleteTaskByTaskId RES: ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      }
      return response.body;
    }).catchError((error, stackTrace){
      return "Unhandled Exception: ${Const.BASE_API}tasks/$_taskId ${error}";
    });
  }


}