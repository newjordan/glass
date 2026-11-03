
/tmp/glass-i31-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002585c0 <<glass::engine::Engine>::apply>:
  2585c0:	push   %rbp
  2585c1:	push   %r15
  2585c3:	push   %r14
  2585c5:	push   %r13
  2585c7:	push   %r12
  2585c9:	push   %rbx
  2585ca:	sub    $0x248,%rsp
  2585d1:	mov    %rdi,%rbx
  2585d4:	testb  $0x10,0x6d5(%rdi)
  2585db:	jne    25863d <<glass::engine::Engine>::apply+0x7d>
  2585dd:	cmpb   $0x2,0x278(%rbx)
  2585e4:	jne    25863d <<glass::engine::Engine>::apply+0x7d>
  2585e6:	mov    0xb0(%rbx),%rax
  2585ed:	dec    %rax
  2585f0:	movq   $0x0,0x250(%rbx)
  2585fb:	movl   $0x0,0x258(%rbx)
  258605:	movb   $0x0,0x260(%rbx)
  25860c:	mov    %rax,0x268(%rbx)
  258613:	movl   $0x0,0x270(%rbx)
  25861d:	movb   $0x1,0x278(%rbx)
  258624:	movb   $0x0,0x280(%rbx)
  25862b:	movq   $0x0,0xa60(%rbx)
  258636:	movb   $0x1,0xa7d(%rbx)
  25863d:	test   %rdx,%rdx
  258640:	je     25a918 <<glass::engine::Engine>::apply+0x2358>
  258646:	lea    0x10(%rbx),%rax
  25864a:	mov    %rax,0x238(%rsp)
  258652:	lea    0x6f0(%rbx),%rax
  258659:	mov    %rax,0x78(%rsp)
  25865e:	lea    0x8e8(%rbx),%rax
  258665:	mov    %rax,0x228(%rsp)
  25866d:	lea    0xa7e(%rbx),%rax
  258674:	mov    %rax,0x60(%rsp)
  258679:	lea    0x720(%rbx),%rax
  258680:	mov    %rax,0xf0(%rsp)
  258688:	lea    0x9a0(%rbx),%rax
  25868f:	mov    %rax,0xe0(%rsp)
  258697:	mov    %rbx,0x38(%rsp)
  25869c:	jmp    2586bb <<glass::engine::Engine>::apply+0xfb>
  25869e:	xchg   %ax,%ax
  2586a0:	mov    0x110(%rsp),%rsi
  2586a8:	mov    0x240(%rsp),%rdx
  2586b0:	sub    0x18(%rsp),%rdx
  2586b5:	je     25a918 <<glass::engine::Engine>::apply+0x2358>
  2586bb:	mov    %rsi,0x28(%rsp)
  2586c0:	cmp    $0x2000,%rdx
  2586c7:	mov    $0x2000,%eax
  2586cc:	mov    %rdx,0x240(%rsp)
  2586d4:	cmovb  %rdx,%rax
  2586d8:	mov    %rax,0x18(%rsp)
  2586dd:	mov    0x6d4(%rbx),%ebp
  2586e3:	mov    $0x1000,%eax
  2586e8:	and    %eax,%ebp
  2586ea:	mov    0xa58(%rbx),%r9
  2586f1:	mov    $0x0,%r10d
  2586f7:	cmove  %r9,%r10
  2586fb:	mov    0xa68(%rbx),%rax
  258702:	mov    %rax,%r11
  258705:	cmove  %r9,%r11
  258709:	mov    0x910(%rbx),%r13
  258710:	mov    $0x8,%r12d
  258716:	test   %r13,%r13
  258719:	je     25877c <<glass::engine::Engine>::apply+0x1bc>
  25871b:	mov    %r11,0x58(%rsp)
  258720:	mov    %r10,0x10(%rsp)
  258725:	mov    %r9,0x8(%rsp)
  25872a:	mov    0x908(%rbx),%r15
  258731:	lea    0x0(,%r13,8),%rax
  258739:	lea    (%rax,%rax,2),%r14
  25873d:	mov    $0x8,%esi
  258742:	mov    %r14,%rdi
  258745:	call   *0x39a87d(%rip)        # 5f2fc8 <_DYNAMIC+0x228>
  25874b:	test   %rax,%rax
  25874e:	je     25aa15 <<glass::engine::Engine>::apply+0x2455>
  258754:	mov    %rax,%r12
  258757:	mov    %rax,%rdi
  25875a:	mov    %r15,%rsi
  25875d:	mov    %r14,%rdx
  258760:	call   *0x39a86a(%rip)        # 5f2fd0 <memcpy@GLIBC_2.14>
  258766:	mov    0xa68(%rbx),%rax
  25876d:	mov    0x8(%rsp),%r9
  258772:	mov    0x10(%rsp),%r10
  258777:	mov    0x58(%rsp),%r11
  25877c:	mov    0x18(%rsp),%r15
  258781:	mov    0x28(%rsp),%r14
  258786:	lea    (%r14,%r15,1),%rcx
  25878a:	mov    %rcx,0x110(%rsp)
  258792:	mov    0xa78(%rbx),%ecx
  258798:	mov    0xa60(%rbx),%rdx
  25879f:	movzbl 0xa7d(%rbx),%esi
  2587a6:	movzbl 0xa81(%rbx),%edi
  2587ad:	mov    0x238(%rsp),%r8
  2587b5:	mov    %r8,0x1a8(%rsp)
  2587bd:	movq   $0x0,0x140(%rsp)
  2587c9:	movq   $0x8,0x148(%rsp)
  2587d5:	movq   $0x0,0x150(%rsp)
  2587e1:	mov    %r13,0x158(%rsp)
  2587e9:	mov    %r12,0x160(%rsp)
  2587f1:	mov    %r13,0x168(%rsp)
  2587f9:	mov    %r11,0x1b0(%rsp)
  258801:	mov    %r10,0x1b8(%rsp)
  258809:	shr    $0xc,%ebp
  25880c:	mov    %bpl,0x1ec(%rsp)
  258814:	mov    %rax,0x1c0(%rsp)
  25881c:	mov    %ecx,0x1e8(%rsp)
  258823:	mov    %rdx,0x1c8(%rsp)
  25882b:	mov    %sil,0x1ed(%rsp)
  258833:	mov    %r15,0x1d0(%rsp)
  25883b:	movups (%rbx),%xmm0
  25883e:	movaps %xmm0,0x130(%rsp)
  258846:	movq   $0xffffffffffffffff,0x170(%rsp)
  258852:	mov    %r9,0x1d8(%rsp)
  25885a:	mov    %dil,0x1ee(%rsp)
  258862:	mov    0xa70(%rbx),%rax
  258869:	mov    %rax,0x1e0(%rsp)
  258871:	test   %dil,%dil
  258874:	mov    %rbx,%r12
  258877:	je     25a390 <<glass::engine::Engine>::apply+0x1dd0>
  25887d:	mov    $0x3,%eax
  258882:	sub    %r15,%rax
  258885:	mov    %rax,0x230(%rsp)
  25888d:	mov    $0x1,%al
  25888f:	mov    %eax,0xdc(%rsp)
  258896:	xor    %ebp,%ebp
  258898:	mov    %r14,0x1f8(%rsp)
  2588a0:	mov    $0x1,%al
  2588a2:	mov    %eax,0x104(%rsp)
  2588a9:	movq   $0x0,0x8(%rsp)
  2588b2:	movl   $0x0,0xd0(%rsp)
  2588bd:	movq   $0x0,0x58(%rsp)
  2588c6:	xor    %r13d,%r13d
  2588c9:	testb  $0x1,0xdc(%rsp)
  2588d1:	je     258930 <<glass::engine::Engine>::apply+0x370>
  2588d3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2588e0:	mov    0x39af79(%rip),%rax        # 5f3860 <_DYNAMIC+0xac0>
  2588e7:	mov    (%rax),%rax
  2588ea:	mov    $0x1b,%edi
  2588ef:	mov    0x1f8(%rsp),%rsi
  2588f7:	mov    0x110(%rsp),%rdx
  2588ff:	call   *%rax
  258901:	cmp    $0x1,%rax
  258905:	jne    258930 <<glass::engine::Engine>::apply+0x370>
  258907:	mov    %rdx,%rax
  25890a:	sub    0x28(%rsp),%rax
  25890f:	inc    %rdx
  258912:	mov    $0x1,%cl
  258914:	mov    %ecx,0xdc(%rsp)
  25891b:	mov    %rdx,0x1f8(%rsp)
  258923:	jmp    258959 <<glass::engine::Engine>::apply+0x399>
  258925:	data16 cs nopw 0x0(%rax,%rax,1)
  258930:	testb  $0x1,0x104(%rsp)
  258938:	je     25a400 <<glass::engine::Engine>::apply+0x1e40>
  25893e:	movl   $0x0,0x104(%rsp)
  258949:	mov    0x18(%rsp),%rax
  25894e:	movl   $0x0,0xdc(%rsp)
  258959:	mov    %rax,%rdx
  25895c:	sub    %r13,%rax
  25895f:	cmp    $0x18,%rax
  258963:	mov    %rdx,0x10(%rsp)
  258968:	jb     258fb0 <<glass::engine::Engine>::apply+0x9f0>
  25896e:	cmp    %rdx,0x18(%rsp)
  258973:	jae    2589b8 <<glass::engine::Engine>::apply+0x3f8>
  258975:	jmp    25a979 <<glass::engine::Engine>::apply+0x23b9>
  25897a:	mov    0x58(%rsp),%rax
  25897f:	mov    %eax,%ebp
  258981:	mov    0x38(%rsp),%rax
  258986:	cmpl   $0xffffffff,0x710(%rax)
  25898d:	je     258d16 <<glass::engine::Engine>::apply+0x756>
  258993:	mov    %ebp,%eax
  258995:	mov    %rax,0x58(%rsp)
  25899a:	nopw   0x0(%rax,%rax,1)
  2589a0:	mov    0x10(%rsp),%rdx
  2589a5:	mov    %rdx,%rax
  2589a8:	sub    %r13,%rax
  2589ab:	mov    %r13,%rbp
  2589ae:	cmp    $0x17,%rax
  2589b2:	jbe    258fb3 <<glass::engine::Engine>::apply+0x9f3>
  2589b8:	lea    0xb0(%rsp),%rdi
  2589c0:	mov    0x28(%rsp),%rsi
  2589c5:	mov    %r13,%rcx
  2589c8:	call   2a21c0 <glass::engine::next_run>
  2589cd:	movzbl 0xc0(%rsp),%r12d
  2589d6:	cmp    $0x2,%r12b
  2589da:	je     259040 <<glass::engine::Engine>::apply+0xa80>
  2589e0:	mov    0xb0(%rsp),%rbx
  2589e8:	cmp    %rbp,%rbx
  2589eb:	jb     25a936 <<glass::engine::Engine>::apply+0x2376>
  2589f1:	mov    0x18(%rsp),%r15
  2589f6:	cmp    %r15,%rbx
  2589f9:	ja     25a947 <<glass::engine::Engine>::apply+0x2387>
  2589ff:	mov    0xb8(%rsp),%r13
  258a07:	mov    0x28(%rsp),%rax
  258a0c:	lea    (%rax,%rbp,1),%r15
  258a10:	lea    (%rax,%rbx,1),%r14
  258a14:	mov    0x39ae3d(%rip),%rax        # 5f3858 <_DYNAMIC+0xab8>
  258a1b:	mov    (%rax),%rax
  258a1e:	mov    $0x1b,%edi
  258a23:	mov    %r15,%rsi
  258a26:	mov    %r14,%rdx
  258a29:	call   *%rax
  258a2b:	cmp    $0x1,%rax
  258a2f:	jne    258a4d <<glass::engine::Engine>::apply+0x48d>
  258a31:	sub    %r15,%rdx
  258a34:	mov    0x38(%rsp),%rax
  258a39:	movb   $0x1,0xa80(%rax)
  258a40:	movb   $0x0,0xa7e(%rax)
  258a47:	add    %rdx,%rbp
  258a4a:	inc    %rbp
  258a4d:	cmp    %rbx,%rbp
  258a50:	jae    258a8e <<glass::engine::Engine>::apply+0x4ce>
  258a52:	mov    0x60(%rsp),%rdi
  258a57:	mov    0x28(%rsp),%rsi
  258a5c:	mov    0x18(%rsp),%rdx
  258a61:	mov    %rbp,%rcx
  258a64:	mov    %rbx,%r8
  258a67:	call   270770 <<glass::engine::Mirror>::stretch>
  258a6c:	cmp    %rbx,%rax
  258a6f:	jae    258a8e <<glass::engine::Engine>::apply+0x4ce>
  258a71:	mov    0x38(%rsp),%rax
  258a76:	cmpb   $0x0,0xa80(%rax)
  258a7d:	jne    258a8e <<glass::engine::Engine>::apply+0x4ce>
  258a7f:	movzbl -0x1(%r14),%eax
  258a84:	shr    $0x7,%al
  258a87:	mov    0x60(%rsp),%rcx
  258a8c:	mov    %al,(%rcx)
  258a8e:	mov    0x60(%rsp),%rdi
  258a93:	mov    0x28(%rsp),%rsi
  258a98:	mov    0x18(%rsp),%rdx
  258a9d:	mov    %rbx,%rcx
  258aa0:	mov    %r13,%r8
  258aa3:	call   270770 <<glass::engine::Mirror>::stretch>
  258aa8:	mov    %rax,%rbx
  258aab:	mov    0x38(%rsp),%rax
  258ab0:	cmpb   $0x0,0xa80(%rax)
  258ab7:	jne    2589a0 <<glass::engine::Engine>::apply+0x3e0>
  258abd:	lea    -0x1(%r13),%r14
  258ac1:	cmp    0x18(%rsp),%r14
  258ac6:	jae    25a9c4 <<glass::engine::Engine>::apply+0x2404>
  258acc:	mov    0x28(%rsp),%rax
  258ad1:	movzbl (%rax,%r14,1),%eax
  258ad6:	shr    $0x7,%al
  258ad9:	mov    0x60(%rsp),%rcx
  258ade:	mov    %al,(%rcx)
  258ae0:	test   %rbx,%rbx
  258ae3:	je     258b12 <<glass::engine::Engine>::apply+0x552>
  258ae5:	lea    -0x1(%rbx),%r14
  258ae9:	cmp    0x18(%rsp),%r14
  258aee:	jae    25a9e1 <<glass::engine::Engine>::apply+0x2421>
  258af4:	mov    0x28(%rsp),%rax
  258af9:	movzbl (%rax,%r14,1),%eax
  258afe:	shr    $0x7,%al
  258b01:	mov    %r13,%r14
  258b04:	sub    %rbx,%r14
  258b07:	cmp    $0x18,%r14
  258b0b:	jae    258b2e <<glass::engine::Engine>::apply+0x56e>
  258b0d:	jmp    2589a0 <<glass::engine::Engine>::apply+0x3e0>
  258b12:	mov    0x38(%rsp),%rax
  258b17:	movzbl 0xa7f(%rax),%eax
  258b1e:	mov    %r13,%r14
  258b21:	sub    %rbx,%r14
  258b24:	cmp    $0x18,%r14
  258b28:	jb     2589a0 <<glass::engine::Engine>::apply+0x3e0>
  258b2e:	test   %al,%al
  258b30:	jne    2589a0 <<glass::engine::Engine>::apply+0x3e0>
  258b36:	mov    %rbx,%r15
  258b39:	sub    0x8(%rsp),%r15
  258b3e:	jbe    25897a <<glass::engine::Engine>::apply+0x3ba>
  258b44:	movzbl 0x3a072d(%rip),%eax        # 5f9278 <glass::engine::probes::RUN_PROBE>
  258b4b:	mov    $0x1,%bpl
  258b4e:	cmp    $0x68,%al
  258b50:	je     258cff <<glass::engine::Engine>::apply+0x73f>
  258b56:	cmp    0x18(%rsp),%rbx
  258b5b:	ja     25a98c <<glass::engine::Engine>::apply+0x23cc>
  258b61:	mov    0x8(%rsp),%rax
  258b66:	add    0x28(%rsp),%rax
  258b6b:	mov    %rax,0x8(%rsp)
  258b70:	cmpb   $0x1,0x58(%rsp)
  258b75:	jne    258ba2 <<glass::engine::Engine>::apply+0x5e2>
  258b77:	mov    0x38(%rsp),%rax
  258b7c:	cmpl   $0xffffffff,0x710(%rax)
  258b83:	jne    258ba2 <<glass::engine::Engine>::apply+0x5e2>
  258b85:	lea    0x130(%rsp),%rdi
  258b8d:	mov    0x8(%rsp),%rsi
  258b92:	mov    %r15,%rdx
  258b95:	call   2a24b0 <glass::engine::plain_c0>
  258b9a:	test   %al,%al
  258b9c:	jne    258cff <<glass::engine::Engine>::apply+0x73f>
  258ba2:	movzbl 0x3a06df(%rip),%eax        # 5f9288 <glass::engine::timers::ON>
  258ba9:	test   %al,%al
  258bab:	je     258ddf <<glass::engine::Engine>::apply+0x81f>
  258bb1:	mov    $0x1,%edi
  258bb6:	call   50ffd0 <<std::sys::pal::unix::time::Timespec>::now>
  258bbb:	mov    %rax,0x58(%rsp)
  258bc0:	mov    %edx,0x30(%rsp)
  258bc4:	xor    %ebp,%ebp
  258bc6:	cs nopw 0x0(%rax,%rax,1)
  258bd0:	mov    0x38(%rsp),%rax
  258bd5:	cmpl   $0xffffffff,0x710(%rax)
  258bdc:	jne    258c37 <<glass::engine::Engine>::apply+0x677>
  258bde:	mov    0x78(%rsp),%rax
  258be3:	mov    %rax,0x80(%rsp)
  258beb:	lea    0x130(%rsp),%rax
  258bf3:	mov    %rax,0x88(%rsp)
  258bfb:	movb   $0x0,0x90(%rsp)
  258c03:	mov    %r15,%rcx
  258c06:	sub    %rbp,%rcx
  258c09:	jb     25a92a <<glass::engine::Engine>::apply+0x236a>
  258c0f:	mov    0x8(%rsp),%rax
  258c14:	lea    (%rax,%rbp,1),%rdx
  258c18:	mov    0xf0(%rsp),%rdi
  258c20:	lea    0x80(%rsp),%rsi
  258c28:	call   1a08f0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258c2d:	add    %rax,%rbp
  258c30:	cmp    %r15,%rbp
  258c33:	jne    258bd0 <<glass::engine::Engine>::apply+0x610>
  258c35:	jmp    258c60 <<glass::engine::Engine>::apply+0x6a0>
  258c37:	mov    %r15,%rcx
  258c3a:	sub    %rbp,%rcx
  258c3d:	jb     25aa36 <<glass::engine::Engine>::apply+0x2476>
  258c43:	mov    0x8(%rsp),%rax
  258c48:	lea    (%rax,%rbp,1),%rdx
  258c4c:	mov    0x78(%rsp),%rdi
  258c51:	lea    0x130(%rsp),%rsi
  258c59:	call   194650 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258c5e:	jmp    258c2d <<glass::engine::Engine>::apply+0x66d>
  258c60:	movzbl 0x3a0621(%rip),%eax        # 5f9288 <glass::engine::timers::ON>
  258c67:	test   %al,%al
  258c69:	mov    $0x1,%bpl
  258c6c:	je     258cff <<glass::engine::Engine>::apply+0x73f>
  258c72:	mov    $0x1,%edi
  258c77:	call   50ffd0 <<std::sys::pal::unix::time::Timespec>::now>
  258c7c:	mov    %rax,0x200(%rsp)
  258c84:	mov    %edx,0x208(%rsp)
  258c8b:	mov    0x58(%rsp),%rax
  258c90:	mov    %rax,0x210(%rsp)
  258c98:	mov    0x30(%rsp),%eax
  258c9c:	mov    %eax,0x218(%rsp)
  258ca3:	lea    0x80(%rsp),%rdi
  258cab:	lea    0x200(%rsp),%rsi
  258cb3:	lea    0x210(%rsp),%rdx
  258cbb:	call   50ff10 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258cc0:	imul   $0x3b9aca00,0x88(%rsp),%rax
  258ccc:	mov    0x90(%rsp),%ecx
  258cd3:	add    %rcx,%rax
  258cd6:	cmpb   $0x0,0x80(%rsp)
  258cde:	mov    $0x0,%ecx
  258ce3:	cmove  %rax,%rcx
  258ce7:	lock add %rcx,0x3a05a9(%rip)        # 5f9298 <glass::engine::timers::VTE_NS>
  258cef:	lock incq 0x3a05d1(%rip)        # 5f92c8 <glass::engine::timers::VTE_CALLS>
  258cf7:	lock add %r15,0x3a05c1(%rip)        # 5f92c0 <glass::engine::timers::VTE_BYTES>
  258cff:	mov    %rbx,0x8(%rsp)
  258d04:	mov    0x38(%rsp),%rax
  258d09:	cmpl   $0xffffffff,0x710(%rax)
  258d10:	jne    258993 <<glass::engine::Engine>::apply+0x3d3>
  258d16:	cmp    0x18(%rsp),%r13
  258d1b:	ja     25a965 <<glass::engine::Engine>::apply+0x23a5>
  258d21:	cmp    %rbx,%r13
  258d24:	jb     25a965 <<glass::engine::Engine>::apply+0x23a5>
  258d2a:	movzbl 0x3a0546(%rip),%r15d        # 5f9278 <glass::engine::probes::RUN_PROBE>
  258d32:	movzbl 0x3a054f(%rip),%eax        # 5f9288 <glass::engine::timers::ON>
  258d39:	test   %al,%al
  258d3b:	je     258d6c <<glass::engine::Engine>::apply+0x7ac>
  258d3d:	mov    $0x1,%edi
  258d42:	call   50ffd0 <<std::sys::pal::unix::time::Timespec>::now>
  258d47:	mov    %rax,0x58(%rsp)
  258d4c:	mov    %edx,%ebp
  258d4e:	cmp    $0x63,%r15b
  258d52:	jbe    258d77 <<glass::engine::Engine>::apply+0x7b7>
  258d54:	movzbl %r12b,%eax
  258d58:	mov    %r14,%rbx
  258d5b:	sub    %rax,%rbx
  258d5e:	cmp    $0xffffffff,%ebp
  258d61:	jne    258eea <<glass::engine::Engine>::apply+0x92a>
  258d67:	jmp    258f82 <<glass::engine::Engine>::apply+0x9c2>
  258d6c:	mov    $0xffffffff,%ebp
  258d71:	cmp    $0x63,%r15b
  258d75:	ja     258d54 <<glass::engine::Engine>::apply+0x794>
  258d77:	mov    0x39d203(%rip),%eax        # 5f5f80 <glass::engine::run_whole::ON>
  258d7d:	test   %eax,%eax
  258d7f:	jne    258fa1 <<glass::engine::Engine>::apply+0x9e1>
  258d85:	mov    0x28(%rsp),%rax
  258d8a:	lea    (%rax,%rbx,1),%rsi
  258d8e:	cmpb   $0x0,0x39d1ef(%rip)        # 5f5f84 <glass::engine::run_whole::ON+0x4>
  258d95:	je     258db6 <<glass::engine::Engine>::apply+0x7f6>
  258d97:	test   $0x1,%r12b
  258d9b:	je     258e9f <<glass::engine::Engine>::apply+0x8df>
  258da1:	lea    0x130(%rsp),%rdi
  258da9:	mov    %r14,%rdx
  258dac:	call   265530 <<glass::engine::Watch>::print_run>
  258db1:	jmp    258eaf <<glass::engine::Engine>::apply+0x8ef>
  258db6:	test   $0x1,%r12b
  258dba:	je     258ece <<glass::engine::Engine>::apply+0x90e>
  258dc0:	cmp    %rbx,%r13
  258dc3:	je     25a9a2 <<glass::engine::Engine>::apply+0x23e2>
  258dc9:	lea    -0x1(%r14),%rdx
  258dcd:	lea    0x130(%rsp),%rdi
  258dd5:	call   265530 <<glass::engine::Watch>::print_run>
  258dda:	jmp    258ede <<glass::engine::Engine>::apply+0x91e>
  258ddf:	xor    %ebp,%ebp
  258de1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258df0:	mov    0x38(%rsp),%rax
  258df5:	cmpl   $0xffffffff,0x710(%rax)
  258dfc:	jne    258e57 <<glass::engine::Engine>::apply+0x897>
  258dfe:	mov    0x78(%rsp),%rax
  258e03:	mov    %rax,0x80(%rsp)
  258e0b:	lea    0x130(%rsp),%rax
  258e13:	mov    %rax,0x88(%rsp)
  258e1b:	movb   $0x0,0x90(%rsp)
  258e23:	mov    %r15,%rcx
  258e26:	sub    %rbp,%rcx
  258e29:	jb     25a92a <<glass::engine::Engine>::apply+0x236a>
  258e2f:	mov    0x8(%rsp),%rax
  258e34:	lea    (%rax,%rbp,1),%rdx
  258e38:	mov    0xf0(%rsp),%rdi
  258e40:	lea    0x80(%rsp),%rsi
  258e48:	call   1a08f0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258e4d:	add    %rax,%rbp
  258e50:	cmp    %r15,%rbp
  258e53:	jne    258df0 <<glass::engine::Engine>::apply+0x830>
  258e55:	jmp    258e80 <<glass::engine::Engine>::apply+0x8c0>
  258e57:	mov    %r15,%rcx
  258e5a:	sub    %rbp,%rcx
  258e5d:	jb     25aa36 <<glass::engine::Engine>::apply+0x2476>
  258e63:	mov    0x8(%rsp),%rax
  258e68:	lea    (%rax,%rbp,1),%rdx
  258e6c:	mov    0x78(%rsp),%rdi
  258e71:	lea    0x130(%rsp),%rsi
  258e79:	call   194650 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258e7e:	jmp    258e4d <<glass::engine::Engine>::apply+0x88d>
  258e80:	mov    %rbx,0x8(%rsp)
  258e85:	mov    $0x1,%bpl
  258e88:	mov    0x38(%rsp),%rax
  258e8d:	cmpl   $0xffffffff,0x710(%rax)
  258e94:	jne    258993 <<glass::engine::Engine>::apply+0x3d3>
  258e9a:	jmp    258d16 <<glass::engine::Engine>::apply+0x756>
  258e9f:	lea    0x130(%rsp),%rdi
  258ea7:	mov    %r14,%rdx
  258eaa:	call   262620 <<glass::engine::Watch>::print_utf8>
  258eaf:	mov    %rax,%rbx
  258eb2:	mov    0x1e0(%rsp),%eax
  258eb9:	mov    0x38(%rsp),%rcx
  258ebe:	mov    %eax,0x718(%rcx)
  258ec4:	cmp    $0xffffffff,%ebp
  258ec7:	jne    258eea <<glass::engine::Engine>::apply+0x92a>
  258ec9:	jmp    258f82 <<glass::engine::Engine>::apply+0x9c2>
  258ece:	lea    0x130(%rsp),%rdi
  258ed6:	mov    %r14,%rdx
  258ed9:	call   262620 <<glass::engine::Watch>::print_utf8>
  258ede:	mov    %rax,%rbx
  258ee1:	cmp    $0xffffffff,%ebp
  258ee4:	je     258f82 <<glass::engine::Engine>::apply+0x9c2>
  258eea:	movzbl 0x3a0397(%rip),%eax        # 5f9288 <glass::engine::timers::ON>
  258ef1:	test   %al,%al
  258ef3:	je     258f7a <<glass::engine::Engine>::apply+0x9ba>
  258ef9:	mov    $0x1,%edi
  258efe:	call   50ffd0 <<std::sys::pal::unix::time::Timespec>::now>
  258f03:	mov    %rax,0x200(%rsp)
  258f0b:	mov    %edx,0x208(%rsp)
  258f12:	mov    0x58(%rsp),%rax
  258f17:	mov    %rax,0x210(%rsp)
  258f1f:	mov    %ebp,0x218(%rsp)
  258f26:	lea    0x80(%rsp),%rdi
  258f2e:	lea    0x200(%rsp),%rsi
  258f36:	lea    0x210(%rsp),%rdx
  258f3e:	call   50ff10 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258f43:	imul   $0x3b9aca00,0x88(%rsp),%rax
  258f4f:	mov    0x90(%rsp),%ecx
  258f56:	add    %rcx,%rax
  258f59:	cmpb   $0x0,0x80(%rsp)
  258f61:	mov    $0x0,%ecx
  258f66:	cmove  %rax,%rcx
  258f6a:	lock add %rcx,0x3a031e(%rip)        # 5f9290 <glass::engine::timers::RUN_NS>
  258f72:	lock incq 0x3a033e(%rip)        # 5f92b8 <glass::engine::timers::RUN_CALLS>
  258f7a:	lock add %r14,0x3a032e(%rip)        # 5f92b0 <glass::engine::timers::RUN_BYTES>
  258f82:	movzbl 0x3a034f(%rip),%eax        # 5f92d8 <glass::engine::counters::COUNTING>
  258f89:	test   %al,%al
  258f8b:	je     258f95 <<glass::engine::Engine>::apply+0x9d5>
  258f8d:	lock add %rbx,0x3a033b(%rip)        # 5f92d0 <glass::engine::counters::LANE_RUN_BYTES>
  258f95:	add    %rbx,0x8(%rsp)
  258f9a:	mov    $0x1,%al
  258f9c:	jmp    258995 <<glass::engine::Engine>::apply+0x3d5>
  258fa1:	call   18bc86 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  258fa6:	jmp    258d85 <<glass::engine::Engine>::apply+0x7c5>
  258fab:	nopl   0x0(%rax,%rax,1)
  258fb0:	mov    %rbp,%r13
  258fb3:	mov    $0x1,%ebx
  258fb8:	mov    0x18(%rsp),%rax
  258fbd:	sub    %rdx,%rax
  258fc0:	jbe    25905b <<glass::engine::Engine>::apply+0xa9b>
  258fc6:	mov    0x8(%rsp),%rcx
  258fcb:	cmp    %rcx,0xe8(%rsp)
  258fd3:	sete   %r9b
  258fd7:	cmp    $0x2,%rax
  258fdb:	mov    0x38(%rsp),%r12
  258fe0:	jb     259030 <<glass::engine::Engine>::apply+0xa70>
  258fe2:	mov    0x28(%rsp),%rcx
  258fe7:	mov    0x10(%rsp),%rdx
  258fec:	lea    (%rcx,%rdx,1),%rbp
  258ff0:	cmpb   $0x5b,0x1(%rbp)
  258ff4:	jne    259030 <<glass::engine::Engine>::apply+0xa70>
  258ff6:	xorps  %xmm0,%xmm0
  258ff9:	movaps %xmm0,0x90(%rsp)
  259001:	movaps %xmm0,0x80(%rsp)
  259009:	cmp    $0x2,%rax
  25900d:	je     259030 <<glass::engine::Engine>::apply+0xa70>
  25900f:	movzbl 0x2(%rbp),%ecx
  259013:	lea    -0x30(%rcx),%eax
  259016:	cmp    $0xa,%al
  259018:	jae    259081 <<glass::engine::Engine>::apply+0xac1>
  25901a:	movzbl %al,%eax
  25901d:	xor    %r14d,%r14d
  259020:	mov    0x10(%rsp),%rcx
  259025:	add    $0x3,%rcx
  259029:	cmp    0x18(%rsp),%rcx
  25902e:	jne    2590a7 <<glass::engine::Engine>::apply+0xae7>
  259030:	movl   $0x0,0xd0(%rsp)
  25903b:	jmp    259060 <<glass::engine::Engine>::apply+0xaa0>
  25903d:	nopl   (%rax)
  259040:	mov    %rbp,%r13
  259043:	mov    0x10(%rsp),%rdx
  259048:	mov    $0x1,%ebx
  25904d:	mov    0x18(%rsp),%rax
  259052:	sub    %rdx,%rax
  259055:	ja     258fc6 <<glass::engine::Engine>::apply+0xa06>
  25905b:	mov    0x38(%rsp),%r12
  259060:	mov    0x10(%rsp),%r8
  259065:	add    %r8,%rbx
  259068:	mov    %r13,%rbp
  25906b:	mov    %rbx,%r13
  25906e:	testb  $0x1,0xdc(%rsp)
  259076:	je     258930 <<glass::engine::Engine>::apply+0x370>
  25907c:	jmp    2588e0 <<glass::engine::Engine>::apply+0x320>
  259081:	movzbl %cl,%edx
  259084:	xor    %eax,%eax
  259086:	lea    -0x48(%rdx),%esi
  259089:	cmp    $0x25,%esi
  25908c:	ja     2590c0 <<glass::engine::Engine>::apply+0xb00>
  25908e:	mov    $0x3,%r8d
  259094:	lea    -0x1ea813(%rip),%rdi        # 6e888 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2cd7>
  25909b:	movslq (%rdi,%rsi,4),%rdx
  25909f:	add    %rdi,%rdx
  2590a2:	xor    %r14d,%r14d
  2590a5:	jmp    *%rdx
  2590a7:	mov    0x10(%rsp),%rcx
  2590ac:	mov    0x230(%rsp),%rdx
  2590b4:	lea    (%rdx,%rcx,1),%rsi
  2590b8:	mov    $0x4,%r8d
  2590be:	jmp    259103 <<glass::engine::Engine>::apply+0xb43>
  2590c0:	mov    $0x1,%r14d
  2590c6:	cmp    $0x3b,%edx
  2590c9:	je     259020 <<glass::engine::Engine>::apply+0xa60>
  2590cf:	jmp    259030 <<glass::engine::Engine>::apply+0xa70>
  2590d4:	mov    $0xffff,%cx
  2590d8:	nopl   0x0(%rax,%rax,1)
  2590e0:	movzbl %dil,%eax
  2590e4:	add    %cx,%ax
  2590e7:	mov    $0xffff,%ecx
  2590ec:	cmovb  %ecx,%eax
  2590ef:	lea    (%rsi,%r8,1),%rcx
  2590f3:	inc    %rcx
  2590f6:	inc    %r8
  2590f9:	cmp    $0x4,%rcx
  2590fd:	je     259030 <<glass::engine::Engine>::apply+0xa70>
  259103:	movzbl -0x1(%rbp,%r8,1),%ecx
  259109:	lea    -0x30(%rcx),%edi
  25910c:	cmp    $0xa,%dil
  259110:	jae    259120 <<glass::engine::Engine>::apply+0xb60>
  259112:	mov    $0xa,%cx
  259116:	mul    %cx
  259119:	jo     2590d4 <<glass::engine::Engine>::apply+0xb14>
  25911b:	mov    %eax,%ecx
  25911d:	jmp    2590e0 <<glass::engine::Engine>::apply+0xb20>
  25911f:	nop
  259120:	movzbl %cl,%edx
  259123:	cmp    $0x3b,%edx
  259126:	jne    259163 <<glass::engine::Engine>::apply+0xba3>
  259128:	lea    0x1(%r14),%rcx
  25912c:	cmp    $0x10,%rcx
  259130:	jae    259030 <<glass::engine::Engine>::apply+0xa70>
  259136:	cmp    $0xf,%r14
  25913a:	ja     25a9fb <<glass::engine::Engine>::apply+0x243b>
  259140:	mov    %ax,0x80(%rsp,%r14,2)
  259149:	xor    %eax,%eax
  25914b:	mov    %rcx,%r14
  25914e:	lea    (%rsi,%r8,1),%rcx
  259152:	inc    %rcx
  259155:	inc    %r8
  259158:	cmp    $0x4,%rcx
  25915c:	jne    259103 <<glass::engine::Engine>::apply+0xb43>
  25915e:	jmp    259030 <<glass::engine::Engine>::apply+0xa70>
  259163:	add    $0xffffffb8,%edx
  259166:	cmp    $0x25,%edx
  259169:	ja     259030 <<glass::engine::Engine>::apply+0xa70>
  25916f:	lea    -0x1ea856(%rip),%rsi        # 6e920 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d6f>
  259176:	movslq (%rsi,%rdx,4),%rdx
  25917a:	add    %rsi,%rdx
  25917d:	jmp    *%rdx
  25917f:	cmp    $0x10,%r14
  259183:	jae    25aa23 <<glass::engine::Engine>::apply+0x2463>
  259189:	mov    %r8,0x120(%rsp)
  259191:	mov    %ax,0x80(%rsp,%r14,2)
  25919a:	cmp    $0x6d,%cl
  25919d:	setne  %cl
  2591a0:	movaps 0x80(%rsp),%xmm0
  2591a8:	movaps 0x90(%rsp),%xmm1
  2591b0:	movaps %xmm0,0xb0(%rsp)
  2591b8:	movaps %xmm1,0xc0(%rsp)
  2591c0:	xor    %edx,%edx
  2591c2:	jmp    259203 <<glass::engine::Engine>::apply+0xc43>
  2591c4:	cmp    $0x10,%r14
  2591c8:	jae    25aa45 <<glass::engine::Engine>::apply+0x2485>
  2591ce:	mov    %r8,0x120(%rsp)
  2591d6:	mov    %ax,0x80(%rsp,%r14,2)
  2591df:	movaps 0x80(%rsp),%xmm0
  2591e7:	movaps 0x90(%rsp),%xmm1
  2591ef:	movaps %xmm0,0xb0(%rsp)
  2591f7:	movaps %xmm1,0xc0(%rsp)
  2591ff:	mov    $0x1,%dl
  259201:	xor    %ecx,%ecx
  259203:	lea    0x1(%r14),%rax
  259207:	movaps 0xb0(%rsp),%xmm0
  25920f:	movaps 0xc0(%rsp),%xmm1
  259217:	movaps %xmm1,0x90(%rsp)
  25921f:	movaps %xmm0,0x80(%rsp)
  259227:	mov    %rax,0xa0(%rsp)
  25922f:	mov    %cl,0xa8(%rsp)
  259236:	mov    %dl,0xa9(%rsp)
  25923d:	mov    0x10(%rsp),%r8
  259242:	cmp    %r13,%r8
  259245:	jb     25a9b7 <<glass::engine::Engine>::apply+0x23f7>
  25924b:	mov    %r9b,0x30(%rsp)
  259250:	mov    %edx,0x12c(%rsp)
  259257:	mov    %ecx,0x128(%rsp)
  25925e:	mov    0x28(%rsp),%rax
  259263:	lea    (%rax,%r13,1),%r15
  259267:	mov    0x39a5ea(%rip),%rax        # 5f3858 <_DYNAMIC+0xab8>
  25926e:	mov    (%rax),%rax
  259271:	mov    $0x1b,%edi
  259276:	mov    %r15,%rsi
  259279:	mov    %rbp,%rdx
  25927c:	call   *%rax
  25927e:	cmp    $0x1,%rax
  259282:	jne    25929f <<glass::engine::Engine>::apply+0xcdf>
  259284:	sub    %r15,%rdx
  259287:	movb   $0x1,0xa80(%r12)
  259290:	movb   $0x0,0xa7e(%r12)
  259299:	add    %rdx,%r13
  25929c:	inc    %r13
  25929f:	mov    0x10(%rsp),%r8
  2592a4:	cmp    %r8,%r13
  2592a7:	jae    2592f9 <<glass::engine::Engine>::apply+0xd39>
  2592a9:	mov    0x60(%rsp),%rdi
  2592ae:	mov    0x28(%rsp),%rsi
  2592b3:	mov    0x18(%rsp),%rdx
  2592b8:	mov    %r13,%rcx
  2592bb:	call   270770 <<glass::engine::Mirror>::stretch>
  2592c0:	movzbl 0xa80(%r12),%ecx
  2592c9:	test   %cl,%cl
  2592cb:	setne  %dl
  2592ce:	mov    0x10(%rsp),%r8
  2592d3:	cmp    %r8,%rax
  2592d6:	setae  %al
  2592d9:	or     %dl,%al
  2592db:	jne    259302 <<glass::engine::Engine>::apply+0xd42>
  2592dd:	movzbl -0x1(%rbp),%eax
  2592e1:	shr    $0x7,%al
  2592e4:	mov    0x60(%rsp),%rcx
  2592e9:	mov    %al,(%rcx)
  2592eb:	mov    0x28(%rsp),%r9
  2592f0:	test   %al,%al
  2592f2:	jne    25931f <<glass::engine::Engine>::apply+0xd5f>
  2592f4:	jmp    2593f0 <<glass::engine::Engine>::apply+0xe30>
  2592f9:	movzbl 0xa80(%r12),%ecx
  259302:	test   %cl,%cl
  259304:	mov    0x28(%rsp),%r9
  259309:	jne    25963c <<glass::engine::Engine>::apply+0x107c>
  25930f:	mov    0x60(%rsp),%rax
  259314:	movzbl (%rax),%eax
  259317:	test   %al,%al
  259319:	je     2593f0 <<glass::engine::Engine>::apply+0xe30>
  25931f:	mov    0x10(%rsp),%r8
  259324:	test   %r8,%r8
  259327:	je     25963c <<glass::engine::Engine>::apply+0x107c>
  25932d:	cmpb   $0xc0,-0x1(%rbp)
  259331:	jge    259373 <<glass::engine::Engine>::apply+0xdb3>
  259333:	cmp    $0x1,%r8
  259337:	je     25963c <<glass::engine::Engine>::apply+0x107c>
  25933d:	cmpb   $0xbf,-0x2(%rbp)
  259341:	jg     25948d <<glass::engine::Engine>::apply+0xecd>
  259347:	cmp    $0x2,%r8
  25934b:	je     25963c <<glass::engine::Engine>::apply+0x107c>
  259351:	cmpb   $0xbf,-0x3(%rbp)
  259355:	jg     259b57 <<glass::engine::Engine>::apply+0x1597>
  25935b:	cmp    $0x3,%r8
  25935f:	je     25963c <<glass::engine::Engine>::apply+0x107c>
  259365:	cmpb   $0xc0,-0x4(%rbp)
  259369:	setl   %al
  25936c:	mov    $0x3,%edx
  259371:	jmp    259377 <<glass::engine::Engine>::apply+0xdb7>
  259373:	xor    %edx,%edx
  259375:	xor    %eax,%eax
  259377:	test   %al,%al
  259379:	jne    2593e6 <<glass::engine::Engine>::apply+0xe26>
  25937b:	mov    %rdx,%rsi
  25937e:	not    %rsi
  259381:	add    0x10(%rsp),%rsi
  259386:	jae    25aa58 <<glass::engine::Engine>::apply+0x2498>
  25938c:	movzbl (%r9,%rsi,1),%eax
  259391:	mov    $0x1,%ecx
  259396:	test   %al,%al
  259398:	jns    2593c4 <<glass::engine::Engine>::apply+0xe04>
  25939a:	lea    0x3e(%rax),%edi
  25939d:	mov    $0x2,%ecx
  2593a2:	cmp    $0x1e,%dil
  2593a6:	jb     2593c4 <<glass::engine::Engine>::apply+0xe04>
  2593a8:	mov    %eax,%edi
  2593aa:	and    $0xf0,%dil
  2593ae:	mov    $0x3,%ecx
  2593b3:	cmp    $0xe0,%dil
  2593b7:	je     2593c4 <<glass::engine::Engine>::apply+0xe04>
  2593b9:	add    $0x10,%al
  2593bb:	mov    $0x4,%ecx
  2593c0:	cmp    $0x4,%al
  2593c2:	ja     2593e6 <<glass::engine::Engine>::apply+0xe26>
  2593c4:	inc    %rdx
  2593c7:	cmp    %ecx,%edx
  2593c9:	jne    2593e6 <<glass::engine::Engine>::apply+0xe26>
  2593cb:	add    %r9,%rsi
  2593ce:	lea    0xb0(%rsp),%rdi
  2593d6:	call   *0x399cb4(%rip)        # 5f3090 <_DYNAMIC+0x2f0>
  2593dc:	cmpb   $0x0,0xb0(%rsp)
  2593e4:	je     2593f0 <<glass::engine::Engine>::apply+0xe30>
  2593e6:	mov    0x10(%rsp),%r8
  2593eb:	jmp    25963c <<glass::engine::Engine>::apply+0x107c>
  2593f0:	mov    0x10(%rsp),%r8
  2593f5:	mov    %r8,%rbp
  2593f8:	sub    0x8(%rsp),%rbp
  2593fd:	jbe    259631 <<glass::engine::Engine>::apply+0x1071>
  259403:	mov    0x39cb77(%rip),%eax        # 5f5f80 <glass::engine::run_whole::ON>
  259409:	test   %eax,%eax
  25940b:	jne    259b61 <<glass::engine::Engine>::apply+0x15a1>
  259411:	mov    0xd0(%rsp),%ecx
  259418:	and    0x30(%rsp),%cl
  25941c:	movzbl 0x39cb61(%rip),%eax        # 5f5f84 <glass::engine::run_whole::ON+0x4>
  259423:	xor    $0x1,%rax
  259427:	cmp    %rax,%rbp
  25942a:	seta   %al
  25942d:	and    %cl,%al
  25942f:	cmp    $0x1,%al
  259431:	jne    259483 <<glass::engine::Engine>::apply+0xec3>
  259433:	mov    0x8(%rsp),%rcx
  259438:	mov    %rcx,%rax
  25943b:	cmp    %rcx,0x10(%rsp)
  259440:	mov    0x28(%rsp),%rdx
  259445:	je     259466 <<glass::engine::Engine>::apply+0xea6>
  259447:	nopw   0x0(%rax,%rax,1)
  259450:	movzbl (%rdx,%rax,1),%ecx
  259454:	add    $0xe0,%cl
  259457:	cmp    $0x5f,%cl
  25945a:	jae    259471 <<glass::engine::Engine>::apply+0xeb1>
  25945c:	inc    %rax
  25945f:	cmp    %rax,0x10(%rsp)
  259464:	jne    259450 <<glass::engine::Engine>::apply+0xe90>
  259466:	cmpl   $0xffffffff,0x710(%r12)
  25946f:	je     259497 <<glass::engine::Engine>::apply+0xed7>
  259471:	mov    0x10(%rsp),%r8
  259476:	mov    0xe8(%rsp),%r13
  25947e:	jmp    259575 <<glass::engine::Engine>::apply+0xfb5>
  259483:	mov    0x8(%rsp),%r13
  259488:	jmp    25956b <<glass::engine::Engine>::apply+0xfab>
  25948d:	mov    $0x1,%edx
  259492:	jmp    259375 <<glass::engine::Engine>::apply+0xdb5>
  259497:	mov    0x39cae3(%rip),%eax        # 5f5f80 <glass::engine::run_whole::ON>
  25949d:	test   %eax,%eax
  25949f:	jne    259b6b <<glass::engine::Engine>::apply+0x15ab>
  2594a5:	mov    0x8(%rsp),%rax
  2594aa:	add    0x28(%rsp),%rax
  2594af:	mov    %rax,0x8(%rsp)
  2594b4:	movzbl 0x39cac9(%rip),%eax        # 5f5f84 <glass::engine::run_whole::ON+0x4>
  2594bb:	xor    $0x1,%rax
  2594bf:	sub    %rax,%rbp
  2594c2:	cmp    $0x1,%rbp
  2594c6:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  2594c8:	cmpb   $0x1,0x1ee(%rsp)
  2594d0:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  2594d2:	cmpq   $0x0,0x168(%rsp)
  2594db:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  2594dd:	mov    0x1a8(%rsp),%r13
  2594e5:	testb  $0x4,0x6c5(%r13)
  2594ed:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  2594ef:	cmpq   $0x0,0x50(%r13)
  2594f4:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  2594f6:	movzwl 0x64(%r13),%eax
  2594fb:	test   $0x460,%eax
  259500:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  259502:	cmpb   $0x0,0x68(%r13)
  259507:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  259509:	cmpb   $0x0,0x69(%r13)
  25950e:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  259510:	cmpb   $0x0,0x6a(%r13)
  259515:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  259517:	cmpb   $0x0,0x6b(%r13)
  25951c:	je     259b75 <<glass::engine::Engine>::apply+0x15b5>
  259522:	lea    0x130(%rsp),%rdi
  25952a:	mov    0x8(%rsp),%rsi
  25952f:	mov    %rbp,%rdx
  259532:	call   265530 <<glass::engine::Watch>::print_run>
  259537:	mov    %rax,%r15
  25953a:	mov    0x39ca40(%rip),%eax        # 5f5f80 <glass::engine::run_whole::ON>
  259540:	test   %eax,%eax
  259542:	jne    25a37d <<glass::engine::Engine>::apply+0x1dbd>
  259548:	cmpb   $0x0,0x39ca35(%rip)        # 5f5f84 <glass::engine::run_whole::ON+0x4>
  25954f:	je     259560 <<glass::engine::Engine>::apply+0xfa0>
  259551:	mov    0x1e0(%rsp),%eax
  259558:	mov    %eax,0x718(%r12)
  259560:	mov    0xe8(%rsp),%r13
  259568:	add    %r15,%r13
  25956b:	mov    0x28(%rsp),%rdx
  259570:	mov    0x10(%rsp),%r8
  259575:	cmp    %r13,%r8
  259578:	jb     25a9cd <<glass::engine::Engine>::apply+0x240d>
  25957e:	mov    %r8,%r15
  259581:	mov    %r8,0x8(%rsp)
  259586:	sub    %r13,%r15
  259589:	je     259631 <<glass::engine::Engine>::apply+0x1071>
  25958f:	add    %rdx,%r13
  259592:	xor    %ebp,%ebp
  259594:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  2595a0:	cmpl   $0xffffffff,0x710(%r12)
  2595a9:	jne    259606 <<glass::engine::Engine>::apply+0x1046>
  2595ab:	mov    0x78(%rsp),%rax
  2595b0:	mov    %rax,0xb0(%rsp)
  2595b8:	lea    0x130(%rsp),%rax
  2595c0:	mov    %rax,0xb8(%rsp)
  2595c8:	movb   $0x0,0xc0(%rsp)
  2595d0:	mov    %r15,%rcx
  2595d3:	sub    %rbp,%rcx
  2595d6:	jb     25a92a <<glass::engine::Engine>::apply+0x236a>
  2595dc:	mov    %r13,%rdx
  2595df:	add    %rbp,%rdx
  2595e2:	mov    0xf0(%rsp),%rdi
  2595ea:	lea    0xb0(%rsp),%rsi
  2595f2:	call   1a08f0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  2595f7:	add    %rax,%rbp
  2595fa:	cmp    %r15,%rbp
  2595fd:	mov    0x10(%rsp),%r8
  259602:	jne    2595a0 <<glass::engine::Engine>::apply+0xfe0>
  259604:	jmp    25962c <<glass::engine::Engine>::apply+0x106c>
  259606:	mov    %r15,%rcx
  259609:	sub    %rbp,%rcx
  25960c:	jb     25aa36 <<glass::engine::Engine>::apply+0x2476>
  259612:	mov    %r13,%rdx
  259615:	add    %rbp,%rdx
  259618:	mov    0x78(%rsp),%rdi
  25961d:	lea    0x130(%rsp),%rsi
  259625:	call   194650 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25962a:	jmp    2595f7 <<glass::engine::Engine>::apply+0x1037>
  25962c:	mov    %r8,0x8(%rsp)
  259631:	cmpl   $0xffffffff,0x710(%r12)
  25963a:	je     25964f <<glass::engine::Engine>::apply+0x108f>
  25963c:	movl   $0x0,0xd0(%rsp)
  259647:	mov    %r8,%r13
  25964a:	jmp    259065 <<glass::engine::Engine>::apply+0xaa5>
  25964f:	cmpb   $0x0,0x12c(%rsp)
  259657:	je     259699 <<glass::engine::Engine>::apply+0x10d9>
  259659:	mov    0x1e0(%rsp),%ebx
  259660:	cmp    $0xffffffff,%ebx
  259663:	je     259ac5 <<glass::engine::Engine>::apply+0x1505>
  259669:	mov    0x80(%rsp),%ebp
  259670:	cmp    $0x1,%bp
  259674:	adc    $0x0,%ebp
  259677:	nopw   0x0(%rax,%rax,1)
  259680:	lea    0x130(%rsp),%rdi
  259688:	mov    %ebx,%esi
  25968a:	call   33dc40 <<glass::engine::Watch as vte::ansi::Handler>::input>
  25968f:	dec    %bp
  259692:	jne    259680 <<glass::engine::Engine>::apply+0x10c0>
  259694:	jmp    259b12 <<glass::engine::Engine>::apply+0x1552>
  259699:	cmpb   $0x0,0x128(%rsp)
  2596a1:	je     2596d1 <<glass::engine::Engine>::apply+0x1111>
  2596a3:	movzwl 0x80(%rsp),%eax
  2596ab:	lea    -0x1(%rax),%esi
  2596ae:	test   %eax,%eax
  2596b0:	cmove  %eax,%esi
  2596b3:	test   %r14,%r14
  2596b6:	je     259af2 <<glass::engine::Engine>::apply+0x1532>
  2596bc:	movzwl 0x82(%rsp),%ecx
  2596c4:	xor    %eax,%eax
  2596c6:	test   %cx,%cx
  2596c9:	setne  %al
  2596cc:	jmp    259af4 <<glass::engine::Engine>::apply+0x1534>
  2596d1:	mov    0x1a8(%rsp),%r13
  2596d9:	xor    %eax,%eax
  2596db:	jmp    25970e <<glass::engine::Engine>::apply+0x114e>
  2596dd:	mov    $0x17,%cx
  2596e1:	mov    $0x1010000,%esi
  2596e6:	cs nopw 0x0(%rax,%rax,1)
  2596f0:	movzwl %cx,%eax
  2596f3:	shl    $0x10,%rsi
  2596f7:	or     %rax,%rsi
  2596fa:	mov    %r13,%rdi
  2596fd:	call   34b700 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  259702:	mov    %rbx,%rax
  259705:	cmp    %r14,%rbx
  259708:	ja     259b12 <<glass::engine::Engine>::apply+0x1552>
  25970e:	movzwl 0x80(%rsp,%rax,2),%ecx
  259716:	lea    0x1(%rax),%rbx
  25971a:	cmp    $0x3b,%rcx
  25971e:	ja     25999f <<glass::engine::Engine>::apply+0x13df>
  259724:	lea    -0x1ead73(%rip),%rsi        # 6e9b8 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2e07>
  25972b:	movslq (%rsi,%rcx,4),%rdx
  25972f:	add    %rsi,%rdx
  259732:	jmp    *%rdx
  259734:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  259736:	cmp    %r14,%rax
  259739:	jae    259702 <<glass::engine::Engine>::apply+0x1142>
  25973b:	movzwl 0x82(%rsp,%rax,2),%ecx
  259743:	lea    0x2(%rax),%rbx
  259747:	cmp    $0x5,%ecx
  25974a:	je     259a03 <<glass::engine::Engine>::apply+0x1443>
  259750:	cmp    $0x2,%ecx
  259753:	jne    259702 <<glass::engine::Engine>::apply+0x1142>
  259755:	cmp    %r14,%rbx
  259758:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  25975a:	movzwl 0x84(%rsp,%rax,2),%ecx
  259762:	lea    0x3(%rax),%rbx
  259766:	cmp    $0xff,%ecx
  25976c:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  25976e:	cmp    %r14,%rbx
  259771:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259773:	movzwl 0x86(%rsp,%rax,2),%edx
  25977b:	lea    0x4(%rax),%rbx
  25977f:	cmp    $0xff,%edx
  259785:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  25978b:	cmp    %r14,%rbx
  25978e:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259794:	movzwl 0x88(%rsp,%rax,2),%edi
  25979c:	add    $0x5,%rax
  2597a0:	cmp    $0xff,%edi
  2597a6:	ja     259a86 <<glass::engine::Engine>::apply+0x14c6>
  2597ac:	shl    $0x10,%edi
  2597af:	movzwl %dx,%edx
  2597b2:	shl    $0x8,%edx
  2597b5:	or     %edx,%ecx
  2597b7:	movzwl %cx,%esi
  2597ba:	or     %edi,%esi
  2597bc:	mov    $0x1,%ecx
  2597c1:	jmp    259a25 <<glass::engine::Engine>::apply+0x1465>
  2597c6:	mov    $0x11,%cx
  2597ca:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2597cf:	mov    $0xc,%cx
  2597d3:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2597d8:	mov    $0xa,%cx
  2597dc:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2597e1:	mov    $0x18,%cx
  2597e5:	mov    $0xff,%esi
  2597ea:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2597ef:	mov    $0xe,%cx
  2597f3:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2597f8:	cmp    %r14,%rax
  2597fb:	jae    259702 <<glass::engine::Engine>::apply+0x1142>
  259801:	movzwl 0x82(%rsp,%rax,2),%ecx
  259809:	lea    0x2(%rax),%rbx
  25980d:	cmp    $0x5,%ecx
  259810:	je     259a36 <<glass::engine::Engine>::apply+0x1476>
  259816:	cmp    $0x2,%ecx
  259819:	jne    259702 <<glass::engine::Engine>::apply+0x1142>
  25981f:	cmp    %r14,%rbx
  259822:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259828:	movzwl 0x84(%rsp,%rax,2),%ecx
  259830:	lea    0x3(%rax),%rbx
  259834:	cmp    $0xff,%ecx
  25983a:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259840:	cmp    %r14,%rbx
  259843:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259849:	movzwl 0x86(%rsp,%rax,2),%edx
  259851:	lea    0x4(%rax),%rbx
  259855:	cmp    $0xff,%edx
  25985b:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259861:	cmp    %r14,%rbx
  259864:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  25986a:	movzwl 0x88(%rsp,%rax,2),%edi
  259872:	add    $0x5,%rax
  259876:	cmp    $0xff,%edi
  25987c:	ja     259a86 <<glass::engine::Engine>::apply+0x14c6>
  259882:	shl    $0x10,%edi
  259885:	movzwl %dx,%edx
  259888:	shl    $0x8,%edx
  25988b:	or     %edx,%ecx
  25988d:	movzwl %cx,%esi
  259890:	or     %edi,%esi
  259892:	mov    $0x1,%ecx
  259897:	jmp    259a58 <<glass::engine::Engine>::apply+0x1498>
  25989c:	mov    $0x10,%cx
  2598a0:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598a5:	mov    $0x16,%cx
  2598a9:	mov    $0x1000000,%esi
  2598ae:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598b3:	mov    $0xf,%cx
  2598b7:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598bc:	mov    $0x9,%cx
  2598c0:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598c5:	mov    $0x12,%cx
  2598c9:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598ce:	mov    $0x13,%cx
  2598d2:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598d7:	mov    $0xb,%cx
  2598db:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598e0:	mov    $0xd,%cx
  2598e4:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598e9:	mov    $0x15,%cx
  2598ed:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598f2:	mov    $0x14,%cx
  2598f6:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2598fb:	cmp    %r14,%rax
  2598fe:	jae    259702 <<glass::engine::Engine>::apply+0x1142>
  259904:	movzwl 0x82(%rsp,%rax,2),%ecx
  25990c:	lea    0x2(%rax),%rbx
  259910:	cmp    $0x5,%ecx
  259913:	je     259a69 <<glass::engine::Engine>::apply+0x14a9>
  259919:	cmp    $0x2,%ecx
  25991c:	jne    259702 <<glass::engine::Engine>::apply+0x1142>
  259922:	cmp    %r14,%rbx
  259925:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  25992b:	movzwl 0x84(%rsp,%rax,2),%ecx
  259933:	lea    0x3(%rax),%rbx
  259937:	cmp    $0xff,%ecx
  25993d:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259943:	cmp    %r14,%rbx
  259946:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  25994c:	movzwl 0x86(%rsp,%rax,2),%edx
  259954:	lea    0x4(%rax),%rbx
  259958:	cmp    $0xff,%edx
  25995e:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259964:	cmp    %r14,%rbx
  259967:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  25996d:	movzwl 0x88(%rsp,%rax,2),%edi
  259975:	add    $0x5,%rax
  259979:	cmp    $0xff,%edi
  25997f:	ja     259a86 <<glass::engine::Engine>::apply+0x14c6>
  259985:	shl    $0x10,%edi
  259988:	movzwl %dx,%edx
  25998b:	shl    $0x8,%edx
  25998e:	or     %edx,%ecx
  259990:	movzwl %cx,%esi
  259993:	or     %edi,%esi
  259995:	mov    $0x1,%ecx
  25999a:	jmp    259ab4 <<glass::engine::Engine>::apply+0x14f4>
  25999f:	lea    -0x1e(%rcx),%eax
  2599a2:	cmp    $0x8,%ax
  2599a6:	jae    2599c0 <<glass::engine::Engine>::apply+0x1400>
  2599a8:	lea    -0x1fe54f(%rip),%rax        # 5b460 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0x960>
  2599af:	movzwl -0x3c(%rax,%rcx,2),%esi
  2599b4:	shl    $0x10,%esi
  2599b7:	mov    $0x16,%cx
  2599bb:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2599c0:	mov    %ecx,%eax
  2599c2:	and    $0xfff8,%eax
  2599c7:	cmp    $0x28,%ax
  2599cb:	jne    2599e5 <<glass::engine::Engine>::apply+0x1425>
  2599cd:	lea    -0x1fe574(%rip),%rax        # 5b460 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0x960>
  2599d4:	movzwl -0x50(%rax,%rcx,2),%esi
  2599d9:	shl    $0x10,%esi
  2599dc:	mov    $0x17,%cx
  2599e0:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  2599e5:	lea    -0x5a(%rcx),%eax
  2599e8:	cmp    $0x8,%ax
  2599ec:	jae    259a8e <<glass::engine::Engine>::apply+0x14ce>
  2599f2:	lea    -0x1fc989(%rip),%rax        # 5d070 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0xd0>
  2599f9:	movzwl -0xb4(%rax,%rcx,2),%esi
  259a01:	jmp    2599b4 <<glass::engine::Engine>::apply+0x13f4>
  259a03:	cmp    %r14,%rbx
  259a06:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259a0c:	movzwl 0x84(%rsp,%rax,2),%esi
  259a14:	add    $0x3,%rax
  259a18:	cmp    $0xff,%esi
  259a1e:	ja     259a86 <<glass::engine::Engine>::apply+0x14c6>
  259a20:	mov    $0x2,%ecx
  259a25:	shl    $0x8,%esi
  259a28:	or     %ecx,%esi
  259a2a:	mov    $0x16,%cx
  259a2e:	mov    %rax,%rbx
  259a31:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  259a36:	cmp    %r14,%rbx
  259a39:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259a3f:	movzwl 0x84(%rsp,%rax,2),%esi
  259a47:	add    $0x3,%rax
  259a4b:	cmp    $0xff,%esi
  259a51:	ja     259a86 <<glass::engine::Engine>::apply+0x14c6>
  259a53:	mov    $0x2,%ecx
  259a58:	shl    $0x8,%esi
  259a5b:	or     %ecx,%esi
  259a5d:	mov    $0x18,%cx
  259a61:	mov    %rax,%rbx
  259a64:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  259a69:	cmp    %r14,%rbx
  259a6c:	ja     259702 <<glass::engine::Engine>::apply+0x1142>
  259a72:	movzwl 0x84(%rsp,%rax,2),%esi
  259a7a:	add    $0x3,%rax
  259a7e:	cmp    $0xff,%esi
  259a84:	jbe    259aaf <<glass::engine::Engine>::apply+0x14ef>
  259a86:	mov    %rax,%rbx
  259a89:	jmp    259702 <<glass::engine::Engine>::apply+0x1142>
  259a8e:	lea    -0x64(%rcx),%eax
  259a91:	cmp    $0x8,%ax
  259a95:	jae    259702 <<glass::engine::Engine>::apply+0x1142>
  259a9b:	lea    -0x1fca32(%rip),%rax        # 5d070 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0xd0>
  259aa2:	movzwl -0xc8(%rax,%rcx,2),%esi
  259aaa:	jmp    2599d9 <<glass::engine::Engine>::apply+0x1419>
  259aaf:	mov    $0x2,%ecx
  259ab4:	shl    $0x8,%esi
  259ab7:	or     %ecx,%esi
  259ab9:	mov    $0x17,%cx
  259abd:	mov    %rax,%rbx
  259ac0:	jmp    2596f0 <<glass::engine::Engine>::apply+0x1130>
  259ac5:	mov    $0x1,%al
  259ac7:	mov    %eax,0xd0(%rsp)
  259ace:	mov    %r8,%r13
  259ad1:	mov    0x8(%rsp),%rax
  259ad6:	mov    %rax,0xe8(%rsp)
  259ade:	mov    $0x1,%al
  259ae0:	mov    %rax,0x58(%rsp)
  259ae5:	mov    0x120(%rsp),%rbx
  259aed:	jmp    259065 <<glass::engine::Engine>::apply+0xaa5>
  259af2:	xor    %eax,%eax
  259af4:	movzwl %cx,%edx
  259af7:	dec    %rdx
  259afa:	test   $0x1,%al
  259afc:	mov    $0x0,%eax
  259b01:	cmove  %rax,%rdx
  259b05:	mov    0x1a8(%rsp),%rdi
  259b0d:	call   34cb40 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  259b12:	mov    0x10(%rsp),%r8
  259b17:	mov    0x120(%rsp),%rbx
  259b1f:	lea    (%rbx,%r8,1),%r13
  259b23:	movb   $0x0,0xa80(%r12)
  259b2c:	movb   $0x0,0xa7e(%r12)
  259b35:	mov    $0x1,%al
  259b37:	mov    %eax,0xd0(%rsp)
  259b3e:	mov    %r13,0x8(%rsp)
  259b43:	mov    %r13,0xe8(%rsp)
  259b4b:	mov    $0x1,%al
  259b4d:	mov    %rax,0x58(%rsp)
  259b52:	jmp    259065 <<glass::engine::Engine>::apply+0xaa5>
  259b57:	mov    $0x2,%edx
  259b5c:	jmp    259375 <<glass::engine::Engine>::apply+0xdb5>
  259b61:	call   18bc86 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259b66:	jmp    259411 <<glass::engine::Engine>::apply+0xe51>
  259b6b:	call   18bc86 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259b70:	jmp    2594a5 <<glass::engine::Engine>::apply+0xee5>
  259b75:	mov    0x8(%rsp),%rax
  259b7a:	movzbl (%rax),%eax
  259b7d:	mov    %rax,0xd0(%rsp)
  259b85:	add    $0xffffffe0,%eax
  259b88:	mov    $0x1,%r15d
  259b8e:	cmp    $0x5f,%al
  259b90:	jb     259bbd <<glass::engine::Engine>::apply+0x15fd>
  259b92:	mov    0xd0(%rsp),%rdi
  259b9a:	call   2a2870 <glass::engine::width_of>
  259b9f:	mov    0x38(%rsp),%r12
  259ba4:	mov    %rdx,%r15
  259ba7:	lea    -0x1(%rdx),%rcx
  259bab:	cmp    $0x2,%rcx
  259baf:	setb   %cl
  259bb2:	and    %al,%cl
  259bb4:	cmp    $0x1,%cl
  259bb7:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  259bbd:	cmpb   $0x0,0x6c(%r13)
  259bc2:	mov    0x38(%rsp),%r12
  259bc7:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  259bcd:	mov    0x40(%r13),%rdx
  259bd1:	mov    0xa0(%r13),%rcx
  259bd8:	mov    %rdx,0x30(%rsp)
  259bdd:	lea    (%rdx,%r15,1),%rax
  259be1:	mov    %rax,0x118(%rsp)
  259be9:	mov    %rcx,0x220(%rsp)
  259bf1:	cmp    %rcx,%rax
  259bf4:	ja     259522 <<glass::engine::Engine>::apply+0xf62>
  259bfa:	lea    0x10(%r13),%rdi
  259bfe:	mov    0x48(%r13),%esi
  259c02:	mov    0x58(%r13),%eax
  259c06:	mov    %eax,0xfc(%rsp)
  259c0d:	mov    0x5c(%r13),%eax
  259c11:	mov    %eax,0xf8(%rsp)
  259c18:	movzwl 0x64(%r13),%eax
  259c1d:	mov    %eax,0x100(%rsp)
  259c24:	lea    0x37072d(%rip),%rdx        # 5ca358 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15658>
  259c2b:	call   30c250 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  259c30:	mov    %rax,%rcx
  259c33:	add    $0x18,%rcx
  259c37:	mov    %rcx,0x108(%rsp)
  259c3f:	mov    %rax,0x20(%rsp)
  259c44:	mov    0x28(%rax),%eax
  259c47:	cmp    $0xffffffff,%eax
  259c4a:	je     259c64 <<glass::engine::Engine>::apply+0x16a4>
  259c4c:	mov    0x108(%rsp),%rcx
  259c54:	mov    0x30(%rsp),%rdx
  259c59:	mov    0x20(%rsp),%rsi
  259c5e:	cmp    0x30(%rsi),%rdx
  259c62:	jae    259c8e <<glass::engine::Engine>::apply+0x16ce>
  259c64:	mov    0x20(%rsp),%rcx
  259c69:	mov    0x10(%rcx),%rcx
  259c6d:	cmp    %rcx,0x30(%rsp)
  259c72:	jae    25aa71 <<glass::engine::Engine>::apply+0x24b1>
  259c78:	mov    0x30(%rsp),%rcx
  259c7d:	lea    (%rcx,%rcx,2),%rcx
  259c81:	shl    $0x3,%rcx
  259c85:	mov    0x20(%rsp),%rdx
  259c8a:	add    0x8(%rdx),%rcx
  259c8e:	testb  $0x60,0x14(%rcx)
  259c92:	mov    0x38(%rsp),%r12
  259c97:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  259c9d:	cmp    $0x2,%r15
  259ca1:	jne    259cf5 <<glass::engine::Engine>::apply+0x1735>
  259ca3:	mov    0x30(%rsp),%rcx
  259ca8:	inc    %rcx
  259cab:	cmp    $0xffffffff,%eax
  259cae:	je     259cc3 <<glass::engine::Engine>::apply+0x1703>
  259cb0:	mov    0x108(%rsp),%rdx
  259cb8:	mov    0x20(%rsp),%rsi
  259cbd:	cmp    0x30(%rsi),%rcx
  259cc1:	jae    259ce6 <<glass::engine::Engine>::apply+0x1726>
  259cc3:	mov    0x20(%rsp),%rdx
  259cc8:	mov    0x10(%rdx),%rdx
  259ccc:	cmp    %rdx,%rcx
  259ccf:	jae    25aa87 <<glass::engine::Engine>::apply+0x24c7>
  259cd5:	lea    (%rcx,%rcx,2),%rdx
  259cd9:	shl    $0x3,%rdx
  259cdd:	mov    0x20(%rsp),%rcx
  259ce2:	add    0x8(%rcx),%rdx
  259ce6:	testb  $0x60,0x14(%rdx)
  259cea:	mov    0x38(%rsp),%r12
  259cef:	jne    259522 <<glass::engine::Engine>::apply+0xf62>
  259cf5:	mov    0x30(%rsp),%rcx
  259cfa:	mov    0x20(%rsp),%rdx
  259cff:	cmp    %ecx,0x38(%rdx)
  259d02:	jbe    259d11 <<glass::engine::Engine>::apply+0x1751>
  259d04:	mov    0x30(%rsp),%rcx
  259d09:	mov    0x20(%rsp),%rdx
  259d0e:	mov    %ecx,0x38(%rdx)
  259d11:	cmp    $0xffffffff,%eax
  259d14:	setne  %cl
  259d17:	mov    0x20(%rsp),%rdx
  259d1c:	mov    0x30(%rdx),%r12
  259d20:	cmp    %r12,0x30(%rsp)
  259d25:	sete   %dl
  259d28:	test   %dl,%cl
  259d2a:	jne    259e38 <<glass::engine::Engine>::apply+0x1878>
  259d30:	cmp    $0xffffffff,%eax
  259d33:	je     259f92 <<glass::engine::Engine>::apply+0x19d2>
  259d39:	mov    0x20(%rsp),%rax
  259d3e:	mov    0x10(%rax),%rbp
  259d42:	cmp    %r12,%rbp
  259d45:	mov    %r12,%rax
  259d48:	cmovb  %rbp,%rax
  259d4c:	mov    %rax,0x68(%rsp)
  259d51:	mov    0x30(%rsp),%rax
  259d56:	cmp    %rax,%rbp
  259d59:	cmovb  %rbp,%rax
  259d5d:	mov    %rax,0x40(%rsp)
  259d62:	mov    0x399357(%rip),%rax        # 5f30c0 <_DYNAMIC+0x320>
  259d69:	movzbl (%rax),%eax
  259d6c:	test   %al,%al
  259d6e:	je     259d99 <<glass::engine::Engine>::apply+0x17d9>
  259d70:	mov    0x399381(%rip),%rax        # 5f30f8 <_DYNAMIC+0x358>
  259d77:	cmp    0x40(%rsp),%r12
  259d7c:	jae    259d85 <<glass::engine::Engine>::apply+0x17c5>
  259d7e:	mov    0x39937b(%rip),%rax        # 5f3100 <_DYNAMIC+0x360>
  259d85:	lock incq 0x28(%rax)
  259d8a:	mov    0x40(%rsp),%rdi
  259d8f:	sub    0x68(%rsp),%rdi
  259d94:	call   2f77f0 <alacritty_terminal::grid::row::fill_census::note>
  259d99:	cmp    0x40(%rsp),%r12
  259d9e:	jae    259f72 <<glass::engine::Engine>::apply+0x19b2>
  259da4:	mov    0x20(%rsp),%rax
  259da9:	mov    0x28(%rax),%ecx
  259dac:	mov    %ecx,0x54(%rsp)
  259db0:	mov    0x20(%rax),%ecx
  259db3:	mov    %ecx,0x50(%rsp)
  259db7:	mov    0x24(%rax),%ecx
  259dba:	mov    %ecx,0x4c(%rsp)
  259dbe:	movzwl 0x2c(%rax),%ecx
  259dc2:	mov    %cx,0x70(%rsp)
  259dc7:	mov    0x18(%rax),%rax
  259dcb:	mov    %rax,0x8(%rsp)
  259dd0:	test   %rax,%rax
  259dd3:	je     259e5c <<glass::engine::Engine>::apply+0x189c>
  259dd9:	mov    0x8(%rsp),%rax
  259dde:	lock incq (%rax)
  259de2:	jle    25aaef <<glass::engine::Engine>::apply+0x252f>
  259de8:	mov    0x20(%rsp),%rax
  259ded:	mov    0x10(%rax),%rdx
  259df1:	mov    0x54(%rsp),%eax
  259df5:	mov    %eax,0xc0(%rsp)
  259dfc:	mov    0x50(%rsp),%eax
  259e00:	mov    %eax,0xb8(%rsp)
  259e07:	mov    0x4c(%rsp),%eax
  259e0b:	mov    %eax,0xbc(%rsp)
  259e12:	movzwl 0x70(%rsp),%eax
  259e17:	mov    %ax,0xc4(%rsp)
  259e1f:	mov    0x8(%rsp),%rax
  259e24:	mov    %rax,0xb0(%rsp)
  259e2c:	cmp    %rdx,0x40(%rsp)
  259e31:	jbe    259e97 <<glass::engine::Engine>::apply+0x18d7>
  259e33:	jmp    25aa9b <<glass::engine::Engine>::apply+0x24db>
  259e38:	mov    0x30(%rsp),%rcx
  259e3d:	lea    0x1(%rcx),%rax
  259e41:	mov    0x20(%rsp),%rdx
  259e46:	mov    %rax,0x30(%rdx)
  259e4a:	mov    0x10(%rdx),%rax
  259e4e:	cmp    %rax,%rcx
  259e51:	jb     259fbc <<glass::engine::Engine>::apply+0x19fc>
  259e57:	jmp    25aab4 <<glass::engine::Engine>::apply+0x24f4>
  259e5c:	mov    0x54(%rsp),%eax
  259e60:	mov    %eax,0xc0(%rsp)
  259e67:	mov    0x50(%rsp),%eax
  259e6b:	mov    %eax,0xb8(%rsp)
  259e72:	mov    0x4c(%rsp),%eax
  259e76:	mov    %eax,0xbc(%rsp)
  259e7d:	movzwl 0x70(%rsp),%eax
  259e82:	mov    %ax,0xc4(%rsp)
  259e8a:	mov    0x8(%rsp),%rax
  259e8f:	mov    %rax,0xb0(%rsp)
  259e97:	mov    0x68(%rsp),%rax
  259e9c:	lea    0x0(,%rax,8),%rax
  259ea4:	lea    (%rax,%rax,2),%rax
  259ea8:	mov    0x20(%rsp),%rcx
  259ead:	mov    0x8(%rcx),%rbp
  259eb1:	add    %rax,%rbp
  259eb4:	mov    0x40(%rsp),%rcx
  259eb9:	lea    0x0(,%rcx,8),%rcx
  259ec1:	lea    (%rcx,%rcx,2),%r12
  259ec5:	sub    %rax,%r12
  259ec8:	jmp    259efb <<glass::engine::Engine>::apply+0x193b>
  259eca:	mov    0x8(%rsp),%rax
  259ecf:	mov    %rax,0x0(%rbp)
  259ed3:	mov    0x50(%rsp),%eax
  259ed7:	mov    %eax,0x8(%rbp)
  259eda:	mov    0x4c(%rsp),%eax
  259ede:	mov    %eax,0xc(%rbp)
  259ee1:	mov    0x54(%rsp),%eax
  259ee5:	mov    %eax,0x10(%rbp)
  259ee8:	movzwl 0x70(%rsp),%eax
  259eed:	mov    %ax,0x14(%rbp)
  259ef1:	add    $0x18,%rbp
  259ef5:	add    $0xffffffffffffffe8,%r12
  259ef9:	je     259f2c <<glass::engine::Engine>::apply+0x196c>
  259efb:	cmpq   $0x0,0x8(%rsp)
  259f01:	je     259f12 <<glass::engine::Engine>::apply+0x1952>
  259f03:	mov    0x8(%rsp),%rax
  259f08:	lock incq (%rax)
  259f0c:	jle    25aaef <<glass::engine::Engine>::apply+0x252f>
  259f12:	mov    0x0(%rbp),%rax
  259f16:	test   %rax,%rax
  259f19:	je     259eca <<glass::engine::Engine>::apply+0x190a>
  259f1b:	lock decq (%rax)
  259f1f:	jne    259eca <<glass::engine::Engine>::apply+0x190a>
  259f21:	mov    %rbp,%rdi
  259f24:	call   *0x3990de(%rip)        # 5f3008 <_DYNAMIC+0x268>
  259f2a:	jmp    259eca <<glass::engine::Engine>::apply+0x190a>
  259f2c:	mov    0x20(%rsp),%rax
  259f31:	mov    0x68(%rsp),%rcx
  259f36:	cmp    %ecx,0x38(%rax)
  259f39:	jbe    259f48 <<glass::engine::Engine>::apply+0x1988>
  259f3b:	mov    0x20(%rsp),%rax
  259f40:	mov    0x68(%rsp),%rcx
  259f45:	mov    %ecx,0x38(%rax)
  259f48:	cmpq   $0x0,0x8(%rsp)
  259f4e:	je     259f69 <<glass::engine::Engine>::apply+0x19a9>
  259f50:	mov    0x8(%rsp),%rax
  259f55:	lock decq (%rax)
  259f59:	jne    259f69 <<glass::engine::Engine>::apply+0x19a9>
  259f5b:	lea    0xb0(%rsp),%rdi
  259f63:	call   *0x39909f(%rip)        # 5f3008 <_DYNAMIC+0x268>
  259f69:	mov    0x20(%rsp),%rax
  259f6e:	mov    0x10(%rax),%rbp
  259f72:	cmp    %rbp,0x40(%rsp)
  259f77:	jb     259f92 <<glass::engine::Engine>::apply+0x19d2>
  259f79:	mov    0x108(%rsp),%rdi
  259f81:	call   1ad6e0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259f86:	mov    0x20(%rsp),%rax
  259f8b:	movl   $0xffffffff,0x28(%rax)
  259f92:	mov    0x20(%rsp),%rsi
  259f97:	mov    0x30(%rsi),%rcx
  259f9b:	mov    0x30(%rsp),%rdx
  259fa0:	lea    0x1(%rdx),%rax
  259fa4:	cmp    %rcx,%rax
  259fa7:	cmova  %rax,%rcx
  259fab:	mov    0x10(%rsi),%rax
  259faf:	mov    %rcx,0x30(%rsi)
  259fb3:	cmp    %rax,%rdx
  259fb6:	jae    25aabb <<glass::engine::Engine>::apply+0x24fb>
  259fbc:	mov    0x100(%rsp),%edi
  259fc3:	mov    %edi,%eax
  259fc5:	or     $0x20,%eax
  259fc8:	cmp    $0x2,%r15
  259fcc:	mov    0x20(%rsp),%rcx
  259fd1:	mov    0x8(%rcx),%rcx
  259fd5:	mov    0x30(%rsp),%rdx
  259fda:	lea    (%rdx,%rdx,2),%rdx
  259fde:	lea    (%rcx,%rdx,8),%rbp
  259fe2:	mov    0xd0(%rsp),%rsi
  259fea:	mov    %esi,0x10(%rcx,%rdx,8)
  259fee:	mov    0xfc(%rsp),%esi
  259ff5:	mov    %esi,0x8(%rcx,%rdx,8)
  259ff9:	cmovne %edi,%eax
  259ffc:	mov    0xf8(%rsp),%esi
  25a003:	mov    %esi,0xc(%rcx,%rdx,8)
  25a007:	mov    %ax,0x14(%rcx,%rdx,8)
  25a00c:	mov    (%rcx,%rdx,8),%rax
  25a010:	test   %rax,%rax
  25a013:	je     25a024 <<glass::engine::Engine>::apply+0x1a64>
  25a015:	lock decq (%rax)
  25a019:	jne    25a024 <<glass::engine::Engine>::apply+0x1a64>
  25a01b:	mov    %rbp,%rdi
  25a01e:	call   *0x398fe4(%rip)        # 5f3008 <_DYNAMIC+0x268>
  25a024:	movq   $0x0,0x0(%rbp)
  25a02c:	cmp    $0x2,%r15
  25a030:	jne    25a322 <<glass::engine::Engine>::apply+0x1d62>
  25a036:	mov    0x30(%rsp),%rax
  25a03b:	lea    0x1(%rax),%rdx
  25a03f:	mov    0x20(%rsp),%rax
  25a044:	mov    0x30(%rax),%r15
  25a048:	mov    0x28(%rax),%eax
  25a04b:	mov    %rdx,0x70(%rsp)
  25a050:	cmp    %r15,%rdx
  25a053:	jne    25a080 <<glass::engine::Engine>::apply+0x1ac0>
  25a055:	cmp    $0xffffffff,%eax
  25a058:	je     25a080 <<glass::engine::Engine>::apply+0x1ac0>
  25a05a:	mov    0x30(%rsp),%rax
  25a05f:	add    $0x2,%rax
  25a063:	mov    0x20(%rsp),%rcx
  25a068:	mov    %rax,0x30(%rcx)
  25a06c:	mov    0x10(%rcx),%rax
  25a070:	cmp    %rax,0x70(%rsp)
  25a075:	jb     25a2c0 <<glass::engine::Engine>::apply+0x1d00>
  25a07b:	jmp    25aac2 <<glass::engine::Engine>::apply+0x2502>
  25a080:	cmp    $0xffffffff,%eax
  25a083:	je     25a294 <<glass::engine::Engine>::apply+0x1cd4>
  25a089:	mov    0x20(%rsp),%rax
  25a08e:	mov    0x10(%rax),%r12
  25a092:	cmp    %r15,%r12
  25a095:	mov    %r15,%rax
  25a098:	cmovb  %r12,%rax
  25a09c:	mov    %rax,0x68(%rsp)
  25a0a1:	mov    0x70(%rsp),%rax
  25a0a6:	cmp    %rax,%r12
  25a0a9:	cmovb  %r12,%rax
  25a0ad:	mov    %rax,0x40(%rsp)
  25a0b2:	mov    0x399007(%rip),%rax        # 5f30c0 <_DYNAMIC+0x320>
  25a0b9:	movzbl (%rax),%eax
  25a0bc:	test   %al,%al
  25a0be:	je     25a0e9 <<glass::engine::Engine>::apply+0x1b29>
  25a0c0:	mov    0x399031(%rip),%rax        # 5f30f8 <_DYNAMIC+0x358>
  25a0c7:	cmp    0x40(%rsp),%r15
  25a0cc:	jae    25a0d5 <<glass::engine::Engine>::apply+0x1b15>
  25a0ce:	mov    0x39902b(%rip),%rax        # 5f3100 <_DYNAMIC+0x360>
  25a0d5:	lock incq 0x28(%rax)
  25a0da:	mov    0x40(%rsp),%rdi
  25a0df:	sub    0x68(%rsp),%rdi
  25a0e4:	call   2f77f0 <alacritty_terminal::grid::row::fill_census::note>
  25a0e9:	cmp    0x40(%rsp),%r15
  25a0ee:	jae    25a274 <<glass::engine::Engine>::apply+0x1cb4>
  25a0f4:	mov    0x20(%rsp),%rax
  25a0f9:	mov    0x28(%rax),%ecx
  25a0fc:	mov    %ecx,0x8(%rsp)
  25a100:	mov    0x20(%rax),%ecx
  25a103:	mov    %ecx,0x54(%rsp)
  25a107:	mov    0x24(%rax),%ecx
  25a10a:	mov    %ecx,0x50(%rsp)
  25a10e:	movzwl 0x2c(%rax),%ecx
  25a112:	mov    %cx,0x4c(%rsp)
  25a117:	mov    0x18(%rax),%r12
  25a11b:	test   %r12,%r12
  25a11e:	je     25a176 <<glass::engine::Engine>::apply+0x1bb6>
  25a120:	lock incq (%r12)
  25a125:	jle    25aaef <<glass::engine::Engine>::apply+0x252f>
  25a12b:	mov    0x20(%rsp),%rax
  25a130:	mov    0x10(%rax),%rdx
  25a134:	mov    0x8(%rsp),%eax
  25a138:	mov    %eax,0xc0(%rsp)
  25a13f:	mov    0x54(%rsp),%eax
  25a143:	mov    %eax,0xb8(%rsp)
  25a14a:	mov    0x50(%rsp),%eax
  25a14e:	mov    %eax,0xbc(%rsp)
  25a155:	movzwl 0x4c(%rsp),%eax
  25a15a:	mov    %ax,0xc4(%rsp)
  25a162:	mov    %r12,0xb0(%rsp)
  25a16a:	cmp    %rdx,0x40(%rsp)
  25a16f:	jbe    25a1ac <<glass::engine::Engine>::apply+0x1bec>
  25a171:	jmp    25aad8 <<glass::engine::Engine>::apply+0x2518>
  25a176:	mov    0x8(%rsp),%eax
  25a17a:	mov    %eax,0xc0(%rsp)
  25a181:	mov    0x54(%rsp),%eax
  25a185:	mov    %eax,0xb8(%rsp)
  25a18c:	mov    0x50(%rsp),%eax
  25a190:	mov    %eax,0xbc(%rsp)
  25a197:	movzwl 0x4c(%rsp),%eax
  25a19c:	mov    %ax,0xc4(%rsp)
  25a1a4:	mov    %r12,0xb0(%rsp)
  25a1ac:	mov    0x68(%rsp),%rax
  25a1b1:	lea    0x0(,%rax,8),%rax
  25a1b9:	lea    (%rax,%rax,2),%rax
  25a1bd:	mov    0x20(%rsp),%rcx
  25a1c2:	mov    0x8(%rcx),%rbp
  25a1c6:	add    %rax,%rbp
  25a1c9:	mov    0x40(%rsp),%rcx
  25a1ce:	lea    0x0(,%rcx,8),%rcx
  25a1d6:	lea    (%rcx,%rcx,2),%r15
  25a1da:	sub    %rax,%r15
  25a1dd:	jmp    25a20b <<glass::engine::Engine>::apply+0x1c4b>
  25a1df:	mov    %r12,0x0(%rbp)
  25a1e3:	mov    0x54(%rsp),%eax
  25a1e7:	mov    %eax,0x8(%rbp)
  25a1ea:	mov    0x50(%rsp),%eax
  25a1ee:	mov    %eax,0xc(%rbp)
  25a1f1:	mov    0x8(%rsp),%eax
  25a1f5:	mov    %eax,0x10(%rbp)
  25a1f8:	movzwl 0x4c(%rsp),%eax
  25a1fd:	mov    %ax,0x14(%rbp)
  25a201:	add    $0x18,%rbp
  25a205:	add    $0xffffffffffffffe8,%r15
  25a209:	je     25a235 <<glass::engine::Engine>::apply+0x1c75>
  25a20b:	test   %r12,%r12
  25a20e:	je     25a21b <<glass::engine::Engine>::apply+0x1c5b>
  25a210:	lock incq (%r12)
  25a215:	jle    25aaef <<glass::engine::Engine>::apply+0x252f>
  25a21b:	mov    0x0(%rbp),%rax
  25a21f:	test   %rax,%rax
  25a222:	je     25a1df <<glass::engine::Engine>::apply+0x1c1f>
  25a224:	lock decq (%rax)
  25a228:	jne    25a1df <<glass::engine::Engine>::apply+0x1c1f>
  25a22a:	mov    %rbp,%rdi
  25a22d:	call   *0x398dd5(%rip)        # 5f3008 <_DYNAMIC+0x268>
  25a233:	jmp    25a1df <<glass::engine::Engine>::apply+0x1c1f>
  25a235:	mov    0x20(%rsp),%rax
  25a23a:	mov    0x68(%rsp),%rcx
  25a23f:	cmp    %ecx,0x38(%rax)
  25a242:	jbe    25a251 <<glass::engine::Engine>::apply+0x1c91>
  25a244:	mov    0x20(%rsp),%rax
  25a249:	mov    0x68(%rsp),%rcx
  25a24e:	mov    %ecx,0x38(%rax)
  25a251:	test   %r12,%r12
  25a254:	je     25a26b <<glass::engine::Engine>::apply+0x1cab>
  25a256:	lock decq (%r12)
  25a25b:	jne    25a26b <<glass::engine::Engine>::apply+0x1cab>
  25a25d:	lea    0xb0(%rsp),%rdi
  25a265:	call   *0x398d9d(%rip)        # 5f3008 <_DYNAMIC+0x268>
  25a26b:	mov    0x20(%rsp),%rax
  25a270:	mov    0x10(%rax),%r12
  25a274:	cmp    %r12,0x40(%rsp)
  25a279:	jb     25a294 <<glass::engine::Engine>::apply+0x1cd4>
  25a27b:	mov    0x108(%rsp),%rdi
  25a283:	call   1ad6e0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  25a288:	mov    0x20(%rsp),%rax
  25a28d:	movl   $0xffffffff,0x28(%rax)
  25a294:	mov    0x20(%rsp),%rdx
  25a299:	mov    0x30(%rdx),%rax
  25a29d:	mov    0x30(%rsp),%rcx
  25a2a2:	add    $0x2,%rcx
  25a2a6:	cmp    %rax,%rcx
  25a2a9:	cmovbe %rax,%rcx
  25a2ad:	mov    0x10(%rdx),%rax
  25a2b1:	mov    %rcx,0x30(%rdx)
  25a2b5:	cmp    %rax,0x70(%rsp)
  25a2ba:	jae    25aaf1 <<glass::engine::Engine>::apply+0x2531>
  25a2c0:	mov    0x20(%rsp),%rax
  25a2c5:	mov    0x8(%rax),%rax
  25a2c9:	mov    0x70(%rsp),%rcx
  25a2ce:	lea    (%rcx,%rcx,2),%rcx
  25a2d2:	lea    (%rax,%rcx,8),%r15
  25a2d6:	movl   $0x20,0x10(%rax,%rcx,8)
  25a2de:	mov    0xfc(%rsp),%edx
  25a2e5:	mov    %edx,0x8(%rax,%rcx,8)
  25a2e9:	mov    0xf8(%rsp),%edx
  25a2f0:	mov    %edx,0xc(%rax,%rcx,8)
  25a2f4:	mov    0x100(%rsp),%edx
  25a2fb:	or     $0x40,%edx
  25a2fe:	mov    %dx,0x14(%rax,%rcx,8)
  25a303:	mov    (%rax,%rcx,8),%rax
  25a307:	test   %rax,%rax
  25a30a:	je     25a31b <<glass::engine::Engine>::apply+0x1d5b>
  25a30c:	lock decq (%rax)
  25a310:	jne    25a31b <<glass::engine::Engine>::apply+0x1d5b>
  25a312:	mov    %r15,%rdi
  25a315:	call   *0x398ced(%rip)        # 5f3008 <_DYNAMIC+0x268>
  25a31b:	movq   $0x0,(%r15)
  25a322:	mov    0x220(%rsp),%rax
  25a32a:	cmp    %rax,0x118(%rsp)
  25a332:	jb     25a341 <<glass::engine::Engine>::apply+0x1d81>
  25a334:	decq   0x118(%rsp)
  25a33c:	movb   $0x1,0x6c(%r13)
  25a341:	mov    0x118(%rsp),%rax
  25a349:	mov    %rax,0x40(%r13)
  25a34d:	incq   0x1d0(%rsp)
  25a355:	mov    0xd0(%rsp),%rax
  25a35d:	mov    %eax,0x1e0(%rsp)
  25a364:	mov    $0x1,%r15d
  25a36a:	mov    0x38(%rsp),%r12
  25a36f:	mov    0x39bc0b(%rip),%eax        # 5f5f80 <glass::engine::run_whole::ON>
  25a375:	test   %eax,%eax
  25a377:	je     259548 <<glass::engine::Engine>::apply+0xf88>
  25a37d:	call   18bc86 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25a382:	jmp    259548 <<glass::engine::Engine>::apply+0xf88>
  25a387:	nopw   0x0(%rax,%rax,1)
  25a390:	mov    0x3994c1(%rip),%rax        # 5f3858 <_DYNAMIC+0xab8>
  25a397:	mov    (%rax),%rax
  25a39a:	mov    $0x1b,%edi
  25a39f:	mov    %r14,%rsi
  25a3a2:	mov    0x110(%rsp),%rbx
  25a3aa:	mov    %rbx,%rdx
  25a3ad:	call   *%rax
  25a3af:	mov    %r14,%r13
  25a3b2:	mov    %rbx,%r14
  25a3b5:	cmp    $0x1,%rax
  25a3b9:	jne    25a670 <<glass::engine::Engine>::apply+0x20b0>
  25a3bf:	mov    %rdx,%rcx
  25a3c2:	sub    %r13,%rcx
  25a3c5:	movb   $0x1,0xa80(%r12)
  25a3ce:	movb   $0x0,0xa7e(%r12)
  25a3d7:	inc    %rcx
  25a3da:	cmp    %r15,%rcx
  25a3dd:	jb     25a67b <<glass::engine::Engine>::apply+0x20bb>
  25a3e3:	movzbl 0xa7e(%r12),%eax
  25a3ec:	jmp    25a771 <<glass::engine::Engine>::apply+0x21b1>
  25a3f1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a400:	mov    0x18(%rsp),%r15
  25a405:	cmp    %rbp,%r15
  25a408:	jb     25a9bf <<glass::engine::Engine>::apply+0x23ff>
  25a40e:	mov    0x28(%rsp),%r13
  25a413:	mov    %r13,%rbx
  25a416:	add    %rbp,%rbx
  25a419:	mov    0x399438(%rip),%rax        # 5f3858 <_DYNAMIC+0xab8>
  25a420:	mov    (%rax),%rax
  25a423:	mov    $0x1b,%edi
  25a428:	mov    %rbx,%rsi
  25a42b:	mov    0x110(%rsp),%r14
  25a433:	mov    %r14,%rdx
  25a436:	call   *%rax
  25a438:	cmp    $0x1,%rax
  25a43c:	jne    25a459 <<glass::engine::Engine>::apply+0x1e99>
  25a43e:	sub    %rbx,%rdx
  25a441:	movb   $0x1,0xa80(%r12)
  25a44a:	movb   $0x0,0xa7e(%r12)
  25a453:	add    %rdx,%rbp
  25a456:	inc    %rbp
  25a459:	cmp    %r15,%rbp
  25a45c:	jae    25a493 <<glass::engine::Engine>::apply+0x1ed3>
  25a45e:	mov    0x60(%rsp),%rdi
  25a463:	mov    %r13,%rsi
  25a466:	mov    %r15,%rdx
  25a469:	mov    %rbp,%rcx
  25a46c:	mov    %r15,%r8
  25a46f:	call   270770 <<glass::engine::Mirror>::stretch>
  25a474:	cmp    %r15,%rax
  25a477:	jae    25a493 <<glass::engine::Engine>::apply+0x1ed3>
  25a479:	cmpb   $0x0,0xa80(%r12)
  25a482:	jne    25a493 <<glass::engine::Engine>::apply+0x1ed3>
  25a484:	movzbl -0x1(%r14),%eax
  25a489:	shr    $0x7,%al
  25a48c:	mov    0x60(%rsp),%rcx
  25a491:	mov    %al,(%rcx)
  25a493:	movzbl 0xa7e(%r12),%eax
  25a49c:	mov    %al,0xa7f(%r12)
  25a4a4:	sub    0x8(%rsp),%r15
  25a4a9:	mov    0xe0(%rsp),%rbx
  25a4b1:	jbe    25a4e0 <<glass::engine::Engine>::apply+0x1f20>
  25a4b3:	movzbl 0x39ee1e(%rip),%eax        # 5f92d8 <glass::engine::counters::COUNTING>
  25a4ba:	test   %al,%al
  25a4bc:	je     25a4c6 <<glass::engine::Engine>::apply+0x1f06>
  25a4be:	lock add %r15,0x39ee1a(%rip)        # 5f92e0 <glass::engine::counters::VTE_BYTES>
  25a4c6:	movzbl 0x39edab(%rip),%eax        # 5f9278 <glass::engine::probes::RUN_PROBE>
  25a4cd:	cmp    $0x68,%al
  25a4cf:	jne    25a81a <<glass::engine::Engine>::apply+0x225a>
  25a4d5:	data16 cs nopw 0x0(%rax,%rax,1)
  25a4e0:	mov    0x1e0(%rsp),%rax
  25a4e8:	mov    %rax,0xa70(%r12)
  25a4f0:	mov    0x1e8(%rsp),%eax
  25a4f7:	mov    %eax,0xa78(%r12)
  25a4ff:	pshufd $0x4e,0x1c0(%rsp),%xmm0
  25a509:	movdqu %xmm0,0xa60(%r12)
  25a513:	movzbl 0x1ed(%rsp),%eax
  25a51b:	mov    %al,0xa7d(%r12)
  25a523:	movzbl 0x1ec(%rsp),%eax
  25a52b:	and    $0x1,%eax
  25a52e:	shl    $0x5,%eax
  25a531:	mov    0x1b8(%rsp,%rax,1),%rax
  25a539:	mov    0xa58(%r12),%rcx
  25a541:	cmp    %rcx,%rax
  25a544:	cmova  %rax,%rcx
  25a548:	mov    %rcx,0xa58(%r12)
  25a550:	mov    0x140(%rsp),%rax
  25a558:	mov    %rax,0x28(%rsp)
  25a55d:	mov    0x148(%rsp),%r13
  25a565:	mov    0x150(%rsp),%r14
  25a56d:	movq   $0x0,0x140(%rsp)
  25a579:	movq   $0x8,0x148(%rsp)
  25a585:	movq   $0x0,0x150(%rsp)
  25a591:	test   %r14,%r14
  25a594:	je     25a5f2 <<glass::engine::Engine>::apply+0x2032>
  25a596:	mov    0x8e8(%r12),%rax
  25a59e:	mov    0x8f8(%r12),%r15
  25a5a6:	sub    %r15,%rax
  25a5a9:	cmp    %rax,%r14
  25a5ac:	ja     25a8ed <<glass::engine::Engine>::apply+0x232d>
  25a5b2:	mov    %r14,%rax
  25a5b5:	shl    $0x4,%rax
  25a5b9:	lea    (%rax,%rax,2),%rdx
  25a5bd:	lea    (%r15,%r15,2),%rdi
  25a5c1:	shl    $0x4,%rdi
  25a5c5:	add    0x8f0(%r12),%rdi
  25a5cd:	mov    %r13,%rsi
  25a5d0:	call   *0x3989fa(%rip)        # 5f2fd0 <memcpy@GLIBC_2.14>
  25a5d6:	add    %r14,%r15
  25a5d9:	mov    %r15,0x8f8(%r12)
  25a5e1:	cmpq   $0x0,0x28(%rsp)
  25a5e7:	je     25a5f2 <<glass::engine::Engine>::apply+0x2032>
  25a5e9:	mov    %r13,%rdi
  25a5ec:	call   *0x3989f6(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25a5f2:	mov    0x170(%rsp),%r15
  25a5fa:	lea    0x178(%rsp),%rax
  25a602:	movups (%rax),%xmm0
  25a605:	movups 0x10(%rax),%xmm1
  25a609:	movups 0x20(%rax),%xmm2
  25a60d:	movaps %xmm0,0x80(%rsp)
  25a615:	movaps %xmm1,0x90(%rsp)
  25a61d:	movaps %xmm2,0xa0(%rsp)
  25a625:	movq   $0xffffffffffffffff,0x170(%rsp)
  25a631:	cmp    $0xffffffffffffffff,%r15
  25a635:	je     25a660 <<glass::engine::Engine>::apply+0x20a0>
  25a637:	cmpq   $0x0,0x998(%r12)
  25a640:	jle    25a6ba <<glass::engine::Engine>::apply+0x20fa>
  25a642:	mov    (%rbx),%rdi
  25a645:	call   *0x39899d(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25a64b:	cmpq   $0x0,0x170(%rsp)
  25a654:	setg   %bpl
  25a658:	jmp    25a6bc <<glass::engine::Engine>::apply+0x20fc>
  25a65a:	nopw   0x0(%rax,%rax,1)
  25a660:	xor    %ebp,%ebp
  25a662:	jmp    25a6e7 <<glass::engine::Engine>::apply+0x2127>
  25a667:	nopw   0x0(%rax,%rax,1)
  25a670:	xor    %ecx,%ecx
  25a672:	cmp    %r15,%rcx
  25a675:	jae    25a3e3 <<glass::engine::Engine>::apply+0x1e23>
  25a67b:	mov    0x60(%rsp),%rdi
  25a680:	mov    %r13,%rsi
  25a683:	mov    %r15,%rdx
  25a686:	mov    %r15,%r8
  25a689:	call   270770 <<glass::engine::Mirror>::stretch>
  25a68e:	cmp    %r15,%rax
  25a691:	jae    25a769 <<glass::engine::Engine>::apply+0x21a9>
  25a697:	cmpb   $0x0,0xa80(%r12)
  25a6a0:	jne    25a769 <<glass::engine::Engine>::apply+0x21a9>
  25a6a6:	movzbl -0x1(%r14),%eax
  25a6ab:	shr    $0x7,%al
  25a6ae:	mov    0x60(%rsp),%rcx
  25a6b3:	mov    %al,(%rcx)
  25a6b5:	jmp    25a771 <<glass::engine::Engine>::apply+0x21b1>
  25a6ba:	xor    %ebp,%ebp
  25a6bc:	mov    %r15,0x998(%r12)
  25a6c4:	movaps 0x80(%rsp),%xmm0
  25a6cc:	movaps 0x90(%rsp),%xmm1
  25a6d4:	movaps 0xa0(%rsp),%xmm2
  25a6dc:	movups %xmm2,0x20(%rbx)
  25a6e0:	movups %xmm1,0x10(%rbx)
  25a6e4:	movups %xmm0,(%rbx)
  25a6e7:	mov    0x158(%rsp),%rbx
  25a6ef:	mov    0x160(%rsp),%r12
  25a6f7:	mov    0x178(%rsp),%r15
  25a6ff:	cmpq   $0x0,0x140(%rsp)
  25a708:	je     25a718 <<glass::engine::Engine>::apply+0x2158>
  25a70a:	mov    0x148(%rsp),%rdi
  25a712:	call   *0x3988d0(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25a718:	test   %rbx,%rbx
  25a71b:	je     25a726 <<glass::engine::Engine>::apply+0x2166>
  25a71d:	mov    %r12,%rdi
  25a720:	call   *0x3988c2(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25a726:	test   %bpl,%bpl
  25a729:	je     25a734 <<glass::engine::Engine>::apply+0x2174>
  25a72b:	mov    %r15,%rdi
  25a72e:	call   *0x3988b4(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25a734:	mov    0x38(%rsp),%rbx
  25a739:	mov    %rbx,%rdi
  25a73c:	call   257830 <<glass::engine::Engine>::fold_sentinel>
  25a741:	test   %r14,%r14
  25a744:	setne  %al
  25a747:	cmpq   $0x0,0x28(%rsp)
  25a74d:	sete   %cl
  25a750:	or     %al,%cl
  25a752:	cmp    $0x1,%cl
  25a755:	je     2586a0 <<glass::engine::Engine>::apply+0xe0>
  25a75b:	mov    %r13,%rdi
  25a75e:	call   *0x398884(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25a764:	jmp    2586a0 <<glass::engine::Engine>::apply+0xe0>
  25a769:	mov    0x60(%rsp),%rax
  25a76e:	movzbl (%rax),%eax
  25a771:	mov    %al,0xa7f(%r12)
  25a779:	mov    0xe0(%rsp),%rbx
  25a781:	xor    %ebp,%ebp
  25a783:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a790:	cmpl   $0xffffffff,0x710(%r12)
  25a799:	jne    25a7f4 <<glass::engine::Engine>::apply+0x2234>
  25a79b:	mov    0x78(%rsp),%rax
  25a7a0:	mov    %rax,0x80(%rsp)
  25a7a8:	lea    0x130(%rsp),%rax
  25a7b0:	mov    %rax,0x88(%rsp)
  25a7b8:	movb   $0x0,0x90(%rsp)
  25a7c0:	mov    %r15,%rcx
  25a7c3:	sub    %rbp,%rcx
  25a7c6:	jb     25a92a <<glass::engine::Engine>::apply+0x236a>
  25a7cc:	mov    %r13,%rdx
  25a7cf:	add    %rbp,%rdx
  25a7d2:	mov    0xf0(%rsp),%rdi
  25a7da:	lea    0x80(%rsp),%rsi
  25a7e2:	call   1a08f0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a7e7:	add    %rax,%rbp
  25a7ea:	cmp    %r15,%rbp
  25a7ed:	jne    25a790 <<glass::engine::Engine>::apply+0x21d0>
  25a7ef:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1f20>
  25a7f4:	mov    %r15,%rcx
  25a7f7:	sub    %rbp,%rcx
  25a7fa:	jb     25aa36 <<glass::engine::Engine>::apply+0x2476>
  25a800:	mov    %r13,%rdx
  25a803:	add    %rbp,%rdx
  25a806:	mov    0x78(%rsp),%rdi
  25a80b:	lea    0x130(%rsp),%rsi
  25a813:	call   194650 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a818:	jmp    25a7e7 <<glass::engine::Engine>::apply+0x2227>
  25a81a:	mov    %r15,%rdx
  25a81d:	add    0x8(%rsp),%r13
  25a822:	cmpb   $0x1,0x58(%rsp)
  25a827:	jne    25a857 <<glass::engine::Engine>::apply+0x2297>
  25a829:	cmpl   $0xffffffff,0x710(%r12)
  25a832:	jne    25a857 <<glass::engine::Engine>::apply+0x2297>
  25a834:	lea    0x130(%rsp),%rdi
  25a83c:	mov    %r13,%rsi
  25a83f:	call   2a24b0 <glass::engine::plain_c0>
  25a844:	test   %al,%al
  25a846:	mov    0xe0(%rsp),%rbx
  25a84e:	mov    %r15,%rdx
  25a851:	jne    25a4e0 <<glass::engine::Engine>::apply+0x1f20>
  25a857:	xor    %ebp,%ebp
  25a859:	nopl   0x0(%rax)
  25a860:	cmpl   $0xffffffff,0x710(%r12)
  25a869:	jne    25a8c7 <<glass::engine::Engine>::apply+0x2307>
  25a86b:	mov    0x78(%rsp),%rax
  25a870:	mov    %rax,0x80(%rsp)
  25a878:	lea    0x130(%rsp),%rax
  25a880:	mov    %rax,0x88(%rsp)
  25a888:	movb   $0x0,0x90(%rsp)
  25a890:	mov    %r15,%rcx
  25a893:	sub    %rbp,%rcx
  25a896:	jb     25a92a <<glass::engine::Engine>::apply+0x236a>
  25a89c:	mov    %r13,%rdx
  25a89f:	add    %rbp,%rdx
  25a8a2:	mov    0xf0(%rsp),%rdi
  25a8aa:	lea    0x80(%rsp),%rsi
  25a8b2:	call   1a08f0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a8b7:	add    %rax,%rbp
  25a8ba:	mov    %r15,%rdx
  25a8bd:	cmp    %r15,%rbp
  25a8c0:	jne    25a860 <<glass::engine::Engine>::apply+0x22a0>
  25a8c2:	jmp    25a4e0 <<glass::engine::Engine>::apply+0x1f20>
  25a8c7:	mov    %rdx,%rcx
  25a8ca:	sub    %rbp,%rcx
  25a8cd:	jb     25aa36 <<glass::engine::Engine>::apply+0x2476>
  25a8d3:	mov    %r13,%rdx
  25a8d6:	add    %rbp,%rdx
  25a8d9:	mov    0x78(%rsp),%rdi
  25a8de:	lea    0x130(%rsp),%rsi
  25a8e6:	call   194650 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a8eb:	jmp    25a8b7 <<glass::engine::Engine>::apply+0x22f7>
  25a8ed:	mov    $0x8,%ecx
  25a8f2:	mov    $0x30,%r8d
  25a8f8:	mov    0x228(%rsp),%rdi
  25a900:	mov    %r15,%rsi
  25a903:	mov    %r14,%rdx
  25a906:	call   1cfbf0 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  25a90b:	mov    0x8f8(%r12),%r15
  25a913:	jmp    25a5b2 <<glass::engine::Engine>::apply+0x1ff2>
  25a918:	add    $0x248,%rsp
  25a91f:	pop    %rbx
  25a920:	pop    %r12
  25a922:	pop    %r13
  25a924:	pop    %r14
  25a926:	pop    %r15
  25a928:	pop    %rbp
  25a929:	ret
  25a92a:	mov    %r15,%r8
  25a92d:	lea    0x35ac44(%rip),%rcx        # 5b5578 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25a934:	jmp    25a951 <<glass::engine::Engine>::apply+0x2391>
  25a936:	mov    %rbx,%r8
  25a939:	lea    0x36fc28(%rip),%rcx        # 5ca568 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15868>
  25a940:	mov    0x18(%rsp),%r15
  25a945:	jmp    25a951 <<glass::engine::Engine>::apply+0x2391>
  25a947:	mov    %rbx,%r8
  25a94a:	lea    0x36fc17(%rip),%rcx        # 5ca568 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15868>
  25a951:	mov    %rbp,%rdi
  25a954:	mov    %r8,%rsi
  25a957:	mov    %r15,%rdx
  25a95a:	call   *0x398818(%rip)        # 5f3178 <_DYNAMIC+0x3d8>
  25a960:	jmp    25aaef <<glass::engine::Engine>::apply+0x252f>
  25a965:	mov    %rbx,%rbp
  25a968:	mov    %r13,%r8
  25a96b:	lea    0x37206e(%rip),%rcx        # 5cc9e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17ce0>
  25a972:	mov    0x18(%rsp),%r15
  25a977:	jmp    25a951 <<glass::engine::Engine>::apply+0x2391>
  25a979:	lea    0x372090(%rip),%rcx        # 5cca10 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d10>
  25a980:	xor    %ebp,%ebp
  25a982:	mov    0x18(%rsp),%r15
  25a987:	mov    %rdx,%r8
  25a98a:	jmp    25a951 <<glass::engine::Engine>::apply+0x2391>
  25a98c:	mov    0x8(%rsp),%rbp
  25a991:	mov    %rbx,%r8
  25a994:	lea    0x37205d(%rip),%rcx        # 5cc9f8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cf8>
  25a99b:	mov    0x18(%rsp),%r15
  25a9a0:	jmp    25a951 <<glass::engine::Engine>::apply+0x2391>
  25a9a2:	mov    $0xffffffffffffffff,%r8
  25a9a9:	xor    %ebp,%ebp
  25a9ab:	xor    %r15d,%r15d
  25a9ae:	lea    0x372013(%rip),%rcx        # 5cc9c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cc8>
  25a9b5:	jmp    25a951 <<glass::engine::Engine>::apply+0x2391>
  25a9b7:	mov    %r13,%rbp
  25a9ba:	jmp    25a939 <<glass::engine::Engine>::apply+0x2379>
  25a9bf:	mov    %r15,%r8
  25a9c2:	jmp    25a94a <<glass::engine::Engine>::apply+0x238a>
  25a9c4:	lea    0x371fcd(%rip),%rdx        # 5cc998 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c98>
  25a9cb:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25a9cd:	mov    %r13,%rbp
  25a9d0:	lea    0x372051(%rip),%rcx        # 5cca28 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d28>
  25a9d7:	mov    0x18(%rsp),%r15
  25a9dc:	jmp    25a951 <<glass::engine::Engine>::apply+0x2391>
  25a9e1:	lea    0x371fc8(%rip),%rdx        # 5cc9b0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cb0>
  25a9e8:	mov    %r14,%rdi
  25a9eb:	mov    0x18(%rsp),%rsi
  25a9f0:	call   *0x3985c2(%rip)        # 5f2fb8 <_DYNAMIC+0x218>
  25a9f6:	jmp    25aaef <<glass::engine::Engine>::apply+0x252f>
  25a9fb:	mov    $0x10,%eax
  25aa00:	mov    %rax,0x18(%rsp)
  25aa05:	mov    $0xffffffffffffffff,%r14
  25aa0c:	lea    0x37202d(%rip),%rdx        # 5cca40 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d40>
  25aa13:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25aa15:	mov    $0x8,%edi
  25aa1a:	mov    %r14,%rsi
  25aa1d:	call   *0x398585(%rip)        # 5f2fa8 <_DYNAMIC+0x208>
  25aa23:	mov    $0x10,%eax
  25aa28:	mov    %rax,0x18(%rsp)
  25aa2d:	lea    0x372024(%rip),%rdx        # 5cca58 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d58>
  25aa34:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25aa36:	mov    %r15,%r8
  25aa39:	lea    0x35ab50(%rip),%rcx        # 5b5590 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25aa40:	jmp    25a951 <<glass::engine::Engine>::apply+0x2391>
  25aa45:	mov    $0x10,%eax
  25aa4a:	mov    %rax,0x18(%rsp)
  25aa4f:	lea    0x37201a(%rip),%rdx        # 5cca70 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d70>
  25aa56:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25aa58:	mov    %rsi,%r14
  25aa5b:	mov    0x10(%rsp),%rax
  25aa60:	mov    %rax,0x18(%rsp)
  25aa65:	lea    0x371f14(%rip),%rdx        # 5cc980 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c80>
  25aa6c:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25aa71:	mov    0x30(%rsp),%r14
  25aa76:	mov    %rcx,0x18(%rsp)
  25aa7b:	lea    0x35d866(%rip),%rdx        # 5b82e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25aa82:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25aa87:	mov    %rcx,%r14
  25aa8a:	mov    %rdx,0x18(%rsp)
  25aa8f:	lea    0x35d852(%rip),%rdx        # 5b82e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25aa96:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25aa9b:	lea    0x36f226(%rip),%rcx        # 5c9cc8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  25aaa2:	mov    0x68(%rsp),%rdi
  25aaa7:	mov    0x40(%rsp),%rsi
  25aaac:	call   *0x3986c6(%rip)        # 5f3178 <_DYNAMIC+0x3d8>
  25aab2:	jmp    25aaef <<glass::engine::Engine>::apply+0x252f>
  25aab4:	mov    0x30(%rsp),%r14
  25aab9:	jmp    25aac7 <<glass::engine::Engine>::apply+0x2507>
  25aabb:	mov    0x30(%rsp),%r14
  25aac0:	jmp    25aaf6 <<glass::engine::Engine>::apply+0x2536>
  25aac2:	mov    0x70(%rsp),%r14
  25aac7:	mov    %rax,0x18(%rsp)
  25aacc:	lea    0x36fe0d(%rip),%rdx        # 5ca8e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15be0>
  25aad3:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25aad8:	lea    0x36f1e9(%rip),%rcx        # 5c9cc8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  25aadf:	mov    0x68(%rsp),%rdi
  25aae4:	mov    0x40(%rsp),%rsi
  25aae9:	call   *0x398689(%rip)        # 5f3178 <_DYNAMIC+0x3d8>
  25aaef:	ud2
  25aaf1:	mov    0x70(%rsp),%r14
  25aaf6:	mov    %rax,0x18(%rsp)
  25aafb:	lea    0x36fdc6(%rip),%rdx        # 5ca8c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  25ab02:	jmp    25a9e8 <<glass::engine::Engine>::apply+0x2428>
  25ab07:	mov    %rax,%r15
  25ab0a:	cmpq   $0x0,0x28(%rsp)
  25ab10:	je     25ab7a <<glass::engine::Engine>::apply+0x25ba>
  25ab12:	mov    %r13,%rdi
  25ab15:	call   *0x3984cd(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25ab1b:	jmp    25ab7a <<glass::engine::Engine>::apply+0x25ba>
  25ab1d:	mov    %rax,%r15
  25ab20:	lock decq (%r12)
  25ab25:	je     25ab37 <<glass::engine::Engine>::apply+0x2577>
  25ab27:	jmp    25ab7a <<glass::engine::Engine>::apply+0x25ba>
  25ab29:	mov    %rax,%r15
  25ab2c:	mov    0x8(%rsp),%rax
  25ab31:	lock decq (%rax)
  25ab35:	jne    25ab7a <<glass::engine::Engine>::apply+0x25ba>
  25ab37:	lea    0xb0(%rsp),%rdi
  25ab3f:	call   *0x3984c3(%rip)        # 5f3008 <_DYNAMIC+0x268>
  25ab45:	jmp    25ab7a <<glass::engine::Engine>::apply+0x25ba>
  25ab47:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab49:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab4b:	mov    %rax,%r15
  25ab4e:	test   %r14,%r14
  25ab51:	setne  %al
  25ab54:	cmpq   $0x0,0x28(%rsp)
  25ab5a:	sete   %cl
  25ab5d:	or     %al,%cl
  25ab5f:	jne    25abe6 <<glass::engine::Engine>::apply+0x2626>
  25ab65:	jmp    25aba3 <<glass::engine::Engine>::apply+0x25e3>
  25ab67:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab69:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab6b:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab6d:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab6f:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab71:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab73:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab75:	jmp    25ab77 <<glass::engine::Engine>::apply+0x25b7>
  25ab77:	mov    %rax,%r15
  25ab7a:	cmpq   $0x0,0x140(%rsp)
  25ab83:	jne    25abb4 <<glass::engine::Engine>::apply+0x25f4>
  25ab85:	cmpq   $0x0,0x158(%rsp)
  25ab8e:	jne    25abcd <<glass::engine::Engine>::apply+0x260d>
  25ab90:	cmpq   $0x0,0x170(%rsp)
  25ab99:	jle    25abe6 <<glass::engine::Engine>::apply+0x2626>
  25ab9b:	mov    0x178(%rsp),%r13
  25aba3:	mov    %r13,%rdi
  25aba6:	call   *0x39843c(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25abac:	mov    %r15,%rdi
  25abaf:	call   5b15f0 <_Unwind_Resume@plt>
  25abb4:	mov    0x148(%rsp),%rdi
  25abbc:	call   *0x398426(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25abc2:	cmpq   $0x0,0x158(%rsp)
  25abcb:	je     25ab90 <<glass::engine::Engine>::apply+0x25d0>
  25abcd:	mov    0x160(%rsp),%rdi
  25abd5:	call   *0x39840d(%rip)        # 5f2fe8 <_DYNAMIC+0x248>
  25abdb:	cmpq   $0x0,0x170(%rsp)
  25abe4:	jg     25ab9b <<glass::engine::Engine>::apply+0x25db>
  25abe6:	mov    %r15,%rdi
  25abe9:	call   5b15f0 <_Unwind_Resume@plt>
