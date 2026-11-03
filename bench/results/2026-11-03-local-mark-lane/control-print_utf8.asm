
/tmp/glass-i31-control-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002625a0 <<glass::engine::Watch>::print_utf8>:
  2625a0:	push   %rbp
  2625a1:	push   %r15
  2625a3:	push   %r14
  2625a5:	push   %r13
  2625a7:	push   %r12
  2625a9:	push   %rbx
  2625aa:	sub    $0x118,%rsp
  2625b1:	mov    %rdx,%r13
  2625b4:	mov    %rdi,%r15
  2625b7:	cmpb   $0x1,0xbe(%rdi)
  2625be:	jne    2625eb <<glass::engine::Watch>::print_utf8+0x4b>
  2625c0:	cmpq   $0x0,0x38(%r15)
  2625c5:	jne    2625eb <<glass::engine::Watch>::print_utf8+0x4b>
  2625c7:	mov    0x78(%r15),%rax
  2625cb:	testb  $0x4,0x6c5(%rax)
  2625d2:	jne    2625eb <<glass::engine::Watch>::print_utf8+0x4b>
  2625d4:	cmpq   $0x0,0x50(%rax)
  2625d9:	jne    2625eb <<glass::engine::Watch>::print_utf8+0x4b>
  2625db:	movzwl 0x64(%rax),%ecx
  2625df:	test   $0x460,%ecx
  2625e5:	je     263d10 <<glass::engine::Watch>::print_utf8+0x1770>
  2625eb:	movl   $0x0,0x10(%rsp)
  2625f3:	movl   $0x0,0x80(%rsp)
  2625fe:	mov    $0xffffffff,%r8d
  262604:	xor    %r14d,%r14d
  262607:	lea    0x36767a(%rip),%rax        # 5c9c88 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15508>
  26260e:	mov    %rax,0xf0(%rsp)
  262616:	lea    0x40(%rsp),%rax
  26261b:	mov    %rax,0x110(%rsp)
  262623:	xor    %edx,%edx
  262625:	mov    %r13,0xc0(%rsp)
  26262d:	mov    %r15,0xc8(%rsp)
  262635:	mov    %rsi,0x18(%rsp)
  26263a:	cmpb   $0x0,0x80(%rsp)
  262642:	je     263139 <<glass::engine::Watch>::print_utf8+0xb99>
  262648:	nopl   0x0(%rax,%rax,1)
  262650:	mov    0x78(%r15),%rbx
  262654:	cmpb   $0x0,0x6c(%rbx)
  262658:	jne    263139 <<glass::engine::Watch>::print_utf8+0xb99>
  26265e:	mov    0x30(%rbx),%eax
  262661:	sub    0x48(%rbx),%eax
  262664:	cltq
  262666:	mov    0x20(%rbx),%rsi
  26266a:	mov    0x28(%rbx),%rcx
  26266e:	lea    (%rcx,%rax,1),%rdi
  262672:	dec    %rdi
  262675:	cmp    %rsi,%rdi
  262678:	mov    $0x0,%eax
  26267d:	cmovae %rsi,%rax
  262681:	sub    %rax,%rdi
  262684:	cmp    %rsi,%rdi
  262687:	jae    2645b4 <<glass::engine::Watch>::print_utf8+0x2014>
  26268d:	mov    0xa0(%rbx),%rax
  262694:	mov    %rax,0x38(%rsp)
  262699:	mov    0x40(%rbx),%r12
  26269d:	mov    0x58(%rbx),%eax
  2626a0:	mov    %eax,0x78(%rsp)
  2626a4:	mov    0x5c(%rbx),%eax
  2626a7:	mov    %eax,0xa0(%rsp)
  2626ae:	movzwl 0x64(%rbx),%eax
  2626b2:	mov    %eax,0xc(%rsp)
  2626b6:	mov    0x18(%rbx),%rax
  2626ba:	shl    $0x6,%rdi
  2626be:	lea    (%rax,%rdi,1),%rbp
  2626c2:	cmp    %r12d,0x38(%rax,%rdi,1)
  2626c7:	jbe    2626cd <<glass::engine::Watch>::print_utf8+0x12d>
  2626c9:	mov    %r12d,0x38(%rbp)
  2626cd:	mov    %rdx,0x28(%rsp)
  2626d2:	mov    0x28(%rbp),%r10d
  2626d6:	cmp    $0xffffffff,%r10d
  2626da:	mov    %r12,0x60(%rsp)
  2626df:	je     262799 <<glass::engine::Watch>::print_utf8+0x1f9>
  2626e5:	mov    0x30(%rbp),%rax
  2626e9:	cmp    %rax,%r12
  2626ec:	mov    $0x0,%ecx
  2626f1:	cmovb  %rax,%rcx
  2626f5:	mov    %rcx,0x20(%rsp)
  2626fa:	movl   $0x20,0x108(%rsp)
  262705:	mov    0x78(%rsp),%ecx
  262709:	mov    %ecx,0x100(%rsp)
  262710:	mov    0xa0(%rsp),%ecx
  262717:	mov    %ecx,0x104(%rsp)
  26271e:	mov    0xc(%rsp),%ecx
  262722:	mov    %cx,0x10c(%rsp)
  26272a:	movq   $0x0,0xf8(%rsp)
  262736:	mov    0x10(%rbp),%rcx
  26273a:	cmp    %rax,%rcx
  26273d:	mov    %rax,%rdx
  262740:	cmovb  %rcx,%rdx
  262744:	mov    %rdx,0x68(%rsp)
  262749:	cmp    %r12,%rcx
  26274c:	mov    %r12,%r9
  26274f:	cmovb  %rcx,%r9
  262753:	mov    0x3903a6(%rip),%rdx        # 5f2b00 <_DYNAMIC+0x320>
  26275a:	movzbl (%rdx),%edx
  26275d:	test   %dl,%dl
  26275f:	je     26283a <<glass::engine::Watch>::print_utf8+0x29a>
  262765:	mov    0x3903cc(%rip),%rdx        # 5f2b38 <_DYNAMIC+0x358>
  26276c:	cmp    %r9,%rax
  26276f:	jae    262778 <<glass::engine::Watch>::print_utf8+0x1d8>
  262771:	mov    0x3903c8(%rip),%rdx        # 5f2b40 <_DYNAMIC+0x360>
  262778:	lock incq 0x28(%rdx)
  26277d:	mov    0x390394(%rip),%rdx        # 5f2b18 <_DYNAMIC+0x338>
  262784:	lock incq (%rdx)
  262788:	mov    %r9,%rdx
  26278b:	sub    0x68(%rsp),%rdx
  262790:	jne    2627ef <<glass::engine::Watch>::print_utf8+0x24f>
  262792:	xor    %esi,%esi
  262794:	jmp    26282e <<glass::engine::Watch>::print_utf8+0x28e>
  262799:	movl   $0x20,0x108(%rsp)
  2627a4:	mov    0x78(%rsp),%eax
  2627a8:	mov    %eax,0x100(%rsp)
  2627af:	mov    0xa0(%rsp),%eax
  2627b6:	mov    %eax,0x104(%rsp)
  2627bd:	mov    0xc(%rsp),%eax
  2627c1:	mov    %ax,0x10c(%rsp)
  2627c9:	movq   $0x0,0xf8(%rsp)
  2627d5:	lea    0x30(%rbp),%rax
  2627d9:	mov    %rax,0xd8(%rsp)
  2627e1:	movq   $0xffffffffffffffff,0x20(%rsp)
  2627ea:	jmp    2629ca <<glass::engine::Watch>::print_utf8+0x42a>
  2627ef:	mov    0x39032a(%rip),%rsi        # 5f2b20 <_DYNAMIC+0x340>
  2627f6:	lock add %rdx,(%rsi)
  2627fa:	cmp    $0x5,%rdx
  2627fe:	jae    26280e <<glass::engine::Watch>::print_utf8+0x26e>
  262800:	lea    -0x204bf7(%rip),%rsi        # 5dc10 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  262807:	movzbl -0x1(%rdx,%rsi,1),%esi
  26280c:	jmp    26282e <<glass::engine::Watch>::print_utf8+0x28e>
  26280e:	lea    -0x5(%rdx),%rdi
  262812:	mov    $0x4,%esi
  262817:	cmp    $0x4,%rdi
  26281b:	jb     26282e <<glass::engine::Watch>::print_utf8+0x28e>
  26281d:	add    $0xfffffffffffffff7,%rdx
  262821:	cmp    $0x8,%rdx
  262825:	mov    $0x6,%esi
  26282a:	sbb    $0x0,%rsi
  26282e:	mov    0x3902db(%rip),%rdx        # 5f2b10 <_DYNAMIC+0x330>
  262835:	lock incq (%rdx,%rsi,8)
  26283a:	cmp    %r9,%rax
  26283d:	mov    %r8,0x58(%rsp)
  262842:	jae    26298f <<glass::engine::Watch>::print_utf8+0x3ef>
  262848:	mov    %rbx,0x98(%rsp)
  262850:	mov    %r14,0x30(%rsp)
  262855:	mov    0x20(%rbp),%r13d
  262859:	mov    0x24(%rbp),%esi
  26285c:	movzwl 0x2c(%rbp),%edi
  262860:	mov    0x18(%rbp),%r12
  262864:	test   %r12,%r12
  262867:	je     262874 <<glass::engine::Watch>::print_utf8+0x2d4>
  262869:	lock incq (%r12)
  26286e:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  262874:	mov    %r10d,0x50(%rsp)
  262879:	mov    %r13d,0x48(%rsp)
  26287e:	mov    %esi,0x4c(%rsp)
  262882:	mov    %di,0x54(%rsp)
  262887:	mov    %r12,0x40(%rsp)
  26288c:	mov    0x68(%rsp),%rax
  262891:	lea    0x0(,%rax,8),%rax
  262899:	lea    (%rax,%rax,2),%rax
  26289d:	mov    %rbp,0xd0(%rsp)
  2628a5:	mov    0x8(%rbp),%rbx
  2628a9:	add    %rax,%rbx
  2628ac:	lea    0x0(,%r9,8),%rcx
  2628b4:	lea    (%rcx,%rcx,2),%rbp
  2628b8:	sub    %rax,%rbp
  2628bb:	mov    %esi,0x70(%rsp)
  2628bf:	mov    %di,0x90(%rsp)
  2628c7:	jmp    2628ec <<glass::engine::Watch>::print_utf8+0x34c>
  2628c9:	nopl   0x0(%rax)
  2628d0:	mov    %r12,(%rbx)
  2628d3:	mov    %r13d,0x8(%rbx)
  2628d7:	mov    %esi,0xc(%rbx)
  2628da:	mov    %r10d,0x10(%rbx)
  2628de:	mov    %di,0x14(%rbx)
  2628e2:	add    $0x18,%rbx
  2628e6:	add    $0xffffffffffffffe8,%rbp
  2628ea:	je     262932 <<glass::engine::Watch>::print_utf8+0x392>
  2628ec:	test   %r12,%r12
  2628ef:	je     2628fc <<glass::engine::Watch>::print_utf8+0x35c>
  2628f1:	lock incq (%r12)
  2628f6:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  2628fc:	mov    (%rbx),%rax
  2628ff:	test   %rax,%rax
  262902:	je     2628d0 <<glass::engine::Watch>::print_utf8+0x330>
  262904:	lock decq (%rax)
  262908:	jne    2628d0 <<glass::engine::Watch>::print_utf8+0x330>
  26290a:	mov    %rbx,%rdi
  26290d:	mov    %r9,%r14
  262910:	mov    %r10d,%r15d
  262913:	call   *0x39012f(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  262919:	movzwl 0x90(%rsp),%edi
  262921:	mov    0x70(%rsp),%esi
  262925:	mov    %r15d,%r10d
  262928:	mov    %r14,%r9
  26292b:	mov    0x58(%rsp),%r8
  262930:	jmp    2628d0 <<glass::engine::Watch>::print_utf8+0x330>
  262932:	mov    0xd0(%rsp),%rbp
  26293a:	mov    0x68(%rsp),%rax
  26293f:	cmp    %eax,0x38(%rbp)
  262942:	jbe    262947 <<glass::engine::Watch>::print_utf8+0x3a7>
  262944:	mov    %eax,0x38(%rbp)
  262947:	test   %r12,%r12
  26294a:	mov    0xc0(%rsp),%r13
  262952:	mov    0xc8(%rsp),%r15
  26295a:	mov    0x30(%rsp),%r14
  26295f:	mov    0x98(%rsp),%rbx
  262967:	je     262986 <<glass::engine::Watch>::print_utf8+0x3e6>
  262969:	lock decq (%r12)
  26296e:	jne    262986 <<glass::engine::Watch>::print_utf8+0x3e6>
  262970:	lea    0x40(%rsp),%rdi
  262975:	mov    %r9,%r12
  262978:	call   *0x3900ca(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  26297e:	mov    %r12,%r9
  262981:	mov    0x58(%rsp),%r8
  262986:	mov    0x10(%rbp),%rcx
  26298a:	mov    0x60(%rsp),%r12
  26298f:	lea    0x30(%rbp),%rax
  262993:	mov    %rax,0xd8(%rsp)
  26299b:	cmp    %rcx,%r9
  26299e:	jb     2629ca <<glass::engine::Watch>::print_utf8+0x42a>
  2629a0:	cmpl   $0xffffffff,0x28(%rbp)
  2629a4:	je     2629c3 <<glass::engine::Watch>::print_utf8+0x423>
  2629a6:	lea    0x18(%rbp),%rdi
  2629aa:	mov    (%rdi),%rax
  2629ad:	test   %rax,%rax
  2629b0:	je     2629c3 <<glass::engine::Watch>::print_utf8+0x423>
  2629b2:	lock decq (%rax)
  2629b6:	jne    2629c3 <<glass::engine::Watch>::print_utf8+0x423>
  2629b8:	call   *0x39008a(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  2629be:	mov    0x58(%rsp),%r8
  2629c3:	movl   $0xffffffff,0x28(%rbp)
  2629ca:	mov    0x10(%rbp),%rdx
  2629ce:	mov    0x30(%rbp),%rax
  2629d2:	cmp    %r12,%rdx
  2629d5:	mov    %r12,%rsi
  2629d8:	cmovb  %rdx,%rsi
  2629dc:	cmp    %rax,%rsi
  2629df:	cmova  %rsi,%rax
  2629e3:	mov    %rdx,%rcx
  2629e6:	mov    %rax,0x30(%rbp)
  2629ea:	sub    %r12,%rcx
  2629ed:	mov    %rcx,0x30(%rsp)
  2629f2:	jb     263f3e <<glass::engine::Watch>::print_utf8+0x199e>
  2629f8:	mov    0x28(%rsp),%rdx
  2629fd:	cmp    %r13,%rdx
  262a00:	jae    263000 <<glass::engine::Watch>::print_utf8+0xa60>
  262a06:	mov    %rbx,0x98(%rsp)
  262a0e:	mov    %rbp,0xd0(%rsp)
  262a16:	mov    0x8(%rbp),%rcx
  262a1a:	lea    (%r12,%r12,2),%rax
  262a1e:	mov    %rcx,0x70(%rsp)
  262a23:	lea    (%rcx,%rax,8),%rax
  262a27:	mov    %rax,0xb8(%rsp)
  262a2f:	mov    0xc(%rsp),%eax
  262a33:	mov    %eax,%ecx
  262a35:	or     $0x20,%ecx
  262a38:	mov    %ecx,0x8c(%rsp)
  262a3f:	or     $0x40,%eax
  262a42:	mov    %eax,0xa8(%rsp)
  262a49:	mov    $0x1,%al
  262a4b:	mov    %eax,0x90(%rsp)
  262a52:	xor    %r11d,%r11d
  262a55:	xor    %edi,%edi
  262a57:	mov    %r12,%rbx
  262a5a:	mov    %r12,%r10
  262a5d:	mov    0x18(%rsp),%rsi
  262a62:	jmp    262acf <<glass::engine::Watch>::print_utf8+0x52f>
  262a64:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  262a70:	movq   $0x0,(%rbx)
  262a77:	mov    0x78(%rsp),%eax
  262a7b:	mov    %eax,0x8(%rbx)
  262a7e:	mov    0xa0(%rsp),%eax
  262a85:	mov    %eax,0xc(%rbx)
  262a88:	movl   $0x20,0x10(%rbx)
  262a8f:	mov    0xa8(%rsp),%eax
  262a96:	mov    %ax,0x14(%rbx)
  262a9a:	movl   $0x0,0x90(%rsp)
  262aa5:	xor    %r11d,%r11d
  262aa8:	cmp    0x38(%rsp),%r9
  262aad:	setae  %r11b
  262ab1:	mov    %r9,%r10
  262ab4:	sub    %r11,%r10
  262ab7:	inc    %rdi
  262aba:	mov    %r9,%rbx
  262abd:	add    %r15,%rdx
  262ac0:	mov    %ebp,%r8d
  262ac3:	mov    %r15,%r14
  262ac6:	cmp    %r13,%rdx
  262ac9:	jae    26301d <<glass::engine::Watch>::print_utf8+0xa7d>
  262acf:	mov    %rdx,%r15
  262ad2:	movzbl (%rsi,%rdx,1),%ebp
  262ad6:	test   %bpl,%bpl
  262ad9:	js     262b00 <<glass::engine::Watch>::print_utf8+0x560>
  262adb:	mov    $0x1,%edx
  262ae0:	lea    -0x7f(%rbp),%eax
  262ae3:	cmp    $0x21,%eax
  262ae6:	jae    262c68 <<glass::engine::Watch>::print_utf8+0x6c8>
  262aec:	jmp    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262af1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262b00:	lea    0x3e(%rbp),%eax
  262b03:	cmp    $0x1e,%al
  262b05:	jae    262b30 <<glass::engine::Watch>::print_utf8+0x590>
  262b07:	lea    0x1(%r15),%rax
  262b0b:	cmp    %r13,%rax
  262b0e:	jae    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262b14:	movzbl (%rsi,%rax,1),%eax
  262b18:	cmp    $0xc0,%al
  262b1a:	jge    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262b20:	and    $0x1f,%ebp
  262b23:	shl    $0x6,%ebp
  262b26:	mov    $0x2,%edx
  262b2b:	jmp    262c3b <<glass::engine::Watch>::print_utf8+0x69b>
  262b30:	mov    %ebp,%eax
  262b32:	and    $0xf0,%al
  262b34:	cmp    $0xe0,%al
  262b36:	jne    262b50 <<glass::engine::Watch>::print_utf8+0x5b0>
  262b38:	mov    $0xbf,%al
  262b3a:	cmp    $0xe0,%ebp
  262b40:	je     262b73 <<glass::engine::Watch>::print_utf8+0x5d3>
  262b42:	mov    $0x80,%cl
  262b44:	cmp    $0xed,%ebp
  262b4a:	jne    262b75 <<glass::engine::Watch>::print_utf8+0x5d5>
  262b4c:	mov    $0x9f,%al
  262b4e:	jmp    262b75 <<glass::engine::Watch>::print_utf8+0x5d5>
  262b50:	lea    0x10(%rbp),%eax
  262b53:	cmp    $0x5,%al
  262b55:	jae    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262b5b:	mov    $0x80,%al
  262b5d:	cmp    $0xf4,%ebp
  262b63:	je     262bc7 <<glass::engine::Watch>::print_utf8+0x627>
  262b65:	mov    $0xbf,%cl
  262b67:	cmp    $0xf0,%ebp
  262b6d:	jne    262bc9 <<glass::engine::Watch>::print_utf8+0x629>
  262b6f:	mov    $0x90,%al
  262b71:	jmp    262bc9 <<glass::engine::Watch>::print_utf8+0x629>
  262b73:	mov    $0xa0,%cl
  262b75:	lea    0x1(%r15),%rdx
  262b79:	cmp    %r13,%rdx
  262b7c:	jae    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262b82:	movzbl (%rsi,%rdx,1),%edx
  262b86:	cmp    %dl,%cl
  262b88:	ja     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262b8e:	cmp    %al,%dl
  262b90:	ja     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262b96:	lea    0x2(%r15),%rax
  262b9a:	cmp    %r13,%rax
  262b9d:	jae    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262ba3:	movzbl (%rsi,%rax,1),%eax
  262ba7:	cmp    $0xc0,%al
  262ba9:	jge    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262baf:	movzbl %dl,%ecx
  262bb2:	and    $0x3f,%ecx
  262bb5:	shl    $0x6,%ecx
  262bb8:	and    $0xf,%ebp
  262bbb:	shl    $0xc,%ebp
  262bbe:	or     %ecx,%ebp
  262bc0:	mov    $0x3,%edx
  262bc5:	jmp    262c3b <<glass::engine::Watch>::print_utf8+0x69b>
  262bc7:	mov    $0x8f,%cl
  262bc9:	lea    0x1(%r15),%rdx
  262bcd:	cmp    %r13,%rdx
  262bd0:	jae    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262bd6:	movzbl (%rsi,%rdx,1),%edx
  262bda:	cmp    %dl,%al
  262bdc:	ja     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262be2:	cmp    %cl,%dl
  262be4:	ja     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262bea:	lea    0x2(%r15),%rax
  262bee:	cmp    %r13,%rax
  262bf1:	jae    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262bf7:	movzbl (%rsi,%rax,1),%ecx
  262bfb:	cmp    $0xbf,%cl
  262bfe:	jg     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262c04:	lea    0x3(%r15),%rax
  262c08:	cmp    %r13,%rax
  262c0b:	jae    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262c11:	movzbl (%rsi,%rax,1),%eax
  262c15:	cmp    $0xbf,%al
  262c17:	jg     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262c1d:	movzbl %dl,%edx
  262c20:	and    $0x3f,%ecx
  262c23:	shl    $0x6,%ecx
  262c26:	and    $0x3f,%edx
  262c29:	shl    $0xc,%edx
  262c2c:	and    $0x7,%ebp
  262c2f:	shl    $0x12,%ebp
  262c32:	or     %edx,%ebp
  262c34:	or     %ecx,%ebp
  262c36:	mov    $0x4,%edx
  262c3b:	mov    %ebp,%ecx
  262c3d:	xor    $0xd800,%ecx
  262c43:	add    $0xffef0000,%ecx
  262c49:	cmp    $0xffef0800,%ecx
  262c4f:	jb     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262c55:	and    $0x3f,%al
  262c57:	movzbl %al,%eax
  262c5a:	or     %eax,%ebp
  262c5c:	lea    -0x7f(%rbp),%eax
  262c5f:	cmp    $0x21,%eax
  262c62:	jb     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262c68:	cmp    $0xffffffff,%r8d
  262c6c:	je     262c90 <<glass::engine::Watch>::print_utf8+0x6f0>
  262c6e:	lea    -0x20(%r8),%eax
  262c72:	cmp    $0x5f,%eax
  262c75:	jae    262ca0 <<glass::engine::Watch>::print_utf8+0x700>
  262c77:	mov    $0x1,%ecx
  262c7c:	cmpb   $0x0,0x10(%rsp)
  262c81:	jne    262d9b <<glass::engine::Watch>::print_utf8+0x7fb>
  262c87:	jmp    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262c8c:	nopl   0x0(%rax)
  262c90:	mov    %rbx,%r9
  262c93:	jmp    262abd <<glass::engine::Watch>::print_utf8+0x51d>
  262c98:	nopl   0x0(%rax,%rax,1)
  262ca0:	mov    %rbx,0x68(%rsp)
  262ca5:	mov    0x392d0d(%rip),%eax        # 5f59b8 <glass::engine::width_of::CACHE+0x10>
  262cab:	test   %eax,%eax
  262cad:	jne    262f8e <<glass::engine::Watch>::print_utf8+0x9ee>
  262cb3:	mov    %r8d,%ebx
  262cb6:	mov    0x392cf3(%rip),%rsi        # 5f59b0 <glass::engine::width_of::CACHE+0x8>
  262cbd:	cmp    %rbx,%rsi
  262cc0:	jbe    264578 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262cc6:	mov    0x392cdb(%rip),%r12        # 5f59a8 <glass::engine::width_of::CACHE>
  262ccd:	movzbl (%r12,%rbx,1),%eax
  262cd2:	movzbl %al,%ecx
  262cd5:	test   %cl,%cl
  262cd7:	mov    %rdx,0x28(%rsp)
  262cdc:	js     262cf7 <<glass::engine::Watch>::print_utf8+0x757>
  262cde:	mov    $0x1,%dl
  262ce0:	mov    0x18(%rsp),%rsi
  262ce5:	test   %dl,%dl
  262ce7:	mov    0x68(%rsp),%rbx
  262cec:	jne    262d83 <<glass::engine::Watch>::print_utf8+0x7e3>
  262cf2:	jmp    26307d <<glass::engine::Watch>::print_utf8+0xadd>
  262cf7:	cmp    $0xfe,%ecx
  262cfd:	mov    0x18(%rsp),%rsi
  262d02:	je     26309d <<glass::engine::Watch>::print_utf8+0xafd>
  262d08:	mov    $0xfe,%al
  262d0a:	cmp    $0x7f,%r8d
  262d0e:	jae    262d19 <<glass::engine::Watch>::print_utf8+0x779>
  262d10:	mov    $0x1,%ecx
  262d15:	xor    %edx,%edx
  262d17:	jmp    262d72 <<glass::engine::Watch>::print_utf8+0x7d2>
  262d19:	cmp    $0xa0,%r8d
  262d20:	jb     262d70 <<glass::engine::Watch>::print_utf8+0x7d0>
  262d22:	mov    %rdi,0xb0(%rsp)
  262d2a:	mov    %r8d,%edi
  262d2d:	mov    %r8,0x58(%rsp)
  262d32:	mov    %r10,0xe8(%rsp)
  262d3a:	mov    %r11,0xe0(%rsp)
  262d42:	call   2989d0 <unicode_width::tables::lookup_width>
  262d47:	mov    0xe0(%rsp),%r11
  262d4f:	mov    0xe8(%rsp),%r10
  262d57:	mov    0xb0(%rsp),%rdi
  262d5f:	mov    0x58(%rsp),%r8
  262d64:	mov    0x18(%rsp),%rsi
  262d69:	movzbl %al,%ecx
  262d6c:	mov    $0x1,%dl
  262d6e:	jmp    262d72 <<glass::engine::Watch>::print_utf8+0x7d2>
  262d70:	xor    %edx,%edx
  262d72:	mov    %al,(%r12,%rbx,1)
  262d76:	test   %dl,%dl
  262d78:	mov    0x68(%rsp),%rbx
  262d7d:	je     26307d <<glass::engine::Watch>::print_utf8+0xadd>
  262d83:	lea    -0x1(%rcx),%rax
  262d87:	cmp    $0x1,%rax
  262d8b:	mov    0x28(%rsp),%rdx
  262d90:	mov    0x60(%rsp),%r12
  262d95:	ja     263014 <<glass::engine::Watch>::print_utf8+0xa74>
  262d9b:	test   $0x1,%r11b
  262d9f:	jne    26300c <<glass::engine::Watch>::print_utf8+0xa6c>
  262da5:	lea    (%rcx,%r10,1),%rax
  262da9:	cmp    0x38(%rsp),%rax
  262dae:	ja     263011 <<glass::engine::Watch>::print_utf8+0xa71>
  262db4:	mov    %rax,0x58(%rsp)
  262db9:	mov    %rbx,%r9
  262dbc:	mov    %r10,%rbx
  262dbf:	sub    %r12,%rbx
  262dc2:	cmp    0x20(%rsp),%r10
  262dc7:	jae    262e30 <<glass::engine::Watch>::print_utf8+0x890>
  262dc9:	cmp    0x30(%rsp),%rbx
  262dce:	mov    0x70(%rsp),%r11
  262dd3:	jae    2645c1 <<glass::engine::Watch>::print_utf8+0x2021>
  262dd9:	lea    (%r10,%r10,2),%rax
  262ddd:	testb  $0x60,0x14(%r11,%rax,8)
  262de3:	jne    263078 <<glass::engine::Watch>::print_utf8+0xad8>
  262de9:	lea    (%r11,%rax,8),%r12
  262ded:	cmp    $0x2,%rcx
  262df1:	jne    262ec2 <<glass::engine::Watch>::print_utf8+0x922>
  262df7:	lea    0x1(%rbx),%rax
  262dfb:	cmp    0x30(%rsp),%rax
  262e00:	jae    2645df <<glass::engine::Watch>::print_utf8+0x203f>
  262e06:	mov    %r14,%rcx
  262e09:	lea    (%rax,%rax,2),%rax
  262e0d:	mov    $0x1,%r14b
  262e10:	mov    0xb8(%rsp),%r13
  262e18:	testb  $0x60,0x14(%r13,%rax,8)
  262e1e:	mov    0x8c(%rsp),%r13d
  262e26:	je     262e5e <<glass::engine::Watch>::print_utf8+0x8be>
  262e28:	jmp    263082 <<glass::engine::Watch>::print_utf8+0xae2>
  262e2d:	nopl   (%rax)
  262e30:	cmp    0x30(%rsp),%rbx
  262e35:	mov    0x70(%rsp),%r11
  262e3a:	jae    2645f1 <<glass::engine::Watch>::print_utf8+0x2051>
  262e40:	lea    (%r10,%r10,2),%rax
  262e44:	lea    (%r11,%rax,8),%r12
  262e48:	cmp    $0x2,%rcx
  262e4c:	sete   %r14b
  262e50:	mov    0xc(%rsp),%r13d
  262e55:	cmove  0x8c(%rsp),%r13d
  262e5e:	mov    (%r12),%rax
  262e62:	test   %rax,%rax
  262e65:	je     262ee0 <<glass::engine::Watch>::print_utf8+0x940>
  262e67:	lock decq (%rax)
  262e6b:	jne    262ee0 <<glass::engine::Watch>::print_utf8+0x940>
  262e6d:	mov    %rdi,0xb0(%rsp)
  262e75:	mov    %r12,%rdi
  262e78:	mov    %r15,0xe0(%rsp)
  262e80:	mov    %r8,%r15
  262e83:	mov    %rdx,0x28(%rsp)
  262e88:	mov    %r10,0xe8(%rsp)
  262e90:	call   *0x38fbb2(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  262e96:	mov    0x70(%rsp),%r11
  262e9b:	mov    0xe8(%rsp),%r10
  262ea3:	mov    0xb0(%rsp),%rdi
  262eab:	mov    0x28(%rsp),%rdx
  262eb0:	mov    %r15,%r8
  262eb3:	mov    0xe0(%rsp),%r15
  262ebb:	mov    0x18(%rsp),%rsi
  262ec0:	jmp    262ee0 <<glass::engine::Watch>::print_utf8+0x940>
  262ec2:	xor    %r14d,%r14d
  262ec5:	mov    0xc(%rsp),%r13d
  262eca:	mov    (%r12),%rax
  262ece:	test   %rax,%rax
  262ed1:	jne    262e67 <<glass::engine::Watch>::print_utf8+0x8c7>
  262ed3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262ee0:	lea    (%r10,%r10,2),%rax
  262ee4:	movq   $0x0,(%r12)
  262eec:	mov    0x78(%rsp),%ecx
  262ef0:	mov    %ecx,0x8(%r11,%rax,8)
  262ef5:	mov    0xa0(%rsp),%ecx
  262efc:	mov    %ecx,0xc(%r11,%rax,8)
  262f01:	mov    %r13w,0x14(%r11,%rax,8)
  262f07:	mov    %r8d,0x10(%r11,%rax,8)
  262f0c:	test   %r14b,%r14b
  262f0f:	mov    0xc0(%rsp),%r13
  262f17:	mov    0x60(%rsp),%r12
  262f1c:	mov    0x58(%rsp),%r9
  262f21:	je     262aa5 <<glass::engine::Watch>::print_utf8+0x505>
  262f27:	inc    %rbx
  262f2a:	cmp    0x30(%rsp),%rbx
  262f2f:	jae    2645ca <<glass::engine::Watch>::print_utf8+0x202a>
  262f35:	lea    (%rbx,%rbx,2),%rax
  262f39:	mov    0xb8(%rsp),%rcx
  262f41:	lea    (%rcx,%rax,8),%rbx
  262f45:	mov    (%rcx,%rax,8),%rax
  262f49:	test   %rax,%rax
  262f4c:	je     262a70 <<glass::engine::Watch>::print_utf8+0x4d0>
  262f52:	lock decq (%rax)
  262f56:	jne    262a70 <<glass::engine::Watch>::print_utf8+0x4d0>
  262f5c:	mov    %r15,%r13
  262f5f:	mov    %rdi,%r15
  262f62:	mov    %rbx,%rdi
  262f65:	mov    %rdx,%r14
  262f68:	call   *0x38fada(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  262f6e:	mov    0x58(%rsp),%r9
  262f73:	mov    %r15,%rdi
  262f76:	mov    %r13,%r15
  262f79:	mov    0xc0(%rsp),%r13
  262f81:	mov    %r14,%rdx
  262f84:	mov    0x18(%rsp),%rsi
  262f89:	jmp    262a70 <<glass::engine::Watch>::print_utf8+0x4d0>
  262f8e:	mov    %r8,0x58(%rsp)
  262f93:	mov    %r15,0xe0(%rsp)
  262f9b:	mov    %rdx,%r15
  262f9e:	mov    %rdi,0xb0(%rsp)
  262fa6:	mov    %r10,0xe8(%rsp)
  262fae:	mov    %r11,%r12
  262fb1:	call   18bb62 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  262fb6:	mov    %r12,%r11
  262fb9:	mov    0xe8(%rsp),%r10
  262fc1:	mov    0xb0(%rsp),%rdi
  262fc9:	mov    %r15,%rdx
  262fcc:	mov    0xe0(%rsp),%r15
  262fd4:	mov    0x58(%rsp),%r8
  262fd9:	mov    %r8d,%ebx
  262fdc:	mov    0x3929cd(%rip),%rsi        # 5f59b0 <glass::engine::width_of::CACHE+0x8>
  262fe3:	cmp    %rbx,%rsi
  262fe6:	ja     262cc6 <<glass::engine::Watch>::print_utf8+0x726>
  262fec:	jmp    264578 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262ff1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  263000:	xor    %edi,%edi
  263002:	xor    %r11d,%r11d
  263005:	mov    0x18(%rsp),%rsi
  26300a:	jmp    263064 <<glass::engine::Watch>::print_utf8+0xac4>
  26300c:	mov    $0x1,%r11b
  26300f:	jmp    263014 <<glass::engine::Watch>::print_utf8+0xa74>
  263011:	xor    %r11d,%r11d
  263014:	mov    %rbx,%r9
  263017:	mov    %r8d,%ebp
  26301a:	mov    %r15,%rdx
  26301d:	cmp    %r12,%r9
  263020:	jbe    263037 <<glass::engine::Watch>::print_utf8+0xa97>
  263022:	mov    0xd8(%rsp),%rcx
  26302a:	mov    (%rcx),%rax
  26302d:	cmp    %rax,%r9
  263030:	cmova  %r9,%rax
  263034:	mov    %rax,(%rcx)
  263037:	cmp    $0x8,%rdi
  26303b:	setae  %al
  26303e:	testb  $0x1,0x90(%rsp)
  263046:	mov    0xc8(%rsp),%r15
  26304e:	jne    263052 <<glass::engine::Watch>::print_utf8+0xab2>
  263050:	xor    %eax,%eax
  263052:	test   %al,%al
  263054:	jne    2630b2 <<glass::engine::Watch>::print_utf8+0xb12>
  263056:	mov    %r10,%r12
  263059:	mov    %ebp,%r8d
  26305c:	mov    0x98(%rsp),%rbx
  263064:	mov    %r12,0x40(%rbx)
  263068:	mov    %r11b,0x6c(%rbx)
  26306c:	add    %rdi,0xa0(%r15)
  263073:	jmp    263139 <<glass::engine::Watch>::print_utf8+0xb99>
  263078:	xor    %r11d,%r11d
  26307b:	jmp    263017 <<glass::engine::Watch>::print_utf8+0xa77>
  26307d:	mov    %rbx,%r9
  263080:	jmp    2630a2 <<glass::engine::Watch>::print_utf8+0xb02>
  263082:	xor    %r11d,%r11d
  263085:	mov    %r8d,%ebp
  263088:	mov    %r15,%rdx
  26308b:	mov    0xc0(%rsp),%r13
  263093:	mov    %rcx,%r14
  263096:	mov    0x60(%rsp),%r12
  26309b:	jmp    26301d <<glass::engine::Watch>::print_utf8+0xa7d>
  26309d:	mov    0x68(%rsp),%r9
  2630a2:	mov    %r8d,%ebp
  2630a5:	mov    %r15,%rdx
  2630a8:	mov    0x60(%rsp),%r12
  2630ad:	jmp    26301d <<glass::engine::Watch>::print_utf8+0xa7d>
  2630b2:	mov    %rdx,0x28(%rsp)
  2630b7:	movzbl %r11b,%edx
  2630bb:	add    %r10,%rdx
  2630be:	mov    %rdi,0xb0(%rsp)
  2630c6:	mov    0xd0(%rsp),%rdi
  2630ce:	mov    %r12,%rsi
  2630d1:	lea    0xf8(%rsp),%rcx
  2630d9:	mov    %r10,%r12
  2630dc:	mov    %r11,%rbx
  2630df:	call   2a1830 <glass::engine::note_uniform_span>
  2630e4:	mov    %rbx,%r11
  2630e7:	mov    0xb0(%rsp),%rdi
  2630ef:	mov    0x28(%rsp),%rdx
  2630f4:	mov    0x18(%rsp),%rsi
  2630f9:	jmp    263059 <<glass::engine::Watch>::print_utf8+0xab9>
  2630fe:	xchg   %ax,%ax
  263100:	mov    0xc8(%rsp),%r15
  263108:	mov    %r15,%rdi
  26310b:	mov    %ebp,%esi
  26310d:	mov    %r8,%rbx
  263110:	mov    %rdx,%r14
  263113:	call   33d3b0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  263118:	mov    %r14,%rdx
  26311b:	mov    %rbx,%r8
  26311e:	mov    0x18(%rsp),%rsi
  263123:	mov    0x30(%rsp),%r14
  263128:	add    %r14,%rdx
  26312b:	cmpb   $0x0,0x80(%rsp)
  263133:	jne    262650 <<glass::engine::Watch>::print_utf8+0xb0>
  263139:	mov    %r8d,%ebp
  26313c:	mov    %r14,%rbx
  26313f:	mov    %rdx,%r14
  263142:	cmp    %r13,%rdx
  263145:	jae    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  26314b:	movzbl (%rsi,%r14,1),%r8d
  263150:	test   %r8b,%r8b
  263153:	js     263170 <<glass::engine::Watch>::print_utf8+0xbd0>
  263155:	mov    $0x1,%edx
  26315a:	lea    -0x7f(%r8),%eax
  26315e:	cmp    $0x21,%eax
  263161:	jae    2632f8 <<glass::engine::Watch>::print_utf8+0xd58>
  263167:	jmp    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  26316c:	nopl   0x0(%rax)
  263170:	lea    0x3e(%r8),%eax
  263174:	cmp    $0x1e,%al
  263176:	jae    2631b0 <<glass::engine::Watch>::print_utf8+0xc10>
  263178:	lea    0x1(%r14),%rax
  26317c:	cmp    %r13,%rax
  26317f:	jae    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  263185:	movzbl (%rsi,%rax,1),%eax
  263189:	cmp    $0xc0,%al
  26318b:	jge    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  263191:	and    $0x1f,%r8d
  263195:	shl    $0x6,%r8d
  263199:	mov    $0x2,%edx
  26319e:	jmp    2632c8 <<glass::engine::Watch>::print_utf8+0xd28>
  2631a3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2631b0:	mov    %r8d,%eax
  2631b3:	and    $0xf0,%al
  2631b5:	cmp    $0xe0,%al
  2631b7:	jne    2631d3 <<glass::engine::Watch>::print_utf8+0xc33>
  2631b9:	mov    $0xbf,%al
  2631bb:	cmp    $0xe0,%r8d
  2631c2:	je     2631f9 <<glass::engine::Watch>::print_utf8+0xc59>
  2631c4:	mov    $0x80,%cl
  2631c6:	cmp    $0xed,%r8d
  2631cd:	jne    2631fb <<glass::engine::Watch>::print_utf8+0xc5b>
  2631cf:	mov    $0x9f,%al
  2631d1:	jmp    2631fb <<glass::engine::Watch>::print_utf8+0xc5b>
  2631d3:	lea    0x10(%r8),%eax
  2631d7:	cmp    $0x5,%al
  2631d9:	jae    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  2631df:	mov    $0x80,%al
  2631e1:	cmp    $0xf4,%r8d
  2631e8:	je     263250 <<glass::engine::Watch>::print_utf8+0xcb0>
  2631ea:	mov    $0xbf,%cl
  2631ec:	cmp    $0xf0,%r8d
  2631f3:	jne    263252 <<glass::engine::Watch>::print_utf8+0xcb2>
  2631f5:	mov    $0x90,%al
  2631f7:	jmp    263252 <<glass::engine::Watch>::print_utf8+0xcb2>
  2631f9:	mov    $0xa0,%cl
  2631fb:	lea    0x1(%r14),%rdx
  2631ff:	cmp    %r13,%rdx
  263202:	jae    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  263208:	movzbl (%rsi,%rdx,1),%edx
  26320c:	cmp    %dl,%cl
  26320e:	ja     263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  263214:	cmp    %al,%dl
  263216:	ja     263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  26321c:	lea    0x2(%r14),%rax
  263220:	cmp    %r13,%rax
  263223:	jae    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  263229:	movzbl (%rsi,%rax,1),%eax
  26322d:	cmp    $0xc0,%al
  26322f:	jge    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  263235:	movzbl %dl,%ecx
  263238:	and    $0x3f,%ecx
  26323b:	shl    $0x6,%ecx
  26323e:	and    $0xf,%r8d
  263242:	shl    $0xc,%r8d
  263246:	or     %ecx,%r8d
  263249:	mov    $0x3,%edx
  26324e:	jmp    2632c8 <<glass::engine::Watch>::print_utf8+0xd28>
  263250:	mov    $0x8f,%cl
  263252:	lea    0x1(%r14),%rdx
  263256:	cmp    %r13,%rdx
  263259:	jae    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  26325f:	movzbl (%rsi,%rdx,1),%edx
  263263:	cmp    %dl,%al
  263265:	ja     263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  26326b:	cmp    %cl,%dl
  26326d:	ja     263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  263273:	lea    0x2(%r14),%rax
  263277:	cmp    %r13,%rax
  26327a:	jae    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  263280:	movzbl (%rsi,%rax,1),%ecx
  263284:	cmp    $0xbf,%cl
  263287:	jg     263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  26328d:	lea    0x3(%r14),%rax
  263291:	cmp    %r13,%rax
  263294:	jae    263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  26329a:	movzbl (%rsi,%rax,1),%eax
  26329e:	cmp    $0xbf,%al
  2632a0:	jg     263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  2632a6:	movzbl %dl,%edx
  2632a9:	and    $0x3f,%ecx
  2632ac:	shl    $0x6,%ecx
  2632af:	and    $0x3f,%edx
  2632b2:	shl    $0xc,%edx
  2632b5:	and    $0x7,%r8d
  2632b9:	shl    $0x12,%r8d
  2632bd:	or     %edx,%r8d
  2632c0:	or     %ecx,%r8d
  2632c3:	mov    $0x4,%edx
  2632c8:	mov    %r8d,%ecx
  2632cb:	xor    $0xd800,%ecx
  2632d1:	add    $0xffef0000,%ecx
  2632d7:	cmp    $0xffef0800,%ecx
  2632dd:	jb     263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  2632e3:	and    $0x3f,%al
  2632e5:	movzbl %al,%eax
  2632e8:	or     %eax,%r8d
  2632eb:	lea    -0x7f(%r8),%eax
  2632ef:	cmp    $0x21,%eax
  2632f2:	jb     263c1e <<glass::engine::Watch>::print_utf8+0x167e>
  2632f8:	cmp    $0xffffffff,%ebp
  2632fb:	je     263be0 <<glass::engine::Watch>::print_utf8+0x1640>
  263301:	mov    %r14,0x30(%rsp)
  263306:	lea    -0x20(%rbp),%eax
  263309:	cmp    $0x5f,%eax
  26330c:	jae    263330 <<glass::engine::Watch>::print_utf8+0xd90>
  26330e:	mov    $0x1,%r12d
  263314:	cmpb   $0x0,0x10(%rsp)
  263319:	je     263100 <<glass::engine::Watch>::print_utf8+0xb60>
  26331f:	jmp    2633dc <<glass::engine::Watch>::print_utf8+0xe3c>
  263324:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  263330:	cmpb   $0x0,0x80(%rsp)
  263338:	je     263100 <<glass::engine::Watch>::print_utf8+0xb60>
  26333e:	mov    0x392674(%rip),%eax        # 5f59b8 <glass::engine::width_of::CACHE+0x10>
  263344:	test   %eax,%eax
  263346:	jne    263bf6 <<glass::engine::Watch>::print_utf8+0x1656>
  26334c:	mov    %ebp,%ebx
  26334e:	mov    0x39265b(%rip),%rsi        # 5f59b0 <glass::engine::width_of::CACHE+0x8>
  263355:	cmp    %rbx,%rsi
  263358:	jbe    264578 <<glass::engine::Watch>::print_utf8+0x1fd8>
  26335e:	mov    0x392643(%rip),%r14        # 5f59a8 <glass::engine::width_of::CACHE>
  263365:	movzbl (%r14,%rbx,1),%eax
  26336a:	movzbl %al,%r12d
  26336e:	test   %r12b,%r12b
  263371:	js     26337e <<glass::engine::Watch>::print_utf8+0xdde>
  263373:	mov    $0x1,%cl
  263375:	test   %cl,%cl
  263377:	jne    2633cd <<glass::engine::Watch>::print_utf8+0xe2d>
  263379:	jmp    263100 <<glass::engine::Watch>::print_utf8+0xb60>
  26337e:	cmp    $0xfe,%r12d
  263385:	je     263100 <<glass::engine::Watch>::print_utf8+0xb60>
  26338b:	mov    $0xfe,%al
  26338d:	cmp    $0x7f,%ebp
  263390:	jae    26339c <<glass::engine::Watch>::print_utf8+0xdfc>
  263392:	mov    $0x1,%r12d
  263398:	xor    %ecx,%ecx
  26339a:	jmp    2633c1 <<glass::engine::Watch>::print_utf8+0xe21>
  26339c:	cmp    $0xa0,%ebp
  2633a2:	jb     2633bf <<glass::engine::Watch>::print_utf8+0xe1f>
  2633a4:	mov    %ebp,%edi
  2633a6:	mov    %r8,%r15
  2633a9:	mov    %rdx,%r12
  2633ac:	call   2989d0 <unicode_width::tables::lookup_width>
  2633b1:	mov    %r12,%rdx
  2633b4:	mov    %r15,%r8
  2633b7:	movzbl %al,%r12d
  2633bb:	mov    $0x1,%cl
  2633bd:	jmp    2633c1 <<glass::engine::Watch>::print_utf8+0xe21>
  2633bf:	xor    %ecx,%ecx
  2633c1:	mov    %al,(%r14,%rbx,1)
  2633c5:	test   %cl,%cl
  2633c7:	je     263100 <<glass::engine::Watch>::print_utf8+0xb60>
  2633cd:	lea    -0x1(%r12),%rax
  2633d2:	cmp    $0x1,%rax
  2633d6:	ja     263100 <<glass::engine::Watch>::print_utf8+0xb60>
  2633dc:	mov    0xc8(%rsp),%rax
  2633e4:	mov    0x78(%rax),%r9
  2633e8:	cmpb   $0x0,0x6c(%r9)
  2633ed:	jne    263100 <<glass::engine::Watch>::print_utf8+0xb60>
  2633f3:	mov    0x40(%r9),%rbx
  2633f7:	mov    0xa0(%r9),%r11
  2633fe:	lea    (%rbx,%r12,1),%r10
  263402:	cmp    %r11,%r10
  263405:	ja     263100 <<glass::engine::Watch>::print_utf8+0xb60>
  26340b:	mov    0x30(%r9),%eax
  26340f:	sub    0x48(%r9),%eax
  263413:	cltq
  263415:	mov    0x20(%r9),%rsi
  263419:	mov    0x28(%r9),%rcx
  26341d:	lea    (%rcx,%rax,1),%rdi
  263421:	dec    %rdi
  263424:	cmp    %rsi,%rdi
  263427:	mov    $0x0,%eax
  26342c:	cmovae %rsi,%rax
  263430:	sub    %rax,%rdi
  263433:	cmp    %rsi,%rdi
  263436:	jae    26461b <<glass::engine::Watch>::print_utf8+0x207b>
  26343c:	mov    0x58(%r9),%eax
  263440:	mov    %eax,0x58(%rsp)
  263444:	mov    0x5c(%r9),%eax
  263448:	mov    %eax,0xa0(%rsp)
  26344f:	movzwl 0x64(%r9),%r14d
  263454:	mov    0x18(%r9),%rax
  263458:	shl    $0x6,%rdi
  26345c:	lea    (%rax,%rdi,1),%r15
  263460:	lea    (%rax,%rdi,1),%rcx
  263464:	add    $0x18,%rcx
  263468:	mov    %rcx,0x78(%rsp)
  26346d:	mov    0x28(%rax,%rdi,1),%eax
  263471:	cmp    $0xffffffff,%eax
  263474:	je     263481 <<glass::engine::Watch>::print_utf8+0xee1>
  263476:	mov    0x78(%rsp),%rcx
  26347b:	cmp    0x30(%r15),%rbx
  26347f:	jae    26349a <<glass::engine::Watch>::print_utf8+0xefa>
  263481:	mov    0x10(%r15),%rsi
  263485:	cmp    %rsi,%rbx
  263488:	jae    264628 <<glass::engine::Watch>::print_utf8+0x2088>
  26348e:	lea    (%rbx,%rbx,2),%rcx
  263492:	shl    $0x3,%rcx
  263496:	add    0x8(%r15),%rcx
  26349a:	testb  $0x60,0x14(%rcx)
  26349e:	jne    263100 <<glass::engine::Watch>::print_utf8+0xb60>
  2634a4:	cmp    $0x2,%r12
  2634a8:	jne    2634e1 <<glass::engine::Watch>::print_utf8+0xf41>
  2634aa:	lea    0x1(%rbx),%rdi
  2634ae:	cmp    $0xffffffff,%eax
  2634b1:	je     2634be <<glass::engine::Watch>::print_utf8+0xf1e>
  2634b3:	mov    0x78(%rsp),%rcx
  2634b8:	cmp    0x30(%r15),%rdi
  2634bc:	jae    2634d7 <<glass::engine::Watch>::print_utf8+0xf37>
  2634be:	mov    0x10(%r15),%rsi
  2634c2:	cmp    %rsi,%rdi
  2634c5:	jae    26464c <<glass::engine::Watch>::print_utf8+0x20ac>
  2634cb:	lea    (%rdi,%rdi,2),%rcx
  2634cf:	shl    $0x3,%rcx
  2634d3:	add    0x8(%r15),%rcx
  2634d7:	testb  $0x60,0x14(%rcx)
  2634db:	jne    263100 <<glass::engine::Watch>::print_utf8+0xb60>
  2634e1:	mov    %rdx,0x28(%rsp)
  2634e6:	cmp    %ebx,0x38(%r15)
  2634ea:	jbe    2634f0 <<glass::engine::Watch>::print_utf8+0xf50>
  2634ec:	mov    %ebx,0x38(%r15)
  2634f0:	mov    %r14d,0xc(%rsp)
  2634f5:	mov    %r11,0x90(%rsp)
  2634fd:	cmp    $0xffffffff,%eax
  263500:	setne  %dl
  263503:	mov    0x30(%r15),%rcx
  263507:	cmp    %rcx,%rbx
  26350a:	sete   %sil
  26350e:	test   %sil,%dl
  263511:	mov    %rbx,0x20(%rsp)
  263516:	mov    %r15,0x38(%rsp)
  26351b:	mov    %r9,0x60(%rsp)
  263520:	mov    %r10,0x70(%rsp)
  263525:	jne    26359e <<glass::engine::Watch>::print_utf8+0xffe>
  263527:	cmp    $0xffffffff,%eax
  26352a:	mov    0x30(%rsp),%r14
  26352f:	je     2637ed <<glass::engine::Watch>::print_utf8+0x124d>
  263535:	mov    0x10(%r15),%rax
  263539:	cmp    %rcx,%rax
  26353c:	mov    %rcx,%rdx
  26353f:	cmovb  %rax,%rdx
  263543:	mov    %rdx,0xa8(%rsp)
  26354b:	cmp    %rbx,%rax
  26354e:	mov    %rbx,%rsi
  263551:	cmovb  %rax,%rsi
  263555:	mov    0x38f5a4(%rip),%rdx        # 5f2b00 <_DYNAMIC+0x320>
  26355c:	movzbl (%rdx),%edx
  26355f:	test   %dl,%dl
  263561:	je     26360b <<glass::engine::Watch>::print_utf8+0x106b>
  263567:	mov    0x38f5ca(%rip),%rdx        # 5f2b38 <_DYNAMIC+0x358>
  26356e:	mov    %rsi,%r11
  263571:	cmp    %rsi,%rcx
  263574:	jae    26357d <<glass::engine::Watch>::print_utf8+0xfdd>
  263576:	mov    0x38f5c3(%rip),%rdx        # 5f2b40 <_DYNAMIC+0x360>
  26357d:	lock incq 0x28(%rdx)
  263582:	mov    0x38f58f(%rip),%rdx        # 5f2b18 <_DYNAMIC+0x338>
  263589:	lock incq (%rdx)
  26358d:	mov    %r11,%rdx
  263590:	sub    0xa8(%rsp),%rdx
  263598:	jne    2635bd <<glass::engine::Watch>::print_utf8+0x101d>
  26359a:	xor    %esi,%esi
  26359c:	jmp    2635fc <<glass::engine::Watch>::print_utf8+0x105c>
  26359e:	lea    0x1(%rbx),%rax
  2635a2:	mov    %rax,0x30(%r15)
  2635a6:	mov    0x10(%r15),%rsi
  2635aa:	cmp    %rsi,%rbx
  2635ad:	mov    0x30(%rsp),%r14
  2635b2:	jb     26380d <<glass::engine::Watch>::print_utf8+0x126d>
  2635b8:	jmp    264659 <<glass::engine::Watch>::print_utf8+0x20b9>
  2635bd:	mov    0x38f55c(%rip),%rsi        # 5f2b20 <_DYNAMIC+0x340>
  2635c4:	lock add %rdx,(%rsi)
  2635c8:	cmp    $0x5,%rdx
  2635cc:	jae    2635dc <<glass::engine::Watch>::print_utf8+0x103c>
  2635ce:	lea    -0x2059c5(%rip),%rsi        # 5dc10 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2635d5:	movzbl -0x1(%rdx,%rsi,1),%esi
  2635da:	jmp    2635fc <<glass::engine::Watch>::print_utf8+0x105c>
  2635dc:	lea    -0x5(%rdx),%rdi
  2635e0:	mov    $0x4,%esi
  2635e5:	cmp    $0x4,%rdi
  2635e9:	jb     2635fc <<glass::engine::Watch>::print_utf8+0x105c>
  2635eb:	add    $0xfffffffffffffff7,%rdx
  2635ef:	cmp    $0x8,%rdx
  2635f3:	mov    $0x6,%esi
  2635f8:	sbb    $0x0,%rsi
  2635fc:	mov    0x38f50d(%rip),%rdx        # 5f2b10 <_DYNAMIC+0x330>
  263603:	lock incq (%rdx,%rsi,8)
  263608:	mov    %r11,%rsi
  26360b:	cmp    %rsi,%rcx
  26360e:	jae    2637ab <<glass::engine::Watch>::print_utf8+0x120b>
  263614:	mov    0x28(%r15),%edi
  263618:	mov    0x20(%r15),%r10d
  26361c:	mov    0x24(%r15),%r11d
  263620:	movzwl 0x2c(%r15),%ecx
  263625:	mov    0x18(%r15),%rax
  263629:	test   %rax,%rax
  26362c:	mov    %rax,0x68(%rsp)
  263631:	je     263666 <<glass::engine::Watch>::print_utf8+0x10c6>
  263633:	lock incq (%rax)
  263637:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  26363d:	mov    0x10(%r15),%rdx
  263641:	mov    %edi,0x50(%rsp)
  263645:	mov    %r10d,0x48(%rsp)
  26364a:	mov    %r11d,0x4c(%rsp)
  26364f:	mov    %ecx,%r9d
  263652:	mov    %cx,0x54(%rsp)
  263657:	mov    %rax,0x40(%rsp)
  26365c:	cmp    %rdx,%rsi
  26365f:	jbe    263681 <<glass::engine::Watch>::print_utf8+0x10e1>
  263661:	jmp    264588 <<glass::engine::Watch>::print_utf8+0x1fe8>
  263666:	mov    %edi,0x50(%rsp)
  26366a:	mov    %r10d,0x48(%rsp)
  26366f:	mov    %r11d,0x4c(%rsp)
  263674:	mov    %cx,0x54(%rsp)
  263679:	mov    %rax,0x40(%rsp)
  26367e:	mov    %ecx,%r9d
  263681:	mov    0xa8(%rsp),%rax
  263689:	lea    0x0(,%rax,8),%rax
  263691:	lea    (%rax,%rax,2),%rax
  263695:	mov    0x8(%r15),%rbx
  263699:	add    %rax,%rbx
  26369c:	mov    %rsi,0xd0(%rsp)
  2636a4:	lea    0x0(,%rsi,8),%rcx
  2636ac:	lea    (%rcx,%rcx,2),%r14
  2636b0:	sub    %rax,%r14
  2636b3:	mov    0x68(%rsp),%rcx
  2636b8:	mov    %edi,0x98(%rsp)
  2636bf:	mov    %r10d,0x8c(%rsp)
  2636c7:	mov    %r11d,0xb8(%rsp)
  2636cf:	mov    %r9w,0xd8(%rsp)
  2636d8:	jmp    2636fd <<glass::engine::Watch>::print_utf8+0x115d>
  2636da:	nopw   0x0(%rax,%rax,1)
  2636e0:	mov    %rcx,(%rbx)
  2636e3:	mov    %r10d,0x8(%rbx)
  2636e7:	mov    %r11d,0xc(%rbx)
  2636eb:	mov    %edi,0x10(%rbx)
  2636ee:	mov    %r9w,0x14(%rbx)
  2636f3:	add    $0x18,%rbx
  2636f7:	add    $0xffffffffffffffe8,%r14
  2636fb:	je     263755 <<glass::engine::Watch>::print_utf8+0x11b5>
  2636fd:	test   %rcx,%rcx
  263700:	je     26370c <<glass::engine::Watch>::print_utf8+0x116c>
  263702:	lock incq (%rcx)
  263706:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  26370c:	mov    (%rbx),%rax
  26370f:	test   %rax,%rax
  263712:	je     2636e0 <<glass::engine::Watch>::print_utf8+0x1140>
  263714:	lock decq (%rax)
  263718:	jne    2636e0 <<glass::engine::Watch>::print_utf8+0x1140>
  26371a:	mov    %rbx,%rdi
  26371d:	mov    %r8,%r15
  263720:	call   *0x38f322(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  263726:	movzwl 0xd8(%rsp),%r9d
  26372f:	mov    0xb8(%rsp),%r11d
  263737:	mov    0x8c(%rsp),%r10d
  26373f:	mov    0x98(%rsp),%edi
  263746:	mov    0x68(%rsp),%rcx
  26374b:	mov    %r15,%r8
  26374e:	mov    0x38(%rsp),%r15
  263753:	jmp    2636e0 <<glass::engine::Watch>::print_utf8+0x1140>
  263755:	mov    0xa8(%rsp),%rax
  26375d:	cmp    %eax,0x38(%r15)
  263761:	mov    0x30(%rsp),%r14
  263766:	mov    0x20(%rsp),%rbx
  26376b:	jbe    263771 <<glass::engine::Watch>::print_utf8+0x11d1>
  26376d:	mov    %eax,0x38(%r15)
  263771:	test   %rcx,%rcx
  263774:	mov    0xd0(%rsp),%rsi
  26377c:	je     2637a7 <<glass::engine::Watch>::print_utf8+0x1207>
  26377e:	lock decq (%rcx)
  263782:	jne    2637a7 <<glass::engine::Watch>::print_utf8+0x1207>
  263784:	lea    0x40(%rsp),%rdi
  263789:	mov    %r8,%rbx
  26378c:	call   *0x38f2b6(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  263792:	mov    0xd0(%rsp),%rsi
  26379a:	mov    %rbx,%r8
  26379d:	mov    0x20(%rsp),%rbx
  2637a2:	mov    0x38(%rsp),%r15
  2637a7:	mov    0x10(%r15),%rax
  2637ab:	cmp    %rax,%rsi
  2637ae:	jb     2637ed <<glass::engine::Watch>::print_utf8+0x124d>
  2637b0:	cmpl   $0xffffffff,0x28(%r15)
  2637b5:	je     2637e5 <<glass::engine::Watch>::print_utf8+0x1245>
  2637b7:	mov    0x78(%rsp),%rax
  2637bc:	mov    (%rax),%rax
  2637bf:	test   %rax,%rax
  2637c2:	je     2637e5 <<glass::engine::Watch>::print_utf8+0x1245>
  2637c4:	lock decq (%rax)
  2637c8:	jne    2637e5 <<glass::engine::Watch>::print_utf8+0x1245>
  2637ca:	mov    0x78(%rsp),%rdi
  2637cf:	mov    %r8,%rbx
  2637d2:	call   *0x38f270(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  2637d8:	mov    %rbx,%r8
  2637db:	mov    0x20(%rsp),%rbx
  2637e0:	mov    0x38(%rsp),%r15
  2637e5:	movl   $0xffffffff,0x28(%r15)
  2637ed:	mov    0x30(%r15),%rax
  2637f1:	lea    0x1(%rbx),%rcx
  2637f5:	cmp    %rax,%rcx
  2637f8:	cmova  %rcx,%rax
  2637fc:	mov    0x10(%r15),%rsi
  263800:	mov    %rax,0x30(%r15)
  263804:	cmp    %rsi,%rbx
  263807:	jae    264669 <<glass::engine::Watch>::print_utf8+0x20c9>
  26380d:	mov    0xc(%rsp),%esi
  263811:	mov    %esi,%eax
  263813:	or     $0x20,%eax
  263816:	cmp    $0x2,%r12
  26381a:	mov    0x8(%r15),%rcx
  26381e:	lea    (%rbx,%rbx,2),%rdx
  263822:	lea    (%rcx,%rdx,8),%rbx
  263826:	mov    %ebp,0x10(%rcx,%rdx,8)
  26382a:	mov    0x58(%rsp),%ebp
  26382e:	mov    %ebp,0x8(%rcx,%rdx,8)
  263832:	cmovne %esi,%eax
  263835:	mov    0xa0(%rsp),%esi
  26383c:	mov    %esi,0xc(%rcx,%rdx,8)
  263840:	mov    %ax,0x14(%rcx,%rdx,8)
  263845:	mov    (%rcx,%rdx,8),%rax
  263849:	test   %rax,%rax
  26384c:	je     263868 <<glass::engine::Watch>::print_utf8+0x12c8>
  26384e:	lock decq (%rax)
  263852:	jne    263868 <<glass::engine::Watch>::print_utf8+0x12c8>
  263854:	mov    %rbx,%rdi
  263857:	mov    %r8,%r15
  26385a:	call   *0x38f1e8(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  263860:	mov    %r15,%r8
  263863:	mov    0x38(%rsp),%r15
  263868:	movq   $0x0,(%rbx)
  26386f:	cmp    $0x2,%r12
  263873:	mov    0x28(%rsp),%rdx
  263878:	jne    263ba8 <<glass::engine::Watch>::print_utf8+0x1608>
  26387e:	mov    0x20(%rsp),%r9
  263883:	lea    0x1(%r9),%r12
  263887:	mov    0x30(%r15),%rax
  26388b:	mov    0x28(%r15),%ecx
  26388f:	cmp    %rax,%r12
  263892:	jne    2638b3 <<glass::engine::Watch>::print_utf8+0x1313>
  263894:	cmp    $0xffffffff,%ecx
  263897:	je     2638b3 <<glass::engine::Watch>::print_utf8+0x1313>
  263899:	add    $0x2,%r9
  26389d:	mov    %r9,0x30(%r15)
  2638a1:	mov    0x10(%r15),%rsi
  2638a5:	cmp    %rsi,%r12
  2638a8:	jb     263b4f <<glass::engine::Watch>::print_utf8+0x15af>
  2638ae:	jmp    263f2e <<glass::engine::Watch>::print_utf8+0x198e>
  2638b3:	cmp    $0xffffffff,%ecx
  2638b6:	je     263b2f <<glass::engine::Watch>::print_utf8+0x158f>
  2638bc:	mov    0x10(%r15),%rcx
  2638c0:	cmp    %rax,%rcx
  2638c3:	mov    %rax,%rdi
  2638c6:	cmovb  %rcx,%rdi
  2638ca:	cmp    %r12,%rcx
  2638cd:	mov    %r12,%r10
  2638d0:	cmovb  %rcx,%r10
  2638d4:	mov    0x38f225(%rip),%rdx        # 5f2b00 <_DYNAMIC+0x320>
  2638db:	movzbl (%rdx),%edx
  2638de:	test   %dl,%dl
  2638e0:	je     26395c <<glass::engine::Watch>::print_utf8+0x13bc>
  2638e2:	mov    0x38f24f(%rip),%rdx        # 5f2b38 <_DYNAMIC+0x358>
  2638e9:	cmp    %r10,%rax
  2638ec:	jae    2638f5 <<glass::engine::Watch>::print_utf8+0x1355>
  2638ee:	mov    0x38f24b(%rip),%rdx        # 5f2b40 <_DYNAMIC+0x360>
  2638f5:	lock incq 0x28(%rdx)
  2638fa:	mov    0x38f217(%rip),%rdx        # 5f2b18 <_DYNAMIC+0x338>
  263901:	lock incq (%rdx)
  263905:	mov    %r10,%rdx
  263908:	sub    %rdi,%rdx
  26390b:	jne    263911 <<glass::engine::Watch>::print_utf8+0x1371>
  26390d:	xor    %esi,%esi
  26390f:	jmp    263950 <<glass::engine::Watch>::print_utf8+0x13b0>
  263911:	mov    0x38f208(%rip),%rsi        # 5f2b20 <_DYNAMIC+0x340>
  263918:	lock add %rdx,(%rsi)
  26391c:	cmp    $0x5,%rdx
  263920:	jae    263930 <<glass::engine::Watch>::print_utf8+0x1390>
  263922:	lea    -0x205d19(%rip),%rsi        # 5dc10 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263929:	movzbl -0x1(%rdx,%rsi,1),%esi
  26392e:	jmp    263950 <<glass::engine::Watch>::print_utf8+0x13b0>
  263930:	lea    -0x5(%rdx),%r11
  263934:	mov    $0x4,%esi
  263939:	cmp    $0x4,%r11
  26393d:	jb     263950 <<glass::engine::Watch>::print_utf8+0x13b0>
  26393f:	add    $0xfffffffffffffff7,%rdx
  263943:	cmp    $0x8,%rdx
  263947:	mov    $0x6,%esi
  26394c:	sbb    $0x0,%rsi
  263950:	mov    0x38f1b9(%rip),%rdx        # 5f2b10 <_DYNAMIC+0x330>
  263957:	lock incq (%rdx,%rsi,8)
  26395c:	cmp    %r10,%rax
  26395f:	mov    0x28(%rsp),%rdx
  263964:	jae    263b08 <<glass::engine::Watch>::print_utf8+0x1568>
  26396a:	mov    %r12,0xd8(%rsp)
  263972:	mov    0x28(%r15),%r9d
  263976:	mov    0x20(%r15),%r11d
  26397a:	mov    0x24(%r15),%ebp
  26397e:	movzwl 0x2c(%r15),%eax
  263983:	mov    0x18(%r15),%r12
  263987:	test   %r12,%r12
  26398a:	mov    %r12,0x98(%rsp)
  263992:	mov    %ax,0x68(%rsp)
  263997:	je     2639cd <<glass::engine::Watch>::print_utf8+0x142d>
  263999:	lock incq (%r12)
  26399e:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  2639a4:	mov    0x10(%r15),%rdx
  2639a8:	mov    %r9d,0x50(%rsp)
  2639ad:	mov    %r11d,0x48(%rsp)
  2639b2:	mov    %ebp,0x4c(%rsp)
  2639b6:	mov    %ax,0x54(%rsp)
  2639bb:	mov    %r12,0x40(%rsp)
  2639c0:	cmp    %rdx,%r10
  2639c3:	mov    %r10,%rsi
  2639c6:	jbe    2639e8 <<glass::engine::Watch>::print_utf8+0x1448>
  2639c8:	jmp    2645a2 <<glass::engine::Watch>::print_utf8+0x2002>
  2639cd:	mov    %r9d,0x50(%rsp)
  2639d2:	mov    %r11d,0x48(%rsp)
  2639d7:	mov    %ebp,0x4c(%rsp)
  2639db:	mov    %ax,0x54(%rsp)
  2639e0:	mov    %r12,0x40(%rsp)
  2639e5:	mov    %r10,%rsi
  2639e8:	mov    %rdi,0xa8(%rsp)
  2639f0:	lea    0x0(,%rdi,8),%rax
  2639f8:	lea    (%rax,%rax,2),%rax
  2639fc:	mov    0x8(%r15),%rbx
  263a00:	add    %rax,%rbx
  263a03:	mov    %rsi,0xb8(%rsp)
  263a0b:	lea    0x0(,%rsi,8),%rcx
  263a13:	lea    (%rcx,%rcx,2),%r14
  263a17:	sub    %rax,%r14
  263a1a:	movzwl 0x68(%rsp),%ecx
  263a1f:	mov    %ebp,0x8c(%rsp)
  263a26:	jmp    263a4c <<glass::engine::Watch>::print_utf8+0x14ac>
  263a28:	nopl   0x0(%rax,%rax,1)
  263a30:	mov    %r12,(%rbx)
  263a33:	mov    %r11d,0x8(%rbx)
  263a37:	mov    %ebp,0xc(%rbx)
  263a3a:	mov    %r9d,0x10(%rbx)
  263a3e:	mov    %cx,0x14(%rbx)
  263a42:	add    $0x18,%rbx
  263a46:	add    $0xffffffffffffffe8,%r14
  263a4a:	je     263aa0 <<glass::engine::Watch>::print_utf8+0x1500>
  263a4c:	test   %r12,%r12
  263a4f:	je     263a5c <<glass::engine::Watch>::print_utf8+0x14bc>
  263a51:	lock incq (%r12)
  263a56:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  263a5c:	mov    (%rbx),%rax
  263a5f:	test   %rax,%rax
  263a62:	je     263a30 <<glass::engine::Watch>::print_utf8+0x1490>
  263a64:	lock decq (%rax)
  263a68:	jne    263a30 <<glass::engine::Watch>::print_utf8+0x1490>
  263a6a:	mov    %rbx,%rdi
  263a6d:	mov    %r8,%r15
  263a70:	mov    %r9d,%ebp
  263a73:	mov    %r11d,%r12d
  263a76:	call   *0x38efcc(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  263a7c:	movzwl 0x68(%rsp),%ecx
  263a81:	mov    %r12d,%r11d
  263a84:	mov    0x98(%rsp),%r12
  263a8c:	mov    %ebp,%r9d
  263a8f:	mov    0x8c(%rsp),%ebp
  263a96:	mov    %r15,%r8
  263a99:	mov    0x38(%rsp),%r15
  263a9e:	jmp    263a30 <<glass::engine::Watch>::print_utf8+0x1490>
  263aa0:	mov    0xa8(%rsp),%rax
  263aa8:	cmp    %eax,0x38(%r15)
  263aac:	mov    0x30(%rsp),%r14
  263ab1:	mov    0x28(%rsp),%rdx
  263ab6:	mov    0x20(%rsp),%r9
  263abb:	jbe    263ac1 <<glass::engine::Watch>::print_utf8+0x1521>
  263abd:	mov    %eax,0x38(%r15)
  263ac1:	test   %r12,%r12
  263ac4:	mov    0x58(%rsp),%ebp
  263ac8:	mov    0xb8(%rsp),%r10
  263ad0:	je     263afc <<glass::engine::Watch>::print_utf8+0x155c>
  263ad2:	lock decq (%r12)
  263ad7:	jne    263afc <<glass::engine::Watch>::print_utf8+0x155c>
  263ad9:	lea    0x40(%rsp),%rdi
  263ade:	mov    %r8,%rbx
  263ae1:	call   *0x38ef61(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  263ae7:	mov    0x28(%rsp),%rdx
  263aec:	mov    %rbx,%r8
  263aef:	mov    0xb8(%rsp),%r10
  263af7:	mov    0x20(%rsp),%r9
  263afc:	mov    0x10(%r15),%rcx
  263b00:	mov    0xd8(%rsp),%r12
  263b08:	cmp    %rcx,%r10
  263b0b:	jb     263b2f <<glass::engine::Watch>::print_utf8+0x158f>
  263b0d:	mov    0x78(%rsp),%rdi
  263b12:	mov    %r8,%rbx
  263b15:	call   1ad660 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263b1a:	mov    0x28(%rsp),%rdx
  263b1f:	mov    %rbx,%r8
  263b22:	mov    0x20(%rsp),%r9
  263b27:	movl   $0xffffffff,0x28(%r15)
  263b2f:	mov    0x30(%r15),%rax
  263b33:	add    $0x2,%r9
  263b37:	cmp    %rax,%r9
  263b3a:	cmovbe %rax,%r9
  263b3e:	mov    0x10(%r15),%rsi
  263b42:	mov    %r9,0x30(%r15)
  263b46:	cmp    %rsi,%r12
  263b49:	jae    264679 <<glass::engine::Watch>::print_utf8+0x20d9>
  263b4f:	mov    0x8(%r15),%rax
  263b53:	lea    (%r12,%r12,2),%rcx
  263b57:	lea    (%rax,%rcx,8),%rbx
  263b5b:	movl   $0x20,0x10(%rax,%rcx,8)
  263b63:	mov    %ebp,0x8(%rax,%rcx,8)
  263b67:	mov    0xa0(%rsp),%esi
  263b6e:	mov    %esi,0xc(%rax,%rcx,8)
  263b72:	mov    0xc(%rsp),%esi
  263b76:	or     $0x40,%esi
  263b79:	mov    %si,0x14(%rax,%rcx,8)
  263b7e:	mov    (%rax,%rcx,8),%rax
  263b82:	test   %rax,%rax
  263b85:	je     263ba1 <<glass::engine::Watch>::print_utf8+0x1601>
  263b87:	lock decq (%rax)
  263b8b:	jne    263ba1 <<glass::engine::Watch>::print_utf8+0x1601>
  263b8d:	mov    %rbx,%rdi
  263b90:	mov    %r8,%r15
  263b93:	call   *0x38eeaf(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  263b99:	mov    0x28(%rsp),%rdx
  263b9e:	mov    %r15,%r8
  263ba1:	movq   $0x0,(%rbx)
  263ba8:	mov    0x70(%rsp),%rcx
  263bad:	cmp    0x90(%rsp),%rcx
  263bb5:	mov    0x18(%rsp),%rsi
  263bba:	mov    0x60(%rsp),%rax
  263bbf:	jb     263bc8 <<glass::engine::Watch>::print_utf8+0x1628>
  263bc1:	dec    %rcx
  263bc4:	movb   $0x1,0x6c(%rax)
  263bc8:	mov    %rcx,0x40(%rax)
  263bcc:	mov    0xc8(%rsp),%r15
  263bd4:	incq   0xa0(%r15)
  263bdb:	nopl   0x0(%rax,%rax,1)
  263be0:	add    %r14,%rdx
  263be3:	cmpb   $0x0,0x80(%rsp)
  263beb:	je     263139 <<glass::engine::Watch>::print_utf8+0xb99>
  263bf1:	jmp    262650 <<glass::engine::Watch>::print_utf8+0xb0>
  263bf6:	mov    %r8,%rbx
  263bf9:	mov    %rdx,%r14
  263bfc:	call   18bb62 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263c01:	mov    %r14,%rdx
  263c04:	mov    %rbx,%r8
  263c07:	mov    %ebp,%ebx
  263c09:	mov    0x391da0(%rip),%rsi        # 5f59b0 <glass::engine::width_of::CACHE+0x8>
  263c10:	cmp    %rbx,%rsi
  263c13:	ja     26335e <<glass::engine::Watch>::print_utf8+0xdbe>
  263c19:	jmp    264578 <<glass::engine::Watch>::print_utf8+0x1fd8>
  263c1e:	cmpq   $0x400,0xa0(%r15)
  263c29:	jb     263c54 <<glass::engine::Watch>::print_utf8+0x16b4>
  263c2b:	mov    %r15,%rdi
  263c2e:	call   2649f0 <<glass::engine::Watch>::fold_sentinel>
  263c33:	movq   $0x0,0xa0(%r15)
  263c3e:	mov    0x391d7c(%rip),%eax        # 5f59c0 <glass::engine::run_whole::ON>
  263c44:	test   %eax,%eax
  263c46:	je     263c5e <<glass::engine::Watch>::print_utf8+0x16be>
  263c48:	call   18bc06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  263c4d:	cmp    %r13,%r14
  263c50:	je     263c63 <<glass::engine::Watch>::print_utf8+0x16c3>
  263c52:	jmp    263c93 <<glass::engine::Watch>::print_utf8+0x16f3>
  263c54:	mov    0x391d66(%rip),%eax        # 5f59c0 <glass::engine::run_whole::ON>
  263c5a:	test   %eax,%eax
  263c5c:	jne    263c48 <<glass::engine::Watch>::print_utf8+0x16a8>
  263c5e:	cmp    %r13,%r14
  263c61:	jne    263c93 <<glass::engine::Watch>::print_utf8+0x16f3>
  263c63:	cmpb   $0x0,0x391d5a(%rip)        # 5f59c4 <glass::engine::run_whole::ON+0x4>
  263c6a:	je     263c93 <<glass::engine::Watch>::print_utf8+0x16f3>
  263c6c:	cmp    $0xffffffff,%ebp
  263c6f:	je     263e35 <<glass::engine::Watch>::print_utf8+0x1895>
  263c75:	lea    -0x20(%rbp),%eax
  263c78:	cmp    $0x5f,%eax
  263c7b:	jae    263ca4 <<glass::engine::Watch>::print_utf8+0x1704>
  263c7d:	mov    $0x1,%r13d
  263c83:	cmpb   $0x0,0x10(%rsp)
  263c88:	jne    263d6f <<glass::engine::Watch>::print_utf8+0x17cf>
  263c8e:	jmp    263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263c93:	xor    %eax,%eax
  263c95:	cmp    $0xffffffff,%ebp
  263c98:	cmove  %rax,%rbx
  263c9c:	mov    %rbx,%r13
  263c9f:	jmp    263e35 <<glass::engine::Watch>::print_utf8+0x1895>
  263ca4:	cmpb   $0x0,0x80(%rsp)
  263cac:	je     263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263cb2:	mov    0x391d00(%rip),%eax        # 5f59b8 <glass::engine::width_of::CACHE+0x10>
  263cb8:	test   %eax,%eax
  263cba:	jne    264561 <<glass::engine::Watch>::print_utf8+0x1fc1>
  263cc0:	mov    %ebp,%ebx
  263cc2:	mov    0x391ce7(%rip),%rsi        # 5f59b0 <glass::engine::width_of::CACHE+0x8>
  263cc9:	cmp    %rbx,%rsi
  263ccc:	jbe    264578 <<glass::engine::Watch>::print_utf8+0x1fd8>
  263cd2:	mov    0x391ccf(%rip),%r14        # 5f59a8 <glass::engine::width_of::CACHE>
  263cd9:	movzbl (%r14,%rbx,1),%eax
  263cde:	movzbl %al,%r13d
  263ce2:	test   %r13b,%r13b
  263ce5:	js     263cf2 <<glass::engine::Watch>::print_utf8+0x1752>
  263ce7:	mov    $0x1,%cl
  263ce9:	test   %cl,%cl
  263ceb:	jne    263d61 <<glass::engine::Watch>::print_utf8+0x17c1>
  263ced:	jmp    263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263cf2:	cmp    $0xfe,%r13d
  263cf9:	je     263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263cff:	mov    $0xfe,%al
  263d01:	cmp    $0x7f,%ebp
  263d04:	jae    263d3c <<glass::engine::Watch>::print_utf8+0x179c>
  263d06:	mov    $0x1,%r13d
  263d0c:	xor    %ecx,%ecx
  263d0e:	jmp    263d55 <<glass::engine::Watch>::print_utf8+0x17b5>
  263d10:	mov    $0x1,%cl
  263d12:	mov    %ecx,0x80(%rsp)
  263d19:	cmpb   $0x0,0x68(%rax)
  263d1d:	jne    263d2f <<glass::engine::Watch>::print_utf8+0x178f>
  263d1f:	cmpb   $0x0,0x69(%rax)
  263d23:	jne    263d2f <<glass::engine::Watch>::print_utf8+0x178f>
  263d25:	cmpb   $0x0,0x6a(%rax)
  263d29:	je     263f4e <<glass::engine::Watch>::print_utf8+0x19ae>
  263d2f:	movl   $0x0,0x10(%rsp)
  263d37:	jmp    2625fe <<glass::engine::Watch>::print_utf8+0x5e>
  263d3c:	cmp    $0xa0,%ebp
  263d42:	jb     263d53 <<glass::engine::Watch>::print_utf8+0x17b3>
  263d44:	mov    %ebp,%edi
  263d46:	call   2989d0 <unicode_width::tables::lookup_width>
  263d4b:	movzbl %al,%r13d
  263d4f:	mov    $0x1,%cl
  263d51:	jmp    263d55 <<glass::engine::Watch>::print_utf8+0x17b5>
  263d53:	xor    %ecx,%ecx
  263d55:	mov    %al,(%r14,%rbx,1)
  263d59:	test   %cl,%cl
  263d5b:	je     263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263d61:	lea    -0x1(%r13),%rax
  263d65:	cmp    $0x1,%rax
  263d69:	ja     263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263d6f:	mov    0x78(%r15),%r14
  263d73:	cmpb   $0x0,0x6c(%r14)
  263d78:	jne    263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263d7e:	mov    0x40(%r14),%r12
  263d82:	mov    0xa0(%r14),%r8
  263d89:	lea    (%r12,%r13,1),%rdx
  263d8d:	cmp    %r8,%rdx
  263d90:	ja     263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263d96:	mov    0x30(%r14),%eax
  263d9a:	sub    0x48(%r14),%eax
  263d9e:	cltq
  263da0:	mov    0x20(%r14),%rsi
  263da4:	mov    0x28(%r14),%rcx
  263da8:	lea    (%rcx,%rax,1),%rdi
  263dac:	dec    %rdi
  263daf:	xor    %eax,%eax
  263db1:	cmp    %rsi,%rdi
  263db4:	cmovae %rsi,%rax
  263db8:	sub    %rax,%rdi
  263dbb:	cmp    %rsi,%rdi
  263dbe:	jae    26461b <<glass::engine::Watch>::print_utf8+0x207b>
  263dc4:	mov    0x58(%r14),%r10d
  263dc8:	mov    0x5c(%r14),%r11d
  263dcc:	movzwl 0x64(%r14),%r9d
  263dd1:	mov    0x18(%r14),%rax
  263dd5:	shl    $0x6,%rdi
  263dd9:	lea    (%rax,%rdi,1),%rbx
  263ddd:	lea    (%rax,%rdi,1),%rcx
  263de1:	add    $0x18,%rcx
  263de5:	mov    %rcx,0x80(%rsp)
  263ded:	mov    0x28(%rax,%rdi,1),%eax
  263df1:	cmp    $0xffffffff,%eax
  263df4:	je     263e04 <<glass::engine::Watch>::print_utf8+0x1864>
  263df6:	mov    0x80(%rsp),%rcx
  263dfe:	cmp    0x30(%rbx),%r12
  263e02:	jae    263e1d <<glass::engine::Watch>::print_utf8+0x187d>
  263e04:	mov    0x10(%rbx),%rsi
  263e08:	cmp    %rsi,%r12
  263e0b:	jae    264689 <<glass::engine::Watch>::print_utf8+0x20e9>
  263e11:	lea    (%r12,%r12,2),%rcx
  263e15:	shl    $0x3,%rcx
  263e19:	add    0x8(%rbx),%rcx
  263e1d:	testb  $0x60,0x14(%rcx)
  263e21:	je     263e4a <<glass::engine::Watch>::print_utf8+0x18aa>
  263e23:	mov    %r15,%rdi
  263e26:	mov    %ebp,%esi
  263e28:	call   33d3b0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  263e2d:	mov    0xc0(%rsp),%r13
  263e35:	mov    %r13,%rax
  263e38:	add    $0x118,%rsp
  263e3f:	pop    %rbx
  263e40:	pop    %r12
  263e42:	pop    %r13
  263e44:	pop    %r14
  263e46:	pop    %r15
  263e48:	pop    %rbp
  263e49:	ret
  263e4a:	cmp    $0x2,%r13
  263e4e:	jne    263e87 <<glass::engine::Watch>::print_utf8+0x18e7>
  263e50:	lea    0x1(%r12),%rdi
  263e55:	cmp    $0xffffffff,%eax
  263e58:	je     263e68 <<glass::engine::Watch>::print_utf8+0x18c8>
  263e5a:	mov    0x80(%rsp),%rcx
  263e62:	cmp    0x30(%rbx),%rdi
  263e66:	jae    263e81 <<glass::engine::Watch>::print_utf8+0x18e1>
  263e68:	mov    0x10(%rbx),%rsi
  263e6c:	cmp    %rsi,%rdi
  263e6f:	jae    26464c <<glass::engine::Watch>::print_utf8+0x20ac>
  263e75:	lea    (%rdi,%rdi,2),%rcx
  263e79:	shl    $0x3,%rcx
  263e7d:	add    0x8(%rbx),%rcx
  263e81:	testb  $0x60,0x14(%rcx)
  263e85:	jne    263e23 <<glass::engine::Watch>::print_utf8+0x1883>
  263e87:	mov    %r11d,0x78(%rsp)
  263e8c:	mov    %r10d,0x28(%rsp)
  263e91:	mov    %r9d,0x30(%rsp)
  263e96:	mov    %r8,0x58(%rsp)
  263e9b:	mov    %rdx,0xa0(%rsp)
  263ea3:	cmp    %r12d,0x38(%rbx)
  263ea7:	jbe    263ead <<glass::engine::Watch>::print_utf8+0x190d>
  263ea9:	mov    %r12d,0x38(%rbx)
  263ead:	cmp    $0xffffffff,%eax
  263eb0:	setne  %cl
  263eb3:	mov    %rbx,%rdi
  263eb6:	mov    0x30(%rbx),%rbx
  263eba:	cmp    %rbx,%r12
  263ebd:	sete   %dl
  263ec0:	test   %dl,%cl
  263ec2:	mov    %rdi,0x18(%rsp)
  263ec7:	jne    263f15 <<glass::engine::Watch>::print_utf8+0x1975>
  263ec9:	cmp    $0xffffffff,%eax
  263ecc:	je     26417f <<glass::engine::Watch>::print_utf8+0x1bdf>
  263ed2:	mov    0x18(%rsp),%rax
  263ed7:	mov    0x10(%rax),%r15
  263edb:	cmp    %rbx,%r15
  263ede:	mov    %rbx,%rax
  263ee1:	cmovb  %r15,%rax
  263ee5:	mov    %rax,0x10(%rsp)
  263eea:	cmp    %r12,%r15
  263eed:	mov    %r12,%rcx
  263ef0:	cmovb  %r15,%rcx
  263ef4:	mov    0x38ec05(%rip),%rax        # 5f2b00 <_DYNAMIC+0x320>
  263efb:	movzbl (%rax),%eax
  263efe:	test   %al,%al
  263f00:	mov    %rcx,0x20(%rsp)
  263f05:	je     263f7c <<glass::engine::Watch>::print_utf8+0x19dc>
  263f07:	cmp    %rcx,%rbx
  263f0a:	jae    263f5e <<glass::engine::Watch>::print_utf8+0x19be>
  263f0c:	mov    0x38ec2d(%rip),%rax        # 5f2b40 <_DYNAMIC+0x360>
  263f13:	jmp    263f65 <<glass::engine::Watch>::print_utf8+0x19c5>
  263f15:	lea    0x1(%r12),%rax
  263f1a:	mov    %rax,0x30(%rdi)
  263f1e:	mov    0x10(%rdi),%rsi
  263f22:	cmp    %rsi,%r12
  263f25:	mov    %rdi,%rdx
  263f28:	jb     2641a5 <<glass::engine::Watch>::print_utf8+0x1c05>
  263f2e:	lea    0x366413(%rip),%rdx        # 5ca348 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  263f35:	mov    %r12,%rdi
  263f38:	call   *0x38eaba(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  263f3e:	lea    0x36635b(%rip),%rcx        # 5ca2a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b20>
  263f45:	mov    %r12,%rdi
  263f48:	call   *0x38ec6a(%rip)        # 5f2bb8 <_DYNAMIC+0x3d8>
  263f4e:	cmpb   $0x0,0x6b(%rax)
  263f52:	sete   %al
  263f55:	mov    %eax,0x10(%rsp)
  263f59:	jmp    2625fe <<glass::engine::Watch>::print_utf8+0x5e>
  263f5e:	mov    0x38ebd3(%rip),%rax        # 5f2b38 <_DYNAMIC+0x358>
  263f65:	lock incq 0x28(%rax)
  263f6a:	mov    %rcx,%rdi
  263f6d:	sub    0x10(%rsp),%rdi
  263f72:	call   2f6f60 <alacritty_terminal::grid::row::fill_census::note>
  263f77:	mov    0x20(%rsp),%rcx
  263f7c:	cmp    %rcx,%rbx
  263f7f:	jae    264159 <<glass::engine::Watch>::print_utf8+0x1bb9>
  263f85:	mov    0x18(%rsp),%rcx
  263f8a:	mov    0x28(%rcx),%edi
  263f8d:	mov    0x20(%rcx),%r8d
  263f91:	mov    0x24(%rcx),%r9d
  263f95:	movzwl 0x2c(%rcx),%r10d
  263f9a:	mov    0x18(%rcx),%rsi
  263f9e:	test   %rsi,%rsi
  263fa1:	mov    %rsi,0x38(%rsp)
  263fa6:	mov    %edi,0xc(%rsp)
  263faa:	mov    %r8d,0x60(%rsp)
  263faf:	mov    %r9d,0x70(%rsp)
  263fb4:	mov    %r10w,0x90(%rsp)
  263fbd:	je     264086 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263fc3:	lock incq (%rsi)
  263fc7:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  263fcd:	mov    0x10(%rcx),%rdx
  263fd1:	mov    %edi,0x50(%rsp)
  263fd5:	mov    %r8d,0x48(%rsp)
  263fda:	mov    %r9d,0x4c(%rsp)
  263fdf:	mov    %r10w,0x54(%rsp)
  263fe5:	mov    %rsi,0x40(%rsp)
  263fea:	mov    0x20(%rsp),%rsi
  263fef:	cmp    %rdx,%rsi
  263ff2:	ja     264607 <<glass::engine::Watch>::print_utf8+0x2067>
  263ff8:	mov    0x10(%rsp),%rax
  263ffd:	lea    0x0(,%rax,8),%rax
  264005:	lea    (%rax,%rax,2),%rax
  264009:	mov    0x8(%rcx),%rbx
  26400d:	add    %rax,%rbx
  264010:	lea    0x0(,%rsi,8),%rcx
  264018:	lea    (%rcx,%rcx,2),%r15
  26401c:	sub    %rax,%r15
  26401f:	mov    0x38(%rsp),%rsi
  264024:	jmp    264047 <<glass::engine::Watch>::print_utf8+0x1aa7>
  264026:	mov    %rsi,(%rbx)
  264029:	mov    %r8d,0x8(%rbx)
  26402d:	mov    %r9d,0xc(%rbx)
  264031:	mov    %edi,0x10(%rbx)
  264034:	mov    %r10w,0x14(%rbx)
  264039:	add    $0x18,%rbx
  26403d:	add    $0xffffffffffffffe8,%r15
  264041:	je     264123 <<glass::engine::Watch>::print_utf8+0x1b83>
  264047:	lock incq (%rsi)
  26404b:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  264051:	mov    (%rbx),%rax
  264054:	test   %rax,%rax
  264057:	je     264026 <<glass::engine::Watch>::print_utf8+0x1a86>
  264059:	lock decq (%rax)
  26405d:	jne    264026 <<glass::engine::Watch>::print_utf8+0x1a86>
  26405f:	mov    %rbx,%rdi
  264062:	call   *0x38e9e0(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  264068:	movzwl 0x90(%rsp),%r10d
  264071:	mov    0x70(%rsp),%r9d
  264076:	mov    0x60(%rsp),%r8d
  26407b:	mov    0xc(%rsp),%edi
  26407f:	mov    0x38(%rsp),%rsi
  264084:	jmp    264026 <<glass::engine::Watch>::print_utf8+0x1a86>
  264086:	mov    %edi,0x50(%rsp)
  26408a:	mov    %r8d,0x48(%rsp)
  26408f:	mov    %r9d,0x4c(%rsp)
  264094:	mov    %r10w,0x54(%rsp)
  26409a:	mov    %rsi,0x40(%rsp)
  26409f:	mov    0x10(%rsp),%rax
  2640a4:	lea    0x0(,%rax,8),%rax
  2640ac:	lea    (%rax,%rax,2),%rax
  2640b0:	mov    0x8(%rcx),%rbx
  2640b4:	add    %rax,%rbx
  2640b7:	mov    0x20(%rsp),%rcx
  2640bc:	lea    0x0(,%rcx,8),%rcx
  2640c4:	lea    (%rcx,%rcx,2),%r15
  2640c8:	sub    %rax,%r15
  2640cb:	jmp    2640ee <<glass::engine::Watch>::print_utf8+0x1b4e>
  2640cd:	movq   $0x0,(%rbx)
  2640d4:	mov    %r8d,0x8(%rbx)
  2640d8:	mov    %r9d,0xc(%rbx)
  2640dc:	mov    %edi,0x10(%rbx)
  2640df:	mov    %r10w,0x14(%rbx)
  2640e4:	add    $0x18,%rbx
  2640e8:	add    $0xffffffffffffffe8,%r15
  2640ec:	je     264123 <<glass::engine::Watch>::print_utf8+0x1b83>
  2640ee:	mov    (%rbx),%rax
  2640f1:	test   %rax,%rax
  2640f4:	je     2640cd <<glass::engine::Watch>::print_utf8+0x1b2d>
  2640f6:	lock decq (%rax)
  2640fa:	jne    2640cd <<glass::engine::Watch>::print_utf8+0x1b2d>
  2640fc:	mov    %rbx,%rdi
  2640ff:	call   *0x38e943(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  264105:	movzwl 0x90(%rsp),%r10d
  26410e:	mov    0x70(%rsp),%r9d
  264113:	mov    0x60(%rsp),%r8d
  264118:	mov    0xc(%rsp),%edi
  26411c:	mov    0x38(%rsp),%rsi
  264121:	jmp    2640cd <<glass::engine::Watch>::print_utf8+0x1b2d>
  264123:	mov    0x18(%rsp),%rbx
  264128:	mov    0x10(%rsp),%rax
  26412d:	cmp    %eax,0x38(%rbx)
  264130:	jbe    264135 <<glass::engine::Watch>::print_utf8+0x1b95>
  264132:	mov    %eax,0x38(%rbx)
  264135:	test   %rsi,%rsi
  264138:	mov    0x20(%rsp),%rcx
  26413d:	je     264155 <<glass::engine::Watch>::print_utf8+0x1bb5>
  26413f:	lock decq (%rsi)
  264143:	jne    264155 <<glass::engine::Watch>::print_utf8+0x1bb5>
  264145:	lea    0x40(%rsp),%rdi
  26414a:	call   *0x38e8f8(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  264150:	mov    0x20(%rsp),%rcx
  264155:	mov    0x10(%rbx),%r15
  264159:	cmp    %r15,%rcx
  26415c:	mov    0xc8(%rsp),%r15
  264164:	jb     26417f <<glass::engine::Watch>::print_utf8+0x1bdf>
  264166:	mov    0x80(%rsp),%rdi
  26416e:	call   1ad660 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  264173:	mov    0x18(%rsp),%rax
  264178:	movl   $0xffffffff,0x28(%rax)
  26417f:	mov    0x18(%rsp),%rdx
  264184:	mov    0x30(%rdx),%rax
  264188:	lea    0x1(%r12),%rcx
  26418d:	cmp    %rax,%rcx
  264190:	cmova  %rcx,%rax
  264194:	mov    0x10(%rdx),%rsi
  264198:	mov    %rax,0x30(%rdx)
  26419c:	cmp    %rsi,%r12
  26419f:	jae    264679 <<glass::engine::Watch>::print_utf8+0x20d9>
  2641a5:	mov    0x30(%rsp),%esi
  2641a9:	mov    %esi,%eax
  2641ab:	or     $0x20,%eax
  2641ae:	cmp    $0x2,%r13
  2641b2:	mov    0x8(%rdx),%rcx
  2641b6:	lea    (%r12,%r12,2),%rdx
  2641ba:	lea    (%rcx,%rdx,8),%rbx
  2641be:	mov    %ebp,0x10(%rcx,%rdx,8)
  2641c2:	mov    0x28(%rsp),%edi
  2641c6:	mov    %edi,0x8(%rcx,%rdx,8)
  2641ca:	cmovne %esi,%eax
  2641cd:	mov    0x78(%rsp),%esi
  2641d1:	mov    %esi,0xc(%rcx,%rdx,8)
  2641d5:	mov    %ax,0x14(%rcx,%rdx,8)
  2641da:	mov    (%rcx,%rdx,8),%rax
  2641de:	test   %rax,%rax
  2641e1:	je     2641f2 <<glass::engine::Watch>::print_utf8+0x1c52>
  2641e3:	lock decq (%rax)
  2641e7:	jne    2641f2 <<glass::engine::Watch>::print_utf8+0x1c52>
  2641e9:	mov    %rbx,%rdi
  2641ec:	call   *0x38e856(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  2641f2:	movq   $0x0,(%rbx)
  2641f9:	cmp    $0x2,%r13
  2641fd:	mov    0xc0(%rsp),%r13
  264205:	jne    264533 <<glass::engine::Watch>::print_utf8+0x1f93>
  26420b:	lea    0x1(%r12),%rcx
  264210:	mov    0x18(%rsp),%rax
  264215:	mov    0x30(%rax),%rbx
  264219:	mov    0x28(%rax),%eax
  26421c:	mov    %rcx,0x38(%rsp)
  264221:	cmp    %rbx,%rcx
  264224:	jne    264257 <<glass::engine::Watch>::print_utf8+0x1cb7>
  264226:	cmp    $0xffffffff,%eax
  264229:	je     264257 <<glass::engine::Watch>::print_utf8+0x1cb7>
  26422b:	add    $0x2,%r12
  26422f:	mov    0x18(%rsp),%rcx
  264234:	mov    %r12,0x30(%rcx)
  264238:	mov    0x10(%rcx),%rsi
  26423c:	mov    0x38(%rsp),%rdi
  264241:	cmp    %rsi,%rdi
  264244:	jb     2644e4 <<glass::engine::Watch>::print_utf8+0x1f44>
  26424a:	lea    0x3660f7(%rip),%rdx        # 5ca348 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  264251:	call   *0x38e7a1(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264257:	cmp    $0xffffffff,%eax
  26425a:	je     2644ba <<glass::engine::Watch>::print_utf8+0x1f1a>
  264260:	mov    0x18(%rsp),%rax
  264265:	mov    0x10(%rax),%r15
  264269:	cmp    %rbx,%r15
  26426c:	mov    %rbx,%rax
  26426f:	cmovb  %r15,%rax
  264273:	mov    %rax,0x10(%rsp)
  264278:	lea    0x1(%r12),%rcx
  26427d:	cmp    %rcx,%r15
  264280:	cmovb  %r15,%rcx
  264284:	mov    0x38e875(%rip),%rax        # 5f2b00 <_DYNAMIC+0x320>
  26428b:	movzbl (%rax),%eax
  26428e:	test   %al,%al
  264290:	mov    %rcx,0x20(%rsp)
  264295:	je     2642c3 <<glass::engine::Watch>::print_utf8+0x1d23>
  264297:	cmp    %rcx,%rbx
  26429a:	jae    2642a5 <<glass::engine::Watch>::print_utf8+0x1d05>
  26429c:	mov    0x38e89d(%rip),%rax        # 5f2b40 <_DYNAMIC+0x360>
  2642a3:	jmp    2642ac <<glass::engine::Watch>::print_utf8+0x1d0c>
  2642a5:	mov    0x38e88c(%rip),%rax        # 5f2b38 <_DYNAMIC+0x358>
  2642ac:	lock incq 0x28(%rax)
  2642b1:	mov    %rcx,%rdi
  2642b4:	sub    0x10(%rsp),%rdi
  2642b9:	call   2f6f60 <alacritty_terminal::grid::row::fill_census::note>
  2642be:	mov    0x20(%rsp),%rcx
  2642c3:	cmp    %rcx,%rbx
  2642c6:	jae    264494 <<glass::engine::Watch>::print_utf8+0x1ef4>
  2642cc:	mov    0x18(%rsp),%rcx
  2642d1:	mov    0x28(%rcx),%edi
  2642d4:	mov    0x20(%rcx),%r8d
  2642d8:	mov    0x24(%rcx),%r9d
  2642dc:	movzwl 0x2c(%rcx),%r10d
  2642e1:	mov    0x18(%rcx),%r15
  2642e5:	test   %r15,%r15
  2642e8:	mov    %edi,0xc(%rsp)
  2642ec:	mov    %r8d,0x60(%rsp)
  2642f1:	mov    %r9d,0x70(%rsp)
  2642f6:	mov    %r10w,0x90(%rsp)
  2642ff:	je     2643be <<glass::engine::Watch>::print_utf8+0x1e1e>
  264305:	lock incq (%r15)
  264309:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  26430f:	mov    0x10(%rcx),%rdx
  264313:	mov    %edi,0x50(%rsp)
  264317:	mov    %r8d,0x48(%rsp)
  26431c:	mov    %r9d,0x4c(%rsp)
  264321:	mov    %r10w,0x54(%rsp)
  264327:	mov    %r15,0x40(%rsp)
  26432c:	mov    0x20(%rsp),%rsi
  264331:	cmp    %rdx,%rsi
  264334:	ja     264638 <<glass::engine::Watch>::print_utf8+0x2098>
  26433a:	mov    0x10(%rsp),%rax
  26433f:	lea    0x0(,%rax,8),%rax
  264347:	lea    (%rax,%rax,2),%rax
  26434b:	mov    0x8(%rcx),%rbx
  26434f:	add    %rax,%rbx
  264352:	lea    0x0(,%rsi,8),%rcx
  26435a:	lea    (%rcx,%rcx,2),%r13
  26435e:	sub    %rax,%r13
  264361:	jmp    264384 <<glass::engine::Watch>::print_utf8+0x1de4>
  264363:	mov    %r15,(%rbx)
  264366:	mov    %r8d,0x8(%rbx)
  26436a:	mov    %r9d,0xc(%rbx)
  26436e:	mov    %edi,0x10(%rbx)
  264371:	mov    %r10w,0x14(%rbx)
  264376:	add    $0x18,%rbx
  26437a:	add    $0xffffffffffffffe8,%r13
  26437e:	je     264456 <<glass::engine::Watch>::print_utf8+0x1eb6>
  264384:	lock incq (%r15)
  264388:	jle    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  26438e:	mov    (%rbx),%rax
  264391:	test   %rax,%rax
  264394:	je     264363 <<glass::engine::Watch>::print_utf8+0x1dc3>
  264396:	lock decq (%rax)
  26439a:	jne    264363 <<glass::engine::Watch>::print_utf8+0x1dc3>
  26439c:	mov    %rbx,%rdi
  26439f:	call   *0x38e6a3(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  2643a5:	movzwl 0x90(%rsp),%r10d
  2643ae:	mov    0x70(%rsp),%r9d
  2643b3:	mov    0x60(%rsp),%r8d
  2643b8:	mov    0xc(%rsp),%edi
  2643bc:	jmp    264363 <<glass::engine::Watch>::print_utf8+0x1dc3>
  2643be:	mov    %edi,0x50(%rsp)
  2643c2:	mov    %r8d,0x48(%rsp)
  2643c7:	mov    %r9d,0x4c(%rsp)
  2643cc:	mov    %r10w,0x54(%rsp)
  2643d2:	mov    %r15,0x40(%rsp)
  2643d7:	mov    0x10(%rsp),%rax
  2643dc:	lea    0x0(,%rax,8),%rax
  2643e4:	lea    (%rax,%rax,2),%rax
  2643e8:	mov    0x8(%rcx),%rbx
  2643ec:	add    %rax,%rbx
  2643ef:	mov    0x20(%rsp),%rcx
  2643f4:	lea    0x0(,%rcx,8),%rcx
  2643fc:	lea    (%rcx,%rcx,2),%r13
  264400:	sub    %rax,%r13
  264403:	jmp    264426 <<glass::engine::Watch>::print_utf8+0x1e86>
  264405:	movq   $0x0,(%rbx)
  26440c:	mov    %r8d,0x8(%rbx)
  264410:	mov    %r9d,0xc(%rbx)
  264414:	mov    %edi,0x10(%rbx)
  264417:	mov    %r10w,0x14(%rbx)
  26441c:	add    $0x18,%rbx
  264420:	add    $0xffffffffffffffe8,%r13
  264424:	je     264456 <<glass::engine::Watch>::print_utf8+0x1eb6>
  264426:	mov    (%rbx),%rax
  264429:	test   %rax,%rax
  26442c:	je     264405 <<glass::engine::Watch>::print_utf8+0x1e65>
  26442e:	lock decq (%rax)
  264432:	jne    264405 <<glass::engine::Watch>::print_utf8+0x1e65>
  264434:	mov    %rbx,%rdi
  264437:	call   *0x38e60b(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  26443d:	movzwl 0x90(%rsp),%r10d
  264446:	mov    0x70(%rsp),%r9d
  26444b:	mov    0x60(%rsp),%r8d
  264450:	mov    0xc(%rsp),%edi
  264454:	jmp    264405 <<glass::engine::Watch>::print_utf8+0x1e65>
  264456:	mov    0x18(%rsp),%rbx
  26445b:	mov    0x10(%rsp),%rax
  264460:	cmp    %eax,0x38(%rbx)
  264463:	jbe    264468 <<glass::engine::Watch>::print_utf8+0x1ec8>
  264465:	mov    %eax,0x38(%rbx)
  264468:	test   %r15,%r15
  26446b:	mov    0xc0(%rsp),%r13
  264473:	mov    0x20(%rsp),%rcx
  264478:	je     264490 <<glass::engine::Watch>::print_utf8+0x1ef0>
  26447a:	lock decq (%r15)
  26447e:	jne    264490 <<glass::engine::Watch>::print_utf8+0x1ef0>
  264480:	lea    0x40(%rsp),%rdi
  264485:	call   *0x38e5bd(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  26448b:	mov    0x20(%rsp),%rcx
  264490:	mov    0x10(%rbx),%r15
  264494:	cmp    %r15,%rcx
  264497:	mov    0xc8(%rsp),%r15
  26449f:	jb     2644ba <<glass::engine::Watch>::print_utf8+0x1f1a>
  2644a1:	mov    0x80(%rsp),%rdi
  2644a9:	call   1ad660 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2644ae:	mov    0x18(%rsp),%rax
  2644b3:	movl   $0xffffffff,0x28(%rax)
  2644ba:	mov    0x18(%rsp),%rcx
  2644bf:	mov    0x30(%rcx),%rax
  2644c3:	add    $0x2,%r12
  2644c7:	cmp    %rax,%r12
  2644ca:	cmovbe %rax,%r12
  2644ce:	mov    0x10(%rcx),%rsi
  2644d2:	mov    %r12,0x30(%rcx)
  2644d6:	mov    0x38(%rsp),%rdi
  2644db:	cmp    %rsi,%rdi
  2644de:	jae    264699 <<glass::engine::Watch>::print_utf8+0x20f9>
  2644e4:	mov    0x8(%rcx),%rax
  2644e8:	lea    (%rdi,%rdi,2),%rcx
  2644ec:	lea    (%rax,%rcx,8),%rbx
  2644f0:	movl   $0x20,0x10(%rax,%rcx,8)
  2644f8:	mov    0x28(%rsp),%edx
  2644fc:	mov    %edx,0x8(%rax,%rcx,8)
  264500:	mov    0x78(%rsp),%edx
  264504:	mov    %edx,0xc(%rax,%rcx,8)
  264508:	mov    0x30(%rsp),%edx
  26450c:	or     $0x40,%edx
  26450f:	mov    %dx,0x14(%rax,%rcx,8)
  264514:	mov    (%rax,%rcx,8),%rax
  264518:	test   %rax,%rax
  26451b:	je     26452c <<glass::engine::Watch>::print_utf8+0x1f8c>
  26451d:	lock decq (%rax)
  264521:	jne    26452c <<glass::engine::Watch>::print_utf8+0x1f8c>
  264523:	mov    %rbx,%rdi
  264526:	call   *0x38e51c(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  26452c:	movq   $0x0,(%rbx)
  264533:	mov    0xa0(%rsp),%rax
  26453b:	cmp    0x58(%rsp),%rax
  264540:	jb     26454a <<glass::engine::Watch>::print_utf8+0x1faa>
  264542:	dec    %rax
  264545:	movb   $0x1,0x6c(%r14)
  26454a:	mov    %rax,0x40(%r14)
  26454e:	incq   0xa0(%r15)
  264555:	mov    %ebp,0xb0(%r15)
  26455c:	jmp    263e35 <<glass::engine::Watch>::print_utf8+0x1895>
  264561:	call   18bb62 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  264566:	mov    %ebp,%ebx
  264568:	mov    0x391441(%rip),%rsi        # 5f59b0 <glass::engine::width_of::CACHE+0x8>
  26456f:	cmp    %rbx,%rsi
  264572:	ja     263cd2 <<glass::engine::Watch>::print_utf8+0x1732>
  264578:	lea    0x367fd1(%rip),%rdx        # 5cc550 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17dd0>
  26457f:	mov    %rbx,%rdi
  264582:	call   *0x38e470(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264588:	lea    0x3651b9(%rip),%rcx        # 5c9748 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  26458f:	mov    0xa8(%rsp),%rdi
  264597:	call   *0x38e61b(%rip)        # 5f2bb8 <_DYNAMIC+0x3d8>
  26459d:	jmp    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  2645a2:	lea    0x36519f(%rip),%rcx        # 5c9748 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  2645a9:	call   *0x38e609(%rip)        # 5f2bb8 <_DYNAMIC+0x3d8>
  2645af:	jmp    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  2645b4:	lea    0x365685(%rip),%rdx        # 5c9c40 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x154c0>
  2645bb:	call   *0x38e437(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  2645c1:	lea    0x365690(%rip),%rax        # 5c9c58 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x154d8>
  2645c8:	jmp    2645e9 <<glass::engine::Watch>::print_utf8+0x2049>
  2645ca:	lea    0x3656cf(%rip),%rdx        # 5c9ca0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15520>
  2645d1:	mov    %rbx,%rdi
  2645d4:	mov    0x30(%rsp),%rsi
  2645d9:	call   *0x38e419(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  2645df:	mov    %rax,%rbx
  2645e2:	lea    0x365687(%rip),%rax        # 5c9c70 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x154f0>
  2645e9:	mov    %rax,0xf0(%rsp)
  2645f1:	mov    %rbx,%rdi
  2645f4:	mov    0x30(%rsp),%rsi
  2645f9:	mov    0xf0(%rsp),%rdx
  264601:	call   *0x38e3f1(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264607:	lea    0x36513a(%rip),%rcx        # 5c9748 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  26460e:	mov    0x10(%rsp),%rdi
  264613:	call   *0x38e59f(%rip)        # 5f2bb8 <_DYNAMIC+0x3d8>
  264619:	jmp    26464a <<glass::engine::Watch>::print_utf8+0x20aa>
  26461b:	lea    0x36579e(%rip),%rdx        # 5c9dc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15640>
  264622:	call   *0x38e3d0(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264628:	lea    0x353739(%rip),%rdx        # 5b7d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  26462f:	mov    %rbx,%rdi
  264632:	call   *0x38e3c0(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264638:	lea    0x365109(%rip),%rcx        # 5c9748 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  26463f:	mov    0x10(%rsp),%rdi
  264644:	call   *0x38e56e(%rip)        # 5f2bb8 <_DYNAMIC+0x3d8>
  26464a:	ud2
  26464c:	lea    0x353715(%rip),%rdx        # 5b7d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264653:	call   *0x38e39f(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264659:	lea    0x365ce8(%rip),%rdx        # 5ca348 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  264660:	mov    %rbx,%rdi
  264663:	call   *0x38e38f(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264669:	lea    0x365cc0(%rip),%rdx        # 5ca330 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bb0>
  264670:	mov    %rbx,%rdi
  264673:	call   *0x38e37f(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264679:	lea    0x365cb0(%rip),%rdx        # 5ca330 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bb0>
  264680:	mov    %r12,%rdi
  264683:	call   *0x38e36f(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264689:	lea    0x3536d8(%rip),%rdx        # 5b7d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264690:	mov    %r12,%rdi
  264693:	call   *0x38e35f(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  264699:	lea    0x365c90(%rip),%rdx        # 5ca330 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bb0>
  2646a0:	call   *0x38e352(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  2646a6:	mov    %rax,%rbx
  2646a9:	lock decq (%r15)
  2646ad:	je     2646d6 <<glass::engine::Watch>::print_utf8+0x2136>
  2646af:	jmp    2646e4 <<glass::engine::Watch>::print_utf8+0x2144>
  2646b1:	mov    %rax,%rbx
  2646b4:	mov    0x38(%rsp),%rax
  2646b9:	jmp    2646d0 <<glass::engine::Watch>::print_utf8+0x2130>
  2646bb:	mov    %rax,%rbx
  2646be:	mov    0x98(%rsp),%rax
  2646c6:	jmp    2646d0 <<glass::engine::Watch>::print_utf8+0x2130>
  2646c8:	mov    %rax,%rbx
  2646cb:	mov    0x68(%rsp),%rax
  2646d0:	lock decq (%rax)
  2646d4:	jne    2646e4 <<glass::engine::Watch>::print_utf8+0x2144>
  2646d6:	mov    0x110(%rsp),%rdi
  2646de:	call   *0x38e364(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  2646e4:	mov    %rbx,%rdi
  2646e7:	call   5b1070 <_Unwind_Resume@plt>
