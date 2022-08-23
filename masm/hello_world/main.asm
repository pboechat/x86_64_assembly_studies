                    includelib      kernel32.lib
                    includelib      utils.lib
open_stdout         proto
write_string        proto
ExitProcess         proto
                    .code
main                proc
                    sub             RSP,40
                    call            open_stdout
                    lea             RCX,message
                    mov             RDX,lengthof message
                    call            write_string
                    add             RSP,40
                    mov             RCX,0
                    call            ExitProcess
main                endp
                    .data
message             byte            "hello world"
                    end
