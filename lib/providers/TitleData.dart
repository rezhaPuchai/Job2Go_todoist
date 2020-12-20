
import 'package:flutter/foundation.dart';

class TitleData extends ChangeNotifier{

  String _titleMain = "Home";

  String get getTitleMain => _titleMain;
  set setTitleMain(String value){
    _titleMain = value;
    notifyListeners();
  }

}