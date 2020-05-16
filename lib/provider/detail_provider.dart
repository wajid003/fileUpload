import 'dart:async';
import 'dart:convert';

import 'package:fileupload/model/file_data.dart';
import 'package:fileupload/model/filelist_data.dart';
import 'package:fileupload/provider/base_provider.dart';
import 'package:fileupload/util/file_helper.dart';
import 'package:fileupload/util/sharedpref_helper.dart';
import 'package:flutter/material.dart';

class DetailProvider extends BaseProvider {
  DetailProvider(BuildContext mContext) : super(mContext) {
    configureListener();
    checkforPendingList();
  }

  List<FileData> fileList;

  String _token;

  String get token => _token;

  void updateItem() async {
    int position;
    if (fileList == null) {
      position = 0;
    } else {
      position = fileList.length;
    }

    FileHelper.fileHelper.pickImage(this, position, (file) async {
      int fileBytes = await file.length();
      FileData fileData = FileData(
          path: file.path,
          progress: 0,
          fileName: file.path.split('/').last,
          fileSize: (fileBytes / 1048576).toStringAsFixed(2),
          position: position);
      if (fileList == null) {
        fileList = [fileData];
      } else {
        fileList.add(fileData);
      }
      notifyListeners();
      updateList(fileData);
    });
  }

  void fetchList() async {
    FileListData fileData =
        await SharedPreferenceHelper.sharedPref.retrieveFileData();
    if (fileData != null) {
      if (fileData.fileList != null && fileData.fileList.isNotEmpty) {
//        print("1 list size" + fileList.length.toString());
        if (fileList == null) fileList = fileData.fileList;
        /*else{
          fileList.map((item) => fileData.pendingList.map((child) => {
            if(child.position == item.position)
              fileList[item.position].progress = fileData.fileList[item.position].progress
          }));
        }*/
        fileList[fileList.length-1].progress = 1;
        print("1 list size" + jsonEncode(fileData));

        /* if (fileList == null)
          fileList = fileData.fileList;
        else
          fileList.clear();
        fileList.addAll(fileData.fileList);*/
        notifyListeners();
      }
    }
  }

  void configureListener() async {
    Timer.periodic(Duration(seconds: 3), (timer) {
      fetchList();
    });
  }

  /**call api here**/
  void uploadList(List<FileData> pendingList) async {
    pendingList.map(
        (item) => FileHelper.fileHelper.uploadImages(item.path, item.position));
  }

  void updateList(FileData itemData) async {
    FileListData fileData =
        await SharedPreferenceHelper.sharedPref.retrieveFileData();
    if (fileData == null) {
      fileData = FileListData(fileList: fileList, pendingList: fileList);
    } else {
      fileData.fileList = fileList;
      fileData.pendingList.add(itemData);
    }
    await SharedPreferenceHelper.sharedPref.saveFileData(fileData);
  }

  void checkforPendingList() async {
    FileListData fileData =
        await SharedPreferenceHelper.sharedPref.retrieveFileData();
    if (fileData != null &&
        fileData.pendingList != null &&
        fileData.pendingList.isNotEmpty) {
      print("pending list size" + fileData.pendingList.length.toString());
      uploadList(fileData.pendingList);
    }
  }
}
