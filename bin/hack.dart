import 'dart:io';

/**
 * name :addorsubop
 * params:operator
 * meanig: according to the operator it will transform to hack
 */
String addOrSubop(String op)
{
  String finalstring = '''@SP
A=M-1
D=M
A=A-1
M=M'''+op+'''D
@SP
M=M-1

''';
  return finalstring;
}
/**
 * name :neg
 * meanig: give the neg of a number in hack
 */

String negNot(String op){
  return '''@SP
A=M-1
D=M
M='''+op+'''D
''';
}

String andOr(String op)
{
 return '''@SP
A=M-1
D=M
A=A-1
M=D'''+op+'''M
@SP
M=M-1
''';
}
String jump(String op)
{
  return '''@0
A=M-1
D=M
@0
M=M-1
A=M-1
D=M-D
@TRUE
D;'''+op+'''

@END
D=0;JMP
(TRUE)
D=-1
(END)
@0
A=M-1
M=D
''';}
String jumplt = '''@0
A=M-1
D=M
@0
M=M-1
A=M-1
D=D-M
@LT_TRUE
D;JGT
@LT_END
D=0;JMP
(LT_TRUE)
D=-1
(LT_END)
@0
A=M-1
M=D
''';
String pushconstant(String value){
  return '''@'''  + value + '''
  
D=A
@SP
A=M
M=D
@SP
M=M+1
''';
}
String pushlocalArg(String op,String value){
  return '''@ '''+ value+'''
  
D=A
@'''+op+'''
 
A=M
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
''';
}
String pophack(String op, String value)
{
  return  '''@'''+op+'''
      
D=M
@''' + value + '''

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
}
String pushPointer(String value){
  String temp ="";

  if (int.parse(value)==0)
    {temp = 'THIS';}
else
    {temp = 'THAT';}
  return '''@'''+temp+'''
  
D=M
@SP
M=M+1
A=M-1
M=D
  ''';
}