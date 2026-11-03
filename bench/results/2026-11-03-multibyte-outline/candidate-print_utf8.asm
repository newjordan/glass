
/tmp/glass-i29-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002623a0 <<glass::engine::Watch>::print_utf8>:
  2623a0:	push   %rbp
  2623a1:	push   %r15
  2623a3:	push   %r14
  2623a5:	push   %r13
  2623a7:	push   %r12
  2623a9:	push   %rbx
  2623aa:	sub    $0x118,%rsp
  2623b1:	mov    %rdx,%r8
  2623b4:	mov    %rsi,%rbp
  2623b7:	mov    %rdi,%r12
  2623ba:	cmpb   $0x1,0xbe(%rdi)
  2623c1:	jne    2623f0 <<glass::engine::Watch>::print_utf8+0x50>
  2623c3:	cmpq   $0x0,0x38(%r12)
  2623c9:	jne    2623f0 <<glass::engine::Watch>::print_utf8+0x50>
  2623cb:	mov    0x78(%r12),%rax
  2623d0:	testb  $0x4,0x6c5(%rax)
  2623d7:	jne    2623f0 <<glass::engine::Watch>::print_utf8+0x50>
  2623d9:	cmpq   $0x0,0x50(%rax)
  2623de:	jne    2623f0 <<glass::engine::Watch>::print_utf8+0x50>
  2623e0:	movzwl 0x64(%rax),%ecx
  2623e4:	test   $0x460,%ecx
  2623ea:	je     2638d7 <<glass::engine::Watch>::print_utf8+0x1537>
  2623f0:	movl   $0x0,0x1c(%rsp)
  2623f8:	movl   $0x0,0x98(%rsp)
  262403:	mov    $0xffffffff,%r15d
  262409:	xor    %r14d,%r14d
  26240c:	lea    0x365915(%rip),%rax        # 5c7d28 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15468>
  262413:	mov    %rax,0xd8(%rsp)
  26241b:	lea    0x50(%rsp),%rax
  262420:	mov    %rax,0x108(%rsp)
  262428:	xor    %edx,%edx
  26242a:	mov    %r8,0x90(%rsp)
  262432:	mov    %r12,0xb0(%rsp)
  26243a:	mov    %rbp,0x70(%rsp)
  26243f:	jmp    262474 <<glass::engine::Watch>::print_utf8+0xd4>
  262441:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262450:	mov    %r12,%rdi
  262453:	mov    %r13d,%esi
  262456:	mov    %rdx,%rbx
  262459:	mov    %r8,%r14
  26245c:	call   33d150 <<glass::engine::Watch as vte::ansi::Handler>::input>
  262461:	mov    %r14,%r8
  262464:	mov    %rbx,%rdx
  262467:	mov    0x70(%rsp),%rbp
  26246c:	mov    0x28(%rsp),%r14
  262471:	add    %r14,%rdx
  262474:	cmpb   $0x0,0x98(%rsp)
  26247c:	je     26248a <<glass::engine::Watch>::print_utf8+0xea>
  26247e:	mov    0x78(%r12),%r13
  262483:	cmpb   $0x0,0x6c(%r13)
  262488:	je     2624b0 <<glass::engine::Watch>::print_utf8+0x110>
  26248a:	mov    %r15d,%r13d
  26248d:	mov    %r14,%rbx
  262490:	mov    %rdx,%r14
  262493:	cmp    %r8,%rdx
  262496:	jb     262db2 <<glass::engine::Watch>::print_utf8+0xa12>
  26249c:	jmp    2637d2 <<glass::engine::Watch>::print_utf8+0x1432>
  2624a1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2624b0:	mov    0x30(%r13),%eax
  2624b4:	sub    0x48(%r13),%eax
  2624b8:	cltq
  2624ba:	mov    0x20(%r13),%rsi
  2624be:	mov    0x28(%r13),%rcx
  2624c2:	lea    (%rcx,%rax,1),%rdi
  2624c6:	dec    %rdi
  2624c9:	cmp    %rsi,%rdi
  2624cc:	mov    $0x0,%eax
  2624d1:	cmovae %rsi,%rax
  2624d5:	sub    %rax,%rdi
  2624d8:	cmp    %rsi,%rdi
  2624db:	jae    26417f <<glass::engine::Watch>::print_utf8+0x1ddf>
  2624e1:	mov    0xa0(%r13),%rax
  2624e8:	mov    %rax,0x88(%rsp)
  2624f0:	mov    0x40(%r13),%r9
  2624f4:	mov    0x58(%r13),%eax
  2624f8:	mov    %eax,0x30(%rsp)
  2624fc:	mov    0x5c(%r13),%eax
  262500:	mov    %eax,0x38(%rsp)
  262504:	movzwl 0x64(%r13),%eax
  262509:	mov    %eax,0x68(%rsp)
  26250d:	mov    0x18(%r13),%rax
  262511:	shl    $0x6,%rdi
  262515:	lea    (%rax,%rdi,1),%rcx
  262519:	cmp    %r9d,0x38(%rax,%rdi,1)
  26251e:	mov    %rcx,%rax
  262521:	jbe    262527 <<glass::engine::Watch>::print_utf8+0x187>
  262523:	mov    %r9d,0x38(%rax)
  262527:	mov    %rdx,0x48(%rsp)
  26252c:	mov    0x28(%rax),%r11d
  262530:	cmp    $0xffffffff,%r11d
  262534:	mov    %r9,0x80(%rsp)
  26253c:	mov    %rax,0x40(%rsp)
  262541:	mov    %r14,0x28(%rsp)
  262546:	je     2625fc <<glass::engine::Watch>::print_utf8+0x25c>
  26254c:	mov    %rax,%rcx
  26254f:	mov    0x30(%rax),%rax
  262553:	cmp    %rax,%r9
  262556:	mov    $0x0,%edx
  26255b:	cmovb  %rax,%rdx
  26255f:	mov    %rdx,0xc8(%rsp)
  262567:	movl   $0x20,0xf8(%rsp)
  262572:	mov    0x30(%rsp),%edx
  262576:	mov    %edx,0xf0(%rsp)
  26257d:	mov    0x38(%rsp),%edx
  262581:	mov    %edx,0xf4(%rsp)
  262588:	mov    0x68(%rsp),%edx
  26258c:	mov    %dx,0xfc(%rsp)
  262594:	movq   $0x0,0xe8(%rsp)
  2625a0:	mov    0x10(%rcx),%rcx
  2625a4:	cmp    %rax,%rcx
  2625a7:	mov    %rax,%rbx
  2625aa:	cmovb  %rcx,%rbx
  2625ae:	cmp    %r9,%rcx
  2625b1:	mov    %r9,%r10
  2625b4:	cmovb  %rcx,%r10
  2625b8:	mov    0x38e5c1(%rip),%rdx        # 5f0b80 <_DYNAMIC+0x320>
  2625bf:	movzbl (%rdx),%edx
  2625c2:	test   %dl,%dl
  2625c4:	je     26269d <<glass::engine::Watch>::print_utf8+0x2fd>
  2625ca:	mov    0x38e5e7(%rip),%rdx        # 5f0bb8 <_DYNAMIC+0x358>
  2625d1:	cmp    %r10,%rax
  2625d4:	jae    2625dd <<glass::engine::Watch>::print_utf8+0x23d>
  2625d6:	mov    0x38e5e3(%rip),%rdx        # 5f0bc0 <_DYNAMIC+0x360>
  2625dd:	lock incq 0x28(%rdx)
  2625e2:	mov    0x38e5af(%rip),%rdx        # 5f0b98 <_DYNAMIC+0x338>
  2625e9:	lock incq (%rdx)
  2625ed:	mov    %r10,%rdx
  2625f0:	sub    %rbx,%rdx
  2625f3:	jne    262652 <<glass::engine::Watch>::print_utf8+0x2b2>
  2625f5:	xor    %esi,%esi
  2625f7:	jmp    262691 <<glass::engine::Watch>::print_utf8+0x2f1>
  2625fc:	movl   $0x20,0xf8(%rsp)
  262607:	mov    0x30(%rsp),%ecx
  26260b:	mov    %ecx,0xf0(%rsp)
  262612:	mov    0x38(%rsp),%ecx
  262616:	mov    %ecx,0xf4(%rsp)
  26261d:	mov    0x68(%rsp),%ecx
  262621:	mov    %cx,0xfc(%rsp)
  262629:	movq   $0x0,0xe8(%rsp)
  262635:	lea    0x30(%rax),%rcx
  262639:	mov    %rcx,0x100(%rsp)
  262641:	movq   $0xffffffffffffffff,0xc8(%rsp)
  26264d:	jmp    262841 <<glass::engine::Watch>::print_utf8+0x4a1>
  262652:	mov    0x38e547(%rip),%rsi        # 5f0ba0 <_DYNAMIC+0x340>
  262659:	lock add %rdx,(%rsi)
  26265d:	cmp    $0x5,%rdx
  262661:	jae    262671 <<glass::engine::Watch>::print_utf8+0x2d1>
  262663:	lea    -0x204b52(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  26266a:	movzbl -0x1(%rdx,%rsi,1),%esi
  26266f:	jmp    262691 <<glass::engine::Watch>::print_utf8+0x2f1>
  262671:	lea    -0x5(%rdx),%rdi
  262675:	mov    $0x4,%esi
  26267a:	cmp    $0x4,%rdi
  26267e:	jb     262691 <<glass::engine::Watch>::print_utf8+0x2f1>
  262680:	add    $0xfffffffffffffff7,%rdx
  262684:	cmp    $0x8,%rdx
  262688:	mov    $0x6,%esi
  26268d:	sbb    $0x0,%rsi
  262691:	mov    0x38e4f8(%rip),%rdx        # 5f0b90 <_DYNAMIC+0x330>
  262698:	lock incq (%rdx,%rsi,8)
  26269d:	cmp    %r10,%rax
  2626a0:	mov    0x40(%rsp),%rax
  2626a5:	jae    2627f5 <<glass::engine::Watch>::print_utf8+0x455>
  2626ab:	mov    %r10,0x20(%rsp)
  2626b0:	mov    %r13,0xd0(%rsp)
  2626b8:	mov    %r15,0x78(%rsp)
  2626bd:	mov    0x20(%rax),%r15d
  2626c1:	mov    0x24(%rax),%r14d
  2626c5:	movzwl 0x2c(%rax),%edi
  2626c9:	mov    0x18(%rax),%r12
  2626cd:	test   %r12,%r12
  2626d0:	je     2626dd <<glass::engine::Watch>::print_utf8+0x33d>
  2626d2:	lock incq (%r12)
  2626d7:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  2626dd:	mov    %r11d,0x60(%rsp)
  2626e2:	mov    %r15d,0x58(%rsp)
  2626e7:	mov    %r14d,0x5c(%rsp)
  2626ec:	mov    %di,0x64(%rsp)
  2626f1:	mov    %r12,0x50(%rsp)
  2626f6:	mov    %rbx,0x8(%rsp)
  2626fb:	lea    0x0(,%rbx,8),%rax
  262703:	lea    (%rax,%rax,2),%rax
  262707:	mov    0x40(%rsp),%rcx
  26270c:	mov    0x8(%rcx),%rbx
  262710:	add    %rax,%rbx
  262713:	mov    0x20(%rsp),%rcx
  262718:	lea    0x0(,%rcx,8),%rcx
  262720:	lea    (%rcx,%rcx,2),%rbp
  262724:	sub    %rax,%rbp
  262727:	mov    %di,0x10(%rsp)
  26272c:	jmp    26274d <<glass::engine::Watch>::print_utf8+0x3ad>
  26272e:	xchg   %ax,%ax
  262730:	mov    %r12,(%rbx)
  262733:	mov    %r15d,0x8(%rbx)
  262737:	mov    %r14d,0xc(%rbx)
  26273b:	mov    %r11d,0x10(%rbx)
  26273f:	mov    %di,0x14(%rbx)
  262743:	add    $0x18,%rbx
  262747:	add    $0xffffffffffffffe8,%rbp
  26274b:	je     262789 <<glass::engine::Watch>::print_utf8+0x3e9>
  26274d:	test   %r12,%r12
  262750:	je     26275d <<glass::engine::Watch>::print_utf8+0x3bd>
  262752:	lock incq (%r12)
  262757:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  26275d:	mov    (%rbx),%rax
  262760:	test   %rax,%rax
  262763:	je     262730 <<glass::engine::Watch>::print_utf8+0x390>
  262765:	lock decq (%rax)
  262769:	jne    262730 <<glass::engine::Watch>::print_utf8+0x390>
  26276b:	mov    %rbx,%rdi
  26276e:	mov    %r11d,%r13d
  262771:	call   *0x38e351(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  262777:	movzwl 0x10(%rsp),%edi
  26277c:	mov    %r13d,%r11d
  26277f:	mov    0x80(%rsp),%r9
  262787:	jmp    262730 <<glass::engine::Watch>::print_utf8+0x390>
  262789:	mov    0x40(%rsp),%rax
  26278e:	mov    0x8(%rsp),%rcx
  262793:	cmp    %ecx,0x38(%rax)
  262796:	jbe    26279b <<glass::engine::Watch>::print_utf8+0x3fb>
  262798:	mov    %ecx,0x38(%rax)
  26279b:	test   %r12,%r12
  26279e:	mov    0x90(%rsp),%r8
  2627a6:	mov    0x70(%rsp),%rbp
  2627ab:	mov    0x78(%rsp),%r15
  2627b0:	mov    0xd0(%rsp),%r13
  2627b8:	mov    0x20(%rsp),%r10
  2627bd:	je     2627e9 <<glass::engine::Watch>::print_utf8+0x449>
  2627bf:	lock decq (%r12)
  2627c4:	jne    2627e9 <<glass::engine::Watch>::print_utf8+0x449>
  2627c6:	lea    0x50(%rsp),%rdi
  2627cb:	mov    %r8,%rbx
  2627ce:	call   *0x38e2f4(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  2627d4:	mov    0x40(%rsp),%rax
  2627d9:	mov    0x80(%rsp),%r9
  2627e1:	mov    %rbx,%r8
  2627e4:	mov    0x20(%rsp),%r10
  2627e9:	mov    0x10(%rax),%rcx
  2627ed:	mov    0xb0(%rsp),%r12
  2627f5:	lea    0x30(%rax),%rdx
  2627f9:	mov    %rdx,0x100(%rsp)
  262801:	cmp    %rcx,%r10
  262804:	jb     262841 <<glass::engine::Watch>::print_utf8+0x4a1>
  262806:	cmpl   $0xffffffff,0x28(%rax)
  26280a:	mov    %rax,%rbx
  26280d:	je     262837 <<glass::engine::Watch>::print_utf8+0x497>
  26280f:	lea    0x18(%rbx),%rdi
  262813:	mov    (%rdi),%rax
  262816:	test   %rax,%rax
  262819:	je     262837 <<glass::engine::Watch>::print_utf8+0x497>
  26281b:	lock decq (%rax)
  26281f:	jne    262837 <<glass::engine::Watch>::print_utf8+0x497>
  262821:	call   *0x38e2a1(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  262827:	mov    0x80(%rsp),%r9
  26282f:	mov    0x90(%rsp),%r8
  262837:	movl   $0xffffffff,0x28(%rbx)
  26283e:	mov    %rbx,%rax
  262841:	mov    0x10(%rax),%rdx
  262845:	mov    0x40(%rsp),%rax
  26284a:	mov    0x30(%rax),%rax
  26284e:	cmp    %r9,%rdx
  262851:	mov    %r9,%rsi
  262854:	cmovb  %rdx,%rsi
  262858:	cmp    %rax,%rsi
  26285b:	cmova  %rsi,%rax
  26285f:	mov    %rdx,%rdi
  262862:	mov    0x40(%rsp),%rcx
  262867:	mov    %rax,0x30(%rcx)
  26286b:	mov    0x40(%rsp),%rax
  262870:	sub    %r9,%rdi
  262873:	mov    %rdi,0x20(%rsp)
  262878:	jb     263b04 <<glass::engine::Watch>::print_utf8+0x1764>
  26287e:	mov    0x48(%rsp),%rdx
  262883:	cmp    %r8,%rdx
  262886:	jae    262d20 <<glass::engine::Watch>::print_utf8+0x980>
  26288c:	mov    %r13,0xd0(%rsp)
  262894:	mov    0x8(%rax),%r12
  262898:	lea    (%r9,%r9,2),%rax
  26289c:	lea    (%r12,%rax,8),%rax
  2628a0:	mov    %rax,0xb8(%rsp)
  2628a8:	mov    0x68(%rsp),%eax
  2628ac:	mov    %eax,%ecx
  2628ae:	or     $0x20,%ecx
  2628b1:	mov    %ecx,0xa0(%rsp)
  2628b8:	or     $0x40,%eax
  2628bb:	mov    %eax,0xe4(%rsp)
  2628c2:	mov    $0x1,%al
  2628c4:	mov    %eax,0xc0(%rsp)
  2628cb:	xor    %r14d,%r14d
  2628ce:	xor    %r10d,%r10d
  2628d1:	mov    %r9,0x8(%rsp)
  2628d6:	mov    %r9,%r11
  2628d9:	mov    %r12,0xa8(%rsp)
  2628e1:	jmp    262958 <<glass::engine::Watch>::print_utf8+0x5b8>
  2628e3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2628f0:	movq   $0x0,(%rbx)
  2628f7:	mov    0x30(%rsp),%eax
  2628fb:	mov    %eax,0x8(%rbx)
  2628fe:	mov    0x38(%rsp),%eax
  262902:	mov    %eax,0xc(%rbx)
  262905:	movl   $0x20,0x10(%rbx)
  26290c:	mov    0xe4(%rsp),%eax
  262913:	mov    %ax,0x14(%rbx)
  262917:	movl   $0x0,0xc0(%rsp)
  262922:	xor    %r14d,%r14d
  262925:	cmp    0x88(%rsp),%rdi
  26292d:	setae  %r14b
  262931:	mov    %rdi,%r11
  262934:	sub    %r14,%r11
  262937:	inc    %r10
  26293a:	mov    %rdi,0x8(%rsp)
  26293f:	mov    0x10(%rsp),%rax
  262944:	add    %rax,%rdx
  262947:	mov    %ecx,%r15d
  26294a:	mov    %rax,0x28(%rsp)
  26294f:	cmp    %r8,%rdx
  262952:	jae    262d3d <<glass::engine::Watch>::print_utf8+0x99d>
  262958:	movsbl 0x0(%rbp,%rdx,1),%ecx
  26295d:	test   %ecx,%ecx
  26295f:	mov    %rdx,0x10(%rsp)
  262964:	js     262980 <<glass::engine::Watch>::print_utf8+0x5e0>
  262966:	mov    $0x1,%edx
  26296b:	lea    -0x7f(%rcx),%eax
  26296e:	cmp    $0x20,%eax
  262971:	ja     2629ca <<glass::engine::Watch>::print_utf8+0x62a>
  262973:	jmp    262d30 <<glass::engine::Watch>::print_utf8+0x990>
  262978:	nopl   0x0(%rax,%rax,1)
  262980:	mov    %r14,%r12
  262983:	mov    %r11,%r13
  262986:	mov    %rbp,%rdi
  262989:	mov    %r10,%r14
  26298c:	mov    %r8,%rbx
  26298f:	mov    %r8,%rsi
  262992:	call   2a1520 <glass::engine::utf8_multibyte_at>
  262997:	cmp    $0xffffffff,%eax
  26299a:	je     2630bd <<glass::engine::Watch>::print_utf8+0xd1d>
  2629a0:	mov    %eax,%ecx
  2629a2:	mov    %rbx,%r8
  2629a5:	mov    0x80(%rsp),%r9
  2629ad:	mov    %r14,%r10
  2629b0:	mov    %r13,%r11
  2629b3:	mov    %r12,%r14
  2629b6:	mov    0xa8(%rsp),%r12
  2629be:	lea    -0x7f(%rcx),%eax
  2629c1:	cmp    $0x20,%eax
  2629c4:	jbe    262d30 <<glass::engine::Watch>::print_utf8+0x990>
  2629ca:	cmp    $0xffffffff,%r15d
  2629ce:	je     262a00 <<glass::engine::Watch>::print_utf8+0x660>
  2629d0:	lea    -0x20(%r15),%eax
  2629d4:	cmp    $0x5f,%eax
  2629d7:	mov    %r15,0x78(%rsp)
  2629dc:	jae    262a10 <<glass::engine::Watch>::print_utf8+0x670>
  2629de:	mov    %rcx,%r13
  2629e1:	mov    $0x1,%ecx
  2629e6:	cmpb   $0x0,0x1c(%rsp)
  2629eb:	jne    262af2 <<glass::engine::Watch>::print_utf8+0x752>
  2629f1:	jmp    262d30 <<glass::engine::Watch>::print_utf8+0x990>
  2629f6:	cs nopw 0x0(%rax,%rax,1)
  262a00:	mov    0x8(%rsp),%rdi
  262a05:	jmp    26293f <<glass::engine::Watch>::print_utf8+0x59f>
  262a0a:	nopw   0x0(%rax,%rax,1)
  262a10:	mov    0x391022(%rip),%eax        # 5f3a38 <glass::engine::width_of::CACHE+0x10>
  262a16:	test   %eax,%eax
  262a18:	jne    262cc8 <<glass::engine::Watch>::print_utf8+0x928>
  262a1e:	mov    %r15d,%ebx
  262a21:	mov    0x391008(%rip),%rsi        # 5f3a30 <glass::engine::width_of::CACHE+0x8>
  262a28:	cmp    %rbx,%rsi
  262a2b:	jbe    264140 <<glass::engine::Watch>::print_utf8+0x1da0>
  262a31:	mov    %rcx,%r13
  262a34:	mov    0x390fed(%rip),%r12        # 5f3a28 <glass::engine::width_of::CACHE>
  262a3b:	movzbl (%r12,%rbx,1),%eax
  262a40:	movzbl %al,%ecx
  262a43:	test   %cl,%cl
  262a45:	js     262a61 <<glass::engine::Watch>::print_utf8+0x6c1>
  262a47:	mov    %rdx,%r15
  262a4a:	mov    $0x1,%dl
  262a4c:	test   %dl,%dl
  262a4e:	mov    0xa8(%rsp),%r12
  262a56:	jne    262adc <<glass::engine::Watch>::print_utf8+0x73c>
  262a5c:	jmp    263110 <<glass::engine::Watch>::print_utf8+0xd70>
  262a61:	cmp    $0xfe,%ecx
  262a67:	je     262d30 <<glass::engine::Watch>::print_utf8+0x990>
  262a6d:	mov    $0xfe,%al
  262a6f:	cmp    $0x7f,%r15d
  262a73:	jae    262a81 <<glass::engine::Watch>::print_utf8+0x6e1>
  262a75:	mov    %rdx,%r15
  262a78:	mov    $0x1,%ecx
  262a7d:	xor    %edx,%edx
  262a7f:	jmp    262ac8 <<glass::engine::Watch>::print_utf8+0x728>
  262a81:	mov    %r15,%rdi
  262a84:	mov    %rdx,%r15
  262a87:	cmp    $0xa0,%edi
  262a8d:	jb     262ac6 <<glass::engine::Watch>::print_utf8+0x726>
  262a8f:	mov    %r10,%rbp
  262a92:	mov    %r14,0x48(%rsp)
  262a97:	mov    %r11,%r14
  262a9a:	call   2985c0 <unicode_width::tables::lookup_width>
  262a9f:	mov    %r14,%r11
  262aa2:	mov    0x48(%rsp),%r14
  262aa7:	mov    %rbp,%r10
  262aaa:	mov    0x70(%rsp),%rbp
  262aaf:	mov    0x80(%rsp),%r9
  262ab7:	mov    0x90(%rsp),%r8
  262abf:	movzbl %al,%ecx
  262ac2:	mov    $0x1,%dl
  262ac4:	jmp    262ac8 <<glass::engine::Watch>::print_utf8+0x728>
  262ac6:	xor    %edx,%edx
  262ac8:	mov    %al,(%r12,%rbx,1)
  262acc:	test   %dl,%dl
  262ace:	mov    0xa8(%rsp),%r12
  262ad6:	je     263110 <<glass::engine::Watch>::print_utf8+0xd70>
  262adc:	lea    -0x1(%rcx),%rax
  262ae0:	cmp    $0x1,%rax
  262ae4:	mov    %r15,%rdx
  262ae7:	mov    0x78(%rsp),%r15
  262aec:	ja     262d30 <<glass::engine::Watch>::print_utf8+0x990>
  262af2:	test   $0x1,%r14b
  262af6:	jne    262d2d <<glass::engine::Watch>::print_utf8+0x98d>
  262afc:	lea    (%rcx,%r11,1),%rdi
  262b00:	cmp    0x88(%rsp),%rdi
  262b08:	ja     262d28 <<glass::engine::Watch>::print_utf8+0x988>
  262b0e:	mov    %r11,%rbx
  262b11:	sub    %r9,%rbx
  262b14:	cmp    0xc8(%rsp),%r11
  262b1c:	jae    262b80 <<glass::engine::Watch>::print_utf8+0x7e0>
  262b1e:	cmp    0x20(%rsp),%rbx
  262b23:	jae    26418c <<glass::engine::Watch>::print_utf8+0x1dec>
  262b29:	lea    (%r11,%r11,2),%rax
  262b2d:	testb  $0x60,0x14(%r12,%rax,8)
  262b33:	jne    262d28 <<glass::engine::Watch>::print_utf8+0x988>
  262b39:	lea    (%r12,%rax,8),%r14
  262b3d:	cmp    $0x2,%rcx
  262b41:	jne    262bf6 <<glass::engine::Watch>::print_utf8+0x856>
  262b47:	lea    0x1(%rbx),%rax
  262b4b:	cmp    0x20(%rsp),%rax
  262b50:	jae    2641aa <<glass::engine::Watch>::print_utf8+0x1e0a>
  262b56:	lea    (%rax,%rax,2),%rax
  262b5a:	mov    $0x1,%r15b
  262b5d:	mov    0xb8(%rsp),%rcx
  262b65:	testb  $0x60,0x14(%rcx,%rax,8)
  262b6a:	mov    0xa0(%rsp),%ebp
  262b71:	je     262ba7 <<glass::engine::Watch>::print_utf8+0x807>
  262b73:	jmp    263122 <<glass::engine::Watch>::print_utf8+0xd82>
  262b78:	nopl   0x0(%rax,%rax,1)
  262b80:	cmp    0x20(%rsp),%rbx
  262b85:	jae    2641bc <<glass::engine::Watch>::print_utf8+0x1e1c>
  262b8b:	lea    (%r11,%r11,2),%rax
  262b8f:	lea    (%r12,%rax,8),%r14
  262b93:	cmp    $0x2,%rcx
  262b97:	sete   %r15b
  262b9b:	mov    0x68(%rsp),%ebp
  262b9f:	cmove  0xa0(%rsp),%ebp
  262ba7:	mov    (%r14),%rax
  262baa:	test   %rax,%rax
  262bad:	je     262c10 <<glass::engine::Watch>::print_utf8+0x870>
  262baf:	lock decq (%rax)
  262bb3:	jne    262c10 <<glass::engine::Watch>::print_utf8+0x870>
  262bb5:	mov    %rdi,0x28(%rsp)
  262bba:	mov    %r14,%rdi
  262bbd:	mov    %rdx,0x48(%rsp)
  262bc2:	mov    %r10,0x8(%rsp)
  262bc7:	mov    %r11,0x110(%rsp)
  262bcf:	call   *0x38def3(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  262bd5:	mov    0x28(%rsp),%rdi
  262bda:	mov    0x110(%rsp),%r11
  262be2:	mov    0x8(%rsp),%r10
  262be7:	mov    0x80(%rsp),%r9
  262bef:	mov    0x48(%rsp),%rdx
  262bf4:	jmp    262c10 <<glass::engine::Watch>::print_utf8+0x870>
  262bf6:	xor    %r15d,%r15d
  262bf9:	mov    0x68(%rsp),%ebp
  262bfd:	mov    (%r14),%rax
  262c00:	test   %rax,%rax
  262c03:	jne    262baf <<glass::engine::Watch>::print_utf8+0x80f>
  262c05:	data16 cs nopw 0x0(%rax,%rax,1)
  262c10:	lea    (%r11,%r11,2),%rax
  262c14:	movq   $0x0,(%r14)
  262c1b:	mov    0x30(%rsp),%ecx
  262c1f:	mov    %ecx,0x8(%r12,%rax,8)
  262c24:	mov    0x38(%rsp),%ecx
  262c28:	mov    %ecx,0xc(%r12,%rax,8)
  262c2d:	mov    %bp,0x14(%r12,%rax,8)
  262c33:	mov    0x78(%rsp),%rcx
  262c38:	mov    %ecx,0x10(%r12,%rax,8)
  262c3d:	test   %r15b,%r15b
  262c40:	mov    0x90(%rsp),%r8
  262c48:	mov    0x70(%rsp),%rbp
  262c4d:	mov    %r13,%rcx
  262c50:	je     262922 <<glass::engine::Watch>::print_utf8+0x582>
  262c56:	inc    %rbx
  262c59:	cmp    0x20(%rsp),%rbx
  262c5e:	jae    264195 <<glass::engine::Watch>::print_utf8+0x1df5>
  262c64:	lea    (%rbx,%rbx,2),%rax
  262c68:	mov    0xb8(%rsp),%rsi
  262c70:	lea    (%rsi,%rax,8),%rbx
  262c74:	mov    (%rsi,%rax,8),%rax
  262c78:	test   %rax,%rax
  262c7b:	je     2628f0 <<glass::engine::Watch>::print_utf8+0x550>
  262c81:	lock decq (%rax)
  262c85:	jne    2628f0 <<glass::engine::Watch>::print_utf8+0x550>
  262c8b:	mov    %rdi,0x28(%rsp)
  262c90:	mov    %rbx,%rdi
  262c93:	mov    %rdx,%r14
  262c96:	mov    %r8,%r15
  262c99:	mov    %r10,%rbp
  262c9c:	mov    %rcx,%r13
  262c9f:	call   *0x38de23(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  262ca5:	mov    0x28(%rsp),%rdi
  262caa:	mov    %r13,%rcx
  262cad:	mov    %rbp,%r10
  262cb0:	mov    0x70(%rsp),%rbp
  262cb5:	mov    0x80(%rsp),%r9
  262cbd:	mov    %r15,%r8
  262cc0:	mov    %r14,%rdx
  262cc3:	jmp    2628f0 <<glass::engine::Watch>::print_utf8+0x550>
  262cc8:	mov    %rdx,%rbx
  262ccb:	mov    %r8,%r12
  262cce:	mov    %r10,%rbp
  262cd1:	mov    %r15,%r13
  262cd4:	mov    %r11,%r15
  262cd7:	mov    %r14,0x48(%rsp)
  262cdc:	mov    %rcx,%r14
  262cdf:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  262ce4:	mov    %r14,%rcx
  262ce7:	mov    0x48(%rsp),%r14
  262cec:	mov    %r15,%r11
  262cef:	mov    %r13,%r15
  262cf2:	mov    %rbp,%r10
  262cf5:	mov    0x70(%rsp),%rbp
  262cfa:	mov    0x80(%rsp),%r9
  262d02:	mov    %r12,%r8
  262d05:	mov    %rbx,%rdx
  262d08:	mov    %r15d,%ebx
  262d0b:	mov    0x390d1e(%rip),%rsi        # 5f3a30 <glass::engine::width_of::CACHE+0x8>
  262d12:	cmp    %rbx,%rsi
  262d15:	ja     262a31 <<glass::engine::Watch>::print_utf8+0x691>
  262d1b:	jmp    264140 <<glass::engine::Watch>::print_utf8+0x1da0>
  262d20:	xor    %r10d,%r10d
  262d23:	xor    %r14d,%r14d
  262d26:	jmp    262d8e <<glass::engine::Watch>::print_utf8+0x9ee>
  262d28:	xor    %r14d,%r14d
  262d2b:	jmp    262d30 <<glass::engine::Watch>::print_utf8+0x990>
  262d2d:	mov    $0x1,%r14b
  262d30:	mov    0x8(%rsp),%rdi
  262d35:	mov    %r15d,%ecx
  262d38:	mov    0x10(%rsp),%rdx
  262d3d:	cmp    %r9,%rdi
  262d40:	jbe    262d5d <<glass::engine::Watch>::print_utf8+0x9bd>
  262d42:	mov    %rcx,%rsi
  262d45:	mov    0x100(%rsp),%rcx
  262d4d:	mov    (%rcx),%rax
  262d50:	cmp    %rax,%rdi
  262d53:	cmova  %rdi,%rax
  262d57:	mov    %rax,(%rcx)
  262d5a:	mov    %rsi,%rcx
  262d5d:	cmp    $0x8,%r10
  262d61:	setae  %al
  262d64:	testb  $0x1,0xc0(%rsp)
  262d6c:	mov    0xb0(%rsp),%r12
  262d74:	jne    262d78 <<glass::engine::Watch>::print_utf8+0x9d8>
  262d76:	xor    %eax,%eax
  262d78:	test   %al,%al
  262d7a:	jne    26377f <<glass::engine::Watch>::print_utf8+0x13df>
  262d80:	mov    %r11,%r9
  262d83:	mov    %ecx,%r15d
  262d86:	mov    0xd0(%rsp),%r13
  262d8e:	mov    %r9,0x40(%r13)
  262d92:	mov    %r14b,0x6c(%r13)
  262d96:	add    %r10,0xa0(%r12)
  262d9e:	mov    %r15d,%r13d
  262da1:	mov    0x28(%rsp),%rbx
  262da6:	mov    %rdx,%r14
  262da9:	cmp    %r8,%rdx
  262dac:	jae    2637d2 <<glass::engine::Watch>::print_utf8+0x1432>
  262db2:	movsbl 0x0(%rbp,%r14,1),%r15d
  262db8:	test   %r15d,%r15d
  262dbb:	js     262dd0 <<glass::engine::Watch>::print_utf8+0xa30>
  262dbd:	mov    $0x1,%edx
  262dc2:	lea    -0x7f(%r15),%eax
  262dc6:	cmp    $0x20,%eax
  262dc9:	ja     262e00 <<glass::engine::Watch>::print_utf8+0xa60>
  262dcb:	jmp    2637d2 <<glass::engine::Watch>::print_utf8+0x1432>
  262dd0:	mov    %rbp,%rdi
  262dd3:	mov    %r8,%rsi
  262dd6:	mov    %r14,%rdx
  262dd9:	mov    %r15d,%ecx
  262ddc:	mov    %r8,%r15
  262ddf:	call   2a1520 <glass::engine::utf8_multibyte_at>
  262de4:	mov    %r15,%r8
  262de7:	cmp    $0xffffffff,%eax
  262dea:	je     2637d2 <<glass::engine::Watch>::print_utf8+0x1432>
  262df0:	mov    %eax,%r15d
  262df3:	lea    -0x7f(%r15),%eax
  262df7:	cmp    $0x20,%eax
  262dfa:	jbe    2637d2 <<glass::engine::Watch>::print_utf8+0x1432>
  262e00:	cmp    $0xffffffff,%r13d
  262e04:	je     262471 <<glass::engine::Watch>::print_utf8+0xd1>
  262e0a:	mov    %r14,0x28(%rsp)
  262e0f:	lea    -0x20(%r13),%eax
  262e13:	cmp    $0x5f,%eax
  262e16:	jae    262e30 <<glass::engine::Watch>::print_utf8+0xa90>
  262e18:	mov    $0x1,%ebp
  262e1d:	cmpb   $0x0,0x1c(%rsp)
  262e22:	je     262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262e28:	jmp    262e8f <<glass::engine::Watch>::print_utf8+0xaef>
  262e2a:	nopw   0x0(%rax,%rax,1)
  262e30:	cmpb   $0x0,0x98(%rsp)
  262e38:	je     262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262e3e:	mov    0x390bf4(%rip),%eax        # 5f3a38 <glass::engine::width_of::CACHE+0x10>
  262e44:	test   %eax,%eax
  262e46:	jne    263756 <<glass::engine::Watch>::print_utf8+0x13b6>
  262e4c:	mov    %r13d,%ebx
  262e4f:	mov    0x390bda(%rip),%rsi        # 5f3a30 <glass::engine::width_of::CACHE+0x8>
  262e56:	cmp    %rbx,%rsi
  262e59:	jbe    264140 <<glass::engine::Watch>::print_utf8+0x1da0>
  262e5f:	mov    0x390bc2(%rip),%r14        # 5f3a28 <glass::engine::width_of::CACHE>
  262e66:	movzbl (%r14,%rbx,1),%eax
  262e6b:	movzbl %al,%ebp
  262e6e:	test   %bpl,%bpl
  262e71:	js     263054 <<glass::engine::Watch>::print_utf8+0xcb4>
  262e77:	mov    $0x1,%cl
  262e79:	test   %cl,%cl
  262e7b:	je     262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262e81:	lea    -0x1(%rbp),%rax
  262e85:	cmp    $0x1,%rax
  262e89:	ja     262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262e8f:	mov    0x78(%r12),%r14
  262e94:	cmpb   $0x0,0x6c(%r14)
  262e99:	jne    262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262e9f:	mov    0x40(%r14),%r10
  262ea3:	mov    0xa0(%r14),%r9
  262eaa:	lea    (%r10,%rbp,1),%rbx
  262eae:	cmp    %r9,%rbx
  262eb1:	ja     262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262eb7:	mov    0x30(%r14),%eax
  262ebb:	sub    0x48(%r14),%eax
  262ebf:	cltq
  262ec1:	mov    0x20(%r14),%rsi
  262ec5:	mov    0x28(%r14),%rcx
  262ec9:	lea    (%rcx,%rax,1),%rdi
  262ecd:	dec    %rdi
  262ed0:	cmp    %rsi,%rdi
  262ed3:	mov    $0x0,%eax
  262ed8:	cmovae %rsi,%rax
  262edc:	sub    %rax,%rdi
  262edf:	cmp    %rsi,%rdi
  262ee2:	jae    2641d2 <<glass::engine::Watch>::print_utf8+0x1e32>
  262ee8:	mov    0x58(%r14),%eax
  262eec:	mov    %eax,0x40(%rsp)
  262ef0:	mov    0x5c(%r14),%eax
  262ef4:	mov    %eax,0x88(%rsp)
  262efb:	movzwl 0x64(%r14),%eax
  262f00:	mov    %eax,0x80(%rsp)
  262f07:	mov    0x18(%r14),%rax
  262f0b:	shl    $0x6,%rdi
  262f0f:	lea    (%rax,%rdi,1),%r11
  262f13:	lea    (%rax,%rdi,1),%rcx
  262f17:	add    $0x18,%rcx
  262f1b:	mov    %rcx,0x10(%rsp)
  262f20:	mov    0x28(%rax,%rdi,1),%eax
  262f24:	cmp    $0xffffffff,%eax
  262f27:	je     262f34 <<glass::engine::Watch>::print_utf8+0xb94>
  262f29:	mov    0x10(%rsp),%rcx
  262f2e:	cmp    0x30(%r11),%r10
  262f32:	jae    262f4d <<glass::engine::Watch>::print_utf8+0xbad>
  262f34:	mov    0x10(%r11),%rsi
  262f38:	cmp    %rsi,%r10
  262f3b:	jae    2641f1 <<glass::engine::Watch>::print_utf8+0x1e51>
  262f41:	lea    (%r10,%r10,2),%rcx
  262f45:	shl    $0x3,%rcx
  262f49:	add    0x8(%r11),%rcx
  262f4d:	testb  $0x60,0x14(%rcx)
  262f51:	jne    262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262f57:	cmp    $0x2,%rbp
  262f5b:	jne    262f94 <<glass::engine::Watch>::print_utf8+0xbf4>
  262f5d:	lea    0x1(%r10),%rdi
  262f61:	cmp    $0xffffffff,%eax
  262f64:	je     262f71 <<glass::engine::Watch>::print_utf8+0xbd1>
  262f66:	mov    0x10(%rsp),%rcx
  262f6b:	cmp    0x30(%r11),%rdi
  262f6f:	jae    262f8a <<glass::engine::Watch>::print_utf8+0xbea>
  262f71:	mov    0x10(%r11),%rsi
  262f75:	cmp    %rsi,%rdi
  262f78:	jae    264213 <<glass::engine::Watch>::print_utf8+0x1e73>
  262f7e:	lea    (%rdi,%rdi,2),%rcx
  262f82:	shl    $0x3,%rcx
  262f86:	add    0x8(%r11),%rcx
  262f8a:	testb  $0x60,0x14(%rcx)
  262f8e:	jne    262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262f94:	mov    %rdx,0x48(%rsp)
  262f99:	cmp    %r10d,0x38(%r11)
  262f9d:	jbe    262fa3 <<glass::engine::Watch>::print_utf8+0xc03>
  262f9f:	mov    %r10d,0x38(%r11)
  262fa3:	cmp    $0xffffffff,%eax
  262fa6:	setne  %dl
  262fa9:	mov    0x30(%r11),%rcx
  262fad:	cmp    %rcx,%r10
  262fb0:	sete   %sil
  262fb4:	test   %sil,%dl
  262fb7:	mov    %r9,0x30(%rsp)
  262fbc:	mov    %r10,0x38(%rsp)
  262fc1:	mov    %r11,0x20(%rsp)
  262fc6:	mov    %rbx,0x8(%rsp)
  262fcb:	jne    2630f6 <<glass::engine::Watch>::print_utf8+0xd56>
  262fd1:	cmp    $0xffffffff,%eax
  262fd4:	je     26338b <<glass::engine::Watch>::print_utf8+0xfeb>
  262fda:	mov    0x10(%r11),%rax
  262fde:	cmp    %rcx,%rax
  262fe1:	mov    %rcx,%rdx
  262fe4:	cmovb  %rax,%rdx
  262fe8:	mov    %rdx,0xb8(%rsp)
  262ff0:	cmp    %r10,%rax
  262ff3:	mov    %r10,%rsi
  262ff6:	cmovb  %rax,%rsi
  262ffa:	mov    0x38db7f(%rip),%rdx        # 5f0b80 <_DYNAMIC+0x320>
  263001:	movzbl (%rdx),%edx
  263004:	test   %dl,%dl
  263006:	mov    %rsi,0xa0(%rsp)
  26300e:	je     26319c <<glass::engine::Watch>::print_utf8+0xdfc>
  263014:	mov    0x38db9d(%rip),%rdx        # 5f0bb8 <_DYNAMIC+0x358>
  26301b:	cmp    %rsi,%rcx
  26301e:	jae    263027 <<glass::engine::Watch>::print_utf8+0xc87>
  263020:	mov    0x38db99(%rip),%rdx        # 5f0bc0 <_DYNAMIC+0x360>
  263027:	lock incq 0x28(%rdx)
  26302c:	mov    0x38db65(%rip),%rdx        # 5f0b98 <_DYNAMIC+0x338>
  263033:	lock incq (%rdx)
  263037:	mov    0xa0(%rsp),%rdx
  26303f:	sub    0xb8(%rsp),%rdx
  263047:	jne    263149 <<glass::engine::Watch>::print_utf8+0xda9>
  26304d:	xor    %esi,%esi
  26304f:	jmp    263188 <<glass::engine::Watch>::print_utf8+0xde8>
  263054:	cmp    $0xfe,%ebp
  26305a:	je     262450 <<glass::engine::Watch>::print_utf8+0xb0>
  263060:	mov    $0xfe,%al
  263062:	cmp    $0x7f,%r13d
  263066:	jae    263080 <<glass::engine::Watch>::print_utf8+0xce0>
  263068:	mov    $0x1,%ebp
  26306d:	xor    %ecx,%ecx
  26306f:	mov    %al,(%r14,%rbx,1)
  263073:	test   %cl,%cl
  263075:	jne    262e81 <<glass::engine::Watch>::print_utf8+0xae1>
  26307b:	jmp    262450 <<glass::engine::Watch>::print_utf8+0xb0>
  263080:	cmp    $0xa0,%r13d
  263087:	jb     2630e3 <<glass::engine::Watch>::print_utf8+0xd43>
  263089:	mov    %r13d,%edi
  26308c:	mov    %r15,0x78(%rsp)
  263091:	mov    %rdx,%r15
  263094:	mov    %r8,%rbp
  263097:	call   2985c0 <unicode_width::tables::lookup_width>
  26309c:	mov    %rbp,%r8
  26309f:	mov    %r15,%rdx
  2630a2:	mov    0x78(%rsp),%r15
  2630a7:	movzbl %al,%ebp
  2630aa:	mov    $0x1,%cl
  2630ac:	mov    %al,(%r14,%rbx,1)
  2630b0:	test   %cl,%cl
  2630b2:	jne    262e81 <<glass::engine::Watch>::print_utf8+0xae1>
  2630b8:	jmp    262450 <<glass::engine::Watch>::print_utf8+0xb0>
  2630bd:	mov    0x8(%rsp),%rdi
  2630c2:	mov    %r15d,%ecx
  2630c5:	mov    0x10(%rsp),%rdx
  2630ca:	mov    %rbx,%r8
  2630cd:	mov    0x80(%rsp),%r9
  2630d5:	mov    %r14,%r10
  2630d8:	mov    %r13,%r11
  2630db:	mov    %r12,%r14
  2630de:	jmp    262d3d <<glass::engine::Watch>::print_utf8+0x99d>
  2630e3:	xor    %ecx,%ecx
  2630e5:	mov    %al,(%r14,%rbx,1)
  2630e9:	test   %cl,%cl
  2630eb:	jne    262e81 <<glass::engine::Watch>::print_utf8+0xae1>
  2630f1:	jmp    262450 <<glass::engine::Watch>::print_utf8+0xb0>
  2630f6:	lea    0x1(%r10),%rax
  2630fa:	mov    %rax,0x30(%r11)
  2630fe:	mov    0x10(%r11),%rsi
  263102:	cmp    %rsi,%r10
  263105:	jb     2633ab <<glass::engine::Watch>::print_utf8+0x100b>
  26310b:	jmp    264220 <<glass::engine::Watch>::print_utf8+0x1e80>
  263110:	mov    0x8(%rsp),%rdi
  263115:	mov    0x78(%rsp),%r13
  26311a:	mov    %r13d,%ecx
  26311d:	jmp    262d38 <<glass::engine::Watch>::print_utf8+0x998>
  263122:	xor    %r14d,%r14d
  263125:	mov    0x8(%rsp),%rdi
  26312a:	mov    0x78(%rsp),%r13
  26312f:	mov    %r13d,%ecx
  263132:	mov    0x10(%rsp),%rdx
  263137:	mov    0x90(%rsp),%r8
  26313f:	mov    0x70(%rsp),%rbp
  263144:	jmp    262d3d <<glass::engine::Watch>::print_utf8+0x99d>
  263149:	mov    0x38da50(%rip),%rsi        # 5f0ba0 <_DYNAMIC+0x340>
  263150:	lock add %rdx,(%rsi)
  263154:	cmp    $0x5,%rdx
  263158:	jae    263168 <<glass::engine::Watch>::print_utf8+0xdc8>
  26315a:	lea    -0x205649(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263161:	movzbl -0x1(%rdx,%rsi,1),%esi
  263166:	jmp    263188 <<glass::engine::Watch>::print_utf8+0xde8>
  263168:	mov    $0x4,%esi
  26316d:	lea    -0x5(%rdx),%rdi
  263171:	cmp    $0x4,%rdi
  263175:	jb     263188 <<glass::engine::Watch>::print_utf8+0xde8>
  263177:	add    $0xfffffffffffffff7,%rdx
  26317b:	cmp    $0x8,%rdx
  26317f:	mov    $0x6,%esi
  263184:	sbb    $0x0,%rsi
  263188:	mov    0x38da01(%rip),%rdx        # 5f0b90 <_DYNAMIC+0x330>
  26318f:	lock incq (%rdx,%rsi,8)
  263194:	mov    0xa0(%rsp),%rsi
  26319c:	cmp    %rsi,%rcx
  26319f:	jae    263344 <<glass::engine::Watch>::print_utf8+0xfa4>
  2631a5:	mov    %r15,0x78(%rsp)
  2631aa:	mov    0x28(%r11),%edi
  2631ae:	mov    0x20(%r11),%r15d
  2631b2:	mov    0x24(%r11),%eax
  2631b6:	movzwl 0x2c(%r11),%ecx
  2631bb:	mov    0x18(%r11),%r8
  2631bf:	test   %r8,%r8
  2631c2:	mov    %r8,0xa8(%rsp)
  2631ca:	mov    %eax,0xc8(%rsp)
  2631d1:	mov    %cx,0x68(%rsp)
  2631d6:	je     26320c <<glass::engine::Watch>::print_utf8+0xe6c>
  2631d8:	lock incq (%r8)
  2631dc:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  2631e2:	mov    0x10(%r11),%rdx
  2631e6:	mov    %edi,0x60(%rsp)
  2631ea:	mov    %r15d,0x58(%rsp)
  2631ef:	mov    %eax,0x5c(%rsp)
  2631f3:	movzwl 0x68(%rsp),%eax
  2631f8:	mov    %ax,0x64(%rsp)
  2631fd:	mov    %r8,0x50(%rsp)
  263202:	cmp    %rdx,%rsi
  263205:	jbe    263223 <<glass::engine::Watch>::print_utf8+0xe83>
  263207:	jmp    264150 <<glass::engine::Watch>::print_utf8+0x1db0>
  26320c:	mov    %edi,0x60(%rsp)
  263210:	mov    %r15d,0x58(%rsp)
  263215:	mov    %eax,0x5c(%rsp)
  263219:	mov    %cx,0x64(%rsp)
  26321e:	mov    %r8,0x50(%rsp)
  263223:	mov    0xb8(%rsp),%rax
  26322b:	lea    0x0(,%rax,8),%rax
  263233:	lea    (%rax,%rax,2),%rax
  263237:	mov    0x8(%r11),%rbx
  26323b:	add    %rax,%rbx
  26323e:	lea    0x0(,%rsi,8),%rcx
  263246:	lea    (%rcx,%rcx,2),%r12
  26324a:	sub    %rax,%r12
  26324d:	mov    0xc8(%rsp),%ecx
  263254:	movzwl 0x68(%rsp),%edx
  263259:	mov    %r15d,0xc0(%rsp)
  263261:	jmp    26328b <<glass::engine::Watch>::print_utf8+0xeeb>
  263263:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  263270:	mov    %r8,(%rbx)
  263273:	mov    %r15d,0x8(%rbx)
  263277:	mov    %ecx,0xc(%rbx)
  26327a:	mov    %edi,0x10(%rbx)
  26327d:	mov    %dx,0x14(%rbx)
  263281:	add    $0x18,%rbx
  263285:	add    $0xffffffffffffffe8,%r12
  263289:	je     2632e4 <<glass::engine::Watch>::print_utf8+0xf44>
  26328b:	test   %r8,%r8
  26328e:	je     26329a <<glass::engine::Watch>::print_utf8+0xefa>
  263290:	lock incq (%r8)
  263294:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  26329a:	mov    (%rbx),%rax
  26329d:	test   %rax,%rax
  2632a0:	je     263270 <<glass::engine::Watch>::print_utf8+0xed0>
  2632a2:	lock decq (%rax)
  2632a6:	jne    263270 <<glass::engine::Watch>::print_utf8+0xed0>
  2632a8:	mov    %edi,%r15d
  2632ab:	mov    %rbx,%rdi
  2632ae:	call   *0x38d814(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  2632b4:	movzwl 0x68(%rsp),%edx
  2632b9:	mov    0xc8(%rsp),%ecx
  2632c0:	mov    %r15d,%edi
  2632c3:	mov    0xc0(%rsp),%r15d
  2632cb:	mov    0xa8(%rsp),%r8
  2632d3:	mov    0x20(%rsp),%r11
  2632d8:	mov    0x38(%rsp),%r10
  2632dd:	mov    0x30(%rsp),%r9
  2632e2:	jmp    263270 <<glass::engine::Watch>::print_utf8+0xed0>
  2632e4:	mov    0xb8(%rsp),%rax
  2632ec:	cmp    %eax,0x38(%r11)
  2632f0:	mov    0xb0(%rsp),%r12
  2632f8:	jbe    2632fe <<glass::engine::Watch>::print_utf8+0xf5e>
  2632fa:	mov    %eax,0x38(%r11)
  2632fe:	test   %r8,%r8
  263301:	mov    0xa0(%rsp),%rsi
  263309:	je     263333 <<glass::engine::Watch>::print_utf8+0xf93>
  26330b:	lock decq (%r8)
  26330f:	jne    263333 <<glass::engine::Watch>::print_utf8+0xf93>
  263311:	lea    0x50(%rsp),%rdi
  263316:	call   *0x38d7ac(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  26331c:	mov    0xa0(%rsp),%rsi
  263324:	mov    0x20(%rsp),%r11
  263329:	mov    0x38(%rsp),%r10
  26332e:	mov    0x30(%rsp),%r9
  263333:	mov    0x10(%r11),%rax
  263337:	mov    0x90(%rsp),%r8
  26333f:	mov    0x78(%rsp),%r15
  263344:	cmp    %rax,%rsi
  263347:	jb     26338b <<glass::engine::Watch>::print_utf8+0xfeb>
  263349:	cmpl   $0xffffffff,0x28(%r11)
  26334e:	je     263383 <<glass::engine::Watch>::print_utf8+0xfe3>
  263350:	mov    0x10(%rsp),%rax
  263355:	mov    (%rax),%rax
  263358:	test   %rax,%rax
  26335b:	je     263383 <<glass::engine::Watch>::print_utf8+0xfe3>
  26335d:	lock decq (%rax)
  263361:	jne    263383 <<glass::engine::Watch>::print_utf8+0xfe3>
  263363:	mov    0x10(%rsp),%rdi
  263368:	mov    %r8,%rbx
  26336b:	call   *0x38d757(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263371:	mov    0x20(%rsp),%r11
  263376:	mov    0x38(%rsp),%r10
  26337b:	mov    0x30(%rsp),%r9
  263380:	mov    %rbx,%r8
  263383:	movl   $0xffffffff,0x28(%r11)
  26338b:	mov    0x30(%r11),%rax
  26338f:	lea    0x1(%r10),%rcx
  263393:	cmp    %rax,%rcx
  263396:	cmova  %rcx,%rax
  26339a:	mov    0x10(%r11),%rsi
  26339e:	mov    %rax,0x30(%r11)
  2633a2:	cmp    %rsi,%r10
  2633a5:	jae    264230 <<glass::engine::Watch>::print_utf8+0x1e90>
  2633ab:	mov    0x80(%rsp),%esi
  2633b2:	mov    %esi,%eax
  2633b4:	or     $0x20,%eax
  2633b7:	cmp    $0x2,%rbp
  2633bb:	mov    0x8(%r11),%rcx
  2633bf:	lea    (%r10,%r10,2),%rdx
  2633c3:	lea    (%rcx,%rdx,8),%rbx
  2633c7:	mov    %r13d,0x10(%rcx,%rdx,8)
  2633cc:	mov    0x40(%rsp),%edi
  2633d0:	mov    %edi,0x8(%rcx,%rdx,8)
  2633d4:	cmovne %esi,%eax
  2633d7:	mov    0x88(%rsp),%esi
  2633de:	mov    %esi,0xc(%rcx,%rdx,8)
  2633e2:	mov    %ax,0x14(%rcx,%rdx,8)
  2633e7:	mov    (%rcx,%rdx,8),%rax
  2633eb:	test   %rax,%rax
  2633ee:	je     263414 <<glass::engine::Watch>::print_utf8+0x1074>
  2633f0:	lock decq (%rax)
  2633f4:	jne    263414 <<glass::engine::Watch>::print_utf8+0x1074>
  2633f6:	mov    %rbx,%rdi
  2633f9:	mov    %r8,%r13
  2633fc:	call   *0x38d6c6(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263402:	mov    0x20(%rsp),%r11
  263407:	mov    0x38(%rsp),%r10
  26340c:	mov    0x30(%rsp),%r9
  263411:	mov    %r13,%r8
  263414:	movq   $0x0,(%rbx)
  26341b:	cmp    $0x2,%rbp
  26341f:	mov    0x70(%rsp),%rbp
  263424:	mov    0x48(%rsp),%rdx
  263429:	jne    263733 <<glass::engine::Watch>::print_utf8+0x1393>
  26342f:	lea    0x1(%r10),%r13
  263433:	mov    0x30(%r11),%rbx
  263437:	mov    0x28(%r11),%eax
  26343b:	cmp    %rbx,%r13
  26343e:	jne    26345f <<glass::engine::Watch>::print_utf8+0x10bf>
  263440:	cmp    $0xffffffff,%eax
  263443:	je     26345f <<glass::engine::Watch>::print_utf8+0x10bf>
  263445:	add    $0x2,%r10
  263449:	mov    %r10,0x30(%r11)
  26344d:	mov    0x10(%r11),%rsi
  263451:	cmp    %rsi,%r13
  263454:	jb     2636c7 <<glass::engine::Watch>::print_utf8+0x1327>
  26345a:	jmp    264240 <<glass::engine::Watch>::print_utf8+0x1ea0>
  26345f:	cmp    $0xffffffff,%eax
  263462:	je     2636a7 <<glass::engine::Watch>::print_utf8+0x1307>
  263468:	mov    %r15,0x78(%rsp)
  26346d:	mov    0x10(%r11),%r15
  263471:	cmp    %rbx,%r15
  263474:	mov    %rbx,%rcx
  263477:	cmovb  %r15,%rcx
  26347b:	cmp    %r13,%r15
  26347e:	mov    %r13,%rsi
  263481:	cmovb  %r15,%rsi
  263485:	mov    0x38d6f4(%rip),%rax        # 5f0b80 <_DYNAMIC+0x320>
  26348c:	movzbl (%rax),%eax
  26348f:	test   %al,%al
  263491:	mov    %rsi,0xa8(%rsp)
  263499:	mov    %rcx,0xc0(%rsp)
  2634a1:	je     2634ea <<glass::engine::Watch>::print_utf8+0x114a>
  2634a3:	mov    0x38d70e(%rip),%rax        # 5f0bb8 <_DYNAMIC+0x358>
  2634aa:	cmp    %rsi,%rbx
  2634ad:	jae    2634b6 <<glass::engine::Watch>::print_utf8+0x1116>
  2634af:	mov    0x38d70a(%rip),%rax        # 5f0bc0 <_DYNAMIC+0x360>
  2634b6:	lock incq 0x28(%rax)
  2634bb:	mov    %rsi,%rdi
  2634be:	sub    %rcx,%rdi
  2634c1:	call   2f6d00 <alacritty_terminal::grid::row::fill_census::note>
  2634c6:	mov    0xc0(%rsp),%rcx
  2634ce:	mov    0xa8(%rsp),%rsi
  2634d6:	mov    0x48(%rsp),%rdx
  2634db:	mov    0x30(%rsp),%r9
  2634e0:	mov    0x38(%rsp),%r10
  2634e5:	mov    0x20(%rsp),%r11
  2634ea:	cmp    %rsi,%rbx
  2634ed:	jae    263669 <<glass::engine::Watch>::print_utf8+0x12c9>
  2634f3:	mov    %r13,0xa0(%rsp)
  2634fb:	mov    0x28(%r11),%edi
  2634ff:	mov    0x20(%r11),%r8d
  263503:	mov    0x24(%r11),%ebp
  263507:	movzwl 0x2c(%r11),%r13d
  26350c:	mov    0x18(%r11),%r15
  263510:	test   %r15,%r15
  263513:	mov    %r15,0x68(%rsp)
  263518:	je     26354a <<glass::engine::Watch>::print_utf8+0x11aa>
  26351a:	lock incq (%r15)
  26351e:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  263524:	mov    0x10(%r11),%rdx
  263528:	mov    %edi,0x60(%rsp)
  26352c:	mov    %r8d,0x58(%rsp)
  263531:	mov    %ebp,0x5c(%rsp)
  263535:	mov    %r13w,0x64(%rsp)
  26353b:	mov    %r15,0x50(%rsp)
  263540:	cmp    %rdx,%rsi
  263543:	jbe    263562 <<glass::engine::Watch>::print_utf8+0x11c2>
  263545:	jmp    26416a <<glass::engine::Watch>::print_utf8+0x1dca>
  26354a:	mov    %edi,0x60(%rsp)
  26354e:	mov    %r8d,0x58(%rsp)
  263553:	mov    %ebp,0x5c(%rsp)
  263557:	mov    %r13w,0x64(%rsp)
  26355d:	mov    %r15,0x50(%rsp)
  263562:	lea    0x0(,%rcx,8),%rax
  26356a:	lea    (%rax,%rax,2),%rax
  26356e:	mov    0x8(%r11),%rbx
  263572:	add    %rax,%rbx
  263575:	lea    0x0(,%rsi,8),%rcx
  26357d:	lea    (%rcx,%rcx,2),%r12
  263581:	sub    %rax,%r12
  263584:	mov    %ebp,0xc8(%rsp)
  26358b:	jmp    2635ac <<glass::engine::Watch>::print_utf8+0x120c>
  26358d:	nopl   (%rax)
  263590:	mov    %r15,(%rbx)
  263593:	mov    %r8d,0x8(%rbx)
  263597:	mov    %ebp,0xc(%rbx)
  26359a:	mov    %edi,0x10(%rbx)
  26359d:	mov    %r13w,0x14(%rbx)
  2635a2:	add    $0x18,%rbx
  2635a6:	add    $0xffffffffffffffe8,%r12
  2635aa:	je     2635ff <<glass::engine::Watch>::print_utf8+0x125f>
  2635ac:	test   %r15,%r15
  2635af:	je     2635bb <<glass::engine::Watch>::print_utf8+0x121b>
  2635b1:	lock incq (%r15)
  2635b5:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  2635bb:	mov    (%rbx),%rax
  2635be:	test   %rax,%rax
  2635c1:	je     263590 <<glass::engine::Watch>::print_utf8+0x11f0>
  2635c3:	lock decq (%rax)
  2635c7:	jne    263590 <<glass::engine::Watch>::print_utf8+0x11f0>
  2635c9:	mov    %edi,%ebp
  2635cb:	mov    %rbx,%rdi
  2635ce:	mov    %r13d,%r15d
  2635d1:	mov    %r8d,%r13d
  2635d4:	call   *0x38d4ee(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  2635da:	mov    %r13d,%r8d
  2635dd:	mov    %r15d,%r13d
  2635e0:	mov    %ebp,%edi
  2635e2:	mov    0xc8(%rsp),%ebp
  2635e9:	mov    0x68(%rsp),%r15
  2635ee:	mov    0x20(%rsp),%r11
  2635f3:	mov    0x38(%rsp),%r10
  2635f8:	mov    0x30(%rsp),%r9
  2635fd:	jmp    263590 <<glass::engine::Watch>::print_utf8+0x11f0>
  2635ff:	mov    0xc0(%rsp),%rax
  263607:	cmp    %eax,0x38(%r11)
  26360b:	mov    0xb0(%rsp),%r12
  263613:	mov    0x48(%rsp),%rdx
  263618:	jbe    26361e <<glass::engine::Watch>::print_utf8+0x127e>
  26361a:	mov    %eax,0x38(%r11)
  26361e:	test   %r15,%r15
  263621:	mov    0x70(%rsp),%rbp
  263626:	mov    0xa0(%rsp),%r13
  26362e:	mov    0xa8(%rsp),%rsi
  263636:	je     263665 <<glass::engine::Watch>::print_utf8+0x12c5>
  263638:	lock decq (%r15)
  26363c:	jne    263665 <<glass::engine::Watch>::print_utf8+0x12c5>
  26363e:	lea    0x50(%rsp),%rdi
  263643:	call   *0x38d47f(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263649:	mov    0xa8(%rsp),%rsi
  263651:	mov    0x20(%rsp),%r11
  263656:	mov    0x38(%rsp),%r10
  26365b:	mov    0x30(%rsp),%r9
  263660:	mov    0x48(%rsp),%rdx
  263665:	mov    0x10(%r11),%r15
  263669:	cmp    %r15,%rsi
  26366c:	mov    0x90(%rsp),%r8
  263674:	mov    0x78(%rsp),%r15
  263679:	jb     2636a7 <<glass::engine::Watch>::print_utf8+0x1307>
  26367b:	mov    0x10(%rsp),%rdi
  263680:	mov    %r8,%rbx
  263683:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263688:	mov    0x20(%rsp),%r11
  26368d:	mov    0x38(%rsp),%r10
  263692:	mov    0x30(%rsp),%r9
  263697:	mov    %rbx,%r8
  26369a:	mov    0x48(%rsp),%rdx
  26369f:	movl   $0xffffffff,0x28(%r11)
  2636a7:	mov    0x30(%r11),%rax
  2636ab:	add    $0x2,%r10
  2636af:	cmp    %rax,%r10
  2636b2:	cmovbe %rax,%r10
  2636b6:	mov    0x10(%r11),%rsi
  2636ba:	mov    %r10,0x30(%r11)
  2636be:	cmp    %rsi,%r13
  2636c1:	jae    264250 <<glass::engine::Watch>::print_utf8+0x1eb0>
  2636c7:	mov    0x8(%r11),%rax
  2636cb:	lea    0x0(,%r13,2),%rcx
  2636d3:	add    %r13,%rcx
  2636d6:	lea    (%rax,%rcx,8),%rbx
  2636da:	movl   $0x20,0x10(%rax,%rcx,8)
  2636e2:	mov    0x40(%rsp),%esi
  2636e6:	mov    %esi,0x8(%rax,%rcx,8)
  2636ea:	mov    0x88(%rsp),%esi
  2636f1:	mov    %esi,0xc(%rax,%rcx,8)
  2636f5:	mov    0x80(%rsp),%esi
  2636fc:	or     $0x40,%esi
  2636ff:	mov    %si,0x14(%rax,%rcx,8)
  263704:	mov    (%rax,%rcx,8),%rax
  263708:	test   %rax,%rax
  26370b:	je     26372c <<glass::engine::Watch>::print_utf8+0x138c>
  26370d:	lock decq (%rax)
  263711:	jne    26372c <<glass::engine::Watch>::print_utf8+0x138c>
  263713:	mov    %rbx,%rdi
  263716:	mov    %r8,%r13
  263719:	call   *0x38d3a9(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  26371f:	mov    0x30(%rsp),%r9
  263724:	mov    %r13,%r8
  263727:	mov    0x48(%rsp),%rdx
  26372c:	movq   $0x0,(%rbx)
  263733:	mov    0x8(%rsp),%rax
  263738:	cmp    %r9,%rax
  26373b:	jb     263745 <<glass::engine::Watch>::print_utf8+0x13a5>
  26373d:	dec    %rax
  263740:	movb   $0x1,0x6c(%r14)
  263745:	mov    %rax,0x40(%r14)
  263749:	incq   0xa0(%r12)
  263751:	jmp    26246c <<glass::engine::Watch>::print_utf8+0xcc>
  263756:	mov    %rdx,%rbx
  263759:	mov    %r8,%r14
  26375c:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263761:	mov    %r14,%r8
  263764:	mov    %rbx,%rdx
  263767:	mov    %r13d,%ebx
  26376a:	mov    0x3902bf(%rip),%rsi        # 5f3a30 <glass::engine::width_of::CACHE+0x8>
  263771:	cmp    %rbx,%rsi
  263774:	ja     262e5f <<glass::engine::Watch>::print_utf8+0xabf>
  26377a:	jmp    264140 <<glass::engine::Watch>::print_utf8+0x1da0>
  26377f:	mov    %rdx,0x48(%rsp)
  263784:	movzbl %r14b,%edx
  263788:	add    %r11,%rdx
  26378b:	mov    0x40(%rsp),%rdi
  263790:	mov    %r9,%rsi
  263793:	mov    %rcx,0x10(%rsp)
  263798:	lea    0xe8(%rsp),%rcx
  2637a0:	mov    %r8,%r15
  2637a3:	mov    %r14,%r13
  2637a6:	mov    %rbp,%r14
  2637a9:	mov    %r10,%rbp
  2637ac:	mov    %r11,%rbx
  2637af:	call   2a1420 <glass::engine::note_uniform_span>
  2637b4:	mov    %rbp,%r10
  2637b7:	mov    %r14,%rbp
  2637ba:	mov    %r13,%r14
  2637bd:	mov    %r15,%r8
  2637c0:	mov    0x48(%rsp),%rdx
  2637c5:	mov    %rbx,%r9
  2637c8:	mov    0x10(%rsp),%r15
  2637cd:	jmp    262d86 <<glass::engine::Watch>::print_utf8+0x9e6>
  2637d2:	cmpq   $0x3ff,0xa0(%r12)
  2637de:	jbe    263816 <<glass::engine::Watch>::print_utf8+0x1476>
  2637e0:	mov    %r12,%rdi
  2637e3:	mov    %r8,%r15
  2637e6:	call   2645e0 <<glass::engine::Watch>::fold_sentinel>
  2637eb:	mov    %r15,%r8
  2637ee:	movq   $0x0,0xa0(%r12)
  2637fa:	mov    0x390240(%rip),%eax        # 5f3a40 <glass::engine::run_whole::ON>
  263800:	test   %eax,%eax
  263802:	je     263820 <<glass::engine::Watch>::print_utf8+0x1480>
  263804:	mov    %r8,%r15
  263807:	call   18ba06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  26380c:	mov    %r15,%r8
  26380f:	cmp    %r8,%r14
  263812:	je     263825 <<glass::engine::Watch>::print_utf8+0x1485>
  263814:	jmp    263857 <<glass::engine::Watch>::print_utf8+0x14b7>
  263816:	mov    0x390224(%rip),%eax        # 5f3a40 <glass::engine::run_whole::ON>
  26381c:	test   %eax,%eax
  26381e:	jne    263804 <<glass::engine::Watch>::print_utf8+0x1464>
  263820:	cmp    %r8,%r14
  263823:	jne    263857 <<glass::engine::Watch>::print_utf8+0x14b7>
  263825:	cmpb   $0x0,0x390218(%rip)        # 5f3a44 <glass::engine::run_whole::ON+0x4>
  26382c:	je     263857 <<glass::engine::Watch>::print_utf8+0x14b7>
  26382e:	cmp    $0xffffffff,%r13d
  263832:	je     263a0a <<glass::engine::Watch>::print_utf8+0x166a>
  263838:	lea    -0x20(%r13),%eax
  26383c:	cmp    $0x5f,%eax
  26383f:	jae    263869 <<glass::engine::Watch>::print_utf8+0x14c9>
  263841:	mov    $0x1,%r15d
  263847:	cmpb   $0x0,0x1c(%rsp)
  26384c:	jne    263938 <<glass::engine::Watch>::print_utf8+0x1598>
  263852:	jmp    2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  263857:	xor    %eax,%eax
  263859:	cmp    $0xffffffff,%r13d
  26385d:	cmove  %rax,%rbx
  263861:	mov    %rbx,%r8
  263864:	jmp    263a0a <<glass::engine::Watch>::print_utf8+0x166a>
  263869:	cmpb   $0x0,0x98(%rsp)
  263871:	je     2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  263877:	mov    0x3901bb(%rip),%eax        # 5f3a38 <glass::engine::width_of::CACHE+0x10>
  26387d:	test   %eax,%eax
  26387f:	jne    264128 <<glass::engine::Watch>::print_utf8+0x1d88>
  263885:	mov    %r13d,%ebx
  263888:	mov    0x3901a1(%rip),%rsi        # 5f3a30 <glass::engine::width_of::CACHE+0x8>
  26388f:	cmp    %rbx,%rsi
  263892:	jbe    264140 <<glass::engine::Watch>::print_utf8+0x1da0>
  263898:	mov    0x390189(%rip),%r14        # 5f3a28 <glass::engine::width_of::CACHE>
  26389f:	movzbl (%r14,%rbx,1),%eax
  2638a4:	movzbl %al,%r15d
  2638a8:	test   %r15b,%r15b
  2638ab:	js     2638b8 <<glass::engine::Watch>::print_utf8+0x1518>
  2638ad:	mov    $0x1,%cl
  2638af:	test   %cl,%cl
  2638b1:	jne    26392a <<glass::engine::Watch>::print_utf8+0x158a>
  2638b3:	jmp    2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  2638b8:	cmp    $0xfe,%r15d
  2638bf:	je     2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  2638c5:	mov    $0xfe,%al
  2638c7:	cmp    $0x7f,%r13d
  2638cb:	jae    263903 <<glass::engine::Watch>::print_utf8+0x1563>
  2638cd:	mov    $0x1,%r15d
  2638d3:	xor    %ecx,%ecx
  2638d5:	jmp    26391e <<glass::engine::Watch>::print_utf8+0x157e>
  2638d7:	mov    $0x1,%cl
  2638d9:	mov    %ecx,0x98(%rsp)
  2638e0:	cmpb   $0x0,0x68(%rax)
  2638e4:	jne    2638f6 <<glass::engine::Watch>::print_utf8+0x1556>
  2638e6:	cmpb   $0x0,0x69(%rax)
  2638ea:	jne    2638f6 <<glass::engine::Watch>::print_utf8+0x1556>
  2638ec:	cmpb   $0x0,0x6a(%rax)
  2638f0:	je     263b14 <<glass::engine::Watch>::print_utf8+0x1774>
  2638f6:	movl   $0x0,0x1c(%rsp)
  2638fe:	jmp    262403 <<glass::engine::Watch>::print_utf8+0x63>
  263903:	cmp    $0xa0,%r13d
  26390a:	jb     26391c <<glass::engine::Watch>::print_utf8+0x157c>
  26390c:	mov    %r13d,%edi
  26390f:	call   2985c0 <unicode_width::tables::lookup_width>
  263914:	movzbl %al,%r15d
  263918:	mov    $0x1,%cl
  26391a:	jmp    26391e <<glass::engine::Watch>::print_utf8+0x157e>
  26391c:	xor    %ecx,%ecx
  26391e:	mov    %al,(%r14,%rbx,1)
  263922:	test   %cl,%cl
  263924:	je     2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  26392a:	lea    -0x1(%r15),%rax
  26392e:	cmp    $0x1,%rax
  263932:	ja     2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  263938:	mov    0xb0(%rsp),%rax
  263940:	mov    0x78(%rax),%r12
  263944:	cmpb   $0x0,0x6c(%r12)
  26394a:	jne    2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  263950:	mov    0x40(%r12),%rbx
  263955:	mov    0xa0(%r12),%rdx
  26395d:	lea    (%rbx,%r15,1),%rbp
  263961:	cmp    %rdx,%rbp
  263964:	ja     2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  26396a:	mov    0x30(%r12),%eax
  26396f:	sub    0x48(%r12),%eax
  263974:	cltq
  263976:	mov    0x20(%r12),%rsi
  26397b:	mov    0x28(%r12),%rcx
  263980:	lea    (%rcx,%rax,1),%rdi
  263984:	dec    %rdi
  263987:	xor    %eax,%eax
  263989:	cmp    %rsi,%rdi
  26398c:	cmovae %rsi,%rax
  263990:	sub    %rax,%rdi
  263993:	cmp    %rsi,%rdi
  263996:	jae    2641d2 <<glass::engine::Watch>::print_utf8+0x1e32>
  26399c:	mov    0x58(%r12),%r9d
  2639a1:	mov    0x5c(%r12),%r10d
  2639a6:	movzwl 0x64(%r12),%r8d
  2639ac:	mov    0x18(%r12),%rax
  2639b1:	shl    $0x6,%rdi
  2639b5:	lea    (%rax,%rdi,1),%r11
  2639b9:	lea    (%rax,%rdi,1),%r14
  2639bd:	add    $0x18,%r14
  2639c1:	mov    0x28(%rax,%rdi,1),%eax
  2639c5:	cmp    $0xffffffff,%eax
  2639c8:	je     2639d3 <<glass::engine::Watch>::print_utf8+0x1633>
  2639ca:	mov    %r14,%rcx
  2639cd:	cmp    0x30(%r11),%rbx
  2639d1:	jae    2639ec <<glass::engine::Watch>::print_utf8+0x164c>
  2639d3:	mov    0x10(%r11),%rsi
  2639d7:	cmp    %rsi,%rbx
  2639da:	jae    264260 <<glass::engine::Watch>::print_utf8+0x1ec0>
  2639e0:	lea    (%rbx,%rbx,2),%rcx
  2639e4:	shl    $0x3,%rcx
  2639e8:	add    0x8(%r11),%rcx
  2639ec:	testb  $0x60,0x14(%rcx)
  2639f0:	je     263a1f <<glass::engine::Watch>::print_utf8+0x167f>
  2639f2:	mov    0xb0(%rsp),%rdi
  2639fa:	mov    %r13d,%esi
  2639fd:	call   33d150 <<glass::engine::Watch as vte::ansi::Handler>::input>
  263a02:	mov    0x90(%rsp),%r8
  263a0a:	mov    %r8,%rax
  263a0d:	add    $0x118,%rsp
  263a14:	pop    %rbx
  263a15:	pop    %r12
  263a17:	pop    %r13
  263a19:	pop    %r14
  263a1b:	pop    %r15
  263a1d:	pop    %rbp
  263a1e:	ret
  263a1f:	cmp    $0x2,%r15
  263a23:	jne    263a56 <<glass::engine::Watch>::print_utf8+0x16b6>
  263a25:	lea    0x1(%rbx),%rdi
  263a29:	cmp    $0xffffffff,%eax
  263a2c:	je     263a37 <<glass::engine::Watch>::print_utf8+0x1697>
  263a2e:	mov    %r14,%rcx
  263a31:	cmp    0x30(%r11),%rdi
  263a35:	jae    263a50 <<glass::engine::Watch>::print_utf8+0x16b0>
  263a37:	mov    0x10(%r11),%rsi
  263a3b:	cmp    %rsi,%rdi
  263a3e:	jae    264213 <<glass::engine::Watch>::print_utf8+0x1e73>
  263a44:	lea    (%rdi,%rdi,2),%rcx
  263a48:	shl    $0x3,%rcx
  263a4c:	add    0x8(%r11),%rcx
  263a50:	testb  $0x60,0x14(%rcx)
  263a54:	jne    2639f2 <<glass::engine::Watch>::print_utf8+0x1652>
  263a56:	mov    %r14,0x20(%rsp)
  263a5b:	mov    %r10d,0x78(%rsp)
  263a60:	mov    %r9d,0x80(%rsp)
  263a68:	mov    %r8d,0x10(%rsp)
  263a6d:	mov    %rdx,0x98(%rsp)
  263a75:	cmp    %ebx,0x38(%r11)
  263a79:	jbe    263a7f <<glass::engine::Watch>::print_utf8+0x16df>
  263a7b:	mov    %ebx,0x38(%r11)
  263a7f:	cmp    $0xffffffff,%eax
  263a82:	setne  %cl
  263a85:	mov    0x30(%r11),%r14
  263a89:	cmp    %r14,%rbx
  263a8c:	sete   %dl
  263a8f:	test   %dl,%cl
  263a91:	mov    %r11,0x28(%rsp)
  263a96:	jne    263adf <<glass::engine::Watch>::print_utf8+0x173f>
  263a98:	cmp    $0xffffffff,%eax
  263a9b:	je     263d43 <<glass::engine::Watch>::print_utf8+0x19a3>
  263aa1:	mov    0x10(%r11),%rbp
  263aa5:	cmp    %r14,%rbp
  263aa8:	mov    %r14,%rcx
  263aab:	cmovb  %rbp,%rcx
  263aaf:	cmp    %rbx,%rbp
  263ab2:	mov    %rbx,%rsi
  263ab5:	cmovb  %rbp,%rsi
  263ab9:	mov    0x38d0c0(%rip),%rax        # 5f0b80 <_DYNAMIC+0x320>
  263ac0:	movzbl (%rax),%eax
  263ac3:	test   %al,%al
  263ac5:	mov    %rsi,0x8(%rsp)
  263aca:	mov    %rcx,0x68(%rsp)
  263acf:	je     263b4a <<glass::engine::Watch>::print_utf8+0x17aa>
  263ad1:	cmp    %rsi,%r14
  263ad4:	jae    263b24 <<glass::engine::Watch>::print_utf8+0x1784>
  263ad6:	mov    0x38d0e3(%rip),%rax        # 5f0bc0 <_DYNAMIC+0x360>
  263add:	jmp    263b2b <<glass::engine::Watch>::print_utf8+0x178b>
  263adf:	lea    0x1(%rbx),%rax
  263ae3:	mov    %rax,0x30(%r11)
  263ae7:	mov    0x10(%r11),%rsi
  263aeb:	cmp    %rsi,%rbx
  263aee:	jb     263d63 <<glass::engine::Watch>::print_utf8+0x19c3>
  263af4:	lea    0x3648ed(%rip),%rdx        # 5c83e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  263afb:	mov    %rbx,%rdi
  263afe:	call   *0x38cf74(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  263b04:	lea    0x364835(%rip),%rcx        # 5c8340 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15a80>
  263b0b:	mov    %r9,%rdi
  263b0e:	call   *0x38d124(%rip)        # 5f0c38 <_DYNAMIC+0x3d8>
  263b14:	cmpb   $0x0,0x6b(%rax)
  263b18:	sete   %al
  263b1b:	mov    %eax,0x1c(%rsp)
  263b1f:	jmp    262403 <<glass::engine::Watch>::print_utf8+0x63>
  263b24:	mov    0x38d08d(%rip),%rax        # 5f0bb8 <_DYNAMIC+0x358>
  263b2b:	lock incq 0x28(%rax)
  263b30:	mov    %rsi,%rdi
  263b33:	sub    %rcx,%rdi
  263b36:	call   2f6d00 <alacritty_terminal::grid::row::fill_census::note>
  263b3b:	mov    0x68(%rsp),%rcx
  263b40:	mov    0x8(%rsp),%rsi
  263b45:	mov    0x28(%rsp),%r11
  263b4a:	cmp    %rsi,%r14
  263b4d:	jae    263d23 <<glass::engine::Watch>::print_utf8+0x1983>
  263b53:	mov    0x28(%r11),%edi
  263b57:	mov    0x20(%r11),%r8d
  263b5b:	mov    0x24(%r11),%r9d
  263b5f:	movzwl 0x2c(%r11),%r10d
  263b64:	mov    0x18(%r11),%rdx
  263b68:	test   %rdx,%rdx
  263b6b:	mov    %rdx,0x40(%rsp)
  263b70:	mov    %edi,0x70(%rsp)
  263b74:	mov    %r8d,0x88(%rsp)
  263b7c:	mov    %r9d,0x30(%rsp)
  263b81:	mov    %r10w,0x38(%rsp)
  263b87:	je     263c50 <<glass::engine::Watch>::print_utf8+0x18b0>
  263b8d:	lock incq (%rdx)
  263b91:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  263b97:	mov    %rdx,%rax
  263b9a:	mov    0x10(%r11),%rdx
  263b9e:	mov    %edi,0x60(%rsp)
  263ba2:	mov    %r8d,0x58(%rsp)
  263ba7:	mov    %r9d,0x5c(%rsp)
  263bac:	mov    %r10w,0x64(%rsp)
  263bb2:	mov    %rax,0x50(%rsp)
  263bb7:	cmp    %rdx,%rsi
  263bba:	ja     2641df <<glass::engine::Watch>::print_utf8+0x1e3f>
  263bc0:	lea    0x0(,%rcx,8),%rax
  263bc8:	lea    (%rax,%rax,2),%rax
  263bcc:	mov    0x8(%r11),%rbp
  263bd0:	add    %rax,%rbp
  263bd3:	lea    0x0(,%rsi,8),%rcx
  263bdb:	lea    (%rcx,%rcx,2),%r14
  263bdf:	sub    %rax,%r14
  263be2:	mov    0x40(%rsp),%rdx
  263be7:	jmp    263c0b <<glass::engine::Watch>::print_utf8+0x186b>
  263be9:	mov    %rdx,0x0(%rbp)
  263bed:	mov    %r8d,0x8(%rbp)
  263bf1:	mov    %r9d,0xc(%rbp)
  263bf5:	mov    %edi,0x10(%rbp)
  263bf8:	mov    %r10w,0x14(%rbp)
  263bfd:	add    $0x18,%rbp
  263c01:	add    $0xffffffffffffffe8,%r14
  263c05:	je     263cea <<glass::engine::Watch>::print_utf8+0x194a>
  263c0b:	lock incq (%rdx)
  263c0f:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  263c15:	mov    0x0(%rbp),%rax
  263c19:	test   %rax,%rax
  263c1c:	je     263be9 <<glass::engine::Watch>::print_utf8+0x1849>
  263c1e:	lock decq (%rax)
  263c22:	jne    263be9 <<glass::engine::Watch>::print_utf8+0x1849>
  263c24:	mov    %rbp,%rdi
  263c27:	call   *0x38ce9b(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263c2d:	movzwl 0x38(%rsp),%r10d
  263c33:	mov    0x30(%rsp),%r9d
  263c38:	mov    0x88(%rsp),%r8d
  263c40:	mov    0x70(%rsp),%edi
  263c44:	mov    0x40(%rsp),%rdx
  263c49:	mov    0x28(%rsp),%r11
  263c4e:	jmp    263be9 <<glass::engine::Watch>::print_utf8+0x1849>
  263c50:	mov    %edi,0x60(%rsp)
  263c54:	mov    %r8d,0x58(%rsp)
  263c59:	mov    %r9d,0x5c(%rsp)
  263c5e:	mov    %r10w,0x64(%rsp)
  263c64:	mov    %rdx,0x50(%rsp)
  263c69:	lea    0x0(,%rcx,8),%rax
  263c71:	lea    (%rax,%rax,2),%rax
  263c75:	mov    0x8(%r11),%rbp
  263c79:	add    %rax,%rbp
  263c7c:	lea    0x0(,%rsi,8),%rcx
  263c84:	lea    (%rcx,%rcx,2),%r14
  263c88:	sub    %rax,%r14
  263c8b:	jmp    263caf <<glass::engine::Watch>::print_utf8+0x190f>
  263c8d:	movq   $0x0,0x0(%rbp)
  263c95:	mov    %r8d,0x8(%rbp)
  263c99:	mov    %r9d,0xc(%rbp)
  263c9d:	mov    %edi,0x10(%rbp)
  263ca0:	mov    %r10w,0x14(%rbp)
  263ca5:	add    $0x18,%rbp
  263ca9:	add    $0xffffffffffffffe8,%r14
  263cad:	je     263cea <<glass::engine::Watch>::print_utf8+0x194a>
  263caf:	mov    0x0(%rbp),%rax
  263cb3:	test   %rax,%rax
  263cb6:	je     263c8d <<glass::engine::Watch>::print_utf8+0x18ed>
  263cb8:	lock decq (%rax)
  263cbc:	jne    263c8d <<glass::engine::Watch>::print_utf8+0x18ed>
  263cbe:	mov    %rbp,%rdi
  263cc1:	call   *0x38ce01(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263cc7:	movzwl 0x38(%rsp),%r10d
  263ccd:	mov    0x30(%rsp),%r9d
  263cd2:	mov    0x88(%rsp),%r8d
  263cda:	mov    0x70(%rsp),%edi
  263cde:	mov    0x40(%rsp),%rdx
  263ce3:	mov    0x28(%rsp),%r11
  263ce8:	jmp    263c8d <<glass::engine::Watch>::print_utf8+0x18ed>
  263cea:	mov    0x68(%rsp),%rax
  263cef:	cmp    %eax,0x38(%r11)
  263cf3:	jbe    263cf9 <<glass::engine::Watch>::print_utf8+0x1959>
  263cf5:	mov    %eax,0x38(%r11)
  263cf9:	test   %rdx,%rdx
  263cfc:	mov    0x8(%rsp),%rsi
  263d01:	je     263d1f <<glass::engine::Watch>::print_utf8+0x197f>
  263d03:	lock decq (%rdx)
  263d07:	jne    263d1f <<glass::engine::Watch>::print_utf8+0x197f>
  263d09:	lea    0x50(%rsp),%rdi
  263d0e:	mov    %rsi,%r14
  263d11:	call   *0x38cdb1(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263d17:	mov    %r14,%rsi
  263d1a:	mov    0x28(%rsp),%r11
  263d1f:	mov    0x10(%r11),%rbp
  263d23:	cmp    %rbp,%rsi
  263d26:	lea    (%rbx,%r15,1),%rbp
  263d2a:	jb     263d43 <<glass::engine::Watch>::print_utf8+0x19a3>
  263d2c:	mov    0x20(%rsp),%rdi
  263d31:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263d36:	mov    0x28(%rsp),%r11
  263d3b:	movl   $0xffffffff,0x28(%r11)
  263d43:	mov    0x30(%r11),%rax
  263d47:	lea    0x1(%rbx),%rcx
  263d4b:	cmp    %rax,%rcx
  263d4e:	cmova  %rcx,%rax
  263d52:	mov    0x10(%r11),%rsi
  263d56:	mov    %rax,0x30(%r11)
  263d5a:	cmp    %rsi,%rbx
  263d5d:	jae    264270 <<glass::engine::Watch>::print_utf8+0x1ed0>
  263d63:	mov    0x10(%rsp),%esi
  263d67:	mov    %esi,%eax
  263d69:	or     $0x20,%eax
  263d6c:	cmp    $0x2,%r15
  263d70:	mov    0x8(%r11),%rcx
  263d74:	lea    (%rbx,%rbx,2),%rdx
  263d78:	lea    (%rcx,%rdx,8),%r14
  263d7c:	mov    %r13d,0x10(%rcx,%rdx,8)
  263d81:	mov    0x80(%rsp),%edi
  263d88:	mov    %edi,0x8(%rcx,%rdx,8)
  263d8c:	cmovne %esi,%eax
  263d8f:	mov    0x78(%rsp),%esi
  263d93:	mov    %esi,0xc(%rcx,%rdx,8)
  263d97:	mov    %ax,0x14(%rcx,%rdx,8)
  263d9c:	mov    (%rcx,%rdx,8),%rax
  263da0:	test   %rax,%rax
  263da3:	je     263db9 <<glass::engine::Watch>::print_utf8+0x1a19>
  263da5:	lock decq (%rax)
  263da9:	jne    263db9 <<glass::engine::Watch>::print_utf8+0x1a19>
  263dab:	mov    %r14,%rdi
  263dae:	call   *0x38cd14(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263db4:	mov    0x28(%rsp),%r11
  263db9:	movq   $0x0,(%r14)
  263dc0:	cmp    $0x2,%r15
  263dc4:	mov    0x90(%rsp),%r8
  263dcc:	jne    2640f5 <<glass::engine::Watch>::print_utf8+0x1d55>
  263dd2:	lea    0x1(%rbx),%rdi
  263dd6:	mov    0x30(%r11),%r14
  263dda:	mov    0x28(%r11),%eax
  263dde:	cmp    %r14,%rdi
  263de1:	jne    263e0a <<glass::engine::Watch>::print_utf8+0x1a6a>
  263de3:	cmp    $0xffffffff,%eax
  263de6:	je     263e0a <<glass::engine::Watch>::print_utf8+0x1a6a>
  263de8:	add    $0x2,%rbx
  263dec:	mov    %rbx,0x30(%r11)
  263df0:	mov    0x10(%r11),%rsi
  263df4:	cmp    %rsi,%rdi
  263df7:	jb     26409d <<glass::engine::Watch>::print_utf8+0x1cfd>
  263dfd:	lea    0x3645e4(%rip),%rdx        # 5c83e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  263e04:	call   *0x38cc6e(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  263e0a:	cmp    $0xffffffff,%eax
  263e0d:	je     26407d <<glass::engine::Watch>::print_utf8+0x1cdd>
  263e13:	mov    0x10(%r11),%r15
  263e17:	cmp    %r14,%r15
  263e1a:	mov    %r14,%rcx
  263e1d:	cmovb  %r15,%rcx
  263e21:	cmp    %rdi,%r15
  263e24:	mov    %rdi,%rsi
  263e27:	cmovb  %r15,%rsi
  263e2b:	mov    0x38cd4e(%rip),%rax        # 5f0b80 <_DYNAMIC+0x320>
  263e32:	movzbl (%rax),%eax
  263e35:	test   %al,%al
  263e37:	mov    %rsi,0x38(%rsp)
  263e3c:	mov    %rcx,0x8(%rsp)
  263e41:	je     263e7b <<glass::engine::Watch>::print_utf8+0x1adb>
  263e43:	cmp    %rsi,%r14
  263e46:	jae    263e51 <<glass::engine::Watch>::print_utf8+0x1ab1>
  263e48:	mov    0x38cd71(%rip),%rax        # 5f0bc0 <_DYNAMIC+0x360>
  263e4f:	jmp    263e58 <<glass::engine::Watch>::print_utf8+0x1ab8>
  263e51:	mov    0x38cd60(%rip),%rax        # 5f0bb8 <_DYNAMIC+0x358>
  263e58:	lock incq 0x28(%rax)
  263e5d:	mov    %rsi,%rdi
  263e60:	sub    %rcx,%rdi
  263e63:	call   2f6d00 <alacritty_terminal::grid::row::fill_census::note>
  263e68:	mov    0x8(%rsp),%rcx
  263e6d:	mov    0x38(%rsp),%rsi
  263e72:	mov    0x28(%rsp),%r11
  263e77:	lea    0x1(%rbx),%rdi
  263e7b:	cmp    %rsi,%r14
  263e7e:	jae    26404f <<glass::engine::Watch>::print_utf8+0x1caf>
  263e84:	mov    0x28(%r11),%edi
  263e88:	mov    0x20(%r11),%r8d
  263e8c:	mov    0x24(%r11),%r9d
  263e90:	movzwl 0x2c(%r11),%r10d
  263e95:	mov    0x18(%r11),%r15
  263e99:	test   %r15,%r15
  263e9c:	mov    %edi,0x40(%rsp)
  263ea0:	mov    %r8d,0x70(%rsp)
  263ea5:	mov    %r9d,0x88(%rsp)
  263ead:	mov    %r10w,0x30(%rsp)
  263eb3:	mov    %rbp,0x48(%rsp)
  263eb8:	je     263f74 <<glass::engine::Watch>::print_utf8+0x1bd4>
  263ebe:	lock incq (%r15)
  263ec2:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  263ec8:	mov    0x10(%r11),%rdx
  263ecc:	mov    %edi,0x60(%rsp)
  263ed0:	mov    %r8d,0x58(%rsp)
  263ed5:	mov    %r9d,0x5c(%rsp)
  263eda:	mov    %r10w,0x64(%rsp)
  263ee0:	mov    %r15,0x50(%rsp)
  263ee5:	cmp    %rdx,%rsi
  263ee8:	ja     264201 <<glass::engine::Watch>::print_utf8+0x1e61>
  263eee:	lea    0x0(,%rcx,8),%rax
  263ef6:	lea    (%rax,%rax,2),%rax
  263efa:	mov    0x8(%r11),%rbp
  263efe:	add    %rax,%rbp
  263f01:	lea    0x0(,%rsi,8),%rcx
  263f09:	lea    (%rcx,%rcx,2),%r14
  263f0d:	sub    %rax,%r14
  263f10:	jmp    263f34 <<glass::engine::Watch>::print_utf8+0x1b94>
  263f12:	mov    %r15,0x0(%rbp)
  263f16:	mov    %r8d,0x8(%rbp)
  263f1a:	mov    %r9d,0xc(%rbp)
  263f1e:	mov    %edi,0x10(%rbp)
  263f21:	mov    %r10w,0x14(%rbp)
  263f26:	add    $0x18,%rbp
  263f2a:	add    $0xffffffffffffffe8,%r14
  263f2e:	je     264009 <<glass::engine::Watch>::print_utf8+0x1c69>
  263f34:	lock incq (%r15)
  263f38:	jle    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  263f3e:	mov    0x0(%rbp),%rax
  263f42:	test   %rax,%rax
  263f45:	je     263f12 <<glass::engine::Watch>::print_utf8+0x1b72>
  263f47:	lock decq (%rax)
  263f4b:	jne    263f12 <<glass::engine::Watch>::print_utf8+0x1b72>
  263f4d:	mov    %rbp,%rdi
  263f50:	call   *0x38cb72(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263f56:	movzwl 0x30(%rsp),%r10d
  263f5c:	mov    0x88(%rsp),%r9d
  263f64:	mov    0x70(%rsp),%r8d
  263f69:	mov    0x40(%rsp),%edi
  263f6d:	mov    0x28(%rsp),%r11
  263f72:	jmp    263f12 <<glass::engine::Watch>::print_utf8+0x1b72>
  263f74:	mov    %edi,0x60(%rsp)
  263f78:	mov    %r8d,0x58(%rsp)
  263f7d:	mov    %r9d,0x5c(%rsp)
  263f82:	mov    %r10w,0x64(%rsp)
  263f88:	mov    %r15,0x50(%rsp)
  263f8d:	lea    0x0(,%rcx,8),%rax
  263f95:	lea    (%rax,%rax,2),%rax
  263f99:	mov    0x8(%r11),%rbp
  263f9d:	add    %rax,%rbp
  263fa0:	lea    0x0(,%rsi,8),%rcx
  263fa8:	lea    (%rcx,%rcx,2),%r14
  263fac:	sub    %rax,%r14
  263faf:	jmp    263fd3 <<glass::engine::Watch>::print_utf8+0x1c33>
  263fb1:	movq   $0x0,0x0(%rbp)
  263fb9:	mov    %r8d,0x8(%rbp)
  263fbd:	mov    %r9d,0xc(%rbp)
  263fc1:	mov    %edi,0x10(%rbp)
  263fc4:	mov    %r10w,0x14(%rbp)
  263fc9:	add    $0x18,%rbp
  263fcd:	add    $0xffffffffffffffe8,%r14
  263fd1:	je     264009 <<glass::engine::Watch>::print_utf8+0x1c69>
  263fd3:	mov    0x0(%rbp),%rax
  263fd7:	test   %rax,%rax
  263fda:	je     263fb1 <<glass::engine::Watch>::print_utf8+0x1c11>
  263fdc:	lock decq (%rax)
  263fe0:	jne    263fb1 <<glass::engine::Watch>::print_utf8+0x1c11>
  263fe2:	mov    %rbp,%rdi
  263fe5:	call   *0x38cadd(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  263feb:	movzwl 0x30(%rsp),%r10d
  263ff1:	mov    0x88(%rsp),%r9d
  263ff9:	mov    0x70(%rsp),%r8d
  263ffe:	mov    0x40(%rsp),%edi
  264002:	mov    0x28(%rsp),%r11
  264007:	jmp    263fb1 <<glass::engine::Watch>::print_utf8+0x1c11>
  264009:	mov    0x8(%rsp),%rax
  26400e:	cmp    %eax,0x38(%r11)
  264012:	jbe    264018 <<glass::engine::Watch>::print_utf8+0x1c78>
  264014:	mov    %eax,0x38(%r11)
  264018:	test   %r15,%r15
  26401b:	mov    0x48(%rsp),%rbp
  264020:	lea    0x1(%rbx),%rdi
  264024:	mov    0x38(%rsp),%rsi
  264029:	je     26404b <<glass::engine::Watch>::print_utf8+0x1cab>
  26402b:	lock decq (%r15)
  26402f:	jne    26404b <<glass::engine::Watch>::print_utf8+0x1cab>
  264031:	lea    0x50(%rsp),%rdi
  264036:	mov    %rsi,%r14
  264039:	call   *0x38ca89(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  26403f:	mov    %r14,%rsi
  264042:	lea    0x1(%rbx),%rdi
  264046:	mov    0x28(%rsp),%r11
  26404b:	mov    0x10(%r11),%r15
  26404f:	cmp    %r15,%rsi
  264052:	mov    0x90(%rsp),%r8
  26405a:	jb     26407d <<glass::engine::Watch>::print_utf8+0x1cdd>
  26405c:	mov    0x20(%rsp),%rdi
  264061:	mov    %r8,%r14
  264064:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  264069:	lea    0x1(%rbx),%rdi
  26406d:	mov    0x28(%rsp),%r11
  264072:	mov    %r14,%r8
  264075:	movl   $0xffffffff,0x28(%r11)
  26407d:	mov    0x30(%r11),%rax
  264081:	add    $0x2,%rbx
  264085:	cmp    %rax,%rbx
  264088:	cmovbe %rax,%rbx
  26408c:	mov    0x10(%r11),%rsi
  264090:	mov    %rbx,0x30(%r11)
  264094:	cmp    %rsi,%rdi
  264097:	jae    264280 <<glass::engine::Watch>::print_utf8+0x1ee0>
  26409d:	mov    0x8(%r11),%rax
  2640a1:	lea    (%rdi,%rdi,2),%rcx
  2640a5:	lea    (%rax,%rcx,8),%rbx
  2640a9:	movl   $0x20,0x10(%rax,%rcx,8)
  2640b1:	mov    0x80(%rsp),%edx
  2640b8:	mov    %edx,0x8(%rax,%rcx,8)
  2640bc:	mov    0x78(%rsp),%edx
  2640c0:	mov    %edx,0xc(%rax,%rcx,8)
  2640c4:	mov    0x10(%rsp),%edx
  2640c8:	or     $0x40,%edx
  2640cb:	mov    %dx,0x14(%rax,%rcx,8)
  2640d0:	mov    (%rax,%rcx,8),%rax
  2640d4:	test   %rax,%rax
  2640d7:	je     2640ee <<glass::engine::Watch>::print_utf8+0x1d4e>
  2640d9:	lock decq (%rax)
  2640dd:	jne    2640ee <<glass::engine::Watch>::print_utf8+0x1d4e>
  2640df:	mov    %rbx,%rdi
  2640e2:	mov    %r8,%r14
  2640e5:	call   *0x38c9dd(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  2640eb:	mov    %r14,%r8
  2640ee:	movq   $0x0,(%rbx)
  2640f5:	cmp    0x98(%rsp),%rbp
  2640fd:	jb     264108 <<glass::engine::Watch>::print_utf8+0x1d68>
  2640ff:	dec    %rbp
  264102:	movb   $0x1,0x6c(%r12)
  264108:	mov    %rbp,0x40(%r12)
  26410d:	mov    0xb0(%rsp),%rax
  264115:	incq   0xa0(%rax)
  26411c:	mov    %r13d,0xb0(%rax)
  264123:	jmp    263a0a <<glass::engine::Watch>::print_utf8+0x166a>
  264128:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  26412d:	mov    %r13d,%ebx
  264130:	mov    0x38f8f9(%rip),%rsi        # 5f3a30 <glass::engine::width_of::CACHE+0x8>
  264137:	cmp    %rbx,%rsi
  26413a:	ja     263898 <<glass::engine::Watch>::print_utf8+0x14f8>
  264140:	lea    0x366491(%rip),%rdx        # 5ca5d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d18>
  264147:	mov    %rbx,%rdi
  26414a:	call   *0x38c928(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264150:	lea    0x363691(%rip),%rcx        # 5c77e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  264157:	mov    0xb8(%rsp),%rdi
  26415f:	call   *0x38cad3(%rip)        # 5f0c38 <_DYNAMIC+0x3d8>
  264165:	jmp    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  26416a:	mov    %rcx,%rdi
  26416d:	lea    0x363674(%rip),%rcx        # 5c77e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  264174:	call   *0x38cabe(%rip)        # 5f0c38 <_DYNAMIC+0x3d8>
  26417a:	jmp    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  26417f:	lea    0x363b5a(%rip),%rdx        # 5c7ce0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15420>
  264186:	call   *0x38c8ec(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  26418c:	lea    0x363b65(%rip),%rax        # 5c7cf8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15438>
  264193:	jmp    2641b4 <<glass::engine::Watch>::print_utf8+0x1e14>
  264195:	lea    0x363ba4(%rip),%rdx        # 5c7d40 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15480>
  26419c:	mov    %rbx,%rdi
  26419f:	mov    0x20(%rsp),%rsi
  2641a4:	call   *0x38c8ce(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  2641aa:	mov    %rax,%rbx
  2641ad:	lea    0x363b5c(%rip),%rax        # 5c7d10 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15450>
  2641b4:	mov    %rax,0xd8(%rsp)
  2641bc:	mov    %rbx,%rdi
  2641bf:	mov    0x20(%rsp),%rsi
  2641c4:	mov    0xd8(%rsp),%rdx
  2641cc:	call   *0x38c8a6(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  2641d2:	lea    0x363c87(%rip),%rdx        # 5c7e60 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a0>
  2641d9:	call   *0x38c899(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  2641df:	mov    %rcx,%rdi
  2641e2:	lea    0x3635ff(%rip),%rcx        # 5c77e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  2641e9:	call   *0x38ca49(%rip)        # 5f0c38 <_DYNAMIC+0x3d8>
  2641ef:	jmp    264211 <<glass::engine::Watch>::print_utf8+0x1e71>
  2641f1:	lea    0x351cb0(%rip),%rdx        # 5b5ea8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  2641f8:	mov    %r10,%rdi
  2641fb:	call   *0x38c877(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264201:	mov    %rcx,%rdi
  264204:	lea    0x3635dd(%rip),%rcx        # 5c77e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  26420b:	call   *0x38ca27(%rip)        # 5f0c38 <_DYNAMIC+0x3d8>
  264211:	ud2
  264213:	lea    0x351c8e(%rip),%rdx        # 5b5ea8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  26421a:	call   *0x38c858(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264220:	lea    0x3641c1(%rip),%rdx        # 5c83e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  264227:	mov    %r10,%rdi
  26422a:	call   *0x38c848(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264230:	lea    0x364199(%rip),%rdx        # 5c83d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264237:	mov    %r10,%rdi
  26423a:	call   *0x38c838(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264240:	lea    0x3641a1(%rip),%rdx        # 5c83e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  264247:	mov    %r13,%rdi
  26424a:	call   *0x38c828(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264250:	lea    0x364179(%rip),%rdx        # 5c83d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264257:	mov    %r13,%rdi
  26425a:	call   *0x38c818(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264260:	lea    0x351c41(%rip),%rdx        # 5b5ea8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264267:	mov    %rbx,%rdi
  26426a:	call   *0x38c808(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264270:	lea    0x364159(%rip),%rdx        # 5c83d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264277:	mov    %rbx,%rdi
  26427a:	call   *0x38c7f8(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  264280:	lea    0x364149(%rip),%rdx        # 5c83d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264287:	call   *0x38c7eb(%rip)        # 5f0a78 <_DYNAMIC+0x218>
  26428d:	mov    %rax,%rbx
  264290:	lock decq (%r15)
  264294:	je     2642bd <<glass::engine::Watch>::print_utf8+0x1f1d>
  264296:	jmp    2642cb <<glass::engine::Watch>::print_utf8+0x1f2b>
  264298:	mov    %rax,%rbx
  26429b:	mov    0x40(%rsp),%rax
  2642a0:	jmp    2642b7 <<glass::engine::Watch>::print_utf8+0x1f17>
  2642a2:	mov    %rax,%rbx
  2642a5:	mov    0x68(%rsp),%rax
  2642aa:	jmp    2642b7 <<glass::engine::Watch>::print_utf8+0x1f17>
  2642ac:	mov    %rax,%rbx
  2642af:	mov    0xa8(%rsp),%rax
  2642b7:	lock decq (%rax)
  2642bb:	jne    2642cb <<glass::engine::Watch>::print_utf8+0x1f2b>
  2642bd:	mov    0x108(%rsp),%rdi
  2642c5:	call   *0x38c7fd(%rip)        # 5f0ac8 <_DYNAMIC+0x268>
  2642cb:	mov    %rbx,%rdi
  2642ce:	call   5af1b0 <_Unwind_Resume@plt>
