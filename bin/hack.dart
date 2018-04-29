import 'dart:io';
int numhelp = 0;
/**
 * name :addorsubop
 * params:operator
 * meanig: according to the operator it will transform to hack
 */
String add(String op) {
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

String andOr(String op) {
 return '''@SP
A=M-1
D=M
A=A-1
M=D'''+op+'''M
@SP
M=M-1
''';
}

String jump(String op) {
  String retour =  '''@0
A=M-1
D=M
@0
M=M-1
A=M-1
D=M-D
@'''+op+'''_TRUE'''+numhelp.toString()+'''

D;'''+op+'''

@'''+op+'''_END
D=0;JMP
('''+op+'''_TRUE)
D=-1
('''+op+'''_END)
@0
A=M-1
M=D
''';
numhelp++;
return retour;}

String jumplt(){

String retour = '''@0
A=M-1
D=M
@0
M=M-1
A=M-1
D=D-M
@LT_TRUE'''+numhelp.toString()+'''

D;JGT
@LT_END'''+numhelp.toString()+'''

D=0;JMP
(LT_TRUE'''+numhelp.toString()+''')
D=-1
(LT_END'''+numhelp.toString()+''')
@0
A=M-1
M=D
''';
numhelp++;
return retour;}


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

String pophack(String op, String value) {
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
String popstatic(String op, String value, String functionname){
  return '''@SP
  
M=M-1
@SP
A=M
D=M
@''' + functionname+'''.'''+value+'''
  
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
  return '''@''' + path + '''.'''+label +'''
  
0;JMP
''';
}

String ifgotofunc(String filename, String label){
  return '''@SP
M=M-1
A=M			
D=M
@''' + filename + '''.'''+label+'''
  
D;JNE
''';
  }

String gotoHelper(String filename, String label){
  return '''@''' +r"$"+ filename + '''.'''+label;
  }

String labelfunc(String filename, String label){
    return '''('''+filename+'''.'''+label+''')
''';
  }

String callfunc(String str1, String str2,String path, String str3){
    String retour= returnAdress(path,numhelp.toString())+'''
    
'''
+ saveAdress('LCL') +'''

'''
+ saveAdress('ARG') +'''

'''
+ saveAdress('THIS') +'''

'''
+ saveAdress('THAT') +'''

@'''+str3+'''

D=A
@5
D=D+A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
'''
    + gotofunc(str1, str2) +'''
    
'''
+ labelfunc(path, "ReturnAddress"+numhelp.toString()) + '''
''';
numhelp++;
return retour;
}

String declarfunc(String str1, String str2, String filename){

  int str2int = int.parse(str2);
  String func=labelfunc(filename, str1);
    for(int i=1 ;i<=str2int;i++)
      func+='''
'''
        +pushconstant("0");
     return func  ;
}

String returnhack ='''
@LCL
D=M
@5
A=D-A
D=M
@R14
M=D
@SP
M=M-1
@0
D=A
@ARG
D=M+D
@R13
M=D
@SP
A=M
D=M
@R13
A=M
M=D
@ARG
D=M+1
@SP
M=D
@LCL
D=M
@1
A=D-A
D=M
@THAT
M=D
@LCL
D=M
@2
A=D-A
D=M
@THIS
M=D
@LCL
D=M
@3
A=D-A
D=M
@ARG
M=D
@LCL
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14
A=M
1 ; JMP


''';

String saveAdress(String str){
  return '''@'''+ str + '''
  
D=M
@SP
A=M
M=D
@SP
M=M+1
''';
}

String returnAdress(String str, String num) {
  return '''@'''+ str + '''.ReturnAddress'''+num+'''
  
D=A
@SP
A=M
M=D
@SP
M=M+1
''';
}
String inithack(){
  return '''@256
D=A
@SP
M=D
@return_1
D=A
@SP
M=M+1
A=M-1
M=D
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@0
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
@0
D=A
@5
D=D+A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.init
0;JMP
(return_1)
''';
  

}