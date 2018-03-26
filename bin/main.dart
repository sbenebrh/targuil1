import 'package:targuil1/targuil1.dart' as targuil1;
import 'Functions.dart';
import 'dart:io';

main(List<String> arguments) {
  var folder = Directory.current;
  folder.list(recursive: true, followLinks: false).forEach( (file)  {
    if( file.path.endsWith(".vm")){
      compile(file);
    }
  });
  }

