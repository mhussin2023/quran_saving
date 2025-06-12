import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quran_saving/storage_modules.dart';
import 'package:quran_saving/dashBoardPage/dashBoardPage.dart';

AppBar getAppBar(Function refreshMainPage,BuildContext context) {
  return AppBar(
    title: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Center(child: Text('جدول المراجعة'))],
      ),
    ),
     leading: IconButton(onPressed: () {
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) =>  DashBoardPage(refreshMainPage: refreshMainPage,)),
       );
     },
       icon: Icon(Icons.menu)),
    actions: [
      IconButton(
        onPressed: () async {
          await DataStorage.saveBoolList();
        },
        icon: Icon(Icons.save),
      ),
      IconButton(
        onPressed: () async {
          await DataStorage.saveBoolList();
          exit(0);
        },
        icon: Icon(Icons.exit_to_app),
      ),
    ],
  );
}
