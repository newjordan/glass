
/tmp/glass-i32-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000263880 <<glass::engine::Watch>::print_utf8>:
  263880:	push   %rbp
  263881:	push   %r15
  263883:	push   %r14
  263885:	push   %r13
  263887:	push   %r12
  263889:	push   %rbx
  26388a:	sub    $0x118,%rsp
  263891:	mov    %rdx,%r13
  263894:	mov    %rdi,%r15
  263897:	cmpb   $0x1,0xbe(%rdi)
  26389e:	jne    2638cb <<glass::engine::Watch>::print_utf8+0x4b>
  2638a0:	cmpq   $0x0,0x38(%r15)
  2638a5:	jne    2638cb <<glass::engine::Watch>::print_utf8+0x4b>
  2638a7:	mov    0x78(%r15),%rax
  2638ab:	testb  $0x4,0x6c5(%rax)
  2638b2:	jne    2638cb <<glass::engine::Watch>::print_utf8+0x4b>
  2638b4:	cmpq   $0x0,0x50(%rax)
  2638b9:	jne    2638cb <<glass::engine::Watch>::print_utf8+0x4b>
  2638bb:	movzwl 0x64(%rax),%ecx
  2638bf:	test   $0x460,%ecx
  2638c5:	je     264ff0 <<glass::engine::Watch>::print_utf8+0x1770>
  2638cb:	movl   $0x0,0x10(%rsp)
  2638d3:	movl   $0x0,0x80(%rsp)
  2638de:	mov    $0xffffffff,%r8d
  2638e4:	xor    %r14d,%r14d
  2638e7:	lea    0x369ffa(%rip),%rax        # 5cd8e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a8>
  2638ee:	mov    %rax,0xf0(%rsp)
  2638f6:	lea    0x40(%rsp),%rax
  2638fb:	mov    %rax,0x110(%rsp)
  263903:	xor    %edx,%edx
  263905:	mov    %r13,0xc0(%rsp)
  26390d:	mov    %r15,0xc8(%rsp)
  263915:	mov    %rsi,0x18(%rsp)
  26391a:	cmpb   $0x0,0x80(%rsp)
  263922:	je     264419 <<glass::engine::Watch>::print_utf8+0xb99>
  263928:	nopl   0x0(%rax,%rax,1)
  263930:	mov    0x78(%r15),%rbx
  263934:	cmpb   $0x0,0x6c(%rbx)
  263938:	jne    264419 <<glass::engine::Watch>::print_utf8+0xb99>
  26393e:	mov    0x30(%rbx),%eax
  263941:	sub    0x48(%rbx),%eax
  263944:	cltq
  263946:	mov    0x20(%rbx),%rsi
  26394a:	mov    0x28(%rbx),%rcx
  26394e:	lea    (%rcx,%rax,1),%rdi
  263952:	dec    %rdi
  263955:	cmp    %rsi,%rdi
  263958:	mov    $0x0,%eax
  26395d:	cmovae %rsi,%rax
  263961:	sub    %rax,%rdi
  263964:	cmp    %rsi,%rdi
  263967:	jae    265894 <<glass::engine::Watch>::print_utf8+0x2014>
  26396d:	mov    0xa0(%rbx),%rax
  263974:	mov    %rax,0x38(%rsp)
  263979:	mov    0x40(%rbx),%r12
  26397d:	mov    0x58(%rbx),%eax
  263980:	mov    %eax,0x78(%rsp)
  263984:	mov    0x5c(%rbx),%eax
  263987:	mov    %eax,0xa0(%rsp)
  26398e:	movzwl 0x64(%rbx),%eax
  263992:	mov    %eax,0xc(%rsp)
  263996:	mov    0x18(%rbx),%rax
  26399a:	shl    $0x6,%rdi
  26399e:	lea    (%rax,%rdi,1),%rbp
  2639a2:	cmp    %r12d,0x38(%rax,%rdi,1)
  2639a7:	jbe    2639ad <<glass::engine::Watch>::print_utf8+0x12d>
  2639a9:	mov    %r12d,0x38(%rbp)
  2639ad:	mov    %rdx,0x28(%rsp)
  2639b2:	mov    0x28(%rbp),%r10d
  2639b6:	cmp    $0xffffffff,%r10d
  2639ba:	mov    %r12,0x60(%rsp)
  2639bf:	je     263a79 <<glass::engine::Watch>::print_utf8+0x1f9>
  2639c5:	mov    0x30(%rbp),%rax
  2639c9:	cmp    %rax,%r12
  2639cc:	mov    $0x0,%ecx
  2639d1:	cmovb  %rax,%rcx
  2639d5:	mov    %rcx,0x20(%rsp)
  2639da:	movl   $0x20,0x108(%rsp)
  2639e5:	mov    0x78(%rsp),%ecx
  2639e9:	mov    %ecx,0x100(%rsp)
  2639f0:	mov    0xa0(%rsp),%ecx
  2639f7:	mov    %ecx,0x104(%rsp)
  2639fe:	mov    0xc(%rsp),%ecx
  263a02:	mov    %cx,0x10c(%rsp)
  263a0a:	movq   $0x0,0xf8(%rsp)
  263a16:	mov    0x10(%rbp),%rcx
  263a1a:	cmp    %rax,%rcx
  263a1d:	mov    %rax,%rdx
  263a20:	cmovb  %rcx,%rdx
  263a24:	mov    %rdx,0x68(%rsp)
  263a29:	cmp    %r12,%rcx
  263a2c:	mov    %r12,%r9
  263a2f:	cmovb  %rcx,%r9
  263a33:	mov    0x392f06(%rip),%rdx        # 5f6940 <_DYNAMIC+0x320>
  263a3a:	movzbl (%rdx),%edx
  263a3d:	test   %dl,%dl
  263a3f:	je     263b1a <<glass::engine::Watch>::print_utf8+0x29a>
  263a45:	mov    0x392f2c(%rip),%rdx        # 5f6978 <_DYNAMIC+0x358>
  263a4c:	cmp    %r9,%rax
  263a4f:	jae    263a58 <<glass::engine::Watch>::print_utf8+0x1d8>
  263a51:	mov    0x392f28(%rip),%rdx        # 5f6980 <_DYNAMIC+0x360>
  263a58:	lock incq 0x28(%rdx)
  263a5d:	mov    0x392ef4(%rip),%rdx        # 5f6958 <_DYNAMIC+0x338>
  263a64:	lock incq (%rdx)
  263a68:	mov    %r9,%rdx
  263a6b:	sub    0x68(%rsp),%rdx
  263a70:	jne    263acf <<glass::engine::Watch>::print_utf8+0x24f>
  263a72:	xor    %esi,%esi
  263a74:	jmp    263b0e <<glass::engine::Watch>::print_utf8+0x28e>
  263a79:	movl   $0x20,0x108(%rsp)
  263a84:	mov    0x78(%rsp),%eax
  263a88:	mov    %eax,0x100(%rsp)
  263a8f:	mov    0xa0(%rsp),%eax
  263a96:	mov    %eax,0x104(%rsp)
  263a9d:	mov    0xc(%rsp),%eax
  263aa1:	mov    %ax,0x10c(%rsp)
  263aa9:	movq   $0x0,0xf8(%rsp)
  263ab5:	lea    0x30(%rbp),%rax
  263ab9:	mov    %rax,0xd8(%rsp)
  263ac1:	movq   $0xffffffffffffffff,0x20(%rsp)
  263aca:	jmp    263caa <<glass::engine::Watch>::print_utf8+0x42a>
  263acf:	mov    0x392e8a(%rip),%rsi        # 5f6960 <_DYNAMIC+0x340>
  263ad6:	lock add %rdx,(%rsi)
  263ada:	cmp    $0x5,%rdx
  263ade:	jae    263aee <<glass::engine::Watch>::print_utf8+0x26e>
  263ae0:	lea    -0x205907(%rip),%rsi        # 5e1e0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263ae7:	movzbl -0x1(%rdx,%rsi,1),%esi
  263aec:	jmp    263b0e <<glass::engine::Watch>::print_utf8+0x28e>
  263aee:	lea    -0x5(%rdx),%rdi
  263af2:	mov    $0x4,%esi
  263af7:	cmp    $0x4,%rdi
  263afb:	jb     263b0e <<glass::engine::Watch>::print_utf8+0x28e>
  263afd:	add    $0xfffffffffffffff7,%rdx
  263b01:	cmp    $0x8,%rdx
  263b05:	mov    $0x6,%esi
  263b0a:	sbb    $0x0,%rsi
  263b0e:	mov    0x392e3b(%rip),%rdx        # 5f6950 <_DYNAMIC+0x330>
  263b15:	lock incq (%rdx,%rsi,8)
  263b1a:	cmp    %r9,%rax
  263b1d:	mov    %r8,0x58(%rsp)
  263b22:	jae    263c6f <<glass::engine::Watch>::print_utf8+0x3ef>
  263b28:	mov    %rbx,0x98(%rsp)
  263b30:	mov    %r14,0x30(%rsp)
  263b35:	mov    0x20(%rbp),%r13d
  263b39:	mov    0x24(%rbp),%esi
  263b3c:	movzwl 0x2c(%rbp),%edi
  263b40:	mov    0x18(%rbp),%r12
  263b44:	test   %r12,%r12
  263b47:	je     263b54 <<glass::engine::Watch>::print_utf8+0x2d4>
  263b49:	lock incq (%r12)
  263b4e:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  263b54:	mov    %r10d,0x50(%rsp)
  263b59:	mov    %r13d,0x48(%rsp)
  263b5e:	mov    %esi,0x4c(%rsp)
  263b62:	mov    %di,0x54(%rsp)
  263b67:	mov    %r12,0x40(%rsp)
  263b6c:	mov    0x68(%rsp),%rax
  263b71:	lea    0x0(,%rax,8),%rax
  263b79:	lea    (%rax,%rax,2),%rax
  263b7d:	mov    %rbp,0xd0(%rsp)
  263b85:	mov    0x8(%rbp),%rbx
  263b89:	add    %rax,%rbx
  263b8c:	lea    0x0(,%r9,8),%rcx
  263b94:	lea    (%rcx,%rcx,2),%rbp
  263b98:	sub    %rax,%rbp
  263b9b:	mov    %esi,0x70(%rsp)
  263b9f:	mov    %di,0x90(%rsp)
  263ba7:	jmp    263bcc <<glass::engine::Watch>::print_utf8+0x34c>
  263ba9:	nopl   0x0(%rax)
  263bb0:	mov    %r12,(%rbx)
  263bb3:	mov    %r13d,0x8(%rbx)
  263bb7:	mov    %esi,0xc(%rbx)
  263bba:	mov    %r10d,0x10(%rbx)
  263bbe:	mov    %di,0x14(%rbx)
  263bc2:	add    $0x18,%rbx
  263bc6:	add    $0xffffffffffffffe8,%rbp
  263bca:	je     263c12 <<glass::engine::Watch>::print_utf8+0x392>
  263bcc:	test   %r12,%r12
  263bcf:	je     263bdc <<glass::engine::Watch>::print_utf8+0x35c>
  263bd1:	lock incq (%r12)
  263bd6:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  263bdc:	mov    (%rbx),%rax
  263bdf:	test   %rax,%rax
  263be2:	je     263bb0 <<glass::engine::Watch>::print_utf8+0x330>
  263be4:	lock decq (%rax)
  263be8:	jne    263bb0 <<glass::engine::Watch>::print_utf8+0x330>
  263bea:	mov    %rbx,%rdi
  263bed:	mov    %r9,%r14
  263bf0:	mov    %r10d,%r15d
  263bf3:	call   *0x392c8f(%rip)        # 5f6888 <_DYNAMIC+0x268>
  263bf9:	movzwl 0x90(%rsp),%edi
  263c01:	mov    0x70(%rsp),%esi
  263c05:	mov    %r15d,%r10d
  263c08:	mov    %r14,%r9
  263c0b:	mov    0x58(%rsp),%r8
  263c10:	jmp    263bb0 <<glass::engine::Watch>::print_utf8+0x330>
  263c12:	mov    0xd0(%rsp),%rbp
  263c1a:	mov    0x68(%rsp),%rax
  263c1f:	cmp    %eax,0x38(%rbp)
  263c22:	jbe    263c27 <<glass::engine::Watch>::print_utf8+0x3a7>
  263c24:	mov    %eax,0x38(%rbp)
  263c27:	test   %r12,%r12
  263c2a:	mov    0xc0(%rsp),%r13
  263c32:	mov    0xc8(%rsp),%r15
  263c3a:	mov    0x30(%rsp),%r14
  263c3f:	mov    0x98(%rsp),%rbx
  263c47:	je     263c66 <<glass::engine::Watch>::print_utf8+0x3e6>
  263c49:	lock decq (%r12)
  263c4e:	jne    263c66 <<glass::engine::Watch>::print_utf8+0x3e6>
  263c50:	lea    0x40(%rsp),%rdi
  263c55:	mov    %r9,%r12
  263c58:	call   *0x392c2a(%rip)        # 5f6888 <_DYNAMIC+0x268>
  263c5e:	mov    %r12,%r9
  263c61:	mov    0x58(%rsp),%r8
  263c66:	mov    0x10(%rbp),%rcx
  263c6a:	mov    0x60(%rsp),%r12
  263c6f:	lea    0x30(%rbp),%rax
  263c73:	mov    %rax,0xd8(%rsp)
  263c7b:	cmp    %rcx,%r9
  263c7e:	jb     263caa <<glass::engine::Watch>::print_utf8+0x42a>
  263c80:	cmpl   $0xffffffff,0x28(%rbp)
  263c84:	je     263ca3 <<glass::engine::Watch>::print_utf8+0x423>
  263c86:	lea    0x18(%rbp),%rdi
  263c8a:	mov    (%rdi),%rax
  263c8d:	test   %rax,%rax
  263c90:	je     263ca3 <<glass::engine::Watch>::print_utf8+0x423>
  263c92:	lock decq (%rax)
  263c96:	jne    263ca3 <<glass::engine::Watch>::print_utf8+0x423>
  263c98:	call   *0x392bea(%rip)        # 5f6888 <_DYNAMIC+0x268>
  263c9e:	mov    0x58(%rsp),%r8
  263ca3:	movl   $0xffffffff,0x28(%rbp)
  263caa:	mov    0x10(%rbp),%rdx
  263cae:	mov    0x30(%rbp),%rax
  263cb2:	cmp    %r12,%rdx
  263cb5:	mov    %r12,%rsi
  263cb8:	cmovb  %rdx,%rsi
  263cbc:	cmp    %rax,%rsi
  263cbf:	cmova  %rsi,%rax
  263cc3:	mov    %rdx,%rcx
  263cc6:	mov    %rax,0x30(%rbp)
  263cca:	sub    %r12,%rcx
  263ccd:	mov    %rcx,0x30(%rsp)
  263cd2:	jb     26521e <<glass::engine::Watch>::print_utf8+0x199e>
  263cd8:	mov    0x28(%rsp),%rdx
  263cdd:	cmp    %r13,%rdx
  263ce0:	jae    2642e0 <<glass::engine::Watch>::print_utf8+0xa60>
  263ce6:	mov    %rbx,0x98(%rsp)
  263cee:	mov    %rbp,0xd0(%rsp)
  263cf6:	mov    0x8(%rbp),%rcx
  263cfa:	lea    (%r12,%r12,2),%rax
  263cfe:	mov    %rcx,0x70(%rsp)
  263d03:	lea    (%rcx,%rax,8),%rax
  263d07:	mov    %rax,0xb8(%rsp)
  263d0f:	mov    0xc(%rsp),%eax
  263d13:	mov    %eax,%ecx
  263d15:	or     $0x20,%ecx
  263d18:	mov    %ecx,0x8c(%rsp)
  263d1f:	or     $0x40,%eax
  263d22:	mov    %eax,0xa8(%rsp)
  263d29:	mov    $0x1,%al
  263d2b:	mov    %eax,0x90(%rsp)
  263d32:	xor    %r11d,%r11d
  263d35:	xor    %edi,%edi
  263d37:	mov    %r12,%rbx
  263d3a:	mov    %r12,%r10
  263d3d:	mov    0x18(%rsp),%rsi
  263d42:	jmp    263daf <<glass::engine::Watch>::print_utf8+0x52f>
  263d44:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  263d50:	movq   $0x0,(%rbx)
  263d57:	mov    0x78(%rsp),%eax
  263d5b:	mov    %eax,0x8(%rbx)
  263d5e:	mov    0xa0(%rsp),%eax
  263d65:	mov    %eax,0xc(%rbx)
  263d68:	movl   $0x20,0x10(%rbx)
  263d6f:	mov    0xa8(%rsp),%eax
  263d76:	mov    %ax,0x14(%rbx)
  263d7a:	movl   $0x0,0x90(%rsp)
  263d85:	xor    %r11d,%r11d
  263d88:	cmp    0x38(%rsp),%r9
  263d8d:	setae  %r11b
  263d91:	mov    %r9,%r10
  263d94:	sub    %r11,%r10
  263d97:	inc    %rdi
  263d9a:	mov    %r9,%rbx
  263d9d:	add    %r15,%rdx
  263da0:	mov    %ebp,%r8d
  263da3:	mov    %r15,%r14
  263da6:	cmp    %r13,%rdx
  263da9:	jae    2642fd <<glass::engine::Watch>::print_utf8+0xa7d>
  263daf:	mov    %rdx,%r15
  263db2:	movzbl (%rsi,%rdx,1),%ebp
  263db6:	test   %bpl,%bpl
  263db9:	js     263de0 <<glass::engine::Watch>::print_utf8+0x560>
  263dbb:	mov    $0x1,%edx
  263dc0:	lea    -0x7f(%rbp),%eax
  263dc3:	cmp    $0x21,%eax
  263dc6:	jae    263f48 <<glass::engine::Watch>::print_utf8+0x6c8>
  263dcc:	jmp    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263dd1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  263de0:	lea    0x3e(%rbp),%eax
  263de3:	cmp    $0x1e,%al
  263de5:	jae    263e10 <<glass::engine::Watch>::print_utf8+0x590>
  263de7:	lea    0x1(%r15),%rax
  263deb:	cmp    %r13,%rax
  263dee:	jae    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263df4:	movzbl (%rsi,%rax,1),%eax
  263df8:	cmp    $0xc0,%al
  263dfa:	jge    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263e00:	and    $0x1f,%ebp
  263e03:	shl    $0x6,%ebp
  263e06:	mov    $0x2,%edx
  263e0b:	jmp    263f1b <<glass::engine::Watch>::print_utf8+0x69b>
  263e10:	mov    %ebp,%eax
  263e12:	and    $0xf0,%al
  263e14:	cmp    $0xe0,%al
  263e16:	jne    263e30 <<glass::engine::Watch>::print_utf8+0x5b0>
  263e18:	mov    $0xbf,%al
  263e1a:	cmp    $0xe0,%ebp
  263e20:	je     263e53 <<glass::engine::Watch>::print_utf8+0x5d3>
  263e22:	mov    $0x80,%cl
  263e24:	cmp    $0xed,%ebp
  263e2a:	jne    263e55 <<glass::engine::Watch>::print_utf8+0x5d5>
  263e2c:	mov    $0x9f,%al
  263e2e:	jmp    263e55 <<glass::engine::Watch>::print_utf8+0x5d5>
  263e30:	lea    0x10(%rbp),%eax
  263e33:	cmp    $0x5,%al
  263e35:	jae    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263e3b:	mov    $0x80,%al
  263e3d:	cmp    $0xf4,%ebp
  263e43:	je     263ea7 <<glass::engine::Watch>::print_utf8+0x627>
  263e45:	mov    $0xbf,%cl
  263e47:	cmp    $0xf0,%ebp
  263e4d:	jne    263ea9 <<glass::engine::Watch>::print_utf8+0x629>
  263e4f:	mov    $0x90,%al
  263e51:	jmp    263ea9 <<glass::engine::Watch>::print_utf8+0x629>
  263e53:	mov    $0xa0,%cl
  263e55:	lea    0x1(%r15),%rdx
  263e59:	cmp    %r13,%rdx
  263e5c:	jae    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263e62:	movzbl (%rsi,%rdx,1),%edx
  263e66:	cmp    %dl,%cl
  263e68:	ja     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263e6e:	cmp    %al,%dl
  263e70:	ja     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263e76:	lea    0x2(%r15),%rax
  263e7a:	cmp    %r13,%rax
  263e7d:	jae    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263e83:	movzbl (%rsi,%rax,1),%eax
  263e87:	cmp    $0xc0,%al
  263e89:	jge    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263e8f:	movzbl %dl,%ecx
  263e92:	and    $0x3f,%ecx
  263e95:	shl    $0x6,%ecx
  263e98:	and    $0xf,%ebp
  263e9b:	shl    $0xc,%ebp
  263e9e:	or     %ecx,%ebp
  263ea0:	mov    $0x3,%edx
  263ea5:	jmp    263f1b <<glass::engine::Watch>::print_utf8+0x69b>
  263ea7:	mov    $0x8f,%cl
  263ea9:	lea    0x1(%r15),%rdx
  263ead:	cmp    %r13,%rdx
  263eb0:	jae    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263eb6:	movzbl (%rsi,%rdx,1),%edx
  263eba:	cmp    %dl,%al
  263ebc:	ja     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263ec2:	cmp    %cl,%dl
  263ec4:	ja     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263eca:	lea    0x2(%r15),%rax
  263ece:	cmp    %r13,%rax
  263ed1:	jae    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263ed7:	movzbl (%rsi,%rax,1),%ecx
  263edb:	cmp    $0xbf,%cl
  263ede:	jg     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263ee4:	lea    0x3(%r15),%rax
  263ee8:	cmp    %r13,%rax
  263eeb:	jae    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263ef1:	movzbl (%rsi,%rax,1),%eax
  263ef5:	cmp    $0xbf,%al
  263ef7:	jg     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263efd:	movzbl %dl,%edx
  263f00:	and    $0x3f,%ecx
  263f03:	shl    $0x6,%ecx
  263f06:	and    $0x3f,%edx
  263f09:	shl    $0xc,%edx
  263f0c:	and    $0x7,%ebp
  263f0f:	shl    $0x12,%ebp
  263f12:	or     %edx,%ebp
  263f14:	or     %ecx,%ebp
  263f16:	mov    $0x4,%edx
  263f1b:	mov    %ebp,%ecx
  263f1d:	xor    $0xd800,%ecx
  263f23:	add    $0xffef0000,%ecx
  263f29:	cmp    $0xffef0800,%ecx
  263f2f:	jb     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263f35:	and    $0x3f,%al
  263f37:	movzbl %al,%eax
  263f3a:	or     %eax,%ebp
  263f3c:	lea    -0x7f(%rbp),%eax
  263f3f:	cmp    $0x21,%eax
  263f42:	jb     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263f48:	cmp    $0xffffffff,%r8d
  263f4c:	je     263f70 <<glass::engine::Watch>::print_utf8+0x6f0>
  263f4e:	lea    -0x20(%r8),%eax
  263f52:	cmp    $0x5f,%eax
  263f55:	jae    263f80 <<glass::engine::Watch>::print_utf8+0x700>
  263f57:	mov    $0x1,%ecx
  263f5c:	cmpb   $0x0,0x10(%rsp)
  263f61:	jne    26407b <<glass::engine::Watch>::print_utf8+0x7fb>
  263f67:	jmp    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  263f6c:	nopl   0x0(%rax)
  263f70:	mov    %rbx,%r9
  263f73:	jmp    263d9d <<glass::engine::Watch>::print_utf8+0x51d>
  263f78:	nopl   0x0(%rax,%rax,1)
  263f80:	mov    %rbx,0x68(%rsp)
  263f85:	mov    0x39586d(%rip),%eax        # 5f97f8 <glass::engine::width_of::CACHE+0x10>
  263f8b:	test   %eax,%eax
  263f8d:	jne    26426e <<glass::engine::Watch>::print_utf8+0x9ee>
  263f93:	mov    %r8d,%ebx
  263f96:	mov    0x395853(%rip),%rsi        # 5f97f0 <glass::engine::width_of::CACHE+0x8>
  263f9d:	cmp    %rbx,%rsi
  263fa0:	jbe    265858 <<glass::engine::Watch>::print_utf8+0x1fd8>
  263fa6:	mov    0x39583b(%rip),%r12        # 5f97e8 <glass::engine::width_of::CACHE>
  263fad:	movzbl (%r12,%rbx,1),%eax
  263fb2:	movzbl %al,%ecx
  263fb5:	test   %cl,%cl
  263fb7:	mov    %rdx,0x28(%rsp)
  263fbc:	js     263fd7 <<glass::engine::Watch>::print_utf8+0x757>
  263fbe:	mov    $0x1,%dl
  263fc0:	mov    0x18(%rsp),%rsi
  263fc5:	test   %dl,%dl
  263fc7:	mov    0x68(%rsp),%rbx
  263fcc:	jne    264063 <<glass::engine::Watch>::print_utf8+0x7e3>
  263fd2:	jmp    26435d <<glass::engine::Watch>::print_utf8+0xadd>
  263fd7:	cmp    $0xfe,%ecx
  263fdd:	mov    0x18(%rsp),%rsi
  263fe2:	je     26437d <<glass::engine::Watch>::print_utf8+0xafd>
  263fe8:	mov    $0xfe,%al
  263fea:	cmp    $0x7f,%r8d
  263fee:	jae    263ff9 <<glass::engine::Watch>::print_utf8+0x779>
  263ff0:	mov    $0x1,%ecx
  263ff5:	xor    %edx,%edx
  263ff7:	jmp    264052 <<glass::engine::Watch>::print_utf8+0x7d2>
  263ff9:	cmp    $0xa0,%r8d
  264000:	jb     264050 <<glass::engine::Watch>::print_utf8+0x7d0>
  264002:	mov    %rdi,0xb0(%rsp)
  26400a:	mov    %r8d,%edi
  26400d:	mov    %r8,0x58(%rsp)
  264012:	mov    %r10,0xe8(%rsp)
  26401a:	mov    %r11,0xe0(%rsp)
  264022:	call   29a1a0 <unicode_width::tables::lookup_width>
  264027:	mov    0xe0(%rsp),%r11
  26402f:	mov    0xe8(%rsp),%r10
  264037:	mov    0xb0(%rsp),%rdi
  26403f:	mov    0x58(%rsp),%r8
  264044:	mov    0x18(%rsp),%rsi
  264049:	movzbl %al,%ecx
  26404c:	mov    $0x1,%dl
  26404e:	jmp    264052 <<glass::engine::Watch>::print_utf8+0x7d2>
  264050:	xor    %edx,%edx
  264052:	mov    %al,(%r12,%rbx,1)
  264056:	test   %dl,%dl
  264058:	mov    0x68(%rsp),%rbx
  26405d:	je     26435d <<glass::engine::Watch>::print_utf8+0xadd>
  264063:	lea    -0x1(%rcx),%rax
  264067:	cmp    $0x1,%rax
  26406b:	mov    0x28(%rsp),%rdx
  264070:	mov    0x60(%rsp),%r12
  264075:	ja     2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  26407b:	test   $0x1,%r11b
  26407f:	jne    2642ec <<glass::engine::Watch>::print_utf8+0xa6c>
  264085:	lea    (%rcx,%r10,1),%rax
  264089:	cmp    0x38(%rsp),%rax
  26408e:	ja     2642f1 <<glass::engine::Watch>::print_utf8+0xa71>
  264094:	mov    %rax,0x58(%rsp)
  264099:	mov    %rbx,%r9
  26409c:	mov    %r10,%rbx
  26409f:	sub    %r12,%rbx
  2640a2:	cmp    0x20(%rsp),%r10
  2640a7:	jae    264110 <<glass::engine::Watch>::print_utf8+0x890>
  2640a9:	cmp    0x30(%rsp),%rbx
  2640ae:	mov    0x70(%rsp),%r11
  2640b3:	jae    2658a1 <<glass::engine::Watch>::print_utf8+0x2021>
  2640b9:	lea    (%r10,%r10,2),%rax
  2640bd:	testb  $0x60,0x14(%r11,%rax,8)
  2640c3:	jne    264358 <<glass::engine::Watch>::print_utf8+0xad8>
  2640c9:	lea    (%r11,%rax,8),%r12
  2640cd:	cmp    $0x2,%rcx
  2640d1:	jne    2641a2 <<glass::engine::Watch>::print_utf8+0x922>
  2640d7:	lea    0x1(%rbx),%rax
  2640db:	cmp    0x30(%rsp),%rax
  2640e0:	jae    2658bf <<glass::engine::Watch>::print_utf8+0x203f>
  2640e6:	mov    %r14,%rcx
  2640e9:	lea    (%rax,%rax,2),%rax
  2640ed:	mov    $0x1,%r14b
  2640f0:	mov    0xb8(%rsp),%r13
  2640f8:	testb  $0x60,0x14(%r13,%rax,8)
  2640fe:	mov    0x8c(%rsp),%r13d
  264106:	je     26413e <<glass::engine::Watch>::print_utf8+0x8be>
  264108:	jmp    264362 <<glass::engine::Watch>::print_utf8+0xae2>
  26410d:	nopl   (%rax)
  264110:	cmp    0x30(%rsp),%rbx
  264115:	mov    0x70(%rsp),%r11
  26411a:	jae    2658d1 <<glass::engine::Watch>::print_utf8+0x2051>
  264120:	lea    (%r10,%r10,2),%rax
  264124:	lea    (%r11,%rax,8),%r12
  264128:	cmp    $0x2,%rcx
  26412c:	sete   %r14b
  264130:	mov    0xc(%rsp),%r13d
  264135:	cmove  0x8c(%rsp),%r13d
  26413e:	mov    (%r12),%rax
  264142:	test   %rax,%rax
  264145:	je     2641c0 <<glass::engine::Watch>::print_utf8+0x940>
  264147:	lock decq (%rax)
  26414b:	jne    2641c0 <<glass::engine::Watch>::print_utf8+0x940>
  26414d:	mov    %rdi,0xb0(%rsp)
  264155:	mov    %r12,%rdi
  264158:	mov    %r15,0xe0(%rsp)
  264160:	mov    %r8,%r15
  264163:	mov    %rdx,0x28(%rsp)
  264168:	mov    %r10,0xe8(%rsp)
  264170:	call   *0x392712(%rip)        # 5f6888 <_DYNAMIC+0x268>
  264176:	mov    0x70(%rsp),%r11
  26417b:	mov    0xe8(%rsp),%r10
  264183:	mov    0xb0(%rsp),%rdi
  26418b:	mov    0x28(%rsp),%rdx
  264190:	mov    %r15,%r8
  264193:	mov    0xe0(%rsp),%r15
  26419b:	mov    0x18(%rsp),%rsi
  2641a0:	jmp    2641c0 <<glass::engine::Watch>::print_utf8+0x940>
  2641a2:	xor    %r14d,%r14d
  2641a5:	mov    0xc(%rsp),%r13d
  2641aa:	mov    (%r12),%rax
  2641ae:	test   %rax,%rax
  2641b1:	jne    264147 <<glass::engine::Watch>::print_utf8+0x8c7>
  2641b3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2641c0:	lea    (%r10,%r10,2),%rax
  2641c4:	movq   $0x0,(%r12)
  2641cc:	mov    0x78(%rsp),%ecx
  2641d0:	mov    %ecx,0x8(%r11,%rax,8)
  2641d5:	mov    0xa0(%rsp),%ecx
  2641dc:	mov    %ecx,0xc(%r11,%rax,8)
  2641e1:	mov    %r13w,0x14(%r11,%rax,8)
  2641e7:	mov    %r8d,0x10(%r11,%rax,8)
  2641ec:	test   %r14b,%r14b
  2641ef:	mov    0xc0(%rsp),%r13
  2641f7:	mov    0x60(%rsp),%r12
  2641fc:	mov    0x58(%rsp),%r9
  264201:	je     263d85 <<glass::engine::Watch>::print_utf8+0x505>
  264207:	inc    %rbx
  26420a:	cmp    0x30(%rsp),%rbx
  26420f:	jae    2658aa <<glass::engine::Watch>::print_utf8+0x202a>
  264215:	lea    (%rbx,%rbx,2),%rax
  264219:	mov    0xb8(%rsp),%rcx
  264221:	lea    (%rcx,%rax,8),%rbx
  264225:	mov    (%rcx,%rax,8),%rax
  264229:	test   %rax,%rax
  26422c:	je     263d50 <<glass::engine::Watch>::print_utf8+0x4d0>
  264232:	lock decq (%rax)
  264236:	jne    263d50 <<glass::engine::Watch>::print_utf8+0x4d0>
  26423c:	mov    %r15,%r13
  26423f:	mov    %rdi,%r15
  264242:	mov    %rbx,%rdi
  264245:	mov    %rdx,%r14
  264248:	call   *0x39263a(%rip)        # 5f6888 <_DYNAMIC+0x268>
  26424e:	mov    0x58(%rsp),%r9
  264253:	mov    %r15,%rdi
  264256:	mov    %r13,%r15
  264259:	mov    0xc0(%rsp),%r13
  264261:	mov    %r14,%rdx
  264264:	mov    0x18(%rsp),%rsi
  264269:	jmp    263d50 <<glass::engine::Watch>::print_utf8+0x4d0>
  26426e:	mov    %r8,0x58(%rsp)
  264273:	mov    %r15,0xe0(%rsp)
  26427b:	mov    %rdx,%r15
  26427e:	mov    %rdi,0xb0(%rsp)
  264286:	mov    %r10,0xe8(%rsp)
  26428e:	mov    %r11,%r12
  264291:	call   18c892 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  264296:	mov    %r12,%r11
  264299:	mov    0xe8(%rsp),%r10
  2642a1:	mov    0xb0(%rsp),%rdi
  2642a9:	mov    %r15,%rdx
  2642ac:	mov    0xe0(%rsp),%r15
  2642b4:	mov    0x58(%rsp),%r8
  2642b9:	mov    %r8d,%ebx
  2642bc:	mov    0x39552d(%rip),%rsi        # 5f97f0 <glass::engine::width_of::CACHE+0x8>
  2642c3:	cmp    %rbx,%rsi
  2642c6:	ja     263fa6 <<glass::engine::Watch>::print_utf8+0x726>
  2642cc:	jmp    265858 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2642d1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2642e0:	xor    %edi,%edi
  2642e2:	xor    %r11d,%r11d
  2642e5:	mov    0x18(%rsp),%rsi
  2642ea:	jmp    264344 <<glass::engine::Watch>::print_utf8+0xac4>
  2642ec:	mov    $0x1,%r11b
  2642ef:	jmp    2642f4 <<glass::engine::Watch>::print_utf8+0xa74>
  2642f1:	xor    %r11d,%r11d
  2642f4:	mov    %rbx,%r9
  2642f7:	mov    %r8d,%ebp
  2642fa:	mov    %r15,%rdx
  2642fd:	cmp    %r12,%r9
  264300:	jbe    264317 <<glass::engine::Watch>::print_utf8+0xa97>
  264302:	mov    0xd8(%rsp),%rcx
  26430a:	mov    (%rcx),%rax
  26430d:	cmp    %rax,%r9
  264310:	cmova  %r9,%rax
  264314:	mov    %rax,(%rcx)
  264317:	cmp    $0x8,%rdi
  26431b:	setae  %al
  26431e:	testb  $0x1,0x90(%rsp)
  264326:	mov    0xc8(%rsp),%r15
  26432e:	jne    264332 <<glass::engine::Watch>::print_utf8+0xab2>
  264330:	xor    %eax,%eax
  264332:	test   %al,%al
  264334:	jne    264392 <<glass::engine::Watch>::print_utf8+0xb12>
  264336:	mov    %r10,%r12
  264339:	mov    %ebp,%r8d
  26433c:	mov    0x98(%rsp),%rbx
  264344:	mov    %r12,0x40(%rbx)
  264348:	mov    %r11b,0x6c(%rbx)
  26434c:	add    %rdi,0xa0(%r15)
  264353:	jmp    264419 <<glass::engine::Watch>::print_utf8+0xb99>
  264358:	xor    %r11d,%r11d
  26435b:	jmp    2642f7 <<glass::engine::Watch>::print_utf8+0xa77>
  26435d:	mov    %rbx,%r9
  264360:	jmp    264382 <<glass::engine::Watch>::print_utf8+0xb02>
  264362:	xor    %r11d,%r11d
  264365:	mov    %r8d,%ebp
  264368:	mov    %r15,%rdx
  26436b:	mov    0xc0(%rsp),%r13
  264373:	mov    %rcx,%r14
  264376:	mov    0x60(%rsp),%r12
  26437b:	jmp    2642fd <<glass::engine::Watch>::print_utf8+0xa7d>
  26437d:	mov    0x68(%rsp),%r9
  264382:	mov    %r8d,%ebp
  264385:	mov    %r15,%rdx
  264388:	mov    0x60(%rsp),%r12
  26438d:	jmp    2642fd <<glass::engine::Watch>::print_utf8+0xa7d>
  264392:	mov    %rdx,0x28(%rsp)
  264397:	movzbl %r11b,%edx
  26439b:	add    %r10,%rdx
  26439e:	mov    %rdi,0xb0(%rsp)
  2643a6:	mov    0xd0(%rsp),%rdi
  2643ae:	mov    %r12,%rsi
  2643b1:	lea    0xf8(%rsp),%rcx
  2643b9:	mov    %r10,%r12
  2643bc:	mov    %r11,%rbx
  2643bf:	call   2a3000 <glass::engine::note_uniform_span>
  2643c4:	mov    %rbx,%r11
  2643c7:	mov    0xb0(%rsp),%rdi
  2643cf:	mov    0x28(%rsp),%rdx
  2643d4:	mov    0x18(%rsp),%rsi
  2643d9:	jmp    264339 <<glass::engine::Watch>::print_utf8+0xab9>
  2643de:	xchg   %ax,%ax
  2643e0:	mov    0xc8(%rsp),%r15
  2643e8:	mov    %r15,%rdi
  2643eb:	mov    %ebp,%esi
  2643ed:	mov    %r8,%rbx
  2643f0:	mov    %rdx,%r14
  2643f3:	call   3417f0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  2643f8:	mov    %r14,%rdx
  2643fb:	mov    %rbx,%r8
  2643fe:	mov    0x18(%rsp),%rsi
  264403:	mov    0x30(%rsp),%r14
  264408:	add    %r14,%rdx
  26440b:	cmpb   $0x0,0x80(%rsp)
  264413:	jne    263930 <<glass::engine::Watch>::print_utf8+0xb0>
  264419:	mov    %r8d,%ebp
  26441c:	mov    %r14,%rbx
  26441f:	mov    %rdx,%r14
  264422:	cmp    %r13,%rdx
  264425:	jae    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  26442b:	movzbl (%rsi,%r14,1),%r8d
  264430:	test   %r8b,%r8b
  264433:	js     264450 <<glass::engine::Watch>::print_utf8+0xbd0>
  264435:	mov    $0x1,%edx
  26443a:	lea    -0x7f(%r8),%eax
  26443e:	cmp    $0x21,%eax
  264441:	jae    2645d8 <<glass::engine::Watch>::print_utf8+0xd58>
  264447:	jmp    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  26444c:	nopl   0x0(%rax)
  264450:	lea    0x3e(%r8),%eax
  264454:	cmp    $0x1e,%al
  264456:	jae    264490 <<glass::engine::Watch>::print_utf8+0xc10>
  264458:	lea    0x1(%r14),%rax
  26445c:	cmp    %r13,%rax
  26445f:	jae    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  264465:	movzbl (%rsi,%rax,1),%eax
  264469:	cmp    $0xc0,%al
  26446b:	jge    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  264471:	and    $0x1f,%r8d
  264475:	shl    $0x6,%r8d
  264479:	mov    $0x2,%edx
  26447e:	jmp    2645a8 <<glass::engine::Watch>::print_utf8+0xd28>
  264483:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  264490:	mov    %r8d,%eax
  264493:	and    $0xf0,%al
  264495:	cmp    $0xe0,%al
  264497:	jne    2644b3 <<glass::engine::Watch>::print_utf8+0xc33>
  264499:	mov    $0xbf,%al
  26449b:	cmp    $0xe0,%r8d
  2644a2:	je     2644d9 <<glass::engine::Watch>::print_utf8+0xc59>
  2644a4:	mov    $0x80,%cl
  2644a6:	cmp    $0xed,%r8d
  2644ad:	jne    2644db <<glass::engine::Watch>::print_utf8+0xc5b>
  2644af:	mov    $0x9f,%al
  2644b1:	jmp    2644db <<glass::engine::Watch>::print_utf8+0xc5b>
  2644b3:	lea    0x10(%r8),%eax
  2644b7:	cmp    $0x5,%al
  2644b9:	jae    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  2644bf:	mov    $0x80,%al
  2644c1:	cmp    $0xf4,%r8d
  2644c8:	je     264530 <<glass::engine::Watch>::print_utf8+0xcb0>
  2644ca:	mov    $0xbf,%cl
  2644cc:	cmp    $0xf0,%r8d
  2644d3:	jne    264532 <<glass::engine::Watch>::print_utf8+0xcb2>
  2644d5:	mov    $0x90,%al
  2644d7:	jmp    264532 <<glass::engine::Watch>::print_utf8+0xcb2>
  2644d9:	mov    $0xa0,%cl
  2644db:	lea    0x1(%r14),%rdx
  2644df:	cmp    %r13,%rdx
  2644e2:	jae    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  2644e8:	movzbl (%rsi,%rdx,1),%edx
  2644ec:	cmp    %dl,%cl
  2644ee:	ja     264efe <<glass::engine::Watch>::print_utf8+0x167e>
  2644f4:	cmp    %al,%dl
  2644f6:	ja     264efe <<glass::engine::Watch>::print_utf8+0x167e>
  2644fc:	lea    0x2(%r14),%rax
  264500:	cmp    %r13,%rax
  264503:	jae    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  264509:	movzbl (%rsi,%rax,1),%eax
  26450d:	cmp    $0xc0,%al
  26450f:	jge    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  264515:	movzbl %dl,%ecx
  264518:	and    $0x3f,%ecx
  26451b:	shl    $0x6,%ecx
  26451e:	and    $0xf,%r8d
  264522:	shl    $0xc,%r8d
  264526:	or     %ecx,%r8d
  264529:	mov    $0x3,%edx
  26452e:	jmp    2645a8 <<glass::engine::Watch>::print_utf8+0xd28>
  264530:	mov    $0x8f,%cl
  264532:	lea    0x1(%r14),%rdx
  264536:	cmp    %r13,%rdx
  264539:	jae    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  26453f:	movzbl (%rsi,%rdx,1),%edx
  264543:	cmp    %dl,%al
  264545:	ja     264efe <<glass::engine::Watch>::print_utf8+0x167e>
  26454b:	cmp    %cl,%dl
  26454d:	ja     264efe <<glass::engine::Watch>::print_utf8+0x167e>
  264553:	lea    0x2(%r14),%rax
  264557:	cmp    %r13,%rax
  26455a:	jae    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  264560:	movzbl (%rsi,%rax,1),%ecx
  264564:	cmp    $0xbf,%cl
  264567:	jg     264efe <<glass::engine::Watch>::print_utf8+0x167e>
  26456d:	lea    0x3(%r14),%rax
  264571:	cmp    %r13,%rax
  264574:	jae    264efe <<glass::engine::Watch>::print_utf8+0x167e>
  26457a:	movzbl (%rsi,%rax,1),%eax
  26457e:	cmp    $0xbf,%al
  264580:	jg     264efe <<glass::engine::Watch>::print_utf8+0x167e>
  264586:	movzbl %dl,%edx
  264589:	and    $0x3f,%ecx
  26458c:	shl    $0x6,%ecx
  26458f:	and    $0x3f,%edx
  264592:	shl    $0xc,%edx
  264595:	and    $0x7,%r8d
  264599:	shl    $0x12,%r8d
  26459d:	or     %edx,%r8d
  2645a0:	or     %ecx,%r8d
  2645a3:	mov    $0x4,%edx
  2645a8:	mov    %r8d,%ecx
  2645ab:	xor    $0xd800,%ecx
  2645b1:	add    $0xffef0000,%ecx
  2645b7:	cmp    $0xffef0800,%ecx
  2645bd:	jb     264efe <<glass::engine::Watch>::print_utf8+0x167e>
  2645c3:	and    $0x3f,%al
  2645c5:	movzbl %al,%eax
  2645c8:	or     %eax,%r8d
  2645cb:	lea    -0x7f(%r8),%eax
  2645cf:	cmp    $0x21,%eax
  2645d2:	jb     264efe <<glass::engine::Watch>::print_utf8+0x167e>
  2645d8:	cmp    $0xffffffff,%ebp
  2645db:	je     264ec0 <<glass::engine::Watch>::print_utf8+0x1640>
  2645e1:	mov    %r14,0x30(%rsp)
  2645e6:	lea    -0x20(%rbp),%eax
  2645e9:	cmp    $0x5f,%eax
  2645ec:	jae    264610 <<glass::engine::Watch>::print_utf8+0xd90>
  2645ee:	mov    $0x1,%r12d
  2645f4:	cmpb   $0x0,0x10(%rsp)
  2645f9:	je     2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  2645ff:	jmp    2646bc <<glass::engine::Watch>::print_utf8+0xe3c>
  264604:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  264610:	cmpb   $0x0,0x80(%rsp)
  264618:	je     2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  26461e:	mov    0x3951d4(%rip),%eax        # 5f97f8 <glass::engine::width_of::CACHE+0x10>
  264624:	test   %eax,%eax
  264626:	jne    264ed6 <<glass::engine::Watch>::print_utf8+0x1656>
  26462c:	mov    %ebp,%ebx
  26462e:	mov    0x3951bb(%rip),%rsi        # 5f97f0 <glass::engine::width_of::CACHE+0x8>
  264635:	cmp    %rbx,%rsi
  264638:	jbe    265858 <<glass::engine::Watch>::print_utf8+0x1fd8>
  26463e:	mov    0x3951a3(%rip),%r14        # 5f97e8 <glass::engine::width_of::CACHE>
  264645:	movzbl (%r14,%rbx,1),%eax
  26464a:	movzbl %al,%r12d
  26464e:	test   %r12b,%r12b
  264651:	js     26465e <<glass::engine::Watch>::print_utf8+0xdde>
  264653:	mov    $0x1,%cl
  264655:	test   %cl,%cl
  264657:	jne    2646ad <<glass::engine::Watch>::print_utf8+0xe2d>
  264659:	jmp    2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  26465e:	cmp    $0xfe,%r12d
  264665:	je     2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  26466b:	mov    $0xfe,%al
  26466d:	cmp    $0x7f,%ebp
  264670:	jae    26467c <<glass::engine::Watch>::print_utf8+0xdfc>
  264672:	mov    $0x1,%r12d
  264678:	xor    %ecx,%ecx
  26467a:	jmp    2646a1 <<glass::engine::Watch>::print_utf8+0xe21>
  26467c:	cmp    $0xa0,%ebp
  264682:	jb     26469f <<glass::engine::Watch>::print_utf8+0xe1f>
  264684:	mov    %ebp,%edi
  264686:	mov    %r8,%r15
  264689:	mov    %rdx,%r12
  26468c:	call   29a1a0 <unicode_width::tables::lookup_width>
  264691:	mov    %r12,%rdx
  264694:	mov    %r15,%r8
  264697:	movzbl %al,%r12d
  26469b:	mov    $0x1,%cl
  26469d:	jmp    2646a1 <<glass::engine::Watch>::print_utf8+0xe21>
  26469f:	xor    %ecx,%ecx
  2646a1:	mov    %al,(%r14,%rbx,1)
  2646a5:	test   %cl,%cl
  2646a7:	je     2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  2646ad:	lea    -0x1(%r12),%rax
  2646b2:	cmp    $0x1,%rax
  2646b6:	ja     2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  2646bc:	mov    0xc8(%rsp),%rax
  2646c4:	mov    0x78(%rax),%r9
  2646c8:	cmpb   $0x0,0x6c(%r9)
  2646cd:	jne    2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  2646d3:	mov    0x40(%r9),%rbx
  2646d7:	mov    0xa0(%r9),%r11
  2646de:	lea    (%rbx,%r12,1),%r10
  2646e2:	cmp    %r11,%r10
  2646e5:	ja     2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  2646eb:	mov    0x30(%r9),%eax
  2646ef:	sub    0x48(%r9),%eax
  2646f3:	cltq
  2646f5:	mov    0x20(%r9),%rsi
  2646f9:	mov    0x28(%r9),%rcx
  2646fd:	lea    (%rcx,%rax,1),%rdi
  264701:	dec    %rdi
  264704:	cmp    %rsi,%rdi
  264707:	mov    $0x0,%eax
  26470c:	cmovae %rsi,%rax
  264710:	sub    %rax,%rdi
  264713:	cmp    %rsi,%rdi
  264716:	jae    2658fb <<glass::engine::Watch>::print_utf8+0x207b>
  26471c:	mov    0x58(%r9),%eax
  264720:	mov    %eax,0x58(%rsp)
  264724:	mov    0x5c(%r9),%eax
  264728:	mov    %eax,0xa0(%rsp)
  26472f:	movzwl 0x64(%r9),%r14d
  264734:	mov    0x18(%r9),%rax
  264738:	shl    $0x6,%rdi
  26473c:	lea    (%rax,%rdi,1),%r15
  264740:	lea    (%rax,%rdi,1),%rcx
  264744:	add    $0x18,%rcx
  264748:	mov    %rcx,0x78(%rsp)
  26474d:	mov    0x28(%rax,%rdi,1),%eax
  264751:	cmp    $0xffffffff,%eax
  264754:	je     264761 <<glass::engine::Watch>::print_utf8+0xee1>
  264756:	mov    0x78(%rsp),%rcx
  26475b:	cmp    0x30(%r15),%rbx
  26475f:	jae    26477a <<glass::engine::Watch>::print_utf8+0xefa>
  264761:	mov    0x10(%r15),%rsi
  264765:	cmp    %rsi,%rbx
  264768:	jae    265908 <<glass::engine::Watch>::print_utf8+0x2088>
  26476e:	lea    (%rbx,%rbx,2),%rcx
  264772:	shl    $0x3,%rcx
  264776:	add    0x8(%r15),%rcx
  26477a:	testb  $0x60,0x14(%rcx)
  26477e:	jne    2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  264784:	cmp    $0x2,%r12
  264788:	jne    2647c1 <<glass::engine::Watch>::print_utf8+0xf41>
  26478a:	lea    0x1(%rbx),%rdi
  26478e:	cmp    $0xffffffff,%eax
  264791:	je     26479e <<glass::engine::Watch>::print_utf8+0xf1e>
  264793:	mov    0x78(%rsp),%rcx
  264798:	cmp    0x30(%r15),%rdi
  26479c:	jae    2647b7 <<glass::engine::Watch>::print_utf8+0xf37>
  26479e:	mov    0x10(%r15),%rsi
  2647a2:	cmp    %rsi,%rdi
  2647a5:	jae    26592c <<glass::engine::Watch>::print_utf8+0x20ac>
  2647ab:	lea    (%rdi,%rdi,2),%rcx
  2647af:	shl    $0x3,%rcx
  2647b3:	add    0x8(%r15),%rcx
  2647b7:	testb  $0x60,0x14(%rcx)
  2647bb:	jne    2643e0 <<glass::engine::Watch>::print_utf8+0xb60>
  2647c1:	mov    %rdx,0x28(%rsp)
  2647c6:	cmp    %ebx,0x38(%r15)
  2647ca:	jbe    2647d0 <<glass::engine::Watch>::print_utf8+0xf50>
  2647cc:	mov    %ebx,0x38(%r15)
  2647d0:	mov    %r14d,0xc(%rsp)
  2647d5:	mov    %r11,0x90(%rsp)
  2647dd:	cmp    $0xffffffff,%eax
  2647e0:	setne  %dl
  2647e3:	mov    0x30(%r15),%rcx
  2647e7:	cmp    %rcx,%rbx
  2647ea:	sete   %sil
  2647ee:	test   %sil,%dl
  2647f1:	mov    %rbx,0x20(%rsp)
  2647f6:	mov    %r15,0x38(%rsp)
  2647fb:	mov    %r9,0x60(%rsp)
  264800:	mov    %r10,0x70(%rsp)
  264805:	jne    26487e <<glass::engine::Watch>::print_utf8+0xffe>
  264807:	cmp    $0xffffffff,%eax
  26480a:	mov    0x30(%rsp),%r14
  26480f:	je     264acd <<glass::engine::Watch>::print_utf8+0x124d>
  264815:	mov    0x10(%r15),%rax
  264819:	cmp    %rcx,%rax
  26481c:	mov    %rcx,%rdx
  26481f:	cmovb  %rax,%rdx
  264823:	mov    %rdx,0xa8(%rsp)
  26482b:	cmp    %rbx,%rax
  26482e:	mov    %rbx,%rsi
  264831:	cmovb  %rax,%rsi
  264835:	mov    0x392104(%rip),%rdx        # 5f6940 <_DYNAMIC+0x320>
  26483c:	movzbl (%rdx),%edx
  26483f:	test   %dl,%dl
  264841:	je     2648eb <<glass::engine::Watch>::print_utf8+0x106b>
  264847:	mov    0x39212a(%rip),%rdx        # 5f6978 <_DYNAMIC+0x358>
  26484e:	mov    %rsi,%r11
  264851:	cmp    %rsi,%rcx
  264854:	jae    26485d <<glass::engine::Watch>::print_utf8+0xfdd>
  264856:	mov    0x392123(%rip),%rdx        # 5f6980 <_DYNAMIC+0x360>
  26485d:	lock incq 0x28(%rdx)
  264862:	mov    0x3920ef(%rip),%rdx        # 5f6958 <_DYNAMIC+0x338>
  264869:	lock incq (%rdx)
  26486d:	mov    %r11,%rdx
  264870:	sub    0xa8(%rsp),%rdx
  264878:	jne    26489d <<glass::engine::Watch>::print_utf8+0x101d>
  26487a:	xor    %esi,%esi
  26487c:	jmp    2648dc <<glass::engine::Watch>::print_utf8+0x105c>
  26487e:	lea    0x1(%rbx),%rax
  264882:	mov    %rax,0x30(%r15)
  264886:	mov    0x10(%r15),%rsi
  26488a:	cmp    %rsi,%rbx
  26488d:	mov    0x30(%rsp),%r14
  264892:	jb     264aed <<glass::engine::Watch>::print_utf8+0x126d>
  264898:	jmp    265939 <<glass::engine::Watch>::print_utf8+0x20b9>
  26489d:	mov    0x3920bc(%rip),%rsi        # 5f6960 <_DYNAMIC+0x340>
  2648a4:	lock add %rdx,(%rsi)
  2648a8:	cmp    $0x5,%rdx
  2648ac:	jae    2648bc <<glass::engine::Watch>::print_utf8+0x103c>
  2648ae:	lea    -0x2066d5(%rip),%rsi        # 5e1e0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2648b5:	movzbl -0x1(%rdx,%rsi,1),%esi
  2648ba:	jmp    2648dc <<glass::engine::Watch>::print_utf8+0x105c>
  2648bc:	lea    -0x5(%rdx),%rdi
  2648c0:	mov    $0x4,%esi
  2648c5:	cmp    $0x4,%rdi
  2648c9:	jb     2648dc <<glass::engine::Watch>::print_utf8+0x105c>
  2648cb:	add    $0xfffffffffffffff7,%rdx
  2648cf:	cmp    $0x8,%rdx
  2648d3:	mov    $0x6,%esi
  2648d8:	sbb    $0x0,%rsi
  2648dc:	mov    0x39206d(%rip),%rdx        # 5f6950 <_DYNAMIC+0x330>
  2648e3:	lock incq (%rdx,%rsi,8)
  2648e8:	mov    %r11,%rsi
  2648eb:	cmp    %rsi,%rcx
  2648ee:	jae    264a8b <<glass::engine::Watch>::print_utf8+0x120b>
  2648f4:	mov    0x28(%r15),%edi
  2648f8:	mov    0x20(%r15),%r10d
  2648fc:	mov    0x24(%r15),%r11d
  264900:	movzwl 0x2c(%r15),%ecx
  264905:	mov    0x18(%r15),%rax
  264909:	test   %rax,%rax
  26490c:	mov    %rax,0x68(%rsp)
  264911:	je     264946 <<glass::engine::Watch>::print_utf8+0x10c6>
  264913:	lock incq (%rax)
  264917:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  26491d:	mov    0x10(%r15),%rdx
  264921:	mov    %edi,0x50(%rsp)
  264925:	mov    %r10d,0x48(%rsp)
  26492a:	mov    %r11d,0x4c(%rsp)
  26492f:	mov    %ecx,%r9d
  264932:	mov    %cx,0x54(%rsp)
  264937:	mov    %rax,0x40(%rsp)
  26493c:	cmp    %rdx,%rsi
  26493f:	jbe    264961 <<glass::engine::Watch>::print_utf8+0x10e1>
  264941:	jmp    265868 <<glass::engine::Watch>::print_utf8+0x1fe8>
  264946:	mov    %edi,0x50(%rsp)
  26494a:	mov    %r10d,0x48(%rsp)
  26494f:	mov    %r11d,0x4c(%rsp)
  264954:	mov    %cx,0x54(%rsp)
  264959:	mov    %rax,0x40(%rsp)
  26495e:	mov    %ecx,%r9d
  264961:	mov    0xa8(%rsp),%rax
  264969:	lea    0x0(,%rax,8),%rax
  264971:	lea    (%rax,%rax,2),%rax
  264975:	mov    0x8(%r15),%rbx
  264979:	add    %rax,%rbx
  26497c:	mov    %rsi,0xd0(%rsp)
  264984:	lea    0x0(,%rsi,8),%rcx
  26498c:	lea    (%rcx,%rcx,2),%r14
  264990:	sub    %rax,%r14
  264993:	mov    0x68(%rsp),%rcx
  264998:	mov    %edi,0x98(%rsp)
  26499f:	mov    %r10d,0x8c(%rsp)
  2649a7:	mov    %r11d,0xb8(%rsp)
  2649af:	mov    %r9w,0xd8(%rsp)
  2649b8:	jmp    2649dd <<glass::engine::Watch>::print_utf8+0x115d>
  2649ba:	nopw   0x0(%rax,%rax,1)
  2649c0:	mov    %rcx,(%rbx)
  2649c3:	mov    %r10d,0x8(%rbx)
  2649c7:	mov    %r11d,0xc(%rbx)
  2649cb:	mov    %edi,0x10(%rbx)
  2649ce:	mov    %r9w,0x14(%rbx)
  2649d3:	add    $0x18,%rbx
  2649d7:	add    $0xffffffffffffffe8,%r14
  2649db:	je     264a35 <<glass::engine::Watch>::print_utf8+0x11b5>
  2649dd:	test   %rcx,%rcx
  2649e0:	je     2649ec <<glass::engine::Watch>::print_utf8+0x116c>
  2649e2:	lock incq (%rcx)
  2649e6:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  2649ec:	mov    (%rbx),%rax
  2649ef:	test   %rax,%rax
  2649f2:	je     2649c0 <<glass::engine::Watch>::print_utf8+0x1140>
  2649f4:	lock decq (%rax)
  2649f8:	jne    2649c0 <<glass::engine::Watch>::print_utf8+0x1140>
  2649fa:	mov    %rbx,%rdi
  2649fd:	mov    %r8,%r15
  264a00:	call   *0x391e82(%rip)        # 5f6888 <_DYNAMIC+0x268>
  264a06:	movzwl 0xd8(%rsp),%r9d
  264a0f:	mov    0xb8(%rsp),%r11d
  264a17:	mov    0x8c(%rsp),%r10d
  264a1f:	mov    0x98(%rsp),%edi
  264a26:	mov    0x68(%rsp),%rcx
  264a2b:	mov    %r15,%r8
  264a2e:	mov    0x38(%rsp),%r15
  264a33:	jmp    2649c0 <<glass::engine::Watch>::print_utf8+0x1140>
  264a35:	mov    0xa8(%rsp),%rax
  264a3d:	cmp    %eax,0x38(%r15)
  264a41:	mov    0x30(%rsp),%r14
  264a46:	mov    0x20(%rsp),%rbx
  264a4b:	jbe    264a51 <<glass::engine::Watch>::print_utf8+0x11d1>
  264a4d:	mov    %eax,0x38(%r15)
  264a51:	test   %rcx,%rcx
  264a54:	mov    0xd0(%rsp),%rsi
  264a5c:	je     264a87 <<glass::engine::Watch>::print_utf8+0x1207>
  264a5e:	lock decq (%rcx)
  264a62:	jne    264a87 <<glass::engine::Watch>::print_utf8+0x1207>
  264a64:	lea    0x40(%rsp),%rdi
  264a69:	mov    %r8,%rbx
  264a6c:	call   *0x391e16(%rip)        # 5f6888 <_DYNAMIC+0x268>
  264a72:	mov    0xd0(%rsp),%rsi
  264a7a:	mov    %rbx,%r8
  264a7d:	mov    0x20(%rsp),%rbx
  264a82:	mov    0x38(%rsp),%r15
  264a87:	mov    0x10(%r15),%rax
  264a8b:	cmp    %rax,%rsi
  264a8e:	jb     264acd <<glass::engine::Watch>::print_utf8+0x124d>
  264a90:	cmpl   $0xffffffff,0x28(%r15)
  264a95:	je     264ac5 <<glass::engine::Watch>::print_utf8+0x1245>
  264a97:	mov    0x78(%rsp),%rax
  264a9c:	mov    (%rax),%rax
  264a9f:	test   %rax,%rax
  264aa2:	je     264ac5 <<glass::engine::Watch>::print_utf8+0x1245>
  264aa4:	lock decq (%rax)
  264aa8:	jne    264ac5 <<glass::engine::Watch>::print_utf8+0x1245>
  264aaa:	mov    0x78(%rsp),%rdi
  264aaf:	mov    %r8,%rbx
  264ab2:	call   *0x391dd0(%rip)        # 5f6888 <_DYNAMIC+0x268>
  264ab8:	mov    %rbx,%r8
  264abb:	mov    0x20(%rsp),%rbx
  264ac0:	mov    0x38(%rsp),%r15
  264ac5:	movl   $0xffffffff,0x28(%r15)
  264acd:	mov    0x30(%r15),%rax
  264ad1:	lea    0x1(%rbx),%rcx
  264ad5:	cmp    %rax,%rcx
  264ad8:	cmova  %rcx,%rax
  264adc:	mov    0x10(%r15),%rsi
  264ae0:	mov    %rax,0x30(%r15)
  264ae4:	cmp    %rsi,%rbx
  264ae7:	jae    265949 <<glass::engine::Watch>::print_utf8+0x20c9>
  264aed:	mov    0xc(%rsp),%esi
  264af1:	mov    %esi,%eax
  264af3:	or     $0x20,%eax
  264af6:	cmp    $0x2,%r12
  264afa:	mov    0x8(%r15),%rcx
  264afe:	lea    (%rbx,%rbx,2),%rdx
  264b02:	lea    (%rcx,%rdx,8),%rbx
  264b06:	mov    %ebp,0x10(%rcx,%rdx,8)
  264b0a:	mov    0x58(%rsp),%ebp
  264b0e:	mov    %ebp,0x8(%rcx,%rdx,8)
  264b12:	cmovne %esi,%eax
  264b15:	mov    0xa0(%rsp),%esi
  264b1c:	mov    %esi,0xc(%rcx,%rdx,8)
  264b20:	mov    %ax,0x14(%rcx,%rdx,8)
  264b25:	mov    (%rcx,%rdx,8),%rax
  264b29:	test   %rax,%rax
  264b2c:	je     264b48 <<glass::engine::Watch>::print_utf8+0x12c8>
  264b2e:	lock decq (%rax)
  264b32:	jne    264b48 <<glass::engine::Watch>::print_utf8+0x12c8>
  264b34:	mov    %rbx,%rdi
  264b37:	mov    %r8,%r15
  264b3a:	call   *0x391d48(%rip)        # 5f6888 <_DYNAMIC+0x268>
  264b40:	mov    %r15,%r8
  264b43:	mov    0x38(%rsp),%r15
  264b48:	movq   $0x0,(%rbx)
  264b4f:	cmp    $0x2,%r12
  264b53:	mov    0x28(%rsp),%rdx
  264b58:	jne    264e88 <<glass::engine::Watch>::print_utf8+0x1608>
  264b5e:	mov    0x20(%rsp),%r9
  264b63:	lea    0x1(%r9),%r12
  264b67:	mov    0x30(%r15),%rax
  264b6b:	mov    0x28(%r15),%ecx
  264b6f:	cmp    %rax,%r12
  264b72:	jne    264b93 <<glass::engine::Watch>::print_utf8+0x1313>
  264b74:	cmp    $0xffffffff,%ecx
  264b77:	je     264b93 <<glass::engine::Watch>::print_utf8+0x1313>
  264b79:	add    $0x2,%r9
  264b7d:	mov    %r9,0x30(%r15)
  264b81:	mov    0x10(%r15),%rsi
  264b85:	cmp    %rsi,%r12
  264b88:	jb     264e2f <<glass::engine::Watch>::print_utf8+0x15af>
  264b8e:	jmp    26520e <<glass::engine::Watch>::print_utf8+0x198e>
  264b93:	cmp    $0xffffffff,%ecx
  264b96:	je     264e0f <<glass::engine::Watch>::print_utf8+0x158f>
  264b9c:	mov    0x10(%r15),%rcx
  264ba0:	cmp    %rax,%rcx
  264ba3:	mov    %rax,%rdi
  264ba6:	cmovb  %rcx,%rdi
  264baa:	cmp    %r12,%rcx
  264bad:	mov    %r12,%r10
  264bb0:	cmovb  %rcx,%r10
  264bb4:	mov    0x391d85(%rip),%rdx        # 5f6940 <_DYNAMIC+0x320>
  264bbb:	movzbl (%rdx),%edx
  264bbe:	test   %dl,%dl
  264bc0:	je     264c3c <<glass::engine::Watch>::print_utf8+0x13bc>
  264bc2:	mov    0x391daf(%rip),%rdx        # 5f6978 <_DYNAMIC+0x358>
  264bc9:	cmp    %r10,%rax
  264bcc:	jae    264bd5 <<glass::engine::Watch>::print_utf8+0x1355>
  264bce:	mov    0x391dab(%rip),%rdx        # 5f6980 <_DYNAMIC+0x360>
  264bd5:	lock incq 0x28(%rdx)
  264bda:	mov    0x391d77(%rip),%rdx        # 5f6958 <_DYNAMIC+0x338>
  264be1:	lock incq (%rdx)
  264be5:	mov    %r10,%rdx
  264be8:	sub    %rdi,%rdx
  264beb:	jne    264bf1 <<glass::engine::Watch>::print_utf8+0x1371>
  264bed:	xor    %esi,%esi
  264bef:	jmp    264c30 <<glass::engine::Watch>::print_utf8+0x13b0>
  264bf1:	mov    0x391d68(%rip),%rsi        # 5f6960 <_DYNAMIC+0x340>
  264bf8:	lock add %rdx,(%rsi)
  264bfc:	cmp    $0x5,%rdx
  264c00:	jae    264c10 <<glass::engine::Watch>::print_utf8+0x1390>
  264c02:	lea    -0x206a29(%rip),%rsi        # 5e1e0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  264c09:	movzbl -0x1(%rdx,%rsi,1),%esi
  264c0e:	jmp    264c30 <<glass::engine::Watch>::print_utf8+0x13b0>
  264c10:	lea    -0x5(%rdx),%r11
  264c14:	mov    $0x4,%esi
  264c19:	cmp    $0x4,%r11
  264c1d:	jb     264c30 <<glass::engine::Watch>::print_utf8+0x13b0>
  264c1f:	add    $0xfffffffffffffff7,%rdx
  264c23:	cmp    $0x8,%rdx
  264c27:	mov    $0x6,%esi
  264c2c:	sbb    $0x0,%rsi
  264c30:	mov    0x391d19(%rip),%rdx        # 5f6950 <_DYNAMIC+0x330>
  264c37:	lock incq (%rdx,%rsi,8)
  264c3c:	cmp    %r10,%rax
  264c3f:	mov    0x28(%rsp),%rdx
  264c44:	jae    264de8 <<glass::engine::Watch>::print_utf8+0x1568>
  264c4a:	mov    %r12,0xd8(%rsp)
  264c52:	mov    0x28(%r15),%r9d
  264c56:	mov    0x20(%r15),%r11d
  264c5a:	mov    0x24(%r15),%ebp
  264c5e:	movzwl 0x2c(%r15),%eax
  264c63:	mov    0x18(%r15),%r12
  264c67:	test   %r12,%r12
  264c6a:	mov    %r12,0x98(%rsp)
  264c72:	mov    %ax,0x68(%rsp)
  264c77:	je     264cad <<glass::engine::Watch>::print_utf8+0x142d>
  264c79:	lock incq (%r12)
  264c7e:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  264c84:	mov    0x10(%r15),%rdx
  264c88:	mov    %r9d,0x50(%rsp)
  264c8d:	mov    %r11d,0x48(%rsp)
  264c92:	mov    %ebp,0x4c(%rsp)
  264c96:	mov    %ax,0x54(%rsp)
  264c9b:	mov    %r12,0x40(%rsp)
  264ca0:	cmp    %rdx,%r10
  264ca3:	mov    %r10,%rsi
  264ca6:	jbe    264cc8 <<glass::engine::Watch>::print_utf8+0x1448>
  264ca8:	jmp    265882 <<glass::engine::Watch>::print_utf8+0x2002>
  264cad:	mov    %r9d,0x50(%rsp)
  264cb2:	mov    %r11d,0x48(%rsp)
  264cb7:	mov    %ebp,0x4c(%rsp)
  264cbb:	mov    %ax,0x54(%rsp)
  264cc0:	mov    %r12,0x40(%rsp)
  264cc5:	mov    %r10,%rsi
  264cc8:	mov    %rdi,0xa8(%rsp)
  264cd0:	lea    0x0(,%rdi,8),%rax
  264cd8:	lea    (%rax,%rax,2),%rax
  264cdc:	mov    0x8(%r15),%rbx
  264ce0:	add    %rax,%rbx
  264ce3:	mov    %rsi,0xb8(%rsp)
  264ceb:	lea    0x0(,%rsi,8),%rcx
  264cf3:	lea    (%rcx,%rcx,2),%r14
  264cf7:	sub    %rax,%r14
  264cfa:	movzwl 0x68(%rsp),%ecx
  264cff:	mov    %ebp,0x8c(%rsp)
  264d06:	jmp    264d2c <<glass::engine::Watch>::print_utf8+0x14ac>
  264d08:	nopl   0x0(%rax,%rax,1)
  264d10:	mov    %r12,(%rbx)
  264d13:	mov    %r11d,0x8(%rbx)
  264d17:	mov    %ebp,0xc(%rbx)
  264d1a:	mov    %r9d,0x10(%rbx)
  264d1e:	mov    %cx,0x14(%rbx)
  264d22:	add    $0x18,%rbx
  264d26:	add    $0xffffffffffffffe8,%r14
  264d2a:	je     264d80 <<glass::engine::Watch>::print_utf8+0x1500>
  264d2c:	test   %r12,%r12
  264d2f:	je     264d3c <<glass::engine::Watch>::print_utf8+0x14bc>
  264d31:	lock incq (%r12)
  264d36:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  264d3c:	mov    (%rbx),%rax
  264d3f:	test   %rax,%rax
  264d42:	je     264d10 <<glass::engine::Watch>::print_utf8+0x1490>
  264d44:	lock decq (%rax)
  264d48:	jne    264d10 <<glass::engine::Watch>::print_utf8+0x1490>
  264d4a:	mov    %rbx,%rdi
  264d4d:	mov    %r8,%r15
  264d50:	mov    %r9d,%ebp
  264d53:	mov    %r11d,%r12d
  264d56:	call   *0x391b2c(%rip)        # 5f6888 <_DYNAMIC+0x268>
  264d5c:	movzwl 0x68(%rsp),%ecx
  264d61:	mov    %r12d,%r11d
  264d64:	mov    0x98(%rsp),%r12
  264d6c:	mov    %ebp,%r9d
  264d6f:	mov    0x8c(%rsp),%ebp
  264d76:	mov    %r15,%r8
  264d79:	mov    0x38(%rsp),%r15
  264d7e:	jmp    264d10 <<glass::engine::Watch>::print_utf8+0x1490>
  264d80:	mov    0xa8(%rsp),%rax
  264d88:	cmp    %eax,0x38(%r15)
  264d8c:	mov    0x30(%rsp),%r14
  264d91:	mov    0x28(%rsp),%rdx
  264d96:	mov    0x20(%rsp),%r9
  264d9b:	jbe    264da1 <<glass::engine::Watch>::print_utf8+0x1521>
  264d9d:	mov    %eax,0x38(%r15)
  264da1:	test   %r12,%r12
  264da4:	mov    0x58(%rsp),%ebp
  264da8:	mov    0xb8(%rsp),%r10
  264db0:	je     264ddc <<glass::engine::Watch>::print_utf8+0x155c>
  264db2:	lock decq (%r12)
  264db7:	jne    264ddc <<glass::engine::Watch>::print_utf8+0x155c>
  264db9:	lea    0x40(%rsp),%rdi
  264dbe:	mov    %r8,%rbx
  264dc1:	call   *0x391ac1(%rip)        # 5f6888 <_DYNAMIC+0x268>
  264dc7:	mov    0x28(%rsp),%rdx
  264dcc:	mov    %rbx,%r8
  264dcf:	mov    0xb8(%rsp),%r10
  264dd7:	mov    0x20(%rsp),%r9
  264ddc:	mov    0x10(%r15),%rcx
  264de0:	mov    0xd8(%rsp),%r12
  264de8:	cmp    %rcx,%r10
  264deb:	jb     264e0f <<glass::engine::Watch>::print_utf8+0x158f>
  264ded:	mov    0x78(%rsp),%rdi
  264df2:	mov    %r8,%rbx
  264df5:	call   1ae630 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  264dfa:	mov    0x28(%rsp),%rdx
  264dff:	mov    %rbx,%r8
  264e02:	mov    0x20(%rsp),%r9
  264e07:	movl   $0xffffffff,0x28(%r15)
  264e0f:	mov    0x30(%r15),%rax
  264e13:	add    $0x2,%r9
  264e17:	cmp    %rax,%r9
  264e1a:	cmovbe %rax,%r9
  264e1e:	mov    0x10(%r15),%rsi
  264e22:	mov    %r9,0x30(%r15)
  264e26:	cmp    %rsi,%r12
  264e29:	jae    265959 <<glass::engine::Watch>::print_utf8+0x20d9>
  264e2f:	mov    0x8(%r15),%rax
  264e33:	lea    (%r12,%r12,2),%rcx
  264e37:	lea    (%rax,%rcx,8),%rbx
  264e3b:	movl   $0x20,0x10(%rax,%rcx,8)
  264e43:	mov    %ebp,0x8(%rax,%rcx,8)
  264e47:	mov    0xa0(%rsp),%esi
  264e4e:	mov    %esi,0xc(%rax,%rcx,8)
  264e52:	mov    0xc(%rsp),%esi
  264e56:	or     $0x40,%esi
  264e59:	mov    %si,0x14(%rax,%rcx,8)
  264e5e:	mov    (%rax,%rcx,8),%rax
  264e62:	test   %rax,%rax
  264e65:	je     264e81 <<glass::engine::Watch>::print_utf8+0x1601>
  264e67:	lock decq (%rax)
  264e6b:	jne    264e81 <<glass::engine::Watch>::print_utf8+0x1601>
  264e6d:	mov    %rbx,%rdi
  264e70:	mov    %r8,%r15
  264e73:	call   *0x391a0f(%rip)        # 5f6888 <_DYNAMIC+0x268>
  264e79:	mov    0x28(%rsp),%rdx
  264e7e:	mov    %r15,%r8
  264e81:	movq   $0x0,(%rbx)
  264e88:	mov    0x70(%rsp),%rcx
  264e8d:	cmp    0x90(%rsp),%rcx
  264e95:	mov    0x18(%rsp),%rsi
  264e9a:	mov    0x60(%rsp),%rax
  264e9f:	jb     264ea8 <<glass::engine::Watch>::print_utf8+0x1628>
  264ea1:	dec    %rcx
  264ea4:	movb   $0x1,0x6c(%rax)
  264ea8:	mov    %rcx,0x40(%rax)
  264eac:	mov    0xc8(%rsp),%r15
  264eb4:	incq   0xa0(%r15)
  264ebb:	nopl   0x0(%rax,%rax,1)
  264ec0:	add    %r14,%rdx
  264ec3:	cmpb   $0x0,0x80(%rsp)
  264ecb:	je     264419 <<glass::engine::Watch>::print_utf8+0xb99>
  264ed1:	jmp    263930 <<glass::engine::Watch>::print_utf8+0xb0>
  264ed6:	mov    %r8,%rbx
  264ed9:	mov    %rdx,%r14
  264edc:	call   18c892 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  264ee1:	mov    %r14,%rdx
  264ee4:	mov    %rbx,%r8
  264ee7:	mov    %ebp,%ebx
  264ee9:	mov    0x394900(%rip),%rsi        # 5f97f0 <glass::engine::width_of::CACHE+0x8>
  264ef0:	cmp    %rbx,%rsi
  264ef3:	ja     26463e <<glass::engine::Watch>::print_utf8+0xdbe>
  264ef9:	jmp    265858 <<glass::engine::Watch>::print_utf8+0x1fd8>
  264efe:	cmpq   $0x400,0xa0(%r15)
  264f09:	jb     264f34 <<glass::engine::Watch>::print_utf8+0x16b4>
  264f0b:	mov    %r15,%rdi
  264f0e:	call   265cd0 <<glass::engine::Watch>::fold_sentinel>
  264f13:	movq   $0x0,0xa0(%r15)
  264f1e:	mov    0x3948dc(%rip),%eax        # 5f9800 <glass::engine::run_whole::ON>
  264f24:	test   %eax,%eax
  264f26:	je     264f3e <<glass::engine::Watch>::print_utf8+0x16be>
  264f28:	call   18c936 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  264f2d:	cmp    %r13,%r14
  264f30:	je     264f43 <<glass::engine::Watch>::print_utf8+0x16c3>
  264f32:	jmp    264f73 <<glass::engine::Watch>::print_utf8+0x16f3>
  264f34:	mov    0x3948c6(%rip),%eax        # 5f9800 <glass::engine::run_whole::ON>
  264f3a:	test   %eax,%eax
  264f3c:	jne    264f28 <<glass::engine::Watch>::print_utf8+0x16a8>
  264f3e:	cmp    %r13,%r14
  264f41:	jne    264f73 <<glass::engine::Watch>::print_utf8+0x16f3>
  264f43:	cmpb   $0x0,0x3948ba(%rip)        # 5f9804 <glass::engine::run_whole::ON+0x4>
  264f4a:	je     264f73 <<glass::engine::Watch>::print_utf8+0x16f3>
  264f4c:	cmp    $0xffffffff,%ebp
  264f4f:	je     265115 <<glass::engine::Watch>::print_utf8+0x1895>
  264f55:	lea    -0x20(%rbp),%eax
  264f58:	cmp    $0x5f,%eax
  264f5b:	jae    264f84 <<glass::engine::Watch>::print_utf8+0x1704>
  264f5d:	mov    $0x1,%r13d
  264f63:	cmpb   $0x0,0x10(%rsp)
  264f68:	jne    26504f <<glass::engine::Watch>::print_utf8+0x17cf>
  264f6e:	jmp    265103 <<glass::engine::Watch>::print_utf8+0x1883>
  264f73:	xor    %eax,%eax
  264f75:	cmp    $0xffffffff,%ebp
  264f78:	cmove  %rax,%rbx
  264f7c:	mov    %rbx,%r13
  264f7f:	jmp    265115 <<glass::engine::Watch>::print_utf8+0x1895>
  264f84:	cmpb   $0x0,0x80(%rsp)
  264f8c:	je     265103 <<glass::engine::Watch>::print_utf8+0x1883>
  264f92:	mov    0x394860(%rip),%eax        # 5f97f8 <glass::engine::width_of::CACHE+0x10>
  264f98:	test   %eax,%eax
  264f9a:	jne    265841 <<glass::engine::Watch>::print_utf8+0x1fc1>
  264fa0:	mov    %ebp,%ebx
  264fa2:	mov    0x394847(%rip),%rsi        # 5f97f0 <glass::engine::width_of::CACHE+0x8>
  264fa9:	cmp    %rbx,%rsi
  264fac:	jbe    265858 <<glass::engine::Watch>::print_utf8+0x1fd8>
  264fb2:	mov    0x39482f(%rip),%r14        # 5f97e8 <glass::engine::width_of::CACHE>
  264fb9:	movzbl (%r14,%rbx,1),%eax
  264fbe:	movzbl %al,%r13d
  264fc2:	test   %r13b,%r13b
  264fc5:	js     264fd2 <<glass::engine::Watch>::print_utf8+0x1752>
  264fc7:	mov    $0x1,%cl
  264fc9:	test   %cl,%cl
  264fcb:	jne    265041 <<glass::engine::Watch>::print_utf8+0x17c1>
  264fcd:	jmp    265103 <<glass::engine::Watch>::print_utf8+0x1883>
  264fd2:	cmp    $0xfe,%r13d
  264fd9:	je     265103 <<glass::engine::Watch>::print_utf8+0x1883>
  264fdf:	mov    $0xfe,%al
  264fe1:	cmp    $0x7f,%ebp
  264fe4:	jae    26501c <<glass::engine::Watch>::print_utf8+0x179c>
  264fe6:	mov    $0x1,%r13d
  264fec:	xor    %ecx,%ecx
  264fee:	jmp    265035 <<glass::engine::Watch>::print_utf8+0x17b5>
  264ff0:	mov    $0x1,%cl
  264ff2:	mov    %ecx,0x80(%rsp)
  264ff9:	cmpb   $0x0,0x68(%rax)
  264ffd:	jne    26500f <<glass::engine::Watch>::print_utf8+0x178f>
  264fff:	cmpb   $0x0,0x69(%rax)
  265003:	jne    26500f <<glass::engine::Watch>::print_utf8+0x178f>
  265005:	cmpb   $0x0,0x6a(%rax)
  265009:	je     26522e <<glass::engine::Watch>::print_utf8+0x19ae>
  26500f:	movl   $0x0,0x10(%rsp)
  265017:	jmp    2638de <<glass::engine::Watch>::print_utf8+0x5e>
  26501c:	cmp    $0xa0,%ebp
  265022:	jb     265033 <<glass::engine::Watch>::print_utf8+0x17b3>
  265024:	mov    %ebp,%edi
  265026:	call   29a1a0 <unicode_width::tables::lookup_width>
  26502b:	movzbl %al,%r13d
  26502f:	mov    $0x1,%cl
  265031:	jmp    265035 <<glass::engine::Watch>::print_utf8+0x17b5>
  265033:	xor    %ecx,%ecx
  265035:	mov    %al,(%r14,%rbx,1)
  265039:	test   %cl,%cl
  26503b:	je     265103 <<glass::engine::Watch>::print_utf8+0x1883>
  265041:	lea    -0x1(%r13),%rax
  265045:	cmp    $0x1,%rax
  265049:	ja     265103 <<glass::engine::Watch>::print_utf8+0x1883>
  26504f:	mov    0x78(%r15),%r14
  265053:	cmpb   $0x0,0x6c(%r14)
  265058:	jne    265103 <<glass::engine::Watch>::print_utf8+0x1883>
  26505e:	mov    0x40(%r14),%r12
  265062:	mov    0xa0(%r14),%r8
  265069:	lea    (%r12,%r13,1),%rdx
  26506d:	cmp    %r8,%rdx
  265070:	ja     265103 <<glass::engine::Watch>::print_utf8+0x1883>
  265076:	mov    0x30(%r14),%eax
  26507a:	sub    0x48(%r14),%eax
  26507e:	cltq
  265080:	mov    0x20(%r14),%rsi
  265084:	mov    0x28(%r14),%rcx
  265088:	lea    (%rcx,%rax,1),%rdi
  26508c:	dec    %rdi
  26508f:	xor    %eax,%eax
  265091:	cmp    %rsi,%rdi
  265094:	cmovae %rsi,%rax
  265098:	sub    %rax,%rdi
  26509b:	cmp    %rsi,%rdi
  26509e:	jae    2658fb <<glass::engine::Watch>::print_utf8+0x207b>
  2650a4:	mov    0x58(%r14),%r10d
  2650a8:	mov    0x5c(%r14),%r11d
  2650ac:	movzwl 0x64(%r14),%r9d
  2650b1:	mov    0x18(%r14),%rax
  2650b5:	shl    $0x6,%rdi
  2650b9:	lea    (%rax,%rdi,1),%rbx
  2650bd:	lea    (%rax,%rdi,1),%rcx
  2650c1:	add    $0x18,%rcx
  2650c5:	mov    %rcx,0x80(%rsp)
  2650cd:	mov    0x28(%rax,%rdi,1),%eax
  2650d1:	cmp    $0xffffffff,%eax
  2650d4:	je     2650e4 <<glass::engine::Watch>::print_utf8+0x1864>
  2650d6:	mov    0x80(%rsp),%rcx
  2650de:	cmp    0x30(%rbx),%r12
  2650e2:	jae    2650fd <<glass::engine::Watch>::print_utf8+0x187d>
  2650e4:	mov    0x10(%rbx),%rsi
  2650e8:	cmp    %rsi,%r12
  2650eb:	jae    265969 <<glass::engine::Watch>::print_utf8+0x20e9>
  2650f1:	lea    (%r12,%r12,2),%rcx
  2650f5:	shl    $0x3,%rcx
  2650f9:	add    0x8(%rbx),%rcx
  2650fd:	testb  $0x60,0x14(%rcx)
  265101:	je     26512a <<glass::engine::Watch>::print_utf8+0x18aa>
  265103:	mov    %r15,%rdi
  265106:	mov    %ebp,%esi
  265108:	call   3417f0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  26510d:	mov    0xc0(%rsp),%r13
  265115:	mov    %r13,%rax
  265118:	add    $0x118,%rsp
  26511f:	pop    %rbx
  265120:	pop    %r12
  265122:	pop    %r13
  265124:	pop    %r14
  265126:	pop    %r15
  265128:	pop    %rbp
  265129:	ret
  26512a:	cmp    $0x2,%r13
  26512e:	jne    265167 <<glass::engine::Watch>::print_utf8+0x18e7>
  265130:	lea    0x1(%r12),%rdi
  265135:	cmp    $0xffffffff,%eax
  265138:	je     265148 <<glass::engine::Watch>::print_utf8+0x18c8>
  26513a:	mov    0x80(%rsp),%rcx
  265142:	cmp    0x30(%rbx),%rdi
  265146:	jae    265161 <<glass::engine::Watch>::print_utf8+0x18e1>
  265148:	mov    0x10(%rbx),%rsi
  26514c:	cmp    %rsi,%rdi
  26514f:	jae    26592c <<glass::engine::Watch>::print_utf8+0x20ac>
  265155:	lea    (%rdi,%rdi,2),%rcx
  265159:	shl    $0x3,%rcx
  26515d:	add    0x8(%rbx),%rcx
  265161:	testb  $0x60,0x14(%rcx)
  265165:	jne    265103 <<glass::engine::Watch>::print_utf8+0x1883>
  265167:	mov    %r11d,0x78(%rsp)
  26516c:	mov    %r10d,0x28(%rsp)
  265171:	mov    %r9d,0x30(%rsp)
  265176:	mov    %r8,0x58(%rsp)
  26517b:	mov    %rdx,0xa0(%rsp)
  265183:	cmp    %r12d,0x38(%rbx)
  265187:	jbe    26518d <<glass::engine::Watch>::print_utf8+0x190d>
  265189:	mov    %r12d,0x38(%rbx)
  26518d:	cmp    $0xffffffff,%eax
  265190:	setne  %cl
  265193:	mov    %rbx,%rdi
  265196:	mov    0x30(%rbx),%rbx
  26519a:	cmp    %rbx,%r12
  26519d:	sete   %dl
  2651a0:	test   %dl,%cl
  2651a2:	mov    %rdi,0x18(%rsp)
  2651a7:	jne    2651f5 <<glass::engine::Watch>::print_utf8+0x1975>
  2651a9:	cmp    $0xffffffff,%eax
  2651ac:	je     26545f <<glass::engine::Watch>::print_utf8+0x1bdf>
  2651b2:	mov    0x18(%rsp),%rax
  2651b7:	mov    0x10(%rax),%r15
  2651bb:	cmp    %rbx,%r15
  2651be:	mov    %rbx,%rax
  2651c1:	cmovb  %r15,%rax
  2651c5:	mov    %rax,0x10(%rsp)
  2651ca:	cmp    %r12,%r15
  2651cd:	mov    %r12,%rcx
  2651d0:	cmovb  %r15,%rcx
  2651d4:	mov    0x391765(%rip),%rax        # 5f6940 <_DYNAMIC+0x320>
  2651db:	movzbl (%rax),%eax
  2651de:	test   %al,%al
  2651e0:	mov    %rcx,0x20(%rsp)
  2651e5:	je     26525c <<glass::engine::Watch>::print_utf8+0x19dc>
  2651e7:	cmp    %rcx,%rbx
  2651ea:	jae    26523e <<glass::engine::Watch>::print_utf8+0x19be>
  2651ec:	mov    0x39178d(%rip),%rax        # 5f6980 <_DYNAMIC+0x360>
  2651f3:	jmp    265245 <<glass::engine::Watch>::print_utf8+0x19c5>
  2651f5:	lea    0x1(%r12),%rax
  2651fa:	mov    %rax,0x30(%rdi)
  2651fe:	mov    0x10(%rdi),%rsi
  265202:	cmp    %rsi,%r12
  265205:	mov    %rdi,%rdx
  265208:	jb     265485 <<glass::engine::Watch>::print_utf8+0x1c05>
  26520e:	lea    0x368d93(%rip),%rdx        # 5cdfa8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c68>
  265215:	mov    %r12,%rdi
  265218:	call   *0x39161a(%rip)        # 5f6838 <_DYNAMIC+0x218>
  26521e:	lea    0x368cdb(%rip),%rcx        # 5cdf00 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc0>
  265225:	mov    %r12,%rdi
  265228:	call   *0x3917ca(%rip)        # 5f69f8 <_DYNAMIC+0x3d8>
  26522e:	cmpb   $0x0,0x6b(%rax)
  265232:	sete   %al
  265235:	mov    %eax,0x10(%rsp)
  265239:	jmp    2638de <<glass::engine::Watch>::print_utf8+0x5e>
  26523e:	mov    0x391733(%rip),%rax        # 5f6978 <_DYNAMIC+0x358>
  265245:	lock incq 0x28(%rax)
  26524a:	mov    %rcx,%rdi
  26524d:	sub    0x10(%rsp),%rdi
  265252:	call   2fa8b0 <alacritty_terminal::grid::row::fill_census::note>
  265257:	mov    0x20(%rsp),%rcx
  26525c:	cmp    %rcx,%rbx
  26525f:	jae    265439 <<glass::engine::Watch>::print_utf8+0x1bb9>
  265265:	mov    0x18(%rsp),%rcx
  26526a:	mov    0x28(%rcx),%edi
  26526d:	mov    0x20(%rcx),%r8d
  265271:	mov    0x24(%rcx),%r9d
  265275:	movzwl 0x2c(%rcx),%r10d
  26527a:	mov    0x18(%rcx),%rsi
  26527e:	test   %rsi,%rsi
  265281:	mov    %rsi,0x38(%rsp)
  265286:	mov    %edi,0xc(%rsp)
  26528a:	mov    %r8d,0x60(%rsp)
  26528f:	mov    %r9d,0x70(%rsp)
  265294:	mov    %r10w,0x90(%rsp)
  26529d:	je     265366 <<glass::engine::Watch>::print_utf8+0x1ae6>
  2652a3:	lock incq (%rsi)
  2652a7:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  2652ad:	mov    0x10(%rcx),%rdx
  2652b1:	mov    %edi,0x50(%rsp)
  2652b5:	mov    %r8d,0x48(%rsp)
  2652ba:	mov    %r9d,0x4c(%rsp)
  2652bf:	mov    %r10w,0x54(%rsp)
  2652c5:	mov    %rsi,0x40(%rsp)
  2652ca:	mov    0x20(%rsp),%rsi
  2652cf:	cmp    %rdx,%rsi
  2652d2:	ja     2658e7 <<glass::engine::Watch>::print_utf8+0x2067>
  2652d8:	mov    0x10(%rsp),%rax
  2652dd:	lea    0x0(,%rax,8),%rax
  2652e5:	lea    (%rax,%rax,2),%rax
  2652e9:	mov    0x8(%rcx),%rbx
  2652ed:	add    %rax,%rbx
  2652f0:	lea    0x0(,%rsi,8),%rcx
  2652f8:	lea    (%rcx,%rcx,2),%r15
  2652fc:	sub    %rax,%r15
  2652ff:	mov    0x38(%rsp),%rsi
  265304:	jmp    265327 <<glass::engine::Watch>::print_utf8+0x1aa7>
  265306:	mov    %rsi,(%rbx)
  265309:	mov    %r8d,0x8(%rbx)
  26530d:	mov    %r9d,0xc(%rbx)
  265311:	mov    %edi,0x10(%rbx)
  265314:	mov    %r10w,0x14(%rbx)
  265319:	add    $0x18,%rbx
  26531d:	add    $0xffffffffffffffe8,%r15
  265321:	je     265403 <<glass::engine::Watch>::print_utf8+0x1b83>
  265327:	lock incq (%rsi)
  26532b:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  265331:	mov    (%rbx),%rax
  265334:	test   %rax,%rax
  265337:	je     265306 <<glass::engine::Watch>::print_utf8+0x1a86>
  265339:	lock decq (%rax)
  26533d:	jne    265306 <<glass::engine::Watch>::print_utf8+0x1a86>
  26533f:	mov    %rbx,%rdi
  265342:	call   *0x391540(%rip)        # 5f6888 <_DYNAMIC+0x268>
  265348:	movzwl 0x90(%rsp),%r10d
  265351:	mov    0x70(%rsp),%r9d
  265356:	mov    0x60(%rsp),%r8d
  26535b:	mov    0xc(%rsp),%edi
  26535f:	mov    0x38(%rsp),%rsi
  265364:	jmp    265306 <<glass::engine::Watch>::print_utf8+0x1a86>
  265366:	mov    %edi,0x50(%rsp)
  26536a:	mov    %r8d,0x48(%rsp)
  26536f:	mov    %r9d,0x4c(%rsp)
  265374:	mov    %r10w,0x54(%rsp)
  26537a:	mov    %rsi,0x40(%rsp)
  26537f:	mov    0x10(%rsp),%rax
  265384:	lea    0x0(,%rax,8),%rax
  26538c:	lea    (%rax,%rax,2),%rax
  265390:	mov    0x8(%rcx),%rbx
  265394:	add    %rax,%rbx
  265397:	mov    0x20(%rsp),%rcx
  26539c:	lea    0x0(,%rcx,8),%rcx
  2653a4:	lea    (%rcx,%rcx,2),%r15
  2653a8:	sub    %rax,%r15
  2653ab:	jmp    2653ce <<glass::engine::Watch>::print_utf8+0x1b4e>
  2653ad:	movq   $0x0,(%rbx)
  2653b4:	mov    %r8d,0x8(%rbx)
  2653b8:	mov    %r9d,0xc(%rbx)
  2653bc:	mov    %edi,0x10(%rbx)
  2653bf:	mov    %r10w,0x14(%rbx)
  2653c4:	add    $0x18,%rbx
  2653c8:	add    $0xffffffffffffffe8,%r15
  2653cc:	je     265403 <<glass::engine::Watch>::print_utf8+0x1b83>
  2653ce:	mov    (%rbx),%rax
  2653d1:	test   %rax,%rax
  2653d4:	je     2653ad <<glass::engine::Watch>::print_utf8+0x1b2d>
  2653d6:	lock decq (%rax)
  2653da:	jne    2653ad <<glass::engine::Watch>::print_utf8+0x1b2d>
  2653dc:	mov    %rbx,%rdi
  2653df:	call   *0x3914a3(%rip)        # 5f6888 <_DYNAMIC+0x268>
  2653e5:	movzwl 0x90(%rsp),%r10d
  2653ee:	mov    0x70(%rsp),%r9d
  2653f3:	mov    0x60(%rsp),%r8d
  2653f8:	mov    0xc(%rsp),%edi
  2653fc:	mov    0x38(%rsp),%rsi
  265401:	jmp    2653ad <<glass::engine::Watch>::print_utf8+0x1b2d>
  265403:	mov    0x18(%rsp),%rbx
  265408:	mov    0x10(%rsp),%rax
  26540d:	cmp    %eax,0x38(%rbx)
  265410:	jbe    265415 <<glass::engine::Watch>::print_utf8+0x1b95>
  265412:	mov    %eax,0x38(%rbx)
  265415:	test   %rsi,%rsi
  265418:	mov    0x20(%rsp),%rcx
  26541d:	je     265435 <<glass::engine::Watch>::print_utf8+0x1bb5>
  26541f:	lock decq (%rsi)
  265423:	jne    265435 <<glass::engine::Watch>::print_utf8+0x1bb5>
  265425:	lea    0x40(%rsp),%rdi
  26542a:	call   *0x391458(%rip)        # 5f6888 <_DYNAMIC+0x268>
  265430:	mov    0x20(%rsp),%rcx
  265435:	mov    0x10(%rbx),%r15
  265439:	cmp    %r15,%rcx
  26543c:	mov    0xc8(%rsp),%r15
  265444:	jb     26545f <<glass::engine::Watch>::print_utf8+0x1bdf>
  265446:	mov    0x80(%rsp),%rdi
  26544e:	call   1ae630 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  265453:	mov    0x18(%rsp),%rax
  265458:	movl   $0xffffffff,0x28(%rax)
  26545f:	mov    0x18(%rsp),%rdx
  265464:	mov    0x30(%rdx),%rax
  265468:	lea    0x1(%r12),%rcx
  26546d:	cmp    %rax,%rcx
  265470:	cmova  %rcx,%rax
  265474:	mov    0x10(%rdx),%rsi
  265478:	mov    %rax,0x30(%rdx)
  26547c:	cmp    %rsi,%r12
  26547f:	jae    265959 <<glass::engine::Watch>::print_utf8+0x20d9>
  265485:	mov    0x30(%rsp),%esi
  265489:	mov    %esi,%eax
  26548b:	or     $0x20,%eax
  26548e:	cmp    $0x2,%r13
  265492:	mov    0x8(%rdx),%rcx
  265496:	lea    (%r12,%r12,2),%rdx
  26549a:	lea    (%rcx,%rdx,8),%rbx
  26549e:	mov    %ebp,0x10(%rcx,%rdx,8)
  2654a2:	mov    0x28(%rsp),%edi
  2654a6:	mov    %edi,0x8(%rcx,%rdx,8)
  2654aa:	cmovne %esi,%eax
  2654ad:	mov    0x78(%rsp),%esi
  2654b1:	mov    %esi,0xc(%rcx,%rdx,8)
  2654b5:	mov    %ax,0x14(%rcx,%rdx,8)
  2654ba:	mov    (%rcx,%rdx,8),%rax
  2654be:	test   %rax,%rax
  2654c1:	je     2654d2 <<glass::engine::Watch>::print_utf8+0x1c52>
  2654c3:	lock decq (%rax)
  2654c7:	jne    2654d2 <<glass::engine::Watch>::print_utf8+0x1c52>
  2654c9:	mov    %rbx,%rdi
  2654cc:	call   *0x3913b6(%rip)        # 5f6888 <_DYNAMIC+0x268>
  2654d2:	movq   $0x0,(%rbx)
  2654d9:	cmp    $0x2,%r13
  2654dd:	mov    0xc0(%rsp),%r13
  2654e5:	jne    265813 <<glass::engine::Watch>::print_utf8+0x1f93>
  2654eb:	lea    0x1(%r12),%rcx
  2654f0:	mov    0x18(%rsp),%rax
  2654f5:	mov    0x30(%rax),%rbx
  2654f9:	mov    0x28(%rax),%eax
  2654fc:	mov    %rcx,0x38(%rsp)
  265501:	cmp    %rbx,%rcx
  265504:	jne    265537 <<glass::engine::Watch>::print_utf8+0x1cb7>
  265506:	cmp    $0xffffffff,%eax
  265509:	je     265537 <<glass::engine::Watch>::print_utf8+0x1cb7>
  26550b:	add    $0x2,%r12
  26550f:	mov    0x18(%rsp),%rcx
  265514:	mov    %r12,0x30(%rcx)
  265518:	mov    0x10(%rcx),%rsi
  26551c:	mov    0x38(%rsp),%rdi
  265521:	cmp    %rsi,%rdi
  265524:	jb     2657c4 <<glass::engine::Watch>::print_utf8+0x1f44>
  26552a:	lea    0x368a77(%rip),%rdx        # 5cdfa8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c68>
  265531:	call   *0x391301(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265537:	cmp    $0xffffffff,%eax
  26553a:	je     26579a <<glass::engine::Watch>::print_utf8+0x1f1a>
  265540:	mov    0x18(%rsp),%rax
  265545:	mov    0x10(%rax),%r15
  265549:	cmp    %rbx,%r15
  26554c:	mov    %rbx,%rax
  26554f:	cmovb  %r15,%rax
  265553:	mov    %rax,0x10(%rsp)
  265558:	lea    0x1(%r12),%rcx
  26555d:	cmp    %rcx,%r15
  265560:	cmovb  %r15,%rcx
  265564:	mov    0x3913d5(%rip),%rax        # 5f6940 <_DYNAMIC+0x320>
  26556b:	movzbl (%rax),%eax
  26556e:	test   %al,%al
  265570:	mov    %rcx,0x20(%rsp)
  265575:	je     2655a3 <<glass::engine::Watch>::print_utf8+0x1d23>
  265577:	cmp    %rcx,%rbx
  26557a:	jae    265585 <<glass::engine::Watch>::print_utf8+0x1d05>
  26557c:	mov    0x3913fd(%rip),%rax        # 5f6980 <_DYNAMIC+0x360>
  265583:	jmp    26558c <<glass::engine::Watch>::print_utf8+0x1d0c>
  265585:	mov    0x3913ec(%rip),%rax        # 5f6978 <_DYNAMIC+0x358>
  26558c:	lock incq 0x28(%rax)
  265591:	mov    %rcx,%rdi
  265594:	sub    0x10(%rsp),%rdi
  265599:	call   2fa8b0 <alacritty_terminal::grid::row::fill_census::note>
  26559e:	mov    0x20(%rsp),%rcx
  2655a3:	cmp    %rcx,%rbx
  2655a6:	jae    265774 <<glass::engine::Watch>::print_utf8+0x1ef4>
  2655ac:	mov    0x18(%rsp),%rcx
  2655b1:	mov    0x28(%rcx),%edi
  2655b4:	mov    0x20(%rcx),%r8d
  2655b8:	mov    0x24(%rcx),%r9d
  2655bc:	movzwl 0x2c(%rcx),%r10d
  2655c1:	mov    0x18(%rcx),%r15
  2655c5:	test   %r15,%r15
  2655c8:	mov    %edi,0xc(%rsp)
  2655cc:	mov    %r8d,0x60(%rsp)
  2655d1:	mov    %r9d,0x70(%rsp)
  2655d6:	mov    %r10w,0x90(%rsp)
  2655df:	je     26569e <<glass::engine::Watch>::print_utf8+0x1e1e>
  2655e5:	lock incq (%r15)
  2655e9:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  2655ef:	mov    0x10(%rcx),%rdx
  2655f3:	mov    %edi,0x50(%rsp)
  2655f7:	mov    %r8d,0x48(%rsp)
  2655fc:	mov    %r9d,0x4c(%rsp)
  265601:	mov    %r10w,0x54(%rsp)
  265607:	mov    %r15,0x40(%rsp)
  26560c:	mov    0x20(%rsp),%rsi
  265611:	cmp    %rdx,%rsi
  265614:	ja     265918 <<glass::engine::Watch>::print_utf8+0x2098>
  26561a:	mov    0x10(%rsp),%rax
  26561f:	lea    0x0(,%rax,8),%rax
  265627:	lea    (%rax,%rax,2),%rax
  26562b:	mov    0x8(%rcx),%rbx
  26562f:	add    %rax,%rbx
  265632:	lea    0x0(,%rsi,8),%rcx
  26563a:	lea    (%rcx,%rcx,2),%r13
  26563e:	sub    %rax,%r13
  265641:	jmp    265664 <<glass::engine::Watch>::print_utf8+0x1de4>
  265643:	mov    %r15,(%rbx)
  265646:	mov    %r8d,0x8(%rbx)
  26564a:	mov    %r9d,0xc(%rbx)
  26564e:	mov    %edi,0x10(%rbx)
  265651:	mov    %r10w,0x14(%rbx)
  265656:	add    $0x18,%rbx
  26565a:	add    $0xffffffffffffffe8,%r13
  26565e:	je     265736 <<glass::engine::Watch>::print_utf8+0x1eb6>
  265664:	lock incq (%r15)
  265668:	jle    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  26566e:	mov    (%rbx),%rax
  265671:	test   %rax,%rax
  265674:	je     265643 <<glass::engine::Watch>::print_utf8+0x1dc3>
  265676:	lock decq (%rax)
  26567a:	jne    265643 <<glass::engine::Watch>::print_utf8+0x1dc3>
  26567c:	mov    %rbx,%rdi
  26567f:	call   *0x391203(%rip)        # 5f6888 <_DYNAMIC+0x268>
  265685:	movzwl 0x90(%rsp),%r10d
  26568e:	mov    0x70(%rsp),%r9d
  265693:	mov    0x60(%rsp),%r8d
  265698:	mov    0xc(%rsp),%edi
  26569c:	jmp    265643 <<glass::engine::Watch>::print_utf8+0x1dc3>
  26569e:	mov    %edi,0x50(%rsp)
  2656a2:	mov    %r8d,0x48(%rsp)
  2656a7:	mov    %r9d,0x4c(%rsp)
  2656ac:	mov    %r10w,0x54(%rsp)
  2656b2:	mov    %r15,0x40(%rsp)
  2656b7:	mov    0x10(%rsp),%rax
  2656bc:	lea    0x0(,%rax,8),%rax
  2656c4:	lea    (%rax,%rax,2),%rax
  2656c8:	mov    0x8(%rcx),%rbx
  2656cc:	add    %rax,%rbx
  2656cf:	mov    0x20(%rsp),%rcx
  2656d4:	lea    0x0(,%rcx,8),%rcx
  2656dc:	lea    (%rcx,%rcx,2),%r13
  2656e0:	sub    %rax,%r13
  2656e3:	jmp    265706 <<glass::engine::Watch>::print_utf8+0x1e86>
  2656e5:	movq   $0x0,(%rbx)
  2656ec:	mov    %r8d,0x8(%rbx)
  2656f0:	mov    %r9d,0xc(%rbx)
  2656f4:	mov    %edi,0x10(%rbx)
  2656f7:	mov    %r10w,0x14(%rbx)
  2656fc:	add    $0x18,%rbx
  265700:	add    $0xffffffffffffffe8,%r13
  265704:	je     265736 <<glass::engine::Watch>::print_utf8+0x1eb6>
  265706:	mov    (%rbx),%rax
  265709:	test   %rax,%rax
  26570c:	je     2656e5 <<glass::engine::Watch>::print_utf8+0x1e65>
  26570e:	lock decq (%rax)
  265712:	jne    2656e5 <<glass::engine::Watch>::print_utf8+0x1e65>
  265714:	mov    %rbx,%rdi
  265717:	call   *0x39116b(%rip)        # 5f6888 <_DYNAMIC+0x268>
  26571d:	movzwl 0x90(%rsp),%r10d
  265726:	mov    0x70(%rsp),%r9d
  26572b:	mov    0x60(%rsp),%r8d
  265730:	mov    0xc(%rsp),%edi
  265734:	jmp    2656e5 <<glass::engine::Watch>::print_utf8+0x1e65>
  265736:	mov    0x18(%rsp),%rbx
  26573b:	mov    0x10(%rsp),%rax
  265740:	cmp    %eax,0x38(%rbx)
  265743:	jbe    265748 <<glass::engine::Watch>::print_utf8+0x1ec8>
  265745:	mov    %eax,0x38(%rbx)
  265748:	test   %r15,%r15
  26574b:	mov    0xc0(%rsp),%r13
  265753:	mov    0x20(%rsp),%rcx
  265758:	je     265770 <<glass::engine::Watch>::print_utf8+0x1ef0>
  26575a:	lock decq (%r15)
  26575e:	jne    265770 <<glass::engine::Watch>::print_utf8+0x1ef0>
  265760:	lea    0x40(%rsp),%rdi
  265765:	call   *0x39111d(%rip)        # 5f6888 <_DYNAMIC+0x268>
  26576b:	mov    0x20(%rsp),%rcx
  265770:	mov    0x10(%rbx),%r15
  265774:	cmp    %r15,%rcx
  265777:	mov    0xc8(%rsp),%r15
  26577f:	jb     26579a <<glass::engine::Watch>::print_utf8+0x1f1a>
  265781:	mov    0x80(%rsp),%rdi
  265789:	call   1ae630 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26578e:	mov    0x18(%rsp),%rax
  265793:	movl   $0xffffffff,0x28(%rax)
  26579a:	mov    0x18(%rsp),%rcx
  26579f:	mov    0x30(%rcx),%rax
  2657a3:	add    $0x2,%r12
  2657a7:	cmp    %rax,%r12
  2657aa:	cmovbe %rax,%r12
  2657ae:	mov    0x10(%rcx),%rsi
  2657b2:	mov    %r12,0x30(%rcx)
  2657b6:	mov    0x38(%rsp),%rdi
  2657bb:	cmp    %rsi,%rdi
  2657be:	jae    265979 <<glass::engine::Watch>::print_utf8+0x20f9>
  2657c4:	mov    0x8(%rcx),%rax
  2657c8:	lea    (%rdi,%rdi,2),%rcx
  2657cc:	lea    (%rax,%rcx,8),%rbx
  2657d0:	movl   $0x20,0x10(%rax,%rcx,8)
  2657d8:	mov    0x28(%rsp),%edx
  2657dc:	mov    %edx,0x8(%rax,%rcx,8)
  2657e0:	mov    0x78(%rsp),%edx
  2657e4:	mov    %edx,0xc(%rax,%rcx,8)
  2657e8:	mov    0x30(%rsp),%edx
  2657ec:	or     $0x40,%edx
  2657ef:	mov    %dx,0x14(%rax,%rcx,8)
  2657f4:	mov    (%rax,%rcx,8),%rax
  2657f8:	test   %rax,%rax
  2657fb:	je     26580c <<glass::engine::Watch>::print_utf8+0x1f8c>
  2657fd:	lock decq (%rax)
  265801:	jne    26580c <<glass::engine::Watch>::print_utf8+0x1f8c>
  265803:	mov    %rbx,%rdi
  265806:	call   *0x39107c(%rip)        # 5f6888 <_DYNAMIC+0x268>
  26580c:	movq   $0x0,(%rbx)
  265813:	mov    0xa0(%rsp),%rax
  26581b:	cmp    0x58(%rsp),%rax
  265820:	jb     26582a <<glass::engine::Watch>::print_utf8+0x1faa>
  265822:	dec    %rax
  265825:	movb   $0x1,0x6c(%r14)
  26582a:	mov    %rax,0x40(%r14)
  26582e:	incq   0xa0(%r15)
  265835:	mov    %ebp,0xb0(%r15)
  26583c:	jmp    265115 <<glass::engine::Watch>::print_utf8+0x1895>
  265841:	call   18c892 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  265846:	mov    %ebp,%ebx
  265848:	mov    0x393fa1(%rip),%rsi        # 5f97f0 <glass::engine::width_of::CACHE+0x8>
  26584f:	cmp    %rbx,%rsi
  265852:	ja     264fb2 <<glass::engine::Watch>::print_utf8+0x1732>
  265858:	lea    0x36a939(%rip),%rdx        # 5d0198 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17e58>
  26585f:	mov    %rbx,%rdi
  265862:	call   *0x390fd0(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265868:	lea    0x367b39(%rip),%rcx        # 5cd3a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  26586f:	mov    0xa8(%rsp),%rdi
  265877:	call   *0x39117b(%rip)        # 5f69f8 <_DYNAMIC+0x3d8>
  26587d:	jmp    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  265882:	lea    0x367b1f(%rip),%rcx        # 5cd3a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  265889:	call   *0x391169(%rip)        # 5f69f8 <_DYNAMIC+0x3d8>
  26588f:	jmp    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  265894:	lea    0x368005(%rip),%rdx        # 5cd8a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15560>
  26589b:	call   *0x390f97(%rip)        # 5f6838 <_DYNAMIC+0x218>
  2658a1:	lea    0x368010(%rip),%rax        # 5cd8b8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15578>
  2658a8:	jmp    2658c9 <<glass::engine::Watch>::print_utf8+0x2049>
  2658aa:	lea    0x36804f(%rip),%rdx        # 5cd900 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155c0>
  2658b1:	mov    %rbx,%rdi
  2658b4:	mov    0x30(%rsp),%rsi
  2658b9:	call   *0x390f79(%rip)        # 5f6838 <_DYNAMIC+0x218>
  2658bf:	mov    %rax,%rbx
  2658c2:	lea    0x368007(%rip),%rax        # 5cd8d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15590>
  2658c9:	mov    %rax,0xf0(%rsp)
  2658d1:	mov    %rbx,%rdi
  2658d4:	mov    0x30(%rsp),%rsi
  2658d9:	mov    0xf0(%rsp),%rdx
  2658e1:	call   *0x390f51(%rip)        # 5f6838 <_DYNAMIC+0x218>
  2658e7:	lea    0x367aba(%rip),%rcx        # 5cd3a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  2658ee:	mov    0x10(%rsp),%rdi
  2658f3:	call   *0x3910ff(%rip)        # 5f69f8 <_DYNAMIC+0x3d8>
  2658f9:	jmp    26592a <<glass::engine::Watch>::print_utf8+0x20aa>
  2658fb:	lea    0x36811e(%rip),%rdx        # 5cda20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x156e0>
  265902:	call   *0x390f30(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265908:	lea    0x3560b9(%rip),%rdx        # 5bb9c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  26590f:	mov    %rbx,%rdi
  265912:	call   *0x390f20(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265918:	lea    0x367a89(%rip),%rcx        # 5cd3a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  26591f:	mov    0x10(%rsp),%rdi
  265924:	call   *0x3910ce(%rip)        # 5f69f8 <_DYNAMIC+0x3d8>
  26592a:	ud2
  26592c:	lea    0x356095(%rip),%rdx        # 5bb9c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  265933:	call   *0x390eff(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265939:	lea    0x368668(%rip),%rdx        # 5cdfa8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c68>
  265940:	mov    %rbx,%rdi
  265943:	call   *0x390eef(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265949:	lea    0x368640(%rip),%rdx        # 5cdf90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c50>
  265950:	mov    %rbx,%rdi
  265953:	call   *0x390edf(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265959:	lea    0x368630(%rip),%rdx        # 5cdf90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c50>
  265960:	mov    %r12,%rdi
  265963:	call   *0x390ecf(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265969:	lea    0x356058(%rip),%rdx        # 5bb9c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  265970:	mov    %r12,%rdi
  265973:	call   *0x390ebf(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265979:	lea    0x368610(%rip),%rdx        # 5cdf90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c50>
  265980:	call   *0x390eb2(%rip)        # 5f6838 <_DYNAMIC+0x218>
  265986:	mov    %rax,%rbx
  265989:	lock decq (%r15)
  26598d:	je     2659b6 <<glass::engine::Watch>::print_utf8+0x2136>
  26598f:	jmp    2659c4 <<glass::engine::Watch>::print_utf8+0x2144>
  265991:	mov    %rax,%rbx
  265994:	mov    0x38(%rsp),%rax
  265999:	jmp    2659b0 <<glass::engine::Watch>::print_utf8+0x2130>
  26599b:	mov    %rax,%rbx
  26599e:	mov    0x98(%rsp),%rax
  2659a6:	jmp    2659b0 <<glass::engine::Watch>::print_utf8+0x2130>
  2659a8:	mov    %rax,%rbx
  2659ab:	mov    0x68(%rsp),%rax
  2659b0:	lock decq (%rax)
  2659b4:	jne    2659c4 <<glass::engine::Watch>::print_utf8+0x2144>
  2659b6:	mov    0x110(%rsp),%rdi
  2659be:	call   *0x390ec4(%rip)        # 5f6888 <_DYNAMIC+0x268>
  2659c4:	mov    %rbx,%rdi
  2659c7:	call   5b4c30 <_Unwind_Resume@plt>
