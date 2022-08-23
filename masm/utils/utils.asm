                        includelib      kernel32.lib
GetStdHandle            proto
WriteConsoleA           proto
ReadConsoleA            proto
keyboard                equ             -10
console                 equ             -11
                        .code
;   Acquires stdout handle
;   Input: none
;   Output: none
;   Registers used: RCX, RAX
open_stdout             proc
                        mov             RCX,console
                        call            GetStdHandle
                        mov             stdout,RAX
                        ret
open_stdout             endp
;   Acquires stdin handle
;   Input: none
;   Output: none
;   Registers used: RCX, RAX
open_stdin              proc
                        mov             RCX,keyboard
                        call            GetStdHandle
                        mov             stdin,RAX
                        ret
open_stdin              endp
;   Writes a string to stdout
;   Input: RCX (buffer address), RDX (buffer length)
;   Output: RAX (number of bytes written)
;   Registers used: RCX, RDX, R8, R9 and RAX
write_string            proc
                        mov             R8,RDX                                      ; moves buffer length to R8
                        mov             RDX,RCX                                     ; moves buffer address to RDX
                        mov             RCX,stdout
                        lea             R9,num_bytes_written
                        call            WriteConsoleA
                        mov             RAX,num_bytes_read
                        ret
write_string            endp
;   Writes a char to stdout
;   Input: RCX (char address)
;   Output: RAX (number of bytes written)
;   Registers used: RCX, RDX, R8, R9 and RAX
write_char              proc
                        mov             RDX,1
                        call            write_string
                        ret
write_char              endp
;   Writes the ASCII code of a char to stdout
;   Input: RCX (char address)
;   Output: RAX (number of bytes written)
;   Registers used: RCX, RDX, R8, R9 and RAX
write_char_ascii        proc
                        push                RDI
                        mov                 DL,[RCX]
                        lea                 RDI,ascii_code_string
                        cld
                        movzx               AX,DL
                        mov                 CL,100
                        div                 CL
                        add                 AL,'0'
                        stosb
                        mov                 AL,AH
                        xor                 AH,AH
                        mov                 CL,10
                        div                 CL
                        add                 AL,'0'
                        stosb
                        mov                 AL,AH
                        add                 AL,'0'
                        stosb
                        lea                 RCX,ascii_code_string
                        mov                 RDX,lengthof ascii_code_string
                        call                write_string
                        pop                 RDI
                        ret
write_char_ascii        endp
;   Writes the binary equivalent of a char to stdout
;   Input: RCX (char address)
;   Output: RAX (number of bytes written)
;   Registers used: RCX, RDX, R8, R9 and RAX
write_char_bin          proc
                        push                RDI
                        mov                 DL,[RCX]
                        lea                 RDI,binary_string
                        cld
                        mov                 CL,7
write_char_bin_lp_1:    mov                 AL,DL
                        shr                 AL,CL
                        and                 AL,1
                        add                 AL,'0'
                        stosb
                        dec                 CL
                        jge                 write_char_bin_lp_1
                        lea                 RCX,binary_string
                        mov                 RDX,lengthof binary_string
                        call                write_string
                        pop                 RDI
                        ret
write_char_bin          endp
;   Reads a string from stdin
;   Input: RCX (buffer address), RDX (buffer length)
;   Output: RAX (number of bytes read)
;   Registers used: RCX, RDX, R8, R9 and RAX
read_string             proc
                        mov                 R8,RDX
                        mov                 RDX,RCX
                        mov                 RCX,stdin
                        lea                 R9,num_bytes_read
                        call                ReadConsoleA
                        mov                 RAX,num_bytes_read
                        ret
read_string             endp
                        .data
stdout                  qword           ?
stdin                   qword           ?
num_bytes_written       qword           ?
num_bytes_read          qword           ?
ascii_code_string       byte            3 DUP(?)
binary_string           byte            8 DUP(?)
                        end