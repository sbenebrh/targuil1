import 'package:path/path.dart';
import 'package:targuil1/targuil1.dart' as targuil1;
import 'Functions.dart';
import 'dart:io';
/**
 * name :main
 * params:
 * meanig: if the file end with .vm
 * it call the compile function
 */
main(List<String> arguments) {

  var folder = Directory.current;
  folder.list(recursive: true, followLinks: false).forEach( (file)  {


    if( file.path.endsWith(".asm")){
      file.delete();
    }
  });
  folder.list(recursive: true, followLinks: false).forEach( (file)  {


    if( file.path.endsWith(".vm")){
      compile(file);
    }
  });
  }

