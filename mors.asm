; multi-segment executable file template.

data segment
    ; add your data here!
 counter  dw 0 ; the message length
  text db 100 dup(0) "$" ; the messeage 
  cruser dw 0 ; the cruser help us place the paint (the x values)
  conmessage db "Please enter your message    $" ; this is the start massage
  endmess db "Press any key for convert again$"; this is convert again message
  filename db 'f.txt',0 ; the file name
  filehandle dw ? ; file handle
  filestring db 100 dup('$'),'$' ; the read from file string 
  incorrect_message db "File not found$"; file not found message
  hellouser db "hello user!$" ; hello user message
  chosemes db "please select your commend          $" ; chosing message
  options db "press on the numbers(keys) to read from file    else for translating to mors$" ; the translate option
  chosecheck db 0 ;if the costumer want translating it stay 0 if he want read from file it will change to 1

ends

stack segment
    dw   128  dup(0)
ends

code segment
proc longtone 
pusha
XOR CX,CX
ADD CX,4
loopoutlong: ;this loop made the sound long
xor SI,SI
add SI,0FFFFH
          
          outlong: ;this loop out the do tone
          in al, 61h
          or al, 00000011b
          out 61h, al
          mov al, 0B6h
          out 43h, al 
          mov al, 98h
          mov ax, 5641h
          out 42h, al ; Sending lower byte
          mov al, ah
          out 42h,al
          DEC SI 
          cmp SI,0
          jnz outlong
          LOOP loopoutlong
           

; close the speaker
in al, 61h
and al, 11111100b
out 61h, al
call drawline 
popa 
ret
endp longtone
;******************
;******************
;*****************
PROC SHORTTONE
  pusha
XOR CX,CX
ADD CX,2
loopoutshort: ;this loop made the sound short
xor SI,SI
add SI,0FFFFH
          
          outshort: ;this loop out the higer tone
          in al, 61h
          or al, 00000011b
          out 61h, al
          mov al, 0B6h
          out 43h, al 
          mov al, 98h
          mov ax, 880h
          out 42h, al ; Sending lower byte
          mov al, ah
          out 42h,al
          DEC SI 
          cmp SI,0
          jnz outshort
          LOOP loopoutshort
           

; close the speaker
in al, 61h
and al, 11111100b
out 61h, al
popa
call drawpoint 
ret
endp shorttone
;****************************
;****************************
;****************************
;****************************
proc readstring
  pusha
  xor ax,ax
  lea bx,text
 runloop: ;this loop will read the string
xor ah,ah  
inc ah
int 21h
cmp al,0dh
jz sof
cmp al,8
jz remove
mov [bx],al
inc bx
inc counter
jmp runloop
  
  remove:
  dec bx
  dec counter
  mov al,' '
  mov [bx],al
  call WriteNull
  jmp runloop
 sof:
 mov [bx],'$'
popa  
ret
endp readstring
;*************
;************
proc Aa
call shorttone
call wait1
call longtone
call wait2    
ret
endp Aa
;*************
;************
proc Bb
call longtone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait2    
ret
endp Bb
;*************
;************
proc Cc
call longtone
call wait1
call shorttone
call wait1
call longtone
call wait1
call shorttone
call wait2
ret
endp Cc
;***************
;***************
;***************
proc morsconvertor
pusha
lea si,text
mov cx,counter
converttext:
mov al,[si]
mov dl,al
xor ah,ah
add ah,2
int 21h
cmp al,'a'
jz Aa1
cmp al,'A'
jz Aa1
cmp al,'b'
jz Bb1
cmp al,'B'
jz Bb1
cmp al,'c'
jz Cc1
cmp al,'C'
jz Cc1
cmp al,'d'
jz Dd2
cmp al,'D'
jz Dd2
cmp al,'e'
jz Ee1
cmp al,'E'
jz Ee1
cmp al,'f'
jz Ff1
cmp al,'F'
jz Ff1
cmp al,'g'
jz Gg1
cmp al,'G'
jz Gg1
cmp al,'h'
jz Hh1
cmp al,'H'
jz Hh1
cmp al,'i'
jz Ii1
cmp al,'I'
jz Ii1
cmp al,'j'
jz Jj1
cmp al,'J'
jz Jj1
cmp al,'k'
jz Kk1
cmp al,'K'
jz Kk1
cmp al,'l'
jz Ll1
cmp al,'L'
jz Ll1
cmp al,'m'
jz Mmm
cmp al,'M'
jz Mmm
cmp al,'n'
jz Nn1
cmp al,'N'
jz Nn1
cmp al,'o'
jz Oo1
cmp al,'O'
jz Oo1
cmp al,'p'
jz Pp1
cmp al,'P'
jz Pp1
cmp al,'q'
jz Qq1
cmp al,'Q'
jz Qq1
cmp al,'r'
jz Rr1
cmp al,'R'
jz Rr1
cmp al,'s'
jz SignS1
cmp al,'S'
jz SignS1
cmp al,'t'
jz Tt1
cmp al,'T'
jz Tt1
cmp al,'u'
jz Uu1
cmp al,'U'
jz Uu1
cmp al,'v'
jz Vv1
cmp al,'V'
jz Vv1
cmp al,'w'
jz Ww1
cmp al,'W'
jz Ww1
cmp al,'x'
jz Xx1
cmp al,'X'
jz Xx1
cmp al,'y'
jz Yy1
cmp al,'Y'
jz Yy1
cmp al,'z'
jz Zz1
cmp al,'Z'
jz Zz1
cmp al,'0'
jz N02
cmp al,'1'
jz N12
cmp al,'2'
jz N22   
cmp al,'3'
jz N32
cmp al,'4'
jz N42
cmp al,'5'
jz N52   
cmp al,'6'
jz N62
cmp al,'7'
jz N72
cmp al,'8'
jz N82   
cmp al,'9' 
jz N92
cmp al,'.'
jz Ee1
cmp al,'-'
jz Tt1
cmp al,'$'
jz sof2                                     
JMP LOOP1


           Aa1:
           CALL Aa
           JMP loop1
           Bb1:
           call Bb
           jmp loop1
           Cc1:
           call Cc
           jmp loop1
           Dd2:
           call Dd1
           jmp loop1
           Ee1:
           call Ee
           jmp loop1
           Ff1:
           call Ff
           jmp loop1
           Gg1:
           call Gg
           jmp loop1
           Hh1:
           call Hh
           jmp loop1
           Ii1:
           call Ii
           jmp loop1
           Jj1:
           call Jj
           jmp loop1
           Kk1:
           call Kk
           jmp loop1
           Ll1:
           call Ll
           jmp loop1
           Mmm:
           call Mm
           jmp loop1
           Nn1:
           call Nn
           jmp loop1
           Oo1:
           call Oo
           jmp loop1
           Pp1:
           call Pp
           jmp loop1
           Qq1:
           call Qq
           jmp loop1
           Rr1:
           call Rr
           jmp loop1
           SignS1:
           call SignS
           jmp loop1
           Tt1:
           call Tt
           jmp loop1
           Uu1:
           call Uu
           jmp loop1
           Vv1:
           call Vv
           jmp loop1
           Ww1:
           call Ww
           jmp loop1
           Xx1:
           call Xx
           jmp loop1
           Yy1:
           call Yy
           jmp loop1
           Zz1:
           call Zz
           jmp loop1
           N02:
           call N0
           jmp loop1
           N12:
           call N1
           jmp loop1
           N22:
           call N2
           jmp loop1
           N32:
           call N3
           jmp loop1
           N42:
           call N4
           jmp loop1
           N52:
           call N5
           jmp loop1
           N62:
           call N6
           jmp loop1
           N72:
           call N7
           jmp loop1
           N82:
           call N8
           jmp loop1
           N92:
           call N9
           jmp loop1  
             
loop1:
inc si  
loop converttext 
sof2:
popa    
ret
endp morsconvertor
;*********************
;*********************
proc wait1 ;wait between tones
  pusha
  mov ah,86h
  xor cx,cx
  xor dx,dx
  add cx,1
  int 15h
  popa  
  ret
endp wait1
;**************
;**************
proc wait2 ;wait betwwen chars
  pusha
  mov ah,86h
  xor cx,cx
  xor dx,dx
  add cx,20
  int 15h
  add cruser,2
  popa  
  ret
endp wait2
;**************
;**************
proc Dd1
call longtone
call wait1
call shorttone
call wait1
call shorttone
call wait2
ret
endp Dd1
;**************
;**************
proc Ee
call shorttone
call wait2    
ret
endp Ee
;**************
;**************
proc Ff
call shorttone 
call wait1
call shorttone
call wait1
call longtone
call wait1
call shorttone
call wait2
    ret
endp Ff
;**************
;**************
proc Gg
call longtone
call wait1
call longtone
call wait1
call shorttone
call wait2    
ret
endp Gg
;**************
;**************
proc Hh
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait2     
ret
endp Hh
;*************
;************
proc Ii
call shorttone
call wait1
call shorttone
call wait2     
ret
endp Ii
;*************
;************
proc Jj
call shorttone
call wait1
call longtone
call wait1
call longtone
call wait1
call longtone
call wait2     
ret
endp Jj
;*************
;************
proc Kk
call longtone
call wait1
call shorttone
call wait1
call longtone
call wait2     
ret
endp Kk
;*************
;************
proc Ll
call shorttone
call wait1
call longtone
call wait1
call shorttone
call wait1
call shorttone
call wait2    
ret
endp Ll
;*************
;************
proc Mm
call longtone
call wait1
call longtone
call wait2     
ret
endp Mm
;*************
;************
proc Nn
call longtone
call wait1
call shorttone
call wait2        
ret
endp Nn
;***************
;***************
proc Oo
call longtone
call wait1
call longtone
call wait1
call longtone
call wait2    
ret
endp Oo
;***************
;***************
proc Pp
call shorttone
call wait1
call longtone
call wait1
call longtone
call wait1
call shorttone
call wait2    
ret
endp Pp
;***************
;***************
proc Qq
call longtone
call wait1
call longtone
call wait1
call shorttone
call wait1
call longtone
call wait2    
ret
endp Qq
;***************
;***************
proc Rr
call shorttone
call wait1
call longtone
call wait1
call shorttone
call wait2    
ret
endp Rr
;***************
;***************
proc SignS
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait2    
ret
endp SignS
;***************
;***************
proc Tt
call longtone
call wait2
ret
endp Tt
;***************
;***************
proc Uu
call shorttone
call wait1
call shorttone
call wait1
call longtone
call wait2
ret
endp Uu
;***************
;***************
proc Vv
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call longtone
call wait2    
 ret
endp Vv
;***************
;***************
proc Ww
call shorttone
call wait1
call longtone
call wait1
call longtone
call wait2    
ret
endp Ww
;***************
;***************
proc Xx
call longtone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call longtone
call wait2
ret
endp Xx
;***************
;***************
proc Yy
call longtone
call wait1
call shorttone
call wait1
call longtone
call wait1
call longtone
call wait2    
ret
endp Yy
;***********
;***********
proc Zz
call longtone
call wait1
call longtone
call wait1
call shorttone
call wait1
call shorttone
call wait2    
ret
endp Zz
;***********
;***********
proc N1
call shorttone
call wait1
call longtone
call wait1
call longtone
call wait1
call longtone
call wait1
call longtone
call wait2    
ret
endp N1
;***********
;***********
proc N2
call shorttone
call wait1
call shorttone
call wait1
call longtone
call wait1
call longtone
call wait1
call longtone
call wait2
ret
endp N2
;***********
;***********
proc N3
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call longtone
call wait1
call longtone
call wait2    
ret
endp N3
;***********
;***********
proc N4
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call longtone
call wait2    
ret
endp N4
;***********
;***********
proc N5
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait2    
ret
endp N5
;***********
;***********
proc N6
call longtone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait2    
ret
endp N6
;***********
;***********
proc N7
call longtone
call wait1
call longtone
call wait1
call shorttone
call wait1
call shorttone
call wait1
call shorttone
call wait2    
ret
endp N7
;***********
;***********
proc N8
call longtone
call wait1
call longtone
call wait1
call longtone
call wait1
call shorttone
call wait1
call shorttone
call wait2    
ret
endp N8
;***********
;***********
proc N9
call longtone
call wait1
call longtone
call wait1
call longtone
call wait1
call longtone
call wait1
call shorttone
call wait2    
ret
endp N9
;***********
;***********
proc N0
call longtone
call wait1
call longtone
call wait1
call longtone
call wait1
call longtone
call wait1
call longtone
call wait1
ret
endp N0
;*************
;************
proc drawline
pusha
   
mov bl,14
xor cx,cx
add cx,2
add cx,cruser
xor dx,dx 
add dx,80
xor ax,ax
add al,14
add ah,0ch
    line:
    inc cx
    int 10h
    dec bl
    cmp bl,0
    jnz line
add cruser,16
xor al,al
inc cx
int 10h
inc cx
int 10h
popa    
ret
endp drawline
;**************
;**************
proc setcruser
pusha
xor bh,bh
mov ah,2
add dl,6
add dh,6
int 10h
popa
ret
endp setcruser
;**************
;**************
proc drawpoint
pusha
xor ax,ax
xor cx,cx
add cx,2
xor dx,dx
add dx,80
add cx,cruser
add al,14
add ah,0ch
int 10h
xor al,al
inc cx
int 10h
inc cx
int 10h
add cruser,3
popa
ret
endp drawpoint
;**************
;*************
proc videomode
xor ax,ax
add al,13h
int 10h    
ret
endp videomode
;*****************
;*****************
proc WriteNull ; this function write null char
pusha
xor ax,ax
xor dx,dx
add ah,2
int 21h
popa
ret    
endp WriteNull
;**********************
;**********************
proc ipos ; this function restart the program
pusha
xor ax,ax
mov counter,ax
mov cruser,ax
add ax,'$'
xor dl,dl
lea bx, text
    iposmes: ; this loop rebuild a empty string
    cmp [bx],'$'
    jnz null
    jmp sofipos
          null: ;empty char in this place
          mov [bx],dl
          inc bx
sofipos:;the end of the function+set cruser postion
call videomode
xor ax,ax
add ah,2
xor dx,dx
int 10h       
popa
ret
endp ipos 
;***********************
;***********************
proc OpenFile ; this function opens file
pusha
xor ax,ax
add ah,3dh
lea dx,filename
int 21h  
jc open_error
mov filehandle,ax  
jmp ended
open_error:
   mov dx, offset incorrect_message
   mov ah, 9h
   int 21H
ended:
popa    
ret
endp OpenFile
;**************
;**************
proc readfromfile
pusha
xor ax,ax
xor bx,bx
xor cx,cx
xor dx,dx
add ah,3fh
mov bx,filehandle
add cx,100
lea dx, filestring
int 21h
popa
ret
endp readfromfile
;***************
;***************
proc filetotext
pusha
popa
lea bx,text
lea si,filestring
 copy:
 cmp [si],'$'
 jz sofcopy
 xor al,al
 mov al,[si]
 mov [bx],al
 inc si
 inc bx
 inc counter
 jmp copy
sofcopy:
mov [bx],'$'
inc counter     
ret
endp filetotext
;*******************
;*******************
proc CloseFile
mov ah,3Eh
mov bx,filehandle
int 21h
ret
endp CloseFile
;******************
;******************
proc startscreen
pusha
xor ax,ax
lea dx,hellouser
add ah,9
int 21h
xor dx,dx
xor ax,ax
add dh,7
add ah,2
int 10h
xor ax,ax
xor dx,dx
add ah,9
lea dx,chosemes
int 21h
xor dx,dx
xor ax,ax
add dh,9
add ah,2
int 10h
xor ah,ah
add ah,9
xor dx,dx
lea dx,options
int 21h
xor ax,ax
inc ah
int 21h
cmp al,'0'
jz file1
cmp al,'1'
jz file1
cmp al,'2'
jz file1
cmp al,'3'
jz file1
cmp al,'4'
jz file1
cmp al,'5'
jz file1
cmp al,'6'
jz file1
cmp al,'7'
jz file1
cmp al,'8'
jz file1
cmp al,'9'
jz file1
jmp sof23
   file1:
   inc chosecheck
   jmp sof23  
sof23:
popa
ret
endp startscreen
;****************
;****************


start: ;MAIN
;***************
;***************
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
run:
xor ax,ax
mov chosecheck,ah
call videomode
call startscreen
xor ax,ax
mov ah,chosecheck
cmp ah,1
jz file
call videomode
xor ax,ax
xor dx,dx
add ah,9
lea dx,conmessage
int 21h
call wait1
call wait1
mov cruser,0     
Call readstring
call morsconvertor
xor ah,ah
add ah,2
xor dx,dx
add dh,20
int 10h
xor ax,ax
xor dx,dx
lea dx,endmess
add ah,9
int 21h
xor ax,ax
add ah,8
int 21h
cmp al,27
call ipos
jmp run
file:
call videomode
call openfile
call readfromfile
call filetotext
call morsconvertor
call CloseFile
JMP RUN
 
 
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
