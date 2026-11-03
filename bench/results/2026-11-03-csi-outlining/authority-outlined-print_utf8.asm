
/tmp/glass-i26-authority-outlined-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000261c90 <<glass::engine::Watch>::print_utf8>:
  261c90:	push   %rbp
  261c91:	push   %r15
  261c93:	push   %r14
  261c95:	push   %r13
  261c97:	push   %r12
  261c99:	push   %rbx
  261c9a:	sub    $0x118,%rsp
  261ca1:	mov    %rdx,%r13
  261ca4:	mov    %rdi,%r15
  261ca7:	cmpb   $0x1,0xbe(%rdi)
  261cae:	jne    261cdb <<glass::engine::Watch>::print_utf8+0x4b>
  261cb0:	cmpq   $0x0,0x38(%r15)
  261cb5:	jne    261cdb <<glass::engine::Watch>::print_utf8+0x4b>
  261cb7:	mov    0x78(%r15),%rax
  261cbb:	testb  $0x4,0x6c5(%rax)
  261cc2:	jne    261cdb <<glass::engine::Watch>::print_utf8+0x4b>
  261cc4:	cmpq   $0x0,0x50(%rax)
  261cc9:	jne    261cdb <<glass::engine::Watch>::print_utf8+0x4b>
  261ccb:	movzwl 0x64(%rax),%ecx
  261ccf:	test   $0x460,%ecx
  261cd5:	je     263400 <<glass::engine::Watch>::print_utf8+0x1770>
  261cdb:	movl   $0x0,0x10(%rsp)
  261ce3:	movl   $0x0,0x80(%rsp)
  261cee:	mov    $0xffffffff,%r8d
  261cf4:	xor    %r14d,%r14d
  261cf7:	lea    0x3664d2(%rip),%rax        # 5c81d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15450>
  261cfe:	mov    %rax,0xf0(%rsp)
  261d06:	lea    0x40(%rsp),%rax
  261d0b:	mov    %rax,0x110(%rsp)
  261d13:	xor    %edx,%edx
  261d15:	mov    %r13,0xc0(%rsp)
  261d1d:	mov    %r15,0xc8(%rsp)
  261d25:	mov    %rsi,0x18(%rsp)
  261d2a:	cmpb   $0x0,0x80(%rsp)
  261d32:	je     262829 <<glass::engine::Watch>::print_utf8+0xb99>
  261d38:	nopl   0x0(%rax,%rax,1)
  261d40:	mov    0x78(%r15),%rbx
  261d44:	cmpb   $0x0,0x6c(%rbx)
  261d48:	jne    262829 <<glass::engine::Watch>::print_utf8+0xb99>
  261d4e:	mov    0x30(%rbx),%eax
  261d51:	sub    0x48(%rbx),%eax
  261d54:	cltq
  261d56:	mov    0x20(%rbx),%rsi
  261d5a:	mov    0x28(%rbx),%rcx
  261d5e:	lea    (%rcx,%rax,1),%rdi
  261d62:	dec    %rdi
  261d65:	cmp    %rsi,%rdi
  261d68:	mov    $0x0,%eax
  261d6d:	cmovae %rsi,%rax
  261d71:	sub    %rax,%rdi
  261d74:	cmp    %rsi,%rdi
  261d77:	jae    263ca4 <<glass::engine::Watch>::print_utf8+0x2014>
  261d7d:	mov    0xa0(%rbx),%rax
  261d84:	mov    %rax,0x38(%rsp)
  261d89:	mov    0x40(%rbx),%r12
  261d8d:	mov    0x58(%rbx),%eax
  261d90:	mov    %eax,0x78(%rsp)
  261d94:	mov    0x5c(%rbx),%eax
  261d97:	mov    %eax,0xa0(%rsp)
  261d9e:	movzwl 0x64(%rbx),%eax
  261da2:	mov    %eax,0xc(%rsp)
  261da6:	mov    0x18(%rbx),%rax
  261daa:	shl    $0x6,%rdi
  261dae:	lea    (%rax,%rdi,1),%rbp
  261db2:	cmp    %r12d,0x38(%rax,%rdi,1)
  261db7:	jbe    261dbd <<glass::engine::Watch>::print_utf8+0x12d>
  261db9:	mov    %r12d,0x38(%rbp)
  261dbd:	mov    %rdx,0x28(%rsp)
  261dc2:	mov    0x28(%rbp),%r10d
  261dc6:	cmp    $0xffffffff,%r10d
  261dca:	mov    %r12,0x60(%rsp)
  261dcf:	je     261e89 <<glass::engine::Watch>::print_utf8+0x1f9>
  261dd5:	mov    0x30(%rbp),%rax
  261dd9:	cmp    %rax,%r12
  261ddc:	mov    $0x0,%ecx
  261de1:	cmovb  %rax,%rcx
  261de5:	mov    %rcx,0x20(%rsp)
  261dea:	movl   $0x20,0x108(%rsp)
  261df5:	mov    0x78(%rsp),%ecx
  261df9:	mov    %ecx,0x100(%rsp)
  261e00:	mov    0xa0(%rsp),%ecx
  261e07:	mov    %ecx,0x104(%rsp)
  261e0e:	mov    0xc(%rsp),%ecx
  261e12:	mov    %cx,0x10c(%rsp)
  261e1a:	movq   $0x0,0xf8(%rsp)
  261e26:	mov    0x10(%rbp),%rcx
  261e2a:	cmp    %rax,%rcx
  261e2d:	mov    %rax,%rdx
  261e30:	cmovb  %rcx,%rdx
  261e34:	mov    %rdx,0x68(%rsp)
  261e39:	cmp    %r12,%rcx
  261e3c:	mov    %r12,%r9
  261e3f:	cmovb  %rcx,%r9
  261e43:	mov    0x38f176(%rip),%rdx        # 5f0fc0 <_DYNAMIC+0x320>
  261e4a:	movzbl (%rdx),%edx
  261e4d:	test   %dl,%dl
  261e4f:	je     261f2a <<glass::engine::Watch>::print_utf8+0x29a>
  261e55:	mov    0x38f19c(%rip),%rdx        # 5f0ff8 <_DYNAMIC+0x358>
  261e5c:	cmp    %r9,%rax
  261e5f:	jae    261e68 <<glass::engine::Watch>::print_utf8+0x1d8>
  261e61:	mov    0x38f198(%rip),%rdx        # 5f1000 <_DYNAMIC+0x360>
  261e68:	lock incq 0x28(%rdx)
  261e6d:	mov    0x38f164(%rip),%rdx        # 5f0fd8 <_DYNAMIC+0x338>
  261e74:	lock incq (%rdx)
  261e78:	mov    %r9,%rdx
  261e7b:	sub    0x68(%rsp),%rdx
  261e80:	jne    261edf <<glass::engine::Watch>::print_utf8+0x24f>
  261e82:	xor    %esi,%esi
  261e84:	jmp    261f1e <<glass::engine::Watch>::print_utf8+0x28e>
  261e89:	movl   $0x20,0x108(%rsp)
  261e94:	mov    0x78(%rsp),%eax
  261e98:	mov    %eax,0x100(%rsp)
  261e9f:	mov    0xa0(%rsp),%eax
  261ea6:	mov    %eax,0x104(%rsp)
  261ead:	mov    0xc(%rsp),%eax
  261eb1:	mov    %ax,0x10c(%rsp)
  261eb9:	movq   $0x0,0xf8(%rsp)
  261ec5:	lea    0x30(%rbp),%rax
  261ec9:	mov    %rax,0xd8(%rsp)
  261ed1:	movq   $0xffffffffffffffff,0x20(%rsp)
  261eda:	jmp    2620ba <<glass::engine::Watch>::print_utf8+0x42a>
  261edf:	mov    0x38f0fa(%rip),%rsi        # 5f0fe0 <_DYNAMIC+0x340>
  261ee6:	lock add %rdx,(%rsi)
  261eea:	cmp    $0x5,%rdx
  261eee:	jae    261efe <<glass::engine::Watch>::print_utf8+0x26e>
  261ef0:	lea    -0x20445f(%rip),%rsi        # 5da98 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  261ef7:	movzbl -0x1(%rdx,%rsi,1),%esi
  261efc:	jmp    261f1e <<glass::engine::Watch>::print_utf8+0x28e>
  261efe:	lea    -0x5(%rdx),%rdi
  261f02:	mov    $0x4,%esi
  261f07:	cmp    $0x4,%rdi
  261f0b:	jb     261f1e <<glass::engine::Watch>::print_utf8+0x28e>
  261f0d:	add    $0xfffffffffffffff7,%rdx
  261f11:	cmp    $0x8,%rdx
  261f15:	mov    $0x6,%esi
  261f1a:	sbb    $0x0,%rsi
  261f1e:	mov    0x38f0ab(%rip),%rdx        # 5f0fd0 <_DYNAMIC+0x330>
  261f25:	lock incq (%rdx,%rsi,8)
  261f2a:	cmp    %r9,%rax
  261f2d:	mov    %r8,0x58(%rsp)
  261f32:	jae    26207f <<glass::engine::Watch>::print_utf8+0x3ef>
  261f38:	mov    %rbx,0x98(%rsp)
  261f40:	mov    %r14,0x30(%rsp)
  261f45:	mov    0x20(%rbp),%r13d
  261f49:	mov    0x24(%rbp),%esi
  261f4c:	movzwl 0x2c(%rbp),%edi
  261f50:	mov    0x18(%rbp),%r12
  261f54:	test   %r12,%r12
  261f57:	je     261f64 <<glass::engine::Watch>::print_utf8+0x2d4>
  261f59:	lock incq (%r12)
  261f5e:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  261f64:	mov    %r10d,0x50(%rsp)
  261f69:	mov    %r13d,0x48(%rsp)
  261f6e:	mov    %esi,0x4c(%rsp)
  261f72:	mov    %di,0x54(%rsp)
  261f77:	mov    %r12,0x40(%rsp)
  261f7c:	mov    0x68(%rsp),%rax
  261f81:	lea    0x0(,%rax,8),%rax
  261f89:	lea    (%rax,%rax,2),%rax
  261f8d:	mov    %rbp,0xd0(%rsp)
  261f95:	mov    0x8(%rbp),%rbx
  261f99:	add    %rax,%rbx
  261f9c:	lea    0x0(,%r9,8),%rcx
  261fa4:	lea    (%rcx,%rcx,2),%rbp
  261fa8:	sub    %rax,%rbp
  261fab:	mov    %esi,0x70(%rsp)
  261faf:	mov    %di,0x90(%rsp)
  261fb7:	jmp    261fdc <<glass::engine::Watch>::print_utf8+0x34c>
  261fb9:	nopl   0x0(%rax)
  261fc0:	mov    %r12,(%rbx)
  261fc3:	mov    %r13d,0x8(%rbx)
  261fc7:	mov    %esi,0xc(%rbx)
  261fca:	mov    %r10d,0x10(%rbx)
  261fce:	mov    %di,0x14(%rbx)
  261fd2:	add    $0x18,%rbx
  261fd6:	add    $0xffffffffffffffe8,%rbp
  261fda:	je     262022 <<glass::engine::Watch>::print_utf8+0x392>
  261fdc:	test   %r12,%r12
  261fdf:	je     261fec <<glass::engine::Watch>::print_utf8+0x35c>
  261fe1:	lock incq (%r12)
  261fe6:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  261fec:	mov    (%rbx),%rax
  261fef:	test   %rax,%rax
  261ff2:	je     261fc0 <<glass::engine::Watch>::print_utf8+0x330>
  261ff4:	lock decq (%rax)
  261ff8:	jne    261fc0 <<glass::engine::Watch>::print_utf8+0x330>
  261ffa:	mov    %rbx,%rdi
  261ffd:	mov    %r9,%r14
  262000:	mov    %r10d,%r15d
  262003:	call   *0x38eeff(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  262009:	movzwl 0x90(%rsp),%edi
  262011:	mov    0x70(%rsp),%esi
  262015:	mov    %r15d,%r10d
  262018:	mov    %r14,%r9
  26201b:	mov    0x58(%rsp),%r8
  262020:	jmp    261fc0 <<glass::engine::Watch>::print_utf8+0x330>
  262022:	mov    0xd0(%rsp),%rbp
  26202a:	mov    0x68(%rsp),%rax
  26202f:	cmp    %eax,0x38(%rbp)
  262032:	jbe    262037 <<glass::engine::Watch>::print_utf8+0x3a7>
  262034:	mov    %eax,0x38(%rbp)
  262037:	test   %r12,%r12
  26203a:	mov    0xc0(%rsp),%r13
  262042:	mov    0xc8(%rsp),%r15
  26204a:	mov    0x30(%rsp),%r14
  26204f:	mov    0x98(%rsp),%rbx
  262057:	je     262076 <<glass::engine::Watch>::print_utf8+0x3e6>
  262059:	lock decq (%r12)
  26205e:	jne    262076 <<glass::engine::Watch>::print_utf8+0x3e6>
  262060:	lea    0x40(%rsp),%rdi
  262065:	mov    %r9,%r12
  262068:	call   *0x38ee9a(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  26206e:	mov    %r12,%r9
  262071:	mov    0x58(%rsp),%r8
  262076:	mov    0x10(%rbp),%rcx
  26207a:	mov    0x60(%rsp),%r12
  26207f:	lea    0x30(%rbp),%rax
  262083:	mov    %rax,0xd8(%rsp)
  26208b:	cmp    %rcx,%r9
  26208e:	jb     2620ba <<glass::engine::Watch>::print_utf8+0x42a>
  262090:	cmpl   $0xffffffff,0x28(%rbp)
  262094:	je     2620b3 <<glass::engine::Watch>::print_utf8+0x423>
  262096:	lea    0x18(%rbp),%rdi
  26209a:	mov    (%rdi),%rax
  26209d:	test   %rax,%rax
  2620a0:	je     2620b3 <<glass::engine::Watch>::print_utf8+0x423>
  2620a2:	lock decq (%rax)
  2620a6:	jne    2620b3 <<glass::engine::Watch>::print_utf8+0x423>
  2620a8:	call   *0x38ee5a(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  2620ae:	mov    0x58(%rsp),%r8
  2620b3:	movl   $0xffffffff,0x28(%rbp)
  2620ba:	mov    0x10(%rbp),%rdx
  2620be:	mov    0x30(%rbp),%rax
  2620c2:	cmp    %r12,%rdx
  2620c5:	mov    %r12,%rsi
  2620c8:	cmovb  %rdx,%rsi
  2620cc:	cmp    %rax,%rsi
  2620cf:	cmova  %rsi,%rax
  2620d3:	mov    %rdx,%rcx
  2620d6:	mov    %rax,0x30(%rbp)
  2620da:	sub    %r12,%rcx
  2620dd:	mov    %rcx,0x30(%rsp)
  2620e2:	jb     26362e <<glass::engine::Watch>::print_utf8+0x199e>
  2620e8:	mov    0x28(%rsp),%rdx
  2620ed:	cmp    %r13,%rdx
  2620f0:	jae    2626f0 <<glass::engine::Watch>::print_utf8+0xa60>
  2620f6:	mov    %rbx,0x98(%rsp)
  2620fe:	mov    %rbp,0xd0(%rsp)
  262106:	mov    0x8(%rbp),%rcx
  26210a:	lea    (%r12,%r12,2),%rax
  26210e:	mov    %rcx,0x70(%rsp)
  262113:	lea    (%rcx,%rax,8),%rax
  262117:	mov    %rax,0xb8(%rsp)
  26211f:	mov    0xc(%rsp),%eax
  262123:	mov    %eax,%ecx
  262125:	or     $0x20,%ecx
  262128:	mov    %ecx,0x8c(%rsp)
  26212f:	or     $0x40,%eax
  262132:	mov    %eax,0xa8(%rsp)
  262139:	mov    $0x1,%al
  26213b:	mov    %eax,0x90(%rsp)
  262142:	xor    %r11d,%r11d
  262145:	xor    %edi,%edi
  262147:	mov    %r12,%rbx
  26214a:	mov    %r12,%r10
  26214d:	mov    0x18(%rsp),%rsi
  262152:	jmp    2621bf <<glass::engine::Watch>::print_utf8+0x52f>
  262154:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  262160:	movq   $0x0,(%rbx)
  262167:	mov    0x78(%rsp),%eax
  26216b:	mov    %eax,0x8(%rbx)
  26216e:	mov    0xa0(%rsp),%eax
  262175:	mov    %eax,0xc(%rbx)
  262178:	movl   $0x20,0x10(%rbx)
  26217f:	mov    0xa8(%rsp),%eax
  262186:	mov    %ax,0x14(%rbx)
  26218a:	movl   $0x0,0x90(%rsp)
  262195:	xor    %r11d,%r11d
  262198:	cmp    0x38(%rsp),%r9
  26219d:	setae  %r11b
  2621a1:	mov    %r9,%r10
  2621a4:	sub    %r11,%r10
  2621a7:	inc    %rdi
  2621aa:	mov    %r9,%rbx
  2621ad:	add    %r15,%rdx
  2621b0:	mov    %ebp,%r8d
  2621b3:	mov    %r15,%r14
  2621b6:	cmp    %r13,%rdx
  2621b9:	jae    26270d <<glass::engine::Watch>::print_utf8+0xa7d>
  2621bf:	mov    %rdx,%r15
  2621c2:	movzbl (%rsi,%rdx,1),%ebp
  2621c6:	test   %bpl,%bpl
  2621c9:	js     2621f0 <<glass::engine::Watch>::print_utf8+0x560>
  2621cb:	mov    $0x1,%edx
  2621d0:	lea    -0x7f(%rbp),%eax
  2621d3:	cmp    $0x21,%eax
  2621d6:	jae    262358 <<glass::engine::Watch>::print_utf8+0x6c8>
  2621dc:	jmp    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  2621e1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2621f0:	lea    0x3e(%rbp),%eax
  2621f3:	cmp    $0x1e,%al
  2621f5:	jae    262220 <<glass::engine::Watch>::print_utf8+0x590>
  2621f7:	lea    0x1(%r15),%rax
  2621fb:	cmp    %r13,%rax
  2621fe:	jae    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262204:	movzbl (%rsi,%rax,1),%eax
  262208:	cmp    $0xc0,%al
  26220a:	jge    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262210:	and    $0x1f,%ebp
  262213:	shl    $0x6,%ebp
  262216:	mov    $0x2,%edx
  26221b:	jmp    26232b <<glass::engine::Watch>::print_utf8+0x69b>
  262220:	mov    %ebp,%eax
  262222:	and    $0xf0,%al
  262224:	cmp    $0xe0,%al
  262226:	jne    262240 <<glass::engine::Watch>::print_utf8+0x5b0>
  262228:	mov    $0xbf,%al
  26222a:	cmp    $0xe0,%ebp
  262230:	je     262263 <<glass::engine::Watch>::print_utf8+0x5d3>
  262232:	mov    $0x80,%cl
  262234:	cmp    $0xed,%ebp
  26223a:	jne    262265 <<glass::engine::Watch>::print_utf8+0x5d5>
  26223c:	mov    $0x9f,%al
  26223e:	jmp    262265 <<glass::engine::Watch>::print_utf8+0x5d5>
  262240:	lea    0x10(%rbp),%eax
  262243:	cmp    $0x5,%al
  262245:	jae    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  26224b:	mov    $0x80,%al
  26224d:	cmp    $0xf4,%ebp
  262253:	je     2622b7 <<glass::engine::Watch>::print_utf8+0x627>
  262255:	mov    $0xbf,%cl
  262257:	cmp    $0xf0,%ebp
  26225d:	jne    2622b9 <<glass::engine::Watch>::print_utf8+0x629>
  26225f:	mov    $0x90,%al
  262261:	jmp    2622b9 <<glass::engine::Watch>::print_utf8+0x629>
  262263:	mov    $0xa0,%cl
  262265:	lea    0x1(%r15),%rdx
  262269:	cmp    %r13,%rdx
  26226c:	jae    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262272:	movzbl (%rsi,%rdx,1),%edx
  262276:	cmp    %dl,%cl
  262278:	ja     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  26227e:	cmp    %al,%dl
  262280:	ja     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262286:	lea    0x2(%r15),%rax
  26228a:	cmp    %r13,%rax
  26228d:	jae    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262293:	movzbl (%rsi,%rax,1),%eax
  262297:	cmp    $0xc0,%al
  262299:	jge    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  26229f:	movzbl %dl,%ecx
  2622a2:	and    $0x3f,%ecx
  2622a5:	shl    $0x6,%ecx
  2622a8:	and    $0xf,%ebp
  2622ab:	shl    $0xc,%ebp
  2622ae:	or     %ecx,%ebp
  2622b0:	mov    $0x3,%edx
  2622b5:	jmp    26232b <<glass::engine::Watch>::print_utf8+0x69b>
  2622b7:	mov    $0x8f,%cl
  2622b9:	lea    0x1(%r15),%rdx
  2622bd:	cmp    %r13,%rdx
  2622c0:	jae    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  2622c6:	movzbl (%rsi,%rdx,1),%edx
  2622ca:	cmp    %dl,%al
  2622cc:	ja     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  2622d2:	cmp    %cl,%dl
  2622d4:	ja     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  2622da:	lea    0x2(%r15),%rax
  2622de:	cmp    %r13,%rax
  2622e1:	jae    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  2622e7:	movzbl (%rsi,%rax,1),%ecx
  2622eb:	cmp    $0xbf,%cl
  2622ee:	jg     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  2622f4:	lea    0x3(%r15),%rax
  2622f8:	cmp    %r13,%rax
  2622fb:	jae    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262301:	movzbl (%rsi,%rax,1),%eax
  262305:	cmp    $0xbf,%al
  262307:	jg     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  26230d:	movzbl %dl,%edx
  262310:	and    $0x3f,%ecx
  262313:	shl    $0x6,%ecx
  262316:	and    $0x3f,%edx
  262319:	shl    $0xc,%edx
  26231c:	and    $0x7,%ebp
  26231f:	shl    $0x12,%ebp
  262322:	or     %edx,%ebp
  262324:	or     %ecx,%ebp
  262326:	mov    $0x4,%edx
  26232b:	mov    %ebp,%ecx
  26232d:	xor    $0xd800,%ecx
  262333:	add    $0xffef0000,%ecx
  262339:	cmp    $0xffef0800,%ecx
  26233f:	jb     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262345:	and    $0x3f,%al
  262347:	movzbl %al,%eax
  26234a:	or     %eax,%ebp
  26234c:	lea    -0x7f(%rbp),%eax
  26234f:	cmp    $0x21,%eax
  262352:	jb     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262358:	cmp    $0xffffffff,%r8d
  26235c:	je     262380 <<glass::engine::Watch>::print_utf8+0x6f0>
  26235e:	lea    -0x20(%r8),%eax
  262362:	cmp    $0x5f,%eax
  262365:	jae    262390 <<glass::engine::Watch>::print_utf8+0x700>
  262367:	mov    $0x1,%ecx
  26236c:	cmpb   $0x0,0x10(%rsp)
  262371:	jne    26248b <<glass::engine::Watch>::print_utf8+0x7fb>
  262377:	jmp    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  26237c:	nopl   0x0(%rax)
  262380:	mov    %rbx,%r9
  262383:	jmp    2621ad <<glass::engine::Watch>::print_utf8+0x51d>
  262388:	nopl   0x0(%rax,%rax,1)
  262390:	mov    %rbx,0x68(%rsp)
  262395:	mov    0x391add(%rip),%eax        # 5f3e78 <glass::engine::width_of::CACHE+0x10>
  26239b:	test   %eax,%eax
  26239d:	jne    26267e <<glass::engine::Watch>::print_utf8+0x9ee>
  2623a3:	mov    %r8d,%ebx
  2623a6:	mov    0x391ac3(%rip),%rsi        # 5f3e70 <glass::engine::width_of::CACHE+0x8>
  2623ad:	cmp    %rbx,%rsi
  2623b0:	jbe    263c68 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2623b6:	mov    0x391aab(%rip),%r12        # 5f3e68 <glass::engine::width_of::CACHE>
  2623bd:	movzbl (%r12,%rbx,1),%eax
  2623c2:	movzbl %al,%ecx
  2623c5:	test   %cl,%cl
  2623c7:	mov    %rdx,0x28(%rsp)
  2623cc:	js     2623e7 <<glass::engine::Watch>::print_utf8+0x757>
  2623ce:	mov    $0x1,%dl
  2623d0:	mov    0x18(%rsp),%rsi
  2623d5:	test   %dl,%dl
  2623d7:	mov    0x68(%rsp),%rbx
  2623dc:	jne    262473 <<glass::engine::Watch>::print_utf8+0x7e3>
  2623e2:	jmp    26276d <<glass::engine::Watch>::print_utf8+0xadd>
  2623e7:	cmp    $0xfe,%ecx
  2623ed:	mov    0x18(%rsp),%rsi
  2623f2:	je     26278d <<glass::engine::Watch>::print_utf8+0xafd>
  2623f8:	mov    $0xfe,%al
  2623fa:	cmp    $0x7f,%r8d
  2623fe:	jae    262409 <<glass::engine::Watch>::print_utf8+0x779>
  262400:	mov    $0x1,%ecx
  262405:	xor    %edx,%edx
  262407:	jmp    262462 <<glass::engine::Watch>::print_utf8+0x7d2>
  262409:	cmp    $0xa0,%r8d
  262410:	jb     262460 <<glass::engine::Watch>::print_utf8+0x7d0>
  262412:	mov    %rdi,0xb0(%rsp)
  26241a:	mov    %r8d,%edi
  26241d:	mov    %r8,0x58(%rsp)
  262422:	mov    %r10,0xe8(%rsp)
  26242a:	mov    %r11,0xe0(%rsp)
  262432:	call   297d70 <unicode_width::tables::lookup_width>
  262437:	mov    0xe0(%rsp),%r11
  26243f:	mov    0xe8(%rsp),%r10
  262447:	mov    0xb0(%rsp),%rdi
  26244f:	mov    0x58(%rsp),%r8
  262454:	mov    0x18(%rsp),%rsi
  262459:	movzbl %al,%ecx
  26245c:	mov    $0x1,%dl
  26245e:	jmp    262462 <<glass::engine::Watch>::print_utf8+0x7d2>
  262460:	xor    %edx,%edx
  262462:	mov    %al,(%r12,%rbx,1)
  262466:	test   %dl,%dl
  262468:	mov    0x68(%rsp),%rbx
  26246d:	je     26276d <<glass::engine::Watch>::print_utf8+0xadd>
  262473:	lea    -0x1(%rcx),%rax
  262477:	cmp    $0x1,%rax
  26247b:	mov    0x28(%rsp),%rdx
  262480:	mov    0x60(%rsp),%r12
  262485:	ja     262704 <<glass::engine::Watch>::print_utf8+0xa74>
  26248b:	test   $0x1,%r11b
  26248f:	jne    2626fc <<glass::engine::Watch>::print_utf8+0xa6c>
  262495:	lea    (%rcx,%r10,1),%rax
  262499:	cmp    0x38(%rsp),%rax
  26249e:	ja     262701 <<glass::engine::Watch>::print_utf8+0xa71>
  2624a4:	mov    %rax,0x58(%rsp)
  2624a9:	mov    %rbx,%r9
  2624ac:	mov    %r10,%rbx
  2624af:	sub    %r12,%rbx
  2624b2:	cmp    0x20(%rsp),%r10
  2624b7:	jae    262520 <<glass::engine::Watch>::print_utf8+0x890>
  2624b9:	cmp    0x30(%rsp),%rbx
  2624be:	mov    0x70(%rsp),%r11
  2624c3:	jae    263cb1 <<glass::engine::Watch>::print_utf8+0x2021>
  2624c9:	lea    (%r10,%r10,2),%rax
  2624cd:	testb  $0x60,0x14(%r11,%rax,8)
  2624d3:	jne    262768 <<glass::engine::Watch>::print_utf8+0xad8>
  2624d9:	lea    (%r11,%rax,8),%r12
  2624dd:	cmp    $0x2,%rcx
  2624e1:	jne    2625b2 <<glass::engine::Watch>::print_utf8+0x922>
  2624e7:	lea    0x1(%rbx),%rax
  2624eb:	cmp    0x30(%rsp),%rax
  2624f0:	jae    263ccf <<glass::engine::Watch>::print_utf8+0x203f>
  2624f6:	mov    %r14,%rcx
  2624f9:	lea    (%rax,%rax,2),%rax
  2624fd:	mov    $0x1,%r14b
  262500:	mov    0xb8(%rsp),%r13
  262508:	testb  $0x60,0x14(%r13,%rax,8)
  26250e:	mov    0x8c(%rsp),%r13d
  262516:	je     26254e <<glass::engine::Watch>::print_utf8+0x8be>
  262518:	jmp    262772 <<glass::engine::Watch>::print_utf8+0xae2>
  26251d:	nopl   (%rax)
  262520:	cmp    0x30(%rsp),%rbx
  262525:	mov    0x70(%rsp),%r11
  26252a:	jae    263ce1 <<glass::engine::Watch>::print_utf8+0x2051>
  262530:	lea    (%r10,%r10,2),%rax
  262534:	lea    (%r11,%rax,8),%r12
  262538:	cmp    $0x2,%rcx
  26253c:	sete   %r14b
  262540:	mov    0xc(%rsp),%r13d
  262545:	cmove  0x8c(%rsp),%r13d
  26254e:	mov    (%r12),%rax
  262552:	test   %rax,%rax
  262555:	je     2625d0 <<glass::engine::Watch>::print_utf8+0x940>
  262557:	lock decq (%rax)
  26255b:	jne    2625d0 <<glass::engine::Watch>::print_utf8+0x940>
  26255d:	mov    %rdi,0xb0(%rsp)
  262565:	mov    %r12,%rdi
  262568:	mov    %r15,0xe0(%rsp)
  262570:	mov    %r8,%r15
  262573:	mov    %rdx,0x28(%rsp)
  262578:	mov    %r10,0xe8(%rsp)
  262580:	call   *0x38e982(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  262586:	mov    0x70(%rsp),%r11
  26258b:	mov    0xe8(%rsp),%r10
  262593:	mov    0xb0(%rsp),%rdi
  26259b:	mov    0x28(%rsp),%rdx
  2625a0:	mov    %r15,%r8
  2625a3:	mov    0xe0(%rsp),%r15
  2625ab:	mov    0x18(%rsp),%rsi
  2625b0:	jmp    2625d0 <<glass::engine::Watch>::print_utf8+0x940>
  2625b2:	xor    %r14d,%r14d
  2625b5:	mov    0xc(%rsp),%r13d
  2625ba:	mov    (%r12),%rax
  2625be:	test   %rax,%rax
  2625c1:	jne    262557 <<glass::engine::Watch>::print_utf8+0x8c7>
  2625c3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2625d0:	lea    (%r10,%r10,2),%rax
  2625d4:	movq   $0x0,(%r12)
  2625dc:	mov    0x78(%rsp),%ecx
  2625e0:	mov    %ecx,0x8(%r11,%rax,8)
  2625e5:	mov    0xa0(%rsp),%ecx
  2625ec:	mov    %ecx,0xc(%r11,%rax,8)
  2625f1:	mov    %r13w,0x14(%r11,%rax,8)
  2625f7:	mov    %r8d,0x10(%r11,%rax,8)
  2625fc:	test   %r14b,%r14b
  2625ff:	mov    0xc0(%rsp),%r13
  262607:	mov    0x60(%rsp),%r12
  26260c:	mov    0x58(%rsp),%r9
  262611:	je     262195 <<glass::engine::Watch>::print_utf8+0x505>
  262617:	inc    %rbx
  26261a:	cmp    0x30(%rsp),%rbx
  26261f:	jae    263cba <<glass::engine::Watch>::print_utf8+0x202a>
  262625:	lea    (%rbx,%rbx,2),%rax
  262629:	mov    0xb8(%rsp),%rcx
  262631:	lea    (%rcx,%rax,8),%rbx
  262635:	mov    (%rcx,%rax,8),%rax
  262639:	test   %rax,%rax
  26263c:	je     262160 <<glass::engine::Watch>::print_utf8+0x4d0>
  262642:	lock decq (%rax)
  262646:	jne    262160 <<glass::engine::Watch>::print_utf8+0x4d0>
  26264c:	mov    %r15,%r13
  26264f:	mov    %rdi,%r15
  262652:	mov    %rbx,%rdi
  262655:	mov    %rdx,%r14
  262658:	call   *0x38e8aa(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  26265e:	mov    0x58(%rsp),%r9
  262663:	mov    %r15,%rdi
  262666:	mov    %r13,%r15
  262669:	mov    0xc0(%rsp),%r13
  262671:	mov    %r14,%rdx
  262674:	mov    0x18(%rsp),%rsi
  262679:	jmp    262160 <<glass::engine::Watch>::print_utf8+0x4d0>
  26267e:	mov    %r8,0x58(%rsp)
  262683:	mov    %r15,0xe0(%rsp)
  26268b:	mov    %rdx,%r15
  26268e:	mov    %rdi,0xb0(%rsp)
  262696:	mov    %r10,0xe8(%rsp)
  26269e:	mov    %r11,%r12
  2626a1:	call   18b862 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2626a6:	mov    %r12,%r11
  2626a9:	mov    0xe8(%rsp),%r10
  2626b1:	mov    0xb0(%rsp),%rdi
  2626b9:	mov    %r15,%rdx
  2626bc:	mov    0xe0(%rsp),%r15
  2626c4:	mov    0x58(%rsp),%r8
  2626c9:	mov    %r8d,%ebx
  2626cc:	mov    0x39179d(%rip),%rsi        # 5f3e70 <glass::engine::width_of::CACHE+0x8>
  2626d3:	cmp    %rbx,%rsi
  2626d6:	ja     2623b6 <<glass::engine::Watch>::print_utf8+0x726>
  2626dc:	jmp    263c68 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2626e1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2626f0:	xor    %edi,%edi
  2626f2:	xor    %r11d,%r11d
  2626f5:	mov    0x18(%rsp),%rsi
  2626fa:	jmp    262754 <<glass::engine::Watch>::print_utf8+0xac4>
  2626fc:	mov    $0x1,%r11b
  2626ff:	jmp    262704 <<glass::engine::Watch>::print_utf8+0xa74>
  262701:	xor    %r11d,%r11d
  262704:	mov    %rbx,%r9
  262707:	mov    %r8d,%ebp
  26270a:	mov    %r15,%rdx
  26270d:	cmp    %r12,%r9
  262710:	jbe    262727 <<glass::engine::Watch>::print_utf8+0xa97>
  262712:	mov    0xd8(%rsp),%rcx
  26271a:	mov    (%rcx),%rax
  26271d:	cmp    %rax,%r9
  262720:	cmova  %r9,%rax
  262724:	mov    %rax,(%rcx)
  262727:	cmp    $0x8,%rdi
  26272b:	setae  %al
  26272e:	testb  $0x1,0x90(%rsp)
  262736:	mov    0xc8(%rsp),%r15
  26273e:	jne    262742 <<glass::engine::Watch>::print_utf8+0xab2>
  262740:	xor    %eax,%eax
  262742:	test   %al,%al
  262744:	jne    2627a2 <<glass::engine::Watch>::print_utf8+0xb12>
  262746:	mov    %r10,%r12
  262749:	mov    %ebp,%r8d
  26274c:	mov    0x98(%rsp),%rbx
  262754:	mov    %r12,0x40(%rbx)
  262758:	mov    %r11b,0x6c(%rbx)
  26275c:	add    %rdi,0xa0(%r15)
  262763:	jmp    262829 <<glass::engine::Watch>::print_utf8+0xb99>
  262768:	xor    %r11d,%r11d
  26276b:	jmp    262707 <<glass::engine::Watch>::print_utf8+0xa77>
  26276d:	mov    %rbx,%r9
  262770:	jmp    262792 <<glass::engine::Watch>::print_utf8+0xb02>
  262772:	xor    %r11d,%r11d
  262775:	mov    %r8d,%ebp
  262778:	mov    %r15,%rdx
  26277b:	mov    0xc0(%rsp),%r13
  262783:	mov    %rcx,%r14
  262786:	mov    0x60(%rsp),%r12
  26278b:	jmp    26270d <<glass::engine::Watch>::print_utf8+0xa7d>
  26278d:	mov    0x68(%rsp),%r9
  262792:	mov    %r8d,%ebp
  262795:	mov    %r15,%rdx
  262798:	mov    0x60(%rsp),%r12
  26279d:	jmp    26270d <<glass::engine::Watch>::print_utf8+0xa7d>
  2627a2:	mov    %rdx,0x28(%rsp)
  2627a7:	movzbl %r11b,%edx
  2627ab:	add    %r10,%rdx
  2627ae:	mov    %rdi,0xb0(%rsp)
  2627b6:	mov    0xd0(%rsp),%rdi
  2627be:	mov    %r12,%rsi
  2627c1:	lea    0xf8(%rsp),%rcx
  2627c9:	mov    %r10,%r12
  2627cc:	mov    %r11,%rbx
  2627cf:	call   2a0bd0 <glass::engine::note_uniform_span>
  2627d4:	mov    %rbx,%r11
  2627d7:	mov    0xb0(%rsp),%rdi
  2627df:	mov    0x28(%rsp),%rdx
  2627e4:	mov    0x18(%rsp),%rsi
  2627e9:	jmp    262749 <<glass::engine::Watch>::print_utf8+0xab9>
  2627ee:	xchg   %ax,%ax
  2627f0:	mov    0xc8(%rsp),%r15
  2627f8:	mov    %r15,%rdi
  2627fb:	mov    %ebp,%esi
  2627fd:	mov    %r8,%rbx
  262800:	mov    %rdx,%r14
  262803:	call   33c8d0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  262808:	mov    %r14,%rdx
  26280b:	mov    %rbx,%r8
  26280e:	mov    0x18(%rsp),%rsi
  262813:	mov    0x30(%rsp),%r14
  262818:	add    %r14,%rdx
  26281b:	cmpb   $0x0,0x80(%rsp)
  262823:	jne    261d40 <<glass::engine::Watch>::print_utf8+0xb0>
  262829:	mov    %r8d,%ebp
  26282c:	mov    %r14,%rbx
  26282f:	mov    %rdx,%r14
  262832:	cmp    %r13,%rdx
  262835:	jae    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  26283b:	movzbl (%rsi,%r14,1),%r8d
  262840:	test   %r8b,%r8b
  262843:	js     262860 <<glass::engine::Watch>::print_utf8+0xbd0>
  262845:	mov    $0x1,%edx
  26284a:	lea    -0x7f(%r8),%eax
  26284e:	cmp    $0x21,%eax
  262851:	jae    2629e8 <<glass::engine::Watch>::print_utf8+0xd58>
  262857:	jmp    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  26285c:	nopl   0x0(%rax)
  262860:	lea    0x3e(%r8),%eax
  262864:	cmp    $0x1e,%al
  262866:	jae    2628a0 <<glass::engine::Watch>::print_utf8+0xc10>
  262868:	lea    0x1(%r14),%rax
  26286c:	cmp    %r13,%rax
  26286f:	jae    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  262875:	movzbl (%rsi,%rax,1),%eax
  262879:	cmp    $0xc0,%al
  26287b:	jge    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  262881:	and    $0x1f,%r8d
  262885:	shl    $0x6,%r8d
  262889:	mov    $0x2,%edx
  26288e:	jmp    2629b8 <<glass::engine::Watch>::print_utf8+0xd28>
  262893:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2628a0:	mov    %r8d,%eax
  2628a3:	and    $0xf0,%al
  2628a5:	cmp    $0xe0,%al
  2628a7:	jne    2628c3 <<glass::engine::Watch>::print_utf8+0xc33>
  2628a9:	mov    $0xbf,%al
  2628ab:	cmp    $0xe0,%r8d
  2628b2:	je     2628e9 <<glass::engine::Watch>::print_utf8+0xc59>
  2628b4:	mov    $0x80,%cl
  2628b6:	cmp    $0xed,%r8d
  2628bd:	jne    2628eb <<glass::engine::Watch>::print_utf8+0xc5b>
  2628bf:	mov    $0x9f,%al
  2628c1:	jmp    2628eb <<glass::engine::Watch>::print_utf8+0xc5b>
  2628c3:	lea    0x10(%r8),%eax
  2628c7:	cmp    $0x5,%al
  2628c9:	jae    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  2628cf:	mov    $0x80,%al
  2628d1:	cmp    $0xf4,%r8d
  2628d8:	je     262940 <<glass::engine::Watch>::print_utf8+0xcb0>
  2628da:	mov    $0xbf,%cl
  2628dc:	cmp    $0xf0,%r8d
  2628e3:	jne    262942 <<glass::engine::Watch>::print_utf8+0xcb2>
  2628e5:	mov    $0x90,%al
  2628e7:	jmp    262942 <<glass::engine::Watch>::print_utf8+0xcb2>
  2628e9:	mov    $0xa0,%cl
  2628eb:	lea    0x1(%r14),%rdx
  2628ef:	cmp    %r13,%rdx
  2628f2:	jae    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  2628f8:	movzbl (%rsi,%rdx,1),%edx
  2628fc:	cmp    %dl,%cl
  2628fe:	ja     26330e <<glass::engine::Watch>::print_utf8+0x167e>
  262904:	cmp    %al,%dl
  262906:	ja     26330e <<glass::engine::Watch>::print_utf8+0x167e>
  26290c:	lea    0x2(%r14),%rax
  262910:	cmp    %r13,%rax
  262913:	jae    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  262919:	movzbl (%rsi,%rax,1),%eax
  26291d:	cmp    $0xc0,%al
  26291f:	jge    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  262925:	movzbl %dl,%ecx
  262928:	and    $0x3f,%ecx
  26292b:	shl    $0x6,%ecx
  26292e:	and    $0xf,%r8d
  262932:	shl    $0xc,%r8d
  262936:	or     %ecx,%r8d
  262939:	mov    $0x3,%edx
  26293e:	jmp    2629b8 <<glass::engine::Watch>::print_utf8+0xd28>
  262940:	mov    $0x8f,%cl
  262942:	lea    0x1(%r14),%rdx
  262946:	cmp    %r13,%rdx
  262949:	jae    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  26294f:	movzbl (%rsi,%rdx,1),%edx
  262953:	cmp    %dl,%al
  262955:	ja     26330e <<glass::engine::Watch>::print_utf8+0x167e>
  26295b:	cmp    %cl,%dl
  26295d:	ja     26330e <<glass::engine::Watch>::print_utf8+0x167e>
  262963:	lea    0x2(%r14),%rax
  262967:	cmp    %r13,%rax
  26296a:	jae    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  262970:	movzbl (%rsi,%rax,1),%ecx
  262974:	cmp    $0xbf,%cl
  262977:	jg     26330e <<glass::engine::Watch>::print_utf8+0x167e>
  26297d:	lea    0x3(%r14),%rax
  262981:	cmp    %r13,%rax
  262984:	jae    26330e <<glass::engine::Watch>::print_utf8+0x167e>
  26298a:	movzbl (%rsi,%rax,1),%eax
  26298e:	cmp    $0xbf,%al
  262990:	jg     26330e <<glass::engine::Watch>::print_utf8+0x167e>
  262996:	movzbl %dl,%edx
  262999:	and    $0x3f,%ecx
  26299c:	shl    $0x6,%ecx
  26299f:	and    $0x3f,%edx
  2629a2:	shl    $0xc,%edx
  2629a5:	and    $0x7,%r8d
  2629a9:	shl    $0x12,%r8d
  2629ad:	or     %edx,%r8d
  2629b0:	or     %ecx,%r8d
  2629b3:	mov    $0x4,%edx
  2629b8:	mov    %r8d,%ecx
  2629bb:	xor    $0xd800,%ecx
  2629c1:	add    $0xffef0000,%ecx
  2629c7:	cmp    $0xffef0800,%ecx
  2629cd:	jb     26330e <<glass::engine::Watch>::print_utf8+0x167e>
  2629d3:	and    $0x3f,%al
  2629d5:	movzbl %al,%eax
  2629d8:	or     %eax,%r8d
  2629db:	lea    -0x7f(%r8),%eax
  2629df:	cmp    $0x21,%eax
  2629e2:	jb     26330e <<glass::engine::Watch>::print_utf8+0x167e>
  2629e8:	cmp    $0xffffffff,%ebp
  2629eb:	je     2632d0 <<glass::engine::Watch>::print_utf8+0x1640>
  2629f1:	mov    %r14,0x30(%rsp)
  2629f6:	lea    -0x20(%rbp),%eax
  2629f9:	cmp    $0x5f,%eax
  2629fc:	jae    262a20 <<glass::engine::Watch>::print_utf8+0xd90>
  2629fe:	mov    $0x1,%r12d
  262a04:	cmpb   $0x0,0x10(%rsp)
  262a09:	je     2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262a0f:	jmp    262acc <<glass::engine::Watch>::print_utf8+0xe3c>
  262a14:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  262a20:	cmpb   $0x0,0x80(%rsp)
  262a28:	je     2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262a2e:	mov    0x391444(%rip),%eax        # 5f3e78 <glass::engine::width_of::CACHE+0x10>
  262a34:	test   %eax,%eax
  262a36:	jne    2632e6 <<glass::engine::Watch>::print_utf8+0x1656>
  262a3c:	mov    %ebp,%ebx
  262a3e:	mov    0x39142b(%rip),%rsi        # 5f3e70 <glass::engine::width_of::CACHE+0x8>
  262a45:	cmp    %rbx,%rsi
  262a48:	jbe    263c68 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262a4e:	mov    0x391413(%rip),%r14        # 5f3e68 <glass::engine::width_of::CACHE>
  262a55:	movzbl (%r14,%rbx,1),%eax
  262a5a:	movzbl %al,%r12d
  262a5e:	test   %r12b,%r12b
  262a61:	js     262a6e <<glass::engine::Watch>::print_utf8+0xdde>
  262a63:	mov    $0x1,%cl
  262a65:	test   %cl,%cl
  262a67:	jne    262abd <<glass::engine::Watch>::print_utf8+0xe2d>
  262a69:	jmp    2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262a6e:	cmp    $0xfe,%r12d
  262a75:	je     2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262a7b:	mov    $0xfe,%al
  262a7d:	cmp    $0x7f,%ebp
  262a80:	jae    262a8c <<glass::engine::Watch>::print_utf8+0xdfc>
  262a82:	mov    $0x1,%r12d
  262a88:	xor    %ecx,%ecx
  262a8a:	jmp    262ab1 <<glass::engine::Watch>::print_utf8+0xe21>
  262a8c:	cmp    $0xa0,%ebp
  262a92:	jb     262aaf <<glass::engine::Watch>::print_utf8+0xe1f>
  262a94:	mov    %ebp,%edi
  262a96:	mov    %r8,%r15
  262a99:	mov    %rdx,%r12
  262a9c:	call   297d70 <unicode_width::tables::lookup_width>
  262aa1:	mov    %r12,%rdx
  262aa4:	mov    %r15,%r8
  262aa7:	movzbl %al,%r12d
  262aab:	mov    $0x1,%cl
  262aad:	jmp    262ab1 <<glass::engine::Watch>::print_utf8+0xe21>
  262aaf:	xor    %ecx,%ecx
  262ab1:	mov    %al,(%r14,%rbx,1)
  262ab5:	test   %cl,%cl
  262ab7:	je     2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262abd:	lea    -0x1(%r12),%rax
  262ac2:	cmp    $0x1,%rax
  262ac6:	ja     2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262acc:	mov    0xc8(%rsp),%rax
  262ad4:	mov    0x78(%rax),%r9
  262ad8:	cmpb   $0x0,0x6c(%r9)
  262add:	jne    2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262ae3:	mov    0x40(%r9),%rbx
  262ae7:	mov    0xa0(%r9),%r11
  262aee:	lea    (%rbx,%r12,1),%r10
  262af2:	cmp    %r11,%r10
  262af5:	ja     2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262afb:	mov    0x30(%r9),%eax
  262aff:	sub    0x48(%r9),%eax
  262b03:	cltq
  262b05:	mov    0x20(%r9),%rsi
  262b09:	mov    0x28(%r9),%rcx
  262b0d:	lea    (%rcx,%rax,1),%rdi
  262b11:	dec    %rdi
  262b14:	cmp    %rsi,%rdi
  262b17:	mov    $0x0,%eax
  262b1c:	cmovae %rsi,%rax
  262b20:	sub    %rax,%rdi
  262b23:	cmp    %rsi,%rdi
  262b26:	jae    263d0b <<glass::engine::Watch>::print_utf8+0x207b>
  262b2c:	mov    0x58(%r9),%eax
  262b30:	mov    %eax,0x58(%rsp)
  262b34:	mov    0x5c(%r9),%eax
  262b38:	mov    %eax,0xa0(%rsp)
  262b3f:	movzwl 0x64(%r9),%r14d
  262b44:	mov    0x18(%r9),%rax
  262b48:	shl    $0x6,%rdi
  262b4c:	lea    (%rax,%rdi,1),%r15
  262b50:	lea    (%rax,%rdi,1),%rcx
  262b54:	add    $0x18,%rcx
  262b58:	mov    %rcx,0x78(%rsp)
  262b5d:	mov    0x28(%rax,%rdi,1),%eax
  262b61:	cmp    $0xffffffff,%eax
  262b64:	je     262b71 <<glass::engine::Watch>::print_utf8+0xee1>
  262b66:	mov    0x78(%rsp),%rcx
  262b6b:	cmp    0x30(%r15),%rbx
  262b6f:	jae    262b8a <<glass::engine::Watch>::print_utf8+0xefa>
  262b71:	mov    0x10(%r15),%rsi
  262b75:	cmp    %rsi,%rbx
  262b78:	jae    263d18 <<glass::engine::Watch>::print_utf8+0x2088>
  262b7e:	lea    (%rbx,%rbx,2),%rcx
  262b82:	shl    $0x3,%rcx
  262b86:	add    0x8(%r15),%rcx
  262b8a:	testb  $0x60,0x14(%rcx)
  262b8e:	jne    2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262b94:	cmp    $0x2,%r12
  262b98:	jne    262bd1 <<glass::engine::Watch>::print_utf8+0xf41>
  262b9a:	lea    0x1(%rbx),%rdi
  262b9e:	cmp    $0xffffffff,%eax
  262ba1:	je     262bae <<glass::engine::Watch>::print_utf8+0xf1e>
  262ba3:	mov    0x78(%rsp),%rcx
  262ba8:	cmp    0x30(%r15),%rdi
  262bac:	jae    262bc7 <<glass::engine::Watch>::print_utf8+0xf37>
  262bae:	mov    0x10(%r15),%rsi
  262bb2:	cmp    %rsi,%rdi
  262bb5:	jae    263d3c <<glass::engine::Watch>::print_utf8+0x20ac>
  262bbb:	lea    (%rdi,%rdi,2),%rcx
  262bbf:	shl    $0x3,%rcx
  262bc3:	add    0x8(%r15),%rcx
  262bc7:	testb  $0x60,0x14(%rcx)
  262bcb:	jne    2627f0 <<glass::engine::Watch>::print_utf8+0xb60>
  262bd1:	mov    %rdx,0x28(%rsp)
  262bd6:	cmp    %ebx,0x38(%r15)
  262bda:	jbe    262be0 <<glass::engine::Watch>::print_utf8+0xf50>
  262bdc:	mov    %ebx,0x38(%r15)
  262be0:	mov    %r14d,0xc(%rsp)
  262be5:	mov    %r11,0x90(%rsp)
  262bed:	cmp    $0xffffffff,%eax
  262bf0:	setne  %dl
  262bf3:	mov    0x30(%r15),%rcx
  262bf7:	cmp    %rcx,%rbx
  262bfa:	sete   %sil
  262bfe:	test   %sil,%dl
  262c01:	mov    %rbx,0x20(%rsp)
  262c06:	mov    %r15,0x38(%rsp)
  262c0b:	mov    %r9,0x60(%rsp)
  262c10:	mov    %r10,0x70(%rsp)
  262c15:	jne    262c8e <<glass::engine::Watch>::print_utf8+0xffe>
  262c17:	cmp    $0xffffffff,%eax
  262c1a:	mov    0x30(%rsp),%r14
  262c1f:	je     262edd <<glass::engine::Watch>::print_utf8+0x124d>
  262c25:	mov    0x10(%r15),%rax
  262c29:	cmp    %rcx,%rax
  262c2c:	mov    %rcx,%rdx
  262c2f:	cmovb  %rax,%rdx
  262c33:	mov    %rdx,0xa8(%rsp)
  262c3b:	cmp    %rbx,%rax
  262c3e:	mov    %rbx,%rsi
  262c41:	cmovb  %rax,%rsi
  262c45:	mov    0x38e374(%rip),%rdx        # 5f0fc0 <_DYNAMIC+0x320>
  262c4c:	movzbl (%rdx),%edx
  262c4f:	test   %dl,%dl
  262c51:	je     262cfb <<glass::engine::Watch>::print_utf8+0x106b>
  262c57:	mov    0x38e39a(%rip),%rdx        # 5f0ff8 <_DYNAMIC+0x358>
  262c5e:	mov    %rsi,%r11
  262c61:	cmp    %rsi,%rcx
  262c64:	jae    262c6d <<glass::engine::Watch>::print_utf8+0xfdd>
  262c66:	mov    0x38e393(%rip),%rdx        # 5f1000 <_DYNAMIC+0x360>
  262c6d:	lock incq 0x28(%rdx)
  262c72:	mov    0x38e35f(%rip),%rdx        # 5f0fd8 <_DYNAMIC+0x338>
  262c79:	lock incq (%rdx)
  262c7d:	mov    %r11,%rdx
  262c80:	sub    0xa8(%rsp),%rdx
  262c88:	jne    262cad <<glass::engine::Watch>::print_utf8+0x101d>
  262c8a:	xor    %esi,%esi
  262c8c:	jmp    262cec <<glass::engine::Watch>::print_utf8+0x105c>
  262c8e:	lea    0x1(%rbx),%rax
  262c92:	mov    %rax,0x30(%r15)
  262c96:	mov    0x10(%r15),%rsi
  262c9a:	cmp    %rsi,%rbx
  262c9d:	mov    0x30(%rsp),%r14
  262ca2:	jb     262efd <<glass::engine::Watch>::print_utf8+0x126d>
  262ca8:	jmp    263d49 <<glass::engine::Watch>::print_utf8+0x20b9>
  262cad:	mov    0x38e32c(%rip),%rsi        # 5f0fe0 <_DYNAMIC+0x340>
  262cb4:	lock add %rdx,(%rsi)
  262cb8:	cmp    $0x5,%rdx
  262cbc:	jae    262ccc <<glass::engine::Watch>::print_utf8+0x103c>
  262cbe:	lea    -0x20522d(%rip),%rsi        # 5da98 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  262cc5:	movzbl -0x1(%rdx,%rsi,1),%esi
  262cca:	jmp    262cec <<glass::engine::Watch>::print_utf8+0x105c>
  262ccc:	lea    -0x5(%rdx),%rdi
  262cd0:	mov    $0x4,%esi
  262cd5:	cmp    $0x4,%rdi
  262cd9:	jb     262cec <<glass::engine::Watch>::print_utf8+0x105c>
  262cdb:	add    $0xfffffffffffffff7,%rdx
  262cdf:	cmp    $0x8,%rdx
  262ce3:	mov    $0x6,%esi
  262ce8:	sbb    $0x0,%rsi
  262cec:	mov    0x38e2dd(%rip),%rdx        # 5f0fd0 <_DYNAMIC+0x330>
  262cf3:	lock incq (%rdx,%rsi,8)
  262cf8:	mov    %r11,%rsi
  262cfb:	cmp    %rsi,%rcx
  262cfe:	jae    262e9b <<glass::engine::Watch>::print_utf8+0x120b>
  262d04:	mov    0x28(%r15),%edi
  262d08:	mov    0x20(%r15),%r10d
  262d0c:	mov    0x24(%r15),%r11d
  262d10:	movzwl 0x2c(%r15),%ecx
  262d15:	mov    0x18(%r15),%rax
  262d19:	test   %rax,%rax
  262d1c:	mov    %rax,0x68(%rsp)
  262d21:	je     262d56 <<glass::engine::Watch>::print_utf8+0x10c6>
  262d23:	lock incq (%rax)
  262d27:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  262d2d:	mov    0x10(%r15),%rdx
  262d31:	mov    %edi,0x50(%rsp)
  262d35:	mov    %r10d,0x48(%rsp)
  262d3a:	mov    %r11d,0x4c(%rsp)
  262d3f:	mov    %ecx,%r9d
  262d42:	mov    %cx,0x54(%rsp)
  262d47:	mov    %rax,0x40(%rsp)
  262d4c:	cmp    %rdx,%rsi
  262d4f:	jbe    262d71 <<glass::engine::Watch>::print_utf8+0x10e1>
  262d51:	jmp    263c78 <<glass::engine::Watch>::print_utf8+0x1fe8>
  262d56:	mov    %edi,0x50(%rsp)
  262d5a:	mov    %r10d,0x48(%rsp)
  262d5f:	mov    %r11d,0x4c(%rsp)
  262d64:	mov    %cx,0x54(%rsp)
  262d69:	mov    %rax,0x40(%rsp)
  262d6e:	mov    %ecx,%r9d
  262d71:	mov    0xa8(%rsp),%rax
  262d79:	lea    0x0(,%rax,8),%rax
  262d81:	lea    (%rax,%rax,2),%rax
  262d85:	mov    0x8(%r15),%rbx
  262d89:	add    %rax,%rbx
  262d8c:	mov    %rsi,0xd0(%rsp)
  262d94:	lea    0x0(,%rsi,8),%rcx
  262d9c:	lea    (%rcx,%rcx,2),%r14
  262da0:	sub    %rax,%r14
  262da3:	mov    0x68(%rsp),%rcx
  262da8:	mov    %edi,0x98(%rsp)
  262daf:	mov    %r10d,0x8c(%rsp)
  262db7:	mov    %r11d,0xb8(%rsp)
  262dbf:	mov    %r9w,0xd8(%rsp)
  262dc8:	jmp    262ded <<glass::engine::Watch>::print_utf8+0x115d>
  262dca:	nopw   0x0(%rax,%rax,1)
  262dd0:	mov    %rcx,(%rbx)
  262dd3:	mov    %r10d,0x8(%rbx)
  262dd7:	mov    %r11d,0xc(%rbx)
  262ddb:	mov    %edi,0x10(%rbx)
  262dde:	mov    %r9w,0x14(%rbx)
  262de3:	add    $0x18,%rbx
  262de7:	add    $0xffffffffffffffe8,%r14
  262deb:	je     262e45 <<glass::engine::Watch>::print_utf8+0x11b5>
  262ded:	test   %rcx,%rcx
  262df0:	je     262dfc <<glass::engine::Watch>::print_utf8+0x116c>
  262df2:	lock incq (%rcx)
  262df6:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  262dfc:	mov    (%rbx),%rax
  262dff:	test   %rax,%rax
  262e02:	je     262dd0 <<glass::engine::Watch>::print_utf8+0x1140>
  262e04:	lock decq (%rax)
  262e08:	jne    262dd0 <<glass::engine::Watch>::print_utf8+0x1140>
  262e0a:	mov    %rbx,%rdi
  262e0d:	mov    %r8,%r15
  262e10:	call   *0x38e0f2(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  262e16:	movzwl 0xd8(%rsp),%r9d
  262e1f:	mov    0xb8(%rsp),%r11d
  262e27:	mov    0x8c(%rsp),%r10d
  262e2f:	mov    0x98(%rsp),%edi
  262e36:	mov    0x68(%rsp),%rcx
  262e3b:	mov    %r15,%r8
  262e3e:	mov    0x38(%rsp),%r15
  262e43:	jmp    262dd0 <<glass::engine::Watch>::print_utf8+0x1140>
  262e45:	mov    0xa8(%rsp),%rax
  262e4d:	cmp    %eax,0x38(%r15)
  262e51:	mov    0x30(%rsp),%r14
  262e56:	mov    0x20(%rsp),%rbx
  262e5b:	jbe    262e61 <<glass::engine::Watch>::print_utf8+0x11d1>
  262e5d:	mov    %eax,0x38(%r15)
  262e61:	test   %rcx,%rcx
  262e64:	mov    0xd0(%rsp),%rsi
  262e6c:	je     262e97 <<glass::engine::Watch>::print_utf8+0x1207>
  262e6e:	lock decq (%rcx)
  262e72:	jne    262e97 <<glass::engine::Watch>::print_utf8+0x1207>
  262e74:	lea    0x40(%rsp),%rdi
  262e79:	mov    %r8,%rbx
  262e7c:	call   *0x38e086(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  262e82:	mov    0xd0(%rsp),%rsi
  262e8a:	mov    %rbx,%r8
  262e8d:	mov    0x20(%rsp),%rbx
  262e92:	mov    0x38(%rsp),%r15
  262e97:	mov    0x10(%r15),%rax
  262e9b:	cmp    %rax,%rsi
  262e9e:	jb     262edd <<glass::engine::Watch>::print_utf8+0x124d>
  262ea0:	cmpl   $0xffffffff,0x28(%r15)
  262ea5:	je     262ed5 <<glass::engine::Watch>::print_utf8+0x1245>
  262ea7:	mov    0x78(%rsp),%rax
  262eac:	mov    (%rax),%rax
  262eaf:	test   %rax,%rax
  262eb2:	je     262ed5 <<glass::engine::Watch>::print_utf8+0x1245>
  262eb4:	lock decq (%rax)
  262eb8:	jne    262ed5 <<glass::engine::Watch>::print_utf8+0x1245>
  262eba:	mov    0x78(%rsp),%rdi
  262ebf:	mov    %r8,%rbx
  262ec2:	call   *0x38e040(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  262ec8:	mov    %rbx,%r8
  262ecb:	mov    0x20(%rsp),%rbx
  262ed0:	mov    0x38(%rsp),%r15
  262ed5:	movl   $0xffffffff,0x28(%r15)
  262edd:	mov    0x30(%r15),%rax
  262ee1:	lea    0x1(%rbx),%rcx
  262ee5:	cmp    %rax,%rcx
  262ee8:	cmova  %rcx,%rax
  262eec:	mov    0x10(%r15),%rsi
  262ef0:	mov    %rax,0x30(%r15)
  262ef4:	cmp    %rsi,%rbx
  262ef7:	jae    263d59 <<glass::engine::Watch>::print_utf8+0x20c9>
  262efd:	mov    0xc(%rsp),%esi
  262f01:	mov    %esi,%eax
  262f03:	or     $0x20,%eax
  262f06:	cmp    $0x2,%r12
  262f0a:	mov    0x8(%r15),%rcx
  262f0e:	lea    (%rbx,%rbx,2),%rdx
  262f12:	lea    (%rcx,%rdx,8),%rbx
  262f16:	mov    %ebp,0x10(%rcx,%rdx,8)
  262f1a:	mov    0x58(%rsp),%ebp
  262f1e:	mov    %ebp,0x8(%rcx,%rdx,8)
  262f22:	cmovne %esi,%eax
  262f25:	mov    0xa0(%rsp),%esi
  262f2c:	mov    %esi,0xc(%rcx,%rdx,8)
  262f30:	mov    %ax,0x14(%rcx,%rdx,8)
  262f35:	mov    (%rcx,%rdx,8),%rax
  262f39:	test   %rax,%rax
  262f3c:	je     262f58 <<glass::engine::Watch>::print_utf8+0x12c8>
  262f3e:	lock decq (%rax)
  262f42:	jne    262f58 <<glass::engine::Watch>::print_utf8+0x12c8>
  262f44:	mov    %rbx,%rdi
  262f47:	mov    %r8,%r15
  262f4a:	call   *0x38dfb8(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  262f50:	mov    %r15,%r8
  262f53:	mov    0x38(%rsp),%r15
  262f58:	movq   $0x0,(%rbx)
  262f5f:	cmp    $0x2,%r12
  262f63:	mov    0x28(%rsp),%rdx
  262f68:	jne    263298 <<glass::engine::Watch>::print_utf8+0x1608>
  262f6e:	mov    0x20(%rsp),%r9
  262f73:	lea    0x1(%r9),%r12
  262f77:	mov    0x30(%r15),%rax
  262f7b:	mov    0x28(%r15),%ecx
  262f7f:	cmp    %rax,%r12
  262f82:	jne    262fa3 <<glass::engine::Watch>::print_utf8+0x1313>
  262f84:	cmp    $0xffffffff,%ecx
  262f87:	je     262fa3 <<glass::engine::Watch>::print_utf8+0x1313>
  262f89:	add    $0x2,%r9
  262f8d:	mov    %r9,0x30(%r15)
  262f91:	mov    0x10(%r15),%rsi
  262f95:	cmp    %rsi,%r12
  262f98:	jb     26323f <<glass::engine::Watch>::print_utf8+0x15af>
  262f9e:	jmp    26361e <<glass::engine::Watch>::print_utf8+0x198e>
  262fa3:	cmp    $0xffffffff,%ecx
  262fa6:	je     26321f <<glass::engine::Watch>::print_utf8+0x158f>
  262fac:	mov    0x10(%r15),%rcx
  262fb0:	cmp    %rax,%rcx
  262fb3:	mov    %rax,%rdi
  262fb6:	cmovb  %rcx,%rdi
  262fba:	cmp    %r12,%rcx
  262fbd:	mov    %r12,%r10
  262fc0:	cmovb  %rcx,%r10
  262fc4:	mov    0x38dff5(%rip),%rdx        # 5f0fc0 <_DYNAMIC+0x320>
  262fcb:	movzbl (%rdx),%edx
  262fce:	test   %dl,%dl
  262fd0:	je     26304c <<glass::engine::Watch>::print_utf8+0x13bc>
  262fd2:	mov    0x38e01f(%rip),%rdx        # 5f0ff8 <_DYNAMIC+0x358>
  262fd9:	cmp    %r10,%rax
  262fdc:	jae    262fe5 <<glass::engine::Watch>::print_utf8+0x1355>
  262fde:	mov    0x38e01b(%rip),%rdx        # 5f1000 <_DYNAMIC+0x360>
  262fe5:	lock incq 0x28(%rdx)
  262fea:	mov    0x38dfe7(%rip),%rdx        # 5f0fd8 <_DYNAMIC+0x338>
  262ff1:	lock incq (%rdx)
  262ff5:	mov    %r10,%rdx
  262ff8:	sub    %rdi,%rdx
  262ffb:	jne    263001 <<glass::engine::Watch>::print_utf8+0x1371>
  262ffd:	xor    %esi,%esi
  262fff:	jmp    263040 <<glass::engine::Watch>::print_utf8+0x13b0>
  263001:	mov    0x38dfd8(%rip),%rsi        # 5f0fe0 <_DYNAMIC+0x340>
  263008:	lock add %rdx,(%rsi)
  26300c:	cmp    $0x5,%rdx
  263010:	jae    263020 <<glass::engine::Watch>::print_utf8+0x1390>
  263012:	lea    -0x205581(%rip),%rsi        # 5da98 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263019:	movzbl -0x1(%rdx,%rsi,1),%esi
  26301e:	jmp    263040 <<glass::engine::Watch>::print_utf8+0x13b0>
  263020:	lea    -0x5(%rdx),%r11
  263024:	mov    $0x4,%esi
  263029:	cmp    $0x4,%r11
  26302d:	jb     263040 <<glass::engine::Watch>::print_utf8+0x13b0>
  26302f:	add    $0xfffffffffffffff7,%rdx
  263033:	cmp    $0x8,%rdx
  263037:	mov    $0x6,%esi
  26303c:	sbb    $0x0,%rsi
  263040:	mov    0x38df89(%rip),%rdx        # 5f0fd0 <_DYNAMIC+0x330>
  263047:	lock incq (%rdx,%rsi,8)
  26304c:	cmp    %r10,%rax
  26304f:	mov    0x28(%rsp),%rdx
  263054:	jae    2631f8 <<glass::engine::Watch>::print_utf8+0x1568>
  26305a:	mov    %r12,0xd8(%rsp)
  263062:	mov    0x28(%r15),%r9d
  263066:	mov    0x20(%r15),%r11d
  26306a:	mov    0x24(%r15),%ebp
  26306e:	movzwl 0x2c(%r15),%eax
  263073:	mov    0x18(%r15),%r12
  263077:	test   %r12,%r12
  26307a:	mov    %r12,0x98(%rsp)
  263082:	mov    %ax,0x68(%rsp)
  263087:	je     2630bd <<glass::engine::Watch>::print_utf8+0x142d>
  263089:	lock incq (%r12)
  26308e:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  263094:	mov    0x10(%r15),%rdx
  263098:	mov    %r9d,0x50(%rsp)
  26309d:	mov    %r11d,0x48(%rsp)
  2630a2:	mov    %ebp,0x4c(%rsp)
  2630a6:	mov    %ax,0x54(%rsp)
  2630ab:	mov    %r12,0x40(%rsp)
  2630b0:	cmp    %rdx,%r10
  2630b3:	mov    %r10,%rsi
  2630b6:	jbe    2630d8 <<glass::engine::Watch>::print_utf8+0x1448>
  2630b8:	jmp    263c92 <<glass::engine::Watch>::print_utf8+0x2002>
  2630bd:	mov    %r9d,0x50(%rsp)
  2630c2:	mov    %r11d,0x48(%rsp)
  2630c7:	mov    %ebp,0x4c(%rsp)
  2630cb:	mov    %ax,0x54(%rsp)
  2630d0:	mov    %r12,0x40(%rsp)
  2630d5:	mov    %r10,%rsi
  2630d8:	mov    %rdi,0xa8(%rsp)
  2630e0:	lea    0x0(,%rdi,8),%rax
  2630e8:	lea    (%rax,%rax,2),%rax
  2630ec:	mov    0x8(%r15),%rbx
  2630f0:	add    %rax,%rbx
  2630f3:	mov    %rsi,0xb8(%rsp)
  2630fb:	lea    0x0(,%rsi,8),%rcx
  263103:	lea    (%rcx,%rcx,2),%r14
  263107:	sub    %rax,%r14
  26310a:	movzwl 0x68(%rsp),%ecx
  26310f:	mov    %ebp,0x8c(%rsp)
  263116:	jmp    26313c <<glass::engine::Watch>::print_utf8+0x14ac>
  263118:	nopl   0x0(%rax,%rax,1)
  263120:	mov    %r12,(%rbx)
  263123:	mov    %r11d,0x8(%rbx)
  263127:	mov    %ebp,0xc(%rbx)
  26312a:	mov    %r9d,0x10(%rbx)
  26312e:	mov    %cx,0x14(%rbx)
  263132:	add    $0x18,%rbx
  263136:	add    $0xffffffffffffffe8,%r14
  26313a:	je     263190 <<glass::engine::Watch>::print_utf8+0x1500>
  26313c:	test   %r12,%r12
  26313f:	je     26314c <<glass::engine::Watch>::print_utf8+0x14bc>
  263141:	lock incq (%r12)
  263146:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  26314c:	mov    (%rbx),%rax
  26314f:	test   %rax,%rax
  263152:	je     263120 <<glass::engine::Watch>::print_utf8+0x1490>
  263154:	lock decq (%rax)
  263158:	jne    263120 <<glass::engine::Watch>::print_utf8+0x1490>
  26315a:	mov    %rbx,%rdi
  26315d:	mov    %r8,%r15
  263160:	mov    %r9d,%ebp
  263163:	mov    %r11d,%r12d
  263166:	call   *0x38dd9c(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  26316c:	movzwl 0x68(%rsp),%ecx
  263171:	mov    %r12d,%r11d
  263174:	mov    0x98(%rsp),%r12
  26317c:	mov    %ebp,%r9d
  26317f:	mov    0x8c(%rsp),%ebp
  263186:	mov    %r15,%r8
  263189:	mov    0x38(%rsp),%r15
  26318e:	jmp    263120 <<glass::engine::Watch>::print_utf8+0x1490>
  263190:	mov    0xa8(%rsp),%rax
  263198:	cmp    %eax,0x38(%r15)
  26319c:	mov    0x30(%rsp),%r14
  2631a1:	mov    0x28(%rsp),%rdx
  2631a6:	mov    0x20(%rsp),%r9
  2631ab:	jbe    2631b1 <<glass::engine::Watch>::print_utf8+0x1521>
  2631ad:	mov    %eax,0x38(%r15)
  2631b1:	test   %r12,%r12
  2631b4:	mov    0x58(%rsp),%ebp
  2631b8:	mov    0xb8(%rsp),%r10
  2631c0:	je     2631ec <<glass::engine::Watch>::print_utf8+0x155c>
  2631c2:	lock decq (%r12)
  2631c7:	jne    2631ec <<glass::engine::Watch>::print_utf8+0x155c>
  2631c9:	lea    0x40(%rsp),%rdi
  2631ce:	mov    %r8,%rbx
  2631d1:	call   *0x38dd31(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  2631d7:	mov    0x28(%rsp),%rdx
  2631dc:	mov    %rbx,%r8
  2631df:	mov    0xb8(%rsp),%r10
  2631e7:	mov    0x20(%rsp),%r9
  2631ec:	mov    0x10(%r15),%rcx
  2631f0:	mov    0xd8(%rsp),%r12
  2631f8:	cmp    %rcx,%r10
  2631fb:	jb     26321f <<glass::engine::Watch>::print_utf8+0x158f>
  2631fd:	mov    0x78(%rsp),%rdi
  263202:	mov    %r8,%rbx
  263205:	call   1ad360 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26320a:	mov    0x28(%rsp),%rdx
  26320f:	mov    %rbx,%r8
  263212:	mov    0x20(%rsp),%r9
  263217:	movl   $0xffffffff,0x28(%r15)
  26321f:	mov    0x30(%r15),%rax
  263223:	add    $0x2,%r9
  263227:	cmp    %rax,%r9
  26322a:	cmovbe %rax,%r9
  26322e:	mov    0x10(%r15),%rsi
  263232:	mov    %r9,0x30(%r15)
  263236:	cmp    %rsi,%r12
  263239:	jae    263d69 <<glass::engine::Watch>::print_utf8+0x20d9>
  26323f:	mov    0x8(%r15),%rax
  263243:	lea    (%r12,%r12,2),%rcx
  263247:	lea    (%rax,%rcx,8),%rbx
  26324b:	movl   $0x20,0x10(%rax,%rcx,8)
  263253:	mov    %ebp,0x8(%rax,%rcx,8)
  263257:	mov    0xa0(%rsp),%esi
  26325e:	mov    %esi,0xc(%rax,%rcx,8)
  263262:	mov    0xc(%rsp),%esi
  263266:	or     $0x40,%esi
  263269:	mov    %si,0x14(%rax,%rcx,8)
  26326e:	mov    (%rax,%rcx,8),%rax
  263272:	test   %rax,%rax
  263275:	je     263291 <<glass::engine::Watch>::print_utf8+0x1601>
  263277:	lock decq (%rax)
  26327b:	jne    263291 <<glass::engine::Watch>::print_utf8+0x1601>
  26327d:	mov    %rbx,%rdi
  263280:	mov    %r8,%r15
  263283:	call   *0x38dc7f(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  263289:	mov    0x28(%rsp),%rdx
  26328e:	mov    %r15,%r8
  263291:	movq   $0x0,(%rbx)
  263298:	mov    0x70(%rsp),%rcx
  26329d:	cmp    0x90(%rsp),%rcx
  2632a5:	mov    0x18(%rsp),%rsi
  2632aa:	mov    0x60(%rsp),%rax
  2632af:	jb     2632b8 <<glass::engine::Watch>::print_utf8+0x1628>
  2632b1:	dec    %rcx
  2632b4:	movb   $0x1,0x6c(%rax)
  2632b8:	mov    %rcx,0x40(%rax)
  2632bc:	mov    0xc8(%rsp),%r15
  2632c4:	incq   0xa0(%r15)
  2632cb:	nopl   0x0(%rax,%rax,1)
  2632d0:	add    %r14,%rdx
  2632d3:	cmpb   $0x0,0x80(%rsp)
  2632db:	je     262829 <<glass::engine::Watch>::print_utf8+0xb99>
  2632e1:	jmp    261d40 <<glass::engine::Watch>::print_utf8+0xb0>
  2632e6:	mov    %r8,%rbx
  2632e9:	mov    %rdx,%r14
  2632ec:	call   18b862 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2632f1:	mov    %r14,%rdx
  2632f4:	mov    %rbx,%r8
  2632f7:	mov    %ebp,%ebx
  2632f9:	mov    0x390b70(%rip),%rsi        # 5f3e70 <glass::engine::width_of::CACHE+0x8>
  263300:	cmp    %rbx,%rsi
  263303:	ja     262a4e <<glass::engine::Watch>::print_utf8+0xdbe>
  263309:	jmp    263c68 <<glass::engine::Watch>::print_utf8+0x1fd8>
  26330e:	cmpq   $0x400,0xa0(%r15)
  263319:	jb     263344 <<glass::engine::Watch>::print_utf8+0x16b4>
  26331b:	mov    %r15,%rdi
  26331e:	call   2640e0 <<glass::engine::Watch>::fold_sentinel>
  263323:	movq   $0x0,0xa0(%r15)
  26332e:	mov    0x390b4c(%rip),%eax        # 5f3e80 <glass::engine::run_whole::ON>
  263334:	test   %eax,%eax
  263336:	je     26334e <<glass::engine::Watch>::print_utf8+0x16be>
  263338:	call   18b906 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  26333d:	cmp    %r13,%r14
  263340:	je     263353 <<glass::engine::Watch>::print_utf8+0x16c3>
  263342:	jmp    263383 <<glass::engine::Watch>::print_utf8+0x16f3>
  263344:	mov    0x390b36(%rip),%eax        # 5f3e80 <glass::engine::run_whole::ON>
  26334a:	test   %eax,%eax
  26334c:	jne    263338 <<glass::engine::Watch>::print_utf8+0x16a8>
  26334e:	cmp    %r13,%r14
  263351:	jne    263383 <<glass::engine::Watch>::print_utf8+0x16f3>
  263353:	cmpb   $0x0,0x390b2a(%rip)        # 5f3e84 <glass::engine::run_whole::ON+0x4>
  26335a:	je     263383 <<glass::engine::Watch>::print_utf8+0x16f3>
  26335c:	cmp    $0xffffffff,%ebp
  26335f:	je     263525 <<glass::engine::Watch>::print_utf8+0x1895>
  263365:	lea    -0x20(%rbp),%eax
  263368:	cmp    $0x5f,%eax
  26336b:	jae    263394 <<glass::engine::Watch>::print_utf8+0x1704>
  26336d:	mov    $0x1,%r13d
  263373:	cmpb   $0x0,0x10(%rsp)
  263378:	jne    26345f <<glass::engine::Watch>::print_utf8+0x17cf>
  26337e:	jmp    263513 <<glass::engine::Watch>::print_utf8+0x1883>
  263383:	xor    %eax,%eax
  263385:	cmp    $0xffffffff,%ebp
  263388:	cmove  %rax,%rbx
  26338c:	mov    %rbx,%r13
  26338f:	jmp    263525 <<glass::engine::Watch>::print_utf8+0x1895>
  263394:	cmpb   $0x0,0x80(%rsp)
  26339c:	je     263513 <<glass::engine::Watch>::print_utf8+0x1883>
  2633a2:	mov    0x390ad0(%rip),%eax        # 5f3e78 <glass::engine::width_of::CACHE+0x10>
  2633a8:	test   %eax,%eax
  2633aa:	jne    263c51 <<glass::engine::Watch>::print_utf8+0x1fc1>
  2633b0:	mov    %ebp,%ebx
  2633b2:	mov    0x390ab7(%rip),%rsi        # 5f3e70 <glass::engine::width_of::CACHE+0x8>
  2633b9:	cmp    %rbx,%rsi
  2633bc:	jbe    263c68 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2633c2:	mov    0x390a9f(%rip),%r14        # 5f3e68 <glass::engine::width_of::CACHE>
  2633c9:	movzbl (%r14,%rbx,1),%eax
  2633ce:	movzbl %al,%r13d
  2633d2:	test   %r13b,%r13b
  2633d5:	js     2633e2 <<glass::engine::Watch>::print_utf8+0x1752>
  2633d7:	mov    $0x1,%cl
  2633d9:	test   %cl,%cl
  2633db:	jne    263451 <<glass::engine::Watch>::print_utf8+0x17c1>
  2633dd:	jmp    263513 <<glass::engine::Watch>::print_utf8+0x1883>
  2633e2:	cmp    $0xfe,%r13d
  2633e9:	je     263513 <<glass::engine::Watch>::print_utf8+0x1883>
  2633ef:	mov    $0xfe,%al
  2633f1:	cmp    $0x7f,%ebp
  2633f4:	jae    26342c <<glass::engine::Watch>::print_utf8+0x179c>
  2633f6:	mov    $0x1,%r13d
  2633fc:	xor    %ecx,%ecx
  2633fe:	jmp    263445 <<glass::engine::Watch>::print_utf8+0x17b5>
  263400:	mov    $0x1,%cl
  263402:	mov    %ecx,0x80(%rsp)
  263409:	cmpb   $0x0,0x68(%rax)
  26340d:	jne    26341f <<glass::engine::Watch>::print_utf8+0x178f>
  26340f:	cmpb   $0x0,0x69(%rax)
  263413:	jne    26341f <<glass::engine::Watch>::print_utf8+0x178f>
  263415:	cmpb   $0x0,0x6a(%rax)
  263419:	je     26363e <<glass::engine::Watch>::print_utf8+0x19ae>
  26341f:	movl   $0x0,0x10(%rsp)
  263427:	jmp    261cee <<glass::engine::Watch>::print_utf8+0x5e>
  26342c:	cmp    $0xa0,%ebp
  263432:	jb     263443 <<glass::engine::Watch>::print_utf8+0x17b3>
  263434:	mov    %ebp,%edi
  263436:	call   297d70 <unicode_width::tables::lookup_width>
  26343b:	movzbl %al,%r13d
  26343f:	mov    $0x1,%cl
  263441:	jmp    263445 <<glass::engine::Watch>::print_utf8+0x17b5>
  263443:	xor    %ecx,%ecx
  263445:	mov    %al,(%r14,%rbx,1)
  263449:	test   %cl,%cl
  26344b:	je     263513 <<glass::engine::Watch>::print_utf8+0x1883>
  263451:	lea    -0x1(%r13),%rax
  263455:	cmp    $0x1,%rax
  263459:	ja     263513 <<glass::engine::Watch>::print_utf8+0x1883>
  26345f:	mov    0x78(%r15),%r14
  263463:	cmpb   $0x0,0x6c(%r14)
  263468:	jne    263513 <<glass::engine::Watch>::print_utf8+0x1883>
  26346e:	mov    0x40(%r14),%r12
  263472:	mov    0xa0(%r14),%r8
  263479:	lea    (%r12,%r13,1),%rdx
  26347d:	cmp    %r8,%rdx
  263480:	ja     263513 <<glass::engine::Watch>::print_utf8+0x1883>
  263486:	mov    0x30(%r14),%eax
  26348a:	sub    0x48(%r14),%eax
  26348e:	cltq
  263490:	mov    0x20(%r14),%rsi
  263494:	mov    0x28(%r14),%rcx
  263498:	lea    (%rcx,%rax,1),%rdi
  26349c:	dec    %rdi
  26349f:	xor    %eax,%eax
  2634a1:	cmp    %rsi,%rdi
  2634a4:	cmovae %rsi,%rax
  2634a8:	sub    %rax,%rdi
  2634ab:	cmp    %rsi,%rdi
  2634ae:	jae    263d0b <<glass::engine::Watch>::print_utf8+0x207b>
  2634b4:	mov    0x58(%r14),%r10d
  2634b8:	mov    0x5c(%r14),%r11d
  2634bc:	movzwl 0x64(%r14),%r9d
  2634c1:	mov    0x18(%r14),%rax
  2634c5:	shl    $0x6,%rdi
  2634c9:	lea    (%rax,%rdi,1),%rbx
  2634cd:	lea    (%rax,%rdi,1),%rcx
  2634d1:	add    $0x18,%rcx
  2634d5:	mov    %rcx,0x80(%rsp)
  2634dd:	mov    0x28(%rax,%rdi,1),%eax
  2634e1:	cmp    $0xffffffff,%eax
  2634e4:	je     2634f4 <<glass::engine::Watch>::print_utf8+0x1864>
  2634e6:	mov    0x80(%rsp),%rcx
  2634ee:	cmp    0x30(%rbx),%r12
  2634f2:	jae    26350d <<glass::engine::Watch>::print_utf8+0x187d>
  2634f4:	mov    0x10(%rbx),%rsi
  2634f8:	cmp    %rsi,%r12
  2634fb:	jae    263d79 <<glass::engine::Watch>::print_utf8+0x20e9>
  263501:	lea    (%r12,%r12,2),%rcx
  263505:	shl    $0x3,%rcx
  263509:	add    0x8(%rbx),%rcx
  26350d:	testb  $0x60,0x14(%rcx)
  263511:	je     26353a <<glass::engine::Watch>::print_utf8+0x18aa>
  263513:	mov    %r15,%rdi
  263516:	mov    %ebp,%esi
  263518:	call   33c8d0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  26351d:	mov    0xc0(%rsp),%r13
  263525:	mov    %r13,%rax
  263528:	add    $0x118,%rsp
  26352f:	pop    %rbx
  263530:	pop    %r12
  263532:	pop    %r13
  263534:	pop    %r14
  263536:	pop    %r15
  263538:	pop    %rbp
  263539:	ret
  26353a:	cmp    $0x2,%r13
  26353e:	jne    263577 <<glass::engine::Watch>::print_utf8+0x18e7>
  263540:	lea    0x1(%r12),%rdi
  263545:	cmp    $0xffffffff,%eax
  263548:	je     263558 <<glass::engine::Watch>::print_utf8+0x18c8>
  26354a:	mov    0x80(%rsp),%rcx
  263552:	cmp    0x30(%rbx),%rdi
  263556:	jae    263571 <<glass::engine::Watch>::print_utf8+0x18e1>
  263558:	mov    0x10(%rbx),%rsi
  26355c:	cmp    %rsi,%rdi
  26355f:	jae    263d3c <<glass::engine::Watch>::print_utf8+0x20ac>
  263565:	lea    (%rdi,%rdi,2),%rcx
  263569:	shl    $0x3,%rcx
  26356d:	add    0x8(%rbx),%rcx
  263571:	testb  $0x60,0x14(%rcx)
  263575:	jne    263513 <<glass::engine::Watch>::print_utf8+0x1883>
  263577:	mov    %r11d,0x78(%rsp)
  26357c:	mov    %r10d,0x28(%rsp)
  263581:	mov    %r9d,0x30(%rsp)
  263586:	mov    %r8,0x58(%rsp)
  26358b:	mov    %rdx,0xa0(%rsp)
  263593:	cmp    %r12d,0x38(%rbx)
  263597:	jbe    26359d <<glass::engine::Watch>::print_utf8+0x190d>
  263599:	mov    %r12d,0x38(%rbx)
  26359d:	cmp    $0xffffffff,%eax
  2635a0:	setne  %cl
  2635a3:	mov    %rbx,%rdi
  2635a6:	mov    0x30(%rbx),%rbx
  2635aa:	cmp    %rbx,%r12
  2635ad:	sete   %dl
  2635b0:	test   %dl,%cl
  2635b2:	mov    %rdi,0x18(%rsp)
  2635b7:	jne    263605 <<glass::engine::Watch>::print_utf8+0x1975>
  2635b9:	cmp    $0xffffffff,%eax
  2635bc:	je     26386f <<glass::engine::Watch>::print_utf8+0x1bdf>
  2635c2:	mov    0x18(%rsp),%rax
  2635c7:	mov    0x10(%rax),%r15
  2635cb:	cmp    %rbx,%r15
  2635ce:	mov    %rbx,%rax
  2635d1:	cmovb  %r15,%rax
  2635d5:	mov    %rax,0x10(%rsp)
  2635da:	cmp    %r12,%r15
  2635dd:	mov    %r12,%rcx
  2635e0:	cmovb  %r15,%rcx
  2635e4:	mov    0x38d9d5(%rip),%rax        # 5f0fc0 <_DYNAMIC+0x320>
  2635eb:	movzbl (%rax),%eax
  2635ee:	test   %al,%al
  2635f0:	mov    %rcx,0x20(%rsp)
  2635f5:	je     26366c <<glass::engine::Watch>::print_utf8+0x19dc>
  2635f7:	cmp    %rcx,%rbx
  2635fa:	jae    26364e <<glass::engine::Watch>::print_utf8+0x19be>
  2635fc:	mov    0x38d9fd(%rip),%rax        # 5f1000 <_DYNAMIC+0x360>
  263603:	jmp    263655 <<glass::engine::Watch>::print_utf8+0x19c5>
  263605:	lea    0x1(%r12),%rax
  26360a:	mov    %rax,0x30(%rdi)
  26360e:	mov    0x10(%rdi),%rsi
  263612:	cmp    %rsi,%r12
  263615:	mov    %rdi,%rdx
  263618:	jb     263895 <<glass::engine::Watch>::print_utf8+0x1c05>
  26361e:	lea    0x36523b(%rip),%rdx        # 5c8860 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  263625:	mov    %r12,%rdi
  263628:	call   *0x38d88a(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  26362e:	lea    0x365183(%rip),%rcx        # 5c87b8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15a38>
  263635:	mov    %r12,%rdi
  263638:	call   *0x38da3a(%rip)        # 5f1078 <_DYNAMIC+0x3d8>
  26363e:	cmpb   $0x0,0x6b(%rax)
  263642:	sete   %al
  263645:	mov    %eax,0x10(%rsp)
  263649:	jmp    261cee <<glass::engine::Watch>::print_utf8+0x5e>
  26364e:	mov    0x38d9a3(%rip),%rax        # 5f0ff8 <_DYNAMIC+0x358>
  263655:	lock incq 0x28(%rax)
  26365a:	mov    %rcx,%rdi
  26365d:	sub    0x10(%rsp),%rdi
  263662:	call   2f6480 <alacritty_terminal::grid::row::fill_census::note>
  263667:	mov    0x20(%rsp),%rcx
  26366c:	cmp    %rcx,%rbx
  26366f:	jae    263849 <<glass::engine::Watch>::print_utf8+0x1bb9>
  263675:	mov    0x18(%rsp),%rcx
  26367a:	mov    0x28(%rcx),%edi
  26367d:	mov    0x20(%rcx),%r8d
  263681:	mov    0x24(%rcx),%r9d
  263685:	movzwl 0x2c(%rcx),%r10d
  26368a:	mov    0x18(%rcx),%rsi
  26368e:	test   %rsi,%rsi
  263691:	mov    %rsi,0x38(%rsp)
  263696:	mov    %edi,0xc(%rsp)
  26369a:	mov    %r8d,0x60(%rsp)
  26369f:	mov    %r9d,0x70(%rsp)
  2636a4:	mov    %r10w,0x90(%rsp)
  2636ad:	je     263776 <<glass::engine::Watch>::print_utf8+0x1ae6>
  2636b3:	lock incq (%rsi)
  2636b7:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  2636bd:	mov    0x10(%rcx),%rdx
  2636c1:	mov    %edi,0x50(%rsp)
  2636c5:	mov    %r8d,0x48(%rsp)
  2636ca:	mov    %r9d,0x4c(%rsp)
  2636cf:	mov    %r10w,0x54(%rsp)
  2636d5:	mov    %rsi,0x40(%rsp)
  2636da:	mov    0x20(%rsp),%rsi
  2636df:	cmp    %rdx,%rsi
  2636e2:	ja     263cf7 <<glass::engine::Watch>::print_utf8+0x2067>
  2636e8:	mov    0x10(%rsp),%rax
  2636ed:	lea    0x0(,%rax,8),%rax
  2636f5:	lea    (%rax,%rax,2),%rax
  2636f9:	mov    0x8(%rcx),%rbx
  2636fd:	add    %rax,%rbx
  263700:	lea    0x0(,%rsi,8),%rcx
  263708:	lea    (%rcx,%rcx,2),%r15
  26370c:	sub    %rax,%r15
  26370f:	mov    0x38(%rsp),%rsi
  263714:	jmp    263737 <<glass::engine::Watch>::print_utf8+0x1aa7>
  263716:	mov    %rsi,(%rbx)
  263719:	mov    %r8d,0x8(%rbx)
  26371d:	mov    %r9d,0xc(%rbx)
  263721:	mov    %edi,0x10(%rbx)
  263724:	mov    %r10w,0x14(%rbx)
  263729:	add    $0x18,%rbx
  26372d:	add    $0xffffffffffffffe8,%r15
  263731:	je     263813 <<glass::engine::Watch>::print_utf8+0x1b83>
  263737:	lock incq (%rsi)
  26373b:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  263741:	mov    (%rbx),%rax
  263744:	test   %rax,%rax
  263747:	je     263716 <<glass::engine::Watch>::print_utf8+0x1a86>
  263749:	lock decq (%rax)
  26374d:	jne    263716 <<glass::engine::Watch>::print_utf8+0x1a86>
  26374f:	mov    %rbx,%rdi
  263752:	call   *0x38d7b0(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  263758:	movzwl 0x90(%rsp),%r10d
  263761:	mov    0x70(%rsp),%r9d
  263766:	mov    0x60(%rsp),%r8d
  26376b:	mov    0xc(%rsp),%edi
  26376f:	mov    0x38(%rsp),%rsi
  263774:	jmp    263716 <<glass::engine::Watch>::print_utf8+0x1a86>
  263776:	mov    %edi,0x50(%rsp)
  26377a:	mov    %r8d,0x48(%rsp)
  26377f:	mov    %r9d,0x4c(%rsp)
  263784:	mov    %r10w,0x54(%rsp)
  26378a:	mov    %rsi,0x40(%rsp)
  26378f:	mov    0x10(%rsp),%rax
  263794:	lea    0x0(,%rax,8),%rax
  26379c:	lea    (%rax,%rax,2),%rax
  2637a0:	mov    0x8(%rcx),%rbx
  2637a4:	add    %rax,%rbx
  2637a7:	mov    0x20(%rsp),%rcx
  2637ac:	lea    0x0(,%rcx,8),%rcx
  2637b4:	lea    (%rcx,%rcx,2),%r15
  2637b8:	sub    %rax,%r15
  2637bb:	jmp    2637de <<glass::engine::Watch>::print_utf8+0x1b4e>
  2637bd:	movq   $0x0,(%rbx)
  2637c4:	mov    %r8d,0x8(%rbx)
  2637c8:	mov    %r9d,0xc(%rbx)
  2637cc:	mov    %edi,0x10(%rbx)
  2637cf:	mov    %r10w,0x14(%rbx)
  2637d4:	add    $0x18,%rbx
  2637d8:	add    $0xffffffffffffffe8,%r15
  2637dc:	je     263813 <<glass::engine::Watch>::print_utf8+0x1b83>
  2637de:	mov    (%rbx),%rax
  2637e1:	test   %rax,%rax
  2637e4:	je     2637bd <<glass::engine::Watch>::print_utf8+0x1b2d>
  2637e6:	lock decq (%rax)
  2637ea:	jne    2637bd <<glass::engine::Watch>::print_utf8+0x1b2d>
  2637ec:	mov    %rbx,%rdi
  2637ef:	call   *0x38d713(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  2637f5:	movzwl 0x90(%rsp),%r10d
  2637fe:	mov    0x70(%rsp),%r9d
  263803:	mov    0x60(%rsp),%r8d
  263808:	mov    0xc(%rsp),%edi
  26380c:	mov    0x38(%rsp),%rsi
  263811:	jmp    2637bd <<glass::engine::Watch>::print_utf8+0x1b2d>
  263813:	mov    0x18(%rsp),%rbx
  263818:	mov    0x10(%rsp),%rax
  26381d:	cmp    %eax,0x38(%rbx)
  263820:	jbe    263825 <<glass::engine::Watch>::print_utf8+0x1b95>
  263822:	mov    %eax,0x38(%rbx)
  263825:	test   %rsi,%rsi
  263828:	mov    0x20(%rsp),%rcx
  26382d:	je     263845 <<glass::engine::Watch>::print_utf8+0x1bb5>
  26382f:	lock decq (%rsi)
  263833:	jne    263845 <<glass::engine::Watch>::print_utf8+0x1bb5>
  263835:	lea    0x40(%rsp),%rdi
  26383a:	call   *0x38d6c8(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  263840:	mov    0x20(%rsp),%rcx
  263845:	mov    0x10(%rbx),%r15
  263849:	cmp    %r15,%rcx
  26384c:	mov    0xc8(%rsp),%r15
  263854:	jb     26386f <<glass::engine::Watch>::print_utf8+0x1bdf>
  263856:	mov    0x80(%rsp),%rdi
  26385e:	call   1ad360 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263863:	mov    0x18(%rsp),%rax
  263868:	movl   $0xffffffff,0x28(%rax)
  26386f:	mov    0x18(%rsp),%rdx
  263874:	mov    0x30(%rdx),%rax
  263878:	lea    0x1(%r12),%rcx
  26387d:	cmp    %rax,%rcx
  263880:	cmova  %rcx,%rax
  263884:	mov    0x10(%rdx),%rsi
  263888:	mov    %rax,0x30(%rdx)
  26388c:	cmp    %rsi,%r12
  26388f:	jae    263d69 <<glass::engine::Watch>::print_utf8+0x20d9>
  263895:	mov    0x30(%rsp),%esi
  263899:	mov    %esi,%eax
  26389b:	or     $0x20,%eax
  26389e:	cmp    $0x2,%r13
  2638a2:	mov    0x8(%rdx),%rcx
  2638a6:	lea    (%r12,%r12,2),%rdx
  2638aa:	lea    (%rcx,%rdx,8),%rbx
  2638ae:	mov    %ebp,0x10(%rcx,%rdx,8)
  2638b2:	mov    0x28(%rsp),%edi
  2638b6:	mov    %edi,0x8(%rcx,%rdx,8)
  2638ba:	cmovne %esi,%eax
  2638bd:	mov    0x78(%rsp),%esi
  2638c1:	mov    %esi,0xc(%rcx,%rdx,8)
  2638c5:	mov    %ax,0x14(%rcx,%rdx,8)
  2638ca:	mov    (%rcx,%rdx,8),%rax
  2638ce:	test   %rax,%rax
  2638d1:	je     2638e2 <<glass::engine::Watch>::print_utf8+0x1c52>
  2638d3:	lock decq (%rax)
  2638d7:	jne    2638e2 <<glass::engine::Watch>::print_utf8+0x1c52>
  2638d9:	mov    %rbx,%rdi
  2638dc:	call   *0x38d626(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  2638e2:	movq   $0x0,(%rbx)
  2638e9:	cmp    $0x2,%r13
  2638ed:	mov    0xc0(%rsp),%r13
  2638f5:	jne    263c23 <<glass::engine::Watch>::print_utf8+0x1f93>
  2638fb:	lea    0x1(%r12),%rcx
  263900:	mov    0x18(%rsp),%rax
  263905:	mov    0x30(%rax),%rbx
  263909:	mov    0x28(%rax),%eax
  26390c:	mov    %rcx,0x38(%rsp)
  263911:	cmp    %rbx,%rcx
  263914:	jne    263947 <<glass::engine::Watch>::print_utf8+0x1cb7>
  263916:	cmp    $0xffffffff,%eax
  263919:	je     263947 <<glass::engine::Watch>::print_utf8+0x1cb7>
  26391b:	add    $0x2,%r12
  26391f:	mov    0x18(%rsp),%rcx
  263924:	mov    %r12,0x30(%rcx)
  263928:	mov    0x10(%rcx),%rsi
  26392c:	mov    0x38(%rsp),%rdi
  263931:	cmp    %rsi,%rdi
  263934:	jb     263bd4 <<glass::engine::Watch>::print_utf8+0x1f44>
  26393a:	lea    0x364f1f(%rip),%rdx        # 5c8860 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  263941:	call   *0x38d571(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263947:	cmp    $0xffffffff,%eax
  26394a:	je     263baa <<glass::engine::Watch>::print_utf8+0x1f1a>
  263950:	mov    0x18(%rsp),%rax
  263955:	mov    0x10(%rax),%r15
  263959:	cmp    %rbx,%r15
  26395c:	mov    %rbx,%rax
  26395f:	cmovb  %r15,%rax
  263963:	mov    %rax,0x10(%rsp)
  263968:	lea    0x1(%r12),%rcx
  26396d:	cmp    %rcx,%r15
  263970:	cmovb  %r15,%rcx
  263974:	mov    0x38d645(%rip),%rax        # 5f0fc0 <_DYNAMIC+0x320>
  26397b:	movzbl (%rax),%eax
  26397e:	test   %al,%al
  263980:	mov    %rcx,0x20(%rsp)
  263985:	je     2639b3 <<glass::engine::Watch>::print_utf8+0x1d23>
  263987:	cmp    %rcx,%rbx
  26398a:	jae    263995 <<glass::engine::Watch>::print_utf8+0x1d05>
  26398c:	mov    0x38d66d(%rip),%rax        # 5f1000 <_DYNAMIC+0x360>
  263993:	jmp    26399c <<glass::engine::Watch>::print_utf8+0x1d0c>
  263995:	mov    0x38d65c(%rip),%rax        # 5f0ff8 <_DYNAMIC+0x358>
  26399c:	lock incq 0x28(%rax)
  2639a1:	mov    %rcx,%rdi
  2639a4:	sub    0x10(%rsp),%rdi
  2639a9:	call   2f6480 <alacritty_terminal::grid::row::fill_census::note>
  2639ae:	mov    0x20(%rsp),%rcx
  2639b3:	cmp    %rcx,%rbx
  2639b6:	jae    263b84 <<glass::engine::Watch>::print_utf8+0x1ef4>
  2639bc:	mov    0x18(%rsp),%rcx
  2639c1:	mov    0x28(%rcx),%edi
  2639c4:	mov    0x20(%rcx),%r8d
  2639c8:	mov    0x24(%rcx),%r9d
  2639cc:	movzwl 0x2c(%rcx),%r10d
  2639d1:	mov    0x18(%rcx),%r15
  2639d5:	test   %r15,%r15
  2639d8:	mov    %edi,0xc(%rsp)
  2639dc:	mov    %r8d,0x60(%rsp)
  2639e1:	mov    %r9d,0x70(%rsp)
  2639e6:	mov    %r10w,0x90(%rsp)
  2639ef:	je     263aae <<glass::engine::Watch>::print_utf8+0x1e1e>
  2639f5:	lock incq (%r15)
  2639f9:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  2639ff:	mov    0x10(%rcx),%rdx
  263a03:	mov    %edi,0x50(%rsp)
  263a07:	mov    %r8d,0x48(%rsp)
  263a0c:	mov    %r9d,0x4c(%rsp)
  263a11:	mov    %r10w,0x54(%rsp)
  263a17:	mov    %r15,0x40(%rsp)
  263a1c:	mov    0x20(%rsp),%rsi
  263a21:	cmp    %rdx,%rsi
  263a24:	ja     263d28 <<glass::engine::Watch>::print_utf8+0x2098>
  263a2a:	mov    0x10(%rsp),%rax
  263a2f:	lea    0x0(,%rax,8),%rax
  263a37:	lea    (%rax,%rax,2),%rax
  263a3b:	mov    0x8(%rcx),%rbx
  263a3f:	add    %rax,%rbx
  263a42:	lea    0x0(,%rsi,8),%rcx
  263a4a:	lea    (%rcx,%rcx,2),%r13
  263a4e:	sub    %rax,%r13
  263a51:	jmp    263a74 <<glass::engine::Watch>::print_utf8+0x1de4>
  263a53:	mov    %r15,(%rbx)
  263a56:	mov    %r8d,0x8(%rbx)
  263a5a:	mov    %r9d,0xc(%rbx)
  263a5e:	mov    %edi,0x10(%rbx)
  263a61:	mov    %r10w,0x14(%rbx)
  263a66:	add    $0x18,%rbx
  263a6a:	add    $0xffffffffffffffe8,%r13
  263a6e:	je     263b46 <<glass::engine::Watch>::print_utf8+0x1eb6>
  263a74:	lock incq (%r15)
  263a78:	jle    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  263a7e:	mov    (%rbx),%rax
  263a81:	test   %rax,%rax
  263a84:	je     263a53 <<glass::engine::Watch>::print_utf8+0x1dc3>
  263a86:	lock decq (%rax)
  263a8a:	jne    263a53 <<glass::engine::Watch>::print_utf8+0x1dc3>
  263a8c:	mov    %rbx,%rdi
  263a8f:	call   *0x38d473(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  263a95:	movzwl 0x90(%rsp),%r10d
  263a9e:	mov    0x70(%rsp),%r9d
  263aa3:	mov    0x60(%rsp),%r8d
  263aa8:	mov    0xc(%rsp),%edi
  263aac:	jmp    263a53 <<glass::engine::Watch>::print_utf8+0x1dc3>
  263aae:	mov    %edi,0x50(%rsp)
  263ab2:	mov    %r8d,0x48(%rsp)
  263ab7:	mov    %r9d,0x4c(%rsp)
  263abc:	mov    %r10w,0x54(%rsp)
  263ac2:	mov    %r15,0x40(%rsp)
  263ac7:	mov    0x10(%rsp),%rax
  263acc:	lea    0x0(,%rax,8),%rax
  263ad4:	lea    (%rax,%rax,2),%rax
  263ad8:	mov    0x8(%rcx),%rbx
  263adc:	add    %rax,%rbx
  263adf:	mov    0x20(%rsp),%rcx
  263ae4:	lea    0x0(,%rcx,8),%rcx
  263aec:	lea    (%rcx,%rcx,2),%r13
  263af0:	sub    %rax,%r13
  263af3:	jmp    263b16 <<glass::engine::Watch>::print_utf8+0x1e86>
  263af5:	movq   $0x0,(%rbx)
  263afc:	mov    %r8d,0x8(%rbx)
  263b00:	mov    %r9d,0xc(%rbx)
  263b04:	mov    %edi,0x10(%rbx)
  263b07:	mov    %r10w,0x14(%rbx)
  263b0c:	add    $0x18,%rbx
  263b10:	add    $0xffffffffffffffe8,%r13
  263b14:	je     263b46 <<glass::engine::Watch>::print_utf8+0x1eb6>
  263b16:	mov    (%rbx),%rax
  263b19:	test   %rax,%rax
  263b1c:	je     263af5 <<glass::engine::Watch>::print_utf8+0x1e65>
  263b1e:	lock decq (%rax)
  263b22:	jne    263af5 <<glass::engine::Watch>::print_utf8+0x1e65>
  263b24:	mov    %rbx,%rdi
  263b27:	call   *0x38d3db(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  263b2d:	movzwl 0x90(%rsp),%r10d
  263b36:	mov    0x70(%rsp),%r9d
  263b3b:	mov    0x60(%rsp),%r8d
  263b40:	mov    0xc(%rsp),%edi
  263b44:	jmp    263af5 <<glass::engine::Watch>::print_utf8+0x1e65>
  263b46:	mov    0x18(%rsp),%rbx
  263b4b:	mov    0x10(%rsp),%rax
  263b50:	cmp    %eax,0x38(%rbx)
  263b53:	jbe    263b58 <<glass::engine::Watch>::print_utf8+0x1ec8>
  263b55:	mov    %eax,0x38(%rbx)
  263b58:	test   %r15,%r15
  263b5b:	mov    0xc0(%rsp),%r13
  263b63:	mov    0x20(%rsp),%rcx
  263b68:	je     263b80 <<glass::engine::Watch>::print_utf8+0x1ef0>
  263b6a:	lock decq (%r15)
  263b6e:	jne    263b80 <<glass::engine::Watch>::print_utf8+0x1ef0>
  263b70:	lea    0x40(%rsp),%rdi
  263b75:	call   *0x38d38d(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  263b7b:	mov    0x20(%rsp),%rcx
  263b80:	mov    0x10(%rbx),%r15
  263b84:	cmp    %r15,%rcx
  263b87:	mov    0xc8(%rsp),%r15
  263b8f:	jb     263baa <<glass::engine::Watch>::print_utf8+0x1f1a>
  263b91:	mov    0x80(%rsp),%rdi
  263b99:	call   1ad360 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263b9e:	mov    0x18(%rsp),%rax
  263ba3:	movl   $0xffffffff,0x28(%rax)
  263baa:	mov    0x18(%rsp),%rcx
  263baf:	mov    0x30(%rcx),%rax
  263bb3:	add    $0x2,%r12
  263bb7:	cmp    %rax,%r12
  263bba:	cmovbe %rax,%r12
  263bbe:	mov    0x10(%rcx),%rsi
  263bc2:	mov    %r12,0x30(%rcx)
  263bc6:	mov    0x38(%rsp),%rdi
  263bcb:	cmp    %rsi,%rdi
  263bce:	jae    263d89 <<glass::engine::Watch>::print_utf8+0x20f9>
  263bd4:	mov    0x8(%rcx),%rax
  263bd8:	lea    (%rdi,%rdi,2),%rcx
  263bdc:	lea    (%rax,%rcx,8),%rbx
  263be0:	movl   $0x20,0x10(%rax,%rcx,8)
  263be8:	mov    0x28(%rsp),%edx
  263bec:	mov    %edx,0x8(%rax,%rcx,8)
  263bf0:	mov    0x78(%rsp),%edx
  263bf4:	mov    %edx,0xc(%rax,%rcx,8)
  263bf8:	mov    0x30(%rsp),%edx
  263bfc:	or     $0x40,%edx
  263bff:	mov    %dx,0x14(%rax,%rcx,8)
  263c04:	mov    (%rax,%rcx,8),%rax
  263c08:	test   %rax,%rax
  263c0b:	je     263c1c <<glass::engine::Watch>::print_utf8+0x1f8c>
  263c0d:	lock decq (%rax)
  263c11:	jne    263c1c <<glass::engine::Watch>::print_utf8+0x1f8c>
  263c13:	mov    %rbx,%rdi
  263c16:	call   *0x38d2ec(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  263c1c:	movq   $0x0,(%rbx)
  263c23:	mov    0xa0(%rsp),%rax
  263c2b:	cmp    0x58(%rsp),%rax
  263c30:	jb     263c3a <<glass::engine::Watch>::print_utf8+0x1faa>
  263c32:	dec    %rax
  263c35:	movb   $0x1,0x6c(%r14)
  263c3a:	mov    %rax,0x40(%r14)
  263c3e:	incq   0xa0(%r15)
  263c45:	mov    %ebp,0xb0(%r15)
  263c4c:	jmp    263525 <<glass::engine::Watch>::print_utf8+0x1895>
  263c51:	call   18b862 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263c56:	mov    %ebp,%ebx
  263c58:	mov    0x390211(%rip),%rsi        # 5f3e70 <glass::engine::width_of::CACHE+0x8>
  263c5f:	cmp    %rbx,%rsi
  263c62:	ja     2633c2 <<glass::engine::Watch>::print_utf8+0x1732>
  263c68:	lea    0x366db1(%rip),%rdx        # 5caa20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17ca0>
  263c6f:	mov    %rbx,%rdi
  263c72:	call   *0x38d240(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263c78:	lea    0x364011(%rip),%rcx        # 5c7c90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  263c7f:	mov    0xa8(%rsp),%rdi
  263c87:	call   *0x38d3eb(%rip)        # 5f1078 <_DYNAMIC+0x3d8>
  263c8d:	jmp    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  263c92:	lea    0x363ff7(%rip),%rcx        # 5c7c90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  263c99:	call   *0x38d3d9(%rip)        # 5f1078 <_DYNAMIC+0x3d8>
  263c9f:	jmp    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  263ca4:	lea    0x3644dd(%rip),%rdx        # 5c8188 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15408>
  263cab:	call   *0x38d207(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263cb1:	lea    0x3644e8(%rip),%rax        # 5c81a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15420>
  263cb8:	jmp    263cd9 <<glass::engine::Watch>::print_utf8+0x2049>
  263cba:	lea    0x364527(%rip),%rdx        # 5c81e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15468>
  263cc1:	mov    %rbx,%rdi
  263cc4:	mov    0x30(%rsp),%rsi
  263cc9:	call   *0x38d1e9(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263ccf:	mov    %rax,%rbx
  263cd2:	lea    0x3644df(%rip),%rax        # 5c81b8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15438>
  263cd9:	mov    %rax,0xf0(%rsp)
  263ce1:	mov    %rbx,%rdi
  263ce4:	mov    0x30(%rsp),%rsi
  263ce9:	mov    0xf0(%rsp),%rdx
  263cf1:	call   *0x38d1c1(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263cf7:	lea    0x363f92(%rip),%rcx        # 5c7c90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  263cfe:	mov    0x10(%rsp),%rdi
  263d03:	call   *0x38d36f(%rip)        # 5f1078 <_DYNAMIC+0x3d8>
  263d09:	jmp    263d3a <<glass::engine::Watch>::print_utf8+0x20aa>
  263d0b:	lea    0x3645f6(%rip),%rdx        # 5c8308 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15588>
  263d12:	call   *0x38d1a0(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263d18:	lea    0x352649(%rip),%rdx        # 5b6368 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  263d1f:	mov    %rbx,%rdi
  263d22:	call   *0x38d190(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263d28:	lea    0x363f61(%rip),%rcx        # 5c7c90 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  263d2f:	mov    0x10(%rsp),%rdi
  263d34:	call   *0x38d33e(%rip)        # 5f1078 <_DYNAMIC+0x3d8>
  263d3a:	ud2
  263d3c:	lea    0x352625(%rip),%rdx        # 5b6368 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  263d43:	call   *0x38d16f(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263d49:	lea    0x364b10(%rip),%rdx        # 5c8860 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  263d50:	mov    %rbx,%rdi
  263d53:	call   *0x38d15f(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263d59:	lea    0x364ae8(%rip),%rdx        # 5c8848 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  263d60:	mov    %rbx,%rdi
  263d63:	call   *0x38d14f(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263d69:	lea    0x364ad8(%rip),%rdx        # 5c8848 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  263d70:	mov    %r12,%rdi
  263d73:	call   *0x38d13f(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263d79:	lea    0x3525e8(%rip),%rdx        # 5b6368 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  263d80:	mov    %r12,%rdi
  263d83:	call   *0x38d12f(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263d89:	lea    0x364ab8(%rip),%rdx        # 5c8848 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  263d90:	call   *0x38d122(%rip)        # 5f0eb8 <_DYNAMIC+0x218>
  263d96:	mov    %rax,%rbx
  263d99:	lock decq (%r15)
  263d9d:	je     263dc6 <<glass::engine::Watch>::print_utf8+0x2136>
  263d9f:	jmp    263dd4 <<glass::engine::Watch>::print_utf8+0x2144>
  263da1:	mov    %rax,%rbx
  263da4:	mov    0x38(%rsp),%rax
  263da9:	jmp    263dc0 <<glass::engine::Watch>::print_utf8+0x2130>
  263dab:	mov    %rax,%rbx
  263dae:	mov    0x98(%rsp),%rax
  263db6:	jmp    263dc0 <<glass::engine::Watch>::print_utf8+0x2130>
  263db8:	mov    %rax,%rbx
  263dbb:	mov    0x68(%rsp),%rax
  263dc0:	lock decq (%rax)
  263dc4:	jne    263dd4 <<glass::engine::Watch>::print_utf8+0x2144>
  263dc6:	mov    0x110(%rsp),%rdi
  263dce:	call   *0x38d134(%rip)        # 5f0f08 <_DYNAMIC+0x268>
  263dd4:	mov    %rbx,%rdi
  263dd7:	call   5af670 <_Unwind_Resume@plt>
