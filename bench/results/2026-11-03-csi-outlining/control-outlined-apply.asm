
/tmp/glass-i26-control-outlined-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000258380 <<glass::engine::Engine>::apply>:
  258380:	push   %rbp
  258381:	push   %r15
  258383:	push   %r14
  258385:	push   %r13
  258387:	push   %r12
  258389:	push   %rbx
  25838a:	sub    $0x268,%rsp
  258391:	mov    %rdi,%r14
  258394:	testb  $0x10,0x6d5(%rdi)
  25839b:	jne    258404 <<glass::engine::Engine>::apply+0x84>
  25839d:	cmpb   $0x2,0x278(%r14)
  2583a5:	jne    258404 <<glass::engine::Engine>::apply+0x84>
  2583a7:	mov    0xb0(%r14),%rax
  2583ae:	dec    %rax
  2583b1:	movq   $0x0,0x250(%r14)
  2583bc:	movl   $0x0,0x258(%r14)
  2583c7:	movb   $0x0,0x260(%r14)
  2583cf:	mov    %rax,0x268(%r14)
  2583d6:	movl   $0x0,0x270(%r14)
  2583e1:	movb   $0x1,0x278(%r14)
  2583e9:	movb   $0x0,0x280(%r14)
  2583f1:	movq   $0x0,0xa60(%r14)
  2583fc:	movb   $0x1,0xa7d(%r14)
  258404:	test   %rdx,%rdx
  258407:	je     25a646 <<glass::engine::Engine>::apply+0x22c6>
  25840d:	lea    0x10(%r14),%rax
  258411:	mov    %rax,0x258(%rsp)
  258419:	lea    0x6f0(%r14),%rax
  258420:	mov    %rax,0x80(%rsp)
  258428:	lea    0x8e8(%r14),%rax
  25842f:	mov    %rax,0x250(%rsp)
  258437:	lea    0xa7e(%r14),%rax
  25843e:	mov    %rax,0x68(%rsp)
  258443:	lea    0x720(%r14),%rax
  25844a:	mov    %rax,0xe8(%rsp)
  258452:	lea    0x9a0(%r14),%rbx
  258459:	mov    %r14,0x20(%rsp)
  25845e:	mov    %rbx,0xd0(%rsp)
  258466:	jmp    258490 <<glass::engine::Engine>::apply+0x110>
  258468:	nopl   0x0(%rax,%rax,1)
  258470:	mov    0xe0(%rsp),%rsi
  258478:	mov    0x260(%rsp),%rdx
  258480:	sub    0x18(%rsp),%rdx
  258485:	mov    0x20(%rsp),%r14
  25848a:	je     25a646 <<glass::engine::Engine>::apply+0x22c6>
  258490:	cmp    $0x2000,%rdx
  258497:	mov    $0x2000,%eax
  25849c:	mov    %rdx,0x260(%rsp)
  2584a4:	cmovb  %rdx,%rax
  2584a8:	mov    %rax,0x18(%rsp)
  2584ad:	mov    0x6d4(%r14),%ebp
  2584b4:	mov    $0x1000,%eax
  2584b9:	and    %eax,%ebp
  2584bb:	mov    0xa58(%r14),%r11
  2584c2:	mov    $0x0,%r12d
  2584c8:	cmove  %r11,%r12
  2584cc:	mov    0xa68(%r14),%rax
  2584d3:	mov    %rax,%rcx
  2584d6:	cmove  %r11,%rcx
  2584da:	mov    %rcx,0x28(%rsp)
  2584df:	mov    0x910(%r14),%r13
  2584e6:	mov    $0x8,%ebx
  2584eb:	test   %r13,%r13
  2584ee:	mov    %rsi,0x30(%rsp)
  2584f3:	je     258551 <<glass::engine::Engine>::apply+0x1d1>
  2584f5:	mov    %r12,0x60(%rsp)
  2584fa:	mov    %r11,0x8(%rsp)
  2584ff:	mov    0x908(%r14),%r12
  258506:	lea    0x0(,%r13,8),%rax
  25850e:	lea    (%rax,%rax,2),%r15
  258512:	mov    $0x8,%esi
  258517:	mov    %r15,%rdi
  25851a:	call   *0x399468(%rip)        # 5f1988 <_DYNAMIC+0x228>
  258520:	test   %rax,%rax
  258523:	je     25a75b <<glass::engine::Engine>::apply+0x23db>
  258529:	mov    %rax,%rbx
  25852c:	mov    %rax,%rdi
  25852f:	mov    %r12,%rsi
  258532:	mov    %r15,%rdx
  258535:	call   *0x399455(%rip)        # 5f1990 <memcpy@GLIBC_2.14>
  25853b:	mov    0xa68(%r14),%rax
  258542:	mov    0x30(%rsp),%rsi
  258547:	mov    0x8(%rsp),%r11
  25854c:	mov    0x60(%rsp),%r12
  258551:	mov    0x18(%rsp),%r8
  258556:	mov    %rsi,%r15
  258559:	lea    (%rsi,%r8,1),%rdx
  25855d:	mov    0xa78(%r14),%ecx
  258564:	mov    0xa60(%r14),%r10
  25856b:	movzbl 0xa7d(%r14),%esi
  258573:	movzbl 0xa81(%r14),%edi
  25857b:	mov    0x258(%rsp),%r9
  258583:	mov    %r9,0x1c8(%rsp)
  25858b:	movq   $0x0,0x160(%rsp)
  258597:	movq   $0x8,0x168(%rsp)
  2585a3:	movq   $0x0,0x170(%rsp)
  2585af:	mov    %r13,0x178(%rsp)
  2585b7:	mov    %rbx,0x180(%rsp)
  2585bf:	mov    %r13,0x188(%rsp)
  2585c7:	mov    %r8,%r13
  2585ca:	mov    0x28(%rsp),%r8
  2585cf:	mov    %r8,0x1d0(%rsp)
  2585d7:	mov    %r12,0x1d8(%rsp)
  2585df:	shr    $0xc,%ebp
  2585e2:	mov    %bpl,0x20c(%rsp)
  2585ea:	mov    %rax,0x1e0(%rsp)
  2585f2:	mov    %ecx,0x208(%rsp)
  2585f9:	mov    %r10,0x1e8(%rsp)
  258601:	mov    %sil,0x20d(%rsp)
  258609:	mov    %r13,0x1f0(%rsp)
  258611:	movups (%r14),%xmm0
  258615:	movaps %xmm0,0x150(%rsp)
  25861d:	movq   $0xffffffffffffffff,0x190(%rsp)
  258629:	mov    %r11,0x1f8(%rsp)
  258631:	mov    %dil,0x20e(%rsp)
  258639:	mov    0xa70(%r14),%rax
  258640:	mov    %rax,0x200(%rsp)
  258648:	test   %dil,%dil
  25864b:	mov    %rdx,0xe0(%rsp)
  258653:	je     25a0a0 <<glass::engine::Engine>::apply+0x1d20>
  258659:	mov    $0x1,%cl
  25865b:	xor    %ebp,%ebp
  25865d:	mov    %r15,%rsi
  258660:	mov    %r15,0x220(%rsp)
  258668:	mov    $0x1,%al
  25866a:	mov    %eax,0x100(%rsp)
  258671:	movq   $0x0,0x8(%rsp)
  25867a:	movl   $0x0,0x88(%rsp)
  258685:	movq   $0x0,0x60(%rsp)
  25868e:	xor    %r13d,%r13d
  258691:	jmp    2586c5 <<glass::engine::Engine>::apply+0x345>
  258693:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2586a0:	movl   $0x0,0x88(%rsp)
  2586ab:	mov    0x30(%rsp),%rsi
  2586b0:	mov    0x28(%rsp),%r8
  2586b5:	add    %r8,%r12
  2586b8:	mov    %r13,%rbp
  2586bb:	mov    %r12,%r13
  2586be:	mov    0x104(%rsp),%ecx
  2586c5:	test   $0x1,%cl
  2586c8:	je     258720 <<glass::engine::Engine>::apply+0x3a0>
  2586ca:	mov    0x399b4f(%rip),%rax        # 5f2220 <_DYNAMIC+0xac0>
  2586d1:	mov    (%rax),%rax
  2586d4:	mov    $0x1b,%edi
  2586d9:	mov    0x220(%rsp),%rsi
  2586e1:	mov    0xe0(%rsp),%rdx
  2586e9:	call   *%rax
  2586eb:	cmp    $0x1,%rax
  2586ef:	mov    0x30(%rsp),%rsi
  2586f4:	jne    258720 <<glass::engine::Engine>::apply+0x3a0>
  2586f6:	mov    %rdx,%r8
  2586f9:	sub    %rsi,%r8
  2586fc:	inc    %rdx
  2586ff:	mov    $0x1,%al
  258701:	mov    %eax,0x104(%rsp)
  258708:	mov    %rdx,0x220(%rsp)
  258710:	jmp    258749 <<glass::engine::Engine>::apply+0x3c9>
  258712:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258720:	testb  $0x1,0x100(%rsp)
  258728:	je     25a100 <<glass::engine::Engine>::apply+0x1d80>
  25872e:	movl   $0x0,0x100(%rsp)
  258739:	mov    0x18(%rsp),%r8
  25873e:	movl   $0x0,0x104(%rsp)
  258749:	mov    %r8,%rax
  25874c:	sub    %r13,%rax
  25874f:	cmp    $0x18,%rax
  258753:	mov    %r8,0x28(%rsp)
  258758:	jb     258de0 <<glass::engine::Engine>::apply+0xa60>
  25875e:	cmp    %r8,0x18(%rsp)
  258763:	jb     25a6b1 <<glass::engine::Engine>::apply+0x2331>
  258769:	nopl   0x0(%rax)
  258770:	lea    0x110(%rsp),%rdi
  258778:	mov    %r8,%rdx
  25877b:	mov    %r13,%rcx
  25877e:	call   2a18d0 <glass::engine::next_run>
  258783:	movzbl 0x120(%rsp),%r14d
  25878c:	cmp    $0x2,%r14b
  258790:	je     258e00 <<glass::engine::Engine>::apply+0xa80>
  258796:	mov    0x110(%rsp),%rbx
  25879e:	cmp    %rbp,%rbx
  2587a1:	mov    0x30(%rsp),%rax
  2587a6:	jb     25a667 <<glass::engine::Engine>::apply+0x22e7>
  2587ac:	mov    0x18(%rsp),%r13
  2587b1:	cmp    %r13,%rbx
  2587b4:	ja     25a678 <<glass::engine::Engine>::apply+0x22f8>
  2587ba:	mov    0x118(%rsp),%r13
  2587c2:	lea    (%rax,%rbp,1),%r12
  2587c6:	lea    (%rax,%rbx,1),%r15
  2587ca:	mov    0x399a47(%rip),%rax        # 5f2218 <_DYNAMIC+0xab8>
  2587d1:	mov    (%rax),%rax
  2587d4:	mov    $0x1b,%edi
  2587d9:	mov    %r12,%rsi
  2587dc:	mov    %r15,%rdx
  2587df:	call   *%rax
  2587e1:	cmp    $0x1,%rax
  2587e5:	jne    258803 <<glass::engine::Engine>::apply+0x483>
  2587e7:	sub    %r12,%rdx
  2587ea:	mov    0x20(%rsp),%rax
  2587ef:	movb   $0x1,0xa80(%rax)
  2587f6:	movb   $0x0,0xa7e(%rax)
  2587fd:	add    %rdx,%rbp
  258800:	inc    %rbp
  258803:	cmp    %rbx,%rbp
  258806:	jae    258844 <<glass::engine::Engine>::apply+0x4c4>
  258808:	mov    0x68(%rsp),%rdi
  25880d:	mov    0x30(%rsp),%rsi
  258812:	mov    0x18(%rsp),%rdx
  258817:	mov    %rbp,%rcx
  25881a:	mov    %rbx,%r8
  25881d:	call   26ff50 <<glass::engine::Mirror>::stretch>
  258822:	cmp    %rbx,%rax
  258825:	jae    258844 <<glass::engine::Engine>::apply+0x4c4>
  258827:	mov    0x20(%rsp),%rax
  25882c:	cmpb   $0x0,0xa80(%rax)
  258833:	jne    258844 <<glass::engine::Engine>::apply+0x4c4>
  258835:	movzbl -0x1(%r15),%eax
  25883a:	shr    $0x7,%al
  25883d:	mov    0x68(%rsp),%rcx
  258842:	mov    %al,(%rcx)
  258844:	mov    0x68(%rsp),%rdi
  258849:	mov    0x30(%rsp),%rsi
  25884e:	mov    0x18(%rsp),%rdx
  258853:	mov    %rbx,%rcx
  258856:	mov    %r13,%r8
  258859:	call   26ff50 <<glass::engine::Mirror>::stretch>
  25885e:	mov    %rax,%r15
  258861:	mov    0x20(%rsp),%rax
  258866:	cmpb   $0x0,0xa80(%rax)
  25886d:	je     2588a0 <<glass::engine::Engine>::apply+0x520>
  25886f:	mov    0x20(%rsp),%r14
  258874:	mov    0x28(%rsp),%rax
  258879:	sub    %r13,%rax
  25887c:	mov    %r13,%rbp
  25887f:	cmp    $0x17,%rax
  258883:	mov    0x28(%rsp),%r8
  258888:	mov    0x30(%rsp),%rsi
  25888d:	ja     258770 <<glass::engine::Engine>::apply+0x3f0>
  258893:	jmp    258de3 <<glass::engine::Engine>::apply+0xa63>
  258898:	nopl   0x0(%rax,%rax,1)
  2588a0:	lea    -0x1(%r13),%rsi
  2588a4:	cmp    0x18(%rsp),%rsi
  2588a9:	jae    25a738 <<glass::engine::Engine>::apply+0x23b8>
  2588af:	mov    0x30(%rsp),%rax
  2588b4:	movzbl (%rax,%rsi,1),%eax
  2588b8:	shr    $0x7,%al
  2588bb:	mov    0x68(%rsp),%rcx
  2588c0:	mov    %al,(%rcx)
  2588c2:	test   %r15,%r15
  2588c5:	je     2588f3 <<glass::engine::Engine>::apply+0x573>
  2588c7:	lea    -0x1(%r15),%rsi
  2588cb:	cmp    0x18(%rsp),%rsi
  2588d0:	jae    25a741 <<glass::engine::Engine>::apply+0x23c1>
  2588d6:	mov    0x30(%rsp),%rax
  2588db:	movzbl (%rax,%rsi,1),%eax
  2588df:	shr    $0x7,%al
  2588e2:	mov    %r13,%rbx
  2588e5:	sub    %r15,%rbx
  2588e8:	cmp    $0x18,%rbx
  2588ec:	jae    25890f <<glass::engine::Engine>::apply+0x58f>
  2588ee:	jmp    25886f <<glass::engine::Engine>::apply+0x4ef>
  2588f3:	mov    0x20(%rsp),%rax
  2588f8:	movzbl 0xa7f(%rax),%eax
  2588ff:	mov    %r13,%rbx
  258902:	sub    %r15,%rbx
  258905:	cmp    $0x18,%rbx
  258909:	jb     25886f <<glass::engine::Engine>::apply+0x4ef>
  25890f:	test   %al,%al
  258911:	jne    25886f <<glass::engine::Engine>::apply+0x4ef>
  258917:	mov    %r15,%r12
  25891a:	sub    0x8(%rsp),%r12
  25891f:	jbe    258a46 <<glass::engine::Engine>::apply+0x6c6>
  258925:	movzbl 0x39f30c(%rip),%eax        # 5f7c38 <glass::engine::probes::RUN_PROBE>
  25892c:	mov    $0x1,%bpl
  25892f:	cmp    $0x68,%al
  258931:	je     258b0a <<glass::engine::Engine>::apply+0x78a>
  258937:	cmp    0x18(%rsp),%r15
  25893c:	ja     25a6e1 <<glass::engine::Engine>::apply+0x2361>
  258942:	mov    0x8(%rsp),%rax
  258947:	add    0x30(%rsp),%rax
  25894c:	mov    %rax,0x8(%rsp)
  258951:	cmpb   $0x1,0x60(%rsp)
  258956:	jne    258983 <<glass::engine::Engine>::apply+0x603>
  258958:	mov    0x20(%rsp),%rax
  25895d:	cmpl   $0xffffffff,0x710(%rax)
  258964:	jne    258983 <<glass::engine::Engine>::apply+0x603>
  258966:	lea    0x150(%rsp),%rdi
  25896e:	mov    0x8(%rsp),%rsi
  258973:	mov    %r12,%rdx
  258976:	call   2a1bc0 <glass::engine::plain_c0>
  25897b:	test   %al,%al
  25897d:	jne    258b0a <<glass::engine::Engine>::apply+0x78a>
  258983:	movzbl 0x39f2be(%rip),%eax        # 5f7c48 <glass::engine::timers::ON>
  25898a:	test   %al,%al
  25898c:	je     258bef <<glass::engine::Engine>::apply+0x86f>
  258992:	mov    $0x1,%edi
  258997:	call   50ea60 <<std::sys::pal::unix::time::Timespec>::now>
  25899c:	mov    %rax,0x60(%rsp)
  2589a1:	mov    %edx,0x38(%rsp)
  2589a5:	xor    %ebp,%ebp
  2589a7:	nopw   0x0(%rax,%rax,1)
  2589b0:	mov    0x20(%rsp),%rax
  2589b5:	cmpl   $0xffffffff,0x710(%rax)
  2589bc:	jne    258a1a <<glass::engine::Engine>::apply+0x69a>
  2589be:	mov    0x80(%rsp),%rax
  2589c6:	mov    %rax,0x90(%rsp)
  2589ce:	lea    0x150(%rsp),%rax
  2589d6:	mov    %rax,0x98(%rsp)
  2589de:	movb   $0x0,0xa0(%rsp)
  2589e6:	mov    %r12,%rcx
  2589e9:	sub    %rbp,%rcx
  2589ec:	jb     25a658 <<glass::engine::Engine>::apply+0x22d8>
  2589f2:	mov    0x8(%rsp),%rax
  2589f7:	lea    (%rax,%rbp,1),%rdx
  2589fb:	mov    0xe8(%rsp),%rdi
  258a03:	lea    0x90(%rsp),%rsi
  258a0b:	call   1a06b0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258a10:	add    %rax,%rbp
  258a13:	cmp    %r12,%rbp
  258a16:	jne    2589b0 <<glass::engine::Engine>::apply+0x630>
  258a18:	jmp    258a6b <<glass::engine::Engine>::apply+0x6eb>
  258a1a:	mov    %r12,%rcx
  258a1d:	sub    %rbp,%rcx
  258a20:	jb     25a77c <<glass::engine::Engine>::apply+0x23fc>
  258a26:	mov    0x8(%rsp),%rax
  258a2b:	lea    (%rax,%rbp,1),%rdx
  258a2f:	mov    0x80(%rsp),%rdi
  258a37:	lea    0x150(%rsp),%rsi
  258a3f:	call   194410 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258a44:	jmp    258a10 <<glass::engine::Engine>::apply+0x690>
  258a46:	mov    0x60(%rsp),%rax
  258a4b:	mov    %eax,%ebp
  258a4d:	mov    0x20(%rsp),%rax
  258a52:	cmpl   $0xffffffff,0x710(%rax)
  258a59:	je     258b21 <<glass::engine::Engine>::apply+0x7a1>
  258a5f:	mov    %ebp,%eax
  258a61:	mov    %rax,0x60(%rsp)
  258a66:	jmp    25886f <<glass::engine::Engine>::apply+0x4ef>
  258a6b:	movzbl 0x39f1d6(%rip),%eax        # 5f7c48 <glass::engine::timers::ON>
  258a72:	test   %al,%al
  258a74:	mov    $0x1,%bpl
  258a77:	je     258b0a <<glass::engine::Engine>::apply+0x78a>
  258a7d:	mov    $0x1,%edi
  258a82:	call   50ea60 <<std::sys::pal::unix::time::Timespec>::now>
  258a87:	mov    %rax,0x228(%rsp)
  258a8f:	mov    %edx,0x230(%rsp)
  258a96:	mov    0x60(%rsp),%rax
  258a9b:	mov    %rax,0x238(%rsp)
  258aa3:	mov    0x38(%rsp),%eax
  258aa7:	mov    %eax,0x240(%rsp)
  258aae:	lea    0x90(%rsp),%rdi
  258ab6:	lea    0x228(%rsp),%rsi
  258abe:	lea    0x238(%rsp),%rdx
  258ac6:	call   50e9a0 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258acb:	imul   $0x3b9aca00,0x98(%rsp),%rax
  258ad7:	mov    0xa0(%rsp),%ecx
  258ade:	add    %rcx,%rax
  258ae1:	cmpb   $0x0,0x90(%rsp)
  258ae9:	mov    $0x0,%ecx
  258aee:	cmove  %rax,%rcx
  258af2:	lock add %rcx,0x39f15e(%rip)        # 5f7c58 <glass::engine::timers::VTE_NS>
  258afa:	lock incq 0x39f186(%rip)        # 5f7c88 <glass::engine::timers::VTE_CALLS>
  258b02:	lock add %r12,0x39f176(%rip)        # 5f7c80 <glass::engine::timers::VTE_BYTES>
  258b0a:	mov    %r15,0x8(%rsp)
  258b0f:	mov    0x20(%rsp),%rax
  258b14:	cmpl   $0xffffffff,0x710(%rax)
  258b1b:	jne    258a5f <<glass::engine::Engine>::apply+0x6df>
  258b21:	cmp    0x18(%rsp),%r13
  258b26:	ja     25a6a2 <<glass::engine::Engine>::apply+0x2322>
  258b2c:	cmp    %r15,%r13
  258b2f:	jb     25a6a2 <<glass::engine::Engine>::apply+0x2322>
  258b35:	movzbl 0x39f0fb(%rip),%r12d        # 5f7c38 <glass::engine::probes::RUN_PROBE>
  258b3d:	movzbl 0x39f104(%rip),%eax        # 5f7c48 <glass::engine::timers::ON>
  258b44:	test   %al,%al
  258b46:	je     258b7c <<glass::engine::Engine>::apply+0x7fc>
  258b48:	mov    $0x1,%edi
  258b4d:	call   50ea60 <<std::sys::pal::unix::time::Timespec>::now>
  258b52:	mov    %rax,0x60(%rsp)
  258b57:	mov    %edx,%ebp
  258b59:	cmp    $0x63,%r12b
  258b5d:	jbe    258b87 <<glass::engine::Engine>::apply+0x807>
  258b5f:	movzbl %r14b,%eax
  258b63:	mov    %rbx,%r15
  258b66:	sub    %rax,%r15
  258b69:	mov    0x20(%rsp),%r14
  258b6e:	cmp    $0xffffffff,%ebp
  258b71:	jne    258d06 <<glass::engine::Engine>::apply+0x986>
  258b77:	jmp    258da3 <<glass::engine::Engine>::apply+0xa23>
  258b7c:	mov    $0xffffffff,%ebp
  258b81:	cmp    $0x63,%r12b
  258b85:	ja     258b5f <<glass::engine::Engine>::apply+0x7df>
  258b87:	mov    0x39bdb3(%rip),%eax        # 5f4940 <glass::engine::run_whole::ON>
  258b8d:	test   %eax,%eax
  258b8f:	jne    258dc7 <<glass::engine::Engine>::apply+0xa47>
  258b95:	mov    0x30(%rsp),%rax
  258b9a:	lea    (%rax,%r15,1),%rsi
  258b9e:	cmpb   $0x0,0x39bd9f(%rip)        # 5f4944 <glass::engine::run_whole::ON+0x4>
  258ba5:	je     258bc6 <<glass::engine::Engine>::apply+0x846>
  258ba7:	test   $0x1,%r14b
  258bab:	je     258cb5 <<glass::engine::Engine>::apply+0x935>
  258bb1:	lea    0x150(%rsp),%rdi
  258bb9:	mov    %rbx,%rdx
  258bbc:	call   264d10 <<glass::engine::Watch>::print_run>
  258bc1:	jmp    258cc5 <<glass::engine::Engine>::apply+0x945>
  258bc6:	test   $0x1,%r14b
  258bca:	je     258ce5 <<glass::engine::Engine>::apply+0x965>
  258bd0:	cmp    %r15,%r13
  258bd3:	je     25a6f5 <<glass::engine::Engine>::apply+0x2375>
  258bd9:	lea    -0x1(%rbx),%rdx
  258bdd:	lea    0x150(%rsp),%rdi
  258be5:	call   264d10 <<glass::engine::Watch>::print_run>
  258bea:	jmp    258cf5 <<glass::engine::Engine>::apply+0x975>
  258bef:	xor    %ebp,%ebp
  258bf1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258c00:	mov    0x20(%rsp),%rax
  258c05:	cmpl   $0xffffffff,0x710(%rax)
  258c0c:	jne    258c6a <<glass::engine::Engine>::apply+0x8ea>
  258c0e:	mov    0x80(%rsp),%rax
  258c16:	mov    %rax,0x90(%rsp)
  258c1e:	lea    0x150(%rsp),%rax
  258c26:	mov    %rax,0x98(%rsp)
  258c2e:	movb   $0x0,0xa0(%rsp)
  258c36:	mov    %r12,%rcx
  258c39:	sub    %rbp,%rcx
  258c3c:	jb     25a658 <<glass::engine::Engine>::apply+0x22d8>
  258c42:	mov    0x8(%rsp),%rax
  258c47:	lea    (%rax,%rbp,1),%rdx
  258c4b:	mov    0xe8(%rsp),%rdi
  258c53:	lea    0x90(%rsp),%rsi
  258c5b:	call   1a06b0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258c60:	add    %rax,%rbp
  258c63:	cmp    %r12,%rbp
  258c66:	jne    258c00 <<glass::engine::Engine>::apply+0x880>
  258c68:	jmp    258c96 <<glass::engine::Engine>::apply+0x916>
  258c6a:	mov    %r12,%rcx
  258c6d:	sub    %rbp,%rcx
  258c70:	jb     25a77c <<glass::engine::Engine>::apply+0x23fc>
  258c76:	mov    0x8(%rsp),%rax
  258c7b:	lea    (%rax,%rbp,1),%rdx
  258c7f:	mov    0x80(%rsp),%rdi
  258c87:	lea    0x150(%rsp),%rsi
  258c8f:	call   194410 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258c94:	jmp    258c60 <<glass::engine::Engine>::apply+0x8e0>
  258c96:	mov    %r15,0x8(%rsp)
  258c9b:	mov    $0x1,%bpl
  258c9e:	mov    0x20(%rsp),%rax
  258ca3:	cmpl   $0xffffffff,0x710(%rax)
  258caa:	jne    258a5f <<glass::engine::Engine>::apply+0x6df>
  258cb0:	jmp    258b21 <<glass::engine::Engine>::apply+0x7a1>
  258cb5:	lea    0x150(%rsp),%rdi
  258cbd:	mov    %rbx,%rdx
  258cc0:	call   262370 <<glass::engine::Watch>::print_utf8>
  258cc5:	mov    %rax,%r15
  258cc8:	mov    0x200(%rsp),%eax
  258ccf:	mov    0x20(%rsp),%r14
  258cd4:	mov    %eax,0x718(%r14)
  258cdb:	cmp    $0xffffffff,%ebp
  258cde:	jne    258d06 <<glass::engine::Engine>::apply+0x986>
  258ce0:	jmp    258da3 <<glass::engine::Engine>::apply+0xa23>
  258ce5:	lea    0x150(%rsp),%rdi
  258ced:	mov    %rbx,%rdx
  258cf0:	call   262370 <<glass::engine::Watch>::print_utf8>
  258cf5:	mov    %rax,%r15
  258cf8:	mov    0x20(%rsp),%r14
  258cfd:	cmp    $0xffffffff,%ebp
  258d00:	je     258da3 <<glass::engine::Engine>::apply+0xa23>
  258d06:	movzbl 0x39ef3b(%rip),%eax        # 5f7c48 <glass::engine::timers::ON>
  258d0d:	test   %al,%al
  258d0f:	je     258d9b <<glass::engine::Engine>::apply+0xa1b>
  258d15:	mov    $0x1,%edi
  258d1a:	call   50ea60 <<std::sys::pal::unix::time::Timespec>::now>
  258d1f:	mov    %rax,0x228(%rsp)
  258d27:	mov    %edx,0x230(%rsp)
  258d2e:	mov    0x60(%rsp),%rax
  258d33:	mov    %rax,0x238(%rsp)
  258d3b:	mov    %ebp,0x240(%rsp)
  258d42:	lea    0x90(%rsp),%rdi
  258d4a:	lea    0x228(%rsp),%rsi
  258d52:	lea    0x238(%rsp),%rdx
  258d5a:	call   50e9a0 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258d5f:	imul   $0x3b9aca00,0x98(%rsp),%rax
  258d6b:	mov    0xa0(%rsp),%ecx
  258d72:	add    %rcx,%rax
  258d75:	cmpb   $0x0,0x90(%rsp)
  258d7d:	mov    $0x0,%ecx
  258d82:	cmove  %rax,%rcx
  258d86:	lock add %rcx,0x39eec2(%rip)        # 5f7c50 <glass::engine::timers::RUN_NS>
  258d8e:	lock incq 0x39eee2(%rip)        # 5f7c78 <glass::engine::timers::RUN_CALLS>
  258d96:	mov    0x20(%rsp),%r14
  258d9b:	lock add %rbx,0x39eecd(%rip)        # 5f7c70 <glass::engine::timers::RUN_BYTES>
  258da3:	movzbl 0x39eeee(%rip),%eax        # 5f7c98 <glass::engine::counters::COUNTING>
  258daa:	test   %al,%al
  258dac:	je     258db6 <<glass::engine::Engine>::apply+0xa36>
  258dae:	lock add %r15,0x39eeda(%rip)        # 5f7c90 <glass::engine::counters::LANE_RUN_BYTES>
  258db6:	add    %r15,0x8(%rsp)
  258dbb:	mov    $0x1,%al
  258dbd:	mov    %rax,0x60(%rsp)
  258dc2:	jmp    258874 <<glass::engine::Engine>::apply+0x4f4>
  258dc7:	call   18ba46 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  258dcc:	jmp    258b95 <<glass::engine::Engine>::apply+0x815>
  258dd1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258de0:	mov    %rbp,%r13
  258de3:	mov    $0x1,%r12d
  258de9:	mov    0x18(%rsp),%rdx
  258dee:	sub    %r8,%rdx
  258df1:	jbe    2586b5 <<glass::engine::Engine>::apply+0x335>
  258df7:	jmp    258e26 <<glass::engine::Engine>::apply+0xaa6>
  258df9:	nopl   0x0(%rax)
  258e00:	mov    %rbp,%r13
  258e03:	mov    0x20(%rsp),%r14
  258e08:	mov    0x30(%rsp),%rsi
  258e0d:	mov    0x28(%rsp),%r8
  258e12:	mov    $0x1,%r12d
  258e18:	mov    0x18(%rsp),%rdx
  258e1d:	sub    %r8,%rdx
  258e20:	jbe    2586b5 <<glass::engine::Engine>::apply+0x335>
  258e26:	mov    0x8(%rsp),%rax
  258e2b:	cmp    %rax,0xd8(%rsp)
  258e33:	sete   %bpl
  258e37:	lea    (%rsi,%r8,1),%rbx
  258e3b:	lea    0x90(%rsp),%rdi
  258e43:	mov    %rbx,%rsi
  258e46:	call   2a1700 <glass::engine::simple>
  258e4b:	movzbl 0xc1(%rsp),%r8d
  258e54:	cmp    $0x2,%r8b
  258e58:	je     2586a0 <<glass::engine::Engine>::apply+0x320>
  258e5e:	mov    0x90(%rsp),%rsi
  258e66:	mov    0xb8(%rsp),%rdi
  258e6e:	lea    0x98(%rsp),%rcx
  258e76:	movups (%rcx),%xmm0
  258e79:	movups 0x10(%rcx),%xmm1
  258e7d:	movaps %xmm1,0x120(%rsp)
  258e85:	movaps %xmm0,0x110(%rsp)
  258e8d:	movzbl 0xc0(%rsp),%r9d
  258e96:	movzwl 0x2e(%rcx),%eax
  258e9a:	lea    0x13a(%rsp),%rdx
  258ea2:	mov    %ax,0x4(%rdx)
  258ea6:	mov    0x2a(%rcx),%eax
  258ea9:	mov    %eax,(%rdx)
  258eab:	mov    %rdi,0x130(%rsp)
  258eb3:	mov    %r9b,0x5e(%rsp)
  258eb8:	mov    %r9b,0x138(%rsp)
  258ec0:	mov    %r8b,0x139(%rsp)
  258ec8:	cmp    %r13,0x28(%rsp)
  258ecd:	mov    0x30(%rsp),%rax
  258ed2:	jb     25a6cb <<glass::engine::Engine>::apply+0x234b>
  258ed8:	mov    %r8b,0x5f(%rsp)
  258edd:	mov    %rdi,0x38(%rsp)
  258ee2:	mov    %rsi,0x218(%rsp)
  258eea:	lea    (%rax,%r13,1),%r15
  258eee:	mov    0x399323(%rip),%rax        # 5f2218 <_DYNAMIC+0xab8>
  258ef5:	mov    (%rax),%rax
  258ef8:	mov    $0x1b,%edi
  258efd:	mov    %r15,%rsi
  258f00:	mov    %rbx,%rdx
  258f03:	call   *%rax
  258f05:	cmp    $0x1,%rax
  258f09:	jne    258f24 <<glass::engine::Engine>::apply+0xba4>
  258f0b:	sub    %r15,%rdx
  258f0e:	movb   $0x1,0xa80(%r14)
  258f16:	movb   $0x0,0xa7e(%r14)
  258f1e:	add    %rdx,%r13
  258f21:	inc    %r13
  258f24:	mov    0x30(%rsp),%rsi
  258f29:	mov    0x28(%rsp),%r8
  258f2e:	cmp    %r8,%r13
  258f31:	jae    258f7d <<glass::engine::Engine>::apply+0xbfd>
  258f33:	mov    0x68(%rsp),%rdi
  258f38:	mov    0x18(%rsp),%rdx
  258f3d:	mov    %r13,%rcx
  258f40:	call   26ff50 <<glass::engine::Mirror>::stretch>
  258f45:	movzbl 0xa80(%r14),%ecx
  258f4d:	test   %cl,%cl
  258f4f:	setne  %dl
  258f52:	mov    0x28(%rsp),%r8
  258f57:	cmp    %r8,%rax
  258f5a:	setae  %al
  258f5d:	or     %dl,%al
  258f5f:	mov    0x30(%rsp),%rsi
  258f64:	jne    258f85 <<glass::engine::Engine>::apply+0xc05>
  258f66:	movzbl -0x1(%rbx),%eax
  258f6a:	shr    $0x7,%al
  258f6d:	mov    0x68(%rsp),%rcx
  258f72:	mov    %al,(%rcx)
  258f74:	test   %al,%al
  258f76:	jne    258f9d <<glass::engine::Engine>::apply+0xc1d>
  258f78:	jmp    259085 <<glass::engine::Engine>::apply+0xd05>
  258f7d:	movzbl 0xa80(%r14),%ecx
  258f85:	test   %cl,%cl
  258f87:	jne    259300 <<glass::engine::Engine>::apply+0xf80>
  258f8d:	mov    0x68(%rsp),%rax
  258f92:	movzbl (%rax),%eax
  258f95:	test   %al,%al
  258f97:	je     259085 <<glass::engine::Engine>::apply+0xd05>
  258f9d:	mov    0x28(%rsp),%r8
  258fa2:	test   %r8,%r8
  258fa5:	je     259300 <<glass::engine::Engine>::apply+0xf80>
  258fab:	cmpb   $0xc0,-0x1(%rbx)
  258faf:	jge    258ff8 <<glass::engine::Engine>::apply+0xc78>
  258fb1:	cmp    $0x1,%r8
  258fb5:	je     259300 <<glass::engine::Engine>::apply+0xf80>
  258fbb:	cmpb   $0xbf,-0x2(%rbx)
  258fbf:	jg     25913d <<glass::engine::Engine>::apply+0xdbd>
  258fc5:	cmp    $0x2,%r8
  258fc9:	je     259300 <<glass::engine::Engine>::apply+0xf80>
  258fcf:	cmpb   $0xbf,-0x3(%rbx)
  258fd3:	jg     2598b1 <<glass::engine::Engine>::apply+0x1531>
  258fd9:	cmp    $0x3,%r8
  258fdd:	je     259300 <<glass::engine::Engine>::apply+0xf80>
  258fe3:	cmpb   $0xc0,-0x4(%rbx)
  258fe7:	setl   %al
  258fea:	mov    $0x3,%edx
  258fef:	test   %al,%al
  258ff1:	je     259004 <<glass::engine::Engine>::apply+0xc84>
  258ff3:	jmp    259133 <<glass::engine::Engine>::apply+0xdb3>
  258ff8:	xor    %edx,%edx
  258ffa:	xor    %eax,%eax
  258ffc:	test   %al,%al
  258ffe:	jne    259133 <<glass::engine::Engine>::apply+0xdb3>
  259004:	mov    %rsi,%r8
  259007:	mov    %rdx,%rsi
  25900a:	not    %rsi
  25900d:	add    0x28(%rsp),%rsi
  259012:	jae    25a769 <<glass::engine::Engine>::apply+0x23e9>
  259018:	movzbl (%r8,%rsi,1),%eax
  25901d:	mov    $0x1,%ecx
  259022:	test   %al,%al
  259024:	jns    259054 <<glass::engine::Engine>::apply+0xcd4>
  259026:	lea    0x3e(%rax),%edi
  259029:	mov    $0x2,%ecx
  25902e:	cmp    $0x1e,%dil
  259032:	jb     259054 <<glass::engine::Engine>::apply+0xcd4>
  259034:	mov    %eax,%edi
  259036:	and    $0xf0,%dil
  25903a:	mov    $0x3,%ecx
  25903f:	cmp    $0xe0,%dil
  259043:	je     259054 <<glass::engine::Engine>::apply+0xcd4>
  259045:	add    $0x10,%al
  259047:	mov    $0x4,%ecx
  25904c:	cmp    $0x4,%al
  25904e:	ja     259130 <<glass::engine::Engine>::apply+0xdb0>
  259054:	inc    %rdx
  259057:	cmp    %ecx,%edx
  259059:	jne    259130 <<glass::engine::Engine>::apply+0xdb0>
  25905f:	mov    %r8,%rbx
  259062:	add    %r8,%rsi
  259065:	lea    0x90(%rsp),%rdi
  25906d:	call   *0x3989dd(%rip)        # 5f1a50 <_DYNAMIC+0x2f0>
  259073:	cmpb   $0x0,0x90(%rsp)
  25907b:	je     259085 <<glass::engine::Engine>::apply+0xd05>
  25907d:	mov    %rbx,%rsi
  259080:	jmp    259133 <<glass::engine::Engine>::apply+0xdb3>
  259085:	mov    0x28(%rsp),%r8
  25908a:	mov    %r8,%r15
  25908d:	sub    0x8(%rsp),%r15
  259092:	jbe    25911c <<glass::engine::Engine>::apply+0xd9c>
  259098:	mov    0x39b8a2(%rip),%eax        # 5f4940 <glass::engine::run_whole::ON>
  25909e:	test   %eax,%eax
  2590a0:	jne    2598bb <<glass::engine::Engine>::apply+0x153b>
  2590a6:	mov    0x88(%rsp),%ecx
  2590ad:	and    %bpl,%cl
  2590b0:	movzbl 0x39b88d(%rip),%eax        # 5f4944 <glass::engine::run_whole::ON+0x4>
  2590b7:	xor    $0x1,%rax
  2590bb:	cmp    %rax,%r15
  2590be:	seta   %al
  2590c1:	and    %cl,%al
  2590c3:	cmp    $0x1,%al
  2590c5:	jne    259126 <<glass::engine::Engine>::apply+0xda6>
  2590c7:	mov    0x8(%rsp),%rcx
  2590cc:	mov    %rcx,%rax
  2590cf:	cmp    %rcx,0x28(%rsp)
  2590d4:	mov    0x18(%rsp),%r13
  2590d9:	je     2590fb <<glass::engine::Engine>::apply+0xd7b>
  2590db:	nopl   0x0(%rax,%rax,1)
  2590e0:	mov    0x30(%rsp),%rcx
  2590e5:	movzbl (%rcx,%rax,1),%ecx
  2590e9:	add    $0xe0,%cl
  2590ec:	cmp    $0x5f,%cl
  2590ef:	jae    259105 <<glass::engine::Engine>::apply+0xd85>
  2590f1:	inc    %rax
  2590f4:	cmp    %rax,0x28(%rsp)
  2590f9:	jne    2590e0 <<glass::engine::Engine>::apply+0xd60>
  2590fb:	cmpl   $0xffffffff,0x710(%r14)
  259103:	je     259147 <<glass::engine::Engine>::apply+0xdc7>
  259105:	mov    0x30(%rsp),%rsi
  25910a:	mov    0x28(%rsp),%r8
  25910f:	mov    0xd8(%rsp),%rbp
  259117:	jmp    259223 <<glass::engine::Engine>::apply+0xea3>
  25911c:	mov    0x30(%rsp),%rsi
  259121:	jmp    2592e9 <<glass::engine::Engine>::apply+0xf69>
  259126:	mov    0x8(%rsp),%rbp
  25912b:	jmp    259214 <<glass::engine::Engine>::apply+0xe94>
  259130:	mov    %r8,%rsi
  259133:	mov    0x28(%rsp),%r8
  259138:	jmp    259300 <<glass::engine::Engine>::apply+0xf80>
  25913d:	mov    $0x1,%edx
  259142:	jmp    258ffa <<glass::engine::Engine>::apply+0xc7a>
  259147:	mov    0x39b7f3(%rip),%eax        # 5f4940 <glass::engine::run_whole::ON>
  25914d:	test   %eax,%eax
  25914f:	jne    2598c5 <<glass::engine::Engine>::apply+0x1545>
  259155:	mov    0x8(%rsp),%rax
  25915a:	add    0x30(%rsp),%rax
  25915f:	mov    %rax,0x8(%rsp)
  259164:	movzbl 0x39b7d9(%rip),%eax        # 5f4944 <glass::engine::run_whole::ON+0x4>
  25916b:	xor    $0x1,%rax
  25916f:	sub    %rax,%r15
  259172:	cmp    $0x1,%r15
  259176:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  259178:	cmpb   $0x1,0x20e(%rsp)
  259180:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  259182:	cmpq   $0x0,0x188(%rsp)
  25918b:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  25918d:	mov    0x1c8(%rsp),%rbp
  259195:	testb  $0x4,0x6c5(%rbp)
  25919c:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  25919e:	cmpq   $0x0,0x50(%rbp)
  2591a3:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  2591a5:	movzwl 0x64(%rbp),%eax
  2591a9:	test   $0x460,%eax
  2591ae:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  2591b0:	cmpb   $0x0,0x68(%rbp)
  2591b4:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  2591b6:	cmpb   $0x0,0x69(%rbp)
  2591ba:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  2591bc:	cmpb   $0x0,0x6a(%rbp)
  2591c0:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  2591c2:	cmpb   $0x0,0x6b(%rbp)
  2591c6:	je     2598cf <<glass::engine::Engine>::apply+0x154f>
  2591cc:	lea    0x150(%rsp),%rdi
  2591d4:	mov    0x8(%rsp),%rsi
  2591d9:	mov    %r15,%rdx
  2591dc:	call   264d10 <<glass::engine::Watch>::print_run>
  2591e1:	mov    %rax,%rbx
  2591e4:	mov    0x39b756(%rip),%eax        # 5f4940 <glass::engine::run_whole::ON>
  2591ea:	test   %eax,%eax
  2591ec:	jne    25a091 <<glass::engine::Engine>::apply+0x1d11>
  2591f2:	cmpb   $0x0,0x39b74b(%rip)        # 5f4944 <glass::engine::run_whole::ON+0x4>
  2591f9:	je     259209 <<glass::engine::Engine>::apply+0xe89>
  2591fb:	mov    0x200(%rsp),%eax
  259202:	mov    %eax,0x718(%r14)
  259209:	mov    0xd8(%rsp),%rbp
  259211:	add    %rbx,%rbp
  259214:	mov    0x18(%rsp),%r13
  259219:	mov    0x30(%rsp),%rsi
  25921e:	mov    0x28(%rsp),%r8
  259223:	mov    0x38(%rsp),%rcx
  259228:	cmp    %rbp,%r8
  25922b:	jb     25a72c <<glass::engine::Engine>::apply+0x23ac>
  259231:	mov    %r8,%rbx
  259234:	mov    %r8,0x8(%rsp)
  259239:	sub    %rbp,%rbx
  25923c:	je     2592ee <<glass::engine::Engine>::apply+0xf6e>
  259242:	mov    %rbp,%r13
  259245:	add    %rsi,%r13
  259248:	xor    %ebp,%ebp
  25924a:	mov    %rsi,%r15
  25924d:	nopl   (%rax)
  259250:	cmpl   $0xffffffff,0x710(%r14)
  259258:	jne    2592bb <<glass::engine::Engine>::apply+0xf3b>
  25925a:	mov    0x80(%rsp),%rax
  259262:	mov    %rax,0x90(%rsp)
  25926a:	lea    0x150(%rsp),%rax
  259272:	mov    %rax,0x98(%rsp)
  25927a:	movb   $0x0,0xa0(%rsp)
  259282:	mov    %rbx,%rcx
  259285:	sub    %rbp,%rcx
  259288:	jb     25a6bc <<glass::engine::Engine>::apply+0x233c>
  25928e:	mov    %r13,%rdx
  259291:	add    %rbp,%rdx
  259294:	mov    0xe8(%rsp),%rdi
  25929c:	lea    0x90(%rsp),%rsi
  2592a4:	call   1a06b0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  2592a9:	mov    %r15,%rsi
  2592ac:	add    %rax,%rbp
  2592af:	cmp    %rbx,%rbp
  2592b2:	mov    0x28(%rsp),%r8
  2592b7:	jne    259250 <<glass::engine::Engine>::apply+0xed0>
  2592b9:	jmp    2592e4 <<glass::engine::Engine>::apply+0xf64>
  2592bb:	mov    %rbx,%rcx
  2592be:	sub    %rbp,%rcx
  2592c1:	jb     25a79d <<glass::engine::Engine>::apply+0x241d>
  2592c7:	mov    %r13,%rdx
  2592ca:	add    %rbp,%rdx
  2592cd:	mov    0x80(%rsp),%rdi
  2592d5:	lea    0x150(%rsp),%rsi
  2592dd:	call   194410 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  2592e2:	jmp    2592a9 <<glass::engine::Engine>::apply+0xf29>
  2592e4:	mov    %r8,0x8(%rsp)
  2592e9:	mov    0x38(%rsp),%rcx
  2592ee:	cmpl   $0xffffffff,0x710(%r14)
  2592f6:	je     259313 <<glass::engine::Engine>::apply+0xf93>
  2592f8:	nopl   0x0(%rax,%rax,1)
  259300:	movl   $0x0,0x88(%rsp)
  25930b:	mov    %r8,%r13
  25930e:	jmp    2586b5 <<glass::engine::Engine>::apply+0x335>
  259313:	cmp    $0x11,%rcx
  259317:	jae    25a70d <<glass::engine::Engine>::apply+0x238d>
  25931d:	testb  $0x1,0x5f(%rsp)
  259322:	je     259342 <<glass::engine::Engine>::apply+0xfc2>
  259324:	test   %rcx,%rcx
  259327:	je     2597d0 <<glass::engine::Engine>::apply+0x1450>
  25932d:	movzwl 0x110(%rsp),%ebp
  259335:	xor    %eax,%eax
  259337:	test   %bp,%bp
  25933a:	setne  %al
  25933d:	jmp    2597d2 <<glass::engine::Engine>::apply+0x1452>
  259342:	testb  $0x1,0x5e(%rsp)
  259347:	je     259373 <<glass::engine::Engine>::apply+0xff3>
  259349:	test   %rcx,%rcx
  25934c:	je     259835 <<glass::engine::Engine>::apply+0x14b5>
  259352:	movzwl 0x110(%rsp),%eax
  25935a:	lea    -0x1(%rax),%esi
  25935d:	test   %eax,%eax
  25935f:	cmove  %eax,%esi
  259362:	cmp    $0x1,%rcx
  259366:	jne    25983b <<glass::engine::Engine>::apply+0x14bb>
  25936c:	xor    %eax,%eax
  25936e:	jmp    25984b <<glass::engine::Engine>::apply+0x14cb>
  259373:	test   %rcx,%rcx
  259376:	je     259869 <<glass::engine::Engine>::apply+0x14e9>
  25937c:	mov    0x1c8(%rsp),%r15
  259384:	xor    %eax,%eax
  259386:	jmp    2593c0 <<glass::engine::Engine>::apply+0x1040>
  259388:	mov    $0x17,%cx
  25938c:	mov    $0x1010000,%esi
  259391:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2593a0:	movzwl %cx,%eax
  2593a3:	shl    $0x10,%rsi
  2593a7:	or     %rax,%rsi
  2593aa:	mov    %r15,%rdi
  2593ad:	call   34ae10 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  2593b2:	mov    %rbx,%rax
  2593b5:	cmp    0x38(%rsp),%rbx
  2593ba:	jae    259869 <<glass::engine::Engine>::apply+0x14e9>
  2593c0:	movzwl 0x110(%rsp,%rax,2),%ecx
  2593c8:	lea    0x1(%rax),%rbx
  2593cc:	cmp    $0x3b,%rcx
  2593d0:	ja     2596a4 <<glass::engine::Engine>::apply+0x1324>
  2593d6:	lea    -0x1eac55(%rip),%rsi        # 6e788 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2cd7>
  2593dd:	movslq (%rsi,%rcx,4),%rdx
  2593e1:	add    %rsi,%rdx
  2593e4:	jmp    *%rdx
  2593e6:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2593e8:	cmp    0x38(%rsp),%rbx
  2593ed:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  2593ef:	movzwl 0x112(%rsp,%rax,2),%ecx
  2593f7:	lea    0x2(%rax),%rbx
  2593fb:	cmp    $0x5,%ecx
  2593fe:	je     259708 <<glass::engine::Engine>::apply+0x1388>
  259404:	cmp    $0x2,%ecx
  259407:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259409:	cmp    0x38(%rsp),%rbx
  25940e:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259410:	movzwl 0x114(%rsp,%rax,2),%ecx
  259418:	lea    0x3(%rax),%rbx
  25941c:	cmp    $0x100,%ecx
  259422:	setb   %dl
  259425:	cmp    0x38(%rsp),%rbx
  25942a:	setb   %sil
  25942e:	and    %dl,%sil
  259431:	cmp    $0x1,%sil
  259435:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  25943b:	movzwl 0x116(%rsp,%rax,2),%edx
  259443:	lea    0x4(%rax),%rbx
  259447:	cmp    $0x100,%edx
  25944d:	setb   %sil
  259451:	cmp    0x38(%rsp),%rbx
  259456:	setb   %dil
  25945a:	and    %sil,%dil
  25945d:	cmp    $0x1,%dil
  259461:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259467:	movzwl 0x118(%rsp,%rax,2),%edi
  25946f:	add    $0x5,%rax
  259473:	cmp    $0xff,%edi
  259479:	ja     259791 <<glass::engine::Engine>::apply+0x1411>
  25947f:	shl    $0x10,%edi
  259482:	movzwl %dx,%edx
  259485:	shl    $0x8,%edx
  259488:	or     %edx,%ecx
  25948a:	movzwl %cx,%esi
  25948d:	or     %edi,%esi
  25948f:	mov    $0x1,%ecx
  259494:	jmp    25972c <<glass::engine::Engine>::apply+0x13ac>
  259499:	mov    $0x11,%cx
  25949d:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2594a2:	mov    $0xc,%cx
  2594a6:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2594ab:	mov    $0xa,%cx
  2594af:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2594b4:	mov    $0x18,%cx
  2594b8:	mov    $0xff,%esi
  2594bd:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2594c2:	mov    $0xe,%cx
  2594c6:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2594cb:	cmp    0x38(%rsp),%rbx
  2594d0:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  2594d6:	movzwl 0x112(%rsp,%rax,2),%ecx
  2594de:	lea    0x2(%rax),%rbx
  2594e2:	cmp    $0x5,%ecx
  2594e5:	je     25973d <<glass::engine::Engine>::apply+0x13bd>
  2594eb:	cmp    $0x2,%ecx
  2594ee:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  2594f4:	cmp    0x38(%rsp),%rbx
  2594f9:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  2594ff:	movzwl 0x114(%rsp,%rax,2),%ecx
  259507:	lea    0x3(%rax),%rbx
  25950b:	cmp    $0x100,%ecx
  259511:	setb   %dl
  259514:	cmp    0x38(%rsp),%rbx
  259519:	setb   %sil
  25951d:	and    %dl,%sil
  259520:	cmp    $0x1,%sil
  259524:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  25952a:	movzwl 0x116(%rsp,%rax,2),%edx
  259532:	lea    0x4(%rax),%rbx
  259536:	cmp    $0x100,%edx
  25953c:	setb   %sil
  259540:	cmp    0x38(%rsp),%rbx
  259545:	setb   %dil
  259549:	and    %sil,%dil
  25954c:	cmp    $0x1,%dil
  259550:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259556:	movzwl 0x118(%rsp,%rax,2),%edi
  25955e:	add    $0x5,%rax
  259562:	cmp    $0xff,%edi
  259568:	ja     259791 <<glass::engine::Engine>::apply+0x1411>
  25956e:	shl    $0x10,%edi
  259571:	movzwl %dx,%edx
  259574:	shl    $0x8,%edx
  259577:	or     %edx,%ecx
  259579:	movzwl %cx,%esi
  25957c:	or     %edi,%esi
  25957e:	mov    $0x1,%ecx
  259583:	jmp    259761 <<glass::engine::Engine>::apply+0x13e1>
  259588:	mov    $0x10,%cx
  25958c:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  259591:	mov    $0x16,%cx
  259595:	mov    $0x1000000,%esi
  25959a:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  25959f:	mov    $0xf,%cx
  2595a3:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2595a8:	mov    $0x9,%cx
  2595ac:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2595b1:	mov    $0x12,%cx
  2595b5:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2595ba:	mov    $0x13,%cx
  2595be:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2595c3:	mov    $0xb,%cx
  2595c7:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2595cc:	mov    $0xd,%cx
  2595d0:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2595d5:	mov    $0x15,%cx
  2595d9:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2595de:	mov    $0x14,%cx
  2595e2:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2595e7:	cmp    0x38(%rsp),%rbx
  2595ec:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  2595f2:	movzwl 0x112(%rsp,%rax,2),%ecx
  2595fa:	lea    0x2(%rax),%rbx
  2595fe:	cmp    $0x5,%ecx
  259601:	je     259772 <<glass::engine::Engine>::apply+0x13f2>
  259607:	cmp    $0x2,%ecx
  25960a:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259610:	cmp    0x38(%rsp),%rbx
  259615:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  25961b:	movzwl 0x114(%rsp,%rax,2),%ecx
  259623:	lea    0x3(%rax),%rbx
  259627:	cmp    $0x100,%ecx
  25962d:	setb   %dl
  259630:	cmp    0x38(%rsp),%rbx
  259635:	setb   %sil
  259639:	and    %dl,%sil
  25963c:	cmp    $0x1,%sil
  259640:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259646:	movzwl 0x116(%rsp,%rax,2),%edx
  25964e:	lea    0x4(%rax),%rbx
  259652:	cmp    $0x100,%edx
  259658:	setb   %sil
  25965c:	cmp    0x38(%rsp),%rbx
  259661:	setb   %dil
  259665:	and    %sil,%dil
  259668:	cmp    $0x1,%dil
  25966c:	jne    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259672:	movzwl 0x118(%rsp,%rax,2),%edi
  25967a:	add    $0x5,%rax
  25967e:	cmp    $0xff,%edi
  259684:	ja     259791 <<glass::engine::Engine>::apply+0x1411>
  25968a:	shl    $0x10,%edi
  25968d:	movzwl %dx,%edx
  259690:	shl    $0x8,%edx
  259693:	or     %edx,%ecx
  259695:	movzwl %cx,%esi
  259698:	or     %edi,%esi
  25969a:	mov    $0x1,%ecx
  25969f:	jmp    2597bf <<glass::engine::Engine>::apply+0x143f>
  2596a4:	lea    -0x1e(%rcx),%eax
  2596a7:	cmp    $0x8,%ax
  2596ab:	jae    2596c5 <<glass::engine::Engine>::apply+0x1345>
  2596ad:	lea    -0x1fe344(%rip),%rax        # 5b370 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0x960>
  2596b4:	movzwl -0x3c(%rax,%rcx,2),%esi
  2596b9:	shl    $0x10,%esi
  2596bc:	mov    $0x16,%cx
  2596c0:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2596c5:	mov    %ecx,%eax
  2596c7:	and    $0xfff8,%eax
  2596cc:	cmp    $0x28,%ax
  2596d0:	jne    2596ea <<glass::engine::Engine>::apply+0x136a>
  2596d2:	lea    -0x1fe369(%rip),%rax        # 5b370 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0x960>
  2596d9:	movzwl -0x50(%rax,%rcx,2),%esi
  2596de:	shl    $0x10,%esi
  2596e1:	mov    $0x17,%cx
  2596e5:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2596ea:	lea    -0x5a(%rcx),%eax
  2596ed:	cmp    $0x8,%ax
  2596f1:	jae    259799 <<glass::engine::Engine>::apply+0x1419>
  2596f7:	lea    -0x1fc77e(%rip),%rax        # 5cf80 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0xd0>
  2596fe:	movzwl -0xb4(%rax,%rcx,2),%esi
  259706:	jmp    2596b9 <<glass::engine::Engine>::apply+0x1339>
  259708:	cmp    0x38(%rsp),%rbx
  25970d:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259713:	movzwl 0x114(%rsp,%rax,2),%esi
  25971b:	add    $0x3,%rax
  25971f:	cmp    $0xff,%esi
  259725:	ja     259791 <<glass::engine::Engine>::apply+0x1411>
  259727:	mov    $0x2,%ecx
  25972c:	shl    $0x8,%esi
  25972f:	or     %ecx,%esi
  259731:	mov    $0x16,%cx
  259735:	mov    %rax,%rbx
  259738:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  25973d:	cmp    0x38(%rsp),%rbx
  259742:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259748:	movzwl 0x114(%rsp,%rax,2),%esi
  259750:	add    $0x3,%rax
  259754:	cmp    $0xff,%esi
  25975a:	ja     259791 <<glass::engine::Engine>::apply+0x1411>
  25975c:	mov    $0x2,%ecx
  259761:	shl    $0x8,%esi
  259764:	or     %ecx,%esi
  259766:	mov    $0x18,%cx
  25976a:	mov    %rax,%rbx
  25976d:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  259772:	cmp    0x38(%rsp),%rbx
  259777:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  25977d:	movzwl 0x114(%rsp,%rax,2),%esi
  259785:	add    $0x3,%rax
  259789:	cmp    $0xff,%esi
  25978f:	jbe    2597ba <<glass::engine::Engine>::apply+0x143a>
  259791:	mov    %rax,%rbx
  259794:	jmp    2593b2 <<glass::engine::Engine>::apply+0x1032>
  259799:	lea    -0x64(%rcx),%eax
  25979c:	cmp    $0x8,%ax
  2597a0:	jae    2593b2 <<glass::engine::Engine>::apply+0x1032>
  2597a6:	lea    -0x1fc82d(%rip),%rax        # 5cf80 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0xd0>
  2597ad:	movzwl -0xc8(%rax,%rcx,2),%esi
  2597b5:	jmp    2596de <<glass::engine::Engine>::apply+0x135e>
  2597ba:	mov    $0x2,%ecx
  2597bf:	shl    $0x8,%esi
  2597c2:	or     %ecx,%esi
  2597c4:	mov    $0x17,%cx
  2597c8:	mov    %rax,%rbx
  2597cb:	jmp    2593a0 <<glass::engine::Engine>::apply+0x1020>
  2597d0:	xor    %eax,%eax
  2597d2:	test   $0x1,%al
  2597d4:	mov    $0x1,%eax
  2597d9:	cmove  %eax,%ebp
  2597dc:	mov    0x200(%rsp),%ebx
  2597e3:	cmp    $0xffffffff,%ebx
  2597e6:	je     259806 <<glass::engine::Engine>::apply+0x1486>
  2597e8:	test   %bp,%bp
  2597eb:	je     259869 <<glass::engine::Engine>::apply+0x14e9>
  2597ed:	nopl   (%rax)
  2597f0:	lea    0x150(%rsp),%rdi
  2597f8:	mov    %ebx,%esi
  2597fa:	call   33d350 <<glass::engine::Watch as vte::ansi::Handler>::input>
  2597ff:	dec    %bp
  259802:	jne    2597f0 <<glass::engine::Engine>::apply+0x1470>
  259804:	jmp    259869 <<glass::engine::Engine>::apply+0x14e9>
  259806:	mov    $0x1,%al
  259808:	mov    %eax,0x88(%rsp)
  25980f:	mov    0x28(%rsp),%r8
  259814:	mov    %r8,%r13
  259817:	mov    0x8(%rsp),%rax
  25981c:	mov    %rax,0xd8(%rsp)
  259824:	mov    $0x1,%al
  259826:	mov    %rax,0x60(%rsp)
  25982b:	mov    0x218(%rsp),%r12
  259833:	jmp    2598a7 <<glass::engine::Engine>::apply+0x1527>
  259835:	xor    %esi,%esi
  259837:	xor    %eax,%eax
  259839:	jmp    25984b <<glass::engine::Engine>::apply+0x14cb>
  25983b:	movzwl 0x112(%rsp),%ecx
  259843:	xor    %eax,%eax
  259845:	test   %cx,%cx
  259848:	setne  %al
  25984b:	movzwl %cx,%edx
  25984e:	dec    %rdx
  259851:	test   $0x1,%al
  259853:	mov    $0x0,%eax
  259858:	cmove  %rax,%rdx
  25985c:	mov    0x1c8(%rsp),%rdi
  259864:	call   34c250 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  259869:	mov    0x28(%rsp),%r8
  25986e:	mov    0x218(%rsp),%r12
  259876:	lea    (%r12,%r8,1),%r13
  25987a:	movb   $0x0,0xa80(%r14)
  259882:	movb   $0x0,0xa7e(%r14)
  25988a:	mov    $0x1,%al
  25988c:	mov    %eax,0x88(%rsp)
  259893:	mov    %r13,0x8(%rsp)
  259898:	mov    %r13,0xd8(%rsp)
  2598a0:	mov    $0x1,%al
  2598a2:	mov    %rax,0x60(%rsp)
  2598a7:	mov    0x30(%rsp),%rsi
  2598ac:	jmp    2586b5 <<glass::engine::Engine>::apply+0x335>
  2598b1:	mov    $0x2,%edx
  2598b6:	jmp    258ffa <<glass::engine::Engine>::apply+0xc7a>
  2598bb:	call   18ba46 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2598c0:	jmp    2590a6 <<glass::engine::Engine>::apply+0xd26>
  2598c5:	call   18ba46 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2598ca:	jmp    259155 <<glass::engine::Engine>::apply+0xdd5>
  2598cf:	mov    0x8(%rsp),%rax
  2598d4:	movzbl (%rax),%eax
  2598d7:	mov    %rax,0x88(%rsp)
  2598df:	add    $0xffffffe0,%eax
  2598e2:	mov    $0x1,%ebx
  2598e7:	cmp    $0x5f,%al
  2598e9:	jb     259916 <<glass::engine::Engine>::apply+0x1596>
  2598eb:	mov    0x88(%rsp),%rdi
  2598f3:	call   2a1f80 <glass::engine::width_of>
  2598f8:	mov    0x20(%rsp),%r14
  2598fd:	mov    %rdx,%rbx
  259900:	lea    -0x1(%rdx),%rcx
  259904:	cmp    $0x2,%rcx
  259908:	setb   %cl
  25990b:	and    %al,%cl
  25990d:	cmp    $0x1,%cl
  259910:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  259916:	cmpb   $0x0,0x6c(%rbp)
  25991a:	mov    0x20(%rsp),%r14
  25991f:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  259925:	mov    0x40(%rbp),%rcx
  259929:	mov    0xa0(%rbp),%rdx
  259930:	mov    %rcx,0x40(%rsp)
  259935:	lea    (%rcx,%rbx,1),%rax
  259939:	mov    %rax,0x148(%rsp)
  259941:	mov    %rdx,0x248(%rsp)
  259949:	cmp    %rdx,%rax
  25994c:	ja     2591cc <<glass::engine::Engine>::apply+0xe4c>
  259952:	lea    0x10(%rbp),%rdi
  259956:	mov    0x48(%rbp),%esi
  259959:	mov    0x58(%rbp),%eax
  25995c:	mov    %eax,0xf8(%rsp)
  259963:	mov    0x5c(%rbp),%eax
  259966:	mov    %eax,0xf4(%rsp)
  25996d:	movzwl 0x64(%rbp),%eax
  259971:	mov    %eax,0xfc(%rsp)
  259978:	lea    0x36f3a1(%rip),%rdx        # 5c8d20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a0>
  25997f:	call   30b960 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  259984:	mov    %rax,%rcx
  259987:	add    $0x18,%rcx
  25998b:	mov    %rcx,0x108(%rsp)
  259993:	mov    %rax,0x10(%rsp)
  259998:	mov    0x28(%rax),%eax
  25999b:	cmp    $0xffffffff,%eax
  25999e:	je     2599b8 <<glass::engine::Engine>::apply+0x1638>
  2599a0:	mov    0x108(%rsp),%rcx
  2599a8:	mov    0x40(%rsp),%rdx
  2599ad:	mov    0x10(%rsp),%rsi
  2599b2:	cmp    0x30(%rsi),%rdx
  2599b6:	jae    2599e2 <<glass::engine::Engine>::apply+0x1662>
  2599b8:	mov    0x10(%rsp),%rcx
  2599bd:	mov    0x10(%rcx),%rcx
  2599c1:	cmp    %rcx,0x40(%rsp)
  2599c6:	jae    25a7af <<glass::engine::Engine>::apply+0x242f>
  2599cc:	mov    0x40(%rsp),%rcx
  2599d1:	lea    (%rcx,%rcx,2),%rcx
  2599d5:	shl    $0x3,%rcx
  2599d9:	mov    0x10(%rsp),%rdx
  2599de:	add    0x8(%rdx),%rcx
  2599e2:	testb  $0x60,0x14(%rcx)
  2599e6:	mov    0x20(%rsp),%r14
  2599eb:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  2599f1:	cmp    $0x2,%rbx
  2599f5:	jne    259a49 <<glass::engine::Engine>::apply+0x16c9>
  2599f7:	mov    0x40(%rsp),%rcx
  2599fc:	inc    %rcx
  2599ff:	cmp    $0xffffffff,%eax
  259a02:	je     259a17 <<glass::engine::Engine>::apply+0x1697>
  259a04:	mov    0x108(%rsp),%rdx
  259a0c:	mov    0x10(%rsp),%rsi
  259a11:	cmp    0x30(%rsi),%rcx
  259a15:	jae    259a3a <<glass::engine::Engine>::apply+0x16ba>
  259a17:	mov    0x10(%rsp),%rdx
  259a1c:	mov    0x10(%rdx),%rdx
  259a20:	cmp    %rdx,%rcx
  259a23:	jae    25a7c2 <<glass::engine::Engine>::apply+0x2442>
  259a29:	lea    (%rcx,%rcx,2),%rdx
  259a2d:	shl    $0x3,%rdx
  259a31:	mov    0x10(%rsp),%rcx
  259a36:	add    0x8(%rcx),%rdx
  259a3a:	testb  $0x60,0x14(%rdx)
  259a3e:	mov    0x20(%rsp),%r14
  259a43:	jne    2591cc <<glass::engine::Engine>::apply+0xe4c>
  259a49:	mov    0x40(%rsp),%rcx
  259a4e:	mov    0x10(%rsp),%rdx
  259a53:	cmp    %ecx,0x38(%rdx)
  259a56:	jbe    259a65 <<glass::engine::Engine>::apply+0x16e5>
  259a58:	mov    0x40(%rsp),%rcx
  259a5d:	mov    0x10(%rsp),%rdx
  259a62:	mov    %ecx,0x38(%rdx)
  259a65:	cmp    $0xffffffff,%eax
  259a68:	setne  %cl
  259a6b:	mov    0x10(%rsp),%rdx
  259a70:	mov    0x30(%rdx),%r14
  259a74:	cmp    %r14,0x40(%rsp)
  259a79:	sete   %dl
  259a7c:	test   %dl,%cl
  259a7e:	jne    259b79 <<glass::engine::Engine>::apply+0x17f9>
  259a84:	cmp    $0xffffffff,%eax
  259a87:	je     259cbb <<glass::engine::Engine>::apply+0x193b>
  259a8d:	mov    0x10(%rsp),%rax
  259a92:	mov    0x10(%rax),%r15
  259a96:	cmp    %r14,%r15
  259a99:	mov    %r14,%rax
  259a9c:	cmovb  %r15,%rax
  259aa0:	mov    %rax,0x70(%rsp)
  259aa5:	mov    0x40(%rsp),%rax
  259aaa:	cmp    %rax,%r15
  259aad:	cmovb  %r15,%rax
  259ab1:	mov    %rax,0x48(%rsp)
  259ab6:	mov    0x397fc3(%rip),%rax        # 5f1a80 <_DYNAMIC+0x320>
  259abd:	movzbl (%rax),%eax
  259ac0:	test   %al,%al
  259ac2:	je     259aed <<glass::engine::Engine>::apply+0x176d>
  259ac4:	mov    0x397fed(%rip),%rax        # 5f1ab8 <_DYNAMIC+0x358>
  259acb:	cmp    0x48(%rsp),%r14
  259ad0:	jae    259ad9 <<glass::engine::Engine>::apply+0x1759>
  259ad2:	mov    0x397fe7(%rip),%rax        # 5f1ac0 <_DYNAMIC+0x360>
  259ad9:	lock incq 0x28(%rax)
  259ade:	mov    0x48(%rsp),%rdi
  259ae3:	sub    0x70(%rsp),%rdi
  259ae8:	call   2f6f00 <alacritty_terminal::grid::row::fill_census::note>
  259aed:	cmp    0x48(%rsp),%r14
  259af2:	jae    259c9b <<glass::engine::Engine>::apply+0x191b>
  259af8:	mov    0x10(%rsp),%rax
  259afd:	mov    0x28(%rax),%ecx
  259b00:	mov    %ecx,0x8(%rsp)
  259b04:	mov    0x20(%rax),%ecx
  259b07:	mov    %ecx,0x58(%rsp)
  259b0b:	mov    0x24(%rax),%ecx
  259b0e:	mov    %ecx,0x54(%rsp)
  259b12:	movzwl 0x2c(%rax),%ecx
  259b16:	mov    %cx,0x78(%rsp)
  259b1b:	mov    0x18(%rax),%r14
  259b1f:	test   %r14,%r14
  259b22:	je     259b9d <<glass::engine::Engine>::apply+0x181d>
  259b24:	lock incq (%r14)
  259b28:	jle    25a848 <<glass::engine::Engine>::apply+0x24c8>
  259b2e:	mov    0x10(%rsp),%rax
  259b33:	mov    0x10(%rax),%rdx
  259b37:	mov    0x8(%rsp),%eax
  259b3b:	mov    %eax,0xa0(%rsp)
  259b42:	mov    0x58(%rsp),%eax
  259b46:	mov    %eax,0x98(%rsp)
  259b4d:	mov    0x54(%rsp),%eax
  259b51:	mov    %eax,0x9c(%rsp)
  259b58:	movzwl 0x78(%rsp),%eax
  259b5d:	mov    %ax,0xa4(%rsp)
  259b65:	mov    %r14,0x90(%rsp)
  259b6d:	cmp    %rdx,0x48(%rsp)
  259b72:	jbe    259bd3 <<glass::engine::Engine>::apply+0x1853>
  259b74:	jmp    25a7d6 <<glass::engine::Engine>::apply+0x2456>
  259b79:	mov    0x40(%rsp),%rcx
  259b7e:	lea    0x1(%rcx),%rax
  259b82:	mov    0x10(%rsp),%rdx
  259b87:	mov    %rax,0x30(%rdx)
  259b8b:	mov    0x10(%rdx),%rax
  259b8f:	cmp    %rax,%rcx
  259b92:	jb     259ce5 <<glass::engine::Engine>::apply+0x1965>
  259b98:	jmp    25a7ef <<glass::engine::Engine>::apply+0x246f>
  259b9d:	mov    0x8(%rsp),%eax
  259ba1:	mov    %eax,0xa0(%rsp)
  259ba8:	mov    0x58(%rsp),%eax
  259bac:	mov    %eax,0x98(%rsp)
  259bb3:	mov    0x54(%rsp),%eax
  259bb7:	mov    %eax,0x9c(%rsp)
  259bbe:	movzwl 0x78(%rsp),%eax
  259bc3:	mov    %ax,0xa4(%rsp)
  259bcb:	mov    %r14,0x90(%rsp)
  259bd3:	mov    0x70(%rsp),%rax
  259bd8:	lea    0x0(,%rax,8),%rax
  259be0:	lea    (%rax,%rax,2),%rax
  259be4:	mov    0x10(%rsp),%rcx
  259be9:	mov    0x8(%rcx),%r15
  259bed:	add    %rax,%r15
  259bf0:	mov    0x48(%rsp),%rcx
  259bf5:	lea    0x0(,%rcx,8),%rcx
  259bfd:	lea    (%rcx,%rcx,2),%r13
  259c01:	sub    %rax,%r13
  259c04:	jmp    259c35 <<glass::engine::Engine>::apply+0x18b5>
  259c06:	mov    %r14,(%r15)
  259c09:	mov    0x58(%rsp),%eax
  259c0d:	mov    %eax,0x8(%r15)
  259c11:	mov    0x54(%rsp),%eax
  259c15:	mov    %eax,0xc(%r15)
  259c19:	mov    0x8(%rsp),%eax
  259c1d:	mov    %eax,0x10(%r15)
  259c21:	movzwl 0x78(%rsp),%eax
  259c26:	mov    %ax,0x14(%r15)
  259c2b:	add    $0x18,%r15
  259c2f:	add    $0xffffffffffffffe8,%r13
  259c33:	je     259c5d <<glass::engine::Engine>::apply+0x18dd>
  259c35:	test   %r14,%r14
  259c38:	je     259c44 <<glass::engine::Engine>::apply+0x18c4>
  259c3a:	lock incq (%r14)
  259c3e:	jle    25a848 <<glass::engine::Engine>::apply+0x24c8>
  259c44:	mov    (%r15),%rax
  259c47:	test   %rax,%rax
  259c4a:	je     259c06 <<glass::engine::Engine>::apply+0x1886>
  259c4c:	lock decq (%rax)
  259c50:	jne    259c06 <<glass::engine::Engine>::apply+0x1886>
  259c52:	mov    %r15,%rdi
  259c55:	call   *0x397d6d(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  259c5b:	jmp    259c06 <<glass::engine::Engine>::apply+0x1886>
  259c5d:	mov    0x10(%rsp),%rax
  259c62:	mov    0x70(%rsp),%rcx
  259c67:	cmp    %ecx,0x38(%rax)
  259c6a:	jbe    259c79 <<glass::engine::Engine>::apply+0x18f9>
  259c6c:	mov    0x10(%rsp),%rax
  259c71:	mov    0x70(%rsp),%rcx
  259c76:	mov    %ecx,0x38(%rax)
  259c79:	test   %r14,%r14
  259c7c:	je     259c92 <<glass::engine::Engine>::apply+0x1912>
  259c7e:	lock decq (%r14)
  259c82:	jne    259c92 <<glass::engine::Engine>::apply+0x1912>
  259c84:	lea    0x90(%rsp),%rdi
  259c8c:	call   *0x397d36(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  259c92:	mov    0x10(%rsp),%rax
  259c97:	mov    0x10(%rax),%r15
  259c9b:	cmp    %r15,0x48(%rsp)
  259ca0:	jb     259cbb <<glass::engine::Engine>::apply+0x193b>
  259ca2:	mov    0x108(%rsp),%rdi
  259caa:	call   1ad4a0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259caf:	mov    0x10(%rsp),%rax
  259cb4:	movl   $0xffffffff,0x28(%rax)
  259cbb:	mov    0x10(%rsp),%rsi
  259cc0:	mov    0x30(%rsi),%rcx
  259cc4:	mov    0x40(%rsp),%rdx
  259cc9:	lea    0x1(%rdx),%rax
  259ccd:	cmp    %rcx,%rax
  259cd0:	cmova  %rax,%rcx
  259cd4:	mov    0x10(%rsi),%rax
  259cd8:	mov    %rcx,0x30(%rsi)
  259cdc:	cmp    %rax,%rdx
  259cdf:	jae    25a805 <<glass::engine::Engine>::apply+0x2485>
  259ce5:	mov    0xfc(%rsp),%edi
  259cec:	mov    %edi,%ecx
  259cee:	or     $0x20,%ecx
  259cf1:	cmp    $0x2,%rbx
  259cf5:	mov    0x10(%rsp),%rax
  259cfa:	mov    0x8(%rax),%rdx
  259cfe:	mov    0x40(%rsp),%rax
  259d03:	lea    (%rax,%rax,2),%rax
  259d07:	lea    (%rdx,%rax,8),%r15
  259d0b:	mov    0x88(%rsp),%rsi
  259d13:	mov    %esi,0x10(%rdx,%rax,8)
  259d17:	mov    0xf8(%rsp),%esi
  259d1e:	mov    %esi,0x8(%rdx,%rax,8)
  259d22:	cmovne %edi,%ecx
  259d25:	mov    0xf4(%rsp),%esi
  259d2c:	mov    %esi,0xc(%rdx,%rax,8)
  259d30:	mov    %cx,0x14(%rdx,%rax,8)
  259d35:	mov    (%rdx,%rax,8),%rax
  259d39:	test   %rax,%rax
  259d3c:	je     259d4d <<glass::engine::Engine>::apply+0x19cd>
  259d3e:	lock decq (%rax)
  259d42:	jne    259d4d <<glass::engine::Engine>::apply+0x19cd>
  259d44:	mov    %r15,%rdi
  259d47:	call   *0x397c7b(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  259d4d:	movq   $0x0,(%r15)
  259d54:	cmp    $0x2,%rbx
  259d58:	jne    25a038 <<glass::engine::Engine>::apply+0x1cb8>
  259d5e:	mov    0x40(%rsp),%rax
  259d63:	lea    0x1(%rax),%rdx
  259d67:	mov    0x10(%rsp),%rax
  259d6c:	mov    0x30(%rax),%rbx
  259d70:	mov    0x28(%rax),%eax
  259d73:	mov    %rdx,0x78(%rsp)
  259d78:	cmp    %rbx,%rdx
  259d7b:	jne    259da8 <<glass::engine::Engine>::apply+0x1a28>
  259d7d:	cmp    $0xffffffff,%eax
  259d80:	je     259da8 <<glass::engine::Engine>::apply+0x1a28>
  259d82:	mov    0x40(%rsp),%rax
  259d87:	add    $0x2,%rax
  259d8b:	mov    0x10(%rsp),%rcx
  259d90:	mov    %rax,0x30(%rcx)
  259d94:	mov    0x10(%rcx),%rax
  259d98:	cmp    %rax,0x78(%rsp)
  259d9d:	jb     259fd6 <<glass::engine::Engine>::apply+0x1c56>
  259da3:	jmp    25a81b <<glass::engine::Engine>::apply+0x249b>
  259da8:	cmp    $0xffffffff,%eax
  259dab:	je     259faa <<glass::engine::Engine>::apply+0x1c2a>
  259db1:	mov    0x10(%rsp),%rax
  259db6:	mov    0x10(%rax),%r14
  259dba:	cmp    %rbx,%r14
  259dbd:	mov    %rbx,%rax
  259dc0:	cmovb  %r14,%rax
  259dc4:	mov    %rax,0x70(%rsp)
  259dc9:	mov    0x78(%rsp),%rax
  259dce:	cmp    %rax,%r14
  259dd1:	cmovb  %r14,%rax
  259dd5:	mov    %rax,0x48(%rsp)
  259dda:	mov    0x397c9f(%rip),%rax        # 5f1a80 <_DYNAMIC+0x320>
  259de1:	movzbl (%rax),%eax
  259de4:	test   %al,%al
  259de6:	je     259e11 <<glass::engine::Engine>::apply+0x1a91>
  259de8:	mov    0x397cc9(%rip),%rax        # 5f1ab8 <_DYNAMIC+0x358>
  259def:	cmp    0x48(%rsp),%rbx
  259df4:	jae    259dfd <<glass::engine::Engine>::apply+0x1a7d>
  259df6:	mov    0x397cc3(%rip),%rax        # 5f1ac0 <_DYNAMIC+0x360>
  259dfd:	lock incq 0x28(%rax)
  259e02:	mov    0x48(%rsp),%rdi
  259e07:	sub    0x70(%rsp),%rdi
  259e0c:	call   2f6f00 <alacritty_terminal::grid::row::fill_census::note>
  259e11:	cmp    0x48(%rsp),%rbx
  259e16:	jae    259f8a <<glass::engine::Engine>::apply+0x1c0a>
  259e1c:	mov    0x10(%rsp),%rax
  259e21:	mov    0x28(%rax),%ecx
  259e24:	mov    %ecx,0x8(%rsp)
  259e28:	mov    0x20(%rax),%ecx
  259e2b:	mov    %ecx,0x58(%rsp)
  259e2f:	mov    0x24(%rax),%ecx
  259e32:	mov    %ecx,0x54(%rsp)
  259e36:	movzwl 0x2c(%rax),%r14d
  259e3b:	mov    0x18(%rax),%rbx
  259e3f:	test   %rbx,%rbx
  259e42:	je     259e95 <<glass::engine::Engine>::apply+0x1b15>
  259e44:	lock incq (%rbx)
  259e48:	jle    25a848 <<glass::engine::Engine>::apply+0x24c8>
  259e4e:	mov    0x10(%rsp),%rax
  259e53:	mov    0x10(%rax),%rdx
  259e57:	mov    0x8(%rsp),%eax
  259e5b:	mov    %eax,0xa0(%rsp)
  259e62:	mov    0x58(%rsp),%eax
  259e66:	mov    %eax,0x98(%rsp)
  259e6d:	mov    0x54(%rsp),%eax
  259e71:	mov    %eax,0x9c(%rsp)
  259e78:	mov    %r14w,0xa4(%rsp)
  259e81:	mov    %rbx,0x90(%rsp)
  259e89:	cmp    %rdx,0x48(%rsp)
  259e8e:	jbe    259ec7 <<glass::engine::Engine>::apply+0x1b47>
  259e90:	jmp    25a831 <<glass::engine::Engine>::apply+0x24b1>
  259e95:	mov    0x8(%rsp),%eax
  259e99:	mov    %eax,0xa0(%rsp)
  259ea0:	mov    0x58(%rsp),%eax
  259ea4:	mov    %eax,0x98(%rsp)
  259eab:	mov    0x54(%rsp),%eax
  259eaf:	mov    %eax,0x9c(%rsp)
  259eb6:	mov    %r14w,0xa4(%rsp)
  259ebf:	mov    %rbx,0x90(%rsp)
  259ec7:	mov    0x70(%rsp),%rax
  259ecc:	lea    0x0(,%rax,8),%rax
  259ed4:	lea    (%rax,%rax,2),%rax
  259ed8:	mov    0x10(%rsp),%rcx
  259edd:	mov    0x8(%rcx),%r15
  259ee1:	add    %rax,%r15
  259ee4:	mov    0x48(%rsp),%rcx
  259ee9:	lea    0x0(,%rcx,8),%rcx
  259ef1:	lea    (%rcx,%rcx,2),%r13
  259ef5:	sub    %rax,%r13
  259ef8:	jmp    259f24 <<glass::engine::Engine>::apply+0x1ba4>
  259efa:	mov    %rbx,(%r15)
  259efd:	mov    0x58(%rsp),%eax
  259f01:	mov    %eax,0x8(%r15)
  259f05:	mov    0x54(%rsp),%eax
  259f09:	mov    %eax,0xc(%r15)
  259f0d:	mov    0x8(%rsp),%eax
  259f11:	mov    %eax,0x10(%r15)
  259f15:	mov    %r14w,0x14(%r15)
  259f1a:	add    $0x18,%r15
  259f1e:	add    $0xffffffffffffffe8,%r13
  259f22:	je     259f4c <<glass::engine::Engine>::apply+0x1bcc>
  259f24:	test   %rbx,%rbx
  259f27:	je     259f33 <<glass::engine::Engine>::apply+0x1bb3>
  259f29:	lock incq (%rbx)
  259f2d:	jle    25a848 <<glass::engine::Engine>::apply+0x24c8>
  259f33:	mov    (%r15),%rax
  259f36:	test   %rax,%rax
  259f39:	je     259efa <<glass::engine::Engine>::apply+0x1b7a>
  259f3b:	lock decq (%rax)
  259f3f:	jne    259efa <<glass::engine::Engine>::apply+0x1b7a>
  259f41:	mov    %r15,%rdi
  259f44:	call   *0x397a7e(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  259f4a:	jmp    259efa <<glass::engine::Engine>::apply+0x1b7a>
  259f4c:	mov    0x10(%rsp),%rax
  259f51:	mov    0x70(%rsp),%rcx
  259f56:	cmp    %ecx,0x38(%rax)
  259f59:	jbe    259f68 <<glass::engine::Engine>::apply+0x1be8>
  259f5b:	mov    0x10(%rsp),%rax
  259f60:	mov    0x70(%rsp),%rcx
  259f65:	mov    %ecx,0x38(%rax)
  259f68:	test   %rbx,%rbx
  259f6b:	je     259f81 <<glass::engine::Engine>::apply+0x1c01>
  259f6d:	lock decq (%rbx)
  259f71:	jne    259f81 <<glass::engine::Engine>::apply+0x1c01>
  259f73:	lea    0x90(%rsp),%rdi
  259f7b:	call   *0x397a47(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  259f81:	mov    0x10(%rsp),%rax
  259f86:	mov    0x10(%rax),%r14
  259f8a:	cmp    %r14,0x48(%rsp)
  259f8f:	jb     259faa <<glass::engine::Engine>::apply+0x1c2a>
  259f91:	mov    0x108(%rsp),%rdi
  259f99:	call   1ad4a0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259f9e:	mov    0x10(%rsp),%rax
  259fa3:	movl   $0xffffffff,0x28(%rax)
  259faa:	mov    0x10(%rsp),%rsi
  259faf:	mov    0x30(%rsi),%rcx
  259fb3:	mov    0x40(%rsp),%rdx
  259fb8:	add    $0x2,%rdx
  259fbc:	cmp    %rcx,%rdx
  259fbf:	cmovbe %rcx,%rdx
  259fc3:	mov    0x10(%rsi),%rax
  259fc7:	mov    %rdx,0x30(%rsi)
  259fcb:	cmp    %rax,0x78(%rsp)
  259fd0:	jae    25a84a <<glass::engine::Engine>::apply+0x24ca>
  259fd6:	mov    0x10(%rsp),%rax
  259fdb:	mov    0x8(%rax),%rax
  259fdf:	mov    0x78(%rsp),%rcx
  259fe4:	lea    (%rcx,%rcx,2),%rcx
  259fe8:	lea    (%rax,%rcx,8),%rbx
  259fec:	movl   $0x20,0x10(%rax,%rcx,8)
  259ff4:	mov    0xf8(%rsp),%edx
  259ffb:	mov    %edx,0x8(%rax,%rcx,8)
  259fff:	mov    0xf4(%rsp),%edx
  25a006:	mov    %edx,0xc(%rax,%rcx,8)
  25a00a:	mov    0xfc(%rsp),%edx
  25a011:	or     $0x40,%edx
  25a014:	mov    %dx,0x14(%rax,%rcx,8)
  25a019:	mov    (%rax,%rcx,8),%rax
  25a01d:	test   %rax,%rax
  25a020:	je     25a031 <<glass::engine::Engine>::apply+0x1cb1>
  25a022:	lock decq (%rax)
  25a026:	jne    25a031 <<glass::engine::Engine>::apply+0x1cb1>
  25a028:	mov    %rbx,%rdi
  25a02b:	call   *0x397997(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  25a031:	movq   $0x0,(%rbx)
  25a038:	mov    0x248(%rsp),%rax
  25a040:	cmp    %rax,0x148(%rsp)
  25a048:	jb     25a056 <<glass::engine::Engine>::apply+0x1cd6>
  25a04a:	decq   0x148(%rsp)
  25a052:	movb   $0x1,0x6c(%rbp)
  25a056:	mov    0x148(%rsp),%rax
  25a05e:	mov    %rax,0x40(%rbp)
  25a062:	incq   0x1f0(%rsp)
  25a06a:	mov    0x88(%rsp),%rax
  25a072:	mov    %eax,0x200(%rsp)
  25a079:	mov    $0x1,%ebx
  25a07e:	mov    0x20(%rsp),%r14
  25a083:	mov    0x39a8b7(%rip),%eax        # 5f4940 <glass::engine::run_whole::ON>
  25a089:	test   %eax,%eax
  25a08b:	je     2591f2 <<glass::engine::Engine>::apply+0xe72>
  25a091:	call   18ba46 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25a096:	jmp    2591f2 <<glass::engine::Engine>::apply+0xe72>
  25a09b:	nopl   0x0(%rax,%rax,1)
  25a0a0:	mov    0x398171(%rip),%rax        # 5f2218 <_DYNAMIC+0xab8>
  25a0a7:	mov    (%rax),%rax
  25a0aa:	mov    $0x1b,%edi
  25a0af:	mov    %r15,%rsi
  25a0b2:	call   *%rax
  25a0b4:	cmp    $0x1,%rax
  25a0b8:	jne    25a380 <<glass::engine::Engine>::apply+0x2000>
  25a0be:	mov    %rdx,%rcx
  25a0c1:	mov    %r15,%rsi
  25a0c4:	sub    %r15,%rcx
  25a0c7:	movb   $0x1,0xa80(%r14)
  25a0cf:	movb   $0x0,0xa7e(%r14)
  25a0d7:	inc    %rcx
  25a0da:	cmp    %r13,%rcx
  25a0dd:	jb     25a38e <<glass::engine::Engine>::apply+0x200e>
  25a0e3:	movzbl 0xa7e(%r14),%eax
  25a0eb:	mov    %al,0xa7f(%r14)
  25a0f2:	mov    0xd0(%rsp),%rbx
  25a0fa:	jmp    25a4a2 <<glass::engine::Engine>::apply+0x2122>
  25a0ff:	nop
  25a100:	mov    0x18(%rsp),%r13
  25a105:	cmp    %rbp,%r13
  25a108:	jb     25a724 <<glass::engine::Engine>::apply+0x23a4>
  25a10e:	mov    %rsi,%r15
  25a111:	lea    (%rsi,%rbp,1),%rbx
  25a115:	mov    0x3980fc(%rip),%rax        # 5f2218 <_DYNAMIC+0xab8>
  25a11c:	mov    (%rax),%rax
  25a11f:	mov    $0x1b,%edi
  25a124:	mov    %rbx,%rsi
  25a127:	mov    0xe0(%rsp),%rdx
  25a12f:	call   *%rax
  25a131:	cmp    $0x1,%rax
  25a135:	jne    25a150 <<glass::engine::Engine>::apply+0x1dd0>
  25a137:	sub    %rbx,%rdx
  25a13a:	movb   $0x1,0xa80(%r14)
  25a142:	movb   $0x0,0xa7e(%r14)
  25a14a:	add    %rdx,%rbp
  25a14d:	inc    %rbp
  25a150:	mov    %r15,%rsi
  25a153:	cmp    %r13,%rbp
  25a156:	jae    25a193 <<glass::engine::Engine>::apply+0x1e13>
  25a158:	mov    0x68(%rsp),%rdi
  25a15d:	mov    %r13,%rdx
  25a160:	mov    %rbp,%rcx
  25a163:	mov    %r13,%r8
  25a166:	call   26ff50 <<glass::engine::Mirror>::stretch>
  25a16b:	cmp    %r13,%rax
  25a16e:	mov    %r15,%rsi
  25a171:	jae    25a193 <<glass::engine::Engine>::apply+0x1e13>
  25a173:	cmpb   $0x0,0xa80(%r14)
  25a17b:	jne    25a193 <<glass::engine::Engine>::apply+0x1e13>
  25a17d:	mov    0xe0(%rsp),%rax
  25a185:	movzbl -0x1(%rax),%eax
  25a189:	shr    $0x7,%al
  25a18c:	mov    0x68(%rsp),%rcx
  25a191:	mov    %al,(%rcx)
  25a193:	movzbl 0xa7e(%r14),%eax
  25a19b:	mov    %al,0xa7f(%r14)
  25a1a2:	sub    0x8(%rsp),%r13
  25a1a7:	mov    0xd0(%rsp),%rbx
  25a1af:	jbe    25a1e0 <<glass::engine::Engine>::apply+0x1e60>
  25a1b1:	movzbl 0x39dae0(%rip),%eax        # 5f7c98 <glass::engine::counters::COUNTING>
  25a1b8:	test   %al,%al
  25a1ba:	je     25a1c4 <<glass::engine::Engine>::apply+0x1e44>
  25a1bc:	lock add %r13,0x39dadc(%rip)        # 5f7ca0 <glass::engine::counters::VTE_BYTES>
  25a1c4:	movzbl 0x39da6d(%rip),%eax        # 5f7c38 <glass::engine::probes::RUN_PROBE>
  25a1cb:	cmp    $0x68,%al
  25a1cd:	jne    25a53e <<glass::engine::Engine>::apply+0x21be>
  25a1d3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a1e0:	mov    0x200(%rsp),%rax
  25a1e8:	mov    %rax,0xa70(%r14)
  25a1ef:	mov    0x208(%rsp),%eax
  25a1f6:	mov    %eax,0xa78(%r14)
  25a1fd:	pshufd $0x4e,0x1e0(%rsp),%xmm0
  25a207:	movdqu %xmm0,0xa60(%r14)
  25a210:	movzbl 0x20d(%rsp),%eax
  25a218:	mov    %al,0xa7d(%r14)
  25a21f:	movzbl 0x20c(%rsp),%eax
  25a227:	and    $0x1,%eax
  25a22a:	shl    $0x5,%eax
  25a22d:	mov    0x1d8(%rsp,%rax,1),%rax
  25a235:	mov    0xa58(%r14),%rcx
  25a23c:	cmp    %rcx,%rax
  25a23f:	cmova  %rax,%rcx
  25a243:	mov    %rcx,0xa58(%r14)
  25a24a:	mov    0x160(%rsp),%r13
  25a252:	mov    0x168(%rsp),%r12
  25a25a:	mov    0x170(%rsp),%r14
  25a262:	movq   $0x0,0x160(%rsp)
  25a26e:	movq   $0x8,0x168(%rsp)
  25a27a:	movq   $0x0,0x170(%rsp)
  25a286:	test   %r14,%r14
  25a289:	je     25a2f2 <<glass::engine::Engine>::apply+0x1f72>
  25a28b:	mov    0x20(%rsp),%rcx
  25a290:	mov    0x8e8(%rcx),%rax
  25a297:	mov    0x8f8(%rcx),%r15
  25a29e:	sub    %r15,%rax
  25a2a1:	cmp    %rax,%r14
  25a2a4:	ja     25a617 <<glass::engine::Engine>::apply+0x2297>
  25a2aa:	mov    %r14,%rax
  25a2ad:	shl    $0x4,%rax
  25a2b1:	lea    (%rax,%rax,2),%rdx
  25a2b5:	lea    (%r15,%r15,2),%rdi
  25a2b9:	shl    $0x4,%rdi
  25a2bd:	mov    0x20(%rsp),%rbx
  25a2c2:	add    0x8f0(%rbx),%rdi
  25a2c9:	mov    %r12,%rsi
  25a2cc:	call   *0x3976be(%rip)        # 5f1990 <memcpy@GLIBC_2.14>
  25a2d2:	add    %r14,%r15
  25a2d5:	mov    %r15,0x8f8(%rbx)
  25a2dc:	test   %r13,%r13
  25a2df:	mov    0xd0(%rsp),%rbx
  25a2e7:	je     25a2f2 <<glass::engine::Engine>::apply+0x1f72>
  25a2e9:	mov    %r12,%rdi
  25a2ec:	call   *0x3976b6(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a2f2:	mov    0x190(%rsp),%r15
  25a2fa:	lea    0x198(%rsp),%rax
  25a302:	movups (%rax),%xmm0
  25a305:	movups 0x10(%rax),%xmm1
  25a309:	movups 0x20(%rax),%xmm2
  25a30d:	movaps %xmm0,0x90(%rsp)
  25a315:	movaps %xmm1,0xa0(%rsp)
  25a31d:	movaps %xmm2,0xb0(%rsp)
  25a325:	movq   $0xffffffffffffffff,0x190(%rsp)
  25a331:	cmp    $0xffffffffffffffff,%r15
  25a335:	mov    %r13,0x30(%rsp)
  25a33a:	je     25a370 <<glass::engine::Engine>::apply+0x1ff0>
  25a33c:	mov    0x20(%rsp),%rax
  25a341:	cmpq   $0x0,0x998(%rax)
  25a349:	jle    25a3d0 <<glass::engine::Engine>::apply+0x2050>
  25a34f:	mov    (%rbx),%rdi
  25a352:	call   *0x397650(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a358:	cmpq   $0x0,0x190(%rsp)
  25a361:	setg   %bpl
  25a365:	jmp    25a3d2 <<glass::engine::Engine>::apply+0x2052>
  25a367:	nopw   0x0(%rax,%rax,1)
  25a370:	mov    %r12,%r13
  25a373:	xor    %ebp,%ebp
  25a375:	jmp    25a404 <<glass::engine::Engine>::apply+0x2084>
  25a37a:	nopw   0x0(%rax,%rax,1)
  25a380:	xor    %ecx,%ecx
  25a382:	mov    %r15,%rsi
  25a385:	cmp    %r13,%rcx
  25a388:	jae    25a0e3 <<glass::engine::Engine>::apply+0x1d63>
  25a38e:	mov    0x68(%rsp),%rdi
  25a393:	mov    %r13,%rdx
  25a396:	mov    %r13,%r8
  25a399:	call   26ff50 <<glass::engine::Mirror>::stretch>
  25a39e:	cmp    %r13,%rax
  25a3a1:	jae    25a488 <<glass::engine::Engine>::apply+0x2108>
  25a3a7:	cmpb   $0x0,0xa80(%r14)
  25a3af:	jne    25a488 <<glass::engine::Engine>::apply+0x2108>
  25a3b5:	mov    0xe0(%rsp),%rax
  25a3bd:	movzbl -0x1(%rax),%eax
  25a3c1:	shr    $0x7,%al
  25a3c4:	mov    0x68(%rsp),%rcx
  25a3c9:	mov    %al,(%rcx)
  25a3cb:	jmp    25a490 <<glass::engine::Engine>::apply+0x2110>
  25a3d0:	xor    %ebp,%ebp
  25a3d2:	mov    %r12,%r13
  25a3d5:	mov    0x20(%rsp),%rax
  25a3da:	mov    %r15,0x998(%rax)
  25a3e1:	movaps 0x90(%rsp),%xmm0
  25a3e9:	movaps 0xa0(%rsp),%xmm1
  25a3f1:	movaps 0xb0(%rsp),%xmm2
  25a3f9:	movups %xmm2,0x20(%rbx)
  25a3fd:	movups %xmm1,0x10(%rbx)
  25a401:	movups %xmm0,(%rbx)
  25a404:	mov    0x178(%rsp),%rbx
  25a40c:	mov    0x180(%rsp),%r12
  25a414:	mov    0x198(%rsp),%r15
  25a41c:	cmpq   $0x0,0x160(%rsp)
  25a425:	je     25a435 <<glass::engine::Engine>::apply+0x20b5>
  25a427:	mov    0x168(%rsp),%rdi
  25a42f:	call   *0x397573(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a435:	test   %rbx,%rbx
  25a438:	je     25a443 <<glass::engine::Engine>::apply+0x20c3>
  25a43a:	mov    %r12,%rdi
  25a43d:	call   *0x397565(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a443:	test   %bpl,%bpl
  25a446:	je     25a451 <<glass::engine::Engine>::apply+0x20d1>
  25a448:	mov    %r15,%rdi
  25a44b:	call   *0x397557(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a451:	mov    0x20(%rsp),%rdi
  25a456:	mov    %r13,%r12
  25a459:	mov    0x30(%rsp),%r13
  25a45e:	call   2575f0 <<glass::engine::Engine>::fold_sentinel>
  25a463:	test   %r14,%r14
  25a466:	setne  %al
  25a469:	test   %r13,%r13
  25a46c:	sete   %cl
  25a46f:	or     %al,%cl
  25a471:	cmp    $0x1,%cl
  25a474:	je     258470 <<glass::engine::Engine>::apply+0xf0>
  25a47a:	mov    %r12,%rdi
  25a47d:	call   *0x397525(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a483:	jmp    258470 <<glass::engine::Engine>::apply+0xf0>
  25a488:	mov    0x68(%rsp),%rax
  25a48d:	movzbl (%rax),%eax
  25a490:	mov    %al,0xa7f(%r14)
  25a497:	mov    0xd0(%rsp),%rbx
  25a49f:	mov    %r15,%rsi
  25a4a2:	xor    %ebp,%ebp
  25a4a4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a4b0:	cmpl   $0xffffffff,0x710(%r14)
  25a4b8:	jne    25a517 <<glass::engine::Engine>::apply+0x2197>
  25a4ba:	mov    0x80(%rsp),%rax
  25a4c2:	mov    %rax,0x90(%rsp)
  25a4ca:	lea    0x150(%rsp),%rax
  25a4d2:	mov    %rax,0x98(%rsp)
  25a4da:	movb   $0x0,0xa0(%rsp)
  25a4e2:	mov    %r13,%rcx
  25a4e5:	sub    %rbp,%rcx
  25a4e8:	jb     25a696 <<glass::engine::Engine>::apply+0x2316>
  25a4ee:	lea    (%rsi,%rbp,1),%rdx
  25a4f2:	mov    0xe8(%rsp),%rdi
  25a4fa:	lea    0x90(%rsp),%rsi
  25a502:	call   1a06b0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a507:	add    %rax,%rbp
  25a50a:	cmp    %r13,%rbp
  25a50d:	mov    %r15,%rsi
  25a510:	jne    25a4b0 <<glass::engine::Engine>::apply+0x2130>
  25a512:	jmp    25a1e0 <<glass::engine::Engine>::apply+0x1e60>
  25a517:	mov    %r13,%rcx
  25a51a:	sub    %rbp,%rcx
  25a51d:	jb     25a78e <<glass::engine::Engine>::apply+0x240e>
  25a523:	lea    (%rsi,%rbp,1),%rdx
  25a527:	mov    0x80(%rsp),%rdi
  25a52f:	lea    0x150(%rsp),%rsi
  25a537:	call   194410 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a53c:	jmp    25a507 <<glass::engine::Engine>::apply+0x2187>
  25a53e:	mov    %r13,%rdx
  25a541:	add    0x8(%rsp),%rsi
  25a546:	cmpb   $0x1,0x60(%rsp)
  25a54b:	jne    25a57d <<glass::engine::Engine>::apply+0x21fd>
  25a54d:	cmpl   $0xffffffff,0x710(%r14)
  25a555:	jne    25a57d <<glass::engine::Engine>::apply+0x21fd>
  25a557:	lea    0x150(%rsp),%rdi
  25a55f:	mov    %rsi,%r15
  25a562:	call   2a1bc0 <glass::engine::plain_c0>
  25a567:	test   %al,%al
  25a569:	mov    0xd0(%rsp),%rbx
  25a571:	mov    %r15,%rsi
  25a574:	mov    %r13,%rdx
  25a577:	jne    25a1e0 <<glass::engine::Engine>::apply+0x1e60>
  25a57d:	xor    %ebp,%ebp
  25a57f:	nop
  25a580:	cmpl   $0xffffffff,0x710(%r14)
  25a588:	jne    25a5ed <<glass::engine::Engine>::apply+0x226d>
  25a58a:	mov    0x80(%rsp),%rax
  25a592:	mov    %rax,0x90(%rsp)
  25a59a:	lea    0x150(%rsp),%rax
  25a5a2:	mov    %rax,0x98(%rsp)
  25a5aa:	movb   $0x0,0xa0(%rsp)
  25a5b2:	mov    %r13,%rcx
  25a5b5:	sub    %rbp,%rcx
  25a5b8:	jb     25a696 <<glass::engine::Engine>::apply+0x2316>
  25a5be:	mov    %rsi,%r15
  25a5c1:	lea    (%rsi,%rbp,1),%rdx
  25a5c5:	mov    0xe8(%rsp),%rdi
  25a5cd:	lea    0x90(%rsp),%rsi
  25a5d5:	call   1a06b0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a5da:	add    %rax,%rbp
  25a5dd:	mov    %r13,%rdx
  25a5e0:	cmp    %r13,%rbp
  25a5e3:	mov    %r15,%rsi
  25a5e6:	jne    25a580 <<glass::engine::Engine>::apply+0x2200>
  25a5e8:	jmp    25a1e0 <<glass::engine::Engine>::apply+0x1e60>
  25a5ed:	mov    %rdx,%rcx
  25a5f0:	sub    %rbp,%rcx
  25a5f3:	jb     25a78e <<glass::engine::Engine>::apply+0x240e>
  25a5f9:	mov    %rsi,%r15
  25a5fc:	lea    (%rsi,%rbp,1),%rdx
  25a600:	mov    0x80(%rsp),%rdi
  25a608:	lea    0x150(%rsp),%rsi
  25a610:	call   194410 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a615:	jmp    25a5da <<glass::engine::Engine>::apply+0x225a>
  25a617:	mov    $0x8,%ecx
  25a61c:	mov    $0x30,%r8d
  25a622:	mov    0x250(%rsp),%rdi
  25a62a:	mov    %r15,%rsi
  25a62d:	mov    %r14,%rdx
  25a630:	call   1cf9b0 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  25a635:	mov    0x20(%rsp),%rax
  25a63a:	mov    0x8f8(%rax),%r15
  25a641:	jmp    25a2aa <<glass::engine::Engine>::apply+0x1f2a>
  25a646:	add    $0x268,%rsp
  25a64d:	pop    %rbx
  25a64e:	pop    %r12
  25a650:	pop    %r13
  25a652:	pop    %r14
  25a654:	pop    %r15
  25a656:	pop    %rbp
  25a657:	ret
  25a658:	mov    %r12,%r8
  25a65b:	mov    %r12,%r13
  25a65e:	lea    0x359993(%rip),%rcx        # 5b3ff8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25a665:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a667:	mov    %rbx,%r8
  25a66a:	lea    0x36e8bf(%rip),%rcx        # 5c8f30 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x157b0>
  25a671:	mov    0x18(%rsp),%r13
  25a676:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a678:	mov    %rbx,%r8
  25a67b:	lea    0x36e8ae(%rip),%rcx        # 5c8f30 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x157b0>
  25a682:	mov    %rbp,%rdi
  25a685:	mov    %r8,%rsi
  25a688:	mov    %r13,%rdx
  25a68b:	call   *0x3974a7(%rip)        # 5f1b38 <_DYNAMIC+0x3d8>
  25a691:	jmp    25a848 <<glass::engine::Engine>::apply+0x24c8>
  25a696:	mov    %r13,%r8
  25a699:	lea    0x359958(%rip),%rcx        # 5b3ff8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25a6a0:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a6a2:	mov    %r15,%rbp
  25a6a5:	mov    %r13,%r8
  25a6a8:	lea    0x370ce1(%rip),%rcx        # 5cb390 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c10>
  25a6af:	jmp    25a671 <<glass::engine::Engine>::apply+0x22f1>
  25a6b1:	lea    0x370d08(%rip),%rcx        # 5cb3c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c40>
  25a6b8:	xor    %ebp,%ebp
  25a6ba:	jmp    25a671 <<glass::engine::Engine>::apply+0x22f1>
  25a6bc:	mov    %rbx,%r8
  25a6bf:	mov    %rbx,%r13
  25a6c2:	lea    0x35992f(%rip),%rcx        # 5b3ff8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25a6c9:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a6cb:	mov    %r13,%rbp
  25a6ce:	lea    0x36e85b(%rip),%rcx        # 5c8f30 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x157b0>
  25a6d5:	mov    0x18(%rsp),%r13
  25a6da:	mov    0x28(%rsp),%r8
  25a6df:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a6e1:	mov    0x8(%rsp),%rbp
  25a6e6:	mov    %r15,%r8
  25a6e9:	lea    0x370cb8(%rip),%rcx        # 5cb3a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c28>
  25a6f0:	jmp    25a671 <<glass::engine::Engine>::apply+0x22f1>
  25a6f5:	mov    $0xffffffffffffffff,%r8
  25a6fc:	xor    %ebp,%ebp
  25a6fe:	xor    %r13d,%r13d
  25a701:	lea    0x370c70(%rip),%rcx        # 5cb378 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bf8>
  25a708:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a70d:	mov    $0x10,%r13d
  25a713:	xor    %ebp,%ebp
  25a715:	mov    %rcx,%r8
  25a718:	lea    0x370cb9(%rip),%rcx        # 5cb3d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c58>
  25a71f:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a724:	mov    %r13,%r8
  25a727:	jmp    25a67b <<glass::engine::Engine>::apply+0x22fb>
  25a72c:	lea    0x370cbd(%rip),%rcx        # 5cb3f0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c70>
  25a733:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a738:	lea    0x370c09(%rip),%rdx        # 5cb348 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bc8>
  25a73f:	jmp    25a748 <<glass::engine::Engine>::apply+0x23c8>
  25a741:	lea    0x370c18(%rip),%rdx        # 5cb360 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17be0>
  25a748:	mov    %rsi,%rdi
  25a74b:	mov    0x18(%rsp),%rsi
  25a750:	call   *0x397222(%rip)        # 5f1978 <_DYNAMIC+0x218>
  25a756:	jmp    25a848 <<glass::engine::Engine>::apply+0x24c8>
  25a75b:	mov    $0x8,%edi
  25a760:	mov    %r15,%rsi
  25a763:	call   *0x3971ff(%rip)        # 5f1968 <_DYNAMIC+0x208>
  25a769:	mov    0x28(%rsp),%rax
  25a76e:	mov    %rax,0x18(%rsp)
  25a773:	lea    0x370bb6(%rip),%rdx        # 5cb330 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bb0>
  25a77a:	jmp    25a748 <<glass::engine::Engine>::apply+0x23c8>
  25a77c:	mov    %r12,%r8
  25a77f:	mov    %r12,%r13
  25a782:	lea    0x359887(%rip),%rcx        # 5b4010 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25a789:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a78e:	mov    %r13,%r8
  25a791:	lea    0x359878(%rip),%rcx        # 5b4010 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25a798:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a79d:	mov    %rbx,%r8
  25a7a0:	mov    %rbx,%r13
  25a7a3:	lea    0x359866(%rip),%rcx        # 5b4010 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25a7aa:	jmp    25a682 <<glass::engine::Engine>::apply+0x2302>
  25a7af:	mov    %rcx,0x18(%rsp)
  25a7b4:	lea    0x35c5ad(%rip),%rdx        # 5b6d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25a7bb:	mov    0x40(%rsp),%rsi
  25a7c0:	jmp    25a748 <<glass::engine::Engine>::apply+0x23c8>
  25a7c2:	mov    %rcx,%rsi
  25a7c5:	mov    %rdx,0x18(%rsp)
  25a7ca:	lea    0x35c597(%rip),%rdx        # 5b6d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25a7d1:	jmp    25a748 <<glass::engine::Engine>::apply+0x23c8>
  25a7d6:	lea    0x36decb(%rip),%rcx        # 5c86a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  25a7dd:	mov    0x70(%rsp),%rdi
  25a7e2:	mov    0x48(%rsp),%rsi
  25a7e7:	call   *0x39734b(%rip)        # 5f1b38 <_DYNAMIC+0x3d8>
  25a7ed:	jmp    25a848 <<glass::engine::Engine>::apply+0x24c8>
  25a7ef:	mov    %rax,0x18(%rsp)
  25a7f4:	lea    0x36eaad(%rip),%rdx        # 5c92a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  25a7fb:	mov    0x40(%rsp),%rsi
  25a800:	jmp    25a748 <<glass::engine::Engine>::apply+0x23c8>
  25a805:	mov    %rax,0x18(%rsp)
  25a80a:	lea    0x36ea7f(%rip),%rdx        # 5c9290 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  25a811:	mov    0x40(%rsp),%rsi
  25a816:	jmp    25a748 <<glass::engine::Engine>::apply+0x23c8>
  25a81b:	mov    0x78(%rsp),%rsi
  25a820:	mov    %rax,0x18(%rsp)
  25a825:	lea    0x36ea7c(%rip),%rdx        # 5c92a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  25a82c:	jmp    25a748 <<glass::engine::Engine>::apply+0x23c8>
  25a831:	lea    0x36de70(%rip),%rcx        # 5c86a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  25a838:	mov    0x70(%rsp),%rdi
  25a83d:	mov    0x48(%rsp),%rsi
  25a842:	call   *0x3972f0(%rip)        # 5f1b38 <_DYNAMIC+0x3d8>
  25a848:	ud2
  25a84a:	mov    0x78(%rsp),%rsi
  25a84f:	mov    %rax,0x18(%rsp)
  25a854:	lea    0x36ea35(%rip),%rdx        # 5c9290 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  25a85b:	jmp    25a748 <<glass::engine::Engine>::apply+0x23c8>
  25a860:	mov    %rax,%r15
  25a863:	test   %r13,%r13
  25a866:	je     25a8c7 <<glass::engine::Engine>::apply+0x2547>
  25a868:	mov    %r12,%rdi
  25a86b:	call   *0x397137(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a871:	jmp    25a8c7 <<glass::engine::Engine>::apply+0x2547>
  25a873:	mov    %rax,%r15
  25a876:	lock decq (%rbx)
  25a87a:	je     25a887 <<glass::engine::Engine>::apply+0x2507>
  25a87c:	jmp    25a8c7 <<glass::engine::Engine>::apply+0x2547>
  25a87e:	mov    %rax,%r15
  25a881:	lock decq (%r14)
  25a885:	jne    25a8c7 <<glass::engine::Engine>::apply+0x2547>
  25a887:	lea    0x90(%rsp),%rdi
  25a88f:	call   *0x397133(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  25a895:	jmp    25a8c7 <<glass::engine::Engine>::apply+0x2547>
  25a897:	mov    %rax,%r15
  25a89a:	test   %r14,%r14
  25a89d:	setne  %al
  25a8a0:	test   %r13,%r13
  25a8a3:	sete   %cl
  25a8a6:	or     %al,%cl
  25a8a8:	jne    25a933 <<glass::engine::Engine>::apply+0x25b3>
  25a8ae:	jmp    25a8f0 <<glass::engine::Engine>::apply+0x2570>
  25a8b0:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8b2:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8b4:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8b6:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8b8:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8ba:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8bc:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8be:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8c0:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8c2:	jmp    25a8c4 <<glass::engine::Engine>::apply+0x2544>
  25a8c4:	mov    %rax,%r15
  25a8c7:	cmpq   $0x0,0x160(%rsp)
  25a8d0:	jne    25a901 <<glass::engine::Engine>::apply+0x2581>
  25a8d2:	cmpq   $0x0,0x178(%rsp)
  25a8db:	jne    25a91a <<glass::engine::Engine>::apply+0x259a>
  25a8dd:	cmpq   $0x0,0x190(%rsp)
  25a8e6:	jle    25a933 <<glass::engine::Engine>::apply+0x25b3>
  25a8e8:	mov    0x198(%rsp),%r12
  25a8f0:	mov    %r12,%rdi
  25a8f3:	call   *0x3970af(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a8f9:	mov    %r15,%rdi
  25a8fc:	call   5b0070 <_Unwind_Resume@plt>
  25a901:	mov    0x168(%rsp),%rdi
  25a909:	call   *0x397099(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a90f:	cmpq   $0x0,0x178(%rsp)
  25a918:	je     25a8dd <<glass::engine::Engine>::apply+0x255d>
  25a91a:	mov    0x180(%rsp),%rdi
  25a922:	call   *0x397080(%rip)        # 5f19a8 <_DYNAMIC+0x248>
  25a928:	cmpq   $0x0,0x190(%rsp)
  25a931:	jg     25a8e8 <<glass::engine::Engine>::apply+0x2568>
  25a933:	mov    %r15,%rdi
  25a936:	call   5b0070 <_Unwind_Resume@plt>
