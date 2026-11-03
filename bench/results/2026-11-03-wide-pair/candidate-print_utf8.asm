
/tmp/glass-wide-pair-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000276d20 <<glass::engine::Watch>::print_utf8>:
  276d20:	push   %rbp
  276d21:	push   %r15
  276d23:	push   %r14
  276d25:	push   %r13
  276d27:	push   %r12
  276d29:	push   %rbx
  276d2a:	sub    $0x108,%rsp
  276d31:	mov    %rdx,%r8
  276d34:	mov    %rdi,0x88(%rsp)
  276d3c:	cmpb   $0x1,0xbe(%rdi)
  276d43:	jne    276d80 <<glass::engine::Watch>::print_utf8+0x60>
  276d45:	mov    0x88(%rsp),%rax
  276d4d:	cmpq   $0x0,0x38(%rax)
  276d52:	jne    276d80 <<glass::engine::Watch>::print_utf8+0x60>
  276d54:	mov    0x88(%rsp),%rax
  276d5c:	mov    0x78(%rax),%rax
  276d60:	testb  $0x4,0x6c5(%rax)
  276d67:	jne    276d80 <<glass::engine::Watch>::print_utf8+0x60>
  276d69:	cmpq   $0x0,0x50(%rax)
  276d6e:	jne    276d80 <<glass::engine::Watch>::print_utf8+0x60>
  276d70:	movzwl 0x64(%rax),%ecx
  276d74:	test   $0x460,%ecx
  276d7a:	je     2784e1 <<glass::engine::Watch>::print_utf8+0x17c1>
  276d80:	movl   $0x0,0x60(%rsp)
  276d88:	movl   $0x0,0x68(%rsp)
  276d90:	mov    $0xffffffff,%r9d
  276d96:	xor    %r13d,%r13d
  276d99:	lea    0x3884f0(%rip),%rax        # 5ff290 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16188>
  276da0:	mov    %rax,0xc8(%rsp)
  276da8:	lea    0x40(%rsp),%rax
  276dad:	mov    %rax,0xf8(%rsp)
  276db5:	xor    %edx,%edx
  276db7:	mov    %rsi,0x18(%rsp)
  276dbc:	mov    %r8,0x98(%rsp)
  276dc4:	cmpb   $0x0,0x68(%rsp)
  276dc9:	je     277887 <<glass::engine::Watch>::print_utf8+0xb67>
  276dcf:	nop
  276dd0:	mov    0x88(%rsp),%rax
  276dd8:	mov    0x78(%rax),%r12
  276ddc:	cmpb   $0x0,0x6c(%r12)
  276de2:	jne    277887 <<glass::engine::Watch>::print_utf8+0xb67>
  276de8:	mov    0x30(%r12),%eax
  276ded:	sub    0x48(%r12),%eax
  276df2:	cltq
  276df4:	mov    0x20(%r12),%rsi
  276df9:	mov    0x28(%r12),%rcx
  276dfe:	lea    (%rcx,%rax,1),%rdi
  276e02:	dec    %rdi
  276e05:	cmp    %rsi,%rdi
  276e08:	mov    $0x0,%eax
  276e0d:	cmovae %rsi,%rax
  276e11:	sub    %rax,%rdi
  276e14:	cmp    %rsi,%rdi
  276e17:	jae    278db2 <<glass::engine::Watch>::print_utf8+0x2092>
  276e1d:	mov    0xa0(%r12),%rax
  276e25:	mov    %rax,0xb0(%rsp)
  276e2d:	mov    0x40(%r12),%r10
  276e32:	mov    0x58(%r12),%eax
  276e37:	mov    %eax,0x20(%rsp)
  276e3b:	mov    0x5c(%r12),%eax
  276e40:	mov    %eax,0x78(%rsp)
  276e44:	movzwl 0x64(%r12),%eax
  276e4a:	mov    %eax,0x70(%rsp)
  276e4e:	mov    0x18(%r12),%rax
  276e53:	shl    $0x6,%rdi
  276e57:	lea    (%rax,%rdi,1),%rbp
  276e5b:	cmp    %r10d,0x38(%rax,%rdi,1)
  276e60:	jbe    276e66 <<glass::engine::Watch>::print_utf8+0x146>
  276e62:	mov    %r10d,0x38(%rbp)
  276e66:	mov    %rdx,0x8(%rsp)
  276e6b:	mov    0x28(%rbp),%r15d
  276e6f:	cmp    $0xffffffff,%r15d
  276e73:	mov    %r10,0x90(%rsp)
  276e7b:	je     276f2b <<glass::engine::Watch>::print_utf8+0x20b>
  276e81:	mov    0x30(%rbp),%rax
  276e85:	cmp    %rax,%r10
  276e88:	mov    $0x0,%ecx
  276e8d:	cmovb  %rax,%rcx
  276e91:	mov    %rcx,0x38(%rsp)
  276e96:	movl   $0x20,0xe8(%rsp)
  276ea1:	mov    0x20(%rsp),%ecx
  276ea5:	mov    %ecx,0xe0(%rsp)
  276eac:	mov    0x78(%rsp),%ecx
  276eb0:	mov    %ecx,0xe4(%rsp)
  276eb7:	mov    0x70(%rsp),%ecx
  276ebb:	mov    %cx,0xec(%rsp)
  276ec3:	movq   $0x0,0xd8(%rsp)
  276ecf:	mov    0x10(%rbp),%rcx
  276ed3:	cmp    %rax,%rcx
  276ed6:	mov    %rax,%rbx
  276ed9:	cmovb  %rcx,%rbx
  276edd:	cmp    %r10,%rcx
  276ee0:	mov    %r10,%r14
  276ee3:	cmovb  %rcx,%r14
  276ee7:	mov    0x3b1d12(%rip),%rdx        # 628c00 <_DYNAMIC+0x320>
  276eee:	movzbl (%rdx),%edx
  276ef1:	test   %dl,%dl
  276ef3:	je     276fc9 <<glass::engine::Watch>::print_utf8+0x2a9>
  276ef9:	mov    0x3b1d38(%rip),%rdx        # 628c38 <_DYNAMIC+0x358>
  276f00:	cmp    %r14,%rax
  276f03:	jae    276f0c <<glass::engine::Watch>::print_utf8+0x1ec>
  276f05:	mov    0x3b1d34(%rip),%rdx        # 628c40 <_DYNAMIC+0x360>
  276f0c:	lock incq 0x28(%rdx)
  276f11:	mov    0x3b1d00(%rip),%rdx        # 628c18 <_DYNAMIC+0x338>
  276f18:	lock incq (%rdx)
  276f1c:	mov    %r14,%rdx
  276f1f:	sub    %rbx,%rdx
  276f22:	jne    276f7e <<glass::engine::Watch>::print_utf8+0x25e>
  276f24:	xor    %esi,%esi
  276f26:	jmp    276fbd <<glass::engine::Watch>::print_utf8+0x29d>
  276f2b:	movl   $0x20,0xe8(%rsp)
  276f36:	mov    0x20(%rsp),%eax
  276f3a:	mov    %eax,0xe0(%rsp)
  276f41:	mov    0x78(%rsp),%eax
  276f45:	mov    %eax,0xe4(%rsp)
  276f4c:	mov    0x70(%rsp),%eax
  276f50:	mov    %ax,0xec(%rsp)
  276f58:	movq   $0x0,0xd8(%rsp)
  276f64:	lea    0x30(%rbp),%rax
  276f68:	mov    %rax,0xb8(%rsp)
  276f70:	movq   $0xffffffffffffffff,0x38(%rsp)
  276f79:	jmp    27715e <<glass::engine::Watch>::print_utf8+0x43e>
  276f7e:	mov    0x3b1c9b(%rip),%rsi        # 628c20 <_DYNAMIC+0x340>
  276f85:	lock add %rdx,(%rsi)
  276f89:	cmp    $0x5,%rdx
  276f8d:	jae    276f9d <<glass::engine::Watch>::print_utf8+0x27d>
  276f8f:	lea    -0x2172d6(%rip),%rsi        # 5fcc0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  276f96:	movzbl -0x1(%rdx,%rsi,1),%esi
  276f9b:	jmp    276fbd <<glass::engine::Watch>::print_utf8+0x29d>
  276f9d:	lea    -0x5(%rdx),%rdi
  276fa1:	mov    $0x4,%esi
  276fa6:	cmp    $0x4,%rdi
  276faa:	jb     276fbd <<glass::engine::Watch>::print_utf8+0x29d>
  276fac:	add    $0xfffffffffffffff7,%rdx
  276fb0:	cmp    $0x8,%rdx
  276fb4:	mov    $0x6,%esi
  276fb9:	sbb    $0x0,%rsi
  276fbd:	mov    0x3b1c4c(%rip),%rdx        # 628c10 <_DYNAMIC+0x330>
  276fc4:	lock incq (%rdx,%rsi,8)
  276fc9:	cmp    %r14,%rax
  276fcc:	mov    %r9,(%rsp)
  276fd0:	jae    277116 <<glass::engine::Watch>::print_utf8+0x3f6>
  276fd6:	mov    %r14,0x30(%rsp)
  276fdb:	mov    %r12,0xa0(%rsp)
  276fe3:	mov    %r13,0x28(%rsp)
  276fe8:	mov    0x20(%rbp),%r14d
  276fec:	mov    0x24(%rbp),%r12d
  276ff0:	movzwl 0x2c(%rbp),%edi
  276ff4:	mov    0x18(%rbp),%r13
  276ff8:	test   %r13,%r13
  276ffb:	je     277008 <<glass::engine::Watch>::print_utf8+0x2e8>
  276ffd:	lock incq 0x0(%r13)
  277002:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  277008:	mov    %r15d,0x50(%rsp)
  27700d:	mov    %r14d,0x48(%rsp)
  277012:	mov    %r12d,0x4c(%rsp)
  277017:	mov    %di,0x54(%rsp)
  27701c:	mov    %r13,0x40(%rsp)
  277021:	mov    %rbx,0x10(%rsp)
  277026:	lea    0x0(,%rbx,8),%rax
  27702e:	lea    (%rax,%rax,2),%rax
  277032:	mov    %rbp,0xd0(%rsp)
  27703a:	mov    0x8(%rbp),%rbx
  27703e:	add    %rax,%rbx
  277041:	mov    0x30(%rsp),%rcx
  277046:	lea    0x0(,%rcx,8),%rcx
  27704e:	lea    (%rcx,%rcx,2),%rbp
  277052:	sub    %rax,%rbp
  277055:	mov    %di,0x80(%rsp)
  27705d:	jmp    27707d <<glass::engine::Watch>::print_utf8+0x35d>
  27705f:	nop
  277060:	mov    %r13,(%rbx)
  277063:	mov    %r14d,0x8(%rbx)
  277067:	mov    %r12d,0xc(%rbx)
  27706b:	mov    %r15d,0x10(%rbx)
  27706f:	mov    %di,0x14(%rbx)
  277073:	add    $0x18,%rbx
  277077:	add    $0xffffffffffffffe8,%rbp
  27707b:	je     2770b2 <<glass::engine::Watch>::print_utf8+0x392>
  27707d:	test   %r13,%r13
  277080:	je     27708d <<glass::engine::Watch>::print_utf8+0x36d>
  277082:	lock incq 0x0(%r13)
  277087:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  27708d:	mov    (%rbx),%rax
  277090:	test   %rax,%rax
  277093:	je     277060 <<glass::engine::Watch>::print_utf8+0x340>
  277095:	lock decq (%rax)
  277099:	jne    277060 <<glass::engine::Watch>::print_utf8+0x340>
  27709b:	mov    %rbx,%rdi
  27709e:	call   *0x3b1aa4(%rip)        # 628b48 <_DYNAMIC+0x268>
  2770a4:	movzwl 0x80(%rsp),%edi
  2770ac:	mov    (%rsp),%r9
  2770b0:	jmp    277060 <<glass::engine::Watch>::print_utf8+0x340>
  2770b2:	mov    0xd0(%rsp),%rbp
  2770ba:	mov    0x10(%rsp),%rax
  2770bf:	cmp    %eax,0x38(%rbp)
  2770c2:	jbe    2770c7 <<glass::engine::Watch>::print_utf8+0x3a7>
  2770c4:	mov    %eax,0x38(%rbp)
  2770c7:	test   %r13,%r13
  2770ca:	mov    0x98(%rsp),%r8
  2770d2:	mov    0xa0(%rsp),%r12
  2770da:	mov    0x90(%rsp),%r10
  2770e2:	mov    0x30(%rsp),%r14
  2770e7:	je     27710d <<glass::engine::Watch>::print_utf8+0x3ed>
  2770e9:	lock decq 0x0(%r13)
  2770ee:	jne    27710d <<glass::engine::Watch>::print_utf8+0x3ed>
  2770f0:	lea    0x40(%rsp),%rdi
  2770f5:	mov    %r8,%rbx
  2770f8:	call   *0x3b1a4a(%rip)        # 628b48 <_DYNAMIC+0x268>
  2770fe:	mov    (%rsp),%r9
  277102:	mov    %rbx,%r8
  277105:	mov    0x90(%rsp),%r10
  27710d:	mov    0x10(%rbp),%rcx
  277111:	mov    0x28(%rsp),%r13
  277116:	lea    0x30(%rbp),%rax
  27711a:	mov    %rax,0xb8(%rsp)
  277122:	cmp    %rcx,%r14
  277125:	jb     27715e <<glass::engine::Watch>::print_utf8+0x43e>
  277127:	cmpl   $0xffffffff,0x28(%rbp)
  27712b:	je     277157 <<glass::engine::Watch>::print_utf8+0x437>
  27712d:	lea    0x18(%rbp),%rdi
  277131:	mov    (%rdi),%rax
  277134:	test   %rax,%rax
  277137:	je     277157 <<glass::engine::Watch>::print_utf8+0x437>
  277139:	lock decq (%rax)
  27713d:	jne    277157 <<glass::engine::Watch>::print_utf8+0x437>
  27713f:	mov    %r8,%rbx
  277142:	call   *0x3b1a00(%rip)        # 628b48 <_DYNAMIC+0x268>
  277148:	mov    (%rsp),%r9
  27714c:	mov    %rbx,%r8
  27714f:	mov    0x90(%rsp),%r10
  277157:	movl   $0xffffffff,0x28(%rbp)
  27715e:	mov    0x10(%rbp),%rdx
  277162:	mov    0x30(%rbp),%rax
  277166:	cmp    %r10,%rdx
  277169:	mov    %r10,%rsi
  27716c:	cmovb  %rdx,%rsi
  277170:	cmp    %rax,%rsi
  277173:	cmova  %rsi,%rax
  277177:	mov    %rdx,%r14
  27717a:	mov    %rax,0x30(%rbp)
  27717e:	sub    %r10,%r14
  277181:	jb     278711 <<glass::engine::Watch>::print_utf8+0x19f1>
  277187:	mov    0x8(%rsp),%rdx
  27718c:	cmp    %r8,%rdx
  27718f:	jae    277740 <<glass::engine::Watch>::print_utf8+0xa20>
  277195:	mov    %r12,0xa0(%rsp)
  27719d:	mov    %r13,0x28(%rsp)
  2771a2:	mov    %rbp,0xd0(%rsp)
  2771aa:	mov    0x8(%rbp),%rcx
  2771ae:	lea    (%r10,%r10,2),%rax
  2771b2:	mov    %rcx,0x10(%rsp)
  2771b7:	lea    (%rcx,%rax,8),%rax
  2771bb:	mov    %rax,0x100(%rsp)
  2771c3:	mov    0x70(%rsp),%eax
  2771c7:	mov    %eax,%ecx
  2771c9:	or     $0x20,%ecx
  2771cc:	mov    %ecx,0xa8(%rsp)
  2771d3:	or     $0x40,%eax
  2771d6:	mov    %eax,0xc0(%rsp)
  2771dd:	mov    $0x1,%al
  2771df:	mov    %eax,0x5c(%rsp)
  2771e3:	xor    %edi,%edi
  2771e5:	movq   $0x0,0x80(%rsp)
  2771f1:	mov    %r10,%r11
  2771f4:	mov    %r10,%rbx
  2771f7:	mov    0x18(%rsp),%rsi
  2771fc:	jmp    277217 <<glass::engine::Watch>::print_utf8+0x4f7>
  2771fe:	xchg   %ax,%ax
  277200:	mov    %r11,%r15
  277203:	add    %r12,%rdx
  277206:	mov    %ebp,%r9d
  277209:	mov    %r12,0x28(%rsp)
  27720e:	cmp    %r8,%rdx
  277211:	jae    277765 <<glass::engine::Watch>::print_utf8+0xa45>
  277217:	mov    %rdx,%r12
  27721a:	movzbl (%rsi,%rdx,1),%ebp
  27721e:	test   %bpl,%bpl
  277221:	js     277240 <<glass::engine::Watch>::print_utf8+0x520>
  277223:	mov    $0x1,%edx
  277228:	lea    -0x7f(%rbp),%eax
  27722b:	cmp    $0x21,%eax
  27722e:	jae    2773ae <<glass::engine::Watch>::print_utf8+0x68e>
  277234:	jmp    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  277239:	nopl   0x0(%rax)
  277240:	lea    0x3e(%rbp),%eax
  277243:	cmp    $0x1e,%al
  277245:	jae    277271 <<glass::engine::Watch>::print_utf8+0x551>
  277247:	lea    0x1(%r12),%rax
  27724c:	cmp    %r8,%rax
  27724f:	jae    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  277255:	movzbl (%rsi,%rax,1),%eax
  277259:	cmp    $0xc0,%al
  27725b:	jge    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  277261:	and    $0x1f,%ebp
  277264:	shl    $0x6,%ebp
  277267:	mov    $0x2,%edx
  27726c:	jmp    277381 <<glass::engine::Watch>::print_utf8+0x661>
  277271:	mov    %ebp,%eax
  277273:	and    $0xf0,%al
  277275:	cmp    $0xe0,%al
  277277:	jne    277291 <<glass::engine::Watch>::print_utf8+0x571>
  277279:	mov    $0xbf,%al
  27727b:	cmp    $0xe0,%ebp
  277281:	je     2772b4 <<glass::engine::Watch>::print_utf8+0x594>
  277283:	mov    $0x80,%cl
  277285:	cmp    $0xed,%ebp
  27728b:	jne    2772b6 <<glass::engine::Watch>::print_utf8+0x596>
  27728d:	mov    $0x9f,%al
  27728f:	jmp    2772b6 <<glass::engine::Watch>::print_utf8+0x596>
  277291:	lea    0x10(%rbp),%eax
  277294:	cmp    $0x5,%al
  277296:	jae    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  27729c:	mov    $0x80,%al
  27729e:	cmp    $0xf4,%ebp
  2772a4:	je     27730a <<glass::engine::Watch>::print_utf8+0x5ea>
  2772a6:	mov    $0xbf,%cl
  2772a8:	cmp    $0xf0,%ebp
  2772ae:	jne    27730c <<glass::engine::Watch>::print_utf8+0x5ec>
  2772b0:	mov    $0x90,%al
  2772b2:	jmp    27730c <<glass::engine::Watch>::print_utf8+0x5ec>
  2772b4:	mov    $0xa0,%cl
  2772b6:	lea    0x1(%r12),%rdx
  2772bb:	cmp    %r8,%rdx
  2772be:	jae    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  2772c4:	movzbl (%rsi,%rdx,1),%edx
  2772c8:	cmp    %dl,%cl
  2772ca:	ja     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  2772d0:	cmp    %al,%dl
  2772d2:	ja     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  2772d8:	lea    0x2(%r12),%rax
  2772dd:	cmp    %r8,%rax
  2772e0:	jae    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  2772e6:	movzbl (%rsi,%rax,1),%eax
  2772ea:	cmp    $0xc0,%al
  2772ec:	jge    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  2772f2:	movzbl %dl,%ecx
  2772f5:	and    $0x3f,%ecx
  2772f8:	shl    $0x6,%ecx
  2772fb:	and    $0xf,%ebp
  2772fe:	shl    $0xc,%ebp
  277301:	or     %ecx,%ebp
  277303:	mov    $0x3,%edx
  277308:	jmp    277381 <<glass::engine::Watch>::print_utf8+0x661>
  27730a:	mov    $0x8f,%cl
  27730c:	lea    0x1(%r12),%rdx
  277311:	cmp    %r8,%rdx
  277314:	jae    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  27731a:	movzbl (%rsi,%rdx,1),%edx
  27731e:	cmp    %dl,%al
  277320:	ja     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  277326:	cmp    %cl,%dl
  277328:	ja     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  27732e:	lea    0x2(%r12),%rax
  277333:	cmp    %r8,%rax
  277336:	jae    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  27733c:	movzbl (%rsi,%rax,1),%ecx
  277340:	cmp    $0xbf,%cl
  277343:	jg     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  277349:	lea    0x3(%r12),%rax
  27734e:	cmp    %r8,%rax
  277351:	jae    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  277357:	movzbl (%rsi,%rax,1),%eax
  27735b:	cmp    $0xbf,%al
  27735d:	jg     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  277363:	movzbl %dl,%edx
  277366:	and    $0x3f,%ecx
  277369:	shl    $0x6,%ecx
  27736c:	and    $0x3f,%edx
  27736f:	shl    $0xc,%edx
  277372:	and    $0x7,%ebp
  277375:	shl    $0x12,%ebp
  277378:	or     %edx,%ebp
  27737a:	or     %ecx,%ebp
  27737c:	mov    $0x4,%edx
  277381:	mov    %ebp,%ecx
  277383:	xor    $0xd800,%ecx
  277389:	add    $0xffef0000,%ecx
  27738f:	cmp    $0xffef0800,%ecx
  277395:	jb     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  27739b:	and    $0x3f,%al
  27739d:	movzbl %al,%eax
  2773a0:	or     %eax,%ebp
  2773a2:	lea    -0x7f(%rbp),%eax
  2773a5:	cmp    $0x21,%eax
  2773a8:	jb     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  2773ae:	cmp    $0xffffffff,%r9d
  2773b2:	je     277200 <<glass::engine::Watch>::print_utf8+0x4e0>
  2773b8:	lea    -0x20(%r9),%eax
  2773bc:	cmp    $0x5f,%eax
  2773bf:	mov    %r12,0x30(%rsp)
  2773c4:	jae    2773e0 <<glass::engine::Watch>::print_utf8+0x6c0>
  2773c6:	mov    $0x1,%ecx
  2773cb:	cmpb   $0x0,0x60(%rsp)
  2773d0:	jne    2774d4 <<glass::engine::Watch>::print_utf8+0x7b4>
  2773d6:	jmp    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  2773db:	nopl   0x0(%rax,%rax,1)
  2773e0:	mov    %rbx,%r12
  2773e3:	mov    0x3b474f(%rip),%eax        # 62bb38 <glass::engine::width_of::CACHE+0x10>
  2773e9:	test   %eax,%eax
  2773eb:	jne    2776fa <<glass::engine::Watch>::print_utf8+0x9da>
  2773f1:	mov    %r9d,%ebx
  2773f4:	mov    0x3b4735(%rip),%rsi        # 62bb30 <glass::engine::width_of::CACHE+0x8>
  2773fb:	cmp    %rbx,%rsi
  2773fe:	jbe    278dbf <<glass::engine::Watch>::print_utf8+0x209f>
  277404:	mov    0x3b471d(%rip),%r15        # 62bb28 <glass::engine::width_of::CACHE>
  27740b:	movzbl (%r15,%rbx,1),%eax
  277410:	movzbl %al,%ecx
  277413:	test   %cl,%cl
  277415:	js     277439 <<glass::engine::Watch>::print_utf8+0x719>
  277417:	mov    %rdx,%r13
  27741a:	mov    $0x1,%dl
  27741c:	mov    0x18(%rsp),%rsi
  277421:	test   %dl,%dl
  277423:	mov    0x90(%rsp),%r10
  27742b:	mov    %r12,%rbx
  27742e:	jne    2774be <<glass::engine::Watch>::print_utf8+0x79e>
  277434:	jmp    2777d8 <<glass::engine::Watch>::print_utf8+0xab8>
  277439:	cmp    $0xfe,%ecx
  27743f:	mov    0x18(%rsp),%rsi
  277444:	je     2777e5 <<glass::engine::Watch>::print_utf8+0xac5>
  27744a:	mov    $0xfe,%al
  27744c:	mov    %rdx,%r13
  27744f:	cmp    $0x7f,%r9d
  277453:	jae    27745e <<glass::engine::Watch>::print_utf8+0x73e>
  277455:	mov    $0x1,%ecx
  27745a:	xor    %edx,%edx
  27745c:	jmp    2774a7 <<glass::engine::Watch>::print_utf8+0x787>
  27745e:	cmp    $0xa0,%r9d
  277465:	jb     2774a5 <<glass::engine::Watch>::print_utf8+0x785>
  277467:	mov    %rdi,0x8(%rsp)
  27746c:	mov    %r9d,%edi
  27746f:	mov    %r9,(%rsp)
  277473:	mov    %r11,0xf0(%rsp)
  27747b:	call   2ad720 <unicode_width::tables::lookup_width>
  277480:	mov    0xf0(%rsp),%r11
  277488:	mov    0x8(%rsp),%rdi
  27748d:	mov    (%rsp),%r9
  277491:	mov    0x98(%rsp),%r8
  277499:	mov    0x18(%rsp),%rsi
  27749e:	movzbl %al,%ecx
  2774a1:	mov    $0x1,%dl
  2774a3:	jmp    2774a7 <<glass::engine::Watch>::print_utf8+0x787>
  2774a5:	xor    %edx,%edx
  2774a7:	mov    %al,(%r15,%rbx,1)
  2774ab:	test   %dl,%dl
  2774ad:	mov    0x90(%rsp),%r10
  2774b5:	mov    %r12,%rbx
  2774b8:	je     2777d8 <<glass::engine::Watch>::print_utf8+0xab8>
  2774be:	lea    -0x1(%rcx),%rax
  2774c2:	cmp    $0x1,%rax
  2774c6:	mov    %r13,%rdx
  2774c9:	mov    0x30(%rsp),%r12
  2774ce:	ja     27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  2774d4:	test   $0x1,%dil
  2774d8:	jne    277755 <<glass::engine::Watch>::print_utf8+0xa35>
  2774de:	lea    (%rcx,%rbx,1),%r15
  2774e2:	cmp    0xb0(%rsp),%r15
  2774ea:	ja     27775a <<glass::engine::Watch>::print_utf8+0xa3a>
  2774f0:	mov    %rbx,%rdi
  2774f3:	sub    %r10,%rdi
  2774f6:	cmp    0x38(%rsp),%rbx
  2774fb:	jae    277550 <<glass::engine::Watch>::print_utf8+0x830>
  2774fd:	cmp    %r14,%rdi
  277500:	jae    278dea <<glass::engine::Watch>::print_utf8+0x20ca>
  277506:	mov    %r11,%r13
  277509:	lea    (%rbx,%rbx,2),%rax
  27750d:	mov    0x10(%rsp),%r11
  277512:	testb  $0x60,0x14(%r11,%rax,8)
  277518:	jne    2777d1 <<glass::engine::Watch>::print_utf8+0xab1>
  27751e:	cmp    $0x2,%rcx
  277522:	jne    277650 <<glass::engine::Watch>::print_utf8+0x930>
  277528:	lea    0x1(%rdi),%rax
  27752c:	cmp    %r14,%rax
  27752f:	jae    278dd8 <<glass::engine::Watch>::print_utf8+0x20b8>
  277535:	lea    (%rax,%rax,2),%rax
  277539:	mov    0x100(%rsp),%rcx
  277541:	testb  $0x60,0x14(%rcx,%rax,8)
  277546:	je     27755a <<glass::engine::Watch>::print_utf8+0x83a>
  277548:	jmp    2777d1 <<glass::engine::Watch>::print_utf8+0xab1>
  27754d:	nopl   (%rax)
  277550:	cmp    $0x2,%rcx
  277554:	jne    277650 <<glass::engine::Watch>::print_utf8+0x930>
  27755a:	lea    0x2(%rdi),%rsi
  27755e:	cmp    %r14,%rsi
  277561:	seta   %al
  277564:	cmp    $0xfffffffffffffffd,%rdi
  277568:	ja     2776eb <<glass::engine::Watch>::print_utf8+0x9cb>
  27756e:	test   %al,%al
  277570:	jne    278721 <<glass::engine::Watch>::print_utf8+0x1a01>
  277576:	lea    (%rbx,%rbx,2),%rax
  27757a:	mov    0x10(%rsp),%rcx
  27757f:	lea    (%rcx,%rax,8),%rbx
  277583:	mov    (%rcx,%rax,8),%rax
  277587:	test   %rax,%rax
  27758a:	je     2775b8 <<glass::engine::Watch>::print_utf8+0x898>
  27758c:	lock decq (%rax)
  277590:	jne    2775b8 <<glass::engine::Watch>::print_utf8+0x898>
  277592:	mov    %rbx,%rdi
  277595:	mov    %r9,%r12
  277598:	mov    %rdx,0x8(%rsp)
  27759d:	call   *0x3b15a5(%rip)        # 628b48 <_DYNAMIC+0x268>
  2775a3:	mov    0x8(%rsp),%rdx
  2775a8:	mov    %r12,%r9
  2775ab:	mov    0x30(%rsp),%r12
  2775b0:	mov    0x98(%rsp),%r8
  2775b8:	mov    0x18(%rbx),%rax
  2775bc:	test   %rax,%rax
  2775bf:	je     2775ee <<glass::engine::Watch>::print_utf8+0x8ce>
  2775c1:	lock decq (%rax)
  2775c5:	jne    2775ee <<glass::engine::Watch>::print_utf8+0x8ce>
  2775c7:	lea    0x18(%rbx),%rdi
  2775cb:	mov    %r9,%r12
  2775ce:	mov    %rdx,0x8(%rsp)
  2775d3:	call   *0x3b156f(%rip)        # 628b48 <_DYNAMIC+0x268>
  2775d9:	mov    0x8(%rsp),%rdx
  2775de:	mov    %r12,%r9
  2775e1:	mov    0x30(%rsp),%r12
  2775e6:	mov    0x98(%rsp),%r8
  2775ee:	movq   $0x0,(%rbx)
  2775f5:	mov    0x20(%rsp),%eax
  2775f9:	mov    %eax,0x8(%rbx)
  2775fc:	mov    0x78(%rsp),%ecx
  277600:	mov    %ecx,0xc(%rbx)
  277603:	mov    %r9d,0x10(%rbx)
  277607:	mov    0xa8(%rsp),%esi
  27760e:	mov    %si,0x14(%rbx)
  277612:	movq   $0x0,0x18(%rbx)
  27761a:	mov    %eax,0x20(%rbx)
  27761d:	mov    %ecx,0x24(%rbx)
  277620:	movl   $0x20,0x28(%rbx)
  277627:	mov    0xc0(%rsp),%eax
  27762e:	mov    %ax,0x2c(%rbx)
  277632:	movl   $0x0,0x5c(%rsp)
  27763a:	mov    0x18(%rsp),%rsi
  27763f:	jmp    2776bf <<glass::engine::Watch>::print_utf8+0x99f>
  277641:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  277650:	cmp    %r14,%rdi
  277653:	jae    278dcf <<glass::engine::Watch>::print_utf8+0x20af>
  277659:	lea    (%rbx,%rbx,2),%rax
  27765d:	mov    0x10(%rsp),%rcx
  277662:	lea    (%rcx,%rax,8),%rbx
  277666:	mov    (%rcx,%rax,8),%rax
  27766a:	test   %rax,%rax
  27766d:	je     27769e <<glass::engine::Watch>::print_utf8+0x97e>
  27766f:	lock decq (%rax)
  277673:	jne    27769e <<glass::engine::Watch>::print_utf8+0x97e>
  277675:	mov    %rbx,%rdi
  277678:	mov    %r9,(%rsp)
  27767c:	mov    %rdx,%r13
  27767f:	call   *0x3b14c3(%rip)        # 628b48 <_DYNAMIC+0x268>
  277685:	mov    0x30(%rsp),%r12
  27768a:	mov    %r13,%rdx
  27768d:	mov    (%rsp),%r9
  277691:	mov    0x98(%rsp),%r8
  277699:	mov    0x18(%rsp),%rsi
  27769e:	movq   $0x0,(%rbx)
  2776a5:	mov    0x20(%rsp),%eax
  2776a9:	mov    %eax,0x8(%rbx)
  2776ac:	mov    0x78(%rsp),%eax
  2776b0:	mov    %eax,0xc(%rbx)
  2776b3:	mov    0x70(%rsp),%eax
  2776b7:	mov    %ax,0x14(%rbx)
  2776bb:	mov    %r9d,0x10(%rbx)
  2776bf:	xor    %edi,%edi
  2776c1:	cmp    0xb0(%rsp),%r15
  2776c9:	setae  %dil
  2776cd:	mov    %r15,%rbx
  2776d0:	sub    %rdi,%rbx
  2776d3:	incq   0x80(%rsp)
  2776db:	mov    %r15,%r11
  2776de:	mov    0x90(%rsp),%r10
  2776e6:	jmp    277203 <<glass::engine::Watch>::print_utf8+0x4e3>
  2776eb:	mov    $0x1,%al
  2776ed:	test   %al,%al
  2776ef:	je     277576 <<glass::engine::Watch>::print_utf8+0x856>
  2776f5:	jmp    278721 <<glass::engine::Watch>::print_utf8+0x1a01>
  2776fa:	mov    %r9,%rbx
  2776fd:	mov    %rdx,%r15
  277700:	mov    %rdi,0x8(%rsp)
  277705:	mov    %r11,%r13
  277708:	call   1930a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  27770d:	mov    %r13,%r11
  277710:	mov    0x8(%rsp),%rdi
  277715:	mov    %r15,%rdx
  277718:	mov    %rbx,%r9
  27771b:	mov    0x98(%rsp),%r8
  277723:	mov    %r9d,%ebx
  277726:	mov    0x3b4403(%rip),%rsi        # 62bb30 <glass::engine::width_of::CACHE+0x8>
  27772d:	cmp    %rbx,%rsi
  277730:	ja     277404 <<glass::engine::Watch>::print_utf8+0x6e4>
  277736:	jmp    278dbf <<glass::engine::Watch>::print_utf8+0x209f>
  27773b:	nopl   0x0(%rax,%rax,1)
  277740:	movq   $0x0,0x80(%rsp)
  27774c:	xor    %edi,%edi
  27774e:	mov    0x18(%rsp),%rsi
  277753:	jmp    2777ab <<glass::engine::Watch>::print_utf8+0xa8b>
  277755:	mov    $0x1,%dil
  277758:	jmp    27775c <<glass::engine::Watch>::print_utf8+0xa3c>
  27775a:	xor    %edi,%edi
  27775c:	mov    %r11,%r15
  27775f:	mov    %r9d,%ebp
  277762:	mov    %r12,%rdx
  277765:	cmp    %r10,%r15
  277768:	jbe    27777f <<glass::engine::Watch>::print_utf8+0xa5f>
  27776a:	mov    0xb8(%rsp),%rcx
  277772:	mov    (%rcx),%rax
  277775:	cmp    %rax,%r15
  277778:	cmova  %r15,%rax
  27777c:	mov    %rax,(%rcx)
  27777f:	cmpq   $0x8,0x80(%rsp)
  277788:	setae  %al
  27778b:	testb  $0x1,0x5c(%rsp)
  277790:	jne    277794 <<glass::engine::Watch>::print_utf8+0xa74>
  277792:	xor    %eax,%eax
  277794:	test   %al,%al
  277796:	mov    0x28(%rsp),%r13
  27779b:	jne    277800 <<glass::engine::Watch>::print_utf8+0xae0>
  27779d:	mov    %rbx,%r10
  2777a0:	mov    %ebp,%r9d
  2777a3:	mov    0xa0(%rsp),%r12
  2777ab:	mov    %r10,0x40(%r12)
  2777b0:	mov    %dil,0x6c(%r12)
  2777b5:	mov    0x80(%rsp),%rax
  2777bd:	mov    0x88(%rsp),%rcx
  2777c5:	add    %rax,0xa0(%rcx)
  2777cc:	jmp    277887 <<glass::engine::Watch>::print_utf8+0xb67>
  2777d1:	xor    %edi,%edi
  2777d3:	mov    %r13,%r15
  2777d6:	jmp    27775f <<glass::engine::Watch>::print_utf8+0xa3f>
  2777d8:	mov    %r11,%r15
  2777db:	mov    %r9d,%ebp
  2777de:	mov    0x30(%rsp),%rdx
  2777e3:	jmp    277765 <<glass::engine::Watch>::print_utf8+0xa45>
  2777e5:	mov    %r11,%r15
  2777e8:	mov    %r9d,%ebp
  2777eb:	mov    0x30(%rsp),%rdx
  2777f0:	mov    0x90(%rsp),%r10
  2777f8:	mov    %r12,%rbx
  2777fb:	jmp    277765 <<glass::engine::Watch>::print_utf8+0xa45>
  277800:	mov    %rbx,%r12
  277803:	mov    %rdx,0x8(%rsp)
  277808:	movzbl %dil,%edx
  27780c:	add    %rbx,%rdx
  27780f:	mov    %rdi,%rbx
  277812:	mov    0xd0(%rsp),%rdi
  27781a:	mov    %r10,%rsi
  27781d:	lea    0xd8(%rsp),%rcx
  277825:	call   2bbbf0 <glass::engine::note_uniform_span>
  27782a:	mov    %rbx,%rdi
  27782d:	mov    0x8(%rsp),%rdx
  277832:	mov    0x98(%rsp),%r8
  27783a:	mov    0x18(%rsp),%rsi
  27783f:	mov    %r12,%r10
  277842:	jmp    2777a0 <<glass::engine::Watch>::print_utf8+0xa80>
  277847:	nopw   0x0(%rax,%rax,1)
  277850:	mov    0x88(%rsp),%rdi
  277858:	mov    %ebp,%esi
  27785a:	mov    %r8,%rbx
  27785d:	mov    %r9,%r14
  277860:	mov    %rdx,%r15
  277863:	call   357570 <<glass::engine::Watch as vte::ansi::Handler>::input>
  277868:	mov    %r15,%rdx
  27786b:	mov    %r14,%r9
  27786e:	mov    %rbx,%r8
  277871:	mov    0x18(%rsp),%rsi
  277876:	mov    %r12,%r13
  277879:	add    %r12,%rdx
  27787c:	cmpb   $0x0,0x68(%rsp)
  277881:	jne    276dd0 <<glass::engine::Watch>::print_utf8+0xb0>
  277887:	mov    %r9d,%ebp
  27788a:	mov    %r13,%rbx
  27788d:	mov    %rdx,%r13
  277890:	cmp    %r8,%rdx
  277893:	jae    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  277899:	movzbl (%rsi,%r13,1),%r9d
  27789e:	test   %r9b,%r9b
  2778a1:	js     2778c0 <<glass::engine::Watch>::print_utf8+0xba0>
  2778a3:	mov    $0x1,%edx
  2778a8:	lea    -0x7f(%r9),%eax
  2778ac:	cmp    $0x21,%eax
  2778af:	jae    277a48 <<glass::engine::Watch>::print_utf8+0xd28>
  2778b5:	jmp    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2778ba:	nopw   0x0(%rax,%rax,1)
  2778c0:	lea    0x3e(%r9),%eax
  2778c4:	cmp    $0x1e,%al
  2778c6:	jae    277900 <<glass::engine::Watch>::print_utf8+0xbe0>
  2778c8:	lea    0x1(%r13),%rax
  2778cc:	cmp    %r8,%rax
  2778cf:	jae    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2778d5:	movzbl (%rsi,%rax,1),%eax
  2778d9:	cmp    $0xc0,%al
  2778db:	jge    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2778e1:	and    $0x1f,%r9d
  2778e5:	shl    $0x6,%r9d
  2778e9:	mov    $0x2,%edx
  2778ee:	jmp    277a18 <<glass::engine::Watch>::print_utf8+0xcf8>
  2778f3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  277900:	mov    %r9d,%eax
  277903:	and    $0xf0,%al
  277905:	cmp    $0xe0,%al
  277907:	jne    277923 <<glass::engine::Watch>::print_utf8+0xc03>
  277909:	mov    $0xbf,%al
  27790b:	cmp    $0xe0,%r9d
  277912:	je     277949 <<glass::engine::Watch>::print_utf8+0xc29>
  277914:	mov    $0x80,%cl
  277916:	cmp    $0xed,%r9d
  27791d:	jne    27794b <<glass::engine::Watch>::print_utf8+0xc2b>
  27791f:	mov    $0x9f,%al
  277921:	jmp    27794b <<glass::engine::Watch>::print_utf8+0xc2b>
  277923:	lea    0x10(%r9),%eax
  277927:	cmp    $0x5,%al
  277929:	jae    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  27792f:	mov    $0x80,%al
  277931:	cmp    $0xf4,%r9d
  277938:	je     2779a0 <<glass::engine::Watch>::print_utf8+0xc80>
  27793a:	mov    $0xbf,%cl
  27793c:	cmp    $0xf0,%r9d
  277943:	jne    2779a2 <<glass::engine::Watch>::print_utf8+0xc82>
  277945:	mov    $0x90,%al
  277947:	jmp    2779a2 <<glass::engine::Watch>::print_utf8+0xc82>
  277949:	mov    $0xa0,%cl
  27794b:	lea    0x1(%r13),%rdx
  27794f:	cmp    %r8,%rdx
  277952:	jae    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  277958:	movzbl (%rsi,%rdx,1),%edx
  27795c:	cmp    %dl,%cl
  27795e:	ja     2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  277964:	cmp    %al,%dl
  277966:	ja     2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  27796c:	lea    0x2(%r13),%rax
  277970:	cmp    %r8,%rax
  277973:	jae    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  277979:	movzbl (%rsi,%rax,1),%eax
  27797d:	cmp    $0xc0,%al
  27797f:	jge    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  277985:	movzbl %dl,%ecx
  277988:	and    $0x3f,%ecx
  27798b:	shl    $0x6,%ecx
  27798e:	and    $0xf,%r9d
  277992:	shl    $0xc,%r9d
  277996:	or     %ecx,%r9d
  277999:	mov    $0x3,%edx
  27799e:	jmp    277a18 <<glass::engine::Watch>::print_utf8+0xcf8>
  2779a0:	mov    $0x8f,%cl
  2779a2:	lea    0x1(%r13),%rdx
  2779a6:	cmp    %r8,%rdx
  2779a9:	jae    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2779af:	movzbl (%rsi,%rdx,1),%edx
  2779b3:	cmp    %dl,%al
  2779b5:	ja     2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2779bb:	cmp    %cl,%dl
  2779bd:	ja     2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2779c3:	lea    0x2(%r13),%rax
  2779c7:	cmp    %r8,%rax
  2779ca:	jae    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2779d0:	movzbl (%rsi,%rax,1),%ecx
  2779d4:	cmp    $0xbf,%cl
  2779d7:	jg     2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2779dd:	lea    0x3(%r13),%rax
  2779e1:	cmp    %r8,%rax
  2779e4:	jae    2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2779ea:	movzbl (%rsi,%rax,1),%eax
  2779ee:	cmp    $0xbf,%al
  2779f0:	jg     2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  2779f6:	movzbl %dl,%edx
  2779f9:	and    $0x3f,%ecx
  2779fc:	shl    $0x6,%ecx
  2779ff:	and    $0x3f,%edx
  277a02:	shl    $0xc,%edx
  277a05:	and    $0x7,%r9d
  277a09:	shl    $0x12,%r9d
  277a0d:	or     %edx,%r9d
  277a10:	or     %ecx,%r9d
  277a13:	mov    $0x4,%edx
  277a18:	mov    %r9d,%ecx
  277a1b:	xor    $0xd800,%ecx
  277a21:	add    $0xffef0000,%ecx
  277a27:	cmp    $0xffef0800,%ecx
  277a2d:	jb     2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  277a33:	and    $0x3f,%al
  277a35:	movzbl %al,%eax
  277a38:	or     %eax,%r9d
  277a3b:	lea    -0x7f(%r9),%eax
  277a3f:	cmp    $0x21,%eax
  277a42:	jb     2783d2 <<glass::engine::Watch>::print_utf8+0x16b2>
  277a48:	cmp    $0xffffffff,%ebp
  277a4b:	je     278390 <<glass::engine::Watch>::print_utf8+0x1670>
  277a51:	mov    %r13,%r12
  277a54:	lea    -0x20(%rbp),%eax
  277a57:	cmp    $0x5f,%eax
  277a5a:	jae    277a80 <<glass::engine::Watch>::print_utf8+0xd60>
  277a5c:	mov    $0x1,%r13d
  277a62:	cmpb   $0x0,0x60(%rsp)
  277a67:	je     277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277a6d:	jmp    277b31 <<glass::engine::Watch>::print_utf8+0xe11>
  277a72:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  277a80:	cmpb   $0x0,0x68(%rsp)
  277a85:	je     277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277a8b:	mov    0x3b40a7(%rip),%eax        # 62bb38 <glass::engine::width_of::CACHE+0x10>
  277a91:	test   %eax,%eax
  277a93:	jne    2783a3 <<glass::engine::Watch>::print_utf8+0x1683>
  277a99:	mov    %ebp,%r14d
  277a9c:	mov    0x3b408d(%rip),%rsi        # 62bb30 <glass::engine::width_of::CACHE+0x8>
  277aa3:	cmp    %r14,%rsi
  277aa6:	jbe    278d70 <<glass::engine::Watch>::print_utf8+0x2050>
  277aac:	mov    0x3b4075(%rip),%rbx        # 62bb28 <glass::engine::width_of::CACHE>
  277ab3:	movzbl (%rbx,%r14,1),%eax
  277ab8:	movzbl %al,%r13d
  277abc:	test   %r13b,%r13b
  277abf:	js     277acc <<glass::engine::Watch>::print_utf8+0xdac>
  277ac1:	mov    $0x1,%cl
  277ac3:	test   %cl,%cl
  277ac5:	jne    277b23 <<glass::engine::Watch>::print_utf8+0xe03>
  277ac7:	jmp    277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277acc:	cmp    $0xfe,%r13d
  277ad3:	je     277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277ad9:	mov    $0xfe,%al
  277adb:	cmp    $0x7f,%ebp
  277ade:	jae    277aea <<glass::engine::Watch>::print_utf8+0xdca>
  277ae0:	mov    $0x1,%r13d
  277ae6:	xor    %ecx,%ecx
  277ae8:	jmp    277b17 <<glass::engine::Watch>::print_utf8+0xdf7>
  277aea:	cmp    $0xa0,%ebp
  277af0:	jb     277b15 <<glass::engine::Watch>::print_utf8+0xdf5>
  277af2:	mov    %ebp,%edi
  277af4:	mov    %r9,%r13
  277af7:	mov    %rdx,%r15
  277afa:	call   2ad720 <unicode_width::tables::lookup_width>
  277aff:	mov    %r15,%rdx
  277b02:	mov    %r13,%r9
  277b05:	mov    0x98(%rsp),%r8
  277b0d:	movzbl %al,%r13d
  277b11:	mov    $0x1,%cl
  277b13:	jmp    277b17 <<glass::engine::Watch>::print_utf8+0xdf7>
  277b15:	xor    %ecx,%ecx
  277b17:	mov    %al,(%rbx,%r14,1)
  277b1b:	test   %cl,%cl
  277b1d:	je     277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277b23:	lea    -0x1(%r13),%rax
  277b27:	cmp    $0x1,%rax
  277b2b:	ja     277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277b31:	mov    0x88(%rsp),%rax
  277b39:	mov    0x78(%rax),%r10
  277b3d:	cmpb   $0x0,0x6c(%r10)
  277b42:	jne    277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277b48:	mov    0x40(%r10),%rcx
  277b4c:	mov    0xa0(%r10),%rbx
  277b53:	mov    %rcx,(%rsp)
  277b57:	lea    (%rcx,%r13,1),%r11
  277b5b:	cmp    %rbx,%r11
  277b5e:	ja     277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277b64:	mov    0x30(%r10),%eax
  277b68:	sub    0x48(%r10),%eax
  277b6c:	cltq
  277b6e:	mov    0x20(%r10),%rsi
  277b72:	mov    0x28(%r10),%rcx
  277b76:	lea    (%rcx,%rax,1),%rdi
  277b7a:	dec    %rdi
  277b7d:	cmp    %rsi,%rdi
  277b80:	mov    $0x0,%eax
  277b85:	cmovae %rsi,%rax
  277b89:	sub    %rax,%rdi
  277b8c:	cmp    %rsi,%rdi
  277b8f:	jae    278e0f <<glass::engine::Watch>::print_utf8+0x20ef>
  277b95:	mov    0x58(%r10),%eax
  277b99:	mov    %eax,0x80(%rsp)
  277ba0:	mov    0x5c(%r10),%eax
  277ba4:	mov    %eax,0x90(%rsp)
  277bab:	movzwl 0x64(%r10),%eax
  277bb0:	mov    %eax,0xb0(%rsp)
  277bb7:	mov    0x18(%r10),%rax
  277bbb:	shl    $0x6,%rdi
  277bbf:	lea    (%rax,%rdi,1),%rcx
  277bc3:	lea    (%rax,%rdi,1),%r14
  277bc7:	add    $0x18,%r14
  277bcb:	mov    0x28(%rax,%rdi,1),%eax
  277bcf:	mov    %rcx,%rdi
  277bd2:	cmp    $0xffffffff,%eax
  277bd5:	je     277be4 <<glass::engine::Watch>::print_utf8+0xec4>
  277bd7:	mov    %r14,%rcx
  277bda:	mov    (%rsp),%rsi
  277bde:	cmp    0x30(%rdi),%rsi
  277be2:	jae    277c02 <<glass::engine::Watch>::print_utf8+0xee2>
  277be4:	mov    0x10(%rdi),%rsi
  277be8:	cmp    %rsi,(%rsp)
  277bec:	jae    278e1c <<glass::engine::Watch>::print_utf8+0x20fc>
  277bf2:	mov    (%rsp),%rcx
  277bf6:	lea    (%rcx,%rcx,2),%rcx
  277bfa:	shl    $0x3,%rcx
  277bfe:	add    0x8(%rdi),%rcx
  277c02:	testb  $0x60,0x14(%rcx)
  277c06:	jne    277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277c0c:	cmp    $0x2,%r13
  277c10:	mov    %rdi,0x28(%rsp)
  277c15:	mov    %r14,0x20(%rsp)
  277c1a:	jne    277c69 <<glass::engine::Watch>::print_utf8+0xf49>
  277c1c:	mov    (%rsp),%rcx
  277c20:	lea    0x1(%rcx),%rdi
  277c24:	cmp    $0xffffffff,%eax
  277c27:	je     277c37 <<glass::engine::Watch>::print_utf8+0xf17>
  277c29:	mov    %r14,%rcx
  277c2c:	mov    0x28(%rsp),%rsi
  277c31:	cmp    0x30(%rsi),%rdi
  277c35:	jae    277c5a <<glass::engine::Watch>::print_utf8+0xf3a>
  277c37:	mov    0x28(%rsp),%r14
  277c3c:	mov    0x10(%r14),%rsi
  277c40:	cmp    %rsi,%rdi
  277c43:	jae    278e41 <<glass::engine::Watch>::print_utf8+0x2121>
  277c49:	lea    (%rdi,%rdi,2),%rcx
  277c4d:	shl    $0x3,%rcx
  277c51:	add    0x8(%r14),%rcx
  277c55:	mov    0x20(%rsp),%r14
  277c5a:	testb  $0x60,0x14(%rcx)
  277c5e:	mov    0x28(%rsp),%rdi
  277c63:	jne    277850 <<glass::engine::Watch>::print_utf8+0xb30>
  277c69:	mov    %rdx,0x8(%rsp)
  277c6e:	mov    (%rsp),%rcx
  277c72:	cmp    %ecx,0x38(%rdi)
  277c75:	jbe    277c7e <<glass::engine::Watch>::print_utf8+0xf5e>
  277c77:	mov    (%rsp),%rcx
  277c7b:	mov    %ecx,0x38(%rdi)
  277c7e:	cmp    $0xffffffff,%eax
  277c81:	setne  %dl
  277c84:	mov    0x30(%rdi),%rcx
  277c88:	cmp    %rcx,(%rsp)
  277c8c:	sete   %sil
  277c90:	test   %sil,%dl
  277c93:	mov    %r10,0x78(%rsp)
  277c98:	mov    %r11,0x70(%rsp)
  277c9d:	mov    %rbx,0x30(%rsp)
  277ca2:	jne    277d14 <<glass::engine::Watch>::print_utf8+0xff4>
  277ca4:	cmp    $0xffffffff,%eax
  277ca7:	je     277f51 <<glass::engine::Watch>::print_utf8+0x1231>
  277cad:	mov    0x10(%rdi),%rax
  277cb1:	cmp    %rcx,%rax
  277cb4:	mov    %rcx,%rdx
  277cb7:	cmovb  %rax,%rdx
  277cbb:	mov    %rdx,0xa8(%rsp)
  277cc3:	mov    (%rsp),%r15
  277cc7:	cmp    %r15,%rax
  277cca:	cmovb  %rax,%r15
  277cce:	mov    0x3b0f2b(%rip),%rdx        # 628c00 <_DYNAMIC+0x320>
  277cd5:	movzbl (%rdx),%edx
  277cd8:	test   %dl,%dl
  277cda:	je     277d82 <<glass::engine::Watch>::print_utf8+0x1062>
  277ce0:	mov    0x3b0f51(%rip),%rdx        # 628c38 <_DYNAMIC+0x358>
  277ce7:	cmp    %r15,%rcx
  277cea:	jae    277cf3 <<glass::engine::Watch>::print_utf8+0xfd3>
  277cec:	mov    0x3b0f4d(%rip),%rdx        # 628c40 <_DYNAMIC+0x360>
  277cf3:	lock incq 0x28(%rdx)
  277cf8:	mov    0x3b0f19(%rip),%rdx        # 628c18 <_DYNAMIC+0x338>
  277cff:	lock incq (%rdx)
  277d03:	mov    %r15,%rdx
  277d06:	sub    0xa8(%rsp),%rdx
  277d0e:	jne    277d32 <<glass::engine::Watch>::print_utf8+0x1012>
  277d10:	xor    %esi,%esi
  277d12:	jmp    277d76 <<glass::engine::Watch>::print_utf8+0x1056>
  277d14:	mov    (%rsp),%rcx
  277d18:	lea    0x1(%rcx),%rax
  277d1c:	mov    %rax,0x30(%rdi)
  277d20:	mov    0x10(%rdi),%rsi
  277d24:	cmp    %rsi,%rcx
  277d27:	jb     277f75 <<glass::engine::Watch>::print_utf8+0x1255>
  277d2d:	jmp    278e4e <<glass::engine::Watch>::print_utf8+0x212e>
  277d32:	mov    0x3b0ee7(%rip),%rsi        # 628c20 <_DYNAMIC+0x340>
  277d39:	lock add %rdx,(%rsi)
  277d3d:	cmp    $0x5,%rdx
  277d41:	jae    277d51 <<glass::engine::Watch>::print_utf8+0x1031>
  277d43:	lea    -0x21808a(%rip),%rsi        # 5fcc0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  277d4a:	movzbl -0x1(%rdx,%rsi,1),%esi
  277d4f:	jmp    277d76 <<glass::engine::Watch>::print_utf8+0x1056>
  277d51:	lea    -0x5(%rdx),%rdi
  277d55:	mov    $0x4,%esi
  277d5a:	cmp    $0x4,%rdi
  277d5e:	mov    0x28(%rsp),%rdi
  277d63:	jb     277d76 <<glass::engine::Watch>::print_utf8+0x1056>
  277d65:	add    $0xfffffffffffffff7,%rdx
  277d69:	cmp    $0x8,%rdx
  277d6d:	mov    $0x6,%esi
  277d72:	sbb    $0x0,%rsi
  277d76:	mov    0x3b0e93(%rip),%rdx        # 628c10 <_DYNAMIC+0x330>
  277d7d:	lock incq (%rdx,%rsi,8)
  277d82:	cmp    %r15,%rcx
  277d85:	jae    277f12 <<glass::engine::Watch>::print_utf8+0x11f2>
  277d8b:	mov    0x28(%rdi),%esi
  277d8e:	mov    0x20(%rdi),%r11d
  277d92:	mov    0x24(%rdi),%ecx
  277d95:	movzwl 0x2c(%rdi),%edx
  277d99:	mov    0x18(%rdi),%rax
  277d9d:	test   %rax,%rax
  277da0:	mov    %rax,0x10(%rsp)
  277da5:	mov    %ecx,0x38(%rsp)
  277da9:	je     277ddd <<glass::engine::Watch>::print_utf8+0x10bd>
  277dab:	lock incq (%rax)
  277daf:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  277db5:	mov    0x10(%rdi),%rbx
  277db9:	mov    %esi,0x50(%rsp)
  277dbd:	mov    %r11d,0x48(%rsp)
  277dc2:	mov    %ecx,0x4c(%rsp)
  277dc6:	mov    %edx,%r10d
  277dc9:	mov    %dx,0x54(%rsp)
  277dce:	mov    %rax,0x40(%rsp)
  277dd3:	cmp    %rbx,%r15
  277dd6:	jbe    277df7 <<glass::engine::Watch>::print_utf8+0x10d7>
  277dd8:	jmp    278d80 <<glass::engine::Watch>::print_utf8+0x2060>
  277ddd:	mov    %esi,0x50(%rsp)
  277de1:	mov    %r11d,0x48(%rsp)
  277de6:	mov    %ecx,0x4c(%rsp)
  277dea:	mov    %dx,0x54(%rsp)
  277def:	mov    %rax,0x40(%rsp)
  277df4:	mov    %edx,%r10d
  277df7:	mov    0xa8(%rsp),%rax
  277dff:	lea    0x0(,%rax,8),%rax
  277e07:	lea    (%rax,%rax,2),%rax
  277e0b:	mov    0x8(%rdi),%rbx
  277e0f:	add    %rax,%rbx
  277e12:	mov    %r15,0xc0(%rsp)
  277e1a:	lea    0x0(,%r15,8),%rcx
  277e22:	lea    (%rcx,%rcx,2),%r15
  277e26:	sub    %rax,%r15
  277e29:	mov    0x10(%rsp),%rdx
  277e2e:	mov    0x38(%rsp),%ecx
  277e32:	mov    %esi,0x5c(%rsp)
  277e36:	mov    %r11d,0xa0(%rsp)
  277e3e:	mov    %r10w,0xb8(%rsp)
  277e47:	jmp    277e6c <<glass::engine::Watch>::print_utf8+0x114c>
  277e49:	nopl   0x0(%rax)
  277e50:	mov    %rdx,(%rbx)
  277e53:	mov    %r11d,0x8(%rbx)
  277e57:	mov    %ecx,0xc(%rbx)
  277e5a:	mov    %esi,0x10(%rbx)
  277e5d:	mov    %r10w,0x14(%rbx)
  277e62:	add    $0x18,%rbx
  277e66:	add    $0xffffffffffffffe8,%r15
  277e6a:	je     277eca <<glass::engine::Watch>::print_utf8+0x11aa>
  277e6c:	test   %rdx,%rdx
  277e6f:	je     277e7b <<glass::engine::Watch>::print_utf8+0x115b>
  277e71:	lock incq (%rdx)
  277e75:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  277e7b:	mov    (%rbx),%rax
  277e7e:	test   %rax,%rax
  277e81:	je     277e50 <<glass::engine::Watch>::print_utf8+0x1130>
  277e83:	lock decq (%rax)
  277e87:	jne    277e50 <<glass::engine::Watch>::print_utf8+0x1130>
  277e89:	mov    %rbx,%rdi
  277e8c:	mov    %r9,%r14
  277e8f:	call   *0x3b0cb3(%rip)        # 628b48 <_DYNAMIC+0x268>
  277e95:	movzwl 0xb8(%rsp),%r10d
  277e9e:	mov    0x38(%rsp),%ecx
  277ea2:	mov    0xa0(%rsp),%r11d
  277eaa:	mov    0x5c(%rsp),%esi
  277eae:	mov    0x10(%rsp),%rdx
  277eb3:	mov    0x28(%rsp),%rdi
  277eb8:	mov    %r14,%r9
  277ebb:	mov    0x20(%rsp),%r14
  277ec0:	mov    0x98(%rsp),%r8
  277ec8:	jmp    277e50 <<glass::engine::Watch>::print_utf8+0x1130>
  277eca:	mov    0xa8(%rsp),%rcx
  277ed2:	cmp    %ecx,0x38(%rdi)
  277ed5:	jbe    277eda <<glass::engine::Watch>::print_utf8+0x11ba>
  277ed7:	mov    %ecx,0x38(%rdi)
  277eda:	test   %rdx,%rdx
  277edd:	mov    0xc0(%rsp),%r15
  277ee5:	je     277f0e <<glass::engine::Watch>::print_utf8+0x11ee>
  277ee7:	lock decq (%rdx)
  277eeb:	jne    277f0e <<glass::engine::Watch>::print_utf8+0x11ee>
  277eed:	lea    0x40(%rsp),%rdi
  277ef2:	mov    %r8,%rbx
  277ef5:	mov    %r9,%r14
  277ef8:	call   *0x3b0c4a(%rip)        # 628b48 <_DYNAMIC+0x268>
  277efe:	mov    0x28(%rsp),%rdi
  277f03:	mov    %r14,%r9
  277f06:	mov    0x20(%rsp),%r14
  277f0b:	mov    %rbx,%r8
  277f0e:	mov    0x10(%rdi),%rax
  277f12:	cmp    %rax,%r15
  277f15:	jb     277f51 <<glass::engine::Watch>::print_utf8+0x1231>
  277f17:	cmpl   $0xffffffff,0x28(%rdi)
  277f1b:	je     277f4a <<glass::engine::Watch>::print_utf8+0x122a>
  277f1d:	mov    (%r14),%rax
  277f20:	test   %rax,%rax
  277f23:	je     277f4a <<glass::engine::Watch>::print_utf8+0x122a>
  277f25:	lock decq (%rax)
  277f29:	jne    277f4a <<glass::engine::Watch>::print_utf8+0x122a>
  277f2b:	mov    %r14,%rdi
  277f2e:	mov    %r8,%rbx
  277f31:	mov    %r9,%r14
  277f34:	call   *0x3b0c0e(%rip)        # 628b48 <_DYNAMIC+0x268>
  277f3a:	mov    0x28(%rsp),%rdi
  277f3f:	mov    %r14,%r9
  277f42:	mov    0x20(%rsp),%r14
  277f47:	mov    %rbx,%r8
  277f4a:	movl   $0xffffffff,0x28(%rdi)
  277f51:	mov    0x30(%rdi),%rax
  277f55:	mov    (%rsp),%rdx
  277f59:	lea    0x1(%rdx),%rcx
  277f5d:	cmp    %rax,%rcx
  277f60:	cmova  %rcx,%rax
  277f64:	mov    0x10(%rdi),%rsi
  277f68:	mov    %rax,0x30(%rdi)
  277f6c:	cmp    %rsi,%rdx
  277f6f:	jae    278e5f <<glass::engine::Watch>::print_utf8+0x213f>
  277f75:	mov    0xb0(%rsp),%esi
  277f7c:	mov    %esi,%eax
  277f7e:	or     $0x20,%eax
  277f81:	cmp    $0x2,%r13
  277f85:	mov    0x8(%rdi),%rcx
  277f89:	mov    (%rsp),%rdx
  277f8d:	lea    (%rdx,%rdx,2),%rdx
  277f91:	lea    (%rcx,%rdx,8),%rbx
  277f95:	mov    %ebp,0x10(%rcx,%rdx,8)
  277f99:	mov    0x80(%rsp),%edi
  277fa0:	mov    %edi,0x8(%rcx,%rdx,8)
  277fa4:	cmovne %esi,%eax
  277fa7:	mov    0x90(%rsp),%esi
  277fae:	mov    %esi,0xc(%rcx,%rdx,8)
  277fb2:	mov    %ax,0x14(%rcx,%rdx,8)
  277fb7:	mov    (%rcx,%rdx,8),%rax
  277fbb:	test   %rax,%rax
  277fbe:	je     277fe0 <<glass::engine::Watch>::print_utf8+0x12c0>
  277fc0:	lock decq (%rax)
  277fc4:	jne    277fe0 <<glass::engine::Watch>::print_utf8+0x12c0>
  277fc6:	mov    %rbx,%rdi
  277fc9:	mov    %r8,%r14
  277fcc:	mov    %r9,%rbp
  277fcf:	call   *0x3b0b73(%rip)        # 628b48 <_DYNAMIC+0x268>
  277fd5:	mov    %rbp,%r9
  277fd8:	mov    %r14,%r8
  277fdb:	mov    0x20(%rsp),%r14
  277fe0:	movq   $0x0,(%rbx)
  277fe7:	cmp    $0x2,%r13
  277feb:	mov    %r12,%r13
  277fee:	mov    0x8(%rsp),%rdx
  277ff3:	jne    278354 <<glass::engine::Watch>::print_utf8+0x1634>
  277ff9:	mov    (%rsp),%rax
  277ffd:	lea    0x1(%rax),%r15
  278001:	mov    0x28(%rsp),%r11
  278006:	mov    0x30(%r11),%rax
  27800a:	mov    0x28(%r11),%ecx
  27800e:	cmp    %rax,%r15
  278011:	jne    278036 <<glass::engine::Watch>::print_utf8+0x1316>
  278013:	cmp    $0xffffffff,%ecx
  278016:	je     278036 <<glass::engine::Watch>::print_utf8+0x1316>
  278018:	mov    (%rsp),%rax
  27801c:	add    $0x2,%rax
  278020:	mov    %rax,0x30(%r11)
  278024:	mov    0x10(%r11),%rsi
  278028:	cmp    %rsi,%r15
  27802b:	jb     2782eb <<glass::engine::Watch>::print_utf8+0x15cb>
  278031:	jmp    278e70 <<glass::engine::Watch>::print_utf8+0x2150>
  278036:	cmp    $0xffffffff,%ecx
  278039:	je     2782c7 <<glass::engine::Watch>::print_utf8+0x15a7>
  27803f:	mov    0x10(%r11),%rcx
  278043:	cmp    %rax,%rcx
  278046:	mov    %rax,%rdi
  278049:	cmovb  %rcx,%rdi
  27804d:	cmp    %r15,%rcx
  278050:	mov    %r15,%r10
  278053:	cmovb  %rcx,%r10
  278057:	mov    0x3b0ba2(%rip),%rdx        # 628c00 <_DYNAMIC+0x320>
  27805e:	movzbl (%rdx),%edx
  278061:	test   %dl,%dl
  278063:	je     2780e4 <<glass::engine::Watch>::print_utf8+0x13c4>
  278065:	mov    0x3b0bcc(%rip),%rdx        # 628c38 <_DYNAMIC+0x358>
  27806c:	cmp    %r10,%rax
  27806f:	jae    278078 <<glass::engine::Watch>::print_utf8+0x1358>
  278071:	mov    0x3b0bc8(%rip),%rdx        # 628c40 <_DYNAMIC+0x360>
  278078:	lock incq 0x28(%rdx)
  27807d:	mov    0x3b0b94(%rip),%rdx        # 628c18 <_DYNAMIC+0x338>
  278084:	lock incq (%rdx)
  278088:	mov    %r10,%rdx
  27808b:	sub    %rdi,%rdx
  27808e:	jne    278094 <<glass::engine::Watch>::print_utf8+0x1374>
  278090:	xor    %esi,%esi
  278092:	jmp    2780d8 <<glass::engine::Watch>::print_utf8+0x13b8>
  278094:	mov    0x3b0b85(%rip),%rsi        # 628c20 <_DYNAMIC+0x340>
  27809b:	lock add %rdx,(%rsi)
  27809f:	cmp    $0x5,%rdx
  2780a3:	jae    2780b3 <<glass::engine::Watch>::print_utf8+0x1393>
  2780a5:	lea    -0x2183ec(%rip),%rsi        # 5fcc0 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2780ac:	movzbl -0x1(%rdx,%rsi,1),%esi
  2780b1:	jmp    2780d8 <<glass::engine::Watch>::print_utf8+0x13b8>
  2780b3:	lea    -0x5(%rdx),%r11
  2780b7:	mov    $0x4,%esi
  2780bc:	cmp    $0x4,%r11
  2780c0:	mov    0x28(%rsp),%r11
  2780c5:	jb     2780d8 <<glass::engine::Watch>::print_utf8+0x13b8>
  2780c7:	add    $0xfffffffffffffff7,%rdx
  2780cb:	cmp    $0x8,%rdx
  2780cf:	mov    $0x6,%esi
  2780d4:	sbb    $0x0,%rsi
  2780d8:	mov    0x3b0b31(%rip),%rdx        # 628c10 <_DYNAMIC+0x330>
  2780df:	lock incq (%rdx,%rsi,8)
  2780e4:	cmp    %r10,%rax
  2780e7:	mov    0x8(%rsp),%rdx
  2780ec:	jae    27829c <<glass::engine::Watch>::print_utf8+0x157c>
  2780f2:	mov    0x28(%r11),%ebp
  2780f6:	mov    0x20(%r11),%eax
  2780fa:	mov    0x24(%r11),%ecx
  2780fe:	movzwl 0x2c(%r11),%esi
  278103:	mov    0x18(%r11),%r13
  278107:	test   %r13,%r13
  27810a:	mov    %r13,0xa0(%rsp)
  278112:	mov    %eax,0x10(%rsp)
  278116:	mov    %ecx,0x38(%rsp)
  27811a:	mov    %si,0x5c(%rsp)
  27811f:	mov    %r15,0xa8(%rsp)
  278127:	je     27815b <<glass::engine::Watch>::print_utf8+0x143b>
  278129:	lock incq 0x0(%r13)
  27812e:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  278134:	mov    0x10(%r11),%rdx
  278138:	mov    %ebp,0x50(%rsp)
  27813c:	mov    %eax,0x48(%rsp)
  278140:	mov    %ecx,0x4c(%rsp)
  278144:	mov    %si,0x54(%rsp)
  278149:	mov    %r13,0x40(%rsp)
  27814e:	cmp    %rdx,%r10
  278151:	mov    %r10,%rsi
  278154:	jbe    278174 <<glass::engine::Watch>::print_utf8+0x1454>
  278156:	jmp    278da0 <<glass::engine::Watch>::print_utf8+0x2080>
  27815b:	mov    %ebp,0x50(%rsp)
  27815f:	mov    %eax,0x48(%rsp)
  278163:	mov    %ecx,0x4c(%rsp)
  278167:	mov    %si,0x54(%rsp)
  27816c:	mov    %r13,0x40(%rsp)
  278171:	mov    %r10,%rsi
  278174:	mov    %rdi,0xc0(%rsp)
  27817c:	lea    0x0(,%rdi,8),%rax
  278184:	lea    (%rax,%rax,2),%rax
  278188:	mov    0x8(%r11),%rbx
  27818c:	add    %rax,%rbx
  27818f:	mov    %rsi,0xb8(%rsp)
  278197:	lea    0x0(,%rsi,8),%rcx
  27819f:	lea    (%rcx,%rcx,2),%r15
  2781a3:	sub    %rax,%r15
  2781a6:	mov    0x10(%rsp),%ecx
  2781aa:	mov    0x38(%rsp),%edx
  2781ae:	movzwl 0x5c(%rsp),%esi
  2781b3:	jmp    2781da <<glass::engine::Watch>::print_utf8+0x14ba>
  2781b5:	data16 cs nopw 0x0(%rax,%rax,1)
  2781c0:	mov    %r13,(%rbx)
  2781c3:	mov    %ecx,0x8(%rbx)
  2781c6:	mov    %edx,0xc(%rbx)
  2781c9:	mov    %ebp,0x10(%rbx)
  2781cc:	mov    %si,0x14(%rbx)
  2781d0:	add    $0x18,%rbx
  2781d4:	add    $0xffffffffffffffe8,%r15
  2781d8:	je     278234 <<glass::engine::Watch>::print_utf8+0x1514>
  2781da:	test   %r13,%r13
  2781dd:	je     2781ea <<glass::engine::Watch>::print_utf8+0x14ca>
  2781df:	lock incq 0x0(%r13)
  2781e4:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  2781ea:	mov    (%rbx),%rax
  2781ed:	test   %rax,%rax
  2781f0:	je     2781c0 <<glass::engine::Watch>::print_utf8+0x14a0>
  2781f2:	lock decq (%rax)
  2781f6:	jne    2781c0 <<glass::engine::Watch>::print_utf8+0x14a0>
  2781f8:	mov    %rbx,%rdi
  2781fb:	mov    %r8,%r14
  2781fe:	mov    %ebp,%r13d
  278201:	mov    %r9,%rbp
  278204:	call   *0x3b093e(%rip)        # 628b48 <_DYNAMIC+0x268>
  27820a:	movzwl 0x5c(%rsp),%esi
  27820f:	mov    0x38(%rsp),%edx
  278213:	mov    0x10(%rsp),%ecx
  278217:	mov    0x28(%rsp),%r11
  27821c:	mov    %rbp,%r9
  27821f:	mov    %r13d,%ebp
  278222:	mov    0xa0(%rsp),%r13
  27822a:	mov    %r14,%r8
  27822d:	mov    0x20(%rsp),%r14
  278232:	jmp    2781c0 <<glass::engine::Watch>::print_utf8+0x14a0>
  278234:	mov    0xc0(%rsp),%rax
  27823c:	cmp    %eax,0x38(%r11)
  278240:	mov    0x8(%rsp),%rdx
  278245:	mov    0xa8(%rsp),%r15
  27824d:	jbe    278253 <<glass::engine::Watch>::print_utf8+0x1533>
  27824f:	mov    %eax,0x38(%r11)
  278253:	test   %r13,%r13
  278256:	mov    0xb8(%rsp),%r10
  27825e:	je     278295 <<glass::engine::Watch>::print_utf8+0x1575>
  278260:	lock decq 0x0(%r13)
  278265:	jne    278295 <<glass::engine::Watch>::print_utf8+0x1575>
  278267:	lea    0x40(%rsp),%rdi
  27826c:	mov    %r8,%rbx
  27826f:	mov    %r9,%r14
  278272:	call   *0x3b08d0(%rip)        # 628b48 <_DYNAMIC+0x268>
  278278:	mov    0x28(%rsp),%r11
  27827d:	mov    0x8(%rsp),%rdx
  278282:	mov    %r14,%r9
  278285:	mov    0x20(%rsp),%r14
  27828a:	mov    %rbx,%r8
  27828d:	mov    0xb8(%rsp),%r10
  278295:	mov    0x10(%r11),%rcx
  278299:	mov    %r12,%r13
  27829c:	cmp    %rcx,%r10
  27829f:	jb     2782c7 <<glass::engine::Watch>::print_utf8+0x15a7>
  2782a1:	mov    %r14,%rdi
  2782a4:	mov    %r8,%rbx
  2782a7:	mov    %r9,%r14
  2782aa:	call   1b72c0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2782af:	mov    0x28(%rsp),%r11
  2782b4:	mov    0x8(%rsp),%rdx
  2782b9:	mov    %r14,%r9
  2782bc:	mov    %rbx,%r8
  2782bf:	movl   $0xffffffff,0x28(%r11)
  2782c7:	mov    0x30(%r11),%rax
  2782cb:	mov    (%rsp),%rcx
  2782cf:	add    $0x2,%rcx
  2782d3:	cmp    %rax,%rcx
  2782d6:	cmovbe %rax,%rcx
  2782da:	mov    0x10(%r11),%rsi
  2782de:	mov    %rcx,0x30(%r11)
  2782e2:	cmp    %rsi,%r15
  2782e5:	jae    278e80 <<glass::engine::Watch>::print_utf8+0x2160>
  2782eb:	mov    0x8(%r11),%rax
  2782ef:	lea    (%r15,%r15,2),%rcx
  2782f3:	lea    (%rax,%rcx,8),%rbx
  2782f7:	movl   $0x20,0x10(%rax,%rcx,8)
  2782ff:	mov    0x80(%rsp),%esi
  278306:	mov    %esi,0x8(%rax,%rcx,8)
  27830a:	mov    0x90(%rsp),%esi
  278311:	mov    %esi,0xc(%rax,%rcx,8)
  278315:	mov    0xb0(%rsp),%esi
  27831c:	or     $0x40,%esi
  27831f:	mov    %si,0x14(%rax,%rcx,8)
  278324:	mov    (%rax,%rcx,8),%rax
  278328:	test   %rax,%rax
  27832b:	je     27834d <<glass::engine::Watch>::print_utf8+0x162d>
  27832d:	lock decq (%rax)
  278331:	jne    27834d <<glass::engine::Watch>::print_utf8+0x162d>
  278333:	mov    %rbx,%rdi
  278336:	mov    %r8,%r14
  278339:	mov    %r9,%r12
  27833c:	call   *0x3b0806(%rip)        # 628b48 <_DYNAMIC+0x268>
  278342:	mov    0x8(%rsp),%rdx
  278347:	mov    %r12,%r9
  27834a:	mov    %r14,%r8
  27834d:	movq   $0x0,(%rbx)
  278354:	mov    0x70(%rsp),%rcx
  278359:	cmp    0x30(%rsp),%rcx
  27835e:	mov    0x18(%rsp),%rsi
  278363:	mov    0x78(%rsp),%rax
  278368:	jb     278371 <<glass::engine::Watch>::print_utf8+0x1651>
  27836a:	dec    %rcx
  27836d:	movb   $0x1,0x6c(%rax)
  278371:	mov    %rcx,0x40(%rax)
  278375:	mov    0x88(%rsp),%rax
  27837d:	incq   0xa0(%rax)
  278384:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  278390:	add    %r13,%rdx
  278393:	cmpb   $0x0,0x68(%rsp)
  278398:	je     277887 <<glass::engine::Watch>::print_utf8+0xb67>
  27839e:	jmp    276dd0 <<glass::engine::Watch>::print_utf8+0xb0>
  2783a3:	mov    %r8,%rbx
  2783a6:	mov    %r9,%r14
  2783a9:	mov    %rdx,%r15
  2783ac:	call   1930a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2783b1:	mov    %r15,%rdx
  2783b4:	mov    %r14,%r9
  2783b7:	mov    %rbx,%r8
  2783ba:	mov    %ebp,%r14d
  2783bd:	mov    0x3b376c(%rip),%rsi        # 62bb30 <glass::engine::width_of::CACHE+0x8>
  2783c4:	cmp    %r14,%rsi
  2783c7:	ja     277aac <<glass::engine::Watch>::print_utf8+0xd8c>
  2783cd:	jmp    278d70 <<glass::engine::Watch>::print_utf8+0x2050>
  2783d2:	mov    0x88(%rsp),%rax
  2783da:	cmpq   $0x400,0xa0(%rax)
  2783e5:	jb     278424 <<glass::engine::Watch>::print_utf8+0x1704>
  2783e7:	mov    0x88(%rsp),%r15
  2783ef:	mov    %r15,%rdi
  2783f2:	mov    %r8,%r14
  2783f5:	call   279210 <<glass::engine::Watch>::fold_sentinel>
  2783fa:	mov    %r14,%r8
  2783fd:	movq   $0x0,0xa0(%r15)
  278408:	mov    0x3b3732(%rip),%eax        # 62bb40 <glass::engine::run_whole::ON>
  27840e:	test   %eax,%eax
  278410:	je     27842e <<glass::engine::Watch>::print_utf8+0x170e>
  278412:	mov    %r8,%r14
  278415:	call   193146 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  27841a:	mov    %r14,%r8
  27841d:	cmp    %r8,%r13
  278420:	je     278433 <<glass::engine::Watch>::print_utf8+0x1713>
  278422:	jmp    278466 <<glass::engine::Watch>::print_utf8+0x1746>
  278424:	mov    0x3b3716(%rip),%eax        # 62bb40 <glass::engine::run_whole::ON>
  27842a:	test   %eax,%eax
  27842c:	jne    278412 <<glass::engine::Watch>::print_utf8+0x16f2>
  27842e:	cmp    %r8,%r13
  278431:	jne    278466 <<glass::engine::Watch>::print_utf8+0x1746>
  278433:	cmpb   $0x0,0x3b370a(%rip)        # 62bb44 <glass::engine::run_whole::ON+0x4>
  27843a:	je     278466 <<glass::engine::Watch>::print_utf8+0x1746>
  27843c:	cmp    $0xffffffff,%ebp
  27843f:	je     278605 <<glass::engine::Watch>::print_utf8+0x18e5>
  278445:	mov    %r8,%r12
  278448:	lea    -0x20(%rbp),%eax
  27844b:	cmp    $0x5f,%eax
  27844e:	jae    278477 <<glass::engine::Watch>::print_utf8+0x1757>
  278450:	mov    $0x1,%r13d
  278456:	cmpb   $0x0,0x60(%rsp)
  27845b:	jne    27853d <<glass::engine::Watch>::print_utf8+0x181d>
  278461:	jmp    2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  278466:	xor    %eax,%eax
  278468:	cmp    $0xffffffff,%ebp
  27846b:	cmove  %rax,%rbx
  27846f:	mov    %rbx,%r8
  278472:	jmp    278605 <<glass::engine::Watch>::print_utf8+0x18e5>
  278477:	cmpb   $0x0,0x68(%rsp)
  27847c:	je     2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  278482:	mov    0x3b36b0(%rip),%eax        # 62bb38 <glass::engine::width_of::CACHE+0x10>
  278488:	test   %eax,%eax
  27848a:	jne    278d58 <<glass::engine::Watch>::print_utf8+0x2038>
  278490:	mov    %ebp,%r14d
  278493:	mov    0x3b3696(%rip),%rsi        # 62bb30 <glass::engine::width_of::CACHE+0x8>
  27849a:	cmp    %r14,%rsi
  27849d:	jbe    278d70 <<glass::engine::Watch>::print_utf8+0x2050>
  2784a3:	mov    0x3b367e(%rip),%rbx        # 62bb28 <glass::engine::width_of::CACHE>
  2784aa:	movzbl (%rbx,%r14,1),%eax
  2784af:	movzbl %al,%r13d
  2784b3:	test   %r13b,%r13b
  2784b6:	js     2784c3 <<glass::engine::Watch>::print_utf8+0x17a3>
  2784b8:	mov    $0x1,%cl
  2784ba:	test   %cl,%cl
  2784bc:	jne    27852f <<glass::engine::Watch>::print_utf8+0x180f>
  2784be:	jmp    2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  2784c3:	cmp    $0xfe,%r13d
  2784ca:	je     2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  2784d0:	mov    $0xfe,%al
  2784d2:	cmp    $0x7f,%ebp
  2784d5:	jae    27850a <<glass::engine::Watch>::print_utf8+0x17ea>
  2784d7:	mov    $0x1,%r13d
  2784dd:	xor    %ecx,%ecx
  2784df:	jmp    278523 <<glass::engine::Watch>::print_utf8+0x1803>
  2784e1:	mov    $0x1,%cl
  2784e3:	mov    %ecx,0x68(%rsp)
  2784e7:	cmpb   $0x0,0x68(%rax)
  2784eb:	jne    2784fd <<glass::engine::Watch>::print_utf8+0x17dd>
  2784ed:	cmpb   $0x0,0x69(%rax)
  2784f1:	jne    2784fd <<glass::engine::Watch>::print_utf8+0x17dd>
  2784f3:	cmpb   $0x0,0x6a(%rax)
  2784f7:	je     278731 <<glass::engine::Watch>::print_utf8+0x1a11>
  2784fd:	movl   $0x0,0x60(%rsp)
  278505:	jmp    276d90 <<glass::engine::Watch>::print_utf8+0x70>
  27850a:	cmp    $0xa0,%ebp
  278510:	jb     278521 <<glass::engine::Watch>::print_utf8+0x1801>
  278512:	mov    %ebp,%edi
  278514:	call   2ad720 <unicode_width::tables::lookup_width>
  278519:	movzbl %al,%r13d
  27851d:	mov    $0x1,%cl
  27851f:	jmp    278523 <<glass::engine::Watch>::print_utf8+0x1803>
  278521:	xor    %ecx,%ecx
  278523:	mov    %al,(%rbx,%r14,1)
  278527:	test   %cl,%cl
  278529:	je     2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  27852f:	lea    -0x1(%r13),%rax
  278533:	cmp    $0x1,%rax
  278537:	ja     2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  27853d:	mov    0x88(%rsp),%rax
  278545:	mov    0x78(%rax),%r15
  278549:	cmpb   $0x0,0x6c(%r15)
  27854e:	jne    2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  278554:	mov    0x40(%r15),%r8
  278558:	mov    0xa0(%r15),%rdx
  27855f:	lea    (%r8,%r13,1),%r14
  278563:	cmp    %rdx,%r14
  278566:	ja     2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  27856c:	mov    0x30(%r15),%eax
  278570:	sub    0x48(%r15),%eax
  278574:	cltq
  278576:	mov    0x20(%r15),%rsi
  27857a:	mov    0x28(%r15),%rcx
  27857e:	lea    (%rcx,%rax,1),%rdi
  278582:	dec    %rdi
  278585:	xor    %eax,%eax
  278587:	cmp    %rsi,%rdi
  27858a:	cmovae %rsi,%rax
  27858e:	sub    %rax,%rdi
  278591:	cmp    %rsi,%rdi
  278594:	jae    278e0f <<glass::engine::Watch>::print_utf8+0x20ef>
  27859a:	mov    0x58(%r15),%r10d
  27859e:	mov    0x5c(%r15),%r11d
  2785a2:	movzwl 0x64(%r15),%r9d
  2785a7:	mov    0x18(%r15),%rax
  2785ab:	shl    $0x6,%rdi
  2785af:	lea    (%rax,%rdi,1),%rbx
  2785b3:	lea    (%rax,%rdi,1),%rcx
  2785b7:	add    $0x18,%rcx
  2785bb:	mov    %rcx,0x68(%rsp)
  2785c0:	mov    0x28(%rax,%rdi,1),%eax
  2785c4:	cmp    $0xffffffff,%eax
  2785c7:	je     2785d4 <<glass::engine::Watch>::print_utf8+0x18b4>
  2785c9:	mov    0x68(%rsp),%rcx
  2785ce:	cmp    0x30(%rbx),%r8
  2785d2:	jae    2785ed <<glass::engine::Watch>::print_utf8+0x18cd>
  2785d4:	mov    0x10(%rbx),%rsi
  2785d8:	cmp    %rsi,%r8
  2785db:	jae    278e90 <<glass::engine::Watch>::print_utf8+0x2170>
  2785e1:	lea    (%r8,%r8,2),%rcx
  2785e5:	shl    $0x3,%rcx
  2785e9:	add    0x8(%rbx),%rcx
  2785ed:	testb  $0x60,0x14(%rcx)
  2785f1:	je     27861a <<glass::engine::Watch>::print_utf8+0x18fa>
  2785f3:	mov    0x88(%rsp),%rdi
  2785fb:	mov    %ebp,%esi
  2785fd:	call   357570 <<glass::engine::Watch as vte::ansi::Handler>::input>
  278602:	mov    %r12,%r8
  278605:	mov    %r8,%rax
  278608:	add    $0x108,%rsp
  27860f:	pop    %rbx
  278610:	pop    %r12
  278612:	pop    %r13
  278614:	pop    %r14
  278616:	pop    %r15
  278618:	pop    %rbp
  278619:	ret
  27861a:	cmp    $0x2,%r13
  27861e:	jne    278653 <<glass::engine::Watch>::print_utf8+0x1933>
  278620:	lea    0x1(%r8),%rdi
  278624:	cmp    $0xffffffff,%eax
  278627:	je     278634 <<glass::engine::Watch>::print_utf8+0x1914>
  278629:	mov    0x68(%rsp),%rcx
  27862e:	cmp    0x30(%rbx),%rdi
  278632:	jae    27864d <<glass::engine::Watch>::print_utf8+0x192d>
  278634:	mov    0x10(%rbx),%rsi
  278638:	cmp    %rsi,%rdi
  27863b:	jae    278e41 <<glass::engine::Watch>::print_utf8+0x2121>
  278641:	lea    (%rdi,%rdi,2),%rcx
  278645:	shl    $0x3,%rcx
  278649:	add    0x8(%rbx),%rcx
  27864d:	testb  $0x60,0x14(%rcx)
  278651:	jne    2785f3 <<glass::engine::Watch>::print_utf8+0x18d3>
  278653:	mov    %r11d,0x80(%rsp)
  27865b:	mov    %r10d,0xb0(%rsp)
  278663:	mov    %r9d,0x28(%rsp)
  278668:	mov    %rdx,0x90(%rsp)
  278670:	cmp    %r8d,0x38(%rbx)
  278674:	jbe    27867a <<glass::engine::Watch>::print_utf8+0x195a>
  278676:	mov    %r8d,0x38(%rbx)
  27867a:	cmp    $0xffffffff,%eax
  27867d:	setne  %cl
  278680:	mov    %rbx,%rdi
  278683:	mov    0x30(%rbx),%rbx
  278687:	cmp    %rbx,%r8
  27868a:	sete   %dl
  27868d:	test   %dl,%cl
  27868f:	mov    %r8,0x18(%rsp)
  278694:	mov    %rdi,(%rsp)
  278698:	jne    2786e9 <<glass::engine::Watch>::print_utf8+0x19c9>
  27869a:	cmp    $0xffffffff,%eax
  27869d:	je     278968 <<glass::engine::Watch>::print_utf8+0x1c48>
  2786a3:	mov    (%rsp),%rax
  2786a7:	mov    0x10(%rax),%r14
  2786ab:	cmp    %rbx,%r14
  2786ae:	mov    %rbx,%rax
  2786b1:	cmovb  %r14,%rax
  2786b5:	mov    %rax,0x38(%rsp)
  2786ba:	cmp    %r8,%r14
  2786bd:	mov    %r8,%rcx
  2786c0:	cmovb  %r14,%rcx
  2786c4:	mov    0x3b0535(%rip),%rax        # 628c00 <_DYNAMIC+0x320>
  2786cb:	movzbl (%rax),%eax
  2786ce:	test   %al,%al
  2786d0:	mov    %rcx,0x10(%rsp)
  2786d5:	je     278764 <<glass::engine::Watch>::print_utf8+0x1a44>
  2786db:	cmp    %rcx,%rbx
  2786de:	jae    278741 <<glass::engine::Watch>::print_utf8+0x1a21>
  2786e0:	mov    0x3b0559(%rip),%rax        # 628c40 <_DYNAMIC+0x360>
  2786e7:	jmp    278748 <<glass::engine::Watch>::print_utf8+0x1a28>
  2786e9:	lea    0x1(%r8),%rax
  2786ed:	mov    %rax,0x30(%rdi)
  2786f1:	mov    0x10(%rdi),%rsi
  2786f5:	cmp    %rsi,%r8
  2786f8:	mov    %rdi,%rdx
  2786fb:	jb     27898c <<glass::engine::Watch>::print_utf8+0x1c6c>
  278701:	lea    0x387278(%rip),%rdx        # 5ff980 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  278708:	mov    %r8,%rdi
  27870b:	call   *0x3b03e7(%rip)        # 628af8 <_DYNAMIC+0x218>
  278711:	lea    0x3871c0(%rip),%rcx        # 5ff8d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x167d0>
  278718:	mov    %r10,%rdi
  27871b:	call   *0x3b0597(%rip)        # 628cb8 <_DYNAMIC+0x3d8>
  278721:	lea    0x386b98(%rip),%rcx        # 5ff2c0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161b8>
  278728:	mov    %r14,%rdx
  27872b:	call   *0x3b0587(%rip)        # 628cb8 <_DYNAMIC+0x3d8>
  278731:	cmpb   $0x0,0x6b(%rax)
  278735:	sete   %al
  278738:	mov    %eax,0x60(%rsp)
  27873c:	jmp    276d90 <<glass::engine::Watch>::print_utf8+0x70>
  278741:	mov    0x3b04f0(%rip),%rax        # 628c38 <_DYNAMIC+0x358>
  278748:	lock incq 0x28(%rax)
  27874d:	mov    %rcx,%rdi
  278750:	sub    0x38(%rsp),%rdi
  278755:	call   310fb0 <alacritty_terminal::grid::row::fill_census::note>
  27875a:	mov    0x10(%rsp),%rcx
  27875f:	mov    0x18(%rsp),%r8
  278764:	cmp    %rcx,%rbx
  278767:	jae    278945 <<glass::engine::Watch>::print_utf8+0x1c25>
  27876d:	mov    (%rsp),%rcx
  278771:	mov    0x28(%rcx),%edi
  278774:	mov    0x20(%rcx),%r9d
  278778:	mov    0x24(%rcx),%r10d
  27877c:	movzwl 0x2c(%rcx),%r11d
  278781:	mov    0x18(%rcx),%rsi
  278785:	test   %rsi,%rsi
  278788:	mov    %rsi,0x20(%rsp)
  27878d:	mov    %edi,0x78(%rsp)
  278791:	mov    %r9d,0x70(%rsp)
  278796:	mov    %r10d,0x30(%rsp)
  27879b:	mov    %r11w,0x8(%rsp)
  2787a1:	je     27886c <<glass::engine::Watch>::print_utf8+0x1b4c>
  2787a7:	lock incq (%rsi)
  2787ab:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  2787b1:	mov    0x10(%rcx),%rdx
  2787b5:	mov    %edi,0x50(%rsp)
  2787b9:	mov    %r9d,0x48(%rsp)
  2787be:	mov    %r10d,0x4c(%rsp)
  2787c3:	mov    %r11w,0x54(%rsp)
  2787c9:	mov    %rsi,0x40(%rsp)
  2787ce:	mov    0x10(%rsp),%rsi
  2787d3:	cmp    %rdx,%rsi
  2787d6:	ja     278dfb <<glass::engine::Watch>::print_utf8+0x20db>
  2787dc:	mov    0x38(%rsp),%rax
  2787e1:	lea    0x0(,%rax,8),%rax
  2787e9:	lea    (%rax,%rax,2),%rax
  2787ed:	mov    0x8(%rcx),%rbx
  2787f1:	add    %rax,%rbx
  2787f4:	lea    0x0(,%rsi,8),%rcx
  2787fc:	lea    (%rcx,%rcx,2),%r14
  278800:	sub    %rax,%r14
  278803:	mov    0x20(%rsp),%rsi
  278808:	jmp    27882b <<glass::engine::Watch>::print_utf8+0x1b0b>
  27880a:	mov    %rsi,(%rbx)
  27880d:	mov    %r9d,0x8(%rbx)
  278811:	mov    %r10d,0xc(%rbx)
  278815:	mov    %edi,0x10(%rbx)
  278818:	mov    %r11w,0x14(%rbx)
  27881d:	add    $0x18,%rbx
  278821:	add    $0xffffffffffffffe8,%r14
  278825:	je     27890b <<glass::engine::Watch>::print_utf8+0x1beb>
  27882b:	lock incq (%rsi)
  27882f:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  278835:	mov    (%rbx),%rax
  278838:	test   %rax,%rax
  27883b:	je     27880a <<glass::engine::Watch>::print_utf8+0x1aea>
  27883d:	lock decq (%rax)
  278841:	jne    27880a <<glass::engine::Watch>::print_utf8+0x1aea>
  278843:	mov    %rbx,%rdi
  278846:	call   *0x3b02fc(%rip)        # 628b48 <_DYNAMIC+0x268>
  27884c:	movzwl 0x8(%rsp),%r11d
  278852:	mov    0x30(%rsp),%r10d
  278857:	mov    0x70(%rsp),%r9d
  27885c:	mov    0x78(%rsp),%edi
  278860:	mov    0x20(%rsp),%rsi
  278865:	mov    0x18(%rsp),%r8
  27886a:	jmp    27880a <<glass::engine::Watch>::print_utf8+0x1aea>
  27886c:	mov    %edi,0x50(%rsp)
  278870:	mov    %r9d,0x48(%rsp)
  278875:	mov    %r10d,0x4c(%rsp)
  27887a:	mov    %r11w,0x54(%rsp)
  278880:	mov    %rsi,0x40(%rsp)
  278885:	mov    0x38(%rsp),%rax
  27888a:	lea    0x0(,%rax,8),%rax
  278892:	lea    (%rax,%rax,2),%rax
  278896:	mov    0x8(%rcx),%rbx
  27889a:	add    %rax,%rbx
  27889d:	mov    0x10(%rsp),%rcx
  2788a2:	lea    0x0(,%rcx,8),%rcx
  2788aa:	lea    (%rcx,%rcx,2),%r14
  2788ae:	sub    %rax,%r14
  2788b1:	jmp    2788d4 <<glass::engine::Watch>::print_utf8+0x1bb4>
  2788b3:	movq   $0x0,(%rbx)
  2788ba:	mov    %r9d,0x8(%rbx)
  2788be:	mov    %r10d,0xc(%rbx)
  2788c2:	mov    %edi,0x10(%rbx)
  2788c5:	mov    %r11w,0x14(%rbx)
  2788ca:	add    $0x18,%rbx
  2788ce:	add    $0xffffffffffffffe8,%r14
  2788d2:	je     27890b <<glass::engine::Watch>::print_utf8+0x1beb>
  2788d4:	mov    (%rbx),%rax
  2788d7:	test   %rax,%rax
  2788da:	je     2788b3 <<glass::engine::Watch>::print_utf8+0x1b93>
  2788dc:	lock decq (%rax)
  2788e0:	jne    2788b3 <<glass::engine::Watch>::print_utf8+0x1b93>
  2788e2:	mov    %rbx,%rdi
  2788e5:	call   *0x3b025d(%rip)        # 628b48 <_DYNAMIC+0x268>
  2788eb:	movzwl 0x8(%rsp),%r11d
  2788f1:	mov    0x30(%rsp),%r10d
  2788f6:	mov    0x70(%rsp),%r9d
  2788fb:	mov    0x78(%rsp),%edi
  2788ff:	mov    0x20(%rsp),%rsi
  278904:	mov    0x18(%rsp),%r8
  278909:	jmp    2788b3 <<glass::engine::Watch>::print_utf8+0x1b93>
  27890b:	mov    (%rsp),%rbx
  27890f:	mov    0x38(%rsp),%rax
  278914:	cmp    %eax,0x38(%rbx)
  278917:	jbe    27891c <<glass::engine::Watch>::print_utf8+0x1bfc>
  278919:	mov    %eax,0x38(%rbx)
  27891c:	test   %rsi,%rsi
  27891f:	mov    0x10(%rsp),%rcx
  278924:	je     278941 <<glass::engine::Watch>::print_utf8+0x1c21>
  278926:	lock decq (%rsi)
  27892a:	jne    278941 <<glass::engine::Watch>::print_utf8+0x1c21>
  27892c:	lea    0x40(%rsp),%rdi
  278931:	call   *0x3b0211(%rip)        # 628b48 <_DYNAMIC+0x268>
  278937:	mov    0x10(%rsp),%rcx
  27893c:	mov    0x18(%rsp),%r8
  278941:	mov    0x10(%rbx),%r14
  278945:	cmp    %r14,%rcx
  278948:	lea    (%r8,%r13,1),%r14
  27894c:	jb     278968 <<glass::engine::Watch>::print_utf8+0x1c48>
  27894e:	mov    0x68(%rsp),%rdi
  278953:	call   1b72c0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  278958:	mov    0x18(%rsp),%r8
  27895d:	mov    (%rsp),%rax
  278961:	movl   $0xffffffff,0x28(%rax)
  278968:	mov    (%rsp),%rdx
  27896c:	mov    0x30(%rdx),%rax
  278970:	lea    0x1(%r8),%rcx
  278974:	cmp    %rax,%rcx
  278977:	cmova  %rcx,%rax
  27897b:	mov    0x10(%rdx),%rsi
  27897f:	mov    %rax,0x30(%rdx)
  278983:	cmp    %rsi,%r8
  278986:	jae    278ea0 <<glass::engine::Watch>::print_utf8+0x2180>
  27898c:	mov    0x28(%rsp),%esi
  278990:	mov    %esi,%eax
  278992:	or     $0x20,%eax
  278995:	cmp    $0x2,%r13
  278999:	mov    0x8(%rdx),%rcx
  27899d:	lea    (%r8,%r8,2),%rdx
  2789a1:	lea    (%rcx,%rdx,8),%rbx
  2789a5:	mov    %ebp,0x10(%rcx,%rdx,8)
  2789a9:	mov    0xb0(%rsp),%edi
  2789b0:	mov    %edi,0x8(%rcx,%rdx,8)
  2789b4:	cmovne %esi,%eax
  2789b7:	mov    0x80(%rsp),%esi
  2789be:	mov    %esi,0xc(%rcx,%rdx,8)
  2789c2:	mov    %ax,0x14(%rcx,%rdx,8)
  2789c7:	mov    (%rcx,%rdx,8),%rax
  2789cb:	test   %rax,%rax
  2789ce:	je     2789e4 <<glass::engine::Watch>::print_utf8+0x1cc4>
  2789d0:	lock decq (%rax)
  2789d4:	jne    2789e4 <<glass::engine::Watch>::print_utf8+0x1cc4>
  2789d6:	mov    %rbx,%rdi
  2789d9:	call   *0x3b0169(%rip)        # 628b48 <_DYNAMIC+0x268>
  2789df:	mov    0x18(%rsp),%r8
  2789e4:	movq   $0x0,(%rbx)
  2789eb:	cmp    $0x2,%r13
  2789ef:	jne    278d25 <<glass::engine::Watch>::print_utf8+0x2005>
  2789f5:	lea    0x1(%r8),%r13
  2789f9:	mov    (%rsp),%rax
  2789fd:	mov    0x30(%rax),%rbx
  278a01:	mov    0x28(%rax),%eax
  278a04:	cmp    %rbx,%r13
  278a07:	jne    278a37 <<glass::engine::Watch>::print_utf8+0x1d17>
  278a09:	cmp    $0xffffffff,%eax
  278a0c:	je     278a37 <<glass::engine::Watch>::print_utf8+0x1d17>
  278a0e:	add    $0x2,%r8
  278a12:	mov    (%rsp),%rcx
  278a16:	mov    %r8,0x30(%rcx)
  278a1a:	mov    0x10(%rcx),%rsi
  278a1e:	cmp    %rsi,%r13
  278a21:	jb     278cc9 <<glass::engine::Watch>::print_utf8+0x1fa9>
  278a27:	lea    0x386f52(%rip),%rdx        # 5ff980 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  278a2e:	mov    %r13,%rdi
  278a31:	call   *0x3b00c1(%rip)        # 628af8 <_DYNAMIC+0x218>
  278a37:	cmp    $0xffffffff,%eax
  278a3a:	je     278ca5 <<glass::engine::Watch>::print_utf8+0x1f85>
  278a40:	mov    %r14,0x38(%rsp)
  278a45:	mov    (%rsp),%rax
  278a49:	mov    0x10(%rax),%r14
  278a4d:	cmp    %rbx,%r14
  278a50:	mov    %rbx,%rax
  278a53:	cmovb  %r14,%rax
  278a57:	mov    %rax,0x10(%rsp)
  278a5c:	cmp    %r13,%r14
  278a5f:	mov    %r13,%rcx
  278a62:	cmovb  %r14,%rcx
  278a66:	mov    0x3b0193(%rip),%rax        # 628c00 <_DYNAMIC+0x320>
  278a6d:	movzbl (%rax),%eax
  278a70:	test   %al,%al
  278a72:	mov    %rcx,0x8(%rsp)
  278a77:	je     278aaa <<glass::engine::Watch>::print_utf8+0x1d8a>
  278a79:	cmp    %rcx,%rbx
  278a7c:	jae    278a87 <<glass::engine::Watch>::print_utf8+0x1d67>
  278a7e:	mov    0x3b01bb(%rip),%rax        # 628c40 <_DYNAMIC+0x360>
  278a85:	jmp    278a8e <<glass::engine::Watch>::print_utf8+0x1d6e>
  278a87:	mov    0x3b01aa(%rip),%rax        # 628c38 <_DYNAMIC+0x358>
  278a8e:	lock incq 0x28(%rax)
  278a93:	mov    %rcx,%rdi
  278a96:	sub    0x10(%rsp),%rdi
  278a9b:	call   310fb0 <alacritty_terminal::grid::row::fill_census::note>
  278aa0:	mov    0x8(%rsp),%rcx
  278aa5:	mov    0x18(%rsp),%r8
  278aaa:	cmp    %rcx,%rbx
  278aad:	jae    278c81 <<glass::engine::Watch>::print_utf8+0x1f61>
  278ab3:	mov    (%rsp),%rcx
  278ab7:	mov    0x28(%rcx),%edi
  278aba:	mov    0x20(%rcx),%r9d
  278abe:	mov    0x24(%rcx),%r10d
  278ac2:	movzwl 0x2c(%rcx),%r11d
  278ac7:	mov    0x18(%rcx),%r14
  278acb:	test   %r14,%r14
  278ace:	mov    %edi,0x20(%rsp)
  278ad2:	mov    %r9d,0x78(%rsp)
  278ad7:	mov    %r10d,0x70(%rsp)
  278adc:	mov    %r11w,0x30(%rsp)
  278ae2:	mov    %r13,0x60(%rsp)
  278ae7:	je     278ba8 <<glass::engine::Watch>::print_utf8+0x1e88>
  278aed:	lock incq (%r14)
  278af1:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  278af7:	mov    0x10(%rcx),%rdx
  278afb:	mov    %edi,0x50(%rsp)
  278aff:	mov    %r9d,0x48(%rsp)
  278b04:	mov    %r10d,0x4c(%rsp)
  278b09:	mov    %r11w,0x54(%rsp)
  278b0f:	mov    %r14,0x40(%rsp)
  278b14:	mov    0x8(%rsp),%rsi
  278b19:	cmp    %rdx,%rsi
  278b1c:	ja     278e2d <<glass::engine::Watch>::print_utf8+0x210d>
  278b22:	mov    0x10(%rsp),%rax
  278b27:	lea    0x0(,%rax,8),%rax
  278b2f:	lea    (%rax,%rax,2),%rax
  278b33:	mov    0x8(%rcx),%rbx
  278b37:	add    %rax,%rbx
  278b3a:	lea    0x0(,%rsi,8),%rcx
  278b42:	lea    (%rcx,%rcx,2),%r13
  278b46:	sub    %rax,%r13
  278b49:	jmp    278b6c <<glass::engine::Watch>::print_utf8+0x1e4c>
  278b4b:	mov    %r14,(%rbx)
  278b4e:	mov    %r9d,0x8(%rbx)
  278b52:	mov    %r10d,0xc(%rbx)
  278b56:	mov    %edi,0x10(%rbx)
  278b59:	mov    %r11w,0x14(%rbx)
  278b5e:	add    $0x18,%rbx
  278b62:	add    $0xffffffffffffffe8,%r13
  278b66:	je     278c42 <<glass::engine::Watch>::print_utf8+0x1f22>
  278b6c:	lock incq (%r14)
  278b70:	jle    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  278b76:	mov    (%rbx),%rax
  278b79:	test   %rax,%rax
  278b7c:	je     278b4b <<glass::engine::Watch>::print_utf8+0x1e2b>
  278b7e:	lock decq (%rax)
  278b82:	jne    278b4b <<glass::engine::Watch>::print_utf8+0x1e2b>
  278b84:	mov    %rbx,%rdi
  278b87:	call   *0x3affbb(%rip)        # 628b48 <_DYNAMIC+0x268>
  278b8d:	movzwl 0x30(%rsp),%r11d
  278b93:	mov    0x70(%rsp),%r10d
  278b98:	mov    0x78(%rsp),%r9d
  278b9d:	mov    0x20(%rsp),%edi
  278ba1:	mov    0x18(%rsp),%r8
  278ba6:	jmp    278b4b <<glass::engine::Watch>::print_utf8+0x1e2b>
  278ba8:	mov    %edi,0x50(%rsp)
  278bac:	mov    %r9d,0x48(%rsp)
  278bb1:	mov    %r10d,0x4c(%rsp)
  278bb6:	mov    %r11w,0x54(%rsp)
  278bbc:	mov    %r14,0x40(%rsp)
  278bc1:	mov    0x10(%rsp),%rax
  278bc6:	lea    0x0(,%rax,8),%rax
  278bce:	lea    (%rax,%rax,2),%rax
  278bd2:	mov    0x8(%rcx),%rbx
  278bd6:	add    %rax,%rbx
  278bd9:	mov    0x8(%rsp),%rcx
  278bde:	lea    0x0(,%rcx,8),%rcx
  278be6:	lea    (%rcx,%rcx,2),%r13
  278bea:	sub    %rax,%r13
  278bed:	jmp    278c10 <<glass::engine::Watch>::print_utf8+0x1ef0>
  278bef:	movq   $0x0,(%rbx)
  278bf6:	mov    %r9d,0x8(%rbx)
  278bfa:	mov    %r10d,0xc(%rbx)
  278bfe:	mov    %edi,0x10(%rbx)
  278c01:	mov    %r11w,0x14(%rbx)
  278c06:	add    $0x18,%rbx
  278c0a:	add    $0xffffffffffffffe8,%r13
  278c0e:	je     278c42 <<glass::engine::Watch>::print_utf8+0x1f22>
  278c10:	mov    (%rbx),%rax
  278c13:	test   %rax,%rax
  278c16:	je     278bef <<glass::engine::Watch>::print_utf8+0x1ecf>
  278c18:	lock decq (%rax)
  278c1c:	jne    278bef <<glass::engine::Watch>::print_utf8+0x1ecf>
  278c1e:	mov    %rbx,%rdi
  278c21:	call   *0x3aff21(%rip)        # 628b48 <_DYNAMIC+0x268>
  278c27:	movzwl 0x30(%rsp),%r11d
  278c2d:	mov    0x70(%rsp),%r10d
  278c32:	mov    0x78(%rsp),%r9d
  278c37:	mov    0x20(%rsp),%edi
  278c3b:	mov    0x18(%rsp),%r8
  278c40:	jmp    278bef <<glass::engine::Watch>::print_utf8+0x1ecf>
  278c42:	mov    (%rsp),%rbx
  278c46:	mov    0x10(%rsp),%rax
  278c4b:	cmp    %eax,0x38(%rbx)
  278c4e:	jbe    278c53 <<glass::engine::Watch>::print_utf8+0x1f33>
  278c50:	mov    %eax,0x38(%rbx)
  278c53:	test   %r14,%r14
  278c56:	mov    0x60(%rsp),%r13
  278c5b:	mov    0x8(%rsp),%rcx
  278c60:	je     278c7d <<glass::engine::Watch>::print_utf8+0x1f5d>
  278c62:	lock decq (%r14)
  278c66:	jne    278c7d <<glass::engine::Watch>::print_utf8+0x1f5d>
  278c68:	lea    0x40(%rsp),%rdi
  278c6d:	call   *0x3afed5(%rip)        # 628b48 <_DYNAMIC+0x268>
  278c73:	mov    0x8(%rsp),%rcx
  278c78:	mov    0x18(%rsp),%r8
  278c7d:	mov    0x10(%rbx),%r14
  278c81:	cmp    %r14,%rcx
  278c84:	mov    0x38(%rsp),%r14
  278c89:	jb     278ca5 <<glass::engine::Watch>::print_utf8+0x1f85>
  278c8b:	mov    0x68(%rsp),%rdi
  278c90:	call   1b72c0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  278c95:	mov    0x18(%rsp),%r8
  278c9a:	mov    (%rsp),%rax
  278c9e:	movl   $0xffffffff,0x28(%rax)
  278ca5:	mov    (%rsp),%rcx
  278ca9:	mov    0x30(%rcx),%rax
  278cad:	add    $0x2,%r8
  278cb1:	cmp    %rax,%r8
  278cb4:	cmovbe %rax,%r8
  278cb8:	mov    0x10(%rcx),%rsi
  278cbc:	mov    %r8,0x30(%rcx)
  278cc0:	cmp    %rsi,%r13
  278cc3:	jae    278eb0 <<glass::engine::Watch>::print_utf8+0x2190>
  278cc9:	mov    0x8(%rcx),%rax
  278ccd:	lea    0x0(,%r13,2),%rcx
  278cd5:	add    %r13,%rcx
  278cd8:	lea    (%rax,%rcx,8),%rbx
  278cdc:	movl   $0x20,0x10(%rax,%rcx,8)
  278ce4:	mov    0xb0(%rsp),%edx
  278ceb:	mov    %edx,0x8(%rax,%rcx,8)
  278cef:	mov    0x80(%rsp),%edx
  278cf6:	mov    %edx,0xc(%rax,%rcx,8)
  278cfa:	mov    0x28(%rsp),%edx
  278cfe:	or     $0x40,%edx
  278d01:	mov    %dx,0x14(%rax,%rcx,8)
  278d06:	mov    (%rax,%rcx,8),%rax
  278d0a:	test   %rax,%rax
  278d0d:	je     278d1e <<glass::engine::Watch>::print_utf8+0x1ffe>
  278d0f:	lock decq (%rax)
  278d13:	jne    278d1e <<glass::engine::Watch>::print_utf8+0x1ffe>
  278d15:	mov    %rbx,%rdi
  278d18:	call   *0x3afe2a(%rip)        # 628b48 <_DYNAMIC+0x268>
  278d1e:	movq   $0x0,(%rbx)
  278d25:	cmp    0x90(%rsp),%r14
  278d2d:	jb     278d37 <<glass::engine::Watch>::print_utf8+0x2017>
  278d2f:	dec    %r14
  278d32:	movb   $0x1,0x6c(%r15)
  278d37:	mov    %r12,%r8
  278d3a:	mov    %r14,0x40(%r15)
  278d3e:	mov    0x88(%rsp),%rax
  278d46:	incq   0xa0(%rax)
  278d4d:	mov    %ebp,0xb0(%rax)
  278d53:	jmp    278605 <<glass::engine::Watch>::print_utf8+0x18e5>
  278d58:	call   1930a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  278d5d:	mov    %ebp,%r14d
  278d60:	mov    0x3b2dc9(%rip),%rsi        # 62bb30 <glass::engine::width_of::CACHE+0x8>
  278d67:	cmp    %r14,%rsi
  278d6a:	ja     2784a3 <<glass::engine::Watch>::print_utf8+0x1783>
  278d70:	lea    0x389081(%rip),%rdx        # 601df8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18cf0>
  278d77:	mov    %r14,%rdi
  278d7a:	call   *0x3afd78(%rip)        # 628af8 <_DYNAMIC+0x218>
  278d80:	lea    0x385ff9(%rip),%rcx        # 5fed80 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  278d87:	mov    0xa8(%rsp),%rdi
  278d8f:	mov    %r15,%rsi
  278d92:	mov    %rbx,%rdx
  278d95:	call   *0x3aff1d(%rip)        # 628cb8 <_DYNAMIC+0x3d8>
  278d9b:	jmp    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  278da0:	lea    0x385fd9(%rip),%rcx        # 5fed80 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  278da7:	call   *0x3aff0b(%rip)        # 628cb8 <_DYNAMIC+0x3d8>
  278dad:	jmp    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  278db2:	lea    0x3864bf(%rip),%rdx        # 5ff278 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16170>
  278db9:	call   *0x3afd39(%rip)        # 628af8 <_DYNAMIC+0x218>
  278dbf:	lea    0x389032(%rip),%rdx        # 601df8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x18cf0>
  278dc6:	mov    %rbx,%rdi
  278dc9:	call   *0x3afd29(%rip)        # 628af8 <_DYNAMIC+0x218>
  278dcf:	lea    0x386502(%rip),%rax        # 5ff2d8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161d0>
  278dd6:	jmp    278de2 <<glass::engine::Watch>::print_utf8+0x20c2>
  278dd8:	mov    %rax,%rdi
  278ddb:	lea    0x3864c6(%rip),%rax        # 5ff2a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x161a0>
  278de2:	mov    %rax,0xc8(%rsp)
  278dea:	mov    %r14,%rsi
  278ded:	mov    0xc8(%rsp),%rdx
  278df5:	call   *0x3afcfd(%rip)        # 628af8 <_DYNAMIC+0x218>
  278dfb:	lea    0x385f7e(%rip),%rcx        # 5fed80 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  278e02:	mov    0x38(%rsp),%rdi
  278e07:	call   *0x3afeab(%rip)        # 628cb8 <_DYNAMIC+0x3d8>
  278e0d:	jmp    278e3f <<glass::engine::Watch>::print_utf8+0x211f>
  278e0f:	lea    0x3865e2(%rip),%rdx        # 5ff3f8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x162f0>
  278e16:	call   *0x3afcdc(%rip)        # 628af8 <_DYNAMIC+0x218>
  278e1c:	lea    0x373a25(%rip),%rdx        # 5ec848 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  278e23:	mov    (%rsp),%rdi
  278e27:	call   *0x3afccb(%rip)        # 628af8 <_DYNAMIC+0x218>
  278e2d:	lea    0x385f4c(%rip),%rcx        # 5fed80 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15c78>
  278e34:	mov    0x10(%rsp),%rdi
  278e39:	call   *0x3afe79(%rip)        # 628cb8 <_DYNAMIC+0x3d8>
  278e3f:	ud2
  278e41:	lea    0x373a00(%rip),%rdx        # 5ec848 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  278e48:	call   *0x3afcaa(%rip)        # 628af8 <_DYNAMIC+0x218>
  278e4e:	lea    0x386b2b(%rip),%rdx        # 5ff980 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  278e55:	mov    (%rsp),%rdi
  278e59:	call   *0x3afc99(%rip)        # 628af8 <_DYNAMIC+0x218>
  278e5f:	lea    0x386b02(%rip),%rdx        # 5ff968 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16860>
  278e66:	mov    (%rsp),%rdi
  278e6a:	call   *0x3afc88(%rip)        # 628af8 <_DYNAMIC+0x218>
  278e70:	lea    0x386b09(%rip),%rdx        # 5ff980 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16878>
  278e77:	mov    %r15,%rdi
  278e7a:	call   *0x3afc78(%rip)        # 628af8 <_DYNAMIC+0x218>
  278e80:	lea    0x386ae1(%rip),%rdx        # 5ff968 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16860>
  278e87:	mov    %r15,%rdi
  278e8a:	call   *0x3afc68(%rip)        # 628af8 <_DYNAMIC+0x218>
  278e90:	lea    0x3739b1(%rip),%rdx        # 5ec848 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x3740>
  278e97:	mov    %r8,%rdi
  278e9a:	call   *0x3afc58(%rip)        # 628af8 <_DYNAMIC+0x218>
  278ea0:	lea    0x386ac1(%rip),%rdx        # 5ff968 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16860>
  278ea7:	mov    %r8,%rdi
  278eaa:	call   *0x3afc48(%rip)        # 628af8 <_DYNAMIC+0x218>
  278eb0:	lea    0x386ab1(%rip),%rdx        # 5ff968 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x16860>
  278eb7:	mov    %r13,%rdi
  278eba:	call   *0x3afc38(%rip)        # 628af8 <_DYNAMIC+0x218>
  278ec0:	mov    %rax,%rbx
  278ec3:	lock decq (%r14)
  278ec7:	je     278ef0 <<glass::engine::Watch>::print_utf8+0x21d0>
  278ec9:	jmp    278efe <<glass::engine::Watch>::print_utf8+0x21de>
  278ecb:	mov    %rax,%rbx
  278ece:	mov    0x20(%rsp),%rax
  278ed3:	jmp    278eea <<glass::engine::Watch>::print_utf8+0x21ca>
  278ed5:	mov    %rax,%rbx
  278ed8:	mov    0xa0(%rsp),%rax
  278ee0:	jmp    278eea <<glass::engine::Watch>::print_utf8+0x21ca>
  278ee2:	mov    %rax,%rbx
  278ee5:	mov    0x10(%rsp),%rax
  278eea:	lock decq (%rax)
  278eee:	jne    278efe <<glass::engine::Watch>::print_utf8+0x21de>
  278ef0:	mov    0xf8(%rsp),%rdi
  278ef8:	call   *0x3afc4a(%rip)        # 628b48 <_DYNAMIC+0x268>
  278efe:	mov    %rbx,%rdi
  278f01:	call   5e59b0 <_Unwind_Resume@plt>
