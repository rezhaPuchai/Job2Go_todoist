import 'package:flutter/material.dart';

class ProjectView extends StatefulWidget {
  int id;

  ProjectView({this.id});

  @override
  _ProjectViewState createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  String TAG = "ProjectView ===>";


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
        child: Text("${widget.id}"
      ),
    );
  }
}
