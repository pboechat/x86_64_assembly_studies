                        includelib          kernel32.lib
                        includelib          utils.lib
open_stdout             proto
write_string            proto
ExitProcess             proto
                        .code
main                    proc
                        sub                 rsp,40
                        call                open_stdout
                        mov                 rcx,offset message
                        mov                 rdx,lengthof message
                        call                write_string
                        add                 rsp,40
                        mov                 rcx,0
                        call                ExitProcess
main                    endp
                        .data
message                 byte                "hello world"
                        end
