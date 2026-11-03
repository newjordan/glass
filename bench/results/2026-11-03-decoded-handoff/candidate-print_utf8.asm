
/tmp/glass-i27-candidate-test:     file format elf64-x86-64


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
  2623b4:	mov    %rsi,0x20(%rsp)
  2623b9:	mov    %rdi,%r14
  2623bc:	cmpb   $0x1,0xbe(%rdi)
  2623c3:	jne    2623f0 <<glass::engine::Watch>::print_utf8+0x50>
  2623c5:	cmpq   $0x0,0x38(%r14)
  2623ca:	jne    2623f0 <<glass::engine::Watch>::print_utf8+0x50>
  2623cc:	mov    0x78(%r14),%rax
  2623d0:	testb  $0x4,0x6c5(%rax)
  2623d7:	jne    2623f0 <<glass::engine::Watch>::print_utf8+0x50>
  2623d9:	cmpq   $0x0,0x50(%rax)
  2623de:	jne    2623f0 <<glass::engine::Watch>::print_utf8+0x50>
  2623e0:	movzwl 0x64(%rax),%ecx
  2623e4:	test   $0x460,%ecx
  2623ea:	je     263f96 <<glass::engine::Watch>::print_utf8+0x1bf6>
  2623f0:	movl   $0x0,0x1c(%rsp)
  2623f8:	movl   $0x0,0x30(%rsp)
  262400:	movq   $0x0,0x10(%rsp)
  262409:	lea    0x366ad8(%rip),%rax        # 5c8ee8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15468>
  262410:	mov    %rax,0xd8(%rsp)
  262418:	lea    0x58(%rsp),%rax
  26241d:	mov    %rax,0x110(%rsp)
  262425:	mov    $0xffffffff,%edx
  26242a:	xor    %r12d,%r12d
  26242d:	mov    %r8,0x98(%rsp)
  262435:	mov    %r14,0xd0(%rsp)
  26243d:	jmp    26246b <<glass::engine::Watch>::print_utf8+0xcb>
  26243f:	nop
  262440:	mov    0xd0(%rsp),%r14
  262448:	mov    %r14,%rdi
  26244b:	mov    %edx,%esi
  26244d:	call   33d650 <<glass::engine::Watch as vte::ansi::Handler>::input>
  262452:	mov    0x98(%rsp),%r8
  26245a:	mov    %r15,%r12
  26245d:	add    %r12,%rbp
  262460:	mov    %r12,0x10(%rsp)
  262465:	mov    %r13d,%edx
  262468:	mov    %rbp,%r12
  26246b:	cmpb   $0x0,0x30(%rsp)
  262470:	je     2624e0 <<glass::engine::Watch>::print_utf8+0x140>
  262472:	mov    0x78(%r14),%r9
  262476:	cmpb   $0x0,0x6c(%r9)
  26247b:	je     262510 <<glass::engine::Watch>::print_utf8+0x170>
  262481:	cmp    %r8,%r12
  262484:	jae    263e89 <<glass::engine::Watch>::print_utf8+0x1ae9>
  26248a:	mov    0x20(%rsp),%rax
  26248f:	movzbl (%rax,%r12,1),%r13d
  262494:	test   %r13b,%r13b
  262497:	jns    2624fc <<glass::engine::Watch>::print_utf8+0x15c>
  262499:	lea    0x3e(%r13),%eax
  26249d:	cmp    $0x1e,%al
  26249f:	jb     262651 <<glass::engine::Watch>::print_utf8+0x2b1>
  2624a5:	mov    %r13d,%eax
  2624a8:	and    $0xf0,%al
  2624aa:	cmp    $0xe0,%al
  2624ac:	jne    2630bb <<glass::engine::Watch>::print_utf8+0xd1b>
  2624b2:	mov    $0xbf,%al
  2624b4:	cmp    $0xe0,%r13d
  2624bb:	je     263212 <<glass::engine::Watch>::print_utf8+0xe72>
  2624c1:	mov    $0x80,%cl
  2624c3:	mov    %rdx,%rdi
  2624c6:	cmp    $0xed,%r13d
  2624cd:	jne    263217 <<glass::engine::Watch>::print_utf8+0xe77>
  2624d3:	mov    $0x9f,%al
  2624d5:	jmp    263217 <<glass::engine::Watch>::print_utf8+0xe77>
  2624da:	nopw   0x0(%rax,%rax,1)
  2624e0:	cmp    %r8,%r12
  2624e3:	jae    263e89 <<glass::engine::Watch>::print_utf8+0x1ae9>
  2624e9:	mov    0x20(%rsp),%rax
  2624ee:	movzbl (%rax,%r12,1),%r13d
  2624f3:	test   %r13b,%r13b
  2624f6:	js     262645 <<glass::engine::Watch>::print_utf8+0x2a5>
  2624fc:	mov    $0x1,%ebp
  262501:	jmp    26344c <<glass::engine::Watch>::print_utf8+0x10ac>
  262506:	cs nopw 0x0(%rax,%rax,1)
  262510:	mov    0x30(%r9),%eax
  262514:	sub    0x48(%r9),%eax
  262518:	cltq
  26251a:	mov    0x20(%r9),%rsi
  26251e:	mov    0x28(%r9),%rcx
  262522:	lea    (%rcx,%rax,1),%rdi
  262526:	dec    %rdi
  262529:	cmp    %rsi,%rdi
  26252c:	mov    $0x0,%eax
  262531:	cmovae %rsi,%rax
  262535:	sub    %rax,%rdi
  262538:	cmp    %rsi,%rdi
  26253b:	jae    264829 <<glass::engine::Watch>::print_utf8+0x2489>
  262541:	mov    0xa0(%r9),%rax
  262548:	mov    %rax,0x40(%rsp)
  26254d:	mov    0x40(%r9),%r10
  262551:	mov    0x58(%r9),%ebp
  262555:	mov    0x5c(%r9),%eax
  262559:	mov    %eax,0xa0(%rsp)
  262560:	movzwl 0x64(%r9),%eax
  262565:	mov    %eax,0x80(%rsp)
  26256c:	mov    0x18(%r9),%rax
  262570:	shl    $0x6,%rdi
  262574:	lea    (%rax,%rdi,1),%r11
  262578:	cmp    %r10d,0x38(%rax,%rdi,1)
  26257d:	jbe    262583 <<glass::engine::Watch>::print_utf8+0x1e3>
  26257f:	mov    %r10d,0x38(%r11)
  262583:	mov    %rdx,0x8(%rsp)
  262588:	mov    0x28(%r11),%edi
  26258c:	cmp    $0xffffffff,%edi
  26258f:	je     262685 <<glass::engine::Watch>::print_utf8+0x2e5>
  262595:	mov    0x30(%r11),%rax
  262599:	cmp    %rax,%r10
  26259c:	mov    $0x0,%ecx
  2625a1:	cmovb  %rax,%rcx
  2625a5:	mov    %rcx,0x48(%rsp)
  2625aa:	movl   $0x20,0x100(%rsp)
  2625b5:	mov    %ebp,0xf8(%rsp)
  2625bc:	mov    0xa0(%rsp),%ecx
  2625c3:	mov    %ecx,0xfc(%rsp)
  2625ca:	mov    0x80(%rsp),%ecx
  2625d1:	mov    %cx,0x104(%rsp)
  2625d9:	movq   $0x0,0xf0(%rsp)
  2625e5:	mov    0x10(%r11),%rcx
  2625e9:	cmp    %rax,%rcx
  2625ec:	mov    %rax,%r15
  2625ef:	cmovb  %rcx,%r15
  2625f3:	cmp    %r10,%rcx
  2625f6:	mov    %r10,%r13
  2625f9:	cmovb  %rcx,%r13
  2625fd:	mov    0x38f73c(%rip),%rdx        # 5f1d40 <_DYNAMIC+0x320>
  262604:	movzbl (%rdx),%edx
  262607:	test   %dl,%dl
  262609:	je     262786 <<glass::engine::Watch>::print_utf8+0x3e6>
  26260f:	mov    0x38f762(%rip),%rdx        # 5f1d78 <_DYNAMIC+0x358>
  262616:	cmp    %r13,%rax
  262619:	jae    262622 <<glass::engine::Watch>::print_utf8+0x282>
  26261b:	mov    0x38f75e(%rip),%rdx        # 5f1d80 <_DYNAMIC+0x360>
  262622:	lock incq 0x28(%rdx)
  262627:	mov    0x38f72a(%rip),%rdx        # 5f1d58 <_DYNAMIC+0x338>
  26262e:	lock incq (%rdx)
  262632:	mov    %r13,%rdx
  262635:	sub    %r15,%rdx
  262638:	jne    262703 <<glass::engine::Watch>::print_utf8+0x363>
  26263e:	xor    %esi,%esi
  262640:	jmp    26277a <<glass::engine::Watch>::print_utf8+0x3da>
  262645:	lea    0x3e(%r13),%eax
  262649:	cmp    $0x1e,%al
  26264b:	jae    2626d2 <<glass::engine::Watch>::print_utf8+0x332>
  262651:	lea    0x1(%r12),%rax
  262656:	cmp    %r8,%rax
  262659:	jae    263e89 <<glass::engine::Watch>::print_utf8+0x1ae9>
  26265f:	mov    0x20(%rsp),%rcx
  262664:	movzbl (%rcx,%rax,1),%eax
  262668:	cmp    $0xc0,%al
  26266a:	jge    263e89 <<glass::engine::Watch>::print_utf8+0x1ae9>
  262670:	mov    %rdx,%rdi
  262673:	and    $0x1f,%r13d
  262677:	shl    $0x6,%r13d
  26267b:	mov    $0x2,%ecx
  262680:	jmp    263276 <<glass::engine::Watch>::print_utf8+0xed6>
  262685:	movl   $0x20,0x100(%rsp)
  262690:	mov    %ebp,0xf8(%rsp)
  262697:	mov    0xa0(%rsp),%eax
  26269e:	mov    %eax,0xfc(%rsp)
  2626a5:	mov    0x80(%rsp),%eax
  2626ac:	mov    %ax,0x104(%rsp)
  2626b4:	movq   $0x0,0xf0(%rsp)
  2626c0:	lea    0x30(%r11),%rbx
  2626c4:	movq   $0xffffffffffffffff,0x48(%rsp)
  2626cd:	jmp    262954 <<glass::engine::Watch>::print_utf8+0x5b4>
  2626d2:	mov    %r13d,%eax
  2626d5:	and    $0xf0,%al
  2626d7:	cmp    $0xe0,%al
  2626d9:	jne    262722 <<glass::engine::Watch>::print_utf8+0x382>
  2626db:	mov    $0xbf,%al
  2626dd:	cmp    $0xe0,%r13d
  2626e4:	je     263168 <<glass::engine::Watch>::print_utf8+0xdc8>
  2626ea:	mov    $0x80,%cl
  2626ec:	mov    %rdx,%rdi
  2626ef:	cmp    $0xed,%r13d
  2626f6:	jne    26316d <<glass::engine::Watch>::print_utf8+0xdcd>
  2626fc:	mov    $0x9f,%al
  2626fe:	jmp    26316d <<glass::engine::Watch>::print_utf8+0xdcd>
  262703:	mov    0x38f656(%rip),%rsi        # 5f1d60 <_DYNAMIC+0x340>
  26270a:	lock add %rdx,(%rsi)
  26270e:	cmp    $0x5,%rdx
  262712:	jae    262756 <<glass::engine::Watch>::print_utf8+0x3b6>
  262714:	lea    -0x204c03(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  26271b:	movzbl -0x1(%rdx,%rsi,1),%esi
  262720:	jmp    26277a <<glass::engine::Watch>::print_utf8+0x3da>
  262722:	lea    0x10(%r13),%eax
  262726:	cmp    $0x5,%al
  262728:	jae    263e89 <<glass::engine::Watch>::print_utf8+0x1ae9>
  26272e:	mov    $0x80,%al
  262730:	cmp    $0xf4,%r13d
  262737:	je     2630d6 <<glass::engine::Watch>::print_utf8+0xd36>
  26273d:	mov    $0xbf,%cl
  26273f:	mov    %rdx,%rdi
  262742:	cmp    $0xf0,%r13d
  262749:	jne    2630db <<glass::engine::Watch>::print_utf8+0xd3b>
  26274f:	mov    $0x90,%al
  262751:	jmp    2630db <<glass::engine::Watch>::print_utf8+0xd3b>
  262756:	mov    %edi,%ebx
  262758:	lea    -0x5(%rdx),%rdi
  26275c:	mov    $0x4,%esi
  262761:	cmp    $0x4,%rdi
  262765:	mov    %ebx,%edi
  262767:	jb     26277a <<glass::engine::Watch>::print_utf8+0x3da>
  262769:	add    $0xfffffffffffffff7,%rdx
  26276d:	cmp    $0x8,%rdx
  262771:	mov    $0x6,%esi
  262776:	sbb    $0x0,%rsi
  26277a:	mov    0x38f5cf(%rip),%rdx        # 5f1d50 <_DYNAMIC+0x330>
  262781:	lock incq (%rdx,%rsi,8)
  262786:	cmp    %r13,%rax
  262789:	jae    2628fa <<glass::engine::Watch>::print_utf8+0x55a>
  26278f:	mov    %r13,0x90(%rsp)
  262797:	mov    %ebp,0x50(%rsp)
  26279b:	mov    %r10,0x38(%rsp)
  2627a0:	mov    %r9,0x88(%rsp)
  2627a8:	mov    %r12,0x28(%rsp)
  2627ad:	mov    0x20(%r11),%edx
  2627b1:	mov    0x24(%r11),%r14d
  2627b5:	movzwl 0x2c(%r11),%r13d
  2627ba:	mov    0x18(%r11),%r12
  2627be:	test   %r12,%r12
  2627c1:	je     2627ce <<glass::engine::Watch>::print_utf8+0x42e>
  2627c3:	lock incq (%r12)
  2627c8:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  2627ce:	mov    %edi,0x68(%rsp)
  2627d2:	mov    %edx,0x60(%rsp)
  2627d6:	mov    %r14d,0x64(%rsp)
  2627db:	mov    %r13w,0x6c(%rsp)
  2627e1:	mov    %r12,0x58(%rsp)
  2627e6:	mov    %r15,0x78(%rsp)
  2627eb:	lea    0x0(,%r15,8),%rax
  2627f3:	lea    (%rax,%rax,2),%rax
  2627f7:	mov    %r11,0xb0(%rsp)
  2627ff:	mov    0x8(%r11),%rbx
  262803:	add    %rax,%rbx
  262806:	mov    0x90(%rsp),%rcx
  26280e:	lea    0x0(,%rcx,8),%rcx
  262816:	lea    (%rcx,%rcx,2),%rbp
  26281a:	sub    %rax,%rbp
  26281d:	mov    %edi,0x70(%rsp)
  262821:	jmp    26284c <<glass::engine::Watch>::print_utf8+0x4ac>
  262823:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262830:	mov    %r12,(%rbx)
  262833:	mov    %edx,0x8(%rbx)
  262836:	mov    %r14d,0xc(%rbx)
  26283a:	mov    %edi,0x10(%rbx)
  26283d:	mov    %r13w,0x14(%rbx)
  262842:	add    $0x18,%rbx
  262846:	add    $0xffffffffffffffe8,%rbp
  26284a:	je     26287f <<glass::engine::Watch>::print_utf8+0x4df>
  26284c:	test   %r12,%r12
  26284f:	je     26285c <<glass::engine::Watch>::print_utf8+0x4bc>
  262851:	lock incq (%r12)
  262856:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  26285c:	mov    (%rbx),%rax
  26285f:	test   %rax,%rax
  262862:	je     262830 <<glass::engine::Watch>::print_utf8+0x490>
  262864:	lock decq (%rax)
  262868:	jne    262830 <<glass::engine::Watch>::print_utf8+0x490>
  26286a:	mov    %rbx,%rdi
  26286d:	mov    %edx,%r15d
  262870:	call   *0x38f412(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  262876:	mov    %r15d,%edx
  262879:	mov    0x70(%rsp),%edi
  26287d:	jmp    262830 <<glass::engine::Watch>::print_utf8+0x490>
  26287f:	mov    0xb0(%rsp),%r11
  262887:	mov    0x78(%rsp),%rax
  26288c:	cmp    %eax,0x38(%r11)
  262890:	jbe    262896 <<glass::engine::Watch>::print_utf8+0x4f6>
  262892:	mov    %eax,0x38(%r11)
  262896:	test   %r12,%r12
  262899:	mov    0x98(%rsp),%r8
  2628a1:	mov    0xd0(%rsp),%r14
  2628a9:	mov    0x88(%rsp),%r9
  2628b1:	mov    0x38(%rsp),%r10
  2628b6:	mov    0x50(%rsp),%ebp
  2628ba:	mov    0x90(%rsp),%r13
  2628c2:	je     2628f1 <<glass::engine::Watch>::print_utf8+0x551>
  2628c4:	lock decq (%r12)
  2628c9:	jne    2628f1 <<glass::engine::Watch>::print_utf8+0x551>
  2628cb:	lea    0x58(%rsp),%rdi
  2628d0:	mov    %r8,%rbx
  2628d3:	call   *0x38f3af(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  2628d9:	mov    %rbx,%r8
  2628dc:	mov    0xb0(%rsp),%r11
  2628e4:	mov    0x38(%rsp),%r10
  2628e9:	mov    0x88(%rsp),%r9
  2628f1:	mov    0x10(%r11),%rcx
  2628f5:	mov    0x28(%rsp),%r12
  2628fa:	lea    0x30(%r11),%rbx
  2628fe:	cmp    %rcx,%r13
  262901:	jb     262954 <<glass::engine::Watch>::print_utf8+0x5b4>
  262903:	cmpl   $0xffffffff,0x28(%r11)
  262908:	je     26294c <<glass::engine::Watch>::print_utf8+0x5ac>
  26290a:	lea    0x18(%r11),%rdi
  26290e:	mov    (%rdi),%rax
  262911:	test   %rax,%rax
  262914:	je     26294c <<glass::engine::Watch>::print_utf8+0x5ac>
  262916:	lock decq (%rax)
  26291a:	jne    26294c <<glass::engine::Watch>::print_utf8+0x5ac>
  26291c:	mov    %r9,%r13
  26291f:	mov    %r10,0x38(%rsp)
  262924:	mov    %r11,%r15
  262927:	mov    %ebp,0x50(%rsp)
  26292b:	mov    %rbx,%rbp
  26292e:	mov    %r8,%rbx
  262931:	call   *0x38f351(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  262937:	mov    %rbx,%r8
  26293a:	mov    %rbp,%rbx
  26293d:	mov    0x50(%rsp),%ebp
  262941:	mov    %r15,%r11
  262944:	mov    0x38(%rsp),%r10
  262949:	mov    %r13,%r9
  26294c:	movl   $0xffffffff,0x28(%r11)
  262954:	mov    0x10(%r11),%rdx
  262958:	mov    0x30(%r11),%rax
  26295c:	cmp    %r10,%rdx
  26295f:	mov    %r10,%rsi
  262962:	cmovb  %rdx,%rsi
  262966:	cmp    %rax,%rsi
  262969:	cmova  %rsi,%rax
  26296d:	mov    %rdx,%rcx
  262970:	mov    %rax,0x30(%r11)
  262974:	sub    %r10,%rcx
  262977:	mov    %rcx,0x70(%rsp)
  26297c:	jb     2641bd <<glass::engine::Watch>::print_utf8+0x1e1d>
  262982:	mov    $0xffffffff,%r13d
  262988:	cmp    %r8,%r12
  26298b:	jae    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  262991:	mov    0x8(%r11),%rax
  262995:	mov    %rax,0x78(%rsp)
  26299a:	mov    0x20(%rsp),%rax
  26299f:	movzbl (%rax,%r12,1),%esi
  2629a4:	test   %sil,%sil
  2629a7:	mov    0x8(%rsp),%rdx
  2629ac:	js     2629d7 <<glass::engine::Watch>::print_utf8+0x637>
  2629ae:	mov    %ebp,0x50(%rsp)
  2629b2:	mov    $0x1,%ebp
  2629b7:	cmp    $0xffffffff,%esi
  2629ba:	sete   %al
  2629bd:	lea    -0x7f(%rsi),%ecx
  2629c0:	cmp    $0x21,%ecx
  2629c3:	setb   %cl
  2629c6:	or     %al,%cl
  2629c8:	je     262a46 <<glass::engine::Watch>::print_utf8+0x6a6>
  2629ca:	xor    %r11d,%r11d
  2629cd:	mov    %esi,%r13d
  2629d0:	xor    %ecx,%ecx
  2629d2:	jmp    26343d <<glass::engine::Watch>::print_utf8+0x109d>
  2629d7:	lea    0x3e(%rsi),%eax
  2629da:	cmp    $0x1e,%al
  2629dc:	jae    263082 <<glass::engine::Watch>::print_utf8+0xce2>
  2629e2:	lea    0x1(%r12),%rax
  2629e7:	cmp    %r8,%rax
  2629ea:	jae    2631ec <<glass::engine::Watch>::print_utf8+0xe4c>
  2629f0:	mov    0x20(%rsp),%rcx
  2629f5:	movzbl (%rcx,%rax,1),%eax
  2629f9:	cmp    $0xc0,%al
  2629fb:	jge    2631ec <<glass::engine::Watch>::print_utf8+0xe4c>
  262a01:	mov    %ebp,0x50(%rsp)
  262a05:	and    $0x1f,%esi
  262a08:	shl    $0x6,%esi
  262a0b:	mov    $0x2,%ecx
  262a10:	mov    %esi,%edx
  262a12:	and    $0x3f,%al
  262a14:	movzbl %al,%esi
  262a17:	or     %edx,%esi
  262a19:	xor    $0xd800,%edx
  262a1f:	add    $0xffef0000,%edx
  262a25:	cmp    $0xffef0800,%edx
  262a2b:	mov    $0x0,%ebp
  262a30:	cmovae %rcx,%rbp
  262a34:	mov    $0xffffffff,%eax
  262a39:	cmovb  %eax,%esi
  262a3c:	mov    0x8(%rsp),%rdx
  262a41:	jmp    2629b7 <<glass::engine::Watch>::print_utf8+0x617>
  262a46:	mov    %rbx,0x108(%rsp)
  262a4e:	mov    %r11,0xb0(%rsp)
  262a56:	mov    %r9,0x88(%rsp)
  262a5e:	mov    %r12,0x28(%rsp)
  262a63:	lea    (%r10,%r10,2),%rax
  262a67:	mov    0x78(%rsp),%r9
  262a6c:	lea    (%r9,%rax,8),%rax
  262a70:	mov    %rax,0xc8(%rsp)
  262a78:	mov    0x80(%rsp),%eax
  262a7f:	mov    %eax,%ecx
  262a81:	or     $0x20,%ecx
  262a84:	mov    %ecx,0xa8(%rsp)
  262a8b:	or     $0x40,%eax
  262a8e:	mov    %eax,0xec(%rsp)
  262a95:	mov    $0x1,%al
  262a97:	mov    %eax,0xb8(%rsp)
  262a9e:	movq   $0x0,0x8(%rsp)
  262aa7:	xor    %r11d,%r11d
  262aaa:	mov    %r10,%r15
  262aad:	mov    %r10,0x38(%rsp)
  262ab2:	mov    0x40(%rsp),%rdi
  262ab7:	jmp    262af4 <<glass::engine::Watch>::print_utf8+0x754>
  262ab9:	nopl   0x0(%rax)
  262ac0:	mov    $0x1,%ebx
  262ac5:	cmp    $0xffffffff,%r13d
  262ac9:	je     263200 <<glass::engine::Watch>::print_utf8+0xe60>
  262acf:	lea    -0x7f(%r13),%eax
  262ad3:	mov    %r14,0x10(%rsp)
  262ad8:	mov    %esi,%r12d
  262adb:	mov    %rbp,0x28(%rsp)
  262ae0:	mov    %esi,%edx
  262ae2:	mov    %rcx,%r15
  262ae5:	mov    %rbx,%rbp
  262ae8:	mov    %r13d,%esi
  262aeb:	cmp    $0x21,%eax
  262aee:	jb     2632f1 <<glass::engine::Watch>::print_utf8+0xf51>
  262af4:	cmp    $0xffffffff,%edx
  262af7:	je     262b20 <<glass::engine::Watch>::print_utf8+0x780>
  262af9:	lea    -0x20(%rdx),%eax
  262afc:	cmp    $0x5f,%eax
  262aff:	jae    262b40 <<glass::engine::Watch>::print_utf8+0x7a0>
  262b01:	mov    $0x1,%ecx
  262b06:	cmpb   $0x0,0x1c(%rsp)
  262b0b:	jne    262c1d <<glass::engine::Watch>::print_utf8+0x87d>
  262b11:	jmp    2632e5 <<glass::engine::Watch>::print_utf8+0xf45>
  262b16:	cs nopw 0x0(%rax,%rax,1)
  262b20:	mov    %r15,%rcx
  262b23:	mov    0x28(%rsp),%r14
  262b28:	add    %r14,%rbp
  262b2b:	cmp    %r8,%rbp
  262b2e:	jb     262e53 <<glass::engine::Watch>::print_utf8+0xab3>
  262b34:	jmp    2631f8 <<glass::engine::Watch>::print_utf8+0xe58>
  262b39:	nopl   0x0(%rax)
  262b40:	mov    %rsi,%r13
  262b43:	mov    0x3920af(%rip),%eax        # 5f4bf8 <glass::engine::width_of::CACHE+0x10>
  262b49:	test   %eax,%eax
  262b4b:	jne    26303a <<glass::engine::Watch>::print_utf8+0xc9a>
  262b51:	mov    %edx,%ebx
  262b53:	mov    0x392096(%rip),%rsi        # 5f4bf0 <glass::engine::width_of::CACHE+0x8>
  262b5a:	cmp    %rbx,%rsi
  262b5d:	jbe    2647e5 <<glass::engine::Watch>::print_utf8+0x2445>
  262b63:	mov    0x39207e(%rip),%r12        # 5f4be8 <glass::engine::width_of::CACHE>
  262b6a:	movzbl (%r12,%rbx,1),%eax
  262b6f:	movzbl %al,%ecx
  262b72:	test   %cl,%cl
  262b74:	js     262b8b <<glass::engine::Watch>::print_utf8+0x7eb>
  262b76:	mov    %rdx,%r14
  262b79:	mov    $0x1,%dl
  262b7b:	mov    %r13,%rsi
  262b7e:	test   %dl,%dl
  262b80:	jne    262c0c <<glass::engine::Watch>::print_utf8+0x86c>
  262b86:	jmp    263788 <<glass::engine::Watch>::print_utf8+0x13e8>
  262b8b:	cmp    $0xfe,%ecx
  262b91:	mov    %r13,%rsi
  262b94:	je     2632e5 <<glass::engine::Watch>::print_utf8+0xf45>
  262b9a:	mov    $0xfe,%al
  262b9c:	cmp    $0x7f,%edx
  262b9f:	jae    262bad <<glass::engine::Watch>::print_utf8+0x80d>
  262ba1:	mov    %rdx,%r14
  262ba4:	mov    $0x1,%ecx
  262ba9:	xor    %edx,%edx
  262bab:	jmp    262c00 <<glass::engine::Watch>::print_utf8+0x860>
  262bad:	cmp    $0xa0,%edx
  262bb3:	jb     262bfb <<glass::engine::Watch>::print_utf8+0x85b>
  262bb5:	mov    %rdx,%r14
  262bb8:	mov    %edx,%edi
  262bba:	mov    %r11,0xe0(%rsp)
  262bc2:	mov    %r10,0xc0(%rsp)
  262bca:	call   298c70 <unicode_width::tables::lookup_width>
  262bcf:	mov    0x78(%rsp),%r9
  262bd4:	mov    0xc0(%rsp),%r10
  262bdc:	mov    %r13,%rsi
  262bdf:	mov    0xe0(%rsp),%r11
  262be7:	mov    0x40(%rsp),%rdi
  262bec:	mov    0x98(%rsp),%r8
  262bf4:	movzbl %al,%ecx
  262bf7:	mov    $0x1,%dl
  262bf9:	jmp    262c00 <<glass::engine::Watch>::print_utf8+0x860>
  262bfb:	mov    %rdx,%r14
  262bfe:	xor    %edx,%edx
  262c00:	mov    %al,(%r12,%rbx,1)
  262c04:	test   %dl,%dl
  262c06:	je     263788 <<glass::engine::Watch>::print_utf8+0x13e8>
  262c0c:	lea    -0x1(%rcx),%rax
  262c10:	cmp    $0x1,%rax
  262c14:	mov    %r14,%rdx
  262c17:	ja     2632e5 <<glass::engine::Watch>::print_utf8+0xf45>
  262c1d:	testb  $0x1,0x8(%rsp)
  262c22:	jne    2632de <<glass::engine::Watch>::print_utf8+0xf3e>
  262c28:	mov    %rbp,0x90(%rsp)
  262c30:	lea    (%rcx,%r10,1),%rax
  262c34:	cmp    %rdi,%rax
  262c37:	ja     2632ae <<glass::engine::Watch>::print_utf8+0xf0e>
  262c3d:	mov    %rax,%rbp
  262c40:	mov    %r10,%rbx
  262c43:	sub    0x38(%rsp),%rbx
  262c48:	cmp    0x48(%rsp),%r10
  262c4d:	jae    262cb0 <<glass::engine::Watch>::print_utf8+0x910>
  262c4f:	cmp    0x70(%rsp),%rbx
  262c54:	jae    264836 <<glass::engine::Watch>::print_utf8+0x2496>
  262c5a:	lea    (%r10,%r10,2),%rax
  262c5e:	testb  $0x60,0x14(%r9,%rax,8)
  262c64:	jne    2632ae <<glass::engine::Watch>::print_utf8+0xf0e>
  262c6a:	lea    (%r9,%rax,8),%r12
  262c6e:	cmp    $0x2,%rcx
  262c72:	jne    262d34 <<glass::engine::Watch>::print_utf8+0x994>
  262c78:	lea    0x1(%rbx),%rax
  262c7c:	cmp    0x70(%rsp),%rax
  262c81:	jae    264875 <<glass::engine::Watch>::print_utf8+0x24d5>
  262c87:	lea    (%rax,%rax,2),%rax
  262c8b:	mov    $0x1,%r13b
  262c8e:	mov    0xc8(%rsp),%rcx
  262c96:	testb  $0x60,0x14(%rcx,%rax,8)
  262c9b:	mov    0xa8(%rsp),%r14d
  262ca3:	je     262cdc <<glass::engine::Watch>::print_utf8+0x93c>
  262ca5:	jmp    2637ae <<glass::engine::Watch>::print_utf8+0x140e>
  262caa:	nopw   0x0(%rax,%rax,1)
  262cb0:	cmp    0x70(%rsp),%rbx
  262cb5:	jae    264887 <<glass::engine::Watch>::print_utf8+0x24e7>
  262cbb:	lea    (%r10,%r10,2),%rax
  262cbf:	lea    (%r9,%rax,8),%r12
  262cc3:	cmp    $0x2,%rcx
  262cc7:	sete   %r13b
  262ccb:	mov    0x80(%rsp),%r14d
  262cd3:	cmove  0xa8(%rsp),%r14d
  262cdc:	mov    (%r12),%rax
  262ce0:	test   %rax,%rax
  262ce3:	je     262d50 <<glass::engine::Watch>::print_utf8+0x9b0>
  262ce5:	lock decq (%rax)
  262ce9:	jne    262d50 <<glass::engine::Watch>::print_utf8+0x9b0>
  262ceb:	mov    %r12,%rdi
  262cee:	mov    %rdx,0x8(%rsp)
  262cf3:	mov    %r11,0xe0(%rsp)
  262cfb:	mov    %rsi,0x10(%rsp)
  262d00:	mov    %r10,0xc0(%rsp)
  262d08:	call   *0x38ef7a(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  262d0e:	mov    0x78(%rsp),%r9
  262d13:	mov    0xc0(%rsp),%r10
  262d1b:	mov    0x10(%rsp),%rsi
  262d20:	mov    0xe0(%rsp),%r11
  262d28:	mov    0x40(%rsp),%rdi
  262d2d:	mov    0x8(%rsp),%rdx
  262d32:	jmp    262d50 <<glass::engine::Watch>::print_utf8+0x9b0>
  262d34:	xor    %r13d,%r13d
  262d37:	mov    0x80(%rsp),%r14d
  262d3f:	mov    (%r12),%rax
  262d43:	test   %rax,%rax
  262d46:	jne    262ce5 <<glass::engine::Watch>::print_utf8+0x945>
  262d48:	nopl   0x0(%rax,%rax,1)
  262d50:	lea    (%r10,%r10,2),%rax
  262d54:	movq   $0x0,(%r12)
  262d5c:	mov    0x50(%rsp),%ecx
  262d60:	mov    %ecx,0x8(%r9,%rax,8)
  262d65:	mov    0xa0(%rsp),%ecx
  262d6c:	mov    %ecx,0xc(%r9,%rax,8)
  262d71:	mov    %r14w,0x14(%r9,%rax,8)
  262d77:	mov    %edx,0x10(%r9,%rax,8)
  262d7c:	test   %r13b,%r13b
  262d7f:	mov    0x98(%rsp),%r8
  262d87:	mov    0x28(%rsp),%r14
  262d8c:	mov    %rbp,%rcx
  262d8f:	je     262e29 <<glass::engine::Watch>::print_utf8+0xa89>
  262d95:	inc    %rbx
  262d98:	cmp    0x70(%rsp),%rbx
  262d9d:	jae    26483f <<glass::engine::Watch>::print_utf8+0x249f>
  262da3:	lea    (%rbx,%rbx,2),%rax
  262da7:	mov    0xc8(%rsp),%rdx
  262daf:	lea    (%rdx,%rax,8),%rbx
  262db3:	mov    (%rdx,%rax,8),%rax
  262db7:	test   %rax,%rax
  262dba:	je     262df4 <<glass::engine::Watch>::print_utf8+0xa54>
  262dbc:	lock decq (%rax)
  262dc0:	jne    262df4 <<glass::engine::Watch>::print_utf8+0xa54>
  262dc2:	mov    %rbx,%rdi
  262dc5:	mov    %r14,0x28(%rsp)
  262dca:	mov    %r8,%r14
  262dcd:	mov    %r11,%r12
  262dd0:	mov    %rsi,%r13
  262dd3:	call   *0x38eeaf(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  262dd9:	mov    %rbp,%rcx
  262ddc:	mov    0x78(%rsp),%r9
  262de1:	mov    %r13,%rsi
  262de4:	mov    %r12,%r11
  262de7:	mov    0x40(%rsp),%rdi
  262dec:	mov    %r14,%r8
  262def:	mov    0x28(%rsp),%r14
  262df4:	movq   $0x0,(%rbx)
  262dfb:	mov    0x50(%rsp),%eax
  262dff:	mov    %eax,0x8(%rbx)
  262e02:	mov    0xa0(%rsp),%eax
  262e09:	mov    %eax,0xc(%rbx)
  262e0c:	movl   $0x20,0x10(%rbx)
  262e13:	mov    0xec(%rsp),%eax
  262e1a:	mov    %ax,0x14(%rbx)
  262e1e:	movl   $0x0,0xb8(%rsp)
  262e29:	xor    %eax,%eax
  262e2b:	cmp    %rdi,%rcx
  262e2e:	setae  %al
  262e31:	mov    %rcx,%r10
  262e34:	mov    %rax,0x8(%rsp)
  262e39:	sub    %rax,%r10
  262e3c:	inc    %r11
  262e3f:	mov    0x90(%rsp),%rbp
  262e47:	add    %r14,%rbp
  262e4a:	cmp    %r8,%rbp
  262e4d:	jae    2631f8 <<glass::engine::Watch>::print_utf8+0xe58>
  262e53:	mov    0x20(%rsp),%rax
  262e58:	movzbl (%rax,%rbp,1),%r13d
  262e5d:	test   %r13b,%r13b
  262e60:	jns    262ac0 <<glass::engine::Watch>::print_utf8+0x720>
  262e66:	lea    0x3e(%r13),%eax
  262e6a:	cmp    $0x1e,%al
  262e6c:	jae    262ea4 <<glass::engine::Watch>::print_utf8+0xb04>
  262e6e:	lea    0x1(%rbp),%rax
  262e72:	cmp    %r8,%rax
  262e75:	jae    2631f8 <<glass::engine::Watch>::print_utf8+0xe58>
  262e7b:	mov    %rcx,%r15
  262e7e:	mov    0x20(%rsp),%rcx
  262e83:	movzbl (%rcx,%rax,1),%eax
  262e87:	cmp    $0xc0,%al
  262e89:	jge    2632c4 <<glass::engine::Watch>::print_utf8+0xf24>
  262e8f:	and    $0x1f,%r13d
  262e93:	shl    $0x6,%r13d
  262e97:	mov    $0x2,%ecx
  262e9c:	mov    %r13d,%edx
  262e9f:	jmp    262ffb <<glass::engine::Watch>::print_utf8+0xc5b>
  262ea4:	mov    %r13d,%eax
  262ea7:	and    $0xf0,%al
  262ea9:	cmp    $0xe0,%al
  262eab:	jne    262eca <<glass::engine::Watch>::print_utf8+0xb2a>
  262ead:	mov    %rcx,%r15
  262eb0:	mov    $0xbf,%al
  262eb2:	cmp    $0xe0,%r13d
  262eb9:	je     262ef3 <<glass::engine::Watch>::print_utf8+0xb53>
  262ebb:	mov    $0x80,%cl
  262ebd:	cmp    $0xed,%r13d
  262ec4:	jne    262ef5 <<glass::engine::Watch>::print_utf8+0xb55>
  262ec6:	mov    $0x9f,%al
  262ec8:	jmp    262ef5 <<glass::engine::Watch>::print_utf8+0xb55>
  262eca:	lea    0x10(%r13),%eax
  262ece:	cmp    $0x5,%al
  262ed0:	jae    2631f8 <<glass::engine::Watch>::print_utf8+0xe58>
  262ed6:	mov    %rcx,%r15
  262ed9:	mov    $0x80,%al
  262edb:	cmp    $0xf4,%r13d
  262ee2:	je     262f63 <<glass::engine::Watch>::print_utf8+0xbc3>
  262ee4:	mov    $0xbf,%cl
  262ee6:	cmp    $0xf0,%r13d
  262eed:	jne    262f65 <<glass::engine::Watch>::print_utf8+0xbc5>
  262eef:	mov    $0x90,%al
  262ef1:	jmp    262f65 <<glass::engine::Watch>::print_utf8+0xbc5>
  262ef3:	mov    $0xa0,%cl
  262ef5:	lea    0x1(%rbp),%rdx
  262ef9:	cmp    %r8,%rdx
  262efc:	jae    2632c4 <<glass::engine::Watch>::print_utf8+0xf24>
  262f02:	mov    %rsi,%r9
  262f05:	mov    0x20(%rsp),%rsi
  262f0a:	movzbl (%rsi,%rdx,1),%edx
  262f0e:	cmp    %dl,%cl
  262f10:	ja     263799 <<glass::engine::Watch>::print_utf8+0x13f9>
  262f16:	cmp    %al,%dl
  262f18:	mov    %r9,%rsi
  262f1b:	mov    %r15,%rcx
  262f1e:	ja     2631f8 <<glass::engine::Watch>::print_utf8+0xe58>
  262f24:	lea    0x2(%rbp),%rax
  262f28:	cmp    %r8,%rax
  262f2b:	jae    2631f8 <<glass::engine::Watch>::print_utf8+0xe58>
  262f31:	mov    0x20(%rsp),%rcx
  262f36:	movzbl (%rcx,%rax,1),%eax
  262f3a:	cmp    $0xc0,%al
  262f3c:	jge    2632c4 <<glass::engine::Watch>::print_utf8+0xf24>
  262f42:	movzbl %dl,%ecx
  262f45:	and    $0x3f,%ecx
  262f48:	shl    $0x6,%ecx
  262f4b:	and    $0xf,%r13d
  262f4f:	shl    $0xc,%r13d
  262f53:	or     %ecx,%r13d
  262f56:	mov    $0x3,%ecx
  262f5b:	mov    %r13d,%edx
  262f5e:	jmp    262ff6 <<glass::engine::Watch>::print_utf8+0xc56>
  262f63:	mov    $0x8f,%cl
  262f65:	lea    0x1(%rbp),%rdx
  262f69:	cmp    %r8,%rdx
  262f6c:	jae    2632c4 <<glass::engine::Watch>::print_utf8+0xf24>
  262f72:	mov    %rsi,%r9
  262f75:	mov    0x20(%rsp),%rsi
  262f7a:	movzbl (%rsi,%rdx,1),%edx
  262f7e:	cmp    %dl,%al
  262f80:	ja     263799 <<glass::engine::Watch>::print_utf8+0x13f9>
  262f86:	cmp    %cl,%dl
  262f88:	mov    %r9,%rsi
  262f8b:	ja     2632c4 <<glass::engine::Watch>::print_utf8+0xf24>
  262f91:	lea    0x2(%rbp),%rax
  262f95:	cmp    %r8,%rax
  262f98:	jae    2632c4 <<glass::engine::Watch>::print_utf8+0xf24>
  262f9e:	mov    0x20(%rsp),%rcx
  262fa3:	movzbl (%rcx,%rax,1),%ecx
  262fa7:	cmp    $0xbf,%cl
  262faa:	jg     2632c4 <<glass::engine::Watch>::print_utf8+0xf24>
  262fb0:	lea    0x3(%rbp),%rax
  262fb4:	cmp    %r8,%rax
  262fb7:	jae    2632c4 <<glass::engine::Watch>::print_utf8+0xf24>
  262fbd:	mov    0x20(%rsp),%rsi
  262fc2:	movzbl (%rsi,%rax,1),%eax
  262fc6:	cmp    $0xbf,%al
  262fc8:	jg     263799 <<glass::engine::Watch>::print_utf8+0x13f9>
  262fce:	movzbl %dl,%edx
  262fd1:	and    $0x3f,%ecx
  262fd4:	shl    $0x6,%ecx
  262fd7:	and    $0x3f,%edx
  262fda:	shl    $0xc,%edx
  262fdd:	and    $0x7,%r13d
  262fe1:	shl    $0x12,%r13d
  262fe5:	or     %edx,%r13d
  262fe8:	or     %ecx,%r13d
  262feb:	mov    $0x4,%ecx
  262ff0:	mov    %r13d,%edx
  262ff3:	mov    %r9,%rsi
  262ff6:	mov    0x78(%rsp),%r9
  262ffb:	and    $0x3f,%al
  262ffd:	movzbl %al,%r13d
  263001:	or     %edx,%r13d
  263004:	xor    $0xd800,%edx
  26300a:	add    $0xffef0000,%edx
  263010:	cmp    $0xffef0800,%edx
  263016:	mov    $0x0,%ebx
  26301b:	cmovae %rcx,%rbx
  26301f:	mov    $0xffffffff,%eax
  263024:	cmovb  %eax,%r13d
  263028:	mov    %r15,%rcx
  26302b:	cmp    $0xffffffff,%r13d
  26302f:	jne    262acf <<glass::engine::Watch>::print_utf8+0x72f>
  263035:	jmp    263200 <<glass::engine::Watch>::print_utf8+0xe60>
  26303a:	mov    %rdx,%rbx
  26303d:	mov    %r8,%r14
  263040:	mov    %r11,%r12
  263043:	mov    %r10,0xc0(%rsp)
  26304b:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263050:	mov    0x78(%rsp),%r9
  263055:	mov    0xc0(%rsp),%r10
  26305d:	mov    %r12,%r11
  263060:	mov    0x40(%rsp),%rdi
  263065:	mov    %r14,%r8
  263068:	mov    %rbx,%rdx
  26306b:	mov    %edx,%ebx
  26306d:	mov    0x391b7c(%rip),%rsi        # 5f4bf0 <glass::engine::width_of::CACHE+0x8>
  263074:	cmp    %rbx,%rsi
  263077:	ja     262b63 <<glass::engine::Watch>::print_utf8+0x7c3>
  26307d:	jmp    2647e5 <<glass::engine::Watch>::print_utf8+0x2445>
  263082:	mov    %esi,%eax
  263084:	and    $0xf0,%al
  263086:	cmp    $0xe0,%al
  263088:	jne    2631b8 <<glass::engine::Watch>::print_utf8+0xe18>
  26308e:	mov    $0xbf,%al
  263090:	cmp    $0xe0,%esi
  263096:	je     263350 <<glass::engine::Watch>::print_utf8+0xfb0>
  26309c:	mov    $0x80,%dl
  26309e:	cmp    $0xed,%esi
  2630a4:	jne    2630a8 <<glass::engine::Watch>::print_utf8+0xd08>
  2630a6:	mov    $0x9f,%al
  2630a8:	lea    0x1(%r12),%rcx
  2630ad:	cmp    %r8,%rcx
  2630b0:	jae    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  2630b6:	jmp    263360 <<glass::engine::Watch>::print_utf8+0xfc0>
  2630bb:	lea    0x10(%r13),%eax
  2630bf:	cmp    $0x5,%al
  2630c1:	jae    263e89 <<glass::engine::Watch>::print_utf8+0x1ae9>
  2630c7:	mov    $0x80,%al
  2630c9:	cmp    $0xf4,%r13d
  2630d0:	jne    26273d <<glass::engine::Watch>::print_utf8+0x39d>
  2630d6:	mov    %rdx,%rdi
  2630d9:	mov    $0x8f,%cl
  2630db:	lea    0x1(%r12),%rdx
  2630e0:	cmp    %r8,%rdx
  2630e3:	jae    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  2630e9:	mov    0x20(%rsp),%rsi
  2630ee:	movzbl (%rsi,%rdx,1),%edx
  2630f2:	cmp    %dl,%al
  2630f4:	ja     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  2630fa:	cmp    %cl,%dl
  2630fc:	ja     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263102:	lea    0x2(%r12),%rax
  263107:	cmp    %r8,%rax
  26310a:	jae    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263110:	mov    0x20(%rsp),%rcx
  263115:	movzbl (%rcx,%rax,1),%ecx
  263119:	cmp    $0xbf,%cl
  26311c:	jg     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263122:	lea    0x3(%r12),%rax
  263127:	cmp    %r8,%rax
  26312a:	jae    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263130:	mov    0x20(%rsp),%rsi
  263135:	movzbl (%rsi,%rax,1),%eax
  263139:	cmp    $0xbf,%al
  26313b:	jg     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263141:	movzbl %dl,%edx
  263144:	and    $0x3f,%ecx
  263147:	shl    $0x6,%ecx
  26314a:	and    $0x3f,%edx
  26314d:	shl    $0xc,%edx
  263150:	and    $0x7,%r13d
  263154:	shl    $0x12,%r13d
  263158:	or     %edx,%r13d
  26315b:	or     %ecx,%r13d
  26315e:	mov    $0x4,%ecx
  263163:	jmp    263276 <<glass::engine::Watch>::print_utf8+0xed6>
  263168:	mov    %rdx,%rdi
  26316b:	mov    $0xa0,%cl
  26316d:	lea    0x1(%r12),%rdx
  263172:	cmp    %r8,%rdx
  263175:	jae    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  26317b:	mov    0x20(%rsp),%rsi
  263180:	movzbl (%rsi,%rdx,1),%edx
  263184:	cmp    %dl,%cl
  263186:	ja     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  26318c:	cmp    %al,%dl
  26318e:	ja     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263194:	lea    0x2(%r12),%rax
  263199:	cmp    %r8,%rax
  26319c:	jae    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  2631a2:	mov    0x20(%rsp),%rcx
  2631a7:	movzbl (%rcx,%rax,1),%eax
  2631ab:	cmp    $0xc0,%al
  2631ad:	jl     26325d <<glass::engine::Watch>::print_utf8+0xebd>
  2631b3:	jmp    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  2631b8:	lea    0x10(%rsi),%eax
  2631bb:	cmp    $0x5,%al
  2631bd:	jae    2631ec <<glass::engine::Watch>::print_utf8+0xe4c>
  2631bf:	mov    $0x80,%al
  2631c1:	cmp    $0xf4,%esi
  2631c7:	je     2633bb <<glass::engine::Watch>::print_utf8+0x101b>
  2631cd:	mov    $0xbf,%dl
  2631cf:	cmp    $0xf0,%esi
  2631d5:	jne    2631d9 <<glass::engine::Watch>::print_utf8+0xe39>
  2631d7:	mov    $0x90,%al
  2631d9:	lea    0x1(%r12),%rcx
  2631de:	cmp    %r8,%rcx
  2631e1:	jb     2633c7 <<glass::engine::Watch>::print_utf8+0x1027>
  2631e7:	jmp    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  2631ec:	xor    %ebp,%ebp
  2631ee:	xor    %r11d,%r11d
  2631f1:	xor    %ecx,%ecx
  2631f3:	jmp    26343d <<glass::engine::Watch>::print_utf8+0x109d>
  2631f8:	mov    $0xffffffff,%r13d
  2631fe:	xor    %ebx,%ebx
  263200:	mov    %r14,0x10(%rsp)
  263205:	mov    %esi,%r12d
  263208:	mov    %rbp,0x28(%rsp)
  26320d:	jmp    2632f1 <<glass::engine::Watch>::print_utf8+0xf51>
  263212:	mov    %rdx,%rdi
  263215:	mov    $0xa0,%cl
  263217:	lea    0x1(%r12),%rdx
  26321c:	cmp    %r8,%rdx
  26321f:	jae    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263225:	mov    0x20(%rsp),%rsi
  26322a:	movzbl (%rsi,%rdx,1),%edx
  26322e:	cmp    %dl,%cl
  263230:	ja     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263236:	cmp    %al,%dl
  263238:	ja     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  26323e:	lea    0x2(%r12),%rax
  263243:	cmp    %r8,%rax
  263246:	jae    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  26324c:	mov    0x20(%rsp),%rcx
  263251:	movzbl (%rcx,%rax,1),%eax
  263255:	cmp    $0xc0,%al
  263257:	jge    263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  26325d:	movzbl %dl,%ecx
  263260:	and    $0x3f,%ecx
  263263:	shl    $0x6,%ecx
  263266:	and    $0xf,%r13d
  26326a:	shl    $0xc,%r13d
  26326e:	or     %ecx,%r13d
  263271:	mov    $0x3,%ecx
  263276:	mov    %r13d,%edx
  263279:	and    $0x3f,%al
  26327b:	movzbl %al,%r13d
  26327f:	or     %edx,%r13d
  263282:	xor    $0xd800,%edx
  263288:	add    $0xffef0000,%edx
  26328e:	cmp    $0xffef0800,%edx
  263294:	mov    $0x0,%ebp
  263299:	cmovae %rcx,%rbp
  26329d:	mov    $0xffffffff,%eax
  2632a2:	cmovb  %eax,%r13d
  2632a6:	mov    %rdi,%rdx
  2632a9:	jmp    26344c <<glass::engine::Watch>::print_utf8+0x10ac>
  2632ae:	movq   $0x0,0x8(%rsp)
  2632b7:	mov    %esi,%r13d
  2632ba:	mov    0x90(%rsp),%rbx
  2632c2:	jmp    2632eb <<glass::engine::Watch>::print_utf8+0xf4b>
  2632c4:	mov    $0xffffffff,%r13d
  2632ca:	xor    %ebx,%ebx
  2632cc:	mov    %r14,0x10(%rsp)
  2632d1:	mov    %esi,%r12d
  2632d4:	mov    %rbp,0x28(%rsp)
  2632d9:	mov    %r15,%rcx
  2632dc:	jmp    2632f1 <<glass::engine::Watch>::print_utf8+0xf51>
  2632de:	mov    $0x1,%al
  2632e0:	mov    %rax,0x8(%rsp)
  2632e5:	mov    %esi,%r13d
  2632e8:	mov    %rbp,%rbx
  2632eb:	mov    %r15,%rcx
  2632ee:	mov    %edx,%r12d
  2632f1:	cmp    0x38(%rsp),%rcx
  2632f6:	jbe    263310 <<glass::engine::Watch>::print_utf8+0xf70>
  2632f8:	mov    %rcx,%rdx
  2632fb:	mov    0x108(%rsp),%rcx
  263303:	mov    (%rcx),%rax
  263306:	cmp    %rax,%rdx
  263309:	cmova  %rdx,%rax
  26330d:	mov    %rax,(%rcx)
  263310:	cmp    $0x8,%r11
  263314:	setae  %al
  263317:	testb  $0x1,0xb8(%rsp)
  26331f:	mov    0xd0(%rsp),%r14
  263327:	mov    0x8(%rsp),%rcx
  26332c:	jne    263330 <<glass::engine::Watch>::print_utf8+0xf90>
  26332e:	xor    %eax,%eax
  263330:	test   %al,%al
  263332:	jne    263e3d <<glass::engine::Watch>::print_utf8+0x1a9d>
  263338:	mov    %rbx,%rbp
  26333b:	mov    %r12d,%edx
  26333e:	mov    0x28(%rsp),%r12
  263343:	mov    0x88(%rsp),%r9
  26334b:	jmp    26343d <<glass::engine::Watch>::print_utf8+0x109d>
  263350:	mov    $0xa0,%dl
  263352:	lea    0x1(%r12),%rcx
  263357:	cmp    %r8,%rcx
  26335a:	jae    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  263360:	mov    %rsi,%rdi
  263363:	mov    0x20(%rsp),%rsi
  263368:	movzbl (%rsi,%rcx,1),%ecx
  26336c:	cmp    %cl,%dl
  26336e:	seta   %dl
  263371:	cmp    %al,%cl
  263373:	seta   %al
  263376:	or     %dl,%al
  263378:	jne    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  26337e:	lea    0x2(%r12),%rax
  263383:	cmp    %r8,%rax
  263386:	jae    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  26338c:	mov    0x20(%rsp),%rdx
  263391:	movzbl (%rdx,%rax,1),%eax
  263395:	cmp    $0xc0,%al
  263397:	jge    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  26339d:	mov    %ebp,0x50(%rsp)
  2633a1:	and    $0x3f,%ecx
  2633a4:	shl    $0x6,%ecx
  2633a7:	and    $0xf,%edi
  2633aa:	shl    $0xc,%edi
  2633ad:	or     %ecx,%edi
  2633af:	mov    $0x3,%ecx
  2633b4:	mov    %edi,%edx
  2633b6:	jmp    262a12 <<glass::engine::Watch>::print_utf8+0x672>
  2633bb:	mov    $0x8f,%dl
  2633bd:	lea    0x1(%r12),%rcx
  2633c2:	cmp    %r8,%rcx
  2633c5:	jae    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  2633c7:	mov    %rsi,%rdi
  2633ca:	mov    0x20(%rsp),%rsi
  2633cf:	movzbl (%rsi,%rcx,1),%ecx
  2633d3:	cmp    %cl,%al
  2633d5:	seta   %al
  2633d8:	cmp    %dl,%cl
  2633da:	seta   %dl
  2633dd:	or     %al,%dl
  2633df:	jne    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  2633e1:	lea    0x2(%r12),%rax
  2633e6:	cmp    %r8,%rax
  2633e9:	jae    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  2633eb:	mov    0x20(%rsp),%rdx
  2633f0:	movzbl (%rdx,%rax,1),%edx
  2633f4:	cmp    $0xbf,%dl
  2633f7:	jg     263431 <<glass::engine::Watch>::print_utf8+0x1091>
  2633f9:	lea    0x3(%r12),%rax
  2633fe:	cmp    %r8,%rax
  263401:	jae    263431 <<glass::engine::Watch>::print_utf8+0x1091>
  263403:	mov    0x20(%rsp),%rsi
  263408:	movzbl (%rsi,%rax,1),%eax
  26340c:	cmp    $0xbf,%al
  26340e:	jg     263431 <<glass::engine::Watch>::print_utf8+0x1091>
  263410:	mov    %ebp,0x50(%rsp)
  263414:	and    $0x3f,%edx
  263417:	shl    $0x6,%edx
  26341a:	and    $0x3f,%ecx
  26341d:	shl    $0xc,%ecx
  263420:	and    $0x7,%edi
  263423:	shl    $0x12,%edi
  263426:	or     %ecx,%edi
  263428:	or     %edx,%edi
  26342a:	mov    $0x4,%ecx
  26342f:	jmp    2633b4 <<glass::engine::Watch>::print_utf8+0x1014>
  263431:	xor    %ebp,%ebp
  263433:	xor    %r11d,%r11d
  263436:	xor    %ecx,%ecx
  263438:	mov    0x8(%rsp),%rdx
  26343d:	mov    %r10,0x40(%r9)
  263441:	mov    %cl,0x6c(%r9)
  263445:	add    %r11,0xa0(%r14)
  26344c:	cmp    $0xffffffff,%r13d
  263450:	je     263e89 <<glass::engine::Watch>::print_utf8+0x1ae9>
  263456:	lea    -0x7f(%r13),%eax
  26345a:	cmp    $0x20,%eax
  26345d:	jbe    263e89 <<glass::engine::Watch>::print_utf8+0x1ae9>
  263463:	cmp    $0xffffffff,%edx
  263466:	je     26245d <<glass::engine::Watch>::print_utf8+0xbd>
  26346c:	mov    %r12,%r15
  26346f:	lea    -0x20(%rdx),%eax
  263472:	cmp    $0x5f,%eax
  263475:	jae    263490 <<glass::engine::Watch>::print_utf8+0x10f0>
  263477:	mov    $0x1,%r12d
  26347d:	cmpb   $0x0,0x1c(%rsp)
  263482:	je     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  263488:	jmp    2634ed <<glass::engine::Watch>::print_utf8+0x114d>
  26348a:	nopw   0x0(%rax,%rax,1)
  263490:	cmpb   $0x0,0x30(%rsp)
  263495:	je     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  26349b:	mov    0x391757(%rip),%eax        # 5f4bf8 <glass::engine::width_of::CACHE+0x10>
  2634a1:	test   %eax,%eax
  2634a3:	jne    263e1b <<glass::engine::Watch>::print_utf8+0x1a7b>
  2634a9:	mov    %edx,%ebx
  2634ab:	mov    0x39173e(%rip),%rsi        # 5f4bf0 <glass::engine::width_of::CACHE+0x8>
  2634b2:	cmp    %rbx,%rsi
  2634b5:	jbe    2647e5 <<glass::engine::Watch>::print_utf8+0x2445>
  2634bb:	mov    0x391726(%rip),%r14        # 5f4be8 <glass::engine::width_of::CACHE>
  2634c2:	movzbl (%r14,%rbx,1),%eax
  2634c7:	movzbl %al,%r12d
  2634cb:	test   %r12b,%r12b
  2634ce:	js     2636db <<glass::engine::Watch>::print_utf8+0x133b>
  2634d4:	mov    $0x1,%cl
  2634d6:	test   %cl,%cl
  2634d8:	je     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2634de:	lea    -0x1(%r12),%rax
  2634e3:	cmp    $0x1,%rax
  2634e7:	ja     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2634ed:	mov    0xd0(%rsp),%rax
  2634f5:	mov    0x78(%rax),%r14
  2634f9:	cmpb   $0x0,0x6c(%r14)
  2634fe:	jne    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  263504:	mov    0x40(%r14),%r10
  263508:	mov    0xa0(%r14),%r8
  26350f:	lea    (%r10,%r12,1),%r9
  263513:	cmp    %r8,%r9
  263516:	ja     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  26351c:	mov    0x30(%r14),%eax
  263520:	sub    0x48(%r14),%eax
  263524:	cltq
  263526:	mov    0x20(%r14),%rsi
  26352a:	mov    0x28(%r14),%rcx
  26352e:	lea    (%rcx,%rax,1),%rdi
  263532:	dec    %rdi
  263535:	cmp    %rsi,%rdi
  263538:	mov    $0x0,%eax
  26353d:	cmovae %rsi,%rax
  263541:	sub    %rax,%rdi
  263544:	cmp    %rsi,%rdi
  263547:	jae    264854 <<glass::engine::Watch>::print_utf8+0x24b4>
  26354d:	mov    0x58(%r14),%eax
  263551:	mov    %eax,0x70(%rsp)
  263555:	mov    0x5c(%r14),%eax
  263559:	mov    %eax,0x28(%rsp)
  26355d:	movzwl 0x64(%r14),%r11d
  263562:	mov    0x18(%r14),%rax
  263566:	shl    $0x6,%rdi
  26356a:	lea    (%rax,%rdi,1),%rcx
  26356e:	lea    (%rax,%rdi,1),%rbx
  263572:	add    $0x18,%rbx
  263576:	mov    0x28(%rax,%rdi,1),%eax
  26357a:	mov    %rcx,%rdi
  26357d:	cmp    $0xffffffff,%eax
  263580:	je     26358b <<glass::engine::Watch>::print_utf8+0x11eb>
  263582:	mov    %rbx,%rcx
  263585:	cmp    0x30(%rdi),%r10
  263589:	jae    2635a4 <<glass::engine::Watch>::print_utf8+0x1204>
  26358b:	mov    0x10(%rdi),%rsi
  26358f:	cmp    %rsi,%r10
  263592:	jae    26489d <<glass::engine::Watch>::print_utf8+0x24fd>
  263598:	lea    (%r10,%r10,2),%rcx
  26359c:	shl    $0x3,%rcx
  2635a0:	add    0x8(%rdi),%rcx
  2635a4:	testb  $0x60,0x14(%rcx)
  2635a8:	jne    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2635ae:	cmp    $0x2,%r12
  2635b2:	mov    %rdi,0x10(%rsp)
  2635b7:	mov    %rbx,0xa0(%rsp)
  2635bf:	jne    26360d <<glass::engine::Watch>::print_utf8+0x126d>
  2635c1:	lea    0x1(%r10),%rdi
  2635c5:	cmp    $0xffffffff,%eax
  2635c8:	je     2635d8 <<glass::engine::Watch>::print_utf8+0x1238>
  2635ca:	mov    %rbx,%rcx
  2635cd:	mov    0x10(%rsp),%rsi
  2635d2:	cmp    0x30(%rsi),%rdi
  2635d6:	jae    2635fe <<glass::engine::Watch>::print_utf8+0x125e>
  2635d8:	mov    0x10(%rsp),%rbx
  2635dd:	mov    0x10(%rbx),%rsi
  2635e1:	cmp    %rsi,%rdi
  2635e4:	jae    2648c1 <<glass::engine::Watch>::print_utf8+0x2521>
  2635ea:	lea    (%rdi,%rdi,2),%rcx
  2635ee:	shl    $0x3,%rcx
  2635f2:	add    0x8(%rbx),%rcx
  2635f6:	mov    0xa0(%rsp),%rbx
  2635fe:	testb  $0x60,0x14(%rcx)
  263602:	mov    0x10(%rsp),%rdi
  263607:	jne    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  26360d:	mov    %rdx,0x8(%rsp)
  263612:	cmp    %r10d,0x38(%rdi)
  263616:	jbe    26361c <<glass::engine::Watch>::print_utf8+0x127c>
  263618:	mov    %r10d,0x38(%rdi)
  26361c:	mov    %r8,0x50(%rsp)
  263621:	cmp    $0xffffffff,%eax
  263624:	setne  %dl
  263627:	mov    0x30(%rdi),%rcx
  26362b:	cmp    %rcx,%r10
  26362e:	sete   %sil
  263632:	test   %sil,%dl
  263635:	mov    %r10,0x38(%rsp)
  26363a:	mov    %r9,0x80(%rsp)
  263642:	mov    %r11d,0x90(%rsp)
  26364a:	jne    263747 <<glass::engine::Watch>::print_utf8+0x13a7>
  263650:	cmp    $0xffffffff,%eax
  263653:	mov    0x98(%rsp),%r8
  26365b:	je     263a09 <<glass::engine::Watch>::print_utf8+0x1669>
  263661:	mov    0x10(%rdi),%rax
  263665:	cmp    %rcx,%rax
  263668:	mov    %rcx,%rdx
  26366b:	cmovb  %rax,%rdx
  26366f:	mov    %rdx,0xc8(%rsp)
  263677:	cmp    %r10,%rax
  26367a:	mov    %r10,%rsi
  26367d:	cmovb  %rax,%rsi
  263681:	mov    0x38e6b8(%rip),%rdx        # 5f1d40 <_DYNAMIC+0x320>
  263688:	movzbl (%rdx),%edx
  26368b:	test   %dl,%dl
  26368d:	mov    %rsi,0xa8(%rsp)
  263695:	je     26380e <<glass::engine::Watch>::print_utf8+0x146e>
  26369b:	mov    0x38e6d6(%rip),%rdx        # 5f1d78 <_DYNAMIC+0x358>
  2636a2:	cmp    %rsi,%rcx
  2636a5:	jae    2636ae <<glass::engine::Watch>::print_utf8+0x130e>
  2636a7:	mov    0x38e6d2(%rip),%rdx        # 5f1d80 <_DYNAMIC+0x360>
  2636ae:	lock incq 0x28(%rdx)
  2636b3:	mov    0x38e69e(%rip),%rdx        # 5f1d58 <_DYNAMIC+0x338>
  2636ba:	lock incq (%rdx)
  2636be:	mov    0xa8(%rsp),%rdx
  2636c6:	sub    0xc8(%rsp),%rdx
  2636ce:	jne    263769 <<glass::engine::Watch>::print_utf8+0x13c9>
  2636d4:	xor    %esi,%esi
  2636d6:	jmp    2637fa <<glass::engine::Watch>::print_utf8+0x145a>
  2636db:	cmp    $0xfe,%r12d
  2636e2:	je     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2636e8:	mov    $0xfe,%al
  2636ea:	cmp    $0x7f,%edx
  2636ed:	jae    263708 <<glass::engine::Watch>::print_utf8+0x1368>
  2636ef:	mov    $0x1,%r12d
  2636f5:	xor    %ecx,%ecx
  2636f7:	mov    %al,(%r14,%rbx,1)
  2636fb:	test   %cl,%cl
  2636fd:	jne    2634de <<glass::engine::Watch>::print_utf8+0x113e>
  263703:	jmp    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  263708:	cmp    $0xa0,%edx
  26370e:	jb     263734 <<glass::engine::Watch>::print_utf8+0x1394>
  263710:	mov    %edx,%edi
  263712:	mov    %rdx,%r12
  263715:	call   298c70 <unicode_width::tables::lookup_width>
  26371a:	mov    %r12,%rdx
  26371d:	movzbl %al,%r12d
  263721:	mov    $0x1,%cl
  263723:	mov    %al,(%r14,%rbx,1)
  263727:	test   %cl,%cl
  263729:	jne    2634de <<glass::engine::Watch>::print_utf8+0x113e>
  26372f:	jmp    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  263734:	xor    %ecx,%ecx
  263736:	mov    %al,(%r14,%rbx,1)
  26373a:	test   %cl,%cl
  26373c:	jne    2634de <<glass::engine::Watch>::print_utf8+0x113e>
  263742:	jmp    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  263747:	lea    0x1(%r10),%rax
  26374b:	mov    %rax,0x30(%rdi)
  26374f:	mov    0x10(%rdi),%rsi
  263753:	cmp    %rsi,%r10
  263756:	mov    0x98(%rsp),%r8
  26375e:	jb     263a29 <<glass::engine::Watch>::print_utf8+0x1689>
  263764:	jmp    2648ce <<glass::engine::Watch>::print_utf8+0x252e>
  263769:	mov    0x38e5f0(%rip),%rsi        # 5f1d60 <_DYNAMIC+0x340>
  263770:	lock add %rdx,(%rsi)
  263774:	cmp    $0x5,%rdx
  263778:	jae    2637d5 <<glass::engine::Watch>::print_utf8+0x1435>
  26377a:	lea    -0x205c69(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263781:	movzbl -0x1(%rdx,%rsi,1),%esi
  263786:	jmp    2637fa <<glass::engine::Watch>::print_utf8+0x145a>
  263788:	mov    %esi,%r13d
  26378b:	mov    %rbp,%rbx
  26378e:	mov    %r15,%rcx
  263791:	mov    %r14d,%r12d
  263794:	jmp    2632f1 <<glass::engine::Watch>::print_utf8+0xf51>
  263799:	mov    $0xffffffff,%r13d
  26379f:	xor    %ebx,%ebx
  2637a1:	mov    %r14,0x10(%rsp)
  2637a6:	mov    %r9d,%r12d
  2637a9:	jmp    2632d4 <<glass::engine::Watch>::print_utf8+0xf34>
  2637ae:	movq   $0x0,0x8(%rsp)
  2637b7:	mov    %esi,%r13d
  2637ba:	mov    0x90(%rsp),%rbx
  2637c2:	mov    %r15,%rcx
  2637c5:	mov    %edx,%r12d
  2637c8:	mov    0x98(%rsp),%r8
  2637d0:	jmp    2632f1 <<glass::engine::Watch>::print_utf8+0xf51>
  2637d5:	lea    -0x5(%rdx),%rdi
  2637d9:	mov    $0x4,%esi
  2637de:	cmp    $0x4,%rdi
  2637e2:	mov    0x10(%rsp),%rdi
  2637e7:	jb     2637fa <<glass::engine::Watch>::print_utf8+0x145a>
  2637e9:	add    $0xfffffffffffffff7,%rdx
  2637ed:	cmp    $0x8,%rdx
  2637f1:	mov    $0x6,%esi
  2637f6:	sbb    $0x0,%rsi
  2637fa:	mov    0x38e54f(%rip),%rdx        # 5f1d50 <_DYNAMIC+0x330>
  263801:	lock incq (%rdx,%rsi,8)
  263806:	mov    0xa8(%rsp),%rsi
  26380e:	cmp    %rsi,%rcx
  263811:	jae    2639c8 <<glass::engine::Watch>::print_utf8+0x1628>
  263817:	mov    0x28(%rdi),%r8d
  26381b:	mov    0x20(%rdi),%r9d
  26381f:	mov    0x24(%rdi),%r10d
  263823:	movzwl 0x2c(%rdi),%ecx
  263827:	mov    0x18(%rdi),%rax
  26382b:	test   %rax,%rax
  26382e:	mov    %rax,0x48(%rsp)
  263833:	mov    %cx,0x40(%rsp)
  263838:	mov    %r14,0xb8(%rsp)
  263840:	je     263873 <<glass::engine::Watch>::print_utf8+0x14d3>
  263842:	lock incq (%rax)
  263846:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  26384c:	mov    0x10(%rdi),%rdx
  263850:	mov    %r8d,0x68(%rsp)
  263855:	mov    %r9d,0x60(%rsp)
  26385a:	mov    %r10d,0x64(%rsp)
  26385f:	mov    %cx,0x6c(%rsp)
  263864:	mov    %rax,0x58(%rsp)
  263869:	cmp    %rdx,%rsi
  26386c:	jbe    26388c <<glass::engine::Watch>::print_utf8+0x14ec>
  26386e:	jmp    2647f5 <<glass::engine::Watch>::print_utf8+0x2455>
  263873:	mov    %r8d,0x68(%rsp)
  263878:	mov    %r9d,0x60(%rsp)
  26387d:	mov    %r10d,0x64(%rsp)
  263882:	mov    %cx,0x6c(%rsp)
  263887:	mov    %rax,0x58(%rsp)
  26388c:	mov    0xc8(%rsp),%rax
  263894:	lea    0x0(,%rax,8),%rax
  26389c:	lea    (%rax,%rax,2),%rax
  2638a0:	mov    0x8(%rdi),%rbx
  2638a4:	add    %rax,%rbx
  2638a7:	lea    0x0(,%rsi,8),%rcx
  2638af:	lea    (%rcx,%rcx,2),%r14
  2638b3:	sub    %rax,%r14
  2638b6:	mov    0x48(%rsp),%rdx
  2638bb:	movzwl 0x40(%rsp),%ecx
  2638c0:	mov    %r8d,0x78(%rsp)
  2638c5:	mov    %r9d,0x88(%rsp)
  2638cd:	mov    %r10d,0xb0(%rsp)
  2638d5:	jmp    2638fd <<glass::engine::Watch>::print_utf8+0x155d>
  2638d7:	nopw   0x0(%rax,%rax,1)
  2638e0:	mov    %rdx,(%rbx)
  2638e3:	mov    %r9d,0x8(%rbx)
  2638e7:	mov    %r10d,0xc(%rbx)
  2638eb:	mov    %r8d,0x10(%rbx)
  2638ef:	mov    %cx,0x14(%rbx)
  2638f3:	add    $0x18,%rbx
  2638f7:	add    $0xffffffffffffffe8,%r14
  2638fb:	je     263949 <<glass::engine::Watch>::print_utf8+0x15a9>
  2638fd:	test   %rdx,%rdx
  263900:	je     26390c <<glass::engine::Watch>::print_utf8+0x156c>
  263902:	lock incq (%rdx)
  263906:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  26390c:	mov    (%rbx),%rax
  26390f:	test   %rax,%rax
  263912:	je     2638e0 <<glass::engine::Watch>::print_utf8+0x1540>
  263914:	lock decq (%rax)
  263918:	jne    2638e0 <<glass::engine::Watch>::print_utf8+0x1540>
  26391a:	mov    %rbx,%rdi
  26391d:	call   *0x38e365(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  263923:	movzwl 0x40(%rsp),%ecx
  263928:	mov    0xb0(%rsp),%r10d
  263930:	mov    0x88(%rsp),%r9d
  263938:	mov    0x78(%rsp),%r8d
  26393d:	mov    0x48(%rsp),%rdx
  263942:	mov    0x10(%rsp),%rdi
  263947:	jmp    2638e0 <<glass::engine::Watch>::print_utf8+0x1540>
  263949:	mov    0xc8(%rsp),%rcx
  263951:	cmp    %ecx,0x38(%rdi)
  263954:	mov    0x98(%rsp),%r8
  26395c:	mov    0xb8(%rsp),%r14
  263964:	mov    0x38(%rsp),%r10
  263969:	mov    0x90(%rsp),%r11d
  263971:	mov    0xa0(%rsp),%rbx
  263979:	jbe    26397e <<glass::engine::Watch>::print_utf8+0x15de>
  26397b:	mov    %ecx,0x38(%rdi)
  26397e:	test   %rdx,%rdx
  263981:	mov    0xa8(%rsp),%rsi
  263989:	je     2639c4 <<glass::engine::Watch>::print_utf8+0x1624>
  26398b:	lock decq (%rdx)
  26398f:	jne    2639c4 <<glass::engine::Watch>::print_utf8+0x1624>
  263991:	lea    0x58(%rsp),%rdi
  263996:	mov    %r8,%rbx
  263999:	call   *0x38e2e9(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  26399f:	mov    0xa8(%rsp),%rsi
  2639a7:	mov    0x10(%rsp),%rdi
  2639ac:	mov    %rbx,%r8
  2639af:	mov    0xa0(%rsp),%rbx
  2639b7:	mov    0x90(%rsp),%r11d
  2639bf:	mov    0x38(%rsp),%r10
  2639c4:	mov    0x10(%rdi),%rax
  2639c8:	cmp    %rax,%rsi
  2639cb:	jb     263a09 <<glass::engine::Watch>::print_utf8+0x1669>
  2639cd:	cmpl   $0xffffffff,0x28(%rdi)
  2639d1:	je     263a02 <<glass::engine::Watch>::print_utf8+0x1662>
  2639d3:	mov    (%rbx),%rax
  2639d6:	test   %rax,%rax
  2639d9:	je     263a02 <<glass::engine::Watch>::print_utf8+0x1662>
  2639db:	lock decq (%rax)
  2639df:	jne    263a02 <<glass::engine::Watch>::print_utf8+0x1662>
  2639e1:	mov    %rbx,%rdi
  2639e4:	mov    %r8,%rbx
  2639e7:	call   *0x38e29b(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  2639ed:	mov    0x10(%rsp),%rdi
  2639f2:	mov    %rbx,%r8
  2639f5:	mov    0x90(%rsp),%r11d
  2639fd:	mov    0x38(%rsp),%r10
  263a02:	movl   $0xffffffff,0x28(%rdi)
  263a09:	mov    0x30(%rdi),%rax
  263a0d:	lea    0x1(%r10),%rcx
  263a11:	cmp    %rax,%rcx
  263a14:	cmova  %rcx,%rax
  263a18:	mov    0x10(%rdi),%rsi
  263a1c:	mov    %rax,0x30(%rdi)
  263a20:	cmp    %rsi,%r10
  263a23:	jae    2648de <<glass::engine::Watch>::print_utf8+0x253e>
  263a29:	mov    %r11d,%eax
  263a2c:	or     $0x20,%eax
  263a2f:	cmp    $0x2,%r12
  263a33:	mov    0x8(%rdi),%rcx
  263a37:	lea    (%r10,%r10,2),%rdx
  263a3b:	lea    (%rcx,%rdx,8),%rbx
  263a3f:	mov    0x8(%rsp),%rsi
  263a44:	mov    %esi,0x10(%rcx,%rdx,8)
  263a48:	mov    0x70(%rsp),%esi
  263a4c:	mov    %esi,0x8(%rcx,%rdx,8)
  263a50:	cmovne %r11d,%eax
  263a54:	mov    0x28(%rsp),%esi
  263a58:	mov    %esi,0xc(%rcx,%rdx,8)
  263a5c:	mov    %ax,0x14(%rcx,%rdx,8)
  263a61:	mov    (%rcx,%rdx,8),%rax
  263a65:	test   %rax,%rax
  263a68:	je     263a94 <<glass::engine::Watch>::print_utf8+0x16f4>
  263a6a:	lock decq (%rax)
  263a6e:	jne    263a94 <<glass::engine::Watch>::print_utf8+0x16f4>
  263a70:	mov    %rbx,%rdi
  263a73:	mov    %r14,0xb8(%rsp)
  263a7b:	mov    %r8,%r14
  263a7e:	call   *0x38e204(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  263a84:	mov    0x10(%rsp),%rdi
  263a89:	mov    %r14,%r8
  263a8c:	mov    0xb8(%rsp),%r14
  263a94:	movq   $0x0,(%rbx)
  263a9b:	cmp    $0x2,%r12
  263a9f:	mov    %r15,%r12
  263aa2:	jne    263dec <<glass::engine::Watch>::print_utf8+0x1a4c>
  263aa8:	mov    0x38(%rsp),%rbx
  263aad:	lea    0x1(%rbx),%rdx
  263ab1:	mov    0x30(%rdi),%rax
  263ab5:	mov    0x28(%rdi),%ecx
  263ab8:	cmp    %rax,%rdx
  263abb:	jne    263adc <<glass::engine::Watch>::print_utf8+0x173c>
  263abd:	cmp    $0xffffffff,%ecx
  263ac0:	je     263adc <<glass::engine::Watch>::print_utf8+0x173c>
  263ac2:	add    $0x2,%rbx
  263ac6:	mov    %rbx,0x30(%rdi)
  263aca:	mov    0x10(%rdi),%rsi
  263ace:	cmp    %rsi,%rdx
  263ad1:	jb     263d8e <<glass::engine::Watch>::print_utf8+0x19ee>
  263ad7:	jmp    2648ee <<glass::engine::Watch>::print_utf8+0x254e>
  263adc:	cmp    $0xffffffff,%ecx
  263adf:	je     263d6e <<glass::engine::Watch>::print_utf8+0x19ce>
  263ae5:	mov    0x10(%rdi),%rcx
  263ae9:	cmp    %rax,%rcx
  263aec:	mov    %rax,%rsi
  263aef:	cmovb  %rcx,%rsi
  263af3:	mov    %rsi,0x88(%rsp)
  263afb:	cmp    %rdx,%rcx
  263afe:	mov    %rdx,0xb0(%rsp)
  263b06:	mov    %rdx,%rsi
  263b09:	cmovb  %rcx,%rsi
  263b0d:	mov    0x38e22c(%rip),%rdx        # 5f1d40 <_DYNAMIC+0x320>
  263b14:	movzbl (%rdx),%edx
  263b17:	test   %dl,%dl
  263b19:	je     263ba9 <<glass::engine::Watch>::print_utf8+0x1809>
  263b1f:	mov    0x38e252(%rip),%rdx        # 5f1d78 <_DYNAMIC+0x358>
  263b26:	mov    %rsi,%r9
  263b29:	cmp    %rsi,%rax
  263b2c:	jae    263b35 <<glass::engine::Watch>::print_utf8+0x1795>
  263b2e:	mov    0x38e24b(%rip),%rdx        # 5f1d80 <_DYNAMIC+0x360>
  263b35:	lock incq 0x28(%rdx)
  263b3a:	mov    0x38e217(%rip),%rdx        # 5f1d58 <_DYNAMIC+0x338>
  263b41:	lock incq (%rdx)
  263b45:	mov    %r9,%rdx
  263b48:	sub    0x88(%rsp),%rdx
  263b50:	jne    263b56 <<glass::engine::Watch>::print_utf8+0x17b6>
  263b52:	xor    %esi,%esi
  263b54:	jmp    263b9a <<glass::engine::Watch>::print_utf8+0x17fa>
  263b56:	mov    0x38e203(%rip),%rsi        # 5f1d60 <_DYNAMIC+0x340>
  263b5d:	lock add %rdx,(%rsi)
  263b61:	cmp    $0x5,%rdx
  263b65:	jae    263b75 <<glass::engine::Watch>::print_utf8+0x17d5>
  263b67:	lea    -0x206056(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263b6e:	movzbl -0x1(%rdx,%rsi,1),%esi
  263b73:	jmp    263b9a <<glass::engine::Watch>::print_utf8+0x17fa>
  263b75:	lea    -0x5(%rdx),%rdi
  263b79:	mov    $0x4,%esi
  263b7e:	cmp    $0x4,%rdi
  263b82:	mov    0x10(%rsp),%rdi
  263b87:	jb     263b9a <<glass::engine::Watch>::print_utf8+0x17fa>
  263b89:	add    $0xfffffffffffffff7,%rdx
  263b8d:	cmp    $0x8,%rdx
  263b91:	mov    $0x6,%esi
  263b96:	sbb    $0x0,%rsi
  263b9a:	mov    0x38e1af(%rip),%rdx        # 5f1d50 <_DYNAMIC+0x330>
  263ba1:	lock incq (%rdx,%rsi,8)
  263ba6:	mov    %r9,%rsi
  263ba9:	cmp    %rsi,%rax
  263bac:	lea    0x1(%rbx),%rdx
  263bb0:	jae    263d3d <<glass::engine::Watch>::print_utf8+0x199d>
  263bb6:	mov    %r14,0xb8(%rsp)
  263bbe:	mov    0x28(%rdi),%r8d
  263bc2:	mov    0x20(%rdi),%r10d
  263bc6:	mov    0x24(%rdi),%r11d
  263bca:	movzwl 0x2c(%rdi),%r14d
  263bcf:	mov    0x18(%rdi),%r9
  263bd3:	test   %r9,%r9
  263bd6:	mov    %r9,0x8(%rsp)
  263bdb:	je     263c0f <<glass::engine::Watch>::print_utf8+0x186f>
  263bdd:	lock incq (%r9)
  263be1:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  263be7:	mov    0x10(%rdi),%rdx
  263beb:	mov    %r8d,0x68(%rsp)
  263bf0:	mov    %r10d,0x60(%rsp)
  263bf5:	mov    %r11d,0x64(%rsp)
  263bfa:	mov    %r14w,0x6c(%rsp)
  263c00:	mov    %r9,0x58(%rsp)
  263c05:	cmp    %rdx,%rsi
  263c08:	jbe    263c29 <<glass::engine::Watch>::print_utf8+0x1889>
  263c0a:	jmp    26480f <<glass::engine::Watch>::print_utf8+0x246f>
  263c0f:	mov    %r8d,0x68(%rsp)
  263c14:	mov    %r10d,0x60(%rsp)
  263c19:	mov    %r11d,0x64(%rsp)
  263c1e:	mov    %r14w,0x6c(%rsp)
  263c24:	mov    %r9,0x58(%rsp)
  263c29:	mov    0x88(%rsp),%rax
  263c31:	lea    0x0(,%rax,8),%rax
  263c39:	lea    (%rax,%rax,2),%rax
  263c3d:	mov    0x8(%rdi),%rbx
  263c41:	add    %rax,%rbx
  263c44:	mov    %rsi,0xa8(%rsp)
  263c4c:	lea    0x0(,%rsi,8),%rcx
  263c54:	lea    (%rcx,%rcx,2),%r12
  263c58:	sub    %rax,%r12
  263c5b:	mov    %r10d,0x48(%rsp)
  263c60:	mov    %r11d,0x40(%rsp)
  263c65:	mov    %r14w,0x78(%rsp)
  263c6b:	jmp    263c8e <<glass::engine::Watch>::print_utf8+0x18ee>
  263c6d:	nopl   (%rax)
  263c70:	mov    %r9,(%rbx)
  263c73:	mov    %r10d,0x8(%rbx)
  263c77:	mov    %r11d,0xc(%rbx)
  263c7b:	mov    %r8d,0x10(%rbx)
  263c7f:	mov    %r14w,0x14(%rbx)
  263c84:	add    $0x18,%rbx
  263c88:	add    $0xffffffffffffffe8,%r12
  263c8c:	je     263cd6 <<glass::engine::Watch>::print_utf8+0x1936>
  263c8e:	test   %r9,%r9
  263c91:	je     263c9d <<glass::engine::Watch>::print_utf8+0x18fd>
  263c93:	lock incq (%r9)
  263c97:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  263c9d:	mov    (%rbx),%rax
  263ca0:	test   %rax,%rax
  263ca3:	je     263c70 <<glass::engine::Watch>::print_utf8+0x18d0>
  263ca5:	lock decq (%rax)
  263ca9:	jne    263c70 <<glass::engine::Watch>::print_utf8+0x18d0>
  263cab:	mov    %rbx,%rdi
  263cae:	mov    %r8d,%r14d
  263cb1:	call   *0x38dfd1(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  263cb7:	mov    0x40(%rsp),%r11d
  263cbc:	mov    0x48(%rsp),%r10d
  263cc1:	mov    %r14d,%r8d
  263cc4:	movzwl 0x78(%rsp),%r14d
  263cca:	mov    0x8(%rsp),%r9
  263ccf:	mov    0x10(%rsp),%rdi
  263cd4:	jmp    263c70 <<glass::engine::Watch>::print_utf8+0x18d0>
  263cd6:	mov    0x88(%rsp),%rax
  263cde:	cmp    %eax,0x38(%rdi)
  263ce1:	mov    %r15,%r12
  263ce4:	mov    0x38(%rsp),%rbx
  263ce9:	mov    0xb0(%rsp),%rdx
  263cf1:	jbe    263cf6 <<glass::engine::Watch>::print_utf8+0x1956>
  263cf3:	mov    %eax,0x38(%rdi)
  263cf6:	test   %r9,%r9
  263cf9:	mov    0xa8(%rsp),%rsi
  263d01:	je     263d29 <<glass::engine::Watch>::print_utf8+0x1989>
  263d03:	lock decq (%r9)
  263d07:	jne    263d29 <<glass::engine::Watch>::print_utf8+0x1989>
  263d09:	lea    0x58(%rsp),%rdi
  263d0e:	call   *0x38df74(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  263d14:	mov    0xa8(%rsp),%rsi
  263d1c:	mov    0xb0(%rsp),%rdx
  263d24:	mov    0x10(%rsp),%rdi
  263d29:	mov    0x10(%rdi),%rcx
  263d2d:	mov    0x98(%rsp),%r8
  263d35:	mov    0xb8(%rsp),%r14
  263d3d:	cmp    %rcx,%rsi
  263d40:	jb     263d6e <<glass::engine::Watch>::print_utf8+0x19ce>
  263d42:	mov    0xa0(%rsp),%rdi
  263d4a:	mov    %r8,%rbx
  263d4d:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263d52:	mov    0xb0(%rsp),%rdx
  263d5a:	mov    0x10(%rsp),%rdi
  263d5f:	mov    %rbx,%r8
  263d62:	mov    0x38(%rsp),%rbx
  263d67:	movl   $0xffffffff,0x28(%rdi)
  263d6e:	mov    0x30(%rdi),%rax
  263d72:	add    $0x2,%rbx
  263d76:	cmp    %rax,%rbx
  263d79:	cmovbe %rax,%rbx
  263d7d:	mov    0x10(%rdi),%rsi
  263d81:	mov    %rbx,0x30(%rdi)
  263d85:	cmp    %rsi,%rdx
  263d88:	jae    2648fe <<glass::engine::Watch>::print_utf8+0x255e>
  263d8e:	mov    0x8(%rdi),%rax
  263d92:	lea    (%rdx,%rdx,2),%rcx
  263d96:	lea    (%rax,%rcx,8),%rbx
  263d9a:	movl   $0x20,0x10(%rax,%rcx,8)
  263da2:	mov    0x70(%rsp),%edx
  263da6:	mov    %edx,0x8(%rax,%rcx,8)
  263daa:	mov    0x28(%rsp),%edx
  263dae:	mov    %edx,0xc(%rax,%rcx,8)
  263db2:	mov    0x90(%rsp),%edx
  263db9:	or     $0x40,%edx
  263dbc:	mov    %dx,0x14(%rax,%rcx,8)
  263dc1:	mov    (%rax,%rcx,8),%rax
  263dc5:	test   %rax,%rax
  263dc8:	je     263de5 <<glass::engine::Watch>::print_utf8+0x1a45>
  263dca:	lock decq (%rax)
  263dce:	jne    263de5 <<glass::engine::Watch>::print_utf8+0x1a45>
  263dd0:	mov    %rbx,%rdi
  263dd3:	mov    %r14,%r15
  263dd6:	mov    %r8,%r14
  263dd9:	call   *0x38dea9(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  263ddf:	mov    %r14,%r8
  263de2:	mov    %r15,%r14
  263de5:	movq   $0x0,(%rbx)
  263dec:	mov    0x80(%rsp),%rax
  263df4:	cmp    0x50(%rsp),%rax
  263df9:	jb     263e03 <<glass::engine::Watch>::print_utf8+0x1a63>
  263dfb:	dec    %rax
  263dfe:	movb   $0x1,0x6c(%r14)
  263e03:	mov    %rax,0x40(%r14)
  263e07:	mov    0xd0(%rsp),%r14
  263e0f:	incq   0xa0(%r14)
  263e16:	jmp    26245d <<glass::engine::Watch>::print_utf8+0xbd>
  263e1b:	mov    %rdx,%rbx
  263e1e:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263e23:	mov    %rbx,%rdx
  263e26:	mov    %edx,%ebx
  263e28:	mov    0x390dc1(%rip),%rsi        # 5f4bf0 <glass::engine::width_of::CACHE+0x8>
  263e2f:	cmp    %rbx,%rsi
  263e32:	ja     2634bb <<glass::engine::Watch>::print_utf8+0x111b>
  263e38:	jmp    2647e5 <<glass::engine::Watch>::print_utf8+0x2445>
  263e3d:	movzbl %cl,%edx
  263e40:	add    %r10,%rdx
  263e43:	mov    0xb0(%rsp),%rdi
  263e4b:	mov    0x38(%rsp),%rsi
  263e50:	lea    0xf0(%rsp),%rcx
  263e58:	mov    %r8,%r15
  263e5b:	mov    %r11,%rbp
  263e5e:	mov    %r10,0xc0(%rsp)
  263e66:	call   2a1ad0 <glass::engine::note_uniform_span>
  263e6b:	mov    0x8(%rsp),%rcx
  263e70:	mov    %rbp,%r11
  263e73:	mov    %r15,%r8
  263e76:	mov    %rbx,%rbp
  263e79:	mov    0xc0(%rsp),%r10
  263e81:	jmp    26333b <<glass::engine::Watch>::print_utf8+0xf9b>
  263e86:	mov    %rdi,%rdx
  263e89:	cmpq   $0x3ff,0xa0(%r14)
  263e94:	jbe    263edb <<glass::engine::Watch>::print_utf8+0x1b3b>
  263e96:	mov    %r14,%rdi
  263e99:	mov    %rdx,%rbx
  263e9c:	mov    %r8,%r15
  263e9f:	call   264c90 <<glass::engine::Watch>::fold_sentinel>
  263ea4:	mov    %r15,%r8
  263ea7:	mov    %rbx,%rdx
  263eaa:	movq   $0x0,0xa0(%r14)
  263eb5:	mov    0x390d45(%rip),%eax        # 5f4c00 <glass::engine::run_whole::ON>
  263ebb:	test   %eax,%eax
  263ebd:	je     263ee5 <<glass::engine::Watch>::print_utf8+0x1b45>
  263ebf:	mov    %rdx,%rbx
  263ec2:	mov    %r8,%r15
  263ec5:	call   18ba06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  263eca:	mov    %r15,%r8
  263ecd:	mov    %rbx,%rdx
  263ed0:	cmpb   $0x1,0x390d2d(%rip)        # 5f4c04 <glass::engine::run_whole::ON+0x4>
  263ed7:	je     263eee <<glass::engine::Watch>::print_utf8+0x1b4e>
  263ed9:	jmp    263f1a <<glass::engine::Watch>::print_utf8+0x1b7a>
  263edb:	mov    0x390d1f(%rip),%eax        # 5f4c00 <glass::engine::run_whole::ON>
  263ee1:	test   %eax,%eax
  263ee3:	jne    263ebf <<glass::engine::Watch>::print_utf8+0x1b1f>
  263ee5:	cmpb   $0x1,0x390d18(%rip)        # 5f4c04 <glass::engine::run_whole::ON+0x4>
  263eec:	jne    263f1a <<glass::engine::Watch>::print_utf8+0x1b7a>
  263eee:	cmp    %r8,%r12
  263ef1:	jne    263f1a <<glass::engine::Watch>::print_utf8+0x1b7a>
  263ef3:	cmp    $0xffffffff,%edx
  263ef6:	je     2640c0 <<glass::engine::Watch>::print_utf8+0x1d20>
  263efc:	lea    -0x20(%rdx),%eax
  263eff:	cmp    $0x5f,%eax
  263f02:	jae    263f2d <<glass::engine::Watch>::print_utf8+0x1b8d>
  263f04:	mov    $0x1,%r12d
  263f0a:	cmpb   $0x0,0x1c(%rsp)
  263f0f:	jne    263ff9 <<glass::engine::Watch>::print_utf8+0x1c59>
  263f15:	jmp    2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  263f1a:	xor    %eax,%eax
  263f1c:	cmp    $0xffffffff,%edx
  263f1f:	mov    0x10(%rsp),%r8
  263f24:	cmove  %rax,%r8
  263f28:	jmp    2640c0 <<glass::engine::Watch>::print_utf8+0x1d20>
  263f2d:	cmpb   $0x0,0x30(%rsp)
  263f32:	je     2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  263f38:	mov    0x390cba(%rip),%eax        # 5f4bf8 <glass::engine::width_of::CACHE+0x10>
  263f3e:	test   %eax,%eax
  263f40:	jne    2647c8 <<glass::engine::Watch>::print_utf8+0x2428>
  263f46:	mov    %edx,%ebx
  263f48:	mov    0x390ca1(%rip),%rsi        # 5f4bf0 <glass::engine::width_of::CACHE+0x8>
  263f4f:	cmp    %rbx,%rsi
  263f52:	jbe    2647e5 <<glass::engine::Watch>::print_utf8+0x2445>
  263f58:	mov    0x390c89(%rip),%r15        # 5f4be8 <glass::engine::width_of::CACHE>
  263f5f:	movzbl (%r15,%rbx,1),%eax
  263f64:	movzbl %al,%r12d
  263f68:	test   %r12b,%r12b
  263f6b:	js     263f78 <<glass::engine::Watch>::print_utf8+0x1bd8>
  263f6d:	mov    $0x1,%cl
  263f6f:	test   %cl,%cl
  263f71:	jne    263fea <<glass::engine::Watch>::print_utf8+0x1c4a>
  263f73:	jmp    2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  263f78:	cmp    $0xfe,%r12d
  263f7f:	je     2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  263f85:	mov    $0xfe,%al
  263f87:	cmp    $0x7f,%edx
  263f8a:	jae    263fbf <<glass::engine::Watch>::print_utf8+0x1c1f>
  263f8c:	mov    $0x1,%r12d
  263f92:	xor    %ecx,%ecx
  263f94:	jmp    263fde <<glass::engine::Watch>::print_utf8+0x1c3e>
  263f96:	mov    $0x1,%cl
  263f98:	mov    %ecx,0x30(%rsp)
  263f9c:	cmpb   $0x0,0x68(%rax)
  263fa0:	jne    263fb2 <<glass::engine::Watch>::print_utf8+0x1c12>
  263fa2:	cmpb   $0x0,0x69(%rax)
  263fa6:	jne    263fb2 <<glass::engine::Watch>::print_utf8+0x1c12>
  263fa8:	cmpb   $0x0,0x6a(%rax)
  263fac:	je     2641cd <<glass::engine::Watch>::print_utf8+0x1e2d>
  263fb2:	movl   $0x0,0x1c(%rsp)
  263fba:	jmp    262400 <<glass::engine::Watch>::print_utf8+0x60>
  263fbf:	cmp    $0xa0,%edx
  263fc5:	jb     263fdc <<glass::engine::Watch>::print_utf8+0x1c3c>
  263fc7:	mov    %edx,%edi
  263fc9:	mov    %rdx,%r12
  263fcc:	call   298c70 <unicode_width::tables::lookup_width>
  263fd1:	mov    %r12,%rdx
  263fd4:	movzbl %al,%r12d
  263fd8:	mov    $0x1,%cl
  263fda:	jmp    263fde <<glass::engine::Watch>::print_utf8+0x1c3e>
  263fdc:	xor    %ecx,%ecx
  263fde:	mov    %al,(%r15,%rbx,1)
  263fe2:	test   %cl,%cl
  263fe4:	je     2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  263fea:	lea    -0x1(%r12),%rax
  263fef:	cmp    $0x1,%rax
  263ff3:	ja     2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  263ff9:	mov    0x78(%r14),%r13
  263ffd:	cmpb   $0x0,0x6c(%r13)
  264002:	jne    2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  264008:	mov    0x40(%r13),%rbp
  26400c:	mov    0xa0(%r13),%r8
  264013:	lea    (%r12,%rbp,1),%r15
  264017:	cmp    %r8,%r15
  26401a:	ja     2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  264020:	mov    0x30(%r13),%eax
  264024:	sub    0x48(%r13),%eax
  264028:	cltq
  26402a:	mov    0x20(%r13),%rsi
  26402e:	mov    0x28(%r13),%rcx
  264032:	lea    (%rcx,%rax,1),%rdi
  264036:	dec    %rdi
  264039:	xor    %eax,%eax
  26403b:	cmp    %rsi,%rdi
  26403e:	cmovae %rsi,%rax
  264042:	sub    %rax,%rdi
  264045:	cmp    %rsi,%rdi
  264048:	jae    264854 <<glass::engine::Watch>::print_utf8+0x24b4>
  26404e:	mov    0x58(%r13),%r10d
  264052:	mov    0x5c(%r13),%r11d
  264056:	movzwl 0x64(%r13),%r9d
  26405b:	mov    0x18(%r13),%rax
  26405f:	shl    $0x6,%rdi
  264063:	lea    (%rax,%rdi,1),%rbx
  264067:	lea    (%rax,%rdi,1),%rcx
  26406b:	add    $0x18,%rcx
  26406f:	mov    %rcx,0x20(%rsp)
  264074:	mov    0x28(%rax,%rdi,1),%eax
  264078:	cmp    $0xffffffff,%eax
  26407b:	je     264088 <<glass::engine::Watch>::print_utf8+0x1ce8>
  26407d:	mov    0x20(%rsp),%rcx
  264082:	cmp    0x30(%rbx),%rbp
  264086:	jae    2640a8 <<glass::engine::Watch>::print_utf8+0x1d08>
  264088:	mov    0x10(%rbx),%rsi
  26408c:	cmp    %rsi,%rbp
  26408f:	jae    26490e <<glass::engine::Watch>::print_utf8+0x256e>
  264095:	lea    0x0(,%rbp,2),%rcx
  26409d:	add    %rbp,%rcx
  2640a0:	shl    $0x3,%rcx
  2640a4:	add    0x8(%rbx),%rcx
  2640a8:	testb  $0x60,0x14(%rcx)
  2640ac:	je     2640d5 <<glass::engine::Watch>::print_utf8+0x1d35>
  2640ae:	mov    %r14,%rdi
  2640b1:	mov    %edx,%esi
  2640b3:	call   33d650 <<glass::engine::Watch as vte::ansi::Handler>::input>
  2640b8:	mov    0x98(%rsp),%r8
  2640c0:	mov    %r8,%rax
  2640c3:	add    $0x118,%rsp
  2640ca:	pop    %rbx
  2640cb:	pop    %r12
  2640cd:	pop    %r13
  2640cf:	pop    %r14
  2640d1:	pop    %r15
  2640d3:	pop    %rbp
  2640d4:	ret
  2640d5:	cmp    $0x2,%r12
  2640d9:	jne    26410e <<glass::engine::Watch>::print_utf8+0x1d6e>
  2640db:	lea    0x1(%rbp),%rdi
  2640df:	cmp    $0xffffffff,%eax
  2640e2:	je     2640ef <<glass::engine::Watch>::print_utf8+0x1d4f>
  2640e4:	mov    0x20(%rsp),%rcx
  2640e9:	cmp    0x30(%rbx),%rdi
  2640ed:	jae    264108 <<glass::engine::Watch>::print_utf8+0x1d68>
  2640ef:	mov    0x10(%rbx),%rsi
  2640f3:	cmp    %rsi,%rdi
  2640f6:	jae    2648c1 <<glass::engine::Watch>::print_utf8+0x2521>
  2640fc:	lea    (%rdi,%rdi,2),%rcx
  264100:	shl    $0x3,%rcx
  264104:	add    0x8(%rbx),%rcx
  264108:	testb  $0x60,0x14(%rcx)
  26410c:	jne    2640ae <<glass::engine::Watch>::print_utf8+0x1d0e>
  26410e:	mov    %r11d,0x28(%rsp)
  264113:	mov    %r10d,0x70(%rsp)
  264118:	mov    %r9d,0x10(%rsp)
  26411d:	mov    %r8,0xa0(%rsp)
  264125:	mov    %rdx,0x8(%rsp)
  26412a:	cmp    %ebp,0x38(%rbx)
  26412d:	jbe    264132 <<glass::engine::Watch>::print_utf8+0x1d92>
  26412f:	mov    %ebp,0x38(%rbx)
  264132:	cmp    $0xffffffff,%eax
  264135:	setne  %cl
  264138:	mov    %rbx,%rdi
  26413b:	mov    0x30(%rbx),%rbx
  26413f:	cmp    %rbx,%rbp
  264142:	sete   %dl
  264145:	test   %dl,%cl
  264147:	mov    %rdi,0x30(%rsp)
  26414c:	jne    264195 <<glass::engine::Watch>::print_utf8+0x1df5>
  26414e:	cmp    $0xffffffff,%eax
  264151:	je     2643e5 <<glass::engine::Watch>::print_utf8+0x2045>
  264157:	mov    0x30(%rsp),%rax
  26415c:	mov    0x10(%rax),%r15
  264160:	cmp    %rbx,%r15
  264163:	mov    %rbx,%rcx
  264166:	cmovb  %r15,%rcx
  26416a:	cmp    %rbp,%r15
  26416d:	mov    %rbp,%r14
  264170:	cmovb  %r15,%r14
  264174:	mov    0x38dbc5(%rip),%rax        # 5f1d40 <_DYNAMIC+0x320>
  26417b:	movzbl (%rax),%eax
  26417e:	test   %al,%al
  264180:	mov    %rcx,0x48(%rsp)
  264185:	je     2641f4 <<glass::engine::Watch>::print_utf8+0x1e54>
  264187:	cmp    %r14,%rbx
  26418a:	jae    2641dd <<glass::engine::Watch>::print_utf8+0x1e3d>
  26418c:	mov    0x38dbed(%rip),%rax        # 5f1d80 <_DYNAMIC+0x360>
  264193:	jmp    2641e4 <<glass::engine::Watch>::print_utf8+0x1e44>
  264195:	lea    0x1(%rbp),%rax
  264199:	mov    %rax,0x30(%rdi)
  26419d:	mov    0x10(%rdi),%rsi
  2641a1:	cmp    %rsi,%rbp
  2641a4:	mov    %rdi,%rdx
  2641a7:	jb     26440a <<glass::engine::Watch>::print_utf8+0x206a>
  2641ad:	lea    0x3653f4(%rip),%rdx        # 5c95a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  2641b4:	mov    %rbp,%rdi
  2641b7:	call   *0x38da7b(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  2641bd:	lea    0x36533c(%rip),%rcx        # 5c9500 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15a80>
  2641c4:	mov    %r10,%rdi
  2641c7:	call   *0x38dc2b(%rip)        # 5f1df8 <_DYNAMIC+0x3d8>
  2641cd:	cmpb   $0x0,0x6b(%rax)
  2641d1:	sete   %al
  2641d4:	mov    %eax,0x1c(%rsp)
  2641d8:	jmp    262400 <<glass::engine::Watch>::print_utf8+0x60>
  2641dd:	mov    0x38db94(%rip),%rax        # 5f1d78 <_DYNAMIC+0x358>
  2641e4:	lock incq 0x28(%rax)
  2641e9:	mov    %r14,%rdi
  2641ec:	sub    %rcx,%rdi
  2641ef:	call   2f7200 <alacritty_terminal::grid::row::fill_census::note>
  2641f4:	cmp    %r14,%rbx
  2641f7:	jae    2643bd <<glass::engine::Watch>::print_utf8+0x201d>
  2641fd:	mov    %r14,0x40(%rsp)
  264202:	mov    0x30(%rsp),%rcx
  264207:	mov    0x28(%rcx),%edi
  26420a:	mov    0x20(%rcx),%r8d
  26420e:	mov    0x24(%rcx),%r9d
  264212:	movzwl 0x2c(%rcx),%r10d
  264217:	mov    0x18(%rcx),%r14
  26421b:	test   %r14,%r14
  26421e:	mov    %edi,0x80(%rsp)
  264225:	mov    %r8d,0x50(%rsp)
  26422a:	mov    %r9d,0x1c(%rsp)
  26422f:	mov    %r10w,0x38(%rsp)
  264235:	je     2642f4 <<glass::engine::Watch>::print_utf8+0x1f54>
  26423b:	lock incq (%r14)
  26423f:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  264245:	mov    0x10(%rcx),%rdx
  264249:	mov    %edi,0x68(%rsp)
  26424d:	mov    %r8d,0x60(%rsp)
  264252:	mov    %r9d,0x64(%rsp)
  264257:	mov    %r10w,0x6c(%rsp)
  26425d:	mov    %r14,0x58(%rsp)
  264262:	mov    0x40(%rsp),%rsi
  264267:	cmp    %rdx,%rsi
  26426a:	ja     264861 <<glass::engine::Watch>::print_utf8+0x24c1>
  264270:	mov    0x48(%rsp),%rax
  264275:	lea    0x0(,%rax,8),%rax
  26427d:	lea    (%rax,%rax,2),%rax
  264281:	mov    0x8(%rcx),%rbx
  264285:	add    %rax,%rbx
  264288:	lea    0x0(,%rsi,8),%rcx
  264290:	lea    (%rcx,%rcx,2),%r15
  264294:	sub    %rax,%r15
  264297:	jmp    2642ba <<glass::engine::Watch>::print_utf8+0x1f1a>
  264299:	mov    %r14,(%rbx)
  26429c:	mov    %r8d,0x8(%rbx)
  2642a0:	mov    %r9d,0xc(%rbx)
  2642a4:	mov    %edi,0x10(%rbx)
  2642a7:	mov    %r10w,0x14(%rbx)
  2642ac:	add    $0x18,%rbx
  2642b0:	add    $0xffffffffffffffe8,%r15
  2642b4:	je     26438c <<glass::engine::Watch>::print_utf8+0x1fec>
  2642ba:	lock incq (%r14)
  2642be:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  2642c4:	mov    (%rbx),%rax
  2642c7:	test   %rax,%rax
  2642ca:	je     264299 <<glass::engine::Watch>::print_utf8+0x1ef9>
  2642cc:	lock decq (%rax)
  2642d0:	jne    264299 <<glass::engine::Watch>::print_utf8+0x1ef9>
  2642d2:	mov    %rbx,%rdi
  2642d5:	call   *0x38d9ad(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  2642db:	movzwl 0x38(%rsp),%r10d
  2642e1:	mov    0x1c(%rsp),%r9d
  2642e6:	mov    0x50(%rsp),%r8d
  2642eb:	mov    0x80(%rsp),%edi
  2642f2:	jmp    264299 <<glass::engine::Watch>::print_utf8+0x1ef9>
  2642f4:	mov    %edi,0x68(%rsp)
  2642f8:	mov    %r8d,0x60(%rsp)
  2642fd:	mov    %r9d,0x64(%rsp)
  264302:	mov    %r10w,0x6c(%rsp)
  264308:	mov    %r14,0x58(%rsp)
  26430d:	mov    0x48(%rsp),%rax
  264312:	lea    0x0(,%rax,8),%rax
  26431a:	lea    (%rax,%rax,2),%rax
  26431e:	mov    0x8(%rcx),%rbx
  264322:	add    %rax,%rbx
  264325:	mov    0x40(%rsp),%rcx
  26432a:	lea    0x0(,%rcx,8),%rcx
  264332:	lea    (%rcx,%rcx,2),%r15
  264336:	sub    %rax,%r15
  264339:	jmp    26435c <<glass::engine::Watch>::print_utf8+0x1fbc>
  26433b:	movq   $0x0,(%rbx)
  264342:	mov    %r8d,0x8(%rbx)
  264346:	mov    %r9d,0xc(%rbx)
  26434a:	mov    %edi,0x10(%rbx)
  26434d:	mov    %r10w,0x14(%rbx)
  264352:	add    $0x18,%rbx
  264356:	add    $0xffffffffffffffe8,%r15
  26435a:	je     26438c <<glass::engine::Watch>::print_utf8+0x1fec>
  26435c:	mov    (%rbx),%rax
  26435f:	test   %rax,%rax
  264362:	je     26433b <<glass::engine::Watch>::print_utf8+0x1f9b>
  264364:	lock decq (%rax)
  264368:	jne    26433b <<glass::engine::Watch>::print_utf8+0x1f9b>
  26436a:	mov    %rbx,%rdi
  26436d:	call   *0x38d915(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  264373:	movzwl 0x38(%rsp),%r10d
  264379:	mov    0x1c(%rsp),%r9d
  26437e:	mov    0x50(%rsp),%r8d
  264383:	mov    0x80(%rsp),%edi
  26438a:	jmp    26433b <<glass::engine::Watch>::print_utf8+0x1f9b>
  26438c:	mov    0x30(%rsp),%rbx
  264391:	mov    0x48(%rsp),%rax
  264396:	cmp    %eax,0x38(%rbx)
  264399:	jbe    26439e <<glass::engine::Watch>::print_utf8+0x1ffe>
  26439b:	mov    %eax,0x38(%rbx)
  26439e:	test   %r14,%r14
  2643a1:	je     2643b4 <<glass::engine::Watch>::print_utf8+0x2014>
  2643a3:	lock decq (%r14)
  2643a7:	jne    2643b4 <<glass::engine::Watch>::print_utf8+0x2014>
  2643a9:	lea    0x58(%rsp),%rdi
  2643ae:	call   *0x38d8d4(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  2643b4:	mov    0x10(%rbx),%r15
  2643b8:	mov    0x40(%rsp),%r14
  2643bd:	cmp    %r15,%r14
  2643c0:	mov    0xd0(%rsp),%r14
  2643c8:	lea    0x0(%rbp,%r12,1),%r15
  2643cd:	jb     2643e5 <<glass::engine::Watch>::print_utf8+0x2045>
  2643cf:	mov    0x20(%rsp),%rdi
  2643d4:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2643d9:	mov    0x30(%rsp),%rax
  2643de:	movl   $0xffffffff,0x28(%rax)
  2643e5:	mov    0x30(%rsp),%rdx
  2643ea:	mov    0x30(%rdx),%rax
  2643ee:	lea    0x1(%rbp),%rcx
  2643f2:	cmp    %rax,%rcx
  2643f5:	cmova  %rcx,%rax
  2643f9:	mov    0x10(%rdx),%rsi
  2643fd:	mov    %rax,0x30(%rdx)
  264401:	cmp    %rsi,%rbp
  264404:	jae    26491e <<glass::engine::Watch>::print_utf8+0x257e>
  26440a:	mov    0x10(%rsp),%edi
  26440e:	mov    %edi,%eax
  264410:	or     $0x20,%eax
  264413:	cmp    $0x2,%r12
  264417:	mov    0x8(%rdx),%rcx
  26441b:	lea    0x0(%rbp,%rbp,2),%rdx
  264420:	lea    (%rcx,%rdx,8),%rbx
  264424:	mov    0x8(%rsp),%rsi
  264429:	mov    %esi,0x10(%rcx,%rdx,8)
  26442d:	mov    0x70(%rsp),%esi
  264431:	mov    %esi,0x8(%rcx,%rdx,8)
  264435:	cmovne %edi,%eax
  264438:	mov    0x28(%rsp),%esi
  26443c:	mov    %esi,0xc(%rcx,%rdx,8)
  264440:	mov    %ax,0x14(%rcx,%rdx,8)
  264445:	mov    (%rcx,%rdx,8),%rax
  264449:	test   %rax,%rax
  26444c:	je     26445d <<glass::engine::Watch>::print_utf8+0x20bd>
  26444e:	lock decq (%rax)
  264452:	jne    26445d <<glass::engine::Watch>::print_utf8+0x20bd>
  264454:	mov    %rbx,%rdi
  264457:	call   *0x38d82b(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  26445d:	movq   $0x0,(%rbx)
  264464:	cmp    $0x2,%r12
  264468:	mov    0x8(%rsp),%rdx
  26446d:	jne    264797 <<glass::engine::Watch>::print_utf8+0x23f7>
  264473:	lea    0x1(%rbp),%r12
  264477:	mov    0x30(%rsp),%rax
  26447c:	mov    0x30(%rax),%rbx
  264480:	mov    0x28(%rax),%eax
  264483:	cmp    %rbx,%r12
  264486:	jne    2644b7 <<glass::engine::Watch>::print_utf8+0x2117>
  264488:	cmp    $0xffffffff,%eax
  26448b:	je     2644b7 <<glass::engine::Watch>::print_utf8+0x2117>
  26448d:	add    $0x2,%rbp
  264491:	mov    0x30(%rsp),%rcx
  264496:	mov    %rbp,0x30(%rcx)
  26449a:	mov    0x10(%rcx),%rsi
  26449e:	cmp    %rsi,%r12
  2644a1:	jb     264743 <<glass::engine::Watch>::print_utf8+0x23a3>
  2644a7:	lea    0x3650fa(%rip),%rdx        # 5c95a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  2644ae:	mov    %r12,%rdi
  2644b1:	call   *0x38d781(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  2644b7:	cmp    $0xffffffff,%eax
  2644ba:	je     26471e <<glass::engine::Watch>::print_utf8+0x237e>
  2644c0:	mov    %r15,0x38(%rsp)
  2644c5:	mov    0x30(%rsp),%rax
  2644ca:	mov    0x10(%rax),%r15
  2644ce:	cmp    %rbx,%r15
  2644d1:	mov    %rbx,%rcx
  2644d4:	cmovb  %r15,%rcx
  2644d8:	cmp    %r12,%r15
  2644db:	mov    %r12,%r14
  2644de:	cmovb  %r15,%r14
  2644e2:	mov    0x38d857(%rip),%rax        # 5f1d40 <_DYNAMIC+0x320>
  2644e9:	movzbl (%rax),%eax
  2644ec:	test   %al,%al
  2644ee:	mov    %rcx,0x48(%rsp)
  2644f3:	je     26451f <<glass::engine::Watch>::print_utf8+0x217f>
  2644f5:	cmp    %r14,%rbx
  2644f8:	jae    264503 <<glass::engine::Watch>::print_utf8+0x2163>
  2644fa:	mov    0x38d87f(%rip),%rax        # 5f1d80 <_DYNAMIC+0x360>
  264501:	jmp    26450a <<glass::engine::Watch>::print_utf8+0x216a>
  264503:	mov    0x38d86e(%rip),%rax        # 5f1d78 <_DYNAMIC+0x358>
  26450a:	lock incq 0x28(%rax)
  26450f:	mov    %r14,%rdi
  264512:	sub    %rcx,%rdi
  264515:	call   2f7200 <alacritty_terminal::grid::row::fill_census::note>
  26451a:	mov    0x8(%rsp),%rdx
  26451f:	cmp    %r14,%rbx
  264522:	jae    2646f1 <<glass::engine::Watch>::print_utf8+0x2351>
  264528:	mov    %r14,0x40(%rsp)
  26452d:	mov    0x30(%rsp),%rcx
  264532:	mov    0x28(%rcx),%edi
  264535:	mov    0x20(%rcx),%r8d
  264539:	mov    0x24(%rcx),%r9d
  26453d:	movzwl 0x2c(%rcx),%r14d
  264542:	mov    0x18(%rcx),%r12
  264546:	test   %r12,%r12
  264549:	mov    %edi,0x80(%rsp)
  264550:	mov    %r8d,0x50(%rsp)
  264555:	mov    %r9d,0x1c(%rsp)
  26455a:	je     26461f <<glass::engine::Watch>::print_utf8+0x227f>
  264560:	lock incq (%r12)
  264565:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  26456b:	mov    0x10(%rcx),%rdx
  26456f:	mov    %edi,0x68(%rsp)
  264573:	mov    %r8d,0x60(%rsp)
  264578:	mov    %r9d,0x64(%rsp)
  26457d:	mov    %r14w,0x6c(%rsp)
  264583:	mov    %r12,0x58(%rsp)
  264588:	mov    0x40(%rsp),%rsi
  26458d:	cmp    %rdx,%rsi
  264590:	ja     2648ad <<glass::engine::Watch>::print_utf8+0x250d>
  264596:	mov    0x48(%rsp),%rax
  26459b:	lea    0x0(,%rax,8),%rax
  2645a3:	lea    (%rax,%rax,2),%rax
  2645a7:	mov    0x8(%rcx),%rbx
  2645ab:	add    %rax,%rbx
  2645ae:	lea    0x0(,%rsi,8),%rcx
  2645b6:	lea    (%rcx,%rcx,2),%r15
  2645ba:	sub    %rax,%r15
  2645bd:	mov    0x8(%rsp),%rdx
  2645c2:	jmp    2645e5 <<glass::engine::Watch>::print_utf8+0x2245>
  2645c4:	mov    %r12,(%rbx)
  2645c7:	mov    %r8d,0x8(%rbx)
  2645cb:	mov    %r9d,0xc(%rbx)
  2645cf:	mov    %edi,0x10(%rbx)
  2645d2:	mov    %r14w,0x14(%rbx)
  2645d7:	add    $0x18,%rbx
  2645db:	add    $0xffffffffffffffe8,%r15
  2645df:	je     2646b6 <<glass::engine::Watch>::print_utf8+0x2316>
  2645e5:	lock incq (%r12)
  2645ea:	jle    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  2645f0:	mov    (%rbx),%rax
  2645f3:	test   %rax,%rax
  2645f6:	je     2645c4 <<glass::engine::Watch>::print_utf8+0x2224>
  2645f8:	lock decq (%rax)
  2645fc:	jne    2645c4 <<glass::engine::Watch>::print_utf8+0x2224>
  2645fe:	mov    %rbx,%rdi
  264601:	call   *0x38d681(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  264607:	mov    0x1c(%rsp),%r9d
  26460c:	mov    0x50(%rsp),%r8d
  264611:	mov    0x80(%rsp),%edi
  264618:	mov    0x8(%rsp),%rdx
  26461d:	jmp    2645c4 <<glass::engine::Watch>::print_utf8+0x2224>
  26461f:	mov    %edi,0x68(%rsp)
  264623:	mov    %r8d,0x60(%rsp)
  264628:	mov    %r9d,0x64(%rsp)
  26462d:	mov    %r14w,0x6c(%rsp)
  264633:	mov    %r12,0x58(%rsp)
  264638:	mov    0x48(%rsp),%rax
  26463d:	lea    0x0(,%rax,8),%rax
  264645:	lea    (%rax,%rax,2),%rax
  264649:	mov    0x8(%rcx),%rbx
  26464d:	add    %rax,%rbx
  264650:	mov    0x40(%rsp),%rcx
  264655:	lea    0x0(,%rcx,8),%rcx
  26465d:	lea    (%rcx,%rcx,2),%r15
  264661:	sub    %rax,%r15
  264664:	jmp    264687 <<glass::engine::Watch>::print_utf8+0x22e7>
  264666:	movq   $0x0,(%rbx)
  26466d:	mov    %r8d,0x8(%rbx)
  264671:	mov    %r9d,0xc(%rbx)
  264675:	mov    %edi,0x10(%rbx)
  264678:	mov    %r14w,0x14(%rbx)
  26467d:	add    $0x18,%rbx
  264681:	add    $0xffffffffffffffe8,%r15
  264685:	je     2646b6 <<glass::engine::Watch>::print_utf8+0x2316>
  264687:	mov    (%rbx),%rax
  26468a:	test   %rax,%rax
  26468d:	je     264666 <<glass::engine::Watch>::print_utf8+0x22c6>
  26468f:	lock decq (%rax)
  264693:	jne    264666 <<glass::engine::Watch>::print_utf8+0x22c6>
  264695:	mov    %rbx,%rdi
  264698:	call   *0x38d5ea(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  26469e:	mov    0x1c(%rsp),%r9d
  2646a3:	mov    0x50(%rsp),%r8d
  2646a8:	mov    0x80(%rsp),%edi
  2646af:	mov    0x8(%rsp),%rdx
  2646b4:	jmp    264666 <<glass::engine::Watch>::print_utf8+0x22c6>
  2646b6:	mov    0x30(%rsp),%rbx
  2646bb:	mov    0x48(%rsp),%rax
  2646c0:	cmp    %eax,0x38(%rbx)
  2646c3:	jbe    2646c8 <<glass::engine::Watch>::print_utf8+0x2328>
  2646c5:	mov    %eax,0x38(%rbx)
  2646c8:	test   %r12,%r12
  2646cb:	mov    0x40(%rsp),%r14
  2646d0:	je     2646e9 <<glass::engine::Watch>::print_utf8+0x2349>
  2646d2:	lock decq (%r12)
  2646d7:	jne    2646e9 <<glass::engine::Watch>::print_utf8+0x2349>
  2646d9:	lea    0x58(%rsp),%rdi
  2646de:	call   *0x38d5a4(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  2646e4:	mov    0x8(%rsp),%rdx
  2646e9:	mov    0x10(%rbx),%r15
  2646ed:	lea    0x1(%rbp),%r12
  2646f1:	cmp    %r15,%r14
  2646f4:	mov    0xd0(%rsp),%r14
  2646fc:	mov    0x38(%rsp),%r15
  264701:	jb     26471e <<glass::engine::Watch>::print_utf8+0x237e>
  264703:	mov    0x20(%rsp),%rdi
  264708:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26470d:	mov    0x8(%rsp),%rdx
  264712:	mov    0x30(%rsp),%rax
  264717:	movl   $0xffffffff,0x28(%rax)
  26471e:	mov    0x30(%rsp),%rcx
  264723:	mov    0x30(%rcx),%rax
  264727:	add    $0x2,%rbp
  26472b:	cmp    %rax,%rbp
  26472e:	cmovbe %rax,%rbp
  264732:	mov    0x10(%rcx),%rsi
  264736:	mov    %rbp,0x30(%rcx)
  26473a:	cmp    %rsi,%r12
  26473d:	jae    26492e <<glass::engine::Watch>::print_utf8+0x258e>
  264743:	mov    0x8(%rcx),%rax
  264747:	lea    (%r12,%r12,2),%rcx
  26474b:	lea    (%rax,%rcx,8),%rbx
  26474f:	movl   $0x20,0x10(%rax,%rcx,8)
  264757:	mov    0x70(%rsp),%esi
  26475b:	mov    %esi,0x8(%rax,%rcx,8)
  26475f:	mov    0x28(%rsp),%esi
  264763:	mov    %esi,0xc(%rax,%rcx,8)
  264767:	mov    0x10(%rsp),%esi
  26476b:	or     $0x40,%esi
  26476e:	mov    %si,0x14(%rax,%rcx,8)
  264773:	mov    (%rax,%rcx,8),%rax
  264777:	test   %rax,%rax
  26477a:	je     264790 <<glass::engine::Watch>::print_utf8+0x23f0>
  26477c:	lock decq (%rax)
  264780:	jne    264790 <<glass::engine::Watch>::print_utf8+0x23f0>
  264782:	mov    %rbx,%rdi
  264785:	call   *0x38d4fd(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  26478b:	mov    0x8(%rsp),%rdx
  264790:	movq   $0x0,(%rbx)
  264797:	cmp    0xa0(%rsp),%r15
  26479f:	jb     2647a9 <<glass::engine::Watch>::print_utf8+0x2409>
  2647a1:	dec    %r15
  2647a4:	movb   $0x1,0x6c(%r13)
  2647a9:	mov    0x98(%rsp),%r8
  2647b1:	mov    %r15,0x40(%r13)
  2647b5:	incq   0xa0(%r14)
  2647bc:	mov    %edx,0xb0(%r14)
  2647c3:	jmp    2640c0 <<glass::engine::Watch>::print_utf8+0x1d20>
  2647c8:	mov    %rdx,%rbx
  2647cb:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2647d0:	mov    %rbx,%rdx
  2647d3:	mov    %edx,%ebx
  2647d5:	mov    0x390414(%rip),%rsi        # 5f4bf0 <glass::engine::width_of::CACHE+0x8>
  2647dc:	cmp    %rbx,%rsi
  2647df:	ja     263f58 <<glass::engine::Watch>::print_utf8+0x1bb8>
  2647e5:	lea    0x366fac(%rip),%rdx        # 5cb798 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d18>
  2647ec:	mov    %rbx,%rdi
  2647ef:	call   *0x38d443(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  2647f5:	lea    0x3641ac(%rip),%rcx        # 5c89a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  2647fc:	mov    0xc8(%rsp),%rdi
  264804:	call   *0x38d5ee(%rip)        # 5f1df8 <_DYNAMIC+0x3d8>
  26480a:	jmp    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  26480f:	lea    0x364192(%rip),%rcx        # 5c89a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  264816:	mov    0x88(%rsp),%rdi
  26481e:	call   *0x38d5d4(%rip)        # 5f1df8 <_DYNAMIC+0x3d8>
  264824:	jmp    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  264829:	lea    0x364670(%rip),%rdx        # 5c8ea0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15420>
  264830:	call   *0x38d402(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  264836:	lea    0x36467b(%rip),%rax        # 5c8eb8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15438>
  26483d:	jmp    26487f <<glass::engine::Watch>::print_utf8+0x24df>
  26483f:	lea    0x3646ba(%rip),%rdx        # 5c8f00 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15480>
  264846:	mov    %rbx,%rdi
  264849:	mov    0x70(%rsp),%rsi
  26484e:	call   *0x38d3e4(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  264854:	lea    0x3647c5(%rip),%rdx        # 5c9020 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a0>
  26485b:	call   *0x38d3d7(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  264861:	lea    0x364140(%rip),%rcx        # 5c89a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  264868:	mov    0x48(%rsp),%rdi
  26486d:	call   *0x38d585(%rip)        # 5f1df8 <_DYNAMIC+0x3d8>
  264873:	jmp    2648bf <<glass::engine::Watch>::print_utf8+0x251f>
  264875:	mov    %rax,%rbx
  264878:	lea    0x364651(%rip),%rax        # 5c8ed0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15450>
  26487f:	mov    %rax,0xd8(%rsp)
  264887:	mov    %rbx,%rdi
  26488a:	mov    0x70(%rsp),%rsi
  26488f:	mov    0xd8(%rsp),%rdx
  264897:	call   *0x38d39b(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  26489d:	lea    0x3527c4(%rip),%rdx        # 5b7068 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  2648a4:	mov    %r10,%rdi
  2648a7:	call   *0x38d38b(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  2648ad:	lea    0x3640f4(%rip),%rcx        # 5c89a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  2648b4:	mov    0x48(%rsp),%rdi
  2648b9:	call   *0x38d539(%rip)        # 5f1df8 <_DYNAMIC+0x3d8>
  2648bf:	ud2
  2648c1:	lea    0x3527a0(%rip),%rdx        # 5b7068 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  2648c8:	call   *0x38d36a(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  2648ce:	lea    0x364cd3(%rip),%rdx        # 5c95a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  2648d5:	mov    %r10,%rdi
  2648d8:	call   *0x38d35a(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  2648de:	lea    0x364cab(%rip),%rdx        # 5c9590 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  2648e5:	mov    %r10,%rdi
  2648e8:	call   *0x38d34a(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  2648ee:	mov    %rdx,%rdi
  2648f1:	lea    0x364cb0(%rip),%rdx        # 5c95a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  2648f8:	call   *0x38d33a(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  2648fe:	mov    %rdx,%rdi
  264901:	lea    0x364c88(%rip),%rdx        # 5c9590 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264908:	call   *0x38d32a(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  26490e:	lea    0x352753(%rip),%rdx        # 5b7068 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264915:	mov    %rbp,%rdi
  264918:	call   *0x38d31a(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  26491e:	lea    0x364c6b(%rip),%rdx        # 5c9590 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264925:	mov    %rbp,%rdi
  264928:	call   *0x38d30a(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  26492e:	lea    0x364c5b(%rip),%rdx        # 5c9590 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264935:	mov    %r12,%rdi
  264938:	call   *0x38d2fa(%rip)        # 5f1c38 <_DYNAMIC+0x218>
  26493e:	mov    %rax,%rbx
  264941:	lock decq (%r12)
  264946:	je     26496d <<glass::engine::Watch>::print_utf8+0x25cd>
  264948:	jmp    26497b <<glass::engine::Watch>::print_utf8+0x25db>
  26494a:	mov    %rax,%rbx
  26494d:	lock decq (%r14)
  264951:	je     26496d <<glass::engine::Watch>::print_utf8+0x25cd>
  264953:	jmp    26497b <<glass::engine::Watch>::print_utf8+0x25db>
  264955:	mov    %rax,%rbx
  264958:	mov    0x8(%rsp),%rax
  26495d:	jmp    264967 <<glass::engine::Watch>::print_utf8+0x25c7>
  26495f:	mov    %rax,%rbx
  264962:	mov    0x48(%rsp),%rax
  264967:	lock decq (%rax)
  26496b:	jne    26497b <<glass::engine::Watch>::print_utf8+0x25db>
  26496d:	mov    0x110(%rsp),%rdi
  264975:	call   *0x38d30d(%rip)        # 5f1c88 <_DYNAMIC+0x268>
  26497b:	mov    %rbx,%rdi
  26497e:	call   5b0370 <_Unwind_Resume@plt>
