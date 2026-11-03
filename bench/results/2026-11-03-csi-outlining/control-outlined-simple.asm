
/tmp/glass-i26-control-outlined-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002a1700 <glass::engine::simple>:
  2a1700:	push   %rbp
  2a1701:	push   %r14
  2a1703:	push   %rbx
  2a1704:	sub    $0x20,%rsp
  2a1708:	mov    $0x2,%r8b
  2a170b:	cmp    $0x2,%rdx
  2a170f:	jb     2a1875 <glass::engine::simple+0x175>
  2a1715:	cmpb   $0x5b,0x1(%rsi)
  2a1719:	jne    2a1875 <glass::engine::simple+0x175>
  2a171f:	xorps  %xmm0,%xmm0
  2a1722:	movaps %xmm0,0x10(%rsp)
  2a1727:	movaps %xmm0,(%rsp)
  2a172b:	cmp    $0x2,%rdx
  2a172f:	je     2a1875 <glass::engine::simple+0x175>
  2a1735:	movzbl 0x2(%rsi),%r11d
  2a173a:	lea    -0x30(%r11),%eax
  2a173e:	cmp    $0xa,%al
  2a1740:	jae    2a176b <glass::engine::simple+0x6b>
  2a1742:	movzbl %al,%eax
  2a1745:	xor    %ecx,%ecx
  2a1747:	cmp    $0x3,%rdx
  2a174b:	je     2a1875 <glass::engine::simple+0x175>
  2a1751:	mov    $0x3,%r10d
  2a1757:	sub    %rdx,%r10
  2a175a:	mov    $0x4,%r9d
  2a1760:	mov    $0xa,%bx
  2a1764:	mov    $0xffff,%ebp
  2a1769:	jmp    2a17c4 <glass::engine::simple+0xc4>
  2a176b:	movzbl %r11b,%r9d
  2a176f:	xor    %eax,%eax
  2a1771:	lea    -0x48(%r9),%ecx
  2a1775:	cmp    $0x25,%ecx
  2a1778:	ja     2a1792 <glass::engine::simple+0x92>
  2a177a:	mov    $0x3,%r9d
  2a1780:	lea    -0x2320c3(%rip),%rdx        # 6f6c4 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x3c13>
  2a1787:	movslq (%rdx,%rcx,4),%rsi
  2a178b:	add    %rdx,%rsi
  2a178e:	xor    %ecx,%ecx
  2a1790:	jmp    *%rsi
  2a1792:	mov    $0x1,%ecx
  2a1797:	cmp    $0x3b,%r9d
  2a179b:	je     2a1747 <glass::engine::simple+0x47>
  2a179d:	jmp    2a1875 <glass::engine::simple+0x175>
  2a17a2:	mov    $0xffff,%dx
  2a17a6:	movzbl %r14b,%eax
  2a17aa:	add    %dx,%ax
  2a17ad:	cmovb  %ebp,%eax
  2a17b0:	lea    (%r10,%r9,1),%rdx
  2a17b4:	inc    %rdx
  2a17b7:	inc    %r9
  2a17ba:	cmp    $0x4,%rdx
  2a17be:	je     2a1875 <glass::engine::simple+0x175>
  2a17c4:	movzbl -0x1(%rsi,%r9,1),%r11d
  2a17ca:	lea    -0x30(%r11),%r14d
  2a17ce:	cmp    $0xa,%r14b
  2a17d2:	jae    2a17dd <glass::engine::simple+0xdd>
  2a17d4:	mul    %bx
  2a17d7:	jo     2a17a2 <glass::engine::simple+0xa2>
  2a17d9:	mov    %eax,%edx
  2a17db:	jmp    2a17a6 <glass::engine::simple+0xa6>
  2a17dd:	movzbl %r11b,%edx
  2a17e1:	cmp    $0x3b,%edx
  2a17e4:	jne    2a1809 <glass::engine::simple+0x109>
  2a17e6:	lea    0x1(%rcx),%rdx
  2a17ea:	cmp    $0x10,%rdx
  2a17ee:	jae    2a1875 <glass::engine::simple+0x175>
  2a17f4:	cmp    $0xf,%rcx
  2a17f8:	ja     2a1882 <glass::engine::simple+0x182>
  2a17fe:	mov    %ax,(%rsp,%rcx,2)
  2a1802:	xor    %eax,%eax
  2a1804:	mov    %rdx,%rcx
  2a1807:	jmp    2a17b0 <glass::engine::simple+0xb0>
  2a1809:	add    $0xffffffb8,%edx
  2a180c:	cmp    $0x25,%edx
  2a180f:	ja     2a1875 <glass::engine::simple+0x175>
  2a1811:	lea    -0x2320bc(%rip),%rsi        # 6f75c <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x3cab>
  2a1818:	movslq (%rsi,%rdx,4),%rdx
  2a181c:	add    %rsi,%rdx
  2a181f:	jmp    *%rdx
  2a1821:	cmp    $0x10,%rcx
  2a1825:	jae    2a1897 <glass::engine::simple+0x197>
  2a1827:	mov    %ax,(%rsp,%rcx,2)
  2a182b:	cmp    $0x6d,%r11b
  2a182f:	setne  %al
  2a1832:	movaps (%rsp),%xmm0
  2a1836:	movaps 0x10(%rsp),%xmm1
  2a183b:	movups %xmm1,0x18(%rdi)
  2a183f:	movups %xmm0,0x8(%rdi)
  2a1843:	xor    %r8d,%r8d
  2a1846:	jmp    2a1868 <glass::engine::simple+0x168>
  2a1848:	cmp    $0x10,%rcx
  2a184c:	jae    2a18ac <glass::engine::simple+0x1ac>
  2a184e:	mov    %ax,(%rsp,%rcx,2)
  2a1852:	movaps (%rsp),%xmm0
  2a1856:	movaps 0x10(%rsp),%xmm1
  2a185b:	movups %xmm1,0x18(%rdi)
  2a185f:	movups %xmm0,0x8(%rdi)
  2a1863:	mov    $0x1,%r8b
  2a1866:	xor    %eax,%eax
  2a1868:	inc    %rcx
  2a186b:	mov    %r9,(%rdi)
  2a186e:	mov    %rcx,0x28(%rdi)
  2a1872:	mov    %al,0x30(%rdi)
  2a1875:	mov    %r8b,0x31(%rdi)
  2a1879:	add    $0x20,%rsp
  2a187d:	pop    %rbx
  2a187e:	pop    %r14
  2a1880:	pop    %rbp
  2a1881:	ret
  2a1882:	lea    0x329b7f(%rip),%rdx        # 5cb408 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c88>
  2a1889:	mov    $0x10,%esi
  2a188e:	mov    %rcx,%rdi
  2a1891:	call   *0x3500e1(%rip)        # 5f1978 <_DYNAMIC+0x218>
  2a1897:	lea    0x329b82(%rip),%rdx        # 5cb420 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17ca0>
  2a189e:	mov    $0x10,%esi
  2a18a3:	mov    %rcx,%rdi
  2a18a6:	call   *0x3500cc(%rip)        # 5f1978 <_DYNAMIC+0x218>
  2a18ac:	lea    0x329b85(%rip),%rdx        # 5cb438 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cb8>
  2a18b3:	mov    $0x10,%esi
  2a18b8:	mov    %rcx,%rdi
  2a18bb:	call   *0x3500b7(%rip)        # 5f1978 <_DYNAMIC+0x218>
