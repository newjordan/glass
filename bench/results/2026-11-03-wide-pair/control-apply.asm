
/tmp/glass-wide-pair-control-test:     file format elf64-x86-64


Disassembly of section .text:

000000000026c4e0 <<glass::engine::Engine>::apply>:
  26c4e0:	push   %rbp
  26c4e1:	push   %r15
  26c4e3:	push   %r14
  26c4e5:	push   %r13
  26c4e7:	push   %r12
  26c4e9:	push   %rbx
  26c4ea:	sub    $0x248,%rsp
  26c4f1:	mov    %rdi,%rbx
  26c4f4:	testb  $0x10,0x6d5(%rdi)
  26c4fb:	jne    26c55d <<glass::engine::Engine>::apply+0x7d>
  26c4fd:	cmpb   $0x2,0x278(%rbx)
  26c504:	jne    26c55d <<glass::engine::Engine>::apply+0x7d>
  26c506:	mov    0xb0(%rbx),%rax
  26c50d:	dec    %rax
  26c510:	movq   $0x0,0x250(%rbx)
  26c51b:	movl   $0x0,0x258(%rbx)
  26c525:	movb   $0x0,0x260(%rbx)
  26c52c:	mov    %rax,0x268(%rbx)
  26c533:	movl   $0x0,0x270(%rbx)
  26c53d:	movb   $0x1,0x278(%rbx)
  26c544:	movb   $0x0,0x280(%rbx)
  26c54b:	movq   $0x0,0xa60(%rbx)
  26c556:	movb   $0x1,0xa7d(%rbx)
  26c55d:	test   %rdx,%rdx
  26c560:	je     26e838 <<glass::engine::Engine>::apply+0x2358>
  26c566:	lea    0x10(%rbx),%rax
  26c56a:	mov    %rax,0x238(%rsp)
  26c572:	lea    0x6f0(%rbx),%rax
  26c579:	mov    %rax,0x78(%rsp)
  26c57e:	lea    0x8e8(%rbx),%rax
  26c585:	mov    %rax,0x228(%rsp)
  26c58d:	lea    0xa7e(%rbx),%rax
  26c594:	mov    %rax,0x60(%rsp)
  26c599:	lea    0x720(%rbx),%rax
  26c5a0:	mov    %rax,0xf0(%rsp)
  26c5a8:	lea    0x9a0(%rbx),%rax
  26c5af:	mov    %rax,0xe0(%rsp)
  26c5b7:	mov    %rbx,0x38(%rsp)
  26c5bc:	jmp    26c5db <<glass::engine::Engine>::apply+0xfb>
  26c5be:	xchg   %ax,%ax
  26c5c0:	mov    0x110(%rsp),%rsi
  26c5c8:	mov    0x240(%rsp),%rdx
  26c5d0:	sub    0x18(%rsp),%rdx
  26c5d5:	je     26e838 <<glass::engine::Engine>::apply+0x2358>
  26c5db:	mov    %rsi,0x28(%rsp)
  26c5e0:	cmp    $0x2000,%rdx
  26c5e7:	mov    $0x2000,%eax
  26c5ec:	mov    %rdx,0x240(%rsp)
  26c5f4:	cmovb  %rdx,%rax
  26c5f8:	mov    %rax,0x18(%rsp)
  26c5fd:	mov    0x6d4(%rbx),%ebp
  26c603:	mov    $0x1000,%eax
  26c608:	and    %eax,%ebp
  26c60a:	mov    0xa58(%rbx),%r9
  26c611:	mov    $0x0,%r10d
  26c617:	cmove  %r9,%r10
  26c61b:	mov    0xa68(%rbx),%rax
  26c622:	mov    %rax,%r11
  26c625:	cmove  %r9,%r11
  26c629:	mov    0x910(%rbx),%r13
  26c630:	mov    $0x8,%r12d
  26c636:	test   %r13,%r13
  26c639:	je     26c69c <<glass::engine::Engine>::apply+0x1bc>
  26c63b:	mov    %r11,0x58(%rsp)
  26c640:	mov    %r10,0x10(%rsp)
  26c645:	mov    %r9,0x8(%rsp)
  26c64a:	mov    0x908(%rbx),%r15
  26c651:	lea    0x0(,%r13,8),%rax
  26c659:	lea    (%rax,%rax,2),%r14
  26c65d:	mov    $0x8,%esi
  26c662:	mov    %r14,%rdi
  26c665:	call   *0x3bc3dd(%rip)        # 628a48 <_DYNAMIC+0x228>
  26c66b:	test   %rax,%rax
  26c66e:	je     26e935 <<glass::engine::Engine>::apply+0x2455>
  26c674:	mov    %rax,%r12
  26c677:	mov    %rax,%rdi
  26c67a:	mov    %r15,%rsi
  26c67d:	mov    %r14,%rdx
  26c680:	call   *0x3bc3ca(%rip)        # 628a50 <memcpy@GLIBC_2.14>
  26c686:	mov    0xa68(%rbx),%rax
  26c68d:	mov    0x8(%rsp),%r9
  26c692:	mov    0x10(%rsp),%r10
  26c697:	mov    0x58(%rsp),%r11
  26c69c:	mov    0x18(%rsp),%r15
  26c6a1:	mov    0x28(%rsp),%r14
  26c6a6:	lea    (%r14,%r15,1),%rcx
  26c6aa:	mov    %rcx,0x110(%rsp)
  26c6b2:	mov    0xa78(%rbx),%ecx
  26c6b8:	mov    0xa60(%rbx),%rdx
  26c6bf:	movzbl 0xa7d(%rbx),%esi
  26c6c6:	movzbl 0xa81(%rbx),%edi
  26c6cd:	mov    0x238(%rsp),%r8
  26c6d5:	mov    %r8,0x1a8(%rsp)
  26c6dd:	movq   $0x0,0x140(%rsp)
  26c6e9:	movq   $0x8,0x148(%rsp)
  26c6f5:	movq   $0x0,0x150(%rsp)
  26c701:	mov    %r13,0x158(%rsp)
  26c709:	mov    %r12,0x160(%rsp)
  26c711:	mov    %r13,0x168(%rsp)
  26c719:	mov    %r11,0x1b0(%rsp)
  26c721:	mov    %r10,0x1b8(%rsp)
  26c729:	shr    $0xc,%ebp
  26c72c:	mov    %bpl,0x1ec(%rsp)
  26c734:	mov    %rax,0x1c0(%rsp)
  26c73c:	mov    %ecx,0x1e8(%rsp)
  26c743:	mov    %rdx,0x1c8(%rsp)
  26c74b:	mov    %sil,0x1ed(%rsp)
  26c753:	mov    %r15,0x1d0(%rsp)
  26c75b:	movups (%rbx),%xmm0
  26c75e:	movaps %xmm0,0x130(%rsp)
  26c766:	movq   $0xffffffffffffffff,0x170(%rsp)
  26c772:	mov    %r9,0x1d8(%rsp)
  26c77a:	mov    %dil,0x1ee(%rsp)
  26c782:	mov    0xa70(%rbx),%rax
  26c789:	mov    %rax,0x1e0(%rsp)
  26c791:	test   %dil,%dil
  26c794:	mov    %rbx,%r12
  26c797:	je     26e2b0 <<glass::engine::Engine>::apply+0x1dd0>
  26c79d:	mov    $0x3,%eax
  26c7a2:	sub    %r15,%rax
  26c7a5:	mov    %rax,0x230(%rsp)
  26c7ad:	mov    $0x1,%al
  26c7af:	mov    %eax,0xdc(%rsp)
  26c7b6:	xor    %ebp,%ebp
  26c7b8:	mov    %r14,0x1f8(%rsp)
  26c7c0:	mov    $0x1,%al
  26c7c2:	mov    %eax,0x104(%rsp)
  26c7c9:	movq   $0x0,0x8(%rsp)
  26c7d2:	movl   $0x0,0xd0(%rsp)
  26c7dd:	movq   $0x0,0x58(%rsp)
  26c7e6:	xor    %r13d,%r13d
  26c7e9:	testb  $0x1,0xdc(%rsp)
  26c7f1:	je     26c850 <<glass::engine::Engine>::apply+0x370>
  26c7f3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  26c800:	mov    0x3bcae9(%rip),%rax        # 6292f0 <_DYNAMIC+0xad0>
  26c807:	mov    (%rax),%rax
  26c80a:	mov    $0x1b,%edi
  26c80f:	mov    0x1f8(%rsp),%rsi
  26c817:	mov    0x110(%rsp),%rdx
  26c81f:	call   *%rax
  26c821:	cmp    $0x1,%rax
  26c825:	jne    26c850 <<glass::engine::Engine>::apply+0x370>
  26c827:	mov    %rdx,%rax
  26c82a:	sub    0x28(%rsp),%rax
  26c82f:	inc    %rdx
  26c832:	mov    $0x1,%cl
  26c834:	mov    %ecx,0xdc(%rsp)
  26c83b:	mov    %rdx,0x1f8(%rsp)
  26c843:	jmp    26c879 <<glass::engine::Engine>::apply+0x399>
  26c845:	data16 cs nopw 0x0(%rax,%rax,1)
  26c850:	testb  $0x1,0x104(%rsp)
  26c858:	je     26e320 <<glass::engine::Engine>::apply+0x1e40>
  26c85e:	movl   $0x0,0x104(%rsp)
  26c869:	mov    0x18(%rsp),%rax
  26c86e:	movl   $0x0,0xdc(%rsp)
  26c879:	mov    %rax,%rdx
  26c87c:	sub    %r13,%rax
  26c87f:	cmp    $0x18,%rax
  26c883:	mov    %rdx,0x10(%rsp)
  26c888:	jb     26ced0 <<glass::engine::Engine>::apply+0x9f0>
  26c88e:	cmp    %rdx,0x18(%rsp)
  26c893:	jae    26c8d8 <<glass::engine::Engine>::apply+0x3f8>
  26c895:	jmp    26e899 <<glass::engine::Engine>::apply+0x23b9>
  26c89a:	mov    0x58(%rsp),%rax
  26c89f:	mov    %eax,%ebp
  26c8a1:	mov    0x38(%rsp),%rax
  26c8a6:	cmpl   $0xffffffff,0x710(%rax)
  26c8ad:	je     26cc36 <<glass::engine::Engine>::apply+0x756>
  26c8b3:	mov    %ebp,%eax
  26c8b5:	mov    %rax,0x58(%rsp)
  26c8ba:	nopw   0x0(%rax,%rax,1)
  26c8c0:	mov    0x10(%rsp),%rdx
  26c8c5:	mov    %rdx,%rax
  26c8c8:	sub    %r13,%rax
  26c8cb:	mov    %r13,%rbp
  26c8ce:	cmp    $0x17,%rax
  26c8d2:	jbe    26ced3 <<glass::engine::Engine>::apply+0x9f3>
  26c8d8:	lea    0xb0(%rsp),%rdi
  26c8e0:	mov    0x28(%rsp),%rsi
  26c8e5:	mov    %r13,%rcx
  26c8e8:	call   2bbc50 <glass::engine::next_run>
  26c8ed:	movzbl 0xc0(%rsp),%r12d
  26c8f6:	cmp    $0x2,%r12b
  26c8fa:	je     26cf60 <<glass::engine::Engine>::apply+0xa80>
  26c900:	mov    0xb0(%rsp),%rbx
  26c908:	cmp    %rbp,%rbx
  26c90b:	jb     26e856 <<glass::engine::Engine>::apply+0x2376>
  26c911:	mov    0x18(%rsp),%r15
  26c916:	cmp    %r15,%rbx
  26c919:	ja     26e867 <<glass::engine::Engine>::apply+0x2387>
  26c91f:	mov    0xb8(%rsp),%r13
  26c927:	mov    0x28(%rsp),%rax
  26c92c:	lea    (%rax,%rbp,1),%r15
  26c930:	lea    (%rax,%rbx,1),%r14
  26c934:	mov    0x3bc9ad(%rip),%rax        # 6292e8 <_DYNAMIC+0xac8>
  26c93b:	mov    (%rax),%rax
  26c93e:	mov    $0x1b,%edi
  26c943:	mov    %r15,%rsi
  26c946:	mov    %r14,%rdx
  26c949:	call   *%rax
  26c94b:	cmp    $0x1,%rax
  26c94f:	jne    26c96d <<glass::engine::Engine>::apply+0x48d>
  26c951:	sub    %r15,%rdx
  26c954:	mov    0x38(%rsp),%rax
  26c959:	movb   $0x1,0xa80(%rax)
  26c960:	movb   $0x0,0xa7e(%rax)
  26c967:	add    %rdx,%rbp
  26c96a:	inc    %rbp
  26c96d:	cmp    %rbx,%rbp
  26c970:	jae    26c9ae <<glass::engine::Engine>::apply+0x4ce>
  26c972:	mov    0x60(%rsp),%rdi
  26c977:	mov    0x28(%rsp),%rsi
  26c97c:	mov    0x18(%rsp),%rdx
  26c981:	mov    %rbp,%rcx
  26c984:	mov    %rbx,%r8
  26c987:	call   284900 <<glass::engine::Mirror>::stretch>
  26c98c:	cmp    %rbx,%rax
  26c98f:	jae    26c9ae <<glass::engine::Engine>::apply+0x4ce>
  26c991:	mov    0x38(%rsp),%rax
  26c996:	cmpb   $0x0,0xa80(%rax)
  26c99d:	jne    26c9ae <<glass::engine::Engine>::apply+0x4ce>
  26c99f:	movzbl -0x1(%r14),%eax
  26c9a4:	shr    $0x7,%al
  26c9a7:	mov    0x60(%rsp),%rcx
  26c9ac:	mov    %al,(%rcx)
  26c9ae:	mov    0x60(%rsp),%rdi
  26c9b3:	mov    0x28(%rsp),%rsi
  26c9b8:	mov    0x18(%rsp),%rdx
  26c9bd:	mov    %rbx,%rcx
  26c9c0:	mov    %r13,%r8
  26c9c3:	call   284900 <<glass::engine::Mirror>::stretch>
  26c9c8:	mov    %rax,%rbx
  26c9cb:	mov    0x38(%rsp),%rax
  26c9d0:	cmpb   $0x0,0xa80(%rax)
  26c9d7:	jne    26c8c0 <<glass::engine::Engine>::apply+0x3e0>
  26c9dd:	lea    -0x1(%r13),%r14
  26c9e1:	cmp    0x18(%rsp),%r14
  26c9e6:	jae    26e8e4 <<glass::engine::Engine>::apply+0x2404>
  26c9ec:	mov    0x28(%rsp),%rax
  26c9f1:	movzbl (%rax,%r14,1),%eax
  26c9f6:	shr    $0x7,%al
  26c9f9:	mov    0x60(%rsp),%rcx
  26c9fe:	mov    %al,(%rcx)
  26ca00:	test   %rbx,%rbx
  26ca03:	je     26ca32 <<glass::engine::Engine>::apply+0x552>
  26ca05:	lea    -0x1(%rbx),%r14
  26ca09:	cmp    0x18(%rsp),%r14
  26ca0e:	jae    26e901 <<glass::engine::Engine>::apply+0x2421>
  26ca14:	mov    0x28(%rsp),%rax
  26ca19:	movzbl (%rax,%r14,1),%eax
  26ca1e:	shr    $0x7,%al
  26ca21:	mov    %r13,%r14
  26ca24:	sub    %rbx,%r14
  26ca27:	cmp    $0x18,%r14
  26ca2b:	jae    26ca4e <<glass::engine::Engine>::apply+0x56e>
  26ca2d:	jmp    26c8c0 <<glass::engine::Engine>::apply+0x3e0>
  26ca32:	mov    0x38(%rsp),%rax
  26ca37:	movzbl 0xa7f(%rax),%eax
  26ca3e:	mov    %r13,%r14
  26ca41:	sub    %rbx,%r14
  26ca44:	cmp    $0x18,%r14
  26ca48:	jb     26c8c0 <<glass::engine::Engine>::apply+0x3e0>
  26ca4e:	test   %al,%al
  26ca50:	jne    26c8c0 <<glass::engine::Engine>::apply+0x3e0>
  26ca56:	mov    %rbx,%r15
  26ca59:	sub    0x8(%rsp),%r15
  26ca5e:	jbe    26c89a <<glass::engine::Engine>::apply+0x3ba>
  26ca64:	movzbl 0x3c230d(%rip),%eax        # 62ed78 <glass::engine::probes::RUN_PROBE>
  26ca6b:	mov    $0x1,%bpl
  26ca6e:	cmp    $0x68,%al
  26ca70:	je     26cc1f <<glass::engine::Engine>::apply+0x73f>
  26ca76:	cmp    0x18(%rsp),%rbx
  26ca7b:	ja     26e8ac <<glass::engine::Engine>::apply+0x23cc>
  26ca81:	mov    0x8(%rsp),%rax
  26ca86:	add    0x28(%rsp),%rax
  26ca8b:	mov    %rax,0x8(%rsp)
  26ca90:	cmpb   $0x1,0x58(%rsp)
  26ca95:	jne    26cac2 <<glass::engine::Engine>::apply+0x5e2>
  26ca97:	mov    0x38(%rsp),%rax
  26ca9c:	cmpl   $0xffffffff,0x710(%rax)
  26caa3:	jne    26cac2 <<glass::engine::Engine>::apply+0x5e2>
  26caa5:	lea    0x130(%rsp),%rdi
  26caad:	mov    0x8(%rsp),%rsi
  26cab2:	mov    %r15,%rdx
  26cab5:	call   2bbf40 <glass::engine::plain_c0>
  26caba:	test   %al,%al
  26cabc:	jne    26cc1f <<glass::engine::Engine>::apply+0x73f>
  26cac2:	movzbl 0x3c22bf(%rip),%eax        # 62ed88 <glass::engine::timers::ON>
  26cac9:	test   %al,%al
  26cacb:	je     26ccff <<glass::engine::Engine>::apply+0x81f>
  26cad1:	mov    $0x1,%edi
  26cad6:	call   5441b0 <<std::sys::pal::unix::time::Timespec>::now>
  26cadb:	mov    %rax,0x58(%rsp)
  26cae0:	mov    %edx,0x30(%rsp)
  26cae4:	xor    %ebp,%ebp
  26cae6:	cs nopw 0x0(%rax,%rax,1)
  26caf0:	mov    0x38(%rsp),%rax
  26caf5:	cmpl   $0xffffffff,0x710(%rax)
  26cafc:	jne    26cb57 <<glass::engine::Engine>::apply+0x677>
  26cafe:	mov    0x78(%rsp),%rax
  26cb03:	mov    %rax,0x80(%rsp)
  26cb0b:	lea    0x130(%rsp),%rax
  26cb13:	mov    %rax,0x88(%rsp)
  26cb1b:	movb   $0x0,0x90(%rsp)
  26cb23:	mov    %r15,%rcx
  26cb26:	sub    %rbp,%rcx
  26cb29:	jb     26e84a <<glass::engine::Engine>::apply+0x236a>
  26cb2f:	mov    0x8(%rsp),%rax
  26cb34:	lea    (%rax,%rbp,1),%rdx
  26cb38:	mov    0xf0(%rsp),%rdi
  26cb40:	lea    0x80(%rsp),%rsi
  26cb48:	call   1a8780 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  26cb4d:	add    %rax,%rbp
  26cb50:	cmp    %r15,%rbp
  26cb53:	jne    26caf0 <<glass::engine::Engine>::apply+0x610>
  26cb55:	jmp    26cb80 <<glass::engine::Engine>::apply+0x6a0>
  26cb57:	mov    %r15,%rcx
  26cb5a:	sub    %rbp,%rcx
  26cb5d:	jb     26e956 <<glass::engine::Engine>::apply+0x2476>
  26cb63:	mov    0x8(%rsp),%rax
  26cb68:	lea    (%rax,%rbp,1),%rdx
  26cb6c:	mov    0x78(%rsp),%rdi
  26cb71:	lea    0x130(%rsp),%rsi
  26cb79:	call   19bf90 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  26cb7e:	jmp    26cb4d <<glass::engine::Engine>::apply+0x66d>
  26cb80:	movzbl 0x3c2201(%rip),%eax        # 62ed88 <glass::engine::timers::ON>
  26cb87:	test   %al,%al
  26cb89:	mov    $0x1,%bpl
  26cb8c:	je     26cc1f <<glass::engine::Engine>::apply+0x73f>
  26cb92:	mov    $0x1,%edi
  26cb97:	call   5441b0 <<std::sys::pal::unix::time::Timespec>::now>
  26cb9c:	mov    %rax,0x200(%rsp)
  26cba4:	mov    %edx,0x208(%rsp)
  26cbab:	mov    0x58(%rsp),%rax
  26cbb0:	mov    %rax,0x210(%rsp)
  26cbb8:	mov    0x30(%rsp),%eax
  26cbbc:	mov    %eax,0x218(%rsp)
  26cbc3:	lea    0x80(%rsp),%rdi
  26cbcb:	lea    0x200(%rsp),%rsi
  26cbd3:	lea    0x210(%rsp),%rdx
  26cbdb:	call   5440f0 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  26cbe0:	imul   $0x3b9aca00,0x88(%rsp),%rax
  26cbec:	mov    0x90(%rsp),%ecx
  26cbf3:	add    %rcx,%rax
  26cbf6:	cmpb   $0x0,0x80(%rsp)
  26cbfe:	mov    $0x0,%ecx
  26cc03:	cmove  %rax,%rcx
  26cc07:	lock add %rcx,0x3c2189(%rip)        # 62ed98 <glass::engine::timers::VTE_NS>
  26cc0f:	lock incq 0x3c21b1(%rip)        # 62edc8 <glass::engine::timers::VTE_CALLS>
  26cc17:	lock add %r15,0x3c21a1(%rip)        # 62edc0 <glass::engine::timers::VTE_BYTES>
  26cc1f:	mov    %rbx,0x8(%rsp)
  26cc24:	mov    0x38(%rsp),%rax
  26cc29:	cmpl   $0xffffffff,0x710(%rax)
  26cc30:	jne    26c8b3 <<glass::engine::Engine>::apply+0x3d3>
  26cc36:	cmp    0x18(%rsp),%r13
  26cc3b:	ja     26e885 <<glass::engine::Engine>::apply+0x23a5>
  26cc41:	cmp    %rbx,%r13
  26cc44:	jb     26e885 <<glass::engine::Engine>::apply+0x23a5>
  26cc4a:	movzbl 0x3c2126(%rip),%r15d        # 62ed78 <glass::engine::probes::RUN_PROBE>
  26cc52:	movzbl 0x3c212f(%rip),%eax        # 62ed88 <glass::engine::timers::ON>
  26cc59:	test   %al,%al
  26cc5b:	je     26cc8c <<glass::engine::Engine>::apply+0x7ac>
  26cc5d:	mov    $0x1,%edi
  26cc62:	call   5441b0 <<std::sys::pal::unix::time::Timespec>::now>
  26cc67:	mov    %rax,0x58(%rsp)
  26cc6c:	mov    %edx,%ebp
  26cc6e:	cmp    $0x63,%r15b
  26cc72:	jbe    26cc97 <<glass::engine::Engine>::apply+0x7b7>
  26cc74:	movzbl %r12b,%eax
  26cc78:	mov    %r14,%rbx
  26cc7b:	sub    %rax,%rbx
  26cc7e:	cmp    $0xffffffff,%ebp
  26cc81:	jne    26ce0a <<glass::engine::Engine>::apply+0x92a>
  26cc87:	jmp    26cea2 <<glass::engine::Engine>::apply+0x9c2>
  26cc8c:	mov    $0xffffffff,%ebp
  26cc91:	cmp    $0x63,%r15b
  26cc95:	ja     26cc74 <<glass::engine::Engine>::apply+0x794>
  26cc97:	mov    0x3bede3(%rip),%eax        # 62ba80 <glass::engine::run_whole::ON>
  26cc9d:	test   %eax,%eax
  26cc9f:	jne    26cec1 <<glass::engine::Engine>::apply+0x9e1>
  26cca5:	mov    0x28(%rsp),%rax
  26ccaa:	lea    (%rax,%rbx,1),%rsi
  26ccae:	cmpb   $0x0,0x3bedcf(%rip)        # 62ba84 <glass::engine::run_whole::ON+0x4>
  26ccb5:	je     26ccd6 <<glass::engine::Engine>::apply+0x7f6>
  26ccb7:	test   $0x1,%r12b
  26ccbb:	je     26cdbf <<glass::engine::Engine>::apply+0x8df>
  26ccc1:	lea    0x130(%rsp),%rdi
  26ccc9:	mov    %r14,%rdx
  26cccc:	call   2796c0 <<glass::engine::Watch>::print_run>
  26ccd1:	jmp    26cdcf <<glass::engine::Engine>::apply+0x8ef>
  26ccd6:	test   $0x1,%r12b
  26ccda:	je     26cdee <<glass::engine::Engine>::apply+0x90e>
  26cce0:	cmp    %rbx,%r13
  26cce3:	je     26e8c2 <<glass::engine::Engine>::apply+0x23e2>
  26cce9:	lea    -0x1(%r14),%rdx
  26cced:	lea    0x130(%rsp),%rdi
  26ccf5:	call   2796c0 <<glass::engine::Watch>::print_run>
  26ccfa:	jmp    26cdfe <<glass::engine::Engine>::apply+0x91e>
  26ccff:	xor    %ebp,%ebp
  26cd01:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  26cd10:	mov    0x38(%rsp),%rax
  26cd15:	cmpl   $0xffffffff,0x710(%rax)
  26cd1c:	jne    26cd77 <<glass::engine::Engine>::apply+0x897>
  26cd1e:	mov    0x78(%rsp),%rax
  26cd23:	mov    %rax,0x80(%rsp)
  26cd2b:	lea    0x130(%rsp),%rax
  26cd33:	mov    %rax,0x88(%rsp)
  26cd3b:	movb   $0x0,0x90(%rsp)
  26cd43:	mov    %r15,%rcx
  26cd46:	sub    %rbp,%rcx
  26cd49:	jb     26e84a <<glass::engine::Engine>::apply+0x236a>
  26cd4f:	mov    0x8(%rsp),%rax
  26cd54:	lea    (%rax,%rbp,1),%rdx
  26cd58:	mov    0xf0(%rsp),%rdi
  26cd60:	lea    0x80(%rsp),%rsi
  26cd68:	call   1a8780 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  26cd6d:	add    %rax,%rbp
  26cd70:	cmp    %r15,%rbp
  26cd73:	jne    26cd10 <<glass::engine::Engine>::apply+0x830>
  26cd75:	jmp    26cda0 <<glass::engine::Engine>::apply+0x8c0>
  26cd77:	mov    %r15,%rcx
  26cd7a:	sub    %rbp,%rcx
  26cd7d:	jb     26e956 <<glass::engine::Engine>::apply+0x2476>
  26cd83:	mov    0x8(%rsp),%rax
  26cd88:	lea    (%rax,%rbp,1),%rdx
  26cd8c:	mov    0x78(%rsp),%rdi
  26cd91:	lea    0x130(%rsp),%rsi
  26cd99:	call   19bf90 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  26cd9e:	jmp    26cd6d <<glass::engine::Engine>::apply+0x88d>
  26cda0:	mov    %rbx,0x8(%rsp)
  26cda5:	mov    $0x1,%bpl
  26cda8:	mov    0x38(%rsp),%rax
  26cdad:	cmpl   $0xffffffff,0x710(%rax)
  26cdb4:	jne    26c8b3 <<glass::engine::Engine>::apply+0x3d3>
  26cdba:	jmp    26cc36 <<glass::engine::Engine>::apply+0x756>
  26cdbf:	lea    0x130(%rsp),%rdi
  26cdc7:	mov    %r14,%rdx
  26cdca:	call   276d20 <<glass::engine::Watch>::print_utf8>
  26cdcf:	mov    %rax,%rbx
  26cdd2:	mov    0x1e0(%rsp),%eax
  26cdd9:	mov    0x38(%rsp),%rcx
  26cdde:	mov    %eax,0x718(%rcx)
  26cde4:	cmp    $0xffffffff,%ebp
  26cde7:	jne    26ce0a <<glass::engine::Engine>::apply+0x92a>
  26cde9:	jmp    26cea2 <<glass::engine::Engine>::apply+0x9c2>
  26cdee:	lea    0x130(%rsp),%rdi
  26cdf6:	mov    %r14,%rdx
  26cdf9:	call   276d20 <<glass::engine::Watch>::print_utf8>
  26cdfe:	mov    %rax,%rbx
  26ce01:	cmp    $0xffffffff,%ebp
  26ce04:	je     26cea2 <<glass::engine::Engine>::apply+0x9c2>
  26ce0a:	movzbl 0x3c1f77(%rip),%eax        # 62ed88 <glass::engine::timers::ON>
  26ce11:	test   %al,%al
  26ce13:	je     26ce9a <<glass::engine::Engine>::apply+0x9ba>
  26ce19:	mov    $0x1,%edi
  26ce1e:	call   5441b0 <<std::sys::pal::unix::time::Timespec>::now>
  26ce23:	mov    %rax,0x200(%rsp)
  26ce2b:	mov    %edx,0x208(%rsp)
  26ce32:	mov    0x58(%rsp),%rax
  26ce37:	mov    %rax,0x210(%rsp)
  26ce3f:	mov    %ebp,0x218(%rsp)
  26ce46:	lea    0x80(%rsp),%rdi
  26ce4e:	lea    0x200(%rsp),%rsi
  26ce56:	lea    0x210(%rsp),%rdx
  26ce5e:	call   5440f0 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  26ce63:	imul   $0x3b9aca00,0x88(%rsp),%rax
  26ce6f:	mov    0x90(%rsp),%ecx
  26ce76:	add    %rcx,%rax
  26ce79:	cmpb   $0x0,0x80(%rsp)
  26ce81:	mov    $0x0,%ecx
  26ce86:	cmove  %rax,%rcx
  26ce8a:	lock add %rcx,0x3c1efe(%rip)        # 62ed90 <glass::engine::timers::RUN_NS>
  26ce92:	lock incq 0x3c1f1e(%rip)        # 62edb8 <glass::engine::timers::RUN_CALLS>
  26ce9a:	lock add %r14,0x3c1f0e(%rip)        # 62edb0 <glass::engine::timers::RUN_BYTES>
  26cea2:	movzbl 0x3c1f2f(%rip),%eax        # 62edd8 <glass::engine::counters::COUNTING>
  26cea9:	test   %al,%al
  26ceab:	je     26ceb5 <<glass::engine::Engine>::apply+0x9d5>
  26cead:	lock add %rbx,0x3c1f1b(%rip)        # 62edd0 <glass::engine::counters::LANE_RUN_BYTES>
  26ceb5:	add    %rbx,0x8(%rsp)
  26ceba:	mov    $0x1,%al
  26cebc:	jmp    26c8b5 <<glass::engine::Engine>::apply+0x3d5>
  26cec1:	call   193146 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  26cec6:	jmp    26cca5 <<glass::engine::Engine>::apply+0x7c5>
  26cecb:	nopl   0x0(%rax,%rax,1)
  26ced0:	mov    %rbp,%r13
  26ced3:	mov    $0x1,%ebx
  26ced8:	mov    0x18(%rsp),%rax
  26cedd:	sub    %rdx,%rax
  26cee0:	jbe    26cf7b <<glass::engine::Engine>::apply+0xa9b>
  26cee6:	mov    0x8(%rsp),%rcx
  26ceeb:	cmp    %rcx,0xe8(%rsp)
  26cef3:	sete   %r9b
  26cef7:	cmp    $0x2,%rax
  26cefb:	mov    0x38(%rsp),%r12
  26cf00:	jb     26cf50 <<glass::engine::Engine>::apply+0xa70>
  26cf02:	mov    0x28(%rsp),%rcx
  26cf07:	mov    0x10(%rsp),%rdx
  26cf0c:	lea    (%rcx,%rdx,1),%rbp
  26cf10:	cmpb   $0x5b,0x1(%rbp)
  26cf14:	jne    26cf50 <<glass::engine::Engine>::apply+0xa70>
  26cf16:	xorps  %xmm0,%xmm0
  26cf19:	movaps %xmm0,0x90(%rsp)
  26cf21:	movaps %xmm0,0x80(%rsp)
  26cf29:	cmp    $0x2,%rax
  26cf2d:	je     26cf50 <<glass::engine::Engine>::apply+0xa70>
  26cf2f:	movzbl 0x2(%rbp),%ecx
  26cf33:	lea    -0x30(%rcx),%eax
  26cf36:	cmp    $0xa,%al
  26cf38:	jae    26cfa1 <<glass::engine::Engine>::apply+0xac1>
  26cf3a:	movzbl %al,%eax
  26cf3d:	xor    %r14d,%r14d
  26cf40:	mov    0x10(%rsp),%rcx
  26cf45:	add    $0x3,%rcx
  26cf49:	cmp    0x18(%rsp),%rcx
  26cf4e:	jne    26cfc7 <<glass::engine::Engine>::apply+0xae7>
  26cf50:	movl   $0x0,0xd0(%rsp)
  26cf5b:	jmp    26cf80 <<glass::engine::Engine>::apply+0xaa0>
  26cf5d:	nopl   (%rax)
  26cf60:	mov    %rbp,%r13
  26cf63:	mov    0x10(%rsp),%rdx
  26cf68:	mov    $0x1,%ebx
  26cf6d:	mov    0x18(%rsp),%rax
  26cf72:	sub    %rdx,%rax
  26cf75:	ja     26cee6 <<glass::engine::Engine>::apply+0xa06>
  26cf7b:	mov    0x38(%rsp),%r12
  26cf80:	mov    0x10(%rsp),%r8
  26cf85:	add    %r8,%rbx
  26cf88:	mov    %r13,%rbp
  26cf8b:	mov    %rbx,%r13
  26cf8e:	testb  $0x1,0xdc(%rsp)
  26cf96:	je     26c850 <<glass::engine::Engine>::apply+0x370>
  26cf9c:	jmp    26c800 <<glass::engine::Engine>::apply+0x320>
  26cfa1:	movzbl %cl,%edx
  26cfa4:	xor    %eax,%eax
  26cfa6:	lea    -0x48(%rdx),%esi
  26cfa9:	cmp    $0x25,%esi
  26cfac:	ja     26cfe0 <<glass::engine::Engine>::apply+0xb00>
  26cfae:	mov    $0x3,%r8d
  26cfb4:	lea    -0x1fc4c3(%rip),%rdi        # 70af8 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d07>
  26cfbb:	movslq (%rdi,%rsi,4),%rdx
  26cfbf:	add    %rdi,%rdx
  26cfc2:	xor    %r14d,%r14d
  26cfc5:	jmp    *%rdx
  26cfc7:	mov    0x10(%rsp),%rcx
  26cfcc:	mov    0x230(%rsp),%rdx
  26cfd4:	lea    (%rdx,%rcx,1),%rsi
  26cfd8:	mov    $0x4,%r8d
  26cfde:	jmp    26d023 <<glass::engine::Engine>::apply+0xb43>
  26cfe0:	mov    $0x1,%r14d
  26cfe6:	cmp    $0x3b,%edx
  26cfe9:	je     26cf40 <<glass::engine::Engine>::apply+0xa60>
  26cfef:	jmp    26cf50 <<glass::engine::Engine>::apply+0xa70>
  26cff4:	mov    $0xffff,%cx
  26cff8:	nopl   0x0(%rax,%rax,1)
  26d000:	movzbl %dil,%eax
  26d004:	add    %cx,%ax
  26d007:	mov    $0xffff,%ecx
  26d00c:	cmovb  %ecx,%eax
  26d00f:	lea    (%rsi,%r8,1),%rcx
  26d013:	inc    %rcx
  26d016:	inc    %r8
  26d019:	cmp    $0x4,%rcx
  26d01d:	je     26cf50 <<glass::engine::Engine>::apply+0xa70>
  26d023:	movzbl -0x1(%rbp,%r8,1),%ecx
  26d029:	lea    -0x30(%rcx),%edi
  26d02c:	cmp    $0xa,%dil
  26d030:	jae    26d040 <<glass::engine::Engine>::apply+0xb60>
  26d032:	mov    $0xa,%cx
  26d036:	mul    %cx
  26d039:	jo     26cff4 <<glass::engine::Engine>::apply+0xb14>
  26d03b:	mov    %eax,%ecx
  26d03d:	jmp    26d000 <<glass::engine::Engine>::apply+0xb20>
  26d03f:	nop
  26d040:	movzbl %cl,%edx
  26d043:	cmp    $0x3b,%edx
  26d046:	jne    26d083 <<glass::engine::Engine>::apply+0xba3>
  26d048:	lea    0x1(%r14),%rcx
  26d04c:	cmp    $0x10,%rcx
  26d050:	jae    26cf50 <<glass::engine::Engine>::apply+0xa70>
  26d056:	cmp    $0xf,%r14
  26d05a:	ja     26e91b <<glass::engine::Engine>::apply+0x243b>
  26d060:	mov    %ax,0x80(%rsp,%r14,2)
  26d069:	xor    %eax,%eax
  26d06b:	mov    %rcx,%r14
  26d06e:	lea    (%rsi,%r8,1),%rcx
  26d072:	inc    %rcx
  26d075:	inc    %r8
  26d078:	cmp    $0x4,%rcx
  26d07c:	jne    26d023 <<glass::engine::Engine>::apply+0xb43>
  26d07e:	jmp    26cf50 <<glass::engine::Engine>::apply+0xa70>
  26d083:	add    $0xffffffb8,%edx
  26d086:	cmp    $0x25,%edx
  26d089:	ja     26cf50 <<glass::engine::Engine>::apply+0xa70>
  26d08f:	lea    -0x1fc506(%rip),%rsi        # 70b90 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d9f>
  26d096:	movslq (%rsi,%rdx,4),%rdx
  26d09a:	add    %rsi,%rdx
  26d09d:	jmp    *%rdx
  26d09f:	cmp    $0x10,%r14
  26d0a3:	jae    26e943 <<glass::engine::Engine>::apply+0x2463>
  26d0a9:	mov    %r8,0x120(%rsp)
  26d0b1:	mov    %ax,0x80(%rsp,%r14,2)
  26d0ba:	cmp    $0x6d,%cl
  26d0bd:	setne  %cl
  26d0c0:	movaps 0x80(%rsp),%xmm0
  26d0c8:	movaps 0x90(%rsp),%xmm1
  26d0d0:	movaps %xmm0,0xb0(%rsp)
  26d0d8:	movaps %xmm1,0xc0(%rsp)
  26d0e0:	xor    %edx,%edx
  26d0e2:	jmp    26d123 <<glass::engine::Engine>::apply+0xc43>
  26d0e4:	cmp    $0x10,%r14
  26d0e8:	jae    26e965 <<glass::engine::Engine>::apply+0x2485>
  26d0ee:	mov    %r8,0x120(%rsp)
  26d0f6:	mov    %ax,0x80(%rsp,%r14,2)
  26d0ff:	movaps 0x80(%rsp),%xmm0
  26d107:	movaps 0x90(%rsp),%xmm1
  26d10f:	movaps %xmm0,0xb0(%rsp)
  26d117:	movaps %xmm1,0xc0(%rsp)
  26d11f:	mov    $0x1,%dl
  26d121:	xor    %ecx,%ecx
  26d123:	lea    0x1(%r14),%rax
  26d127:	movaps 0xb0(%rsp),%xmm0
  26d12f:	movaps 0xc0(%rsp),%xmm1
  26d137:	movaps %xmm1,0x90(%rsp)
  26d13f:	movaps %xmm0,0x80(%rsp)
  26d147:	mov    %rax,0xa0(%rsp)
  26d14f:	mov    %cl,0xa8(%rsp)
  26d156:	mov    %dl,0xa9(%rsp)
  26d15d:	mov    0x10(%rsp),%r8
  26d162:	cmp    %r13,%r8
  26d165:	jb     26e8d7 <<glass::engine::Engine>::apply+0x23f7>
  26d16b:	mov    %r9b,0x30(%rsp)
  26d170:	mov    %edx,0x12c(%rsp)
  26d177:	mov    %ecx,0x128(%rsp)
  26d17e:	mov    0x28(%rsp),%rax
  26d183:	lea    (%rax,%r13,1),%r15
  26d187:	mov    0x3bc15a(%rip),%rax        # 6292e8 <_DYNAMIC+0xac8>
  26d18e:	mov    (%rax),%rax
  26d191:	mov    $0x1b,%edi
  26d196:	mov    %r15,%rsi
  26d199:	mov    %rbp,%rdx
  26d19c:	call   *%rax
  26d19e:	cmp    $0x1,%rax
  26d1a2:	jne    26d1bf <<glass::engine::Engine>::apply+0xcdf>
  26d1a4:	sub    %r15,%rdx
  26d1a7:	movb   $0x1,0xa80(%r12)
  26d1b0:	movb   $0x0,0xa7e(%r12)
  26d1b9:	add    %rdx,%r13
  26d1bc:	inc    %r13
  26d1bf:	mov    0x10(%rsp),%r8
  26d1c4:	cmp    %r8,%r13
  26d1c7:	jae    26d219 <<glass::engine::Engine>::apply+0xd39>
  26d1c9:	mov    0x60(%rsp),%rdi
  26d1ce:	mov    0x28(%rsp),%rsi
  26d1d3:	mov    0x18(%rsp),%rdx
  26d1d8:	mov    %r13,%rcx
  26d1db:	call   284900 <<glass::engine::Mirror>::stretch>
  26d1e0:	movzbl 0xa80(%r12),%ecx
  26d1e9:	test   %cl,%cl
  26d1eb:	setne  %dl
  26d1ee:	mov    0x10(%rsp),%r8
  26d1f3:	cmp    %r8,%rax
  26d1f6:	setae  %al
  26d1f9:	or     %dl,%al
  26d1fb:	jne    26d222 <<glass::engine::Engine>::apply+0xd42>
  26d1fd:	movzbl -0x1(%rbp),%eax
  26d201:	shr    $0x7,%al
  26d204:	mov    0x60(%rsp),%rcx
  26d209:	mov    %al,(%rcx)
  26d20b:	mov    0x28(%rsp),%r9
  26d210:	test   %al,%al
  26d212:	jne    26d23f <<glass::engine::Engine>::apply+0xd5f>
  26d214:	jmp    26d310 <<glass::engine::Engine>::apply+0xe30>
  26d219:	movzbl 0xa80(%r12),%ecx
  26d222:	test   %cl,%cl
  26d224:	mov    0x28(%rsp),%r9
  26d229:	jne    26d55c <<glass::engine::Engine>::apply+0x107c>
  26d22f:	mov    0x60(%rsp),%rax
  26d234:	movzbl (%rax),%eax
  26d237:	test   %al,%al
  26d239:	je     26d310 <<glass::engine::Engine>::apply+0xe30>
  26d23f:	mov    0x10(%rsp),%r8
  26d244:	test   %r8,%r8
  26d247:	je     26d55c <<glass::engine::Engine>::apply+0x107c>
  26d24d:	cmpb   $0xc0,-0x1(%rbp)
  26d251:	jge    26d293 <<glass::engine::Engine>::apply+0xdb3>
  26d253:	cmp    $0x1,%r8
  26d257:	je     26d55c <<glass::engine::Engine>::apply+0x107c>
  26d25d:	cmpb   $0xbf,-0x2(%rbp)
  26d261:	jg     26d3ad <<glass::engine::Engine>::apply+0xecd>
  26d267:	cmp    $0x2,%r8
  26d26b:	je     26d55c <<glass::engine::Engine>::apply+0x107c>
  26d271:	cmpb   $0xbf,-0x3(%rbp)
  26d275:	jg     26da77 <<glass::engine::Engine>::apply+0x1597>
  26d27b:	cmp    $0x3,%r8
  26d27f:	je     26d55c <<glass::engine::Engine>::apply+0x107c>
  26d285:	cmpb   $0xc0,-0x4(%rbp)
  26d289:	setl   %al
  26d28c:	mov    $0x3,%edx
  26d291:	jmp    26d297 <<glass::engine::Engine>::apply+0xdb7>
  26d293:	xor    %edx,%edx
  26d295:	xor    %eax,%eax
  26d297:	test   %al,%al
  26d299:	jne    26d306 <<glass::engine::Engine>::apply+0xe26>
  26d29b:	mov    %rdx,%rsi
  26d29e:	not    %rsi
  26d2a1:	add    0x10(%rsp),%rsi
  26d2a6:	jae    26e978 <<glass::engine::Engine>::apply+0x2498>
  26d2ac:	movzbl (%r9,%rsi,1),%eax
  26d2b1:	mov    $0x1,%ecx
  26d2b6:	test   %al,%al
  26d2b8:	jns    26d2e4 <<glass::engine::Engine>::apply+0xe04>
  26d2ba:	lea    0x3e(%rax),%edi
  26d2bd:	mov    $0x2,%ecx
  26d2c2:	cmp    $0x1e,%dil
  26d2c6:	jb     26d2e4 <<glass::engine::Engine>::apply+0xe04>
  26d2c8:	mov    %eax,%edi
  26d2ca:	and    $0xf0,%dil
  26d2ce:	mov    $0x3,%ecx
  26d2d3:	cmp    $0xe0,%dil
  26d2d7:	je     26d2e4 <<glass::engine::Engine>::apply+0xe04>
  26d2d9:	add    $0x10,%al
  26d2db:	mov    $0x4,%ecx
  26d2e0:	cmp    $0x4,%al
  26d2e2:	ja     26d306 <<glass::engine::Engine>::apply+0xe26>
  26d2e4:	inc    %rdx
  26d2e7:	cmp    %ecx,%edx
  26d2e9:	jne    26d306 <<glass::engine::Engine>::apply+0xe26>
  26d2eb:	add    %r9,%rsi
  26d2ee:	lea    0xb0(%rsp),%rdi
  26d2f6:	call   *0x3bb814(%rip)        # 628b10 <_DYNAMIC+0x2f0>
  26d2fc:	cmpb   $0x0,0xb0(%rsp)
  26d304:	je     26d310 <<glass::engine::Engine>::apply+0xe30>
  26d306:	mov    0x10(%rsp),%r8
  26d30b:	jmp    26d55c <<glass::engine::Engine>::apply+0x107c>
  26d310:	mov    0x10(%rsp),%r8
  26d315:	mov    %r8,%rbp
  26d318:	sub    0x8(%rsp),%rbp
  26d31d:	jbe    26d551 <<glass::engine::Engine>::apply+0x1071>
  26d323:	mov    0x3be757(%rip),%eax        # 62ba80 <glass::engine::run_whole::ON>
  26d329:	test   %eax,%eax
  26d32b:	jne    26da81 <<glass::engine::Engine>::apply+0x15a1>
  26d331:	mov    0xd0(%rsp),%ecx
  26d338:	and    0x30(%rsp),%cl
  26d33c:	movzbl 0x3be741(%rip),%eax        # 62ba84 <glass::engine::run_whole::ON+0x4>
  26d343:	xor    $0x1,%rax
  26d347:	cmp    %rax,%rbp
  26d34a:	seta   %al
  26d34d:	and    %cl,%al
  26d34f:	cmp    $0x1,%al
  26d351:	jne    26d3a3 <<glass::engine::Engine>::apply+0xec3>
  26d353:	mov    0x8(%rsp),%rcx
  26d358:	mov    %rcx,%rax
  26d35b:	cmp    %rcx,0x10(%rsp)
  26d360:	mov    0x28(%rsp),%rdx
  26d365:	je     26d386 <<glass::engine::Engine>::apply+0xea6>
  26d367:	nopw   0x0(%rax,%rax,1)
  26d370:	movzbl (%rdx,%rax,1),%ecx
  26d374:	add    $0xe0,%cl
  26d377:	cmp    $0x5f,%cl
  26d37a:	jae    26d391 <<glass::engine::Engine>::apply+0xeb1>
  26d37c:	inc    %rax
  26d37f:	cmp    %rax,0x10(%rsp)
  26d384:	jne    26d370 <<glass::engine::Engine>::apply+0xe90>
  26d386:	cmpl   $0xffffffff,0x710(%r12)
  26d38f:	je     26d3b7 <<glass::engine::Engine>::apply+0xed7>
  26d391:	mov    0x10(%rsp),%r8
  26d396:	mov    0xe8(%rsp),%r13
  26d39e:	jmp    26d495 <<glass::engine::Engine>::apply+0xfb5>
  26d3a3:	mov    0x8(%rsp),%r13
  26d3a8:	jmp    26d48b <<glass::engine::Engine>::apply+0xfab>
  26d3ad:	mov    $0x1,%edx
  26d3b2:	jmp    26d295 <<glass::engine::Engine>::apply+0xdb5>
  26d3b7:	mov    0x3be6c3(%rip),%eax        # 62ba80 <glass::engine::run_whole::ON>
  26d3bd:	test   %eax,%eax
  26d3bf:	jne    26da8b <<glass::engine::Engine>::apply+0x15ab>
  26d3c5:	mov    0x8(%rsp),%rax
  26d3ca:	add    0x28(%rsp),%rax
  26d3cf:	mov    %rax,0x8(%rsp)
  26d3d4:	movzbl 0x3be6a9(%rip),%eax        # 62ba84 <glass::engine::run_whole::ON+0x4>
  26d3db:	xor    $0x1,%rax
  26d3df:	sub    %rax,%rbp
  26d3e2:	cmp    $0x1,%rbp
  26d3e6:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d3e8:	cmpb   $0x1,0x1ee(%rsp)
  26d3f0:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d3f2:	cmpq   $0x0,0x168(%rsp)
  26d3fb:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d3fd:	mov    0x1a8(%rsp),%r13
  26d405:	testb  $0x4,0x6c5(%r13)
  26d40d:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d40f:	cmpq   $0x0,0x50(%r13)
  26d414:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d416:	movzwl 0x64(%r13),%eax
  26d41b:	test   $0x460,%eax
  26d420:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d422:	cmpb   $0x0,0x68(%r13)
  26d427:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d429:	cmpb   $0x0,0x69(%r13)
  26d42e:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d430:	cmpb   $0x0,0x6a(%r13)
  26d435:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26d437:	cmpb   $0x0,0x6b(%r13)
  26d43c:	je     26da95 <<glass::engine::Engine>::apply+0x15b5>
  26d442:	lea    0x130(%rsp),%rdi
  26d44a:	mov    0x8(%rsp),%rsi
  26d44f:	mov    %rbp,%rdx
  26d452:	call   2796c0 <<glass::engine::Watch>::print_run>
  26d457:	mov    %rax,%r15
  26d45a:	mov    0x3be620(%rip),%eax        # 62ba80 <glass::engine::run_whole::ON>
  26d460:	test   %eax,%eax
  26d462:	jne    26e29d <<glass::engine::Engine>::apply+0x1dbd>
  26d468:	cmpb   $0x0,0x3be615(%rip)        # 62ba84 <glass::engine::run_whole::ON+0x4>
  26d46f:	je     26d480 <<glass::engine::Engine>::apply+0xfa0>
  26d471:	mov    0x1e0(%rsp),%eax
  26d478:	mov    %eax,0x718(%r12)
  26d480:	mov    0xe8(%rsp),%r13
  26d488:	add    %r15,%r13
  26d48b:	mov    0x28(%rsp),%rdx
  26d490:	mov    0x10(%rsp),%r8
  26d495:	cmp    %r13,%r8
  26d498:	jb     26e8ed <<glass::engine::Engine>::apply+0x240d>
  26d49e:	mov    %r8,%r15
  26d4a1:	mov    %r8,0x8(%rsp)
  26d4a6:	sub    %r13,%r15
  26d4a9:	je     26d551 <<glass::engine::Engine>::apply+0x1071>
  26d4af:	add    %rdx,%r13
  26d4b2:	xor    %ebp,%ebp
  26d4b4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  26d4c0:	cmpl   $0xffffffff,0x710(%r12)
  26d4c9:	jne    26d526 <<glass::engine::Engine>::apply+0x1046>
  26d4cb:	mov    0x78(%rsp),%rax
  26d4d0:	mov    %rax,0xb0(%rsp)
  26d4d8:	lea    0x130(%rsp),%rax
  26d4e0:	mov    %rax,0xb8(%rsp)
  26d4e8:	movb   $0x0,0xc0(%rsp)
  26d4f0:	mov    %r15,%rcx
  26d4f3:	sub    %rbp,%rcx
  26d4f6:	jb     26e84a <<glass::engine::Engine>::apply+0x236a>
  26d4fc:	mov    %r13,%rdx
  26d4ff:	add    %rbp,%rdx
  26d502:	mov    0xf0(%rsp),%rdi
  26d50a:	lea    0xb0(%rsp),%rsi
  26d512:	call   1a8780 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  26d517:	add    %rax,%rbp
  26d51a:	cmp    %r15,%rbp
  26d51d:	mov    0x10(%rsp),%r8
  26d522:	jne    26d4c0 <<glass::engine::Engine>::apply+0xfe0>
  26d524:	jmp    26d54c <<glass::engine::Engine>::apply+0x106c>
  26d526:	mov    %r15,%rcx
  26d529:	sub    %rbp,%rcx
  26d52c:	jb     26e956 <<glass::engine::Engine>::apply+0x2476>
  26d532:	mov    %r13,%rdx
  26d535:	add    %rbp,%rdx
  26d538:	mov    0x78(%rsp),%rdi
  26d53d:	lea    0x130(%rsp),%rsi
  26d545:	call   19bf90 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  26d54a:	jmp    26d517 <<glass::engine::Engine>::apply+0x1037>
  26d54c:	mov    %r8,0x8(%rsp)
  26d551:	cmpl   $0xffffffff,0x710(%r12)
  26d55a:	je     26d56f <<glass::engine::Engine>::apply+0x108f>
  26d55c:	movl   $0x0,0xd0(%rsp)
  26d567:	mov    %r8,%r13
  26d56a:	jmp    26cf85 <<glass::engine::Engine>::apply+0xaa5>
  26d56f:	cmpb   $0x0,0x12c(%rsp)
  26d577:	je     26d5b9 <<glass::engine::Engine>::apply+0x10d9>
  26d579:	mov    0x1e0(%rsp),%ebx
  26d580:	cmp    $0xffffffff,%ebx
  26d583:	je     26d9e5 <<glass::engine::Engine>::apply+0x1505>
  26d589:	mov    0x80(%rsp),%ebp
  26d590:	cmp    $0x1,%bp
  26d594:	adc    $0x0,%ebp
  26d597:	nopw   0x0(%rax,%rax,1)
  26d5a0:	lea    0x130(%rsp),%rdi
  26d5a8:	mov    %ebx,%esi
  26d5aa:	call   3574d0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  26d5af:	dec    %bp
  26d5b2:	jne    26d5a0 <<glass::engine::Engine>::apply+0x10c0>
  26d5b4:	jmp    26da32 <<glass::engine::Engine>::apply+0x1552>
  26d5b9:	cmpb   $0x0,0x128(%rsp)
  26d5c1:	je     26d5f1 <<glass::engine::Engine>::apply+0x1111>
  26d5c3:	movzwl 0x80(%rsp),%eax
  26d5cb:	lea    -0x1(%rax),%esi
  26d5ce:	test   %eax,%eax
  26d5d0:	cmove  %eax,%esi
  26d5d3:	test   %r14,%r14
  26d5d6:	je     26da12 <<glass::engine::Engine>::apply+0x1532>
  26d5dc:	movzwl 0x82(%rsp),%ecx
  26d5e4:	xor    %eax,%eax
  26d5e6:	test   %cx,%cx
  26d5e9:	setne  %al
  26d5ec:	jmp    26da14 <<glass::engine::Engine>::apply+0x1534>
  26d5f1:	mov    0x1a8(%rsp),%r13
  26d5f9:	xor    %eax,%eax
  26d5fb:	jmp    26d62e <<glass::engine::Engine>::apply+0x114e>
  26d5fd:	mov    $0x17,%cx
  26d601:	mov    $0x1010000,%esi
  26d606:	cs nopw 0x0(%rax,%rax,1)
  26d610:	movzwl %cx,%eax
  26d613:	shl    $0x10,%rsi
  26d617:	or     %rax,%rsi
  26d61a:	mov    %r13,%rdi
  26d61d:	call   365580 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  26d622:	mov    %rbx,%rax
  26d625:	cmp    %r14,%rbx
  26d628:	ja     26da32 <<glass::engine::Engine>::apply+0x1552>
  26d62e:	movzwl 0x80(%rsp,%rax,2),%ecx
  26d636:	lea    0x1(%rax),%rbx
  26d63a:	cmp    $0x3b,%rcx
  26d63e:	ja     26d8bf <<glass::engine::Engine>::apply+0x13df>
  26d644:	lea    -0x1fca23(%rip),%rsi        # 70c28 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2e37>
  26d64b:	movslq (%rsi,%rcx,4),%rdx
  26d64f:	add    %rsi,%rdx
  26d652:	jmp    *%rdx
  26d654:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d656:	cmp    %r14,%rax
  26d659:	jae    26d622 <<glass::engine::Engine>::apply+0x1142>
  26d65b:	movzwl 0x82(%rsp,%rax,2),%ecx
  26d663:	lea    0x2(%rax),%rbx
  26d667:	cmp    $0x5,%ecx
  26d66a:	je     26d923 <<glass::engine::Engine>::apply+0x1443>
  26d670:	cmp    $0x2,%ecx
  26d673:	jne    26d622 <<glass::engine::Engine>::apply+0x1142>
  26d675:	cmp    %r14,%rbx
  26d678:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d67a:	movzwl 0x84(%rsp,%rax,2),%ecx
  26d682:	lea    0x3(%rax),%rbx
  26d686:	cmp    $0xff,%ecx
  26d68c:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d68e:	cmp    %r14,%rbx
  26d691:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d693:	movzwl 0x86(%rsp,%rax,2),%edx
  26d69b:	lea    0x4(%rax),%rbx
  26d69f:	cmp    $0xff,%edx
  26d6a5:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d6ab:	cmp    %r14,%rbx
  26d6ae:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d6b4:	movzwl 0x88(%rsp,%rax,2),%edi
  26d6bc:	add    $0x5,%rax
  26d6c0:	cmp    $0xff,%edi
  26d6c6:	ja     26d9a6 <<glass::engine::Engine>::apply+0x14c6>
  26d6cc:	shl    $0x10,%edi
  26d6cf:	movzwl %dx,%edx
  26d6d2:	shl    $0x8,%edx
  26d6d5:	or     %edx,%ecx
  26d6d7:	movzwl %cx,%esi
  26d6da:	or     %edi,%esi
  26d6dc:	mov    $0x1,%ecx
  26d6e1:	jmp    26d945 <<glass::engine::Engine>::apply+0x1465>
  26d6e6:	mov    $0x11,%cx
  26d6ea:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d6ef:	mov    $0xc,%cx
  26d6f3:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d6f8:	mov    $0xa,%cx
  26d6fc:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d701:	mov    $0x18,%cx
  26d705:	mov    $0xff,%esi
  26d70a:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d70f:	mov    $0xe,%cx
  26d713:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d718:	cmp    %r14,%rax
  26d71b:	jae    26d622 <<glass::engine::Engine>::apply+0x1142>
  26d721:	movzwl 0x82(%rsp,%rax,2),%ecx
  26d729:	lea    0x2(%rax),%rbx
  26d72d:	cmp    $0x5,%ecx
  26d730:	je     26d956 <<glass::engine::Engine>::apply+0x1476>
  26d736:	cmp    $0x2,%ecx
  26d739:	jne    26d622 <<glass::engine::Engine>::apply+0x1142>
  26d73f:	cmp    %r14,%rbx
  26d742:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d748:	movzwl 0x84(%rsp,%rax,2),%ecx
  26d750:	lea    0x3(%rax),%rbx
  26d754:	cmp    $0xff,%ecx
  26d75a:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d760:	cmp    %r14,%rbx
  26d763:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d769:	movzwl 0x86(%rsp,%rax,2),%edx
  26d771:	lea    0x4(%rax),%rbx
  26d775:	cmp    $0xff,%edx
  26d77b:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d781:	cmp    %r14,%rbx
  26d784:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d78a:	movzwl 0x88(%rsp,%rax,2),%edi
  26d792:	add    $0x5,%rax
  26d796:	cmp    $0xff,%edi
  26d79c:	ja     26d9a6 <<glass::engine::Engine>::apply+0x14c6>
  26d7a2:	shl    $0x10,%edi
  26d7a5:	movzwl %dx,%edx
  26d7a8:	shl    $0x8,%edx
  26d7ab:	or     %edx,%ecx
  26d7ad:	movzwl %cx,%esi
  26d7b0:	or     %edi,%esi
  26d7b2:	mov    $0x1,%ecx
  26d7b7:	jmp    26d978 <<glass::engine::Engine>::apply+0x1498>
  26d7bc:	mov    $0x10,%cx
  26d7c0:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d7c5:	mov    $0x16,%cx
  26d7c9:	mov    $0x1000000,%esi
  26d7ce:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d7d3:	mov    $0xf,%cx
  26d7d7:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d7dc:	mov    $0x9,%cx
  26d7e0:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d7e5:	mov    $0x12,%cx
  26d7e9:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d7ee:	mov    $0x13,%cx
  26d7f2:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d7f7:	mov    $0xb,%cx
  26d7fb:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d800:	mov    $0xd,%cx
  26d804:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d809:	mov    $0x15,%cx
  26d80d:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d812:	mov    $0x14,%cx
  26d816:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d81b:	cmp    %r14,%rax
  26d81e:	jae    26d622 <<glass::engine::Engine>::apply+0x1142>
  26d824:	movzwl 0x82(%rsp,%rax,2),%ecx
  26d82c:	lea    0x2(%rax),%rbx
  26d830:	cmp    $0x5,%ecx
  26d833:	je     26d989 <<glass::engine::Engine>::apply+0x14a9>
  26d839:	cmp    $0x2,%ecx
  26d83c:	jne    26d622 <<glass::engine::Engine>::apply+0x1142>
  26d842:	cmp    %r14,%rbx
  26d845:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d84b:	movzwl 0x84(%rsp,%rax,2),%ecx
  26d853:	lea    0x3(%rax),%rbx
  26d857:	cmp    $0xff,%ecx
  26d85d:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d863:	cmp    %r14,%rbx
  26d866:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d86c:	movzwl 0x86(%rsp,%rax,2),%edx
  26d874:	lea    0x4(%rax),%rbx
  26d878:	cmp    $0xff,%edx
  26d87e:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d884:	cmp    %r14,%rbx
  26d887:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d88d:	movzwl 0x88(%rsp,%rax,2),%edi
  26d895:	add    $0x5,%rax
  26d899:	cmp    $0xff,%edi
  26d89f:	ja     26d9a6 <<glass::engine::Engine>::apply+0x14c6>
  26d8a5:	shl    $0x10,%edi
  26d8a8:	movzwl %dx,%edx
  26d8ab:	shl    $0x8,%edx
  26d8ae:	or     %edx,%ecx
  26d8b0:	movzwl %cx,%esi
  26d8b3:	or     %edi,%esi
  26d8b5:	mov    $0x1,%ecx
  26d8ba:	jmp    26d9d4 <<glass::engine::Engine>::apply+0x14f4>
  26d8bf:	lea    -0x1e(%rcx),%eax
  26d8c2:	cmp    $0x8,%ax
  26d8c6:	jae    26d8e0 <<glass::engine::Engine>::apply+0x1400>
  26d8c8:	lea    -0x21067f(%rip),%rax        # 5d250 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.936144864058942182+0xa90>
  26d8cf:	movzwl -0x3c(%rax,%rcx,2),%esi
  26d8d4:	shl    $0x10,%esi
  26d8d7:	mov    $0x16,%cx
  26d8db:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d8e0:	mov    %ecx,%eax
  26d8e2:	and    $0xfff8,%eax
  26d8e7:	cmp    $0x28,%ax
  26d8eb:	jne    26d905 <<glass::engine::Engine>::apply+0x1425>
  26d8ed:	lea    -0x2106a4(%rip),%rax        # 5d250 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.936144864058942182+0xa90>
  26d8f4:	movzwl -0x50(%rax,%rcx,2),%esi
  26d8f9:	shl    $0x10,%esi
  26d8fc:	mov    $0x17,%cx
  26d900:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d905:	lea    -0x5a(%rcx),%eax
  26d908:	cmp    $0x8,%ax
  26d90c:	jae    26d9ae <<glass::engine::Engine>::apply+0x14ce>
  26d912:	lea    -0x20e829(%rip),%rax        # 5f0f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.936144864058942182+0x110>
  26d919:	movzwl -0xb4(%rax,%rcx,2),%esi
  26d921:	jmp    26d8d4 <<glass::engine::Engine>::apply+0x13f4>
  26d923:	cmp    %r14,%rbx
  26d926:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d92c:	movzwl 0x84(%rsp,%rax,2),%esi
  26d934:	add    $0x3,%rax
  26d938:	cmp    $0xff,%esi
  26d93e:	ja     26d9a6 <<glass::engine::Engine>::apply+0x14c6>
  26d940:	mov    $0x2,%ecx
  26d945:	shl    $0x8,%esi
  26d948:	or     %ecx,%esi
  26d94a:	mov    $0x16,%cx
  26d94e:	mov    %rax,%rbx
  26d951:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d956:	cmp    %r14,%rbx
  26d959:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d95f:	movzwl 0x84(%rsp,%rax,2),%esi
  26d967:	add    $0x3,%rax
  26d96b:	cmp    $0xff,%esi
  26d971:	ja     26d9a6 <<glass::engine::Engine>::apply+0x14c6>
  26d973:	mov    $0x2,%ecx
  26d978:	shl    $0x8,%esi
  26d97b:	or     %ecx,%esi
  26d97d:	mov    $0x18,%cx
  26d981:	mov    %rax,%rbx
  26d984:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d989:	cmp    %r14,%rbx
  26d98c:	ja     26d622 <<glass::engine::Engine>::apply+0x1142>
  26d992:	movzwl 0x84(%rsp,%rax,2),%esi
  26d99a:	add    $0x3,%rax
  26d99e:	cmp    $0xff,%esi
  26d9a4:	jbe    26d9cf <<glass::engine::Engine>::apply+0x14ef>
  26d9a6:	mov    %rax,%rbx
  26d9a9:	jmp    26d622 <<glass::engine::Engine>::apply+0x1142>
  26d9ae:	lea    -0x64(%rcx),%eax
  26d9b1:	cmp    $0x8,%ax
  26d9b5:	jae    26d622 <<glass::engine::Engine>::apply+0x1142>
  26d9bb:	lea    -0x20e8d2(%rip),%rax        # 5f0f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.936144864058942182+0x110>
  26d9c2:	movzwl -0xc8(%rax,%rcx,2),%esi
  26d9ca:	jmp    26d8f9 <<glass::engine::Engine>::apply+0x1419>
  26d9cf:	mov    $0x2,%ecx
  26d9d4:	shl    $0x8,%esi
  26d9d7:	or     %ecx,%esi
  26d9d9:	mov    $0x17,%cx
  26d9dd:	mov    %rax,%rbx
  26d9e0:	jmp    26d610 <<glass::engine::Engine>::apply+0x1130>
  26d9e5:	mov    $0x1,%al
  26d9e7:	mov    %eax,0xd0(%rsp)
  26d9ee:	mov    %r8,%r13
  26d9f1:	mov    0x8(%rsp),%rax
  26d9f6:	mov    %rax,0xe8(%rsp)
  26d9fe:	mov    $0x1,%al
  26da00:	mov    %rax,0x58(%rsp)
  26da05:	mov    0x120(%rsp),%rbx
  26da0d:	jmp    26cf85 <<glass::engine::Engine>::apply+0xaa5>
  26da12:	xor    %eax,%eax
  26da14:	movzwl %cx,%edx
  26da17:	dec    %rdx
  26da1a:	test   $0x1,%al
  26da1c:	mov    $0x0,%eax
  26da21:	cmove  %rax,%rdx
  26da25:	mov    0x1a8(%rsp),%rdi
  26da2d:	call   3669c0 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  26da32:	mov    0x10(%rsp),%r8
  26da37:	mov    0x120(%rsp),%rbx
  26da3f:	lea    (%rbx,%r8,1),%r13
  26da43:	movb   $0x0,0xa80(%r12)
  26da4c:	movb   $0x0,0xa7e(%r12)
  26da55:	mov    $0x1,%al
  26da57:	mov    %eax,0xd0(%rsp)
  26da5e:	mov    %r13,0x8(%rsp)
  26da63:	mov    %r13,0xe8(%rsp)
  26da6b:	mov    $0x1,%al
  26da6d:	mov    %rax,0x58(%rsp)
  26da72:	jmp    26cf85 <<glass::engine::Engine>::apply+0xaa5>
  26da77:	mov    $0x2,%edx
  26da7c:	jmp    26d295 <<glass::engine::Engine>::apply+0xdb5>
  26da81:	call   193146 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  26da86:	jmp    26d331 <<glass::engine::Engine>::apply+0xe51>
  26da8b:	call   193146 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  26da90:	jmp    26d3c5 <<glass::engine::Engine>::apply+0xee5>
  26da95:	mov    0x8(%rsp),%rax
  26da9a:	movzbl (%rax),%eax
  26da9d:	mov    %rax,0xd0(%rsp)
  26daa5:	add    $0xffffffe0,%eax
  26daa8:	mov    $0x1,%r15d
  26daae:	cmp    $0x5f,%al
  26dab0:	jb     26dadd <<glass::engine::Engine>::apply+0x15fd>
  26dab2:	mov    0xd0(%rsp),%rdi
  26daba:	call   2bc300 <glass::engine::width_of>
  26dabf:	mov    0x38(%rsp),%r12
  26dac4:	mov    %rdx,%r15
  26dac7:	lea    -0x1(%rdx),%rcx
  26dacb:	cmp    $0x2,%rcx
  26dacf:	setb   %cl
  26dad2:	and    %al,%cl
  26dad4:	cmp    $0x1,%cl
  26dad7:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26dadd:	cmpb   $0x0,0x6c(%r13)
  26dae2:	mov    0x38(%rsp),%r12
  26dae7:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26daed:	mov    0x40(%r13),%rdx
  26daf1:	mov    0xa0(%r13),%rcx
  26daf8:	mov    %rdx,0x30(%rsp)
  26dafd:	lea    (%rdx,%r15,1),%rax
  26db01:	mov    %rax,0x118(%rsp)
  26db09:	mov    %rcx,0x220(%rsp)
  26db11:	cmp    %rcx,%rax
  26db14:	ja     26d442 <<glass::engine::Engine>::apply+0xf62>
  26db1a:	lea    0x10(%r13),%rdi
  26db1e:	mov    0x48(%r13),%esi
  26db22:	mov    0x58(%r13),%eax
  26db26:	mov    %eax,0xfc(%rsp)
  26db2d:	mov    0x5c(%r13),%eax
  26db31:	mov    %eax,0xf8(%rsp)
  26db38:	movzwl 0x64(%r13),%eax
  26db3d:	mov    %eax,0x100(%rsp)
  26db44:	lea    0x3917ed(%rip),%rdx        # 5ff338 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x162f0>
  26db4b:	call   323e20 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  26db50:	mov    %rax,%rcx
  26db53:	add    $0x18,%rcx
  26db57:	mov    %rcx,0x108(%rsp)
  26db5f:	mov    %rax,0x20(%rsp)
  26db64:	mov    0x28(%rax),%eax
  26db67:	cmp    $0xffffffff,%eax
  26db6a:	je     26db84 <<glass::engine::Engine>::apply+0x16a4>
  26db6c:	mov    0x108(%rsp),%rcx
  26db74:	mov    0x30(%rsp),%rdx
  26db79:	mov    0x20(%rsp),%rsi
  26db7e:	cmp    0x30(%rsi),%rdx
  26db82:	jae    26dbae <<glass::engine::Engine>::apply+0x16ce>
  26db84:	mov    0x20(%rsp),%rcx
  26db89:	mov    0x10(%rcx),%rcx
  26db8d:	cmp    %rcx,0x30(%rsp)
  26db92:	jae    26e991 <<glass::engine::Engine>::apply+0x24b1>
  26db98:	mov    0x30(%rsp),%rcx
  26db9d:	lea    (%rcx,%rcx,2),%rcx
  26dba1:	shl    $0x3,%rcx
  26dba5:	mov    0x20(%rsp),%rdx
  26dbaa:	add    0x8(%rdx),%rcx
  26dbae:	testb  $0x60,0x14(%rcx)
  26dbb2:	mov    0x38(%rsp),%r12
  26dbb7:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26dbbd:	cmp    $0x2,%r15
  26dbc1:	jne    26dc15 <<glass::engine::Engine>::apply+0x1735>
  26dbc3:	mov    0x30(%rsp),%rcx
  26dbc8:	inc    %rcx
  26dbcb:	cmp    $0xffffffff,%eax
  26dbce:	je     26dbe3 <<glass::engine::Engine>::apply+0x1703>
  26dbd0:	mov    0x108(%rsp),%rdx
  26dbd8:	mov    0x20(%rsp),%rsi
  26dbdd:	cmp    0x30(%rsi),%rcx
  26dbe1:	jae    26dc06 <<glass::engine::Engine>::apply+0x1726>
  26dbe3:	mov    0x20(%rsp),%rdx
  26dbe8:	mov    0x10(%rdx),%rdx
  26dbec:	cmp    %rdx,%rcx
  26dbef:	jae    26e9a7 <<glass::engine::Engine>::apply+0x24c7>
  26dbf5:	lea    (%rcx,%rcx,2),%rdx
  26dbf9:	shl    $0x3,%rdx
  26dbfd:	mov    0x20(%rsp),%rcx
  26dc02:	add    0x8(%rcx),%rdx
  26dc06:	testb  $0x60,0x14(%rdx)
  26dc0a:	mov    0x38(%rsp),%r12
  26dc0f:	jne    26d442 <<glass::engine::Engine>::apply+0xf62>
  26dc15:	mov    0x30(%rsp),%rcx
  26dc1a:	mov    0x20(%rsp),%rdx
  26dc1f:	cmp    %ecx,0x38(%rdx)
  26dc22:	jbe    26dc31 <<glass::engine::Engine>::apply+0x1751>
  26dc24:	mov    0x30(%rsp),%rcx
  26dc29:	mov    0x20(%rsp),%rdx
  26dc2e:	mov    %ecx,0x38(%rdx)
  26dc31:	cmp    $0xffffffff,%eax
  26dc34:	setne  %cl
  26dc37:	mov    0x20(%rsp),%rdx
  26dc3c:	mov    0x30(%rdx),%r12
  26dc40:	cmp    %r12,0x30(%rsp)
  26dc45:	sete   %dl
  26dc48:	test   %dl,%cl
  26dc4a:	jne    26dd58 <<glass::engine::Engine>::apply+0x1878>
  26dc50:	cmp    $0xffffffff,%eax
  26dc53:	je     26deb2 <<glass::engine::Engine>::apply+0x19d2>
  26dc59:	mov    0x20(%rsp),%rax
  26dc5e:	mov    0x10(%rax),%rbp
  26dc62:	cmp    %r12,%rbp
  26dc65:	mov    %r12,%rax
  26dc68:	cmovb  %rbp,%rax
  26dc6c:	mov    %rax,0x68(%rsp)
  26dc71:	mov    0x30(%rsp),%rax
  26dc76:	cmp    %rax,%rbp
  26dc79:	cmovb  %rbp,%rax
  26dc7d:	mov    %rax,0x40(%rsp)
  26dc82:	mov    0x3baeb7(%rip),%rax        # 628b40 <_DYNAMIC+0x320>
  26dc89:	movzbl (%rax),%eax
  26dc8c:	test   %al,%al
  26dc8e:	je     26dcb9 <<glass::engine::Engine>::apply+0x17d9>
  26dc90:	mov    0x3baee1(%rip),%rax        # 628b78 <_DYNAMIC+0x358>
  26dc97:	cmp    0x40(%rsp),%r12
  26dc9c:	jae    26dca5 <<glass::engine::Engine>::apply+0x17c5>
  26dc9e:	mov    0x3baedb(%rip),%rax        # 628b80 <_DYNAMIC+0x360>
  26dca5:	lock incq 0x28(%rax)
  26dcaa:	mov    0x40(%rsp),%rdi
  26dcaf:	sub    0x68(%rsp),%rdi
  26dcb4:	call   310f10 <alacritty_terminal::grid::row::fill_census::note>
  26dcb9:	cmp    0x40(%rsp),%r12
  26dcbe:	jae    26de92 <<glass::engine::Engine>::apply+0x19b2>
  26dcc4:	mov    0x20(%rsp),%rax
  26dcc9:	mov    0x28(%rax),%ecx
  26dccc:	mov    %ecx,0x54(%rsp)
  26dcd0:	mov    0x20(%rax),%ecx
  26dcd3:	mov    %ecx,0x50(%rsp)
  26dcd7:	mov    0x24(%rax),%ecx
  26dcda:	mov    %ecx,0x4c(%rsp)
  26dcde:	movzwl 0x2c(%rax),%ecx
  26dce2:	mov    %cx,0x70(%rsp)
  26dce7:	mov    0x18(%rax),%rax
  26dceb:	mov    %rax,0x8(%rsp)
  26dcf0:	test   %rax,%rax
  26dcf3:	je     26dd7c <<glass::engine::Engine>::apply+0x189c>
  26dcf9:	mov    0x8(%rsp),%rax
  26dcfe:	lock incq (%rax)
  26dd02:	jle    26ea0f <<glass::engine::Engine>::apply+0x252f>
  26dd08:	mov    0x20(%rsp),%rax
  26dd0d:	mov    0x10(%rax),%rdx
  26dd11:	mov    0x54(%rsp),%eax
  26dd15:	mov    %eax,0xc0(%rsp)
  26dd1c:	mov    0x50(%rsp),%eax
  26dd20:	mov    %eax,0xb8(%rsp)
  26dd27:	mov    0x4c(%rsp),%eax
  26dd2b:	mov    %eax,0xbc(%rsp)
  26dd32:	movzwl 0x70(%rsp),%eax
  26dd37:	mov    %ax,0xc4(%rsp)
  26dd3f:	mov    0x8(%rsp),%rax
  26dd44:	mov    %rax,0xb0(%rsp)
  26dd4c:	cmp    %rdx,0x40(%rsp)
  26dd51:	jbe    26ddb7 <<glass::engine::Engine>::apply+0x18d7>
  26dd53:	jmp    26e9bb <<glass::engine::Engine>::apply+0x24db>
  26dd58:	mov    0x30(%rsp),%rcx
  26dd5d:	lea    0x1(%rcx),%rax
  26dd61:	mov    0x20(%rsp),%rdx
  26dd66:	mov    %rax,0x30(%rdx)
  26dd6a:	mov    0x10(%rdx),%rax
  26dd6e:	cmp    %rax,%rcx
  26dd71:	jb     26dedc <<glass::engine::Engine>::apply+0x19fc>
  26dd77:	jmp    26e9d4 <<glass::engine::Engine>::apply+0x24f4>
  26dd7c:	mov    0x54(%rsp),%eax
  26dd80:	mov    %eax,0xc0(%rsp)
  26dd87:	mov    0x50(%rsp),%eax
  26dd8b:	mov    %eax,0xb8(%rsp)
  26dd92:	mov    0x4c(%rsp),%eax
  26dd96:	mov    %eax,0xbc(%rsp)
  26dd9d:	movzwl 0x70(%rsp),%eax
  26dda2:	mov    %ax,0xc4(%rsp)
  26ddaa:	mov    0x8(%rsp),%rax
  26ddaf:	mov    %rax,0xb0(%rsp)
  26ddb7:	mov    0x68(%rsp),%rax
  26ddbc:	lea    0x0(,%rax,8),%rax
  26ddc4:	lea    (%rax,%rax,2),%rax
  26ddc8:	mov    0x20(%rsp),%rcx
  26ddcd:	mov    0x8(%rcx),%rbp
  26ddd1:	add    %rax,%rbp
  26ddd4:	mov    0x40(%rsp),%rcx
  26ddd9:	lea    0x0(,%rcx,8),%rcx
  26dde1:	lea    (%rcx,%rcx,2),%r12
  26dde5:	sub    %rax,%r12
  26dde8:	jmp    26de1b <<glass::engine::Engine>::apply+0x193b>
  26ddea:	mov    0x8(%rsp),%rax
  26ddef:	mov    %rax,0x0(%rbp)
  26ddf3:	mov    0x50(%rsp),%eax
  26ddf7:	mov    %eax,0x8(%rbp)
  26ddfa:	mov    0x4c(%rsp),%eax
  26ddfe:	mov    %eax,0xc(%rbp)
  26de01:	mov    0x54(%rsp),%eax
  26de05:	mov    %eax,0x10(%rbp)
  26de08:	movzwl 0x70(%rsp),%eax
  26de0d:	mov    %ax,0x14(%rbp)
  26de11:	add    $0x18,%rbp
  26de15:	add    $0xffffffffffffffe8,%r12
  26de19:	je     26de4c <<glass::engine::Engine>::apply+0x196c>
  26de1b:	cmpq   $0x0,0x8(%rsp)
  26de21:	je     26de32 <<glass::engine::Engine>::apply+0x1952>
  26de23:	mov    0x8(%rsp),%rax
  26de28:	lock incq (%rax)
  26de2c:	jle    26ea0f <<glass::engine::Engine>::apply+0x252f>
  26de32:	mov    0x0(%rbp),%rax
  26de36:	test   %rax,%rax
  26de39:	je     26ddea <<glass::engine::Engine>::apply+0x190a>
  26de3b:	lock decq (%rax)
  26de3f:	jne    26ddea <<glass::engine::Engine>::apply+0x190a>
  26de41:	mov    %rbp,%rdi
  26de44:	call   *0x3bac3e(%rip)        # 628a88 <_DYNAMIC+0x268>
  26de4a:	jmp    26ddea <<glass::engine::Engine>::apply+0x190a>
  26de4c:	mov    0x20(%rsp),%rax
  26de51:	mov    0x68(%rsp),%rcx
  26de56:	cmp    %ecx,0x38(%rax)
  26de59:	jbe    26de68 <<glass::engine::Engine>::apply+0x1988>
  26de5b:	mov    0x20(%rsp),%rax
  26de60:	mov    0x68(%rsp),%rcx
  26de65:	mov    %ecx,0x38(%rax)
  26de68:	cmpq   $0x0,0x8(%rsp)
  26de6e:	je     26de89 <<glass::engine::Engine>::apply+0x19a9>
  26de70:	mov    0x8(%rsp),%rax
  26de75:	lock decq (%rax)
  26de79:	jne    26de89 <<glass::engine::Engine>::apply+0x19a9>
  26de7b:	lea    0xb0(%rsp),%rdi
  26de83:	call   *0x3babff(%rip)        # 628a88 <_DYNAMIC+0x268>
  26de89:	mov    0x20(%rsp),%rax
  26de8e:	mov    0x10(%rax),%rbp
  26de92:	cmp    %rbp,0x40(%rsp)
  26de97:	jb     26deb2 <<glass::engine::Engine>::apply+0x19d2>
  26de99:	mov    0x108(%rsp),%rdi
  26dea1:	call   1b72c0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26dea6:	mov    0x20(%rsp),%rax
  26deab:	movl   $0xffffffff,0x28(%rax)
  26deb2:	mov    0x20(%rsp),%rsi
  26deb7:	mov    0x30(%rsi),%rcx
  26debb:	mov    0x30(%rsp),%rdx
  26dec0:	lea    0x1(%rdx),%rax
  26dec4:	cmp    %rcx,%rax
  26dec7:	cmova  %rax,%rcx
  26decb:	mov    0x10(%rsi),%rax
  26decf:	mov    %rcx,0x30(%rsi)
  26ded3:	cmp    %rax,%rdx
  26ded6:	jae    26e9db <<glass::engine::Engine>::apply+0x24fb>
  26dedc:	mov    0x100(%rsp),%edi
  26dee3:	mov    %edi,%eax
  26dee5:	or     $0x20,%eax
  26dee8:	cmp    $0x2,%r15
  26deec:	mov    0x20(%rsp),%rcx
  26def1:	mov    0x8(%rcx),%rcx
  26def5:	mov    0x30(%rsp),%rdx
  26defa:	lea    (%rdx,%rdx,2),%rdx
  26defe:	lea    (%rcx,%rdx,8),%rbp
  26df02:	mov    0xd0(%rsp),%rsi
  26df0a:	mov    %esi,0x10(%rcx,%rdx,8)
  26df0e:	mov    0xfc(%rsp),%esi
  26df15:	mov    %esi,0x8(%rcx,%rdx,8)
  26df19:	cmovne %edi,%eax
  26df1c:	mov    0xf8(%rsp),%esi
  26df23:	mov    %esi,0xc(%rcx,%rdx,8)
  26df27:	mov    %ax,0x14(%rcx,%rdx,8)
  26df2c:	mov    (%rcx,%rdx,8),%rax
  26df30:	test   %rax,%rax
  26df33:	je     26df44 <<glass::engine::Engine>::apply+0x1a64>
  26df35:	lock decq (%rax)
  26df39:	jne    26df44 <<glass::engine::Engine>::apply+0x1a64>
  26df3b:	mov    %rbp,%rdi
  26df3e:	call   *0x3bab44(%rip)        # 628a88 <_DYNAMIC+0x268>
  26df44:	movq   $0x0,0x0(%rbp)
  26df4c:	cmp    $0x2,%r15
  26df50:	jne    26e242 <<glass::engine::Engine>::apply+0x1d62>
  26df56:	mov    0x30(%rsp),%rax
  26df5b:	lea    0x1(%rax),%rdx
  26df5f:	mov    0x20(%rsp),%rax
  26df64:	mov    0x30(%rax),%r15
  26df68:	mov    0x28(%rax),%eax
  26df6b:	mov    %rdx,0x70(%rsp)
  26df70:	cmp    %r15,%rdx
  26df73:	jne    26dfa0 <<glass::engine::Engine>::apply+0x1ac0>
  26df75:	cmp    $0xffffffff,%eax
  26df78:	je     26dfa0 <<glass::engine::Engine>::apply+0x1ac0>
  26df7a:	mov    0x30(%rsp),%rax
  26df7f:	add    $0x2,%rax
  26df83:	mov    0x20(%rsp),%rcx
  26df88:	mov    %rax,0x30(%rcx)
  26df8c:	mov    0x10(%rcx),%rax
  26df90:	cmp    %rax,0x70(%rsp)
  26df95:	jb     26e1e0 <<glass::engine::Engine>::apply+0x1d00>
  26df9b:	jmp    26e9e2 <<glass::engine::Engine>::apply+0x2502>
  26dfa0:	cmp    $0xffffffff,%eax
  26dfa3:	je     26e1b4 <<glass::engine::Engine>::apply+0x1cd4>
  26dfa9:	mov    0x20(%rsp),%rax
  26dfae:	mov    0x10(%rax),%r12
  26dfb2:	cmp    %r15,%r12
  26dfb5:	mov    %r15,%rax
  26dfb8:	cmovb  %r12,%rax
  26dfbc:	mov    %rax,0x68(%rsp)
  26dfc1:	mov    0x70(%rsp),%rax
  26dfc6:	cmp    %rax,%r12
  26dfc9:	cmovb  %r12,%rax
  26dfcd:	mov    %rax,0x40(%rsp)
  26dfd2:	mov    0x3bab67(%rip),%rax        # 628b40 <_DYNAMIC+0x320>
  26dfd9:	movzbl (%rax),%eax
  26dfdc:	test   %al,%al
  26dfde:	je     26e009 <<glass::engine::Engine>::apply+0x1b29>
  26dfe0:	mov    0x3bab91(%rip),%rax        # 628b78 <_DYNAMIC+0x358>
  26dfe7:	cmp    0x40(%rsp),%r15
  26dfec:	jae    26dff5 <<glass::engine::Engine>::apply+0x1b15>
  26dfee:	mov    0x3bab8b(%rip),%rax        # 628b80 <_DYNAMIC+0x360>
  26dff5:	lock incq 0x28(%rax)
  26dffa:	mov    0x40(%rsp),%rdi
  26dfff:	sub    0x68(%rsp),%rdi
  26e004:	call   310f10 <alacritty_terminal::grid::row::fill_census::note>
  26e009:	cmp    0x40(%rsp),%r15
  26e00e:	jae    26e194 <<glass::engine::Engine>::apply+0x1cb4>
  26e014:	mov    0x20(%rsp),%rax
  26e019:	mov    0x28(%rax),%ecx
  26e01c:	mov    %ecx,0x8(%rsp)
  26e020:	mov    0x20(%rax),%ecx
  26e023:	mov    %ecx,0x54(%rsp)
  26e027:	mov    0x24(%rax),%ecx
  26e02a:	mov    %ecx,0x50(%rsp)
  26e02e:	movzwl 0x2c(%rax),%ecx
  26e032:	mov    %cx,0x4c(%rsp)
  26e037:	mov    0x18(%rax),%r12
  26e03b:	test   %r12,%r12
  26e03e:	je     26e096 <<glass::engine::Engine>::apply+0x1bb6>
  26e040:	lock incq (%r12)
  26e045:	jle    26ea0f <<glass::engine::Engine>::apply+0x252f>
  26e04b:	mov    0x20(%rsp),%rax
  26e050:	mov    0x10(%rax),%rdx
  26e054:	mov    0x8(%rsp),%eax
  26e058:	mov    %eax,0xc0(%rsp)
  26e05f:	mov    0x54(%rsp),%eax
  26e063:	mov    %eax,0xb8(%rsp)
  26e06a:	mov    0x50(%rsp),%eax
  26e06e:	mov    %eax,0xbc(%rsp)
  26e075:	movzwl 0x4c(%rsp),%eax
  26e07a:	mov    %ax,0xc4(%rsp)
  26e082:	mov    %r12,0xb0(%rsp)
  26e08a:	cmp    %rdx,0x40(%rsp)
  26e08f:	jbe    26e0cc <<glass::engine::Engine>::apply+0x1bec>
  26e091:	jmp    26e9f8 <<glass::engine::Engine>::apply+0x2518>
  26e096:	mov    0x8(%rsp),%eax
  26e09a:	mov    %eax,0xc0(%rsp)
  26e0a1:	mov    0x54(%rsp),%eax
  26e0a5:	mov    %eax,0xb8(%rsp)
  26e0ac:	mov    0x50(%rsp),%eax
  26e0b0:	mov    %eax,0xbc(%rsp)
  26e0b7:	movzwl 0x4c(%rsp),%eax
  26e0bc:	mov    %ax,0xc4(%rsp)
  26e0c4:	mov    %r12,0xb0(%rsp)
  26e0cc:	mov    0x68(%rsp),%rax
  26e0d1:	lea    0x0(,%rax,8),%rax
  26e0d9:	lea    (%rax,%rax,2),%rax
  26e0dd:	mov    0x20(%rsp),%rcx
  26e0e2:	mov    0x8(%rcx),%rbp
  26e0e6:	add    %rax,%rbp
  26e0e9:	mov    0x40(%rsp),%rcx
  26e0ee:	lea    0x0(,%rcx,8),%rcx
  26e0f6:	lea    (%rcx,%rcx,2),%r15
  26e0fa:	sub    %rax,%r15
  26e0fd:	jmp    26e12b <<glass::engine::Engine>::apply+0x1c4b>
  26e0ff:	mov    %r12,0x0(%rbp)
  26e103:	mov    0x54(%rsp),%eax
  26e107:	mov    %eax,0x8(%rbp)
  26e10a:	mov    0x50(%rsp),%eax
  26e10e:	mov    %eax,0xc(%rbp)
  26e111:	mov    0x8(%rsp),%eax
  26e115:	mov    %eax,0x10(%rbp)
  26e118:	movzwl 0x4c(%rsp),%eax
  26e11d:	mov    %ax,0x14(%rbp)
  26e121:	add    $0x18,%rbp
  26e125:	add    $0xffffffffffffffe8,%r15
  26e129:	je     26e155 <<glass::engine::Engine>::apply+0x1c75>
  26e12b:	test   %r12,%r12
  26e12e:	je     26e13b <<glass::engine::Engine>::apply+0x1c5b>
  26e130:	lock incq (%r12)
  26e135:	jle    26ea0f <<glass::engine::Engine>::apply+0x252f>
  26e13b:	mov    0x0(%rbp),%rax
  26e13f:	test   %rax,%rax
  26e142:	je     26e0ff <<glass::engine::Engine>::apply+0x1c1f>
  26e144:	lock decq (%rax)
  26e148:	jne    26e0ff <<glass::engine::Engine>::apply+0x1c1f>
  26e14a:	mov    %rbp,%rdi
  26e14d:	call   *0x3ba935(%rip)        # 628a88 <_DYNAMIC+0x268>
  26e153:	jmp    26e0ff <<glass::engine::Engine>::apply+0x1c1f>
  26e155:	mov    0x20(%rsp),%rax
  26e15a:	mov    0x68(%rsp),%rcx
  26e15f:	cmp    %ecx,0x38(%rax)
  26e162:	jbe    26e171 <<glass::engine::Engine>::apply+0x1c91>
  26e164:	mov    0x20(%rsp),%rax
  26e169:	mov    0x68(%rsp),%rcx
  26e16e:	mov    %ecx,0x38(%rax)
  26e171:	test   %r12,%r12
  26e174:	je     26e18b <<glass::engine::Engine>::apply+0x1cab>
  26e176:	lock decq (%r12)
  26e17b:	jne    26e18b <<glass::engine::Engine>::apply+0x1cab>
  26e17d:	lea    0xb0(%rsp),%rdi
  26e185:	call   *0x3ba8fd(%rip)        # 628a88 <_DYNAMIC+0x268>
  26e18b:	mov    0x20(%rsp),%rax
  26e190:	mov    0x10(%rax),%r12
  26e194:	cmp    %r12,0x40(%rsp)
  26e199:	jb     26e1b4 <<glass::engine::Engine>::apply+0x1cd4>
  26e19b:	mov    0x108(%rsp),%rdi
  26e1a3:	call   1b72c0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26e1a8:	mov    0x20(%rsp),%rax
  26e1ad:	movl   $0xffffffff,0x28(%rax)
  26e1b4:	mov    0x20(%rsp),%rdx
  26e1b9:	mov    0x30(%rdx),%rax
  26e1bd:	mov    0x30(%rsp),%rcx
  26e1c2:	add    $0x2,%rcx
  26e1c6:	cmp    %rax,%rcx
  26e1c9:	cmovbe %rax,%rcx
  26e1cd:	mov    0x10(%rdx),%rax
  26e1d1:	mov    %rcx,0x30(%rdx)
  26e1d5:	cmp    %rax,0x70(%rsp)
  26e1da:	jae    26ea11 <<glass::engine::Engine>::apply+0x2531>
  26e1e0:	mov    0x20(%rsp),%rax
  26e1e5:	mov    0x8(%rax),%rax
  26e1e9:	mov    0x70(%rsp),%rcx
  26e1ee:	lea    (%rcx,%rcx,2),%rcx
  26e1f2:	lea    (%rax,%rcx,8),%r15
  26e1f6:	movl   $0x20,0x10(%rax,%rcx,8)
  26e1fe:	mov    0xfc(%rsp),%edx
  26e205:	mov    %edx,0x8(%rax,%rcx,8)
  26e209:	mov    0xf8(%rsp),%edx
  26e210:	mov    %edx,0xc(%rax,%rcx,8)
  26e214:	mov    0x100(%rsp),%edx
  26e21b:	or     $0x40,%edx
  26e21e:	mov    %dx,0x14(%rax,%rcx,8)
  26e223:	mov    (%rax,%rcx,8),%rax
  26e227:	test   %rax,%rax
  26e22a:	je     26e23b <<glass::engine::Engine>::apply+0x1d5b>
  26e22c:	lock decq (%rax)
  26e230:	jne    26e23b <<glass::engine::Engine>::apply+0x1d5b>
  26e232:	mov    %r15,%rdi
  26e235:	call   *0x3ba84d(%rip)        # 628a88 <_DYNAMIC+0x268>
  26e23b:	movq   $0x0,(%r15)
  26e242:	mov    0x220(%rsp),%rax
  26e24a:	cmp    %rax,0x118(%rsp)
  26e252:	jb     26e261 <<glass::engine::Engine>::apply+0x1d81>
  26e254:	decq   0x118(%rsp)
  26e25c:	movb   $0x1,0x6c(%r13)
  26e261:	mov    0x118(%rsp),%rax
  26e269:	mov    %rax,0x40(%r13)
  26e26d:	incq   0x1d0(%rsp)
  26e275:	mov    0xd0(%rsp),%rax
  26e27d:	mov    %eax,0x1e0(%rsp)
  26e284:	mov    $0x1,%r15d
  26e28a:	mov    0x38(%rsp),%r12
  26e28f:	mov    0x3bd7eb(%rip),%eax        # 62ba80 <glass::engine::run_whole::ON>
  26e295:	test   %eax,%eax
  26e297:	je     26d468 <<glass::engine::Engine>::apply+0xf88>
  26e29d:	call   193146 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  26e2a2:	jmp    26d468 <<glass::engine::Engine>::apply+0xf88>
  26e2a7:	nopw   0x0(%rax,%rax,1)
  26e2b0:	mov    0x3bb031(%rip),%rax        # 6292e8 <_DYNAMIC+0xac8>
  26e2b7:	mov    (%rax),%rax
  26e2ba:	mov    $0x1b,%edi
  26e2bf:	mov    %r14,%rsi
  26e2c2:	mov    0x110(%rsp),%rbx
  26e2ca:	mov    %rbx,%rdx
  26e2cd:	call   *%rax
  26e2cf:	mov    %r14,%r13
  26e2d2:	mov    %rbx,%r14
  26e2d5:	cmp    $0x1,%rax
  26e2d9:	jne    26e590 <<glass::engine::Engine>::apply+0x20b0>
  26e2df:	mov    %rdx,%rcx
  26e2e2:	sub    %r13,%rcx
  26e2e5:	movb   $0x1,0xa80(%r12)
  26e2ee:	movb   $0x0,0xa7e(%r12)
  26e2f7:	inc    %rcx
  26e2fa:	cmp    %r15,%rcx
  26e2fd:	jb     26e59b <<glass::engine::Engine>::apply+0x20bb>
  26e303:	movzbl 0xa7e(%r12),%eax
  26e30c:	jmp    26e691 <<glass::engine::Engine>::apply+0x21b1>
  26e311:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  26e320:	mov    0x18(%rsp),%r15
  26e325:	cmp    %rbp,%r15
  26e328:	jb     26e8df <<glass::engine::Engine>::apply+0x23ff>
  26e32e:	mov    0x28(%rsp),%r13
  26e333:	mov    %r13,%rbx
  26e336:	add    %rbp,%rbx
  26e339:	mov    0x3bafa8(%rip),%rax        # 6292e8 <_DYNAMIC+0xac8>
  26e340:	mov    (%rax),%rax
  26e343:	mov    $0x1b,%edi
  26e348:	mov    %rbx,%rsi
  26e34b:	mov    0x110(%rsp),%r14
  26e353:	mov    %r14,%rdx
  26e356:	call   *%rax
  26e358:	cmp    $0x1,%rax
  26e35c:	jne    26e379 <<glass::engine::Engine>::apply+0x1e99>
  26e35e:	sub    %rbx,%rdx
  26e361:	movb   $0x1,0xa80(%r12)
  26e36a:	movb   $0x0,0xa7e(%r12)
  26e373:	add    %rdx,%rbp
  26e376:	inc    %rbp
  26e379:	cmp    %r15,%rbp
  26e37c:	jae    26e3b3 <<glass::engine::Engine>::apply+0x1ed3>
  26e37e:	mov    0x60(%rsp),%rdi
  26e383:	mov    %r13,%rsi
  26e386:	mov    %r15,%rdx
  26e389:	mov    %rbp,%rcx
  26e38c:	mov    %r15,%r8
  26e38f:	call   284900 <<glass::engine::Mirror>::stretch>
  26e394:	cmp    %r15,%rax
  26e397:	jae    26e3b3 <<glass::engine::Engine>::apply+0x1ed3>
  26e399:	cmpb   $0x0,0xa80(%r12)
  26e3a2:	jne    26e3b3 <<glass::engine::Engine>::apply+0x1ed3>
  26e3a4:	movzbl -0x1(%r14),%eax
  26e3a9:	shr    $0x7,%al
  26e3ac:	mov    0x60(%rsp),%rcx
  26e3b1:	mov    %al,(%rcx)
  26e3b3:	movzbl 0xa7e(%r12),%eax
  26e3bc:	mov    %al,0xa7f(%r12)
  26e3c4:	sub    0x8(%rsp),%r15
  26e3c9:	mov    0xe0(%rsp),%rbx
  26e3d1:	jbe    26e400 <<glass::engine::Engine>::apply+0x1f20>
  26e3d3:	movzbl 0x3c09fe(%rip),%eax        # 62edd8 <glass::engine::counters::COUNTING>
  26e3da:	test   %al,%al
  26e3dc:	je     26e3e6 <<glass::engine::Engine>::apply+0x1f06>
  26e3de:	lock add %r15,0x3c09fa(%rip)        # 62ede0 <glass::engine::counters::VTE_BYTES>
  26e3e6:	movzbl 0x3c098b(%rip),%eax        # 62ed78 <glass::engine::probes::RUN_PROBE>
  26e3ed:	cmp    $0x68,%al
  26e3ef:	jne    26e73a <<glass::engine::Engine>::apply+0x225a>
  26e3f5:	data16 cs nopw 0x0(%rax,%rax,1)
  26e400:	mov    0x1e0(%rsp),%rax
  26e408:	mov    %rax,0xa70(%r12)
  26e410:	mov    0x1e8(%rsp),%eax
  26e417:	mov    %eax,0xa78(%r12)
  26e41f:	pshufd $0x4e,0x1c0(%rsp),%xmm0
  26e429:	movdqu %xmm0,0xa60(%r12)
  26e433:	movzbl 0x1ed(%rsp),%eax
  26e43b:	mov    %al,0xa7d(%r12)
  26e443:	movzbl 0x1ec(%rsp),%eax
  26e44b:	and    $0x1,%eax
  26e44e:	shl    $0x5,%eax
  26e451:	mov    0x1b8(%rsp,%rax,1),%rax
  26e459:	mov    0xa58(%r12),%rcx
  26e461:	cmp    %rcx,%rax
  26e464:	cmova  %rax,%rcx
  26e468:	mov    %rcx,0xa58(%r12)
  26e470:	mov    0x140(%rsp),%rax
  26e478:	mov    %rax,0x28(%rsp)
  26e47d:	mov    0x148(%rsp),%r13
  26e485:	mov    0x150(%rsp),%r14
  26e48d:	movq   $0x0,0x140(%rsp)
  26e499:	movq   $0x8,0x148(%rsp)
  26e4a5:	movq   $0x0,0x150(%rsp)
  26e4b1:	test   %r14,%r14
  26e4b4:	je     26e512 <<glass::engine::Engine>::apply+0x2032>
  26e4b6:	mov    0x8e8(%r12),%rax
  26e4be:	mov    0x8f8(%r12),%r15
  26e4c6:	sub    %r15,%rax
  26e4c9:	cmp    %rax,%r14
  26e4cc:	ja     26e80d <<glass::engine::Engine>::apply+0x232d>
  26e4d2:	mov    %r14,%rax
  26e4d5:	shl    $0x4,%rax
  26e4d9:	lea    (%rax,%rax,2),%rdx
  26e4dd:	lea    (%r15,%r15,2),%rdi
  26e4e1:	shl    $0x4,%rdi
  26e4e5:	add    0x8f0(%r12),%rdi
  26e4ed:	mov    %r13,%rsi
  26e4f0:	call   *0x3ba55a(%rip)        # 628a50 <memcpy@GLIBC_2.14>
  26e4f6:	add    %r14,%r15
  26e4f9:	mov    %r15,0x8f8(%r12)
  26e501:	cmpq   $0x0,0x28(%rsp)
  26e507:	je     26e512 <<glass::engine::Engine>::apply+0x2032>
  26e509:	mov    %r13,%rdi
  26e50c:	call   *0x3ba556(%rip)        # 628a68 <_DYNAMIC+0x248>
  26e512:	mov    0x170(%rsp),%r15
  26e51a:	lea    0x178(%rsp),%rax
  26e522:	movups (%rax),%xmm0
  26e525:	movups 0x10(%rax),%xmm1
  26e529:	movups 0x20(%rax),%xmm2
  26e52d:	movaps %xmm0,0x80(%rsp)
  26e535:	movaps %xmm1,0x90(%rsp)
  26e53d:	movaps %xmm2,0xa0(%rsp)
  26e545:	movq   $0xffffffffffffffff,0x170(%rsp)
  26e551:	cmp    $0xffffffffffffffff,%r15
  26e555:	je     26e580 <<glass::engine::Engine>::apply+0x20a0>
  26e557:	cmpq   $0x0,0x998(%r12)
  26e560:	jle    26e5da <<glass::engine::Engine>::apply+0x20fa>
  26e562:	mov    (%rbx),%rdi
  26e565:	call   *0x3ba4fd(%rip)        # 628a68 <_DYNAMIC+0x248>
  26e56b:	cmpq   $0x0,0x170(%rsp)
  26e574:	setg   %bpl
  26e578:	jmp    26e5dc <<glass::engine::Engine>::apply+0x20fc>
  26e57a:	nopw   0x0(%rax,%rax,1)
  26e580:	xor    %ebp,%ebp
  26e582:	jmp    26e607 <<glass::engine::Engine>::apply+0x2127>
  26e587:	nopw   0x0(%rax,%rax,1)
  26e590:	xor    %ecx,%ecx
  26e592:	cmp    %r15,%rcx
  26e595:	jae    26e303 <<glass::engine::Engine>::apply+0x1e23>
  26e59b:	mov    0x60(%rsp),%rdi
  26e5a0:	mov    %r13,%rsi
  26e5a3:	mov    %r15,%rdx
  26e5a6:	mov    %r15,%r8
  26e5a9:	call   284900 <<glass::engine::Mirror>::stretch>
  26e5ae:	cmp    %r15,%rax
  26e5b1:	jae    26e689 <<glass::engine::Engine>::apply+0x21a9>
  26e5b7:	cmpb   $0x0,0xa80(%r12)
  26e5c0:	jne    26e689 <<glass::engine::Engine>::apply+0x21a9>
  26e5c6:	movzbl -0x1(%r14),%eax
  26e5cb:	shr    $0x7,%al
  26e5ce:	mov    0x60(%rsp),%rcx
  26e5d3:	mov    %al,(%rcx)
  26e5d5:	jmp    26e691 <<glass::engine::Engine>::apply+0x21b1>
  26e5da:	xor    %ebp,%ebp
  26e5dc:	mov    %r15,0x998(%r12)
  26e5e4:	movaps 0x80(%rsp),%xmm0
  26e5ec:	movaps 0x90(%rsp),%xmm1
  26e5f4:	movaps 0xa0(%rsp),%xmm2
  26e5fc:	movups %xmm2,0x20(%rbx)
  26e600:	movups %xmm1,0x10(%rbx)
  26e604:	movups %xmm0,(%rbx)
  26e607:	mov    0x158(%rsp),%rbx
  26e60f:	mov    0x160(%rsp),%r12
  26e617:	mov    0x178(%rsp),%r15
  26e61f:	cmpq   $0x0,0x140(%rsp)
  26e628:	je     26e638 <<glass::engine::Engine>::apply+0x2158>
  26e62a:	mov    0x148(%rsp),%rdi
  26e632:	call   *0x3ba430(%rip)        # 628a68 <_DYNAMIC+0x248>
  26e638:	test   %rbx,%rbx
  26e63b:	je     26e646 <<glass::engine::Engine>::apply+0x2166>
  26e63d:	mov    %r12,%rdi
  26e640:	call   *0x3ba422(%rip)        # 628a68 <_DYNAMIC+0x248>
  26e646:	test   %bpl,%bpl
  26e649:	je     26e654 <<glass::engine::Engine>::apply+0x2174>
  26e64b:	mov    %r15,%rdi
  26e64e:	call   *0x3ba414(%rip)        # 628a68 <_DYNAMIC+0x248>
  26e654:	mov    0x38(%rsp),%rbx
  26e659:	mov    %rbx,%rdi
  26e65c:	call   26b750 <<glass::engine::Engine>::fold_sentinel>
  26e661:	test   %r14,%r14
  26e664:	setne  %al
  26e667:	cmpq   $0x0,0x28(%rsp)
  26e66d:	sete   %cl
  26e670:	or     %al,%cl
  26e672:	cmp    $0x1,%cl
  26e675:	je     26c5c0 <<glass::engine::Engine>::apply+0xe0>
  26e67b:	mov    %r13,%rdi
  26e67e:	call   *0x3ba3e4(%rip)        # 628a68 <_DYNAMIC+0x248>
  26e684:	jmp    26c5c0 <<glass::engine::Engine>::apply+0xe0>
  26e689:	mov    0x60(%rsp),%rax
  26e68e:	movzbl (%rax),%eax
  26e691:	mov    %al,0xa7f(%r12)
  26e699:	mov    0xe0(%rsp),%rbx
  26e6a1:	xor    %ebp,%ebp
  26e6a3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  26e6b0:	cmpl   $0xffffffff,0x710(%r12)
  26e6b9:	jne    26e714 <<glass::engine::Engine>::apply+0x2234>
  26e6bb:	mov    0x78(%rsp),%rax
  26e6c0:	mov    %rax,0x80(%rsp)
  26e6c8:	lea    0x130(%rsp),%rax
  26e6d0:	mov    %rax,0x88(%rsp)
  26e6d8:	movb   $0x0,0x90(%rsp)
  26e6e0:	mov    %r15,%rcx
  26e6e3:	sub    %rbp,%rcx
  26e6e6:	jb     26e84a <<glass::engine::Engine>::apply+0x236a>
  26e6ec:	mov    %r13,%rdx
  26e6ef:	add    %rbp,%rdx
  26e6f2:	mov    0xf0(%rsp),%rdi
  26e6fa:	lea    0x80(%rsp),%rsi
  26e702:	call   1a8780 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  26e707:	add    %rax,%rbp
  26e70a:	cmp    %r15,%rbp
  26e70d:	jne    26e6b0 <<glass::engine::Engine>::apply+0x21d0>
  26e70f:	jmp    26e400 <<glass::engine::Engine>::apply+0x1f20>
  26e714:	mov    %r15,%rcx
  26e717:	sub    %rbp,%rcx
  26e71a:	jb     26e956 <<glass::engine::Engine>::apply+0x2476>
  26e720:	mov    %r13,%rdx
  26e723:	add    %rbp,%rdx
  26e726:	mov    0x78(%rsp),%rdi
  26e72b:	lea    0x130(%rsp),%rsi
  26e733:	call   19bf90 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  26e738:	jmp    26e707 <<glass::engine::Engine>::apply+0x2227>
  26e73a:	mov    %r15,%rdx
  26e73d:	add    0x8(%rsp),%r13
  26e742:	cmpb   $0x1,0x58(%rsp)
  26e747:	jne    26e777 <<glass::engine::Engine>::apply+0x2297>
  26e749:	cmpl   $0xffffffff,0x710(%r12)
  26e752:	jne    26e777 <<glass::engine::Engine>::apply+0x2297>
  26e754:	lea    0x130(%rsp),%rdi
  26e75c:	mov    %r13,%rsi
  26e75f:	call   2bbf40 <glass::engine::plain_c0>
  26e764:	test   %al,%al
  26e766:	mov    0xe0(%rsp),%rbx
  26e76e:	mov    %r15,%rdx
  26e771:	jne    26e400 <<glass::engine::Engine>::apply+0x1f20>
  26e777:	xor    %ebp,%ebp
  26e779:	nopl   0x0(%rax)
  26e780:	cmpl   $0xffffffff,0x710(%r12)
  26e789:	jne    26e7e7 <<glass::engine::Engine>::apply+0x2307>
  26e78b:	mov    0x78(%rsp),%rax
  26e790:	mov    %rax,0x80(%rsp)
  26e798:	lea    0x130(%rsp),%rax
  26e7a0:	mov    %rax,0x88(%rsp)
  26e7a8:	movb   $0x0,0x90(%rsp)
  26e7b0:	mov    %r15,%rcx
  26e7b3:	sub    %rbp,%rcx
  26e7b6:	jb     26e84a <<glass::engine::Engine>::apply+0x236a>
  26e7bc:	mov    %r13,%rdx
  26e7bf:	add    %rbp,%rdx
  26e7c2:	mov    0xf0(%rsp),%rdi
  26e7ca:	lea    0x80(%rsp),%rsi
  26e7d2:	call   1a8780 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  26e7d7:	add    %rax,%rbp
  26e7da:	mov    %r15,%rdx
  26e7dd:	cmp    %r15,%rbp
  26e7e0:	jne    26e780 <<glass::engine::Engine>::apply+0x22a0>
  26e7e2:	jmp    26e400 <<glass::engine::Engine>::apply+0x1f20>
  26e7e7:	mov    %rdx,%rcx
  26e7ea:	sub    %rbp,%rcx
  26e7ed:	jb     26e956 <<glass::engine::Engine>::apply+0x2476>
  26e7f3:	mov    %r13,%rdx
  26e7f6:	add    %rbp,%rdx
  26e7f9:	mov    0x78(%rsp),%rdi
  26e7fe:	lea    0x130(%rsp),%rsi
  26e806:	call   19bf90 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  26e80b:	jmp    26e7d7 <<glass::engine::Engine>::apply+0x22f7>
  26e80d:	mov    $0x8,%ecx
  26e812:	mov    $0x30,%r8d
  26e818:	mov    0x228(%rsp),%rdi
  26e820:	mov    %r15,%rsi
  26e823:	mov    %r14,%rdx
  26e826:	call   1e2640 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  26e82b:	mov    0x8f8(%r12),%r15
  26e833:	jmp    26e4d2 <<glass::engine::Engine>::apply+0x1ff2>
  26e838:	add    $0x248,%rsp
  26e83f:	pop    %rbx
  26e840:	pop    %r12
  26e842:	pop    %r13
  26e844:	pop    %r14
  26e846:	pop    %r15
  26e848:	pop    %rbp
  26e849:	ret
  26e84a:	mov    %r15,%r8
  26e84d:	lea    0x37b06c(%rip),%rcx        # 5e98c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  26e854:	jmp    26e871 <<glass::engine::Engine>::apply+0x2391>
  26e856:	mov    %rbx,%r8
  26e859:	lea    0x390ce8(%rip),%rcx        # 5ff548 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16500>
  26e860:	mov    0x18(%rsp),%r15
  26e865:	jmp    26e871 <<glass::engine::Engine>::apply+0x2391>
  26e867:	mov    %rbx,%r8
  26e86a:	lea    0x390cd7(%rip),%rcx        # 5ff548 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16500>
  26e871:	mov    %rbp,%rdi
  26e874:	mov    %r8,%rsi
  26e877:	mov    %r15,%rdx
  26e87a:	call   *0x3ba378(%rip)        # 628bf8 <_DYNAMIC+0x3d8>
  26e880:	jmp    26ea0f <<glass::engine::Engine>::apply+0x252f>
  26e885:	mov    %rbx,%rbp
  26e888:	mov    %r13,%r8
  26e88b:	lea    0x39339e(%rip),%rcx        # 601c30 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18be8>
  26e892:	mov    0x18(%rsp),%r15
  26e897:	jmp    26e871 <<glass::engine::Engine>::apply+0x2391>
  26e899:	lea    0x3933c0(%rip),%rcx        # 601c60 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c18>
  26e8a0:	xor    %ebp,%ebp
  26e8a2:	mov    0x18(%rsp),%r15
  26e8a7:	mov    %rdx,%r8
  26e8aa:	jmp    26e871 <<glass::engine::Engine>::apply+0x2391>
  26e8ac:	mov    0x8(%rsp),%rbp
  26e8b1:	mov    %rbx,%r8
  26e8b4:	lea    0x39338d(%rip),%rcx        # 601c48 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c00>
  26e8bb:	mov    0x18(%rsp),%r15
  26e8c0:	jmp    26e871 <<glass::engine::Engine>::apply+0x2391>
  26e8c2:	mov    $0xffffffffffffffff,%r8
  26e8c9:	xor    %ebp,%ebp
  26e8cb:	xor    %r15d,%r15d
  26e8ce:	lea    0x393343(%rip),%rcx        # 601c18 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18bd0>
  26e8d5:	jmp    26e871 <<glass::engine::Engine>::apply+0x2391>
  26e8d7:	mov    %r13,%rbp
  26e8da:	jmp    26e859 <<glass::engine::Engine>::apply+0x2379>
  26e8df:	mov    %r15,%r8
  26e8e2:	jmp    26e86a <<glass::engine::Engine>::apply+0x238a>
  26e8e4:	lea    0x3932fd(%rip),%rdx        # 601be8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18ba0>
  26e8eb:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26e8ed:	mov    %r13,%rbp
  26e8f0:	lea    0x393381(%rip),%rcx        # 601c78 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c30>
  26e8f7:	mov    0x18(%rsp),%r15
  26e8fc:	jmp    26e871 <<glass::engine::Engine>::apply+0x2391>
  26e901:	lea    0x3932f8(%rip),%rdx        # 601c00 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18bb8>
  26e908:	mov    %r14,%rdi
  26e90b:	mov    0x18(%rsp),%rsi
  26e910:	call   *0x3ba122(%rip)        # 628a38 <_DYNAMIC+0x218>
  26e916:	jmp    26ea0f <<glass::engine::Engine>::apply+0x252f>
  26e91b:	mov    $0x10,%eax
  26e920:	mov    %rax,0x18(%rsp)
  26e925:	mov    $0xffffffffffffffff,%r14
  26e92c:	lea    0x39335d(%rip),%rdx        # 601c90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c48>
  26e933:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26e935:	mov    $0x8,%edi
  26e93a:	mov    %r14,%rsi
  26e93d:	call   *0x3ba0e5(%rip)        # 628a28 <_DYNAMIC+0x208>
  26e943:	mov    $0x10,%eax
  26e948:	mov    %rax,0x18(%rsp)
  26e94d:	lea    0x393354(%rip),%rdx        # 601ca8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c60>
  26e954:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26e956:	mov    %r15,%r8
  26e959:	lea    0x37af78(%rip),%rcx        # 5e98d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  26e960:	jmp    26e871 <<glass::engine::Engine>::apply+0x2391>
  26e965:	mov    $0x10,%eax
  26e96a:	mov    %rax,0x18(%rsp)
  26e96f:	lea    0x39334a(%rip),%rdx        # 601cc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c78>
  26e976:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26e978:	mov    %rsi,%r14
  26e97b:	mov    0x10(%rsp),%rax
  26e980:	mov    %rax,0x18(%rsp)
  26e985:	lea    0x393244(%rip),%rdx        # 601bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18b88>
  26e98c:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26e991:	mov    0x30(%rsp),%r14
  26e996:	mov    %rcx,0x18(%rsp)
  26e99b:	lea    0x37dde6(%rip),%rdx        # 5ec788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  26e9a2:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26e9a7:	mov    %rcx,%r14
  26e9aa:	mov    %rdx,0x18(%rsp)
  26e9af:	lea    0x37ddd2(%rip),%rdx        # 5ec788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  26e9b6:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26e9bb:	lea    0x3902fe(%rip),%rcx        # 5fecc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  26e9c2:	mov    0x68(%rsp),%rdi
  26e9c7:	mov    0x40(%rsp),%rsi
  26e9cc:	call   *0x3ba226(%rip)        # 628bf8 <_DYNAMIC+0x3d8>
  26e9d2:	jmp    26ea0f <<glass::engine::Engine>::apply+0x252f>
  26e9d4:	mov    0x30(%rsp),%r14
  26e9d9:	jmp    26e9e7 <<glass::engine::Engine>::apply+0x2507>
  26e9db:	mov    0x30(%rsp),%r14
  26e9e0:	jmp    26ea16 <<glass::engine::Engine>::apply+0x2536>
  26e9e2:	mov    0x70(%rsp),%r14
  26e9e7:	mov    %rax,0x18(%rsp)
  26e9ec:	lea    0x390ecd(%rip),%rdx        # 5ff8c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  26e9f3:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26e9f8:	lea    0x3902c1(%rip),%rcx        # 5fecc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  26e9ff:	mov    0x68(%rsp),%rdi
  26ea04:	mov    0x40(%rsp),%rsi
  26ea09:	call   *0x3ba1e9(%rip)        # 628bf8 <_DYNAMIC+0x3d8>
  26ea0f:	ud2
  26ea11:	mov    0x70(%rsp),%r14
  26ea16:	mov    %rax,0x18(%rsp)
  26ea1b:	lea    0x390e86(%rip),%rdx        # 5ff8a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16860>
  26ea22:	jmp    26e908 <<glass::engine::Engine>::apply+0x2428>
  26ea27:	mov    %rax,%r15
  26ea2a:	cmpq   $0x0,0x28(%rsp)
  26ea30:	je     26ea9a <<glass::engine::Engine>::apply+0x25ba>
  26ea32:	mov    %r13,%rdi
  26ea35:	call   *0x3ba02d(%rip)        # 628a68 <_DYNAMIC+0x248>
  26ea3b:	jmp    26ea9a <<glass::engine::Engine>::apply+0x25ba>
  26ea3d:	mov    %rax,%r15
  26ea40:	lock decq (%r12)
  26ea45:	je     26ea57 <<glass::engine::Engine>::apply+0x2577>
  26ea47:	jmp    26ea9a <<glass::engine::Engine>::apply+0x25ba>
  26ea49:	mov    %rax,%r15
  26ea4c:	mov    0x8(%rsp),%rax
  26ea51:	lock decq (%rax)
  26ea55:	jne    26ea9a <<glass::engine::Engine>::apply+0x25ba>
  26ea57:	lea    0xb0(%rsp),%rdi
  26ea5f:	call   *0x3ba023(%rip)        # 628a88 <_DYNAMIC+0x268>
  26ea65:	jmp    26ea9a <<glass::engine::Engine>::apply+0x25ba>
  26ea67:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea69:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea6b:	mov    %rax,%r15
  26ea6e:	test   %r14,%r14
  26ea71:	setne  %al
  26ea74:	cmpq   $0x0,0x28(%rsp)
  26ea7a:	sete   %cl
  26ea7d:	or     %al,%cl
  26ea7f:	jne    26eb06 <<glass::engine::Engine>::apply+0x2626>
  26ea85:	jmp    26eac3 <<glass::engine::Engine>::apply+0x25e3>
  26ea87:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea89:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea8b:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea8d:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea8f:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea91:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea93:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea95:	jmp    26ea97 <<glass::engine::Engine>::apply+0x25b7>
  26ea97:	mov    %rax,%r15
  26ea9a:	cmpq   $0x0,0x140(%rsp)
  26eaa3:	jne    26ead4 <<glass::engine::Engine>::apply+0x25f4>
  26eaa5:	cmpq   $0x0,0x158(%rsp)
  26eaae:	jne    26eaed <<glass::engine::Engine>::apply+0x260d>
  26eab0:	cmpq   $0x0,0x170(%rsp)
  26eab9:	jle    26eb06 <<glass::engine::Engine>::apply+0x2626>
  26eabb:	mov    0x178(%rsp),%r13
  26eac3:	mov    %r13,%rdi
  26eac6:	call   *0x3b9f9c(%rip)        # 628a68 <_DYNAMIC+0x248>
  26eacc:	mov    %r15,%rdi
  26eacf:	call   5e58f0 <_Unwind_Resume@plt>
  26ead4:	mov    0x148(%rsp),%rdi
  26eadc:	call   *0x3b9f86(%rip)        # 628a68 <_DYNAMIC+0x248>
  26eae2:	cmpq   $0x0,0x158(%rsp)
  26eaeb:	je     26eab0 <<glass::engine::Engine>::apply+0x25d0>
  26eaed:	mov    0x160(%rsp),%rdi
  26eaf5:	call   *0x3b9f6d(%rip)        # 628a68 <_DYNAMIC+0x248>
  26eafb:	cmpq   $0x0,0x170(%rsp)
  26eb04:	jg     26eabb <<glass::engine::Engine>::apply+0x25db>
  26eb06:	mov    %r15,%rdi
  26eb09:	call   5e58f0 <_Unwind_Resume@plt>
