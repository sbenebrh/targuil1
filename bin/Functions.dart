import 'dart:io';
import 'hack.dart';
import 'package:path/path.dart';


const int lcl = 1, arg = 2, this1 = 3, that = 4, pointer = 3, static1 = 16, temp = 5 ;


/**
 * name :compile
 * params: File
 * meanig: create a file with the end .asm
 * and call hackTransformation in order to write on the asm file
 */
void compile(File f){

  String temp = removeComments(f.readAsStringSync());
  List<String> stringtemp = fileToListOfString(temp);
  String temp2 = hackTransformation(stringtemp,basename(f.path) );
  File fileAsm = new File(f.path.substring(0, f.path.length -3) + ".asm");
  fileAsm.writeAsString(temp2);
}
/**
 * name: removeComments
 * params: String
 * meaning: it remove all the comments(start with // )
 */
String removeComments(String str){
  String temp = "";
  int temp1 = 0, next = str.indexOf("//");

  while(next >= 0){
    temp += str.substring(temp1, next);
    temp1 = str.indexOf("\n", next)+1;
    if(temp1 == -1){
      return temp;
    }
    next = str.indexOf("//", temp1);
  }
  temp += str.substring(temp1);

  return temp;
}


List<String> fileToListOfString(String str){
  RegExp exp = new RegExp(r"(\w+)");
  Iterable<Match> matches = exp.allMatches(str);
  List<String> ret =  new List<String>();
  for(var m in matches){
    ret.add(m.group(0));
  }
  return ret;
}

String hackTransformation(List<String> str, String fileName){
  String finaltemp = "";

  for(int i =0; i < str.length;i++ ){
    switch(str[i]){
      case "push":
        finaltemp +=  push(str[i+1], str[i+2]);
        i+=2;
        break;
      case "pop":
        finaltemp += pop(str[i+1], str[i+2]);
        i+=2;
        break;
      case "add":
       finaltemp += add('+');
        break;
      case "sub":
        finaltemp+= sub('-');
        break;
      case "neg":
        finaltemp+= negNot('-');
        break;
      case "not":
        finaltemp+=negNot('!');
        break;
      case "and":
        finaltemp+=  andOr('&');
        break;
      case "or":
        finaltemp+=  andOr('|');
        break;
      case "gt":
     finaltemp+= jump('JGT');
     break;
      case "lt":
        finaltemp+= jumplt;
      break;
      case "eq":
        finaltemp+=  jump('JEQ');
      break;
      case "label":
        finaltemp += labelfunc(fileName.substring(0,fileName.length - 3),str[i+1]);
        break;
      case "if":
        finaltemp+= ifgotofunc(fileName.substring(0,fileName.length - 3),str[i+2]);
        i+=2;
        break;
      case "goto":
        finaltemp+= gotofunc(fileName.substring(0,fileName.length - 3), str[i+1]);
        break;

    }
  }

  return finaltemp;
}

String push(String typeOfStr, String value){

  switch(typeOfStr){
    case "constant":
      return pushconstant(value);
      break;
    case "local":
      return pushlocalArg(lcl.toString(), value);
      break;
    case "argument":
      return pushlocalArg(arg.toString(), value);
      break;
    case "temp":
      return pushtemp(value);
      break;
    case "static":
      return pushlocalArg(static1.toString(), value);
      break;
    case "pointer":
     return pushPointer(value);
      break;
    case "this":
      return pushlocalArg(this1.toString(), value);
      break;
    case "that":
     return pushlocalArg(that.toString(), value);
      break;
  }
  return "";
}


String pop(String typeOfString, String value){
  switch(typeOfString){

    case "pointer":
      return popPointer(pointer.toString(), value);
      break;
    case "temp":
      return  popTemp(temp.toString(), value);
      break;
    case "local":
      return pophack(lcl.toString(), value);
      break;
    case "argument":
      return pophack(arg.toString(), value);
      break;
    case "static":
      return pophack(static1.toString(), value);
      break;
    case "this":
      return pophack(this1.toString(), value);
      break;
    case "that":
      return pophack(that.toString(), value);
      break;
  }
  return "";
}
