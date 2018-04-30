// push constant111        
@111  
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant333        
@333  
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant888        
@888  
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop static8        
@SP
  
M=M-1
@SP
A=M
D=M
@Sys.8  
M=D
// pop static3        
@SP
  
M=M-1
@SP
A=M
D=M
@Sys.3  
M=D
// pop static1        
@SP
  
M=M-1
@SP
A=M
D=M
@Sys.1  
M=D
// push static3        
@Sys.3  
  
D=M
@0
A=M
M=D
@0
M=M+1
// push static1        
@Sys.1  
  
D=M
@0
A=M
M=D
@0
M=M+1
//sub
@0
M=M-1
A=M
D=M
@0
A=M-1
M=M-D

// push static8        
@Sys.8  
  
D=M
@0
A=M
M=D
@0
M=M+1
//add
@SP
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1

