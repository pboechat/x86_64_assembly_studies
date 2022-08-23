                        includelib          kernel32.lib
                        includelib          utils.lib
open_stdout             proto
open_stdin              proto
write_string            proto
write_char              proto
write_char_bin          proto
read_string             proto
ExitProcess             proto
print_string            macro               msg
                        lea                 rcx,msg
                        mov                 rdx,lengthof msg
                        call                write_string
                        endm
                        .code
main                    proc
                        sub                 rsp,40
                        call                open_stdout
                        call                open_stdin
begin_iter:             print_string        start_msg
                        lea                 rcx,user_input
                        mov                 rdx,lengthof user_input
                        call                read_string
                        mov                 read_string_length,rax
                        lea                 r12,user_input
                        mov                 r13,read_string_length
                        sub                 r13,2
                        je                  end_iter
in_loop:                mov                 rcx,r12
                        call                write_char_bin
                        print_string        tab
                        mov                 rcx,r12
                        call                write_char
                        print_string        new_line
                        inc                 r12
                        dec                 r13
                        jg                  in_loop
                        jp                  begin_iter
end_iter:               add                 rsp,40
                        mov                 rcx,0
                        call                ExitProcess
main                    endp
                        .data
read_string_length      qword               ?
start_msg               byte                "Please enter text message: "
user_input              byte                128 dup(?)
new_line                byte                0dh,0ah
tab                     byte                09h
                        end