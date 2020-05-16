import 'package:fileupload/model/file_data.dart';
import 'package:fileupload/provider/detail_provider.dart';
import 'package:fileupload/resource/app_color.dart';
import 'package:fileupload/resource/app_string.dart';
import 'package:fileupload/resource/app_style.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var _detailState = Provider.of<DetailProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _detailState.fileList != null
                ? Selector<DetailProvider, List<FileData>>(
                    builder: (context, data, child) {
                      print("provider=====");
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return _getListItem(data[index]);
                            }),
                      );
                    },
                    selector: (context, provider) => provider.fileList,
                  )
                : Expanded(child: Center(child: Text("No List Found"))),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: RaisedButton(
                color: AppColors.colorBlue,
                textColor: AppColors.colorWhite,
                onPressed: () {
                  _detailState.updateItem();
                },
                child: Text(AppStrings.fileUpload),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getListItem(FileData fileData) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(AppStrings.fileName, style: AppStyles.labelText),
                    SizedBox(
                      width: 8,
                    ),
                    Text(fileData.fileName,
                        style: AppStyles.labelText
                            .copyWith(fontWeight: FontWeight.normal), overflow: TextOverflow.ellipsis,),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    Text(AppStrings.fileSize, style: AppStyles.labelText),
                    SizedBox(
                      width: 8,
                    ),
                    Text(fileData.fileSize + " mb",
                        style: AppStyles.labelText
                            .copyWith(fontWeight: FontWeight.normal)),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: fileData.progress != 1,
                  child: Center(
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 40,
                      lineHeight: 14.0,
                      percent: fileData.progress,
                      backgroundColor: Colors.grey,
                      progressColor: AppColors.colorBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
