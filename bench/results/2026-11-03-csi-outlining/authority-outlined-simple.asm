
/tmp/glass-i26-authority-outlined-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002a0cd0 <glass::engine::simple>:
  2a0cd0:	push   %rbp
  2a0cd1:	push   %r14
  2a0cd3:	push   %rbx
  2a0cd4:	sub    $0x20,%rsp
  2a0cd8:	mov    $0x2,%r8b
  2a0cdb:	cmp    $0x2,%rdx
  2a0cdf:	jb     2a0e45 <glass::engine::simple+0x175>
  2a0ce5:	cmpb   $0x5b,0x1(%rsi)
  2a0ce9:	jne    2a0e45 <glass::engine::simple+0x175>
  2a0cef:	xorps  %xmm0,%xmm0
  2a0cf2:	movaps %xmm0,0x10(%rsp)
  2a0cf7:	movaps %xmm0,(%rsp)
  2a0cfb:	cmp    $0x2,%rdx
  2a0cff:	je     2a0e45 <glass::engine::simple+0x175>
  2a0d05:	movzbl 0x2(%rsi),%r11d
  2a0d0a:	lea    -0x30(%r11),%eax
  2a0d0e:	cmp    $0xa,%al
  2a0d10:	jae    2a0d3b <glass::engine::simple+0x6b>
  2a0d12:	movzbl %al,%eax
  2a0d15:	xor    %ecx,%ecx
  2a0d17:	cmp    $0x3,%rdx
  2a0d1b:	je     2a0e45 <glass::engine::simple+0x175>
  2a0d21:	mov    $0x3,%r10d
  2a0d27:	sub    %rdx,%r10
  2a0d2a:	mov    $0x4,%r9d
  2a0d30:	mov    $0xa,%bx
  2a0d34:	mov    $0xffff,%ebp
  2a0d39:	jmp    2a0d94 <glass::engine::simple+0xc4>
  2a0d3b:	movzbl %r11b,%r9d
  2a0d3f:	xor    %eax,%eax
  2a0d41:	lea    -0x48(%r9),%ecx
  2a0d45:	cmp    $0x25,%ecx
  2a0d48:	ja     2a0d62 <glass::engine::simple+0x92>
  2a0d4a:	mov    $0x3,%r9d
  2a0d50:	lea    -0x23177f(%rip),%rdx        # 6f5d8 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x3ba7>
  2a0d57:	movslq (%rdx,%rcx,4),%rsi
  2a0d5b:	add    %rdx,%rsi
  2a0d5e:	xor    %ecx,%ecx
  2a0d60:	jmp    *%rsi
  2a0d62:	mov    $0x1,%ecx
  2a0d67:	cmp    $0x3b,%r9d
  2a0d6b:	je     2a0d17 <glass::engine::simple+0x47>
  2a0d6d:	jmp    2a0e45 <glass::engine::simple+0x175>
  2a0d72:	mov    $0xffff,%dx
  2a0d76:	movzbl %r14b,%eax
  2a0d7a:	add    %dx,%ax
  2a0d7d:	cmovb  %ebp,%eax
  2a0d80:	lea    (%r10,%r9,1),%rdx
  2a0d84:	inc    %rdx
  2a0d87:	inc    %r9
  2a0d8a:	cmp    $0x4,%rdx
  2a0d8e:	je     2a0e45 <glass::engine::simple+0x175>
  2a0d94:	movzbl -0x1(%rsi,%r9,1),%r11d
  2a0d9a:	lea    -0x30(%r11),%r14d
  2a0d9e:	cmp    $0xa,%r14b
  2a0da2:	jae    2a0dad <glass::engine::simple+0xdd>
  2a0da4:	mul    %bx
  2a0da7:	jo     2a0d72 <glass::engine::simple+0xa2>
  2a0da9:	mov    %eax,%edx
  2a0dab:	jmp    2a0d76 <glass::engine::simple+0xa6>
  2a0dad:	movzbl %r11b,%edx
  2a0db1:	cmp    $0x3b,%edx
  2a0db4:	jne    2a0dd9 <glass::engine::simple+0x109>
  2a0db6:	lea    0x1(%rcx),%rdx
  2a0dba:	cmp    $0x10,%rdx
  2a0dbe:	jae    2a0e45 <glass::engine::simple+0x175>
  2a0dc4:	cmp    $0xf,%rcx
  2a0dc8:	ja     2a0e52 <glass::engine::simple+0x182>
  2a0dce:	mov    %ax,(%rsp,%rcx,2)
  2a0dd2:	xor    %eax,%eax
  2a0dd4:	mov    %rdx,%rcx
  2a0dd7:	jmp    2a0d80 <glass::engine::simple+0xb0>
  2a0dd9:	add    $0xffffffb8,%edx
  2a0ddc:	cmp    $0x25,%edx
  2a0ddf:	ja     2a0e45 <glass::engine::simple+0x175>
  2a0de1:	lea    -0x231778(%rip),%rsi        # 6f670 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x3c3f>
  2a0de8:	movslq (%rsi,%rdx,4),%rdx
  2a0dec:	add    %rsi,%rdx
  2a0def:	jmp    *%rdx
  2a0df1:	cmp    $0x10,%rcx
  2a0df5:	jae    2a0e67 <glass::engine::simple+0x197>
  2a0df7:	mov    %ax,(%rsp,%rcx,2)
  2a0dfb:	cmp    $0x6d,%r11b
  2a0dff:	setne  %al
  2a0e02:	movaps (%rsp),%xmm0
  2a0e06:	movaps 0x10(%rsp),%xmm1
  2a0e0b:	movups %xmm1,0x18(%rdi)
  2a0e0f:	movups %xmm0,0x8(%rdi)
  2a0e13:	xor    %r8d,%r8d
  2a0e16:	jmp    2a0e38 <glass::engine::simple+0x168>
  2a0e18:	cmp    $0x10,%rcx
  2a0e1c:	jae    2a0e7c <glass::engine::simple+0x1ac>
  2a0e1e:	mov    %ax,(%rsp,%rcx,2)
  2a0e22:	movaps (%rsp),%xmm0
  2a0e26:	movaps 0x10(%rsp),%xmm1
  2a0e2b:	movups %xmm1,0x18(%rdi)
  2a0e2f:	movups %xmm0,0x8(%rdi)
  2a0e33:	mov    $0x1,%r8b
  2a0e36:	xor    %eax,%eax
  2a0e38:	inc    %rcx
  2a0e3b:	mov    %r9,(%rdi)
  2a0e3e:	mov    %rcx,0x28(%rdi)
  2a0e42:	mov    %al,0x30(%rdi)
  2a0e45:	mov    %r8b,0x31(%rdi)
  2a0e49:	add    $0x20,%rsp
  2a0e4d:	pop    %rbx
  2a0e4e:	pop    %r14
  2a0e50:	pop    %rbp
  2a0e51:	ret
  2a0e52:	lea    0x329b1f(%rip),%rdx        # 5ca978 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17bf8>
  2a0e59:	mov    $0x10,%esi
  2a0e5e:	mov    %rcx,%rdi
  2a0e61:	call   *0x350051(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  2a0e67:	lea    0x329b22(%rip),%rdx        # 5ca990 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c10>
  2a0e6e:	mov    $0x10,%esi
  2a0e73:	mov    %rcx,%rdi
  2a0e76:	call   *0x35003c(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  2a0e7c:	lea    0x329b25(%rip),%rdx        # 5ca9a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c28>
  2a0e83:	mov    $0x10,%esi
  2a0e88:	mov    %rcx,%rdi
  2a0e8b:	call   *0x350027(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
