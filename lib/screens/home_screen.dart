import 'package:fileupload/provider/detail_provider.dart';
import 'package:fileupload/resource/app_color.dart';
import 'package:fileupload/resource/app_string.dart';
import 'package:fileupload/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: AppColors.colorBlue,
        textColor: AppColors.colorWhite,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(),
          ));
        },
        child: Text(AppStrings.viewDetails),
      ),
    );
  }
}
