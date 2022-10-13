	.file	"lwp.c"
	.globl	curr
	.bss
	.align 8
	.type	curr, @object
	.size	curr, 8
curr:
	.zero	8
	.globl	root
	.align 8
	.type	root, @object
	.size	root, 8
root:
	.zero	8
	.globl	thread_id
	.align 8
	.type	thread_id, @object
	.size	thread_id, 8
thread_id:
	.zero	8
	.comm	original_stack,640,32
	.text
	.type	new_intel_stack64, @function
new_intel_stack64:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	subq	$8, -24(%rbp)
	movl	$lwp_exit, %edx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	subq	$8, -24(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	subq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	$0, (%rax)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	new_intel_stack64, .-new_intel_stack64
	.globl	lwp_create
	.type	lwp_create, @function
lwp_create:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$560, %rsp
	movq	%rdi, -536(%rbp)
	movq	%rsi, -544(%rbp)
	movq	%rdx, -552(%rbp)
	movl	$704, %edi
	call	malloc
	movq	%rax, -8(%rbp)
	movq	-552(%rbp), %rax
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 8(%rax)
	movq	-8(%rbp), %rax
	movq	-552(%rbp), %rdx
	movq	%rdx, 16(%rax)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	-552(%rbp), %rdx
	salq	$3, %rdx
	subq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 80(%rax)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	-552(%rbp), %rdx
	salq	$3, %rdx
	subq	$8, %rdx
	addq	%rax, %rdx
	movq	-536(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	new_intel_stack64
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 88(%rax)
	movq	-544(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 72(%rax)
	leaq	-528(%rbp), %rsi
	movl	$0, %eax
	movl	$64, %edx
	movq	%rsi, %rdi
	movq	%rdx, %rcx
	rep stosq
	movb	$127, -528(%rbp)
	movb	$3, -527(%rbp)
	movb	$-128, -504(%rbp)
	movb	$31, -503(%rbp)
	movb	$-1, -500(%rbp)
	movb	$-1, -499(%rbp)
	movb	$37, -352(%rbp)
	movb	$37, -351(%rbp)
	movb	$37, -350(%rbp)
	movb	$37, -349(%rbp)
	movb	$37, -348(%rbp)
	movb	$37, -347(%rbp)
	movb	$37, -346(%rbp)
	movb	$37, -345(%rbp)
	movb	$37, -344(%rbp)
	movb	$37, -343(%rbp)
	movb	$37, -342(%rbp)
	movb	$37, -341(%rbp)
	movb	$37, -340(%rbp)
	movb	$37, -339(%rbp)
	movb	$37, -338(%rbp)
	movb	$37, -337(%rbp)
	movb	$-1, -312(%rbp)
	movb	$-1, -307(%rbp)
	movq	-8(%rbp), %rax
	leaq	160(%rax), %rdi
	leaq	-528(%rbp), %rdx
	movl	$64, %eax
	movq	%rdx, %rsi
	movq	%rax, %rcx
	rep movsq
	movq	root(%rip), %rax
	testq	%rax, %rax
	jne	.L4
	movq	-8(%rbp), %rax
	movq	%rax, root(%rip)
	jmp	.L5
.L4:
	movq	curr(%rip), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 672(%rax)
	movq	curr(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 680(%rax)
.L5:
	movq	-8(%rbp), %rax
	movq	%rax, curr(%rip)
	movq	RoundRobin(%rip), %rax
	movq	16(%rax), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
	movq	thread_id(%rip), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, thread_id(%rip)
	movq	-8(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	lwp_create, .-lwp_create
	.globl	lwp_exit
	.type	lwp_exit, @function
lwp_exit:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	curr(%rip), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	curr(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	RoundRobin(%rip), %rax
	movq	24(%rax), %rax
	movq	curr(%rip), %rdx
	movq	%rdx, %rdi
	call	*%rax
	movq	RoundRobin(%rip), %rax
	movq	32(%rax), %rdx
	movl	$0, %eax
	call	*%rdx
	movq	%rax, curr(%rip)
	movq	curr(%rip), %rax
	testq	%rax, %rax
	jne	.L8
	movl	$original_stack, %esi
	movl	$0, %edi
	call	swap_rfiles
	jmp	.L7
.L8:
	movq	curr(%rip), %rax
	addq	$32, %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	swap_rfiles
.L7:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	lwp_exit, .-lwp_exit
	.globl	lwp_gettid
	.type	lwp_gettid, @function
lwp_gettid:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	curr(%rip), %rax
	testq	%rax, %rax
	jne	.L11
	movl	$0, %eax
	jmp	.L12
.L11:
	movq	curr(%rip), %rax
	movq	(%rax), %rax
.L12:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	lwp_gettid, .-lwp_gettid
	.globl	lwp_yield
	.type	lwp_yield, @function
lwp_yield:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	curr(%rip), %rax
	addq	$32, %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	swap_rfiles
	movq	RoundRobin(%rip), %rax
	movq	32(%rax), %rdx
	movl	$0, %eax
	call	*%rdx
	movq	%rax, curr(%rip)
	movq	curr(%rip), %rax
	testq	%rax, %rax
	jne	.L14
	movl	$original_stack, %esi
	movl	$0, %edi
	call	swap_rfiles
	jmp	.L13
.L14:
	movq	curr(%rip), %rax
	addq	$32, %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	swap_rfiles
.L13:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	lwp_yield, .-lwp_yield
	.globl	lwp_start
	.type	lwp_start, @function
lwp_start:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	root(%rip), %rax
	testq	%rax, %rax
	jne	.L17
	jmp	.L16
.L17:
	movl	$0, %esi
	movl	$original_stack, %edi
	call	swap_rfiles
	movq	RoundRobin(%rip), %rax
	movq	32(%rax), %rdx
	movl	$0, %eax
	call	*%rdx
	movq	%rax, curr(%rip)
	movq	curr(%rip), %rax
	testq	%rax, %rax
	jne	.L19
	movl	$original_stack, %esi
	movl	$0, %edi
	call	swap_rfiles
	jmp	.L16
.L19:
	movq	curr(%rip), %rax
	addq	$32, %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	swap_rfiles
.L16:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	lwp_start, .-lwp_start
	.globl	lwp_stop
	.type	lwp_stop, @function
lwp_stop:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	curr(%rip), %rax
	addq	$32, %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	swap_rfiles
	movl	$original_stack, %esi
	movl	$0, %edi
	call	swap_rfiles
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	lwp_stop, .-lwp_stop
	.globl	lwp_set_scheduler
	.type	lwp_set_scheduler, @function
lwp_set_scheduler:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L22
	jmp	.L21
.L22:
	movq	root(%rip), %rax
	movq	%rax, curr(%rip)
	movq	-8(%rbp), %rax
	movq	%rax, RoundRobin(%rip)
	jmp	.L24
.L25:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	curr(%rip), %rdx
	movq	%rdx, %rdi
	call	*%rax
	movq	curr(%rip), %rax
	movq	672(%rax), %rax
	movq	%rax, curr(%rip)
.L24:
	movq	curr(%rip), %rax
	testq	%rax, %rax
	jne	.L25
	nop
.L21:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	lwp_set_scheduler, .-lwp_set_scheduler
	.globl	lwp_get_scheduler
	.type	lwp_get_scheduler, @function
lwp_get_scheduler:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	RoundRobin(%rip), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	lwp_get_scheduler, .-lwp_get_scheduler
	.globl	tid2thread
	.type	tid2thread, @function
tid2thread:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	root(%rip), %rax
	movq	%rax, curr(%rip)
	jmp	.L29
.L32:
	movq	curr(%rip), %rax
	movq	(%rax), %rax
	cmpq	-8(%rbp), %rax
	jne	.L30
	movq	curr(%rip), %rax
	jmp	.L31
.L30:
	movq	curr(%rip), %rax
	movq	672(%rax), %rax
	movq	%rax, curr(%rip)
.L29:
	movq	curr(%rip), %rax
	testq	%rax, %rax
	jne	.L32
	movl	$0, %eax
.L31:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	tid2thread, .-tid2thread
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",@progbits
