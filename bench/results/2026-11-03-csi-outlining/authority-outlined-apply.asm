
/tmp/glass-i26-authority-outlined-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000258220 <<glass::engine::Engine>::apply>:
  258220:	push   %rbp
  258221:	push   %r15
  258223:	push   %r14
  258225:	push   %r13
  258227:	push   %r12
  258229:	push   %rbx
  25822a:	sub    $0x258,%rsp
  258231:	mov    %rdi,%r12
  258234:	testb  $0x10,0x6d5(%rdi)
  25823b:	jne    2582af <<glass::engine::Engine>::apply+0x8f>
  25823d:	cmpb   $0x2,0x278(%r12)
  258246:	jne    2582af <<glass::engine::Engine>::apply+0x8f>
  258248:	mov    0xb0(%r12),%rax
  258250:	dec    %rax
  258253:	movq   $0x0,0x250(%r12)
  25825f:	movl   $0x0,0x258(%r12)
  25826b:	movb   $0x0,0x260(%r12)
  258274:	mov    %rax,0x268(%r12)
  25827c:	movl   $0x0,0x270(%r12)
  258288:	movb   $0x1,0x278(%r12)
  258291:	movb   $0x0,0x280(%r12)
  25829a:	movq   $0x0,0xa60(%r12)
  2582a6:	movb   $0x1,0xa7d(%r12)
  2582af:	test   %rdx,%rdx
  2582b2:	je     259fdf <<glass::engine::Engine>::apply+0x1dbf>
  2582b8:	lea    0x10(%r12),%rax
  2582bd:	mov    %rax,0x248(%rsp)
  2582c5:	lea    0x6f0(%r12),%rax
  2582cd:	mov    %rax,0x50(%rsp)
  2582d2:	lea    0x8e8(%r12),%rax
  2582da:	mov    %rax,0x240(%rsp)
  2582e2:	lea    0x720(%r12),%rax
  2582ea:	mov    %rax,0xb0(%rsp)
  2582f2:	lea    0x9a0(%r12),%r14
  2582fa:	mov    $0x1000,%ecx
  2582ff:	lea    0x35e062(%rip),%rax        # 5b6368 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  258306:	mov    %rax,0xb8(%rsp)
  25830e:	mov    %r12,0x8(%rsp)
  258313:	mov    %r14,0x200(%rsp)
  25831b:	jmp    258345 <<glass::engine::Engine>::apply+0x125>
  25831d:	nopl   (%rax)
  258320:	mov    0x208(%rsp),%rsi
  258328:	mov    0x250(%rsp),%rdx
  258330:	sub    0x18(%rsp),%rdx
  258335:	mov    0x8(%rsp),%r12
  25833a:	mov    $0x1000,%ecx
  25833f:	je     259fdf <<glass::engine::Engine>::apply+0x1dbf>
  258345:	mov    %rsi,0x40(%rsp)
  25834a:	cmp    $0x2000,%rdx
  258351:	mov    $0x2000,%eax
  258356:	mov    %rdx,0x250(%rsp)
  25835e:	cmovb  %rdx,%rax
  258362:	mov    %rax,0x18(%rsp)
  258367:	mov    0x6d4(%r12),%ebp
  25836f:	and    %ecx,%ebp
  258371:	mov    0xa58(%r12),%r11
  258379:	mov    $0x0,%r14d
  25837f:	cmove  %r11,%r14
  258383:	mov    0xa68(%r12),%rax
  25838b:	mov    %rax,%r15
  25838e:	cmove  %r11,%r15
  258392:	mov    0x910(%r12),%r13
  25839a:	mov    $0x8,%ebx
  25839f:	test   %r13,%r13
  2583a2:	je     258407 <<glass::engine::Engine>::apply+0x1e7>
  2583a4:	mov    %r15,0x60(%rsp)
  2583a9:	mov    %r14,0x28(%rsp)
  2583ae:	mov    %r11,0x48(%rsp)
  2583b3:	mov    0x908(%r12),%r15
  2583bb:	lea    0x0(,%r13,8),%rax
  2583c3:	lea    (%rax,%rax,2),%r14
  2583c7:	mov    $0x8,%esi
  2583cc:	mov    %r14,%rdi
  2583cf:	call   *0x398af3(%rip)        # 5f0ec8 <_DYNAMIC+0x228>
  2583d5:	test   %rax,%rax
  2583d8:	je     25a0c1 <<glass::engine::Engine>::apply+0x1ea1>
  2583de:	mov    %rax,%rbx
  2583e1:	mov    %rax,%rdi
  2583e4:	mov    %r15,%rsi
  2583e7:	mov    %r14,%rdx
  2583ea:	call   *0x398ae0(%rip)        # 5f0ed0 <memcpy@GLIBC_2.14>
  2583f0:	mov    0xa68(%r12),%rax
  2583f8:	mov    0x48(%rsp),%r11
  2583fd:	mov    0x28(%rsp),%r14
  258402:	mov    0x60(%rsp),%r15
  258407:	mov    0x18(%rsp),%r8
  25840c:	mov    0x40(%rsp),%r10
  258411:	lea    (%r10,%r8,1),%rcx
  258415:	mov    %rcx,0x208(%rsp)
  25841d:	mov    0xa78(%r12),%ecx
  258425:	mov    0xa60(%r12),%rdx
  25842d:	movzbl 0xa7d(%r12),%esi
  258436:	movzbl 0xa7e(%r12),%edi
  25843f:	mov    0x248(%rsp),%r9
  258447:	mov    %r9,0x1b8(%rsp)
  25844f:	movq   $0x0,0x150(%rsp)
  25845b:	movq   $0x8,0x158(%rsp)
  258467:	movq   $0x0,0x160(%rsp)
  258473:	mov    %r13,0x168(%rsp)
  25847b:	mov    %rbx,0x170(%rsp)
  258483:	mov    %r13,0x178(%rsp)
  25848b:	mov    %r15,0x1c0(%rsp)
  258493:	mov    %r14,0x1c8(%rsp)
  25849b:	shr    $0xc,%ebp
  25849e:	mov    %bpl,0x1fc(%rsp)
  2584a6:	mov    %rax,0x1d0(%rsp)
  2584ae:	mov    %ecx,0x1f8(%rsp)
  2584b5:	mov    %rdx,0x1d8(%rsp)
  2584bd:	mov    %sil,0x1fd(%rsp)
  2584c5:	mov    %r8,0x1e0(%rsp)
  2584cd:	movups (%r12),%xmm0
  2584d2:	movaps %xmm0,0x140(%rsp)
  2584da:	movq   $0xffffffffffffffff,0x180(%rsp)
  2584e6:	mov    %r11,0x1e8(%rsp)
  2584ee:	mov    %dil,0x1fe(%rsp)
  2584f6:	mov    0xa70(%r12),%rax
  2584fe:	mov    %rax,0x1f0(%rsp)
  258506:	test   %dil,%dil
  258509:	je     259be0 <<glass::engine::Engine>::apply+0x19c0>
  25850f:	cmpb   $0xd,0x8c9(%r12)
  258518:	sete   %al
  25851b:	cmpq   $0x0,0x8b8(%r12)
  258524:	sete   %cl
  258527:	and    %al,%cl
  258529:	cmpl   $0xffffffff,0x710(%r12)
  258532:	sete   %r14b
  258536:	and    %cl,%r14b
  258539:	mov    $0x1,%cl
  25853b:	xor    %ebx,%ebx
  25853d:	mov    %r10,0x210(%rsp)
  258545:	mov    $0x1,%al
  258547:	mov    %eax,0xd8(%rsp)
  25854e:	movl   $0x0,0x24(%rsp)
  258556:	xor    %r13d,%r13d
  258559:	mov    %r10,%r12
  25855c:	jmp    258577 <<glass::engine::Engine>::apply+0x357>
  25855e:	xchg   %ax,%ax
  258560:	movl   $0x0,0x24(%rsp)
  258568:	mov    0x28(%rsp),%r15
  25856d:	add    %r15,%r13
  258570:	mov    0xdc(%rsp),%ecx
  258577:	test   $0x1,%cl
  25857a:	je     2585c0 <<glass::engine::Engine>::apply+0x3a0>
  25857c:	mov    0x3991dd(%rip),%rax        # 5f1760 <_DYNAMIC+0xac0>
  258583:	mov    (%rax),%rax
  258586:	mov    $0x1b,%edi
  25858b:	mov    0x210(%rsp),%rsi
  258593:	mov    0x208(%rsp),%rdx
  25859b:	call   *%rax
  25859d:	cmp    $0x1,%rax
  2585a1:	jne    2585c0 <<glass::engine::Engine>::apply+0x3a0>
  2585a3:	mov    %rdx,%r15
  2585a6:	sub    %r12,%r15
  2585a9:	inc    %rdx
  2585ac:	mov    $0x1,%al
  2585ae:	mov    %eax,0xdc(%rsp)
  2585b5:	mov    %rdx,0x210(%rsp)
  2585bd:	jmp    2585e9 <<glass::engine::Engine>::apply+0x3c9>
  2585bf:	nop
  2585c0:	testb  $0x1,0xd8(%rsp)
  2585c8:	je     259c73 <<glass::engine::Engine>::apply+0x1a53>
  2585ce:	movl   $0x0,0xd8(%rsp)
  2585d9:	mov    0x18(%rsp),%r15
  2585de:	movl   $0x0,0xdc(%rsp)
  2585e9:	mov    %r15,%rax
  2585ec:	sub    %r13,%rax
  2585ef:	cmp    $0x18,%rax
  2585f3:	mov    %r15,0x28(%rsp)
  2585f8:	jb     258bda <<glass::engine::Engine>::apply+0x9ba>
  2585fe:	cmp    %r15,0x18(%rsp)
  258603:	jae    25864b <<glass::engine::Engine>::apply+0x42b>
  258605:	jmp    25a079 <<glass::engine::Engine>::apply+0x1e59>
  25860a:	nopw   0x0(%rax,%rax,1)
  258610:	mov    0x40(%rsp),%r12
  258615:	cmp    $0xd,%al
  258617:	sete   %al
  25861a:	test   %rcx,%rcx
  25861d:	sete   %cl
  258620:	and    %al,%cl
  258622:	cmp    $0xffffffff,%edx
  258625:	sete   %r14b
  258629:	and    %cl,%r14b
  25862c:	mov    0x48(%rsp),%r13
  258631:	mov    %r13,%rbx
  258634:	mov    0x28(%rsp),%rax
  258639:	sub    %r13,%rax
  25863c:	cmp    $0x17,%rax
  258640:	mov    0x28(%rsp),%r15
  258645:	jbe    258bda <<glass::engine::Engine>::apply+0x9ba>
  25864b:	lea    0xf0(%rsp),%rdi
  258653:	mov    %r12,%rsi
  258656:	mov    %r15,%rdx
  258659:	mov    %r13,%rcx
  25865c:	call   2a0ea0 <glass::engine::next_run>
  258661:	movzbl 0x100(%rsp),%r12d
  25866a:	cmp    $0x2,%r12b
  25866e:	je     258bd0 <<glass::engine::Engine>::apply+0x9b0>
  258674:	mov    0xf0(%rsp),%r15
  25867c:	mov    0xf8(%rsp),%rax
  258684:	mov    %rax,0x48(%rsp)
  258689:	mov    %r15,%rbp
  25868c:	sub    %rbx,%rbp
  25868f:	jbe    258790 <<glass::engine::Engine>::apply+0x570>
  258695:	movzbl 0x39eadc(%rip),%eax        # 5f7178 <glass::engine::probes::RUN_PROBE>
  25869c:	mov    %r15,%r13
  25869f:	cmp    $0x68,%al
  2586a1:	je     258793 <<glass::engine::Engine>::apply+0x573>
  2586a7:	cmp    0x18(%rsp),%r15
  2586ac:	ja     25a06b <<glass::engine::Engine>::apply+0x1e4b>
  2586b2:	add    0x40(%rsp),%rbx
  2586b7:	cmp    $0x1,%r14b
  2586bb:	jne    2586e9 <<glass::engine::Engine>::apply+0x4c9>
  2586bd:	mov    0x8(%rsp),%rax
  2586c2:	cmpl   $0xffffffff,0x710(%rax)
  2586c9:	jne    2586e9 <<glass::engine::Engine>::apply+0x4c9>
  2586cb:	lea    0x140(%rsp),%rdi
  2586d3:	mov    %rbx,%rsi
  2586d6:	mov    %rbp,%rdx
  2586d9:	call   2a1190 <glass::engine::plain_c0>
  2586de:	mov    %r15,%r13
  2586e1:	test   %al,%al
  2586e3:	jne    258793 <<glass::engine::Engine>::apply+0x573>
  2586e9:	movzbl 0x39ea98(%rip),%eax        # 5f7188 <glass::engine::timers::ON>
  2586f0:	test   %al,%al
  2586f2:	je     258a20 <<glass::engine::Engine>::apply+0x800>
  2586f8:	mov    $0x1,%edi
  2586fd:	call   50e050 <<std::sys::pal::unix::time::Timespec>::now>
  258702:	mov    %edx,0x60(%rsp)
  258706:	mov    %rax,%r14
  258709:	xor    %r13d,%r13d
  25870c:	nopl   0x0(%rax)
  258710:	mov    0x8(%rsp),%rax
  258715:	cmpl   $0xffffffff,0x710(%rax)
  25871c:	jne    25876c <<glass::engine::Engine>::apply+0x54c>
  25871e:	mov    0x50(%rsp),%rax
  258723:	mov    %rax,0x70(%rsp)
  258728:	lea    0x140(%rsp),%rax
  258730:	mov    %rax,0x78(%rsp)
  258735:	movb   $0x0,0x80(%rsp)
  25873d:	mov    %rbp,%rcx
  258740:	sub    %r13,%rcx
  258743:	jb     259ff9 <<glass::engine::Engine>::apply+0x1dd9>
  258749:	lea    (%rbx,%r13,1),%rdx
  25874d:	mov    0xb0(%rsp),%rdi
  258755:	lea    0x70(%rsp),%rsi
  25875a:	call   1a0570 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25875f:	add    %rax,%r13
  258762:	cmp    %rbp,%r13
  258765:	jne    258710 <<glass::engine::Engine>::apply+0x4f0>
  258767:	jmp    258987 <<glass::engine::Engine>::apply+0x767>
  25876c:	mov    %rbp,%rcx
  25876f:	sub    %r13,%rcx
  258772:	jb     25a0d7 <<glass::engine::Engine>::apply+0x1eb7>
  258778:	lea    (%rbx,%r13,1),%rdx
  25877c:	mov    0x50(%rsp),%rdi
  258781:	lea    0x140(%rsp),%rsi
  258789:	call   1942d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25878e:	jmp    25875f <<glass::engine::Engine>::apply+0x53f>
  258790:	mov    %rbx,%r13
  258793:	mov    0x8(%rsp),%rdi
  258798:	movzbl 0x8c9(%rdi),%eax
  25879f:	cmp    $0xd,%al
  2587a1:	sete   %dl
  2587a4:	mov    0x8b8(%rdi),%rcx
  2587ab:	test   %rcx,%rcx
  2587ae:	sete   %sil
  2587b2:	and    %dl,%sil
  2587b5:	mov    0x710(%rdi),%edx
  2587bb:	cmp    $0xffffffff,%edx
  2587be:	sete   %dil
  2587c2:	test   %dil,%sil
  2587c5:	je     258840 <<glass::engine::Engine>::apply+0x620>
  2587c7:	mov    0x48(%rsp),%rax
  2587cc:	mov    %rax,%rbp
  2587cf:	sub    %r15,%rbp
  2587d2:	mov    0x18(%rsp),%rdx
  2587d7:	jb     25a031 <<glass::engine::Engine>::apply+0x1e11>
  2587dd:	cmp    %rdx,%rax
  2587e0:	ja     25a040 <<glass::engine::Engine>::apply+0x1e20>
  2587e6:	movzbl 0x39e98b(%rip),%ebx        # 5f7178 <glass::engine::probes::RUN_PROBE>
  2587ed:	movzbl 0x39e994(%rip),%eax        # 5f7188 <glass::engine::timers::ON>
  2587f4:	test   %al,%al
  2587f6:	je     25890e <<glass::engine::Engine>::apply+0x6ee>
  2587fc:	mov    $0x1,%edi
  258801:	call   50e050 <<std::sys::pal::unix::time::Timespec>::now>
  258806:	mov    %rax,0x60(%rsp)
  25880b:	mov    %edx,%r14d
  25880e:	cmp    $0x63,%bl
  258811:	jbe    25891d <<glass::engine::Engine>::apply+0x6fd>
  258817:	movzbl %r12b,%eax
  25881b:	mov    %rbp,%rbx
  25881e:	sub    %rax,%rbx
  258821:	mov    0x40(%rsp),%r12
  258826:	cmp    $0xffffffff,%r14d
  25882a:	jne    258b0c <<glass::engine::Engine>::apply+0x8ec>
  258830:	jmp    258b9d <<glass::engine::Engine>::apply+0x97d>
  258835:	data16 cs nopw 0x0(%rax,%rax,1)
  258840:	mov    0x18(%rsp),%rsi
  258845:	mov    0x48(%rsp),%r14
  25884a:	cmp    %rsi,%r14
  25884d:	ja     25a01f <<glass::engine::Engine>::apply+0x1dff>
  258853:	cmp    %r13,%r14
  258856:	jb     25a01f <<glass::engine::Engine>::apply+0x1dff>
  25885c:	sub    %r13,%r14
  25885f:	je     258610 <<glass::engine::Engine>::apply+0x3f0>
  258865:	mov    0x40(%rsp),%r12
  25886a:	add    %r12,%r13
  25886d:	xor    %ebx,%ebx
  25886f:	nop
  258870:	mov    0x8(%rsp),%rax
  258875:	cmpl   $0xffffffff,0x710(%rax)
  25887c:	jne    2588c9 <<glass::engine::Engine>::apply+0x6a9>
  25887e:	mov    0x50(%rsp),%rax
  258883:	mov    %rax,0x70(%rsp)
  258888:	lea    0x140(%rsp),%rax
  258890:	mov    %rax,0x78(%rsp)
  258895:	movb   $0x0,0x80(%rsp)
  25889d:	mov    %r14,%rcx
  2588a0:	sub    %rbx,%rcx
  2588a3:	jb     259ff1 <<glass::engine::Engine>::apply+0x1dd1>
  2588a9:	lea    (%rbx,%r13,1),%rdx
  2588ad:	mov    0xb0(%rsp),%rdi
  2588b5:	lea    0x70(%rsp),%rsi
  2588ba:	call   1a0570 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  2588bf:	add    %rax,%rbx
  2588c2:	cmp    %r14,%rbx
  2588c5:	jne    258870 <<glass::engine::Engine>::apply+0x650>
  2588c7:	jmp    2588f0 <<glass::engine::Engine>::apply+0x6d0>
  2588c9:	mov    %r14,%rcx
  2588cc:	sub    %rbx,%rcx
  2588cf:	jb     25a0cf <<glass::engine::Engine>::apply+0x1eaf>
  2588d5:	lea    (%rbx,%r13,1),%rdx
  2588d9:	mov    0x50(%rsp),%rdi
  2588de:	lea    0x140(%rsp),%rsi
  2588e6:	call   1942d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  2588eb:	jmp    2588bf <<glass::engine::Engine>::apply+0x69f>
  2588ed:	nopl   (%rax)
  2588f0:	mov    0x8(%rsp),%rdx
  2588f5:	movzbl 0x8c9(%rdx),%eax
  2588fc:	mov    0x8b8(%rdx),%rcx
  258903:	mov    0x710(%rdx),%edx
  258909:	jmp    258615 <<glass::engine::Engine>::apply+0x3f5>
  25890e:	mov    $0xffffffff,%r14d
  258914:	cmp    $0x63,%bl
  258917:	ja     258817 <<glass::engine::Engine>::apply+0x5f7>
  25891d:	mov    0x39b55d(%rip),%eax        # 5f3e80 <glass::engine::run_whole::ON>
  258923:	test   %eax,%eax
  258925:	jne    258bc0 <<glass::engine::Engine>::apply+0x9a0>
  25892b:	mov    0x40(%rsp),%rax
  258930:	lea    (%rax,%r15,1),%rsi
  258934:	cmpb   $0x0,0x39b549(%rip)        # 5f3e84 <glass::engine::run_whole::ON+0x4>
  25893b:	je     25895c <<glass::engine::Engine>::apply+0x73c>
  25893d:	test   $0x1,%r12b
  258941:	je     258ab5 <<glass::engine::Engine>::apply+0x895>
  258947:	lea    0x140(%rsp),%rdi
  25894f:	mov    %rbp,%rdx
  258952:	call   264630 <<glass::engine::Watch>::print_run>
  258957:	jmp    258ac5 <<glass::engine::Engine>::apply+0x8a5>
  25895c:	test   $0x1,%r12b
  258960:	je     258aea <<glass::engine::Engine>::apply+0x8ca>
  258966:	cmp    %r15,0x48(%rsp)
  25896b:	je     25a089 <<glass::engine::Engine>::apply+0x1e69>
  258971:	lea    -0x1(%rbp),%rdx
  258975:	lea    0x140(%rsp),%rdi
  25897d:	call   264630 <<glass::engine::Watch>::print_run>
  258982:	jmp    258afa <<glass::engine::Engine>::apply+0x8da>
  258987:	movzbl 0x39e7fa(%rip),%eax        # 5f7188 <glass::engine::timers::ON>
  25898e:	mov    %r15,%r13
  258991:	test   %al,%al
  258993:	je     258793 <<glass::engine::Engine>::apply+0x573>
  258999:	mov    $0x1,%edi
  25899e:	call   50e050 <<std::sys::pal::unix::time::Timespec>::now>
  2589a3:	mov    %rax,0x218(%rsp)
  2589ab:	mov    %edx,0x220(%rsp)
  2589b2:	mov    %r14,0x228(%rsp)
  2589ba:	mov    0x60(%rsp),%eax
  2589be:	mov    %eax,0x230(%rsp)
  2589c5:	lea    0x70(%rsp),%rdi
  2589ca:	lea    0x218(%rsp),%rsi
  2589d2:	lea    0x228(%rsp),%rdx
  2589da:	call   50df90 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  2589df:	imul   $0x3b9aca00,0x78(%rsp),%rax
  2589e8:	mov    0x80(%rsp),%ecx
  2589ef:	add    %rcx,%rax
  2589f2:	cmpb   $0x0,0x70(%rsp)
  2589f7:	mov    $0x0,%ecx
  2589fc:	cmove  %rax,%rcx
  258a00:	lock add %rcx,0x39e790(%rip)        # 5f7198 <glass::engine::timers::VTE_NS>
  258a08:	lock incq 0x39e7b8(%rip)        # 5f71c8 <glass::engine::timers::VTE_CALLS>
  258a10:	lock add %rbp,0x39e7a8(%rip)        # 5f71c0 <glass::engine::timers::VTE_BYTES>
  258a18:	mov    %r15,%r13
  258a1b:	jmp    258793 <<glass::engine::Engine>::apply+0x573>
  258a20:	xor    %r14d,%r14d
  258a23:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258a30:	mov    0x8(%rsp),%rax
  258a35:	cmpl   $0xffffffff,0x710(%rax)
  258a3c:	jne    258a89 <<glass::engine::Engine>::apply+0x869>
  258a3e:	mov    0x50(%rsp),%rax
  258a43:	mov    %rax,0x70(%rsp)
  258a48:	lea    0x140(%rsp),%rax
  258a50:	mov    %rax,0x78(%rsp)
  258a55:	movb   $0x0,0x80(%rsp)
  258a5d:	mov    %rbp,%rcx
  258a60:	sub    %r14,%rcx
  258a63:	jb     259ffe <<glass::engine::Engine>::apply+0x1dde>
  258a69:	lea    (%rbx,%r14,1),%rdx
  258a6d:	mov    0xb0(%rsp),%rdi
  258a75:	lea    0x70(%rsp),%rsi
  258a7a:	call   1a0570 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258a7f:	add    %rax,%r14
  258a82:	cmp    %rbp,%r14
  258a85:	jne    258a30 <<glass::engine::Engine>::apply+0x810>
  258a87:	jmp    258aad <<glass::engine::Engine>::apply+0x88d>
  258a89:	mov    %rbp,%rcx
  258a8c:	sub    %r14,%rcx
  258a8f:	jb     25a0dc <<glass::engine::Engine>::apply+0x1ebc>
  258a95:	lea    (%rbx,%r14,1),%rdx
  258a99:	mov    0x50(%rsp),%rdi
  258a9e:	lea    0x140(%rsp),%rsi
  258aa6:	call   1942d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258aab:	jmp    258a7f <<glass::engine::Engine>::apply+0x85f>
  258aad:	mov    %r15,%r13
  258ab0:	jmp    258793 <<glass::engine::Engine>::apply+0x573>
  258ab5:	lea    0x140(%rsp),%rdi
  258abd:	mov    %rbp,%rdx
  258ac0:	call   261c90 <<glass::engine::Watch>::print_utf8>
  258ac5:	mov    %rax,%rbx
  258ac8:	mov    0x1f0(%rsp),%eax
  258acf:	mov    0x8(%rsp),%rcx
  258ad4:	mov    %eax,0x718(%rcx)
  258ada:	mov    0x40(%rsp),%r12
  258adf:	cmp    $0xffffffff,%r14d
  258ae3:	jne    258b0c <<glass::engine::Engine>::apply+0x8ec>
  258ae5:	jmp    258b9d <<glass::engine::Engine>::apply+0x97d>
  258aea:	lea    0x140(%rsp),%rdi
  258af2:	mov    %rbp,%rdx
  258af5:	call   261c90 <<glass::engine::Watch>::print_utf8>
  258afa:	mov    %rax,%rbx
  258afd:	mov    0x40(%rsp),%r12
  258b02:	cmp    $0xffffffff,%r14d
  258b06:	je     258b9d <<glass::engine::Engine>::apply+0x97d>
  258b0c:	movzbl 0x39e675(%rip),%eax        # 5f7188 <glass::engine::timers::ON>
  258b13:	test   %al,%al
  258b15:	je     258b95 <<glass::engine::Engine>::apply+0x975>
  258b17:	mov    $0x1,%edi
  258b1c:	call   50e050 <<std::sys::pal::unix::time::Timespec>::now>
  258b21:	mov    %rax,0x218(%rsp)
  258b29:	mov    %edx,0x220(%rsp)
  258b30:	mov    0x60(%rsp),%rax
  258b35:	mov    %rax,0x228(%rsp)
  258b3d:	mov    %r14d,0x230(%rsp)
  258b45:	lea    0x70(%rsp),%rdi
  258b4a:	lea    0x218(%rsp),%rsi
  258b52:	lea    0x228(%rsp),%rdx
  258b5a:	call   50df90 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258b5f:	imul   $0x3b9aca00,0x78(%rsp),%rax
  258b68:	mov    0x80(%rsp),%ecx
  258b6f:	add    %rcx,%rax
  258b72:	cmpb   $0x0,0x70(%rsp)
  258b77:	mov    $0x0,%ecx
  258b7c:	cmove  %rax,%rcx
  258b80:	lock add %rcx,0x39e608(%rip)        # 5f7190 <glass::engine::timers::RUN_NS>
  258b88:	lock incq 0x39e628(%rip)        # 5f71b8 <glass::engine::timers::RUN_CALLS>
  258b90:	mov    0x40(%rsp),%r12
  258b95:	lock add %rbp,0x39e613(%rip)        # 5f71b0 <glass::engine::timers::RUN_BYTES>
  258b9d:	movzbl 0x39e634(%rip),%eax        # 5f71d8 <glass::engine::counters::COUNTING>
  258ba4:	test   %al,%al
  258ba6:	je     258bb0 <<glass::engine::Engine>::apply+0x990>
  258ba8:	lock add %rbx,0x39e620(%rip)        # 5f71d0 <glass::engine::counters::LANE_RUN_BYTES>
  258bb0:	add    %r13,%rbx
  258bb3:	mov    $0x1,%r14b
  258bb6:	mov    0x48(%rsp),%r13
  258bbb:	jmp    258634 <<glass::engine::Engine>::apply+0x414>
  258bc0:	call   18b906 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  258bc5:	jmp    25892b <<glass::engine::Engine>::apply+0x70b>
  258bca:	nopw   0x0(%rax,%rax,1)
  258bd0:	mov    0x40(%rsp),%r12
  258bd5:	mov    0x28(%rsp),%r15
  258bda:	mov    $0x1,%r13d
  258be0:	mov    0x18(%rsp),%rdx
  258be5:	sub    %r15,%rdx
  258be8:	jbe    25856d <<glass::engine::Engine>::apply+0x34d>
  258bee:	cmp    %rbx,0xe8(%rsp)
  258bf6:	sete   %bpl
  258bfa:	lea    (%r12,%r15,1),%rsi
  258bfe:	lea    0x70(%rsp),%rdi
  258c03:	call   2a0cd0 <glass::engine::simple>
  258c08:	movzbl 0xa1(%rsp),%edi
  258c10:	cmp    $0x2,%dil
  258c14:	je     258560 <<glass::engine::Engine>::apply+0x340>
  258c1a:	mov    0x24(%rsp),%eax
  258c1e:	and    %bpl,%al
  258c21:	mov    %eax,0x24(%rsp)
  258c25:	mov    0x70(%rsp),%r13
  258c2a:	mov    0x98(%rsp),%rbp
  258c32:	lea    0x78(%rsp),%rcx
  258c37:	movups (%rcx),%xmm0
  258c3a:	movups 0x10(%rcx),%xmm1
  258c3e:	movaps %xmm1,0x100(%rsp)
  258c46:	movaps %xmm0,0xf0(%rsp)
  258c4e:	movzbl 0xa0(%rsp),%esi
  258c56:	movzwl 0x2e(%rcx),%eax
  258c5a:	lea    0x11a(%rsp),%rdx
  258c62:	mov    %ax,0x4(%rdx)
  258c66:	mov    0x2a(%rcx),%eax
  258c69:	mov    %eax,(%rdx)
  258c6b:	mov    %rbp,0x110(%rsp)
  258c73:	mov    %sil,0x3f(%rsp)
  258c78:	mov    %sil,0x118(%rsp)
  258c80:	mov    %dil,0x60(%rsp)
  258c85:	mov    %dil,0x119(%rsp)
  258c8d:	mov    0x28(%rsp),%r15
  258c92:	sub    %rbx,%r15
  258c95:	jbe    258dcf <<glass::engine::Engine>::apply+0xbaf>
  258c9b:	mov    0x39b1df(%rip),%eax        # 5f3e80 <glass::engine::run_whole::ON>
  258ca1:	test   %eax,%eax
  258ca3:	jne    259430 <<glass::engine::Engine>::apply+0x1210>
  258ca9:	movzbl 0x39b1d4(%rip),%eax        # 5f3e84 <glass::engine::run_whole::ON+0x4>
  258cb0:	xor    $0x1,%rax
  258cb4:	cmp    %rax,%r15
  258cb7:	seta   %al
  258cba:	and    0x24(%rsp),%al
  258cbe:	cmp    $0x1,%al
  258cc0:	jne    258dff <<glass::engine::Engine>::apply+0xbdf>
  258cc6:	mov    %rbx,%rax
  258cc9:	cmp    %rbx,0x28(%rsp)
  258cce:	je     258ceb <<glass::engine::Engine>::apply+0xacb>
  258cd0:	movzbl (%r12,%rax,1),%ecx
  258cd5:	add    $0xe0,%cl
  258cd8:	cmp    $0x5f,%cl
  258cdb:	jae    258df7 <<glass::engine::Engine>::apply+0xbd7>
  258ce1:	inc    %rax
  258ce4:	cmp    %rax,0x28(%rsp)
  258ce9:	jne    258cd0 <<glass::engine::Engine>::apply+0xab0>
  258ceb:	mov    0x39b18f(%rip),%eax        # 5f3e80 <glass::engine::run_whole::ON>
  258cf1:	test   %eax,%eax
  258cf3:	jne    25943a <<glass::engine::Engine>::apply+0x121a>
  258cf9:	add    %r12,%rbx
  258cfc:	movzbl 0x39b181(%rip),%eax        # 5f3e84 <glass::engine::run_whole::ON+0x4>
  258d03:	xor    $0x1,%rax
  258d07:	sub    %rax,%r15
  258d0a:	mov    %r15,%r12
  258d0d:	cmp    $0x1,%r15
  258d11:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d13:	cmpb   $0x1,0x1fe(%rsp)
  258d1b:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d1d:	cmpq   $0x0,0x178(%rsp)
  258d26:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d28:	mov    0x1b8(%rsp),%rcx
  258d30:	testb  $0x4,0x6c5(%rcx)
  258d37:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d39:	cmpq   $0x0,0x50(%rcx)
  258d3e:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d40:	movzwl 0x64(%rcx),%eax
  258d44:	test   $0x460,%eax
  258d49:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d4b:	cmpb   $0x0,0x68(%rcx)
  258d4f:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d51:	cmpb   $0x0,0x69(%rcx)
  258d55:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d57:	cmpb   $0x0,0x6a(%rcx)
  258d5b:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  258d5d:	cmpb   $0x0,0x6b(%rcx)
  258d61:	je     259444 <<glass::engine::Engine>::apply+0x1224>
  258d67:	lea    0x140(%rsp),%rdi
  258d6f:	mov    %rbx,%rsi
  258d72:	mov    %r12,%rdx
  258d75:	call   264630 <<glass::engine::Watch>::print_run>
  258d7a:	mov    %rax,%rbx
  258d7d:	mov    0x39b0fd(%rip),%eax        # 5f3e80 <glass::engine::run_whole::ON>
  258d83:	test   %eax,%eax
  258d85:	jne    259bc7 <<glass::engine::Engine>::apply+0x19a7>
  258d8b:	cmpb   $0x0,0x39b0f2(%rip)        # 5f3e84 <glass::engine::run_whole::ON+0x4>
  258d92:	movzbl 0x60(%rsp),%r15d
  258d98:	je     258dac <<glass::engine::Engine>::apply+0xb8c>
  258d9a:	mov    0x1f0(%rsp),%eax
  258da1:	mov    0x8(%rsp),%rcx
  258da6:	mov    %eax,0x718(%rcx)
  258dac:	add    0xe8(%rsp),%rbx
  258db4:	mov    0x28(%rsp),%r12
  258db9:	sub    %rbx,%r12
  258dbc:	ja     258e0f <<glass::engine::Engine>::apply+0xbef>
  258dbe:	mov    0x40(%rsp),%r12
  258dc3:	cmpb   $0x0,0x24(%rsp)
  258dc8:	je     258de0 <<glass::engine::Engine>::apply+0xbc0>
  258dca:	jmp    258ee3 <<glass::engine::Engine>::apply+0xcc3>
  258dcf:	movzbl 0x60(%rsp),%r15d
  258dd5:	cmpb   $0x0,0x24(%rsp)
  258dda:	jne    258ee3 <<glass::engine::Engine>::apply+0xcc3>
  258de0:	mov    0x8(%rsp),%rax
  258de5:	cmpb   $0xd,0x8c9(%rax)
  258dec:	je     258ed0 <<glass::engine::Engine>::apply+0xcb0>
  258df2:	jmp    258f44 <<glass::engine::Engine>::apply+0xd24>
  258df7:	mov    0xe8(%rsp),%rbx
  258dff:	mov    0x28(%rsp),%r12
  258e04:	movzbl 0x60(%rsp),%r15d
  258e0a:	sub    %rbx,%r12
  258e0d:	jbe    258dbe <<glass::engine::Engine>::apply+0xb9e>
  258e0f:	mov    %rbp,0xc0(%rsp)
  258e17:	mov    %r13,%rbp
  258e1a:	add    0x40(%rsp),%rbx
  258e1f:	xor    %r13d,%r13d
  258e22:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258e30:	mov    0x8(%rsp),%rax
  258e35:	cmpl   $0xffffffff,0x710(%rax)
  258e3c:	jne    258e89 <<glass::engine::Engine>::apply+0xc69>
  258e3e:	mov    0x50(%rsp),%rax
  258e43:	mov    %rax,0x70(%rsp)
  258e48:	lea    0x140(%rsp),%rax
  258e50:	mov    %rax,0x78(%rsp)
  258e55:	movb   $0x0,0x80(%rsp)
  258e5d:	mov    %r12,%rcx
  258e60:	sub    %r13,%rcx
  258e63:	jb     25a060 <<glass::engine::Engine>::apply+0x1e40>
  258e69:	lea    (%rbx,%r13,1),%rdx
  258e6d:	mov    0xb0(%rsp),%rdi
  258e75:	lea    0x70(%rsp),%rsi
  258e7a:	call   1a0570 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258e7f:	add    %rax,%r13
  258e82:	cmp    %r12,%r13
  258e85:	jne    258e30 <<glass::engine::Engine>::apply+0xc10>
  258e87:	jmp    258ead <<glass::engine::Engine>::apply+0xc8d>
  258e89:	mov    %r12,%rcx
  258e8c:	sub    %r13,%rcx
  258e8f:	jb     25a0fb <<glass::engine::Engine>::apply+0x1edb>
  258e95:	lea    (%rbx,%r13,1),%rdx
  258e99:	mov    0x50(%rsp),%rdi
  258e9e:	lea    0x140(%rsp),%rsi
  258ea6:	call   1942d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258eab:	jmp    258e7f <<glass::engine::Engine>::apply+0xc5f>
  258ead:	mov    0x28(%rsp),%rbx
  258eb2:	mov    0x40(%rsp),%r12
  258eb7:	mov    %rbp,%r13
  258eba:	mov    0xc0(%rsp),%rbp
  258ec2:	mov    0x8(%rsp),%rax
  258ec7:	cmpb   $0xd,0x8c9(%rax)
  258ece:	jne    258f44 <<glass::engine::Engine>::apply+0xd24>
  258ed0:	cmpq   $0x0,0x8b8(%rax)
  258ed8:	jne    258f44 <<glass::engine::Engine>::apply+0xd24>
  258eda:	cmpl   $0xffffffff,0x710(%rax)
  258ee1:	jne    258f44 <<glass::engine::Engine>::apply+0xd24>
  258ee3:	cmp    $0x11,%rbp
  258ee7:	jae    25a0a0 <<glass::engine::Engine>::apply+0x1e80>
  258eed:	test   $0x1,%r15b
  258ef1:	je     258f13 <<glass::engine::Engine>::apply+0xcf3>
  258ef3:	test   %rbp,%rbp
  258ef6:	je     25938c <<glass::engine::Engine>::apply+0x116c>
  258efc:	movzwl 0xf0(%rsp),%r14d
  258f05:	xor    %eax,%eax
  258f07:	test   %r14w,%r14w
  258f0b:	setne  %al
  258f0e:	jmp    25938e <<glass::engine::Engine>::apply+0x116e>
  258f13:	testb  $0x1,0x3f(%rsp)
  258f18:	je     258f57 <<glass::engine::Engine>::apply+0xd37>
  258f1a:	test   %rbp,%rbp
  258f1d:	je     2593dd <<glass::engine::Engine>::apply+0x11bd>
  258f23:	movzwl 0xf0(%rsp),%eax
  258f2b:	lea    -0x1(%rax),%esi
  258f2e:	test   %eax,%eax
  258f30:	cmove  %eax,%esi
  258f33:	cmp    $0x1,%rbp
  258f37:	jne    2593e3 <<glass::engine::Engine>::apply+0x11c3>
  258f3d:	xor    %eax,%eax
  258f3f:	jmp    2593f3 <<glass::engine::Engine>::apply+0x11d3>
  258f44:	movl   $0x0,0x24(%rsp)
  258f4c:	mov    $0x1,%r13d
  258f52:	jmp    258568 <<glass::engine::Engine>::apply+0x348>
  258f57:	test   %rbp,%rbp
  258f5a:	je     259411 <<glass::engine::Engine>::apply+0x11f1>
  258f60:	mov    0x1b8(%rsp),%rbx
  258f68:	xor    %eax,%eax
  258f6a:	jmp    258f9e <<glass::engine::Engine>::apply+0xd7e>
  258f6c:	mov    $0x17,%cx
  258f70:	mov    $0x1010000,%esi
  258f75:	data16 cs nopw 0x0(%rax,%rax,1)
  258f80:	movzwl %cx,%eax
  258f83:	shl    $0x10,%rsi
  258f87:	or     %rax,%rsi
  258f8a:	mov    %rbx,%rdi
  258f8d:	call   34a390 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  258f92:	mov    %r14,%rax
  258f95:	cmp    %rbp,%r14
  258f98:	jae    259411 <<glass::engine::Engine>::apply+0x11f1>
  258f9e:	movzwl 0xf0(%rsp,%rax,2),%ecx
  258fa6:	lea    0x1(%rax),%r14
  258faa:	cmp    $0x3b,%rcx
  258fae:	ja     259266 <<glass::engine::Engine>::apply+0x1046>
  258fb4:	lea    -0x1ea8b3(%rip),%rsi        # 6e708 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2cd7>
  258fbb:	movslq (%rsi,%rcx,4),%rdx
  258fbf:	add    %rsi,%rdx
  258fc2:	jmp    *%rdx
  258fc4:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  258fc6:	cmp    %rbp,%r14
  258fc9:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  258fcb:	movzwl 0xf2(%rsp,%rax,2),%ecx
  258fd3:	lea    0x2(%rax),%r14
  258fd7:	cmp    $0x5,%ecx
  258fda:	je     2592ca <<glass::engine::Engine>::apply+0x10aa>
  258fe0:	cmp    $0x2,%ecx
  258fe3:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  258fe5:	cmp    %rbp,%r14
  258fe8:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  258fea:	movzwl 0xf4(%rsp,%rax,2),%ecx
  258ff2:	lea    0x3(%rax),%r14
  258ff6:	cmp    $0x100,%ecx
  258ffc:	setb   %dl
  258fff:	cmp    %rbp,%r14
  259002:	setb   %sil
  259006:	and    %dl,%sil
  259009:	cmp    $0x1,%sil
  25900d:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  25900f:	movzwl 0xf6(%rsp,%rax,2),%edx
  259017:	lea    0x4(%rax),%r14
  25901b:	cmp    $0x100,%edx
  259021:	setb   %sil
  259025:	cmp    %rbp,%r14
  259028:	setb   %dil
  25902c:	and    %sil,%dil
  25902f:	cmp    $0x1,%dil
  259033:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  259039:	movzwl 0xf8(%rsp,%rax,2),%edi
  259041:	add    $0x5,%rax
  259045:	cmp    $0xff,%edi
  25904b:	ja     25934d <<glass::engine::Engine>::apply+0x112d>
  259051:	shl    $0x10,%edi
  259054:	movzwl %dx,%edx
  259057:	shl    $0x8,%edx
  25905a:	or     %edx,%ecx
  25905c:	movzwl %cx,%esi
  25905f:	or     %edi,%esi
  259061:	mov    $0x1,%ecx
  259066:	jmp    2592ec <<glass::engine::Engine>::apply+0x10cc>
  25906b:	mov    $0x11,%cx
  25906f:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259074:	mov    $0xc,%cx
  259078:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  25907d:	mov    $0xa,%cx
  259081:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259086:	mov    $0x18,%cx
  25908a:	mov    $0xff,%esi
  25908f:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259094:	mov    $0xe,%cx
  259098:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  25909d:	cmp    %rbp,%r14
  2590a0:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  2590a6:	movzwl 0xf2(%rsp,%rax,2),%ecx
  2590ae:	lea    0x2(%rax),%r14
  2590b2:	cmp    $0x5,%ecx
  2590b5:	je     2592fd <<glass::engine::Engine>::apply+0x10dd>
  2590bb:	cmp    $0x2,%ecx
  2590be:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  2590c4:	cmp    %rbp,%r14
  2590c7:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  2590cd:	movzwl 0xf4(%rsp,%rax,2),%ecx
  2590d5:	lea    0x3(%rax),%r14
  2590d9:	cmp    $0x100,%ecx
  2590df:	setb   %dl
  2590e2:	cmp    %rbp,%r14
  2590e5:	setb   %sil
  2590e9:	and    %dl,%sil
  2590ec:	cmp    $0x1,%sil
  2590f0:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  2590f6:	movzwl 0xf6(%rsp,%rax,2),%edx
  2590fe:	lea    0x4(%rax),%r14
  259102:	cmp    $0x100,%edx
  259108:	setb   %sil
  25910c:	cmp    %rbp,%r14
  25910f:	setb   %dil
  259113:	and    %sil,%dil
  259116:	cmp    $0x1,%dil
  25911a:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  259120:	movzwl 0xf8(%rsp,%rax,2),%edi
  259128:	add    $0x5,%rax
  25912c:	cmp    $0xff,%edi
  259132:	ja     25934d <<glass::engine::Engine>::apply+0x112d>
  259138:	shl    $0x10,%edi
  25913b:	movzwl %dx,%edx
  25913e:	shl    $0x8,%edx
  259141:	or     %edx,%ecx
  259143:	movzwl %cx,%esi
  259146:	or     %edi,%esi
  259148:	mov    $0x1,%ecx
  25914d:	jmp    25931f <<glass::engine::Engine>::apply+0x10ff>
  259152:	mov    $0x10,%cx
  259156:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  25915b:	mov    $0x16,%cx
  25915f:	mov    $0x1000000,%esi
  259164:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259169:	mov    $0xf,%cx
  25916d:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259172:	mov    $0x9,%cx
  259176:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  25917b:	mov    $0x12,%cx
  25917f:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259184:	mov    $0x13,%cx
  259188:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  25918d:	mov    $0xb,%cx
  259191:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259196:	mov    $0xd,%cx
  25919a:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  25919f:	mov    $0x15,%cx
  2591a3:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  2591a8:	mov    $0x14,%cx
  2591ac:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  2591b1:	cmp    %rbp,%r14
  2591b4:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  2591ba:	movzwl 0xf2(%rsp,%rax,2),%ecx
  2591c2:	lea    0x2(%rax),%r14
  2591c6:	cmp    $0x5,%ecx
  2591c9:	je     259330 <<glass::engine::Engine>::apply+0x1110>
  2591cf:	cmp    $0x2,%ecx
  2591d2:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  2591d8:	cmp    %rbp,%r14
  2591db:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  2591e1:	movzwl 0xf4(%rsp,%rax,2),%ecx
  2591e9:	lea    0x3(%rax),%r14
  2591ed:	cmp    $0x100,%ecx
  2591f3:	setb   %dl
  2591f6:	cmp    %rbp,%r14
  2591f9:	setb   %sil
  2591fd:	and    %dl,%sil
  259200:	cmp    $0x1,%sil
  259204:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  25920a:	movzwl 0xf6(%rsp,%rax,2),%edx
  259212:	lea    0x4(%rax),%r14
  259216:	cmp    $0x100,%edx
  25921c:	setb   %sil
  259220:	cmp    %rbp,%r14
  259223:	setb   %dil
  259227:	and    %sil,%dil
  25922a:	cmp    $0x1,%dil
  25922e:	jne    258f92 <<glass::engine::Engine>::apply+0xd72>
  259234:	movzwl 0xf8(%rsp,%rax,2),%edi
  25923c:	add    $0x5,%rax
  259240:	cmp    $0xff,%edi
  259246:	ja     25934d <<glass::engine::Engine>::apply+0x112d>
  25924c:	shl    $0x10,%edi
  25924f:	movzwl %dx,%edx
  259252:	shl    $0x8,%edx
  259255:	or     %edx,%ecx
  259257:	movzwl %cx,%esi
  25925a:	or     %edi,%esi
  25925c:	mov    $0x1,%ecx
  259261:	jmp    25937b <<glass::engine::Engine>::apply+0x115b>
  259266:	lea    -0x1e(%rcx),%eax
  259269:	cmp    $0x8,%ax
  25926d:	jae    259287 <<glass::engine::Engine>::apply+0x1067>
  25926f:	lea    -0x1fdf86(%rip),%rax        # 5b2f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.8409604262742718139+0x960>
  259276:	movzwl -0x3c(%rax,%rcx,2),%esi
  25927b:	shl    $0x10,%esi
  25927e:	mov    $0x16,%cx
  259282:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259287:	mov    %ecx,%eax
  259289:	and    $0xfff8,%eax
  25928e:	cmp    $0x28,%ax
  259292:	jne    2592ac <<glass::engine::Engine>::apply+0x108c>
  259294:	lea    -0x1fdfab(%rip),%rax        # 5b2f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.8409604262742718139+0x960>
  25929b:	movzwl -0x50(%rax,%rcx,2),%esi
  2592a0:	shl    $0x10,%esi
  2592a3:	mov    $0x17,%cx
  2592a7:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  2592ac:	lea    -0x5a(%rcx),%eax
  2592af:	cmp    $0x8,%ax
  2592b3:	jae    259355 <<glass::engine::Engine>::apply+0x1135>
  2592b9:	lea    -0x1fc3c0(%rip),%rax        # 5cf00 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.8409604262742718139+0xd0>
  2592c0:	movzwl -0xb4(%rax,%rcx,2),%esi
  2592c8:	jmp    25927b <<glass::engine::Engine>::apply+0x105b>
  2592ca:	cmp    %rbp,%r14
  2592cd:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  2592d3:	movzwl 0xf4(%rsp,%rax,2),%esi
  2592db:	add    $0x3,%rax
  2592df:	cmp    $0xff,%esi
  2592e5:	ja     25934d <<glass::engine::Engine>::apply+0x112d>
  2592e7:	mov    $0x2,%ecx
  2592ec:	shl    $0x8,%esi
  2592ef:	or     %ecx,%esi
  2592f1:	mov    $0x16,%cx
  2592f5:	mov    %rax,%r14
  2592f8:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  2592fd:	cmp    %rbp,%r14
  259300:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  259306:	movzwl 0xf4(%rsp,%rax,2),%esi
  25930e:	add    $0x3,%rax
  259312:	cmp    $0xff,%esi
  259318:	ja     25934d <<glass::engine::Engine>::apply+0x112d>
  25931a:	mov    $0x2,%ecx
  25931f:	shl    $0x8,%esi
  259322:	or     %ecx,%esi
  259324:	mov    $0x18,%cx
  259328:	mov    %rax,%r14
  25932b:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  259330:	cmp    %rbp,%r14
  259333:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  259339:	movzwl 0xf4(%rsp,%rax,2),%esi
  259341:	add    $0x3,%rax
  259345:	cmp    $0xff,%esi
  25934b:	jbe    259376 <<glass::engine::Engine>::apply+0x1156>
  25934d:	mov    %rax,%r14
  259350:	jmp    258f92 <<glass::engine::Engine>::apply+0xd72>
  259355:	lea    -0x64(%rcx),%eax
  259358:	cmp    $0x8,%ax
  25935c:	jae    258f92 <<glass::engine::Engine>::apply+0xd72>
  259362:	lea    -0x1fc469(%rip),%rax        # 5cf00 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.8409604262742718139+0xd0>
  259369:	movzwl -0xc8(%rax,%rcx,2),%esi
  259371:	jmp    2592a0 <<glass::engine::Engine>::apply+0x1080>
  259376:	mov    $0x2,%ecx
  25937b:	shl    $0x8,%esi
  25937e:	or     %ecx,%esi
  259380:	mov    $0x17,%cx
  259384:	mov    %rax,%r14
  259387:	jmp    258f80 <<glass::engine::Engine>::apply+0xd60>
  25938c:	xor    %eax,%eax
  25938e:	test   $0x1,%al
  259390:	mov    $0x1,%eax
  259395:	cmove  %eax,%r14d
  259399:	mov    0x1f0(%rsp),%ebp
  2593a0:	cmp    $0xffffffff,%ebp
  2593a3:	je     2593c7 <<glass::engine::Engine>::apply+0x11a7>
  2593a5:	test   %r14w,%r14w
  2593a9:	je     259411 <<glass::engine::Engine>::apply+0x11f1>
  2593ab:	nopl   0x0(%rax,%rax,1)
  2593b0:	lea    0x140(%rsp),%rdi
  2593b8:	mov    %ebp,%esi
  2593ba:	call   33c8d0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  2593bf:	dec    %r14w
  2593c3:	jne    2593b0 <<glass::engine::Engine>::apply+0x1190>
  2593c5:	jmp    259411 <<glass::engine::Engine>::apply+0x11f1>
  2593c7:	mov    $0x1,%r14b
  2593ca:	mov    $0x1,%al
  2593cc:	mov    %eax,0x24(%rsp)
  2593d0:	mov    %rbx,0xe8(%rsp)
  2593d8:	jmp    258568 <<glass::engine::Engine>::apply+0x348>
  2593dd:	xor    %esi,%esi
  2593df:	xor    %eax,%eax
  2593e1:	jmp    2593f3 <<glass::engine::Engine>::apply+0x11d3>
  2593e3:	movzwl 0xf2(%rsp),%ecx
  2593eb:	xor    %eax,%eax
  2593ed:	test   %cx,%cx
  2593f0:	setne  %al
  2593f3:	movzwl %cx,%edx
  2593f6:	dec    %rdx
  2593f9:	test   $0x1,%al
  2593fb:	mov    $0x0,%eax
  259400:	cmove  %rax,%rdx
  259404:	mov    0x1b8(%rsp),%rdi
  25940c:	call   34b7d0 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  259411:	mov    0x28(%rsp),%r15
  259416:	lea    (%r15,%r13,1),%rbx
  25941a:	mov    $0x1,%r14b
  25941d:	mov    $0x1,%al
  25941f:	mov    %eax,0x24(%rsp)
  259423:	mov    %rbx,0xe8(%rsp)
  25942b:	jmp    25856d <<glass::engine::Engine>::apply+0x34d>
  259430:	call   18b906 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259435:	jmp    258ca9 <<glass::engine::Engine>::apply+0xa89>
  25943a:	call   18b906 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25943f:	jmp    258cf9 <<glass::engine::Engine>::apply+0xad9>
  259444:	mov    %rcx,0x138(%rsp)
  25944c:	movzbl (%rbx),%eax
  25944f:	mov    %rax,0x130(%rsp)
  259457:	add    $0xffffffe0,%eax
  25945a:	mov    $0x1,%ecx
  25945f:	mov    %rcx,0x58(%rsp)
  259464:	cmp    $0x5f,%al
  259466:	jb     259494 <<glass::engine::Engine>::apply+0x1274>
  259468:	mov    0x130(%rsp),%rdi
  259470:	call   2a1550 <glass::engine::width_of>
  259475:	mov    %rdx,0x58(%rsp)
  25947a:	mov    0x58(%rsp),%rcx
  25947f:	dec    %rcx
  259482:	cmp    $0x2,%rcx
  259486:	setb   %cl
  259489:	and    %al,%cl
  25948b:	cmp    $0x1,%cl
  25948e:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  259494:	mov    0x138(%rsp),%rax
  25949c:	cmpb   $0x0,0x6c(%rax)
  2594a0:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  2594a6:	mov    0x40(%rax),%rsi
  2594aa:	mov    0xa0(%rax),%rdx
  2594b1:	mov    %rsi,0x10(%rsp)
  2594b6:	mov    0x58(%rsp),%rcx
  2594bb:	add    %rsi,%rcx
  2594be:	mov    %rcx,0x128(%rsp)
  2594c6:	mov    %rdx,0x238(%rsp)
  2594ce:	cmp    %rdx,%rcx
  2594d1:	ja     258d67 <<glass::engine::Engine>::apply+0xb47>
  2594d7:	lea    0x10(%rax),%rdi
  2594db:	mov    0x48(%rax),%esi
  2594de:	mov    0x58(%rax),%ecx
  2594e1:	mov    %ecx,0xd0(%rsp)
  2594e8:	mov    0x5c(%rax),%ecx
  2594eb:	mov    %ecx,0xcc(%rsp)
  2594f2:	movzwl 0x64(%rax),%eax
  2594f6:	mov    %eax,0xd4(%rsp)
  2594fd:	lea    0x36ee04(%rip),%rdx        # 5c8308 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15588>
  259504:	call   30aee0 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  259509:	mov    %rbp,0xc0(%rsp)
  259511:	mov    %r13,0x48(%rsp)
  259516:	mov    %rax,%rcx
  259519:	add    $0x18,%rcx
  25951d:	mov    %rcx,0xe0(%rsp)
  259525:	mov    %rax,(%rsp)
  259529:	mov    0x28(%rax),%eax
  25952c:	cmp    $0xffffffff,%eax
  25952f:	je     259548 <<glass::engine::Engine>::apply+0x1328>
  259531:	mov    0xe0(%rsp),%rcx
  259539:	mov    0x10(%rsp),%rdx
  25953e:	mov    (%rsp),%rsi
  259542:	cmp    0x30(%rsi),%rdx
  259546:	jae    259570 <<glass::engine::Engine>::apply+0x1350>
  259548:	mov    (%rsp),%rcx
  25954c:	mov    0x10(%rcx),%rsi
  259550:	cmp    %rsi,0x10(%rsp)
  259555:	jae    25a163 <<glass::engine::Engine>::apply+0x1f43>
  25955b:	mov    0x10(%rsp),%rcx
  259560:	lea    (%rcx,%rcx,2),%rcx
  259564:	shl    $0x3,%rcx
  259568:	mov    (%rsp),%rdx
  25956c:	add    0x8(%rdx),%rcx
  259570:	testb  $0x60,0x14(%rcx)
  259574:	mov    0x48(%rsp),%r13
  259579:	mov    0xc0(%rsp),%rbp
  259581:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  259587:	cmpq   $0x2,0x58(%rsp)
  25958d:	jne    2595e6 <<glass::engine::Engine>::apply+0x13c6>
  25958f:	mov    0x10(%rsp),%rcx
  259594:	inc    %rcx
  259597:	cmp    $0xffffffff,%eax
  25959a:	je     2595ae <<glass::engine::Engine>::apply+0x138e>
  25959c:	mov    0xe0(%rsp),%rdx
  2595a4:	mov    (%rsp),%rsi
  2595a8:	cmp    0x30(%rsi),%rcx
  2595ac:	jae    2595cf <<glass::engine::Engine>::apply+0x13af>
  2595ae:	mov    (%rsp),%rdx
  2595b2:	mov    0x10(%rdx),%rsi
  2595b6:	cmp    %rsi,%rcx
  2595b9:	jae    25a10e <<glass::engine::Engine>::apply+0x1eee>
  2595bf:	lea    (%rcx,%rcx,2),%rdx
  2595c3:	shl    $0x3,%rdx
  2595c7:	mov    (%rsp),%rcx
  2595cb:	add    0x8(%rcx),%rdx
  2595cf:	testb  $0x60,0x14(%rdx)
  2595d3:	mov    0x48(%rsp),%r13
  2595d8:	mov    0xc0(%rsp),%rbp
  2595e0:	jne    258d67 <<glass::engine::Engine>::apply+0xb47>
  2595e6:	mov    0x10(%rsp),%rcx
  2595eb:	mov    (%rsp),%rdx
  2595ef:	cmp    %ecx,0x38(%rdx)
  2595f2:	jbe    259600 <<glass::engine::Engine>::apply+0x13e0>
  2595f4:	mov    0x10(%rsp),%rcx
  2595f9:	mov    (%rsp),%rdx
  2595fd:	mov    %ecx,0x38(%rdx)
  259600:	cmp    $0xffffffff,%eax
  259603:	setne  %cl
  259606:	mov    (%rsp),%rdx
  25960a:	mov    0x30(%rdx),%rbx
  25960e:	cmp    %rbx,0x10(%rsp)
  259613:	sete   %dl
  259616:	test   %dl,%cl
  259618:	jne    2596f4 <<glass::engine::Engine>::apply+0x14d4>
  25961e:	cmp    $0xffffffff,%eax
  259621:	je     25980c <<glass::engine::Engine>::apply+0x15ec>
  259627:	mov    (%rsp),%rax
  25962b:	mov    0x10(%rax),%r12
  25962f:	cmp    %rbx,%r12
  259632:	mov    %rbx,%rbp
  259635:	cmovb  %r12,%rbp
  259639:	mov    0x10(%rsp),%r15
  25963e:	cmp    %r15,%r12
  259641:	cmovb  %r12,%r15
  259645:	mov    0x397974(%rip),%rax        # 5f0fc0 <_DYNAMIC+0x320>
  25964c:	movzbl (%rax),%eax
  25964f:	test   %al,%al
  259651:	je     259676 <<glass::engine::Engine>::apply+0x1456>
  259653:	mov    0x39799e(%rip),%rax        # 5f0ff8 <_DYNAMIC+0x358>
  25965a:	cmp    %r15,%rbx
  25965d:	jae    259666 <<glass::engine::Engine>::apply+0x1446>
  25965f:	mov    0x39799a(%rip),%rax        # 5f1000 <_DYNAMIC+0x360>
  259666:	lock incq 0x28(%rax)
  25966b:	mov    %r15,%rdi
  25966e:	sub    %rbp,%rdi
  259671:	call   2f6480 <alacritty_terminal::grid::row::fill_census::note>
  259676:	cmp    %r15,%rbx
  259679:	jae    2597ef <<glass::engine::Engine>::apply+0x15cf>
  25967f:	mov    (%rsp),%rax
  259683:	mov    0x28(%rax),%ecx
  259686:	mov    %ecx,0x38(%rsp)
  25968a:	mov    0x20(%rax),%ecx
  25968d:	mov    %ecx,0x34(%rsp)
  259691:	mov    0x24(%rax),%ecx
  259694:	mov    %ecx,0x30(%rsp)
  259698:	movzwl 0x2c(%rax),%ecx
  25969c:	mov    %cx,0x68(%rsp)
  2596a1:	mov    0x18(%rax),%r12
  2596a5:	test   %r12,%r12
  2596a8:	je     259717 <<glass::engine::Engine>::apply+0x14f7>
  2596aa:	lock incq (%r12)
  2596af:	jle    25a176 <<glass::engine::Engine>::apply+0x1f56>
  2596b5:	mov    (%rsp),%rax
  2596b9:	mov    0x10(%rax),%rdx
  2596bd:	mov    0x38(%rsp),%eax
  2596c1:	mov    %eax,0x80(%rsp)
  2596c8:	mov    0x34(%rsp),%eax
  2596cc:	mov    %eax,0x78(%rsp)
  2596d0:	mov    0x30(%rsp),%eax
  2596d4:	mov    %eax,0x7c(%rsp)
  2596d8:	movzwl 0x68(%rsp),%eax
  2596dd:	mov    %ax,0x84(%rsp)
  2596e5:	mov    %r12,0x70(%rsp)
  2596ea:	cmp    %rdx,%r15
  2596ed:	jbe    259744 <<glass::engine::Engine>::apply+0x1524>
  2596ef:	jmp    25a115 <<glass::engine::Engine>::apply+0x1ef5>
  2596f4:	mov    0x10(%rsp),%rcx
  2596f9:	lea    0x1(%rcx),%rax
  2596fd:	mov    (%rsp),%rdx
  259701:	mov    %rax,0x30(%rdx)
  259705:	mov    0x10(%rdx),%rsi
  259709:	cmp    %rsi,%rcx
  25970c:	jb     259835 <<glass::engine::Engine>::apply+0x1615>
  259712:	jmp    25a12f <<glass::engine::Engine>::apply+0x1f0f>
  259717:	mov    0x38(%rsp),%eax
  25971b:	mov    %eax,0x80(%rsp)
  259722:	mov    0x34(%rsp),%eax
  259726:	mov    %eax,0x78(%rsp)
  25972a:	mov    0x30(%rsp),%eax
  25972e:	mov    %eax,0x7c(%rsp)
  259732:	movzwl 0x68(%rsp),%eax
  259737:	mov    %ax,0x84(%rsp)
  25973f:	mov    %r12,0x70(%rsp)
  259744:	lea    0x0(,%rbp,8),%rax
  25974c:	lea    (%rax,%rax,2),%rax
  259750:	mov    (%rsp),%rcx
  259754:	mov    0x8(%rcx),%rbx
  259758:	add    %rax,%rbx
  25975b:	lea    0x0(,%r15,8),%rcx
  259763:	lea    (%rcx,%rcx,2),%r13
  259767:	sub    %rax,%r13
  25976a:	jmp    259797 <<glass::engine::Engine>::apply+0x1577>
  25976c:	mov    %r12,(%rbx)
  25976f:	mov    0x34(%rsp),%eax
  259773:	mov    %eax,0x8(%rbx)
  259776:	mov    0x30(%rsp),%eax
  25977a:	mov    %eax,0xc(%rbx)
  25977d:	mov    0x38(%rsp),%eax
  259781:	mov    %eax,0x10(%rbx)
  259784:	movzwl 0x68(%rsp),%eax
  259789:	mov    %ax,0x14(%rbx)
  25978d:	add    $0x18,%rbx
  259791:	add    $0xffffffffffffffe8,%r13
  259795:	je     2597c0 <<glass::engine::Engine>::apply+0x15a0>
  259797:	test   %r12,%r12
  25979a:	je     2597a7 <<glass::engine::Engine>::apply+0x1587>
  25979c:	lock incq (%r12)
  2597a1:	jle    25a176 <<glass::engine::Engine>::apply+0x1f56>
  2597a7:	mov    (%rbx),%rax
  2597aa:	test   %rax,%rax
  2597ad:	je     25976c <<glass::engine::Engine>::apply+0x154c>
  2597af:	lock decq (%rax)
  2597b3:	jne    25976c <<glass::engine::Engine>::apply+0x154c>
  2597b5:	mov    %rbx,%rdi
  2597b8:	call   *0x39774a(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  2597be:	jmp    25976c <<glass::engine::Engine>::apply+0x154c>
  2597c0:	mov    (%rsp),%rax
  2597c4:	cmp    %ebp,0x38(%rax)
  2597c7:	jbe    2597d0 <<glass::engine::Engine>::apply+0x15b0>
  2597c9:	mov    (%rsp),%rax
  2597cd:	mov    %ebp,0x38(%rax)
  2597d0:	test   %r12,%r12
  2597d3:	je     2597e7 <<glass::engine::Engine>::apply+0x15c7>
  2597d5:	lock decq (%r12)
  2597da:	jne    2597e7 <<glass::engine::Engine>::apply+0x15c7>
  2597dc:	lea    0x70(%rsp),%rdi
  2597e1:	call   *0x397721(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  2597e7:	mov    (%rsp),%rax
  2597eb:	mov    0x10(%rax),%r12
  2597ef:	cmp    %r12,%r15
  2597f2:	jb     25980c <<glass::engine::Engine>::apply+0x15ec>
  2597f4:	mov    0xe0(%rsp),%rdi
  2597fc:	call   1ad360 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259801:	mov    (%rsp),%rax
  259805:	movl   $0xffffffff,0x28(%rax)
  25980c:	mov    (%rsp),%rdi
  259810:	mov    0x30(%rdi),%rax
  259814:	mov    0x10(%rsp),%rdx
  259819:	lea    0x1(%rdx),%rcx
  25981d:	cmp    %rax,%rcx
  259820:	cmova  %rcx,%rax
  259824:	mov    0x10(%rdi),%rsi
  259828:	mov    %rax,0x30(%rdi)
  25982c:	cmp    %rsi,%rdx
  25982f:	jae    25a154 <<glass::engine::Engine>::apply+0x1f34>
  259835:	mov    0xd4(%rsp),%edi
  25983c:	mov    %edi,%eax
  25983e:	or     $0x20,%eax
  259841:	cmpq   $0x2,0x58(%rsp)
  259847:	mov    (%rsp),%rcx
  25984b:	mov    0x8(%rcx),%rcx
  25984f:	mov    0x10(%rsp),%rdx
  259854:	lea    (%rdx,%rdx,2),%rdx
  259858:	lea    (%rcx,%rdx,8),%rbx
  25985c:	mov    0x130(%rsp),%rsi
  259864:	mov    %esi,0x10(%rcx,%rdx,8)
  259868:	mov    0xd0(%rsp),%esi
  25986f:	mov    %esi,0x8(%rcx,%rdx,8)
  259873:	cmovne %edi,%eax
  259876:	mov    0xcc(%rsp),%esi
  25987d:	mov    %esi,0xc(%rcx,%rdx,8)
  259881:	mov    %ax,0x14(%rcx,%rdx,8)
  259886:	mov    (%rcx,%rdx,8),%rax
  25988a:	test   %rax,%rax
  25988d:	je     25989e <<glass::engine::Engine>::apply+0x167e>
  25988f:	lock decq (%rax)
  259893:	jne    25989e <<glass::engine::Engine>::apply+0x167e>
  259895:	mov    %rbx,%rdi
  259898:	call   *0x39766a(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  25989e:	movq   $0x0,(%rbx)
  2598a5:	cmpq   $0x2,0x58(%rsp)
  2598ab:	jne    259b56 <<glass::engine::Engine>::apply+0x1936>
  2598b1:	mov    0x10(%rsp),%rax
  2598b6:	lea    0x1(%rax),%r15
  2598ba:	mov    (%rsp),%rax
  2598be:	mov    0x30(%rax),%rbx
  2598c2:	mov    0x28(%rax),%eax
  2598c5:	cmp    %rbx,%r15
  2598c8:	jne    2598f2 <<glass::engine::Engine>::apply+0x16d2>
  2598ca:	cmp    $0xffffffff,%eax
  2598cd:	je     2598f2 <<glass::engine::Engine>::apply+0x16d2>
  2598cf:	mov    0x10(%rsp),%rax
  2598d4:	add    $0x2,%rax
  2598d8:	mov    (%rsp),%rcx
  2598dc:	mov    %rax,0x30(%rcx)
  2598e0:	mov    0x10(%rcx),%rsi
  2598e4:	cmp    %rsi,%r15
  2598e7:	jb     259afa <<glass::engine::Engine>::apply+0x18da>
  2598ed:	jmp    25a12a <<glass::engine::Engine>::apply+0x1f0a>
  2598f2:	cmp    $0xffffffff,%eax
  2598f5:	je     259ad1 <<glass::engine::Engine>::apply+0x18b1>
  2598fb:	mov    (%rsp),%rax
  2598ff:	mov    0x10(%rax),%r12
  259903:	cmp    %rbx,%r12
  259906:	mov    %rbx,%rax
  259909:	cmovb  %r12,%rax
  25990d:	mov    %rax,0x68(%rsp)
  259912:	cmp    %r15,%r12
  259915:	mov    %r15,%rbp
  259918:	cmovb  %r12,%rbp
  25991c:	mov    0x39769d(%rip),%rax        # 5f0fc0 <_DYNAMIC+0x320>
  259923:	movzbl (%rax),%eax
  259926:	test   %al,%al
  259928:	je     25994f <<glass::engine::Engine>::apply+0x172f>
  25992a:	mov    0x3976c7(%rip),%rax        # 5f0ff8 <_DYNAMIC+0x358>
  259931:	cmp    %rbp,%rbx
  259934:	jae    25993d <<glass::engine::Engine>::apply+0x171d>
  259936:	mov    0x3976c3(%rip),%rax        # 5f1000 <_DYNAMIC+0x360>
  25993d:	lock incq 0x28(%rax)
  259942:	mov    %rbp,%rdi
  259945:	sub    0x68(%rsp),%rdi
  25994a:	call   2f6480 <alacritty_terminal::grid::row::fill_census::note>
  25994f:	cmp    %rbp,%rbx
  259952:	jae    259ab4 <<glass::engine::Engine>::apply+0x1894>
  259958:	mov    (%rsp),%rax
  25995c:	mov    0x28(%rax),%ecx
  25995f:	mov    %ecx,0x58(%rsp)
  259963:	mov    0x20(%rax),%ecx
  259966:	mov    %ecx,0x38(%rsp)
  25996a:	mov    0x24(%rax),%ecx
  25996d:	mov    %ecx,0x34(%rsp)
  259971:	movzwl 0x2c(%rax),%ecx
  259975:	mov    %cx,0x30(%rsp)
  25997a:	mov    0x18(%rax),%r13
  25997e:	test   %r13,%r13
  259981:	je     2599cd <<glass::engine::Engine>::apply+0x17ad>
  259983:	lock incq 0x0(%r13)
  259988:	jle    25a176 <<glass::engine::Engine>::apply+0x1f56>
  25998e:	mov    (%rsp),%rax
  259992:	mov    0x10(%rax),%rdx
  259996:	mov    0x58(%rsp),%eax
  25999a:	mov    %eax,0x80(%rsp)
  2599a1:	mov    0x38(%rsp),%eax
  2599a5:	mov    %eax,0x78(%rsp)
  2599a9:	mov    0x34(%rsp),%eax
  2599ad:	mov    %eax,0x7c(%rsp)
  2599b1:	movzwl 0x30(%rsp),%eax
  2599b6:	mov    %ax,0x84(%rsp)
  2599be:	mov    %r13,0x70(%rsp)
  2599c3:	cmp    %rdx,%rbp
  2599c6:	jbe    2599fa <<glass::engine::Engine>::apply+0x17da>
  2599c8:	jmp    25a138 <<glass::engine::Engine>::apply+0x1f18>
  2599cd:	mov    0x58(%rsp),%eax
  2599d1:	mov    %eax,0x80(%rsp)
  2599d8:	mov    0x38(%rsp),%eax
  2599dc:	mov    %eax,0x78(%rsp)
  2599e0:	mov    0x34(%rsp),%eax
  2599e4:	mov    %eax,0x7c(%rsp)
  2599e8:	movzwl 0x30(%rsp),%eax
  2599ed:	mov    %ax,0x84(%rsp)
  2599f5:	mov    %r13,0x70(%rsp)
  2599fa:	mov    0x68(%rsp),%rax
  2599ff:	lea    0x0(,%rax,8),%rax
  259a07:	lea    (%rax,%rax,2),%rax
  259a0b:	mov    (%rsp),%rcx
  259a0f:	mov    0x8(%rcx),%rbx
  259a13:	add    %rax,%rbx
  259a16:	lea    0x0(,%rbp,8),%rcx
  259a1e:	lea    (%rcx,%rcx,2),%r12
  259a22:	sub    %rax,%r12
  259a25:	jmp    259a52 <<glass::engine::Engine>::apply+0x1832>
  259a27:	mov    %r13,(%rbx)
  259a2a:	mov    0x38(%rsp),%eax
  259a2e:	mov    %eax,0x8(%rbx)
  259a31:	mov    0x34(%rsp),%eax
  259a35:	mov    %eax,0xc(%rbx)
  259a38:	mov    0x58(%rsp),%eax
  259a3c:	mov    %eax,0x10(%rbx)
  259a3f:	movzwl 0x30(%rsp),%eax
  259a44:	mov    %ax,0x14(%rbx)
  259a48:	add    $0x18,%rbx
  259a4c:	add    $0xffffffffffffffe8,%r12
  259a50:	je     259a7b <<glass::engine::Engine>::apply+0x185b>
  259a52:	test   %r13,%r13
  259a55:	je     259a62 <<glass::engine::Engine>::apply+0x1842>
  259a57:	lock incq 0x0(%r13)
  259a5c:	jle    25a176 <<glass::engine::Engine>::apply+0x1f56>
  259a62:	mov    (%rbx),%rax
  259a65:	test   %rax,%rax
  259a68:	je     259a27 <<glass::engine::Engine>::apply+0x1807>
  259a6a:	lock decq (%rax)
  259a6e:	jne    259a27 <<glass::engine::Engine>::apply+0x1807>
  259a70:	mov    %rbx,%rdi
  259a73:	call   *0x39748f(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  259a79:	jmp    259a27 <<glass::engine::Engine>::apply+0x1807>
  259a7b:	mov    (%rsp),%rax
  259a7f:	mov    0x68(%rsp),%rcx
  259a84:	cmp    %ecx,0x38(%rax)
  259a87:	jbe    259a95 <<glass::engine::Engine>::apply+0x1875>
  259a89:	mov    (%rsp),%rax
  259a8d:	mov    0x68(%rsp),%rcx
  259a92:	mov    %ecx,0x38(%rax)
  259a95:	test   %r13,%r13
  259a98:	je     259aac <<glass::engine::Engine>::apply+0x188c>
  259a9a:	lock decq 0x0(%r13)
  259a9f:	jne    259aac <<glass::engine::Engine>::apply+0x188c>
  259aa1:	lea    0x70(%rsp),%rdi
  259aa6:	call   *0x39745c(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  259aac:	mov    (%rsp),%rax
  259ab0:	mov    0x10(%rax),%r12
  259ab4:	cmp    %r12,%rbp
  259ab7:	jb     259ad1 <<glass::engine::Engine>::apply+0x18b1>
  259ab9:	mov    0xe0(%rsp),%rdi
  259ac1:	call   1ad360 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259ac6:	mov    (%rsp),%rax
  259aca:	movl   $0xffffffff,0x28(%rax)
  259ad1:	mov    (%rsp),%rdx
  259ad5:	mov    0x30(%rdx),%rax
  259ad9:	mov    0x10(%rsp),%rcx
  259ade:	add    $0x2,%rcx
  259ae2:	cmp    %rax,%rcx
  259ae5:	cmovbe %rax,%rcx
  259ae9:	mov    0x10(%rdx),%rsi
  259aed:	mov    %rcx,0x30(%rdx)
  259af1:	cmp    %rsi,%r15
  259af4:	jae    25a14f <<glass::engine::Engine>::apply+0x1f2f>
  259afa:	mov    (%rsp),%rax
  259afe:	mov    0x8(%rax),%rax
  259b02:	lea    (%r15,%r15,2),%rcx
  259b06:	lea    (%rax,%rcx,8),%rbx
  259b0a:	movl   $0x20,0x10(%rax,%rcx,8)
  259b12:	mov    0xd0(%rsp),%edx
  259b19:	mov    %edx,0x8(%rax,%rcx,8)
  259b1d:	mov    0xcc(%rsp),%edx
  259b24:	mov    %edx,0xc(%rax,%rcx,8)
  259b28:	mov    0xd4(%rsp),%edx
  259b2f:	or     $0x40,%edx
  259b32:	mov    %dx,0x14(%rax,%rcx,8)
  259b37:	mov    (%rax,%rcx,8),%rax
  259b3b:	test   %rax,%rax
  259b3e:	je     259b4f <<glass::engine::Engine>::apply+0x192f>
  259b40:	lock decq (%rax)
  259b44:	jne    259b4f <<glass::engine::Engine>::apply+0x192f>
  259b46:	mov    %rbx,%rdi
  259b49:	call   *0x3973b9(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  259b4f:	movq   $0x0,(%rbx)
  259b56:	mov    0x238(%rsp),%rax
  259b5e:	cmp    %rax,0x128(%rsp)
  259b66:	jb     259b7c <<glass::engine::Engine>::apply+0x195c>
  259b68:	decq   0x128(%rsp)
  259b70:	mov    0x138(%rsp),%rax
  259b78:	movb   $0x1,0x6c(%rax)
  259b7c:	mov    0x138(%rsp),%rax
  259b84:	mov    0x128(%rsp),%rcx
  259b8c:	mov    %rcx,0x40(%rax)
  259b90:	incq   0x1e0(%rsp)
  259b98:	mov    0x130(%rsp),%rax
  259ba0:	mov    %eax,0x1f0(%rsp)
  259ba7:	mov    $0x1,%ebx
  259bac:	mov    0x48(%rsp),%r13
  259bb1:	mov    0xc0(%rsp),%rbp
  259bb9:	mov    0x39a2c1(%rip),%eax        # 5f3e80 <glass::engine::run_whole::ON>
  259bbf:	test   %eax,%eax
  259bc1:	je     258d8b <<glass::engine::Engine>::apply+0xb6b>
  259bc7:	call   18b906 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259bcc:	jmp    258d8b <<glass::engine::Engine>::apply+0xb6b>
  259bd1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  259be0:	xor    %ebx,%ebx
  259be2:	mov    %r10,%r14
  259be5:	data16 cs nopw 0x0(%rax,%rax,1)
  259bf0:	mov    0x8(%rsp),%rax
  259bf5:	cmpl   $0xffffffff,0x710(%rax)
  259bfc:	jne    259c4d <<glass::engine::Engine>::apply+0x1a2d>
  259bfe:	mov    0x50(%rsp),%rax
  259c03:	mov    %rax,0x70(%rsp)
  259c08:	lea    0x140(%rsp),%rax
  259c10:	mov    %rax,0x78(%rsp)
  259c15:	movb   $0x0,0x80(%rsp)
  259c1d:	mov    0x18(%rsp),%rcx
  259c22:	sub    %rbx,%rcx
  259c25:	jb     25a056 <<glass::engine::Engine>::apply+0x1e36>
  259c2b:	lea    (%r14,%rbx,1),%rdx
  259c2f:	mov    0xb0(%rsp),%rdi
  259c37:	lea    0x70(%rsp),%rsi
  259c3c:	call   1a0570 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  259c41:	add    %rax,%rbx
  259c44:	cmp    0x18(%rsp),%rbx
  259c49:	jne    259bf0 <<glass::engine::Engine>::apply+0x19d0>
  259c4b:	jmp    259ca0 <<glass::engine::Engine>::apply+0x1a80>
  259c4d:	mov    0x18(%rsp),%rcx
  259c52:	sub    %rbx,%rcx
  259c55:	jb     25a0f1 <<glass::engine::Engine>::apply+0x1ed1>
  259c5b:	lea    (%r14,%rbx,1),%rdx
  259c5f:	mov    0x50(%rsp),%rdi
  259c64:	lea    0x140(%rsp),%rsi
  259c6c:	call   1942d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  259c71:	jmp    259c41 <<glass::engine::Engine>::apply+0x1a21>
  259c73:	mov    0x18(%rsp),%r13
  259c78:	sub    %rbx,%r13
  259c7b:	jbe    259ca0 <<glass::engine::Engine>::apply+0x1a80>
  259c7d:	movzbl 0x39d554(%rip),%eax        # 5f71d8 <glass::engine::counters::COUNTING>
  259c84:	test   %al,%al
  259c86:	je     259c90 <<glass::engine::Engine>::apply+0x1a70>
  259c88:	lock add %r13,0x39d550(%rip)        # 5f71e0 <glass::engine::counters::VTE_BYTES>
  259c90:	movzbl 0x39d4e1(%rip),%eax        # 5f7178 <glass::engine::probes::RUN_PROBE>
  259c97:	cmp    $0x68,%al
  259c99:	jne    259ef4 <<glass::engine::Engine>::apply+0x1cd4>
  259c9f:	nop
  259ca0:	mov    0x1f0(%rsp),%rax
  259ca8:	mov    0x8(%rsp),%rdx
  259cad:	mov    %rax,0xa70(%rdx)
  259cb4:	mov    0x1f8(%rsp),%eax
  259cbb:	mov    %eax,0xa78(%rdx)
  259cc1:	pshufd $0x4e,0x1d0(%rsp),%xmm0
  259ccb:	movdqu %xmm0,0xa60(%rdx)
  259cd3:	movzbl 0x1fd(%rsp),%eax
  259cdb:	mov    %al,0xa7d(%rdx)
  259ce1:	movzbl 0x1fc(%rsp),%eax
  259ce9:	and    $0x1,%eax
  259cec:	shl    $0x5,%eax
  259cef:	mov    0x1c8(%rsp,%rax,1),%rax
  259cf7:	mov    0xa58(%rdx),%rcx
  259cfe:	cmp    %rcx,%rax
  259d01:	cmova  %rax,%rcx
  259d05:	mov    %rcx,0xa58(%rdx)
  259d0c:	mov    0x150(%rsp),%r12
  259d14:	mov    0x158(%rsp),%rbx
  259d1c:	mov    0x160(%rsp),%r13
  259d24:	movq   $0x0,0x150(%rsp)
  259d30:	movq   $0x8,0x158(%rsp)
  259d3c:	movq   $0x0,0x160(%rsp)
  259d48:	test   %r13,%r13
  259d4b:	je     259dac <<glass::engine::Engine>::apply+0x1b8c>
  259d4d:	mov    0x8(%rsp),%rcx
  259d52:	mov    0x8e8(%rcx),%rax
  259d59:	mov    0x8f8(%rcx),%r14
  259d60:	sub    %r14,%rax
  259d63:	cmp    %rax,%r13
  259d66:	ja     259fb0 <<glass::engine::Engine>::apply+0x1d90>
  259d6c:	mov    %r13,%rax
  259d6f:	shl    $0x4,%rax
  259d73:	lea    (%rax,%rax,2),%rdx
  259d77:	lea    (%r14,%r14,2),%rdi
  259d7b:	shl    $0x4,%rdi
  259d7f:	mov    0x8(%rsp),%r15
  259d84:	add    0x8f0(%r15),%rdi
  259d8b:	mov    %rbx,%rsi
  259d8e:	call   *0x39713c(%rip)        # 5f0ed0 <memcpy@GLIBC_2.14>
  259d94:	add    %r13,%r14
  259d97:	mov    %r14,0x8f8(%r15)
  259d9e:	test   %r12,%r12
  259da1:	je     259dac <<glass::engine::Engine>::apply+0x1b8c>
  259da3:	mov    %rbx,%rdi
  259da6:	call   *0x39713c(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  259dac:	mov    0x180(%rsp),%r14
  259db4:	lea    0x188(%rsp),%rax
  259dbc:	movups (%rax),%xmm0
  259dbf:	movups 0x10(%rax),%xmm1
  259dc3:	movups 0x20(%rax),%xmm2
  259dc7:	movaps %xmm0,0x70(%rsp)
  259dcc:	movaps %xmm1,0x80(%rsp)
  259dd4:	movaps %xmm2,0x90(%rsp)
  259ddc:	movq   $0xffffffffffffffff,0x180(%rsp)
  259de8:	cmp    $0xffffffffffffffff,%r14
  259dec:	mov    %rbx,0x48(%rsp)
  259df1:	je     259e30 <<glass::engine::Engine>::apply+0x1c10>
  259df3:	mov    0x8(%rsp),%rax
  259df8:	cmpq   $0x0,0x998(%rax)
  259e00:	jle    259e37 <<glass::engine::Engine>::apply+0x1c17>
  259e02:	mov    0x200(%rsp),%r15
  259e0a:	mov    (%r15),%rdi
  259e0d:	call   *0x3970d5(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  259e13:	cmpq   $0x0,0x180(%rsp)
  259e1c:	setg   %bpl
  259e20:	jmp    259e41 <<glass::engine::Engine>::apply+0x1c21>
  259e22:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  259e30:	mov    %r12,%rbx
  259e33:	xor    %ebp,%ebp
  259e35:	jmp    259e73 <<glass::engine::Engine>::apply+0x1c53>
  259e37:	xor    %ebp,%ebp
  259e39:	mov    0x200(%rsp),%r15
  259e41:	mov    %r12,%rbx
  259e44:	mov    0x8(%rsp),%rax
  259e49:	mov    %r14,0x998(%rax)
  259e50:	movaps 0x70(%rsp),%xmm0
  259e55:	movaps 0x80(%rsp),%xmm1
  259e5d:	movaps 0x90(%rsp),%xmm2
  259e65:	movups %xmm2,0x20(%r15)
  259e6a:	movups %xmm1,0x10(%r15)
  259e6f:	movups %xmm0,(%r15)
  259e73:	mov    0x168(%rsp),%r12
  259e7b:	mov    0x170(%rsp),%r15
  259e83:	mov    0x188(%rsp),%r14
  259e8b:	cmpq   $0x0,0x150(%rsp)
  259e94:	je     259ea4 <<glass::engine::Engine>::apply+0x1c84>
  259e96:	mov    0x158(%rsp),%rdi
  259e9e:	call   *0x397044(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  259ea4:	test   %r12,%r12
  259ea7:	je     259eb2 <<glass::engine::Engine>::apply+0x1c92>
  259ea9:	mov    %r15,%rdi
  259eac:	call   *0x397036(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  259eb2:	test   %bpl,%bpl
  259eb5:	je     259ec0 <<glass::engine::Engine>::apply+0x1ca0>
  259eb7:	mov    %r14,%rdi
  259eba:	call   *0x397028(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  259ec0:	mov    0x8(%rsp),%rdi
  259ec5:	mov    0x48(%rsp),%r15
  259eca:	call   257490 <<glass::engine::Engine>::fold_sentinel>
  259ecf:	test   %r13,%r13
  259ed2:	setne  %al
  259ed5:	test   %rbx,%rbx
  259ed8:	sete   %cl
  259edb:	or     %al,%cl
  259edd:	cmp    $0x1,%cl
  259ee0:	je     258320 <<glass::engine::Engine>::apply+0x100>
  259ee6:	mov    %r15,%rdi
  259ee9:	call   *0x396ff9(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  259eef:	jmp    258320 <<glass::engine::Engine>::apply+0x100>
  259ef4:	add    %rbx,%r12
  259ef7:	cmp    $0x1,%r14b
  259efb:	jne    259f26 <<glass::engine::Engine>::apply+0x1d06>
  259efd:	mov    0x8(%rsp),%rax
  259f02:	cmpl   $0xffffffff,0x710(%rax)
  259f09:	jne    259f26 <<glass::engine::Engine>::apply+0x1d06>
  259f0b:	lea    0x140(%rsp),%rdi
  259f13:	mov    %r12,%rsi
  259f16:	mov    %r13,%rdx
  259f19:	call   2a1190 <glass::engine::plain_c0>
  259f1e:	test   %al,%al
  259f20:	jne    259ca0 <<glass::engine::Engine>::apply+0x1a80>
  259f26:	xor    %ebx,%ebx
  259f28:	nopl   0x0(%rax,%rax,1)
  259f30:	mov    0x8(%rsp),%rax
  259f35:	cmpl   $0xffffffff,0x710(%rax)
  259f3c:	jne    259f8c <<glass::engine::Engine>::apply+0x1d6c>
  259f3e:	mov    0x50(%rsp),%rax
  259f43:	mov    %rax,0x70(%rsp)
  259f48:	lea    0x140(%rsp),%rax
  259f50:	mov    %rax,0x78(%rsp)
  259f55:	movb   $0x0,0x80(%rsp)
  259f5d:	mov    %r13,%rcx
  259f60:	sub    %rbx,%rcx
  259f63:	jb     25a0b6 <<glass::engine::Engine>::apply+0x1e96>
  259f69:	lea    (%r12,%rbx,1),%rdx
  259f6d:	mov    0xb0(%rsp),%rdi
  259f75:	lea    0x70(%rsp),%rsi
  259f7a:	call   1a0570 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  259f7f:	add    %rax,%rbx
  259f82:	cmp    %r13,%rbx
  259f85:	jne    259f30 <<glass::engine::Engine>::apply+0x1d10>
  259f87:	jmp    259ca0 <<glass::engine::Engine>::apply+0x1a80>
  259f8c:	mov    %r13,%rcx
  259f8f:	sub    %rbx,%rcx
  259f92:	jb     25a106 <<glass::engine::Engine>::apply+0x1ee6>
  259f98:	lea    (%r12,%rbx,1),%rdx
  259f9c:	mov    0x50(%rsp),%rdi
  259fa1:	lea    0x140(%rsp),%rsi
  259fa9:	call   1942d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  259fae:	jmp    259f7f <<glass::engine::Engine>::apply+0x1d5f>
  259fb0:	mov    $0x8,%ecx
  259fb5:	mov    $0x30,%r8d
  259fbb:	mov    0x240(%rsp),%rdi
  259fc3:	mov    %r14,%rsi
  259fc6:	mov    %r13,%rdx
  259fc9:	call   1cf870 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  259fce:	mov    0x8(%rsp),%rax
  259fd3:	mov    0x8f8(%rax),%r14
  259fda:	jmp    259d6c <<glass::engine::Engine>::apply+0x1b4c>
  259fdf:	add    $0x258,%rsp
  259fe6:	pop    %rbx
  259fe7:	pop    %r12
  259fe9:	pop    %r13
  259feb:	pop    %r14
  259fed:	pop    %r15
  259fef:	pop    %rbp
  259ff0:	ret
  259ff1:	mov    %r14,%r15
  259ff4:	mov    %r14,%rdx
  259ff7:	jmp    25a007 <<glass::engine::Engine>::apply+0x1de7>
  259ff9:	mov    %r13,%rbx
  259ffc:	jmp    25a001 <<glass::engine::Engine>::apply+0x1de1>
  259ffe:	mov    %r14,%rbx
  25a001:	mov    %rbp,%r15
  25a004:	mov    %rbp,%rdx
  25a007:	lea    0x3595ea(%rip),%rcx        # 5b35f8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25a00e:	mov    %rbx,%rdi
  25a011:	mov    %r15,%rsi
  25a014:	call   *0x39705e(%rip)        # 5f1078 <_DYNAMIC+0x3d8>
  25a01a:	jmp    25a176 <<glass::engine::Engine>::apply+0x1f56>
  25a01f:	mov    %rsi,%rdx
  25a022:	mov    %r13,%rbx
  25a025:	mov    %r14,%r15
  25a028:	lea    0x3708e9(%rip),%rcx        # 5ca918 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17b98>
  25a02f:	jmp    25a00e <<glass::engine::Engine>::apply+0x1dee>
  25a031:	mov    %r15,%rbx
  25a034:	mov    %rax,%r15
  25a037:	lea    0x3708c2(%rip),%rcx        # 5ca900 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17b80>
  25a03e:	jmp    25a00e <<glass::engine::Engine>::apply+0x1dee>
  25a040:	mov    %r15,%rbx
  25a043:	mov    0x48(%rsp),%r15
  25a048:	lea    0x3708b1(%rip),%rcx        # 5ca900 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17b80>
  25a04f:	mov    0x18(%rsp),%rdx
  25a054:	jmp    25a00e <<glass::engine::Engine>::apply+0x1dee>
  25a056:	mov    0x18(%rsp),%rdx
  25a05b:	mov    %rdx,%r15
  25a05e:	jmp    25a007 <<glass::engine::Engine>::apply+0x1de7>
  25a060:	mov    %r13,%rbx
  25a063:	mov    %r12,%r15
  25a066:	mov    %r12,%rdx
  25a069:	jmp    25a007 <<glass::engine::Engine>::apply+0x1de7>
  25a06b:	lea    0x3708be(%rip),%rcx        # 5ca930 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bb0>
  25a072:	mov    0x18(%rsp),%rdx
  25a077:	jmp    25a00e <<glass::engine::Engine>::apply+0x1dee>
  25a079:	lea    0x3708c8(%rip),%rcx        # 5ca948 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bc8>
  25a080:	xor    %ebx,%ebx
  25a082:	mov    0x18(%rsp),%rdx
  25a087:	jmp    25a00e <<glass::engine::Engine>::apply+0x1dee>
  25a089:	mov    $0xffffffffffffffff,%r15
  25a090:	xor    %ebx,%ebx
  25a092:	xor    %edx,%edx
  25a094:	lea    0x37084d(%rip),%rcx        # 5ca8e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17b68>
  25a09b:	jmp    25a00e <<glass::engine::Engine>::apply+0x1dee>
  25a0a0:	mov    $0x10,%edx
  25a0a5:	xor    %ebx,%ebx
  25a0a7:	mov    %rbp,%r15
  25a0aa:	lea    0x3708af(%rip),%rcx        # 5ca960 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17be0>
  25a0b1:	jmp    25a00e <<glass::engine::Engine>::apply+0x1dee>
  25a0b6:	mov    %r13,%r15
  25a0b9:	mov    %r13,%rdx
  25a0bc:	jmp    25a007 <<glass::engine::Engine>::apply+0x1de7>
  25a0c1:	mov    $0x8,%edi
  25a0c6:	mov    %r14,%rsi
  25a0c9:	call   *0x396dd9(%rip)        # 5f0ea8 <_DYNAMIC+0x208>
  25a0cf:	mov    %r14,%r15
  25a0d2:	mov    %r14,%rdx
  25a0d5:	jmp    25a0e5 <<glass::engine::Engine>::apply+0x1ec5>
  25a0d7:	mov    %r13,%rbx
  25a0da:	jmp    25a0df <<glass::engine::Engine>::apply+0x1ebf>
  25a0dc:	mov    %r14,%rbx
  25a0df:	mov    %rbp,%r15
  25a0e2:	mov    %rbp,%rdx
  25a0e5:	lea    0x359524(%rip),%rcx        # 5b3610 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25a0ec:	jmp    25a00e <<glass::engine::Engine>::apply+0x1dee>
  25a0f1:	mov    0x18(%rsp),%rdx
  25a0f6:	mov    %rdx,%r15
  25a0f9:	jmp    25a0e5 <<glass::engine::Engine>::apply+0x1ec5>
  25a0fb:	mov    %r13,%rbx
  25a0fe:	mov    %r12,%r15
  25a101:	mov    %r12,%rdx
  25a104:	jmp    25a0e5 <<glass::engine::Engine>::apply+0x1ec5>
  25a106:	mov    %r13,%r15
  25a109:	mov    %r13,%rdx
  25a10c:	jmp    25a0e5 <<glass::engine::Engine>::apply+0x1ec5>
  25a10e:	mov    %rcx,0x10(%rsp)
  25a113:	jmp    25a163 <<glass::engine::Engine>::apply+0x1f43>
  25a115:	lea    0x36db74(%rip),%rcx        # 5c7c90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  25a11c:	mov    %rbp,%rdi
  25a11f:	mov    %r15,%rsi
  25a122:	call   *0x396f50(%rip)        # 5f1078 <_DYNAMIC+0x3d8>
  25a128:	jmp    25a176 <<glass::engine::Engine>::apply+0x1f56>
  25a12a:	mov    %r15,0x10(%rsp)
  25a12f:	lea    0x36e72a(%rip),%rax        # 5c8860 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  25a136:	jmp    25a15b <<glass::engine::Engine>::apply+0x1f3b>
  25a138:	lea    0x36db51(%rip),%rcx        # 5c7c90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  25a13f:	mov    0x68(%rsp),%rdi
  25a144:	mov    %rbp,%rsi
  25a147:	call   *0x396f2b(%rip)        # 5f1078 <_DYNAMIC+0x3d8>
  25a14d:	jmp    25a176 <<glass::engine::Engine>::apply+0x1f56>
  25a14f:	mov    %r15,0x10(%rsp)
  25a154:	lea    0x36e6ed(%rip),%rax        # 5c8848 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  25a15b:	mov    %rax,0xb8(%rsp)
  25a163:	mov    0x10(%rsp),%rdi
  25a168:	mov    0xb8(%rsp),%rdx
  25a170:	call   *0x396d42(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  25a176:	ud2
  25a178:	mov    %rax,%r14
  25a17b:	test   %r12,%r12
  25a17e:	je     25a1e0 <<glass::engine::Engine>::apply+0x1fc0>
  25a180:	mov    %rbx,%rdi
  25a183:	call   *0x396d5f(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  25a189:	jmp    25a1e0 <<glass::engine::Engine>::apply+0x1fc0>
  25a18b:	mov    %rax,%r14
  25a18e:	lock decq 0x0(%r13)
  25a193:	je     25a1a1 <<glass::engine::Engine>::apply+0x1f81>
  25a195:	jmp    25a1e0 <<glass::engine::Engine>::apply+0x1fc0>
  25a197:	mov    %rax,%r14
  25a19a:	lock decq (%r12)
  25a19f:	jne    25a1e0 <<glass::engine::Engine>::apply+0x1fc0>
  25a1a1:	lea    0x70(%rsp),%rdi
  25a1a6:	call   *0x396d5c(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  25a1ac:	jmp    25a1e0 <<glass::engine::Engine>::apply+0x1fc0>
  25a1ae:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1b0:	mov    %rax,%r14
  25a1b3:	test   %r13,%r13
  25a1b6:	setne  %al
  25a1b9:	test   %rbx,%rbx
  25a1bc:	sete   %cl
  25a1bf:	or     %al,%cl
  25a1c1:	jne    25a24c <<glass::engine::Engine>::apply+0x202c>
  25a1c7:	jmp    25a209 <<glass::engine::Engine>::apply+0x1fe9>
  25a1c9:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1cb:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1cd:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1cf:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1d1:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1d3:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1d5:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1d7:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1d9:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1db:	jmp    25a1dd <<glass::engine::Engine>::apply+0x1fbd>
  25a1dd:	mov    %rax,%r14
  25a1e0:	cmpq   $0x0,0x150(%rsp)
  25a1e9:	jne    25a21a <<glass::engine::Engine>::apply+0x1ffa>
  25a1eb:	cmpq   $0x0,0x168(%rsp)
  25a1f4:	jne    25a233 <<glass::engine::Engine>::apply+0x2013>
  25a1f6:	cmpq   $0x0,0x180(%rsp)
  25a1ff:	jle    25a24c <<glass::engine::Engine>::apply+0x202c>
  25a201:	mov    0x188(%rsp),%r15
  25a209:	mov    %r15,%rdi
  25a20c:	call   *0x396cd6(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  25a212:	mov    %r14,%rdi
  25a215:	call   5af670 <_Unwind_Resume@plt>
  25a21a:	mov    0x158(%rsp),%rdi
  25a222:	call   *0x396cc0(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  25a228:	cmpq   $0x0,0x168(%rsp)
  25a231:	je     25a1f6 <<glass::engine::Engine>::apply+0x1fd6>
  25a233:	mov    0x170(%rsp),%rdi
  25a23b:	call   *0x396ca7(%rip)        # 5f0ee8 <_DYNAMIC+0x248>
  25a241:	cmpq   $0x0,0x180(%rsp)
  25a24a:	jg     25a201 <<glass::engine::Engine>::apply+0x1fe1>
  25a24c:	mov    %r14,%rdi
  25a24f:	call   5af670 <_Unwind_Resume@plt>
