import 'package:fileupload/provider/detail_provider.dart';
import 'package:fileupload/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DetailProvider(context),
          builder: (BuildContext context) => DetailProvider(context),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          home: SafeArea(
            child: Scaffold(
              body: HomeScreen(),
            ),
          )),
    );
  }
}
