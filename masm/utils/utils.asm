                        includelib          kernel32.lib
GetStdHandle            proto
WriteConsoleA           proto
ReadConsoleA            proto
keyboard                equ                 -10
console                 equ                 -11
                        .code
;   Acquires stdout handle
;   Input: none
;   Output: none
;   Registers used: rcx, rax
open_stdout             proc
                        mov                 rcx,console
                        call                GetStdHandle
                        mov                 stdout,rax
                        ret
open_stdout             endp
;   Acquires stdin handle
;   Input: none
;   Output: none
;   Registers used: rcx, rax
open_stdin              proc
                        mov                 rcx,keyboard
                        call                GetStdHandle
                        mov                 stdin,rax
                        ret
open_stdin              endp
;   Writes a string to stdout
;   Input: rcx (buffer address), rdx (buffer length)
;   Output: rax (number of bytes written)
;   Registers used: rcx, rdx, r8, r9 and rax
write_string            proc
                        mov                 r8,rdx                                  ; moves buffer length to r8
                        mov                 rdx,rcx                                 ; moves buffer address to rdx
                        mov                 rcx,stdout
                        mov                 r9,offset num_bytes_written
                        call                WriteConsoleA
                        mov                 rax,num_bytes_read
                        ret
write_string            endp
;   Writes a char to stdout
;   Input: rcx (char address)
;   Output: rax (number of bytes written)
;   Registers used: rcx, rdx, r8, r9 and rax
write_char              proc
                        mov                 rdx,1
                        call                write_string
                        ret
write_char              endp
;   Writes the ASCII code of a char to stdout
;   Input: rcx (char address)
;   Output: rax (number of bytes written)
;   Registers used: rcx, rdx, r8, r9 and rax
write_char_ascii        proc
                        mov                 dl,[rcx]
                        movzx               ax,dl
                        mov                 cl,100
                        div                 cl
                        add                 al,'0'
                        mov                 [ascii_code_string],al
                        mov                 al,ah
                        xor                 ah,ah
                        mov                 cl,10
                        div                 cl
                        add                 al,'0'
                        mov                 [ascii_code_string+1],al
                        mov                 al,ah
                        add                 al,'0'
                        mov                 [ascii_code_string+2],al
                        mov                 rcx,offset ascii_code_string
                        mov                 rdx,lengthof ascii_code_string
                        call                write_string
                        ret
write_char_ascii        endp
;   Writes the binary equivalent of a char to stdout
;   Input: rcx (char address)
;   Output: rax (number of bytes written)
;   Registers used: rcx, rdx, r8, r9 and rax
write_char_bin          proc
                        push                rdi
                        mov                 dl,[rcx]
                        mov                 rdi,offset binary_string
                        cld
                        mov                 cl,7
write_char_bin_lp_1:    mov                 al,dl
                        shr                 al,cl
                        and                 al,1
                        add                 al,'0'
                        stosb
                        dec                 cl
                        jge                 write_char_bin_lp_1
                        mov                 rcx,offset binary_string
                        mov                 rdx,lengthof binary_string
                        call                write_string
                        pop                 rdi
                        ret
write_char_bin          endp
;   Writes the hex equivalent of a char to stdout
;   Input: rcx (char address)
;   Output: rax (number of bytes written)
;   Registers used: rcx, rdx, r8, r9 and rax
write_char_hex          proc
                        push                rbx
                        mov                 rbx,offset hex_char_table
                        mov                 al,[rcx]
                        shr                 al,4
                        xlat
                        mov                 [hex_string+2],al
                        mov                 al,[rcx]
                        and                 al,1111b
                        xlat
                        mov                 [hex_string+3],al
                        mov                 rcx,offset hex_string
                        mov                 rdx,lengthof hex_string
                        call                write_string
                        pop                 rbx
                        ret
write_char_hex          endp
;   Reads a string from stdin
;   Input: rcx (buffer address), rdx (buffer length)
;   Output: rax (number of bytes read)
;   Registers used: rcx, rdx, r8, r9 and rax
read_string             proc
                        mov                 r8,rdx
                        mov                 rdx,rcx
                        mov                 rcx,stdin
                        mov                 r9,offset num_bytes_read
                        call                ReadConsoleA
                        mov                 rax,num_bytes_read
                        ret
read_string             endp
                        .data
stdout                  qword               ?
stdin                   qword               ?
num_bytes_written       qword               ?
num_bytes_read          qword               ?
ascii_code_string       byte                3 dup(?)
hex_string              byte                '0','x',?,?
binary_string           byte                8 dup(?)
hex_char_table          byte                "0123456789ABCDEF"
                        end