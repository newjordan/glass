
/tmp/glass-i28-candidate-test:     file format elf64-x86-64


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
  2623b4:	mov    %rdi,%r14
  2623b7:	cmpb   $0x1,0xbe(%rdi)
  2623be:	jne    2623eb <<glass::engine::Watch>::print_utf8+0x4b>
  2623c0:	cmpq   $0x0,0x38(%r14)
  2623c5:	jne    2623eb <<glass::engine::Watch>::print_utf8+0x4b>
  2623c7:	mov    0x78(%r14),%rax
  2623cb:	testb  $0x4,0x6c5(%rax)
  2623d2:	jne    2623eb <<glass::engine::Watch>::print_utf8+0x4b>
  2623d4:	cmpq   $0x0,0x50(%rax)
  2623d9:	jne    2623eb <<glass::engine::Watch>::print_utf8+0x4b>
  2623db:	movzwl 0x64(%rax),%ecx
  2623df:	test   $0x460,%ecx
  2623e5:	je     263b64 <<glass::engine::Watch>::print_utf8+0x17c4>
  2623eb:	movl   $0x0,0x10(%rsp)
  2623f3:	movl   $0x0,0x28(%rsp)
  2623fb:	mov    $0xffffffff,%r8d
  262401:	xor    %r15d,%r15d
  262404:	lea    0x3668dd(%rip),%rax        # 5c8ce8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15468>
  26240b:	mov    %rax,0xe0(%rsp)
  262413:	lea    0x50(%rsp),%rax
  262418:	mov    %rax,0x110(%rsp)
  262420:	xor    %r9d,%r9d
  262423:	mov    %r13,0xc0(%rsp)
  26242b:	mov    %r14,0xb8(%rsp)
  262433:	mov    %rsi,0x78(%rsp)
  262438:	jmp    26246e <<glass::engine::Watch>::print_utf8+0xce>
  26243a:	nopw   0x0(%rax,%rax,1)
  262440:	mov    0xb8(%rsp),%r14
  262448:	mov    %r14,%rdi
  26244b:	mov    %ebp,%esi
  26244d:	mov    %r8,%rbx
  262450:	mov    %r9,%r15
  262453:	call   33d200 <<glass::engine::Watch as vte::ansi::Handler>::input>
  262458:	mov    %r15,%r9
  26245b:	mov    %rbx,%r8
  26245e:	mov    0x78(%rsp),%rsi
  262463:	mov    0x90(%rsp),%r15
  26246b:	add    %r15,%r9
  26246e:	cmpb   $0x0,0x28(%rsp)
  262473:	je     262e79 <<glass::engine::Watch>::print_utf8+0xad9>
  262479:	mov    0x78(%r14),%rbx
  26247d:	cmpb   $0x0,0x6c(%rbx)
  262481:	jne    262e79 <<glass::engine::Watch>::print_utf8+0xad9>
  262487:	mov    0x30(%rbx),%eax
  26248a:	sub    0x48(%rbx),%eax
  26248d:	cltq
  26248f:	mov    0x20(%rbx),%rsi
  262493:	mov    0x28(%rbx),%rcx
  262497:	lea    (%rcx,%rax,1),%rdi
  26249b:	dec    %rdi
  26249e:	cmp    %rsi,%rdi
  2624a1:	mov    $0x0,%eax
  2624a6:	cmovae %rsi,%rax
  2624aa:	sub    %rax,%rdi
  2624ad:	cmp    %rsi,%rdi
  2624b0:	jae    264406 <<glass::engine::Watch>::print_utf8+0x2066>
  2624b6:	mov    0xa0(%rbx),%rax
  2624bd:	mov    %rax,0x88(%rsp)
  2624c5:	mov    0x40(%rbx),%rbp
  2624c9:	mov    0x58(%rbx),%eax
  2624cc:	mov    %eax,0xb0(%rsp)
  2624d3:	mov    0x5c(%rbx),%eax
  2624d6:	mov    %eax,0xa8(%rsp)
  2624dd:	movzwl 0x64(%rbx),%eax
  2624e1:	mov    %eax,0xc(%rsp)
  2624e5:	mov    0x18(%rbx),%rax
  2624e9:	shl    $0x6,%rdi
  2624ed:	lea    (%rax,%rdi,1),%r12
  2624f1:	cmp    %ebp,0x38(%rax,%rdi,1)
  2624f5:	jbe    2624fc <<glass::engine::Watch>::print_utf8+0x15c>
  2624f7:	mov    %ebp,0x38(%r12)
  2624fc:	mov    0x28(%r12),%r11d
  262501:	cmp    $0xffffffff,%r11d
  262505:	je     2625c7 <<glass::engine::Watch>::print_utf8+0x227>
  26250b:	mov    0x30(%r12),%rax
  262510:	cmp    %rax,%rbp
  262513:	mov    $0x0,%ecx
  262518:	cmovb  %rax,%rcx
  26251c:	mov    %rcx,0xd0(%rsp)
  262524:	movl   $0x20,0x100(%rsp)
  26252f:	mov    0xb0(%rsp),%ecx
  262536:	mov    %ecx,0xf8(%rsp)
  26253d:	mov    0xa8(%rsp),%ecx
  262544:	mov    %ecx,0xfc(%rsp)
  26254b:	mov    0xc(%rsp),%ecx
  26254f:	mov    %cx,0x104(%rsp)
  262557:	movq   $0x0,0xf0(%rsp)
  262563:	mov    0x10(%r12),%rcx
  262568:	cmp    %rax,%rcx
  26256b:	mov    %rax,%rdx
  26256e:	cmovb  %rcx,%rdx
  262572:	mov    %rdx,0x38(%rsp)
  262577:	cmp    %rbp,%rcx
  26257a:	mov    %rbp,%r10
  26257d:	cmovb  %rcx,%r10
  262581:	mov    0x38f5b8(%rip),%rdx        # 5f1b40 <_DYNAMIC+0x320>
  262588:	movzbl (%rdx),%edx
  26258b:	test   %dl,%dl
  26258d:	je     26266f <<glass::engine::Watch>::print_utf8+0x2cf>
  262593:	mov    0x38f5de(%rip),%rdx        # 5f1b78 <_DYNAMIC+0x358>
  26259a:	cmp    %r10,%rax
  26259d:	jae    2625a6 <<glass::engine::Watch>::print_utf8+0x206>
  26259f:	mov    0x38f5da(%rip),%rdx        # 5f1b80 <_DYNAMIC+0x360>
  2625a6:	lock incq 0x28(%rdx)
  2625ab:	mov    0x38f5a6(%rip),%rdx        # 5f1b58 <_DYNAMIC+0x338>
  2625b2:	lock incq (%rdx)
  2625b6:	mov    %r10,%rdx
  2625b9:	sub    0x38(%rsp),%rdx
  2625be:	jne    262624 <<glass::engine::Watch>::print_utf8+0x284>
  2625c0:	xor    %esi,%esi
  2625c2:	jmp    262663 <<glass::engine::Watch>::print_utf8+0x2c3>
  2625c7:	movl   $0x20,0x100(%rsp)
  2625d2:	mov    0xb0(%rsp),%eax
  2625d9:	mov    %eax,0xf8(%rsp)
  2625e0:	mov    0xa8(%rsp),%eax
  2625e7:	mov    %eax,0xfc(%rsp)
  2625ee:	mov    0xc(%rsp),%eax
  2625f2:	mov    %ax,0x104(%rsp)
  2625fa:	movq   $0x0,0xf0(%rsp)
  262606:	lea    0x30(%r12),%rax
  26260b:	mov    %rax,0x108(%rsp)
  262613:	movq   $0xffffffffffffffff,0xd0(%rsp)
  26261f:	jmp    262827 <<glass::engine::Watch>::print_utf8+0x487>
  262624:	mov    0x38f535(%rip),%rsi        # 5f1b60 <_DYNAMIC+0x340>
  26262b:	lock add %rdx,(%rsi)
  26262f:	cmp    $0x5,%rdx
  262633:	jae    262643 <<glass::engine::Watch>::print_utf8+0x2a3>
  262635:	lea    -0x204b24(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  26263c:	movzbl -0x1(%rdx,%rsi,1),%esi
  262641:	jmp    262663 <<glass::engine::Watch>::print_utf8+0x2c3>
  262643:	lea    -0x5(%rdx),%rdi
  262647:	mov    $0x4,%esi
  26264c:	cmp    $0x4,%rdi
  262650:	jb     262663 <<glass::engine::Watch>::print_utf8+0x2c3>
  262652:	add    $0xfffffffffffffff7,%rdx
  262656:	cmp    $0x8,%rdx
  26265a:	mov    $0x6,%esi
  26265f:	sbb    $0x0,%rsi
  262663:	mov    0x38f4e6(%rip),%rdx        # 5f1b50 <_DYNAMIC+0x330>
  26266a:	lock incq (%rdx,%rsi,8)
  26266f:	cmp    %r10,%rax
  262672:	mov    %r8,0x70(%rsp)
  262677:	mov    %r9,0x48(%rsp)
  26267c:	jae    2627e1 <<glass::engine::Watch>::print_utf8+0x441>
  262682:	mov    %rbp,0x40(%rsp)
  262687:	mov    %rbx,0x80(%rsp)
  26268f:	mov    %r15,0x90(%rsp)
  262697:	mov    0x20(%r12),%edx
  26269c:	mov    0x24(%r12),%r14d
  2626a1:	movzwl 0x2c(%r12),%edi
  2626a7:	mov    %r12,0x68(%rsp)
  2626ac:	mov    0x18(%r12),%r12
  2626b1:	test   %r12,%r12
  2626b4:	je     2626c1 <<glass::engine::Watch>::print_utf8+0x321>
  2626b6:	lock incq (%r12)
  2626bb:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  2626c1:	mov    %r11d,0x60(%rsp)
  2626c6:	mov    %edx,0x58(%rsp)
  2626ca:	mov    %r14d,0x5c(%rsp)
  2626cf:	mov    %di,0x64(%rsp)
  2626d4:	mov    %r12,0x50(%rsp)
  2626d9:	mov    0x38(%rsp),%rax
  2626de:	lea    0x0(,%rax,8),%rax
  2626e6:	lea    (%rax,%rax,2),%rax
  2626ea:	mov    0x68(%rsp),%rcx
  2626ef:	mov    0x8(%rcx),%rbx
  2626f3:	add    %rax,%rbx
  2626f6:	lea    0x0(,%r10,8),%rcx
  2626fe:	lea    (%rcx,%rcx,2),%rbp
  262702:	sub    %rax,%rbp
  262705:	mov    %edx,0x20(%rsp)
  262709:	mov    %di,0x18(%rsp)
  26270e:	jmp    26272c <<glass::engine::Watch>::print_utf8+0x38c>
  262710:	mov    %r12,(%rbx)
  262713:	mov    %edx,0x8(%rbx)
  262716:	mov    %r14d,0xc(%rbx)
  26271a:	mov    %r11d,0x10(%rbx)
  26271e:	mov    %di,0x14(%rbx)
  262722:	add    $0x18,%rbx
  262726:	add    $0xffffffffffffffe8,%rbp
  26272a:	je     262774 <<glass::engine::Watch>::print_utf8+0x3d4>
  26272c:	test   %r12,%r12
  26272f:	je     26273c <<glass::engine::Watch>::print_utf8+0x39c>
  262731:	lock incq (%r12)
  262736:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  26273c:	mov    (%rbx),%rax
  26273f:	test   %rax,%rax
  262742:	je     262710 <<glass::engine::Watch>::print_utf8+0x370>
  262744:	lock decq (%rax)
  262748:	jne    262710 <<glass::engine::Watch>::print_utf8+0x370>
  26274a:	mov    %rbx,%rdi
  26274d:	mov    %r10,%r15
  262750:	mov    %r11d,%r13d
  262753:	call   *0x38f32f(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  262759:	movzwl 0x18(%rsp),%edi
  26275e:	mov    0x20(%rsp),%edx
  262762:	mov    %r13d,%r11d
  262765:	mov    %r15,%r10
  262768:	mov    0x48(%rsp),%r9
  26276d:	mov    0x70(%rsp),%r8
  262772:	jmp    262710 <<glass::engine::Watch>::print_utf8+0x370>
  262774:	mov    0x68(%rsp),%rax
  262779:	mov    0x38(%rsp),%rcx
  26277e:	cmp    %ecx,0x38(%rax)
  262781:	jbe    26278b <<glass::engine::Watch>::print_utf8+0x3eb>
  262783:	mov    0x68(%rsp),%rax
  262788:	mov    %ecx,0x38(%rax)
  26278b:	test   %r12,%r12
  26278e:	mov    0xc0(%rsp),%r13
  262796:	mov    0xb8(%rsp),%r14
  26279e:	mov    0x90(%rsp),%r15
  2627a6:	mov    0x80(%rsp),%rbx
  2627ae:	mov    0x40(%rsp),%rbp
  2627b3:	je     2627d7 <<glass::engine::Watch>::print_utf8+0x437>
  2627b5:	lock decq (%r12)
  2627ba:	jne    2627d7 <<glass::engine::Watch>::print_utf8+0x437>
  2627bc:	lea    0x50(%rsp),%rdi
  2627c1:	mov    %r10,%r12
  2627c4:	call   *0x38f2be(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  2627ca:	mov    %r12,%r10
  2627cd:	mov    0x48(%rsp),%r9
  2627d2:	mov    0x70(%rsp),%r8
  2627d7:	mov    0x68(%rsp),%r12
  2627dc:	mov    0x10(%r12),%rcx
  2627e1:	lea    0x30(%r12),%rax
  2627e6:	mov    %rax,0x108(%rsp)
  2627ee:	cmp    %rcx,%r10
  2627f1:	jb     262827 <<glass::engine::Watch>::print_utf8+0x487>
  2627f3:	cmpl   $0xffffffff,0x28(%r12)
  2627f9:	je     26281e <<glass::engine::Watch>::print_utf8+0x47e>
  2627fb:	lea    0x18(%r12),%rdi
  262800:	mov    (%rdi),%rax
  262803:	test   %rax,%rax
  262806:	je     26281e <<glass::engine::Watch>::print_utf8+0x47e>
  262808:	lock decq (%rax)
  26280c:	jne    26281e <<glass::engine::Watch>::print_utf8+0x47e>
  26280e:	call   *0x38f274(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  262814:	mov    0x48(%rsp),%r9
  262819:	mov    0x70(%rsp),%r8
  26281e:	movl   $0xffffffff,0x28(%r12)
  262827:	mov    0x10(%r12),%rdx
  26282c:	mov    0x30(%r12),%rax
  262831:	cmp    %rbp,%rdx
  262834:	mov    %rbp,%rsi
  262837:	cmovb  %rdx,%rsi
  26283b:	cmp    %rax,%rsi
  26283e:	cmova  %rsi,%rax
  262842:	mov    %rdx,%rcx
  262845:	mov    %rax,0x30(%r12)
  26284a:	sub    %rbp,%rcx
  26284d:	mov    %rcx,0x18(%rsp)
  262852:	jb     263d97 <<glass::engine::Watch>::print_utf8+0x19f7>
  262858:	cmp    %r13,%r9
  26285b:	jae    262dea <<glass::engine::Watch>::print_utf8+0xa4a>
  262861:	mov    %rbx,0x80(%rsp)
  262869:	mov    %r15,0x90(%rsp)
  262871:	mov    %r12,0x68(%rsp)
  262876:	mov    0x8(%r12),%rdx
  26287b:	lea    0x0(,%rbp,2),%rax
  262883:	add    %rbp,%rax
  262886:	lea    (%rdx,%rax,8),%rax
  26288a:	mov    %rax,0xc8(%rsp)
  262892:	mov    0xc(%rsp),%eax
  262896:	mov    %eax,%ecx
  262898:	or     $0x20,%ecx
  26289b:	mov    %ecx,0xa0(%rsp)
  2628a2:	or     $0x40,%eax
  2628a5:	mov    %eax,0xec(%rsp)
  2628ac:	mov    $0x1,%al
  2628ae:	mov    %eax,0x98(%rsp)
  2628b5:	xor    %r11d,%r11d
  2628b8:	movq   $0x0,0x20(%rsp)
  2628c1:	mov    %rbp,%r14
  2628c4:	mov    %rbp,0x40(%rsp)
  2628c9:	mov    %rbp,%r10
  2628cc:	mov    0x78(%rsp),%rsi
  2628d1:	mov    0x88(%rsp),%rdi
  2628d9:	mov    %rdx,0x30(%rsp)
  2628de:	jmp    26294c <<glass::engine::Watch>::print_utf8+0x5ac>
  2628e0:	movq   $0x0,(%rbx)
  2628e7:	mov    0xb0(%rsp),%eax
  2628ee:	mov    %eax,0x8(%rbx)
  2628f1:	mov    0xa8(%rsp),%eax
  2628f8:	mov    %eax,0xc(%rbx)
  2628fb:	movl   $0x20,0x10(%rbx)
  262902:	mov    0xec(%rsp),%eax
  262909:	mov    %ax,0x14(%rbx)
  26290d:	movl   $0x0,0x98(%rsp)
  262918:	xor    %r11d,%r11d
  26291b:	cmp    %rdi,%r15
  26291e:	setae  %r11b
  262922:	mov    %r15,%r10
  262925:	sub    %r11,%r10
  262928:	incq   0x20(%rsp)
  26292d:	mov    %r15,%r14
  262930:	mov    0x38(%rsp),%rbx
  262935:	add    %rbx,%r9
  262938:	mov    %ebp,%r8d
  26293b:	mov    %rbx,0x90(%rsp)
  262943:	cmp    %r13,%r9
  262946:	jae    262e0e <<glass::engine::Watch>::print_utf8+0xa6e>
  26294c:	mov    %r9,%rbx
  26294f:	movzbl (%rsi,%r9,1),%ebp
  262954:	test   %bpl,%bpl
  262957:	js     262970 <<glass::engine::Watch>::print_utf8+0x5d0>
  262959:	mov    $0x1,%r9d
  26295f:	jmp    262aa2 <<glass::engine::Watch>::print_utf8+0x702>
  262964:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  262970:	lea    0x3e(%rbp),%eax
  262973:	cmp    $0x1e,%al
  262975:	jae    2629a9 <<glass::engine::Watch>::print_utf8+0x609>
  262977:	lea    0x1(%rbx),%rax
  26297b:	cmp    %r13,%rax
  26297e:	jae    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262984:	movzbl (%rsi,%rax,1),%ecx
  262988:	cmp    $0xc0,%cl
  26298b:	jge    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262991:	and    $0x1f,%ebp
  262994:	shl    $0x6,%ebp
  262997:	mov    $0x80,%edx
  26299c:	mov    $0x2,%r9d
  2629a2:	mov    %ebp,%eax
  2629a4:	jmp    262a78 <<glass::engine::Watch>::print_utf8+0x6d8>
  2629a9:	mov    %ebp,%eax
  2629ab:	and    $0xf0,%al
  2629ad:	cmp    $0xe0,%al
  2629af:	jne    2629ff <<glass::engine::Watch>::print_utf8+0x65f>
  2629b1:	lea    0x1(%rbx),%rax
  2629b5:	cmp    %r13,%rax
  2629b8:	jae    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  2629be:	movzbl (%rsi,%rax,1),%eax
  2629c2:	cmp    $0xbf,%al
  2629c4:	jg     262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  2629ca:	lea    0x2(%rbx),%rcx
  2629ce:	cmp    %r13,%rcx
  2629d1:	jae    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  2629d7:	movzbl (%rsi,%rcx,1),%ecx
  2629db:	cmp    $0xc0,%cl
  2629de:	jge    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  2629e4:	and    $0xf,%ebp
  2629e7:	shl    $0xc,%ebp
  2629ea:	and    $0x3f,%eax
  2629ed:	shl    $0x6,%eax
  2629f0:	or     %ebp,%eax
  2629f2:	mov    $0x800,%edx
  2629f7:	mov    $0x3,%r9d
  2629fd:	jmp    262a78 <<glass::engine::Watch>::print_utf8+0x6d8>
  2629ff:	lea    0x10(%rbp),%eax
  262a02:	cmp    $0x5,%al
  262a04:	jae    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262a0a:	lea    0x1(%rbx),%rax
  262a0e:	cmp    %r13,%rax
  262a11:	jae    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262a17:	movzbl (%rsi,%rax,1),%edx
  262a1b:	cmp    $0xbf,%dl
  262a1e:	jg     262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262a24:	lea    0x2(%rbx),%rax
  262a28:	cmp    %r13,%rax
  262a2b:	jae    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262a31:	movzbl (%rsi,%rax,1),%eax
  262a35:	cmp    $0xbf,%al
  262a37:	jg     262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262a3d:	lea    0x3(%rbx),%rcx
  262a41:	cmp    %r13,%rcx
  262a44:	jae    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262a4a:	movzbl (%rsi,%rcx,1),%ecx
  262a4e:	cmp    $0xbf,%cl
  262a51:	jg     262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262a57:	and    $0x7,%ebp
  262a5a:	shl    $0x12,%ebp
  262a5d:	and    $0x3f,%edx
  262a60:	shl    $0xc,%edx
  262a63:	or     %ebp,%edx
  262a65:	and    $0x3f,%eax
  262a68:	shl    $0x6,%eax
  262a6b:	or     %edx,%eax
  262a6d:	mov    $0x10000,%edx
  262a72:	mov    $0x4,%r9d
  262a78:	and    $0x3f,%cl
  262a7b:	movzbl %cl,%ebp
  262a7e:	or     %eax,%ebp
  262a80:	cmp    %edx,%ebp
  262a82:	jb     262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262a88:	xor    $0xd800,%eax
  262a8d:	add    $0xffef0000,%eax
  262a92:	cmp    $0xffef0800,%eax
  262a97:	mov    0x30(%rsp),%rdx
  262a9c:	jb     262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262aa2:	lea    -0x7f(%rbp),%eax
  262aa5:	cmp    $0x21,%eax
  262aa8:	jb     262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262aae:	cmp    $0xffffffff,%r8d
  262ab2:	je     262ae0 <<glass::engine::Watch>::print_utf8+0x740>
  262ab4:	lea    -0x20(%r8),%eax
  262ab8:	cmp    $0x5f,%eax
  262abb:	jae    262af0 <<glass::engine::Watch>::print_utf8+0x750>
  262abd:	mov    $0x1,%ecx
  262ac2:	cmpb   $0x0,0x10(%rsp)
  262ac7:	jne    262bdb <<glass::engine::Watch>::print_utf8+0x83b>
  262acd:	jmp    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262ad2:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262ae0:	mov    %r14,%r15
  262ae3:	jmp    262935 <<glass::engine::Watch>::print_utf8+0x595>
  262ae8:	nopl   0x0(%rax,%rax,1)
  262af0:	mov    %rbx,%r13
  262af3:	mov    0x391eff(%rip),%eax        # 5f49f8 <glass::engine::width_of::CACHE+0x10>
  262af9:	test   %eax,%eax
  262afb:	jne    262d99 <<glass::engine::Watch>::print_utf8+0x9f9>
  262b01:	mov    %r8d,%ebx
  262b04:	mov    0x391ee5(%rip),%rsi        # 5f49f0 <glass::engine::width_of::CACHE+0x8>
  262b0b:	cmp    %rbx,%rsi
  262b0e:	jbe    2643c2 <<glass::engine::Watch>::print_utf8+0x2022>
  262b14:	mov    0x391ecd(%rip),%r12        # 5f49e8 <glass::engine::width_of::CACHE>
  262b1b:	movzbl (%r12,%rbx,1),%eax
  262b20:	movzbl %al,%ecx
  262b23:	test   %cl,%cl
  262b25:	js     262b3e <<glass::engine::Watch>::print_utf8+0x79e>
  262b27:	mov    $0x1,%dl
  262b29:	mov    0x78(%rsp),%rsi
  262b2e:	test   %dl,%dl
  262b30:	mov    %r13,%rbx
  262b33:	jne    262bc0 <<glass::engine::Watch>::print_utf8+0x820>
  262b39:	jmp    2632ab <<glass::engine::Watch>::print_utf8+0xf0b>
  262b3e:	cmp    $0xfe,%ecx
  262b44:	mov    0x78(%rsp),%rsi
  262b49:	je     2632dc <<glass::engine::Watch>::print_utf8+0xf3c>
  262b4f:	mov    $0xfe,%al
  262b51:	cmp    $0x7f,%r8d
  262b55:	jae    262b60 <<glass::engine::Watch>::print_utf8+0x7c0>
  262b57:	mov    $0x1,%ecx
  262b5c:	xor    %edx,%edx
  262b5e:	jmp    262bb1 <<glass::engine::Watch>::print_utf8+0x811>
  262b60:	cmp    $0xa0,%r8d
  262b67:	jb     262baf <<glass::engine::Watch>::print_utf8+0x80f>
  262b69:	mov    %r8d,%edi
  262b6c:	mov    %r10,0xd8(%rsp)
  262b74:	mov    %r8,%r15
  262b77:	mov    %r9,0x48(%rsp)
  262b7c:	mov    %r11,0x70(%rsp)
  262b81:	call   298820 <unicode_width::tables::lookup_width>
  262b86:	mov    0x70(%rsp),%r11
  262b8b:	mov    0x48(%rsp),%r9
  262b90:	mov    %r15,%r8
  262b93:	mov    0xd8(%rsp),%r10
  262b9b:	mov    0x88(%rsp),%rdi
  262ba3:	mov    0x78(%rsp),%rsi
  262ba8:	movzbl %al,%ecx
  262bab:	mov    $0x1,%dl
  262bad:	jmp    262bb1 <<glass::engine::Watch>::print_utf8+0x811>
  262baf:	xor    %edx,%edx
  262bb1:	mov    %al,(%r12,%rbx,1)
  262bb5:	test   %dl,%dl
  262bb7:	mov    %r13,%rbx
  262bba:	je     2632ab <<glass::engine::Watch>::print_utf8+0xf0b>
  262bc0:	lea    -0x1(%rcx),%rax
  262bc4:	cmp    $0x1,%rax
  262bc8:	mov    0xc0(%rsp),%r13
  262bd0:	mov    0x30(%rsp),%rdx
  262bd5:	ja     262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262bdb:	test   $0x1,%r11b
  262bdf:	jne    262dfd <<glass::engine::Watch>::print_utf8+0xa5d>
  262be5:	lea    (%rcx,%r10,1),%r15
  262be9:	cmp    %rdi,%r15
  262bec:	ja     262e02 <<glass::engine::Watch>::print_utf8+0xa62>
  262bf2:	mov    %rbx,0x38(%rsp)
  262bf7:	mov    %r10,%rbx
  262bfa:	sub    0x40(%rsp),%rbx
  262bff:	cmp    0xd0(%rsp),%r10
  262c07:	jae    262c70 <<glass::engine::Watch>::print_utf8+0x8d0>
  262c09:	cmp    0x18(%rsp),%rbx
  262c0e:	jae    264413 <<glass::engine::Watch>::print_utf8+0x2073>
  262c14:	lea    (%r10,%r10,2),%rax
  262c18:	testb  $0x60,0x14(%rdx,%rax,8)
  262c1d:	jne    263298 <<glass::engine::Watch>::print_utf8+0xef8>
  262c23:	lea    (%rdx,%rax,8),%r12
  262c27:	cmp    $0x2,%rcx
  262c2b:	jne    262ce9 <<glass::engine::Watch>::print_utf8+0x949>
  262c31:	lea    0x1(%rbx),%rax
  262c35:	cmp    0x18(%rsp),%rax
  262c3a:	jae    264431 <<glass::engine::Watch>::print_utf8+0x2091>
  262c40:	mov    %r14,%r11
  262c43:	lea    (%rax,%rax,2),%rax
  262c47:	mov    $0x1,%r14b
  262c4a:	mov    0xc8(%rsp),%rcx
  262c52:	testb  $0x60,0x14(%rcx,%rax,8)
  262c57:	mov    0xa0(%rsp),%r13d
  262c5f:	je     262c99 <<glass::engine::Watch>::print_utf8+0x8f9>
  262c61:	jmp    2632c1 <<glass::engine::Watch>::print_utf8+0xf21>
  262c66:	cs nopw 0x0(%rax,%rax,1)
  262c70:	cmp    0x18(%rsp),%rbx
  262c75:	jae    264443 <<glass::engine::Watch>::print_utf8+0x20a3>
  262c7b:	lea    (%r10,%r10,2),%rax
  262c7f:	lea    (%rdx,%rax,8),%r12
  262c83:	cmp    $0x2,%rcx
  262c87:	sete   %r14b
  262c8b:	mov    0xc(%rsp),%r13d
  262c90:	cmove  0xa0(%rsp),%r13d
  262c99:	mov    (%r12),%rax
  262c9d:	test   %rax,%rax
  262ca0:	je     262d00 <<glass::engine::Watch>::print_utf8+0x960>
  262ca2:	lock decq (%rax)
  262ca6:	jne    262d00 <<glass::engine::Watch>::print_utf8+0x960>
  262ca8:	mov    %r12,%rdi
  262cab:	mov    %r10,0xd8(%rsp)
  262cb3:	mov    %r8,0x70(%rsp)
  262cb8:	mov    %r9,0x48(%rsp)
  262cbd:	call   *0x38edc5(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  262cc3:	mov    0x30(%rsp),%rdx
  262cc8:	mov    0x48(%rsp),%r9
  262ccd:	mov    0x70(%rsp),%r8
  262cd2:	mov    0xd8(%rsp),%r10
  262cda:	mov    0x88(%rsp),%rdi
  262ce2:	mov    0x78(%rsp),%rsi
  262ce7:	jmp    262d00 <<glass::engine::Watch>::print_utf8+0x960>
  262ce9:	xor    %r14d,%r14d
  262cec:	mov    0xc(%rsp),%r13d
  262cf1:	mov    (%r12),%rax
  262cf5:	test   %rax,%rax
  262cf8:	jne    262ca2 <<glass::engine::Watch>::print_utf8+0x902>
  262cfa:	nopw   0x0(%rax,%rax,1)
  262d00:	lea    (%r10,%r10,2),%rax
  262d04:	movq   $0x0,(%r12)
  262d0c:	mov    0xb0(%rsp),%ecx
  262d13:	mov    %ecx,0x8(%rdx,%rax,8)
  262d17:	mov    0xa8(%rsp),%ecx
  262d1e:	mov    %ecx,0xc(%rdx,%rax,8)
  262d22:	mov    %r13w,0x14(%rdx,%rax,8)
  262d28:	mov    %r8d,0x10(%rdx,%rax,8)
  262d2d:	test   %r14b,%r14b
  262d30:	mov    0xc0(%rsp),%r13
  262d38:	je     262918 <<glass::engine::Watch>::print_utf8+0x578>
  262d3e:	inc    %rbx
  262d41:	cmp    0x18(%rsp),%rbx
  262d46:	jae    26441c <<glass::engine::Watch>::print_utf8+0x207c>
  262d4c:	lea    (%rbx,%rbx,2),%rax
  262d50:	mov    0xc8(%rsp),%rcx
  262d58:	lea    (%rcx,%rax,8),%rbx
  262d5c:	mov    (%rcx,%rax,8),%rax
  262d60:	test   %rax,%rax
  262d63:	je     2628e0 <<glass::engine::Watch>::print_utf8+0x540>
  262d69:	lock decq (%rax)
  262d6d:	jne    2628e0 <<glass::engine::Watch>::print_utf8+0x540>
  262d73:	mov    %rbx,%rdi
  262d76:	mov    %r9,%r14
  262d79:	call   *0x38ed09(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  262d7f:	mov    0x30(%rsp),%rdx
  262d84:	mov    0x88(%rsp),%rdi
  262d8c:	mov    %r14,%r9
  262d8f:	mov    0x78(%rsp),%rsi
  262d94:	jmp    2628e0 <<glass::engine::Watch>::print_utf8+0x540>
  262d99:	mov    %r8,0x70(%rsp)
  262d9e:	mov    %r14,%rbx
  262da1:	mov    %r9,%r14
  262da4:	mov    %r10,0xd8(%rsp)
  262dac:	mov    %r11,%r12
  262daf:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  262db4:	mov    %r12,%r11
  262db7:	mov    0xd8(%rsp),%r10
  262dbf:	mov    0x88(%rsp),%rdi
  262dc7:	mov    %r14,%r9
  262dca:	mov    %rbx,%r14
  262dcd:	mov    0x70(%rsp),%r8
  262dd2:	mov    %r8d,%ebx
  262dd5:	mov    0x391c14(%rip),%rsi        # 5f49f0 <glass::engine::width_of::CACHE+0x8>
  262ddc:	cmp    %rbx,%rsi
  262ddf:	ja     262b14 <<glass::engine::Watch>::print_utf8+0x774>
  262de5:	jmp    2643c2 <<glass::engine::Watch>::print_utf8+0x2022>
  262dea:	movq   $0x0,0x20(%rsp)
  262df3:	xor    %r11d,%r11d
  262df6:	mov    0x78(%rsp),%rsi
  262dfb:	jmp    262e65 <<glass::engine::Watch>::print_utf8+0xac5>
  262dfd:	mov    $0x1,%r11b
  262e00:	jmp    262e05 <<glass::engine::Watch>::print_utf8+0xa65>
  262e02:	xor    %r11d,%r11d
  262e05:	mov    %r14,%r15
  262e08:	mov    %r8d,%ebp
  262e0b:	mov    %rbx,%r9
  262e0e:	cmp    0x40(%rsp),%r15
  262e13:	jbe    262e2a <<glass::engine::Watch>::print_utf8+0xa8a>
  262e15:	mov    0x108(%rsp),%rcx
  262e1d:	mov    (%rcx),%rax
  262e20:	cmp    %rax,%r15
  262e23:	cmova  %r15,%rax
  262e27:	mov    %rax,(%rcx)
  262e2a:	cmpq   $0x8,0x20(%rsp)
  262e30:	setae  %al
  262e33:	testb  $0x1,0x98(%rsp)
  262e3b:	mov    0xb8(%rsp),%r14
  262e43:	jne    262e47 <<glass::engine::Watch>::print_utf8+0xaa7>
  262e45:	xor    %eax,%eax
  262e47:	test   %al,%al
  262e49:	mov    0x90(%rsp),%r15
  262e51:	jne    263a34 <<glass::engine::Watch>::print_utf8+0x1694>
  262e57:	mov    %ebp,%r8d
  262e5a:	mov    %r10,%rbp
  262e5d:	mov    0x80(%rsp),%rbx
  262e65:	mov    %rbp,0x40(%rbx)
  262e69:	mov    %r11b,0x6c(%rbx)
  262e6d:	mov    0x20(%rsp),%rax
  262e72:	add    %rax,0xa0(%r14)
  262e79:	mov    %r8d,%ebp
  262e7c:	mov    %r15,%rbx
  262e7f:	mov    %r9,%r15
  262e82:	cmp    %r13,%r9
  262e85:	jae    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262e8b:	movzbl (%rsi,%r15,1),%r8d
  262e90:	test   %r8b,%r8b
  262e93:	js     262ea0 <<glass::engine::Watch>::print_utf8+0xb00>
  262e95:	mov    $0x1,%r9d
  262e9b:	jmp    262fdc <<glass::engine::Watch>::print_utf8+0xc3c>
  262ea0:	lea    0x3e(%r8),%eax
  262ea4:	cmp    $0x1e,%al
  262ea6:	jae    262edd <<glass::engine::Watch>::print_utf8+0xb3d>
  262ea8:	lea    0x1(%r15),%rax
  262eac:	cmp    %r13,%rax
  262eaf:	jae    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262eb5:	movzbl (%rsi,%rax,1),%ecx
  262eb9:	cmp    $0xc0,%cl
  262ebc:	jge    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262ec2:	and    $0x1f,%r8d
  262ec6:	shl    $0x6,%r8d
  262eca:	mov    $0x80,%edx
  262ecf:	mov    $0x2,%r9d
  262ed5:	mov    %r8d,%eax
  262ed8:	jmp    262fb4 <<glass::engine::Watch>::print_utf8+0xc14>
  262edd:	mov    %r8d,%eax
  262ee0:	and    $0xf0,%al
  262ee2:	cmp    $0xe0,%al
  262ee4:	jne    262f37 <<glass::engine::Watch>::print_utf8+0xb97>
  262ee6:	lea    0x1(%r15),%rax
  262eea:	cmp    %r13,%rax
  262eed:	jae    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262ef3:	movzbl (%rsi,%rax,1),%eax
  262ef7:	cmp    $0xbf,%al
  262ef9:	jg     263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262eff:	lea    0x2(%r15),%rcx
  262f03:	cmp    %r13,%rcx
  262f06:	jae    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f0c:	movzbl (%rsi,%rcx,1),%ecx
  262f10:	cmp    $0xc0,%cl
  262f13:	jge    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f19:	and    $0xf,%r8d
  262f1d:	shl    $0xc,%r8d
  262f21:	and    $0x3f,%eax
  262f24:	shl    $0x6,%eax
  262f27:	or     %r8d,%eax
  262f2a:	mov    $0x800,%edx
  262f2f:	mov    $0x3,%r9d
  262f35:	jmp    262fb4 <<glass::engine::Watch>::print_utf8+0xc14>
  262f37:	lea    0x10(%r8),%eax
  262f3b:	cmp    $0x5,%al
  262f3d:	jae    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f43:	lea    0x1(%r15),%rax
  262f47:	cmp    %r13,%rax
  262f4a:	jae    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f50:	movzbl (%rsi,%rax,1),%edx
  262f54:	cmp    $0xbf,%dl
  262f57:	jg     263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f5d:	lea    0x2(%r15),%rax
  262f61:	cmp    %r13,%rax
  262f64:	jae    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f6a:	movzbl (%rsi,%rax,1),%eax
  262f6e:	cmp    $0xbf,%al
  262f70:	jg     263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f76:	lea    0x3(%r15),%rcx
  262f7a:	cmp    %r13,%rcx
  262f7d:	jae    263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f83:	movzbl (%rsi,%rcx,1),%ecx
  262f87:	cmp    $0xbf,%cl
  262f8a:	jg     263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262f90:	and    $0x7,%r8d
  262f94:	shl    $0x12,%r8d
  262f98:	and    $0x3f,%edx
  262f9b:	shl    $0xc,%edx
  262f9e:	or     %r8d,%edx
  262fa1:	and    $0x3f,%eax
  262fa4:	shl    $0x6,%eax
  262fa7:	or     %edx,%eax
  262fa9:	mov    $0x10000,%edx
  262fae:	mov    $0x4,%r9d
  262fb4:	and    $0x3f,%cl
  262fb7:	movzbl %cl,%r8d
  262fbb:	or     %eax,%r8d
  262fbe:	cmp    %edx,%r8d
  262fc1:	jb     263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262fc7:	xor    $0xd800,%eax
  262fcc:	add    $0xffef0000,%eax
  262fd1:	cmp    $0xffef0800,%eax
  262fd6:	jb     263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262fdc:	lea    -0x7f(%r8),%eax
  262fe0:	cmp    $0x21,%eax
  262fe3:	jb     263a75 <<glass::engine::Watch>::print_utf8+0x16d5>
  262fe9:	cmp    $0xffffffff,%ebp
  262fec:	je     26246b <<glass::engine::Watch>::print_utf8+0xcb>
  262ff2:	mov    %r15,0x90(%rsp)
  262ffa:	lea    -0x20(%rbp),%eax
  262ffd:	cmp    $0x5f,%eax
  263000:	jae    263020 <<glass::engine::Watch>::print_utf8+0xc80>
  263002:	mov    $0x1,%r12d
  263008:	cmpb   $0x0,0x10(%rsp)
  26300d:	je     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  263013:	jmp    2630c9 <<glass::engine::Watch>::print_utf8+0xd29>
  263018:	nopl   0x0(%rax,%rax,1)
  263020:	cmpb   $0x0,0x28(%rsp)
  263025:	je     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  26302b:	mov    0x3919c7(%rip),%eax        # 5f49f8 <glass::engine::width_of::CACHE+0x10>
  263031:	test   %eax,%eax
  263033:	jne    263a0c <<glass::engine::Watch>::print_utf8+0x166c>
  263039:	mov    %ebp,%ebx
  26303b:	mov    0x3919ae(%rip),%rsi        # 5f49f0 <glass::engine::width_of::CACHE+0x8>
  263042:	cmp    %rbx,%rsi
  263045:	jbe    2643c2 <<glass::engine::Watch>::print_utf8+0x2022>
  26304b:	mov    0x391996(%rip),%r14        # 5f49e8 <glass::engine::width_of::CACHE>
  263052:	movzbl (%r14,%rbx,1),%eax
  263057:	movzbl %al,%r12d
  26305b:	test   %r12b,%r12b
  26305e:	js     26306b <<glass::engine::Watch>::print_utf8+0xccb>
  263060:	mov    $0x1,%cl
  263062:	test   %cl,%cl
  263064:	jne    2630ba <<glass::engine::Watch>::print_utf8+0xd1a>
  263066:	jmp    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  26306b:	cmp    $0xfe,%r12d
  263072:	je     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  263078:	mov    $0xfe,%al
  26307a:	cmp    $0x7f,%ebp
  26307d:	jae    263089 <<glass::engine::Watch>::print_utf8+0xce9>
  26307f:	mov    $0x1,%r12d
  263085:	xor    %ecx,%ecx
  263087:	jmp    2630ae <<glass::engine::Watch>::print_utf8+0xd0e>
  263089:	cmp    $0xa0,%ebp
  26308f:	jb     2630ac <<glass::engine::Watch>::print_utf8+0xd0c>
  263091:	mov    %ebp,%edi
  263093:	mov    %r8,%r15
  263096:	mov    %r9,%r12
  263099:	call   298820 <unicode_width::tables::lookup_width>
  26309e:	mov    %r12,%r9
  2630a1:	mov    %r15,%r8
  2630a4:	movzbl %al,%r12d
  2630a8:	mov    $0x1,%cl
  2630aa:	jmp    2630ae <<glass::engine::Watch>::print_utf8+0xd0e>
  2630ac:	xor    %ecx,%ecx
  2630ae:	mov    %al,(%r14,%rbx,1)
  2630b2:	test   %cl,%cl
  2630b4:	je     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2630ba:	lea    -0x1(%r12),%rax
  2630bf:	cmp    $0x1,%rax
  2630c3:	ja     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2630c9:	mov    0xb8(%rsp),%rax
  2630d1:	mov    0x78(%rax),%r10
  2630d5:	cmpb   $0x0,0x6c(%r10)
  2630da:	jne    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2630e0:	mov    0x40(%r10),%rbx
  2630e4:	mov    0xa0(%r10),%r14
  2630eb:	lea    (%rbx,%r12,1),%r11
  2630ef:	cmp    %r14,%r11
  2630f2:	ja     262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2630f8:	mov    0x30(%r10),%eax
  2630fc:	sub    0x48(%r10),%eax
  263100:	cltq
  263102:	mov    0x20(%r10),%rsi
  263106:	mov    0x28(%r10),%rcx
  26310a:	lea    (%rcx,%rax,1),%rdi
  26310e:	dec    %rdi
  263111:	cmp    %rsi,%rdi
  263114:	mov    $0x0,%eax
  263119:	cmovae %rsi,%rax
  26311d:	sub    %rax,%rdi
  263120:	cmp    %rsi,%rdi
  263123:	jae    26446d <<glass::engine::Watch>::print_utf8+0x20cd>
  263129:	mov    0x58(%r10),%edx
  26312d:	mov    0x5c(%r10),%eax
  263131:	mov    %eax,0xa8(%rsp)
  263138:	movzwl 0x64(%r10),%eax
  26313d:	mov    %eax,0xb0(%rsp)
  263144:	mov    0x18(%r10),%rax
  263148:	shl    $0x6,%rdi
  26314c:	lea    (%rax,%rdi,1),%r15
  263150:	lea    (%rax,%rdi,1),%rcx
  263154:	add    $0x18,%rcx
  263158:	mov    %rcx,0x48(%rsp)
  26315d:	mov    0x28(%rax,%rdi,1),%eax
  263161:	cmp    $0xffffffff,%eax
  263164:	je     263171 <<glass::engine::Watch>::print_utf8+0xdd1>
  263166:	mov    0x48(%rsp),%rcx
  26316b:	cmp    0x30(%r15),%rbx
  26316f:	jae    26318a <<glass::engine::Watch>::print_utf8+0xdea>
  263171:	mov    0x10(%r15),%rsi
  263175:	cmp    %rsi,%rbx
  263178:	jae    26448e <<glass::engine::Watch>::print_utf8+0x20ee>
  26317e:	lea    (%rbx,%rbx,2),%rcx
  263182:	shl    $0x3,%rcx
  263186:	add    0x8(%r15),%rcx
  26318a:	testb  $0x60,0x14(%rcx)
  26318e:	jne    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  263194:	cmp    $0x2,%r12
  263198:	jne    2631d1 <<glass::engine::Watch>::print_utf8+0xe31>
  26319a:	lea    0x1(%rbx),%rdi
  26319e:	cmp    $0xffffffff,%eax
  2631a1:	je     2631ae <<glass::engine::Watch>::print_utf8+0xe0e>
  2631a3:	mov    0x48(%rsp),%rcx
  2631a8:	cmp    0x30(%r15),%rdi
  2631ac:	jae    2631c7 <<glass::engine::Watch>::print_utf8+0xe27>
  2631ae:	mov    0x10(%r15),%rsi
  2631b2:	cmp    %rsi,%rdi
  2631b5:	jae    26449e <<glass::engine::Watch>::print_utf8+0x20fe>
  2631bb:	lea    (%rdi,%rdi,2),%rcx
  2631bf:	shl    $0x3,%rcx
  2631c3:	add    0x8(%r15),%rcx
  2631c7:	testb  $0x60,0x14(%rcx)
  2631cb:	jne    262440 <<glass::engine::Watch>::print_utf8+0xa0>
  2631d1:	mov    %edx,0xc(%rsp)
  2631d5:	cmp    %ebx,0x38(%r15)
  2631d9:	jbe    2631df <<glass::engine::Watch>::print_utf8+0xe3f>
  2631db:	mov    %ebx,0x38(%r15)
  2631df:	cmp    $0xffffffff,%eax
  2631e2:	setne  %dl
  2631e5:	mov    0x30(%r15),%rcx
  2631e9:	cmp    %rcx,%rbx
  2631ec:	sete   %sil
  2631f0:	test   %sil,%dl
  2631f3:	mov    %r15,0x20(%rsp)
  2631f8:	mov    %rbx,0x18(%rsp)
  2631fd:	jne    26327e <<glass::engine::Watch>::print_utf8+0xede>
  2631ff:	cmp    $0xffffffff,%eax
  263202:	je     263575 <<glass::engine::Watch>::print_utf8+0x11d5>
  263208:	mov    0x10(%r15),%rax
  26320c:	cmp    %rcx,%rax
  26320f:	mov    %rcx,%rdx
  263212:	cmovb  %rax,%rdx
  263216:	mov    %rdx,0x80(%rsp)
  26321e:	cmp    %rbx,%rax
  263221:	mov    %rbx,%rsi
  263224:	cmovb  %rax,%rsi
  263228:	mov    0x38e911(%rip),%rdx        # 5f1b40 <_DYNAMIC+0x320>
  26322f:	movzbl (%rdx),%edx
  263232:	test   %dl,%dl
  263234:	mov    %rsi,0x98(%rsp)
  26323c:	je     263345 <<glass::engine::Watch>::print_utf8+0xfa5>
  263242:	mov    0x38e92f(%rip),%rdx        # 5f1b78 <_DYNAMIC+0x358>
  263249:	cmp    %rsi,%rcx
  26324c:	jae    263255 <<glass::engine::Watch>::print_utf8+0xeb5>
  26324e:	mov    0x38e92b(%rip),%rdx        # 5f1b80 <_DYNAMIC+0x360>
  263255:	lock incq 0x28(%rdx)
  26325a:	mov    0x38e8f7(%rip),%rdx        # 5f1b58 <_DYNAMIC+0x338>
  263261:	lock incq (%rdx)
  263265:	mov    0x98(%rsp),%rdx
  26326d:	sub    0x80(%rsp),%rdx
  263275:	jne    2632f2 <<glass::engine::Watch>::print_utf8+0xf52>
  263277:	xor    %esi,%esi
  263279:	jmp    263331 <<glass::engine::Watch>::print_utf8+0xf91>
  26327e:	lea    0x1(%rbx),%rax
  263282:	mov    %rax,0x30(%r15)
  263286:	mov    0x10(%r15),%rsi
  26328a:	cmp    %rsi,%rbx
  26328d:	jb     263595 <<glass::engine::Watch>::print_utf8+0x11f5>
  263293:	jmp    2644ab <<glass::engine::Watch>::print_utf8+0x210b>
  263298:	xor    %r11d,%r11d
  26329b:	mov    %r14,%r15
  26329e:	mov    %r8d,%ebp
  2632a1:	mov    0x38(%rsp),%r9
  2632a6:	jmp    262e0e <<glass::engine::Watch>::print_utf8+0xa6e>
  2632ab:	mov    %r14,%r15
  2632ae:	mov    %r8d,%ebp
  2632b1:	mov    %rbx,%r9
  2632b4:	mov    0xc0(%rsp),%r13
  2632bc:	jmp    262e0e <<glass::engine::Watch>::print_utf8+0xa6e>
  2632c1:	mov    %r11,%r15
  2632c4:	xor    %r11d,%r11d
  2632c7:	mov    %r8d,%ebp
  2632ca:	mov    0x38(%rsp),%r9
  2632cf:	mov    0xc0(%rsp),%r13
  2632d7:	jmp    262e0e <<glass::engine::Watch>::print_utf8+0xa6e>
  2632dc:	mov    %r14,%r15
  2632df:	mov    %r8d,%ebp
  2632e2:	mov    %r13,%r9
  2632e5:	mov    0xc0(%rsp),%r13
  2632ed:	jmp    262e0e <<glass::engine::Watch>::print_utf8+0xa6e>
  2632f2:	mov    0x38e867(%rip),%rsi        # 5f1b60 <_DYNAMIC+0x340>
  2632f9:	lock add %rdx,(%rsi)
  2632fd:	cmp    $0x5,%rdx
  263301:	jae    263311 <<glass::engine::Watch>::print_utf8+0xf71>
  263303:	lea    -0x2057f2(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  26330a:	movzbl -0x1(%rdx,%rsi,1),%esi
  26330f:	jmp    263331 <<glass::engine::Watch>::print_utf8+0xf91>
  263311:	mov    $0x4,%esi
  263316:	lea    -0x5(%rdx),%rdi
  26331a:	cmp    $0x4,%rdi
  26331e:	jb     263331 <<glass::engine::Watch>::print_utf8+0xf91>
  263320:	add    $0xfffffffffffffff7,%rdx
  263324:	cmp    $0x8,%rdx
  263328:	mov    $0x6,%esi
  26332d:	sbb    $0x0,%rsi
  263331:	mov    0x38e818(%rip),%rdx        # 5f1b50 <_DYNAMIC+0x330>
  263338:	lock incq (%rdx,%rsi,8)
  26333d:	mov    0x98(%rsp),%rsi
  263345:	cmp    %rsi,%rcx
  263348:	jae    26350d <<glass::engine::Watch>::print_utf8+0x116d>
  26334e:	mov    0x28(%r15),%edi
  263352:	mov    0x20(%r15),%r11d
  263356:	mov    0x24(%r15),%ecx
  26335a:	movzwl 0x2c(%r15),%edx
  26335f:	mov    0x18(%r15),%rax
  263363:	test   %rax,%rax
  263366:	mov    %rax,0x38(%rsp)
  26336b:	mov    %dx,0x40(%rsp)
  263370:	mov    %r10,0xa0(%rsp)
  263378:	mov    %r14,0x68(%rsp)
  26337d:	je     2633b6 <<glass::engine::Watch>::print_utf8+0x1016>
  26337f:	lock incq (%rax)
  263383:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  263389:	mov    0x10(%r15),%rdx
  26338d:	mov    %edi,0x60(%rsp)
  263391:	mov    %r11d,0x58(%rsp)
  263396:	mov    %ecx,%r10d
  263399:	mov    %ecx,0x5c(%rsp)
  26339d:	movzwl 0x40(%rsp),%ecx
  2633a2:	mov    %cx,0x64(%rsp)
  2633a7:	mov    %rax,0x50(%rsp)
  2633ac:	cmp    %rdx,%rsi
  2633af:	jbe    2633d0 <<glass::engine::Watch>::print_utf8+0x1030>
  2633b1:	jmp    2643d2 <<glass::engine::Watch>::print_utf8+0x2032>
  2633b6:	mov    %edi,0x60(%rsp)
  2633ba:	mov    %r11d,0x58(%rsp)
  2633bf:	mov    %ecx,0x5c(%rsp)
  2633c3:	mov    %dx,0x64(%rsp)
  2633c8:	mov    %rax,0x50(%rsp)
  2633cd:	mov    %ecx,%r10d
  2633d0:	mov    0x80(%rsp),%rax
  2633d8:	lea    0x0(,%rax,8),%rax
  2633e0:	lea    (%rax,%rax,2),%rax
  2633e4:	mov    0x8(%r15),%rbx
  2633e8:	add    %rax,%rbx
  2633eb:	lea    0x0(,%rsi,8),%rcx
  2633f3:	lea    (%rcx,%rcx,2),%r14
  2633f7:	sub    %rax,%r14
  2633fa:	mov    0x38(%rsp),%rcx
  2633ff:	movzwl 0x40(%rsp),%edx
  263404:	mov    %r8,0x70(%rsp)
  263409:	mov    %edi,0x30(%rsp)
  26340d:	mov    %r11d,0xd0(%rsp)
  263415:	mov    %r10d,0x88(%rsp)
  26341d:	jmp    26343c <<glass::engine::Watch>::print_utf8+0x109c>
  26341f:	nop
  263420:	mov    %rcx,(%rbx)
  263423:	mov    %r11d,0x8(%rbx)
  263427:	mov    %r10d,0xc(%rbx)
  26342b:	mov    %edi,0x10(%rbx)
  26342e:	mov    %dx,0x14(%rbx)
  263432:	add    $0x18,%rbx
  263436:	add    $0xffffffffffffffe8,%r14
  26343a:	je     263492 <<glass::engine::Watch>::print_utf8+0x10f2>
  26343c:	test   %rcx,%rcx
  26343f:	je     26344b <<glass::engine::Watch>::print_utf8+0x10ab>
  263441:	lock incq (%rcx)
  263445:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  26344b:	mov    (%rbx),%rax
  26344e:	test   %rax,%rax
  263451:	je     263420 <<glass::engine::Watch>::print_utf8+0x1080>
  263453:	lock decq (%rax)
  263457:	jne    263420 <<glass::engine::Watch>::print_utf8+0x1080>
  263459:	mov    %rbx,%rdi
  26345c:	mov    %r9,%r15
  26345f:	call   *0x38e623(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  263465:	movzwl 0x40(%rsp),%edx
  26346a:	mov    0x88(%rsp),%r10d
  263472:	mov    0xd0(%rsp),%r11d
  26347a:	mov    0x30(%rsp),%edi
  26347e:	mov    0x38(%rsp),%rcx
  263483:	mov    %r15,%r9
  263486:	mov    0x20(%rsp),%r15
  26348b:	mov    0x70(%rsp),%r8
  263490:	jmp    263420 <<glass::engine::Watch>::print_utf8+0x1080>
  263492:	mov    0x80(%rsp),%rax
  26349a:	cmp    %eax,0x38(%r15)
  26349e:	mov    0xa0(%rsp),%r10
  2634a6:	mov    0x18(%rsp),%rbx
  2634ab:	lea    (%rbx,%r12,1),%r11
  2634af:	mov    0x68(%rsp),%r14
  2634b4:	jbe    2634ba <<glass::engine::Watch>::print_utf8+0x111a>
  2634b6:	mov    %eax,0x38(%r15)
  2634ba:	test   %rcx,%rcx
  2634bd:	mov    0x98(%rsp),%rsi
  2634c5:	je     263509 <<glass::engine::Watch>::print_utf8+0x1169>
  2634c7:	lock decq (%rcx)
  2634cb:	jne    263509 <<glass::engine::Watch>::print_utf8+0x1169>
  2634cd:	lea    0x50(%rsp),%rdi
  2634d2:	mov    %r8,%rbx
  2634d5:	mov    %r11,%r15
  2634d8:	mov    %r9,%r14
  2634db:	call   *0x38e5a7(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  2634e1:	mov    0x98(%rsp),%rsi
  2634e9:	mov    %r14,%r9
  2634ec:	mov    0x68(%rsp),%r14
  2634f1:	mov    %r15,%r11
  2634f4:	mov    0x20(%rsp),%r15
  2634f9:	mov    0xa0(%rsp),%r10
  263501:	mov    %rbx,%r8
  263504:	mov    0x18(%rsp),%rbx
  263509:	mov    0x10(%r15),%rax
  26350d:	cmp    %rax,%rsi
  263510:	jb     263575 <<glass::engine::Watch>::print_utf8+0x11d5>
  263512:	cmpl   $0xffffffff,0x28(%r15)
  263517:	je     26356d <<glass::engine::Watch>::print_utf8+0x11cd>
  263519:	mov    0x48(%rsp),%rax
  26351e:	mov    (%rax),%rax
  263521:	test   %rax,%rax
  263524:	je     26356d <<glass::engine::Watch>::print_utf8+0x11cd>
  263526:	lock decq (%rax)
  26352a:	jne    26356d <<glass::engine::Watch>::print_utf8+0x11cd>
  26352c:	mov    0x48(%rsp),%rdi
  263531:	mov    %r8,%rbx
  263534:	mov    %r10,0xa0(%rsp)
  26353c:	mov    %r11,%r15
  26353f:	mov    %r14,0x68(%rsp)
  263544:	mov    %r9,%r14
  263547:	call   *0x38e53b(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  26354d:	mov    %r14,%r9
  263550:	mov    0x68(%rsp),%r14
  263555:	mov    %r15,%r11
  263558:	mov    0x20(%rsp),%r15
  26355d:	mov    0xa0(%rsp),%r10
  263565:	mov    %rbx,%r8
  263568:	mov    0x18(%rsp),%rbx
  26356d:	movl   $0xffffffff,0x28(%r15)
  263575:	mov    0x30(%r15),%rax
  263579:	lea    0x1(%rbx),%rcx
  26357d:	cmp    %rax,%rcx
  263580:	cmova  %rcx,%rax
  263584:	mov    0x10(%r15),%rsi
  263588:	mov    %rax,0x30(%r15)
  26358c:	cmp    %rsi,%rbx
  26358f:	jae    2644bb <<glass::engine::Watch>::print_utf8+0x211b>
  263595:	mov    0xb0(%rsp),%esi
  26359c:	mov    %esi,%eax
  26359e:	or     $0x20,%eax
  2635a1:	cmp    $0x2,%r12
  2635a5:	mov    0x8(%r15),%rcx
  2635a9:	lea    (%rbx,%rbx,2),%rdx
  2635ad:	lea    (%rcx,%rdx,8),%rbx
  2635b1:	mov    %ebp,0x10(%rcx,%rdx,8)
  2635b5:	mov    0xc(%rsp),%edi
  2635b9:	mov    %edi,0x8(%rcx,%rdx,8)
  2635bd:	cmovne %esi,%eax
  2635c0:	mov    0xa8(%rsp),%esi
  2635c7:	mov    %esi,0xc(%rcx,%rdx,8)
  2635cb:	mov    %ax,0x14(%rcx,%rdx,8)
  2635d0:	mov    (%rcx,%rdx,8),%rax
  2635d4:	test   %rax,%rax
  2635d7:	je     263612 <<glass::engine::Watch>::print_utf8+0x1272>
  2635d9:	lock decq (%rax)
  2635dd:	jne    263612 <<glass::engine::Watch>::print_utf8+0x1272>
  2635df:	mov    %rbx,%rdi
  2635e2:	mov    %r10,%rbp
  2635e5:	mov    %r14,0x68(%rsp)
  2635ea:	mov    %r8,%r14
  2635ed:	mov    %r9,%r15
  2635f0:	call   *0x38e492(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  2635f6:	mov    %r15,%r9
  2635f9:	mov    0x20(%rsp),%r15
  2635fe:	mov    %r14,%r8
  263601:	mov    0x68(%rsp),%r14
  263606:	mov    0x18(%rsp),%rax
  26360b:	lea    (%rax,%r12,1),%r11
  26360f:	mov    %rbp,%r10
  263612:	movq   $0x0,(%rbx)
  263619:	cmp    $0x2,%r12
  26361d:	jne    2639e2 <<glass::engine::Watch>::print_utf8+0x1642>
  263623:	mov    0x18(%rsp),%rbx
  263628:	lea    0x1(%rbx),%r12
  26362c:	mov    0x30(%r15),%rax
  263630:	mov    0x28(%r15),%ecx
  263634:	cmp    %rax,%r12
  263637:	jne    26365c <<glass::engine::Watch>::print_utf8+0x12bc>
  263639:	cmp    $0xffffffff,%ecx
  26363c:	je     26365c <<glass::engine::Watch>::print_utf8+0x12bc>
  26363e:	add    $0x2,%rbx
  263642:	mov    %rbx,0x30(%r15)
  263646:	mov    0x10(%r15),%rsi
  26364a:	cmp    %rsi,%r12
  26364d:	mov    0xc(%rsp),%edx
  263651:	jb     263969 <<glass::engine::Watch>::print_utf8+0x15c9>
  263657:	jmp    263d87 <<glass::engine::Watch>::print_utf8+0x19e7>
  26365c:	cmp    $0xffffffff,%ecx
  26365f:	mov    0xc(%rsp),%edx
  263663:	je     263949 <<glass::engine::Watch>::print_utf8+0x15a9>
  263669:	mov    0x10(%r15),%rcx
  26366d:	cmp    %rax,%rcx
  263670:	mov    %rax,%rdx
  263673:	cmovb  %rcx,%rdx
  263677:	mov    %rdx,0x88(%rsp)
  26367f:	cmp    %r12,%rcx
  263682:	mov    %r12,%rsi
  263685:	cmovb  %rcx,%rsi
  263689:	mov    0x38e4b0(%rip),%rdx        # 5f1b40 <_DYNAMIC+0x320>
  263690:	movzbl (%rdx),%edx
  263693:	test   %dl,%dl
  263695:	je     263720 <<glass::engine::Watch>::print_utf8+0x1380>
  26369b:	mov    0x38e4d6(%rip),%rdx        # 5f1b78 <_DYNAMIC+0x358>
  2636a2:	mov    %rsi,%rbp
  2636a5:	cmp    %rsi,%rax
  2636a8:	jae    2636b1 <<glass::engine::Watch>::print_utf8+0x1311>
  2636aa:	mov    0x38e4cf(%rip),%rdx        # 5f1b80 <_DYNAMIC+0x360>
  2636b1:	lock incq 0x28(%rdx)
  2636b6:	mov    0x38e49b(%rip),%rdx        # 5f1b58 <_DYNAMIC+0x338>
  2636bd:	lock incq (%rdx)
  2636c1:	mov    %rbp,%rdx
  2636c4:	sub    0x88(%rsp),%rdx
  2636cc:	jne    2636d2 <<glass::engine::Watch>::print_utf8+0x1332>
  2636ce:	xor    %esi,%esi
  2636d0:	jmp    263711 <<glass::engine::Watch>::print_utf8+0x1371>
  2636d2:	mov    0x38e487(%rip),%rsi        # 5f1b60 <_DYNAMIC+0x340>
  2636d9:	lock add %rdx,(%rsi)
  2636dd:	cmp    $0x5,%rdx
  2636e1:	jae    2636f1 <<glass::engine::Watch>::print_utf8+0x1351>
  2636e3:	lea    -0x205bd2(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2636ea:	movzbl -0x1(%rdx,%rsi,1),%esi
  2636ef:	jmp    263711 <<glass::engine::Watch>::print_utf8+0x1371>
  2636f1:	lea    -0x5(%rdx),%rdi
  2636f5:	mov    $0x4,%esi
  2636fa:	cmp    $0x4,%rdi
  2636fe:	jb     263711 <<glass::engine::Watch>::print_utf8+0x1371>
  263700:	add    $0xfffffffffffffff7,%rdx
  263704:	cmp    $0x8,%rdx
  263708:	mov    $0x6,%esi
  26370d:	sbb    $0x0,%rsi
  263711:	mov    0x38e438(%rip),%rdx        # 5f1b50 <_DYNAMIC+0x330>
  263718:	lock incq (%rdx,%rsi,8)
  26371d:	mov    %rbp,%rsi
  263720:	cmp    %rsi,%rax
  263723:	mov    0xc(%rsp),%edx
  263727:	mov    %r12,0x98(%rsp)
  26372f:	jae    2638fe <<glass::engine::Watch>::print_utf8+0x155e>
  263735:	mov    0x28(%r15),%edi
  263739:	mov    0x20(%r15),%ebp
  26373d:	mov    0x24(%r15),%eax
  263741:	movzwl 0x2c(%r15),%ecx
  263746:	mov    0x18(%r15),%r12
  26374a:	test   %r12,%r12
  26374d:	mov    %r12,0x38(%rsp)
  263752:	mov    %eax,0x40(%rsp)
  263756:	mov    %r10,0xa0(%rsp)
  26375e:	mov    %r11,0xc8(%rsp)
  263766:	mov    %r14,0x68(%rsp)
  26376b:	je     26379f <<glass::engine::Watch>::print_utf8+0x13ff>
  26376d:	lock incq (%r12)
  263772:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  263778:	mov    0x10(%r15),%rdx
  26377c:	mov    %edi,0x60(%rsp)
  263780:	mov    %ebp,0x58(%rsp)
  263784:	mov    %eax,0x5c(%rsp)
  263788:	mov    %ecx,%r10d
  26378b:	mov    %cx,0x64(%rsp)
  263790:	mov    %r12,0x50(%rsp)
  263795:	cmp    %rdx,%rsi
  263798:	jbe    2637b8 <<glass::engine::Watch>::print_utf8+0x1418>
  26379a:	jmp    2643ec <<glass::engine::Watch>::print_utf8+0x204c>
  26379f:	mov    %edi,0x60(%rsp)
  2637a3:	mov    %ebp,0x58(%rsp)
  2637a7:	mov    %eax,0x5c(%rsp)
  2637ab:	mov    %cx,0x64(%rsp)
  2637b0:	mov    %r12,0x50(%rsp)
  2637b5:	mov    %ecx,%r10d
  2637b8:	mov    0x88(%rsp),%rax
  2637c0:	lea    0x0(,%rax,8),%rax
  2637c8:	lea    (%rax,%rax,2),%rax
  2637cc:	mov    0x8(%r15),%rbx
  2637d0:	add    %rax,%rbx
  2637d3:	mov    %rsi,0x80(%rsp)
  2637db:	lea    0x0(,%rsi,8),%rcx
  2637e3:	lea    (%rcx,%rcx,2),%r14
  2637e7:	sub    %rax,%r14
  2637ea:	mov    0x40(%rsp),%ecx
  2637ee:	mov    %ebp,0x30(%rsp)
  2637f2:	mov    %edi,0xd0(%rsp)
  2637f9:	jmp    26381b <<glass::engine::Watch>::print_utf8+0x147b>
  2637fb:	nopl   0x0(%rax,%rax,1)
  263800:	mov    %r12,(%rbx)
  263803:	mov    %ebp,0x8(%rbx)
  263806:	mov    %ecx,0xc(%rbx)
  263809:	mov    %edi,0x10(%rbx)
  26380c:	mov    %r10w,0x14(%rbx)
  263811:	add    $0x18,%rbx
  263815:	add    $0xffffffffffffffe8,%r14
  263819:	je     26386f <<glass::engine::Watch>::print_utf8+0x14cf>
  26381b:	test   %r12,%r12
  26381e:	je     26382b <<glass::engine::Watch>::print_utf8+0x148b>
  263820:	lock incq (%r12)
  263825:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  26382b:	mov    (%rbx),%rax
  26382e:	test   %rax,%rax
  263831:	je     263800 <<glass::engine::Watch>::print_utf8+0x1460>
  263833:	lock decq (%rax)
  263837:	jne    263800 <<glass::engine::Watch>::print_utf8+0x1460>
  263839:	mov    %rbx,%rdi
  26383c:	mov    %r8,%r15
  26383f:	mov    %r9,%rbp
  263842:	mov    %r10d,%r12d
  263845:	call   *0x38e23d(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  26384b:	mov    %r12d,%r10d
  26384e:	mov    0x40(%rsp),%ecx
  263852:	mov    0xd0(%rsp),%edi
  263859:	mov    0x38(%rsp),%r12
  26385e:	mov    %rbp,%r9
  263861:	mov    0x30(%rsp),%ebp
  263865:	mov    %r15,%r8
  263868:	mov    0x20(%rsp),%r15
  26386d:	jmp    263800 <<glass::engine::Watch>::print_utf8+0x1460>
  26386f:	mov    0x88(%rsp),%rax
  263877:	cmp    %eax,0x38(%r15)
  26387b:	mov    0xa0(%rsp),%r10
  263883:	mov    0xc8(%rsp),%r11
  26388b:	mov    0x68(%rsp),%r14
  263890:	mov    0x18(%rsp),%rbx
  263895:	mov    0xc(%rsp),%edx
  263899:	jbe    26389f <<glass::engine::Watch>::print_utf8+0x14ff>
  26389b:	mov    %eax,0x38(%r15)
  26389f:	test   %r12,%r12
  2638a2:	mov    0x80(%rsp),%rsi
  2638aa:	je     2638f2 <<glass::engine::Watch>::print_utf8+0x1552>
  2638ac:	lock decq (%r12)
  2638b1:	jne    2638f2 <<glass::engine::Watch>::print_utf8+0x1552>
  2638b3:	lea    0x50(%rsp),%rdi
  2638b8:	mov    %r8,%rbx
  2638bb:	mov    %r10,%r15
  2638be:	mov    %r11,%r12
  2638c1:	mov    %r14,%rbp
  2638c4:	mov    %r9,%r14
  2638c7:	call   *0x38e1bb(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  2638cd:	mov    0x80(%rsp),%rsi
  2638d5:	mov    0xc(%rsp),%edx
  2638d9:	mov    %r14,%r9
  2638dc:	mov    %rbp,%r14
  2638df:	mov    %r12,%r11
  2638e2:	mov    %r15,%r10
  2638e5:	mov    0x20(%rsp),%r15
  2638ea:	mov    %rbx,%r8
  2638ed:	mov    0x18(%rsp),%rbx
  2638f2:	mov    0x10(%r15),%rcx
  2638f6:	mov    0x98(%rsp),%r12
  2638fe:	cmp    %rcx,%rsi
  263901:	jb     263949 <<glass::engine::Watch>::print_utf8+0x15a9>
  263903:	mov    0x48(%rsp),%rdi
  263908:	mov    %r8,%rbx
  26390b:	mov    %r10,%r15
  26390e:	mov    %r11,%r12
  263911:	mov    %r14,%rbp
  263914:	mov    %r9,%r14
  263917:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26391c:	mov    0xc(%rsp),%edx
  263920:	mov    %r14,%r9
  263923:	mov    %rbp,%r14
  263926:	mov    %r12,%r11
  263929:	mov    0x98(%rsp),%r12
  263931:	mov    %r15,%r10
  263934:	mov    0x20(%rsp),%r15
  263939:	mov    %rbx,%r8
  26393c:	mov    0x18(%rsp),%rbx
  263941:	movl   $0xffffffff,0x28(%r15)
  263949:	mov    0x30(%r15),%rax
  26394d:	add    $0x2,%rbx
  263951:	cmp    %rax,%rbx
  263954:	cmovbe %rax,%rbx
  263958:	mov    0x10(%r15),%rsi
  26395c:	mov    %rbx,0x30(%r15)
  263960:	cmp    %rsi,%r12
  263963:	jae    2644cb <<glass::engine::Watch>::print_utf8+0x212b>
  263969:	mov    0x8(%r15),%rax
  26396d:	lea    (%r12,%r12,2),%rcx
  263971:	lea    (%rax,%rcx,8),%rbx
  263975:	movl   $0x20,0x10(%rax,%rcx,8)
  26397d:	mov    %edx,0x8(%rax,%rcx,8)
  263981:	mov    0xa8(%rsp),%edx
  263988:	mov    %edx,0xc(%rax,%rcx,8)
  26398c:	mov    0xb0(%rsp),%edx
  263993:	or     $0x40,%edx
  263996:	mov    %dx,0x14(%rax,%rcx,8)
  26399b:	mov    (%rax,%rcx,8),%rax
  26399f:	test   %rax,%rax
  2639a2:	je     2639db <<glass::engine::Watch>::print_utf8+0x163b>
  2639a4:	lock decq (%rax)
  2639a8:	jne    2639db <<glass::engine::Watch>::print_utf8+0x163b>
  2639aa:	mov    %rbx,%rdi
  2639ad:	mov    %r10,%r12
  2639b0:	mov    %r11,0xc8(%rsp)
  2639b8:	mov    %r14,%rbp
  2639bb:	mov    %r8,%r14
  2639be:	mov    %r9,%r15
  2639c1:	call   *0x38e0c1(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  2639c7:	mov    %r15,%r9
  2639ca:	mov    %r14,%r8
  2639cd:	mov    %rbp,%r14
  2639d0:	mov    0xc8(%rsp),%r11
  2639d8:	mov    %r12,%r10
  2639db:	movq   $0x0,(%rbx)
  2639e2:	cmp    %r14,%r11
  2639e5:	mov    0x78(%rsp),%rsi
  2639ea:	jb     2639f4 <<glass::engine::Watch>::print_utf8+0x1654>
  2639ec:	dec    %r11
  2639ef:	movb   $0x1,0x6c(%r10)
  2639f4:	mov    %r11,0x40(%r10)
  2639f8:	mov    0xb8(%rsp),%r14
  263a00:	incq   0xa0(%r14)
  263a07:	jmp    262463 <<glass::engine::Watch>::print_utf8+0xc3>
  263a0c:	mov    %r8,%rbx
  263a0f:	mov    %r9,%r14
  263a12:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263a17:	mov    %r14,%r9
  263a1a:	mov    %rbx,%r8
  263a1d:	mov    %ebp,%ebx
  263a1f:	mov    0x390fca(%rip),%rsi        # 5f49f0 <glass::engine::width_of::CACHE+0x8>
  263a26:	cmp    %rbx,%rsi
  263a29:	ja     26304b <<glass::engine::Watch>::print_utf8+0xcab>
  263a2f:	jmp    2643c2 <<glass::engine::Watch>::print_utf8+0x2022>
  263a34:	movzbl %r11b,%edx
  263a38:	mov    %r10,%rbx
  263a3b:	add    %r10,%rdx
  263a3e:	mov    0x68(%rsp),%rdi
  263a43:	mov    0x40(%rsp),%rsi
  263a48:	lea    0xf0(%rsp),%rcx
  263a50:	mov    %r9,0x48(%rsp)
  263a55:	mov    %r11,%r12
  263a58:	call   2a1680 <glass::engine::note_uniform_span>
  263a5d:	mov    %r12,%r11
  263a60:	mov    0x48(%rsp),%r9
  263a65:	mov    0x78(%rsp),%rsi
  263a6a:	mov    %ebp,%r8d
  263a6d:	mov    %rbx,%rbp
  263a70:	jmp    262e5d <<glass::engine::Watch>::print_utf8+0xabd>
  263a75:	cmpq   $0x400,0xa0(%r14)
  263a80:	jb     263aab <<glass::engine::Watch>::print_utf8+0x170b>
  263a82:	mov    %r14,%rdi
  263a85:	call   264840 <<glass::engine::Watch>::fold_sentinel>
  263a8a:	movq   $0x0,0xa0(%r14)
  263a95:	mov    0x390f65(%rip),%eax        # 5f4a00 <glass::engine::run_whole::ON>
  263a9b:	test   %eax,%eax
  263a9d:	je     263ab5 <<glass::engine::Watch>::print_utf8+0x1715>
  263a9f:	call   18ba06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  263aa4:	cmp    %r13,%r15
  263aa7:	je     263aba <<glass::engine::Watch>::print_utf8+0x171a>
  263aa9:	jmp    263aea <<glass::engine::Watch>::print_utf8+0x174a>
  263aab:	mov    0x390f4f(%rip),%eax        # 5f4a00 <glass::engine::run_whole::ON>
  263ab1:	test   %eax,%eax
  263ab3:	jne    263a9f <<glass::engine::Watch>::print_utf8+0x16ff>
  263ab5:	cmp    %r13,%r15
  263ab8:	jne    263aea <<glass::engine::Watch>::print_utf8+0x174a>
  263aba:	cmpb   $0x0,0x390f43(%rip)        # 5f4a04 <glass::engine::run_whole::ON+0x4>
  263ac1:	je     263aea <<glass::engine::Watch>::print_utf8+0x174a>
  263ac3:	cmp    $0xffffffff,%ebp
  263ac6:	je     263c8b <<glass::engine::Watch>::print_utf8+0x18eb>
  263acc:	lea    -0x20(%rbp),%eax
  263acf:	cmp    $0x5f,%eax
  263ad2:	jae    263afb <<glass::engine::Watch>::print_utf8+0x175b>
  263ad4:	mov    $0x1,%r15d
  263ada:	cmpb   $0x0,0x10(%rsp)
  263adf:	jne    263bc0 <<glass::engine::Watch>::print_utf8+0x1820>
  263ae5:	jmp    263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263aea:	xor    %eax,%eax
  263aec:	cmp    $0xffffffff,%ebp
  263aef:	cmove  %rax,%rbx
  263af3:	mov    %rbx,%r13
  263af6:	jmp    263c8b <<glass::engine::Watch>::print_utf8+0x18eb>
  263afb:	cmpb   $0x0,0x28(%rsp)
  263b00:	je     263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263b06:	mov    0x390eec(%rip),%eax        # 5f49f8 <glass::engine::width_of::CACHE+0x10>
  263b0c:	test   %eax,%eax
  263b0e:	jne    2643ab <<glass::engine::Watch>::print_utf8+0x200b>
  263b14:	mov    %ebp,%ebx
  263b16:	mov    0x390ed3(%rip),%rsi        # 5f49f0 <glass::engine::width_of::CACHE+0x8>
  263b1d:	cmp    %rbx,%rsi
  263b20:	jbe    2643c2 <<glass::engine::Watch>::print_utf8+0x2022>
  263b26:	mov    0x390ebb(%rip),%r14        # 5f49e8 <glass::engine::width_of::CACHE>
  263b2d:	movzbl (%r14,%rbx,1),%eax
  263b32:	movzbl %al,%r15d
  263b36:	test   %r15b,%r15b
  263b39:	js     263b46 <<glass::engine::Watch>::print_utf8+0x17a6>
  263b3b:	mov    $0x1,%cl
  263b3d:	test   %cl,%cl
  263b3f:	jne    263bb2 <<glass::engine::Watch>::print_utf8+0x1812>
  263b41:	jmp    263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263b46:	cmp    $0xfe,%r15d
  263b4d:	je     263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263b53:	mov    $0xfe,%al
  263b55:	cmp    $0x7f,%ebp
  263b58:	jae    263b8d <<glass::engine::Watch>::print_utf8+0x17ed>
  263b5a:	mov    $0x1,%r15d
  263b60:	xor    %ecx,%ecx
  263b62:	jmp    263ba6 <<glass::engine::Watch>::print_utf8+0x1806>
  263b64:	mov    $0x1,%cl
  263b66:	mov    %ecx,0x28(%rsp)
  263b6a:	cmpb   $0x0,0x68(%rax)
  263b6e:	jne    263b80 <<glass::engine::Watch>::print_utf8+0x17e0>
  263b70:	cmpb   $0x0,0x69(%rax)
  263b74:	jne    263b80 <<glass::engine::Watch>::print_utf8+0x17e0>
  263b76:	cmpb   $0x0,0x6a(%rax)
  263b7a:	je     263da7 <<glass::engine::Watch>::print_utf8+0x1a07>
  263b80:	movl   $0x0,0x10(%rsp)
  263b88:	jmp    2623fb <<glass::engine::Watch>::print_utf8+0x5b>
  263b8d:	cmp    $0xa0,%ebp
  263b93:	jb     263ba4 <<glass::engine::Watch>::print_utf8+0x1804>
  263b95:	mov    %ebp,%edi
  263b97:	call   298820 <unicode_width::tables::lookup_width>
  263b9c:	movzbl %al,%r15d
  263ba0:	mov    $0x1,%cl
  263ba2:	jmp    263ba6 <<glass::engine::Watch>::print_utf8+0x1806>
  263ba4:	xor    %ecx,%ecx
  263ba6:	mov    %al,(%r14,%rbx,1)
  263baa:	test   %cl,%cl
  263bac:	je     263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263bb2:	lea    -0x1(%r15),%rax
  263bb6:	cmp    $0x1,%rax
  263bba:	ja     263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263bc0:	mov    0xb8(%rsp),%rax
  263bc8:	mov    0x78(%rax),%r14
  263bcc:	cmpb   $0x0,0x6c(%r14)
  263bd1:	jne    263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263bd7:	mov    0x40(%r14),%r12
  263bdb:	mov    0xa0(%r14),%r8
  263be2:	lea    (%r12,%r15,1),%rdx
  263be6:	cmp    %r8,%rdx
  263be9:	ja     263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263bef:	mov    0x30(%r14),%eax
  263bf3:	sub    0x48(%r14),%eax
  263bf7:	cltq
  263bf9:	mov    0x20(%r14),%rsi
  263bfd:	mov    0x28(%r14),%rcx
  263c01:	lea    (%rcx,%rax,1),%rdi
  263c05:	dec    %rdi
  263c08:	xor    %eax,%eax
  263c0a:	cmp    %rsi,%rdi
  263c0d:	cmovae %rsi,%rax
  263c11:	sub    %rax,%rdi
  263c14:	cmp    %rsi,%rdi
  263c17:	jae    26446d <<glass::engine::Watch>::print_utf8+0x20cd>
  263c1d:	mov    0x58(%r14),%r10d
  263c21:	mov    0x5c(%r14),%r11d
  263c25:	movzwl 0x64(%r14),%r9d
  263c2a:	mov    0x18(%r14),%rax
  263c2e:	shl    $0x6,%rdi
  263c32:	lea    (%rax,%rdi,1),%rbx
  263c36:	lea    (%rax,%rdi,1),%rcx
  263c3a:	add    $0x18,%rcx
  263c3e:	mov    %rcx,0x90(%rsp)
  263c46:	mov    0x28(%rax,%rdi,1),%eax
  263c4a:	cmp    $0xffffffff,%eax
  263c4d:	je     263c5d <<glass::engine::Watch>::print_utf8+0x18bd>
  263c4f:	mov    0x90(%rsp),%rcx
  263c57:	cmp    0x30(%rbx),%r12
  263c5b:	jae    263c76 <<glass::engine::Watch>::print_utf8+0x18d6>
  263c5d:	mov    0x10(%rbx),%rsi
  263c61:	cmp    %rsi,%r12
  263c64:	jae    2644db <<glass::engine::Watch>::print_utf8+0x213b>
  263c6a:	lea    (%r12,%r12,2),%rcx
  263c6e:	shl    $0x3,%rcx
  263c72:	add    0x8(%rbx),%rcx
  263c76:	testb  $0x60,0x14(%rcx)
  263c7a:	je     263ca0 <<glass::engine::Watch>::print_utf8+0x1900>
  263c7c:	mov    0xb8(%rsp),%rdi
  263c84:	mov    %ebp,%esi
  263c86:	call   33d200 <<glass::engine::Watch as vte::ansi::Handler>::input>
  263c8b:	mov    %r13,%rax
  263c8e:	add    $0x118,%rsp
  263c95:	pop    %rbx
  263c96:	pop    %r12
  263c98:	pop    %r13
  263c9a:	pop    %r14
  263c9c:	pop    %r15
  263c9e:	pop    %rbp
  263c9f:	ret
  263ca0:	cmp    $0x2,%r15
  263ca4:	jne    263cdd <<glass::engine::Watch>::print_utf8+0x193d>
  263ca6:	lea    0x1(%r12),%rdi
  263cab:	cmp    $0xffffffff,%eax
  263cae:	je     263cbe <<glass::engine::Watch>::print_utf8+0x191e>
  263cb0:	mov    0x90(%rsp),%rcx
  263cb8:	cmp    0x30(%rbx),%rdi
  263cbc:	jae    263cd7 <<glass::engine::Watch>::print_utf8+0x1937>
  263cbe:	mov    0x10(%rbx),%rsi
  263cc2:	cmp    %rsi,%rdi
  263cc5:	jae    26449e <<glass::engine::Watch>::print_utf8+0x20fe>
  263ccb:	lea    (%rdi,%rdi,2),%rcx
  263ccf:	shl    $0x3,%rcx
  263cd3:	add    0x8(%rbx),%rcx
  263cd7:	testb  $0x60,0x14(%rcx)
  263cdb:	jne    263c7c <<glass::engine::Watch>::print_utf8+0x18dc>
  263cdd:	mov    %r11d,0x70(%rsp)
  263ce2:	mov    %r10d,0x48(%rsp)
  263ce7:	mov    %r9d,0x78(%rsp)
  263cec:	mov    %r8,0xa8(%rsp)
  263cf4:	mov    %rdx,0xb0(%rsp)
  263cfc:	cmp    %r12d,0x38(%rbx)
  263d00:	jbe    263d06 <<glass::engine::Watch>::print_utf8+0x1966>
  263d02:	mov    %r12d,0x38(%rbx)
  263d06:	cmp    $0xffffffff,%eax
  263d09:	setne  %cl
  263d0c:	mov    %rbx,%rdi
  263d0f:	mov    0x30(%rbx),%rbx
  263d13:	cmp    %rbx,%r12
  263d16:	sete   %dl
  263d19:	test   %dl,%cl
  263d1b:	mov    %rdi,0x28(%rsp)
  263d20:	jne    263d6e <<glass::engine::Watch>::print_utf8+0x19ce>
  263d22:	cmp    $0xffffffff,%eax
  263d25:	je     263fcf <<glass::engine::Watch>::print_utf8+0x1c2f>
  263d2b:	mov    0x28(%rsp),%rax
  263d30:	mov    0x10(%rax),%r13
  263d34:	cmp    %rbx,%r13
  263d37:	mov    %rbx,%rax
  263d3a:	cmovb  %r13,%rax
  263d3e:	mov    %rax,0x10(%rsp)
  263d43:	cmp    %r12,%r13
  263d46:	mov    %r12,%rcx
  263d49:	cmovb  %r13,%rcx
  263d4d:	mov    0x38ddec(%rip),%rax        # 5f1b40 <_DYNAMIC+0x320>
  263d54:	movzbl (%rax),%eax
  263d57:	test   %al,%al
  263d59:	mov    %rcx,0x30(%rsp)
  263d5e:	je     263dd5 <<glass::engine::Watch>::print_utf8+0x1a35>
  263d60:	cmp    %rcx,%rbx
  263d63:	jae    263db7 <<glass::engine::Watch>::print_utf8+0x1a17>
  263d65:	mov    0x38de14(%rip),%rax        # 5f1b80 <_DYNAMIC+0x360>
  263d6c:	jmp    263dbe <<glass::engine::Watch>::print_utf8+0x1a1e>
  263d6e:	lea    0x1(%r12),%rax
  263d73:	mov    %rax,0x30(%rdi)
  263d77:	mov    0x10(%rdi),%rsi
  263d7b:	cmp    %rsi,%r12
  263d7e:	mov    %rdi,%rdx
  263d81:	jb     263ff5 <<glass::engine::Watch>::print_utf8+0x1c55>
  263d87:	lea    0x36561a(%rip),%rdx        # 5c93a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  263d8e:	mov    %r12,%rdi
  263d91:	call   *0x38dca1(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  263d97:	lea    0x365562(%rip),%rcx        # 5c9300 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15a80>
  263d9e:	mov    %rbp,%rdi
  263da1:	call   *0x38de51(%rip)        # 5f1bf8 <_DYNAMIC+0x3d8>
  263da7:	cmpb   $0x0,0x6b(%rax)
  263dab:	sete   %al
  263dae:	mov    %eax,0x10(%rsp)
  263db2:	jmp    2623fb <<glass::engine::Watch>::print_utf8+0x5b>
  263db7:	mov    0x38ddba(%rip),%rax        # 5f1b78 <_DYNAMIC+0x358>
  263dbe:	lock incq 0x28(%rax)
  263dc3:	mov    %rcx,%rdi
  263dc6:	sub    0x10(%rsp),%rdi
  263dcb:	call   2f6db0 <alacritty_terminal::grid::row::fill_census::note>
  263dd0:	mov    0x30(%rsp),%rcx
  263dd5:	cmp    %rcx,%rbx
  263dd8:	jae    263fa9 <<glass::engine::Watch>::print_utf8+0x1c09>
  263dde:	mov    0x28(%rsp),%rcx
  263de3:	mov    0x28(%rcx),%edi
  263de6:	mov    0x20(%rcx),%r8d
  263dea:	mov    0x24(%rcx),%r9d
  263dee:	movzwl 0x2c(%rcx),%r10d
  263df3:	mov    0x18(%rcx),%rsi
  263df7:	test   %rsi,%rsi
  263dfa:	mov    %rsi,0x20(%rsp)
  263dff:	mov    %edi,0xc(%rsp)
  263e03:	mov    %r8d,0x18(%rsp)
  263e08:	mov    %r9d,0x40(%rsp)
  263e0d:	mov    %r10w,0x38(%rsp)
  263e13:	je     263ed9 <<glass::engine::Watch>::print_utf8+0x1b39>
  263e19:	lock incq (%rsi)
  263e1d:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  263e23:	mov    0x10(%rcx),%rdx
  263e27:	mov    %edi,0x60(%rsp)
  263e2b:	mov    %r8d,0x58(%rsp)
  263e30:	mov    %r9d,0x5c(%rsp)
  263e35:	mov    %r10w,0x64(%rsp)
  263e3b:	mov    %rsi,0x50(%rsp)
  263e40:	mov    0x30(%rsp),%rsi
  263e45:	cmp    %rdx,%rsi
  263e48:	ja     264459 <<glass::engine::Watch>::print_utf8+0x20b9>
  263e4e:	mov    0x10(%rsp),%rax
  263e53:	lea    0x0(,%rax,8),%rax
  263e5b:	lea    (%rax,%rax,2),%rax
  263e5f:	mov    0x8(%rcx),%rbx
  263e63:	add    %rax,%rbx
  263e66:	lea    0x0(,%rsi,8),%rcx
  263e6e:	lea    (%rcx,%rcx,2),%r13
  263e72:	sub    %rax,%r13
  263e75:	mov    0x20(%rsp),%rsi
  263e7a:	jmp    263e9d <<glass::engine::Watch>::print_utf8+0x1afd>
  263e7c:	mov    %rsi,(%rbx)
  263e7f:	mov    %r8d,0x8(%rbx)
  263e83:	mov    %r9d,0xc(%rbx)
  263e87:	mov    %edi,0x10(%rbx)
  263e8a:	mov    %r10w,0x14(%rbx)
  263e8f:	add    $0x18,%rbx
  263e93:	add    $0xffffffffffffffe8,%r13
  263e97:	je     263f73 <<glass::engine::Watch>::print_utf8+0x1bd3>
  263e9d:	lock incq (%rsi)
  263ea1:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  263ea7:	mov    (%rbx),%rax
  263eaa:	test   %rax,%rax
  263ead:	je     263e7c <<glass::engine::Watch>::print_utf8+0x1adc>
  263eaf:	lock decq (%rax)
  263eb3:	jne    263e7c <<glass::engine::Watch>::print_utf8+0x1adc>
  263eb5:	mov    %rbx,%rdi
  263eb8:	call   *0x38dbca(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  263ebe:	movzwl 0x38(%rsp),%r10d
  263ec4:	mov    0x40(%rsp),%r9d
  263ec9:	mov    0x18(%rsp),%r8d
  263ece:	mov    0xc(%rsp),%edi
  263ed2:	mov    0x20(%rsp),%rsi
  263ed7:	jmp    263e7c <<glass::engine::Watch>::print_utf8+0x1adc>
  263ed9:	mov    %edi,0x60(%rsp)
  263edd:	mov    %r8d,0x58(%rsp)
  263ee2:	mov    %r9d,0x5c(%rsp)
  263ee7:	mov    %r10w,0x64(%rsp)
  263eed:	mov    %rsi,0x50(%rsp)
  263ef2:	mov    0x10(%rsp),%rax
  263ef7:	lea    0x0(,%rax,8),%rax
  263eff:	lea    (%rax,%rax,2),%rax
  263f03:	mov    0x8(%rcx),%rbx
  263f07:	add    %rax,%rbx
  263f0a:	mov    0x30(%rsp),%rcx
  263f0f:	lea    0x0(,%rcx,8),%rcx
  263f17:	lea    (%rcx,%rcx,2),%r13
  263f1b:	sub    %rax,%r13
  263f1e:	jmp    263f41 <<glass::engine::Watch>::print_utf8+0x1ba1>
  263f20:	movq   $0x0,(%rbx)
  263f27:	mov    %r8d,0x8(%rbx)
  263f2b:	mov    %r9d,0xc(%rbx)
  263f2f:	mov    %edi,0x10(%rbx)
  263f32:	mov    %r10w,0x14(%rbx)
  263f37:	add    $0x18,%rbx
  263f3b:	add    $0xffffffffffffffe8,%r13
  263f3f:	je     263f73 <<glass::engine::Watch>::print_utf8+0x1bd3>
  263f41:	mov    (%rbx),%rax
  263f44:	test   %rax,%rax
  263f47:	je     263f20 <<glass::engine::Watch>::print_utf8+0x1b80>
  263f49:	lock decq (%rax)
  263f4d:	jne    263f20 <<glass::engine::Watch>::print_utf8+0x1b80>
  263f4f:	mov    %rbx,%rdi
  263f52:	call   *0x38db30(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  263f58:	movzwl 0x38(%rsp),%r10d
  263f5e:	mov    0x40(%rsp),%r9d
  263f63:	mov    0x18(%rsp),%r8d
  263f68:	mov    0xc(%rsp),%edi
  263f6c:	mov    0x20(%rsp),%rsi
  263f71:	jmp    263f20 <<glass::engine::Watch>::print_utf8+0x1b80>
  263f73:	mov    0x28(%rsp),%rbx
  263f78:	mov    0x10(%rsp),%rax
  263f7d:	cmp    %eax,0x38(%rbx)
  263f80:	jbe    263f85 <<glass::engine::Watch>::print_utf8+0x1be5>
  263f82:	mov    %eax,0x38(%rbx)
  263f85:	test   %rsi,%rsi
  263f88:	mov    0x30(%rsp),%rcx
  263f8d:	je     263fa5 <<glass::engine::Watch>::print_utf8+0x1c05>
  263f8f:	lock decq (%rsi)
  263f93:	jne    263fa5 <<glass::engine::Watch>::print_utf8+0x1c05>
  263f95:	lea    0x50(%rsp),%rdi
  263f9a:	call   *0x38dae8(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  263fa0:	mov    0x30(%rsp),%rcx
  263fa5:	mov    0x10(%rbx),%r13
  263fa9:	cmp    %r13,%rcx
  263fac:	mov    0xc0(%rsp),%r13
  263fb4:	jb     263fcf <<glass::engine::Watch>::print_utf8+0x1c2f>
  263fb6:	mov    0x90(%rsp),%rdi
  263fbe:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263fc3:	mov    0x28(%rsp),%rax
  263fc8:	movl   $0xffffffff,0x28(%rax)
  263fcf:	mov    0x28(%rsp),%rdx
  263fd4:	mov    0x30(%rdx),%rax
  263fd8:	lea    0x1(%r12),%rcx
  263fdd:	cmp    %rax,%rcx
  263fe0:	cmova  %rcx,%rax
  263fe4:	mov    0x10(%rdx),%rsi
  263fe8:	mov    %rax,0x30(%rdx)
  263fec:	cmp    %rsi,%r12
  263fef:	jae    2644cb <<glass::engine::Watch>::print_utf8+0x212b>
  263ff5:	mov    0x78(%rsp),%esi
  263ff9:	mov    %esi,%eax
  263ffb:	or     $0x20,%eax
  263ffe:	cmp    $0x2,%r15
  264002:	mov    0x8(%rdx),%rcx
  264006:	lea    (%r12,%r12,2),%rdx
  26400a:	lea    (%rcx,%rdx,8),%rbx
  26400e:	mov    %ebp,0x10(%rcx,%rdx,8)
  264012:	mov    0x48(%rsp),%edi
  264016:	mov    %edi,0x8(%rcx,%rdx,8)
  26401a:	cmovne %esi,%eax
  26401d:	mov    0x70(%rsp),%esi
  264021:	mov    %esi,0xc(%rcx,%rdx,8)
  264025:	mov    %ax,0x14(%rcx,%rdx,8)
  26402a:	mov    (%rcx,%rdx,8),%rax
  26402e:	test   %rax,%rax
  264031:	je     264042 <<glass::engine::Watch>::print_utf8+0x1ca2>
  264033:	lock decq (%rax)
  264037:	jne    264042 <<glass::engine::Watch>::print_utf8+0x1ca2>
  264039:	mov    %rbx,%rdi
  26403c:	call   *0x38da46(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  264042:	movq   $0x0,(%rbx)
  264049:	cmp    $0x2,%r15
  26404d:	mov    0xb8(%rsp),%r15
  264055:	jne    26437a <<glass::engine::Watch>::print_utf8+0x1fda>
  26405b:	lea    0x1(%r12),%rcx
  264060:	mov    0x28(%rsp),%rax
  264065:	mov    0x30(%rax),%rbx
  264069:	mov    0x28(%rax),%eax
  26406c:	mov    %rcx,0x20(%rsp)
  264071:	cmp    %rbx,%rcx
  264074:	jne    2640a7 <<glass::engine::Watch>::print_utf8+0x1d07>
  264076:	cmp    $0xffffffff,%eax
  264079:	je     2640a7 <<glass::engine::Watch>::print_utf8+0x1d07>
  26407b:	add    $0x2,%r12
  26407f:	mov    0x28(%rsp),%rcx
  264084:	mov    %r12,0x30(%rcx)
  264088:	mov    0x10(%rcx),%rsi
  26408c:	mov    0x20(%rsp),%rdi
  264091:	cmp    %rsi,%rdi
  264094:	jb     26432b <<glass::engine::Watch>::print_utf8+0x1f8b>
  26409a:	lea    0x365307(%rip),%rdx        # 5c93a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  2640a1:	call   *0x38d991(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  2640a7:	cmp    $0xffffffff,%eax
  2640aa:	je     264301 <<glass::engine::Watch>::print_utf8+0x1f61>
  2640b0:	mov    0x28(%rsp),%rax
  2640b5:	mov    0x10(%rax),%r15
  2640b9:	cmp    %rbx,%r15
  2640bc:	mov    %rbx,%rax
  2640bf:	cmovb  %r15,%rax
  2640c3:	mov    %rax,0x10(%rsp)
  2640c8:	lea    0x1(%r12),%rcx
  2640cd:	cmp    %rcx,%r15
  2640d0:	cmovb  %r15,%rcx
  2640d4:	mov    0x38da65(%rip),%rax        # 5f1b40 <_DYNAMIC+0x320>
  2640db:	movzbl (%rax),%eax
  2640de:	test   %al,%al
  2640e0:	mov    %rcx,0x30(%rsp)
  2640e5:	je     264113 <<glass::engine::Watch>::print_utf8+0x1d73>
  2640e7:	cmp    %rcx,%rbx
  2640ea:	jae    2640f5 <<glass::engine::Watch>::print_utf8+0x1d55>
  2640ec:	mov    0x38da8d(%rip),%rax        # 5f1b80 <_DYNAMIC+0x360>
  2640f3:	jmp    2640fc <<glass::engine::Watch>::print_utf8+0x1d5c>
  2640f5:	mov    0x38da7c(%rip),%rax        # 5f1b78 <_DYNAMIC+0x358>
  2640fc:	lock incq 0x28(%rax)
  264101:	mov    %rcx,%rdi
  264104:	sub    0x10(%rsp),%rdi
  264109:	call   2f6db0 <alacritty_terminal::grid::row::fill_census::note>
  26410e:	mov    0x30(%rsp),%rcx
  264113:	cmp    %rcx,%rbx
  264116:	jae    2642db <<glass::engine::Watch>::print_utf8+0x1f3b>
  26411c:	mov    0x28(%rsp),%rcx
  264121:	mov    0x28(%rcx),%edi
  264124:	mov    0x20(%rcx),%r8d
  264128:	mov    0x24(%rcx),%r9d
  26412c:	movzwl 0x2c(%rcx),%r10d
  264131:	mov    0x18(%rcx),%r15
  264135:	test   %r15,%r15
  264138:	mov    %edi,0xc(%rsp)
  26413c:	mov    %r8d,0x18(%rsp)
  264141:	mov    %r9d,0x40(%rsp)
  264146:	mov    %r10w,0x38(%rsp)
  26414c:	je     264208 <<glass::engine::Watch>::print_utf8+0x1e68>
  264152:	lock incq (%r15)
  264156:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  26415c:	mov    0x10(%rcx),%rdx
  264160:	mov    %edi,0x60(%rsp)
  264164:	mov    %r8d,0x58(%rsp)
  264169:	mov    %r9d,0x5c(%rsp)
  26416e:	mov    %r10w,0x64(%rsp)
  264174:	mov    %r15,0x50(%rsp)
  264179:	mov    0x30(%rsp),%rsi
  26417e:	cmp    %rdx,%rsi
  264181:	ja     26447a <<glass::engine::Watch>::print_utf8+0x20da>
  264187:	mov    0x10(%rsp),%rax
  26418c:	lea    0x0(,%rax,8),%rax
  264194:	lea    (%rax,%rax,2),%rax
  264198:	mov    0x8(%rcx),%rbx
  26419c:	add    %rax,%rbx
  26419f:	lea    0x0(,%rsi,8),%rcx
  2641a7:	lea    (%rcx,%rcx,2),%r13
  2641ab:	sub    %rax,%r13
  2641ae:	jmp    2641d1 <<glass::engine::Watch>::print_utf8+0x1e31>
  2641b0:	mov    %r15,(%rbx)
  2641b3:	mov    %r8d,0x8(%rbx)
  2641b7:	mov    %r9d,0xc(%rbx)
  2641bb:	mov    %edi,0x10(%rbx)
  2641be:	mov    %r10w,0x14(%rbx)
  2641c3:	add    $0x18,%rbx
  2641c7:	add    $0xffffffffffffffe8,%r13
  2641cb:	je     26429d <<glass::engine::Watch>::print_utf8+0x1efd>
  2641d1:	lock incq (%r15)
  2641d5:	jle    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  2641db:	mov    (%rbx),%rax
  2641de:	test   %rax,%rax
  2641e1:	je     2641b0 <<glass::engine::Watch>::print_utf8+0x1e10>
  2641e3:	lock decq (%rax)
  2641e7:	jne    2641b0 <<glass::engine::Watch>::print_utf8+0x1e10>
  2641e9:	mov    %rbx,%rdi
  2641ec:	call   *0x38d896(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  2641f2:	movzwl 0x38(%rsp),%r10d
  2641f8:	mov    0x40(%rsp),%r9d
  2641fd:	mov    0x18(%rsp),%r8d
  264202:	mov    0xc(%rsp),%edi
  264206:	jmp    2641b0 <<glass::engine::Watch>::print_utf8+0x1e10>
  264208:	mov    %edi,0x60(%rsp)
  26420c:	mov    %r8d,0x58(%rsp)
  264211:	mov    %r9d,0x5c(%rsp)
  264216:	mov    %r10w,0x64(%rsp)
  26421c:	mov    %r15,0x50(%rsp)
  264221:	mov    0x10(%rsp),%rax
  264226:	lea    0x0(,%rax,8),%rax
  26422e:	lea    (%rax,%rax,2),%rax
  264232:	mov    0x8(%rcx),%rbx
  264236:	add    %rax,%rbx
  264239:	mov    0x30(%rsp),%rcx
  26423e:	lea    0x0(,%rcx,8),%rcx
  264246:	lea    (%rcx,%rcx,2),%r13
  26424a:	sub    %rax,%r13
  26424d:	jmp    264270 <<glass::engine::Watch>::print_utf8+0x1ed0>
  26424f:	movq   $0x0,(%rbx)
  264256:	mov    %r8d,0x8(%rbx)
  26425a:	mov    %r9d,0xc(%rbx)
  26425e:	mov    %edi,0x10(%rbx)
  264261:	mov    %r10w,0x14(%rbx)
  264266:	add    $0x18,%rbx
  26426a:	add    $0xffffffffffffffe8,%r13
  26426e:	je     26429d <<glass::engine::Watch>::print_utf8+0x1efd>
  264270:	mov    (%rbx),%rax
  264273:	test   %rax,%rax
  264276:	je     26424f <<glass::engine::Watch>::print_utf8+0x1eaf>
  264278:	lock decq (%rax)
  26427c:	jne    26424f <<glass::engine::Watch>::print_utf8+0x1eaf>
  26427e:	mov    %rbx,%rdi
  264281:	call   *0x38d801(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  264287:	movzwl 0x38(%rsp),%r10d
  26428d:	mov    0x40(%rsp),%r9d
  264292:	mov    0x18(%rsp),%r8d
  264297:	mov    0xc(%rsp),%edi
  26429b:	jmp    26424f <<glass::engine::Watch>::print_utf8+0x1eaf>
  26429d:	mov    0x28(%rsp),%rbx
  2642a2:	mov    0x10(%rsp),%rax
  2642a7:	cmp    %eax,0x38(%rbx)
  2642aa:	jbe    2642af <<glass::engine::Watch>::print_utf8+0x1f0f>
  2642ac:	mov    %eax,0x38(%rbx)
  2642af:	test   %r15,%r15
  2642b2:	mov    0xc0(%rsp),%r13
  2642ba:	mov    0x30(%rsp),%rcx
  2642bf:	je     2642d7 <<glass::engine::Watch>::print_utf8+0x1f37>
  2642c1:	lock decq (%r15)
  2642c5:	jne    2642d7 <<glass::engine::Watch>::print_utf8+0x1f37>
  2642c7:	lea    0x50(%rsp),%rdi
  2642cc:	call   *0x38d7b6(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  2642d2:	mov    0x30(%rsp),%rcx
  2642d7:	mov    0x10(%rbx),%r15
  2642db:	cmp    %r15,%rcx
  2642de:	mov    0xb8(%rsp),%r15
  2642e6:	jb     264301 <<glass::engine::Watch>::print_utf8+0x1f61>
  2642e8:	mov    0x90(%rsp),%rdi
  2642f0:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2642f5:	mov    0x28(%rsp),%rax
  2642fa:	movl   $0xffffffff,0x28(%rax)
  264301:	mov    0x28(%rsp),%rcx
  264306:	mov    0x30(%rcx),%rax
  26430a:	add    $0x2,%r12
  26430e:	cmp    %rax,%r12
  264311:	cmovbe %rax,%r12
  264315:	mov    0x10(%rcx),%rsi
  264319:	mov    %r12,0x30(%rcx)
  26431d:	mov    0x20(%rsp),%rdi
  264322:	cmp    %rsi,%rdi
  264325:	jae    2644eb <<glass::engine::Watch>::print_utf8+0x214b>
  26432b:	mov    0x8(%rcx),%rax
  26432f:	lea    (%rdi,%rdi,2),%rcx
  264333:	lea    (%rax,%rcx,8),%rbx
  264337:	movl   $0x20,0x10(%rax,%rcx,8)
  26433f:	mov    0x48(%rsp),%edx
  264343:	mov    %edx,0x8(%rax,%rcx,8)
  264347:	mov    0x70(%rsp),%edx
  26434b:	mov    %edx,0xc(%rax,%rcx,8)
  26434f:	mov    0x78(%rsp),%edx
  264353:	or     $0x40,%edx
  264356:	mov    %dx,0x14(%rax,%rcx,8)
  26435b:	mov    (%rax,%rcx,8),%rax
  26435f:	test   %rax,%rax
  264362:	je     264373 <<glass::engine::Watch>::print_utf8+0x1fd3>
  264364:	lock decq (%rax)
  264368:	jne    264373 <<glass::engine::Watch>::print_utf8+0x1fd3>
  26436a:	mov    %rbx,%rdi
  26436d:	call   *0x38d715(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  264373:	movq   $0x0,(%rbx)
  26437a:	mov    0xb0(%rsp),%rax
  264382:	cmp    0xa8(%rsp),%rax
  26438a:	jb     264394 <<glass::engine::Watch>::print_utf8+0x1ff4>
  26438c:	dec    %rax
  26438f:	movb   $0x1,0x6c(%r14)
  264394:	mov    %rax,0x40(%r14)
  264398:	incq   0xa0(%r15)
  26439f:	mov    %ebp,0xb0(%r15)
  2643a6:	jmp    263c8b <<glass::engine::Watch>::print_utf8+0x18eb>
  2643ab:	call   18b962 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2643b0:	mov    %ebp,%ebx
  2643b2:	mov    0x390637(%rip),%rsi        # 5f49f0 <glass::engine::width_of::CACHE+0x8>
  2643b9:	cmp    %rbx,%rsi
  2643bc:	ja     263b26 <<glass::engine::Watch>::print_utf8+0x1786>
  2643c2:	lea    0x3671cf(%rip),%rdx        # 5cb598 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d18>
  2643c9:	mov    %rbx,%rdi
  2643cc:	call   *0x38d666(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  2643d2:	lea    0x3643cf(%rip),%rcx        # 5c87a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  2643d9:	mov    0x80(%rsp),%rdi
  2643e1:	call   *0x38d811(%rip)        # 5f1bf8 <_DYNAMIC+0x3d8>
  2643e7:	jmp    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  2643ec:	lea    0x3643b5(%rip),%rcx        # 5c87a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  2643f3:	mov    0x88(%rsp),%rdi
  2643fb:	call   *0x38d7f7(%rip)        # 5f1bf8 <_DYNAMIC+0x3d8>
  264401:	jmp    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  264406:	lea    0x364893(%rip),%rdx        # 5c8ca0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15420>
  26440d:	call   *0x38d625(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  264413:	lea    0x36489e(%rip),%rax        # 5c8cb8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15438>
  26441a:	jmp    26443b <<glass::engine::Watch>::print_utf8+0x209b>
  26441c:	lea    0x3648dd(%rip),%rdx        # 5c8d00 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15480>
  264423:	mov    %rbx,%rdi
  264426:	mov    0x18(%rsp),%rsi
  26442b:	call   *0x38d607(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  264431:	mov    %rax,%rbx
  264434:	lea    0x364895(%rip),%rax        # 5c8cd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15450>
  26443b:	mov    %rax,0xe0(%rsp)
  264443:	mov    %rbx,%rdi
  264446:	mov    0x18(%rsp),%rsi
  26444b:	mov    0xe0(%rsp),%rdx
  264453:	call   *0x38d5df(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  264459:	lea    0x364348(%rip),%rcx        # 5c87a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  264460:	mov    0x10(%rsp),%rdi
  264465:	call   *0x38d78d(%rip)        # 5f1bf8 <_DYNAMIC+0x3d8>
  26446b:	jmp    26448c <<glass::engine::Watch>::print_utf8+0x20ec>
  26446d:	lea    0x3649ac(%rip),%rdx        # 5c8e20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a0>
  264474:	call   *0x38d5be(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  26447a:	lea    0x364327(%rip),%rcx        # 5c87a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  264481:	mov    0x10(%rsp),%rdi
  264486:	call   *0x38d76c(%rip)        # 5f1bf8 <_DYNAMIC+0x3d8>
  26448c:	ud2
  26448e:	lea    0x3529d3(%rip),%rdx        # 5b6e68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264495:	mov    %rbx,%rdi
  264498:	call   *0x38d59a(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  26449e:	lea    0x3529c3(%rip),%rdx        # 5b6e68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  2644a5:	call   *0x38d58d(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  2644ab:	lea    0x364ef6(%rip),%rdx        # 5c93a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  2644b2:	mov    %rbx,%rdi
  2644b5:	call   *0x38d57d(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  2644bb:	lea    0x364ece(%rip),%rdx        # 5c9390 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  2644c2:	mov    %rbx,%rdi
  2644c5:	call   *0x38d56d(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  2644cb:	lea    0x364ebe(%rip),%rdx        # 5c9390 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  2644d2:	mov    %r12,%rdi
  2644d5:	call   *0x38d55d(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  2644db:	lea    0x352986(%rip),%rdx        # 5b6e68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  2644e2:	mov    %r12,%rdi
  2644e5:	call   *0x38d54d(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  2644eb:	lea    0x364e9e(%rip),%rdx        # 5c9390 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  2644f2:	call   *0x38d540(%rip)        # 5f1a38 <_DYNAMIC+0x218>
  2644f8:	mov    %rax,%rbx
  2644fb:	lock decq (%r15)
  2644ff:	je     26451d <<glass::engine::Watch>::print_utf8+0x217d>
  264501:	jmp    26452b <<glass::engine::Watch>::print_utf8+0x218b>
  264503:	mov    %rax,%rbx
  264506:	mov    0x20(%rsp),%rax
  26450b:	jmp    264517 <<glass::engine::Watch>::print_utf8+0x2177>
  26450d:	jmp    26450f <<glass::engine::Watch>::print_utf8+0x216f>
  26450f:	mov    %rax,%rbx
  264512:	mov    0x38(%rsp),%rax
  264517:	lock decq (%rax)
  26451b:	jne    26452b <<glass::engine::Watch>::print_utf8+0x218b>
  26451d:	mov    0x110(%rsp),%rdi
  264525:	call   *0x38d55d(%rip)        # 5f1a88 <_DYNAMIC+0x268>
  26452b:	mov    %rbx,%rdi
  26452e:	call   5b0170 <_Unwind_Resume@plt>
