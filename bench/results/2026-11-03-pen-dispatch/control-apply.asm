
/tmp/glass-i32-control-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002593b0 <<glass::engine::Engine>::apply>:
  2593b0:	push   %rbp
  2593b1:	push   %r15
  2593b3:	push   %r14
  2593b5:	push   %r13
  2593b7:	push   %r12
  2593b9:	push   %rbx
  2593ba:	sub    $0x248,%rsp
  2593c1:	mov    %rdi,%rbx
  2593c4:	testb  $0x10,0x6d5(%rdi)
  2593cb:	jne    25942d <<glass::engine::Engine>::apply+0x7d>
  2593cd:	cmpb   $0x2,0x278(%rbx)
  2593d4:	jne    25942d <<glass::engine::Engine>::apply+0x7d>
  2593d6:	mov    0xb0(%rbx),%rax
  2593dd:	dec    %rax
  2593e0:	movq   $0x0,0x250(%rbx)
  2593eb:	movl   $0x0,0x258(%rbx)
  2593f5:	movb   $0x0,0x260(%rbx)
  2593fc:	mov    %rax,0x268(%rbx)
  259403:	movl   $0x0,0x270(%rbx)
  25940d:	movb   $0x1,0x278(%rbx)
  259414:	movb   $0x0,0x280(%rbx)
  25941b:	movq   $0x0,0xa60(%rbx)
  259426:	movb   $0x1,0xa7d(%rbx)
  25942d:	test   %rdx,%rdx
  259430:	je     25b708 <<glass::engine::Engine>::apply+0x2358>
  259436:	lea    0x10(%rbx),%rax
  25943a:	mov    %rax,0x238(%rsp)
  259442:	lea    0x6f0(%rbx),%rax
  259449:	mov    %rax,0x78(%rsp)
  25944e:	lea    0x8e8(%rbx),%rax
  259455:	mov    %rax,0x228(%rsp)
  25945d:	lea    0xa7e(%rbx),%rax
  259464:	mov    %rax,0x60(%rsp)
  259469:	lea    0x720(%rbx),%rax
  259470:	mov    %rax,0xf0(%rsp)
  259478:	lea    0x9a0(%rbx),%rax
  25947f:	mov    %rax,0xe0(%rsp)
  259487:	mov    %rbx,0x38(%rsp)
  25948c:	jmp    2594ab <<glass::engine::Engine>::apply+0xfb>
  25948e:	xchg   %ax,%ax
  259490:	mov    0x110(%rsp),%rsi
  259498:	mov    0x240(%rsp),%rdx
  2594a0:	sub    0x18(%rsp),%rdx
  2594a5:	je     25b708 <<glass::engine::Engine>::apply+0x2358>
  2594ab:	mov    %rsi,0x28(%rsp)
  2594b0:	cmp    $0x2000,%rdx
  2594b7:	mov    $0x2000,%eax
  2594bc:	mov    %rdx,0x240(%rsp)
  2594c4:	cmovb  %rdx,%rax
  2594c8:	mov    %rax,0x18(%rsp)
  2594cd:	mov    0x6d4(%rbx),%ebp
  2594d3:	mov    $0x1000,%eax
  2594d8:	and    %eax,%ebp
  2594da:	mov    0xa58(%rbx),%r9
  2594e1:	mov    $0x0,%r10d
  2594e7:	cmove  %r9,%r10
  2594eb:	mov    0xa68(%rbx),%rax
  2594f2:	mov    %rax,%r11
  2594f5:	cmove  %r9,%r11
  2594f9:	mov    0x910(%rbx),%r13
  259500:	mov    $0x8,%r12d
  259506:	test   %r13,%r13
  259509:	je     25956c <<glass::engine::Engine>::apply+0x1bc>
  25950b:	mov    %r11,0x58(%rsp)
  259510:	mov    %r10,0x10(%rsp)
  259515:	mov    %r9,0x8(%rsp)
  25951a:	mov    0x908(%rbx),%r15
  259521:	lea    0x0(,%r13,8),%rax
  259529:	lea    (%rax,%rax,2),%r14
  25952d:	mov    $0x8,%esi
  259532:	mov    %r14,%rdi
  259535:	call   *0x39c74d(%rip)        # 5f5c88 <_DYNAMIC+0x228>
  25953b:	test   %rax,%rax
  25953e:	je     25b805 <<glass::engine::Engine>::apply+0x2455>
  259544:	mov    %rax,%r12
  259547:	mov    %rax,%rdi
  25954a:	mov    %r15,%rsi
  25954d:	mov    %r14,%rdx
  259550:	call   *0x39c73a(%rip)        # 5f5c90 <memcpy@GLIBC_2.14>
  259556:	mov    0xa68(%rbx),%rax
  25955d:	mov    0x8(%rsp),%r9
  259562:	mov    0x10(%rsp),%r10
  259567:	mov    0x58(%rsp),%r11
  25956c:	mov    0x18(%rsp),%r15
  259571:	mov    0x28(%rsp),%r14
  259576:	lea    (%r14,%r15,1),%rcx
  25957a:	mov    %rcx,0x110(%rsp)
  259582:	mov    0xa78(%rbx),%ecx
  259588:	mov    0xa60(%rbx),%rdx
  25958f:	movzbl 0xa7d(%rbx),%esi
  259596:	movzbl 0xa81(%rbx),%edi
  25959d:	mov    0x238(%rsp),%r8
  2595a5:	mov    %r8,0x1a8(%rsp)
  2595ad:	movq   $0x0,0x140(%rsp)
  2595b9:	movq   $0x8,0x148(%rsp)
  2595c5:	movq   $0x0,0x150(%rsp)
  2595d1:	mov    %r13,0x158(%rsp)
  2595d9:	mov    %r12,0x160(%rsp)
  2595e1:	mov    %r13,0x168(%rsp)
  2595e9:	mov    %r11,0x1b0(%rsp)
  2595f1:	mov    %r10,0x1b8(%rsp)
  2595f9:	shr    $0xc,%ebp
  2595fc:	mov    %bpl,0x1ec(%rsp)
  259604:	mov    %rax,0x1c0(%rsp)
  25960c:	mov    %ecx,0x1e8(%rsp)
  259613:	mov    %rdx,0x1c8(%rsp)
  25961b:	mov    %sil,0x1ed(%rsp)
  259623:	mov    %r15,0x1d0(%rsp)
  25962b:	movups (%rbx),%xmm0
  25962e:	movaps %xmm0,0x130(%rsp)
  259636:	movq   $0xffffffffffffffff,0x170(%rsp)
  259642:	mov    %r9,0x1d8(%rsp)
  25964a:	mov    %dil,0x1ee(%rsp)
  259652:	mov    0xa70(%rbx),%rax
  259659:	mov    %rax,0x1e0(%rsp)
  259661:	test   %dil,%dil
  259664:	mov    %rbx,%r12
  259667:	je     25b180 <<glass::engine::Engine>::apply+0x1dd0>
  25966d:	mov    $0x3,%eax
  259672:	sub    %r15,%rax
  259675:	mov    %rax,0x230(%rsp)
  25967d:	mov    $0x1,%al
  25967f:	mov    %eax,0xdc(%rsp)
  259686:	xor    %ebp,%ebp
  259688:	mov    %r14,0x1f8(%rsp)
  259690:	mov    $0x1,%al
  259692:	mov    %eax,0x104(%rsp)
  259699:	movq   $0x0,0x8(%rsp)
  2596a2:	movl   $0x0,0xd0(%rsp)
  2596ad:	movq   $0x0,0x58(%rsp)
  2596b6:	xor    %r13d,%r13d
  2596b9:	testb  $0x1,0xdc(%rsp)
  2596c1:	je     259720 <<glass::engine::Engine>::apply+0x370>
  2596c3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2596d0:	mov    0x39ce49(%rip),%rax        # 5f6520 <_DYNAMIC+0xac0>
  2596d7:	mov    (%rax),%rax
  2596da:	mov    $0x1b,%edi
  2596df:	mov    0x1f8(%rsp),%rsi
  2596e7:	mov    0x110(%rsp),%rdx
  2596ef:	call   *%rax
  2596f1:	cmp    $0x1,%rax
  2596f5:	jne    259720 <<glass::engine::Engine>::apply+0x370>
  2596f7:	mov    %rdx,%rax
  2596fa:	sub    0x28(%rsp),%rax
  2596ff:	inc    %rdx
  259702:	mov    $0x1,%cl
  259704:	mov    %ecx,0xdc(%rsp)
  25970b:	mov    %rdx,0x1f8(%rsp)
  259713:	jmp    259749 <<glass::engine::Engine>::apply+0x399>
  259715:	data16 cs nopw 0x0(%rax,%rax,1)
  259720:	testb  $0x1,0x104(%rsp)
  259728:	je     25b1f0 <<glass::engine::Engine>::apply+0x1e40>
  25972e:	movl   $0x0,0x104(%rsp)
  259739:	mov    0x18(%rsp),%rax
  25973e:	movl   $0x0,0xdc(%rsp)
  259749:	mov    %rax,%rdx
  25974c:	sub    %r13,%rax
  25974f:	cmp    $0x18,%rax
  259753:	mov    %rdx,0x10(%rsp)
  259758:	jb     259da0 <<glass::engine::Engine>::apply+0x9f0>
  25975e:	cmp    %rdx,0x18(%rsp)
  259763:	jae    2597a8 <<glass::engine::Engine>::apply+0x3f8>
  259765:	jmp    25b769 <<glass::engine::Engine>::apply+0x23b9>
  25976a:	mov    0x58(%rsp),%rax
  25976f:	mov    %eax,%ebp
  259771:	mov    0x38(%rsp),%rax
  259776:	cmpl   $0xffffffff,0x710(%rax)
  25977d:	je     259b06 <<glass::engine::Engine>::apply+0x756>
  259783:	mov    %ebp,%eax
  259785:	mov    %rax,0x58(%rsp)
  25978a:	nopw   0x0(%rax,%rax,1)
  259790:	mov    0x10(%rsp),%rdx
  259795:	mov    %rdx,%rax
  259798:	sub    %r13,%rax
  25979b:	mov    %r13,%rbp
  25979e:	cmp    $0x17,%rax
  2597a2:	jbe    259da3 <<glass::engine::Engine>::apply+0x9f3>
  2597a8:	lea    0xb0(%rsp),%rdi
  2597b0:	mov    0x28(%rsp),%rsi
  2597b5:	mov    %r13,%rcx
  2597b8:	call   2a2a40 <glass::engine::next_run>
  2597bd:	movzbl 0xc0(%rsp),%r12d
  2597c6:	cmp    $0x2,%r12b
  2597ca:	je     259e30 <<glass::engine::Engine>::apply+0xa80>
  2597d0:	mov    0xb0(%rsp),%rbx
  2597d8:	cmp    %rbp,%rbx
  2597db:	jb     25b726 <<glass::engine::Engine>::apply+0x2376>
  2597e1:	mov    0x18(%rsp),%r15
  2597e6:	cmp    %r15,%rbx
  2597e9:	ja     25b737 <<glass::engine::Engine>::apply+0x2387>
  2597ef:	mov    0xb8(%rsp),%r13
  2597f7:	mov    0x28(%rsp),%rax
  2597fc:	lea    (%rax,%rbp,1),%r15
  259800:	lea    (%rax,%rbx,1),%r14
  259804:	mov    0x39cd0d(%rip),%rax        # 5f6518 <_DYNAMIC+0xab8>
  25980b:	mov    (%rax),%rax
  25980e:	mov    $0x1b,%edi
  259813:	mov    %r15,%rsi
  259816:	mov    %r14,%rdx
  259819:	call   *%rax
  25981b:	cmp    $0x1,%rax
  25981f:	jne    25983d <<glass::engine::Engine>::apply+0x48d>
  259821:	sub    %r15,%rdx
  259824:	mov    0x38(%rsp),%rax
  259829:	movb   $0x1,0xa80(%rax)
  259830:	movb   $0x0,0xa7e(%rax)
  259837:	add    %rdx,%rbp
  25983a:	inc    %rbp
  25983d:	cmp    %rbx,%rbp
  259840:	jae    25987e <<glass::engine::Engine>::apply+0x4ce>
  259842:	mov    0x60(%rsp),%rdi
  259847:	mov    0x28(%rsp),%rsi
  25984c:	mov    0x18(%rsp),%rdx
  259851:	mov    %rbp,%rcx
  259854:	mov    %rbx,%r8
  259857:	call   270ff0 <<glass::engine::Mirror>::stretch>
  25985c:	cmp    %rbx,%rax
  25985f:	jae    25987e <<glass::engine::Engine>::apply+0x4ce>
  259861:	mov    0x38(%rsp),%rax
  259866:	cmpb   $0x0,0xa80(%rax)
  25986d:	jne    25987e <<glass::engine::Engine>::apply+0x4ce>
  25986f:	movzbl -0x1(%r14),%eax
  259874:	shr    $0x7,%al
  259877:	mov    0x60(%rsp),%rcx
  25987c:	mov    %al,(%rcx)
  25987e:	mov    0x60(%rsp),%rdi
  259883:	mov    0x28(%rsp),%rsi
  259888:	mov    0x18(%rsp),%rdx
  25988d:	mov    %rbx,%rcx
  259890:	mov    %r13,%r8
  259893:	call   270ff0 <<glass::engine::Mirror>::stretch>
  259898:	mov    %rax,%rbx
  25989b:	mov    0x38(%rsp),%rax
  2598a0:	cmpb   $0x0,0xa80(%rax)
  2598a7:	jne    259790 <<glass::engine::Engine>::apply+0x3e0>
  2598ad:	lea    -0x1(%r13),%r14
  2598b1:	cmp    0x18(%rsp),%r14
  2598b6:	jae    25b7b4 <<glass::engine::Engine>::apply+0x2404>
  2598bc:	mov    0x28(%rsp),%rax
  2598c1:	movzbl (%rax,%r14,1),%eax
  2598c6:	shr    $0x7,%al
  2598c9:	mov    0x60(%rsp),%rcx
  2598ce:	mov    %al,(%rcx)
  2598d0:	test   %rbx,%rbx
  2598d3:	je     259902 <<glass::engine::Engine>::apply+0x552>
  2598d5:	lea    -0x1(%rbx),%r14
  2598d9:	cmp    0x18(%rsp),%r14
  2598de:	jae    25b7d1 <<glass::engine::Engine>::apply+0x2421>
  2598e4:	mov    0x28(%rsp),%rax
  2598e9:	movzbl (%rax,%r14,1),%eax
  2598ee:	shr    $0x7,%al
  2598f1:	mov    %r13,%r14
  2598f4:	sub    %rbx,%r14
  2598f7:	cmp    $0x18,%r14
  2598fb:	jae    25991e <<glass::engine::Engine>::apply+0x56e>
  2598fd:	jmp    259790 <<glass::engine::Engine>::apply+0x3e0>
  259902:	mov    0x38(%rsp),%rax
  259907:	movzbl 0xa7f(%rax),%eax
  25990e:	mov    %r13,%r14
  259911:	sub    %rbx,%r14
  259914:	cmp    $0x18,%r14
  259918:	jb     259790 <<glass::engine::Engine>::apply+0x3e0>
  25991e:	test   %al,%al
  259920:	jne    259790 <<glass::engine::Engine>::apply+0x3e0>
  259926:	mov    %rbx,%r15
  259929:	sub    0x8(%rsp),%r15
  25992e:	jbe    25976a <<glass::engine::Engine>::apply+0x3ba>
  259934:	movzbl 0x3a25fd(%rip),%eax        # 5fbf38 <glass::engine::probes::RUN_PROBE>
  25993b:	mov    $0x1,%bpl
  25993e:	cmp    $0x68,%al
  259940:	je     259aef <<glass::engine::Engine>::apply+0x73f>
  259946:	cmp    0x18(%rsp),%rbx
  25994b:	ja     25b77c <<glass::engine::Engine>::apply+0x23cc>
  259951:	mov    0x8(%rsp),%rax
  259956:	add    0x28(%rsp),%rax
  25995b:	mov    %rax,0x8(%rsp)
  259960:	cmpb   $0x1,0x58(%rsp)
  259965:	jne    259992 <<glass::engine::Engine>::apply+0x5e2>
  259967:	mov    0x38(%rsp),%rax
  25996c:	cmpl   $0xffffffff,0x710(%rax)
  259973:	jne    259992 <<glass::engine::Engine>::apply+0x5e2>
  259975:	lea    0x130(%rsp),%rdi
  25997d:	mov    0x8(%rsp),%rsi
  259982:	mov    %r15,%rdx
  259985:	call   2a2d30 <glass::engine::plain_c0>
  25998a:	test   %al,%al
  25998c:	jne    259aef <<glass::engine::Engine>::apply+0x73f>
  259992:	movzbl 0x3a25af(%rip),%eax        # 5fbf48 <glass::engine::timers::ON>
  259999:	test   %al,%al
  25999b:	je     259bcf <<glass::engine::Engine>::apply+0x81f>
  2599a1:	mov    $0x1,%edi
  2599a6:	call   512a50 <<std::sys::pal::unix::time::Timespec>::now>
  2599ab:	mov    %rax,0x58(%rsp)
  2599b0:	mov    %edx,0x30(%rsp)
  2599b4:	xor    %ebp,%ebp
  2599b6:	cs nopw 0x0(%rax,%rax,1)
  2599c0:	mov    0x38(%rsp),%rax
  2599c5:	cmpl   $0xffffffff,0x710(%rax)
  2599cc:	jne    259a27 <<glass::engine::Engine>::apply+0x677>
  2599ce:	mov    0x78(%rsp),%rax
  2599d3:	mov    %rax,0x80(%rsp)
  2599db:	lea    0x130(%rsp),%rax
  2599e3:	mov    %rax,0x88(%rsp)
  2599eb:	movb   $0x0,0x90(%rsp)
  2599f3:	mov    %r15,%rcx
  2599f6:	sub    %rbp,%rcx
  2599f9:	jb     25b71a <<glass::engine::Engine>::apply+0x236a>
  2599ff:	mov    0x8(%rsp),%rax
  259a04:	lea    (%rax,%rbp,1),%rdx
  259a08:	mov    0xf0(%rsp),%rdi
  259a10:	lea    0x80(%rsp),%rsi
  259a18:	call   1a1560 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  259a1d:	add    %rax,%rbp
  259a20:	cmp    %r15,%rbp
  259a23:	jne    2599c0 <<glass::engine::Engine>::apply+0x610>
  259a25:	jmp    259a50 <<glass::engine::Engine>::apply+0x6a0>
  259a27:	mov    %r15,%rcx
  259a2a:	sub    %rbp,%rcx
  259a2d:	jb     25b826 <<glass::engine::Engine>::apply+0x2476>
  259a33:	mov    0x8(%rsp),%rax
  259a38:	lea    (%rax,%rbp,1),%rdx
  259a3c:	mov    0x78(%rsp),%rdi
  259a41:	lea    0x130(%rsp),%rsi
  259a49:	call   1952c0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  259a4e:	jmp    259a1d <<glass::engine::Engine>::apply+0x66d>
  259a50:	movzbl 0x3a24f1(%rip),%eax        # 5fbf48 <glass::engine::timers::ON>
  259a57:	test   %al,%al
  259a59:	mov    $0x1,%bpl
  259a5c:	je     259aef <<glass::engine::Engine>::apply+0x73f>
  259a62:	mov    $0x1,%edi
  259a67:	call   512a50 <<std::sys::pal::unix::time::Timespec>::now>
  259a6c:	mov    %rax,0x200(%rsp)
  259a74:	mov    %edx,0x208(%rsp)
  259a7b:	mov    0x58(%rsp),%rax
  259a80:	mov    %rax,0x210(%rsp)
  259a88:	mov    0x30(%rsp),%eax
  259a8c:	mov    %eax,0x218(%rsp)
  259a93:	lea    0x80(%rsp),%rdi
  259a9b:	lea    0x200(%rsp),%rsi
  259aa3:	lea    0x210(%rsp),%rdx
  259aab:	call   512990 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  259ab0:	imul   $0x3b9aca00,0x88(%rsp),%rax
  259abc:	mov    0x90(%rsp),%ecx
  259ac3:	add    %rcx,%rax
  259ac6:	cmpb   $0x0,0x80(%rsp)
  259ace:	mov    $0x0,%ecx
  259ad3:	cmove  %rax,%rcx
  259ad7:	lock add %rcx,0x3a2479(%rip)        # 5fbf58 <glass::engine::timers::VTE_NS>
  259adf:	lock incq 0x3a24a1(%rip)        # 5fbf88 <glass::engine::timers::VTE_CALLS>
  259ae7:	lock add %r15,0x3a2491(%rip)        # 5fbf80 <glass::engine::timers::VTE_BYTES>
  259aef:	mov    %rbx,0x8(%rsp)
  259af4:	mov    0x38(%rsp),%rax
  259af9:	cmpl   $0xffffffff,0x710(%rax)
  259b00:	jne    259783 <<glass::engine::Engine>::apply+0x3d3>
  259b06:	cmp    0x18(%rsp),%r13
  259b0b:	ja     25b755 <<glass::engine::Engine>::apply+0x23a5>
  259b11:	cmp    %rbx,%r13
  259b14:	jb     25b755 <<glass::engine::Engine>::apply+0x23a5>
  259b1a:	movzbl 0x3a2416(%rip),%r15d        # 5fbf38 <glass::engine::probes::RUN_PROBE>
  259b22:	movzbl 0x3a241f(%rip),%eax        # 5fbf48 <glass::engine::timers::ON>
  259b29:	test   %al,%al
  259b2b:	je     259b5c <<glass::engine::Engine>::apply+0x7ac>
  259b2d:	mov    $0x1,%edi
  259b32:	call   512a50 <<std::sys::pal::unix::time::Timespec>::now>
  259b37:	mov    %rax,0x58(%rsp)
  259b3c:	mov    %edx,%ebp
  259b3e:	cmp    $0x63,%r15b
  259b42:	jbe    259b67 <<glass::engine::Engine>::apply+0x7b7>
  259b44:	movzbl %r12b,%eax
  259b48:	mov    %r14,%rbx
  259b4b:	sub    %rax,%rbx
  259b4e:	cmp    $0xffffffff,%ebp
  259b51:	jne    259cda <<glass::engine::Engine>::apply+0x92a>
  259b57:	jmp    259d72 <<glass::engine::Engine>::apply+0x9c2>
  259b5c:	mov    $0xffffffff,%ebp
  259b61:	cmp    $0x63,%r15b
  259b65:	ja     259b44 <<glass::engine::Engine>::apply+0x794>
  259b67:	mov    0x39f0d3(%rip),%eax        # 5f8c40 <glass::engine::run_whole::ON>
  259b6d:	test   %eax,%eax
  259b6f:	jne    259d91 <<glass::engine::Engine>::apply+0x9e1>
  259b75:	mov    0x28(%rsp),%rax
  259b7a:	lea    (%rax,%rbx,1),%rsi
  259b7e:	cmpb   $0x0,0x39f0bf(%rip)        # 5f8c44 <glass::engine::run_whole::ON+0x4>
  259b85:	je     259ba6 <<glass::engine::Engine>::apply+0x7f6>
  259b87:	test   $0x1,%r12b
  259b8b:	je     259c8f <<glass::engine::Engine>::apply+0x8df>
  259b91:	lea    0x130(%rsp),%rdi
  259b99:	mov    %r14,%rdx
  259b9c:	call   265db0 <<glass::engine::Watch>::print_run>
  259ba1:	jmp    259c9f <<glass::engine::Engine>::apply+0x8ef>
  259ba6:	test   $0x1,%r12b
  259baa:	je     259cbe <<glass::engine::Engine>::apply+0x90e>
  259bb0:	cmp    %rbx,%r13
  259bb3:	je     25b792 <<glass::engine::Engine>::apply+0x23e2>
  259bb9:	lea    -0x1(%r14),%rdx
  259bbd:	lea    0x130(%rsp),%rdi
  259bc5:	call   265db0 <<glass::engine::Watch>::print_run>
  259bca:	jmp    259cce <<glass::engine::Engine>::apply+0x91e>
  259bcf:	xor    %ebp,%ebp
  259bd1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  259be0:	mov    0x38(%rsp),%rax
  259be5:	cmpl   $0xffffffff,0x710(%rax)
  259bec:	jne    259c47 <<glass::engine::Engine>::apply+0x897>
  259bee:	mov    0x78(%rsp),%rax
  259bf3:	mov    %rax,0x80(%rsp)
  259bfb:	lea    0x130(%rsp),%rax
  259c03:	mov    %rax,0x88(%rsp)
  259c0b:	movb   $0x0,0x90(%rsp)
  259c13:	mov    %r15,%rcx
  259c16:	sub    %rbp,%rcx
  259c19:	jb     25b71a <<glass::engine::Engine>::apply+0x236a>
  259c1f:	mov    0x8(%rsp),%rax
  259c24:	lea    (%rax,%rbp,1),%rdx
  259c28:	mov    0xf0(%rsp),%rdi
  259c30:	lea    0x80(%rsp),%rsi
  259c38:	call   1a1560 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  259c3d:	add    %rax,%rbp
  259c40:	cmp    %r15,%rbp
  259c43:	jne    259be0 <<glass::engine::Engine>::apply+0x830>
  259c45:	jmp    259c70 <<glass::engine::Engine>::apply+0x8c0>
  259c47:	mov    %r15,%rcx
  259c4a:	sub    %rbp,%rcx
  259c4d:	jb     25b826 <<glass::engine::Engine>::apply+0x2476>
  259c53:	mov    0x8(%rsp),%rax
  259c58:	lea    (%rax,%rbp,1),%rdx
  259c5c:	mov    0x78(%rsp),%rdi
  259c61:	lea    0x130(%rsp),%rsi
  259c69:	call   1952c0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  259c6e:	jmp    259c3d <<glass::engine::Engine>::apply+0x88d>
  259c70:	mov    %rbx,0x8(%rsp)
  259c75:	mov    $0x1,%bpl
  259c78:	mov    0x38(%rsp),%rax
  259c7d:	cmpl   $0xffffffff,0x710(%rax)
  259c84:	jne    259783 <<glass::engine::Engine>::apply+0x3d3>
  259c8a:	jmp    259b06 <<glass::engine::Engine>::apply+0x756>
  259c8f:	lea    0x130(%rsp),%rdi
  259c97:	mov    %r14,%rdx
  259c9a:	call   263410 <<glass::engine::Watch>::print_utf8>
  259c9f:	mov    %rax,%rbx
  259ca2:	mov    0x1e0(%rsp),%eax
  259ca9:	mov    0x38(%rsp),%rcx
  259cae:	mov    %eax,0x718(%rcx)
  259cb4:	cmp    $0xffffffff,%ebp
  259cb7:	jne    259cda <<glass::engine::Engine>::apply+0x92a>
  259cb9:	jmp    259d72 <<glass::engine::Engine>::apply+0x9c2>
  259cbe:	lea    0x130(%rsp),%rdi
  259cc6:	mov    %r14,%rdx
  259cc9:	call   263410 <<glass::engine::Watch>::print_utf8>
  259cce:	mov    %rax,%rbx
  259cd1:	cmp    $0xffffffff,%ebp
  259cd4:	je     259d72 <<glass::engine::Engine>::apply+0x9c2>
  259cda:	movzbl 0x3a2267(%rip),%eax        # 5fbf48 <glass::engine::timers::ON>
  259ce1:	test   %al,%al
  259ce3:	je     259d6a <<glass::engine::Engine>::apply+0x9ba>
  259ce9:	mov    $0x1,%edi
  259cee:	call   512a50 <<std::sys::pal::unix::time::Timespec>::now>
  259cf3:	mov    %rax,0x200(%rsp)
  259cfb:	mov    %edx,0x208(%rsp)
  259d02:	mov    0x58(%rsp),%rax
  259d07:	mov    %rax,0x210(%rsp)
  259d0f:	mov    %ebp,0x218(%rsp)
  259d16:	lea    0x80(%rsp),%rdi
  259d1e:	lea    0x200(%rsp),%rsi
  259d26:	lea    0x210(%rsp),%rdx
  259d2e:	call   512990 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  259d33:	imul   $0x3b9aca00,0x88(%rsp),%rax
  259d3f:	mov    0x90(%rsp),%ecx
  259d46:	add    %rcx,%rax
  259d49:	cmpb   $0x0,0x80(%rsp)
  259d51:	mov    $0x0,%ecx
  259d56:	cmove  %rax,%rcx
  259d5a:	lock add %rcx,0x3a21ee(%rip)        # 5fbf50 <glass::engine::timers::RUN_NS>
  259d62:	lock incq 0x3a220e(%rip)        # 5fbf78 <glass::engine::timers::RUN_CALLS>
  259d6a:	lock add %r14,0x3a21fe(%rip)        # 5fbf70 <glass::engine::timers::RUN_BYTES>
  259d72:	movzbl 0x3a221f(%rip),%eax        # 5fbf98 <glass::engine::counters::COUNTING>
  259d79:	test   %al,%al
  259d7b:	je     259d85 <<glass::engine::Engine>::apply+0x9d5>
  259d7d:	lock add %rbx,0x3a220b(%rip)        # 5fbf90 <glass::engine::counters::LANE_RUN_BYTES>
  259d85:	add    %rbx,0x8(%rsp)
  259d8a:	mov    $0x1,%al
  259d8c:	jmp    259785 <<glass::engine::Engine>::apply+0x3d5>
  259d91:	call   18c8f6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259d96:	jmp    259b75 <<glass::engine::Engine>::apply+0x7c5>
  259d9b:	nopl   0x0(%rax,%rax,1)
  259da0:	mov    %rbp,%r13
  259da3:	mov    $0x1,%ebx
  259da8:	mov    0x18(%rsp),%rax
  259dad:	sub    %rdx,%rax
  259db0:	jbe    259e4b <<glass::engine::Engine>::apply+0xa9b>
  259db6:	mov    0x8(%rsp),%rcx
  259dbb:	cmp    %rcx,0xe8(%rsp)
  259dc3:	sete   %r9b
  259dc7:	cmp    $0x2,%rax
  259dcb:	mov    0x38(%rsp),%r12
  259dd0:	jb     259e20 <<glass::engine::Engine>::apply+0xa70>
  259dd2:	mov    0x28(%rsp),%rcx
  259dd7:	mov    0x10(%rsp),%rdx
  259ddc:	lea    (%rcx,%rdx,1),%rbp
  259de0:	cmpb   $0x5b,0x1(%rbp)
  259de4:	jne    259e20 <<glass::engine::Engine>::apply+0xa70>
  259de6:	xorps  %xmm0,%xmm0
  259de9:	movaps %xmm0,0x90(%rsp)
  259df1:	movaps %xmm0,0x80(%rsp)
  259df9:	cmp    $0x2,%rax
  259dfd:	je     259e20 <<glass::engine::Engine>::apply+0xa70>
  259dff:	movzbl 0x2(%rbp),%ecx
  259e03:	lea    -0x30(%rcx),%eax
  259e06:	cmp    $0xa,%al
  259e08:	jae    259e71 <<glass::engine::Engine>::apply+0xac1>
  259e0a:	movzbl %al,%eax
  259e0d:	xor    %r14d,%r14d
  259e10:	mov    0x10(%rsp),%rcx
  259e15:	add    $0x3,%rcx
  259e19:	cmp    0x18(%rsp),%rcx
  259e1e:	jne    259e97 <<glass::engine::Engine>::apply+0xae7>
  259e20:	movl   $0x0,0xd0(%rsp)
  259e2b:	jmp    259e50 <<glass::engine::Engine>::apply+0xaa0>
  259e2d:	nopl   (%rax)
  259e30:	mov    %rbp,%r13
  259e33:	mov    0x10(%rsp),%rdx
  259e38:	mov    $0x1,%ebx
  259e3d:	mov    0x18(%rsp),%rax
  259e42:	sub    %rdx,%rax
  259e45:	ja     259db6 <<glass::engine::Engine>::apply+0xa06>
  259e4b:	mov    0x38(%rsp),%r12
  259e50:	mov    0x10(%rsp),%r8
  259e55:	add    %r8,%rbx
  259e58:	mov    %r13,%rbp
  259e5b:	mov    %rbx,%r13
  259e5e:	testb  $0x1,0xdc(%rsp)
  259e66:	je     259720 <<glass::engine::Engine>::apply+0x370>
  259e6c:	jmp    2596d0 <<glass::engine::Engine>::apply+0x320>
  259e71:	movzbl %cl,%edx
  259e74:	xor    %eax,%eax
  259e76:	lea    -0x48(%rdx),%esi
  259e79:	cmp    $0x25,%esi
  259e7c:	ja     259eb0 <<glass::engine::Engine>::apply+0xb00>
  259e7e:	mov    $0x3,%r8d
  259e84:	lea    -0x1eb023(%rip),%rdi        # 6ee68 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2cd7>
  259e8b:	movslq (%rdi,%rsi,4),%rdx
  259e8f:	add    %rdi,%rdx
  259e92:	xor    %r14d,%r14d
  259e95:	jmp    *%rdx
  259e97:	mov    0x10(%rsp),%rcx
  259e9c:	mov    0x230(%rsp),%rdx
  259ea4:	lea    (%rdx,%rcx,1),%rsi
  259ea8:	mov    $0x4,%r8d
  259eae:	jmp    259ef3 <<glass::engine::Engine>::apply+0xb43>
  259eb0:	mov    $0x1,%r14d
  259eb6:	cmp    $0x3b,%edx
  259eb9:	je     259e10 <<glass::engine::Engine>::apply+0xa60>
  259ebf:	jmp    259e20 <<glass::engine::Engine>::apply+0xa70>
  259ec4:	mov    $0xffff,%cx
  259ec8:	nopl   0x0(%rax,%rax,1)
  259ed0:	movzbl %dil,%eax
  259ed4:	add    %cx,%ax
  259ed7:	mov    $0xffff,%ecx
  259edc:	cmovb  %ecx,%eax
  259edf:	lea    (%rsi,%r8,1),%rcx
  259ee3:	inc    %rcx
  259ee6:	inc    %r8
  259ee9:	cmp    $0x4,%rcx
  259eed:	je     259e20 <<glass::engine::Engine>::apply+0xa70>
  259ef3:	movzbl -0x1(%rbp,%r8,1),%ecx
  259ef9:	lea    -0x30(%rcx),%edi
  259efc:	cmp    $0xa,%dil
  259f00:	jae    259f10 <<glass::engine::Engine>::apply+0xb60>
  259f02:	mov    $0xa,%cx
  259f06:	mul    %cx
  259f09:	jo     259ec4 <<glass::engine::Engine>::apply+0xb14>
  259f0b:	mov    %eax,%ecx
  259f0d:	jmp    259ed0 <<glass::engine::Engine>::apply+0xb20>
  259f0f:	nop
  259f10:	movzbl %cl,%edx
  259f13:	cmp    $0x3b,%edx
  259f16:	jne    259f53 <<glass::engine::Engine>::apply+0xba3>
  259f18:	lea    0x1(%r14),%rcx
  259f1c:	cmp    $0x10,%rcx
  259f20:	jae    259e20 <<glass::engine::Engine>::apply+0xa70>
  259f26:	cmp    $0xf,%r14
  259f2a:	ja     25b7eb <<glass::engine::Engine>::apply+0x243b>
  259f30:	mov    %ax,0x80(%rsp,%r14,2)
  259f39:	xor    %eax,%eax
  259f3b:	mov    %rcx,%r14
  259f3e:	lea    (%rsi,%r8,1),%rcx
  259f42:	inc    %rcx
  259f45:	inc    %r8
  259f48:	cmp    $0x4,%rcx
  259f4c:	jne    259ef3 <<glass::engine::Engine>::apply+0xb43>
  259f4e:	jmp    259e20 <<glass::engine::Engine>::apply+0xa70>
  259f53:	add    $0xffffffb8,%edx
  259f56:	cmp    $0x25,%edx
  259f59:	ja     259e20 <<glass::engine::Engine>::apply+0xa70>
  259f5f:	lea    -0x1eb066(%rip),%rsi        # 6ef00 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d6f>
  259f66:	movslq (%rsi,%rdx,4),%rdx
  259f6a:	add    %rsi,%rdx
  259f6d:	jmp    *%rdx
  259f6f:	cmp    $0x10,%r14
  259f73:	jae    25b813 <<glass::engine::Engine>::apply+0x2463>
  259f79:	mov    %r8,0x120(%rsp)
  259f81:	mov    %ax,0x80(%rsp,%r14,2)
  259f8a:	cmp    $0x6d,%cl
  259f8d:	setne  %cl
  259f90:	movaps 0x80(%rsp),%xmm0
  259f98:	movaps 0x90(%rsp),%xmm1
  259fa0:	movaps %xmm0,0xb0(%rsp)
  259fa8:	movaps %xmm1,0xc0(%rsp)
  259fb0:	xor    %edx,%edx
  259fb2:	jmp    259ff3 <<glass::engine::Engine>::apply+0xc43>
  259fb4:	cmp    $0x10,%r14
  259fb8:	jae    25b835 <<glass::engine::Engine>::apply+0x2485>
  259fbe:	mov    %r8,0x120(%rsp)
  259fc6:	mov    %ax,0x80(%rsp,%r14,2)
  259fcf:	movaps 0x80(%rsp),%xmm0
  259fd7:	movaps 0x90(%rsp),%xmm1
  259fdf:	movaps %xmm0,0xb0(%rsp)
  259fe7:	movaps %xmm1,0xc0(%rsp)
  259fef:	mov    $0x1,%dl
  259ff1:	xor    %ecx,%ecx
  259ff3:	lea    0x1(%r14),%rax
  259ff7:	movaps 0xb0(%rsp),%xmm0
  259fff:	movaps 0xc0(%rsp),%xmm1
  25a007:	movaps %xmm1,0x90(%rsp)
  25a00f:	movaps %xmm0,0x80(%rsp)
  25a017:	mov    %rax,0xa0(%rsp)
  25a01f:	mov    %cl,0xa8(%rsp)
  25a026:	mov    %dl,0xa9(%rsp)
  25a02d:	mov    0x10(%rsp),%r8
  25a032:	cmp    %r13,%r8
  25a035:	jb     25b7a7 <<glass::engine::Engine>::apply+0x23f7>
  25a03b:	mov    %r9b,0x30(%rsp)
  25a040:	mov    %edx,0x12c(%rsp)
  25a047:	mov    %ecx,0x128(%rsp)
  25a04e:	mov    0x28(%rsp),%rax
  25a053:	lea    (%rax,%r13,1),%r15
  25a057:	mov    0x39c4ba(%rip),%rax        # 5f6518 <_DYNAMIC+0xab8>
  25a05e:	mov    (%rax),%rax
  25a061:	mov    $0x1b,%edi
  25a066:	mov    %r15,%rsi
  25a069:	mov    %rbp,%rdx
  25a06c:	call   *%rax
  25a06e:	cmp    $0x1,%rax
  25a072:	jne    25a08f <<glass::engine::Engine>::apply+0xcdf>
  25a074:	sub    %r15,%rdx
  25a077:	movb   $0x1,0xa80(%r12)
  25a080:	movb   $0x0,0xa7e(%r12)
  25a089:	add    %rdx,%r13
  25a08c:	inc    %r13
  25a08f:	mov    0x10(%rsp),%r8
  25a094:	cmp    %r8,%r13
  25a097:	jae    25a0e9 <<glass::engine::Engine>::apply+0xd39>
  25a099:	mov    0x60(%rsp),%rdi
  25a09e:	mov    0x28(%rsp),%rsi
  25a0a3:	mov    0x18(%rsp),%rdx
  25a0a8:	mov    %r13,%rcx
  25a0ab:	call   270ff0 <<glass::engine::Mirror>::stretch>
  25a0b0:	movzbl 0xa80(%r12),%ecx
  25a0b9:	test   %cl,%cl
  25a0bb:	setne  %dl
  25a0be:	mov    0x10(%rsp),%r8
  25a0c3:	cmp    %r8,%rax
  25a0c6:	setae  %al
  25a0c9:	or     %dl,%al
  25a0cb:	jne    25a0f2 <<glass::engine::Engine>::apply+0xd42>
  25a0cd:	movzbl -0x1(%rbp),%eax
  25a0d1:	shr    $0x7,%al
  25a0d4:	mov    0x60(%rsp),%rcx
  25a0d9:	mov    %al,(%rcx)
  25a0db:	mov    0x28(%rsp),%r9
  25a0e0:	test   %al,%al
  25a0e2:	jne    25a10f <<glass::engine::Engine>::apply+0xd5f>
  25a0e4:	jmp    25a1e0 <<glass::engine::Engine>::apply+0xe30>
  25a0e9:	movzbl 0xa80(%r12),%ecx
  25a0f2:	test   %cl,%cl
  25a0f4:	mov    0x28(%rsp),%r9
  25a0f9:	jne    25a42c <<glass::engine::Engine>::apply+0x107c>
  25a0ff:	mov    0x60(%rsp),%rax
  25a104:	movzbl (%rax),%eax
  25a107:	test   %al,%al
  25a109:	je     25a1e0 <<glass::engine::Engine>::apply+0xe30>
  25a10f:	mov    0x10(%rsp),%r8
  25a114:	test   %r8,%r8
  25a117:	je     25a42c <<glass::engine::Engine>::apply+0x107c>
  25a11d:	cmpb   $0xc0,-0x1(%rbp)
  25a121:	jge    25a163 <<glass::engine::Engine>::apply+0xdb3>
  25a123:	cmp    $0x1,%r8
  25a127:	je     25a42c <<glass::engine::Engine>::apply+0x107c>
  25a12d:	cmpb   $0xbf,-0x2(%rbp)
  25a131:	jg     25a27d <<glass::engine::Engine>::apply+0xecd>
  25a137:	cmp    $0x2,%r8
  25a13b:	je     25a42c <<glass::engine::Engine>::apply+0x107c>
  25a141:	cmpb   $0xbf,-0x3(%rbp)
  25a145:	jg     25a947 <<glass::engine::Engine>::apply+0x1597>
  25a14b:	cmp    $0x3,%r8
  25a14f:	je     25a42c <<glass::engine::Engine>::apply+0x107c>
  25a155:	cmpb   $0xc0,-0x4(%rbp)
  25a159:	setl   %al
  25a15c:	mov    $0x3,%edx
  25a161:	jmp    25a167 <<glass::engine::Engine>::apply+0xdb7>
  25a163:	xor    %edx,%edx
  25a165:	xor    %eax,%eax
  25a167:	test   %al,%al
  25a169:	jne    25a1d6 <<glass::engine::Engine>::apply+0xe26>
  25a16b:	mov    %rdx,%rsi
  25a16e:	not    %rsi
  25a171:	add    0x10(%rsp),%rsi
  25a176:	jae    25b848 <<glass::engine::Engine>::apply+0x2498>
  25a17c:	movzbl (%r9,%rsi,1),%eax
  25a181:	mov    $0x1,%ecx
  25a186:	test   %al,%al
  25a188:	jns    25a1b4 <<glass::engine::Engine>::apply+0xe04>
  25a18a:	lea    0x3e(%rax),%edi
  25a18d:	mov    $0x2,%ecx
  25a192:	cmp    $0x1e,%dil
  25a196:	jb     25a1b4 <<glass::engine::Engine>::apply+0xe04>
  25a198:	mov    %eax,%edi
  25a19a:	and    $0xf0,%dil
  25a19e:	mov    $0x3,%ecx
  25a1a3:	cmp    $0xe0,%dil
  25a1a7:	je     25a1b4 <<glass::engine::Engine>::apply+0xe04>
  25a1a9:	add    $0x10,%al
  25a1ab:	mov    $0x4,%ecx
  25a1b0:	cmp    $0x4,%al
  25a1b2:	ja     25a1d6 <<glass::engine::Engine>::apply+0xe26>
  25a1b4:	inc    %rdx
  25a1b7:	cmp    %ecx,%edx
  25a1b9:	jne    25a1d6 <<glass::engine::Engine>::apply+0xe26>
  25a1bb:	add    %r9,%rsi
  25a1be:	lea    0xb0(%rsp),%rdi
  25a1c6:	call   *0x39bb84(%rip)        # 5f5d50 <_DYNAMIC+0x2f0>
  25a1cc:	cmpb   $0x0,0xb0(%rsp)
  25a1d4:	je     25a1e0 <<glass::engine::Engine>::apply+0xe30>
  25a1d6:	mov    0x10(%rsp),%r8
  25a1db:	jmp    25a42c <<glass::engine::Engine>::apply+0x107c>
  25a1e0:	mov    0x10(%rsp),%r8
  25a1e5:	mov    %r8,%rbp
  25a1e8:	sub    0x8(%rsp),%rbp
  25a1ed:	jbe    25a421 <<glass::engine::Engine>::apply+0x1071>
  25a1f3:	mov    0x39ea47(%rip),%eax        # 5f8c40 <glass::engine::run_whole::ON>
  25a1f9:	test   %eax,%eax
  25a1fb:	jne    25a951 <<glass::engine::Engine>::apply+0x15a1>
  25a201:	mov    0xd0(%rsp),%ecx
  25a208:	and    0x30(%rsp),%cl
  25a20c:	movzbl 0x39ea31(%rip),%eax        # 5f8c44 <glass::engine::run_whole::ON+0x4>
  25a213:	xor    $0x1,%rax
  25a217:	cmp    %rax,%rbp
  25a21a:	seta   %al
  25a21d:	and    %cl,%al
  25a21f:	cmp    $0x1,%al
  25a221:	jne    25a273 <<glass::engine::Engine>::apply+0xec3>
  25a223:	mov    0x8(%rsp),%rcx
  25a228:	mov    %rcx,%rax
  25a22b:	cmp    %rcx,0x10(%rsp)
  25a230:	mov    0x28(%rsp),%rdx
  25a235:	je     25a256 <<glass::engine::Engine>::apply+0xea6>
  25a237:	nopw   0x0(%rax,%rax,1)
  25a240:	movzbl (%rdx,%rax,1),%ecx
  25a244:	add    $0xe0,%cl
  25a247:	cmp    $0x5f,%cl
  25a24a:	jae    25a261 <<glass::engine::Engine>::apply+0xeb1>
  25a24c:	inc    %rax
  25a24f:	cmp    %rax,0x10(%rsp)
  25a254:	jne    25a240 <<glass::engine::Engine>::apply+0xe90>
  25a256:	cmpl   $0xffffffff,0x710(%r12)
  25a25f:	je     25a287 <<glass::engine::Engine>::apply+0xed7>
  25a261:	mov    0x10(%rsp),%r8
  25a266:	mov    0xe8(%rsp),%r13
  25a26e:	jmp    25a365 <<glass::engine::Engine>::apply+0xfb5>
  25a273:	mov    0x8(%rsp),%r13
  25a278:	jmp    25a35b <<glass::engine::Engine>::apply+0xfab>
  25a27d:	mov    $0x1,%edx
  25a282:	jmp    25a165 <<glass::engine::Engine>::apply+0xdb5>
  25a287:	mov    0x39e9b3(%rip),%eax        # 5f8c40 <glass::engine::run_whole::ON>
  25a28d:	test   %eax,%eax
  25a28f:	jne    25a95b <<glass::engine::Engine>::apply+0x15ab>
  25a295:	mov    0x8(%rsp),%rax
  25a29a:	add    0x28(%rsp),%rax
  25a29f:	mov    %rax,0x8(%rsp)
  25a2a4:	movzbl 0x39e999(%rip),%eax        # 5f8c44 <glass::engine::run_whole::ON+0x4>
  25a2ab:	xor    $0x1,%rax
  25a2af:	sub    %rax,%rbp
  25a2b2:	cmp    $0x1,%rbp
  25a2b6:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a2b8:	cmpb   $0x1,0x1ee(%rsp)
  25a2c0:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a2c2:	cmpq   $0x0,0x168(%rsp)
  25a2cb:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a2cd:	mov    0x1a8(%rsp),%r13
  25a2d5:	testb  $0x4,0x6c5(%r13)
  25a2dd:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a2df:	cmpq   $0x0,0x50(%r13)
  25a2e4:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a2e6:	movzwl 0x64(%r13),%eax
  25a2eb:	test   $0x460,%eax
  25a2f0:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a2f2:	cmpb   $0x0,0x68(%r13)
  25a2f7:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a2f9:	cmpb   $0x0,0x69(%r13)
  25a2fe:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a300:	cmpb   $0x0,0x6a(%r13)
  25a305:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a307:	cmpb   $0x0,0x6b(%r13)
  25a30c:	je     25a965 <<glass::engine::Engine>::apply+0x15b5>
  25a312:	lea    0x130(%rsp),%rdi
  25a31a:	mov    0x8(%rsp),%rsi
  25a31f:	mov    %rbp,%rdx
  25a322:	call   265db0 <<glass::engine::Watch>::print_run>
  25a327:	mov    %rax,%r15
  25a32a:	mov    0x39e910(%rip),%eax        # 5f8c40 <glass::engine::run_whole::ON>
  25a330:	test   %eax,%eax
  25a332:	jne    25b16d <<glass::engine::Engine>::apply+0x1dbd>
  25a338:	cmpb   $0x0,0x39e905(%rip)        # 5f8c44 <glass::engine::run_whole::ON+0x4>
  25a33f:	je     25a350 <<glass::engine::Engine>::apply+0xfa0>
  25a341:	mov    0x1e0(%rsp),%eax
  25a348:	mov    %eax,0x718(%r12)
  25a350:	mov    0xe8(%rsp),%r13
  25a358:	add    %r15,%r13
  25a35b:	mov    0x28(%rsp),%rdx
  25a360:	mov    0x10(%rsp),%r8
  25a365:	cmp    %r13,%r8
  25a368:	jb     25b7bd <<glass::engine::Engine>::apply+0x240d>
  25a36e:	mov    %r8,%r15
  25a371:	mov    %r8,0x8(%rsp)
  25a376:	sub    %r13,%r15
  25a379:	je     25a421 <<glass::engine::Engine>::apply+0x1071>
  25a37f:	add    %rdx,%r13
  25a382:	xor    %ebp,%ebp
  25a384:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a390:	cmpl   $0xffffffff,0x710(%r12)
  25a399:	jne    25a3f6 <<glass::engine::Engine>::apply+0x1046>
  25a39b:	mov    0x78(%rsp),%rax
  25a3a0:	mov    %rax,0xb0(%rsp)
  25a3a8:	lea    0x130(%rsp),%rax
  25a3b0:	mov    %rax,0xb8(%rsp)
  25a3b8:	movb   $0x0,0xc0(%rsp)
  25a3c0:	mov    %r15,%rcx
  25a3c3:	sub    %rbp,%rcx
  25a3c6:	jb     25b71a <<glass::engine::Engine>::apply+0x236a>
  25a3cc:	mov    %r13,%rdx
  25a3cf:	add    %rbp,%rdx
  25a3d2:	mov    0xf0(%rsp),%rdi
  25a3da:	lea    0xb0(%rsp),%rsi
  25a3e2:	call   1a1560 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a3e7:	add    %rax,%rbp
  25a3ea:	cmp    %r15,%rbp
  25a3ed:	mov    0x10(%rsp),%r8
  25a3f2:	jne    25a390 <<glass::engine::Engine>::apply+0xfe0>
  25a3f4:	jmp    25a41c <<glass::engine::Engine>::apply+0x106c>
  25a3f6:	mov    %r15,%rcx
  25a3f9:	sub    %rbp,%rcx
  25a3fc:	jb     25b826 <<glass::engine::Engine>::apply+0x2476>
  25a402:	mov    %r13,%rdx
  25a405:	add    %rbp,%rdx
  25a408:	mov    0x78(%rsp),%rdi
  25a40d:	lea    0x130(%rsp),%rsi
  25a415:	call   1952c0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a41a:	jmp    25a3e7 <<glass::engine::Engine>::apply+0x1037>
  25a41c:	mov    %r8,0x8(%rsp)
  25a421:	cmpl   $0xffffffff,0x710(%r12)
  25a42a:	je     25a43f <<glass::engine::Engine>::apply+0x108f>
  25a42c:	movl   $0x0,0xd0(%rsp)
  25a437:	mov    %r8,%r13
  25a43a:	jmp    259e55 <<glass::engine::Engine>::apply+0xaa5>
  25a43f:	cmpb   $0x0,0x12c(%rsp)
  25a447:	je     25a489 <<glass::engine::Engine>::apply+0x10d9>
  25a449:	mov    0x1e0(%rsp),%ebx
  25a450:	cmp    $0xffffffff,%ebx
  25a453:	je     25a8b5 <<glass::engine::Engine>::apply+0x1505>
  25a459:	mov    0x80(%rsp),%ebp
  25a460:	cmp    $0x1,%bp
  25a464:	adc    $0x0,%ebp
  25a467:	nopw   0x0(%rax,%rax,1)
  25a470:	lea    0x130(%rsp),%rdi
  25a478:	mov    %ebx,%esi
  25a47a:	call   340a50 <<glass::engine::Watch as vte::ansi::Handler>::input>
  25a47f:	dec    %bp
  25a482:	jne    25a470 <<glass::engine::Engine>::apply+0x10c0>
  25a484:	jmp    25a902 <<glass::engine::Engine>::apply+0x1552>
  25a489:	cmpb   $0x0,0x128(%rsp)
  25a491:	je     25a4c1 <<glass::engine::Engine>::apply+0x1111>
  25a493:	movzwl 0x80(%rsp),%eax
  25a49b:	lea    -0x1(%rax),%esi
  25a49e:	test   %eax,%eax
  25a4a0:	cmove  %eax,%esi
  25a4a3:	test   %r14,%r14
  25a4a6:	je     25a8e2 <<glass::engine::Engine>::apply+0x1532>
  25a4ac:	movzwl 0x82(%rsp),%ecx
  25a4b4:	xor    %eax,%eax
  25a4b6:	test   %cx,%cx
  25a4b9:	setne  %al
  25a4bc:	jmp    25a8e4 <<glass::engine::Engine>::apply+0x1534>
  25a4c1:	mov    0x1a8(%rsp),%r13
  25a4c9:	xor    %eax,%eax
  25a4cb:	jmp    25a4fe <<glass::engine::Engine>::apply+0x114e>
  25a4cd:	mov    $0x17,%cx
  25a4d1:	mov    $0x1010000,%esi
  25a4d6:	cs nopw 0x0(%rax,%rax,1)
  25a4e0:	movzwl %cx,%eax
  25a4e3:	shl    $0x10,%rsi
  25a4e7:	or     %rax,%rsi
  25a4ea:	mov    %r13,%rdi
  25a4ed:	call   34e510 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  25a4f2:	mov    %rbx,%rax
  25a4f5:	cmp    %r14,%rbx
  25a4f8:	ja     25a902 <<glass::engine::Engine>::apply+0x1552>
  25a4fe:	movzwl 0x80(%rsp,%rax,2),%ecx
  25a506:	lea    0x1(%rax),%rbx
  25a50a:	cmp    $0x3b,%rcx
  25a50e:	ja     25a78f <<glass::engine::Engine>::apply+0x13df>
  25a514:	lea    -0x1eb583(%rip),%rsi        # 6ef98 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2e07>
  25a51b:	movslq (%rsi,%rcx,4),%rdx
  25a51f:	add    %rsi,%rdx
  25a522:	jmp    *%rdx
  25a524:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a526:	cmp    %r14,%rax
  25a529:	jae    25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a52b:	movzwl 0x82(%rsp,%rax,2),%ecx
  25a533:	lea    0x2(%rax),%rbx
  25a537:	cmp    $0x5,%ecx
  25a53a:	je     25a7f3 <<glass::engine::Engine>::apply+0x1443>
  25a540:	cmp    $0x2,%ecx
  25a543:	jne    25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a545:	cmp    %r14,%rbx
  25a548:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a54a:	movzwl 0x84(%rsp,%rax,2),%ecx
  25a552:	lea    0x3(%rax),%rbx
  25a556:	cmp    $0xff,%ecx
  25a55c:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a55e:	cmp    %r14,%rbx
  25a561:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a563:	movzwl 0x86(%rsp,%rax,2),%edx
  25a56b:	lea    0x4(%rax),%rbx
  25a56f:	cmp    $0xff,%edx
  25a575:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a57b:	cmp    %r14,%rbx
  25a57e:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a584:	movzwl 0x88(%rsp,%rax,2),%edi
  25a58c:	add    $0x5,%rax
  25a590:	cmp    $0xff,%edi
  25a596:	ja     25a876 <<glass::engine::Engine>::apply+0x14c6>
  25a59c:	shl    $0x10,%edi
  25a59f:	movzwl %dx,%edx
  25a5a2:	shl    $0x8,%edx
  25a5a5:	or     %edx,%ecx
  25a5a7:	movzwl %cx,%esi
  25a5aa:	or     %edi,%esi
  25a5ac:	mov    $0x1,%ecx
  25a5b1:	jmp    25a815 <<glass::engine::Engine>::apply+0x1465>
  25a5b6:	mov    $0x11,%cx
  25a5ba:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a5bf:	mov    $0xc,%cx
  25a5c3:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a5c8:	mov    $0xa,%cx
  25a5cc:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a5d1:	mov    $0x18,%cx
  25a5d5:	mov    $0xff,%esi
  25a5da:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a5df:	mov    $0xe,%cx
  25a5e3:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a5e8:	cmp    %r14,%rax
  25a5eb:	jae    25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a5f1:	movzwl 0x82(%rsp,%rax,2),%ecx
  25a5f9:	lea    0x2(%rax),%rbx
  25a5fd:	cmp    $0x5,%ecx
  25a600:	je     25a826 <<glass::engine::Engine>::apply+0x1476>
  25a606:	cmp    $0x2,%ecx
  25a609:	jne    25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a60f:	cmp    %r14,%rbx
  25a612:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a618:	movzwl 0x84(%rsp,%rax,2),%ecx
  25a620:	lea    0x3(%rax),%rbx
  25a624:	cmp    $0xff,%ecx
  25a62a:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a630:	cmp    %r14,%rbx
  25a633:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a639:	movzwl 0x86(%rsp,%rax,2),%edx
  25a641:	lea    0x4(%rax),%rbx
  25a645:	cmp    $0xff,%edx
  25a64b:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a651:	cmp    %r14,%rbx
  25a654:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a65a:	movzwl 0x88(%rsp,%rax,2),%edi
  25a662:	add    $0x5,%rax
  25a666:	cmp    $0xff,%edi
  25a66c:	ja     25a876 <<glass::engine::Engine>::apply+0x14c6>
  25a672:	shl    $0x10,%edi
  25a675:	movzwl %dx,%edx
  25a678:	shl    $0x8,%edx
  25a67b:	or     %edx,%ecx
  25a67d:	movzwl %cx,%esi
  25a680:	or     %edi,%esi
  25a682:	mov    $0x1,%ecx
  25a687:	jmp    25a848 <<glass::engine::Engine>::apply+0x1498>
  25a68c:	mov    $0x10,%cx
  25a690:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a695:	mov    $0x16,%cx
  25a699:	mov    $0x1000000,%esi
  25a69e:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6a3:	mov    $0xf,%cx
  25a6a7:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6ac:	mov    $0x9,%cx
  25a6b0:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6b5:	mov    $0x12,%cx
  25a6b9:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6be:	mov    $0x13,%cx
  25a6c2:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6c7:	mov    $0xb,%cx
  25a6cb:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6d0:	mov    $0xd,%cx
  25a6d4:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6d9:	mov    $0x15,%cx
  25a6dd:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6e2:	mov    $0x14,%cx
  25a6e6:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a6eb:	cmp    %r14,%rax
  25a6ee:	jae    25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a6f4:	movzwl 0x82(%rsp,%rax,2),%ecx
  25a6fc:	lea    0x2(%rax),%rbx
  25a700:	cmp    $0x5,%ecx
  25a703:	je     25a859 <<glass::engine::Engine>::apply+0x14a9>
  25a709:	cmp    $0x2,%ecx
  25a70c:	jne    25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a712:	cmp    %r14,%rbx
  25a715:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a71b:	movzwl 0x84(%rsp,%rax,2),%ecx
  25a723:	lea    0x3(%rax),%rbx
  25a727:	cmp    $0xff,%ecx
  25a72d:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a733:	cmp    %r14,%rbx
  25a736:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a73c:	movzwl 0x86(%rsp,%rax,2),%edx
  25a744:	lea    0x4(%rax),%rbx
  25a748:	cmp    $0xff,%edx
  25a74e:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a754:	cmp    %r14,%rbx
  25a757:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a75d:	movzwl 0x88(%rsp,%rax,2),%edi
  25a765:	add    $0x5,%rax
  25a769:	cmp    $0xff,%edi
  25a76f:	ja     25a876 <<glass::engine::Engine>::apply+0x14c6>
  25a775:	shl    $0x10,%edi
  25a778:	movzwl %dx,%edx
  25a77b:	shl    $0x8,%edx
  25a77e:	or     %edx,%ecx
  25a780:	movzwl %cx,%esi
  25a783:	or     %edi,%esi
  25a785:	mov    $0x1,%ecx
  25a78a:	jmp    25a8a4 <<glass::engine::Engine>::apply+0x14f4>
  25a78f:	lea    -0x1e(%rcx),%eax
  25a792:	cmp    $0x8,%ax
  25a796:	jae    25a7b0 <<glass::engine::Engine>::apply+0x1400>
  25a798:	lea    -0x1fefaf(%rip),%rax        # 5b7f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0xa30>
  25a79f:	movzwl -0x3c(%rax,%rcx,2),%esi
  25a7a4:	shl    $0x10,%esi
  25a7a7:	mov    $0x16,%cx
  25a7ab:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a7b0:	mov    %ecx,%eax
  25a7b2:	and    $0xfff8,%eax
  25a7b7:	cmp    $0x28,%ax
  25a7bb:	jne    25a7d5 <<glass::engine::Engine>::apply+0x1425>
  25a7bd:	lea    -0x1fefd4(%rip),%rax        # 5b7f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0xa30>
  25a7c4:	movzwl -0x50(%rax,%rcx,2),%esi
  25a7c9:	shl    $0x10,%esi
  25a7cc:	mov    $0x17,%cx
  25a7d0:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a7d5:	lea    -0x5a(%rcx),%eax
  25a7d8:	cmp    $0x8,%ax
  25a7dc:	jae    25a87e <<glass::engine::Engine>::apply+0x14ce>
  25a7e2:	lea    -0x1fd1b9(%rip),%rax        # 5d630 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0x110>
  25a7e9:	movzwl -0xb4(%rax,%rcx,2),%esi
  25a7f1:	jmp    25a7a4 <<glass::engine::Engine>::apply+0x13f4>
  25a7f3:	cmp    %r14,%rbx
  25a7f6:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a7fc:	movzwl 0x84(%rsp,%rax,2),%esi
  25a804:	add    $0x3,%rax
  25a808:	cmp    $0xff,%esi
  25a80e:	ja     25a876 <<glass::engine::Engine>::apply+0x14c6>
  25a810:	mov    $0x2,%ecx
  25a815:	shl    $0x8,%esi
  25a818:	or     %ecx,%esi
  25a81a:	mov    $0x16,%cx
  25a81e:	mov    %rax,%rbx
  25a821:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a826:	cmp    %r14,%rbx
  25a829:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a82f:	movzwl 0x84(%rsp,%rax,2),%esi
  25a837:	add    $0x3,%rax
  25a83b:	cmp    $0xff,%esi
  25a841:	ja     25a876 <<glass::engine::Engine>::apply+0x14c6>
  25a843:	mov    $0x2,%ecx
  25a848:	shl    $0x8,%esi
  25a84b:	or     %ecx,%esi
  25a84d:	mov    $0x18,%cx
  25a851:	mov    %rax,%rbx
  25a854:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a859:	cmp    %r14,%rbx
  25a85c:	ja     25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a862:	movzwl 0x84(%rsp,%rax,2),%esi
  25a86a:	add    $0x3,%rax
  25a86e:	cmp    $0xff,%esi
  25a874:	jbe    25a89f <<glass::engine::Engine>::apply+0x14ef>
  25a876:	mov    %rax,%rbx
  25a879:	jmp    25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a87e:	lea    -0x64(%rcx),%eax
  25a881:	cmp    $0x8,%ax
  25a885:	jae    25a4f2 <<glass::engine::Engine>::apply+0x1142>
  25a88b:	lea    -0x1fd262(%rip),%rax        # 5d630 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0x110>
  25a892:	movzwl -0xc8(%rax,%rcx,2),%esi
  25a89a:	jmp    25a7c9 <<glass::engine::Engine>::apply+0x1419>
  25a89f:	mov    $0x2,%ecx
  25a8a4:	shl    $0x8,%esi
  25a8a7:	or     %ecx,%esi
  25a8a9:	mov    $0x17,%cx
  25a8ad:	mov    %rax,%rbx
  25a8b0:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1130>
  25a8b5:	mov    $0x1,%al
  25a8b7:	mov    %eax,0xd0(%rsp)
  25a8be:	mov    %r8,%r13
  25a8c1:	mov    0x8(%rsp),%rax
  25a8c6:	mov    %rax,0xe8(%rsp)
  25a8ce:	mov    $0x1,%al
  25a8d0:	mov    %rax,0x58(%rsp)
  25a8d5:	mov    0x120(%rsp),%rbx
  25a8dd:	jmp    259e55 <<glass::engine::Engine>::apply+0xaa5>
  25a8e2:	xor    %eax,%eax
  25a8e4:	movzwl %cx,%edx
  25a8e7:	dec    %rdx
  25a8ea:	test   $0x1,%al
  25a8ec:	mov    $0x0,%eax
  25a8f1:	cmove  %rax,%rdx
  25a8f5:	mov    0x1a8(%rsp),%rdi
  25a8fd:	call   34f950 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  25a902:	mov    0x10(%rsp),%r8
  25a907:	mov    0x120(%rsp),%rbx
  25a90f:	lea    (%rbx,%r8,1),%r13
  25a913:	movb   $0x0,0xa80(%r12)
  25a91c:	movb   $0x0,0xa7e(%r12)
  25a925:	mov    $0x1,%al
  25a927:	mov    %eax,0xd0(%rsp)
  25a92e:	mov    %r13,0x8(%rsp)
  25a933:	mov    %r13,0xe8(%rsp)
  25a93b:	mov    $0x1,%al
  25a93d:	mov    %rax,0x58(%rsp)
  25a942:	jmp    259e55 <<glass::engine::Engine>::apply+0xaa5>
  25a947:	mov    $0x2,%edx
  25a94c:	jmp    25a165 <<glass::engine::Engine>::apply+0xdb5>
  25a951:	call   18c8f6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25a956:	jmp    25a201 <<glass::engine::Engine>::apply+0xe51>
  25a95b:	call   18c8f6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25a960:	jmp    25a295 <<glass::engine::Engine>::apply+0xee5>
  25a965:	mov    0x8(%rsp),%rax
  25a96a:	movzbl (%rax),%eax
  25a96d:	mov    %rax,0xd0(%rsp)
  25a975:	add    $0xffffffe0,%eax
  25a978:	mov    $0x1,%r15d
  25a97e:	cmp    $0x5f,%al
  25a980:	jb     25a9ad <<glass::engine::Engine>::apply+0x15fd>
  25a982:	mov    0xd0(%rsp),%rdi
  25a98a:	call   2a30f0 <glass::engine::width_of>
  25a98f:	mov    0x38(%rsp),%r12
  25a994:	mov    %rdx,%r15
  25a997:	lea    -0x1(%rdx),%rcx
  25a99b:	cmp    $0x2,%rcx
  25a99f:	setb   %cl
  25a9a2:	and    %al,%cl
  25a9a4:	cmp    $0x1,%cl
  25a9a7:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a9ad:	cmpb   $0x0,0x6c(%r13)
  25a9b2:	mov    0x38(%rsp),%r12
  25a9b7:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25a9bd:	mov    0x40(%r13),%rdx
  25a9c1:	mov    0xa0(%r13),%rcx
  25a9c8:	mov    %rdx,0x30(%rsp)
  25a9cd:	lea    (%rdx,%r15,1),%rax
  25a9d1:	mov    %rax,0x118(%rsp)
  25a9d9:	mov    %rcx,0x220(%rsp)
  25a9e1:	cmp    %rcx,%rax
  25a9e4:	ja     25a312 <<glass::engine::Engine>::apply+0xf62>
  25a9ea:	lea    0x10(%r13),%rdi
  25a9ee:	mov    0x48(%r13),%esi
  25a9f2:	mov    0x58(%r13),%eax
  25a9f6:	mov    %eax,0xfc(%rsp)
  25a9fd:	mov    0x5c(%r13),%eax
  25aa01:	mov    %eax,0xf8(%rsp)
  25aa08:	movzwl 0x64(%r13),%eax
  25aa0d:	mov    %eax,0x100(%rsp)
  25aa14:	lea    0x372445(%rip),%rdx        # 5cce60 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x156e0>
  25aa1b:	call   30e6c0 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  25aa20:	mov    %rax,%rcx
  25aa23:	add    $0x18,%rcx
  25aa27:	mov    %rcx,0x108(%rsp)
  25aa2f:	mov    %rax,0x20(%rsp)
  25aa34:	mov    0x28(%rax),%eax
  25aa37:	cmp    $0xffffffff,%eax
  25aa3a:	je     25aa54 <<glass::engine::Engine>::apply+0x16a4>
  25aa3c:	mov    0x108(%rsp),%rcx
  25aa44:	mov    0x30(%rsp),%rdx
  25aa49:	mov    0x20(%rsp),%rsi
  25aa4e:	cmp    0x30(%rsi),%rdx
  25aa52:	jae    25aa7e <<glass::engine::Engine>::apply+0x16ce>
  25aa54:	mov    0x20(%rsp),%rcx
  25aa59:	mov    0x10(%rcx),%rcx
  25aa5d:	cmp    %rcx,0x30(%rsp)
  25aa62:	jae    25b861 <<glass::engine::Engine>::apply+0x24b1>
  25aa68:	mov    0x30(%rsp),%rcx
  25aa6d:	lea    (%rcx,%rcx,2),%rcx
  25aa71:	shl    $0x3,%rcx
  25aa75:	mov    0x20(%rsp),%rdx
  25aa7a:	add    0x8(%rdx),%rcx
  25aa7e:	testb  $0x60,0x14(%rcx)
  25aa82:	mov    0x38(%rsp),%r12
  25aa87:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25aa8d:	cmp    $0x2,%r15
  25aa91:	jne    25aae5 <<glass::engine::Engine>::apply+0x1735>
  25aa93:	mov    0x30(%rsp),%rcx
  25aa98:	inc    %rcx
  25aa9b:	cmp    $0xffffffff,%eax
  25aa9e:	je     25aab3 <<glass::engine::Engine>::apply+0x1703>
  25aaa0:	mov    0x108(%rsp),%rdx
  25aaa8:	mov    0x20(%rsp),%rsi
  25aaad:	cmp    0x30(%rsi),%rcx
  25aab1:	jae    25aad6 <<glass::engine::Engine>::apply+0x1726>
  25aab3:	mov    0x20(%rsp),%rdx
  25aab8:	mov    0x10(%rdx),%rdx
  25aabc:	cmp    %rdx,%rcx
  25aabf:	jae    25b877 <<glass::engine::Engine>::apply+0x24c7>
  25aac5:	lea    (%rcx,%rcx,2),%rdx
  25aac9:	shl    $0x3,%rdx
  25aacd:	mov    0x20(%rsp),%rcx
  25aad2:	add    0x8(%rcx),%rdx
  25aad6:	testb  $0x60,0x14(%rdx)
  25aada:	mov    0x38(%rsp),%r12
  25aadf:	jne    25a312 <<glass::engine::Engine>::apply+0xf62>
  25aae5:	mov    0x30(%rsp),%rcx
  25aaea:	mov    0x20(%rsp),%rdx
  25aaef:	cmp    %ecx,0x38(%rdx)
  25aaf2:	jbe    25ab01 <<glass::engine::Engine>::apply+0x1751>
  25aaf4:	mov    0x30(%rsp),%rcx
  25aaf9:	mov    0x20(%rsp),%rdx
  25aafe:	mov    %ecx,0x38(%rdx)
  25ab01:	cmp    $0xffffffff,%eax
  25ab04:	setne  %cl
  25ab07:	mov    0x20(%rsp),%rdx
  25ab0c:	mov    0x30(%rdx),%r12
  25ab10:	cmp    %r12,0x30(%rsp)
  25ab15:	sete   %dl
  25ab18:	test   %dl,%cl
  25ab1a:	jne    25ac28 <<glass::engine::Engine>::apply+0x1878>
  25ab20:	cmp    $0xffffffff,%eax
  25ab23:	je     25ad82 <<glass::engine::Engine>::apply+0x19d2>
  25ab29:	mov    0x20(%rsp),%rax
  25ab2e:	mov    0x10(%rax),%rbp
  25ab32:	cmp    %r12,%rbp
  25ab35:	mov    %r12,%rax
  25ab38:	cmovb  %rbp,%rax
  25ab3c:	mov    %rax,0x68(%rsp)
  25ab41:	mov    0x30(%rsp),%rax
  25ab46:	cmp    %rax,%rbp
  25ab49:	cmovb  %rbp,%rax
  25ab4d:	mov    %rax,0x40(%rsp)
  25ab52:	mov    0x39b227(%rip),%rax        # 5f5d80 <_DYNAMIC+0x320>
  25ab59:	movzbl (%rax),%eax
  25ab5c:	test   %al,%al
  25ab5e:	je     25ab89 <<glass::engine::Engine>::apply+0x17d9>
  25ab60:	mov    0x39b251(%rip),%rax        # 5f5db8 <_DYNAMIC+0x358>
  25ab67:	cmp    0x40(%rsp),%r12
  25ab6c:	jae    25ab75 <<glass::engine::Engine>::apply+0x17c5>
  25ab6e:	mov    0x39b24b(%rip),%rax        # 5f5dc0 <_DYNAMIC+0x360>
  25ab75:	lock incq 0x28(%rax)
  25ab7a:	mov    0x40(%rsp),%rdi
  25ab7f:	sub    0x68(%rsp),%rdi
  25ab84:	call   2f9c60 <alacritty_terminal::grid::row::fill_census::note>
  25ab89:	cmp    0x40(%rsp),%r12
  25ab8e:	jae    25ad62 <<glass::engine::Engine>::apply+0x19b2>
  25ab94:	mov    0x20(%rsp),%rax
  25ab99:	mov    0x28(%rax),%ecx
  25ab9c:	mov    %ecx,0x54(%rsp)
  25aba0:	mov    0x20(%rax),%ecx
  25aba3:	mov    %ecx,0x50(%rsp)
  25aba7:	mov    0x24(%rax),%ecx
  25abaa:	mov    %ecx,0x4c(%rsp)
  25abae:	movzwl 0x2c(%rax),%ecx
  25abb2:	mov    %cx,0x70(%rsp)
  25abb7:	mov    0x18(%rax),%rax
  25abbb:	mov    %rax,0x8(%rsp)
  25abc0:	test   %rax,%rax
  25abc3:	je     25ac4c <<glass::engine::Engine>::apply+0x189c>
  25abc9:	mov    0x8(%rsp),%rax
  25abce:	lock incq (%rax)
  25abd2:	jle    25b8df <<glass::engine::Engine>::apply+0x252f>
  25abd8:	mov    0x20(%rsp),%rax
  25abdd:	mov    0x10(%rax),%rdx
  25abe1:	mov    0x54(%rsp),%eax
  25abe5:	mov    %eax,0xc0(%rsp)
  25abec:	mov    0x50(%rsp),%eax
  25abf0:	mov    %eax,0xb8(%rsp)
  25abf7:	mov    0x4c(%rsp),%eax
  25abfb:	mov    %eax,0xbc(%rsp)
  25ac02:	movzwl 0x70(%rsp),%eax
  25ac07:	mov    %ax,0xc4(%rsp)
  25ac0f:	mov    0x8(%rsp),%rax
  25ac14:	mov    %rax,0xb0(%rsp)
  25ac1c:	cmp    %rdx,0x40(%rsp)
  25ac21:	jbe    25ac87 <<glass::engine::Engine>::apply+0x18d7>
  25ac23:	jmp    25b88b <<glass::engine::Engine>::apply+0x24db>
  25ac28:	mov    0x30(%rsp),%rcx
  25ac2d:	lea    0x1(%rcx),%rax
  25ac31:	mov    0x20(%rsp),%rdx
  25ac36:	mov    %rax,0x30(%rdx)
  25ac3a:	mov    0x10(%rdx),%rax
  25ac3e:	cmp    %rax,%rcx
  25ac41:	jb     25adac <<glass::engine::Engine>::apply+0x19fc>
  25ac47:	jmp    25b8a4 <<glass::engine::Engine>::apply+0x24f4>
  25ac4c:	mov    0x54(%rsp),%eax
  25ac50:	mov    %eax,0xc0(%rsp)
  25ac57:	mov    0x50(%rsp),%eax
  25ac5b:	mov    %eax,0xb8(%rsp)
  25ac62:	mov    0x4c(%rsp),%eax
  25ac66:	mov    %eax,0xbc(%rsp)
  25ac6d:	movzwl 0x70(%rsp),%eax
  25ac72:	mov    %ax,0xc4(%rsp)
  25ac7a:	mov    0x8(%rsp),%rax
  25ac7f:	mov    %rax,0xb0(%rsp)
  25ac87:	mov    0x68(%rsp),%rax
  25ac8c:	lea    0x0(,%rax,8),%rax
  25ac94:	lea    (%rax,%rax,2),%rax
  25ac98:	mov    0x20(%rsp),%rcx
  25ac9d:	mov    0x8(%rcx),%rbp
  25aca1:	add    %rax,%rbp
  25aca4:	mov    0x40(%rsp),%rcx
  25aca9:	lea    0x0(,%rcx,8),%rcx
  25acb1:	lea    (%rcx,%rcx,2),%r12
  25acb5:	sub    %rax,%r12
  25acb8:	jmp    25aceb <<glass::engine::Engine>::apply+0x193b>
  25acba:	mov    0x8(%rsp),%rax
  25acbf:	mov    %rax,0x0(%rbp)
  25acc3:	mov    0x50(%rsp),%eax
  25acc7:	mov    %eax,0x8(%rbp)
  25acca:	mov    0x4c(%rsp),%eax
  25acce:	mov    %eax,0xc(%rbp)
  25acd1:	mov    0x54(%rsp),%eax
  25acd5:	mov    %eax,0x10(%rbp)
  25acd8:	movzwl 0x70(%rsp),%eax
  25acdd:	mov    %ax,0x14(%rbp)
  25ace1:	add    $0x18,%rbp
  25ace5:	add    $0xffffffffffffffe8,%r12
  25ace9:	je     25ad1c <<glass::engine::Engine>::apply+0x196c>
  25aceb:	cmpq   $0x0,0x8(%rsp)
  25acf1:	je     25ad02 <<glass::engine::Engine>::apply+0x1952>
  25acf3:	mov    0x8(%rsp),%rax
  25acf8:	lock incq (%rax)
  25acfc:	jle    25b8df <<glass::engine::Engine>::apply+0x252f>
  25ad02:	mov    0x0(%rbp),%rax
  25ad06:	test   %rax,%rax
  25ad09:	je     25acba <<glass::engine::Engine>::apply+0x190a>
  25ad0b:	lock decq (%rax)
  25ad0f:	jne    25acba <<glass::engine::Engine>::apply+0x190a>
  25ad11:	mov    %rbp,%rdi
  25ad14:	call   *0x39afae(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  25ad1a:	jmp    25acba <<glass::engine::Engine>::apply+0x190a>
  25ad1c:	mov    0x20(%rsp),%rax
  25ad21:	mov    0x68(%rsp),%rcx
  25ad26:	cmp    %ecx,0x38(%rax)
  25ad29:	jbe    25ad38 <<glass::engine::Engine>::apply+0x1988>
  25ad2b:	mov    0x20(%rsp),%rax
  25ad30:	mov    0x68(%rsp),%rcx
  25ad35:	mov    %ecx,0x38(%rax)
  25ad38:	cmpq   $0x0,0x8(%rsp)
  25ad3e:	je     25ad59 <<glass::engine::Engine>::apply+0x19a9>
  25ad40:	mov    0x8(%rsp),%rax
  25ad45:	lock decq (%rax)
  25ad49:	jne    25ad59 <<glass::engine::Engine>::apply+0x19a9>
  25ad4b:	lea    0xb0(%rsp),%rdi
  25ad53:	call   *0x39af6f(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  25ad59:	mov    0x20(%rsp),%rax
  25ad5e:	mov    0x10(%rax),%rbp
  25ad62:	cmp    %rbp,0x40(%rsp)
  25ad67:	jb     25ad82 <<glass::engine::Engine>::apply+0x19d2>
  25ad69:	mov    0x108(%rsp),%rdi
  25ad71:	call   1ae350 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  25ad76:	mov    0x20(%rsp),%rax
  25ad7b:	movl   $0xffffffff,0x28(%rax)
  25ad82:	mov    0x20(%rsp),%rsi
  25ad87:	mov    0x30(%rsi),%rcx
  25ad8b:	mov    0x30(%rsp),%rdx
  25ad90:	lea    0x1(%rdx),%rax
  25ad94:	cmp    %rcx,%rax
  25ad97:	cmova  %rax,%rcx
  25ad9b:	mov    0x10(%rsi),%rax
  25ad9f:	mov    %rcx,0x30(%rsi)
  25ada3:	cmp    %rax,%rdx
  25ada6:	jae    25b8ab <<glass::engine::Engine>::apply+0x24fb>
  25adac:	mov    0x100(%rsp),%edi
  25adb3:	mov    %edi,%eax
  25adb5:	or     $0x20,%eax
  25adb8:	cmp    $0x2,%r15
  25adbc:	mov    0x20(%rsp),%rcx
  25adc1:	mov    0x8(%rcx),%rcx
  25adc5:	mov    0x30(%rsp),%rdx
  25adca:	lea    (%rdx,%rdx,2),%rdx
  25adce:	lea    (%rcx,%rdx,8),%rbp
  25add2:	mov    0xd0(%rsp),%rsi
  25adda:	mov    %esi,0x10(%rcx,%rdx,8)
  25adde:	mov    0xfc(%rsp),%esi
  25ade5:	mov    %esi,0x8(%rcx,%rdx,8)
  25ade9:	cmovne %edi,%eax
  25adec:	mov    0xf8(%rsp),%esi
  25adf3:	mov    %esi,0xc(%rcx,%rdx,8)
  25adf7:	mov    %ax,0x14(%rcx,%rdx,8)
  25adfc:	mov    (%rcx,%rdx,8),%rax
  25ae00:	test   %rax,%rax
  25ae03:	je     25ae14 <<glass::engine::Engine>::apply+0x1a64>
  25ae05:	lock decq (%rax)
  25ae09:	jne    25ae14 <<glass::engine::Engine>::apply+0x1a64>
  25ae0b:	mov    %rbp,%rdi
  25ae0e:	call   *0x39aeb4(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  25ae14:	movq   $0x0,0x0(%rbp)
  25ae1c:	cmp    $0x2,%r15
  25ae20:	jne    25b112 <<glass::engine::Engine>::apply+0x1d62>
  25ae26:	mov    0x30(%rsp),%rax
  25ae2b:	lea    0x1(%rax),%rdx
  25ae2f:	mov    0x20(%rsp),%rax
  25ae34:	mov    0x30(%rax),%r15
  25ae38:	mov    0x28(%rax),%eax
  25ae3b:	mov    %rdx,0x70(%rsp)
  25ae40:	cmp    %r15,%rdx
  25ae43:	jne    25ae70 <<glass::engine::Engine>::apply+0x1ac0>
  25ae45:	cmp    $0xffffffff,%eax
  25ae48:	je     25ae70 <<glass::engine::Engine>::apply+0x1ac0>
  25ae4a:	mov    0x30(%rsp),%rax
  25ae4f:	add    $0x2,%rax
  25ae53:	mov    0x20(%rsp),%rcx
  25ae58:	mov    %rax,0x30(%rcx)
  25ae5c:	mov    0x10(%rcx),%rax
  25ae60:	cmp    %rax,0x70(%rsp)
  25ae65:	jb     25b0b0 <<glass::engine::Engine>::apply+0x1d00>
  25ae6b:	jmp    25b8b2 <<glass::engine::Engine>::apply+0x2502>
  25ae70:	cmp    $0xffffffff,%eax
  25ae73:	je     25b084 <<glass::engine::Engine>::apply+0x1cd4>
  25ae79:	mov    0x20(%rsp),%rax
  25ae7e:	mov    0x10(%rax),%r12
  25ae82:	cmp    %r15,%r12
  25ae85:	mov    %r15,%rax
  25ae88:	cmovb  %r12,%rax
  25ae8c:	mov    %rax,0x68(%rsp)
  25ae91:	mov    0x70(%rsp),%rax
  25ae96:	cmp    %rax,%r12
  25ae99:	cmovb  %r12,%rax
  25ae9d:	mov    %rax,0x40(%rsp)
  25aea2:	mov    0x39aed7(%rip),%rax        # 5f5d80 <_DYNAMIC+0x320>
  25aea9:	movzbl (%rax),%eax
  25aeac:	test   %al,%al
  25aeae:	je     25aed9 <<glass::engine::Engine>::apply+0x1b29>
  25aeb0:	mov    0x39af01(%rip),%rax        # 5f5db8 <_DYNAMIC+0x358>
  25aeb7:	cmp    0x40(%rsp),%r15
  25aebc:	jae    25aec5 <<glass::engine::Engine>::apply+0x1b15>
  25aebe:	mov    0x39aefb(%rip),%rax        # 5f5dc0 <_DYNAMIC+0x360>
  25aec5:	lock incq 0x28(%rax)
  25aeca:	mov    0x40(%rsp),%rdi
  25aecf:	sub    0x68(%rsp),%rdi
  25aed4:	call   2f9c60 <alacritty_terminal::grid::row::fill_census::note>
  25aed9:	cmp    0x40(%rsp),%r15
  25aede:	jae    25b064 <<glass::engine::Engine>::apply+0x1cb4>
  25aee4:	mov    0x20(%rsp),%rax
  25aee9:	mov    0x28(%rax),%ecx
  25aeec:	mov    %ecx,0x8(%rsp)
  25aef0:	mov    0x20(%rax),%ecx
  25aef3:	mov    %ecx,0x54(%rsp)
  25aef7:	mov    0x24(%rax),%ecx
  25aefa:	mov    %ecx,0x50(%rsp)
  25aefe:	movzwl 0x2c(%rax),%ecx
  25af02:	mov    %cx,0x4c(%rsp)
  25af07:	mov    0x18(%rax),%r12
  25af0b:	test   %r12,%r12
  25af0e:	je     25af66 <<glass::engine::Engine>::apply+0x1bb6>
  25af10:	lock incq (%r12)
  25af15:	jle    25b8df <<glass::engine::Engine>::apply+0x252f>
  25af1b:	mov    0x20(%rsp),%rax
  25af20:	mov    0x10(%rax),%rdx
  25af24:	mov    0x8(%rsp),%eax
  25af28:	mov    %eax,0xc0(%rsp)
  25af2f:	mov    0x54(%rsp),%eax
  25af33:	mov    %eax,0xb8(%rsp)
  25af3a:	mov    0x50(%rsp),%eax
  25af3e:	mov    %eax,0xbc(%rsp)
  25af45:	movzwl 0x4c(%rsp),%eax
  25af4a:	mov    %ax,0xc4(%rsp)
  25af52:	mov    %r12,0xb0(%rsp)
  25af5a:	cmp    %rdx,0x40(%rsp)
  25af5f:	jbe    25af9c <<glass::engine::Engine>::apply+0x1bec>
  25af61:	jmp    25b8c8 <<glass::engine::Engine>::apply+0x2518>
  25af66:	mov    0x8(%rsp),%eax
  25af6a:	mov    %eax,0xc0(%rsp)
  25af71:	mov    0x54(%rsp),%eax
  25af75:	mov    %eax,0xb8(%rsp)
  25af7c:	mov    0x50(%rsp),%eax
  25af80:	mov    %eax,0xbc(%rsp)
  25af87:	movzwl 0x4c(%rsp),%eax
  25af8c:	mov    %ax,0xc4(%rsp)
  25af94:	mov    %r12,0xb0(%rsp)
  25af9c:	mov    0x68(%rsp),%rax
  25afa1:	lea    0x0(,%rax,8),%rax
  25afa9:	lea    (%rax,%rax,2),%rax
  25afad:	mov    0x20(%rsp),%rcx
  25afb2:	mov    0x8(%rcx),%rbp
  25afb6:	add    %rax,%rbp
  25afb9:	mov    0x40(%rsp),%rcx
  25afbe:	lea    0x0(,%rcx,8),%rcx
  25afc6:	lea    (%rcx,%rcx,2),%r15
  25afca:	sub    %rax,%r15
  25afcd:	jmp    25affb <<glass::engine::Engine>::apply+0x1c4b>
  25afcf:	mov    %r12,0x0(%rbp)
  25afd3:	mov    0x54(%rsp),%eax
  25afd7:	mov    %eax,0x8(%rbp)
  25afda:	mov    0x50(%rsp),%eax
  25afde:	mov    %eax,0xc(%rbp)
  25afe1:	mov    0x8(%rsp),%eax
  25afe5:	mov    %eax,0x10(%rbp)
  25afe8:	movzwl 0x4c(%rsp),%eax
  25afed:	mov    %ax,0x14(%rbp)
  25aff1:	add    $0x18,%rbp
  25aff5:	add    $0xffffffffffffffe8,%r15
  25aff9:	je     25b025 <<glass::engine::Engine>::apply+0x1c75>
  25affb:	test   %r12,%r12
  25affe:	je     25b00b <<glass::engine::Engine>::apply+0x1c5b>
  25b000:	lock incq (%r12)
  25b005:	jle    25b8df <<glass::engine::Engine>::apply+0x252f>
  25b00b:	mov    0x0(%rbp),%rax
  25b00f:	test   %rax,%rax
  25b012:	je     25afcf <<glass::engine::Engine>::apply+0x1c1f>
  25b014:	lock decq (%rax)
  25b018:	jne    25afcf <<glass::engine::Engine>::apply+0x1c1f>
  25b01a:	mov    %rbp,%rdi
  25b01d:	call   *0x39aca5(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  25b023:	jmp    25afcf <<glass::engine::Engine>::apply+0x1c1f>
  25b025:	mov    0x20(%rsp),%rax
  25b02a:	mov    0x68(%rsp),%rcx
  25b02f:	cmp    %ecx,0x38(%rax)
  25b032:	jbe    25b041 <<glass::engine::Engine>::apply+0x1c91>
  25b034:	mov    0x20(%rsp),%rax
  25b039:	mov    0x68(%rsp),%rcx
  25b03e:	mov    %ecx,0x38(%rax)
  25b041:	test   %r12,%r12
  25b044:	je     25b05b <<glass::engine::Engine>::apply+0x1cab>
  25b046:	lock decq (%r12)
  25b04b:	jne    25b05b <<glass::engine::Engine>::apply+0x1cab>
  25b04d:	lea    0xb0(%rsp),%rdi
  25b055:	call   *0x39ac6d(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  25b05b:	mov    0x20(%rsp),%rax
  25b060:	mov    0x10(%rax),%r12
  25b064:	cmp    %r12,0x40(%rsp)
  25b069:	jb     25b084 <<glass::engine::Engine>::apply+0x1cd4>
  25b06b:	mov    0x108(%rsp),%rdi
  25b073:	call   1ae350 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  25b078:	mov    0x20(%rsp),%rax
  25b07d:	movl   $0xffffffff,0x28(%rax)
  25b084:	mov    0x20(%rsp),%rdx
  25b089:	mov    0x30(%rdx),%rax
  25b08d:	mov    0x30(%rsp),%rcx
  25b092:	add    $0x2,%rcx
  25b096:	cmp    %rax,%rcx
  25b099:	cmovbe %rax,%rcx
  25b09d:	mov    0x10(%rdx),%rax
  25b0a1:	mov    %rcx,0x30(%rdx)
  25b0a5:	cmp    %rax,0x70(%rsp)
  25b0aa:	jae    25b8e1 <<glass::engine::Engine>::apply+0x2531>
  25b0b0:	mov    0x20(%rsp),%rax
  25b0b5:	mov    0x8(%rax),%rax
  25b0b9:	mov    0x70(%rsp),%rcx
  25b0be:	lea    (%rcx,%rcx,2),%rcx
  25b0c2:	lea    (%rax,%rcx,8),%r15
  25b0c6:	movl   $0x20,0x10(%rax,%rcx,8)
  25b0ce:	mov    0xfc(%rsp),%edx
  25b0d5:	mov    %edx,0x8(%rax,%rcx,8)
  25b0d9:	mov    0xf8(%rsp),%edx
  25b0e0:	mov    %edx,0xc(%rax,%rcx,8)
  25b0e4:	mov    0x100(%rsp),%edx
  25b0eb:	or     $0x40,%edx
  25b0ee:	mov    %dx,0x14(%rax,%rcx,8)
  25b0f3:	mov    (%rax,%rcx,8),%rax
  25b0f7:	test   %rax,%rax
  25b0fa:	je     25b10b <<glass::engine::Engine>::apply+0x1d5b>
  25b0fc:	lock decq (%rax)
  25b100:	jne    25b10b <<glass::engine::Engine>::apply+0x1d5b>
  25b102:	mov    %r15,%rdi
  25b105:	call   *0x39abbd(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  25b10b:	movq   $0x0,(%r15)
  25b112:	mov    0x220(%rsp),%rax
  25b11a:	cmp    %rax,0x118(%rsp)
  25b122:	jb     25b131 <<glass::engine::Engine>::apply+0x1d81>
  25b124:	decq   0x118(%rsp)
  25b12c:	movb   $0x1,0x6c(%r13)
  25b131:	mov    0x118(%rsp),%rax
  25b139:	mov    %rax,0x40(%r13)
  25b13d:	incq   0x1d0(%rsp)
  25b145:	mov    0xd0(%rsp),%rax
  25b14d:	mov    %eax,0x1e0(%rsp)
  25b154:	mov    $0x1,%r15d
  25b15a:	mov    0x38(%rsp),%r12
  25b15f:	mov    0x39dadb(%rip),%eax        # 5f8c40 <glass::engine::run_whole::ON>
  25b165:	test   %eax,%eax
  25b167:	je     25a338 <<glass::engine::Engine>::apply+0xf88>
  25b16d:	call   18c8f6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25b172:	jmp    25a338 <<glass::engine::Engine>::apply+0xf88>
  25b177:	nopw   0x0(%rax,%rax,1)
  25b180:	mov    0x39b391(%rip),%rax        # 5f6518 <_DYNAMIC+0xab8>
  25b187:	mov    (%rax),%rax
  25b18a:	mov    $0x1b,%edi
  25b18f:	mov    %r14,%rsi
  25b192:	mov    0x110(%rsp),%rbx
  25b19a:	mov    %rbx,%rdx
  25b19d:	call   *%rax
  25b19f:	mov    %r14,%r13
  25b1a2:	mov    %rbx,%r14
  25b1a5:	cmp    $0x1,%rax
  25b1a9:	jne    25b460 <<glass::engine::Engine>::apply+0x20b0>
  25b1af:	mov    %rdx,%rcx
  25b1b2:	sub    %r13,%rcx
  25b1b5:	movb   $0x1,0xa80(%r12)
  25b1be:	movb   $0x0,0xa7e(%r12)
  25b1c7:	inc    %rcx
  25b1ca:	cmp    %r15,%rcx
  25b1cd:	jb     25b46b <<glass::engine::Engine>::apply+0x20bb>
  25b1d3:	movzbl 0xa7e(%r12),%eax
  25b1dc:	jmp    25b561 <<glass::engine::Engine>::apply+0x21b1>
  25b1e1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25b1f0:	mov    0x18(%rsp),%r15
  25b1f5:	cmp    %rbp,%r15
  25b1f8:	jb     25b7af <<glass::engine::Engine>::apply+0x23ff>
  25b1fe:	mov    0x28(%rsp),%r13
  25b203:	mov    %r13,%rbx
  25b206:	add    %rbp,%rbx
  25b209:	mov    0x39b308(%rip),%rax        # 5f6518 <_DYNAMIC+0xab8>
  25b210:	mov    (%rax),%rax
  25b213:	mov    $0x1b,%edi
  25b218:	mov    %rbx,%rsi
  25b21b:	mov    0x110(%rsp),%r14
  25b223:	mov    %r14,%rdx
  25b226:	call   *%rax
  25b228:	cmp    $0x1,%rax
  25b22c:	jne    25b249 <<glass::engine::Engine>::apply+0x1e99>
  25b22e:	sub    %rbx,%rdx
  25b231:	movb   $0x1,0xa80(%r12)
  25b23a:	movb   $0x0,0xa7e(%r12)
  25b243:	add    %rdx,%rbp
  25b246:	inc    %rbp
  25b249:	cmp    %r15,%rbp
  25b24c:	jae    25b283 <<glass::engine::Engine>::apply+0x1ed3>
  25b24e:	mov    0x60(%rsp),%rdi
  25b253:	mov    %r13,%rsi
  25b256:	mov    %r15,%rdx
  25b259:	mov    %rbp,%rcx
  25b25c:	mov    %r15,%r8
  25b25f:	call   270ff0 <<glass::engine::Mirror>::stretch>
  25b264:	cmp    %r15,%rax
  25b267:	jae    25b283 <<glass::engine::Engine>::apply+0x1ed3>
  25b269:	cmpb   $0x0,0xa80(%r12)
  25b272:	jne    25b283 <<glass::engine::Engine>::apply+0x1ed3>
  25b274:	movzbl -0x1(%r14),%eax
  25b279:	shr    $0x7,%al
  25b27c:	mov    0x60(%rsp),%rcx
  25b281:	mov    %al,(%rcx)
  25b283:	movzbl 0xa7e(%r12),%eax
  25b28c:	mov    %al,0xa7f(%r12)
  25b294:	sub    0x8(%rsp),%r15
  25b299:	mov    0xe0(%rsp),%rbx
  25b2a1:	jbe    25b2d0 <<glass::engine::Engine>::apply+0x1f20>
  25b2a3:	movzbl 0x3a0cee(%rip),%eax        # 5fbf98 <glass::engine::counters::COUNTING>
  25b2aa:	test   %al,%al
  25b2ac:	je     25b2b6 <<glass::engine::Engine>::apply+0x1f06>
  25b2ae:	lock add %r15,0x3a0cea(%rip)        # 5fbfa0 <glass::engine::counters::VTE_BYTES>
  25b2b6:	movzbl 0x3a0c7b(%rip),%eax        # 5fbf38 <glass::engine::probes::RUN_PROBE>
  25b2bd:	cmp    $0x68,%al
  25b2bf:	jne    25b60a <<glass::engine::Engine>::apply+0x225a>
  25b2c5:	data16 cs nopw 0x0(%rax,%rax,1)
  25b2d0:	mov    0x1e0(%rsp),%rax
  25b2d8:	mov    %rax,0xa70(%r12)
  25b2e0:	mov    0x1e8(%rsp),%eax
  25b2e7:	mov    %eax,0xa78(%r12)
  25b2ef:	pshufd $0x4e,0x1c0(%rsp),%xmm0
  25b2f9:	movdqu %xmm0,0xa60(%r12)
  25b303:	movzbl 0x1ed(%rsp),%eax
  25b30b:	mov    %al,0xa7d(%r12)
  25b313:	movzbl 0x1ec(%rsp),%eax
  25b31b:	and    $0x1,%eax
  25b31e:	shl    $0x5,%eax
  25b321:	mov    0x1b8(%rsp,%rax,1),%rax
  25b329:	mov    0xa58(%r12),%rcx
  25b331:	cmp    %rcx,%rax
  25b334:	cmova  %rax,%rcx
  25b338:	mov    %rcx,0xa58(%r12)
  25b340:	mov    0x140(%rsp),%rax
  25b348:	mov    %rax,0x28(%rsp)
  25b34d:	mov    0x148(%rsp),%r13
  25b355:	mov    0x150(%rsp),%r14
  25b35d:	movq   $0x0,0x140(%rsp)
  25b369:	movq   $0x8,0x148(%rsp)
  25b375:	movq   $0x0,0x150(%rsp)
  25b381:	test   %r14,%r14
  25b384:	je     25b3e2 <<glass::engine::Engine>::apply+0x2032>
  25b386:	mov    0x8e8(%r12),%rax
  25b38e:	mov    0x8f8(%r12),%r15
  25b396:	sub    %r15,%rax
  25b399:	cmp    %rax,%r14
  25b39c:	ja     25b6dd <<glass::engine::Engine>::apply+0x232d>
  25b3a2:	mov    %r14,%rax
  25b3a5:	shl    $0x4,%rax
  25b3a9:	lea    (%rax,%rax,2),%rdx
  25b3ad:	lea    (%r15,%r15,2),%rdi
  25b3b1:	shl    $0x4,%rdi
  25b3b5:	add    0x8f0(%r12),%rdi
  25b3bd:	mov    %r13,%rsi
  25b3c0:	call   *0x39a8ca(%rip)        # 5f5c90 <memcpy@GLIBC_2.14>
  25b3c6:	add    %r14,%r15
  25b3c9:	mov    %r15,0x8f8(%r12)
  25b3d1:	cmpq   $0x0,0x28(%rsp)
  25b3d7:	je     25b3e2 <<glass::engine::Engine>::apply+0x2032>
  25b3d9:	mov    %r13,%rdi
  25b3dc:	call   *0x39a8c6(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b3e2:	mov    0x170(%rsp),%r15
  25b3ea:	lea    0x178(%rsp),%rax
  25b3f2:	movups (%rax),%xmm0
  25b3f5:	movups 0x10(%rax),%xmm1
  25b3f9:	movups 0x20(%rax),%xmm2
  25b3fd:	movaps %xmm0,0x80(%rsp)
  25b405:	movaps %xmm1,0x90(%rsp)
  25b40d:	movaps %xmm2,0xa0(%rsp)
  25b415:	movq   $0xffffffffffffffff,0x170(%rsp)
  25b421:	cmp    $0xffffffffffffffff,%r15
  25b425:	je     25b450 <<glass::engine::Engine>::apply+0x20a0>
  25b427:	cmpq   $0x0,0x998(%r12)
  25b430:	jle    25b4aa <<glass::engine::Engine>::apply+0x20fa>
  25b432:	mov    (%rbx),%rdi
  25b435:	call   *0x39a86d(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b43b:	cmpq   $0x0,0x170(%rsp)
  25b444:	setg   %bpl
  25b448:	jmp    25b4ac <<glass::engine::Engine>::apply+0x20fc>
  25b44a:	nopw   0x0(%rax,%rax,1)
  25b450:	xor    %ebp,%ebp
  25b452:	jmp    25b4d7 <<glass::engine::Engine>::apply+0x2127>
  25b457:	nopw   0x0(%rax,%rax,1)
  25b460:	xor    %ecx,%ecx
  25b462:	cmp    %r15,%rcx
  25b465:	jae    25b1d3 <<glass::engine::Engine>::apply+0x1e23>
  25b46b:	mov    0x60(%rsp),%rdi
  25b470:	mov    %r13,%rsi
  25b473:	mov    %r15,%rdx
  25b476:	mov    %r15,%r8
  25b479:	call   270ff0 <<glass::engine::Mirror>::stretch>
  25b47e:	cmp    %r15,%rax
  25b481:	jae    25b559 <<glass::engine::Engine>::apply+0x21a9>
  25b487:	cmpb   $0x0,0xa80(%r12)
  25b490:	jne    25b559 <<glass::engine::Engine>::apply+0x21a9>
  25b496:	movzbl -0x1(%r14),%eax
  25b49b:	shr    $0x7,%al
  25b49e:	mov    0x60(%rsp),%rcx
  25b4a3:	mov    %al,(%rcx)
  25b4a5:	jmp    25b561 <<glass::engine::Engine>::apply+0x21b1>
  25b4aa:	xor    %ebp,%ebp
  25b4ac:	mov    %r15,0x998(%r12)
  25b4b4:	movaps 0x80(%rsp),%xmm0
  25b4bc:	movaps 0x90(%rsp),%xmm1
  25b4c4:	movaps 0xa0(%rsp),%xmm2
  25b4cc:	movups %xmm2,0x20(%rbx)
  25b4d0:	movups %xmm1,0x10(%rbx)
  25b4d4:	movups %xmm0,(%rbx)
  25b4d7:	mov    0x158(%rsp),%rbx
  25b4df:	mov    0x160(%rsp),%r12
  25b4e7:	mov    0x178(%rsp),%r15
  25b4ef:	cmpq   $0x0,0x140(%rsp)
  25b4f8:	je     25b508 <<glass::engine::Engine>::apply+0x2158>
  25b4fa:	mov    0x148(%rsp),%rdi
  25b502:	call   *0x39a7a0(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b508:	test   %rbx,%rbx
  25b50b:	je     25b516 <<glass::engine::Engine>::apply+0x2166>
  25b50d:	mov    %r12,%rdi
  25b510:	call   *0x39a792(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b516:	test   %bpl,%bpl
  25b519:	je     25b524 <<glass::engine::Engine>::apply+0x2174>
  25b51b:	mov    %r15,%rdi
  25b51e:	call   *0x39a784(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b524:	mov    0x38(%rsp),%rbx
  25b529:	mov    %rbx,%rdi
  25b52c:	call   258620 <<glass::engine::Engine>::fold_sentinel>
  25b531:	test   %r14,%r14
  25b534:	setne  %al
  25b537:	cmpq   $0x0,0x28(%rsp)
  25b53d:	sete   %cl
  25b540:	or     %al,%cl
  25b542:	cmp    $0x1,%cl
  25b545:	je     259490 <<glass::engine::Engine>::apply+0xe0>
  25b54b:	mov    %r13,%rdi
  25b54e:	call   *0x39a754(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b554:	jmp    259490 <<glass::engine::Engine>::apply+0xe0>
  25b559:	mov    0x60(%rsp),%rax
  25b55e:	movzbl (%rax),%eax
  25b561:	mov    %al,0xa7f(%r12)
  25b569:	mov    0xe0(%rsp),%rbx
  25b571:	xor    %ebp,%ebp
  25b573:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25b580:	cmpl   $0xffffffff,0x710(%r12)
  25b589:	jne    25b5e4 <<glass::engine::Engine>::apply+0x2234>
  25b58b:	mov    0x78(%rsp),%rax
  25b590:	mov    %rax,0x80(%rsp)
  25b598:	lea    0x130(%rsp),%rax
  25b5a0:	mov    %rax,0x88(%rsp)
  25b5a8:	movb   $0x0,0x90(%rsp)
  25b5b0:	mov    %r15,%rcx
  25b5b3:	sub    %rbp,%rcx
  25b5b6:	jb     25b71a <<glass::engine::Engine>::apply+0x236a>
  25b5bc:	mov    %r13,%rdx
  25b5bf:	add    %rbp,%rdx
  25b5c2:	mov    0xf0(%rsp),%rdi
  25b5ca:	lea    0x80(%rsp),%rsi
  25b5d2:	call   1a1560 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25b5d7:	add    %rax,%rbp
  25b5da:	cmp    %r15,%rbp
  25b5dd:	jne    25b580 <<glass::engine::Engine>::apply+0x21d0>
  25b5df:	jmp    25b2d0 <<glass::engine::Engine>::apply+0x1f20>
  25b5e4:	mov    %r15,%rcx
  25b5e7:	sub    %rbp,%rcx
  25b5ea:	jb     25b826 <<glass::engine::Engine>::apply+0x2476>
  25b5f0:	mov    %r13,%rdx
  25b5f3:	add    %rbp,%rdx
  25b5f6:	mov    0x78(%rsp),%rdi
  25b5fb:	lea    0x130(%rsp),%rsi
  25b603:	call   1952c0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25b608:	jmp    25b5d7 <<glass::engine::Engine>::apply+0x2227>
  25b60a:	mov    %r15,%rdx
  25b60d:	add    0x8(%rsp),%r13
  25b612:	cmpb   $0x1,0x58(%rsp)
  25b617:	jne    25b647 <<glass::engine::Engine>::apply+0x2297>
  25b619:	cmpl   $0xffffffff,0x710(%r12)
  25b622:	jne    25b647 <<glass::engine::Engine>::apply+0x2297>
  25b624:	lea    0x130(%rsp),%rdi
  25b62c:	mov    %r13,%rsi
  25b62f:	call   2a2d30 <glass::engine::plain_c0>
  25b634:	test   %al,%al
  25b636:	mov    0xe0(%rsp),%rbx
  25b63e:	mov    %r15,%rdx
  25b641:	jne    25b2d0 <<glass::engine::Engine>::apply+0x1f20>
  25b647:	xor    %ebp,%ebp
  25b649:	nopl   0x0(%rax)
  25b650:	cmpl   $0xffffffff,0x710(%r12)
  25b659:	jne    25b6b7 <<glass::engine::Engine>::apply+0x2307>
  25b65b:	mov    0x78(%rsp),%rax
  25b660:	mov    %rax,0x80(%rsp)
  25b668:	lea    0x130(%rsp),%rax
  25b670:	mov    %rax,0x88(%rsp)
  25b678:	movb   $0x0,0x90(%rsp)
  25b680:	mov    %r15,%rcx
  25b683:	sub    %rbp,%rcx
  25b686:	jb     25b71a <<glass::engine::Engine>::apply+0x236a>
  25b68c:	mov    %r13,%rdx
  25b68f:	add    %rbp,%rdx
  25b692:	mov    0xf0(%rsp),%rdi
  25b69a:	lea    0x80(%rsp),%rsi
  25b6a2:	call   1a1560 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25b6a7:	add    %rax,%rbp
  25b6aa:	mov    %r15,%rdx
  25b6ad:	cmp    %r15,%rbp
  25b6b0:	jne    25b650 <<glass::engine::Engine>::apply+0x22a0>
  25b6b2:	jmp    25b2d0 <<glass::engine::Engine>::apply+0x1f20>
  25b6b7:	mov    %rdx,%rcx
  25b6ba:	sub    %rbp,%rcx
  25b6bd:	jb     25b826 <<glass::engine::Engine>::apply+0x2476>
  25b6c3:	mov    %r13,%rdx
  25b6c6:	add    %rbp,%rdx
  25b6c9:	mov    0x78(%rsp),%rdi
  25b6ce:	lea    0x130(%rsp),%rsi
  25b6d6:	call   1952c0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25b6db:	jmp    25b6a7 <<glass::engine::Engine>::apply+0x22f7>
  25b6dd:	mov    $0x8,%ecx
  25b6e2:	mov    $0x30,%r8d
  25b6e8:	mov    0x228(%rsp),%rdi
  25b6f0:	mov    %r15,%rsi
  25b6f3:	mov    %r14,%rdx
  25b6f6:	call   1d09e0 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  25b6fb:	mov    0x8f8(%r12),%r15
  25b703:	jmp    25b3a2 <<glass::engine::Engine>::apply+0x1ff2>
  25b708:	add    $0x248,%rsp
  25b70f:	pop    %rbx
  25b710:	pop    %r12
  25b712:	pop    %r13
  25b714:	pop    %r14
  25b716:	pop    %r15
  25b718:	pop    %rbp
  25b719:	ret
  25b71a:	mov    %r15,%r8
  25b71d:	lea    0x35c8d4(%rip),%rcx        # 5b7ff8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25b724:	jmp    25b741 <<glass::engine::Engine>::apply+0x2391>
  25b726:	mov    %rbx,%r8
  25b729:	lea    0x371940(%rip),%rcx        # 5cd070 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x158f0>
  25b730:	mov    0x18(%rsp),%r15
  25b735:	jmp    25b741 <<glass::engine::Engine>::apply+0x2391>
  25b737:	mov    %rbx,%r8
  25b73a:	lea    0x37192f(%rip),%rcx        # 5cd070 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x158f0>
  25b741:	mov    %rbp,%rdi
  25b744:	mov    %r8,%rsi
  25b747:	mov    %r15,%rdx
  25b74a:	call   *0x39a6e8(%rip)        # 5f5e38 <_DYNAMIC+0x3d8>
  25b750:	jmp    25b8df <<glass::engine::Engine>::apply+0x252f>
  25b755:	mov    %rbx,%rbp
  25b758:	mov    %r13,%r8
  25b75b:	lea    0x373d6e(%rip),%rcx        # 5cf4d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d50>
  25b762:	mov    0x18(%rsp),%r15
  25b767:	jmp    25b741 <<glass::engine::Engine>::apply+0x2391>
  25b769:	lea    0x373d90(%rip),%rcx        # 5cf500 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d80>
  25b770:	xor    %ebp,%ebp
  25b772:	mov    0x18(%rsp),%r15
  25b777:	mov    %rdx,%r8
  25b77a:	jmp    25b741 <<glass::engine::Engine>::apply+0x2391>
  25b77c:	mov    0x8(%rsp),%rbp
  25b781:	mov    %rbx,%r8
  25b784:	lea    0x373d5d(%rip),%rcx        # 5cf4e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d68>
  25b78b:	mov    0x18(%rsp),%r15
  25b790:	jmp    25b741 <<glass::engine::Engine>::apply+0x2391>
  25b792:	mov    $0xffffffffffffffff,%r8
  25b799:	xor    %ebp,%ebp
  25b79b:	xor    %r15d,%r15d
  25b79e:	lea    0x373d13(%rip),%rcx        # 5cf4b8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d38>
  25b7a5:	jmp    25b741 <<glass::engine::Engine>::apply+0x2391>
  25b7a7:	mov    %r13,%rbp
  25b7aa:	jmp    25b729 <<glass::engine::Engine>::apply+0x2379>
  25b7af:	mov    %r15,%r8
  25b7b2:	jmp    25b73a <<glass::engine::Engine>::apply+0x238a>
  25b7b4:	lea    0x373ccd(%rip),%rdx        # 5cf488 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d08>
  25b7bb:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b7bd:	mov    %r13,%rbp
  25b7c0:	lea    0x373d51(%rip),%rcx        # 5cf518 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d98>
  25b7c7:	mov    0x18(%rsp),%r15
  25b7cc:	jmp    25b741 <<glass::engine::Engine>::apply+0x2391>
  25b7d1:	lea    0x373cc8(%rip),%rdx        # 5cf4a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d20>
  25b7d8:	mov    %r14,%rdi
  25b7db:	mov    0x18(%rsp),%rsi
  25b7e0:	call   *0x39a492(%rip)        # 5f5c78 <_DYNAMIC+0x218>
  25b7e6:	jmp    25b8df <<glass::engine::Engine>::apply+0x252f>
  25b7eb:	mov    $0x10,%eax
  25b7f0:	mov    %rax,0x18(%rsp)
  25b7f5:	mov    $0xffffffffffffffff,%r14
  25b7fc:	lea    0x373d2d(%rip),%rdx        # 5cf530 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17db0>
  25b803:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b805:	mov    $0x8,%edi
  25b80a:	mov    %r14,%rsi
  25b80d:	call   *0x39a455(%rip)        # 5f5c68 <_DYNAMIC+0x208>
  25b813:	mov    $0x10,%eax
  25b818:	mov    %rax,0x18(%rsp)
  25b81d:	lea    0x373d24(%rip),%rdx        # 5cf548 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17dc8>
  25b824:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b826:	mov    %r15,%r8
  25b829:	lea    0x35c7e0(%rip),%rcx        # 5b8010 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25b830:	jmp    25b741 <<glass::engine::Engine>::apply+0x2391>
  25b835:	mov    $0x10,%eax
  25b83a:	mov    %rax,0x18(%rsp)
  25b83f:	lea    0x373d1a(%rip),%rdx        # 5cf560 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17de0>
  25b846:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b848:	mov    %rsi,%r14
  25b84b:	mov    0x10(%rsp),%rax
  25b850:	mov    %rax,0x18(%rsp)
  25b855:	lea    0x373c14(%rip),%rdx        # 5cf470 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cf0>
  25b85c:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b861:	mov    0x30(%rsp),%r14
  25b866:	mov    %rcx,0x18(%rsp)
  25b86b:	lea    0x35f596(%rip),%rdx        # 5bae08 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  25b872:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b877:	mov    %rcx,%r14
  25b87a:	mov    %rdx,0x18(%rsp)
  25b87f:	lea    0x35f582(%rip),%rdx        # 5bae08 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  25b886:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b88b:	lea    0x370f56(%rip),%rcx        # 5cc7e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  25b892:	mov    0x68(%rsp),%rdi
  25b897:	mov    0x40(%rsp),%rsi
  25b89c:	call   *0x39a596(%rip)        # 5f5e38 <_DYNAMIC+0x3d8>
  25b8a2:	jmp    25b8df <<glass::engine::Engine>::apply+0x252f>
  25b8a4:	mov    0x30(%rsp),%r14
  25b8a9:	jmp    25b8b7 <<glass::engine::Engine>::apply+0x2507>
  25b8ab:	mov    0x30(%rsp),%r14
  25b8b0:	jmp    25b8e6 <<glass::engine::Engine>::apply+0x2536>
  25b8b2:	mov    0x70(%rsp),%r14
  25b8b7:	mov    %rax,0x18(%rsp)
  25b8bc:	lea    0x371b25(%rip),%rdx        # 5cd3e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c68>
  25b8c3:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b8c8:	lea    0x370f19(%rip),%rcx        # 5cc7e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  25b8cf:	mov    0x68(%rsp),%rdi
  25b8d4:	mov    0x40(%rsp),%rsi
  25b8d9:	call   *0x39a559(%rip)        # 5f5e38 <_DYNAMIC+0x3d8>
  25b8df:	ud2
  25b8e1:	mov    0x70(%rsp),%r14
  25b8e6:	mov    %rax,0x18(%rsp)
  25b8eb:	lea    0x371ade(%rip),%rdx        # 5cd3d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c50>
  25b8f2:	jmp    25b7d8 <<glass::engine::Engine>::apply+0x2428>
  25b8f7:	mov    %rax,%r15
  25b8fa:	cmpq   $0x0,0x28(%rsp)
  25b900:	je     25b96a <<glass::engine::Engine>::apply+0x25ba>
  25b902:	mov    %r13,%rdi
  25b905:	call   *0x39a39d(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b90b:	jmp    25b96a <<glass::engine::Engine>::apply+0x25ba>
  25b90d:	mov    %rax,%r15
  25b910:	lock decq (%r12)
  25b915:	je     25b927 <<glass::engine::Engine>::apply+0x2577>
  25b917:	jmp    25b96a <<glass::engine::Engine>::apply+0x25ba>
  25b919:	mov    %rax,%r15
  25b91c:	mov    0x8(%rsp),%rax
  25b921:	lock decq (%rax)
  25b925:	jne    25b96a <<glass::engine::Engine>::apply+0x25ba>
  25b927:	lea    0xb0(%rsp),%rdi
  25b92f:	call   *0x39a393(%rip)        # 5f5cc8 <_DYNAMIC+0x268>
  25b935:	jmp    25b96a <<glass::engine::Engine>::apply+0x25ba>
  25b937:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b939:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b93b:	mov    %rax,%r15
  25b93e:	test   %r14,%r14
  25b941:	setne  %al
  25b944:	cmpq   $0x0,0x28(%rsp)
  25b94a:	sete   %cl
  25b94d:	or     %al,%cl
  25b94f:	jne    25b9d6 <<glass::engine::Engine>::apply+0x2626>
  25b955:	jmp    25b993 <<glass::engine::Engine>::apply+0x25e3>
  25b957:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b959:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b95b:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b95d:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b95f:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b961:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b963:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b965:	jmp    25b967 <<glass::engine::Engine>::apply+0x25b7>
  25b967:	mov    %rax,%r15
  25b96a:	cmpq   $0x0,0x140(%rsp)
  25b973:	jne    25b9a4 <<glass::engine::Engine>::apply+0x25f4>
  25b975:	cmpq   $0x0,0x158(%rsp)
  25b97e:	jne    25b9bd <<glass::engine::Engine>::apply+0x260d>
  25b980:	cmpq   $0x0,0x170(%rsp)
  25b989:	jle    25b9d6 <<glass::engine::Engine>::apply+0x2626>
  25b98b:	mov    0x178(%rsp),%r13
  25b993:	mov    %r13,%rdi
  25b996:	call   *0x39a30c(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b99c:	mov    %r15,%rdi
  25b99f:	call   5b4070 <_Unwind_Resume@plt>
  25b9a4:	mov    0x148(%rsp),%rdi
  25b9ac:	call   *0x39a2f6(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b9b2:	cmpq   $0x0,0x158(%rsp)
  25b9bb:	je     25b980 <<glass::engine::Engine>::apply+0x25d0>
  25b9bd:	mov    0x160(%rsp),%rdi
  25b9c5:	call   *0x39a2dd(%rip)        # 5f5ca8 <_DYNAMIC+0x248>
  25b9cb:	cmpq   $0x0,0x170(%rsp)
  25b9d4:	jg     25b98b <<glass::engine::Engine>::apply+0x25db>
  25b9d6:	mov    %r15,%rdi
  25b9d9:	call   5b4070 <_Unwind_Resume@plt>
