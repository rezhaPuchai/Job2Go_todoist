import 'dart:convert';

import 'package:http/http.dart' as Client;
import 'package:todoist_project/helpers/Const.dart';

class GetApi{
  String TAG = "GetApi ===>";

  Future<String> getAllProject() async {
    print("$TAG getAllProject: ${Const.BASE_API}");
    return await Client.get(Const.BASE_API+ "projects",
      headers: {
        "content-type": "application/json","accept":"application/json",
        "Authorization": "${Const.TOKEN}"
      },
    ).then((Client.Response response) {
      var data = json.decode(response.body);
      return response.body;
    }).catchError((error, stackTrace){
      return "Unhandled Exception: ${Const.BASE_API}projects";
    });
  }

  Future<String> getAllTask(/*int _idProject*/) async {
    print("$TAG getTaskByIdProject: ${Const.BASE_API}");
    return await Client.get(Const.BASE_API+ "tasks"/*?project_id=$_idProject*/,
      headers: {
        "content-type": "application/json","accept":"application/json",
        "Authorization": "${Const.TOKEN}"
      },
    ).then((Client.Response response) {
      var data = json.decode(response.body);
      return response.body;
    }).catchError((error, stackTrace){
      return "Unhandled Exception: ${Const.BASE_API}projects";
    });
  }

}