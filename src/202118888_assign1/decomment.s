	.file	"decomment.c"
	.text
	.globl	current_line
	.data
	.align 4
	.type	current_line, @object
	.size	current_line, 4
current_line:
	.long	1
	.globl	comment_line
	.bss
	.align 4
	.type	comment_line, @object
	.size	comment_line, 4
comment_line:
	.zero	4
	.globl	quote_delim
	.align 4
	.type	quote_delim, @object
	.size	quote_delim, 4
quote_delim:
	.zero	4
	.section	.rodata
	.align 8
.LC0:
	.string	"Error: line %d: unterminated comment\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -8(%rbp)
	jmp	.L2
.L13:
	cmpl	$10, -4(%rbp)
	jne	.L3
	cmpl	$2, -8(%rbp)
	je	.L3
	cmpl	$3, -8(%rbp)
	je	.L3
	movl	current_line(%rip), %eax
	addl	$1, %eax
	movl	%eax, current_line(%rip)
.L3:
	cmpl	$6, -8(%rbp)
	ja	.L18
	movl	-8(%rbp), %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L6(%rip), %rax
	movl	(%rdx,%rax), %eax
	cltq
	leaq	.L6(%rip), %rdx
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L6:
	.long	.L12-.L6
	.long	.L11-.L6
	.long	.L10-.L6
	.long	.L9-.L6
	.long	.L8-.L6
	.long	.L7-.L6
	.long	.L5-.L6
	.text
.L12:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	handle_normal_state
	movl	%eax, -8(%rbp)
	jmp	.L2
.L11:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	handle_slash_state
	movl	%eax, -8(%rbp)
	jmp	.L2
.L10:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	handle_multi_state
	movl	%eax, -8(%rbp)
	jmp	.L2
.L9:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	handle_star_state
	movl	%eax, -8(%rbp)
	jmp	.L2
.L8:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	handle_single_state
	movl	%eax, -8(%rbp)
	jmp	.L2
.L7:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	handle_quote_state
	movl	%eax, -8(%rbp)
	jmp	.L2
.L5:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	$5, -8(%rbp)
	jmp	.L2
.L18:
	nop
.L2:
	call	getchar@PLT
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L13
	cmpl	$1, -8(%rbp)
	jne	.L14
	movl	$47, %edi
	call	putchar@PLT
.L14:
	cmpl	$2, -8(%rbp)
	je	.L15
	cmpl	$3, -8(%rbp)
	jne	.L16
.L15:
	movl	comment_line(%rip), %edx
	movq	stderr(%rip), %rax
	leaq	.LC0(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
	jmp	.L17
.L16:
	movl	$0, %eax
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	handle_normal_state
	.type	handle_normal_state, @function
handle_normal_state:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$47, -4(%rbp)
	jne	.L20
	movl	$1, %eax
	jmp	.L21
.L20:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	cmpl	$34, -4(%rbp)
	je	.L22
	cmpl	$39, -4(%rbp)
	jne	.L23
.L22:
	movl	-4(%rbp), %eax
	movl	%eax, quote_delim(%rip)
	movl	$5, %eax
	jmp	.L21
.L23:
	movl	$0, %eax
.L21:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	handle_normal_state, .-handle_normal_state
	.globl	handle_slash_state
	.type	handle_slash_state, @function
handle_slash_state:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$42, -4(%rbp)
	jne	.L25
	movl	$32, %edi
	call	putchar@PLT
	movl	current_line(%rip), %eax
	movl	%eax, comment_line(%rip)
	movl	$2, %eax
	jmp	.L26
.L25:
	cmpl	$47, -4(%rbp)
	jne	.L27
	movl	$32, %edi
	call	putchar@PLT
	movl	$4, %eax
	jmp	.L26
.L27:
	movl	$47, %edi
	call	putchar@PLT
	cmpl	$34, -4(%rbp)
	je	.L28
	cmpl	$39, -4(%rbp)
	jne	.L29
.L28:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	-4(%rbp), %eax
	movl	%eax, quote_delim(%rip)
	movl	$5, %eax
	jmp	.L26
.L29:
	cmpl	$47, -4(%rbp)
	jne	.L30
	movl	$1, %eax
	jmp	.L26
.L30:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	$0, %eax
.L26:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	handle_slash_state, .-handle_slash_state
	.globl	handle_multi_state
	.type	handle_multi_state, @function
handle_multi_state:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$42, -4(%rbp)
	jne	.L32
	movl	$3, %eax
	jmp	.L33
.L32:
	cmpl	$10, -4(%rbp)
	jne	.L34
	movl	$10, %edi
	call	putchar@PLT
	movl	current_line(%rip), %eax
	addl	$1, %eax
	movl	%eax, current_line(%rip)
.L34:
	movl	$2, %eax
.L33:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	handle_multi_state, .-handle_multi_state
	.globl	handle_star_state
	.type	handle_star_state, @function
handle_star_state:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$47, -4(%rbp)
	jne	.L36
	movl	$0, %eax
	jmp	.L37
.L36:
	cmpl	$42, -4(%rbp)
	jne	.L38
	movl	$3, %eax
	jmp	.L37
.L38:
	cmpl	$10, -4(%rbp)
	jne	.L39
	movl	$10, %edi
	call	putchar@PLT
	movl	current_line(%rip), %eax
	addl	$1, %eax
	movl	%eax, current_line(%rip)
	movl	$2, %eax
	jmp	.L37
.L39:
	movl	$2, %eax
.L37:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	handle_star_state, .-handle_star_state
	.globl	handle_single_state
	.type	handle_single_state, @function
handle_single_state:
.LFB5:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$10, -4(%rbp)
	jne	.L41
	movl	$10, %edi
	call	putchar@PLT
	movl	$0, %eax
	jmp	.L42
.L41:
	movl	$4, %eax
.L42:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	handle_single_state, .-handle_single_state
	.globl	handle_quote_state
	.type	handle_quote_state, @function
handle_quote_state:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	cmpl	$92, -4(%rbp)
	jne	.L44
	movl	$6, %eax
	jmp	.L45
.L44:
	movl	quote_delim(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jne	.L46
	movl	$0, %eax
	jmp	.L45
.L46:
	movl	$5, %eax
.L45:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	handle_quote_state, .-handle_quote_state
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.3) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
