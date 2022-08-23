                        includelib          kernel32.lib
                        includelib          utils.lib
open_stdout             proto
open_stdin              proto
write_string            proto
write_char              proto
write_char_ascii        proto
read_string             proto
ExitProcess             proto
print_string            macro               msg
                        lea                 RCX,msg
                        mov                 RDX,lengthof msg
                        call                write_string
                        endm
                        .code
main                    proc
                        sub                 RSP,40
                        call                open_stdout
                        call                open_stdin
begin_iter:              print_string        start_msg
                        lea                 RCX,user_input
                        mov                 RDX,lengthof user_input
                        call                read_string
                        mov                 read_string_length,RAX
                        lea                 R12,user_input
                        mov                 R13,read_string_length
                        sub                 R13,2
                        je                  end_iter
in_loop:                mov                 RCX,R12
                        call                write_char_ascii
                        print_string        tab
                        mov                 RCX,R12
                        call                write_char
                        print_string        new_line
                        inc                 R12
                        dec                 R13
                        jg                  in_loop
                        jp                  begin_iter
end_iter:               add                 RSP,40
                        mov                 RCX,0
                        call                ExitProcess
main                    endp
                        .data
read_string_length      qword               ?
start_msg               byte                "Please enter text message: "
user_input              byte                128 DUP(?)
new_line                byte                0DH,0AH
tab                     byte                09H
                        end