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
@Sys.init.8  
M=D
// pop static3        
@SP
  
M=M-1
@SP
A=M
D=M
@Sys.init.3  
M=D
// pop static1        
@SP
  
M=M-1
@SP
A=M
D=M
@Sys.init.1  
M=D
// push static3        
@3  
D=A
@16 
A=M
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push static1        
@1  
D=A
@16 
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

// push static8        
@8  
D=A
@16 
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

