
/tmp/glass-i32-control-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000263410 <<glass::engine::Watch>::print_utf8>:
  263410:	push   %rbp
  263411:	push   %r15
  263413:	push   %r14
  263415:	push   %r13
  263417:	push   %r12
  263419:	push   %rbx
  26341a:	sub    $0x118,%rsp
  263421:	mov    %rdx,%r13
  263424:	mov    %rdi,%r15
  263427:	cmpb   $0x1,0xbe(%rdi)
  26342e:	jne    26345b <<glass::engine::Watch>::print_utf8+0x4b>
  263430:	cmpq   $0x0,0x38(%r15)
  263435:	jne    26345b <<glass::engine::Watch>::print_utf8+0x4b>
  263437:	mov    0x78(%r15),%rax
  26343b:	testb  $0x4,0x6c5(%rax)
  263442:	jne    26345b <<glass::engine::Watch>::print_utf8+0x4b>
  263444:	cmpq   $0x0,0x50(%rax)
  263449:	jne    26345b <<glass::engine::Watch>::print_utf8+0x4b>
  26344b:	movzwl 0x64(%rax),%ecx
  26344f:	test   $0x460,%ecx
  263455:	je     264b80 <<glass::engine::Watch>::print_utf8+0x1770>
  26345b:	movl   $0x0,0x10(%rsp)
  263463:	movl   $0x0,0x80(%rsp)
  26346e:	mov    $0xffffffff,%r8d
  263474:	xor    %r14d,%r14d
  263477:	lea    0x3698aa(%rip),%rax        # 5ccd28 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a8>
  26347e:	mov    %rax,0xf0(%rsp)
  263486:	lea    0x40(%rsp),%rax
  26348b:	mov    %rax,0x110(%rsp)
  263493:	xor    %edx,%edx
  263495:	mov    %r13,0xc0(%rsp)
  26349d:	mov    %r15,0xc8(%rsp)
  2634a5:	mov    %rsi,0x18(%rsp)
  2634aa:	cmpb   $0x0,0x80(%rsp)
  2634b2:	je     263fa9 <<glass::engine::Watch>::print_utf8+0xb99>
  2634b8:	nopl   0x0(%rax,%rax,1)
  2634c0:	mov    0x78(%r15),%rbx
  2634c4:	cmpb   $0x0,0x6c(%rbx)
  2634c8:	jne    263fa9 <<glass::engine::Watch>::print_utf8+0xb99>
  2634ce:	mov    0x30(%rbx),%eax
  2634d1:	sub    0x48(%rbx),%eax
  2634d4:	cltq
  2634d6:	mov    0x20(%rbx),%rsi
  2634da:	mov    0x28(%rbx),%rcx
  2634de:	lea    (%rcx,%rax,1),%rdi
  2634e2:	dec    %rdi
  2634e5:	cmp    %rsi,%rdi
  2634e8:	mov    $0x0,%eax
  2634ed:	cmovae %rsi,%rax
  2634f1:	sub    %rax,%rdi
  2634f4:	cmp    %rsi,%rdi
  2634f7:	jae    265424 <<glass::engine::Watch>::print_utf8+0x2014>
  2634fd:	mov    0xa0(%rbx),%rax
  263504:	mov    %rax,0x38(%rsp)
  263509:	mov    0x40(%rbx),%r12
  26350d:	mov    0x58(%rbx),%eax
  263510:	mov    %eax,0x78(%rsp)
  263514:	mov    0x5c(%rbx),%eax
  263517:	mov    %eax,0xa0(%rsp)
  26351e:	movzwl 0x64(%rbx),%eax
  263522:	mov    %eax,0xc(%rsp)
  263526:	mov    0x18(%rbx),%rax
  26352a:	shl    $0x6,%rdi
  26352e:	lea    (%rax,%rdi,1),%rbp
  263532:	cmp    %r12d,0x38(%rax,%rdi,1)
  263537:	jbe    26353d <<glass::engine::Watch>::print_utf8+0x12d>
  263539:	mov    %r12d,0x38(%rbp)
  26353d:	mov    %rdx,0x28(%rsp)
  263542:	mov    0x28(%rbp),%r10d
  263546:	cmp    $0xffffffff,%r10d
  26354a:	mov    %r12,0x60(%rsp)
  26354f:	je     263609 <<glass::engine::Watch>::print_utf8+0x1f9>
  263555:	mov    0x30(%rbp),%rax
  263559:	cmp    %rax,%r12
  26355c:	mov    $0x0,%ecx
  263561:	cmovb  %rax,%rcx
  263565:	mov    %rcx,0x20(%rsp)
  26356a:	movl   $0x20,0x108(%rsp)
  263575:	mov    0x78(%rsp),%ecx
  263579:	mov    %ecx,0x100(%rsp)
  263580:	mov    0xa0(%rsp),%ecx
  263587:	mov    %ecx,0x104(%rsp)
  26358e:	mov    0xc(%rsp),%ecx
  263592:	mov    %cx,0x10c(%rsp)
  26359a:	movq   $0x0,0xf8(%rsp)
  2635a6:	mov    0x10(%rbp),%rcx
  2635aa:	cmp    %rax,%rcx
  2635ad:	mov    %rax,%rdx
  2635b0:	cmovb  %rcx,%rdx
  2635b4:	mov    %rdx,0x68(%rsp)
  2635b9:	cmp    %r12,%rcx
  2635bc:	mov    %r12,%r9
  2635bf:	cmovb  %rcx,%r9
  2635c3:	mov    0x3927b6(%rip),%rdx        # 5f5d80 <_DYNAMIC+0x320>
  2635ca:	movzbl (%rdx),%edx
  2635cd:	test   %dl,%dl
  2635cf:	je     2636aa <<glass::engine::Watch>::print_utf8+0x29a>
  2635d5:	mov    0x3927dc(%rip),%rdx        # 5f5db8 <_DYNAMIC+0x358>
  2635dc:	cmp    %r9,%rax
  2635df:	jae    2635e8 <<glass::engine::Watch>::print_utf8+0x1d8>
  2635e1:	mov    0x3927d8(%rip),%rdx        # 5f5dc0 <_DYNAMIC+0x360>
  2635e8:	lock incq 0x28(%rdx)
  2635ed:	mov    0x3927a4(%rip),%rdx        # 5f5d98 <_DYNAMIC+0x338>
  2635f4:	lock incq (%rdx)
  2635f8:	mov    %r9,%rdx
  2635fb:	sub    0x68(%rsp),%rdx
  263600:	jne    26365f <<glass::engine::Watch>::print_utf8+0x24f>
  263602:	xor    %esi,%esi
  263604:	jmp    26369e <<glass::engine::Watch>::print_utf8+0x28e>
  263609:	movl   $0x20,0x108(%rsp)
  263614:	mov    0x78(%rsp),%eax
  263618:	mov    %eax,0x100(%rsp)
  26361f:	mov    0xa0(%rsp),%eax
  263626:	mov    %eax,0x104(%rsp)
  26362d:	mov    0xc(%rsp),%eax
  263631:	mov    %ax,0x10c(%rsp)
  263639:	movq   $0x0,0xf8(%rsp)
  263645:	lea    0x30(%rbp),%rax
  263649:	mov    %rax,0xd8(%rsp)
  263651:	movq   $0xffffffffffffffff,0x20(%rsp)
  26365a:	jmp    26383a <<glass::engine::Watch>::print_utf8+0x42a>
  26365f:	mov    0x39273a(%rip),%rsi        # 5f5da0 <_DYNAMIC+0x340>
  263666:	lock add %rdx,(%rsi)
  26366a:	cmp    $0x5,%rdx
  26366e:	jae    26367e <<glass::engine::Watch>::print_utf8+0x26e>
  263670:	lea    -0x205497(%rip),%rsi        # 5e1e0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263677:	movzbl -0x1(%rdx,%rsi,1),%esi
  26367c:	jmp    26369e <<glass::engine::Watch>::print_utf8+0x28e>
  26367e:	lea    -0x5(%rdx),%rdi
  263682:	mov    $0x4,%esi
  263687:	cmp    $0x4,%rdi
  26368b:	jb     26369e <<glass::engine::Watch>::print_utf8+0x28e>
  26368d:	add    $0xfffffffffffffff7,%rdx
  263691:	cmp    $0x8,%rdx
  263695:	mov    $0x6,%esi
  26369a:	sbb    $0x0,%rsi
  26369e:	mov    0x3926eb(%rip),%rdx        # 5f5d90 <_DYNAMIC+0x330>
  2636a5:	lock incq (%rdx,%rsi,8)
  2636aa:	cmp    %r9,%rax
  2636ad:	mov    %r8,0x58(%rsp)
  2636b2:	jae    2637ff <<glass::engine::Watch>::print_utf8+0x3ef>
  2636b8:	mov    %rbx,0x98(%rsp)
  2636c0:	mov    %r14,0x30(%rsp)
  2636c5:	mov    0x20(%rbp),%r13d
  2636c9:	mov    0x24(%rbp),%esi
  2636cc:	movzwl 0x2c(%rbp),%edi
  2636d0:	mov    0x18(%rbp),%r12
  2636d4:	test   %r12,%r12
  2636d7:	je     2636e4 <<glass::engine::Watch>::print_utf8+0x2d4>
  2636d9:	lock incq (%r12)
  2636de:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  2636e4:	mov    %r10d,0x50(%rsp)
  2636e9:	mov    %r13d,0x48(%rsp)
  2636ee:	mov    %esi,0x4c(%rsp)
  2636f2:	mov    %di,0x54(%rsp)
  2636f7:	mov    %r12,0x40(%rsp)
  2636fc:	mov    0x68(%rsp),%rax
  263701:	lea    0x0(,%rax,8),%rax
  263709:	lea    (%rax,%rax,2),%rax
  26370d:	mov    %rbp,0xd0(%rsp)
  263715:	mov    0x8(%rbp),%rbx
  263719:	add    %rax,%rbx
  26371c:	lea    0x0(,%r9,8),%rcx
  263724:	lea    (%rcx,%rcx,2),%rbp
  263728:	sub    %rax,%rbp
  26372b:	mov    %esi,0x70(%rsp)
  26372f:	mov    %di,0x90(%rsp)
  263737:	jmp    26375c <<glass::engine::Watch>::print_utf8+0x34c>
  263739:	nopl   0x0(%rax)
  263740:	mov    %r12,(%rbx)
  263743:	mov    %r13d,0x8(%rbx)
  263747:	mov    %esi,0xc(%rbx)
  26374a:	mov    %r10d,0x10(%rbx)
  26374e:	mov    %di,0x14(%rbx)
  263752:	add    $0x18,%rbx
  263756:	add    $0xffffffffffffffe8,%rbp
  26375a:	je     2637a2 <<glass::engine::Watch>::print_utf8+0x392>
  26375c:	test   %r12,%r12
  26375f:	je     26376c <<glass::engine::Watch>::print_utf8+0x35c>
  263761:	lock incq (%r12)
  263766:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  26376c:	mov    (%rbx),%rax
  26376f:	test   %rax,%rax
  263772:	je     263740 <<glass::engine::Watch>::print_utf8+0x330>
  263774:	lock decq (%rax)
  263778:	jne    263740 <<glass::engine::Watch>::print_utf8+0x330>
  26377a:	mov    %rbx,%rdi
  26377d:	mov    %r9,%r14
  263780:	mov    %r10d,%r15d
  263783:	call   *0x39253f(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  263789:	movzwl 0x90(%rsp),%edi
  263791:	mov    0x70(%rsp),%esi
  263795:	mov    %r15d,%r10d
  263798:	mov    %r14,%r9
  26379b:	mov    0x58(%rsp),%r8
  2637a0:	jmp    263740 <<glass::engine::Watch>::print_utf8+0x330>
  2637a2:	mov    0xd0(%rsp),%rbp
  2637aa:	mov    0x68(%rsp),%rax
  2637af:	cmp    %eax,0x38(%rbp)
  2637b2:	jbe    2637b7 <<glass::engine::Watch>::print_utf8+0x3a7>
  2637b4:	mov    %eax,0x38(%rbp)
  2637b7:	test   %r12,%r12
  2637ba:	mov    0xc0(%rsp),%r13
  2637c2:	mov    0xc8(%rsp),%r15
  2637ca:	mov    0x30(%rsp),%r14
  2637cf:	mov    0x98(%rsp),%rbx
  2637d7:	je     2637f6 <<glass::engine::Watch>::print_utf8+0x3e6>
  2637d9:	lock decq (%r12)
  2637de:	jne    2637f6 <<glass::engine::Watch>::print_utf8+0x3e6>
  2637e0:	lea    0x40(%rsp),%rdi
  2637e5:	mov    %r9,%r12
  2637e8:	call   *0x3924da(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  2637ee:	mov    %r12,%r9
  2637f1:	mov    0x58(%rsp),%r8
  2637f6:	mov    0x10(%rbp),%rcx
  2637fa:	mov    0x60(%rsp),%r12
  2637ff:	lea    0x30(%rbp),%rax
  263803:	mov    %rax,0xd8(%rsp)
  26380b:	cmp    %rcx,%r9
  26380e:	jb     26383a <<glass::engine::Watch>::print_utf8+0x42a>
  263810:	cmpl   $0xffffffff,0x28(%rbp)
  263814:	je     263833 <<glass::engine::Watch>::print_utf8+0x423>
  263816:	lea    0x18(%rbp),%rdi
  26381a:	mov    (%rdi),%rax
  26381d:	test   %rax,%rax
  263820:	je     263833 <<glass::engine::Watch>::print_utf8+0x423>
  263822:	lock decq (%rax)
  263826:	jne    263833 <<glass::engine::Watch>::print_utf8+0x423>
  263828:	call   *0x39249a(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  26382e:	mov    0x58(%rsp),%r8
  263833:	movl   $0xffffffff,0x28(%rbp)
  26383a:	mov    0x10(%rbp),%rdx
  26383e:	mov    0x30(%rbp),%rax
  263842:	cmp    %r12,%rdx
  263845:	mov    %r12,%rsi
  263848:	cmovb  %rdx,%rsi
  26384c:	cmp    %rax,%rsi
  26384f:	cmova  %rsi,%rax
  263853:	mov    %rdx,%rcx
  263856:	mov    %rax,0x30(%rbp)
  26385a:	sub    %r12,%rcx
  26385d:	mov    %rcx,0x30(%rsp)
  263862:	jb     264dae <<glass::engine::Watch>::print_utf8+0x199e>
  263868:	mov    0x28(%rsp),%rdx
  26386d:	cmp    %r13,%rdx
  263870:	jae    263e70 <<glass::engine::Watch>::print_utf8+0xa60>
  263876:	mov    %rbx,0x98(%rsp)
  26387e:	mov    %rbp,0xd0(%rsp)
  263886:	mov    0x8(%rbp),%rcx
  26388a:	lea    (%r12,%r12,2),%rax
  26388e:	mov    %rcx,0x70(%rsp)
  263893:	lea    (%rcx,%rax,8),%rax
  263897:	mov    %rax,0xb8(%rsp)
  26389f:	mov    0xc(%rsp),%eax
  2638a3:	mov    %eax,%ecx
  2638a5:	or     $0x20,%ecx
  2638a8:	mov    %ecx,0x8c(%rsp)
  2638af:	or     $0x40,%eax
  2638b2:	mov    %eax,0xa8(%rsp)
  2638b9:	mov    $0x1,%al
  2638bb:	mov    %eax,0x90(%rsp)
  2638c2:	xor    %r11d,%r11d
  2638c5:	xor    %edi,%edi
  2638c7:	mov    %r12,%rbx
  2638ca:	mov    %r12,%r10
  2638cd:	mov    0x18(%rsp),%rsi
  2638d2:	jmp    26393f <<glass::engine::Watch>::print_utf8+0x52f>
  2638d4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  2638e0:	movq   $0x0,(%rbx)
  2638e7:	mov    0x78(%rsp),%eax
  2638eb:	mov    %eax,0x8(%rbx)
  2638ee:	mov    0xa0(%rsp),%eax
  2638f5:	mov    %eax,0xc(%rbx)
  2638f8:	movl   $0x20,0x10(%rbx)
  2638ff:	mov    0xa8(%rsp),%eax
  263906:	mov    %ax,0x14(%rbx)
  26390a:	movl   $0x0,0x90(%rsp)
  263915:	xor    %r11d,%r11d
  263918:	cmp    0x38(%rsp),%r9
  26391d:	setae  %r11b
  263921:	mov    %r9,%r10
  263924:	sub    %r11,%r10
  263927:	inc    %rdi
  26392a:	mov    %r9,%rbx
  26392d:	add    %r15,%rdx
  263930:	mov    %ebp,%r8d
  263933:	mov    %r15,%r14
  263936:	cmp    %r13,%rdx
  263939:	jae    263e8d <<glass::engine::Watch>::print_utf8+0xa7d>
  26393f:	mov    %rdx,%r15
  263942:	movzbl (%rsi,%rdx,1),%ebp
  263946:	test   %bpl,%bpl
  263949:	js     263970 <<glass::engine::Watch>::print_utf8+0x560>
  26394b:	mov    $0x1,%edx
  263950:	lea    -0x7f(%rbp),%eax
  263953:	cmp    $0x21,%eax
  263956:	jae    263ad8 <<glass::engine::Watch>::print_utf8+0x6c8>
  26395c:	jmp    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263961:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  263970:	lea    0x3e(%rbp),%eax
  263973:	cmp    $0x1e,%al
  263975:	jae    2639a0 <<glass::engine::Watch>::print_utf8+0x590>
  263977:	lea    0x1(%r15),%rax
  26397b:	cmp    %r13,%rax
  26397e:	jae    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263984:	movzbl (%rsi,%rax,1),%eax
  263988:	cmp    $0xc0,%al
  26398a:	jge    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263990:	and    $0x1f,%ebp
  263993:	shl    $0x6,%ebp
  263996:	mov    $0x2,%edx
  26399b:	jmp    263aab <<glass::engine::Watch>::print_utf8+0x69b>
  2639a0:	mov    %ebp,%eax
  2639a2:	and    $0xf0,%al
  2639a4:	cmp    $0xe0,%al
  2639a6:	jne    2639c0 <<glass::engine::Watch>::print_utf8+0x5b0>
  2639a8:	mov    $0xbf,%al
  2639aa:	cmp    $0xe0,%ebp
  2639b0:	je     2639e3 <<glass::engine::Watch>::print_utf8+0x5d3>
  2639b2:	mov    $0x80,%cl
  2639b4:	cmp    $0xed,%ebp
  2639ba:	jne    2639e5 <<glass::engine::Watch>::print_utf8+0x5d5>
  2639bc:	mov    $0x9f,%al
  2639be:	jmp    2639e5 <<glass::engine::Watch>::print_utf8+0x5d5>
  2639c0:	lea    0x10(%rbp),%eax
  2639c3:	cmp    $0x5,%al
  2639c5:	jae    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  2639cb:	mov    $0x80,%al
  2639cd:	cmp    $0xf4,%ebp
  2639d3:	je     263a37 <<glass::engine::Watch>::print_utf8+0x627>
  2639d5:	mov    $0xbf,%cl
  2639d7:	cmp    $0xf0,%ebp
  2639dd:	jne    263a39 <<glass::engine::Watch>::print_utf8+0x629>
  2639df:	mov    $0x90,%al
  2639e1:	jmp    263a39 <<glass::engine::Watch>::print_utf8+0x629>
  2639e3:	mov    $0xa0,%cl
  2639e5:	lea    0x1(%r15),%rdx
  2639e9:	cmp    %r13,%rdx
  2639ec:	jae    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  2639f2:	movzbl (%rsi,%rdx,1),%edx
  2639f6:	cmp    %dl,%cl
  2639f8:	ja     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  2639fe:	cmp    %al,%dl
  263a00:	ja     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a06:	lea    0x2(%r15),%rax
  263a0a:	cmp    %r13,%rax
  263a0d:	jae    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a13:	movzbl (%rsi,%rax,1),%eax
  263a17:	cmp    $0xc0,%al
  263a19:	jge    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a1f:	movzbl %dl,%ecx
  263a22:	and    $0x3f,%ecx
  263a25:	shl    $0x6,%ecx
  263a28:	and    $0xf,%ebp
  263a2b:	shl    $0xc,%ebp
  263a2e:	or     %ecx,%ebp
  263a30:	mov    $0x3,%edx
  263a35:	jmp    263aab <<glass::engine::Watch>::print_utf8+0x69b>
  263a37:	mov    $0x8f,%cl
  263a39:	lea    0x1(%r15),%rdx
  263a3d:	cmp    %r13,%rdx
  263a40:	jae    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a46:	movzbl (%rsi,%rdx,1),%edx
  263a4a:	cmp    %dl,%al
  263a4c:	ja     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a52:	cmp    %cl,%dl
  263a54:	ja     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a5a:	lea    0x2(%r15),%rax
  263a5e:	cmp    %r13,%rax
  263a61:	jae    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a67:	movzbl (%rsi,%rax,1),%ecx
  263a6b:	cmp    $0xbf,%cl
  263a6e:	jg     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a74:	lea    0x3(%r15),%rax
  263a78:	cmp    %r13,%rax
  263a7b:	jae    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a81:	movzbl (%rsi,%rax,1),%eax
  263a85:	cmp    $0xbf,%al
  263a87:	jg     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263a8d:	movzbl %dl,%edx
  263a90:	and    $0x3f,%ecx
  263a93:	shl    $0x6,%ecx
  263a96:	and    $0x3f,%edx
  263a99:	shl    $0xc,%edx
  263a9c:	and    $0x7,%ebp
  263a9f:	shl    $0x12,%ebp
  263aa2:	or     %edx,%ebp
  263aa4:	or     %ecx,%ebp
  263aa6:	mov    $0x4,%edx
  263aab:	mov    %ebp,%ecx
  263aad:	xor    $0xd800,%ecx
  263ab3:	add    $0xffef0000,%ecx
  263ab9:	cmp    $0xffef0800,%ecx
  263abf:	jb     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263ac5:	and    $0x3f,%al
  263ac7:	movzbl %al,%eax
  263aca:	or     %eax,%ebp
  263acc:	lea    -0x7f(%rbp),%eax
  263acf:	cmp    $0x21,%eax
  263ad2:	jb     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263ad8:	cmp    $0xffffffff,%r8d
  263adc:	je     263b00 <<glass::engine::Watch>::print_utf8+0x6f0>
  263ade:	lea    -0x20(%r8),%eax
  263ae2:	cmp    $0x5f,%eax
  263ae5:	jae    263b10 <<glass::engine::Watch>::print_utf8+0x700>
  263ae7:	mov    $0x1,%ecx
  263aec:	cmpb   $0x0,0x10(%rsp)
  263af1:	jne    263c0b <<glass::engine::Watch>::print_utf8+0x7fb>
  263af7:	jmp    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263afc:	nopl   0x0(%rax)
  263b00:	mov    %rbx,%r9
  263b03:	jmp    26392d <<glass::engine::Watch>::print_utf8+0x51d>
  263b08:	nopl   0x0(%rax,%rax,1)
  263b10:	mov    %rbx,0x68(%rsp)
  263b15:	mov    0x39511d(%rip),%eax        # 5f8c38 <glass::engine::width_of::CACHE+0x10>
  263b1b:	test   %eax,%eax
  263b1d:	jne    263dfe <<glass::engine::Watch>::print_utf8+0x9ee>
  263b23:	mov    %r8d,%ebx
  263b26:	mov    0x395103(%rip),%rsi        # 5f8c30 <glass::engine::width_of::CACHE+0x8>
  263b2d:	cmp    %rbx,%rsi
  263b30:	jbe    2653e8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  263b36:	mov    0x3950eb(%rip),%r12        # 5f8c28 <glass::engine::width_of::CACHE>
  263b3d:	movzbl (%r12,%rbx,1),%eax
  263b42:	movzbl %al,%ecx
  263b45:	test   %cl,%cl
  263b47:	mov    %rdx,0x28(%rsp)
  263b4c:	js     263b67 <<glass::engine::Watch>::print_utf8+0x757>
  263b4e:	mov    $0x1,%dl
  263b50:	mov    0x18(%rsp),%rsi
  263b55:	test   %dl,%dl
  263b57:	mov    0x68(%rsp),%rbx
  263b5c:	jne    263bf3 <<glass::engine::Watch>::print_utf8+0x7e3>
  263b62:	jmp    263eed <<glass::engine::Watch>::print_utf8+0xadd>
  263b67:	cmp    $0xfe,%ecx
  263b6d:	mov    0x18(%rsp),%rsi
  263b72:	je     263f0d <<glass::engine::Watch>::print_utf8+0xafd>
  263b78:	mov    $0xfe,%al
  263b7a:	cmp    $0x7f,%r8d
  263b7e:	jae    263b89 <<glass::engine::Watch>::print_utf8+0x779>
  263b80:	mov    $0x1,%ecx
  263b85:	xor    %edx,%edx
  263b87:	jmp    263be2 <<glass::engine::Watch>::print_utf8+0x7d2>
  263b89:	cmp    $0xa0,%r8d
  263b90:	jb     263be0 <<glass::engine::Watch>::print_utf8+0x7d0>
  263b92:	mov    %rdi,0xb0(%rsp)
  263b9a:	mov    %r8d,%edi
  263b9d:	mov    %r8,0x58(%rsp)
  263ba2:	mov    %r10,0xe8(%rsp)
  263baa:	mov    %r11,0xe0(%rsp)
  263bb2:	call   299ae0 <unicode_width::tables::lookup_width>
  263bb7:	mov    0xe0(%rsp),%r11
  263bbf:	mov    0xe8(%rsp),%r10
  263bc7:	mov    0xb0(%rsp),%rdi
  263bcf:	mov    0x58(%rsp),%r8
  263bd4:	mov    0x18(%rsp),%rsi
  263bd9:	movzbl %al,%ecx
  263bdc:	mov    $0x1,%dl
  263bde:	jmp    263be2 <<glass::engine::Watch>::print_utf8+0x7d2>
  263be0:	xor    %edx,%edx
  263be2:	mov    %al,(%r12,%rbx,1)
  263be6:	test   %dl,%dl
  263be8:	mov    0x68(%rsp),%rbx
  263bed:	je     263eed <<glass::engine::Watch>::print_utf8+0xadd>
  263bf3:	lea    -0x1(%rcx),%rax
  263bf7:	cmp    $0x1,%rax
  263bfb:	mov    0x28(%rsp),%rdx
  263c00:	mov    0x60(%rsp),%r12
  263c05:	ja     263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263c0b:	test   $0x1,%r11b
  263c0f:	jne    263e7c <<glass::engine::Watch>::print_utf8+0xa6c>
  263c15:	lea    (%rcx,%r10,1),%rax
  263c19:	cmp    0x38(%rsp),%rax
  263c1e:	ja     263e81 <<glass::engine::Watch>::print_utf8+0xa71>
  263c24:	mov    %rax,0x58(%rsp)
  263c29:	mov    %rbx,%r9
  263c2c:	mov    %r10,%rbx
  263c2f:	sub    %r12,%rbx
  263c32:	cmp    0x20(%rsp),%r10
  263c37:	jae    263ca0 <<glass::engine::Watch>::print_utf8+0x890>
  263c39:	cmp    0x30(%rsp),%rbx
  263c3e:	mov    0x70(%rsp),%r11
  263c43:	jae    265431 <<glass::engine::Watch>::print_utf8+0x2021>
  263c49:	lea    (%r10,%r10,2),%rax
  263c4d:	testb  $0x60,0x14(%r11,%rax,8)
  263c53:	jne    263ee8 <<glass::engine::Watch>::print_utf8+0xad8>
  263c59:	lea    (%r11,%rax,8),%r12
  263c5d:	cmp    $0x2,%rcx
  263c61:	jne    263d32 <<glass::engine::Watch>::print_utf8+0x922>
  263c67:	lea    0x1(%rbx),%rax
  263c6b:	cmp    0x30(%rsp),%rax
  263c70:	jae    26544f <<glass::engine::Watch>::print_utf8+0x203f>
  263c76:	mov    %r14,%rcx
  263c79:	lea    (%rax,%rax,2),%rax
  263c7d:	mov    $0x1,%r14b
  263c80:	mov    0xb8(%rsp),%r13
  263c88:	testb  $0x60,0x14(%r13,%rax,8)
  263c8e:	mov    0x8c(%rsp),%r13d
  263c96:	je     263cce <<glass::engine::Watch>::print_utf8+0x8be>
  263c98:	jmp    263ef2 <<glass::engine::Watch>::print_utf8+0xae2>
  263c9d:	nopl   (%rax)
  263ca0:	cmp    0x30(%rsp),%rbx
  263ca5:	mov    0x70(%rsp),%r11
  263caa:	jae    265461 <<glass::engine::Watch>::print_utf8+0x2051>
  263cb0:	lea    (%r10,%r10,2),%rax
  263cb4:	lea    (%r11,%rax,8),%r12
  263cb8:	cmp    $0x2,%rcx
  263cbc:	sete   %r14b
  263cc0:	mov    0xc(%rsp),%r13d
  263cc5:	cmove  0x8c(%rsp),%r13d
  263cce:	mov    (%r12),%rax
  263cd2:	test   %rax,%rax
  263cd5:	je     263d50 <<glass::engine::Watch>::print_utf8+0x940>
  263cd7:	lock decq (%rax)
  263cdb:	jne    263d50 <<glass::engine::Watch>::print_utf8+0x940>
  263cdd:	mov    %rdi,0xb0(%rsp)
  263ce5:	mov    %r12,%rdi
  263ce8:	mov    %r15,0xe0(%rsp)
  263cf0:	mov    %r8,%r15
  263cf3:	mov    %rdx,0x28(%rsp)
  263cf8:	mov    %r10,0xe8(%rsp)
  263d00:	call   *0x391fc2(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  263d06:	mov    0x70(%rsp),%r11
  263d0b:	mov    0xe8(%rsp),%r10
  263d13:	mov    0xb0(%rsp),%rdi
  263d1b:	mov    0x28(%rsp),%rdx
  263d20:	mov    %r15,%r8
  263d23:	mov    0xe0(%rsp),%r15
  263d2b:	mov    0x18(%rsp),%rsi
  263d30:	jmp    263d50 <<glass::engine::Watch>::print_utf8+0x940>
  263d32:	xor    %r14d,%r14d
  263d35:	mov    0xc(%rsp),%r13d
  263d3a:	mov    (%r12),%rax
  263d3e:	test   %rax,%rax
  263d41:	jne    263cd7 <<glass::engine::Watch>::print_utf8+0x8c7>
  263d43:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  263d50:	lea    (%r10,%r10,2),%rax
  263d54:	movq   $0x0,(%r12)
  263d5c:	mov    0x78(%rsp),%ecx
  263d60:	mov    %ecx,0x8(%r11,%rax,8)
  263d65:	mov    0xa0(%rsp),%ecx
  263d6c:	mov    %ecx,0xc(%r11,%rax,8)
  263d71:	mov    %r13w,0x14(%r11,%rax,8)
  263d77:	mov    %r8d,0x10(%r11,%rax,8)
  263d7c:	test   %r14b,%r14b
  263d7f:	mov    0xc0(%rsp),%r13
  263d87:	mov    0x60(%rsp),%r12
  263d8c:	mov    0x58(%rsp),%r9
  263d91:	je     263915 <<glass::engine::Watch>::print_utf8+0x505>
  263d97:	inc    %rbx
  263d9a:	cmp    0x30(%rsp),%rbx
  263d9f:	jae    26543a <<glass::engine::Watch>::print_utf8+0x202a>
  263da5:	lea    (%rbx,%rbx,2),%rax
  263da9:	mov    0xb8(%rsp),%rcx
  263db1:	lea    (%rcx,%rax,8),%rbx
  263db5:	mov    (%rcx,%rax,8),%rax
  263db9:	test   %rax,%rax
  263dbc:	je     2638e0 <<glass::engine::Watch>::print_utf8+0x4d0>
  263dc2:	lock decq (%rax)
  263dc6:	jne    2638e0 <<glass::engine::Watch>::print_utf8+0x4d0>
  263dcc:	mov    %r15,%r13
  263dcf:	mov    %rdi,%r15
  263dd2:	mov    %rbx,%rdi
  263dd5:	mov    %rdx,%r14
  263dd8:	call   *0x391eea(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  263dde:	mov    0x58(%rsp),%r9
  263de3:	mov    %r15,%rdi
  263de6:	mov    %r13,%r15
  263de9:	mov    0xc0(%rsp),%r13
  263df1:	mov    %r14,%rdx
  263df4:	mov    0x18(%rsp),%rsi
  263df9:	jmp    2638e0 <<glass::engine::Watch>::print_utf8+0x4d0>
  263dfe:	mov    %r8,0x58(%rsp)
  263e03:	mov    %r15,0xe0(%rsp)
  263e0b:	mov    %rdx,%r15
  263e0e:	mov    %rdi,0xb0(%rsp)
  263e16:	mov    %r10,0xe8(%rsp)
  263e1e:	mov    %r11,%r12
  263e21:	call   18c852 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263e26:	mov    %r12,%r11
  263e29:	mov    0xe8(%rsp),%r10
  263e31:	mov    0xb0(%rsp),%rdi
  263e39:	mov    %r15,%rdx
  263e3c:	mov    0xe0(%rsp),%r15
  263e44:	mov    0x58(%rsp),%r8
  263e49:	mov    %r8d,%ebx
  263e4c:	mov    0x394ddd(%rip),%rsi        # 5f8c30 <glass::engine::width_of::CACHE+0x8>
  263e53:	cmp    %rbx,%rsi
  263e56:	ja     263b36 <<glass::engine::Watch>::print_utf8+0x726>
  263e5c:	jmp    2653e8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  263e61:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  263e70:	xor    %edi,%edi
  263e72:	xor    %r11d,%r11d
  263e75:	mov    0x18(%rsp),%rsi
  263e7a:	jmp    263ed4 <<glass::engine::Watch>::print_utf8+0xac4>
  263e7c:	mov    $0x1,%r11b
  263e7f:	jmp    263e84 <<glass::engine::Watch>::print_utf8+0xa74>
  263e81:	xor    %r11d,%r11d
  263e84:	mov    %rbx,%r9
  263e87:	mov    %r8d,%ebp
  263e8a:	mov    %r15,%rdx
  263e8d:	cmp    %r12,%r9
  263e90:	jbe    263ea7 <<glass::engine::Watch>::print_utf8+0xa97>
  263e92:	mov    0xd8(%rsp),%rcx
  263e9a:	mov    (%rcx),%rax
  263e9d:	cmp    %rax,%r9
  263ea0:	cmova  %r9,%rax
  263ea4:	mov    %rax,(%rcx)
  263ea7:	cmp    $0x8,%rdi
  263eab:	setae  %al
  263eae:	testb  $0x1,0x90(%rsp)
  263eb6:	mov    0xc8(%rsp),%r15
  263ebe:	jne    263ec2 <<glass::engine::Watch>::print_utf8+0xab2>
  263ec0:	xor    %eax,%eax
  263ec2:	test   %al,%al
  263ec4:	jne    263f22 <<glass::engine::Watch>::print_utf8+0xb12>
  263ec6:	mov    %r10,%r12
  263ec9:	mov    %ebp,%r8d
  263ecc:	mov    0x98(%rsp),%rbx
  263ed4:	mov    %r12,0x40(%rbx)
  263ed8:	mov    %r11b,0x6c(%rbx)
  263edc:	add    %rdi,0xa0(%r15)
  263ee3:	jmp    263fa9 <<glass::engine::Watch>::print_utf8+0xb99>
  263ee8:	xor    %r11d,%r11d
  263eeb:	jmp    263e87 <<glass::engine::Watch>::print_utf8+0xa77>
  263eed:	mov    %rbx,%r9
  263ef0:	jmp    263f12 <<glass::engine::Watch>::print_utf8+0xb02>
  263ef2:	xor    %r11d,%r11d
  263ef5:	mov    %r8d,%ebp
  263ef8:	mov    %r15,%rdx
  263efb:	mov    0xc0(%rsp),%r13
  263f03:	mov    %rcx,%r14
  263f06:	mov    0x60(%rsp),%r12
  263f0b:	jmp    263e8d <<glass::engine::Watch>::print_utf8+0xa7d>
  263f0d:	mov    0x68(%rsp),%r9
  263f12:	mov    %r8d,%ebp
  263f15:	mov    %r15,%rdx
  263f18:	mov    0x60(%rsp),%r12
  263f1d:	jmp    263e8d <<glass::engine::Watch>::print_utf8+0xa7d>
  263f22:	mov    %rdx,0x28(%rsp)
  263f27:	movzbl %r11b,%edx
  263f2b:	add    %r10,%rdx
  263f2e:	mov    %rdi,0xb0(%rsp)
  263f36:	mov    0xd0(%rsp),%rdi
  263f3e:	mov    %r12,%rsi
  263f41:	lea    0xf8(%rsp),%rcx
  263f49:	mov    %r10,%r12
  263f4c:	mov    %r11,%rbx
  263f4f:	call   2a2940 <glass::engine::note_uniform_span>
  263f54:	mov    %rbx,%r11
  263f57:	mov    0xb0(%rsp),%rdi
  263f5f:	mov    0x28(%rsp),%rdx
  263f64:	mov    0x18(%rsp),%rsi
  263f69:	jmp    263ec9 <<glass::engine::Watch>::print_utf8+0xab9>
  263f6e:	xchg   %ax,%ax
  263f70:	mov    0xc8(%rsp),%r15
  263f78:	mov    %r15,%rdi
  263f7b:	mov    %ebp,%esi
  263f7d:	mov    %r8,%rbx
  263f80:	mov    %rdx,%r14
  263f83:	call   340a50 <<glass::engine::Watch as vte::ansi::Handler>::input>
  263f88:	mov    %r14,%rdx
  263f8b:	mov    %rbx,%r8
  263f8e:	mov    0x18(%rsp),%rsi
  263f93:	mov    0x30(%rsp),%r14
  263f98:	add    %r14,%rdx
  263f9b:	cmpb   $0x0,0x80(%rsp)
  263fa3:	jne    2634c0 <<glass::engine::Watch>::print_utf8+0xb0>
  263fa9:	mov    %r8d,%ebp
  263fac:	mov    %r14,%rbx
  263faf:	mov    %rdx,%r14
  263fb2:	cmp    %r13,%rdx
  263fb5:	jae    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  263fbb:	movzbl (%rsi,%r14,1),%r8d
  263fc0:	test   %r8b,%r8b
  263fc3:	js     263fe0 <<glass::engine::Watch>::print_utf8+0xbd0>
  263fc5:	mov    $0x1,%edx
  263fca:	lea    -0x7f(%r8),%eax
  263fce:	cmp    $0x21,%eax
  263fd1:	jae    264168 <<glass::engine::Watch>::print_utf8+0xd58>
  263fd7:	jmp    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  263fdc:	nopl   0x0(%rax)
  263fe0:	lea    0x3e(%r8),%eax
  263fe4:	cmp    $0x1e,%al
  263fe6:	jae    264020 <<glass::engine::Watch>::print_utf8+0xc10>
  263fe8:	lea    0x1(%r14),%rax
  263fec:	cmp    %r13,%rax
  263fef:	jae    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  263ff5:	movzbl (%rsi,%rax,1),%eax
  263ff9:	cmp    $0xc0,%al
  263ffb:	jge    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  264001:	and    $0x1f,%r8d
  264005:	shl    $0x6,%r8d
  264009:	mov    $0x2,%edx
  26400e:	jmp    264138 <<glass::engine::Watch>::print_utf8+0xd28>
  264013:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  264020:	mov    %r8d,%eax
  264023:	and    $0xf0,%al
  264025:	cmp    $0xe0,%al
  264027:	jne    264043 <<glass::engine::Watch>::print_utf8+0xc33>
  264029:	mov    $0xbf,%al
  26402b:	cmp    $0xe0,%r8d
  264032:	je     264069 <<glass::engine::Watch>::print_utf8+0xc59>
  264034:	mov    $0x80,%cl
  264036:	cmp    $0xed,%r8d
  26403d:	jne    26406b <<glass::engine::Watch>::print_utf8+0xc5b>
  26403f:	mov    $0x9f,%al
  264041:	jmp    26406b <<glass::engine::Watch>::print_utf8+0xc5b>
  264043:	lea    0x10(%r8),%eax
  264047:	cmp    $0x5,%al
  264049:	jae    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  26404f:	mov    $0x80,%al
  264051:	cmp    $0xf4,%r8d
  264058:	je     2640c0 <<glass::engine::Watch>::print_utf8+0xcb0>
  26405a:	mov    $0xbf,%cl
  26405c:	cmp    $0xf0,%r8d
  264063:	jne    2640c2 <<glass::engine::Watch>::print_utf8+0xcb2>
  264065:	mov    $0x90,%al
  264067:	jmp    2640c2 <<glass::engine::Watch>::print_utf8+0xcb2>
  264069:	mov    $0xa0,%cl
  26406b:	lea    0x1(%r14),%rdx
  26406f:	cmp    %r13,%rdx
  264072:	jae    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  264078:	movzbl (%rsi,%rdx,1),%edx
  26407c:	cmp    %dl,%cl
  26407e:	ja     264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  264084:	cmp    %al,%dl
  264086:	ja     264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  26408c:	lea    0x2(%r14),%rax
  264090:	cmp    %r13,%rax
  264093:	jae    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  264099:	movzbl (%rsi,%rax,1),%eax
  26409d:	cmp    $0xc0,%al
  26409f:	jge    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  2640a5:	movzbl %dl,%ecx
  2640a8:	and    $0x3f,%ecx
  2640ab:	shl    $0x6,%ecx
  2640ae:	and    $0xf,%r8d
  2640b2:	shl    $0xc,%r8d
  2640b6:	or     %ecx,%r8d
  2640b9:	mov    $0x3,%edx
  2640be:	jmp    264138 <<glass::engine::Watch>::print_utf8+0xd28>
  2640c0:	mov    $0x8f,%cl
  2640c2:	lea    0x1(%r14),%rdx
  2640c6:	cmp    %r13,%rdx
  2640c9:	jae    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  2640cf:	movzbl (%rsi,%rdx,1),%edx
  2640d3:	cmp    %dl,%al
  2640d5:	ja     264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  2640db:	cmp    %cl,%dl
  2640dd:	ja     264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  2640e3:	lea    0x2(%r14),%rax
  2640e7:	cmp    %r13,%rax
  2640ea:	jae    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  2640f0:	movzbl (%rsi,%rax,1),%ecx
  2640f4:	cmp    $0xbf,%cl
  2640f7:	jg     264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  2640fd:	lea    0x3(%r14),%rax
  264101:	cmp    %r13,%rax
  264104:	jae    264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  26410a:	movzbl (%rsi,%rax,1),%eax
  26410e:	cmp    $0xbf,%al
  264110:	jg     264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  264116:	movzbl %dl,%edx
  264119:	and    $0x3f,%ecx
  26411c:	shl    $0x6,%ecx
  26411f:	and    $0x3f,%edx
  264122:	shl    $0xc,%edx
  264125:	and    $0x7,%r8d
  264129:	shl    $0x12,%r8d
  26412d:	or     %edx,%r8d
  264130:	or     %ecx,%r8d
  264133:	mov    $0x4,%edx
  264138:	mov    %r8d,%ecx
  26413b:	xor    $0xd800,%ecx
  264141:	add    $0xffef0000,%ecx
  264147:	cmp    $0xffef0800,%ecx
  26414d:	jb     264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  264153:	and    $0x3f,%al
  264155:	movzbl %al,%eax
  264158:	or     %eax,%r8d
  26415b:	lea    -0x7f(%r8),%eax
  26415f:	cmp    $0x21,%eax
  264162:	jb     264a8e <<glass::engine::Watch>::print_utf8+0x167e>
  264168:	cmp    $0xffffffff,%ebp
  26416b:	je     264a50 <<glass::engine::Watch>::print_utf8+0x1640>
  264171:	mov    %r14,0x30(%rsp)
  264176:	lea    -0x20(%rbp),%eax
  264179:	cmp    $0x5f,%eax
  26417c:	jae    2641a0 <<glass::engine::Watch>::print_utf8+0xd90>
  26417e:	mov    $0x1,%r12d
  264184:	cmpb   $0x0,0x10(%rsp)
  264189:	je     263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  26418f:	jmp    26424c <<glass::engine::Watch>::print_utf8+0xe3c>
  264194:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  2641a0:	cmpb   $0x0,0x80(%rsp)
  2641a8:	je     263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  2641ae:	mov    0x394a84(%rip),%eax        # 5f8c38 <glass::engine::width_of::CACHE+0x10>
  2641b4:	test   %eax,%eax
  2641b6:	jne    264a66 <<glass::engine::Watch>::print_utf8+0x1656>
  2641bc:	mov    %ebp,%ebx
  2641be:	mov    0x394a6b(%rip),%rsi        # 5f8c30 <glass::engine::width_of::CACHE+0x8>
  2641c5:	cmp    %rbx,%rsi
  2641c8:	jbe    2653e8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2641ce:	mov    0x394a53(%rip),%r14        # 5f8c28 <glass::engine::width_of::CACHE>
  2641d5:	movzbl (%r14,%rbx,1),%eax
  2641da:	movzbl %al,%r12d
  2641de:	test   %r12b,%r12b
  2641e1:	js     2641ee <<glass::engine::Watch>::print_utf8+0xdde>
  2641e3:	mov    $0x1,%cl
  2641e5:	test   %cl,%cl
  2641e7:	jne    26423d <<glass::engine::Watch>::print_utf8+0xe2d>
  2641e9:	jmp    263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  2641ee:	cmp    $0xfe,%r12d
  2641f5:	je     263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  2641fb:	mov    $0xfe,%al
  2641fd:	cmp    $0x7f,%ebp
  264200:	jae    26420c <<glass::engine::Watch>::print_utf8+0xdfc>
  264202:	mov    $0x1,%r12d
  264208:	xor    %ecx,%ecx
  26420a:	jmp    264231 <<glass::engine::Watch>::print_utf8+0xe21>
  26420c:	cmp    $0xa0,%ebp
  264212:	jb     26422f <<glass::engine::Watch>::print_utf8+0xe1f>
  264214:	mov    %ebp,%edi
  264216:	mov    %r8,%r15
  264219:	mov    %rdx,%r12
  26421c:	call   299ae0 <unicode_width::tables::lookup_width>
  264221:	mov    %r12,%rdx
  264224:	mov    %r15,%r8
  264227:	movzbl %al,%r12d
  26422b:	mov    $0x1,%cl
  26422d:	jmp    264231 <<glass::engine::Watch>::print_utf8+0xe21>
  26422f:	xor    %ecx,%ecx
  264231:	mov    %al,(%r14,%rbx,1)
  264235:	test   %cl,%cl
  264237:	je     263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  26423d:	lea    -0x1(%r12),%rax
  264242:	cmp    $0x1,%rax
  264246:	ja     263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  26424c:	mov    0xc8(%rsp),%rax
  264254:	mov    0x78(%rax),%r9
  264258:	cmpb   $0x0,0x6c(%r9)
  26425d:	jne    263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  264263:	mov    0x40(%r9),%rbx
  264267:	mov    0xa0(%r9),%r11
  26426e:	lea    (%rbx,%r12,1),%r10
  264272:	cmp    %r11,%r10
  264275:	ja     263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  26427b:	mov    0x30(%r9),%eax
  26427f:	sub    0x48(%r9),%eax
  264283:	cltq
  264285:	mov    0x20(%r9),%rsi
  264289:	mov    0x28(%r9),%rcx
  26428d:	lea    (%rcx,%rax,1),%rdi
  264291:	dec    %rdi
  264294:	cmp    %rsi,%rdi
  264297:	mov    $0x0,%eax
  26429c:	cmovae %rsi,%rax
  2642a0:	sub    %rax,%rdi
  2642a3:	cmp    %rsi,%rdi
  2642a6:	jae    26548b <<glass::engine::Watch>::print_utf8+0x207b>
  2642ac:	mov    0x58(%r9),%eax
  2642b0:	mov    %eax,0x58(%rsp)
  2642b4:	mov    0x5c(%r9),%eax
  2642b8:	mov    %eax,0xa0(%rsp)
  2642bf:	movzwl 0x64(%r9),%r14d
  2642c4:	mov    0x18(%r9),%rax
  2642c8:	shl    $0x6,%rdi
  2642cc:	lea    (%rax,%rdi,1),%r15
  2642d0:	lea    (%rax,%rdi,1),%rcx
  2642d4:	add    $0x18,%rcx
  2642d8:	mov    %rcx,0x78(%rsp)
  2642dd:	mov    0x28(%rax,%rdi,1),%eax
  2642e1:	cmp    $0xffffffff,%eax
  2642e4:	je     2642f1 <<glass::engine::Watch>::print_utf8+0xee1>
  2642e6:	mov    0x78(%rsp),%rcx
  2642eb:	cmp    0x30(%r15),%rbx
  2642ef:	jae    26430a <<glass::engine::Watch>::print_utf8+0xefa>
  2642f1:	mov    0x10(%r15),%rsi
  2642f5:	cmp    %rsi,%rbx
  2642f8:	jae    265498 <<glass::engine::Watch>::print_utf8+0x2088>
  2642fe:	lea    (%rbx,%rbx,2),%rcx
  264302:	shl    $0x3,%rcx
  264306:	add    0x8(%r15),%rcx
  26430a:	testb  $0x60,0x14(%rcx)
  26430e:	jne    263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  264314:	cmp    $0x2,%r12
  264318:	jne    264351 <<glass::engine::Watch>::print_utf8+0xf41>
  26431a:	lea    0x1(%rbx),%rdi
  26431e:	cmp    $0xffffffff,%eax
  264321:	je     26432e <<glass::engine::Watch>::print_utf8+0xf1e>
  264323:	mov    0x78(%rsp),%rcx
  264328:	cmp    0x30(%r15),%rdi
  26432c:	jae    264347 <<glass::engine::Watch>::print_utf8+0xf37>
  26432e:	mov    0x10(%r15),%rsi
  264332:	cmp    %rsi,%rdi
  264335:	jae    2654bc <<glass::engine::Watch>::print_utf8+0x20ac>
  26433b:	lea    (%rdi,%rdi,2),%rcx
  26433f:	shl    $0x3,%rcx
  264343:	add    0x8(%r15),%rcx
  264347:	testb  $0x60,0x14(%rcx)
  26434b:	jne    263f70 <<glass::engine::Watch>::print_utf8+0xb60>
  264351:	mov    %rdx,0x28(%rsp)
  264356:	cmp    %ebx,0x38(%r15)
  26435a:	jbe    264360 <<glass::engine::Watch>::print_utf8+0xf50>
  26435c:	mov    %ebx,0x38(%r15)
  264360:	mov    %r14d,0xc(%rsp)
  264365:	mov    %r11,0x90(%rsp)
  26436d:	cmp    $0xffffffff,%eax
  264370:	setne  %dl
  264373:	mov    0x30(%r15),%rcx
  264377:	cmp    %rcx,%rbx
  26437a:	sete   %sil
  26437e:	test   %sil,%dl
  264381:	mov    %rbx,0x20(%rsp)
  264386:	mov    %r15,0x38(%rsp)
  26438b:	mov    %r9,0x60(%rsp)
  264390:	mov    %r10,0x70(%rsp)
  264395:	jne    26440e <<glass::engine::Watch>::print_utf8+0xffe>
  264397:	cmp    $0xffffffff,%eax
  26439a:	mov    0x30(%rsp),%r14
  26439f:	je     26465d <<glass::engine::Watch>::print_utf8+0x124d>
  2643a5:	mov    0x10(%r15),%rax
  2643a9:	cmp    %rcx,%rax
  2643ac:	mov    %rcx,%rdx
  2643af:	cmovb  %rax,%rdx
  2643b3:	mov    %rdx,0xa8(%rsp)
  2643bb:	cmp    %rbx,%rax
  2643be:	mov    %rbx,%rsi
  2643c1:	cmovb  %rax,%rsi
  2643c5:	mov    0x3919b4(%rip),%rdx        # 5f5d80 <_DYNAMIC+0x320>
  2643cc:	movzbl (%rdx),%edx
  2643cf:	test   %dl,%dl
  2643d1:	je     26447b <<glass::engine::Watch>::print_utf8+0x106b>
  2643d7:	mov    0x3919da(%rip),%rdx        # 5f5db8 <_DYNAMIC+0x358>
  2643de:	mov    %rsi,%r11
  2643e1:	cmp    %rsi,%rcx
  2643e4:	jae    2643ed <<glass::engine::Watch>::print_utf8+0xfdd>
  2643e6:	mov    0x3919d3(%rip),%rdx        # 5f5dc0 <_DYNAMIC+0x360>
  2643ed:	lock incq 0x28(%rdx)
  2643f2:	mov    0x39199f(%rip),%rdx        # 5f5d98 <_DYNAMIC+0x338>
  2643f9:	lock incq (%rdx)
  2643fd:	mov    %r11,%rdx
  264400:	sub    0xa8(%rsp),%rdx
  264408:	jne    26442d <<glass::engine::Watch>::print_utf8+0x101d>
  26440a:	xor    %esi,%esi
  26440c:	jmp    26446c <<glass::engine::Watch>::print_utf8+0x105c>
  26440e:	lea    0x1(%rbx),%rax
  264412:	mov    %rax,0x30(%r15)
  264416:	mov    0x10(%r15),%rsi
  26441a:	cmp    %rsi,%rbx
  26441d:	mov    0x30(%rsp),%r14
  264422:	jb     26467d <<glass::engine::Watch>::print_utf8+0x126d>
  264428:	jmp    2654c9 <<glass::engine::Watch>::print_utf8+0x20b9>
  26442d:	mov    0x39196c(%rip),%rsi        # 5f5da0 <_DYNAMIC+0x340>
  264434:	lock add %rdx,(%rsi)
  264438:	cmp    $0x5,%rdx
  26443c:	jae    26444c <<glass::engine::Watch>::print_utf8+0x103c>
  26443e:	lea    -0x206265(%rip),%rsi        # 5e1e0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  264445:	movzbl -0x1(%rdx,%rsi,1),%esi
  26444a:	jmp    26446c <<glass::engine::Watch>::print_utf8+0x105c>
  26444c:	lea    -0x5(%rdx),%rdi
  264450:	mov    $0x4,%esi
  264455:	cmp    $0x4,%rdi
  264459:	jb     26446c <<glass::engine::Watch>::print_utf8+0x105c>
  26445b:	add    $0xfffffffffffffff7,%rdx
  26445f:	cmp    $0x8,%rdx
  264463:	mov    $0x6,%esi
  264468:	sbb    $0x0,%rsi
  26446c:	mov    0x39191d(%rip),%rdx        # 5f5d90 <_DYNAMIC+0x330>
  264473:	lock incq (%rdx,%rsi,8)
  264478:	mov    %r11,%rsi
  26447b:	cmp    %rsi,%rcx
  26447e:	jae    26461b <<glass::engine::Watch>::print_utf8+0x120b>
  264484:	mov    0x28(%r15),%edi
  264488:	mov    0x20(%r15),%r10d
  26448c:	mov    0x24(%r15),%r11d
  264490:	movzwl 0x2c(%r15),%ecx
  264495:	mov    0x18(%r15),%rax
  264499:	test   %rax,%rax
  26449c:	mov    %rax,0x68(%rsp)
  2644a1:	je     2644d6 <<glass::engine::Watch>::print_utf8+0x10c6>
  2644a3:	lock incq (%rax)
  2644a7:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  2644ad:	mov    0x10(%r15),%rdx
  2644b1:	mov    %edi,0x50(%rsp)
  2644b5:	mov    %r10d,0x48(%rsp)
  2644ba:	mov    %r11d,0x4c(%rsp)
  2644bf:	mov    %ecx,%r9d
  2644c2:	mov    %cx,0x54(%rsp)
  2644c7:	mov    %rax,0x40(%rsp)
  2644cc:	cmp    %rdx,%rsi
  2644cf:	jbe    2644f1 <<glass::engine::Watch>::print_utf8+0x10e1>
  2644d1:	jmp    2653f8 <<glass::engine::Watch>::print_utf8+0x1fe8>
  2644d6:	mov    %edi,0x50(%rsp)
  2644da:	mov    %r10d,0x48(%rsp)
  2644df:	mov    %r11d,0x4c(%rsp)
  2644e4:	mov    %cx,0x54(%rsp)
  2644e9:	mov    %rax,0x40(%rsp)
  2644ee:	mov    %ecx,%r9d
  2644f1:	mov    0xa8(%rsp),%rax
  2644f9:	lea    0x0(,%rax,8),%rax
  264501:	lea    (%rax,%rax,2),%rax
  264505:	mov    0x8(%r15),%rbx
  264509:	add    %rax,%rbx
  26450c:	mov    %rsi,0xd0(%rsp)
  264514:	lea    0x0(,%rsi,8),%rcx
  26451c:	lea    (%rcx,%rcx,2),%r14
  264520:	sub    %rax,%r14
  264523:	mov    0x68(%rsp),%rcx
  264528:	mov    %edi,0x98(%rsp)
  26452f:	mov    %r10d,0x8c(%rsp)
  264537:	mov    %r11d,0xb8(%rsp)
  26453f:	mov    %r9w,0xd8(%rsp)
  264548:	jmp    26456d <<glass::engine::Watch>::print_utf8+0x115d>
  26454a:	nopw   0x0(%rax,%rax,1)
  264550:	mov    %rcx,(%rbx)
  264553:	mov    %r10d,0x8(%rbx)
  264557:	mov    %r11d,0xc(%rbx)
  26455b:	mov    %edi,0x10(%rbx)
  26455e:	mov    %r9w,0x14(%rbx)
  264563:	add    $0x18,%rbx
  264567:	add    $0xffffffffffffffe8,%r14
  26456b:	je     2645c5 <<glass::engine::Watch>::print_utf8+0x11b5>
  26456d:	test   %rcx,%rcx
  264570:	je     26457c <<glass::engine::Watch>::print_utf8+0x116c>
  264572:	lock incq (%rcx)
  264576:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  26457c:	mov    (%rbx),%rax
  26457f:	test   %rax,%rax
  264582:	je     264550 <<glass::engine::Watch>::print_utf8+0x1140>
  264584:	lock decq (%rax)
  264588:	jne    264550 <<glass::engine::Watch>::print_utf8+0x1140>
  26458a:	mov    %rbx,%rdi
  26458d:	mov    %r8,%r15
  264590:	call   *0x391732(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  264596:	movzwl 0xd8(%rsp),%r9d
  26459f:	mov    0xb8(%rsp),%r11d
  2645a7:	mov    0x8c(%rsp),%r10d
  2645af:	mov    0x98(%rsp),%edi
  2645b6:	mov    0x68(%rsp),%rcx
  2645bb:	mov    %r15,%r8
  2645be:	mov    0x38(%rsp),%r15
  2645c3:	jmp    264550 <<glass::engine::Watch>::print_utf8+0x1140>
  2645c5:	mov    0xa8(%rsp),%rax
  2645cd:	cmp    %eax,0x38(%r15)
  2645d1:	mov    0x30(%rsp),%r14
  2645d6:	mov    0x20(%rsp),%rbx
  2645db:	jbe    2645e1 <<glass::engine::Watch>::print_utf8+0x11d1>
  2645dd:	mov    %eax,0x38(%r15)
  2645e1:	test   %rcx,%rcx
  2645e4:	mov    0xd0(%rsp),%rsi
  2645ec:	je     264617 <<glass::engine::Watch>::print_utf8+0x1207>
  2645ee:	lock decq (%rcx)
  2645f2:	jne    264617 <<glass::engine::Watch>::print_utf8+0x1207>
  2645f4:	lea    0x40(%rsp),%rdi
  2645f9:	mov    %r8,%rbx
  2645fc:	call   *0x3916c6(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  264602:	mov    0xd0(%rsp),%rsi
  26460a:	mov    %rbx,%r8
  26460d:	mov    0x20(%rsp),%rbx
  264612:	mov    0x38(%rsp),%r15
  264617:	mov    0x10(%r15),%rax
  26461b:	cmp    %rax,%rsi
  26461e:	jb     26465d <<glass::engine::Watch>::print_utf8+0x124d>
  264620:	cmpl   $0xffffffff,0x28(%r15)
  264625:	je     264655 <<glass::engine::Watch>::print_utf8+0x1245>
  264627:	mov    0x78(%rsp),%rax
  26462c:	mov    (%rax),%rax
  26462f:	test   %rax,%rax
  264632:	je     264655 <<glass::engine::Watch>::print_utf8+0x1245>
  264634:	lock decq (%rax)
  264638:	jne    264655 <<glass::engine::Watch>::print_utf8+0x1245>
  26463a:	mov    0x78(%rsp),%rdi
  26463f:	mov    %r8,%rbx
  264642:	call   *0x391680(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  264648:	mov    %rbx,%r8
  26464b:	mov    0x20(%rsp),%rbx
  264650:	mov    0x38(%rsp),%r15
  264655:	movl   $0xffffffff,0x28(%r15)
  26465d:	mov    0x30(%r15),%rax
  264661:	lea    0x1(%rbx),%rcx
  264665:	cmp    %rax,%rcx
  264668:	cmova  %rcx,%rax
  26466c:	mov    0x10(%r15),%rsi
  264670:	mov    %rax,0x30(%r15)
  264674:	cmp    %rsi,%rbx
  264677:	jae    2654d9 <<glass::engine::Watch>::print_utf8+0x20c9>
  26467d:	mov    0xc(%rsp),%esi
  264681:	mov    %esi,%eax
  264683:	or     $0x20,%eax
  264686:	cmp    $0x2,%r12
  26468a:	mov    0x8(%r15),%rcx
  26468e:	lea    (%rbx,%rbx,2),%rdx
  264692:	lea    (%rcx,%rdx,8),%rbx
  264696:	mov    %ebp,0x10(%rcx,%rdx,8)
  26469a:	mov    0x58(%rsp),%ebp
  26469e:	mov    %ebp,0x8(%rcx,%rdx,8)
  2646a2:	cmovne %esi,%eax
  2646a5:	mov    0xa0(%rsp),%esi
  2646ac:	mov    %esi,0xc(%rcx,%rdx,8)
  2646b0:	mov    %ax,0x14(%rcx,%rdx,8)
  2646b5:	mov    (%rcx,%rdx,8),%rax
  2646b9:	test   %rax,%rax
  2646bc:	je     2646d8 <<glass::engine::Watch>::print_utf8+0x12c8>
  2646be:	lock decq (%rax)
  2646c2:	jne    2646d8 <<glass::engine::Watch>::print_utf8+0x12c8>
  2646c4:	mov    %rbx,%rdi
  2646c7:	mov    %r8,%r15
  2646ca:	call   *0x3915f8(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  2646d0:	mov    %r15,%r8
  2646d3:	mov    0x38(%rsp),%r15
  2646d8:	movq   $0x0,(%rbx)
  2646df:	cmp    $0x2,%r12
  2646e3:	mov    0x28(%rsp),%rdx
  2646e8:	jne    264a18 <<glass::engine::Watch>::print_utf8+0x1608>
  2646ee:	mov    0x20(%rsp),%r9
  2646f3:	lea    0x1(%r9),%r12
  2646f7:	mov    0x30(%r15),%rax
  2646fb:	mov    0x28(%r15),%ecx
  2646ff:	cmp    %rax,%r12
  264702:	jne    264723 <<glass::engine::Watch>::print_utf8+0x1313>
  264704:	cmp    $0xffffffff,%ecx
  264707:	je     264723 <<glass::engine::Watch>::print_utf8+0x1313>
  264709:	add    $0x2,%r9
  26470d:	mov    %r9,0x30(%r15)
  264711:	mov    0x10(%r15),%rsi
  264715:	cmp    %rsi,%r12
  264718:	jb     2649bf <<glass::engine::Watch>::print_utf8+0x15af>
  26471e:	jmp    264d9e <<glass::engine::Watch>::print_utf8+0x198e>
  264723:	cmp    $0xffffffff,%ecx
  264726:	je     26499f <<glass::engine::Watch>::print_utf8+0x158f>
  26472c:	mov    0x10(%r15),%rcx
  264730:	cmp    %rax,%rcx
  264733:	mov    %rax,%rdi
  264736:	cmovb  %rcx,%rdi
  26473a:	cmp    %r12,%rcx
  26473d:	mov    %r12,%r10
  264740:	cmovb  %rcx,%r10
  264744:	mov    0x391635(%rip),%rdx        # 5f5d80 <_DYNAMIC+0x320>
  26474b:	movzbl (%rdx),%edx
  26474e:	test   %dl,%dl
  264750:	je     2647cc <<glass::engine::Watch>::print_utf8+0x13bc>
  264752:	mov    0x39165f(%rip),%rdx        # 5f5db8 <_DYNAMIC+0x358>
  264759:	cmp    %r10,%rax
  26475c:	jae    264765 <<glass::engine::Watch>::print_utf8+0x1355>
  26475e:	mov    0x39165b(%rip),%rdx        # 5f5dc0 <_DYNAMIC+0x360>
  264765:	lock incq 0x28(%rdx)
  26476a:	mov    0x391627(%rip),%rdx        # 5f5d98 <_DYNAMIC+0x338>
  264771:	lock incq (%rdx)
  264775:	mov    %r10,%rdx
  264778:	sub    %rdi,%rdx
  26477b:	jne    264781 <<glass::engine::Watch>::print_utf8+0x1371>
  26477d:	xor    %esi,%esi
  26477f:	jmp    2647c0 <<glass::engine::Watch>::print_utf8+0x13b0>
  264781:	mov    0x391618(%rip),%rsi        # 5f5da0 <_DYNAMIC+0x340>
  264788:	lock add %rdx,(%rsi)
  26478c:	cmp    $0x5,%rdx
  264790:	jae    2647a0 <<glass::engine::Watch>::print_utf8+0x1390>
  264792:	lea    -0x2065b9(%rip),%rsi        # 5e1e0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  264799:	movzbl -0x1(%rdx,%rsi,1),%esi
  26479e:	jmp    2647c0 <<glass::engine::Watch>::print_utf8+0x13b0>
  2647a0:	lea    -0x5(%rdx),%r11
  2647a4:	mov    $0x4,%esi
  2647a9:	cmp    $0x4,%r11
  2647ad:	jb     2647c0 <<glass::engine::Watch>::print_utf8+0x13b0>
  2647af:	add    $0xfffffffffffffff7,%rdx
  2647b3:	cmp    $0x8,%rdx
  2647b7:	mov    $0x6,%esi
  2647bc:	sbb    $0x0,%rsi
  2647c0:	mov    0x3915c9(%rip),%rdx        # 5f5d90 <_DYNAMIC+0x330>
  2647c7:	lock incq (%rdx,%rsi,8)
  2647cc:	cmp    %r10,%rax
  2647cf:	mov    0x28(%rsp),%rdx
  2647d4:	jae    264978 <<glass::engine::Watch>::print_utf8+0x1568>
  2647da:	mov    %r12,0xd8(%rsp)
  2647e2:	mov    0x28(%r15),%r9d
  2647e6:	mov    0x20(%r15),%r11d
  2647ea:	mov    0x24(%r15),%ebp
  2647ee:	movzwl 0x2c(%r15),%eax
  2647f3:	mov    0x18(%r15),%r12
  2647f7:	test   %r12,%r12
  2647fa:	mov    %r12,0x98(%rsp)
  264802:	mov    %ax,0x68(%rsp)
  264807:	je     26483d <<glass::engine::Watch>::print_utf8+0x142d>
  264809:	lock incq (%r12)
  26480e:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  264814:	mov    0x10(%r15),%rdx
  264818:	mov    %r9d,0x50(%rsp)
  26481d:	mov    %r11d,0x48(%rsp)
  264822:	mov    %ebp,0x4c(%rsp)
  264826:	mov    %ax,0x54(%rsp)
  26482b:	mov    %r12,0x40(%rsp)
  264830:	cmp    %rdx,%r10
  264833:	mov    %r10,%rsi
  264836:	jbe    264858 <<glass::engine::Watch>::print_utf8+0x1448>
  264838:	jmp    265412 <<glass::engine::Watch>::print_utf8+0x2002>
  26483d:	mov    %r9d,0x50(%rsp)
  264842:	mov    %r11d,0x48(%rsp)
  264847:	mov    %ebp,0x4c(%rsp)
  26484b:	mov    %ax,0x54(%rsp)
  264850:	mov    %r12,0x40(%rsp)
  264855:	mov    %r10,%rsi
  264858:	mov    %rdi,0xa8(%rsp)
  264860:	lea    0x0(,%rdi,8),%rax
  264868:	lea    (%rax,%rax,2),%rax
  26486c:	mov    0x8(%r15),%rbx
  264870:	add    %rax,%rbx
  264873:	mov    %rsi,0xb8(%rsp)
  26487b:	lea    0x0(,%rsi,8),%rcx
  264883:	lea    (%rcx,%rcx,2),%r14
  264887:	sub    %rax,%r14
  26488a:	movzwl 0x68(%rsp),%ecx
  26488f:	mov    %ebp,0x8c(%rsp)
  264896:	jmp    2648bc <<glass::engine::Watch>::print_utf8+0x14ac>
  264898:	nopl   0x0(%rax,%rax,1)
  2648a0:	mov    %r12,(%rbx)
  2648a3:	mov    %r11d,0x8(%rbx)
  2648a7:	mov    %ebp,0xc(%rbx)
  2648aa:	mov    %r9d,0x10(%rbx)
  2648ae:	mov    %cx,0x14(%rbx)
  2648b2:	add    $0x18,%rbx
  2648b6:	add    $0xffffffffffffffe8,%r14
  2648ba:	je     264910 <<glass::engine::Watch>::print_utf8+0x1500>
  2648bc:	test   %r12,%r12
  2648bf:	je     2648cc <<glass::engine::Watch>::print_utf8+0x14bc>
  2648c1:	lock incq (%r12)
  2648c6:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  2648cc:	mov    (%rbx),%rax
  2648cf:	test   %rax,%rax
  2648d2:	je     2648a0 <<glass::engine::Watch>::print_utf8+0x1490>
  2648d4:	lock decq (%rax)
  2648d8:	jne    2648a0 <<glass::engine::Watch>::print_utf8+0x1490>
  2648da:	mov    %rbx,%rdi
  2648dd:	mov    %r8,%r15
  2648e0:	mov    %r9d,%ebp
  2648e3:	mov    %r11d,%r12d
  2648e6:	call   *0x3913dc(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  2648ec:	movzwl 0x68(%rsp),%ecx
  2648f1:	mov    %r12d,%r11d
  2648f4:	mov    0x98(%rsp),%r12
  2648fc:	mov    %ebp,%r9d
  2648ff:	mov    0x8c(%rsp),%ebp
  264906:	mov    %r15,%r8
  264909:	mov    0x38(%rsp),%r15
  26490e:	jmp    2648a0 <<glass::engine::Watch>::print_utf8+0x1490>
  264910:	mov    0xa8(%rsp),%rax
  264918:	cmp    %eax,0x38(%r15)
  26491c:	mov    0x30(%rsp),%r14
  264921:	mov    0x28(%rsp),%rdx
  264926:	mov    0x20(%rsp),%r9
  26492b:	jbe    264931 <<glass::engine::Watch>::print_utf8+0x1521>
  26492d:	mov    %eax,0x38(%r15)
  264931:	test   %r12,%r12
  264934:	mov    0x58(%rsp),%ebp
  264938:	mov    0xb8(%rsp),%r10
  264940:	je     26496c <<glass::engine::Watch>::print_utf8+0x155c>
  264942:	lock decq (%r12)
  264947:	jne    26496c <<glass::engine::Watch>::print_utf8+0x155c>
  264949:	lea    0x40(%rsp),%rdi
  26494e:	mov    %r8,%rbx
  264951:	call   *0x391371(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  264957:	mov    0x28(%rsp),%rdx
  26495c:	mov    %rbx,%r8
  26495f:	mov    0xb8(%rsp),%r10
  264967:	mov    0x20(%rsp),%r9
  26496c:	mov    0x10(%r15),%rcx
  264970:	mov    0xd8(%rsp),%r12
  264978:	cmp    %rcx,%r10
  26497b:	jb     26499f <<glass::engine::Watch>::print_utf8+0x158f>
  26497d:	mov    0x78(%rsp),%rdi
  264982:	mov    %r8,%rbx
  264985:	call   1ae350 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26498a:	mov    0x28(%rsp),%rdx
  26498f:	mov    %rbx,%r8
  264992:	mov    0x20(%rsp),%r9
  264997:	movl   $0xffffffff,0x28(%r15)
  26499f:	mov    0x30(%r15),%rax
  2649a3:	add    $0x2,%r9
  2649a7:	cmp    %rax,%r9
  2649aa:	cmovbe %rax,%r9
  2649ae:	mov    0x10(%r15),%rsi
  2649b2:	mov    %r9,0x30(%r15)
  2649b6:	cmp    %rsi,%r12
  2649b9:	jae    2654e9 <<glass::engine::Watch>::print_utf8+0x20d9>
  2649bf:	mov    0x8(%r15),%rax
  2649c3:	lea    (%r12,%r12,2),%rcx
  2649c7:	lea    (%rax,%rcx,8),%rbx
  2649cb:	movl   $0x20,0x10(%rax,%rcx,8)
  2649d3:	mov    %ebp,0x8(%rax,%rcx,8)
  2649d7:	mov    0xa0(%rsp),%esi
  2649de:	mov    %esi,0xc(%rax,%rcx,8)
  2649e2:	mov    0xc(%rsp),%esi
  2649e6:	or     $0x40,%esi
  2649e9:	mov    %si,0x14(%rax,%rcx,8)
  2649ee:	mov    (%rax,%rcx,8),%rax
  2649f2:	test   %rax,%rax
  2649f5:	je     264a11 <<glass::engine::Watch>::print_utf8+0x1601>
  2649f7:	lock decq (%rax)
  2649fb:	jne    264a11 <<glass::engine::Watch>::print_utf8+0x1601>
  2649fd:	mov    %rbx,%rdi
  264a00:	mov    %r8,%r15
  264a03:	call   *0x3912bf(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  264a09:	mov    0x28(%rsp),%rdx
  264a0e:	mov    %r15,%r8
  264a11:	movq   $0x0,(%rbx)
  264a18:	mov    0x70(%rsp),%rcx
  264a1d:	cmp    0x90(%rsp),%rcx
  264a25:	mov    0x18(%rsp),%rsi
  264a2a:	mov    0x60(%rsp),%rax
  264a2f:	jb     264a38 <<glass::engine::Watch>::print_utf8+0x1628>
  264a31:	dec    %rcx
  264a34:	movb   $0x1,0x6c(%rax)
  264a38:	mov    %rcx,0x40(%rax)
  264a3c:	mov    0xc8(%rsp),%r15
  264a44:	incq   0xa0(%r15)
  264a4b:	nopl   0x0(%rax,%rax,1)
  264a50:	add    %r14,%rdx
  264a53:	cmpb   $0x0,0x80(%rsp)
  264a5b:	je     263fa9 <<glass::engine::Watch>::print_utf8+0xb99>
  264a61:	jmp    2634c0 <<glass::engine::Watch>::print_utf8+0xb0>
  264a66:	mov    %r8,%rbx
  264a69:	mov    %rdx,%r14
  264a6c:	call   18c852 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  264a71:	mov    %r14,%rdx
  264a74:	mov    %rbx,%r8
  264a77:	mov    %ebp,%ebx
  264a79:	mov    0x3941b0(%rip),%rsi        # 5f8c30 <glass::engine::width_of::CACHE+0x8>
  264a80:	cmp    %rbx,%rsi
  264a83:	ja     2641ce <<glass::engine::Watch>::print_utf8+0xdbe>
  264a89:	jmp    2653e8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  264a8e:	cmpq   $0x400,0xa0(%r15)
  264a99:	jb     264ac4 <<glass::engine::Watch>::print_utf8+0x16b4>
  264a9b:	mov    %r15,%rdi
  264a9e:	call   265860 <<glass::engine::Watch>::fold_sentinel>
  264aa3:	movq   $0x0,0xa0(%r15)
  264aae:	mov    0x39418c(%rip),%eax        # 5f8c40 <glass::engine::run_whole::ON>
  264ab4:	test   %eax,%eax
  264ab6:	je     264ace <<glass::engine::Watch>::print_utf8+0x16be>
  264ab8:	call   18c8f6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  264abd:	cmp    %r13,%r14
  264ac0:	je     264ad3 <<glass::engine::Watch>::print_utf8+0x16c3>
  264ac2:	jmp    264b03 <<glass::engine::Watch>::print_utf8+0x16f3>
  264ac4:	mov    0x394176(%rip),%eax        # 5f8c40 <glass::engine::run_whole::ON>
  264aca:	test   %eax,%eax
  264acc:	jne    264ab8 <<glass::engine::Watch>::print_utf8+0x16a8>
  264ace:	cmp    %r13,%r14
  264ad1:	jne    264b03 <<glass::engine::Watch>::print_utf8+0x16f3>
  264ad3:	cmpb   $0x0,0x39416a(%rip)        # 5f8c44 <glass::engine::run_whole::ON+0x4>
  264ada:	je     264b03 <<glass::engine::Watch>::print_utf8+0x16f3>
  264adc:	cmp    $0xffffffff,%ebp
  264adf:	je     264ca5 <<glass::engine::Watch>::print_utf8+0x1895>
  264ae5:	lea    -0x20(%rbp),%eax
  264ae8:	cmp    $0x5f,%eax
  264aeb:	jae    264b14 <<glass::engine::Watch>::print_utf8+0x1704>
  264aed:	mov    $0x1,%r13d
  264af3:	cmpb   $0x0,0x10(%rsp)
  264af8:	jne    264bdf <<glass::engine::Watch>::print_utf8+0x17cf>
  264afe:	jmp    264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264b03:	xor    %eax,%eax
  264b05:	cmp    $0xffffffff,%ebp
  264b08:	cmove  %rax,%rbx
  264b0c:	mov    %rbx,%r13
  264b0f:	jmp    264ca5 <<glass::engine::Watch>::print_utf8+0x1895>
  264b14:	cmpb   $0x0,0x80(%rsp)
  264b1c:	je     264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264b22:	mov    0x394110(%rip),%eax        # 5f8c38 <glass::engine::width_of::CACHE+0x10>
  264b28:	test   %eax,%eax
  264b2a:	jne    2653d1 <<glass::engine::Watch>::print_utf8+0x1fc1>
  264b30:	mov    %ebp,%ebx
  264b32:	mov    0x3940f7(%rip),%rsi        # 5f8c30 <glass::engine::width_of::CACHE+0x8>
  264b39:	cmp    %rbx,%rsi
  264b3c:	jbe    2653e8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  264b42:	mov    0x3940df(%rip),%r14        # 5f8c28 <glass::engine::width_of::CACHE>
  264b49:	movzbl (%r14,%rbx,1),%eax
  264b4e:	movzbl %al,%r13d
  264b52:	test   %r13b,%r13b
  264b55:	js     264b62 <<glass::engine::Watch>::print_utf8+0x1752>
  264b57:	mov    $0x1,%cl
  264b59:	test   %cl,%cl
  264b5b:	jne    264bd1 <<glass::engine::Watch>::print_utf8+0x17c1>
  264b5d:	jmp    264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264b62:	cmp    $0xfe,%r13d
  264b69:	je     264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264b6f:	mov    $0xfe,%al
  264b71:	cmp    $0x7f,%ebp
  264b74:	jae    264bac <<glass::engine::Watch>::print_utf8+0x179c>
  264b76:	mov    $0x1,%r13d
  264b7c:	xor    %ecx,%ecx
  264b7e:	jmp    264bc5 <<glass::engine::Watch>::print_utf8+0x17b5>
  264b80:	mov    $0x1,%cl
  264b82:	mov    %ecx,0x80(%rsp)
  264b89:	cmpb   $0x0,0x68(%rax)
  264b8d:	jne    264b9f <<glass::engine::Watch>::print_utf8+0x178f>
  264b8f:	cmpb   $0x0,0x69(%rax)
  264b93:	jne    264b9f <<glass::engine::Watch>::print_utf8+0x178f>
  264b95:	cmpb   $0x0,0x6a(%rax)
  264b99:	je     264dbe <<glass::engine::Watch>::print_utf8+0x19ae>
  264b9f:	movl   $0x0,0x10(%rsp)
  264ba7:	jmp    26346e <<glass::engine::Watch>::print_utf8+0x5e>
  264bac:	cmp    $0xa0,%ebp
  264bb2:	jb     264bc3 <<glass::engine::Watch>::print_utf8+0x17b3>
  264bb4:	mov    %ebp,%edi
  264bb6:	call   299ae0 <unicode_width::tables::lookup_width>
  264bbb:	movzbl %al,%r13d
  264bbf:	mov    $0x1,%cl
  264bc1:	jmp    264bc5 <<glass::engine::Watch>::print_utf8+0x17b5>
  264bc3:	xor    %ecx,%ecx
  264bc5:	mov    %al,(%r14,%rbx,1)
  264bc9:	test   %cl,%cl
  264bcb:	je     264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264bd1:	lea    -0x1(%r13),%rax
  264bd5:	cmp    $0x1,%rax
  264bd9:	ja     264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264bdf:	mov    0x78(%r15),%r14
  264be3:	cmpb   $0x0,0x6c(%r14)
  264be8:	jne    264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264bee:	mov    0x40(%r14),%r12
  264bf2:	mov    0xa0(%r14),%r8
  264bf9:	lea    (%r12,%r13,1),%rdx
  264bfd:	cmp    %r8,%rdx
  264c00:	ja     264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264c06:	mov    0x30(%r14),%eax
  264c0a:	sub    0x48(%r14),%eax
  264c0e:	cltq
  264c10:	mov    0x20(%r14),%rsi
  264c14:	mov    0x28(%r14),%rcx
  264c18:	lea    (%rcx,%rax,1),%rdi
  264c1c:	dec    %rdi
  264c1f:	xor    %eax,%eax
  264c21:	cmp    %rsi,%rdi
  264c24:	cmovae %rsi,%rax
  264c28:	sub    %rax,%rdi
  264c2b:	cmp    %rsi,%rdi
  264c2e:	jae    26548b <<glass::engine::Watch>::print_utf8+0x207b>
  264c34:	mov    0x58(%r14),%r10d
  264c38:	mov    0x5c(%r14),%r11d
  264c3c:	movzwl 0x64(%r14),%r9d
  264c41:	mov    0x18(%r14),%rax
  264c45:	shl    $0x6,%rdi
  264c49:	lea    (%rax,%rdi,1),%rbx
  264c4d:	lea    (%rax,%rdi,1),%rcx
  264c51:	add    $0x18,%rcx
  264c55:	mov    %rcx,0x80(%rsp)
  264c5d:	mov    0x28(%rax,%rdi,1),%eax
  264c61:	cmp    $0xffffffff,%eax
  264c64:	je     264c74 <<glass::engine::Watch>::print_utf8+0x1864>
  264c66:	mov    0x80(%rsp),%rcx
  264c6e:	cmp    0x30(%rbx),%r12
  264c72:	jae    264c8d <<glass::engine::Watch>::print_utf8+0x187d>
  264c74:	mov    0x10(%rbx),%rsi
  264c78:	cmp    %rsi,%r12
  264c7b:	jae    2654f9 <<glass::engine::Watch>::print_utf8+0x20e9>
  264c81:	lea    (%r12,%r12,2),%rcx
  264c85:	shl    $0x3,%rcx
  264c89:	add    0x8(%rbx),%rcx
  264c8d:	testb  $0x60,0x14(%rcx)
  264c91:	je     264cba <<glass::engine::Watch>::print_utf8+0x18aa>
  264c93:	mov    %r15,%rdi
  264c96:	mov    %ebp,%esi
  264c98:	call   340a50 <<glass::engine::Watch as vte::ansi::Handler>::input>
  264c9d:	mov    0xc0(%rsp),%r13
  264ca5:	mov    %r13,%rax
  264ca8:	add    $0x118,%rsp
  264caf:	pop    %rbx
  264cb0:	pop    %r12
  264cb2:	pop    %r13
  264cb4:	pop    %r14
  264cb6:	pop    %r15
  264cb8:	pop    %rbp
  264cb9:	ret
  264cba:	cmp    $0x2,%r13
  264cbe:	jne    264cf7 <<glass::engine::Watch>::print_utf8+0x18e7>
  264cc0:	lea    0x1(%r12),%rdi
  264cc5:	cmp    $0xffffffff,%eax
  264cc8:	je     264cd8 <<glass::engine::Watch>::print_utf8+0x18c8>
  264cca:	mov    0x80(%rsp),%rcx
  264cd2:	cmp    0x30(%rbx),%rdi
  264cd6:	jae    264cf1 <<glass::engine::Watch>::print_utf8+0x18e1>
  264cd8:	mov    0x10(%rbx),%rsi
  264cdc:	cmp    %rsi,%rdi
  264cdf:	jae    2654bc <<glass::engine::Watch>::print_utf8+0x20ac>
  264ce5:	lea    (%rdi,%rdi,2),%rcx
  264ce9:	shl    $0x3,%rcx
  264ced:	add    0x8(%rbx),%rcx
  264cf1:	testb  $0x60,0x14(%rcx)
  264cf5:	jne    264c93 <<glass::engine::Watch>::print_utf8+0x1883>
  264cf7:	mov    %r11d,0x78(%rsp)
  264cfc:	mov    %r10d,0x28(%rsp)
  264d01:	mov    %r9d,0x30(%rsp)
  264d06:	mov    %r8,0x58(%rsp)
  264d0b:	mov    %rdx,0xa0(%rsp)
  264d13:	cmp    %r12d,0x38(%rbx)
  264d17:	jbe    264d1d <<glass::engine::Watch>::print_utf8+0x190d>
  264d19:	mov    %r12d,0x38(%rbx)
  264d1d:	cmp    $0xffffffff,%eax
  264d20:	setne  %cl
  264d23:	mov    %rbx,%rdi
  264d26:	mov    0x30(%rbx),%rbx
  264d2a:	cmp    %rbx,%r12
  264d2d:	sete   %dl
  264d30:	test   %dl,%cl
  264d32:	mov    %rdi,0x18(%rsp)
  264d37:	jne    264d85 <<glass::engine::Watch>::print_utf8+0x1975>
  264d39:	cmp    $0xffffffff,%eax
  264d3c:	je     264fef <<glass::engine::Watch>::print_utf8+0x1bdf>
  264d42:	mov    0x18(%rsp),%rax
  264d47:	mov    0x10(%rax),%r15
  264d4b:	cmp    %rbx,%r15
  264d4e:	mov    %rbx,%rax
  264d51:	cmovb  %r15,%rax
  264d55:	mov    %rax,0x10(%rsp)
  264d5a:	cmp    %r12,%r15
  264d5d:	mov    %r12,%rcx
  264d60:	cmovb  %r15,%rcx
  264d64:	mov    0x391015(%rip),%rax        # 5f5d80 <_DYNAMIC+0x320>
  264d6b:	movzbl (%rax),%eax
  264d6e:	test   %al,%al
  264d70:	mov    %rcx,0x20(%rsp)
  264d75:	je     264dec <<glass::engine::Watch>::print_utf8+0x19dc>
  264d77:	cmp    %rcx,%rbx
  264d7a:	jae    264dce <<glass::engine::Watch>::print_utf8+0x19be>
  264d7c:	mov    0x39103d(%rip),%rax        # 5f5dc0 <_DYNAMIC+0x360>
  264d83:	jmp    264dd5 <<glass::engine::Watch>::print_utf8+0x19c5>
  264d85:	lea    0x1(%r12),%rax
  264d8a:	mov    %rax,0x30(%rdi)
  264d8e:	mov    0x10(%rdi),%rsi
  264d92:	cmp    %rsi,%r12
  264d95:	mov    %rdi,%rdx
  264d98:	jb     265015 <<glass::engine::Watch>::print_utf8+0x1c05>
  264d9e:	lea    0x368643(%rip),%rdx        # 5cd3e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c68>
  264da5:	mov    %r12,%rdi
  264da8:	call   *0x390eca(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  264dae:	lea    0x36858b(%rip),%rcx        # 5cd340 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc0>
  264db5:	mov    %r12,%rdi
  264db8:	call   *0x39107a(%rip)        # 5f5e38 <_DYNAMIC+0x3d8>
  264dbe:	cmpb   $0x0,0x6b(%rax)
  264dc2:	sete   %al
  264dc5:	mov    %eax,0x10(%rsp)
  264dc9:	jmp    26346e <<glass::engine::Watch>::print_utf8+0x5e>
  264dce:	mov    0x390fe3(%rip),%rax        # 5f5db8 <_DYNAMIC+0x358>
  264dd5:	lock incq 0x28(%rax)
  264dda:	mov    %rcx,%rdi
  264ddd:	sub    0x10(%rsp),%rdi
  264de2:	call   2f9c60 <alacritty_terminal::grid::row::fill_census::note>
  264de7:	mov    0x20(%rsp),%rcx
  264dec:	cmp    %rcx,%rbx
  264def:	jae    264fc9 <<glass::engine::Watch>::print_utf8+0x1bb9>
  264df5:	mov    0x18(%rsp),%rcx
  264dfa:	mov    0x28(%rcx),%edi
  264dfd:	mov    0x20(%rcx),%r8d
  264e01:	mov    0x24(%rcx),%r9d
  264e05:	movzwl 0x2c(%rcx),%r10d
  264e0a:	mov    0x18(%rcx),%rsi
  264e0e:	test   %rsi,%rsi
  264e11:	mov    %rsi,0x38(%rsp)
  264e16:	mov    %edi,0xc(%rsp)
  264e1a:	mov    %r8d,0x60(%rsp)
  264e1f:	mov    %r9d,0x70(%rsp)
  264e24:	mov    %r10w,0x90(%rsp)
  264e2d:	je     264ef6 <<glass::engine::Watch>::print_utf8+0x1ae6>
  264e33:	lock incq (%rsi)
  264e37:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  264e3d:	mov    0x10(%rcx),%rdx
  264e41:	mov    %edi,0x50(%rsp)
  264e45:	mov    %r8d,0x48(%rsp)
  264e4a:	mov    %r9d,0x4c(%rsp)
  264e4f:	mov    %r10w,0x54(%rsp)
  264e55:	mov    %rsi,0x40(%rsp)
  264e5a:	mov    0x20(%rsp),%rsi
  264e5f:	cmp    %rdx,%rsi
  264e62:	ja     265477 <<glass::engine::Watch>::print_utf8+0x2067>
  264e68:	mov    0x10(%rsp),%rax
  264e6d:	lea    0x0(,%rax,8),%rax
  264e75:	lea    (%rax,%rax,2),%rax
  264e79:	mov    0x8(%rcx),%rbx
  264e7d:	add    %rax,%rbx
  264e80:	lea    0x0(,%rsi,8),%rcx
  264e88:	lea    (%rcx,%rcx,2),%r15
  264e8c:	sub    %rax,%r15
  264e8f:	mov    0x38(%rsp),%rsi
  264e94:	jmp    264eb7 <<glass::engine::Watch>::print_utf8+0x1aa7>
  264e96:	mov    %rsi,(%rbx)
  264e99:	mov    %r8d,0x8(%rbx)
  264e9d:	mov    %r9d,0xc(%rbx)
  264ea1:	mov    %edi,0x10(%rbx)
  264ea4:	mov    %r10w,0x14(%rbx)
  264ea9:	add    $0x18,%rbx
  264ead:	add    $0xffffffffffffffe8,%r15
  264eb1:	je     264f93 <<glass::engine::Watch>::print_utf8+0x1b83>
  264eb7:	lock incq (%rsi)
  264ebb:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  264ec1:	mov    (%rbx),%rax
  264ec4:	test   %rax,%rax
  264ec7:	je     264e96 <<glass::engine::Watch>::print_utf8+0x1a86>
  264ec9:	lock decq (%rax)
  264ecd:	jne    264e96 <<glass::engine::Watch>::print_utf8+0x1a86>
  264ecf:	mov    %rbx,%rdi
  264ed2:	call   *0x390df0(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  264ed8:	movzwl 0x90(%rsp),%r10d
  264ee1:	mov    0x70(%rsp),%r9d
  264ee6:	mov    0x60(%rsp),%r8d
  264eeb:	mov    0xc(%rsp),%edi
  264eef:	mov    0x38(%rsp),%rsi
  264ef4:	jmp    264e96 <<glass::engine::Watch>::print_utf8+0x1a86>
  264ef6:	mov    %edi,0x50(%rsp)
  264efa:	mov    %r8d,0x48(%rsp)
  264eff:	mov    %r9d,0x4c(%rsp)
  264f04:	mov    %r10w,0x54(%rsp)
  264f0a:	mov    %rsi,0x40(%rsp)
  264f0f:	mov    0x10(%rsp),%rax
  264f14:	lea    0x0(,%rax,8),%rax
  264f1c:	lea    (%rax,%rax,2),%rax
  264f20:	mov    0x8(%rcx),%rbx
  264f24:	add    %rax,%rbx
  264f27:	mov    0x20(%rsp),%rcx
  264f2c:	lea    0x0(,%rcx,8),%rcx
  264f34:	lea    (%rcx,%rcx,2),%r15
  264f38:	sub    %rax,%r15
  264f3b:	jmp    264f5e <<glass::engine::Watch>::print_utf8+0x1b4e>
  264f3d:	movq   $0x0,(%rbx)
  264f44:	mov    %r8d,0x8(%rbx)
  264f48:	mov    %r9d,0xc(%rbx)
  264f4c:	mov    %edi,0x10(%rbx)
  264f4f:	mov    %r10w,0x14(%rbx)
  264f54:	add    $0x18,%rbx
  264f58:	add    $0xffffffffffffffe8,%r15
  264f5c:	je     264f93 <<glass::engine::Watch>::print_utf8+0x1b83>
  264f5e:	mov    (%rbx),%rax
  264f61:	test   %rax,%rax
  264f64:	je     264f3d <<glass::engine::Watch>::print_utf8+0x1b2d>
  264f66:	lock decq (%rax)
  264f6a:	jne    264f3d <<glass::engine::Watch>::print_utf8+0x1b2d>
  264f6c:	mov    %rbx,%rdi
  264f6f:	call   *0x390d53(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  264f75:	movzwl 0x90(%rsp),%r10d
  264f7e:	mov    0x70(%rsp),%r9d
  264f83:	mov    0x60(%rsp),%r8d
  264f88:	mov    0xc(%rsp),%edi
  264f8c:	mov    0x38(%rsp),%rsi
  264f91:	jmp    264f3d <<glass::engine::Watch>::print_utf8+0x1b2d>
  264f93:	mov    0x18(%rsp),%rbx
  264f98:	mov    0x10(%rsp),%rax
  264f9d:	cmp    %eax,0x38(%rbx)
  264fa0:	jbe    264fa5 <<glass::engine::Watch>::print_utf8+0x1b95>
  264fa2:	mov    %eax,0x38(%rbx)
  264fa5:	test   %rsi,%rsi
  264fa8:	mov    0x20(%rsp),%rcx
  264fad:	je     264fc5 <<glass::engine::Watch>::print_utf8+0x1bb5>
  264faf:	lock decq (%rsi)
  264fb3:	jne    264fc5 <<glass::engine::Watch>::print_utf8+0x1bb5>
  264fb5:	lea    0x40(%rsp),%rdi
  264fba:	call   *0x390d08(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  264fc0:	mov    0x20(%rsp),%rcx
  264fc5:	mov    0x10(%rbx),%r15
  264fc9:	cmp    %r15,%rcx
  264fcc:	mov    0xc8(%rsp),%r15
  264fd4:	jb     264fef <<glass::engine::Watch>::print_utf8+0x1bdf>
  264fd6:	mov    0x80(%rsp),%rdi
  264fde:	call   1ae350 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  264fe3:	mov    0x18(%rsp),%rax
  264fe8:	movl   $0xffffffff,0x28(%rax)
  264fef:	mov    0x18(%rsp),%rdx
  264ff4:	mov    0x30(%rdx),%rax
  264ff8:	lea    0x1(%r12),%rcx
  264ffd:	cmp    %rax,%rcx
  265000:	cmova  %rcx,%rax
  265004:	mov    0x10(%rdx),%rsi
  265008:	mov    %rax,0x30(%rdx)
  26500c:	cmp    %rsi,%r12
  26500f:	jae    2654e9 <<glass::engine::Watch>::print_utf8+0x20d9>
  265015:	mov    0x30(%rsp),%esi
  265019:	mov    %esi,%eax
  26501b:	or     $0x20,%eax
  26501e:	cmp    $0x2,%r13
  265022:	mov    0x8(%rdx),%rcx
  265026:	lea    (%r12,%r12,2),%rdx
  26502a:	lea    (%rcx,%rdx,8),%rbx
  26502e:	mov    %ebp,0x10(%rcx,%rdx,8)
  265032:	mov    0x28(%rsp),%edi
  265036:	mov    %edi,0x8(%rcx,%rdx,8)
  26503a:	cmovne %esi,%eax
  26503d:	mov    0x78(%rsp),%esi
  265041:	mov    %esi,0xc(%rcx,%rdx,8)
  265045:	mov    %ax,0x14(%rcx,%rdx,8)
  26504a:	mov    (%rcx,%rdx,8),%rax
  26504e:	test   %rax,%rax
  265051:	je     265062 <<glass::engine::Watch>::print_utf8+0x1c52>
  265053:	lock decq (%rax)
  265057:	jne    265062 <<glass::engine::Watch>::print_utf8+0x1c52>
  265059:	mov    %rbx,%rdi
  26505c:	call   *0x390c66(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  265062:	movq   $0x0,(%rbx)
  265069:	cmp    $0x2,%r13
  26506d:	mov    0xc0(%rsp),%r13
  265075:	jne    2653a3 <<glass::engine::Watch>::print_utf8+0x1f93>
  26507b:	lea    0x1(%r12),%rcx
  265080:	mov    0x18(%rsp),%rax
  265085:	mov    0x30(%rax),%rbx
  265089:	mov    0x28(%rax),%eax
  26508c:	mov    %rcx,0x38(%rsp)
  265091:	cmp    %rbx,%rcx
  265094:	jne    2650c7 <<glass::engine::Watch>::print_utf8+0x1cb7>
  265096:	cmp    $0xffffffff,%eax
  265099:	je     2650c7 <<glass::engine::Watch>::print_utf8+0x1cb7>
  26509b:	add    $0x2,%r12
  26509f:	mov    0x18(%rsp),%rcx
  2650a4:	mov    %r12,0x30(%rcx)
  2650a8:	mov    0x10(%rcx),%rsi
  2650ac:	mov    0x38(%rsp),%rdi
  2650b1:	cmp    %rsi,%rdi
  2650b4:	jb     265354 <<glass::engine::Watch>::print_utf8+0x1f44>
  2650ba:	lea    0x368327(%rip),%rdx        # 5cd3e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c68>
  2650c1:	call   *0x390bb1(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  2650c7:	cmp    $0xffffffff,%eax
  2650ca:	je     26532a <<glass::engine::Watch>::print_utf8+0x1f1a>
  2650d0:	mov    0x18(%rsp),%rax
  2650d5:	mov    0x10(%rax),%r15
  2650d9:	cmp    %rbx,%r15
  2650dc:	mov    %rbx,%rax
  2650df:	cmovb  %r15,%rax
  2650e3:	mov    %rax,0x10(%rsp)
  2650e8:	lea    0x1(%r12),%rcx
  2650ed:	cmp    %rcx,%r15
  2650f0:	cmovb  %r15,%rcx
  2650f4:	mov    0x390c85(%rip),%rax        # 5f5d80 <_DYNAMIC+0x320>
  2650fb:	movzbl (%rax),%eax
  2650fe:	test   %al,%al
  265100:	mov    %rcx,0x20(%rsp)
  265105:	je     265133 <<glass::engine::Watch>::print_utf8+0x1d23>
  265107:	cmp    %rcx,%rbx
  26510a:	jae    265115 <<glass::engine::Watch>::print_utf8+0x1d05>
  26510c:	mov    0x390cad(%rip),%rax        # 5f5dc0 <_DYNAMIC+0x360>
  265113:	jmp    26511c <<glass::engine::Watch>::print_utf8+0x1d0c>
  265115:	mov    0x390c9c(%rip),%rax        # 5f5db8 <_DYNAMIC+0x358>
  26511c:	lock incq 0x28(%rax)
  265121:	mov    %rcx,%rdi
  265124:	sub    0x10(%rsp),%rdi
  265129:	call   2f9c60 <alacritty_terminal::grid::row::fill_census::note>
  26512e:	mov    0x20(%rsp),%rcx
  265133:	cmp    %rcx,%rbx
  265136:	jae    265304 <<glass::engine::Watch>::print_utf8+0x1ef4>
  26513c:	mov    0x18(%rsp),%rcx
  265141:	mov    0x28(%rcx),%edi
  265144:	mov    0x20(%rcx),%r8d
  265148:	mov    0x24(%rcx),%r9d
  26514c:	movzwl 0x2c(%rcx),%r10d
  265151:	mov    0x18(%rcx),%r15
  265155:	test   %r15,%r15
  265158:	mov    %edi,0xc(%rsp)
  26515c:	mov    %r8d,0x60(%rsp)
  265161:	mov    %r9d,0x70(%rsp)
  265166:	mov    %r10w,0x90(%rsp)
  26516f:	je     26522e <<glass::engine::Watch>::print_utf8+0x1e1e>
  265175:	lock incq (%r15)
  265179:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  26517f:	mov    0x10(%rcx),%rdx
  265183:	mov    %edi,0x50(%rsp)
  265187:	mov    %r8d,0x48(%rsp)
  26518c:	mov    %r9d,0x4c(%rsp)
  265191:	mov    %r10w,0x54(%rsp)
  265197:	mov    %r15,0x40(%rsp)
  26519c:	mov    0x20(%rsp),%rsi
  2651a1:	cmp    %rdx,%rsi
  2651a4:	ja     2654a8 <<glass::engine::Watch>::print_utf8+0x2098>
  2651aa:	mov    0x10(%rsp),%rax
  2651af:	lea    0x0(,%rax,8),%rax
  2651b7:	lea    (%rax,%rax,2),%rax
  2651bb:	mov    0x8(%rcx),%rbx
  2651bf:	add    %rax,%rbx
  2651c2:	lea    0x0(,%rsi,8),%rcx
  2651ca:	lea    (%rcx,%rcx,2),%r13
  2651ce:	sub    %rax,%r13
  2651d1:	jmp    2651f4 <<glass::engine::Watch>::print_utf8+0x1de4>
  2651d3:	mov    %r15,(%rbx)
  2651d6:	mov    %r8d,0x8(%rbx)
  2651da:	mov    %r9d,0xc(%rbx)
  2651de:	mov    %edi,0x10(%rbx)
  2651e1:	mov    %r10w,0x14(%rbx)
  2651e6:	add    $0x18,%rbx
  2651ea:	add    $0xffffffffffffffe8,%r13
  2651ee:	je     2652c6 <<glass::engine::Watch>::print_utf8+0x1eb6>
  2651f4:	lock incq (%r15)
  2651f8:	jle    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  2651fe:	mov    (%rbx),%rax
  265201:	test   %rax,%rax
  265204:	je     2651d3 <<glass::engine::Watch>::print_utf8+0x1dc3>
  265206:	lock decq (%rax)
  26520a:	jne    2651d3 <<glass::engine::Watch>::print_utf8+0x1dc3>
  26520c:	mov    %rbx,%rdi
  26520f:	call   *0x390ab3(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  265215:	movzwl 0x90(%rsp),%r10d
  26521e:	mov    0x70(%rsp),%r9d
  265223:	mov    0x60(%rsp),%r8d
  265228:	mov    0xc(%rsp),%edi
  26522c:	jmp    2651d3 <<glass::engine::Watch>::print_utf8+0x1dc3>
  26522e:	mov    %edi,0x50(%rsp)
  265232:	mov    %r8d,0x48(%rsp)
  265237:	mov    %r9d,0x4c(%rsp)
  26523c:	mov    %r10w,0x54(%rsp)
  265242:	mov    %r15,0x40(%rsp)
  265247:	mov    0x10(%rsp),%rax
  26524c:	lea    0x0(,%rax,8),%rax
  265254:	lea    (%rax,%rax,2),%rax
  265258:	mov    0x8(%rcx),%rbx
  26525c:	add    %rax,%rbx
  26525f:	mov    0x20(%rsp),%rcx
  265264:	lea    0x0(,%rcx,8),%rcx
  26526c:	lea    (%rcx,%rcx,2),%r13
  265270:	sub    %rax,%r13
  265273:	jmp    265296 <<glass::engine::Watch>::print_utf8+0x1e86>
  265275:	movq   $0x0,(%rbx)
  26527c:	mov    %r8d,0x8(%rbx)
  265280:	mov    %r9d,0xc(%rbx)
  265284:	mov    %edi,0x10(%rbx)
  265287:	mov    %r10w,0x14(%rbx)
  26528c:	add    $0x18,%rbx
  265290:	add    $0xffffffffffffffe8,%r13
  265294:	je     2652c6 <<glass::engine::Watch>::print_utf8+0x1eb6>
  265296:	mov    (%rbx),%rax
  265299:	test   %rax,%rax
  26529c:	je     265275 <<glass::engine::Watch>::print_utf8+0x1e65>
  26529e:	lock decq (%rax)
  2652a2:	jne    265275 <<glass::engine::Watch>::print_utf8+0x1e65>
  2652a4:	mov    %rbx,%rdi
  2652a7:	call   *0x390a1b(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  2652ad:	movzwl 0x90(%rsp),%r10d
  2652b6:	mov    0x70(%rsp),%r9d
  2652bb:	mov    0x60(%rsp),%r8d
  2652c0:	mov    0xc(%rsp),%edi
  2652c4:	jmp    265275 <<glass::engine::Watch>::print_utf8+0x1e65>
  2652c6:	mov    0x18(%rsp),%rbx
  2652cb:	mov    0x10(%rsp),%rax
  2652d0:	cmp    %eax,0x38(%rbx)
  2652d3:	jbe    2652d8 <<glass::engine::Watch>::print_utf8+0x1ec8>
  2652d5:	mov    %eax,0x38(%rbx)
  2652d8:	test   %r15,%r15
  2652db:	mov    0xc0(%rsp),%r13
  2652e3:	mov    0x20(%rsp),%rcx
  2652e8:	je     265300 <<glass::engine::Watch>::print_utf8+0x1ef0>
  2652ea:	lock decq (%r15)
  2652ee:	jne    265300 <<glass::engine::Watch>::print_utf8+0x1ef0>
  2652f0:	lea    0x40(%rsp),%rdi
  2652f5:	call   *0x3909cd(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  2652fb:	mov    0x20(%rsp),%rcx
  265300:	mov    0x10(%rbx),%r15
  265304:	cmp    %r15,%rcx
  265307:	mov    0xc8(%rsp),%r15
  26530f:	jb     26532a <<glass::engine::Watch>::print_utf8+0x1f1a>
  265311:	mov    0x80(%rsp),%rdi
  265319:	call   1ae350 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26531e:	mov    0x18(%rsp),%rax
  265323:	movl   $0xffffffff,0x28(%rax)
  26532a:	mov    0x18(%rsp),%rcx
  26532f:	mov    0x30(%rcx),%rax
  265333:	add    $0x2,%r12
  265337:	cmp    %rax,%r12
  26533a:	cmovbe %rax,%r12
  26533e:	mov    0x10(%rcx),%rsi
  265342:	mov    %r12,0x30(%rcx)
  265346:	mov    0x38(%rsp),%rdi
  26534b:	cmp    %rsi,%rdi
  26534e:	jae    265509 <<glass::engine::Watch>::print_utf8+0x20f9>
  265354:	mov    0x8(%rcx),%rax
  265358:	lea    (%rdi,%rdi,2),%rcx
  26535c:	lea    (%rax,%rcx,8),%rbx
  265360:	movl   $0x20,0x10(%rax,%rcx,8)
  265368:	mov    0x28(%rsp),%edx
  26536c:	mov    %edx,0x8(%rax,%rcx,8)
  265370:	mov    0x78(%rsp),%edx
  265374:	mov    %edx,0xc(%rax,%rcx,8)
  265378:	mov    0x30(%rsp),%edx
  26537c:	or     $0x40,%edx
  26537f:	mov    %dx,0x14(%rax,%rcx,8)
  265384:	mov    (%rax,%rcx,8),%rax
  265388:	test   %rax,%rax
  26538b:	je     26539c <<glass::engine::Watch>::print_utf8+0x1f8c>
  26538d:	lock decq (%rax)
  265391:	jne    26539c <<glass::engine::Watch>::print_utf8+0x1f8c>
  265393:	mov    %rbx,%rdi
  265396:	call   *0x39092c(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  26539c:	movq   $0x0,(%rbx)
  2653a3:	mov    0xa0(%rsp),%rax
  2653ab:	cmp    0x58(%rsp),%rax
  2653b0:	jb     2653ba <<glass::engine::Watch>::print_utf8+0x1faa>
  2653b2:	dec    %rax
  2653b5:	movb   $0x1,0x6c(%r14)
  2653ba:	mov    %rax,0x40(%r14)
  2653be:	incq   0xa0(%r15)
  2653c5:	mov    %ebp,0xb0(%r15)
  2653cc:	jmp    264ca5 <<glass::engine::Watch>::print_utf8+0x1895>
  2653d1:	call   18c852 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2653d6:	mov    %ebp,%ebx
  2653d8:	mov    0x393851(%rip),%rsi        # 5f8c30 <glass::engine::width_of::CACHE+0x8>
  2653df:	cmp    %rbx,%rsi
  2653e2:	ja     264b42 <<glass::engine::Watch>::print_utf8+0x1732>
  2653e8:	lea    0x36a1e9(%rip),%rdx        # 5cf5d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17e58>
  2653ef:	mov    %rbx,%rdi
  2653f2:	call   *0x390880(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  2653f8:	lea    0x3673e9(%rip),%rcx        # 5cc7e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  2653ff:	mov    0xa8(%rsp),%rdi
  265407:	call   *0x390a2b(%rip)        # 5f5e38 <_DYNAMIC+0x3d8>
  26540d:	jmp    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  265412:	lea    0x3673cf(%rip),%rcx        # 5cc7e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  265419:	call   *0x390a19(%rip)        # 5f5e38 <_DYNAMIC+0x3d8>
  26541f:	jmp    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  265424:	lea    0x3678b5(%rip),%rdx        # 5ccce0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15560>
  26542b:	call   *0x390847(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  265431:	lea    0x3678c0(%rip),%rax        # 5cccf8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15578>
  265438:	jmp    265459 <<glass::engine::Watch>::print_utf8+0x2049>
  26543a:	lea    0x3678ff(%rip),%rdx        # 5ccd40 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155c0>
  265441:	mov    %rbx,%rdi
  265444:	mov    0x30(%rsp),%rsi
  265449:	call   *0x390829(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  26544f:	mov    %rax,%rbx
  265452:	lea    0x3678b7(%rip),%rax        # 5ccd10 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15590>
  265459:	mov    %rax,0xf0(%rsp)
  265461:	mov    %rbx,%rdi
  265464:	mov    0x30(%rsp),%rsi
  265469:	mov    0xf0(%rsp),%rdx
  265471:	call   *0x390801(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  265477:	lea    0x36736a(%rip),%rcx        # 5cc7e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  26547e:	mov    0x10(%rsp),%rdi
  265483:	call   *0x3909af(%rip)        # 5f5e38 <_DYNAMIC+0x3d8>
  265489:	jmp    2654ba <<glass::engine::Watch>::print_utf8+0x20aa>
  26548b:	lea    0x3679ce(%rip),%rdx        # 5cce60 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x156e0>
  265492:	call   *0x3907e0(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  265498:	lea    0x355969(%rip),%rdx        # 5bae08 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  26549f:	mov    %rbx,%rdi
  2654a2:	call   *0x3907d0(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  2654a8:	lea    0x367339(%rip),%rcx        # 5cc7e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  2654af:	mov    0x10(%rsp),%rdi
  2654b4:	call   *0x39097e(%rip)        # 5f5e38 <_DYNAMIC+0x3d8>
  2654ba:	ud2
  2654bc:	lea    0x355945(%rip),%rdx        # 5bae08 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  2654c3:	call   *0x3907af(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  2654c9:	lea    0x367f18(%rip),%rdx        # 5cd3e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c68>
  2654d0:	mov    %rbx,%rdi
  2654d3:	call   *0x39079f(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  2654d9:	lea    0x367ef0(%rip),%rdx        # 5cd3d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c50>
  2654e0:	mov    %rbx,%rdi
  2654e3:	call   *0x39078f(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  2654e9:	lea    0x367ee0(%rip),%rdx        # 5cd3d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c50>
  2654f0:	mov    %r12,%rdi
  2654f3:	call   *0x39077f(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  2654f9:	lea    0x355908(%rip),%rdx        # 5bae08 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  265500:	mov    %r12,%rdi
  265503:	call   *0x39076f(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  265509:	lea    0x367ec0(%rip),%rdx        # 5cd3d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c50>
  265510:	call   *0x390762(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  265516:	mov    %rax,%rbx
  265519:	lock decq (%r15)
  26551d:	je     265546 <<glass::engine::Watch>::print_utf8+0x2136>
  26551f:	jmp    265554 <<glass::engine::Watch>::print_utf8+0x2144>
  265521:	mov    %rax,%rbx
  265524:	mov    0x38(%rsp),%rax
  265529:	jmp    265540 <<glass::engine::Watch>::print_utf8+0x2130>
  26552b:	mov    %rax,%rbx
  26552e:	mov    0x98(%rsp),%rax
  265536:	jmp    265540 <<glass::engine::Watch>::print_utf8+0x2130>
  265538:	mov    %rax,%rbx
  26553b:	mov    0x68(%rsp),%rax
  265540:	lock decq (%rax)
  265544:	jne    265554 <<glass::engine::Watch>::print_utf8+0x2144>
  265546:	mov    0x110(%rsp),%rdi
  26554e:	call   *0x390774(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  265554:	mov    %rbx,%rdi
  265557:	call   5b4070 <_Unwind_Resume@plt>
