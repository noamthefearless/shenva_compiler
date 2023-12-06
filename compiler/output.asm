
include \masm32\include\irvine\Irvine32.inc
includelib \masm32\include\irvine\Irvine32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib


.code


print_number_signed PROC
	
	push ebp
	mov ebp, esp
	pushad
	
	mov edx, [ebp + 8]
	test edx, 80000000h
	js print_negative
	
	call writeDec
	jmp finish_print_num_signed_function
	print_negative:
	call writeInt
	
	finish_print_num_signed_function:
	popad
	mov esp, ebp
	pop ebp
	retn 4
print_number_signed  ENDP




main:
    push ebp
    mov ebp, esp

sub esp, 1
push 104
pop eax
mov byte ptr [ebp - 1], al
sub esp, 1
push 101
pop eax
mov byte ptr [ebp - 2], al
sub esp, 1
push 108
pop eax
mov byte ptr [ebp - 3], al
sub esp, 1
push 111
pop eax
mov byte ptr [ebp - 4], al
sub esp, 1
push 32
pop eax
mov byte ptr [ebp - 5], al
sub esp, 1
push 119
pop eax
mov byte ptr [ebp - 6], al
sub esp, 1
push 114
pop eax
mov byte ptr [ebp - 7], al
sub esp, 1
push 100
pop eax
mov byte ptr [ebp - 8], al
sub esp, 1
push 33
pop eax
mov byte ptr [ebp - 9], al
push [ebp - 1]
pop eax
call WriteChar
push [ebp - 2]
pop eax
call WriteChar
push [ebp - 3]
pop eax
call WriteChar
push [ebp - 3]
pop eax
call WriteChar
push [ebp - 4]
pop eax
call WriteChar
push [ebp - 5]
pop eax
call WriteChar
push [ebp - 6]
pop eax
call WriteChar
push [ebp - 4]
pop eax
call WriteChar
push [ebp - 7]
pop eax
call WriteChar
push [ebp - 3]
pop eax
call WriteChar
push [ebp - 8]
pop eax
call WriteChar
push [ebp - 9]
pop eax
call WriteChar

mov esp, ebp
pop ebp

invoke ExitProcess, 0
end main
