
/tmp/glass-i28-control-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000258340 <<glass::engine::Engine>::apply>:
  258340:	push   %rbp
  258341:	push   %r15
  258343:	push   %r14
  258345:	push   %r13
  258347:	push   %r12
  258349:	push   %rbx
  25834a:	sub    $0x248,%rsp
  258351:	mov    %rdi,%rbx
  258354:	testb  $0x10,0x6d5(%rdi)
  25835b:	jne    2583bd <<glass::engine::Engine>::apply+0x7d>
  25835d:	cmpb   $0x2,0x278(%rbx)
  258364:	jne    2583bd <<glass::engine::Engine>::apply+0x7d>
  258366:	mov    0xb0(%rbx),%rax
  25836d:	dec    %rax
  258370:	movq   $0x0,0x250(%rbx)
  25837b:	movl   $0x0,0x258(%rbx)
  258385:	movb   $0x0,0x260(%rbx)
  25838c:	mov    %rax,0x268(%rbx)
  258393:	movl   $0x0,0x270(%rbx)
  25839d:	movb   $0x1,0x278(%rbx)
  2583a4:	movb   $0x0,0x280(%rbx)
  2583ab:	movq   $0x0,0xa60(%rbx)
  2583b6:	movb   $0x1,0xa7d(%rbx)
  2583bd:	test   %rdx,%rdx
  2583c0:	je     25a698 <<glass::engine::Engine>::apply+0x2358>
  2583c6:	lea    0x10(%rbx),%rax
  2583ca:	mov    %rax,0x238(%rsp)
  2583d2:	lea    0x6f0(%rbx),%rax
  2583d9:	mov    %rax,0x78(%rsp)
  2583de:	lea    0x8e8(%rbx),%rax
  2583e5:	mov    %rax,0x228(%rsp)
  2583ed:	lea    0xa7e(%rbx),%rax
  2583f4:	mov    %rax,0x60(%rsp)
  2583f9:	lea    0x720(%rbx),%rax
  258400:	mov    %rax,0xf0(%rsp)
  258408:	lea    0x9a0(%rbx),%rax
  25840f:	mov    %rax,0xe0(%rsp)
  258417:	mov    %rbx,0x38(%rsp)
  25841c:	jmp    25843b <<glass::engine::Engine>::apply+0xfb>
  25841e:	xchg   %ax,%ax
  258420:	mov    0x110(%rsp),%rsi
  258428:	mov    0x240(%rsp),%rdx
  258430:	sub    0x18(%rsp),%rdx
  258435:	je     25a698 <<glass::engine::Engine>::apply+0x2358>
  25843b:	mov    %rsi,0x28(%rsp)
  258440:	cmp    $0x2000,%rdx
  258447:	mov    $0x2000,%eax
  25844c:	mov    %rdx,0x240(%rsp)
  258454:	cmovb  %rdx,%rax
  258458:	mov    %rax,0x18(%rsp)
  25845d:	mov    0x6d4(%rbx),%ebp
  258463:	mov    $0x1000,%eax
  258468:	and    %eax,%ebp
  25846a:	mov    0xa58(%rbx),%r9
  258471:	mov    $0x0,%r10d
  258477:	cmove  %r9,%r10
  25847b:	mov    0xa68(%rbx),%rax
  258482:	mov    %rax,%r11
  258485:	cmove  %r9,%r11
  258489:	mov    0x910(%rbx),%r13
  258490:	mov    $0x8,%r12d
  258496:	test   %r13,%r13
  258499:	je     2584fc <<glass::engine::Engine>::apply+0x1bc>
  25849b:	mov    %r11,0x58(%rsp)
  2584a0:	mov    %r10,0x10(%rsp)
  2584a5:	mov    %r9,0x8(%rsp)
  2584aa:	mov    0x908(%rbx),%r15
  2584b1:	lea    0x0(,%r13,8),%rax
  2584b9:	lea    (%rax,%rax,2),%r14
  2584bd:	mov    $0x8,%esi
  2584c2:	mov    %r14,%rdi
  2584c5:	call   *0x3992fd(%rip)        # 5f17c8 <_DYNAMIC+0x228>
  2584cb:	test   %rax,%rax
  2584ce:	je     25a795 <<glass::engine::Engine>::apply+0x2455>
  2584d4:	mov    %rax,%r12
  2584d7:	mov    %rax,%rdi
  2584da:	mov    %r15,%rsi
  2584dd:	mov    %r14,%rdx
  2584e0:	call   *0x3992ea(%rip)        # 5f17d0 <memcpy@GLIBC_2.14>
  2584e6:	mov    0xa68(%rbx),%rax
  2584ed:	mov    0x8(%rsp),%r9
  2584f2:	mov    0x10(%rsp),%r10
  2584f7:	mov    0x58(%rsp),%r11
  2584fc:	mov    0x18(%rsp),%r15
  258501:	mov    0x28(%rsp),%r14
  258506:	lea    (%r14,%r15,1),%rcx
  25850a:	mov    %rcx,0x110(%rsp)
  258512:	mov    0xa78(%rbx),%ecx
  258518:	mov    0xa60(%rbx),%rdx
  25851f:	movzbl 0xa7d(%rbx),%esi
  258526:	movzbl 0xa81(%rbx),%edi
  25852d:	mov    0x238(%rsp),%r8
  258535:	mov    %r8,0x1a8(%rsp)
  25853d:	movq   $0x0,0x140(%rsp)
  258549:	movq   $0x8,0x148(%rsp)
  258555:	movq   $0x0,0x150(%rsp)
  258561:	mov    %r13,0x158(%rsp)
  258569:	mov    %r12,0x160(%rsp)
  258571:	mov    %r13,0x168(%rsp)
  258579:	mov    %r11,0x1b0(%rsp)
  258581:	mov    %r10,0x1b8(%rsp)
  258589:	shr    $0xc,%ebp
  25858c:	mov    %bpl,0x1ec(%rsp)
  258594:	mov    %rax,0x1c0(%rsp)
  25859c:	mov    %ecx,0x1e8(%rsp)
  2585a3:	mov    %rdx,0x1c8(%rsp)
  2585ab:	mov    %sil,0x1ed(%rsp)
  2585b3:	mov    %r15,0x1d0(%rsp)
  2585bb:	movups (%rbx),%xmm0
  2585be:	movaps %xmm0,0x130(%rsp)
  2585c6:	movq   $0xffffffffffffffff,0x170(%rsp)
  2585d2:	mov    %r9,0x1d8(%rsp)
  2585da:	mov    %dil,0x1ee(%rsp)
  2585e2:	mov    0xa70(%rbx),%rax
  2585e9:	mov    %rax,0x1e0(%rsp)
  2585f1:	test   %dil,%dil
  2585f4:	mov    %rbx,%r12
  2585f7:	je     25a110 <<glass::engine::Engine>::apply+0x1dd0>
  2585fd:	mov    $0x3,%eax
  258602:	sub    %r15,%rax
  258605:	mov    %rax,0x230(%rsp)
  25860d:	mov    $0x1,%al
  25860f:	mov    %eax,0xdc(%rsp)
  258616:	xor    %ebp,%ebp
  258618:	mov    %r14,0x1f8(%rsp)
  258620:	mov    $0x1,%al
  258622:	mov    %eax,0x104(%rsp)
  258629:	movq   $0x0,0x8(%rsp)
  258632:	movl   $0x0,0xd0(%rsp)
  25863d:	movq   $0x0,0x58(%rsp)
  258646:	xor    %r13d,%r13d
  258649:	testb  $0x1,0xdc(%rsp)
  258651:	je     2586b0 <<glass::engine::Engine>::apply+0x370>
  258653:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258660:	mov    0x3999f9(%rip),%rax        # 5f2060 <_DYNAMIC+0xac0>
  258667:	mov    (%rax),%rax
  25866a:	mov    $0x1b,%edi
  25866f:	mov    0x1f8(%rsp),%rsi
  258677:	mov    0x110(%rsp),%rdx
  25867f:	call   *%rax
  258681:	cmp    $0x1,%rax
  258685:	jne    2586b0 <<glass::engine::Engine>::apply+0x370>
  258687:	mov    %rdx,%rax
  25868a:	sub    0x28(%rsp),%rax
  25868f:	inc    %rdx
  258692:	mov    $0x1,%cl
  258694:	mov    %ecx,0xdc(%rsp)
  25869b:	mov    %rdx,0x1f8(%rsp)
  2586a3:	jmp    2586d9 <<glass::engine::Engine>::apply+0x399>
  2586a5:	data16 cs nopw 0x0(%rax,%rax,1)
  2586b0:	testb  $0x1,0x104(%rsp)
  2586b8:	je     25a180 <<glass::engine::Engine>::apply+0x1e40>
  2586be:	movl   $0x0,0x104(%rsp)
  2586c9:	mov    0x18(%rsp),%rax
  2586ce:	movl   $0x0,0xdc(%rsp)
  2586d9:	mov    %rax,%rdx
  2586dc:	sub    %r13,%rax
  2586df:	cmp    $0x18,%rax
  2586e3:	mov    %rdx,0x10(%rsp)
  2586e8:	jb     258d30 <<glass::engine::Engine>::apply+0x9f0>
  2586ee:	cmp    %rdx,0x18(%rsp)
  2586f3:	jae    258738 <<glass::engine::Engine>::apply+0x3f8>
  2586f5:	jmp    25a6f9 <<glass::engine::Engine>::apply+0x23b9>
  2586fa:	mov    0x58(%rsp),%rax
  2586ff:	mov    %eax,%ebp
  258701:	mov    0x38(%rsp),%rax
  258706:	cmpl   $0xffffffff,0x710(%rax)
  25870d:	je     258a96 <<glass::engine::Engine>::apply+0x756>
  258713:	mov    %ebp,%eax
  258715:	mov    %rax,0x58(%rsp)
  25871a:	nopw   0x0(%rax,%rax,1)
  258720:	mov    0x10(%rsp),%rdx
  258725:	mov    %rdx,%rax
  258728:	sub    %r13,%rax
  25872b:	mov    %r13,%rbp
  25872e:	cmp    $0x17,%rax
  258732:	jbe    258d33 <<glass::engine::Engine>::apply+0x9f3>
  258738:	lea    0xb0(%rsp),%rdi
  258740:	mov    0x28(%rsp),%rsi
  258745:	mov    %r13,%rcx
  258748:	call   2a1730 <glass::engine::next_run>
  25874d:	movzbl 0xc0(%rsp),%r12d
  258756:	cmp    $0x2,%r12b
  25875a:	je     258dc0 <<glass::engine::Engine>::apply+0xa80>
  258760:	mov    0xb0(%rsp),%rbx
  258768:	cmp    %rbp,%rbx
  25876b:	jb     25a6b6 <<glass::engine::Engine>::apply+0x2376>
  258771:	mov    0x18(%rsp),%r15
  258776:	cmp    %r15,%rbx
  258779:	ja     25a6c7 <<glass::engine::Engine>::apply+0x2387>
  25877f:	mov    0xb8(%rsp),%r13
  258787:	mov    0x28(%rsp),%rax
  25878c:	lea    (%rax,%rbp,1),%r15
  258790:	lea    (%rax,%rbx,1),%r14
  258794:	mov    0x3998bd(%rip),%rax        # 5f2058 <_DYNAMIC+0xab8>
  25879b:	mov    (%rax),%rax
  25879e:	mov    $0x1b,%edi
  2587a3:	mov    %r15,%rsi
  2587a6:	mov    %r14,%rdx
  2587a9:	call   *%rax
  2587ab:	cmp    $0x1,%rax
  2587af:	jne    2587cd <<glass::engine::Engine>::apply+0x48d>
  2587b1:	sub    %r15,%rdx
  2587b4:	mov    0x38(%rsp),%rax
  2587b9:	movb   $0x1,0xa80(%rax)
  2587c0:	movb   $0x0,0xa7e(%rax)
  2587c7:	add    %rdx,%rbp
  2587ca:	inc    %rbp
  2587cd:	cmp    %rbx,%rbp
  2587d0:	jae    25880e <<glass::engine::Engine>::apply+0x4ce>
  2587d2:	mov    0x60(%rsp),%rdi
  2587d7:	mov    0x28(%rsp),%rsi
  2587dc:	mov    0x18(%rsp),%rdx
  2587e1:	mov    %rbp,%rcx
  2587e4:	mov    %rbx,%r8
  2587e7:	call   26ff80 <<glass::engine::Mirror>::stretch>
  2587ec:	cmp    %rbx,%rax
  2587ef:	jae    25880e <<glass::engine::Engine>::apply+0x4ce>
  2587f1:	mov    0x38(%rsp),%rax
  2587f6:	cmpb   $0x0,0xa80(%rax)
  2587fd:	jne    25880e <<glass::engine::Engine>::apply+0x4ce>
  2587ff:	movzbl -0x1(%r14),%eax
  258804:	shr    $0x7,%al
  258807:	mov    0x60(%rsp),%rcx
  25880c:	mov    %al,(%rcx)
  25880e:	mov    0x60(%rsp),%rdi
  258813:	mov    0x28(%rsp),%rsi
  258818:	mov    0x18(%rsp),%rdx
  25881d:	mov    %rbx,%rcx
  258820:	mov    %r13,%r8
  258823:	call   26ff80 <<glass::engine::Mirror>::stretch>
  258828:	mov    %rax,%rbx
  25882b:	mov    0x38(%rsp),%rax
  258830:	cmpb   $0x0,0xa80(%rax)
  258837:	jne    258720 <<glass::engine::Engine>::apply+0x3e0>
  25883d:	lea    -0x1(%r13),%r14
  258841:	cmp    0x18(%rsp),%r14
  258846:	jae    25a744 <<glass::engine::Engine>::apply+0x2404>
  25884c:	mov    0x28(%rsp),%rax
  258851:	movzbl (%rax,%r14,1),%eax
  258856:	shr    $0x7,%al
  258859:	mov    0x60(%rsp),%rcx
  25885e:	mov    %al,(%rcx)
  258860:	test   %rbx,%rbx
  258863:	je     258892 <<glass::engine::Engine>::apply+0x552>
  258865:	lea    -0x1(%rbx),%r14
  258869:	cmp    0x18(%rsp),%r14
  25886e:	jae    25a761 <<glass::engine::Engine>::apply+0x2421>
  258874:	mov    0x28(%rsp),%rax
  258879:	movzbl (%rax,%r14,1),%eax
  25887e:	shr    $0x7,%al
  258881:	mov    %r13,%r14
  258884:	sub    %rbx,%r14
  258887:	cmp    $0x18,%r14
  25888b:	jae    2588ae <<glass::engine::Engine>::apply+0x56e>
  25888d:	jmp    258720 <<glass::engine::Engine>::apply+0x3e0>
  258892:	mov    0x38(%rsp),%rax
  258897:	movzbl 0xa7f(%rax),%eax
  25889e:	mov    %r13,%r14
  2588a1:	sub    %rbx,%r14
  2588a4:	cmp    $0x18,%r14
  2588a8:	jb     258720 <<glass::engine::Engine>::apply+0x3e0>
  2588ae:	test   %al,%al
  2588b0:	jne    258720 <<glass::engine::Engine>::apply+0x3e0>
  2588b6:	mov    %rbx,%r15
  2588b9:	sub    0x8(%rsp),%r15
  2588be:	jbe    2586fa <<glass::engine::Engine>::apply+0x3ba>
  2588c4:	movzbl 0x39f1ad(%rip),%eax        # 5f7a78 <glass::engine::probes::RUN_PROBE>
  2588cb:	mov    $0x1,%bpl
  2588ce:	cmp    $0x68,%al
  2588d0:	je     258a7f <<glass::engine::Engine>::apply+0x73f>
  2588d6:	cmp    0x18(%rsp),%rbx
  2588db:	ja     25a70c <<glass::engine::Engine>::apply+0x23cc>
  2588e1:	mov    0x8(%rsp),%rax
  2588e6:	add    0x28(%rsp),%rax
  2588eb:	mov    %rax,0x8(%rsp)
  2588f0:	cmpb   $0x1,0x58(%rsp)
  2588f5:	jne    258922 <<glass::engine::Engine>::apply+0x5e2>
  2588f7:	mov    0x38(%rsp),%rax
  2588fc:	cmpl   $0xffffffff,0x710(%rax)
  258903:	jne    258922 <<glass::engine::Engine>::apply+0x5e2>
  258905:	lea    0x130(%rsp),%rdi
  25890d:	mov    0x8(%rsp),%rsi
  258912:	mov    %r15,%rdx
  258915:	call   2a1a20 <glass::engine::plain_c0>
  25891a:	test   %al,%al
  25891c:	jne    258a7f <<glass::engine::Engine>::apply+0x73f>
  258922:	movzbl 0x39f15f(%rip),%eax        # 5f7a88 <glass::engine::timers::ON>
  258929:	test   %al,%al
  25892b:	je     258b5f <<glass::engine::Engine>::apply+0x81f>
  258931:	mov    $0x1,%edi
  258936:	call   50e8c0 <<std::sys::pal::unix::time::Timespec>::now>
  25893b:	mov    %rax,0x58(%rsp)
  258940:	mov    %edx,0x30(%rsp)
  258944:	xor    %ebp,%ebp
  258946:	cs nopw 0x0(%rax,%rax,1)
  258950:	mov    0x38(%rsp),%rax
  258955:	cmpl   $0xffffffff,0x710(%rax)
  25895c:	jne    2589b7 <<glass::engine::Engine>::apply+0x677>
  25895e:	mov    0x78(%rsp),%rax
  258963:	mov    %rax,0x80(%rsp)
  25896b:	lea    0x130(%rsp),%rax
  258973:	mov    %rax,0x88(%rsp)
  25897b:	movb   $0x0,0x90(%rsp)
  258983:	mov    %r15,%rcx
  258986:	sub    %rbp,%rcx
  258989:	jb     25a6aa <<glass::engine::Engine>::apply+0x236a>
  25898f:	mov    0x8(%rsp),%rax
  258994:	lea    (%rax,%rbp,1),%rdx
  258998:	mov    0xf0(%rsp),%rdi
  2589a0:	lea    0x80(%rsp),%rsi
  2589a8:	call   1a0670 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  2589ad:	add    %rax,%rbp
  2589b0:	cmp    %r15,%rbp
  2589b3:	jne    258950 <<glass::engine::Engine>::apply+0x610>
  2589b5:	jmp    2589e0 <<glass::engine::Engine>::apply+0x6a0>
  2589b7:	mov    %r15,%rcx
  2589ba:	sub    %rbp,%rcx
  2589bd:	jb     25a7b6 <<glass::engine::Engine>::apply+0x2476>
  2589c3:	mov    0x8(%rsp),%rax
  2589c8:	lea    (%rax,%rbp,1),%rdx
  2589cc:	mov    0x78(%rsp),%rdi
  2589d1:	lea    0x130(%rsp),%rsi
  2589d9:	call   1943d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  2589de:	jmp    2589ad <<glass::engine::Engine>::apply+0x66d>
  2589e0:	movzbl 0x39f0a1(%rip),%eax        # 5f7a88 <glass::engine::timers::ON>
  2589e7:	test   %al,%al
  2589e9:	mov    $0x1,%bpl
  2589ec:	je     258a7f <<glass::engine::Engine>::apply+0x73f>
  2589f2:	mov    $0x1,%edi
  2589f7:	call   50e8c0 <<std::sys::pal::unix::time::Timespec>::now>
  2589fc:	mov    %rax,0x200(%rsp)
  258a04:	mov    %edx,0x208(%rsp)
  258a0b:	mov    0x58(%rsp),%rax
  258a10:	mov    %rax,0x210(%rsp)
  258a18:	mov    0x30(%rsp),%eax
  258a1c:	mov    %eax,0x218(%rsp)
  258a23:	lea    0x80(%rsp),%rdi
  258a2b:	lea    0x200(%rsp),%rsi
  258a33:	lea    0x210(%rsp),%rdx
  258a3b:	call   50e800 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258a40:	imul   $0x3b9aca00,0x88(%rsp),%rax
  258a4c:	mov    0x90(%rsp),%ecx
  258a53:	add    %rcx,%rax
  258a56:	cmpb   $0x0,0x80(%rsp)
  258a5e:	mov    $0x0,%ecx
  258a63:	cmove  %rax,%rcx
  258a67:	lock add %rcx,0x39f029(%rip)        # 5f7a98 <glass::engine::timers::VTE_NS>
  258a6f:	lock incq 0x39f051(%rip)        # 5f7ac8 <glass::engine::timers::VTE_CALLS>
  258a77:	lock add %r15,0x39f041(%rip)        # 5f7ac0 <glass::engine::timers::VTE_BYTES>
  258a7f:	mov    %rbx,0x8(%rsp)
  258a84:	mov    0x38(%rsp),%rax
  258a89:	cmpl   $0xffffffff,0x710(%rax)
  258a90:	jne    258713 <<glass::engine::Engine>::apply+0x3d3>
  258a96:	cmp    0x18(%rsp),%r13
  258a9b:	ja     25a6e5 <<glass::engine::Engine>::apply+0x23a5>
  258aa1:	cmp    %rbx,%r13
  258aa4:	jb     25a6e5 <<glass::engine::Engine>::apply+0x23a5>
  258aaa:	movzbl 0x39efc6(%rip),%r15d        # 5f7a78 <glass::engine::probes::RUN_PROBE>
  258ab2:	movzbl 0x39efcf(%rip),%eax        # 5f7a88 <glass::engine::timers::ON>
  258ab9:	test   %al,%al
  258abb:	je     258aec <<glass::engine::Engine>::apply+0x7ac>
  258abd:	mov    $0x1,%edi
  258ac2:	call   50e8c0 <<std::sys::pal::unix::time::Timespec>::now>
  258ac7:	mov    %rax,0x58(%rsp)
  258acc:	mov    %edx,%ebp
  258ace:	cmp    $0x63,%r15b
  258ad2:	jbe    258af7 <<glass::engine::Engine>::apply+0x7b7>
  258ad4:	movzbl %r12b,%eax
  258ad8:	mov    %r14,%rbx
  258adb:	sub    %rax,%rbx
  258ade:	cmp    $0xffffffff,%ebp
  258ae1:	jne    258c6a <<glass::engine::Engine>::apply+0x92a>
  258ae7:	jmp    258d02 <<glass::engine::Engine>::apply+0x9c2>
  258aec:	mov    $0xffffffff,%ebp
  258af1:	cmp    $0x63,%r15b
  258af5:	ja     258ad4 <<glass::engine::Engine>::apply+0x794>
  258af7:	mov    0x39bc83(%rip),%eax        # 5f4780 <glass::engine::run_whole::ON>
  258afd:	test   %eax,%eax
  258aff:	jne    258d21 <<glass::engine::Engine>::apply+0x9e1>
  258b05:	mov    0x28(%rsp),%rax
  258b0a:	lea    (%rax,%rbx,1),%rsi
  258b0e:	cmpb   $0x0,0x39bc6f(%rip)        # 5f4784 <glass::engine::run_whole::ON+0x4>
  258b15:	je     258b36 <<glass::engine::Engine>::apply+0x7f6>
  258b17:	test   $0x1,%r12b
  258b1b:	je     258c1f <<glass::engine::Engine>::apply+0x8df>
  258b21:	lea    0x130(%rsp),%rdi
  258b29:	mov    %r14,%rdx
  258b2c:	call   264d40 <<glass::engine::Watch>::print_run>
  258b31:	jmp    258c2f <<glass::engine::Engine>::apply+0x8ef>
  258b36:	test   $0x1,%r12b
  258b3a:	je     258c4e <<glass::engine::Engine>::apply+0x90e>
  258b40:	cmp    %rbx,%r13
  258b43:	je     25a722 <<glass::engine::Engine>::apply+0x23e2>
  258b49:	lea    -0x1(%r14),%rdx
  258b4d:	lea    0x130(%rsp),%rdi
  258b55:	call   264d40 <<glass::engine::Watch>::print_run>
  258b5a:	jmp    258c5e <<glass::engine::Engine>::apply+0x91e>
  258b5f:	xor    %ebp,%ebp
  258b61:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258b70:	mov    0x38(%rsp),%rax
  258b75:	cmpl   $0xffffffff,0x710(%rax)
  258b7c:	jne    258bd7 <<glass::engine::Engine>::apply+0x897>
  258b7e:	mov    0x78(%rsp),%rax
  258b83:	mov    %rax,0x80(%rsp)
  258b8b:	lea    0x130(%rsp),%rax
  258b93:	mov    %rax,0x88(%rsp)
  258b9b:	movb   $0x0,0x90(%rsp)
  258ba3:	mov    %r15,%rcx
  258ba6:	sub    %rbp,%rcx
  258ba9:	jb     25a6aa <<glass::engine::Engine>::apply+0x236a>
  258baf:	mov    0x8(%rsp),%rax
  258bb4:	lea    (%rax,%rbp,1),%rdx
  258bb8:	mov    0xf0(%rsp),%rdi
  258bc0:	lea    0x80(%rsp),%rsi
  258bc8:	call   1a0670 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258bcd:	add    %rax,%rbp
  258bd0:	cmp    %r15,%rbp
  258bd3:	jne    258b70 <<glass::engine::Engine>::apply+0x830>
  258bd5:	jmp    258c00 <<glass::engine::Engine>::apply+0x8c0>
  258bd7:	mov    %r15,%rcx
  258bda:	sub    %rbp,%rcx
  258bdd:	jb     25a7b6 <<glass::engine::Engine>::apply+0x2476>
  258be3:	mov    0x8(%rsp),%rax
  258be8:	lea    (%rax,%rbp,1),%rdx
  258bec:	mov    0x78(%rsp),%rdi
  258bf1:	lea    0x130(%rsp),%rsi
  258bf9:	call   1943d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258bfe:	jmp    258bcd <<glass::engine::Engine>::apply+0x88d>
  258c00:	mov    %rbx,0x8(%rsp)
  258c05:	mov    $0x1,%bpl
  258c08:	mov    0x38(%rsp),%rax
  258c0d:	cmpl   $0xffffffff,0x710(%rax)
  258c14:	jne    258713 <<glass::engine::Engine>::apply+0x3d3>
  258c1a:	jmp    258a96 <<glass::engine::Engine>::apply+0x756>
  258c1f:	lea    0x130(%rsp),%rdi
  258c27:	mov    %r14,%rdx
  258c2a:	call   2623a0 <<glass::engine::Watch>::print_utf8>
  258c2f:	mov    %rax,%rbx
  258c32:	mov    0x1e0(%rsp),%eax
  258c39:	mov    0x38(%rsp),%rcx
  258c3e:	mov    %eax,0x718(%rcx)
  258c44:	cmp    $0xffffffff,%ebp
  258c47:	jne    258c6a <<glass::engine::Engine>::apply+0x92a>
  258c49:	jmp    258d02 <<glass::engine::Engine>::apply+0x9c2>
  258c4e:	lea    0x130(%rsp),%rdi
  258c56:	mov    %r14,%rdx
  258c59:	call   2623a0 <<glass::engine::Watch>::print_utf8>
  258c5e:	mov    %rax,%rbx
  258c61:	cmp    $0xffffffff,%ebp
  258c64:	je     258d02 <<glass::engine::Engine>::apply+0x9c2>
  258c6a:	movzbl 0x39ee17(%rip),%eax        # 5f7a88 <glass::engine::timers::ON>
  258c71:	test   %al,%al
  258c73:	je     258cfa <<glass::engine::Engine>::apply+0x9ba>
  258c79:	mov    $0x1,%edi
  258c7e:	call   50e8c0 <<std::sys::pal::unix::time::Timespec>::now>
  258c83:	mov    %rax,0x200(%rsp)
  258c8b:	mov    %edx,0x208(%rsp)
  258c92:	mov    0x58(%rsp),%rax
  258c97:	mov    %rax,0x210(%rsp)
  258c9f:	mov    %ebp,0x218(%rsp)
  258ca6:	lea    0x80(%rsp),%rdi
  258cae:	lea    0x200(%rsp),%rsi
  258cb6:	lea    0x210(%rsp),%rdx
  258cbe:	call   50e800 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258cc3:	imul   $0x3b9aca00,0x88(%rsp),%rax
  258ccf:	mov    0x90(%rsp),%ecx
  258cd6:	add    %rcx,%rax
  258cd9:	cmpb   $0x0,0x80(%rsp)
  258ce1:	mov    $0x0,%ecx
  258ce6:	cmove  %rax,%rcx
  258cea:	lock add %rcx,0x39ed9e(%rip)        # 5f7a90 <glass::engine::timers::RUN_NS>
  258cf2:	lock incq 0x39edbe(%rip)        # 5f7ab8 <glass::engine::timers::RUN_CALLS>
  258cfa:	lock add %r14,0x39edae(%rip)        # 5f7ab0 <glass::engine::timers::RUN_BYTES>
  258d02:	movzbl 0x39edcf(%rip),%eax        # 5f7ad8 <glass::engine::counters::COUNTING>
  258d09:	test   %al,%al
  258d0b:	je     258d15 <<glass::engine::Engine>::apply+0x9d5>
  258d0d:	lock add %rbx,0x39edbb(%rip)        # 5f7ad0 <glass::engine::counters::LANE_RUN_BYTES>
  258d15:	add    %rbx,0x8(%rsp)
  258d1a:	mov    $0x1,%al
  258d1c:	jmp    258715 <<glass::engine::Engine>::apply+0x3d5>
  258d21:	call   18ba06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  258d26:	jmp    258b05 <<glass::engine::Engine>::apply+0x7c5>
  258d2b:	nopl   0x0(%rax,%rax,1)
  258d30:	mov    %rbp,%r13
  258d33:	mov    $0x1,%ebx
  258d38:	mov    0x18(%rsp),%rax
  258d3d:	sub    %rdx,%rax
  258d40:	jbe    258ddb <<glass::engine::Engine>::apply+0xa9b>
  258d46:	mov    0x8(%rsp),%rcx
  258d4b:	cmp    %rcx,0xe8(%rsp)
  258d53:	sete   %r9b
  258d57:	cmp    $0x2,%rax
  258d5b:	mov    0x38(%rsp),%r12
  258d60:	jb     258db0 <<glass::engine::Engine>::apply+0xa70>
  258d62:	mov    0x28(%rsp),%rcx
  258d67:	mov    0x10(%rsp),%rdx
  258d6c:	lea    (%rcx,%rdx,1),%rbp
  258d70:	cmpb   $0x5b,0x1(%rbp)
  258d74:	jne    258db0 <<glass::engine::Engine>::apply+0xa70>
  258d76:	xorps  %xmm0,%xmm0
  258d79:	movaps %xmm0,0x90(%rsp)
  258d81:	movaps %xmm0,0x80(%rsp)
  258d89:	cmp    $0x2,%rax
  258d8d:	je     258db0 <<glass::engine::Engine>::apply+0xa70>
  258d8f:	movzbl 0x2(%rbp),%ecx
  258d93:	lea    -0x30(%rcx),%eax
  258d96:	cmp    $0xa,%al
  258d98:	jae    258e01 <<glass::engine::Engine>::apply+0xac1>
  258d9a:	movzbl %al,%eax
  258d9d:	xor    %r14d,%r14d
  258da0:	mov    0x10(%rsp),%rcx
  258da5:	add    $0x3,%rcx
  258da9:	cmp    0x18(%rsp),%rcx
  258dae:	jne    258e27 <<glass::engine::Engine>::apply+0xae7>
  258db0:	movl   $0x0,0xd0(%rsp)
  258dbb:	jmp    258de0 <<glass::engine::Engine>::apply+0xaa0>
  258dbd:	nopl   (%rax)
  258dc0:	mov    %rbp,%r13
  258dc3:	mov    0x10(%rsp),%rdx
  258dc8:	mov    $0x1,%ebx
  258dcd:	mov    0x18(%rsp),%rax
  258dd2:	sub    %rdx,%rax
  258dd5:	ja     258d46 <<glass::engine::Engine>::apply+0xa06>
  258ddb:	mov    0x38(%rsp),%r12
  258de0:	mov    0x10(%rsp),%r8
  258de5:	add    %r8,%rbx
  258de8:	mov    %r13,%rbp
  258deb:	mov    %rbx,%r13
  258dee:	testb  $0x1,0xdc(%rsp)
  258df6:	je     2586b0 <<glass::engine::Engine>::apply+0x370>
  258dfc:	jmp    258660 <<glass::engine::Engine>::apply+0x320>
  258e01:	movzbl %cl,%edx
  258e04:	xor    %eax,%eax
  258e06:	lea    -0x48(%rdx),%esi
  258e09:	cmp    $0x25,%esi
  258e0c:	ja     258e40 <<glass::engine::Engine>::apply+0xb00>
  258e0e:	mov    $0x3,%r8d
  258e14:	lea    -0x1ea693(%rip),%rdi        # 6e788 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2cd7>
  258e1b:	movslq (%rdi,%rsi,4),%rdx
  258e1f:	add    %rdi,%rdx
  258e22:	xor    %r14d,%r14d
  258e25:	jmp    *%rdx
  258e27:	mov    0x10(%rsp),%rcx
  258e2c:	mov    0x230(%rsp),%rdx
  258e34:	lea    (%rdx,%rcx,1),%rsi
  258e38:	mov    $0x4,%r8d
  258e3e:	jmp    258e83 <<glass::engine::Engine>::apply+0xb43>
  258e40:	mov    $0x1,%r14d
  258e46:	cmp    $0x3b,%edx
  258e49:	je     258da0 <<glass::engine::Engine>::apply+0xa60>
  258e4f:	jmp    258db0 <<glass::engine::Engine>::apply+0xa70>
  258e54:	mov    $0xffff,%cx
  258e58:	nopl   0x0(%rax,%rax,1)
  258e60:	movzbl %dil,%eax
  258e64:	add    %cx,%ax
  258e67:	mov    $0xffff,%ecx
  258e6c:	cmovb  %ecx,%eax
  258e6f:	lea    (%rsi,%r8,1),%rcx
  258e73:	inc    %rcx
  258e76:	inc    %r8
  258e79:	cmp    $0x4,%rcx
  258e7d:	je     258db0 <<glass::engine::Engine>::apply+0xa70>
  258e83:	movzbl -0x1(%rbp,%r8,1),%ecx
  258e89:	lea    -0x30(%rcx),%edi
  258e8c:	cmp    $0xa,%dil
  258e90:	jae    258ea0 <<glass::engine::Engine>::apply+0xb60>
  258e92:	mov    $0xa,%cx
  258e96:	mul    %cx
  258e99:	jo     258e54 <<glass::engine::Engine>::apply+0xb14>
  258e9b:	mov    %eax,%ecx
  258e9d:	jmp    258e60 <<glass::engine::Engine>::apply+0xb20>
  258e9f:	nop
  258ea0:	movzbl %cl,%edx
  258ea3:	cmp    $0x3b,%edx
  258ea6:	jne    258ee3 <<glass::engine::Engine>::apply+0xba3>
  258ea8:	lea    0x1(%r14),%rcx
  258eac:	cmp    $0x10,%rcx
  258eb0:	jae    258db0 <<glass::engine::Engine>::apply+0xa70>
  258eb6:	cmp    $0xf,%r14
  258eba:	ja     25a77b <<glass::engine::Engine>::apply+0x243b>
  258ec0:	mov    %ax,0x80(%rsp,%r14,2)
  258ec9:	xor    %eax,%eax
  258ecb:	mov    %rcx,%r14
  258ece:	lea    (%rsi,%r8,1),%rcx
  258ed2:	inc    %rcx
  258ed5:	inc    %r8
  258ed8:	cmp    $0x4,%rcx
  258edc:	jne    258e83 <<glass::engine::Engine>::apply+0xb43>
  258ede:	jmp    258db0 <<glass::engine::Engine>::apply+0xa70>
  258ee3:	add    $0xffffffb8,%edx
  258ee6:	cmp    $0x25,%edx
  258ee9:	ja     258db0 <<glass::engine::Engine>::apply+0xa70>
  258eef:	lea    -0x1ea6d6(%rip),%rsi        # 6e820 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d6f>
  258ef6:	movslq (%rsi,%rdx,4),%rdx
  258efa:	add    %rsi,%rdx
  258efd:	jmp    *%rdx
  258eff:	cmp    $0x10,%r14
  258f03:	jae    25a7a3 <<glass::engine::Engine>::apply+0x2463>
  258f09:	mov    %r8,0x120(%rsp)
  258f11:	mov    %ax,0x80(%rsp,%r14,2)
  258f1a:	cmp    $0x6d,%cl
  258f1d:	setne  %cl
  258f20:	movaps 0x80(%rsp),%xmm0
  258f28:	movaps 0x90(%rsp),%xmm1
  258f30:	movaps %xmm0,0xb0(%rsp)
  258f38:	movaps %xmm1,0xc0(%rsp)
  258f40:	xor    %edx,%edx
  258f42:	jmp    258f83 <<glass::engine::Engine>::apply+0xc43>
  258f44:	cmp    $0x10,%r14
  258f48:	jae    25a7c5 <<glass::engine::Engine>::apply+0x2485>
  258f4e:	mov    %r8,0x120(%rsp)
  258f56:	mov    %ax,0x80(%rsp,%r14,2)
  258f5f:	movaps 0x80(%rsp),%xmm0
  258f67:	movaps 0x90(%rsp),%xmm1
  258f6f:	movaps %xmm0,0xb0(%rsp)
  258f77:	movaps %xmm1,0xc0(%rsp)
  258f7f:	mov    $0x1,%dl
  258f81:	xor    %ecx,%ecx
  258f83:	lea    0x1(%r14),%rax
  258f87:	movaps 0xb0(%rsp),%xmm0
  258f8f:	movaps 0xc0(%rsp),%xmm1
  258f97:	movaps %xmm1,0x90(%rsp)
  258f9f:	movaps %xmm0,0x80(%rsp)
  258fa7:	mov    %rax,0xa0(%rsp)
  258faf:	mov    %cl,0xa8(%rsp)
  258fb6:	mov    %dl,0xa9(%rsp)
  258fbd:	mov    0x10(%rsp),%r8
  258fc2:	cmp    %r13,%r8
  258fc5:	jb     25a737 <<glass::engine::Engine>::apply+0x23f7>
  258fcb:	mov    %r9b,0x30(%rsp)
  258fd0:	mov    %edx,0x12c(%rsp)
  258fd7:	mov    %ecx,0x128(%rsp)
  258fde:	mov    0x28(%rsp),%rax
  258fe3:	lea    (%rax,%r13,1),%r15
  258fe7:	mov    0x39906a(%rip),%rax        # 5f2058 <_DYNAMIC+0xab8>
  258fee:	mov    (%rax),%rax
  258ff1:	mov    $0x1b,%edi
  258ff6:	mov    %r15,%rsi
  258ff9:	mov    %rbp,%rdx
  258ffc:	call   *%rax
  258ffe:	cmp    $0x1,%rax
  259002:	jne    25901f <<glass::engine::Engine>::apply+0xcdf>
  259004:	sub    %r15,%rdx
  259007:	movb   $0x1,0xa80(%r12)
  259010:	movb   $0x0,0xa7e(%r12)
  259019:	add    %rdx,%r13
  25901c:	inc    %r13
  25901f:	mov    0x10(%rsp),%r8
  259024:	cmp    %r8,%r13
  259027:	jae    259079 <<glass::engine::Engine>::apply+0xd39>
  259029:	mov    0x60(%rsp),%rdi
  25902e:	mov    0x28(%rsp),%rsi
  259033:	mov    0x18(%rsp),%rdx
  259038:	mov    %r13,%rcx
  25903b:	call   26ff80 <<glass::engine::Mirror>::stretch>
  259040:	movzbl 0xa80(%r12),%ecx
  259049:	test   %cl,%cl
  25904b:	setne  %dl
  25904e:	mov    0x10(%rsp),%r8
  259053:	cmp    %r8,%rax
  259056:	setae  %al
  259059:	or     %dl,%al
  25905b:	jne    259082 <<glass::engine::Engine>::apply+0xd42>
  25905d:	movzbl -0x1(%rbp),%eax
  259061:	shr    $0x7,%al
  259064:	mov    0x60(%rsp),%rcx
  259069:	mov    %al,(%rcx)
  25906b:	mov    0x28(%rsp),%r9
  259070:	test   %al,%al
  259072:	jne    25909f <<glass::engine::Engine>::apply+0xd5f>
  259074:	jmp    259170 <<glass::engine::Engine>::apply+0xe30>
  259079:	movzbl 0xa80(%r12),%ecx
  259082:	test   %cl,%cl
  259084:	mov    0x28(%rsp),%r9
  259089:	jne    2593bc <<glass::engine::Engine>::apply+0x107c>
  25908f:	mov    0x60(%rsp),%rax
  259094:	movzbl (%rax),%eax
  259097:	test   %al,%al
  259099:	je     259170 <<glass::engine::Engine>::apply+0xe30>
  25909f:	mov    0x10(%rsp),%r8
  2590a4:	test   %r8,%r8
  2590a7:	je     2593bc <<glass::engine::Engine>::apply+0x107c>
  2590ad:	cmpb   $0xc0,-0x1(%rbp)
  2590b1:	jge    2590f3 <<glass::engine::Engine>::apply+0xdb3>
  2590b3:	cmp    $0x1,%r8
  2590b7:	je     2593bc <<glass::engine::Engine>::apply+0x107c>
  2590bd:	cmpb   $0xbf,-0x2(%rbp)
  2590c1:	jg     25920d <<glass::engine::Engine>::apply+0xecd>
  2590c7:	cmp    $0x2,%r8
  2590cb:	je     2593bc <<glass::engine::Engine>::apply+0x107c>
  2590d1:	cmpb   $0xbf,-0x3(%rbp)
  2590d5:	jg     2598d7 <<glass::engine::Engine>::apply+0x1597>
  2590db:	cmp    $0x3,%r8
  2590df:	je     2593bc <<glass::engine::Engine>::apply+0x107c>
  2590e5:	cmpb   $0xc0,-0x4(%rbp)
  2590e9:	setl   %al
  2590ec:	mov    $0x3,%edx
  2590f1:	jmp    2590f7 <<glass::engine::Engine>::apply+0xdb7>
  2590f3:	xor    %edx,%edx
  2590f5:	xor    %eax,%eax
  2590f7:	test   %al,%al
  2590f9:	jne    259166 <<glass::engine::Engine>::apply+0xe26>
  2590fb:	mov    %rdx,%rsi
  2590fe:	not    %rsi
  259101:	add    0x10(%rsp),%rsi
  259106:	jae    25a7d8 <<glass::engine::Engine>::apply+0x2498>
  25910c:	movzbl (%r9,%rsi,1),%eax
  259111:	mov    $0x1,%ecx
  259116:	test   %al,%al
  259118:	jns    259144 <<glass::engine::Engine>::apply+0xe04>
  25911a:	lea    0x3e(%rax),%edi
  25911d:	mov    $0x2,%ecx
  259122:	cmp    $0x1e,%dil
  259126:	jb     259144 <<glass::engine::Engine>::apply+0xe04>
  259128:	mov    %eax,%edi
  25912a:	and    $0xf0,%dil
  25912e:	mov    $0x3,%ecx
  259133:	cmp    $0xe0,%dil
  259137:	je     259144 <<glass::engine::Engine>::apply+0xe04>
  259139:	add    $0x10,%al
  25913b:	mov    $0x4,%ecx
  259140:	cmp    $0x4,%al
  259142:	ja     259166 <<glass::engine::Engine>::apply+0xe26>
  259144:	inc    %rdx
  259147:	cmp    %ecx,%edx
  259149:	jne    259166 <<glass::engine::Engine>::apply+0xe26>
  25914b:	add    %r9,%rsi
  25914e:	lea    0xb0(%rsp),%rdi
  259156:	call   *0x398734(%rip)        # 5f1890 <_DYNAMIC+0x2f0>
  25915c:	cmpb   $0x0,0xb0(%rsp)
  259164:	je     259170 <<glass::engine::Engine>::apply+0xe30>
  259166:	mov    0x10(%rsp),%r8
  25916b:	jmp    2593bc <<glass::engine::Engine>::apply+0x107c>
  259170:	mov    0x10(%rsp),%r8
  259175:	mov    %r8,%rbp
  259178:	sub    0x8(%rsp),%rbp
  25917d:	jbe    2593b1 <<glass::engine::Engine>::apply+0x1071>
  259183:	mov    0x39b5f7(%rip),%eax        # 5f4780 <glass::engine::run_whole::ON>
  259189:	test   %eax,%eax
  25918b:	jne    2598e1 <<glass::engine::Engine>::apply+0x15a1>
  259191:	mov    0xd0(%rsp),%ecx
  259198:	and    0x30(%rsp),%cl
  25919c:	movzbl 0x39b5e1(%rip),%eax        # 5f4784 <glass::engine::run_whole::ON+0x4>
  2591a3:	xor    $0x1,%rax
  2591a7:	cmp    %rax,%rbp
  2591aa:	seta   %al
  2591ad:	and    %cl,%al
  2591af:	cmp    $0x1,%al
  2591b1:	jne    259203 <<glass::engine::Engine>::apply+0xec3>
  2591b3:	mov    0x8(%rsp),%rcx
  2591b8:	mov    %rcx,%rax
  2591bb:	cmp    %rcx,0x10(%rsp)
  2591c0:	mov    0x28(%rsp),%rdx
  2591c5:	je     2591e6 <<glass::engine::Engine>::apply+0xea6>
  2591c7:	nopw   0x0(%rax,%rax,1)
  2591d0:	movzbl (%rdx,%rax,1),%ecx
  2591d4:	add    $0xe0,%cl
  2591d7:	cmp    $0x5f,%cl
  2591da:	jae    2591f1 <<glass::engine::Engine>::apply+0xeb1>
  2591dc:	inc    %rax
  2591df:	cmp    %rax,0x10(%rsp)
  2591e4:	jne    2591d0 <<glass::engine::Engine>::apply+0xe90>
  2591e6:	cmpl   $0xffffffff,0x710(%r12)
  2591ef:	je     259217 <<glass::engine::Engine>::apply+0xed7>
  2591f1:	mov    0x10(%rsp),%r8
  2591f6:	mov    0xe8(%rsp),%r13
  2591fe:	jmp    2592f5 <<glass::engine::Engine>::apply+0xfb5>
  259203:	mov    0x8(%rsp),%r13
  259208:	jmp    2592eb <<glass::engine::Engine>::apply+0xfab>
  25920d:	mov    $0x1,%edx
  259212:	jmp    2590f5 <<glass::engine::Engine>::apply+0xdb5>
  259217:	mov    0x39b563(%rip),%eax        # 5f4780 <glass::engine::run_whole::ON>
  25921d:	test   %eax,%eax
  25921f:	jne    2598eb <<glass::engine::Engine>::apply+0x15ab>
  259225:	mov    0x8(%rsp),%rax
  25922a:	add    0x28(%rsp),%rax
  25922f:	mov    %rax,0x8(%rsp)
  259234:	movzbl 0x39b549(%rip),%eax        # 5f4784 <glass::engine::run_whole::ON+0x4>
  25923b:	xor    $0x1,%rax
  25923f:	sub    %rax,%rbp
  259242:	cmp    $0x1,%rbp
  259246:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259248:	cmpb   $0x1,0x1ee(%rsp)
  259250:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259252:	cmpq   $0x0,0x168(%rsp)
  25925b:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  25925d:	mov    0x1a8(%rsp),%r13
  259265:	testb  $0x4,0x6c5(%r13)
  25926d:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  25926f:	cmpq   $0x0,0x50(%r13)
  259274:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259276:	movzwl 0x64(%r13),%eax
  25927b:	test   $0x460,%eax
  259280:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259282:	cmpb   $0x0,0x68(%r13)
  259287:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259289:	cmpb   $0x0,0x69(%r13)
  25928e:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259290:	cmpb   $0x0,0x6a(%r13)
  259295:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259297:	cmpb   $0x0,0x6b(%r13)
  25929c:	je     2598f5 <<glass::engine::Engine>::apply+0x15b5>
  2592a2:	lea    0x130(%rsp),%rdi
  2592aa:	mov    0x8(%rsp),%rsi
  2592af:	mov    %rbp,%rdx
  2592b2:	call   264d40 <<glass::engine::Watch>::print_run>
  2592b7:	mov    %rax,%r15
  2592ba:	mov    0x39b4c0(%rip),%eax        # 5f4780 <glass::engine::run_whole::ON>
  2592c0:	test   %eax,%eax
  2592c2:	jne    25a0fd <<glass::engine::Engine>::apply+0x1dbd>
  2592c8:	cmpb   $0x0,0x39b4b5(%rip)        # 5f4784 <glass::engine::run_whole::ON+0x4>
  2592cf:	je     2592e0 <<glass::engine::Engine>::apply+0xfa0>
  2592d1:	mov    0x1e0(%rsp),%eax
  2592d8:	mov    %eax,0x718(%r12)
  2592e0:	mov    0xe8(%rsp),%r13
  2592e8:	add    %r15,%r13
  2592eb:	mov    0x28(%rsp),%rdx
  2592f0:	mov    0x10(%rsp),%r8
  2592f5:	cmp    %r13,%r8
  2592f8:	jb     25a74d <<glass::engine::Engine>::apply+0x240d>
  2592fe:	mov    %r8,%r15
  259301:	mov    %r8,0x8(%rsp)
  259306:	sub    %r13,%r15
  259309:	je     2593b1 <<glass::engine::Engine>::apply+0x1071>
  25930f:	add    %rdx,%r13
  259312:	xor    %ebp,%ebp
  259314:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  259320:	cmpl   $0xffffffff,0x710(%r12)
  259329:	jne    259386 <<glass::engine::Engine>::apply+0x1046>
  25932b:	mov    0x78(%rsp),%rax
  259330:	mov    %rax,0xb0(%rsp)
  259338:	lea    0x130(%rsp),%rax
  259340:	mov    %rax,0xb8(%rsp)
  259348:	movb   $0x0,0xc0(%rsp)
  259350:	mov    %r15,%rcx
  259353:	sub    %rbp,%rcx
  259356:	jb     25a6aa <<glass::engine::Engine>::apply+0x236a>
  25935c:	mov    %r13,%rdx
  25935f:	add    %rbp,%rdx
  259362:	mov    0xf0(%rsp),%rdi
  25936a:	lea    0xb0(%rsp),%rsi
  259372:	call   1a0670 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  259377:	add    %rax,%rbp
  25937a:	cmp    %r15,%rbp
  25937d:	mov    0x10(%rsp),%r8
  259382:	jne    259320 <<glass::engine::Engine>::apply+0xfe0>
  259384:	jmp    2593ac <<glass::engine::Engine>::apply+0x106c>
  259386:	mov    %r15,%rcx
  259389:	sub    %rbp,%rcx
  25938c:	jb     25a7b6 <<glass::engine::Engine>::apply+0x2476>
  259392:	mov    %r13,%rdx
  259395:	add    %rbp,%rdx
  259398:	mov    0x78(%rsp),%rdi
  25939d:	lea    0x130(%rsp),%rsi
  2593a5:	call   1943d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  2593aa:	jmp    259377 <<glass::engine::Engine>::apply+0x1037>
  2593ac:	mov    %r8,0x8(%rsp)
  2593b1:	cmpl   $0xffffffff,0x710(%r12)
  2593ba:	je     2593cf <<glass::engine::Engine>::apply+0x108f>
  2593bc:	movl   $0x0,0xd0(%rsp)
  2593c7:	mov    %r8,%r13
  2593ca:	jmp    258de5 <<glass::engine::Engine>::apply+0xaa5>
  2593cf:	cmpb   $0x0,0x12c(%rsp)
  2593d7:	je     259419 <<glass::engine::Engine>::apply+0x10d9>
  2593d9:	mov    0x1e0(%rsp),%ebx
  2593e0:	cmp    $0xffffffff,%ebx
  2593e3:	je     259845 <<glass::engine::Engine>::apply+0x1505>
  2593e9:	mov    0x80(%rsp),%ebp
  2593f0:	cmp    $0x1,%bp
  2593f4:	adc    $0x0,%ebp
  2593f7:	nopw   0x0(%rax,%rax,1)
  259400:	lea    0x130(%rsp),%rdi
  259408:	mov    %ebx,%esi
  25940a:	call   33d1b0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  25940f:	dec    %bp
  259412:	jne    259400 <<glass::engine::Engine>::apply+0x10c0>
  259414:	jmp    259892 <<glass::engine::Engine>::apply+0x1552>
  259419:	cmpb   $0x0,0x128(%rsp)
  259421:	je     259451 <<glass::engine::Engine>::apply+0x1111>
  259423:	movzwl 0x80(%rsp),%eax
  25942b:	lea    -0x1(%rax),%esi
  25942e:	test   %eax,%eax
  259430:	cmove  %eax,%esi
  259433:	test   %r14,%r14
  259436:	je     259872 <<glass::engine::Engine>::apply+0x1532>
  25943c:	movzwl 0x82(%rsp),%ecx
  259444:	xor    %eax,%eax
  259446:	test   %cx,%cx
  259449:	setne  %al
  25944c:	jmp    259874 <<glass::engine::Engine>::apply+0x1534>
  259451:	mov    0x1a8(%rsp),%r13
  259459:	xor    %eax,%eax
  25945b:	jmp    25948e <<glass::engine::Engine>::apply+0x114e>
  25945d:	mov    $0x17,%cx
  259461:	mov    $0x1010000,%esi
  259466:	cs nopw 0x0(%rax,%rax,1)
  259470:	movzwl %cx,%eax
  259473:	shl    $0x10,%rsi
  259477:	or     %rax,%rsi
  25947a:	mov    %r13,%rdi
  25947d:	call   34ac70 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  259482:	mov    %rbx,%rax
  259485:	cmp    %r14,%rbx
  259488:	ja     259892 <<glass::engine::Engine>::apply+0x1552>
  25948e:	movzwl 0x80(%rsp,%rax,2),%ecx
  259496:	lea    0x1(%rax),%rbx
  25949a:	cmp    $0x3b,%rcx
  25949e:	ja     25971f <<glass::engine::Engine>::apply+0x13df>
  2594a4:	lea    -0x1eabf3(%rip),%rsi        # 6e8b8 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2e07>
  2594ab:	movslq (%rsi,%rcx,4),%rdx
  2594af:	add    %rsi,%rdx
  2594b2:	jmp    *%rdx
  2594b4:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  2594b6:	cmp    %r14,%rax
  2594b9:	jae    259482 <<glass::engine::Engine>::apply+0x1142>
  2594bb:	movzwl 0x82(%rsp,%rax,2),%ecx
  2594c3:	lea    0x2(%rax),%rbx
  2594c7:	cmp    $0x5,%ecx
  2594ca:	je     259783 <<glass::engine::Engine>::apply+0x1443>
  2594d0:	cmp    $0x2,%ecx
  2594d3:	jne    259482 <<glass::engine::Engine>::apply+0x1142>
  2594d5:	cmp    %r14,%rbx
  2594d8:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2594da:	movzwl 0x84(%rsp,%rax,2),%ecx
  2594e2:	lea    0x3(%rax),%rbx
  2594e6:	cmp    $0xff,%ecx
  2594ec:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2594ee:	cmp    %r14,%rbx
  2594f1:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2594f3:	movzwl 0x86(%rsp,%rax,2),%edx
  2594fb:	lea    0x4(%rax),%rbx
  2594ff:	cmp    $0xff,%edx
  259505:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  25950b:	cmp    %r14,%rbx
  25950e:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  259514:	movzwl 0x88(%rsp,%rax,2),%edi
  25951c:	add    $0x5,%rax
  259520:	cmp    $0xff,%edi
  259526:	ja     259806 <<glass::engine::Engine>::apply+0x14c6>
  25952c:	shl    $0x10,%edi
  25952f:	movzwl %dx,%edx
  259532:	shl    $0x8,%edx
  259535:	or     %edx,%ecx
  259537:	movzwl %cx,%esi
  25953a:	or     %edi,%esi
  25953c:	mov    $0x1,%ecx
  259541:	jmp    2597a5 <<glass::engine::Engine>::apply+0x1465>
  259546:	mov    $0x11,%cx
  25954a:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  25954f:	mov    $0xc,%cx
  259553:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259558:	mov    $0xa,%cx
  25955c:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259561:	mov    $0x18,%cx
  259565:	mov    $0xff,%esi
  25956a:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  25956f:	mov    $0xe,%cx
  259573:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259578:	cmp    %r14,%rax
  25957b:	jae    259482 <<glass::engine::Engine>::apply+0x1142>
  259581:	movzwl 0x82(%rsp,%rax,2),%ecx
  259589:	lea    0x2(%rax),%rbx
  25958d:	cmp    $0x5,%ecx
  259590:	je     2597b6 <<glass::engine::Engine>::apply+0x1476>
  259596:	cmp    $0x2,%ecx
  259599:	jne    259482 <<glass::engine::Engine>::apply+0x1142>
  25959f:	cmp    %r14,%rbx
  2595a2:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2595a8:	movzwl 0x84(%rsp,%rax,2),%ecx
  2595b0:	lea    0x3(%rax),%rbx
  2595b4:	cmp    $0xff,%ecx
  2595ba:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2595c0:	cmp    %r14,%rbx
  2595c3:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2595c9:	movzwl 0x86(%rsp,%rax,2),%edx
  2595d1:	lea    0x4(%rax),%rbx
  2595d5:	cmp    $0xff,%edx
  2595db:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2595e1:	cmp    %r14,%rbx
  2595e4:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2595ea:	movzwl 0x88(%rsp,%rax,2),%edi
  2595f2:	add    $0x5,%rax
  2595f6:	cmp    $0xff,%edi
  2595fc:	ja     259806 <<glass::engine::Engine>::apply+0x14c6>
  259602:	shl    $0x10,%edi
  259605:	movzwl %dx,%edx
  259608:	shl    $0x8,%edx
  25960b:	or     %edx,%ecx
  25960d:	movzwl %cx,%esi
  259610:	or     %edi,%esi
  259612:	mov    $0x1,%ecx
  259617:	jmp    2597d8 <<glass::engine::Engine>::apply+0x1498>
  25961c:	mov    $0x10,%cx
  259620:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259625:	mov    $0x16,%cx
  259629:	mov    $0x1000000,%esi
  25962e:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259633:	mov    $0xf,%cx
  259637:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  25963c:	mov    $0x9,%cx
  259640:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259645:	mov    $0x12,%cx
  259649:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  25964e:	mov    $0x13,%cx
  259652:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259657:	mov    $0xb,%cx
  25965b:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259660:	mov    $0xd,%cx
  259664:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259669:	mov    $0x15,%cx
  25966d:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259672:	mov    $0x14,%cx
  259676:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  25967b:	cmp    %r14,%rax
  25967e:	jae    259482 <<glass::engine::Engine>::apply+0x1142>
  259684:	movzwl 0x82(%rsp,%rax,2),%ecx
  25968c:	lea    0x2(%rax),%rbx
  259690:	cmp    $0x5,%ecx
  259693:	je     2597e9 <<glass::engine::Engine>::apply+0x14a9>
  259699:	cmp    $0x2,%ecx
  25969c:	jne    259482 <<glass::engine::Engine>::apply+0x1142>
  2596a2:	cmp    %r14,%rbx
  2596a5:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2596ab:	movzwl 0x84(%rsp,%rax,2),%ecx
  2596b3:	lea    0x3(%rax),%rbx
  2596b7:	cmp    $0xff,%ecx
  2596bd:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2596c3:	cmp    %r14,%rbx
  2596c6:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2596cc:	movzwl 0x86(%rsp,%rax,2),%edx
  2596d4:	lea    0x4(%rax),%rbx
  2596d8:	cmp    $0xff,%edx
  2596de:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2596e4:	cmp    %r14,%rbx
  2596e7:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2596ed:	movzwl 0x88(%rsp,%rax,2),%edi
  2596f5:	add    $0x5,%rax
  2596f9:	cmp    $0xff,%edi
  2596ff:	ja     259806 <<glass::engine::Engine>::apply+0x14c6>
  259705:	shl    $0x10,%edi
  259708:	movzwl %dx,%edx
  25970b:	shl    $0x8,%edx
  25970e:	or     %edx,%ecx
  259710:	movzwl %cx,%esi
  259713:	or     %edi,%esi
  259715:	mov    $0x1,%ecx
  25971a:	jmp    259834 <<glass::engine::Engine>::apply+0x14f4>
  25971f:	lea    -0x1e(%rcx),%eax
  259722:	cmp    $0x8,%ax
  259726:	jae    259740 <<glass::engine::Engine>::apply+0x1400>
  259728:	lea    -0x1fe3bf(%rip),%rax        # 5b370 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0x960>
  25972f:	movzwl -0x3c(%rax,%rcx,2),%esi
  259734:	shl    $0x10,%esi
  259737:	mov    $0x16,%cx
  25973b:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259740:	mov    %ecx,%eax
  259742:	and    $0xfff8,%eax
  259747:	cmp    $0x28,%ax
  25974b:	jne    259765 <<glass::engine::Engine>::apply+0x1425>
  25974d:	lea    -0x1fe3e4(%rip),%rax        # 5b370 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0x960>
  259754:	movzwl -0x50(%rax,%rcx,2),%esi
  259759:	shl    $0x10,%esi
  25975c:	mov    $0x17,%cx
  259760:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259765:	lea    -0x5a(%rcx),%eax
  259768:	cmp    $0x8,%ax
  25976c:	jae    25980e <<glass::engine::Engine>::apply+0x14ce>
  259772:	lea    -0x1fc7f9(%rip),%rax        # 5cf80 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0xd0>
  259779:	movzwl -0xb4(%rax,%rcx,2),%esi
  259781:	jmp    259734 <<glass::engine::Engine>::apply+0x13f4>
  259783:	cmp    %r14,%rbx
  259786:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  25978c:	movzwl 0x84(%rsp,%rax,2),%esi
  259794:	add    $0x3,%rax
  259798:	cmp    $0xff,%esi
  25979e:	ja     259806 <<glass::engine::Engine>::apply+0x14c6>
  2597a0:	mov    $0x2,%ecx
  2597a5:	shl    $0x8,%esi
  2597a8:	or     %ecx,%esi
  2597aa:	mov    $0x16,%cx
  2597ae:	mov    %rax,%rbx
  2597b1:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  2597b6:	cmp    %r14,%rbx
  2597b9:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2597bf:	movzwl 0x84(%rsp,%rax,2),%esi
  2597c7:	add    $0x3,%rax
  2597cb:	cmp    $0xff,%esi
  2597d1:	ja     259806 <<glass::engine::Engine>::apply+0x14c6>
  2597d3:	mov    $0x2,%ecx
  2597d8:	shl    $0x8,%esi
  2597db:	or     %ecx,%esi
  2597dd:	mov    $0x18,%cx
  2597e1:	mov    %rax,%rbx
  2597e4:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  2597e9:	cmp    %r14,%rbx
  2597ec:	ja     259482 <<glass::engine::Engine>::apply+0x1142>
  2597f2:	movzwl 0x84(%rsp,%rax,2),%esi
  2597fa:	add    $0x3,%rax
  2597fe:	cmp    $0xff,%esi
  259804:	jbe    25982f <<glass::engine::Engine>::apply+0x14ef>
  259806:	mov    %rax,%rbx
  259809:	jmp    259482 <<glass::engine::Engine>::apply+0x1142>
  25980e:	lea    -0x64(%rcx),%eax
  259811:	cmp    $0x8,%ax
  259815:	jae    259482 <<glass::engine::Engine>::apply+0x1142>
  25981b:	lea    -0x1fc8a2(%rip),%rax        # 5cf80 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0xd0>
  259822:	movzwl -0xc8(%rax,%rcx,2),%esi
  25982a:	jmp    259759 <<glass::engine::Engine>::apply+0x1419>
  25982f:	mov    $0x2,%ecx
  259834:	shl    $0x8,%esi
  259837:	or     %ecx,%esi
  259839:	mov    $0x17,%cx
  25983d:	mov    %rax,%rbx
  259840:	jmp    259470 <<glass::engine::Engine>::apply+0x1130>
  259845:	mov    $0x1,%al
  259847:	mov    %eax,0xd0(%rsp)
  25984e:	mov    %r8,%r13
  259851:	mov    0x8(%rsp),%rax
  259856:	mov    %rax,0xe8(%rsp)
  25985e:	mov    $0x1,%al
  259860:	mov    %rax,0x58(%rsp)
  259865:	mov    0x120(%rsp),%rbx
  25986d:	jmp    258de5 <<glass::engine::Engine>::apply+0xaa5>
  259872:	xor    %eax,%eax
  259874:	movzwl %cx,%edx
  259877:	dec    %rdx
  25987a:	test   $0x1,%al
  25987c:	mov    $0x0,%eax
  259881:	cmove  %rax,%rdx
  259885:	mov    0x1a8(%rsp),%rdi
  25988d:	call   34c0b0 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  259892:	mov    0x10(%rsp),%r8
  259897:	mov    0x120(%rsp),%rbx
  25989f:	lea    (%rbx,%r8,1),%r13
  2598a3:	movb   $0x0,0xa80(%r12)
  2598ac:	movb   $0x0,0xa7e(%r12)
  2598b5:	mov    $0x1,%al
  2598b7:	mov    %eax,0xd0(%rsp)
  2598be:	mov    %r13,0x8(%rsp)
  2598c3:	mov    %r13,0xe8(%rsp)
  2598cb:	mov    $0x1,%al
  2598cd:	mov    %rax,0x58(%rsp)
  2598d2:	jmp    258de5 <<glass::engine::Engine>::apply+0xaa5>
  2598d7:	mov    $0x2,%edx
  2598dc:	jmp    2590f5 <<glass::engine::Engine>::apply+0xdb5>
  2598e1:	call   18ba06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2598e6:	jmp    259191 <<glass::engine::Engine>::apply+0xe51>
  2598eb:	call   18ba06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2598f0:	jmp    259225 <<glass::engine::Engine>::apply+0xee5>
  2598f5:	mov    0x8(%rsp),%rax
  2598fa:	movzbl (%rax),%eax
  2598fd:	mov    %rax,0xd0(%rsp)
  259905:	add    $0xffffffe0,%eax
  259908:	mov    $0x1,%r15d
  25990e:	cmp    $0x5f,%al
  259910:	jb     25993d <<glass::engine::Engine>::apply+0x15fd>
  259912:	mov    0xd0(%rsp),%rdi
  25991a:	call   2a1de0 <glass::engine::width_of>
  25991f:	mov    0x38(%rsp),%r12
  259924:	mov    %rdx,%r15
  259927:	lea    -0x1(%rdx),%rcx
  25992b:	cmp    $0x2,%rcx
  25992f:	setb   %cl
  259932:	and    %al,%cl
  259934:	cmp    $0x1,%cl
  259937:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  25993d:	cmpb   $0x0,0x6c(%r13)
  259942:	mov    0x38(%rsp),%r12
  259947:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  25994d:	mov    0x40(%r13),%rdx
  259951:	mov    0xa0(%r13),%rcx
  259958:	mov    %rdx,0x30(%rsp)
  25995d:	lea    (%rdx,%r15,1),%rax
  259961:	mov    %rax,0x118(%rsp)
  259969:	mov    %rcx,0x220(%rsp)
  259971:	cmp    %rcx,%rax
  259974:	ja     2592a2 <<glass::engine::Engine>::apply+0xf62>
  25997a:	lea    0x10(%r13),%rdi
  25997e:	mov    0x48(%r13),%esi
  259982:	mov    0x58(%r13),%eax
  259986:	mov    %eax,0xfc(%rsp)
  25998d:	mov    0x5c(%r13),%eax
  259991:	mov    %eax,0xf8(%rsp)
  259998:	movzwl 0x64(%r13),%eax
  25999d:	mov    %eax,0x100(%rsp)
  2599a4:	lea    0x36f1f5(%rip),%rdx        # 5c8ba0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a0>
  2599ab:	call   30b7c0 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  2599b0:	mov    %rax,%rcx
  2599b3:	add    $0x18,%rcx
  2599b7:	mov    %rcx,0x108(%rsp)
  2599bf:	mov    %rax,0x20(%rsp)
  2599c4:	mov    0x28(%rax),%eax
  2599c7:	cmp    $0xffffffff,%eax
  2599ca:	je     2599e4 <<glass::engine::Engine>::apply+0x16a4>
  2599cc:	mov    0x108(%rsp),%rcx
  2599d4:	mov    0x30(%rsp),%rdx
  2599d9:	mov    0x20(%rsp),%rsi
  2599de:	cmp    0x30(%rsi),%rdx
  2599e2:	jae    259a0e <<glass::engine::Engine>::apply+0x16ce>
  2599e4:	mov    0x20(%rsp),%rcx
  2599e9:	mov    0x10(%rcx),%rcx
  2599ed:	cmp    %rcx,0x30(%rsp)
  2599f2:	jae    25a7f1 <<glass::engine::Engine>::apply+0x24b1>
  2599f8:	mov    0x30(%rsp),%rcx
  2599fd:	lea    (%rcx,%rcx,2),%rcx
  259a01:	shl    $0x3,%rcx
  259a05:	mov    0x20(%rsp),%rdx
  259a0a:	add    0x8(%rdx),%rcx
  259a0e:	testb  $0x60,0x14(%rcx)
  259a12:	mov    0x38(%rsp),%r12
  259a17:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259a1d:	cmp    $0x2,%r15
  259a21:	jne    259a75 <<glass::engine::Engine>::apply+0x1735>
  259a23:	mov    0x30(%rsp),%rcx
  259a28:	inc    %rcx
  259a2b:	cmp    $0xffffffff,%eax
  259a2e:	je     259a43 <<glass::engine::Engine>::apply+0x1703>
  259a30:	mov    0x108(%rsp),%rdx
  259a38:	mov    0x20(%rsp),%rsi
  259a3d:	cmp    0x30(%rsi),%rcx
  259a41:	jae    259a66 <<glass::engine::Engine>::apply+0x1726>
  259a43:	mov    0x20(%rsp),%rdx
  259a48:	mov    0x10(%rdx),%rdx
  259a4c:	cmp    %rdx,%rcx
  259a4f:	jae    25a807 <<glass::engine::Engine>::apply+0x24c7>
  259a55:	lea    (%rcx,%rcx,2),%rdx
  259a59:	shl    $0x3,%rdx
  259a5d:	mov    0x20(%rsp),%rcx
  259a62:	add    0x8(%rcx),%rdx
  259a66:	testb  $0x60,0x14(%rdx)
  259a6a:	mov    0x38(%rsp),%r12
  259a6f:	jne    2592a2 <<glass::engine::Engine>::apply+0xf62>
  259a75:	mov    0x30(%rsp),%rcx
  259a7a:	mov    0x20(%rsp),%rdx
  259a7f:	cmp    %ecx,0x38(%rdx)
  259a82:	jbe    259a91 <<glass::engine::Engine>::apply+0x1751>
  259a84:	mov    0x30(%rsp),%rcx
  259a89:	mov    0x20(%rsp),%rdx
  259a8e:	mov    %ecx,0x38(%rdx)
  259a91:	cmp    $0xffffffff,%eax
  259a94:	setne  %cl
  259a97:	mov    0x20(%rsp),%rdx
  259a9c:	mov    0x30(%rdx),%r12
  259aa0:	cmp    %r12,0x30(%rsp)
  259aa5:	sete   %dl
  259aa8:	test   %dl,%cl
  259aaa:	jne    259bb8 <<glass::engine::Engine>::apply+0x1878>
  259ab0:	cmp    $0xffffffff,%eax
  259ab3:	je     259d12 <<glass::engine::Engine>::apply+0x19d2>
  259ab9:	mov    0x20(%rsp),%rax
  259abe:	mov    0x10(%rax),%rbp
  259ac2:	cmp    %r12,%rbp
  259ac5:	mov    %r12,%rax
  259ac8:	cmovb  %rbp,%rax
  259acc:	mov    %rax,0x68(%rsp)
  259ad1:	mov    0x30(%rsp),%rax
  259ad6:	cmp    %rax,%rbp
  259ad9:	cmovb  %rbp,%rax
  259add:	mov    %rax,0x40(%rsp)
  259ae2:	mov    0x397dd7(%rip),%rax        # 5f18c0 <_DYNAMIC+0x320>
  259ae9:	movzbl (%rax),%eax
  259aec:	test   %al,%al
  259aee:	je     259b19 <<glass::engine::Engine>::apply+0x17d9>
  259af0:	mov    0x397e01(%rip),%rax        # 5f18f8 <_DYNAMIC+0x358>
  259af7:	cmp    0x40(%rsp),%r12
  259afc:	jae    259b05 <<glass::engine::Engine>::apply+0x17c5>
  259afe:	mov    0x397dfb(%rip),%rax        # 5f1900 <_DYNAMIC+0x360>
  259b05:	lock incq 0x28(%rax)
  259b0a:	mov    0x40(%rsp),%rdi
  259b0f:	sub    0x68(%rsp),%rdi
  259b14:	call   2f6d60 <alacritty_terminal::grid::row::fill_census::note>
  259b19:	cmp    0x40(%rsp),%r12
  259b1e:	jae    259cf2 <<glass::engine::Engine>::apply+0x19b2>
  259b24:	mov    0x20(%rsp),%rax
  259b29:	mov    0x28(%rax),%ecx
  259b2c:	mov    %ecx,0x54(%rsp)
  259b30:	mov    0x20(%rax),%ecx
  259b33:	mov    %ecx,0x50(%rsp)
  259b37:	mov    0x24(%rax),%ecx
  259b3a:	mov    %ecx,0x4c(%rsp)
  259b3e:	movzwl 0x2c(%rax),%ecx
  259b42:	mov    %cx,0x70(%rsp)
  259b47:	mov    0x18(%rax),%rax
  259b4b:	mov    %rax,0x8(%rsp)
  259b50:	test   %rax,%rax
  259b53:	je     259bdc <<glass::engine::Engine>::apply+0x189c>
  259b59:	mov    0x8(%rsp),%rax
  259b5e:	lock incq (%rax)
  259b62:	jle    25a86f <<glass::engine::Engine>::apply+0x252f>
  259b68:	mov    0x20(%rsp),%rax
  259b6d:	mov    0x10(%rax),%rdx
  259b71:	mov    0x54(%rsp),%eax
  259b75:	mov    %eax,0xc0(%rsp)
  259b7c:	mov    0x50(%rsp),%eax
  259b80:	mov    %eax,0xb8(%rsp)
  259b87:	mov    0x4c(%rsp),%eax
  259b8b:	mov    %eax,0xbc(%rsp)
  259b92:	movzwl 0x70(%rsp),%eax
  259b97:	mov    %ax,0xc4(%rsp)
  259b9f:	mov    0x8(%rsp),%rax
  259ba4:	mov    %rax,0xb0(%rsp)
  259bac:	cmp    %rdx,0x40(%rsp)
  259bb1:	jbe    259c17 <<glass::engine::Engine>::apply+0x18d7>
  259bb3:	jmp    25a81b <<glass::engine::Engine>::apply+0x24db>
  259bb8:	mov    0x30(%rsp),%rcx
  259bbd:	lea    0x1(%rcx),%rax
  259bc1:	mov    0x20(%rsp),%rdx
  259bc6:	mov    %rax,0x30(%rdx)
  259bca:	mov    0x10(%rdx),%rax
  259bce:	cmp    %rax,%rcx
  259bd1:	jb     259d3c <<glass::engine::Engine>::apply+0x19fc>
  259bd7:	jmp    25a834 <<glass::engine::Engine>::apply+0x24f4>
  259bdc:	mov    0x54(%rsp),%eax
  259be0:	mov    %eax,0xc0(%rsp)
  259be7:	mov    0x50(%rsp),%eax
  259beb:	mov    %eax,0xb8(%rsp)
  259bf2:	mov    0x4c(%rsp),%eax
  259bf6:	mov    %eax,0xbc(%rsp)
  259bfd:	movzwl 0x70(%rsp),%eax
  259c02:	mov    %ax,0xc4(%rsp)
  259c0a:	mov    0x8(%rsp),%rax
  259c0f:	mov    %rax,0xb0(%rsp)
  259c17:	mov    0x68(%rsp),%rax
  259c1c:	lea    0x0(,%rax,8),%rax
  259c24:	lea    (%rax,%rax,2),%rax
  259c28:	mov    0x20(%rsp),%rcx
  259c2d:	mov    0x8(%rcx),%rbp
  259c31:	add    %rax,%rbp
  259c34:	mov    0x40(%rsp),%rcx
  259c39:	lea    0x0(,%rcx,8),%rcx
  259c41:	lea    (%rcx,%rcx,2),%r12
  259c45:	sub    %rax,%r12
  259c48:	jmp    259c7b <<glass::engine::Engine>::apply+0x193b>
  259c4a:	mov    0x8(%rsp),%rax
  259c4f:	mov    %rax,0x0(%rbp)
  259c53:	mov    0x50(%rsp),%eax
  259c57:	mov    %eax,0x8(%rbp)
  259c5a:	mov    0x4c(%rsp),%eax
  259c5e:	mov    %eax,0xc(%rbp)
  259c61:	mov    0x54(%rsp),%eax
  259c65:	mov    %eax,0x10(%rbp)
  259c68:	movzwl 0x70(%rsp),%eax
  259c6d:	mov    %ax,0x14(%rbp)
  259c71:	add    $0x18,%rbp
  259c75:	add    $0xffffffffffffffe8,%r12
  259c79:	je     259cac <<glass::engine::Engine>::apply+0x196c>
  259c7b:	cmpq   $0x0,0x8(%rsp)
  259c81:	je     259c92 <<glass::engine::Engine>::apply+0x1952>
  259c83:	mov    0x8(%rsp),%rax
  259c88:	lock incq (%rax)
  259c8c:	jle    25a86f <<glass::engine::Engine>::apply+0x252f>
  259c92:	mov    0x0(%rbp),%rax
  259c96:	test   %rax,%rax
  259c99:	je     259c4a <<glass::engine::Engine>::apply+0x190a>
  259c9b:	lock decq (%rax)
  259c9f:	jne    259c4a <<glass::engine::Engine>::apply+0x190a>
  259ca1:	mov    %rbp,%rdi
  259ca4:	call   *0x397b5e(%rip)        # 5f1808 <_DYNAMIC+0x268>
  259caa:	jmp    259c4a <<glass::engine::Engine>::apply+0x190a>
  259cac:	mov    0x20(%rsp),%rax
  259cb1:	mov    0x68(%rsp),%rcx
  259cb6:	cmp    %ecx,0x38(%rax)
  259cb9:	jbe    259cc8 <<glass::engine::Engine>::apply+0x1988>
  259cbb:	mov    0x20(%rsp),%rax
  259cc0:	mov    0x68(%rsp),%rcx
  259cc5:	mov    %ecx,0x38(%rax)
  259cc8:	cmpq   $0x0,0x8(%rsp)
  259cce:	je     259ce9 <<glass::engine::Engine>::apply+0x19a9>
  259cd0:	mov    0x8(%rsp),%rax
  259cd5:	lock decq (%rax)
  259cd9:	jne    259ce9 <<glass::engine::Engine>::apply+0x19a9>
  259cdb:	lea    0xb0(%rsp),%rdi
  259ce3:	call   *0x397b1f(%rip)        # 5f1808 <_DYNAMIC+0x268>
  259ce9:	mov    0x20(%rsp),%rax
  259cee:	mov    0x10(%rax),%rbp
  259cf2:	cmp    %rbp,0x40(%rsp)
  259cf7:	jb     259d12 <<glass::engine::Engine>::apply+0x19d2>
  259cf9:	mov    0x108(%rsp),%rdi
  259d01:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259d06:	mov    0x20(%rsp),%rax
  259d0b:	movl   $0xffffffff,0x28(%rax)
  259d12:	mov    0x20(%rsp),%rsi
  259d17:	mov    0x30(%rsi),%rcx
  259d1b:	mov    0x30(%rsp),%rdx
  259d20:	lea    0x1(%rdx),%rax
  259d24:	cmp    %rcx,%rax
  259d27:	cmova  %rax,%rcx
  259d2b:	mov    0x10(%rsi),%rax
  259d2f:	mov    %rcx,0x30(%rsi)
  259d33:	cmp    %rax,%rdx
  259d36:	jae    25a83b <<glass::engine::Engine>::apply+0x24fb>
  259d3c:	mov    0x100(%rsp),%edi
  259d43:	mov    %edi,%eax
  259d45:	or     $0x20,%eax
  259d48:	cmp    $0x2,%r15
  259d4c:	mov    0x20(%rsp),%rcx
  259d51:	mov    0x8(%rcx),%rcx
  259d55:	mov    0x30(%rsp),%rdx
  259d5a:	lea    (%rdx,%rdx,2),%rdx
  259d5e:	lea    (%rcx,%rdx,8),%rbp
  259d62:	mov    0xd0(%rsp),%rsi
  259d6a:	mov    %esi,0x10(%rcx,%rdx,8)
  259d6e:	mov    0xfc(%rsp),%esi
  259d75:	mov    %esi,0x8(%rcx,%rdx,8)
  259d79:	cmovne %edi,%eax
  259d7c:	mov    0xf8(%rsp),%esi
  259d83:	mov    %esi,0xc(%rcx,%rdx,8)
  259d87:	mov    %ax,0x14(%rcx,%rdx,8)
  259d8c:	mov    (%rcx,%rdx,8),%rax
  259d90:	test   %rax,%rax
  259d93:	je     259da4 <<glass::engine::Engine>::apply+0x1a64>
  259d95:	lock decq (%rax)
  259d99:	jne    259da4 <<glass::engine::Engine>::apply+0x1a64>
  259d9b:	mov    %rbp,%rdi
  259d9e:	call   *0x397a64(%rip)        # 5f1808 <_DYNAMIC+0x268>
  259da4:	movq   $0x0,0x0(%rbp)
  259dac:	cmp    $0x2,%r15
  259db0:	jne    25a0a2 <<glass::engine::Engine>::apply+0x1d62>
  259db6:	mov    0x30(%rsp),%rax
  259dbb:	lea    0x1(%rax),%rdx
  259dbf:	mov    0x20(%rsp),%rax
  259dc4:	mov    0x30(%rax),%r15
  259dc8:	mov    0x28(%rax),%eax
  259dcb:	mov    %rdx,0x70(%rsp)
  259dd0:	cmp    %r15,%rdx
  259dd3:	jne    259e00 <<glass::engine::Engine>::apply+0x1ac0>
  259dd5:	cmp    $0xffffffff,%eax
  259dd8:	je     259e00 <<glass::engine::Engine>::apply+0x1ac0>
  259dda:	mov    0x30(%rsp),%rax
  259ddf:	add    $0x2,%rax
  259de3:	mov    0x20(%rsp),%rcx
  259de8:	mov    %rax,0x30(%rcx)
  259dec:	mov    0x10(%rcx),%rax
  259df0:	cmp    %rax,0x70(%rsp)
  259df5:	jb     25a040 <<glass::engine::Engine>::apply+0x1d00>
  259dfb:	jmp    25a842 <<glass::engine::Engine>::apply+0x2502>
  259e00:	cmp    $0xffffffff,%eax
  259e03:	je     25a014 <<glass::engine::Engine>::apply+0x1cd4>
  259e09:	mov    0x20(%rsp),%rax
  259e0e:	mov    0x10(%rax),%r12
  259e12:	cmp    %r15,%r12
  259e15:	mov    %r15,%rax
  259e18:	cmovb  %r12,%rax
  259e1c:	mov    %rax,0x68(%rsp)
  259e21:	mov    0x70(%rsp),%rax
  259e26:	cmp    %rax,%r12
  259e29:	cmovb  %r12,%rax
  259e2d:	mov    %rax,0x40(%rsp)
  259e32:	mov    0x397a87(%rip),%rax        # 5f18c0 <_DYNAMIC+0x320>
  259e39:	movzbl (%rax),%eax
  259e3c:	test   %al,%al
  259e3e:	je     259e69 <<glass::engine::Engine>::apply+0x1b29>
  259e40:	mov    0x397ab1(%rip),%rax        # 5f18f8 <_DYNAMIC+0x358>
  259e47:	cmp    0x40(%rsp),%r15
  259e4c:	jae    259e55 <<glass::engine::Engine>::apply+0x1b15>
  259e4e:	mov    0x397aab(%rip),%rax        # 5f1900 <_DYNAMIC+0x360>
  259e55:	lock incq 0x28(%rax)
  259e5a:	mov    0x40(%rsp),%rdi
  259e5f:	sub    0x68(%rsp),%rdi
  259e64:	call   2f6d60 <alacritty_terminal::grid::row::fill_census::note>
  259e69:	cmp    0x40(%rsp),%r15
  259e6e:	jae    259ff4 <<glass::engine::Engine>::apply+0x1cb4>
  259e74:	mov    0x20(%rsp),%rax
  259e79:	mov    0x28(%rax),%ecx
  259e7c:	mov    %ecx,0x8(%rsp)
  259e80:	mov    0x20(%rax),%ecx
  259e83:	mov    %ecx,0x54(%rsp)
  259e87:	mov    0x24(%rax),%ecx
  259e8a:	mov    %ecx,0x50(%rsp)
  259e8e:	movzwl 0x2c(%rax),%ecx
  259e92:	mov    %cx,0x4c(%rsp)
  259e97:	mov    0x18(%rax),%r12
  259e9b:	test   %r12,%r12
  259e9e:	je     259ef6 <<glass::engine::Engine>::apply+0x1bb6>
  259ea0:	lock incq (%r12)
  259ea5:	jle    25a86f <<glass::engine::Engine>::apply+0x252f>
  259eab:	mov    0x20(%rsp),%rax
  259eb0:	mov    0x10(%rax),%rdx
  259eb4:	mov    0x8(%rsp),%eax
  259eb8:	mov    %eax,0xc0(%rsp)
  259ebf:	mov    0x54(%rsp),%eax
  259ec3:	mov    %eax,0xb8(%rsp)
  259eca:	mov    0x50(%rsp),%eax
  259ece:	mov    %eax,0xbc(%rsp)
  259ed5:	movzwl 0x4c(%rsp),%eax
  259eda:	mov    %ax,0xc4(%rsp)
  259ee2:	mov    %r12,0xb0(%rsp)
  259eea:	cmp    %rdx,0x40(%rsp)
  259eef:	jbe    259f2c <<glass::engine::Engine>::apply+0x1bec>
  259ef1:	jmp    25a858 <<glass::engine::Engine>::apply+0x2518>
  259ef6:	mov    0x8(%rsp),%eax
  259efa:	mov    %eax,0xc0(%rsp)
  259f01:	mov    0x54(%rsp),%eax
  259f05:	mov    %eax,0xb8(%rsp)
  259f0c:	mov    0x50(%rsp),%eax
  259f10:	mov    %eax,0xbc(%rsp)
  259f17:	movzwl 0x4c(%rsp),%eax
  259f1c:	mov    %ax,0xc4(%rsp)
  259f24:	mov    %r12,0xb0(%rsp)
  259f2c:	mov    0x68(%rsp),%rax
  259f31:	lea    0x0(,%rax,8),%rax
  259f39:	lea    (%rax,%rax,2),%rax
  259f3d:	mov    0x20(%rsp),%rcx
  259f42:	mov    0x8(%rcx),%rbp
  259f46:	add    %rax,%rbp
  259f49:	mov    0x40(%rsp),%rcx
  259f4e:	lea    0x0(,%rcx,8),%rcx
  259f56:	lea    (%rcx,%rcx,2),%r15
  259f5a:	sub    %rax,%r15
  259f5d:	jmp    259f8b <<glass::engine::Engine>::apply+0x1c4b>
  259f5f:	mov    %r12,0x0(%rbp)
  259f63:	mov    0x54(%rsp),%eax
  259f67:	mov    %eax,0x8(%rbp)
  259f6a:	mov    0x50(%rsp),%eax
  259f6e:	mov    %eax,0xc(%rbp)
  259f71:	mov    0x8(%rsp),%eax
  259f75:	mov    %eax,0x10(%rbp)
  259f78:	movzwl 0x4c(%rsp),%eax
  259f7d:	mov    %ax,0x14(%rbp)
  259f81:	add    $0x18,%rbp
  259f85:	add    $0xffffffffffffffe8,%r15
  259f89:	je     259fb5 <<glass::engine::Engine>::apply+0x1c75>
  259f8b:	test   %r12,%r12
  259f8e:	je     259f9b <<glass::engine::Engine>::apply+0x1c5b>
  259f90:	lock incq (%r12)
  259f95:	jle    25a86f <<glass::engine::Engine>::apply+0x252f>
  259f9b:	mov    0x0(%rbp),%rax
  259f9f:	test   %rax,%rax
  259fa2:	je     259f5f <<glass::engine::Engine>::apply+0x1c1f>
  259fa4:	lock decq (%rax)
  259fa8:	jne    259f5f <<glass::engine::Engine>::apply+0x1c1f>
  259faa:	mov    %rbp,%rdi
  259fad:	call   *0x397855(%rip)        # 5f1808 <_DYNAMIC+0x268>
  259fb3:	jmp    259f5f <<glass::engine::Engine>::apply+0x1c1f>
  259fb5:	mov    0x20(%rsp),%rax
  259fba:	mov    0x68(%rsp),%rcx
  259fbf:	cmp    %ecx,0x38(%rax)
  259fc2:	jbe    259fd1 <<glass::engine::Engine>::apply+0x1c91>
  259fc4:	mov    0x20(%rsp),%rax
  259fc9:	mov    0x68(%rsp),%rcx
  259fce:	mov    %ecx,0x38(%rax)
  259fd1:	test   %r12,%r12
  259fd4:	je     259feb <<glass::engine::Engine>::apply+0x1cab>
  259fd6:	lock decq (%r12)
  259fdb:	jne    259feb <<glass::engine::Engine>::apply+0x1cab>
  259fdd:	lea    0xb0(%rsp),%rdi
  259fe5:	call   *0x39781d(%rip)        # 5f1808 <_DYNAMIC+0x268>
  259feb:	mov    0x20(%rsp),%rax
  259ff0:	mov    0x10(%rax),%r12
  259ff4:	cmp    %r12,0x40(%rsp)
  259ff9:	jb     25a014 <<glass::engine::Engine>::apply+0x1cd4>
  259ffb:	mov    0x108(%rsp),%rdi
  25a003:	call   1ad460 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  25a008:	mov    0x20(%rsp),%rax
  25a00d:	movl   $0xffffffff,0x28(%rax)
  25a014:	mov    0x20(%rsp),%rdx
  25a019:	mov    0x30(%rdx),%rax
  25a01d:	mov    0x30(%rsp),%rcx
  25a022:	add    $0x2,%rcx
  25a026:	cmp    %rax,%rcx
  25a029:	cmovbe %rax,%rcx
  25a02d:	mov    0x10(%rdx),%rax
  25a031:	mov    %rcx,0x30(%rdx)
  25a035:	cmp    %rax,0x70(%rsp)
  25a03a:	jae    25a871 <<glass::engine::Engine>::apply+0x2531>
  25a040:	mov    0x20(%rsp),%rax
  25a045:	mov    0x8(%rax),%rax
  25a049:	mov    0x70(%rsp),%rcx
  25a04e:	lea    (%rcx,%rcx,2),%rcx
  25a052:	lea    (%rax,%rcx,8),%r15
  25a056:	movl   $0x20,0x10(%rax,%rcx,8)
  25a05e:	mov    0xfc(%rsp),%edx
  25a065:	mov    %edx,0x8(%rax,%rcx,8)
  25a069:	mov    0xf8(%rsp),%edx
  25a070:	mov    %edx,0xc(%rax,%rcx,8)
  25a074:	mov    0x100(%rsp),%edx
  25a07b:	or     $0x40,%edx
  25a07e:	mov    %dx,0x14(%rax,%rcx,8)
  25a083:	mov    (%rax,%rcx,8),%rax
  25a087:	test   %rax,%rax
  25a08a:	je     25a09b <<glass::engine::Engine>::apply+0x1d5b>
  25a08c:	lock decq (%rax)
  25a090:	jne    25a09b <<glass::engine::Engine>::apply+0x1d5b>
  25a092:	mov    %r15,%rdi
  25a095:	call   *0x39776d(%rip)        # 5f1808 <_DYNAMIC+0x268>
  25a09b:	movq   $0x0,(%r15)
  25a0a2:	mov    0x220(%rsp),%rax
  25a0aa:	cmp    %rax,0x118(%rsp)
  25a0b2:	jb     25a0c1 <<glass::engine::Engine>::apply+0x1d81>
  25a0b4:	decq   0x118(%rsp)
  25a0bc:	movb   $0x1,0x6c(%r13)
  25a0c1:	mov    0x118(%rsp),%rax
  25a0c9:	mov    %rax,0x40(%r13)
  25a0cd:	incq   0x1d0(%rsp)
  25a0d5:	mov    0xd0(%rsp),%rax
  25a0dd:	mov    %eax,0x1e0(%rsp)
  25a0e4:	mov    $0x1,%r15d
  25a0ea:	mov    0x38(%rsp),%r12
  25a0ef:	mov    0x39a68b(%rip),%eax        # 5f4780 <glass::engine::run_whole::ON>
  25a0f5:	test   %eax,%eax
  25a0f7:	je     2592c8 <<glass::engine::Engine>::apply+0xf88>
  25a0fd:	call   18ba06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25a102:	jmp    2592c8 <<glass::engine::Engine>::apply+0xf88>
  25a107:	nopw   0x0(%rax,%rax,1)
  25a110:	mov    0x397f41(%rip),%rax        # 5f2058 <_DYNAMIC+0xab8>
  25a117:	mov    (%rax),%rax
  25a11a:	mov    $0x1b,%edi
  25a11f:	mov    %r14,%rsi
  25a122:	mov    0x110(%rsp),%rbx
  25a12a:	mov    %rbx,%rdx
  25a12d:	call   *%rax
  25a12f:	mov    %r14,%r13
  25a132:	mov    %rbx,%r14
  25a135:	cmp    $0x1,%rax
  25a139:	jne    25a3f0 <<glass::engine::Engine>::apply+0x20b0>
  25a13f:	mov    %rdx,%rcx
  25a142:	sub    %r13,%rcx
  25a145:	movb   $0x1,0xa80(%r12)
  25a14e:	movb   $0x0,0xa7e(%r12)
  25a157:	inc    %rcx
  25a15a:	cmp    %r15,%rcx
  25a15d:	jb     25a3fb <<glass::engine::Engine>::apply+0x20bb>
  25a163:	movzbl 0xa7e(%r12),%eax
  25a16c:	jmp    25a4f1 <<glass::engine::Engine>::apply+0x21b1>
  25a171:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a180:	mov    0x18(%rsp),%r15
  25a185:	cmp    %rbp,%r15
  25a188:	jb     25a73f <<glass::engine::Engine>::apply+0x23ff>
  25a18e:	mov    0x28(%rsp),%r13
  25a193:	mov    %r13,%rbx
  25a196:	add    %rbp,%rbx
  25a199:	mov    0x397eb8(%rip),%rax        # 5f2058 <_DYNAMIC+0xab8>
  25a1a0:	mov    (%rax),%rax
  25a1a3:	mov    $0x1b,%edi
  25a1a8:	mov    %rbx,%rsi
  25a1ab:	mov    0x110(%rsp),%r14
  25a1b3:	mov    %r14,%rdx
  25a1b6:	call   *%rax
  25a1b8:	cmp    $0x1,%rax
  25a1bc:	jne    25a1d9 <<glass::engine::Engine>::apply+0x1e99>
  25a1be:	sub    %rbx,%rdx
  25a1c1:	movb   $0x1,0xa80(%r12)
  25a1ca:	movb   $0x0,0xa7e(%r12)
  25a1d3:	add    %rdx,%rbp
  25a1d6:	inc    %rbp
  25a1d9:	cmp    %r15,%rbp
  25a1dc:	jae    25a213 <<glass::engine::Engine>::apply+0x1ed3>
  25a1de:	mov    0x60(%rsp),%rdi
  25a1e3:	mov    %r13,%rsi
  25a1e6:	mov    %r15,%rdx
  25a1e9:	mov    %rbp,%rcx
  25a1ec:	mov    %r15,%r8
  25a1ef:	call   26ff80 <<glass::engine::Mirror>::stretch>
  25a1f4:	cmp    %r15,%rax
  25a1f7:	jae    25a213 <<glass::engine::Engine>::apply+0x1ed3>
  25a1f9:	cmpb   $0x0,0xa80(%r12)
  25a202:	jne    25a213 <<glass::engine::Engine>::apply+0x1ed3>
  25a204:	movzbl -0x1(%r14),%eax
  25a209:	shr    $0x7,%al
  25a20c:	mov    0x60(%rsp),%rcx
  25a211:	mov    %al,(%rcx)
  25a213:	movzbl 0xa7e(%r12),%eax
  25a21c:	mov    %al,0xa7f(%r12)
  25a224:	sub    0x8(%rsp),%r15
  25a229:	mov    0xe0(%rsp),%rbx
  25a231:	jbe    25a260 <<glass::engine::Engine>::apply+0x1f20>
  25a233:	movzbl 0x39d89e(%rip),%eax        # 5f7ad8 <glass::engine::counters::COUNTING>
  25a23a:	test   %al,%al
  25a23c:	je     25a246 <<glass::engine::Engine>::apply+0x1f06>
  25a23e:	lock add %r15,0x39d89a(%rip)        # 5f7ae0 <glass::engine::counters::VTE_BYTES>
  25a246:	movzbl 0x39d82b(%rip),%eax        # 5f7a78 <glass::engine::probes::RUN_PROBE>
  25a24d:	cmp    $0x68,%al
  25a24f:	jne    25a59a <<glass::engine::Engine>::apply+0x225a>
  25a255:	data16 cs nopw 0x0(%rax,%rax,1)
  25a260:	mov    0x1e0(%rsp),%rax
  25a268:	mov    %rax,0xa70(%r12)
  25a270:	mov    0x1e8(%rsp),%eax
  25a277:	mov    %eax,0xa78(%r12)
  25a27f:	pshufd $0x4e,0x1c0(%rsp),%xmm0
  25a289:	movdqu %xmm0,0xa60(%r12)
  25a293:	movzbl 0x1ed(%rsp),%eax
  25a29b:	mov    %al,0xa7d(%r12)
  25a2a3:	movzbl 0x1ec(%rsp),%eax
  25a2ab:	and    $0x1,%eax
  25a2ae:	shl    $0x5,%eax
  25a2b1:	mov    0x1b8(%rsp,%rax,1),%rax
  25a2b9:	mov    0xa58(%r12),%rcx
  25a2c1:	cmp    %rcx,%rax
  25a2c4:	cmova  %rax,%rcx
  25a2c8:	mov    %rcx,0xa58(%r12)
  25a2d0:	mov    0x140(%rsp),%rax
  25a2d8:	mov    %rax,0x28(%rsp)
  25a2dd:	mov    0x148(%rsp),%r13
  25a2e5:	mov    0x150(%rsp),%r14
  25a2ed:	movq   $0x0,0x140(%rsp)
  25a2f9:	movq   $0x8,0x148(%rsp)
  25a305:	movq   $0x0,0x150(%rsp)
  25a311:	test   %r14,%r14
  25a314:	je     25a372 <<glass::engine::Engine>::apply+0x2032>
  25a316:	mov    0x8e8(%r12),%rax
  25a31e:	mov    0x8f8(%r12),%r15
  25a326:	sub    %r15,%rax
  25a329:	cmp    %rax,%r14
  25a32c:	ja     25a66d <<glass::engine::Engine>::apply+0x232d>
  25a332:	mov    %r14,%rax
  25a335:	shl    $0x4,%rax
  25a339:	lea    (%rax,%rax,2),%rdx
  25a33d:	lea    (%r15,%r15,2),%rdi
  25a341:	shl    $0x4,%rdi
  25a345:	add    0x8f0(%r12),%rdi
  25a34d:	mov    %r13,%rsi
  25a350:	call   *0x39747a(%rip)        # 5f17d0 <memcpy@GLIBC_2.14>
  25a356:	add    %r14,%r15
  25a359:	mov    %r15,0x8f8(%r12)
  25a361:	cmpq   $0x0,0x28(%rsp)
  25a367:	je     25a372 <<glass::engine::Engine>::apply+0x2032>
  25a369:	mov    %r13,%rdi
  25a36c:	call   *0x397476(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a372:	mov    0x170(%rsp),%r15
  25a37a:	lea    0x178(%rsp),%rax
  25a382:	movups (%rax),%xmm0
  25a385:	movups 0x10(%rax),%xmm1
  25a389:	movups 0x20(%rax),%xmm2
  25a38d:	movaps %xmm0,0x80(%rsp)
  25a395:	movaps %xmm1,0x90(%rsp)
  25a39d:	movaps %xmm2,0xa0(%rsp)
  25a3a5:	movq   $0xffffffffffffffff,0x170(%rsp)
  25a3b1:	cmp    $0xffffffffffffffff,%r15
  25a3b5:	je     25a3e0 <<glass::engine::Engine>::apply+0x20a0>
  25a3b7:	cmpq   $0x0,0x998(%r12)
  25a3c0:	jle    25a43a <<glass::engine::Engine>::apply+0x20fa>
  25a3c2:	mov    (%rbx),%rdi
  25a3c5:	call   *0x39741d(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a3cb:	cmpq   $0x0,0x170(%rsp)
  25a3d4:	setg   %bpl
  25a3d8:	jmp    25a43c <<glass::engine::Engine>::apply+0x20fc>
  25a3da:	nopw   0x0(%rax,%rax,1)
  25a3e0:	xor    %ebp,%ebp
  25a3e2:	jmp    25a467 <<glass::engine::Engine>::apply+0x2127>
  25a3e7:	nopw   0x0(%rax,%rax,1)
  25a3f0:	xor    %ecx,%ecx
  25a3f2:	cmp    %r15,%rcx
  25a3f5:	jae    25a163 <<glass::engine::Engine>::apply+0x1e23>
  25a3fb:	mov    0x60(%rsp),%rdi
  25a400:	mov    %r13,%rsi
  25a403:	mov    %r15,%rdx
  25a406:	mov    %r15,%r8
  25a409:	call   26ff80 <<glass::engine::Mirror>::stretch>
  25a40e:	cmp    %r15,%rax
  25a411:	jae    25a4e9 <<glass::engine::Engine>::apply+0x21a9>
  25a417:	cmpb   $0x0,0xa80(%r12)
  25a420:	jne    25a4e9 <<glass::engine::Engine>::apply+0x21a9>
  25a426:	movzbl -0x1(%r14),%eax
  25a42b:	shr    $0x7,%al
  25a42e:	mov    0x60(%rsp),%rcx
  25a433:	mov    %al,(%rcx)
  25a435:	jmp    25a4f1 <<glass::engine::Engine>::apply+0x21b1>
  25a43a:	xor    %ebp,%ebp
  25a43c:	mov    %r15,0x998(%r12)
  25a444:	movaps 0x80(%rsp),%xmm0
  25a44c:	movaps 0x90(%rsp),%xmm1
  25a454:	movaps 0xa0(%rsp),%xmm2
  25a45c:	movups %xmm2,0x20(%rbx)
  25a460:	movups %xmm1,0x10(%rbx)
  25a464:	movups %xmm0,(%rbx)
  25a467:	mov    0x158(%rsp),%rbx
  25a46f:	mov    0x160(%rsp),%r12
  25a477:	mov    0x178(%rsp),%r15
  25a47f:	cmpq   $0x0,0x140(%rsp)
  25a488:	je     25a498 <<glass::engine::Engine>::apply+0x2158>
  25a48a:	mov    0x148(%rsp),%rdi
  25a492:	call   *0x397350(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a498:	test   %rbx,%rbx
  25a49b:	je     25a4a6 <<glass::engine::Engine>::apply+0x2166>
  25a49d:	mov    %r12,%rdi
  25a4a0:	call   *0x397342(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a4a6:	test   %bpl,%bpl
  25a4a9:	je     25a4b4 <<glass::engine::Engine>::apply+0x2174>
  25a4ab:	mov    %r15,%rdi
  25a4ae:	call   *0x397334(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a4b4:	mov    0x38(%rsp),%rbx
  25a4b9:	mov    %rbx,%rdi
  25a4bc:	call   2575b0 <<glass::engine::Engine>::fold_sentinel>
  25a4c1:	test   %r14,%r14
  25a4c4:	setne  %al
  25a4c7:	cmpq   $0x0,0x28(%rsp)
  25a4cd:	sete   %cl
  25a4d0:	or     %al,%cl
  25a4d2:	cmp    $0x1,%cl
  25a4d5:	je     258420 <<glass::engine::Engine>::apply+0xe0>
  25a4db:	mov    %r13,%rdi
  25a4de:	call   *0x397304(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a4e4:	jmp    258420 <<glass::engine::Engine>::apply+0xe0>
  25a4e9:	mov    0x60(%rsp),%rax
  25a4ee:	movzbl (%rax),%eax
  25a4f1:	mov    %al,0xa7f(%r12)
  25a4f9:	mov    0xe0(%rsp),%rbx
  25a501:	xor    %ebp,%ebp
  25a503:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a510:	cmpl   $0xffffffff,0x710(%r12)
  25a519:	jne    25a574 <<glass::engine::Engine>::apply+0x2234>
  25a51b:	mov    0x78(%rsp),%rax
  25a520:	mov    %rax,0x80(%rsp)
  25a528:	lea    0x130(%rsp),%rax
  25a530:	mov    %rax,0x88(%rsp)
  25a538:	movb   $0x0,0x90(%rsp)
  25a540:	mov    %r15,%rcx
  25a543:	sub    %rbp,%rcx
  25a546:	jb     25a6aa <<glass::engine::Engine>::apply+0x236a>
  25a54c:	mov    %r13,%rdx
  25a54f:	add    %rbp,%rdx
  25a552:	mov    0xf0(%rsp),%rdi
  25a55a:	lea    0x80(%rsp),%rsi
  25a562:	call   1a0670 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a567:	add    %rax,%rbp
  25a56a:	cmp    %r15,%rbp
  25a56d:	jne    25a510 <<glass::engine::Engine>::apply+0x21d0>
  25a56f:	jmp    25a260 <<glass::engine::Engine>::apply+0x1f20>
  25a574:	mov    %r15,%rcx
  25a577:	sub    %rbp,%rcx
  25a57a:	jb     25a7b6 <<glass::engine::Engine>::apply+0x2476>
  25a580:	mov    %r13,%rdx
  25a583:	add    %rbp,%rdx
  25a586:	mov    0x78(%rsp),%rdi
  25a58b:	lea    0x130(%rsp),%rsi
  25a593:	call   1943d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a598:	jmp    25a567 <<glass::engine::Engine>::apply+0x2227>
  25a59a:	mov    %r15,%rdx
  25a59d:	add    0x8(%rsp),%r13
  25a5a2:	cmpb   $0x1,0x58(%rsp)
  25a5a7:	jne    25a5d7 <<glass::engine::Engine>::apply+0x2297>
  25a5a9:	cmpl   $0xffffffff,0x710(%r12)
  25a5b2:	jne    25a5d7 <<glass::engine::Engine>::apply+0x2297>
  25a5b4:	lea    0x130(%rsp),%rdi
  25a5bc:	mov    %r13,%rsi
  25a5bf:	call   2a1a20 <glass::engine::plain_c0>
  25a5c4:	test   %al,%al
  25a5c6:	mov    0xe0(%rsp),%rbx
  25a5ce:	mov    %r15,%rdx
  25a5d1:	jne    25a260 <<glass::engine::Engine>::apply+0x1f20>
  25a5d7:	xor    %ebp,%ebp
  25a5d9:	nopl   0x0(%rax)
  25a5e0:	cmpl   $0xffffffff,0x710(%r12)
  25a5e9:	jne    25a647 <<glass::engine::Engine>::apply+0x2307>
  25a5eb:	mov    0x78(%rsp),%rax
  25a5f0:	mov    %rax,0x80(%rsp)
  25a5f8:	lea    0x130(%rsp),%rax
  25a600:	mov    %rax,0x88(%rsp)
  25a608:	movb   $0x0,0x90(%rsp)
  25a610:	mov    %r15,%rcx
  25a613:	sub    %rbp,%rcx
  25a616:	jb     25a6aa <<glass::engine::Engine>::apply+0x236a>
  25a61c:	mov    %r13,%rdx
  25a61f:	add    %rbp,%rdx
  25a622:	mov    0xf0(%rsp),%rdi
  25a62a:	lea    0x80(%rsp),%rsi
  25a632:	call   1a0670 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a637:	add    %rax,%rbp
  25a63a:	mov    %r15,%rdx
  25a63d:	cmp    %r15,%rbp
  25a640:	jne    25a5e0 <<glass::engine::Engine>::apply+0x22a0>
  25a642:	jmp    25a260 <<glass::engine::Engine>::apply+0x1f20>
  25a647:	mov    %rdx,%rcx
  25a64a:	sub    %rbp,%rcx
  25a64d:	jb     25a7b6 <<glass::engine::Engine>::apply+0x2476>
  25a653:	mov    %r13,%rdx
  25a656:	add    %rbp,%rdx
  25a659:	mov    0x78(%rsp),%rdi
  25a65e:	lea    0x130(%rsp),%rsi
  25a666:	call   1943d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a66b:	jmp    25a637 <<glass::engine::Engine>::apply+0x22f7>
  25a66d:	mov    $0x8,%ecx
  25a672:	mov    $0x30,%r8d
  25a678:	mov    0x228(%rsp),%rdi
  25a680:	mov    %r15,%rsi
  25a683:	mov    %r14,%rdx
  25a686:	call   1cf970 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  25a68b:	mov    0x8f8(%r12),%r15
  25a693:	jmp    25a332 <<glass::engine::Engine>::apply+0x1ff2>
  25a698:	add    $0x248,%rsp
  25a69f:	pop    %rbx
  25a6a0:	pop    %r12
  25a6a2:	pop    %r13
  25a6a4:	pop    %r14
  25a6a6:	pop    %r15
  25a6a8:	pop    %rbp
  25a6a9:	ret
  25a6aa:	mov    %r15,%r8
  25a6ad:	lea    0x3597c4(%rip),%rcx        # 5b3e78 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25a6b4:	jmp    25a6d1 <<glass::engine::Engine>::apply+0x2391>
  25a6b6:	mov    %rbx,%r8
  25a6b9:	lea    0x36e6f0(%rip),%rcx        # 5c8db0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x157b0>
  25a6c0:	mov    0x18(%rsp),%r15
  25a6c5:	jmp    25a6d1 <<glass::engine::Engine>::apply+0x2391>
  25a6c7:	mov    %rbx,%r8
  25a6ca:	lea    0x36e6df(%rip),%rcx        # 5c8db0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x157b0>
  25a6d1:	mov    %rbp,%rdi
  25a6d4:	mov    %r8,%rsi
  25a6d7:	mov    %r15,%rdx
  25a6da:	call   *0x397298(%rip)        # 5f1978 <_DYNAMIC+0x3d8>
  25a6e0:	jmp    25a86f <<glass::engine::Engine>::apply+0x252f>
  25a6e5:	mov    %rbx,%rbp
  25a6e8:	mov    %r13,%r8
  25a6eb:	lea    0x370b1e(%rip),%rcx        # 5cb210 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c10>
  25a6f2:	mov    0x18(%rsp),%r15
  25a6f7:	jmp    25a6d1 <<glass::engine::Engine>::apply+0x2391>
  25a6f9:	lea    0x370b40(%rip),%rcx        # 5cb240 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c40>
  25a700:	xor    %ebp,%ebp
  25a702:	mov    0x18(%rsp),%r15
  25a707:	mov    %rdx,%r8
  25a70a:	jmp    25a6d1 <<glass::engine::Engine>::apply+0x2391>
  25a70c:	mov    0x8(%rsp),%rbp
  25a711:	mov    %rbx,%r8
  25a714:	lea    0x370b0d(%rip),%rcx        # 5cb228 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c28>
  25a71b:	mov    0x18(%rsp),%r15
  25a720:	jmp    25a6d1 <<glass::engine::Engine>::apply+0x2391>
  25a722:	mov    $0xffffffffffffffff,%r8
  25a729:	xor    %ebp,%ebp
  25a72b:	xor    %r15d,%r15d
  25a72e:	lea    0x370ac3(%rip),%rcx        # 5cb1f8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bf8>
  25a735:	jmp    25a6d1 <<glass::engine::Engine>::apply+0x2391>
  25a737:	mov    %r13,%rbp
  25a73a:	jmp    25a6b9 <<glass::engine::Engine>::apply+0x2379>
  25a73f:	mov    %r15,%r8
  25a742:	jmp    25a6ca <<glass::engine::Engine>::apply+0x238a>
  25a744:	lea    0x370a7d(%rip),%rdx        # 5cb1c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bc8>
  25a74b:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a74d:	mov    %r13,%rbp
  25a750:	lea    0x370b01(%rip),%rcx        # 5cb258 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c58>
  25a757:	mov    0x18(%rsp),%r15
  25a75c:	jmp    25a6d1 <<glass::engine::Engine>::apply+0x2391>
  25a761:	lea    0x370a78(%rip),%rdx        # 5cb1e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17be0>
  25a768:	mov    %r14,%rdi
  25a76b:	mov    0x18(%rsp),%rsi
  25a770:	call   *0x397042(%rip)        # 5f17b8 <_DYNAMIC+0x218>
  25a776:	jmp    25a86f <<glass::engine::Engine>::apply+0x252f>
  25a77b:	mov    $0x10,%eax
  25a780:	mov    %rax,0x18(%rsp)
  25a785:	mov    $0xffffffffffffffff,%r14
  25a78c:	lea    0x370add(%rip),%rdx        # 5cb270 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c70>
  25a793:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a795:	mov    $0x8,%edi
  25a79a:	mov    %r14,%rsi
  25a79d:	call   *0x397005(%rip)        # 5f17a8 <_DYNAMIC+0x208>
  25a7a3:	mov    $0x10,%eax
  25a7a8:	mov    %rax,0x18(%rsp)
  25a7ad:	lea    0x370ad4(%rip),%rdx        # 5cb288 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c88>
  25a7b4:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a7b6:	mov    %r15,%r8
  25a7b9:	lea    0x3596d0(%rip),%rcx        # 5b3e90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25a7c0:	jmp    25a6d1 <<glass::engine::Engine>::apply+0x2391>
  25a7c5:	mov    $0x10,%eax
  25a7ca:	mov    %rax,0x18(%rsp)
  25a7cf:	lea    0x370aca(%rip),%rdx        # 5cb2a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17ca0>
  25a7d6:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a7d8:	mov    %rsi,%r14
  25a7db:	mov    0x10(%rsp),%rax
  25a7e0:	mov    %rax,0x18(%rsp)
  25a7e5:	lea    0x3709c4(%rip),%rdx        # 5cb1b0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bb0>
  25a7ec:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a7f1:	mov    0x30(%rsp),%r14
  25a7f6:	mov    %rcx,0x18(%rsp)
  25a7fb:	lea    0x35c3e6(%rip),%rdx        # 5b6be8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25a802:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a807:	mov    %rcx,%r14
  25a80a:	mov    %rdx,0x18(%rsp)
  25a80f:	lea    0x35c3d2(%rip),%rdx        # 5b6be8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25a816:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a81b:	lea    0x36dd06(%rip),%rcx        # 5c8528 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  25a822:	mov    0x68(%rsp),%rdi
  25a827:	mov    0x40(%rsp),%rsi
  25a82c:	call   *0x397146(%rip)        # 5f1978 <_DYNAMIC+0x3d8>
  25a832:	jmp    25a86f <<glass::engine::Engine>::apply+0x252f>
  25a834:	mov    0x30(%rsp),%r14
  25a839:	jmp    25a847 <<glass::engine::Engine>::apply+0x2507>
  25a83b:	mov    0x30(%rsp),%r14
  25a840:	jmp    25a876 <<glass::engine::Engine>::apply+0x2536>
  25a842:	mov    0x70(%rsp),%r14
  25a847:	mov    %rax,0x18(%rsp)
  25a84c:	lea    0x36e8d5(%rip),%rdx        # 5c9128 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  25a853:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a858:	lea    0x36dcc9(%rip),%rcx        # 5c8528 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  25a85f:	mov    0x68(%rsp),%rdi
  25a864:	mov    0x40(%rsp),%rsi
  25a869:	call   *0x397109(%rip)        # 5f1978 <_DYNAMIC+0x3d8>
  25a86f:	ud2
  25a871:	mov    0x70(%rsp),%r14
  25a876:	mov    %rax,0x18(%rsp)
  25a87b:	lea    0x36e88e(%rip),%rdx        # 5c9110 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  25a882:	jmp    25a768 <<glass::engine::Engine>::apply+0x2428>
  25a887:	mov    %rax,%r15
  25a88a:	cmpq   $0x0,0x28(%rsp)
  25a890:	je     25a8fa <<glass::engine::Engine>::apply+0x25ba>
  25a892:	mov    %r13,%rdi
  25a895:	call   *0x396f4d(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a89b:	jmp    25a8fa <<glass::engine::Engine>::apply+0x25ba>
  25a89d:	mov    %rax,%r15
  25a8a0:	lock decq (%r12)
  25a8a5:	je     25a8b7 <<glass::engine::Engine>::apply+0x2577>
  25a8a7:	jmp    25a8fa <<glass::engine::Engine>::apply+0x25ba>
  25a8a9:	mov    %rax,%r15
  25a8ac:	mov    0x8(%rsp),%rax
  25a8b1:	lock decq (%rax)
  25a8b5:	jne    25a8fa <<glass::engine::Engine>::apply+0x25ba>
  25a8b7:	lea    0xb0(%rsp),%rdi
  25a8bf:	call   *0x396f43(%rip)        # 5f1808 <_DYNAMIC+0x268>
  25a8c5:	jmp    25a8fa <<glass::engine::Engine>::apply+0x25ba>
  25a8c7:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8c9:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8cb:	mov    %rax,%r15
  25a8ce:	test   %r14,%r14
  25a8d1:	setne  %al
  25a8d4:	cmpq   $0x0,0x28(%rsp)
  25a8da:	sete   %cl
  25a8dd:	or     %al,%cl
  25a8df:	jne    25a966 <<glass::engine::Engine>::apply+0x2626>
  25a8e5:	jmp    25a923 <<glass::engine::Engine>::apply+0x25e3>
  25a8e7:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8e9:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8eb:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8ed:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8ef:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8f1:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8f3:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8f5:	jmp    25a8f7 <<glass::engine::Engine>::apply+0x25b7>
  25a8f7:	mov    %rax,%r15
  25a8fa:	cmpq   $0x0,0x140(%rsp)
  25a903:	jne    25a934 <<glass::engine::Engine>::apply+0x25f4>
  25a905:	cmpq   $0x0,0x158(%rsp)
  25a90e:	jne    25a94d <<glass::engine::Engine>::apply+0x260d>
  25a910:	cmpq   $0x0,0x170(%rsp)
  25a919:	jle    25a966 <<glass::engine::Engine>::apply+0x2626>
  25a91b:	mov    0x178(%rsp),%r13
  25a923:	mov    %r13,%rdi
  25a926:	call   *0x396ebc(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a92c:	mov    %r15,%rdi
  25a92f:	call   5afef0 <_Unwind_Resume@plt>
  25a934:	mov    0x148(%rsp),%rdi
  25a93c:	call   *0x396ea6(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a942:	cmpq   $0x0,0x158(%rsp)
  25a94b:	je     25a910 <<glass::engine::Engine>::apply+0x25d0>
  25a94d:	mov    0x160(%rsp),%rdi
  25a955:	call   *0x396e8d(%rip)        # 5f17e8 <_DYNAMIC+0x248>
  25a95b:	cmpq   $0x0,0x170(%rsp)
  25a964:	jg     25a91b <<glass::engine::Engine>::apply+0x25db>
  25a966:	mov    %r15,%rdi
  25a969:	call   5afef0 <_Unwind_Resume@plt>
