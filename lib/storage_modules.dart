import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;



class DataStorage {
  static const String key = "boolList";
  static bool listType=false;
  //static final List<bool> _checkStatusInitialValue = List.filled(114, false);
  static List<bool> checkStatus=List.filled(114, false);
  static int builCounter=0;

  static List<String> dataFilesNames=[];
  // Save list of bools
  static Future<void> getFilesNames() async {
    dataFilesNames.clear();
   // dataFilesNames.add('noName');
    final directory = await path_provider.getApplicationDocumentsDirectory();//.then((value) => value.path);
    List<FileSystemEntity> filesList=directory.listSync();
    FileSystemEntity? tempFile;
    for( tempFile in filesList){
      if(tempFile.path.contains('data-'))
      {
      String fileName=path.basename(tempFile.path);
      dataFilesNames.add(fileName);
      print(tempFile.path);
      }
    }
    print("length=${dataFilesNames.length}");
  }

  static void clearStatusList(){
    for(int _i=0;_i<checkStatus.length;_i++) {
      checkStatus[_i] = false;
    }
    print('cleared');
    print(checkStatus);

  }


  static Future<void> saveBoolList() async {
    print('start saving data');
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = checkStatus.map((b) => b.toString()).toList();
    await prefs.setStringList(key, stringList);
    print(stringList);
    print('finished saving data');
  }

  // Retrieve list of bools
  static  Future<void> getBoolList() async {
    print('start getting data');
    final prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList(key);
    if(stringList==null || stringList.isEmpty || stringList==[] || stringList.length!=114){
      clearStatusList();

    }else {
      checkStatus = stringList.map((s) => s == "true").toList() ?? [];
    }
    print('finished getting data');
    print(checkStatus);
    //return stringList?.map((s) => s == "true").toList() ?? [];
  }

  static Future<void> saveToDevice(String? fileName) async {
    if(fileName==null){fileName='noName';}
    print('start saving data');
    final directory = await path_provider.getApplicationDocumentsDirectory().then((value) => value.path);
    DateTime now=DateTime.now();
    print(now);

    String formatedDate ="${now.day}-${now.month}-${now.year}";
    //String formattedDate = formatter.toString();
    print(formatedDate); // 2016-01-25
    String fileFullName='$directory/data-$fileName-$formatedDate.txt';
    print('filename=$fileFullName');
    File newFile=File(fileFullName);
    await newFile.writeAsString(checkStatus.toString());
    print('finished saving data');




  }
}