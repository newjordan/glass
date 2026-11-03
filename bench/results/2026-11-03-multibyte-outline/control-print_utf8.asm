
/tmp/glass-i29-control-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002623a0 <<glass::engine::Watch>::print_utf8>:
  2623a0:	push   %rbp
  2623a1:	push   %r15
  2623a3:	push   %r14
  2623a5:	push   %r13
  2623a7:	push   %r12
  2623a9:	push   %rbx
  2623aa:	sub    $0x118,%rsp
  2623b1:	mov    %rdx,%r13
  2623b4:	mov    %rdi,%r15
  2623b7:	cmpb   $0x1,0xbe(%rdi)
  2623be:	jne    2623eb <<glass::engine::Watch>::print_utf8+0x4b>
  2623c0:	cmpq   $0x0,0x38(%r15)
  2623c5:	jne    2623eb <<glass::engine::Watch>::print_utf8+0x4b>
  2623c7:	mov    0x78(%r15),%rax
  2623cb:	testb  $0x4,0x6c5(%rax)
  2623d2:	jne    2623eb <<glass::engine::Watch>::print_utf8+0x4b>
  2623d4:	cmpq   $0x0,0x50(%rax)
  2623d9:	jne    2623eb <<glass::engine::Watch>::print_utf8+0x4b>
  2623db:	movzwl 0x64(%rax),%ecx
  2623df:	test   $0x460,%ecx
  2623e5:	je     263b10 <<glass::engine::Watch>::print_utf8+0x1770>
  2623eb:	movl   $0x0,0x10(%rsp)
  2623f3:	movl   $0x0,0x80(%rsp)
  2623fe:	mov    $0xffffffff,%r8d
  262404:	xor    %r14d,%r14d
  262407:	lea    0x36665a(%rip),%rax        # 5c8a68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15468>
  26240e:	mov    %rax,0xf0(%rsp)
  262416:	lea    0x40(%rsp),%rax
  26241b:	mov    %rax,0x110(%rsp)
  262423:	xor    %edx,%edx
  262425:	mov    %r13,0xc0(%rsp)
  26242d:	mov    %r15,0xc8(%rsp)
  262435:	mov    %rsi,0x18(%rsp)
  26243a:	cmpb   $0x0,0x80(%rsp)
  262442:	je     262f39 <<glass::engine::Watch>::print_utf8+0xb99>
  262448:	nopl   0x0(%rax,%rax,1)
  262450:	mov    0x78(%r15),%rbx
  262454:	cmpb   $0x0,0x6c(%rbx)
  262458:	jne    262f39 <<glass::engine::Watch>::print_utf8+0xb99>
  26245e:	mov    0x30(%rbx),%eax
  262461:	sub    0x48(%rbx),%eax
  262464:	cltq
  262466:	mov    0x20(%rbx),%rsi
  26246a:	mov    0x28(%rbx),%rcx
  26246e:	lea    (%rcx,%rax,1),%rdi
  262472:	dec    %rdi
  262475:	cmp    %rsi,%rdi
  262478:	mov    $0x0,%eax
  26247d:	cmovae %rsi,%rax
  262481:	sub    %rax,%rdi
  262484:	cmp    %rsi,%rdi
  262487:	jae    2643b4 <<glass::engine::Watch>::print_utf8+0x2014>
  26248d:	mov    0xa0(%rbx),%rax
  262494:	mov    %rax,0x38(%rsp)
  262499:	mov    0x40(%rbx),%r12
  26249d:	mov    0x58(%rbx),%eax
  2624a0:	mov    %eax,0x78(%rsp)
  2624a4:	mov    0x5c(%rbx),%eax
  2624a7:	mov    %eax,0xa0(%rsp)
  2624ae:	movzwl 0x64(%rbx),%eax
  2624b2:	mov    %eax,0xc(%rsp)
  2624b6:	mov    0x18(%rbx),%rax
  2624ba:	shl    $0x6,%rdi
  2624be:	lea    (%rax,%rdi,1),%rbp
  2624c2:	cmp    %r12d,0x38(%rax,%rdi,1)
  2624c7:	jbe    2624cd <<glass::engine::Watch>::print_utf8+0x12d>
  2624c9:	mov    %r12d,0x38(%rbp)
  2624cd:	mov    %rdx,0x28(%rsp)
  2624d2:	mov    0x28(%rbp),%r10d
  2624d6:	cmp    $0xffffffff,%r10d
  2624da:	mov    %r12,0x60(%rsp)
  2624df:	je     262599 <<glass::engine::Watch>::print_utf8+0x1f9>
  2624e5:	mov    0x30(%rbp),%rax
  2624e9:	cmp    %rax,%r12
  2624ec:	mov    $0x0,%ecx
  2624f1:	cmovb  %rax,%rcx
  2624f5:	mov    %rcx,0x20(%rsp)
  2624fa:	movl   $0x20,0x108(%rsp)
  262505:	mov    0x78(%rsp),%ecx
  262509:	mov    %ecx,0x100(%rsp)
  262510:	mov    0xa0(%rsp),%ecx
  262517:	mov    %ecx,0x104(%rsp)
  26251e:	mov    0xc(%rsp),%ecx
  262522:	mov    %cx,0x10c(%rsp)
  26252a:	movq   $0x0,0xf8(%rsp)
  262536:	mov    0x10(%rbp),%rcx
  26253a:	cmp    %rax,%rcx
  26253d:	mov    %rax,%rdx
  262540:	cmovb  %rcx,%rdx
  262544:	mov    %rdx,0x68(%rsp)
  262549:	cmp    %r12,%rcx
  26254c:	mov    %r12,%r9
  26254f:	cmovb  %rcx,%r9
  262553:	mov    0x38f366(%rip),%rdx        # 5f18c0 <_DYNAMIC+0x320>
  26255a:	movzbl (%rdx),%edx
  26255d:	test   %dl,%dl
  26255f:	je     26263a <<glass::engine::Watch>::print_utf8+0x29a>
  262565:	mov    0x38f38c(%rip),%rdx        # 5f18f8 <_DYNAMIC+0x358>
  26256c:	cmp    %r9,%rax
  26256f:	jae    262578 <<glass::engine::Watch>::print_utf8+0x1d8>
  262571:	mov    0x38f388(%rip),%rdx        # 5f1900 <_DYNAMIC+0x360>
  262578:	lock incq 0x28(%rdx)
  26257d:	mov    0x38f354(%rip),%rdx        # 5f18d8 <_DYNAMIC+0x338>
  262584:	lock incq (%rdx)
  262588:	mov    %r9,%rdx
  26258b:	sub    0x68(%rsp),%rdx
  262590:	jne    2625ef <<glass::engine::Watch>::print_utf8+0x24f>
  262592:	xor    %esi,%esi
  262594:	jmp    26262e <<glass::engine::Watch>::print_utf8+0x28e>
  262599:	movl   $0x20,0x108(%rsp)
  2625a4:	mov    0x78(%rsp),%eax
  2625a8:	mov    %eax,0x100(%rsp)
  2625af:	mov    0xa0(%rsp),%eax
  2625b6:	mov    %eax,0x104(%rsp)
  2625bd:	mov    0xc(%rsp),%eax
  2625c1:	mov    %ax,0x10c(%rsp)
  2625c9:	movq   $0x0,0xf8(%rsp)
  2625d5:	lea    0x30(%rbp),%rax
  2625d9:	mov    %rax,0xd8(%rsp)
  2625e1:	movq   $0xffffffffffffffff,0x20(%rsp)
  2625ea:	jmp    2627ca <<glass::engine::Watch>::print_utf8+0x42a>
  2625ef:	mov    0x38f2ea(%rip),%rsi        # 5f18e0 <_DYNAMIC+0x340>
  2625f6:	lock add %rdx,(%rsi)
  2625fa:	cmp    $0x5,%rdx
  2625fe:	jae    26260e <<glass::engine::Watch>::print_utf8+0x26e>
  262600:	lea    -0x204aef(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  262607:	movzbl -0x1(%rdx,%rsi,1),%esi
  26260c:	jmp    26262e <<glass::engine::Watch>::print_utf8+0x28e>
  26260e:	lea    -0x5(%rdx),%rdi
  262612:	mov    $0x4,%esi
  262617:	cmp    $0x4,%rdi
  26261b:	jb     26262e <<glass::engine::Watch>::print_utf8+0x28e>
  26261d:	add    $0xfffffffffffffff7,%rdx
  262621:	cmp    $0x8,%rdx
  262625:	mov    $0x6,%esi
  26262a:	sbb    $0x0,%rsi
  26262e:	mov    0x38f29b(%rip),%rdx        # 5f18d0 <_DYNAMIC+0x330>
  262635:	lock incq (%rdx,%rsi,8)
  26263a:	cmp    %r9,%rax
  26263d:	mov    %r8,0x58(%rsp)
  262642:	jae    26278f <<glass::engine::Watch>::print_utf8+0x3ef>
  262648:	mov    %rbx,0x98(%rsp)
  262650:	mov    %r14,0x30(%rsp)
  262655:	mov    0x20(%rbp),%r13d
  262659:	mov    0x24(%rbp),%esi
  26265c:	movzwl 0x2c(%rbp),%edi
  262660:	mov    0x18(%rbp),%r12
  262664:	test   %r12,%r12
  262667:	je     262674 <<glass::engine::Watch>::print_utf8+0x2d4>
  262669:	lock incq (%r12)
  26266e:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  262674:	mov    %r10d,0x50(%rsp)
  262679:	mov    %r13d,0x48(%rsp)
  26267e:	mov    %esi,0x4c(%rsp)
  262682:	mov    %di,0x54(%rsp)
  262687:	mov    %r12,0x40(%rsp)
  26268c:	mov    0x68(%rsp),%rax
  262691:	lea    0x0(,%rax,8),%rax
  262699:	lea    (%rax,%rax,2),%rax
  26269d:	mov    %rbp,0xd0(%rsp)
  2626a5:	mov    0x8(%rbp),%rbx
  2626a9:	add    %rax,%rbx
  2626ac:	lea    0x0(,%r9,8),%rcx
  2626b4:	lea    (%rcx,%rcx,2),%rbp
  2626b8:	sub    %rax,%rbp
  2626bb:	mov    %esi,0x70(%rsp)
  2626bf:	mov    %di,0x90(%rsp)
  2626c7:	jmp    2626ec <<glass::engine::Watch>::print_utf8+0x34c>
  2626c9:	nopl   0x0(%rax)
  2626d0:	mov    %r12,(%rbx)
  2626d3:	mov    %r13d,0x8(%rbx)
  2626d7:	mov    %esi,0xc(%rbx)
  2626da:	mov    %r10d,0x10(%rbx)
  2626de:	mov    %di,0x14(%rbx)
  2626e2:	add    $0x18,%rbx
  2626e6:	add    $0xffffffffffffffe8,%rbp
  2626ea:	je     262732 <<glass::engine::Watch>::print_utf8+0x392>
  2626ec:	test   %r12,%r12
  2626ef:	je     2626fc <<glass::engine::Watch>::print_utf8+0x35c>
  2626f1:	lock incq (%r12)
  2626f6:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  2626fc:	mov    (%rbx),%rax
  2626ff:	test   %rax,%rax
  262702:	je     2626d0 <<glass::engine::Watch>::print_utf8+0x330>
  262704:	lock decq (%rax)
  262708:	jne    2626d0 <<glass::engine::Watch>::print_utf8+0x330>
  26270a:	mov    %rbx,%rdi
  26270d:	mov    %r9,%r14
  262710:	mov    %r10d,%r15d
  262713:	call   *0x38f0ef(%rip)        # 5f1808 <_DYNAMIC+0x268>
  262719:	movzwl 0x90(%rsp),%edi
  262721:	mov    0x70(%rsp),%esi
  262725:	mov    %r15d,%r10d
  262728:	mov    %r14,%r9
  26272b:	mov    0x58(%rsp),%r8
  262730:	jmp    2626d0 <<glass::engine::Watch>::print_utf8+0x330>
  262732:	mov    0xd0(%rsp),%rbp
  26273a:	mov    0x68(%rsp),%rax
  26273f:	cmp    %eax,0x38(%rbp)
  262742:	jbe    262747 <<glass::engine::Watch>::print_utf8+0x3a7>
  262744:	mov    %eax,0x38(%rbp)
  262747:	test   %r12,%r12
  26274a:	mov    0xc0(%rsp),%r13
  262752:	mov    0xc8(%rsp),%r15
  26275a:	mov    0x30(%rsp),%r14
  26275f:	mov    0x98(%rsp),%rbx
  262767:	je     262786 <<glass::engine::Watch>::print_utf8+0x3e6>
  262769:	lock decq (%r12)
  26276e:	jne    262786 <<glass::engine::Watch>::print_utf8+0x3e6>
  262770:	lea    0x40(%rsp),%rdi
  262775:	mov    %r9,%r12
  262778:	call   *0x38f08a(%rip)        # 5f1808 <_DYNAMIC+0x268>
  26277e:	mov    %r12,%r9
  262781:	mov    0x58(%rsp),%r8
  262786:	mov    0x10(%rbp),%rcx
  26278a:	mov    0x60(%rsp),%r12
  26278f:	lea    0x30(%rbp),%rax
  262793:	mov    %rax,0xd8(%rsp)
  26279b:	cmp    %rcx,%r9
  26279e:	jb     2627ca <<glass::engine::Watch>::print_utf8+0x42a>
  2627a0:	cmpl   $0xffffffff,0x28(%rbp)
  2627a4:	je     2627c3 <<glass::engine::Watch>::print_utf8+0x423>
  2627a6:	lea    0x18(%rbp),%rdi
  2627aa:	mov    (%rdi),%rax
  2627ad:	test   %rax,%rax
  2627b0:	je     2627c3 <<glass::engine::Watch>::print_utf8+0x423>
  2627b2:	lock decq (%rax)
  2627b6:	jne    2627c3 <<glass::engine::Watch>::print_utf8+0x423>
  2627b8:	call   *0x38f04a(%rip)        # 5f1808 <_DYNAMIC+0x268>
  2627be:	mov    0x58(%rsp),%r8
  2627c3:	movl   $0xffffffff,0x28(%rbp)
  2627ca:	mov    0x10(%rbp),%rdx
  2627ce:	mov    0x30(%rbp),%rax
  2627d2:	cmp    %r12,%rdx
  2627d5:	mov    %r12,%rsi
  2627d8:	cmovb  %rdx,%rsi
  2627dc:	cmp    %rax,%rsi
  2627df:	cmova  %rsi,%rax
  2627e3:	mov    %rdx,%rcx
  2627e6:	mov    %rax,0x30(%rbp)
  2627ea:	sub    %r12,%rcx
  2627ed:	mov    %rcx,0x30(%rsp)
  2627f2:	jb     263d3e <<glass::engine::Watch>::print_utf8+0x199e>
  2627f8:	mov    0x28(%rsp),%rdx
  2627fd:	cmp    %r13,%rdx
  262800:	jae    262e00 <<glass::engine::Watch>::print_utf8+0xa60>
  262806:	mov    %rbx,0x98(%rsp)
  26280e:	mov    %rbp,0xd0(%rsp)
  262816:	mov    0x8(%rbp),%rcx
  26281a:	lea    (%r12,%r12,2),%rax
  26281e:	mov    %rcx,0x70(%rsp)
  262823:	lea    (%rcx,%rax,8),%rax
  262827:	mov    %rax,0xb8(%rsp)
  26282f:	mov    0xc(%rsp),%eax
  262833:	mov    %eax,%ecx
  262835:	or     $0x20,%ecx
  262838:	mov    %ecx,0x8c(%rsp)
  26283f:	or     $0x40,%eax
  262842:	mov    %eax,0xa8(%rsp)
  262849:	mov    $0x1,%al
  26284b:	mov    %eax,0x90(%rsp)
  262852:	xor    %r11d,%r11d
  262855:	xor    %edi,%edi
  262857:	mov    %r12,%rbx
  26285a:	mov    %r12,%r10
  26285d:	mov    0x18(%rsp),%rsi
  262862:	jmp    2628cf <<glass::engine::Watch>::print_utf8+0x52f>
  262864:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  262870:	movq   $0x0,(%rbx)
  262877:	mov    0x78(%rsp),%eax
  26287b:	mov    %eax,0x8(%rbx)
  26287e:	mov    0xa0(%rsp),%eax
  262885:	mov    %eax,0xc(%rbx)
  262888:	movl   $0x20,0x10(%rbx)
  26288f:	mov    0xa8(%rsp),%eax
  262896:	mov    %ax,0x14(%rbx)
  26289a:	movl   $0x0,0x90(%rsp)
  2628a5:	xor    %r11d,%r11d
  2628a8:	cmp    0x38(%rsp),%r9
  2628ad:	setae  %r11b
  2628b1:	mov    %r9,%r10
  2628b4:	sub    %r11,%r10
  2628b7:	inc    %rdi
  2628ba:	mov    %r9,%rbx
  2628bd:	add    %r15,%rdx
  2628c0:	mov    %ebp,%r8d
  2628c3:	mov    %r15,%r14
  2628c6:	cmp    %r13,%rdx
  2628c9:	jae    262e1d <<glass::engine::Watch>::print_utf8+0xa7d>
  2628cf:	mov    %rdx,%r15
  2628d2:	movzbl (%rsi,%rdx,1),%ebp
  2628d6:	test   %bpl,%bpl
  2628d9:	js     262900 <<glass::engine::Watch>::print_utf8+0x560>
  2628db:	mov    $0x1,%edx
  2628e0:	lea    -0x7f(%rbp),%eax
  2628e3:	cmp    $0x21,%eax
  2628e6:	jae    262a68 <<glass::engine::Watch>::print_utf8+0x6c8>
  2628ec:	jmp    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  2628f1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262900:	lea    0x3e(%rbp),%eax
  262903:	cmp    $0x1e,%al
  262905:	jae    262930 <<glass::engine::Watch>::print_utf8+0x590>
  262907:	lea    0x1(%r15),%rax
  26290b:	cmp    %r13,%rax
  26290e:	jae    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262914:	movzbl (%rsi,%rax,1),%eax
  262918:	cmp    $0xc0,%al
  26291a:	jge    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262920:	and    $0x1f,%ebp
  262923:	shl    $0x6,%ebp
  262926:	mov    $0x2,%edx
  26292b:	jmp    262a3b <<glass::engine::Watch>::print_utf8+0x69b>
  262930:	mov    %ebp,%eax
  262932:	and    $0xf0,%al
  262934:	cmp    $0xe0,%al
  262936:	jne    262950 <<glass::engine::Watch>::print_utf8+0x5b0>
  262938:	mov    $0xbf,%al
  26293a:	cmp    $0xe0,%ebp
  262940:	je     262973 <<glass::engine::Watch>::print_utf8+0x5d3>
  262942:	mov    $0x80,%cl
  262944:	cmp    $0xed,%ebp
  26294a:	jne    262975 <<glass::engine::Watch>::print_utf8+0x5d5>
  26294c:	mov    $0x9f,%al
  26294e:	jmp    262975 <<glass::engine::Watch>::print_utf8+0x5d5>
  262950:	lea    0x10(%rbp),%eax
  262953:	cmp    $0x5,%al
  262955:	jae    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  26295b:	mov    $0x80,%al
  26295d:	cmp    $0xf4,%ebp
  262963:	je     2629c7 <<glass::engine::Watch>::print_utf8+0x627>
  262965:	mov    $0xbf,%cl
  262967:	cmp    $0xf0,%ebp
  26296d:	jne    2629c9 <<glass::engine::Watch>::print_utf8+0x629>
  26296f:	mov    $0x90,%al
  262971:	jmp    2629c9 <<glass::engine::Watch>::print_utf8+0x629>
  262973:	mov    $0xa0,%cl
  262975:	lea    0x1(%r15),%rdx
  262979:	cmp    %r13,%rdx
  26297c:	jae    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262982:	movzbl (%rsi,%rdx,1),%edx
  262986:	cmp    %dl,%cl
  262988:	ja     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  26298e:	cmp    %al,%dl
  262990:	ja     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262996:	lea    0x2(%r15),%rax
  26299a:	cmp    %r13,%rax
  26299d:	jae    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  2629a3:	movzbl (%rsi,%rax,1),%eax
  2629a7:	cmp    $0xc0,%al
  2629a9:	jge    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  2629af:	movzbl %dl,%ecx
  2629b2:	and    $0x3f,%ecx
  2629b5:	shl    $0x6,%ecx
  2629b8:	and    $0xf,%ebp
  2629bb:	shl    $0xc,%ebp
  2629be:	or     %ecx,%ebp
  2629c0:	mov    $0x3,%edx
  2629c5:	jmp    262a3b <<glass::engine::Watch>::print_utf8+0x69b>
  2629c7:	mov    $0x8f,%cl
  2629c9:	lea    0x1(%r15),%rdx
  2629cd:	cmp    %r13,%rdx
  2629d0:	jae    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  2629d6:	movzbl (%rsi,%rdx,1),%edx
  2629da:	cmp    %dl,%al
  2629dc:	ja     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  2629e2:	cmp    %cl,%dl
  2629e4:	ja     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  2629ea:	lea    0x2(%r15),%rax
  2629ee:	cmp    %r13,%rax
  2629f1:	jae    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  2629f7:	movzbl (%rsi,%rax,1),%ecx
  2629fb:	cmp    $0xbf,%cl
  2629fe:	jg     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262a04:	lea    0x3(%r15),%rax
  262a08:	cmp    %r13,%rax
  262a0b:	jae    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262a11:	movzbl (%rsi,%rax,1),%eax
  262a15:	cmp    $0xbf,%al
  262a17:	jg     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262a1d:	movzbl %dl,%edx
  262a20:	and    $0x3f,%ecx
  262a23:	shl    $0x6,%ecx
  262a26:	and    $0x3f,%edx
  262a29:	shl    $0xc,%edx
  262a2c:	and    $0x7,%ebp
  262a2f:	shl    $0x12,%ebp
  262a32:	or     %edx,%ebp
  262a34:	or     %ecx,%ebp
  262a36:	mov    $0x4,%edx
  262a3b:	mov    %ebp,%ecx
  262a3d:	xor    $0xd800,%ecx
  262a43:	add    $0xffef0000,%ecx
  262a49:	cmp    $0xffef0800,%ecx
  262a4f:	jb     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262a55:	and    $0x3f,%al
  262a57:	movzbl %al,%eax
  262a5a:	or     %eax,%ebp
  262a5c:	lea    -0x7f(%rbp),%eax
  262a5f:	cmp    $0x21,%eax
  262a62:	jb     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262a68:	cmp    $0xffffffff,%r8d
  262a6c:	je     262a90 <<glass::engine::Watch>::print_utf8+0x6f0>
  262a6e:	lea    -0x20(%r8),%eax
  262a72:	cmp    $0x5f,%eax
  262a75:	jae    262aa0 <<glass::engine::Watch>::print_utf8+0x700>
  262a77:	mov    $0x1,%ecx
  262a7c:	cmpb   $0x0,0x10(%rsp)
  262a81:	jne    262b9b <<glass::engine::Watch>::print_utf8+0x7fb>
  262a87:	jmp    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262a8c:	nopl   0x0(%rax)
  262a90:	mov    %rbx,%r9
  262a93:	jmp    2628bd <<glass::engine::Watch>::print_utf8+0x51d>
  262a98:	nopl   0x0(%rax,%rax,1)
  262aa0:	mov    %rbx,0x68(%rsp)
  262aa5:	mov    0x391ccd(%rip),%eax        # 5f4778 <glass::engine::width_of::CACHE+0x10>
  262aab:	test   %eax,%eax
  262aad:	jne    262d8e <<glass::engine::Watch>::print_utf8+0x9ee>
  262ab3:	mov    %r8d,%ebx
  262ab6:	mov    0x391cb3(%rip),%rsi        # 5f4770 <glass::engine::width_of::CACHE+0x8>
  262abd:	cmp    %rbx,%rsi
  262ac0:	jbe    264378 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262ac6:	mov    0x391c9b(%rip),%r12        # 5f4768 <glass::engine::width_of::CACHE>
  262acd:	movzbl (%r12,%rbx,1),%eax
  262ad2:	movzbl %al,%ecx
  262ad5:	test   %cl,%cl
  262ad7:	mov    %rdx,0x28(%rsp)
  262adc:	js     262af7 <<glass::engine::Watch>::print_utf8+0x757>
  262ade:	mov    $0x1,%dl
  262ae0:	mov    0x18(%rsp),%rsi
  262ae5:	test   %dl,%dl
  262ae7:	mov    0x68(%rsp),%rbx
  262aec:	jne    262b83 <<glass::engine::Watch>::print_utf8+0x7e3>
  262af2:	jmp    262e7d <<glass::engine::Watch>::print_utf8+0xadd>
  262af7:	cmp    $0xfe,%ecx
  262afd:	mov    0x18(%rsp),%rsi
  262b02:	je     262e9d <<glass::engine::Watch>::print_utf8+0xafd>
  262b08:	mov    $0xfe,%al
  262b0a:	cmp    $0x7f,%r8d
  262b0e:	jae    262b19 <<glass::engine::Watch>::print_utf8+0x779>
  262b10:	mov    $0x1,%ecx
  262b15:	xor    %edx,%edx
  262b17:	jmp    262b72 <<glass::engine::Watch>::print_utf8+0x7d2>
  262b19:	cmp    $0xa0,%r8d
  262b20:	jb     262b70 <<glass::engine::Watch>::print_utf8+0x7d0>
  262b22:	mov    %rdi,0xb0(%rsp)
  262b2a:	mov    %r8d,%edi
  262b2d:	mov    %r8,0x58(%rsp)
  262b32:	mov    %r10,0xe8(%rsp)
  262b3a:	mov    %r11,0xe0(%rsp)
  262b42:	call   2987d0 <unicode_width::tables::lookup_width>
  262b47:	mov    0xe0(%rsp),%r11
  262b4f:	mov    0xe8(%rsp),%r10
  262b57:	mov    0xb0(%rsp),%rdi
  262b5f:	mov    0x58(%rsp),%r8
  262b64:	mov    0x18(%rsp),%rsi
  262b69:	movzbl %al,%ecx
  262b6c:	mov    $0x1,%dl
  262b6e:	jmp    262b72 <<glass::engine::Watch>::print_utf8+0x7d2>
  262b70:	xor    %edx,%edx
  262b72:	mov    %al,(%r12,%rbx,1)
  262b76:	test   %dl,%dl
  262b78:	mov    0x68(%rsp),%rbx
  262b7d:	je     262e7d <<glass::engine::Watch>::print_utf8+0xadd>
  262b83:	lea    -0x1(%rcx),%rax
  262b87:	cmp    $0x1,%rax
  262b8b:	mov    0x28(%rsp),%rdx
  262b90:	mov    0x60(%rsp),%r12
  262b95:	ja     262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262b9b:	test   $0x1,%r11b
  262b9f:	jne    262e0c <<glass::engine::Watch>::print_utf8+0xa6c>
  262ba5:	lea    (%rcx,%r10,1),%rax
  262ba9:	cmp    0x38(%rsp),%rax
  262bae:	ja     262e11 <<glass::engine::Watch>::print_utf8+0xa71>
  262bb4:	mov    %rax,0x58(%rsp)
  262bb9:	mov    %rbx,%r9
  262bbc:	mov    %r10,%rbx
  262bbf:	sub    %r12,%rbx
  262bc2:	cmp    0x20(%rsp),%r10
  262bc7:	jae    262c30 <<glass::engine::Watch>::print_utf8+0x890>
  262bc9:	cmp    0x30(%rsp),%rbx
  262bce:	mov    0x70(%rsp),%r11
  262bd3:	jae    2643c1 <<glass::engine::Watch>::print_utf8+0x2021>
  262bd9:	lea    (%r10,%r10,2),%rax
  262bdd:	testb  $0x60,0x14(%r11,%rax,8)
  262be3:	jne    262e78 <<glass::engine::Watch>::print_utf8+0xad8>
  262be9:	lea    (%r11,%rax,8),%r12
  262bed:	cmp    $0x2,%rcx
  262bf1:	jne    262cc2 <<glass::engine::Watch>::print_utf8+0x922>
  262bf7:	lea    0x1(%rbx),%rax
  262bfb:	cmp    0x30(%rsp),%rax
  262c00:	jae    2643df <<glass::engine::Watch>::print_utf8+0x203f>
  262c06:	mov    %r14,%rcx
  262c09:	lea    (%rax,%rax,2),%rax
  262c0d:	mov    $0x1,%r14b
  262c10:	mov    0xb8(%rsp),%r13
  262c18:	testb  $0x60,0x14(%r13,%rax,8)
  262c1e:	mov    0x8c(%rsp),%r13d
  262c26:	je     262c5e <<glass::engine::Watch>::print_utf8+0x8be>
  262c28:	jmp    262e82 <<glass::engine::Watch>::print_utf8+0xae2>
  262c2d:	nopl   (%rax)
  262c30:	cmp    0x30(%rsp),%rbx
  262c35:	mov    0x70(%rsp),%r11
  262c3a:	jae    2643f1 <<glass::engine::Watch>::print_utf8+0x2051>
  262c40:	lea    (%r10,%r10,2),%rax
  262c44:	lea    (%r11,%rax,8),%r12
  262c48:	cmp    $0x2,%rcx
  262c4c:	sete   %r14b
  262c50:	mov    0xc(%rsp),%r13d
  262c55:	cmove  0x8c(%rsp),%r13d
  262c5e:	mov    (%r12),%rax
  262c62:	test   %rax,%rax
  262c65:	je     262ce0 <<glass::engine::Watch>::print_utf8+0x940>
  262c67:	lock decq (%rax)
  262c6b:	jne    262ce0 <<glass::engine::Watch>::print_utf8+0x940>
  262c6d:	mov    %rdi,0xb0(%rsp)
  262c75:	mov    %r12,%rdi
  262c78:	mov    %r15,0xe0(%rsp)
  262c80:	mov    %r8,%r15
  262c83:	mov    %rdx,0x28(%rsp)
  262c88:	mov    %r10,0xe8(%rsp)
  262c90:	call   *0x38eb72(%rip)        # 5f1808 <_DYNAMIC+0x268>
  262c96:	mov    0x70(%rsp),%r11
  262c9b:	mov    0xe8(%rsp),%r10
  262ca3:	mov    0xb0(%rsp),%rdi
  262cab:	mov    0x28(%rsp),%rdx
  262cb0:	mov    %r15,%r8
  262cb3:	mov    0xe0(%rsp),%r15
  262cbb:	mov    0x18(%rsp),%rsi
  262cc0:	jmp    262ce0 <<glass::engine::Watch>::print_utf8+0x940>
  262cc2:	xor    %r14d,%r14d
  262cc5:	mov    0xc(%rsp),%r13d
  262cca:	mov    (%r12),%rax
  262cce:	test   %rax,%rax
  262cd1:	jne    262c67 <<glass::engine::Watch>::print_utf8+0x8c7>
  262cd3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262ce0:	lea    (%r10,%r10,2),%rax
  262ce4:	movq   $0x0,(%r12)
  262cec:	mov    0x78(%rsp),%ecx
  262cf0:	mov    %ecx,0x8(%r11,%rax,8)
  262cf5:	mov    0xa0(%rsp),%ecx
  262cfc:	mov    %ecx,0xc(%r11,%rax,8)
  262d01:	mov    %r13w,0x14(%r11,%rax,8)
  262d07:	mov    %r8d,0x10(%r11,%rax,8)
  262d0c:	test   %r14b,%r14b
  262d0f:	mov    0xc0(%rsp),%r13
  262d17:	mov    0x60(%rsp),%r12
  262d1c:	mov    0x58(%rsp),%r9
  262d21:	je     2628a5 <<glass::engine::Watch>::print_utf8+0x505>
  262d27:	inc    %rbx
  262d2a:	cmp    0x30(%rsp),%rbx
  262d2f:	jae    2643ca <<glass::engine::Watch>::print_utf8+0x202a>
  262d35:	lea    (%rbx,%rbx,2),%rax
  262d39:	mov    0xb8(%rsp),%rcx
  262d41:	lea    (%rcx,%rax,8),%rbx
  262d45:	mov    (%rcx,%rax,8),%rax
  262d49:	test   %rax,%rax
  262d4c:	je     262870 <<glass::engine::Watch>::print_utf8+0x4d0>
  262d52:	lock decq (%rax)
  262d56:	jne    262870 <<glass::engine::Watch>::print_utf8+0x4d0>
  262d5c:	mov    %r15,%r13
  262d5f:	mov    %rdi,%r15
  262d62:	mov    %rbx,%rdi
  262d65:	mov    %rdx,%r14
  262d68:	call   *0x38ea9a(%rip)        # 5f1808 <_DYNAMIC+0x268>
  262d6e:	mov    0x58(%rsp),%r9
  262d73:	mov    %r15,%rdi
  262d76:	mov    %r13,%r15
  262d79:	mov    0xc0(%rsp),%r13
  262d81:	mov    %r14,%rdx
  262d84:	mov    0x18(%rsp),%rsi
  262d89:	jmp    262870 <<glass::engine::Watch>::print_utf8+0x4d0>
  262d8e:	mov    %r8,0x58(%rsp)
  262d93:	mov    %r15,0xe0(%rsp)
  262d9b:	mov    %rdx,%r15
  262d9e:	mov    %rdi,0xb0(%rsp)
  262da6:	mov    %r10,0xe8(%rsp)
  262dae:	mov    %r11,%r12
  262db1:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  262db6:	mov    %r12,%r11
  262db9:	mov    0xe8(%rsp),%r10
  262dc1:	mov    0xb0(%rsp),%rdi
  262dc9:	mov    %r15,%rdx
  262dcc:	mov    0xe0(%rsp),%r15
  262dd4:	mov    0x58(%rsp),%r8
  262dd9:	mov    %r8d,%ebx
  262ddc:	mov    0x39198d(%rip),%rsi        # 5f4770 <glass::engine::width_of::CACHE+0x8>
  262de3:	cmp    %rbx,%rsi
  262de6:	ja     262ac6 <<glass::engine::Watch>::print_utf8+0x726>
  262dec:	jmp    264378 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262df1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262e00:	xor    %edi,%edi
  262e02:	xor    %r11d,%r11d
  262e05:	mov    0x18(%rsp),%rsi
  262e0a:	jmp    262e64 <<glass::engine::Watch>::print_utf8+0xac4>
  262e0c:	mov    $0x1,%r11b
  262e0f:	jmp    262e14 <<glass::engine::Watch>::print_utf8+0xa74>
  262e11:	xor    %r11d,%r11d
  262e14:	mov    %rbx,%r9
  262e17:	mov    %r8d,%ebp
  262e1a:	mov    %r15,%rdx
  262e1d:	cmp    %r12,%r9
  262e20:	jbe    262e37 <<glass::engine::Watch>::print_utf8+0xa97>
  262e22:	mov    0xd8(%rsp),%rcx
  262e2a:	mov    (%rcx),%rax
  262e2d:	cmp    %rax,%r9
  262e30:	cmova  %r9,%rax
  262e34:	mov    %rax,(%rcx)
  262e37:	cmp    $0x8,%rdi
  262e3b:	setae  %al
  262e3e:	testb  $0x1,0x90(%rsp)
  262e46:	mov    0xc8(%rsp),%r15
  262e4e:	jne    262e52 <<glass::engine::Watch>::print_utf8+0xab2>
  262e50:	xor    %eax,%eax
  262e52:	test   %al,%al
  262e54:	jne    262eb2 <<glass::engine::Watch>::print_utf8+0xb12>
  262e56:	mov    %r10,%r12
  262e59:	mov    %ebp,%r8d
  262e5c:	mov    0x98(%rsp),%rbx
  262e64:	mov    %r12,0x40(%rbx)
  262e68:	mov    %r11b,0x6c(%rbx)
  262e6c:	add    %rdi,0xa0(%r15)
  262e73:	jmp    262f39 <<glass::engine::Watch>::print_utf8+0xb99>
  262e78:	xor    %r11d,%r11d
  262e7b:	jmp    262e17 <<glass::engine::Watch>::print_utf8+0xa77>
  262e7d:	mov    %rbx,%r9
  262e80:	jmp    262ea2 <<glass::engine::Watch>::print_utf8+0xb02>
  262e82:	xor    %r11d,%r11d
  262e85:	mov    %r8d,%ebp
  262e88:	mov    %r15,%rdx
  262e8b:	mov    0xc0(%rsp),%r13
  262e93:	mov    %rcx,%r14
  262e96:	mov    0x60(%rsp),%r12
  262e9b:	jmp    262e1d <<glass::engine::Watch>::print_utf8+0xa7d>
  262e9d:	mov    0x68(%rsp),%r9
  262ea2:	mov    %r8d,%ebp
  262ea5:	mov    %r15,%rdx
  262ea8:	mov    0x60(%rsp),%r12
  262ead:	jmp    262e1d <<glass::engine::Watch>::print_utf8+0xa7d>
  262eb2:	mov    %rdx,0x28(%rsp)
  262eb7:	movzbl %r11b,%edx
  262ebb:	add    %r10,%rdx
  262ebe:	mov    %rdi,0xb0(%rsp)
  262ec6:	mov    0xd0(%rsp),%rdi
  262ece:	mov    %r12,%rsi
  262ed1:	lea    0xf8(%rsp),%rcx
  262ed9:	mov    %r10,%r12
  262edc:	mov    %r11,%rbx
  262edf:	call   2a1630 <glass::engine::note_uniform_span>
  262ee4:	mov    %rbx,%r11
  262ee7:	mov    0xb0(%rsp),%rdi
  262eef:	mov    0x28(%rsp),%rdx
  262ef4:	mov    0x18(%rsp),%rsi
  262ef9:	jmp    262e59 <<glass::engine::Watch>::print_utf8+0xab9>
  262efe:	xchg   %ax,%ax
  262f00:	mov    0xc8(%rsp),%r15
  262f08:	mov    %r15,%rdi
  262f0b:	mov    %ebp,%esi
  262f0d:	mov    %r8,%rbx
  262f10:	mov    %rdx,%r14
  262f13:	call   33d1b0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  262f18:	mov    %r14,%rdx
  262f1b:	mov    %rbx,%r8
  262f1e:	mov    0x18(%rsp),%rsi
  262f23:	mov    0x30(%rsp),%r14
  262f28:	add    %r14,%rdx
  262f2b:	cmpb   $0x0,0x80(%rsp)
  262f33:	jne    262450 <<glass::engine::Watch>::print_utf8+0xb0>
  262f39:	mov    %r8d,%ebp
  262f3c:	mov    %r14,%rbx
  262f3f:	mov    %rdx,%r14
  262f42:	cmp    %r13,%rdx
  262f45:	jae    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  262f4b:	movzbl (%rsi,%r14,1),%r8d
  262f50:	test   %r8b,%r8b
  262f53:	js     262f70 <<glass::engine::Watch>::print_utf8+0xbd0>
  262f55:	mov    $0x1,%edx
  262f5a:	lea    -0x7f(%r8),%eax
  262f5e:	cmp    $0x21,%eax
  262f61:	jae    2630f8 <<glass::engine::Watch>::print_utf8+0xd58>
  262f67:	jmp    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  262f6c:	nopl   0x0(%rax)
  262f70:	lea    0x3e(%r8),%eax
  262f74:	cmp    $0x1e,%al
  262f76:	jae    262fb0 <<glass::engine::Watch>::print_utf8+0xc10>
  262f78:	lea    0x1(%r14),%rax
  262f7c:	cmp    %r13,%rax
  262f7f:	jae    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  262f85:	movzbl (%rsi,%rax,1),%eax
  262f89:	cmp    $0xc0,%al
  262f8b:	jge    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  262f91:	and    $0x1f,%r8d
  262f95:	shl    $0x6,%r8d
  262f99:	mov    $0x2,%edx
  262f9e:	jmp    2630c8 <<glass::engine::Watch>::print_utf8+0xd28>
  262fa3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262fb0:	mov    %r8d,%eax
  262fb3:	and    $0xf0,%al
  262fb5:	cmp    $0xe0,%al
  262fb7:	jne    262fd3 <<glass::engine::Watch>::print_utf8+0xc33>
  262fb9:	mov    $0xbf,%al
  262fbb:	cmp    $0xe0,%r8d
  262fc2:	je     262ff9 <<glass::engine::Watch>::print_utf8+0xc59>
  262fc4:	mov    $0x80,%cl
  262fc6:	cmp    $0xed,%r8d
  262fcd:	jne    262ffb <<glass::engine::Watch>::print_utf8+0xc5b>
  262fcf:	mov    $0x9f,%al
  262fd1:	jmp    262ffb <<glass::engine::Watch>::print_utf8+0xc5b>
  262fd3:	lea    0x10(%r8),%eax
  262fd7:	cmp    $0x5,%al
  262fd9:	jae    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  262fdf:	mov    $0x80,%al
  262fe1:	cmp    $0xf4,%r8d
  262fe8:	je     263050 <<glass::engine::Watch>::print_utf8+0xcb0>
  262fea:	mov    $0xbf,%cl
  262fec:	cmp    $0xf0,%r8d
  262ff3:	jne    263052 <<glass::engine::Watch>::print_utf8+0xcb2>
  262ff5:	mov    $0x90,%al
  262ff7:	jmp    263052 <<glass::engine::Watch>::print_utf8+0xcb2>
  262ff9:	mov    $0xa0,%cl
  262ffb:	lea    0x1(%r14),%rdx
  262fff:	cmp    %r13,%rdx
  263002:	jae    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  263008:	movzbl (%rsi,%rdx,1),%edx
  26300c:	cmp    %dl,%cl
  26300e:	ja     263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  263014:	cmp    %al,%dl
  263016:	ja     263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  26301c:	lea    0x2(%r14),%rax
  263020:	cmp    %r13,%rax
  263023:	jae    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  263029:	movzbl (%rsi,%rax,1),%eax
  26302d:	cmp    $0xc0,%al
  26302f:	jge    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  263035:	movzbl %dl,%ecx
  263038:	and    $0x3f,%ecx
  26303b:	shl    $0x6,%ecx
  26303e:	and    $0xf,%r8d
  263042:	shl    $0xc,%r8d
  263046:	or     %ecx,%r8d
  263049:	mov    $0x3,%edx
  26304e:	jmp    2630c8 <<glass::engine::Watch>::print_utf8+0xd28>
  263050:	mov    $0x8f,%cl
  263052:	lea    0x1(%r14),%rdx
  263056:	cmp    %r13,%rdx
  263059:	jae    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  26305f:	movzbl (%rsi,%rdx,1),%edx
  263063:	cmp    %dl,%al
  263065:	ja     263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  26306b:	cmp    %cl,%dl
  26306d:	ja     263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  263073:	lea    0x2(%r14),%rax
  263077:	cmp    %r13,%rax
  26307a:	jae    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  263080:	movzbl (%rsi,%rax,1),%ecx
  263084:	cmp    $0xbf,%cl
  263087:	jg     263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  26308d:	lea    0x3(%r14),%rax
  263091:	cmp    %r13,%rax
  263094:	jae    263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  26309a:	movzbl (%rsi,%rax,1),%eax
  26309e:	cmp    $0xbf,%al
  2630a0:	jg     263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  2630a6:	movzbl %dl,%edx
  2630a9:	and    $0x3f,%ecx
  2630ac:	shl    $0x6,%ecx
  2630af:	and    $0x3f,%edx
  2630b2:	shl    $0xc,%edx
  2630b5:	and    $0x7,%r8d
  2630b9:	shl    $0x12,%r8d
  2630bd:	or     %edx,%r8d
  2630c0:	or     %ecx,%r8d
  2630c3:	mov    $0x4,%edx
  2630c8:	mov    %r8d,%ecx
  2630cb:	xor    $0xd800,%ecx
  2630d1:	add    $0xffef0000,%ecx
  2630d7:	cmp    $0xffef0800,%ecx
  2630dd:	jb     263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  2630e3:	and    $0x3f,%al
  2630e5:	movzbl %al,%eax
  2630e8:	or     %eax,%r8d
  2630eb:	lea    -0x7f(%r8),%eax
  2630ef:	cmp    $0x21,%eax
  2630f2:	jb     263a1e <<glass::engine::Watch>::print_utf8+0x167e>
  2630f8:	cmp    $0xffffffff,%ebp
  2630fb:	je     2639e0 <<glass::engine::Watch>::print_utf8+0x1640>
  263101:	mov    %r14,0x30(%rsp)
  263106:	lea    -0x20(%rbp),%eax
  263109:	cmp    $0x5f,%eax
  26310c:	jae    263130 <<glass::engine::Watch>::print_utf8+0xd90>
  26310e:	mov    $0x1,%r12d
  263114:	cmpb   $0x0,0x10(%rsp)
  263119:	je     262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  26311f:	jmp    2631dc <<glass::engine::Watch>::print_utf8+0xe3c>
  263124:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  263130:	cmpb   $0x0,0x80(%rsp)
  263138:	je     262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  26313e:	mov    0x391634(%rip),%eax        # 5f4778 <glass::engine::width_of::CACHE+0x10>
  263144:	test   %eax,%eax
  263146:	jne    2639f6 <<glass::engine::Watch>::print_utf8+0x1656>
  26314c:	mov    %ebp,%ebx
  26314e:	mov    0x39161b(%rip),%rsi        # 5f4770 <glass::engine::width_of::CACHE+0x8>
  263155:	cmp    %rbx,%rsi
  263158:	jbe    264378 <<glass::engine::Watch>::print_utf8+0x1fd8>
  26315e:	mov    0x391603(%rip),%r14        # 5f4768 <glass::engine::width_of::CACHE>
  263165:	movzbl (%r14,%rbx,1),%eax
  26316a:	movzbl %al,%r12d
  26316e:	test   %r12b,%r12b
  263171:	js     26317e <<glass::engine::Watch>::print_utf8+0xdde>
  263173:	mov    $0x1,%cl
  263175:	test   %cl,%cl
  263177:	jne    2631cd <<glass::engine::Watch>::print_utf8+0xe2d>
  263179:	jmp    262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  26317e:	cmp    $0xfe,%r12d
  263185:	je     262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  26318b:	mov    $0xfe,%al
  26318d:	cmp    $0x7f,%ebp
  263190:	jae    26319c <<glass::engine::Watch>::print_utf8+0xdfc>
  263192:	mov    $0x1,%r12d
  263198:	xor    %ecx,%ecx
  26319a:	jmp    2631c1 <<glass::engine::Watch>::print_utf8+0xe21>
  26319c:	cmp    $0xa0,%ebp
  2631a2:	jb     2631bf <<glass::engine::Watch>::print_utf8+0xe1f>
  2631a4:	mov    %ebp,%edi
  2631a6:	mov    %r8,%r15
  2631a9:	mov    %rdx,%r12
  2631ac:	call   2987d0 <unicode_width::tables::lookup_width>
  2631b1:	mov    %r12,%rdx
  2631b4:	mov    %r15,%r8
  2631b7:	movzbl %al,%r12d
  2631bb:	mov    $0x1,%cl
  2631bd:	jmp    2631c1 <<glass::engine::Watch>::print_utf8+0xe21>
  2631bf:	xor    %ecx,%ecx
  2631c1:	mov    %al,(%r14,%rbx,1)
  2631c5:	test   %cl,%cl
  2631c7:	je     262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  2631cd:	lea    -0x1(%r12),%rax
  2631d2:	cmp    $0x1,%rax
  2631d6:	ja     262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  2631dc:	mov    0xc8(%rsp),%rax
  2631e4:	mov    0x78(%rax),%r9
  2631e8:	cmpb   $0x0,0x6c(%r9)
  2631ed:	jne    262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  2631f3:	mov    0x40(%r9),%rbx
  2631f7:	mov    0xa0(%r9),%r11
  2631fe:	lea    (%rbx,%r12,1),%r10
  263202:	cmp    %r11,%r10
  263205:	ja     262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  26320b:	mov    0x30(%r9),%eax
  26320f:	sub    0x48(%r9),%eax
  263213:	cltq
  263215:	mov    0x20(%r9),%rsi
  263219:	mov    0x28(%r9),%rcx
  26321d:	lea    (%rcx,%rax,1),%rdi
  263221:	dec    %rdi
  263224:	cmp    %rsi,%rdi
  263227:	mov    $0x0,%eax
  26322c:	cmovae %rsi,%rax
  263230:	sub    %rax,%rdi
  263233:	cmp    %rsi,%rdi
  263236:	jae    26441b <<glass::engine::Watch>::print_utf8+0x207b>
  26323c:	mov    0x58(%r9),%eax
  263240:	mov    %eax,0x58(%rsp)
  263244:	mov    0x5c(%r9),%eax
  263248:	mov    %eax,0xa0(%rsp)
  26324f:	movzwl 0x64(%r9),%r14d
  263254:	mov    0x18(%r9),%rax
  263258:	shl    $0x6,%rdi
  26325c:	lea    (%rax,%rdi,1),%r15
  263260:	lea    (%rax,%rdi,1),%rcx
  263264:	add    $0x18,%rcx
  263268:	mov    %rcx,0x78(%rsp)
  26326d:	mov    0x28(%rax,%rdi,1),%eax
  263271:	cmp    $0xffffffff,%eax
  263274:	je     263281 <<glass::engine::Watch>::print_utf8+0xee1>
  263276:	mov    0x78(%rsp),%rcx
  26327b:	cmp    0x30(%r15),%rbx
  26327f:	jae    26329a <<glass::engine::Watch>::print_utf8+0xefa>
  263281:	mov    0x10(%r15),%rsi
  263285:	cmp    %rsi,%rbx
  263288:	jae    264428 <<glass::engine::Watch>::print_utf8+0x2088>
  26328e:	lea    (%rbx,%rbx,2),%rcx
  263292:	shl    $0x3,%rcx
  263296:	add    0x8(%r15),%rcx
  26329a:	testb  $0x60,0x14(%rcx)
  26329e:	jne    262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  2632a4:	cmp    $0x2,%r12
  2632a8:	jne    2632e1 <<glass::engine::Watch>::print_utf8+0xf41>
  2632aa:	lea    0x1(%rbx),%rdi
  2632ae:	cmp    $0xffffffff,%eax
  2632b1:	je     2632be <<glass::engine::Watch>::print_utf8+0xf1e>
  2632b3:	mov    0x78(%rsp),%rcx
  2632b8:	cmp    0x30(%r15),%rdi
  2632bc:	jae    2632d7 <<glass::engine::Watch>::print_utf8+0xf37>
  2632be:	mov    0x10(%r15),%rsi
  2632c2:	cmp    %rsi,%rdi
  2632c5:	jae    26444c <<glass::engine::Watch>::print_utf8+0x20ac>
  2632cb:	lea    (%rdi,%rdi,2),%rcx
  2632cf:	shl    $0x3,%rcx
  2632d3:	add    0x8(%r15),%rcx
  2632d7:	testb  $0x60,0x14(%rcx)
  2632db:	jne    262f00 <<glass::engine::Watch>::print_utf8+0xb60>
  2632e1:	mov    %rdx,0x28(%rsp)
  2632e6:	cmp    %ebx,0x38(%r15)
  2632ea:	jbe    2632f0 <<glass::engine::Watch>::print_utf8+0xf50>
  2632ec:	mov    %ebx,0x38(%r15)
  2632f0:	mov    %r14d,0xc(%rsp)
  2632f5:	mov    %r11,0x90(%rsp)
  2632fd:	cmp    $0xffffffff,%eax
  263300:	setne  %dl
  263303:	mov    0x30(%r15),%rcx
  263307:	cmp    %rcx,%rbx
  26330a:	sete   %sil
  26330e:	test   %sil,%dl
  263311:	mov    %rbx,0x20(%rsp)
  263316:	mov    %r15,0x38(%rsp)
  26331b:	mov    %r9,0x60(%rsp)
  263320:	mov    %r10,0x70(%rsp)
  263325:	jne    26339e <<glass::engine::Watch>::print_utf8+0xffe>
  263327:	cmp    $0xffffffff,%eax
  26332a:	mov    0x30(%rsp),%r14
  26332f:	je     2635ed <<glass::engine::Watch>::print_utf8+0x124d>
  263335:	mov    0x10(%r15),%rax
  263339:	cmp    %rcx,%rax
  26333c:	mov    %rcx,%rdx
  26333f:	cmovb  %rax,%rdx
  263343:	mov    %rdx,0xa8(%rsp)
  26334b:	cmp    %rbx,%rax
  26334e:	mov    %rbx,%rsi
  263351:	cmovb  %rax,%rsi
  263355:	mov    0x38e564(%rip),%rdx        # 5f18c0 <_DYNAMIC+0x320>
  26335c:	movzbl (%rdx),%edx
  26335f:	test   %dl,%dl
  263361:	je     26340b <<glass::engine::Watch>::print_utf8+0x106b>
  263367:	mov    0x38e58a(%rip),%rdx        # 5f18f8 <_DYNAMIC+0x358>
  26336e:	mov    %rsi,%r11
  263371:	cmp    %rsi,%rcx
  263374:	jae    26337d <<glass::engine::Watch>::print_utf8+0xfdd>
  263376:	mov    0x38e583(%rip),%rdx        # 5f1900 <_DYNAMIC+0x360>
  26337d:	lock incq 0x28(%rdx)
  263382:	mov    0x38e54f(%rip),%rdx        # 5f18d8 <_DYNAMIC+0x338>
  263389:	lock incq (%rdx)
  26338d:	mov    %r11,%rdx
  263390:	sub    0xa8(%rsp),%rdx
  263398:	jne    2633bd <<glass::engine::Watch>::print_utf8+0x101d>
  26339a:	xor    %esi,%esi
  26339c:	jmp    2633fc <<glass::engine::Watch>::print_utf8+0x105c>
  26339e:	lea    0x1(%rbx),%rax
  2633a2:	mov    %rax,0x30(%r15)
  2633a6:	mov    0x10(%r15),%rsi
  2633aa:	cmp    %rsi,%rbx
  2633ad:	mov    0x30(%rsp),%r14
  2633b2:	jb     26360d <<glass::engine::Watch>::print_utf8+0x126d>
  2633b8:	jmp    264459 <<glass::engine::Watch>::print_utf8+0x20b9>
  2633bd:	mov    0x38e51c(%rip),%rsi        # 5f18e0 <_DYNAMIC+0x340>
  2633c4:	lock add %rdx,(%rsi)
  2633c8:	cmp    $0x5,%rdx
  2633cc:	jae    2633dc <<glass::engine::Watch>::print_utf8+0x103c>
  2633ce:	lea    -0x2058bd(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2633d5:	movzbl -0x1(%rdx,%rsi,1),%esi
  2633da:	jmp    2633fc <<glass::engine::Watch>::print_utf8+0x105c>
  2633dc:	lea    -0x5(%rdx),%rdi
  2633e0:	mov    $0x4,%esi
  2633e5:	cmp    $0x4,%rdi
  2633e9:	jb     2633fc <<glass::engine::Watch>::print_utf8+0x105c>
  2633eb:	add    $0xfffffffffffffff7,%rdx
  2633ef:	cmp    $0x8,%rdx
  2633f3:	mov    $0x6,%esi
  2633f8:	sbb    $0x0,%rsi
  2633fc:	mov    0x38e4cd(%rip),%rdx        # 5f18d0 <_DYNAMIC+0x330>
  263403:	lock incq (%rdx,%rsi,8)
  263408:	mov    %r11,%rsi
  26340b:	cmp    %rsi,%rcx
  26340e:	jae    2635ab <<glass::engine::Watch>::print_utf8+0x120b>
  263414:	mov    0x28(%r15),%edi
  263418:	mov    0x20(%r15),%r10d
  26341c:	mov    0x24(%r15),%r11d
  263420:	movzwl 0x2c(%r15),%ecx
  263425:	mov    0x18(%r15),%rax
  263429:	test   %rax,%rax
  26342c:	mov    %rax,0x68(%rsp)
  263431:	je     263466 <<glass::engine::Watch>::print_utf8+0x10c6>
  263433:	lock incq (%rax)
  263437:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  26343d:	mov    0x10(%r15),%rdx
  263441:	mov    %edi,0x50(%rsp)
  263445:	mov    %r10d,0x48(%rsp)
  26344a:	mov    %r11d,0x4c(%rsp)
  26344f:	mov    %ecx,%r9d
  263452:	mov    %cx,0x54(%rsp)
  263457:	mov    %rax,0x40(%rsp)
  26345c:	cmp    %rdx,%rsi
  26345f:	jbe    263481 <<glass::engine::Watch>::print_utf8+0x10e1>
  263461:	jmp    264388 <<glass::engine::Watch>::print_utf8+0x1fe8>
  263466:	mov    %edi,0x50(%rsp)
  26346a:	mov    %r10d,0x48(%rsp)
  26346f:	mov    %r11d,0x4c(%rsp)
  263474:	mov    %cx,0x54(%rsp)
  263479:	mov    %rax,0x40(%rsp)
  26347e:	mov    %ecx,%r9d
  263481:	mov    0xa8(%rsp),%rax
  263489:	lea    0x0(,%rax,8),%rax
  263491:	lea    (%rax,%rax,2),%rax
  263495:	mov    0x8(%r15),%rbx
  263499:	add    %rax,%rbx
  26349c:	mov    %rsi,0xd0(%rsp)
  2634a4:	lea    0x0(,%rsi,8),%rcx
  2634ac:	lea    (%rcx,%rcx,2),%r14
  2634b0:	sub    %rax,%r14
  2634b3:	mov    0x68(%rsp),%rcx
  2634b8:	mov    %edi,0x98(%rsp)
  2634bf:	mov    %r10d,0x8c(%rsp)
  2634c7:	mov    %r11d,0xb8(%rsp)
  2634cf:	mov    %r9w,0xd8(%rsp)
  2634d8:	jmp    2634fd <<glass::engine::Watch>::print_utf8+0x115d>
  2634da:	nopw   0x0(%rax,%rax,1)
  2634e0:	mov    %rcx,(%rbx)
  2634e3:	mov    %r10d,0x8(%rbx)
  2634e7:	mov    %r11d,0xc(%rbx)
  2634eb:	mov    %edi,0x10(%rbx)
  2634ee:	mov    %r9w,0x14(%rbx)
  2634f3:	add    $0x18,%rbx
  2634f7:	add    $0xffffffffffffffe8,%r14
  2634fb:	je     263555 <<glass::engine::Watch>::print_utf8+0x11b5>
  2634fd:	test   %rcx,%rcx
  263500:	je     26350c <<glass::engine::Watch>::print_utf8+0x116c>
  263502:	lock incq (%rcx)
  263506:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  26350c:	mov    (%rbx),%rax
  26350f:	test   %rax,%rax
  263512:	je     2634e0 <<glass::engine::Watch>::print_utf8+0x1140>
  263514:	lock decq (%rax)
  263518:	jne    2634e0 <<glass::engine::Watch>::print_utf8+0x1140>
  26351a:	mov    %rbx,%rdi
  26351d:	mov    %r8,%r15
  263520:	call   *0x38e2e2(%rip)        # 5f1808 <_DYNAMIC+0x268>
  263526:	movzwl 0xd8(%rsp),%r9d
  26352f:	mov    0xb8(%rsp),%r11d
  263537:	mov    0x8c(%rsp),%r10d
  26353f:	mov    0x98(%rsp),%edi
  263546:	mov    0x68(%rsp),%rcx
  26354b:	mov    %r15,%r8
  26354e:	mov    0x38(%rsp),%r15
  263553:	jmp    2634e0 <<glass::engine::Watch>::print_utf8+0x1140>
  263555:	mov    0xa8(%rsp),%rax
  26355d:	cmp    %eax,0x38(%r15)
  263561:	mov    0x30(%rsp),%r14
  263566:	mov    0x20(%rsp),%rbx
  26356b:	jbe    263571 <<glass::engine::Watch>::print_utf8+0x11d1>
  26356d:	mov    %eax,0x38(%r15)
  263571:	test   %rcx,%rcx
  263574:	mov    0xd0(%rsp),%rsi
  26357c:	je     2635a7 <<glass::engine::Watch>::print_utf8+0x1207>
  26357e:	lock decq (%rcx)
  263582:	jne    2635a7 <<glass::engine::Watch>::print_utf8+0x1207>
  263584:	lea    0x40(%rsp),%rdi
  263589:	mov    %r8,%rbx
  26358c:	call   *0x38e276(%rip)        # 5f1808 <_DYNAMIC+0x268>
  263592:	mov    0xd0(%rsp),%rsi
  26359a:	mov    %rbx,%r8
  26359d:	mov    0x20(%rsp),%rbx
  2635a2:	mov    0x38(%rsp),%r15
  2635a7:	mov    0x10(%r15),%rax
  2635ab:	cmp    %rax,%rsi
  2635ae:	jb     2635ed <<glass::engine::Watch>::print_utf8+0x124d>
  2635b0:	cmpl   $0xffffffff,0x28(%r15)
  2635b5:	je     2635e5 <<glass::engine::Watch>::print_utf8+0x1245>
  2635b7:	mov    0x78(%rsp),%rax
  2635bc:	mov    (%rax),%rax
  2635bf:	test   %rax,%rax
  2635c2:	je     2635e5 <<glass::engine::Watch>::print_utf8+0x1245>
  2635c4:	lock decq (%rax)
  2635c8:	jne    2635e5 <<glass::engine::Watch>::print_utf8+0x1245>
  2635ca:	mov    0x78(%rsp),%rdi
  2635cf:	mov    %r8,%rbx
  2635d2:	call   *0x38e230(%rip)        # 5f1808 <_DYNAMIC+0x268>
  2635d8:	mov    %rbx,%r8
  2635db:	mov    0x20(%rsp),%rbx
  2635e0:	mov    0x38(%rsp),%r15
  2635e5:	movl   $0xffffffff,0x28(%r15)
  2635ed:	mov    0x30(%r15),%rax
  2635f1:	lea    0x1(%rbx),%rcx
  2635f5:	cmp    %rax,%rcx
  2635f8:	cmova  %rcx,%rax
  2635fc:	mov    0x10(%r15),%rsi
  263600:	mov    %rax,0x30(%r15)
  263604:	cmp    %rsi,%rbx
  263607:	jae    264469 <<glass::engine::Watch>::print_utf8+0x20c9>
  26360d:	mov    0xc(%rsp),%esi
  263611:	mov    %esi,%eax
  263613:	or     $0x20,%eax
  263616:	cmp    $0x2,%r12
  26361a:	mov    0x8(%r15),%rcx
  26361e:	lea    (%rbx,%rbx,2),%rdx
  263622:	lea    (%rcx,%rdx,8),%rbx
  263626:	mov    %ebp,0x10(%rcx,%rdx,8)
  26362a:	mov    0x58(%rsp),%ebp
  26362e:	mov    %ebp,0x8(%rcx,%rdx,8)
  263632:	cmovne %esi,%eax
  263635:	mov    0xa0(%rsp),%esi
  26363c:	mov    %esi,0xc(%rcx,%rdx,8)
  263640:	mov    %ax,0x14(%rcx,%rdx,8)
  263645:	mov    (%rcx,%rdx,8),%rax
  263649:	test   %rax,%rax
  26364c:	je     263668 <<glass::engine::Watch>::print_utf8+0x12c8>
  26364e:	lock decq (%rax)
  263652:	jne    263668 <<glass::engine::Watch>::print_utf8+0x12c8>
  263654:	mov    %rbx,%rdi
  263657:	mov    %r8,%r15
  26365a:	call   *0x38e1a8(%rip)        # 5f1808 <_DYNAMIC+0x268>
  263660:	mov    %r15,%r8
  263663:	mov    0x38(%rsp),%r15
  263668:	movq   $0x0,(%rbx)
  26366f:	cmp    $0x2,%r12
  263673:	mov    0x28(%rsp),%rdx
  263678:	jne    2639a8 <<glass::engine::Watch>::print_utf8+0x1608>
  26367e:	mov    0x20(%rsp),%r9
  263683:	lea    0x1(%r9),%r12
  263687:	mov    0x30(%r15),%rax
  26368b:	mov    0x28(%r15),%ecx
  26368f:	cmp    %rax,%r12
  263692:	jne    2636b3 <<glass::engine::Watch>::print_utf8+0x1313>
  263694:	cmp    $0xffffffff,%ecx
  263697:	je     2636b3 <<glass::engine::Watch>::print_utf8+0x1313>
  263699:	add    $0x2,%r9
  26369d:	mov    %r9,0x30(%r15)
  2636a1:	mov    0x10(%r15),%rsi
  2636a5:	cmp    %rsi,%r12
  2636a8:	jb     26394f <<glass::engine::Watch>::print_utf8+0x15af>
  2636ae:	jmp    263d2e <<glass::engine::Watch>::print_utf8+0x198e>
  2636b3:	cmp    $0xffffffff,%ecx
  2636b6:	je     26392f <<glass::engine::Watch>::print_utf8+0x158f>
  2636bc:	mov    0x10(%r15),%rcx
  2636c0:	cmp    %rax,%rcx
  2636c3:	mov    %rax,%rdi
  2636c6:	cmovb  %rcx,%rdi
  2636ca:	cmp    %r12,%rcx
  2636cd:	mov    %r12,%r10
  2636d0:	cmovb  %rcx,%r10
  2636d4:	mov    0x38e1e5(%rip),%rdx        # 5f18c0 <_DYNAMIC+0x320>
  2636db:	movzbl (%rdx),%edx
  2636de:	test   %dl,%dl
  2636e0:	je     26375c <<glass::engine::Watch>::print_utf8+0x13bc>
  2636e2:	mov    0x38e20f(%rip),%rdx        # 5f18f8 <_DYNAMIC+0x358>
  2636e9:	cmp    %r10,%rax
  2636ec:	jae    2636f5 <<glass::engine::Watch>::print_utf8+0x1355>
  2636ee:	mov    0x38e20b(%rip),%rdx        # 5f1900 <_DYNAMIC+0x360>
  2636f5:	lock incq 0x28(%rdx)
  2636fa:	mov    0x38e1d7(%rip),%rdx        # 5f18d8 <_DYNAMIC+0x338>
  263701:	lock incq (%rdx)
  263705:	mov    %r10,%rdx
  263708:	sub    %rdi,%rdx
  26370b:	jne    263711 <<glass::engine::Watch>::print_utf8+0x1371>
  26370d:	xor    %esi,%esi
  26370f:	jmp    263750 <<glass::engine::Watch>::print_utf8+0x13b0>
  263711:	mov    0x38e1c8(%rip),%rsi        # 5f18e0 <_DYNAMIC+0x340>
  263718:	lock add %rdx,(%rsi)
  26371c:	cmp    $0x5,%rdx
  263720:	jae    263730 <<glass::engine::Watch>::print_utf8+0x1390>
  263722:	lea    -0x205c11(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263729:	movzbl -0x1(%rdx,%rsi,1),%esi
  26372e:	jmp    263750 <<glass::engine::Watch>::print_utf8+0x13b0>
  263730:	lea    -0x5(%rdx),%r11
  263734:	mov    $0x4,%esi
  263739:	cmp    $0x4,%r11
  26373d:	jb     263750 <<glass::engine::Watch>::print_utf8+0x13b0>
  26373f:	add    $0xfffffffffffffff7,%rdx
  263743:	cmp    $0x8,%rdx
  263747:	mov    $0x6,%esi
  26374c:	sbb    $0x0,%rsi
  263750:	mov    0x38e179(%rip),%rdx        # 5f18d0 <_DYNAMIC+0x330>
  263757:	lock incq (%rdx,%rsi,8)
  26375c:	cmp    %r10,%rax
  26375f:	mov    0x28(%rsp),%rdx
  263764:	jae    263908 <<glass::engine::Watch>::print_utf8+0x1568>
  26376a:	mov    %r12,0xd8(%rsp)
  263772:	mov    0x28(%r15),%r9d
  263776:	mov    0x20(%r15),%r11d
  26377a:	mov    0x24(%r15),%ebp
  26377e:	movzwl 0x2c(%r15),%eax
  263783:	mov    0x18(%r15),%r12
  263787:	test   %r12,%r12
  26378a:	mov    %r12,0x98(%rsp)
  263792:	mov    %ax,0x68(%rsp)
  263797:	je     2637cd <<glass::engine::Watch>::print_utf8+0x142d>
  263799:	lock incq (%r12)
  26379e:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  2637a4:	mov    0x10(%r15),%rdx
  2637a8:	mov    %r9d,0x50(%rsp)
  2637ad:	mov    %r11d,0x48(%rsp)
  2637b2:	mov    %ebp,0x4c(%rsp)
  2637b6:	mov    %ax,0x54(%rsp)
  2637bb:	mov    %r12,0x40(%rsp)
  2637c0:	cmp    %rdx,%r10
  2637c3:	mov    %r10,%rsi
  2637c6:	jbe    2637e8 <<glass::engine::Watch>::print_utf8+0x1448>
  2637c8:	jmp    2643a2 <<glass::engine::Watch>::print_utf8+0x2002>
  2637cd:	mov    %r9d,0x50(%rsp)
  2637d2:	mov    %r11d,0x48(%rsp)
  2637d7:	mov    %ebp,0x4c(%rsp)
  2637db:	mov    %ax,0x54(%rsp)
  2637e0:	mov    %r12,0x40(%rsp)
  2637e5:	mov    %r10,%rsi
  2637e8:	mov    %rdi,0xa8(%rsp)
  2637f0:	lea    0x0(,%rdi,8),%rax
  2637f8:	lea    (%rax,%rax,2),%rax
  2637fc:	mov    0x8(%r15),%rbx
  263800:	add    %rax,%rbx
  263803:	mov    %rsi,0xb8(%rsp)
  26380b:	lea    0x0(,%rsi,8),%rcx
  263813:	lea    (%rcx,%rcx,2),%r14
  263817:	sub    %rax,%r14
  26381a:	movzwl 0x68(%rsp),%ecx
  26381f:	mov    %ebp,0x8c(%rsp)
  263826:	jmp    26384c <<glass::engine::Watch>::print_utf8+0x14ac>
  263828:	nopl   0x0(%rax,%rax,1)
  263830:	mov    %r12,(%rbx)
  263833:	mov    %r11d,0x8(%rbx)
  263837:	mov    %ebp,0xc(%rbx)
  26383a:	mov    %r9d,0x10(%rbx)
  26383e:	mov    %cx,0x14(%rbx)
  263842:	add    $0x18,%rbx
  263846:	add    $0xffffffffffffffe8,%r14
  26384a:	je     2638a0 <<glass::engine::Watch>::print_utf8+0x1500>
  26384c:	test   %r12,%r12
  26384f:	je     26385c <<glass::engine::Watch>::print_utf8+0x14bc>
  263851:	lock incq (%r12)
  263856:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  26385c:	mov    (%rbx),%rax
  26385f:	test   %rax,%rax
  263862:	je     263830 <<glass::engine::Watch>::print_utf8+0x1490>
  263864:	lock decq (%rax)
  263868:	jne    263830 <<glass::engine::Watch>::print_utf8+0x1490>
  26386a:	mov    %rbx,%rdi
  26386d:	mov    %r8,%r15
  263870:	mov    %r9d,%ebp
  263873:	mov    %r11d,%r12d
  263876:	call   *0x38df8c(%rip)        # 5f1808 <_DYNAMIC+0x268>
  26387c:	movzwl 0x68(%rsp),%ecx
  263881:	mov    %r12d,%r11d
  263884:	mov    0x98(%rsp),%r12
  26388c:	mov    %ebp,%r9d
  26388f:	mov    0x8c(%rsp),%ebp
  263896:	mov    %r15,%r8
  263899:	mov    0x38(%rsp),%r15
  26389e:	jmp    263830 <<glass::engine::Watch>::print_utf8+0x1490>
  2638a0:	mov    0xa8(%rsp),%rax
  2638a8:	cmp    %eax,0x38(%r15)
  2638ac:	mov    0x30(%rsp),%r14
  2638b1:	mov    0x28(%rsp),%rdx
  2638b6:	mov    0x20(%rsp),%r9
  2638bb:	jbe    2638c1 <<glass::engine::Watch>::print_utf8+0x1521>
  2638bd:	mov    %eax,0x38(%r15)
  2638c1:	test   %r12,%r12
  2638c4:	mov    0x58(%rsp),%ebp
  2638c8:	mov    0xb8(%rsp),%r10
  2638d0:	je     2638fc <<glass::engine::Watch>::print_utf8+0x155c>
  2638d2:	lock decq (%r12)
  2638d7:	jne    2638fc <<glass::engine::Watch>::print_utf8+0x155c>
  2638d9:	lea    0x40(%rsp),%rdi
  2638de:	mov    %r8,%rbx
  2638e1:	call   *0x38df21(%rip)        # 5f1808 <_DYNAMIC+0x268>
  2638e7:	mov    0x28(%rsp),%rdx
  2638ec:	mov    %rbx,%r8
  2638ef:	mov    0xb8(%rsp),%r10
  2638f7:	mov    0x20(%rsp),%r9
  2638fc:	mov    0x10(%r15),%rcx
  263900:	mov    0xd8(%rsp),%r12
  263908:	cmp    %rcx,%r10
  26390b:	jb     26392f <<glass::engine::Watch>::print_utf8+0x158f>
  26390d:	mov    0x78(%rsp),%rdi
  263912:	mov    %r8,%rbx
  263915:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26391a:	mov    0x28(%rsp),%rdx
  26391f:	mov    %rbx,%r8
  263922:	mov    0x20(%rsp),%r9
  263927:	movl   $0xffffffff,0x28(%r15)
  26392f:	mov    0x30(%r15),%rax
  263933:	add    $0x2,%r9
  263937:	cmp    %rax,%r9
  26393a:	cmovbe %rax,%r9
  26393e:	mov    0x10(%r15),%rsi
  263942:	mov    %r9,0x30(%r15)
  263946:	cmp    %rsi,%r12
  263949:	jae    264479 <<glass::engine::Watch>::print_utf8+0x20d9>
  26394f:	mov    0x8(%r15),%rax
  263953:	lea    (%r12,%r12,2),%rcx
  263957:	lea    (%rax,%rcx,8),%rbx
  26395b:	movl   $0x20,0x10(%rax,%rcx,8)
  263963:	mov    %ebp,0x8(%rax,%rcx,8)
  263967:	mov    0xa0(%rsp),%esi
  26396e:	mov    %esi,0xc(%rax,%rcx,8)
  263972:	mov    0xc(%rsp),%esi
  263976:	or     $0x40,%esi
  263979:	mov    %si,0x14(%rax,%rcx,8)
  26397e:	mov    (%rax,%rcx,8),%rax
  263982:	test   %rax,%rax
  263985:	je     2639a1 <<glass::engine::Watch>::print_utf8+0x1601>
  263987:	lock decq (%rax)
  26398b:	jne    2639a1 <<glass::engine::Watch>::print_utf8+0x1601>
  26398d:	mov    %rbx,%rdi
  263990:	mov    %r8,%r15
  263993:	call   *0x38de6f(%rip)        # 5f1808 <_DYNAMIC+0x268>
  263999:	mov    0x28(%rsp),%rdx
  26399e:	mov    %r15,%r8
  2639a1:	movq   $0x0,(%rbx)
  2639a8:	mov    0x70(%rsp),%rcx
  2639ad:	cmp    0x90(%rsp),%rcx
  2639b5:	mov    0x18(%rsp),%rsi
  2639ba:	mov    0x60(%rsp),%rax
  2639bf:	jb     2639c8 <<glass::engine::Watch>::print_utf8+0x1628>
  2639c1:	dec    %rcx
  2639c4:	movb   $0x1,0x6c(%rax)
  2639c8:	mov    %rcx,0x40(%rax)
  2639cc:	mov    0xc8(%rsp),%r15
  2639d4:	incq   0xa0(%r15)
  2639db:	nopl   0x0(%rax,%rax,1)
  2639e0:	add    %r14,%rdx
  2639e3:	cmpb   $0x0,0x80(%rsp)
  2639eb:	je     262f39 <<glass::engine::Watch>::print_utf8+0xb99>
  2639f1:	jmp    262450 <<glass::engine::Watch>::print_utf8+0xb0>
  2639f6:	mov    %r8,%rbx
  2639f9:	mov    %rdx,%r14
  2639fc:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263a01:	mov    %r14,%rdx
  263a04:	mov    %rbx,%r8
  263a07:	mov    %ebp,%ebx
  263a09:	mov    0x390d60(%rip),%rsi        # 5f4770 <glass::engine::width_of::CACHE+0x8>
  263a10:	cmp    %rbx,%rsi
  263a13:	ja     26315e <<glass::engine::Watch>::print_utf8+0xdbe>
  263a19:	jmp    264378 <<glass::engine::Watch>::print_utf8+0x1fd8>
  263a1e:	cmpq   $0x400,0xa0(%r15)
  263a29:	jb     263a54 <<glass::engine::Watch>::print_utf8+0x16b4>
  263a2b:	mov    %r15,%rdi
  263a2e:	call   2647f0 <<glass::engine::Watch>::fold_sentinel>
  263a33:	movq   $0x0,0xa0(%r15)
  263a3e:	mov    0x390d3c(%rip),%eax        # 5f4780 <glass::engine::run_whole::ON>
  263a44:	test   %eax,%eax
  263a46:	je     263a5e <<glass::engine::Watch>::print_utf8+0x16be>
  263a48:	call   18ba06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  263a4d:	cmp    %r13,%r14
  263a50:	je     263a63 <<glass::engine::Watch>::print_utf8+0x16c3>
  263a52:	jmp    263a93 <<glass::engine::Watch>::print_utf8+0x16f3>
  263a54:	mov    0x390d26(%rip),%eax        # 5f4780 <glass::engine::run_whole::ON>
  263a5a:	test   %eax,%eax
  263a5c:	jne    263a48 <<glass::engine::Watch>::print_utf8+0x16a8>
  263a5e:	cmp    %r13,%r14
  263a61:	jne    263a93 <<glass::engine::Watch>::print_utf8+0x16f3>
  263a63:	cmpb   $0x0,0x390d1a(%rip)        # 5f4784 <glass::engine::run_whole::ON+0x4>
  263a6a:	je     263a93 <<glass::engine::Watch>::print_utf8+0x16f3>
  263a6c:	cmp    $0xffffffff,%ebp
  263a6f:	je     263c35 <<glass::engine::Watch>::print_utf8+0x1895>
  263a75:	lea    -0x20(%rbp),%eax
  263a78:	cmp    $0x5f,%eax
  263a7b:	jae    263aa4 <<glass::engine::Watch>::print_utf8+0x1704>
  263a7d:	mov    $0x1,%r13d
  263a83:	cmpb   $0x0,0x10(%rsp)
  263a88:	jne    263b6f <<glass::engine::Watch>::print_utf8+0x17cf>
  263a8e:	jmp    263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263a93:	xor    %eax,%eax
  263a95:	cmp    $0xffffffff,%ebp
  263a98:	cmove  %rax,%rbx
  263a9c:	mov    %rbx,%r13
  263a9f:	jmp    263c35 <<glass::engine::Watch>::print_utf8+0x1895>
  263aa4:	cmpb   $0x0,0x80(%rsp)
  263aac:	je     263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263ab2:	mov    0x390cc0(%rip),%eax        # 5f4778 <glass::engine::width_of::CACHE+0x10>
  263ab8:	test   %eax,%eax
  263aba:	jne    264361 <<glass::engine::Watch>::print_utf8+0x1fc1>
  263ac0:	mov    %ebp,%ebx
  263ac2:	mov    0x390ca7(%rip),%rsi        # 5f4770 <glass::engine::width_of::CACHE+0x8>
  263ac9:	cmp    %rbx,%rsi
  263acc:	jbe    264378 <<glass::engine::Watch>::print_utf8+0x1fd8>
  263ad2:	mov    0x390c8f(%rip),%r14        # 5f4768 <glass::engine::width_of::CACHE>
  263ad9:	movzbl (%r14,%rbx,1),%eax
  263ade:	movzbl %al,%r13d
  263ae2:	test   %r13b,%r13b
  263ae5:	js     263af2 <<glass::engine::Watch>::print_utf8+0x1752>
  263ae7:	mov    $0x1,%cl
  263ae9:	test   %cl,%cl
  263aeb:	jne    263b61 <<glass::engine::Watch>::print_utf8+0x17c1>
  263aed:	jmp    263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263af2:	cmp    $0xfe,%r13d
  263af9:	je     263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263aff:	mov    $0xfe,%al
  263b01:	cmp    $0x7f,%ebp
  263b04:	jae    263b3c <<glass::engine::Watch>::print_utf8+0x179c>
  263b06:	mov    $0x1,%r13d
  263b0c:	xor    %ecx,%ecx
  263b0e:	jmp    263b55 <<glass::engine::Watch>::print_utf8+0x17b5>
  263b10:	mov    $0x1,%cl
  263b12:	mov    %ecx,0x80(%rsp)
  263b19:	cmpb   $0x0,0x68(%rax)
  263b1d:	jne    263b2f <<glass::engine::Watch>::print_utf8+0x178f>
  263b1f:	cmpb   $0x0,0x69(%rax)
  263b23:	jne    263b2f <<glass::engine::Watch>::print_utf8+0x178f>
  263b25:	cmpb   $0x0,0x6a(%rax)
  263b29:	je     263d4e <<glass::engine::Watch>::print_utf8+0x19ae>
  263b2f:	movl   $0x0,0x10(%rsp)
  263b37:	jmp    2623fe <<glass::engine::Watch>::print_utf8+0x5e>
  263b3c:	cmp    $0xa0,%ebp
  263b42:	jb     263b53 <<glass::engine::Watch>::print_utf8+0x17b3>
  263b44:	mov    %ebp,%edi
  263b46:	call   2987d0 <unicode_width::tables::lookup_width>
  263b4b:	movzbl %al,%r13d
  263b4f:	mov    $0x1,%cl
  263b51:	jmp    263b55 <<glass::engine::Watch>::print_utf8+0x17b5>
  263b53:	xor    %ecx,%ecx
  263b55:	mov    %al,(%r14,%rbx,1)
  263b59:	test   %cl,%cl
  263b5b:	je     263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263b61:	lea    -0x1(%r13),%rax
  263b65:	cmp    $0x1,%rax
  263b69:	ja     263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263b6f:	mov    0x78(%r15),%r14
  263b73:	cmpb   $0x0,0x6c(%r14)
  263b78:	jne    263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263b7e:	mov    0x40(%r14),%r12
  263b82:	mov    0xa0(%r14),%r8
  263b89:	lea    (%r12,%r13,1),%rdx
  263b8d:	cmp    %r8,%rdx
  263b90:	ja     263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263b96:	mov    0x30(%r14),%eax
  263b9a:	sub    0x48(%r14),%eax
  263b9e:	cltq
  263ba0:	mov    0x20(%r14),%rsi
  263ba4:	mov    0x28(%r14),%rcx
  263ba8:	lea    (%rcx,%rax,1),%rdi
  263bac:	dec    %rdi
  263baf:	xor    %eax,%eax
  263bb1:	cmp    %rsi,%rdi
  263bb4:	cmovae %rsi,%rax
  263bb8:	sub    %rax,%rdi
  263bbb:	cmp    %rsi,%rdi
  263bbe:	jae    26441b <<glass::engine::Watch>::print_utf8+0x207b>
  263bc4:	mov    0x58(%r14),%r10d
  263bc8:	mov    0x5c(%r14),%r11d
  263bcc:	movzwl 0x64(%r14),%r9d
  263bd1:	mov    0x18(%r14),%rax
  263bd5:	shl    $0x6,%rdi
  263bd9:	lea    (%rax,%rdi,1),%rbx
  263bdd:	lea    (%rax,%rdi,1),%rcx
  263be1:	add    $0x18,%rcx
  263be5:	mov    %rcx,0x80(%rsp)
  263bed:	mov    0x28(%rax,%rdi,1),%eax
  263bf1:	cmp    $0xffffffff,%eax
  263bf4:	je     263c04 <<glass::engine::Watch>::print_utf8+0x1864>
  263bf6:	mov    0x80(%rsp),%rcx
  263bfe:	cmp    0x30(%rbx),%r12
  263c02:	jae    263c1d <<glass::engine::Watch>::print_utf8+0x187d>
  263c04:	mov    0x10(%rbx),%rsi
  263c08:	cmp    %rsi,%r12
  263c0b:	jae    264489 <<glass::engine::Watch>::print_utf8+0x20e9>
  263c11:	lea    (%r12,%r12,2),%rcx
  263c15:	shl    $0x3,%rcx
  263c19:	add    0x8(%rbx),%rcx
  263c1d:	testb  $0x60,0x14(%rcx)
  263c21:	je     263c4a <<glass::engine::Watch>::print_utf8+0x18aa>
  263c23:	mov    %r15,%rdi
  263c26:	mov    %ebp,%esi
  263c28:	call   33d1b0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  263c2d:	mov    0xc0(%rsp),%r13
  263c35:	mov    %r13,%rax
  263c38:	add    $0x118,%rsp
  263c3f:	pop    %rbx
  263c40:	pop    %r12
  263c42:	pop    %r13
  263c44:	pop    %r14
  263c46:	pop    %r15
  263c48:	pop    %rbp
  263c49:	ret
  263c4a:	cmp    $0x2,%r13
  263c4e:	jne    263c87 <<glass::engine::Watch>::print_utf8+0x18e7>
  263c50:	lea    0x1(%r12),%rdi
  263c55:	cmp    $0xffffffff,%eax
  263c58:	je     263c68 <<glass::engine::Watch>::print_utf8+0x18c8>
  263c5a:	mov    0x80(%rsp),%rcx
  263c62:	cmp    0x30(%rbx),%rdi
  263c66:	jae    263c81 <<glass::engine::Watch>::print_utf8+0x18e1>
  263c68:	mov    0x10(%rbx),%rsi
  263c6c:	cmp    %rsi,%rdi
  263c6f:	jae    26444c <<glass::engine::Watch>::print_utf8+0x20ac>
  263c75:	lea    (%rdi,%rdi,2),%rcx
  263c79:	shl    $0x3,%rcx
  263c7d:	add    0x8(%rbx),%rcx
  263c81:	testb  $0x60,0x14(%rcx)
  263c85:	jne    263c23 <<glass::engine::Watch>::print_utf8+0x1883>
  263c87:	mov    %r11d,0x78(%rsp)
  263c8c:	mov    %r10d,0x28(%rsp)
  263c91:	mov    %r9d,0x30(%rsp)
  263c96:	mov    %r8,0x58(%rsp)
  263c9b:	mov    %rdx,0xa0(%rsp)
  263ca3:	cmp    %r12d,0x38(%rbx)
  263ca7:	jbe    263cad <<glass::engine::Watch>::print_utf8+0x190d>
  263ca9:	mov    %r12d,0x38(%rbx)
  263cad:	cmp    $0xffffffff,%eax
  263cb0:	setne  %cl
  263cb3:	mov    %rbx,%rdi
  263cb6:	mov    0x30(%rbx),%rbx
  263cba:	cmp    %rbx,%r12
  263cbd:	sete   %dl
  263cc0:	test   %dl,%cl
  263cc2:	mov    %rdi,0x18(%rsp)
  263cc7:	jne    263d15 <<glass::engine::Watch>::print_utf8+0x1975>
  263cc9:	cmp    $0xffffffff,%eax
  263ccc:	je     263f7f <<glass::engine::Watch>::print_utf8+0x1bdf>
  263cd2:	mov    0x18(%rsp),%rax
  263cd7:	mov    0x10(%rax),%r15
  263cdb:	cmp    %rbx,%r15
  263cde:	mov    %rbx,%rax
  263ce1:	cmovb  %r15,%rax
  263ce5:	mov    %rax,0x10(%rsp)
  263cea:	cmp    %r12,%r15
  263ced:	mov    %r12,%rcx
  263cf0:	cmovb  %r15,%rcx
  263cf4:	mov    0x38dbc5(%rip),%rax        # 5f18c0 <_DYNAMIC+0x320>
  263cfb:	movzbl (%rax),%eax
  263cfe:	test   %al,%al
  263d00:	mov    %rcx,0x20(%rsp)
  263d05:	je     263d7c <<glass::engine::Watch>::print_utf8+0x19dc>
  263d07:	cmp    %rcx,%rbx
  263d0a:	jae    263d5e <<glass::engine::Watch>::print_utf8+0x19be>
  263d0c:	mov    0x38dbed(%rip),%rax        # 5f1900 <_DYNAMIC+0x360>
  263d13:	jmp    263d65 <<glass::engine::Watch>::print_utf8+0x19c5>
  263d15:	lea    0x1(%r12),%rax
  263d1a:	mov    %rax,0x30(%rdi)
  263d1e:	mov    0x10(%rdi),%rsi
  263d22:	cmp    %rsi,%r12
  263d25:	mov    %rdi,%rdx
  263d28:	jb     263fa5 <<glass::engine::Watch>::print_utf8+0x1c05>
  263d2e:	lea    0x3653f3(%rip),%rdx        # 5c9128 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  263d35:	mov    %r12,%rdi
  263d38:	call   *0x38da7a(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  263d3e:	lea    0x36533b(%rip),%rcx        # 5c9080 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15a80>
  263d45:	mov    %r12,%rdi
  263d48:	call   *0x38dc2a(%rip)        # 5f1978 <_DYNAMIC+0x3d8>
  263d4e:	cmpb   $0x0,0x6b(%rax)
  263d52:	sete   %al
  263d55:	mov    %eax,0x10(%rsp)
  263d59:	jmp    2623fe <<glass::engine::Watch>::print_utf8+0x5e>
  263d5e:	mov    0x38db93(%rip),%rax        # 5f18f8 <_DYNAMIC+0x358>
  263d65:	lock incq 0x28(%rax)
  263d6a:	mov    %rcx,%rdi
  263d6d:	sub    0x10(%rsp),%rdi
  263d72:	call   2f6d60 <alacritty_terminal::grid::row::fill_census::note>
  263d77:	mov    0x20(%rsp),%rcx
  263d7c:	cmp    %rcx,%rbx
  263d7f:	jae    263f59 <<glass::engine::Watch>::print_utf8+0x1bb9>
  263d85:	mov    0x18(%rsp),%rcx
  263d8a:	mov    0x28(%rcx),%edi
  263d8d:	mov    0x20(%rcx),%r8d
  263d91:	mov    0x24(%rcx),%r9d
  263d95:	movzwl 0x2c(%rcx),%r10d
  263d9a:	mov    0x18(%rcx),%rsi
  263d9e:	test   %rsi,%rsi
  263da1:	mov    %rsi,0x38(%rsp)
  263da6:	mov    %edi,0xc(%rsp)
  263daa:	mov    %r8d,0x60(%rsp)
  263daf:	mov    %r9d,0x70(%rsp)
  263db4:	mov    %r10w,0x90(%rsp)
  263dbd:	je     263e86 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263dc3:	lock incq (%rsi)
  263dc7:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  263dcd:	mov    0x10(%rcx),%rdx
  263dd1:	mov    %edi,0x50(%rsp)
  263dd5:	mov    %r8d,0x48(%rsp)
  263dda:	mov    %r9d,0x4c(%rsp)
  263ddf:	mov    %r10w,0x54(%rsp)
  263de5:	mov    %rsi,0x40(%rsp)
  263dea:	mov    0x20(%rsp),%rsi
  263def:	cmp    %rdx,%rsi
  263df2:	ja     264407 <<glass::engine::Watch>::print_utf8+0x2067>
  263df8:	mov    0x10(%rsp),%rax
  263dfd:	lea    0x0(,%rax,8),%rax
  263e05:	lea    (%rax,%rax,2),%rax
  263e09:	mov    0x8(%rcx),%rbx
  263e0d:	add    %rax,%rbx
  263e10:	lea    0x0(,%rsi,8),%rcx
  263e18:	lea    (%rcx,%rcx,2),%r15
  263e1c:	sub    %rax,%r15
  263e1f:	mov    0x38(%rsp),%rsi
  263e24:	jmp    263e47 <<glass::engine::Watch>::print_utf8+0x1aa7>
  263e26:	mov    %rsi,(%rbx)
  263e29:	mov    %r8d,0x8(%rbx)
  263e2d:	mov    %r9d,0xc(%rbx)
  263e31:	mov    %edi,0x10(%rbx)
  263e34:	mov    %r10w,0x14(%rbx)
  263e39:	add    $0x18,%rbx
  263e3d:	add    $0xffffffffffffffe8,%r15
  263e41:	je     263f23 <<glass::engine::Watch>::print_utf8+0x1b83>
  263e47:	lock incq (%rsi)
  263e4b:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  263e51:	mov    (%rbx),%rax
  263e54:	test   %rax,%rax
  263e57:	je     263e26 <<glass::engine::Watch>::print_utf8+0x1a86>
  263e59:	lock decq (%rax)
  263e5d:	jne    263e26 <<glass::engine::Watch>::print_utf8+0x1a86>
  263e5f:	mov    %rbx,%rdi
  263e62:	call   *0x38d9a0(%rip)        # 5f1808 <_DYNAMIC+0x268>
  263e68:	movzwl 0x90(%rsp),%r10d
  263e71:	mov    0x70(%rsp),%r9d
  263e76:	mov    0x60(%rsp),%r8d
  263e7b:	mov    0xc(%rsp),%edi
  263e7f:	mov    0x38(%rsp),%rsi
  263e84:	jmp    263e26 <<glass::engine::Watch>::print_utf8+0x1a86>
  263e86:	mov    %edi,0x50(%rsp)
  263e8a:	mov    %r8d,0x48(%rsp)
  263e8f:	mov    %r9d,0x4c(%rsp)
  263e94:	mov    %r10w,0x54(%rsp)
  263e9a:	mov    %rsi,0x40(%rsp)
  263e9f:	mov    0x10(%rsp),%rax
  263ea4:	lea    0x0(,%rax,8),%rax
  263eac:	lea    (%rax,%rax,2),%rax
  263eb0:	mov    0x8(%rcx),%rbx
  263eb4:	add    %rax,%rbx
  263eb7:	mov    0x20(%rsp),%rcx
  263ebc:	lea    0x0(,%rcx,8),%rcx
  263ec4:	lea    (%rcx,%rcx,2),%r15
  263ec8:	sub    %rax,%r15
  263ecb:	jmp    263eee <<glass::engine::Watch>::print_utf8+0x1b4e>
  263ecd:	movq   $0x0,(%rbx)
  263ed4:	mov    %r8d,0x8(%rbx)
  263ed8:	mov    %r9d,0xc(%rbx)
  263edc:	mov    %edi,0x10(%rbx)
  263edf:	mov    %r10w,0x14(%rbx)
  263ee4:	add    $0x18,%rbx
  263ee8:	add    $0xffffffffffffffe8,%r15
  263eec:	je     263f23 <<glass::engine::Watch>::print_utf8+0x1b83>
  263eee:	mov    (%rbx),%rax
  263ef1:	test   %rax,%rax
  263ef4:	je     263ecd <<glass::engine::Watch>::print_utf8+0x1b2d>
  263ef6:	lock decq (%rax)
  263efa:	jne    263ecd <<glass::engine::Watch>::print_utf8+0x1b2d>
  263efc:	mov    %rbx,%rdi
  263eff:	call   *0x38d903(%rip)        # 5f1808 <_DYNAMIC+0x268>
  263f05:	movzwl 0x90(%rsp),%r10d
  263f0e:	mov    0x70(%rsp),%r9d
  263f13:	mov    0x60(%rsp),%r8d
  263f18:	mov    0xc(%rsp),%edi
  263f1c:	mov    0x38(%rsp),%rsi
  263f21:	jmp    263ecd <<glass::engine::Watch>::print_utf8+0x1b2d>
  263f23:	mov    0x18(%rsp),%rbx
  263f28:	mov    0x10(%rsp),%rax
  263f2d:	cmp    %eax,0x38(%rbx)
  263f30:	jbe    263f35 <<glass::engine::Watch>::print_utf8+0x1b95>
  263f32:	mov    %eax,0x38(%rbx)
  263f35:	test   %rsi,%rsi
  263f38:	mov    0x20(%rsp),%rcx
  263f3d:	je     263f55 <<glass::engine::Watch>::print_utf8+0x1bb5>
  263f3f:	lock decq (%rsi)
  263f43:	jne    263f55 <<glass::engine::Watch>::print_utf8+0x1bb5>
  263f45:	lea    0x40(%rsp),%rdi
  263f4a:	call   *0x38d8b8(%rip)        # 5f1808 <_DYNAMIC+0x268>
  263f50:	mov    0x20(%rsp),%rcx
  263f55:	mov    0x10(%rbx),%r15
  263f59:	cmp    %r15,%rcx
  263f5c:	mov    0xc8(%rsp),%r15
  263f64:	jb     263f7f <<glass::engine::Watch>::print_utf8+0x1bdf>
  263f66:	mov    0x80(%rsp),%rdi
  263f6e:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263f73:	mov    0x18(%rsp),%rax
  263f78:	movl   $0xffffffff,0x28(%rax)
  263f7f:	mov    0x18(%rsp),%rdx
  263f84:	mov    0x30(%rdx),%rax
  263f88:	lea    0x1(%r12),%rcx
  263f8d:	cmp    %rax,%rcx
  263f90:	cmova  %rcx,%rax
  263f94:	mov    0x10(%rdx),%rsi
  263f98:	mov    %rax,0x30(%rdx)
  263f9c:	cmp    %rsi,%r12
  263f9f:	jae    264479 <<glass::engine::Watch>::print_utf8+0x20d9>
  263fa5:	mov    0x30(%rsp),%esi
  263fa9:	mov    %esi,%eax
  263fab:	or     $0x20,%eax
  263fae:	cmp    $0x2,%r13
  263fb2:	mov    0x8(%rdx),%rcx
  263fb6:	lea    (%r12,%r12,2),%rdx
  263fba:	lea    (%rcx,%rdx,8),%rbx
  263fbe:	mov    %ebp,0x10(%rcx,%rdx,8)
  263fc2:	mov    0x28(%rsp),%edi
  263fc6:	mov    %edi,0x8(%rcx,%rdx,8)
  263fca:	cmovne %esi,%eax
  263fcd:	mov    0x78(%rsp),%esi
  263fd1:	mov    %esi,0xc(%rcx,%rdx,8)
  263fd5:	mov    %ax,0x14(%rcx,%rdx,8)
  263fda:	mov    (%rcx,%rdx,8),%rax
  263fde:	test   %rax,%rax
  263fe1:	je     263ff2 <<glass::engine::Watch>::print_utf8+0x1c52>
  263fe3:	lock decq (%rax)
  263fe7:	jne    263ff2 <<glass::engine::Watch>::print_utf8+0x1c52>
  263fe9:	mov    %rbx,%rdi
  263fec:	call   *0x38d816(%rip)        # 5f1808 <_DYNAMIC+0x268>
  263ff2:	movq   $0x0,(%rbx)
  263ff9:	cmp    $0x2,%r13
  263ffd:	mov    0xc0(%rsp),%r13
  264005:	jne    264333 <<glass::engine::Watch>::print_utf8+0x1f93>
  26400b:	lea    0x1(%r12),%rcx
  264010:	mov    0x18(%rsp),%rax
  264015:	mov    0x30(%rax),%rbx
  264019:	mov    0x28(%rax),%eax
  26401c:	mov    %rcx,0x38(%rsp)
  264021:	cmp    %rbx,%rcx
  264024:	jne    264057 <<glass::engine::Watch>::print_utf8+0x1cb7>
  264026:	cmp    $0xffffffff,%eax
  264029:	je     264057 <<glass::engine::Watch>::print_utf8+0x1cb7>
  26402b:	add    $0x2,%r12
  26402f:	mov    0x18(%rsp),%rcx
  264034:	mov    %r12,0x30(%rcx)
  264038:	mov    0x10(%rcx),%rsi
  26403c:	mov    0x38(%rsp),%rdi
  264041:	cmp    %rsi,%rdi
  264044:	jb     2642e4 <<glass::engine::Watch>::print_utf8+0x1f44>
  26404a:	lea    0x3650d7(%rip),%rdx        # 5c9128 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  264051:	call   *0x38d761(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264057:	cmp    $0xffffffff,%eax
  26405a:	je     2642ba <<glass::engine::Watch>::print_utf8+0x1f1a>
  264060:	mov    0x18(%rsp),%rax
  264065:	mov    0x10(%rax),%r15
  264069:	cmp    %rbx,%r15
  26406c:	mov    %rbx,%rax
  26406f:	cmovb  %r15,%rax
  264073:	mov    %rax,0x10(%rsp)
  264078:	lea    0x1(%r12),%rcx
  26407d:	cmp    %rcx,%r15
  264080:	cmovb  %r15,%rcx
  264084:	mov    0x38d835(%rip),%rax        # 5f18c0 <_DYNAMIC+0x320>
  26408b:	movzbl (%rax),%eax
  26408e:	test   %al,%al
  264090:	mov    %rcx,0x20(%rsp)
  264095:	je     2640c3 <<glass::engine::Watch>::print_utf8+0x1d23>
  264097:	cmp    %rcx,%rbx
  26409a:	jae    2640a5 <<glass::engine::Watch>::print_utf8+0x1d05>
  26409c:	mov    0x38d85d(%rip),%rax        # 5f1900 <_DYNAMIC+0x360>
  2640a3:	jmp    2640ac <<glass::engine::Watch>::print_utf8+0x1d0c>
  2640a5:	mov    0x38d84c(%rip),%rax        # 5f18f8 <_DYNAMIC+0x358>
  2640ac:	lock incq 0x28(%rax)
  2640b1:	mov    %rcx,%rdi
  2640b4:	sub    0x10(%rsp),%rdi
  2640b9:	call   2f6d60 <alacritty_terminal::grid::row::fill_census::note>
  2640be:	mov    0x20(%rsp),%rcx
  2640c3:	cmp    %rcx,%rbx
  2640c6:	jae    264294 <<glass::engine::Watch>::print_utf8+0x1ef4>
  2640cc:	mov    0x18(%rsp),%rcx
  2640d1:	mov    0x28(%rcx),%edi
  2640d4:	mov    0x20(%rcx),%r8d
  2640d8:	mov    0x24(%rcx),%r9d
  2640dc:	movzwl 0x2c(%rcx),%r10d
  2640e1:	mov    0x18(%rcx),%r15
  2640e5:	test   %r15,%r15
  2640e8:	mov    %edi,0xc(%rsp)
  2640ec:	mov    %r8d,0x60(%rsp)
  2640f1:	mov    %r9d,0x70(%rsp)
  2640f6:	mov    %r10w,0x90(%rsp)
  2640ff:	je     2641be <<glass::engine::Watch>::print_utf8+0x1e1e>
  264105:	lock incq (%r15)
  264109:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  26410f:	mov    0x10(%rcx),%rdx
  264113:	mov    %edi,0x50(%rsp)
  264117:	mov    %r8d,0x48(%rsp)
  26411c:	mov    %r9d,0x4c(%rsp)
  264121:	mov    %r10w,0x54(%rsp)
  264127:	mov    %r15,0x40(%rsp)
  26412c:	mov    0x20(%rsp),%rsi
  264131:	cmp    %rdx,%rsi
  264134:	ja     264438 <<glass::engine::Watch>::print_utf8+0x2098>
  26413a:	mov    0x10(%rsp),%rax
  26413f:	lea    0x0(,%rax,8),%rax
  264147:	lea    (%rax,%rax,2),%rax
  26414b:	mov    0x8(%rcx),%rbx
  26414f:	add    %rax,%rbx
  264152:	lea    0x0(,%rsi,8),%rcx
  26415a:	lea    (%rcx,%rcx,2),%r13
  26415e:	sub    %rax,%r13
  264161:	jmp    264184 <<glass::engine::Watch>::print_utf8+0x1de4>
  264163:	mov    %r15,(%rbx)
  264166:	mov    %r8d,0x8(%rbx)
  26416a:	mov    %r9d,0xc(%rbx)
  26416e:	mov    %edi,0x10(%rbx)
  264171:	mov    %r10w,0x14(%rbx)
  264176:	add    $0x18,%rbx
  26417a:	add    $0xffffffffffffffe8,%r13
  26417e:	je     264256 <<glass::engine::Watch>::print_utf8+0x1eb6>
  264184:	lock incq (%r15)
  264188:	jle    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  26418e:	mov    (%rbx),%rax
  264191:	test   %rax,%rax
  264194:	je     264163 <<glass::engine::Watch>::print_utf8+0x1dc3>
  264196:	lock decq (%rax)
  26419a:	jne    264163 <<glass::engine::Watch>::print_utf8+0x1dc3>
  26419c:	mov    %rbx,%rdi
  26419f:	call   *0x38d663(%rip)        # 5f1808 <_DYNAMIC+0x268>
  2641a5:	movzwl 0x90(%rsp),%r10d
  2641ae:	mov    0x70(%rsp),%r9d
  2641b3:	mov    0x60(%rsp),%r8d
  2641b8:	mov    0xc(%rsp),%edi
  2641bc:	jmp    264163 <<glass::engine::Watch>::print_utf8+0x1dc3>
  2641be:	mov    %edi,0x50(%rsp)
  2641c2:	mov    %r8d,0x48(%rsp)
  2641c7:	mov    %r9d,0x4c(%rsp)
  2641cc:	mov    %r10w,0x54(%rsp)
  2641d2:	mov    %r15,0x40(%rsp)
  2641d7:	mov    0x10(%rsp),%rax
  2641dc:	lea    0x0(,%rax,8),%rax
  2641e4:	lea    (%rax,%rax,2),%rax
  2641e8:	mov    0x8(%rcx),%rbx
  2641ec:	add    %rax,%rbx
  2641ef:	mov    0x20(%rsp),%rcx
  2641f4:	lea    0x0(,%rcx,8),%rcx
  2641fc:	lea    (%rcx,%rcx,2),%r13
  264200:	sub    %rax,%r13
  264203:	jmp    264226 <<glass::engine::Watch>::print_utf8+0x1e86>
  264205:	movq   $0x0,(%rbx)
  26420c:	mov    %r8d,0x8(%rbx)
  264210:	mov    %r9d,0xc(%rbx)
  264214:	mov    %edi,0x10(%rbx)
  264217:	mov    %r10w,0x14(%rbx)
  26421c:	add    $0x18,%rbx
  264220:	add    $0xffffffffffffffe8,%r13
  264224:	je     264256 <<glass::engine::Watch>::print_utf8+0x1eb6>
  264226:	mov    (%rbx),%rax
  264229:	test   %rax,%rax
  26422c:	je     264205 <<glass::engine::Watch>::print_utf8+0x1e65>
  26422e:	lock decq (%rax)
  264232:	jne    264205 <<glass::engine::Watch>::print_utf8+0x1e65>
  264234:	mov    %rbx,%rdi
  264237:	call   *0x38d5cb(%rip)        # 5f1808 <_DYNAMIC+0x268>
  26423d:	movzwl 0x90(%rsp),%r10d
  264246:	mov    0x70(%rsp),%r9d
  26424b:	mov    0x60(%rsp),%r8d
  264250:	mov    0xc(%rsp),%edi
  264254:	jmp    264205 <<glass::engine::Watch>::print_utf8+0x1e65>
  264256:	mov    0x18(%rsp),%rbx
  26425b:	mov    0x10(%rsp),%rax
  264260:	cmp    %eax,0x38(%rbx)
  264263:	jbe    264268 <<glass::engine::Watch>::print_utf8+0x1ec8>
  264265:	mov    %eax,0x38(%rbx)
  264268:	test   %r15,%r15
  26426b:	mov    0xc0(%rsp),%r13
  264273:	mov    0x20(%rsp),%rcx
  264278:	je     264290 <<glass::engine::Watch>::print_utf8+0x1ef0>
  26427a:	lock decq (%r15)
  26427e:	jne    264290 <<glass::engine::Watch>::print_utf8+0x1ef0>
  264280:	lea    0x40(%rsp),%rdi
  264285:	call   *0x38d57d(%rip)        # 5f1808 <_DYNAMIC+0x268>
  26428b:	mov    0x20(%rsp),%rcx
  264290:	mov    0x10(%rbx),%r15
  264294:	cmp    %r15,%rcx
  264297:	mov    0xc8(%rsp),%r15
  26429f:	jb     2642ba <<glass::engine::Watch>::print_utf8+0x1f1a>
  2642a1:	mov    0x80(%rsp),%rdi
  2642a9:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2642ae:	mov    0x18(%rsp),%rax
  2642b3:	movl   $0xffffffff,0x28(%rax)
  2642ba:	mov    0x18(%rsp),%rcx
  2642bf:	mov    0x30(%rcx),%rax
  2642c3:	add    $0x2,%r12
  2642c7:	cmp    %rax,%r12
  2642ca:	cmovbe %rax,%r12
  2642ce:	mov    0x10(%rcx),%rsi
  2642d2:	mov    %r12,0x30(%rcx)
  2642d6:	mov    0x38(%rsp),%rdi
  2642db:	cmp    %rsi,%rdi
  2642de:	jae    264499 <<glass::engine::Watch>::print_utf8+0x20f9>
  2642e4:	mov    0x8(%rcx),%rax
  2642e8:	lea    (%rdi,%rdi,2),%rcx
  2642ec:	lea    (%rax,%rcx,8),%rbx
  2642f0:	movl   $0x20,0x10(%rax,%rcx,8)
  2642f8:	mov    0x28(%rsp),%edx
  2642fc:	mov    %edx,0x8(%rax,%rcx,8)
  264300:	mov    0x78(%rsp),%edx
  264304:	mov    %edx,0xc(%rax,%rcx,8)
  264308:	mov    0x30(%rsp),%edx
  26430c:	or     $0x40,%edx
  26430f:	mov    %dx,0x14(%rax,%rcx,8)
  264314:	mov    (%rax,%rcx,8),%rax
  264318:	test   %rax,%rax
  26431b:	je     26432c <<glass::engine::Watch>::print_utf8+0x1f8c>
  26431d:	lock decq (%rax)
  264321:	jne    26432c <<glass::engine::Watch>::print_utf8+0x1f8c>
  264323:	mov    %rbx,%rdi
  264326:	call   *0x38d4dc(%rip)        # 5f1808 <_DYNAMIC+0x268>
  26432c:	movq   $0x0,(%rbx)
  264333:	mov    0xa0(%rsp),%rax
  26433b:	cmp    0x58(%rsp),%rax
  264340:	jb     26434a <<glass::engine::Watch>::print_utf8+0x1faa>
  264342:	dec    %rax
  264345:	movb   $0x1,0x6c(%r14)
  26434a:	mov    %rax,0x40(%r14)
  26434e:	incq   0xa0(%r15)
  264355:	mov    %ebp,0xb0(%r15)
  26435c:	jmp    263c35 <<glass::engine::Watch>::print_utf8+0x1895>
  264361:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  264366:	mov    %ebp,%ebx
  264368:	mov    0x390401(%rip),%rsi        # 5f4770 <glass::engine::width_of::CACHE+0x8>
  26436f:	cmp    %rbx,%rsi
  264372:	ja     263ad2 <<glass::engine::Watch>::print_utf8+0x1732>
  264378:	lea    0x366f99(%rip),%rdx        # 5cb318 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d18>
  26437f:	mov    %rbx,%rdi
  264382:	call   *0x38d430(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264388:	lea    0x364199(%rip),%rcx        # 5c8528 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  26438f:	mov    0xa8(%rsp),%rdi
  264397:	call   *0x38d5db(%rip)        # 5f1978 <_DYNAMIC+0x3d8>
  26439d:	jmp    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  2643a2:	lea    0x36417f(%rip),%rcx        # 5c8528 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  2643a9:	call   *0x38d5c9(%rip)        # 5f1978 <_DYNAMIC+0x3d8>
  2643af:	jmp    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  2643b4:	lea    0x364665(%rip),%rdx        # 5c8a20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15420>
  2643bb:	call   *0x38d3f7(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  2643c1:	lea    0x364670(%rip),%rax        # 5c8a38 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15438>
  2643c8:	jmp    2643e9 <<glass::engine::Watch>::print_utf8+0x2049>
  2643ca:	lea    0x3646af(%rip),%rdx        # 5c8a80 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15480>
  2643d1:	mov    %rbx,%rdi
  2643d4:	mov    0x30(%rsp),%rsi
  2643d9:	call   *0x38d3d9(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  2643df:	mov    %rax,%rbx
  2643e2:	lea    0x364667(%rip),%rax        # 5c8a50 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15450>
  2643e9:	mov    %rax,0xf0(%rsp)
  2643f1:	mov    %rbx,%rdi
  2643f4:	mov    0x30(%rsp),%rsi
  2643f9:	mov    0xf0(%rsp),%rdx
  264401:	call   *0x38d3b1(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264407:	lea    0x36411a(%rip),%rcx        # 5c8528 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  26440e:	mov    0x10(%rsp),%rdi
  264413:	call   *0x38d55f(%rip)        # 5f1978 <_DYNAMIC+0x3d8>
  264419:	jmp    26444a <<glass::engine::Watch>::print_utf8+0x20aa>
  26441b:	lea    0x36477e(%rip),%rdx        # 5c8ba0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a0>
  264422:	call   *0x38d390(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264428:	lea    0x3527b9(%rip),%rdx        # 5b6be8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  26442f:	mov    %rbx,%rdi
  264432:	call   *0x38d380(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264438:	lea    0x3640e9(%rip),%rcx        # 5c8528 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  26443f:	mov    0x10(%rsp),%rdi
  264444:	call   *0x38d52e(%rip)        # 5f1978 <_DYNAMIC+0x3d8>
  26444a:	ud2
  26444c:	lea    0x352795(%rip),%rdx        # 5b6be8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264453:	call   *0x38d35f(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264459:	lea    0x364cc8(%rip),%rdx        # 5c9128 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  264460:	mov    %rbx,%rdi
  264463:	call   *0x38d34f(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264469:	lea    0x364ca0(%rip),%rdx        # 5c9110 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264470:	mov    %rbx,%rdi
  264473:	call   *0x38d33f(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264479:	lea    0x364c90(%rip),%rdx        # 5c9110 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264480:	mov    %r12,%rdi
  264483:	call   *0x38d32f(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264489:	lea    0x352758(%rip),%rdx        # 5b6be8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264490:	mov    %r12,%rdi
  264493:	call   *0x38d31f(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  264499:	lea    0x364c70(%rip),%rdx        # 5c9110 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  2644a0:	call   *0x38d312(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  2644a6:	mov    %rax,%rbx
  2644a9:	lock decq (%r15)
  2644ad:	je     2644d6 <<glass::engine::Watch>::print_utf8+0x2136>
  2644af:	jmp    2644e4 <<glass::engine::Watch>::print_utf8+0x2144>
  2644b1:	mov    %rax,%rbx
  2644b4:	mov    0x38(%rsp),%rax
  2644b9:	jmp    2644d0 <<glass::engine::Watch>::print_utf8+0x2130>
  2644bb:	mov    %rax,%rbx
  2644be:	mov    0x98(%rsp),%rax
  2644c6:	jmp    2644d0 <<glass::engine::Watch>::print_utf8+0x2130>
  2644c8:	mov    %rax,%rbx
  2644cb:	mov    0x68(%rsp),%rax
  2644d0:	lock decq (%rax)
  2644d4:	jne    2644e4 <<glass::engine::Watch>::print_utf8+0x2144>
  2644d6:	mov    0x110(%rsp),%rdi
  2644de:	call   *0x38d324(%rip)        # 5f1808 <_DYNAMIC+0x268>
  2644e4:	mov    %rbx,%rdi
  2644e7:	call   5afef0 <_Unwind_Resume@plt>
