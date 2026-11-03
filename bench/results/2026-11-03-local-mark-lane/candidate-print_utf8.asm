
/tmp/glass-i31-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000262620 <<glass::engine::Watch>::print_utf8>:
  262620:	push   %rbp
  262621:	push   %r15
  262623:	push   %r14
  262625:	push   %r13
  262627:	push   %r12
  262629:	push   %rbx
  26262a:	sub    $0x108,%rsp
  262631:	mov    %rdx,0x38(%rsp)
  262636:	mov    %rsi,0x28(%rsp)
  26263b:	mov    %rdi,%r12
  26263e:	cmpb   $0x1,0xbe(%rdi)
  262645:	jne    262674 <<glass::engine::Watch>::print_utf8+0x54>
  262647:	cmpq   $0x0,0x38(%r12)
  26264d:	jne    262674 <<glass::engine::Watch>::print_utf8+0x54>
  26264f:	mov    0x78(%r12),%rax
  262654:	testb  $0x4,0x6c5(%rax)
  26265b:	jne    262674 <<glass::engine::Watch>::print_utf8+0x54>
  26265d:	cmpq   $0x0,0x50(%rax)
  262662:	jne    262674 <<glass::engine::Watch>::print_utf8+0x54>
  262664:	movzwl 0x64(%rax),%ecx
  262668:	test   $0x460,%ecx
  26266e:	je     26422c <<glass::engine::Watch>::print_utf8+0x1c0c>
  262674:	movl   $0x0,0x48(%rsp)
  26267c:	movl   $0x0,0x4c(%rsp)
  262684:	mov    $0xffffffff,%r9d
  26268a:	xor    %r13d,%r13d
  26268d:	lea    0x367b44(%rip),%rax        # 5ca1d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x154d8>
  262694:	mov    %rax,0xc0(%rsp)
  26269c:	lea    0x68(%rsp),%rax
  2626a1:	mov    %rax,0x100(%rsp)
  2626a9:	xor    %edx,%edx
  2626ab:	mov    %r12,0xa8(%rsp)
  2626b3:	jmp    2626dc <<glass::engine::Watch>::print_utf8+0xbc>
  2626b5:	data16 cs nopw 0x0(%rax,%rax,1)
  2626c0:	mov    %r12,%rdi
  2626c3:	mov    %r9,%rbx
  2626c6:	mov    %rdx,%r14
  2626c9:	call   33dc40 <<glass::engine::Watch as vte::ansi::Handler>::input>
  2626ce:	mov    %r14,%rdx
  2626d1:	mov    %rbx,%r9
  2626d4:	mov    0x18(%rsp),%r13
  2626d9:	add    %r13,%rdx
  2626dc:	cmpb   $0x0,0x4c(%rsp)
  2626e1:	je     2634d5 <<glass::engine::Watch>::print_utf8+0xeb5>
  2626e7:	mov    0x78(%r12),%rbx
  2626ec:	cmpb   $0x0,0x6c(%rbx)
  2626f0:	jne    2634d5 <<glass::engine::Watch>::print_utf8+0xeb5>
  2626f6:	mov    0x30(%rbx),%eax
  2626f9:	sub    0x48(%rbx),%eax
  2626fc:	cltq
  2626fe:	mov    0x20(%rbx),%rsi
  262702:	mov    0x28(%rbx),%rcx
  262706:	lea    (%rcx,%rax,1),%rdi
  26270a:	dec    %rdi
  26270d:	cmp    %rsi,%rdi
  262710:	mov    $0x0,%eax
  262715:	cmovae %rsi,%rax
  262719:	sub    %rax,%rdi
  26271c:	cmp    %rsi,%rdi
  26271f:	jae    264b2c <<glass::engine::Watch>::print_utf8+0x250c>
  262725:	mov    0xa0(%rbx),%rax
  26272c:	mov    %rax,0x88(%rsp)
  262734:	mov    0x40(%rbx),%r12
  262738:	mov    0x58(%rbx),%eax
  26273b:	mov    %eax,0x34(%rsp)
  26273f:	mov    0x5c(%rbx),%eax
  262742:	mov    %eax,0x60(%rsp)
  262746:	movzwl 0x64(%rbx),%eax
  26274a:	mov    %eax,0x30(%rsp)
  26274e:	mov    0x18(%rbx),%rax
  262752:	shl    $0x6,%rdi
  262756:	lea    (%rax,%rdi,1),%rbp
  26275a:	cmp    %r12d,0x38(%rax,%rdi,1)
  26275f:	jbe    262765 <<glass::engine::Watch>::print_utf8+0x145>
  262761:	mov    %r12d,0x38(%rbp)
  262765:	mov    %rdx,0x20(%rsp)
  26276a:	mov    0x28(%rbp),%r8d
  26276e:	cmp    $0xffffffff,%r8d
  262772:	mov    %r12,0x58(%rsp)
  262777:	je     26282a <<glass::engine::Watch>::print_utf8+0x20a>
  26277d:	mov    0x30(%rbp),%rax
  262781:	cmp    %rax,%r12
  262784:	mov    $0x0,%ecx
  262789:	cmovb  %rax,%rcx
  26278d:	mov    %rcx,0x98(%rsp)
  262795:	movl   $0x20,0xf8(%rsp)
  2627a0:	mov    0x34(%rsp),%ecx
  2627a4:	mov    %ecx,0xf0(%rsp)
  2627ab:	mov    0x60(%rsp),%ecx
  2627af:	mov    %ecx,0xf4(%rsp)
  2627b6:	mov    0x30(%rsp),%ecx
  2627ba:	mov    %cx,0xfc(%rsp)
  2627c2:	movq   $0x0,0xe8(%rsp)
  2627ce:	mov    0x10(%rbp),%rcx
  2627d2:	cmp    %rax,%rcx
  2627d5:	mov    %rax,%r10
  2627d8:	cmovb  %rcx,%r10
  2627dc:	cmp    %r12,%rcx
  2627df:	mov    %r12,%r14
  2627e2:	cmovb  %rcx,%r14
  2627e6:	mov    0x3908d3(%rip),%rdx        # 5f30c0 <_DYNAMIC+0x320>
  2627ed:	movzbl (%rdx),%edx
  2627f0:	test   %dl,%dl
  2627f2:	je     2628cb <<glass::engine::Watch>::print_utf8+0x2ab>
  2627f8:	mov    0x3908f9(%rip),%rdx        # 5f30f8 <_DYNAMIC+0x358>
  2627ff:	cmp    %r14,%rax
  262802:	jae    26280b <<glass::engine::Watch>::print_utf8+0x1eb>
  262804:	mov    0x3908f5(%rip),%rdx        # 5f3100 <_DYNAMIC+0x360>
  26280b:	lock incq 0x28(%rdx)
  262810:	mov    0x3908c1(%rip),%rdx        # 5f30d8 <_DYNAMIC+0x338>
  262817:	lock incq (%rdx)
  26281b:	mov    %r14,%rdx
  26281e:	sub    %r10,%rdx
  262821:	jne    262880 <<glass::engine::Watch>::print_utf8+0x260>
  262823:	xor    %esi,%esi
  262825:	jmp    2628bf <<glass::engine::Watch>::print_utf8+0x29f>
  26282a:	movl   $0x20,0xf8(%rsp)
  262835:	mov    0x34(%rsp),%eax
  262839:	mov    %eax,0xf0(%rsp)
  262840:	mov    0x60(%rsp),%eax
  262844:	mov    %eax,0xf4(%rsp)
  26284b:	mov    0x30(%rsp),%eax
  26284f:	mov    %ax,0xfc(%rsp)
  262857:	movq   $0x0,0xe8(%rsp)
  262863:	lea    0x30(%rbp),%rax
  262867:	mov    %rax,0xc8(%rsp)
  26286f:	movq   $0xffffffffffffffff,0x98(%rsp)
  26287b:	jmp    262a4e <<glass::engine::Watch>::print_utf8+0x42e>
  262880:	mov    0x390859(%rip),%rsi        # 5f30e0 <_DYNAMIC+0x340>
  262887:	lock add %rdx,(%rsi)
  26288b:	cmp    $0x5,%rdx
  26288f:	jae    26289f <<glass::engine::Watch>::print_utf8+0x27f>
  262891:	lea    -0x204c88(%rip),%rsi        # 5dc10 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  262898:	movzbl -0x1(%rdx,%rsi,1),%esi
  26289d:	jmp    2628bf <<glass::engine::Watch>::print_utf8+0x29f>
  26289f:	lea    -0x5(%rdx),%rdi
  2628a3:	mov    $0x4,%esi
  2628a8:	cmp    $0x4,%rdi
  2628ac:	jb     2628bf <<glass::engine::Watch>::print_utf8+0x29f>
  2628ae:	add    $0xfffffffffffffff7,%rdx
  2628b2:	cmp    $0x8,%rdx
  2628b6:	mov    $0x6,%esi
  2628bb:	sbb    $0x0,%rsi
  2628bf:	mov    0x39080a(%rip),%rdx        # 5f30d0 <_DYNAMIC+0x330>
  2628c6:	lock incq (%rdx,%rsi,8)
  2628cb:	cmp    %r14,%rax
  2628ce:	mov    %r9,0x10(%rsp)
  2628d3:	jae    262a13 <<glass::engine::Watch>::print_utf8+0x3f3>
  2628d9:	mov    %r10,0x50(%rsp)
  2628de:	mov    %r14,0x80(%rsp)
  2628e6:	mov    %rbx,0x90(%rsp)
  2628ee:	mov    %r13,0x18(%rsp)
  2628f3:	mov    0x20(%rbp),%r13d
  2628f7:	mov    0x24(%rbp),%r12d
  2628fb:	movzwl 0x2c(%rbp),%edi
  2628ff:	mov    0x18(%rbp),%r15
  262903:	test   %r15,%r15
  262906:	je     262912 <<glass::engine::Watch>::print_utf8+0x2f2>
  262908:	lock incq (%r15)
  26290c:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  262912:	mov    %r8d,0x78(%rsp)
  262917:	mov    %r13d,0x70(%rsp)
  26291c:	mov    %r12d,0x74(%rsp)
  262921:	mov    %di,0x7c(%rsp)
  262926:	mov    %r15,0x68(%rsp)
  26292b:	mov    0x50(%rsp),%rax
  262930:	lea    0x0(,%rax,8),%rax
  262938:	lea    (%rax,%rax,2),%rax
  26293c:	mov    %rbp,0xd8(%rsp)
  262944:	mov    0x8(%rbp),%rbx
  262948:	add    %rax,%rbx
  26294b:	mov    0x80(%rsp),%rcx
  262953:	lea    0x0(,%rcx,8),%rcx
  26295b:	lea    (%rcx,%rcx,2),%rbp
  26295f:	sub    %rax,%rbp
  262962:	mov    %di,0x40(%rsp)
  262967:	jmp    26298d <<glass::engine::Watch>::print_utf8+0x36d>
  262969:	nopl   0x0(%rax)
  262970:	mov    %r15,(%rbx)
  262973:	mov    %r13d,0x8(%rbx)
  262977:	mov    %r12d,0xc(%rbx)
  26297b:	mov    %r8d,0x10(%rbx)
  26297f:	mov    %di,0x14(%rbx)
  262983:	add    $0x18,%rbx
  262987:	add    $0xffffffffffffffe8,%rbp
  26298b:	je     2629c5 <<glass::engine::Watch>::print_utf8+0x3a5>
  26298d:	test   %r15,%r15
  262990:	je     26299c <<glass::engine::Watch>::print_utf8+0x37c>
  262992:	lock incq (%r15)
  262996:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  26299c:	mov    (%rbx),%rax
  26299f:	test   %rax,%rax
  2629a2:	je     262970 <<glass::engine::Watch>::print_utf8+0x350>
  2629a4:	lock decq (%rax)
  2629a8:	jne    262970 <<glass::engine::Watch>::print_utf8+0x350>
  2629aa:	mov    %rbx,%rdi
  2629ad:	mov    %r8d,%r14d
  2629b0:	call   *0x390652(%rip)        # 5f3008 <_DYNAMIC+0x268>
  2629b6:	movzwl 0x40(%rsp),%edi
  2629bb:	mov    %r14d,%r8d
  2629be:	mov    0x10(%rsp),%r9
  2629c3:	jmp    262970 <<glass::engine::Watch>::print_utf8+0x350>
  2629c5:	mov    0xd8(%rsp),%rbp
  2629cd:	mov    0x50(%rsp),%rax
  2629d2:	cmp    %eax,0x38(%rbp)
  2629d5:	jbe    2629da <<glass::engine::Watch>::print_utf8+0x3ba>
  2629d7:	mov    %eax,0x38(%rbp)
  2629da:	test   %r15,%r15
  2629dd:	mov    0x18(%rsp),%r13
  2629e2:	mov    0x90(%rsp),%rbx
  2629ea:	mov    0x58(%rsp),%r12
  2629ef:	mov    0x80(%rsp),%r14
  2629f7:	je     262a0f <<glass::engine::Watch>::print_utf8+0x3ef>
  2629f9:	lock decq (%r15)
  2629fd:	jne    262a0f <<glass::engine::Watch>::print_utf8+0x3ef>
  2629ff:	lea    0x68(%rsp),%rdi
  262a04:	call   *0x3905fe(%rip)        # 5f3008 <_DYNAMIC+0x268>
  262a0a:	mov    0x10(%rsp),%r9
  262a0f:	mov    0x10(%rbp),%rcx
  262a13:	lea    0x30(%rbp),%rax
  262a17:	mov    %rax,0xc8(%rsp)
  262a1f:	cmp    %rcx,%r14
  262a22:	jb     262a4e <<glass::engine::Watch>::print_utf8+0x42e>
  262a24:	cmpl   $0xffffffff,0x28(%rbp)
  262a28:	je     262a47 <<glass::engine::Watch>::print_utf8+0x427>
  262a2a:	lea    0x18(%rbp),%rdi
  262a2e:	mov    (%rdi),%rax
  262a31:	test   %rax,%rax
  262a34:	je     262a47 <<glass::engine::Watch>::print_utf8+0x427>
  262a36:	lock decq (%rax)
  262a3a:	jne    262a47 <<glass::engine::Watch>::print_utf8+0x427>
  262a3c:	call   *0x3905c6(%rip)        # 5f3008 <_DYNAMIC+0x268>
  262a42:	mov    0x10(%rsp),%r9
  262a47:	movl   $0xffffffff,0x28(%rbp)
  262a4e:	mov    0x10(%rbp),%rdx
  262a52:	mov    0x30(%rbp),%rax
  262a56:	cmp    %r12,%rdx
  262a59:	mov    %r12,%rsi
  262a5c:	cmovb  %rdx,%rsi
  262a60:	cmp    %rax,%rsi
  262a63:	cmova  %rsi,%rax
  262a67:	mov    %rdx,%rcx
  262a6a:	mov    %rax,0x30(%rbp)
  262a6e:	sub    %r12,%rcx
  262a71:	mov    %rcx,0x80(%rsp)
  262a79:	jb     264457 <<glass::engine::Watch>::print_utf8+0x1e37>
  262a7f:	mov    0x20(%rsp),%rdx
  262a84:	cmp    0x38(%rsp),%rdx
  262a89:	jae    262afe <<glass::engine::Watch>::print_utf8+0x4de>
  262a8b:	mov    %rbx,0x90(%rsp)
  262a93:	mov    %r13,0x18(%rsp)
  262a98:	mov    %rbp,0xd8(%rsp)
  262aa0:	mov    0x8(%rbp),%r10
  262aa4:	lea    (%r12,%r12,2),%rax
  262aa8:	lea    (%r10,%rax,8),%rax
  262aac:	mov    %rax,0xa0(%rsp)
  262ab4:	mov    0x30(%rsp),%eax
  262ab8:	mov    %eax,%ecx
  262aba:	or     $0x20,%ecx
  262abd:	mov    %ecx,0xbc(%rsp)
  262ac4:	or     $0x40,%eax
  262ac7:	mov    %eax,0xe4(%rsp)
  262ace:	mov    $0x1,%al
  262ad0:	mov    %eax,0x4(%rsp)
  262ad4:	movq   $0x0,0x10(%rsp)
  262add:	movq   $0x0,0xb0(%rsp)
  262ae9:	mov    %r12,0x8(%rsp)
  262aee:	xor    %r8d,%r8d
  262af1:	mov    %r12,%r14
  262af4:	mov    %r10,0x50(%rsp)
  262af9:	jmp    262b8e <<glass::engine::Watch>::print_utf8+0x56e>
  262afe:	xor    %eax,%eax
  262b00:	xor    %ecx,%ecx
  262b02:	jmp    2634be <<glass::engine::Watch>::print_utf8+0xe9e>
  262b07:	nopw   0x0(%rax,%rax,1)
  262b10:	movq   $0x0,(%r12)
  262b18:	mov    0x34(%rsp),%eax
  262b1c:	mov    %eax,0x8(%r12)
  262b21:	mov    0x60(%rsp),%eax
  262b25:	mov    %eax,0xc(%r12)
  262b2a:	movl   $0x20,0x10(%r12)
  262b33:	mov    0xe4(%rsp),%eax
  262b3a:	mov    %ax,0x14(%r12)
  262b40:	movl   $0x0,0x4(%rsp)
  262b48:	xor    %eax,%eax
  262b4a:	cmp    0x88(%rsp),%rsi
  262b52:	setae  %al
  262b55:	mov    %rsi,%r14
  262b58:	mov    %rax,0x10(%rsp)
  262b5d:	sub    %rax,%r14
  262b60:	incq   0xb0(%rsp)
  262b68:	mov    $0x1,%r8b
  262b6b:	mov    %rsi,0x8(%rsp)
  262b70:	mov    0x58(%rsp),%r12
  262b75:	add    %r11,%r13
  262b78:	mov    %r13,%rdx
  262b7b:	mov    %ebp,%r9d
  262b7e:	mov    %r11,0x18(%rsp)
  262b83:	cmp    0x38(%rsp),%r13
  262b88:	jae    263464 <<glass::engine::Watch>::print_utf8+0xe44>
  262b8e:	mov    0x28(%rsp),%rax
  262b93:	movzbl (%rax,%rdx,1),%ebp
  262b97:	test   %bpl,%bpl
  262b9a:	js     262bc0 <<glass::engine::Watch>::print_utf8+0x5a0>
  262b9c:	mov    $0x1,%r13d
  262ba2:	lea    -0x7f(%rbp),%eax
  262ba5:	cmp    $0x21,%eax
  262ba8:	jae    262d5f <<glass::engine::Watch>::print_utf8+0x73f>
  262bae:	jmp    2633f3 <<glass::engine::Watch>::print_utf8+0xdd3>
  262bb3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262bc0:	lea    0x3e(%rbp),%eax
  262bc3:	cmp    $0x1e,%al
  262bc5:	jae    262bf8 <<glass::engine::Watch>::print_utf8+0x5d8>
  262bc7:	lea    0x1(%rdx),%rax
  262bcb:	cmp    0x38(%rsp),%rax
  262bd0:	jae    2633f3 <<glass::engine::Watch>::print_utf8+0xdd3>
  262bd6:	mov    0x28(%rsp),%rcx
  262bdb:	movzbl (%rcx,%rax,1),%eax
  262bdf:	cmp    $0xbf,%al
  262be1:	jg     2633f3 <<glass::engine::Watch>::print_utf8+0xdd3>
  262be7:	and    $0x1f,%ebp
  262bea:	shl    $0x6,%ebp
  262bed:	mov    $0x2,%r13d
  262bf3:	jmp    262d32 <<glass::engine::Watch>::print_utf8+0x712>
  262bf8:	mov    %ebp,%eax
  262bfa:	and    $0xf0,%al
  262bfc:	cmp    $0xe0,%al
  262bfe:	jne    262c18 <<glass::engine::Watch>::print_utf8+0x5f8>
  262c00:	mov    $0xbf,%al
  262c02:	cmp    $0xe0,%ebp
  262c08:	je     262c3b <<glass::engine::Watch>::print_utf8+0x61b>
  262c0a:	mov    $0x80,%cl
  262c0c:	cmp    $0xed,%ebp
  262c12:	jne    262c3d <<glass::engine::Watch>::print_utf8+0x61d>
  262c14:	mov    $0x9f,%al
  262c16:	jmp    262c3d <<glass::engine::Watch>::print_utf8+0x61d>
  262c18:	lea    0x10(%rbp),%eax
  262c1b:	cmp    $0x4,%al
  262c1d:	ja     2633f3 <<glass::engine::Watch>::print_utf8+0xdd3>
  262c23:	mov    $0xbf,%al
  262c25:	cmp    $0xf0,%ebp
  262c2b:	je     262ca3 <<glass::engine::Watch>::print_utf8+0x683>
  262c2d:	mov    $0x80,%cl
  262c2f:	cmp    $0xf4,%ebp
  262c35:	jne    262ca5 <<glass::engine::Watch>::print_utf8+0x685>
  262c37:	mov    $0x8f,%al
  262c39:	jmp    262ca5 <<glass::engine::Watch>::print_utf8+0x685>
  262c3b:	mov    $0xa0,%cl
  262c3d:	mov    %rdx,%rsi
  262c40:	inc    %rdx
  262c43:	cmp    0x38(%rsp),%rdx
  262c48:	jae    26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262c4e:	mov    0x28(%rsp),%rdi
  262c53:	movzbl (%rdi,%rdx,1),%edx
  262c57:	cmp    %dl,%cl
  262c59:	ja     26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262c5f:	cmp    %al,%dl
  262c61:	ja     26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262c67:	lea    0x2(%rsi),%rax
  262c6b:	cmp    0x38(%rsp),%rax
  262c70:	jae    26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262c76:	mov    0x28(%rsp),%rcx
  262c7b:	movzbl (%rcx,%rax,1),%eax
  262c7f:	cmp    $0xc0,%al
  262c81:	jge    26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262c87:	movzbl %dl,%ecx
  262c8a:	and    $0x3f,%ecx
  262c8d:	shl    $0x6,%ecx
  262c90:	and    $0xf,%ebp
  262c93:	shl    $0xc,%ebp
  262c96:	or     %ecx,%ebp
  262c98:	mov    $0x3,%r13d
  262c9e:	jmp    262d2f <<glass::engine::Watch>::print_utf8+0x70f>
  262ca3:	mov    $0x90,%cl
  262ca5:	mov    %rdx,%rsi
  262ca8:	inc    %rdx
  262cab:	cmp    0x38(%rsp),%rdx
  262cb0:	jae    26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262cb6:	mov    0x28(%rsp),%rdi
  262cbb:	movzbl (%rdi,%rdx,1),%edx
  262cbf:	cmp    %dl,%cl
  262cc1:	ja     26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262cc7:	cmp    %al,%dl
  262cc9:	ja     26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262ccf:	lea    0x2(%rsi),%rax
  262cd3:	cmp    0x38(%rsp),%rax
  262cd8:	jae    26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262cde:	mov    0x28(%rsp),%rcx
  262ce3:	movzbl (%rcx,%rax,1),%ecx
  262ce7:	cmp    $0xbf,%cl
  262cea:	jg     26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262cf0:	lea    0x3(%rsi),%rax
  262cf4:	cmp    0x38(%rsp),%rax
  262cf9:	jae    26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262cff:	mov    0x28(%rsp),%rdi
  262d04:	movzbl (%rdi,%rax,1),%eax
  262d08:	cmp    $0xc0,%al
  262d0a:	jge    26340a <<glass::engine::Watch>::print_utf8+0xdea>
  262d10:	movzbl %dl,%edx
  262d13:	and    $0x3f,%ecx
  262d16:	shl    $0x6,%ecx
  262d19:	and    $0x3f,%edx
  262d1c:	shl    $0xc,%edx
  262d1f:	and    $0x7,%ebp
  262d22:	shl    $0x12,%ebp
  262d25:	or     %edx,%ebp
  262d27:	or     %ecx,%ebp
  262d29:	mov    $0x4,%r13d
  262d2f:	mov    %rsi,%rdx
  262d32:	mov    %ebp,%ecx
  262d34:	xor    $0xd800,%ecx
  262d3a:	add    $0xffef0000,%ecx
  262d40:	cmp    $0xffef0800,%ecx
  262d46:	jb     2633f3 <<glass::engine::Watch>::print_utf8+0xdd3>
  262d4c:	and    $0x3f,%al
  262d4e:	movzbl %al,%eax
  262d51:	or     %eax,%ebp
  262d53:	lea    -0x7f(%rbp),%eax
  262d56:	cmp    $0x21,%eax
  262d59:	jb     2633f3 <<glass::engine::Watch>::print_utf8+0xdd3>
  262d5f:	cmp    $0xffffffff,%r9d
  262d63:	je     262da0 <<glass::engine::Watch>::print_utf8+0x780>
  262d65:	lea    -0x20(%r9),%eax
  262d69:	cmp    $0x5f,%eax
  262d6c:	mov    %r14,0x40(%rsp)
  262d71:	jae    262db0 <<glass::engine::Watch>::print_utf8+0x790>
  262d73:	mov    %rdx,%r11
  262d76:	mov    0x18(%rsp),%rdx
  262d7b:	mov    $0x1,%eax
  262d80:	cmpb   $0x0,0x48(%rsp)
  262d85:	je     263454 <<glass::engine::Watch>::print_utf8+0xe34>
  262d8b:	testb  $0x1,0x10(%rsp)
  262d90:	je     262e0b <<glass::engine::Watch>::print_utf8+0x7eb>
  262d92:	jmp    26344d <<glass::engine::Watch>::print_utf8+0xe2d>
  262d97:	nopw   0x0(%rax,%rax,1)
  262da0:	mov    %rdx,%r11
  262da3:	mov    0x8(%rsp),%rsi
  262da8:	jmp    262b75 <<glass::engine::Watch>::print_utf8+0x555>
  262dad:	nopl   (%rax)
  262db0:	mov    0x3931c2(%rip),%eax        # 5f5f78 <glass::engine::width_of::CACHE+0x10>
  262db6:	test   %eax,%eax
  262db8:	jne    2633b0 <<glass::engine::Watch>::print_utf8+0xd90>
  262dbe:	mov    %r9d,%edi
  262dc1:	mov    0x3931a8(%rip),%rsi        # 5f5f70 <glass::engine::width_of::CACHE+0x8>
  262dc8:	cmp    %rdi,%rsi
  262dcb:	jbe    264b1f <<glass::engine::Watch>::print_utf8+0x24ff>
  262dd1:	mov    0x393190(%rip),%rbx        # 5f5f68 <glass::engine::width_of::CACHE>
  262dd8:	movzbl (%rbx,%rdi,1),%eax
  262ddc:	test   %al,%al
  262dde:	js     262f28 <<glass::engine::Watch>::print_utf8+0x908>
  262de4:	lea    -0x1(%rax),%ecx
  262de7:	cmp    $0x2,%cl
  262dea:	jae    262f7c <<glass::engine::Watch>::print_utf8+0x95c>
  262df0:	mov    %rdx,%r11
  262df3:	mov    0x18(%rsp),%rdx
  262df8:	mov    0x40(%rsp),%r14
  262dfd:	movzbl %al,%eax
  262e00:	testb  $0x1,0x10(%rsp)
  262e05:	jne    26344d <<glass::engine::Watch>::print_utf8+0xe2d>
  262e0b:	lea    (%rax,%r14,1),%rsi
  262e0f:	cmp    0x88(%rsp),%rsi
  262e17:	ja     26341a <<glass::engine::Watch>::print_utf8+0xdfa>
  262e1d:	mov    %r14,%rdi
  262e20:	sub    %r12,%rdi
  262e23:	cmp    0x98(%rsp),%r14
  262e2b:	jae    262ea0 <<glass::engine::Watch>::print_utf8+0x880>
  262e2d:	cmp    0x80(%rsp),%rdi
  262e35:	jae    264b42 <<glass::engine::Watch>::print_utf8+0x2522>
  262e3b:	lea    (%r14,%r14,2),%rcx
  262e3f:	testb  $0x60,0x14(%r10,%rcx,8)
  262e45:	jne    26341a <<glass::engine::Watch>::print_utf8+0xdfa>
  262e4b:	lea    (%r10,%rcx,8),%r12
  262e4f:	cmp    $0x2,%eax
  262e52:	jne    2632b6 <<glass::engine::Watch>::print_utf8+0xc96>
  262e58:	lea    0x1(%rdi),%rax
  262e5c:	cmp    0x80(%rsp),%rax
  262e64:	jae    264ba6 <<glass::engine::Watch>::print_utf8+0x2586>
  262e6a:	mov    %r14,%r8
  262e6d:	mov    %rdi,%rbx
  262e70:	lea    (%rax,%rax,2),%rax
  262e74:	mov    $0x1,%r14b
  262e77:	mov    0xa0(%rsp),%rcx
  262e7f:	testb  $0x60,0x14(%rcx,%rax,8)
  262e84:	mov    0xbc(%rsp),%r15d
  262e8c:	je     262ed5 <<glass::engine::Watch>::print_utf8+0x8b5>
  262e8e:	jmp    263a2f <<glass::engine::Watch>::print_utf8+0x140f>
  262e93:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262ea0:	mov    %rdi,%rbx
  262ea3:	cmp    0x80(%rsp),%rdi
  262eab:	jae    264b39 <<glass::engine::Watch>::print_utf8+0x2519>
  262eb1:	mov    %r14,%r8
  262eb4:	lea    (%r14,%r14,2),%rcx
  262eb8:	lea    (%r10,%rcx,8),%r12
  262ebc:	cmp    $0x2,%rax
  262ec0:	sete   %r14b
  262ec4:	cmp    $0x2,%eax
  262ec7:	mov    0x30(%rsp),%r15d
  262ecc:	cmove  0xbc(%rsp),%r15d
  262ed5:	mov    (%r12),%rax
  262ed9:	test   %rax,%rax
  262edc:	je     2632e0 <<glass::engine::Watch>::print_utf8+0xcc0>
  262ee2:	lock decq (%rax)
  262ee6:	jne    2632e0 <<glass::engine::Watch>::print_utf8+0xcc0>
  262eec:	mov    %r12,%rdi
  262eef:	mov    %r9,0x10(%rsp)
  262ef4:	mov    %r11,0xd0(%rsp)
  262efc:	mov    %rsi,0x18(%rsp)
  262f01:	call   *0x390101(%rip)        # 5f3008 <_DYNAMIC+0x268>
  262f07:	mov    0x18(%rsp),%rsi
  262f0c:	mov    0xd0(%rsp),%r11
  262f14:	mov    0x50(%rsp),%r10
  262f19:	mov    0x10(%rsp),%r9
  262f1e:	mov    0x40(%rsp),%r8
  262f23:	jmp    2632e0 <<glass::engine::Watch>::print_utf8+0xcc0>
  262f28:	cmp    $0xfe,%al
  262f2a:	je     2639b6 <<glass::engine::Watch>::print_utf8+0x1396>
  262f30:	add    %rdi,%rbx
  262f33:	cmp    $0xa0,%r9d
  262f3a:	jb     263a14 <<glass::engine::Watch>::print_utf8+0x13f4>
  262f40:	mov    %r9d,%edi
  262f43:	mov    %r9,%r12
  262f46:	mov    %r15,0x20(%rsp)
  262f4b:	mov    %rdx,%r15
  262f4e:	mov    %r8,%r14
  262f51:	call   299260 <unicode_width::tables::lookup_width>
  262f56:	mov    %r14,%r8
  262f59:	mov    0x50(%rsp),%r10
  262f5e:	mov    %r15,%rdx
  262f61:	mov    0x20(%rsp),%r15
  262f66:	mov    %r12,%r9
  262f69:	mov    0x58(%rsp),%r12
  262f6e:	mov    %al,(%rbx)
  262f70:	lea    -0x1(%rax),%ecx
  262f73:	cmp    $0x2,%cl
  262f76:	jb     262df0 <<glass::engine::Watch>::print_utf8+0x7d0>
  262f7c:	test   %al,%al
  262f7e:	sete   %al
  262f81:	and    %r8b,%al
  262f84:	cmp    $0x1,%al
  262f86:	jne    2639b6 <<glass::engine::Watch>::print_utf8+0x1396>
  262f8c:	cmp    0x80(%rsp),%r15
  262f94:	jae    264b63 <<glass::engine::Watch>::print_utf8+0x2543>
  262f9a:	mov    %rdx,%rbx
  262f9d:	lea    (%r15,%r15,2),%rax
  262fa1:	mov    0xa0(%rsp),%rcx
  262fa9:	lea    (%rcx,%rax,8),%rdi
  262fad:	mov    %rdi,0x18(%rsp)
  262fb2:	mov    %r9d,%esi
  262fb5:	call   291980 <<alacritty_terminal::term::cell::Cell>::push_zerowidth>
  262fba:	mov    %rbx,%rdx
  262fbd:	add    %rbx,%r13
  262fc0:	cmp    0x38(%rsp),%r13
  262fc5:	jae    2639f8 <<glass::engine::Watch>::print_utf8+0x13d8>
  262fcb:	mov    %ebp,%r9d
  262fce:	mov    0x40(%rsp),%r14
  262fd3:	mov    %r13,%r11
  262fd6:	mov    0x28(%rsp),%rax
  262fdb:	movzbl (%rax,%r13,1),%ebp
  262fe0:	test   %bpl,%bpl
  262fe3:	mov    %rdx,0x20(%rsp)
  262fe8:	js     263010 <<glass::engine::Watch>::print_utf8+0x9f0>
  262fea:	mov    $0x1,%r13d
  262ff0:	mov    0x50(%rsp),%r10
  262ff5:	lea    -0x7f(%rbp),%eax
  262ff8:	cmp    $0x21,%eax
  262ffb:	jae    2631c2 <<glass::engine::Watch>::print_utf8+0xba2>
  263001:	jmp    263400 <<glass::engine::Watch>::print_utf8+0xde0>
  263006:	cs nopw 0x0(%rax,%rax,1)
  263010:	lea    0x3e(%rbp),%eax
  263013:	cmp    $0x1e,%al
  263015:	mov    0x50(%rsp),%r10
  26301a:	jae    26304d <<glass::engine::Watch>::print_utf8+0xa2d>
  26301c:	lea    0x1(%r11),%rax
  263020:	cmp    0x38(%rsp),%rax
  263025:	jae    263400 <<glass::engine::Watch>::print_utf8+0xde0>
  26302b:	mov    0x28(%rsp),%rcx
  263030:	movzbl (%rcx,%rax,1),%eax
  263034:	cmp    $0xc0,%al
  263036:	jge    263400 <<glass::engine::Watch>::print_utf8+0xde0>
  26303c:	and    $0x1f,%ebp
  26303f:	shl    $0x6,%ebp
  263042:	mov    $0x2,%r13d
  263048:	jmp    263195 <<glass::engine::Watch>::print_utf8+0xb75>
  26304d:	mov    %ebp,%eax
  26304f:	and    $0xf0,%al
  263051:	cmp    $0xe0,%al
  263053:	jne    26306d <<glass::engine::Watch>::print_utf8+0xa4d>
  263055:	mov    $0xbf,%al
  263057:	cmp    $0xe0,%ebp
  26305d:	je     263090 <<glass::engine::Watch>::print_utf8+0xa70>
  26305f:	mov    $0x80,%cl
  263061:	cmp    $0xed,%ebp
  263067:	jne    263092 <<glass::engine::Watch>::print_utf8+0xa72>
  263069:	mov    $0x9f,%al
  26306b:	jmp    263092 <<glass::engine::Watch>::print_utf8+0xa72>
  26306d:	lea    0x10(%rbp),%eax
  263070:	cmp    $0x5,%al
  263072:	jae    263400 <<glass::engine::Watch>::print_utf8+0xde0>
  263078:	mov    $0x80,%al
  26307a:	cmp    $0xf4,%ebp
  263080:	je     2630fe <<glass::engine::Watch>::print_utf8+0xade>
  263082:	mov    $0xbf,%cl
  263084:	cmp    $0xf0,%ebp
  26308a:	jne    263100 <<glass::engine::Watch>::print_utf8+0xae0>
  26308c:	mov    $0x90,%al
  26308e:	jmp    263100 <<glass::engine::Watch>::print_utf8+0xae0>
  263090:	mov    $0xa0,%cl
  263092:	lea    0x1(%r11),%rdx
  263096:	cmp    0x38(%rsp),%rdx
  26309b:	jae    26397b <<glass::engine::Watch>::print_utf8+0x135b>
  2630a1:	mov    0x28(%rsp),%rsi
  2630a6:	movzbl (%rsi,%rdx,1),%edx
  2630aa:	movl   $0x0,0x4(%rsp)
  2630b2:	cmp    %dl,%cl
  2630b4:	ja     263983 <<glass::engine::Watch>::print_utf8+0x1363>
  2630ba:	cmp    %al,%dl
  2630bc:	ja     263983 <<glass::engine::Watch>::print_utf8+0x1363>
  2630c2:	lea    0x2(%r11),%rax
  2630c6:	cmp    0x38(%rsp),%rax
  2630cb:	jae    26397b <<glass::engine::Watch>::print_utf8+0x135b>
  2630d1:	mov    0x28(%rsp),%rcx
  2630d6:	movzbl (%rcx,%rax,1),%eax
  2630da:	cmp    $0xc0,%al
  2630dc:	jge    26397b <<glass::engine::Watch>::print_utf8+0x135b>
  2630e2:	movzbl %dl,%ecx
  2630e5:	and    $0x3f,%ecx
  2630e8:	shl    $0x6,%ecx
  2630eb:	and    $0xf,%ebp
  2630ee:	shl    $0xc,%ebp
  2630f1:	or     %ecx,%ebp
  2630f3:	mov    $0x3,%r13d
  2630f9:	jmp    263190 <<glass::engine::Watch>::print_utf8+0xb70>
  2630fe:	mov    $0x8f,%cl
  263100:	lea    0x1(%r11),%rdx
  263104:	cmp    0x38(%rsp),%rdx
  263109:	jae    26397b <<glass::engine::Watch>::print_utf8+0x135b>
  26310f:	mov    0x28(%rsp),%rsi
  263114:	movzbl (%rsi,%rdx,1),%edx
  263118:	movl   $0x0,0x4(%rsp)
  263120:	cmp    %dl,%al
  263122:	ja     263983 <<glass::engine::Watch>::print_utf8+0x1363>
  263128:	cmp    %cl,%dl
  26312a:	ja     263983 <<glass::engine::Watch>::print_utf8+0x1363>
  263130:	lea    0x2(%r11),%rax
  263134:	cmp    0x38(%rsp),%rax
  263139:	jae    26397b <<glass::engine::Watch>::print_utf8+0x135b>
  26313f:	mov    0x28(%rsp),%rcx
  263144:	movzbl (%rcx,%rax,1),%ecx
  263148:	cmp    $0xbf,%cl
  26314b:	jg     26397b <<glass::engine::Watch>::print_utf8+0x135b>
  263151:	lea    0x3(%r11),%rax
  263155:	cmp    0x38(%rsp),%rax
  26315a:	jae    26397b <<glass::engine::Watch>::print_utf8+0x135b>
  263160:	mov    0x28(%rsp),%rsi
  263165:	movzbl (%rsi,%rax,1),%eax
  263169:	cmp    $0xbf,%al
  26316b:	jg     26397b <<glass::engine::Watch>::print_utf8+0x135b>
  263171:	movzbl %dl,%edx
  263174:	and    $0x3f,%ecx
  263177:	shl    $0x6,%ecx
  26317a:	and    $0x3f,%edx
  26317d:	shl    $0xc,%edx
  263180:	and    $0x7,%ebp
  263183:	shl    $0x12,%ebp
  263186:	or     %edx,%ebp
  263188:	or     %ecx,%ebp
  26318a:	mov    $0x4,%r13d
  263190:	mov    0x20(%rsp),%rdx
  263195:	mov    %ebp,%ecx
  263197:	xor    $0xd800,%ecx
  26319d:	add    $0xffef0000,%ecx
  2631a3:	cmp    $0xffef0800,%ecx
  2631a9:	jb     263400 <<glass::engine::Watch>::print_utf8+0xde0>
  2631af:	and    $0x3f,%al
  2631b1:	movzbl %al,%eax
  2631b4:	or     %eax,%ebp
  2631b6:	lea    -0x7f(%rbp),%eax
  2631b9:	cmp    $0x21,%eax
  2631bc:	jb     263400 <<glass::engine::Watch>::print_utf8+0xde0>
  2631c2:	lea    -0x20(%r9),%eax
  2631c6:	cmp    $0x5f,%eax
  2631c9:	jb     263373 <<glass::engine::Watch>::print_utf8+0xd53>
  2631cf:	mov    0x392da3(%rip),%eax        # 5f5f78 <glass::engine::width_of::CACHE+0x10>
  2631d5:	test   %eax,%eax
  2631d7:	jne    26327e <<glass::engine::Watch>::print_utf8+0xc5e>
  2631dd:	mov    %r9d,%edi
  2631e0:	mov    0x392d89(%rip),%rsi        # 5f5f70 <glass::engine::width_of::CACHE+0x8>
  2631e7:	cmp    %rdi,%rsi
  2631ea:	jbe    264b1f <<glass::engine::Watch>::print_utf8+0x24ff>
  2631f0:	mov    0x392d71(%rip),%rbx        # 5f5f68 <glass::engine::width_of::CACHE>
  2631f7:	movzbl (%rbx,%rdi,1),%eax
  2631fb:	test   %al,%al
  2631fd:	jns    263237 <<glass::engine::Watch>::print_utf8+0xc17>
  2631ff:	cmp    $0xfe,%al
  263201:	je     2639cb <<glass::engine::Watch>::print_utf8+0x13ab>
  263207:	add    %rdi,%rbx
  26320a:	cmp    $0xa0,%r9d
  263211:	jb     2639e4 <<glass::engine::Watch>::print_utf8+0x13c4>
  263217:	mov    %r9d,%edi
  26321a:	mov    %r9,%r12
  26321d:	mov    %r11,%r15
  263220:	call   299260 <unicode_width::tables::lookup_width>
  263225:	mov    %r15,%r11
  263228:	mov    0x50(%rsp),%r10
  26322d:	mov    %r12,%r9
  263230:	mov    0x58(%rsp),%r12
  263235:	mov    %al,(%rbx)
  263237:	lea    -0x1(%rax),%ecx
  26323a:	cmp    $0x2,%cl
  26323d:	mov    0x40(%rsp),%r14
  263242:	jb     263390 <<glass::engine::Watch>::print_utf8+0xd70>
  263248:	test   %al,%al
  26324a:	mov    0x20(%rsp),%r15
  26324f:	jne    263425 <<glass::engine::Watch>::print_utf8+0xe05>
  263255:	mov    0x18(%rsp),%rdi
  26325a:	mov    %r9d,%esi
  26325d:	mov    %r11,%r15
  263260:	call   291980 <<alacritty_terminal::term::cell::Cell>::push_zerowidth>
  263265:	add    %r15,%r13
  263268:	mov    %ebp,%r9d
  26326b:	mov    %r15,%rdx
  26326e:	cmp    0x38(%rsp),%r13
  263273:	jb     262fd3 <<glass::engine::Watch>::print_utf8+0x9b3>
  263279:	jmp    263439 <<glass::engine::Watch>::print_utf8+0xe19>
  26327e:	mov    %r9,%rbx
  263281:	mov    %r11,0xd0(%rsp)
  263289:	call   18bbe2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  26328e:	mov    0xd0(%rsp),%r11
  263296:	mov    0x50(%rsp),%r10
  26329b:	mov    %rbx,%r9
  26329e:	mov    %r9d,%edi
  2632a1:	mov    0x392cc8(%rip),%rsi        # 5f5f70 <glass::engine::width_of::CACHE+0x8>
  2632a8:	cmp    %rdi,%rsi
  2632ab:	ja     2631f0 <<glass::engine::Watch>::print_utf8+0xbd0>
  2632b1:	jmp    264b1f <<glass::engine::Watch>::print_utf8+0x24ff>
  2632b6:	mov    %r14,%r8
  2632b9:	mov    %rdi,%rbx
  2632bc:	xor    %r14d,%r14d
  2632bf:	mov    0x30(%rsp),%r15d
  2632c4:	mov    (%r12),%rax
  2632c8:	test   %rax,%rax
  2632cb:	jne    262ee2 <<glass::engine::Watch>::print_utf8+0x8c2>
  2632d1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2632e0:	lea    (%r8,%r8,2),%rax
  2632e4:	movq   $0x0,(%r12)
  2632ec:	mov    0x34(%rsp),%ecx
  2632f0:	mov    %ecx,0x8(%r10,%rax,8)
  2632f5:	mov    0x60(%rsp),%ecx
  2632f9:	mov    %ecx,0xc(%r10,%rax,8)
  2632fe:	mov    %r15w,0x14(%r10,%rax,8)
  263304:	mov    %r9d,0x10(%r10,%rax,8)
  263309:	test   %r14b,%r14b
  26330c:	mov    %rbx,%r15
  26330f:	je     262b48 <<glass::engine::Watch>::print_utf8+0x528>
  263315:	lea    0x1(%r15),%rdi
  263319:	cmp    0x80(%rsp),%rdi
  263321:	jae    264b4e <<glass::engine::Watch>::print_utf8+0x252e>
  263327:	lea    (%rdi,%rdi,2),%rax
  26332b:	mov    0xa0(%rsp),%rcx
  263333:	lea    (%rcx,%rax,8),%r12
  263337:	mov    (%rcx,%rax,8),%rax
  26333b:	test   %rax,%rax
  26333e:	je     262b10 <<glass::engine::Watch>::print_utf8+0x4f0>
  263344:	lock decq (%rax)
  263348:	jne    262b10 <<glass::engine::Watch>::print_utf8+0x4f0>
  26334e:	mov    %r12,%rdi
  263351:	mov    %r11,%rbx
  263354:	mov    %r15,%r14
  263357:	mov    %rsi,%r15
  26335a:	call   *0x38fca8(%rip)        # 5f3008 <_DYNAMIC+0x268>
  263360:	mov    %r15,%rsi
  263363:	mov    %r14,%r15
  263366:	mov    %rbx,%r11
  263369:	mov    0x50(%rsp),%r10
  26336e:	jmp    262b10 <<glass::engine::Watch>::print_utf8+0x4f0>
  263373:	movl   $0x0,0x4(%rsp)
  26337b:	mov    $0x1,%eax
  263380:	cmpb   $0x0,0x48(%rsp)
  263385:	jne    262d8b <<glass::engine::Watch>::print_utf8+0x76b>
  26338b:	jmp    263454 <<glass::engine::Watch>::print_utf8+0xe34>
  263390:	movl   $0x0,0x4(%rsp)
  263398:	mov    0x20(%rsp),%rdx
  26339d:	movzbl %al,%eax
  2633a0:	testb  $0x1,0x10(%rsp)
  2633a5:	je     262e0b <<glass::engine::Watch>::print_utf8+0x7eb>
  2633ab:	jmp    26344d <<glass::engine::Watch>::print_utf8+0xe2d>
  2633b0:	mov    %r9,%rbx
  2633b3:	mov    %r15,0x20(%rsp)
  2633b8:	mov    %rdx,%r15
  2633bb:	mov    %r8,%r14
  2633be:	call   18bbe2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2633c3:	mov    %r14,%r8
  2633c6:	mov    0x50(%rsp),%r10
  2633cb:	mov    %r15,%rdx
  2633ce:	mov    0x20(%rsp),%r15
  2633d3:	mov    0x58(%rsp),%r12
  2633d8:	mov    %rbx,%r9
  2633db:	mov    %r9d,%edi
  2633de:	mov    0x392b8b(%rip),%rsi        # 5f5f70 <glass::engine::width_of::CACHE+0x8>
  2633e5:	cmp    %rdi,%rsi
  2633e8:	ja     262dd1 <<glass::engine::Watch>::print_utf8+0x7b1>
  2633ee:	jmp    264b1f <<glass::engine::Watch>::print_utf8+0x24ff>
  2633f3:	mov    0x8(%rsp),%rsi
  2633f8:	mov    %r9d,%ebp
  2633fb:	mov    %rdx,%r13
  2633fe:	jmp    263464 <<glass::engine::Watch>::print_utf8+0xe44>
  263400:	movl   $0x0,0x4(%rsp)
  263408:	jmp    263454 <<glass::engine::Watch>::print_utf8+0xe34>
  26340a:	mov    0x8(%rsp),%rax
  26340f:	mov    %r9d,%ebp
  263412:	mov    %rsi,%r13
  263415:	mov    %rax,%rsi
  263418:	jmp    263464 <<glass::engine::Watch>::print_utf8+0xe44>
  26341a:	movq   $0x0,0x10(%rsp)
  263423:	jmp    263454 <<glass::engine::Watch>::print_utf8+0xe34>
  263425:	movl   $0x0,0x4(%rsp)
  26342d:	mov    0x8(%rsp),%rsi
  263432:	mov    %r15,0x18(%rsp)
  263437:	jmp    26345e <<glass::engine::Watch>::print_utf8+0xe3e>
  263439:	movl   $0x0,0x4(%rsp)
  263441:	mov    0x8(%rsp),%rsi
  263446:	mov    %r15,0x18(%rsp)
  26344b:	jmp    263464 <<glass::engine::Watch>::print_utf8+0xe44>
  26344d:	mov    $0x1,%al
  26344f:	mov    %rax,0x10(%rsp)
  263454:	mov    0x8(%rsp),%rsi
  263459:	mov    %rdx,0x18(%rsp)
  26345e:	mov    %r9d,%ebp
  263461:	mov    %r11,%r13
  263464:	cmp    %r12,%rsi
  263467:	jbe    26347e <<glass::engine::Watch>::print_utf8+0xe5e>
  263469:	mov    0xc8(%rsp),%rcx
  263471:	mov    (%rcx),%rax
  263474:	cmp    %rax,%rsi
  263477:	cmova  %rsi,%rax
  26347b:	mov    %rax,(%rcx)
  26347e:	cmpq   $0x8,0xb0(%rsp)
  263487:	setae  %al
  26348a:	testb  $0x1,0x4(%rsp)
  26348f:	jne    263493 <<glass::engine::Watch>::print_utf8+0xe73>
  263491:	xor    %eax,%eax
  263493:	test   %al,%al
  263495:	jne    2640e4 <<glass::engine::Watch>::print_utf8+0x1ac4>
  26349b:	mov    %r14,%r12
  26349e:	mov    %ebp,%r9d
  2634a1:	mov    %r13,%rdx
  2634a4:	mov    0x18(%rsp),%r13
  2634a9:	mov    0x90(%rsp),%rbx
  2634b1:	mov    0xb0(%rsp),%rax
  2634b9:	mov    0x10(%rsp),%rcx
  2634be:	mov    %r12,0x40(%rbx)
  2634c2:	mov    %cl,0x6c(%rbx)
  2634c5:	mov    0xa8(%rsp),%r12
  2634cd:	add    %rax,0xa0(%r12)
  2634d5:	mov    %r9d,%esi
  2634d8:	mov    %r13,%rbx
  2634db:	mov    %rdx,%r13
  2634de:	cmp    0x38(%rsp),%rdx
  2634e3:	jae    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  2634e9:	mov    0x28(%rsp),%rax
  2634ee:	movzbl (%rax,%r13,1),%r9d
  2634f3:	test   %r9b,%r9b
  2634f6:	js     263510 <<glass::engine::Watch>::print_utf8+0xef0>
  2634f8:	mov    $0x1,%edx
  2634fd:	lea    -0x7f(%r9),%eax
  263501:	cmp    $0x21,%eax
  263504:	jae    2636b8 <<glass::engine::Watch>::print_utf8+0x1098>
  26350a:	jmp    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  26350f:	nop
  263510:	lea    0x3e(%r9),%eax
  263514:	cmp    $0x1e,%al
  263516:	jae    26354a <<glass::engine::Watch>::print_utf8+0xf2a>
  263518:	lea    0x1(%r13),%rax
  26351c:	cmp    0x38(%rsp),%rax
  263521:	jae    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  263527:	mov    0x28(%rsp),%rcx
  26352c:	movzbl (%rcx,%rax,1),%eax
  263530:	cmp    $0xc0,%al
  263532:	jge    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  263538:	and    $0x1f,%r9d
  26353c:	shl    $0x6,%r9d
  263540:	mov    $0x2,%edx
  263545:	jmp    263688 <<glass::engine::Watch>::print_utf8+0x1068>
  26354a:	mov    %r9d,%eax
  26354d:	and    $0xf0,%al
  26354f:	cmp    $0xe0,%al
  263551:	jne    26356d <<glass::engine::Watch>::print_utf8+0xf4d>
  263553:	mov    $0xbf,%al
  263555:	cmp    $0xe0,%r9d
  26355c:	je     263593 <<glass::engine::Watch>::print_utf8+0xf73>
  26355e:	mov    $0x80,%cl
  263560:	cmp    $0xed,%r9d
  263567:	jne    263595 <<glass::engine::Watch>::print_utf8+0xf75>
  263569:	mov    $0x9f,%al
  26356b:	jmp    263595 <<glass::engine::Watch>::print_utf8+0xf75>
  26356d:	lea    0x10(%r9),%eax
  263571:	cmp    $0x5,%al
  263573:	jae    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  263579:	mov    $0x80,%al
  26357b:	cmp    $0xf4,%r9d
  263582:	je     2635fb <<glass::engine::Watch>::print_utf8+0xfdb>
  263584:	mov    $0xbf,%cl
  263586:	cmp    $0xf0,%r9d
  26358d:	jne    2635fd <<glass::engine::Watch>::print_utf8+0xfdd>
  26358f:	mov    $0x90,%al
  263591:	jmp    2635fd <<glass::engine::Watch>::print_utf8+0xfdd>
  263593:	mov    $0xa0,%cl
  263595:	lea    0x1(%r13),%rdx
  263599:	cmp    0x38(%rsp),%rdx
  26359e:	jae    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  2635a4:	mov    0x28(%rsp),%rdi
  2635a9:	movzbl (%rdi,%rdx,1),%edx
  2635ad:	cmp    %dl,%cl
  2635af:	ja     26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  2635b5:	cmp    %al,%dl
  2635b7:	ja     26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  2635bd:	lea    0x2(%r13),%rax
  2635c1:	cmp    0x38(%rsp),%rax
  2635c6:	jae    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  2635cc:	mov    0x28(%rsp),%rcx
  2635d1:	movzbl (%rcx,%rax,1),%eax
  2635d5:	cmp    $0xc0,%al
  2635d7:	jge    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  2635dd:	movzbl %dl,%ecx
  2635e0:	and    $0x3f,%ecx
  2635e3:	shl    $0x6,%ecx
  2635e6:	and    $0xf,%r9d
  2635ea:	shl    $0xc,%r9d
  2635ee:	or     %ecx,%r9d
  2635f1:	mov    $0x3,%edx
  2635f6:	jmp    263688 <<glass::engine::Watch>::print_utf8+0x1068>
  2635fb:	mov    $0x8f,%cl
  2635fd:	lea    0x1(%r13),%rdx
  263601:	cmp    0x38(%rsp),%rdx
  263606:	jae    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  26360c:	mov    0x28(%rsp),%rdi
  263611:	movzbl (%rdi,%rdx,1),%edx
  263615:	cmp    %dl,%al
  263617:	ja     26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  26361d:	cmp    %cl,%dl
  26361f:	ja     26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  263625:	lea    0x2(%r13),%rax
  263629:	cmp    0x38(%rsp),%rax
  26362e:	jae    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  263634:	mov    0x28(%rsp),%rcx
  263639:	movzbl (%rcx,%rax,1),%ecx
  26363d:	cmp    $0xbf,%cl
  263640:	jg     26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  263646:	lea    0x3(%r13),%rax
  26364a:	cmp    0x38(%rsp),%rax
  26364f:	jae    26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  263655:	mov    0x28(%rsp),%rdi
  26365a:	movzbl (%rdi,%rax,1),%eax
  26365e:	cmp    $0xbf,%al
  263660:	jg     26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  263666:	movzbl %dl,%edx
  263669:	and    $0x3f,%ecx
  26366c:	shl    $0x6,%ecx
  26366f:	and    $0x3f,%edx
  263672:	shl    $0xc,%edx
  263675:	and    $0x7,%r9d
  263679:	shl    $0x12,%r9d
  26367d:	or     %edx,%r9d
  263680:	or     %ecx,%r9d
  263683:	mov    $0x4,%edx
  263688:	mov    %r9d,%ecx
  26368b:	xor    $0xd800,%ecx
  263691:	add    $0xffef0000,%ecx
  263697:	cmp    $0xffef0800,%ecx
  26369d:	jb     26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  2636a3:	and    $0x3f,%al
  2636a5:	movzbl %al,%eax
  2636a8:	or     %eax,%r9d
  2636ab:	lea    -0x7f(%r9),%eax
  2636af:	cmp    $0x21,%eax
  2636b2:	jb     26412d <<glass::engine::Watch>::print_utf8+0x1b0d>
  2636b8:	cmp    $0xffffffff,%esi
  2636bb:	je     2626d9 <<glass::engine::Watch>::print_utf8+0xb9>
  2636c1:	mov    %r13,0x18(%rsp)
  2636c6:	lea    -0x20(%rsi),%eax
  2636c9:	cmp    $0x5f,%eax
  2636cc:	jae    2636f0 <<glass::engine::Watch>::print_utf8+0x10d0>
  2636ce:	mov    $0x1,%ebp
  2636d3:	cmpb   $0x0,0x48(%rsp)
  2636d8:	je     2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  2636de:	jmp    26379a <<glass::engine::Watch>::print_utf8+0x117a>
  2636e3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2636f0:	cmpb   $0x0,0x4c(%rsp)
  2636f5:	je     2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  2636fb:	mov    0x392877(%rip),%eax        # 5f5f78 <glass::engine::width_of::CACHE+0x10>
  263701:	test   %eax,%eax
  263703:	jne    2640b6 <<glass::engine::Watch>::print_utf8+0x1a96>
  263709:	mov    %esi,%ebx
  26370b:	mov    0x39285e(%rip),%rax        # 5f5f70 <glass::engine::width_of::CACHE+0x8>
  263712:	cmp    %rbx,%rax
  263715:	jbe    264ada <<glass::engine::Watch>::print_utf8+0x24ba>
  26371b:	mov    0x392846(%rip),%r14        # 5f5f68 <glass::engine::width_of::CACHE>
  263722:	movzbl (%r14,%rbx,1),%eax
  263727:	movzbl %al,%ebp
  26372a:	test   %bpl,%bpl
  26372d:	js     26373a <<glass::engine::Watch>::print_utf8+0x111a>
  26372f:	mov    $0x1,%cl
  263731:	test   %cl,%cl
  263733:	jne    26378c <<glass::engine::Watch>::print_utf8+0x116c>
  263735:	jmp    2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  26373a:	cmp    $0xfe,%ebp
  263740:	je     2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  263746:	mov    $0xfe,%al
  263748:	cmp    $0x7f,%esi
  26374b:	jae    263756 <<glass::engine::Watch>::print_utf8+0x1136>
  26374d:	mov    $0x1,%ebp
  263752:	xor    %ecx,%ecx
  263754:	jmp    263780 <<glass::engine::Watch>::print_utf8+0x1160>
  263756:	cmp    $0xa0,%esi
  26375c:	jb     26377e <<glass::engine::Watch>::print_utf8+0x115e>
  26375e:	mov    %esi,%edi
  263760:	mov    %rsi,%r15
  263763:	mov    %r9,%r13
  263766:	mov    %rdx,%rbp
  263769:	call   299260 <unicode_width::tables::lookup_width>
  26376e:	mov    %rbp,%rdx
  263771:	mov    %r13,%r9
  263774:	mov    %r15,%rsi
  263777:	movzbl %al,%ebp
  26377a:	mov    $0x1,%cl
  26377c:	jmp    263780 <<glass::engine::Watch>::print_utf8+0x1160>
  26377e:	xor    %ecx,%ecx
  263780:	mov    %al,(%r14,%rbx,1)
  263784:	test   %cl,%cl
  263786:	je     2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  26378c:	lea    -0x1(%rbp),%rax
  263790:	cmp    $0x1,%rax
  263794:	ja     2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  26379a:	mov    0x78(%r12),%r13
  26379f:	cmpb   $0x0,0x6c(%r13)
  2637a4:	jne    2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  2637aa:	mov    0x40(%r13),%r11
  2637ae:	mov    0xa0(%r13),%r10
  2637b5:	lea    (%r11,%rbp,1),%r8
  2637b9:	cmp    %r10,%r8
  2637bc:	ja     2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  2637c2:	mov    %rdx,0x20(%rsp)
  2637c7:	mov    0x30(%r13),%eax
  2637cb:	sub    0x48(%r13),%eax
  2637cf:	movslq %eax,%rcx
  2637d2:	mov    0x20(%r13),%rax
  2637d6:	mov    0x28(%r13),%rdx
  2637da:	lea    (%rdx,%rcx,1),%rdi
  2637de:	dec    %rdi
  2637e1:	cmp    %rax,%rdi
  2637e4:	mov    $0x0,%ecx
  2637e9:	cmovae %rax,%rcx
  2637ed:	sub    %rcx,%rdi
  2637f0:	cmp    %rax,%rdi
  2637f3:	jae    264b96 <<glass::engine::Watch>::print_utf8+0x2576>
  2637f9:	mov    0x58(%r13),%r14d
  2637fd:	mov    0x5c(%r13),%eax
  263801:	mov    %eax,0x34(%rsp)
  263805:	movzwl 0x64(%r13),%ebx
  26380a:	mov    0x18(%r13),%rax
  26380e:	shl    $0x6,%rdi
  263812:	lea    (%rax,%rdi,1),%rcx
  263816:	mov    %rcx,0x10(%rsp)
  26381b:	lea    (%rax,%rdi,1),%rcx
  26381f:	add    $0x18,%rcx
  263823:	mov    %rcx,0x40(%rsp)
  263828:	mov    0x28(%rax,%rdi,1),%ecx
  26382c:	cmp    $0xffffffff,%ecx
  26382f:	mov    0x20(%rsp),%rdx
  263834:	je     263846 <<glass::engine::Watch>::print_utf8+0x1226>
  263836:	mov    0x40(%rsp),%rax
  26383b:	mov    0x10(%rsp),%rdi
  263840:	cmp    0x30(%rdi),%r11
  263844:	jae    263869 <<glass::engine::Watch>::print_utf8+0x1249>
  263846:	mov    0x10(%rsp),%rax
  26384b:	mov    0x10(%rax),%rax
  26384f:	cmp    %rax,%r11
  263852:	jae    264bd1 <<glass::engine::Watch>::print_utf8+0x25b1>
  263858:	lea    (%r11,%r11,2),%rax
  26385c:	shl    $0x3,%rax
  263860:	mov    0x10(%rsp),%rdi
  263865:	add    0x8(%rdi),%rax
  263869:	testb  $0x60,0x14(%rax)
  26386d:	jne    2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  263873:	cmp    $0x2,%rbp
  263877:	jne    2638bf <<glass::engine::Watch>::print_utf8+0x129f>
  263879:	lea    0x1(%r11),%rdi
  26387d:	cmp    $0xffffffff,%ecx
  263880:	je     263892 <<glass::engine::Watch>::print_utf8+0x1272>
  263882:	mov    0x40(%rsp),%rax
  263887:	mov    0x10(%rsp),%r15
  26388c:	cmp    0x30(%r15),%rdi
  263890:	jae    2638b5 <<glass::engine::Watch>::print_utf8+0x1295>
  263892:	mov    0x10(%rsp),%rax
  263897:	mov    0x10(%rax),%rax
  26389b:	cmp    %rax,%rdi
  26389e:	jae    264bfb <<glass::engine::Watch>::print_utf8+0x25db>
  2638a4:	lea    (%rdi,%rdi,2),%rax
  2638a8:	shl    $0x3,%rax
  2638ac:	mov    0x10(%rsp),%rdi
  2638b1:	add    0x8(%rdi),%rax
  2638b5:	testb  $0x60,0x14(%rax)
  2638b9:	jne    2626c0 <<glass::engine::Watch>::print_utf8+0xa0>
  2638bf:	mov    0x10(%rsp),%rax
  2638c4:	cmp    %r11d,0x38(%rax)
  2638c8:	jbe    2638d3 <<glass::engine::Watch>::print_utf8+0x12b3>
  2638ca:	mov    0x10(%rsp),%rax
  2638cf:	mov    %r11d,0x38(%rax)
  2638d3:	mov    %r14d,0x58(%rsp)
  2638d8:	mov    %ebx,0x30(%rsp)
  2638dc:	mov    %r10,0x50(%rsp)
  2638e1:	mov    %r8,0x80(%rsp)
  2638e9:	cmp    $0xffffffff,%ecx
  2638ec:	setne  %dl
  2638ef:	mov    0x10(%rsp),%rax
  2638f4:	mov    0x30(%rax),%rax
  2638f8:	cmp    %rax,%r11
  2638fb:	sete   %dil
  2638ff:	test   %dil,%dl
  263902:	mov    %r11,0x60(%rsp)
  263907:	jne    263997 <<glass::engine::Watch>::print_utf8+0x1377>
  26390d:	cmp    $0xffffffff,%ecx
  263910:	je     263ca4 <<glass::engine::Watch>::print_utf8+0x1684>
  263916:	mov    0x10(%rsp),%rcx
  26391b:	mov    0x10(%rcx),%rcx
  26391f:	cmp    %rax,%rcx
  263922:	mov    %rax,%r10
  263925:	cmovb  %rcx,%r10
  263929:	cmp    %r11,%rcx
  26392c:	mov    %r11,%r14
  26392f:	cmovb  %rcx,%r14
  263933:	mov    0x38f786(%rip),%rdx        # 5f30c0 <_DYNAMIC+0x320>
  26393a:	movzbl (%rdx),%edx
  26393d:	test   %dl,%dl
  26393f:	je     263aa0 <<glass::engine::Watch>::print_utf8+0x1480>
  263945:	mov    0x38f7ac(%rip),%rdx        # 5f30f8 <_DYNAMIC+0x358>
  26394c:	cmp    %r14,%rax
  26394f:	jae    263958 <<glass::engine::Watch>::print_utf8+0x1338>
  263951:	mov    0x38f7a8(%rip),%rdx        # 5f3100 <_DYNAMIC+0x360>
  263958:	lock incq 0x28(%rdx)
  26395d:	mov    0x38f774(%rip),%rdx        # 5f30d8 <_DYNAMIC+0x338>
  263964:	lock incq (%rdx)
  263968:	mov    %r14,%rdx
  26396b:	sub    %r10,%rdx
  26396e:	jne    263a55 <<glass::engine::Watch>::print_utf8+0x1435>
  263974:	xor    %edi,%edi
  263976:	jmp    263a94 <<glass::engine::Watch>::print_utf8+0x1474>
  26397b:	movl   $0x0,0x4(%rsp)
  263983:	mov    0x8(%rsp),%rsi
  263988:	mov    0x20(%rsp),%rax
  26398d:	mov    %rax,0x18(%rsp)
  263992:	jmp    26345e <<glass::engine::Watch>::print_utf8+0xe3e>
  263997:	lea    0x1(%r11),%rax
  26399b:	mov    0x10(%rsp),%rcx
  2639a0:	mov    %rax,0x30(%rcx)
  2639a4:	mov    0x10(%rcx),%rax
  2639a8:	cmp    %rax,%r11
  2639ab:	jb     263cc9 <<glass::engine::Watch>::print_utf8+0x16a9>
  2639b1:	jmp    264c0b <<glass::engine::Watch>::print_utf8+0x25eb>
  2639b6:	mov    0x8(%rsp),%rsi
  2639bb:	mov    %r9d,%ebp
  2639be:	mov    %rdx,%r13
  2639c1:	mov    0x40(%rsp),%r14
  2639c6:	jmp    263464 <<glass::engine::Watch>::print_utf8+0xe44>
  2639cb:	movl   $0x0,0x4(%rsp)
  2639d3:	mov    0x8(%rsp),%rsi
  2639d8:	mov    0x20(%rsp),%rax
  2639dd:	mov    %rax,0x18(%rsp)
  2639e2:	jmp    263a1f <<glass::engine::Watch>::print_utf8+0x13ff>
  2639e4:	movl   $0x0,0x4(%rsp)
  2639ec:	mov    0x20(%rsp),%rax
  2639f1:	mov    %rax,0x18(%rsp)
  2639f6:	jmp    263a17 <<glass::engine::Watch>::print_utf8+0x13f7>
  2639f8:	movl   $0x0,0x4(%rsp)
  263a00:	mov    0x8(%rsp),%rsi
  263a05:	mov    %rdx,0x18(%rsp)
  263a0a:	mov    0x40(%rsp),%r14
  263a0f:	jmp    263464 <<glass::engine::Watch>::print_utf8+0xe44>
  263a14:	mov    %rdx,%r11
  263a17:	movb   $0xfe,(%rbx)
  263a1a:	mov    0x8(%rsp),%rsi
  263a1f:	mov    %r9d,%ebp
  263a22:	mov    %r11,%r13
  263a25:	mov    0x40(%rsp),%r14
  263a2a:	jmp    263464 <<glass::engine::Watch>::print_utf8+0xe44>
  263a2f:	movq   $0x0,0x10(%rsp)
  263a38:	mov    0x8(%rsp),%rsi
  263a3d:	mov    %rdx,0x18(%rsp)
  263a42:	mov    %r9d,%ebp
  263a45:	mov    %r11,%r13
  263a48:	mov    0x58(%rsp),%r12
  263a4d:	mov    %r8,%r14
  263a50:	jmp    263464 <<glass::engine::Watch>::print_utf8+0xe44>
  263a55:	mov    0x38f684(%rip),%rdi        # 5f30e0 <_DYNAMIC+0x340>
  263a5c:	lock add %rdx,(%rdi)
  263a60:	cmp    $0x5,%rdx
  263a64:	jae    263a74 <<glass::engine::Watch>::print_utf8+0x1454>
  263a66:	lea    -0x205e5d(%rip),%rdi        # 5dc10 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263a6d:	movzbl -0x1(%rdx,%rdi,1),%edi
  263a72:	jmp    263a94 <<glass::engine::Watch>::print_utf8+0x1474>
  263a74:	lea    -0x5(%rdx),%r8
  263a78:	mov    $0x4,%edi
  263a7d:	cmp    $0x4,%r8
  263a81:	jb     263a94 <<glass::engine::Watch>::print_utf8+0x1474>
  263a83:	add    $0xfffffffffffffff7,%rdx
  263a87:	cmp    $0x8,%rdx
  263a8b:	mov    $0x6,%edi
  263a90:	sbb    $0x0,%rdi
  263a94:	mov    0x38f635(%rip),%rdx        # 5f30d0 <_DYNAMIC+0x330>
  263a9b:	lock incq (%rdx,%rdi,8)
  263aa0:	cmp    %r14,%rax
  263aa3:	jae    263c59 <<glass::engine::Watch>::print_utf8+0x1639>
  263aa9:	mov    0x10(%rsp),%rax
  263aae:	mov    0x28(%rax),%r8d
  263ab2:	mov    0x20(%rax),%ebx
  263ab5:	mov    0x24(%rax),%r15d
  263ab9:	movzwl 0x2c(%rax),%ecx
  263abd:	mov    0x18(%rax),%rdi
  263ac1:	test   %rdi,%rdi
  263ac4:	mov    %rdi,0x8(%rsp)
  263ac9:	mov    %cx,0x88(%rsp)
  263ad1:	je     263b08 <<glass::engine::Watch>::print_utf8+0x14e8>
  263ad3:	lock incq (%rdi)
  263ad7:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  263add:	mov    0x10(%rsp),%rax
  263ae2:	mov    0x10(%rax),%rdx
  263ae6:	mov    %r8d,0x78(%rsp)
  263aeb:	mov    %ebx,0x70(%rsp)
  263aef:	mov    %r15d,0x74(%rsp)
  263af4:	mov    %cx,0x7c(%rsp)
  263af9:	mov    %rdi,0x68(%rsp)
  263afe:	cmp    %rdx,%r14
  263b01:	jbe    263b20 <<glass::engine::Watch>::print_utf8+0x1500>
  263b03:	jmp    264aed <<glass::engine::Watch>::print_utf8+0x24cd>
  263b08:	mov    %r8d,0x78(%rsp)
  263b0d:	mov    %ebx,0x70(%rsp)
  263b11:	mov    %r15d,0x74(%rsp)
  263b16:	mov    %cx,0x7c(%rsp)
  263b1b:	mov    %rdi,0x68(%rsp)
  263b20:	mov    %r10,0xa0(%rsp)
  263b28:	lea    0x0(,%r10,8),%rax
  263b30:	lea    (%rax,%rax,2),%rax
  263b34:	mov    0x10(%rsp),%rcx
  263b39:	mov    0x8(%rcx),%r12
  263b3d:	add    %rax,%r12
  263b40:	mov    %r14,0x90(%rsp)
  263b48:	lea    0x0(,%r14,8),%rcx
  263b50:	lea    (%rcx,%rcx,2),%r14
  263b54:	sub    %rax,%r14
  263b57:	movzwl 0x88(%rsp),%ecx
  263b5f:	mov    %r13,0xb0(%rsp)
  263b67:	mov    %ebx,0x4(%rsp)
  263b6b:	mov    %r15d,0x98(%rsp)
  263b73:	jmp    263ba3 <<glass::engine::Watch>::print_utf8+0x1583>
  263b75:	data16 cs nopw 0x0(%rax,%rax,1)
  263b80:	mov    %rdi,(%r12)
  263b84:	mov    %ebx,0x8(%r12)
  263b89:	mov    %r15d,0xc(%r12)
  263b8e:	mov    %r8d,0x10(%r12)
  263b93:	mov    %cx,0x14(%r12)
  263b99:	add    $0x18,%r12
  263b9d:	add    $0xffffffffffffffe8,%r14
  263ba1:	je     263c07 <<glass::engine::Watch>::print_utf8+0x15e7>
  263ba3:	test   %rdi,%rdi
  263ba6:	je     263bb2 <<glass::engine::Watch>::print_utf8+0x1592>
  263ba8:	lock incq (%rdi)
  263bac:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  263bb2:	mov    (%r12),%rax
  263bb6:	test   %rax,%rax
  263bb9:	je     263b80 <<glass::engine::Watch>::print_utf8+0x1560>
  263bbb:	lock decq (%rax)
  263bbf:	jne    263b80 <<glass::engine::Watch>::print_utf8+0x1560>
  263bc1:	mov    %r12,%rdi
  263bc4:	mov    %rsi,%r15
  263bc7:	mov    %r9,%rbx
  263bca:	mov    %r8d,%r13d
  263bcd:	call   *0x38f435(%rip)        # 5f3008 <_DYNAMIC+0x268>
  263bd3:	movzwl 0x88(%rsp),%ecx
  263bdb:	mov    %r13d,%r8d
  263bde:	mov    0xb0(%rsp),%r13
  263be6:	mov    %rbx,%r9
  263be9:	mov    0x4(%rsp),%ebx
  263bed:	mov    0x8(%rsp),%rdi
  263bf2:	mov    0x60(%rsp),%r11
  263bf7:	mov    %r15,%rsi
  263bfa:	mov    0x98(%rsp),%r15d
  263c02:	jmp    263b80 <<glass::engine::Watch>::print_utf8+0x1560>
  263c07:	mov    0xa0(%rsp),%rax
  263c0f:	mov    0x10(%rsp),%rcx
  263c14:	cmp    %eax,0x38(%rcx)
  263c17:	jbe    263c21 <<glass::engine::Watch>::print_utf8+0x1601>
  263c19:	mov    0x10(%rsp),%rcx
  263c1e:	mov    %eax,0x38(%rcx)
  263c21:	test   %rdi,%rdi
  263c24:	mov    0x90(%rsp),%r14
  263c2c:	je     263c50 <<glass::engine::Watch>::print_utf8+0x1630>
  263c2e:	lock decq (%rdi)
  263c32:	jne    263c50 <<glass::engine::Watch>::print_utf8+0x1630>
  263c34:	lea    0x68(%rsp),%rdi
  263c39:	mov    %rsi,%rbx
  263c3c:	mov    %r9,%r12
  263c3f:	call   *0x38f3c3(%rip)        # 5f3008 <_DYNAMIC+0x268>
  263c45:	mov    %r12,%r9
  263c48:	mov    %rbx,%rsi
  263c4b:	mov    0x60(%rsp),%r11
  263c50:	mov    0x10(%rsp),%rax
  263c55:	mov    0x10(%rax),%rcx
  263c59:	cmp    %rcx,%r14
  263c5c:	jb     263ca4 <<glass::engine::Watch>::print_utf8+0x1684>
  263c5e:	mov    0x10(%rsp),%rax
  263c63:	cmpl   $0xffffffff,0x28(%rax)
  263c67:	je     263c98 <<glass::engine::Watch>::print_utf8+0x1678>
  263c69:	mov    0x40(%rsp),%rax
  263c6e:	mov    (%rax),%rax
  263c71:	test   %rax,%rax
  263c74:	je     263c98 <<glass::engine::Watch>::print_utf8+0x1678>
  263c76:	lock decq (%rax)
  263c7a:	jne    263c98 <<glass::engine::Watch>::print_utf8+0x1678>
  263c7c:	mov    0x40(%rsp),%rdi
  263c81:	mov    %rsi,%rbx
  263c84:	mov    %r9,%r12
  263c87:	call   *0x38f37b(%rip)        # 5f3008 <_DYNAMIC+0x268>
  263c8d:	mov    %r12,%r9
  263c90:	mov    %rbx,%rsi
  263c93:	mov    0x60(%rsp),%r11
  263c98:	mov    0x10(%rsp),%rax
  263c9d:	movl   $0xffffffff,0x28(%rax)
  263ca4:	mov    0x10(%rsp),%rdx
  263ca9:	mov    0x30(%rdx),%rcx
  263cad:	lea    0x1(%r11),%rax
  263cb1:	cmp    %rcx,%rax
  263cb4:	cmova  %rax,%rcx
  263cb8:	mov    0x10(%rdx),%rax
  263cbc:	mov    %rcx,0x30(%rdx)
  263cc0:	cmp    %rax,%r11
  263cc3:	jae    264c1e <<glass::engine::Watch>::print_utf8+0x25fe>
  263cc9:	mov    0x30(%rsp),%edi
  263ccd:	mov    %edi,%eax
  263ccf:	or     $0x20,%eax
  263cd2:	cmp    $0x2,%rbp
  263cd6:	mov    0x10(%rsp),%rcx
  263cdb:	mov    0x8(%rcx),%rcx
  263cdf:	lea    (%r11,%r11,2),%rdx
  263ce3:	lea    (%rcx,%rdx,8),%r12
  263ce7:	mov    %esi,0x10(%rcx,%rdx,8)
  263ceb:	mov    0x58(%rsp),%esi
  263cef:	mov    %esi,0x8(%rcx,%rdx,8)
  263cf3:	cmovne %edi,%eax
  263cf6:	mov    0x34(%rsp),%esi
  263cfa:	mov    %esi,0xc(%rcx,%rdx,8)
  263cfe:	mov    %ax,0x14(%rcx,%rdx,8)
  263d03:	mov    (%rcx,%rdx,8),%rax
  263d07:	test   %rax,%rax
  263d0a:	je     263d26 <<glass::engine::Watch>::print_utf8+0x1706>
  263d0c:	lock decq (%rax)
  263d10:	jne    263d26 <<glass::engine::Watch>::print_utf8+0x1706>
  263d12:	mov    %r12,%rdi
  263d15:	mov    %r9,%rbx
  263d18:	call   *0x38f2ea(%rip)        # 5f3008 <_DYNAMIC+0x268>
  263d1e:	mov    %rbx,%r9
  263d21:	mov    0x60(%rsp),%r11
  263d26:	movq   $0x0,(%r12)
  263d2e:	cmp    $0x2,%rbp
  263d32:	mov    0xa8(%rsp),%r12
  263d3a:	mov    0x20(%rsp),%rdx
  263d3f:	jne    26408e <<glass::engine::Watch>::print_utf8+0x1a6e>
  263d45:	lea    0x1(%r11),%r14
  263d49:	mov    0x10(%rsp),%rcx
  263d4e:	mov    0x30(%rcx),%rax
  263d52:	mov    0x28(%rcx),%ecx
  263d55:	cmp    %rax,%r14
  263d58:	jne    263d7e <<glass::engine::Watch>::print_utf8+0x175e>
  263d5a:	cmp    $0xffffffff,%ecx
  263d5d:	je     263d7e <<glass::engine::Watch>::print_utf8+0x175e>
  263d5f:	add    $0x2,%r11
  263d63:	mov    0x10(%rsp),%rax
  263d68:	mov    %r11,0x30(%rax)
  263d6c:	mov    0x10(%rax),%rsi
  263d70:	cmp    %rsi,%r14
  263d73:	jb     26402f <<glass::engine::Watch>::print_utf8+0x1a0f>
  263d79:	jmp    264c31 <<glass::engine::Watch>::print_utf8+0x2611>
  263d7e:	cmp    $0xffffffff,%ecx
  263d81:	je     26400a <<glass::engine::Watch>::print_utf8+0x19ea>
  263d87:	mov    0x10(%rsp),%rcx
  263d8c:	mov    0x10(%rcx),%rcx
  263d90:	cmp    %rax,%rcx
  263d93:	mov    %rax,%r10
  263d96:	cmovb  %rcx,%r10
  263d9a:	cmp    %r14,%rcx
  263d9d:	mov    %r14,%r8
  263da0:	cmovb  %rcx,%r8
  263da4:	mov    0x38f315(%rip),%rdx        # 5f30c0 <_DYNAMIC+0x320>
  263dab:	movzbl (%rdx),%edx
  263dae:	test   %dl,%dl
  263db0:	je     263e2c <<glass::engine::Watch>::print_utf8+0x180c>
  263db2:	mov    0x38f33f(%rip),%rdx        # 5f30f8 <_DYNAMIC+0x358>
  263db9:	cmp    %r8,%rax
  263dbc:	jae    263dc5 <<glass::engine::Watch>::print_utf8+0x17a5>
  263dbe:	mov    0x38f33b(%rip),%rdx        # 5f3100 <_DYNAMIC+0x360>
  263dc5:	lock incq 0x28(%rdx)
  263dca:	mov    0x38f307(%rip),%rdx        # 5f30d8 <_DYNAMIC+0x338>
  263dd1:	lock incq (%rdx)
  263dd5:	mov    %r8,%rdx
  263dd8:	sub    %r10,%rdx
  263ddb:	jne    263de1 <<glass::engine::Watch>::print_utf8+0x17c1>
  263ddd:	xor    %esi,%esi
  263ddf:	jmp    263e20 <<glass::engine::Watch>::print_utf8+0x1800>
  263de1:	mov    0x38f2f8(%rip),%rsi        # 5f30e0 <_DYNAMIC+0x340>
  263de8:	lock add %rdx,(%rsi)
  263dec:	cmp    $0x5,%rdx
  263df0:	jae    263e00 <<glass::engine::Watch>::print_utf8+0x17e0>
  263df2:	lea    -0x2061e9(%rip),%rsi        # 5dc10 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263df9:	movzbl -0x1(%rdx,%rsi,1),%esi
  263dfe:	jmp    263e20 <<glass::engine::Watch>::print_utf8+0x1800>
  263e00:	lea    -0x5(%rdx),%rdi
  263e04:	mov    $0x4,%esi
  263e09:	cmp    $0x4,%rdi
  263e0d:	jb     263e20 <<glass::engine::Watch>::print_utf8+0x1800>
  263e0f:	add    $0xfffffffffffffff7,%rdx
  263e13:	cmp    $0x8,%rdx
  263e17:	mov    $0x6,%esi
  263e1c:	sbb    $0x0,%rsi
  263e20:	mov    0x38f2a9(%rip),%rdx        # 5f30d0 <_DYNAMIC+0x330>
  263e27:	lock incq (%rdx,%rsi,8)
  263e2c:	cmp    %r8,%rax
  263e2f:	mov    0x20(%rsp),%rdx
  263e34:	jae    263fdf <<glass::engine::Watch>::print_utf8+0x19bf>
  263e3a:	mov    %r10,0x90(%rsp)
  263e42:	mov    %r8,0x98(%rsp)
  263e4a:	mov    0x10(%rsp),%rax
  263e4f:	mov    0x28(%rax),%edi
  263e52:	mov    0x20(%rax),%r8d
  263e56:	mov    0x24(%rax),%r15d
  263e5a:	movzwl 0x2c(%rax),%ebx
  263e5e:	mov    0x18(%rax),%r10
  263e62:	test   %r10,%r10
  263e65:	mov    %r10,0x88(%rsp)
  263e6d:	mov    %r14,0xa0(%rsp)
  263e75:	je     263eb4 <<glass::engine::Watch>::print_utf8+0x1894>
  263e77:	lock incq (%r10)
  263e7b:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  263e81:	mov    0x10(%rsp),%rax
  263e86:	mov    0x10(%rax),%rdx
  263e8a:	mov    %edi,0x78(%rsp)
  263e8e:	mov    %r8d,0x70(%rsp)
  263e93:	mov    %r15d,0x74(%rsp)
  263e98:	mov    %bx,0x7c(%rsp)
  263e9d:	mov    %r10,0x68(%rsp)
  263ea2:	mov    0x98(%rsp),%rsi
  263eaa:	cmp    %rdx,%rsi
  263ead:	jbe    263ed4 <<glass::engine::Watch>::print_utf8+0x18b4>
  263eaf:	jmp    264b05 <<glass::engine::Watch>::print_utf8+0x24e5>
  263eb4:	mov    %edi,0x78(%rsp)
  263eb8:	mov    %r8d,0x70(%rsp)
  263ebd:	mov    %r15d,0x74(%rsp)
  263ec2:	mov    %bx,0x7c(%rsp)
  263ec7:	mov    %r10,0x68(%rsp)
  263ecc:	mov    0x98(%rsp),%rsi
  263ed4:	mov    0x90(%rsp),%rax
  263edc:	lea    0x0(,%rax,8),%rax
  263ee4:	lea    (%rax,%rax,2),%rax
  263ee8:	mov    0x10(%rsp),%rcx
  263eed:	mov    0x8(%rcx),%r12
  263ef1:	add    %rax,%r12
  263ef4:	lea    0x0(,%rsi,8),%rcx
  263efc:	lea    (%rcx,%rcx,2),%r14
  263f00:	sub    %rax,%r14
  263f03:	mov    %edi,0x8(%rsp)
  263f07:	mov    %bx,0x4(%rsp)
  263f0c:	jmp    263f33 <<glass::engine::Watch>::print_utf8+0x1913>
  263f0e:	xchg   %ax,%ax
  263f10:	mov    %r10,(%r12)
  263f14:	mov    %r8d,0x8(%r12)
  263f19:	mov    %r15d,0xc(%r12)
  263f1e:	mov    %edi,0x10(%r12)
  263f23:	mov    %bx,0x14(%r12)
  263f29:	add    $0x18,%r12
  263f2d:	add    $0xffffffffffffffe8,%r14
  263f31:	je     263f79 <<glass::engine::Watch>::print_utf8+0x1959>
  263f33:	test   %r10,%r10
  263f36:	je     263f42 <<glass::engine::Watch>::print_utf8+0x1922>
  263f38:	lock incq (%r10)
  263f3c:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  263f42:	mov    (%r12),%rax
  263f46:	test   %rax,%rax
  263f49:	je     263f10 <<glass::engine::Watch>::print_utf8+0x18f0>
  263f4b:	lock decq (%rax)
  263f4f:	jne    263f10 <<glass::engine::Watch>::print_utf8+0x18f0>
  263f51:	mov    %r12,%rdi
  263f54:	mov    %r9,%rbp
  263f57:	mov    %r8d,%ebx
  263f5a:	call   *0x38f0a8(%rip)        # 5f3008 <_DYNAMIC+0x268>
  263f60:	mov    %ebx,%r8d
  263f63:	movzwl 0x4(%rsp),%ebx
  263f68:	mov    0x88(%rsp),%r10
  263f70:	mov    0x8(%rsp),%edi
  263f74:	mov    %rbp,%r9
  263f77:	jmp    263f10 <<glass::engine::Watch>::print_utf8+0x18f0>
  263f79:	mov    0x90(%rsp),%rax
  263f81:	mov    0x10(%rsp),%rcx
  263f86:	cmp    %eax,0x38(%rcx)
  263f89:	mov    0xa8(%rsp),%r12
  263f91:	mov    0x20(%rsp),%rdx
  263f96:	mov    0xa0(%rsp),%r14
  263f9e:	jbe    263fa8 <<glass::engine::Watch>::print_utf8+0x1988>
  263fa0:	mov    0x10(%rsp),%rcx
  263fa5:	mov    %eax,0x38(%rcx)
  263fa8:	test   %r10,%r10
  263fab:	je     263fc9 <<glass::engine::Watch>::print_utf8+0x19a9>
  263fad:	lock decq (%r10)
  263fb1:	jne    263fc9 <<glass::engine::Watch>::print_utf8+0x19a9>
  263fb3:	lea    0x68(%rsp),%rdi
  263fb8:	mov    %r9,%rbx
  263fbb:	call   *0x38f047(%rip)        # 5f3008 <_DYNAMIC+0x268>
  263fc1:	mov    0x20(%rsp),%rdx
  263fc6:	mov    %rbx,%r9
  263fc9:	mov    0x10(%rsp),%rax
  263fce:	mov    0x10(%rax),%rcx
  263fd2:	mov    0x60(%rsp),%r11
  263fd7:	mov    0x98(%rsp),%r8
  263fdf:	cmp    %rcx,%r8
  263fe2:	jb     26400a <<glass::engine::Watch>::print_utf8+0x19ea>
  263fe4:	mov    0x40(%rsp),%rdi
  263fe9:	mov    %r9,%rbx
  263fec:	call   1ad6e0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263ff1:	mov    0x20(%rsp),%rdx
  263ff6:	mov    %rbx,%r9
  263ff9:	mov    0x60(%rsp),%r11
  263ffe:	mov    0x10(%rsp),%rax
  264003:	movl   $0xffffffff,0x28(%rax)
  26400a:	mov    0x10(%rsp),%rcx
  26400f:	mov    0x30(%rcx),%rax
  264013:	add    $0x2,%r11
  264017:	cmp    %rax,%r11
  26401a:	cmovbe %rax,%r11
  26401e:	mov    0x10(%rcx),%rsi
  264022:	mov    %r11,0x30(%rcx)
  264026:	cmp    %rsi,%r14
  264029:	jae    264c41 <<glass::engine::Watch>::print_utf8+0x2621>
  26402f:	mov    0x10(%rsp),%rax
  264034:	mov    0x8(%rax),%rax
  264038:	lea    (%r14,%r14,2),%rcx
  26403c:	lea    (%rax,%rcx,8),%rbx
  264040:	movl   $0x20,0x10(%rax,%rcx,8)
  264048:	mov    0x58(%rsp),%esi
  26404c:	mov    %esi,0x8(%rax,%rcx,8)
  264050:	mov    0x34(%rsp),%esi
  264054:	mov    %esi,0xc(%rax,%rcx,8)
  264058:	mov    0x30(%rsp),%esi
  26405c:	or     $0x40,%esi
  26405f:	mov    %si,0x14(%rax,%rcx,8)
  264064:	mov    (%rax,%rcx,8),%rax
  264068:	test   %rax,%rax
  26406b:	je     264087 <<glass::engine::Watch>::print_utf8+0x1a67>
  26406d:	lock decq (%rax)
  264071:	jne    264087 <<glass::engine::Watch>::print_utf8+0x1a67>
  264073:	mov    %rbx,%rdi
  264076:	mov    %r9,%rbp
  264079:	call   *0x38ef89(%rip)        # 5f3008 <_DYNAMIC+0x268>
  26407f:	mov    0x20(%rsp),%rdx
  264084:	mov    %rbp,%r9
  264087:	movq   $0x0,(%rbx)
  26408e:	mov    0x80(%rsp),%rax
  264096:	cmp    0x50(%rsp),%rax
  26409b:	jb     2640a5 <<glass::engine::Watch>::print_utf8+0x1a85>
  26409d:	dec    %rax
  2640a0:	movb   $0x1,0x6c(%r13)
  2640a5:	mov    %rax,0x40(%r13)
  2640a9:	incq   0xa0(%r12)
  2640b1:	jmp    2626d4 <<glass::engine::Watch>::print_utf8+0xb4>
  2640b6:	mov    %rsi,%rbx
  2640b9:	mov    %r9,%r14
  2640bc:	mov    %rdx,%r15
  2640bf:	call   18bbe2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2640c4:	mov    %r15,%rdx
  2640c7:	mov    %r14,%r9
  2640ca:	mov    %rbx,%rsi
  2640cd:	mov    %esi,%ebx
  2640cf:	mov    0x391e9a(%rip),%rax        # 5f5f70 <glass::engine::width_of::CACHE+0x8>
  2640d6:	cmp    %rbx,%rax
  2640d9:	ja     26371b <<glass::engine::Watch>::print_utf8+0x10fb>
  2640df:	jmp    264ada <<glass::engine::Watch>::print_utf8+0x24ba>
  2640e4:	mov    0x10(%rsp),%rbx
  2640e9:	movzbl %bl,%edx
  2640ec:	add    %r14,%rdx
  2640ef:	mov    0xd8(%rsp),%rdi
  2640f7:	mov    %r12,%rsi
  2640fa:	lea    0xe8(%rsp),%rcx
  264102:	call   2a20c0 <glass::engine::note_uniform_span>
  264107:	mov    %r14,%r12
  26410a:	mov    %ebp,%r9d
  26410d:	mov    %rbx,%rcx
  264110:	mov    %r13,%rdx
  264113:	mov    0x18(%rsp),%r13
  264118:	mov    0x90(%rsp),%rbx
  264120:	mov    0xb0(%rsp),%rax
  264128:	jmp    2634be <<glass::engine::Watch>::print_utf8+0xe9e>
  26412d:	cmpq   $0x400,0xa0(%r12)
  264139:	jb     264173 <<glass::engine::Watch>::print_utf8+0x1b53>
  26413b:	mov    %r12,%rdi
  26413e:	mov    %rsi,%r14
  264141:	call   264fe0 <<glass::engine::Watch>::fold_sentinel>
  264146:	mov    %r14,%rsi
  264149:	movq   $0x0,0xa0(%r12)
  264155:	mov    0x391e25(%rip),%eax        # 5f5f80 <glass::engine::run_whole::ON>
  26415b:	test   %eax,%eax
  26415d:	je     26417d <<glass::engine::Watch>::print_utf8+0x1b5d>
  26415f:	mov    %rsi,%r14
  264162:	call   18bc86 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  264167:	mov    %r14,%rsi
  26416a:	cmp    0x38(%rsp),%r13
  26416f:	je     264184 <<glass::engine::Watch>::print_utf8+0x1b64>
  264171:	jmp    2641b3 <<glass::engine::Watch>::print_utf8+0x1b93>
  264173:	mov    0x391e07(%rip),%eax        # 5f5f80 <glass::engine::run_whole::ON>
  264179:	test   %eax,%eax
  26417b:	jne    26415f <<glass::engine::Watch>::print_utf8+0x1b3f>
  26417d:	cmp    0x38(%rsp),%r13
  264182:	jne    2641b3 <<glass::engine::Watch>::print_utf8+0x1b93>
  264184:	cmpb   $0x0,0x391df9(%rip)        # 5f5f84 <glass::engine::run_whole::ON+0x4>
  26418b:	je     2641b3 <<glass::engine::Watch>::print_utf8+0x1b93>
  26418d:	cmp    $0xffffffff,%esi
  264190:	je     264355 <<glass::engine::Watch>::print_utf8+0x1d35>
  264196:	lea    -0x20(%rsi),%eax
  264199:	cmp    $0x5f,%eax
  26419c:	jae    2641c6 <<glass::engine::Watch>::print_utf8+0x1ba6>
  26419e:	mov    $0x1,%ebp
  2641a3:	cmpb   $0x0,0x48(%rsp)
  2641a8:	jne    26428d <<glass::engine::Watch>::print_utf8+0x1c6d>
  2641ae:	jmp    264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  2641b3:	xor    %eax,%eax
  2641b5:	cmp    $0xffffffff,%esi
  2641b8:	cmove  %rax,%rbx
  2641bc:	mov    %rbx,0x38(%rsp)
  2641c1:	jmp    264355 <<glass::engine::Watch>::print_utf8+0x1d35>
  2641c6:	cmpb   $0x0,0x4c(%rsp)
  2641cb:	je     264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  2641d1:	mov    0x391da1(%rip),%eax        # 5f5f78 <glass::engine::width_of::CACHE+0x10>
  2641d7:	test   %eax,%eax
  2641d9:	jne    264abd <<glass::engine::Watch>::print_utf8+0x249d>
  2641df:	mov    %esi,%ebx
  2641e1:	mov    0x391d88(%rip),%rax        # 5f5f70 <glass::engine::width_of::CACHE+0x8>
  2641e8:	cmp    %rbx,%rax
  2641eb:	jbe    264ada <<glass::engine::Watch>::print_utf8+0x24ba>
  2641f1:	mov    0x391d70(%rip),%r14        # 5f5f68 <glass::engine::width_of::CACHE>
  2641f8:	movzbl (%r14,%rbx,1),%eax
  2641fd:	movzbl %al,%ebp
  264200:	test   %bpl,%bpl
  264203:	js     264210 <<glass::engine::Watch>::print_utf8+0x1bf0>
  264205:	mov    $0x1,%cl
  264207:	test   %cl,%cl
  264209:	jne    26427f <<glass::engine::Watch>::print_utf8+0x1c5f>
  26420b:	jmp    264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  264210:	cmp    $0xfe,%ebp
  264216:	je     264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  26421c:	mov    $0xfe,%al
  26421e:	cmp    $0x7f,%esi
  264221:	jae    264255 <<glass::engine::Watch>::print_utf8+0x1c35>
  264223:	mov    $0x1,%ebp
  264228:	xor    %ecx,%ecx
  26422a:	jmp    264273 <<glass::engine::Watch>::print_utf8+0x1c53>
  26422c:	mov    $0x1,%cl
  26422e:	mov    %ecx,0x4c(%rsp)
  264232:	cmpb   $0x0,0x68(%rax)
  264236:	jne    264248 <<glass::engine::Watch>::print_utf8+0x1c28>
  264238:	cmpb   $0x0,0x69(%rax)
  26423c:	jne    264248 <<glass::engine::Watch>::print_utf8+0x1c28>
  26423e:	cmpb   $0x0,0x6a(%rax)
  264242:	je     264467 <<glass::engine::Watch>::print_utf8+0x1e47>
  264248:	movl   $0x0,0x48(%rsp)
  264250:	jmp    262684 <<glass::engine::Watch>::print_utf8+0x64>
  264255:	cmp    $0xa0,%esi
  26425b:	jb     264271 <<glass::engine::Watch>::print_utf8+0x1c51>
  26425d:	mov    %esi,%edi
  26425f:	mov    %rsi,%r15
  264262:	call   299260 <unicode_width::tables::lookup_width>
  264267:	mov    %r15,%rsi
  26426a:	movzbl %al,%ebp
  26426d:	mov    $0x1,%cl
  26426f:	jmp    264273 <<glass::engine::Watch>::print_utf8+0x1c53>
  264271:	xor    %ecx,%ecx
  264273:	mov    %al,(%r14,%rbx,1)
  264277:	test   %cl,%cl
  264279:	je     264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  26427f:	lea    -0x1(%rbp),%rax
  264283:	cmp    $0x1,%rax
  264287:	ja     264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  26428d:	mov    0xa8(%rsp),%rax
  264295:	mov    0x78(%rax),%r12
  264299:	cmpb   $0x0,0x6c(%r12)
  26429f:	jne    264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  2642a5:	mov    0x40(%r12),%r14
  2642aa:	mov    0xa0(%r12),%r8
  2642b2:	lea    (%r14,%rbp,1),%r13
  2642b6:	cmp    %r8,%r13
  2642b9:	ja     264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  2642bf:	mov    0x30(%r12),%eax
  2642c4:	sub    0x48(%r12),%eax
  2642c9:	movslq %eax,%rcx
  2642cc:	mov    0x20(%r12),%rax
  2642d1:	mov    0x28(%r12),%rdx
  2642d6:	lea    (%rdx,%rcx,1),%rdi
  2642da:	dec    %rdi
  2642dd:	xor    %ecx,%ecx
  2642df:	cmp    %rax,%rdi
  2642e2:	cmovae %rax,%rcx
  2642e6:	sub    %rcx,%rdi
  2642e9:	cmp    %rax,%rdi
  2642ec:	jae    264b96 <<glass::engine::Watch>::print_utf8+0x2576>
  2642f2:	mov    0x58(%r12),%r9d
  2642f7:	mov    0x5c(%r12),%r10d
  2642fc:	movzwl 0x64(%r12),%edx
  264302:	mov    0x18(%r12),%rax
  264307:	shl    $0x6,%rdi
  26430b:	lea    (%rax,%rdi,1),%r11
  26430f:	lea    (%rax,%rdi,1),%rbx
  264313:	add    $0x18,%rbx
  264317:	mov    0x28(%rax,%rdi,1),%ecx
  26431b:	cmp    $0xffffffff,%ecx
  26431e:	je     264329 <<glass::engine::Watch>::print_utf8+0x1d09>
  264320:	mov    %rbx,%rax
  264323:	cmp    0x30(%r11),%r14
  264327:	jae    264342 <<glass::engine::Watch>::print_utf8+0x1d22>
  264329:	mov    0x10(%r11),%rax
  26432d:	cmp    %rax,%r14
  264330:	jae    264c51 <<glass::engine::Watch>::print_utf8+0x2631>
  264336:	lea    (%r14,%r14,2),%rax
  26433a:	shl    $0x3,%rax
  26433e:	add    0x8(%r11),%rax
  264342:	testb  $0x60,0x14(%rax)
  264346:	je     26436c <<glass::engine::Watch>::print_utf8+0x1d4c>
  264348:	mov    0xa8(%rsp),%rdi
  264350:	call   33dc40 <<glass::engine::Watch as vte::ansi::Handler>::input>
  264355:	mov    0x38(%rsp),%rax
  26435a:	add    $0x108,%rsp
  264361:	pop    %rbx
  264362:	pop    %r12
  264364:	pop    %r13
  264366:	pop    %r14
  264368:	pop    %r15
  26436a:	pop    %rbp
  26436b:	ret
  26436c:	cmp    $0x2,%rbp
  264370:	jne    2643a3 <<glass::engine::Watch>::print_utf8+0x1d83>
  264372:	lea    0x1(%r14),%rdi
  264376:	cmp    $0xffffffff,%ecx
  264379:	je     264384 <<glass::engine::Watch>::print_utf8+0x1d64>
  26437b:	mov    %rbx,%rax
  26437e:	cmp    0x30(%r11),%rdi
  264382:	jae    26439d <<glass::engine::Watch>::print_utf8+0x1d7d>
  264384:	mov    0x10(%r11),%rax
  264388:	cmp    %rax,%rdi
  26438b:	jae    264bfb <<glass::engine::Watch>::print_utf8+0x25db>
  264391:	lea    (%rdi,%rdi,2),%rax
  264395:	shl    $0x3,%rax
  264399:	add    0x8(%r11),%rax
  26439d:	testb  $0x60,0x14(%rax)
  2643a1:	jne    264348 <<glass::engine::Watch>::print_utf8+0x1d28>
  2643a3:	mov    %rbx,0x80(%rsp)
  2643ab:	mov    %r10d,0x20(%rsp)
  2643b0:	mov    %r9d,0x4c(%rsp)
  2643b5:	mov    %edx,0x18(%rsp)
  2643b9:	mov    %r8,0x10(%rsp)
  2643be:	cmp    %r14d,0x38(%r11)
  2643c2:	jbe    2643c8 <<glass::engine::Watch>::print_utf8+0x1da8>
  2643c4:	mov    %r14d,0x38(%r11)
  2643c8:	cmp    $0xffffffff,%ecx
  2643cb:	setne  %al
  2643ce:	mov    0x30(%r11),%rbx
  2643d2:	cmp    %rbx,%r14
  2643d5:	sete   %dl
  2643d8:	test   %dl,%al
  2643da:	mov    %r11,0x28(%rsp)
  2643df:	jne    26442f <<glass::engine::Watch>::print_utf8+0x1e0f>
  2643e1:	cmp    $0xffffffff,%ecx
  2643e4:	je     2646bb <<glass::engine::Watch>::print_utf8+0x209b>
  2643ea:	mov    0x10(%r11),%r15
  2643ee:	cmp    %rbx,%r15
  2643f1:	mov    %rbx,%rax
  2643f4:	cmovb  %r15,%rax
  2643f8:	mov    %rax,0x50(%rsp)
  2643fd:	cmp    %r14,%r15
  264400:	mov    %r14,%rcx
  264403:	cmovb  %r15,%rcx
  264407:	mov    0x38ecb2(%rip),%rax        # 5f30c0 <_DYNAMIC+0x320>
  26440e:	movzbl (%rax),%eax
  264411:	test   %al,%al
  264413:	je     2644a7 <<glass::engine::Watch>::print_utf8+0x1e87>
  264419:	cmp    %rcx,%rbx
  26441c:	mov    %rsi,0xc8(%rsp)
  264424:	jae    264477 <<glass::engine::Watch>::print_utf8+0x1e57>
  264426:	mov    0x38ecd3(%rip),%rax        # 5f3100 <_DYNAMIC+0x360>
  26442d:	jmp    26447e <<glass::engine::Watch>::print_utf8+0x1e5e>
  26442f:	lea    0x1(%r14),%rax
  264433:	mov    %rax,0x30(%r11)
  264437:	mov    0x10(%r11),%rax
  26443b:	cmp    %rax,%r14
  26443e:	jb     2646db <<glass::engine::Watch>::print_utf8+0x20bb>
  264444:	lea    0x366495(%rip),%rdx        # 5ca8e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15be0>
  26444b:	mov    %r14,%rdi
  26444e:	mov    %rax,%rsi
  264451:	call   *0x38eb61(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264457:	lea    0x3663da(%rip),%rcx        # 5ca838 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b38>
  26445e:	mov    %r12,%rdi
  264461:	call   *0x38ed11(%rip)        # 5f3178 <_DYNAMIC+0x3d8>
  264467:	cmpb   $0x0,0x6b(%rax)
  26446b:	sete   %al
  26446e:	mov    %eax,0x48(%rsp)
  264472:	jmp    262684 <<glass::engine::Watch>::print_utf8+0x64>
  264477:	mov    0x38ec7a(%rip),%rax        # 5f30f8 <_DYNAMIC+0x358>
  26447e:	lock incq 0x28(%rax)
  264483:	mov    %rcx,%rdi
  264486:	sub    0x50(%rsp),%rdi
  26448b:	mov    %rcx,%r13
  26448e:	call   2f77f0 <alacritty_terminal::grid::row::fill_census::note>
  264493:	mov    %r13,%rcx
  264496:	mov    0xc8(%rsp),%rsi
  26449e:	lea    (%r14,%rbp,1),%r13
  2644a2:	mov    0x28(%rsp),%r11
  2644a7:	cmp    %rcx,%rbx
  2644aa:	jae    264696 <<glass::engine::Watch>::print_utf8+0x2076>
  2644b0:	mov    0x28(%r11),%r8d
  2644b4:	mov    0x20(%r11),%r9d
  2644b8:	mov    0x24(%r11),%r10d
  2644bc:	movzwl 0x2c(%r11),%ebx
  2644c1:	mov    0x18(%r11),%rdi
  2644c5:	test   %rdi,%rdi
  2644c8:	mov    %rdi,0x40(%rsp)
  2644cd:	mov    %r8d,0x34(%rsp)
  2644d2:	mov    %r9d,0x60(%rsp)
  2644d7:	mov    %r10d,0x30(%rsp)
  2644dc:	mov    %bx,0x58(%rsp)
  2644e1:	mov    %rcx,0x8(%rsp)
  2644e6:	je     2645b0 <<glass::engine::Watch>::print_utf8+0x1f90>
  2644ec:	lock incq (%rdi)
  2644f0:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  2644f6:	mov    0x10(%r11),%rdx
  2644fa:	mov    %r8d,0x78(%rsp)
  2644ff:	mov    %r9d,0x70(%rsp)
  264504:	mov    %r10d,0x74(%rsp)
  264509:	mov    %bx,0x7c(%rsp)
  26450e:	mov    %rdi,0x68(%rsp)
  264513:	cmp    %rdx,%rcx
  264516:	ja     264b7f <<glass::engine::Watch>::print_utf8+0x255f>
  26451c:	mov    0x50(%rsp),%rax
  264521:	lea    0x0(,%rax,8),%rax
  264529:	lea    (%rax,%rax,2),%rax
  26452d:	mov    0x8(%r11),%r13
  264531:	add    %rax,%r13
  264534:	lea    0x0(,%rcx,8),%rcx
  26453c:	lea    (%rcx,%rcx,2),%r15
  264540:	sub    %rax,%r15
  264543:	jmp    264568 <<glass::engine::Watch>::print_utf8+0x1f48>
  264545:	mov    %rdi,0x0(%r13)
  264549:	mov    %r9d,0x8(%r13)
  26454d:	mov    %r10d,0xc(%r13)
  264551:	mov    %r8d,0x10(%r13)
  264555:	mov    %bx,0x14(%r13)
  26455a:	add    $0x18,%r13
  26455e:	add    $0xffffffffffffffe8,%r15
  264562:	je     264653 <<glass::engine::Watch>::print_utf8+0x2033>
  264568:	lock incq (%rdi)
  26456c:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  264572:	mov    0x0(%r13),%rax
  264576:	test   %rax,%rax
  264579:	je     264545 <<glass::engine::Watch>::print_utf8+0x1f25>
  26457b:	lock decq (%rax)
  26457f:	jne    264545 <<glass::engine::Watch>::print_utf8+0x1f25>
  264581:	mov    %r13,%rdi
  264584:	mov    %rsi,%rbx
  264587:	call   *0x38ea7b(%rip)        # 5f3008 <_DYNAMIC+0x268>
  26458d:	mov    0x30(%rsp),%r10d
  264592:	mov    0x60(%rsp),%r9d
  264597:	mov    0x34(%rsp),%r8d
  26459c:	mov    0x28(%rsp),%r11
  2645a1:	mov    %rbx,%rsi
  2645a4:	movzwl 0x58(%rsp),%ebx
  2645a9:	mov    0x40(%rsp),%rdi
  2645ae:	jmp    264545 <<glass::engine::Watch>::print_utf8+0x1f25>
  2645b0:	mov    %r8d,0x78(%rsp)
  2645b5:	mov    %r9d,0x70(%rsp)
  2645ba:	mov    %r10d,0x74(%rsp)
  2645bf:	mov    %bx,0x7c(%rsp)
  2645c4:	mov    %rdi,0x68(%rsp)
  2645c9:	mov    0x50(%rsp),%rax
  2645ce:	lea    0x0(,%rax,8),%rax
  2645d6:	lea    (%rax,%rax,2),%rax
  2645da:	mov    0x8(%r11),%r13
  2645de:	add    %rax,%r13
  2645e1:	lea    0x0(,%rcx,8),%rcx
  2645e9:	lea    (%rcx,%rcx,2),%r15
  2645ed:	sub    %rax,%r15
  2645f0:	jmp    264615 <<glass::engine::Watch>::print_utf8+0x1ff5>
  2645f2:	movq   $0x0,0x0(%r13)
  2645fa:	mov    %r9d,0x8(%r13)
  2645fe:	mov    %r10d,0xc(%r13)
  264602:	mov    %r8d,0x10(%r13)
  264606:	mov    %bx,0x14(%r13)
  26460b:	add    $0x18,%r13
  26460f:	add    $0xffffffffffffffe8,%r15
  264613:	je     264653 <<glass::engine::Watch>::print_utf8+0x2033>
  264615:	mov    0x0(%r13),%rax
  264619:	test   %rax,%rax
  26461c:	je     2645f2 <<glass::engine::Watch>::print_utf8+0x1fd2>
  26461e:	lock decq (%rax)
  264622:	jne    2645f2 <<glass::engine::Watch>::print_utf8+0x1fd2>
  264624:	mov    %r13,%rdi
  264627:	mov    %rsi,%rbx
  26462a:	call   *0x38e9d8(%rip)        # 5f3008 <_DYNAMIC+0x268>
  264630:	mov    0x30(%rsp),%r10d
  264635:	mov    0x60(%rsp),%r9d
  26463a:	mov    0x34(%rsp),%r8d
  26463f:	mov    0x28(%rsp),%r11
  264644:	mov    %rbx,%rsi
  264647:	movzwl 0x58(%rsp),%ebx
  26464c:	mov    0x40(%rsp),%rdi
  264651:	jmp    2645f2 <<glass::engine::Watch>::print_utf8+0x1fd2>
  264653:	mov    0x50(%rsp),%rax
  264658:	cmp    %eax,0x38(%r11)
  26465c:	jbe    264662 <<glass::engine::Watch>::print_utf8+0x2042>
  26465e:	mov    %eax,0x38(%r11)
  264662:	test   %rdi,%rdi
  264665:	lea    (%r14,%rbp,1),%r13
  264669:	mov    0x8(%rsp),%rcx
  26466e:	je     264692 <<glass::engine::Watch>::print_utf8+0x2072>
  264670:	lock decq (%rdi)
  264674:	jne    264692 <<glass::engine::Watch>::print_utf8+0x2072>
  264676:	lea    0x68(%rsp),%rdi
  26467b:	mov    %rsi,%rbx
  26467e:	mov    %rcx,%r15
  264681:	call   *0x38e981(%rip)        # 5f3008 <_DYNAMIC+0x268>
  264687:	mov    %r15,%rcx
  26468a:	mov    0x28(%rsp),%r11
  26468f:	mov    %rbx,%rsi
  264692:	mov    0x10(%r11),%r15
  264696:	cmp    %r15,%rcx
  264699:	jb     2646bb <<glass::engine::Watch>::print_utf8+0x209b>
  26469b:	mov    0x80(%rsp),%rdi
  2646a3:	mov    %rsi,%rbx
  2646a6:	call   1ad6e0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2646ab:	mov    0x28(%rsp),%r11
  2646b0:	mov    %rbx,%rsi
  2646b3:	movl   $0xffffffff,0x28(%r11)
  2646bb:	mov    0x30(%r11),%rcx
  2646bf:	lea    0x1(%r14),%rax
  2646c3:	cmp    %rcx,%rax
  2646c6:	cmova  %rax,%rcx
  2646ca:	mov    0x10(%r11),%rax
  2646ce:	mov    %rcx,0x30(%r11)
  2646d2:	cmp    %rax,%r14
  2646d5:	jae    264c64 <<glass::engine::Watch>::print_utf8+0x2644>
  2646db:	mov    0x18(%rsp),%edi
  2646df:	mov    %edi,%eax
  2646e1:	or     $0x20,%eax
  2646e4:	cmp    $0x2,%rbp
  2646e8:	mov    0x8(%r11),%rcx
  2646ec:	lea    (%r14,%r14,2),%rdx
  2646f0:	lea    (%rcx,%rdx,8),%rbx
  2646f4:	mov    %esi,0x10(%rcx,%rdx,8)
  2646f8:	mov    0x4c(%rsp),%r8d
  2646fd:	mov    %r8d,0x8(%rcx,%rdx,8)
  264702:	cmovne %edi,%eax
  264705:	mov    0x20(%rsp),%edi
  264709:	mov    %edi,0xc(%rcx,%rdx,8)
  26470d:	mov    %ax,0x14(%rcx,%rdx,8)
  264712:	mov    (%rcx,%rdx,8),%rax
  264716:	test   %rax,%rax
  264719:	je     264735 <<glass::engine::Watch>::print_utf8+0x2115>
  26471b:	lock decq (%rax)
  26471f:	jne    264735 <<glass::engine::Watch>::print_utf8+0x2115>
  264721:	mov    %rbx,%rdi
  264724:	mov    %rsi,%r15
  264727:	call   *0x38e8db(%rip)        # 5f3008 <_DYNAMIC+0x268>
  26472d:	mov    0x28(%rsp),%r11
  264732:	mov    %r15,%rsi
  264735:	movq   $0x0,(%rbx)
  26473c:	cmp    $0x2,%rbp
  264740:	jne    264a8e <<glass::engine::Watch>::print_utf8+0x246e>
  264746:	lea    0x1(%r14),%rbp
  26474a:	mov    0x30(%r11),%rbx
  26474e:	mov    0x28(%r11),%eax
  264752:	cmp    %rbx,%rbp
  264755:	jne    264784 <<glass::engine::Watch>::print_utf8+0x2164>
  264757:	cmp    $0xffffffff,%eax
  26475a:	je     264784 <<glass::engine::Watch>::print_utf8+0x2164>
  26475c:	add    $0x2,%r14
  264760:	mov    %r14,0x30(%r11)
  264764:	mov    0x10(%r11),%rax
  264768:	cmp    %rax,%rbp
  26476b:	jb     264a32 <<glass::engine::Watch>::print_utf8+0x2412>
  264771:	lea    0x366168(%rip),%rdx        # 5ca8e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15be0>
  264778:	mov    %rbp,%rdi
  26477b:	mov    %rax,%rsi
  26477e:	call   *0x38e834(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264784:	cmp    $0xffffffff,%eax
  264787:	je     264a12 <<glass::engine::Watch>::print_utf8+0x23f2>
  26478d:	mov    0x10(%r11),%r15
  264791:	cmp    %rbx,%r15
  264794:	mov    %rbx,%rax
  264797:	cmovb  %r15,%rax
  26479b:	mov    %rax,0x58(%rsp)
  2647a0:	cmp    %rbp,%r15
  2647a3:	mov    %rbp,%rcx
  2647a6:	cmovb  %r15,%rcx
  2647aa:	mov    0x38e90f(%rip),%rax        # 5f30c0 <_DYNAMIC+0x320>
  2647b1:	movzbl (%rax),%eax
  2647b4:	test   %al,%al
  2647b6:	mov    %r13,0x88(%rsp)
  2647be:	je     264804 <<glass::engine::Watch>::print_utf8+0x21e4>
  2647c0:	mov    %rsi,%r13
  2647c3:	cmp    %rcx,%rbx
  2647c6:	jae    2647d1 <<glass::engine::Watch>::print_utf8+0x21b1>
  2647c8:	mov    0x38e931(%rip),%rax        # 5f3100 <_DYNAMIC+0x360>
  2647cf:	jmp    2647d8 <<glass::engine::Watch>::print_utf8+0x21b8>
  2647d1:	mov    0x38e920(%rip),%rax        # 5f30f8 <_DYNAMIC+0x358>
  2647d8:	lock incq 0x28(%rax)
  2647dd:	mov    %rcx,%rdi
  2647e0:	sub    0x58(%rsp),%rdi
  2647e5:	mov    %rcx,%rbp
  2647e8:	call   2f77f0 <alacritty_terminal::grid::row::fill_census::note>
  2647ed:	mov    %rbp,%rcx
  2647f0:	mov    %r13,%rsi
  2647f3:	mov    0x88(%rsp),%r13
  2647fb:	mov    0x28(%rsp),%r11
  264800:	lea    0x1(%r14),%rbp
  264804:	cmp    %rcx,%rbx
  264807:	jae    2649ed <<glass::engine::Watch>::print_utf8+0x23cd>
  26480d:	mov    0x28(%r11),%edi
  264811:	mov    0x20(%r11),%r8d
  264815:	mov    0x24(%r11),%r9d
  264819:	movzwl 0x2c(%r11),%r10d
  26481e:	mov    0x18(%r11),%r13
  264822:	test   %r13,%r13
  264825:	mov    %edi,0x40(%rsp)
  264829:	mov    %r8d,0x34(%rsp)
  26482e:	mov    %r9d,0x60(%rsp)
  264833:	mov    %r10w,0x30(%rsp)
  264839:	mov    %rcx,0x50(%rsp)
  26483e:	je     264904 <<glass::engine::Watch>::print_utf8+0x22e4>
  264844:	lock incq 0x0(%r13)
  264849:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  26484f:	mov    0x10(%r11),%rdx
  264853:	mov    %edi,0x78(%rsp)
  264857:	mov    %r8d,0x70(%rsp)
  26485c:	mov    %r9d,0x74(%rsp)
  264861:	mov    %r10w,0x7c(%rsp)
  264867:	mov    %r13,0x68(%rsp)
  26486c:	cmp    %rdx,%rcx
  26486f:	ja     264be4 <<glass::engine::Watch>::print_utf8+0x25c4>
  264875:	mov    0x58(%rsp),%rax
  26487a:	lea    0x0(,%rax,8),%rax
  264882:	lea    (%rax,%rax,2),%rax
  264886:	mov    0x8(%r11),%rbp
  26488a:	add    %rax,%rbp
  26488d:	lea    0x0(,%rcx,8),%rcx
  264895:	lea    (%rcx,%rcx,2),%r15
  264899:	sub    %rax,%r15
  26489c:	jmp    2648c0 <<glass::engine::Watch>::print_utf8+0x22a0>
  26489e:	mov    %r13,0x0(%rbp)
  2648a2:	mov    %r8d,0x8(%rbp)
  2648a6:	mov    %r9d,0xc(%rbp)
  2648aa:	mov    %edi,0x10(%rbp)
  2648ad:	mov    %r10w,0x14(%rbp)
  2648b2:	add    $0x18,%rbp
  2648b6:	add    $0xffffffffffffffe8,%r15
  2648ba:	je     2649a1 <<glass::engine::Watch>::print_utf8+0x2381>
  2648c0:	lock incq 0x0(%r13)
  2648c5:	jle    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  2648cb:	mov    0x0(%rbp),%rax
  2648cf:	test   %rax,%rax
  2648d2:	je     26489e <<glass::engine::Watch>::print_utf8+0x227e>
  2648d4:	lock decq (%rax)
  2648d8:	jne    26489e <<glass::engine::Watch>::print_utf8+0x227e>
  2648da:	mov    %rbp,%rdi
  2648dd:	mov    %rsi,%rbx
  2648e0:	call   *0x38e722(%rip)        # 5f3008 <_DYNAMIC+0x268>
  2648e6:	movzwl 0x30(%rsp),%r10d
  2648ec:	mov    0x60(%rsp),%r9d
  2648f1:	mov    0x34(%rsp),%r8d
  2648f6:	mov    0x40(%rsp),%edi
  2648fa:	mov    0x28(%rsp),%r11
  2648ff:	mov    %rbx,%rsi
  264902:	jmp    26489e <<glass::engine::Watch>::print_utf8+0x227e>
  264904:	mov    %edi,0x78(%rsp)
  264908:	mov    %r8d,0x70(%rsp)
  26490d:	mov    %r9d,0x74(%rsp)
  264912:	mov    %r10w,0x7c(%rsp)
  264918:	mov    %r13,0x68(%rsp)
  26491d:	mov    0x58(%rsp),%rax
  264922:	lea    0x0(,%rax,8),%rax
  26492a:	lea    (%rax,%rax,2),%rax
  26492e:	mov    0x8(%r11),%rbp
  264932:	add    %rax,%rbp
  264935:	lea    0x0(,%rcx,8),%rcx
  26493d:	lea    (%rcx,%rcx,2),%r15
  264941:	sub    %rax,%r15
  264944:	jmp    264968 <<glass::engine::Watch>::print_utf8+0x2348>
  264946:	movq   $0x0,0x0(%rbp)
  26494e:	mov    %r8d,0x8(%rbp)
  264952:	mov    %r9d,0xc(%rbp)
  264956:	mov    %edi,0x10(%rbp)
  264959:	mov    %r10w,0x14(%rbp)
  26495e:	add    $0x18,%rbp
  264962:	add    $0xffffffffffffffe8,%r15
  264966:	je     2649a1 <<glass::engine::Watch>::print_utf8+0x2381>
  264968:	mov    0x0(%rbp),%rax
  26496c:	test   %rax,%rax
  26496f:	je     264946 <<glass::engine::Watch>::print_utf8+0x2326>
  264971:	lock decq (%rax)
  264975:	jne    264946 <<glass::engine::Watch>::print_utf8+0x2326>
  264977:	mov    %rbp,%rdi
  26497a:	mov    %rsi,%rbx
  26497d:	call   *0x38e685(%rip)        # 5f3008 <_DYNAMIC+0x268>
  264983:	movzwl 0x30(%rsp),%r10d
  264989:	mov    0x60(%rsp),%r9d
  26498e:	mov    0x34(%rsp),%r8d
  264993:	mov    0x40(%rsp),%edi
  264997:	mov    0x28(%rsp),%r11
  26499c:	mov    %rbx,%rsi
  26499f:	jmp    264946 <<glass::engine::Watch>::print_utf8+0x2326>
  2649a1:	mov    0x58(%rsp),%rax
  2649a6:	cmp    %eax,0x38(%r11)
  2649aa:	jbe    2649b0 <<glass::engine::Watch>::print_utf8+0x2390>
  2649ac:	mov    %eax,0x38(%r11)
  2649b0:	test   %r13,%r13
  2649b3:	lea    0x1(%r14),%rbp
  2649b7:	mov    0x50(%rsp),%rcx
  2649bc:	je     2649e1 <<glass::engine::Watch>::print_utf8+0x23c1>
  2649be:	lock decq 0x0(%r13)
  2649c3:	jne    2649e1 <<glass::engine::Watch>::print_utf8+0x23c1>
  2649c5:	lea    0x68(%rsp),%rdi
  2649ca:	mov    %rsi,%rbx
  2649cd:	mov    %rcx,%r15
  2649d0:	call   *0x38e632(%rip)        # 5f3008 <_DYNAMIC+0x268>
  2649d6:	mov    %r15,%rcx
  2649d9:	mov    0x28(%rsp),%r11
  2649de:	mov    %rbx,%rsi
  2649e1:	mov    0x10(%r11),%r15
  2649e5:	mov    0x88(%rsp),%r13
  2649ed:	cmp    %r15,%rcx
  2649f0:	jb     264a12 <<glass::engine::Watch>::print_utf8+0x23f2>
  2649f2:	mov    0x80(%rsp),%rdi
  2649fa:	mov    %rsi,%rbx
  2649fd:	call   1ad6e0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  264a02:	mov    0x28(%rsp),%r11
  264a07:	mov    %rbx,%rsi
  264a0a:	movl   $0xffffffff,0x28(%r11)
  264a12:	mov    0x30(%r11),%rax
  264a16:	add    $0x2,%r14
  264a1a:	cmp    %rax,%r14
  264a1d:	cmovbe %rax,%r14
  264a21:	mov    0x10(%r11),%rax
  264a25:	mov    %r14,0x30(%r11)
  264a29:	cmp    %rax,%rbp
  264a2c:	jae    264c77 <<glass::engine::Watch>::print_utf8+0x2657>
  264a32:	mov    0x8(%r11),%rax
  264a36:	lea    0x0(,%rbp,2),%rcx
  264a3e:	add    %rbp,%rcx
  264a41:	lea    (%rax,%rcx,8),%rbx
  264a45:	movl   $0x20,0x10(%rax,%rcx,8)
  264a4d:	mov    0x4c(%rsp),%edx
  264a51:	mov    %edx,0x8(%rax,%rcx,8)
  264a55:	mov    0x20(%rsp),%edx
  264a59:	mov    %edx,0xc(%rax,%rcx,8)
  264a5d:	mov    0x18(%rsp),%edx
  264a61:	or     $0x40,%edx
  264a64:	mov    %dx,0x14(%rax,%rcx,8)
  264a69:	mov    (%rax,%rcx,8),%rax
  264a6d:	test   %rax,%rax
  264a70:	je     264a87 <<glass::engine::Watch>::print_utf8+0x2467>
  264a72:	lock decq (%rax)
  264a76:	jne    264a87 <<glass::engine::Watch>::print_utf8+0x2467>
  264a78:	mov    %rbx,%rdi
  264a7b:	mov    %rsi,%r14
  264a7e:	call   *0x38e584(%rip)        # 5f3008 <_DYNAMIC+0x268>
  264a84:	mov    %r14,%rsi
  264a87:	movq   $0x0,(%rbx)
  264a8e:	cmp    0x10(%rsp),%r13
  264a93:	jb     264a9e <<glass::engine::Watch>::print_utf8+0x247e>
  264a95:	dec    %r13
  264a98:	movb   $0x1,0x6c(%r12)
  264a9e:	mov    %r13,0x40(%r12)
  264aa3:	mov    0xa8(%rsp),%rax
  264aab:	incq   0xa0(%rax)
  264ab2:	mov    %esi,0xb0(%rax)
  264ab8:	jmp    264355 <<glass::engine::Watch>::print_utf8+0x1d35>
  264abd:	mov    %rsi,%rbx
  264ac0:	call   18bbe2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  264ac5:	mov    %rbx,%rsi
  264ac8:	mov    %esi,%ebx
  264aca:	mov    0x39149f(%rip),%rax        # 5f5f70 <glass::engine::width_of::CACHE+0x8>
  264ad1:	cmp    %rbx,%rax
  264ad4:	ja     2641f1 <<glass::engine::Watch>::print_utf8+0x1bd1>
  264ada:	lea    0x368007(%rip),%rdx        # 5ccae8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17de8>
  264ae1:	mov    %rbx,%rdi
  264ae4:	mov    %rax,%rsi
  264ae7:	call   *0x38e4cb(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264aed:	lea    0x3651d4(%rip),%rcx        # 5c9cc8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  264af4:	mov    %r10,%rdi
  264af7:	mov    %r14,%rsi
  264afa:	call   *0x38e678(%rip)        # 5f3178 <_DYNAMIC+0x3d8>
  264b00:	jmp    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  264b05:	lea    0x3651bc(%rip),%rcx        # 5c9cc8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  264b0c:	mov    0x90(%rsp),%rdi
  264b14:	call   *0x38e65e(%rip)        # 5f3178 <_DYNAMIC+0x3d8>
  264b1a:	jmp    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  264b1f:	lea    0x367fc2(%rip),%rdx        # 5ccae8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17de8>
  264b26:	call   *0x38e48c(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264b2c:	lea    0x36568d(%rip),%rdx        # 5ca1c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x154c0>
  264b33:	call   *0x38e47f(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264b39:	lea    0x3656e0(%rip),%rax        # 5ca220 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15520>
  264b40:	jmp    264bb0 <<glass::engine::Watch>::print_utf8+0x2590>
  264b42:	mov    %rdi,%rbx
  264b45:	lea    0x3656a4(%rip),%rax        # 5ca1f0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x154f0>
  264b4c:	jmp    264bb0 <<glass::engine::Watch>::print_utf8+0x2590>
  264b4e:	lea    0x3656e3(%rip),%rdx        # 5ca238 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15538>
  264b55:	mov    0x80(%rsp),%rsi
  264b5d:	call   *0x38e455(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264b63:	mov    %r15,%rbx
  264b66:	mov    %rbx,%rdi
  264b69:	mov    0x80(%rsp),%rsi
  264b71:	mov    0xc0(%rsp),%rdx
  264b79:	call   *0x38e439(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264b7f:	mov    %rcx,%rsi
  264b82:	lea    0x36513f(%rip),%rcx        # 5c9cc8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  264b89:	mov    0x50(%rsp),%rdi
  264b8e:	call   *0x38e5e4(%rip)        # 5f3178 <_DYNAMIC+0x3d8>
  264b94:	jmp    264bf9 <<glass::engine::Watch>::print_utf8+0x25d9>
  264b96:	lea    0x3657bb(%rip),%rdx        # 5ca358 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15658>
  264b9d:	mov    %rax,%rsi
  264ba0:	call   *0x38e412(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264ba6:	mov    %rax,%rbx
  264ba9:	lea    0x365658(%rip),%rax        # 5ca208 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15508>
  264bb0:	mov    %rax,0xc0(%rsp)
  264bb8:	mov    %rbx,%rdi
  264bbb:	mov    0x80(%rsp),%rsi
  264bc3:	mov    0xc0(%rsp),%rdx
  264bcb:	call   *0x38e3e7(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264bd1:	lea    0x353710(%rip),%rdx        # 5b82e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264bd8:	mov    %r11,%rdi
  264bdb:	mov    %rax,%rsi
  264bde:	call   *0x38e3d4(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264be4:	mov    %rcx,%rsi
  264be7:	lea    0x3650da(%rip),%rcx        # 5c9cc8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  264bee:	mov    0x58(%rsp),%rdi
  264bf3:	call   *0x38e57f(%rip)        # 5f3178 <_DYNAMIC+0x3d8>
  264bf9:	ud2
  264bfb:	lea    0x3536e6(%rip),%rdx        # 5b82e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264c02:	mov    %rax,%rsi
  264c05:	call   *0x38e3ad(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264c0b:	lea    0x365cce(%rip),%rdx        # 5ca8e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15be0>
  264c12:	mov    %r11,%rdi
  264c15:	mov    %rax,%rsi
  264c18:	call   *0x38e39a(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264c1e:	lea    0x365ca3(%rip),%rdx        # 5ca8c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  264c25:	mov    %r11,%rdi
  264c28:	mov    %rax,%rsi
  264c2b:	call   *0x38e387(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264c31:	lea    0x365ca8(%rip),%rdx        # 5ca8e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15be0>
  264c38:	mov    %r14,%rdi
  264c3b:	call   *0x38e377(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264c41:	lea    0x365c80(%rip),%rdx        # 5ca8c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  264c48:	mov    %r14,%rdi
  264c4b:	call   *0x38e367(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264c51:	lea    0x353690(%rip),%rdx        # 5b82e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264c58:	mov    %r14,%rdi
  264c5b:	mov    %rax,%rsi
  264c5e:	call   *0x38e354(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264c64:	lea    0x365c5d(%rip),%rdx        # 5ca8c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  264c6b:	mov    %r14,%rdi
  264c6e:	mov    %rax,%rsi
  264c71:	call   *0x38e341(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264c77:	lea    0x365c4a(%rip),%rdx        # 5ca8c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  264c7e:	mov    %rbp,%rdi
  264c81:	mov    %rax,%rsi
  264c84:	call   *0x38e32e(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  264c8a:	mov    %rax,%r14
  264c8d:	lock decq 0x0(%r13)
  264c92:	je     264cbb <<glass::engine::Watch>::print_utf8+0x269b>
  264c94:	jmp    264cc9 <<glass::engine::Watch>::print_utf8+0x26a9>
  264c96:	mov    %rax,%r14
  264c99:	mov    0x40(%rsp),%rax
  264c9e:	jmp    264cb5 <<glass::engine::Watch>::print_utf8+0x2695>
  264ca0:	mov    %rax,%r14
  264ca3:	mov    0x88(%rsp),%rax
  264cab:	jmp    264cb5 <<glass::engine::Watch>::print_utf8+0x2695>
  264cad:	mov    %rax,%r14
  264cb0:	mov    0x8(%rsp),%rax
  264cb5:	lock decq (%rax)
  264cb9:	jne    264cc9 <<glass::engine::Watch>::print_utf8+0x26a9>
  264cbb:	mov    0x100(%rsp),%rdi
  264cc3:	call   *0x38e33f(%rip)        # 5f3008 <_DYNAMIC+0x268>
  264cc9:	mov    %r14,%rdi
  264ccc:	call   5b15f0 <_Unwind_Resume@plt>
