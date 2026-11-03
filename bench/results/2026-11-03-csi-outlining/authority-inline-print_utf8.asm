
/tmp/glass-i26-authority-inline-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000261dc0 <<glass::engine::Watch>::print_utf8>:
  261dc0:	push   %rbp
  261dc1:	push   %r15
  261dc3:	push   %r14
  261dc5:	push   %r13
  261dc7:	push   %r12
  261dc9:	push   %rbx
  261dca:	sub    $0x118,%rsp
  261dd1:	mov    %rdx,%r13
  261dd4:	mov    %rdi,%r15
  261dd7:	cmpb   $0x1,0xbe(%rdi)
  261dde:	jne    261e0b <<glass::engine::Watch>::print_utf8+0x4b>
  261de0:	cmpq   $0x0,0x38(%r15)
  261de5:	jne    261e0b <<glass::engine::Watch>::print_utf8+0x4b>
  261de7:	mov    0x78(%r15),%rax
  261deb:	testb  $0x4,0x6c5(%rax)
  261df2:	jne    261e0b <<glass::engine::Watch>::print_utf8+0x4b>
  261df4:	cmpq   $0x0,0x50(%rax)
  261df9:	jne    261e0b <<glass::engine::Watch>::print_utf8+0x4b>
  261dfb:	movzwl 0x64(%rax),%ecx
  261dff:	test   $0x460,%ecx
  261e05:	je     263530 <<glass::engine::Watch>::print_utf8+0x1770>
  261e0b:	movl   $0x0,0x10(%rsp)
  261e13:	movl   $0x0,0x80(%rsp)
  261e1e:	mov    $0xffffffff,%r8d
  261e24:	xor    %r14d,%r14d
  261e27:	lea    0x3662e2(%rip),%rax        # 5c8110 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15450>
  261e2e:	mov    %rax,0xf0(%rsp)
  261e36:	lea    0x40(%rsp),%rax
  261e3b:	mov    %rax,0x110(%rsp)
  261e43:	xor    %edx,%edx
  261e45:	mov    %r13,0xc0(%rsp)
  261e4d:	mov    %r15,0xc8(%rsp)
  261e55:	mov    %rsi,0x18(%rsp)
  261e5a:	cmpb   $0x0,0x80(%rsp)
  261e62:	je     262959 <<glass::engine::Watch>::print_utf8+0xb99>
  261e68:	nopl   0x0(%rax,%rax,1)
  261e70:	mov    0x78(%r15),%rbx
  261e74:	cmpb   $0x0,0x6c(%rbx)
  261e78:	jne    262959 <<glass::engine::Watch>::print_utf8+0xb99>
  261e7e:	mov    0x30(%rbx),%eax
  261e81:	sub    0x48(%rbx),%eax
  261e84:	cltq
  261e86:	mov    0x20(%rbx),%rsi
  261e8a:	mov    0x28(%rbx),%rcx
  261e8e:	lea    (%rcx,%rax,1),%rdi
  261e92:	dec    %rdi
  261e95:	cmp    %rsi,%rdi
  261e98:	mov    $0x0,%eax
  261e9d:	cmovae %rsi,%rax
  261ea1:	sub    %rax,%rdi
  261ea4:	cmp    %rsi,%rdi
  261ea7:	jae    263dd4 <<glass::engine::Watch>::print_utf8+0x2014>
  261ead:	mov    0xa0(%rbx),%rax
  261eb4:	mov    %rax,0x38(%rsp)
  261eb9:	mov    0x40(%rbx),%r12
  261ebd:	mov    0x58(%rbx),%eax
  261ec0:	mov    %eax,0x78(%rsp)
  261ec4:	mov    0x5c(%rbx),%eax
  261ec7:	mov    %eax,0xa0(%rsp)
  261ece:	movzwl 0x64(%rbx),%eax
  261ed2:	mov    %eax,0xc(%rsp)
  261ed6:	mov    0x18(%rbx),%rax
  261eda:	shl    $0x6,%rdi
  261ede:	lea    (%rax,%rdi,1),%rbp
  261ee2:	cmp    %r12d,0x38(%rax,%rdi,1)
  261ee7:	jbe    261eed <<glass::engine::Watch>::print_utf8+0x12d>
  261ee9:	mov    %r12d,0x38(%rbp)
  261eed:	mov    %rdx,0x28(%rsp)
  261ef2:	mov    0x28(%rbp),%r10d
  261ef6:	cmp    $0xffffffff,%r10d
  261efa:	mov    %r12,0x60(%rsp)
  261eff:	je     261fb9 <<glass::engine::Watch>::print_utf8+0x1f9>
  261f05:	mov    0x30(%rbp),%rax
  261f09:	cmp    %rax,%r12
  261f0c:	mov    $0x0,%ecx
  261f11:	cmovb  %rax,%rcx
  261f15:	mov    %rcx,0x20(%rsp)
  261f1a:	movl   $0x20,0x108(%rsp)
  261f25:	mov    0x78(%rsp),%ecx
  261f29:	mov    %ecx,0x100(%rsp)
  261f30:	mov    0xa0(%rsp),%ecx
  261f37:	mov    %ecx,0x104(%rsp)
  261f3e:	mov    0xc(%rsp),%ecx
  261f42:	mov    %cx,0x10c(%rsp)
  261f4a:	movq   $0x0,0xf8(%rsp)
  261f56:	mov    0x10(%rbp),%rcx
  261f5a:	cmp    %rax,%rcx
  261f5d:	mov    %rax,%rdx
  261f60:	cmovb  %rcx,%rdx
  261f64:	mov    %rdx,0x68(%rsp)
  261f69:	cmp    %r12,%rcx
  261f6c:	mov    %r12,%r9
  261f6f:	cmovb  %rcx,%r9
  261f73:	mov    0x38ef86(%rip),%rdx        # 5f0f00 <_DYNAMIC+0x320>
  261f7a:	movzbl (%rdx),%edx
  261f7d:	test   %dl,%dl
  261f7f:	je     26205a <<glass::engine::Watch>::print_utf8+0x29a>
  261f85:	mov    0x38efac(%rip),%rdx        # 5f0f38 <_DYNAMIC+0x358>
  261f8c:	cmp    %r9,%rax
  261f8f:	jae    261f98 <<glass::engine::Watch>::print_utf8+0x1d8>
  261f91:	mov    0x38efa8(%rip),%rdx        # 5f0f40 <_DYNAMIC+0x360>
  261f98:	lock incq 0x28(%rdx)
  261f9d:	mov    0x38ef74(%rip),%rdx        # 5f0f18 <_DYNAMIC+0x338>
  261fa4:	lock incq (%rdx)
  261fa8:	mov    %r9,%rdx
  261fab:	sub    0x68(%rsp),%rdx
  261fb0:	jne    26200f <<glass::engine::Watch>::print_utf8+0x24f>
  261fb2:	xor    %esi,%esi
  261fb4:	jmp    26204e <<glass::engine::Watch>::print_utf8+0x28e>
  261fb9:	movl   $0x20,0x108(%rsp)
  261fc4:	mov    0x78(%rsp),%eax
  261fc8:	mov    %eax,0x100(%rsp)
  261fcf:	mov    0xa0(%rsp),%eax
  261fd6:	mov    %eax,0x104(%rsp)
  261fdd:	mov    0xc(%rsp),%eax
  261fe1:	mov    %ax,0x10c(%rsp)
  261fe9:	movq   $0x0,0xf8(%rsp)
  261ff5:	lea    0x30(%rbp),%rax
  261ff9:	mov    %rax,0xd8(%rsp)
  262001:	movq   $0xffffffffffffffff,0x20(%rsp)
  26200a:	jmp    2621ea <<glass::engine::Watch>::print_utf8+0x42a>
  26200f:	mov    0x38ef0a(%rip),%rsi        # 5f0f20 <_DYNAMIC+0x340>
  262016:	lock add %rdx,(%rsi)
  26201a:	cmp    $0x5,%rdx
  26201e:	jae    26202e <<glass::engine::Watch>::print_utf8+0x26e>
  262020:	lea    -0x20458f(%rip),%rsi        # 5da98 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  262027:	movzbl -0x1(%rdx,%rsi,1),%esi
  26202c:	jmp    26204e <<glass::engine::Watch>::print_utf8+0x28e>
  26202e:	lea    -0x5(%rdx),%rdi
  262032:	mov    $0x4,%esi
  262037:	cmp    $0x4,%rdi
  26203b:	jb     26204e <<glass::engine::Watch>::print_utf8+0x28e>
  26203d:	add    $0xfffffffffffffff7,%rdx
  262041:	cmp    $0x8,%rdx
  262045:	mov    $0x6,%esi
  26204a:	sbb    $0x0,%rsi
  26204e:	mov    0x38eebb(%rip),%rdx        # 5f0f10 <_DYNAMIC+0x330>
  262055:	lock incq (%rdx,%rsi,8)
  26205a:	cmp    %r9,%rax
  26205d:	mov    %r8,0x58(%rsp)
  262062:	jae    2621af <<glass::engine::Watch>::print_utf8+0x3ef>
  262068:	mov    %rbx,0x98(%rsp)
  262070:	mov    %r14,0x30(%rsp)
  262075:	mov    0x20(%rbp),%r13d
  262079:	mov    0x24(%rbp),%esi
  26207c:	movzwl 0x2c(%rbp),%edi
  262080:	mov    0x18(%rbp),%r12
  262084:	test   %r12,%r12
  262087:	je     262094 <<glass::engine::Watch>::print_utf8+0x2d4>
  262089:	lock incq (%r12)
  26208e:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  262094:	mov    %r10d,0x50(%rsp)
  262099:	mov    %r13d,0x48(%rsp)
  26209e:	mov    %esi,0x4c(%rsp)
  2620a2:	mov    %di,0x54(%rsp)
  2620a7:	mov    %r12,0x40(%rsp)
  2620ac:	mov    0x68(%rsp),%rax
  2620b1:	lea    0x0(,%rax,8),%rax
  2620b9:	lea    (%rax,%rax,2),%rax
  2620bd:	mov    %rbp,0xd0(%rsp)
  2620c5:	mov    0x8(%rbp),%rbx
  2620c9:	add    %rax,%rbx
  2620cc:	lea    0x0(,%r9,8),%rcx
  2620d4:	lea    (%rcx,%rcx,2),%rbp
  2620d8:	sub    %rax,%rbp
  2620db:	mov    %esi,0x70(%rsp)
  2620df:	mov    %di,0x90(%rsp)
  2620e7:	jmp    26210c <<glass::engine::Watch>::print_utf8+0x34c>
  2620e9:	nopl   0x0(%rax)
  2620f0:	mov    %r12,(%rbx)
  2620f3:	mov    %r13d,0x8(%rbx)
  2620f7:	mov    %esi,0xc(%rbx)
  2620fa:	mov    %r10d,0x10(%rbx)
  2620fe:	mov    %di,0x14(%rbx)
  262102:	add    $0x18,%rbx
  262106:	add    $0xffffffffffffffe8,%rbp
  26210a:	je     262152 <<glass::engine::Watch>::print_utf8+0x392>
  26210c:	test   %r12,%r12
  26210f:	je     26211c <<glass::engine::Watch>::print_utf8+0x35c>
  262111:	lock incq (%r12)
  262116:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  26211c:	mov    (%rbx),%rax
  26211f:	test   %rax,%rax
  262122:	je     2620f0 <<glass::engine::Watch>::print_utf8+0x330>
  262124:	lock decq (%rax)
  262128:	jne    2620f0 <<glass::engine::Watch>::print_utf8+0x330>
  26212a:	mov    %rbx,%rdi
  26212d:	mov    %r9,%r14
  262130:	mov    %r10d,%r15d
  262133:	call   *0x38ed0f(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  262139:	movzwl 0x90(%rsp),%edi
  262141:	mov    0x70(%rsp),%esi
  262145:	mov    %r15d,%r10d
  262148:	mov    %r14,%r9
  26214b:	mov    0x58(%rsp),%r8
  262150:	jmp    2620f0 <<glass::engine::Watch>::print_utf8+0x330>
  262152:	mov    0xd0(%rsp),%rbp
  26215a:	mov    0x68(%rsp),%rax
  26215f:	cmp    %eax,0x38(%rbp)
  262162:	jbe    262167 <<glass::engine::Watch>::print_utf8+0x3a7>
  262164:	mov    %eax,0x38(%rbp)
  262167:	test   %r12,%r12
  26216a:	mov    0xc0(%rsp),%r13
  262172:	mov    0xc8(%rsp),%r15
  26217a:	mov    0x30(%rsp),%r14
  26217f:	mov    0x98(%rsp),%rbx
  262187:	je     2621a6 <<glass::engine::Watch>::print_utf8+0x3e6>
  262189:	lock decq (%r12)
  26218e:	jne    2621a6 <<glass::engine::Watch>::print_utf8+0x3e6>
  262190:	lea    0x40(%rsp),%rdi
  262195:	mov    %r9,%r12
  262198:	call   *0x38ecaa(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  26219e:	mov    %r12,%r9
  2621a1:	mov    0x58(%rsp),%r8
  2621a6:	mov    0x10(%rbp),%rcx
  2621aa:	mov    0x60(%rsp),%r12
  2621af:	lea    0x30(%rbp),%rax
  2621b3:	mov    %rax,0xd8(%rsp)
  2621bb:	cmp    %rcx,%r9
  2621be:	jb     2621ea <<glass::engine::Watch>::print_utf8+0x42a>
  2621c0:	cmpl   $0xffffffff,0x28(%rbp)
  2621c4:	je     2621e3 <<glass::engine::Watch>::print_utf8+0x423>
  2621c6:	lea    0x18(%rbp),%rdi
  2621ca:	mov    (%rdi),%rax
  2621cd:	test   %rax,%rax
  2621d0:	je     2621e3 <<glass::engine::Watch>::print_utf8+0x423>
  2621d2:	lock decq (%rax)
  2621d6:	jne    2621e3 <<glass::engine::Watch>::print_utf8+0x423>
  2621d8:	call   *0x38ec6a(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  2621de:	mov    0x58(%rsp),%r8
  2621e3:	movl   $0xffffffff,0x28(%rbp)
  2621ea:	mov    0x10(%rbp),%rdx
  2621ee:	mov    0x30(%rbp),%rax
  2621f2:	cmp    %r12,%rdx
  2621f5:	mov    %r12,%rsi
  2621f8:	cmovb  %rdx,%rsi
  2621fc:	cmp    %rax,%rsi
  2621ff:	cmova  %rsi,%rax
  262203:	mov    %rdx,%rcx
  262206:	mov    %rax,0x30(%rbp)
  26220a:	sub    %r12,%rcx
  26220d:	mov    %rcx,0x30(%rsp)
  262212:	jb     26375e <<glass::engine::Watch>::print_utf8+0x199e>
  262218:	mov    0x28(%rsp),%rdx
  26221d:	cmp    %r13,%rdx
  262220:	jae    262820 <<glass::engine::Watch>::print_utf8+0xa60>
  262226:	mov    %rbx,0x98(%rsp)
  26222e:	mov    %rbp,0xd0(%rsp)
  262236:	mov    0x8(%rbp),%rcx
  26223a:	lea    (%r12,%r12,2),%rax
  26223e:	mov    %rcx,0x70(%rsp)
  262243:	lea    (%rcx,%rax,8),%rax
  262247:	mov    %rax,0xb8(%rsp)
  26224f:	mov    0xc(%rsp),%eax
  262253:	mov    %eax,%ecx
  262255:	or     $0x20,%ecx
  262258:	mov    %ecx,0x8c(%rsp)
  26225f:	or     $0x40,%eax
  262262:	mov    %eax,0xa8(%rsp)
  262269:	mov    $0x1,%al
  26226b:	mov    %eax,0x90(%rsp)
  262272:	xor    %r11d,%r11d
  262275:	xor    %edi,%edi
  262277:	mov    %r12,%rbx
  26227a:	mov    %r12,%r10
  26227d:	mov    0x18(%rsp),%rsi
  262282:	jmp    2622ef <<glass::engine::Watch>::print_utf8+0x52f>
  262284:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  262290:	movq   $0x0,(%rbx)
  262297:	mov    0x78(%rsp),%eax
  26229b:	mov    %eax,0x8(%rbx)
  26229e:	mov    0xa0(%rsp),%eax
  2622a5:	mov    %eax,0xc(%rbx)
  2622a8:	movl   $0x20,0x10(%rbx)
  2622af:	mov    0xa8(%rsp),%eax
  2622b6:	mov    %ax,0x14(%rbx)
  2622ba:	movl   $0x0,0x90(%rsp)
  2622c5:	xor    %r11d,%r11d
  2622c8:	cmp    0x38(%rsp),%r9
  2622cd:	setae  %r11b
  2622d1:	mov    %r9,%r10
  2622d4:	sub    %r11,%r10
  2622d7:	inc    %rdi
  2622da:	mov    %r9,%rbx
  2622dd:	add    %r15,%rdx
  2622e0:	mov    %ebp,%r8d
  2622e3:	mov    %r15,%r14
  2622e6:	cmp    %r13,%rdx
  2622e9:	jae    26283d <<glass::engine::Watch>::print_utf8+0xa7d>
  2622ef:	mov    %rdx,%r15
  2622f2:	movzbl (%rsi,%rdx,1),%ebp
  2622f6:	test   %bpl,%bpl
  2622f9:	js     262320 <<glass::engine::Watch>::print_utf8+0x560>
  2622fb:	mov    $0x1,%edx
  262300:	lea    -0x7f(%rbp),%eax
  262303:	cmp    $0x21,%eax
  262306:	jae    262488 <<glass::engine::Watch>::print_utf8+0x6c8>
  26230c:	jmp    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262311:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262320:	lea    0x3e(%rbp),%eax
  262323:	cmp    $0x1e,%al
  262325:	jae    262350 <<glass::engine::Watch>::print_utf8+0x590>
  262327:	lea    0x1(%r15),%rax
  26232b:	cmp    %r13,%rax
  26232e:	jae    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262334:	movzbl (%rsi,%rax,1),%eax
  262338:	cmp    $0xc0,%al
  26233a:	jge    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262340:	and    $0x1f,%ebp
  262343:	shl    $0x6,%ebp
  262346:	mov    $0x2,%edx
  26234b:	jmp    26245b <<glass::engine::Watch>::print_utf8+0x69b>
  262350:	mov    %ebp,%eax
  262352:	and    $0xf0,%al
  262354:	cmp    $0xe0,%al
  262356:	jne    262370 <<glass::engine::Watch>::print_utf8+0x5b0>
  262358:	mov    $0xbf,%al
  26235a:	cmp    $0xe0,%ebp
  262360:	je     262393 <<glass::engine::Watch>::print_utf8+0x5d3>
  262362:	mov    $0x80,%cl
  262364:	cmp    $0xed,%ebp
  26236a:	jne    262395 <<glass::engine::Watch>::print_utf8+0x5d5>
  26236c:	mov    $0x9f,%al
  26236e:	jmp    262395 <<glass::engine::Watch>::print_utf8+0x5d5>
  262370:	lea    0x10(%rbp),%eax
  262373:	cmp    $0x5,%al
  262375:	jae    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  26237b:	mov    $0x80,%al
  26237d:	cmp    $0xf4,%ebp
  262383:	je     2623e7 <<glass::engine::Watch>::print_utf8+0x627>
  262385:	mov    $0xbf,%cl
  262387:	cmp    $0xf0,%ebp
  26238d:	jne    2623e9 <<glass::engine::Watch>::print_utf8+0x629>
  26238f:	mov    $0x90,%al
  262391:	jmp    2623e9 <<glass::engine::Watch>::print_utf8+0x629>
  262393:	mov    $0xa0,%cl
  262395:	lea    0x1(%r15),%rdx
  262399:	cmp    %r13,%rdx
  26239c:	jae    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  2623a2:	movzbl (%rsi,%rdx,1),%edx
  2623a6:	cmp    %dl,%cl
  2623a8:	ja     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  2623ae:	cmp    %al,%dl
  2623b0:	ja     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  2623b6:	lea    0x2(%r15),%rax
  2623ba:	cmp    %r13,%rax
  2623bd:	jae    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  2623c3:	movzbl (%rsi,%rax,1),%eax
  2623c7:	cmp    $0xc0,%al
  2623c9:	jge    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  2623cf:	movzbl %dl,%ecx
  2623d2:	and    $0x3f,%ecx
  2623d5:	shl    $0x6,%ecx
  2623d8:	and    $0xf,%ebp
  2623db:	shl    $0xc,%ebp
  2623de:	or     %ecx,%ebp
  2623e0:	mov    $0x3,%edx
  2623e5:	jmp    26245b <<glass::engine::Watch>::print_utf8+0x69b>
  2623e7:	mov    $0x8f,%cl
  2623e9:	lea    0x1(%r15),%rdx
  2623ed:	cmp    %r13,%rdx
  2623f0:	jae    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  2623f6:	movzbl (%rsi,%rdx,1),%edx
  2623fa:	cmp    %dl,%al
  2623fc:	ja     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262402:	cmp    %cl,%dl
  262404:	ja     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  26240a:	lea    0x2(%r15),%rax
  26240e:	cmp    %r13,%rax
  262411:	jae    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262417:	movzbl (%rsi,%rax,1),%ecx
  26241b:	cmp    $0xbf,%cl
  26241e:	jg     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262424:	lea    0x3(%r15),%rax
  262428:	cmp    %r13,%rax
  26242b:	jae    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262431:	movzbl (%rsi,%rax,1),%eax
  262435:	cmp    $0xbf,%al
  262437:	jg     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  26243d:	movzbl %dl,%edx
  262440:	and    $0x3f,%ecx
  262443:	shl    $0x6,%ecx
  262446:	and    $0x3f,%edx
  262449:	shl    $0xc,%edx
  26244c:	and    $0x7,%ebp
  26244f:	shl    $0x12,%ebp
  262452:	or     %edx,%ebp
  262454:	or     %ecx,%ebp
  262456:	mov    $0x4,%edx
  26245b:	mov    %ebp,%ecx
  26245d:	xor    $0xd800,%ecx
  262463:	add    $0xffef0000,%ecx
  262469:	cmp    $0xffef0800,%ecx
  26246f:	jb     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262475:	and    $0x3f,%al
  262477:	movzbl %al,%eax
  26247a:	or     %eax,%ebp
  26247c:	lea    -0x7f(%rbp),%eax
  26247f:	cmp    $0x21,%eax
  262482:	jb     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262488:	cmp    $0xffffffff,%r8d
  26248c:	je     2624b0 <<glass::engine::Watch>::print_utf8+0x6f0>
  26248e:	lea    -0x20(%r8),%eax
  262492:	cmp    $0x5f,%eax
  262495:	jae    2624c0 <<glass::engine::Watch>::print_utf8+0x700>
  262497:	mov    $0x1,%ecx
  26249c:	cmpb   $0x0,0x10(%rsp)
  2624a1:	jne    2625bb <<glass::engine::Watch>::print_utf8+0x7fb>
  2624a7:	jmp    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  2624ac:	nopl   0x0(%rax)
  2624b0:	mov    %rbx,%r9
  2624b3:	jmp    2622dd <<glass::engine::Watch>::print_utf8+0x51d>
  2624b8:	nopl   0x0(%rax,%rax,1)
  2624c0:	mov    %rbx,0x68(%rsp)
  2624c5:	mov    0x3918ed(%rip),%eax        # 5f3db8 <glass::engine::width_of::CACHE+0x10>
  2624cb:	test   %eax,%eax
  2624cd:	jne    2627ae <<glass::engine::Watch>::print_utf8+0x9ee>
  2624d3:	mov    %r8d,%ebx
  2624d6:	mov    0x3918d3(%rip),%rsi        # 5f3db0 <glass::engine::width_of::CACHE+0x8>
  2624dd:	cmp    %rbx,%rsi
  2624e0:	jbe    263d98 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2624e6:	mov    0x3918bb(%rip),%r12        # 5f3da8 <glass::engine::width_of::CACHE>
  2624ed:	movzbl (%r12,%rbx,1),%eax
  2624f2:	movzbl %al,%ecx
  2624f5:	test   %cl,%cl
  2624f7:	mov    %rdx,0x28(%rsp)
  2624fc:	js     262517 <<glass::engine::Watch>::print_utf8+0x757>
  2624fe:	mov    $0x1,%dl
  262500:	mov    0x18(%rsp),%rsi
  262505:	test   %dl,%dl
  262507:	mov    0x68(%rsp),%rbx
  26250c:	jne    2625a3 <<glass::engine::Watch>::print_utf8+0x7e3>
  262512:	jmp    26289d <<glass::engine::Watch>::print_utf8+0xadd>
  262517:	cmp    $0xfe,%ecx
  26251d:	mov    0x18(%rsp),%rsi
  262522:	je     2628bd <<glass::engine::Watch>::print_utf8+0xafd>
  262528:	mov    $0xfe,%al
  26252a:	cmp    $0x7f,%r8d
  26252e:	jae    262539 <<glass::engine::Watch>::print_utf8+0x779>
  262530:	mov    $0x1,%ecx
  262535:	xor    %edx,%edx
  262537:	jmp    262592 <<glass::engine::Watch>::print_utf8+0x7d2>
  262539:	cmp    $0xa0,%r8d
  262540:	jb     262590 <<glass::engine::Watch>::print_utf8+0x7d0>
  262542:	mov    %rdi,0xb0(%rsp)
  26254a:	mov    %r8d,%edi
  26254d:	mov    %r8,0x58(%rsp)
  262552:	mov    %r10,0xe8(%rsp)
  26255a:	mov    %r11,0xe0(%rsp)
  262562:	call   297ea0 <unicode_width::tables::lookup_width>
  262567:	mov    0xe0(%rsp),%r11
  26256f:	mov    0xe8(%rsp),%r10
  262577:	mov    0xb0(%rsp),%rdi
  26257f:	mov    0x58(%rsp),%r8
  262584:	mov    0x18(%rsp),%rsi
  262589:	movzbl %al,%ecx
  26258c:	mov    $0x1,%dl
  26258e:	jmp    262592 <<glass::engine::Watch>::print_utf8+0x7d2>
  262590:	xor    %edx,%edx
  262592:	mov    %al,(%r12,%rbx,1)
  262596:	test   %dl,%dl
  262598:	mov    0x68(%rsp),%rbx
  26259d:	je     26289d <<glass::engine::Watch>::print_utf8+0xadd>
  2625a3:	lea    -0x1(%rcx),%rax
  2625a7:	cmp    $0x1,%rax
  2625ab:	mov    0x28(%rsp),%rdx
  2625b0:	mov    0x60(%rsp),%r12
  2625b5:	ja     262834 <<glass::engine::Watch>::print_utf8+0xa74>
  2625bb:	test   $0x1,%r11b
  2625bf:	jne    26282c <<glass::engine::Watch>::print_utf8+0xa6c>
  2625c5:	lea    (%rcx,%r10,1),%rax
  2625c9:	cmp    0x38(%rsp),%rax
  2625ce:	ja     262831 <<glass::engine::Watch>::print_utf8+0xa71>
  2625d4:	mov    %rax,0x58(%rsp)
  2625d9:	mov    %rbx,%r9
  2625dc:	mov    %r10,%rbx
  2625df:	sub    %r12,%rbx
  2625e2:	cmp    0x20(%rsp),%r10
  2625e7:	jae    262650 <<glass::engine::Watch>::print_utf8+0x890>
  2625e9:	cmp    0x30(%rsp),%rbx
  2625ee:	mov    0x70(%rsp),%r11
  2625f3:	jae    263de1 <<glass::engine::Watch>::print_utf8+0x2021>
  2625f9:	lea    (%r10,%r10,2),%rax
  2625fd:	testb  $0x60,0x14(%r11,%rax,8)
  262603:	jne    262898 <<glass::engine::Watch>::print_utf8+0xad8>
  262609:	lea    (%r11,%rax,8),%r12
  26260d:	cmp    $0x2,%rcx
  262611:	jne    2626e2 <<glass::engine::Watch>::print_utf8+0x922>
  262617:	lea    0x1(%rbx),%rax
  26261b:	cmp    0x30(%rsp),%rax
  262620:	jae    263dff <<glass::engine::Watch>::print_utf8+0x203f>
  262626:	mov    %r14,%rcx
  262629:	lea    (%rax,%rax,2),%rax
  26262d:	mov    $0x1,%r14b
  262630:	mov    0xb8(%rsp),%r13
  262638:	testb  $0x60,0x14(%r13,%rax,8)
  26263e:	mov    0x8c(%rsp),%r13d
  262646:	je     26267e <<glass::engine::Watch>::print_utf8+0x8be>
  262648:	jmp    2628a2 <<glass::engine::Watch>::print_utf8+0xae2>
  26264d:	nopl   (%rax)
  262650:	cmp    0x30(%rsp),%rbx
  262655:	mov    0x70(%rsp),%r11
  26265a:	jae    263e11 <<glass::engine::Watch>::print_utf8+0x2051>
  262660:	lea    (%r10,%r10,2),%rax
  262664:	lea    (%r11,%rax,8),%r12
  262668:	cmp    $0x2,%rcx
  26266c:	sete   %r14b
  262670:	mov    0xc(%rsp),%r13d
  262675:	cmove  0x8c(%rsp),%r13d
  26267e:	mov    (%r12),%rax
  262682:	test   %rax,%rax
  262685:	je     262700 <<glass::engine::Watch>::print_utf8+0x940>
  262687:	lock decq (%rax)
  26268b:	jne    262700 <<glass::engine::Watch>::print_utf8+0x940>
  26268d:	mov    %rdi,0xb0(%rsp)
  262695:	mov    %r12,%rdi
  262698:	mov    %r15,0xe0(%rsp)
  2626a0:	mov    %r8,%r15
  2626a3:	mov    %rdx,0x28(%rsp)
  2626a8:	mov    %r10,0xe8(%rsp)
  2626b0:	call   *0x38e792(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  2626b6:	mov    0x70(%rsp),%r11
  2626bb:	mov    0xe8(%rsp),%r10
  2626c3:	mov    0xb0(%rsp),%rdi
  2626cb:	mov    0x28(%rsp),%rdx
  2626d0:	mov    %r15,%r8
  2626d3:	mov    0xe0(%rsp),%r15
  2626db:	mov    0x18(%rsp),%rsi
  2626e0:	jmp    262700 <<glass::engine::Watch>::print_utf8+0x940>
  2626e2:	xor    %r14d,%r14d
  2626e5:	mov    0xc(%rsp),%r13d
  2626ea:	mov    (%r12),%rax
  2626ee:	test   %rax,%rax
  2626f1:	jne    262687 <<glass::engine::Watch>::print_utf8+0x8c7>
  2626f3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262700:	lea    (%r10,%r10,2),%rax
  262704:	movq   $0x0,(%r12)
  26270c:	mov    0x78(%rsp),%ecx
  262710:	mov    %ecx,0x8(%r11,%rax,8)
  262715:	mov    0xa0(%rsp),%ecx
  26271c:	mov    %ecx,0xc(%r11,%rax,8)
  262721:	mov    %r13w,0x14(%r11,%rax,8)
  262727:	mov    %r8d,0x10(%r11,%rax,8)
  26272c:	test   %r14b,%r14b
  26272f:	mov    0xc0(%rsp),%r13
  262737:	mov    0x60(%rsp),%r12
  26273c:	mov    0x58(%rsp),%r9
  262741:	je     2622c5 <<glass::engine::Watch>::print_utf8+0x505>
  262747:	inc    %rbx
  26274a:	cmp    0x30(%rsp),%rbx
  26274f:	jae    263dea <<glass::engine::Watch>::print_utf8+0x202a>
  262755:	lea    (%rbx,%rbx,2),%rax
  262759:	mov    0xb8(%rsp),%rcx
  262761:	lea    (%rcx,%rax,8),%rbx
  262765:	mov    (%rcx,%rax,8),%rax
  262769:	test   %rax,%rax
  26276c:	je     262290 <<glass::engine::Watch>::print_utf8+0x4d0>
  262772:	lock decq (%rax)
  262776:	jne    262290 <<glass::engine::Watch>::print_utf8+0x4d0>
  26277c:	mov    %r15,%r13
  26277f:	mov    %rdi,%r15
  262782:	mov    %rbx,%rdi
  262785:	mov    %rdx,%r14
  262788:	call   *0x38e6ba(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  26278e:	mov    0x58(%rsp),%r9
  262793:	mov    %r15,%rdi
  262796:	mov    %r13,%r15
  262799:	mov    0xc0(%rsp),%r13
  2627a1:	mov    %r14,%rdx
  2627a4:	mov    0x18(%rsp),%rsi
  2627a9:	jmp    262290 <<glass::engine::Watch>::print_utf8+0x4d0>
  2627ae:	mov    %r8,0x58(%rsp)
  2627b3:	mov    %r15,0xe0(%rsp)
  2627bb:	mov    %rdx,%r15
  2627be:	mov    %rdi,0xb0(%rsp)
  2627c6:	mov    %r10,0xe8(%rsp)
  2627ce:	mov    %r11,%r12
  2627d1:	call   18b822 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2627d6:	mov    %r12,%r11
  2627d9:	mov    0xe8(%rsp),%r10
  2627e1:	mov    0xb0(%rsp),%rdi
  2627e9:	mov    %r15,%rdx
  2627ec:	mov    0xe0(%rsp),%r15
  2627f4:	mov    0x58(%rsp),%r8
  2627f9:	mov    %r8d,%ebx
  2627fc:	mov    0x3915ad(%rip),%rsi        # 5f3db0 <glass::engine::width_of::CACHE+0x8>
  262803:	cmp    %rbx,%rsi
  262806:	ja     2624e6 <<glass::engine::Watch>::print_utf8+0x726>
  26280c:	jmp    263d98 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262811:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262820:	xor    %edi,%edi
  262822:	xor    %r11d,%r11d
  262825:	mov    0x18(%rsp),%rsi
  26282a:	jmp    262884 <<glass::engine::Watch>::print_utf8+0xac4>
  26282c:	mov    $0x1,%r11b
  26282f:	jmp    262834 <<glass::engine::Watch>::print_utf8+0xa74>
  262831:	xor    %r11d,%r11d
  262834:	mov    %rbx,%r9
  262837:	mov    %r8d,%ebp
  26283a:	mov    %r15,%rdx
  26283d:	cmp    %r12,%r9
  262840:	jbe    262857 <<glass::engine::Watch>::print_utf8+0xa97>
  262842:	mov    0xd8(%rsp),%rcx
  26284a:	mov    (%rcx),%rax
  26284d:	cmp    %rax,%r9
  262850:	cmova  %r9,%rax
  262854:	mov    %rax,(%rcx)
  262857:	cmp    $0x8,%rdi
  26285b:	setae  %al
  26285e:	testb  $0x1,0x90(%rsp)
  262866:	mov    0xc8(%rsp),%r15
  26286e:	jne    262872 <<glass::engine::Watch>::print_utf8+0xab2>
  262870:	xor    %eax,%eax
  262872:	test   %al,%al
  262874:	jne    2628d2 <<glass::engine::Watch>::print_utf8+0xb12>
  262876:	mov    %r10,%r12
  262879:	mov    %ebp,%r8d
  26287c:	mov    0x98(%rsp),%rbx
  262884:	mov    %r12,0x40(%rbx)
  262888:	mov    %r11b,0x6c(%rbx)
  26288c:	add    %rdi,0xa0(%r15)
  262893:	jmp    262959 <<glass::engine::Watch>::print_utf8+0xb99>
  262898:	xor    %r11d,%r11d
  26289b:	jmp    262837 <<glass::engine::Watch>::print_utf8+0xa77>
  26289d:	mov    %rbx,%r9
  2628a0:	jmp    2628c2 <<glass::engine::Watch>::print_utf8+0xb02>
  2628a2:	xor    %r11d,%r11d
  2628a5:	mov    %r8d,%ebp
  2628a8:	mov    %r15,%rdx
  2628ab:	mov    0xc0(%rsp),%r13
  2628b3:	mov    %rcx,%r14
  2628b6:	mov    0x60(%rsp),%r12
  2628bb:	jmp    26283d <<glass::engine::Watch>::print_utf8+0xa7d>
  2628bd:	mov    0x68(%rsp),%r9
  2628c2:	mov    %r8d,%ebp
  2628c5:	mov    %r15,%rdx
  2628c8:	mov    0x60(%rsp),%r12
  2628cd:	jmp    26283d <<glass::engine::Watch>::print_utf8+0xa7d>
  2628d2:	mov    %rdx,0x28(%rsp)
  2628d7:	movzbl %r11b,%edx
  2628db:	add    %r10,%rdx
  2628de:	mov    %rdi,0xb0(%rsp)
  2628e6:	mov    0xd0(%rsp),%rdi
  2628ee:	mov    %r12,%rsi
  2628f1:	lea    0xf8(%rsp),%rcx
  2628f9:	mov    %r10,%r12
  2628fc:	mov    %r11,%rbx
  2628ff:	call   2a0d00 <glass::engine::note_uniform_span>
  262904:	mov    %rbx,%r11
  262907:	mov    0xb0(%rsp),%rdi
  26290f:	mov    0x28(%rsp),%rdx
  262914:	mov    0x18(%rsp),%rsi
  262919:	jmp    262879 <<glass::engine::Watch>::print_utf8+0xab9>
  26291e:	xchg   %ax,%ax
  262920:	mov    0xc8(%rsp),%r15
  262928:	mov    %r15,%rdi
  26292b:	mov    %ebp,%esi
  26292d:	mov    %r8,%rbx
  262930:	mov    %rdx,%r14
  262933:	call   33c830 <<glass::engine::Watch as vte::ansi::Handler>::input>
  262938:	mov    %r14,%rdx
  26293b:	mov    %rbx,%r8
  26293e:	mov    0x18(%rsp),%rsi
  262943:	mov    0x30(%rsp),%r14
  262948:	add    %r14,%rdx
  26294b:	cmpb   $0x0,0x80(%rsp)
  262953:	jne    261e70 <<glass::engine::Watch>::print_utf8+0xb0>
  262959:	mov    %r8d,%ebp
  26295c:	mov    %r14,%rbx
  26295f:	mov    %rdx,%r14
  262962:	cmp    %r13,%rdx
  262965:	jae    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  26296b:	movzbl (%rsi,%r14,1),%r8d
  262970:	test   %r8b,%r8b
  262973:	js     262990 <<glass::engine::Watch>::print_utf8+0xbd0>
  262975:	mov    $0x1,%edx
  26297a:	lea    -0x7f(%r8),%eax
  26297e:	cmp    $0x21,%eax
  262981:	jae    262b18 <<glass::engine::Watch>::print_utf8+0xd58>
  262987:	jmp    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  26298c:	nopl   0x0(%rax)
  262990:	lea    0x3e(%r8),%eax
  262994:	cmp    $0x1e,%al
  262996:	jae    2629d0 <<glass::engine::Watch>::print_utf8+0xc10>
  262998:	lea    0x1(%r14),%rax
  26299c:	cmp    %r13,%rax
  26299f:	jae    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  2629a5:	movzbl (%rsi,%rax,1),%eax
  2629a9:	cmp    $0xc0,%al
  2629ab:	jge    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  2629b1:	and    $0x1f,%r8d
  2629b5:	shl    $0x6,%r8d
  2629b9:	mov    $0x2,%edx
  2629be:	jmp    262ae8 <<glass::engine::Watch>::print_utf8+0xd28>
  2629c3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2629d0:	mov    %r8d,%eax
  2629d3:	and    $0xf0,%al
  2629d5:	cmp    $0xe0,%al
  2629d7:	jne    2629f3 <<glass::engine::Watch>::print_utf8+0xc33>
  2629d9:	mov    $0xbf,%al
  2629db:	cmp    $0xe0,%r8d
  2629e2:	je     262a19 <<glass::engine::Watch>::print_utf8+0xc59>
  2629e4:	mov    $0x80,%cl
  2629e6:	cmp    $0xed,%r8d
  2629ed:	jne    262a1b <<glass::engine::Watch>::print_utf8+0xc5b>
  2629ef:	mov    $0x9f,%al
  2629f1:	jmp    262a1b <<glass::engine::Watch>::print_utf8+0xc5b>
  2629f3:	lea    0x10(%r8),%eax
  2629f7:	cmp    $0x5,%al
  2629f9:	jae    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  2629ff:	mov    $0x80,%al
  262a01:	cmp    $0xf4,%r8d
  262a08:	je     262a70 <<glass::engine::Watch>::print_utf8+0xcb0>
  262a0a:	mov    $0xbf,%cl
  262a0c:	cmp    $0xf0,%r8d
  262a13:	jne    262a72 <<glass::engine::Watch>::print_utf8+0xcb2>
  262a15:	mov    $0x90,%al
  262a17:	jmp    262a72 <<glass::engine::Watch>::print_utf8+0xcb2>
  262a19:	mov    $0xa0,%cl
  262a1b:	lea    0x1(%r14),%rdx
  262a1f:	cmp    %r13,%rdx
  262a22:	jae    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262a28:	movzbl (%rsi,%rdx,1),%edx
  262a2c:	cmp    %dl,%cl
  262a2e:	ja     26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262a34:	cmp    %al,%dl
  262a36:	ja     26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262a3c:	lea    0x2(%r14),%rax
  262a40:	cmp    %r13,%rax
  262a43:	jae    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262a49:	movzbl (%rsi,%rax,1),%eax
  262a4d:	cmp    $0xc0,%al
  262a4f:	jge    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262a55:	movzbl %dl,%ecx
  262a58:	and    $0x3f,%ecx
  262a5b:	shl    $0x6,%ecx
  262a5e:	and    $0xf,%r8d
  262a62:	shl    $0xc,%r8d
  262a66:	or     %ecx,%r8d
  262a69:	mov    $0x3,%edx
  262a6e:	jmp    262ae8 <<glass::engine::Watch>::print_utf8+0xd28>
  262a70:	mov    $0x8f,%cl
  262a72:	lea    0x1(%r14),%rdx
  262a76:	cmp    %r13,%rdx
  262a79:	jae    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262a7f:	movzbl (%rsi,%rdx,1),%edx
  262a83:	cmp    %dl,%al
  262a85:	ja     26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262a8b:	cmp    %cl,%dl
  262a8d:	ja     26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262a93:	lea    0x2(%r14),%rax
  262a97:	cmp    %r13,%rax
  262a9a:	jae    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262aa0:	movzbl (%rsi,%rax,1),%ecx
  262aa4:	cmp    $0xbf,%cl
  262aa7:	jg     26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262aad:	lea    0x3(%r14),%rax
  262ab1:	cmp    %r13,%rax
  262ab4:	jae    26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262aba:	movzbl (%rsi,%rax,1),%eax
  262abe:	cmp    $0xbf,%al
  262ac0:	jg     26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262ac6:	movzbl %dl,%edx
  262ac9:	and    $0x3f,%ecx
  262acc:	shl    $0x6,%ecx
  262acf:	and    $0x3f,%edx
  262ad2:	shl    $0xc,%edx
  262ad5:	and    $0x7,%r8d
  262ad9:	shl    $0x12,%r8d
  262add:	or     %edx,%r8d
  262ae0:	or     %ecx,%r8d
  262ae3:	mov    $0x4,%edx
  262ae8:	mov    %r8d,%ecx
  262aeb:	xor    $0xd800,%ecx
  262af1:	add    $0xffef0000,%ecx
  262af7:	cmp    $0xffef0800,%ecx
  262afd:	jb     26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262b03:	and    $0x3f,%al
  262b05:	movzbl %al,%eax
  262b08:	or     %eax,%r8d
  262b0b:	lea    -0x7f(%r8),%eax
  262b0f:	cmp    $0x21,%eax
  262b12:	jb     26343e <<glass::engine::Watch>::print_utf8+0x167e>
  262b18:	cmp    $0xffffffff,%ebp
  262b1b:	je     263400 <<glass::engine::Watch>::print_utf8+0x1640>
  262b21:	mov    %r14,0x30(%rsp)
  262b26:	lea    -0x20(%rbp),%eax
  262b29:	cmp    $0x5f,%eax
  262b2c:	jae    262b50 <<glass::engine::Watch>::print_utf8+0xd90>
  262b2e:	mov    $0x1,%r12d
  262b34:	cmpb   $0x0,0x10(%rsp)
  262b39:	je     262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262b3f:	jmp    262bfc <<glass::engine::Watch>::print_utf8+0xe3c>
  262b44:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  262b50:	cmpb   $0x0,0x80(%rsp)
  262b58:	je     262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262b5e:	mov    0x391254(%rip),%eax        # 5f3db8 <glass::engine::width_of::CACHE+0x10>
  262b64:	test   %eax,%eax
  262b66:	jne    263416 <<glass::engine::Watch>::print_utf8+0x1656>
  262b6c:	mov    %ebp,%ebx
  262b6e:	mov    0x39123b(%rip),%rsi        # 5f3db0 <glass::engine::width_of::CACHE+0x8>
  262b75:	cmp    %rbx,%rsi
  262b78:	jbe    263d98 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262b7e:	mov    0x391223(%rip),%r14        # 5f3da8 <glass::engine::width_of::CACHE>
  262b85:	movzbl (%r14,%rbx,1),%eax
  262b8a:	movzbl %al,%r12d
  262b8e:	test   %r12b,%r12b
  262b91:	js     262b9e <<glass::engine::Watch>::print_utf8+0xdde>
  262b93:	mov    $0x1,%cl
  262b95:	test   %cl,%cl
  262b97:	jne    262bed <<glass::engine::Watch>::print_utf8+0xe2d>
  262b99:	jmp    262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262b9e:	cmp    $0xfe,%r12d
  262ba5:	je     262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262bab:	mov    $0xfe,%al
  262bad:	cmp    $0x7f,%ebp
  262bb0:	jae    262bbc <<glass::engine::Watch>::print_utf8+0xdfc>
  262bb2:	mov    $0x1,%r12d
  262bb8:	xor    %ecx,%ecx
  262bba:	jmp    262be1 <<glass::engine::Watch>::print_utf8+0xe21>
  262bbc:	cmp    $0xa0,%ebp
  262bc2:	jb     262bdf <<glass::engine::Watch>::print_utf8+0xe1f>
  262bc4:	mov    %ebp,%edi
  262bc6:	mov    %r8,%r15
  262bc9:	mov    %rdx,%r12
  262bcc:	call   297ea0 <unicode_width::tables::lookup_width>
  262bd1:	mov    %r12,%rdx
  262bd4:	mov    %r15,%r8
  262bd7:	movzbl %al,%r12d
  262bdb:	mov    $0x1,%cl
  262bdd:	jmp    262be1 <<glass::engine::Watch>::print_utf8+0xe21>
  262bdf:	xor    %ecx,%ecx
  262be1:	mov    %al,(%r14,%rbx,1)
  262be5:	test   %cl,%cl
  262be7:	je     262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262bed:	lea    -0x1(%r12),%rax
  262bf2:	cmp    $0x1,%rax
  262bf6:	ja     262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262bfc:	mov    0xc8(%rsp),%rax
  262c04:	mov    0x78(%rax),%r9
  262c08:	cmpb   $0x0,0x6c(%r9)
  262c0d:	jne    262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262c13:	mov    0x40(%r9),%rbx
  262c17:	mov    0xa0(%r9),%r11
  262c1e:	lea    (%rbx,%r12,1),%r10
  262c22:	cmp    %r11,%r10
  262c25:	ja     262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262c2b:	mov    0x30(%r9),%eax
  262c2f:	sub    0x48(%r9),%eax
  262c33:	cltq
  262c35:	mov    0x20(%r9),%rsi
  262c39:	mov    0x28(%r9),%rcx
  262c3d:	lea    (%rcx,%rax,1),%rdi
  262c41:	dec    %rdi
  262c44:	cmp    %rsi,%rdi
  262c47:	mov    $0x0,%eax
  262c4c:	cmovae %rsi,%rax
  262c50:	sub    %rax,%rdi
  262c53:	cmp    %rsi,%rdi
  262c56:	jae    263e3b <<glass::engine::Watch>::print_utf8+0x207b>
  262c5c:	mov    0x58(%r9),%eax
  262c60:	mov    %eax,0x58(%rsp)
  262c64:	mov    0x5c(%r9),%eax
  262c68:	mov    %eax,0xa0(%rsp)
  262c6f:	movzwl 0x64(%r9),%r14d
  262c74:	mov    0x18(%r9),%rax
  262c78:	shl    $0x6,%rdi
  262c7c:	lea    (%rax,%rdi,1),%r15
  262c80:	lea    (%rax,%rdi,1),%rcx
  262c84:	add    $0x18,%rcx
  262c88:	mov    %rcx,0x78(%rsp)
  262c8d:	mov    0x28(%rax,%rdi,1),%eax
  262c91:	cmp    $0xffffffff,%eax
  262c94:	je     262ca1 <<glass::engine::Watch>::print_utf8+0xee1>
  262c96:	mov    0x78(%rsp),%rcx
  262c9b:	cmp    0x30(%r15),%rbx
  262c9f:	jae    262cba <<glass::engine::Watch>::print_utf8+0xefa>
  262ca1:	mov    0x10(%r15),%rsi
  262ca5:	cmp    %rsi,%rbx
  262ca8:	jae    263e48 <<glass::engine::Watch>::print_utf8+0x2088>
  262cae:	lea    (%rbx,%rbx,2),%rcx
  262cb2:	shl    $0x3,%rcx
  262cb6:	add    0x8(%r15),%rcx
  262cba:	testb  $0x60,0x14(%rcx)
  262cbe:	jne    262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262cc4:	cmp    $0x2,%r12
  262cc8:	jne    262d01 <<glass::engine::Watch>::print_utf8+0xf41>
  262cca:	lea    0x1(%rbx),%rdi
  262cce:	cmp    $0xffffffff,%eax
  262cd1:	je     262cde <<glass::engine::Watch>::print_utf8+0xf1e>
  262cd3:	mov    0x78(%rsp),%rcx
  262cd8:	cmp    0x30(%r15),%rdi
  262cdc:	jae    262cf7 <<glass::engine::Watch>::print_utf8+0xf37>
  262cde:	mov    0x10(%r15),%rsi
  262ce2:	cmp    %rsi,%rdi
  262ce5:	jae    263e6c <<glass::engine::Watch>::print_utf8+0x20ac>
  262ceb:	lea    (%rdi,%rdi,2),%rcx
  262cef:	shl    $0x3,%rcx
  262cf3:	add    0x8(%r15),%rcx
  262cf7:	testb  $0x60,0x14(%rcx)
  262cfb:	jne    262920 <<glass::engine::Watch>::print_utf8+0xb60>
  262d01:	mov    %rdx,0x28(%rsp)
  262d06:	cmp    %ebx,0x38(%r15)
  262d0a:	jbe    262d10 <<glass::engine::Watch>::print_utf8+0xf50>
  262d0c:	mov    %ebx,0x38(%r15)
  262d10:	mov    %r14d,0xc(%rsp)
  262d15:	mov    %r11,0x90(%rsp)
  262d1d:	cmp    $0xffffffff,%eax
  262d20:	setne  %dl
  262d23:	mov    0x30(%r15),%rcx
  262d27:	cmp    %rcx,%rbx
  262d2a:	sete   %sil
  262d2e:	test   %sil,%dl
  262d31:	mov    %rbx,0x20(%rsp)
  262d36:	mov    %r15,0x38(%rsp)
  262d3b:	mov    %r9,0x60(%rsp)
  262d40:	mov    %r10,0x70(%rsp)
  262d45:	jne    262dbe <<glass::engine::Watch>::print_utf8+0xffe>
  262d47:	cmp    $0xffffffff,%eax
  262d4a:	mov    0x30(%rsp),%r14
  262d4f:	je     26300d <<glass::engine::Watch>::print_utf8+0x124d>
  262d55:	mov    0x10(%r15),%rax
  262d59:	cmp    %rcx,%rax
  262d5c:	mov    %rcx,%rdx
  262d5f:	cmovb  %rax,%rdx
  262d63:	mov    %rdx,0xa8(%rsp)
  262d6b:	cmp    %rbx,%rax
  262d6e:	mov    %rbx,%rsi
  262d71:	cmovb  %rax,%rsi
  262d75:	mov    0x38e184(%rip),%rdx        # 5f0f00 <_DYNAMIC+0x320>
  262d7c:	movzbl (%rdx),%edx
  262d7f:	test   %dl,%dl
  262d81:	je     262e2b <<glass::engine::Watch>::print_utf8+0x106b>
  262d87:	mov    0x38e1aa(%rip),%rdx        # 5f0f38 <_DYNAMIC+0x358>
  262d8e:	mov    %rsi,%r11
  262d91:	cmp    %rsi,%rcx
  262d94:	jae    262d9d <<glass::engine::Watch>::print_utf8+0xfdd>
  262d96:	mov    0x38e1a3(%rip),%rdx        # 5f0f40 <_DYNAMIC+0x360>
  262d9d:	lock incq 0x28(%rdx)
  262da2:	mov    0x38e16f(%rip),%rdx        # 5f0f18 <_DYNAMIC+0x338>
  262da9:	lock incq (%rdx)
  262dad:	mov    %r11,%rdx
  262db0:	sub    0xa8(%rsp),%rdx
  262db8:	jne    262ddd <<glass::engine::Watch>::print_utf8+0x101d>
  262dba:	xor    %esi,%esi
  262dbc:	jmp    262e1c <<glass::engine::Watch>::print_utf8+0x105c>
  262dbe:	lea    0x1(%rbx),%rax
  262dc2:	mov    %rax,0x30(%r15)
  262dc6:	mov    0x10(%r15),%rsi
  262dca:	cmp    %rsi,%rbx
  262dcd:	mov    0x30(%rsp),%r14
  262dd2:	jb     26302d <<glass::engine::Watch>::print_utf8+0x126d>
  262dd8:	jmp    263e79 <<glass::engine::Watch>::print_utf8+0x20b9>
  262ddd:	mov    0x38e13c(%rip),%rsi        # 5f0f20 <_DYNAMIC+0x340>
  262de4:	lock add %rdx,(%rsi)
  262de8:	cmp    $0x5,%rdx
  262dec:	jae    262dfc <<glass::engine::Watch>::print_utf8+0x103c>
  262dee:	lea    -0x20535d(%rip),%rsi        # 5da98 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  262df5:	movzbl -0x1(%rdx,%rsi,1),%esi
  262dfa:	jmp    262e1c <<glass::engine::Watch>::print_utf8+0x105c>
  262dfc:	lea    -0x5(%rdx),%rdi
  262e00:	mov    $0x4,%esi
  262e05:	cmp    $0x4,%rdi
  262e09:	jb     262e1c <<glass::engine::Watch>::print_utf8+0x105c>
  262e0b:	add    $0xfffffffffffffff7,%rdx
  262e0f:	cmp    $0x8,%rdx
  262e13:	mov    $0x6,%esi
  262e18:	sbb    $0x0,%rsi
  262e1c:	mov    0x38e0ed(%rip),%rdx        # 5f0f10 <_DYNAMIC+0x330>
  262e23:	lock incq (%rdx,%rsi,8)
  262e28:	mov    %r11,%rsi
  262e2b:	cmp    %rsi,%rcx
  262e2e:	jae    262fcb <<glass::engine::Watch>::print_utf8+0x120b>
  262e34:	mov    0x28(%r15),%edi
  262e38:	mov    0x20(%r15),%r10d
  262e3c:	mov    0x24(%r15),%r11d
  262e40:	movzwl 0x2c(%r15),%ecx
  262e45:	mov    0x18(%r15),%rax
  262e49:	test   %rax,%rax
  262e4c:	mov    %rax,0x68(%rsp)
  262e51:	je     262e86 <<glass::engine::Watch>::print_utf8+0x10c6>
  262e53:	lock incq (%rax)
  262e57:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  262e5d:	mov    0x10(%r15),%rdx
  262e61:	mov    %edi,0x50(%rsp)
  262e65:	mov    %r10d,0x48(%rsp)
  262e6a:	mov    %r11d,0x4c(%rsp)
  262e6f:	mov    %ecx,%r9d
  262e72:	mov    %cx,0x54(%rsp)
  262e77:	mov    %rax,0x40(%rsp)
  262e7c:	cmp    %rdx,%rsi
  262e7f:	jbe    262ea1 <<glass::engine::Watch>::print_utf8+0x10e1>
  262e81:	jmp    263da8 <<glass::engine::Watch>::print_utf8+0x1fe8>
  262e86:	mov    %edi,0x50(%rsp)
  262e8a:	mov    %r10d,0x48(%rsp)
  262e8f:	mov    %r11d,0x4c(%rsp)
  262e94:	mov    %cx,0x54(%rsp)
  262e99:	mov    %rax,0x40(%rsp)
  262e9e:	mov    %ecx,%r9d
  262ea1:	mov    0xa8(%rsp),%rax
  262ea9:	lea    0x0(,%rax,8),%rax
  262eb1:	lea    (%rax,%rax,2),%rax
  262eb5:	mov    0x8(%r15),%rbx
  262eb9:	add    %rax,%rbx
  262ebc:	mov    %rsi,0xd0(%rsp)
  262ec4:	lea    0x0(,%rsi,8),%rcx
  262ecc:	lea    (%rcx,%rcx,2),%r14
  262ed0:	sub    %rax,%r14
  262ed3:	mov    0x68(%rsp),%rcx
  262ed8:	mov    %edi,0x98(%rsp)
  262edf:	mov    %r10d,0x8c(%rsp)
  262ee7:	mov    %r11d,0xb8(%rsp)
  262eef:	mov    %r9w,0xd8(%rsp)
  262ef8:	jmp    262f1d <<glass::engine::Watch>::print_utf8+0x115d>
  262efa:	nopw   0x0(%rax,%rax,1)
  262f00:	mov    %rcx,(%rbx)
  262f03:	mov    %r10d,0x8(%rbx)
  262f07:	mov    %r11d,0xc(%rbx)
  262f0b:	mov    %edi,0x10(%rbx)
  262f0e:	mov    %r9w,0x14(%rbx)
  262f13:	add    $0x18,%rbx
  262f17:	add    $0xffffffffffffffe8,%r14
  262f1b:	je     262f75 <<glass::engine::Watch>::print_utf8+0x11b5>
  262f1d:	test   %rcx,%rcx
  262f20:	je     262f2c <<glass::engine::Watch>::print_utf8+0x116c>
  262f22:	lock incq (%rcx)
  262f26:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  262f2c:	mov    (%rbx),%rax
  262f2f:	test   %rax,%rax
  262f32:	je     262f00 <<glass::engine::Watch>::print_utf8+0x1140>
  262f34:	lock decq (%rax)
  262f38:	jne    262f00 <<glass::engine::Watch>::print_utf8+0x1140>
  262f3a:	mov    %rbx,%rdi
  262f3d:	mov    %r8,%r15
  262f40:	call   *0x38df02(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  262f46:	movzwl 0xd8(%rsp),%r9d
  262f4f:	mov    0xb8(%rsp),%r11d
  262f57:	mov    0x8c(%rsp),%r10d
  262f5f:	mov    0x98(%rsp),%edi
  262f66:	mov    0x68(%rsp),%rcx
  262f6b:	mov    %r15,%r8
  262f6e:	mov    0x38(%rsp),%r15
  262f73:	jmp    262f00 <<glass::engine::Watch>::print_utf8+0x1140>
  262f75:	mov    0xa8(%rsp),%rax
  262f7d:	cmp    %eax,0x38(%r15)
  262f81:	mov    0x30(%rsp),%r14
  262f86:	mov    0x20(%rsp),%rbx
  262f8b:	jbe    262f91 <<glass::engine::Watch>::print_utf8+0x11d1>
  262f8d:	mov    %eax,0x38(%r15)
  262f91:	test   %rcx,%rcx
  262f94:	mov    0xd0(%rsp),%rsi
  262f9c:	je     262fc7 <<glass::engine::Watch>::print_utf8+0x1207>
  262f9e:	lock decq (%rcx)
  262fa2:	jne    262fc7 <<glass::engine::Watch>::print_utf8+0x1207>
  262fa4:	lea    0x40(%rsp),%rdi
  262fa9:	mov    %r8,%rbx
  262fac:	call   *0x38de96(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  262fb2:	mov    0xd0(%rsp),%rsi
  262fba:	mov    %rbx,%r8
  262fbd:	mov    0x20(%rsp),%rbx
  262fc2:	mov    0x38(%rsp),%r15
  262fc7:	mov    0x10(%r15),%rax
  262fcb:	cmp    %rax,%rsi
  262fce:	jb     26300d <<glass::engine::Watch>::print_utf8+0x124d>
  262fd0:	cmpl   $0xffffffff,0x28(%r15)
  262fd5:	je     263005 <<glass::engine::Watch>::print_utf8+0x1245>
  262fd7:	mov    0x78(%rsp),%rax
  262fdc:	mov    (%rax),%rax
  262fdf:	test   %rax,%rax
  262fe2:	je     263005 <<glass::engine::Watch>::print_utf8+0x1245>
  262fe4:	lock decq (%rax)
  262fe8:	jne    263005 <<glass::engine::Watch>::print_utf8+0x1245>
  262fea:	mov    0x78(%rsp),%rdi
  262fef:	mov    %r8,%rbx
  262ff2:	call   *0x38de50(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  262ff8:	mov    %rbx,%r8
  262ffb:	mov    0x20(%rsp),%rbx
  263000:	mov    0x38(%rsp),%r15
  263005:	movl   $0xffffffff,0x28(%r15)
  26300d:	mov    0x30(%r15),%rax
  263011:	lea    0x1(%rbx),%rcx
  263015:	cmp    %rax,%rcx
  263018:	cmova  %rcx,%rax
  26301c:	mov    0x10(%r15),%rsi
  263020:	mov    %rax,0x30(%r15)
  263024:	cmp    %rsi,%rbx
  263027:	jae    263e89 <<glass::engine::Watch>::print_utf8+0x20c9>
  26302d:	mov    0xc(%rsp),%esi
  263031:	mov    %esi,%eax
  263033:	or     $0x20,%eax
  263036:	cmp    $0x2,%r12
  26303a:	mov    0x8(%r15),%rcx
  26303e:	lea    (%rbx,%rbx,2),%rdx
  263042:	lea    (%rcx,%rdx,8),%rbx
  263046:	mov    %ebp,0x10(%rcx,%rdx,8)
  26304a:	mov    0x58(%rsp),%ebp
  26304e:	mov    %ebp,0x8(%rcx,%rdx,8)
  263052:	cmovne %esi,%eax
  263055:	mov    0xa0(%rsp),%esi
  26305c:	mov    %esi,0xc(%rcx,%rdx,8)
  263060:	mov    %ax,0x14(%rcx,%rdx,8)
  263065:	mov    (%rcx,%rdx,8),%rax
  263069:	test   %rax,%rax
  26306c:	je     263088 <<glass::engine::Watch>::print_utf8+0x12c8>
  26306e:	lock decq (%rax)
  263072:	jne    263088 <<glass::engine::Watch>::print_utf8+0x12c8>
  263074:	mov    %rbx,%rdi
  263077:	mov    %r8,%r15
  26307a:	call   *0x38ddc8(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263080:	mov    %r15,%r8
  263083:	mov    0x38(%rsp),%r15
  263088:	movq   $0x0,(%rbx)
  26308f:	cmp    $0x2,%r12
  263093:	mov    0x28(%rsp),%rdx
  263098:	jne    2633c8 <<glass::engine::Watch>::print_utf8+0x1608>
  26309e:	mov    0x20(%rsp),%r9
  2630a3:	lea    0x1(%r9),%r12
  2630a7:	mov    0x30(%r15),%rax
  2630ab:	mov    0x28(%r15),%ecx
  2630af:	cmp    %rax,%r12
  2630b2:	jne    2630d3 <<glass::engine::Watch>::print_utf8+0x1313>
  2630b4:	cmp    $0xffffffff,%ecx
  2630b7:	je     2630d3 <<glass::engine::Watch>::print_utf8+0x1313>
  2630b9:	add    $0x2,%r9
  2630bd:	mov    %r9,0x30(%r15)
  2630c1:	mov    0x10(%r15),%rsi
  2630c5:	cmp    %rsi,%r12
  2630c8:	jb     26336f <<glass::engine::Watch>::print_utf8+0x15af>
  2630ce:	jmp    26374e <<glass::engine::Watch>::print_utf8+0x198e>
  2630d3:	cmp    $0xffffffff,%ecx
  2630d6:	je     26334f <<glass::engine::Watch>::print_utf8+0x158f>
  2630dc:	mov    0x10(%r15),%rcx
  2630e0:	cmp    %rax,%rcx
  2630e3:	mov    %rax,%rdi
  2630e6:	cmovb  %rcx,%rdi
  2630ea:	cmp    %r12,%rcx
  2630ed:	mov    %r12,%r10
  2630f0:	cmovb  %rcx,%r10
  2630f4:	mov    0x38de05(%rip),%rdx        # 5f0f00 <_DYNAMIC+0x320>
  2630fb:	movzbl (%rdx),%edx
  2630fe:	test   %dl,%dl
  263100:	je     26317c <<glass::engine::Watch>::print_utf8+0x13bc>
  263102:	mov    0x38de2f(%rip),%rdx        # 5f0f38 <_DYNAMIC+0x358>
  263109:	cmp    %r10,%rax
  26310c:	jae    263115 <<glass::engine::Watch>::print_utf8+0x1355>
  26310e:	mov    0x38de2b(%rip),%rdx        # 5f0f40 <_DYNAMIC+0x360>
  263115:	lock incq 0x28(%rdx)
  26311a:	mov    0x38ddf7(%rip),%rdx        # 5f0f18 <_DYNAMIC+0x338>
  263121:	lock incq (%rdx)
  263125:	mov    %r10,%rdx
  263128:	sub    %rdi,%rdx
  26312b:	jne    263131 <<glass::engine::Watch>::print_utf8+0x1371>
  26312d:	xor    %esi,%esi
  26312f:	jmp    263170 <<glass::engine::Watch>::print_utf8+0x13b0>
  263131:	mov    0x38dde8(%rip),%rsi        # 5f0f20 <_DYNAMIC+0x340>
  263138:	lock add %rdx,(%rsi)
  26313c:	cmp    $0x5,%rdx
  263140:	jae    263150 <<glass::engine::Watch>::print_utf8+0x1390>
  263142:	lea    -0x2056b1(%rip),%rsi        # 5da98 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  263149:	movzbl -0x1(%rdx,%rsi,1),%esi
  26314e:	jmp    263170 <<glass::engine::Watch>::print_utf8+0x13b0>
  263150:	lea    -0x5(%rdx),%r11
  263154:	mov    $0x4,%esi
  263159:	cmp    $0x4,%r11
  26315d:	jb     263170 <<glass::engine::Watch>::print_utf8+0x13b0>
  26315f:	add    $0xfffffffffffffff7,%rdx
  263163:	cmp    $0x8,%rdx
  263167:	mov    $0x6,%esi
  26316c:	sbb    $0x0,%rsi
  263170:	mov    0x38dd99(%rip),%rdx        # 5f0f10 <_DYNAMIC+0x330>
  263177:	lock incq (%rdx,%rsi,8)
  26317c:	cmp    %r10,%rax
  26317f:	mov    0x28(%rsp),%rdx
  263184:	jae    263328 <<glass::engine::Watch>::print_utf8+0x1568>
  26318a:	mov    %r12,0xd8(%rsp)
  263192:	mov    0x28(%r15),%r9d
  263196:	mov    0x20(%r15),%r11d
  26319a:	mov    0x24(%r15),%ebp
  26319e:	movzwl 0x2c(%r15),%eax
  2631a3:	mov    0x18(%r15),%r12
  2631a7:	test   %r12,%r12
  2631aa:	mov    %r12,0x98(%rsp)
  2631b2:	mov    %ax,0x68(%rsp)
  2631b7:	je     2631ed <<glass::engine::Watch>::print_utf8+0x142d>
  2631b9:	lock incq (%r12)
  2631be:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  2631c4:	mov    0x10(%r15),%rdx
  2631c8:	mov    %r9d,0x50(%rsp)
  2631cd:	mov    %r11d,0x48(%rsp)
  2631d2:	mov    %ebp,0x4c(%rsp)
  2631d6:	mov    %ax,0x54(%rsp)
  2631db:	mov    %r12,0x40(%rsp)
  2631e0:	cmp    %rdx,%r10
  2631e3:	mov    %r10,%rsi
  2631e6:	jbe    263208 <<glass::engine::Watch>::print_utf8+0x1448>
  2631e8:	jmp    263dc2 <<glass::engine::Watch>::print_utf8+0x2002>
  2631ed:	mov    %r9d,0x50(%rsp)
  2631f2:	mov    %r11d,0x48(%rsp)
  2631f7:	mov    %ebp,0x4c(%rsp)
  2631fb:	mov    %ax,0x54(%rsp)
  263200:	mov    %r12,0x40(%rsp)
  263205:	mov    %r10,%rsi
  263208:	mov    %rdi,0xa8(%rsp)
  263210:	lea    0x0(,%rdi,8),%rax
  263218:	lea    (%rax,%rax,2),%rax
  26321c:	mov    0x8(%r15),%rbx
  263220:	add    %rax,%rbx
  263223:	mov    %rsi,0xb8(%rsp)
  26322b:	lea    0x0(,%rsi,8),%rcx
  263233:	lea    (%rcx,%rcx,2),%r14
  263237:	sub    %rax,%r14
  26323a:	movzwl 0x68(%rsp),%ecx
  26323f:	mov    %ebp,0x8c(%rsp)
  263246:	jmp    26326c <<glass::engine::Watch>::print_utf8+0x14ac>
  263248:	nopl   0x0(%rax,%rax,1)
  263250:	mov    %r12,(%rbx)
  263253:	mov    %r11d,0x8(%rbx)
  263257:	mov    %ebp,0xc(%rbx)
  26325a:	mov    %r9d,0x10(%rbx)
  26325e:	mov    %cx,0x14(%rbx)
  263262:	add    $0x18,%rbx
  263266:	add    $0xffffffffffffffe8,%r14
  26326a:	je     2632c0 <<glass::engine::Watch>::print_utf8+0x1500>
  26326c:	test   %r12,%r12
  26326f:	je     26327c <<glass::engine::Watch>::print_utf8+0x14bc>
  263271:	lock incq (%r12)
  263276:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  26327c:	mov    (%rbx),%rax
  26327f:	test   %rax,%rax
  263282:	je     263250 <<glass::engine::Watch>::print_utf8+0x1490>
  263284:	lock decq (%rax)
  263288:	jne    263250 <<glass::engine::Watch>::print_utf8+0x1490>
  26328a:	mov    %rbx,%rdi
  26328d:	mov    %r8,%r15
  263290:	mov    %r9d,%ebp
  263293:	mov    %r11d,%r12d
  263296:	call   *0x38dbac(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  26329c:	movzwl 0x68(%rsp),%ecx
  2632a1:	mov    %r12d,%r11d
  2632a4:	mov    0x98(%rsp),%r12
  2632ac:	mov    %ebp,%r9d
  2632af:	mov    0x8c(%rsp),%ebp
  2632b6:	mov    %r15,%r8
  2632b9:	mov    0x38(%rsp),%r15
  2632be:	jmp    263250 <<glass::engine::Watch>::print_utf8+0x1490>
  2632c0:	mov    0xa8(%rsp),%rax
  2632c8:	cmp    %eax,0x38(%r15)
  2632cc:	mov    0x30(%rsp),%r14
  2632d1:	mov    0x28(%rsp),%rdx
  2632d6:	mov    0x20(%rsp),%r9
  2632db:	jbe    2632e1 <<glass::engine::Watch>::print_utf8+0x1521>
  2632dd:	mov    %eax,0x38(%r15)
  2632e1:	test   %r12,%r12
  2632e4:	mov    0x58(%rsp),%ebp
  2632e8:	mov    0xb8(%rsp),%r10
  2632f0:	je     26331c <<glass::engine::Watch>::print_utf8+0x155c>
  2632f2:	lock decq (%r12)
  2632f7:	jne    26331c <<glass::engine::Watch>::print_utf8+0x155c>
  2632f9:	lea    0x40(%rsp),%rdi
  2632fe:	mov    %r8,%rbx
  263301:	call   *0x38db41(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263307:	mov    0x28(%rsp),%rdx
  26330c:	mov    %rbx,%r8
  26330f:	mov    0xb8(%rsp),%r10
  263317:	mov    0x20(%rsp),%r9
  26331c:	mov    0x10(%r15),%rcx
  263320:	mov    0xd8(%rsp),%r12
  263328:	cmp    %rcx,%r10
  26332b:	jb     26334f <<glass::engine::Watch>::print_utf8+0x158f>
  26332d:	mov    0x78(%rsp),%rdi
  263332:	mov    %r8,%rbx
  263335:	call   1ad320 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26333a:	mov    0x28(%rsp),%rdx
  26333f:	mov    %rbx,%r8
  263342:	mov    0x20(%rsp),%r9
  263347:	movl   $0xffffffff,0x28(%r15)
  26334f:	mov    0x30(%r15),%rax
  263353:	add    $0x2,%r9
  263357:	cmp    %rax,%r9
  26335a:	cmovbe %rax,%r9
  26335e:	mov    0x10(%r15),%rsi
  263362:	mov    %r9,0x30(%r15)
  263366:	cmp    %rsi,%r12
  263369:	jae    263e99 <<glass::engine::Watch>::print_utf8+0x20d9>
  26336f:	mov    0x8(%r15),%rax
  263373:	lea    (%r12,%r12,2),%rcx
  263377:	lea    (%rax,%rcx,8),%rbx
  26337b:	movl   $0x20,0x10(%rax,%rcx,8)
  263383:	mov    %ebp,0x8(%rax,%rcx,8)
  263387:	mov    0xa0(%rsp),%esi
  26338e:	mov    %esi,0xc(%rax,%rcx,8)
  263392:	mov    0xc(%rsp),%esi
  263396:	or     $0x40,%esi
  263399:	mov    %si,0x14(%rax,%rcx,8)
  26339e:	mov    (%rax,%rcx,8),%rax
  2633a2:	test   %rax,%rax
  2633a5:	je     2633c1 <<glass::engine::Watch>::print_utf8+0x1601>
  2633a7:	lock decq (%rax)
  2633ab:	jne    2633c1 <<glass::engine::Watch>::print_utf8+0x1601>
  2633ad:	mov    %rbx,%rdi
  2633b0:	mov    %r8,%r15
  2633b3:	call   *0x38da8f(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  2633b9:	mov    0x28(%rsp),%rdx
  2633be:	mov    %r15,%r8
  2633c1:	movq   $0x0,(%rbx)
  2633c8:	mov    0x70(%rsp),%rcx
  2633cd:	cmp    0x90(%rsp),%rcx
  2633d5:	mov    0x18(%rsp),%rsi
  2633da:	mov    0x60(%rsp),%rax
  2633df:	jb     2633e8 <<glass::engine::Watch>::print_utf8+0x1628>
  2633e1:	dec    %rcx
  2633e4:	movb   $0x1,0x6c(%rax)
  2633e8:	mov    %rcx,0x40(%rax)
  2633ec:	mov    0xc8(%rsp),%r15
  2633f4:	incq   0xa0(%r15)
  2633fb:	nopl   0x0(%rax,%rax,1)
  263400:	add    %r14,%rdx
  263403:	cmpb   $0x0,0x80(%rsp)
  26340b:	je     262959 <<glass::engine::Watch>::print_utf8+0xb99>
  263411:	jmp    261e70 <<glass::engine::Watch>::print_utf8+0xb0>
  263416:	mov    %r8,%rbx
  263419:	mov    %rdx,%r14
  26341c:	call   18b822 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263421:	mov    %r14,%rdx
  263424:	mov    %rbx,%r8
  263427:	mov    %ebp,%ebx
  263429:	mov    0x390980(%rip),%rsi        # 5f3db0 <glass::engine::width_of::CACHE+0x8>
  263430:	cmp    %rbx,%rsi
  263433:	ja     262b7e <<glass::engine::Watch>::print_utf8+0xdbe>
  263439:	jmp    263d98 <<glass::engine::Watch>::print_utf8+0x1fd8>
  26343e:	cmpq   $0x400,0xa0(%r15)
  263449:	jb     263474 <<glass::engine::Watch>::print_utf8+0x16b4>
  26344b:	mov    %r15,%rdi
  26344e:	call   264210 <<glass::engine::Watch>::fold_sentinel>
  263453:	movq   $0x0,0xa0(%r15)
  26345e:	mov    0x39095c(%rip),%eax        # 5f3dc0 <glass::engine::run_whole::ON>
  263464:	test   %eax,%eax
  263466:	je     26347e <<glass::engine::Watch>::print_utf8+0x16be>
  263468:	call   18b8c6 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  26346d:	cmp    %r13,%r14
  263470:	je     263483 <<glass::engine::Watch>::print_utf8+0x16c3>
  263472:	jmp    2634b3 <<glass::engine::Watch>::print_utf8+0x16f3>
  263474:	mov    0x390946(%rip),%eax        # 5f3dc0 <glass::engine::run_whole::ON>
  26347a:	test   %eax,%eax
  26347c:	jne    263468 <<glass::engine::Watch>::print_utf8+0x16a8>
  26347e:	cmp    %r13,%r14
  263481:	jne    2634b3 <<glass::engine::Watch>::print_utf8+0x16f3>
  263483:	cmpb   $0x0,0x39093a(%rip)        # 5f3dc4 <glass::engine::run_whole::ON+0x4>
  26348a:	je     2634b3 <<glass::engine::Watch>::print_utf8+0x16f3>
  26348c:	cmp    $0xffffffff,%ebp
  26348f:	je     263655 <<glass::engine::Watch>::print_utf8+0x1895>
  263495:	lea    -0x20(%rbp),%eax
  263498:	cmp    $0x5f,%eax
  26349b:	jae    2634c4 <<glass::engine::Watch>::print_utf8+0x1704>
  26349d:	mov    $0x1,%r13d
  2634a3:	cmpb   $0x0,0x10(%rsp)
  2634a8:	jne    26358f <<glass::engine::Watch>::print_utf8+0x17cf>
  2634ae:	jmp    263643 <<glass::engine::Watch>::print_utf8+0x1883>
  2634b3:	xor    %eax,%eax
  2634b5:	cmp    $0xffffffff,%ebp
  2634b8:	cmove  %rax,%rbx
  2634bc:	mov    %rbx,%r13
  2634bf:	jmp    263655 <<glass::engine::Watch>::print_utf8+0x1895>
  2634c4:	cmpb   $0x0,0x80(%rsp)
  2634cc:	je     263643 <<glass::engine::Watch>::print_utf8+0x1883>
  2634d2:	mov    0x3908e0(%rip),%eax        # 5f3db8 <glass::engine::width_of::CACHE+0x10>
  2634d8:	test   %eax,%eax
  2634da:	jne    263d81 <<glass::engine::Watch>::print_utf8+0x1fc1>
  2634e0:	mov    %ebp,%ebx
  2634e2:	mov    0x3908c7(%rip),%rsi        # 5f3db0 <glass::engine::width_of::CACHE+0x8>
  2634e9:	cmp    %rbx,%rsi
  2634ec:	jbe    263d98 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2634f2:	mov    0x3908af(%rip),%r14        # 5f3da8 <glass::engine::width_of::CACHE>
  2634f9:	movzbl (%r14,%rbx,1),%eax
  2634fe:	movzbl %al,%r13d
  263502:	test   %r13b,%r13b
  263505:	js     263512 <<glass::engine::Watch>::print_utf8+0x1752>
  263507:	mov    $0x1,%cl
  263509:	test   %cl,%cl
  26350b:	jne    263581 <<glass::engine::Watch>::print_utf8+0x17c1>
  26350d:	jmp    263643 <<glass::engine::Watch>::print_utf8+0x1883>
  263512:	cmp    $0xfe,%r13d
  263519:	je     263643 <<glass::engine::Watch>::print_utf8+0x1883>
  26351f:	mov    $0xfe,%al
  263521:	cmp    $0x7f,%ebp
  263524:	jae    26355c <<glass::engine::Watch>::print_utf8+0x179c>
  263526:	mov    $0x1,%r13d
  26352c:	xor    %ecx,%ecx
  26352e:	jmp    263575 <<glass::engine::Watch>::print_utf8+0x17b5>
  263530:	mov    $0x1,%cl
  263532:	mov    %ecx,0x80(%rsp)
  263539:	cmpb   $0x0,0x68(%rax)
  26353d:	jne    26354f <<glass::engine::Watch>::print_utf8+0x178f>
  26353f:	cmpb   $0x0,0x69(%rax)
  263543:	jne    26354f <<glass::engine::Watch>::print_utf8+0x178f>
  263545:	cmpb   $0x0,0x6a(%rax)
  263549:	je     26376e <<glass::engine::Watch>::print_utf8+0x19ae>
  26354f:	movl   $0x0,0x10(%rsp)
  263557:	jmp    261e1e <<glass::engine::Watch>::print_utf8+0x5e>
  26355c:	cmp    $0xa0,%ebp
  263562:	jb     263573 <<glass::engine::Watch>::print_utf8+0x17b3>
  263564:	mov    %ebp,%edi
  263566:	call   297ea0 <unicode_width::tables::lookup_width>
  26356b:	movzbl %al,%r13d
  26356f:	mov    $0x1,%cl
  263571:	jmp    263575 <<glass::engine::Watch>::print_utf8+0x17b5>
  263573:	xor    %ecx,%ecx
  263575:	mov    %al,(%r14,%rbx,1)
  263579:	test   %cl,%cl
  26357b:	je     263643 <<glass::engine::Watch>::print_utf8+0x1883>
  263581:	lea    -0x1(%r13),%rax
  263585:	cmp    $0x1,%rax
  263589:	ja     263643 <<glass::engine::Watch>::print_utf8+0x1883>
  26358f:	mov    0x78(%r15),%r14
  263593:	cmpb   $0x0,0x6c(%r14)
  263598:	jne    263643 <<glass::engine::Watch>::print_utf8+0x1883>
  26359e:	mov    0x40(%r14),%r12
  2635a2:	mov    0xa0(%r14),%r8
  2635a9:	lea    (%r12,%r13,1),%rdx
  2635ad:	cmp    %r8,%rdx
  2635b0:	ja     263643 <<glass::engine::Watch>::print_utf8+0x1883>
  2635b6:	mov    0x30(%r14),%eax
  2635ba:	sub    0x48(%r14),%eax
  2635be:	cltq
  2635c0:	mov    0x20(%r14),%rsi
  2635c4:	mov    0x28(%r14),%rcx
  2635c8:	lea    (%rcx,%rax,1),%rdi
  2635cc:	dec    %rdi
  2635cf:	xor    %eax,%eax
  2635d1:	cmp    %rsi,%rdi
  2635d4:	cmovae %rsi,%rax
  2635d8:	sub    %rax,%rdi
  2635db:	cmp    %rsi,%rdi
  2635de:	jae    263e3b <<glass::engine::Watch>::print_utf8+0x207b>
  2635e4:	mov    0x58(%r14),%r10d
  2635e8:	mov    0x5c(%r14),%r11d
  2635ec:	movzwl 0x64(%r14),%r9d
  2635f1:	mov    0x18(%r14),%rax
  2635f5:	shl    $0x6,%rdi
  2635f9:	lea    (%rax,%rdi,1),%rbx
  2635fd:	lea    (%rax,%rdi,1),%rcx
  263601:	add    $0x18,%rcx
  263605:	mov    %rcx,0x80(%rsp)
  26360d:	mov    0x28(%rax,%rdi,1),%eax
  263611:	cmp    $0xffffffff,%eax
  263614:	je     263624 <<glass::engine::Watch>::print_utf8+0x1864>
  263616:	mov    0x80(%rsp),%rcx
  26361e:	cmp    0x30(%rbx),%r12
  263622:	jae    26363d <<glass::engine::Watch>::print_utf8+0x187d>
  263624:	mov    0x10(%rbx),%rsi
  263628:	cmp    %rsi,%r12
  26362b:	jae    263ea9 <<glass::engine::Watch>::print_utf8+0x20e9>
  263631:	lea    (%r12,%r12,2),%rcx
  263635:	shl    $0x3,%rcx
  263639:	add    0x8(%rbx),%rcx
  26363d:	testb  $0x60,0x14(%rcx)
  263641:	je     26366a <<glass::engine::Watch>::print_utf8+0x18aa>
  263643:	mov    %r15,%rdi
  263646:	mov    %ebp,%esi
  263648:	call   33c830 <<glass::engine::Watch as vte::ansi::Handler>::input>
  26364d:	mov    0xc0(%rsp),%r13
  263655:	mov    %r13,%rax
  263658:	add    $0x118,%rsp
  26365f:	pop    %rbx
  263660:	pop    %r12
  263662:	pop    %r13
  263664:	pop    %r14
  263666:	pop    %r15
  263668:	pop    %rbp
  263669:	ret
  26366a:	cmp    $0x2,%r13
  26366e:	jne    2636a7 <<glass::engine::Watch>::print_utf8+0x18e7>
  263670:	lea    0x1(%r12),%rdi
  263675:	cmp    $0xffffffff,%eax
  263678:	je     263688 <<glass::engine::Watch>::print_utf8+0x18c8>
  26367a:	mov    0x80(%rsp),%rcx
  263682:	cmp    0x30(%rbx),%rdi
  263686:	jae    2636a1 <<glass::engine::Watch>::print_utf8+0x18e1>
  263688:	mov    0x10(%rbx),%rsi
  26368c:	cmp    %rsi,%rdi
  26368f:	jae    263e6c <<glass::engine::Watch>::print_utf8+0x20ac>
  263695:	lea    (%rdi,%rdi,2),%rcx
  263699:	shl    $0x3,%rcx
  26369d:	add    0x8(%rbx),%rcx
  2636a1:	testb  $0x60,0x14(%rcx)
  2636a5:	jne    263643 <<glass::engine::Watch>::print_utf8+0x1883>
  2636a7:	mov    %r11d,0x78(%rsp)
  2636ac:	mov    %r10d,0x28(%rsp)
  2636b1:	mov    %r9d,0x30(%rsp)
  2636b6:	mov    %r8,0x58(%rsp)
  2636bb:	mov    %rdx,0xa0(%rsp)
  2636c3:	cmp    %r12d,0x38(%rbx)
  2636c7:	jbe    2636cd <<glass::engine::Watch>::print_utf8+0x190d>
  2636c9:	mov    %r12d,0x38(%rbx)
  2636cd:	cmp    $0xffffffff,%eax
  2636d0:	setne  %cl
  2636d3:	mov    %rbx,%rdi
  2636d6:	mov    0x30(%rbx),%rbx
  2636da:	cmp    %rbx,%r12
  2636dd:	sete   %dl
  2636e0:	test   %dl,%cl
  2636e2:	mov    %rdi,0x18(%rsp)
  2636e7:	jne    263735 <<glass::engine::Watch>::print_utf8+0x1975>
  2636e9:	cmp    $0xffffffff,%eax
  2636ec:	je     26399f <<glass::engine::Watch>::print_utf8+0x1bdf>
  2636f2:	mov    0x18(%rsp),%rax
  2636f7:	mov    0x10(%rax),%r15
  2636fb:	cmp    %rbx,%r15
  2636fe:	mov    %rbx,%rax
  263701:	cmovb  %r15,%rax
  263705:	mov    %rax,0x10(%rsp)
  26370a:	cmp    %r12,%r15
  26370d:	mov    %r12,%rcx
  263710:	cmovb  %r15,%rcx
  263714:	mov    0x38d7e5(%rip),%rax        # 5f0f00 <_DYNAMIC+0x320>
  26371b:	movzbl (%rax),%eax
  26371e:	test   %al,%al
  263720:	mov    %rcx,0x20(%rsp)
  263725:	je     26379c <<glass::engine::Watch>::print_utf8+0x19dc>
  263727:	cmp    %rcx,%rbx
  26372a:	jae    26377e <<glass::engine::Watch>::print_utf8+0x19be>
  26372c:	mov    0x38d80d(%rip),%rax        # 5f0f40 <_DYNAMIC+0x360>
  263733:	jmp    263785 <<glass::engine::Watch>::print_utf8+0x19c5>
  263735:	lea    0x1(%r12),%rax
  26373a:	mov    %rax,0x30(%rdi)
  26373e:	mov    0x10(%rdi),%rsi
  263742:	cmp    %rsi,%r12
  263745:	mov    %rdi,%rdx
  263748:	jb     2639c5 <<glass::engine::Watch>::print_utf8+0x1c05>
  26374e:	lea    0x36504b(%rip),%rdx        # 5c87a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  263755:	mov    %r12,%rdi
  263758:	call   *0x38d69a(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  26375e:	lea    0x364f93(%rip),%rcx        # 5c86f8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15a38>
  263765:	mov    %r12,%rdi
  263768:	call   *0x38d84a(%rip)        # 5f0fb8 <_DYNAMIC+0x3d8>
  26376e:	cmpb   $0x0,0x6b(%rax)
  263772:	sete   %al
  263775:	mov    %eax,0x10(%rsp)
  263779:	jmp    261e1e <<glass::engine::Watch>::print_utf8+0x5e>
  26377e:	mov    0x38d7b3(%rip),%rax        # 5f0f38 <_DYNAMIC+0x358>
  263785:	lock incq 0x28(%rax)
  26378a:	mov    %rcx,%rdi
  26378d:	sub    0x10(%rsp),%rdi
  263792:	call   2f63e0 <alacritty_terminal::grid::row::fill_census::note>
  263797:	mov    0x20(%rsp),%rcx
  26379c:	cmp    %rcx,%rbx
  26379f:	jae    263979 <<glass::engine::Watch>::print_utf8+0x1bb9>
  2637a5:	mov    0x18(%rsp),%rcx
  2637aa:	mov    0x28(%rcx),%edi
  2637ad:	mov    0x20(%rcx),%r8d
  2637b1:	mov    0x24(%rcx),%r9d
  2637b5:	movzwl 0x2c(%rcx),%r10d
  2637ba:	mov    0x18(%rcx),%rsi
  2637be:	test   %rsi,%rsi
  2637c1:	mov    %rsi,0x38(%rsp)
  2637c6:	mov    %edi,0xc(%rsp)
  2637ca:	mov    %r8d,0x60(%rsp)
  2637cf:	mov    %r9d,0x70(%rsp)
  2637d4:	mov    %r10w,0x90(%rsp)
  2637dd:	je     2638a6 <<glass::engine::Watch>::print_utf8+0x1ae6>
  2637e3:	lock incq (%rsi)
  2637e7:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  2637ed:	mov    0x10(%rcx),%rdx
  2637f1:	mov    %edi,0x50(%rsp)
  2637f5:	mov    %r8d,0x48(%rsp)
  2637fa:	mov    %r9d,0x4c(%rsp)
  2637ff:	mov    %r10w,0x54(%rsp)
  263805:	mov    %rsi,0x40(%rsp)
  26380a:	mov    0x20(%rsp),%rsi
  26380f:	cmp    %rdx,%rsi
  263812:	ja     263e27 <<glass::engine::Watch>::print_utf8+0x2067>
  263818:	mov    0x10(%rsp),%rax
  26381d:	lea    0x0(,%rax,8),%rax
  263825:	lea    (%rax,%rax,2),%rax
  263829:	mov    0x8(%rcx),%rbx
  26382d:	add    %rax,%rbx
  263830:	lea    0x0(,%rsi,8),%rcx
  263838:	lea    (%rcx,%rcx,2),%r15
  26383c:	sub    %rax,%r15
  26383f:	mov    0x38(%rsp),%rsi
  263844:	jmp    263867 <<glass::engine::Watch>::print_utf8+0x1aa7>
  263846:	mov    %rsi,(%rbx)
  263849:	mov    %r8d,0x8(%rbx)
  26384d:	mov    %r9d,0xc(%rbx)
  263851:	mov    %edi,0x10(%rbx)
  263854:	mov    %r10w,0x14(%rbx)
  263859:	add    $0x18,%rbx
  26385d:	add    $0xffffffffffffffe8,%r15
  263861:	je     263943 <<glass::engine::Watch>::print_utf8+0x1b83>
  263867:	lock incq (%rsi)
  26386b:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  263871:	mov    (%rbx),%rax
  263874:	test   %rax,%rax
  263877:	je     263846 <<glass::engine::Watch>::print_utf8+0x1a86>
  263879:	lock decq (%rax)
  26387d:	jne    263846 <<glass::engine::Watch>::print_utf8+0x1a86>
  26387f:	mov    %rbx,%rdi
  263882:	call   *0x38d5c0(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263888:	movzwl 0x90(%rsp),%r10d
  263891:	mov    0x70(%rsp),%r9d
  263896:	mov    0x60(%rsp),%r8d
  26389b:	mov    0xc(%rsp),%edi
  26389f:	mov    0x38(%rsp),%rsi
  2638a4:	jmp    263846 <<glass::engine::Watch>::print_utf8+0x1a86>
  2638a6:	mov    %edi,0x50(%rsp)
  2638aa:	mov    %r8d,0x48(%rsp)
  2638af:	mov    %r9d,0x4c(%rsp)
  2638b4:	mov    %r10w,0x54(%rsp)
  2638ba:	mov    %rsi,0x40(%rsp)
  2638bf:	mov    0x10(%rsp),%rax
  2638c4:	lea    0x0(,%rax,8),%rax
  2638cc:	lea    (%rax,%rax,2),%rax
  2638d0:	mov    0x8(%rcx),%rbx
  2638d4:	add    %rax,%rbx
  2638d7:	mov    0x20(%rsp),%rcx
  2638dc:	lea    0x0(,%rcx,8),%rcx
  2638e4:	lea    (%rcx,%rcx,2),%r15
  2638e8:	sub    %rax,%r15
  2638eb:	jmp    26390e <<glass::engine::Watch>::print_utf8+0x1b4e>
  2638ed:	movq   $0x0,(%rbx)
  2638f4:	mov    %r8d,0x8(%rbx)
  2638f8:	mov    %r9d,0xc(%rbx)
  2638fc:	mov    %edi,0x10(%rbx)
  2638ff:	mov    %r10w,0x14(%rbx)
  263904:	add    $0x18,%rbx
  263908:	add    $0xffffffffffffffe8,%r15
  26390c:	je     263943 <<glass::engine::Watch>::print_utf8+0x1b83>
  26390e:	mov    (%rbx),%rax
  263911:	test   %rax,%rax
  263914:	je     2638ed <<glass::engine::Watch>::print_utf8+0x1b2d>
  263916:	lock decq (%rax)
  26391a:	jne    2638ed <<glass::engine::Watch>::print_utf8+0x1b2d>
  26391c:	mov    %rbx,%rdi
  26391f:	call   *0x38d523(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263925:	movzwl 0x90(%rsp),%r10d
  26392e:	mov    0x70(%rsp),%r9d
  263933:	mov    0x60(%rsp),%r8d
  263938:	mov    0xc(%rsp),%edi
  26393c:	mov    0x38(%rsp),%rsi
  263941:	jmp    2638ed <<glass::engine::Watch>::print_utf8+0x1b2d>
  263943:	mov    0x18(%rsp),%rbx
  263948:	mov    0x10(%rsp),%rax
  26394d:	cmp    %eax,0x38(%rbx)
  263950:	jbe    263955 <<glass::engine::Watch>::print_utf8+0x1b95>
  263952:	mov    %eax,0x38(%rbx)
  263955:	test   %rsi,%rsi
  263958:	mov    0x20(%rsp),%rcx
  26395d:	je     263975 <<glass::engine::Watch>::print_utf8+0x1bb5>
  26395f:	lock decq (%rsi)
  263963:	jne    263975 <<glass::engine::Watch>::print_utf8+0x1bb5>
  263965:	lea    0x40(%rsp),%rdi
  26396a:	call   *0x38d4d8(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263970:	mov    0x20(%rsp),%rcx
  263975:	mov    0x10(%rbx),%r15
  263979:	cmp    %r15,%rcx
  26397c:	mov    0xc8(%rsp),%r15
  263984:	jb     26399f <<glass::engine::Watch>::print_utf8+0x1bdf>
  263986:	mov    0x80(%rsp),%rdi
  26398e:	call   1ad320 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263993:	mov    0x18(%rsp),%rax
  263998:	movl   $0xffffffff,0x28(%rax)
  26399f:	mov    0x18(%rsp),%rdx
  2639a4:	mov    0x30(%rdx),%rax
  2639a8:	lea    0x1(%r12),%rcx
  2639ad:	cmp    %rax,%rcx
  2639b0:	cmova  %rcx,%rax
  2639b4:	mov    0x10(%rdx),%rsi
  2639b8:	mov    %rax,0x30(%rdx)
  2639bc:	cmp    %rsi,%r12
  2639bf:	jae    263e99 <<glass::engine::Watch>::print_utf8+0x20d9>
  2639c5:	mov    0x30(%rsp),%esi
  2639c9:	mov    %esi,%eax
  2639cb:	or     $0x20,%eax
  2639ce:	cmp    $0x2,%r13
  2639d2:	mov    0x8(%rdx),%rcx
  2639d6:	lea    (%r12,%r12,2),%rdx
  2639da:	lea    (%rcx,%rdx,8),%rbx
  2639de:	mov    %ebp,0x10(%rcx,%rdx,8)
  2639e2:	mov    0x28(%rsp),%edi
  2639e6:	mov    %edi,0x8(%rcx,%rdx,8)
  2639ea:	cmovne %esi,%eax
  2639ed:	mov    0x78(%rsp),%esi
  2639f1:	mov    %esi,0xc(%rcx,%rdx,8)
  2639f5:	mov    %ax,0x14(%rcx,%rdx,8)
  2639fa:	mov    (%rcx,%rdx,8),%rax
  2639fe:	test   %rax,%rax
  263a01:	je     263a12 <<glass::engine::Watch>::print_utf8+0x1c52>
  263a03:	lock decq (%rax)
  263a07:	jne    263a12 <<glass::engine::Watch>::print_utf8+0x1c52>
  263a09:	mov    %rbx,%rdi
  263a0c:	call   *0x38d436(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263a12:	movq   $0x0,(%rbx)
  263a19:	cmp    $0x2,%r13
  263a1d:	mov    0xc0(%rsp),%r13
  263a25:	jne    263d53 <<glass::engine::Watch>::print_utf8+0x1f93>
  263a2b:	lea    0x1(%r12),%rcx
  263a30:	mov    0x18(%rsp),%rax
  263a35:	mov    0x30(%rax),%rbx
  263a39:	mov    0x28(%rax),%eax
  263a3c:	mov    %rcx,0x38(%rsp)
  263a41:	cmp    %rbx,%rcx
  263a44:	jne    263a77 <<glass::engine::Watch>::print_utf8+0x1cb7>
  263a46:	cmp    $0xffffffff,%eax
  263a49:	je     263a77 <<glass::engine::Watch>::print_utf8+0x1cb7>
  263a4b:	add    $0x2,%r12
  263a4f:	mov    0x18(%rsp),%rcx
  263a54:	mov    %r12,0x30(%rcx)
  263a58:	mov    0x10(%rcx),%rsi
  263a5c:	mov    0x38(%rsp),%rdi
  263a61:	cmp    %rsi,%rdi
  263a64:	jb     263d04 <<glass::engine::Watch>::print_utf8+0x1f44>
  263a6a:	lea    0x364d2f(%rip),%rdx        # 5c87a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  263a71:	call   *0x38d381(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263a77:	cmp    $0xffffffff,%eax
  263a7a:	je     263cda <<glass::engine::Watch>::print_utf8+0x1f1a>
  263a80:	mov    0x18(%rsp),%rax
  263a85:	mov    0x10(%rax),%r15
  263a89:	cmp    %rbx,%r15
  263a8c:	mov    %rbx,%rax
  263a8f:	cmovb  %r15,%rax
  263a93:	mov    %rax,0x10(%rsp)
  263a98:	lea    0x1(%r12),%rcx
  263a9d:	cmp    %rcx,%r15
  263aa0:	cmovb  %r15,%rcx
  263aa4:	mov    0x38d455(%rip),%rax        # 5f0f00 <_DYNAMIC+0x320>
  263aab:	movzbl (%rax),%eax
  263aae:	test   %al,%al
  263ab0:	mov    %rcx,0x20(%rsp)
  263ab5:	je     263ae3 <<glass::engine::Watch>::print_utf8+0x1d23>
  263ab7:	cmp    %rcx,%rbx
  263aba:	jae    263ac5 <<glass::engine::Watch>::print_utf8+0x1d05>
  263abc:	mov    0x38d47d(%rip),%rax        # 5f0f40 <_DYNAMIC+0x360>
  263ac3:	jmp    263acc <<glass::engine::Watch>::print_utf8+0x1d0c>
  263ac5:	mov    0x38d46c(%rip),%rax        # 5f0f38 <_DYNAMIC+0x358>
  263acc:	lock incq 0x28(%rax)
  263ad1:	mov    %rcx,%rdi
  263ad4:	sub    0x10(%rsp),%rdi
  263ad9:	call   2f63e0 <alacritty_terminal::grid::row::fill_census::note>
  263ade:	mov    0x20(%rsp),%rcx
  263ae3:	cmp    %rcx,%rbx
  263ae6:	jae    263cb4 <<glass::engine::Watch>::print_utf8+0x1ef4>
  263aec:	mov    0x18(%rsp),%rcx
  263af1:	mov    0x28(%rcx),%edi
  263af4:	mov    0x20(%rcx),%r8d
  263af8:	mov    0x24(%rcx),%r9d
  263afc:	movzwl 0x2c(%rcx),%r10d
  263b01:	mov    0x18(%rcx),%r15
  263b05:	test   %r15,%r15
  263b08:	mov    %edi,0xc(%rsp)
  263b0c:	mov    %r8d,0x60(%rsp)
  263b11:	mov    %r9d,0x70(%rsp)
  263b16:	mov    %r10w,0x90(%rsp)
  263b1f:	je     263bde <<glass::engine::Watch>::print_utf8+0x1e1e>
  263b25:	lock incq (%r15)
  263b29:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  263b2f:	mov    0x10(%rcx),%rdx
  263b33:	mov    %edi,0x50(%rsp)
  263b37:	mov    %r8d,0x48(%rsp)
  263b3c:	mov    %r9d,0x4c(%rsp)
  263b41:	mov    %r10w,0x54(%rsp)
  263b47:	mov    %r15,0x40(%rsp)
  263b4c:	mov    0x20(%rsp),%rsi
  263b51:	cmp    %rdx,%rsi
  263b54:	ja     263e58 <<glass::engine::Watch>::print_utf8+0x2098>
  263b5a:	mov    0x10(%rsp),%rax
  263b5f:	lea    0x0(,%rax,8),%rax
  263b67:	lea    (%rax,%rax,2),%rax
  263b6b:	mov    0x8(%rcx),%rbx
  263b6f:	add    %rax,%rbx
  263b72:	lea    0x0(,%rsi,8),%rcx
  263b7a:	lea    (%rcx,%rcx,2),%r13
  263b7e:	sub    %rax,%r13
  263b81:	jmp    263ba4 <<glass::engine::Watch>::print_utf8+0x1de4>
  263b83:	mov    %r15,(%rbx)
  263b86:	mov    %r8d,0x8(%rbx)
  263b8a:	mov    %r9d,0xc(%rbx)
  263b8e:	mov    %edi,0x10(%rbx)
  263b91:	mov    %r10w,0x14(%rbx)
  263b96:	add    $0x18,%rbx
  263b9a:	add    $0xffffffffffffffe8,%r13
  263b9e:	je     263c76 <<glass::engine::Watch>::print_utf8+0x1eb6>
  263ba4:	lock incq (%r15)
  263ba8:	jle    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  263bae:	mov    (%rbx),%rax
  263bb1:	test   %rax,%rax
  263bb4:	je     263b83 <<glass::engine::Watch>::print_utf8+0x1dc3>
  263bb6:	lock decq (%rax)
  263bba:	jne    263b83 <<glass::engine::Watch>::print_utf8+0x1dc3>
  263bbc:	mov    %rbx,%rdi
  263bbf:	call   *0x38d283(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263bc5:	movzwl 0x90(%rsp),%r10d
  263bce:	mov    0x70(%rsp),%r9d
  263bd3:	mov    0x60(%rsp),%r8d
  263bd8:	mov    0xc(%rsp),%edi
  263bdc:	jmp    263b83 <<glass::engine::Watch>::print_utf8+0x1dc3>
  263bde:	mov    %edi,0x50(%rsp)
  263be2:	mov    %r8d,0x48(%rsp)
  263be7:	mov    %r9d,0x4c(%rsp)
  263bec:	mov    %r10w,0x54(%rsp)
  263bf2:	mov    %r15,0x40(%rsp)
  263bf7:	mov    0x10(%rsp),%rax
  263bfc:	lea    0x0(,%rax,8),%rax
  263c04:	lea    (%rax,%rax,2),%rax
  263c08:	mov    0x8(%rcx),%rbx
  263c0c:	add    %rax,%rbx
  263c0f:	mov    0x20(%rsp),%rcx
  263c14:	lea    0x0(,%rcx,8),%rcx
  263c1c:	lea    (%rcx,%rcx,2),%r13
  263c20:	sub    %rax,%r13
  263c23:	jmp    263c46 <<glass::engine::Watch>::print_utf8+0x1e86>
  263c25:	movq   $0x0,(%rbx)
  263c2c:	mov    %r8d,0x8(%rbx)
  263c30:	mov    %r9d,0xc(%rbx)
  263c34:	mov    %edi,0x10(%rbx)
  263c37:	mov    %r10w,0x14(%rbx)
  263c3c:	add    $0x18,%rbx
  263c40:	add    $0xffffffffffffffe8,%r13
  263c44:	je     263c76 <<glass::engine::Watch>::print_utf8+0x1eb6>
  263c46:	mov    (%rbx),%rax
  263c49:	test   %rax,%rax
  263c4c:	je     263c25 <<glass::engine::Watch>::print_utf8+0x1e65>
  263c4e:	lock decq (%rax)
  263c52:	jne    263c25 <<glass::engine::Watch>::print_utf8+0x1e65>
  263c54:	mov    %rbx,%rdi
  263c57:	call   *0x38d1eb(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263c5d:	movzwl 0x90(%rsp),%r10d
  263c66:	mov    0x70(%rsp),%r9d
  263c6b:	mov    0x60(%rsp),%r8d
  263c70:	mov    0xc(%rsp),%edi
  263c74:	jmp    263c25 <<glass::engine::Watch>::print_utf8+0x1e65>
  263c76:	mov    0x18(%rsp),%rbx
  263c7b:	mov    0x10(%rsp),%rax
  263c80:	cmp    %eax,0x38(%rbx)
  263c83:	jbe    263c88 <<glass::engine::Watch>::print_utf8+0x1ec8>
  263c85:	mov    %eax,0x38(%rbx)
  263c88:	test   %r15,%r15
  263c8b:	mov    0xc0(%rsp),%r13
  263c93:	mov    0x20(%rsp),%rcx
  263c98:	je     263cb0 <<glass::engine::Watch>::print_utf8+0x1ef0>
  263c9a:	lock decq (%r15)
  263c9e:	jne    263cb0 <<glass::engine::Watch>::print_utf8+0x1ef0>
  263ca0:	lea    0x40(%rsp),%rdi
  263ca5:	call   *0x38d19d(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263cab:	mov    0x20(%rsp),%rcx
  263cb0:	mov    0x10(%rbx),%r15
  263cb4:	cmp    %r15,%rcx
  263cb7:	mov    0xc8(%rsp),%r15
  263cbf:	jb     263cda <<glass::engine::Watch>::print_utf8+0x1f1a>
  263cc1:	mov    0x80(%rsp),%rdi
  263cc9:	call   1ad320 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263cce:	mov    0x18(%rsp),%rax
  263cd3:	movl   $0xffffffff,0x28(%rax)
  263cda:	mov    0x18(%rsp),%rcx
  263cdf:	mov    0x30(%rcx),%rax
  263ce3:	add    $0x2,%r12
  263ce7:	cmp    %rax,%r12
  263cea:	cmovbe %rax,%r12
  263cee:	mov    0x10(%rcx),%rsi
  263cf2:	mov    %r12,0x30(%rcx)
  263cf6:	mov    0x38(%rsp),%rdi
  263cfb:	cmp    %rsi,%rdi
  263cfe:	jae    263eb9 <<glass::engine::Watch>::print_utf8+0x20f9>
  263d04:	mov    0x8(%rcx),%rax
  263d08:	lea    (%rdi,%rdi,2),%rcx
  263d0c:	lea    (%rax,%rcx,8),%rbx
  263d10:	movl   $0x20,0x10(%rax,%rcx,8)
  263d18:	mov    0x28(%rsp),%edx
  263d1c:	mov    %edx,0x8(%rax,%rcx,8)
  263d20:	mov    0x78(%rsp),%edx
  263d24:	mov    %edx,0xc(%rax,%rcx,8)
  263d28:	mov    0x30(%rsp),%edx
  263d2c:	or     $0x40,%edx
  263d2f:	mov    %dx,0x14(%rax,%rcx,8)
  263d34:	mov    (%rax,%rcx,8),%rax
  263d38:	test   %rax,%rax
  263d3b:	je     263d4c <<glass::engine::Watch>::print_utf8+0x1f8c>
  263d3d:	lock decq (%rax)
  263d41:	jne    263d4c <<glass::engine::Watch>::print_utf8+0x1f8c>
  263d43:	mov    %rbx,%rdi
  263d46:	call   *0x38d0fc(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263d4c:	movq   $0x0,(%rbx)
  263d53:	mov    0xa0(%rsp),%rax
  263d5b:	cmp    0x58(%rsp),%rax
  263d60:	jb     263d6a <<glass::engine::Watch>::print_utf8+0x1faa>
  263d62:	dec    %rax
  263d65:	movb   $0x1,0x6c(%r14)
  263d6a:	mov    %rax,0x40(%r14)
  263d6e:	incq   0xa0(%r15)
  263d75:	mov    %ebp,0xb0(%r15)
  263d7c:	jmp    263655 <<glass::engine::Watch>::print_utf8+0x1895>
  263d81:	call   18b822 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  263d86:	mov    %ebp,%ebx
  263d88:	mov    0x390021(%rip),%rsi        # 5f3db0 <glass::engine::width_of::CACHE+0x8>
  263d8f:	cmp    %rbx,%rsi
  263d92:	ja     2634f2 <<glass::engine::Watch>::print_utf8+0x1732>
  263d98:	lea    0x366ba9(%rip),%rdx        # 5ca948 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17c88>
  263d9f:	mov    %rbx,%rdi
  263da2:	call   *0x38d050(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263da8:	lea    0x363e21(%rip),%rcx        # 5c7bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  263daf:	mov    0xa8(%rsp),%rdi
  263db7:	call   *0x38d1fb(%rip)        # 5f0fb8 <_DYNAMIC+0x3d8>
  263dbd:	jmp    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  263dc2:	lea    0x363e07(%rip),%rcx        # 5c7bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  263dc9:	call   *0x38d1e9(%rip)        # 5f0fb8 <_DYNAMIC+0x3d8>
  263dcf:	jmp    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  263dd4:	lea    0x3642ed(%rip),%rdx        # 5c80c8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15408>
  263ddb:	call   *0x38d017(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263de1:	lea    0x3642f8(%rip),%rax        # 5c80e0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15420>
  263de8:	jmp    263e09 <<glass::engine::Watch>::print_utf8+0x2049>
  263dea:	lea    0x364337(%rip),%rdx        # 5c8128 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15468>
  263df1:	mov    %rbx,%rdi
  263df4:	mov    0x30(%rsp),%rsi
  263df9:	call   *0x38cff9(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263dff:	mov    %rax,%rbx
  263e02:	lea    0x3642ef(%rip),%rax        # 5c80f8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15438>
  263e09:	mov    %rax,0xf0(%rsp)
  263e11:	mov    %rbx,%rdi
  263e14:	mov    0x30(%rsp),%rsi
  263e19:	mov    0xf0(%rsp),%rdx
  263e21:	call   *0x38cfd1(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263e27:	lea    0x363da2(%rip),%rcx        # 5c7bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  263e2e:	mov    0x10(%rsp),%rdi
  263e33:	call   *0x38d17f(%rip)        # 5f0fb8 <_DYNAMIC+0x3d8>
  263e39:	jmp    263e6a <<glass::engine::Watch>::print_utf8+0x20aa>
  263e3b:	lea    0x364406(%rip),%rdx        # 5c8248 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15588>
  263e42:	call   *0x38cfb0(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263e48:	lea    0x352459(%rip),%rdx        # 5b62a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  263e4f:	mov    %rbx,%rdi
  263e52:	call   *0x38cfa0(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263e58:	lea    0x363d71(%rip),%rcx        # 5c7bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f10>
  263e5f:	mov    0x10(%rsp),%rdi
  263e64:	call   *0x38d14e(%rip)        # 5f0fb8 <_DYNAMIC+0x3d8>
  263e6a:	ud2
  263e6c:	lea    0x352435(%rip),%rdx        # 5b62a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  263e73:	call   *0x38cf7f(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263e79:	lea    0x364920(%rip),%rdx        # 5c87a0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ae0>
  263e80:	mov    %rbx,%rdi
  263e83:	call   *0x38cf6f(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263e89:	lea    0x3648f8(%rip),%rdx        # 5c8788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  263e90:	mov    %rbx,%rdi
  263e93:	call   *0x38cf5f(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263e99:	lea    0x3648e8(%rip),%rdx        # 5c8788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  263ea0:	mov    %r12,%rdi
  263ea3:	call   *0x38cf4f(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263ea9:	lea    0x3523f8(%rip),%rdx        # 5b62a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  263eb0:	mov    %r12,%rdi
  263eb3:	call   *0x38cf3f(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263eb9:	lea    0x3648c8(%rip),%rdx        # 5c8788 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15ac8>
  263ec0:	call   *0x38cf32(%rip)        # 5f0df8 <_DYNAMIC+0x218>
  263ec6:	mov    %rax,%rbx
  263ec9:	lock decq (%r15)
  263ecd:	je     263ef6 <<glass::engine::Watch>::print_utf8+0x2136>
  263ecf:	jmp    263f04 <<glass::engine::Watch>::print_utf8+0x2144>
  263ed1:	mov    %rax,%rbx
  263ed4:	mov    0x38(%rsp),%rax
  263ed9:	jmp    263ef0 <<glass::engine::Watch>::print_utf8+0x2130>
  263edb:	mov    %rax,%rbx
  263ede:	mov    0x98(%rsp),%rax
  263ee6:	jmp    263ef0 <<glass::engine::Watch>::print_utf8+0x2130>
  263ee8:	mov    %rax,%rbx
  263eeb:	mov    0x68(%rsp),%rax
  263ef0:	lock decq (%rax)
  263ef4:	jne    263f04 <<glass::engine::Watch>::print_utf8+0x2144>
  263ef6:	mov    0x110(%rsp),%rdi
  263efe:	call   *0x38cf44(%rip)        # 5f0e48 <_DYNAMIC+0x268>
  263f04:	mov    %rbx,%rdi
  263f07:	call   5af5b0 <_Unwind_Resume@plt>
