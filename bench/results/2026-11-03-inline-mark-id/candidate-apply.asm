
/tmp/glass-inline-mark-id-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

000000000026eb40 <<glass::engine::Engine>::apply>:
  26eb40:	push   %rbp
  26eb41:	push   %r15
  26eb43:	push   %r14
  26eb45:	push   %r13
  26eb47:	push   %r12
  26eb49:	push   %rbx
  26eb4a:	sub    $0x258,%rsp
  26eb51:	mov    %rdi,%rbx
  26eb54:	testb  $0x10,0x6d5(%rdi)
  26eb5b:	jne    26ebbd <<glass::engine::Engine>::apply+0x7d>
  26eb5d:	cmpb   $0x2,0x278(%rbx)
  26eb64:	jne    26ebbd <<glass::engine::Engine>::apply+0x7d>
  26eb66:	mov    0xb0(%rbx),%rax
  26eb6d:	dec    %rax
  26eb70:	movq   $0x0,0x250(%rbx)
  26eb7b:	movl   $0x0,0x258(%rbx)
  26eb85:	movb   $0x0,0x260(%rbx)
  26eb8c:	mov    %rax,0x268(%rbx)
  26eb93:	movl   $0x0,0x270(%rbx)
  26eb9d:	movb   $0x1,0x278(%rbx)
  26eba4:	movb   $0x0,0x280(%rbx)
  26ebab:	movq   $0x0,0xa60(%rbx)
  26ebb6:	movb   $0x1,0xa7d(%rbx)
  26ebbd:	test   %rdx,%rdx
  26ebc0:	je     270e78 <<glass::engine::Engine>::apply+0x2338>
  26ebc6:	lea    0x10(%rbx),%rax
  26ebca:	mov    %rax,0x248(%rsp)
  26ebd2:	lea    0x6f0(%rbx),%rax
  26ebd9:	mov    %rax,0x78(%rsp)
  26ebde:	lea    0x8e8(%rbx),%rax
  26ebe5:	mov    %rax,0x238(%rsp)
  26ebed:	lea    0xa7e(%rbx),%rax
  26ebf4:	mov    %rax,0x58(%rsp)
  26ebf9:	lea    0x720(%rbx),%rax
  26ec00:	mov    %rax,0x100(%rsp)
  26ec08:	lea    0x9a0(%rbx),%rax
  26ec0f:	mov    %rax,0xf0(%rsp)
  26ec17:	mov    %rbx,0x40(%rsp)
  26ec1c:	jmp    26ec3b <<glass::engine::Engine>::apply+0xfb>
  26ec1e:	xchg   %ax,%ax
  26ec20:	mov    0x120(%rsp),%rsi
  26ec28:	mov    0x250(%rsp),%rdx
  26ec30:	sub    0x20(%rsp),%rdx
  26ec35:	je     270e78 <<glass::engine::Engine>::apply+0x2338>
  26ec3b:	mov    %rsi,0x28(%rsp)
  26ec40:	cmp    $0x2000,%rdx
  26ec47:	mov    $0x2000,%eax
  26ec4c:	mov    %rdx,0x250(%rsp)
  26ec54:	cmovb  %rdx,%rax
  26ec58:	mov    %rax,0x20(%rsp)
  26ec5d:	mov    0x6d4(%rbx),%ebp
  26ec63:	mov    $0x1000,%eax
  26ec68:	and    %eax,%ebp
  26ec6a:	mov    0xa58(%rbx),%r9
  26ec71:	mov    $0x0,%r10d
  26ec77:	cmove  %r9,%r10
  26ec7b:	mov    0xa68(%rbx),%rax
  26ec82:	mov    %rax,%r11
  26ec85:	cmove  %r9,%r11
  26ec89:	mov    0x910(%rbx),%r13
  26ec90:	mov    $0x8,%r12d
  26ec96:	test   %r13,%r13
  26ec99:	je     26ecfc <<glass::engine::Engine>::apply+0x1bc>
  26ec9b:	mov    %r11,0x50(%rsp)
  26eca0:	mov    %r10,0x18(%rsp)
  26eca5:	mov    %r9,0x8(%rsp)
  26ecaa:	mov    0x908(%rbx),%r15
  26ecb1:	lea    0x0(,%r13,8),%rax
  26ecb9:	lea    (%rax,%rax,2),%r14
  26ecbd:	mov    $0x8,%esi
  26ecc2:	mov    %r14,%rdi
  26ecc5:	call   *0x3bc43d(%rip)        # 62b108 <_DYNAMIC+0x228>
  26eccb:	test   %rax,%rax
  26ecce:	je     270f75 <<glass::engine::Engine>::apply+0x2435>
  26ecd4:	mov    %rax,%r12
  26ecd7:	mov    %rax,%rdi
  26ecda:	mov    %r15,%rsi
  26ecdd:	mov    %r14,%rdx
  26ece0:	call   *0x3bc42a(%rip)        # 62b110 <memcpy@GLIBC_2.14>
  26ece6:	mov    0xa68(%rbx),%rax
  26eced:	mov    0x8(%rsp),%r9
  26ecf2:	mov    0x18(%rsp),%r10
  26ecf7:	mov    0x50(%rsp),%r11
  26ecfc:	mov    0x20(%rsp),%r15
  26ed01:	mov    0x28(%rsp),%r14
  26ed06:	lea    (%r14,%r15,1),%rcx
  26ed0a:	mov    %rcx,0x120(%rsp)
  26ed12:	mov    0xa78(%rbx),%ecx
  26ed18:	mov    0xa60(%rbx),%rdx
  26ed1f:	movzbl 0xa7d(%rbx),%esi
  26ed26:	movzbl 0xa81(%rbx),%edi
  26ed2d:	mov    0x248(%rsp),%r8
  26ed35:	mov    %r8,0x1b8(%rsp)
  26ed3d:	movq   $0x0,0x150(%rsp)
  26ed49:	movq   $0x8,0x158(%rsp)
  26ed55:	movq   $0x0,0x160(%rsp)
  26ed61:	mov    %r13,0x168(%rsp)
  26ed69:	mov    %r12,0x170(%rsp)
  26ed71:	mov    %r13,0x178(%rsp)
  26ed79:	mov    %r11,0x1c0(%rsp)
  26ed81:	mov    %r10,0x1c8(%rsp)
  26ed89:	shr    $0xc,%ebp
  26ed8c:	mov    %bpl,0x1fc(%rsp)
  26ed94:	mov    %rax,0x1d0(%rsp)
  26ed9c:	mov    %ecx,0x1f8(%rsp)
  26eda3:	mov    %rdx,0x1d8(%rsp)
  26edab:	mov    %sil,0x1fd(%rsp)
  26edb3:	mov    %r15,0x1e0(%rsp)
  26edbb:	movups (%rbx),%xmm0
  26edbe:	movaps %xmm0,0x140(%rsp)
  26edc6:	movq   $0xffffffffffffffff,0x180(%rsp)
  26edd2:	mov    %r9,0x1e8(%rsp)
  26edda:	mov    %dil,0x1fe(%rsp)
  26ede2:	mov    0xa70(%rbx),%rax
  26ede9:	mov    %rax,0x1f0(%rsp)
  26edf1:	test   %dil,%dil
  26edf4:	mov    %rbx,%r12
  26edf7:	je     2708f0 <<glass::engine::Engine>::apply+0x1db0>
  26edfd:	mov    $0x3,%eax
  26ee02:	sub    %r15,%rax
  26ee05:	mov    %rax,0x240(%rsp)
  26ee0d:	mov    $0x1,%al
  26ee0f:	mov    %eax,0xec(%rsp)
  26ee16:	xor    %ebp,%ebp
  26ee18:	mov    %r14,0x208(%rsp)
  26ee20:	mov    $0x1,%al
  26ee22:	mov    %eax,0x114(%rsp)
  26ee29:	movq   $0x0,0x8(%rsp)
  26ee32:	movl   $0x0,0xb0(%rsp)
  26ee3d:	movq   $0x0,0x50(%rsp)
  26ee46:	xor    %r13d,%r13d
  26ee49:	testb  $0x1,0xec(%rsp)
  26ee51:	je     26eeb0 <<glass::engine::Engine>::apply+0x370>
  26ee53:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  26ee60:	mov    0x3bcb69(%rip),%rax        # 62b9d0 <_DYNAMIC+0xaf0>
  26ee67:	mov    (%rax),%rax
  26ee6a:	mov    $0x1b,%edi
  26ee6f:	mov    0x208(%rsp),%rsi
  26ee77:	mov    0x120(%rsp),%rdx
  26ee7f:	call   *%rax
  26ee81:	cmp    $0x1,%rax
  26ee85:	jne    26eeb0 <<glass::engine::Engine>::apply+0x370>
  26ee87:	mov    %rdx,%rax
  26ee8a:	sub    0x28(%rsp),%rax
  26ee8f:	inc    %rdx
  26ee92:	mov    $0x1,%cl
  26ee94:	mov    %ecx,0xec(%rsp)
  26ee9b:	mov    %rdx,0x208(%rsp)
  26eea3:	jmp    26eed9 <<glass::engine::Engine>::apply+0x399>
  26eea5:	data16 cs nopw 0x0(%rax,%rax,1)
  26eeb0:	testb  $0x1,0x114(%rsp)
  26eeb8:	je     270960 <<glass::engine::Engine>::apply+0x1e20>
  26eebe:	movl   $0x0,0x114(%rsp)
  26eec9:	mov    0x20(%rsp),%rax
  26eece:	movl   $0x0,0xec(%rsp)
  26eed9:	mov    %rax,%rdx
  26eedc:	sub    %r13,%rax
  26eedf:	cmp    $0x18,%rax
  26eee3:	mov    %rdx,0x18(%rsp)
  26eee8:	jb     26f530 <<glass::engine::Engine>::apply+0x9f0>
  26eeee:	cmp    %rdx,0x20(%rsp)
  26eef3:	jae    26ef38 <<glass::engine::Engine>::apply+0x3f8>
  26eef5:	jmp    270ed9 <<glass::engine::Engine>::apply+0x2399>
  26eefa:	mov    0x50(%rsp),%rax
  26eeff:	mov    %eax,%ebp
  26ef01:	mov    0x40(%rsp),%rax
  26ef06:	cmpl   $0xffffffff,0x710(%rax)
  26ef0d:	je     26f296 <<glass::engine::Engine>::apply+0x756>
  26ef13:	mov    %ebp,%eax
  26ef15:	mov    %rax,0x50(%rsp)
  26ef1a:	nopw   0x0(%rax,%rax,1)
  26ef20:	mov    0x18(%rsp),%rdx
  26ef25:	mov    %rdx,%rax
  26ef28:	sub    %r13,%rax
  26ef2b:	mov    %r13,%rbp
  26ef2e:	cmp    $0x17,%rax
  26ef32:	jbe    26f533 <<glass::engine::Engine>::apply+0x9f3>
  26ef38:	lea    0xc0(%rsp),%rdi
  26ef40:	mov    0x28(%rsp),%rsi
  26ef45:	mov    %r13,%rcx
  26ef48:	call   2be870 <glass::engine::next_run>
  26ef4d:	movzbl 0xd0(%rsp),%r12d
  26ef56:	cmp    $0x2,%r12b
  26ef5a:	je     26f5c0 <<glass::engine::Engine>::apply+0xa80>
  26ef60:	mov    0xc0(%rsp),%rbx
  26ef68:	cmp    %rbp,%rbx
  26ef6b:	jb     270e96 <<glass::engine::Engine>::apply+0x2356>
  26ef71:	mov    0x20(%rsp),%r15
  26ef76:	cmp    %r15,%rbx
  26ef79:	ja     270ea7 <<glass::engine::Engine>::apply+0x2367>
  26ef7f:	mov    0xc8(%rsp),%r13
  26ef87:	mov    0x28(%rsp),%rax
  26ef8c:	lea    (%rax,%rbp,1),%r15
  26ef90:	lea    (%rax,%rbx,1),%r14
  26ef94:	mov    0x3bca2d(%rip),%rax        # 62b9c8 <_DYNAMIC+0xae8>
  26ef9b:	mov    (%rax),%rax
  26ef9e:	mov    $0x1b,%edi
  26efa3:	mov    %r15,%rsi
  26efa6:	mov    %r14,%rdx
  26efa9:	call   *%rax
  26efab:	cmp    $0x1,%rax
  26efaf:	jne    26efcd <<glass::engine::Engine>::apply+0x48d>
  26efb1:	sub    %r15,%rdx
  26efb4:	mov    0x40(%rsp),%rax
  26efb9:	movb   $0x1,0xa80(%rax)
  26efc0:	movb   $0x0,0xa7e(%rax)
  26efc7:	add    %rdx,%rbp
  26efca:	inc    %rbp
  26efcd:	cmp    %rbx,%rbp
  26efd0:	jae    26f00e <<glass::engine::Engine>::apply+0x4ce>
  26efd2:	mov    0x58(%rsp),%rdi
  26efd7:	mov    0x28(%rsp),%rsi
  26efdc:	mov    0x20(%rsp),%rdx
  26efe1:	mov    %rbp,%rcx
  26efe4:	mov    %rbx,%r8
  26efe7:	call   2872d0 <<glass::engine::Mirror>::stretch>
  26efec:	cmp    %rbx,%rax
  26efef:	jae    26f00e <<glass::engine::Engine>::apply+0x4ce>
  26eff1:	mov    0x40(%rsp),%rax
  26eff6:	cmpb   $0x0,0xa80(%rax)
  26effd:	jne    26f00e <<glass::engine::Engine>::apply+0x4ce>
  26efff:	movzbl -0x1(%r14),%eax
  26f004:	shr    $0x7,%al
  26f007:	mov    0x58(%rsp),%rcx
  26f00c:	mov    %al,(%rcx)
  26f00e:	mov    0x58(%rsp),%rdi
  26f013:	mov    0x28(%rsp),%rsi
  26f018:	mov    0x20(%rsp),%rdx
  26f01d:	mov    %rbx,%rcx
  26f020:	mov    %r13,%r8
  26f023:	call   2872d0 <<glass::engine::Mirror>::stretch>
  26f028:	mov    %rax,%rbx
  26f02b:	mov    0x40(%rsp),%rax
  26f030:	cmpb   $0x0,0xa80(%rax)
  26f037:	jne    26ef20 <<glass::engine::Engine>::apply+0x3e0>
  26f03d:	lea    -0x1(%r13),%r14
  26f041:	cmp    0x20(%rsp),%r14
  26f046:	jae    270f24 <<glass::engine::Engine>::apply+0x23e4>
  26f04c:	mov    0x28(%rsp),%rax
  26f051:	movzbl (%rax,%r14,1),%eax
  26f056:	shr    $0x7,%al
  26f059:	mov    0x58(%rsp),%rcx
  26f05e:	mov    %al,(%rcx)
  26f060:	test   %rbx,%rbx
  26f063:	je     26f092 <<glass::engine::Engine>::apply+0x552>
  26f065:	lea    -0x1(%rbx),%r14
  26f069:	cmp    0x20(%rsp),%r14
  26f06e:	jae    270f41 <<glass::engine::Engine>::apply+0x2401>
  26f074:	mov    0x28(%rsp),%rax
  26f079:	movzbl (%rax,%r14,1),%eax
  26f07e:	shr    $0x7,%al
  26f081:	mov    %r13,%r14
  26f084:	sub    %rbx,%r14
  26f087:	cmp    $0x18,%r14
  26f08b:	jae    26f0ae <<glass::engine::Engine>::apply+0x56e>
  26f08d:	jmp    26ef20 <<glass::engine::Engine>::apply+0x3e0>
  26f092:	mov    0x40(%rsp),%rax
  26f097:	movzbl 0xa7f(%rax),%eax
  26f09e:	mov    %r13,%r14
  26f0a1:	sub    %rbx,%r14
  26f0a4:	cmp    $0x18,%r14
  26f0a8:	jb     26ef20 <<glass::engine::Engine>::apply+0x3e0>
  26f0ae:	test   %al,%al
  26f0b0:	jne    26ef20 <<glass::engine::Engine>::apply+0x3e0>
  26f0b6:	mov    %rbx,%r15
  26f0b9:	sub    0x8(%rsp),%r15
  26f0be:	jbe    26eefa <<glass::engine::Engine>::apply+0x3ba>
  26f0c4:	movzbl 0x3c3bed(%rip),%eax        # 632cb8 <glass::engine::probes::RUN_PROBE>
  26f0cb:	mov    $0x1,%bpl
  26f0ce:	cmp    $0x68,%al
  26f0d0:	je     26f27f <<glass::engine::Engine>::apply+0x73f>
  26f0d6:	cmp    0x20(%rsp),%rbx
  26f0db:	ja     270eec <<glass::engine::Engine>::apply+0x23ac>
  26f0e1:	mov    0x8(%rsp),%rax
  26f0e6:	add    0x28(%rsp),%rax
  26f0eb:	mov    %rax,0x8(%rsp)
  26f0f0:	cmpb   $0x1,0x50(%rsp)
  26f0f5:	jne    26f122 <<glass::engine::Engine>::apply+0x5e2>
  26f0f7:	mov    0x40(%rsp),%rax
  26f0fc:	cmpl   $0xffffffff,0x710(%rax)
  26f103:	jne    26f122 <<glass::engine::Engine>::apply+0x5e2>
  26f105:	lea    0x140(%rsp),%rdi
  26f10d:	mov    0x8(%rsp),%rsi
  26f112:	mov    %r15,%rdx
  26f115:	call   2beb60 <glass::engine::plain_c0>
  26f11a:	test   %al,%al
  26f11c:	jne    26f27f <<glass::engine::Engine>::apply+0x73f>
  26f122:	movzbl 0x3c3b9f(%rip),%eax        # 632cc8 <glass::engine::timers::ON>
  26f129:	test   %al,%al
  26f12b:	je     26f35f <<glass::engine::Engine>::apply+0x81f>
  26f131:	mov    $0x1,%edi
  26f136:	call   545ef0 <<std::sys::pal::unix::time::Timespec>::now>
  26f13b:	mov    %rax,0x50(%rsp)
  26f140:	mov    %edx,0x30(%rsp)
  26f144:	xor    %ebp,%ebp
  26f146:	cs nopw 0x0(%rax,%rax,1)
  26f150:	mov    0x40(%rsp),%rax
  26f155:	cmpl   $0xffffffff,0x710(%rax)
  26f15c:	jne    26f1b7 <<glass::engine::Engine>::apply+0x677>
  26f15e:	mov    0x78(%rsp),%rax
  26f163:	mov    %rax,0x80(%rsp)
  26f16b:	lea    0x140(%rsp),%rax
  26f173:	mov    %rax,0x88(%rsp)
  26f17b:	movb   $0x0,0x90(%rsp)
  26f183:	mov    %r15,%rcx
  26f186:	sub    %rbp,%rcx
  26f189:	jb     270e8a <<glass::engine::Engine>::apply+0x234a>
  26f18f:	mov    0x8(%rsp),%rax
  26f194:	lea    (%rax,%rbp,1),%rdx
  26f198:	mov    0x100(%rsp),%rdi
  26f1a0:	lea    0x80(%rsp),%rsi
  26f1a8:	call   1aad70 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  26f1ad:	add    %rax,%rbp
  26f1b0:	cmp    %r15,%rbp
  26f1b3:	jne    26f150 <<glass::engine::Engine>::apply+0x610>
  26f1b5:	jmp    26f1e0 <<glass::engine::Engine>::apply+0x6a0>
  26f1b7:	mov    %r15,%rcx
  26f1ba:	sub    %rbp,%rcx
  26f1bd:	jb     270f96 <<glass::engine::Engine>::apply+0x2456>
  26f1c3:	mov    0x8(%rsp),%rax
  26f1c8:	lea    (%rax,%rbp,1),%rdx
  26f1cc:	mov    0x78(%rsp),%rdi
  26f1d1:	lea    0x140(%rsp),%rsi
  26f1d9:	call   19e580 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  26f1de:	jmp    26f1ad <<glass::engine::Engine>::apply+0x66d>
  26f1e0:	movzbl 0x3c3ae1(%rip),%eax        # 632cc8 <glass::engine::timers::ON>
  26f1e7:	test   %al,%al
  26f1e9:	mov    $0x1,%bpl
  26f1ec:	je     26f27f <<glass::engine::Engine>::apply+0x73f>
  26f1f2:	mov    $0x1,%edi
  26f1f7:	call   545ef0 <<std::sys::pal::unix::time::Timespec>::now>
  26f1fc:	mov    %rax,0x210(%rsp)
  26f204:	mov    %edx,0x218(%rsp)
  26f20b:	mov    0x50(%rsp),%rax
  26f210:	mov    %rax,0x220(%rsp)
  26f218:	mov    0x30(%rsp),%eax
  26f21c:	mov    %eax,0x228(%rsp)
  26f223:	lea    0x80(%rsp),%rdi
  26f22b:	lea    0x210(%rsp),%rsi
  26f233:	lea    0x220(%rsp),%rdx
  26f23b:	call   545e30 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  26f240:	imul   $0x3b9aca00,0x88(%rsp),%rax
  26f24c:	mov    0x90(%rsp),%ecx
  26f253:	add    %rcx,%rax
  26f256:	cmpb   $0x0,0x80(%rsp)
  26f25e:	mov    $0x0,%ecx
  26f263:	cmove  %rax,%rcx
  26f267:	lock add %rcx,0x3c3a69(%rip)        # 632cd8 <glass::engine::timers::VTE_NS>
  26f26f:	lock incq 0x3c3a91(%rip)        # 632d08 <glass::engine::timers::VTE_CALLS>
  26f277:	lock add %r15,0x3c3a81(%rip)        # 632d00 <glass::engine::timers::VTE_BYTES>
  26f27f:	mov    %rbx,0x8(%rsp)
  26f284:	mov    0x40(%rsp),%rax
  26f289:	cmpl   $0xffffffff,0x710(%rax)
  26f290:	jne    26ef13 <<glass::engine::Engine>::apply+0x3d3>
  26f296:	cmp    0x20(%rsp),%r13
  26f29b:	ja     270ec5 <<glass::engine::Engine>::apply+0x2385>
  26f2a1:	cmp    %rbx,%r13
  26f2a4:	jb     270ec5 <<glass::engine::Engine>::apply+0x2385>
  26f2aa:	movzbl 0x3c3a06(%rip),%r15d        # 632cb8 <glass::engine::probes::RUN_PROBE>
  26f2b2:	movzbl 0x3c3a0f(%rip),%eax        # 632cc8 <glass::engine::timers::ON>
  26f2b9:	test   %al,%al
  26f2bb:	je     26f2ec <<glass::engine::Engine>::apply+0x7ac>
  26f2bd:	mov    $0x1,%edi
  26f2c2:	call   545ef0 <<std::sys::pal::unix::time::Timespec>::now>
  26f2c7:	mov    %rax,0x50(%rsp)
  26f2cc:	mov    %edx,%ebp
  26f2ce:	cmp    $0x63,%r15b
  26f2d2:	jbe    26f2f7 <<glass::engine::Engine>::apply+0x7b7>
  26f2d4:	movzbl %r12b,%eax
  26f2d8:	mov    %r14,%rbx
  26f2db:	sub    %rax,%rbx
  26f2de:	cmp    $0xffffffff,%ebp
  26f2e1:	jne    26f46a <<glass::engine::Engine>::apply+0x92a>
  26f2e7:	jmp    26f502 <<glass::engine::Engine>::apply+0x9c2>
  26f2ec:	mov    $0xffffffff,%ebp
  26f2f1:	cmp    $0x63,%r15b
  26f2f5:	ja     26f2d4 <<glass::engine::Engine>::apply+0x794>
  26f2f7:	mov    0x3c06cb(%rip),%eax        # 62f9c8 <glass::engine::run_whole::ON>
  26f2fd:	test   %eax,%eax
  26f2ff:	jne    26f521 <<glass::engine::Engine>::apply+0x9e1>
  26f305:	mov    0x28(%rsp),%rax
  26f30a:	lea    (%rax,%rbx,1),%rsi
  26f30e:	cmpb   $0x0,0x3c06b7(%rip)        # 62f9cc <glass::engine::run_whole::ON+0x4>
  26f315:	je     26f336 <<glass::engine::Engine>::apply+0x7f6>
  26f317:	test   $0x1,%r12b
  26f31b:	je     26f41f <<glass::engine::Engine>::apply+0x8df>
  26f321:	lea    0x140(%rsp),%rdi
  26f329:	mov    %r14,%rdx
  26f32c:	call   27c0c0 <<glass::engine::Watch>::print_run>
  26f331:	jmp    26f42f <<glass::engine::Engine>::apply+0x8ef>
  26f336:	test   $0x1,%r12b
  26f33a:	je     26f44e <<glass::engine::Engine>::apply+0x90e>
  26f340:	cmp    %rbx,%r13
  26f343:	je     270f02 <<glass::engine::Engine>::apply+0x23c2>
  26f349:	lea    -0x1(%r14),%rdx
  26f34d:	lea    0x140(%rsp),%rdi
  26f355:	call   27c0c0 <<glass::engine::Watch>::print_run>
  26f35a:	jmp    26f45e <<glass::engine::Engine>::apply+0x91e>
  26f35f:	xor    %ebp,%ebp
  26f361:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  26f370:	mov    0x40(%rsp),%rax
  26f375:	cmpl   $0xffffffff,0x710(%rax)
  26f37c:	jne    26f3d7 <<glass::engine::Engine>::apply+0x897>
  26f37e:	mov    0x78(%rsp),%rax
  26f383:	mov    %rax,0x80(%rsp)
  26f38b:	lea    0x140(%rsp),%rax
  26f393:	mov    %rax,0x88(%rsp)
  26f39b:	movb   $0x0,0x90(%rsp)
  26f3a3:	mov    %r15,%rcx
  26f3a6:	sub    %rbp,%rcx
  26f3a9:	jb     270e8a <<glass::engine::Engine>::apply+0x234a>
  26f3af:	mov    0x8(%rsp),%rax
  26f3b4:	lea    (%rax,%rbp,1),%rdx
  26f3b8:	mov    0x100(%rsp),%rdi
  26f3c0:	lea    0x80(%rsp),%rsi
  26f3c8:	call   1aad70 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  26f3cd:	add    %rax,%rbp
  26f3d0:	cmp    %r15,%rbp
  26f3d3:	jne    26f370 <<glass::engine::Engine>::apply+0x830>
  26f3d5:	jmp    26f400 <<glass::engine::Engine>::apply+0x8c0>
  26f3d7:	mov    %r15,%rcx
  26f3da:	sub    %rbp,%rcx
  26f3dd:	jb     270f96 <<glass::engine::Engine>::apply+0x2456>
  26f3e3:	mov    0x8(%rsp),%rax
  26f3e8:	lea    (%rax,%rbp,1),%rdx
  26f3ec:	mov    0x78(%rsp),%rdi
  26f3f1:	lea    0x140(%rsp),%rsi
  26f3f9:	call   19e580 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  26f3fe:	jmp    26f3cd <<glass::engine::Engine>::apply+0x88d>
  26f400:	mov    %rbx,0x8(%rsp)
  26f405:	mov    $0x1,%bpl
  26f408:	mov    0x40(%rsp),%rax
  26f40d:	cmpl   $0xffffffff,0x710(%rax)
  26f414:	jne    26ef13 <<glass::engine::Engine>::apply+0x3d3>
  26f41a:	jmp    26f296 <<glass::engine::Engine>::apply+0x756>
  26f41f:	lea    0x140(%rsp),%rdi
  26f427:	mov    %r14,%rdx
  26f42a:	call   279640 <<glass::engine::Watch>::print_utf8>
  26f42f:	mov    %rax,%rbx
  26f432:	mov    0x1f0(%rsp),%eax
  26f439:	mov    0x40(%rsp),%rcx
  26f43e:	mov    %eax,0x718(%rcx)
  26f444:	cmp    $0xffffffff,%ebp
  26f447:	jne    26f46a <<glass::engine::Engine>::apply+0x92a>
  26f449:	jmp    26f502 <<glass::engine::Engine>::apply+0x9c2>
  26f44e:	lea    0x140(%rsp),%rdi
  26f456:	mov    %r14,%rdx
  26f459:	call   279640 <<glass::engine::Watch>::print_utf8>
  26f45e:	mov    %rax,%rbx
  26f461:	cmp    $0xffffffff,%ebp
  26f464:	je     26f502 <<glass::engine::Engine>::apply+0x9c2>
  26f46a:	movzbl 0x3c3857(%rip),%eax        # 632cc8 <glass::engine::timers::ON>
  26f471:	test   %al,%al
  26f473:	je     26f4fa <<glass::engine::Engine>::apply+0x9ba>
  26f479:	mov    $0x1,%edi
  26f47e:	call   545ef0 <<std::sys::pal::unix::time::Timespec>::now>
  26f483:	mov    %rax,0x210(%rsp)
  26f48b:	mov    %edx,0x218(%rsp)
  26f492:	mov    0x50(%rsp),%rax
  26f497:	mov    %rax,0x220(%rsp)
  26f49f:	mov    %ebp,0x228(%rsp)
  26f4a6:	lea    0x80(%rsp),%rdi
  26f4ae:	lea    0x210(%rsp),%rsi
  26f4b6:	lea    0x220(%rsp),%rdx
  26f4be:	call   545e30 <<std::sys::pal::unix::time::Timespec>::sub_timespec>
  26f4c3:	imul   $0x3b9aca00,0x88(%rsp),%rax
  26f4cf:	mov    0x90(%rsp),%ecx
  26f4d6:	add    %rcx,%rax
  26f4d9:	cmpb   $0x0,0x80(%rsp)
  26f4e1:	mov    $0x0,%ecx
  26f4e6:	cmove  %rax,%rcx
  26f4ea:	lock add %rcx,0x3c37de(%rip)        # 632cd0 <glass::engine::timers::RUN_NS>
  26f4f2:	lock incq 0x3c37fe(%rip)        # 632cf8 <glass::engine::timers::RUN_CALLS>
  26f4fa:	lock add %r14,0x3c37ee(%rip)        # 632cf0 <glass::engine::timers::RUN_BYTES>
  26f502:	movzbl 0x3c380f(%rip),%eax        # 632d18 <glass::engine::counters::COUNTING>
  26f509:	test   %al,%al
  26f50b:	je     26f515 <<glass::engine::Engine>::apply+0x9d5>
  26f50d:	lock add %rbx,0x3c37fb(%rip)        # 632d10 <glass::engine::counters::LANE_RUN_BYTES>
  26f515:	add    %rbx,0x8(%rsp)
  26f51a:	mov    $0x1,%al
  26f51c:	jmp    26ef15 <<glass::engine::Engine>::apply+0x3d5>
  26f521:	call   195736 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  26f526:	jmp    26f305 <<glass::engine::Engine>::apply+0x7c5>
  26f52b:	nopl   0x0(%rax,%rax,1)
  26f530:	mov    %rbp,%r13
  26f533:	mov    $0x1,%ebx
  26f538:	mov    0x20(%rsp),%rax
  26f53d:	sub    %rdx,%rax
  26f540:	jbe    26f5db <<glass::engine::Engine>::apply+0xa9b>
  26f546:	mov    0x8(%rsp),%rcx
  26f54b:	cmp    %rcx,0xf8(%rsp)
  26f553:	sete   %r9b
  26f557:	cmp    $0x2,%rax
  26f55b:	mov    0x40(%rsp),%r12
  26f560:	jb     26f5b0 <<glass::engine::Engine>::apply+0xa70>
  26f562:	mov    0x28(%rsp),%rcx
  26f567:	mov    0x18(%rsp),%rdx
  26f56c:	lea    (%rcx,%rdx,1),%rbp
  26f570:	cmpb   $0x5b,0x1(%rbp)
  26f574:	jne    26f5b0 <<glass::engine::Engine>::apply+0xa70>
  26f576:	xorps  %xmm0,%xmm0
  26f579:	movaps %xmm0,0x90(%rsp)
  26f581:	movaps %xmm0,0x80(%rsp)
  26f589:	cmp    $0x2,%rax
  26f58d:	je     26f5b0 <<glass::engine::Engine>::apply+0xa70>
  26f58f:	movzbl 0x2(%rbp),%ecx
  26f593:	lea    -0x30(%rcx),%eax
  26f596:	cmp    $0xa,%al
  26f598:	jae    26f601 <<glass::engine::Engine>::apply+0xac1>
  26f59a:	movzbl %al,%eax
  26f59d:	xor    %r14d,%r14d
  26f5a0:	mov    0x18(%rsp),%rcx
  26f5a5:	add    $0x3,%rcx
  26f5a9:	cmp    0x20(%rsp),%rcx
  26f5ae:	jne    26f627 <<glass::engine::Engine>::apply+0xae7>
  26f5b0:	movl   $0x0,0xb0(%rsp)
  26f5bb:	jmp    26f5e0 <<glass::engine::Engine>::apply+0xaa0>
  26f5bd:	nopl   (%rax)
  26f5c0:	mov    %rbp,%r13
  26f5c3:	mov    0x18(%rsp),%rdx
  26f5c8:	mov    $0x1,%ebx
  26f5cd:	mov    0x20(%rsp),%rax
  26f5d2:	sub    %rdx,%rax
  26f5d5:	ja     26f546 <<glass::engine::Engine>::apply+0xa06>
  26f5db:	mov    0x40(%rsp),%r12
  26f5e0:	mov    0x18(%rsp),%r8
  26f5e5:	add    %r8,%rbx
  26f5e8:	mov    %r13,%rbp
  26f5eb:	mov    %rbx,%r13
  26f5ee:	testb  $0x1,0xec(%rsp)
  26f5f6:	je     26eeb0 <<glass::engine::Engine>::apply+0x370>
  26f5fc:	jmp    26ee60 <<glass::engine::Engine>::apply+0x320>
  26f601:	movzbl %cl,%edx
  26f604:	xor    %eax,%eax
  26f606:	lea    -0x48(%rdx),%esi
  26f609:	cmp    $0x25,%esi
  26f60c:	ja     26f640 <<glass::engine::Engine>::apply+0xb00>
  26f60e:	mov    $0x3,%r8d
  26f614:	lea    -0x1fe443(%rip),%rdi        # 711d8 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d07>
  26f61b:	movslq (%rdi,%rsi,4),%rdx
  26f61f:	add    %rdi,%rdx
  26f622:	xor    %r14d,%r14d
  26f625:	jmp    *%rdx
  26f627:	mov    0x18(%rsp),%rcx
  26f62c:	mov    0x240(%rsp),%rdx
  26f634:	lea    (%rdx,%rcx,1),%rsi
  26f638:	mov    $0x4,%r8d
  26f63e:	jmp    26f683 <<glass::engine::Engine>::apply+0xb43>
  26f640:	mov    $0x1,%r14d
  26f646:	cmp    $0x3b,%edx
  26f649:	je     26f5a0 <<glass::engine::Engine>::apply+0xa60>
  26f64f:	jmp    26f5b0 <<glass::engine::Engine>::apply+0xa70>
  26f654:	mov    $0xffff,%cx
  26f658:	nopl   0x0(%rax,%rax,1)
  26f660:	movzbl %dil,%eax
  26f664:	add    %cx,%ax
  26f667:	mov    $0xffff,%ecx
  26f66c:	cmovb  %ecx,%eax
  26f66f:	lea    (%rsi,%r8,1),%rcx
  26f673:	inc    %rcx
  26f676:	inc    %r8
  26f679:	cmp    $0x4,%rcx
  26f67d:	je     26f5b0 <<glass::engine::Engine>::apply+0xa70>
  26f683:	movzbl -0x1(%rbp,%r8,1),%ecx
  26f689:	lea    -0x30(%rcx),%edi
  26f68c:	cmp    $0xa,%dil
  26f690:	jae    26f6a0 <<glass::engine::Engine>::apply+0xb60>
  26f692:	mov    $0xa,%cx
  26f696:	mul    %cx
  26f699:	jo     26f654 <<glass::engine::Engine>::apply+0xb14>
  26f69b:	mov    %eax,%ecx
  26f69d:	jmp    26f660 <<glass::engine::Engine>::apply+0xb20>
  26f69f:	nop
  26f6a0:	movzbl %cl,%edx
  26f6a3:	cmp    $0x3b,%edx
  26f6a6:	jne    26f6e3 <<glass::engine::Engine>::apply+0xba3>
  26f6a8:	lea    0x1(%r14),%rcx
  26f6ac:	cmp    $0x10,%rcx
  26f6b0:	jae    26f5b0 <<glass::engine::Engine>::apply+0xa70>
  26f6b6:	cmp    $0xf,%r14
  26f6ba:	ja     270f5b <<glass::engine::Engine>::apply+0x241b>
  26f6c0:	mov    %ax,0x80(%rsp,%r14,2)
  26f6c9:	xor    %eax,%eax
  26f6cb:	mov    %rcx,%r14
  26f6ce:	lea    (%rsi,%r8,1),%rcx
  26f6d2:	inc    %rcx
  26f6d5:	inc    %r8
  26f6d8:	cmp    $0x4,%rcx
  26f6dc:	jne    26f683 <<glass::engine::Engine>::apply+0xb43>
  26f6de:	jmp    26f5b0 <<glass::engine::Engine>::apply+0xa70>
  26f6e3:	add    $0xffffffb8,%edx
  26f6e6:	cmp    $0x25,%edx
  26f6e9:	ja     26f5b0 <<glass::engine::Engine>::apply+0xa70>
  26f6ef:	lea    -0x1fe486(%rip),%rsi        # 71270 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2d9f>
  26f6f6:	movslq (%rsi,%rdx,4),%rdx
  26f6fa:	add    %rsi,%rdx
  26f6fd:	jmp    *%rdx
  26f6ff:	cmp    $0x10,%r14
  26f703:	jae    270f83 <<glass::engine::Engine>::apply+0x2443>
  26f709:	mov    %r8,0x130(%rsp)
  26f711:	mov    %ax,0x80(%rsp,%r14,2)
  26f71a:	cmp    $0x6d,%cl
  26f71d:	setne  %cl
  26f720:	movaps 0x80(%rsp),%xmm0
  26f728:	movaps 0x90(%rsp),%xmm1
  26f730:	movaps %xmm0,0xc0(%rsp)
  26f738:	movaps %xmm1,0xd0(%rsp)
  26f740:	xor    %edx,%edx
  26f742:	jmp    26f783 <<glass::engine::Engine>::apply+0xc43>
  26f744:	cmp    $0x10,%r14
  26f748:	jae    270fa5 <<glass::engine::Engine>::apply+0x2465>
  26f74e:	mov    %r8,0x130(%rsp)
  26f756:	mov    %ax,0x80(%rsp,%r14,2)
  26f75f:	movaps 0x80(%rsp),%xmm0
  26f767:	movaps 0x90(%rsp),%xmm1
  26f76f:	movaps %xmm0,0xc0(%rsp)
  26f777:	movaps %xmm1,0xd0(%rsp)
  26f77f:	mov    $0x1,%dl
  26f781:	xor    %ecx,%ecx
  26f783:	lea    0x1(%r14),%rax
  26f787:	movaps 0xc0(%rsp),%xmm0
  26f78f:	movaps 0xd0(%rsp),%xmm1
  26f797:	movaps %xmm1,0x90(%rsp)
  26f79f:	movaps %xmm0,0x80(%rsp)
  26f7a7:	mov    %rax,0xa0(%rsp)
  26f7af:	mov    %cl,0xa8(%rsp)
  26f7b6:	mov    %dl,0xa9(%rsp)
  26f7bd:	mov    0x18(%rsp),%r8
  26f7c2:	cmp    %r13,%r8
  26f7c5:	jb     270f17 <<glass::engine::Engine>::apply+0x23d7>
  26f7cb:	mov    %r9b,0x30(%rsp)
  26f7d0:	mov    %edx,0x13c(%rsp)
  26f7d7:	mov    %ecx,0x138(%rsp)
  26f7de:	mov    0x28(%rsp),%rax
  26f7e3:	lea    (%rax,%r13,1),%r15
  26f7e7:	mov    0x3bc1da(%rip),%rax        # 62b9c8 <_DYNAMIC+0xae8>
  26f7ee:	mov    (%rax),%rax
  26f7f1:	mov    $0x1b,%edi
  26f7f6:	mov    %r15,%rsi
  26f7f9:	mov    %rbp,%rdx
  26f7fc:	call   *%rax
  26f7fe:	cmp    $0x1,%rax
  26f802:	jne    26f81f <<glass::engine::Engine>::apply+0xcdf>
  26f804:	sub    %r15,%rdx
  26f807:	movb   $0x1,0xa80(%r12)
  26f810:	movb   $0x0,0xa7e(%r12)
  26f819:	add    %rdx,%r13
  26f81c:	inc    %r13
  26f81f:	mov    0x18(%rsp),%r8
  26f824:	cmp    %r8,%r13
  26f827:	jae    26f879 <<glass::engine::Engine>::apply+0xd39>
  26f829:	mov    0x58(%rsp),%rdi
  26f82e:	mov    0x28(%rsp),%rsi
  26f833:	mov    0x20(%rsp),%rdx
  26f838:	mov    %r13,%rcx
  26f83b:	call   2872d0 <<glass::engine::Mirror>::stretch>
  26f840:	movzbl 0xa80(%r12),%ecx
  26f849:	test   %cl,%cl
  26f84b:	setne  %dl
  26f84e:	mov    0x18(%rsp),%r8
  26f853:	cmp    %r8,%rax
  26f856:	setae  %al
  26f859:	or     %dl,%al
  26f85b:	jne    26f882 <<glass::engine::Engine>::apply+0xd42>
  26f85d:	movzbl -0x1(%rbp),%eax
  26f861:	shr    $0x7,%al
  26f864:	mov    0x58(%rsp),%rcx
  26f869:	mov    %al,(%rcx)
  26f86b:	mov    0x28(%rsp),%r9
  26f870:	test   %al,%al
  26f872:	jne    26f89f <<glass::engine::Engine>::apply+0xd5f>
  26f874:	jmp    26f970 <<glass::engine::Engine>::apply+0xe30>
  26f879:	movzbl 0xa80(%r12),%ecx
  26f882:	test   %cl,%cl
  26f884:	mov    0x28(%rsp),%r9
  26f889:	jne    26fbbc <<glass::engine::Engine>::apply+0x107c>
  26f88f:	mov    0x58(%rsp),%rax
  26f894:	movzbl (%rax),%eax
  26f897:	test   %al,%al
  26f899:	je     26f970 <<glass::engine::Engine>::apply+0xe30>
  26f89f:	mov    0x18(%rsp),%r8
  26f8a4:	test   %r8,%r8
  26f8a7:	je     26fbbc <<glass::engine::Engine>::apply+0x107c>
  26f8ad:	cmpb   $0xc0,-0x1(%rbp)
  26f8b1:	jge    26f8f3 <<glass::engine::Engine>::apply+0xdb3>
  26f8b3:	cmp    $0x1,%r8
  26f8b7:	je     26fbbc <<glass::engine::Engine>::apply+0x107c>
  26f8bd:	cmpb   $0xbf,-0x2(%rbp)
  26f8c1:	jg     26fa0d <<glass::engine::Engine>::apply+0xecd>
  26f8c7:	cmp    $0x2,%r8
  26f8cb:	je     26fbbc <<glass::engine::Engine>::apply+0x107c>
  26f8d1:	cmpb   $0xbf,-0x3(%rbp)
  26f8d5:	jg     2700d7 <<glass::engine::Engine>::apply+0x1597>
  26f8db:	cmp    $0x3,%r8
  26f8df:	je     26fbbc <<glass::engine::Engine>::apply+0x107c>
  26f8e5:	cmpb   $0xc0,-0x4(%rbp)
  26f8e9:	setl   %al
  26f8ec:	mov    $0x3,%edx
  26f8f1:	jmp    26f8f7 <<glass::engine::Engine>::apply+0xdb7>
  26f8f3:	xor    %edx,%edx
  26f8f5:	xor    %eax,%eax
  26f8f7:	test   %al,%al
  26f8f9:	jne    26f966 <<glass::engine::Engine>::apply+0xe26>
  26f8fb:	mov    %rdx,%rsi
  26f8fe:	not    %rsi
  26f901:	add    0x18(%rsp),%rsi
  26f906:	jae    270fb8 <<glass::engine::Engine>::apply+0x2478>
  26f90c:	movzbl (%r9,%rsi,1),%eax
  26f911:	mov    $0x1,%ecx
  26f916:	test   %al,%al
  26f918:	jns    26f944 <<glass::engine::Engine>::apply+0xe04>
  26f91a:	lea    0x3e(%rax),%edi
  26f91d:	mov    $0x2,%ecx
  26f922:	cmp    $0x1e,%dil
  26f926:	jb     26f944 <<glass::engine::Engine>::apply+0xe04>
  26f928:	mov    %eax,%edi
  26f92a:	and    $0xf0,%dil
  26f92e:	mov    $0x3,%ecx
  26f933:	cmp    $0xe0,%dil
  26f937:	je     26f944 <<glass::engine::Engine>::apply+0xe04>
  26f939:	add    $0x10,%al
  26f93b:	mov    $0x4,%ecx
  26f940:	cmp    $0x4,%al
  26f942:	ja     26f966 <<glass::engine::Engine>::apply+0xe26>
  26f944:	inc    %rdx
  26f947:	cmp    %ecx,%edx
  26f949:	jne    26f966 <<glass::engine::Engine>::apply+0xe26>
  26f94b:	add    %r9,%rsi
  26f94e:	lea    0xc0(%rsp),%rdi
  26f956:	call   *0x3bb88c(%rip)        # 62b1e8 <_DYNAMIC+0x308>
  26f95c:	cmpb   $0x0,0xc0(%rsp)
  26f964:	je     26f970 <<glass::engine::Engine>::apply+0xe30>
  26f966:	mov    0x18(%rsp),%r8
  26f96b:	jmp    26fbbc <<glass::engine::Engine>::apply+0x107c>
  26f970:	mov    0x18(%rsp),%r8
  26f975:	mov    %r8,%rbp
  26f978:	sub    0x8(%rsp),%rbp
  26f97d:	jbe    26fbb1 <<glass::engine::Engine>::apply+0x1071>
  26f983:	mov    0x3c003f(%rip),%eax        # 62f9c8 <glass::engine::run_whole::ON>
  26f989:	test   %eax,%eax
  26f98b:	jne    2700e1 <<glass::engine::Engine>::apply+0x15a1>
  26f991:	mov    0xb0(%rsp),%ecx
  26f998:	and    0x30(%rsp),%cl
  26f99c:	movzbl 0x3c0029(%rip),%eax        # 62f9cc <glass::engine::run_whole::ON+0x4>
  26f9a3:	xor    $0x1,%rax
  26f9a7:	cmp    %rax,%rbp
  26f9aa:	seta   %al
  26f9ad:	and    %cl,%al
  26f9af:	cmp    $0x1,%al
  26f9b1:	jne    26fa03 <<glass::engine::Engine>::apply+0xec3>
  26f9b3:	mov    0x8(%rsp),%rcx
  26f9b8:	mov    %rcx,%rax
  26f9bb:	cmp    %rcx,0x18(%rsp)
  26f9c0:	mov    0x28(%rsp),%rdx
  26f9c5:	je     26f9e6 <<glass::engine::Engine>::apply+0xea6>
  26f9c7:	nopw   0x0(%rax,%rax,1)
  26f9d0:	movzbl (%rdx,%rax,1),%ecx
  26f9d4:	add    $0xe0,%cl
  26f9d7:	cmp    $0x5f,%cl
  26f9da:	jae    26f9f1 <<glass::engine::Engine>::apply+0xeb1>
  26f9dc:	inc    %rax
  26f9df:	cmp    %rax,0x18(%rsp)
  26f9e4:	jne    26f9d0 <<glass::engine::Engine>::apply+0xe90>
  26f9e6:	cmpl   $0xffffffff,0x710(%r12)
  26f9ef:	je     26fa17 <<glass::engine::Engine>::apply+0xed7>
  26f9f1:	mov    0x18(%rsp),%r8
  26f9f6:	mov    0xf8(%rsp),%r13
  26f9fe:	jmp    26fafd <<glass::engine::Engine>::apply+0xfbd>
  26fa03:	mov    0x8(%rsp),%r13
  26fa08:	jmp    26faf3 <<glass::engine::Engine>::apply+0xfb3>
  26fa0d:	mov    $0x1,%edx
  26fa12:	jmp    26f8f5 <<glass::engine::Engine>::apply+0xdb5>
  26fa17:	mov    0x3bffab(%rip),%eax        # 62f9c8 <glass::engine::run_whole::ON>
  26fa1d:	test   %eax,%eax
  26fa1f:	jne    2700eb <<glass::engine::Engine>::apply+0x15ab>
  26fa25:	mov    0x8(%rsp),%rax
  26fa2a:	add    0x28(%rsp),%rax
  26fa2f:	mov    %rax,0x8(%rsp)
  26fa34:	movzbl 0x3bff91(%rip),%eax        # 62f9cc <glass::engine::run_whole::ON+0x4>
  26fa3b:	xor    $0x1,%rax
  26fa3f:	sub    %rax,%rbp
  26fa42:	cmp    $0x1,%rbp
  26fa46:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa48:	cmpb   $0x1,0x1fe(%rsp)
  26fa50:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa52:	cmpq   $0x0,0x178(%rsp)
  26fa5b:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa5d:	mov    0x1b8(%rsp),%r13
  26fa65:	testb  $0x4,0x6c5(%r13)
  26fa6d:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa6f:	cmpw   $0x0,0x66(%r13)
  26fa75:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa77:	cmpq   $0x0,0x50(%r13)
  26fa7c:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa7e:	movzwl 0x64(%r13),%eax
  26fa83:	test   $0x460,%eax
  26fa88:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa8a:	cmpb   $0x0,0x68(%r13)
  26fa8f:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa91:	cmpb   $0x0,0x69(%r13)
  26fa96:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa98:	cmpb   $0x0,0x6a(%r13)
  26fa9d:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  26fa9f:	cmpb   $0x0,0x6b(%r13)
  26faa4:	je     2700f5 <<glass::engine::Engine>::apply+0x15b5>
  26faaa:	lea    0x140(%rsp),%rdi
  26fab2:	mov    0x8(%rsp),%rsi
  26fab7:	mov    %rbp,%rdx
  26faba:	call   27c0c0 <<glass::engine::Watch>::print_run>
  26fabf:	mov    %rax,%r15
  26fac2:	mov    0x3bff00(%rip),%eax        # 62f9c8 <glass::engine::run_whole::ON>
  26fac8:	test   %eax,%eax
  26faca:	jne    2708e3 <<glass::engine::Engine>::apply+0x1da3>
  26fad0:	cmpb   $0x0,0x3bfef5(%rip)        # 62f9cc <glass::engine::run_whole::ON+0x4>
  26fad7:	je     26fae8 <<glass::engine::Engine>::apply+0xfa8>
  26fad9:	mov    0x1f0(%rsp),%eax
  26fae0:	mov    %eax,0x718(%r12)
  26fae8:	mov    0xf8(%rsp),%r13
  26faf0:	add    %r15,%r13
  26faf3:	mov    0x28(%rsp),%rdx
  26faf8:	mov    0x18(%rsp),%r8
  26fafd:	cmp    %r13,%r8
  26fb00:	jb     270f2d <<glass::engine::Engine>::apply+0x23ed>
  26fb06:	mov    %r8,%r15
  26fb09:	mov    %r8,0x8(%rsp)
  26fb0e:	sub    %r13,%r15
  26fb11:	je     26fbb1 <<glass::engine::Engine>::apply+0x1071>
  26fb17:	add    %rdx,%r13
  26fb1a:	xor    %ebp,%ebp
  26fb1c:	nopl   0x0(%rax)
  26fb20:	cmpl   $0xffffffff,0x710(%r12)
  26fb29:	jne    26fb86 <<glass::engine::Engine>::apply+0x1046>
  26fb2b:	mov    0x78(%rsp),%rax
  26fb30:	mov    %rax,0xc0(%rsp)
  26fb38:	lea    0x140(%rsp),%rax
  26fb40:	mov    %rax,0xc8(%rsp)
  26fb48:	movb   $0x0,0xd0(%rsp)
  26fb50:	mov    %r15,%rcx
  26fb53:	sub    %rbp,%rcx
  26fb56:	jb     270e8a <<glass::engine::Engine>::apply+0x234a>
  26fb5c:	mov    %r13,%rdx
  26fb5f:	add    %rbp,%rdx
  26fb62:	mov    0x100(%rsp),%rdi
  26fb6a:	lea    0xc0(%rsp),%rsi
  26fb72:	call   1aad70 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  26fb77:	add    %rax,%rbp
  26fb7a:	cmp    %r15,%rbp
  26fb7d:	mov    0x18(%rsp),%r8
  26fb82:	jne    26fb20 <<glass::engine::Engine>::apply+0xfe0>
  26fb84:	jmp    26fbac <<glass::engine::Engine>::apply+0x106c>
  26fb86:	mov    %r15,%rcx
  26fb89:	sub    %rbp,%rcx
  26fb8c:	jb     270f96 <<glass::engine::Engine>::apply+0x2456>
  26fb92:	mov    %r13,%rdx
  26fb95:	add    %rbp,%rdx
  26fb98:	mov    0x78(%rsp),%rdi
  26fb9d:	lea    0x140(%rsp),%rsi
  26fba5:	call   19e580 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  26fbaa:	jmp    26fb77 <<glass::engine::Engine>::apply+0x1037>
  26fbac:	mov    %r8,0x8(%rsp)
  26fbb1:	cmpl   $0xffffffff,0x710(%r12)
  26fbba:	je     26fbcf <<glass::engine::Engine>::apply+0x108f>
  26fbbc:	movl   $0x0,0xb0(%rsp)
  26fbc7:	mov    %r8,%r13
  26fbca:	jmp    26f5e5 <<glass::engine::Engine>::apply+0xaa5>
  26fbcf:	cmpb   $0x0,0x13c(%rsp)
  26fbd7:	je     26fc19 <<glass::engine::Engine>::apply+0x10d9>
  26fbd9:	mov    0x1f0(%rsp),%ebx
  26fbe0:	cmp    $0xffffffff,%ebx
  26fbe3:	je     270045 <<glass::engine::Engine>::apply+0x1505>
  26fbe9:	mov    0x80(%rsp),%ebp
  26fbf0:	cmp    $0x1,%bp
  26fbf4:	adc    $0x0,%ebp
  26fbf7:	nopw   0x0(%rax,%rax,1)
  26fc00:	lea    0x140(%rsp),%rdi
  26fc08:	mov    %ebx,%esi
  26fc0a:	call   359b50 <<glass::engine::Watch as vte::ansi::Handler>::input>
  26fc0f:	dec    %bp
  26fc12:	jne    26fc00 <<glass::engine::Engine>::apply+0x10c0>
  26fc14:	jmp    270092 <<glass::engine::Engine>::apply+0x1552>
  26fc19:	cmpb   $0x0,0x138(%rsp)
  26fc21:	je     26fc51 <<glass::engine::Engine>::apply+0x1111>
  26fc23:	movzwl 0x80(%rsp),%eax
  26fc2b:	lea    -0x1(%rax),%esi
  26fc2e:	test   %eax,%eax
  26fc30:	cmove  %eax,%esi
  26fc33:	test   %r14,%r14
  26fc36:	je     270072 <<glass::engine::Engine>::apply+0x1532>
  26fc3c:	movzwl 0x82(%rsp),%ecx
  26fc44:	xor    %eax,%eax
  26fc46:	test   %cx,%cx
  26fc49:	setne  %al
  26fc4c:	jmp    270074 <<glass::engine::Engine>::apply+0x1534>
  26fc51:	mov    0x1b8(%rsp),%r13
  26fc59:	xor    %eax,%eax
  26fc5b:	jmp    26fc8e <<glass::engine::Engine>::apply+0x114e>
  26fc5d:	mov    $0x17,%cx
  26fc61:	mov    $0x1010000,%esi
  26fc66:	cs nopw 0x0(%rax,%rax,1)
  26fc70:	movzwl %cx,%eax
  26fc73:	shl    $0x10,%rsi
  26fc77:	or     %rax,%rsi
  26fc7a:	mov    %r13,%rdi
  26fc7d:	call   367cf0 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>
  26fc82:	mov    %rbx,%rax
  26fc85:	cmp    %r14,%rbx
  26fc88:	ja     270092 <<glass::engine::Engine>::apply+0x1552>
  26fc8e:	movzwl 0x80(%rsp,%rax,2),%ecx
  26fc96:	lea    0x1(%rax),%rbx
  26fc9a:	cmp    $0x3b,%rcx
  26fc9e:	ja     26ff1f <<glass::engine::Engine>::apply+0x13df>
  26fca4:	lea    -0x1fe9a3(%rip),%rsi        # 71308 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x2e37>
  26fcab:	movslq (%rsi,%rcx,4),%rdx
  26fcaf:	add    %rsi,%rdx
  26fcb2:	jmp    *%rdx
  26fcb4:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fcb6:	cmp    %r14,%rax
  26fcb9:	jae    26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fcbb:	movzwl 0x82(%rsp,%rax,2),%ecx
  26fcc3:	lea    0x2(%rax),%rbx
  26fcc7:	cmp    $0x5,%ecx
  26fcca:	je     26ff83 <<glass::engine::Engine>::apply+0x1443>
  26fcd0:	cmp    $0x2,%ecx
  26fcd3:	jne    26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fcd5:	cmp    %r14,%rbx
  26fcd8:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fcda:	movzwl 0x84(%rsp,%rax,2),%ecx
  26fce2:	lea    0x3(%rax),%rbx
  26fce6:	cmp    $0xff,%ecx
  26fcec:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fcee:	cmp    %r14,%rbx
  26fcf1:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fcf3:	movzwl 0x86(%rsp,%rax,2),%edx
  26fcfb:	lea    0x4(%rax),%rbx
  26fcff:	cmp    $0xff,%edx
  26fd05:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fd0b:	cmp    %r14,%rbx
  26fd0e:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fd14:	movzwl 0x88(%rsp,%rax,2),%edi
  26fd1c:	add    $0x5,%rax
  26fd20:	cmp    $0xff,%edi
  26fd26:	ja     270006 <<glass::engine::Engine>::apply+0x14c6>
  26fd2c:	shl    $0x10,%edi
  26fd2f:	movzwl %dx,%edx
  26fd32:	shl    $0x8,%edx
  26fd35:	or     %edx,%ecx
  26fd37:	movzwl %cx,%esi
  26fd3a:	or     %edi,%esi
  26fd3c:	mov    $0x1,%ecx
  26fd41:	jmp    26ffa5 <<glass::engine::Engine>::apply+0x1465>
  26fd46:	mov    $0x11,%cx
  26fd4a:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fd4f:	mov    $0xc,%cx
  26fd53:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fd58:	mov    $0xa,%cx
  26fd5c:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fd61:	mov    $0x18,%cx
  26fd65:	mov    $0xff,%esi
  26fd6a:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fd6f:	mov    $0xe,%cx
  26fd73:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fd78:	cmp    %r14,%rax
  26fd7b:	jae    26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fd81:	movzwl 0x82(%rsp,%rax,2),%ecx
  26fd89:	lea    0x2(%rax),%rbx
  26fd8d:	cmp    $0x5,%ecx
  26fd90:	je     26ffb6 <<glass::engine::Engine>::apply+0x1476>
  26fd96:	cmp    $0x2,%ecx
  26fd99:	jne    26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fd9f:	cmp    %r14,%rbx
  26fda2:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fda8:	movzwl 0x84(%rsp,%rax,2),%ecx
  26fdb0:	lea    0x3(%rax),%rbx
  26fdb4:	cmp    $0xff,%ecx
  26fdba:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fdc0:	cmp    %r14,%rbx
  26fdc3:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fdc9:	movzwl 0x86(%rsp,%rax,2),%edx
  26fdd1:	lea    0x4(%rax),%rbx
  26fdd5:	cmp    $0xff,%edx
  26fddb:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fde1:	cmp    %r14,%rbx
  26fde4:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fdea:	movzwl 0x88(%rsp,%rax,2),%edi
  26fdf2:	add    $0x5,%rax
  26fdf6:	cmp    $0xff,%edi
  26fdfc:	ja     270006 <<glass::engine::Engine>::apply+0x14c6>
  26fe02:	shl    $0x10,%edi
  26fe05:	movzwl %dx,%edx
  26fe08:	shl    $0x8,%edx
  26fe0b:	or     %edx,%ecx
  26fe0d:	movzwl %cx,%esi
  26fe10:	or     %edi,%esi
  26fe12:	mov    $0x1,%ecx
  26fe17:	jmp    26ffd8 <<glass::engine::Engine>::apply+0x1498>
  26fe1c:	mov    $0x10,%cx
  26fe20:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe25:	mov    $0x16,%cx
  26fe29:	mov    $0x1000000,%esi
  26fe2e:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe33:	mov    $0xf,%cx
  26fe37:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe3c:	mov    $0x9,%cx
  26fe40:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe45:	mov    $0x12,%cx
  26fe49:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe4e:	mov    $0x13,%cx
  26fe52:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe57:	mov    $0xb,%cx
  26fe5b:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe60:	mov    $0xd,%cx
  26fe64:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe69:	mov    $0x15,%cx
  26fe6d:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe72:	mov    $0x14,%cx
  26fe76:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26fe7b:	cmp    %r14,%rax
  26fe7e:	jae    26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fe84:	movzwl 0x82(%rsp,%rax,2),%ecx
  26fe8c:	lea    0x2(%rax),%rbx
  26fe90:	cmp    $0x5,%ecx
  26fe93:	je     26ffe9 <<glass::engine::Engine>::apply+0x14a9>
  26fe99:	cmp    $0x2,%ecx
  26fe9c:	jne    26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fea2:	cmp    %r14,%rbx
  26fea5:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26feab:	movzwl 0x84(%rsp,%rax,2),%ecx
  26feb3:	lea    0x3(%rax),%rbx
  26feb7:	cmp    $0xff,%ecx
  26febd:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fec3:	cmp    %r14,%rbx
  26fec6:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fecc:	movzwl 0x86(%rsp,%rax,2),%edx
  26fed4:	lea    0x4(%rax),%rbx
  26fed8:	cmp    $0xff,%edx
  26fede:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fee4:	cmp    %r14,%rbx
  26fee7:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26feed:	movzwl 0x88(%rsp,%rax,2),%edi
  26fef5:	add    $0x5,%rax
  26fef9:	cmp    $0xff,%edi
  26feff:	ja     270006 <<glass::engine::Engine>::apply+0x14c6>
  26ff05:	shl    $0x10,%edi
  26ff08:	movzwl %dx,%edx
  26ff0b:	shl    $0x8,%edx
  26ff0e:	or     %edx,%ecx
  26ff10:	movzwl %cx,%esi
  26ff13:	or     %edi,%esi
  26ff15:	mov    $0x1,%ecx
  26ff1a:	jmp    270034 <<glass::engine::Engine>::apply+0x14f4>
  26ff1f:	lea    -0x1e(%rcx),%eax
  26ff22:	cmp    $0x8,%ax
  26ff26:	jae    26ff40 <<glass::engine::Engine>::apply+0x1400>
  26ff28:	lea    -0x21285f(%rip),%rax        # 5d6d0 <anon.08859497c3491987c23c942ee25a4872.98.llvm.1954435886486793411+0xa90>
  26ff2f:	movzwl -0x3c(%rax,%rcx,2),%esi
  26ff34:	shl    $0x10,%esi
  26ff37:	mov    $0x16,%cx
  26ff3b:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26ff40:	mov    %ecx,%eax
  26ff42:	and    $0xfff8,%eax
  26ff47:	cmp    $0x28,%ax
  26ff4b:	jne    26ff65 <<glass::engine::Engine>::apply+0x1425>
  26ff4d:	lea    -0x212884(%rip),%rax        # 5d6d0 <anon.08859497c3491987c23c942ee25a4872.98.llvm.1954435886486793411+0xa90>
  26ff54:	movzwl -0x50(%rax,%rcx,2),%esi
  26ff59:	shl    $0x10,%esi
  26ff5c:	mov    $0x17,%cx
  26ff60:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26ff65:	lea    -0x5a(%rcx),%eax
  26ff68:	cmp    $0x8,%ax
  26ff6c:	jae    27000e <<glass::engine::Engine>::apply+0x14ce>
  26ff72:	lea    -0x2109e9(%rip),%rax        # 5f590 <anon.08859497c3491987c23c942ee25a4872.71.llvm.1954435886486793411+0x110>
  26ff79:	movzwl -0xb4(%rax,%rcx,2),%esi
  26ff81:	jmp    26ff34 <<glass::engine::Engine>::apply+0x13f4>
  26ff83:	cmp    %r14,%rbx
  26ff86:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26ff8c:	movzwl 0x84(%rsp,%rax,2),%esi
  26ff94:	add    $0x3,%rax
  26ff98:	cmp    $0xff,%esi
  26ff9e:	ja     270006 <<glass::engine::Engine>::apply+0x14c6>
  26ffa0:	mov    $0x2,%ecx
  26ffa5:	shl    $0x8,%esi
  26ffa8:	or     %ecx,%esi
  26ffaa:	mov    $0x16,%cx
  26ffae:	mov    %rax,%rbx
  26ffb1:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26ffb6:	cmp    %r14,%rbx
  26ffb9:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26ffbf:	movzwl 0x84(%rsp,%rax,2),%esi
  26ffc7:	add    $0x3,%rax
  26ffcb:	cmp    $0xff,%esi
  26ffd1:	ja     270006 <<glass::engine::Engine>::apply+0x14c6>
  26ffd3:	mov    $0x2,%ecx
  26ffd8:	shl    $0x8,%esi
  26ffdb:	or     %ecx,%esi
  26ffdd:	mov    $0x18,%cx
  26ffe1:	mov    %rax,%rbx
  26ffe4:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  26ffe9:	cmp    %r14,%rbx
  26ffec:	ja     26fc82 <<glass::engine::Engine>::apply+0x1142>
  26fff2:	movzwl 0x84(%rsp,%rax,2),%esi
  26fffa:	add    $0x3,%rax
  26fffe:	cmp    $0xff,%esi
  270004:	jbe    27002f <<glass::engine::Engine>::apply+0x14ef>
  270006:	mov    %rax,%rbx
  270009:	jmp    26fc82 <<glass::engine::Engine>::apply+0x1142>
  27000e:	lea    -0x64(%rcx),%eax
  270011:	cmp    $0x8,%ax
  270015:	jae    26fc82 <<glass::engine::Engine>::apply+0x1142>
  27001b:	lea    -0x210a92(%rip),%rax        # 5f590 <anon.08859497c3491987c23c942ee25a4872.71.llvm.1954435886486793411+0x110>
  270022:	movzwl -0xc8(%rax,%rcx,2),%esi
  27002a:	jmp    26ff59 <<glass::engine::Engine>::apply+0x1419>
  27002f:	mov    $0x2,%ecx
  270034:	shl    $0x8,%esi
  270037:	or     %ecx,%esi
  270039:	mov    $0x17,%cx
  27003d:	mov    %rax,%rbx
  270040:	jmp    26fc70 <<glass::engine::Engine>::apply+0x1130>
  270045:	mov    $0x1,%al
  270047:	mov    %eax,0xb0(%rsp)
  27004e:	mov    %r8,%r13
  270051:	mov    0x8(%rsp),%rax
  270056:	mov    %rax,0xf8(%rsp)
  27005e:	mov    $0x1,%al
  270060:	mov    %rax,0x50(%rsp)
  270065:	mov    0x130(%rsp),%rbx
  27006d:	jmp    26f5e5 <<glass::engine::Engine>::apply+0xaa5>
  270072:	xor    %eax,%eax
  270074:	movzwl %cx,%edx
  270077:	dec    %rdx
  27007a:	test   $0x1,%al
  27007c:	mov    $0x0,%eax
  270081:	cmove  %rax,%rdx
  270085:	mov    0x1b8(%rsp),%rdi
  27008d:	call   369160 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::goto>
  270092:	mov    0x18(%rsp),%r8
  270097:	mov    0x130(%rsp),%rbx
  27009f:	lea    (%rbx,%r8,1),%r13
  2700a3:	movb   $0x0,0xa80(%r12)
  2700ac:	movb   $0x0,0xa7e(%r12)
  2700b5:	mov    $0x1,%al
  2700b7:	mov    %eax,0xb0(%rsp)
  2700be:	mov    %r13,0x8(%rsp)
  2700c3:	mov    %r13,0xf8(%rsp)
  2700cb:	mov    $0x1,%al
  2700cd:	mov    %rax,0x50(%rsp)
  2700d2:	jmp    26f5e5 <<glass::engine::Engine>::apply+0xaa5>
  2700d7:	mov    $0x2,%edx
  2700dc:	jmp    26f8f5 <<glass::engine::Engine>::apply+0xdb5>
  2700e1:	call   195736 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2700e6:	jmp    26f991 <<glass::engine::Engine>::apply+0xe51>
  2700eb:	call   195736 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2700f0:	jmp    26fa25 <<glass::engine::Engine>::apply+0xee5>
  2700f5:	mov    0x8(%rsp),%rax
  2700fa:	movzbl (%rax),%eax
  2700fd:	mov    %rax,0xb0(%rsp)
  270105:	add    $0xffffffe0,%eax
  270108:	mov    $0x1,%r15d
  27010e:	cmp    $0x5f,%al
  270110:	jb     27013d <<glass::engine::Engine>::apply+0x15fd>
  270112:	mov    0xb0(%rsp),%rdi
  27011a:	call   2bef20 <glass::engine::width_of>
  27011f:	mov    0x40(%rsp),%r12
  270124:	mov    %rdx,%r15
  270127:	lea    -0x1(%rdx),%rcx
  27012b:	cmp    $0x2,%rcx
  27012f:	setb   %cl
  270132:	and    %al,%cl
  270134:	cmp    $0x1,%cl
  270137:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  27013d:	cmpb   $0x0,0x6c(%r13)
  270142:	mov    0x40(%rsp),%r12
  270147:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  27014d:	mov    0x40(%r13),%rdx
  270151:	mov    0xa0(%r13),%rcx
  270158:	mov    %rdx,0x30(%rsp)
  27015d:	lea    (%rdx,%r15,1),%rax
  270161:	mov    %rax,0x128(%rsp)
  270169:	mov    %rcx,0x230(%rsp)
  270171:	cmp    %rcx,%rax
  270174:	ja     26faaa <<glass::engine::Engine>::apply+0xf6a>
  27017a:	lea    0x10(%r13),%rdi
  27017e:	mov    0x48(%r13),%esi
  270182:	mov    0x58(%r13),%eax
  270186:	mov    %eax,0x10c(%rsp)
  27018d:	mov    0x5c(%r13),%eax
  270191:	mov    %eax,0x108(%rsp)
  270198:	movzwl 0x64(%r13),%eax
  27019d:	mov    %eax,0x110(%rsp)
  2701a4:	lea    0x391925(%rip),%rdx        # 601ad0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x162f0>
  2701ab:	call   3269c0 <<alacritty_terminal::grid::storage::Storage<alacritty_terminal::term::cell::Cell> as core::ops::index::IndexMut<alacritty_terminal::index::Line>>::index_mut>
  2701b0:	mov    %rax,%rcx
  2701b3:	add    $0x18,%rcx
  2701b7:	mov    %rcx,0x118(%rsp)
  2701bf:	mov    %rax,0x10(%rsp)
  2701c4:	mov    0x28(%rax),%eax
  2701c7:	cmp    $0xffffffff,%eax
  2701ca:	je     2701e4 <<glass::engine::Engine>::apply+0x16a4>
  2701cc:	mov    0x118(%rsp),%rcx
  2701d4:	mov    0x30(%rsp),%rdx
  2701d9:	mov    0x10(%rsp),%rsi
  2701de:	cmp    0x30(%rsi),%rdx
  2701e2:	jae    27020e <<glass::engine::Engine>::apply+0x16ce>
  2701e4:	mov    0x10(%rsp),%rcx
  2701e9:	mov    0x10(%rcx),%rcx
  2701ed:	cmp    %rcx,0x30(%rsp)
  2701f2:	jae    270fd1 <<glass::engine::Engine>::apply+0x2491>
  2701f8:	mov    0x30(%rsp),%rcx
  2701fd:	lea    (%rcx,%rcx,2),%rcx
  270201:	shl    $0x3,%rcx
  270205:	mov    0x10(%rsp),%rdx
  27020a:	add    0x8(%rdx),%rcx
  27020e:	testb  $0x60,0x14(%rcx)
  270212:	mov    0x40(%rsp),%r12
  270217:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  27021d:	cmp    $0x2,%r15
  270221:	jne    270275 <<glass::engine::Engine>::apply+0x1735>
  270223:	mov    0x30(%rsp),%rcx
  270228:	inc    %rcx
  27022b:	cmp    $0xffffffff,%eax
  27022e:	je     270243 <<glass::engine::Engine>::apply+0x1703>
  270230:	mov    0x118(%rsp),%rdx
  270238:	mov    0x10(%rsp),%rsi
  27023d:	cmp    0x30(%rsi),%rcx
  270241:	jae    270266 <<glass::engine::Engine>::apply+0x1726>
  270243:	mov    0x10(%rsp),%rdx
  270248:	mov    0x10(%rdx),%rdx
  27024c:	cmp    %rdx,%rcx
  27024f:	jae    270fe7 <<glass::engine::Engine>::apply+0x24a7>
  270255:	lea    (%rcx,%rcx,2),%rdx
  270259:	shl    $0x3,%rdx
  27025d:	mov    0x10(%rsp),%rcx
  270262:	add    0x8(%rcx),%rdx
  270266:	testb  $0x60,0x14(%rdx)
  27026a:	mov    0x40(%rsp),%r12
  27026f:	jne    26faaa <<glass::engine::Engine>::apply+0xf6a>
  270275:	mov    0x30(%rsp),%rcx
  27027a:	mov    0x10(%rsp),%rdx
  27027f:	cmp    %ecx,0x38(%rdx)
  270282:	jbe    270291 <<glass::engine::Engine>::apply+0x1751>
  270284:	mov    0x30(%rsp),%rcx
  270289:	mov    0x10(%rsp),%rdx
  27028e:	mov    %ecx,0x38(%rdx)
  270291:	cmp    $0xffffffff,%eax
  270294:	setne  %cl
  270297:	mov    0x10(%rsp),%rdx
  27029c:	mov    0x30(%rdx),%r12
  2702a0:	cmp    %r12,0x30(%rsp)
  2702a5:	sete   %dl
  2702a8:	test   %dl,%cl
  2702aa:	jne    27046d <<glass::engine::Engine>::apply+0x192d>
  2702b0:	cmp    $0xffffffff,%eax
  2702b3:	je     2704f7 <<glass::engine::Engine>::apply+0x19b7>
  2702b9:	mov    0x10(%rsp),%rax
  2702be:	mov    0x10(%rax),%rbp
  2702c2:	cmp    %r12,%rbp
  2702c5:	mov    %r12,%rax
  2702c8:	cmovb  %rbp,%rax
  2702cc:	mov    %rax,0x60(%rsp)
  2702d1:	mov    0x30(%rsp),%rax
  2702d6:	cmp    %rax,%rbp
  2702d9:	cmovb  %rbp,%rax
  2702dd:	mov    %rax,0x48(%rsp)
  2702e2:	mov    0x3baf2f(%rip),%rax        # 62b218 <_DYNAMIC+0x338>
  2702e9:	movzbl (%rax),%eax
  2702ec:	test   %al,%al
  2702ee:	je     270319 <<glass::engine::Engine>::apply+0x17d9>
  2702f0:	mov    0x3baf59(%rip),%rax        # 62b250 <_DYNAMIC+0x370>
  2702f7:	cmp    0x48(%rsp),%r12
  2702fc:	jae    270305 <<glass::engine::Engine>::apply+0x17c5>
  2702fe:	mov    0x3baf53(%rip),%rax        # 62b258 <_DYNAMIC+0x378>
  270305:	lock incq 0x28(%rax)
  27030a:	mov    0x48(%rsp),%rdi
  27030f:	sub    0x60(%rsp),%rdi
  270314:	call   313ab0 <alacritty_terminal::grid::row::fill_census::note>
  270319:	cmp    0x48(%rsp),%r12
  27031e:	jae    2704d7 <<glass::engine::Engine>::apply+0x1997>
  270324:	mov    0x10(%rsp),%rax
  270329:	mov    0x28(%rax),%ecx
  27032c:	mov    %ecx,0x74(%rsp)
  270330:	mov    0x20(%rax),%ecx
  270333:	mov    %ecx,0x70(%rsp)
  270337:	mov    0x24(%rax),%ecx
  27033a:	mov    %ecx,0x6c(%rsp)
  27033e:	movzwl 0x2c(%rax),%ecx
  270342:	mov    %cx,0x3e(%rsp)
  270347:	mov    0x18(%rax),%rax
  27034b:	mov    %rax,0x8(%rsp)
  270350:	test   %rax,%rax
  270353:	je     27036d <<glass::engine::Engine>::apply+0x182d>
  270355:	mov    0x8(%rsp),%rax
  27035a:	lock incq (%rax)
  27035e:	jle    271058 <<glass::engine::Engine>::apply+0x2518>
  270364:	mov    0x10(%rsp),%rax
  270369:	mov    0x10(%rax),%rbp
  27036d:	mov    0x10(%rsp),%rax
  270372:	movzwl 0x2e(%rax),%ecx
  270376:	mov    0x74(%rsp),%eax
  27037a:	mov    %eax,0xd0(%rsp)
  270381:	mov    0x70(%rsp),%eax
  270385:	mov    %eax,0xc8(%rsp)
  27038c:	mov    0x6c(%rsp),%eax
  270390:	mov    %eax,0xcc(%rsp)
  270397:	movzwl 0x3e(%rsp),%eax
  27039c:	mov    %ax,0xd4(%rsp)
  2703a4:	mov    0x8(%rsp),%rax
  2703a9:	mov    %rax,0xc0(%rsp)
  2703b1:	mov    %cx,0xb8(%rsp)
  2703b9:	mov    %cx,0xd6(%rsp)
  2703c1:	cmp    %rbp,0x48(%rsp)
  2703c6:	ja     270ffb <<glass::engine::Engine>::apply+0x24bb>
  2703cc:	mov    0x60(%rsp),%rax
  2703d1:	lea    0x0(,%rax,8),%rax
  2703d9:	lea    (%rax,%rax,2),%rax
  2703dd:	mov    0x10(%rsp),%rcx
  2703e2:	mov    0x8(%rcx),%rbp
  2703e6:	add    %rax,%rbp
  2703e9:	mov    0x48(%rsp),%rcx
  2703ee:	lea    0x0(,%rcx,8),%rcx
  2703f6:	lea    (%rcx,%rcx,2),%r12
  2703fa:	sub    %rax,%r12
  2703fd:	jmp    27043c <<glass::engine::Engine>::apply+0x18fc>
  2703ff:	mov    0x8(%rsp),%rax
  270404:	mov    %rax,0x0(%rbp)
  270408:	mov    0x70(%rsp),%eax
  27040c:	mov    %eax,0x8(%rbp)
  27040f:	mov    0x6c(%rsp),%eax
  270413:	mov    %eax,0xc(%rbp)
  270416:	mov    0x74(%rsp),%eax
  27041a:	mov    %eax,0x10(%rbp)
  27041d:	movzwl 0x3e(%rsp),%eax
  270422:	mov    %ax,0x14(%rbp)
  270426:	movzwl 0xb8(%rsp),%eax
  27042e:	mov    %ax,0x16(%rbp)
  270432:	add    $0x18,%rbp
  270436:	add    $0xffffffffffffffe8,%r12
  27043a:	je     270491 <<glass::engine::Engine>::apply+0x1951>
  27043c:	cmpq   $0x0,0x8(%rsp)
  270442:	je     270453 <<glass::engine::Engine>::apply+0x1913>
  270444:	mov    0x8(%rsp),%rax
  270449:	lock incq (%rax)
  27044d:	jle    271058 <<glass::engine::Engine>::apply+0x2518>
  270453:	mov    0x0(%rbp),%rax
  270457:	test   %rax,%rax
  27045a:	je     2703ff <<glass::engine::Engine>::apply+0x18bf>
  27045c:	lock decq (%rax)
  270460:	jne    2703ff <<glass::engine::Engine>::apply+0x18bf>
  270462:	mov    %rbp,%rdi
  270465:	call   *0x3bace5(%rip)        # 62b150 <_DYNAMIC+0x270>
  27046b:	jmp    2703ff <<glass::engine::Engine>::apply+0x18bf>
  27046d:	mov    0x30(%rsp),%rcx
  270472:	lea    0x1(%rcx),%rax
  270476:	mov    0x10(%rsp),%rdx
  27047b:	mov    %rax,0x30(%rdx)
  27047f:	mov    0x10(%rdx),%rax
  270483:	cmp    %rax,%rcx
  270486:	jb     270521 <<glass::engine::Engine>::apply+0x19e1>
  27048c:	jmp    271017 <<glass::engine::Engine>::apply+0x24d7>
  270491:	mov    0x10(%rsp),%rax
  270496:	mov    0x60(%rsp),%rcx
  27049b:	cmp    %ecx,0x38(%rax)
  27049e:	jbe    2704ad <<glass::engine::Engine>::apply+0x196d>
  2704a0:	mov    0x10(%rsp),%rax
  2704a5:	mov    0x60(%rsp),%rcx
  2704aa:	mov    %ecx,0x38(%rax)
  2704ad:	cmpq   $0x0,0x8(%rsp)
  2704b3:	je     2704ce <<glass::engine::Engine>::apply+0x198e>
  2704b5:	mov    0x8(%rsp),%rax
  2704ba:	lock decq (%rax)
  2704be:	jne    2704ce <<glass::engine::Engine>::apply+0x198e>
  2704c0:	lea    0xc0(%rsp),%rdi
  2704c8:	call   *0x3bac82(%rip)        # 62b150 <_DYNAMIC+0x270>
  2704ce:	mov    0x10(%rsp),%rax
  2704d3:	mov    0x10(%rax),%rbp
  2704d7:	cmp    %rbp,0x48(%rsp)
  2704dc:	jb     2704f7 <<glass::engine::Engine>::apply+0x19b7>
  2704de:	mov    0x118(%rsp),%rdi
  2704e6:	call   1b98b0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2704eb:	mov    0x10(%rsp),%rax
  2704f0:	movl   $0xffffffff,0x28(%rax)
  2704f7:	mov    0x10(%rsp),%rsi
  2704fc:	mov    0x30(%rsi),%rcx
  270500:	mov    0x30(%rsp),%rdx
  270505:	lea    0x1(%rdx),%rax
  270509:	cmp    %rcx,%rax
  27050c:	cmova  %rax,%rcx
  270510:	mov    0x10(%rsi),%rax
  270514:	mov    %rcx,0x30(%rsi)
  270518:	cmp    %rax,%rdx
  27051b:	jae    27101e <<glass::engine::Engine>::apply+0x24de>
  270521:	mov    0x110(%rsp),%edi
  270528:	mov    %edi,%eax
  27052a:	or     $0x20,%eax
  27052d:	cmp    $0x2,%r15
  270531:	mov    0x10(%rsp),%rcx
  270536:	mov    0x8(%rcx),%rcx
  27053a:	mov    0x30(%rsp),%rdx
  27053f:	lea    (%rdx,%rdx,2),%rdx
  270543:	lea    (%rcx,%rdx,8),%rbp
  270547:	mov    0xb0(%rsp),%rsi
  27054f:	mov    %esi,0x10(%rcx,%rdx,8)
  270553:	mov    0x10c(%rsp),%esi
  27055a:	mov    %esi,0x8(%rcx,%rdx,8)
  27055e:	cmovne %edi,%eax
  270561:	mov    0x108(%rsp),%esi
  270568:	mov    %esi,0xc(%rcx,%rdx,8)
  27056c:	mov    %ax,0x14(%rcx,%rdx,8)
  270571:	mov    (%rcx,%rdx,8),%rax
  270575:	test   %rax,%rax
  270578:	je     270589 <<glass::engine::Engine>::apply+0x1a49>
  27057a:	lock decq (%rax)
  27057e:	jne    270589 <<glass::engine::Engine>::apply+0x1a49>
  270580:	mov    %rbp,%rdi
  270583:	call   *0x3babc7(%rip)        # 62b150 <_DYNAMIC+0x270>
  270589:	movq   $0x0,0x0(%rbp)
  270591:	movw   $0x0,0x16(%rbp)
  270597:	cmp    $0x2,%r15
  27059b:	jne    270888 <<glass::engine::Engine>::apply+0x1d48>
  2705a1:	mov    0x30(%rsp),%rax
  2705a6:	lea    0x1(%rax),%rdx
  2705aa:	mov    0x10(%rsp),%rax
  2705af:	mov    0x30(%rax),%r15
  2705b3:	mov    0x28(%rax),%eax
  2705b6:	mov    %rdx,0xb8(%rsp)
  2705be:	cmp    %r15,%rdx
  2705c1:	jne    2705f1 <<glass::engine::Engine>::apply+0x1ab1>
  2705c3:	cmp    $0xffffffff,%eax
  2705c6:	je     2705f1 <<glass::engine::Engine>::apply+0x1ab1>
  2705c8:	mov    0x30(%rsp),%rax
  2705cd:	add    $0x2,%rax
  2705d1:	mov    0x10(%rsp),%rcx
  2705d6:	mov    %rax,0x30(%rcx)
  2705da:	mov    0x10(%rcx),%rax
  2705de:	cmp    %rax,0xb8(%rsp)
  2705e6:	jb     27081c <<glass::engine::Engine>::apply+0x1cdc>
  2705ec:	jmp    271025 <<glass::engine::Engine>::apply+0x24e5>
  2705f1:	cmp    $0xffffffff,%eax
  2705f4:	je     2707ed <<glass::engine::Engine>::apply+0x1cad>
  2705fa:	mov    0x10(%rsp),%rax
  2705ff:	mov    0x10(%rax),%rbp
  270603:	cmp    %r15,%rbp
  270606:	mov    %r15,%rax
  270609:	cmovb  %rbp,%rax
  27060d:	mov    %rax,0x60(%rsp)
  270612:	mov    0xb8(%rsp),%rax
  27061a:	cmp    %rax,%rbp
  27061d:	cmovb  %rbp,%rax
  270621:	mov    %rax,0x48(%rsp)
  270626:	mov    0x3babeb(%rip),%rax        # 62b218 <_DYNAMIC+0x338>
  27062d:	movzbl (%rax),%eax
  270630:	test   %al,%al
  270632:	je     27065d <<glass::engine::Engine>::apply+0x1b1d>
  270634:	mov    0x3bac15(%rip),%rax        # 62b250 <_DYNAMIC+0x370>
  27063b:	cmp    0x48(%rsp),%r15
  270640:	jae    270649 <<glass::engine::Engine>::apply+0x1b09>
  270642:	mov    0x3bac0f(%rip),%rax        # 62b258 <_DYNAMIC+0x378>
  270649:	lock incq 0x28(%rax)
  27064e:	mov    0x48(%rsp),%rdi
  270653:	sub    0x60(%rsp),%rdi
  270658:	call   313ab0 <alacritty_terminal::grid::row::fill_census::note>
  27065d:	cmp    0x48(%rsp),%r15
  270662:	jae    2707cd <<glass::engine::Engine>::apply+0x1c8d>
  270668:	mov    0x10(%rsp),%rax
  27066d:	mov    0x28(%rax),%ecx
  270670:	mov    %ecx,0x8(%rsp)
  270674:	mov    0x20(%rax),%ecx
  270677:	mov    %ecx,0x74(%rsp)
  27067b:	mov    0x24(%rax),%ecx
  27067e:	mov    %ecx,0x70(%rsp)
  270682:	movzwl 0x2c(%rax),%ecx
  270686:	mov    %cx,0x6c(%rsp)
  27068b:	mov    0x18(%rax),%r15
  27068f:	test   %r15,%r15
  270692:	je     2706a7 <<glass::engine::Engine>::apply+0x1b67>
  270694:	lock incq (%r15)
  270698:	jle    271058 <<glass::engine::Engine>::apply+0x2518>
  27069e:	mov    0x10(%rsp),%rax
  2706a3:	mov    0x10(%rax),%rbp
  2706a7:	mov    0x10(%rsp),%rax
  2706ac:	movzwl 0x2e(%rax),%ecx
  2706b0:	mov    0x8(%rsp),%eax
  2706b4:	mov    %eax,0xd0(%rsp)
  2706bb:	mov    0x74(%rsp),%eax
  2706bf:	mov    %eax,0xc8(%rsp)
  2706c6:	mov    0x70(%rsp),%eax
  2706ca:	mov    %eax,0xcc(%rsp)
  2706d1:	movzwl 0x6c(%rsp),%eax
  2706d6:	mov    %ax,0xd4(%rsp)
  2706de:	mov    %r15,0xc0(%rsp)
  2706e6:	mov    %cx,0x3e(%rsp)
  2706eb:	mov    %cx,0xd6(%rsp)
  2706f3:	cmp    %rbp,0x48(%rsp)
  2706f8:	ja     27103e <<glass::engine::Engine>::apply+0x24fe>
  2706fe:	mov    0x60(%rsp),%rax
  270703:	lea    0x0(,%rax,8),%rax
  27070b:	lea    (%rax,%rax,2),%rax
  27070f:	mov    0x10(%rsp),%rcx
  270714:	mov    0x8(%rcx),%rbp
  270718:	add    %rax,%rbp
  27071b:	mov    0x48(%rsp),%rcx
  270720:	lea    0x0(,%rcx,8),%rcx
  270728:	lea    (%rcx,%rcx,2),%r12
  27072c:	sub    %rax,%r12
  27072f:	jmp    270766 <<glass::engine::Engine>::apply+0x1c26>
  270731:	mov    %r15,0x0(%rbp)
  270735:	mov    0x74(%rsp),%eax
  270739:	mov    %eax,0x8(%rbp)
  27073c:	mov    0x70(%rsp),%eax
  270740:	mov    %eax,0xc(%rbp)
  270743:	mov    0x8(%rsp),%eax
  270747:	mov    %eax,0x10(%rbp)
  27074a:	movzwl 0x6c(%rsp),%eax
  27074f:	mov    %ax,0x14(%rbp)
  270753:	movzwl 0x3e(%rsp),%eax
  270758:	mov    %ax,0x16(%rbp)
  27075c:	add    $0x18,%rbp
  270760:	add    $0xffffffffffffffe8,%r12
  270764:	je     27078f <<glass::engine::Engine>::apply+0x1c4f>
  270766:	test   %r15,%r15
  270769:	je     270775 <<glass::engine::Engine>::apply+0x1c35>
  27076b:	lock incq (%r15)
  27076f:	jle    271058 <<glass::engine::Engine>::apply+0x2518>
  270775:	mov    0x0(%rbp),%rax
  270779:	test   %rax,%rax
  27077c:	je     270731 <<glass::engine::Engine>::apply+0x1bf1>
  27077e:	lock decq (%rax)
  270782:	jne    270731 <<glass::engine::Engine>::apply+0x1bf1>
  270784:	mov    %rbp,%rdi
  270787:	call   *0x3ba9c3(%rip)        # 62b150 <_DYNAMIC+0x270>
  27078d:	jmp    270731 <<glass::engine::Engine>::apply+0x1bf1>
  27078f:	mov    0x10(%rsp),%rax
  270794:	mov    0x60(%rsp),%rcx
  270799:	cmp    %ecx,0x38(%rax)
  27079c:	jbe    2707ab <<glass::engine::Engine>::apply+0x1c6b>
  27079e:	mov    0x10(%rsp),%rax
  2707a3:	mov    0x60(%rsp),%rcx
  2707a8:	mov    %ecx,0x38(%rax)
  2707ab:	test   %r15,%r15
  2707ae:	je     2707c4 <<glass::engine::Engine>::apply+0x1c84>
  2707b0:	lock decq (%r15)
  2707b4:	jne    2707c4 <<glass::engine::Engine>::apply+0x1c84>
  2707b6:	lea    0xc0(%rsp),%rdi
  2707be:	call   *0x3ba98c(%rip)        # 62b150 <_DYNAMIC+0x270>
  2707c4:	mov    0x10(%rsp),%rax
  2707c9:	mov    0x10(%rax),%rbp
  2707cd:	cmp    %rbp,0x48(%rsp)
  2707d2:	jb     2707ed <<glass::engine::Engine>::apply+0x1cad>
  2707d4:	mov    0x118(%rsp),%rdi
  2707dc:	call   1b98b0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2707e1:	mov    0x10(%rsp),%rax
  2707e6:	movl   $0xffffffff,0x28(%rax)
  2707ed:	mov    0x10(%rsp),%rdx
  2707f2:	mov    0x30(%rdx),%rax
  2707f6:	mov    0x30(%rsp),%rcx
  2707fb:	add    $0x2,%rcx
  2707ff:	cmp    %rax,%rcx
  270802:	cmovbe %rax,%rcx
  270806:	mov    0x10(%rdx),%rax
  27080a:	mov    %rcx,0x30(%rdx)
  27080e:	cmp    %rax,0xb8(%rsp)
  270816:	jae    27105a <<glass::engine::Engine>::apply+0x251a>
  27081c:	mov    0x10(%rsp),%rax
  270821:	mov    0x8(%rax),%rax
  270825:	mov    0xb8(%rsp),%rcx
  27082d:	lea    (%rcx,%rcx,2),%rcx
  270831:	lea    (%rax,%rcx,8),%r15
  270835:	movl   $0x20,0x10(%rax,%rcx,8)
  27083d:	mov    0x10c(%rsp),%edx
  270844:	mov    %edx,0x8(%rax,%rcx,8)
  270848:	mov    0x108(%rsp),%edx
  27084f:	mov    %edx,0xc(%rax,%rcx,8)
  270853:	mov    0x110(%rsp),%edx
  27085a:	or     $0x40,%edx
  27085d:	mov    %dx,0x14(%rax,%rcx,8)
  270862:	mov    (%rax,%rcx,8),%rax
  270866:	test   %rax,%rax
  270869:	je     27087a <<glass::engine::Engine>::apply+0x1d3a>
  27086b:	lock decq (%rax)
  27086f:	jne    27087a <<glass::engine::Engine>::apply+0x1d3a>
  270871:	mov    %r15,%rdi
  270874:	call   *0x3ba8d6(%rip)        # 62b150 <_DYNAMIC+0x270>
  27087a:	movq   $0x0,(%r15)
  270881:	movw   $0x0,0x16(%r15)
  270888:	mov    0x230(%rsp),%rax
  270890:	cmp    %rax,0x128(%rsp)
  270898:	jb     2708a7 <<glass::engine::Engine>::apply+0x1d67>
  27089a:	decq   0x128(%rsp)
  2708a2:	movb   $0x1,0x6c(%r13)
  2708a7:	mov    0x128(%rsp),%rax
  2708af:	mov    %rax,0x40(%r13)
  2708b3:	incq   0x1e0(%rsp)
  2708bb:	mov    0xb0(%rsp),%rax
  2708c3:	mov    %eax,0x1f0(%rsp)
  2708ca:	mov    $0x1,%r15d
  2708d0:	mov    0x40(%rsp),%r12
  2708d5:	mov    0x3bf0ed(%rip),%eax        # 62f9c8 <glass::engine::run_whole::ON>
  2708db:	test   %eax,%eax
  2708dd:	je     26fad0 <<glass::engine::Engine>::apply+0xf90>
  2708e3:	call   195736 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2708e8:	jmp    26fad0 <<glass::engine::Engine>::apply+0xf90>
  2708ed:	nopl   (%rax)
  2708f0:	mov    0x3bb0d1(%rip),%rax        # 62b9c8 <_DYNAMIC+0xae8>
  2708f7:	mov    (%rax),%rax
  2708fa:	mov    $0x1b,%edi
  2708ff:	mov    %r14,%rsi
  270902:	mov    0x120(%rsp),%rbx
  27090a:	mov    %rbx,%rdx
  27090d:	call   *%rax
  27090f:	mov    %r14,%r13
  270912:	mov    %rbx,%r14
  270915:	cmp    $0x1,%rax
  270919:	jne    270bd0 <<glass::engine::Engine>::apply+0x2090>
  27091f:	mov    %rdx,%rcx
  270922:	sub    %r13,%rcx
  270925:	movb   $0x1,0xa80(%r12)
  27092e:	movb   $0x0,0xa7e(%r12)
  270937:	inc    %rcx
  27093a:	cmp    %r15,%rcx
  27093d:	jb     270bdb <<glass::engine::Engine>::apply+0x209b>
  270943:	movzbl 0xa7e(%r12),%eax
  27094c:	jmp    270cd1 <<glass::engine::Engine>::apply+0x2191>
  270951:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  270960:	mov    0x20(%rsp),%r15
  270965:	cmp    %rbp,%r15
  270968:	jb     270f1f <<glass::engine::Engine>::apply+0x23df>
  27096e:	mov    0x28(%rsp),%r13
  270973:	mov    %r13,%rbx
  270976:	add    %rbp,%rbx
  270979:	mov    0x3bb048(%rip),%rax        # 62b9c8 <_DYNAMIC+0xae8>
  270980:	mov    (%rax),%rax
  270983:	mov    $0x1b,%edi
  270988:	mov    %rbx,%rsi
  27098b:	mov    0x120(%rsp),%r14
  270993:	mov    %r14,%rdx
  270996:	call   *%rax
  270998:	cmp    $0x1,%rax
  27099c:	jne    2709b9 <<glass::engine::Engine>::apply+0x1e79>
  27099e:	sub    %rbx,%rdx
  2709a1:	movb   $0x1,0xa80(%r12)
  2709aa:	movb   $0x0,0xa7e(%r12)
  2709b3:	add    %rdx,%rbp
  2709b6:	inc    %rbp
  2709b9:	cmp    %r15,%rbp
  2709bc:	jae    2709f3 <<glass::engine::Engine>::apply+0x1eb3>
  2709be:	mov    0x58(%rsp),%rdi
  2709c3:	mov    %r13,%rsi
  2709c6:	mov    %r15,%rdx
  2709c9:	mov    %rbp,%rcx
  2709cc:	mov    %r15,%r8
  2709cf:	call   2872d0 <<glass::engine::Mirror>::stretch>
  2709d4:	cmp    %r15,%rax
  2709d7:	jae    2709f3 <<glass::engine::Engine>::apply+0x1eb3>
  2709d9:	cmpb   $0x0,0xa80(%r12)
  2709e2:	jne    2709f3 <<glass::engine::Engine>::apply+0x1eb3>
  2709e4:	movzbl -0x1(%r14),%eax
  2709e9:	shr    $0x7,%al
  2709ec:	mov    0x58(%rsp),%rcx
  2709f1:	mov    %al,(%rcx)
  2709f3:	movzbl 0xa7e(%r12),%eax
  2709fc:	mov    %al,0xa7f(%r12)
  270a04:	sub    0x8(%rsp),%r15
  270a09:	mov    0xf0(%rsp),%rbx
  270a11:	jbe    270a40 <<glass::engine::Engine>::apply+0x1f00>
  270a13:	movzbl 0x3c22fe(%rip),%eax        # 632d18 <glass::engine::counters::COUNTING>
  270a1a:	test   %al,%al
  270a1c:	je     270a26 <<glass::engine::Engine>::apply+0x1ee6>
  270a1e:	lock add %r15,0x3c22fa(%rip)        # 632d20 <glass::engine::counters::VTE_BYTES>
  270a26:	movzbl 0x3c228b(%rip),%eax        # 632cb8 <glass::engine::probes::RUN_PROBE>
  270a2d:	cmp    $0x68,%al
  270a2f:	jne    270d7a <<glass::engine::Engine>::apply+0x223a>
  270a35:	data16 cs nopw 0x0(%rax,%rax,1)
  270a40:	mov    0x1f0(%rsp),%rax
  270a48:	mov    %rax,0xa70(%r12)
  270a50:	mov    0x1f8(%rsp),%eax
  270a57:	mov    %eax,0xa78(%r12)
  270a5f:	pshufd $0x4e,0x1d0(%rsp),%xmm0
  270a69:	movdqu %xmm0,0xa60(%r12)
  270a73:	movzbl 0x1fd(%rsp),%eax
  270a7b:	mov    %al,0xa7d(%r12)
  270a83:	movzbl 0x1fc(%rsp),%eax
  270a8b:	and    $0x1,%eax
  270a8e:	shl    $0x5,%eax
  270a91:	mov    0x1c8(%rsp,%rax,1),%rax
  270a99:	mov    0xa58(%r12),%rcx
  270aa1:	cmp    %rcx,%rax
  270aa4:	cmova  %rax,%rcx
  270aa8:	mov    %rcx,0xa58(%r12)
  270ab0:	mov    0x150(%rsp),%rax
  270ab8:	mov    %rax,0x28(%rsp)
  270abd:	mov    0x158(%rsp),%r13
  270ac5:	mov    0x160(%rsp),%r15
  270acd:	movq   $0x0,0x150(%rsp)
  270ad9:	movq   $0x8,0x158(%rsp)
  270ae5:	movq   $0x0,0x160(%rsp)
  270af1:	test   %r15,%r15
  270af4:	je     270b52 <<glass::engine::Engine>::apply+0x2012>
  270af6:	mov    0x8e8(%r12),%rax
  270afe:	mov    0x8f8(%r12),%r14
  270b06:	sub    %r14,%rax
  270b09:	cmp    %rax,%r15
  270b0c:	ja     270e4d <<glass::engine::Engine>::apply+0x230d>
  270b12:	mov    %r15,%rax
  270b15:	shl    $0x4,%rax
  270b19:	lea    (%rax,%rax,2),%rdx
  270b1d:	lea    (%r14,%r14,2),%rdi
  270b21:	shl    $0x4,%rdi
  270b25:	add    0x8f0(%r12),%rdi
  270b2d:	mov    %r13,%rsi
  270b30:	call   *0x3ba5da(%rip)        # 62b110 <memcpy@GLIBC_2.14>
  270b36:	add    %r15,%r14
  270b39:	mov    %r14,0x8f8(%r12)
  270b41:	cmpq   $0x0,0x28(%rsp)
  270b47:	je     270b52 <<glass::engine::Engine>::apply+0x2012>
  270b49:	mov    %r13,%rdi
  270b4c:	call   *0x3ba5de(%rip)        # 62b130 <_DYNAMIC+0x250>
  270b52:	mov    0x180(%rsp),%r14
  270b5a:	lea    0x188(%rsp),%rax
  270b62:	movups (%rax),%xmm0
  270b65:	movups 0x10(%rax),%xmm1
  270b69:	movups 0x20(%rax),%xmm2
  270b6d:	movaps %xmm0,0x80(%rsp)
  270b75:	movaps %xmm1,0x90(%rsp)
  270b7d:	movaps %xmm2,0xa0(%rsp)
  270b85:	movq   $0xffffffffffffffff,0x180(%rsp)
  270b91:	cmp    $0xffffffffffffffff,%r14
  270b95:	je     270bc0 <<glass::engine::Engine>::apply+0x2080>
  270b97:	cmpq   $0x0,0x998(%r12)
  270ba0:	jle    270c1a <<glass::engine::Engine>::apply+0x20da>
  270ba2:	mov    (%rbx),%rdi
  270ba5:	call   *0x3ba585(%rip)        # 62b130 <_DYNAMIC+0x250>
  270bab:	cmpq   $0x0,0x180(%rsp)
  270bb4:	setg   %bpl
  270bb8:	jmp    270c1c <<glass::engine::Engine>::apply+0x20dc>
  270bba:	nopw   0x0(%rax,%rax,1)
  270bc0:	xor    %ebp,%ebp
  270bc2:	jmp    270c47 <<glass::engine::Engine>::apply+0x2107>
  270bc7:	nopw   0x0(%rax,%rax,1)
  270bd0:	xor    %ecx,%ecx
  270bd2:	cmp    %r15,%rcx
  270bd5:	jae    270943 <<glass::engine::Engine>::apply+0x1e03>
  270bdb:	mov    0x58(%rsp),%rdi
  270be0:	mov    %r13,%rsi
  270be3:	mov    %r15,%rdx
  270be6:	mov    %r15,%r8
  270be9:	call   2872d0 <<glass::engine::Mirror>::stretch>
  270bee:	cmp    %r15,%rax
  270bf1:	jae    270cc9 <<glass::engine::Engine>::apply+0x2189>
  270bf7:	cmpb   $0x0,0xa80(%r12)
  270c00:	jne    270cc9 <<glass::engine::Engine>::apply+0x2189>
  270c06:	movzbl -0x1(%r14),%eax
  270c0b:	shr    $0x7,%al
  270c0e:	mov    0x58(%rsp),%rcx
  270c13:	mov    %al,(%rcx)
  270c15:	jmp    270cd1 <<glass::engine::Engine>::apply+0x2191>
  270c1a:	xor    %ebp,%ebp
  270c1c:	mov    %r14,0x998(%r12)
  270c24:	movaps 0x80(%rsp),%xmm0
  270c2c:	movaps 0x90(%rsp),%xmm1
  270c34:	movaps 0xa0(%rsp),%xmm2
  270c3c:	movups %xmm2,0x20(%rbx)
  270c40:	movups %xmm1,0x10(%rbx)
  270c44:	movups %xmm0,(%rbx)
  270c47:	mov    0x168(%rsp),%rbx
  270c4f:	mov    0x170(%rsp),%r12
  270c57:	mov    0x188(%rsp),%r14
  270c5f:	cmpq   $0x0,0x150(%rsp)
  270c68:	je     270c78 <<glass::engine::Engine>::apply+0x2138>
  270c6a:	mov    0x158(%rsp),%rdi
  270c72:	call   *0x3ba4b8(%rip)        # 62b130 <_DYNAMIC+0x250>
  270c78:	test   %rbx,%rbx
  270c7b:	je     270c86 <<glass::engine::Engine>::apply+0x2146>
  270c7d:	mov    %r12,%rdi
  270c80:	call   *0x3ba4aa(%rip)        # 62b130 <_DYNAMIC+0x250>
  270c86:	test   %bpl,%bpl
  270c89:	je     270c94 <<glass::engine::Engine>::apply+0x2154>
  270c8b:	mov    %r14,%rdi
  270c8e:	call   *0x3ba49c(%rip)        # 62b130 <_DYNAMIC+0x250>
  270c94:	mov    0x40(%rsp),%rbx
  270c99:	mov    %rbx,%rdi
  270c9c:	call   26ddb0 <<glass::engine::Engine>::fold_sentinel>
  270ca1:	test   %r15,%r15
  270ca4:	setne  %al
  270ca7:	cmpq   $0x0,0x28(%rsp)
  270cad:	sete   %cl
  270cb0:	or     %al,%cl
  270cb2:	cmp    $0x1,%cl
  270cb5:	je     26ec20 <<glass::engine::Engine>::apply+0xe0>
  270cbb:	mov    %r13,%rdi
  270cbe:	call   *0x3ba46c(%rip)        # 62b130 <_DYNAMIC+0x250>
  270cc4:	jmp    26ec20 <<glass::engine::Engine>::apply+0xe0>
  270cc9:	mov    0x58(%rsp),%rax
  270cce:	movzbl (%rax),%eax
  270cd1:	mov    %al,0xa7f(%r12)
  270cd9:	mov    0xf0(%rsp),%rbx
  270ce1:	xor    %ebp,%ebp
  270ce3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  270cf0:	cmpl   $0xffffffff,0x710(%r12)
  270cf9:	jne    270d54 <<glass::engine::Engine>::apply+0x2214>
  270cfb:	mov    0x78(%rsp),%rax
  270d00:	mov    %rax,0x80(%rsp)
  270d08:	lea    0x140(%rsp),%rax
  270d10:	mov    %rax,0x88(%rsp)
  270d18:	movb   $0x0,0x90(%rsp)
  270d20:	mov    %r15,%rcx
  270d23:	sub    %rbp,%rcx
  270d26:	jb     270e8a <<glass::engine::Engine>::apply+0x234a>
  270d2c:	mov    %r13,%rdx
  270d2f:	add    %rbp,%rdx
  270d32:	mov    0x100(%rsp),%rdi
  270d3a:	lea    0x80(%rsp),%rsi
  270d42:	call   1aad70 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  270d47:	add    %rax,%rbp
  270d4a:	cmp    %r15,%rbp
  270d4d:	jne    270cf0 <<glass::engine::Engine>::apply+0x21b0>
  270d4f:	jmp    270a40 <<glass::engine::Engine>::apply+0x1f00>
  270d54:	mov    %r15,%rcx
  270d57:	sub    %rbp,%rcx
  270d5a:	jb     270f96 <<glass::engine::Engine>::apply+0x2456>
  270d60:	mov    %r13,%rdx
  270d63:	add    %rbp,%rdx
  270d66:	mov    0x78(%rsp),%rdi
  270d6b:	lea    0x140(%rsp),%rsi
  270d73:	call   19e580 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  270d78:	jmp    270d47 <<glass::engine::Engine>::apply+0x2207>
  270d7a:	mov    %r15,%rdx
  270d7d:	add    0x8(%rsp),%r13
  270d82:	cmpb   $0x1,0x50(%rsp)
  270d87:	jne    270db7 <<glass::engine::Engine>::apply+0x2277>
  270d89:	cmpl   $0xffffffff,0x710(%r12)
  270d92:	jne    270db7 <<glass::engine::Engine>::apply+0x2277>
  270d94:	lea    0x140(%rsp),%rdi
  270d9c:	mov    %r13,%rsi
  270d9f:	call   2beb60 <glass::engine::plain_c0>
  270da4:	test   %al,%al
  270da6:	mov    0xf0(%rsp),%rbx
  270dae:	mov    %r15,%rdx
  270db1:	jne    270a40 <<glass::engine::Engine>::apply+0x1f00>
  270db7:	xor    %ebp,%ebp
  270db9:	nopl   0x0(%rax)
  270dc0:	cmpl   $0xffffffff,0x710(%r12)
  270dc9:	jne    270e27 <<glass::engine::Engine>::apply+0x22e7>
  270dcb:	mov    0x78(%rsp),%rax
  270dd0:	mov    %rax,0x80(%rsp)
  270dd8:	lea    0x140(%rsp),%rax
  270de0:	mov    %rax,0x88(%rsp)
  270de8:	movb   $0x0,0x90(%rsp)
  270df0:	mov    %r15,%rcx
  270df3:	sub    %rbp,%rcx
  270df6:	jb     270e8a <<glass::engine::Engine>::apply+0x234a>
  270dfc:	mov    %r13,%rdx
  270dff:	add    %rbp,%rdx
  270e02:	mov    0x100(%rsp),%rdi
  270e0a:	lea    0x80(%rsp),%rsi
  270e12:	call   1aad70 <<vte::Parser<1024>>::advance_until_terminated::<vte::ansi::Performer<glass::engine::Watch, vte::ansi::StdSyncHandler>>>
  270e17:	add    %rax,%rbp
  270e1a:	mov    %r15,%rdx
  270e1d:	cmp    %r15,%rbp
  270e20:	jne    270dc0 <<glass::engine::Engine>::apply+0x2280>
  270e22:	jmp    270a40 <<glass::engine::Engine>::apply+0x1f00>
  270e27:	mov    %rdx,%rcx
  270e2a:	sub    %rbp,%rcx
  270e2d:	jb     270f96 <<glass::engine::Engine>::apply+0x2456>
  270e33:	mov    %r13,%rdx
  270e36:	add    %rbp,%rdx
  270e39:	mov    0x78(%rsp),%rdi
  270e3e:	lea    0x140(%rsp),%rsi
  270e46:	call   19e580 <<vte::ansi::Processor>::advance_sync::<glass::engine::Watch>>
  270e4b:	jmp    270e17 <<glass::engine::Engine>::apply+0x22d7>
  270e4d:	mov    $0x8,%ecx
  270e52:	mov    $0x30,%r8d
  270e58:	mov    0x238(%rsp),%rdi
  270e60:	mov    %r14,%rsi
  270e63:	mov    %r15,%rdx
  270e66:	call   1e4c20 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  270e6b:	mov    0x8f8(%r12),%r14
  270e73:	jmp    270b12 <<glass::engine::Engine>::apply+0x1fd2>
  270e78:	add    $0x258,%rsp
  270e7f:	pop    %rbx
  270e80:	pop    %r12
  270e82:	pop    %r13
  270e84:	pop    %r14
  270e86:	pop    %r15
  270e88:	pop    %rbp
  270e89:	ret
  270e8a:	mov    %r15,%r8
  270e8d:	lea    0x37b1c4(%rip),%rcx        # 5ec058 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x878>
  270e94:	jmp    270eb1 <<glass::engine::Engine>::apply+0x2371>
  270e96:	mov    %rbx,%r8
  270e99:	lea    0x390e58(%rip),%rcx        # 601cf8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16518>
  270ea0:	mov    0x20(%rsp),%r15
  270ea5:	jmp    270eb1 <<glass::engine::Engine>::apply+0x2371>
  270ea7:	mov    %rbx,%r8
  270eaa:	lea    0x390e47(%rip),%rcx        # 601cf8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16518>
  270eb1:	mov    %rbp,%rdi
  270eb4:	mov    %r8,%rsi
  270eb7:	mov    %r15,%rdx
  270eba:	call   *0x3ba448(%rip)        # 62b308 <_DYNAMIC+0x428>
  270ec0:	jmp    271058 <<glass::engine::Engine>::apply+0x2518>
  270ec5:	mov    %rbx,%rbp
  270ec8:	mov    %r13,%r8
  270ecb:	lea    0x393526(%rip),%rcx        # 6043f8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c18>
  270ed2:	mov    0x20(%rsp),%r15
  270ed7:	jmp    270eb1 <<glass::engine::Engine>::apply+0x2371>
  270ed9:	lea    0x393548(%rip),%rcx        # 604428 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c48>
  270ee0:	xor    %ebp,%ebp
  270ee2:	mov    0x20(%rsp),%r15
  270ee7:	mov    %rdx,%r8
  270eea:	jmp    270eb1 <<glass::engine::Engine>::apply+0x2371>
  270eec:	mov    0x8(%rsp),%rbp
  270ef1:	mov    %rbx,%r8
  270ef4:	lea    0x393515(%rip),%rcx        # 604410 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c30>
  270efb:	mov    0x20(%rsp),%r15
  270f00:	jmp    270eb1 <<glass::engine::Engine>::apply+0x2371>
  270f02:	mov    $0xffffffffffffffff,%r8
  270f09:	xor    %ebp,%ebp
  270f0b:	xor    %r15d,%r15d
  270f0e:	lea    0x3934cb(%rip),%rcx        # 6043e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c00>
  270f15:	jmp    270eb1 <<glass::engine::Engine>::apply+0x2371>
  270f17:	mov    %r13,%rbp
  270f1a:	jmp    270e99 <<glass::engine::Engine>::apply+0x2359>
  270f1f:	mov    %r15,%r8
  270f22:	jmp    270eaa <<glass::engine::Engine>::apply+0x236a>
  270f24:	lea    0x393485(%rip),%rdx        # 6043b0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18bd0>
  270f2b:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  270f2d:	mov    %r13,%rbp
  270f30:	lea    0x393509(%rip),%rcx        # 604440 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c60>
  270f37:	mov    0x20(%rsp),%r15
  270f3c:	jmp    270eb1 <<glass::engine::Engine>::apply+0x2371>
  270f41:	lea    0x393480(%rip),%rdx        # 6043c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18be8>
  270f48:	mov    %r14,%rdi
  270f4b:	mov    0x20(%rsp),%rsi
  270f50:	call   *0x3ba1a2(%rip)        # 62b0f8 <_DYNAMIC+0x218>
  270f56:	jmp    271058 <<glass::engine::Engine>::apply+0x2518>
  270f5b:	mov    $0x10,%eax
  270f60:	mov    %rax,0x20(%rsp)
  270f65:	mov    $0xffffffffffffffff,%r14
  270f6c:	lea    0x3934e5(%rip),%rdx        # 604458 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c78>
  270f73:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  270f75:	mov    $0x8,%edi
  270f7a:	mov    %r14,%rsi
  270f7d:	call   *0x3ba165(%rip)        # 62b0e8 <_DYNAMIC+0x208>
  270f83:	mov    $0x10,%eax
  270f88:	mov    %rax,0x20(%rsp)
  270f8d:	lea    0x3934dc(%rip),%rdx        # 604470 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18c90>
  270f94:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  270f96:	mov    %r15,%r8
  270f99:	lea    0x37b0d0(%rip),%rcx        # 5ec070 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x890>
  270fa0:	jmp    270eb1 <<glass::engine::Engine>::apply+0x2371>
  270fa5:	mov    $0x10,%eax
  270faa:	mov    %rax,0x20(%rsp)
  270faf:	lea    0x3934d2(%rip),%rdx        # 604488 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18ca8>
  270fb6:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  270fb8:	mov    %rsi,%r14
  270fbb:	mov    0x18(%rsp),%rax
  270fc0:	mov    %rax,0x20(%rsp)
  270fc5:	lea    0x3933cc(%rip),%rdx        # 604398 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18bb8>
  270fcc:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  270fd1:	mov    0x30(%rsp),%r14
  270fd6:	mov    %rcx,0x20(%rsp)
  270fdb:	lea    0x37df3e(%rip),%rdx        # 5eef20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  270fe2:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  270fe7:	mov    %rcx,%r14
  270fea:	mov    %rdx,0x20(%rsp)
  270fef:	lea    0x37df2a(%rip),%rdx        # 5eef20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  270ff6:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  270ffb:	lea    0x390456(%rip),%rcx        # 601458 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  271002:	mov    0x60(%rsp),%rdi
  271007:	mov    0x48(%rsp),%rsi
  27100c:	mov    %rbp,%rdx
  27100f:	call   *0x3ba2f3(%rip)        # 62b308 <_DYNAMIC+0x428>
  271015:	jmp    271058 <<glass::engine::Engine>::apply+0x2518>
  271017:	mov    0x30(%rsp),%r14
  27101c:	jmp    27102d <<glass::engine::Engine>::apply+0x24ed>
  27101e:	mov    0x30(%rsp),%r14
  271023:	jmp    271062 <<glass::engine::Engine>::apply+0x2522>
  271025:	mov    0xb8(%rsp),%r14
  27102d:	mov    %rax,0x20(%rsp)
  271032:	lea    0x391037(%rip),%rdx        # 602070 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16890>
  271039:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  27103e:	lea    0x390413(%rip),%rcx        # 601458 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  271045:	mov    0x60(%rsp),%rdi
  27104a:	mov    0x48(%rsp),%rsi
  27104f:	mov    %rbp,%rdx
  271052:	call   *0x3ba2b0(%rip)        # 62b308 <_DYNAMIC+0x428>
  271058:	ud2
  27105a:	mov    0xb8(%rsp),%r14
  271062:	mov    %rax,0x20(%rsp)
  271067:	lea    0x390fea(%rip),%rdx        # 602058 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  27106e:	jmp    270f48 <<glass::engine::Engine>::apply+0x2408>
  271073:	mov    %rax,%r14
  271076:	cmpq   $0x0,0x28(%rsp)
  27107c:	je     2710f2 <<glass::engine::Engine>::apply+0x25b2>
  27107e:	mov    %r13,%rdi
  271081:	call   *0x3ba0a9(%rip)        # 62b130 <_DYNAMIC+0x250>
  271087:	jmp    2710f2 <<glass::engine::Engine>::apply+0x25b2>
  271089:	mov    %rax,%r14
  27108c:	test   %r15,%r15
  27108f:	je     2710f2 <<glass::engine::Engine>::apply+0x25b2>
  271091:	lock decq (%r15)
  271095:	je     2710af <<glass::engine::Engine>::apply+0x256f>
  271097:	jmp    2710f2 <<glass::engine::Engine>::apply+0x25b2>
  271099:	mov    %rax,%r14
  27109c:	cmpq   $0x0,0x8(%rsp)
  2710a2:	je     2710f2 <<glass::engine::Engine>::apply+0x25b2>
  2710a4:	mov    0x8(%rsp),%rax
  2710a9:	lock decq (%rax)
  2710ad:	jne    2710f2 <<glass::engine::Engine>::apply+0x25b2>
  2710af:	lea    0xc0(%rsp),%rdi
  2710b7:	call   *0x3ba093(%rip)        # 62b150 <_DYNAMIC+0x270>
  2710bd:	jmp    2710f2 <<glass::engine::Engine>::apply+0x25b2>
  2710bf:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710c1:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710c3:	mov    %rax,%r14
  2710c6:	test   %r15,%r15
  2710c9:	setne  %al
  2710cc:	cmpq   $0x0,0x28(%rsp)
  2710d2:	sete   %cl
  2710d5:	or     %al,%cl
  2710d7:	jne    27115e <<glass::engine::Engine>::apply+0x261e>
  2710dd:	jmp    27111b <<glass::engine::Engine>::apply+0x25db>
  2710df:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710e1:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710e3:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710e5:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710e7:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710e9:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710eb:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710ed:	jmp    2710ef <<glass::engine::Engine>::apply+0x25af>
  2710ef:	mov    %rax,%r14
  2710f2:	cmpq   $0x0,0x150(%rsp)
  2710fb:	jne    27112c <<glass::engine::Engine>::apply+0x25ec>
  2710fd:	cmpq   $0x0,0x168(%rsp)
  271106:	jne    271145 <<glass::engine::Engine>::apply+0x2605>
  271108:	cmpq   $0x0,0x180(%rsp)
  271111:	jle    27115e <<glass::engine::Engine>::apply+0x261e>
  271113:	mov    0x188(%rsp),%r13
  27111b:	mov    %r13,%rdi
  27111e:	call   *0x3ba00c(%rip)        # 62b130 <_DYNAMIC+0x250>
  271124:	mov    %r14,%rdi
  271127:	call   5e7630 <_Unwind_Resume@plt>
  27112c:	mov    0x158(%rsp),%rdi
  271134:	call   *0x3b9ff6(%rip)        # 62b130 <_DYNAMIC+0x250>
  27113a:	cmpq   $0x0,0x168(%rsp)
  271143:	je     271108 <<glass::engine::Engine>::apply+0x25c8>
  271145:	mov    0x170(%rsp),%rdi
  27114d:	call   *0x3b9fdd(%rip)        # 62b130 <_DYNAMIC+0x250>
  271153:	cmpq   $0x0,0x180(%rsp)
  27115c:	jg     271113 <<glass::engine::Engine>::apply+0x25d3>
  27115e:	mov    %r14,%rdi
  271161:	call   5e7630 <_Unwind_Resume@plt>
