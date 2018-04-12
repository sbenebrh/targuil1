import 'dart:io';

/**
 * name :addorsubop
 * params:operator
 * meanig: according to the operator it will transform to hack
 */
String add(String op)
{
  String finalstring = '''@SP
A=M-1
D=M
A=A-1
M=D'''+op+'''M
@SP
M=M-1

''';
  return finalstring;
}
String sub(String op)
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
D='''+op+'''M
M=D
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
@'''+op+'''_TRUE

D;'''+op+'''

@'''+op+'''_END
D=0;JMP
('''+op+'''_TRUE)
D=-1
('''+op+'''_END)
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
  return '''@'''+ value+'''
  
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
String pushtemp(String value){
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
}
popPointer(String op, String value){
  return  '''@SP
M=M-1
A=M
D=M
@''' +(int.parse(op)+int.parse(value)).toString() + '''

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

popTemp(String op, String value){
  return '''@'''+op+'''
      
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
}


//targuil 2
String gotofunc(String path, String label){
  return '''@''' +r"$"+ path + '''.'''+label +'''
  
0;JMP
''';
}

String ifgotofunc(String filename, String label){
  return '''@SP
M=M-1
A=M			
D=M
@''' +r"$"+ filename + '''.'''+label+'''
  
D;JNE
''';
  }
  String gotoHelper(String filename, String label){
  return '''@''' +r"$"+ filename + '''.'''+label;
  }
  String labelfunc(String filename, String label){
    return '''('''+r"$"+filename+'''.'''+label+''')
''';
  }