import 'package:flutter/foundation.dart';
import 'package:todoist_project/models/ProjectModel.dart';

class ProjectData extends ChangeNotifier{
  String TAG = "ProjectData ===>";

  List<ProjectModel> _listProject = new List();

  int get getLengtProject => _listProject.length;

  void setListProject(List<dynamic> list) {
    print("$TAG list: ${list}");
    _listProject = List<ProjectModel>.from(list.map((x) => ProjectModel.fromJson(x)));
    notifyListeners();
  }

  List<ProjectModel> get getProjectModel => _listProject;


  bool _isHomeView = true;
  bool get getIsHomeView => _isHomeView;

  set setIsHomeView(bool value){
    _isHomeView = value;
    notifyListeners();
  }

  bool _isProjectView = false;
  bool get getIsProjectView => _isProjectView;

  set setIsProjectView(bool value){
    _isProjectView = value;
    notifyListeners();
  }

}