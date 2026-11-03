
/tmp/glass-i26-authority-inline-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002581e0 <<glass::engine::Engine>::apply>:
  2581e0:	push   %rbp
  2581e1:	push   %r15
  2581e3:	push   %r14
  2581e5:	push   %r13
  2581e7:	push   %r12
  2581e9:	push   %rbx
  2581ea:	sub    $0x248,%rsp
  2581f1:	mov    %rsi,%r15
  2581f4:	testb  $0x10,0x6d5(%rdi)
  2581fb:	jne    25825d <<glass::engine::Engine>::apply+0x7d>
  2581fd:	cmpb   $0x2,0x278(%rdi)
  258204:	jne    25825d <<glass::engine::Engine>::apply+0x7d>
  258206:	mov    0xb0(%rdi),%rax
  25820d:	dec    %rax
  258210:	movq   $0x0,0x250(%rdi)
  25821b:	movl   $0x0,0x258(%rdi)
  258225:	movb   $0x0,0x260(%rdi)
  25822c:	mov    %rax,0x268(%rdi)
  258233:	movl   $0x0,0x270(%rdi)
  25823d:	movb   $0x1,0x278(%rdi)
  258244:	movb   $0x0,0x280(%rdi)
  25824b:	movq   $0x0,0xa60(%rdi)
  258256:	movb   $0x1,0xa7d(%rdi)
  25825d:	test   %rdx,%rdx
  258260:	je     25a0dc <<glass::engine::Engine>::apply+0x1efc>
  258266:	lea    0x10(%rdi),%rax
  25826a:	mov    %rax,0x238(%rsp)
  258272:	lea    0x6f0(%rdi),%rax
  258279:	mov    %rax,0x48(%rsp)
  25827e:	lea    0x8e8(%rdi),%rax
  258285:	mov    %rax,0x220(%rsp)
  25828d:	lea    0x720(%rdi),%rax
  258294:	mov    %rax,0xd0(%rsp)
  25829c:	lea    0x9a0(%rdi),%rbx
  2582a3:	mov    $0x1000,%ecx
  2582a8:	lea    0x372609(%rip),%rax        # 5ca8b8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bf8>
  2582af:	mov    %rax,0x98(%rsp)
  2582b7:	mov    %rdi,0x10(%rsp)
  2582bc:	mov    %rbx,0x230(%rsp)
  2582c4:	jmp    2582f5 <<glass::engine::Engine>::apply+0x115>
  2582c6:	cs nopw 0x0(%rax,%rax,1)
  2582d0:	mov    0x1e8(%rsp),%r15
  2582d8:	mov    0x240(%rsp),%rdx
  2582e0:	sub    0x18(%rsp),%rdx
  2582e5:	mov    0x10(%rsp),%rdi
  2582ea:	mov    $0x1000,%ecx
  2582ef:	je     25a0dc <<glass::engine::Engine>::apply+0x1efc>
  2582f5:	cmp    $0x2000,%rdx
  2582fc:	mov    $0x2000,%r9d
  258302:	mov    %rdx,0x240(%rsp)
  25830a:	cmovb  %rdx,%r9
  25830e:	mov    0x6d4(%rdi),%ebp
  258314:	and    %ecx,%ebp
  258316:	mov    0xa58(%rdi),%r11
  25831d:	mov    $0x0,%r14d
  258323:	cmove  %r11,%r14
  258327:	mov    0xa68(%rdi),%rax
  25832e:	mov    %rax,%r12
  258331:	cmove  %r11,%r12
  258335:	mov    0x910(%rdi),%r13
  25833c:	mov    $0x8,%ebx
  258341:	test   %r13,%r13
  258344:	mov    %r9,0x18(%rsp)
  258349:	mov    %r15,0x40(%rsp)
  25834e:	je     2583c7 <<glass::engine::Engine>::apply+0x1e7>
  258350:	mov    %r12,0x8(%rsp)
  258355:	mov    %r14,0x100(%rsp)
  25835d:	mov    %r11,0x28(%rsp)
  258362:	mov    %rdi,%r15
  258365:	mov    0x908(%rdi),%r12
  25836c:	lea    0x0(,%r13,8),%rax
  258374:	lea    (%rax,%rax,2),%r14
  258378:	mov    $0x8,%esi
  25837d:	mov    %r14,%rdi
  258380:	call   *0x398a82(%rip)        # 5f0e08 <_DYNAMIC+0x228>
  258386:	test   %rax,%rax
  258389:	je     25a1a2 <<glass::engine::Engine>::apply+0x1fc2>
  25838f:	mov    %rax,%rbx
  258392:	mov    %rax,%rdi
  258395:	mov    %r12,%rsi
  258398:	mov    %r14,%rdx
  25839b:	call   *0x398a6f(%rip)        # 5f0e10 <memcpy@GLIBC_2.14>
  2583a1:	mov    0xa68(%r15),%rax
  2583a8:	mov    %r15,%rdi
  2583ab:	mov    0x18(%rsp),%r9
  2583b0:	mov    0x40(%rsp),%r15
  2583b5:	mov    0x28(%rsp),%r11
  2583ba:	mov    0x100(%rsp),%r14
  2583c2:	mov    0x8(%rsp),%r12
  2583c7:	lea    (%r15,%r9,1),%rcx
  2583cb:	mov    %rcx,0x1e8(%rsp)
  2583d3:	mov    0xa78(%rdi),%ecx
  2583d9:	mov    0xa60(%rdi),%rdx
  2583e0:	movzbl 0xa7d(%rdi),%esi
  2583e7:	movzbl 0xa7e(%rdi),%r8d
  2583ef:	mov    0x238(%rsp),%r10
  2583f7:	mov    %r10,0x198(%rsp)
  2583ff:	movq   $0x0,0x130(%rsp)
  25840b:	movq   $0x8,0x138(%rsp)
  258417:	movq   $0x0,0x140(%rsp)
  258423:	mov    %r13,0x148(%rsp)
  25842b:	mov    %rbx,0x150(%rsp)
  258433:	mov    %r13,0x158(%rsp)
  25843b:	mov    %r12,0x1a0(%rsp)
  258443:	mov    %r14,0x1a8(%rsp)
  25844b:	shr    $0xc,%ebp
  25844e:	mov    %bpl,0x1dc(%rsp)
  258456:	mov    %rax,0x1b0(%rsp)
  25845e:	mov    %ecx,0x1d8(%rsp)
  258465:	mov    %rdx,0x1b8(%rsp)
  25846d:	mov    %sil,0x1dd(%rsp)
  258475:	mov    %r9,0x1c0(%rsp)
  25847d:	movups (%rdi),%xmm0
  258480:	movaps %xmm0,0x120(%rsp)
  258488:	movq   $0xffffffffffffffff,0x160(%rsp)
  258494:	mov    %r11,0x1c8(%rsp)
  25849c:	mov    %r8b,0x1de(%rsp)
  2584a4:	mov    0xa70(%rdi),%rax
  2584ab:	mov    %rax,0x1d0(%rsp)
  2584b3:	test   %r8b,%r8b
  2584b6:	je     258520 <<glass::engine::Engine>::apply+0x340>
  2584b8:	cmpb   $0xd,0x8c9(%rdi)
  2584bf:	sete   %al
  2584c2:	cmpq   $0x0,0x8b8(%rdi)
  2584ca:	sete   %cl
  2584cd:	and    %al,%cl
  2584cf:	cmpl   $0xffffffff,0x710(%rdi)
  2584d6:	sete   %r14b
  2584da:	and    %cl,%r14b
  2584dd:	mov    $0x3,%eax
  2584e2:	sub    %r9,%rax
  2584e5:	mov    %rax,0x228(%rsp)
  2584ed:	mov    $0x1,%al
  2584ef:	mov    %eax,0xcc(%rsp)
  2584f6:	xor    %r12d,%r12d
  2584f9:	mov    %r15,0x1f0(%rsp)
  258501:	mov    $0x1,%al
  258503:	mov    %eax,0xec(%rsp)
  25850a:	movl   $0x0,0x30(%rsp)
  258512:	xor    %r13d,%r13d
  258515:	jmp    258623 <<glass::engine::Engine>::apply+0x443>
  25851a:	nopw   0x0(%rax,%rax,1)
  258520:	xor    %r12d,%r12d
  258523:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258530:	mov    0x10(%rsp),%rax
  258535:	cmpl   $0xffffffff,0x710(%rax)
  25853c:	jne    25858d <<glass::engine::Engine>::apply+0x3ad>
  25853e:	mov    0x48(%rsp),%rax
  258543:	mov    %rax,0x60(%rsp)
  258548:	lea    0x120(%rsp),%rax
  258550:	mov    %rax,0x68(%rsp)
  258555:	movb   $0x0,0x70(%rsp)
  25855a:	mov    0x18(%rsp),%rcx
  25855f:	sub    %r12,%rcx
  258562:	jb     25a14d <<glass::engine::Engine>::apply+0x1f6d>
  258568:	lea    (%r15,%r12,1),%rdx
  25856c:	mov    0xd0(%rsp),%rdi
  258574:	lea    0x60(%rsp),%rsi
  258579:	call   1a0530 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25857e:	add    %rax,%r12
  258581:	cmp    0x18(%rsp),%r12
  258586:	jne    258530 <<glass::engine::Engine>::apply+0x350>
  258588:	jmp    259dc0 <<glass::engine::Engine>::apply+0x1be0>
  25858d:	mov    0x18(%rsp),%rcx
  258592:	sub    %r12,%rcx
  258595:	jb     25a218 <<glass::engine::Engine>::apply+0x2038>
  25859b:	lea    (%r15,%r12,1),%rdx
  25859f:	mov    0x48(%rsp),%rdi
  2585a4:	lea    0x120(%rsp),%rsi
  2585ac:	call   194290 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  2585b1:	jmp    25857e <<glass::engine::Engine>::apply+0x39e>
  2585b3:	movzwl 0x60(%rsp),%eax
  2585b8:	lea    -0x1(%rax),%esi
  2585bb:	test   %eax,%eax
  2585bd:	cmove  %eax,%esi
  2585c0:	cmpq   $0x0,0x8(%rsp)
  2585c6:	je     258d73 <<glass::engine::Engine>::apply+0xb93>
  2585cc:	movzwl 0x62(%rsp),%ecx
  2585d1:	xor    %eax,%eax
  2585d3:	test   %cx,%cx
  2585d6:	setne  %al
  2585d9:	movzwl %cx,%edx
  2585dc:	dec    %rdx
  2585df:	test   $0x1,%al
  2585e1:	mov    $0x0,%eax
  2585e6:	cmove  %rax,%rdx
  2585ea:	mov    0x198(%rsp),%rdi
  2585f2:	call   34b730 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  2585f7:	mov    0x28(%rsp),%r13
  2585fc:	mov    %r13,%r12
  2585ff:	add    %rbp,%r12
  258602:	mov    $0x1,%r14b
  258605:	mov    $0x1,%al
  258607:	mov    %eax,0x30(%rsp)
  25860b:	mov    %r12,0xf8(%rsp)
  258613:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258620:	add    %rbp,%r13
  258623:	testb  $0x1,0xcc(%rsp)
  25862b:	je     258690 <<glass::engine::Engine>::apply+0x4b0>
  25862d:	mov    0x39906c(%rip),%rax        # 5f16a0 <_DYNAMIC+0xac0>
  258634:	mov    (%rax),%rax
  258637:	mov    $0x1b,%edi
  25863c:	mov    0x1f0(%rsp),%rsi
  258644:	mov    0x1e8(%rsp),%rdx
  25864c:	call   *%rax
  25864e:	cmp    $0x1,%rax
  258652:	jne    258690 <<glass::engine::Engine>::apply+0x4b0>
  258654:	mov    %rdx,%rax
  258657:	sub    %r15,%rax
  25865a:	inc    %rdx
  25865d:	mov    $0x1,%cl
  25865f:	mov    %ecx,0xcc(%rsp)
  258666:	mov    %rdx,0x1f0(%rsp)
  25866e:	mov    %rax,%rdx
  258671:	mov    %rdx,%rax
  258674:	sub    %r13,%rax
  258677:	cmp    $0x18,%rax
  25867b:	jae    2586c9 <<glass::engine::Engine>::apply+0x4e9>
  25867d:	jmp    258cad <<glass::engine::Engine>::apply+0xacd>
  258682:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258690:	testb  $0x1,0xec(%rsp)
  258698:	je     259d94 <<glass::engine::Engine>::apply+0x1bb4>
  25869e:	movl   $0x0,0xec(%rsp)
  2586a9:	mov    0x18(%rsp),%rdx
  2586ae:	movl   $0x0,0xcc(%rsp)
  2586b9:	mov    %rdx,%rax
  2586bc:	sub    %r13,%rax
  2586bf:	cmp    $0x18,%rax
  2586c3:	jb     258cad <<glass::engine::Engine>::apply+0xacd>
  2586c9:	cmp    %rdx,0x18(%rsp)
  2586ce:	mov    %rdx,0x100(%rsp)
  2586d6:	jae    25871c <<glass::engine::Engine>::apply+0x53c>
  2586d8:	jmp    25a168 <<glass::engine::Engine>::apply+0x1f88>
  2586dd:	nopl   (%rax)
  2586e0:	mov    0x40(%rsp),%r15
  2586e5:	cmp    $0xd,%al
  2586e7:	sete   %al
  2586ea:	test   %rcx,%rcx
  2586ed:	sete   %cl
  2586f0:	and    %al,%cl
  2586f2:	cmp    $0xffffffff,%edx
  2586f5:	sete   %r14b
  2586f9:	and    %cl,%r14b
  2586fc:	mov    0x28(%rsp),%r13
  258701:	mov    %r13,%r12
  258704:	mov    0x100(%rsp),%rdx
  25870c:	mov    %rdx,%rax
  25870f:	sub    %r13,%rax
  258712:	cmp    $0x17,%rax
  258716:	jbe    258cad <<glass::engine::Engine>::apply+0xacd>
  25871c:	lea    0xa0(%rsp),%rdi
  258724:	mov    %r15,%rsi
  258727:	mov    %r13,%rcx
  25872a:	call   2a0e00 <glass::engine::next_run>
  25872f:	movzbl 0xb0(%rsp),%r15d
  258738:	cmp    $0x2,%r15b
  25873c:	je     258ca0 <<glass::engine::Engine>::apply+0xac0>
  258742:	mov    0xa0(%rsp),%rbx
  25874a:	mov    0xa8(%rsp),%rax
  258752:	mov    %rax,0x28(%rsp)
  258757:	mov    %rbx,%rbp
  25875a:	sub    %r12,%rbp
  25875d:	jbe    258860 <<glass::engine::Engine>::apply+0x680>
  258763:	movzbl 0x39e94e(%rip),%eax        # 5f70b8 <glass::engine::probes::RUN_PROBE>
  25876a:	mov    %rbx,%r13
  25876d:	cmp    $0x68,%al
  25876f:	je     258863 <<glass::engine::Engine>::apply+0x683>
  258775:	cmp    0x18(%rsp),%rbx
  25877a:	ja     25a157 <<glass::engine::Engine>::apply+0x1f77>
  258780:	add    0x40(%rsp),%r12
  258785:	cmp    $0x1,%r14b
  258789:	jne    2587b7 <<glass::engine::Engine>::apply+0x5d7>
  25878b:	mov    0x10(%rsp),%rax
  258790:	cmpl   $0xffffffff,0x710(%rax)
  258797:	jne    2587b7 <<glass::engine::Engine>::apply+0x5d7>
  258799:	lea    0x120(%rsp),%rdi
  2587a1:	mov    %r12,%rsi
  2587a4:	mov    %rbp,%rdx
  2587a7:	call   2a10f0 <glass::engine::plain_c0>
  2587ac:	mov    %rbx,%r13
  2587af:	test   %al,%al
  2587b1:	jne    258863 <<glass::engine::Engine>::apply+0x683>
  2587b7:	movzbl 0x39e90a(%rip),%eax        # 5f70c8 <glass::engine::timers::ON>
  2587be:	test   %al,%al
  2587c0:	je     258af0 <<glass::engine::Engine>::apply+0x910>
  2587c6:	mov    $0x1,%edi
  2587cb:	call   50dfb0 <<std::sys::pal::unix::time::Timespec>::now>
  2587d0:	mov    %rax,0x8(%rsp)
  2587d5:	mov    %edx,%r14d
  2587d8:	xor    %r13d,%r13d
  2587db:	nopl   0x0(%rax,%rax,1)
  2587e0:	mov    0x10(%rsp),%rax
  2587e5:	cmpl   $0xffffffff,0x710(%rax)
  2587ec:	jne    258839 <<glass::engine::Engine>::apply+0x659>
  2587ee:	mov    0x48(%rsp),%rax
  2587f3:	mov    %rax,0x60(%rsp)
  2587f8:	lea    0x120(%rsp),%rax
  258800:	mov    %rax,0x68(%rsp)
  258805:	movb   $0x0,0x70(%rsp)
  25880a:	mov    %rbp,%rcx
  25880d:	sub    %r13,%rcx
  258810:	jb     25a0f6 <<glass::engine::Engine>::apply+0x1f16>
  258816:	lea    (%r12,%r13,1),%rdx
  25881a:	mov    0xd0(%rsp),%rdi
  258822:	lea    0x60(%rsp),%rsi
  258827:	call   1a0530 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25882c:	add    %rax,%r13
  25882f:	cmp    %rbp,%r13
  258832:	jne    2587e0 <<glass::engine::Engine>::apply+0x600>
  258834:	jmp    258a58 <<glass::engine::Engine>::apply+0x878>
  258839:	mov    %rbp,%rcx
  25883c:	sub    %r13,%rcx
  25883f:	jb     25a1e9 <<glass::engine::Engine>::apply+0x2009>
  258845:	lea    (%r12,%r13,1),%rdx
  258849:	mov    0x48(%rsp),%rdi
  25884e:	lea    0x120(%rsp),%rsi
  258856:	call   194290 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25885b:	jmp    25882c <<glass::engine::Engine>::apply+0x64c>
  25885d:	nopl   (%rax)
  258860:	mov    %r12,%r13
  258863:	mov    0x10(%rsp),%rdi
  258868:	movzbl 0x8c9(%rdi),%eax
  25886f:	cmp    $0xd,%al
  258871:	sete   %dl
  258874:	mov    0x8b8(%rdi),%rcx
  25887b:	test   %rcx,%rcx
  25887e:	sete   %sil
  258882:	and    %dl,%sil
  258885:	mov    0x710(%rdi),%edx
  25888b:	cmp    $0xffffffff,%edx
  25888e:	sete   %dil
  258892:	test   %dil,%sil
  258895:	je     258910 <<glass::engine::Engine>::apply+0x730>
  258897:	mov    0x28(%rsp),%rsi
  25889c:	mov    %rsi,%rbp
  25889f:	sub    %rbx,%rbp
  2588a2:	mov    0x18(%rsp),%rdx
  2588a7:	jb     25a12b <<glass::engine::Engine>::apply+0x1f4b>
  2588ad:	cmp    %rdx,%rsi
  2588b0:	ja     25a137 <<glass::engine::Engine>::apply+0x1f57>
  2588b6:	movzbl 0x39e7fa(%rip),%r12d        # 5f70b8 <glass::engine::probes::RUN_PROBE>
  2588be:	movzbl 0x39e803(%rip),%eax        # 5f70c8 <glass::engine::timers::ON>
  2588c5:	test   %al,%al
  2588c7:	je     2589de <<glass::engine::Engine>::apply+0x7fe>
  2588cd:	mov    $0x1,%edi
  2588d2:	call   50dfb0 <<std::sys::pal::unix::time::Timespec>::now>
  2588d7:	mov    %rax,0x8(%rsp)
  2588dc:	mov    %edx,%r14d
  2588df:	cmp    $0x63,%r12b
  2588e3:	jbe    2589ee <<glass::engine::Engine>::apply+0x80e>
  2588e9:	movzbl %r15b,%eax
  2588ed:	mov    %rbp,%r12
  2588f0:	sub    %rax,%r12
  2588f3:	mov    0x40(%rsp),%r15
  2588f8:	cmp    $0xffffffff,%r14d
  2588fc:	jne    258bd9 <<glass::engine::Engine>::apply+0x9f9>
  258902:	jmp    258c67 <<glass::engine::Engine>::apply+0xa87>
  258907:	nopw   0x0(%rax,%rax,1)
  258910:	mov    0x18(%rsp),%rsi
  258915:	mov    0x28(%rsp),%rbx
  25891a:	cmp    %rsi,%rbx
  25891d:	ja     25a119 <<glass::engine::Engine>::apply+0x1f39>
  258923:	cmp    %r13,%rbx
  258926:	jb     25a119 <<glass::engine::Engine>::apply+0x1f39>
  25892c:	sub    %r13,%rbx
  25892f:	je     2586e0 <<glass::engine::Engine>::apply+0x500>
  258935:	mov    0x40(%rsp),%r15
  25893a:	add    %r15,%r13
  25893d:	xor    %r12d,%r12d
  258940:	mov    0x10(%rsp),%rax
  258945:	cmpl   $0xffffffff,0x710(%rax)
  25894c:	jne    258996 <<glass::engine::Engine>::apply+0x7b6>
  25894e:	mov    0x48(%rsp),%rax
  258953:	mov    %rax,0x60(%rsp)
  258958:	lea    0x120(%rsp),%rax
  258960:	mov    %rax,0x68(%rsp)
  258965:	movb   $0x0,0x70(%rsp)
  25896a:	mov    %rbx,%rcx
  25896d:	sub    %r12,%rcx
  258970:	jb     25a0ee <<glass::engine::Engine>::apply+0x1f0e>
  258976:	lea    (%r12,%r13,1),%rdx
  25897a:	mov    0xd0(%rsp),%rdi
  258982:	lea    0x60(%rsp),%rsi
  258987:	call   1a0530 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25898c:	add    %rax,%r12
  25898f:	cmp    %rbx,%r12
  258992:	jne    258940 <<glass::engine::Engine>::apply+0x760>
  258994:	jmp    2589c0 <<glass::engine::Engine>::apply+0x7e0>
  258996:	mov    %rbx,%rcx
  258999:	sub    %r12,%rcx
  25899c:	jb     25a1e1 <<glass::engine::Engine>::apply+0x2001>
  2589a2:	lea    (%r12,%r13,1),%rdx
  2589a6:	mov    0x48(%rsp),%rdi
  2589ab:	lea    0x120(%rsp),%rsi
  2589b3:	call   194290 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  2589b8:	jmp    25898c <<glass::engine::Engine>::apply+0x7ac>
  2589ba:	nopw   0x0(%rax,%rax,1)
  2589c0:	mov    0x10(%rsp),%rdx
  2589c5:	movzbl 0x8c9(%rdx),%eax
  2589cc:	mov    0x8b8(%rdx),%rcx
  2589d3:	mov    0x710(%rdx),%edx
  2589d9:	jmp    2586e5 <<glass::engine::Engine>::apply+0x505>
  2589de:	mov    $0xffffffff,%r14d
  2589e4:	cmp    $0x63,%r12b
  2589e8:	ja     2588e9 <<glass::engine::Engine>::apply+0x709>
  2589ee:	mov    0x39b3cc(%rip),%eax        # 5f3dc0 <glass::engine::run_whole::ON>
  2589f4:	test   %eax,%eax
  2589f6:	jne    258c8a <<glass::engine::Engine>::apply+0xaaa>
  2589fc:	mov    0x40(%rsp),%rax
  258a01:	lea    (%rax,%rbx,1),%rsi
  258a05:	cmpb   $0x0,0x39b3b8(%rip)        # 5f3dc4 <glass::engine::run_whole::ON+0x4>
  258a0c:	je     258a2d <<glass::engine::Engine>::apply+0x84d>
  258a0e:	test   $0x1,%r15b
  258a12:	je     258b82 <<glass::engine::Engine>::apply+0x9a2>
  258a18:	lea    0x120(%rsp),%rdi
  258a20:	mov    %rbp,%rdx
  258a23:	call   264760 <<glass::engine::Watch>::print_run>
  258a28:	jmp    258b92 <<glass::engine::Engine>::apply+0x9b2>
  258a2d:	test   $0x1,%r15b
  258a31:	je     258bb7 <<glass::engine::Engine>::apply+0x9d7>
  258a37:	cmp    %rbx,0x28(%rsp)
  258a3c:	je     25a17c <<glass::engine::Engine>::apply+0x1f9c>
  258a42:	lea    -0x1(%rbp),%rdx
  258a46:	lea    0x120(%rsp),%rdi
  258a4e:	call   264760 <<glass::engine::Watch>::print_run>
  258a53:	jmp    258bc7 <<glass::engine::Engine>::apply+0x9e7>
  258a58:	movzbl 0x39e669(%rip),%eax        # 5f70c8 <glass::engine::timers::ON>
  258a5f:	mov    %rbx,%r13
  258a62:	test   %al,%al
  258a64:	je     258863 <<glass::engine::Engine>::apply+0x683>
  258a6a:	mov    $0x1,%edi
  258a6f:	call   50dfb0 <<std::sys::pal::unix::time::Timespec>::now>
  258a74:	mov    %rax,0x1f8(%rsp)
  258a7c:	mov    %edx,0x200(%rsp)
  258a83:	mov    0x8(%rsp),%rax
  258a88:	mov    %rax,0x208(%rsp)
  258a90:	mov    %r14d,0x210(%rsp)
  258a98:	lea    0x60(%rsp),%rdi
  258a9d:	lea    0x1f8(%rsp),%rsi
  258aa5:	lea    0x208(%rsp),%rdx
  258aad:	call   50def0 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258ab2:	imul   $0x3b9aca00,0x68(%rsp),%rax
  258abb:	mov    0x70(%rsp),%ecx
  258abf:	add    %rcx,%rax
  258ac2:	cmpb   $0x0,0x60(%rsp)
  258ac7:	mov    $0x0,%ecx
  258acc:	cmove  %rax,%rcx
  258ad0:	lock add %rcx,0x39e600(%rip)        # 5f70d8 <glass::engine::timers::VTE_NS>
  258ad8:	lock incq 0x39e628(%rip)        # 5f7108 <glass::engine::timers::VTE_CALLS>
  258ae0:	lock add %rbp,0x39e618(%rip)        # 5f7100 <glass::engine::timers::VTE_BYTES>
  258ae8:	mov    %rbx,%r13
  258aeb:	jmp    258863 <<glass::engine::Engine>::apply+0x683>
  258af0:	xor    %r14d,%r14d
  258af3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258b00:	mov    0x10(%rsp),%rax
  258b05:	cmpl   $0xffffffff,0x710(%rax)
  258b0c:	jne    258b56 <<glass::engine::Engine>::apply+0x976>
  258b0e:	mov    0x48(%rsp),%rax
  258b13:	mov    %rax,0x60(%rsp)
  258b18:	lea    0x120(%rsp),%rax
  258b20:	mov    %rax,0x68(%rsp)
  258b25:	movb   $0x0,0x70(%rsp)
  258b2a:	mov    %rbp,%rcx
  258b2d:	sub    %r14,%rcx
  258b30:	jb     25a0fb <<glass::engine::Engine>::apply+0x1f1b>
  258b36:	lea    (%r12,%r14,1),%rdx
  258b3a:	mov    0xd0(%rsp),%rdi
  258b42:	lea    0x60(%rsp),%rsi
  258b47:	call   1a0530 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258b4c:	add    %rax,%r14
  258b4f:	cmp    %rbp,%r14
  258b52:	jne    258b00 <<glass::engine::Engine>::apply+0x920>
  258b54:	jmp    258b7a <<glass::engine::Engine>::apply+0x99a>
  258b56:	mov    %rbp,%rcx
  258b59:	sub    %r14,%rcx
  258b5c:	jb     25a1ee <<glass::engine::Engine>::apply+0x200e>
  258b62:	lea    (%r12,%r14,1),%rdx
  258b66:	mov    0x48(%rsp),%rdi
  258b6b:	lea    0x120(%rsp),%rsi
  258b73:	call   194290 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258b78:	jmp    258b4c <<glass::engine::Engine>::apply+0x96c>
  258b7a:	mov    %rbx,%r13
  258b7d:	jmp    258863 <<glass::engine::Engine>::apply+0x683>
  258b82:	lea    0x120(%rsp),%rdi
  258b8a:	mov    %rbp,%rdx
  258b8d:	call   261dc0 <<glass::engine::Watch>::print_utf8>
  258b92:	mov    %rax,%r12
  258b95:	mov    0x1d0(%rsp),%eax
  258b9c:	mov    0x10(%rsp),%rcx
  258ba1:	mov    %eax,0x718(%rcx)
  258ba7:	mov    0x40(%rsp),%r15
  258bac:	cmp    $0xffffffff,%r14d
  258bb0:	jne    258bd9 <<glass::engine::Engine>::apply+0x9f9>
  258bb2:	jmp    258c67 <<glass::engine::Engine>::apply+0xa87>
  258bb7:	lea    0x120(%rsp),%rdi
  258bbf:	mov    %rbp,%rdx
  258bc2:	call   261dc0 <<glass::engine::Watch>::print_utf8>
  258bc7:	mov    %rax,%r12
  258bca:	mov    0x40(%rsp),%r15
  258bcf:	cmp    $0xffffffff,%r14d
  258bd3:	je     258c67 <<glass::engine::Engine>::apply+0xa87>
  258bd9:	movzbl 0x39e4e8(%rip),%eax        # 5f70c8 <glass::engine::timers::ON>
  258be0:	test   %al,%al
  258be2:	je     258c5f <<glass::engine::Engine>::apply+0xa7f>
  258be4:	mov    $0x1,%edi
  258be9:	call   50dfb0 <<std::sys::pal::unix::time::Timespec>::now>
  258bee:	mov    %rax,0x1f8(%rsp)
  258bf6:	mov    %edx,0x200(%rsp)
  258bfd:	mov    0x8(%rsp),%rax
  258c02:	mov    %rax,0x208(%rsp)
  258c0a:	mov    %r14d,0x210(%rsp)
  258c12:	lea    0x60(%rsp),%rdi
  258c17:	lea    0x1f8(%rsp),%rsi
  258c1f:	lea    0x208(%rsp),%rdx
  258c27:	call   50def0 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258c2c:	imul   $0x3b9aca00,0x68(%rsp),%rax
  258c35:	mov    0x70(%rsp),%ecx
  258c39:	add    %rcx,%rax
  258c3c:	cmpb   $0x0,0x60(%rsp)
  258c41:	mov    $0x0,%ecx
  258c46:	cmove  %rax,%rcx
  258c4a:	lock add %rcx,0x39e47e(%rip)        # 5f70d0 <glass::engine::timers::RUN_NS>
  258c52:	lock incq 0x39e49e(%rip)        # 5f70f8 <glass::engine::timers::RUN_CALLS>
  258c5a:	mov    0x40(%rsp),%r15
  258c5f:	lock add %rbp,0x39e489(%rip)        # 5f70f0 <glass::engine::timers::RUN_BYTES>
  258c67:	movzbl 0x39e4aa(%rip),%eax        # 5f7118 <glass::engine::counters::COUNTING>
  258c6e:	test   %al,%al
  258c70:	je     258c7a <<glass::engine::Engine>::apply+0xa9a>
  258c72:	lock add %r12,0x39e496(%rip)        # 5f7110 <glass::engine::counters::LANE_RUN_BYTES>
  258c7a:	add    %r13,%r12
  258c7d:	mov    $0x1,%r14b
  258c80:	mov    0x28(%rsp),%r13
  258c85:	jmp    258704 <<glass::engine::Engine>::apply+0x524>
  258c8a:	call   18b8c6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  258c8f:	jmp    2589fc <<glass::engine::Engine>::apply+0x81c>
  258c94:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  258ca0:	mov    0x40(%rsp),%r15
  258ca5:	mov    0x100(%rsp),%rdx
  258cad:	mov    $0x1,%r13d
  258cb3:	mov    0x18(%rsp),%rax
  258cb8:	mov    %rdx,%rbp
  258cbb:	sub    %rdx,%rax
  258cbe:	jbe    258620 <<glass::engine::Engine>::apply+0x440>
  258cc4:	cmp    %r12,0xf8(%rsp)
  258ccc:	sete   %sil
  258cd0:	cmp    $0x2,%rax
  258cd4:	jb     259150 <<glass::engine::Engine>::apply+0xf70>
  258cda:	lea    (%r15,%rbp,1),%rdi
  258cde:	cmpb   $0x5b,0x1(%rdi)
  258ce2:	jne    259150 <<glass::engine::Engine>::apply+0xf70>
  258ce8:	xorps  %xmm0,%xmm0
  258ceb:	movaps %xmm0,0x70(%rsp)
  258cf0:	movaps %xmm0,0x60(%rsp)
  258cf5:	cmp    $0x2,%rax
  258cf9:	je     259150 <<glass::engine::Engine>::apply+0xf70>
  258cff:	movzbl 0x2(%rdi),%ecx
  258d03:	lea    -0x30(%rcx),%eax
  258d06:	cmp    $0xa,%al
  258d08:	jae    258d37 <<glass::engine::Engine>::apply+0xb57>
  258d0a:	movzbl %al,%eax
  258d0d:	xor    %r10d,%r10d
  258d10:	lea    0x3(%rbp),%rcx
  258d14:	cmp    0x18(%rsp),%rcx
  258d19:	je     259150 <<glass::engine::Engine>::apply+0xf70>
  258d1f:	mov    0x228(%rsp),%rcx
  258d27:	lea    (%rcx,%rbp,1),%r8
  258d2b:	mov    $0x4,%ecx
  258d30:	mov    %rcx,0x28(%rsp)
  258d35:	jmp    258dad <<glass::engine::Engine>::apply+0xbcd>
  258d37:	movzbl %cl,%edx
  258d3a:	xor    %eax,%eax
  258d3c:	lea    -0x48(%rdx),%r8d
  258d40:	cmp    $0x25,%r8d
  258d44:	ja     258d63 <<glass::engine::Engine>::apply+0xb83>
  258d46:	mov    $0x3,%edx
  258d4b:	mov    %rdx,0x28(%rsp)
  258d50:	lea    -0x1ea64f(%rip),%rdi        # 6e708 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2cd7>
  258d57:	movslq (%rdi,%r8,4),%rdx
  258d5b:	add    %rdi,%rdx
  258d5e:	xor    %r10d,%r10d
  258d61:	jmp    *%rdx
  258d63:	mov    $0x1,%r10d
  258d69:	cmp    $0x3b,%edx
  258d6c:	je     258d10 <<glass::engine::Engine>::apply+0xb30>
  258d6e:	jmp    259150 <<glass::engine::Engine>::apply+0xf70>
  258d73:	xor    %eax,%eax
  258d75:	jmp    2585d9 <<glass::engine::Engine>::apply+0x3f9>
  258d7a:	mov    $0xffff,%cx
  258d7e:	xchg   %ax,%ax
  258d80:	movzbl %r9b,%eax
  258d84:	add    %cx,%ax
  258d87:	mov    $0xffff,%ecx
  258d8c:	cmovb  %ecx,%eax
  258d8f:	mov    0x28(%rsp),%rdx
  258d94:	lea    (%r8,%rdx,1),%rcx
  258d98:	inc    %rcx
  258d9b:	inc    %rdx
  258d9e:	mov    %rdx,0x28(%rsp)
  258da3:	cmp    $0x4,%rcx
  258da7:	je     259150 <<glass::engine::Engine>::apply+0xf70>
  258dad:	mov    0x28(%rsp),%rcx
  258db2:	movzbl -0x1(%rdi,%rcx,1),%ecx
  258db7:	lea    -0x30(%rcx),%r9d
  258dbb:	cmp    $0xa,%r9b
  258dbf:	jae    258dd0 <<glass::engine::Engine>::apply+0xbf0>
  258dc1:	mov    $0xa,%cx
  258dc5:	mul    %cx
  258dc8:	jo     258d7a <<glass::engine::Engine>::apply+0xb9a>
  258dca:	mov    %eax,%ecx
  258dcc:	jmp    258d80 <<glass::engine::Engine>::apply+0xba0>
  258dce:	xchg   %ax,%ax
  258dd0:	movzbl %cl,%edx
  258dd3:	cmp    $0x3b,%edx
  258dd6:	jne    258dfd <<glass::engine::Engine>::apply+0xc1d>
  258dd8:	lea    0x1(%r10),%rcx
  258ddc:	cmp    $0x10,%rcx
  258de0:	jae    259150 <<glass::engine::Engine>::apply+0xf70>
  258de6:	cmp    $0xf,%r10
  258dea:	ja     25a1b0 <<glass::engine::Engine>::apply+0x1fd0>
  258df0:	mov    %ax,0x60(%rsp,%r10,2)
  258df6:	xor    %eax,%eax
  258df8:	mov    %rcx,%r10
  258dfb:	jmp    258d8f <<glass::engine::Engine>::apply+0xbaf>
  258dfd:	add    $0xffffffb8,%edx
  258e00:	cmp    $0x25,%edx
  258e03:	ja     259150 <<glass::engine::Engine>::apply+0xf70>
  258e09:	lea    -0x1ea670(%rip),%rdi        # 6e7a0 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d6f>
  258e10:	movslq (%rdi,%rdx,4),%rdx
  258e14:	add    %rdi,%rdx
  258e17:	jmp    *%rdx
  258e19:	cmp    $0x10,%r10
  258e1d:	jae    25a203 <<glass::engine::Engine>::apply+0x2023>
  258e23:	mov    %ax,0x60(%rsp,%r10,2)
  258e29:	cmp    $0x6d,%cl
  258e2c:	setne  %cl
  258e2f:	movaps 0x60(%rsp),%xmm0
  258e34:	movaps 0x70(%rsp),%xmm1
  258e39:	movaps %xmm0,0xa0(%rsp)
  258e41:	movaps %xmm1,0xb0(%rsp)
  258e49:	xor    %ebx,%ebx
  258e4b:	jmp    258e7b <<glass::engine::Engine>::apply+0xc9b>
  258e4d:	cmp    $0x10,%r10
  258e51:	jae    25a20a <<glass::engine::Engine>::apply+0x202a>
  258e57:	mov    %ax,0x60(%rsp,%r10,2)
  258e5d:	movaps 0x60(%rsp),%xmm0
  258e62:	movaps 0x70(%rsp),%xmm1
  258e67:	movaps %xmm0,0xa0(%rsp)
  258e6f:	movaps %xmm1,0xb0(%rsp)
  258e77:	mov    $0x1,%bl
  258e79:	xor    %ecx,%ecx
  258e7b:	mov    0x30(%rsp),%eax
  258e7f:	and    %sil,%al
  258e82:	mov    %eax,0x30(%rsp)
  258e86:	mov    %r10,0x8(%rsp)
  258e8b:	lea    0x1(%r10),%rax
  258e8f:	movaps 0xa0(%rsp),%xmm0
  258e97:	movaps 0xb0(%rsp),%xmm1
  258e9f:	movaps %xmm1,0x70(%rsp)
  258ea4:	movaps %xmm0,0x60(%rsp)
  258ea9:	mov    %rax,0x80(%rsp)
  258eb1:	mov    %cl,0x88(%rsp)
  258eb8:	mov    %bl,0x89(%rsp)
  258ebf:	mov    %rbp,%rax
  258ec2:	sub    %r12,%rax
  258ec5:	jbe    259007 <<glass::engine::Engine>::apply+0xe27>
  258ecb:	mov    %ebx,0xc8(%rsp)
  258ed2:	mov    %rax,%rbx
  258ed5:	mov    %ecx,0xe8(%rsp)
  258edc:	mov    0x39aede(%rip),%eax        # 5f3dc0 <glass::engine::run_whole::ON>
  258ee2:	test   %eax,%eax
  258ee4:	jne    259583 <<glass::engine::Engine>::apply+0x13a3>
  258eea:	movzbl 0x39aed3(%rip),%eax        # 5f3dc4 <glass::engine::run_whole::ON+0x4>
  258ef1:	xor    $0x1,%rax
  258ef5:	cmp    %rax,%rbx
  258ef8:	seta   %al
  258efb:	and    0x30(%rsp),%al
  258eff:	cmp    $0x1,%al
  258f01:	jne    259031 <<glass::engine::Engine>::apply+0xe51>
  258f07:	mov    %r12,%rax
  258f0a:	cmp    %r12,%rbp
  258f0d:	je     258f29 <<glass::engine::Engine>::apply+0xd49>
  258f0f:	nop
  258f10:	movzbl (%r15,%rax,1),%ecx
  258f15:	add    $0xe0,%cl
  258f18:	cmp    $0x5f,%cl
  258f1b:	jae    259563 <<glass::engine::Engine>::apply+0x1383>
  258f21:	inc    %rax
  258f24:	cmp    %rax,%rbp
  258f27:	jne    258f10 <<glass::engine::Engine>::apply+0xd30>
  258f29:	mov    0x39ae91(%rip),%eax        # 5f3dc0 <glass::engine::run_whole::ON>
  258f2f:	test   %eax,%eax
  258f31:	jne    25958d <<glass::engine::Engine>::apply+0x13ad>
  258f37:	add    %r15,%r12
  258f3a:	movzbl 0x39ae83(%rip),%eax        # 5f3dc4 <glass::engine::run_whole::ON+0x4>
  258f41:	xor    $0x1,%rax
  258f45:	sub    %rax,%rbx
  258f48:	mov    %rbx,%r15
  258f4b:	cmp    $0x1,%rbx
  258f4f:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f51:	cmpb   $0x1,0x1de(%rsp)
  258f59:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f5b:	cmpq   $0x0,0x158(%rsp)
  258f64:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f66:	mov    0x198(%rsp),%rcx
  258f6e:	testb  $0x4,0x6c5(%rcx)
  258f75:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f77:	cmpq   $0x0,0x50(%rcx)
  258f7c:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f7e:	movzwl 0x64(%rcx),%eax
  258f82:	test   $0x460,%eax
  258f87:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f89:	cmpb   $0x0,0x68(%rcx)
  258f8d:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f8f:	cmpb   $0x0,0x69(%rcx)
  258f93:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f95:	cmpb   $0x0,0x6a(%rcx)
  258f99:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  258f9b:	cmpb   $0x0,0x6b(%rcx)
  258f9f:	je     259597 <<glass::engine::Engine>::apply+0x13b7>
  258fa5:	lea    0x120(%rsp),%rdi
  258fad:	mov    %r12,%rsi
  258fb0:	mov    %r15,%rdx
  258fb3:	call   264760 <<glass::engine::Watch>::print_run>
  258fb8:	mov    %rax,%r12
  258fbb:	mov    0x39adff(%rip),%eax        # 5f3dc0 <glass::engine::run_whole::ON>
  258fc1:	test   %eax,%eax
  258fc3:	jne    259d8a <<glass::engine::Engine>::apply+0x1baa>
  258fc9:	cmpb   $0x0,0x39adf4(%rip)        # 5f3dc4 <glass::engine::run_whole::ON+0x4>
  258fd0:	je     259029 <<glass::engine::Engine>::apply+0xe49>
  258fd2:	mov    0x1d0(%rsp),%eax
  258fd9:	mov    0x10(%rsp),%rcx
  258fde:	mov    %eax,0x718(%rcx)
  258fe4:	add    0xf8(%rsp),%r12
  258fec:	mov    0xc8(%rsp),%ebx
  258ff3:	mov    %rbp,%r15
  258ff6:	sub    %r12,%r15
  258ff9:	ja     259040 <<glass::engine::Engine>::apply+0xe60>
  258ffb:	mov    0x40(%rsp),%r15
  259000:	mov    0xe8(%rsp),%ecx
  259007:	cmpb   $0x0,0x30(%rsp)
  25900c:	jne    25910c <<glass::engine::Engine>::apply+0xf2c>
  259012:	mov    0x10(%rsp),%rax
  259017:	cmpb   $0xd,0x8c9(%rax)
  25901e:	je     2590f9 <<glass::engine::Engine>::apply+0xf19>
  259024:	jmp    259150 <<glass::engine::Engine>::apply+0xf70>
  259029:	add    0xf8(%rsp),%r12
  259031:	mov    0xc8(%rsp),%ebx
  259038:	mov    %rbp,%r15
  25903b:	sub    %r12,%r15
  25903e:	jbe    258ffb <<glass::engine::Engine>::apply+0xe1b>
  259040:	add    0x40(%rsp),%r12
  259045:	xor    %r13d,%r13d
  259048:	nopl   0x0(%rax,%rax,1)
  259050:	mov    0x10(%rsp),%rax
  259055:	cmpl   $0xffffffff,0x710(%rax)
  25905c:	jne    2590b2 <<glass::engine::Engine>::apply+0xed2>
  25905e:	mov    0x48(%rsp),%rax
  259063:	mov    %rax,0xa0(%rsp)
  25906b:	lea    0x120(%rsp),%rax
  259073:	mov    %rax,0xa8(%rsp)
  25907b:	movb   $0x0,0xb0(%rsp)
  259083:	mov    %r15,%rcx
  259086:	sub    %r13,%rcx
  259089:	jb     25a194 <<glass::engine::Engine>::apply+0x1fb4>
  25908f:	lea    (%r12,%r13,1),%rdx
  259093:	mov    0xd0(%rsp),%rdi
  25909b:	lea    0xa0(%rsp),%rsi
  2590a3:	call   1a0530 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  2590a8:	add    %rax,%r13
  2590ab:	cmp    %r15,%r13
  2590ae:	jne    259050 <<glass::engine::Engine>::apply+0xe70>
  2590b0:	jmp    2590d6 <<glass::engine::Engine>::apply+0xef6>
  2590b2:	mov    %r15,%rcx
  2590b5:	sub    %r13,%rcx
  2590b8:	jb     25a222 <<glass::engine::Engine>::apply+0x2042>
  2590be:	lea    (%r12,%r13,1),%rdx
  2590c2:	mov    0x48(%rsp),%rdi
  2590c7:	lea    0x120(%rsp),%rsi
  2590cf:	call   194290 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  2590d4:	jmp    2590a8 <<glass::engine::Engine>::apply+0xec8>
  2590d6:	mov    %rbp,%r12
  2590d9:	mov    0x40(%rsp),%r15
  2590de:	mov    $0x1,%r13d
  2590e4:	mov    0xe8(%rsp),%ecx
  2590eb:	mov    0x10(%rsp),%rax
  2590f0:	cmpb   $0xd,0x8c9(%rax)
  2590f7:	jne    259150 <<glass::engine::Engine>::apply+0xf70>
  2590f9:	cmpq   $0x0,0x8b8(%rax)
  259101:	jne    259150 <<glass::engine::Engine>::apply+0xf70>
  259103:	cmpl   $0xffffffff,0x710(%rax)
  25910a:	jne    259150 <<glass::engine::Engine>::apply+0xf70>
  25910c:	test   %bl,%bl
  25910e:	je     259160 <<glass::engine::Engine>::apply+0xf80>
  259110:	mov    0x1d0(%rsp),%ebx
  259117:	cmp    $0xffffffff,%ebx
  25911a:	je     259545 <<glass::engine::Engine>::apply+0x1365>
  259120:	mov    0x60(%rsp),%r14d
  259125:	cmp    $0x1,%r14w
  25912a:	adc    $0x0,%r14d
  25912e:	xchg   %ax,%ax
  259130:	lea    0x120(%rsp),%rdi
  259138:	mov    %ebx,%esi
  25913a:	call   33c830 <<glass::engine::Watch as vte::ansi::Handler>::input>
  25913f:	dec    %r14w
  259143:	jne    259130 <<glass::engine::Engine>::apply+0xf50>
  259145:	jmp    2585f7 <<glass::engine::Engine>::apply+0x417>
  25914a:	nopw   0x0(%rax,%rax,1)
  259150:	movl   $0x0,0x30(%rsp)
  259158:	add    %rbp,%r13
  25915b:	jmp    258623 <<glass::engine::Engine>::apply+0x443>
  259160:	test   %cl,%cl
  259162:	jne    2585b3 <<glass::engine::Engine>::apply+0x3d3>
  259168:	mov    0x198(%rsp),%r12
  259170:	xor    %eax,%eax
  259172:	jmp    2591a0 <<glass::engine::Engine>::apply+0xfc0>
  259174:	mov    $0x17,%cx
  259178:	mov    $0x1010000,%esi
  25917d:	nopl   (%rax)
  259180:	movzwl %cx,%eax
  259183:	shl    $0x10,%rsi
  259187:	or     %rax,%rsi
  25918a:	mov    %r12,%rdi
  25918d:	call   34a2f0 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  259192:	mov    %rbx,%rax
  259195:	cmp    0x8(%rsp),%rbx
  25919a:	ja     2585f7 <<glass::engine::Engine>::apply+0x417>
  2591a0:	movzwl 0x60(%rsp,%rax,2),%ecx
  2591a5:	lea    0x1(%rax),%rbx
  2591a9:	cmp    $0x3b,%rcx
  2591ad:	ja     259422 <<glass::engine::Engine>::apply+0x1242>
  2591b3:	lea    -0x1ea982(%rip),%rsi        # 6e838 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2e07>
  2591ba:	movslq (%rsi,%rcx,4),%rdx
  2591be:	add    %rsi,%rdx
  2591c1:	jmp    *%rdx
  2591c3:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  2591c5:	cmp    0x8(%rsp),%rax
  2591ca:	jae    259192 <<glass::engine::Engine>::apply+0xfb2>
  2591cc:	movzwl 0x62(%rsp,%rax,2),%ecx
  2591d1:	lea    0x2(%rax),%rbx
  2591d5:	cmp    $0x5,%ecx
  2591d8:	je     259486 <<glass::engine::Engine>::apply+0x12a6>
  2591de:	cmp    $0x2,%ecx
  2591e1:	jne    259192 <<glass::engine::Engine>::apply+0xfb2>
  2591e3:	cmp    0x8(%rsp),%rbx
  2591e8:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2591ea:	movzwl 0x64(%rsp,%rax,2),%ecx
  2591ef:	lea    0x3(%rax),%rbx
  2591f3:	cmp    $0xff,%ecx
  2591f9:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2591fb:	cmp    0x8(%rsp),%rbx
  259200:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  259202:	movzwl 0x66(%rsp,%rax,2),%edx
  259207:	lea    0x4(%rax),%rbx
  25920b:	cmp    $0xff,%edx
  259211:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  259217:	cmp    0x8(%rsp),%rbx
  25921c:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  259222:	movzwl 0x68(%rsp,%rax,2),%edi
  259227:	add    $0x5,%rax
  25922b:	cmp    $0xff,%edi
  259231:	ja     259506 <<glass::engine::Engine>::apply+0x1326>
  259237:	shl    $0x10,%edi
  25923a:	movzwl %dx,%edx
  25923d:	shl    $0x8,%edx
  259240:	or     %edx,%ecx
  259242:	movzwl %cx,%esi
  259245:	or     %edi,%esi
  259247:	mov    $0x1,%ecx
  25924c:	jmp    2594a7 <<glass::engine::Engine>::apply+0x12c7>
  259251:	mov    $0x11,%cx
  259255:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  25925a:	mov    $0xc,%cx
  25925e:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259263:	mov    $0xa,%cx
  259267:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  25926c:	mov    $0x18,%cx
  259270:	mov    $0xff,%esi
  259275:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  25927a:	mov    $0xe,%cx
  25927e:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259283:	cmp    0x8(%rsp),%rax
  259288:	jae    259192 <<glass::engine::Engine>::apply+0xfb2>
  25928e:	movzwl 0x62(%rsp,%rax,2),%ecx
  259293:	lea    0x2(%rax),%rbx
  259297:	cmp    $0x5,%ecx
  25929a:	je     2594b8 <<glass::engine::Engine>::apply+0x12d8>
  2592a0:	cmp    $0x2,%ecx
  2592a3:	jne    259192 <<glass::engine::Engine>::apply+0xfb2>
  2592a9:	cmp    0x8(%rsp),%rbx
  2592ae:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2592b4:	movzwl 0x64(%rsp,%rax,2),%ecx
  2592b9:	lea    0x3(%rax),%rbx
  2592bd:	cmp    $0xff,%ecx
  2592c3:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2592c9:	cmp    0x8(%rsp),%rbx
  2592ce:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2592d4:	movzwl 0x66(%rsp,%rax,2),%edx
  2592d9:	lea    0x4(%rax),%rbx
  2592dd:	cmp    $0xff,%edx
  2592e3:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2592e9:	cmp    0x8(%rsp),%rbx
  2592ee:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2592f4:	movzwl 0x68(%rsp,%rax,2),%edi
  2592f9:	add    $0x5,%rax
  2592fd:	cmp    $0xff,%edi
  259303:	ja     259506 <<glass::engine::Engine>::apply+0x1326>
  259309:	shl    $0x10,%edi
  25930c:	movzwl %dx,%edx
  25930f:	shl    $0x8,%edx
  259312:	or     %edx,%ecx
  259314:	movzwl %cx,%esi
  259317:	or     %edi,%esi
  259319:	mov    $0x1,%ecx
  25931e:	jmp    2594d9 <<glass::engine::Engine>::apply+0x12f9>
  259323:	mov    $0x10,%cx
  259327:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  25932c:	mov    $0x16,%cx
  259330:	mov    $0x1000000,%esi
  259335:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  25933a:	mov    $0xf,%cx
  25933e:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259343:	mov    $0x9,%cx
  259347:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  25934c:	mov    $0x12,%cx
  259350:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259355:	mov    $0x13,%cx
  259359:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  25935e:	mov    $0xb,%cx
  259362:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259367:	mov    $0xd,%cx
  25936b:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259370:	mov    $0x15,%cx
  259374:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259379:	mov    $0x14,%cx
  25937d:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259382:	cmp    0x8(%rsp),%rax
  259387:	jae    259192 <<glass::engine::Engine>::apply+0xfb2>
  25938d:	movzwl 0x62(%rsp,%rax,2),%ecx
  259392:	lea    0x2(%rax),%rbx
  259396:	cmp    $0x5,%ecx
  259399:	je     2594ea <<glass::engine::Engine>::apply+0x130a>
  25939f:	cmp    $0x2,%ecx
  2593a2:	jne    259192 <<glass::engine::Engine>::apply+0xfb2>
  2593a8:	cmp    0x8(%rsp),%rbx
  2593ad:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2593b3:	movzwl 0x64(%rsp,%rax,2),%ecx
  2593b8:	lea    0x3(%rax),%rbx
  2593bc:	cmp    $0xff,%ecx
  2593c2:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2593c8:	cmp    0x8(%rsp),%rbx
  2593cd:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2593d3:	movzwl 0x66(%rsp,%rax,2),%edx
  2593d8:	lea    0x4(%rax),%rbx
  2593dc:	cmp    $0xff,%edx
  2593e2:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2593e8:	cmp    0x8(%rsp),%rbx
  2593ed:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2593f3:	movzwl 0x68(%rsp,%rax,2),%edi
  2593f8:	add    $0x5,%rax
  2593fc:	cmp    $0xff,%edi
  259402:	ja     259506 <<glass::engine::Engine>::apply+0x1326>
  259408:	shl    $0x10,%edi
  25940b:	movzwl %dx,%edx
  25940e:	shl    $0x8,%edx
  259411:	or     %edx,%ecx
  259413:	movzwl %cx,%esi
  259416:	or     %edi,%esi
  259418:	mov    $0x1,%ecx
  25941d:	jmp    259534 <<glass::engine::Engine>::apply+0x1354>
  259422:	lea    -0x1e(%rcx),%eax
  259425:	cmp    $0x8,%ax
  259429:	jae    259443 <<glass::engine::Engine>::apply+0x1263>
  25942b:	lea    -0x1fe142(%rip),%rax        # 5b2f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.8409604262742718139+0x960>
  259432:	movzwl -0x3c(%rax,%rcx,2),%esi
  259437:	shl    $0x10,%esi
  25943a:	mov    $0x16,%cx
  25943e:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259443:	mov    %ecx,%eax
  259445:	and    $0xfff8,%eax
  25944a:	cmp    $0x28,%ax
  25944e:	jne    259468 <<glass::engine::Engine>::apply+0x1288>
  259450:	lea    -0x1fe167(%rip),%rax        # 5b2f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.8409604262742718139+0x960>
  259457:	movzwl -0x50(%rax,%rcx,2),%esi
  25945c:	shl    $0x10,%esi
  25945f:	mov    $0x17,%cx
  259463:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259468:	lea    -0x5a(%rcx),%eax
  25946b:	cmp    $0x8,%ax
  25946f:	jae    25950e <<glass::engine::Engine>::apply+0x132e>
  259475:	lea    -0x1fc57c(%rip),%rax        # 5cf00 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.8409604262742718139+0xd0>
  25947c:	movzwl -0xb4(%rax,%rcx,2),%esi
  259484:	jmp    259437 <<glass::engine::Engine>::apply+0x1257>
  259486:	cmp    0x8(%rsp),%rbx
  25948b:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  259491:	movzwl 0x64(%rsp,%rax,2),%esi
  259496:	add    $0x3,%rax
  25949a:	cmp    $0xff,%esi
  2594a0:	ja     259506 <<glass::engine::Engine>::apply+0x1326>
  2594a2:	mov    $0x2,%ecx
  2594a7:	shl    $0x8,%esi
  2594aa:	or     %ecx,%esi
  2594ac:	mov    $0x16,%cx
  2594b0:	mov    %rax,%rbx
  2594b3:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  2594b8:	cmp    0x8(%rsp),%rbx
  2594bd:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2594c3:	movzwl 0x64(%rsp,%rax,2),%esi
  2594c8:	add    $0x3,%rax
  2594cc:	cmp    $0xff,%esi
  2594d2:	ja     259506 <<glass::engine::Engine>::apply+0x1326>
  2594d4:	mov    $0x2,%ecx
  2594d9:	shl    $0x8,%esi
  2594dc:	or     %ecx,%esi
  2594de:	mov    $0x18,%cx
  2594e2:	mov    %rax,%rbx
  2594e5:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  2594ea:	cmp    0x8(%rsp),%rbx
  2594ef:	ja     259192 <<glass::engine::Engine>::apply+0xfb2>
  2594f5:	movzwl 0x64(%rsp,%rax,2),%esi
  2594fa:	add    $0x3,%rax
  2594fe:	cmp    $0xff,%esi
  259504:	jbe    25952f <<glass::engine::Engine>::apply+0x134f>
  259506:	mov    %rax,%rbx
  259509:	jmp    259192 <<glass::engine::Engine>::apply+0xfb2>
  25950e:	lea    -0x64(%rcx),%eax
  259511:	cmp    $0x8,%ax
  259515:	jae    259192 <<glass::engine::Engine>::apply+0xfb2>
  25951b:	lea    -0x1fc622(%rip),%rax        # 5cf00 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.8409604262742718139+0xd0>
  259522:	movzwl -0xc8(%rax,%rcx,2),%esi
  25952a:	jmp    25945c <<glass::engine::Engine>::apply+0x127c>
  25952f:	mov    $0x2,%ecx
  259534:	shl    $0x8,%esi
  259537:	or     %ecx,%esi
  259539:	mov    $0x17,%cx
  25953d:	mov    %rax,%rbx
  259540:	jmp    259180 <<glass::engine::Engine>::apply+0xfa0>
  259545:	mov    $0x1,%r14b
  259548:	mov    $0x1,%al
  25954a:	mov    %eax,0x30(%rsp)
  25954e:	mov    %r12,0xf8(%rsp)
  259556:	mov    0x28(%rsp),%r13
  25955b:	add    %rbp,%r13
  25955e:	jmp    258623 <<glass::engine::Engine>::apply+0x443>
  259563:	mov    0xf8(%rsp),%r12
  25956b:	mov    0xc8(%rsp),%ebx
  259572:	mov    %rbp,%r15
  259575:	sub    %r12,%r15
  259578:	ja     259040 <<glass::engine::Engine>::apply+0xe60>
  25957e:	jmp    258ffb <<glass::engine::Engine>::apply+0xe1b>
  259583:	call   18b8c6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259588:	jmp    258eea <<glass::engine::Engine>::apply+0xd0a>
  25958d:	call   18b8c6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259592:	jmp    258f37 <<glass::engine::Engine>::apply+0xd57>
  259597:	mov    %rcx,0x118(%rsp)
  25959f:	movzbl (%r12),%eax
  2595a4:	mov    %rax,0x110(%rsp)
  2595ac:	add    $0xffffffe0,%eax
  2595af:	mov    $0x1,%ecx
  2595b4:	mov    %rcx,0x90(%rsp)
  2595bc:	cmp    $0x5f,%al
  2595be:	jb     2595f8 <<glass::engine::Engine>::apply+0x1418>
  2595c0:	mov    0x110(%rsp),%rdi
  2595c8:	call   2a14b0 <glass::engine::width_of>
  2595cd:	mov    %rdx,0x90(%rsp)
  2595d5:	mov    $0x1,%r13d
  2595db:	mov    0x90(%rsp),%rcx
  2595e3:	dec    %rcx
  2595e6:	cmp    $0x2,%rcx
  2595ea:	setb   %cl
  2595ed:	and    %al,%cl
  2595ef:	cmp    $0x1,%cl
  2595f2:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  2595f8:	mov    0x118(%rsp),%rax
  259600:	cmpb   $0x0,0x6c(%rax)
  259604:	mov    $0x1,%r13d
  25960a:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  259610:	mov    0x40(%rax),%rsi
  259614:	mov    0xa0(%rax),%rdx
  25961b:	mov    %rsi,0x20(%rsp)
  259620:	mov    0x90(%rsp),%rcx
  259628:	add    %rsi,%rcx
  25962b:	mov    %rcx,0x108(%rsp)
  259633:	mov    %rdx,0x218(%rsp)
  25963b:	cmp    %rdx,%rcx
  25963e:	ja     258fa5 <<glass::engine::Engine>::apply+0xdc5>
  259644:	lea    0x10(%rax),%rdi
  259648:	mov    0x48(%rax),%esi
  25964b:	mov    0x58(%rax),%ecx
  25964e:	mov    %ecx,0xe0(%rsp)
  259655:	mov    0x5c(%rax),%ecx
  259658:	mov    %ecx,0xdc(%rsp)
  25965f:	movzwl 0x64(%rax),%eax
  259663:	mov    %eax,0xe4(%rsp)
  25966a:	lea    0x36ebd7(%rip),%rdx        # 5c8248 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15588>
  259671:	call   30ae40 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  259676:	mov    %rax,%rcx
  259679:	add    $0x18,%rcx
  25967d:	mov    %rcx,0xf0(%rsp)
  259685:	mov    %rax,(%rsp)
  259689:	mov    0x28(%rax),%eax
  25968c:	cmp    $0xffffffff,%eax
  25968f:	je     2596a8 <<glass::engine::Engine>::apply+0x14c8>
  259691:	mov    0xf0(%rsp),%rcx
  259699:	mov    0x20(%rsp),%rdx
  25969e:	mov    (%rsp),%rsi
  2596a2:	cmp    0x30(%rsi),%rdx
  2596a6:	jae    2596d0 <<glass::engine::Engine>::apply+0x14f0>
  2596a8:	mov    (%rsp),%rcx
  2596ac:	mov    0x10(%rcx),%rsi
  2596b0:	cmp    %rsi,0x20(%rsp)
  2596b5:	jae    25a22d <<glass::engine::Engine>::apply+0x204d>
  2596bb:	mov    0x20(%rsp),%rcx
  2596c0:	lea    (%rcx,%rcx,2),%rcx
  2596c4:	shl    $0x3,%rcx
  2596c8:	mov    (%rsp),%rdx
  2596cc:	add    0x8(%rdx),%rcx
  2596d0:	testb  $0x60,0x14(%rcx)
  2596d4:	mov    $0x1,%r13d
  2596da:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  2596e0:	cmpq   $0x2,0x90(%rsp)
  2596e9:	jne    259736 <<glass::engine::Engine>::apply+0x1556>
  2596eb:	mov    0x20(%rsp),%rcx
  2596f0:	lea    0x1(%rcx),%r10
  2596f4:	cmp    $0xffffffff,%eax
  2596f7:	je     25970b <<glass::engine::Engine>::apply+0x152b>
  2596f9:	mov    0xf0(%rsp),%rdx
  259701:	mov    (%rsp),%rsi
  259705:	cmp    0x30(%rsi),%r10
  259709:	jae    25972c <<glass::engine::Engine>::apply+0x154c>
  25970b:	mov    (%rsp),%rdx
  25970f:	mov    0x10(%rdx),%rsi
  259713:	cmp    %rsi,%r10
  259716:	jae    25a232 <<glass::engine::Engine>::apply+0x2052>
  25971c:	lea    (%r10,%r10,2),%rdx
  259720:	shl    $0x3,%rdx
  259724:	mov    (%rsp),%rcx
  259728:	add    0x8(%rcx),%rdx
  25972c:	testb  $0x60,0x14(%rdx)
  259730:	jne    258fa5 <<glass::engine::Engine>::apply+0xdc5>
  259736:	mov    0x20(%rsp),%rcx
  25973b:	mov    (%rsp),%rdx
  25973f:	cmp    %ecx,0x38(%rdx)
  259742:	jbe    259750 <<glass::engine::Engine>::apply+0x1570>
  259744:	mov    0x20(%rsp),%rcx
  259749:	mov    (%rsp),%rdx
  25974d:	mov    %ecx,0x38(%rdx)
  259750:	cmp    $0xffffffff,%eax
  259753:	setne  %cl
  259756:	mov    (%rsp),%rdx
  25975a:	mov    0x30(%rdx),%r15
  25975e:	cmp    %r15,0x20(%rsp)
  259763:	sete   %dl
  259766:	test   %dl,%cl
  259768:	jne    259853 <<glass::engine::Engine>::apply+0x1673>
  25976e:	cmp    $0xffffffff,%eax
  259771:	je     25998e <<glass::engine::Engine>::apply+0x17ae>
  259777:	mov    (%rsp),%rax
  25977b:	mov    0x10(%rax),%r12
  25977f:	cmp    %r15,%r12
  259782:	mov    %r15,%rax
  259785:	cmovb  %r12,%rax
  259789:	mov    %rax,0x50(%rsp)
  25978e:	mov    0x20(%rsp),%rbx
  259793:	cmp    %rbx,%r12
  259796:	cmovb  %r12,%rbx
  25979a:	mov    0x39775f(%rip),%rax        # 5f0f00 <_DYNAMIC+0x320>
  2597a1:	movzbl (%rax),%eax
  2597a4:	test   %al,%al
  2597a6:	je     2597cd <<glass::engine::Engine>::apply+0x15ed>
  2597a8:	mov    0x397789(%rip),%rax        # 5f0f38 <_DYNAMIC+0x358>
  2597af:	cmp    %rbx,%r15
  2597b2:	jae    2597bb <<glass::engine::Engine>::apply+0x15db>
  2597b4:	mov    0x397785(%rip),%rax        # 5f0f40 <_DYNAMIC+0x360>
  2597bb:	lock incq 0x28(%rax)
  2597c0:	mov    %rbx,%rdi
  2597c3:	sub    0x50(%rsp),%rdi
  2597c8:	call   2f63e0 <alacritty_terminal::grid::row::fill_census::note>
  2597cd:	cmp    %rbx,%r15
  2597d0:	jae    259971 <<glass::engine::Engine>::apply+0x1791>
  2597d6:	mov    (%rsp),%rax
  2597da:	mov    0x28(%rax),%ecx
  2597dd:	mov    %ecx,0x3c(%rsp)
  2597e1:	mov    0x20(%rax),%ecx
  2597e4:	mov    %ecx,0x38(%rsp)
  2597e8:	mov    0x24(%rax),%ecx
  2597eb:	mov    %ecx,0x34(%rsp)
  2597ef:	movzwl 0x2c(%rax),%ecx
  2597f3:	mov    %cx,0x58(%rsp)
  2597f8:	mov    0x18(%rax),%r15
  2597fc:	test   %r15,%r15
  2597ff:	je     259876 <<glass::engine::Engine>::apply+0x1696>
  259801:	lock incq (%r15)
  259805:	jle    25a29a <<glass::engine::Engine>::apply+0x20ba>
  25980b:	mov    (%rsp),%rax
  25980f:	mov    0x10(%rax),%rdx
  259813:	mov    0x3c(%rsp),%eax
  259817:	mov    %eax,0xb0(%rsp)
  25981e:	mov    0x38(%rsp),%eax
  259822:	mov    %eax,0xa8(%rsp)
  259829:	mov    0x34(%rsp),%eax
  25982d:	mov    %eax,0xac(%rsp)
  259834:	movzwl 0x58(%rsp),%eax
  259839:	mov    %ax,0xb4(%rsp)
  259841:	mov    %r15,0xa0(%rsp)
  259849:	cmp    %rdx,%rbx
  25984c:	jbe    2598ac <<glass::engine::Engine>::apply+0x16cc>
  25984e:	jmp    25a23b <<glass::engine::Engine>::apply+0x205b>
  259853:	mov    0x20(%rsp),%rcx
  259858:	lea    0x1(%rcx),%rax
  25985c:	mov    (%rsp),%rdx
  259860:	mov    %rax,0x30(%rdx)
  259864:	mov    0x10(%rdx),%rsi
  259868:	cmp    %rsi,%rcx
  25986b:	jb     2599b7 <<glass::engine::Engine>::apply+0x17d7>
  259871:	jmp    25a252 <<glass::engine::Engine>::apply+0x2072>
  259876:	mov    0x3c(%rsp),%eax
  25987a:	mov    %eax,0xb0(%rsp)
  259881:	mov    0x38(%rsp),%eax
  259885:	mov    %eax,0xa8(%rsp)
  25988c:	mov    0x34(%rsp),%eax
  259890:	mov    %eax,0xac(%rsp)
  259897:	movzwl 0x58(%rsp),%eax
  25989c:	mov    %ax,0xb4(%rsp)
  2598a4:	mov    %r15,0xa0(%rsp)
  2598ac:	mov    0x50(%rsp),%rax
  2598b1:	lea    0x0(,%rax,8),%rax
  2598b9:	lea    (%rax,%rax,2),%rax
  2598bd:	mov    (%rsp),%rcx
  2598c1:	mov    0x8(%rcx),%r12
  2598c5:	add    %rax,%r12
  2598c8:	lea    0x0(,%rbx,8),%rcx
  2598d0:	lea    (%rcx,%rcx,2),%r13
  2598d4:	sub    %rax,%r13
  2598d7:	jmp    25990d <<glass::engine::Engine>::apply+0x172d>
  2598d9:	mov    %r15,(%r12)
  2598dd:	mov    0x38(%rsp),%eax
  2598e1:	mov    %eax,0x8(%r12)
  2598e6:	mov    0x34(%rsp),%eax
  2598ea:	mov    %eax,0xc(%r12)
  2598ef:	mov    0x3c(%rsp),%eax
  2598f3:	mov    %eax,0x10(%r12)
  2598f8:	movzwl 0x58(%rsp),%eax
  2598fd:	mov    %ax,0x14(%r12)
  259903:	add    $0x18,%r12
  259907:	add    $0xffffffffffffffe8,%r13
  25990b:	je     259936 <<glass::engine::Engine>::apply+0x1756>
  25990d:	test   %r15,%r15
  259910:	je     25991c <<glass::engine::Engine>::apply+0x173c>
  259912:	lock incq (%r15)
  259916:	jle    25a29a <<glass::engine::Engine>::apply+0x20ba>
  25991c:	mov    (%r12),%rax
  259920:	test   %rax,%rax
  259923:	je     2598d9 <<glass::engine::Engine>::apply+0x16f9>
  259925:	lock decq (%rax)
  259929:	jne    2598d9 <<glass::engine::Engine>::apply+0x16f9>
  25992b:	mov    %r12,%rdi
  25992e:	call   *0x397514(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  259934:	jmp    2598d9 <<glass::engine::Engine>::apply+0x16f9>
  259936:	mov    (%rsp),%rax
  25993a:	mov    0x50(%rsp),%rcx
  25993f:	cmp    %ecx,0x38(%rax)
  259942:	jbe    259950 <<glass::engine::Engine>::apply+0x1770>
  259944:	mov    (%rsp),%rax
  259948:	mov    0x50(%rsp),%rcx
  25994d:	mov    %ecx,0x38(%rax)
  259950:	test   %r15,%r15
  259953:	je     259969 <<glass::engine::Engine>::apply+0x1789>
  259955:	lock decq (%r15)
  259959:	jne    259969 <<glass::engine::Engine>::apply+0x1789>
  25995b:	lea    0xa0(%rsp),%rdi
  259963:	call   *0x3974df(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  259969:	mov    (%rsp),%rax
  25996d:	mov    0x10(%rax),%r12
  259971:	cmp    %r12,%rbx
  259974:	jb     25998e <<glass::engine::Engine>::apply+0x17ae>
  259976:	mov    0xf0(%rsp),%rdi
  25997e:	call   1ad320 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259983:	mov    (%rsp),%rax
  259987:	movl   $0xffffffff,0x28(%rax)
  25998e:	mov    (%rsp),%rdi
  259992:	mov    0x30(%rdi),%rax
  259996:	mov    0x20(%rsp),%rdx
  25999b:	lea    0x1(%rdx),%rcx
  25999f:	cmp    %rax,%rcx
  2599a2:	cmova  %rcx,%rax
  2599a6:	mov    0x10(%rdi),%rsi
  2599aa:	mov    %rax,0x30(%rdi)
  2599ae:	cmp    %rsi,%rdx
  2599b1:	jae    25a263 <<glass::engine::Engine>::apply+0x2083>
  2599b7:	mov    0xe4(%rsp),%edi
  2599be:	mov    %edi,%eax
  2599c0:	or     $0x20,%eax
  2599c3:	cmpq   $0x2,0x90(%rsp)
  2599cc:	mov    (%rsp),%rcx
  2599d0:	mov    0x8(%rcx),%rcx
  2599d4:	mov    0x20(%rsp),%rdx
  2599d9:	lea    (%rdx,%rdx,2),%rdx
  2599dd:	lea    (%rcx,%rdx,8),%r12
  2599e1:	mov    0x110(%rsp),%rsi
  2599e9:	mov    %esi,0x10(%rcx,%rdx,8)
  2599ed:	mov    0xe0(%rsp),%esi
  2599f4:	mov    %esi,0x8(%rcx,%rdx,8)
  2599f8:	cmovne %edi,%eax
  2599fb:	mov    0xdc(%rsp),%esi
  259a02:	mov    %esi,0xc(%rcx,%rdx,8)
  259a06:	mov    %ax,0x14(%rcx,%rdx,8)
  259a0b:	mov    (%rcx,%rdx,8),%rax
  259a0f:	test   %rax,%rax
  259a12:	je     259a23 <<glass::engine::Engine>::apply+0x1843>
  259a14:	lock decq (%rax)
  259a18:	jne    259a23 <<glass::engine::Engine>::apply+0x1843>
  259a1a:	mov    %r12,%rdi
  259a1d:	call   *0x397425(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  259a23:	movq   $0x0,(%r12)
  259a2b:	cmpq   $0x2,0x90(%rsp)
  259a34:	jne    259d1f <<glass::engine::Engine>::apply+0x1b3f>
  259a3a:	mov    0x20(%rsp),%rax
  259a3f:	lea    0x1(%rax),%rbx
  259a43:	mov    (%rsp),%rax
  259a47:	mov    0x30(%rax),%r15
  259a4b:	mov    0x28(%rax),%eax
  259a4e:	cmp    %r15,%rbx
  259a51:	jne    259a7b <<glass::engine::Engine>::apply+0x189b>
  259a53:	cmp    $0xffffffff,%eax
  259a56:	je     259a7b <<glass::engine::Engine>::apply+0x189b>
  259a58:	mov    0x20(%rsp),%rax
  259a5d:	add    $0x2,%rax
  259a61:	mov    (%rsp),%rcx
  259a65:	mov    %rax,0x30(%rcx)
  259a69:	mov    0x10(%rcx),%rsi
  259a6d:	cmp    %rsi,%rbx
  259a70:	jb     259cc2 <<glass::engine::Engine>::apply+0x1ae2>
  259a76:	jmp    25a274 <<glass::engine::Engine>::apply+0x2094>
  259a7b:	cmp    $0xffffffff,%eax
  259a7e:	je     259c99 <<glass::engine::Engine>::apply+0x1ab9>
  259a84:	mov    (%rsp),%rax
  259a88:	mov    0x10(%rax),%r12
  259a8c:	cmp    %r15,%r12
  259a8f:	mov    %r15,%rax
  259a92:	cmovb  %r12,%rax
  259a96:	mov    %rax,0x50(%rsp)
  259a9b:	cmp    %rbx,%r12
  259a9e:	mov    %rbx,%rax
  259aa1:	cmovb  %r12,%rax
  259aa5:	mov    %rax,0x58(%rsp)
  259aaa:	mov    0x39744f(%rip),%rax        # 5f0f00 <_DYNAMIC+0x320>
  259ab1:	movzbl (%rax),%eax
  259ab4:	test   %al,%al
  259ab6:	je     259ae1 <<glass::engine::Engine>::apply+0x1901>
  259ab8:	mov    0x397479(%rip),%rax        # 5f0f38 <_DYNAMIC+0x358>
  259abf:	cmp    0x58(%rsp),%r15
  259ac4:	jae    259acd <<glass::engine::Engine>::apply+0x18ed>
  259ac6:	mov    0x397473(%rip),%rax        # 5f0f40 <_DYNAMIC+0x360>
  259acd:	lock incq 0x28(%rax)
  259ad2:	mov    0x58(%rsp),%rdi
  259ad7:	sub    0x50(%rsp),%rdi
  259adc:	call   2f63e0 <alacritty_terminal::grid::row::fill_census::note>
  259ae1:	cmp    0x58(%rsp),%r15
  259ae6:	jae    259c7a <<glass::engine::Engine>::apply+0x1a9a>
  259aec:	mov    (%rsp),%rax
  259af0:	mov    0x28(%rax),%ecx
  259af3:	mov    %ecx,0x90(%rsp)
  259afa:	mov    0x20(%rax),%ecx
  259afd:	mov    %ecx,0x3c(%rsp)
  259b01:	mov    0x24(%rax),%ecx
  259b04:	mov    %ecx,0x38(%rsp)
  259b08:	movzwl 0x2c(%rax),%ecx
  259b0c:	mov    %cx,0x34(%rsp)
  259b11:	mov    0x18(%rax),%r13
  259b15:	test   %r13,%r13
  259b18:	je     259b72 <<glass::engine::Engine>::apply+0x1992>
  259b1a:	lock incq 0x0(%r13)
  259b1f:	jle    25a29a <<glass::engine::Engine>::apply+0x20ba>
  259b25:	mov    (%rsp),%rax
  259b29:	mov    0x10(%rax),%rdx
  259b2d:	mov    0x90(%rsp),%eax
  259b34:	mov    %eax,0xb0(%rsp)
  259b3b:	mov    0x3c(%rsp),%eax
  259b3f:	mov    %eax,0xa8(%rsp)
  259b46:	mov    0x38(%rsp),%eax
  259b4a:	mov    %eax,0xac(%rsp)
  259b51:	movzwl 0x34(%rsp),%eax
  259b56:	mov    %ax,0xb4(%rsp)
  259b5e:	mov    %r13,0xa0(%rsp)
  259b66:	cmp    %rdx,0x58(%rsp)
  259b6b:	jbe    259bab <<glass::engine::Engine>::apply+0x19cb>
  259b6d:	jmp    25a283 <<glass::engine::Engine>::apply+0x20a3>
  259b72:	mov    0x90(%rsp),%eax
  259b79:	mov    %eax,0xb0(%rsp)
  259b80:	mov    0x3c(%rsp),%eax
  259b84:	mov    %eax,0xa8(%rsp)
  259b8b:	mov    0x38(%rsp),%eax
  259b8f:	mov    %eax,0xac(%rsp)
  259b96:	movzwl 0x34(%rsp),%eax
  259b9b:	mov    %ax,0xb4(%rsp)
  259ba3:	mov    %r13,0xa0(%rsp)
  259bab:	mov    0x50(%rsp),%rax
  259bb0:	lea    0x0(,%rax,8),%rax
  259bb8:	lea    (%rax,%rax,2),%rax
  259bbc:	mov    (%rsp),%rcx
  259bc0:	mov    0x8(%rcx),%r12
  259bc4:	add    %rax,%r12
  259bc7:	mov    0x58(%rsp),%rcx
  259bcc:	lea    0x0(,%rcx,8),%rcx
  259bd4:	lea    (%rcx,%rcx,2),%r15
  259bd8:	sub    %rax,%r15
  259bdb:	jmp    259c14 <<glass::engine::Engine>::apply+0x1a34>
  259bdd:	mov    %r13,(%r12)
  259be1:	mov    0x3c(%rsp),%eax
  259be5:	mov    %eax,0x8(%r12)
  259bea:	mov    0x38(%rsp),%eax
  259bee:	mov    %eax,0xc(%r12)
  259bf3:	mov    0x90(%rsp),%eax
  259bfa:	mov    %eax,0x10(%r12)
  259bff:	movzwl 0x34(%rsp),%eax
  259c04:	mov    %ax,0x14(%r12)
  259c0a:	add    $0x18,%r12
  259c0e:	add    $0xffffffffffffffe8,%r15
  259c12:	je     259c3e <<glass::engine::Engine>::apply+0x1a5e>
  259c14:	test   %r13,%r13
  259c17:	je     259c24 <<glass::engine::Engine>::apply+0x1a44>
  259c19:	lock incq 0x0(%r13)
  259c1e:	jle    25a29a <<glass::engine::Engine>::apply+0x20ba>
  259c24:	mov    (%r12),%rax
  259c28:	test   %rax,%rax
  259c2b:	je     259bdd <<glass::engine::Engine>::apply+0x19fd>
  259c2d:	lock decq (%rax)
  259c31:	jne    259bdd <<glass::engine::Engine>::apply+0x19fd>
  259c33:	mov    %r12,%rdi
  259c36:	call   *0x39720c(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  259c3c:	jmp    259bdd <<glass::engine::Engine>::apply+0x19fd>
  259c3e:	mov    (%rsp),%rax
  259c42:	mov    0x50(%rsp),%rcx
  259c47:	cmp    %ecx,0x38(%rax)
  259c4a:	jbe    259c58 <<glass::engine::Engine>::apply+0x1a78>
  259c4c:	mov    (%rsp),%rax
  259c50:	mov    0x50(%rsp),%rcx
  259c55:	mov    %ecx,0x38(%rax)
  259c58:	test   %r13,%r13
  259c5b:	je     259c72 <<glass::engine::Engine>::apply+0x1a92>
  259c5d:	lock decq 0x0(%r13)
  259c62:	jne    259c72 <<glass::engine::Engine>::apply+0x1a92>
  259c64:	lea    0xa0(%rsp),%rdi
  259c6c:	call   *0x3971d6(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  259c72:	mov    (%rsp),%rax
  259c76:	mov    0x10(%rax),%r12
  259c7a:	cmp    %r12,0x58(%rsp)
  259c7f:	jb     259c99 <<glass::engine::Engine>::apply+0x1ab9>
  259c81:	mov    0xf0(%rsp),%rdi
  259c89:	call   1ad320 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259c8e:	mov    (%rsp),%rax
  259c92:	movl   $0xffffffff,0x28(%rax)
  259c99:	mov    (%rsp),%rdx
  259c9d:	mov    0x30(%rdx),%rax
  259ca1:	mov    0x20(%rsp),%rcx
  259ca6:	add    $0x2,%rcx
  259caa:	cmp    %rax,%rcx
  259cad:	cmovbe %rax,%rcx
  259cb1:	mov    0x10(%rdx),%rsi
  259cb5:	mov    %rcx,0x30(%rdx)
  259cb9:	cmp    %rsi,%rbx
  259cbc:	jae    25a29c <<glass::engine::Engine>::apply+0x20bc>
  259cc2:	mov    (%rsp),%rax
  259cc6:	mov    0x8(%rax),%rax
  259cca:	lea    (%rbx,%rbx,2),%rcx
  259cce:	lea    (%rax,%rcx,8),%r12
  259cd2:	movl   $0x20,0x10(%rax,%rcx,8)
  259cda:	mov    0xe0(%rsp),%edx
  259ce1:	mov    %edx,0x8(%rax,%rcx,8)
  259ce5:	mov    0xdc(%rsp),%edx
  259cec:	mov    %edx,0xc(%rax,%rcx,8)
  259cf0:	mov    0xe4(%rsp),%edx
  259cf7:	or     $0x40,%edx
  259cfa:	mov    %dx,0x14(%rax,%rcx,8)
  259cff:	mov    (%rax,%rcx,8),%rax
  259d03:	test   %rax,%rax
  259d06:	je     259d17 <<glass::engine::Engine>::apply+0x1b37>
  259d08:	lock decq (%rax)
  259d0c:	jne    259d17 <<glass::engine::Engine>::apply+0x1b37>
  259d0e:	mov    %r12,%rdi
  259d11:	call   *0x397131(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  259d17:	movq   $0x0,(%r12)
  259d1f:	mov    0x218(%rsp),%rax
  259d27:	cmp    %rax,0x108(%rsp)
  259d2f:	jb     259d45 <<glass::engine::Engine>::apply+0x1b65>
  259d31:	decq   0x108(%rsp)
  259d39:	mov    0x118(%rsp),%rax
  259d41:	movb   $0x1,0x6c(%rax)
  259d45:	mov    0x118(%rsp),%rax
  259d4d:	mov    0x108(%rsp),%rcx
  259d55:	mov    %rcx,0x40(%rax)
  259d59:	incq   0x1c0(%rsp)
  259d61:	mov    0x110(%rsp),%rax
  259d69:	mov    %eax,0x1d0(%rsp)
  259d70:	mov    $0x1,%r12d
  259d76:	mov    $0x1,%r13d
  259d7c:	mov    0x39a03e(%rip),%eax        # 5f3dc0 <glass::engine::run_whole::ON>
  259d82:	test   %eax,%eax
  259d84:	je     258fc9 <<glass::engine::Engine>::apply+0xde9>
  259d8a:	call   18b8c6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259d8f:	jmp    258fc9 <<glass::engine::Engine>::apply+0xde9>
  259d94:	mov    0x18(%rsp),%rbx
  259d99:	sub    %r12,%rbx
  259d9c:	jbe    259dc0 <<glass::engine::Engine>::apply+0x1be0>
  259d9e:	movzbl 0x39d373(%rip),%eax        # 5f7118 <glass::engine::counters::COUNTING>
  259da5:	test   %al,%al
  259da7:	je     259db1 <<glass::engine::Engine>::apply+0x1bd1>
  259da9:	lock add %rbx,0x39d36f(%rip)        # 5f7120 <glass::engine::counters::VTE_BYTES>
  259db1:	movzbl 0x39d300(%rip),%eax        # 5f70b8 <glass::engine::probes::RUN_PROBE>
  259db8:	cmp    $0x68,%al
  259dba:	jne    259ff9 <<glass::engine::Engine>::apply+0x1e19>
  259dc0:	mov    0x1d0(%rsp),%rax
  259dc8:	mov    0x10(%rsp),%rdx
  259dcd:	mov    %rax,0xa70(%rdx)
  259dd4:	mov    0x1d8(%rsp),%eax
  259ddb:	mov    %eax,0xa78(%rdx)
  259de1:	pshufd $0x4e,0x1b0(%rsp),%xmm0
  259deb:	movdqu %xmm0,0xa60(%rdx)
  259df3:	movzbl 0x1dd(%rsp),%eax
  259dfb:	mov    %al,0xa7d(%rdx)
  259e01:	movzbl 0x1dc(%rsp),%eax
  259e09:	and    $0x1,%eax
  259e0c:	shl    $0x5,%eax
  259e0f:	mov    0x1a8(%rsp,%rax,1),%rax
  259e17:	mov    0xa58(%rdx),%rcx
  259e1e:	cmp    %rcx,%rax
  259e21:	cmova  %rax,%rcx
  259e25:	mov    %rcx,0xa58(%rdx)
  259e2c:	mov    0x130(%rsp),%r15
  259e34:	mov    0x138(%rsp),%r12
  259e3c:	mov    0x140(%rsp),%r13
  259e44:	movq   $0x0,0x130(%rsp)
  259e50:	movq   $0x8,0x138(%rsp)
  259e5c:	movq   $0x0,0x140(%rsp)
  259e68:	test   %r13,%r13
  259e6b:	je     259ecc <<glass::engine::Engine>::apply+0x1cec>
  259e6d:	mov    0x10(%rsp),%rcx
  259e72:	mov    0x8e8(%rcx),%rax
  259e79:	mov    0x8f8(%rcx),%rbx
  259e80:	sub    %rbx,%rax
  259e83:	cmp    %rax,%r13
  259e86:	ja     25a0ad <<glass::engine::Engine>::apply+0x1ecd>
  259e8c:	mov    %r13,%rax
  259e8f:	shl    $0x4,%rax
  259e93:	lea    (%rax,%rax,2),%rdx
  259e97:	lea    (%rbx,%rbx,2),%rdi
  259e9b:	shl    $0x4,%rdi
  259e9f:	mov    0x10(%rsp),%r14
  259ea4:	add    0x8f0(%r14),%rdi
  259eab:	mov    %r12,%rsi
  259eae:	call   *0x396f5c(%rip)        # 5f0e10 <memcpy@GLIBC_2.14>
  259eb4:	add    %r13,%rbx
  259eb7:	mov    %rbx,0x8f8(%r14)
  259ebe:	test   %r15,%r15
  259ec1:	je     259ecc <<glass::engine::Engine>::apply+0x1cec>
  259ec3:	mov    %r12,%rdi
  259ec6:	call   *0x396f5c(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  259ecc:	mov    0x160(%rsp),%rbx
  259ed4:	lea    0x168(%rsp),%rax
  259edc:	movups (%rax),%xmm0
  259edf:	movups 0x10(%rax),%xmm1
  259ee3:	movups 0x20(%rax),%xmm2
  259ee7:	movaps %xmm0,0x60(%rsp)
  259eec:	movaps %xmm1,0x70(%rsp)
  259ef1:	movaps %xmm2,0x80(%rsp)
  259ef9:	movq   $0xffffffffffffffff,0x160(%rsp)
  259f05:	cmp    $0xffffffffffffffff,%rbx
  259f09:	mov    0x230(%rsp),%r14
  259f11:	mov    %r12,0x28(%rsp)
  259f16:	je     259f40 <<glass::engine::Engine>::apply+0x1d60>
  259f18:	mov    0x10(%rsp),%rax
  259f1d:	cmpq   $0x0,0x998(%rax)
  259f25:	jle    259f47 <<glass::engine::Engine>::apply+0x1d67>
  259f27:	mov    (%r14),%rdi
  259f2a:	call   *0x396ef8(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  259f30:	cmpq   $0x0,0x160(%rsp)
  259f39:	setg   %bpl
  259f3d:	jmp    259f49 <<glass::engine::Engine>::apply+0x1d69>
  259f3f:	nop
  259f40:	mov    %r15,%r12
  259f43:	xor    %ebp,%ebp
  259f45:	jmp    259f78 <<glass::engine::Engine>::apply+0x1d98>
  259f47:	xor    %ebp,%ebp
  259f49:	mov    %r15,%r12
  259f4c:	mov    0x10(%rsp),%rax
  259f51:	mov    %rbx,0x998(%rax)
  259f58:	movaps 0x60(%rsp),%xmm0
  259f5d:	movaps 0x70(%rsp),%xmm1
  259f62:	movaps 0x80(%rsp),%xmm2
  259f6a:	movups %xmm2,0x20(%r14)
  259f6f:	movups %xmm1,0x10(%r14)
  259f74:	movups %xmm0,(%r14)
  259f78:	mov    0x148(%rsp),%r15
  259f80:	mov    0x150(%rsp),%r14
  259f88:	mov    0x168(%rsp),%rbx
  259f90:	cmpq   $0x0,0x130(%rsp)
  259f99:	je     259fa9 <<glass::engine::Engine>::apply+0x1dc9>
  259f9b:	mov    0x138(%rsp),%rdi
  259fa3:	call   *0x396e7f(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  259fa9:	test   %r15,%r15
  259fac:	je     259fb7 <<glass::engine::Engine>::apply+0x1dd7>
  259fae:	mov    %r14,%rdi
  259fb1:	call   *0x396e71(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  259fb7:	test   %bpl,%bpl
  259fba:	je     259fc5 <<glass::engine::Engine>::apply+0x1de5>
  259fbc:	mov    %rbx,%rdi
  259fbf:	call   *0x396e63(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  259fc5:	mov    0x10(%rsp),%rdi
  259fca:	mov    0x28(%rsp),%r14
  259fcf:	call   257450 <<glass::engine::Engine>::fold_sentinel>
  259fd4:	test   %r13,%r13
  259fd7:	setne  %al
  259fda:	test   %r12,%r12
  259fdd:	sete   %cl
  259fe0:	or     %al,%cl
  259fe2:	cmp    $0x1,%cl
  259fe5:	je     2582d0 <<glass::engine::Engine>::apply+0xf0>
  259feb:	mov    %r14,%rdi
  259fee:	call   *0x396e34(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  259ff4:	jmp    2582d0 <<glass::engine::Engine>::apply+0xf0>
  259ff9:	add    %r12,%r15
  259ffc:	cmp    $0x1,%r14b
  25a000:	jne    25a02b <<glass::engine::Engine>::apply+0x1e4b>
  25a002:	mov    0x10(%rsp),%rax
  25a007:	cmpl   $0xffffffff,0x710(%rax)
  25a00e:	jne    25a02b <<glass::engine::Engine>::apply+0x1e4b>
  25a010:	lea    0x120(%rsp),%rdi
  25a018:	mov    %r15,%rsi
  25a01b:	mov    %rbx,%rdx
  25a01e:	call   2a10f0 <glass::engine::plain_c0>
  25a023:	test   %al,%al
  25a025:	jne    259dc0 <<glass::engine::Engine>::apply+0x1be0>
  25a02b:	xor    %r12d,%r12d
  25a02e:	xchg   %ax,%ax
  25a030:	mov    0x10(%rsp),%rax
  25a035:	cmpl   $0xffffffff,0x710(%rax)
  25a03c:	jne    25a089 <<glass::engine::Engine>::apply+0x1ea9>
  25a03e:	mov    0x48(%rsp),%rax
  25a043:	mov    %rax,0x60(%rsp)
  25a048:	lea    0x120(%rsp),%rax
  25a050:	mov    %rax,0x68(%rsp)
  25a055:	movb   $0x0,0x70(%rsp)
  25a05a:	mov    %rbx,%rcx
  25a05d:	sub    %r12,%rcx
  25a060:	jb     25a0ee <<glass::engine::Engine>::apply+0x1f0e>
  25a066:	lea    (%r15,%r12,1),%rdx
  25a06a:	mov    0xd0(%rsp),%rdi
  25a072:	lea    0x60(%rsp),%rsi
  25a077:	call   1a0530 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a07c:	add    %rax,%r12
  25a07f:	cmp    %rbx,%r12
  25a082:	jne    25a030 <<glass::engine::Engine>::apply+0x1e50>
  25a084:	jmp    259dc0 <<glass::engine::Engine>::apply+0x1be0>
  25a089:	mov    %rbx,%rcx
  25a08c:	sub    %r12,%rcx
  25a08f:	jb     25a1e1 <<glass::engine::Engine>::apply+0x2001>
  25a095:	lea    (%r15,%r12,1),%rdx
  25a099:	mov    0x48(%rsp),%rdi
  25a09e:	lea    0x120(%rsp),%rsi
  25a0a6:	call   194290 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a0ab:	jmp    25a07c <<glass::engine::Engine>::apply+0x1e9c>
  25a0ad:	mov    $0x8,%ecx
  25a0b2:	mov    $0x30,%r8d
  25a0b8:	mov    0x220(%rsp),%rdi
  25a0c0:	mov    %rbx,%rsi
  25a0c3:	mov    %r13,%rdx
  25a0c6:	call   1cf830 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  25a0cb:	mov    0x10(%rsp),%rax
  25a0d0:	mov    0x8f8(%rax),%rbx
  25a0d7:	jmp    259e8c <<glass::engine::Engine>::apply+0x1cac>
  25a0dc:	add    $0x248,%rsp
  25a0e3:	pop    %rbx
  25a0e4:	pop    %r12
  25a0e6:	pop    %r13
  25a0e8:	pop    %r14
  25a0ea:	pop    %r15
  25a0ec:	pop    %rbp
  25a0ed:	ret
  25a0ee:	mov    %rbx,%rsi
  25a0f1:	mov    %rbx,%rdx
  25a0f4:	jmp    25a104 <<glass::engine::Engine>::apply+0x1f24>
  25a0f6:	mov    %r13,%r12
  25a0f9:	jmp    25a0fe <<glass::engine::Engine>::apply+0x1f1e>
  25a0fb:	mov    %r14,%r12
  25a0fe:	mov    %rbp,%rsi
  25a101:	mov    %rbp,%rdx
  25a104:	lea    0x35942d(%rip),%rcx        # 5b3538 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25a10b:	mov    %r12,%rdi
  25a10e:	call   *0x396ea4(%rip)        # 5f0fb8 <_DYNAMIC+0x3d8>
  25a114:	jmp    25a29a <<glass::engine::Engine>::apply+0x20ba>
  25a119:	mov    %rsi,%rdx
  25a11c:	mov    %r13,%r12
  25a11f:	mov    %rbx,%rsi
  25a122:	lea    0x37072f(%rip),%rcx        # 5ca858 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17b98>
  25a129:	jmp    25a10b <<glass::engine::Engine>::apply+0x1f2b>
  25a12b:	mov    %rbx,%r12
  25a12e:	lea    0x37070b(%rip),%rcx        # 5ca840 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17b80>
  25a135:	jmp    25a10b <<glass::engine::Engine>::apply+0x1f2b>
  25a137:	mov    %rbx,%r12
  25a13a:	mov    0x28(%rsp),%rsi
  25a13f:	lea    0x3706fa(%rip),%rcx        # 5ca840 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17b80>
  25a146:	mov    0x18(%rsp),%rdx
  25a14b:	jmp    25a10b <<glass::engine::Engine>::apply+0x1f2b>
  25a14d:	mov    0x18(%rsp),%rdx
  25a152:	mov    %rdx,%rsi
  25a155:	jmp    25a104 <<glass::engine::Engine>::apply+0x1f24>
  25a157:	mov    %rbx,%rsi
  25a15a:	lea    0x37070f(%rip),%rcx        # 5ca870 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bb0>
  25a161:	mov    0x18(%rsp),%rdx
  25a166:	jmp    25a10b <<glass::engine::Engine>::apply+0x1f2b>
  25a168:	mov    %rdx,%rsi
  25a16b:	lea    0x370716(%rip),%rcx        # 5ca888 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bc8>
  25a172:	xor    %r12d,%r12d
  25a175:	mov    0x18(%rsp),%rdx
  25a17a:	jmp    25a10b <<glass::engine::Engine>::apply+0x1f2b>
  25a17c:	mov    $0xffffffffffffffff,%rsi
  25a183:	xor    %r12d,%r12d
  25a186:	xor    %edx,%edx
  25a188:	lea    0x370699(%rip),%rcx        # 5ca828 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17b68>
  25a18f:	jmp    25a10b <<glass::engine::Engine>::apply+0x1f2b>
  25a194:	mov    %r13,%r12
  25a197:	mov    %r15,%rsi
  25a19a:	mov    %r15,%rdx
  25a19d:	jmp    25a104 <<glass::engine::Engine>::apply+0x1f24>
  25a1a2:	mov    $0x8,%edi
  25a1a7:	mov    %r14,%rsi
  25a1aa:	call   *0x396c38(%rip)        # 5f0de8 <_DYNAMIC+0x208>
  25a1b0:	mov    $0x10,%esi
  25a1b5:	mov    $0xffffffffffffffff,%r10
  25a1bc:	lea    0x3706dd(%rip),%rax        # 5ca8a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17be0>
  25a1c3:	mov    %rax,0x98(%rsp)
  25a1cb:	mov    %r10,%rdi
  25a1ce:	mov    0x98(%rsp),%rdx
  25a1d6:	call   *0x396c1c(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  25a1dc:	jmp    25a29a <<glass::engine::Engine>::apply+0x20ba>
  25a1e1:	mov    %rbx,%rsi
  25a1e4:	mov    %rbx,%rdx
  25a1e7:	jmp    25a1f7 <<glass::engine::Engine>::apply+0x2017>
  25a1e9:	mov    %r13,%r12
  25a1ec:	jmp    25a1f1 <<glass::engine::Engine>::apply+0x2011>
  25a1ee:	mov    %r14,%r12
  25a1f1:	mov    %rbp,%rsi
  25a1f4:	mov    %rbp,%rdx
  25a1f7:	lea    0x359352(%rip),%rcx        # 5b3550 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25a1fe:	jmp    25a10b <<glass::engine::Engine>::apply+0x1f2b>
  25a203:	mov    $0x10,%esi
  25a208:	jmp    25a1cb <<glass::engine::Engine>::apply+0x1feb>
  25a20a:	mov    $0x10,%esi
  25a20f:	lea    0x3706ba(%rip),%rax        # 5ca8d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c10>
  25a216:	jmp    25a1c3 <<glass::engine::Engine>::apply+0x1fe3>
  25a218:	mov    0x18(%rsp),%rdx
  25a21d:	mov    %rdx,%rsi
  25a220:	jmp    25a1f7 <<glass::engine::Engine>::apply+0x2017>
  25a222:	mov    %r13,%r12
  25a225:	mov    %r15,%rsi
  25a228:	mov    %r15,%rdx
  25a22b:	jmp    25a1f7 <<glass::engine::Engine>::apply+0x2017>
  25a22d:	mov    0x20(%rsp),%r10
  25a232:	lea    0x35c06f(%rip),%rax        # 5b62a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25a239:	jmp    25a1c3 <<glass::engine::Engine>::apply+0x1fe3>
  25a23b:	lea    0x36d98e(%rip),%rcx        # 5c7bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  25a242:	mov    0x50(%rsp),%rdi
  25a247:	mov    %rbx,%rsi
  25a24a:	call   *0x396d68(%rip)        # 5f0fb8 <_DYNAMIC+0x3d8>
  25a250:	jmp    25a29a <<glass::engine::Engine>::apply+0x20ba>
  25a252:	mov    0x20(%rsp),%r10
  25a257:	lea    0x36e542(%rip),%rax        # 5c87a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  25a25e:	jmp    25a1c3 <<glass::engine::Engine>::apply+0x1fe3>
  25a263:	mov    0x20(%rsp),%r10
  25a268:	lea    0x36e519(%rip),%rax        # 5c8788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  25a26f:	jmp    25a1c3 <<glass::engine::Engine>::apply+0x1fe3>
  25a274:	mov    %rbx,%r10
  25a277:	lea    0x36e522(%rip),%rax        # 5c87a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  25a27e:	jmp    25a1c3 <<glass::engine::Engine>::apply+0x1fe3>
  25a283:	lea    0x36d946(%rip),%rcx        # 5c7bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  25a28a:	mov    0x50(%rsp),%rdi
  25a28f:	mov    0x58(%rsp),%rsi
  25a294:	call   *0x396d1e(%rip)        # 5f0fb8 <_DYNAMIC+0x3d8>
  25a29a:	ud2
  25a29c:	mov    %rbx,%r10
  25a29f:	lea    0x36e4e2(%rip),%rax        # 5c8788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  25a2a6:	jmp    25a1c3 <<glass::engine::Engine>::apply+0x1fe3>
  25a2ab:	mov    %rax,%rbx
  25a2ae:	test   %r15,%r15
  25a2b1:	je     25a315 <<glass::engine::Engine>::apply+0x2135>
  25a2b3:	mov    %r12,%rdi
  25a2b6:	call   *0x396b6c(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  25a2bc:	jmp    25a315 <<glass::engine::Engine>::apply+0x2135>
  25a2be:	mov    %rax,%rbx
  25a2c1:	lock decq 0x0(%r13)
  25a2c6:	je     25a2d3 <<glass::engine::Engine>::apply+0x20f3>
  25a2c8:	jmp    25a315 <<glass::engine::Engine>::apply+0x2135>
  25a2ca:	mov    %rax,%rbx
  25a2cd:	lock decq (%r15)
  25a2d1:	jne    25a315 <<glass::engine::Engine>::apply+0x2135>
  25a2d3:	lea    0xa0(%rsp),%rdi
  25a2db:	call   *0x396b67(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  25a2e1:	jmp    25a315 <<glass::engine::Engine>::apply+0x2135>
  25a2e3:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a2e5:	mov    %rax,%rbx
  25a2e8:	test   %r13,%r13
  25a2eb:	setne  %al
  25a2ee:	test   %r12,%r12
  25a2f1:	sete   %cl
  25a2f4:	or     %al,%cl
  25a2f6:	jne    25a381 <<glass::engine::Engine>::apply+0x21a1>
  25a2fc:	jmp    25a33e <<glass::engine::Engine>::apply+0x215e>
  25a2fe:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a300:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a302:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a304:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a306:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a308:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a30a:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a30c:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a30e:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a310:	jmp    25a312 <<glass::engine::Engine>::apply+0x2132>
  25a312:	mov    %rax,%rbx
  25a315:	cmpq   $0x0,0x130(%rsp)
  25a31e:	jne    25a34f <<glass::engine::Engine>::apply+0x216f>
  25a320:	cmpq   $0x0,0x148(%rsp)
  25a329:	jne    25a368 <<glass::engine::Engine>::apply+0x2188>
  25a32b:	cmpq   $0x0,0x160(%rsp)
  25a334:	jle    25a381 <<glass::engine::Engine>::apply+0x21a1>
  25a336:	mov    0x168(%rsp),%r14
  25a33e:	mov    %r14,%rdi
  25a341:	call   *0x396ae1(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  25a347:	mov    %rbx,%rdi
  25a34a:	call   5af5b0 <_Unwind_Resume@plt>
  25a34f:	mov    0x138(%rsp),%rdi
  25a357:	call   *0x396acb(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  25a35d:	cmpq   $0x0,0x148(%rsp)
  25a366:	je     25a32b <<glass::engine::Engine>::apply+0x214b>
  25a368:	mov    0x150(%rsp),%rdi
  25a370:	call   *0x396ab2(%rip)        # 5f0e28 <_DYNAMIC+0x248>
  25a376:	cmpq   $0x0,0x160(%rsp)
  25a37f:	jg     25a336 <<glass::engine::Engine>::apply+0x2156>
  25a381:	mov    %rbx,%rdi
  25a384:	call   5af5b0 <_Unwind_Resume@plt>
