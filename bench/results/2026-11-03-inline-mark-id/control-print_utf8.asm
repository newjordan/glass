
/tmp/glass-inline-mark-id-control-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000276d20 <<glass::engine::Watch>::print_utf8>:
  276d20:	push   %rbp
  276d21:	push   %r15
  276d23:	push   %r14
  276d25:	push   %r13
  276d27:	push   %r12
  276d29:	push   %rbx
  276d2a:	sub    $0x118,%rsp
  276d31:	mov    %rdx,%r13
  276d34:	mov    %rdi,%r15
  276d37:	cmpb   $0x1,0xbe(%rdi)
  276d3e:	jne    276d6b <<glass::engine::Watch>::print_utf8+0x4b>
  276d40:	cmpq   $0x0,0x38(%r15)
  276d45:	jne    276d6b <<glass::engine::Watch>::print_utf8+0x4b>
  276d47:	mov    0x78(%r15),%rax
  276d4b:	testb  $0x4,0x6c5(%rax)
  276d52:	jne    276d6b <<glass::engine::Watch>::print_utf8+0x4b>
  276d54:	cmpq   $0x0,0x50(%rax)
  276d59:	jne    276d6b <<glass::engine::Watch>::print_utf8+0x4b>
  276d5b:	movzwl 0x64(%rax),%ecx
  276d5f:	test   $0x460,%ecx
  276d65:	je     278490 <<glass::engine::Watch>::print_utf8+0x1770>
  276d6b:	movl   $0x0,0x10(%rsp)
  276d73:	movl   $0x0,0x80(%rsp)
  276d7e:	mov    $0xffffffff,%r8d
  276d84:	xor    %r14d,%r14d
  276d87:	lea    0x388472(%rip),%rax        # 5ff200 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161b8>
  276d8e:	mov    %rax,0xf0(%rsp)
  276d96:	lea    0x40(%rsp),%rax
  276d9b:	mov    %rax,0x110(%rsp)
  276da3:	xor    %edx,%edx
  276da5:	mov    %r13,0xc0(%rsp)
  276dad:	mov    %r15,0xc8(%rsp)
  276db5:	mov    %rsi,0x18(%rsp)
  276dba:	cmpb   $0x0,0x80(%rsp)
  276dc2:	je     2778b9 <<glass::engine::Watch>::print_utf8+0xb99>
  276dc8:	nopl   0x0(%rax,%rax,1)
  276dd0:	mov    0x78(%r15),%rbx
  276dd4:	cmpb   $0x0,0x6c(%rbx)
  276dd8:	jne    2778b9 <<glass::engine::Watch>::print_utf8+0xb99>
  276dde:	mov    0x30(%rbx),%eax
  276de1:	sub    0x48(%rbx),%eax
  276de4:	cltq
  276de6:	mov    0x20(%rbx),%rsi
  276dea:	mov    0x28(%rbx),%rcx
  276dee:	lea    (%rcx,%rax,1),%rdi
  276df2:	dec    %rdi
  276df5:	cmp    %rsi,%rdi
  276df8:	mov    $0x0,%eax
  276dfd:	cmovae %rsi,%rax
  276e01:	sub    %rax,%rdi
  276e04:	cmp    %rsi,%rdi
  276e07:	jae    278d34 <<glass::engine::Watch>::print_utf8+0x2014>
  276e0d:	mov    0xa0(%rbx),%rax
  276e14:	mov    %rax,0x38(%rsp)
  276e19:	mov    0x40(%rbx),%r12
  276e1d:	mov    0x58(%rbx),%eax
  276e20:	mov    %eax,0x78(%rsp)
  276e24:	mov    0x5c(%rbx),%eax
  276e27:	mov    %eax,0xa0(%rsp)
  276e2e:	movzwl 0x64(%rbx),%eax
  276e32:	mov    %eax,0xc(%rsp)
  276e36:	mov    0x18(%rbx),%rax
  276e3a:	shl    $0x6,%rdi
  276e3e:	lea    (%rax,%rdi,1),%rbp
  276e42:	cmp    %r12d,0x38(%rax,%rdi,1)
  276e47:	jbe    276e4d <<glass::engine::Watch>::print_utf8+0x12d>
  276e49:	mov    %r12d,0x38(%rbp)
  276e4d:	mov    %rdx,0x28(%rsp)
  276e52:	mov    0x28(%rbp),%r10d
  276e56:	cmp    $0xffffffff,%r10d
  276e5a:	mov    %r12,0x60(%rsp)
  276e5f:	je     276f19 <<glass::engine::Watch>::print_utf8+0x1f9>
  276e65:	mov    0x30(%rbp),%rax
  276e69:	cmp    %rax,%r12
  276e6c:	mov    $0x0,%ecx
  276e71:	cmovb  %rax,%rcx
  276e75:	mov    %rcx,0x20(%rsp)
  276e7a:	movl   $0x20,0x108(%rsp)
  276e85:	mov    0x78(%rsp),%ecx
  276e89:	mov    %ecx,0x100(%rsp)
  276e90:	mov    0xa0(%rsp),%ecx
  276e97:	mov    %ecx,0x104(%rsp)
  276e9e:	mov    0xc(%rsp),%ecx
  276ea2:	mov    %cx,0x10c(%rsp)
  276eaa:	movq   $0x0,0xf8(%rsp)
  276eb6:	mov    0x10(%rbp),%rcx
  276eba:	cmp    %rax,%rcx
  276ebd:	mov    %rax,%rdx
  276ec0:	cmovb  %rcx,%rdx
  276ec4:	mov    %rdx,0x68(%rsp)
  276ec9:	cmp    %r12,%rcx
  276ecc:	mov    %r12,%r9
  276ecf:	cmovb  %rcx,%r9
  276ed3:	mov    0x3b1c66(%rip),%rdx        # 628b40 <_DYNAMIC+0x320>
  276eda:	movzbl (%rdx),%edx
  276edd:	test   %dl,%dl
  276edf:	je     276fba <<glass::engine::Watch>::print_utf8+0x29a>
  276ee5:	mov    0x3b1c8c(%rip),%rdx        # 628b78 <_DYNAMIC+0x358>
  276eec:	cmp    %r9,%rax
  276eef:	jae    276ef8 <<glass::engine::Watch>::print_utf8+0x1d8>
  276ef1:	mov    0x3b1c88(%rip),%rdx        # 628b80 <_DYNAMIC+0x360>
  276ef8:	lock incq 0x28(%rdx)
  276efd:	mov    0x3b1c54(%rip),%rdx        # 628b58 <_DYNAMIC+0x338>
  276f04:	lock incq (%rdx)
  276f08:	mov    %r9,%rdx
  276f0b:	sub    0x68(%rsp),%rdx
  276f10:	jne    276f6f <<glass::engine::Watch>::print_utf8+0x24f>
  276f12:	xor    %esi,%esi
  276f14:	jmp    276fae <<glass::engine::Watch>::print_utf8+0x28e>
  276f19:	movl   $0x20,0x108(%rsp)
  276f24:	mov    0x78(%rsp),%eax
  276f28:	mov    %eax,0x100(%rsp)
  276f2f:	mov    0xa0(%rsp),%eax
  276f36:	mov    %eax,0x104(%rsp)
  276f3d:	mov    0xc(%rsp),%eax
  276f41:	mov    %ax,0x10c(%rsp)
  276f49:	movq   $0x0,0xf8(%rsp)
  276f55:	lea    0x30(%rbp),%rax
  276f59:	mov    %rax,0xd8(%rsp)
  276f61:	movq   $0xffffffffffffffff,0x20(%rsp)
  276f6a:	jmp    27714a <<glass::engine::Watch>::print_utf8+0x42a>
  276f6f:	mov    0x3b1bea(%rip),%rsi        # 628b60 <_DYNAMIC+0x340>
  276f76:	lock add %rdx,(%rsi)
  276f7a:	cmp    $0x5,%rdx
  276f7e:	jae    276f8e <<glass::engine::Watch>::print_utf8+0x26e>
  276f80:	lea    -0x2172c7(%rip),%rsi        # 5fcc0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  276f87:	movzbl -0x1(%rdx,%rsi,1),%esi
  276f8c:	jmp    276fae <<glass::engine::Watch>::print_utf8+0x28e>
  276f8e:	lea    -0x5(%rdx),%rdi
  276f92:	mov    $0x4,%esi
  276f97:	cmp    $0x4,%rdi
  276f9b:	jb     276fae <<glass::engine::Watch>::print_utf8+0x28e>
  276f9d:	add    $0xfffffffffffffff7,%rdx
  276fa1:	cmp    $0x8,%rdx
  276fa5:	mov    $0x6,%esi
  276faa:	sbb    $0x0,%rsi
  276fae:	mov    0x3b1b9b(%rip),%rdx        # 628b50 <_DYNAMIC+0x330>
  276fb5:	lock incq (%rdx,%rsi,8)
  276fba:	cmp    %r9,%rax
  276fbd:	mov    %r8,0x58(%rsp)
  276fc2:	jae    27710f <<glass::engine::Watch>::print_utf8+0x3ef>
  276fc8:	mov    %rbx,0x98(%rsp)
  276fd0:	mov    %r14,0x30(%rsp)
  276fd5:	mov    0x20(%rbp),%r13d
  276fd9:	mov    0x24(%rbp),%esi
  276fdc:	movzwl 0x2c(%rbp),%edi
  276fe0:	mov    0x18(%rbp),%r12
  276fe4:	test   %r12,%r12
  276fe7:	je     276ff4 <<glass::engine::Watch>::print_utf8+0x2d4>
  276fe9:	lock incq (%r12)
  276fee:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  276ff4:	mov    %r10d,0x50(%rsp)
  276ff9:	mov    %r13d,0x48(%rsp)
  276ffe:	mov    %esi,0x4c(%rsp)
  277002:	mov    %di,0x54(%rsp)
  277007:	mov    %r12,0x40(%rsp)
  27700c:	mov    0x68(%rsp),%rax
  277011:	lea    0x0(,%rax,8),%rax
  277019:	lea    (%rax,%rax,2),%rax
  27701d:	mov    %rbp,0xd0(%rsp)
  277025:	mov    0x8(%rbp),%rbx
  277029:	add    %rax,%rbx
  27702c:	lea    0x0(,%r9,8),%rcx
  277034:	lea    (%rcx,%rcx,2),%rbp
  277038:	sub    %rax,%rbp
  27703b:	mov    %esi,0x70(%rsp)
  27703f:	mov    %di,0x90(%rsp)
  277047:	jmp    27706c <<glass::engine::Watch>::print_utf8+0x34c>
  277049:	nopl   0x0(%rax)
  277050:	mov    %r12,(%rbx)
  277053:	mov    %r13d,0x8(%rbx)
  277057:	mov    %esi,0xc(%rbx)
  27705a:	mov    %r10d,0x10(%rbx)
  27705e:	mov    %di,0x14(%rbx)
  277062:	add    $0x18,%rbx
  277066:	add    $0xffffffffffffffe8,%rbp
  27706a:	je     2770b2 <<glass::engine::Watch>::print_utf8+0x392>
  27706c:	test   %r12,%r12
  27706f:	je     27707c <<glass::engine::Watch>::print_utf8+0x35c>
  277071:	lock incq (%r12)
  277076:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  27707c:	mov    (%rbx),%rax
  27707f:	test   %rax,%rax
  277082:	je     277050 <<glass::engine::Watch>::print_utf8+0x330>
  277084:	lock decq (%rax)
  277088:	jne    277050 <<glass::engine::Watch>::print_utf8+0x330>
  27708a:	mov    %rbx,%rdi
  27708d:	mov    %r9,%r14
  277090:	mov    %r10d,%r15d
  277093:	call   *0x3b19ef(%rip)        # 628a88 <_DYNAMIC+0x268>
  277099:	movzwl 0x90(%rsp),%edi
  2770a1:	mov    0x70(%rsp),%esi
  2770a5:	mov    %r15d,%r10d
  2770a8:	mov    %r14,%r9
  2770ab:	mov    0x58(%rsp),%r8
  2770b0:	jmp    277050 <<glass::engine::Watch>::print_utf8+0x330>
  2770b2:	mov    0xd0(%rsp),%rbp
  2770ba:	mov    0x68(%rsp),%rax
  2770bf:	cmp    %eax,0x38(%rbp)
  2770c2:	jbe    2770c7 <<glass::engine::Watch>::print_utf8+0x3a7>
  2770c4:	mov    %eax,0x38(%rbp)
  2770c7:	test   %r12,%r12
  2770ca:	mov    0xc0(%rsp),%r13
  2770d2:	mov    0xc8(%rsp),%r15
  2770da:	mov    0x30(%rsp),%r14
  2770df:	mov    0x98(%rsp),%rbx
  2770e7:	je     277106 <<glass::engine::Watch>::print_utf8+0x3e6>
  2770e9:	lock decq (%r12)
  2770ee:	jne    277106 <<glass::engine::Watch>::print_utf8+0x3e6>
  2770f0:	lea    0x40(%rsp),%rdi
  2770f5:	mov    %r9,%r12
  2770f8:	call   *0x3b198a(%rip)        # 628a88 <_DYNAMIC+0x268>
  2770fe:	mov    %r12,%r9
  277101:	mov    0x58(%rsp),%r8
  277106:	mov    0x10(%rbp),%rcx
  27710a:	mov    0x60(%rsp),%r12
  27710f:	lea    0x30(%rbp),%rax
  277113:	mov    %rax,0xd8(%rsp)
  27711b:	cmp    %rcx,%r9
  27711e:	jb     27714a <<glass::engine::Watch>::print_utf8+0x42a>
  277120:	cmpl   $0xffffffff,0x28(%rbp)
  277124:	je     277143 <<glass::engine::Watch>::print_utf8+0x423>
  277126:	lea    0x18(%rbp),%rdi
  27712a:	mov    (%rdi),%rax
  27712d:	test   %rax,%rax
  277130:	je     277143 <<glass::engine::Watch>::print_utf8+0x423>
  277132:	lock decq (%rax)
  277136:	jne    277143 <<glass::engine::Watch>::print_utf8+0x423>
  277138:	call   *0x3b194a(%rip)        # 628a88 <_DYNAMIC+0x268>
  27713e:	mov    0x58(%rsp),%r8
  277143:	movl   $0xffffffff,0x28(%rbp)
  27714a:	mov    0x10(%rbp),%rdx
  27714e:	mov    0x30(%rbp),%rax
  277152:	cmp    %r12,%rdx
  277155:	mov    %r12,%rsi
  277158:	cmovb  %rdx,%rsi
  27715c:	cmp    %rax,%rsi
  27715f:	cmova  %rsi,%rax
  277163:	mov    %rdx,%rcx
  277166:	mov    %rax,0x30(%rbp)
  27716a:	sub    %r12,%rcx
  27716d:	mov    %rcx,0x30(%rsp)
  277172:	jb     2786be <<glass::engine::Watch>::print_utf8+0x199e>
  277178:	mov    0x28(%rsp),%rdx
  27717d:	cmp    %r13,%rdx
  277180:	jae    277780 <<glass::engine::Watch>::print_utf8+0xa60>
  277186:	mov    %rbx,0x98(%rsp)
  27718e:	mov    %rbp,0xd0(%rsp)
  277196:	mov    0x8(%rbp),%rcx
  27719a:	lea    (%r12,%r12,2),%rax
  27719e:	mov    %rcx,0x70(%rsp)
  2771a3:	lea    (%rcx,%rax,8),%rax
  2771a7:	mov    %rax,0xb8(%rsp)
  2771af:	mov    0xc(%rsp),%eax
  2771b3:	mov    %eax,%ecx
  2771b5:	or     $0x20,%ecx
  2771b8:	mov    %ecx,0x8c(%rsp)
  2771bf:	or     $0x40,%eax
  2771c2:	mov    %eax,0xa8(%rsp)
  2771c9:	mov    $0x1,%al
  2771cb:	mov    %eax,0x90(%rsp)
  2771d2:	xor    %r11d,%r11d
  2771d5:	xor    %edi,%edi
  2771d7:	mov    %r12,%rbx
  2771da:	mov    %r12,%r10
  2771dd:	mov    0x18(%rsp),%rsi
  2771e2:	jmp    27724f <<glass::engine::Watch>::print_utf8+0x52f>
  2771e4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  2771f0:	movq   $0x0,(%rbx)
  2771f7:	mov    0x78(%rsp),%eax
  2771fb:	mov    %eax,0x8(%rbx)
  2771fe:	mov    0xa0(%rsp),%eax
  277205:	mov    %eax,0xc(%rbx)
  277208:	movl   $0x20,0x10(%rbx)
  27720f:	mov    0xa8(%rsp),%eax
  277216:	mov    %ax,0x14(%rbx)
  27721a:	movl   $0x0,0x90(%rsp)
  277225:	xor    %r11d,%r11d
  277228:	cmp    0x38(%rsp),%r9
  27722d:	setae  %r11b
  277231:	mov    %r9,%r10
  277234:	sub    %r11,%r10
  277237:	inc    %rdi
  27723a:	mov    %r9,%rbx
  27723d:	add    %r15,%rdx
  277240:	mov    %ebp,%r8d
  277243:	mov    %r15,%r14
  277246:	cmp    %r13,%rdx
  277249:	jae    27779d <<glass::engine::Watch>::print_utf8+0xa7d>
  27724f:	mov    %rdx,%r15
  277252:	movzbl (%rsi,%rdx,1),%ebp
  277256:	test   %bpl,%bpl
  277259:	js     277280 <<glass::engine::Watch>::print_utf8+0x560>
  27725b:	mov    $0x1,%edx
  277260:	lea    -0x7f(%rbp),%eax
  277263:	cmp    $0x21,%eax
  277266:	jae    2773e8 <<glass::engine::Watch>::print_utf8+0x6c8>
  27726c:	jmp    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277271:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  277280:	lea    0x3e(%rbp),%eax
  277283:	cmp    $0x1e,%al
  277285:	jae    2772b0 <<glass::engine::Watch>::print_utf8+0x590>
  277287:	lea    0x1(%r15),%rax
  27728b:	cmp    %r13,%rax
  27728e:	jae    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277294:	movzbl (%rsi,%rax,1),%eax
  277298:	cmp    $0xc0,%al
  27729a:	jge    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  2772a0:	and    $0x1f,%ebp
  2772a3:	shl    $0x6,%ebp
  2772a6:	mov    $0x2,%edx
  2772ab:	jmp    2773bb <<glass::engine::Watch>::print_utf8+0x69b>
  2772b0:	mov    %ebp,%eax
  2772b2:	and    $0xf0,%al
  2772b4:	cmp    $0xe0,%al
  2772b6:	jne    2772d0 <<glass::engine::Watch>::print_utf8+0x5b0>
  2772b8:	mov    $0xbf,%al
  2772ba:	cmp    $0xe0,%ebp
  2772c0:	je     2772f3 <<glass::engine::Watch>::print_utf8+0x5d3>
  2772c2:	mov    $0x80,%cl
  2772c4:	cmp    $0xed,%ebp
  2772ca:	jne    2772f5 <<glass::engine::Watch>::print_utf8+0x5d5>
  2772cc:	mov    $0x9f,%al
  2772ce:	jmp    2772f5 <<glass::engine::Watch>::print_utf8+0x5d5>
  2772d0:	lea    0x10(%rbp),%eax
  2772d3:	cmp    $0x5,%al
  2772d5:	jae    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  2772db:	mov    $0x80,%al
  2772dd:	cmp    $0xf4,%ebp
  2772e3:	je     277347 <<glass::engine::Watch>::print_utf8+0x627>
  2772e5:	mov    $0xbf,%cl
  2772e7:	cmp    $0xf0,%ebp
  2772ed:	jne    277349 <<glass::engine::Watch>::print_utf8+0x629>
  2772ef:	mov    $0x90,%al
  2772f1:	jmp    277349 <<glass::engine::Watch>::print_utf8+0x629>
  2772f3:	mov    $0xa0,%cl
  2772f5:	lea    0x1(%r15),%rdx
  2772f9:	cmp    %r13,%rdx
  2772fc:	jae    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277302:	movzbl (%rsi,%rdx,1),%edx
  277306:	cmp    %dl,%cl
  277308:	ja     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  27730e:	cmp    %al,%dl
  277310:	ja     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277316:	lea    0x2(%r15),%rax
  27731a:	cmp    %r13,%rax
  27731d:	jae    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277323:	movzbl (%rsi,%rax,1),%eax
  277327:	cmp    $0xc0,%al
  277329:	jge    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  27732f:	movzbl %dl,%ecx
  277332:	and    $0x3f,%ecx
  277335:	shl    $0x6,%ecx
  277338:	and    $0xf,%ebp
  27733b:	shl    $0xc,%ebp
  27733e:	or     %ecx,%ebp
  277340:	mov    $0x3,%edx
  277345:	jmp    2773bb <<glass::engine::Watch>::print_utf8+0x69b>
  277347:	mov    $0x8f,%cl
  277349:	lea    0x1(%r15),%rdx
  27734d:	cmp    %r13,%rdx
  277350:	jae    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277356:	movzbl (%rsi,%rdx,1),%edx
  27735a:	cmp    %dl,%al
  27735c:	ja     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277362:	cmp    %cl,%dl
  277364:	ja     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  27736a:	lea    0x2(%r15),%rax
  27736e:	cmp    %r13,%rax
  277371:	jae    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277377:	movzbl (%rsi,%rax,1),%ecx
  27737b:	cmp    $0xbf,%cl
  27737e:	jg     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277384:	lea    0x3(%r15),%rax
  277388:	cmp    %r13,%rax
  27738b:	jae    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277391:	movzbl (%rsi,%rax,1),%eax
  277395:	cmp    $0xbf,%al
  277397:	jg     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  27739d:	movzbl %dl,%edx
  2773a0:	and    $0x3f,%ecx
  2773a3:	shl    $0x6,%ecx
  2773a6:	and    $0x3f,%edx
  2773a9:	shl    $0xc,%edx
  2773ac:	and    $0x7,%ebp
  2773af:	shl    $0x12,%ebp
  2773b2:	or     %edx,%ebp
  2773b4:	or     %ecx,%ebp
  2773b6:	mov    $0x4,%edx
  2773bb:	mov    %ebp,%ecx
  2773bd:	xor    $0xd800,%ecx
  2773c3:	add    $0xffef0000,%ecx
  2773c9:	cmp    $0xffef0800,%ecx
  2773cf:	jb     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  2773d5:	and    $0x3f,%al
  2773d7:	movzbl %al,%eax
  2773da:	or     %eax,%ebp
  2773dc:	lea    -0x7f(%rbp),%eax
  2773df:	cmp    $0x21,%eax
  2773e2:	jb     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  2773e8:	cmp    $0xffffffff,%r8d
  2773ec:	je     277410 <<glass::engine::Watch>::print_utf8+0x6f0>
  2773ee:	lea    -0x20(%r8),%eax
  2773f2:	cmp    $0x5f,%eax
  2773f5:	jae    277420 <<glass::engine::Watch>::print_utf8+0x700>
  2773f7:	mov    $0x1,%ecx
  2773fc:	cmpb   $0x0,0x10(%rsp)
  277401:	jne    27751b <<glass::engine::Watch>::print_utf8+0x7fb>
  277407:	jmp    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  27740c:	nopl   0x0(%rax)
  277410:	mov    %rbx,%r9
  277413:	jmp    27723d <<glass::engine::Watch>::print_utf8+0x51d>
  277418:	nopl   0x0(%rax,%rax,1)
  277420:	mov    %rbx,0x68(%rsp)
  277425:	mov    0x3b464d(%rip),%eax        # 62ba78 <glass::engine::width_of::CACHE+0x10>
  27742b:	test   %eax,%eax
  27742d:	jne    27770e <<glass::engine::Watch>::print_utf8+0x9ee>
  277433:	mov    %r8d,%ebx
  277436:	mov    0x3b4633(%rip),%rsi        # 62ba70 <glass::engine::width_of::CACHE+0x8>
  27743d:	cmp    %rbx,%rsi
  277440:	jbe    278cf8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  277446:	mov    0x3b461b(%rip),%r12        # 62ba68 <glass::engine::width_of::CACHE>
  27744d:	movzbl (%r12,%rbx,1),%eax
  277452:	movzbl %al,%ecx
  277455:	test   %cl,%cl
  277457:	mov    %rdx,0x28(%rsp)
  27745c:	js     277477 <<glass::engine::Watch>::print_utf8+0x757>
  27745e:	mov    $0x1,%dl
  277460:	mov    0x18(%rsp),%rsi
  277465:	test   %dl,%dl
  277467:	mov    0x68(%rsp),%rbx
  27746c:	jne    277503 <<glass::engine::Watch>::print_utf8+0x7e3>
  277472:	jmp    2777fd <<glass::engine::Watch>::print_utf8+0xadd>
  277477:	cmp    $0xfe,%ecx
  27747d:	mov    0x18(%rsp),%rsi
  277482:	je     27781d <<glass::engine::Watch>::print_utf8+0xafd>
  277488:	mov    $0xfe,%al
  27748a:	cmp    $0x7f,%r8d
  27748e:	jae    277499 <<glass::engine::Watch>::print_utf8+0x779>
  277490:	mov    $0x1,%ecx
  277495:	xor    %edx,%edx
  277497:	jmp    2774f2 <<glass::engine::Watch>::print_utf8+0x7d2>
  277499:	cmp    $0xa0,%r8d
  2774a0:	jb     2774f0 <<glass::engine::Watch>::print_utf8+0x7d0>
  2774a2:	mov    %rdi,0xb0(%rsp)
  2774aa:	mov    %r8d,%edi
  2774ad:	mov    %r8,0x58(%rsp)
  2774b2:	mov    %r10,0xe8(%rsp)
  2774ba:	mov    %r11,0xe0(%rsp)
  2774c2:	call   2ad680 <unicode_width::tables::lookup_width>
  2774c7:	mov    0xe0(%rsp),%r11
  2774cf:	mov    0xe8(%rsp),%r10
  2774d7:	mov    0xb0(%rsp),%rdi
  2774df:	mov    0x58(%rsp),%r8
  2774e4:	mov    0x18(%rsp),%rsi
  2774e9:	movzbl %al,%ecx
  2774ec:	mov    $0x1,%dl
  2774ee:	jmp    2774f2 <<glass::engine::Watch>::print_utf8+0x7d2>
  2774f0:	xor    %edx,%edx
  2774f2:	mov    %al,(%r12,%rbx,1)
  2774f6:	test   %dl,%dl
  2774f8:	mov    0x68(%rsp),%rbx
  2774fd:	je     2777fd <<glass::engine::Watch>::print_utf8+0xadd>
  277503:	lea    -0x1(%rcx),%rax
  277507:	cmp    $0x1,%rax
  27750b:	mov    0x28(%rsp),%rdx
  277510:	mov    0x60(%rsp),%r12
  277515:	ja     277794 <<glass::engine::Watch>::print_utf8+0xa74>
  27751b:	test   $0x1,%r11b
  27751f:	jne    27778c <<glass::engine::Watch>::print_utf8+0xa6c>
  277525:	lea    (%rcx,%r10,1),%rax
  277529:	cmp    0x38(%rsp),%rax
  27752e:	ja     277791 <<glass::engine::Watch>::print_utf8+0xa71>
  277534:	mov    %rax,0x58(%rsp)
  277539:	mov    %rbx,%r9
  27753c:	mov    %r10,%rbx
  27753f:	sub    %r12,%rbx
  277542:	cmp    0x20(%rsp),%r10
  277547:	jae    2775b0 <<glass::engine::Watch>::print_utf8+0x890>
  277549:	cmp    0x30(%rsp),%rbx
  27754e:	mov    0x70(%rsp),%r11
  277553:	jae    278d41 <<glass::engine::Watch>::print_utf8+0x2021>
  277559:	lea    (%r10,%r10,2),%rax
  27755d:	testb  $0x60,0x14(%r11,%rax,8)
  277563:	jne    2777f8 <<glass::engine::Watch>::print_utf8+0xad8>
  277569:	lea    (%r11,%rax,8),%r12
  27756d:	cmp    $0x2,%rcx
  277571:	jne    277642 <<glass::engine::Watch>::print_utf8+0x922>
  277577:	lea    0x1(%rbx),%rax
  27757b:	cmp    0x30(%rsp),%rax
  277580:	jae    278d5f <<glass::engine::Watch>::print_utf8+0x203f>
  277586:	mov    %r14,%rcx
  277589:	lea    (%rax,%rax,2),%rax
  27758d:	mov    $0x1,%r14b
  277590:	mov    0xb8(%rsp),%r13
  277598:	testb  $0x60,0x14(%r13,%rax,8)
  27759e:	mov    0x8c(%rsp),%r13d
  2775a6:	je     2775de <<glass::engine::Watch>::print_utf8+0x8be>
  2775a8:	jmp    277802 <<glass::engine::Watch>::print_utf8+0xae2>
  2775ad:	nopl   (%rax)
  2775b0:	cmp    0x30(%rsp),%rbx
  2775b5:	mov    0x70(%rsp),%r11
  2775ba:	jae    278d71 <<glass::engine::Watch>::print_utf8+0x2051>
  2775c0:	lea    (%r10,%r10,2),%rax
  2775c4:	lea    (%r11,%rax,8),%r12
  2775c8:	cmp    $0x2,%rcx
  2775cc:	sete   %r14b
  2775d0:	mov    0xc(%rsp),%r13d
  2775d5:	cmove  0x8c(%rsp),%r13d
  2775de:	mov    (%r12),%rax
  2775e2:	test   %rax,%rax
  2775e5:	je     277660 <<glass::engine::Watch>::print_utf8+0x940>
  2775e7:	lock decq (%rax)
  2775eb:	jne    277660 <<glass::engine::Watch>::print_utf8+0x940>
  2775ed:	mov    %rdi,0xb0(%rsp)
  2775f5:	mov    %r12,%rdi
  2775f8:	mov    %r15,0xe0(%rsp)
  277600:	mov    %r8,%r15
  277603:	mov    %rdx,0x28(%rsp)
  277608:	mov    %r10,0xe8(%rsp)
  277610:	call   *0x3b1472(%rip)        # 628a88 <_DYNAMIC+0x268>
  277616:	mov    0x70(%rsp),%r11
  27761b:	mov    0xe8(%rsp),%r10
  277623:	mov    0xb0(%rsp),%rdi
  27762b:	mov    0x28(%rsp),%rdx
  277630:	mov    %r15,%r8
  277633:	mov    0xe0(%rsp),%r15
  27763b:	mov    0x18(%rsp),%rsi
  277640:	jmp    277660 <<glass::engine::Watch>::print_utf8+0x940>
  277642:	xor    %r14d,%r14d
  277645:	mov    0xc(%rsp),%r13d
  27764a:	mov    (%r12),%rax
  27764e:	test   %rax,%rax
  277651:	jne    2775e7 <<glass::engine::Watch>::print_utf8+0x8c7>
  277653:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  277660:	lea    (%r10,%r10,2),%rax
  277664:	movq   $0x0,(%r12)
  27766c:	mov    0x78(%rsp),%ecx
  277670:	mov    %ecx,0x8(%r11,%rax,8)
  277675:	mov    0xa0(%rsp),%ecx
  27767c:	mov    %ecx,0xc(%r11,%rax,8)
  277681:	mov    %r13w,0x14(%r11,%rax,8)
  277687:	mov    %r8d,0x10(%r11,%rax,8)
  27768c:	test   %r14b,%r14b
  27768f:	mov    0xc0(%rsp),%r13
  277697:	mov    0x60(%rsp),%r12
  27769c:	mov    0x58(%rsp),%r9
  2776a1:	je     277225 <<glass::engine::Watch>::print_utf8+0x505>
  2776a7:	inc    %rbx
  2776aa:	cmp    0x30(%rsp),%rbx
  2776af:	jae    278d4a <<glass::engine::Watch>::print_utf8+0x202a>
  2776b5:	lea    (%rbx,%rbx,2),%rax
  2776b9:	mov    0xb8(%rsp),%rcx
  2776c1:	lea    (%rcx,%rax,8),%rbx
  2776c5:	mov    (%rcx,%rax,8),%rax
  2776c9:	test   %rax,%rax
  2776cc:	je     2771f0 <<glass::engine::Watch>::print_utf8+0x4d0>
  2776d2:	lock decq (%rax)
  2776d6:	jne    2771f0 <<glass::engine::Watch>::print_utf8+0x4d0>
  2776dc:	mov    %r15,%r13
  2776df:	mov    %rdi,%r15
  2776e2:	mov    %rbx,%rdi
  2776e5:	mov    %rdx,%r14
  2776e8:	call   *0x3b139a(%rip)        # 628a88 <_DYNAMIC+0x268>
  2776ee:	mov    0x58(%rsp),%r9
  2776f3:	mov    %r15,%rdi
  2776f6:	mov    %r13,%r15
  2776f9:	mov    0xc0(%rsp),%r13
  277701:	mov    %r14,%rdx
  277704:	mov    0x18(%rsp),%rsi
  277709:	jmp    2771f0 <<glass::engine::Watch>::print_utf8+0x4d0>
  27770e:	mov    %r8,0x58(%rsp)
  277713:	mov    %r15,0xe0(%rsp)
  27771b:	mov    %rdx,%r15
  27771e:	mov    %rdi,0xb0(%rsp)
  277726:	mov    %r10,0xe8(%rsp)
  27772e:	mov    %r11,%r12
  277731:	call   1930a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  277736:	mov    %r12,%r11
  277739:	mov    0xe8(%rsp),%r10
  277741:	mov    0xb0(%rsp),%rdi
  277749:	mov    %r15,%rdx
  27774c:	mov    0xe0(%rsp),%r15
  277754:	mov    0x58(%rsp),%r8
  277759:	mov    %r8d,%ebx
  27775c:	mov    0x3b430d(%rip),%rsi        # 62ba70 <glass::engine::width_of::CACHE+0x8>
  277763:	cmp    %rbx,%rsi
  277766:	ja     277446 <<glass::engine::Watch>::print_utf8+0x726>
  27776c:	jmp    278cf8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  277771:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  277780:	xor    %edi,%edi
  277782:	xor    %r11d,%r11d
  277785:	mov    0x18(%rsp),%rsi
  27778a:	jmp    2777e4 <<glass::engine::Watch>::print_utf8+0xac4>
  27778c:	mov    $0x1,%r11b
  27778f:	jmp    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277791:	xor    %r11d,%r11d
  277794:	mov    %rbx,%r9
  277797:	mov    %r8d,%ebp
  27779a:	mov    %r15,%rdx
  27779d:	cmp    %r12,%r9
  2777a0:	jbe    2777b7 <<glass::engine::Watch>::print_utf8+0xa97>
  2777a2:	mov    0xd8(%rsp),%rcx
  2777aa:	mov    (%rcx),%rax
  2777ad:	cmp    %rax,%r9
  2777b0:	cmova  %r9,%rax
  2777b4:	mov    %rax,(%rcx)
  2777b7:	cmp    $0x8,%rdi
  2777bb:	setae  %al
  2777be:	testb  $0x1,0x90(%rsp)
  2777c6:	mov    0xc8(%rsp),%r15
  2777ce:	jne    2777d2 <<glass::engine::Watch>::print_utf8+0xab2>
  2777d0:	xor    %eax,%eax
  2777d2:	test   %al,%al
  2777d4:	jne    277832 <<glass::engine::Watch>::print_utf8+0xb12>
  2777d6:	mov    %r10,%r12
  2777d9:	mov    %ebp,%r8d
  2777dc:	mov    0x98(%rsp),%rbx
  2777e4:	mov    %r12,0x40(%rbx)
  2777e8:	mov    %r11b,0x6c(%rbx)
  2777ec:	add    %rdi,0xa0(%r15)
  2777f3:	jmp    2778b9 <<glass::engine::Watch>::print_utf8+0xb99>
  2777f8:	xor    %r11d,%r11d
  2777fb:	jmp    277797 <<glass::engine::Watch>::print_utf8+0xa77>
  2777fd:	mov    %rbx,%r9
  277800:	jmp    277822 <<glass::engine::Watch>::print_utf8+0xb02>
  277802:	xor    %r11d,%r11d
  277805:	mov    %r8d,%ebp
  277808:	mov    %r15,%rdx
  27780b:	mov    0xc0(%rsp),%r13
  277813:	mov    %rcx,%r14
  277816:	mov    0x60(%rsp),%r12
  27781b:	jmp    27779d <<glass::engine::Watch>::print_utf8+0xa7d>
  27781d:	mov    0x68(%rsp),%r9
  277822:	mov    %r8d,%ebp
  277825:	mov    %r15,%rdx
  277828:	mov    0x60(%rsp),%r12
  27782d:	jmp    27779d <<glass::engine::Watch>::print_utf8+0xa7d>
  277832:	mov    %rdx,0x28(%rsp)
  277837:	movzbl %r11b,%edx
  27783b:	add    %r10,%rdx
  27783e:	mov    %rdi,0xb0(%rsp)
  277846:	mov    0xd0(%rsp),%rdi
  27784e:	mov    %r12,%rsi
  277851:	lea    0xf8(%rsp),%rcx
  277859:	mov    %r10,%r12
  27785c:	mov    %r11,%rbx
  27785f:	call   2bbb50 <glass::engine::note_uniform_span>
  277864:	mov    %rbx,%r11
  277867:	mov    0xb0(%rsp),%rdi
  27786f:	mov    0x28(%rsp),%rdx
  277874:	mov    0x18(%rsp),%rsi
  277879:	jmp    2777d9 <<glass::engine::Watch>::print_utf8+0xab9>
  27787e:	xchg   %ax,%ax
  277880:	mov    0xc8(%rsp),%r15
  277888:	mov    %r15,%rdi
  27788b:	mov    %ebp,%esi
  27788d:	mov    %r8,%rbx
  277890:	mov    %rdx,%r14
  277893:	call   3574d0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  277898:	mov    %r14,%rdx
  27789b:	mov    %rbx,%r8
  27789e:	mov    0x18(%rsp),%rsi
  2778a3:	mov    0x30(%rsp),%r14
  2778a8:	add    %r14,%rdx
  2778ab:	cmpb   $0x0,0x80(%rsp)
  2778b3:	jne    276dd0 <<glass::engine::Watch>::print_utf8+0xb0>
  2778b9:	mov    %r8d,%ebp
  2778bc:	mov    %r14,%rbx
  2778bf:	mov    %rdx,%r14
  2778c2:	cmp    %r13,%rdx
  2778c5:	jae    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  2778cb:	movzbl (%rsi,%r14,1),%r8d
  2778d0:	test   %r8b,%r8b
  2778d3:	js     2778f0 <<glass::engine::Watch>::print_utf8+0xbd0>
  2778d5:	mov    $0x1,%edx
  2778da:	lea    -0x7f(%r8),%eax
  2778de:	cmp    $0x21,%eax
  2778e1:	jae    277a78 <<glass::engine::Watch>::print_utf8+0xd58>
  2778e7:	jmp    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  2778ec:	nopl   0x0(%rax)
  2778f0:	lea    0x3e(%r8),%eax
  2778f4:	cmp    $0x1e,%al
  2778f6:	jae    277930 <<glass::engine::Watch>::print_utf8+0xc10>
  2778f8:	lea    0x1(%r14),%rax
  2778fc:	cmp    %r13,%rax
  2778ff:	jae    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277905:	movzbl (%rsi,%rax,1),%eax
  277909:	cmp    $0xc0,%al
  27790b:	jge    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277911:	and    $0x1f,%r8d
  277915:	shl    $0x6,%r8d
  277919:	mov    $0x2,%edx
  27791e:	jmp    277a48 <<glass::engine::Watch>::print_utf8+0xd28>
  277923:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  277930:	mov    %r8d,%eax
  277933:	and    $0xf0,%al
  277935:	cmp    $0xe0,%al
  277937:	jne    277953 <<glass::engine::Watch>::print_utf8+0xc33>
  277939:	mov    $0xbf,%al
  27793b:	cmp    $0xe0,%r8d
  277942:	je     277979 <<glass::engine::Watch>::print_utf8+0xc59>
  277944:	mov    $0x80,%cl
  277946:	cmp    $0xed,%r8d
  27794d:	jne    27797b <<glass::engine::Watch>::print_utf8+0xc5b>
  27794f:	mov    $0x9f,%al
  277951:	jmp    27797b <<glass::engine::Watch>::print_utf8+0xc5b>
  277953:	lea    0x10(%r8),%eax
  277957:	cmp    $0x5,%al
  277959:	jae    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  27795f:	mov    $0x80,%al
  277961:	cmp    $0xf4,%r8d
  277968:	je     2779d0 <<glass::engine::Watch>::print_utf8+0xcb0>
  27796a:	mov    $0xbf,%cl
  27796c:	cmp    $0xf0,%r8d
  277973:	jne    2779d2 <<glass::engine::Watch>::print_utf8+0xcb2>
  277975:	mov    $0x90,%al
  277977:	jmp    2779d2 <<glass::engine::Watch>::print_utf8+0xcb2>
  277979:	mov    $0xa0,%cl
  27797b:	lea    0x1(%r14),%rdx
  27797f:	cmp    %r13,%rdx
  277982:	jae    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277988:	movzbl (%rsi,%rdx,1),%edx
  27798c:	cmp    %dl,%cl
  27798e:	ja     27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277994:	cmp    %al,%dl
  277996:	ja     27839e <<glass::engine::Watch>::print_utf8+0x167e>
  27799c:	lea    0x2(%r14),%rax
  2779a0:	cmp    %r13,%rax
  2779a3:	jae    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  2779a9:	movzbl (%rsi,%rax,1),%eax
  2779ad:	cmp    $0xc0,%al
  2779af:	jge    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  2779b5:	movzbl %dl,%ecx
  2779b8:	and    $0x3f,%ecx
  2779bb:	shl    $0x6,%ecx
  2779be:	and    $0xf,%r8d
  2779c2:	shl    $0xc,%r8d
  2779c6:	or     %ecx,%r8d
  2779c9:	mov    $0x3,%edx
  2779ce:	jmp    277a48 <<glass::engine::Watch>::print_utf8+0xd28>
  2779d0:	mov    $0x8f,%cl
  2779d2:	lea    0x1(%r14),%rdx
  2779d6:	cmp    %r13,%rdx
  2779d9:	jae    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  2779df:	movzbl (%rsi,%rdx,1),%edx
  2779e3:	cmp    %dl,%al
  2779e5:	ja     27839e <<glass::engine::Watch>::print_utf8+0x167e>
  2779eb:	cmp    %cl,%dl
  2779ed:	ja     27839e <<glass::engine::Watch>::print_utf8+0x167e>
  2779f3:	lea    0x2(%r14),%rax
  2779f7:	cmp    %r13,%rax
  2779fa:	jae    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277a00:	movzbl (%rsi,%rax,1),%ecx
  277a04:	cmp    $0xbf,%cl
  277a07:	jg     27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277a0d:	lea    0x3(%r14),%rax
  277a11:	cmp    %r13,%rax
  277a14:	jae    27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277a1a:	movzbl (%rsi,%rax,1),%eax
  277a1e:	cmp    $0xbf,%al
  277a20:	jg     27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277a26:	movzbl %dl,%edx
  277a29:	and    $0x3f,%ecx
  277a2c:	shl    $0x6,%ecx
  277a2f:	and    $0x3f,%edx
  277a32:	shl    $0xc,%edx
  277a35:	and    $0x7,%r8d
  277a39:	shl    $0x12,%r8d
  277a3d:	or     %edx,%r8d
  277a40:	or     %ecx,%r8d
  277a43:	mov    $0x4,%edx
  277a48:	mov    %r8d,%ecx
  277a4b:	xor    $0xd800,%ecx
  277a51:	add    $0xffef0000,%ecx
  277a57:	cmp    $0xffef0800,%ecx
  277a5d:	jb     27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277a63:	and    $0x3f,%al
  277a65:	movzbl %al,%eax
  277a68:	or     %eax,%r8d
  277a6b:	lea    -0x7f(%r8),%eax
  277a6f:	cmp    $0x21,%eax
  277a72:	jb     27839e <<glass::engine::Watch>::print_utf8+0x167e>
  277a78:	cmp    $0xffffffff,%ebp
  277a7b:	je     278360 <<glass::engine::Watch>::print_utf8+0x1640>
  277a81:	mov    %r14,0x30(%rsp)
  277a86:	lea    -0x20(%rbp),%eax
  277a89:	cmp    $0x5f,%eax
  277a8c:	jae    277ab0 <<glass::engine::Watch>::print_utf8+0xd90>
  277a8e:	mov    $0x1,%r12d
  277a94:	cmpb   $0x0,0x10(%rsp)
  277a99:	je     277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277a9f:	jmp    277b5c <<glass::engine::Watch>::print_utf8+0xe3c>
  277aa4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  277ab0:	cmpb   $0x0,0x80(%rsp)
  277ab8:	je     277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277abe:	mov    0x3b3fb4(%rip),%eax        # 62ba78 <glass::engine::width_of::CACHE+0x10>
  277ac4:	test   %eax,%eax
  277ac6:	jne    278376 <<glass::engine::Watch>::print_utf8+0x1656>
  277acc:	mov    %ebp,%ebx
  277ace:	mov    0x3b3f9b(%rip),%rsi        # 62ba70 <glass::engine::width_of::CACHE+0x8>
  277ad5:	cmp    %rbx,%rsi
  277ad8:	jbe    278cf8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  277ade:	mov    0x3b3f83(%rip),%r14        # 62ba68 <glass::engine::width_of::CACHE>
  277ae5:	movzbl (%r14,%rbx,1),%eax
  277aea:	movzbl %al,%r12d
  277aee:	test   %r12b,%r12b
  277af1:	js     277afe <<glass::engine::Watch>::print_utf8+0xdde>
  277af3:	mov    $0x1,%cl
  277af5:	test   %cl,%cl
  277af7:	jne    277b4d <<glass::engine::Watch>::print_utf8+0xe2d>
  277af9:	jmp    277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277afe:	cmp    $0xfe,%r12d
  277b05:	je     277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277b0b:	mov    $0xfe,%al
  277b0d:	cmp    $0x7f,%ebp
  277b10:	jae    277b1c <<glass::engine::Watch>::print_utf8+0xdfc>
  277b12:	mov    $0x1,%r12d
  277b18:	xor    %ecx,%ecx
  277b1a:	jmp    277b41 <<glass::engine::Watch>::print_utf8+0xe21>
  277b1c:	cmp    $0xa0,%ebp
  277b22:	jb     277b3f <<glass::engine::Watch>::print_utf8+0xe1f>
  277b24:	mov    %ebp,%edi
  277b26:	mov    %r8,%r15
  277b29:	mov    %rdx,%r12
  277b2c:	call   2ad680 <unicode_width::tables::lookup_width>
  277b31:	mov    %r12,%rdx
  277b34:	mov    %r15,%r8
  277b37:	movzbl %al,%r12d
  277b3b:	mov    $0x1,%cl
  277b3d:	jmp    277b41 <<glass::engine::Watch>::print_utf8+0xe21>
  277b3f:	xor    %ecx,%ecx
  277b41:	mov    %al,(%r14,%rbx,1)
  277b45:	test   %cl,%cl
  277b47:	je     277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277b4d:	lea    -0x1(%r12),%rax
  277b52:	cmp    $0x1,%rax
  277b56:	ja     277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277b5c:	mov    0xc8(%rsp),%rax
  277b64:	mov    0x78(%rax),%r9
  277b68:	cmpb   $0x0,0x6c(%r9)
  277b6d:	jne    277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277b73:	mov    0x40(%r9),%rbx
  277b77:	mov    0xa0(%r9),%r11
  277b7e:	lea    (%rbx,%r12,1),%r10
  277b82:	cmp    %r11,%r10
  277b85:	ja     277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277b8b:	mov    0x30(%r9),%eax
  277b8f:	sub    0x48(%r9),%eax
  277b93:	cltq
  277b95:	mov    0x20(%r9),%rsi
  277b99:	mov    0x28(%r9),%rcx
  277b9d:	lea    (%rcx,%rax,1),%rdi
  277ba1:	dec    %rdi
  277ba4:	cmp    %rsi,%rdi
  277ba7:	mov    $0x0,%eax
  277bac:	cmovae %rsi,%rax
  277bb0:	sub    %rax,%rdi
  277bb3:	cmp    %rsi,%rdi
  277bb6:	jae    278d9b <<glass::engine::Watch>::print_utf8+0x207b>
  277bbc:	mov    0x58(%r9),%eax
  277bc0:	mov    %eax,0x58(%rsp)
  277bc4:	mov    0x5c(%r9),%eax
  277bc8:	mov    %eax,0xa0(%rsp)
  277bcf:	movzwl 0x64(%r9),%r14d
  277bd4:	mov    0x18(%r9),%rax
  277bd8:	shl    $0x6,%rdi
  277bdc:	lea    (%rax,%rdi,1),%r15
  277be0:	lea    (%rax,%rdi,1),%rcx
  277be4:	add    $0x18,%rcx
  277be8:	mov    %rcx,0x78(%rsp)
  277bed:	mov    0x28(%rax,%rdi,1),%eax
  277bf1:	cmp    $0xffffffff,%eax
  277bf4:	je     277c01 <<glass::engine::Watch>::print_utf8+0xee1>
  277bf6:	mov    0x78(%rsp),%rcx
  277bfb:	cmp    0x30(%r15),%rbx
  277bff:	jae    277c1a <<glass::engine::Watch>::print_utf8+0xefa>
  277c01:	mov    0x10(%r15),%rsi
  277c05:	cmp    %rsi,%rbx
  277c08:	jae    278da8 <<glass::engine::Watch>::print_utf8+0x2088>
  277c0e:	lea    (%rbx,%rbx,2),%rcx
  277c12:	shl    $0x3,%rcx
  277c16:	add    0x8(%r15),%rcx
  277c1a:	testb  $0x60,0x14(%rcx)
  277c1e:	jne    277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277c24:	cmp    $0x2,%r12
  277c28:	jne    277c61 <<glass::engine::Watch>::print_utf8+0xf41>
  277c2a:	lea    0x1(%rbx),%rdi
  277c2e:	cmp    $0xffffffff,%eax
  277c31:	je     277c3e <<glass::engine::Watch>::print_utf8+0xf1e>
  277c33:	mov    0x78(%rsp),%rcx
  277c38:	cmp    0x30(%r15),%rdi
  277c3c:	jae    277c57 <<glass::engine::Watch>::print_utf8+0xf37>
  277c3e:	mov    0x10(%r15),%rsi
  277c42:	cmp    %rsi,%rdi
  277c45:	jae    278dcc <<glass::engine::Watch>::print_utf8+0x20ac>
  277c4b:	lea    (%rdi,%rdi,2),%rcx
  277c4f:	shl    $0x3,%rcx
  277c53:	add    0x8(%r15),%rcx
  277c57:	testb  $0x60,0x14(%rcx)
  277c5b:	jne    277880 <<glass::engine::Watch>::print_utf8+0xb60>
  277c61:	mov    %rdx,0x28(%rsp)
  277c66:	cmp    %ebx,0x38(%r15)
  277c6a:	jbe    277c70 <<glass::engine::Watch>::print_utf8+0xf50>
  277c6c:	mov    %ebx,0x38(%r15)
  277c70:	mov    %r14d,0xc(%rsp)
  277c75:	mov    %r11,0x90(%rsp)
  277c7d:	cmp    $0xffffffff,%eax
  277c80:	setne  %dl
  277c83:	mov    0x30(%r15),%rcx
  277c87:	cmp    %rcx,%rbx
  277c8a:	sete   %sil
  277c8e:	test   %sil,%dl
  277c91:	mov    %rbx,0x20(%rsp)
  277c96:	mov    %r15,0x38(%rsp)
  277c9b:	mov    %r9,0x60(%rsp)
  277ca0:	mov    %r10,0x70(%rsp)
  277ca5:	jne    277d1e <<glass::engine::Watch>::print_utf8+0xffe>
  277ca7:	cmp    $0xffffffff,%eax
  277caa:	mov    0x30(%rsp),%r14
  277caf:	je     277f6d <<glass::engine::Watch>::print_utf8+0x124d>
  277cb5:	mov    0x10(%r15),%rax
  277cb9:	cmp    %rcx,%rax
  277cbc:	mov    %rcx,%rdx
  277cbf:	cmovb  %rax,%rdx
  277cc3:	mov    %rdx,0xa8(%rsp)
  277ccb:	cmp    %rbx,%rax
  277cce:	mov    %rbx,%rsi
  277cd1:	cmovb  %rax,%rsi
  277cd5:	mov    0x3b0e64(%rip),%rdx        # 628b40 <_DYNAMIC+0x320>
  277cdc:	movzbl (%rdx),%edx
  277cdf:	test   %dl,%dl
  277ce1:	je     277d8b <<glass::engine::Watch>::print_utf8+0x106b>
  277ce7:	mov    0x3b0e8a(%rip),%rdx        # 628b78 <_DYNAMIC+0x358>
  277cee:	mov    %rsi,%r11
  277cf1:	cmp    %rsi,%rcx
  277cf4:	jae    277cfd <<glass::engine::Watch>::print_utf8+0xfdd>
  277cf6:	mov    0x3b0e83(%rip),%rdx        # 628b80 <_DYNAMIC+0x360>
  277cfd:	lock incq 0x28(%rdx)
  277d02:	mov    0x3b0e4f(%rip),%rdx        # 628b58 <_DYNAMIC+0x338>
  277d09:	lock incq (%rdx)
  277d0d:	mov    %r11,%rdx
  277d10:	sub    0xa8(%rsp),%rdx
  277d18:	jne    277d3d <<glass::engine::Watch>::print_utf8+0x101d>
  277d1a:	xor    %esi,%esi
  277d1c:	jmp    277d7c <<glass::engine::Watch>::print_utf8+0x105c>
  277d1e:	lea    0x1(%rbx),%rax
  277d22:	mov    %rax,0x30(%r15)
  277d26:	mov    0x10(%r15),%rsi
  277d2a:	cmp    %rsi,%rbx
  277d2d:	mov    0x30(%rsp),%r14
  277d32:	jb     277f8d <<glass::engine::Watch>::print_utf8+0x126d>
  277d38:	jmp    278dd9 <<glass::engine::Watch>::print_utf8+0x20b9>
  277d3d:	mov    0x3b0e1c(%rip),%rsi        # 628b60 <_DYNAMIC+0x340>
  277d44:	lock add %rdx,(%rsi)
  277d48:	cmp    $0x5,%rdx
  277d4c:	jae    277d5c <<glass::engine::Watch>::print_utf8+0x103c>
  277d4e:	lea    -0x218095(%rip),%rsi        # 5fcc0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  277d55:	movzbl -0x1(%rdx,%rsi,1),%esi
  277d5a:	jmp    277d7c <<glass::engine::Watch>::print_utf8+0x105c>
  277d5c:	lea    -0x5(%rdx),%rdi
  277d60:	mov    $0x4,%esi
  277d65:	cmp    $0x4,%rdi
  277d69:	jb     277d7c <<glass::engine::Watch>::print_utf8+0x105c>
  277d6b:	add    $0xfffffffffffffff7,%rdx
  277d6f:	cmp    $0x8,%rdx
  277d73:	mov    $0x6,%esi
  277d78:	sbb    $0x0,%rsi
  277d7c:	mov    0x3b0dcd(%rip),%rdx        # 628b50 <_DYNAMIC+0x330>
  277d83:	lock incq (%rdx,%rsi,8)
  277d88:	mov    %r11,%rsi
  277d8b:	cmp    %rsi,%rcx
  277d8e:	jae    277f2b <<glass::engine::Watch>::print_utf8+0x120b>
  277d94:	mov    0x28(%r15),%edi
  277d98:	mov    0x20(%r15),%r10d
  277d9c:	mov    0x24(%r15),%r11d
  277da0:	movzwl 0x2c(%r15),%ecx
  277da5:	mov    0x18(%r15),%rax
  277da9:	test   %rax,%rax
  277dac:	mov    %rax,0x68(%rsp)
  277db1:	je     277de6 <<glass::engine::Watch>::print_utf8+0x10c6>
  277db3:	lock incq (%rax)
  277db7:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  277dbd:	mov    0x10(%r15),%rdx
  277dc1:	mov    %edi,0x50(%rsp)
  277dc5:	mov    %r10d,0x48(%rsp)
  277dca:	mov    %r11d,0x4c(%rsp)
  277dcf:	mov    %ecx,%r9d
  277dd2:	mov    %cx,0x54(%rsp)
  277dd7:	mov    %rax,0x40(%rsp)
  277ddc:	cmp    %rdx,%rsi
  277ddf:	jbe    277e01 <<glass::engine::Watch>::print_utf8+0x10e1>
  277de1:	jmp    278d08 <<glass::engine::Watch>::print_utf8+0x1fe8>
  277de6:	mov    %edi,0x50(%rsp)
  277dea:	mov    %r10d,0x48(%rsp)
  277def:	mov    %r11d,0x4c(%rsp)
  277df4:	mov    %cx,0x54(%rsp)
  277df9:	mov    %rax,0x40(%rsp)
  277dfe:	mov    %ecx,%r9d
  277e01:	mov    0xa8(%rsp),%rax
  277e09:	lea    0x0(,%rax,8),%rax
  277e11:	lea    (%rax,%rax,2),%rax
  277e15:	mov    0x8(%r15),%rbx
  277e19:	add    %rax,%rbx
  277e1c:	mov    %rsi,0xd0(%rsp)
  277e24:	lea    0x0(,%rsi,8),%rcx
  277e2c:	lea    (%rcx,%rcx,2),%r14
  277e30:	sub    %rax,%r14
  277e33:	mov    0x68(%rsp),%rcx
  277e38:	mov    %edi,0x98(%rsp)
  277e3f:	mov    %r10d,0x8c(%rsp)
  277e47:	mov    %r11d,0xb8(%rsp)
  277e4f:	mov    %r9w,0xd8(%rsp)
  277e58:	jmp    277e7d <<glass::engine::Watch>::print_utf8+0x115d>
  277e5a:	nopw   0x0(%rax,%rax,1)
  277e60:	mov    %rcx,(%rbx)
  277e63:	mov    %r10d,0x8(%rbx)
  277e67:	mov    %r11d,0xc(%rbx)
  277e6b:	mov    %edi,0x10(%rbx)
  277e6e:	mov    %r9w,0x14(%rbx)
  277e73:	add    $0x18,%rbx
  277e77:	add    $0xffffffffffffffe8,%r14
  277e7b:	je     277ed5 <<glass::engine::Watch>::print_utf8+0x11b5>
  277e7d:	test   %rcx,%rcx
  277e80:	je     277e8c <<glass::engine::Watch>::print_utf8+0x116c>
  277e82:	lock incq (%rcx)
  277e86:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  277e8c:	mov    (%rbx),%rax
  277e8f:	test   %rax,%rax
  277e92:	je     277e60 <<glass::engine::Watch>::print_utf8+0x1140>
  277e94:	lock decq (%rax)
  277e98:	jne    277e60 <<glass::engine::Watch>::print_utf8+0x1140>
  277e9a:	mov    %rbx,%rdi
  277e9d:	mov    %r8,%r15
  277ea0:	call   *0x3b0be2(%rip)        # 628a88 <_DYNAMIC+0x268>
  277ea6:	movzwl 0xd8(%rsp),%r9d
  277eaf:	mov    0xb8(%rsp),%r11d
  277eb7:	mov    0x8c(%rsp),%r10d
  277ebf:	mov    0x98(%rsp),%edi
  277ec6:	mov    0x68(%rsp),%rcx
  277ecb:	mov    %r15,%r8
  277ece:	mov    0x38(%rsp),%r15
  277ed3:	jmp    277e60 <<glass::engine::Watch>::print_utf8+0x1140>
  277ed5:	mov    0xa8(%rsp),%rax
  277edd:	cmp    %eax,0x38(%r15)
  277ee1:	mov    0x30(%rsp),%r14
  277ee6:	mov    0x20(%rsp),%rbx
  277eeb:	jbe    277ef1 <<glass::engine::Watch>::print_utf8+0x11d1>
  277eed:	mov    %eax,0x38(%r15)
  277ef1:	test   %rcx,%rcx
  277ef4:	mov    0xd0(%rsp),%rsi
  277efc:	je     277f27 <<glass::engine::Watch>::print_utf8+0x1207>
  277efe:	lock decq (%rcx)
  277f02:	jne    277f27 <<glass::engine::Watch>::print_utf8+0x1207>
  277f04:	lea    0x40(%rsp),%rdi
  277f09:	mov    %r8,%rbx
  277f0c:	call   *0x3b0b76(%rip)        # 628a88 <_DYNAMIC+0x268>
  277f12:	mov    0xd0(%rsp),%rsi
  277f1a:	mov    %rbx,%r8
  277f1d:	mov    0x20(%rsp),%rbx
  277f22:	mov    0x38(%rsp),%r15
  277f27:	mov    0x10(%r15),%rax
  277f2b:	cmp    %rax,%rsi
  277f2e:	jb     277f6d <<glass::engine::Watch>::print_utf8+0x124d>
  277f30:	cmpl   $0xffffffff,0x28(%r15)
  277f35:	je     277f65 <<glass::engine::Watch>::print_utf8+0x1245>
  277f37:	mov    0x78(%rsp),%rax
  277f3c:	mov    (%rax),%rax
  277f3f:	test   %rax,%rax
  277f42:	je     277f65 <<glass::engine::Watch>::print_utf8+0x1245>
  277f44:	lock decq (%rax)
  277f48:	jne    277f65 <<glass::engine::Watch>::print_utf8+0x1245>
  277f4a:	mov    0x78(%rsp),%rdi
  277f4f:	mov    %r8,%rbx
  277f52:	call   *0x3b0b30(%rip)        # 628a88 <_DYNAMIC+0x268>
  277f58:	mov    %rbx,%r8
  277f5b:	mov    0x20(%rsp),%rbx
  277f60:	mov    0x38(%rsp),%r15
  277f65:	movl   $0xffffffff,0x28(%r15)
  277f6d:	mov    0x30(%r15),%rax
  277f71:	lea    0x1(%rbx),%rcx
  277f75:	cmp    %rax,%rcx
  277f78:	cmova  %rcx,%rax
  277f7c:	mov    0x10(%r15),%rsi
  277f80:	mov    %rax,0x30(%r15)
  277f84:	cmp    %rsi,%rbx
  277f87:	jae    278de9 <<glass::engine::Watch>::print_utf8+0x20c9>
  277f8d:	mov    0xc(%rsp),%esi
  277f91:	mov    %esi,%eax
  277f93:	or     $0x20,%eax
  277f96:	cmp    $0x2,%r12
  277f9a:	mov    0x8(%r15),%rcx
  277f9e:	lea    (%rbx,%rbx,2),%rdx
  277fa2:	lea    (%rcx,%rdx,8),%rbx
  277fa6:	mov    %ebp,0x10(%rcx,%rdx,8)
  277faa:	mov    0x58(%rsp),%ebp
  277fae:	mov    %ebp,0x8(%rcx,%rdx,8)
  277fb2:	cmovne %esi,%eax
  277fb5:	mov    0xa0(%rsp),%esi
  277fbc:	mov    %esi,0xc(%rcx,%rdx,8)
  277fc0:	mov    %ax,0x14(%rcx,%rdx,8)
  277fc5:	mov    (%rcx,%rdx,8),%rax
  277fc9:	test   %rax,%rax
  277fcc:	je     277fe8 <<glass::engine::Watch>::print_utf8+0x12c8>
  277fce:	lock decq (%rax)
  277fd2:	jne    277fe8 <<glass::engine::Watch>::print_utf8+0x12c8>
  277fd4:	mov    %rbx,%rdi
  277fd7:	mov    %r8,%r15
  277fda:	call   *0x3b0aa8(%rip)        # 628a88 <_DYNAMIC+0x268>
  277fe0:	mov    %r15,%r8
  277fe3:	mov    0x38(%rsp),%r15
  277fe8:	movq   $0x0,(%rbx)
  277fef:	cmp    $0x2,%r12
  277ff3:	mov    0x28(%rsp),%rdx
  277ff8:	jne    278328 <<glass::engine::Watch>::print_utf8+0x1608>
  277ffe:	mov    0x20(%rsp),%r9
  278003:	lea    0x1(%r9),%r12
  278007:	mov    0x30(%r15),%rax
  27800b:	mov    0x28(%r15),%ecx
  27800f:	cmp    %rax,%r12
  278012:	jne    278033 <<glass::engine::Watch>::print_utf8+0x1313>
  278014:	cmp    $0xffffffff,%ecx
  278017:	je     278033 <<glass::engine::Watch>::print_utf8+0x1313>
  278019:	add    $0x2,%r9
  27801d:	mov    %r9,0x30(%r15)
  278021:	mov    0x10(%r15),%rsi
  278025:	cmp    %rsi,%r12
  278028:	jb     2782cf <<glass::engine::Watch>::print_utf8+0x15af>
  27802e:	jmp    2786ae <<glass::engine::Watch>::print_utf8+0x198e>
  278033:	cmp    $0xffffffff,%ecx
  278036:	je     2782af <<glass::engine::Watch>::print_utf8+0x158f>
  27803c:	mov    0x10(%r15),%rcx
  278040:	cmp    %rax,%rcx
  278043:	mov    %rax,%rdi
  278046:	cmovb  %rcx,%rdi
  27804a:	cmp    %r12,%rcx
  27804d:	mov    %r12,%r10
  278050:	cmovb  %rcx,%r10
  278054:	mov    0x3b0ae5(%rip),%rdx        # 628b40 <_DYNAMIC+0x320>
  27805b:	movzbl (%rdx),%edx
  27805e:	test   %dl,%dl
  278060:	je     2780dc <<glass::engine::Watch>::print_utf8+0x13bc>
  278062:	mov    0x3b0b0f(%rip),%rdx        # 628b78 <_DYNAMIC+0x358>
  278069:	cmp    %r10,%rax
  27806c:	jae    278075 <<glass::engine::Watch>::print_utf8+0x1355>
  27806e:	mov    0x3b0b0b(%rip),%rdx        # 628b80 <_DYNAMIC+0x360>
  278075:	lock incq 0x28(%rdx)
  27807a:	mov    0x3b0ad7(%rip),%rdx        # 628b58 <_DYNAMIC+0x338>
  278081:	lock incq (%rdx)
  278085:	mov    %r10,%rdx
  278088:	sub    %rdi,%rdx
  27808b:	jne    278091 <<glass::engine::Watch>::print_utf8+0x1371>
  27808d:	xor    %esi,%esi
  27808f:	jmp    2780d0 <<glass::engine::Watch>::print_utf8+0x13b0>
  278091:	mov    0x3b0ac8(%rip),%rsi        # 628b60 <_DYNAMIC+0x340>
  278098:	lock add %rdx,(%rsi)
  27809c:	cmp    $0x5,%rdx
  2780a0:	jae    2780b0 <<glass::engine::Watch>::print_utf8+0x1390>
  2780a2:	lea    -0x2183e9(%rip),%rsi        # 5fcc0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2780a9:	movzbl -0x1(%rdx,%rsi,1),%esi
  2780ae:	jmp    2780d0 <<glass::engine::Watch>::print_utf8+0x13b0>
  2780b0:	lea    -0x5(%rdx),%r11
  2780b4:	mov    $0x4,%esi
  2780b9:	cmp    $0x4,%r11
  2780bd:	jb     2780d0 <<glass::engine::Watch>::print_utf8+0x13b0>
  2780bf:	add    $0xfffffffffffffff7,%rdx
  2780c3:	cmp    $0x8,%rdx
  2780c7:	mov    $0x6,%esi
  2780cc:	sbb    $0x0,%rsi
  2780d0:	mov    0x3b0a79(%rip),%rdx        # 628b50 <_DYNAMIC+0x330>
  2780d7:	lock incq (%rdx,%rsi,8)
  2780dc:	cmp    %r10,%rax
  2780df:	mov    0x28(%rsp),%rdx
  2780e4:	jae    278288 <<glass::engine::Watch>::print_utf8+0x1568>
  2780ea:	mov    %r12,0xd8(%rsp)
  2780f2:	mov    0x28(%r15),%r9d
  2780f6:	mov    0x20(%r15),%r11d
  2780fa:	mov    0x24(%r15),%ebp
  2780fe:	movzwl 0x2c(%r15),%eax
  278103:	mov    0x18(%r15),%r12
  278107:	test   %r12,%r12
  27810a:	mov    %r12,0x98(%rsp)
  278112:	mov    %ax,0x68(%rsp)
  278117:	je     27814d <<glass::engine::Watch>::print_utf8+0x142d>
  278119:	lock incq (%r12)
  27811e:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  278124:	mov    0x10(%r15),%rdx
  278128:	mov    %r9d,0x50(%rsp)
  27812d:	mov    %r11d,0x48(%rsp)
  278132:	mov    %ebp,0x4c(%rsp)
  278136:	mov    %ax,0x54(%rsp)
  27813b:	mov    %r12,0x40(%rsp)
  278140:	cmp    %rdx,%r10
  278143:	mov    %r10,%rsi
  278146:	jbe    278168 <<glass::engine::Watch>::print_utf8+0x1448>
  278148:	jmp    278d22 <<glass::engine::Watch>::print_utf8+0x2002>
  27814d:	mov    %r9d,0x50(%rsp)
  278152:	mov    %r11d,0x48(%rsp)
  278157:	mov    %ebp,0x4c(%rsp)
  27815b:	mov    %ax,0x54(%rsp)
  278160:	mov    %r12,0x40(%rsp)
  278165:	mov    %r10,%rsi
  278168:	mov    %rdi,0xa8(%rsp)
  278170:	lea    0x0(,%rdi,8),%rax
  278178:	lea    (%rax,%rax,2),%rax
  27817c:	mov    0x8(%r15),%rbx
  278180:	add    %rax,%rbx
  278183:	mov    %rsi,0xb8(%rsp)
  27818b:	lea    0x0(,%rsi,8),%rcx
  278193:	lea    (%rcx,%rcx,2),%r14
  278197:	sub    %rax,%r14
  27819a:	movzwl 0x68(%rsp),%ecx
  27819f:	mov    %ebp,0x8c(%rsp)
  2781a6:	jmp    2781cc <<glass::engine::Watch>::print_utf8+0x14ac>
  2781a8:	nopl   0x0(%rax,%rax,1)
  2781b0:	mov    %r12,(%rbx)
  2781b3:	mov    %r11d,0x8(%rbx)
  2781b7:	mov    %ebp,0xc(%rbx)
  2781ba:	mov    %r9d,0x10(%rbx)
  2781be:	mov    %cx,0x14(%rbx)
  2781c2:	add    $0x18,%rbx
  2781c6:	add    $0xffffffffffffffe8,%r14
  2781ca:	je     278220 <<glass::engine::Watch>::print_utf8+0x1500>
  2781cc:	test   %r12,%r12
  2781cf:	je     2781dc <<glass::engine::Watch>::print_utf8+0x14bc>
  2781d1:	lock incq (%r12)
  2781d6:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  2781dc:	mov    (%rbx),%rax
  2781df:	test   %rax,%rax
  2781e2:	je     2781b0 <<glass::engine::Watch>::print_utf8+0x1490>
  2781e4:	lock decq (%rax)
  2781e8:	jne    2781b0 <<glass::engine::Watch>::print_utf8+0x1490>
  2781ea:	mov    %rbx,%rdi
  2781ed:	mov    %r8,%r15
  2781f0:	mov    %r9d,%ebp
  2781f3:	mov    %r11d,%r12d
  2781f6:	call   *0x3b088c(%rip)        # 628a88 <_DYNAMIC+0x268>
  2781fc:	movzwl 0x68(%rsp),%ecx
  278201:	mov    %r12d,%r11d
  278204:	mov    0x98(%rsp),%r12
  27820c:	mov    %ebp,%r9d
  27820f:	mov    0x8c(%rsp),%ebp
  278216:	mov    %r15,%r8
  278219:	mov    0x38(%rsp),%r15
  27821e:	jmp    2781b0 <<glass::engine::Watch>::print_utf8+0x1490>
  278220:	mov    0xa8(%rsp),%rax
  278228:	cmp    %eax,0x38(%r15)
  27822c:	mov    0x30(%rsp),%r14
  278231:	mov    0x28(%rsp),%rdx
  278236:	mov    0x20(%rsp),%r9
  27823b:	jbe    278241 <<glass::engine::Watch>::print_utf8+0x1521>
  27823d:	mov    %eax,0x38(%r15)
  278241:	test   %r12,%r12
  278244:	mov    0x58(%rsp),%ebp
  278248:	mov    0xb8(%rsp),%r10
  278250:	je     27827c <<glass::engine::Watch>::print_utf8+0x155c>
  278252:	lock decq (%r12)
  278257:	jne    27827c <<glass::engine::Watch>::print_utf8+0x155c>
  278259:	lea    0x40(%rsp),%rdi
  27825e:	mov    %r8,%rbx
  278261:	call   *0x3b0821(%rip)        # 628a88 <_DYNAMIC+0x268>
  278267:	mov    0x28(%rsp),%rdx
  27826c:	mov    %rbx,%r8
  27826f:	mov    0xb8(%rsp),%r10
  278277:	mov    0x20(%rsp),%r9
  27827c:	mov    0x10(%r15),%rcx
  278280:	mov    0xd8(%rsp),%r12
  278288:	cmp    %rcx,%r10
  27828b:	jb     2782af <<glass::engine::Watch>::print_utf8+0x158f>
  27828d:	mov    0x78(%rsp),%rdi
  278292:	mov    %r8,%rbx
  278295:	call   1b72c0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  27829a:	mov    0x28(%rsp),%rdx
  27829f:	mov    %rbx,%r8
  2782a2:	mov    0x20(%rsp),%r9
  2782a7:	movl   $0xffffffff,0x28(%r15)
  2782af:	mov    0x30(%r15),%rax
  2782b3:	add    $0x2,%r9
  2782b7:	cmp    %rax,%r9
  2782ba:	cmovbe %rax,%r9
  2782be:	mov    0x10(%r15),%rsi
  2782c2:	mov    %r9,0x30(%r15)
  2782c6:	cmp    %rsi,%r12
  2782c9:	jae    278df9 <<glass::engine::Watch>::print_utf8+0x20d9>
  2782cf:	mov    0x8(%r15),%rax
  2782d3:	lea    (%r12,%r12,2),%rcx
  2782d7:	lea    (%rax,%rcx,8),%rbx
  2782db:	movl   $0x20,0x10(%rax,%rcx,8)
  2782e3:	mov    %ebp,0x8(%rax,%rcx,8)
  2782e7:	mov    0xa0(%rsp),%esi
  2782ee:	mov    %esi,0xc(%rax,%rcx,8)
  2782f2:	mov    0xc(%rsp),%esi
  2782f6:	or     $0x40,%esi
  2782f9:	mov    %si,0x14(%rax,%rcx,8)
  2782fe:	mov    (%rax,%rcx,8),%rax
  278302:	test   %rax,%rax
  278305:	je     278321 <<glass::engine::Watch>::print_utf8+0x1601>
  278307:	lock decq (%rax)
  27830b:	jne    278321 <<glass::engine::Watch>::print_utf8+0x1601>
  27830d:	mov    %rbx,%rdi
  278310:	mov    %r8,%r15
  278313:	call   *0x3b076f(%rip)        # 628a88 <_DYNAMIC+0x268>
  278319:	mov    0x28(%rsp),%rdx
  27831e:	mov    %r15,%r8
  278321:	movq   $0x0,(%rbx)
  278328:	mov    0x70(%rsp),%rcx
  27832d:	cmp    0x90(%rsp),%rcx
  278335:	mov    0x18(%rsp),%rsi
  27833a:	mov    0x60(%rsp),%rax
  27833f:	jb     278348 <<glass::engine::Watch>::print_utf8+0x1628>
  278341:	dec    %rcx
  278344:	movb   $0x1,0x6c(%rax)
  278348:	mov    %rcx,0x40(%rax)
  27834c:	mov    0xc8(%rsp),%r15
  278354:	incq   0xa0(%r15)
  27835b:	nopl   0x0(%rax,%rax,1)
  278360:	add    %r14,%rdx
  278363:	cmpb   $0x0,0x80(%rsp)
  27836b:	je     2778b9 <<glass::engine::Watch>::print_utf8+0xb99>
  278371:	jmp    276dd0 <<glass::engine::Watch>::print_utf8+0xb0>
  278376:	mov    %r8,%rbx
  278379:	mov    %rdx,%r14
  27837c:	call   1930a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  278381:	mov    %r14,%rdx
  278384:	mov    %rbx,%r8
  278387:	mov    %ebp,%ebx
  278389:	mov    0x3b36e0(%rip),%rsi        # 62ba70 <glass::engine::width_of::CACHE+0x8>
  278390:	cmp    %rbx,%rsi
  278393:	ja     277ade <<glass::engine::Watch>::print_utf8+0xdbe>
  278399:	jmp    278cf8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  27839e:	cmpq   $0x400,0xa0(%r15)
  2783a9:	jb     2783d4 <<glass::engine::Watch>::print_utf8+0x16b4>
  2783ab:	mov    %r15,%rdi
  2783ae:	call   279170 <<glass::engine::Watch>::fold_sentinel>
  2783b3:	movq   $0x0,0xa0(%r15)
  2783be:	mov    0x3b36bc(%rip),%eax        # 62ba80 <glass::engine::run_whole::ON>
  2783c4:	test   %eax,%eax
  2783c6:	je     2783de <<glass::engine::Watch>::print_utf8+0x16be>
  2783c8:	call   193146 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2783cd:	cmp    %r13,%r14
  2783d0:	je     2783e3 <<glass::engine::Watch>::print_utf8+0x16c3>
  2783d2:	jmp    278413 <<glass::engine::Watch>::print_utf8+0x16f3>
  2783d4:	mov    0x3b36a6(%rip),%eax        # 62ba80 <glass::engine::run_whole::ON>
  2783da:	test   %eax,%eax
  2783dc:	jne    2783c8 <<glass::engine::Watch>::print_utf8+0x16a8>
  2783de:	cmp    %r13,%r14
  2783e1:	jne    278413 <<glass::engine::Watch>::print_utf8+0x16f3>
  2783e3:	cmpb   $0x0,0x3b369a(%rip)        # 62ba84 <glass::engine::run_whole::ON+0x4>
  2783ea:	je     278413 <<glass::engine::Watch>::print_utf8+0x16f3>
  2783ec:	cmp    $0xffffffff,%ebp
  2783ef:	je     2785b5 <<glass::engine::Watch>::print_utf8+0x1895>
  2783f5:	lea    -0x20(%rbp),%eax
  2783f8:	cmp    $0x5f,%eax
  2783fb:	jae    278424 <<glass::engine::Watch>::print_utf8+0x1704>
  2783fd:	mov    $0x1,%r13d
  278403:	cmpb   $0x0,0x10(%rsp)
  278408:	jne    2784ef <<glass::engine::Watch>::print_utf8+0x17cf>
  27840e:	jmp    2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  278413:	xor    %eax,%eax
  278415:	cmp    $0xffffffff,%ebp
  278418:	cmove  %rax,%rbx
  27841c:	mov    %rbx,%r13
  27841f:	jmp    2785b5 <<glass::engine::Watch>::print_utf8+0x1895>
  278424:	cmpb   $0x0,0x80(%rsp)
  27842c:	je     2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  278432:	mov    0x3b3640(%rip),%eax        # 62ba78 <glass::engine::width_of::CACHE+0x10>
  278438:	test   %eax,%eax
  27843a:	jne    278ce1 <<glass::engine::Watch>::print_utf8+0x1fc1>
  278440:	mov    %ebp,%ebx
  278442:	mov    0x3b3627(%rip),%rsi        # 62ba70 <glass::engine::width_of::CACHE+0x8>
  278449:	cmp    %rbx,%rsi
  27844c:	jbe    278cf8 <<glass::engine::Watch>::print_utf8+0x1fd8>
  278452:	mov    0x3b360f(%rip),%r14        # 62ba68 <glass::engine::width_of::CACHE>
  278459:	movzbl (%r14,%rbx,1),%eax
  27845e:	movzbl %al,%r13d
  278462:	test   %r13b,%r13b
  278465:	js     278472 <<glass::engine::Watch>::print_utf8+0x1752>
  278467:	mov    $0x1,%cl
  278469:	test   %cl,%cl
  27846b:	jne    2784e1 <<glass::engine::Watch>::print_utf8+0x17c1>
  27846d:	jmp    2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  278472:	cmp    $0xfe,%r13d
  278479:	je     2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  27847f:	mov    $0xfe,%al
  278481:	cmp    $0x7f,%ebp
  278484:	jae    2784bc <<glass::engine::Watch>::print_utf8+0x179c>
  278486:	mov    $0x1,%r13d
  27848c:	xor    %ecx,%ecx
  27848e:	jmp    2784d5 <<glass::engine::Watch>::print_utf8+0x17b5>
  278490:	mov    $0x1,%cl
  278492:	mov    %ecx,0x80(%rsp)
  278499:	cmpb   $0x0,0x68(%rax)
  27849d:	jne    2784af <<glass::engine::Watch>::print_utf8+0x178f>
  27849f:	cmpb   $0x0,0x69(%rax)
  2784a3:	jne    2784af <<glass::engine::Watch>::print_utf8+0x178f>
  2784a5:	cmpb   $0x0,0x6a(%rax)
  2784a9:	je     2786ce <<glass::engine::Watch>::print_utf8+0x19ae>
  2784af:	movl   $0x0,0x10(%rsp)
  2784b7:	jmp    276d7e <<glass::engine::Watch>::print_utf8+0x5e>
  2784bc:	cmp    $0xa0,%ebp
  2784c2:	jb     2784d3 <<glass::engine::Watch>::print_utf8+0x17b3>
  2784c4:	mov    %ebp,%edi
  2784c6:	call   2ad680 <unicode_width::tables::lookup_width>
  2784cb:	movzbl %al,%r13d
  2784cf:	mov    $0x1,%cl
  2784d1:	jmp    2784d5 <<glass::engine::Watch>::print_utf8+0x17b5>
  2784d3:	xor    %ecx,%ecx
  2784d5:	mov    %al,(%r14,%rbx,1)
  2784d9:	test   %cl,%cl
  2784db:	je     2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  2784e1:	lea    -0x1(%r13),%rax
  2784e5:	cmp    $0x1,%rax
  2784e9:	ja     2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  2784ef:	mov    0x78(%r15),%r14
  2784f3:	cmpb   $0x0,0x6c(%r14)
  2784f8:	jne    2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  2784fe:	mov    0x40(%r14),%r12
  278502:	mov    0xa0(%r14),%r8
  278509:	lea    (%r12,%r13,1),%rdx
  27850d:	cmp    %r8,%rdx
  278510:	ja     2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  278516:	mov    0x30(%r14),%eax
  27851a:	sub    0x48(%r14),%eax
  27851e:	cltq
  278520:	mov    0x20(%r14),%rsi
  278524:	mov    0x28(%r14),%rcx
  278528:	lea    (%rcx,%rax,1),%rdi
  27852c:	dec    %rdi
  27852f:	xor    %eax,%eax
  278531:	cmp    %rsi,%rdi
  278534:	cmovae %rsi,%rax
  278538:	sub    %rax,%rdi
  27853b:	cmp    %rsi,%rdi
  27853e:	jae    278d9b <<glass::engine::Watch>::print_utf8+0x207b>
  278544:	mov    0x58(%r14),%r10d
  278548:	mov    0x5c(%r14),%r11d
  27854c:	movzwl 0x64(%r14),%r9d
  278551:	mov    0x18(%r14),%rax
  278555:	shl    $0x6,%rdi
  278559:	lea    (%rax,%rdi,1),%rbx
  27855d:	lea    (%rax,%rdi,1),%rcx
  278561:	add    $0x18,%rcx
  278565:	mov    %rcx,0x80(%rsp)
  27856d:	mov    0x28(%rax,%rdi,1),%eax
  278571:	cmp    $0xffffffff,%eax
  278574:	je     278584 <<glass::engine::Watch>::print_utf8+0x1864>
  278576:	mov    0x80(%rsp),%rcx
  27857e:	cmp    0x30(%rbx),%r12
  278582:	jae    27859d <<glass::engine::Watch>::print_utf8+0x187d>
  278584:	mov    0x10(%rbx),%rsi
  278588:	cmp    %rsi,%r12
  27858b:	jae    278e09 <<glass::engine::Watch>::print_utf8+0x20e9>
  278591:	lea    (%r12,%r12,2),%rcx
  278595:	shl    $0x3,%rcx
  278599:	add    0x8(%rbx),%rcx
  27859d:	testb  $0x60,0x14(%rcx)
  2785a1:	je     2785ca <<glass::engine::Watch>::print_utf8+0x18aa>
  2785a3:	mov    %r15,%rdi
  2785a6:	mov    %ebp,%esi
  2785a8:	call   3574d0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  2785ad:	mov    0xc0(%rsp),%r13
  2785b5:	mov    %r13,%rax
  2785b8:	add    $0x118,%rsp
  2785bf:	pop    %rbx
  2785c0:	pop    %r12
  2785c2:	pop    %r13
  2785c4:	pop    %r14
  2785c6:	pop    %r15
  2785c8:	pop    %rbp
  2785c9:	ret
  2785ca:	cmp    $0x2,%r13
  2785ce:	jne    278607 <<glass::engine::Watch>::print_utf8+0x18e7>
  2785d0:	lea    0x1(%r12),%rdi
  2785d5:	cmp    $0xffffffff,%eax
  2785d8:	je     2785e8 <<glass::engine::Watch>::print_utf8+0x18c8>
  2785da:	mov    0x80(%rsp),%rcx
  2785e2:	cmp    0x30(%rbx),%rdi
  2785e6:	jae    278601 <<glass::engine::Watch>::print_utf8+0x18e1>
  2785e8:	mov    0x10(%rbx),%rsi
  2785ec:	cmp    %rsi,%rdi
  2785ef:	jae    278dcc <<glass::engine::Watch>::print_utf8+0x20ac>
  2785f5:	lea    (%rdi,%rdi,2),%rcx
  2785f9:	shl    $0x3,%rcx
  2785fd:	add    0x8(%rbx),%rcx
  278601:	testb  $0x60,0x14(%rcx)
  278605:	jne    2785a3 <<glass::engine::Watch>::print_utf8+0x1883>
  278607:	mov    %r11d,0x78(%rsp)
  27860c:	mov    %r10d,0x28(%rsp)
  278611:	mov    %r9d,0x30(%rsp)
  278616:	mov    %r8,0x58(%rsp)
  27861b:	mov    %rdx,0xa0(%rsp)
  278623:	cmp    %r12d,0x38(%rbx)
  278627:	jbe    27862d <<glass::engine::Watch>::print_utf8+0x190d>
  278629:	mov    %r12d,0x38(%rbx)
  27862d:	cmp    $0xffffffff,%eax
  278630:	setne  %cl
  278633:	mov    %rbx,%rdi
  278636:	mov    0x30(%rbx),%rbx
  27863a:	cmp    %rbx,%r12
  27863d:	sete   %dl
  278640:	test   %dl,%cl
  278642:	mov    %rdi,0x18(%rsp)
  278647:	jne    278695 <<glass::engine::Watch>::print_utf8+0x1975>
  278649:	cmp    $0xffffffff,%eax
  27864c:	je     2788ff <<glass::engine::Watch>::print_utf8+0x1bdf>
  278652:	mov    0x18(%rsp),%rax
  278657:	mov    0x10(%rax),%r15
  27865b:	cmp    %rbx,%r15
  27865e:	mov    %rbx,%rax
  278661:	cmovb  %r15,%rax
  278665:	mov    %rax,0x10(%rsp)
  27866a:	cmp    %r12,%r15
  27866d:	mov    %r12,%rcx
  278670:	cmovb  %r15,%rcx
  278674:	mov    0x3b04c5(%rip),%rax        # 628b40 <_DYNAMIC+0x320>
  27867b:	movzbl (%rax),%eax
  27867e:	test   %al,%al
  278680:	mov    %rcx,0x20(%rsp)
  278685:	je     2786fc <<glass::engine::Watch>::print_utf8+0x19dc>
  278687:	cmp    %rcx,%rbx
  27868a:	jae    2786de <<glass::engine::Watch>::print_utf8+0x19be>
  27868c:	mov    0x3b04ed(%rip),%rax        # 628b80 <_DYNAMIC+0x360>
  278693:	jmp    2786e5 <<glass::engine::Watch>::print_utf8+0x19c5>
  278695:	lea    0x1(%r12),%rax
  27869a:	mov    %rax,0x30(%rdi)
  27869e:	mov    0x10(%rdi),%rsi
  2786a2:	cmp    %rsi,%r12
  2786a5:	mov    %rdi,%rdx
  2786a8:	jb     278925 <<glass::engine::Watch>::print_utf8+0x1c05>
  2786ae:	lea    0x38720b(%rip),%rdx        # 5ff8c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  2786b5:	mov    %r12,%rdi
  2786b8:	call   *0x3b037a(%rip)        # 628a38 <_DYNAMIC+0x218>
  2786be:	lea    0x387153(%rip),%rcx        # 5ff818 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x167d0>
  2786c5:	mov    %r12,%rdi
  2786c8:	call   *0x3b052a(%rip)        # 628bf8 <_DYNAMIC+0x3d8>
  2786ce:	cmpb   $0x0,0x6b(%rax)
  2786d2:	sete   %al
  2786d5:	mov    %eax,0x10(%rsp)
  2786d9:	jmp    276d7e <<glass::engine::Watch>::print_utf8+0x5e>
  2786de:	mov    0x3b0493(%rip),%rax        # 628b78 <_DYNAMIC+0x358>
  2786e5:	lock incq 0x28(%rax)
  2786ea:	mov    %rcx,%rdi
  2786ed:	sub    0x10(%rsp),%rdi
  2786f2:	call   310f10 <alacritty_terminal::grid::row::fill_census::note>
  2786f7:	mov    0x20(%rsp),%rcx
  2786fc:	cmp    %rcx,%rbx
  2786ff:	jae    2788d9 <<glass::engine::Watch>::print_utf8+0x1bb9>
  278705:	mov    0x18(%rsp),%rcx
  27870a:	mov    0x28(%rcx),%edi
  27870d:	mov    0x20(%rcx),%r8d
  278711:	mov    0x24(%rcx),%r9d
  278715:	movzwl 0x2c(%rcx),%r10d
  27871a:	mov    0x18(%rcx),%rsi
  27871e:	test   %rsi,%rsi
  278721:	mov    %rsi,0x38(%rsp)
  278726:	mov    %edi,0xc(%rsp)
  27872a:	mov    %r8d,0x60(%rsp)
  27872f:	mov    %r9d,0x70(%rsp)
  278734:	mov    %r10w,0x90(%rsp)
  27873d:	je     278806 <<glass::engine::Watch>::print_utf8+0x1ae6>
  278743:	lock incq (%rsi)
  278747:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  27874d:	mov    0x10(%rcx),%rdx
  278751:	mov    %edi,0x50(%rsp)
  278755:	mov    %r8d,0x48(%rsp)
  27875a:	mov    %r9d,0x4c(%rsp)
  27875f:	mov    %r10w,0x54(%rsp)
  278765:	mov    %rsi,0x40(%rsp)
  27876a:	mov    0x20(%rsp),%rsi
  27876f:	cmp    %rdx,%rsi
  278772:	ja     278d87 <<glass::engine::Watch>::print_utf8+0x2067>
  278778:	mov    0x10(%rsp),%rax
  27877d:	lea    0x0(,%rax,8),%rax
  278785:	lea    (%rax,%rax,2),%rax
  278789:	mov    0x8(%rcx),%rbx
  27878d:	add    %rax,%rbx
  278790:	lea    0x0(,%rsi,8),%rcx
  278798:	lea    (%rcx,%rcx,2),%r15
  27879c:	sub    %rax,%r15
  27879f:	mov    0x38(%rsp),%rsi
  2787a4:	jmp    2787c7 <<glass::engine::Watch>::print_utf8+0x1aa7>
  2787a6:	mov    %rsi,(%rbx)
  2787a9:	mov    %r8d,0x8(%rbx)
  2787ad:	mov    %r9d,0xc(%rbx)
  2787b1:	mov    %edi,0x10(%rbx)
  2787b4:	mov    %r10w,0x14(%rbx)
  2787b9:	add    $0x18,%rbx
  2787bd:	add    $0xffffffffffffffe8,%r15
  2787c1:	je     2788a3 <<glass::engine::Watch>::print_utf8+0x1b83>
  2787c7:	lock incq (%rsi)
  2787cb:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  2787d1:	mov    (%rbx),%rax
  2787d4:	test   %rax,%rax
  2787d7:	je     2787a6 <<glass::engine::Watch>::print_utf8+0x1a86>
  2787d9:	lock decq (%rax)
  2787dd:	jne    2787a6 <<glass::engine::Watch>::print_utf8+0x1a86>
  2787df:	mov    %rbx,%rdi
  2787e2:	call   *0x3b02a0(%rip)        # 628a88 <_DYNAMIC+0x268>
  2787e8:	movzwl 0x90(%rsp),%r10d
  2787f1:	mov    0x70(%rsp),%r9d
  2787f6:	mov    0x60(%rsp),%r8d
  2787fb:	mov    0xc(%rsp),%edi
  2787ff:	mov    0x38(%rsp),%rsi
  278804:	jmp    2787a6 <<glass::engine::Watch>::print_utf8+0x1a86>
  278806:	mov    %edi,0x50(%rsp)
  27880a:	mov    %r8d,0x48(%rsp)
  27880f:	mov    %r9d,0x4c(%rsp)
  278814:	mov    %r10w,0x54(%rsp)
  27881a:	mov    %rsi,0x40(%rsp)
  27881f:	mov    0x10(%rsp),%rax
  278824:	lea    0x0(,%rax,8),%rax
  27882c:	lea    (%rax,%rax,2),%rax
  278830:	mov    0x8(%rcx),%rbx
  278834:	add    %rax,%rbx
  278837:	mov    0x20(%rsp),%rcx
  27883c:	lea    0x0(,%rcx,8),%rcx
  278844:	lea    (%rcx,%rcx,2),%r15
  278848:	sub    %rax,%r15
  27884b:	jmp    27886e <<glass::engine::Watch>::print_utf8+0x1b4e>
  27884d:	movq   $0x0,(%rbx)
  278854:	mov    %r8d,0x8(%rbx)
  278858:	mov    %r9d,0xc(%rbx)
  27885c:	mov    %edi,0x10(%rbx)
  27885f:	mov    %r10w,0x14(%rbx)
  278864:	add    $0x18,%rbx
  278868:	add    $0xffffffffffffffe8,%r15
  27886c:	je     2788a3 <<glass::engine::Watch>::print_utf8+0x1b83>
  27886e:	mov    (%rbx),%rax
  278871:	test   %rax,%rax
  278874:	je     27884d <<glass::engine::Watch>::print_utf8+0x1b2d>
  278876:	lock decq (%rax)
  27887a:	jne    27884d <<glass::engine::Watch>::print_utf8+0x1b2d>
  27887c:	mov    %rbx,%rdi
  27887f:	call   *0x3b0203(%rip)        # 628a88 <_DYNAMIC+0x268>
  278885:	movzwl 0x90(%rsp),%r10d
  27888e:	mov    0x70(%rsp),%r9d
  278893:	mov    0x60(%rsp),%r8d
  278898:	mov    0xc(%rsp),%edi
  27889c:	mov    0x38(%rsp),%rsi
  2788a1:	jmp    27884d <<glass::engine::Watch>::print_utf8+0x1b2d>
  2788a3:	mov    0x18(%rsp),%rbx
  2788a8:	mov    0x10(%rsp),%rax
  2788ad:	cmp    %eax,0x38(%rbx)
  2788b0:	jbe    2788b5 <<glass::engine::Watch>::print_utf8+0x1b95>
  2788b2:	mov    %eax,0x38(%rbx)
  2788b5:	test   %rsi,%rsi
  2788b8:	mov    0x20(%rsp),%rcx
  2788bd:	je     2788d5 <<glass::engine::Watch>::print_utf8+0x1bb5>
  2788bf:	lock decq (%rsi)
  2788c3:	jne    2788d5 <<glass::engine::Watch>::print_utf8+0x1bb5>
  2788c5:	lea    0x40(%rsp),%rdi
  2788ca:	call   *0x3b01b8(%rip)        # 628a88 <_DYNAMIC+0x268>
  2788d0:	mov    0x20(%rsp),%rcx
  2788d5:	mov    0x10(%rbx),%r15
  2788d9:	cmp    %r15,%rcx
  2788dc:	mov    0xc8(%rsp),%r15
  2788e4:	jb     2788ff <<glass::engine::Watch>::print_utf8+0x1bdf>
  2788e6:	mov    0x80(%rsp),%rdi
  2788ee:	call   1b72c0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2788f3:	mov    0x18(%rsp),%rax
  2788f8:	movl   $0xffffffff,0x28(%rax)
  2788ff:	mov    0x18(%rsp),%rdx
  278904:	mov    0x30(%rdx),%rax
  278908:	lea    0x1(%r12),%rcx
  27890d:	cmp    %rax,%rcx
  278910:	cmova  %rcx,%rax
  278914:	mov    0x10(%rdx),%rsi
  278918:	mov    %rax,0x30(%rdx)
  27891c:	cmp    %rsi,%r12
  27891f:	jae    278df9 <<glass::engine::Watch>::print_utf8+0x20d9>
  278925:	mov    0x30(%rsp),%esi
  278929:	mov    %esi,%eax
  27892b:	or     $0x20,%eax
  27892e:	cmp    $0x2,%r13
  278932:	mov    0x8(%rdx),%rcx
  278936:	lea    (%r12,%r12,2),%rdx
  27893a:	lea    (%rcx,%rdx,8),%rbx
  27893e:	mov    %ebp,0x10(%rcx,%rdx,8)
  278942:	mov    0x28(%rsp),%edi
  278946:	mov    %edi,0x8(%rcx,%rdx,8)
  27894a:	cmovne %esi,%eax
  27894d:	mov    0x78(%rsp),%esi
  278951:	mov    %esi,0xc(%rcx,%rdx,8)
  278955:	mov    %ax,0x14(%rcx,%rdx,8)
  27895a:	mov    (%rcx,%rdx,8),%rax
  27895e:	test   %rax,%rax
  278961:	je     278972 <<glass::engine::Watch>::print_utf8+0x1c52>
  278963:	lock decq (%rax)
  278967:	jne    278972 <<glass::engine::Watch>::print_utf8+0x1c52>
  278969:	mov    %rbx,%rdi
  27896c:	call   *0x3b0116(%rip)        # 628a88 <_DYNAMIC+0x268>
  278972:	movq   $0x0,(%rbx)
  278979:	cmp    $0x2,%r13
  27897d:	mov    0xc0(%rsp),%r13
  278985:	jne    278cb3 <<glass::engine::Watch>::print_utf8+0x1f93>
  27898b:	lea    0x1(%r12),%rcx
  278990:	mov    0x18(%rsp),%rax
  278995:	mov    0x30(%rax),%rbx
  278999:	mov    0x28(%rax),%eax
  27899c:	mov    %rcx,0x38(%rsp)
  2789a1:	cmp    %rbx,%rcx
  2789a4:	jne    2789d7 <<glass::engine::Watch>::print_utf8+0x1cb7>
  2789a6:	cmp    $0xffffffff,%eax
  2789a9:	je     2789d7 <<glass::engine::Watch>::print_utf8+0x1cb7>
  2789ab:	add    $0x2,%r12
  2789af:	mov    0x18(%rsp),%rcx
  2789b4:	mov    %r12,0x30(%rcx)
  2789b8:	mov    0x10(%rcx),%rsi
  2789bc:	mov    0x38(%rsp),%rdi
  2789c1:	cmp    %rsi,%rdi
  2789c4:	jb     278c64 <<glass::engine::Watch>::print_utf8+0x1f44>
  2789ca:	lea    0x386eef(%rip),%rdx        # 5ff8c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  2789d1:	call   *0x3b0061(%rip)        # 628a38 <_DYNAMIC+0x218>
  2789d7:	cmp    $0xffffffff,%eax
  2789da:	je     278c3a <<glass::engine::Watch>::print_utf8+0x1f1a>
  2789e0:	mov    0x18(%rsp),%rax
  2789e5:	mov    0x10(%rax),%r15
  2789e9:	cmp    %rbx,%r15
  2789ec:	mov    %rbx,%rax
  2789ef:	cmovb  %r15,%rax
  2789f3:	mov    %rax,0x10(%rsp)
  2789f8:	lea    0x1(%r12),%rcx
  2789fd:	cmp    %rcx,%r15
  278a00:	cmovb  %r15,%rcx
  278a04:	mov    0x3b0135(%rip),%rax        # 628b40 <_DYNAMIC+0x320>
  278a0b:	movzbl (%rax),%eax
  278a0e:	test   %al,%al
  278a10:	mov    %rcx,0x20(%rsp)
  278a15:	je     278a43 <<glass::engine::Watch>::print_utf8+0x1d23>
  278a17:	cmp    %rcx,%rbx
  278a1a:	jae    278a25 <<glass::engine::Watch>::print_utf8+0x1d05>
  278a1c:	mov    0x3b015d(%rip),%rax        # 628b80 <_DYNAMIC+0x360>
  278a23:	jmp    278a2c <<glass::engine::Watch>::print_utf8+0x1d0c>
  278a25:	mov    0x3b014c(%rip),%rax        # 628b78 <_DYNAMIC+0x358>
  278a2c:	lock incq 0x28(%rax)
  278a31:	mov    %rcx,%rdi
  278a34:	sub    0x10(%rsp),%rdi
  278a39:	call   310f10 <alacritty_terminal::grid::row::fill_census::note>
  278a3e:	mov    0x20(%rsp),%rcx
  278a43:	cmp    %rcx,%rbx
  278a46:	jae    278c14 <<glass::engine::Watch>::print_utf8+0x1ef4>
  278a4c:	mov    0x18(%rsp),%rcx
  278a51:	mov    0x28(%rcx),%edi
  278a54:	mov    0x20(%rcx),%r8d
  278a58:	mov    0x24(%rcx),%r9d
  278a5c:	movzwl 0x2c(%rcx),%r10d
  278a61:	mov    0x18(%rcx),%r15
  278a65:	test   %r15,%r15
  278a68:	mov    %edi,0xc(%rsp)
  278a6c:	mov    %r8d,0x60(%rsp)
  278a71:	mov    %r9d,0x70(%rsp)
  278a76:	mov    %r10w,0x90(%rsp)
  278a7f:	je     278b3e <<glass::engine::Watch>::print_utf8+0x1e1e>
  278a85:	lock incq (%r15)
  278a89:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  278a8f:	mov    0x10(%rcx),%rdx
  278a93:	mov    %edi,0x50(%rsp)
  278a97:	mov    %r8d,0x48(%rsp)
  278a9c:	mov    %r9d,0x4c(%rsp)
  278aa1:	mov    %r10w,0x54(%rsp)
  278aa7:	mov    %r15,0x40(%rsp)
  278aac:	mov    0x20(%rsp),%rsi
  278ab1:	cmp    %rdx,%rsi
  278ab4:	ja     278db8 <<glass::engine::Watch>::print_utf8+0x2098>
  278aba:	mov    0x10(%rsp),%rax
  278abf:	lea    0x0(,%rax,8),%rax
  278ac7:	lea    (%rax,%rax,2),%rax
  278acb:	mov    0x8(%rcx),%rbx
  278acf:	add    %rax,%rbx
  278ad2:	lea    0x0(,%rsi,8),%rcx
  278ada:	lea    (%rcx,%rcx,2),%r13
  278ade:	sub    %rax,%r13
  278ae1:	jmp    278b04 <<glass::engine::Watch>::print_utf8+0x1de4>
  278ae3:	mov    %r15,(%rbx)
  278ae6:	mov    %r8d,0x8(%rbx)
  278aea:	mov    %r9d,0xc(%rbx)
  278aee:	mov    %edi,0x10(%rbx)
  278af1:	mov    %r10w,0x14(%rbx)
  278af6:	add    $0x18,%rbx
  278afa:	add    $0xffffffffffffffe8,%r13
  278afe:	je     278bd6 <<glass::engine::Watch>::print_utf8+0x1eb6>
  278b04:	lock incq (%r15)
  278b08:	jle    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  278b0e:	mov    (%rbx),%rax
  278b11:	test   %rax,%rax
  278b14:	je     278ae3 <<glass::engine::Watch>::print_utf8+0x1dc3>
  278b16:	lock decq (%rax)
  278b1a:	jne    278ae3 <<glass::engine::Watch>::print_utf8+0x1dc3>
  278b1c:	mov    %rbx,%rdi
  278b1f:	call   *0x3aff63(%rip)        # 628a88 <_DYNAMIC+0x268>
  278b25:	movzwl 0x90(%rsp),%r10d
  278b2e:	mov    0x70(%rsp),%r9d
  278b33:	mov    0x60(%rsp),%r8d
  278b38:	mov    0xc(%rsp),%edi
  278b3c:	jmp    278ae3 <<glass::engine::Watch>::print_utf8+0x1dc3>
  278b3e:	mov    %edi,0x50(%rsp)
  278b42:	mov    %r8d,0x48(%rsp)
  278b47:	mov    %r9d,0x4c(%rsp)
  278b4c:	mov    %r10w,0x54(%rsp)
  278b52:	mov    %r15,0x40(%rsp)
  278b57:	mov    0x10(%rsp),%rax
  278b5c:	lea    0x0(,%rax,8),%rax
  278b64:	lea    (%rax,%rax,2),%rax
  278b68:	mov    0x8(%rcx),%rbx
  278b6c:	add    %rax,%rbx
  278b6f:	mov    0x20(%rsp),%rcx
  278b74:	lea    0x0(,%rcx,8),%rcx
  278b7c:	lea    (%rcx,%rcx,2),%r13
  278b80:	sub    %rax,%r13
  278b83:	jmp    278ba6 <<glass::engine::Watch>::print_utf8+0x1e86>
  278b85:	movq   $0x0,(%rbx)
  278b8c:	mov    %r8d,0x8(%rbx)
  278b90:	mov    %r9d,0xc(%rbx)
  278b94:	mov    %edi,0x10(%rbx)
  278b97:	mov    %r10w,0x14(%rbx)
  278b9c:	add    $0x18,%rbx
  278ba0:	add    $0xffffffffffffffe8,%r13
  278ba4:	je     278bd6 <<glass::engine::Watch>::print_utf8+0x1eb6>
  278ba6:	mov    (%rbx),%rax
  278ba9:	test   %rax,%rax
  278bac:	je     278b85 <<glass::engine::Watch>::print_utf8+0x1e65>
  278bae:	lock decq (%rax)
  278bb2:	jne    278b85 <<glass::engine::Watch>::print_utf8+0x1e65>
  278bb4:	mov    %rbx,%rdi
  278bb7:	call   *0x3afecb(%rip)        # 628a88 <_DYNAMIC+0x268>
  278bbd:	movzwl 0x90(%rsp),%r10d
  278bc6:	mov    0x70(%rsp),%r9d
  278bcb:	mov    0x60(%rsp),%r8d
  278bd0:	mov    0xc(%rsp),%edi
  278bd4:	jmp    278b85 <<glass::engine::Watch>::print_utf8+0x1e65>
  278bd6:	mov    0x18(%rsp),%rbx
  278bdb:	mov    0x10(%rsp),%rax
  278be0:	cmp    %eax,0x38(%rbx)
  278be3:	jbe    278be8 <<glass::engine::Watch>::print_utf8+0x1ec8>
  278be5:	mov    %eax,0x38(%rbx)
  278be8:	test   %r15,%r15
  278beb:	mov    0xc0(%rsp),%r13
  278bf3:	mov    0x20(%rsp),%rcx
  278bf8:	je     278c10 <<glass::engine::Watch>::print_utf8+0x1ef0>
  278bfa:	lock decq (%r15)
  278bfe:	jne    278c10 <<glass::engine::Watch>::print_utf8+0x1ef0>
  278c00:	lea    0x40(%rsp),%rdi
  278c05:	call   *0x3afe7d(%rip)        # 628a88 <_DYNAMIC+0x268>
  278c0b:	mov    0x20(%rsp),%rcx
  278c10:	mov    0x10(%rbx),%r15
  278c14:	cmp    %r15,%rcx
  278c17:	mov    0xc8(%rsp),%r15
  278c1f:	jb     278c3a <<glass::engine::Watch>::print_utf8+0x1f1a>
  278c21:	mov    0x80(%rsp),%rdi
  278c29:	call   1b72c0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  278c2e:	mov    0x18(%rsp),%rax
  278c33:	movl   $0xffffffff,0x28(%rax)
  278c3a:	mov    0x18(%rsp),%rcx
  278c3f:	mov    0x30(%rcx),%rax
  278c43:	add    $0x2,%r12
  278c47:	cmp    %rax,%r12
  278c4a:	cmovbe %rax,%r12
  278c4e:	mov    0x10(%rcx),%rsi
  278c52:	mov    %r12,0x30(%rcx)
  278c56:	mov    0x38(%rsp),%rdi
  278c5b:	cmp    %rsi,%rdi
  278c5e:	jae    278e19 <<glass::engine::Watch>::print_utf8+0x20f9>
  278c64:	mov    0x8(%rcx),%rax
  278c68:	lea    (%rdi,%rdi,2),%rcx
  278c6c:	lea    (%rax,%rcx,8),%rbx
  278c70:	movl   $0x20,0x10(%rax,%rcx,8)
  278c78:	mov    0x28(%rsp),%edx
  278c7c:	mov    %edx,0x8(%rax,%rcx,8)
  278c80:	mov    0x78(%rsp),%edx
  278c84:	mov    %edx,0xc(%rax,%rcx,8)
  278c88:	mov    0x30(%rsp),%edx
  278c8c:	or     $0x40,%edx
  278c8f:	mov    %dx,0x14(%rax,%rcx,8)
  278c94:	mov    (%rax,%rcx,8),%rax
  278c98:	test   %rax,%rax
  278c9b:	je     278cac <<glass::engine::Watch>::print_utf8+0x1f8c>
  278c9d:	lock decq (%rax)
  278ca1:	jne    278cac <<glass::engine::Watch>::print_utf8+0x1f8c>
  278ca3:	mov    %rbx,%rdi
  278ca6:	call   *0x3afddc(%rip)        # 628a88 <_DYNAMIC+0x268>
  278cac:	movq   $0x0,(%rbx)
  278cb3:	mov    0xa0(%rsp),%rax
  278cbb:	cmp    0x58(%rsp),%rax
  278cc0:	jb     278cca <<glass::engine::Watch>::print_utf8+0x1faa>
  278cc2:	dec    %rax
  278cc5:	movb   $0x1,0x6c(%r14)
  278cca:	mov    %rax,0x40(%r14)
  278cce:	incq   0xa0(%r15)
  278cd5:	mov    %ebp,0xb0(%r15)
  278cdc:	jmp    2785b5 <<glass::engine::Watch>::print_utf8+0x1895>
  278ce1:	call   1930a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  278ce6:	mov    %ebp,%ebx
  278ce8:	mov    0x3b2d81(%rip),%rsi        # 62ba70 <glass::engine::width_of::CACHE+0x8>
  278cef:	cmp    %rbx,%rsi
  278cf2:	ja     278452 <<glass::engine::Watch>::print_utf8+0x1732>
  278cf8:	lea    0x389039(%rip),%rdx        # 601d38 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18cf0>
  278cff:	mov    %rbx,%rdi
  278d02:	call   *0x3afd30(%rip)        # 628a38 <_DYNAMIC+0x218>
  278d08:	lea    0x385fb1(%rip),%rcx        # 5fecc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  278d0f:	mov    0xa8(%rsp),%rdi
  278d17:	call   *0x3afedb(%rip)        # 628bf8 <_DYNAMIC+0x3d8>
  278d1d:	jmp    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  278d22:	lea    0x385f97(%rip),%rcx        # 5fecc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  278d29:	call   *0x3afec9(%rip)        # 628bf8 <_DYNAMIC+0x3d8>
  278d2f:	jmp    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  278d34:	lea    0x38647d(%rip),%rdx        # 5ff1b8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16170>
  278d3b:	call   *0x3afcf7(%rip)        # 628a38 <_DYNAMIC+0x218>
  278d41:	lea    0x386488(%rip),%rax        # 5ff1d0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16188>
  278d48:	jmp    278d69 <<glass::engine::Watch>::print_utf8+0x2049>
  278d4a:	lea    0x3864c7(%rip),%rdx        # 5ff218 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161d0>
  278d51:	mov    %rbx,%rdi
  278d54:	mov    0x30(%rsp),%rsi
  278d59:	call   *0x3afcd9(%rip)        # 628a38 <_DYNAMIC+0x218>
  278d5f:	mov    %rax,%rbx
  278d62:	lea    0x38647f(%rip),%rax        # 5ff1e8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161a0>
  278d69:	mov    %rax,0xf0(%rsp)
  278d71:	mov    %rbx,%rdi
  278d74:	mov    0x30(%rsp),%rsi
  278d79:	mov    0xf0(%rsp),%rdx
  278d81:	call   *0x3afcb1(%rip)        # 628a38 <_DYNAMIC+0x218>
  278d87:	lea    0x385f32(%rip),%rcx        # 5fecc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  278d8e:	mov    0x10(%rsp),%rdi
  278d93:	call   *0x3afe5f(%rip)        # 628bf8 <_DYNAMIC+0x3d8>
  278d99:	jmp    278dca <<glass::engine::Watch>::print_utf8+0x20aa>
  278d9b:	lea    0x386596(%rip),%rdx        # 5ff338 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x162f0>
  278da2:	call   *0x3afc90(%rip)        # 628a38 <_DYNAMIC+0x218>
  278da8:	lea    0x3739d9(%rip),%rdx        # 5ec788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  278daf:	mov    %rbx,%rdi
  278db2:	call   *0x3afc80(%rip)        # 628a38 <_DYNAMIC+0x218>
  278db8:	lea    0x385f01(%rip),%rcx        # 5fecc0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  278dbf:	mov    0x10(%rsp),%rdi
  278dc4:	call   *0x3afe2e(%rip)        # 628bf8 <_DYNAMIC+0x3d8>
  278dca:	ud2
  278dcc:	lea    0x3739b5(%rip),%rdx        # 5ec788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  278dd3:	call   *0x3afc5f(%rip)        # 628a38 <_DYNAMIC+0x218>
  278dd9:	lea    0x386ae0(%rip),%rdx        # 5ff8c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  278de0:	mov    %rbx,%rdi
  278de3:	call   *0x3afc4f(%rip)        # 628a38 <_DYNAMIC+0x218>
  278de9:	lea    0x386ab8(%rip),%rdx        # 5ff8a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16860>
  278df0:	mov    %rbx,%rdi
  278df3:	call   *0x3afc3f(%rip)        # 628a38 <_DYNAMIC+0x218>
  278df9:	lea    0x386aa8(%rip),%rdx        # 5ff8a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16860>
  278e00:	mov    %r12,%rdi
  278e03:	call   *0x3afc2f(%rip)        # 628a38 <_DYNAMIC+0x218>
  278e09:	lea    0x373978(%rip),%rdx        # 5ec788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  278e10:	mov    %r12,%rdi
  278e13:	call   *0x3afc1f(%rip)        # 628a38 <_DYNAMIC+0x218>
  278e19:	lea    0x386a88(%rip),%rdx        # 5ff8a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16860>
  278e20:	call   *0x3afc12(%rip)        # 628a38 <_DYNAMIC+0x218>
  278e26:	mov    %rax,%rbx
  278e29:	lock decq (%r15)
  278e2d:	je     278e56 <<glass::engine::Watch>::print_utf8+0x2136>
  278e2f:	jmp    278e64 <<glass::engine::Watch>::print_utf8+0x2144>
  278e31:	mov    %rax,%rbx
  278e34:	mov    0x38(%rsp),%rax
  278e39:	jmp    278e50 <<glass::engine::Watch>::print_utf8+0x2130>
  278e3b:	mov    %rax,%rbx
  278e3e:	mov    0x98(%rsp),%rax
  278e46:	jmp    278e50 <<glass::engine::Watch>::print_utf8+0x2130>
  278e48:	mov    %rax,%rbx
  278e4b:	mov    0x68(%rsp),%rax
  278e50:	lock decq (%rax)
  278e54:	jne    278e64 <<glass::engine::Watch>::print_utf8+0x2144>
  278e56:	mov    0x110(%rsp),%rdi
  278e5e:	call   *0x3afc24(%rip)        # 628a88 <_DYNAMIC+0x268>
  278e64:	mov    %rbx,%rdi
  278e67:	call   5e58f0 <_Unwind_Resume@plt>
