import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  //method to get the path of document Directory
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  // method take file path parameter and return file object
  Future<File>_localFile(String filePath)async{
     final path=await _localPath;
     return File('$path/$filePath'); 
  }
  //method that take string s and file path and writ spacifc string to file object
  Future<File> writToDevice(String s,String filePath)async{
    final file=await _localFile(filePath);
    return file.writeAsString(s);
  }
  // method that read the text from file path that contain the file object
  Future<String> readFromDevice(String filePath) async {
    try {
      final file = await _localFile(filePath);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'error';
    }
  }
}
