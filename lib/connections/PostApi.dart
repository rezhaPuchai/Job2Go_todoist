import 'dart:convert';

import 'package:http/http.dart' as Client;
import 'package:todoist_project/helpers/Const.dart';

class PostApi{
  String TAG = "PostApi ===>";

  Future<String> postNewTask(Map data, int _projectId) async {
    print("$TAG postNewTask: ${Const.BASE_API}tasks");
    print("$TAG jsonBody: ${json.encode(data)}");
    return await Client.post(Const.BASE_API+"tasks",
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${Const.TOKEN}'
      },
      body: json.encode(data),
    ).then((Client.Response response) {
      if (response.statusCode == 200) {
        return response.body;
      }
      return response.body;
    }).catchError((error, stackTrace){
      return "Unhandled Exception: ${Const.BASE_API}tasks ${error}";
    });
  }

}