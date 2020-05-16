
class FileData {
  String path;
  String fileName;
  double progress;
  String fileSize;
  int position;

  FileData({this.path, this.progress=0, this.fileName, this.fileSize, this.position});

  FileData.fromJson(Map<String, dynamic> json)
      : this.path = json['path'],
        this.fileName = json['fileName'],
        this.progress = json['progress'],
        this.fileSize = json['fileSize'],
        this.position = json['position'];

  Map<String, dynamic> toJson() =>
      {
        'path': this.path,
        'fileName': this.fileName,
        'progress': this.progress,
        'fileSize': this.fileSize,
        'position': this.position,
      };
}