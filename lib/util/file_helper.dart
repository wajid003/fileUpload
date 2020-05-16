import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fileupload/model/file_data.dart';
import 'package:fileupload/model/filelist_data.dart';
import 'package:fileupload/provider/base_provider.dart';
import 'package:fileupload/util/sharedpref_helper.dart';
import 'package:fileupload/webservice/ApiRepository.dart';
import 'package:workmanager/workmanager.dart';

class FileHelper {
  static final FileHelper fileHelper = FileHelper._internal();

  FileHelper._internal();

  factory FileHelper() {
    return fileHelper;
  }

  void uploadImages(String filePath, int position) async {
    print("===uploading===");
    initializeWorkManager();
    Workmanager.registerOneOffTask(filePath, "fileUpload",
        existingWorkPolicy: ExistingWorkPolicy.keep,
        inputData: {'path': filePath, 'position': position});
  }

  Future pickImage(
      BaseProvider provider, int position, Function(File file) callback) async {
    File file = await FilePicker.getFile();
    if (file != null) {
      callback(file);
      uploadImages(file.path, position);
    } else {
      provider.showMessage("File does not exist");
    }
  }

  void initializeWorkManager() {
    Workmanager.initialize(callbackDispatcher);
  }
}

Future callbackDispatcher() async {
  Workmanager.executeTask((taskName, inputData) async {
    print("===executed===");
    FormData formData = FormData.fromMap(
        {"image": await MultipartFile.fromFile(inputData['path'])});
    await ApiRepository().uploadFile(formData,
        (value) async {
          print("===inside progress===");

          FileListData fileData =
          await SharedPreferenceHelper.sharedPref.retrieveFileData();


      if (fileData != null) {
        int pendingPosition = await getPendingPosition(fileData.pendingList, inputData['position']);
        fileData.fileList[inputData['position']].progress = value['progress'];
        if (value['progress'] >= 1)
          fileData.pendingList.removeAt(pendingPosition);
        else
          fileData.pendingList[pendingPosition].progress = value['progress']/100;
        await SharedPreferenceHelper.sharedPref.saveFileData(fileData);
      }
    });
    return Future.value(true);
  });
}

Future<int> getPendingPosition(List<FileData> pendingList, inputData) async {
  int position;
  for(int i=0 ; i<pendingList.length; i++){
    if(pendingList[i].position == inputData) {
      position = i;
      break;
    }
  }
  return position;
}
