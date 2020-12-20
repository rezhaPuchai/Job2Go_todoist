import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_project/providers/TaskData.dart';
import 'package:todoist_project/providers/TitleData.dart';
import 'package:todoist_project/views/HomeView.dart';

import 'providers/ProjectData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProjectData>(create: (context) => ProjectData()),
        ChangeNotifierProvider<TaskData>(create: (context) => TaskData()),
        ChangeNotifierProvider<TitleData>(create: (context) => TitleData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
          primarySwatch: Colors.red,
          backgroundColor:Color.fromARGB(255, 16, 39, 51),
          canvasColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "GoogleSans",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeView(),
      ),
    );
  }
}
