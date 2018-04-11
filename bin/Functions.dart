import 'dart:io';
import 'hack.dart';


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
  String temp2 = hackTransformation(stringtemp);
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

String hackTransformation(List<String> str){
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
       finaltemp += addOrSubop('+');
        break;
      case "sub":
        finaltemp+= addOrSubop('-');
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
      return '''@'''  +value + '''
  
D=A
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
''';
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
      return  '''@SP
M=M-1
A=M
D=M
@''' +(pointer+int.parse(value)).toString() + '''

M=D
''';
      break;
    case "temp":
      return  '''@'''+temp.toString()+'''
      
D=A
@''' +value + '''

D=D+A
@13
M=D
@SP
M=M-1
A=M
D=M
@13
A=M
M=D
''';
      break;
    case "local":
      return '''@''' + lcl.toString() + '''

D=M
@''' +value + '''

D=D+A
@13
M=D
@SP
M=M-1
A=M
D=M
@13
A=M
M=D
''';
      break;
    case "argument":
      return '''@''' + arg.toString() + '''

 D=M
@''' +value + '''

D=D+A
@13
M=D
@SP
M=M-1
A=M
D=M
@13
A=M
M=D
''';

      break;
    case "static":

      return '''@''' + static1.toString() + '''

D=M
@''' +value + '''

D=D+A
@13
M=D
@SP
M=M-1
A=M
D=M
@13
A=M
M=D
''';
      break;
    case "this":
      return '''@''' + this1.toString() + '''

D=M
@''' +value + '''

D=D+A
@13
M=D
@SP
M=M-1
A=M
D=M
@13
A=M
M=D
''';
      break;
    case "that":
      return '''@''' + that.toString() + '''

D=M
@''' +value + '''

D=D+A
@13
M=D
@SP
M=M-1
A=M
D=M
@13
A=M
M=D
''';
      break;
  }
  return "";
}
