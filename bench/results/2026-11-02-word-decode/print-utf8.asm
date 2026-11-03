000000000037a400 <<glass::engine::Watch>::print_utf8>:
  37a400:	push   %rbp
  37a401:	push   %r15
  37a403:	push   %r14
  37a405:	push   %r13
  37a407:	push   %r12
  37a409:	push   %rbx
  37a40a:	sub    $0x108,%rsp
  37a411:	mov    %rdx,%r13
  37a414:	mov    %rsi,%r14
  37a417:	mov    %rdi,%r12
  37a41a:	cmpb   $0x1,0xbe(%rdi)
  37a421:	jne    37a450 <<glass::engine::Watch>::print_utf8+0x50>
  37a423:	cmpq   $0x0,0x38(%r12)
  37a429:	jne    37a450 <<glass::engine::Watch>::print_utf8+0x50>
  37a42b:	mov    0x78(%r12),%rax
  37a430:	testb  $0x4,0x6c5(%rax)
  37a437:	jne    37a450 <<glass::engine::Watch>::print_utf8+0x50>
  37a439:	cmpq   $0x0,0x50(%rax)
  37a43e:	jne    37a450 <<glass::engine::Watch>::print_utf8+0x50>
  37a440:	movzwl 0x64(%rax),%ecx
  37a444:	test   $0x460,%ecx
  37a44a:	je     37bcdf <<glass::engine::Watch>::print_utf8+0x18df>
  37a450:	movl   $0x0,0xc(%rsp)
  37a458:	movl   $0x0,0x80(%rsp)
  37a463:	mov    $0xffffffff,%esi
  37a468:	xor    %r15d,%r15d
  37a46b:	lea    0x798236(%rip),%rax        # b126a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x53f0>
  37a472:	mov    %rax,0xc8(%rsp)
  37a47a:	lea    0x40(%rsp),%rax
  37a47f:	mov    %rax,0x100(%rsp)
  37a487:	xor    %edx,%edx
  37a489:	mov    %r13,0xa8(%rsp)
  37a491:	mov    %r12,0x98(%rsp)
  37a499:	mov    %r14,0x70(%rsp)
  37a49e:	cmpb   $0x0,0x80(%rsp)
  37a4a6:	je     37b03f <<glass::engine::Watch>::print_utf8+0xc3f>
  37a4ac:	nopl   0x0(%rax)
  37a4b0:	mov    0x78(%r12),%rbx
  37a4b5:	cmpb   $0x0,0x6c(%rbx)
  37a4b9:	jne    37b03f <<glass::engine::Watch>::print_utf8+0xc3f>
  37a4bf:	mov    %rsi,0x68(%rsp)
  37a4c4:	mov    0x30(%rbx),%eax
  37a4c7:	sub    0x48(%rbx),%eax
  37a4ca:	cltq
  37a4cc:	mov    0x20(%rbx),%rsi
  37a4d0:	mov    0x28(%rbx),%rcx
  37a4d4:	lea    (%rcx,%rax,1),%rdi
  37a4d8:	dec    %rdi
  37a4db:	cmp    %rsi,%rdi
  37a4de:	mov    $0x0,%eax
  37a4e3:	cmovae %rsi,%rax
  37a4e7:	sub    %rax,%rdi
  37a4ea:	cmp    %rsi,%rdi
  37a4ed:	jae    37c544 <<glass::engine::Watch>::print_utf8+0x2144>
  37a4f3:	mov    0xa0(%rbx),%rax
  37a4fa:	mov    %rax,0x38(%rsp)
  37a4ff:	mov    0x40(%rbx),%rcx
  37a503:	mov    0x58(%rbx),%eax
  37a506:	mov    %eax,0x8(%rsp)
  37a50a:	mov    0x5c(%rbx),%eax
  37a50d:	mov    %eax,0x20(%rsp)
  37a511:	movzwl 0x64(%rbx),%eax
  37a515:	mov    %eax,0x58(%rsp)
  37a519:	mov    0x18(%rbx),%rax
  37a51d:	shl    $0x6,%rdi
  37a521:	lea    (%rax,%rdi,1),%r10
  37a525:	mov    %rcx,0x60(%rsp)
  37a52a:	cmp    %ecx,0x38(%rax,%rdi,1)
  37a52e:	jbe    37a539 <<glass::engine::Watch>::print_utf8+0x139>
  37a530:	mov    0x60(%rsp),%rax
  37a535:	mov    %eax,0x38(%r10)
  37a539:	mov    %rdx,0x10(%rsp)
  37a53e:	mov    0x28(%r10),%r8d
  37a542:	cmp    $0xffffffff,%r8d
  37a546:	mov    %r10,0x28(%rsp)
  37a54b:	mov    %rbx,0xb0(%rsp)
  37a553:	je     37a60d <<glass::engine::Watch>::print_utf8+0x20d>
  37a559:	mov    0x30(%r10),%rax
  37a55d:	mov    0x60(%rsp),%rbp
  37a562:	cmp    %rax,%rbp
  37a565:	mov    $0x0,%ecx
  37a56a:	cmovb  %rax,%rcx
  37a56e:	mov    %rcx,0xa0(%rsp)
  37a576:	movl   $0x20,0xf8(%rsp)
  37a581:	mov    0x8(%rsp),%ecx
  37a585:	mov    %ecx,0xf0(%rsp)
  37a58c:	mov    0x20(%rsp),%ecx
  37a590:	mov    %ecx,0xf4(%rsp)
  37a597:	mov    0x58(%rsp),%ecx
  37a59b:	mov    %cx,0xfc(%rsp)
  37a5a3:	movq   $0x0,0xe8(%rsp)
  37a5af:	mov    0x10(%r10),%rcx
  37a5b3:	cmp    %rax,%rcx
  37a5b6:	mov    %rax,%rsi
  37a5b9:	cmovb  %rcx,%rsi
  37a5bd:	mov    %rsi,(%rsp)
  37a5c1:	cmp    %rbp,%rcx
  37a5c4:	cmovb  %rcx,%rbp
  37a5c8:	mov    0x7e1ce1(%rip),%rdx        # b5c2b0 <_DYNAMIC+0x390>
  37a5cf:	movzbl (%rdx),%edx
  37a5d2:	test   %dl,%dl
  37a5d4:	je     37a6ae <<glass::engine::Watch>::print_utf8+0x2ae>
  37a5da:	mov    0x7e1cef(%rip),%rdx        # b5c2d0 <_DYNAMIC+0x3b0>
  37a5e1:	cmp    %rbp,%rax
  37a5e4:	jae    37a5ed <<glass::engine::Watch>::print_utf8+0x1ed>
  37a5e6:	mov    0x7e1ceb(%rip),%rdx        # b5c2d8 <_DYNAMIC+0x3b8>
  37a5ed:	lock incq 0x28(%rdx)
  37a5f2:	mov    0x7e1cbf(%rip),%rdx        # b5c2b8 <_DYNAMIC+0x398>
  37a5f9:	lock incq (%rdx)
  37a5fd:	mov    %rbp,%rdx
  37a600:	sub    (%rsp),%rdx
  37a604:	jne    37a663 <<glass::engine::Watch>::print_utf8+0x263>
  37a606:	xor    %esi,%esi
  37a608:	jmp    37a6a2 <<glass::engine::Watch>::print_utf8+0x2a2>
  37a60d:	movl   $0x20,0xf8(%rsp)
  37a618:	mov    0x8(%rsp),%eax
  37a61c:	mov    %eax,0xf0(%rsp)
  37a623:	mov    0x20(%rsp),%eax
  37a627:	mov    %eax,0xf4(%rsp)
  37a62e:	mov    0x58(%rsp),%eax
  37a632:	mov    %ax,0xfc(%rsp)
  37a63a:	movq   $0x0,0xe8(%rsp)
  37a646:	lea    0x30(%r10),%rax
  37a64a:	mov    %rax,0xc0(%rsp)
  37a652:	movq   $0xffffffffffffffff,0xa0(%rsp)
  37a65e:	jmp    37a80e <<glass::engine::Watch>::print_utf8+0x40e>
  37a663:	mov    0x7e1c56(%rip),%rsi        # b5c2c0 <_DYNAMIC+0x3a0>
  37a66a:	lock add %rdx,(%rsi)
  37a66e:	cmp    $0x5,%rdx
  37a672:	jae    37a682 <<glass::engine::Watch>::print_utf8+0x282>
  37a674:	lea    -0x2dabcb(%rip),%rsi        # 9fab0 <anon.9327c17d0a5e562173c7ee742d8e0b92.574.llvm.1582988309624084939+0x50>
  37a67b:	movzbl -0x1(%rdx,%rsi,1),%esi
  37a680:	jmp    37a6a2 <<glass::engine::Watch>::print_utf8+0x2a2>
  37a682:	lea    -0x5(%rdx),%rdi
  37a686:	mov    $0x4,%esi
  37a68b:	cmp    $0x4,%rdi
  37a68f:	jb     37a6a2 <<glass::engine::Watch>::print_utf8+0x2a2>
  37a691:	add    $0xfffffffffffffff7,%rdx
  37a695:	cmp    $0x8,%rdx
  37a699:	mov    $0x6,%esi
  37a69e:	sbb    $0x0,%rsi
  37a6a2:	mov    0x7e1c1f(%rip),%rdx        # b5c2c8 <_DYNAMIC+0x3a8>
  37a6a9:	lock incq (%rdx,%rsi,8)
  37a6ae:	cmp    %rbp,%rax
  37a6b1:	jae    37a7d1 <<glass::engine::Watch>::print_utf8+0x3d1>
  37a6b7:	mov    %r15,0x18(%rsp)
  37a6bc:	mov    0x20(%r10),%r12d
  37a6c0:	mov    0x24(%r10),%r14d
  37a6c4:	movzwl 0x2c(%r10),%edi
  37a6c9:	mov    0x18(%r10),%r15
  37a6cd:	test   %r15,%r15
  37a6d0:	je     37a6dc <<glass::engine::Watch>::print_utf8+0x2dc>
  37a6d2:	lock incq (%r15)
  37a6d6:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37a6dc:	mov    %r8d,0x50(%rsp)
  37a6e1:	mov    %r12d,0x48(%rsp)
  37a6e6:	mov    %r14d,0x4c(%rsp)
  37a6eb:	mov    %di,0x54(%rsp)
  37a6f0:	mov    %r15,0x40(%rsp)
  37a6f5:	mov    (%rsp),%rax
  37a6f9:	lea    0x0(,%rax,8),%rax
  37a701:	lea    (%rax,%rax,2),%rax
  37a705:	mov    0x8(%r10),%rbx
  37a709:	add    %rax,%rbx
  37a70c:	mov    %rbp,0x78(%rsp)
  37a711:	lea    0x0(,%rbp,8),%rcx
  37a719:	lea    (%rcx,%rcx,2),%rbp
  37a71d:	sub    %rax,%rbp
  37a720:	mov    %di,0x30(%rsp)
  37a725:	jmp    37a74d <<glass::engine::Watch>::print_utf8+0x34d>
  37a727:	nopw   0x0(%rax,%rax,1)
  37a730:	mov    %r15,(%rbx)
  37a733:	mov    %r12d,0x8(%rbx)
  37a737:	mov    %r14d,0xc(%rbx)
  37a73b:	mov    %r8d,0x10(%rbx)
  37a73f:	mov    %di,0x14(%rbx)
  37a743:	add    $0x18,%rbx
  37a747:	add    $0xffffffffffffffe8,%rbp
  37a74b:	je     37a785 <<glass::engine::Watch>::print_utf8+0x385>
  37a74d:	test   %r15,%r15
  37a750:	je     37a75c <<glass::engine::Watch>::print_utf8+0x35c>
  37a752:	lock incq (%r15)
  37a756:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37a75c:	mov    (%rbx),%rax
  37a75f:	test   %rax,%rax
  37a762:	je     37a730 <<glass::engine::Watch>::print_utf8+0x330>
  37a764:	lock decq (%rax)
  37a768:	jne    37a730 <<glass::engine::Watch>::print_utf8+0x330>
  37a76a:	mov    %rbx,%rdi
  37a76d:	mov    %r8d,%r13d
  37a770:	call   *0x7e1a3a(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37a776:	movzwl 0x30(%rsp),%edi
  37a77b:	mov    %r13d,%r8d
  37a77e:	mov    0x28(%rsp),%r10
  37a783:	jmp    37a730 <<glass::engine::Watch>::print_utf8+0x330>
  37a785:	mov    (%rsp),%rax
  37a789:	cmp    %eax,0x38(%r10)
  37a78d:	jbe    37a793 <<glass::engine::Watch>::print_utf8+0x393>
  37a78f:	mov    %eax,0x38(%r10)
  37a793:	test   %r15,%r15
  37a796:	mov    0xa8(%rsp),%r13
  37a79e:	mov    0x98(%rsp),%r12
  37a7a6:	mov    0x70(%rsp),%r14
  37a7ab:	mov    0x78(%rsp),%rbp
  37a7b0:	je     37a7c8 <<glass::engine::Watch>::print_utf8+0x3c8>
  37a7b2:	lock decq (%r15)
  37a7b6:	jne    37a7c8 <<glass::engine::Watch>::print_utf8+0x3c8>
  37a7b8:	lea    0x40(%rsp),%rdi
  37a7bd:	call   *0x7e19ed(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37a7c3:	mov    0x28(%rsp),%r10
  37a7c8:	mov    0x10(%r10),%rcx
  37a7cc:	mov    0x18(%rsp),%r15
  37a7d1:	lea    0x30(%r10),%rax
  37a7d5:	mov    %rax,0xc0(%rsp)
  37a7dd:	cmp    %rcx,%rbp
  37a7e0:	jb     37a80e <<glass::engine::Watch>::print_utf8+0x40e>
  37a7e2:	cmpl   $0xffffffff,0x28(%r10)
  37a7e7:	je     37a806 <<glass::engine::Watch>::print_utf8+0x406>
  37a7e9:	lea    0x18(%r10),%rdi
  37a7ed:	mov    (%rdi),%rax
  37a7f0:	test   %rax,%rax
  37a7f3:	je     37a806 <<glass::engine::Watch>::print_utf8+0x406>
  37a7f5:	lock decq (%rax)
  37a7f9:	jne    37a806 <<glass::engine::Watch>::print_utf8+0x406>
  37a7fb:	call   *0x7e19af(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37a801:	mov    0x28(%rsp),%r10
  37a806:	movl   $0xffffffff,0x28(%r10)
  37a80e:	mov    0x10(%r10),%rdx
  37a812:	mov    0x30(%r10),%rax
  37a816:	mov    0x60(%rsp),%rdi
  37a81b:	cmp    %rdi,%rdx
  37a81e:	mov    %rdi,%rsi
  37a821:	cmovb  %rdx,%rsi
  37a825:	cmp    %rax,%rsi
  37a828:	cmova  %rsi,%rax
  37a82c:	mov    %rdx,%rcx
  37a82f:	mov    %rax,0x30(%r10)
  37a833:	sub    %rdi,%rcx
  37a836:	mov    %rcx,0x30(%rsp)
  37a83b:	jb     37befb <<glass::engine::Watch>::print_utf8+0x1afb>
  37a841:	mov    0x10(%rsp),%rdx
  37a846:	cmp    %r13,%rdx
  37a849:	jae    37aed0 <<glass::engine::Watch>::print_utf8+0xad0>
  37a84f:	mov    %r15,0x18(%rsp)
  37a854:	mov    0x8(%r10),%r15
  37a858:	mov    0x60(%rsp),%r8
  37a85d:	lea    (%r8,%r8,2),%rax
  37a861:	lea    (%r15,%rax,8),%rax
  37a865:	mov    %rax,0x88(%rsp)
  37a86d:	mov    0x58(%rsp),%eax
  37a871:	mov    %eax,%ecx
  37a873:	or     $0x20,%ecx
  37a876:	mov    %ecx,0xb8(%rsp)
  37a87d:	or     $0x40,%eax
  37a880:	mov    %eax,0xe4(%rsp)
  37a887:	mov    $0x1,%al
  37a889:	mov    %eax,0x90(%rsp)
  37a890:	xor    %ebx,%ebx
  37a892:	xor    %r11d,%r11d
  37a895:	mov    %r8,(%rsp)
  37a899:	mov    0x68(%rsp),%rsi
  37a89e:	mov    %r15,0x78(%rsp)
  37a8a3:	jmp    37a911 <<glass::engine::Watch>::print_utf8+0x511>
  37a8a5:	data16 cs nopw 0x0(%rax,%rax,1)
  37a8b0:	movq   $0x0,(%rbx)
  37a8b7:	mov    0x8(%rsp),%eax
  37a8bb:	mov    %eax,0x8(%rbx)
  37a8be:	mov    0x20(%rsp),%eax
  37a8c2:	mov    %eax,0xc(%rbx)
  37a8c5:	movl   $0x20,0x10(%rbx)
  37a8cc:	mov    0xe4(%rsp),%eax
  37a8d3:	mov    %ax,0x14(%rbx)
  37a8d7:	movl   $0x0,0x90(%rsp)
  37a8e2:	xor    %ebx,%ebx
  37a8e4:	cmp    0x38(%rsp),%rbp
  37a8e9:	setae  %bl
  37a8ec:	mov    %rbp,%r8
  37a8ef:	sub    %rbx,%r8
  37a8f2:	inc    %r11
  37a8f5:	mov    %rbp,(%rsp)
  37a8f9:	mov    0x70(%rsp),%r14
  37a8fe:	add    %r9,%rdx
  37a901:	mov    %edi,%esi
  37a903:	mov    %r9,0x18(%rsp)
  37a908:	cmp    %r13,%rdx
  37a90b:	jae    37aef0 <<glass::engine::Watch>::print_utf8+0xaf0>
  37a911:	mov    %rdx,%r9
  37a914:	movzbl (%r14,%rdx,1),%edi
  37a919:	test   %dil,%dil
  37a91c:	js     37a940 <<glass::engine::Watch>::print_utf8+0x540>
  37a91e:	mov    $0x1,%edx
  37a923:	lea    -0x7f(%rdi),%eax
  37a926:	cmp    $0x21,%eax
  37a929:	jae    37aaae <<glass::engine::Watch>::print_utf8+0x6ae>
  37a92f:	jmp    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a934:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  37a940:	lea    0x3e(%rdi),%eax
  37a943:	cmp    $0x1e,%al
  37a945:	jae    37a971 <<glass::engine::Watch>::print_utf8+0x571>
  37a947:	lea    0x1(%r9),%rax
  37a94b:	cmp    %r13,%rax
  37a94e:	jae    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a954:	movzbl (%r14,%rax,1),%eax
  37a959:	cmp    $0xc0,%al
  37a95b:	jge    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a961:	and    $0x1f,%edi
  37a964:	shl    $0x6,%edi
  37a967:	mov    $0x2,%edx
  37a96c:	jmp    37aa81 <<glass::engine::Watch>::print_utf8+0x681>
  37a971:	mov    %edi,%eax
  37a973:	and    $0xf0,%al
  37a975:	cmp    $0xe0,%al
  37a977:	jne    37a991 <<glass::engine::Watch>::print_utf8+0x591>
  37a979:	mov    $0xbf,%al
  37a97b:	cmp    $0xe0,%edi
  37a981:	je     37a9b4 <<glass::engine::Watch>::print_utf8+0x5b4>
  37a983:	mov    $0x80,%cl
  37a985:	cmp    $0xed,%edi
  37a98b:	jne    37a9b6 <<glass::engine::Watch>::print_utf8+0x5b6>
  37a98d:	mov    $0x9f,%al
  37a98f:	jmp    37a9b6 <<glass::engine::Watch>::print_utf8+0x5b6>
  37a991:	lea    0x10(%rdi),%eax
  37a994:	cmp    $0x5,%al
  37a996:	jae    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a99c:	mov    $0x80,%al
  37a99e:	cmp    $0xf4,%edi
  37a9a4:	je     37aa0a <<glass::engine::Watch>::print_utf8+0x60a>
  37a9a6:	mov    $0xbf,%cl
  37a9a8:	cmp    $0xf0,%edi
  37a9ae:	jne    37aa0c <<glass::engine::Watch>::print_utf8+0x60c>
  37a9b0:	mov    $0x90,%al
  37a9b2:	jmp    37aa0c <<glass::engine::Watch>::print_utf8+0x60c>
  37a9b4:	mov    $0xa0,%cl
  37a9b6:	lea    0x1(%r9),%rdx
  37a9ba:	cmp    %r13,%rdx
  37a9bd:	jae    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a9c3:	movzbl (%r14,%rdx,1),%edx
  37a9c8:	cmp    %dl,%cl
  37a9ca:	ja     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a9d0:	cmp    %al,%dl
  37a9d2:	ja     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a9d8:	lea    0x2(%r9),%rax
  37a9dc:	cmp    %r13,%rax
  37a9df:	jae    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a9e5:	movzbl (%r14,%rax,1),%eax
  37a9ea:	cmp    $0xc0,%al
  37a9ec:	jge    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37a9f2:	movzbl %dl,%ecx
  37a9f5:	and    $0x3f,%ecx
  37a9f8:	shl    $0x6,%ecx
  37a9fb:	and    $0xf,%edi
  37a9fe:	shl    $0xc,%edi
  37aa01:	or     %ecx,%edi
  37aa03:	mov    $0x3,%edx
  37aa08:	jmp    37aa81 <<glass::engine::Watch>::print_utf8+0x681>
  37aa0a:	mov    $0x8f,%cl
  37aa0c:	lea    0x1(%r9),%rdx
  37aa10:	cmp    %r13,%rdx
  37aa13:	jae    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aa19:	movzbl (%r14,%rdx,1),%edx
  37aa1e:	cmp    %dl,%al
  37aa20:	ja     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aa26:	cmp    %cl,%dl
  37aa28:	ja     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aa2e:	lea    0x2(%r9),%rax
  37aa32:	cmp    %r13,%rax
  37aa35:	jae    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aa3b:	movzbl (%r14,%rax,1),%ecx
  37aa40:	cmp    $0xbf,%cl
  37aa43:	jg     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aa49:	lea    0x3(%r9),%rax
  37aa4d:	cmp    %r13,%rax
  37aa50:	jae    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aa56:	movzbl (%r14,%rax,1),%eax
  37aa5b:	cmp    $0xbf,%al
  37aa5d:	jg     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aa63:	movzbl %dl,%edx
  37aa66:	and    $0x3f,%ecx
  37aa69:	shl    $0x6,%ecx
  37aa6c:	and    $0x3f,%edx
  37aa6f:	shl    $0xc,%edx
  37aa72:	and    $0x7,%edi
  37aa75:	shl    $0x12,%edi
  37aa78:	or     %edx,%edi
  37aa7a:	or     %ecx,%edi
  37aa7c:	mov    $0x4,%edx
  37aa81:	mov    %edi,%ecx
  37aa83:	xor    $0xd800,%ecx
  37aa89:	add    $0xffef0000,%ecx
  37aa8f:	cmp    $0xffef0800,%ecx
  37aa95:	jb     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aa9b:	and    $0x3f,%al
  37aa9d:	movzbl %al,%eax
  37aaa0:	or     %eax,%edi
  37aaa2:	lea    -0x7f(%rdi),%eax
  37aaa5:	cmp    $0x21,%eax
  37aaa8:	jb     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aaae:	cmp    $0xffffffff,%esi
  37aab1:	je     37aad0 <<glass::engine::Watch>::print_utf8+0x6d0>
  37aab3:	lea    -0x20(%rsi),%eax
  37aab6:	cmp    $0x5f,%eax
  37aab9:	jae    37aae0 <<glass::engine::Watch>::print_utf8+0x6e0>
  37aabb:	mov    $0x1,%eax
  37aac0:	cmpb   $0x0,0xc(%rsp)
  37aac5:	jne    37acad <<glass::engine::Watch>::print_utf8+0x8ad>
  37aacb:	jmp    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aad0:	mov    (%rsp),%rbp
  37aad4:	jmp    37a8fe <<glass::engine::Watch>::print_utf8+0x4fe>
  37aad9:	nopl   0x0(%rax)
  37aae0:	mov    %rdi,%r15
  37aae3:	mov    %r9,0x10(%rsp)
  37aae8:	mov    %r12,%r13
  37aaeb:	mov    %r8,%r12
  37aaee:	mov    0x7e7a8c(%rip),%eax        # b62580 <glass::engine::width_of::CACHE+0x10>
  37aaf4:	test   %eax,%eax
  37aaf6:	jne    37ae96 <<glass::engine::Watch>::print_utf8+0xa96>
  37aafc:	mov    %rsi,%r8
  37aaff:	mov    %esi,%edi
  37ab01:	mov    0x7e7a70(%rip),%rsi        # b62578 <glass::engine::width_of::CACHE+0x8>
  37ab08:	cmp    %rdi,%rsi
  37ab0b:	jbe    37bbdd <<glass::engine::Watch>::print_utf8+0x17dd>
  37ab11:	mov    %rdx,%r9
  37ab14:	mov    0x7e7a55(%rip),%rdx        # b62570 <glass::engine::width_of::CACHE>
  37ab1b:	movzbl (%rdx,%rdi,1),%eax
  37ab1f:	movzbl %al,%eax
  37ab22:	test   %al,%al
  37ab24:	js     37ab38 <<glass::engine::Watch>::print_utf8+0x738>
  37ab26:	mov    $0x1,%cl
  37ab28:	test   %cl,%cl
  37ab2a:	mov    %r8,%rsi
  37ab2d:	jne    37ac81 <<glass::engine::Watch>::print_utf8+0x881>
  37ab33:	jmp    37af6e <<glass::engine::Watch>::print_utf8+0xb6e>
  37ab38:	cmp    $0xfe,%eax
  37ab3d:	je     37af9b <<glass::engine::Watch>::print_utf8+0xb9b>
  37ab43:	mov    $0xfe,%sil
  37ab46:	mov    %r8,%rax
  37ab49:	cmp    $0x7f,%eax
  37ab4c:	jae    37ab5a <<glass::engine::Watch>::print_utf8+0x75a>
  37ab4e:	mov    $0x1,%eax
  37ab53:	xor    %ecx,%ecx
  37ab55:	jmp    37ac72 <<glass::engine::Watch>::print_utf8+0x872>
  37ab5a:	cmp    $0xa0,%eax
  37ab5f:	jb     37abf6 <<glass::engine::Watch>::print_utf8+0x7f6>
  37ab65:	mov    %edi,%eax
  37ab67:	shr    $0xd,%eax
  37ab6a:	mov    0x7e1ad7(%rip),%rcx        # b5c648 <_DYNAMIC+0x728>
  37ab71:	movzbl (%rcx,%rax,1),%eax
  37ab75:	mov    %edi,%ecx
  37ab77:	shr    $0x7,%ecx
  37ab7a:	and    $0x3f,%ecx
  37ab7d:	shl    $0x6,%eax
  37ab80:	add    0x7e1ac9(%rip),%rax        # b5c650 <_DYNAMIC+0x730>
  37ab87:	movzbl (%rcx,%rax,1),%eax
  37ab8b:	cmp    $0xba,%rax
  37ab91:	jae    37c5d8 <<glass::engine::Watch>::print_utf8+0x21d8>
  37ab97:	mov    %edi,%ecx
  37ab99:	shr    $0x2,%ecx
  37ab9c:	and    $0x1f,%ecx
  37ab9f:	shl    $0x5,%eax
  37aba2:	add    0x7e1aaf(%rip),%rax        # b5c658 <_DYNAMIC+0x738>
  37aba9:	movzbl (%rcx,%rax,1),%esi
  37abad:	lea    (%r8,%r8,1),%ecx
  37abb1:	and    $0x6,%cl
  37abb4:	shr    %cl,%sil
  37abb7:	and    $0x3,%sil
  37abbb:	cmp    $0x3,%sil
  37abbf:	jne    37ac6c <<glass::engine::Watch>::print_utf8+0x86c>
  37abc5:	mov    %r8,%rsi
  37abc8:	cmp    $0xfe00,%esi
  37abce:	jg     37abfa <<glass::engine::Watch>::print_utf8+0x7fa>
  37abd0:	cmp    $0x5dc,%esi
  37abd6:	je     37ac18 <<glass::engine::Watch>::print_utf8+0x818>
  37abd8:	mov    %rsi,%rax
  37abdb:	mov    $0x3,%sil
  37abde:	cmp    $0x17d8,%eax
  37abe3:	je     37ac6c <<glass::engine::Watch>::print_utf8+0x86c>
  37abe9:	mov    %r8,%rsi
  37abec:	cmp    $0x1a10,%esi
  37abf2:	je     37ac18 <<glass::engine::Watch>::print_utf8+0x818>
  37abf4:	jmp    37ac2b <<glass::engine::Watch>::print_utf8+0x82b>
  37abf6:	xor    %ecx,%ecx
  37abf8:	jmp    37ac72 <<glass::engine::Watch>::print_utf8+0x872>
  37abfa:	lea    -0xfe01(%rsi),%eax
  37ac00:	cmp    $0xe,%eax
  37ac03:	jbe    37ac1d <<glass::engine::Watch>::print_utf8+0x81d>
  37ac05:	lea    -0x16d67(%rsi),%eax
  37ac0b:	cmp    $0x2,%eax
  37ac0e:	jb     37ac18 <<glass::engine::Watch>::print_utf8+0x818>
  37ac10:	cmp    $0x10c03,%esi
  37ac16:	jne    37ac2b <<glass::engine::Watch>::print_utf8+0x82b>
  37ac18:	mov    $0x1,%sil
  37ac1b:	jmp    37ac6c <<glass::engine::Watch>::print_utf8+0x86c>
  37ac1d:	mov    $0x6001,%ecx
  37ac22:	bt     %eax,%ecx
  37ac25:	jae    37ac05 <<glass::engine::Watch>::print_utf8+0x805>
  37ac27:	xor    %esi,%esi
  37ac29:	jmp    37ac6c <<glass::engine::Watch>::print_utf8+0x86c>
  37ac2b:	movd   %esi,%xmm0
  37ac2f:	pshufd $0x0,%xmm0,%xmm0
  37ac34:	paddd  -0x2ddbcc(%rip),%xmm0        # 9d070 <anon.fbeeda9ffa0bdf528271fe5937be7c0a.453.llvm.4924780659780008694+0x120>
  37ac3c:	mov    %esi,%eax
  37ac3e:	and    $0x1ffffe,%eax
  37ac43:	cmp    $0xa4fc,%eax
  37ac48:	sete   %al
  37ac4b:	pxor   -0x2dd083(%rip),%xmm0        # 9dbd0 <anon.e6b80e3fbb0340b0148aeb4aba9d7171.1298.llvm.10283561813775316742+0x3c0>
  37ac53:	pcmpgtd -0x2dc94b(%rip),%xmm0        # 9e310 <image::codecs::bmp::decoder::LOOKUP_TABLE_4_BIT_TO_8_BIT+0x230>
  37ac5b:	movmskps %xmm0,%ecx
  37ac5e:	cmp    $0xf,%ecx
  37ac61:	setne  %cl
  37ac64:	or     %al,%cl
  37ac66:	mov    $0x2,%sil
  37ac69:	sub    %cl,%sil
  37ac6c:	movzbl %sil,%eax
  37ac70:	mov    $0x1,%cl
  37ac72:	mov    %sil,(%rdx,%rdi,1)
  37ac76:	test   %cl,%cl
  37ac78:	mov    %r8,%rsi
  37ac7b:	je     37af6e <<glass::engine::Watch>::print_utf8+0xb6e>
  37ac81:	mov    %r9,%rdx
  37ac84:	mov    %r15,%rdi
  37ac87:	lea    -0x1(%rax),%rcx
  37ac8b:	cmp    $0x1,%rcx
  37ac8f:	mov    %r12,%r8
  37ac92:	mov    %r13,%r12
  37ac95:	mov    0xa8(%rsp),%r13
  37ac9d:	mov    0x10(%rsp),%r9
  37aca2:	mov    0x78(%rsp),%r15
  37aca7:	ja     37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37acad:	test   $0x1,%bl
  37acb0:	jne    37aee1 <<glass::engine::Watch>::print_utf8+0xae1>
  37acb6:	lea    (%rax,%r8,1),%rbp
  37acba:	cmp    0x38(%rsp),%rbp
  37acbf:	ja     37aee5 <<glass::engine::Watch>::print_utf8+0xae5>
  37acc5:	mov    %r8,%r14
  37acc8:	sub    0x60(%rsp),%r14
  37accd:	cmp    0xa0(%rsp),%r8
  37acd5:	jae    37ad40 <<glass::engine::Watch>::print_utf8+0x940>
  37acd7:	cmp    0x30(%rsp),%r14
  37acdc:	jae    37c551 <<glass::engine::Watch>::print_utf8+0x2151>
  37ace2:	lea    (%r8,%r8,2),%rcx
  37ace6:	testb  $0x60,0x14(%r15,%rcx,8)
  37acec:	jne    37af5c <<glass::engine::Watch>::print_utf8+0xb5c>
  37acf2:	lea    (%r15,%rcx,8),%rbx
  37acf6:	cmp    $0x2,%rax
  37acfa:	jne    37adce <<glass::engine::Watch>::print_utf8+0x9ce>
  37ad00:	lea    0x1(%r14),%rax
  37ad04:	cmp    0x30(%rsp),%rax
  37ad09:	jae    37c56f <<glass::engine::Watch>::print_utf8+0x216f>
  37ad0f:	lea    (%rax,%rax,2),%rax
  37ad13:	mov    $0x1,%r12b
  37ad16:	mov    0x88(%rsp),%rcx
  37ad1e:	testb  $0x60,0x14(%rcx,%rax,8)
  37ad23:	mov    0xb8(%rsp),%r13d
  37ad2b:	je     37ad69 <<glass::engine::Watch>::print_utf8+0x969>
  37ad2d:	jmp    37af76 <<glass::engine::Watch>::print_utf8+0xb76>
  37ad32:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  37ad40:	cmp    0x30(%rsp),%r14
  37ad45:	jae    37c581 <<glass::engine::Watch>::print_utf8+0x2181>
  37ad4b:	lea    (%r8,%r8,2),%rcx
  37ad4f:	lea    (%r15,%rcx,8),%rbx
  37ad53:	cmp    $0x2,%rax
  37ad57:	sete   %r12b
  37ad5b:	mov    0x58(%rsp),%r13d
  37ad60:	cmove  0xb8(%rsp),%r13d
  37ad69:	mov    (%rbx),%rax
  37ad6c:	test   %rax,%rax
  37ad6f:	je     37ade0 <<glass::engine::Watch>::print_utf8+0x9e0>
  37ad71:	lock decq (%rax)
  37ad75:	jne    37ade0 <<glass::engine::Watch>::print_utf8+0x9e0>
  37ad77:	mov    %rdi,(%rsp)
  37ad7b:	mov    %rbx,%rdi
  37ad7e:	mov    %rsi,0x68(%rsp)
  37ad83:	mov    %rdx,%r15
  37ad86:	mov    %r11,0xd8(%rsp)
  37ad8e:	mov    %r8,0xd0(%rsp)
  37ad96:	mov    %r9,0x10(%rsp)
  37ad9b:	call   *0x7e140f(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37ada1:	mov    (%rsp),%rdi
  37ada5:	mov    0x10(%rsp),%r9
  37adaa:	mov    0xd0(%rsp),%r8
  37adb2:	mov    0xd8(%rsp),%r11
  37adba:	mov    0x28(%rsp),%r10
  37adbf:	mov    %r15,%rdx
  37adc2:	mov    0x78(%rsp),%r15
  37adc7:	mov    0x68(%rsp),%rsi
  37adcc:	jmp    37ade0 <<glass::engine::Watch>::print_utf8+0x9e0>
  37adce:	xor    %r12d,%r12d
  37add1:	mov    0x58(%rsp),%r13d
  37add6:	mov    (%rbx),%rax
  37add9:	test   %rax,%rax
  37addc:	jne    37ad71 <<glass::engine::Watch>::print_utf8+0x971>
  37adde:	xchg   %ax,%ax
  37ade0:	lea    (%r8,%r8,2),%rax
  37ade4:	movq   $0x0,(%rbx)
  37adeb:	mov    0x8(%rsp),%ecx
  37adef:	mov    %ecx,0x8(%r15,%rax,8)
  37adf4:	mov    0x20(%rsp),%ecx
  37adf8:	mov    %ecx,0xc(%r15,%rax,8)
  37adfd:	mov    %r13w,0x14(%r15,%rax,8)
  37ae03:	mov    %esi,0x10(%r15,%rax,8)
  37ae08:	test   %r12b,%r12b
  37ae0b:	mov    0xa8(%rsp),%r13
  37ae13:	mov    0x98(%rsp),%r12
  37ae1b:	je     37a8e2 <<glass::engine::Watch>::print_utf8+0x4e2>
  37ae21:	inc    %r14
  37ae24:	cmp    0x30(%rsp),%r14
  37ae29:	jae    37c55a <<glass::engine::Watch>::print_utf8+0x215a>
  37ae2f:	lea    (%r14,%r14,2),%rax
  37ae33:	mov    0x88(%rsp),%rcx
  37ae3b:	lea    (%rcx,%rax,8),%rbx
  37ae3f:	mov    (%rcx,%rax,8),%rax
  37ae43:	test   %rax,%rax
  37ae46:	je     37a8b0 <<glass::engine::Watch>::print_utf8+0x4b0>
  37ae4c:	lock decq (%rax)
  37ae50:	jne    37a8b0 <<glass::engine::Watch>::print_utf8+0x4b0>
  37ae56:	mov    %rdi,(%rsp)
  37ae5a:	mov    %rbx,%rdi
  37ae5d:	mov    %rdx,%r14
  37ae60:	mov    %r11,%r15
  37ae63:	mov    %r12,%r13
  37ae66:	mov    %r9,%r12
  37ae69:	call   *0x7e1341(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37ae6f:	mov    (%rsp),%rdi
  37ae73:	mov    %r12,%r9
  37ae76:	mov    %r13,%r12
  37ae79:	mov    0xa8(%rsp),%r13
  37ae81:	mov    %r15,%r11
  37ae84:	mov    0x78(%rsp),%r15
  37ae89:	mov    0x28(%rsp),%r10
  37ae8e:	mov    %r14,%rdx
  37ae91:	jmp    37a8b0 <<glass::engine::Watch>::print_utf8+0x4b0>
  37ae96:	mov    %rsi,0x68(%rsp)
  37ae9b:	mov    %rdx,%rbp
  37ae9e:	mov    %r11,0xd8(%rsp)
  37aea6:	call   287a12 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  37aeab:	mov    0xd8(%rsp),%r11
  37aeb3:	mov    0x28(%rsp),%r10
  37aeb8:	mov    %rbp,%rdx
  37aebb:	mov    0x68(%rsp),%rsi
  37aec0:	jmp    37aafc <<glass::engine::Watch>::print_utf8+0x6fc>
  37aec5:	data16 cs nopw 0x0(%rax,%rax,1)
  37aed0:	xor    %r11d,%r11d
  37aed3:	xor    %ebx,%ebx
  37aed5:	mov    0x60(%rsp),%rcx
  37aeda:	mov    0x68(%rsp),%rbp
  37aedf:	jmp    37af31 <<glass::engine::Watch>::print_utf8+0xb31>
  37aee1:	mov    $0x1,%bl
  37aee3:	jmp    37aee7 <<glass::engine::Watch>::print_utf8+0xae7>
  37aee5:	xor    %ebx,%ebx
  37aee7:	mov    (%rsp),%rbp
  37aeeb:	mov    %esi,%edi
  37aeed:	mov    %r9,%rdx
  37aef0:	cmp    0x60(%rsp),%rbp
  37aef5:	jbe    37af0c <<glass::engine::Watch>::print_utf8+0xb0c>
  37aef7:	mov    0xc0(%rsp),%rcx
  37aeff:	mov    (%rcx),%rax
  37af02:	cmp    %rax,%rbp
  37af05:	cmova  %rbp,%rax
  37af09:	mov    %rax,(%rcx)
  37af0c:	cmp    $0x8,%r11
  37af10:	setae  %al
  37af13:	testb  $0x1,0x90(%rsp)
  37af1b:	jne    37af1f <<glass::engine::Watch>::print_utf8+0xb1f>
  37af1d:	xor    %eax,%eax
  37af1f:	test   %al,%al
  37af21:	mov    0x18(%rsp),%r15
  37af26:	jne    37afba <<glass::engine::Watch>::print_utf8+0xbba>
  37af2c:	mov    %r8,%rcx
  37af2f:	mov    %edi,%ebp
  37af31:	mov    0xb0(%rsp),%rax
  37af39:	mov    %rcx,0x40(%rax)
  37af3d:	mov    %bl,0x6c(%rax)
  37af40:	add    %r11,0xa0(%r12)
  37af48:	mov    %r15,%rbx
  37af4b:	mov    %rdx,%r15
  37af4e:	cmp    %r13,%rdx
  37af51:	jb     37b050 <<glass::engine::Watch>::print_utf8+0xc50>
  37af57:	jmp    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37af5c:	xor    %ebx,%ebx
  37af5e:	mov    (%rsp),%rbp
  37af62:	mov    %esi,%edi
  37af64:	mov    %r9,%rdx
  37af67:	mov    0x70(%rsp),%r14
  37af6c:	jmp    37aef0 <<glass::engine::Watch>::print_utf8+0xaf0>
  37af6e:	mov    (%rsp),%rbp
  37af72:	mov    %esi,%edi
  37af74:	jmp    37afa2 <<glass::engine::Watch>::print_utf8+0xba2>
  37af76:	xor    %ebx,%ebx
  37af78:	mov    (%rsp),%rbp
  37af7c:	mov    %esi,%edi
  37af7e:	mov    %r9,%rdx
  37af81:	mov    0xa8(%rsp),%r13
  37af89:	mov    0x98(%rsp),%r12
  37af91:	mov    0x70(%rsp),%r14
  37af96:	jmp    37aef0 <<glass::engine::Watch>::print_utf8+0xaf0>
  37af9b:	mov    (%rsp),%rbp
  37af9f:	mov    %r8d,%edi
  37afa2:	mov    0x10(%rsp),%rdx
  37afa7:	mov    %r12,%r8
  37afaa:	mov    %r13,%r12
  37afad:	mov    0xa8(%rsp),%r13
  37afb5:	jmp    37aef0 <<glass::engine::Watch>::print_utf8+0xaf0>
  37afba:	mov    %rdx,0x10(%rsp)
  37afbf:	movzbl %bl,%edx
  37afc2:	add    %r8,%rdx
  37afc5:	mov    %rdi,(%rsp)
  37afc9:	mov    %r10,%rdi
  37afcc:	mov    0x60(%rsp),%rsi
  37afd1:	lea    0xe8(%rsp),%rcx
  37afd9:	mov    %r11,%rbp
  37afdc:	mov    %r8,0xd0(%rsp)
  37afe4:	call   3ce6a0 <glass::engine::note_uniform_span>
  37afe9:	mov    %rbp,%r11
  37afec:	mov    0x10(%rsp),%rdx
  37aff1:	mov    0xd0(%rsp),%rcx
  37aff9:	mov    (%rsp),%rbp
  37affd:	jmp    37af31 <<glass::engine::Watch>::print_utf8+0xb31>
  37b002:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  37b010:	mov    %r12,%rdi
  37b013:	mov    %ebp,%esi
  37b015:	call   426180 <<glass::engine::Watch as vte::ansi::Handler>::input>
  37b01a:	mov    0x70(%rsp),%r14
  37b01f:	mov    0x18(%rsp),%r15
  37b024:	mov    0x68(%rsp),%rsi
  37b029:	mov    0x10(%rsp),%rdx
  37b02e:	add    %r15,%rdx
  37b031:	cmpb   $0x0,0x80(%rsp)
  37b039:	jne    37a4b0 <<glass::engine::Watch>::print_utf8+0xb0>
  37b03f:	mov    %esi,%ebp
  37b041:	mov    %r15,%rbx
  37b044:	mov    %rdx,%r15
  37b047:	cmp    %r13,%rdx
  37b04a:	jae    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b050:	movzbl (%r14,%r15,1),%esi
  37b055:	test   %sil,%sil
  37b058:	js     37b070 <<glass::engine::Watch>::print_utf8+0xc70>
  37b05a:	mov    $0x1,%edx
  37b05f:	lea    -0x7f(%rsi),%eax
  37b062:	cmp    $0x21,%eax
  37b065:	jae    37b1ed <<glass::engine::Watch>::print_utf8+0xded>
  37b06b:	jmp    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b070:	lea    0x3e(%rsi),%eax
  37b073:	cmp    $0x1e,%al
  37b075:	jae    37b0b0 <<glass::engine::Watch>::print_utf8+0xcb0>
  37b077:	lea    0x1(%r15),%rax
  37b07b:	cmp    %r13,%rax
  37b07e:	jae    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b084:	movzbl (%r14,%rax,1),%eax
  37b089:	cmp    $0xc0,%al
  37b08b:	jge    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b091:	and    $0x1f,%esi
  37b094:	shl    $0x6,%esi
  37b097:	mov    $0x2,%edx
  37b09c:	jmp    37b1c0 <<glass::engine::Watch>::print_utf8+0xdc0>
  37b0a1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  37b0b0:	mov    %esi,%eax
  37b0b2:	and    $0xf0,%al
  37b0b4:	cmp    $0xe0,%al
  37b0b6:	jne    37b0d0 <<glass::engine::Watch>::print_utf8+0xcd0>
  37b0b8:	mov    $0xbf,%al
  37b0ba:	cmp    $0xe0,%esi
  37b0c0:	je     37b0f3 <<glass::engine::Watch>::print_utf8+0xcf3>
  37b0c2:	mov    $0x80,%cl
  37b0c4:	cmp    $0xed,%esi
  37b0ca:	jne    37b0f5 <<glass::engine::Watch>::print_utf8+0xcf5>
  37b0cc:	mov    $0x9f,%al
  37b0ce:	jmp    37b0f5 <<glass::engine::Watch>::print_utf8+0xcf5>
  37b0d0:	lea    0x10(%rsi),%eax
  37b0d3:	cmp    $0x5,%al
  37b0d5:	jae    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b0db:	mov    $0x80,%al
  37b0dd:	cmp    $0xf4,%esi
  37b0e3:	je     37b149 <<glass::engine::Watch>::print_utf8+0xd49>
  37b0e5:	mov    $0xbf,%cl
  37b0e7:	cmp    $0xf0,%esi
  37b0ed:	jne    37b14b <<glass::engine::Watch>::print_utf8+0xd4b>
  37b0ef:	mov    $0x90,%al
  37b0f1:	jmp    37b14b <<glass::engine::Watch>::print_utf8+0xd4b>
  37b0f3:	mov    $0xa0,%cl
  37b0f5:	lea    0x1(%r15),%rdx
  37b0f9:	cmp    %r13,%rdx
  37b0fc:	jae    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b102:	movzbl (%r14,%rdx,1),%edx
  37b107:	cmp    %dl,%cl
  37b109:	ja     37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b10f:	cmp    %al,%dl
  37b111:	ja     37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b117:	lea    0x2(%r15),%rax
  37b11b:	cmp    %r13,%rax
  37b11e:	jae    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b124:	movzbl (%r14,%rax,1),%eax
  37b129:	cmp    $0xc0,%al
  37b12b:	jge    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b131:	movzbl %dl,%ecx
  37b134:	and    $0x3f,%ecx
  37b137:	shl    $0x6,%ecx
  37b13a:	and    $0xf,%esi
  37b13d:	shl    $0xc,%esi
  37b140:	or     %ecx,%esi
  37b142:	mov    $0x3,%edx
  37b147:	jmp    37b1c0 <<glass::engine::Watch>::print_utf8+0xdc0>
  37b149:	mov    $0x8f,%cl
  37b14b:	lea    0x1(%r15),%rdx
  37b14f:	cmp    %r13,%rdx
  37b152:	jae    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b158:	movzbl (%r14,%rdx,1),%edx
  37b15d:	cmp    %dl,%al
  37b15f:	ja     37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b165:	cmp    %cl,%dl
  37b167:	ja     37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b16d:	lea    0x2(%r15),%rax
  37b171:	cmp    %r13,%rax
  37b174:	jae    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b17a:	movzbl (%r14,%rax,1),%ecx
  37b17f:	cmp    $0xbf,%cl
  37b182:	jg     37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b188:	lea    0x3(%r15),%rax
  37b18c:	cmp    %r13,%rax
  37b18f:	jae    37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b195:	movzbl (%r14,%rax,1),%eax
  37b19a:	cmp    $0xbf,%al
  37b19c:	jg     37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b1a2:	movzbl %dl,%edx
  37b1a5:	and    $0x3f,%ecx
  37b1a8:	shl    $0x6,%ecx
  37b1ab:	and    $0x3f,%edx
  37b1ae:	shl    $0xc,%edx
  37b1b1:	and    $0x7,%esi
  37b1b4:	shl    $0x12,%esi
  37b1b7:	or     %edx,%esi
  37b1b9:	or     %ecx,%esi
  37b1bb:	mov    $0x4,%edx
  37b1c0:	mov    %esi,%ecx
  37b1c2:	xor    $0xd800,%ecx
  37b1c8:	add    $0xffef0000,%ecx
  37b1ce:	cmp    $0xffef0800,%ecx
  37b1d4:	jb     37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b1da:	and    $0x3f,%al
  37b1dc:	movzbl %al,%eax
  37b1df:	or     %eax,%esi
  37b1e1:	lea    -0x7f(%rsi),%eax
  37b1e4:	cmp    $0x21,%eax
  37b1e7:	jb     37bbea <<glass::engine::Watch>::print_utf8+0x17ea>
  37b1ed:	cmp    $0xffffffff,%ebp
  37b1f0:	je     37bbb0 <<glass::engine::Watch>::print_utf8+0x17b0>
  37b1f6:	mov    %rdx,0x10(%rsp)
  37b1fb:	mov    %rsi,0x68(%rsp)
  37b200:	mov    %r15,0x18(%rsp)
  37b205:	lea    -0x20(%rbp),%eax
  37b208:	cmp    $0x5f,%eax
  37b20b:	jae    37b230 <<glass::engine::Watch>::print_utf8+0xe30>
  37b20d:	mov    $0x1,%r14d
  37b213:	cmpb   $0x0,0xc(%rsp)
  37b218:	je     37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b21e:	jmp    37b3c2 <<glass::engine::Watch>::print_utf8+0xfc2>
  37b223:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  37b230:	cmpb   $0x0,0x80(%rsp)
  37b238:	je     37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b23e:	mov    0x7e733c(%rip),%eax        # b62580 <glass::engine::width_of::CACHE+0x10>
  37b244:	test   %eax,%eax
  37b246:	jne    37bbc6 <<glass::engine::Watch>::print_utf8+0x17c6>
  37b24c:	mov    %ebp,%edi
  37b24e:	mov    0x7e7323(%rip),%rsi        # b62578 <glass::engine::width_of::CACHE+0x8>
  37b255:	cmp    %rdi,%rsi
  37b258:	jbe    37bbdd <<glass::engine::Watch>::print_utf8+0x17dd>
  37b25e:	mov    0x7e730b(%rip),%rdx        # b62570 <glass::engine::width_of::CACHE>
  37b265:	movzbl (%rdx,%rdi,1),%eax
  37b269:	movzbl %al,%r14d
  37b26d:	test   %r14b,%r14b
  37b270:	js     37b281 <<glass::engine::Watch>::print_utf8+0xe81>
  37b272:	mov    $0x1,%cl
  37b274:	test   %cl,%cl
  37b276:	jne    37b3b4 <<glass::engine::Watch>::print_utf8+0xfb4>
  37b27c:	jmp    37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b281:	cmp    $0xfe,%r14d
  37b288:	je     37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b28e:	mov    $0xfe,%al
  37b290:	cmp    $0x7f,%ebp
  37b293:	jae    37b2a2 <<glass::engine::Watch>::print_utf8+0xea2>
  37b295:	mov    $0x1,%r14d
  37b29b:	xor    %ecx,%ecx
  37b29d:	jmp    37b3a9 <<glass::engine::Watch>::print_utf8+0xfa9>
  37b2a2:	cmp    $0xa0,%ebp
  37b2a8:	jb     37b330 <<glass::engine::Watch>::print_utf8+0xf30>
  37b2ae:	mov    %edi,%eax
  37b2b0:	shr    $0xd,%eax
  37b2b3:	mov    0x7e138e(%rip),%rcx        # b5c648 <_DYNAMIC+0x728>
  37b2ba:	movzbl (%rcx,%rax,1),%eax
  37b2be:	mov    %edi,%ecx
  37b2c0:	shr    $0x7,%ecx
  37b2c3:	and    $0x3f,%ecx
  37b2c6:	shl    $0x6,%eax
  37b2c9:	add    0x7e1380(%rip),%rax        # b5c650 <_DYNAMIC+0x730>
  37b2d0:	movzbl (%rcx,%rax,1),%eax
  37b2d4:	cmp    $0xba,%rax
  37b2da:	jae    37c5d8 <<glass::engine::Watch>::print_utf8+0x21d8>
  37b2e0:	mov    %edi,%ecx
  37b2e2:	shr    $0x2,%ecx
  37b2e5:	and    $0x1f,%ecx
  37b2e8:	shl    $0x5,%eax
  37b2eb:	add    0x7e1366(%rip),%rax        # b5c658 <_DYNAMIC+0x738>
  37b2f2:	movzbl (%rcx,%rax,1),%eax
  37b2f6:	lea    0x0(,%rbp,2),%ecx
  37b2fd:	and    $0x6,%cl
  37b300:	shr    %cl,%al
  37b302:	and    $0x3,%al
  37b304:	cmp    $0x3,%al
  37b306:	jne    37b3a3 <<glass::engine::Watch>::print_utf8+0xfa3>
  37b30c:	cmp    $0xfe00,%ebp
  37b312:	jg     37b334 <<glass::engine::Watch>::print_utf8+0xf34>
  37b314:	cmp    $0x5dc,%ebp
  37b31a:	je     37b352 <<glass::engine::Watch>::print_utf8+0xf52>
  37b31c:	mov    $0x3,%al
  37b31e:	cmp    $0x17d8,%ebp
  37b324:	je     37b3a3 <<glass::engine::Watch>::print_utf8+0xfa3>
  37b326:	cmp    $0x1a10,%ebp
  37b32c:	je     37b352 <<glass::engine::Watch>::print_utf8+0xf52>
  37b32e:	jmp    37b364 <<glass::engine::Watch>::print_utf8+0xf64>
  37b330:	xor    %ecx,%ecx
  37b332:	jmp    37b3a9 <<glass::engine::Watch>::print_utf8+0xfa9>
  37b334:	lea    -0xfe01(%rbp),%eax
  37b33a:	cmp    $0xe,%eax
  37b33d:	jbe    37b356 <<glass::engine::Watch>::print_utf8+0xf56>
  37b33f:	lea    -0x16d67(%rbp),%eax
  37b345:	cmp    $0x2,%eax
  37b348:	jb     37b352 <<glass::engine::Watch>::print_utf8+0xf52>
  37b34a:	cmp    $0x10c03,%ebp
  37b350:	jne    37b364 <<glass::engine::Watch>::print_utf8+0xf64>
  37b352:	mov    $0x1,%al
  37b354:	jmp    37b3a3 <<glass::engine::Watch>::print_utf8+0xfa3>
  37b356:	mov    $0x6001,%ecx
  37b35b:	bt     %eax,%ecx
  37b35e:	jae    37b33f <<glass::engine::Watch>::print_utf8+0xf3f>
  37b360:	xor    %eax,%eax
  37b362:	jmp    37b3a3 <<glass::engine::Watch>::print_utf8+0xfa3>
  37b364:	movd   %ebp,%xmm0
  37b368:	pshufd $0x0,%xmm0,%xmm0
  37b36d:	paddd  -0x2de305(%rip),%xmm0        # 9d070 <anon.fbeeda9ffa0bdf528271fe5937be7c0a.453.llvm.4924780659780008694+0x120>
  37b375:	mov    %ebp,%eax
  37b377:	and    $0x1ffffe,%eax
  37b37c:	cmp    $0xa4fc,%eax
  37b381:	sete   %al
  37b384:	pxor   -0x2dd7bc(%rip),%xmm0        # 9dbd0 <anon.e6b80e3fbb0340b0148aeb4aba9d7171.1298.llvm.10283561813775316742+0x3c0>
  37b38c:	pcmpgtd -0x2dd084(%rip),%xmm0        # 9e310 <image::codecs::bmp::decoder::LOOKUP_TABLE_4_BIT_TO_8_BIT+0x230>
  37b394:	movmskps %xmm0,%ecx
  37b397:	cmp    $0xf,%ecx
  37b39a:	setne  %cl
  37b39d:	or     %al,%cl
  37b39f:	mov    $0x2,%al
  37b3a1:	sub    %cl,%al
  37b3a3:	movzbl %al,%r14d
  37b3a7:	mov    $0x1,%cl
  37b3a9:	mov    %al,(%rdx,%rdi,1)
  37b3ac:	test   %cl,%cl
  37b3ae:	je     37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b3b4:	lea    -0x1(%r14),%rax
  37b3b8:	cmp    $0x1,%rax
  37b3bc:	ja     37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b3c2:	mov    0x78(%r12),%r15
  37b3c7:	cmpb   $0x0,0x6c(%r15)
  37b3cc:	jne    37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b3d2:	mov    0x40(%r15),%r8
  37b3d6:	mov    0xa0(%r15),%rdx
  37b3dd:	lea    (%r8,%r14,1),%rbx
  37b3e1:	cmp    %rdx,%rbx
  37b3e4:	ja     37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b3ea:	mov    0x30(%r15),%eax
  37b3ee:	sub    0x48(%r15),%eax
  37b3f2:	cltq
  37b3f4:	mov    0x20(%r15),%rsi
  37b3f8:	mov    0x28(%r15),%rcx
  37b3fc:	lea    (%rcx,%rax,1),%rdi
  37b400:	dec    %rdi
  37b403:	cmp    %rsi,%rdi
  37b406:	mov    $0x0,%eax
  37b40b:	cmovae %rsi,%rax
  37b40f:	sub    %rax,%rdi
  37b412:	cmp    %rsi,%rdi
  37b415:	jae    37c5a9 <<glass::engine::Watch>::print_utf8+0x21a9>
  37b41b:	mov    0x58(%r15),%eax
  37b41f:	mov    %eax,0x8(%rsp)
  37b423:	mov    0x5c(%r15),%eax
  37b427:	mov    %eax,0x28(%rsp)
  37b42b:	movzwl 0x64(%r15),%eax
  37b430:	mov    %eax,0x60(%rsp)
  37b434:	mov    0x18(%r15),%rax
  37b438:	shl    $0x6,%rdi
  37b43c:	lea    (%rax,%rdi,1),%r9
  37b440:	lea    (%rax,%rdi,1),%r10
  37b444:	add    $0x18,%r10
  37b448:	mov    0x28(%rax,%rdi,1),%eax
  37b44c:	cmp    $0xffffffff,%eax
  37b44f:	je     37b45a <<glass::engine::Watch>::print_utf8+0x105a>
  37b451:	mov    %r10,%rcx
  37b454:	cmp    0x30(%r9),%r8
  37b458:	jae    37b473 <<glass::engine::Watch>::print_utf8+0x1073>
  37b45a:	mov    0x10(%r9),%rsi
  37b45e:	cmp    %rsi,%r8
  37b461:	jae    37c5b6 <<glass::engine::Watch>::print_utf8+0x21b6>
  37b467:	lea    (%r8,%r8,2),%rcx
  37b46b:	shl    $0x3,%rcx
  37b46f:	add    0x8(%r9),%rcx
  37b473:	testb  $0x60,0x14(%rcx)
  37b477:	jne    37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b47d:	cmp    $0x2,%r14
  37b481:	jne    37b4b8 <<glass::engine::Watch>::print_utf8+0x10b8>
  37b483:	lea    0x1(%r8),%rdi
  37b487:	cmp    $0xffffffff,%eax
  37b48a:	je     37b495 <<glass::engine::Watch>::print_utf8+0x1095>
  37b48c:	mov    %r10,%rcx
  37b48f:	cmp    0x30(%r9),%rdi
  37b493:	jae    37b4ae <<glass::engine::Watch>::print_utf8+0x10ae>
  37b495:	mov    0x10(%r9),%rsi
  37b499:	cmp    %rsi,%rdi
  37b49c:	jae    37c5ed <<glass::engine::Watch>::print_utf8+0x21ed>
  37b4a2:	lea    (%rdi,%rdi,2),%rcx
  37b4a6:	shl    $0x3,%rcx
  37b4aa:	add    0x8(%r9),%rcx
  37b4ae:	testb  $0x60,0x14(%rcx)
  37b4b2:	jne    37b010 <<glass::engine::Watch>::print_utf8+0xc10>
  37b4b8:	mov    %rdx,(%rsp)
  37b4bc:	cmp    %r8d,0x38(%r9)
  37b4c0:	jbe    37b4c6 <<glass::engine::Watch>::print_utf8+0x10c6>
  37b4c2:	mov    %r8d,0x38(%r9)
  37b4c6:	cmp    $0xffffffff,%eax
  37b4c9:	setne  %dl
  37b4cc:	mov    0x30(%r9),%rcx
  37b4d0:	cmp    %rcx,%r8
  37b4d3:	sete   %sil
  37b4d7:	test   %sil,%dl
  37b4da:	mov    %r8,0x20(%rsp)
  37b4df:	mov    %r9,0x38(%rsp)
  37b4e4:	mov    %r10,0x58(%rsp)
  37b4e9:	mov    %rbx,0x30(%rsp)
  37b4ee:	jne    37b562 <<glass::engine::Watch>::print_utf8+0x1162>
  37b4f0:	cmp    $0xffffffff,%eax
  37b4f3:	je     37b7b2 <<glass::engine::Watch>::print_utf8+0x13b2>
  37b4f9:	mov    0x10(%r9),%rax
  37b4fd:	cmp    %rcx,%rax
  37b500:	mov    %rcx,%rdx
  37b503:	cmovb  %rax,%rdx
  37b507:	mov    %rdx,0x88(%rsp)
  37b50f:	cmp    %r8,%rax
  37b512:	mov    %r8,%rsi
  37b515:	cmovb  %rax,%rsi
  37b519:	mov    0x7e0d90(%rip),%rdx        # b5c2b0 <_DYNAMIC+0x390>
  37b520:	movzbl (%rdx),%edx
  37b523:	test   %dl,%dl
  37b525:	je     37b5ca <<glass::engine::Watch>::print_utf8+0x11ca>
  37b52b:	mov    0x7e0d9e(%rip),%rdx        # b5c2d0 <_DYNAMIC+0x3b0>
  37b532:	mov    %rsi,%r11
  37b535:	cmp    %rsi,%rcx
  37b538:	jae    37b541 <<glass::engine::Watch>::print_utf8+0x1141>
  37b53a:	mov    0x7e0d97(%rip),%rdx        # b5c2d8 <_DYNAMIC+0x3b8>
  37b541:	lock incq 0x28(%rdx)
  37b546:	mov    0x7e0d6b(%rip),%rdx        # b5c2b8 <_DYNAMIC+0x398>
  37b54d:	lock incq (%rdx)
  37b551:	mov    %r11,%rdx
  37b554:	sub    0x88(%rsp),%rdx
  37b55c:	jne    37b57c <<glass::engine::Watch>::print_utf8+0x117c>
  37b55e:	xor    %esi,%esi
  37b560:	jmp    37b5bb <<glass::engine::Watch>::print_utf8+0x11bb>
  37b562:	lea    0x1(%r8),%rax
  37b566:	mov    %rax,0x30(%r9)
  37b56a:	mov    0x10(%r9),%rsi
  37b56e:	cmp    %rsi,%r8
  37b571:	jb     37b7d2 <<glass::engine::Watch>::print_utf8+0x13d2>
  37b577:	jmp    37c5fa <<glass::engine::Watch>::print_utf8+0x21fa>
  37b57c:	mov    0x7e0d3d(%rip),%rsi        # b5c2c0 <_DYNAMIC+0x3a0>
  37b583:	lock add %rdx,(%rsi)
  37b587:	cmp    $0x5,%rdx
  37b58b:	jae    37b59b <<glass::engine::Watch>::print_utf8+0x119b>
  37b58d:	lea    -0x2dbae4(%rip),%rsi        # 9fab0 <anon.9327c17d0a5e562173c7ee742d8e0b92.574.llvm.1582988309624084939+0x50>
  37b594:	movzbl -0x1(%rdx,%rsi,1),%esi
  37b599:	jmp    37b5bb <<glass::engine::Watch>::print_utf8+0x11bb>
  37b59b:	lea    -0x5(%rdx),%rdi
  37b59f:	mov    $0x4,%esi
  37b5a4:	cmp    $0x4,%rdi
  37b5a8:	jb     37b5bb <<glass::engine::Watch>::print_utf8+0x11bb>
  37b5aa:	add    $0xfffffffffffffff7,%rdx
  37b5ae:	cmp    $0x8,%rdx
  37b5b2:	mov    $0x6,%esi
  37b5b7:	sbb    $0x0,%rsi
  37b5bb:	mov    0x7e0d06(%rip),%rdx        # b5c2c8 <_DYNAMIC+0x3a8>
  37b5c2:	lock incq (%rdx,%rsi,8)
  37b5c7:	mov    %r11,%rsi
  37b5ca:	cmp    %rsi,%rcx
  37b5cd:	jae    37b778 <<glass::engine::Watch>::print_utf8+0x1378>
  37b5d3:	mov    0x28(%r9),%edi
  37b5d7:	mov    0x20(%r9),%r11d
  37b5db:	mov    0x24(%r9),%ecx
  37b5df:	movzwl 0x2c(%r9),%edx
  37b5e4:	mov    0x18(%r9),%rax
  37b5e8:	test   %rax,%rax
  37b5eb:	mov    %rax,0x78(%rsp)
  37b5f0:	mov    %ecx,0xa0(%rsp)
  37b5f7:	mov    %dx,0xb0(%rsp)
  37b5ff:	je     37b63f <<glass::engine::Watch>::print_utf8+0x123f>
  37b601:	lock incq (%rax)
  37b605:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37b60b:	mov    0x10(%r9),%rdx
  37b60f:	mov    %edi,0x50(%rsp)
  37b613:	mov    %r11d,0x48(%rsp)
  37b618:	mov    0xa0(%rsp),%ecx
  37b61f:	mov    %ecx,0x4c(%rsp)
  37b623:	movzwl 0xb0(%rsp),%ecx
  37b62b:	mov    %cx,0x54(%rsp)
  37b630:	mov    %rax,0x40(%rsp)
  37b635:	cmp    %rdx,%rsi
  37b638:	jbe    37b656 <<glass::engine::Watch>::print_utf8+0x1256>
  37b63a:	jmp    37c510 <<glass::engine::Watch>::print_utf8+0x2110>
  37b63f:	mov    %edi,0x50(%rsp)
  37b643:	mov    %r11d,0x48(%rsp)
  37b648:	mov    %ecx,0x4c(%rsp)
  37b64c:	mov    %dx,0x54(%rsp)
  37b651:	mov    %rax,0x40(%rsp)
  37b656:	mov    0x88(%rsp),%rax
  37b65e:	lea    0x0(,%rax,8),%rax
  37b666:	lea    (%rax,%rax,2),%rax
  37b66a:	mov    0x8(%r9),%rbx
  37b66e:	add    %rax,%rbx
  37b671:	mov    %rsi,0xc0(%rsp)
  37b679:	lea    0x0(,%rsi,8),%rcx
  37b681:	lea    (%rcx,%rcx,2),%r12
  37b685:	sub    %rax,%r12
  37b688:	mov    0x78(%rsp),%rcx
  37b68d:	mov    0xa0(%rsp),%edx
  37b694:	movzwl 0xb0(%rsp),%esi
  37b69c:	mov    %edi,0x90(%rsp)
  37b6a3:	mov    %r11d,0xb8(%rsp)
  37b6ab:	jmp    37b6cb <<glass::engine::Watch>::print_utf8+0x12cb>
  37b6ad:	nopl   (%rax)
  37b6b0:	mov    %rcx,(%rbx)
  37b6b3:	mov    %r11d,0x8(%rbx)
  37b6b7:	mov    %edx,0xc(%rbx)
  37b6ba:	mov    %edi,0x10(%rbx)
  37b6bd:	mov    %si,0x14(%rbx)
  37b6c1:	add    $0x18,%rbx
  37b6c5:	add    $0xffffffffffffffe8,%r12
  37b6c9:	je     37b725 <<glass::engine::Watch>::print_utf8+0x1325>
  37b6cb:	test   %rcx,%rcx
  37b6ce:	je     37b6da <<glass::engine::Watch>::print_utf8+0x12da>
  37b6d0:	lock incq (%rcx)
  37b6d4:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37b6da:	mov    (%rbx),%rax
  37b6dd:	test   %rax,%rax
  37b6e0:	je     37b6b0 <<glass::engine::Watch>::print_utf8+0x12b0>
  37b6e2:	lock decq (%rax)
  37b6e6:	jne    37b6b0 <<glass::engine::Watch>::print_utf8+0x12b0>
  37b6e8:	mov    %rbx,%rdi
  37b6eb:	call   *0x7e0abf(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37b6f1:	movzwl 0xb0(%rsp),%esi
  37b6f9:	mov    0xa0(%rsp),%edx
  37b700:	mov    0xb8(%rsp),%r11d
  37b708:	mov    0x90(%rsp),%edi
  37b70f:	mov    0x78(%rsp),%rcx
  37b714:	mov    0x58(%rsp),%r10
  37b719:	mov    0x38(%rsp),%r9
  37b71e:	mov    0x20(%rsp),%r8
  37b723:	jmp    37b6b0 <<glass::engine::Watch>::print_utf8+0x12b0>
  37b725:	mov    0x88(%rsp),%rax
  37b72d:	cmp    %eax,0x38(%r9)
  37b731:	mov    0x98(%rsp),%r12
  37b739:	jbe    37b73f <<glass::engine::Watch>::print_utf8+0x133f>
  37b73b:	mov    %eax,0x38(%r9)
  37b73f:	test   %rcx,%rcx
  37b742:	mov    0xc0(%rsp),%rsi
  37b74a:	je     37b774 <<glass::engine::Watch>::print_utf8+0x1374>
  37b74c:	lock decq (%rcx)
  37b750:	jne    37b774 <<glass::engine::Watch>::print_utf8+0x1374>
  37b752:	lea    0x40(%rsp),%rdi
  37b757:	call   *0x7e0a53(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37b75d:	mov    0xc0(%rsp),%rsi
  37b765:	mov    0x58(%rsp),%r10
  37b76a:	mov    0x38(%rsp),%r9
  37b76f:	mov    0x20(%rsp),%r8
  37b774:	mov    0x10(%r9),%rax
  37b778:	cmp    %rax,%rsi
  37b77b:	jb     37b7b2 <<glass::engine::Watch>::print_utf8+0x13b2>
  37b77d:	cmpl   $0xffffffff,0x28(%r9)
  37b782:	je     37b7aa <<glass::engine::Watch>::print_utf8+0x13aa>
  37b784:	mov    (%r10),%rax
  37b787:	test   %rax,%rax
  37b78a:	je     37b7aa <<glass::engine::Watch>::print_utf8+0x13aa>
  37b78c:	lock decq (%rax)
  37b790:	jne    37b7aa <<glass::engine::Watch>::print_utf8+0x13aa>
  37b792:	mov    %r10,%rdi
  37b795:	call   *0x7e0a15(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37b79b:	mov    0x58(%rsp),%r10
  37b7a0:	mov    0x38(%rsp),%r9
  37b7a5:	mov    0x20(%rsp),%r8
  37b7aa:	movl   $0xffffffff,0x28(%r9)
  37b7b2:	mov    0x30(%r9),%rax
  37b7b6:	lea    0x1(%r8),%rcx
  37b7ba:	cmp    %rax,%rcx
  37b7bd:	cmova  %rcx,%rax
  37b7c1:	mov    0x10(%r9),%rsi
  37b7c5:	mov    %rax,0x30(%r9)
  37b7c9:	cmp    %rsi,%r8
  37b7cc:	jae    37c60a <<glass::engine::Watch>::print_utf8+0x220a>
  37b7d2:	mov    0x60(%rsp),%esi
  37b7d6:	mov    %esi,%eax
  37b7d8:	or     $0x20,%eax
  37b7db:	cmp    $0x2,%r14
  37b7df:	mov    0x8(%r9),%rcx
  37b7e3:	lea    (%r8,%r8,2),%rdx
  37b7e7:	lea    (%rcx,%rdx,8),%rbx
  37b7eb:	mov    %ebp,0x10(%rcx,%rdx,8)
  37b7ef:	mov    0x8(%rsp),%ebp
  37b7f3:	mov    %ebp,0x8(%rcx,%rdx,8)
  37b7f7:	cmovne %esi,%eax
  37b7fa:	mov    0x28(%rsp),%esi
  37b7fe:	mov    %esi,0xc(%rcx,%rdx,8)
  37b802:	mov    %ax,0x14(%rcx,%rdx,8)
  37b807:	mov    (%rcx,%rdx,8),%rax
  37b80b:	test   %rax,%rax
  37b80e:	je     37b82e <<glass::engine::Watch>::print_utf8+0x142e>
  37b810:	lock decq (%rax)
  37b814:	jne    37b82e <<glass::engine::Watch>::print_utf8+0x142e>
  37b816:	mov    %rbx,%rdi
  37b819:	call   *0x7e0991(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37b81f:	mov    0x58(%rsp),%r10
  37b824:	mov    0x38(%rsp),%r9
  37b829:	mov    0x20(%rsp),%r8
  37b82e:	movq   $0x0,(%rbx)
  37b835:	cmp    $0x2,%r14
  37b839:	mov    0x70(%rsp),%r14
  37b83e:	mov    0x68(%rsp),%rsi
  37b843:	mov    0x10(%rsp),%rdx
  37b848:	jne    37bb8c <<glass::engine::Watch>::print_utf8+0x178c>
  37b84e:	lea    0x1(%r8),%rbx
  37b852:	mov    0x30(%r9),%rax
  37b856:	mov    0x28(%r9),%ecx
  37b85a:	cmp    %rax,%rbx
  37b85d:	jne    37b87e <<glass::engine::Watch>::print_utf8+0x147e>
  37b85f:	cmp    $0xffffffff,%ecx
  37b862:	je     37b87e <<glass::engine::Watch>::print_utf8+0x147e>
  37b864:	add    $0x2,%r8
  37b868:	mov    %r8,0x30(%r9)
  37b86c:	mov    0x10(%r9),%rsi
  37b870:	cmp    %rsi,%rbx
  37b873:	jb     37bb32 <<glass::engine::Watch>::print_utf8+0x1732>
  37b879:	jmp    37c61a <<glass::engine::Watch>::print_utf8+0x221a>
  37b87e:	cmp    $0xffffffff,%ecx
  37b881:	je     37bb12 <<glass::engine::Watch>::print_utf8+0x1712>
  37b887:	mov    0x10(%r9),%rcx
  37b88b:	cmp    %rax,%rcx
  37b88e:	mov    %rax,%rdx
  37b891:	cmovb  %rcx,%rdx
  37b895:	mov    %rdx,0x90(%rsp)
  37b89d:	cmp    %rbx,%rcx
  37b8a0:	mov    %rbx,%rsi
  37b8a3:	cmovb  %rcx,%rsi
  37b8a7:	mov    0x7e0a02(%rip),%rdx        # b5c2b0 <_DYNAMIC+0x390>
  37b8ae:	movzbl (%rdx),%edx
  37b8b1:	test   %dl,%dl
  37b8b3:	je     37b93e <<glass::engine::Watch>::print_utf8+0x153e>
  37b8b9:	mov    0x7e0a10(%rip),%rdx        # b5c2d0 <_DYNAMIC+0x3b0>
  37b8c0:	mov    %rsi,%r11
  37b8c3:	cmp    %rsi,%rax
  37b8c6:	jae    37b8cf <<glass::engine::Watch>::print_utf8+0x14cf>
  37b8c8:	mov    0x7e0a09(%rip),%rdx        # b5c2d8 <_DYNAMIC+0x3b8>
  37b8cf:	lock incq 0x28(%rdx)
  37b8d4:	mov    0x7e09dd(%rip),%rdx        # b5c2b8 <_DYNAMIC+0x398>
  37b8db:	lock incq (%rdx)
  37b8df:	mov    %r11,%rdx
  37b8e2:	sub    0x90(%rsp),%rdx
  37b8ea:	jne    37b8f0 <<glass::engine::Watch>::print_utf8+0x14f0>
  37b8ec:	xor    %esi,%esi
  37b8ee:	jmp    37b92f <<glass::engine::Watch>::print_utf8+0x152f>
  37b8f0:	mov    0x7e09c9(%rip),%rsi        # b5c2c0 <_DYNAMIC+0x3a0>
  37b8f7:	lock add %rdx,(%rsi)
  37b8fb:	cmp    $0x5,%rdx
  37b8ff:	jae    37b90f <<glass::engine::Watch>::print_utf8+0x150f>
  37b901:	lea    -0x2dbe58(%rip),%rsi        # 9fab0 <anon.9327c17d0a5e562173c7ee742d8e0b92.574.llvm.1582988309624084939+0x50>
  37b908:	movzbl -0x1(%rdx,%rsi,1),%esi
  37b90d:	jmp    37b92f <<glass::engine::Watch>::print_utf8+0x152f>
  37b90f:	lea    -0x5(%rdx),%rdi
  37b913:	mov    $0x4,%esi
  37b918:	cmp    $0x4,%rdi
  37b91c:	jb     37b92f <<glass::engine::Watch>::print_utf8+0x152f>
  37b91e:	add    $0xfffffffffffffff7,%rdx
  37b922:	cmp    $0x8,%rdx
  37b926:	mov    $0x6,%esi
  37b92b:	sbb    $0x0,%rsi
  37b92f:	mov    0x7e0992(%rip),%rdx        # b5c2c8 <_DYNAMIC+0x3a8>
  37b936:	lock incq (%rdx,%rsi,8)
  37b93b:	mov    %r11,%rsi
  37b93e:	cmp    %rsi,%rax
  37b941:	mov    0x10(%rsp),%rdx
  37b946:	jae    37baee <<glass::engine::Watch>::print_utf8+0x16ee>
  37b94c:	mov    0x28(%r9),%edi
  37b950:	mov    0x20(%r9),%r11d
  37b954:	mov    0x24(%r9),%ebp
  37b958:	movzwl 0x2c(%r9),%eax
  37b95d:	mov    0x18(%r9),%r14
  37b961:	test   %r14,%r14
  37b964:	mov    %r14,0xb0(%rsp)
  37b96c:	mov    %ax,0xa0(%rsp)
  37b974:	mov    %rbx,0x88(%rsp)
  37b97c:	je     37b9ad <<glass::engine::Watch>::print_utf8+0x15ad>
  37b97e:	lock incq (%r14)
  37b982:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37b988:	mov    0x10(%r9),%rdx
  37b98c:	mov    %edi,0x50(%rsp)
  37b990:	mov    %r11d,0x48(%rsp)
  37b995:	mov    %ebp,0x4c(%rsp)
  37b999:	mov    %ax,0x54(%rsp)
  37b99e:	mov    %r14,0x40(%rsp)
  37b9a3:	cmp    %rdx,%rsi
  37b9a6:	jbe    37b9c4 <<glass::engine::Watch>::print_utf8+0x15c4>
  37b9a8:	jmp    37c52a <<glass::engine::Watch>::print_utf8+0x212a>
  37b9ad:	mov    %edi,0x50(%rsp)
  37b9b1:	mov    %r11d,0x48(%rsp)
  37b9b6:	mov    %ebp,0x4c(%rsp)
  37b9ba:	mov    %ax,0x54(%rsp)
  37b9bf:	mov    %r14,0x40(%rsp)
  37b9c4:	mov    0x90(%rsp),%rax
  37b9cc:	lea    0x0(,%rax,8),%rax
  37b9d4:	lea    (%rax,%rax,2),%rax
  37b9d8:	mov    0x8(%r9),%rbx
  37b9dc:	add    %rax,%rbx
  37b9df:	mov    %rsi,0xb8(%rsp)
  37b9e7:	lea    0x0(,%rsi,8),%rcx
  37b9ef:	lea    (%rcx,%rcx,2),%r12
  37b9f3:	sub    %rax,%r12
  37b9f6:	movzwl 0xa0(%rsp),%ecx
  37b9fe:	mov    %ebp,0x78(%rsp)
  37ba02:	jmp    37ba2b <<glass::engine::Watch>::print_utf8+0x162b>
  37ba04:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  37ba10:	mov    %r14,(%rbx)
  37ba13:	mov    %r11d,0x8(%rbx)
  37ba17:	mov    %ebp,0xc(%rbx)
  37ba1a:	mov    %edi,0x10(%rbx)
  37ba1d:	mov    %cx,0x14(%rbx)
  37ba21:	add    $0x18,%rbx
  37ba25:	add    $0xffffffffffffffe8,%r12
  37ba29:	je     37ba80 <<glass::engine::Watch>::print_utf8+0x1680>
  37ba2b:	test   %r14,%r14
  37ba2e:	je     37ba3a <<glass::engine::Watch>::print_utf8+0x163a>
  37ba30:	lock incq (%r14)
  37ba34:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37ba3a:	mov    (%rbx),%rax
  37ba3d:	test   %rax,%rax
  37ba40:	je     37ba10 <<glass::engine::Watch>::print_utf8+0x1610>
  37ba42:	lock decq (%rax)
  37ba46:	jne    37ba10 <<glass::engine::Watch>::print_utf8+0x1610>
  37ba48:	mov    %edi,%ebp
  37ba4a:	mov    %rbx,%rdi
  37ba4d:	mov    %r11d,%r14d
  37ba50:	call   *0x7e075a(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37ba56:	movzwl 0xa0(%rsp),%ecx
  37ba5e:	mov    %r14d,%r11d
  37ba61:	mov    0xb0(%rsp),%r14
  37ba69:	mov    %ebp,%edi
  37ba6b:	mov    0x78(%rsp),%ebp
  37ba6f:	mov    0x58(%rsp),%r10
  37ba74:	mov    0x38(%rsp),%r9
  37ba79:	mov    0x20(%rsp),%r8
  37ba7e:	jmp    37ba10 <<glass::engine::Watch>::print_utf8+0x1610>
  37ba80:	mov    0x90(%rsp),%rax
  37ba88:	cmp    %eax,0x38(%r9)
  37ba8c:	mov    0x98(%rsp),%r12
  37ba94:	mov    0x10(%rsp),%rdx
  37ba99:	mov    0x88(%rsp),%rbx
  37baa1:	jbe    37baa7 <<glass::engine::Watch>::print_utf8+0x16a7>
  37baa3:	mov    %eax,0x38(%r9)
  37baa7:	test   %r14,%r14
  37baaa:	mov    0x8(%rsp),%ebp
  37baae:	mov    0xb8(%rsp),%rsi
  37bab6:	je     37bae5 <<glass::engine::Watch>::print_utf8+0x16e5>
  37bab8:	lock decq (%r14)
  37babc:	jne    37bae5 <<glass::engine::Watch>::print_utf8+0x16e5>
  37babe:	lea    0x40(%rsp),%rdi
  37bac3:	call   *0x7e06e7(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37bac9:	mov    0xb8(%rsp),%rsi
  37bad1:	mov    0x58(%rsp),%r10
  37bad6:	mov    0x38(%rsp),%r9
  37badb:	mov    0x20(%rsp),%r8
  37bae0:	mov    0x10(%rsp),%rdx
  37bae5:	mov    0x10(%r9),%rcx
  37bae9:	mov    0x70(%rsp),%r14
  37baee:	cmp    %rcx,%rsi
  37baf1:	jb     37bb12 <<glass::engine::Watch>::print_utf8+0x1712>
  37baf3:	mov    %r10,%rdi
  37baf6:	call   2c0520 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  37bafb:	mov    0x38(%rsp),%r9
  37bb00:	mov    0x20(%rsp),%r8
  37bb05:	mov    0x10(%rsp),%rdx
  37bb0a:	movl   $0xffffffff,0x28(%r9)
  37bb12:	mov    0x30(%r9),%rax
  37bb16:	add    $0x2,%r8
  37bb1a:	cmp    %rax,%r8
  37bb1d:	cmovbe %rax,%r8
  37bb21:	mov    0x10(%r9),%rsi
  37bb25:	mov    %r8,0x30(%r9)
  37bb29:	cmp    %rsi,%rbx
  37bb2c:	jae    37c62a <<glass::engine::Watch>::print_utf8+0x222a>
  37bb32:	mov    0x8(%r9),%rax
  37bb36:	lea    (%rbx,%rbx,2),%rcx
  37bb3a:	lea    (%rax,%rcx,8),%rbx
  37bb3e:	movl   $0x20,0x10(%rax,%rcx,8)
  37bb46:	mov    %ebp,0x8(%rax,%rcx,8)
  37bb4a:	mov    0x28(%rsp),%esi
  37bb4e:	mov    %esi,0xc(%rax,%rcx,8)
  37bb52:	mov    0x60(%rsp),%esi
  37bb56:	or     $0x40,%esi
  37bb59:	mov    %si,0x14(%rax,%rcx,8)
  37bb5e:	mov    (%rax,%rcx,8),%rax
  37bb62:	test   %rax,%rax
  37bb65:	mov    0x68(%rsp),%rsi
  37bb6a:	je     37bb85 <<glass::engine::Watch>::print_utf8+0x1785>
  37bb6c:	lock decq (%rax)
  37bb70:	jne    37bb85 <<glass::engine::Watch>::print_utf8+0x1785>
  37bb72:	mov    %rbx,%rdi
  37bb75:	call   *0x7e0635(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37bb7b:	mov    0x10(%rsp),%rdx
  37bb80:	mov    0x68(%rsp),%rsi
  37bb85:	movq   $0x0,(%rbx)
  37bb8c:	mov    0x30(%rsp),%rax
  37bb91:	cmp    (%rsp),%rax
  37bb95:	jb     37bb9f <<glass::engine::Watch>::print_utf8+0x179f>
  37bb97:	dec    %rax
  37bb9a:	movb   $0x1,0x6c(%r15)
  37bb9f:	mov    %rax,0x40(%r15)
  37bba3:	incq   0xa0(%r12)
  37bbab:	mov    0x18(%rsp),%r15
  37bbb0:	add    %r15,%rdx
  37bbb3:	cmpb   $0x0,0x80(%rsp)
  37bbbb:	je     37b03f <<glass::engine::Watch>::print_utf8+0xc3f>
  37bbc1:	jmp    37a4b0 <<glass::engine::Watch>::print_utf8+0xb0>
  37bbc6:	call   287a12 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  37bbcb:	mov    %ebp,%edi
  37bbcd:	mov    0x7e69a4(%rip),%rsi        # b62578 <glass::engine::width_of::CACHE+0x8>
  37bbd4:	cmp    %rdi,%rsi
  37bbd7:	ja     37b25e <<glass::engine::Watch>::print_utf8+0xe5e>
  37bbdd:	lea    0x798234(%rip),%rdx        # b13e18 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x6b60>
  37bbe4:	call   *0x7e055e(%rip)        # b5c148 <_DYNAMIC+0x228>
  37bbea:	cmpq   $0x400,0xa0(%r12)
  37bbf6:	jb     37bc22 <<glass::engine::Watch>::print_utf8+0x1822>
  37bbf8:	mov    %r12,%rdi
  37bbfb:	call   37cae0 <<glass::engine::Watch>::fold_sentinel>
  37bc00:	movq   $0x0,0xa0(%r12)
  37bc0c:	mov    0x7e6976(%rip),%eax        # b62588 <glass::engine::run_whole::ON>
  37bc12:	test   %eax,%eax
  37bc14:	je     37bc2c <<glass::engine::Watch>::print_utf8+0x182c>
  37bc16:	call   287c27 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  37bc1b:	cmp    %r13,%r15
  37bc1e:	je     37bc31 <<glass::engine::Watch>::print_utf8+0x1831>
  37bc20:	jmp    37bc61 <<glass::engine::Watch>::print_utf8+0x1861>
  37bc22:	mov    0x7e6960(%rip),%eax        # b62588 <glass::engine::run_whole::ON>
  37bc28:	test   %eax,%eax
  37bc2a:	jne    37bc16 <<glass::engine::Watch>::print_utf8+0x1816>
  37bc2c:	cmp    %r13,%r15
  37bc2f:	jne    37bc61 <<glass::engine::Watch>::print_utf8+0x1861>
  37bc31:	cmpb   $0x0,0x7e6954(%rip)        # b6258c <glass::engine::run_whole::ON+0x4>
  37bc38:	je     37bc61 <<glass::engine::Watch>::print_utf8+0x1861>
  37bc3a:	cmp    $0xffffffff,%ebp
  37bc3d:	je     37be05 <<glass::engine::Watch>::print_utf8+0x1a05>
  37bc43:	lea    -0x20(%rbp),%eax
  37bc46:	cmp    $0x5f,%eax
  37bc49:	jae    37bc72 <<glass::engine::Watch>::print_utf8+0x1872>
  37bc4b:	mov    $0x1,%r12d
  37bc51:	cmpb   $0x0,0xc(%rsp)
  37bc56:	jne    37bd3f <<glass::engine::Watch>::print_utf8+0x193f>
  37bc5c:	jmp    37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37bc61:	xor    %eax,%eax
  37bc63:	cmp    $0xffffffff,%ebp
  37bc66:	cmove  %rax,%rbx
  37bc6a:	mov    %rbx,%r13
  37bc6d:	jmp    37be05 <<glass::engine::Watch>::print_utf8+0x1a05>
  37bc72:	cmpb   $0x0,0x80(%rsp)
  37bc7a:	je     37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37bc80:	mov    0x7e68fa(%rip),%eax        # b62580 <glass::engine::width_of::CACHE+0x10>
  37bc86:	test   %eax,%eax
  37bc88:	jne    37c4e8 <<glass::engine::Watch>::print_utf8+0x20e8>
  37bc8e:	mov    %ebp,%r14d
  37bc91:	mov    0x7e68e0(%rip),%rsi        # b62578 <glass::engine::width_of::CACHE+0x8>
  37bc98:	cmp    %r14,%rsi
  37bc9b:	jbe    37c500 <<glass::engine::Watch>::print_utf8+0x2100>
  37bca1:	mov    0x7e68c8(%rip),%rbx        # b62570 <glass::engine::width_of::CACHE>
  37bca8:	movzbl (%rbx,%r14,1),%eax
  37bcad:	movzbl %al,%r12d
  37bcb1:	test   %r12b,%r12b
  37bcb4:	js     37bcc1 <<glass::engine::Watch>::print_utf8+0x18c1>
  37bcb6:	mov    $0x1,%cl
  37bcb8:	test   %cl,%cl
  37bcba:	jne    37bd30 <<glass::engine::Watch>::print_utf8+0x1930>
  37bcbc:	jmp    37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37bcc1:	cmp    $0xfe,%r12d
  37bcc8:	je     37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37bcce:	mov    $0xfe,%al
  37bcd0:	cmp    $0x7f,%ebp
  37bcd3:	jae    37bd0b <<glass::engine::Watch>::print_utf8+0x190b>
  37bcd5:	mov    $0x1,%r12d
  37bcdb:	xor    %ecx,%ecx
  37bcdd:	jmp    37bd24 <<glass::engine::Watch>::print_utf8+0x1924>
  37bcdf:	mov    $0x1,%cl
  37bce1:	mov    %ecx,0x80(%rsp)
  37bce8:	cmpb   $0x0,0x68(%rax)
  37bcec:	jne    37bcfe <<glass::engine::Watch>::print_utf8+0x18fe>
  37bcee:	cmpb   $0x0,0x69(%rax)
  37bcf2:	jne    37bcfe <<glass::engine::Watch>::print_utf8+0x18fe>
  37bcf4:	cmpb   $0x0,0x6a(%rax)
  37bcf8:	je     37bf0d <<glass::engine::Watch>::print_utf8+0x1b0d>
  37bcfe:	movl   $0x0,0xc(%rsp)
  37bd06:	jmp    37a463 <<glass::engine::Watch>::print_utf8+0x63>
  37bd0b:	cmp    $0xa0,%ebp
  37bd11:	jb     37bd22 <<glass::engine::Watch>::print_utf8+0x1922>
  37bd13:	mov    %ebp,%edi
  37bd15:	call   3cc470 <unicode_width::tables::lookup_width>
  37bd1a:	movzbl %al,%r12d
  37bd1e:	mov    $0x1,%cl
  37bd20:	jmp    37bd24 <<glass::engine::Watch>::print_utf8+0x1924>
  37bd22:	xor    %ecx,%ecx
  37bd24:	mov    %al,(%rbx,%r14,1)
  37bd28:	test   %cl,%cl
  37bd2a:	je     37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37bd30:	lea    -0x1(%r12),%rax
  37bd35:	cmp    $0x1,%rax
  37bd39:	ja     37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37bd3f:	mov    0x98(%rsp),%rax
  37bd47:	mov    0x78(%rax),%r13
  37bd4b:	cmpb   $0x0,0x6c(%r13)
  37bd50:	jne    37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37bd56:	mov    0x40(%r13),%r15
  37bd5a:	mov    0xa0(%r13),%rdx
  37bd61:	lea    (%r15,%r12,1),%r14
  37bd65:	cmp    %rdx,%r14
  37bd68:	ja     37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37bd6e:	mov    0x30(%r13),%eax
  37bd72:	sub    0x48(%r13),%eax
  37bd76:	cltq
  37bd78:	mov    0x20(%r13),%rsi
  37bd7c:	mov    0x28(%r13),%rcx
  37bd80:	lea    (%rcx,%rax,1),%rdi
  37bd84:	dec    %rdi
  37bd87:	xor    %eax,%eax
  37bd89:	cmp    %rsi,%rdi
  37bd8c:	cmovae %rsi,%rax
  37bd90:	sub    %rax,%rdi
  37bd93:	cmp    %rsi,%rdi
  37bd96:	jae    37c5a9 <<glass::engine::Watch>::print_utf8+0x21a9>
  37bd9c:	mov    0x58(%r13),%r9d
  37bda0:	mov    0x5c(%r13),%r10d
  37bda4:	movzwl 0x64(%r13),%r8d
  37bda9:	mov    0x18(%r13),%rax
  37bdad:	shl    $0x6,%rdi
  37bdb1:	lea    (%rax,%rdi,1),%r11
  37bdb5:	lea    (%rax,%rdi,1),%rbx
  37bdb9:	add    $0x18,%rbx
  37bdbd:	mov    0x28(%rax,%rdi,1),%eax
  37bdc1:	cmp    $0xffffffff,%eax
  37bdc4:	je     37bdcf <<glass::engine::Watch>::print_utf8+0x19cf>
  37bdc6:	mov    %rbx,%rcx
  37bdc9:	cmp    0x30(%r11),%r15
  37bdcd:	jae    37bde8 <<glass::engine::Watch>::print_utf8+0x19e8>
  37bdcf:	mov    0x10(%r11),%rsi
  37bdd3:	cmp    %rsi,%r15
  37bdd6:	jae    37c63a <<glass::engine::Watch>::print_utf8+0x223a>
  37bddc:	lea    (%r15,%r15,2),%rcx
  37bde0:	shl    $0x3,%rcx
  37bde4:	add    0x8(%r11),%rcx
  37bde8:	testb  $0x60,0x14(%rcx)
  37bdec:	je     37be1a <<glass::engine::Watch>::print_utf8+0x1a1a>
  37bdee:	mov    0x98(%rsp),%rdi
  37bdf6:	mov    %ebp,%esi
  37bdf8:	call   426180 <<glass::engine::Watch as vte::ansi::Handler>::input>
  37bdfd:	mov    0xa8(%rsp),%r13
  37be05:	mov    %r13,%rax
  37be08:	add    $0x108,%rsp
  37be0f:	pop    %rbx
  37be10:	pop    %r12
  37be12:	pop    %r13
  37be14:	pop    %r14
  37be16:	pop    %r15
  37be18:	pop    %rbp
  37be19:	ret
  37be1a:	cmp    $0x2,%r12
  37be1e:	jne    37be51 <<glass::engine::Watch>::print_utf8+0x1a51>
  37be20:	lea    0x1(%r15),%rdi
  37be24:	cmp    $0xffffffff,%eax
  37be27:	je     37be32 <<glass::engine::Watch>::print_utf8+0x1a32>
  37be29:	mov    %rbx,%rcx
  37be2c:	cmp    0x30(%r11),%rdi
  37be30:	jae    37be4b <<glass::engine::Watch>::print_utf8+0x1a4b>
  37be32:	mov    0x10(%r11),%rsi
  37be36:	cmp    %rsi,%rdi
  37be39:	jae    37c5ed <<glass::engine::Watch>::print_utf8+0x21ed>
  37be3f:	lea    (%rdi,%rdi,2),%rcx
  37be43:	shl    $0x3,%rcx
  37be47:	add    0x8(%r11),%rcx
  37be4b:	testb  $0x60,0x14(%rcx)
  37be4f:	jne    37bdee <<glass::engine::Watch>::print_utf8+0x19ee>
  37be51:	mov    %rbx,0x58(%rsp)
  37be56:	mov    %r10d,0x60(%rsp)
  37be5b:	mov    %r9d,0x10(%rsp)
  37be60:	mov    %r8d,0x68(%rsp)
  37be65:	mov    %rdx,0x80(%rsp)
  37be6d:	cmp    %r15d,0x38(%r11)
  37be71:	jbe    37be77 <<glass::engine::Watch>::print_utf8+0x1a77>
  37be73:	mov    %r15d,0x38(%r11)
  37be77:	cmp    $0xffffffff,%eax
  37be7a:	setne  %cl
  37be7d:	mov    0x30(%r11),%rbx
  37be81:	cmp    %rbx,%r15
  37be84:	sete   %dl
  37be87:	test   %dl,%cl
  37be89:	mov    %r11,0x18(%rsp)
  37be8e:	jne    37bed6 <<glass::engine::Watch>::print_utf8+0x1ad6>
  37be90:	cmp    $0xffffffff,%eax
  37be93:	je     37c12d <<glass::engine::Watch>::print_utf8+0x1d2d>
  37be99:	mov    0x10(%r11),%r14
  37be9d:	cmp    %rbx,%r14
  37bea0:	mov    %rbx,%rcx
  37bea3:	cmovb  %r14,%rcx
  37bea7:	cmp    %r15,%r14
  37beaa:	mov    %r15,%rsi
  37bead:	cmovb  %r14,%rsi
  37beb1:	mov    0x7e03f8(%rip),%rax        # b5c2b0 <_DYNAMIC+0x390>
  37beb8:	movzbl (%rax),%eax
  37bebb:	test   %al,%al
  37bebd:	mov    %rsi,0x30(%rsp)
  37bec2:	mov    %rcx,(%rsp)
  37bec6:	je     37bf42 <<glass::engine::Watch>::print_utf8+0x1b42>
  37bec8:	cmp    %rsi,%rbx
  37becb:	jae    37bf1d <<glass::engine::Watch>::print_utf8+0x1b1d>
  37becd:	mov    0x7e0404(%rip),%rax        # b5c2d8 <_DYNAMIC+0x3b8>
  37bed4:	jmp    37bf24 <<glass::engine::Watch>::print_utf8+0x1b24>
  37bed6:	lea    0x1(%r15),%rax
  37beda:	mov    %rax,0x30(%r11)
  37bede:	mov    0x10(%r11),%rsi
  37bee2:	cmp    %rsi,%r15
  37bee5:	jb     37c14d <<glass::engine::Watch>::print_utf8+0x1d4d>
  37beeb:	lea    0x79729e(%rip),%rdx        # b13190 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5ed8>
  37bef2:	mov    %r15,%rdi
  37bef5:	call   *0x7e024d(%rip)        # b5c148 <_DYNAMIC+0x228>
  37befb:	lea    0x7971e6(%rip),%rcx        # b130e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5e30>
  37bf02:	mov    0x60(%rsp),%rdi
  37bf07:	call   *0x7e03e3(%rip)        # b5c2f0 <_DYNAMIC+0x3d0>
  37bf0d:	cmpb   $0x0,0x6b(%rax)
  37bf11:	sete   %al
  37bf14:	mov    %eax,0xc(%rsp)
  37bf18:	jmp    37a463 <<glass::engine::Watch>::print_utf8+0x63>
  37bf1d:	mov    0x7e03ac(%rip),%rax        # b5c2d0 <_DYNAMIC+0x3b0>
  37bf24:	lock incq 0x28(%rax)
  37bf29:	mov    %rsi,%rdi
  37bf2c:	sub    %rcx,%rdi
  37bf2f:	call   401fd0 <alacritty_terminal::grid::row::fill_census::note>
  37bf34:	mov    (%rsp),%rcx
  37bf38:	mov    0x30(%rsp),%rsi
  37bf3d:	mov    0x18(%rsp),%r11
  37bf42:	cmp    %rsi,%rbx
  37bf45:	jae    37c10d <<glass::engine::Watch>::print_utf8+0x1d0d>
  37bf4b:	mov    0x28(%r11),%edi
  37bf4f:	mov    0x20(%r11),%r8d
  37bf53:	mov    0x24(%r11),%r9d
  37bf57:	movzwl 0x2c(%r11),%r10d
  37bf5c:	mov    0x18(%r11),%rdx
  37bf60:	test   %rdx,%rdx
  37bf63:	mov    %rdx,0x28(%rsp)
  37bf68:	mov    %edi,0x70(%rsp)
  37bf6c:	mov    %r8d,0x8(%rsp)
  37bf71:	mov    %r9d,0x20(%rsp)
  37bf76:	mov    %r10w,0x38(%rsp)
  37bf7c:	je     37c040 <<glass::engine::Watch>::print_utf8+0x1c40>
  37bf82:	lock incq (%rdx)
  37bf86:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37bf8c:	mov    %rdx,%rax
  37bf8f:	mov    0x10(%r11),%rdx
  37bf93:	mov    %edi,0x50(%rsp)
  37bf97:	mov    %r8d,0x48(%rsp)
  37bf9c:	mov    %r9d,0x4c(%rsp)
  37bfa1:	mov    %r10w,0x54(%rsp)
  37bfa7:	mov    %rax,0x40(%rsp)
  37bfac:	cmp    %rdx,%rsi
  37bfaf:	ja     37c597 <<glass::engine::Watch>::print_utf8+0x2197>
  37bfb5:	lea    0x0(,%rcx,8),%rax
  37bfbd:	lea    (%rax,%rax,2),%rax
  37bfc1:	mov    0x8(%r11),%rbx
  37bfc5:	add    %rax,%rbx
  37bfc8:	lea    0x0(,%rsi,8),%rcx
  37bfd0:	lea    (%rcx,%rcx,2),%r14
  37bfd4:	sub    %rax,%r14
  37bfd7:	mov    0x28(%rsp),%rdx
  37bfdc:	jmp    37bfff <<glass::engine::Watch>::print_utf8+0x1bff>
  37bfde:	mov    %rdx,(%rbx)
  37bfe1:	mov    %r8d,0x8(%rbx)
  37bfe5:	mov    %r9d,0xc(%rbx)
  37bfe9:	mov    %edi,0x10(%rbx)
  37bfec:	mov    %r10w,0x14(%rbx)
  37bff1:	add    $0x18,%rbx
  37bff5:	add    $0xffffffffffffffe8,%r14
  37bff9:	je     37c0d5 <<glass::engine::Watch>::print_utf8+0x1cd5>
  37bfff:	lock incq (%rdx)
  37c003:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37c009:	mov    (%rbx),%rax
  37c00c:	test   %rax,%rax
  37c00f:	je     37bfde <<glass::engine::Watch>::print_utf8+0x1bde>
  37c011:	lock decq (%rax)
  37c015:	jne    37bfde <<glass::engine::Watch>::print_utf8+0x1bde>
  37c017:	mov    %rbx,%rdi
  37c01a:	call   *0x7e0190(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c020:	movzwl 0x38(%rsp),%r10d
  37c026:	mov    0x20(%rsp),%r9d
  37c02b:	mov    0x8(%rsp),%r8d
  37c030:	mov    0x70(%rsp),%edi
  37c034:	mov    0x28(%rsp),%rdx
  37c039:	mov    0x18(%rsp),%r11
  37c03e:	jmp    37bfde <<glass::engine::Watch>::print_utf8+0x1bde>
  37c040:	mov    %edi,0x50(%rsp)
  37c044:	mov    %r8d,0x48(%rsp)
  37c049:	mov    %r9d,0x4c(%rsp)
  37c04e:	mov    %r10w,0x54(%rsp)
  37c054:	mov    %rdx,0x40(%rsp)
  37c059:	lea    0x0(,%rcx,8),%rax
  37c061:	lea    (%rax,%rax,2),%rax
  37c065:	mov    0x8(%r11),%rbx
  37c069:	add    %rax,%rbx
  37c06c:	lea    0x0(,%rsi,8),%rcx
  37c074:	lea    (%rcx,%rcx,2),%r14
  37c078:	sub    %rax,%r14
  37c07b:	jmp    37c09e <<glass::engine::Watch>::print_utf8+0x1c9e>
  37c07d:	movq   $0x0,(%rbx)
  37c084:	mov    %r8d,0x8(%rbx)
  37c088:	mov    %r9d,0xc(%rbx)
  37c08c:	mov    %edi,0x10(%rbx)
  37c08f:	mov    %r10w,0x14(%rbx)
  37c094:	add    $0x18,%rbx
  37c098:	add    $0xffffffffffffffe8,%r14
  37c09c:	je     37c0d5 <<glass::engine::Watch>::print_utf8+0x1cd5>
  37c09e:	mov    (%rbx),%rax
  37c0a1:	test   %rax,%rax
  37c0a4:	je     37c07d <<glass::engine::Watch>::print_utf8+0x1c7d>
  37c0a6:	lock decq (%rax)
  37c0aa:	jne    37c07d <<glass::engine::Watch>::print_utf8+0x1c7d>
  37c0ac:	mov    %rbx,%rdi
  37c0af:	call   *0x7e00fb(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c0b5:	movzwl 0x38(%rsp),%r10d
  37c0bb:	mov    0x20(%rsp),%r9d
  37c0c0:	mov    0x8(%rsp),%r8d
  37c0c5:	mov    0x70(%rsp),%edi
  37c0c9:	mov    0x28(%rsp),%rdx
  37c0ce:	mov    0x18(%rsp),%r11
  37c0d3:	jmp    37c07d <<glass::engine::Watch>::print_utf8+0x1c7d>
  37c0d5:	mov    (%rsp),%rax
  37c0d9:	cmp    %eax,0x38(%r11)
  37c0dd:	jbe    37c0e3 <<glass::engine::Watch>::print_utf8+0x1ce3>
  37c0df:	mov    %eax,0x38(%r11)
  37c0e3:	test   %rdx,%rdx
  37c0e6:	mov    0x30(%rsp),%rsi
  37c0eb:	je     37c109 <<glass::engine::Watch>::print_utf8+0x1d09>
  37c0ed:	lock decq (%rdx)
  37c0f1:	jne    37c109 <<glass::engine::Watch>::print_utf8+0x1d09>
  37c0f3:	lea    0x40(%rsp),%rdi
  37c0f8:	mov    %rsi,%rbx
  37c0fb:	call   *0x7e00af(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c101:	mov    %rbx,%rsi
  37c104:	mov    0x18(%rsp),%r11
  37c109:	mov    0x10(%r11),%r14
  37c10d:	cmp    %r14,%rsi
  37c110:	lea    (%r15,%r12,1),%r14
  37c114:	jb     37c12d <<glass::engine::Watch>::print_utf8+0x1d2d>
  37c116:	mov    0x58(%rsp),%rdi
  37c11b:	call   2c0520 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  37c120:	mov    0x18(%rsp),%r11
  37c125:	movl   $0xffffffff,0x28(%r11)
  37c12d:	mov    0x30(%r11),%rax
  37c131:	lea    0x1(%r15),%rcx
  37c135:	cmp    %rax,%rcx
  37c138:	cmova  %rcx,%rax
  37c13c:	mov    0x10(%r11),%rsi
  37c140:	mov    %rax,0x30(%r11)
  37c144:	cmp    %rsi,%r15
  37c147:	jae    37c64a <<glass::engine::Watch>::print_utf8+0x224a>
  37c14d:	mov    0x68(%rsp),%esi
  37c151:	mov    %esi,%eax
  37c153:	or     $0x20,%eax
  37c156:	cmp    $0x2,%r12
  37c15a:	mov    0x8(%r11),%rcx
  37c15e:	lea    (%r15,%r15,2),%rdx
  37c162:	lea    (%rcx,%rdx,8),%rbx
  37c166:	mov    %ebp,0x10(%rcx,%rdx,8)
  37c16a:	mov    0x10(%rsp),%edi
  37c16e:	mov    %edi,0x8(%rcx,%rdx,8)
  37c172:	cmovne %esi,%eax
  37c175:	mov    0x60(%rsp),%esi
  37c179:	mov    %esi,0xc(%rcx,%rdx,8)
  37c17d:	mov    %ax,0x14(%rcx,%rdx,8)
  37c182:	mov    (%rcx,%rdx,8),%rax
  37c186:	test   %rax,%rax
  37c189:	je     37c19f <<glass::engine::Watch>::print_utf8+0x1d9f>
  37c18b:	lock decq (%rax)
  37c18f:	jne    37c19f <<glass::engine::Watch>::print_utf8+0x1d9f>
  37c191:	mov    %rbx,%rdi
  37c194:	call   *0x7e0016(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c19a:	mov    0x18(%rsp),%r11
  37c19f:	movq   $0x0,(%rbx)
  37c1a6:	cmp    $0x2,%r12
  37c1aa:	mov    0x98(%rsp),%r12
  37c1b2:	jne    37c4bd <<glass::engine::Watch>::print_utf8+0x20bd>
  37c1b8:	lea    0x1(%r15),%rdi
  37c1bc:	mov    0x30(%r11),%rbx
  37c1c0:	mov    0x28(%r11),%eax
  37c1c4:	cmp    %rbx,%rdi
  37c1c7:	jne    37c1f0 <<glass::engine::Watch>::print_utf8+0x1df0>
  37c1c9:	cmp    $0xffffffff,%eax
  37c1cc:	je     37c1f0 <<glass::engine::Watch>::print_utf8+0x1df0>
  37c1ce:	add    $0x2,%r15
  37c1d2:	mov    %r15,0x30(%r11)
  37c1d6:	mov    0x10(%r11),%rsi
  37c1da:	cmp    %rsi,%rdi
  37c1dd:	jb     37c46e <<glass::engine::Watch>::print_utf8+0x206e>
  37c1e3:	lea    0x796fa6(%rip),%rdx        # b13190 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5ed8>
  37c1ea:	call   *0x7dff58(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c1f0:	cmp    $0xffffffff,%eax
  37c1f3:	je     37c44e <<glass::engine::Watch>::print_utf8+0x204e>
  37c1f9:	mov    %r14,(%rsp)
  37c1fd:	mov    0x10(%r11),%r14
  37c201:	cmp    %rbx,%r14
  37c204:	mov    %rbx,%rcx
  37c207:	cmovb  %r14,%rcx
  37c20b:	cmp    %rdi,%r14
  37c20e:	mov    %rdi,%rsi
  37c211:	cmovb  %r14,%rsi
  37c215:	mov    0x7e0094(%rip),%rax        # b5c2b0 <_DYNAMIC+0x390>
  37c21c:	movzbl (%rax),%eax
  37c21f:	test   %al,%al
  37c221:	mov    %rsi,0x38(%rsp)
  37c226:	mov    %rcx,0x30(%rsp)
  37c22b:	je     37c265 <<glass::engine::Watch>::print_utf8+0x1e65>
  37c22d:	cmp    %rsi,%rbx
  37c230:	jae    37c23b <<glass::engine::Watch>::print_utf8+0x1e3b>
  37c232:	mov    0x7e009f(%rip),%rax        # b5c2d8 <_DYNAMIC+0x3b8>
  37c239:	jmp    37c242 <<glass::engine::Watch>::print_utf8+0x1e42>
  37c23b:	mov    0x7e008e(%rip),%rax        # b5c2d0 <_DYNAMIC+0x3b0>
  37c242:	lock incq 0x28(%rax)
  37c247:	mov    %rsi,%rdi
  37c24a:	sub    %rcx,%rdi
  37c24d:	call   401fd0 <alacritty_terminal::grid::row::fill_census::note>
  37c252:	mov    0x30(%rsp),%rcx
  37c257:	mov    0x38(%rsp),%rsi
  37c25c:	mov    0x18(%rsp),%r11
  37c261:	lea    0x1(%r15),%rdi
  37c265:	cmp    %rsi,%rbx
  37c268:	jae    37c42a <<glass::engine::Watch>::print_utf8+0x202a>
  37c26e:	mov    0x28(%r11),%edi
  37c272:	mov    0x20(%r11),%r8d
  37c276:	mov    0x24(%r11),%r9d
  37c27a:	movzwl 0x2c(%r11),%r10d
  37c27f:	mov    0x18(%r11),%r14
  37c283:	test   %r14,%r14
  37c286:	mov    %edi,0x28(%rsp)
  37c28a:	mov    %r8d,0x70(%rsp)
  37c28f:	mov    %r9d,0x8(%rsp)
  37c294:	mov    %r10w,0x20(%rsp)
  37c29a:	je     37c351 <<glass::engine::Watch>::print_utf8+0x1f51>
  37c2a0:	lock incq (%r14)
  37c2a4:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37c2aa:	mov    0x10(%r11),%rdx
  37c2ae:	mov    %edi,0x50(%rsp)
  37c2b2:	mov    %r8d,0x48(%rsp)
  37c2b7:	mov    %r9d,0x4c(%rsp)
  37c2bc:	mov    %r10w,0x54(%rsp)
  37c2c2:	mov    %r14,0x40(%rsp)
  37c2c7:	cmp    %rdx,%rsi
  37c2ca:	ja     37c5c6 <<glass::engine::Watch>::print_utf8+0x21c6>
  37c2d0:	lea    0x0(,%rcx,8),%rax
  37c2d8:	lea    (%rax,%rax,2),%rax
  37c2dc:	mov    0x8(%r11),%rbx
  37c2e0:	add    %rax,%rbx
  37c2e3:	lea    0x0(,%rsi,8),%rcx
  37c2eb:	lea    (%rcx,%rcx,2),%r12
  37c2ef:	sub    %rax,%r12
  37c2f2:	jmp    37c315 <<glass::engine::Watch>::print_utf8+0x1f15>
  37c2f4:	mov    %r14,(%rbx)
  37c2f7:	mov    %r8d,0x8(%rbx)
  37c2fb:	mov    %r9d,0xc(%rbx)
  37c2ff:	mov    %edi,0x10(%rbx)
  37c302:	mov    %r10w,0x14(%rbx)
  37c307:	add    $0x18,%rbx
  37c30b:	add    $0xffffffffffffffe8,%r12
  37c30f:	je     37c3e1 <<glass::engine::Watch>::print_utf8+0x1fe1>
  37c315:	lock incq (%r14)
  37c319:	jle    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37c31f:	mov    (%rbx),%rax
  37c322:	test   %rax,%rax
  37c325:	je     37c2f4 <<glass::engine::Watch>::print_utf8+0x1ef4>
  37c327:	lock decq (%rax)
  37c32b:	jne    37c2f4 <<glass::engine::Watch>::print_utf8+0x1ef4>
  37c32d:	mov    %rbx,%rdi
  37c330:	call   *0x7dfe7a(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c336:	movzwl 0x20(%rsp),%r10d
  37c33c:	mov    0x8(%rsp),%r9d
  37c341:	mov    0x70(%rsp),%r8d
  37c346:	mov    0x28(%rsp),%edi
  37c34a:	mov    0x18(%rsp),%r11
  37c34f:	jmp    37c2f4 <<glass::engine::Watch>::print_utf8+0x1ef4>
  37c351:	mov    %edi,0x50(%rsp)
  37c355:	mov    %r8d,0x48(%rsp)
  37c35a:	mov    %r9d,0x4c(%rsp)
  37c35f:	mov    %r10w,0x54(%rsp)
  37c365:	mov    %r14,0x40(%rsp)
  37c36a:	lea    0x0(,%rcx,8),%rax
  37c372:	lea    (%rax,%rax,2),%rax
  37c376:	mov    0x8(%r11),%rbx
  37c37a:	add    %rax,%rbx
  37c37d:	lea    0x0(,%rsi,8),%rcx
  37c385:	lea    (%rcx,%rcx,2),%r12
  37c389:	sub    %rax,%r12
  37c38c:	jmp    37c3af <<glass::engine::Watch>::print_utf8+0x1faf>
  37c38e:	movq   $0x0,(%rbx)
  37c395:	mov    %r8d,0x8(%rbx)
  37c399:	mov    %r9d,0xc(%rbx)
  37c39d:	mov    %edi,0x10(%rbx)
  37c3a0:	mov    %r10w,0x14(%rbx)
  37c3a5:	add    $0x18,%rbx
  37c3a9:	add    $0xffffffffffffffe8,%r12
  37c3ad:	je     37c3e1 <<glass::engine::Watch>::print_utf8+0x1fe1>
  37c3af:	mov    (%rbx),%rax
  37c3b2:	test   %rax,%rax
  37c3b5:	je     37c38e <<glass::engine::Watch>::print_utf8+0x1f8e>
  37c3b7:	lock decq (%rax)
  37c3bb:	jne    37c38e <<glass::engine::Watch>::print_utf8+0x1f8e>
  37c3bd:	mov    %rbx,%rdi
  37c3c0:	call   *0x7dfdea(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c3c6:	movzwl 0x20(%rsp),%r10d
  37c3cc:	mov    0x8(%rsp),%r9d
  37c3d1:	mov    0x70(%rsp),%r8d
  37c3d6:	mov    0x28(%rsp),%edi
  37c3da:	mov    0x18(%rsp),%r11
  37c3df:	jmp    37c38e <<glass::engine::Watch>::print_utf8+0x1f8e>
  37c3e1:	mov    0x30(%rsp),%rax
  37c3e6:	cmp    %eax,0x38(%r11)
  37c3ea:	jbe    37c3f0 <<glass::engine::Watch>::print_utf8+0x1ff0>
  37c3ec:	mov    %eax,0x38(%r11)
  37c3f0:	test   %r14,%r14
  37c3f3:	mov    0x98(%rsp),%r12
  37c3fb:	lea    0x1(%r15),%rdi
  37c3ff:	mov    0x38(%rsp),%rsi
  37c404:	je     37c426 <<glass::engine::Watch>::print_utf8+0x2026>
  37c406:	lock decq (%r14)
  37c40a:	jne    37c426 <<glass::engine::Watch>::print_utf8+0x2026>
  37c40c:	lea    0x40(%rsp),%rdi
  37c411:	mov    %rsi,%rbx
  37c414:	call   *0x7dfd96(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c41a:	mov    %rbx,%rsi
  37c41d:	lea    0x1(%r15),%rdi
  37c421:	mov    0x18(%rsp),%r11
  37c426:	mov    0x10(%r11),%r14
  37c42a:	cmp    %r14,%rsi
  37c42d:	mov    (%rsp),%r14
  37c431:	jb     37c44e <<glass::engine::Watch>::print_utf8+0x204e>
  37c433:	mov    0x58(%rsp),%rdi
  37c438:	call   2c0520 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  37c43d:	lea    0x1(%r15),%rdi
  37c441:	mov    0x18(%rsp),%r11
  37c446:	movl   $0xffffffff,0x28(%r11)
  37c44e:	mov    0x30(%r11),%rax
  37c452:	add    $0x2,%r15
  37c456:	cmp    %rax,%r15
  37c459:	cmovbe %rax,%r15
  37c45d:	mov    0x10(%r11),%rsi
  37c461:	mov    %r15,0x30(%r11)
  37c465:	cmp    %rsi,%rdi
  37c468:	jae    37c65a <<glass::engine::Watch>::print_utf8+0x225a>
  37c46e:	mov    0x8(%r11),%rax
  37c472:	lea    (%rdi,%rdi,2),%rcx
  37c476:	lea    (%rax,%rcx,8),%rbx
  37c47a:	movl   $0x20,0x10(%rax,%rcx,8)
  37c482:	mov    0x10(%rsp),%edx
  37c486:	mov    %edx,0x8(%rax,%rcx,8)
  37c48a:	mov    0x60(%rsp),%edx
  37c48e:	mov    %edx,0xc(%rax,%rcx,8)
  37c492:	mov    0x68(%rsp),%edx
  37c496:	or     $0x40,%edx
  37c499:	mov    %dx,0x14(%rax,%rcx,8)
  37c49e:	mov    (%rax,%rcx,8),%rax
  37c4a2:	test   %rax,%rax
  37c4a5:	je     37c4b6 <<glass::engine::Watch>::print_utf8+0x20b6>
  37c4a7:	lock decq (%rax)
  37c4ab:	jne    37c4b6 <<glass::engine::Watch>::print_utf8+0x20b6>
  37c4ad:	mov    %rbx,%rdi
  37c4b0:	call   *0x7dfcfa(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c4b6:	movq   $0x0,(%rbx)
  37c4bd:	cmp    0x80(%rsp),%r14
  37c4c5:	jb     37c4cf <<glass::engine::Watch>::print_utf8+0x20cf>
  37c4c7:	dec    %r14
  37c4ca:	movb   $0x1,0x6c(%r13)
  37c4cf:	mov    %r14,0x40(%r13)
  37c4d3:	incq   0xa0(%r12)
  37c4db:	mov    %ebp,0xb0(%r12)
  37c4e3:	jmp    37bdfd <<glass::engine::Watch>::print_utf8+0x19fd>
  37c4e8:	call   287a12 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  37c4ed:	mov    %ebp,%r14d
  37c4f0:	mov    0x7e6081(%rip),%rsi        # b62578 <glass::engine::width_of::CACHE+0x8>
  37c4f7:	cmp    %r14,%rsi
  37c4fa:	ja     37bca1 <<glass::engine::Watch>::print_utf8+0x18a1>
  37c500:	lea    0x797911(%rip),%rdx        # b13e18 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x6b60>
  37c507:	mov    %r14,%rdi
  37c50a:	call   *0x7dfc38(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c510:	lea    0x795c51(%rip),%rcx        # b12168 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x4eb0>
  37c517:	mov    0x88(%rsp),%rdi
  37c51f:	call   *0x7dfdcb(%rip)        # b5c2f0 <_DYNAMIC+0x3d0>
  37c525:	jmp    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37c52a:	lea    0x795c37(%rip),%rcx        # b12168 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x4eb0>
  37c531:	mov    0x90(%rsp),%rdi
  37c539:	call   *0x7dfdb1(%rip)        # b5c2f0 <_DYNAMIC+0x3d0>
  37c53f:	jmp    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37c544:	lea    0x796115(%rip),%rdx        # b12660 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x53a8>
  37c54b:	call   *0x7dfbf7(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c551:	lea    0x796120(%rip),%rax        # b12678 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x53c0>
  37c558:	jmp    37c579 <<glass::engine::Watch>::print_utf8+0x2179>
  37c55a:	lea    0x79615f(%rip),%rdx        # b126c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5408>
  37c561:	mov    %r14,%rdi
  37c564:	mov    0x30(%rsp),%rsi
  37c569:	call   *0x7dfbd9(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c56f:	mov    %rax,%r14
  37c572:	lea    0x796117(%rip),%rax        # b12690 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x53d8>
  37c579:	mov    %rax,0xc8(%rsp)
  37c581:	mov    %r14,%rdi
  37c584:	mov    0x30(%rsp),%rsi
  37c589:	mov    0xc8(%rsp),%rdx
  37c591:	call   *0x7dfbb1(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c597:	mov    %rcx,%rdi
  37c59a:	lea    0x795bc7(%rip),%rcx        # b12168 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x4eb0>
  37c5a1:	call   *0x7dfd49(%rip)        # b5c2f0 <_DYNAMIC+0x3d0>
  37c5a7:	jmp    37c5d6 <<glass::engine::Watch>::print_utf8+0x21d6>
  37c5a9:	lea    0x796230(%rip),%rdx        # b127e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5528>
  37c5b0:	call   *0x7dfb92(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c5b6:	lea    0x793bdb(%rip),%rdx        # b10198 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x2ee0>
  37c5bd:	mov    %r8,%rdi
  37c5c0:	call   *0x7dfb82(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c5c6:	mov    %rcx,%rdi
  37c5c9:	lea    0x795b98(%rip),%rcx        # b12168 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x4eb0>
  37c5d0:	call   *0x7dfd1a(%rip)        # b5c2f0 <_DYNAMIC+0x3d0>
  37c5d6:	ud2
  37c5d8:	lea    0x797511(%rip),%rdx        # b13af0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x6838>
  37c5df:	mov    $0xba,%esi
  37c5e4:	mov    %rax,%rdi
  37c5e7:	call   *0x7dfb5b(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c5ed:	lea    0x793ba4(%rip),%rdx        # b10198 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x2ee0>
  37c5f4:	call   *0x7dfb4e(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c5fa:	lea    0x796b8f(%rip),%rdx        # b13190 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5ed8>
  37c601:	mov    %r8,%rdi
  37c604:	call   *0x7dfb3e(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c60a:	lea    0x796b67(%rip),%rdx        # b13178 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5ec0>
  37c611:	mov    %r8,%rdi
  37c614:	call   *0x7dfb2e(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c61a:	lea    0x796b6f(%rip),%rdx        # b13190 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5ed8>
  37c621:	mov    %rbx,%rdi
  37c624:	call   *0x7dfb1e(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c62a:	lea    0x796b47(%rip),%rdx        # b13178 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5ec0>
  37c631:	mov    %rbx,%rdi
  37c634:	call   *0x7dfb0e(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c63a:	lea    0x793b57(%rip),%rdx        # b10198 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x2ee0>
  37c641:	mov    %r15,%rdi
  37c644:	call   *0x7dfafe(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c64a:	lea    0x796b27(%rip),%rdx        # b13178 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5ec0>
  37c651:	mov    %r15,%rdi
  37c654:	call   *0x7dfaee(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c65a:	lea    0x796b17(%rip),%rdx        # b13178 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x5ec0>
  37c661:	call   *0x7dfae1(%rip)        # b5c148 <_DYNAMIC+0x228>
  37c667:	mov    %rax,%rbx
  37c66a:	lock decq (%r14)
  37c66e:	je     37c697 <<glass::engine::Watch>::print_utf8+0x2297>
  37c670:	jmp    37c6a5 <<glass::engine::Watch>::print_utf8+0x22a5>
  37c672:	mov    %rax,%rbx
  37c675:	mov    0x28(%rsp),%rax
  37c67a:	jmp    37c691 <<glass::engine::Watch>::print_utf8+0x2291>
  37c67c:	mov    %rax,%rbx
  37c67f:	mov    0xb0(%rsp),%rax
  37c687:	jmp    37c691 <<glass::engine::Watch>::print_utf8+0x2291>
  37c689:	mov    %rax,%rbx
  37c68c:	mov    0x78(%rsp),%rax
  37c691:	lock decq (%rax)
  37c695:	jne    37c6a5 <<glass::engine::Watch>::print_utf8+0x22a5>
  37c697:	mov    0x100(%rsp),%rdi
  37c69f:	call   *0x7dfb0b(%rip)        # b5c1b0 <_DYNAMIC+0x290>
  37c6a5:	mov    %rbx,%rdi
  37c6a8:	call   b08290 <_Unwind_Resume@plt>
  37c6ad:	int3
  37c6ae:	int3
  37c6af:	int3

