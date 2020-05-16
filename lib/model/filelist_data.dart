import 'package:fileupload/model/file_data.dart';

class FileListData {
  List<FileData> fileList;
  List<FileData> pendingList;

  FileListData({this.fileList, this.pendingList});

  FileListData.fromJson(Map<String, dynamic> json) {
    if (json['fileList'] != null) {
      fileList = new List<FileData>();
      json['fileList'].forEach((v) {
        fileList.add(FileData.fromJson(v));
      });
    }
    if (json['pendingList'] != null) {
      pendingList = new List<FileData>();
      json['pendingList'].forEach((v) {
        pendingList.add(new FileData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fileList != null) {
      data['fileList'] = this.fileList.map((v) => v.toJson()).toList();
    }
    if (this.pendingList != null) {
      data['pendingList'] = this.pendingList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
