
/tmp/glass-i32-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000259690 <<glass::engine::Engine>::apply>:
  259690:	push   %rbp
  259691:	push   %r15
  259693:	push   %r14
  259695:	push   %r13
  259697:	push   %r12
  259699:	push   %rbx
  25969a:	sub    $0x2a8,%rsp
  2596a1:	mov    %rdi,%rbx
  2596a4:	testb  $0x10,0x6d5(%rdi)
  2596ab:	jne    25970d <<glass::engine::Engine>::apply+0x7d>
  2596ad:	cmpb   $0x2,0x278(%rbx)
  2596b4:	jne    25970d <<glass::engine::Engine>::apply+0x7d>
  2596b6:	mov    0xb0(%rbx),%rax
  2596bd:	dec    %rax
  2596c0:	movq   $0x0,0x250(%rbx)
  2596cb:	movl   $0x0,0x258(%rbx)
  2596d5:	movb   $0x0,0x260(%rbx)
  2596dc:	mov    %rax,0x268(%rbx)
  2596e3:	movl   $0x0,0x270(%rbx)
  2596ed:	movb   $0x1,0x278(%rbx)
  2596f4:	movb   $0x0,0x280(%rbx)
  2596fb:	movq   $0x0,0xa60(%rbx)
  259706:	movb   $0x1,0xa7d(%rbx)
  25970d:	test   %rdx,%rdx
  259710:	je     25bb78 <<glass::engine::Engine>::apply+0x24e8>
  259716:	lea    0x10(%rbx),%rax
  25971a:	mov    %rax,0x298(%rsp)
  259722:	lea    0x6f0(%rbx),%rax
  259729:	mov    %rax,0x78(%rsp)
  25972e:	lea    0x8e8(%rbx),%rax
  259735:	mov    %rax,0x288(%rsp)
  25973d:	lea    0xa7e(%rbx),%rax
  259744:	mov    %rax,0x60(%rsp)
  259749:	lea    0x720(%rbx),%rax
  259750:	mov    %rax,0x118(%rsp)
  259758:	lea    0x9a0(%rbx),%rax
  25975f:	mov    %rax,0x108(%rsp)
  259767:	mov    %rbx,0x38(%rsp)
  25976c:	jmp    25978b <<glass::engine::Engine>::apply+0xfb>
  25976e:	xchg   %ax,%ax
  259770:	mov    0x138(%rsp),%rsi
  259778:	mov    0x2a0(%rsp),%rdx
  259780:	sub    0x18(%rsp),%rdx
  259785:	je     25bb78 <<glass::engine::Engine>::apply+0x24e8>
  25978b:	mov    %rsi,0x28(%rsp)
  259790:	cmp    $0x2000,%rdx
  259797:	mov    $0x2000,%eax
  25979c:	mov    %rdx,0x2a0(%rsp)
  2597a4:	cmovb  %rdx,%rax
  2597a8:	mov    %rax,0x18(%rsp)
  2597ad:	mov    0x6d4(%rbx),%ebp
  2597b3:	mov    $0x1000,%eax
  2597b8:	and    %eax,%ebp
  2597ba:	mov    0xa58(%rbx),%r9
  2597c1:	mov    $0x0,%r10d
  2597c7:	cmove  %r9,%r10
  2597cb:	mov    0xa68(%rbx),%rax
  2597d2:	mov    %rax,%r11
  2597d5:	cmove  %r9,%r11
  2597d9:	mov    0x910(%rbx),%r13
  2597e0:	mov    $0x8,%r12d
  2597e6:	test   %r13,%r13
  2597e9:	je     25984c <<glass::engine::Engine>::apply+0x1bc>
  2597eb:	mov    %r11,0x58(%rsp)
  2597f0:	mov    %r10,0x10(%rsp)
  2597f5:	mov    %r9,0x8(%rsp)
  2597fa:	mov    0x908(%rbx),%r15
  259801:	lea    0x0(,%r13,8),%rax
  259809:	lea    (%rax,%rax,2),%r14
  25980d:	mov    $0x8,%esi
  259812:	mov    %r14,%rdi
  259815:	call   *0x39d02d(%rip)        # 5f6848 <_DYNAMIC+0x228>
  25981b:	test   %rax,%rax
  25981e:	je     25bc75 <<glass::engine::Engine>::apply+0x25e5>
  259824:	mov    %rax,%r12
  259827:	mov    %rax,%rdi
  25982a:	mov    %r15,%rsi
  25982d:	mov    %r14,%rdx
  259830:	call   *0x39d01a(%rip)        # 5f6850 <memcpy@GLIBC_2.14>
  259836:	mov    0xa68(%rbx),%rax
  25983d:	mov    0x8(%rsp),%r9
  259842:	mov    0x10(%rsp),%r10
  259847:	mov    0x58(%rsp),%r11
  25984c:	mov    0x18(%rsp),%r15
  259851:	mov    0x28(%rsp),%r14
  259856:	lea    (%r14,%r15,1),%rcx
  25985a:	mov    %rcx,0x138(%rsp)
  259862:	mov    0xa78(%rbx),%ecx
  259868:	mov    0xa60(%rbx),%rdx
  25986f:	movzbl 0xa7d(%rbx),%esi
  259876:	movzbl 0xa81(%rbx),%edi
  25987d:	mov    0x298(%rsp),%r8
  259885:	mov    %r8,0x228(%rsp)
  25988d:	movq   $0x0,0x1c0(%rsp)
  259899:	movq   $0x8,0x1c8(%rsp)
  2598a5:	movq   $0x0,0x1d0(%rsp)
  2598b1:	mov    %r13,0x1d8(%rsp)
  2598b9:	mov    %r12,0x1e0(%rsp)
  2598c1:	mov    %r13,0x1e8(%rsp)
  2598c9:	mov    %r11,0x230(%rsp)
  2598d1:	mov    %r10,0x238(%rsp)
  2598d9:	shr    $0xc,%ebp
  2598dc:	mov    %bpl,0x26c(%rsp)
  2598e4:	mov    %rax,0x240(%rsp)
  2598ec:	mov    %ecx,0x268(%rsp)
  2598f3:	mov    %rdx,0x248(%rsp)
  2598fb:	mov    %sil,0x26d(%rsp)
  259903:	mov    %r15,0x250(%rsp)
  25990b:	movups (%rbx),%xmm0
  25990e:	movaps %xmm0,0x1b0(%rsp)
  259916:	movq   $0xffffffffffffffff,0x1f0(%rsp)
  259922:	mov    %r9,0x258(%rsp)
  25992a:	mov    %dil,0x26e(%rsp)
  259932:	mov    0xa70(%rbx),%rax
  259939:	mov    %rax,0x260(%rsp)
  259941:	test   %dil,%dil
  259944:	mov    %rbx,%r12
  259947:	je     25b5f0 <<glass::engine::Engine>::apply+0x1f60>
  25994d:	mov    $0x3,%eax
  259952:	sub    %r15,%rax
  259955:	mov    %rax,0x290(%rsp)
  25995d:	mov    $0x1,%al
  25995f:	mov    %eax,0x8c(%rsp)
  259966:	xor    %ebp,%ebp
  259968:	mov    %r14,0x278(%rsp)
  259970:	mov    $0x1,%al
  259972:	mov    %eax,0x12c(%rsp)
  259979:	movq   $0x0,0x8(%rsp)
  259982:	movl   $0x0,0x80(%rsp)
  25998d:	movq   $0x0,0x58(%rsp)
  259996:	xor    %r13d,%r13d
  259999:	testb  $0x1,0x8c(%rsp)
  2599a1:	je     259a00 <<glass::engine::Engine>::apply+0x370>
  2599a3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2599b0:	mov    0x39d729(%rip),%rax        # 5f70e0 <_DYNAMIC+0xac0>
  2599b7:	mov    (%rax),%rax
  2599ba:	mov    $0x1b,%edi
  2599bf:	mov    0x278(%rsp),%rsi
  2599c7:	mov    0x138(%rsp),%rdx
  2599cf:	call   *%rax
  2599d1:	cmp    $0x1,%rax
  2599d5:	jne    259a00 <<glass::engine::Engine>::apply+0x370>
  2599d7:	mov    %rdx,%rax
  2599da:	sub    0x28(%rsp),%rax
  2599df:	inc    %rdx
  2599e2:	mov    $0x1,%cl
  2599e4:	mov    %ecx,0x8c(%rsp)
  2599eb:	mov    %rdx,0x278(%rsp)
  2599f3:	jmp    259a29 <<glass::engine::Engine>::apply+0x399>
  2599f5:	data16 cs nopw 0x0(%rax,%rax,1)
  259a00:	testb  $0x1,0x12c(%rsp)
  259a08:	je     25b660 <<glass::engine::Engine>::apply+0x1fd0>
  259a0e:	movl   $0x0,0x12c(%rsp)
  259a19:	mov    0x18(%rsp),%rax
  259a1e:	movl   $0x0,0x8c(%rsp)
  259a29:	mov    %rax,%rdx
  259a2c:	sub    %r13,%rax
  259a2f:	cmp    $0x18,%rax
  259a33:	mov    %rdx,0x10(%rsp)
  259a38:	jb     25a080 <<glass::engine::Engine>::apply+0x9f0>
  259a3e:	cmp    %rdx,0x18(%rsp)
  259a43:	jae    259a88 <<glass::engine::Engine>::apply+0x3f8>
  259a45:	jmp    25bbd9 <<glass::engine::Engine>::apply+0x2549>
  259a4a:	mov    0x58(%rsp),%rax
  259a4f:	mov    %eax,%ebp
  259a51:	mov    0x38(%rsp),%rax
  259a56:	cmpl   $0xffffffff,0x710(%rax)
  259a5d:	je     259de6 <<glass::engine::Engine>::apply+0x756>
  259a63:	mov    %ebp,%eax
  259a65:	mov    %rax,0x58(%rsp)
  259a6a:	nopw   0x0(%rax,%rax,1)
  259a70:	mov    0x10(%rsp),%rdx
  259a75:	mov    %rdx,%rax
  259a78:	sub    %r13,%rax
  259a7b:	mov    %r13,%rbp
  259a7e:	cmp    $0x17,%rax
  259a82:	jbe    25a083 <<glass::engine::Engine>::apply+0x9f3>
  259a88:	lea    0x140(%rsp),%rdi
  259a90:	mov    0x28(%rsp),%rsi
  259a95:	mov    %r13,%rcx
  259a98:	call   2a3100 <glass::engine::next_run>
  259a9d:	movzbl 0x150(%rsp),%r12d
  259aa6:	cmp    $0x2,%r12b
  259aaa:	je     25a110 <<glass::engine::Engine>::apply+0xa80>
  259ab0:	mov    0x140(%rsp),%rbx
  259ab8:	cmp    %rbp,%rbx
  259abb:	jb     25bb96 <<glass::engine::Engine>::apply+0x2506>
  259ac1:	mov    0x18(%rsp),%r15
  259ac6:	cmp    %r15,%rbx
  259ac9:	ja     25bba7 <<glass::engine::Engine>::apply+0x2517>
  259acf:	mov    0x148(%rsp),%r13
  259ad7:	mov    0x28(%rsp),%rax
  259adc:	lea    (%rax,%rbp,1),%r15
  259ae0:	lea    (%rax,%rbx,1),%r14
  259ae4:	mov    0x39d5ed(%rip),%rax        # 5f70d8 <_DYNAMIC+0xab8>
  259aeb:	mov    (%rax),%rax
  259aee:	mov    $0x1b,%edi
  259af3:	mov    %r15,%rsi
  259af6:	mov    %r14,%rdx
  259af9:	call   *%rax
  259afb:	cmp    $0x1,%rax
  259aff:	jne    259b1d <<glass::engine::Engine>::apply+0x48d>
  259b01:	sub    %r15,%rdx
  259b04:	mov    0x38(%rsp),%rax
  259b09:	movb   $0x1,0xa80(%rax)
  259b10:	movb   $0x0,0xa7e(%rax)
  259b17:	add    %rdx,%rbp
  259b1a:	inc    %rbp
  259b1d:	cmp    %rbx,%rbp
  259b20:	jae    259b5e <<glass::engine::Engine>::apply+0x4ce>
  259b22:	mov    0x60(%rsp),%rdi
  259b27:	mov    0x28(%rsp),%rsi
  259b2c:	mov    0x18(%rsp),%rdx
  259b31:	mov    %rbp,%rcx
  259b34:	mov    %rbx,%r8
  259b37:	call   271460 <<glass::engine::Mirror>::stretch>
  259b3c:	cmp    %rbx,%rax
  259b3f:	jae    259b5e <<glass::engine::Engine>::apply+0x4ce>
  259b41:	mov    0x38(%rsp),%rax
  259b46:	cmpb   $0x0,0xa80(%rax)
  259b4d:	jne    259b5e <<glass::engine::Engine>::apply+0x4ce>
  259b4f:	movzbl -0x1(%r14),%eax
  259b54:	shr    $0x7,%al
  259b57:	mov    0x60(%rsp),%rcx
  259b5c:	mov    %al,(%rcx)
  259b5e:	mov    0x60(%rsp),%rdi
  259b63:	mov    0x28(%rsp),%rsi
  259b68:	mov    0x18(%rsp),%rdx
  259b6d:	mov    %rbx,%rcx
  259b70:	mov    %r13,%r8
  259b73:	call   271460 <<glass::engine::Mirror>::stretch>
  259b78:	mov    %rax,%rbx
  259b7b:	mov    0x38(%rsp),%rax
  259b80:	cmpb   $0x0,0xa80(%rax)
  259b87:	jne    259a70 <<glass::engine::Engine>::apply+0x3e0>
  259b8d:	lea    -0x1(%r13),%r14
  259b91:	cmp    0x18(%rsp),%r14
  259b96:	jae    25bc24 <<glass::engine::Engine>::apply+0x2594>
  259b9c:	mov    0x28(%rsp),%rax
  259ba1:	movzbl (%rax,%r14,1),%eax
  259ba6:	shr    $0x7,%al
  259ba9:	mov    0x60(%rsp),%rcx
  259bae:	mov    %al,(%rcx)
  259bb0:	test   %rbx,%rbx
  259bb3:	je     259be2 <<glass::engine::Engine>::apply+0x552>
  259bb5:	lea    -0x1(%rbx),%r14
  259bb9:	cmp    0x18(%rsp),%r14
  259bbe:	jae    25bc41 <<glass::engine::Engine>::apply+0x25b1>
  259bc4:	mov    0x28(%rsp),%rax
  259bc9:	movzbl (%rax,%r14,1),%eax
  259bce:	shr    $0x7,%al
  259bd1:	mov    %r13,%r14
  259bd4:	sub    %rbx,%r14
  259bd7:	cmp    $0x18,%r14
  259bdb:	jae    259bfe <<glass::engine::Engine>::apply+0x56e>
  259bdd:	jmp    259a70 <<glass::engine::Engine>::apply+0x3e0>
  259be2:	mov    0x38(%rsp),%rax
  259be7:	movzbl 0xa7f(%rax),%eax
  259bee:	mov    %r13,%r14
  259bf1:	sub    %rbx,%r14
  259bf4:	cmp    $0x18,%r14
  259bf8:	jb     259a70 <<glass::engine::Engine>::apply+0x3e0>
  259bfe:	test   %al,%al
  259c00:	jne    259a70 <<glass::engine::Engine>::apply+0x3e0>
  259c06:	mov    %rbx,%r15
  259c09:	sub    0x8(%rsp),%r15
  259c0e:	jbe    259a4a <<glass::engine::Engine>::apply+0x3ba>
  259c14:	movzbl 0x3a2edd(%rip),%eax        # 5fcaf8 <glass::engine::probes::RUN_PROBE>
  259c1b:	mov    $0x1,%bpl
  259c1e:	cmp    $0x68,%al
  259c20:	je     259dcf <<glass::engine::Engine>::apply+0x73f>
  259c26:	cmp    0x18(%rsp),%rbx
  259c2b:	ja     25bbec <<glass::engine::Engine>::apply+0x255c>
  259c31:	mov    0x8(%rsp),%rax
  259c36:	add    0x28(%rsp),%rax
  259c3b:	mov    %rax,0x8(%rsp)
  259c40:	cmpb   $0x1,0x58(%rsp)
  259c45:	jne    259c72 <<glass::engine::Engine>::apply+0x5e2>
  259c47:	mov    0x38(%rsp),%rax
  259c4c:	cmpl   $0xffffffff,0x710(%rax)
  259c53:	jne    259c72 <<glass::engine::Engine>::apply+0x5e2>
  259c55:	lea    0x1b0(%rsp),%rdi
  259c5d:	mov    0x8(%rsp),%rsi
  259c62:	mov    %r15,%rdx
  259c65:	call   2a33f0 <glass::engine::plain_c0>
  259c6a:	test   %al,%al
  259c6c:	jne    259dcf <<glass::engine::Engine>::apply+0x73f>
  259c72:	movzbl 0x3a2e8f(%rip),%eax        # 5fcb08 <glass::engine::timers::ON>
  259c79:	test   %al,%al
  259c7b:	je     259eaf <<glass::engine::Engine>::apply+0x81f>
  259c81:	mov    $0x1,%edi
  259c86:	call   513600 <<std::sys::pal::unix::time::Timespec>::now>
  259c8b:	mov    %rax,0x58(%rsp)
  259c90:	mov    %edx,0x30(%rsp)
  259c94:	xor    %ebp,%ebp
  259c96:	cs nopw 0x0(%rax,%rax,1)
  259ca0:	mov    0x38(%rsp),%rax
  259ca5:	cmpl   $0xffffffff,0x710(%rax)
  259cac:	jne    259d07 <<glass::engine::Engine>::apply+0x677>
  259cae:	mov    0x78(%rsp),%rax
  259cb3:	mov    %rax,0xa0(%rsp)
  259cbb:	lea    0x1b0(%rsp),%rax
  259cc3:	mov    %rax,0xa8(%rsp)
  259ccb:	movb   $0x0,0xb0(%rsp)
  259cd3:	mov    %r15,%rcx
  259cd6:	sub    %rbp,%rcx
  259cd9:	jb     25bb8a <<glass::engine::Engine>::apply+0x24fa>
  259cdf:	mov    0x8(%rsp),%rax
  259ce4:	lea    (%rax,%rbp,1),%rdx
  259ce8:	mov    0x118(%rsp),%rdi
  259cf0:	lea    0xa0(%rsp),%rsi
  259cf8:	call   1a15a0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  259cfd:	add    %rax,%rbp
  259d00:	cmp    %r15,%rbp
  259d03:	jne    259ca0 <<glass::engine::Engine>::apply+0x610>
  259d05:	jmp    259d30 <<glass::engine::Engine>::apply+0x6a0>
  259d07:	mov    %r15,%rcx
  259d0a:	sub    %rbp,%rcx
  259d0d:	jb     25bc96 <<glass::engine::Engine>::apply+0x2606>
  259d13:	mov    0x8(%rsp),%rax
  259d18:	lea    (%rax,%rbp,1),%rdx
  259d1c:	mov    0x78(%rsp),%rdi
  259d21:	lea    0x1b0(%rsp),%rsi
  259d29:	call   195300 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  259d2e:	jmp    259cfd <<glass::engine::Engine>::apply+0x66d>
  259d30:	movzbl 0x3a2dd1(%rip),%eax        # 5fcb08 <glass::engine::timers::ON>
  259d37:	test   %al,%al
  259d39:	mov    $0x1,%bpl
  259d3c:	je     259dcf <<glass::engine::Engine>::apply+0x73f>
  259d42:	mov    $0x1,%edi
  259d47:	call   513600 <<std::sys::pal::unix::time::Timespec>::now>
  259d4c:	mov    %rax,0x90(%rsp)
  259d54:	mov    %edx,0x98(%rsp)
  259d5b:	mov    0x58(%rsp),%rax
  259d60:	mov    %rax,0x190(%rsp)
  259d68:	mov    0x30(%rsp),%eax
  259d6c:	mov    %eax,0x198(%rsp)
  259d73:	lea    0xa0(%rsp),%rdi
  259d7b:	lea    0x90(%rsp),%rsi
  259d83:	lea    0x190(%rsp),%rdx
  259d8b:	call   513540 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  259d90:	imul   $0x3b9aca00,0xa8(%rsp),%rax
  259d9c:	mov    0xb0(%rsp),%ecx
  259da3:	add    %rcx,%rax
  259da6:	cmpb   $0x0,0xa0(%rsp)
  259dae:	mov    $0x0,%ecx
  259db3:	cmove  %rax,%rcx
  259db7:	lock add %rcx,0x3a2d59(%rip)        # 5fcb18 <glass::engine::timers::VTE_NS>
  259dbf:	lock incq 0x3a2d81(%rip)        # 5fcb48 <glass::engine::timers::VTE_CALLS>
  259dc7:	lock add %r15,0x3a2d71(%rip)        # 5fcb40 <glass::engine::timers::VTE_BYTES>
  259dcf:	mov    %rbx,0x8(%rsp)
  259dd4:	mov    0x38(%rsp),%rax
  259dd9:	cmpl   $0xffffffff,0x710(%rax)
  259de0:	jne    259a63 <<glass::engine::Engine>::apply+0x3d3>
  259de6:	cmp    0x18(%rsp),%r13
  259deb:	ja     25bbc5 <<glass::engine::Engine>::apply+0x2535>
  259df1:	cmp    %rbx,%r13
  259df4:	jb     25bbc5 <<glass::engine::Engine>::apply+0x2535>
  259dfa:	movzbl 0x3a2cf6(%rip),%r15d        # 5fcaf8 <glass::engine::probes::RUN_PROBE>
  259e02:	movzbl 0x3a2cff(%rip),%eax        # 5fcb08 <glass::engine::timers::ON>
  259e09:	test   %al,%al
  259e0b:	je     259e3c <<glass::engine::Engine>::apply+0x7ac>
  259e0d:	mov    $0x1,%edi
  259e12:	call   513600 <<std::sys::pal::unix::time::Timespec>::now>
  259e17:	mov    %rax,0x58(%rsp)
  259e1c:	mov    %edx,%ebp
  259e1e:	cmp    $0x63,%r15b
  259e22:	jbe    259e47 <<glass::engine::Engine>::apply+0x7b7>
  259e24:	movzbl %r12b,%eax
  259e28:	mov    %r14,%rbx
  259e2b:	sub    %rax,%rbx
  259e2e:	cmp    $0xffffffff,%ebp
  259e31:	jne    259fba <<glass::engine::Engine>::apply+0x92a>
  259e37:	jmp    25a052 <<glass::engine::Engine>::apply+0x9c2>
  259e3c:	mov    $0xffffffff,%ebp
  259e41:	cmp    $0x63,%r15b
  259e45:	ja     259e24 <<glass::engine::Engine>::apply+0x794>
  259e47:	mov    0x39f9b3(%rip),%eax        # 5f9800 <glass::engine::run_whole::ON>
  259e4d:	test   %eax,%eax
  259e4f:	jne    25a071 <<glass::engine::Engine>::apply+0x9e1>
  259e55:	mov    0x28(%rsp),%rax
  259e5a:	lea    (%rax,%rbx,1),%rsi
  259e5e:	cmpb   $0x0,0x39f99f(%rip)        # 5f9804 <glass::engine::run_whole::ON+0x4>
  259e65:	je     259e86 <<glass::engine::Engine>::apply+0x7f6>
  259e67:	test   $0x1,%r12b
  259e6b:	je     259f6f <<glass::engine::Engine>::apply+0x8df>
  259e71:	lea    0x1b0(%rsp),%rdi
  259e79:	mov    %r14,%rdx
  259e7c:	call   266220 <<glass::engine::Watch>::print_run>
  259e81:	jmp    259f7f <<glass::engine::Engine>::apply+0x8ef>
  259e86:	test   $0x1,%r12b
  259e8a:	je     259f9e <<glass::engine::Engine>::apply+0x90e>
  259e90:	cmp    %rbx,%r13
  259e93:	je     25bc02 <<glass::engine::Engine>::apply+0x2572>
  259e99:	lea    -0x1(%r14),%rdx
  259e9d:	lea    0x1b0(%rsp),%rdi
  259ea5:	call   266220 <<glass::engine::Watch>::print_run>
  259eaa:	jmp    259fae <<glass::engine::Engine>::apply+0x91e>
  259eaf:	xor    %ebp,%ebp
  259eb1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  259ec0:	mov    0x38(%rsp),%rax
  259ec5:	cmpl   $0xffffffff,0x710(%rax)
  259ecc:	jne    259f27 <<glass::engine::Engine>::apply+0x897>
  259ece:	mov    0x78(%rsp),%rax
  259ed3:	mov    %rax,0xa0(%rsp)
  259edb:	lea    0x1b0(%rsp),%rax
  259ee3:	mov    %rax,0xa8(%rsp)
  259eeb:	movb   $0x0,0xb0(%rsp)
  259ef3:	mov    %r15,%rcx
  259ef6:	sub    %rbp,%rcx
  259ef9:	jb     25bb8a <<glass::engine::Engine>::apply+0x24fa>
  259eff:	mov    0x8(%rsp),%rax
  259f04:	lea    (%rax,%rbp,1),%rdx
  259f08:	mov    0x118(%rsp),%rdi
  259f10:	lea    0xa0(%rsp),%rsi
  259f18:	call   1a15a0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  259f1d:	add    %rax,%rbp
  259f20:	cmp    %r15,%rbp
  259f23:	jne    259ec0 <<glass::engine::Engine>::apply+0x830>
  259f25:	jmp    259f50 <<glass::engine::Engine>::apply+0x8c0>
  259f27:	mov    %r15,%rcx
  259f2a:	sub    %rbp,%rcx
  259f2d:	jb     25bc96 <<glass::engine::Engine>::apply+0x2606>
  259f33:	mov    0x8(%rsp),%rax
  259f38:	lea    (%rax,%rbp,1),%rdx
  259f3c:	mov    0x78(%rsp),%rdi
  259f41:	lea    0x1b0(%rsp),%rsi
  259f49:	call   195300 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  259f4e:	jmp    259f1d <<glass::engine::Engine>::apply+0x88d>
  259f50:	mov    %rbx,0x8(%rsp)
  259f55:	mov    $0x1,%bpl
  259f58:	mov    0x38(%rsp),%rax
  259f5d:	cmpl   $0xffffffff,0x710(%rax)
  259f64:	jne    259a63 <<glass::engine::Engine>::apply+0x3d3>
  259f6a:	jmp    259de6 <<glass::engine::Engine>::apply+0x756>
  259f6f:	lea    0x1b0(%rsp),%rdi
  259f77:	mov    %r14,%rdx
  259f7a:	call   263880 <<glass::engine::Watch>::print_utf8>
  259f7f:	mov    %rax,%rbx
  259f82:	mov    0x260(%rsp),%eax
  259f89:	mov    0x38(%rsp),%rcx
  259f8e:	mov    %eax,0x718(%rcx)
  259f94:	cmp    $0xffffffff,%ebp
  259f97:	jne    259fba <<glass::engine::Engine>::apply+0x92a>
  259f99:	jmp    25a052 <<glass::engine::Engine>::apply+0x9c2>
  259f9e:	lea    0x1b0(%rsp),%rdi
  259fa6:	mov    %r14,%rdx
  259fa9:	call   263880 <<glass::engine::Watch>::print_utf8>
  259fae:	mov    %rax,%rbx
  259fb1:	cmp    $0xffffffff,%ebp
  259fb4:	je     25a052 <<glass::engine::Engine>::apply+0x9c2>
  259fba:	movzbl 0x3a2b47(%rip),%eax        # 5fcb08 <glass::engine::timers::ON>
  259fc1:	test   %al,%al
  259fc3:	je     25a04a <<glass::engine::Engine>::apply+0x9ba>
  259fc9:	mov    $0x1,%edi
  259fce:	call   513600 <<std::sys::pal::unix::time::Timespec>::now>
  259fd3:	mov    %rax,0x90(%rsp)
  259fdb:	mov    %edx,0x98(%rsp)
  259fe2:	mov    0x58(%rsp),%rax
  259fe7:	mov    %rax,0x190(%rsp)
  259fef:	mov    %ebp,0x198(%rsp)
  259ff6:	lea    0xa0(%rsp),%rdi
  259ffe:	lea    0x90(%rsp),%rsi
  25a006:	lea    0x190(%rsp),%rdx
  25a00e:	call   513540 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  25a013:	imul   $0x3b9aca00,0xa8(%rsp),%rax
  25a01f:	mov    0xb0(%rsp),%ecx
  25a026:	add    %rcx,%rax
  25a029:	cmpb   $0x0,0xa0(%rsp)
  25a031:	mov    $0x0,%ecx
  25a036:	cmove  %rax,%rcx
  25a03a:	lock add %rcx,0x3a2ace(%rip)        # 5fcb10 <glass::engine::timers::RUN_NS>
  25a042:	lock incq 0x3a2aee(%rip)        # 5fcb38 <glass::engine::timers::RUN_CALLS>
  25a04a:	lock add %r14,0x3a2ade(%rip)        # 5fcb30 <glass::engine::timers::RUN_BYTES>
  25a052:	movzbl 0x3a2aff(%rip),%eax        # 5fcb58 <glass::engine::counters::COUNTING>
  25a059:	test   %al,%al
  25a05b:	je     25a065 <<glass::engine::Engine>::apply+0x9d5>
  25a05d:	lock add %rbx,0x3a2aeb(%rip)        # 5fcb50 <glass::engine::counters::LANE_RUN_BYTES>
  25a065:	add    %rbx,0x8(%rsp)
  25a06a:	mov    $0x1,%al
  25a06c:	jmp    259a65 <<glass::engine::Engine>::apply+0x3d5>
  25a071:	call   18c936 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25a076:	jmp    259e55 <<glass::engine::Engine>::apply+0x7c5>
  25a07b:	nopl   0x0(%rax,%rax,1)
  25a080:	mov    %rbp,%r13
  25a083:	mov    $0x1,%ebx
  25a088:	mov    0x18(%rsp),%rax
  25a08d:	sub    %rdx,%rax
  25a090:	jbe    25a12b <<glass::engine::Engine>::apply+0xa9b>
  25a096:	mov    0x8(%rsp),%rcx
  25a09b:	cmp    %rcx,0x110(%rsp)
  25a0a3:	sete   %r9b
  25a0a7:	cmp    $0x2,%rax
  25a0ab:	mov    0x38(%rsp),%r12
  25a0b0:	jb     25a100 <<glass::engine::Engine>::apply+0xa70>
  25a0b2:	mov    0x28(%rsp),%rcx
  25a0b7:	mov    0x10(%rsp),%rdx
  25a0bc:	lea    (%rcx,%rdx,1),%rbp
  25a0c0:	cmpb   $0x5b,0x1(%rbp)
  25a0c4:	jne    25a100 <<glass::engine::Engine>::apply+0xa70>
  25a0c6:	xorps  %xmm0,%xmm0
  25a0c9:	movaps %xmm0,0xb0(%rsp)
  25a0d1:	movaps %xmm0,0xa0(%rsp)
  25a0d9:	cmp    $0x2,%rax
  25a0dd:	je     25a100 <<glass::engine::Engine>::apply+0xa70>
  25a0df:	movzbl 0x2(%rbp),%ecx
  25a0e3:	lea    -0x30(%rcx),%eax
  25a0e6:	cmp    $0xa,%al
  25a0e8:	jae    25a151 <<glass::engine::Engine>::apply+0xac1>
  25a0ea:	movzbl %al,%eax
  25a0ed:	xor    %r14d,%r14d
  25a0f0:	mov    0x10(%rsp),%rcx
  25a0f5:	add    $0x3,%rcx
  25a0f9:	cmp    0x18(%rsp),%rcx
  25a0fe:	jne    25a177 <<glass::engine::Engine>::apply+0xae7>
  25a100:	movl   $0x0,0x80(%rsp)
  25a10b:	jmp    25a130 <<glass::engine::Engine>::apply+0xaa0>
  25a10d:	nopl   (%rax)
  25a110:	mov    %rbp,%r13
  25a113:	mov    0x10(%rsp),%rdx
  25a118:	mov    $0x1,%ebx
  25a11d:	mov    0x18(%rsp),%rax
  25a122:	sub    %rdx,%rax
  25a125:	ja     25a096 <<glass::engine::Engine>::apply+0xa06>
  25a12b:	mov    0x38(%rsp),%r12
  25a130:	mov    0x10(%rsp),%r8
  25a135:	add    %r8,%rbx
  25a138:	mov    %r13,%rbp
  25a13b:	mov    %rbx,%r13
  25a13e:	testb  $0x1,0x8c(%rsp)
  25a146:	je     259a00 <<glass::engine::Engine>::apply+0x370>
  25a14c:	jmp    2599b0 <<glass::engine::Engine>::apply+0x320>
  25a151:	movzbl %cl,%edx
  25a154:	xor    %eax,%eax
  25a156:	lea    -0x48(%rdx),%esi
  25a159:	cmp    $0x25,%esi
  25a15c:	ja     25a190 <<glass::engine::Engine>::apply+0xb00>
  25a15e:	mov    $0x3,%r8d
  25a164:	lea    -0x1eb303(%rip),%rdi        # 6ee68 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2cd7>
  25a16b:	movslq (%rdi,%rsi,4),%rdx
  25a16f:	add    %rdi,%rdx
  25a172:	xor    %r14d,%r14d
  25a175:	jmp    *%rdx
  25a177:	mov    0x10(%rsp),%rcx
  25a17c:	mov    0x290(%rsp),%rdx
  25a184:	lea    (%rdx,%rcx,1),%rsi
  25a188:	mov    $0x4,%r8d
  25a18e:	jmp    25a1d3 <<glass::engine::Engine>::apply+0xb43>
  25a190:	mov    $0x1,%r14d
  25a196:	cmp    $0x3b,%edx
  25a199:	je     25a0f0 <<glass::engine::Engine>::apply+0xa60>
  25a19f:	jmp    25a100 <<glass::engine::Engine>::apply+0xa70>
  25a1a4:	mov    $0xffff,%cx
  25a1a8:	nopl   0x0(%rax,%rax,1)
  25a1b0:	movzbl %dil,%eax
  25a1b4:	add    %cx,%ax
  25a1b7:	mov    $0xffff,%ecx
  25a1bc:	cmovb  %ecx,%eax
  25a1bf:	lea    (%rsi,%r8,1),%rcx
  25a1c3:	inc    %rcx
  25a1c6:	inc    %r8
  25a1c9:	cmp    $0x4,%rcx
  25a1cd:	je     25a100 <<glass::engine::Engine>::apply+0xa70>
  25a1d3:	movzbl -0x1(%rbp,%r8,1),%ecx
  25a1d9:	lea    -0x30(%rcx),%edi
  25a1dc:	cmp    $0xa,%dil
  25a1e0:	jae    25a1f0 <<glass::engine::Engine>::apply+0xb60>
  25a1e2:	mov    $0xa,%cx
  25a1e6:	mul    %cx
  25a1e9:	jo     25a1a4 <<glass::engine::Engine>::apply+0xb14>
  25a1eb:	mov    %eax,%ecx
  25a1ed:	jmp    25a1b0 <<glass::engine::Engine>::apply+0xb20>
  25a1ef:	nop
  25a1f0:	movzbl %cl,%edx
  25a1f3:	cmp    $0x3b,%edx
  25a1f6:	jne    25a233 <<glass::engine::Engine>::apply+0xba3>
  25a1f8:	lea    0x1(%r14),%rcx
  25a1fc:	cmp    $0x10,%rcx
  25a200:	jae    25a100 <<glass::engine::Engine>::apply+0xa70>
  25a206:	cmp    $0xf,%r14
  25a20a:	ja     25bc5b <<glass::engine::Engine>::apply+0x25cb>
  25a210:	mov    %ax,0xa0(%rsp,%r14,2)
  25a219:	xor    %eax,%eax
  25a21b:	mov    %rcx,%r14
  25a21e:	lea    (%rsi,%r8,1),%rcx
  25a222:	inc    %rcx
  25a225:	inc    %r8
  25a228:	cmp    $0x4,%rcx
  25a22c:	jne    25a1d3 <<glass::engine::Engine>::apply+0xb43>
  25a22e:	jmp    25a100 <<glass::engine::Engine>::apply+0xa70>
  25a233:	add    $0xffffffb8,%edx
  25a236:	cmp    $0x25,%edx
  25a239:	ja     25a100 <<glass::engine::Engine>::apply+0xa70>
  25a23f:	lea    -0x1eb346(%rip),%rsi        # 6ef00 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d6f>
  25a246:	movslq (%rsi,%rdx,4),%rdx
  25a24a:	add    %rsi,%rdx
  25a24d:	jmp    *%rdx
  25a24f:	cmp    $0x10,%r14
  25a253:	jae    25bc83 <<glass::engine::Engine>::apply+0x25f3>
  25a259:	mov    %r8,0x180(%rsp)
  25a261:	mov    %ax,0xa0(%rsp,%r14,2)
  25a26a:	cmp    $0x6d,%cl
  25a26d:	setne  %cl
  25a270:	movaps 0xa0(%rsp),%xmm0
  25a278:	movaps 0xb0(%rsp),%xmm1
  25a280:	movaps %xmm0,0x190(%rsp)
  25a288:	movaps %xmm1,0x1a0(%rsp)
  25a290:	xor    %edx,%edx
  25a292:	jmp    25a2d3 <<glass::engine::Engine>::apply+0xc43>
  25a294:	cmp    $0x10,%r14
  25a298:	jae    25bca5 <<glass::engine::Engine>::apply+0x2615>
  25a29e:	mov    %r8,0x180(%rsp)
  25a2a6:	mov    %ax,0xa0(%rsp,%r14,2)
  25a2af:	movaps 0xa0(%rsp),%xmm0
  25a2b7:	movaps 0xb0(%rsp),%xmm1
  25a2bf:	movaps %xmm0,0x190(%rsp)
  25a2c7:	movaps %xmm1,0x1a0(%rsp)
  25a2cf:	mov    $0x1,%dl
  25a2d1:	xor    %ecx,%ecx
  25a2d3:	lea    0x1(%r14),%rax
  25a2d7:	movaps 0x190(%rsp),%xmm0
  25a2df:	movaps 0x1a0(%rsp),%xmm1
  25a2e7:	movaps %xmm1,0x150(%rsp)
  25a2ef:	movaps %xmm0,0x140(%rsp)
  25a2f7:	mov    %rax,0x160(%rsp)
  25a2ff:	mov    %cl,0x168(%rsp)
  25a306:	mov    %dl,0x169(%rsp)
  25a30d:	mov    0x10(%rsp),%r8
  25a312:	cmp    %r13,%r8
  25a315:	jb     25bc17 <<glass::engine::Engine>::apply+0x2587>
  25a31b:	mov    %r9b,0x30(%rsp)
  25a320:	mov    %edx,0x18c(%rsp)
  25a327:	mov    %ecx,0x188(%rsp)
  25a32e:	mov    0x28(%rsp),%rax
  25a333:	lea    (%rax,%r13,1),%r15
  25a337:	mov    0x39cd9a(%rip),%rax        # 5f70d8 <_DYNAMIC+0xab8>
  25a33e:	mov    (%rax),%rax
  25a341:	mov    $0x1b,%edi
  25a346:	mov    %r15,%rsi
  25a349:	mov    %rbp,%rdx
  25a34c:	call   *%rax
  25a34e:	cmp    $0x1,%rax
  25a352:	jne    25a36f <<glass::engine::Engine>::apply+0xcdf>
  25a354:	sub    %r15,%rdx
  25a357:	movb   $0x1,0xa80(%r12)
  25a360:	movb   $0x0,0xa7e(%r12)
  25a369:	add    %rdx,%r13
  25a36c:	inc    %r13
  25a36f:	mov    0x10(%rsp),%r8
  25a374:	cmp    %r8,%r13
  25a377:	jae    25a3c9 <<glass::engine::Engine>::apply+0xd39>
  25a379:	mov    0x60(%rsp),%rdi
  25a37e:	mov    0x28(%rsp),%rsi
  25a383:	mov    0x18(%rsp),%rdx
  25a388:	mov    %r13,%rcx
  25a38b:	call   271460 <<glass::engine::Mirror>::stretch>
  25a390:	movzbl 0xa80(%r12),%ecx
  25a399:	test   %cl,%cl
  25a39b:	setne  %dl
  25a39e:	mov    0x10(%rsp),%r8
  25a3a3:	cmp    %r8,%rax
  25a3a6:	setae  %al
  25a3a9:	or     %dl,%al
  25a3ab:	jne    25a3d2 <<glass::engine::Engine>::apply+0xd42>
  25a3ad:	movzbl -0x1(%rbp),%eax
  25a3b1:	shr    $0x7,%al
  25a3b4:	mov    0x60(%rsp),%rcx
  25a3b9:	mov    %al,(%rcx)
  25a3bb:	mov    0x28(%rsp),%r9
  25a3c0:	test   %al,%al
  25a3c2:	jne    25a3ef <<glass::engine::Engine>::apply+0xd5f>
  25a3c4:	jmp    25a4c0 <<glass::engine::Engine>::apply+0xe30>
  25a3c9:	movzbl 0xa80(%r12),%ecx
  25a3d2:	test   %cl,%cl
  25a3d4:	mov    0x28(%rsp),%r9
  25a3d9:	jne    25a70c <<glass::engine::Engine>::apply+0x107c>
  25a3df:	mov    0x60(%rsp),%rax
  25a3e4:	movzbl (%rax),%eax
  25a3e7:	test   %al,%al
  25a3e9:	je     25a4c0 <<glass::engine::Engine>::apply+0xe30>
  25a3ef:	mov    0x10(%rsp),%r8
  25a3f4:	test   %r8,%r8
  25a3f7:	je     25a70c <<glass::engine::Engine>::apply+0x107c>
  25a3fd:	cmpb   $0xc0,-0x1(%rbp)
  25a401:	jge    25a443 <<glass::engine::Engine>::apply+0xdb3>
  25a403:	cmp    $0x1,%r8
  25a407:	je     25a70c <<glass::engine::Engine>::apply+0x107c>
  25a40d:	cmpb   $0xbf,-0x2(%rbp)
  25a411:	jg     25a55d <<glass::engine::Engine>::apply+0xecd>
  25a417:	cmp    $0x2,%r8
  25a41b:	je     25a70c <<glass::engine::Engine>::apply+0x107c>
  25a421:	cmpb   $0xbf,-0x3(%rbp)
  25a425:	jg     25adb5 <<glass::engine::Engine>::apply+0x1725>
  25a42b:	cmp    $0x3,%r8
  25a42f:	je     25a70c <<glass::engine::Engine>::apply+0x107c>
  25a435:	cmpb   $0xc0,-0x4(%rbp)
  25a439:	setl   %al
  25a43c:	mov    $0x3,%edx
  25a441:	jmp    25a447 <<glass::engine::Engine>::apply+0xdb7>
  25a443:	xor    %edx,%edx
  25a445:	xor    %eax,%eax
  25a447:	test   %al,%al
  25a449:	jne    25a4b6 <<glass::engine::Engine>::apply+0xe26>
  25a44b:	mov    %rdx,%rsi
  25a44e:	not    %rsi
  25a451:	add    0x10(%rsp),%rsi
  25a456:	jae    25bcb8 <<glass::engine::Engine>::apply+0x2628>
  25a45c:	movzbl (%r9,%rsi,1),%eax
  25a461:	mov    $0x1,%ecx
  25a466:	test   %al,%al
  25a468:	jns    25a494 <<glass::engine::Engine>::apply+0xe04>
  25a46a:	lea    0x3e(%rax),%edi
  25a46d:	mov    $0x2,%ecx
  25a472:	cmp    $0x1e,%dil
  25a476:	jb     25a494 <<glass::engine::Engine>::apply+0xe04>
  25a478:	mov    %eax,%edi
  25a47a:	and    $0xf0,%dil
  25a47e:	mov    $0x3,%ecx
  25a483:	cmp    $0xe0,%dil
  25a487:	je     25a494 <<glass::engine::Engine>::apply+0xe04>
  25a489:	add    $0x10,%al
  25a48b:	mov    $0x4,%ecx
  25a490:	cmp    $0x4,%al
  25a492:	ja     25a4b6 <<glass::engine::Engine>::apply+0xe26>
  25a494:	inc    %rdx
  25a497:	cmp    %ecx,%edx
  25a499:	jne    25a4b6 <<glass::engine::Engine>::apply+0xe26>
  25a49b:	add    %r9,%rsi
  25a49e:	lea    0xa0(%rsp),%rdi
  25a4a6:	call   *0x39c464(%rip)        # 5f6910 <_DYNAMIC+0x2f0>
  25a4ac:	cmpb   $0x0,0xa0(%rsp)
  25a4b4:	je     25a4c0 <<glass::engine::Engine>::apply+0xe30>
  25a4b6:	mov    0x10(%rsp),%r8
  25a4bb:	jmp    25a70c <<glass::engine::Engine>::apply+0x107c>
  25a4c0:	mov    0x10(%rsp),%r8
  25a4c5:	mov    %r8,%rbp
  25a4c8:	sub    0x8(%rsp),%rbp
  25a4cd:	jbe    25a701 <<glass::engine::Engine>::apply+0x1071>
  25a4d3:	mov    0x39f327(%rip),%eax        # 5f9800 <glass::engine::run_whole::ON>
  25a4d9:	test   %eax,%eax
  25a4db:	jne    25adbf <<glass::engine::Engine>::apply+0x172f>
  25a4e1:	mov    0x80(%rsp),%ecx
  25a4e8:	and    0x30(%rsp),%cl
  25a4ec:	movzbl 0x39f311(%rip),%eax        # 5f9804 <glass::engine::run_whole::ON+0x4>
  25a4f3:	xor    $0x1,%rax
  25a4f7:	cmp    %rax,%rbp
  25a4fa:	seta   %al
  25a4fd:	and    %cl,%al
  25a4ff:	cmp    $0x1,%al
  25a501:	jne    25a553 <<glass::engine::Engine>::apply+0xec3>
  25a503:	mov    0x8(%rsp),%rcx
  25a508:	mov    %rcx,%rax
  25a50b:	cmp    %rcx,0x10(%rsp)
  25a510:	mov    0x28(%rsp),%rdx
  25a515:	je     25a536 <<glass::engine::Engine>::apply+0xea6>
  25a517:	nopw   0x0(%rax,%rax,1)
  25a520:	movzbl (%rdx,%rax,1),%ecx
  25a524:	add    $0xe0,%cl
  25a527:	cmp    $0x5f,%cl
  25a52a:	jae    25a541 <<glass::engine::Engine>::apply+0xeb1>
  25a52c:	inc    %rax
  25a52f:	cmp    %rax,0x10(%rsp)
  25a534:	jne    25a520 <<glass::engine::Engine>::apply+0xe90>
  25a536:	cmpl   $0xffffffff,0x710(%r12)
  25a53f:	je     25a567 <<glass::engine::Engine>::apply+0xed7>
  25a541:	mov    0x10(%rsp),%r8
  25a546:	mov    0x110(%rsp),%r13
  25a54e:	jmp    25a645 <<glass::engine::Engine>::apply+0xfb5>
  25a553:	mov    0x8(%rsp),%r13
  25a558:	jmp    25a63b <<glass::engine::Engine>::apply+0xfab>
  25a55d:	mov    $0x1,%edx
  25a562:	jmp    25a445 <<glass::engine::Engine>::apply+0xdb5>
  25a567:	mov    0x39f293(%rip),%eax        # 5f9800 <glass::engine::run_whole::ON>
  25a56d:	test   %eax,%eax
  25a56f:	jne    25adc9 <<glass::engine::Engine>::apply+0x1739>
  25a575:	mov    0x8(%rsp),%rax
  25a57a:	add    0x28(%rsp),%rax
  25a57f:	mov    %rax,0x8(%rsp)
  25a584:	movzbl 0x39f279(%rip),%eax        # 5f9804 <glass::engine::run_whole::ON+0x4>
  25a58b:	xor    $0x1,%rax
  25a58f:	sub    %rax,%rbp
  25a592:	cmp    $0x1,%rbp
  25a596:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a598:	cmpb   $0x1,0x26e(%rsp)
  25a5a0:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a5a2:	cmpq   $0x0,0x1e8(%rsp)
  25a5ab:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a5ad:	mov    0x228(%rsp),%r13
  25a5b5:	testb  $0x4,0x6c5(%r13)
  25a5bd:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a5bf:	cmpq   $0x0,0x50(%r13)
  25a5c4:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a5c6:	movzwl 0x64(%r13),%eax
  25a5cb:	test   $0x460,%eax
  25a5d0:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a5d2:	cmpb   $0x0,0x68(%r13)
  25a5d7:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a5d9:	cmpb   $0x0,0x69(%r13)
  25a5de:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a5e0:	cmpb   $0x0,0x6a(%r13)
  25a5e5:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25a5e7:	cmpb   $0x0,0x6b(%r13)
  25a5ec:	je     25add3 <<glass::engine::Engine>::apply+0x1743>
  25a5f2:	lea    0x1b0(%rsp),%rdi
  25a5fa:	mov    0x8(%rsp),%rsi
  25a5ff:	mov    %rbp,%rdx
  25a602:	call   266220 <<glass::engine::Watch>::print_run>
  25a607:	mov    %rax,%r15
  25a60a:	mov    0x39f1f0(%rip),%eax        # 5f9800 <glass::engine::run_whole::ON>
  25a610:	test   %eax,%eax
  25a612:	jne    25b5db <<glass::engine::Engine>::apply+0x1f4b>
  25a618:	cmpb   $0x0,0x39f1e5(%rip)        # 5f9804 <glass::engine::run_whole::ON+0x4>
  25a61f:	je     25a630 <<glass::engine::Engine>::apply+0xfa0>
  25a621:	mov    0x260(%rsp),%eax
  25a628:	mov    %eax,0x718(%r12)
  25a630:	mov    0x110(%rsp),%r13
  25a638:	add    %r15,%r13
  25a63b:	mov    0x28(%rsp),%rdx
  25a640:	mov    0x10(%rsp),%r8
  25a645:	cmp    %r13,%r8
  25a648:	jb     25bc2d <<glass::engine::Engine>::apply+0x259d>
  25a64e:	mov    %r8,%r15
  25a651:	mov    %r8,0x8(%rsp)
  25a656:	sub    %r13,%r15
  25a659:	je     25a701 <<glass::engine::Engine>::apply+0x1071>
  25a65f:	add    %rdx,%r13
  25a662:	xor    %ebp,%ebp
  25a664:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a670:	cmpl   $0xffffffff,0x710(%r12)
  25a679:	jne    25a6d6 <<glass::engine::Engine>::apply+0x1046>
  25a67b:	mov    0x78(%rsp),%rax
  25a680:	mov    %rax,0xa0(%rsp)
  25a688:	lea    0x1b0(%rsp),%rax
  25a690:	mov    %rax,0xa8(%rsp)
  25a698:	movb   $0x0,0xb0(%rsp)
  25a6a0:	mov    %r15,%rcx
  25a6a3:	sub    %rbp,%rcx
  25a6a6:	jb     25bb8a <<glass::engine::Engine>::apply+0x24fa>
  25a6ac:	mov    %r13,%rdx
  25a6af:	add    %rbp,%rdx
  25a6b2:	mov    0x118(%rsp),%rdi
  25a6ba:	lea    0xa0(%rsp),%rsi
  25a6c2:	call   1a15a0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25a6c7:	add    %rax,%rbp
  25a6ca:	cmp    %r15,%rbp
  25a6cd:	mov    0x10(%rsp),%r8
  25a6d2:	jne    25a670 <<glass::engine::Engine>::apply+0xfe0>
  25a6d4:	jmp    25a6fc <<glass::engine::Engine>::apply+0x106c>
  25a6d6:	mov    %r15,%rcx
  25a6d9:	sub    %rbp,%rcx
  25a6dc:	jb     25bc96 <<glass::engine::Engine>::apply+0x2606>
  25a6e2:	mov    %r13,%rdx
  25a6e5:	add    %rbp,%rdx
  25a6e8:	mov    0x78(%rsp),%rdi
  25a6ed:	lea    0x1b0(%rsp),%rsi
  25a6f5:	call   195300 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25a6fa:	jmp    25a6c7 <<glass::engine::Engine>::apply+0x1037>
  25a6fc:	mov    %r8,0x8(%rsp)
  25a701:	cmpl   $0xffffffff,0x710(%r12)
  25a70a:	je     25a71f <<glass::engine::Engine>::apply+0x108f>
  25a70c:	movl   $0x0,0x80(%rsp)
  25a717:	mov    %r8,%r13
  25a71a:	jmp    25a135 <<glass::engine::Engine>::apply+0xaa5>
  25a71f:	cmpb   $0x0,0x18c(%rsp)
  25a727:	je     25a769 <<glass::engine::Engine>::apply+0x10d9>
  25a729:	mov    0x260(%rsp),%ebx
  25a730:	cmp    $0xffffffff,%ebx
  25a733:	je     25ad23 <<glass::engine::Engine>::apply+0x1693>
  25a739:	mov    0x140(%rsp),%ebp
  25a740:	cmp    $0x1,%bp
  25a744:	adc    $0x0,%ebp
  25a747:	nopw   0x0(%rax,%rax,1)
  25a750:	lea    0x1b0(%rsp),%rdi
  25a758:	mov    %ebx,%esi
  25a75a:	call   3417f0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  25a75f:	dec    %bp
  25a762:	jne    25a750 <<glass::engine::Engine>::apply+0x10c0>
  25a764:	jmp    25ad70 <<glass::engine::Engine>::apply+0x16e0>
  25a769:	cmpb   $0x0,0x188(%rsp)
  25a771:	je     25a7a1 <<glass::engine::Engine>::apply+0x1111>
  25a773:	movzwl 0x140(%rsp),%eax
  25a77b:	lea    -0x1(%rax),%esi
  25a77e:	test   %eax,%eax
  25a780:	cmove  %eax,%esi
  25a783:	test   %r14,%r14
  25a786:	je     25ad50 <<glass::engine::Engine>::apply+0x16c0>
  25a78c:	movzwl 0x142(%rsp),%ecx
  25a794:	xor    %eax,%eax
  25a796:	test   %cx,%cx
  25a799:	setne  %al
  25a79c:	jmp    25ad52 <<glass::engine::Engine>::apply+0x16c2>
  25a7a1:	mov    0x228(%rsp),%r13
  25a7a9:	xor    %eax,%eax
  25a7ab:	jmp    25a7c7 <<glass::engine::Engine>::apply+0x1137>
  25a7ad:	nopl   (%rax)
  25a7b0:	mov    0x92(%rsp),%eax
  25a7b7:	mov    %eax,0x58(%r13)
  25a7bb:	mov    %rbx,%rax
  25a7be:	cmp    %r14,%rbx
  25a7c1:	ja     25ad70 <<glass::engine::Engine>::apply+0x16e0>
  25a7c7:	movzwl 0x140(%rsp,%rax,2),%ecx
  25a7cf:	lea    0x1(%rax),%rbx
  25a7d3:	cmp    $0x3b,%rcx
  25a7d7:	ja     25abfd <<glass::engine::Engine>::apply+0x156d>
  25a7dd:	lea    -0x1eb84c(%rip),%rsi        # 6ef98 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2e07>
  25a7e4:	movslq (%rsi,%rcx,4),%rdx
  25a7e8:	add    %rsi,%rdx
  25a7eb:	jmp    *%rdx
  25a7ed:	movzwl %cx,%eax
  25a7f0:	mov    %edx,%esi
  25a7f2:	shr    $0x10,%esi
  25a7f5:	shl    $0x10,%rdx
  25a7f9:	or     %rax,%rdx
  25a7fc:	mov    %si,0x94(%rsp)
  25a804:	mov    %edx,0x90(%rsp)
  25a80b:	mov    0x39c2de(%rip),%rax        # 5f6af0 <_DYNAMIC+0x4d0>
  25a812:	mov    (%rax),%rax
  25a815:	cmp    $0x5,%rax
  25a819:	jb     25a91f <<glass::engine::Engine>::apply+0x128f>
  25a81f:	lea    0x90(%rsp),%rax
  25a827:	mov    %rax,0x190(%rsp)
  25a82f:	lea    0xe42aa(%rip),%rax        # 33eae0 <<vte::ansi::Attr as core::fmt::Debug>::fmt>
  25a836:	mov    %rax,0x198(%rsp)
  25a83e:	movq   $0x5,0xd0(%rsp)
  25a84a:	lea    -0x1e6ae8(%rip),%rcx        # 73d69 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x7bd8>
  25a851:	mov    %rcx,0xd8(%rsp)
  25a859:	movq   $0x18,0xe0(%rsp)
  25a865:	lea    -0x20396c(%rip),%rax        # 56f00 <anon.b1f4d9ab9a70b62acaac4b25f359f3f9.23.llvm.7200124262536369696+0x4f1>
  25a86c:	mov    %rax,0xf0(%rsp)
  25a874:	lea    0x190(%rsp),%rax
  25a87c:	mov    %rax,0xf8(%rsp)
  25a884:	movq   $0x0,0xa0(%rsp)
  25a890:	mov    %rcx,0xa8(%rsp)
  25a898:	movq   $0x18,0xb0(%rsp)
  25a8a4:	movq   $0x0,0xb8(%rsp)
  25a8b0:	lea    -0x209013(%rip),%rax        # 518a4 <anon.48a94b4156a1895edfc227e0e61a21e6.7.llvm.774233506152284253+0x6a>
  25a8b7:	mov    %rax,0xc0(%rsp)
  25a8bf:	movq   $0x29,0xc8(%rsp)
  25a8cb:	movabs $0x7b300000001,%rax
  25a8d5:	mov    %rax,0xe8(%rsp)
  25a8dd:	mov    0x3a22cc(%rip),%rax        # 5fcbb0 <log::STATE>
  25a8e4:	cmp    $0x2,%rax
  25a8e8:	mov    0x39efa1(%rip),%rax        # 5f9890 <log::LOGGER>
  25a8ef:	lea    0x38c2b2(%rip),%rcx        # 5e6ba8 <anon.9d01c2521e6ce7ddd00230a5633940a7.11.llvm.13591961162351055884>
  25a8f6:	cmovne %rcx,%rax
  25a8fa:	mov    0x39ef87(%rip),%rdi        # 5f9888 <log::LOGGER>
  25a901:	lea    -0x18f2ba(%rip),%rcx        # cb64e <log::logger::NOP>
  25a908:	cmovne %rcx,%rdi
  25a90c:	lea    0xa0(%rsp),%rsi
  25a914:	call   *0x20(%rax)
  25a917:	movzwl 0x90(%rsp),%ecx
  25a91f:	cmp    $0x16,%cx
  25a923:	je     25a7b0 <<glass::engine::Engine>::apply+0x1120>
  25a929:	movzwl %cx,%eax
  25a92c:	cmp    $0x17,%eax
  25a92f:	jne    25a950 <<glass::engine::Engine>::apply+0x12c0>
  25a931:	mov    0x92(%rsp),%eax
  25a938:	mov    %eax,0x5c(%r13)
  25a93c:	jmp    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a941:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25a950:	mov    0x90(%rsp),%eax
  25a957:	mov    0x94(%rsp),%esi
  25a95e:	shl    $0x20,%rsi
  25a962:	or     %rax,%rsi
  25a965:	mov    %r13,%rdi
  25a968:	call   2929a0 <<alacritty_terminal::term::Term<glass::engine::Listener>>::terminal_attribute_cold>
  25a96d:	jmp    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a972:	cmp    %r14,%rax
  25a975:	jae    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a97b:	movzwl 0x142(%rsp,%rax,2),%ecx
  25a983:	lea    0x2(%rax),%rbx
  25a987:	cmp    $0x5,%ecx
  25a98a:	je     25ac61 <<glass::engine::Engine>::apply+0x15d1>
  25a990:	cmp    $0x2,%ecx
  25a993:	jne    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a999:	cmp    %r14,%rbx
  25a99c:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a9a2:	movzwl 0x144(%rsp,%rax,2),%ecx
  25a9aa:	lea    0x3(%rax),%rbx
  25a9ae:	cmp    $0xff,%ecx
  25a9b4:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a9ba:	cmp    %r14,%rbx
  25a9bd:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a9c3:	movzwl 0x146(%rsp,%rax,2),%edx
  25a9cb:	lea    0x4(%rax),%rbx
  25a9cf:	cmp    $0xff,%edx
  25a9d5:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a9db:	cmp    %r14,%rbx
  25a9de:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25a9e4:	movzwl 0x148(%rsp,%rax,2),%esi
  25a9ec:	add    $0x5,%rax
  25a9f0:	cmp    $0xff,%esi
  25a9f6:	ja     25ace4 <<glass::engine::Engine>::apply+0x1654>
  25a9fc:	shl    $0x10,%esi
  25a9ff:	movzwl %dx,%edx
  25aa02:	shl    $0x8,%edx
  25aa05:	or     %edx,%ecx
  25aa07:	movzwl %cx,%edx
  25aa0a:	or     %esi,%edx
  25aa0c:	mov    $0x1,%ecx
  25aa11:	jmp    25ac83 <<glass::engine::Engine>::apply+0x15f3>
  25aa16:	mov    $0x17,%cx
  25aa1a:	mov    $0x1010000,%edx
  25aa1f:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25aa24:	mov    $0x11,%cx
  25aa28:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25aa2d:	mov    $0xc,%cx
  25aa31:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25aa36:	mov    $0xa,%cx
  25aa3a:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25aa3f:	mov    $0x18,%cx
  25aa43:	mov    $0xff,%edx
  25aa48:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25aa4d:	mov    $0xe,%cx
  25aa51:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25aa56:	cmp    %r14,%rax
  25aa59:	jae    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25aa5f:	movzwl 0x142(%rsp,%rax,2),%ecx
  25aa67:	lea    0x2(%rax),%rbx
  25aa6b:	cmp    $0x5,%ecx
  25aa6e:	je     25ac94 <<glass::engine::Engine>::apply+0x1604>
  25aa74:	cmp    $0x2,%ecx
  25aa77:	jne    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25aa7d:	cmp    %r14,%rbx
  25aa80:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25aa86:	movzwl 0x144(%rsp,%rax,2),%ecx
  25aa8e:	lea    0x3(%rax),%rbx
  25aa92:	cmp    $0xff,%ecx
  25aa98:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25aa9e:	cmp    %r14,%rbx
  25aaa1:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25aaa7:	movzwl 0x146(%rsp,%rax,2),%edx
  25aaaf:	lea    0x4(%rax),%rbx
  25aab3:	cmp    $0xff,%edx
  25aab9:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25aabf:	cmp    %r14,%rbx
  25aac2:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25aac8:	movzwl 0x148(%rsp,%rax,2),%esi
  25aad0:	add    $0x5,%rax
  25aad4:	cmp    $0xff,%esi
  25aada:	ja     25ace4 <<glass::engine::Engine>::apply+0x1654>
  25aae0:	shl    $0x10,%esi
  25aae3:	movzwl %dx,%edx
  25aae6:	shl    $0x8,%edx
  25aae9:	or     %edx,%ecx
  25aaeb:	movzwl %cx,%edx
  25aaee:	or     %esi,%edx
  25aaf0:	mov    $0x1,%ecx
  25aaf5:	jmp    25acb6 <<glass::engine::Engine>::apply+0x1626>
  25aafa:	mov    $0x10,%cx
  25aafe:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab03:	mov    $0x16,%cx
  25ab07:	mov    $0x1000000,%edx
  25ab0c:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab11:	mov    $0xf,%cx
  25ab15:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab1a:	mov    $0x9,%cx
  25ab1e:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab23:	mov    $0x12,%cx
  25ab27:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab2c:	mov    $0x13,%cx
  25ab30:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab35:	mov    $0xb,%cx
  25ab39:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab3e:	mov    $0xd,%cx
  25ab42:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab47:	mov    $0x15,%cx
  25ab4b:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab50:	mov    $0x14,%cx
  25ab54:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ab59:	cmp    %r14,%rax
  25ab5c:	jae    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25ab62:	movzwl 0x142(%rsp,%rax,2),%ecx
  25ab6a:	lea    0x2(%rax),%rbx
  25ab6e:	cmp    $0x5,%ecx
  25ab71:	je     25acc7 <<glass::engine::Engine>::apply+0x1637>
  25ab77:	cmp    $0x2,%ecx
  25ab7a:	jne    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25ab80:	cmp    %r14,%rbx
  25ab83:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25ab89:	movzwl 0x144(%rsp,%rax,2),%ecx
  25ab91:	lea    0x3(%rax),%rbx
  25ab95:	cmp    $0xff,%ecx
  25ab9b:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25aba1:	cmp    %r14,%rbx
  25aba4:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25abaa:	movzwl 0x146(%rsp,%rax,2),%edx
  25abb2:	lea    0x4(%rax),%rbx
  25abb6:	cmp    $0xff,%edx
  25abbc:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25abc2:	cmp    %r14,%rbx
  25abc5:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25abcb:	movzwl 0x148(%rsp,%rax,2),%esi
  25abd3:	add    $0x5,%rax
  25abd7:	cmp    $0xff,%esi
  25abdd:	ja     25ace4 <<glass::engine::Engine>::apply+0x1654>
  25abe3:	shl    $0x10,%esi
  25abe6:	movzwl %dx,%edx
  25abe9:	shl    $0x8,%edx
  25abec:	or     %edx,%ecx
  25abee:	movzwl %cx,%edx
  25abf1:	or     %esi,%edx
  25abf3:	mov    $0x1,%ecx
  25abf8:	jmp    25ad12 <<glass::engine::Engine>::apply+0x1682>
  25abfd:	lea    -0x1e(%rcx),%eax
  25ac00:	cmp    $0x8,%ax
  25ac04:	jae    25ac1e <<glass::engine::Engine>::apply+0x158e>
  25ac06:	lea    -0x1ff41d(%rip),%rax        # 5b7f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.11017409024884677682+0xa30>
  25ac0d:	movzwl -0x3c(%rax,%rcx,2),%edx
  25ac12:	shl    $0x10,%edx
  25ac15:	mov    $0x16,%cx
  25ac19:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ac1e:	mov    %ecx,%eax
  25ac20:	and    $0xfff8,%eax
  25ac25:	cmp    $0x28,%ax
  25ac29:	jne    25ac43 <<glass::engine::Engine>::apply+0x15b3>
  25ac2b:	lea    -0x1ff442(%rip),%rax        # 5b7f0 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.93.llvm.11017409024884677682+0xa30>
  25ac32:	movzwl -0x50(%rax,%rcx,2),%edx
  25ac37:	shl    $0x10,%edx
  25ac3a:	mov    $0x17,%cx
  25ac3e:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ac43:	lea    -0x5a(%rcx),%eax
  25ac46:	cmp    $0x8,%ax
  25ac4a:	jae    25acec <<glass::engine::Engine>::apply+0x165c>
  25ac50:	lea    -0x1fd627(%rip),%rax        # 5d630 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.11017409024884677682+0x110>
  25ac57:	movzwl -0xb4(%rax,%rcx,2),%edx
  25ac5f:	jmp    25ac12 <<glass::engine::Engine>::apply+0x1582>
  25ac61:	cmp    %r14,%rbx
  25ac64:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25ac6a:	movzwl 0x144(%rsp,%rax,2),%edx
  25ac72:	add    $0x3,%rax
  25ac76:	cmp    $0xff,%edx
  25ac7c:	ja     25ace4 <<glass::engine::Engine>::apply+0x1654>
  25ac7e:	mov    $0x2,%ecx
  25ac83:	shl    $0x8,%edx
  25ac86:	or     %ecx,%edx
  25ac88:	mov    $0x16,%cx
  25ac8c:	mov    %rax,%rbx
  25ac8f:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ac94:	cmp    %r14,%rbx
  25ac97:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25ac9d:	movzwl 0x144(%rsp,%rax,2),%edx
  25aca5:	add    $0x3,%rax
  25aca9:	cmp    $0xff,%edx
  25acaf:	ja     25ace4 <<glass::engine::Engine>::apply+0x1654>
  25acb1:	mov    $0x2,%ecx
  25acb6:	shl    $0x8,%edx
  25acb9:	or     %ecx,%edx
  25acbb:	mov    $0x18,%cx
  25acbf:	mov    %rax,%rbx
  25acc2:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25acc7:	cmp    %r14,%rbx
  25acca:	ja     25a7bb <<glass::engine::Engine>::apply+0x112b>
  25acd0:	movzwl 0x144(%rsp,%rax,2),%edx
  25acd8:	add    $0x3,%rax
  25acdc:	cmp    $0xff,%edx
  25ace2:	jbe    25ad0d <<glass::engine::Engine>::apply+0x167d>
  25ace4:	mov    %rax,%rbx
  25ace7:	jmp    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25acec:	lea    -0x64(%rcx),%eax
  25acef:	cmp    $0x8,%ax
  25acf3:	jae    25a7bb <<glass::engine::Engine>::apply+0x112b>
  25acf9:	lea    -0x1fd6d0(%rip),%rax        # 5d630 <anon.1c77ca5f0aa636dd3bea18f7e6bf23e7.66.llvm.11017409024884677682+0x110>
  25ad00:	movzwl -0xc8(%rax,%rcx,2),%edx
  25ad08:	jmp    25ac37 <<glass::engine::Engine>::apply+0x15a7>
  25ad0d:	mov    $0x2,%ecx
  25ad12:	shl    $0x8,%edx
  25ad15:	or     %ecx,%edx
  25ad17:	mov    $0x17,%cx
  25ad1b:	mov    %rax,%rbx
  25ad1e:	jmp    25a7ed <<glass::engine::Engine>::apply+0x115d>
  25ad23:	mov    $0x1,%al
  25ad25:	mov    %eax,0x80(%rsp)
  25ad2c:	mov    %r8,%r13
  25ad2f:	mov    0x8(%rsp),%rax
  25ad34:	mov    %rax,0x110(%rsp)
  25ad3c:	mov    $0x1,%al
  25ad3e:	mov    %rax,0x58(%rsp)
  25ad43:	mov    0x180(%rsp),%rbx
  25ad4b:	jmp    25a135 <<glass::engine::Engine>::apply+0xaa5>
  25ad50:	xor    %eax,%eax
  25ad52:	movzwl %cx,%edx
  25ad55:	dec    %rdx
  25ad58:	test   $0x1,%al
  25ad5a:	mov    $0x0,%eax
  25ad5f:	cmove  %rax,%rdx
  25ad63:	mov    0x228(%rsp),%rdi
  25ad6b:	call   3505e0 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  25ad70:	mov    0x10(%rsp),%r8
  25ad75:	mov    0x180(%rsp),%rbx
  25ad7d:	lea    (%rbx,%r8,1),%r13
  25ad81:	movb   $0x0,0xa80(%r12)
  25ad8a:	movb   $0x0,0xa7e(%r12)
  25ad93:	mov    $0x1,%al
  25ad95:	mov    %eax,0x80(%rsp)
  25ad9c:	mov    %r13,0x8(%rsp)
  25ada1:	mov    %r13,0x110(%rsp)
  25ada9:	mov    $0x1,%al
  25adab:	mov    %rax,0x58(%rsp)
  25adb0:	jmp    25a135 <<glass::engine::Engine>::apply+0xaa5>
  25adb5:	mov    $0x2,%edx
  25adba:	jmp    25a445 <<glass::engine::Engine>::apply+0xdb5>
  25adbf:	call   18c936 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25adc4:	jmp    25a4e1 <<glass::engine::Engine>::apply+0xe51>
  25adc9:	call   18c936 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25adce:	jmp    25a575 <<glass::engine::Engine>::apply+0xee5>
  25add3:	mov    0x8(%rsp),%rax
  25add8:	movzbl (%rax),%eax
  25addb:	mov    %rax,0x80(%rsp)
  25ade3:	add    $0xffffffe0,%eax
  25ade6:	mov    $0x1,%r15d
  25adec:	cmp    $0x5f,%al
  25adee:	jb     25ae1b <<glass::engine::Engine>::apply+0x178b>
  25adf0:	mov    0x80(%rsp),%rdi
  25adf8:	call   2a37b0 <glass::engine::width_of>
  25adfd:	mov    0x38(%rsp),%r12
  25ae02:	mov    %rdx,%r15
  25ae05:	lea    -0x1(%rdx),%rcx
  25ae09:	cmp    $0x2,%rcx
  25ae0d:	setb   %cl
  25ae10:	and    %al,%cl
  25ae12:	cmp    $0x1,%cl
  25ae15:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25ae1b:	cmpb   $0x0,0x6c(%r13)
  25ae20:	mov    0x38(%rsp),%r12
  25ae25:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25ae2b:	mov    0x40(%r13),%rdx
  25ae2f:	mov    0xa0(%r13),%rcx
  25ae36:	mov    %rdx,0x30(%rsp)
  25ae3b:	lea    (%rdx,%r15,1),%rax
  25ae3f:	mov    %rax,0x178(%rsp)
  25ae47:	mov    %rcx,0x280(%rsp)
  25ae4f:	cmp    %rcx,%rax
  25ae52:	ja     25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25ae58:	lea    0x10(%r13),%rdi
  25ae5c:	mov    0x48(%r13),%esi
  25ae60:	mov    0x58(%r13),%eax
  25ae64:	mov    %eax,0x124(%rsp)
  25ae6b:	mov    0x5c(%r13),%eax
  25ae6f:	mov    %eax,0x120(%rsp)
  25ae76:	movzwl 0x64(%r13),%eax
  25ae7b:	mov    %eax,0x128(%rsp)
  25ae82:	lea    0x372b97(%rip),%rdx        # 5cda20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x156e0>
  25ae89:	call   30f310 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  25ae8e:	mov    %rax,%rcx
  25ae91:	add    $0x18,%rcx
  25ae95:	mov    %rcx,0x130(%rsp)
  25ae9d:	mov    %rax,0x20(%rsp)
  25aea2:	mov    0x28(%rax),%eax
  25aea5:	cmp    $0xffffffff,%eax
  25aea8:	je     25aec2 <<glass::engine::Engine>::apply+0x1832>
  25aeaa:	mov    0x130(%rsp),%rcx
  25aeb2:	mov    0x30(%rsp),%rdx
  25aeb7:	mov    0x20(%rsp),%rsi
  25aebc:	cmp    0x30(%rsi),%rdx
  25aec0:	jae    25aeec <<glass::engine::Engine>::apply+0x185c>
  25aec2:	mov    0x20(%rsp),%rcx
  25aec7:	mov    0x10(%rcx),%rcx
  25aecb:	cmp    %rcx,0x30(%rsp)
  25aed0:	jae    25bcd1 <<glass::engine::Engine>::apply+0x2641>
  25aed6:	mov    0x30(%rsp),%rcx
  25aedb:	lea    (%rcx,%rcx,2),%rcx
  25aedf:	shl    $0x3,%rcx
  25aee3:	mov    0x20(%rsp),%rdx
  25aee8:	add    0x8(%rdx),%rcx
  25aeec:	testb  $0x60,0x14(%rcx)
  25aef0:	mov    0x38(%rsp),%r12
  25aef5:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25aefb:	cmp    $0x2,%r15
  25aeff:	jne    25af53 <<glass::engine::Engine>::apply+0x18c3>
  25af01:	mov    0x30(%rsp),%rcx
  25af06:	inc    %rcx
  25af09:	cmp    $0xffffffff,%eax
  25af0c:	je     25af21 <<glass::engine::Engine>::apply+0x1891>
  25af0e:	mov    0x130(%rsp),%rdx
  25af16:	mov    0x20(%rsp),%rsi
  25af1b:	cmp    0x30(%rsi),%rcx
  25af1f:	jae    25af44 <<glass::engine::Engine>::apply+0x18b4>
  25af21:	mov    0x20(%rsp),%rdx
  25af26:	mov    0x10(%rdx),%rdx
  25af2a:	cmp    %rdx,%rcx
  25af2d:	jae    25bce7 <<glass::engine::Engine>::apply+0x2657>
  25af33:	lea    (%rcx,%rcx,2),%rdx
  25af37:	shl    $0x3,%rdx
  25af3b:	mov    0x20(%rsp),%rcx
  25af40:	add    0x8(%rcx),%rdx
  25af44:	testb  $0x60,0x14(%rdx)
  25af48:	mov    0x38(%rsp),%r12
  25af4d:	jne    25a5f2 <<glass::engine::Engine>::apply+0xf62>
  25af53:	mov    0x30(%rsp),%rcx
  25af58:	mov    0x20(%rsp),%rdx
  25af5d:	cmp    %ecx,0x38(%rdx)
  25af60:	jbe    25af6f <<glass::engine::Engine>::apply+0x18df>
  25af62:	mov    0x30(%rsp),%rcx
  25af67:	mov    0x20(%rsp),%rdx
  25af6c:	mov    %ecx,0x38(%rdx)
  25af6f:	cmp    $0xffffffff,%eax
  25af72:	setne  %cl
  25af75:	mov    0x20(%rsp),%rdx
  25af7a:	mov    0x30(%rdx),%r12
  25af7e:	cmp    %r12,0x30(%rsp)
  25af83:	sete   %dl
  25af86:	test   %dl,%cl
  25af88:	jne    25b096 <<glass::engine::Engine>::apply+0x1a06>
  25af8e:	cmp    $0xffffffff,%eax
  25af91:	je     25b1f0 <<glass::engine::Engine>::apply+0x1b60>
  25af97:	mov    0x20(%rsp),%rax
  25af9c:	mov    0x10(%rax),%rbp
  25afa0:	cmp    %r12,%rbp
  25afa3:	mov    %r12,%rax
  25afa6:	cmovb  %rbp,%rax
  25afaa:	mov    %rax,0x68(%rsp)
  25afaf:	mov    0x30(%rsp),%rax
  25afb4:	cmp    %rax,%rbp
  25afb7:	cmovb  %rbp,%rax
  25afbb:	mov    %rax,0x40(%rsp)
  25afc0:	mov    0x39b979(%rip),%rax        # 5f6940 <_DYNAMIC+0x320>
  25afc7:	movzbl (%rax),%eax
  25afca:	test   %al,%al
  25afcc:	je     25aff7 <<glass::engine::Engine>::apply+0x1967>
  25afce:	mov    0x39b9a3(%rip),%rax        # 5f6978 <_DYNAMIC+0x358>
  25afd5:	cmp    0x40(%rsp),%r12
  25afda:	jae    25afe3 <<glass::engine::Engine>::apply+0x1953>
  25afdc:	mov    0x39b99d(%rip),%rax        # 5f6980 <_DYNAMIC+0x360>
  25afe3:	lock incq 0x28(%rax)
  25afe8:	mov    0x40(%rsp),%rdi
  25afed:	sub    0x68(%rsp),%rdi
  25aff2:	call   2fa8b0 <alacritty_terminal::grid::row::fill_census::note>
  25aff7:	cmp    0x40(%rsp),%r12
  25affc:	jae    25b1d0 <<glass::engine::Engine>::apply+0x1b40>
  25b002:	mov    0x20(%rsp),%rax
  25b007:	mov    0x28(%rax),%ecx
  25b00a:	mov    %ecx,0x54(%rsp)
  25b00e:	mov    0x20(%rax),%ecx
  25b011:	mov    %ecx,0x50(%rsp)
  25b015:	mov    0x24(%rax),%ecx
  25b018:	mov    %ecx,0x4c(%rsp)
  25b01c:	movzwl 0x2c(%rax),%ecx
  25b020:	mov    %cx,0x70(%rsp)
  25b025:	mov    0x18(%rax),%rax
  25b029:	mov    %rax,0x8(%rsp)
  25b02e:	test   %rax,%rax
  25b031:	je     25b0ba <<glass::engine::Engine>::apply+0x1a2a>
  25b037:	mov    0x8(%rsp),%rax
  25b03c:	lock incq (%rax)
  25b040:	jle    25bd4f <<glass::engine::Engine>::apply+0x26bf>
  25b046:	mov    0x20(%rsp),%rax
  25b04b:	mov    0x10(%rax),%rdx
  25b04f:	mov    0x54(%rsp),%eax
  25b053:	mov    %eax,0xb0(%rsp)
  25b05a:	mov    0x50(%rsp),%eax
  25b05e:	mov    %eax,0xa8(%rsp)
  25b065:	mov    0x4c(%rsp),%eax
  25b069:	mov    %eax,0xac(%rsp)
  25b070:	movzwl 0x70(%rsp),%eax
  25b075:	mov    %ax,0xb4(%rsp)
  25b07d:	mov    0x8(%rsp),%rax
  25b082:	mov    %rax,0xa0(%rsp)
  25b08a:	cmp    %rdx,0x40(%rsp)
  25b08f:	jbe    25b0f5 <<glass::engine::Engine>::apply+0x1a65>
  25b091:	jmp    25bcfb <<glass::engine::Engine>::apply+0x266b>
  25b096:	mov    0x30(%rsp),%rcx
  25b09b:	lea    0x1(%rcx),%rax
  25b09f:	mov    0x20(%rsp),%rdx
  25b0a4:	mov    %rax,0x30(%rdx)
  25b0a8:	mov    0x10(%rdx),%rax
  25b0ac:	cmp    %rax,%rcx
  25b0af:	jb     25b21a <<glass::engine::Engine>::apply+0x1b8a>
  25b0b5:	jmp    25bd14 <<glass::engine::Engine>::apply+0x2684>
  25b0ba:	mov    0x54(%rsp),%eax
  25b0be:	mov    %eax,0xb0(%rsp)
  25b0c5:	mov    0x50(%rsp),%eax
  25b0c9:	mov    %eax,0xa8(%rsp)
  25b0d0:	mov    0x4c(%rsp),%eax
  25b0d4:	mov    %eax,0xac(%rsp)
  25b0db:	movzwl 0x70(%rsp),%eax
  25b0e0:	mov    %ax,0xb4(%rsp)
  25b0e8:	mov    0x8(%rsp),%rax
  25b0ed:	mov    %rax,0xa0(%rsp)
  25b0f5:	mov    0x68(%rsp),%rax
  25b0fa:	lea    0x0(,%rax,8),%rax
  25b102:	lea    (%rax,%rax,2),%rax
  25b106:	mov    0x20(%rsp),%rcx
  25b10b:	mov    0x8(%rcx),%rbp
  25b10f:	add    %rax,%rbp
  25b112:	mov    0x40(%rsp),%rcx
  25b117:	lea    0x0(,%rcx,8),%rcx
  25b11f:	lea    (%rcx,%rcx,2),%r12
  25b123:	sub    %rax,%r12
  25b126:	jmp    25b159 <<glass::engine::Engine>::apply+0x1ac9>
  25b128:	mov    0x8(%rsp),%rax
  25b12d:	mov    %rax,0x0(%rbp)
  25b131:	mov    0x50(%rsp),%eax
  25b135:	mov    %eax,0x8(%rbp)
  25b138:	mov    0x4c(%rsp),%eax
  25b13c:	mov    %eax,0xc(%rbp)
  25b13f:	mov    0x54(%rsp),%eax
  25b143:	mov    %eax,0x10(%rbp)
  25b146:	movzwl 0x70(%rsp),%eax
  25b14b:	mov    %ax,0x14(%rbp)
  25b14f:	add    $0x18,%rbp
  25b153:	add    $0xffffffffffffffe8,%r12
  25b157:	je     25b18a <<glass::engine::Engine>::apply+0x1afa>
  25b159:	cmpq   $0x0,0x8(%rsp)
  25b15f:	je     25b170 <<glass::engine::Engine>::apply+0x1ae0>
  25b161:	mov    0x8(%rsp),%rax
  25b166:	lock incq (%rax)
  25b16a:	jle    25bd4f <<glass::engine::Engine>::apply+0x26bf>
  25b170:	mov    0x0(%rbp),%rax
  25b174:	test   %rax,%rax
  25b177:	je     25b128 <<glass::engine::Engine>::apply+0x1a98>
  25b179:	lock decq (%rax)
  25b17d:	jne    25b128 <<glass::engine::Engine>::apply+0x1a98>
  25b17f:	mov    %rbp,%rdi
  25b182:	call   *0x39b700(%rip)        # 5f6888 <_DYNAMIC+0x268>
  25b188:	jmp    25b128 <<glass::engine::Engine>::apply+0x1a98>
  25b18a:	mov    0x20(%rsp),%rax
  25b18f:	mov    0x68(%rsp),%rcx
  25b194:	cmp    %ecx,0x38(%rax)
  25b197:	jbe    25b1a6 <<glass::engine::Engine>::apply+0x1b16>
  25b199:	mov    0x20(%rsp),%rax
  25b19e:	mov    0x68(%rsp),%rcx
  25b1a3:	mov    %ecx,0x38(%rax)
  25b1a6:	cmpq   $0x0,0x8(%rsp)
  25b1ac:	je     25b1c7 <<glass::engine::Engine>::apply+0x1b37>
  25b1ae:	mov    0x8(%rsp),%rax
  25b1b3:	lock decq (%rax)
  25b1b7:	jne    25b1c7 <<glass::engine::Engine>::apply+0x1b37>
  25b1b9:	lea    0xa0(%rsp),%rdi
  25b1c1:	call   *0x39b6c1(%rip)        # 5f6888 <_DYNAMIC+0x268>
  25b1c7:	mov    0x20(%rsp),%rax
  25b1cc:	mov    0x10(%rax),%rbp
  25b1d0:	cmp    %rbp,0x40(%rsp)
  25b1d5:	jb     25b1f0 <<glass::engine::Engine>::apply+0x1b60>
  25b1d7:	mov    0x130(%rsp),%rdi
  25b1df:	call   1ae630 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  25b1e4:	mov    0x20(%rsp),%rax
  25b1e9:	movl   $0xffffffff,0x28(%rax)
  25b1f0:	mov    0x20(%rsp),%rsi
  25b1f5:	mov    0x30(%rsi),%rcx
  25b1f9:	mov    0x30(%rsp),%rdx
  25b1fe:	lea    0x1(%rdx),%rax
  25b202:	cmp    %rcx,%rax
  25b205:	cmova  %rax,%rcx
  25b209:	mov    0x10(%rsi),%rax
  25b20d:	mov    %rcx,0x30(%rsi)
  25b211:	cmp    %rax,%rdx
  25b214:	jae    25bd1b <<glass::engine::Engine>::apply+0x268b>
  25b21a:	mov    0x128(%rsp),%edi
  25b221:	mov    %edi,%eax
  25b223:	or     $0x20,%eax
  25b226:	cmp    $0x2,%r15
  25b22a:	mov    0x20(%rsp),%rcx
  25b22f:	mov    0x8(%rcx),%rcx
  25b233:	mov    0x30(%rsp),%rdx
  25b238:	lea    (%rdx,%rdx,2),%rdx
  25b23c:	lea    (%rcx,%rdx,8),%rbp
  25b240:	mov    0x80(%rsp),%rsi
  25b248:	mov    %esi,0x10(%rcx,%rdx,8)
  25b24c:	mov    0x124(%rsp),%esi
  25b253:	mov    %esi,0x8(%rcx,%rdx,8)
  25b257:	cmovne %edi,%eax
  25b25a:	mov    0x120(%rsp),%esi
  25b261:	mov    %esi,0xc(%rcx,%rdx,8)
  25b265:	mov    %ax,0x14(%rcx,%rdx,8)
  25b26a:	mov    (%rcx,%rdx,8),%rax
  25b26e:	test   %rax,%rax
  25b271:	je     25b282 <<glass::engine::Engine>::apply+0x1bf2>
  25b273:	lock decq (%rax)
  25b277:	jne    25b282 <<glass::engine::Engine>::apply+0x1bf2>
  25b279:	mov    %rbp,%rdi
  25b27c:	call   *0x39b606(%rip)        # 5f6888 <_DYNAMIC+0x268>
  25b282:	movq   $0x0,0x0(%rbp)
  25b28a:	cmp    $0x2,%r15
  25b28e:	jne    25b580 <<glass::engine::Engine>::apply+0x1ef0>
  25b294:	mov    0x30(%rsp),%rax
  25b299:	lea    0x1(%rax),%rdx
  25b29d:	mov    0x20(%rsp),%rax
  25b2a2:	mov    0x30(%rax),%r15
  25b2a6:	mov    0x28(%rax),%eax
  25b2a9:	mov    %rdx,0x70(%rsp)
  25b2ae:	cmp    %r15,%rdx
  25b2b1:	jne    25b2de <<glass::engine::Engine>::apply+0x1c4e>
  25b2b3:	cmp    $0xffffffff,%eax
  25b2b6:	je     25b2de <<glass::engine::Engine>::apply+0x1c4e>
  25b2b8:	mov    0x30(%rsp),%rax
  25b2bd:	add    $0x2,%rax
  25b2c1:	mov    0x20(%rsp),%rcx
  25b2c6:	mov    %rax,0x30(%rcx)
  25b2ca:	mov    0x10(%rcx),%rax
  25b2ce:	cmp    %rax,0x70(%rsp)
  25b2d3:	jb     25b51e <<glass::engine::Engine>::apply+0x1e8e>
  25b2d9:	jmp    25bd22 <<glass::engine::Engine>::apply+0x2692>
  25b2de:	cmp    $0xffffffff,%eax
  25b2e1:	je     25b4f2 <<glass::engine::Engine>::apply+0x1e62>
  25b2e7:	mov    0x20(%rsp),%rax
  25b2ec:	mov    0x10(%rax),%r12
  25b2f0:	cmp    %r15,%r12
  25b2f3:	mov    %r15,%rax
  25b2f6:	cmovb  %r12,%rax
  25b2fa:	mov    %rax,0x68(%rsp)
  25b2ff:	mov    0x70(%rsp),%rax
  25b304:	cmp    %rax,%r12
  25b307:	cmovb  %r12,%rax
  25b30b:	mov    %rax,0x40(%rsp)
  25b310:	mov    0x39b629(%rip),%rax        # 5f6940 <_DYNAMIC+0x320>
  25b317:	movzbl (%rax),%eax
  25b31a:	test   %al,%al
  25b31c:	je     25b347 <<glass::engine::Engine>::apply+0x1cb7>
  25b31e:	mov    0x39b653(%rip),%rax        # 5f6978 <_DYNAMIC+0x358>
  25b325:	cmp    0x40(%rsp),%r15
  25b32a:	jae    25b333 <<glass::engine::Engine>::apply+0x1ca3>
  25b32c:	mov    0x39b64d(%rip),%rax        # 5f6980 <_DYNAMIC+0x360>
  25b333:	lock incq 0x28(%rax)
  25b338:	mov    0x40(%rsp),%rdi
  25b33d:	sub    0x68(%rsp),%rdi
  25b342:	call   2fa8b0 <alacritty_terminal::grid::row::fill_census::note>
  25b347:	cmp    0x40(%rsp),%r15
  25b34c:	jae    25b4d2 <<glass::engine::Engine>::apply+0x1e42>
  25b352:	mov    0x20(%rsp),%rax
  25b357:	mov    0x28(%rax),%ecx
  25b35a:	mov    %ecx,0x8(%rsp)
  25b35e:	mov    0x20(%rax),%ecx
  25b361:	mov    %ecx,0x54(%rsp)
  25b365:	mov    0x24(%rax),%ecx
  25b368:	mov    %ecx,0x50(%rsp)
  25b36c:	movzwl 0x2c(%rax),%ecx
  25b370:	mov    %cx,0x4c(%rsp)
  25b375:	mov    0x18(%rax),%r12
  25b379:	test   %r12,%r12
  25b37c:	je     25b3d4 <<glass::engine::Engine>::apply+0x1d44>
  25b37e:	lock incq (%r12)
  25b383:	jle    25bd4f <<glass::engine::Engine>::apply+0x26bf>
  25b389:	mov    0x20(%rsp),%rax
  25b38e:	mov    0x10(%rax),%rdx
  25b392:	mov    0x8(%rsp),%eax
  25b396:	mov    %eax,0xb0(%rsp)
  25b39d:	mov    0x54(%rsp),%eax
  25b3a1:	mov    %eax,0xa8(%rsp)
  25b3a8:	mov    0x50(%rsp),%eax
  25b3ac:	mov    %eax,0xac(%rsp)
  25b3b3:	movzwl 0x4c(%rsp),%eax
  25b3b8:	mov    %ax,0xb4(%rsp)
  25b3c0:	mov    %r12,0xa0(%rsp)
  25b3c8:	cmp    %rdx,0x40(%rsp)
  25b3cd:	jbe    25b40a <<glass::engine::Engine>::apply+0x1d7a>
  25b3cf:	jmp    25bd38 <<glass::engine::Engine>::apply+0x26a8>
  25b3d4:	mov    0x8(%rsp),%eax
  25b3d8:	mov    %eax,0xb0(%rsp)
  25b3df:	mov    0x54(%rsp),%eax
  25b3e3:	mov    %eax,0xa8(%rsp)
  25b3ea:	mov    0x50(%rsp),%eax
  25b3ee:	mov    %eax,0xac(%rsp)
  25b3f5:	movzwl 0x4c(%rsp),%eax
  25b3fa:	mov    %ax,0xb4(%rsp)
  25b402:	mov    %r12,0xa0(%rsp)
  25b40a:	mov    0x68(%rsp),%rax
  25b40f:	lea    0x0(,%rax,8),%rax
  25b417:	lea    (%rax,%rax,2),%rax
  25b41b:	mov    0x20(%rsp),%rcx
  25b420:	mov    0x8(%rcx),%rbp
  25b424:	add    %rax,%rbp
  25b427:	mov    0x40(%rsp),%rcx
  25b42c:	lea    0x0(,%rcx,8),%rcx
  25b434:	lea    (%rcx,%rcx,2),%r15
  25b438:	sub    %rax,%r15
  25b43b:	jmp    25b469 <<glass::engine::Engine>::apply+0x1dd9>
  25b43d:	mov    %r12,0x0(%rbp)
  25b441:	mov    0x54(%rsp),%eax
  25b445:	mov    %eax,0x8(%rbp)
  25b448:	mov    0x50(%rsp),%eax
  25b44c:	mov    %eax,0xc(%rbp)
  25b44f:	mov    0x8(%rsp),%eax
  25b453:	mov    %eax,0x10(%rbp)
  25b456:	movzwl 0x4c(%rsp),%eax
  25b45b:	mov    %ax,0x14(%rbp)
  25b45f:	add    $0x18,%rbp
  25b463:	add    $0xffffffffffffffe8,%r15
  25b467:	je     25b493 <<glass::engine::Engine>::apply+0x1e03>
  25b469:	test   %r12,%r12
  25b46c:	je     25b479 <<glass::engine::Engine>::apply+0x1de9>
  25b46e:	lock incq (%r12)
  25b473:	jle    25bd4f <<glass::engine::Engine>::apply+0x26bf>
  25b479:	mov    0x0(%rbp),%rax
  25b47d:	test   %rax,%rax
  25b480:	je     25b43d <<glass::engine::Engine>::apply+0x1dad>
  25b482:	lock decq (%rax)
  25b486:	jne    25b43d <<glass::engine::Engine>::apply+0x1dad>
  25b488:	mov    %rbp,%rdi
  25b48b:	call   *0x39b3f7(%rip)        # 5f6888 <_DYNAMIC+0x268>
  25b491:	jmp    25b43d <<glass::engine::Engine>::apply+0x1dad>
  25b493:	mov    0x20(%rsp),%rax
  25b498:	mov    0x68(%rsp),%rcx
  25b49d:	cmp    %ecx,0x38(%rax)
  25b4a0:	jbe    25b4af <<glass::engine::Engine>::apply+0x1e1f>
  25b4a2:	mov    0x20(%rsp),%rax
  25b4a7:	mov    0x68(%rsp),%rcx
  25b4ac:	mov    %ecx,0x38(%rax)
  25b4af:	test   %r12,%r12
  25b4b2:	je     25b4c9 <<glass::engine::Engine>::apply+0x1e39>
  25b4b4:	lock decq (%r12)
  25b4b9:	jne    25b4c9 <<glass::engine::Engine>::apply+0x1e39>
  25b4bb:	lea    0xa0(%rsp),%rdi
  25b4c3:	call   *0x39b3bf(%rip)        # 5f6888 <_DYNAMIC+0x268>
  25b4c9:	mov    0x20(%rsp),%rax
  25b4ce:	mov    0x10(%rax),%r12
  25b4d2:	cmp    %r12,0x40(%rsp)
  25b4d7:	jb     25b4f2 <<glass::engine::Engine>::apply+0x1e62>
  25b4d9:	mov    0x130(%rsp),%rdi
  25b4e1:	call   1ae630 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  25b4e6:	mov    0x20(%rsp),%rax
  25b4eb:	movl   $0xffffffff,0x28(%rax)
  25b4f2:	mov    0x20(%rsp),%rdx
  25b4f7:	mov    0x30(%rdx),%rax
  25b4fb:	mov    0x30(%rsp),%rcx
  25b500:	add    $0x2,%rcx
  25b504:	cmp    %rax,%rcx
  25b507:	cmovbe %rax,%rcx
  25b50b:	mov    0x10(%rdx),%rax
  25b50f:	mov    %rcx,0x30(%rdx)
  25b513:	cmp    %rax,0x70(%rsp)
  25b518:	jae    25bd51 <<glass::engine::Engine>::apply+0x26c1>
  25b51e:	mov    0x20(%rsp),%rax
  25b523:	mov    0x8(%rax),%rax
  25b527:	mov    0x70(%rsp),%rcx
  25b52c:	lea    (%rcx,%rcx,2),%rcx
  25b530:	lea    (%rax,%rcx,8),%r15
  25b534:	movl   $0x20,0x10(%rax,%rcx,8)
  25b53c:	mov    0x124(%rsp),%edx
  25b543:	mov    %edx,0x8(%rax,%rcx,8)
  25b547:	mov    0x120(%rsp),%edx
  25b54e:	mov    %edx,0xc(%rax,%rcx,8)
  25b552:	mov    0x128(%rsp),%edx
  25b559:	or     $0x40,%edx
  25b55c:	mov    %dx,0x14(%rax,%rcx,8)
  25b561:	mov    (%rax,%rcx,8),%rax
  25b565:	test   %rax,%rax
  25b568:	je     25b579 <<glass::engine::Engine>::apply+0x1ee9>
  25b56a:	lock decq (%rax)
  25b56e:	jne    25b579 <<glass::engine::Engine>::apply+0x1ee9>
  25b570:	mov    %r15,%rdi
  25b573:	call   *0x39b30f(%rip)        # 5f6888 <_DYNAMIC+0x268>
  25b579:	movq   $0x0,(%r15)
  25b580:	mov    0x280(%rsp),%rax
  25b588:	cmp    %rax,0x178(%rsp)
  25b590:	jb     25b59f <<glass::engine::Engine>::apply+0x1f0f>
  25b592:	decq   0x178(%rsp)
  25b59a:	movb   $0x1,0x6c(%r13)
  25b59f:	mov    0x178(%rsp),%rax
  25b5a7:	mov    %rax,0x40(%r13)
  25b5ab:	incq   0x250(%rsp)
  25b5b3:	mov    0x80(%rsp),%rax
  25b5bb:	mov    %eax,0x260(%rsp)
  25b5c2:	mov    $0x1,%r15d
  25b5c8:	mov    0x38(%rsp),%r12
  25b5cd:	mov    0x39e22d(%rip),%eax        # 5f9800 <glass::engine::run_whole::ON>
  25b5d3:	test   %eax,%eax
  25b5d5:	je     25a618 <<glass::engine::Engine>::apply+0xf88>
  25b5db:	call   18c936 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  25b5e0:	jmp    25a618 <<glass::engine::Engine>::apply+0xf88>
  25b5e5:	data16 cs nopw 0x0(%rax,%rax,1)
  25b5f0:	mov    0x39bae1(%rip),%rax        # 5f70d8 <_DYNAMIC+0xab8>
  25b5f7:	mov    (%rax),%rax
  25b5fa:	mov    $0x1b,%edi
  25b5ff:	mov    %r14,%rsi
  25b602:	mov    0x138(%rsp),%rbx
  25b60a:	mov    %rbx,%rdx
  25b60d:	call   *%rax
  25b60f:	mov    %r14,%r13
  25b612:	mov    %rbx,%r14
  25b615:	cmp    $0x1,%rax
  25b619:	jne    25b8d0 <<glass::engine::Engine>::apply+0x2240>
  25b61f:	mov    %rdx,%rcx
  25b622:	sub    %r13,%rcx
  25b625:	movb   $0x1,0xa80(%r12)
  25b62e:	movb   $0x0,0xa7e(%r12)
  25b637:	inc    %rcx
  25b63a:	cmp    %r15,%rcx
  25b63d:	jb     25b8db <<glass::engine::Engine>::apply+0x224b>
  25b643:	movzbl 0xa7e(%r12),%eax
  25b64c:	jmp    25b9d1 <<glass::engine::Engine>::apply+0x2341>
  25b651:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25b660:	mov    0x18(%rsp),%r15
  25b665:	cmp    %rbp,%r15
  25b668:	jb     25bc1f <<glass::engine::Engine>::apply+0x258f>
  25b66e:	mov    0x28(%rsp),%r13
  25b673:	mov    %r13,%rbx
  25b676:	add    %rbp,%rbx
  25b679:	mov    0x39ba58(%rip),%rax        # 5f70d8 <_DYNAMIC+0xab8>
  25b680:	mov    (%rax),%rax
  25b683:	mov    $0x1b,%edi
  25b688:	mov    %rbx,%rsi
  25b68b:	mov    0x138(%rsp),%r14
  25b693:	mov    %r14,%rdx
  25b696:	call   *%rax
  25b698:	cmp    $0x1,%rax
  25b69c:	jne    25b6b9 <<glass::engine::Engine>::apply+0x2029>
  25b69e:	sub    %rbx,%rdx
  25b6a1:	movb   $0x1,0xa80(%r12)
  25b6aa:	movb   $0x0,0xa7e(%r12)
  25b6b3:	add    %rdx,%rbp
  25b6b6:	inc    %rbp
  25b6b9:	cmp    %r15,%rbp
  25b6bc:	jae    25b6f3 <<glass::engine::Engine>::apply+0x2063>
  25b6be:	mov    0x60(%rsp),%rdi
  25b6c3:	mov    %r13,%rsi
  25b6c6:	mov    %r15,%rdx
  25b6c9:	mov    %rbp,%rcx
  25b6cc:	mov    %r15,%r8
  25b6cf:	call   271460 <<glass::engine::Mirror>::stretch>
  25b6d4:	cmp    %r15,%rax
  25b6d7:	jae    25b6f3 <<glass::engine::Engine>::apply+0x2063>
  25b6d9:	cmpb   $0x0,0xa80(%r12)
  25b6e2:	jne    25b6f3 <<glass::engine::Engine>::apply+0x2063>
  25b6e4:	movzbl -0x1(%r14),%eax
  25b6e9:	shr    $0x7,%al
  25b6ec:	mov    0x60(%rsp),%rcx
  25b6f1:	mov    %al,(%rcx)
  25b6f3:	movzbl 0xa7e(%r12),%eax
  25b6fc:	mov    %al,0xa7f(%r12)
  25b704:	sub    0x8(%rsp),%r15
  25b709:	mov    0x108(%rsp),%rbx
  25b711:	jbe    25b740 <<glass::engine::Engine>::apply+0x20b0>
  25b713:	movzbl 0x3a143e(%rip),%eax        # 5fcb58 <glass::engine::counters::COUNTING>
  25b71a:	test   %al,%al
  25b71c:	je     25b726 <<glass::engine::Engine>::apply+0x2096>
  25b71e:	lock add %r15,0x3a143a(%rip)        # 5fcb60 <glass::engine::counters::VTE_BYTES>
  25b726:	movzbl 0x3a13cb(%rip),%eax        # 5fcaf8 <glass::engine::probes::RUN_PROBE>
  25b72d:	cmp    $0x68,%al
  25b72f:	jne    25ba7a <<glass::engine::Engine>::apply+0x23ea>
  25b735:	data16 cs nopw 0x0(%rax,%rax,1)
  25b740:	mov    0x260(%rsp),%rax
  25b748:	mov    %rax,0xa70(%r12)
  25b750:	mov    0x268(%rsp),%eax
  25b757:	mov    %eax,0xa78(%r12)
  25b75f:	pshufd $0x4e,0x240(%rsp),%xmm0
  25b769:	movdqu %xmm0,0xa60(%r12)
  25b773:	movzbl 0x26d(%rsp),%eax
  25b77b:	mov    %al,0xa7d(%r12)
  25b783:	movzbl 0x26c(%rsp),%eax
  25b78b:	and    $0x1,%eax
  25b78e:	shl    $0x5,%eax
  25b791:	mov    0x238(%rsp,%rax,1),%rax
  25b799:	mov    0xa58(%r12),%rcx
  25b7a1:	cmp    %rcx,%rax
  25b7a4:	cmova  %rax,%rcx
  25b7a8:	mov    %rcx,0xa58(%r12)
  25b7b0:	mov    0x1c0(%rsp),%rax
  25b7b8:	mov    %rax,0x28(%rsp)
  25b7bd:	mov    0x1c8(%rsp),%r13
  25b7c5:	mov    0x1d0(%rsp),%r14
  25b7cd:	movq   $0x0,0x1c0(%rsp)
  25b7d9:	movq   $0x8,0x1c8(%rsp)
  25b7e5:	movq   $0x0,0x1d0(%rsp)
  25b7f1:	test   %r14,%r14
  25b7f4:	je     25b852 <<glass::engine::Engine>::apply+0x21c2>
  25b7f6:	mov    0x8e8(%r12),%rax
  25b7fe:	mov    0x8f8(%r12),%r15
  25b806:	sub    %r15,%rax
  25b809:	cmp    %rax,%r14
  25b80c:	ja     25bb4d <<glass::engine::Engine>::apply+0x24bd>
  25b812:	mov    %r14,%rax
  25b815:	shl    $0x4,%rax
  25b819:	lea    (%rax,%rax,2),%rdx
  25b81d:	lea    (%r15,%r15,2),%rdi
  25b821:	shl    $0x4,%rdi
  25b825:	add    0x8f0(%r12),%rdi
  25b82d:	mov    %r13,%rsi
  25b830:	call   *0x39b01a(%rip)        # 5f6850 <memcpy@GLIBC_2.14>
  25b836:	add    %r14,%r15
  25b839:	mov    %r15,0x8f8(%r12)
  25b841:	cmpq   $0x0,0x28(%rsp)
  25b847:	je     25b852 <<glass::engine::Engine>::apply+0x21c2>
  25b849:	mov    %r13,%rdi
  25b84c:	call   *0x39b016(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25b852:	mov    0x1f0(%rsp),%r15
  25b85a:	lea    0x1f8(%rsp),%rax
  25b862:	movups (%rax),%xmm0
  25b865:	movups 0x10(%rax),%xmm1
  25b869:	movups 0x20(%rax),%xmm2
  25b86d:	movaps %xmm0,0xa0(%rsp)
  25b875:	movaps %xmm1,0xb0(%rsp)
  25b87d:	movaps %xmm2,0xc0(%rsp)
  25b885:	movq   $0xffffffffffffffff,0x1f0(%rsp)
  25b891:	cmp    $0xffffffffffffffff,%r15
  25b895:	je     25b8c0 <<glass::engine::Engine>::apply+0x2230>
  25b897:	cmpq   $0x0,0x998(%r12)
  25b8a0:	jle    25b91a <<glass::engine::Engine>::apply+0x228a>
  25b8a2:	mov    (%rbx),%rdi
  25b8a5:	call   *0x39afbd(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25b8ab:	cmpq   $0x0,0x1f0(%rsp)
  25b8b4:	setg   %bpl
  25b8b8:	jmp    25b91c <<glass::engine::Engine>::apply+0x228c>
  25b8ba:	nopw   0x0(%rax,%rax,1)
  25b8c0:	xor    %ebp,%ebp
  25b8c2:	jmp    25b947 <<glass::engine::Engine>::apply+0x22b7>
  25b8c7:	nopw   0x0(%rax,%rax,1)
  25b8d0:	xor    %ecx,%ecx
  25b8d2:	cmp    %r15,%rcx
  25b8d5:	jae    25b643 <<glass::engine::Engine>::apply+0x1fb3>
  25b8db:	mov    0x60(%rsp),%rdi
  25b8e0:	mov    %r13,%rsi
  25b8e3:	mov    %r15,%rdx
  25b8e6:	mov    %r15,%r8
  25b8e9:	call   271460 <<glass::engine::Mirror>::stretch>
  25b8ee:	cmp    %r15,%rax
  25b8f1:	jae    25b9c9 <<glass::engine::Engine>::apply+0x2339>
  25b8f7:	cmpb   $0x0,0xa80(%r12)
  25b900:	jne    25b9c9 <<glass::engine::Engine>::apply+0x2339>
  25b906:	movzbl -0x1(%r14),%eax
  25b90b:	shr    $0x7,%al
  25b90e:	mov    0x60(%rsp),%rcx
  25b913:	mov    %al,(%rcx)
  25b915:	jmp    25b9d1 <<glass::engine::Engine>::apply+0x2341>
  25b91a:	xor    %ebp,%ebp
  25b91c:	mov    %r15,0x998(%r12)
  25b924:	movaps 0xa0(%rsp),%xmm0
  25b92c:	movaps 0xb0(%rsp),%xmm1
  25b934:	movaps 0xc0(%rsp),%xmm2
  25b93c:	movups %xmm2,0x20(%rbx)
  25b940:	movups %xmm1,0x10(%rbx)
  25b944:	movups %xmm0,(%rbx)
  25b947:	mov    0x1d8(%rsp),%rbx
  25b94f:	mov    0x1e0(%rsp),%r12
  25b957:	mov    0x1f8(%rsp),%r15
  25b95f:	cmpq   $0x0,0x1c0(%rsp)
  25b968:	je     25b978 <<glass::engine::Engine>::apply+0x22e8>
  25b96a:	mov    0x1c8(%rsp),%rdi
  25b972:	call   *0x39aef0(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25b978:	test   %rbx,%rbx
  25b97b:	je     25b986 <<glass::engine::Engine>::apply+0x22f6>
  25b97d:	mov    %r12,%rdi
  25b980:	call   *0x39aee2(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25b986:	test   %bpl,%bpl
  25b989:	je     25b994 <<glass::engine::Engine>::apply+0x2304>
  25b98b:	mov    %r15,%rdi
  25b98e:	call   *0x39aed4(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25b994:	mov    0x38(%rsp),%rbx
  25b999:	mov    %rbx,%rdi
  25b99c:	call   258900 <<glass::engine::Engine>::fold_sentinel>
  25b9a1:	test   %r14,%r14
  25b9a4:	setne  %al
  25b9a7:	cmpq   $0x0,0x28(%rsp)
  25b9ad:	sete   %cl
  25b9b0:	or     %al,%cl
  25b9b2:	cmp    $0x1,%cl
  25b9b5:	je     259770 <<glass::engine::Engine>::apply+0xe0>
  25b9bb:	mov    %r13,%rdi
  25b9be:	call   *0x39aea4(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25b9c4:	jmp    259770 <<glass::engine::Engine>::apply+0xe0>
  25b9c9:	mov    0x60(%rsp),%rax
  25b9ce:	movzbl (%rax),%eax
  25b9d1:	mov    %al,0xa7f(%r12)
  25b9d9:	mov    0x108(%rsp),%rbx
  25b9e1:	xor    %ebp,%ebp
  25b9e3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  25b9f0:	cmpl   $0xffffffff,0x710(%r12)
  25b9f9:	jne    25ba54 <<glass::engine::Engine>::apply+0x23c4>
  25b9fb:	mov    0x78(%rsp),%rax
  25ba00:	mov    %rax,0xa0(%rsp)
  25ba08:	lea    0x1b0(%rsp),%rax
  25ba10:	mov    %rax,0xa8(%rsp)
  25ba18:	movb   $0x0,0xb0(%rsp)
  25ba20:	mov    %r15,%rcx
  25ba23:	sub    %rbp,%rcx
  25ba26:	jb     25bb8a <<glass::engine::Engine>::apply+0x24fa>
  25ba2c:	mov    %r13,%rdx
  25ba2f:	add    %rbp,%rdx
  25ba32:	mov    0x118(%rsp),%rdi
  25ba3a:	lea    0xa0(%rsp),%rsi
  25ba42:	call   1a15a0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25ba47:	add    %rax,%rbp
  25ba4a:	cmp    %r15,%rbp
  25ba4d:	jne    25b9f0 <<glass::engine::Engine>::apply+0x2360>
  25ba4f:	jmp    25b740 <<glass::engine::Engine>::apply+0x20b0>
  25ba54:	mov    %r15,%rcx
  25ba57:	sub    %rbp,%rcx
  25ba5a:	jb     25bc96 <<glass::engine::Engine>::apply+0x2606>
  25ba60:	mov    %r13,%rdx
  25ba63:	add    %rbp,%rdx
  25ba66:	mov    0x78(%rsp),%rdi
  25ba6b:	lea    0x1b0(%rsp),%rsi
  25ba73:	call   195300 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25ba78:	jmp    25ba47 <<glass::engine::Engine>::apply+0x23b7>
  25ba7a:	mov    %r15,%rdx
  25ba7d:	add    0x8(%rsp),%r13
  25ba82:	cmpb   $0x1,0x58(%rsp)
  25ba87:	jne    25bab7 <<glass::engine::Engine>::apply+0x2427>
  25ba89:	cmpl   $0xffffffff,0x710(%r12)
  25ba92:	jne    25bab7 <<glass::engine::Engine>::apply+0x2427>
  25ba94:	lea    0x1b0(%rsp),%rdi
  25ba9c:	mov    %r13,%rsi
  25ba9f:	call   2a33f0 <glass::engine::plain_c0>
  25baa4:	test   %al,%al
  25baa6:	mov    0x108(%rsp),%rbx
  25baae:	mov    %r15,%rdx
  25bab1:	jne    25b740 <<glass::engine::Engine>::apply+0x20b0>
  25bab7:	xor    %ebp,%ebp
  25bab9:	nopl   0x0(%rax)
  25bac0:	cmpl   $0xffffffff,0x710(%r12)
  25bac9:	jne    25bb27 <<glass::engine::Engine>::apply+0x2497>
  25bacb:	mov    0x78(%rsp),%rax
  25bad0:	mov    %rax,0xa0(%rsp)
  25bad8:	lea    0x1b0(%rsp),%rax
  25bae0:	mov    %rax,0xa8(%rsp)
  25bae8:	movb   $0x0,0xb0(%rsp)
  25baf0:	mov    %r15,%rcx
  25baf3:	sub    %rbp,%rcx
  25baf6:	jb     25bb8a <<glass::engine::Engine>::apply+0x24fa>
  25bafc:	mov    %r13,%rdx
  25baff:	add    %rbp,%rdx
  25bb02:	mov    0x118(%rsp),%rdi
  25bb0a:	lea    0xa0(%rsp),%rsi
  25bb12:	call   1a15a0 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  25bb17:	add    %rax,%rbp
  25bb1a:	mov    %r15,%rdx
  25bb1d:	cmp    %r15,%rbp
  25bb20:	jne    25bac0 <<glass::engine::Engine>::apply+0x2430>
  25bb22:	jmp    25b740 <<glass::engine::Engine>::apply+0x20b0>
  25bb27:	mov    %rdx,%rcx
  25bb2a:	sub    %rbp,%rcx
  25bb2d:	jb     25bc96 <<glass::engine::Engine>::apply+0x2606>
  25bb33:	mov    %r13,%rdx
  25bb36:	add    %rbp,%rdx
  25bb39:	mov    0x78(%rsp),%rdi
  25bb3e:	lea    0x1b0(%rsp),%rsi
  25bb46:	call   195300 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  25bb4b:	jmp    25bb17 <<glass::engine::Engine>::apply+0x2487>
  25bb4d:	mov    $0x8,%ecx
  25bb52:	mov    $0x30,%r8d
  25bb58:	mov    0x288(%rsp),%rdi
  25bb60:	mov    %r15,%rsi
  25bb63:	mov    %r14,%rdx
  25bb66:	call   1d0cc0 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  25bb6b:	mov    0x8f8(%r12),%r15
  25bb73:	jmp    25b812 <<glass::engine::Engine>::apply+0x2182>
  25bb78:	add    $0x2a8,%rsp
  25bb7f:	pop    %rbx
  25bb80:	pop    %r12
  25bb82:	pop    %r13
  25bb84:	pop    %r14
  25bb86:	pop    %r15
  25bb88:	pop    %rbp
  25bb89:	ret
  25bb8a:	mov    %r15,%r8
  25bb8d:	lea    0x35d024(%rip),%rcx        # 5b8bb8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  25bb94:	jmp    25bbb1 <<glass::engine::Engine>::apply+0x2521>
  25bb96:	mov    %rbx,%r8
  25bb99:	lea    0x372090(%rip),%rcx        # 5cdc30 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x158f0>
  25bba0:	mov    0x18(%rsp),%r15
  25bba5:	jmp    25bbb1 <<glass::engine::Engine>::apply+0x2521>
  25bba7:	mov    %rbx,%r8
  25bbaa:	lea    0x37207f(%rip),%rcx        # 5cdc30 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x158f0>
  25bbb1:	mov    %rbp,%rdi
  25bbb4:	mov    %r8,%rsi
  25bbb7:	mov    %r15,%rdx
  25bbba:	call   *0x39ae38(%rip)        # 5f69f8 <_DYNAMIC+0x3d8>
  25bbc0:	jmp    25bd4f <<glass::engine::Engine>::apply+0x26bf>
  25bbc5:	mov    %rbx,%rbp
  25bbc8:	mov    %r13,%r8
  25bbcb:	lea    0x3744be(%rip),%rcx        # 5d0090 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d50>
  25bbd2:	mov    0x18(%rsp),%r15
  25bbd7:	jmp    25bbb1 <<glass::engine::Engine>::apply+0x2521>
  25bbd9:	lea    0x3744e0(%rip),%rcx        # 5d00c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d80>
  25bbe0:	xor    %ebp,%ebp
  25bbe2:	mov    0x18(%rsp),%r15
  25bbe7:	mov    %rdx,%r8
  25bbea:	jmp    25bbb1 <<glass::engine::Engine>::apply+0x2521>
  25bbec:	mov    0x8(%rsp),%rbp
  25bbf1:	mov    %rbx,%r8
  25bbf4:	lea    0x3744ad(%rip),%rcx        # 5d00a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d68>
  25bbfb:	mov    0x18(%rsp),%r15
  25bc00:	jmp    25bbb1 <<glass::engine::Engine>::apply+0x2521>
  25bc02:	mov    $0xffffffffffffffff,%r8
  25bc09:	xor    %ebp,%ebp
  25bc0b:	xor    %r15d,%r15d
  25bc0e:	lea    0x374463(%rip),%rcx        # 5d0078 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d38>
  25bc15:	jmp    25bbb1 <<glass::engine::Engine>::apply+0x2521>
  25bc17:	mov    %r13,%rbp
  25bc1a:	jmp    25bb99 <<glass::engine::Engine>::apply+0x2509>
  25bc1f:	mov    %r15,%r8
  25bc22:	jmp    25bbaa <<glass::engine::Engine>::apply+0x251a>
  25bc24:	lea    0x37441d(%rip),%rdx        # 5d0048 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d08>
  25bc2b:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bc2d:	mov    %r13,%rbp
  25bc30:	lea    0x3744a1(%rip),%rcx        # 5d00d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d98>
  25bc37:	mov    0x18(%rsp),%r15
  25bc3c:	jmp    25bbb1 <<glass::engine::Engine>::apply+0x2521>
  25bc41:	lea    0x374418(%rip),%rdx        # 5d0060 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d20>
  25bc48:	mov    %r14,%rdi
  25bc4b:	mov    0x18(%rsp),%rsi
  25bc50:	call   *0x39abe2(%rip)        # 5f6838 <_DYNAMIC+0x218>
  25bc56:	jmp    25bd4f <<glass::engine::Engine>::apply+0x26bf>
  25bc5b:	mov    $0x10,%eax
  25bc60:	mov    %rax,0x18(%rsp)
  25bc65:	mov    $0xffffffffffffffff,%r14
  25bc6c:	lea    0x37447d(%rip),%rdx        # 5d00f0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17db0>
  25bc73:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bc75:	mov    $0x8,%edi
  25bc7a:	mov    %r14,%rsi
  25bc7d:	call   *0x39aba5(%rip)        # 5f6828 <_DYNAMIC+0x208>
  25bc83:	mov    $0x10,%eax
  25bc88:	mov    %rax,0x18(%rsp)
  25bc8d:	lea    0x374474(%rip),%rdx        # 5d0108 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17dc8>
  25bc94:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bc96:	mov    %r15,%r8
  25bc99:	lea    0x35cf30(%rip),%rcx        # 5b8bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  25bca0:	jmp    25bbb1 <<glass::engine::Engine>::apply+0x2521>
  25bca5:	mov    $0x10,%eax
  25bcaa:	mov    %rax,0x18(%rsp)
  25bcaf:	lea    0x37446a(%rip),%rdx        # 5d0120 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17de0>
  25bcb6:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bcb8:	mov    %rsi,%r14
  25bcbb:	mov    0x10(%rsp),%rax
  25bcc0:	mov    %rax,0x18(%rsp)
  25bcc5:	lea    0x374364(%rip),%rdx        # 5d0030 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17cf0>
  25bccc:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bcd1:	mov    0x30(%rsp),%r14
  25bcd6:	mov    %rcx,0x18(%rsp)
  25bcdb:	lea    0x35fce6(%rip),%rdx        # 5bb9c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  25bce2:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bce7:	mov    %rcx,%r14
  25bcea:	mov    %rdx,0x18(%rsp)
  25bcef:	lea    0x35fcd2(%rip),%rdx        # 5bb9c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3688>
  25bcf6:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bcfb:	lea    0x3716a6(%rip),%rcx        # 5cd3a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  25bd02:	mov    0x68(%rsp),%rdi
  25bd07:	mov    0x40(%rsp),%rsi
  25bd0c:	call   *0x39ace6(%rip)        # 5f69f8 <_DYNAMIC+0x3d8>
  25bd12:	jmp    25bd4f <<glass::engine::Engine>::apply+0x26bf>
  25bd14:	mov    0x30(%rsp),%r14
  25bd19:	jmp    25bd27 <<glass::engine::Engine>::apply+0x2697>
  25bd1b:	mov    0x30(%rsp),%r14
  25bd20:	jmp    25bd56 <<glass::engine::Engine>::apply+0x26c6>
  25bd22:	mov    0x70(%rsp),%r14
  25bd27:	mov    %rax,0x18(%rsp)
  25bd2c:	lea    0x372275(%rip),%rdx        # 5cdfa8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c68>
  25bd33:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bd38:	lea    0x371669(%rip),%rcx        # 5cd3a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15068>
  25bd3f:	mov    0x68(%rsp),%rdi
  25bd44:	mov    0x40(%rsp),%rsi
  25bd49:	call   *0x39aca9(%rip)        # 5f69f8 <_DYNAMIC+0x3d8>
  25bd4f:	ud2
  25bd51:	mov    0x70(%rsp),%r14
  25bd56:	mov    %rax,0x18(%rsp)
  25bd5b:	lea    0x37222e(%rip),%rdx        # 5cdf90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c50>
  25bd62:	jmp    25bc48 <<glass::engine::Engine>::apply+0x25b8>
  25bd67:	mov    %rax,%r15
  25bd6a:	cmpq   $0x0,0x28(%rsp)
  25bd70:	je     25bdda <<glass::engine::Engine>::apply+0x274a>
  25bd72:	mov    %r13,%rdi
  25bd75:	call   *0x39aaed(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25bd7b:	jmp    25bdda <<glass::engine::Engine>::apply+0x274a>
  25bd7d:	mov    %rax,%r15
  25bd80:	lock decq (%r12)
  25bd85:	je     25bd97 <<glass::engine::Engine>::apply+0x2707>
  25bd87:	jmp    25bdda <<glass::engine::Engine>::apply+0x274a>
  25bd89:	mov    %rax,%r15
  25bd8c:	mov    0x8(%rsp),%rax
  25bd91:	lock decq (%rax)
  25bd95:	jne    25bdda <<glass::engine::Engine>::apply+0x274a>
  25bd97:	lea    0xa0(%rsp),%rdi
  25bd9f:	call   *0x39aae3(%rip)        # 5f6888 <_DYNAMIC+0x268>
  25bda5:	jmp    25bdda <<glass::engine::Engine>::apply+0x274a>
  25bda7:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bda9:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdab:	mov    %rax,%r15
  25bdae:	test   %r14,%r14
  25bdb1:	setne  %al
  25bdb4:	cmpq   $0x0,0x28(%rsp)
  25bdba:	sete   %cl
  25bdbd:	or     %al,%cl
  25bdbf:	jne    25be46 <<glass::engine::Engine>::apply+0x27b6>
  25bdc5:	jmp    25be03 <<glass::engine::Engine>::apply+0x2773>
  25bdc7:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdc9:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdcb:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdcd:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdcf:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdd1:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdd3:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdd5:	jmp    25bdd7 <<glass::engine::Engine>::apply+0x2747>
  25bdd7:	mov    %rax,%r15
  25bdda:	cmpq   $0x0,0x1c0(%rsp)
  25bde3:	jne    25be14 <<glass::engine::Engine>::apply+0x2784>
  25bde5:	cmpq   $0x0,0x1d8(%rsp)
  25bdee:	jne    25be2d <<glass::engine::Engine>::apply+0x279d>
  25bdf0:	cmpq   $0x0,0x1f0(%rsp)
  25bdf9:	jle    25be46 <<glass::engine::Engine>::apply+0x27b6>
  25bdfb:	mov    0x1f8(%rsp),%r13
  25be03:	mov    %r13,%rdi
  25be06:	call   *0x39aa5c(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25be0c:	mov    %r15,%rdi
  25be0f:	call   5b4c30 <_Unwind_Resume@plt>
  25be14:	mov    0x1c8(%rsp),%rdi
  25be1c:	call   *0x39aa46(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25be22:	cmpq   $0x0,0x1d8(%rsp)
  25be2b:	je     25bdf0 <<glass::engine::Engine>::apply+0x2760>
  25be2d:	mov    0x1e0(%rsp),%rdi
  25be35:	call   *0x39aa2d(%rip)        # 5f6868 <_DYNAMIC+0x248>
  25be3b:	cmpq   $0x0,0x1f0(%rsp)
  25be44:	jg     25bdfb <<glass::engine::Engine>::apply+0x276b>
  25be46:	mov    %r15,%rdi
  25be49:	call   5b4c30 <_Unwind_Resume@plt>
