import 'dart:convert';

import 'package:fileupload/model/filelist_data.dart';
import 'package:fileupload/resource/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {

  static final SharedPreferenceHelper sharedPref = SharedPreferenceHelper._internal();

  static SharedPreferences pref;

  SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper(){
    return sharedPref;
  }

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }
  
  Future saveFileData(FileListData fileListData) async {
    if(pref == null) await init();
    pref.setString(AppStrings.file, jsonEncode(fileListData));
  }

  Future<FileListData> retrieveFileData() async {
    if(pref == null) await init();
    String file =  pref.getString(AppStrings.file);
    if(file != null && file.isNotEmpty) {
      Map fileMap = jsonDecode(file);
      return FileListData.fromJson(fileMap);
    }else{
      return null;
    }
  }
}