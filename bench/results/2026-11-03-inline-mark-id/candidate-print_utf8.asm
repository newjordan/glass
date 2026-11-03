
/tmp/glass-inline-mark-id-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000279640 <<glass::engine::Watch>::print_utf8>:
  279640:	push   %rbp
  279641:	push   %r15
  279643:	push   %r14
  279645:	push   %r13
  279647:	push   %r12
  279649:	push   %rbx
  27964a:	sub    $0x108,%rsp
  279651:	mov    %rdx,%r13
  279654:	mov    %rdi,%r15
  279657:	cmpb   $0x1,0xbe(%rdi)
  27965e:	jne    279692 <<glass::engine::Watch>::print_utf8+0x52>
  279660:	cmpq   $0x0,0x38(%r15)
  279665:	jne    279692 <<glass::engine::Watch>::print_utf8+0x52>
  279667:	mov    0x78(%r15),%rax
  27966b:	testb  $0x4,0x6c5(%rax)
  279672:	jne    279692 <<glass::engine::Watch>::print_utf8+0x52>
  279674:	cmpw   $0x0,0x66(%rax)
  279679:	jne    279692 <<glass::engine::Watch>::print_utf8+0x52>
  27967b:	cmpq   $0x0,0x50(%rax)
  279680:	jne    279692 <<glass::engine::Watch>::print_utf8+0x52>
  279682:	movzwl 0x64(%rax),%ecx
  279686:	test   $0x460,%ecx
  27968c:	je     27ae21 <<glass::engine::Watch>::print_utf8+0x17e1>
  279692:	movl   $0x0,0x20(%rsp)
  27969a:	movl   $0x0,0x14(%rsp)
  2796a2:	mov    $0xffffffff,%r8d
  2796a8:	xor    %r14d,%r14d
  2796ab:	lea    0x3882e6(%rip),%rax        # 601998 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161b8>
  2796b2:	mov    %rax,0xf8(%rsp)
  2796ba:	lea    0x88(%rsp),%rax
  2796c2:	mov    %rax,0x100(%rsp)
  2796ca:	xor    %edx,%edx
  2796cc:	mov    %r13,0xa8(%rsp)
  2796d4:	mov    %r15,0xc8(%rsp)
  2796dc:	mov    %rsi,0x70(%rsp)
  2796e1:	cmpb   $0x0,0x14(%rsp)
  2796e6:	je     27a1d6 <<glass::engine::Watch>::print_utf8+0xb96>
  2796ec:	nopl   0x0(%rax)
  2796f0:	mov    0x78(%r15),%rbx
  2796f4:	cmpb   $0x0,0x6c(%rbx)
  2796f8:	jne    27a1d6 <<glass::engine::Watch>::print_utf8+0xb96>
  2796fe:	mov    0x30(%rbx),%eax
  279701:	sub    0x48(%rbx),%eax
  279704:	cltq
  279706:	mov    0x20(%rbx),%rsi
  27970a:	mov    0x28(%rbx),%rcx
  27970e:	lea    (%rcx,%rax,1),%rdi
  279712:	dec    %rdi
  279715:	cmp    %rsi,%rdi
  279718:	mov    $0x0,%eax
  27971d:	cmovae %rsi,%rax
  279721:	sub    %rax,%rdi
  279724:	cmp    %rsi,%rdi
  279727:	jae    27b6ec <<glass::engine::Watch>::print_utf8+0x20ac>
  27972d:	mov    0xa0(%rbx),%rax
  279734:	mov    %rax,0xb8(%rsp)
  27973c:	mov    0x40(%rbx),%r12
  279740:	mov    0x58(%rbx),%eax
  279743:	mov    %eax,0x30(%rsp)
  279747:	mov    0x5c(%rbx),%eax
  27974a:	mov    %eax,0x68(%rsp)
  27974e:	movzwl 0x64(%rbx),%eax
  279752:	mov    %eax,0x28(%rsp)
  279756:	mov    0x18(%rbx),%rax
  27975a:	shl    $0x6,%rdi
  27975e:	lea    (%rax,%rdi,1),%rbp
  279762:	cmp    %r12d,0x38(%rax,%rdi,1)
  279767:	jbe    27976d <<glass::engine::Watch>::print_utf8+0x12d>
  279769:	mov    %r12d,0x38(%rbp)
  27976d:	mov    %rdx,0x18(%rsp)
  279772:	mov    0x28(%rbp),%r10d
  279776:	cmp    $0xffffffff,%r10d
  27977a:	mov    %r12,0x48(%rsp)
  27977f:	je     279843 <<glass::engine::Watch>::print_utf8+0x203>
  279785:	mov    0x30(%rbp),%rax
  279789:	cmp    %rax,%r12
  27978c:	mov    $0x0,%ecx
  279791:	cmovb  %rax,%rcx
  279795:	mov    %rcx,0x40(%rsp)
  27979a:	movl   $0x20,0xf0(%rsp)
  2797a5:	mov    0x30(%rsp),%ecx
  2797a9:	mov    %ecx,0xe8(%rsp)
  2797b0:	mov    0x68(%rsp),%ecx
  2797b4:	mov    %ecx,0xec(%rsp)
  2797bb:	mov    0x28(%rsp),%ecx
  2797bf:	mov    %cx,0xf4(%rsp)
  2797c7:	movq   $0x0,0xe0(%rsp)
  2797d3:	movw   $0x0,0xf6(%rsp)
  2797dd:	mov    0x10(%rbp),%rcx
  2797e1:	cmp    %rax,%rcx
  2797e4:	mov    %rax,%rdx
  2797e7:	cmovb  %rcx,%rdx
  2797eb:	mov    %rdx,0x38(%rsp)
  2797f0:	cmp    %r12,%rcx
  2797f3:	mov    %r12,%rsi
  2797f6:	cmovb  %rcx,%rsi
  2797fa:	mov    0x3b1a17(%rip),%rdx        # 62b218 <_DYNAMIC+0x338>
  279801:	movzbl (%rdx),%edx
  279804:	test   %dl,%dl
  279806:	je     2798e2 <<glass::engine::Watch>::print_utf8+0x2a2>
  27980c:	mov    0x3b1a3d(%rip),%rdx        # 62b250 <_DYNAMIC+0x370>
  279813:	mov    %rsi,%r9
  279816:	cmp    %rsi,%rax
  279819:	jae    279822 <<glass::engine::Watch>::print_utf8+0x1e2>
  27981b:	mov    0x3b1a36(%rip),%rdx        # 62b258 <_DYNAMIC+0x378>
  279822:	lock incq 0x28(%rdx)
  279827:	mov    0x3b1a02(%rip),%rdx        # 62b230 <_DYNAMIC+0x350>
  27982e:	lock incq (%rdx)
  279832:	mov    %r9,%rdx
  279835:	sub    0x38(%rsp),%rdx
  27983a:	jne    279894 <<glass::engine::Watch>::print_utf8+0x254>
  27983c:	xor    %esi,%esi
  27983e:	jmp    2798d3 <<glass::engine::Watch>::print_utf8+0x293>
  279843:	movl   $0x20,0xf0(%rsp)
  27984e:	mov    0x30(%rsp),%eax
  279852:	mov    %eax,0xe8(%rsp)
  279859:	mov    0x68(%rsp),%eax
  27985d:	mov    %eax,0xec(%rsp)
  279864:	mov    0x28(%rsp),%eax
  279868:	mov    %ax,0xf4(%rsp)
  279870:	movq   $0x0,0xe0(%rsp)
  27987c:	movw   $0x0,0xf6(%rsp)
  279886:	movq   $0xffffffffffffffff,0x40(%rsp)
  27988f:	jmp    279a94 <<glass::engine::Watch>::print_utf8+0x454>
  279894:	mov    0x3b199d(%rip),%rsi        # 62b238 <_DYNAMIC+0x358>
  27989b:	lock add %rdx,(%rsi)
  27989f:	cmp    $0x5,%rdx
  2798a3:	jae    2798b3 <<glass::engine::Watch>::print_utf8+0x273>
  2798a5:	lea    -0x21974c(%rip),%rsi        # 60160 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2798ac:	movzbl -0x1(%rdx,%rsi,1),%esi
  2798b1:	jmp    2798d3 <<glass::engine::Watch>::print_utf8+0x293>
  2798b3:	lea    -0x5(%rdx),%rdi
  2798b7:	mov    $0x4,%esi
  2798bc:	cmp    $0x4,%rdi
  2798c0:	jb     2798d3 <<glass::engine::Watch>::print_utf8+0x293>
  2798c2:	add    $0xfffffffffffffff7,%rdx
  2798c6:	cmp    $0x8,%rdx
  2798ca:	mov    $0x6,%esi
  2798cf:	sbb    $0x0,%rsi
  2798d3:	mov    0x3b194e(%rip),%rdx        # 62b228 <_DYNAMIC+0x348>
  2798da:	lock incq (%rdx,%rsi,8)
  2798df:	mov    %r9,%rsi
  2798e2:	cmp    %rsi,%rax
  2798e5:	mov    %r8,(%rsp)
  2798e9:	mov    %rsi,%rax
  2798ec:	jae    279a66 <<glass::engine::Watch>::print_utf8+0x426>
  2798f2:	mov    %rax,0x78(%rsp)
  2798f7:	mov    %rbx,0x58(%rsp)
  2798fc:	mov    %r14,0x8(%rsp)
  279901:	mov    0x20(%rbp),%r13d
  279905:	mov    0x24(%rbp),%esi
  279908:	movzwl 0x2c(%rbp),%edi
  27990c:	mov    0x18(%rbp),%r12
  279910:	test   %r12,%r12
  279913:	je     279920 <<glass::engine::Watch>::print_utf8+0x2e0>
  279915:	lock incq (%r12)
  27991a:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  279920:	movzwl 0x2e(%rbp),%r9d
  279925:	mov    %r10d,0x98(%rsp)
  27992d:	mov    %r13d,0x90(%rsp)
  279935:	mov    %esi,0x94(%rsp)
  27993c:	mov    %di,0x9c(%rsp)
  279944:	mov    %r12,0x88(%rsp)
  27994c:	mov    %r9w,0x9e(%rsp)
  279955:	mov    0x38(%rsp),%rax
  27995a:	lea    0x0(,%rax,8),%rax
  279962:	lea    (%rax,%rax,2),%rax
  279966:	mov    %rbp,0xb0(%rsp)
  27996e:	mov    0x8(%rbp),%rbx
  279972:	add    %rax,%rbx
  279975:	mov    0x78(%rsp),%rcx
  27997a:	lea    0x0(,%rcx,8),%rcx
  279982:	lea    (%rcx,%rcx,2),%r14
  279986:	sub    %rax,%r14
  279989:	mov    %di,0x60(%rsp)
  27998e:	mov    %r9w,0x80(%rsp)
  279997:	jmp    2799c1 <<glass::engine::Watch>::print_utf8+0x381>
  279999:	nopl   0x0(%rax)
  2799a0:	mov    %r12,(%rbx)
  2799a3:	mov    %r13d,0x8(%rbx)
  2799a7:	mov    %esi,0xc(%rbx)
  2799aa:	mov    %r10d,0x10(%rbx)
  2799ae:	mov    %di,0x14(%rbx)
  2799b2:	mov    %r9w,0x16(%rbx)
  2799b7:	add    $0x18,%rbx
  2799bb:	add    $0xffffffffffffffe8,%r14
  2799bf:	je     279a06 <<glass::engine::Watch>::print_utf8+0x3c6>
  2799c1:	test   %r12,%r12
  2799c4:	je     2799d1 <<glass::engine::Watch>::print_utf8+0x391>
  2799c6:	lock incq (%r12)
  2799cb:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  2799d1:	mov    (%rbx),%rax
  2799d4:	test   %rax,%rax
  2799d7:	je     2799a0 <<glass::engine::Watch>::print_utf8+0x360>
  2799d9:	lock decq (%rax)
  2799dd:	jne    2799a0 <<glass::engine::Watch>::print_utf8+0x360>
  2799df:	mov    %rbx,%rdi
  2799e2:	mov    %r10d,%r15d
  2799e5:	mov    %esi,%ebp
  2799e7:	call   *0x3b1763(%rip)        # 62b150 <_DYNAMIC+0x270>
  2799ed:	movzwl 0x80(%rsp),%r9d
  2799f6:	movzwl 0x60(%rsp),%edi
  2799fb:	mov    %ebp,%esi
  2799fd:	mov    %r15d,%r10d
  279a00:	mov    (%rsp),%r8
  279a04:	jmp    2799a0 <<glass::engine::Watch>::print_utf8+0x360>
  279a06:	mov    0xb0(%rsp),%rbp
  279a0e:	mov    0x38(%rsp),%rax
  279a13:	cmp    %eax,0x38(%rbp)
  279a16:	jbe    279a1b <<glass::engine::Watch>::print_utf8+0x3db>
  279a18:	mov    %eax,0x38(%rbp)
  279a1b:	test   %r12,%r12
  279a1e:	mov    0xa8(%rsp),%r13
  279a26:	mov    0xc8(%rsp),%r15
  279a2e:	mov    0x8(%rsp),%r14
  279a33:	mov    0x58(%rsp),%rbx
  279a38:	mov    0x78(%rsp),%rax
  279a3d:	je     279a5d <<glass::engine::Watch>::print_utf8+0x41d>
  279a3f:	lock decq (%r12)
  279a44:	jne    279a5d <<glass::engine::Watch>::print_utf8+0x41d>
  279a46:	lea    0x88(%rsp),%rdi
  279a4e:	call   *0x3b16fc(%rip)        # 62b150 <_DYNAMIC+0x270>
  279a54:	mov    0x78(%rsp),%rax
  279a59:	mov    (%rsp),%r8
  279a5d:	mov    0x10(%rbp),%rcx
  279a61:	mov    0x48(%rsp),%r12
  279a66:	cmp    %rcx,%rax
  279a69:	jb     279a94 <<glass::engine::Watch>::print_utf8+0x454>
  279a6b:	cmpl   $0xffffffff,0x28(%rbp)
  279a6f:	je     279a8d <<glass::engine::Watch>::print_utf8+0x44d>
  279a71:	lea    0x18(%rbp),%rdi
  279a75:	mov    (%rdi),%rax
  279a78:	test   %rax,%rax
  279a7b:	je     279a8d <<glass::engine::Watch>::print_utf8+0x44d>
  279a7d:	lock decq (%rax)
  279a81:	jne    279a8d <<glass::engine::Watch>::print_utf8+0x44d>
  279a83:	call   *0x3b16c7(%rip)        # 62b150 <_DYNAMIC+0x270>
  279a89:	mov    (%rsp),%r8
  279a8d:	movl   $0xffffffff,0x28(%rbp)
  279a94:	mov    0x10(%rbp),%rdx
  279a98:	mov    0x30(%rbp),%rax
  279a9c:	cmp    %r12,%rdx
  279a9f:	mov    %r12,%rsi
  279aa2:	cmovb  %rdx,%rsi
  279aa6:	cmp    %rax,%rsi
  279aa9:	cmova  %rsi,%rax
  279aad:	mov    %rdx,%rcx
  279ab0:	mov    %rax,0x30(%rbp)
  279ab4:	sub    %r12,%rcx
  279ab7:	mov    %rcx,0x8(%rsp)
  279abc:	jb     27b01a <<glass::engine::Watch>::print_utf8+0x19da>
  279ac2:	mov    0x18(%rsp),%rdx
  279ac7:	cmp    %r13,%rdx
  279aca:	jae    27a0a0 <<glass::engine::Watch>::print_utf8+0xa60>
  279ad0:	mov    %rbx,0x58(%rsp)
  279ad5:	mov    %rbp,0xb0(%rsp)
  279add:	mov    0x8(%rbp),%rcx
  279ae1:	lea    (%r12,%r12,2),%rax
  279ae5:	mov    %rcx,0x60(%rsp)
  279aea:	lea    (%rcx,%rax,8),%rax
  279aee:	mov    %rax,0xd8(%rsp)
  279af6:	mov    0x28(%rsp),%eax
  279afa:	mov    %eax,%ecx
  279afc:	or     $0x20,%ecx
  279aff:	mov    %ecx,0x78(%rsp)
  279b03:	or     $0x40,%eax
  279b06:	mov    %eax,0xa0(%rsp)
  279b0d:	mov    $0x1,%al
  279b0f:	mov    %eax,0x80(%rsp)
  279b16:	xor    %r11d,%r11d
  279b19:	xor    %edi,%edi
  279b1b:	mov    %r12,%rbx
  279b1e:	mov    %r12,%r10
  279b21:	mov    0x70(%rsp),%rsi
  279b26:	jmp    279b95 <<glass::engine::Watch>::print_utf8+0x555>
  279b28:	nopl   0x0(%rax,%rax,1)
  279b30:	movq   $0x0,(%rbx)
  279b37:	mov    0x30(%rsp),%eax
  279b3b:	mov    %eax,0x8(%rbx)
  279b3e:	mov    0x68(%rsp),%eax
  279b42:	mov    %eax,0xc(%rbx)
  279b45:	movl   $0x20,0x10(%rbx)
  279b4c:	mov    0xa0(%rsp),%eax
  279b53:	mov    %ax,0x14(%rbx)
  279b57:	movw   $0x0,0x16(%rbx)
  279b5d:	movl   $0x0,0x80(%rsp)
  279b68:	xor    %r11d,%r11d
  279b6b:	cmp    0xb8(%rsp),%r9
  279b73:	setae  %r11b
  279b77:	mov    %r9,%r10
  279b7a:	sub    %r11,%r10
  279b7d:	inc    %rdi
  279b80:	mov    %r9,%rbx
  279b83:	add    %r15,%rdx
  279b86:	mov    %ebp,%r8d
  279b89:	mov    %r15,%r14
  279b8c:	cmp    %r13,%rdx
  279b8f:	jae    27a0bd <<glass::engine::Watch>::print_utf8+0xa7d>
  279b95:	mov    %rdx,%r15
  279b98:	movzbl (%rsi,%rdx,1),%ebp
  279b9c:	test   %bpl,%bpl
  279b9f:	js     279bc0 <<glass::engine::Watch>::print_utf8+0x580>
  279ba1:	mov    $0x1,%edx
  279ba6:	lea    -0x7f(%rbp),%eax
  279ba9:	cmp    $0x21,%eax
  279bac:	jae    279d28 <<glass::engine::Watch>::print_utf8+0x6e8>
  279bb2:	jmp    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279bb7:	nopw   0x0(%rax,%rax,1)
  279bc0:	lea    0x3e(%rbp),%eax
  279bc3:	cmp    $0x1e,%al
  279bc5:	jae    279bf0 <<glass::engine::Watch>::print_utf8+0x5b0>
  279bc7:	lea    0x1(%r15),%rax
  279bcb:	cmp    %r13,%rax
  279bce:	jae    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279bd4:	movzbl (%rsi,%rax,1),%eax
  279bd8:	cmp    $0xc0,%al
  279bda:	jge    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279be0:	and    $0x1f,%ebp
  279be3:	shl    $0x6,%ebp
  279be6:	mov    $0x2,%edx
  279beb:	jmp    279cfb <<glass::engine::Watch>::print_utf8+0x6bb>
  279bf0:	mov    %ebp,%eax
  279bf2:	and    $0xf0,%al
  279bf4:	cmp    $0xe0,%al
  279bf6:	jne    279c10 <<glass::engine::Watch>::print_utf8+0x5d0>
  279bf8:	mov    $0xbf,%al
  279bfa:	cmp    $0xe0,%ebp
  279c00:	je     279c33 <<glass::engine::Watch>::print_utf8+0x5f3>
  279c02:	mov    $0x80,%cl
  279c04:	cmp    $0xed,%ebp
  279c0a:	jne    279c35 <<glass::engine::Watch>::print_utf8+0x5f5>
  279c0c:	mov    $0x9f,%al
  279c0e:	jmp    279c35 <<glass::engine::Watch>::print_utf8+0x5f5>
  279c10:	lea    0x10(%rbp),%eax
  279c13:	cmp    $0x5,%al
  279c15:	jae    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279c1b:	mov    $0x80,%al
  279c1d:	cmp    $0xf4,%ebp
  279c23:	je     279c87 <<glass::engine::Watch>::print_utf8+0x647>
  279c25:	mov    $0xbf,%cl
  279c27:	cmp    $0xf0,%ebp
  279c2d:	jne    279c89 <<glass::engine::Watch>::print_utf8+0x649>
  279c2f:	mov    $0x90,%al
  279c31:	jmp    279c89 <<glass::engine::Watch>::print_utf8+0x649>
  279c33:	mov    $0xa0,%cl
  279c35:	lea    0x1(%r15),%rdx
  279c39:	cmp    %r13,%rdx
  279c3c:	jae    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279c42:	movzbl (%rsi,%rdx,1),%edx
  279c46:	cmp    %dl,%cl
  279c48:	ja     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279c4e:	cmp    %al,%dl
  279c50:	ja     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279c56:	lea    0x2(%r15),%rax
  279c5a:	cmp    %r13,%rax
  279c5d:	jae    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279c63:	movzbl (%rsi,%rax,1),%eax
  279c67:	cmp    $0xc0,%al
  279c69:	jge    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279c6f:	movzbl %dl,%ecx
  279c72:	and    $0x3f,%ecx
  279c75:	shl    $0x6,%ecx
  279c78:	and    $0xf,%ebp
  279c7b:	shl    $0xc,%ebp
  279c7e:	or     %ecx,%ebp
  279c80:	mov    $0x3,%edx
  279c85:	jmp    279cfb <<glass::engine::Watch>::print_utf8+0x6bb>
  279c87:	mov    $0x8f,%cl
  279c89:	lea    0x1(%r15),%rdx
  279c8d:	cmp    %r13,%rdx
  279c90:	jae    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279c96:	movzbl (%rsi,%rdx,1),%edx
  279c9a:	cmp    %dl,%al
  279c9c:	ja     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279ca2:	cmp    %cl,%dl
  279ca4:	ja     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279caa:	lea    0x2(%r15),%rax
  279cae:	cmp    %r13,%rax
  279cb1:	jae    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279cb7:	movzbl (%rsi,%rax,1),%ecx
  279cbb:	cmp    $0xbf,%cl
  279cbe:	jg     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279cc4:	lea    0x3(%r15),%rax
  279cc8:	cmp    %r13,%rax
  279ccb:	jae    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279cd1:	movzbl (%rsi,%rax,1),%eax
  279cd5:	cmp    $0xbf,%al
  279cd7:	jg     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279cdd:	movzbl %dl,%edx
  279ce0:	and    $0x3f,%ecx
  279ce3:	shl    $0x6,%ecx
  279ce6:	and    $0x3f,%edx
  279ce9:	shl    $0xc,%edx
  279cec:	and    $0x7,%ebp
  279cef:	shl    $0x12,%ebp
  279cf2:	or     %edx,%ebp
  279cf4:	or     %ecx,%ebp
  279cf6:	mov    $0x4,%edx
  279cfb:	mov    %ebp,%ecx
  279cfd:	xor    $0xd800,%ecx
  279d03:	add    $0xffef0000,%ecx
  279d09:	cmp    $0xffef0800,%ecx
  279d0f:	jb     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279d15:	and    $0x3f,%al
  279d17:	movzbl %al,%eax
  279d1a:	or     %eax,%ebp
  279d1c:	lea    -0x7f(%rbp),%eax
  279d1f:	cmp    $0x21,%eax
  279d22:	jb     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279d28:	cmp    $0xffffffff,%r8d
  279d2c:	je     279d50 <<glass::engine::Watch>::print_utf8+0x710>
  279d2e:	lea    -0x20(%r8),%eax
  279d32:	cmp    $0x5f,%eax
  279d35:	jae    279d60 <<glass::engine::Watch>::print_utf8+0x720>
  279d37:	mov    $0x1,%ecx
  279d3c:	cmpb   $0x0,0x20(%rsp)
  279d41:	jne    279e53 <<glass::engine::Watch>::print_utf8+0x813>
  279d47:	jmp    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279d4c:	nopl   0x0(%rax)
  279d50:	mov    %rbx,%r9
  279d53:	jmp    279b83 <<glass::engine::Watch>::print_utf8+0x543>
  279d58:	nopl   0x0(%rax,%rax,1)
  279d60:	mov    %rbx,0x38(%rsp)
  279d65:	mov    0x3b5c55(%rip),%eax        # 62f9c0 <glass::engine::width_of::CACHE+0x10>
  279d6b:	test   %eax,%eax
  279d6d:	jne    27a041 <<glass::engine::Watch>::print_utf8+0xa01>
  279d73:	mov    %r8d,%ebx
  279d76:	mov    0x3b5c3b(%rip),%rsi        # 62f9b8 <glass::engine::width_of::CACHE+0x8>
  279d7d:	cmp    %rbx,%rsi
  279d80:	jbe    27b6b0 <<glass::engine::Watch>::print_utf8+0x2070>
  279d86:	mov    0x3b5c23(%rip),%r12        # 62f9b0 <glass::engine::width_of::CACHE>
  279d8d:	movzbl (%r12,%rbx,1),%eax
  279d92:	movzbl %al,%ecx
  279d95:	test   %cl,%cl
  279d97:	mov    %rdx,0x18(%rsp)
  279d9c:	js     279db7 <<glass::engine::Watch>::print_utf8+0x777>
  279d9e:	mov    $0x1,%dl
  279da0:	mov    0x70(%rsp),%rsi
  279da5:	test   %dl,%dl
  279da7:	mov    0x38(%rsp),%rbx
  279dac:	jne    279e3b <<glass::engine::Watch>::print_utf8+0x7fb>
  279db2:	jmp    27a11c <<glass::engine::Watch>::print_utf8+0xadc>
  279db7:	cmp    $0xfe,%ecx
  279dbd:	mov    0x70(%rsp),%rsi
  279dc2:	je     27a13c <<glass::engine::Watch>::print_utf8+0xafc>
  279dc8:	mov    $0xfe,%al
  279dca:	cmp    $0x7f,%r8d
  279dce:	jae    279dd9 <<glass::engine::Watch>::print_utf8+0x799>
  279dd0:	mov    $0x1,%ecx
  279dd5:	xor    %edx,%edx
  279dd7:	jmp    279e2a <<glass::engine::Watch>::print_utf8+0x7ea>
  279dd9:	cmp    $0xa0,%r8d
  279de0:	jb     279e28 <<glass::engine::Watch>::print_utf8+0x7e8>
  279de2:	mov    %rdi,0x50(%rsp)
  279de7:	mov    %r8d,%edi
  279dea:	mov    %r8,(%rsp)
  279dee:	mov    %r10,0xc0(%rsp)
  279df6:	mov    %r11,0xd0(%rsp)
  279dfe:	call   2b02a0 <unicode_width::tables::lookup_width>
  279e03:	mov    0xd0(%rsp),%r11
  279e0b:	mov    0xc0(%rsp),%r10
  279e13:	mov    0x50(%rsp),%rdi
  279e18:	mov    (%rsp),%r8
  279e1c:	mov    0x70(%rsp),%rsi
  279e21:	movzbl %al,%ecx
  279e24:	mov    $0x1,%dl
  279e26:	jmp    279e2a <<glass::engine::Watch>::print_utf8+0x7ea>
  279e28:	xor    %edx,%edx
  279e2a:	mov    %al,(%r12,%rbx,1)
  279e2e:	test   %dl,%dl
  279e30:	mov    0x38(%rsp),%rbx
  279e35:	je     27a11c <<glass::engine::Watch>::print_utf8+0xadc>
  279e3b:	lea    -0x1(%rcx),%rax
  279e3f:	cmp    $0x1,%rax
  279e43:	mov    0x18(%rsp),%rdx
  279e48:	mov    0x48(%rsp),%r12
  279e4d:	ja     27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  279e53:	test   $0x1,%r11b
  279e57:	jne    27a0ac <<glass::engine::Watch>::print_utf8+0xa6c>
  279e5d:	lea    (%rcx,%r10,1),%rax
  279e61:	cmp    0xb8(%rsp),%rax
  279e69:	ja     27a0b1 <<glass::engine::Watch>::print_utf8+0xa71>
  279e6f:	mov    %rax,(%rsp)
  279e73:	mov    %rbx,%r9
  279e76:	mov    %r10,%rbx
  279e79:	sub    %r12,%rbx
  279e7c:	cmp    0x40(%rsp),%r10
  279e81:	jae    279ef0 <<glass::engine::Watch>::print_utf8+0x8b0>
  279e83:	cmp    0x8(%rsp),%rbx
  279e88:	mov    0x60(%rsp),%r11
  279e8d:	jae    27b6f9 <<glass::engine::Watch>::print_utf8+0x20b9>
  279e93:	lea    (%r10,%r10,2),%rax
  279e97:	testb  $0x60,0x14(%r11,%rax,8)
  279e9d:	jne    27a117 <<glass::engine::Watch>::print_utf8+0xad7>
  279ea3:	lea    (%r11,%rax,8),%r12
  279ea7:	cmp    $0x2,%rcx
  279eab:	jne    279f79 <<glass::engine::Watch>::print_utf8+0x939>
  279eb1:	lea    0x1(%rbx),%rax
  279eb5:	cmp    0x8(%rsp),%rax
  279eba:	jae    27b717 <<glass::engine::Watch>::print_utf8+0x20d7>
  279ec0:	mov    %r14,%rcx
  279ec3:	lea    (%rax,%rax,2),%rax
  279ec7:	mov    $0x1,%r14b
  279eca:	mov    0xd8(%rsp),%r13
  279ed2:	testb  $0x60,0x14(%r13,%rax,8)
  279ed8:	mov    0x78(%rsp),%r13d
  279edd:	je     279f1b <<glass::engine::Watch>::print_utf8+0x8db>
  279edf:	jmp    27a121 <<glass::engine::Watch>::print_utf8+0xae1>
  279ee4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  279ef0:	cmp    0x8(%rsp),%rbx
  279ef5:	mov    0x60(%rsp),%r11
  279efa:	jae    27b729 <<glass::engine::Watch>::print_utf8+0x20e9>
  279f00:	lea    (%r10,%r10,2),%rax
  279f04:	lea    (%r11,%rax,8),%r12
  279f08:	cmp    $0x2,%rcx
  279f0c:	sete   %r14b
  279f10:	mov    0x28(%rsp),%r13d
  279f15:	cmove  0x78(%rsp),%r13d
  279f1b:	mov    (%r12),%rax
  279f1f:	test   %rax,%rax
  279f22:	je     279f90 <<glass::engine::Watch>::print_utf8+0x950>
  279f24:	lock decq (%rax)
  279f28:	jne    279f90 <<glass::engine::Watch>::print_utf8+0x950>
  279f2a:	mov    %rdi,0x50(%rsp)
  279f2f:	mov    %r12,%rdi
  279f32:	mov    %r15,0xd0(%rsp)
  279f3a:	mov    %r8,%r15
  279f3d:	mov    %rdx,0x18(%rsp)
  279f42:	mov    %r10,0xc0(%rsp)
  279f4a:	call   *0x3b1200(%rip)        # 62b150 <_DYNAMIC+0x270>
  279f50:	mov    0x60(%rsp),%r11
  279f55:	mov    0xc0(%rsp),%r10
  279f5d:	mov    0x50(%rsp),%rdi
  279f62:	mov    0x18(%rsp),%rdx
  279f67:	mov    %r15,%r8
  279f6a:	mov    0xd0(%rsp),%r15
  279f72:	mov    0x70(%rsp),%rsi
  279f77:	jmp    279f90 <<glass::engine::Watch>::print_utf8+0x950>
  279f79:	xor    %r14d,%r14d
  279f7c:	mov    0x28(%rsp),%r13d
  279f81:	mov    (%r12),%rax
  279f85:	test   %rax,%rax
  279f88:	jne    279f24 <<glass::engine::Watch>::print_utf8+0x8e4>
  279f8a:	nopw   0x0(%rax,%rax,1)
  279f90:	lea    (%r10,%r10,2),%rax
  279f94:	movq   $0x0,(%r12)
  279f9c:	mov    0x30(%rsp),%ecx
  279fa0:	mov    %ecx,0x8(%r11,%rax,8)
  279fa5:	mov    0x68(%rsp),%ecx
  279fa9:	mov    %ecx,0xc(%r11,%rax,8)
  279fae:	mov    %r13w,0x14(%r11,%rax,8)
  279fb4:	movw   $0x0,0x16(%r11,%rax,8)
  279fbc:	mov    %r8d,0x10(%r11,%rax,8)
  279fc1:	test   %r14b,%r14b
  279fc4:	mov    0xa8(%rsp),%r13
  279fcc:	mov    0x48(%rsp),%r12
  279fd1:	mov    (%rsp),%r9
  279fd5:	je     279b68 <<glass::engine::Watch>::print_utf8+0x528>
  279fdb:	inc    %rbx
  279fde:	cmp    0x8(%rsp),%rbx
  279fe3:	jae    27b702 <<glass::engine::Watch>::print_utf8+0x20c2>
  279fe9:	lea    (%rbx,%rbx,2),%rax
  279fed:	mov    0xd8(%rsp),%rcx
  279ff5:	lea    (%rcx,%rax,8),%rbx
  279ff9:	mov    (%rcx,%rax,8),%rax
  279ffd:	test   %rax,%rax
  27a000:	je     279b30 <<glass::engine::Watch>::print_utf8+0x4f0>
  27a006:	lock decq (%rax)
  27a00a:	jne    279b30 <<glass::engine::Watch>::print_utf8+0x4f0>
  27a010:	mov    %r15,%r13
  27a013:	mov    %rdi,%r15
  27a016:	mov    %rbx,%rdi
  27a019:	mov    %rdx,%r14
  27a01c:	call   *0x3b112e(%rip)        # 62b150 <_DYNAMIC+0x270>
  27a022:	mov    (%rsp),%r9
  27a026:	mov    %r15,%rdi
  27a029:	mov    %r13,%r15
  27a02c:	mov    0xa8(%rsp),%r13
  27a034:	mov    %r14,%rdx
  27a037:	mov    0x70(%rsp),%rsi
  27a03c:	jmp    279b30 <<glass::engine::Watch>::print_utf8+0x4f0>
  27a041:	mov    %r8,(%rsp)
  27a045:	mov    %r15,0xd0(%rsp)
  27a04d:	mov    %rdx,%r15
  27a050:	mov    %rdi,0x50(%rsp)
  27a055:	mov    %r10,0xc0(%rsp)
  27a05d:	mov    %r11,%r12
  27a060:	call   195692 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  27a065:	mov    %r12,%r11
  27a068:	mov    0xc0(%rsp),%r10
  27a070:	mov    0x50(%rsp),%rdi
  27a075:	mov    %r15,%rdx
  27a078:	mov    0xd0(%rsp),%r15
  27a080:	mov    (%rsp),%r8
  27a084:	mov    %r8d,%ebx
  27a087:	mov    0x3b592a(%rip),%rsi        # 62f9b8 <glass::engine::width_of::CACHE+0x8>
  27a08e:	cmp    %rbx,%rsi
  27a091:	ja     279d86 <<glass::engine::Watch>::print_utf8+0x746>
  27a097:	jmp    27b6b0 <<glass::engine::Watch>::print_utf8+0x2070>
  27a09c:	nopl   0x0(%rax)
  27a0a0:	xor    %edi,%edi
  27a0a2:	xor    %r11d,%r11d
  27a0a5:	mov    0x70(%rsp),%rsi
  27a0aa:	jmp    27a103 <<glass::engine::Watch>::print_utf8+0xac3>
  27a0ac:	mov    $0x1,%r11b
  27a0af:	jmp    27a0b4 <<glass::engine::Watch>::print_utf8+0xa74>
  27a0b1:	xor    %r11d,%r11d
  27a0b4:	mov    %rbx,%r9
  27a0b7:	mov    %r8d,%ebp
  27a0ba:	mov    %r15,%rdx
  27a0bd:	cmp    %r12,%r9
  27a0c0:	jbe    27a0d9 <<glass::engine::Watch>::print_utf8+0xa99>
  27a0c2:	mov    0xb0(%rsp),%rcx
  27a0ca:	mov    0x30(%rcx),%rax
  27a0ce:	cmp    %rax,%r9
  27a0d1:	cmova  %r9,%rax
  27a0d5:	mov    %rax,0x30(%rcx)
  27a0d9:	cmp    $0x8,%rdi
  27a0dd:	setae  %al
  27a0e0:	testb  $0x1,0x80(%rsp)
  27a0e8:	mov    0xc8(%rsp),%r15
  27a0f0:	jne    27a0f4 <<glass::engine::Watch>::print_utf8+0xab4>
  27a0f2:	xor    %eax,%eax
  27a0f4:	test   %al,%al
  27a0f6:	jne    27a151 <<glass::engine::Watch>::print_utf8+0xb11>
  27a0f8:	mov    %r10,%r12
  27a0fb:	mov    %ebp,%r8d
  27a0fe:	mov    0x58(%rsp),%rbx
  27a103:	mov    %r12,0x40(%rbx)
  27a107:	mov    %r11b,0x6c(%rbx)
  27a10b:	add    %rdi,0xa0(%r15)
  27a112:	jmp    27a1d6 <<glass::engine::Watch>::print_utf8+0xb96>
  27a117:	xor    %r11d,%r11d
  27a11a:	jmp    27a0b7 <<glass::engine::Watch>::print_utf8+0xa77>
  27a11c:	mov    %rbx,%r9
  27a11f:	jmp    27a141 <<glass::engine::Watch>::print_utf8+0xb01>
  27a121:	xor    %r11d,%r11d
  27a124:	mov    %r8d,%ebp
  27a127:	mov    %r15,%rdx
  27a12a:	mov    0xa8(%rsp),%r13
  27a132:	mov    %rcx,%r14
  27a135:	mov    0x48(%rsp),%r12
  27a13a:	jmp    27a0bd <<glass::engine::Watch>::print_utf8+0xa7d>
  27a13c:	mov    0x38(%rsp),%r9
  27a141:	mov    %r8d,%ebp
  27a144:	mov    %r15,%rdx
  27a147:	mov    0x48(%rsp),%r12
  27a14c:	jmp    27a0bd <<glass::engine::Watch>::print_utf8+0xa7d>
  27a151:	mov    %rdx,0x18(%rsp)
  27a156:	movzbl %r11b,%edx
  27a15a:	add    %r10,%rdx
  27a15d:	mov    %rdi,0x50(%rsp)
  27a162:	mov    0xb0(%rsp),%rdi
  27a16a:	mov    %r12,%rsi
  27a16d:	lea    0xe0(%rsp),%rcx
  27a175:	mov    %r10,%r12
  27a178:	mov    %r11,%rbx
  27a17b:	call   2be770 <glass::engine::note_uniform_span>
  27a180:	mov    %rbx,%r11
  27a183:	mov    0x50(%rsp),%rdi
  27a188:	mov    0x18(%rsp),%rdx
  27a18d:	mov    0x70(%rsp),%rsi
  27a192:	jmp    27a0fb <<glass::engine::Watch>::print_utf8+0xabb>
  27a197:	nopw   0x0(%rax,%rax,1)
  27a1a0:	mov    0xc8(%rsp),%r15
  27a1a8:	mov    %r15,%rdi
  27a1ab:	mov    %ebp,%esi
  27a1ad:	mov    %r8,%rbx
  27a1b0:	mov    %rdx,%r14
  27a1b3:	call   359b50 <<glass::engine::Watch as vte::ansi::Handler>::input>
  27a1b8:	mov    %r14,%rdx
  27a1bb:	mov    %rbx,%r8
  27a1be:	mov    0x70(%rsp),%rsi
  27a1c3:	mov    0x8(%rsp),%r14
  27a1c8:	add    %r14,%rdx
  27a1cb:	cmpb   $0x0,0x14(%rsp)
  27a1d0:	jne    2796f0 <<glass::engine::Watch>::print_utf8+0xb0>
  27a1d6:	mov    %r8d,%ebp
  27a1d9:	mov    %r14,%rbx
  27a1dc:	mov    %rdx,%r14
  27a1df:	cmp    %r13,%rdx
  27a1e2:	jae    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a1e8:	movzbl (%rsi,%r14,1),%r8d
  27a1ed:	test   %r8b,%r8b
  27a1f0:	js     27a210 <<glass::engine::Watch>::print_utf8+0xbd0>
  27a1f2:	mov    $0x1,%edx
  27a1f7:	lea    -0x7f(%r8),%eax
  27a1fb:	cmp    $0x21,%eax
  27a1fe:	jae    27a398 <<glass::engine::Watch>::print_utf8+0xd58>
  27a204:	jmp    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a209:	nopl   0x0(%rax)
  27a210:	lea    0x3e(%r8),%eax
  27a214:	cmp    $0x1e,%al
  27a216:	jae    27a250 <<glass::engine::Watch>::print_utf8+0xc10>
  27a218:	lea    0x1(%r14),%rax
  27a21c:	cmp    %r13,%rax
  27a21f:	jae    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a225:	movzbl (%rsi,%rax,1),%eax
  27a229:	cmp    $0xc0,%al
  27a22b:	jge    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a231:	and    $0x1f,%r8d
  27a235:	shl    $0x6,%r8d
  27a239:	mov    $0x2,%edx
  27a23e:	jmp    27a368 <<glass::engine::Watch>::print_utf8+0xd28>
  27a243:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  27a250:	mov    %r8d,%eax
  27a253:	and    $0xf0,%al
  27a255:	cmp    $0xe0,%al
  27a257:	jne    27a273 <<glass::engine::Watch>::print_utf8+0xc33>
  27a259:	mov    $0xbf,%al
  27a25b:	cmp    $0xe0,%r8d
  27a262:	je     27a299 <<glass::engine::Watch>::print_utf8+0xc59>
  27a264:	mov    $0x80,%cl
  27a266:	cmp    $0xed,%r8d
  27a26d:	jne    27a29b <<glass::engine::Watch>::print_utf8+0xc5b>
  27a26f:	mov    $0x9f,%al
  27a271:	jmp    27a29b <<glass::engine::Watch>::print_utf8+0xc5b>
  27a273:	lea    0x10(%r8),%eax
  27a277:	cmp    $0x5,%al
  27a279:	jae    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a27f:	mov    $0x80,%al
  27a281:	cmp    $0xf4,%r8d
  27a288:	je     27a2f0 <<glass::engine::Watch>::print_utf8+0xcb0>
  27a28a:	mov    $0xbf,%cl
  27a28c:	cmp    $0xf0,%r8d
  27a293:	jne    27a2f2 <<glass::engine::Watch>::print_utf8+0xcb2>
  27a295:	mov    $0x90,%al
  27a297:	jmp    27a2f2 <<glass::engine::Watch>::print_utf8+0xcb2>
  27a299:	mov    $0xa0,%cl
  27a29b:	lea    0x1(%r14),%rdx
  27a29f:	cmp    %r13,%rdx
  27a2a2:	jae    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a2a8:	movzbl (%rsi,%rdx,1),%edx
  27a2ac:	cmp    %dl,%cl
  27a2ae:	ja     27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a2b4:	cmp    %al,%dl
  27a2b6:	ja     27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a2bc:	lea    0x2(%r14),%rax
  27a2c0:	cmp    %r13,%rax
  27a2c3:	jae    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a2c9:	movzbl (%rsi,%rax,1),%eax
  27a2cd:	cmp    $0xc0,%al
  27a2cf:	jge    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a2d5:	movzbl %dl,%ecx
  27a2d8:	and    $0x3f,%ecx
  27a2db:	shl    $0x6,%ecx
  27a2de:	and    $0xf,%r8d
  27a2e2:	shl    $0xc,%r8d
  27a2e6:	or     %ecx,%r8d
  27a2e9:	mov    $0x3,%edx
  27a2ee:	jmp    27a368 <<glass::engine::Watch>::print_utf8+0xd28>
  27a2f0:	mov    $0x8f,%cl
  27a2f2:	lea    0x1(%r14),%rdx
  27a2f6:	cmp    %r13,%rdx
  27a2f9:	jae    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a2ff:	movzbl (%rsi,%rdx,1),%edx
  27a303:	cmp    %dl,%al
  27a305:	ja     27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a30b:	cmp    %cl,%dl
  27a30d:	ja     27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a313:	lea    0x2(%r14),%rax
  27a317:	cmp    %r13,%rax
  27a31a:	jae    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a320:	movzbl (%rsi,%rax,1),%ecx
  27a324:	cmp    $0xbf,%cl
  27a327:	jg     27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a32d:	lea    0x3(%r14),%rax
  27a331:	cmp    %r13,%rax
  27a334:	jae    27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a33a:	movzbl (%rsi,%rax,1),%eax
  27a33e:	cmp    $0xbf,%al
  27a340:	jg     27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a346:	movzbl %dl,%edx
  27a349:	and    $0x3f,%ecx
  27a34c:	shl    $0x6,%ecx
  27a34f:	and    $0x3f,%edx
  27a352:	shl    $0xc,%edx
  27a355:	and    $0x7,%r8d
  27a359:	shl    $0x12,%r8d
  27a35d:	or     %edx,%r8d
  27a360:	or     %ecx,%r8d
  27a363:	mov    $0x4,%edx
  27a368:	mov    %r8d,%ecx
  27a36b:	xor    $0xd800,%ecx
  27a371:	add    $0xffef0000,%ecx
  27a377:	cmp    $0xffef0800,%ecx
  27a37d:	jb     27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a383:	and    $0x3f,%al
  27a385:	movzbl %al,%eax
  27a388:	or     %eax,%r8d
  27a38b:	lea    -0x7f(%r8),%eax
  27a38f:	cmp    $0x21,%eax
  27a392:	jb     27ad1b <<glass::engine::Watch>::print_utf8+0x16db>
  27a398:	cmp    $0xffffffff,%ebp
  27a39b:	je     27ace0 <<glass::engine::Watch>::print_utf8+0x16a0>
  27a3a1:	mov    %r14,0x8(%rsp)
  27a3a6:	lea    -0x20(%rbp),%eax
  27a3a9:	cmp    $0x5f,%eax
  27a3ac:	jae    27a3d0 <<glass::engine::Watch>::print_utf8+0xd90>
  27a3ae:	mov    $0x1,%r12d
  27a3b4:	cmpb   $0x0,0x20(%rsp)
  27a3b9:	je     27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a3bf:	jmp    27a479 <<glass::engine::Watch>::print_utf8+0xe39>
  27a3c4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  27a3d0:	cmpb   $0x0,0x14(%rsp)
  27a3d5:	je     27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a3db:	mov    0x3b55df(%rip),%eax        # 62f9c0 <glass::engine::width_of::CACHE+0x10>
  27a3e1:	test   %eax,%eax
  27a3e3:	jne    27acf3 <<glass::engine::Watch>::print_utf8+0x16b3>
  27a3e9:	mov    %ebp,%ebx
  27a3eb:	mov    0x3b55c6(%rip),%rsi        # 62f9b8 <glass::engine::width_of::CACHE+0x8>
  27a3f2:	cmp    %rbx,%rsi
  27a3f5:	jbe    27b6b0 <<glass::engine::Watch>::print_utf8+0x2070>
  27a3fb:	mov    0x3b55ae(%rip),%r14        # 62f9b0 <glass::engine::width_of::CACHE>
  27a402:	movzbl (%r14,%rbx,1),%eax
  27a407:	movzbl %al,%r12d
  27a40b:	test   %r12b,%r12b
  27a40e:	js     27a41b <<glass::engine::Watch>::print_utf8+0xddb>
  27a410:	mov    $0x1,%cl
  27a412:	test   %cl,%cl
  27a414:	jne    27a46a <<glass::engine::Watch>::print_utf8+0xe2a>
  27a416:	jmp    27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a41b:	cmp    $0xfe,%r12d
  27a422:	je     27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a428:	mov    $0xfe,%al
  27a42a:	cmp    $0x7f,%ebp
  27a42d:	jae    27a439 <<glass::engine::Watch>::print_utf8+0xdf9>
  27a42f:	mov    $0x1,%r12d
  27a435:	xor    %ecx,%ecx
  27a437:	jmp    27a45e <<glass::engine::Watch>::print_utf8+0xe1e>
  27a439:	cmp    $0xa0,%ebp
  27a43f:	jb     27a45c <<glass::engine::Watch>::print_utf8+0xe1c>
  27a441:	mov    %ebp,%edi
  27a443:	mov    %r8,%r15
  27a446:	mov    %rdx,%r12
  27a449:	call   2b02a0 <unicode_width::tables::lookup_width>
  27a44e:	mov    %r12,%rdx
  27a451:	mov    %r15,%r8
  27a454:	movzbl %al,%r12d
  27a458:	mov    $0x1,%cl
  27a45a:	jmp    27a45e <<glass::engine::Watch>::print_utf8+0xe1e>
  27a45c:	xor    %ecx,%ecx
  27a45e:	mov    %al,(%r14,%rbx,1)
  27a462:	test   %cl,%cl
  27a464:	je     27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a46a:	lea    -0x1(%r12),%rax
  27a46f:	cmp    $0x1,%rax
  27a473:	ja     27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a479:	mov    0xc8(%rsp),%rax
  27a481:	mov    0x78(%rax),%r15
  27a485:	cmpb   $0x0,0x6c(%r15)
  27a48a:	jne    27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a490:	mov    0x40(%r15),%r11
  27a494:	mov    0xa0(%r15),%r10
  27a49b:	lea    (%r11,%r12,1),%r9
  27a49f:	cmp    %r10,%r9
  27a4a2:	ja     27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a4a8:	mov    0x30(%r15),%eax
  27a4ac:	sub    0x48(%r15),%eax
  27a4b0:	cltq
  27a4b2:	mov    0x20(%r15),%rsi
  27a4b6:	mov    0x28(%r15),%rcx
  27a4ba:	lea    (%rcx,%rax,1),%rdi
  27a4be:	dec    %rdi
  27a4c1:	cmp    %rsi,%rdi
  27a4c4:	mov    $0x0,%eax
  27a4c9:	cmovae %rsi,%rax
  27a4cd:	sub    %rax,%rdi
  27a4d0:	cmp    %rsi,%rdi
  27a4d3:	jae    27b759 <<glass::engine::Watch>::print_utf8+0x2119>
  27a4d9:	mov    0x58(%r15),%r14d
  27a4dd:	mov    0x5c(%r15),%eax
  27a4e1:	mov    %eax,0xb8(%rsp)
  27a4e8:	movzwl 0x64(%r15),%eax
  27a4ed:	mov    %eax,0x68(%rsp)
  27a4f1:	mov    0x18(%r15),%rax
  27a4f5:	shl    $0x6,%rdi
  27a4f9:	lea    (%rax,%rdi,1),%rcx
  27a4fd:	lea    (%rax,%rdi,1),%rbx
  27a501:	add    $0x18,%rbx
  27a505:	mov    0x28(%rax,%rdi,1),%eax
  27a509:	mov    %rcx,%rdi
  27a50c:	cmp    $0xffffffff,%eax
  27a50f:	je     27a51a <<glass::engine::Watch>::print_utf8+0xeda>
  27a511:	mov    %rbx,%rcx
  27a514:	cmp    0x30(%rdi),%r11
  27a518:	jae    27a533 <<glass::engine::Watch>::print_utf8+0xef3>
  27a51a:	mov    0x10(%rdi),%rsi
  27a51e:	cmp    %rsi,%r11
  27a521:	jae    27b766 <<glass::engine::Watch>::print_utf8+0x2126>
  27a527:	lea    (%r11,%r11,2),%rcx
  27a52b:	shl    $0x3,%rcx
  27a52f:	add    0x8(%rdi),%rcx
  27a533:	testb  $0x60,0x14(%rcx)
  27a537:	jne    27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a53d:	cmp    $0x2,%r12
  27a541:	mov    %rdi,0x30(%rsp)
  27a546:	mov    %rbx,0x28(%rsp)
  27a54b:	jne    27a596 <<glass::engine::Watch>::print_utf8+0xf56>
  27a54d:	lea    0x1(%r11),%rdi
  27a551:	cmp    $0xffffffff,%eax
  27a554:	je     27a564 <<glass::engine::Watch>::print_utf8+0xf24>
  27a556:	mov    %rbx,%rcx
  27a559:	mov    0x30(%rsp),%rsi
  27a55e:	cmp    0x30(%rsi),%rdi
  27a562:	jae    27a587 <<glass::engine::Watch>::print_utf8+0xf47>
  27a564:	mov    0x30(%rsp),%rbx
  27a569:	mov    0x10(%rbx),%rsi
  27a56d:	cmp    %rsi,%rdi
  27a570:	jae    27b785 <<glass::engine::Watch>::print_utf8+0x2145>
  27a576:	lea    (%rdi,%rdi,2),%rcx
  27a57a:	shl    $0x3,%rcx
  27a57e:	add    0x8(%rbx),%rcx
  27a582:	mov    0x28(%rsp),%rbx
  27a587:	testb  $0x60,0x14(%rcx)
  27a58b:	mov    0x30(%rsp),%rdi
  27a590:	jne    27a1a0 <<glass::engine::Watch>::print_utf8+0xb60>
  27a596:	mov    %rdx,0x18(%rsp)
  27a59b:	cmp    %r11d,0x38(%rdi)
  27a59f:	jbe    27a5a5 <<glass::engine::Watch>::print_utf8+0xf65>
  27a5a1:	mov    %r11d,0x38(%rdi)
  27a5a5:	mov    %r14d,0x48(%rsp)
  27a5aa:	mov    %r10,0x80(%rsp)
  27a5b2:	cmp    $0xffffffff,%eax
  27a5b5:	setne  %dl
  27a5b8:	mov    0x30(%rdi),%rcx
  27a5bc:	cmp    %rcx,%r11
  27a5bf:	sete   %sil
  27a5c3:	test   %sil,%dl
  27a5c6:	mov    %r11,0x40(%rsp)
  27a5cb:	mov    %r9,0x60(%rsp)
  27a5d0:	jne    27a656 <<glass::engine::Watch>::print_utf8+0x1016>
  27a5d6:	cmp    $0xffffffff,%eax
  27a5d9:	mov    0x8(%rsp),%r14
  27a5de:	mov    0x68(%rsp),%r10d
  27a5e3:	je     27a8cb <<glass::engine::Watch>::print_utf8+0x128b>
  27a5e9:	mov    0x10(%rdi),%rdx
  27a5ed:	cmp    %rcx,%rdx
  27a5f0:	mov    %rcx,%rax
  27a5f3:	cmovb  %rdx,%rax
  27a5f7:	mov    %rax,0x50(%rsp)
  27a5fc:	cmp    %r11,%rdx
  27a5ff:	mov    %r11,%rsi
  27a602:	cmovb  %rdx,%rsi
  27a606:	mov    0x3b0c0b(%rip),%rax        # 62b218 <_DYNAMIC+0x338>
  27a60d:	movzbl (%rax),%eax
  27a610:	test   %al,%al
  27a612:	mov    %rsi,0xa0(%rsp)
  27a61a:	je     27a6d2 <<glass::engine::Watch>::print_utf8+0x1092>
  27a620:	mov    0x3b0c29(%rip),%rax        # 62b250 <_DYNAMIC+0x370>
  27a627:	cmp    %rsi,%rcx
  27a62a:	jae    27a633 <<glass::engine::Watch>::print_utf8+0xff3>
  27a62c:	mov    0x3b0c25(%rip),%rax        # 62b258 <_DYNAMIC+0x378>
  27a633:	lock incq 0x28(%rax)
  27a638:	mov    0x3b0bf1(%rip),%rax        # 62b230 <_DYNAMIC+0x350>
  27a63f:	lock incq (%rax)
  27a643:	mov    0xa0(%rsp),%rax
  27a64b:	sub    0x50(%rsp),%rax
  27a650:	jne    27a67a <<glass::engine::Watch>::print_utf8+0x103a>
  27a652:	xor    %esi,%esi
  27a654:	jmp    27a6be <<glass::engine::Watch>::print_utf8+0x107e>
  27a656:	lea    0x1(%r11),%rax
  27a65a:	mov    %rax,0x30(%rdi)
  27a65e:	mov    0x10(%rdi),%rsi
  27a662:	cmp    %rsi,%r11
  27a665:	mov    0x8(%rsp),%r14
  27a66a:	mov    0x68(%rsp),%r10d
  27a66f:	jb     27a8eb <<glass::engine::Watch>::print_utf8+0x12ab>
  27a675:	jmp    27b792 <<glass::engine::Watch>::print_utf8+0x2152>
  27a67a:	mov    0x3b0bb7(%rip),%rsi        # 62b238 <_DYNAMIC+0x358>
  27a681:	lock add %rax,(%rsi)
  27a685:	cmp    $0x5,%rax
  27a689:	jae    27a699 <<glass::engine::Watch>::print_utf8+0x1059>
  27a68b:	lea    -0x21a532(%rip),%rsi        # 60160 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  27a692:	movzbl -0x1(%rax,%rsi,1),%esi
  27a697:	jmp    27a6be <<glass::engine::Watch>::print_utf8+0x107e>
  27a699:	lea    -0x5(%rax),%rdi
  27a69d:	mov    $0x4,%esi
  27a6a2:	cmp    $0x4,%rdi
  27a6a6:	mov    0x30(%rsp),%rdi
  27a6ab:	jb     27a6be <<glass::engine::Watch>::print_utf8+0x107e>
  27a6ad:	add    $0xfffffffffffffff7,%rax
  27a6b1:	cmp    $0x8,%rax
  27a6b5:	mov    $0x6,%esi
  27a6ba:	sbb    $0x0,%rsi
  27a6be:	mov    0x3b0b63(%rip),%rax        # 62b228 <_DYNAMIC+0x348>
  27a6c5:	lock incq (%rax,%rsi,8)
  27a6ca:	mov    0xa0(%rsp),%rsi
  27a6d2:	cmp    %rsi,%rcx
  27a6d5:	jae    27a88d <<glass::engine::Watch>::print_utf8+0x124d>
  27a6db:	mov    0x28(%rdi),%r10d
  27a6df:	mov    0x20(%rdi),%r11d
  27a6e3:	mov    0x24(%rdi),%r14d
  27a6e7:	movzwl 0x2c(%rdi),%eax
  27a6eb:	mov    0x18(%rdi),%r9
  27a6ef:	test   %r9,%r9
  27a6f2:	je     27a702 <<glass::engine::Watch>::print_utf8+0x10c2>
  27a6f4:	lock incq (%r9)
  27a6f8:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27a6fe:	mov    0x10(%rdi),%rdx
  27a702:	movzwl 0x2e(%rdi),%ecx
  27a706:	mov    %r10d,0x98(%rsp)
  27a70e:	mov    %r11d,0x90(%rsp)
  27a716:	mov    %r14d,0x94(%rsp)
  27a71e:	mov    %ax,0x38(%rsp)
  27a723:	mov    %ax,0x9c(%rsp)
  27a72b:	mov    %r9,0x88(%rsp)
  27a733:	mov    %cx,0x58(%rsp)
  27a738:	mov    %cx,0x9e(%rsp)
  27a740:	cmp    %rdx,%rsi
  27a743:	mov    %r9,0x78(%rsp)
  27a748:	ja     27b6c0 <<glass::engine::Watch>::print_utf8+0x2080>
  27a74e:	mov    0x50(%rsp),%rax
  27a753:	lea    0x0(,%rax,8),%rax
  27a75b:	lea    (%rax,%rax,2),%rax
  27a75f:	mov    0x8(%rdi),%rbx
  27a763:	add    %rax,%rbx
  27a766:	lea    0x0(,%rsi,8),%rcx
  27a76e:	lea    (%rcx,%rcx,2),%r13
  27a772:	sub    %rax,%r13
  27a775:	movzwl 0x38(%rsp),%ecx
  27a77a:	movzwl 0x58(%rsp),%edx
  27a77f:	mov    %r15,0xd8(%rsp)
  27a787:	mov    %r8,(%rsp)
  27a78b:	mov    %r14d,0xb0(%rsp)
  27a793:	jmp    27a7c1 <<glass::engine::Watch>::print_utf8+0x1181>
  27a795:	data16 cs nopw 0x0(%rax,%rax,1)
  27a7a0:	mov    %r9,(%rbx)
  27a7a3:	mov    %r11d,0x8(%rbx)
  27a7a7:	mov    %r14d,0xc(%rbx)
  27a7ab:	mov    %r10d,0x10(%rbx)
  27a7af:	mov    %cx,0x14(%rbx)
  27a7b3:	mov    %dx,0x16(%rbx)
  27a7b7:	add    $0x18,%rbx
  27a7bb:	add    $0xffffffffffffffe8,%r13
  27a7bf:	je     27a81d <<glass::engine::Watch>::print_utf8+0x11dd>
  27a7c1:	test   %r9,%r9
  27a7c4:	je     27a7d0 <<glass::engine::Watch>::print_utf8+0x1190>
  27a7c6:	lock incq (%r9)
  27a7ca:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27a7d0:	mov    (%rbx),%rax
  27a7d3:	test   %rax,%rax
  27a7d6:	je     27a7a0 <<glass::engine::Watch>::print_utf8+0x1160>
  27a7d8:	lock decq (%rax)
  27a7dc:	jne    27a7a0 <<glass::engine::Watch>::print_utf8+0x1160>
  27a7de:	mov    %rbx,%rdi
  27a7e1:	mov    %r10d,%r15d
  27a7e4:	mov    %r11d,%r14d
  27a7e7:	call   *0x3b0963(%rip)        # 62b150 <_DYNAMIC+0x270>
  27a7ed:	movzwl 0x58(%rsp),%edx
  27a7f2:	movzwl 0x38(%rsp),%ecx
  27a7f7:	mov    %r14d,%r11d
  27a7fa:	mov    0xb0(%rsp),%r14d
  27a802:	mov    %r15d,%r10d
  27a805:	mov    0xd8(%rsp),%r15
  27a80d:	mov    0x30(%rsp),%rdi
  27a812:	mov    (%rsp),%r8
  27a816:	mov    0x78(%rsp),%r9
  27a81b:	jmp    27a7a0 <<glass::engine::Watch>::print_utf8+0x1160>
  27a81d:	mov    0x50(%rsp),%rax
  27a822:	cmp    %eax,0x38(%rdi)
  27a825:	jbe    27a82a <<glass::engine::Watch>::print_utf8+0x11ea>
  27a827:	mov    %eax,0x38(%rdi)
  27a82a:	test   %r9,%r9
  27a82d:	mov    0xa8(%rsp),%r13
  27a835:	mov    0x8(%rsp),%r14
  27a83a:	mov    0x40(%rsp),%r11
  27a83f:	mov    0x68(%rsp),%r10d
  27a844:	mov    0x28(%rsp),%rbx
  27a849:	mov    0xa0(%rsp),%rsi
  27a851:	je     27a889 <<glass::engine::Watch>::print_utf8+0x1249>
  27a853:	lock decq (%r9)
  27a857:	jne    27a889 <<glass::engine::Watch>::print_utf8+0x1249>
  27a859:	lea    0x88(%rsp),%rdi
  27a861:	mov    %r8,%rbx
  27a864:	call   *0x3b08e6(%rip)        # 62b150 <_DYNAMIC+0x270>
  27a86a:	mov    0xa0(%rsp),%rsi
  27a872:	mov    0x30(%rsp),%rdi
  27a877:	mov    %rbx,%r8
  27a87a:	mov    0x28(%rsp),%rbx
  27a87f:	mov    0x68(%rsp),%r10d
  27a884:	mov    0x40(%rsp),%r11
  27a889:	mov    0x10(%rdi),%rdx
  27a88d:	cmp    %rdx,%rsi
  27a890:	jb     27a8cb <<glass::engine::Watch>::print_utf8+0x128b>
  27a892:	cmpl   $0xffffffff,0x28(%rdi)
  27a896:	je     27a8c4 <<glass::engine::Watch>::print_utf8+0x1284>
  27a898:	mov    (%rbx),%rax
  27a89b:	test   %rax,%rax
  27a89e:	je     27a8c4 <<glass::engine::Watch>::print_utf8+0x1284>
  27a8a0:	lock decq (%rax)
  27a8a4:	jne    27a8c4 <<glass::engine::Watch>::print_utf8+0x1284>
  27a8a6:	mov    %rbx,%rdi
  27a8a9:	mov    %r8,%rbx
  27a8ac:	call   *0x3b089e(%rip)        # 62b150 <_DYNAMIC+0x270>
  27a8b2:	mov    0x30(%rsp),%rdi
  27a8b7:	mov    %rbx,%r8
  27a8ba:	mov    0x68(%rsp),%r10d
  27a8bf:	mov    0x40(%rsp),%r11
  27a8c4:	movl   $0xffffffff,0x28(%rdi)
  27a8cb:	mov    0x30(%rdi),%rax
  27a8cf:	lea    0x1(%r11),%rcx
  27a8d3:	cmp    %rax,%rcx
  27a8d6:	cmova  %rcx,%rax
  27a8da:	mov    0x10(%rdi),%rsi
  27a8de:	mov    %rax,0x30(%rdi)
  27a8e2:	cmp    %rsi,%r11
  27a8e5:	jae    27b7a2 <<glass::engine::Watch>::print_utf8+0x2162>
  27a8eb:	mov    %r10d,%eax
  27a8ee:	or     $0x20,%eax
  27a8f1:	cmp    $0x2,%r12
  27a8f5:	mov    0x8(%rdi),%rcx
  27a8f9:	lea    (%r11,%r11,2),%rdx
  27a8fd:	lea    (%rcx,%rdx,8),%rbx
  27a901:	mov    %ebp,0x10(%rcx,%rdx,8)
  27a905:	mov    0x48(%rsp),%edi
  27a909:	mov    %edi,0x8(%rcx,%rdx,8)
  27a90d:	cmovne %r10d,%eax
  27a911:	mov    0xb8(%rsp),%esi
  27a918:	mov    %esi,0xc(%rcx,%rdx,8)
  27a91c:	mov    %ax,0x14(%rcx,%rdx,8)
  27a921:	mov    (%rcx,%rdx,8),%rax
  27a925:	test   %rax,%rax
  27a928:	je     27a93f <<glass::engine::Watch>::print_utf8+0x12ff>
  27a92a:	lock decq (%rax)
  27a92e:	jne    27a93f <<glass::engine::Watch>::print_utf8+0x12ff>
  27a930:	mov    %rbx,%rdi
  27a933:	mov    %r8,%rbp
  27a936:	call   *0x3b0814(%rip)        # 62b150 <_DYNAMIC+0x270>
  27a93c:	mov    %rbp,%r8
  27a93f:	movq   $0x0,(%rbx)
  27a946:	movw   $0x0,0x16(%rbx)
  27a94c:	cmp    $0x2,%r12
  27a950:	mov    0x18(%rsp),%rdx
  27a955:	jne    27aca7 <<glass::engine::Watch>::print_utf8+0x1667>
  27a95b:	mov    0x40(%rsp),%r9
  27a960:	lea    0x1(%r9),%r12
  27a964:	mov    0x30(%rsp),%r10
  27a969:	mov    0x30(%r10),%rax
  27a96d:	mov    0x28(%r10),%ecx
  27a971:	cmp    %rax,%r12
  27a974:	jne    27a995 <<glass::engine::Watch>::print_utf8+0x1355>
  27a976:	cmp    $0xffffffff,%ecx
  27a979:	je     27a995 <<glass::engine::Watch>::print_utf8+0x1355>
  27a97b:	add    $0x2,%r9
  27a97f:	mov    %r9,0x30(%r10)
  27a983:	mov    0x10(%r10),%rsi
  27a987:	cmp    %rsi,%r12
  27a98a:	jb     27ac44 <<glass::engine::Watch>::print_utf8+0x1604>
  27a990:	jmp    27b00a <<glass::engine::Watch>::print_utf8+0x19ca>
  27a995:	cmp    $0xffffffff,%ecx
  27a998:	mov    0x28(%rsp),%rdi
  27a99d:	je     27ac24 <<glass::engine::Watch>::print_utf8+0x15e4>
  27a9a3:	mov    0x10(%r10),%rdx
  27a9a7:	cmp    %rax,%rdx
  27a9aa:	mov    %rax,%rbx
  27a9ad:	cmovb  %rdx,%rbx
  27a9b1:	cmp    %r12,%rdx
  27a9b4:	mov    %r12,%r11
  27a9b7:	cmovb  %rdx,%r11
  27a9bb:	mov    0x3b0856(%rip),%rcx        # 62b218 <_DYNAMIC+0x338>
  27a9c2:	movzbl (%rcx),%ecx
  27a9c5:	test   %cl,%cl
  27a9c7:	je     27aa48 <<glass::engine::Watch>::print_utf8+0x1408>
  27a9c9:	mov    0x3b0880(%rip),%rcx        # 62b250 <_DYNAMIC+0x370>
  27a9d0:	cmp    %r11,%rax
  27a9d3:	jae    27a9dc <<glass::engine::Watch>::print_utf8+0x139c>
  27a9d5:	mov    0x3b087c(%rip),%rcx        # 62b258 <_DYNAMIC+0x378>
  27a9dc:	lock incq 0x28(%rcx)
  27a9e1:	mov    0x3b0848(%rip),%rcx        # 62b230 <_DYNAMIC+0x350>
  27a9e8:	lock incq (%rcx)
  27a9ec:	mov    %r11,%rcx
  27a9ef:	sub    %rbx,%rcx
  27a9f2:	jne    27a9f8 <<glass::engine::Watch>::print_utf8+0x13b8>
  27a9f4:	xor    %esi,%esi
  27a9f6:	jmp    27aa3c <<glass::engine::Watch>::print_utf8+0x13fc>
  27a9f8:	mov    0x3b0839(%rip),%rsi        # 62b238 <_DYNAMIC+0x358>
  27a9ff:	lock add %rcx,(%rsi)
  27aa03:	cmp    $0x5,%rcx
  27aa07:	jae    27aa17 <<glass::engine::Watch>::print_utf8+0x13d7>
  27aa09:	lea    -0x21a8b0(%rip),%rsi        # 60160 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  27aa10:	movzbl -0x1(%rcx,%rsi,1),%esi
  27aa15:	jmp    27aa3c <<glass::engine::Watch>::print_utf8+0x13fc>
  27aa17:	lea    -0x5(%rcx),%r10
  27aa1b:	mov    $0x4,%esi
  27aa20:	cmp    $0x4,%r10
  27aa24:	mov    0x30(%rsp),%r10
  27aa29:	jb     27aa3c <<glass::engine::Watch>::print_utf8+0x13fc>
  27aa2b:	add    $0xfffffffffffffff7,%rcx
  27aa2f:	cmp    $0x8,%rcx
  27aa33:	mov    $0x6,%esi
  27aa38:	sbb    $0x0,%rsi
  27aa3c:	mov    0x3b07e5(%rip),%rcx        # 62b228 <_DYNAMIC+0x348>
  27aa43:	lock incq (%rcx,%rsi,8)
  27aa48:	cmp    %r11,%rax
  27aa4b:	jae    27abf8 <<glass::engine::Watch>::print_utf8+0x15b8>
  27aa51:	mov    %r12,0x50(%rsp)
  27aa56:	mov    0x28(%r10),%edi
  27aa5a:	mov    0x20(%r10),%r9d
  27aa5e:	mov    0x24(%r10),%ebp
  27aa62:	movzwl 0x2c(%r10),%r14d
  27aa67:	mov    0x18(%r10),%r12
  27aa6b:	test   %r12,%r12
  27aa6e:	je     27aa7f <<glass::engine::Watch>::print_utf8+0x143f>
  27aa70:	lock incq (%r12)
  27aa75:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27aa7b:	mov    0x10(%r10),%rdx
  27aa7f:	movzwl 0x2e(%r10),%eax
  27aa84:	mov    %edi,0x98(%rsp)
  27aa8b:	mov    %r9d,0x90(%rsp)
  27aa93:	mov    %ebp,0x94(%rsp)
  27aa9a:	mov    %r14w,0x9c(%rsp)
  27aaa3:	mov    %r12,0x88(%rsp)
  27aaab:	mov    %ax,0x38(%rsp)
  27aab0:	mov    %ax,0x9e(%rsp)
  27aab8:	cmp    %rdx,%r11
  27aabb:	mov    %r11,%rsi
  27aabe:	mov    %r12,0x58(%rsp)
  27aac3:	ja     27b6d7 <<glass::engine::Watch>::print_utf8+0x2097>
  27aac9:	mov    %rbx,0xc0(%rsp)
  27aad1:	lea    0x0(,%rbx,8),%rax
  27aad9:	lea    (%rax,%rax,2),%rax
  27aadd:	mov    0x8(%r10),%rbx
  27aae1:	add    %rax,%rbx
  27aae4:	mov    %rsi,0xa0(%rsp)
  27aaec:	lea    0x0(,%rsi,8),%rcx
  27aaf4:	lea    (%rcx,%rcx,2),%r13
  27aaf8:	sub    %rax,%r13
  27aafb:	movzwl 0x38(%rsp),%ecx
  27ab00:	mov    %ebp,0x78(%rsp)
  27ab04:	mov    %r14w,0xb0(%rsp)
  27ab0d:	jmp    27ab30 <<glass::engine::Watch>::print_utf8+0x14f0>
  27ab0f:	nop
  27ab10:	mov    %r12,(%rbx)
  27ab13:	mov    %r9d,0x8(%rbx)
  27ab17:	mov    %ebp,0xc(%rbx)
  27ab1a:	mov    %edi,0x10(%rbx)
  27ab1d:	mov    %r14w,0x14(%rbx)
  27ab22:	mov    %cx,0x16(%rbx)
  27ab26:	add    $0x18,%rbx
  27ab2a:	add    $0xffffffffffffffe8,%r13
  27ab2e:	je     27ab87 <<glass::engine::Watch>::print_utf8+0x1547>
  27ab30:	test   %r12,%r12
  27ab33:	je     27ab40 <<glass::engine::Watch>::print_utf8+0x1500>
  27ab35:	lock incq (%r12)
  27ab3a:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27ab40:	mov    (%rbx),%rax
  27ab43:	test   %rax,%rax
  27ab46:	je     27ab10 <<glass::engine::Watch>::print_utf8+0x14d0>
  27ab48:	lock decq (%rax)
  27ab4c:	jne    27ab10 <<glass::engine::Watch>::print_utf8+0x14d0>
  27ab4e:	mov    %edi,%r14d
  27ab51:	mov    %rbx,%rdi
  27ab54:	mov    %r8,%rbp
  27ab57:	mov    %r9d,%r12d
  27ab5a:	call   *0x3b05f0(%rip)        # 62b150 <_DYNAMIC+0x270>
  27ab60:	movzwl 0x38(%rsp),%ecx
  27ab65:	mov    %r12d,%r9d
  27ab68:	mov    0x58(%rsp),%r12
  27ab6d:	mov    %r14d,%edi
  27ab70:	movzwl 0xb0(%rsp),%r14d
  27ab79:	mov    0x30(%rsp),%r10
  27ab7e:	mov    %rbp,%r8
  27ab81:	mov    0x78(%rsp),%ebp
  27ab85:	jmp    27ab10 <<glass::engine::Watch>::print_utf8+0x14d0>
  27ab87:	mov    0xc0(%rsp),%rax
  27ab8f:	cmp    %eax,0x38(%r10)
  27ab93:	jbe    27ab99 <<glass::engine::Watch>::print_utf8+0x1559>
  27ab95:	mov    %eax,0x38(%r10)
  27ab99:	test   %r12,%r12
  27ab9c:	mov    0xa8(%rsp),%r13
  27aba4:	mov    0x8(%rsp),%r14
  27aba9:	mov    0x40(%rsp),%r9
  27abae:	mov    0x28(%rsp),%rdi
  27abb3:	mov    0xa0(%rsp),%r11
  27abbb:	je     27abef <<glass::engine::Watch>::print_utf8+0x15af>
  27abbd:	lock decq (%r12)
  27abc2:	jne    27abef <<glass::engine::Watch>::print_utf8+0x15af>
  27abc4:	lea    0x88(%rsp),%rdi
  27abcc:	mov    %r8,%rbx
  27abcf:	call   *0x3b057b(%rip)        # 62b150 <_DYNAMIC+0x270>
  27abd5:	mov    0x30(%rsp),%r10
  27abda:	mov    %rbx,%r8
  27abdd:	mov    0xa0(%rsp),%r11
  27abe5:	mov    0x28(%rsp),%rdi
  27abea:	mov    0x40(%rsp),%r9
  27abef:	mov    0x10(%r10),%rdx
  27abf3:	mov    0x50(%rsp),%r12
  27abf8:	cmp    %rdx,%r11
  27abfb:	mov    0x18(%rsp),%rdx
  27ac00:	jb     27ac24 <<glass::engine::Watch>::print_utf8+0x15e4>
  27ac02:	mov    %r8,%rbx
  27ac05:	call   1b98b0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  27ac0a:	mov    0x30(%rsp),%r10
  27ac0f:	mov    0x18(%rsp),%rdx
  27ac14:	mov    %rbx,%r8
  27ac17:	mov    0x40(%rsp),%r9
  27ac1c:	movl   $0xffffffff,0x28(%r10)
  27ac24:	mov    0x30(%r10),%rax
  27ac28:	add    $0x2,%r9
  27ac2c:	cmp    %rax,%r9
  27ac2f:	cmovbe %rax,%r9
  27ac33:	mov    0x10(%r10),%rsi
  27ac37:	mov    %r9,0x30(%r10)
  27ac3b:	cmp    %rsi,%r12
  27ac3e:	jae    27b7b2 <<glass::engine::Watch>::print_utf8+0x2172>
  27ac44:	mov    0x8(%r10),%rax
  27ac48:	lea    (%r12,%r12,2),%rcx
  27ac4c:	lea    (%rax,%rcx,8),%rbx
  27ac50:	movl   $0x20,0x10(%rax,%rcx,8)
  27ac58:	mov    0x48(%rsp),%esi
  27ac5c:	mov    %esi,0x8(%rax,%rcx,8)
  27ac60:	mov    0xb8(%rsp),%esi
  27ac67:	mov    %esi,0xc(%rax,%rcx,8)
  27ac6b:	mov    0x68(%rsp),%esi
  27ac6f:	or     $0x40,%esi
  27ac72:	mov    %si,0x14(%rax,%rcx,8)
  27ac77:	mov    (%rax,%rcx,8),%rax
  27ac7b:	test   %rax,%rax
  27ac7e:	je     27ac9a <<glass::engine::Watch>::print_utf8+0x165a>
  27ac80:	lock decq (%rax)
  27ac84:	jne    27ac9a <<glass::engine::Watch>::print_utf8+0x165a>
  27ac86:	mov    %rbx,%rdi
  27ac89:	mov    %r8,%r12
  27ac8c:	call   *0x3b04be(%rip)        # 62b150 <_DYNAMIC+0x270>
  27ac92:	mov    0x18(%rsp),%rdx
  27ac97:	mov    %r12,%r8
  27ac9a:	movq   $0x0,(%rbx)
  27aca1:	movw   $0x0,0x16(%rbx)
  27aca7:	mov    0x60(%rsp),%rax
  27acac:	cmp    0x80(%rsp),%rax
  27acb4:	mov    0x70(%rsp),%rsi
  27acb9:	jb     27acc3 <<glass::engine::Watch>::print_utf8+0x1683>
  27acbb:	dec    %rax
  27acbe:	movb   $0x1,0x6c(%r15)
  27acc3:	mov    %rax,0x40(%r15)
  27acc7:	mov    0xc8(%rsp),%r15
  27accf:	incq   0xa0(%r15)
  27acd6:	cs nopw 0x0(%rax,%rax,1)
  27ace0:	add    %r14,%rdx
  27ace3:	cmpb   $0x0,0x14(%rsp)
  27ace8:	je     27a1d6 <<glass::engine::Watch>::print_utf8+0xb96>
  27acee:	jmp    2796f0 <<glass::engine::Watch>::print_utf8+0xb0>
  27acf3:	mov    %r8,%rbx
  27acf6:	mov    %rdx,%r14
  27acf9:	call   195692 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  27acfe:	mov    %r14,%rdx
  27ad01:	mov    %rbx,%r8
  27ad04:	mov    %ebp,%ebx
  27ad06:	mov    0x3b4cab(%rip),%rsi        # 62f9b8 <glass::engine::width_of::CACHE+0x8>
  27ad0d:	cmp    %rbx,%rsi
  27ad10:	ja     27a3fb <<glass::engine::Watch>::print_utf8+0xdbb>
  27ad16:	jmp    27b6b0 <<glass::engine::Watch>::print_utf8+0x2070>
  27ad1b:	cmpq   $0x400,0xa0(%r15)
  27ad26:	jb     27ad51 <<glass::engine::Watch>::print_utf8+0x1711>
  27ad28:	mov    %r15,%rdi
  27ad2b:	call   27bb70 <<glass::engine::Watch>::fold_sentinel>
  27ad30:	movq   $0x0,0xa0(%r15)
  27ad3b:	mov    0x3b4c87(%rip),%eax        # 62f9c8 <glass::engine::run_whole::ON>
  27ad41:	test   %eax,%eax
  27ad43:	je     27ad5b <<glass::engine::Watch>::print_utf8+0x171b>
  27ad45:	call   195736 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  27ad4a:	cmp    %r13,%r14
  27ad4d:	je     27ad60 <<glass::engine::Watch>::print_utf8+0x1720>
  27ad4f:	jmp    27ad90 <<glass::engine::Watch>::print_utf8+0x1750>
  27ad51:	mov    0x3b4c71(%rip),%eax        # 62f9c8 <glass::engine::run_whole::ON>
  27ad57:	test   %eax,%eax
  27ad59:	jne    27ad45 <<glass::engine::Watch>::print_utf8+0x1705>
  27ad5b:	cmp    %r13,%r14
  27ad5e:	jne    27ad90 <<glass::engine::Watch>::print_utf8+0x1750>
  27ad60:	cmpb   $0x0,0x3b4c65(%rip)        # 62f9cc <glass::engine::run_whole::ON+0x4>
  27ad67:	je     27ad90 <<glass::engine::Watch>::print_utf8+0x1750>
  27ad69:	cmp    $0xffffffff,%ebp
  27ad6c:	je     27af27 <<glass::engine::Watch>::print_utf8+0x18e7>
  27ad72:	lea    -0x20(%rbp),%eax
  27ad75:	cmp    $0x5f,%eax
  27ad78:	jae    27ada1 <<glass::engine::Watch>::print_utf8+0x1761>
  27ad7a:	mov    $0x1,%r13d
  27ad80:	cmpb   $0x0,0x20(%rsp)
  27ad85:	jne    27ae66 <<glass::engine::Watch>::print_utf8+0x1826>
  27ad8b:	jmp    27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27ad90:	xor    %eax,%eax
  27ad92:	cmp    $0xffffffff,%ebp
  27ad95:	cmove  %rax,%rbx
  27ad99:	mov    %rbx,%r13
  27ad9c:	jmp    27af27 <<glass::engine::Watch>::print_utf8+0x18e7>
  27ada1:	cmpb   $0x0,0x14(%rsp)
  27ada6:	je     27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27adac:	mov    0x3b4c0e(%rip),%eax        # 62f9c0 <glass::engine::width_of::CACHE+0x10>
  27adb2:	test   %eax,%eax
  27adb4:	jne    27b699 <<glass::engine::Watch>::print_utf8+0x2059>
  27adba:	mov    %ebp,%ebx
  27adbc:	mov    0x3b4bf5(%rip),%rsi        # 62f9b8 <glass::engine::width_of::CACHE+0x8>
  27adc3:	cmp    %rbx,%rsi
  27adc6:	jbe    27b6b0 <<glass::engine::Watch>::print_utf8+0x2070>
  27adcc:	mov    0x3b4bdd(%rip),%r14        # 62f9b0 <glass::engine::width_of::CACHE>
  27add3:	movzbl (%r14,%rbx,1),%eax
  27add8:	movzbl %al,%r13d
  27addc:	test   %r13b,%r13b
  27addf:	js     27adec <<glass::engine::Watch>::print_utf8+0x17ac>
  27ade1:	mov    $0x1,%cl
  27ade3:	test   %cl,%cl
  27ade5:	jne    27ae58 <<glass::engine::Watch>::print_utf8+0x1818>
  27ade7:	jmp    27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27adec:	cmp    $0xfe,%r13d
  27adf3:	je     27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27adf9:	mov    $0xfe,%al
  27adfb:	cmp    $0x7f,%ebp
  27adfe:	jae    27ae0a <<glass::engine::Watch>::print_utf8+0x17ca>
  27ae00:	mov    $0x1,%r13d
  27ae06:	xor    %ecx,%ecx
  27ae08:	jmp    27ae4c <<glass::engine::Watch>::print_utf8+0x180c>
  27ae0a:	cmp    $0xa0,%ebp
  27ae10:	jb     27ae4a <<glass::engine::Watch>::print_utf8+0x180a>
  27ae12:	mov    %ebp,%edi
  27ae14:	call   2b02a0 <unicode_width::tables::lookup_width>
  27ae19:	movzbl %al,%r13d
  27ae1d:	mov    $0x1,%cl
  27ae1f:	jmp    27ae4c <<glass::engine::Watch>::print_utf8+0x180c>
  27ae21:	mov    $0x1,%cl
  27ae23:	mov    %ecx,0x14(%rsp)
  27ae27:	cmpb   $0x0,0x68(%rax)
  27ae2b:	jne    27ae3d <<glass::engine::Watch>::print_utf8+0x17fd>
  27ae2d:	cmpb   $0x0,0x69(%rax)
  27ae31:	jne    27ae3d <<glass::engine::Watch>::print_utf8+0x17fd>
  27ae33:	cmpb   $0x0,0x6a(%rax)
  27ae37:	je     27b505 <<glass::engine::Watch>::print_utf8+0x1ec5>
  27ae3d:	movl   $0x0,0x20(%rsp)
  27ae45:	jmp    2796a2 <<glass::engine::Watch>::print_utf8+0x62>
  27ae4a:	xor    %ecx,%ecx
  27ae4c:	mov    %al,(%r14,%rbx,1)
  27ae50:	test   %cl,%cl
  27ae52:	je     27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27ae58:	lea    -0x1(%r13),%rax
  27ae5c:	cmp    $0x1,%rax
  27ae60:	ja     27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27ae66:	mov    0x78(%r15),%r14
  27ae6a:	cmpb   $0x0,0x6c(%r14)
  27ae6f:	jne    27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27ae75:	mov    0x40(%r14),%r12
  27ae79:	mov    0xa0(%r14),%r8
  27ae80:	lea    (%r12,%r13,1),%rdx
  27ae84:	cmp    %r8,%rdx
  27ae87:	ja     27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27ae8d:	mov    0x30(%r14),%eax
  27ae91:	sub    0x48(%r14),%eax
  27ae95:	cltq
  27ae97:	mov    0x20(%r14),%rsi
  27ae9b:	mov    0x28(%r14),%rcx
  27ae9f:	lea    (%rcx,%rax,1),%rdi
  27aea3:	dec    %rdi
  27aea6:	xor    %eax,%eax
  27aea8:	cmp    %rsi,%rdi
  27aeab:	cmovae %rsi,%rax
  27aeaf:	sub    %rax,%rdi
  27aeb2:	cmp    %rsi,%rdi
  27aeb5:	jae    27b759 <<glass::engine::Watch>::print_utf8+0x2119>
  27aebb:	mov    0x58(%r14),%eax
  27aebf:	mov    %eax,0x14(%rsp)
  27aec3:	mov    0x5c(%r14),%eax
  27aec7:	mov    %eax,0x70(%rsp)
  27aecb:	movzwl 0x64(%r14),%ebx
  27aed0:	mov    0x18(%r14),%rax
  27aed4:	shl    $0x6,%rdi
  27aed8:	lea    (%rax,%rdi,1),%r9
  27aedc:	lea    (%rax,%rdi,1),%r10
  27aee0:	add    $0x18,%r10
  27aee4:	mov    0x28(%rax,%rdi,1),%eax
  27aee8:	cmp    $0xffffffff,%eax
  27aeeb:	je     27aef6 <<glass::engine::Watch>::print_utf8+0x18b6>
  27aeed:	mov    %r10,%rcx
  27aef0:	cmp    0x30(%r9),%r12
  27aef4:	jae    27af0f <<glass::engine::Watch>::print_utf8+0x18cf>
  27aef6:	mov    0x10(%r9),%rsi
  27aefa:	cmp    %rsi,%r12
  27aefd:	jae    27b7c2 <<glass::engine::Watch>::print_utf8+0x2182>
  27af03:	lea    (%r12,%r12,2),%rcx
  27af07:	shl    $0x3,%rcx
  27af0b:	add    0x8(%r9),%rcx
  27af0f:	testb  $0x60,0x14(%rcx)
  27af13:	je     27af3c <<glass::engine::Watch>::print_utf8+0x18fc>
  27af15:	mov    %r15,%rdi
  27af18:	mov    %ebp,%esi
  27af1a:	call   359b50 <<glass::engine::Watch as vte::ansi::Handler>::input>
  27af1f:	mov    0xa8(%rsp),%r13
  27af27:	mov    %r13,%rax
  27af2a:	add    $0x108,%rsp
  27af31:	pop    %rbx
  27af32:	pop    %r12
  27af34:	pop    %r13
  27af36:	pop    %r14
  27af38:	pop    %r15
  27af3a:	pop    %rbp
  27af3b:	ret
  27af3c:	cmp    $0x2,%r13
  27af40:	jne    27af74 <<glass::engine::Watch>::print_utf8+0x1934>
  27af42:	lea    0x1(%r12),%rdi
  27af47:	cmp    $0xffffffff,%eax
  27af4a:	je     27af55 <<glass::engine::Watch>::print_utf8+0x1915>
  27af4c:	mov    %r10,%rcx
  27af4f:	cmp    0x30(%r9),%rdi
  27af53:	jae    27af6e <<glass::engine::Watch>::print_utf8+0x192e>
  27af55:	mov    0x10(%r9),%rsi
  27af59:	cmp    %rsi,%rdi
  27af5c:	jae    27b785 <<glass::engine::Watch>::print_utf8+0x2145>
  27af62:	lea    (%rdi,%rdi,2),%rcx
  27af66:	shl    $0x3,%rcx
  27af6a:	add    0x8(%r9),%rcx
  27af6e:	testb  $0x60,0x14(%rcx)
  27af72:	jne    27af15 <<glass::engine::Watch>::print_utf8+0x18d5>
  27af74:	cmp    %r12d,0x38(%r9)
  27af78:	jbe    27af7e <<glass::engine::Watch>::print_utf8+0x193e>
  27af7a:	mov    %r12d,0x38(%r9)
  27af7e:	mov    %r8,0x68(%rsp)
  27af83:	mov    %rdx,0x30(%rsp)
  27af88:	cmp    $0xffffffff,%eax
  27af8b:	setne  %cl
  27af8e:	mov    0x30(%r9),%r15
  27af92:	cmp    %r15,%r12
  27af95:	sete   %dl
  27af98:	test   %dl,%cl
  27af9a:	mov    %r9,0x8(%rsp)
  27af9f:	mov    %r10,0x18(%rsp)
  27afa4:	mov    %ebx,0xb8(%rsp)
  27afab:	jne    27aff4 <<glass::engine::Watch>::print_utf8+0x19b4>
  27afad:	cmp    $0xffffffff,%eax
  27afb0:	je     27b26f <<glass::engine::Watch>::print_utf8+0x1c2f>
  27afb6:	mov    0x10(%r9),%rbx
  27afba:	cmp    %r15,%rbx
  27afbd:	mov    %r15,%rax
  27afc0:	cmovb  %rbx,%rax
  27afc4:	mov    %rax,0x20(%rsp)
  27afc9:	cmp    %r12,%rbx
  27afcc:	mov    %r12,0x38(%rsp)
  27afd1:	cmovb  %rbx,%r12
  27afd5:	mov    0x3b023c(%rip),%rax        # 62b218 <_DYNAMIC+0x338>
  27afdc:	movzbl (%rax),%eax
  27afdf:	test   %al,%al
  27afe1:	je     27b050 <<glass::engine::Watch>::print_utf8+0x1a10>
  27afe3:	mov    %r12,%rcx
  27afe6:	cmp    %r12,%r15
  27afe9:	jae    27b02a <<glass::engine::Watch>::print_utf8+0x19ea>
  27afeb:	mov    0x3b0266(%rip),%rax        # 62b258 <_DYNAMIC+0x378>
  27aff2:	jmp    27b031 <<glass::engine::Watch>::print_utf8+0x19f1>
  27aff4:	lea    0x1(%r12),%rax
  27aff9:	mov    %rax,0x30(%r9)
  27affd:	mov    0x10(%r9),%rsi
  27b001:	cmp    %rsi,%r12
  27b004:	jb     27b290 <<glass::engine::Watch>::print_utf8+0x1c50>
  27b00a:	lea    0x38705f(%rip),%rdx        # 602070 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16890>
  27b011:	mov    %r12,%rdi
  27b014:	call   *0x3b00de(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b01a:	lea    0x386fa7(%rip),%rcx        # 601fc8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x167e8>
  27b021:	mov    %r12,%rdi
  27b024:	call   *0x3b02de(%rip)        # 62b308 <_DYNAMIC+0x428>
  27b02a:	mov    0x3b021f(%rip),%rax        # 62b250 <_DYNAMIC+0x370>
  27b031:	lock incq 0x28(%rax)
  27b036:	mov    %rcx,%r12
  27b039:	mov    %rcx,%rdi
  27b03c:	sub    0x20(%rsp),%rdi
  27b041:	call   313ab0 <alacritty_terminal::grid::row::fill_census::note>
  27b046:	mov    0x8(%rsp),%r9
  27b04b:	mov    0x18(%rsp),%r10
  27b050:	cmp    %r12,%r15
  27b053:	mov    %r12,%r15
  27b056:	jae    27b195 <<glass::engine::Watch>::print_utf8+0x1b55>
  27b05c:	mov    0x28(%r9),%edx
  27b060:	mov    0x20(%r9),%esi
  27b064:	mov    0x24(%r9),%edi
  27b068:	movzwl 0x2c(%r9),%r8d
  27b06d:	mov    0x18(%r9),%rax
  27b071:	test   %rax,%rax
  27b074:	mov    0x38(%rsp),%r12
  27b079:	je     27b089 <<glass::engine::Watch>::print_utf8+0x1a49>
  27b07b:	lock incq (%rax)
  27b07f:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27b085:	mov    0x10(%r9),%rbx
  27b089:	movzwl 0x2e(%r9),%r11d
  27b08e:	mov    %edx,0x98(%rsp)
  27b095:	mov    %esi,0x90(%rsp)
  27b09c:	mov    %edi,0x94(%rsp)
  27b0a3:	mov    %r8w,0x9c(%rsp)
  27b0ac:	mov    %rax,0x88(%rsp)
  27b0b4:	mov    %r11w,0x9e(%rsp)
  27b0bd:	cmp    %rbx,%r15
  27b0c0:	mov    %rax,(%rsp)
  27b0c4:	ja     27b73f <<glass::engine::Watch>::print_utf8+0x20ff>
  27b0ca:	mov    0x20(%rsp),%rcx
  27b0cf:	lea    (%rcx,%rcx,2),%rbx
  27b0d3:	shl    $0x3,%rbx
  27b0d7:	add    0x8(%r9),%rbx
  27b0db:	test   %rax,%rax
  27b0de:	mov    %edx,0x28(%rsp)
  27b0e2:	mov    %esi,0x48(%rsp)
  27b0e6:	mov    %edi,0x60(%rsp)
  27b0ea:	mov    %r8w,0x80(%rsp)
  27b0f3:	mov    %r11w,0x40(%rsp)
  27b0f9:	mov    %r15,0x58(%rsp)
  27b0fe:	lea    0x0(,%r15,8),%rax
  27b106:	lea    (%rax,%rax,2),%r15
  27b10a:	lea    0x0(,%rcx,8),%rax
  27b112:	lea    (%rax,%rax,2),%rax
  27b116:	je     27b19f <<glass::engine::Watch>::print_utf8+0x1b5f>
  27b11c:	sub    %rax,%r15
  27b11f:	mov    (%rsp),%rcx
  27b123:	jmp    27b149 <<glass::engine::Watch>::print_utf8+0x1b09>
  27b125:	mov    %rcx,(%rbx)
  27b128:	mov    %esi,0x8(%rbx)
  27b12b:	mov    %edi,0xc(%rbx)
  27b12e:	mov    %edx,0x10(%rbx)
  27b131:	mov    %r8w,0x14(%rbx)
  27b136:	mov    %r11w,0x16(%rbx)
  27b13b:	add    $0x18,%rbx
  27b13f:	add    $0xffffffffffffffe8,%r15
  27b143:	je     27b20e <<glass::engine::Watch>::print_utf8+0x1bce>
  27b149:	lock incq (%rcx)
  27b14d:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27b153:	mov    (%rbx),%rax
  27b156:	test   %rax,%rax
  27b159:	je     27b125 <<glass::engine::Watch>::print_utf8+0x1ae5>
  27b15b:	lock decq (%rax)
  27b15f:	jne    27b125 <<glass::engine::Watch>::print_utf8+0x1ae5>
  27b161:	mov    %rbx,%rdi
  27b164:	call   *0x3affe6(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b16a:	movzwl 0x40(%rsp),%r11d
  27b170:	movzwl 0x80(%rsp),%r8d
  27b179:	mov    0x60(%rsp),%edi
  27b17d:	mov    0x48(%rsp),%esi
  27b181:	mov    0x28(%rsp),%edx
  27b185:	mov    (%rsp),%rcx
  27b189:	mov    0x18(%rsp),%r10
  27b18e:	mov    0x8(%rsp),%r9
  27b193:	jmp    27b125 <<glass::engine::Watch>::print_utf8+0x1ae5>
  27b195:	mov    0x38(%rsp),%r12
  27b19a:	jmp    27b249 <<glass::engine::Watch>::print_utf8+0x1c09>
  27b19f:	sub    %rax,%r15
  27b1a2:	mov    (%rsp),%rcx
  27b1a6:	jmp    27b1cc <<glass::engine::Watch>::print_utf8+0x1b8c>
  27b1a8:	movq   $0x0,(%rbx)
  27b1af:	mov    %esi,0x8(%rbx)
  27b1b2:	mov    %edi,0xc(%rbx)
  27b1b5:	mov    %edx,0x10(%rbx)
  27b1b8:	mov    %r8w,0x14(%rbx)
  27b1bd:	mov    %r11w,0x16(%rbx)
  27b1c2:	add    $0x18,%rbx
  27b1c6:	add    $0xffffffffffffffe8,%r15
  27b1ca:	je     27b20e <<glass::engine::Watch>::print_utf8+0x1bce>
  27b1cc:	mov    (%rbx),%rax
  27b1cf:	test   %rax,%rax
  27b1d2:	je     27b1a8 <<glass::engine::Watch>::print_utf8+0x1b68>
  27b1d4:	lock decq (%rax)
  27b1d8:	jne    27b1a8 <<glass::engine::Watch>::print_utf8+0x1b68>
  27b1da:	mov    %rbx,%rdi
  27b1dd:	call   *0x3aff6d(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b1e3:	movzwl 0x40(%rsp),%r11d
  27b1e9:	movzwl 0x80(%rsp),%r8d
  27b1f2:	mov    0x60(%rsp),%edi
  27b1f6:	mov    0x48(%rsp),%esi
  27b1fa:	mov    0x28(%rsp),%edx
  27b1fe:	mov    (%rsp),%rcx
  27b202:	mov    0x18(%rsp),%r10
  27b207:	mov    0x8(%rsp),%r9
  27b20c:	jmp    27b1a8 <<glass::engine::Watch>::print_utf8+0x1b68>
  27b20e:	mov    0x20(%rsp),%rax
  27b213:	cmp    %eax,0x38(%r9)
  27b217:	jbe    27b21d <<glass::engine::Watch>::print_utf8+0x1bdd>
  27b219:	mov    %eax,0x38(%r9)
  27b21d:	test   %rcx,%rcx
  27b220:	mov    0x58(%rsp),%r15
  27b225:	je     27b245 <<glass::engine::Watch>::print_utf8+0x1c05>
  27b227:	lock decq (%rcx)
  27b22b:	jne    27b245 <<glass::engine::Watch>::print_utf8+0x1c05>
  27b22d:	lea    0x88(%rsp),%rdi
  27b235:	call   *0x3aff15(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b23b:	mov    0x18(%rsp),%r10
  27b240:	mov    0x8(%rsp),%r9
  27b245:	mov    0x10(%r9),%rbx
  27b249:	cmp    %rbx,%r15
  27b24c:	mov    0xb8(%rsp),%ebx
  27b253:	jb     27b26f <<glass::engine::Watch>::print_utf8+0x1c2f>
  27b255:	mov    %r10,%rdi
  27b258:	call   1b98b0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  27b25d:	mov    0x18(%rsp),%r10
  27b262:	mov    0x8(%rsp),%r9
  27b267:	movl   $0xffffffff,0x28(%r9)
  27b26f:	mov    0x30(%r9),%rax
  27b273:	lea    0x1(%r12),%rcx
  27b278:	cmp    %rax,%rcx
  27b27b:	cmova  %rcx,%rax
  27b27f:	mov    0x10(%r9),%rsi
  27b283:	mov    %rax,0x30(%r9)
  27b287:	cmp    %rsi,%r12
  27b28a:	jae    27b7b2 <<glass::engine::Watch>::print_utf8+0x2172>
  27b290:	mov    %ebx,%eax
  27b292:	or     $0x20,%eax
  27b295:	cmp    $0x2,%r13
  27b299:	mov    0x8(%r9),%rcx
  27b29d:	lea    (%r12,%r12,2),%rdx
  27b2a1:	mov    %ebx,%esi
  27b2a3:	lea    (%rcx,%rdx,8),%rbx
  27b2a7:	mov    %ebp,0x10(%rcx,%rdx,8)
  27b2ab:	mov    0x14(%rsp),%edi
  27b2af:	mov    %edi,0x8(%rcx,%rdx,8)
  27b2b3:	cmovne %esi,%eax
  27b2b6:	mov    0x70(%rsp),%esi
  27b2ba:	mov    %esi,0xc(%rcx,%rdx,8)
  27b2be:	mov    %ax,0x14(%rcx,%rdx,8)
  27b2c3:	mov    (%rcx,%rdx,8),%rax
  27b2c7:	test   %rax,%rax
  27b2ca:	mov    0xc8(%rsp),%r15
  27b2d2:	je     27b2ed <<glass::engine::Watch>::print_utf8+0x1cad>
  27b2d4:	lock decq (%rax)
  27b2d8:	jne    27b2ed <<glass::engine::Watch>::print_utf8+0x1cad>
  27b2da:	mov    %rbx,%rdi
  27b2dd:	call   *0x3afe6d(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b2e3:	mov    0x18(%rsp),%r10
  27b2e8:	mov    0x8(%rsp),%r9
  27b2ed:	movq   $0x0,(%rbx)
  27b2f4:	movw   $0x0,0x16(%rbx)
  27b2fa:	cmp    $0x2,%r13
  27b2fe:	jne    27b666 <<glass::engine::Watch>::print_utf8+0x2026>
  27b304:	lea    0x1(%r12),%rbx
  27b309:	mov    0x30(%r9),%r13
  27b30d:	mov    0x28(%r9),%eax
  27b311:	cmp    %r13,%rbx
  27b314:	jne    27b340 <<glass::engine::Watch>::print_utf8+0x1d00>
  27b316:	cmp    $0xffffffff,%eax
  27b319:	je     27b340 <<glass::engine::Watch>::print_utf8+0x1d00>
  27b31b:	add    $0x2,%r12
  27b31f:	mov    %r12,0x30(%r9)
  27b323:	mov    0x10(%r9),%rsi
  27b327:	cmp    %rsi,%rbx
  27b32a:	jb     27b60e <<glass::engine::Watch>::print_utf8+0x1fce>
  27b330:	lea    0x386d39(%rip),%rdx        # 602070 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16890>
  27b337:	mov    %rbx,%rdi
  27b33a:	call   *0x3afdb8(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b340:	cmp    $0xffffffff,%eax
  27b343:	je     27b5ee <<glass::engine::Watch>::print_utf8+0x1fae>
  27b349:	mov    0x10(%r9),%rdx
  27b34d:	cmp    %r13,%rdx
  27b350:	mov    %r13,%rcx
  27b353:	cmovb  %rdx,%rcx
  27b357:	mov    %rcx,0x20(%rsp)
  27b35c:	cmp    %rbx,%rdx
  27b35f:	mov    %rdx,(%rsp)
  27b363:	cmovb  %rdx,%rbx
  27b367:	mov    0x3afeaa(%rip),%rax        # 62b218 <_DYNAMIC+0x338>
  27b36e:	movzbl (%rax),%eax
  27b371:	test   %al,%al
  27b373:	je     27b3ac <<glass::engine::Watch>::print_utf8+0x1d6c>
  27b375:	mov    %rbx,%rcx
  27b378:	cmp    %rbx,%r13
  27b37b:	jae    27b386 <<glass::engine::Watch>::print_utf8+0x1d46>
  27b37d:	mov    0x3afed4(%rip),%rax        # 62b258 <_DYNAMIC+0x378>
  27b384:	jmp    27b38d <<glass::engine::Watch>::print_utf8+0x1d4d>
  27b386:	mov    0x3afec3(%rip),%rax        # 62b250 <_DYNAMIC+0x370>
  27b38d:	lock incq 0x28(%rax)
  27b392:	mov    %rcx,%rbx
  27b395:	mov    %rcx,%rdi
  27b398:	sub    0x20(%rsp),%rdi
  27b39d:	call   313ab0 <alacritty_terminal::grid::row::fill_census::note>
  27b3a2:	mov    0x8(%rsp),%r9
  27b3a7:	mov    0x18(%rsp),%r10
  27b3ac:	cmp    %rbx,%r13
  27b3af:	mov    %rbx,%rsi
  27b3b2:	jae    27b4fc <<glass::engine::Watch>::print_utf8+0x1ebc>
  27b3b8:	mov    0x28(%r9),%ecx
  27b3bc:	mov    0x20(%r9),%r13d
  27b3c0:	mov    0x24(%r9),%r8d
  27b3c4:	movzwl 0x2c(%r9),%r11d
  27b3c9:	mov    0x18(%r9),%r15
  27b3cd:	test   %r15,%r15
  27b3d0:	mov    0x20(%rsp),%rdi
  27b3d5:	mov    (%rsp),%rdx
  27b3d9:	mov    %r15,0x28(%rsp)
  27b3de:	je     27b3f3 <<glass::engine::Watch>::print_utf8+0x1db3>
  27b3e0:	lock incq (%r15)
  27b3e4:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27b3ea:	mov    0x10(%r9),%rdx
  27b3ee:	mov    0x28(%rsp),%r15
  27b3f3:	movzwl 0x2e(%r9),%eax
  27b3f8:	mov    %ecx,0x98(%rsp)
  27b3ff:	mov    %r13d,0x90(%rsp)
  27b407:	mov    %r8d,0x94(%rsp)
  27b40f:	mov    %r11w,0x9c(%rsp)
  27b418:	mov    %r15,0x88(%rsp)
  27b420:	mov    %ax,(%rsp)
  27b424:	mov    %ax,0x9e(%rsp)
  27b42c:	cmp    %rdx,%rsi
  27b42f:	ja     27b776 <<glass::engine::Watch>::print_utf8+0x2136>
  27b435:	lea    (%rdi,%rdi,2),%rbx
  27b439:	shl    $0x3,%rbx
  27b43d:	add    0x8(%r9),%rbx
  27b441:	test   %r15,%r15
  27b444:	mov    %ecx,0x48(%rsp)
  27b448:	mov    %r13d,0x60(%rsp)
  27b44d:	mov    %r8d,0x80(%rsp)
  27b455:	mov    %r11w,0x40(%rsp)
  27b45b:	mov    %r15,%rdx
  27b45e:	mov    %rsi,0x38(%rsp)
  27b463:	lea    0x0(,%rsi,8),%rax
  27b46b:	lea    (%rax,%rax,2),%r15
  27b46f:	lea    0x0(,%rdi,8),%rax
  27b477:	lea    (%rax,%rax,2),%rax
  27b47b:	je     27b515 <<glass::engine::Watch>::print_utf8+0x1ed5>
  27b481:	sub    %rax,%r15
  27b484:	movzwl (%rsp),%esi
  27b488:	jmp    27b4af <<glass::engine::Watch>::print_utf8+0x1e6f>
  27b48a:	mov    %rdx,(%rbx)
  27b48d:	mov    %r13d,0x8(%rbx)
  27b491:	mov    %r8d,0xc(%rbx)
  27b495:	mov    %ecx,0x10(%rbx)
  27b498:	mov    %r11w,0x14(%rbx)
  27b49d:	mov    %si,0x16(%rbx)
  27b4a1:	add    $0x18,%rbx
  27b4a5:	add    $0xffffffffffffffe8,%r15
  27b4a9:	je     27b586 <<glass::engine::Watch>::print_utf8+0x1f46>
  27b4af:	lock incq (%rdx)
  27b4b3:	jle    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27b4b9:	mov    (%rbx),%rax
  27b4bc:	test   %rax,%rax
  27b4bf:	je     27b48a <<glass::engine::Watch>::print_utf8+0x1e4a>
  27b4c1:	lock decq (%rax)
  27b4c5:	jne    27b48a <<glass::engine::Watch>::print_utf8+0x1e4a>
  27b4c7:	mov    %rbx,%rdi
  27b4ca:	call   *0x3afc80(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b4d0:	mov    0x28(%rsp),%rdx
  27b4d5:	movzwl (%rsp),%esi
  27b4d9:	movzwl 0x40(%rsp),%r11d
  27b4df:	mov    0x80(%rsp),%r8d
  27b4e7:	mov    0x60(%rsp),%r13d
  27b4ec:	mov    0x48(%rsp),%ecx
  27b4f0:	mov    0x18(%rsp),%r10
  27b4f5:	mov    0x8(%rsp),%r9
  27b4fa:	jmp    27b48a <<glass::engine::Watch>::print_utf8+0x1e4a>
  27b4fc:	mov    (%rsp),%rax
  27b500:	jmp    27b5cf <<glass::engine::Watch>::print_utf8+0x1f8f>
  27b505:	cmpb   $0x0,0x6b(%rax)
  27b509:	sete   %al
  27b50c:	mov    %eax,0x20(%rsp)
  27b510:	jmp    2796a2 <<glass::engine::Watch>::print_utf8+0x62>
  27b515:	sub    %rax,%r15
  27b518:	movzwl (%rsp),%esi
  27b51c:	jmp    27b543 <<glass::engine::Watch>::print_utf8+0x1f03>
  27b51e:	movq   $0x0,(%rbx)
  27b525:	mov    %r13d,0x8(%rbx)
  27b529:	mov    %r8d,0xc(%rbx)
  27b52d:	mov    %ecx,0x10(%rbx)
  27b530:	mov    %r11w,0x14(%rbx)
  27b535:	mov    %si,0x16(%rbx)
  27b539:	add    $0x18,%rbx
  27b53d:	add    $0xffffffffffffffe8,%r15
  27b541:	je     27b586 <<glass::engine::Watch>::print_utf8+0x1f46>
  27b543:	mov    (%rbx),%rax
  27b546:	test   %rax,%rax
  27b549:	je     27b51e <<glass::engine::Watch>::print_utf8+0x1ede>
  27b54b:	lock decq (%rax)
  27b54f:	jne    27b51e <<glass::engine::Watch>::print_utf8+0x1ede>
  27b551:	mov    %rbx,%rdi
  27b554:	call   *0x3afbf6(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b55a:	mov    0x28(%rsp),%rdx
  27b55f:	movzwl (%rsp),%esi
  27b563:	movzwl 0x40(%rsp),%r11d
  27b569:	mov    0x80(%rsp),%r8d
  27b571:	mov    0x60(%rsp),%r13d
  27b576:	mov    0x48(%rsp),%ecx
  27b57a:	mov    0x18(%rsp),%r10
  27b57f:	mov    0x8(%rsp),%r9
  27b584:	jmp    27b51e <<glass::engine::Watch>::print_utf8+0x1ede>
  27b586:	mov    0x20(%rsp),%rax
  27b58b:	cmp    %eax,0x38(%r9)
  27b58f:	jbe    27b595 <<glass::engine::Watch>::print_utf8+0x1f55>
  27b591:	mov    %eax,0x38(%r9)
  27b595:	test   %rdx,%rdx
  27b598:	mov    0xc8(%rsp),%r15
  27b5a0:	mov    0x38(%rsp),%rsi
  27b5a5:	je     27b5cb <<glass::engine::Watch>::print_utf8+0x1f8b>
  27b5a7:	lock decq (%rdx)
  27b5ab:	jne    27b5cb <<glass::engine::Watch>::print_utf8+0x1f8b>
  27b5ad:	lea    0x88(%rsp),%rdi
  27b5b5:	mov    %rsi,%rbx
  27b5b8:	call   *0x3afb92(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b5be:	mov    %rbx,%rsi
  27b5c1:	mov    0x18(%rsp),%r10
  27b5c6:	mov    0x8(%rsp),%r9
  27b5cb:	mov    0x10(%r9),%rax
  27b5cf:	cmp    %rax,%rsi
  27b5d2:	lea    0x1(%r12),%rbx
  27b5d7:	jb     27b5ee <<glass::engine::Watch>::print_utf8+0x1fae>
  27b5d9:	mov    %r10,%rdi
  27b5dc:	call   1b98b0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  27b5e1:	mov    0x8(%rsp),%r9
  27b5e6:	movl   $0xffffffff,0x28(%r9)
  27b5ee:	mov    0x30(%r9),%rax
  27b5f2:	add    $0x2,%r12
  27b5f6:	cmp    %rax,%r12
  27b5f9:	cmovbe %rax,%r12
  27b5fd:	mov    0x10(%r9),%rsi
  27b601:	mov    %r12,0x30(%r9)
  27b605:	cmp    %rsi,%rbx
  27b608:	jae    27b7d2 <<glass::engine::Watch>::print_utf8+0x2192>
  27b60e:	mov    0x8(%r9),%rax
  27b612:	lea    (%rbx,%rbx,2),%rcx
  27b616:	lea    (%rax,%rcx,8),%rbx
  27b61a:	movl   $0x20,0x10(%rax,%rcx,8)
  27b622:	mov    0x14(%rsp),%edx
  27b626:	mov    %edx,0x8(%rax,%rcx,8)
  27b62a:	mov    0x70(%rsp),%edx
  27b62e:	mov    %edx,0xc(%rax,%rcx,8)
  27b632:	mov    0xb8(%rsp),%edx
  27b639:	or     $0x40,%edx
  27b63c:	mov    %dx,0x14(%rax,%rcx,8)
  27b641:	mov    (%rax,%rcx,8),%rax
  27b645:	test   %rax,%rax
  27b648:	je     27b659 <<glass::engine::Watch>::print_utf8+0x2019>
  27b64a:	lock decq (%rax)
  27b64e:	jne    27b659 <<glass::engine::Watch>::print_utf8+0x2019>
  27b650:	mov    %rbx,%rdi
  27b653:	call   *0x3afaf7(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b659:	movq   $0x0,(%rbx)
  27b660:	movw   $0x0,0x16(%rbx)
  27b666:	mov    0x30(%rsp),%rax
  27b66b:	cmp    0x68(%rsp),%rax
  27b670:	jb     27b67a <<glass::engine::Watch>::print_utf8+0x203a>
  27b672:	dec    %rax
  27b675:	movb   $0x1,0x6c(%r14)
  27b67a:	mov    0xa8(%rsp),%r13
  27b682:	mov    %rax,0x40(%r14)
  27b686:	incq   0xa0(%r15)
  27b68d:	mov    %ebp,0xb0(%r15)
  27b694:	jmp    27af27 <<glass::engine::Watch>::print_utf8+0x18e7>
  27b699:	call   195692 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  27b69e:	mov    %ebp,%ebx
  27b6a0:	mov    0x3b4311(%rip),%rsi        # 62f9b8 <glass::engine::width_of::CACHE+0x8>
  27b6a7:	cmp    %rbx,%rsi
  27b6aa:	ja     27adcc <<glass::engine::Watch>::print_utf8+0x178c>
  27b6b0:	lea    0x388e49(%rip),%rdx        # 604500 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18d20>
  27b6b7:	mov    %rbx,%rdi
  27b6ba:	call   *0x3afa38(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b6c0:	lea    0x385d91(%rip),%rcx        # 601458 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  27b6c7:	mov    0x50(%rsp),%rdi
  27b6cc:	call   *0x3afc36(%rip)        # 62b308 <_DYNAMIC+0x428>
  27b6d2:	jmp    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27b6d7:	lea    0x385d7a(%rip),%rcx        # 601458 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  27b6de:	mov    %rbx,%rdi
  27b6e1:	call   *0x3afc21(%rip)        # 62b308 <_DYNAMIC+0x428>
  27b6e7:	jmp    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27b6ec:	lea    0x38625d(%rip),%rdx        # 601950 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16170>
  27b6f3:	call   *0x3af9ff(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b6f9:	lea    0x386268(%rip),%rax        # 601968 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16188>
  27b700:	jmp    27b721 <<glass::engine::Watch>::print_utf8+0x20e1>
  27b702:	lea    0x3862a7(%rip),%rdx        # 6019b0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161d0>
  27b709:	mov    %rbx,%rdi
  27b70c:	mov    0x8(%rsp),%rsi
  27b711:	call   *0x3af9e1(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b717:	mov    %rax,%rbx
  27b71a:	lea    0x38625f(%rip),%rax        # 601980 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161a0>
  27b721:	mov    %rax,0xf8(%rsp)
  27b729:	mov    %rbx,%rdi
  27b72c:	mov    0x8(%rsp),%rsi
  27b731:	mov    0xf8(%rsp),%rdx
  27b739:	call   *0x3af9b9(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b73f:	lea    0x385d12(%rip),%rcx        # 601458 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  27b746:	mov    0x20(%rsp),%rdi
  27b74b:	mov    %r15,%rsi
  27b74e:	mov    %rbx,%rdx
  27b751:	call   *0x3afbb1(%rip)        # 62b308 <_DYNAMIC+0x428>
  27b757:	jmp    27b783 <<glass::engine::Watch>::print_utf8+0x2143>
  27b759:	lea    0x386370(%rip),%rdx        # 601ad0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x162f0>
  27b760:	call   *0x3af992(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b766:	lea    0x3737b3(%rip),%rdx        # 5eef20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  27b76d:	mov    %r11,%rdi
  27b770:	call   *0x3af982(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b776:	lea    0x385cdb(%rip),%rcx        # 601458 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  27b77d:	call   *0x3afb85(%rip)        # 62b308 <_DYNAMIC+0x428>
  27b783:	ud2
  27b785:	lea    0x373794(%rip),%rdx        # 5eef20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  27b78c:	call   *0x3af966(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b792:	lea    0x3868d7(%rip),%rdx        # 602070 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16890>
  27b799:	mov    %r11,%rdi
  27b79c:	call   *0x3af956(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b7a2:	lea    0x3868af(%rip),%rdx        # 602058 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  27b7a9:	mov    %r11,%rdi
  27b7ac:	call   *0x3af946(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b7b2:	lea    0x38689f(%rip),%rdx        # 602058 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  27b7b9:	mov    %r12,%rdi
  27b7bc:	call   *0x3af936(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b7c2:	lea    0x373757(%rip),%rdx        # 5eef20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  27b7c9:	mov    %r12,%rdi
  27b7cc:	call   *0x3af926(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b7d2:	lea    0x38687f(%rip),%rdx        # 602058 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  27b7d9:	mov    %rbx,%rdi
  27b7dc:	call   *0x3af916(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  27b7e2:	mov    %rax,%rbx
  27b7e5:	cmpq   $0x0,0x28(%rsp)
  27b7eb:	je     27b83a <<glass::engine::Watch>::print_utf8+0x21fa>
  27b7ed:	mov    0x28(%rsp),%rax
  27b7f2:	jmp    27b826 <<glass::engine::Watch>::print_utf8+0x21e6>
  27b7f4:	mov    %rax,%rbx
  27b7f7:	cmpq   $0x0,(%rsp)
  27b7fc:	je     27b83a <<glass::engine::Watch>::print_utf8+0x21fa>
  27b7fe:	mov    (%rsp),%rax
  27b802:	jmp    27b826 <<glass::engine::Watch>::print_utf8+0x21e6>
  27b804:	mov    %rax,%rbx
  27b807:	cmpq   $0x0,0x58(%rsp)
  27b80d:	je     27b83a <<glass::engine::Watch>::print_utf8+0x21fa>
  27b80f:	mov    0x58(%rsp),%rax
  27b814:	jmp    27b826 <<glass::engine::Watch>::print_utf8+0x21e6>
  27b816:	mov    %rax,%rbx
  27b819:	cmpq   $0x0,0x78(%rsp)
  27b81f:	je     27b83a <<glass::engine::Watch>::print_utf8+0x21fa>
  27b821:	mov    0x78(%rsp),%rax
  27b826:	lock decq (%rax)
  27b82a:	jne    27b83a <<glass::engine::Watch>::print_utf8+0x21fa>
  27b82c:	mov    0x100(%rsp),%rdi
  27b834:	call   *0x3af916(%rip)        # 62b150 <_DYNAMIC+0x270>
  27b83a:	mov    %rbx,%rdi
  27b83d:	call   5e7630 <_Unwind_Resume@plt>
