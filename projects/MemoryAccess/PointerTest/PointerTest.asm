// push constant3030        
@3030  
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer0        
@SP
M=M-1
A=M
D=M
@3
M=D
// push constant3040        
@3040  
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer1        
@SP
M=M-1
A=M
D=M
@4
M=D
// push constant32        
@32  
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop this2        
@3      
D=M
@2
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
// push constant46        
@46  
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop that6        
@4      
D=M
@6
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
// push pointer0        
@THIS  
D=M
@SP
M=M+1
A=M-1
M=D
  // push pointer1        
@THAT  
D=M
@SP
M=M+1
A=M-1
M=D
  //add
@SP
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1

// push this2        
@2  
D=A
@3 
A=M
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
//sub
@SP
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1

// push that6        
@6  
D=A
@4 
A=M
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
//add
@SP
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1

