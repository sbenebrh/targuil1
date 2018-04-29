import 'dart:io';
import 'hack.dart';
import 'package:path/path.dart';

var folder = Directory.current;
const int lcl = 1, arg = 2, this1 = 3, that = 4, pointer = 3, static1 = 16, temp = 5 ;
List<String> directory = new List<String>();
List<String> files = new List<String>();
File fileAsm;
String funcname;
bool flag ;

/**
 * name :compile
 * params: File
 * meanig: create a file with the end .asm
 * and call hackTransformation in order to write on the asm file
 */
void compile(File f){
 // initlist();

  String name = basename(f.parent.path);
  String temp = removeComments(f.readAsStringSync());
  List<String> stringtemp = fileToListOfString(temp);
  String temp2 = hackTransformation(stringtemp,basename(f.path) );

  if(directory.contains(f.parent.path)) {
    if(flag) {
      String tempfilecontent = fileAsm.readAsStringSync();
      fileAsm.writeAsStringSync(inithack(), mode: FileMode.WRITE);
      fileAsm.writeAsStringSync(tempfilecontent, mode: FileMode.WRITE_ONLY_APPEND);
      flag = false;
    }
    fileAsm.writeAsStringSync(temp2, mode: FileMode.WRITE_ONLY_APPEND);
    files.add(f.path);
  }
  else //if(directory.contains(f.parent.path) && !files.contains(f.path))
    {
      var folder1 = Directory.current;
      flag = true;


     // print (finaly);
  fileAsm = new File(f.parent.path+"/"+name + ".asm");
  directory.add(f.parent.path);
  files.add(f.path);
  fileAsm.writeAsStringSync(temp2);

}
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
      case "function":
        finaltemp+='''//function
        ''';
        funcname = str[i+1]+'''.'''+str[i+2];
        finaltemp += declarfunc(str[i+2],str[i+3],fileName.substring(0,fileName.length - 3));
        break;
      case "push":
        finaltemp +='''// push ''' + str[i+1] + str[i+2]+'''
        
''';
        finaltemp +=  push(str[i+1], str[i+2]);

        break;
      case "pop":
        finaltemp +='''// pop ''' + str[i+1] + str[i+2]+'''
        
''';
        finaltemp += pop(str[i+1], str[i+2],funcname);
      //  i+=2;
        break;
      case "add":
        finaltemp+='''//add
''';
       finaltemp += add('+');
        break;
      case "sub":
        finaltemp+='''//sub
''';
        finaltemp += sub('-');
        break;
      case "neg":
        finaltemp+='''//neg
''';
        finaltemp += negNot('-');
        break;
      case "not":
        finaltemp+='''//not
''';
        finaltemp +=negNot('!');
        break;
      case "and":
        finaltemp+='''//and
''';
        finaltemp +=  andOr('&');
        break;
      case "or":
        finaltemp+='''//or
''';
        finaltemp +=  andOr('|');
        break;
      case "gt":
        finaltemp+='''//gt
''';
     finaltemp += jump('JGT');
     break;
      case "lt":
        finaltemp+='''//lt
''';
        finaltemp += jumplt();
      break;
      case "eq":
        finaltemp+='''//eq
''';
        finaltemp +=  jump('JEQ');
      break;
      case "label":
        finaltemp+='''//label
''';
        finaltemp += labelfunc(fileName.substring(0,fileName.length - 3),str[i+1]);
        break;
      case "if":
        finaltemp+='''//ifgoto
''';
        finaltemp += ifgotofunc(fileName.substring(0,fileName.length - 3),str[i+2]);
        i+=2;
        break;
      case "goto":
        finaltemp+='''//goto
''';
        finaltemp += gotofunc(fileName.substring(0,fileName.length - 3), str[i+1]);
        break;
      case "call":
        finaltemp+='''//call
''';
        finaltemp += callfunc( str[i+1],str[i+2], fileName.substring(0,fileName.length - 3),str[i+3]);
        break;

      case "return":
        finaltemp+='''//return
''';
        finaltemp += returnhack;
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


String pop(String typeOfString, String value,String funcname){
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
      return popstatic(static1.toString(), value, funcname );
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
//void initlist()
//{
//  folder.list(recursive: true, followLinks: false).forEach( (file)  {
//
//
//    if( file.path.endsWith(".asm")){
//      directory.add(file.parent.path);
//      files.add(file.path);
//    }
//  });
//}
