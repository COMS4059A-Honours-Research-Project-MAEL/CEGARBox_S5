	.file	"ParseFormula.cpp"
	.text
	.section	.text._ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv,"axG",@progbits,_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv
	.type	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv, @function
_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv:
.LFB2396:
	.cfi_startproc
	endbr64
	ret
	.cfi_endproc
.LFE2396:
	.size	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv, .-_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv
	.section	.text._ZNKSt5ctypeIcE8do_widenEc,"axG",@progbits,_ZNKSt5ctypeIcE8do_widenEc,comdat
	.align 2
	.p2align 4
	.weak	_ZNKSt5ctypeIcE8do_widenEc
	.type	_ZNKSt5ctypeIcE8do_widenEc, @function
_ZNKSt5ctypeIcE8do_widenEc:
.LFB3706:
	.cfi_startproc
	endbr64
	movl	%esi, %eax
	ret
	.cfi_endproc
.LFE3706:
	.size	_ZNKSt5ctypeIcE8do_widenEc, .-_ZNKSt5ctypeIcE8do_widenEc
	.section	.text._ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv,"axG",@progbits,_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv
	.type	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv, @function
_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv:
.LFB4719:
	.cfi_startproc
	endbr64
	movq	(%rdi), %rax
	jmp	*8(%rax)
	.cfi_endproc
.LFE4719:
	.size	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv, .-_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv
	.section	.text.unlikely,"ax",@progbits
	.align 2
	.type	_ZNSt8__detail16_Hashtable_allocISaINS_10_Hash_nodeISt10shared_ptrI7FormulaELb1EEEEE18_M_deallocate_nodeEPS5_.constprop.0, @function
_ZNSt8__detail16_Hashtable_allocISaINS_10_Hash_nodeISt10shared_ptrI7FormulaELb1EEEEE18_M_deallocate_nodeEPS5_.constprop.0:
.LFB5017:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rdx
	.cfi_def_cfa_offset 32
	movq	16(%rdi), %rbp
	testq	%rbp, %rbp
	je	.L7
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L8
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
	jmp	.L9
.L8:
	orl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
.L9:
	decl	%eax
	jne	.L7
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	je	.L11
	movq	%rbp, %rdi
	call	*%rax
.L11:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L12
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
	jmp	.L13
.L12:
	orl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
.L13:
	decl	%eax
	jne	.L7
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L14
	call	*8(%rdx)
	jmp	.L7
.L14:
	call	*%rax
.L7:
	popq	%rax
	.cfi_def_cfa_offset 24
	movq	%r12, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$32, %esi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	_ZdlPvm@PLT
	.cfi_endproc
.LFE5017:
	.size	_ZNSt8__detail16_Hashtable_allocISaINS_10_Hash_nodeISt10shared_ptrI7FormulaELb1EEEEE18_M_deallocate_nodeEPS5_.constprop.0, .-_ZNSt8__detail16_Hashtable_allocISaINS_10_Hash_nodeISt10shared_ptrI7FormulaELb1EEEEE18_M_deallocate_nodeEPS5_.constprop.0
	.section	.text._ZNSt7__cxx119to_stringEm,"axG",@progbits,_ZNSt7__cxx119to_stringEm,comdat
	.p2align 4
	.weak	_ZNSt7__cxx119to_stringEm
	.type	_ZNSt7__cxx119to_stringEm, @function
_ZNSt7__cxx119to_stringEm:
.LFB3366:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	cmpq	$9, %rsi
	jbe	.L17
	cmpq	$99, %rsi
	jbe	.L33
	cmpq	$999, %rsi
	jbe	.L34
	cmpq	$9999, %rsi
	jbe	.L35
	movabsq	$3777893186295716171, %rdi
	movq	%rsi, %rdx
	movl	$1, %esi
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L38:
	cmpq	$999999, %rcx
	jbe	.L41
	cmpq	$9999999, %rcx
	jbe	.L42
	cmpq	$99999999, %rcx
	jbe	.L43
.L21:
	movq	%rdx, %rax
	movq	%rdx, %rcx
	mulq	%rdi
	movl	%esi, %eax
	addl	$4, %esi
	shrq	$11, %rdx
	cmpq	$99999, %rcx
	ja	.L38
.L26:
	leaq	16(%r12), %rax
	xorl	%edx, %edx
	movq	%r12, %rdi
	movq	%rax, (%r12)
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructEmc@PLT
	movl	8(%r12), %eax
	movq	(%r12), %rsi
	leal	-1(%rax), %ecx
.L32:
	leaq	_ZZNSt8__detail18__to_chars_10_implImEEvPcjT_E8__digits(%rip), %rdi
	movabsq	$2951479051793528259, %r8
	.p2align 4,,10
	.p2align 3
.L29:
	movq	%rbx, %rdx
	shrq	$2, %rdx
	movq	%rdx, %rax
	mulq	%r8
	movq	%rdx, %r9
	andq	$-4, %rdx
	shrq	$2, %r9
	addq	%r9, %rdx
	leaq	(%rdx,%rdx,4), %rax
	movq	%rbx, %rdx
	salq	$2, %rax
	subq	%rax, %rdx
	movq	%rbx, %rax
	movq	%r9, %rbx
	movl	%ecx, %r9d
	movzbl	1(%rdi,%rdx,2), %r10d
	movzbl	(%rdi,%rdx,2), %edx
	movb	%r10b, (%rsi,%r9)
	leal	-1(%rcx), %r9d
	subl	$2, %ecx
	movb	%dl, (%rsi,%r9)
	cmpq	$9999, %rax
	ja	.L29
	cmpq	$999, %rax
	ja	.L24
.L30:
	addl	$48, %ebx
	movq	%r12, %rax
	movb	%bl, (%rsi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L41:
	.cfi_restore_state
	leal	5(%rax), %esi
.L18:
	leaq	16(%r12), %rax
	movq	%r12, %rdi
	xorl	%edx, %edx
	movq	%rax, (%r12)
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructEmc@PLT
	movq	(%r12), %rsi
	leaq	_ZZNSt8__detail18__to_chars_10_implImEEvPcjT_E8__digits(%rip), %rdi
	cmpq	$99, %rbx
	ja	.L44
.L24:
	movzbl	1(%rdi,%rbx,2), %eax
	movzbl	(%rdi,%rbx,2), %ebx
	movb	%al, 1(%rsi)
	movq	%r12, %rax
	movb	%bl, (%rsi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L42:
	.cfi_restore_state
	leal	6(%rax), %esi
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L43:
	leal	7(%rax), %esi
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L44:
	movl	8(%r12), %eax
	leal	-1(%rax), %ecx
	jmp	.L32
.L17:
	leaq	16(%rdi), %rax
	movl	$1, %esi
	xorl	%edx, %edx
	movq	%rax, (%rdi)
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructEmc@PLT
	movq	(%r12), %rsi
	jmp	.L30
.L33:
	movl	$2, %esi
	jmp	.L18
.L35:
	movl	$4, %esi
	jmp	.L26
.L34:
	movl	$3, %esi
	jmp	.L26
	.cfi_endproc
.LFE3366:
	.size	_ZNSt7__cxx119to_stringEm, .-_ZNSt7__cxx119to_stringEm
	.text
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormulaD2Ev
	.type	_ZN12ParseFormulaD2Ev, @function
_ZN12ParseFormulaD2Ev:
.LFB4121:
	.cfi_startproc
	endbr64
	movq	(%rdi), %r8
	leaq	16(%rdi), %rax
	movq	$0, 32(%rdi)
	cmpq	%rax, %r8
	je	.L45
	movq	16(%rdi), %rsi
	movq	%r8, %rdi
	addq	$1, %rsi
	jmp	_ZdlPvm@PLT
	.p2align 4,,10
	.p2align 3
.L45:
	ret
	.cfi_endproc
.LFE4121:
	.size	_ZN12ParseFormulaD2Ev, .-_ZN12ParseFormulaD2Ev
	.globl	_ZN12ParseFormulaD1Ev
	.set	_ZN12ParseFormulaD1Ev,_ZN12ParseFormulaD2Ev
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula7getCharEv
	.type	_ZN12ParseFormula7getCharEv, @function
_ZN12ParseFormula7getCharEv:
.LFB4123:
	.cfi_startproc
	endbr64
	movq	32(%rdi), %rcx
	movq	40(%rdi), %rdx
	movl	$37, %eax
	cmpq	8(%rcx), %rdx
	jnb	.L47
	movq	(%rcx), %rax
	movzbl	(%rax,%rdx), %eax
.L47:
	ret
	.cfi_endproc
.LFE4123:
	.size	_ZN12ParseFormula7getCharEv, .-_ZN12ParseFormula7getCharEv
	.section	.text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_,"axG",@progbits,_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_,comdat
	.p2align 4
	.weak	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
	.type	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_, @function
_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_:
.LFB4429:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movq	%rsi, %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	call	strlen@PLT
	movq	%r13, %rcx
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%rax, %r8
	movq	%rbp, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm@PLT
	leaq	16(%r12), %rdx
	movq	%rdx, (%r12)
	movq	(%rax), %rcx
	leaq	16(%rax), %rdx
	cmpq	%rdx, %rcx
	je	.L54
	movq	%rcx, (%r12)
	movq	16(%rax), %rcx
	movq	%rcx, 16(%r12)
.L52:
	movq	8(%rax), %rcx
	movq	%rdx, (%rax)
	movq	$0, 8(%rax)
	movq	%rcx, 8(%r12)
	movb	$0, 16(%rax)
	movq	%r12, %rax
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L54:
	.cfi_restore_state
	movdqu	16(%rax), %xmm0
	movups	%xmm0, 16(%r12)
	jmp	.L52
	.cfi_endproc
.LFE4429:
	.size	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_, .-_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
	.section	.rodata._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_.str1.1,"aMS",@progbits,1
.LC0:
	.string	"basic_string::append"
	.section	.text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_,"axG",@progbits,_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_,comdat
	.p2align 4
	.weak	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
	.type	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_, @function
_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_:
.LFB4466:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movq	%rdx, %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	call	strlen@PLT
	movq	%rax, %rdx
	movabsq	$4611686018427387903, %rax
	subq	8(%rbp), %rax
	cmpq	%rax, %rdx
	ja	.L60
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_appendEPKcm@PLT
	leaq	16(%r12), %rdx
	movq	%rdx, (%r12)
	movq	(%rax), %rcx
	leaq	16(%rax), %rdx
	cmpq	%rdx, %rcx
	je	.L61
	movq	%rcx, (%r12)
	movq	16(%rax), %rcx
	movq	%rcx, 16(%r12)
.L58:
	movq	8(%rax), %rcx
	movq	%rdx, (%rax)
	movq	$0, 8(%rax)
	movq	%rcx, 8(%r12)
	movb	$0, 16(%rax)
	movq	%r12, %rax
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L61:
	.cfi_restore_state
	movdqu	16(%rax), %xmm0
	movups	%xmm0, 16(%r12)
	jmp	.L58
.L60:
	leaq	.LC0(%rip), %rdi
	call	_ZSt20__throw_length_errorPKc@PLT
	.cfi_endproc
.LFE4466:
	.size	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_, .-_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
	.section	.text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_,"axG",@progbits,_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_,comdat
	.p2align 4
	.weak	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_
	.type	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_, @function
_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_:
.LFB4467:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	movq	%rsi, %rdi
	movq	8(%rsi), %rsi
	movsbl	%dl, %r8d
	movl	$1, %ecx
	xorl	%edx, %edx
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE14_M_replace_auxEmmmc@PLT
	leaq	16(%r12), %rdx
	movq	%rdx, (%r12)
	movq	(%rax), %rcx
	leaq	16(%rax), %rdx
	cmpq	%rdx, %rcx
	je	.L66
	movq	%rcx, (%r12)
	movq	16(%rax), %rcx
	movq	%rcx, 16(%r12)
.L64:
	movq	8(%rax), %rcx
	movq	%rdx, (%rax)
	movq	$0, 8(%rax)
	movq	%rcx, 8(%r12)
	movb	$0, 16(%rax)
	movq	%r12, %rax
	popq	%r12
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L66:
	.cfi_restore_state
	movdqu	16(%rax), %xmm0
	movups	%xmm0, 16(%r12)
	jmp	.L64
	.cfi_endproc
.LFE4467:
	.size	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_, .-_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED2Ev,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED2Ev
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED2Ev, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED2Ev:
.LFB4505:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	16(%rdi), %rbx
	testq	%rbx, %rbx
	je	.L68
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %r14
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %r15
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L70:
	movl	$32, %esi
	movq	%r12, %rdi
	call	_ZdlPvm@PLT
	testq	%rbx, %rbx
	je	.L68
.L78:
	movq	%rbx, %r12
	movq	(%rbx), %rbx
	movq	16(%r12), %rbp
	testq	%rbp, %rbp
	je	.L70
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L71
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L72:
	cmpl	$1, %eax
	jne	.L70
	movq	0(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%r14, %rax
	jne	.L85
.L74:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L75
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L76:
	cmpl	$1, %eax
	jne	.L70
	movq	0(%rbp), %rax
	movq	%rbp, %rdi
	movq	24(%rax), %rdx
	cmpq	%r15, %rdx
	jne	.L77
	call	*8(%rax)
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L71:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L72
	.p2align 4,,10
	.p2align 3
.L68:
	movq	8(%r13), %rax
	movq	0(%r13), %rdi
	xorl	%esi, %esi
	addq	$48, %r13
	leaq	0(,%rax,8), %rdx
	call	memset@PLT
	movq	-48(%r13), %rdi
	movq	-40(%r13), %rsi
	movq	$0, -24(%r13)
	movq	$0, -32(%r13)
	cmpq	%r13, %rdi
	je	.L67
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	salq	$3, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	_ZdlPvm@PLT
	.p2align 4,,10
	.p2align 3
.L75:
	.cfi_restore_state
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L85:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L74
	.p2align 4,,10
	.p2align 3
.L77:
	call	*%rdx
	jmp	.L70
	.p2align 4,,10
	.p2align 3
.L67:
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4505:
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED2Ev, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED2Ev
	.weak	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	.set	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED2Ev
	.section	.text.unlikely
	.align 2
.LCOLDB1:
	.text
.LHOTB1:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
	.type	_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE, @function
_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE:
.LFB4118:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4118
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$552, %rsp
	.cfi_def_cfa_offset 608
	movq	%fs:40, %rax
	movq	%rax, 536(%rsp)
	xorl	%eax, %eax
	leaq	16(%rdi), %rax
	movb	$0, 16(%rdi)
	leaq	16(%rsp), %r14
	movq	%rax, (%rdi)
	leaq	272(%rsp), %r15
	movq	$0, 8(%rdi)
	movq	$0, 40(%rdi)
	movq	%r15, %rdi
	movq	%rax, 8(%rsp)
	call	_ZNSt8ios_baseC2Ev@PLT
	movq	8+_ZTTSt14basic_ifstreamIcSt11char_traitsIcEE(%rip), %rbp
	pxor	%xmm0, %xmm0
	xorl	%esi, %esi
	leaq	16+_ZTVSt9basic_iosIcSt11char_traitsIcEE(%rip), %rax
	movups	%xmm0, 504(%rsp)
	movq	16+_ZTTSt14basic_ifstreamIcSt11char_traitsIcEE(%rip), %rcx
	movq	%rax, 272(%rsp)
	xorl	%eax, %eax
	movw	%ax, 496(%rsp)
	movups	%xmm0, 520(%rsp)
	movq	-24(%rbp), %rax
	movq	$0, 488(%rsp)
	movq	%rbp, 16(%rsp)
	movq	%rcx, 16(%rsp,%rax)
	movq	$0, 24(%rsp)
	movq	-24(%rbp), %rdi
	addq	%r14, %rdi
.LEHB0:
	call	_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E@PLT
.LEHE0:
	leaq	24+_ZTVSt14basic_ifstreamIcSt11char_traitsIcEE(%rip), %rax
	leaq	32(%rsp), %r12
	movq	%rax, 16(%rsp)
	movq	%r12, %rdi
	addq	$40, %rax
	movq	%rax, 272(%rsp)
.LEHB1:
	call	_ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev@PLT
.LEHE1:
	movq	%r12, %rsi
	movq	%r15, %rdi
.LEHB2:
	call	_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E@PLT
	movq	0(%r13), %rsi
	movl	$8, %edx
	movq	%r12, %rdi
	call	_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode@PLT
	movq	16(%rsp), %rdx
	movq	-24(%rdx), %rdi
	addq	%r14, %rdi
	testq	%rax, %rax
	je	.L112
	xorl	%esi, %esi
	call	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT
.LEHE2:
.L88:
	movq	16(%rsp), %rax
	movq	-24(%rax), %rax
	movq	256(%rsp,%rax), %r13
	testq	%r13, %r13
	je	.L113
	cmpb	$0, 56(%r13)
	je	.L95
	movsbl	67(%r13), %edx
.L96:
	movq	%rbx, %rsi
	movq	%r14, %rdi
.LEHB3:
	call	_ZSt7getlineIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RNSt7__cxx1112basic_stringIS4_S5_T1_EES4_@PLT
	movq	%rbx, 32(%rbx)
	movq	%r12, %rdi
	call	_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv@PLT
.LEHE3:
	testq	%rax, %rax
	je	.L114
.L97:
	leaq	24+_ZTVSt14basic_ifstreamIcSt11char_traitsIcEE(%rip), %rax
	movq	%r12, %rdi
	movq	%rax, 16(%rsp)
	addq	$40, %rax
	movq	%rax, 272(%rsp)
	leaq	16+_ZTVSt13basic_filebufIcSt11char_traitsIcEE(%rip), %rax
	movq	%rax, 32(%rsp)
.LEHB4:
	call	_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv@PLT
.LEHE4:
.L99:
	leaq	136(%rsp), %rdi
	call	_ZNSt12__basic_fileIcED1Ev@PLT
	leaq	16+_ZTVSt15basic_streambufIcSt11char_traitsIcEE(%rip), %rax
	leaq	88(%rsp), %rdi
	movq	%rax, 32(%rsp)
	call	_ZNSt6localeD1Ev@PLT
	movq	-24(%rbp), %rax
	movq	%rbp, 16(%rsp)
	movq	%r15, %rdi
	movq	16+_ZTTSt14basic_ifstreamIcSt11char_traitsIcEE(%rip), %rcx
	movq	%rcx, 16(%rsp,%rax)
	leaq	16+_ZTVSt9basic_iosIcSt11char_traitsIcEE(%rip), %rax
	movq	%rax, 272(%rsp)
	movq	$0, 24(%rsp)
	call	_ZNSt8ios_baseD2Ev@PLT
	movq	536(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L115
	addq	$552, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L95:
	.cfi_restore_state
	movq	%r13, %rdi
.LEHB5:
	call	_ZNKSt5ctypeIcE13_M_widen_initEv@PLT
	movq	0(%r13), %rax
	leaq	_ZNKSt5ctypeIcE8do_widenEc(%rip), %rcx
	movl	$10, %edx
	movq	48(%rax), %rax
	cmpq	%rcx, %rax
	je	.L96
	movl	$10, %esi
	movq	%r13, %rdi
	call	*%rax
.LEHE5:
	movsbl	%al, %edx
	jmp	.L96
	.p2align 4,,10
	.p2align 3
.L112:
	movl	32(%rdi), %esi
	orl	$4, %esi
.LEHB6:
	call	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT
.LEHE6:
	jmp	.L88
	.p2align 4,,10
	.p2align 3
.L114:
	movq	16(%rsp), %rax
	movq	-24(%rax), %rdi
	addq	%r14, %rdi
	movl	32(%rdi), %esi
	orl	$4, %esi
.LEHB7:
	call	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT
	jmp	.L97
.L115:
	call	__stack_chk_fail@PLT
.L113:
	call	_ZSt16__throw_bad_castv@PLT
.LEHE7:
.L107:
	endbr64
	movq	%rax, %r13
	jmp	.L91
.L104:
	endbr64
	movq	%rax, %rbp
	jmp	.L100
.L106:
	endbr64
	movq	%rax, %r13
	jmp	.L92
.L108:
	endbr64
	movq	%rax, %rdi
	jmp	.L98
.L105:
	endbr64
	movq	%rax, %rbp
	jmp	.L93
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
	.align 4
.LLSDA4118:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT4118-.LLSDATTD4118
.LLSDATTD4118:
	.byte	0x1
	.uleb128 .LLSDACSE4118-.LLSDACSB4118
.LLSDACSB4118:
	.uleb128 .LEHB0-.LFB4118
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L105-.LFB4118
	.uleb128 0
	.uleb128 .LEHB1-.LFB4118
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L106-.LFB4118
	.uleb128 0
	.uleb128 .LEHB2-.LFB4118
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L107-.LFB4118
	.uleb128 0
	.uleb128 .LEHB3-.LFB4118
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L104-.LFB4118
	.uleb128 0
	.uleb128 .LEHB4-.LFB4118
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L108-.LFB4118
	.uleb128 0x1
	.uleb128 .LEHB5-.LFB4118
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L104-.LFB4118
	.uleb128 0
	.uleb128 .LEHB6-.LFB4118
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L107-.LFB4118
	.uleb128 0
	.uleb128 .LEHB7-.LFB4118
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L104-.LFB4118
	.uleb128 0
.LLSDACSE4118:
	.byte	0x1
	.byte	0
	.align 4
	.long	0

.LLSDATT4118:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4118
	.type	_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE.cold, @function
_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE.cold:
.LFSB4118:
.L91:
	.cfi_def_cfa_offset 608
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%r12, %rdi
	call	_ZNSt13basic_filebufIcSt11char_traitsIcEED1Ev@PLT
.L92:
	movq	-24(%rbp), %rax
	movq	16+_ZTTSt14basic_ifstreamIcSt11char_traitsIcEE(%rip), %rcx
	movq	%rbp, 16(%rsp)
	movq	%r13, %rbp
	movq	%rcx, 16(%rsp,%rax)
	movq	$0, 24(%rsp)
.L93:
	leaq	16+_ZTVSt9basic_iosIcSt11char_traitsIcEE(%rip), %rax
	movq	%r15, %rdi
	movq	%rax, 272(%rsp)
	call	_ZNSt8ios_baseD2Ev@PLT
.L94:
	movq	(%rbx), %rdi
	cmpq	%rdi, 8(%rsp)
	je	.L101
	movq	16(%rbx), %rsi
	addq	$1, %rsi
	call	_ZdlPvm@PLT
.L101:
	movq	%rbp, %rdi
.LEHB8:
	call	_Unwind_Resume@PLT
.LEHE8:
.L100:
	movq	%r14, %rdi
	call	_ZNSt14basic_ifstreamIcSt11char_traitsIcEED1Ev@PLT
	jmp	.L94
.L98:
	call	__cxa_begin_catch@PLT
	call	__cxa_end_catch@PLT
	jmp	.L99
	.cfi_endproc
.LFE4118:
	.section	.gcc_except_table
	.align 4
.LLSDAC4118:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC4118-.LLSDATTDC4118
.LLSDATTDC4118:
	.byte	0x1
	.uleb128 .LLSDACSEC4118-.LLSDACSBC4118
.LLSDACSBC4118:
	.uleb128 .LEHB8-.LCOLDB1
	.uleb128 .LEHE8-.LEHB8
	.uleb128 0
	.uleb128 0
.LLSDACSEC4118:
	.byte	0x1
	.byte	0
	.align 4
	.long	0

.LLSDATTC4118:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE, .-_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
	.section	.text.unlikely
	.size	_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE.cold, .-_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE.cold
.LCOLDE1:
	.text
.LHOTE1:
	.globl	_ZN12ParseFormulaC1EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
	.set	_ZN12ParseFormulaC1EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE,_ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
	.section	.text._ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv,"axG",@progbits,_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	.type	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv, @function
_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv:
.LFB4618:
	.cfi_startproc
	endbr64
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L117
	movl	8(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rdi)
.L118:
	cmpl	$1, %eax
	je	.L130
	ret
	.p2align 4,,10
	.p2align 3
.L130:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	(%rdi), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L131
.L121:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L122
	movl	12(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rdi)
.L123:
	cmpl	$1, %eax
	je	.L132
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L117:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rdi)
	jmp	.L118
	.p2align 4,,10
	.p2align 3
.L132:
	.cfi_def_cfa_offset 32
	movq	(%rdi), %rax
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	24(%rax), %rdx
	cmpq	%rcx, %rdx
	jne	.L125
	movq	8(%rax), %rax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	*%rax
	.p2align 4,,10
	.p2align 3
.L122:
	.cfi_restore_state
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rdi)
	jmp	.L123
	.p2align 4,,10
	.p2align 3
.L131:
	movq	%rdi, 8(%rsp)
	call	*%rax
	movq	8(%rsp), %rdi
	jmp	.L121
	.p2align 4,,10
	.p2align 3
.L125:
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	jmp	*%rdx
	.cfi_endproc
.LFE4618:
	.size	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv, .-_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv:
.LFB4648:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	16(%rdi), %rbx
	testq	%rbx, %rbx
	je	.L134
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %r14
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %r15
	jmp	.L144
	.p2align 4,,10
	.p2align 3
.L136:
	movl	$32, %esi
	movq	%r12, %rdi
	call	_ZdlPvm@PLT
	testq	%rbx, %rbx
	je	.L134
.L144:
	movq	%rbx, %r12
	movq	(%rbx), %rbx
	movq	16(%r12), %rbp
	testq	%rbp, %rbp
	je	.L136
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L137
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L138:
	cmpl	$1, %eax
	jne	.L136
	movq	0(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%r14, %rax
	jne	.L150
.L140:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L141
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L142:
	cmpl	$1, %eax
	jne	.L136
	movq	0(%rbp), %rax
	movq	%rbp, %rdi
	movq	24(%rax), %rdx
	cmpq	%r15, %rdx
	jne	.L143
	call	*8(%rax)
	jmp	.L136
	.p2align 4,,10
	.p2align 3
.L137:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L138
	.p2align 4,,10
	.p2align 3
.L134:
	movq	8(%r13), %rax
	movq	0(%r13), %rdi
	xorl	%esi, %esi
	leaq	0(,%rax,8), %rdx
	call	memset@PLT
	movq	$0, 24(%r13)
	movq	$0, 16(%r13)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L141:
	.cfi_restore_state
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L142
	.p2align 4,,10
	.p2align 3
.L150:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L140
	.p2align 4,,10
	.p2align 3
.L143:
	call	*%rdx
	jmp	.L136
	.cfi_endproc
.LFE4648:
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv
	.section	.text.unlikely
	.align 2
.LCOLDB2:
	.text
.LHOTB2:
	.align 2
	.p2align 4
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0:
.LFB5023:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA5023
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	xorl	%r13d, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	cmpq	$0, (%rdi)
	je	.L191
.L152:
	movq	16(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L151
	movl	$32, %edi
.LEHB9:
	call	_Znwm@PLT
	movq	$0, (%rax)
	movq	%rax, %r12
	movq	8(%rbx), %rax
	movq	%rax, 8(%r12)
	movq	16(%rbx), %rax
	movq	%rax, 16(%r12)
	testq	%rax, %rax
	je	.L158
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L159
	addl	$1, 8(%rax)
.L158:
	movq	24(%rbx), %rax
	xorl	%edx, %edx
	leaq	16(%rbp), %rcx
	movq	%r12, 16(%rbp)
	movq	%rax, 24(%r12)
	divq	8(%rbp)
	movq	0(%rbp), %rax
	movq	%rcx, (%rax,%rdx,8)
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L164
	jmp	.L151
	.p2align 4,,10
	.p2align 3
.L162:
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L151
.L163:
	movq	%rcx, %r12
.L164:
	movl	$32, %edi
	call	_Znwm@PLT
.LEHE9:
	movq	$0, (%rax)
	movq	%rax, %rcx
	movq	8(%rbx), %rax
	movq	%rax, 8(%rcx)
	movq	16(%rbx), %rax
	movq	%rax, 16(%rcx)
	testq	%rax, %rax
	je	.L160
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L161
	addl	$1, 8(%rax)
.L160:
	movq	24(%rbx), %rax
	xorl	%edx, %edx
	movq	%rcx, (%r12)
	movq	%rax, 24(%rcx)
	divq	8(%rbp)
	movq	0(%rbp), %rax
	leaq	(%rax,%rdx,8), %rax
	cmpq	$0, (%rax)
	jne	.L162
	movq	%r12, (%rax)
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L163
.L151:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L161:
	.cfi_restore_state
	lock addl	$1, 8(%rax)
	jmp	.L160
	.p2align 4,,10
	.p2align 3
.L191:
	movq	8(%rdi), %rdx
	cmpq	$1, %rdx
	je	.L192
	movq	%rdx, %rax
	shrq	$60, %rax
	jne	.L193
	leaq	0(,%rdx,8), %r12
	movq	%r12, %rdi
.LEHB10:
	call	_Znwm@PLT
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%rax, %rdi
	movq	%rax, %r13
	call	memset@PLT
.L154:
	movq	%r13, 0(%rbp)
	jmp	.L152
	.p2align 4,,10
	.p2align 3
.L159:
	lock addl	$1, 8(%rax)
	jmp	.L158
.L192:
	movq	$0, 48(%rdi)
	leaq	48(%rdi), %r13
	jmp	.L154
.L193:
	shrq	$61, %rdx
	je	.L156
	call	_ZSt28__throw_bad_array_new_lengthv@PLT
.L156:
	call	_ZSt17__throw_bad_allocv@PLT
.LEHE10:
.L170:
	endbr64
	movq	%rax, %rdi
	jmp	.L165
	.section	.gcc_except_table
	.align 4
.LLSDA5023:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT5023-.LLSDATTD5023
.LLSDATTD5023:
	.byte	0x1
	.uleb128 .LLSDACSE5023-.LLSDACSB5023
.LLSDACSB5023:
	.uleb128 .LEHB9-.LFB5023
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L170-.LFB5023
	.uleb128 0x1
	.uleb128 .LEHB10-.LFB5023
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
.LLSDACSE5023:
	.byte	0x1
	.byte	0
	.align 4
	.long	0

.LLSDATT5023:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC5023
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0.cold, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0.cold:
.LFSB5023:
.L165:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	__cxa_begin_catch@PLT
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv
	testq	%r13, %r13
	je	.L166
	movq	0(%rbp), %rdi
	movq	8(%rbp), %rsi
	addq	$48, %rbp
	cmpq	%rbp, %rdi
	jne	.L194
.L166:
.LEHB11:
	call	__cxa_rethrow@PLT
.LEHE11:
.L194:
	salq	$3, %rsi
	call	_ZdlPvm@PLT
	jmp	.L166
.L169:
	endbr64
	movq	%rax, %rbp
	call	__cxa_end_catch@PLT
	movq	%rbp, %rdi
.LEHB12:
	call	_Unwind_Resume@PLT
.LEHE12:
	.cfi_endproc
.LFE5023:
	.section	.gcc_except_table
	.align 4
.LLSDAC5023:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC5023-.LLSDATTDC5023
.LLSDATTDC5023:
	.byte	0x1
	.uleb128 .LLSDACSEC5023-.LLSDACSBC5023
.LLSDACSBC5023:
	.uleb128 .LEHB11-.LCOLDB2
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L169-.LCOLDB2
	.uleb128 0
	.uleb128 .LEHB12-.LCOLDB2
	.uleb128 .LEHE12-.LEHB12
	.uleb128 0
	.uleb128 0
.LLSDACSEC5023:
	.byte	0x1
	.byte	0
	.align 4
	.long	0

.LLSDATTC5023:
	.section	.text.unlikely
	.text
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0
	.section	.text.unlikely
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0.cold, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0.cold
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_:
.LFB4773:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4773
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	xorl	%r14d, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpq	$0, (%rdi)
	je	.L269
.L196:
	movq	16(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L195
	movq	0(%r13), %r12
	testq	%r12, %r12
	je	.L202
	movq	(%r12), %rax
	movq	16(%r12), %r15
	movq	%rax, 0(%r13)
	movq	$0, (%r12)
	testq	%r15, %r15
	je	.L204
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L205
	movl	8(%r15), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%r15)
.L206:
	cmpl	$1, %eax
	jne	.L204
	movq	(%r15), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L270
.L208:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L209
	movl	12(%r15), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%r15)
.L210:
	cmpl	$1, %eax
	je	.L271
	.p2align 4,,10
	.p2align 3
.L204:
	movdqu	8(%rbx), %xmm1
	movq	16(%rbx), %rax
	movups	%xmm1, 8(%r12)
	testq	%rax, %rax
	je	.L212
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L214
.L277:
	addl	$1, 8(%rax)
.L212:
	movq	24(%rbx), %rax
	xorl	%edx, %edx
	leaq	16(%rbp), %rcx
	movq	%rax, 24(%r12)
	divq	8(%rbp)
	movq	0(%rbp), %rax
	movq	%r12, 16(%rbp)
	movq	%rcx, (%rax,%rdx,8)
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L195
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %r15
	jmp	.L230
	.p2align 4,,10
	.p2align 3
.L228:
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L195
.L229:
	movq	%rcx, %r12
.L230:
	movq	0(%r13), %rcx
	testq	%rcx, %rcx
	je	.L215
	movq	(%rcx), %rax
	movq	16(%rcx), %rdi
	movq	%rax, 0(%r13)
	movq	$0, (%rcx)
	testq	%rdi, %rdi
	je	.L217
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L218
	movl	8(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rdi)
.L219:
	cmpl	$1, %eax
	je	.L272
.L217:
	movdqu	8(%rbx), %xmm0
	movq	16(%rbx), %rax
	movups	%xmm0, 8(%rcx)
	testq	%rax, %rax
	je	.L225
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L227
.L273:
	addl	$1, 8(%rax)
.L225:
	movq	24(%rbx), %rax
	xorl	%edx, %edx
	movq	%rcx, (%r12)
	movq	%rax, 24(%rcx)
	divq	8(%rbp)
	movq	0(%rbp), %rax
	leaq	(%rax,%rdx,8), %rax
	cmpq	$0, (%rax)
	jne	.L228
	movq	%r12, (%rax)
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L229
.L195:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L215:
	.cfi_restore_state
	movl	$32, %edi
.LEHB13:
	call	_Znwm@PLT
.LEHE13:
	movq	$0, (%rax)
	movq	%rax, %rcx
	movq	8(%rbx), %rax
	movq	%rax, 8(%rcx)
	movq	16(%rbx), %rax
	movq	%rax, 16(%rcx)
	testq	%rax, %rax
	je	.L225
	cmpb	$0, __libc_single_threaded(%rip)
	jne	.L273
.L227:
	lock addl	$1, 8(%rax)
	jmp	.L225
	.p2align 4,,10
	.p2align 3
.L272:
	movq	(%rdi), %rax
	movq	16(%rax), %rax
	cmpq	%r15, %rax
	jne	.L274
.L221:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L222
	movl	12(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rdi)
.L223:
	cmpl	$1, %eax
	jne	.L217
	movq	(%rdi), %rax
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rsi
	movq	%rcx, (%rsp)
	movq	24(%rax), %rdx
	cmpq	%rsi, %rdx
	jne	.L224
	call	*8(%rax)
	movq	(%rsp), %rcx
	jmp	.L217
	.p2align 4,,10
	.p2align 3
.L218:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rdi)
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L269:
	movq	8(%rdi), %rdx
	cmpq	$1, %rdx
	je	.L275
	movq	%rdx, %rax
	shrq	$60, %rax
	jne	.L276
	leaq	0(,%rdx,8), %r12
	movq	%r12, %rdi
.LEHB14:
	call	_Znwm@PLT
.LEHE14:
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%rax, %rdi
	movq	%rax, %r14
	call	memset@PLT
.L198:
	movq	%r14, 0(%rbp)
	jmp	.L196
	.p2align 4,,10
	.p2align 3
.L202:
	movl	$32, %edi
.LEHB15:
	call	_Znwm@PLT
.LEHE15:
	movq	$0, (%rax)
	movq	%rax, %r12
	movq	8(%rbx), %rax
	movq	%rax, 8(%r12)
	movq	16(%rbx), %rax
	movq	%rax, 16(%r12)
	testq	%rax, %rax
	je	.L212
	cmpb	$0, __libc_single_threaded(%rip)
	jne	.L277
.L214:
	lock addl	$1, 8(%rax)
	jmp	.L212
	.p2align 4,,10
	.p2align 3
.L205:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%r15)
	jmp	.L206
	.p2align 4,,10
	.p2align 3
.L222:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rdi)
	jmp	.L223
	.p2align 4,,10
	.p2align 3
.L274:
	movq	%rcx, 8(%rsp)
	movq	%rdi, (%rsp)
	call	*%rax
	movq	8(%rsp), %rcx
	movq	(%rsp), %rdi
	jmp	.L221
.L271:
	movq	(%r15), %rax
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%r15, %rdi
	movq	24(%rax), %rdx
	cmpq	%rcx, %rdx
	jne	.L211
	call	*8(%rax)
	jmp	.L204
.L224:
	call	*%rdx
	movq	(%rsp), %rcx
	jmp	.L217
.L275:
	movq	$0, 48(%rdi)
	leaq	48(%rdi), %r14
	jmp	.L198
.L209:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%r15)
	jmp	.L210
.L276:
	shrq	$61, %rdx
	je	.L200
.LEHB16:
	call	_ZSt28__throw_bad_array_new_lengthv@PLT
.L270:
	movq	%r15, %rdi
	call	*%rax
	jmp	.L208
.L200:
	call	_ZSt17__throw_bad_allocv@PLT
.LEHE16:
.L211:
	call	*%rdx
	jmp	.L204
.L235:
	endbr64
	movq	%rax, %rdi
.L231:
	call	__cxa_begin_catch@PLT
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE5clearEv
	testq	%r14, %r14
	je	.L232
	movq	0(%rbp), %rdi
	movq	8(%rbp), %rsi
	addq	$48, %rbp
	cmpq	%rbp, %rdi
	jne	.L278
.L232:
.LEHB17:
	call	__cxa_rethrow@PLT
.LEHE17:
.L278:
	salq	$3, %rsi
	call	_ZdlPvm@PLT
	jmp	.L232
.L236:
	endbr64
	movq	%rax, %rbp
.L233:
	call	__cxa_end_catch@PLT
	movq	%rbp, %rdi
.LEHB18:
	call	_Unwind_Resume@PLT
.LEHE18:
	.cfi_endproc
.LFE4773:
	.section	.gcc_except_table
	.align 4
.LLSDA4773:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT4773-.LLSDATTD4773
.LLSDATTD4773:
	.byte	0x1
	.uleb128 .LLSDACSE4773-.LLSDACSB4773
.LLSDACSB4773:
	.uleb128 .LEHB13-.LFB4773
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L235-.LFB4773
	.uleb128 0x1
	.uleb128 .LEHB14-.LFB4773
	.uleb128 .LEHE14-.LEHB14
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB15-.LFB4773
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L235-.LFB4773
	.uleb128 0x1
	.uleb128 .LEHB16-.LFB4773
	.uleb128 .LEHE16-.LEHB16
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB17-.LFB4773
	.uleb128 .LEHE17-.LEHB17
	.uleb128 .L236-.LFB4773
	.uleb128 0
	.uleb128 .LEHB18-.LFB4773
	.uleb128 .LEHE18-.LEHB18
	.uleb128 0
	.uleb128 0
.LLSDACSE4773:
	.byte	0x1
	.byte	0
	.align 4
	.long	0

.LLSDATT4773:
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_,comdat
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_:
.LFB4667:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4667
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	8(%rdi), %rbp
	movq	8(%rsi), %rdx
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	40(%rdi), %r14
	movq	(%rdi), %r13
	cmpq	%rbp, %rdx
	je	.L280
	cmpq	$1, %rdx
	je	.L316
	movq	%rdx, %rax
	shrq	$60, %rax
	jne	.L317
	leaq	0(,%rdx,8), %r12
	movq	%r12, %rdi
.LEHB19:
	call	_Znwm@PLT
.LEHE19:
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	8(%r15), %rdx
	movq	%rax, %rcx
.L282:
	movq	%rcx, (%rbx)
	movq	%rdx, 8(%rbx)
.L285:
	movq	24(%r15), %rax
	movdqu	32(%r15), %xmm1
	movq	%rsp, %rdx
	movq	%r15, %rsi
	movq	16(%rbx), %xmm0
	movq	%rbx, %xmm2
	movq	%rbx, %rdi
	movq	$0, 16(%rbx)
	movq	%rax, 24(%rbx)
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm1, 32(%rbx)
	movaps	%xmm0, (%rsp)
.LEHB20:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_17_ReuseOrAllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_
.LEHE20:
	testq	%r13, %r13
	je	.L286
	addq	$48, %rbx
	cmpq	%rbx, %r13
	je	.L286
	leaq	0(,%rbp,8), %rsi
	movq	%r13, %rdi
	call	_ZdlPvm@PLT
.L286:
	movq	(%rsp), %rbx
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %r13
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %r14
	testq	%rbx, %rbx
	jne	.L287
	jmp	.L279
	.p2align 4,,10
	.p2align 3
.L289:
	movl	$32, %esi
	movq	%r12, %rdi
	call	_ZdlPvm@PLT
	testq	%rbx, %rbx
	je	.L279
.L287:
	movq	%rbx, %r12
	movq	(%rbx), %rbx
	movq	16(%r12), %rbp
	testq	%rbp, %rbp
	je	.L289
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L290
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L291:
	cmpl	$1, %eax
	jne	.L289
	movq	0(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%r13, %rax
	jne	.L318
.L293:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L294
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L295:
	cmpl	$1, %eax
	jne	.L289
	movq	0(%rbp), %rax
	movq	%rbp, %rdi
	movq	24(%rax), %rdx
	cmpq	%r14, %rdx
	jne	.L296
	call	*8(%rax)
	jmp	.L289
	.p2align 4,,10
	.p2align 3
.L290:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L291
	.p2align 4,,10
	.p2align 3
.L279:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L319
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L294:
	.cfi_restore_state
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L295
	.p2align 4,,10
	.p2align 3
.L318:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L293
	.p2align 4,,10
	.p2align 3
.L280:
	movq	%r13, %rdi
	leaq	0(,%rbp,8), %rdx
	xorl	%esi, %esi
	xorl	%r13d, %r13d
	call	memset@PLT
	jmp	.L285
	.p2align 4,,10
	.p2align 3
.L296:
	call	*%rdx
	jmp	.L289
.L316:
	movq	$0, 48(%rdi)
	leaq	48(%rdi), %rcx
	jmp	.L282
.L317:
	shrq	$61, %rdx
	je	.L284
.LEHB21:
	call	_ZSt28__throw_bad_array_new_lengthv@PLT
.L284:
	call	_ZSt17__throw_bad_allocv@PLT
.LEHE21:
.L319:
	call	__stack_chk_fail@PLT
.L305:
	endbr64
	movq	%rax, %r15
.L298:
	movq	(%rsp), %rdi
.L299:
	testq	%rdi, %rdi
	je	.L320
	movq	(%rdi), %r12
	call	_ZNSt8__detail16_Hashtable_allocISaINS_10_Hash_nodeISt10shared_ptrI7FormulaELb1EEEEE18_M_deallocate_nodeEPS5_.constprop.0
	movq	%r12, %rdi
	jmp	.L299
.L320:
	movq	%r15, %rdi
	call	__cxa_begin_catch@PLT
	testq	%r13, %r13
	je	.L301
	movq	(%rbx), %rdi
	leaq	48(%rbx), %rax
	movq	8(%rbx), %rsi
	cmpq	%rax, %rdi
	je	.L302
	salq	$3, %rsi
	call	_ZdlPvm@PLT
.L302:
	movq	%r14, 40(%rbx)
	movq	%r13, (%rbx)
	movq	%rbp, 8(%rbx)
.L301:
	movq	8(%rbx), %rax
	movq	(%rbx), %rdi
	xorl	%esi, %esi
	leaq	0(,%rax,8), %rdx
	call	memset@PLT
.LEHB22:
	call	__cxa_rethrow@PLT
.LEHE22:
.L306:
	endbr64
	movq	%rax, %rbp
.L303:
	call	__cxa_end_catch@PLT
	movq	%rbp, %rdi
.LEHB23:
	call	_Unwind_Resume@PLT
.LEHE23:
	.cfi_endproc
.LFE4667:
	.section	.gcc_except_table
	.align 4
.LLSDA4667:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT4667-.LLSDATTD4667
.LLSDATTD4667:
	.byte	0x1
	.uleb128 .LLSDACSE4667-.LLSDACSB4667
.LLSDACSB4667:
	.uleb128 .LEHB19-.LFB4667
	.uleb128 .LEHE19-.LEHB19
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB20-.LFB4667
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L305-.LFB4667
	.uleb128 0x3
	.uleb128 .LEHB21-.LFB4667
	.uleb128 .LEHE21-.LEHB21
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB22-.LFB4667
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L306-.LFB4667
	.uleb128 0
	.uleb128 .LEHB23-.LFB4667
	.uleb128 .LEHE23-.LEHB23
	.uleb128 0
	.uleb128 0
.LLSDACSE4667:
	.byte	0x1
	.byte	0
	.byte	0
	.byte	0x7d
	.align 4
	.long	0

.LLSDATT4667:
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_,comdat
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm:
.LFB4922:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4922
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	cmpq	$1, %rsi
	je	.L345
	movq	%rsi, %rax
	movq	%rdx, %r12
	shrq	$60, %rax
	jne	.L346
	leaq	0(,%rsi,8), %r13
	movq	%r13, %rdi
.LEHB24:
	call	_Znwm@PLT
	movq	%r13, %rdx
	xorl	%esi, %esi
	movq	%rax, %rdi
	movq	%rax, %r12
	call	memset@PLT
	leaq	48(%rbp), %r10
.L323:
	movq	16(%rbp), %rsi
	movq	$0, 16(%rbp)
	xorl	%r8d, %r8d
	leaq	16(%rbp), %r9
.L344:
	testq	%rsi, %rsi
	je	.L347
.L326:
	movq	%rsi, %rcx
	xorl	%edx, %edx
	movq	(%rsi), %rsi
	movq	24(%rcx), %rax
	divq	%rbx
	leaq	(%r12,%rdx,8), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	.L348
	movq	(%rdi), %rdx
	movq	%rdx, (%rcx)
	movq	(%rax), %rax
	movq	%rcx, (%rax)
	testq	%rsi, %rsi
	jne	.L326
.L347:
	movq	0(%rbp), %rdi
	movq	8(%rbp), %rsi
	cmpq	%r10, %rdi
	je	.L327
	salq	$3, %rsi
	call	_ZdlPvm@PLT
.L327:
	movq	%rbx, 8(%rbp)
	movq	%r12, 0(%rbp)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L348:
	.cfi_restore_state
	movq	16(%rbp), %rdi
	movq	%rdi, (%rcx)
	movq	%rcx, 16(%rbp)
	movq	%r9, (%rax)
	cmpq	$0, (%rcx)
	je	.L335
	movq	%rcx, (%r12,%r8,8)
	movq	%rdx, %r8
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L335:
	movq	%rdx, %r8
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L345:
	leaq	48(%rdi), %r12
	movq	$0, 48(%rdi)
	movq	%r12, %r10
	jmp	.L323
	.p2align 4,,10
	.p2align 3
.L346:
	shrq	$61, %rbx
	je	.L325
	call	_ZSt28__throw_bad_array_new_lengthv@PLT
.L325:
	call	_ZSt17__throw_bad_allocv@PLT
.LEHE24:
.L336:
	endbr64
	movq	%rax, %rdi
.L332:
	call	__cxa_begin_catch@PLT
	movq	(%r12), %rax
	movq	%rax, 40(%rbp)
.LEHB25:
	call	__cxa_rethrow@PLT
.LEHE25:
.L337:
	endbr64
	movq	%rax, %rbp
.L333:
	call	__cxa_end_catch@PLT
	movq	%rbp, %rdi
.LEHB26:
	call	_Unwind_Resume@PLT
.LEHE26:
	.cfi_endproc
.LFE4922:
	.section	.gcc_except_table
	.align 4
.LLSDA4922:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT4922-.LLSDATTD4922
.LLSDATTD4922:
	.byte	0x1
	.uleb128 .LLSDACSE4922-.LLSDACSB4922
.LLSDACSB4922:
	.uleb128 .LEHB24-.LFB4922
	.uleb128 .LEHE24-.LEHB24
	.uleb128 .L336-.LFB4922
	.uleb128 0x1
	.uleb128 .LEHB25-.LFB4922
	.uleb128 .LEHE25-.LEHB25
	.uleb128 .L337-.LFB4922
	.uleb128 0
	.uleb128 .LEHB26-.LFB4922
	.uleb128 .LEHE26-.LEHB26
	.uleb128 0
	.uleb128 0
.LLSDACSE4922:
	.byte	0x1
	.byte	0
	.align 4
	.long	0

.LLSDATT4922:
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm,comdat
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm
	.section	.text._ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm,"axG",@progbits,_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm:
.LFB4848:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rcx, %r12
	movq	%r8, %rcx
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	addq	$32, %rdi
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movq	-8(%rdi), %rdx
	movq	-24(%rdi), %rsi
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	movq	8(%rdi), %rax
	movq	%rax, (%rsp)
	call	_ZNKSt8__detail20_Prime_rehash_policy14_M_need_rehashEmmm@PLT
	testb	%al, %al
	jne	.L359
.L350:
	movq	(%rbx), %rsi
	movq	%rbp, 24(%r12)
	leaq	(%rsi,%r13,8), %rcx
	movq	(%rcx), %rax
	testq	%rax, %rax
	je	.L351
	movq	(%rax), %rax
	movq	%rax, (%r12)
	movq	(%rcx), %rax
	movq	%r12, (%rax)
.L352:
	addq	$1, 24(%rbx)
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L360
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L359:
	.cfi_restore_state
	movq	%rdx, %rsi
	movq	%rbx, %rdi
	movq	%rsp, %rdx
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_rehashEmRKm
	movq	%rbp, %rax
	xorl	%edx, %edx
	divq	8(%rbx)
	movq	%rdx, %r13
	jmp	.L350
	.p2align 4,,10
	.p2align 3
.L351:
	movq	16(%rbx), %rax
	movq	%rax, (%r12)
	movq	%r12, 16(%rbx)
	movq	(%r12), %rax
	testq	%rax, %rax
	je	.L353
	movq	24(%rax), %rax
	xorl	%edx, %edx
	divq	8(%rbx)
	movq	%r12, (%rsi,%rdx,8)
.L353:
	leaq	16(%rbx), %rax
	movq	%rax, (%rcx)
	jmp	.L352
.L360:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE4848:
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm
	.section	.text.unlikely
	.align 2
.LCOLDB3:
	.text
.LHOTB3:
	.align 2
	.p2align 4
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0:
.LFB5029:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA5029
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	(%rsi), %rdi
	movq	(%rdi), %rax
.LEHB27:
	call	*104(%rax)
	xorl	%edx, %edx
	movq	%rax, %r12
	divq	8(%rbp)
	movq	0(%rbp), %rax
	movq	(%rax,%rdx,8), %r13
	movq	%rdx, %r14
	testq	%r13, %r13
	je	.L362
	movq	0(%r13), %rbx
	movq	24(%rbx), %rcx
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L363:
	movq	(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L362
	movq	24(%rsi), %rcx
	xorl	%edx, %edx
	movq	%rbx, %r13
	movq	%rcx, %rax
	divq	8(%rbp)
	cmpq	%rdx, %r14
	jne	.L362
	movq	%rsi, %rbx
.L365:
	cmpq	%rcx, %r12
	jne	.L363
	movq	(%r15), %rdi
	movq	8(%rbx), %rsi
	movq	(%rdi), %rax
	call	*88(%rax)
	testb	%al, %al
	je	.L363
	movq	0(%r13), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	je	.L362
.L364:
	xorl	%r8d, %r8d
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movb	%dl, %r8b
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	movq	%r8, %rdx
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L362:
	.cfi_restore_state
	movl	$32, %edi
	call	_Znwm@PLT
.LEHE27:
	pxor	%xmm0, %xmm0
	movq	%r12, %rdx
	movq	%r14, %rsi
	movq	%rax, %r13
	movq	$0, (%rax)
	movq	(%r15), %rax
	movl	$1, %r8d
	movq	%r13, %rcx
	movq	%rbp, %rdi
	movq	%rax, 8(%r13)
	movq	8(%r15), %rax
	movups	%xmm0, (%r15)
	movq	%rax, 16(%r13)
.LEHB28:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm
.LEHE28:
	movl	$1, %edx
	jmp	.L364
.L369:
	endbr64
	movq	%rax, %rbp
	jmp	.L366
	.section	.gcc_except_table
.LLSDA5029:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE5029-.LLSDACSB5029
.LLSDACSB5029:
	.uleb128 .LEHB27-.LFB5029
	.uleb128 .LEHE27-.LEHB27
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB28-.LFB5029
	.uleb128 .LEHE28-.LEHB28
	.uleb128 .L369-.LFB5029
	.uleb128 0
.LLSDACSE5029:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC5029
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0.cold, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0.cold:
.LFSB5029:
.L366:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%r13, %rdi
	call	_ZNSt8__detail16_Hashtable_allocISaINS_10_Hash_nodeISt10shared_ptrI7FormulaELb1EEEEE18_M_deallocate_nodeEPS5_.constprop.0
	movq	%rbp, %rdi
.LEHB29:
	call	_Unwind_Resume@PLT
.LEHE29:
	.cfi_endproc
.LFE5029:
	.section	.gcc_except_table
.LLSDAC5029:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC5029-.LLSDACSBC5029
.LLSDACSBC5029:
	.uleb128 .LEHB29-.LCOLDB3
	.uleb128 .LEHE29-.LEHB29
	.uleb128 0
	.uleb128 0
.LLSDACSEC5029:
	.section	.text.unlikely
	.text
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
	.section	.text.unlikely
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0.cold, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0.cold
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
	.align 2
.LCOLDB4:
	.text
.LHOTB4:
	.align 2
	.p2align 4
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0:
.LFB5030:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA5030
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	(%rsi), %rdi
	movq	(%rdi), %rax
.LEHB30:
	call	*104(%rax)
	xorl	%edx, %edx
	movq	%rax, %r12
	divq	8(%rbp)
	movq	0(%rbp), %rax
	movq	(%rax,%rdx,8), %r13
	movq	%rdx, %r14
	testq	%r13, %r13
	je	.L382
	movq	0(%r13), %rbx
	movq	24(%rbx), %rcx
	jmp	.L385
	.p2align 4,,10
	.p2align 3
.L383:
	movq	(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L382
	movq	24(%rsi), %rcx
	xorl	%edx, %edx
	movq	%rbx, %r13
	movq	%rcx, %rax
	divq	8(%rbp)
	cmpq	%rdx, %r14
	jne	.L382
	movq	%rsi, %rbx
.L385:
	cmpq	%rcx, %r12
	jne	.L383
	movq	(%r15), %rdi
	movq	8(%rbx), %rsi
	movq	(%rdi), %rax
	call	*88(%rax)
	testb	%al, %al
	je	.L383
	movq	0(%r13), %rax
	xorl	%edx, %edx
	testq	%rax, %rax
	je	.L382
.L384:
	xorl	%r8d, %r8d
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movb	%dl, %r8b
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	movq	%r8, %rdx
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L382:
	.cfi_restore_state
	movl	$32, %edi
	call	_Znwm@PLT
.LEHE30:
	movq	$0, (%rax)
	movq	%rax, %r13
	movq	(%r15), %rax
	movq	%rax, 8(%r13)
	movq	8(%r15), %rax
	movq	%rax, 16(%r13)
	testq	%rax, %rax
	je	.L386
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L387
	addl	$1, 8(%rax)
.L386:
	movl	$1, %r8d
	movq	%r13, %rcx
	movq	%r12, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
.LEHB31:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEEm
.LEHE31:
	movl	$1, %edx
	jmp	.L384
.L387:
	lock addl	$1, 8(%rax)
	jmp	.L386
.L391:
	endbr64
	movq	%rax, %rbp
	jmp	.L388
	.section	.gcc_except_table
.LLSDA5030:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE5030-.LLSDACSB5030
.LLSDACSB5030:
	.uleb128 .LEHB30-.LFB5030
	.uleb128 .LEHE30-.LEHB30
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB31-.LFB5030
	.uleb128 .LEHE31-.LEHB31
	.uleb128 .L391-.LFB5030
	.uleb128 0
.LLSDACSE5030:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC5030
	.type	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0.cold, @function
_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0.cold:
.LFSB5030:
.L388:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%r13, %rdi
	call	_ZNSt8__detail16_Hashtable_allocISaINS_10_Hash_nodeISt10shared_ptrI7FormulaELb1EEEEE18_M_deallocate_nodeEPS5_.constprop.0
	movq	%rbp, %rdi
.LEHB32:
	call	_Unwind_Resume@PLT
.LEHE32:
	.cfi_endproc
.LFE5030:
	.section	.gcc_except_table
.LLSDAC5030:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC5030-.LLSDACSBC5030
.LLSDACSBC5030:
	.uleb128 .LEHB32-.LCOLDB4
	.uleb128 .LEHE32-.LEHB32
	.uleb128 0
	.uleb128 0
.LLSDACSEC5030:
	.section	.text.unlikely
	.text
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
	.section	.text.unlikely
	.size	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0.cold, .-_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0.cold
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"basic_string::substr"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC6:
	.string	"%s: __pos (which is %zu) > this->size() (which is %zu)"
	.section	.rodata.str1.1
.LC7:
	.string	"basic_string::basic_string"
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"basic_string::_M_construct null not valid"
	.section	.rodata.str1.1
.LC9:
	.string	"=>"
	.section	.text.unlikely
	.align 2
.LCOLDB11:
	.text
.LHOTB11:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula8parseImpEv
	.type	_ZN12ParseFormula8parseImpEv, @function
_ZN12ParseFormula8parseImpEv:
.LFB4171:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4171
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$248, %rsp
	.cfi_def_cfa_offset 304
	movq	%fs:40, %rax
	movq	%rax, 232(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rdi
.LEHB33:
	call	_ZN12ParseFormula7parseOrEv
.LEHE33:
	movq	32(%rbp), %rbx
	movq	40(%rbp), %r12
	jmp	.L407
	.p2align 4,,10
	.p2align 3
.L409:
	movq	%rax, 40(%rbp)
	movq	%rax, %r12
.L407:
	movq	8(%rbx), %r13
	movl	$37, %edi
	cmpq	%r12, %r13
	jbe	.L540
	movq	(%rbx), %rax
	movsbl	(%rax,%r12), %edi
.L540:
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%r12), %rax
	testl	%r8d, %r8d
	jne	.L409
	cmpq	%r12, %r13
	jb	.L541
	movq	8(%rbx), %rcx
	leaq	208(%rsp), %r13
	movq	%r13, 192(%rsp)
	movq	(%rbx), %rdx
	cmpq	%rcx, %r12
	ja	.L542
	subq	%r12, %rcx
	movl	$2, %eax
	addq	%r12, %rdx
	cmpq	%rax, %rcx
	movq	%rdx, %rsi
	cmovbe	%rcx, %rax
	addq	%rax, %rsi
	je	.L413
	testq	%rdx, %rdx
	je	.L543
.L413:
	cmpq	$1, %rcx
	je	.L544
	testq	%rcx, %rcx
	jne	.L545
.L415:
	leaq	192(%rsp), %rdi
	leaq	.LC9(%rip), %rsi
	movq	%rax, 200(%rsp)
	movb	$0, 208(%rsp,%rax)
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc@PLT
	movq	192(%rsp), %rdi
	movl	%eax, %ebx
	cmpq	%r13, %rdi
	je	.L418
	movq	208(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L418:
	testl	%ebx, %ebx
	je	.L546
	movdqa	16(%rsp), %xmm1
	movups	%xmm1, (%r14)
.L406:
	movq	232(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L547
	addq	$248, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L545:
	.cfi_restore_state
	movl	%eax, %r8d
	testl	%eax, %eax
	je	.L415
	xorl	%ecx, %ecx
.L416:
	movl	%ecx, %esi
	addl	$1, %ecx
	movzbl	(%rdx,%rsi), %edi
	movb	%dil, 0(%r13,%rsi)
	cmpl	%r8d, %ecx
	jb	.L416
	jmp	.L415
	.p2align 4,,10
	.p2align 3
.L544:
	movzbl	(%rdx), %edx
	movb	%dl, 208(%rsp)
	jmp	.L415
	.p2align 4,,10
	.p2align 3
.L546:
	addq	$2, 40(%rbp)
	leaq	32(%rsp), %r13
	movq	%rbp, %rsi
	movq	%r13, %rdi
.LEHB34:
	call	_ZN12ParseFormula8parseImpEv
.LEHE34:
	movq	32(%rsp), %rdi
	leaq	112(%rsp), %rax
	movq	$1, 72(%rsp)
	leaq	64(%rsp), %rbp
	movq	%rax, 64(%rsp)
	movq	(%rdi), %rax
	movl	$0x3f800000, 96(%rsp)
	movq	$0, 80(%rsp)
	movq	$0, 88(%rsp)
	movq	$0, 104(%rsp)
	movq	$0, 112(%rsp)
.LEHB35:
	call	*24(%rax)
.LEHE35:
	movdqa	16(%rsp), %xmm0
	movhlps	%xmm0, %xmm2
	movq	%xmm2, %rbx
	cmpl	$6, %eax
	jne	.L420
	movq	32(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L421
	movq	%rbp, %rdi
	xorl	%ecx, %ecx
	leaq	_ZTI2Or(%rip), %rdx
	movaps	%xmm0, (%rsp)
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movdqa	(%rsp), %xmm0
	movq	%rax, %rbp
.L421:
	movaps	%xmm0, 48(%rsp)
	testq	%rbx, %rbx
	je	.L422
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L423
	addl	$1, 8(%rbx)
.L422:
	leaq	128(%rsp), %r12
	leaq	48(%rsp), %rsi
	movq	%r12, %rdi
.LEHB36:
	call	_ZN3Not6createESt10shared_ptrI7FormulaE@PLT
.LEHE36:
	movq	%r12, %rsi
	movq	%rbp, %rdi
.LEHB37:
	call	_ZN2Or13addSubformulaERKSt10shared_ptrI7FormulaE@PLT
.LEHE37:
	movq	136(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L425
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L426
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L427:
	cmpl	$1, %eax
	je	.L548
.L425:
	movq	56(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L434
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L435
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L436:
	cmpl	$1, %eax
	je	.L549
.L434:
	movdqa	32(%rsp), %xmm3
	pxor	%xmm0, %xmm0
	leaq	64(%rsp), %rbp
	movaps	%xmm0, 32(%rsp)
	movups	%xmm3, (%r14)
.L442:
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	40(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L464
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L465
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L466:
	cmpl	$1, %eax
	je	.L550
.L464:
	movq	24(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L406
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L474
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L475:
	cmpl	$1, %eax
	jne	.L406
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L551
.L477:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L478
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L479:
	cmpl	$1, %eax
	jne	.L406
	movq	0(%rbp), %rax
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rax), %rdx
	cmpq	%rcx, %rdx
	jne	.L480
	call	*8(%rax)
	jmp	.L406
	.p2align 4,,10
	.p2align 3
.L420:
	movaps	%xmm0, 48(%rsp)
	testq	%rbx, %rbx
	je	.L443
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L444
	addl	$1, 8(%rbx)
.L443:
	leaq	128(%rsp), %r12
	leaq	48(%rsp), %rsi
	movq	%r12, %rdi
.LEHB38:
	call	_ZN3Not6createESt10shared_ptrI7FormulaE@PLT
.LEHE38:
	leaq	64(%rsp), %rbp
	movq	%r12, %rsi
	movq	%rbp, %rdi
.LEHB39:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
.LEHE39:
	movq	136(%rsp), %r15
	testq	%r15, %r15
	je	.L446
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L447
	movl	8(%r15), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%r15)
.L448:
	cmpl	$1, %eax
	je	.L552
.L446:
	movq	56(%rsp), %r15
	testq	%r15, %r15
	je	.L455
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L456
	movl	8(%r15), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%r15)
.L457:
	cmpl	$1, %eax
	je	.L553
.L455:
	movq	%r13, %rsi
	movq	%rbp, %rdi
.LEHB40:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
	movq	72(%rsp), %rax
	movdqa	96(%rsp), %xmm4
	movq	%rbp, %rsi
	movq	%r12, %rdi
	movq	$0, 128(%rsp)
	movq	%rax, 136(%rsp)
	movq	88(%rsp), %rax
	movq	$0, 144(%rsp)
	movq	%rax, 152(%rsp)
	movq	$0, 176(%rsp)
	movaps	%xmm4, 160(%rsp)
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0
.LEHE40:
	movq	%r12, %rsi
	movq	%r14, %rdi
.LEHB41:
	call	_ZN2Or6createESt13unordered_setISt10shared_ptrI7FormulaEN5Deref4HashENS4_7CompareESaIS3_EE@PLT
.LEHE41:
	movq	%r12, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	jmp	.L442
	.p2align 4,,10
	.p2align 3
.L474:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L475
.L478:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L479
.L550:
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L554
.L468:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L469
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L470:
	cmpl	$1, %eax
	jne	.L464
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L471
	call	*8(%rdx)
	jmp	.L464
.L465:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L466
.L469:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L470
.L480:
	call	*%rdx
	jmp	.L406
.L554:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L468
.L423:
	lock addl	$1, 8(%rbx)
	jmp	.L422
.L444:
	lock addl	$1, 8(%rbx)
	jmp	.L443
.L551:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L477
.L549:
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L555
.L438:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L439
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L440:
	cmpl	$1, %eax
	jne	.L434
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L441
	call	*8(%rdx)
	jmp	.L434
.L548:
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L556
.L429:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L430
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L431:
	cmpl	$1, %eax
	jne	.L425
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L432
	call	*8(%rdx)
	jmp	.L425
.L426:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L427
.L435:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L436
.L553:
	movq	(%r15), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L557
.L459:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L460
	movl	12(%r15), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%r15)
.L461:
	cmpl	$1, %eax
	jne	.L455
	movq	(%r15), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%r15, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L462
	call	*8(%rdx)
	jmp	.L455
.L552:
	movq	(%r15), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L558
.L450:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L451
	movl	12(%r15), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%r15)
.L452:
	cmpl	$1, %eax
	jne	.L446
	movq	(%r15), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%r15, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L453
	call	*8(%rdx)
	jmp	.L446
.L456:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%r15)
	jmp	.L457
.L447:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%r15)
	jmp	.L448
.L451:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%r15)
	jmp	.L452
.L430:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L431
.L460:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%r15)
	jmp	.L461
.L439:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L440
.L556:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L429
.L555:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L438
.L558:
	movq	%r15, %rdi
	call	*%rax
	jmp	.L450
.L557:
	movq	%r15, %rdi
	call	*%rax
	jmp	.L459
.L471:
	call	*%rax
	jmp	.L464
.L441:
	call	*%rax
	jmp	.L434
.L432:
	call	*%rax
	jmp	.L425
.L453:
	call	*%rax
	jmp	.L446
.L462:
	call	*%rax
	jmp	.L455
.L542:
	movq	%r12, %rdx
	leaq	.LC7(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
.LEHB42:
	call	_ZSt24__throw_out_of_range_fmtPKcz@PLT
.L541:
	movq	%r13, %rcx
	movq	%r12, %rdx
	leaq	.LC5(%rip), %rsi
	xorl	%eax, %eax
	leaq	.LC6(%rip), %rdi
	call	_ZSt24__throw_out_of_range_fmtPKcz@PLT
.L547:
	call	__stack_chk_fail@PLT
.L543:
	leaq	.LC8(%rip), %rdi
	call	_ZSt19__throw_logic_errorPKc@PLT
.LEHE42:
.L498:
	endbr64
	movq	%rax, %rbx
	jmp	.L481
.L500:
	endbr64
	movq	%rax, %rbx
	jmp	.L486
.L499:
	endbr64
	movq	%rax, %rbx
	leaq	64(%rsp), %rbp
	jmp	.L488
.L501:
	endbr64
	movq	%rax, %rbx
	jmp	.L490
.L497:
	endbr64
	movq	%rax, %rbx
	jmp	.L483
.L496:
	endbr64
	movq	%rax, %rbx
	jmp	.L485
.L495:
	endbr64
	movq	%rax, %rbx
	jmp	.L492
	.section	.gcc_except_table
.LLSDA4171:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4171-.LLSDACSB4171
.LLSDACSB4171:
	.uleb128 .LEHB33-.LFB4171
	.uleb128 .LEHE33-.LEHB33
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB34-.LFB4171
	.uleb128 .LEHE34-.LEHB34
	.uleb128 .L495-.LFB4171
	.uleb128 0
	.uleb128 .LEHB35-.LFB4171
	.uleb128 .LEHE35-.LEHB35
	.uleb128 .L496-.LFB4171
	.uleb128 0
	.uleb128 .LEHB36-.LFB4171
	.uleb128 .LEHE36-.LEHB36
	.uleb128 .L497-.LFB4171
	.uleb128 0
	.uleb128 .LEHB37-.LFB4171
	.uleb128 .LEHE37-.LEHB37
	.uleb128 .L498-.LFB4171
	.uleb128 0
	.uleb128 .LEHB38-.LFB4171
	.uleb128 .LEHE38-.LEHB38
	.uleb128 .L499-.LFB4171
	.uleb128 0
	.uleb128 .LEHB39-.LFB4171
	.uleb128 .LEHE39-.LEHB39
	.uleb128 .L500-.LFB4171
	.uleb128 0
	.uleb128 .LEHB40-.LFB4171
	.uleb128 .LEHE40-.LEHB40
	.uleb128 .L496-.LFB4171
	.uleb128 0
	.uleb128 .LEHB41-.LFB4171
	.uleb128 .LEHE41-.LEHB41
	.uleb128 .L501-.LFB4171
	.uleb128 0
	.uleb128 .LEHB42-.LFB4171
	.uleb128 .LEHE42-.LEHB42
	.uleb128 .L495-.LFB4171
	.uleb128 0
.LLSDACSE4171:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4171
	.type	_ZN12ParseFormula8parseImpEv.cold, @function
_ZN12ParseFormula8parseImpEv.cold:
.LFSB4171:
.L481:
	.cfi_def_cfa_offset 304
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	136(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L483
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L483:
	movq	56(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L484
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L484:
	leaq	64(%rsp), %rbp
.L485:
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L492
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L492:
	movq	24(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L493
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L493:
	movq	%rbx, %rdi
.LEHB43:
	call	_Unwind_Resume@PLT
.LEHE43:
.L486:
	movq	136(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L488
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L488:
	movq	56(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L485
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	jmp	.L485
.L490:
	movq	%r12, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	jmp	.L485
	.cfi_endproc
.LFE4171:
	.section	.gcc_except_table
.LLSDAC4171:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4171-.LLSDACSBC4171
.LLSDACSBC4171:
	.uleb128 .LEHB43-.LCOLDB11
	.uleb128 .LEHE43-.LEHB43
	.uleb128 0
	.uleb128 0
.LLSDACSEC4171:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormula8parseImpEv, .-_ZN12ParseFormula8parseImpEv
	.section	.text.unlikely
	.size	_ZN12ParseFormula8parseImpEv.cold, .-_ZN12ParseFormula8parseImpEv.cold
.LCOLDE11:
	.text
.LHOTE11:
	.section	.rodata.str1.1
.LC12:
	.string	"<=>"
	.section	.text.unlikely
	.align 2
.LCOLDB13:
	.text
.LHOTB13:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula8parseIffEv
	.type	_ZN12ParseFormula8parseIffEv, @function
_ZN12ParseFormula8parseIffEv:
.LFB4172:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4172
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$376, %rsp
	.cfi_def_cfa_offset 432
	movq	%fs:40, %rax
	movq	%rax, 360(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %r15
	movq	%r15, %rdi
.LEHB44:
	call	_ZN12ParseFormula8parseImpEv
.LEHE44:
	movq	32(%rbp), %rbx
	movq	40(%rbp), %r12
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L562:
	movq	%rax, 40(%rbp)
	movq	%rax, %r12
.L560:
	movq	8(%rbx), %r13
	movl	$37, %edi
	cmpq	%r12, %r13
	jbe	.L721
	movq	(%rbx), %rax
	movsbl	(%rax,%r12), %edi
.L721:
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%r12), %rax
	testl	%r8d, %r8d
	jne	.L562
	cmpq	%r12, %r13
	jb	.L724
	movq	8(%rbx), %rcx
	leaq	336(%rsp), %r13
	movq	%r13, 320(%rsp)
	movq	(%rbx), %rdx
	cmpq	%r12, %rcx
	jb	.L725
	subq	%r12, %rcx
	movl	$3, %eax
	addq	%r12, %rdx
	cmpq	%rax, %rcx
	movq	%rdx, %rsi
	cmovbe	%rcx, %rax
	addq	%rax, %rsi
	je	.L566
	testq	%rdx, %rdx
	je	.L726
.L566:
	cmpq	$1, %rcx
	je	.L727
	testq	%rcx, %rcx
	jne	.L728
.L568:
	leaq	320(%rsp), %rdi
	leaq	.LC12(%rip), %rsi
	movq	%rax, 328(%rsp)
	movb	$0, 336(%rsp,%rax)
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc@PLT
	movq	320(%rsp), %rdi
	movl	%eax, %ebx
	cmpq	%r13, %rdi
	je	.L571
	movq	336(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L571:
	testl	%ebx, %ebx
	je	.L729
	movdqa	16(%rsp), %xmm1
	movups	%xmm1, (%r14)
.L559:
	movq	360(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L730
	addq	$376, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L728:
	.cfi_restore_state
	movl	%eax, %r8d
	testl	%eax, %eax
	je	.L568
	xorl	%ecx, %ecx
.L569:
	movl	%ecx, %esi
	addl	$1, %ecx
	movzbl	(%rdx,%rsi), %edi
	movb	%dil, 0(%r13,%rsi)
	cmpl	%r8d, %ecx
	jb	.L569
	jmp	.L568
	.p2align 4,,10
	.p2align 3
.L727:
	movzbl	(%rdx), %edx
	movb	%dl, 336(%rsp)
	jmp	.L568
	.p2align 4,,10
	.p2align 3
.L729:
	addq	$3, 40(%rbp)
	leaq	32(%rsp), %r13
	movq	%rbp, %rsi
	movq	%r13, %rdi
.LEHB45:
	call	_ZN12ParseFormula8parseIffEv
.LEHE45:
	leaq	112(%rsp), %rax
	movss	.LC10(%rip), %xmm0
	movq	%r15, %rsi
	leaq	128(%rsp), %rbx
	movq	%rax, 64(%rsp)
	movq	%rbx, %rdi
	leaq	176(%rsp), %rax
	leaq	192(%rsp), %r12
	movq	%rax, 128(%rsp)
	leaq	64(%rsp), %rbp
	leaq	240(%rsp), %rax
	movq	$1, 72(%rsp)
	movq	$0, 80(%rsp)
	movq	$0, 88(%rsp)
	movq	$0, 104(%rsp)
	movq	$0, 112(%rsp)
	movq	$1, 136(%rsp)
	movq	$0, 144(%rsp)
	movq	$0, 152(%rsp)
	movq	$0, 168(%rsp)
	movq	$0, 176(%rsp)
	movq	%rax, 192(%rsp)
	movq	$1, 200(%rsp)
	movq	$0, 208(%rsp)
	movq	$0, 216(%rsp)
	movq	$0, 232(%rsp)
	movq	$0, 240(%rsp)
	movss	%xmm0, 96(%rsp)
	movss	%xmm0, 160(%rsp)
	movss	%xmm0, 224(%rsp)
.LEHB46:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
.LEHE46:
	movdqa	16(%rsp), %xmm2
	movq	24(%rsp), %rax
	movaps	%xmm2, 48(%rsp)
	testq	%rax, %rax
	je	.L573
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L574
	addl	$1, 8(%rax)
.L573:
	leaq	256(%rsp), %r13
	leaq	48(%rsp), %r15
	movq	%r15, %rsi
	movq	%r13, %rdi
.LEHB47:
	call	_ZN3Not6createESt10shared_ptrI7FormulaE@PLT
.LEHE47:
	leaq	192(%rsp), %r12
	movq	%r13, %rsi
	movq	%r12, %rdi
.LEHB48:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
.LEHE48:
	movq	264(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L576
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L577
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L578:
	cmpl	$1, %eax
	jne	.L576
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L731
.L580:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L581
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L582:
	cmpl	$1, %eax
	jne	.L576
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L583
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L576:
	movq	56(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L585
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L586
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L587:
	cmpl	$1, %eax
	jne	.L585
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L732
.L589:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L590
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L591:
	cmpl	$1, %eax
	jne	.L585
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L592
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L585:
	movdqa	32(%rsp), %xmm3
	movq	40(%rsp), %rax
	movaps	%xmm3, 48(%rsp)
	testq	%rax, %rax
	je	.L593
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L594
	addl	$1, 8(%rax)
.L593:
	movq	%r15, %rsi
	movq	%r13, %rdi
.LEHB49:
	call	_ZN3Not6createESt10shared_ptrI7FormulaE@PLT
.LEHE49:
	movq	%r13, %rsi
	movq	%r12, %rdi
.LEHB50:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
.LEHE50:
	movq	264(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L596
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L597
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L598:
	cmpl	$1, %eax
	jne	.L596
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L733
.L600:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L601
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L602:
	cmpl	$1, %eax
	jne	.L596
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L603
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L596:
	movq	56(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L605
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L606
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L607:
	cmpl	$1, %eax
	jne	.L605
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L734
.L609:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L610
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L611:
	cmpl	$1, %eax
	jne	.L605
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L612
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L605:
	movq	136(%rsp), %rax
	movq	%rbx, %rsi
	movq	%r13, %rdi
	leaq	64(%rsp), %rbp
	movdqa	160(%rsp), %xmm4
	movq	$0, 256(%rsp)
	movq	%rax, 264(%rsp)
	movq	152(%rsp), %rax
	movq	$0, 272(%rsp)
	movq	%rax, 280(%rsp)
	movq	$0, 304(%rsp)
	movaps	%xmm4, 288(%rsp)
.LEHB51:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0
.LEHE51:
	movq	%r13, %rsi
	movq	%r15, %rdi
.LEHB52:
	call	_ZN3And6createESt13unordered_setISt10shared_ptrI7FormulaEN5Deref4HashENS4_7CompareESaIS3_EE@PLT
.LEHE52:
	movq	%r15, %rsi
	movq	%rbp, %rdi
.LEHB53:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
.LEHE53:
	movq	56(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L614
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L615
	movl	8(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rdi)
.L616:
	cmpl	$1, %eax
	jne	.L614
	movq	(%rdi), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L735
.L618:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L619
	movl	12(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rdi)
.L620:
	cmpl	$1, %eax
	jne	.L614
	movq	(%rdi), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L621
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L614:
	movq	%r13, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	200(%rsp), %rax
	movq	%r12, %rsi
	movq	%r13, %rdi
	movdqa	224(%rsp), %xmm5
	movq	$0, 256(%rsp)
	movq	%rax, 264(%rsp)
	movq	216(%rsp), %rax
	movq	$0, 272(%rsp)
	movq	%rax, 280(%rsp)
	movq	$0, 304(%rsp)
	movaps	%xmm5, 288(%rsp)
.LEHB54:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0
.LEHE54:
	movq	%r13, %rsi
	movq	%r15, %rdi
.LEHB55:
	call	_ZN3And6createESt13unordered_setISt10shared_ptrI7FormulaEN5Deref4HashENS4_7CompareESaIS3_EE@PLT
.LEHE55:
	movq	%r15, %rsi
	movq	%rbp, %rdi
.LEHB56:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
.LEHE56:
	movq	56(%rsp), %r15
	testq	%r15, %r15
	je	.L623
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L624
	movl	8(%r15), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%r15)
.L625:
	cmpl	$1, %eax
	jne	.L623
	movq	(%r15), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L736
.L627:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L628
	movl	12(%r15), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%r15)
.L629:
	cmpl	$1, %eax
	jne	.L623
	movq	(%r15), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%r15, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L630
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L623:
	movq	%r13, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	72(%rsp), %rax
	movq	%rbp, %rsi
	movq	%r13, %rdi
	movdqa	96(%rsp), %xmm6
	movq	$0, 256(%rsp)
	movq	%rax, 264(%rsp)
	movq	88(%rsp), %rax
	movq	$0, 272(%rsp)
	movq	%rax, 280(%rsp)
	movq	$0, 304(%rsp)
	movaps	%xmm6, 288(%rsp)
.LEHB57:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0
.LEHE57:
	movq	%r13, %rsi
	movq	%r14, %rdi
.LEHB58:
	call	_ZN2Or6createESt13unordered_setISt10shared_ptrI7FormulaEN5Deref4HashENS4_7CompareESaIS3_EE@PLT
.LEHE58:
	movq	%r13, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	%r12, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	%rbx, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	40(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L632
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L633
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L634:
	cmpl	$1, %eax
	jne	.L632
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L737
.L636:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L637
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L638:
	cmpl	$1, %eax
	jne	.L632
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L639
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L632:
	movq	24(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L559
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L642
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L643:
	cmpl	$1, %eax
	jne	.L559
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L738
.L645:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L646
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L647:
	cmpl	$1, %eax
	jne	.L559
	movq	0(%rbp), %rax
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rax), %rdx
	cmpq	%rcx, %rdx
	jne	.L648
	call	*8(%rax)
	jmp	.L559
.L594:
	lock addl	$1, 8(%rax)
	jmp	.L593
.L574:
	lock addl	$1, 8(%rax)
	jmp	.L573
	.p2align 4,,10
	.p2align 3
.L642:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L643
.L646:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L647
.L606:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L607
.L586:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L587
.L633:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L634
.L597:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L598
.L615:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rdi)
	jmp	.L616
.L577:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L578
.L624:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%r15)
	jmp	.L625
.L590:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L591
.L610:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L611
.L601:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L602
.L637:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L638
.L628:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%r15)
	jmp	.L629
.L581:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L582
.L619:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rdi)
	jmp	.L620
.L648:
	call	*%rdx
	jmp	.L559
.L737:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L636
.L734:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L609
.L736:
	movq	%r15, %rdi
	call	*%rax
	jmp	.L627
.L731:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L580
.L732:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L589
.L735:
	movq	%rdi, 8(%rsp)
	call	*%rax
	movq	8(%rsp), %rdi
	jmp	.L618
.L733:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L600
.L738:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L645
.L583:
	call	*%rax
	jmp	.L576
.L603:
	call	*%rax
	jmp	.L596
.L621:
	call	*%rax
	jmp	.L614
.L592:
	call	*%rax
	jmp	.L585
.L639:
	call	*%rax
	jmp	.L632
.L612:
	call	*%rax
	jmp	.L605
.L630:
	call	*%rax
	jmp	.L623
.L724:
	movq	%r13, %rcx
	movq	%r12, %rdx
	leaq	.LC5(%rip), %rsi
	xorl	%eax, %eax
	leaq	.LC6(%rip), %rdi
.LEHB59:
	call	_ZSt24__throw_out_of_range_fmtPKcz@PLT
.L726:
	leaq	.LC8(%rip), %rdi
	call	_ZSt19__throw_logic_errorPKc@PLT
.L730:
	call	__stack_chk_fail@PLT
.L725:
	movq	%r12, %rdx
	leaq	.LC7(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	_ZSt24__throw_out_of_range_fmtPKcz@PLT
.LEHE59:
.L669:
	endbr64
	movq	%rax, %r13
	jmp	.L666
.L676:
	endbr64
	movq	%rax, %r14
	jmp	.L658
.L677:
	endbr64
	movq	%rax, %r14
	jmp	.L664
.L670:
	endbr64
	movq	%rax, %r13
	jmp	.L653
.L673:
	endbr64
	movq	%rax, %r13
	jmp	.L656
.L674:
	endbr64
	movq	%rax, %r13
	jmp	.L654
.L671:
	endbr64
	movq	%rax, %r13
	leaq	192(%rsp), %r12
	jmp	.L656
.L672:
	endbr64
	movq	%rax, %r13
	jmp	.L649
.L679:
	endbr64
	movq	%rax, %r14
	jmp	.L664
.L678:
	endbr64
	movq	%rax, %r14
	jmp	.L661
.L675:
	endbr64
	movq	%rax, %r14
	leaq	64(%rsp), %rbp
	jmp	.L664
	.section	.gcc_except_table
.LLSDA4172:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4172-.LLSDACSB4172
.LLSDACSB4172:
	.uleb128 .LEHB44-.LFB4172
	.uleb128 .LEHE44-.LEHB44
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB45-.LFB4172
	.uleb128 .LEHE45-.LEHB45
	.uleb128 .L669-.LFB4172
	.uleb128 0
	.uleb128 .LEHB46-.LFB4172
	.uleb128 .LEHE46-.LEHB46
	.uleb128 .L670-.LFB4172
	.uleb128 0
	.uleb128 .LEHB47-.LFB4172
	.uleb128 .LEHE47-.LEHB47
	.uleb128 .L671-.LFB4172
	.uleb128 0
	.uleb128 .LEHB48-.LFB4172
	.uleb128 .LEHE48-.LEHB48
	.uleb128 .L672-.LFB4172
	.uleb128 0
	.uleb128 .LEHB49-.LFB4172
	.uleb128 .LEHE49-.LEHB49
	.uleb128 .L673-.LFB4172
	.uleb128 0
	.uleb128 .LEHB50-.LFB4172
	.uleb128 .LEHE50-.LEHB50
	.uleb128 .L674-.LFB4172
	.uleb128 0
	.uleb128 .LEHB51-.LFB4172
	.uleb128 .LEHE51-.LEHB51
	.uleb128 .L670-.LFB4172
	.uleb128 0
	.uleb128 .LEHB52-.LFB4172
	.uleb128 .LEHE52-.LEHB52
	.uleb128 .L675-.LFB4172
	.uleb128 0
	.uleb128 .LEHB53-.LFB4172
	.uleb128 .LEHE53-.LEHB53
	.uleb128 .L676-.LFB4172
	.uleb128 0
	.uleb128 .LEHB54-.LFB4172
	.uleb128 .LEHE54-.LEHB54
	.uleb128 .L670-.LFB4172
	.uleb128 0
	.uleb128 .LEHB55-.LFB4172
	.uleb128 .LEHE55-.LEHB55
	.uleb128 .L677-.LFB4172
	.uleb128 0
	.uleb128 .LEHB56-.LFB4172
	.uleb128 .LEHE56-.LEHB56
	.uleb128 .L678-.LFB4172
	.uleb128 0
	.uleb128 .LEHB57-.LFB4172
	.uleb128 .LEHE57-.LEHB57
	.uleb128 .L670-.LFB4172
	.uleb128 0
	.uleb128 .LEHB58-.LFB4172
	.uleb128 .LEHE58-.LEHB58
	.uleb128 .L679-.LFB4172
	.uleb128 0
	.uleb128 .LEHB59-.LFB4172
	.uleb128 .LEHE59-.LEHB59
	.uleb128 .L669-.LFB4172
	.uleb128 0
.LLSDACSE4172:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4172
	.type	_ZN12ParseFormula8parseIffEv.cold, @function
_ZN12ParseFormula8parseIffEv.cold:
.LFSB4172:
.L658:
	.cfi_def_cfa_offset 432
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	56(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L664
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L664:
	movq	%r13, %rdi
	movq	%r14, %r13
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
.L653:
	movq	%r12, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	%rbx, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L666
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L666:
	movq	24(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L667
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L667:
	movq	%r13, %rdi
.LEHB60:
	call	_Unwind_Resume@PLT
.LEHE60:
.L654:
	movq	264(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L656
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L656:
	movq	56(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L657
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L657:
	leaq	64(%rsp), %rbp
	jmp	.L653
.L649:
	movq	264(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L656
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	jmp	.L656
.L661:
	movq	56(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L664
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	jmp	.L664
	.cfi_endproc
.LFE4172:
	.section	.gcc_except_table
.LLSDAC4172:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4172-.LLSDACSBC4172
.LLSDACSBC4172:
	.uleb128 .LEHB60-.LCOLDB13
	.uleb128 .LEHE60-.LEHB60
	.uleb128 0
	.uleb128 0
.LLSDACSEC4172:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormula8parseIffEv, .-_ZN12ParseFormula8parseIffEv
	.section	.text.unlikely
	.size	_ZN12ParseFormula8parseIffEv.cold, .-_ZN12ParseFormula8parseIffEv.cold
.LCOLDE13:
	.text
.LHOTE13:
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"Unexpected character at position "
	.align 8
.LC15:
	.string	" got end of file but expected )"
	.section	.rodata.str1.1
.LC16:
	.string	" got "
.LC17:
	.string	" but expected )"
.LC18:
	.string	"-"
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	" got end of file but expected ]"
	.section	.rodata.str1.1
.LC20:
	.string	" but expected ]"
.LC21:
	.string	""
.LC22:
	.string	"stoi"
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	" got end of file but expected >"
	.section	.rodata.str1.1
.LC24:
	.string	" but expected >"
.LC25:
	.string	"$true"
.LC26:
	.string	"$false"
.LC27:
	.string	"Unexpected end of file"
	.section	.text.unlikely
	.align 2
.LCOLDB28:
	.text
.LHOTB28:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula9parseRestEv
	.type	_ZN12ParseFormula9parseRestEv, @function
_ZN12ParseFormula9parseRestEv:
.LFB4124:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4124
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$296, %rsp
	.cfi_def_cfa_offset 352
	movq	32(%rsi), %r15
	movq	40(%rsi), %r13
	movq	%fs:40, %rax
	movq	%rax, 280(%rsp)
	xorl	%eax, %eax
	jmp	.L740
	.p2align 4,,10
	.p2align 3
.L1246:
	movq	(%r15), %rbx
	movsbl	(%rbx,%r13), %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%r13), %rax
	testl	%r8d, %r8d
	je	.L1245
.L742:
	movq	%rax, 40(%rbp)
	movq	%rax, %r13
.L740:
	movq	8(%r15), %r14
	cmpq	%r13, %r14
	ja	.L1246
	movl	$37, %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%r13), %rax
	testl	%r8d, %r8d
	jne	.L742
	jmp	.L744
	.p2align 4,,10
	.p2align 3
.L1245:
	movzbl	(%rbx,%r13), %edx
	cmpb	$40, %dl
	je	.L1247
	cmpb	$91, %dl
	je	.L1248
	cmpb	$60, %dl
	je	.L1249
	cmpb	$126, %dl
	je	.L1250
.L744:
	cmpq	%r13, %r14
	jb	.L1251
	movq	8(%r15), %rcx
	leaq	224(%rsp), %rbx
	movq	%rbx, 208(%rsp)
	movq	(%r15), %rdx
	cmpq	%rcx, %r13
	ja	.L1252
	subq	%r13, %rcx
	movl	$5, %eax
	addq	%r13, %rdx
	cmpq	%rax, %rcx
	movq	%rdx, %rsi
	cmovbe	%rcx, %rax
	addq	%rax, %rsi
	je	.L898
	testq	%rdx, %rdx
	je	.L907
.L898:
	cmpq	$1, %rcx
	je	.L1253
	testq	%rcx, %rcx
	jne	.L1254
.L900:
	leaq	208(%rsp), %r15
	leaq	.LC25(%rip), %rsi
	movq	%rax, 216(%rsp)
	movq	%r15, %rdi
	movb	$0, 224(%rsp,%rax)
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc@PLT
	movq	208(%rsp), %rdi
	movl	%eax, %r13d
	cmpq	%rbx, %rdi
	je	.L903
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L903:
	movq	40(%rbp), %rdx
	testl	%r13d, %r13d
	jne	.L904
	addq	$5, %rdx
	movq	%r12, %rdi
	movq	%rdx, 40(%rbp)
.LEHB61:
	call	_ZN4True6createEv@PLT
.LEHE61:
.L739:
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1255
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L904:
	.cfi_restore_state
	movq	32(%rbp), %rax
	movq	8(%rax), %rcx
	cmpq	%rdx, %rcx
	jb	.L1256
	movq	8(%rax), %rcx
	leaq	256(%rsp), %rsi
	movq	%rsi, 8(%rsp)
	movq	%rsi, 240(%rsp)
	movq	(%rax), %rsi
	cmpq	%rdx, %rcx
	jb	.L1257
	subq	%rdx, %rcx
	movl	$6, %eax
	addq	%rdx, %rsi
	cmpq	%rax, %rcx
	movq	%rsi, %rdx
	cmovbe	%rcx, %rax
	addq	%rax, %rdx
	je	.L1080
	testq	%rsi, %rsi
	je	.L907
.L1080:
	cmpq	$1, %rcx
	je	.L1258
	testq	%rcx, %rcx
	je	.L910
	movl	%eax, %r8d
	testl	%eax, %eax
	je	.L910
	xorl	%edx, %edx
.L911:
	movl	%edx, %ecx
	movq	8(%rsp), %r9
	addl	$1, %edx
	movzbl	(%rsi,%rcx), %edi
	movb	%dil, (%r9,%rcx)
	cmpl	%r8d, %edx
	jb	.L911
	jmp	.L910
	.p2align 4,,10
	.p2align 3
.L1248:
	leaq	80(%rsp), %rcx
	movq	%rax, 40(%rbp)
	leaq	96(%rsp), %r14
	movq	%rax, %rdx
	movq	%rcx, (%rsp)
	movq	$0, 88(%rsp)
	movb	$0, 96(%rsp)
	movq	8(%r15), %rcx
	movq	%r14, 80(%rsp)
	cmpq	%rcx, %rax
	jnb	.L771
	movq	(%r15), %rsi
	cmpb	$45, (%rsi,%rax)
	jne	.L1185
	jmp	.L1259
	.p2align 4,,10
	.p2align 3
.L1262:
	movq	(%r15), %rax
	movsbl	(%rax,%rdx), %eax
	movl	%eax, %r13d
	subl	$48, %eax
	cmpl	$9, %eax
	ja	.L1260
	movq	80(%rsp), %rax
	movq	88(%rsp), %rbx
	movl	$15, %edx
	cmpq	%r14, %rax
	cmovne	96(%rsp), %rdx
	leaq	1(%rbx), %r15
	cmpq	%rdx, %r15
	ja	.L1261
.L769:
	movb	%r13b, (%rax,%rbx)
	movq	80(%rsp), %rax
	movq	%r15, 88(%rsp)
	movb	$0, 1(%rax,%rbx)
.L1189:
	movq	40(%rbp), %rax
	movq	32(%rbp), %r15
	leaq	1(%rax), %rdx
	movq	%rdx, 40(%rbp)
	movq	8(%r15), %rcx
.L1185:
	cmpq	%rcx, %rdx
	jb	.L1262
.L771:
	movl	$16, %edi
	leaq	176(%rsp), %r12
	call	__cxa_allocate_exception@PLT
	movq	40(%rbp), %rsi
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB62:
	call	_ZNSt7__cxx119to_stringEm
.LEHE62:
	jmp	.L1178
	.p2align 4,,10
	.p2align 3
.L1254:
	movl	%eax, %r8d
	testl	%eax, %eax
	je	.L900
	xorl	%ecx, %ecx
.L901:
	movl	%ecx, %esi
	addl	$1, %ecx
	movzbl	(%rdx,%rsi), %edi
	movb	%dil, (%rbx,%rsi)
	cmpl	%r8d, %ecx
	jb	.L901
	jmp	.L900
.L1258:
	movzbl	(%rsi), %edx
	movb	%dl, 256(%rsp)
.L910:
	movq	%rax, 248(%rsp)
	leaq	.LC26(%rip), %rsi
	movb	$0, 256(%rsp,%rax)
	leaq	240(%rsp), %rax
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc@PLT
	movq	240(%rsp), %rdi
	movl	%eax, %r13d
	cmpq	8(%rsp), %rdi
	je	.L913
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L913:
	movq	40(%rbp), %rdx
	testl	%r13d, %r13d
	je	.L1263
	movq	32(%rbp), %rcx
	cmpq	%rdx, 8(%rcx)
	jbe	.L915
	movq	(%rcx), %rax
	movq	%rcx, 16(%rsp)
	movq	%rdx, (%rsp)
	movsbl	(%rax,%rdx), %edi
	movl	%edi, %r13d
	call	isalnum@PLT
	movq	(%rsp), %rdx
	movq	16(%rsp), %rcx
	testl	%eax, %eax
	jne	.L916
	cmpb	$95, %r13b
	jne	.L917
.L916:
	movq	%rbx, 208(%rsp)
	leaq	224(%rsp), %rbx
	xorl	%r13d, %r13d
	movq	$0, 216(%rsp)
	movq	%rbx, %r14
	movb	$0, 224(%rsp)
	cmpq	%rdx, 8(%rcx)
	jbe	.L921
.L1265:
	movq	(%rcx), %rax
	movsbl	(%rax,%rdx), %edi
	movb	%dil, (%rsp)
	call	isalnum@PLT
	testl	%eax, %eax
	jne	.L922
	cmpb	$95, (%rsp)
	jne	.L1017
.L922:
	cmpq	%rbx, %r14
	movl	$15, %eax
	leaq	1(%r13), %rsi
	cmovne	224(%rsp), %rax
	movq	%rsi, 16(%rsp)
	cmpq	%rax, %rsi
	ja	.L1264
.L920:
	movzbl	(%rsp), %eax
	movq	16(%rsp), %rcx
	movb	%al, (%r14,%r13)
	movq	208(%rsp), %rax
	movq	%rcx, 216(%rsp)
	movb	$0, (%rax,%rcx)
	movq	40(%rbp), %rax
	movq	32(%rbp), %rcx
	movq	216(%rsp), %r13
	leaq	1(%rax), %rdx
	movq	208(%rsp), %r14
	movq	%rdx, 40(%rbp)
	cmpq	%rdx, 8(%rcx)
	ja	.L1265
.L921:
	movl	$37, %edi
	call	isalnum@PLT
	testl	%eax, %eax
	jne	.L1266
.L1017:
	movq	8(%rsp), %rax
	movq	%rax, 240(%rsp)
	movq	%r14, %rax
	addq	%r13, %rax
	je	.L923
	testq	%r14, %r14
	je	.L1267
.L923:
	movq	%r13, 64(%rsp)
	cmpq	$15, %r13
	ja	.L1268
	cmpq	$1, %r13
	jne	.L926
	movzbl	(%r14), %eax
	movb	%al, 256(%rsp)
	movq	8(%rsp), %rax
.L927:
	movq	%r13, 248(%rsp)
	movq	24(%rsp), %rsi
	movq	%r12, %rdi
	movb	$0, (%rax,%r13)
.LEHB63:
	call	_ZN4Atom6createENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE63:
	movq	240(%rsp), %rdi
	cmpq	8(%rsp), %rdi
	je	.L928
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L928:
	movq	208(%rsp), %rdi
	cmpq	%rbx, %rdi
	je	.L739
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L739
	.p2align 4,,10
	.p2align 3
.L1261:
	movq	(%rsp), %rdi
	movl	$1, %r8d
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbx, %rsi
.LEHB64:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm@PLT
	movq	80(%rsp), %rax
	jmp	.L769
.L1260:
	cmpq	%rdx, %rcx
	jbe	.L771
	cmpb	$93, %r13b
	jne	.L1175
	addq	$1, %rdx
	leaq	64(%rsp), %r13
	movq	%rbp, %rsi
	movq	%rdx, 40(%rbp)
	movq	%r13, %rdi
	call	_ZN12ParseFormula9parseRestEv
.LEHE64:
	movq	(%rsp), %rdi
	leaq	.LC21(%rip), %rsi
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc@PLT
	movq	64(%rsp), %rdi
	testl	%eax, %eax
	movq	(%rdi), %rax
	jne	.L783
.LEHB65:
	call	*24(%rax)
	cmpl	$2, %eax
	jne	.L784
	movq	64(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L785
	movq	%rbp, %rdi
	xorl	%ecx, %ecx
	leaq	_ZTI3Box(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rbp
.L785:
	movq	%rbp, %rdi
	call	_ZNK3Box11getModalityEv@PLT
	cmpl	$1, %eax
	jne	.L784
	movq	%rbp, %rdi
	call	_ZN3Box14incrementPowerEv@PLT
	movdqa	64(%rsp), %xmm3
	movups	%xmm3, (%r12)
	jmp	.L885
.L784:
	movq	%r13, %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%r12, %rdi
	call	_ZN3Box6createEiiRKSt10shared_ptrI7FormulaE@PLT
.LEHE65:
.L787:
	movq	72(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L885
.L1237:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L879
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L880:
	cmpl	$1, %eax
	je	.L1269
.L885:
	movq	80(%rsp), %rdi
	cmpq	%r14, %rdi
	je	.L739
	movq	96(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L739
	.p2align 4,,10
	.p2align 3
.L1253:
	movzbl	(%rdx), %edx
	movb	%dl, 224(%rsp)
	jmp	.L900
	.p2align 4,,10
	.p2align 3
.L1249:
	leaq	80(%rsp), %rcx
	movq	%rax, 40(%rbp)
	leaq	96(%rsp), %r14
	movq	%rax, %rdx
	movq	%rcx, (%rsp)
	movq	$0, 88(%rsp)
	movb	$0, 96(%rsp)
	movq	8(%r15), %rcx
	movq	%r14, 80(%rsp)
	cmpq	%rcx, %rax
	jnb	.L815
	movq	(%r15), %rsi
	cmpb	$45, (%rsi,%rax)
	je	.L1270
.L815:
	cmpq	%rdx, %rcx
	jbe	.L817
	.p2align 4,,10
	.p2align 3
.L816:
	movq	(%r15), %rax
	movsbl	(%rax,%rdx), %eax
	movl	%eax, %r13d
	subl	$48, %eax
	cmpl	$9, %eax
	ja	.L1271
	movq	80(%rsp), %rax
	movq	88(%rsp), %rbx
	movl	$15, %edx
	cmpq	%r14, %rax
	cmovne	96(%rsp), %rdx
	leaq	1(%rbx), %r15
	cmpq	%rdx, %r15
	ja	.L1272
.L819:
	movb	%r13b, (%rax,%rbx)
	movq	80(%rsp), %rax
	movq	%r15, 88(%rsp)
	movb	$0, 1(%rax,%rbx)
	movq	40(%rbp), %rax
	movq	32(%rbp), %r15
	leaq	1(%rax), %rdx
	movq	%rdx, 40(%rbp)
	movq	8(%r15), %rcx
	cmpq	%rcx, %rdx
	jb	.L816
.L817:
	movl	$16, %edi
	leaq	176(%rsp), %r12
	call	__cxa_allocate_exception@PLT
	movq	40(%rbp), %rsi
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB66:
	call	_ZNSt7__cxx119to_stringEm
.LEHE66:
	jmp	.L1176
	.p2align 4,,10
	.p2align 3
.L1272:
	movq	(%rsp), %rdi
	movl	$1, %r8d
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rbx, %rsi
.LEHB67:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm@PLT
	movq	80(%rsp), %rax
	jmp	.L819
.L1271:
	cmpq	%rcx, %rdx
	jnb	.L817
	cmpb	$62, %r13b
	jne	.L1177
	addq	$1, %rdx
	leaq	48(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%rdx, 40(%rbp)
	call	_ZN12ParseFormula9parseRestEv
.LEHE67:
	movq	(%rsp), %rdi
	leaq	.LC21(%rip), %rsi
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc@PLT
	movq	48(%rsp), %rdi
	testl	%eax, %eax
	movq	(%rdi), %rax
	jne	.L833
.LEHB68:
	call	*24(%rax)
	movq	48(%rsp), %rbp
	cmpl	$3, %eax
	jne	.L834
	testq	%rbp, %rbp
	je	.L835
	movq	%rbp, %rdi
	xorl	%ecx, %ecx
	leaq	_ZTI7Diamond(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rbp
.L835:
	movq	%rbp, %rdi
	call	_ZNK7Diamond11getModalityEv@PLT
	cmpl	$1, %eax
	jne	.L834
	movq	%rbp, %rdi
	call	_ZN7Diamond14incrementPowerEv@PLT
.LEHE68:
	movdqa	48(%rsp), %xmm5
	movups	%xmm5, (%r12)
	jmp	.L885
.L834:
	movdqa	48(%rsp), %xmm1
	movq	56(%rsp), %rax
	movaps	%xmm1, 64(%rsp)
	testq	%rax, %rax
	je	.L837
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L838
	addl	$1, 8(%rax)
.L837:
	leaq	64(%rsp), %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%r12, %rdi
.LEHB69:
	call	_ZN7Diamond6createEiiSt10shared_ptrI7FormulaE@PLT
.LEHE69:
.L1183:
	movq	72(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L848
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L872
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L873:
	cmpl	$1, %eax
	jne	.L848
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1273
.L875:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L876
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L877:
	cmpl	$1, %eax
	jne	.L848
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L878
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L848:
	movq	56(%rsp), %rbp
	testq	%rbp, %rbp
	jne	.L1237
	jmp	.L885
	.p2align 4,,10
	.p2align 3
.L1264:
	movl	$1, %r8d
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%r13, %rsi
	movq	%r15, %rdi
.LEHB70:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm@PLT
.LEHE70:
	movq	208(%rsp), %r14
	jmp	.L920
	.p2align 4,,10
	.p2align 3
.L1247:
	movq	%rax, 40(%rbp)
	leaq	64(%rsp), %rdi
	movq	%rbp, %rsi
.LEHB71:
	call	_ZN12ParseFormula8parseIffEv
.LEHE71:
	movq	32(%rbp), %r13
	movq	40(%rbp), %rbx
	jmp	.L746
	.p2align 4,,10
	.p2align 3
.L1275:
	movq	0(%r13), %r14
	movsbl	(%r14,%rbx), %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%rbx), %rax
	testl	%r8d, %r8d
	je	.L1274
.L748:
	movq	%rax, 40(%rbp)
	movq	%rax, %rbx
.L746:
	cmpq	%rbx, 8(%r13)
	ja	.L1275
	movl	$37, %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%rbx), %rax
	testl	%r8d, %r8d
	jne	.L748
	jmp	.L750
.L1274:
	movzbl	(%r14,%rbx), %edx
	cmpb	$41, %dl
	jne	.L1174
	movdqa	64(%rsp), %xmm0
	movq	%rax, 40(%rbp)
	movups	%xmm0, (%r12)
	jmp	.L739
	.p2align 4,,10
	.p2align 3
.L783:
.LEHB72:
	call	*24(%rax)
	cmpl	$2, %eax
	jne	.L788
	movq	64(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L789
	movq	%rbp, %rdi
	xorl	%ecx, %ecx
	leaq	_ZTI3Box(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rbp
.L789:
	movq	%rbp, %rdi
	call	_ZNK3Box11getModalityEv@PLT
	movl	%eax, (%rsp)
	movq	80(%rsp), %r15
	call	__errno_location@PLT
	leaq	48(%rsp), %rsi
	movl	$10, %edx
	movq	%rax, %rbx
	movl	(%rax), %eax
	movq	%r15, %rdi
	movq	%rsi, 8(%rsp)
	movl	$0, (%rbx)
	movl	%eax, 16(%rsp)
	call	strtol@PLT
	cmpq	48(%rsp), %r15
	movq	8(%rsp), %rsi
	je	.L1276
	movl	(%rbx), %r15d
	cmpl	$34, %r15d
	je	.L791
	movl	$2147483648, %edx
	addq	%rax, %rdx
	shrq	$32, %rdx
	jne	.L791
	testl	%r15d, %r15d
	jne	.L793
	movl	16(%rsp), %ecx
	movl	%ecx, (%rbx)
	movl	%ecx, %r15d
.L793:
	cmpl	%eax, (%rsp)
	je	.L1277
.L795:
	movq	80(%rsp), %rbp
	movl	$0, (%rbx)
	movl	$10, %edx
	movq	%rbp, %rdi
	call	strtol@PLT
	cmpq	48(%rsp), %rbp
	je	.L1278
	movl	(%rbx), %ecx
	cmpl	$34, %ecx
	je	.L800
	movl	$2147483648, %edx
	addq	%rax, %rdx
	shrq	$32, %rdx
	jne	.L800
	movl	%eax, %esi
	testl	%ecx, %ecx
	jne	.L802
	movl	%r15d, (%rbx)
.L802:
	movq	%r13, %rcx
	movl	$1, %edx
	movq	%r12, %rdi
	call	_ZN3Box6createEiiRKSt10shared_ptrI7FormulaE@PLT
.LEHE72:
	jmp	.L787
.L1263:
	addq	$6, %rdx
	movq	%r12, %rdi
	movq	%rdx, 40(%rbp)
.LEHB73:
	call	_ZN5False6createEv@PLT
.LEHE73:
	jmp	.L739
.L833:
.LEHB74:
	call	*24(%rax)
	movq	48(%rsp), %rbp
	cmpl	$3, %eax
	jne	.L849
	testq	%rbp, %rbp
	je	.L850
	movq	%rbp, %rdi
	xorl	%ecx, %ecx
	leaq	_ZTI7Diamond(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rbp
.L850:
	movq	%rbp, %rdi
	call	_ZNK7Diamond11getModalityEv@PLT
.LEHE74:
	movl	%eax, %r13d
	movq	80(%rsp), %r15
	call	__errno_location@PLT
	leaq	64(%rsp), %rsi
	movl	$10, %edx
	movq	%rax, %rbx
	movl	(%rax), %eax
	movq	%r15, %rdi
	movl	$0, (%rbx)
	movl	%eax, (%rsp)
	call	strtol@PLT
	cmpq	64(%rsp), %r15
	je	.L1279
	movl	(%rbx), %ecx
	cmpl	$34, %ecx
	je	.L852
	movl	$2147483648, %edx
	addq	%rax, %rdx
	shrq	$32, %rdx
	jne	.L852
	testl	%ecx, %ecx
	jne	.L854
	movl	(%rsp), %esi
	movl	%esi, (%rbx)
.L854:
	cmpl	%eax, %r13d
	je	.L1280
.L856:
	movdqa	48(%rsp), %xmm2
	movq	56(%rsp), %rax
	movaps	%xmm2, 64(%rsp)
	testq	%rax, %rax
	je	.L860
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L861
	addl	$1, 8(%rax)
.L860:
	movq	80(%rsp), %rbp
	movl	(%rbx), %r13d
	movl	$0, (%rbx)
	leaq	40(%rsp), %rsi
	movl	$10, %edx
	movq	%rbp, %rdi
	call	strtol@PLT
	cmpq	40(%rsp), %rbp
	je	.L1281
	movl	(%rbx), %ecx
	cmpl	$34, %ecx
	je	.L863
	movl	$2147483648, %edx
	addq	%rax, %rdx
	shrq	$32, %rdx
	jne	.L863
	movl	%eax, %esi
	testl	%ecx, %ecx
	jne	.L865
	movl	%r13d, (%rbx)
.L865:
	leaq	64(%rsp), %rcx
	movl	$1, %edx
	movq	%r12, %rdi
.LEHB75:
	call	_ZN7Diamond6createEiiSt10shared_ptrI7FormulaE@PLT
.LEHE75:
	jmp	.L1183
.L1250:
	movq	%rax, 40(%rbp)
	leaq	64(%rsp), %r13
	movq	%rbp, %rsi
	movq	%r13, %rdi
.LEHB76:
	call	_ZN12ParseFormula9parseRestEv
.LEHE76:
	movq	%r13, %rsi
	movq	%r12, %rdi
.LEHB77:
	call	_ZN3Not6createESt10shared_ptrI7FormulaE@PLT
.LEHE77:
	movq	72(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L739
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L889
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L890:
	cmpl	$1, %eax
	jne	.L739
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1282
.L892:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L893
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L894:
	cmpl	$1, %eax
	jne	.L739
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L895
	call	*8(%rdx)
	jmp	.L739
	.p2align 4,,10
	.p2align 3
.L1266:
	movb	$37, (%rsp)
	jmp	.L922
.L1269:
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1283
.L881:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L882
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L883:
	cmpl	$1, %eax
	jne	.L885
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L884
	call	*8(%rdx)
	jmp	.L885
.L879:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L880
.L915:
	movl	$37, %edi
	movq	%rcx, 16(%rsp)
	movq	%rdx, (%rsp)
	call	isalnum@PLT
	movq	(%rsp), %rdx
	movq	16(%rsp), %rcx
	testl	%eax, %eax
	jne	.L916
	jmp	.L1018
	.p2align 4,,10
	.p2align 3
.L926:
	testq	%r13, %r13
	jne	.L1284
	movq	8(%rsp), %rax
	jmp	.L927
.L1268:
	movq	24(%rsp), %rdi
	leaq	64(%rsp), %rsi
	xorl	%edx, %edx
.LEHB78:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm@PLT
.LEHE78:
	movq	%rax, 240(%rsp)
	movq	%rax, %rdi
	movq	64(%rsp), %rax
	movq	%rax, 256(%rsp)
.L925:
	movq	%r13, %rdx
	movq	%r14, %rsi
	call	memcpy@PLT
	movq	64(%rsp), %r13
	movq	240(%rsp), %rax
	jmp	.L927
.L788:
	call	__errno_location@PLT
	leaq	48(%rsp), %rsi
	movl	(%rax), %r15d
	movq	%rax, %rbx
	jmp	.L795
.L849:
	call	__errno_location@PLT
	movq	%rax, %rbx
	jmp	.L856
.L872:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L873
.L882:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L883
.L1283:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L881
.L1259:
	movq	(%rsp), %rdi
	movl	$1, %r8d
	xorl	%edx, %edx
	xorl	%esi, %esi
	leaq	.LC18(%rip), %rcx
.LEHB79:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm@PLT
.LEHE79:
	jmp	.L1189
.L1270:
	movq	(%rsp), %rdi
	movl	$1, %r8d
	xorl	%edx, %edx
	xorl	%esi, %esi
	leaq	.LC18(%rip), %rcx
.LEHB80:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm@PLT
.LEHE80:
	movq	40(%rbp), %rax
	movq	32(%rbp), %r15
	leaq	1(%rax), %rdx
	movq	%rdx, 40(%rbp)
	movq	8(%r15), %rcx
	jmp	.L815
.L838:
	lock addl	$1, 8(%rax)
	jmp	.L837
.L861:
	lock addl	$1, 8(%rax)
	jmp	.L860
.L889:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L890
.L1277:
	movq	%rbp, %rdi
.LEHB81:
	call	_ZN3Box14incrementPowerEv@PLT
.LEHE81:
	movdqa	64(%rsp), %xmm4
	movups	%xmm4, (%r12)
	jmp	.L885
.L876:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L877
.L1280:
	movq	%rbp, %rdi
.LEHB82:
	call	_ZN7Diamond14incrementPowerEv@PLT
.LEHE82:
	movdqa	48(%rsp), %xmm6
	movups	%xmm6, (%r12)
	jmp	.L885
.L893:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L894
.L1273:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L875
.L884:
	call	*%rax
	jmp	.L885
.L1282:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L892
.L878:
	call	*%rax
	jmp	.L848
.L895:
	call	*%rax
	jmp	.L739
.L1281:
	leaq	.LC22(%rip), %rdi
.LEHB83:
	call	_ZSt24__throw_invalid_argumentPKc@PLT
.LEHE83:
.L852:
	leaq	.LC22(%rip), %rdi
.LEHB84:
	call	_ZSt20__throw_out_of_rangePKc@PLT
.LEHE84:
.L791:
	leaq	.LC22(%rip), %rdi
.LEHB85:
	call	_ZSt20__throw_out_of_rangePKc@PLT
.LEHE85:
.L1267:
	leaq	.LC8(%rip), %rdi
.LEHB86:
	call	_ZSt19__throw_logic_errorPKc@PLT
.LEHE86:
.L1252:
	movq	%r13, %rdx
	leaq	.LC7(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
.LEHB87:
	call	_ZSt24__throw_out_of_range_fmtPKcz@PLT
.L907:
	leaq	.LC8(%rip), %rdi
	call	_ZSt19__throw_logic_errorPKc@PLT
.L1251:
	movq	%r14, %rcx
	movq	%r13, %rdx
	leaq	.LC5(%rip), %rsi
	xorl	%eax, %eax
	leaq	.LC6(%rip), %rdi
	call	_ZSt24__throw_out_of_range_fmtPKcz@PLT
.L1255:
	call	__stack_chk_fail@PLT
.L1256:
	leaq	.LC5(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	_ZSt24__throw_out_of_range_fmtPKcz@PLT
.L1257:
	leaq	.LC7(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	_ZSt24__throw_out_of_range_fmtPKcz@PLT
.LEHE87:
.L1284:
	movq	8(%rsp), %rdi
	jmp	.L925
.L863:
	leaq	.LC22(%rip), %rdi
.LEHB88:
	call	_ZSt20__throw_out_of_rangePKc@PLT
.LEHE88:
.L1276:
	leaq	.LC22(%rip), %rdi
.LEHB89:
	call	_ZSt24__throw_invalid_argumentPKc@PLT
.LEHE89:
.L800:
	leaq	.LC22(%rip), %rdi
.LEHB90:
	call	_ZSt20__throw_out_of_rangePKc@PLT
.LEHE90:
.L1279:
	leaq	.LC22(%rip), %rdi
.LEHB91:
	call	_ZSt24__throw_invalid_argumentPKc@PLT
.LEHE91:
.L1278:
	leaq	.LC22(%rip), %rdi
.LEHB92:
	call	_ZSt24__throw_invalid_argumentPKc@PLT
.LEHE92:
.L1079:
	endbr64
	movq	%rax, %rbp
	jmp	.L867
.L1064:
	endbr64
	movq	%rax, %rbp
	jmp	.L859
.L1067:
	endbr64
	movq	%rax, %rbp
	jmp	.L1001
.L1065:
	endbr64
	movq	%rax, %rbp
	jmp	.L996
.L1172:
	endbr64
	jmp	.L1173
.L1077:
	endbr64
	movq	%rax, %rbp
	jmp	.L803
.L1078:
	endbr64
	movq	%rax, %rbp
	jmp	.L857
.L1068:
	endbr64
	movq	%rax, %rbp
	jmp	.L1005
.L1052:
	endbr64
	movq	%rax, %rbp
	jmp	.L798
.L1066:
	endbr64
	movq	%rax, %rbp
	jmp	.L869
.L1042:
	endbr64
.L1207:
	movq	%rax, %rbx
	jmp	.L995
.L1170:
	endbr64
	jmp	.L1173
.L1069:
	endbr64
	movq	%rax, %rbp
	jmp	.L1003
.L1076:
	endbr64
	movq	%rax, %rbp
	jmp	.L796
.L1054:
	endbr64
	jmp	.L1207
	.section	.gcc_except_table
.LLSDA4124:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4124-.LLSDACSB4124
.LLSDACSB4124:
	.uleb128 .LEHB61-.LFB4124
	.uleb128 .LEHE61-.LEHB61
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB62-.LFB4124
	.uleb128 .LEHE62-.LEHB62
	.uleb128 .L1042-.LFB4124
	.uleb128 0
	.uleb128 .LEHB63-.LFB4124
	.uleb128 .LEHE63-.LEHB63
	.uleb128 .L1069-.LFB4124
	.uleb128 0
	.uleb128 .LEHB64-.LFB4124
	.uleb128 .LEHE64-.LEHB64
	.uleb128 .L1170-.LFB4124
	.uleb128 0
	.uleb128 .LEHB65-.LFB4124
	.uleb128 .LEHE65-.LEHB65
	.uleb128 .L1052-.LFB4124
	.uleb128 0
	.uleb128 .LEHB66-.LFB4124
	.uleb128 .LEHE66-.LEHB66
	.uleb128 .L1054-.LFB4124
	.uleb128 0
	.uleb128 .LEHB67-.LFB4124
	.uleb128 .LEHE67-.LEHB67
	.uleb128 .L1172-.LFB4124
	.uleb128 0
	.uleb128 .LEHB68-.LFB4124
	.uleb128 .LEHE68-.LEHB68
	.uleb128 .L1064-.LFB4124
	.uleb128 0
	.uleb128 .LEHB69-.LFB4124
	.uleb128 .LEHE69-.LEHB69
	.uleb128 .L1065-.LFB4124
	.uleb128 0
	.uleb128 .LEHB70-.LFB4124
	.uleb128 .LEHE70-.LEHB70
	.uleb128 .L1068-.LFB4124
	.uleb128 0
	.uleb128 .LEHB71-.LFB4124
	.uleb128 .LEHE71-.LEHB71
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB72-.LFB4124
	.uleb128 .LEHE72-.LEHB72
	.uleb128 .L1052-.LFB4124
	.uleb128 0
	.uleb128 .LEHB73-.LFB4124
	.uleb128 .LEHE73-.LEHB73
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB74-.LFB4124
	.uleb128 .LEHE74-.LEHB74
	.uleb128 .L1064-.LFB4124
	.uleb128 0
	.uleb128 .LEHB75-.LFB4124
	.uleb128 .LEHE75-.LEHB75
	.uleb128 .L1066-.LFB4124
	.uleb128 0
	.uleb128 .LEHB76-.LFB4124
	.uleb128 .LEHE76-.LEHB76
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB77-.LFB4124
	.uleb128 .LEHE77-.LEHB77
	.uleb128 .L1067-.LFB4124
	.uleb128 0
	.uleb128 .LEHB78-.LFB4124
	.uleb128 .LEHE78-.LEHB78
	.uleb128 .L1068-.LFB4124
	.uleb128 0
	.uleb128 .LEHB79-.LFB4124
	.uleb128 .LEHE79-.LEHB79
	.uleb128 .L1170-.LFB4124
	.uleb128 0
	.uleb128 .LEHB80-.LFB4124
	.uleb128 .LEHE80-.LEHB80
	.uleb128 .L1172-.LFB4124
	.uleb128 0
	.uleb128 .LEHB81-.LFB4124
	.uleb128 .LEHE81-.LEHB81
	.uleb128 .L1052-.LFB4124
	.uleb128 0
	.uleb128 .LEHB82-.LFB4124
	.uleb128 .LEHE82-.LEHB82
	.uleb128 .L1064-.LFB4124
	.uleb128 0
	.uleb128 .LEHB83-.LFB4124
	.uleb128 .LEHE83-.LEHB83
	.uleb128 .L1079-.LFB4124
	.uleb128 0
	.uleb128 .LEHB84-.LFB4124
	.uleb128 .LEHE84-.LEHB84
	.uleb128 .L1078-.LFB4124
	.uleb128 0
	.uleb128 .LEHB85-.LFB4124
	.uleb128 .LEHE85-.LEHB85
	.uleb128 .L1076-.LFB4124
	.uleb128 0
	.uleb128 .LEHB86-.LFB4124
	.uleb128 .LEHE86-.LEHB86
	.uleb128 .L1068-.LFB4124
	.uleb128 0
	.uleb128 .LEHB87-.LFB4124
	.uleb128 .LEHE87-.LEHB87
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB88-.LFB4124
	.uleb128 .LEHE88-.LEHB88
	.uleb128 .L1079-.LFB4124
	.uleb128 0
	.uleb128 .LEHB89-.LFB4124
	.uleb128 .LEHE89-.LEHB89
	.uleb128 .L1076-.LFB4124
	.uleb128 0
	.uleb128 .LEHB90-.LFB4124
	.uleb128 .LEHE90-.LEHB90
	.uleb128 .L1077-.LFB4124
	.uleb128 0
	.uleb128 .LEHB91-.LFB4124
	.uleb128 .LEHE91-.LEHB91
	.uleb128 .L1078-.LFB4124
	.uleb128 0
	.uleb128 .LEHB92-.LFB4124
	.uleb128 .LEHE92-.LEHB92
	.uleb128 .L1077-.LFB4124
	.uleb128 0
.LLSDACSE4124:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4124
	.type	_ZN12ParseFormula9parseRestEv.cold, @function
_ZN12ParseFormula9parseRestEv.cold:
.LFSB4124:
.L1177:
	.cfi_def_cfa_offset 352
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	cmpb	$37, %r13b
	jne	.L1182
	jmp	.L817
.L867:
	cmpl	$0, (%rbx)
	jne	.L869
	movl	%r13d, (%rbx)
.L869:
	movq	72(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L859
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L859:
	movq	56(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L984
.L1201:
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L984:
	movq	80(%rsp), %rdi
	cmpq	%r14, %rdi
	je	.L1006
	movq	96(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1006:
	movq	%rbp, %rdi
.LEHB93:
	call	_Unwind_Resume@PLT
.LEHE93:
.L917:
	cmpb	$37, %r13b
	jne	.L930
.L1018:
	movl	$16, %edi
	call	__cxa_allocate_exception@PLT
	leaq	.LC27(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbp
.LEHB94:
	call	_ZNSt13runtime_errorC1EPKc@PLT
.LEHE94:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%rbp, %rdi
.LEHB95:
	call	__cxa_throw@PLT
.L1001:
	movq	72(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1006
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	jmp	.L1006
.L1070:
	endbr64
	movq	%rax, %r12
	movq	%rbp, %rdi
	call	__cxa_free_exception@PLT
	movq	%r12, %rdi
	call	_Unwind_Resume@PLT
.LEHE95:
.L1182:
	movl	$16, %edi
	call	__cxa_allocate_exception@PLT
	movq	40(%rbp), %rsi
	movq	%rax, %r13
	movq	32(%rbp), %rax
	cmpq	8(%rax), %rsi
	jnb	.L1025
	movq	(%rax), %rax
	movzbl	(%rax,%rsi), %eax
.L827:
	leaq	112(%rsp), %r12
	movsbl	%al, %ebx
	movq	%r12, %rdi
.LEHB96:
	call	_ZNSt7__cxx119to_stringEm
.LEHE96:
	leaq	144(%rsp), %rbp
	movq	%r12, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%rbp, %rdi
.LEHB97:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
.LEHE97:
	leaq	176(%rsp), %r12
	leaq	.LC16(%rip), %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB98:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE98:
	leaq	208(%rsp), %r15
	movl	%ebx, %edx
	movq	%r12, %rsi
	movq	%r15, %rdi
.LEHB99:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_
.LEHE99:
	leaq	240(%rsp), %rax
	leaq	.LC24(%rip), %rdx
	movq	%r15, %rsi
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
.LEHB100:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE100:
	movq	24(%rsp), %rsi
	movq	%r13, %rdi
.LEHB101:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE101:
	movq	240(%rsp), %rdi
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L828
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L828:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L829
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L829:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L830
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L830:
	movq	144(%rsp), %rdi
	leaq	160(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L831
	movq	160(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L831:
	movq	112(%rsp), %rdi
	leaq	128(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L832
	movq	128(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L832:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%r13, %rdi
.LEHB102:
	call	__cxa_throw@PLT
.LEHE102:
.L1025:
	movl	$37, %eax
	jmp	.L827
.L1174:
	cmpb	$37, %dl
	jne	.L752
.L750:
	movl	$16, %edi
	leaq	176(%rsp), %r12
	call	__cxa_allocate_exception@PLT
	movq	40(%rbp), %rsi
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB103:
	call	_ZNSt7__cxx119to_stringEm
.LEHE103:
	leaq	208(%rsp), %r15
	movq	%r12, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%r15, %rdi
.LEHB104:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
.LEHE104:
	leaq	240(%rsp), %rax
	leaq	.LC15(%rip), %rdx
	movq	%r15, %rsi
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
.LEHB105:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE105:
	movq	24(%rsp), %rsi
	movq	%r13, %rdi
.LEHB106:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE106:
	movq	240(%rsp), %rdi
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L753
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L753:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L754
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L754:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L755
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L755:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%r13, %rdi
.LEHB107:
	call	__cxa_throw@PLT
.LEHE107:
.L996:
	movq	72(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L859
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	jmp	.L859
.L752:
	movl	$16, %edi
	call	__cxa_allocate_exception@PLT
	movq	40(%rbp), %rsi
	movq	%rax, %r13
	movq	32(%rbp), %rax
	cmpq	8(%rax), %rsi
	jnb	.L1021
	movq	(%rax), %rax
	movsbl	(%rax,%rsi), %r14d
.L756:
	leaq	112(%rsp), %r12
	movq	%r12, %rdi
.LEHB108:
	call	_ZNSt7__cxx119to_stringEm
.LEHE108:
	leaq	144(%rsp), %rbp
	movq	%r12, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%rbp, %rdi
.LEHB109:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
.LEHE109:
	leaq	176(%rsp), %r12
	leaq	.LC16(%rip), %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB110:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE110:
	leaq	208(%rsp), %r15
	movl	%r14d, %edx
	movq	%r12, %rsi
	movq	%r15, %rdi
.LEHB111:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_
.LEHE111:
	leaq	240(%rsp), %rax
	leaq	.LC17(%rip), %rdx
	movq	%r15, %rsi
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
.LEHB112:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE112:
	movq	24(%rsp), %rsi
	movq	%r13, %rdi
.LEHB113:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE113:
	movq	240(%rsp), %rdi
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L757
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L757:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L758
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L758:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L759
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L759:
	movq	144(%rsp), %rdi
	leaq	160(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L760
	movq	160(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L760:
	movq	112(%rsp), %rdi
	leaq	128(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L761
	movq	128(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L761:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%r13, %rdi
.LEHB114:
	call	__cxa_throw@PLT
.LEHE114:
.L1021:
	movl	$37, %r14d
	jmp	.L756
.L1053:
	endbr64
.L1173:
	movq	%rax, %rbp
	jmp	.L984
.L803:
	cmpl	$0, (%rbx)
	jne	.L798
	movl	%r15d, (%rbx)
.L798:
	movq	72(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1201
	jmp	.L984
.L1030:
	endbr64
	movq	%rax, %rbx
.L943:
	movq	72(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1188
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L1188:
	movq	%rbx, %rdi
.LEHB115:
	call	_Unwind_Resume@PLT
.LEHE115:
.L1040:
	endbr64
	movq	240(%rsp), %rdi
	movq	%rax, %rbx
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L946
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L946:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L948
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L948:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L950
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L950:
	movq	144(%rsp), %rdi
	leaq	160(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L952
	movq	160(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L952:
	movq	112(%rsp), %rdi
	leaq	128(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L954
	movq	128(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L954:
	movq	%r13, %rdi
	call	__cxa_free_exception@PLT
	jmp	.L943
.L1039:
	endbr64
	movq	%rax, %rbx
	jmp	.L946
.L1038:
	endbr64
	movq	%rax, %rbx
	jmp	.L948
.L1037:
	endbr64
	movq	%rax, %rbx
	jmp	.L950
.L1036:
	endbr64
	movq	%rax, %rbx
	jmp	.L952
.L1035:
	endbr64
.L1193:
	movq	%rax, %rbx
	jmp	.L954
.L857:
	cmpl	$0, (%rbx)
	jne	.L859
	movl	(%rsp), %eax
	movl	%eax, (%rbx)
	jmp	.L859
.L1032:
	endbr64
	movq	%rax, %rbx
.L940:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L954
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L954
.L1031:
	endbr64
	jmp	.L1193
.L1034:
	endbr64
	movq	240(%rsp), %rdi
	movq	%rax, %rbx
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L938
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L938:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L940
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L940
.L1003:
	movq	240(%rsp), %rdi
	cmpq	8(%rsp), %rdi
	je	.L1005
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1005:
	movq	208(%rsp), %rdi
	cmpq	%rbx, %rdi
	je	.L1006
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L1006
.L1033:
	endbr64
	movq	%rax, %rbx
	jmp	.L938
.L930:
	movl	$16, %edi
	call	__cxa_allocate_exception@PLT
	movq	40(%rbp), %rsi
	movq	%rax, %r13
	movq	32(%rbp), %rax
	cmpq	8(%rax), %rsi
	jnb	.L1028
	movq	(%rax), %rax
	movzbl	(%rax,%rsi), %eax
.L931:
	leaq	144(%rsp), %rbp
	movsbl	%al, %r14d
	movq	%rbp, %rdi
.LEHB116:
	call	_ZNSt7__cxx119to_stringEm
.LEHE116:
	leaq	176(%rsp), %r12
	movq	%rbp, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%r12, %rdi
.LEHB117:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
.LEHE117:
	leaq	.LC16(%rip), %rdx
	movq	%r12, %rsi
	movq	%r15, %rdi
.LEHB118:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE118:
	movq	24(%rsp), %rdi
	movl	%r14d, %edx
	movq	%r15, %rsi
.LEHB119:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_
.LEHE119:
	movq	24(%rsp), %rsi
	movq	%r13, %rdi
.LEHB120:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE120:
	movq	240(%rsp), %rdi
	cmpq	8(%rsp), %rdi
	je	.L932
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L932:
	movq	208(%rsp), %rdi
	cmpq	%rbx, %rdi
	je	.L933
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L933:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L934
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L934:
	movq	144(%rsp), %rdi
	leaq	160(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L935
	movq	160(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L935:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%r13, %rdi
.LEHB121:
	call	__cxa_throw@PLT
.LEHE121:
.L1178:
	leaq	208(%rsp), %r15
	movq	%r12, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%r15, %rdi
.LEHB122:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
.LEHE122:
	leaq	240(%rsp), %rax
	leaq	.LC19(%rip), %rdx
	movq	%r15, %rsi
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
.LEHB123:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE123:
	movq	24(%rsp), %rsi
	movq	%r13, %rdi
.LEHB124:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE124:
	movq	240(%rsp), %rdi
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L774
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L774:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L775
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L775:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L776
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L776:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%r13, %rdi
.LEHB125:
	call	__cxa_throw@PLT
.LEHE125:
.L1058:
	endbr64
.L1204:
	movq	%rax, %rbx
.L995:
	movq	%r13, %rdi
	movq	%rbx, %rbp
	call	__cxa_free_exception@PLT
	jmp	.L984
.L1041:
	endbr64
	jmp	.L1173
.L1045:
	endbr64
.L1234:
	movq	240(%rsp), %rdi
	movq	%rax, %rbx
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L979
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L979:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L981
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L981:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L995
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L995
.L1044:
	endbr64
.L1227:
	movq	%rax, %rbx
	jmp	.L979
.L1043:
	endbr64
.L1215:
	movq	%rax, %rbx
	jmp	.L981
.L1063:
	endbr64
.L1244:
	movq	240(%rsp), %rdi
	movq	%rax, %rbx
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L987
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L987:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L989
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L989:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L991
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L991:
	movq	144(%rsp), %rdi
	leaq	160(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L993
	movq	160(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L993:
	movq	112(%rsp), %rdi
	leaq	128(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L995
	movq	128(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L995
.L1062:
	endbr64
.L1241:
	movq	%rax, %rbx
	jmp	.L987
.L1061:
	endbr64
.L1238:
	movq	%rax, %rbx
	jmp	.L989
.L1060:
	endbr64
.L1229:
	movq	%rax, %rbx
	jmp	.L991
.L1059:
	endbr64
.L1217:
	movq	%rax, %rbx
	jmp	.L993
.L1175:
	cmpb	$37, %r13b
	jne	.L1181
	jmp	.L771
.L1181:
	movl	$16, %edi
	call	__cxa_allocate_exception@PLT
	movq	40(%rbp), %rsi
	movq	%rax, %r13
	movq	32(%rbp), %rax
	cmpq	8(%rax), %rsi
	jnb	.L1023
	movq	(%rax), %rax
	movzbl	(%rax,%rsi), %eax
.L777:
	leaq	112(%rsp), %r12
	movsbl	%al, %ebx
	movq	%r12, %rdi
.LEHB126:
	call	_ZNSt7__cxx119to_stringEm
.LEHE126:
	leaq	144(%rsp), %rbp
	movq	%r12, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%rbp, %rdi
.LEHB127:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
.LEHE127:
	leaq	176(%rsp), %r12
	leaq	.LC16(%rip), %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB128:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE128:
	leaq	208(%rsp), %r15
	movl	%ebx, %edx
	movq	%r12, %rsi
	movq	%r15, %rdi
.LEHB129:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_
.LEHE129:
	leaq	240(%rsp), %rax
	leaq	.LC20(%rip), %rdx
	movq	%r15, %rsi
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
.LEHB130:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE130:
	movq	24(%rsp), %rsi
	movq	%r13, %rdi
.LEHB131:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE131:
	movq	240(%rsp), %rdi
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L778
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L778:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L779
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L779:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L780
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L780:
	movq	144(%rsp), %rdi
	leaq	160(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L781
	movq	160(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L781:
	movq	112(%rsp), %rdi
	leaq	128(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L782
	movq	128(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L782:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%r13, %rdi
.LEHB132:
	call	__cxa_throw@PLT
.LEHE132:
.L1023:
	movl	$37, %eax
	jmp	.L777
.L796:
	cmpl	$0, (%rbx)
	jne	.L798
	movl	16(%rsp), %eax
	movl	%eax, (%rbx)
	jmp	.L798
.L1051:
	endbr64
	jmp	.L1244
.L1050:
	endbr64
	jmp	.L1241
.L1049:
	endbr64
	jmp	.L1238
.L1048:
	endbr64
	jmp	.L1229
.L1047:
	endbr64
	jmp	.L1217
.L1046:
	endbr64
	jmp	.L1204
.L1176:
	leaq	208(%rsp), %r15
	movq	%r12, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%r15, %rdi
.LEHB133:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
.LEHE133:
	leaq	240(%rsp), %rax
	leaq	.LC23(%rip), %rdx
	movq	%r15, %rsi
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
.LEHB134:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE134:
	movq	24(%rsp), %rsi
	movq	%r13, %rdi
.LEHB135:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE135:
	movq	240(%rsp), %rdi
	leaq	256(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L824
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L824:
	movq	208(%rsp), %rdi
	leaq	224(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L825
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L825:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L826
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L826:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%r13, %rdi
.LEHB136:
	call	__cxa_throw@PLT
.LEHE136:
.L1057:
	endbr64
	jmp	.L1234
.L1056:
	endbr64
	jmp	.L1227
.L1055:
	endbr64
	jmp	.L1215
.L1028:
	movl	$37, %eax
	jmp	.L931
.L1071:
	endbr64
	movq	%rax, %rbx
.L1016:
	movq	%r13, %rdi
	call	__cxa_free_exception@PLT
	jmp	.L1188
.L1075:
	endbr64
	movq	240(%rsp), %rdi
	movq	%rax, %rbp
	cmpq	8(%rsp), %rdi
	je	.L1010
	movq	256(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1010:
	movq	208(%rsp), %rdi
	cmpq	%rbx, %rdi
	je	.L1011
	movq	224(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1011:
	movq	%rbp, %rbx
.L1012:
	movq	176(%rsp), %rdi
	leaq	192(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1014
	movq	192(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1014:
	movq	144(%rsp), %rdi
	leaq	160(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1016
	movq	160(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L1016
.L1074:
	endbr64
	movq	%rax, %rbp
	jmp	.L1010
.L1073:
	endbr64
	movq	%rax, %rbx
	jmp	.L1012
.L1072:
	endbr64
	movq	%rax, %rbx
	jmp	.L1014
	.cfi_endproc
.LFE4124:
	.section	.gcc_except_table
.LLSDAC4124:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4124-.LLSDACSBC4124
.LLSDACSBC4124:
	.uleb128 .LEHB93-.LCOLDB28
	.uleb128 .LEHE93-.LEHB93
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB94-.LCOLDB28
	.uleb128 .LEHE94-.LEHB94
	.uleb128 .L1070-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB95-.LCOLDB28
	.uleb128 .LEHE95-.LEHB95
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB96-.LCOLDB28
	.uleb128 .LEHE96-.LEHB96
	.uleb128 .L1058-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB97-.LCOLDB28
	.uleb128 .LEHE97-.LEHB97
	.uleb128 .L1059-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB98-.LCOLDB28
	.uleb128 .LEHE98-.LEHB98
	.uleb128 .L1060-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB99-.LCOLDB28
	.uleb128 .LEHE99-.LEHB99
	.uleb128 .L1061-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB100-.LCOLDB28
	.uleb128 .LEHE100-.LEHB100
	.uleb128 .L1062-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB101-.LCOLDB28
	.uleb128 .LEHE101-.LEHB101
	.uleb128 .L1063-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB102-.LCOLDB28
	.uleb128 .LEHE102-.LEHB102
	.uleb128 .L1053-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB103-.LCOLDB28
	.uleb128 .LEHE103-.LEHB103
	.uleb128 .L1031-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB104-.LCOLDB28
	.uleb128 .LEHE104-.LEHB104
	.uleb128 .L1032-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB105-.LCOLDB28
	.uleb128 .LEHE105-.LEHB105
	.uleb128 .L1033-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB106-.LCOLDB28
	.uleb128 .LEHE106-.LEHB106
	.uleb128 .L1034-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB107-.LCOLDB28
	.uleb128 .LEHE107-.LEHB107
	.uleb128 .L1030-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB108-.LCOLDB28
	.uleb128 .LEHE108-.LEHB108
	.uleb128 .L1035-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB109-.LCOLDB28
	.uleb128 .LEHE109-.LEHB109
	.uleb128 .L1036-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB110-.LCOLDB28
	.uleb128 .LEHE110-.LEHB110
	.uleb128 .L1037-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB111-.LCOLDB28
	.uleb128 .LEHE111-.LEHB111
	.uleb128 .L1038-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB112-.LCOLDB28
	.uleb128 .LEHE112-.LEHB112
	.uleb128 .L1039-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB113-.LCOLDB28
	.uleb128 .LEHE113-.LEHB113
	.uleb128 .L1040-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB114-.LCOLDB28
	.uleb128 .LEHE114-.LEHB114
	.uleb128 .L1030-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB115-.LCOLDB28
	.uleb128 .LEHE115-.LEHB115
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB116-.LCOLDB28
	.uleb128 .LEHE116-.LEHB116
	.uleb128 .L1071-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB117-.LCOLDB28
	.uleb128 .LEHE117-.LEHB117
	.uleb128 .L1072-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB118-.LCOLDB28
	.uleb128 .LEHE118-.LEHB118
	.uleb128 .L1073-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB119-.LCOLDB28
	.uleb128 .LEHE119-.LEHB119
	.uleb128 .L1074-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB120-.LCOLDB28
	.uleb128 .LEHE120-.LEHB120
	.uleb128 .L1075-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB121-.LCOLDB28
	.uleb128 .LEHE121-.LEHB121
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB122-.LCOLDB28
	.uleb128 .LEHE122-.LEHB122
	.uleb128 .L1043-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB123-.LCOLDB28
	.uleb128 .LEHE123-.LEHB123
	.uleb128 .L1044-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB124-.LCOLDB28
	.uleb128 .LEHE124-.LEHB124
	.uleb128 .L1045-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB125-.LCOLDB28
	.uleb128 .LEHE125-.LEHB125
	.uleb128 .L1041-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB126-.LCOLDB28
	.uleb128 .LEHE126-.LEHB126
	.uleb128 .L1046-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB127-.LCOLDB28
	.uleb128 .LEHE127-.LEHB127
	.uleb128 .L1047-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB128-.LCOLDB28
	.uleb128 .LEHE128-.LEHB128
	.uleb128 .L1048-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB129-.LCOLDB28
	.uleb128 .LEHE129-.LEHB129
	.uleb128 .L1049-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB130-.LCOLDB28
	.uleb128 .LEHE130-.LEHB130
	.uleb128 .L1050-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB131-.LCOLDB28
	.uleb128 .LEHE131-.LEHB131
	.uleb128 .L1051-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB132-.LCOLDB28
	.uleb128 .LEHE132-.LEHB132
	.uleb128 .L1041-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB133-.LCOLDB28
	.uleb128 .LEHE133-.LEHB133
	.uleb128 .L1055-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB134-.LCOLDB28
	.uleb128 .LEHE134-.LEHB134
	.uleb128 .L1056-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB135-.LCOLDB28
	.uleb128 .LEHE135-.LEHB135
	.uleb128 .L1057-.LCOLDB28
	.uleb128 0
	.uleb128 .LEHB136-.LCOLDB28
	.uleb128 .LEHE136-.LEHB136
	.uleb128 .L1053-.LCOLDB28
	.uleb128 0
.LLSDACSEC4124:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormula9parseRestEv, .-_ZN12ParseFormula9parseRestEv
	.section	.text.unlikely
	.size	_ZN12ParseFormula9parseRestEv.cold, .-_ZN12ParseFormula9parseRestEv.cold
.LCOLDE28:
	.text
.LHOTE28:
	.section	.text.unlikely
	.align 2
.LCOLDB29:
	.text
.LHOTB29:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE
	.type	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE, @function
_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE:
.LFB4139:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4139
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$168, %rsp
	.cfi_def_cfa_offset 224
	movq	32(%rsi), %r14
	movq	40(%rsi), %rbx
	movq	%fs:40, %rax
	movq	%rax, 152(%rsp)
	xorl	%eax, %eax
	jmp	.L1286
	.p2align 4,,10
	.p2align 3
.L1499:
	movq	(%r14), %r15
	movsbl	(%r15,%rbx), %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%rbx), %rax
	testl	%r8d, %r8d
	je	.L1498
.L1288:
	movq	%rax, 40(%rbp)
	movq	%rax, %rbx
.L1286:
	cmpq	%rbx, 8(%r14)
	ja	.L1499
	movl	$37, %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%rbx), %rax
	testl	%r8d, %r8d
	jne	.L1288
.L1290:
	movq	0(%r13), %rax
	pxor	%xmm0, %xmm0
	movq	$0, 8(%r12)
	movq	%rax, (%r12)
	movq	8(%r13), %rax
	movups	%xmm0, 0(%r13)
	movq	%rax, 8(%r12)
.L1285:
	movq	152(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1500
	addq	$168, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1498:
	.cfi_restore_state
	cmpb	$38, (%r15,%rbx)
	jne	.L1290
	movq	%rax, 40(%rbp)
	leaq	16(%rsp), %r15
	movq	%rbp, %rsi
	movq	%r15, %rdi
.LEHB137:
	call	_ZN12ParseFormula9parseRestEv
.LEHE137:
	movq	0(%r13), %rdi
	movq	(%rdi), %rax
.LEHB138:
	call	*24(%rax)
	testl	%eax, %eax
	je	.L1291
	movq	0(%r13), %rdi
.L1293:
	movq	(%rdi), %rax
	call	*24(%rax)
	testl	%eax, %eax
	je	.L1501
	movq	16(%rsp), %rdi
	movq	(%rdi), %rax
	call	*24(%rax)
	testl	%eax, %eax
	jne	.L1361
	movq	16(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1362
	xorl	%ecx, %ecx
	leaq	_ZTI3And(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rdi
.L1362:
	movq	%r13, %rsi
	call	_ZN3And13addSubformulaERKSt10shared_ptrI7FormulaE@PLT
.LEHE138:
	movdqa	16(%rsp), %xmm4
	movq	24(%rsp), %rax
	movaps	%xmm4, 96(%rsp)
	testq	%rax, %rax
	je	.L1363
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1364
	addl	$1, 8(%rax)
.L1363:
	leaq	96(%rsp), %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB139:
	call	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE
.LEHE139:
.L1495:
	movq	104(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L1322
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1367
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L1368:
	cmpl	$1, %eax
	je	.L1502
.L1322:
	movq	24(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L1285
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1376
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L1377:
	cmpl	$1, %eax
	jne	.L1285
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1503
.L1379:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1380
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L1381:
	cmpl	$1, %eax
	jne	.L1285
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L1382
	call	*8(%rdx)
	jmp	.L1285
	.p2align 4,,10
	.p2align 3
.L1291:
	movq	16(%rsp), %rdi
	movq	(%rdi), %rax
.LEHB140:
	call	*24(%rax)
	movq	0(%r13), %r14
	movq	%r14, %rdi
	testl	%eax, %eax
	jne	.L1293
	testq	%r14, %r14
	je	.L1294
	xorl	%ecx, %ecx
	leaq	_ZTI3And(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %r14
.L1294:
	movq	16(%rsp), %rbx
	testq	%rbx, %rbx
	je	.L1295
	movq	%rbx, %rdi
	xorl	%ecx, %ecx
	leaq	_ZTI3And(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rbx
.L1295:
	movq	%rbx, %rdi
	call	_ZNK3And9getLengthEv@PLT
	movq	%r14, %rdi
	movl	%eax, %r15d
	call	_ZNK3And9getLengthEv@PLT
	cmpl	%eax, %r15d
	jge	.L1296
	movq	%rbx, %rdi
	call	_ZNK3And23getSubformulasReferenceEv@PLT
.LEHE140:
	movq	16(%rax), %rbx
	leaq	96(%rsp), %r15
	testq	%rbx, %rbx
	jne	.L1297
	jmp	.L1311
	.p2align 4,,10
	.p2align 3
.L1505:
	addl	$1, 8(%rax)
.L1300:
	movq	%r15, %rsi
	movq	%r14, %rdi
.LEHB141:
	call	_ZN3And13addSubformulaERKSt10shared_ptrI7FormulaE@PLT
.LEHE141:
	movq	104(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1303
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1304
	movl	8(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rdi)
.L1305:
	cmpl	$1, %eax
	je	.L1504
.L1303:
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L1311
.L1297:
	movq	16(%rbx), %rax
	movdqu	8(%rbx), %xmm1
	movaps	%xmm1, 96(%rsp)
	testq	%rax, %rax
	je	.L1300
	cmpb	$0, __libc_single_threaded(%rip)
	jne	.L1505
	lock addl	$1, 8(%rax)
	jmp	.L1300
.L1501:
	movq	0(%r13), %rdi
	testq	%rdi, %rdi
	je	.L1349
	xorl	%ecx, %ecx
	leaq	_ZTI3And(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rdi
.L1349:
	movq	%r15, %rsi
.LEHB142:
	call	_ZN3And13addSubformulaERKSt10shared_ptrI7FormulaE@PLT
.LEHE142:
	movdqu	0(%r13), %xmm3
	movaps	%xmm3, 96(%rsp)
	movq	104(%rsp), %rax
	testq	%rax, %rax
	je	.L1350
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1351
	addl	$1, 8(%rax)
.L1350:
	leaq	96(%rsp), %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB143:
	call	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE
.LEHE143:
	jmp	.L1495
.L1504:
	movq	(%rdi), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rcx
	movq	16(%rax), %rax
	cmpq	%rcx, %rax
	jne	.L1506
.L1307:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1308
	movl	12(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rdi)
.L1309:
	cmpl	$1, %eax
	jne	.L1303
	movq	(%rdi), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L1310
	call	*8(%rdx)
	jmp	.L1303
.L1304:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rdi)
	jmp	.L1305
.L1376:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L1377
.L1502:
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1507
.L1370:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1371
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L1372:
	cmpl	$1, %eax
	jne	.L1322
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L1373
	call	*8(%rdx)
	jmp	.L1322
.L1367:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L1368
.L1361:
	leaq	32(%rsp), %r14
	leaq	80(%rsp), %rax
	movq	%r13, %rsi
	movq	$1, 40(%rsp)
	movq	%r14, %rdi
	movq	%rax, 32(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 56(%rsp)
	movl	$0x3f800000, 64(%rsp)
	movq	$0, 72(%rsp)
	movq	$0, 80(%rsp)
.LEHB144:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
	movq	40(%rsp), %rax
	movdqa	64(%rsp), %xmm7
	leaq	96(%rsp), %r15
	movq	%r14, %rsi
	movq	$0, 96(%rsp)
	movq	%r15, %rdi
	movq	%rax, 104(%rsp)
	movq	56(%rsp), %rax
	movq	$0, 112(%rsp)
	movq	%rax, 120(%rsp)
	movq	$0, 144(%rsp)
	movaps	%xmm7, 128(%rsp)
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0
.LEHE144:
	movq	%r15, %rsi
	movq	%r12, %rdi
.LEHB145:
	call	_ZN3And6createESt13unordered_setISt10shared_ptrI7FormulaEN5Deref4HashENS4_7CompareESaIS3_EE@PLT
.LEHE145:
	movq	%r15, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	%r14, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	jmp	.L1322
.L1311:
	movdqu	0(%r13), %xmm5
	movaps	%xmm5, 96(%rsp)
	movq	104(%rsp), %rax
	testq	%rax, %rax
	je	.L1299
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1312
	addl	$1, 8(%rax)
.L1299:
	movq	%r15, %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB146:
	call	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE
.LEHE146:
	jmp	.L1495
.L1296:
	movq	%r14, %rdi
.LEHB147:
	call	_ZNK3And23getSubformulasReferenceEv@PLT
.LEHE147:
	movq	16(%rax), %r13
	leaq	96(%rsp), %r15
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %r14
	testq	%r13, %r13
	jne	.L1323
	jmp	.L1337
	.p2align 4,,10
	.p2align 3
.L1509:
	addl	$1, 8(%rax)
.L1326:
	movq	%r15, %rsi
	movq	%rbx, %rdi
.LEHB148:
	call	_ZN3And13addSubformulaERKSt10shared_ptrI7FormulaE@PLT
.LEHE148:
	movq	104(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1329
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1330
	movl	8(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rdi)
.L1331:
	cmpl	$1, %eax
	je	.L1508
.L1329:
	movq	0(%r13), %r13
	testq	%r13, %r13
	je	.L1337
.L1323:
	movq	16(%r13), %rax
	movdqu	8(%r13), %xmm2
	movaps	%xmm2, 96(%rsp)
	testq	%rax, %rax
	je	.L1326
	cmpb	$0, __libc_single_threaded(%rip)
	jne	.L1509
	lock addl	$1, 8(%rax)
	jmp	.L1326
.L1508:
	movq	(%rdi), %rax
	movq	16(%rax), %rax
	cmpq	%r14, %rax
	jne	.L1510
.L1333:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1334
	movl	12(%rdi), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rdi)
.L1335:
	cmpl	$1, %eax
	jne	.L1329
	movq	(%rdi), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L1336
	call	*8(%rdx)
	jmp	.L1329
.L1330:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rdi)
	jmp	.L1331
.L1337:
	movdqa	16(%rsp), %xmm6
	movq	24(%rsp), %rax
	movaps	%xmm6, 96(%rsp)
	testq	%rax, %rax
	je	.L1325
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1338
	addl	$1, 8(%rax)
.L1325:
	movq	%r15, %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB149:
	call	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE
.LEHE149:
	jmp	.L1495
.L1351:
	lock addl	$1, 8(%rax)
	jmp	.L1350
.L1334:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rdi)
	jmp	.L1335
.L1308:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rdi)
	jmp	.L1309
.L1380:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L1381
.L1364:
	lock addl	$1, 8(%rax)
	jmp	.L1363
.L1371:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L1372
.L1506:
	movq	%rdi, 8(%rsp)
	call	*%rax
	movq	8(%rsp), %rdi
	jmp	.L1307
.L1503:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L1379
.L1507:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L1370
.L1510:
	movq	%rdi, 8(%rsp)
	call	*%rax
	movq	8(%rsp), %rdi
	jmp	.L1333
.L1338:
	lock addl	$1, 8(%rax)
	jmp	.L1325
.L1312:
	lock addl	$1, 8(%rax)
	jmp	.L1299
.L1336:
	call	*%rax
	jmp	.L1329
.L1373:
	call	*%rax
	jmp	.L1322
.L1382:
	call	*%rax
	jmp	.L1285
.L1310:
	call	*%rax
	jmp	.L1303
.L1500:
	call	__stack_chk_fail@PLT
.L1406:
	endbr64
	movq	%rax, %rbp
	jmp	.L1395
.L1404:
	endbr64
	movq	%rax, %rbp
	jmp	.L1395
.L1409:
	endbr64
	movq	%rax, %rbp
	jmp	.L1397
.L1408:
	endbr64
	movq	%rax, %rbp
	jmp	.L1398
.L1402:
	endbr64
	movq	%rax, %rbp
	jmp	.L1395
.L1405:
	endbr64
	movq	%rax, %rbp
	jmp	.L1395
.L1407:
	endbr64
	movq	%rax, %rbp
	jmp	.L1395
.L1401:
	endbr64
	movq	%rax, %rbp
	jmp	.L1386
.L1403:
	endbr64
	movq	%rax, %rbp
	jmp	.L1395
	.section	.gcc_except_table
.LLSDA4139:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4139-.LLSDACSB4139
.LLSDACSB4139:
	.uleb128 .LEHB137-.LFB4139
	.uleb128 .LEHE137-.LEHB137
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB138-.LFB4139
	.uleb128 .LEHE138-.LEHB138
	.uleb128 .L1401-.LFB4139
	.uleb128 0
	.uleb128 .LEHB139-.LFB4139
	.uleb128 .LEHE139-.LEHB139
	.uleb128 .L1407-.LFB4139
	.uleb128 0
	.uleb128 .LEHB140-.LFB4139
	.uleb128 .LEHE140-.LEHB140
	.uleb128 .L1401-.LFB4139
	.uleb128 0
	.uleb128 .LEHB141-.LFB4139
	.uleb128 .LEHE141-.LEHB141
	.uleb128 .L1402-.LFB4139
	.uleb128 0
	.uleb128 .LEHB142-.LFB4139
	.uleb128 .LEHE142-.LEHB142
	.uleb128 .L1401-.LFB4139
	.uleb128 0
	.uleb128 .LEHB143-.LFB4139
	.uleb128 .LEHE143-.LEHB143
	.uleb128 .L1406-.LFB4139
	.uleb128 0
	.uleb128 .LEHB144-.LFB4139
	.uleb128 .LEHE144-.LEHB144
	.uleb128 .L1408-.LFB4139
	.uleb128 0
	.uleb128 .LEHB145-.LFB4139
	.uleb128 .LEHE145-.LEHB145
	.uleb128 .L1409-.LFB4139
	.uleb128 0
	.uleb128 .LEHB146-.LFB4139
	.uleb128 .LEHE146-.LEHB146
	.uleb128 .L1403-.LFB4139
	.uleb128 0
	.uleb128 .LEHB147-.LFB4139
	.uleb128 .LEHE147-.LEHB147
	.uleb128 .L1401-.LFB4139
	.uleb128 0
	.uleb128 .LEHB148-.LFB4139
	.uleb128 .LEHE148-.LEHB148
	.uleb128 .L1404-.LFB4139
	.uleb128 0
	.uleb128 .LEHB149-.LFB4139
	.uleb128 .LEHE149-.LEHB149
	.uleb128 .L1405-.LFB4139
	.uleb128 0
.LLSDACSE4139:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4139
	.type	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE.cold, @function
_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE.cold:
.LFSB4139:
.L1397:
	.cfi_def_cfa_offset 224
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%r15, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
.L1398:
	movq	%r14, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
.L1386:
	movq	24(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1399
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L1399:
	movq	%rbp, %rdi
.LEHB150:
	call	_Unwind_Resume@PLT
.LEHE150:
.L1395:
	movq	104(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1386
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	jmp	.L1386
	.cfi_endproc
.LFE4139:
	.section	.gcc_except_table
.LLSDAC4139:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4139-.LLSDACSBC4139
.LLSDACSBC4139:
	.uleb128 .LEHB150-.LCOLDB29
	.uleb128 .LEHE150-.LEHB150
	.uleb128 0
	.uleb128 0
.LLSDACSEC4139:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE, .-_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE
	.section	.text.unlikely
	.size	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE.cold, .-_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE.cold
.LCOLDE29:
	.text
.LHOTE29:
	.section	.text.unlikely
	.align 2
.LCOLDB30:
	.text
.LHOTB30:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula8parseAndEv
	.type	_ZN12ParseFormula8parseAndEv, @function
_ZN12ParseFormula8parseAndEv:
.LFB4138:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4138
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %r13
	movq	%r13, %rdi
.LEHB151:
	call	_ZN12ParseFormula9parseRestEv
.LEHE151:
	movq	%r13, %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB152:
	call	_ZN12ParseFormula11parseAndAccESt10shared_ptrI7FormulaE
.LEHE152:
	movq	8(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L1511
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1514
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L1515:
	cmpl	$1, %eax
	je	.L1529
.L1511:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1530
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%r12, %rax
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1529:
	.cfi_restore_state
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1531
.L1517:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1518
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L1519:
	cmpl	$1, %eax
	jne	.L1511
	movq	0(%rbp), %rax
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rax), %rdx
	cmpq	%rcx, %rdx
	jne	.L1520
	call	*8(%rax)
	jmp	.L1511
	.p2align 4,,10
	.p2align 3
.L1514:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L1515
	.p2align 4,,10
	.p2align 3
.L1518:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L1519
	.p2align 4,,10
	.p2align 3
.L1520:
	call	*%rdx
	jmp	.L1511
	.p2align 4,,10
	.p2align 3
.L1531:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L1517
.L1530:
	call	__stack_chk_fail@PLT
.L1524:
	endbr64
	movq	%rax, %rbp
	jmp	.L1521
	.section	.gcc_except_table
.LLSDA4138:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4138-.LLSDACSB4138
.LLSDACSB4138:
	.uleb128 .LEHB151-.LFB4138
	.uleb128 .LEHE151-.LEHB151
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB152-.LFB4138
	.uleb128 .LEHE152-.LEHB152
	.uleb128 .L1524-.LFB4138
	.uleb128 0
.LLSDACSE4138:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4138
	.type	_ZN12ParseFormula8parseAndEv.cold, @function
_ZN12ParseFormula8parseAndEv.cold:
.LFSB4138:
.L1521:
	.cfi_def_cfa_offset 64
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	8(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1522
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L1522:
	movq	%rbp, %rdi
.LEHB153:
	call	_Unwind_Resume@PLT
.LEHE153:
	.cfi_endproc
.LFE4138:
	.section	.gcc_except_table
.LLSDAC4138:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4138-.LLSDACSBC4138
.LLSDACSBC4138:
	.uleb128 .LEHB153-.LCOLDB30
	.uleb128 .LEHE153-.LEHB153
	.uleb128 0
	.uleb128 0
.LLSDACSEC4138:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormula8parseAndEv, .-_ZN12ParseFormula8parseAndEv
	.section	.text.unlikely
	.size	_ZN12ParseFormula8parseAndEv.cold, .-_ZN12ParseFormula8parseAndEv.cold
.LCOLDE30:
	.text
.LHOTE30:
	.section	.text.unlikely
	.align 2
.LCOLDB31:
	.text
.LHOTB31:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE
	.type	_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE, @function
_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE:
.LFB4168:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4168
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$216, %rsp
	.cfi_def_cfa_offset 272
	movq	32(%rsi), %rbp
	movq	40(%rsi), %rbx
	movq	%fs:40, %rax
	movq	%rax, 200(%rsp)
	xorl	%eax, %eax
	jmp	.L1533
	.p2align 4,,10
	.p2align 3
.L1640:
	movq	0(%rbp), %r15
	movsbl	(%r15,%rbx), %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%rbx), %rax
	testl	%r8d, %r8d
	je	.L1639
.L1535:
	movq	%rax, 40(%r12)
	movq	%rax, %rbx
.L1533:
	cmpq	%rbx, 8(%rbp)
	ja	.L1640
	movl	$37, %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%rbx), %rax
	testl	%r8d, %r8d
	jne	.L1535
.L1537:
	movq	0(%r13), %rdi
	movq	(%rdi), %rax
.LEHB154:
	call	*24(%rax)
	cmpl	$6, %eax
	je	.L1641
.L1577:
	movq	0(%r13), %rax
	movq	$0, 8(%r14)
	pxor	%xmm0, %xmm0
	movq	%rax, (%r14)
	movq	8(%r13), %rax
	movups	%xmm0, 0(%r13)
	movq	%rax, 8(%r14)
.L1532:
	movq	200(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1642
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1639:
	.cfi_restore_state
	cmpb	$124, (%r15,%rbx)
	jne	.L1537
	movq	%rax, 40(%r12)
	movq	%rsp, %r15
	movq	%r12, %rsi
	leaq	16(%rsp), %rbp
	movq	%r15, %rdi
	call	_ZN12ParseFormula8parseAndEv
.LEHE154:
	movq	0(%r13), %rdi
	leaq	64(%rsp), %rax
	movq	$1, 24(%rsp)
	movq	%rax, 16(%rsp)
	movq	(%rdi), %rax
	movl	$0x3f800000, 48(%rsp)
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
	movq	$0, 56(%rsp)
	movq	$0, 64(%rsp)
.LEHB155:
	call	*24(%rax)
	cmpl	$6, %eax
	jne	.L1538
	movq	0(%r13), %rdi
	testq	%rdi, %rdi
	je	.L1539
	xorl	%ecx, %ecx
	leaq	_ZTI2Or(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rdi
.L1539:
	leaq	16(%rsp), %rbp
	call	_ZNK2Or23getSubformulasReferenceEv@PLT
	movq	%rax, %rsi
	cmpq	%rbp, %rax
	je	.L1541
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE18_M_assign_elementsIRKSE_EEvOT_
.L1541:
	movq	(%rsp), %rdi
	movq	(%rdi), %rax
	call	*24(%rax)
	cmpl	$6, %eax
	jne	.L1543
	movq	(%rsp), %rbx
	testq	%rbx, %rbx
	je	.L1544
	movq	%rbx, %rdi
	xorl	%ecx, %ecx
	leaq	_ZTI2Or(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rbx
.L1544:
	leaq	144(%rsp), %r13
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	_ZNK2Or14getSubformulasEv@PLT
.LEHE155:
	leaq	80(%rsp), %r15
	movq	%rbx, %rsi
	movq	%r15, %rdi
.LEHB156:
	call	_ZNK2Or14getSubformulasEv@PLT
.LEHE156:
	movq	96(%rsp), %rbx
	testq	%rbx, %rbx
	je	.L1547
	.p2align 4,,10
	.p2align 3
.L1545:
	leaq	8(%rbx), %rsi
	movq	%rbp, %rdi
.LEHB157:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
.LEHE157:
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L1545
.L1547:
	movq	%r15, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	%r13, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	24(%rsp), %rax
	movq	%rbp, %rsi
	movq	%r13, %rdi
	movdqa	48(%rsp), %xmm1
	movq	$0, 144(%rsp)
	movq	%rax, 152(%rsp)
	movq	40(%rsp), %rax
	movq	$0, 160(%rsp)
	movq	%rax, 168(%rsp)
	movq	$0, 192(%rsp)
	movaps	%xmm1, 176(%rsp)
.LEHB158:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0
.LEHE158:
	movq	%r13, %rsi
	movq	%r15, %rdi
.LEHB159:
	call	_ZN2Or6createESt13unordered_setISt10shared_ptrI7FormulaEN5Deref4HashENS4_7CompareESaIS3_EE@PLT
.LEHE159:
	movq	%r15, %rdx
	movq	%r12, %rsi
	movq	%r14, %rdi
.LEHB160:
	call	_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE
.LEHE160:
.L1638:
	movq	88(%rsp), %r12
	testq	%r12, %r12
	je	.L1559
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1560
	movl	8(%r12), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%r12)
.L1561:
	cmpl	$1, %eax
	jne	.L1559
	movq	(%r12), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1643
.L1563:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1564
	movl	12(%r12), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%r12)
.L1565:
	cmpl	$1, %eax
	jne	.L1559
	movq	(%r12), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%r12, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L1566
	call	*8(%rdx)
	.p2align 4,,10
	.p2align 3
.L1559:
	movq	%r13, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	8(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L1532
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1569
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L1570:
	cmpl	$1, %eax
	jne	.L1532
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1644
.L1572:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1573
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L1574:
	cmpl	$1, %eax
	jne	.L1532
	movq	0(%rbp), %rdx
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rdx), %rax
	cmpq	%rcx, %rax
	jne	.L1575
	call	*8(%rdx)
	jmp	.L1532
	.p2align 4,,10
	.p2align 3
.L1641:
	movq	0(%r13), %rbp
	testq	%rbp, %rbp
	je	.L1578
	movq	%rbp, %rdi
	xorl	%ecx, %ecx
	leaq	_ZTI2Or(%rip), %rdx
	leaq	_ZTI7Formula(%rip), %rsi
	call	__dynamic_cast@PLT
	movq	%rax, %rbp
.L1578:
	movq	%rbp, %rdi
.LEHB161:
	call	_ZNK2Or9getLengthEv@PLT
	cmpl	$1, %eax
	jne	.L1577
	leaq	144(%rsp), %r13
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	_ZNK2Or14getSubformulasEv@PLT
.LEHE161:
	movq	160(%rsp), %rax
	movdqu	8(%rax), %xmm3
	movups	%xmm3, (%r14)
	movq	8(%r14), %rax
	testq	%rax, %rax
	je	.L1579
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1580
	addl	$1, 8(%rax)
.L1579:
	movq	%r13, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	jmp	.L1532
.L1538:
	leaq	16(%rsp), %rbp
	movq	%r13, %rsi
	movq	%rbp, %rdi
.LEHB162:
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
	jmp	.L1541
.L1543:
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_insertIRKS2_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEESt4pairINS4_14_Node_iteratorIS2_Lb1ELb1EEEbEOT_RKT0_St17integral_constantIbLb1EE.isra.0
	movq	24(%rsp), %rax
	movdqa	48(%rsp), %xmm2
	leaq	144(%rsp), %r13
	movq	%rbp, %rsi
	movq	$0, 144(%rsp)
	movq	%r13, %rdi
	movq	%rax, 152(%rsp)
	movq	40(%rsp), %rax
	movq	$0, 160(%rsp)
	movq	%rax, 168(%rsp)
	movq	$0, 192(%rsp)
	movaps	%xmm2, 176(%rsp)
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEE9_M_assignIRKSE_NS4_10_AllocNodeISaINS4_10_Hash_nodeIS2_Lb1EEEEEEEEvOT_RKT0_.isra.0
.LEHE162:
	leaq	80(%rsp), %r15
	movq	%r13, %rsi
	movq	%r15, %rdi
.LEHB163:
	call	_ZN2Or6createESt13unordered_setISt10shared_ptrI7FormulaEN5Deref4HashENS4_7CompareESaIS3_EE@PLT
.LEHE163:
	movq	%r15, %rdx
	movq	%r12, %rsi
	movq	%r14, %rdi
.LEHB164:
	call	_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE
.LEHE164:
	jmp	.L1638
.L1560:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%r12)
	jmp	.L1561
.L1569:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L1570
.L1580:
	lock addl	$1, 8(%rax)
	jmp	.L1579
.L1573:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L1574
.L1564:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%r12)
	jmp	.L1565
.L1644:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L1572
.L1643:
	movq	%r12, %rdi
	call	*%rax
	jmp	.L1563
.L1566:
	call	*%rax
	jmp	.L1559
.L1575:
	call	*%rax
	jmp	.L1532
.L1642:
	call	__stack_chk_fail@PLT
.L1598:
	endbr64
	movq	%rax, %r12
	jmp	.L1587
.L1593:
	endbr64
	movq	%rax, %r12
	jmp	.L1589
.L1596:
	endbr64
	movq	%rax, %r12
	jmp	.L1584
.L1597:
	endbr64
	movq	%rax, %r12
	jmp	.L1589
.L1592:
	endbr64
	movq	%rax, %r12
	jmp	.L1583
.L1595:
	endbr64
	movq	%rax, %r12
	jmp	.L1589
.L1594:
	endbr64
	movq	%rax, %r12
	jmp	.L1581
	.section	.gcc_except_table
.LLSDA4168:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4168-.LLSDACSB4168
.LLSDACSB4168:
	.uleb128 .LEHB154-.LFB4168
	.uleb128 .LEHE154-.LEHB154
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB155-.LFB4168
	.uleb128 .LEHE155-.LEHB155
	.uleb128 .L1592-.LFB4168
	.uleb128 0
	.uleb128 .LEHB156-.LFB4168
	.uleb128 .LEHE156-.LEHB156
	.uleb128 .L1593-.LFB4168
	.uleb128 0
	.uleb128 .LEHB157-.LFB4168
	.uleb128 .LEHE157-.LEHB157
	.uleb128 .L1594-.LFB4168
	.uleb128 0
	.uleb128 .LEHB158-.LFB4168
	.uleb128 .LEHE158-.LEHB158
	.uleb128 .L1592-.LFB4168
	.uleb128 0
	.uleb128 .LEHB159-.LFB4168
	.uleb128 .LEHE159-.LEHB159
	.uleb128 .L1595-.LFB4168
	.uleb128 0
	.uleb128 .LEHB160-.LFB4168
	.uleb128 .LEHE160-.LEHB160
	.uleb128 .L1596-.LFB4168
	.uleb128 0
	.uleb128 .LEHB161-.LFB4168
	.uleb128 .LEHE161-.LEHB161
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB162-.LFB4168
	.uleb128 .LEHE162-.LEHB162
	.uleb128 .L1592-.LFB4168
	.uleb128 0
	.uleb128 .LEHB163-.LFB4168
	.uleb128 .LEHE163-.LEHB163
	.uleb128 .L1597-.LFB4168
	.uleb128 0
	.uleb128 .LEHB164-.LFB4168
	.uleb128 .LEHE164-.LEHB164
	.uleb128 .L1598-.LFB4168
	.uleb128 0
.LLSDACSE4168:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4168
	.type	_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE.cold, @function
_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE.cold:
.LFSB4168:
.L1587:
	.cfi_def_cfa_offset 272
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	88(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1645
.L1589:
	movq	%r13, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
.L1583:
	movq	%rbp, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	movq	8(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1590
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L1590:
	movq	%r12, %rdi
.LEHB165:
	call	_Unwind_Resume@PLT
.LEHE165:
.L1584:
	movq	88(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1589
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	jmp	.L1589
.L1645:
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	jmp	.L1589
.L1581:
	movq	%r15, %rdi
	call	_ZNSt10_HashtableISt10shared_ptrI7FormulaES2_SaIS2_ENSt8__detail9_IdentityEN5Deref7CompareENS6_4HashENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb1ELb1EEEED1Ev
	jmp	.L1589
	.cfi_endproc
.LFE4168:
	.section	.gcc_except_table
.LLSDAC4168:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4168-.LLSDACSBC4168
.LLSDACSBC4168:
	.uleb128 .LEHB165-.LCOLDB31
	.uleb128 .LEHE165-.LEHB165
	.uleb128 0
	.uleb128 0
.LLSDACSEC4168:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE, .-_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE
	.section	.text.unlikely
	.size	_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE.cold, .-_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE.cold
.LCOLDE31:
	.text
.LHOTE31:
	.section	.text.unlikely
	.align 2
.LCOLDB32:
	.text
.LHOTB32:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula7parseOrEv
	.type	_ZN12ParseFormula7parseOrEv, @function
_ZN12ParseFormula7parseOrEv:
.LFB4170:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4170
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	subq	$56, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rdi
.LEHB166:
	call	_ZN12ParseFormula8parseAndEv
.LEHE166:
	movdqa	(%rsp), %xmm0
	movq	8(%rsp), %rax
	movaps	%xmm0, 16(%rsp)
	testq	%rax, %rax
	je	.L1647
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1648
	addl	$1, 8(%rax)
.L1647:
	leaq	16(%rsp), %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
.LEHB167:
	call	_ZN12ParseFormula10parseOrAccESt10shared_ptrI7FormulaE
.LEHE167:
	movq	24(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L1650
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1651
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L1652:
	cmpl	$1, %eax
	je	.L1682
.L1650:
	movq	8(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L1646
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1660
	movl	8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 8(%rbp)
.L1661:
	cmpl	$1, %eax
	je	.L1683
.L1646:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1684
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rax
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1648:
	.cfi_restore_state
	lock addl	$1, 8(%rax)
	jmp	.L1647
	.p2align 4,,10
	.p2align 3
.L1682:
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1685
.L1654:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1655
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L1656:
	cmpl	$1, %eax
	jne	.L1650
	movq	0(%rbp), %rax
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rax), %rdx
	cmpq	%rcx, %rdx
	jne	.L1657
	call	*8(%rax)
	jmp	.L1650
	.p2align 4,,10
	.p2align 3
.L1683:
	movq	0(%rbp), %rax
	leaq	_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv(%rip), %rdx
	movq	16(%rax), %rax
	cmpq	%rdx, %rax
	jne	.L1686
.L1663:
	cmpb	$0, __libc_single_threaded(%rip)
	je	.L1664
	movl	12(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, 12(%rbp)
.L1665:
	cmpl	$1, %eax
	jne	.L1646
	movq	0(%rbp), %rax
	leaq	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv(%rip), %rcx
	movq	%rbp, %rdi
	movq	24(%rax), %rdx
	cmpq	%rcx, %rdx
	jne	.L1666
	call	*8(%rax)
	jmp	.L1646
	.p2align 4,,10
	.p2align 3
.L1660:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L1661
	.p2align 4,,10
	.p2align 3
.L1651:
	movl	$-1, %eax
	lock xaddl	%eax, 8(%rbp)
	jmp	.L1652
	.p2align 4,,10
	.p2align 3
.L1655:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L1656
	.p2align 4,,10
	.p2align 3
.L1664:
	movl	$-1, %eax
	lock xaddl	%eax, 12(%rbp)
	jmp	.L1665
	.p2align 4,,10
	.p2align 3
.L1657:
	call	*%rdx
	jmp	.L1650
	.p2align 4,,10
	.p2align 3
.L1666:
	call	*%rdx
	jmp	.L1646
	.p2align 4,,10
	.p2align 3
.L1686:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L1663
	.p2align 4,,10
	.p2align 3
.L1685:
	movq	%rbp, %rdi
	call	*%rax
	jmp	.L1654
.L1684:
	call	__stack_chk_fail@PLT
.L1671:
	endbr64
	movq	%rax, %rbp
	jmp	.L1667
	.section	.gcc_except_table
.LLSDA4170:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4170-.LLSDACSB4170
.LLSDACSB4170:
	.uleb128 .LEHB166-.LFB4170
	.uleb128 .LEHE166-.LEHB166
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB167-.LFB4170
	.uleb128 .LEHE167-.LEHB167
	.uleb128 .L1671-.LFB4170
	.uleb128 0
.LLSDACSE4170:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4170
	.type	_ZN12ParseFormula7parseOrEv.cold, @function
_ZN12ParseFormula7parseOrEv.cold:
.LFSB4170:
.L1667:
	.cfi_def_cfa_offset 80
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	24(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1668
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L1668:
	movq	8(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L1669
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L1669:
	movq	%rbp, %rdi
.LEHB168:
	call	_Unwind_Resume@PLT
.LEHE168:
	.cfi_endproc
.LFE4170:
	.section	.gcc_except_table
.LLSDAC4170:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4170-.LLSDACSBC4170
.LLSDACSBC4170:
	.uleb128 .LEHB168-.LCOLDB32
	.uleb128 .LEHE168-.LEHB168
	.uleb128 0
	.uleb128 0
.LLSDACSEC4170:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormula7parseOrEv, .-_ZN12ParseFormula7parseOrEv
	.section	.text.unlikely
	.size	_ZN12ParseFormula7parseOrEv.cold, .-_ZN12ParseFormula7parseOrEv.cold
.LCOLDE32:
	.text
.LHOTE32:
	.section	.text.unlikely
	.align 2
.LCOLDB33:
	.text
.LHOTB33:
	.align 2
	.p2align 4
	.globl	_ZN12ParseFormula12parseFormulaEv
	.type	_ZN12ParseFormula12parseFormulaEv, @function
_ZN12ParseFormula12parseFormulaEv:
.LFB4173:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4173
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
.LEHB169:
	call	_ZN12ParseFormula8parseIffEv
.LEHE169:
	movq	32(%r12), %rbp
	movq	40(%r12), %rbx
	jmp	.L1688
	.p2align 4,,10
	.p2align 3
.L1724:
	movq	0(%rbp), %r13
	movsbl	0(%r13,%rbx), %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%rbx), %rax
	testl	%r8d, %r8d
	je	.L1723
.L1690:
	movq	%rax, 40(%r12)
	movq	%rax, %rbx
.L1688:
	cmpq	%rbx, 8(%rbp)
	ja	.L1724
	movl	$37, %edi
	call	isspace@PLT
	movl	%eax, %r8d
	leaq	1(%rbx), %rax
	testl	%r8d, %r8d
	jne	.L1690
.L1687:
	movq	136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1725
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r14, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1723:
	.cfi_restore_state
	cmpb	$37, 0(%r13,%rbx)
	je	.L1687
	jmp	.L1720
.L1725:
	call	__stack_chk_fail@PLT
	.section	.gcc_except_table
.LLSDA4173:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4173-.LLSDACSB4173
.LLSDACSB4173:
	.uleb128 .LEHB169-.LFB4173
	.uleb128 .LEHE169-.LEHB169
	.uleb128 0
	.uleb128 0
.LLSDACSE4173:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4173
	.type	_ZN12ParseFormula12parseFormulaEv.cold, @function
_ZN12ParseFormula12parseFormulaEv.cold:
.LFSB4173:
.L1720:
	.cfi_def_cfa_offset 208
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$16, %edi
	call	__cxa_allocate_exception@PLT
	movq	40(%r12), %rsi
	movq	%rax, %r13
	movq	32(%r12), %rax
	cmpq	8(%rax), %rsi
	jnb	.L1710
	movq	(%rax), %rax
	movsbl	(%rax,%rsi), %r12d
.L1693:
	movq	%rsp, %r15
	movq	%r15, %rdi
.LEHB170:
	call	_ZNSt7__cxx119to_stringEm
.LEHE170:
	leaq	32(%rsp), %rbp
	movq	%r15, %rdx
	leaq	.LC14(%rip), %rsi
	movq	%rbp, %rdi
.LEHB171:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_OS8_
.LEHE171:
	leaq	64(%rsp), %r15
	leaq	.LC16(%rip), %rdx
	movq	%rbp, %rsi
	movq	%r15, %rdi
.LEHB172:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_
.LEHE172:
	leaq	96(%rsp), %rbp
	movl	%r12d, %edx
	movq	%r15, %rsi
	movq	%rbp, %rdi
.LEHB173:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S5_
.LEHE173:
	movq	%rbp, %rsi
	movq	%r13, %rdi
.LEHB174:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE174:
	movq	96(%rsp), %rdi
	leaq	112(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1694
	movq	112(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1694:
	movq	64(%rsp), %rdi
	leaq	80(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1695
	movq	80(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1695:
	movq	32(%rsp), %rdi
	leaq	48(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1696
	movq	48(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1696:
	movq	(%rsp), %rdi
	leaq	16(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1697
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1697:
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%r13, %rdi
.LEHB175:
	call	__cxa_throw@PLT
.LEHE175:
.L1710:
	movl	$37, %r12d
	jmp	.L1693
.L1712:
	endbr64
	movq	%rax, %rbx
.L1706:
	movq	%r13, %rdi
	movq	%rbx, %rbp
	call	__cxa_free_exception@PLT
.L1707:
	movq	8(%r14), %rdi
	testq	%rdi, %rdi
	je	.L1708
	call	_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
.L1708:
	movq	%rbp, %rdi
.LEHB176:
	call	_Unwind_Resume@PLT
.LEHE176:
.L1711:
	endbr64
	movq	%rax, %rbp
	jmp	.L1707
.L1716:
	endbr64
	movq	96(%rsp), %rdi
	movq	%rax, %rbx
	leaq	112(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1700
	movq	112(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1700:
	movq	64(%rsp), %rdi
	leaq	80(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1702
	movq	80(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1702:
	movq	32(%rsp), %rdi
	leaq	48(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1704
	movq	48(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L1704:
	movq	(%rsp), %rdi
	leaq	16(%rsp), %rax
	cmpq	%rax, %rdi
	je	.L1706
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L1706
.L1715:
	endbr64
	movq	%rax, %rbx
	jmp	.L1700
.L1714:
	endbr64
	movq	%rax, %rbx
	jmp	.L1702
.L1713:
	endbr64
	movq	%rax, %rbx
	jmp	.L1704
	.cfi_endproc
.LFE4173:
	.section	.gcc_except_table
.LLSDAC4173:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4173-.LLSDACSBC4173
.LLSDACSBC4173:
	.uleb128 .LEHB170-.LCOLDB33
	.uleb128 .LEHE170-.LEHB170
	.uleb128 .L1712-.LCOLDB33
	.uleb128 0
	.uleb128 .LEHB171-.LCOLDB33
	.uleb128 .LEHE171-.LEHB171
	.uleb128 .L1713-.LCOLDB33
	.uleb128 0
	.uleb128 .LEHB172-.LCOLDB33
	.uleb128 .LEHE172-.LEHB172
	.uleb128 .L1714-.LCOLDB33
	.uleb128 0
	.uleb128 .LEHB173-.LCOLDB33
	.uleb128 .LEHE173-.LEHB173
	.uleb128 .L1715-.LCOLDB33
	.uleb128 0
	.uleb128 .LEHB174-.LCOLDB33
	.uleb128 .LEHE174-.LEHB174
	.uleb128 .L1716-.LCOLDB33
	.uleb128 0
	.uleb128 .LEHB175-.LCOLDB33
	.uleb128 .LEHE175-.LEHB175
	.uleb128 .L1711-.LCOLDB33
	.uleb128 0
	.uleb128 .LEHB176-.LCOLDB33
	.uleb128 .LEHE176-.LEHB176
	.uleb128 0
	.uleb128 0
.LLSDACSEC4173:
	.section	.text.unlikely
	.text
	.size	_ZN12ParseFormula12parseFormulaEv, .-_ZN12ParseFormula12parseFormulaEv
	.section	.text.unlikely
	.size	_ZN12ParseFormula12parseFormulaEv.cold, .-_ZN12ParseFormula12parseFormulaEv.cold
.LCOLDE33:
	.text
.LHOTE33:
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.type	_GLOBAL__sub_I__ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE, @function
_GLOBAL__sub_I__ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE:
.LFB5007:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	_ZStL8__ioinit(%rip), %rbp
	movq	%rbp, %rdi
	call	_ZNSt8ios_base4InitC1Ev@PLT
	movq	_ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rdi
	movq	%rbp, %rsi
	popq	%rbp
	.cfi_def_cfa_offset 8
	leaq	__dso_handle(%rip), %rdx
	jmp	__cxa_atexit@PLT
	.cfi_endproc
.LFE5007:
	.size	_GLOBAL__sub_I__ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE, .-_GLOBAL__sub_I__ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__ZN12ParseFormulaC2EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
	.weak	_ZZNSt8__detail18__to_chars_10_implImEEvPcjT_E8__digits
	.section	.rodata._ZZNSt8__detail18__to_chars_10_implImEEvPcjT_E8__digits,"aG",@progbits,_ZZNSt8__detail18__to_chars_10_implImEEvPcjT_E8__digits,comdat
	.align 32
	.type	_ZZNSt8__detail18__to_chars_10_implImEEvPcjT_E8__digits, @gnu_unique_object
	.size	_ZZNSt8__detail18__to_chars_10_implImEEvPcjT_E8__digits, 201
_ZZNSt8__detail18__to_chars_10_implImEEvPcjT_E8__digits:
	.string	"00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899"
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC10:
	.long	1065353216
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
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
