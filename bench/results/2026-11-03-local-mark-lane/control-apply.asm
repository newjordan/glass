
/tmp/glass-i31-control-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000258540 <<glass::engine::Engine>::apply>:
  258540:	push   %rbp
  258541:	push   %r15
  258543:	push   %r14
  258545:	push   %r13
  258547:	push   %r12
  258549:	push   %rbx
  25854a:	sub    $0x248,%rsp
  258551:	mov    %rdi,%rbx
  258554:	testb  $0x10,0x6d5(%rdi)
  25855b:	jne    2585bd <<glass::engine::Engine>::apply+0x7d>
  25855d:	cmpb   $0x2,0x278(%rbx)
  258564:	jne    2585bd <<glass::engine::Engine>::apply+0x7d>
  258566:	mov    0xb0(%rbx),%rax
  25856d:	dec    %rax
  258570:	movq   $0x0,0x250(%rbx)
  25857b:	movl   $0x0,0x258(%rbx)
  258585:	movb   $0x0,0x260(%rbx)
  25858c:	mov    %rax,0x268(%rbx)
  258593:	movl   $0x0,0x270(%rbx)
  25859d:	movb   $0x1,0x278(%rbx)
  2585a4:	movb   $0x0,0x280(%rbx)
  2585ab:	movq   $0x0,0xa60(%rbx)
  2585b6:	movb   $0x1,0xa7d(%rbx)
  2585bd:	test   %rdx,%rdx
  2585c0:	je     25a898 <<glass::engine::Engine>::apply+0x2358>
  2585c6:	lea    0x10(%rbx),%rax
  2585ca:	mov    %rax,0x238(%rsp)
  2585d2:	lea    0x6f0(%rbx),%rax
  2585d9:	mov    %rax,0x78(%rsp)
  2585de:	lea    0x8e8(%rbx),%rax
  2585e5:	mov    %rax,0x228(%rsp)
  2585ed:	lea    0xa7e(%rbx),%rax
  2585f4:	mov    %rax,0x60(%rsp)
  2585f9:	lea    0x720(%rbx),%rax
  258600:	mov    %rax,0xf0(%rsp)
  258608:	lea    0x9a0(%rbx),%rax
  25860f:	mov    %rax,0xe0(%rsp)
  258617:	mov    %rbx,0x38(%rsp)
  25861c:	jmp    25863b <<glass::engine::Engine>::apply+0xfb>
  25861e:	xchg   %ax,%ax
  258620:	mov    0x110(%rsp),%rsi
  258628:	mov    0x240(%rsp),%rdx
  258630:	sub    0x18(%rsp),%rdx
  258635:	je     25a898 <<glass::engine::Engine>::apply+0x2358>
  25863b:	mov    %rsi,0x28(%rsp)
  258640:	cmp    $0x2000,%rdx
  258647:	mov    $0x2000,%eax
  25864c:	mov    %rdx,0x240(%rsp)
  258654:	cmovb  %rdx,%rax
  258658:	mov    %rax,0x18(%rsp)
  25865d:	mov    0x6d4(%rbx),%ebp
  258663:	mov    $0x1000,%eax
  258668:	and    %eax,%ebp
  25866a:	mov    0xa58(%rbx),%r9
  258671:	mov    $0x0,%r10d
  258677:	cmove  %r9,%r10
  25867b:	mov    0xa68(%rbx),%rax
  258682:	mov    %rax,%r11
  258685:	cmove  %r9,%r11
  258689:	mov    0x910(%rbx),%r13
  258690:	mov    $0x8,%r12d
  258696:	test   %r13,%r13
  258699:	je     2586fc <<glass::engine::Engine>::apply+0x1bc>
  25869b:	mov    %r11,0x58(%rsp)
  2586a0:	mov    %r10,0x10(%rsp)
  2586a5:	mov    %r9,0x8(%rsp)
  2586aa:	mov    0x908(%rbx),%r15
  2586b1:	lea    0x0(,%r13,8),%rax
  2586b9:	lea    (%rax,%rax,2),%r14
  2586bd:	mov    $0x8,%esi
  2586c2:	mov    %r14,%rdi
  2586c5:	call   *0x39a33d(%rip)        # 5f2a08 <_DYNAMIC+0x228>
  2586cb:	test   %rax,%rax
  2586ce:	je     25a995 <<glass::engine::Engine>::apply+0x2455>
  2586d4:	mov    %rax,%r12
  2586d7:	mov    %rax,%rdi
  2586da:	mov    %r15,%rsi
  2586dd:	mov    %r14,%rdx
  2586e0:	call   *0x39a32a(%rip)        # 5f2a10 <memcpy@GLIBC_2.14>
  2586e6:	mov    0xa68(%rbx),%rax
  2586ed:	mov    0x8(%rsp),%r9
  2586f2:	mov    0x10(%rsp),%r10
  2586f7:	mov    0x58(%rsp),%r11
  2586fc:	mov    0x18(%rsp),%r15
  258701:	mov    0x28(%rsp),%r14
  258706:	lea    (%r14,%r15,1),%rcx
  25870a:	mov    %rcx,0x110(%rsp)
  258712:	mov    0xa78(%rbx),%ecx
  258718:	mov    0xa60(%rbx),%rdx
  25871f:	movzbl 0xa7d(%rbx),%esi
  258726:	movzbl 0xa81(%rbx),%edi
  25872d:	mov    0x238(%rsp),%r8
  258735:	mov    %r8,0x1a8(%rsp)
  25873d:	movq   $0x0,0x140(%rsp)
  258749:	movq   $0x8,0x148(%rsp)
  258755:	movq   $0x0,0x150(%rsp)
  258761:	mov    %r13,0x158(%rsp)
  258769:	mov    %r12,0x160(%rsp)
  258771:	mov    %r13,0x168(%rsp)
  258779:	mov    %r11,0x1b0(%rsp)
  258781:	mov    %r10,0x1b8(%rsp)
  258789:	shr    $0xc,%ebp
  25878c:	mov    %bpl,0x1ec(%rsp)
  258794:	mov    %rax,0x1c0(%rsp)
  25879c:	mov    %ecx,0x1e8(%rsp)
  2587a3:	mov    %rdx,0x1c8(%rsp)
  2587ab:	mov    %sil,0x1ed(%rsp)
  2587b3:	mov    %r15,0x1d0(%rsp)
  2587bb:	movups (%rbx),%xmm0
  2587be:	movaps %xmm0,0x130(%rsp)
  2587c6:	movq   $0xffffffffffffffff,0x170(%rsp)
  2587d2:	mov    %r9,0x1d8(%rsp)
  2587da:	mov    %dil,0x1ee(%rsp)
  2587e2:	mov    0xa70(%rbx),%rax
  2587e9:	mov    %rax,0x1e0(%rsp)
  2587f1:	test   %dil,%dil
  2587f4:	mov    %rbx,%r12
  2587f7:	je     25a310 <<glass::engine::Engine>::apply+0x1dd0>
  2587fd:	mov    $0x3,%eax
  258802:	sub    %r15,%rax
  258805:	mov    %rax,0x230(%rsp)
  25880d:	mov    $0x1,%al
  25880f:	mov    %eax,0xdc(%rsp)
  258816:	xor    %ebp,%ebp
  258818:	mov    %r14,0x1f8(%rsp)
  258820:	mov    $0x1,%al
  258822:	mov    %eax,0x104(%rsp)
  258829:	movq   $0x0,0x8(%rsp)
  258832:	movl   $0x0,0xd0(%rsp)
  25883d:	movq   $0x0,0x58(%rsp)
  258846:	xor    %r13d,%r13d
  258849:	testb  $0x1,0xdc(%rsp)
  258851:	je     2588b0 <<glass::engine::Engine>::apply+0x370>
  258853:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258860:	mov    0x39aa39(%rip),%rax        # 5f32a0 <_DYNAMIC+0xac0>
  258867:	mov    (%rax),%rax
  25886a:	mov    $0x1b,%edi
  25886f:	mov    0x1f8(%rsp),%rsi
  258877:	mov    0x110(%rsp),%rdx
  25887f:	call   *%rax
  258881:	cmp    $0x1,%rax
  258885:	jne    2588b0 <<glass::engine::Engine>::apply+0x370>
  258887:	mov    %rdx,%rax
  25888a:	sub    0x28(%rsp),%rax
  25888f:	inc    %rdx
  258892:	mov    $0x1,%cl
  258894:	mov    %ecx,0xdc(%rsp)
  25889b:	mov    %rdx,0x1f8(%rsp)
  2588a3:	jmp    2588d9 <<glass::engine::Engine>::apply+0x399>
  2588a5:	data16 cs nopw 0x0(%rax,%rax,1)
  2588b0:	testb  $0x1,0x104(%rsp)
  2588b8:	je     25a380 <<glass::engine::Engine>::apply+0x1e40>
  2588be:	movl   $0x0,0x104(%rsp)
  2588c9:	mov    0x18(%rsp),%rax
  2588ce:	movl   $0x0,0xdc(%rsp)
  2588d9:	mov    %rax,%rdx
  2588dc:	sub    %r13,%rax
  2588df:	cmp    $0x18,%rax
  2588e3:	mov    %rdx,0x10(%rsp)
  2588e8:	jb     258f30 <<glass::engine::Engine>::apply+0x9f0>
  2588ee:	cmp    %rdx,0x18(%rsp)
  2588f3:	jae    258938 <<glass::engine::Engine>::apply+0x3f8>
  2588f5:	jmp    25a8f9 <<glass::engine::Engine>::apply+0x23b9>
  2588fa:	mov    0x58(%rsp),%rax
  2588ff:	mov    %eax,%ebp
  258901:	mov    0x38(%rsp),%rax
  258906:	cmpl   $0xffffffff,0x710(%rax)
  25890d:	je     258c96 <<glass::engine::Engine>::apply+0x756>
  258913:	mov    %ebp,%eax
  258915:	mov    %rax,0x58(%rsp)
  25891a:	nopw   0x0(%rax,%rax,1)
  258920:	mov    0x10(%rsp),%rdx
  258925:	mov    %rdx,%rax
  258928:	sub    %r13,%rax
  25892b:	mov    %r13,%rbp
  25892e:	cmp    $0x17,%rax
  258932:	jbe    258f33 <<glass::engine::Engine>::apply+0x9f3>
  258938:	lea    0xb0(%rsp),%rdi
  258940:	mov    0x28(%rsp),%rsi
  258945:	mov    %r13,%rcx
  258948:	call   2a1930 <glass::engine::next_run>
  25894d:	movzbl 0xc0(%rsp),%r12d
  258956:	cmp    $0x2,%r12b
  25895a:	je     258fc0 <<glass::engine::Engine>::apply+0xa80>
  258960:	mov    0xb0(%rsp),%rbx
  258968:	cmp    %rbp,%rbx
  25896b:	jb     25a8b6 <<glass::engine::Engine>::apply+0x2376>
  258971:	mov    0x18(%rsp),%r15
  258976:	cmp    %r15,%rbx
  258979:	ja     25a8c7 <<glass::engine::Engine>::apply+0x2387>
  25897f:	mov    0xb8(%rsp),%r13
  258987:	mov    0x28(%rsp),%rax
  25898c:	lea    (%rax,%rbp,1),%r15
  258990:	lea    (%rax,%rbx,1),%r14
  258994:	mov    0x39a8fd(%rip),%rax        # 5f3298 <_DYNAMIC+0xab8>
  25899b:	mov    (%rax),%rax
  25899e:	mov    $0x1b,%edi
  2589a3:	mov    %r15,%rsi
  2589a6:	mov    %r14,%rdx
  2589a9:	call   *%rax
  2589ab:	cmp    $0x1,%rax
  2589af:	jne    2589cd <<glass::engine::Engine>::apply+0x48d>
  2589b1:	sub    %r15,%rdx
  2589b4:	mov    0x38(%rsp),%rax
  2589b9:	movb   $0x1,0xa80(%rax)
  2589c0:	movb   $0x0,0xa7e(%rax)
  2589c7:	add    %rdx,%rbp
  2589ca:	inc    %rbp
  2589cd:	cmp    %rbx,%rbp
  2589d0:	jae    258a0e <<glass::engine::Engine>::apply+0x4ce>
  2589d2:	mov    0x60(%rsp),%rdi
  2589d7:	mov    0x28(%rsp),%rsi
  2589dc:	mov    0x18(%rsp),%rdx
  2589e1:	mov    %rbp,%rcx
  2589e4:	mov    %rbx,%r8
  2589e7:	call   270180 <<glass::engine::Mirror>::stretch>
  2589ec:	cmp    %rbx,%rax
  2589ef:	jae    258a0e <<glass::engine::Engine>::apply+0x4ce>
  2589f1:	mov    0x38(%rsp),%rax
  2589f6:	cmpb   $0x0,0xa80(%rax)
  2589fd:	jne    258a0e <<glass::engine::Engine>::apply+0x4ce>
  2589ff:	movzbl -0x1(%r14),%eax
  258a04:	shr    $0x7,%al
  258a07:	mov    0x60(%rsp),%rcx
  258a0c:	mov    %al,(%rcx)
  258a0e:	mov    0x60(%rsp),%rdi
  258a13:	mov    0x28(%rsp),%rsi
  258a18:	mov    0x18(%rsp),%rdx
  258a1d:	mov    %rbx,%rcx
  258a20:	mov    %r13,%r8
  258a23:	call   270180 <<glass::engine::Mirror>::stretch>
  258a28:	mov    %rax,%rbx
  258a2b:	mov    0x38(%rsp),%rax
  258a30:	cmpb   $0x0,0xa80(%rax)
  258a37:	jne    258920 <<glass::engine::Engine>::apply+0x3e0>
  258a3d:	lea    -0x1(%r13),%r14
  258a41:	cmp    0x18(%rsp),%r14
  258a46:	jae    25a944 <<glass::engine::Engine>::apply+0x2404>
  258a4c:	mov    0x28(%rsp),%rax
  258a51:	movzbl (%rax,%r14,1),%eax
  258a56:	shr    $0x7,%al
  258a59:	mov    0x60(%rsp),%rcx
  258a5e:	mov    %al,(%rcx)
  258a60:	test   %rbx,%rbx
  258a63:	je     258a92 <<glass::engine::Engine>::apply+0x552>
  258a65:	lea    -0x1(%rbx),%r14
  258a69:	cmp    0x18(%rsp),%r14
  258a6e:	jae    25a961 <<glass::engine::Engine>::apply+0x2421>
  258a74:	mov    0x28(%rsp),%rax
  258a79:	movzbl (%rax,%r14,1),%eax
  258a7e:	shr    $0x7,%al
  258a81:	mov    %r13,%r14
  258a84:	sub    %rbx,%r14
  258a87:	cmp    $0x18,%r14
  258a8b:	jae    258aae <<glass::engine::Engine>::apply+0x56e>
  258a8d:	jmp    258920 <<glass::engine::Engine>::apply+0x3e0>
  258a92:	mov    0x38(%rsp),%rax
  258a97:	movzbl 0xa7f(%rax),%eax
  258a9e:	mov    %r13,%r14
  258aa1:	sub    %rbx,%r14
  258aa4:	cmp    $0x18,%r14
  258aa8:	jb     258920 <<glass::engine::Engine>::apply+0x3e0>
  258aae:	test   %al,%al
  258ab0:	jne    258920 <<glass::engine::Engine>::apply+0x3e0>
  258ab6:	mov    %rbx,%r15
  258ab9:	sub    0x8(%rsp),%r15
  258abe:	jbe    2588fa <<glass::engine::Engine>::apply+0x3ba>
  258ac4:	movzbl 0x3a01ed(%rip),%eax        # 5f8cb8 <glass::engine::probes::RUN_PROBE>
  258acb:	mov    $0x1,%bpl
  258ace:	cmp    $0x68,%al
  258ad0:	je     258c7f <<glass::engine::Engine>::apply+0x73f>
  258ad6:	cmp    0x18(%rsp),%rbx
  258adb:	ja     25a90c <<glass::engine::Engine>::apply+0x23cc>
  258ae1:	mov    0x8(%rsp),%rax
  258ae6:	add    0x28(%rsp),%rax
  258aeb:	mov    %rax,0x8(%rsp)
  258af0:	cmpb   $0x1,0x58(%rsp)
  258af5:	jne    258b22 <<glass::engine::Engine>::apply+0x5e2>
  258af7:	mov    0x38(%rsp),%rax
  258afc:	cmpl   $0xffffffff,0x710(%rax)
  258b03:	jne    258b22 <<glass::engine::Engine>::apply+0x5e2>
  258b05:	lea    0x130(%rsp),%rdi
  258b0d:	mov    0x8(%rsp),%rsi
  258b12:	mov    %r15,%rdx
  258b15:	call   2a1c20 <glass::engine::plain_c0>
  258b1a:	test   %al,%al
  258b1c:	jne    258c7f <<glass::engine::Engine>::apply+0x73f>
  258b22:	movzbl 0x3a019f(%rip),%eax        # 5f8cc8 <glass::engine::timers::ON>
  258b29:	test   %al,%al
  258b2b:	je     258d5f <<glass::engine::Engine>::apply+0x81f>
  258b31:	mov    $0x1,%edi
  258b36:	call   50fa40 <<std::sys::pal::unix::time::Timespec>::now>
  258b3b:	mov    %rax,0x58(%rsp)
  258b40:	mov    %edx,0x30(%rsp)
  258b44:	xor    %ebp,%ebp
  258b46:	cs nopw 0x0(%rax,%rax,1)
  258b50:	mov    0x38(%rsp),%rax
  258b55:	cmpl   $0xffffffff,0x710(%rax)
  258b5c:	jne    258bb7 <<glass::engine::Engine>::apply+0x677>
  258b5e:	mov    0x78(%rsp),%rax
  258b63:	mov    %rax,0x80(%rsp)
  258b6b:	lea    0x130(%rsp),%rax
  258b73:	mov    %rax,0x88(%rsp)
  258b7b:	movb   $0x0,0x90(%rsp)
  258b83:	mov    %r15,%rcx
  258b86:	sub    %rbp,%rcx
  258b89:	jb     25a8aa <<glass::engine::Engine>::apply+0x236a>
  258b8f:	mov    0x8(%rsp),%rax
  258b94:	lea    (%rax,%rbp,1),%rdx
  258b98:	mov    0xf0(%rsp),%rdi
  258ba0:	lea    0x80(%rsp),%rsi
  258ba8:	call   1a0870 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258bad:	add    %rax,%rbp
  258bb0:	cmp    %r15,%rbp
  258bb3:	jne    258b50 <<glass::engine::Engine>::apply+0x610>
  258bb5:	jmp    258be0 <<glass::engine::Engine>::apply+0x6a0>
  258bb7:	mov    %r15,%rcx
  258bba:	sub    %rbp,%rcx
  258bbd:	jb     25a9b6 <<glass::engine::Engine>::apply+0x2476>
  258bc3:	mov    0x8(%rsp),%rax
  258bc8:	lea    (%rax,%rbp,1),%rdx
  258bcc:	mov    0x78(%rsp),%rdi
  258bd1:	lea    0x130(%rsp),%rsi
  258bd9:	call   1945d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258bde:	jmp    258bad <<glass::engine::Engine>::apply+0x66d>
  258be0:	movzbl 0x3a00e1(%rip),%eax        # 5f8cc8 <glass::engine::timers::ON>
  258be7:	test   %al,%al
  258be9:	mov    $0x1,%bpl
  258bec:	je     258c7f <<glass::engine::Engine>::apply+0x73f>
  258bf2:	mov    $0x1,%edi
  258bf7:	call   50fa40 <<std::sys::pal::unix::time::Timespec>::now>
  258bfc:	mov    %rax,0x200(%rsp)
  258c04:	mov    %edx,0x208(%rsp)
  258c0b:	mov    0x58(%rsp),%rax
  258c10:	mov    %rax,0x210(%rsp)
  258c18:	mov    0x30(%rsp),%eax
  258c1c:	mov    %eax,0x218(%rsp)
  258c23:	lea    0x80(%rsp),%rdi
  258c2b:	lea    0x200(%rsp),%rsi
  258c33:	lea    0x210(%rsp),%rdx
  258c3b:	call   50f980 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258c40:	imul   $0x3b9aca00,0x88(%rsp),%rax
  258c4c:	mov    0x90(%rsp),%ecx
  258c53:	add    %rcx,%rax
  258c56:	cmpb   $0x0,0x80(%rsp)
  258c5e:	mov    $0x0,%ecx
  258c63:	cmove  %rax,%rcx
  258c67:	lock add %rcx,0x3a0069(%rip)        # 5f8cd8 <glass::engine::timers::VTE_NS>
  258c6f:	lock incq 0x3a0091(%rip)        # 5f8d08 <glass::engine::timers::VTE_CALLS>
  258c77:	lock add %r15,0x3a0081(%rip)        # 5f8d00 <glass::engine::timers::VTE_BYTES>
  258c7f:	mov    %rbx,0x8(%rsp)
  258c84:	mov    0x38(%rsp),%rax
  258c89:	cmpl   $0xffffffff,0x710(%rax)
  258c90:	jne    258913 <<glass::engine::Engine>::apply+0x3d3>
  258c96:	cmp    0x18(%rsp),%r13
  258c9b:	ja     25a8e5 <<glass::engine::Engine>::apply+0x23a5>
  258ca1:	cmp    %rbx,%r13
  258ca4:	jb     25a8e5 <<glass::engine::Engine>::apply+0x23a5>
  258caa:	movzbl 0x3a0006(%rip),%r15d        # 5f8cb8 <glass::engine::probes::RUN_PROBE>
  258cb2:	movzbl 0x3a000f(%rip),%eax        # 5f8cc8 <glass::engine::timers::ON>
  258cb9:	test   %al,%al
  258cbb:	je     258cec <<glass::engine::Engine>::apply+0x7ac>
  258cbd:	mov    $0x1,%edi
  258cc2:	call   50fa40 <<std::sys::pal::unix::time::Timespec>::now>
  258cc7:	mov    %rax,0x58(%rsp)
  258ccc:	mov    %edx,%ebp
  258cce:	cmp    $0x63,%r15b
  258cd2:	jbe    258cf7 <<glass::engine::Engine>::apply+0x7b7>
  258cd4:	movzbl %r12b,%eax
  258cd8:	mov    %r14,%rbx
  258cdb:	sub    %rax,%rbx
  258cde:	cmp    $0xffffffff,%ebp
  258ce1:	jne    258e6a <<glass::engine::Engine>::apply+0x92a>
  258ce7:	jmp    258f02 <<glass::engine::Engine>::apply+0x9c2>
  258cec:	mov    $0xffffffff,%ebp
  258cf1:	cmp    $0x63,%r15b
  258cf5:	ja     258cd4 <<glass::engine::Engine>::apply+0x794>
  258cf7:	mov    0x39ccc3(%rip),%eax        # 5f59c0 <glass::engine::run_whole::ON>
  258cfd:	test   %eax,%eax
  258cff:	jne    258f21 <<glass::engine::Engine>::apply+0x9e1>
  258d05:	mov    0x28(%rsp),%rax
  258d0a:	lea    (%rax,%rbx,1),%rsi
  258d0e:	cmpb   $0x0,0x39ccaf(%rip)        # 5f59c4 <glass::engine::run_whole::ON+0x4>
  258d15:	je     258d36 <<glass::engine::Engine>::apply+0x7f6>
  258d17:	test   $0x1,%r12b
  258d1b:	je     258e1f <<glass::engine::Engine>::apply+0x8df>
  258d21:	lea    0x130(%rsp),%rdi
  258d29:	mov    %r14,%rdx
  258d2c:	call   264f40 <<glass::engine::Watch>::print_run>
  258d31:	jmp    258e2f <<glass::engine::Engine>::apply+0x8ef>
  258d36:	test   $0x1,%r12b
  258d3a:	je     258e4e <<glass::engine::Engine>::apply+0x90e>
  258d40:	cmp    %rbx,%r13
  258d43:	je     25a922 <<glass::engine::Engine>::apply+0x23e2>
  258d49:	lea    -0x1(%r14),%rdx
  258d4d:	lea    0x130(%rsp),%rdi
  258d55:	call   264f40 <<glass::engine::Watch>::print_run>
  258d5a:	jmp    258e5e <<glass::engine::Engine>::apply+0x91e>
  258d5f:	xor    %ebp,%ebp
  258d61:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  258d70:	mov    0x38(%rsp),%rax
  258d75:	cmpl   $0xffffffff,0x710(%rax)
  258d7c:	jne    258dd7 <<glass::engine::Engine>::apply+0x897>
  258d7e:	mov    0x78(%rsp),%rax
  258d83:	mov    %rax,0x80(%rsp)
  258d8b:	lea    0x130(%rsp),%rax
  258d93:	mov    %rax,0x88(%rsp)
  258d9b:	movb   $0x0,0x90(%rsp)
  258da3:	mov    %r15,%rcx
  258da6:	sub    %rbp,%rcx
  258da9:	jb     25a8aa <<glass::engine::Engine>::apply+0x236a>
  258daf:	mov    0x8(%rsp),%rax
  258db4:	lea    (%rax,%rbp,1),%rdx
  258db8:	mov    0xf0(%rsp),%rdi
  258dc0:	lea    0x80(%rsp),%rsi
  258dc8:	call   1a0870 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  258dcd:	add    %rax,%rbp
  258dd0:	cmp    %r15,%rbp
  258dd3:	jne    258d70 <<glass::engine::Engine>::apply+0x830>
  258dd5:	jmp    258e00 <<glass::engine::Engine>::apply+0x8c0>
  258dd7:	mov    %r15,%rcx
  258dda:	sub    %rbp,%rcx
  258ddd:	jb     25a9b6 <<glass::engine::Engine>::apply+0x2476>
  258de3:	mov    0x8(%rsp),%rax
  258de8:	lea    (%rax,%rbp,1),%rdx
  258dec:	mov    0x78(%rsp),%rdi
  258df1:	lea    0x130(%rsp),%rsi
  258df9:	call   1945d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  258dfe:	jmp    258dcd <<glass::engine::Engine>::apply+0x88d>
  258e00:	mov    %rbx,0x8(%rsp)
  258e05:	mov    $0x1,%bpl
  258e08:	mov    0x38(%rsp),%rax
  258e0d:	cmpl   $0xffffffff,0x710(%rax)
  258e14:	jne    258913 <<glass::engine::Engine>::apply+0x3d3>
  258e1a:	jmp    258c96 <<glass::engine::Engine>::apply+0x756>
  258e1f:	lea    0x130(%rsp),%rdi
  258e27:	mov    %r14,%rdx
  258e2a:	call   2625a0 <<glass::engine::Watch>::print_utf8>
  258e2f:	mov    %rax,%rbx
  258e32:	mov    0x1e0(%rsp),%eax
  258e39:	mov    0x38(%rsp),%rcx
  258e3e:	mov    %eax,0x718(%rcx)
  258e44:	cmp    $0xffffffff,%ebp
  258e47:	jne    258e6a <<glass::engine::Engine>::apply+0x92a>
  258e49:	jmp    258f02 <<glass::engine::Engine>::apply+0x9c2>
  258e4e:	lea    0x130(%rsp),%rdi
  258e56:	mov    %r14,%rdx
  258e59:	call   2625a0 <<glass::engine::Watch>::print_utf8>
  258e5e:	mov    %rax,%rbx
  258e61:	cmp    $0xffffffff,%ebp
  258e64:	je     258f02 <<glass::engine::Engine>::apply+0x9c2>
  258e6a:	movzbl 0x39fe57(%rip),%eax        # 5f8cc8 <glass::engine::timers::ON>
  258e71:	test   %al,%al
  258e73:	je     258efa <<glass::engine::Engine>::apply+0x9ba>
  258e79:	mov    $0x1,%edi
  258e7e:	call   50fa40 <<std::sys::pal::unix::time::Timespec>::now>
  258e83:	mov    %rax,0x200(%rsp)
  258e8b:	mov    %edx,0x208(%rsp)
  258e92:	mov    0x58(%rsp),%rax
  258e97:	mov    %rax,0x210(%rsp)
  258e9f:	mov    %ebp,0x218(%rsp)
  258ea6:	lea    0x80(%rsp),%rdi
  258eae:	lea    0x200(%rsp),%rsi
  258eb6:	lea    0x210(%rsp),%rdx
  258ebe:	call   50f980 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  258ec3:	imul   $0x3b9aca00,0x88(%rsp),%rax
  258ecf:	mov    0x90(%rsp),%ecx
  258ed6:	add    %rcx,%rax
  258ed9:	cmpb   $0x0,0x80(%rsp)
  258ee1:	mov    $0x0,%ecx
  258ee6:	cmove  %rax,%rcx
  258eea:	lock add %rcx,0x39fdde(%rip)        # 5f8cd0 <glass::engine::timers::RUN_NS>
  258ef2:	lock incq 0x39fdfe(%rip)        # 5f8cf8 <glass::engine::timers::RUN_CALLS>
  258efa:	lock add %r14,0x39fdee(%rip)        # 5f8cf0 <glass::engine::timers::RUN_BYTES>
  258f02:	movzbl 0x39fe0f(%rip),%eax        # 5f8d18 <glass::engine::counters::COUNTING>
  258f09:	test   %al,%al
  258f0b:	je     258f15 <<glass::engine::Engine>::apply+0x9d5>
  258f0d:	lock add %rbx,0x39fdfb(%rip)        # 5f8d10 <glass::engine::counters::LANE_RUN_BYTES>
  258f15:	add    %rbx,0x8(%rsp)
  258f1a:	mov    $0x1,%al
  258f1c:	jmp    258915 <<glass::engine::Engine>::apply+0x3d5>
  258f21:	call   18bc06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  258f26:	jmp    258d05 <<glass::engine::Engine>::apply+0x7c5>
  258f2b:	nopl   0x0(%rax,%rax,1)
  258f30:	mov    %rbp,%r13
  258f33:	mov    $0x1,%ebx
  258f38:	mov    0x18(%rsp),%rax
  258f3d:	sub    %rdx,%rax
  258f40:	jbe    258fdb <<glass::engine::Engine>::apply+0xa9b>
  258f46:	mov    0x8(%rsp),%rcx
  258f4b:	cmp    %rcx,0xe8(%rsp)
  258f53:	sete   %r9b
  258f57:	cmp    $0x2,%rax
  258f5b:	mov    0x38(%rsp),%r12
  258f60:	jb     258fb0 <<glass::engine::Engine>::apply+0xa70>
  258f62:	mov    0x28(%rsp),%rcx
  258f67:	mov    0x10(%rsp),%rdx
  258f6c:	lea    (%rcx,%rdx,1),%rbp
  258f70:	cmpb   $0x5b,0x1(%rbp)
  258f74:	jne    258fb0 <<glass::engine::Engine>::apply+0xa70>
  258f76:	xorps  %xmm0,%xmm0
  258f79:	movaps %xmm0,0x90(%rsp)
  258f81:	movaps %xmm0,0x80(%rsp)
  258f89:	cmp    $0x2,%rax
  258f8d:	je     258fb0 <<glass::engine::Engine>::apply+0xa70>
  258f8f:	movzbl 0x2(%rbp),%ecx
  258f93:	lea    -0x30(%rcx),%eax
  258f96:	cmp    $0xa,%al
  258f98:	jae    259001 <<glass::engine::Engine>::apply+0xac1>
  258f9a:	movzbl %al,%eax
  258f9d:	xor    %r14d,%r14d
  258fa0:	mov    0x10(%rsp),%rcx
  258fa5:	add    $0x3,%rcx
  258fa9:	cmp    0x18(%rsp),%rcx
  258fae:	jne    259027 <<glass::engine::Engine>::apply+0xae7>
  258fb0:	movl   $0x0,0xd0(%rsp)
  258fbb:	jmp    258fe0 <<glass::engine::Engine>::apply+0xaa0>
  258fbd:	nopl   (%rax)
  258fc0:	mov    %rbp,%r13
  258fc3:	mov    0x10(%rsp),%rdx
  258fc8:	mov    $0x1,%ebx
  258fcd:	mov    0x18(%rsp),%rax
  258fd2:	sub    %rdx,%rax
  258fd5:	ja     258f46 <<glass::engine::Engine>::apply+0xa06>
  258fdb:	mov    0x38(%rsp),%r12
  258fe0:	mov    0x10(%rsp),%r8
  258fe5:	add    %r8,%rbx
  258fe8:	mov    %r13,%rbp
  258feb:	mov    %rbx,%r13
  258fee:	testb  $0x1,0xdc(%rsp)
  258ff6:	je     2588b0 <<glass::engine::Engine>::apply+0x370>
  258ffc:	jmp    258860 <<glass::engine::Engine>::apply+0x320>
  259001:	movzbl %cl,%edx
  259004:	xor    %eax,%eax
  259006:	lea    -0x48(%rdx),%esi
  259009:	cmp    $0x25,%esi
  25900c:	ja     259040 <<glass::engine::Engine>::apply+0xb00>
  25900e:	mov    $0x3,%r8d
  259014:	lea    -0x1ea793(%rip),%rdi        # 6e888 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2cd7>
  25901b:	movslq (%rdi,%rsi,4),%rdx
  25901f:	add    %rdi,%rdx
  259022:	xor    %r14d,%r14d
  259025:	jmp    *%rdx
  259027:	mov    0x10(%rsp),%rcx
  25902c:	mov    0x230(%rsp),%rdx
  259034:	lea    (%rdx,%rcx,1),%rsi
  259038:	mov    $0x4,%r8d
  25903e:	jmp    259083 <<glass::engine::Engine>::apply+0xb43>
  259040:	mov    $0x1,%r14d
  259046:	cmp    $0x3b,%edx
  259049:	je     258fa0 <<glass::engine::Engine>::apply+0xa60>
  25904f:	jmp    258fb0 <<glass::engine::Engine>::apply+0xa70>
  259054:	mov    $0xffff,%cx
  259058:	nopl   0x0(%rax,%rax,1)
  259060:	movzbl %dil,%eax
  259064:	add    %cx,%ax
  259067:	mov    $0xffff,%ecx
  25906c:	cmovb  %ecx,%eax
  25906f:	lea    (%rsi,%r8,1),%rcx
  259073:	inc    %rcx
  259076:	inc    %r8
  259079:	cmp    $0x4,%rcx
  25907d:	je     258fb0 <<glass::engine::Engine>::apply+0xa70>
  259083:	movzbl -0x1(%rbp,%r8,1),%ecx
  259089:	lea    -0x30(%rcx),%edi
  25908c:	cmp    $0xa,%dil
  259090:	jae    2590a0 <<glass::engine::Engine>::apply+0xb60>
  259092:	mov    $0xa,%cx
  259096:	mul    %cx
  259099:	jo     259054 <<glass::engine::Engine>::apply+0xb14>
  25909b:	mov    %eax,%ecx
  25909d:	jmp    259060 <<glass::engine::Engine>::apply+0xb20>
  25909f:	nop
  2590a0:	movzbl %cl,%edx
  2590a3:	cmp    $0x3b,%edx
  2590a6:	jne    2590e3 <<glass::engine::Engine>::apply+0xba3>
  2590a8:	lea    0x1(%r14),%rcx
  2590ac:	cmp    $0x10,%rcx
  2590b0:	jae    258fb0 <<glass::engine::Engine>::apply+0xa70>
  2590b6:	cmp    $0xf,%r14
  2590ba:	ja     25a97b <<glass::engine::Engine>::apply+0x243b>
  2590c0:	mov    %ax,0x80(%rsp,%r14,2)
  2590c9:	xor    %eax,%eax
  2590cb:	mov    %rcx,%r14
  2590ce:	lea    (%rsi,%r8,1),%rcx
  2590d2:	inc    %rcx
  2590d5:	inc    %r8
  2590d8:	cmp    $0x4,%rcx
  2590dc:	jne    259083 <<glass::engine::Engine>::apply+0xb43>
  2590de:	jmp    258fb0 <<glass::engine::Engine>::apply+0xa70>
  2590e3:	add    $0xffffffb8,%edx
  2590e6:	cmp    $0x25,%edx
  2590e9:	ja     258fb0 <<glass::engine::Engine>::apply+0xa70>
  2590ef:	lea    -0x1ea7d6(%rip),%rsi        # 6e920 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d6f>
  2590f6:	movslq (%rsi,%rdx,4),%rdx
  2590fa:	add    %rsi,%rdx
  2590fd:	jmp    *%rdx
  2590ff:	cmp    $0x10,%r14
  259103:	jae    25a9a3 <<glass::engine::Engine>::apply+0x2463>
  259109:	mov    %r8,0x120(%rsp)
  259111:	mov    %ax,0x80(%rsp,%r14,2)
  25911a:	cmp    $0x6d,%cl
  25911d:	setne  %cl
  259120:	movaps 0x80(%rsp),%xmm0
  259128:	movaps 0x90(%rsp),%xmm1
  259130:	movaps %xmm0,0xb0(%rsp)
  259138:	movaps %xmm1,0xc0(%rsp)
  259140:	xor    %edx,%edx
  259142:	jmp    259183 <<glass::engine::Engine>::apply+0xc43>
  259144:	cmp    $0x10,%r14
  259148:	jae    25a9c5 <<glass::engine::Engine>::apply+0x2485>
  25914e:	mov    %r8,0x120(%rsp)
  259156:	mov    %ax,0x80(%rsp,%r14,2)
  25915f:	movaps 0x80(%rsp),%xmm0
  259167:	movaps 0x90(%rsp),%xmm1
  25916f:	movaps %xmm0,0xb0(%rsp)
  259177:	movaps %xmm1,0xc0(%rsp)
  25917f:	mov    $0x1,%dl
  259181:	xor    %ecx,%ecx
  259183:	lea    0x1(%r14),%rax
  259187:	movaps 0xb0(%rsp),%xmm0
  25918f:	movaps 0xc0(%rsp),%xmm1
  259197:	movaps %xmm1,0x90(%rsp)
  25919f:	movaps %xmm0,0x80(%rsp)
  2591a7:	mov    %rax,0xa0(%rsp)
  2591af:	mov    %cl,0xa8(%rsp)
  2591b6:	mov    %dl,0xa9(%rsp)
  2591bd:	mov    0x10(%rsp),%r8
  2591c2:	cmp    %r13,%r8
  2591c5:	jb     25a937 <<glass::engine::Engine>::apply+0x23f7>
  2591cb:	mov    %r9b,0x30(%rsp)
  2591d0:	mov    %edx,0x12c(%rsp)
  2591d7:	mov    %ecx,0x128(%rsp)
  2591de:	mov    0x28(%rsp),%rax
  2591e3:	lea    (%rax,%r13,1),%r15
  2591e7:	mov    0x39a0aa(%rip),%rax        # 5f3298 <_DYNAMIC+0xab8>
  2591ee:	mov    (%rax),%rax
  2591f1:	mov    $0x1b,%edi
  2591f6:	mov    %r15,%rsi
  2591f9:	mov    %rbp,%rdx
  2591fc:	call   *%rax
  2591fe:	cmp    $0x1,%rax
  259202:	jne    25921f <<glass::engine::Engine>::apply+0xcdf>
  259204:	sub    %r15,%rdx
  259207:	movb   $0x1,0xa80(%r12)
  259210:	movb   $0x0,0xa7e(%r12)
  259219:	add    %rdx,%r13
  25921c:	inc    %r13
  25921f:	mov    0x10(%rsp),%r8
  259224:	cmp    %r8,%r13
  259227:	jae    259279 <<glass::engine::Engine>::apply+0xd39>
  259229:	mov    0x60(%rsp),%rdi
  25922e:	mov    0x28(%rsp),%rsi
  259233:	mov    0x18(%rsp),%rdx
  259238:	mov    %r13,%rcx
  25923b:	call   270180 <<glass::engine::Mirror>::stretch>
  259240:	movzbl 0xa80(%r12),%ecx
  259249:	test   %cl,%cl
  25924b:	setne  %dl
  25924e:	mov    0x10(%rsp),%r8
  259253:	cmp    %r8,%rax
  259256:	setae  %al
  259259:	or     %dl,%al
  25925b:	jne    259282 <<glass::engine::Engine>::apply+0xd42>
  25925d:	movzbl -0x1(%rbp),%eax
  259261:	shr    $0x7,%al
  259264:	mov    0x60(%rsp),%rcx
  259269:	mov    %al,(%rcx)
  25926b:	mov    0x28(%rsp),%r9
  259270:	test   %al,%al
  259272:	jne    25929f <<glass::engine::Engine>::apply+0xd5f>
  259274:	jmp    259370 <<glass::engine::Engine>::apply+0xe30>
  259279:	movzbl 0xa80(%r12),%ecx
  259282:	test   %cl,%cl
  259284:	mov    0x28(%rsp),%r9
  259289:	jne    2595bc <<glass::engine::Engine>::apply+0x107c>
  25928f:	mov    0x60(%rsp),%rax
  259294:	movzbl (%rax),%eax
  259297:	test   %al,%al
  259299:	je     259370 <<glass::engine::Engine>::apply+0xe30>
  25929f:	mov    0x10(%rsp),%r8
  2592a4:	test   %r8,%r8
  2592a7:	je     2595bc <<glass::engine::Engine>::apply+0x107c>
  2592ad:	cmpb   $0xc0,-0x1(%rbp)
  2592b1:	jge    2592f3 <<glass::engine::Engine>::apply+0xdb3>
  2592b3:	cmp    $0x1,%r8
  2592b7:	je     2595bc <<glass::engine::Engine>::apply+0x107c>
  2592bd:	cmpb   $0xbf,-0x2(%rbp)
  2592c1:	jg     25940d <<glass::engine::Engine>::apply+0xecd>
  2592c7:	cmp    $0x2,%r8
  2592cb:	je     2595bc <<glass::engine::Engine>::apply+0x107c>
  2592d1:	cmpb   $0xbf,-0x3(%rbp)
  2592d5:	jg     259ad7 <<glass::engine::Engine>::apply+0x1597>
  2592db:	cmp    $0x3,%r8
  2592df:	je     2595bc <<glass::engine::Engine>::apply+0x107c>
  2592e5:	cmpb   $0xc0,-0x4(%rbp)
  2592e9:	setl   %al
  2592ec:	mov    $0x3,%edx
  2592f1:	jmp    2592f7 <<glass::engine::Engine>::apply+0xdb7>
  2592f3:	xor    %edx,%edx
  2592f5:	xor    %eax,%eax
  2592f7:	test   %al,%al
  2592f9:	jne    259366 <<glass::engine::Engine>::apply+0xe26>
  2592fb:	mov    %rdx,%rsi
  2592fe:	not    %rsi
  259301:	add    0x10(%rsp),%rsi
  259306:	jae    25a9d8 <<glass::engine::Engine>::apply+0x2498>
  25930c:	movzbl (%r9,%rsi,1),%eax
  259311:	mov    $0x1,%ecx
  259316:	test   %al,%al
  259318:	jns    259344 <<glass::engine::Engine>::apply+0xe04>
  25931a:	lea    0x3e(%rax),%edi
  25931d:	mov    $0x2,%ecx
  259322:	cmp    $0x1e,%dil
  259326:	jb     259344 <<glass::engine::Engine>::apply+0xe04>
  259328:	mov    %eax,%edi
  25932a:	and    $0xf0,%dil
  25932e:	mov    $0x3,%ecx
  259333:	cmp    $0xe0,%dil
  259337:	je     259344 <<glass::engine::Engine>::apply+0xe04>
  259339:	add    $0x10,%al
  25933b:	mov    $0x4,%ecx
  259340:	cmp    $0x4,%al
  259342:	ja     259366 <<glass::engine::Engine>::apply+0xe26>
  259344:	inc    %rdx
  259347:	cmp    %ecx,%edx
  259349:	jne    259366 <<glass::engine::Engine>::apply+0xe26>
  25934b:	add    %r9,%rsi
  25934e:	lea    0xb0(%rsp),%rdi
  259356:	call   *0x399774(%rip)        # 5f2ad0 <_DYNAMIC+0x2f0>
  25935c:	cmpb   $0x0,0xb0(%rsp)
  259364:	je     259370 <<glass::engine::Engine>::apply+0xe30>
  259366:	mov    0x10(%rsp),%r8
  25936b:	jmp    2595bc <<glass::engine::Engine>::apply+0x107c>
  259370:	mov    0x10(%rsp),%r8
  259375:	mov    %r8,%rbp
  259378:	sub    0x8(%rsp),%rbp
  25937d:	jbe    2595b1 <<glass::engine::Engine>::apply+0x1071>
  259383:	mov    0x39c637(%rip),%eax        # 5f59c0 <glass::engine::run_whole::ON>
  259389:	test   %eax,%eax
  25938b:	jne    259ae1 <<glass::engine::Engine>::apply+0x15a1>
  259391:	mov    0xd0(%rsp),%ecx
  259398:	and    0x30(%rsp),%cl
  25939c:	movzbl 0x39c621(%rip),%eax        # 5f59c4 <glass::engine::run_whole::ON+0x4>
  2593a3:	xor    $0x1,%rax
  2593a7:	cmp    %rax,%rbp
  2593aa:	seta   %al
  2593ad:	and    %cl,%al
  2593af:	cmp    $0x1,%al
  2593b1:	jne    259403 <<glass::engine::Engine>::apply+0xec3>
  2593b3:	mov    0x8(%rsp),%rcx
  2593b8:	mov    %rcx,%rax
  2593bb:	cmp    %rcx,0x10(%rsp)
  2593c0:	mov    0x28(%rsp),%rdx
  2593c5:	je     2593e6 <<glass::engine::Engine>::apply+0xea6>
  2593c7:	nopw   0x0(%rax,%rax,1)
  2593d0:	movzbl (%rdx,%rax,1),%ecx
  2593d4:	add    $0xe0,%cl
  2593d7:	cmp    $0x5f,%cl
  2593da:	jae    2593f1 <<glass::engine::Engine>::apply+0xeb1>
  2593dc:	inc    %rax
  2593df:	cmp    %rax,0x10(%rsp)
  2593e4:	jne    2593d0 <<glass::engine::Engine>::apply+0xe90>
  2593e6:	cmpl   $0xffffffff,0x710(%r12)
  2593ef:	je     259417 <<glass::engine::Engine>::apply+0xed7>
  2593f1:	mov    0x10(%rsp),%r8
  2593f6:	mov    0xe8(%rsp),%r13
  2593fe:	jmp    2594f5 <<glass::engine::Engine>::apply+0xfb5>
  259403:	mov    0x8(%rsp),%r13
  259408:	jmp    2594eb <<glass::engine::Engine>::apply+0xfab>
  25940d:	mov    $0x1,%edx
  259412:	jmp    2592f5 <<glass::engine::Engine>::apply+0xdb5>
  259417:	mov    0x39c5a3(%rip),%eax        # 5f59c0 <glass::engine::run_whole::ON>
  25941d:	test   %eax,%eax
  25941f:	jne    259aeb <<glass::engine::Engine>::apply+0x15ab>
  259425:	mov    0x8(%rsp),%rax
  25942a:	add    0x28(%rsp),%rax
  25942f:	mov    %rax,0x8(%rsp)
  259434:	movzbl 0x39c589(%rip),%eax        # 5f59c4 <glass::engine::run_whole::ON+0x4>
  25943b:	xor    $0x1,%rax
  25943f:	sub    %rax,%rbp
  259442:	cmp    $0x1,%rbp
  259446:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259448:	cmpb   $0x1,0x1ee(%rsp)
  259450:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259452:	cmpq   $0x0,0x168(%rsp)
  25945b:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  25945d:	mov    0x1a8(%rsp),%r13
  259465:	testb  $0x4,0x6c5(%r13)
  25946d:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  25946f:	cmpq   $0x0,0x50(%r13)
  259474:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259476:	movzwl 0x64(%r13),%eax
  25947b:	test   $0x460,%eax
  259480:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259482:	cmpb   $0x0,0x68(%r13)
  259487:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259489:	cmpb   $0x0,0x69(%r13)
  25948e:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259490:	cmpb   $0x0,0x6a(%r13)
  259495:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259497:	cmpb   $0x0,0x6b(%r13)
  25949c:	je     259af5 <<glass::engine::Engine>::apply+0x15b5>
  2594a2:	lea    0x130(%rsp),%rdi
  2594aa:	mov    0x8(%rsp),%rsi
  2594af:	mov    %rbp,%rdx
  2594b2:	call   264f40 <<glass::engine::Watch>::print_run>
  2594b7:	mov    %rax,%r15
  2594ba:	mov    0x39c500(%rip),%eax        # 5f59c0 <glass::engine::run_whole::ON>
  2594c0:	test   %eax,%eax
  2594c2:	jne    25a2fd <<glass::engine::Engine>::apply+0x1dbd>
  2594c8:	cmpb   $0x0,0x39c4f5(%rip)        # 5f59c4 <glass::engine::run_whole::ON+0x4>
  2594cf:	je     2594e0 <<glass::engine::Engine>::apply+0xfa0>
  2594d1:	mov    0x1e0(%rsp),%eax
  2594d8:	mov    %eax,0x718(%r12)
  2594e0:	mov    0xe8(%rsp),%r13
  2594e8:	add    %r15,%r13
  2594eb:	mov    0x28(%rsp),%rdx
  2594f0:	mov    0x10(%rsp),%r8
  2594f5:	cmp    %r13,%r8
  2594f8:	jb     25a94d <<glass::engine::Engine>::apply+0x240d>
  2594fe:	mov    %r8,%r15
  259501:	mov    %r8,0x8(%rsp)
  259506:	sub    %r13,%r15
  259509:	je     2595b1 <<glass::engine::Engine>::apply+0x1071>
  25950f:	add    %rdx,%r13
  259512:	xor    %ebp,%ebp
  259514:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  259520:	cmpl   $0xffffffff,0x710(%r12)
  259529:	jne    259586 <<glass::engine::Engine>::apply+0x1046>
  25952b:	mov    0x78(%rsp),%rax
  259530:	mov    %rax,0xb0(%rsp)
  259538:	lea    0x130(%rsp),%rax
  259540:	mov    %rax,0xb8(%rsp)
  259548:	movb   $0x0,0xc0(%rsp)
  259550:	mov    %r15,%rcx
  259553:	sub    %rbp,%rcx
  259556:	jb     25a8aa <<glass::engine::Engine>::apply+0x236a>
  25955c:	mov    %r13,%rdx
  25955f:	add    %rbp,%rdx
  259562:	mov    0xf0(%rsp),%rdi
  25956a:	lea    0xb0(%rsp),%rsi
  259572:	call   1a0870 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  259577:	add    %rax,%rbp
  25957a:	cmp    %r15,%rbp
  25957d:	mov    0x10(%rsp),%r8
  259582:	jne    259520 <<glass::engine::Engine>::apply+0xfe0>
  259584:	jmp    2595ac <<glass::engine::Engine>::apply+0x106c>
  259586:	mov    %r15,%rcx
  259589:	sub    %rbp,%rcx
  25958c:	jb     25a9b6 <<glass::engine::Engine>::apply+0x2476>
  259592:	mov    %r13,%rdx
  259595:	add    %rbp,%rdx
  259598:	mov    0x78(%rsp),%rdi
  25959d:	lea    0x130(%rsp),%rsi
  2595a5:	call   1945d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  2595aa:	jmp    259577 <<glass::engine::Engine>::apply+0x1037>
  2595ac:	mov    %r8,0x8(%rsp)
  2595b1:	cmpl   $0xffffffff,0x710(%r12)
  2595ba:	je     2595cf <<glass::engine::Engine>::apply+0x108f>
  2595bc:	movl   $0x0,0xd0(%rsp)
  2595c7:	mov    %r8,%r13
  2595ca:	jmp    258fe5 <<glass::engine::Engine>::apply+0xaa5>
  2595cf:	cmpb   $0x0,0x12c(%rsp)
  2595d7:	je     259619 <<glass::engine::Engine>::apply+0x10d9>
  2595d9:	mov    0x1e0(%rsp),%ebx
  2595e0:	cmp    $0xffffffff,%ebx
  2595e3:	je     259a45 <<glass::engine::Engine>::apply+0x1505>
  2595e9:	mov    0x80(%rsp),%ebp
  2595f0:	cmp    $0x1,%bp
  2595f4:	adc    $0x0,%ebp
  2595f7:	nopw   0x0(%rax,%rax,1)
  259600:	lea    0x130(%rsp),%rdi
  259608:	mov    %ebx,%esi
  25960a:	call   33d3b0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  25960f:	dec    %bp
  259612:	jne    259600 <<glass::engine::Engine>::apply+0x10c0>
  259614:	jmp    259a92 <<glass::engine::Engine>::apply+0x1552>
  259619:	cmpb   $0x0,0x128(%rsp)
  259621:	je     259651 <<glass::engine::Engine>::apply+0x1111>
  259623:	movzwl 0x80(%rsp),%eax
  25962b:	lea    -0x1(%rax),%esi
  25962e:	test   %eax,%eax
  259630:	cmove  %eax,%esi
  259633:	test   %r14,%r14
  259636:	je     259a72 <<glass::engine::Engine>::apply+0x1532>
  25963c:	movzwl 0x82(%rsp),%ecx
  259644:	xor    %eax,%eax
  259646:	test   %cx,%cx
  259649:	setne  %al
  25964c:	jmp    259a74 <<glass::engine::Engine>::apply+0x1534>
  259651:	mov    0x1a8(%rsp),%r13
  259659:	xor    %eax,%eax
  25965b:	jmp    25968e <<glass::engine::Engine>::apply+0x114e>
  25965d:	mov    $0x17,%cx
  259661:	mov    $0x1010000,%esi
  259666:	cs nopw 0x0(%rax,%rax,1)
  259670:	movzwl %cx,%eax
  259673:	shl    $0x10,%rsi
  259677:	or     %rax,%rsi
  25967a:	mov    %r13,%rdi
  25967d:	call   34ae70 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  259682:	mov    %rbx,%rax
  259685:	cmp    %r14,%rbx
  259688:	ja     259a92 <<glass::engine::Engine>::apply+0x1552>
  25968e:	movzwl 0x80(%rsp,%rax,2),%ecx
  259696:	lea    0x1(%rax),%rbx
  25969a:	cmp    $0x3b,%rcx
  25969e:	ja     25991f <<glass::engine::Engine>::apply+0x13df>
  2596a4:	lea    -0x1eacf3(%rip),%rsi        # 6e9b8 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2e07>
  2596ab:	movslq (%rsi,%rcx,4),%rdx
  2596af:	add    %rsi,%rdx
  2596b2:	jmp    *%rdx
  2596b4:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  2596b6:	cmp    %r14,%rax
  2596b9:	jae    259682 <<glass::engine::Engine>::apply+0x1142>
  2596bb:	movzwl 0x82(%rsp,%rax,2),%ecx
  2596c3:	lea    0x2(%rax),%rbx
  2596c7:	cmp    $0x5,%ecx
  2596ca:	je     259983 <<glass::engine::Engine>::apply+0x1443>
  2596d0:	cmp    $0x2,%ecx
  2596d3:	jne    259682 <<glass::engine::Engine>::apply+0x1142>
  2596d5:	cmp    %r14,%rbx
  2596d8:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2596da:	movzwl 0x84(%rsp,%rax,2),%ecx
  2596e2:	lea    0x3(%rax),%rbx
  2596e6:	cmp    $0xff,%ecx
  2596ec:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2596ee:	cmp    %r14,%rbx
  2596f1:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2596f3:	movzwl 0x86(%rsp,%rax,2),%edx
  2596fb:	lea    0x4(%rax),%rbx
  2596ff:	cmp    $0xff,%edx
  259705:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  25970b:	cmp    %r14,%rbx
  25970e:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  259714:	movzwl 0x88(%rsp,%rax,2),%edi
  25971c:	add    $0x5,%rax
  259720:	cmp    $0xff,%edi
  259726:	ja     259a06 <<glass::engine::Engine>::apply+0x14c6>
  25972c:	shl    $0x10,%edi
  25972f:	movzwl %dx,%edx
  259732:	shl    $0x8,%edx
  259735:	or     %edx,%ecx
  259737:	movzwl %cx,%esi
  25973a:	or     %edi,%esi
  25973c:	mov    $0x1,%ecx
  259741:	jmp    2599a5 <<glass::engine::Engine>::apply+0x1465>
  259746:	mov    $0x11,%cx
  25974a:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  25974f:	mov    $0xc,%cx
  259753:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259758:	mov    $0xa,%cx
  25975c:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259761:	mov    $0x18,%cx
  259765:	mov    $0xff,%esi
  25976a:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  25976f:	mov    $0xe,%cx
  259773:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259778:	cmp    %r14,%rax
  25977b:	jae    259682 <<glass::engine::Engine>::apply+0x1142>
  259781:	movzwl 0x82(%rsp,%rax,2),%ecx
  259789:	lea    0x2(%rax),%rbx
  25978d:	cmp    $0x5,%ecx
  259790:	je     2599b6 <<glass::engine::Engine>::apply+0x1476>
  259796:	cmp    $0x2,%ecx
  259799:	jne    259682 <<glass::engine::Engine>::apply+0x1142>
  25979f:	cmp    %r14,%rbx
  2597a2:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2597a8:	movzwl 0x84(%rsp,%rax,2),%ecx
  2597b0:	lea    0x3(%rax),%rbx
  2597b4:	cmp    $0xff,%ecx
  2597ba:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2597c0:	cmp    %r14,%rbx
  2597c3:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2597c9:	movzwl 0x86(%rsp,%rax,2),%edx
  2597d1:	lea    0x4(%rax),%rbx
  2597d5:	cmp    $0xff,%edx
  2597db:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2597e1:	cmp    %r14,%rbx
  2597e4:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2597ea:	movzwl 0x88(%rsp,%rax,2),%edi
  2597f2:	add    $0x5,%rax
  2597f6:	cmp    $0xff,%edi
  2597fc:	ja     259a06 <<glass::engine::Engine>::apply+0x14c6>
  259802:	shl    $0x10,%edi
  259805:	movzwl %dx,%edx
  259808:	shl    $0x8,%edx
  25980b:	or     %edx,%ecx
  25980d:	movzwl %cx,%esi
  259810:	or     %edi,%esi
  259812:	mov    $0x1,%ecx
  259817:	jmp    2599d8 <<glass::engine::Engine>::apply+0x1498>
  25981c:	mov    $0x10,%cx
  259820:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259825:	mov    $0x16,%cx
  259829:	mov    $0x1000000,%esi
  25982e:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259833:	mov    $0xf,%cx
  259837:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  25983c:	mov    $0x9,%cx
  259840:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259845:	mov    $0x12,%cx
  259849:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  25984e:	mov    $0x13,%cx
  259852:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259857:	mov    $0xb,%cx
  25985b:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259860:	mov    $0xd,%cx
  259864:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259869:	mov    $0x15,%cx
  25986d:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259872:	mov    $0x14,%cx
  259876:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  25987b:	cmp    %r14,%rax
  25987e:	jae    259682 <<glass::engine::Engine>::apply+0x1142>
  259884:	movzwl 0x82(%rsp,%rax,2),%ecx
  25988c:	lea    0x2(%rax),%rbx
  259890:	cmp    $0x5,%ecx
  259893:	je     2599e9 <<glass::engine::Engine>::apply+0x14a9>
  259899:	cmp    $0x2,%ecx
  25989c:	jne    259682 <<glass::engine::Engine>::apply+0x1142>
  2598a2:	cmp    %r14,%rbx
  2598a5:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2598ab:	movzwl 0x84(%rsp,%rax,2),%ecx
  2598b3:	lea    0x3(%rax),%rbx
  2598b7:	cmp    $0xff,%ecx
  2598bd:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2598c3:	cmp    %r14,%rbx
  2598c6:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2598cc:	movzwl 0x86(%rsp,%rax,2),%edx
  2598d4:	lea    0x4(%rax),%rbx
  2598d8:	cmp    $0xff,%edx
  2598de:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2598e4:	cmp    %r14,%rbx
  2598e7:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2598ed:	movzwl 0x88(%rsp,%rax,2),%edi
  2598f5:	add    $0x5,%rax
  2598f9:	cmp    $0xff,%edi
  2598ff:	ja     259a06 <<glass::engine::Engine>::apply+0x14c6>
  259905:	shl    $0x10,%edi
  259908:	movzwl %dx,%edx
  25990b:	shl    $0x8,%edx
  25990e:	or     %edx,%ecx
  259910:	movzwl %cx,%esi
  259913:	or     %edi,%esi
  259915:	mov    $0x1,%ecx
  25991a:	jmp    259a34 <<glass::engine::Engine>::apply+0x14f4>
  25991f:	lea    -0x1e(%rcx),%eax
  259922:	cmp    $0x8,%ax
  259926:	jae    259940 <<glass::engine::Engine>::apply+0x1400>
  259928:	lea    -0x1fe4cf(%rip),%rax        # 5b460 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0x960>
  25992f:	movzwl -0x3c(%rax,%rcx,2),%esi
  259934:	shl    $0x10,%esi
  259937:	mov    $0x16,%cx
  25993b:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259940:	mov    %ecx,%eax
  259942:	and    $0xfff8,%eax
  259947:	cmp    $0x28,%ax
  25994b:	jne    259965 <<glass::engine::Engine>::apply+0x1425>
  25994d:	lea    -0x1fe4f4(%rip),%rax        # 5b460 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.13656677798324493035+0x960>
  259954:	movzwl -0x50(%rax,%rcx,2),%esi
  259959:	shl    $0x10,%esi
  25995c:	mov    $0x17,%cx
  259960:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259965:	lea    -0x5a(%rcx),%eax
  259968:	cmp    $0x8,%ax
  25996c:	jae    259a0e <<glass::engine::Engine>::apply+0x14ce>
  259972:	lea    -0x1fc909(%rip),%rax        # 5d070 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0xd0>
  259979:	movzwl -0xb4(%rax,%rcx,2),%esi
  259981:	jmp    259934 <<glass::engine::Engine>::apply+0x13f4>
  259983:	cmp    %r14,%rbx
  259986:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  25998c:	movzwl 0x84(%rsp,%rax,2),%esi
  259994:	add    $0x3,%rax
  259998:	cmp    $0xff,%esi
  25999e:	ja     259a06 <<glass::engine::Engine>::apply+0x14c6>
  2599a0:	mov    $0x2,%ecx
  2599a5:	shl    $0x8,%esi
  2599a8:	or     %ecx,%esi
  2599aa:	mov    $0x16,%cx
  2599ae:	mov    %rax,%rbx
  2599b1:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  2599b6:	cmp    %r14,%rbx
  2599b9:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2599bf:	movzwl 0x84(%rsp,%rax,2),%esi
  2599c7:	add    $0x3,%rax
  2599cb:	cmp    $0xff,%esi
  2599d1:	ja     259a06 <<glass::engine::Engine>::apply+0x14c6>
  2599d3:	mov    $0x2,%ecx
  2599d8:	shl    $0x8,%esi
  2599db:	or     %ecx,%esi
  2599dd:	mov    $0x18,%cx
  2599e1:	mov    %rax,%rbx
  2599e4:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  2599e9:	cmp    %r14,%rbx
  2599ec:	ja     259682 <<glass::engine::Engine>::apply+0x1142>
  2599f2:	movzwl 0x84(%rsp,%rax,2),%esi
  2599fa:	add    $0x3,%rax
  2599fe:	cmp    $0xff,%esi
  259a04:	jbe    259a2f <<glass::engine::Engine>::apply+0x14ef>
  259a06:	mov    %rax,%rbx
  259a09:	jmp    259682 <<glass::engine::Engine>::apply+0x1142>
  259a0e:	lea    -0x64(%rcx),%eax
  259a11:	cmp    $0x8,%ax
  259a15:	jae    259682 <<glass::engine::Engine>::apply+0x1142>
  259a1b:	lea    -0x1fc9b2(%rip),%rax        # 5d070 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.13656677798324493035+0xd0>
  259a22:	movzwl -0xc8(%rax,%rcx,2),%esi
  259a2a:	jmp    259959 <<glass::engine::Engine>::apply+0x1419>
  259a2f:	mov    $0x2,%ecx
  259a34:	shl    $0x8,%esi
  259a37:	or     %ecx,%esi
  259a39:	mov    $0x17,%cx
  259a3d:	mov    %rax,%rbx
  259a40:	jmp    259670 <<glass::engine::Engine>::apply+0x1130>
  259a45:	mov    $0x1,%al
  259a47:	mov    %eax,0xd0(%rsp)
  259a4e:	mov    %r8,%r13
  259a51:	mov    0x8(%rsp),%rax
  259a56:	mov    %rax,0xe8(%rsp)
  259a5e:	mov    $0x1,%al
  259a60:	mov    %rax,0x58(%rsp)
  259a65:	mov    0x120(%rsp),%rbx
  259a6d:	jmp    258fe5 <<glass::engine::Engine>::apply+0xaa5>
  259a72:	xor    %eax,%eax
  259a74:	movzwl %cx,%edx
  259a77:	dec    %rdx
  259a7a:	test   $0x1,%al
  259a7c:	mov    $0x0,%eax
  259a81:	cmove  %rax,%rdx
  259a85:	mov    0x1a8(%rsp),%rdi
  259a8d:	call   34c2b0 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  259a92:	mov    0x10(%rsp),%r8
  259a97:	mov    0x120(%rsp),%rbx
  259a9f:	lea    (%rbx,%r8,1),%r13
  259aa3:	movb   $0x0,0xa80(%r12)
  259aac:	movb   $0x0,0xa7e(%r12)
  259ab5:	mov    $0x1,%al
  259ab7:	mov    %eax,0xd0(%rsp)
  259abe:	mov    %r13,0x8(%rsp)
  259ac3:	mov    %r13,0xe8(%rsp)
  259acb:	mov    $0x1,%al
  259acd:	mov    %rax,0x58(%rsp)
  259ad2:	jmp    258fe5 <<glass::engine::Engine>::apply+0xaa5>
  259ad7:	mov    $0x2,%edx
  259adc:	jmp    2592f5 <<glass::engine::Engine>::apply+0xdb5>
  259ae1:	call   18bc06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259ae6:	jmp    259391 <<glass::engine::Engine>::apply+0xe51>
  259aeb:	call   18bc06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  259af0:	jmp    259425 <<glass::engine::Engine>::apply+0xee5>
  259af5:	mov    0x8(%rsp),%rax
  259afa:	movzbl (%rax),%eax
  259afd:	mov    %rax,0xd0(%rsp)
  259b05:	add    $0xffffffe0,%eax
  259b08:	mov    $0x1,%r15d
  259b0e:	cmp    $0x5f,%al
  259b10:	jb     259b3d <<glass::engine::Engine>::apply+0x15fd>
  259b12:	mov    0xd0(%rsp),%rdi
  259b1a:	call   2a1fe0 <glass::engine::width_of>
  259b1f:	mov    0x38(%rsp),%r12
  259b24:	mov    %rdx,%r15
  259b27:	lea    -0x1(%rdx),%rcx
  259b2b:	cmp    $0x2,%rcx
  259b2f:	setb   %cl
  259b32:	and    %al,%cl
  259b34:	cmp    $0x1,%cl
  259b37:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259b3d:	cmpb   $0x0,0x6c(%r13)
  259b42:	mov    0x38(%rsp),%r12
  259b47:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259b4d:	mov    0x40(%r13),%rdx
  259b51:	mov    0xa0(%r13),%rcx
  259b58:	mov    %rdx,0x30(%rsp)
  259b5d:	lea    (%rdx,%r15,1),%rax
  259b61:	mov    %rax,0x118(%rsp)
  259b69:	mov    %rcx,0x220(%rsp)
  259b71:	cmp    %rcx,%rax
  259b74:	ja     2594a2 <<glass::engine::Engine>::apply+0xf62>
  259b7a:	lea    0x10(%r13),%rdi
  259b7e:	mov    0x48(%r13),%esi
  259b82:	mov    0x58(%r13),%eax
  259b86:	mov    %eax,0xfc(%rsp)
  259b8d:	mov    0x5c(%r13),%eax
  259b91:	mov    %eax,0xf8(%rsp)
  259b98:	movzwl 0x64(%r13),%eax
  259b9d:	mov    %eax,0x100(%rsp)
  259ba4:	lea    0x370215(%rip),%rdx        # 5c9dc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15640>
  259bab:	call   30b9c0 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  259bb0:	mov    %rax,%rcx
  259bb3:	add    $0x18,%rcx
  259bb7:	mov    %rcx,0x108(%rsp)
  259bbf:	mov    %rax,0x20(%rsp)
  259bc4:	mov    0x28(%rax),%eax
  259bc7:	cmp    $0xffffffff,%eax
  259bca:	je     259be4 <<glass::engine::Engine>::apply+0x16a4>
  259bcc:	mov    0x108(%rsp),%rcx
  259bd4:	mov    0x30(%rsp),%rdx
  259bd9:	mov    0x20(%rsp),%rsi
  259bde:	cmp    0x30(%rsi),%rdx
  259be2:	jae    259c0e <<glass::engine::Engine>::apply+0x16ce>
  259be4:	mov    0x20(%rsp),%rcx
  259be9:	mov    0x10(%rcx),%rcx
  259bed:	cmp    %rcx,0x30(%rsp)
  259bf2:	jae    25a9f1 <<glass::engine::Engine>::apply+0x24b1>
  259bf8:	mov    0x30(%rsp),%rcx
  259bfd:	lea    (%rcx,%rcx,2),%rcx
  259c01:	shl    $0x3,%rcx
  259c05:	mov    0x20(%rsp),%rdx
  259c0a:	add    0x8(%rdx),%rcx
  259c0e:	testb  $0x60,0x14(%rcx)
  259c12:	mov    0x38(%rsp),%r12
  259c17:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259c1d:	cmp    $0x2,%r15
  259c21:	jne    259c75 <<glass::engine::Engine>::apply+0x1735>
  259c23:	mov    0x30(%rsp),%rcx
  259c28:	inc    %rcx
  259c2b:	cmp    $0xffffffff,%eax
  259c2e:	je     259c43 <<glass::engine::Engine>::apply+0x1703>
  259c30:	mov    0x108(%rsp),%rdx
  259c38:	mov    0x20(%rsp),%rsi
  259c3d:	cmp    0x30(%rsi),%rcx
  259c41:	jae    259c66 <<glass::engine::Engine>::apply+0x1726>
  259c43:	mov    0x20(%rsp),%rdx
  259c48:	mov    0x10(%rdx),%rdx
  259c4c:	cmp    %rdx,%rcx
  259c4f:	jae    25aa07 <<glass::engine::Engine>::apply+0x24c7>
  259c55:	lea    (%rcx,%rcx,2),%rdx
  259c59:	shl    $0x3,%rdx
  259c5d:	mov    0x20(%rsp),%rcx
  259c62:	add    0x8(%rcx),%rdx
  259c66:	testb  $0x60,0x14(%rdx)
  259c6a:	mov    0x38(%rsp),%r12
  259c6f:	jne    2594a2 <<glass::engine::Engine>::apply+0xf62>
  259c75:	mov    0x30(%rsp),%rcx
  259c7a:	mov    0x20(%rsp),%rdx
  259c7f:	cmp    %ecx,0x38(%rdx)
  259c82:	jbe    259c91 <<glass::engine::Engine>::apply+0x1751>
  259c84:	mov    0x30(%rsp),%rcx
  259c89:	mov    0x20(%rsp),%rdx
  259c8e:	mov    %ecx,0x38(%rdx)
  259c91:	cmp    $0xffffffff,%eax
  259c94:	setne  %cl
  259c97:	mov    0x20(%rsp),%rdx
  259c9c:	mov    0x30(%rdx),%r12
  259ca0:	cmp    %r12,0x30(%rsp)
  259ca5:	sete   %dl
  259ca8:	test   %dl,%cl
  259caa:	jne    259db8 <<glass::engine::Engine>::apply+0x1878>
  259cb0:	cmp    $0xffffffff,%eax
  259cb3:	je     259f12 <<glass::engine::Engine>::apply+0x19d2>
  259cb9:	mov    0x20(%rsp),%rax
  259cbe:	mov    0x10(%rax),%rbp
  259cc2:	cmp    %r12,%rbp
  259cc5:	mov    %r12,%rax
  259cc8:	cmovb  %rbp,%rax
  259ccc:	mov    %rax,0x68(%rsp)
  259cd1:	mov    0x30(%rsp),%rax
  259cd6:	cmp    %rax,%rbp
  259cd9:	cmovb  %rbp,%rax
  259cdd:	mov    %rax,0x40(%rsp)
  259ce2:	mov    0x398e17(%rip),%rax        # 5f2b00 <_DYNAMIC+0x320>
  259ce9:	movzbl (%rax),%eax
  259cec:	test   %al,%al
  259cee:	je     259d19 <<glass::engine::Engine>::apply+0x17d9>
  259cf0:	mov    0x398e41(%rip),%rax        # 5f2b38 <_DYNAMIC+0x358>
  259cf7:	cmp    0x40(%rsp),%r12
  259cfc:	jae    259d05 <<glass::engine::Engine>::apply+0x17c5>
  259cfe:	mov    0x398e3b(%rip),%rax        # 5f2b40 <_DYNAMIC+0x360>
  259d05:	lock incq 0x28(%rax)
  259d0a:	mov    0x40(%rsp),%rdi
  259d0f:	sub    0x68(%rsp),%rdi
  259d14:	call   2f6f60 <alacritty_terminal::grid::row::fill_census::note>
  259d19:	cmp    0x40(%rsp),%r12
  259d1e:	jae    259ef2 <<glass::engine::Engine>::apply+0x19b2>
  259d24:	mov    0x20(%rsp),%rax
  259d29:	mov    0x28(%rax),%ecx
  259d2c:	mov    %ecx,0x54(%rsp)
  259d30:	mov    0x20(%rax),%ecx
  259d33:	mov    %ecx,0x50(%rsp)
  259d37:	mov    0x24(%rax),%ecx
  259d3a:	mov    %ecx,0x4c(%rsp)
  259d3e:	movzwl 0x2c(%rax),%ecx
  259d42:	mov    %cx,0x70(%rsp)
  259d47:	mov    0x18(%rax),%rax
  259d4b:	mov    %rax,0x8(%rsp)
  259d50:	test   %rax,%rax
  259d53:	je     259ddc <<glass::engine::Engine>::apply+0x189c>
  259d59:	mov    0x8(%rsp),%rax
  259d5e:	lock incq (%rax)
  259d62:	jle    25aa6f <<glass::engine::Engine>::apply+0x252f>
  259d68:	mov    0x20(%rsp),%rax
  259d6d:	mov    0x10(%rax),%rdx
  259d71:	mov    0x54(%rsp),%eax
  259d75:	mov    %eax,0xc0(%rsp)
  259d7c:	mov    0x50(%rsp),%eax
  259d80:	mov    %eax,0xb8(%rsp)
  259d87:	mov    0x4c(%rsp),%eax
  259d8b:	mov    %eax,0xbc(%rsp)
  259d92:	movzwl 0x70(%rsp),%eax
  259d97:	mov    %ax,0xc4(%rsp)
  259d9f:	mov    0x8(%rsp),%rax
  259da4:	mov    %rax,0xb0(%rsp)
  259dac:	cmp    %rdx,0x40(%rsp)
  259db1:	jbe    259e17 <<glass::engine::Engine>::apply+0x18d7>
  259db3:	jmp    25aa1b <<glass::engine::Engine>::apply+0x24db>
  259db8:	mov    0x30(%rsp),%rcx
  259dbd:	lea    0x1(%rcx),%rax
  259dc1:	mov    0x20(%rsp),%rdx
  259dc6:	mov    %rax,0x30(%rdx)
  259dca:	mov    0x10(%rdx),%rax
  259dce:	cmp    %rax,%rcx
  259dd1:	jb     259f3c <<glass::engine::Engine>::apply+0x19fc>
  259dd7:	jmp    25aa34 <<glass::engine::Engine>::apply+0x24f4>
  259ddc:	mov    0x54(%rsp),%eax
  259de0:	mov    %eax,0xc0(%rsp)
  259de7:	mov    0x50(%rsp),%eax
  259deb:	mov    %eax,0xb8(%rsp)
  259df2:	mov    0x4c(%rsp),%eax
  259df6:	mov    %eax,0xbc(%rsp)
  259dfd:	movzwl 0x70(%rsp),%eax
  259e02:	mov    %ax,0xc4(%rsp)
  259e0a:	mov    0x8(%rsp),%rax
  259e0f:	mov    %rax,0xb0(%rsp)
  259e17:	mov    0x68(%rsp),%rax
  259e1c:	lea    0x0(,%rax,8),%rax
  259e24:	lea    (%rax,%rax,2),%rax
  259e28:	mov    0x20(%rsp),%rcx
  259e2d:	mov    0x8(%rcx),%rbp
  259e31:	add    %rax,%rbp
  259e34:	mov    0x40(%rsp),%rcx
  259e39:	lea    0x0(,%rcx,8),%rcx
  259e41:	lea    (%rcx,%rcx,2),%r12
  259e45:	sub    %rax,%r12
  259e48:	jmp    259e7b <<glass::engine::Engine>::apply+0x193b>
  259e4a:	mov    0x8(%rsp),%rax
  259e4f:	mov    %rax,0x0(%rbp)
  259e53:	mov    0x50(%rsp),%eax
  259e57:	mov    %eax,0x8(%rbp)
  259e5a:	mov    0x4c(%rsp),%eax
  259e5e:	mov    %eax,0xc(%rbp)
  259e61:	mov    0x54(%rsp),%eax
  259e65:	mov    %eax,0x10(%rbp)
  259e68:	movzwl 0x70(%rsp),%eax
  259e6d:	mov    %ax,0x14(%rbp)
  259e71:	add    $0x18,%rbp
  259e75:	add    $0xffffffffffffffe8,%r12
  259e79:	je     259eac <<glass::engine::Engine>::apply+0x196c>
  259e7b:	cmpq   $0x0,0x8(%rsp)
  259e81:	je     259e92 <<glass::engine::Engine>::apply+0x1952>
  259e83:	mov    0x8(%rsp),%rax
  259e88:	lock incq (%rax)
  259e8c:	jle    25aa6f <<glass::engine::Engine>::apply+0x252f>
  259e92:	mov    0x0(%rbp),%rax
  259e96:	test   %rax,%rax
  259e99:	je     259e4a <<glass::engine::Engine>::apply+0x190a>
  259e9b:	lock decq (%rax)
  259e9f:	jne    259e4a <<glass::engine::Engine>::apply+0x190a>
  259ea1:	mov    %rbp,%rdi
  259ea4:	call   *0x398b9e(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  259eaa:	jmp    259e4a <<glass::engine::Engine>::apply+0x190a>
  259eac:	mov    0x20(%rsp),%rax
  259eb1:	mov    0x68(%rsp),%rcx
  259eb6:	cmp    %ecx,0x38(%rax)
  259eb9:	jbe    259ec8 <<glass::engine::Engine>::apply+0x1988>
  259ebb:	mov    0x20(%rsp),%rax
  259ec0:	mov    0x68(%rsp),%rcx
  259ec5:	mov    %ecx,0x38(%rax)
  259ec8:	cmpq   $0x0,0x8(%rsp)
  259ece:	je     259ee9 <<glass::engine::Engine>::apply+0x19a9>
  259ed0:	mov    0x8(%rsp),%rax
  259ed5:	lock decq (%rax)
  259ed9:	jne    259ee9 <<glass::engine::Engine>::apply+0x19a9>
  259edb:	lea    0xb0(%rsp),%rdi
  259ee3:	call   *0x398b5f(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  259ee9:	mov    0x20(%rsp),%rax
  259eee:	mov    0x10(%rax),%rbp
  259ef2:	cmp    %rbp,0x40(%rsp)
  259ef7:	jb     259f12 <<glass::engine::Engine>::apply+0x19d2>
  259ef9:	mov    0x108(%rsp),%rdi
  259f01:	call   1ad660 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  259f06:	mov    0x20(%rsp),%rax
  259f0b:	movl   $0xffffffff,0x28(%rax)
  259f12:	mov    0x20(%rsp),%rsi
  259f17:	mov    0x30(%rsi),%rcx
  259f1b:	mov    0x30(%rsp),%rdx
  259f20:	lea    0x1(%rdx),%rax
  259f24:	cmp    %rcx,%rax
  259f27:	cmova  %rax,%rcx
  259f2b:	mov    0x10(%rsi),%rax
  259f2f:	mov    %rcx,0x30(%rsi)
  259f33:	cmp    %rax,%rdx
  259f36:	jae    25aa3b <<glass::engine::Engine>::apply+0x24fb>
  259f3c:	mov    0x100(%rsp),%edi
  259f43:	mov    %edi,%eax
  259f45:	or     $0x20,%eax
  259f48:	cmp    $0x2,%r15
  259f4c:	mov    0x20(%rsp),%rcx
  259f51:	mov    0x8(%rcx),%rcx
  259f55:	mov    0x30(%rsp),%rdx
  259f5a:	lea    (%rdx,%rdx,2),%rdx
  259f5e:	lea    (%rcx,%rdx,8),%rbp
  259f62:	mov    0xd0(%rsp),%rsi
  259f6a:	mov    %esi,0x10(%rcx,%rdx,8)
  259f6e:	mov    0xfc(%rsp),%esi
  259f75:	mov    %esi,0x8(%rcx,%rdx,8)
  259f79:	cmovne %edi,%eax
  259f7c:	mov    0xf8(%rsp),%esi
  259f83:	mov    %esi,0xc(%rcx,%rdx,8)
  259f87:	mov    %ax,0x14(%rcx,%rdx,8)
  259f8c:	mov    (%rcx,%rdx,8),%rax
  259f90:	test   %rax,%rax
  259f93:	je     259fa4 <<glass::engine::Engine>::apply+0x1a64>
  259f95:	lock decq (%rax)
  259f99:	jne    259fa4 <<glass::engine::Engine>::apply+0x1a64>
  259f9b:	mov    %rbp,%rdi
  259f9e:	call   *0x398aa4(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  259fa4:	movq   $0x0,0x0(%rbp)
  259fac:	cmp    $0x2,%r15
  259fb0:	jne    25a2a2 <<glass::engine::Engine>::apply+0x1d62>
  259fb6:	mov    0x30(%rsp),%rax
  259fbb:	lea    0x1(%rax),%rdx
  259fbf:	mov    0x20(%rsp),%rax
  259fc4:	mov    0x30(%rax),%r15
  259fc8:	mov    0x28(%rax),%eax
  259fcb:	mov    %rdx,0x70(%rsp)
  259fd0:	cmp    %r15,%rdx
  259fd3:	jne    25a000 <<glass::engine::Engine>::apply+0x1ac0>
  259fd5:	cmp    $0xffffffff,%eax
  259fd8:	je     25a000 <<glass::engine::Engine>::apply+0x1ac0>
  259fda:	mov    0x30(%rsp),%rax
  259fdf:	add    $0x2,%rax
  259fe3:	mov    0x20(%rsp),%rcx
  259fe8:	mov    %rax,0x30(%rcx)
  259fec:	mov    0x10(%rcx),%rax
  259ff0:	cmp    %rax,0x70(%rsp)
  259ff5:	jb     25a240 <<glass::engine::Engine>::apply+0x1d00>
  259ffb:	jmp    25aa42 <<glass::engine::Engine>::apply+0x2502>
  25a000:	cmp    $0xffffffff,%eax
  25a003:	je     25a214 <<glass::engine::Engine>::apply+0x1cd4>
  25a009:	mov    0x20(%rsp),%rax
  25a00e:	mov    0x10(%rax),%r12
  25a012:	cmp    %r15,%r12
  25a015:	mov    %r15,%rax
  25a018:	cmovb  %r12,%rax
  25a01c:	mov    %rax,0x68(%rsp)
  25a021:	mov    0x70(%rsp),%rax
  25a026:	cmp    %rax,%r12
  25a029:	cmovb  %r12,%rax
  25a02d:	mov    %rax,0x40(%rsp)
  25a032:	mov    0x398ac7(%rip),%rax        # 5f2b00 <_DYNAMIC+0x320>
  25a039:	movzbl (%rax),%eax
  25a03c:	test   %al,%al
  25a03e:	je     25a069 <<glass::engine::Engine>::apply+0x1b29>
  25a040:	mov    0x398af1(%rip),%rax        # 5f2b38 <_DYNAMIC+0x358>
  25a047:	cmp    0x40(%rsp),%r15
  25a04c:	jae    25a055 <<glass::engine::Engine>::apply+0x1b15>
  25a04e:	mov    0x398aeb(%rip),%rax        # 5f2b40 <_DYNAMIC+0x360>
  25a055:	lock incq 0x28(%rax)
  25a05a:	mov    0x40(%rsp),%rdi
  25a05f:	sub    0x68(%rsp),%rdi
  25a064:	call   2f6f60 <alacritty_terminal::grid::row::fill_census::note>
  25a069:	cmp    0x40(%rsp),%r15
  25a06e:	jae    25a1f4 <<glass::engine::Engine>::apply+0x1cb4>
  25a074:	mov    0x20(%rsp),%rax
  25a079:	mov    0x28(%rax),%ecx
  25a07c:	mov    %ecx,0x8(%rsp)
  25a080:	mov    0x20(%rax),%ecx
  25a083:	mov    %ecx,0x54(%rsp)
  25a087:	mov    0x24(%rax),%ecx
  25a08a:	mov    %ecx,0x50(%rsp)
  25a08e:	movzwl 0x2c(%rax),%ecx
  25a092:	mov    %cx,0x4c(%rsp)
  25a097:	mov    0x18(%rax),%r12
  25a09b:	test   %r12,%r12
  25a09e:	je     25a0f6 <<glass::engine::Engine>::apply+0x1bb6>
  25a0a0:	lock incq (%r12)
  25a0a5:	jle    25aa6f <<glass::engine::Engine>::apply+0x252f>
  25a0ab:	mov    0x20(%rsp),%rax
  25a0b0:	mov    0x10(%rax),%rdx
  25a0b4:	mov    0x8(%rsp),%eax
  25a0b8:	mov    %eax,0xc0(%rsp)
  25a0bf:	mov    0x54(%rsp),%eax
  25a0c3:	mov    %eax,0xb8(%rsp)
  25a0ca:	mov    0x50(%rsp),%eax
  25a0ce:	mov    %eax,0xbc(%rsp)
  25a0d5:	movzwl 0x4c(%rsp),%eax
  25a0da:	mov    %ax,0xc4(%rsp)
  25a0e2:	mov    %r12,0xb0(%rsp)
  25a0ea:	cmp    %rdx,0x40(%rsp)
  25a0ef:	jbe    25a12c <<glass::engine::Engine>::apply+0x1bec>
  25a0f1:	jmp    25aa58 <<glass::engine::Engine>::apply+0x2518>
  25a0f6:	mov    0x8(%rsp),%eax
  25a0fa:	mov    %eax,0xc0(%rsp)
  25a101:	mov    0x54(%rsp),%eax
  25a105:	mov    %eax,0xb8(%rsp)
  25a10c:	mov    0x50(%rsp),%eax
  25a110:	mov    %eax,0xbc(%rsp)
  25a117:	movzwl 0x4c(%rsp),%eax
  25a11c:	mov    %ax,0xc4(%rsp)
  25a124:	mov    %r12,0xb0(%rsp)
  25a12c:	mov    0x68(%rsp),%rax
  25a131:	lea    0x0(,%rax,8),%rax
  25a139:	lea    (%rax,%rax,2),%rax
  25a13d:	mov    0x20(%rsp),%rcx
  25a142:	mov    0x8(%rcx),%rbp
  25a146:	add    %rax,%rbp
  25a149:	mov    0x40(%rsp),%rcx
  25a14e:	lea    0x0(,%rcx,8),%rcx
  25a156:	lea    (%rcx,%rcx,2),%r15
  25a15a:	sub    %rax,%r15
  25a15d:	jmp    25a18b <<glass::engine::Engine>::apply+0x1c4b>
  25a15f:	mov    %r12,0x0(%rbp)
  25a163:	mov    0x54(%rsp),%eax
  25a167:	mov    %eax,0x8(%rbp)
  25a16a:	mov    0x50(%rsp),%eax
  25a16e:	mov    %eax,0xc(%rbp)
  25a171:	mov    0x8(%rsp),%eax
  25a175:	mov    %eax,0x10(%rbp)
  25a178:	movzwl 0x4c(%rsp),%eax
  25a17d:	mov    %ax,0x14(%rbp)
  25a181:	add    $0x18,%rbp
  25a185:	add    $0xffffffffffffffe8,%r15
  25a189:	je     25a1b5 <<glass::engine::Engine>::apply+0x1c75>
  25a18b:	test   %r12,%r12
  25a18e:	je     25a19b <<glass::engine::Engine>::apply+0x1c5b>
  25a190:	lock incq (%r12)
  25a195:	jle    25aa6f <<glass::engine::Engine>::apply+0x252f>
  25a19b:	mov    0x0(%rbp),%rax
  25a19f:	test   %rax,%rax
  25a1a2:	je     25a15f <<glass::engine::Engine>::apply+0x1c1f>
  25a1a4:	lock decq (%rax)
  25a1a8:	jne    25a15f <<glass::engine::Engine>::apply+0x1c1f>
  25a1aa:	mov    %rbp,%rdi
  25a1ad:	call   *0x398895(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  25a1b3:	jmp    25a15f <<glass::engine::Engine>::apply+0x1c1f>
  25a1b5:	mov    0x20(%rsp),%rax
  25a1ba:	mov    0x68(%rsp),%rcx
  25a1bf:	cmp    %ecx,0x38(%rax)
  25a1c2:	jbe    25a1d1 <<glass::engine::Engine>::apply+0x1c91>
  25a1c4:	mov    0x20(%rsp),%rax
  25a1c9:	mov    0x68(%rsp),%rcx
  25a1ce:	mov    %ecx,0x38(%rax)
  25a1d1:	test   %r12,%r12
  25a1d4:	je     25a1eb <<glass::engine::Engine>::apply+0x1cab>
  25a1d6:	lock decq (%r12)
  25a1db:	jne    25a1eb <<glass::engine::Engine>::apply+0x1cab>
  25a1dd:	lea    0xb0(%rsp),%rdi
  25a1e5:	call   *0x39885d(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  25a1eb:	mov    0x20(%rsp),%rax
  25a1f0:	mov    0x10(%rax),%r12
  25a1f4:	cmp    %r12,0x40(%rsp)
  25a1f9:	jb     25a214 <<glass::engine::Engine>::apply+0x1cd4>
  25a1fb:	mov    0x108(%rsp),%rdi
  25a203:	call   1ad660 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  25a208:	mov    0x20(%rsp),%rax
  25a20d:	movl   $0xffffffff,0x28(%rax)
  25a214:	mov    0x20(%rsp),%rdx
  25a219:	mov    0x30(%rdx),%rax
  25a21d:	mov    0x30(%rsp),%rcx
  25a222:	add    $0x2,%rcx
  25a226:	cmp    %rax,%rcx
  25a229:	cmovbe %rax,%rcx
  25a22d:	mov    0x10(%rdx),%rax
  25a231:	mov    %rcx,0x30(%rdx)
  25a235:	cmp    %rax,0x70(%rsp)
  25a23a:	jae    25aa71 <<glass::engine::Engine>::apply+0x2531>
  25a240:	mov    0x20(%rsp),%rax
  25a245:	mov    0x8(%rax),%rax
  25a249:	mov    0x70(%rsp),%rcx
  25a24e:	lea    (%rcx,%rcx,2),%rcx
  25a252:	lea    (%rax,%rcx,8),%r15
  25a256:	movl   $0x20,0x10(%rax,%rcx,8)
  25a25e:	mov    0xfc(%rsp),%edx
  25a265:	mov    %edx,0x8(%rax,%rcx,8)
  25a269:	mov    0xf8(%rsp),%edx
  25a270:	mov    %edx,0xc(%rax,%rcx,8)
  25a274:	mov    0x100(%rsp),%edx
  25a27b:	or     $0x40,%edx
  25a27e:	mov    %dx,0x14(%rax,%rcx,8)
  25a283:	mov    (%rax,%rcx,8),%rax
  25a287:	test   %rax,%rax
  25a28a:	je     25a29b <<glass::engine::Engine>::apply+0x1d5b>
  25a28c:	lock decq (%rax)
  25a290:	jne    25a29b <<glass::engine::Engine>::apply+0x1d5b>
  25a292:	mov    %r15,%rdi
  25a295:	call   *0x3987ad(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  25a29b:	movq   $0x0,(%r15)
  25a2a2:	mov    0x220(%rsp),%rax
  25a2aa:	cmp    %rax,0x118(%rsp)
  25a2b2:	jb     25a2c1 <<glass::engine::Engine>::apply+0x1d81>
  25a2b4:	decq   0x118(%rsp)
  25a2bc:	movb   $0x1,0x6c(%r13)
  25a2c1:	mov    0x118(%rsp),%rax
  25a2c9:	mov    %rax,0x40(%r13)
  25a2cd:	incq   0x1d0(%rsp)
  25a2d5:	mov    0xd0(%rsp),%rax
  25a2dd:	mov    %eax,0x1e0(%rsp)
  25a2e4:	mov    $0x1,%r15d
  25a2ea:	mov    0x38(%rsp),%r12
  25a2ef:	mov    0x39b6cb(%rip),%eax        # 5f59c0 <glass::engine::run_whole::ON>
  25a2f5:	test   %eax,%eax
  25a2f7:	je     2594c8 <<glass::engine::Engine>::apply+0xf88>
  25a2fd:	call   18bc06 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25a302:	jmp    2594c8 <<glass::engine::Engine>::apply+0xf88>
  25a307:	nopw   0x0(%rax,%rax,1)
  25a310:	mov    0x398f81(%rip),%rax        # 5f3298 <_DYNAMIC+0xab8>
  25a317:	mov    (%rax),%rax
  25a31a:	mov    $0x1b,%edi
  25a31f:	mov    %r14,%rsi
  25a322:	mov    0x110(%rsp),%rbx
  25a32a:	mov    %rbx,%rdx
  25a32d:	call   *%rax
  25a32f:	mov    %r14,%r13
  25a332:	mov    %rbx,%r14
  25a335:	cmp    $0x1,%rax
  25a339:	jne    25a5f0 <<glass::engine::Engine>::apply+0x20b0>
  25a33f:	mov    %rdx,%rcx
  25a342:	sub    %r13,%rcx
  25a345:	movb   $0x1,0xa80(%r12)
  25a34e:	movb   $0x0,0xa7e(%r12)
  25a357:	inc    %rcx
  25a35a:	cmp    %r15,%rcx
  25a35d:	jb     25a5fb <<glass::engine::Engine>::apply+0x20bb>
  25a363:	movzbl 0xa7e(%r12),%eax
  25a36c:	jmp    25a6f1 <<glass::engine::Engine>::apply+0x21b1>
  25a371:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a380:	mov    0x18(%rsp),%r15
  25a385:	cmp    %rbp,%r15
  25a388:	jb     25a93f <<glass::engine::Engine>::apply+0x23ff>
  25a38e:	mov    0x28(%rsp),%r13
  25a393:	mov    %r13,%rbx
  25a396:	add    %rbp,%rbx
  25a399:	mov    0x398ef8(%rip),%rax        # 5f3298 <_DYNAMIC+0xab8>
  25a3a0:	mov    (%rax),%rax
  25a3a3:	mov    $0x1b,%edi
  25a3a8:	mov    %rbx,%rsi
  25a3ab:	mov    0x110(%rsp),%r14
  25a3b3:	mov    %r14,%rdx
  25a3b6:	call   *%rax
  25a3b8:	cmp    $0x1,%rax
  25a3bc:	jne    25a3d9 <<glass::engine::Engine>::apply+0x1e99>
  25a3be:	sub    %rbx,%rdx
  25a3c1:	movb   $0x1,0xa80(%r12)
  25a3ca:	movb   $0x0,0xa7e(%r12)
  25a3d3:	add    %rdx,%rbp
  25a3d6:	inc    %rbp
  25a3d9:	cmp    %r15,%rbp
  25a3dc:	jae    25a413 <<glass::engine::Engine>::apply+0x1ed3>
  25a3de:	mov    0x60(%rsp),%rdi
  25a3e3:	mov    %r13,%rsi
  25a3e6:	mov    %r15,%rdx
  25a3e9:	mov    %rbp,%rcx
  25a3ec:	mov    %r15,%r8
  25a3ef:	call   270180 <<glass::engine::Mirror>::stretch>
  25a3f4:	cmp    %r15,%rax
  25a3f7:	jae    25a413 <<glass::engine::Engine>::apply+0x1ed3>
  25a3f9:	cmpb   $0x0,0xa80(%r12)
  25a402:	jne    25a413 <<glass::engine::Engine>::apply+0x1ed3>
  25a404:	movzbl -0x1(%r14),%eax
  25a409:	shr    $0x7,%al
  25a40c:	mov    0x60(%rsp),%rcx
  25a411:	mov    %al,(%rcx)
  25a413:	movzbl 0xa7e(%r12),%eax
  25a41c:	mov    %al,0xa7f(%r12)
  25a424:	sub    0x8(%rsp),%r15
  25a429:	mov    0xe0(%rsp),%rbx
  25a431:	jbe    25a460 <<glass::engine::Engine>::apply+0x1f20>
  25a433:	movzbl 0x39e8de(%rip),%eax        # 5f8d18 <glass::engine::counters::COUNTING>
  25a43a:	test   %al,%al
  25a43c:	je     25a446 <<glass::engine::Engine>::apply+0x1f06>
  25a43e:	lock add %r15,0x39e8da(%rip)        # 5f8d20 <glass::engine::counters::VTE_BYTES>
  25a446:	movzbl 0x39e86b(%rip),%eax        # 5f8cb8 <glass::engine::probes::RUN_PROBE>
  25a44d:	cmp    $0x68,%al
  25a44f:	jne    25a79a <<glass::engine::Engine>::apply+0x225a>
  25a455:	data16 cs nopw 0x0(%rax,%rax,1)
  25a460:	mov    0x1e0(%rsp),%rax
  25a468:	mov    %rax,0xa70(%r12)
  25a470:	mov    0x1e8(%rsp),%eax
  25a477:	mov    %eax,0xa78(%r12)
  25a47f:	pshufd $0x4e,0x1c0(%rsp),%xmm0
  25a489:	movdqu %xmm0,0xa60(%r12)
  25a493:	movzbl 0x1ed(%rsp),%eax
  25a49b:	mov    %al,0xa7d(%r12)
  25a4a3:	movzbl 0x1ec(%rsp),%eax
  25a4ab:	and    $0x1,%eax
  25a4ae:	shl    $0x5,%eax
  25a4b1:	mov    0x1b8(%rsp,%rax,1),%rax
  25a4b9:	mov    0xa58(%r12),%rcx
  25a4c1:	cmp    %rcx,%rax
  25a4c4:	cmova  %rax,%rcx
  25a4c8:	mov    %rcx,0xa58(%r12)
  25a4d0:	mov    0x140(%rsp),%rax
  25a4d8:	mov    %rax,0x28(%rsp)
  25a4dd:	mov    0x148(%rsp),%r13
  25a4e5:	mov    0x150(%rsp),%r14
  25a4ed:	movq   $0x0,0x140(%rsp)
  25a4f9:	movq   $0x8,0x148(%rsp)
  25a505:	movq   $0x0,0x150(%rsp)
  25a511:	test   %r14,%r14
  25a514:	je     25a572 <<glass::engine::Engine>::apply+0x2032>
  25a516:	mov    0x8e8(%r12),%rax
  25a51e:	mov    0x8f8(%r12),%r15
  25a526:	sub    %r15,%rax
  25a529:	cmp    %rax,%r14
  25a52c:	ja     25a86d <<glass::engine::Engine>::apply+0x232d>
  25a532:	mov    %r14,%rax
  25a535:	shl    $0x4,%rax
  25a539:	lea    (%rax,%rax,2),%rdx
  25a53d:	lea    (%r15,%r15,2),%rdi
  25a541:	shl    $0x4,%rdi
  25a545:	add    0x8f0(%r12),%rdi
  25a54d:	mov    %r13,%rsi
  25a550:	call   *0x3984ba(%rip)        # 5f2a10 <memcpy@GLIBC_2.14>
  25a556:	add    %r14,%r15
  25a559:	mov    %r15,0x8f8(%r12)
  25a561:	cmpq   $0x0,0x28(%rsp)
  25a567:	je     25a572 <<glass::engine::Engine>::apply+0x2032>
  25a569:	mov    %r13,%rdi
  25a56c:	call   *0x3984b6(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25a572:	mov    0x170(%rsp),%r15
  25a57a:	lea    0x178(%rsp),%rax
  25a582:	movups (%rax),%xmm0
  25a585:	movups 0x10(%rax),%xmm1
  25a589:	movups 0x20(%rax),%xmm2
  25a58d:	movaps %xmm0,0x80(%rsp)
  25a595:	movaps %xmm1,0x90(%rsp)
  25a59d:	movaps %xmm2,0xa0(%rsp)
  25a5a5:	movq   $0xffffffffffffffff,0x170(%rsp)
  25a5b1:	cmp    $0xffffffffffffffff,%r15
  25a5b5:	je     25a5e0 <<glass::engine::Engine>::apply+0x20a0>
  25a5b7:	cmpq   $0x0,0x998(%r12)
  25a5c0:	jle    25a63a <<glass::engine::Engine>::apply+0x20fa>
  25a5c2:	mov    (%rbx),%rdi
  25a5c5:	call   *0x39845d(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25a5cb:	cmpq   $0x0,0x170(%rsp)
  25a5d4:	setg   %bpl
  25a5d8:	jmp    25a63c <<glass::engine::Engine>::apply+0x20fc>
  25a5da:	nopw   0x0(%rax,%rax,1)
  25a5e0:	xor    %ebp,%ebp
  25a5e2:	jmp    25a667 <<glass::engine::Engine>::apply+0x2127>
  25a5e7:	nopw   0x0(%rax,%rax,1)
  25a5f0:	xor    %ecx,%ecx
  25a5f2:	cmp    %r15,%rcx
  25a5f5:	jae    25a363 <<glass::engine::Engine>::apply+0x1e23>
  25a5fb:	mov    0x60(%rsp),%rdi
  25a600:	mov    %r13,%rsi
  25a603:	mov    %r15,%rdx
  25a606:	mov    %r15,%r8
  25a609:	call   270180 <<glass::engine::Mirror>::stretch>
  25a60e:	cmp    %r15,%rax
  25a611:	jae    25a6e9 <<glass::engine::Engine>::apply+0x21a9>
  25a617:	cmpb   $0x0,0xa80(%r12)
  25a620:	jne    25a6e9 <<glass::engine::Engine>::apply+0x21a9>
  25a626:	movzbl -0x1(%r14),%eax
  25a62b:	shr    $0x7,%al
  25a62e:	mov    0x60(%rsp),%rcx
  25a633:	mov    %al,(%rcx)
  25a635:	jmp    25a6f1 <<glass::engine::Engine>::apply+0x21b1>
  25a63a:	xor    %ebp,%ebp
  25a63c:	mov    %r15,0x998(%r12)
  25a644:	movaps 0x80(%rsp),%xmm0
  25a64c:	movaps 0x90(%rsp),%xmm1
  25a654:	movaps 0xa0(%rsp),%xmm2
  25a65c:	movups %xmm2,0x20(%rbx)
  25a660:	movups %xmm1,0x10(%rbx)
  25a664:	movups %xmm0,(%rbx)
  25a667:	mov    0x158(%rsp),%rbx
  25a66f:	mov    0x160(%rsp),%r12
  25a677:	mov    0x178(%rsp),%r15
  25a67f:	cmpq   $0x0,0x140(%rsp)
  25a688:	je     25a698 <<glass::engine::Engine>::apply+0x2158>
  25a68a:	mov    0x148(%rsp),%rdi
  25a692:	call   *0x398390(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25a698:	test   %rbx,%rbx
  25a69b:	je     25a6a6 <<glass::engine::Engine>::apply+0x2166>
  25a69d:	mov    %r12,%rdi
  25a6a0:	call   *0x398382(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25a6a6:	test   %bpl,%bpl
  25a6a9:	je     25a6b4 <<glass::engine::Engine>::apply+0x2174>
  25a6ab:	mov    %r15,%rdi
  25a6ae:	call   *0x398374(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25a6b4:	mov    0x38(%rsp),%rbx
  25a6b9:	mov    %rbx,%rdi
  25a6bc:	call   2577b0 <<glass::engine::Engine>::fold_sentinel>
  25a6c1:	test   %r14,%r14
  25a6c4:	setne  %al
  25a6c7:	cmpq   $0x0,0x28(%rsp)
  25a6cd:	sete   %cl
  25a6d0:	or     %al,%cl
  25a6d2:	cmp    $0x1,%cl
  25a6d5:	je     258620 <<glass::engine::Engine>::apply+0xe0>
  25a6db:	mov    %r13,%rdi
  25a6de:	call   *0x398344(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25a6e4:	jmp    258620 <<glass::engine::Engine>::apply+0xe0>
  25a6e9:	mov    0x60(%rsp),%rax
  25a6ee:	movzbl (%rax),%eax
  25a6f1:	mov    %al,0xa7f(%r12)
  25a6f9:	mov    0xe0(%rsp),%rbx
  25a701:	xor    %ebp,%ebp
  25a703:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a710:	cmpl   $0xffffffff,0x710(%r12)
  25a719:	jne    25a774 <<glass::engine::Engine>::apply+0x2234>
  25a71b:	mov    0x78(%rsp),%rax
  25a720:	mov    %rax,0x80(%rsp)
  25a728:	lea    0x130(%rsp),%rax
  25a730:	mov    %rax,0x88(%rsp)
  25a738:	movb   $0x0,0x90(%rsp)
  25a740:	mov    %r15,%rcx
  25a743:	sub    %rbp,%rcx
  25a746:	jb     25a8aa <<glass::engine::Engine>::apply+0x236a>
  25a74c:	mov    %r13,%rdx
  25a74f:	add    %rbp,%rdx
  25a752:	mov    0xf0(%rsp),%rdi
  25a75a:	lea    0x80(%rsp),%rsi
  25a762:	call   1a0870 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a767:	add    %rax,%rbp
  25a76a:	cmp    %r15,%rbp
  25a76d:	jne    25a710 <<glass::engine::Engine>::apply+0x21d0>
  25a76f:	jmp    25a460 <<glass::engine::Engine>::apply+0x1f20>
  25a774:	mov    %r15,%rcx
  25a777:	sub    %rbp,%rcx
  25a77a:	jb     25a9b6 <<glass::engine::Engine>::apply+0x2476>
  25a780:	mov    %r13,%rdx
  25a783:	add    %rbp,%rdx
  25a786:	mov    0x78(%rsp),%rdi
  25a78b:	lea    0x130(%rsp),%rsi
  25a793:	call   1945d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a798:	jmp    25a767 <<glass::engine::Engine>::apply+0x2227>
  25a79a:	mov    %r15,%rdx
  25a79d:	add    0x8(%rsp),%r13
  25a7a2:	cmpb   $0x1,0x58(%rsp)
  25a7a7:	jne    25a7d7 <<glass::engine::Engine>::apply+0x2297>
  25a7a9:	cmpl   $0xffffffff,0x710(%r12)
  25a7b2:	jne    25a7d7 <<glass::engine::Engine>::apply+0x2297>
  25a7b4:	lea    0x130(%rsp),%rdi
  25a7bc:	mov    %r13,%rsi
  25a7bf:	call   2a1c20 <glass::engine::plain_c0>
  25a7c4:	test   %al,%al
  25a7c6:	mov    0xe0(%rsp),%rbx
  25a7ce:	mov    %r15,%rdx
  25a7d1:	jne    25a460 <<glass::engine::Engine>::apply+0x1f20>
  25a7d7:	xor    %ebp,%ebp
  25a7d9:	nopl   0x0(%rax)
  25a7e0:	cmpl   $0xffffffff,0x710(%r12)
  25a7e9:	jne    25a847 <<glass::engine::Engine>::apply+0x2307>
  25a7eb:	mov    0x78(%rsp),%rax
  25a7f0:	mov    %rax,0x80(%rsp)
  25a7f8:	lea    0x130(%rsp),%rax
  25a800:	mov    %rax,0x88(%rsp)
  25a808:	movb   $0x0,0x90(%rsp)
  25a810:	mov    %r15,%rcx
  25a813:	sub    %rbp,%rcx
  25a816:	jb     25a8aa <<glass::engine::Engine>::apply+0x236a>
  25a81c:	mov    %r13,%rdx
  25a81f:	add    %rbp,%rdx
  25a822:	mov    0xf0(%rsp),%rdi
  25a82a:	lea    0x80(%rsp),%rsi
  25a832:	call   1a0870 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a837:	add    %rax,%rbp
  25a83a:	mov    %r15,%rdx
  25a83d:	cmp    %r15,%rbp
  25a840:	jne    25a7e0 <<glass::engine::Engine>::apply+0x22a0>
  25a842:	jmp    25a460 <<glass::engine::Engine>::apply+0x1f20>
  25a847:	mov    %rdx,%rcx
  25a84a:	sub    %rbp,%rcx
  25a84d:	jb     25a9b6 <<glass::engine::Engine>::apply+0x2476>
  25a853:	mov    %r13,%rdx
  25a856:	add    %rbp,%rdx
  25a859:	mov    0x78(%rsp),%rdi
  25a85e:	lea    0x130(%rsp),%rsi
  25a866:	call   1945d0 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a86b:	jmp    25a837 <<glass::engine::Engine>::apply+0x22f7>
  25a86d:	mov    $0x8,%ecx
  25a872:	mov    $0x30,%r8d
  25a878:	mov    0x228(%rsp),%rdi
  25a880:	mov    %r15,%rsi
  25a883:	mov    %r14,%rdx
  25a886:	call   1cfb70 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  25a88b:	mov    0x8f8(%r12),%r15
  25a893:	jmp    25a532 <<glass::engine::Engine>::apply+0x1ff2>
  25a898:	add    $0x248,%rsp
  25a89f:	pop    %rbx
  25a8a0:	pop    %r12
  25a8a2:	pop    %r13
  25a8a4:	pop    %r14
  25a8a6:	pop    %r15
  25a8a8:	pop    %rbp
  25a8a9:	ret
  25a8aa:	mov    %r15,%r8
  25a8ad:	lea    0x35a744(%rip),%rcx        # 5b4ff8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25a8b4:	jmp    25a8d1 <<glass::engine::Engine>::apply+0x2391>
  25a8b6:	mov    %rbx,%r8
  25a8b9:	lea    0x36f710(%rip),%rcx        # 5c9fd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15850>
  25a8c0:	mov    0x18(%rsp),%r15
  25a8c5:	jmp    25a8d1 <<glass::engine::Engine>::apply+0x2391>
  25a8c7:	mov    %rbx,%r8
  25a8ca:	lea    0x36f6ff(%rip),%rcx        # 5c9fd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15850>
  25a8d1:	mov    %rbp,%rdi
  25a8d4:	mov    %r8,%rsi
  25a8d7:	mov    %r15,%rdx
  25a8da:	call   *0x3982d8(%rip)        # 5f2bb8 <_DYNAMIC+0x3d8>
  25a8e0:	jmp    25aa6f <<glass::engine::Engine>::apply+0x252f>
  25a8e5:	mov    %rbx,%rbp
  25a8e8:	mov    %r13,%r8
  25a8eb:	lea    0x371b56(%rip),%rcx        # 5cc448 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cc8>
  25a8f2:	mov    0x18(%rsp),%r15
  25a8f7:	jmp    25a8d1 <<glass::engine::Engine>::apply+0x2391>
  25a8f9:	lea    0x371b78(%rip),%rcx        # 5cc478 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cf8>
  25a900:	xor    %ebp,%ebp
  25a902:	mov    0x18(%rsp),%r15
  25a907:	mov    %rdx,%r8
  25a90a:	jmp    25a8d1 <<glass::engine::Engine>::apply+0x2391>
  25a90c:	mov    0x8(%rsp),%rbp
  25a911:	mov    %rbx,%r8
  25a914:	lea    0x371b45(%rip),%rcx        # 5cc460 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17ce0>
  25a91b:	mov    0x18(%rsp),%r15
  25a920:	jmp    25a8d1 <<glass::engine::Engine>::apply+0x2391>
  25a922:	mov    $0xffffffffffffffff,%r8
  25a929:	xor    %ebp,%ebp
  25a92b:	xor    %r15d,%r15d
  25a92e:	lea    0x371afb(%rip),%rcx        # 5cc430 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cb0>
  25a935:	jmp    25a8d1 <<glass::engine::Engine>::apply+0x2391>
  25a937:	mov    %r13,%rbp
  25a93a:	jmp    25a8b9 <<glass::engine::Engine>::apply+0x2379>
  25a93f:	mov    %r15,%r8
  25a942:	jmp    25a8ca <<glass::engine::Engine>::apply+0x238a>
  25a944:	lea    0x371ab5(%rip),%rdx        # 5cc400 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c80>
  25a94b:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25a94d:	mov    %r13,%rbp
  25a950:	lea    0x371b39(%rip),%rcx        # 5cc490 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d10>
  25a957:	mov    0x18(%rsp),%r15
  25a95c:	jmp    25a8d1 <<glass::engine::Engine>::apply+0x2391>
  25a961:	lea    0x371ab0(%rip),%rdx        # 5cc418 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c98>
  25a968:	mov    %r14,%rdi
  25a96b:	mov    0x18(%rsp),%rsi
  25a970:	call   *0x398082(%rip)        # 5f29f8 <_DYNAMIC+0x218>
  25a976:	jmp    25aa6f <<glass::engine::Engine>::apply+0x252f>
  25a97b:	mov    $0x10,%eax
  25a980:	mov    %rax,0x18(%rsp)
  25a985:	mov    $0xffffffffffffffff,%r14
  25a98c:	lea    0x371b15(%rip),%rdx        # 5cc4a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d28>
  25a993:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25a995:	mov    $0x8,%edi
  25a99a:	mov    %r14,%rsi
  25a99d:	call   *0x398045(%rip)        # 5f29e8 <_DYNAMIC+0x208>
  25a9a3:	mov    $0x10,%eax
  25a9a8:	mov    %rax,0x18(%rsp)
  25a9ad:	lea    0x371b0c(%rip),%rdx        # 5cc4c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d40>
  25a9b4:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25a9b6:	mov    %r15,%r8
  25a9b9:	lea    0x35a650(%rip),%rcx        # 5b5010 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25a9c0:	jmp    25a8d1 <<glass::engine::Engine>::apply+0x2391>
  25a9c5:	mov    $0x10,%eax
  25a9ca:	mov    %rax,0x18(%rsp)
  25a9cf:	lea    0x371b02(%rip),%rdx        # 5cc4d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d58>
  25a9d6:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25a9d8:	mov    %rsi,%r14
  25a9db:	mov    0x10(%rsp),%rax
  25a9e0:	mov    %rax,0x18(%rsp)
  25a9e5:	lea    0x3719fc(%rip),%rdx        # 5cc3e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c68>
  25a9ec:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25a9f1:	mov    0x30(%rsp),%r14
  25a9f6:	mov    %rcx,0x18(%rsp)
  25a9fb:	lea    0x35d366(%rip),%rdx        # 5b7d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25aa02:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25aa07:	mov    %rcx,%r14
  25aa0a:	mov    %rdx,0x18(%rsp)
  25aa0f:	lea    0x35d352(%rip),%rdx        # 5b7d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  25aa16:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25aa1b:	lea    0x36ed26(%rip),%rcx        # 5c9748 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  25aa22:	mov    0x68(%rsp),%rdi
  25aa27:	mov    0x40(%rsp),%rsi
  25aa2c:	call   *0x398186(%rip)        # 5f2bb8 <_DYNAMIC+0x3d8>
  25aa32:	jmp    25aa6f <<glass::engine::Engine>::apply+0x252f>
  25aa34:	mov    0x30(%rsp),%r14
  25aa39:	jmp    25aa47 <<glass::engine::Engine>::apply+0x2507>
  25aa3b:	mov    0x30(%rsp),%r14
  25aa40:	jmp    25aa76 <<glass::engine::Engine>::apply+0x2536>
  25aa42:	mov    0x70(%rsp),%r14
  25aa47:	mov    %rax,0x18(%rsp)
  25aa4c:	lea    0x36f8f5(%rip),%rdx        # 5ca348 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bc8>
  25aa53:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25aa58:	lea    0x36ece9(%rip),%rcx        # 5c9748 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fc8>
  25aa5f:	mov    0x68(%rsp),%rdi
  25aa64:	mov    0x40(%rsp),%rsi
  25aa69:	call   *0x398149(%rip)        # 5f2bb8 <_DYNAMIC+0x3d8>
  25aa6f:	ud2
  25aa71:	mov    0x70(%rsp),%r14
  25aa76:	mov    %rax,0x18(%rsp)
  25aa7b:	lea    0x36f8ae(%rip),%rdx        # 5ca330 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15bb0>
  25aa82:	jmp    25a968 <<glass::engine::Engine>::apply+0x2428>
  25aa87:	mov    %rax,%r15
  25aa8a:	cmpq   $0x0,0x28(%rsp)
  25aa90:	je     25aafa <<glass::engine::Engine>::apply+0x25ba>
  25aa92:	mov    %r13,%rdi
  25aa95:	call   *0x397f8d(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25aa9b:	jmp    25aafa <<glass::engine::Engine>::apply+0x25ba>
  25aa9d:	mov    %rax,%r15
  25aaa0:	lock decq (%r12)
  25aaa5:	je     25aab7 <<glass::engine::Engine>::apply+0x2577>
  25aaa7:	jmp    25aafa <<glass::engine::Engine>::apply+0x25ba>
  25aaa9:	mov    %rax,%r15
  25aaac:	mov    0x8(%rsp),%rax
  25aab1:	lock decq (%rax)
  25aab5:	jne    25aafa <<glass::engine::Engine>::apply+0x25ba>
  25aab7:	lea    0xb0(%rsp),%rdi
  25aabf:	call   *0x397f83(%rip)        # 5f2a48 <_DYNAMIC+0x268>
  25aac5:	jmp    25aafa <<glass::engine::Engine>::apply+0x25ba>
  25aac7:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aac9:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aacb:	mov    %rax,%r15
  25aace:	test   %r14,%r14
  25aad1:	setne  %al
  25aad4:	cmpq   $0x0,0x28(%rsp)
  25aada:	sete   %cl
  25aadd:	or     %al,%cl
  25aadf:	jne    25ab66 <<glass::engine::Engine>::apply+0x2626>
  25aae5:	jmp    25ab23 <<glass::engine::Engine>::apply+0x25e3>
  25aae7:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aae9:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aaeb:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aaed:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aaef:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aaf1:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aaf3:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aaf5:	jmp    25aaf7 <<glass::engine::Engine>::apply+0x25b7>
  25aaf7:	mov    %rax,%r15
  25aafa:	cmpq   $0x0,0x140(%rsp)
  25ab03:	jne    25ab34 <<glass::engine::Engine>::apply+0x25f4>
  25ab05:	cmpq   $0x0,0x158(%rsp)
  25ab0e:	jne    25ab4d <<glass::engine::Engine>::apply+0x260d>
  25ab10:	cmpq   $0x0,0x170(%rsp)
  25ab19:	jle    25ab66 <<glass::engine::Engine>::apply+0x2626>
  25ab1b:	mov    0x178(%rsp),%r13
  25ab23:	mov    %r13,%rdi
  25ab26:	call   *0x397efc(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25ab2c:	mov    %r15,%rdi
  25ab2f:	call   5b1070 <_Unwind_Resume@plt>
  25ab34:	mov    0x148(%rsp),%rdi
  25ab3c:	call   *0x397ee6(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25ab42:	cmpq   $0x0,0x158(%rsp)
  25ab4b:	je     25ab10 <<glass::engine::Engine>::apply+0x25d0>
  25ab4d:	mov    0x160(%rsp),%rdi
  25ab55:	call   *0x397ecd(%rip)        # 5f2a28 <_DYNAMIC+0x248>
  25ab5b:	cmpq   $0x0,0x170(%rsp)
  25ab64:	jg     25ab1b <<glass::engine::Engine>::apply+0x25db>
  25ab66:	mov    %r15,%rdi
  25ab69:	call   5b1070 <_Unwind_Resume@plt>
