@17  
D=A
@SP
M=M+1
A=M-1
M=D
@17  
D=A
@SP
M=M+1
A=M-1
M=D
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
@SP
A=M
D=D-A
@LABEL1
D ; JEQ
@LABEL2
D=0 ; JEQ
(LABEL2)
D=-1
(LABEL1)
@SP
A=M
M=D
@SP
M=M+1

@892  
D=A
@SP
M=M+1
A=M-1
M=D
@891  
D=A
@SP
M=M+1
A=M-1
M=D
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
@SP
A=M
D=D-A
@LABEL1
D ; JLT
@LABEL2
D=0 ; JEQ
(LABEL1)
D=-1
(LABEL2)
@SP
A=M
M=D
@SP
M=M+1
@32767  
D=A
@SP
M=M+1
A=M-1
M=D
@32766  
D=A
@SP
M=M+1
A=M-1
M=D
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
@SP
A=M
D=D-A
@LABEL1
D ; JGT
@LABEL2
D=0 ; JEQ
(LABEL1)
D=-1
(LABEL2)
@SP
A=M
M=D
@SP
M=M+1
@56  
D=A
@SP
M=M+1
A=M-1
M=D
@31  
D=A
@SP
M=M+1
A=M-1
M=D
@53  
D=A
@SP
M=M+1
A=M-1
M=D
@SP
M=M-1
A=M
D=M
A=A-1
M=M+D
@112  
D=A
@SP
M=M+1
A=M-1
M=D
@SP
M=M-1
D=M
M=M-D
A=A-1
@SP
A=M
A=A-1
M=-M
@SP
M=M-1
A=M
D=M
A=A-1
M=M&D
@82  
D=A
@SP
M=M+1
A=M-1
M=D
@SP
M=M-1
A=M
D=M
A=A-1
M=M|D
