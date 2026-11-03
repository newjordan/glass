000000000025ff50 <<glass::engine::Watch>::print_utf8>:
  25ff50:	55                   	push   %rbp
  25ff51:	41 57                	push   %r15
  25ff53:	41 56                	push   %r14
  25ff55:	41 55                	push   %r13
  25ff57:	41 54                	push   %r12
  25ff59:	53                   	push   %rbx
  25ff5a:	48 81 ec 18 01 00 00 	sub    $0x118,%rsp
  25ff61:	49 89 d5             	mov    %rdx,%r13
  25ff64:	49 89 ff             	mov    %rdi,%r15
  25ff67:	80 bf be 00 00 00 01 	cmpb   $0x1,0xbe(%rdi)
  25ff6e:	75 2b                	jne    25ff9b <<glass::engine::Watch>::print_utf8+0x4b>
  25ff70:	49 83 7f 38 00       	cmpq   $0x0,0x38(%r15)
  25ff75:	75 24                	jne    25ff9b <<glass::engine::Watch>::print_utf8+0x4b>
  25ff77:	49 8b 47 78          	mov    0x78(%r15),%rax
  25ff7b:	f6 80 c5 06 00 00 04 	testb  $0x4,0x6c5(%rax)
  25ff82:	75 17                	jne    25ff9b <<glass::engine::Watch>::print_utf8+0x4b>
  25ff84:	48 83 78 50 00       	cmpq   $0x0,0x50(%rax)
  25ff89:	75 10                	jne    25ff9b <<glass::engine::Watch>::print_utf8+0x4b>
  25ff8b:	0f b7 48 64          	movzwl 0x64(%rax),%ecx
  25ff8f:	f7 c1 60 04 00 00    	test   $0x460,%ecx
  25ff95:	0f 84 25 17 00 00    	je     2616c0 <<glass::engine::Watch>::print_utf8+0x1770>
  25ff9b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%rsp)
  25ffa2:	00 
  25ffa3:	c7 84 24 80 00 00 00 	movl   $0x0,0x80(%rsp)
  25ffaa:	00 00 00 00 
  25ffae:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
  25ffb4:	45 31 f6             	xor    %r14d,%r14d
  25ffb7:	48 8d 05 aa 0c 36 00 	lea    0x360caa(%rip),%rax        # 5c0c68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fe8>
  25ffbe:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
  25ffc5:	00 
  25ffc6:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  25ffcb:	48 89 84 24 10 01 00 	mov    %rax,0x110(%rsp)
  25ffd2:	00 
  25ffd3:	31 d2                	xor    %edx,%edx
  25ffd5:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
  25ffdc:	00 
  25ffdd:	4c 89 bc 24 c8 00 00 	mov    %r15,0xc8(%rsp)
  25ffe4:	00 
  25ffe5:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
  25ffea:	80 bc 24 80 00 00 00 	cmpb   $0x0,0x80(%rsp)
  25fff1:	00 
  25fff2:	0f 84 f1 0a 00 00    	je     260ae9 <<glass::engine::Watch>::print_utf8+0xb99>
  25fff8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  25ffff:	00 
  260000:	49 8b 5f 78          	mov    0x78(%r15),%rbx
  260004:	80 7b 6c 00          	cmpb   $0x0,0x6c(%rbx)
  260008:	0f 85 db 0a 00 00    	jne    260ae9 <<glass::engine::Watch>::print_utf8+0xb99>
  26000e:	8b 43 30             	mov    0x30(%rbx),%eax
  260011:	2b 43 48             	sub    0x48(%rbx),%eax
  260014:	48 98                	cltq
  260016:	48 8b 73 20          	mov    0x20(%rbx),%rsi
  26001a:	48 8b 4b 28          	mov    0x28(%rbx),%rcx
  26001e:	48 8d 3c 01          	lea    (%rcx,%rax,1),%rdi
  260022:	48 ff cf             	dec    %rdi
  260025:	48 39 f7             	cmp    %rsi,%rdi
  260028:	b8 00 00 00 00       	mov    $0x0,%eax
  26002d:	48 0f 43 c6          	cmovae %rsi,%rax
  260031:	48 29 c7             	sub    %rax,%rdi
  260034:	48 39 f7             	cmp    %rsi,%rdi
  260037:	0f 83 27 1f 00 00    	jae    261f64 <<glass::engine::Watch>::print_utf8+0x2014>
  26003d:	48 8b 83 a0 00 00 00 	mov    0xa0(%rbx),%rax
  260044:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  260049:	4c 8b 63 40          	mov    0x40(%rbx),%r12
  26004d:	8b 43 58             	mov    0x58(%rbx),%eax
  260050:	89 44 24 78          	mov    %eax,0x78(%rsp)
  260054:	8b 43 5c             	mov    0x5c(%rbx),%eax
  260057:	89 84 24 a0 00 00 00 	mov    %eax,0xa0(%rsp)
  26005e:	0f b7 43 64          	movzwl 0x64(%rbx),%eax
  260062:	89 44 24 0c          	mov    %eax,0xc(%rsp)
  260066:	48 8b 43 18          	mov    0x18(%rbx),%rax
  26006a:	48 c1 e7 06          	shl    $0x6,%rdi
  26006e:	48 8d 2c 38          	lea    (%rax,%rdi,1),%rbp
  260072:	44 39 64 38 38       	cmp    %r12d,0x38(%rax,%rdi,1)
  260077:	76 04                	jbe    26007d <<glass::engine::Watch>::print_utf8+0x12d>
  260079:	44 89 65 38          	mov    %r12d,0x38(%rbp)
  26007d:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
  260082:	44 8b 55 28          	mov    0x28(%rbp),%r10d
  260086:	41 83 fa ff          	cmp    $0xffffffff,%r10d
  26008a:	4c 89 64 24 60       	mov    %r12,0x60(%rsp)
  26008f:	0f 84 b4 00 00 00    	je     260149 <<glass::engine::Watch>::print_utf8+0x1f9>
  260095:	48 8b 45 30          	mov    0x30(%rbp),%rax
  260099:	49 39 c4             	cmp    %rax,%r12
  26009c:	b9 00 00 00 00       	mov    $0x0,%ecx
  2600a1:	48 0f 42 c8          	cmovb  %rax,%rcx
  2600a5:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
  2600aa:	c7 84 24 08 01 00 00 	movl   $0x20,0x108(%rsp)
  2600b1:	20 00 00 00 
  2600b5:	8b 4c 24 78          	mov    0x78(%rsp),%ecx
  2600b9:	89 8c 24 00 01 00 00 	mov    %ecx,0x100(%rsp)
  2600c0:	8b 8c 24 a0 00 00 00 	mov    0xa0(%rsp),%ecx
  2600c7:	89 8c 24 04 01 00 00 	mov    %ecx,0x104(%rsp)
  2600ce:	8b 4c 24 0c          	mov    0xc(%rsp),%ecx
  2600d2:	66 89 8c 24 0c 01 00 	mov    %cx,0x10c(%rsp)
  2600d9:	00 
  2600da:	48 c7 84 24 f8 00 00 	movq   $0x0,0xf8(%rsp)
  2600e1:	00 00 00 00 00 
  2600e6:	48 8b 4d 10          	mov    0x10(%rbp),%rcx
  2600ea:	48 39 c1             	cmp    %rax,%rcx
  2600ed:	48 89 c2             	mov    %rax,%rdx
  2600f0:	48 0f 42 d1          	cmovb  %rcx,%rdx
  2600f4:	48 89 54 24 68       	mov    %rdx,0x68(%rsp)
  2600f9:	4c 39 e1             	cmp    %r12,%rcx
  2600fc:	4d 89 e1             	mov    %r12,%r9
  2600ff:	4c 0f 42 c9          	cmovb  %rcx,%r9
  260103:	48 8b 15 36 95 38 00 	mov    0x389536(%rip),%rdx        # 5e9640 <_DYNAMIC+0x320>
  26010a:	0f b6 12             	movzbl (%rdx),%edx
  26010d:	84 d2                	test   %dl,%dl
  26010f:	0f 84 d5 00 00 00    	je     2601ea <<glass::engine::Watch>::print_utf8+0x29a>
  260115:	48 8b 15 5c 95 38 00 	mov    0x38955c(%rip),%rdx        # 5e9678 <_DYNAMIC+0x358>
  26011c:	4c 39 c8             	cmp    %r9,%rax
  26011f:	73 07                	jae    260128 <<glass::engine::Watch>::print_utf8+0x1d8>
  260121:	48 8b 15 58 95 38 00 	mov    0x389558(%rip),%rdx        # 5e9680 <_DYNAMIC+0x360>
  260128:	f0 48 ff 42 28       	lock incq 0x28(%rdx)
  26012d:	48 8b 15 24 95 38 00 	mov    0x389524(%rip),%rdx        # 5e9658 <_DYNAMIC+0x338>
  260134:	f0 48 ff 02          	lock incq (%rdx)
  260138:	4c 89 ca             	mov    %r9,%rdx
  26013b:	48 2b 54 24 68       	sub    0x68(%rsp),%rdx
  260140:	75 5d                	jne    26019f <<glass::engine::Watch>::print_utf8+0x24f>
  260142:	31 f6                	xor    %esi,%esi
  260144:	e9 95 00 00 00       	jmp    2601de <<glass::engine::Watch>::print_utf8+0x28e>
  260149:	c7 84 24 08 01 00 00 	movl   $0x20,0x108(%rsp)
  260150:	20 00 00 00 
  260154:	8b 44 24 78          	mov    0x78(%rsp),%eax
  260158:	89 84 24 00 01 00 00 	mov    %eax,0x100(%rsp)
  26015f:	8b 84 24 a0 00 00 00 	mov    0xa0(%rsp),%eax
  260166:	89 84 24 04 01 00 00 	mov    %eax,0x104(%rsp)
  26016d:	8b 44 24 0c          	mov    0xc(%rsp),%eax
  260171:	66 89 84 24 0c 01 00 	mov    %ax,0x10c(%rsp)
  260178:	00 
  260179:	48 c7 84 24 f8 00 00 	movq   $0x0,0xf8(%rsp)
  260180:	00 00 00 00 00 
  260185:	48 8d 45 30          	lea    0x30(%rbp),%rax
  260189:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
  260190:	00 
  260191:	48 c7 44 24 20 ff ff 	movq   $0xffffffffffffffff,0x20(%rsp)
  260198:	ff ff 
  26019a:	e9 db 01 00 00       	jmp    26037a <<glass::engine::Watch>::print_utf8+0x42a>
  26019f:	48 8b 35 ba 94 38 00 	mov    0x3894ba(%rip),%rsi        # 5e9660 <_DYNAMIC+0x340>
  2601a6:	f0 48 01 16          	lock add %rdx,(%rsi)
  2601aa:	48 83 fa 05          	cmp    $0x5,%rdx
  2601ae:	73 0e                	jae    2601be <<glass::engine::Watch>::print_utf8+0x26e>
  2601b0:	48 8d 35 11 cf df ff 	lea    -0x2030ef(%rip),%rsi        # 5d0c8 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2601b7:	0f b6 74 32 ff       	movzbl -0x1(%rdx,%rsi,1),%esi
  2601bc:	eb 20                	jmp    2601de <<glass::engine::Watch>::print_utf8+0x28e>
  2601be:	48 8d 7a fb          	lea    -0x5(%rdx),%rdi
  2601c2:	be 04 00 00 00       	mov    $0x4,%esi
  2601c7:	48 83 ff 04          	cmp    $0x4,%rdi
  2601cb:	72 11                	jb     2601de <<glass::engine::Watch>::print_utf8+0x28e>
  2601cd:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
  2601d1:	48 83 fa 08          	cmp    $0x8,%rdx
  2601d5:	be 06 00 00 00       	mov    $0x6,%esi
  2601da:	48 83 de 00          	sbb    $0x0,%rsi
  2601de:	48 8b 15 6b 94 38 00 	mov    0x38946b(%rip),%rdx        # 5e9650 <_DYNAMIC+0x330>
  2601e5:	f0 48 ff 04 f2       	lock incq (%rdx,%rsi,8)
  2601ea:	4c 39 c8             	cmp    %r9,%rax
  2601ed:	4c 89 44 24 58       	mov    %r8,0x58(%rsp)
  2601f2:	0f 83 47 01 00 00    	jae    26033f <<glass::engine::Watch>::print_utf8+0x3ef>
  2601f8:	48 89 9c 24 98 00 00 	mov    %rbx,0x98(%rsp)
  2601ff:	00 
  260200:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
  260205:	44 8b 6d 20          	mov    0x20(%rbp),%r13d
  260209:	8b 75 24             	mov    0x24(%rbp),%esi
  26020c:	0f b7 7d 2c          	movzwl 0x2c(%rbp),%edi
  260210:	4c 8b 65 18          	mov    0x18(%rbp),%r12
  260214:	4d 85 e4             	test   %r12,%r12
  260217:	74 0b                	je     260224 <<glass::engine::Watch>::print_utf8+0x2d4>
  260219:	f0 49 ff 04 24       	lock incq (%r12)
  26021e:	0f 8e d6 1d 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  260224:	44 89 54 24 50       	mov    %r10d,0x50(%rsp)
  260229:	44 89 6c 24 48       	mov    %r13d,0x48(%rsp)
  26022e:	89 74 24 4c          	mov    %esi,0x4c(%rsp)
  260232:	66 89 7c 24 54       	mov    %di,0x54(%rsp)
  260237:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
  26023c:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  260241:	48 8d 04 c5 00 00 00 	lea    0x0(,%rax,8),%rax
  260248:	00 
  260249:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  26024d:	48 89 ac 24 d0 00 00 	mov    %rbp,0xd0(%rsp)
  260254:	00 
  260255:	48 8b 5d 08          	mov    0x8(%rbp),%rbx
  260259:	48 01 c3             	add    %rax,%rbx
  26025c:	4a 8d 0c cd 00 00 00 	lea    0x0(,%r9,8),%rcx
  260263:	00 
  260264:	48 8d 2c 49          	lea    (%rcx,%rcx,2),%rbp
  260268:	48 29 c5             	sub    %rax,%rbp
  26026b:	89 74 24 70          	mov    %esi,0x70(%rsp)
  26026f:	66 89 bc 24 90 00 00 	mov    %di,0x90(%rsp)
  260276:	00 
  260277:	eb 23                	jmp    26029c <<glass::engine::Watch>::print_utf8+0x34c>
  260279:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  260280:	4c 89 23             	mov    %r12,(%rbx)
  260283:	44 89 6b 08          	mov    %r13d,0x8(%rbx)
  260287:	89 73 0c             	mov    %esi,0xc(%rbx)
  26028a:	44 89 53 10          	mov    %r10d,0x10(%rbx)
  26028e:	66 89 7b 14          	mov    %di,0x14(%rbx)
  260292:	48 83 c3 18          	add    $0x18,%rbx
  260296:	48 83 c5 e8          	add    $0xffffffffffffffe8,%rbp
  26029a:	74 46                	je     2602e2 <<glass::engine::Watch>::print_utf8+0x392>
  26029c:	4d 85 e4             	test   %r12,%r12
  26029f:	74 0b                	je     2602ac <<glass::engine::Watch>::print_utf8+0x35c>
  2602a1:	f0 49 ff 04 24       	lock incq (%r12)
  2602a6:	0f 8e 4e 1d 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  2602ac:	48 8b 03             	mov    (%rbx),%rax
  2602af:	48 85 c0             	test   %rax,%rax
  2602b2:	74 cc                	je     260280 <<glass::engine::Watch>::print_utf8+0x330>
  2602b4:	f0 48 ff 08          	lock decq (%rax)
  2602b8:	75 c6                	jne    260280 <<glass::engine::Watch>::print_utf8+0x330>
  2602ba:	48 89 df             	mov    %rbx,%rdi
  2602bd:	4d 89 ce             	mov    %r9,%r14
  2602c0:	45 89 d7             	mov    %r10d,%r15d
  2602c3:	ff 15 bf 92 38 00    	call   *0x3892bf(%rip)        # 5e9588 <_DYNAMIC+0x268>
  2602c9:	0f b7 bc 24 90 00 00 	movzwl 0x90(%rsp),%edi
  2602d0:	00 
  2602d1:	8b 74 24 70          	mov    0x70(%rsp),%esi
  2602d5:	45 89 fa             	mov    %r15d,%r10d
  2602d8:	4d 89 f1             	mov    %r14,%r9
  2602db:	4c 8b 44 24 58       	mov    0x58(%rsp),%r8
  2602e0:	eb 9e                	jmp    260280 <<glass::engine::Watch>::print_utf8+0x330>
  2602e2:	48 8b ac 24 d0 00 00 	mov    0xd0(%rsp),%rbp
  2602e9:	00 
  2602ea:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  2602ef:	39 45 38             	cmp    %eax,0x38(%rbp)
  2602f2:	76 03                	jbe    2602f7 <<glass::engine::Watch>::print_utf8+0x3a7>
  2602f4:	89 45 38             	mov    %eax,0x38(%rbp)
  2602f7:	4d 85 e4             	test   %r12,%r12
  2602fa:	4c 8b ac 24 c0 00 00 	mov    0xc0(%rsp),%r13
  260301:	00 
  260302:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
  260309:	00 
  26030a:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  26030f:	48 8b 9c 24 98 00 00 	mov    0x98(%rsp),%rbx
  260316:	00 
  260317:	74 1d                	je     260336 <<glass::engine::Watch>::print_utf8+0x3e6>
  260319:	f0 49 ff 0c 24       	lock decq (%r12)
  26031e:	75 16                	jne    260336 <<glass::engine::Watch>::print_utf8+0x3e6>
  260320:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  260325:	4d 89 cc             	mov    %r9,%r12
  260328:	ff 15 5a 92 38 00    	call   *0x38925a(%rip)        # 5e9588 <_DYNAMIC+0x268>
  26032e:	4d 89 e1             	mov    %r12,%r9
  260331:	4c 8b 44 24 58       	mov    0x58(%rsp),%r8
  260336:	48 8b 4d 10          	mov    0x10(%rbp),%rcx
  26033a:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
  26033f:	48 8d 45 30          	lea    0x30(%rbp),%rax
  260343:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
  26034a:	00 
  26034b:	49 39 c9             	cmp    %rcx,%r9
  26034e:	72 2a                	jb     26037a <<glass::engine::Watch>::print_utf8+0x42a>
  260350:	83 7d 28 ff          	cmpl   $0xffffffff,0x28(%rbp)
  260354:	74 1d                	je     260373 <<glass::engine::Watch>::print_utf8+0x423>
  260356:	48 8d 7d 18          	lea    0x18(%rbp),%rdi
  26035a:	48 8b 07             	mov    (%rdi),%rax
  26035d:	48 85 c0             	test   %rax,%rax
  260360:	74 11                	je     260373 <<glass::engine::Watch>::print_utf8+0x423>
  260362:	f0 48 ff 08          	lock decq (%rax)
  260366:	75 0b                	jne    260373 <<glass::engine::Watch>::print_utf8+0x423>
  260368:	ff 15 1a 92 38 00    	call   *0x38921a(%rip)        # 5e9588 <_DYNAMIC+0x268>
  26036e:	4c 8b 44 24 58       	mov    0x58(%rsp),%r8
  260373:	c7 45 28 ff ff ff ff 	movl   $0xffffffff,0x28(%rbp)
  26037a:	48 8b 55 10          	mov    0x10(%rbp),%rdx
  26037e:	48 8b 45 30          	mov    0x30(%rbp),%rax
  260382:	4c 39 e2             	cmp    %r12,%rdx
  260385:	4c 89 e6             	mov    %r12,%rsi
  260388:	48 0f 42 f2          	cmovb  %rdx,%rsi
  26038c:	48 39 c6             	cmp    %rax,%rsi
  26038f:	48 0f 47 c6          	cmova  %rsi,%rax
  260393:	48 89 d1             	mov    %rdx,%rcx
  260396:	48 89 45 30          	mov    %rax,0x30(%rbp)
  26039a:	4c 29 e1             	sub    %r12,%rcx
  26039d:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
  2603a2:	0f 82 46 15 00 00    	jb     2618ee <<glass::engine::Watch>::print_utf8+0x199e>
  2603a8:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  2603ad:	4c 39 ea             	cmp    %r13,%rdx
  2603b0:	0f 83 fa 05 00 00    	jae    2609b0 <<glass::engine::Watch>::print_utf8+0xa60>
  2603b6:	48 89 9c 24 98 00 00 	mov    %rbx,0x98(%rsp)
  2603bd:	00 
  2603be:	48 89 ac 24 d0 00 00 	mov    %rbp,0xd0(%rsp)
  2603c5:	00 
  2603c6:	48 8b 4d 08          	mov    0x8(%rbp),%rcx
  2603ca:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  2603ce:	48 89 4c 24 70       	mov    %rcx,0x70(%rsp)
  2603d3:	48 8d 04 c1          	lea    (%rcx,%rax,8),%rax
  2603d7:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  2603de:	00 
  2603df:	8b 44 24 0c          	mov    0xc(%rsp),%eax
  2603e3:	89 c1                	mov    %eax,%ecx
  2603e5:	83 c9 20             	or     $0x20,%ecx
  2603e8:	89 8c 24 8c 00 00 00 	mov    %ecx,0x8c(%rsp)
  2603ef:	83 c8 40             	or     $0x40,%eax
  2603f2:	89 84 24 a8 00 00 00 	mov    %eax,0xa8(%rsp)
  2603f9:	b0 01                	mov    $0x1,%al
  2603fb:	89 84 24 90 00 00 00 	mov    %eax,0x90(%rsp)
  260402:	45 31 db             	xor    %r11d,%r11d
  260405:	31 ff                	xor    %edi,%edi
  260407:	4c 89 e3             	mov    %r12,%rbx
  26040a:	4d 89 e2             	mov    %r12,%r10
  26040d:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  260412:	eb 6b                	jmp    26047f <<glass::engine::Watch>::print_utf8+0x52f>
  260414:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  26041b:	00 00 00 00 00 
  260420:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  260427:	8b 44 24 78          	mov    0x78(%rsp),%eax
  26042b:	89 43 08             	mov    %eax,0x8(%rbx)
  26042e:	8b 84 24 a0 00 00 00 	mov    0xa0(%rsp),%eax
  260435:	89 43 0c             	mov    %eax,0xc(%rbx)
  260438:	c7 43 10 20 00 00 00 	movl   $0x20,0x10(%rbx)
  26043f:	8b 84 24 a8 00 00 00 	mov    0xa8(%rsp),%eax
  260446:	66 89 43 14          	mov    %ax,0x14(%rbx)
  26044a:	c7 84 24 90 00 00 00 	movl   $0x0,0x90(%rsp)
  260451:	00 00 00 00 
  260455:	45 31 db             	xor    %r11d,%r11d
  260458:	4c 3b 4c 24 38       	cmp    0x38(%rsp),%r9
  26045d:	41 0f 93 c3          	setae  %r11b
  260461:	4d 89 ca             	mov    %r9,%r10
  260464:	4d 29 da             	sub    %r11,%r10
  260467:	48 ff c7             	inc    %rdi
  26046a:	4c 89 cb             	mov    %r9,%rbx
  26046d:	4c 01 fa             	add    %r15,%rdx
  260470:	41 89 e8             	mov    %ebp,%r8d
  260473:	4d 89 fe             	mov    %r15,%r14
  260476:	4c 39 ea             	cmp    %r13,%rdx
  260479:	0f 83 4e 05 00 00    	jae    2609cd <<glass::engine::Watch>::print_utf8+0xa7d>
  26047f:	49 89 d7             	mov    %rdx,%r15
  260482:	0f b6 2c 16          	movzbl (%rsi,%rdx,1),%ebp
  260486:	40 84 ed             	test   %bpl,%bpl
  260489:	78 25                	js     2604b0 <<glass::engine::Watch>::print_utf8+0x560>
  26048b:	ba 01 00 00 00       	mov    $0x1,%edx
  260490:	8d 45 81             	lea    -0x7f(%rbp),%eax
  260493:	83 f8 21             	cmp    $0x21,%eax
  260496:	0f 83 7c 01 00 00    	jae    260618 <<glass::engine::Watch>::print_utf8+0x6c8>
  26049c:	e9 23 05 00 00       	jmp    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  2604a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2604a8:	0f 1f 84 00 00 00 00 
  2604af:	00 
  2604b0:	8d 45 3e             	lea    0x3e(%rbp),%eax
  2604b3:	3c 1e                	cmp    $0x1e,%al
  2604b5:	73 29                	jae    2604e0 <<glass::engine::Watch>::print_utf8+0x590>
  2604b7:	49 8d 47 01          	lea    0x1(%r15),%rax
  2604bb:	4c 39 e8             	cmp    %r13,%rax
  2604be:	0f 83 00 05 00 00    	jae    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  2604c4:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
  2604c8:	3c c0                	cmp    $0xc0,%al
  2604ca:	0f 8d f4 04 00 00    	jge    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  2604d0:	83 e5 1f             	and    $0x1f,%ebp
  2604d3:	c1 e5 06             	shl    $0x6,%ebp
  2604d6:	ba 02 00 00 00       	mov    $0x2,%edx
  2604db:	e9 0b 01 00 00       	jmp    2605eb <<glass::engine::Watch>::print_utf8+0x69b>
  2604e0:	89 e8                	mov    %ebp,%eax
  2604e2:	24 f0                	and    $0xf0,%al
  2604e4:	3c e0                	cmp    $0xe0,%al
  2604e6:	75 18                	jne    260500 <<glass::engine::Watch>::print_utf8+0x5b0>
  2604e8:	b0 bf                	mov    $0xbf,%al
  2604ea:	81 fd e0 00 00 00    	cmp    $0xe0,%ebp
  2604f0:	74 31                	je     260523 <<glass::engine::Watch>::print_utf8+0x5d3>
  2604f2:	b1 80                	mov    $0x80,%cl
  2604f4:	81 fd ed 00 00 00    	cmp    $0xed,%ebp
  2604fa:	75 29                	jne    260525 <<glass::engine::Watch>::print_utf8+0x5d5>
  2604fc:	b0 9f                	mov    $0x9f,%al
  2604fe:	eb 25                	jmp    260525 <<glass::engine::Watch>::print_utf8+0x5d5>
  260500:	8d 45 10             	lea    0x10(%rbp),%eax
  260503:	3c 05                	cmp    $0x5,%al
  260505:	0f 83 b9 04 00 00    	jae    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  26050b:	b0 80                	mov    $0x80,%al
  26050d:	81 fd f4 00 00 00    	cmp    $0xf4,%ebp
  260513:	74 62                	je     260577 <<glass::engine::Watch>::print_utf8+0x627>
  260515:	b1 bf                	mov    $0xbf,%cl
  260517:	81 fd f0 00 00 00    	cmp    $0xf0,%ebp
  26051d:	75 5a                	jne    260579 <<glass::engine::Watch>::print_utf8+0x629>
  26051f:	b0 90                	mov    $0x90,%al
  260521:	eb 56                	jmp    260579 <<glass::engine::Watch>::print_utf8+0x629>
  260523:	b1 a0                	mov    $0xa0,%cl
  260525:	49 8d 57 01          	lea    0x1(%r15),%rdx
  260529:	4c 39 ea             	cmp    %r13,%rdx
  26052c:	0f 83 92 04 00 00    	jae    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  260532:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
  260536:	38 d1                	cmp    %dl,%cl
  260538:	0f 87 86 04 00 00    	ja     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  26053e:	38 c2                	cmp    %al,%dl
  260540:	0f 87 7e 04 00 00    	ja     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  260546:	49 8d 47 02          	lea    0x2(%r15),%rax
  26054a:	4c 39 e8             	cmp    %r13,%rax
  26054d:	0f 83 71 04 00 00    	jae    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  260553:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
  260557:	3c c0                	cmp    $0xc0,%al
  260559:	0f 8d 65 04 00 00    	jge    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  26055f:	0f b6 ca             	movzbl %dl,%ecx
  260562:	83 e1 3f             	and    $0x3f,%ecx
  260565:	c1 e1 06             	shl    $0x6,%ecx
  260568:	83 e5 0f             	and    $0xf,%ebp
  26056b:	c1 e5 0c             	shl    $0xc,%ebp
  26056e:	09 cd                	or     %ecx,%ebp
  260570:	ba 03 00 00 00       	mov    $0x3,%edx
  260575:	eb 74                	jmp    2605eb <<glass::engine::Watch>::print_utf8+0x69b>
  260577:	b1 8f                	mov    $0x8f,%cl
  260579:	49 8d 57 01          	lea    0x1(%r15),%rdx
  26057d:	4c 39 ea             	cmp    %r13,%rdx
  260580:	0f 83 3e 04 00 00    	jae    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  260586:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
  26058a:	38 d0                	cmp    %dl,%al
  26058c:	0f 87 32 04 00 00    	ja     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  260592:	38 ca                	cmp    %cl,%dl
  260594:	0f 87 2a 04 00 00    	ja     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  26059a:	49 8d 47 02          	lea    0x2(%r15),%rax
  26059e:	4c 39 e8             	cmp    %r13,%rax
  2605a1:	0f 83 1d 04 00 00    	jae    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  2605a7:	0f b6 0c 06          	movzbl (%rsi,%rax,1),%ecx
  2605ab:	80 f9 bf             	cmp    $0xbf,%cl
  2605ae:	0f 8f 10 04 00 00    	jg     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  2605b4:	49 8d 47 03          	lea    0x3(%r15),%rax
  2605b8:	4c 39 e8             	cmp    %r13,%rax
  2605bb:	0f 83 03 04 00 00    	jae    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  2605c1:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
  2605c5:	3c bf                	cmp    $0xbf,%al
  2605c7:	0f 8f f7 03 00 00    	jg     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  2605cd:	0f b6 d2             	movzbl %dl,%edx
  2605d0:	83 e1 3f             	and    $0x3f,%ecx
  2605d3:	c1 e1 06             	shl    $0x6,%ecx
  2605d6:	83 e2 3f             	and    $0x3f,%edx
  2605d9:	c1 e2 0c             	shl    $0xc,%edx
  2605dc:	83 e5 07             	and    $0x7,%ebp
  2605df:	c1 e5 12             	shl    $0x12,%ebp
  2605e2:	09 d5                	or     %edx,%ebp
  2605e4:	09 cd                	or     %ecx,%ebp
  2605e6:	ba 04 00 00 00       	mov    $0x4,%edx
  2605eb:	89 e9                	mov    %ebp,%ecx
  2605ed:	81 f1 00 d8 00 00    	xor    $0xd800,%ecx
  2605f3:	81 c1 00 00 ef ff    	add    $0xffef0000,%ecx
  2605f9:	81 f9 00 08 ef ff    	cmp    $0xffef0800,%ecx
  2605ff:	0f 82 bf 03 00 00    	jb     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  260605:	24 3f                	and    $0x3f,%al
  260607:	0f b6 c0             	movzbl %al,%eax
  26060a:	09 c5                	or     %eax,%ebp
  26060c:	8d 45 81             	lea    -0x7f(%rbp),%eax
  26060f:	83 f8 21             	cmp    $0x21,%eax
  260612:	0f 82 ac 03 00 00    	jb     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  260618:	41 83 f8 ff          	cmp    $0xffffffff,%r8d
  26061c:	74 22                	je     260640 <<glass::engine::Watch>::print_utf8+0x6f0>
  26061e:	41 8d 40 e0          	lea    -0x20(%r8),%eax
  260622:	83 f8 5f             	cmp    $0x5f,%eax
  260625:	73 29                	jae    260650 <<glass::engine::Watch>::print_utf8+0x700>
  260627:	b9 01 00 00 00       	mov    $0x1,%ecx
  26062c:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
  260631:	0f 85 14 01 00 00    	jne    26074b <<glass::engine::Watch>::print_utf8+0x7fb>
  260637:	e9 88 03 00 00       	jmp    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  26063c:	0f 1f 40 00          	nopl   0x0(%rax)
  260640:	49 89 d9             	mov    %rbx,%r9
  260643:	e9 25 fe ff ff       	jmp    26046d <<glass::engine::Watch>::print_utf8+0x51d>
  260648:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  26064f:	00 
  260650:	48 89 5c 24 68       	mov    %rbx,0x68(%rsp)
  260655:	8b 05 9d be 38 00    	mov    0x38be9d(%rip),%eax        # 5ec4f8 <glass::engine::width_of::CACHE+0x10>
  26065b:	85 c0                	test   %eax,%eax
  26065d:	0f 85 db 02 00 00    	jne    26093e <<glass::engine::Watch>::print_utf8+0x9ee>
  260663:	44 89 c3             	mov    %r8d,%ebx
  260666:	48 8b 35 83 be 38 00 	mov    0x38be83(%rip),%rsi        # 5ec4f0 <glass::engine::width_of::CACHE+0x8>
  26066d:	48 39 de             	cmp    %rbx,%rsi
  260670:	0f 86 b2 18 00 00    	jbe    261f28 <<glass::engine::Watch>::print_utf8+0x1fd8>
  260676:	4c 8b 25 6b be 38 00 	mov    0x38be6b(%rip),%r12        # 5ec4e8 <glass::engine::width_of::CACHE>
  26067d:	41 0f b6 04 1c       	movzbl (%r12,%rbx,1),%eax
  260682:	0f b6 c8             	movzbl %al,%ecx
  260685:	84 c9                	test   %cl,%cl
  260687:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
  26068c:	78 19                	js     2606a7 <<glass::engine::Watch>::print_utf8+0x757>
  26068e:	b2 01                	mov    $0x1,%dl
  260690:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  260695:	84 d2                	test   %dl,%dl
  260697:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  26069c:	0f 85 91 00 00 00    	jne    260733 <<glass::engine::Watch>::print_utf8+0x7e3>
  2606a2:	e9 86 03 00 00       	jmp    260a2d <<glass::engine::Watch>::print_utf8+0xadd>
  2606a7:	81 f9 fe 00 00 00    	cmp    $0xfe,%ecx
  2606ad:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  2606b2:	0f 84 95 03 00 00    	je     260a4d <<glass::engine::Watch>::print_utf8+0xafd>
  2606b8:	b0 fe                	mov    $0xfe,%al
  2606ba:	41 83 f8 7f          	cmp    $0x7f,%r8d
  2606be:	73 09                	jae    2606c9 <<glass::engine::Watch>::print_utf8+0x779>
  2606c0:	b9 01 00 00 00       	mov    $0x1,%ecx
  2606c5:	31 d2                	xor    %edx,%edx
  2606c7:	eb 59                	jmp    260722 <<glass::engine::Watch>::print_utf8+0x7d2>
  2606c9:	41 81 f8 a0 00 00 00 	cmp    $0xa0,%r8d
  2606d0:	72 4e                	jb     260720 <<glass::engine::Watch>::print_utf8+0x7d0>
  2606d2:	48 89 bc 24 b0 00 00 	mov    %rdi,0xb0(%rsp)
  2606d9:	00 
  2606da:	44 89 c7             	mov    %r8d,%edi
  2606dd:	4c 89 44 24 58       	mov    %r8,0x58(%rsp)
  2606e2:	4c 89 94 24 e8 00 00 	mov    %r10,0xe8(%rsp)
  2606e9:	00 
  2606ea:	4c 89 9c 24 e0 00 00 	mov    %r11,0xe0(%rsp)
  2606f1:	00 
  2606f2:	e8 89 5c 03 00       	call   296380 <unicode_width::tables::lookup_width>
  2606f7:	4c 8b 9c 24 e0 00 00 	mov    0xe0(%rsp),%r11
  2606fe:	00 
  2606ff:	4c 8b 94 24 e8 00 00 	mov    0xe8(%rsp),%r10
  260706:	00 
  260707:	48 8b bc 24 b0 00 00 	mov    0xb0(%rsp),%rdi
  26070e:	00 
  26070f:	4c 8b 44 24 58       	mov    0x58(%rsp),%r8
  260714:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  260719:	0f b6 c8             	movzbl %al,%ecx
  26071c:	b2 01                	mov    $0x1,%dl
  26071e:	eb 02                	jmp    260722 <<glass::engine::Watch>::print_utf8+0x7d2>
  260720:	31 d2                	xor    %edx,%edx
  260722:	41 88 04 1c          	mov    %al,(%r12,%rbx,1)
  260726:	84 d2                	test   %dl,%dl
  260728:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  26072d:	0f 84 fa 02 00 00    	je     260a2d <<glass::engine::Watch>::print_utf8+0xadd>
  260733:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
  260737:	48 83 f8 01          	cmp    $0x1,%rax
  26073b:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  260740:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
  260745:	0f 87 79 02 00 00    	ja     2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  26074b:	41 f6 c3 01          	test   $0x1,%r11b
  26074f:	0f 85 67 02 00 00    	jne    2609bc <<glass::engine::Watch>::print_utf8+0xa6c>
  260755:	4a 8d 04 11          	lea    (%rcx,%r10,1),%rax
  260759:	48 3b 44 24 38       	cmp    0x38(%rsp),%rax
  26075e:	0f 87 5d 02 00 00    	ja     2609c1 <<glass::engine::Watch>::print_utf8+0xa71>
  260764:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  260769:	49 89 d9             	mov    %rbx,%r9
  26076c:	4c 89 d3             	mov    %r10,%rbx
  26076f:	4c 29 e3             	sub    %r12,%rbx
  260772:	4c 3b 54 24 20       	cmp    0x20(%rsp),%r10
  260777:	73 67                	jae    2607e0 <<glass::engine::Watch>::print_utf8+0x890>
  260779:	48 3b 5c 24 30       	cmp    0x30(%rsp),%rbx
  26077e:	4c 8b 5c 24 70       	mov    0x70(%rsp),%r11
  260783:	0f 83 e8 17 00 00    	jae    261f71 <<glass::engine::Watch>::print_utf8+0x2021>
  260789:	4b 8d 04 52          	lea    (%r10,%r10,2),%rax
  26078d:	41 f6 44 c3 14 60    	testb  $0x60,0x14(%r11,%rax,8)
  260793:	0f 85 8f 02 00 00    	jne    260a28 <<glass::engine::Watch>::print_utf8+0xad8>
  260799:	4d 8d 24 c3          	lea    (%r11,%rax,8),%r12
  26079d:	48 83 f9 02          	cmp    $0x2,%rcx
  2607a1:	0f 85 cb 00 00 00    	jne    260872 <<glass::engine::Watch>::print_utf8+0x922>
  2607a7:	48 8d 43 01          	lea    0x1(%rbx),%rax
  2607ab:	48 3b 44 24 30       	cmp    0x30(%rsp),%rax
  2607b0:	0f 83 d9 17 00 00    	jae    261f8f <<glass::engine::Watch>::print_utf8+0x203f>
  2607b6:	4c 89 f1             	mov    %r14,%rcx
  2607b9:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  2607bd:	41 b6 01             	mov    $0x1,%r14b
  2607c0:	4c 8b ac 24 b8 00 00 	mov    0xb8(%rsp),%r13
  2607c7:	00 
  2607c8:	41 f6 44 c5 14 60    	testb  $0x60,0x14(%r13,%rax,8)
  2607ce:	44 8b ac 24 8c 00 00 	mov    0x8c(%rsp),%r13d
  2607d5:	00 
  2607d6:	74 36                	je     26080e <<glass::engine::Watch>::print_utf8+0x8be>
  2607d8:	e9 55 02 00 00       	jmp    260a32 <<glass::engine::Watch>::print_utf8+0xae2>
  2607dd:	0f 1f 00             	nopl   (%rax)
  2607e0:	48 3b 5c 24 30       	cmp    0x30(%rsp),%rbx
  2607e5:	4c 8b 5c 24 70       	mov    0x70(%rsp),%r11
  2607ea:	0f 83 b1 17 00 00    	jae    261fa1 <<glass::engine::Watch>::print_utf8+0x2051>
  2607f0:	4b 8d 04 52          	lea    (%r10,%r10,2),%rax
  2607f4:	4d 8d 24 c3          	lea    (%r11,%rax,8),%r12
  2607f8:	48 83 f9 02          	cmp    $0x2,%rcx
  2607fc:	41 0f 94 c6          	sete   %r14b
  260800:	44 8b 6c 24 0c       	mov    0xc(%rsp),%r13d
  260805:	44 0f 44 ac 24 8c 00 	cmove  0x8c(%rsp),%r13d
  26080c:	00 00 
  26080e:	49 8b 04 24          	mov    (%r12),%rax
  260812:	48 85 c0             	test   %rax,%rax
  260815:	74 79                	je     260890 <<glass::engine::Watch>::print_utf8+0x940>
  260817:	f0 48 ff 08          	lock decq (%rax)
  26081b:	75 73                	jne    260890 <<glass::engine::Watch>::print_utf8+0x940>
  26081d:	48 89 bc 24 b0 00 00 	mov    %rdi,0xb0(%rsp)
  260824:	00 
  260825:	4c 89 e7             	mov    %r12,%rdi
  260828:	4c 89 bc 24 e0 00 00 	mov    %r15,0xe0(%rsp)
  26082f:	00 
  260830:	4d 89 c7             	mov    %r8,%r15
  260833:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
  260838:	4c 89 94 24 e8 00 00 	mov    %r10,0xe8(%rsp)
  26083f:	00 
  260840:	ff 15 42 8d 38 00    	call   *0x388d42(%rip)        # 5e9588 <_DYNAMIC+0x268>
  260846:	4c 8b 5c 24 70       	mov    0x70(%rsp),%r11
  26084b:	4c 8b 94 24 e8 00 00 	mov    0xe8(%rsp),%r10
  260852:	00 
  260853:	48 8b bc 24 b0 00 00 	mov    0xb0(%rsp),%rdi
  26085a:	00 
  26085b:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  260860:	4d 89 f8             	mov    %r15,%r8
  260863:	4c 8b bc 24 e0 00 00 	mov    0xe0(%rsp),%r15
  26086a:	00 
  26086b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  260870:	eb 1e                	jmp    260890 <<glass::engine::Watch>::print_utf8+0x940>
  260872:	45 31 f6             	xor    %r14d,%r14d
  260875:	44 8b 6c 24 0c       	mov    0xc(%rsp),%r13d
  26087a:	49 8b 04 24          	mov    (%r12),%rax
  26087e:	48 85 c0             	test   %rax,%rax
  260881:	75 94                	jne    260817 <<glass::engine::Watch>::print_utf8+0x8c7>
  260883:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  26088a:	84 00 00 00 00 00 
  260890:	4b 8d 04 52          	lea    (%r10,%r10,2),%rax
  260894:	49 c7 04 24 00 00 00 	movq   $0x0,(%r12)
  26089b:	00 
  26089c:	8b 4c 24 78          	mov    0x78(%rsp),%ecx
  2608a0:	41 89 4c c3 08       	mov    %ecx,0x8(%r11,%rax,8)
  2608a5:	8b 8c 24 a0 00 00 00 	mov    0xa0(%rsp),%ecx
  2608ac:	41 89 4c c3 0c       	mov    %ecx,0xc(%r11,%rax,8)
  2608b1:	66 45 89 6c c3 14    	mov    %r13w,0x14(%r11,%rax,8)
  2608b7:	45 89 44 c3 10       	mov    %r8d,0x10(%r11,%rax,8)
  2608bc:	45 84 f6             	test   %r14b,%r14b
  2608bf:	4c 8b ac 24 c0 00 00 	mov    0xc0(%rsp),%r13
  2608c6:	00 
  2608c7:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
  2608cc:	4c 8b 4c 24 58       	mov    0x58(%rsp),%r9
  2608d1:	0f 84 7e fb ff ff    	je     260455 <<glass::engine::Watch>::print_utf8+0x505>
  2608d7:	48 ff c3             	inc    %rbx
  2608da:	48 3b 5c 24 30       	cmp    0x30(%rsp),%rbx
  2608df:	0f 83 95 16 00 00    	jae    261f7a <<glass::engine::Watch>::print_utf8+0x202a>
  2608e5:	48 8d 04 5b          	lea    (%rbx,%rbx,2),%rax
  2608e9:	48 8b 8c 24 b8 00 00 	mov    0xb8(%rsp),%rcx
  2608f0:	00 
  2608f1:	48 8d 1c c1          	lea    (%rcx,%rax,8),%rbx
  2608f5:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
  2608f9:	48 85 c0             	test   %rax,%rax
  2608fc:	0f 84 1e fb ff ff    	je     260420 <<glass::engine::Watch>::print_utf8+0x4d0>
  260902:	f0 48 ff 08          	lock decq (%rax)
  260906:	0f 85 14 fb ff ff    	jne    260420 <<glass::engine::Watch>::print_utf8+0x4d0>
  26090c:	4d 89 fd             	mov    %r15,%r13
  26090f:	49 89 ff             	mov    %rdi,%r15
  260912:	48 89 df             	mov    %rbx,%rdi
  260915:	49 89 d6             	mov    %rdx,%r14
  260918:	ff 15 6a 8c 38 00    	call   *0x388c6a(%rip)        # 5e9588 <_DYNAMIC+0x268>
  26091e:	4c 8b 4c 24 58       	mov    0x58(%rsp),%r9
  260923:	4c 89 ff             	mov    %r15,%rdi
  260926:	4d 89 ef             	mov    %r13,%r15
  260929:	4c 8b ac 24 c0 00 00 	mov    0xc0(%rsp),%r13
  260930:	00 
  260931:	4c 89 f2             	mov    %r14,%rdx
  260934:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  260939:	e9 e2 fa ff ff       	jmp    260420 <<glass::engine::Watch>::print_utf8+0x4d0>
  26093e:	4c 89 44 24 58       	mov    %r8,0x58(%rsp)
  260943:	4c 89 bc 24 e0 00 00 	mov    %r15,0xe0(%rsp)
  26094a:	00 
  26094b:	49 89 d7             	mov    %rdx,%r15
  26094e:	48 89 bc 24 b0 00 00 	mov    %rdi,0xb0(%rsp)
  260955:	00 
  260956:	4c 89 94 24 e8 00 00 	mov    %r10,0xe8(%rsp)
  26095d:	00 
  26095e:	4d 89 dc             	mov    %r11,%r12
  260961:	e8 3c 97 f2 ff       	call   18a0a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  260966:	4d 89 e3             	mov    %r12,%r11
  260969:	4c 8b 94 24 e8 00 00 	mov    0xe8(%rsp),%r10
  260970:	00 
  260971:	48 8b bc 24 b0 00 00 	mov    0xb0(%rsp),%rdi
  260978:	00 
  260979:	4c 89 fa             	mov    %r15,%rdx
  26097c:	4c 8b bc 24 e0 00 00 	mov    0xe0(%rsp),%r15
  260983:	00 
  260984:	4c 8b 44 24 58       	mov    0x58(%rsp),%r8
  260989:	44 89 c3             	mov    %r8d,%ebx
  26098c:	48 8b 35 5d bb 38 00 	mov    0x38bb5d(%rip),%rsi        # 5ec4f0 <glass::engine::width_of::CACHE+0x8>
  260993:	48 39 de             	cmp    %rbx,%rsi
  260996:	0f 87 da fc ff ff    	ja     260676 <<glass::engine::Watch>::print_utf8+0x726>
  26099c:	e9 87 15 00 00       	jmp    261f28 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2609a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2609a8:	0f 1f 84 00 00 00 00 
  2609af:	00 
  2609b0:	31 ff                	xor    %edi,%edi
  2609b2:	45 31 db             	xor    %r11d,%r11d
  2609b5:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  2609ba:	eb 58                	jmp    260a14 <<glass::engine::Watch>::print_utf8+0xac4>
  2609bc:	41 b3 01             	mov    $0x1,%r11b
  2609bf:	eb 03                	jmp    2609c4 <<glass::engine::Watch>::print_utf8+0xa74>
  2609c1:	45 31 db             	xor    %r11d,%r11d
  2609c4:	49 89 d9             	mov    %rbx,%r9
  2609c7:	44 89 c5             	mov    %r8d,%ebp
  2609ca:	4c 89 fa             	mov    %r15,%rdx
  2609cd:	4d 39 e1             	cmp    %r12,%r9
  2609d0:	76 15                	jbe    2609e7 <<glass::engine::Watch>::print_utf8+0xa97>
  2609d2:	48 8b 8c 24 d8 00 00 	mov    0xd8(%rsp),%rcx
  2609d9:	00 
  2609da:	48 8b 01             	mov    (%rcx),%rax
  2609dd:	49 39 c1             	cmp    %rax,%r9
  2609e0:	49 0f 47 c1          	cmova  %r9,%rax
  2609e4:	48 89 01             	mov    %rax,(%rcx)
  2609e7:	48 83 ff 08          	cmp    $0x8,%rdi
  2609eb:	0f 93 c0             	setae  %al
  2609ee:	f6 84 24 90 00 00 00 	testb  $0x1,0x90(%rsp)
  2609f5:	01 
  2609f6:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
  2609fd:	00 
  2609fe:	75 02                	jne    260a02 <<glass::engine::Watch>::print_utf8+0xab2>
  260a00:	31 c0                	xor    %eax,%eax
  260a02:	84 c0                	test   %al,%al
  260a04:	75 5c                	jne    260a62 <<glass::engine::Watch>::print_utf8+0xb12>
  260a06:	4d 89 d4             	mov    %r10,%r12
  260a09:	41 89 e8             	mov    %ebp,%r8d
  260a0c:	48 8b 9c 24 98 00 00 	mov    0x98(%rsp),%rbx
  260a13:	00 
  260a14:	4c 89 63 40          	mov    %r12,0x40(%rbx)
  260a18:	44 88 5b 6c          	mov    %r11b,0x6c(%rbx)
  260a1c:	49 01 bf a0 00 00 00 	add    %rdi,0xa0(%r15)
  260a23:	e9 c1 00 00 00       	jmp    260ae9 <<glass::engine::Watch>::print_utf8+0xb99>
  260a28:	45 31 db             	xor    %r11d,%r11d
  260a2b:	eb 9a                	jmp    2609c7 <<glass::engine::Watch>::print_utf8+0xa77>
  260a2d:	49 89 d9             	mov    %rbx,%r9
  260a30:	eb 20                	jmp    260a52 <<glass::engine::Watch>::print_utf8+0xb02>
  260a32:	45 31 db             	xor    %r11d,%r11d
  260a35:	44 89 c5             	mov    %r8d,%ebp
  260a38:	4c 89 fa             	mov    %r15,%rdx
  260a3b:	4c 8b ac 24 c0 00 00 	mov    0xc0(%rsp),%r13
  260a42:	00 
  260a43:	49 89 ce             	mov    %rcx,%r14
  260a46:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
  260a4b:	eb 80                	jmp    2609cd <<glass::engine::Watch>::print_utf8+0xa7d>
  260a4d:	4c 8b 4c 24 68       	mov    0x68(%rsp),%r9
  260a52:	44 89 c5             	mov    %r8d,%ebp
  260a55:	4c 89 fa             	mov    %r15,%rdx
  260a58:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
  260a5d:	e9 6b ff ff ff       	jmp    2609cd <<glass::engine::Watch>::print_utf8+0xa7d>
  260a62:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
  260a67:	41 0f b6 d3          	movzbl %r11b,%edx
  260a6b:	4c 01 d2             	add    %r10,%rdx
  260a6e:	48 89 bc 24 b0 00 00 	mov    %rdi,0xb0(%rsp)
  260a75:	00 
  260a76:	48 8b bc 24 d0 00 00 	mov    0xd0(%rsp),%rdi
  260a7d:	00 
  260a7e:	4c 89 e6             	mov    %r12,%rsi
  260a81:	48 8d 8c 24 f8 00 00 	lea    0xf8(%rsp),%rcx
  260a88:	00 
  260a89:	4d 89 d4             	mov    %r10,%r12
  260a8c:	4c 89 db             	mov    %r11,%rbx
  260a8f:	e8 4c e7 03 00       	call   29f1e0 <glass::engine::note_uniform_span>
  260a94:	49 89 db             	mov    %rbx,%r11
  260a97:	48 8b bc 24 b0 00 00 	mov    0xb0(%rsp),%rdi
  260a9e:	00 
  260a9f:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  260aa4:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  260aa9:	e9 5b ff ff ff       	jmp    260a09 <<glass::engine::Watch>::print_utf8+0xab9>
  260aae:	66 90                	xchg   %ax,%ax
  260ab0:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
  260ab7:	00 
  260ab8:	4c 89 ff             	mov    %r15,%rdi
  260abb:	89 ee                	mov    %ebp,%esi
  260abd:	4c 89 c3             	mov    %r8,%rbx
  260ac0:	49 89 d6             	mov    %rdx,%r14
  260ac3:	e8 e8 93 0d 00       	call   339eb0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  260ac8:	4c 89 f2             	mov    %r14,%rdx
  260acb:	49 89 d8             	mov    %rbx,%r8
  260ace:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  260ad3:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  260ad8:	4c 01 f2             	add    %r14,%rdx
  260adb:	80 bc 24 80 00 00 00 	cmpb   $0x0,0x80(%rsp)
  260ae2:	00 
  260ae3:	0f 85 17 f5 ff ff    	jne    260000 <<glass::engine::Watch>::print_utf8+0xb0>
  260ae9:	44 89 c5             	mov    %r8d,%ebp
  260aec:	4c 89 f3             	mov    %r14,%rbx
  260aef:	49 89 d6             	mov    %rdx,%r14
  260af2:	4c 39 ea             	cmp    %r13,%rdx
  260af5:	0f 83 d3 0a 00 00    	jae    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260afb:	46 0f b6 04 36       	movzbl (%rsi,%r14,1),%r8d
  260b00:	45 84 c0             	test   %r8b,%r8b
  260b03:	78 1b                	js     260b20 <<glass::engine::Watch>::print_utf8+0xbd0>
  260b05:	ba 01 00 00 00       	mov    $0x1,%edx
  260b0a:	41 8d 40 81          	lea    -0x7f(%r8),%eax
  260b0e:	83 f8 21             	cmp    $0x21,%eax
  260b11:	0f 83 91 01 00 00    	jae    260ca8 <<glass::engine::Watch>::print_utf8+0xd58>
  260b17:	e9 b2 0a 00 00       	jmp    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260b1c:	0f 1f 40 00          	nopl   0x0(%rax)
  260b20:	41 8d 40 3e          	lea    0x3e(%r8),%eax
  260b24:	3c 1e                	cmp    $0x1e,%al
  260b26:	73 38                	jae    260b60 <<glass::engine::Watch>::print_utf8+0xc10>
  260b28:	49 8d 46 01          	lea    0x1(%r14),%rax
  260b2c:	4c 39 e8             	cmp    %r13,%rax
  260b2f:	0f 83 99 0a 00 00    	jae    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260b35:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
  260b39:	3c c0                	cmp    $0xc0,%al
  260b3b:	0f 8d 8d 0a 00 00    	jge    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260b41:	41 83 e0 1f          	and    $0x1f,%r8d
  260b45:	41 c1 e0 06          	shl    $0x6,%r8d
  260b49:	ba 02 00 00 00       	mov    $0x2,%edx
  260b4e:	e9 25 01 00 00       	jmp    260c78 <<glass::engine::Watch>::print_utf8+0xd28>
  260b53:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  260b5a:	84 00 00 00 00 00 
  260b60:	44 89 c0             	mov    %r8d,%eax
  260b63:	24 f0                	and    $0xf0,%al
  260b65:	3c e0                	cmp    $0xe0,%al
  260b67:	75 1a                	jne    260b83 <<glass::engine::Watch>::print_utf8+0xc33>
  260b69:	b0 bf                	mov    $0xbf,%al
  260b6b:	41 81 f8 e0 00 00 00 	cmp    $0xe0,%r8d
  260b72:	74 35                	je     260ba9 <<glass::engine::Watch>::print_utf8+0xc59>
  260b74:	b1 80                	mov    $0x80,%cl
  260b76:	41 81 f8 ed 00 00 00 	cmp    $0xed,%r8d
  260b7d:	75 2c                	jne    260bab <<glass::engine::Watch>::print_utf8+0xc5b>
  260b7f:	b0 9f                	mov    $0x9f,%al
  260b81:	eb 28                	jmp    260bab <<glass::engine::Watch>::print_utf8+0xc5b>
  260b83:	41 8d 40 10          	lea    0x10(%r8),%eax
  260b87:	3c 05                	cmp    $0x5,%al
  260b89:	0f 83 3f 0a 00 00    	jae    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260b8f:	b0 80                	mov    $0x80,%al
  260b91:	41 81 f8 f4 00 00 00 	cmp    $0xf4,%r8d
  260b98:	74 66                	je     260c00 <<glass::engine::Watch>::print_utf8+0xcb0>
  260b9a:	b1 bf                	mov    $0xbf,%cl
  260b9c:	41 81 f8 f0 00 00 00 	cmp    $0xf0,%r8d
  260ba3:	75 5d                	jne    260c02 <<glass::engine::Watch>::print_utf8+0xcb2>
  260ba5:	b0 90                	mov    $0x90,%al
  260ba7:	eb 59                	jmp    260c02 <<glass::engine::Watch>::print_utf8+0xcb2>
  260ba9:	b1 a0                	mov    $0xa0,%cl
  260bab:	49 8d 56 01          	lea    0x1(%r14),%rdx
  260baf:	4c 39 ea             	cmp    %r13,%rdx
  260bb2:	0f 83 16 0a 00 00    	jae    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260bb8:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
  260bbc:	38 d1                	cmp    %dl,%cl
  260bbe:	0f 87 0a 0a 00 00    	ja     2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260bc4:	38 c2                	cmp    %al,%dl
  260bc6:	0f 87 02 0a 00 00    	ja     2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260bcc:	49 8d 46 02          	lea    0x2(%r14),%rax
  260bd0:	4c 39 e8             	cmp    %r13,%rax
  260bd3:	0f 83 f5 09 00 00    	jae    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260bd9:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
  260bdd:	3c c0                	cmp    $0xc0,%al
  260bdf:	0f 8d e9 09 00 00    	jge    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260be5:	0f b6 ca             	movzbl %dl,%ecx
  260be8:	83 e1 3f             	and    $0x3f,%ecx
  260beb:	c1 e1 06             	shl    $0x6,%ecx
  260bee:	41 83 e0 0f          	and    $0xf,%r8d
  260bf2:	41 c1 e0 0c          	shl    $0xc,%r8d
  260bf6:	41 09 c8             	or     %ecx,%r8d
  260bf9:	ba 03 00 00 00       	mov    $0x3,%edx
  260bfe:	eb 78                	jmp    260c78 <<glass::engine::Watch>::print_utf8+0xd28>
  260c00:	b1 8f                	mov    $0x8f,%cl
  260c02:	49 8d 56 01          	lea    0x1(%r14),%rdx
  260c06:	4c 39 ea             	cmp    %r13,%rdx
  260c09:	0f 83 bf 09 00 00    	jae    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260c0f:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
  260c13:	38 d0                	cmp    %dl,%al
  260c15:	0f 87 b3 09 00 00    	ja     2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260c1b:	38 ca                	cmp    %cl,%dl
  260c1d:	0f 87 ab 09 00 00    	ja     2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260c23:	49 8d 46 02          	lea    0x2(%r14),%rax
  260c27:	4c 39 e8             	cmp    %r13,%rax
  260c2a:	0f 83 9e 09 00 00    	jae    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260c30:	0f b6 0c 06          	movzbl (%rsi,%rax,1),%ecx
  260c34:	80 f9 bf             	cmp    $0xbf,%cl
  260c37:	0f 8f 91 09 00 00    	jg     2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260c3d:	49 8d 46 03          	lea    0x3(%r14),%rax
  260c41:	4c 39 e8             	cmp    %r13,%rax
  260c44:	0f 83 84 09 00 00    	jae    2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260c4a:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
  260c4e:	3c bf                	cmp    $0xbf,%al
  260c50:	0f 8f 78 09 00 00    	jg     2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260c56:	0f b6 d2             	movzbl %dl,%edx
  260c59:	83 e1 3f             	and    $0x3f,%ecx
  260c5c:	c1 e1 06             	shl    $0x6,%ecx
  260c5f:	83 e2 3f             	and    $0x3f,%edx
  260c62:	c1 e2 0c             	shl    $0xc,%edx
  260c65:	41 83 e0 07          	and    $0x7,%r8d
  260c69:	41 c1 e0 12          	shl    $0x12,%r8d
  260c6d:	41 09 d0             	or     %edx,%r8d
  260c70:	41 09 c8             	or     %ecx,%r8d
  260c73:	ba 04 00 00 00       	mov    $0x4,%edx
  260c78:	44 89 c1             	mov    %r8d,%ecx
  260c7b:	81 f1 00 d8 00 00    	xor    $0xd800,%ecx
  260c81:	81 c1 00 00 ef ff    	add    $0xffef0000,%ecx
  260c87:	81 f9 00 08 ef ff    	cmp    $0xffef0800,%ecx
  260c8d:	0f 82 3b 09 00 00    	jb     2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260c93:	24 3f                	and    $0x3f,%al
  260c95:	0f b6 c0             	movzbl %al,%eax
  260c98:	41 09 c0             	or     %eax,%r8d
  260c9b:	41 8d 40 81          	lea    -0x7f(%r8),%eax
  260c9f:	83 f8 21             	cmp    $0x21,%eax
  260ca2:	0f 82 26 09 00 00    	jb     2615ce <<glass::engine::Watch>::print_utf8+0x167e>
  260ca8:	83 fd ff             	cmp    $0xffffffff,%ebp
  260cab:	0f 84 df 08 00 00    	je     261590 <<glass::engine::Watch>::print_utf8+0x1640>
  260cb1:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
  260cb6:	8d 45 e0             	lea    -0x20(%rbp),%eax
  260cb9:	83 f8 5f             	cmp    $0x5f,%eax
  260cbc:	73 22                	jae    260ce0 <<glass::engine::Watch>::print_utf8+0xd90>
  260cbe:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  260cc4:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
  260cc9:	0f 84 e1 fd ff ff    	je     260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260ccf:	e9 b8 00 00 00       	jmp    260d8c <<glass::engine::Watch>::print_utf8+0xe3c>
  260cd4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  260cdb:	00 00 00 00 00 
  260ce0:	80 bc 24 80 00 00 00 	cmpb   $0x0,0x80(%rsp)
  260ce7:	00 
  260ce8:	0f 84 c2 fd ff ff    	je     260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260cee:	8b 05 04 b8 38 00    	mov    0x38b804(%rip),%eax        # 5ec4f8 <glass::engine::width_of::CACHE+0x10>
  260cf4:	85 c0                	test   %eax,%eax
  260cf6:	0f 85 aa 08 00 00    	jne    2615a6 <<glass::engine::Watch>::print_utf8+0x1656>
  260cfc:	89 eb                	mov    %ebp,%ebx
  260cfe:	48 8b 35 eb b7 38 00 	mov    0x38b7eb(%rip),%rsi        # 5ec4f0 <glass::engine::width_of::CACHE+0x8>
  260d05:	48 39 de             	cmp    %rbx,%rsi
  260d08:	0f 86 1a 12 00 00    	jbe    261f28 <<glass::engine::Watch>::print_utf8+0x1fd8>
  260d0e:	4c 8b 35 d3 b7 38 00 	mov    0x38b7d3(%rip),%r14        # 5ec4e8 <glass::engine::width_of::CACHE>
  260d15:	41 0f b6 04 1e       	movzbl (%r14,%rbx,1),%eax
  260d1a:	44 0f b6 e0          	movzbl %al,%r12d
  260d1e:	45 84 e4             	test   %r12b,%r12b
  260d21:	78 0b                	js     260d2e <<glass::engine::Watch>::print_utf8+0xdde>
  260d23:	b1 01                	mov    $0x1,%cl
  260d25:	84 c9                	test   %cl,%cl
  260d27:	75 54                	jne    260d7d <<glass::engine::Watch>::print_utf8+0xe2d>
  260d29:	e9 82 fd ff ff       	jmp    260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260d2e:	41 81 fc fe 00 00 00 	cmp    $0xfe,%r12d
  260d35:	0f 84 75 fd ff ff    	je     260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260d3b:	b0 fe                	mov    $0xfe,%al
  260d3d:	83 fd 7f             	cmp    $0x7f,%ebp
  260d40:	73 0a                	jae    260d4c <<glass::engine::Watch>::print_utf8+0xdfc>
  260d42:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  260d48:	31 c9                	xor    %ecx,%ecx
  260d4a:	eb 25                	jmp    260d71 <<glass::engine::Watch>::print_utf8+0xe21>
  260d4c:	81 fd a0 00 00 00    	cmp    $0xa0,%ebp
  260d52:	72 1b                	jb     260d6f <<glass::engine::Watch>::print_utf8+0xe1f>
  260d54:	89 ef                	mov    %ebp,%edi
  260d56:	4d 89 c7             	mov    %r8,%r15
  260d59:	49 89 d4             	mov    %rdx,%r12
  260d5c:	e8 1f 56 03 00       	call   296380 <unicode_width::tables::lookup_width>
  260d61:	4c 89 e2             	mov    %r12,%rdx
  260d64:	4d 89 f8             	mov    %r15,%r8
  260d67:	44 0f b6 e0          	movzbl %al,%r12d
  260d6b:	b1 01                	mov    $0x1,%cl
  260d6d:	eb 02                	jmp    260d71 <<glass::engine::Watch>::print_utf8+0xe21>
  260d6f:	31 c9                	xor    %ecx,%ecx
  260d71:	41 88 04 1e          	mov    %al,(%r14,%rbx,1)
  260d75:	84 c9                	test   %cl,%cl
  260d77:	0f 84 33 fd ff ff    	je     260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260d7d:	49 8d 44 24 ff       	lea    -0x1(%r12),%rax
  260d82:	48 83 f8 01          	cmp    $0x1,%rax
  260d86:	0f 87 24 fd ff ff    	ja     260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260d8c:	48 8b 84 24 c8 00 00 	mov    0xc8(%rsp),%rax
  260d93:	00 
  260d94:	4c 8b 48 78          	mov    0x78(%rax),%r9
  260d98:	41 80 79 6c 00       	cmpb   $0x0,0x6c(%r9)
  260d9d:	0f 85 0d fd ff ff    	jne    260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260da3:	49 8b 59 40          	mov    0x40(%r9),%rbx
  260da7:	4d 8b 99 a0 00 00 00 	mov    0xa0(%r9),%r11
  260dae:	4e 8d 14 23          	lea    (%rbx,%r12,1),%r10
  260db2:	4d 39 da             	cmp    %r11,%r10
  260db5:	0f 87 f5 fc ff ff    	ja     260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260dbb:	41 8b 41 30          	mov    0x30(%r9),%eax
  260dbf:	41 2b 41 48          	sub    0x48(%r9),%eax
  260dc3:	48 98                	cltq
  260dc5:	49 8b 71 20          	mov    0x20(%r9),%rsi
  260dc9:	49 8b 49 28          	mov    0x28(%r9),%rcx
  260dcd:	48 8d 3c 01          	lea    (%rcx,%rax,1),%rdi
  260dd1:	48 ff cf             	dec    %rdi
  260dd4:	48 39 f7             	cmp    %rsi,%rdi
  260dd7:	b8 00 00 00 00       	mov    $0x0,%eax
  260ddc:	48 0f 43 c6          	cmovae %rsi,%rax
  260de0:	48 29 c7             	sub    %rax,%rdi
  260de3:	48 39 f7             	cmp    %rsi,%rdi
  260de6:	0f 83 df 11 00 00    	jae    261fcb <<glass::engine::Watch>::print_utf8+0x207b>
  260dec:	41 8b 41 58          	mov    0x58(%r9),%eax
  260df0:	89 44 24 58          	mov    %eax,0x58(%rsp)
  260df4:	41 8b 41 5c          	mov    0x5c(%r9),%eax
  260df8:	89 84 24 a0 00 00 00 	mov    %eax,0xa0(%rsp)
  260dff:	45 0f b7 71 64       	movzwl 0x64(%r9),%r14d
  260e04:	49 8b 41 18          	mov    0x18(%r9),%rax
  260e08:	48 c1 e7 06          	shl    $0x6,%rdi
  260e0c:	4c 8d 3c 38          	lea    (%rax,%rdi,1),%r15
  260e10:	48 8d 0c 38          	lea    (%rax,%rdi,1),%rcx
  260e14:	48 83 c1 18          	add    $0x18,%rcx
  260e18:	48 89 4c 24 78       	mov    %rcx,0x78(%rsp)
  260e1d:	8b 44 38 28          	mov    0x28(%rax,%rdi,1),%eax
  260e21:	83 f8 ff             	cmp    $0xffffffff,%eax
  260e24:	74 0b                	je     260e31 <<glass::engine::Watch>::print_utf8+0xee1>
  260e26:	48 8b 4c 24 78       	mov    0x78(%rsp),%rcx
  260e2b:	49 3b 5f 30          	cmp    0x30(%r15),%rbx
  260e2f:	73 19                	jae    260e4a <<glass::engine::Watch>::print_utf8+0xefa>
  260e31:	49 8b 77 10          	mov    0x10(%r15),%rsi
  260e35:	48 39 f3             	cmp    %rsi,%rbx
  260e38:	0f 83 9a 11 00 00    	jae    261fd8 <<glass::engine::Watch>::print_utf8+0x2088>
  260e3e:	48 8d 0c 5b          	lea    (%rbx,%rbx,2),%rcx
  260e42:	48 c1 e1 03          	shl    $0x3,%rcx
  260e46:	49 03 4f 08          	add    0x8(%r15),%rcx
  260e4a:	f6 41 14 60          	testb  $0x60,0x14(%rcx)
  260e4e:	0f 85 5c fc ff ff    	jne    260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260e54:	49 83 fc 02          	cmp    $0x2,%r12
  260e58:	75 37                	jne    260e91 <<glass::engine::Watch>::print_utf8+0xf41>
  260e5a:	48 8d 7b 01          	lea    0x1(%rbx),%rdi
  260e5e:	83 f8 ff             	cmp    $0xffffffff,%eax
  260e61:	74 0b                	je     260e6e <<glass::engine::Watch>::print_utf8+0xf1e>
  260e63:	48 8b 4c 24 78       	mov    0x78(%rsp),%rcx
  260e68:	49 3b 7f 30          	cmp    0x30(%r15),%rdi
  260e6c:	73 19                	jae    260e87 <<glass::engine::Watch>::print_utf8+0xf37>
  260e6e:	49 8b 77 10          	mov    0x10(%r15),%rsi
  260e72:	48 39 f7             	cmp    %rsi,%rdi
  260e75:	0f 83 81 11 00 00    	jae    261ffc <<glass::engine::Watch>::print_utf8+0x20ac>
  260e7b:	48 8d 0c 7f          	lea    (%rdi,%rdi,2),%rcx
  260e7f:	48 c1 e1 03          	shl    $0x3,%rcx
  260e83:	49 03 4f 08          	add    0x8(%r15),%rcx
  260e87:	f6 41 14 60          	testb  $0x60,0x14(%rcx)
  260e8b:	0f 85 1f fc ff ff    	jne    260ab0 <<glass::engine::Watch>::print_utf8+0xb60>
  260e91:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
  260e96:	41 39 5f 38          	cmp    %ebx,0x38(%r15)
  260e9a:	76 04                	jbe    260ea0 <<glass::engine::Watch>::print_utf8+0xf50>
  260e9c:	41 89 5f 38          	mov    %ebx,0x38(%r15)
  260ea0:	44 89 74 24 0c       	mov    %r14d,0xc(%rsp)
  260ea5:	4c 89 9c 24 90 00 00 	mov    %r11,0x90(%rsp)
  260eac:	00 
  260ead:	83 f8 ff             	cmp    $0xffffffff,%eax
  260eb0:	0f 95 c2             	setne  %dl
  260eb3:	49 8b 4f 30          	mov    0x30(%r15),%rcx
  260eb7:	48 39 cb             	cmp    %rcx,%rbx
  260eba:	40 0f 94 c6          	sete   %sil
  260ebe:	40 84 f2             	test   %sil,%dl
  260ec1:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
  260ec6:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
  260ecb:	4c 89 4c 24 60       	mov    %r9,0x60(%rsp)
  260ed0:	4c 89 54 24 70       	mov    %r10,0x70(%rsp)
  260ed5:	75 77                	jne    260f4e <<glass::engine::Watch>::print_utf8+0xffe>
  260ed7:	83 f8 ff             	cmp    $0xffffffff,%eax
  260eda:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  260edf:	0f 84 b8 02 00 00    	je     26119d <<glass::engine::Watch>::print_utf8+0x124d>
  260ee5:	49 8b 47 10          	mov    0x10(%r15),%rax
  260ee9:	48 39 c8             	cmp    %rcx,%rax
  260eec:	48 89 ca             	mov    %rcx,%rdx
  260eef:	48 0f 42 d0          	cmovb  %rax,%rdx
  260ef3:	48 89 94 24 a8 00 00 	mov    %rdx,0xa8(%rsp)
  260efa:	00 
  260efb:	48 39 d8             	cmp    %rbx,%rax
  260efe:	48 89 de             	mov    %rbx,%rsi
  260f01:	48 0f 42 f0          	cmovb  %rax,%rsi
  260f05:	48 8b 15 34 87 38 00 	mov    0x388734(%rip),%rdx        # 5e9640 <_DYNAMIC+0x320>
  260f0c:	0f b6 12             	movzbl (%rdx),%edx
  260f0f:	84 d2                	test   %dl,%dl
  260f11:	0f 84 a4 00 00 00    	je     260fbb <<glass::engine::Watch>::print_utf8+0x106b>
  260f17:	48 8b 15 5a 87 38 00 	mov    0x38875a(%rip),%rdx        # 5e9678 <_DYNAMIC+0x358>
  260f1e:	49 89 f3             	mov    %rsi,%r11
  260f21:	48 39 f1             	cmp    %rsi,%rcx
  260f24:	73 07                	jae    260f2d <<glass::engine::Watch>::print_utf8+0xfdd>
  260f26:	48 8b 15 53 87 38 00 	mov    0x388753(%rip),%rdx        # 5e9680 <_DYNAMIC+0x360>
  260f2d:	f0 48 ff 42 28       	lock incq 0x28(%rdx)
  260f32:	48 8b 15 1f 87 38 00 	mov    0x38871f(%rip),%rdx        # 5e9658 <_DYNAMIC+0x338>
  260f39:	f0 48 ff 02          	lock incq (%rdx)
  260f3d:	4c 89 da             	mov    %r11,%rdx
  260f40:	48 2b 94 24 a8 00 00 	sub    0xa8(%rsp),%rdx
  260f47:	00 
  260f48:	75 23                	jne    260f6d <<glass::engine::Watch>::print_utf8+0x101d>
  260f4a:	31 f6                	xor    %esi,%esi
  260f4c:	eb 5e                	jmp    260fac <<glass::engine::Watch>::print_utf8+0x105c>
  260f4e:	48 8d 43 01          	lea    0x1(%rbx),%rax
  260f52:	49 89 47 30          	mov    %rax,0x30(%r15)
  260f56:	49 8b 77 10          	mov    0x10(%r15),%rsi
  260f5a:	48 39 f3             	cmp    %rsi,%rbx
  260f5d:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  260f62:	0f 82 55 02 00 00    	jb     2611bd <<glass::engine::Watch>::print_utf8+0x126d>
  260f68:	e9 9c 10 00 00       	jmp    262009 <<glass::engine::Watch>::print_utf8+0x20b9>
  260f6d:	48 8b 35 ec 86 38 00 	mov    0x3886ec(%rip),%rsi        # 5e9660 <_DYNAMIC+0x340>
  260f74:	f0 48 01 16          	lock add %rdx,(%rsi)
  260f78:	48 83 fa 05          	cmp    $0x5,%rdx
  260f7c:	73 0e                	jae    260f8c <<glass::engine::Watch>::print_utf8+0x103c>
  260f7e:	48 8d 35 43 c1 df ff 	lea    -0x203ebd(%rip),%rsi        # 5d0c8 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  260f85:	0f b6 74 32 ff       	movzbl -0x1(%rdx,%rsi,1),%esi
  260f8a:	eb 20                	jmp    260fac <<glass::engine::Watch>::print_utf8+0x105c>
  260f8c:	48 8d 7a fb          	lea    -0x5(%rdx),%rdi
  260f90:	be 04 00 00 00       	mov    $0x4,%esi
  260f95:	48 83 ff 04          	cmp    $0x4,%rdi
  260f99:	72 11                	jb     260fac <<glass::engine::Watch>::print_utf8+0x105c>
  260f9b:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
  260f9f:	48 83 fa 08          	cmp    $0x8,%rdx
  260fa3:	be 06 00 00 00       	mov    $0x6,%esi
  260fa8:	48 83 de 00          	sbb    $0x0,%rsi
  260fac:	48 8b 15 9d 86 38 00 	mov    0x38869d(%rip),%rdx        # 5e9650 <_DYNAMIC+0x330>
  260fb3:	f0 48 ff 04 f2       	lock incq (%rdx,%rsi,8)
  260fb8:	4c 89 de             	mov    %r11,%rsi
  260fbb:	48 39 f1             	cmp    %rsi,%rcx
  260fbe:	0f 83 97 01 00 00    	jae    26115b <<glass::engine::Watch>::print_utf8+0x120b>
  260fc4:	41 8b 7f 28          	mov    0x28(%r15),%edi
  260fc8:	45 8b 57 20          	mov    0x20(%r15),%r10d
  260fcc:	45 8b 5f 24          	mov    0x24(%r15),%r11d
  260fd0:	41 0f b7 4f 2c       	movzwl 0x2c(%r15),%ecx
  260fd5:	49 8b 47 18          	mov    0x18(%r15),%rax
  260fd9:	48 85 c0             	test   %rax,%rax
  260fdc:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  260fe1:	74 33                	je     261016 <<glass::engine::Watch>::print_utf8+0x10c6>
  260fe3:	f0 48 ff 00          	lock incq (%rax)
  260fe7:	0f 8e 0d 10 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  260fed:	49 8b 57 10          	mov    0x10(%r15),%rdx
  260ff1:	89 7c 24 50          	mov    %edi,0x50(%rsp)
  260ff5:	44 89 54 24 48       	mov    %r10d,0x48(%rsp)
  260ffa:	44 89 5c 24 4c       	mov    %r11d,0x4c(%rsp)
  260fff:	41 89 c9             	mov    %ecx,%r9d
  261002:	66 89 4c 24 54       	mov    %cx,0x54(%rsp)
  261007:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
  26100c:	48 39 d6             	cmp    %rdx,%rsi
  26100f:	76 20                	jbe    261031 <<glass::engine::Watch>::print_utf8+0x10e1>
  261011:	e9 22 0f 00 00       	jmp    261f38 <<glass::engine::Watch>::print_utf8+0x1fe8>
  261016:	89 7c 24 50          	mov    %edi,0x50(%rsp)
  26101a:	44 89 54 24 48       	mov    %r10d,0x48(%rsp)
  26101f:	44 89 5c 24 4c       	mov    %r11d,0x4c(%rsp)
  261024:	66 89 4c 24 54       	mov    %cx,0x54(%rsp)
  261029:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
  26102e:	41 89 c9             	mov    %ecx,%r9d
  261031:	48 8b 84 24 a8 00 00 	mov    0xa8(%rsp),%rax
  261038:	00 
  261039:	48 8d 04 c5 00 00 00 	lea    0x0(,%rax,8),%rax
  261040:	00 
  261041:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  261045:	49 8b 5f 08          	mov    0x8(%r15),%rbx
  261049:	48 01 c3             	add    %rax,%rbx
  26104c:	48 89 b4 24 d0 00 00 	mov    %rsi,0xd0(%rsp)
  261053:	00 
  261054:	48 8d 0c f5 00 00 00 	lea    0x0(,%rsi,8),%rcx
  26105b:	00 
  26105c:	4c 8d 34 49          	lea    (%rcx,%rcx,2),%r14
  261060:	49 29 c6             	sub    %rax,%r14
  261063:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
  261068:	89 bc 24 98 00 00 00 	mov    %edi,0x98(%rsp)
  26106f:	44 89 94 24 8c 00 00 	mov    %r10d,0x8c(%rsp)
  261076:	00 
  261077:	44 89 9c 24 b8 00 00 	mov    %r11d,0xb8(%rsp)
  26107e:	00 
  26107f:	66 44 89 8c 24 d8 00 	mov    %r9w,0xd8(%rsp)
  261086:	00 00 
  261088:	eb 23                	jmp    2610ad <<glass::engine::Watch>::print_utf8+0x115d>
  26108a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  261090:	48 89 0b             	mov    %rcx,(%rbx)
  261093:	44 89 53 08          	mov    %r10d,0x8(%rbx)
  261097:	44 89 5b 0c          	mov    %r11d,0xc(%rbx)
  26109b:	89 7b 10             	mov    %edi,0x10(%rbx)
  26109e:	66 44 89 4b 14       	mov    %r9w,0x14(%rbx)
  2610a3:	48 83 c3 18          	add    $0x18,%rbx
  2610a7:	49 83 c6 e8          	add    $0xffffffffffffffe8,%r14
  2610ab:	74 58                	je     261105 <<glass::engine::Watch>::print_utf8+0x11b5>
  2610ad:	48 85 c9             	test   %rcx,%rcx
  2610b0:	74 0a                	je     2610bc <<glass::engine::Watch>::print_utf8+0x116c>
  2610b2:	f0 48 ff 01          	lock incq (%rcx)
  2610b6:	0f 8e 3e 0f 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  2610bc:	48 8b 03             	mov    (%rbx),%rax
  2610bf:	48 85 c0             	test   %rax,%rax
  2610c2:	74 cc                	je     261090 <<glass::engine::Watch>::print_utf8+0x1140>
  2610c4:	f0 48 ff 08          	lock decq (%rax)
  2610c8:	75 c6                	jne    261090 <<glass::engine::Watch>::print_utf8+0x1140>
  2610ca:	48 89 df             	mov    %rbx,%rdi
  2610cd:	4d 89 c7             	mov    %r8,%r15
  2610d0:	ff 15 b2 84 38 00    	call   *0x3884b2(%rip)        # 5e9588 <_DYNAMIC+0x268>
  2610d6:	44 0f b7 8c 24 d8 00 	movzwl 0xd8(%rsp),%r9d
  2610dd:	00 00 
  2610df:	44 8b 9c 24 b8 00 00 	mov    0xb8(%rsp),%r11d
  2610e6:	00 
  2610e7:	44 8b 94 24 8c 00 00 	mov    0x8c(%rsp),%r10d
  2610ee:	00 
  2610ef:	8b bc 24 98 00 00 00 	mov    0x98(%rsp),%edi
  2610f6:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
  2610fb:	4d 89 f8             	mov    %r15,%r8
  2610fe:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
  261103:	eb 8b                	jmp    261090 <<glass::engine::Watch>::print_utf8+0x1140>
  261105:	48 8b 84 24 a8 00 00 	mov    0xa8(%rsp),%rax
  26110c:	00 
  26110d:	41 39 47 38          	cmp    %eax,0x38(%r15)
  261111:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  261116:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
  26111b:	76 04                	jbe    261121 <<glass::engine::Watch>::print_utf8+0x11d1>
  26111d:	41 89 47 38          	mov    %eax,0x38(%r15)
  261121:	48 85 c9             	test   %rcx,%rcx
  261124:	48 8b b4 24 d0 00 00 	mov    0xd0(%rsp),%rsi
  26112b:	00 
  26112c:	74 29                	je     261157 <<glass::engine::Watch>::print_utf8+0x1207>
  26112e:	f0 48 ff 09          	lock decq (%rcx)
  261132:	75 23                	jne    261157 <<glass::engine::Watch>::print_utf8+0x1207>
  261134:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  261139:	4c 89 c3             	mov    %r8,%rbx
  26113c:	ff 15 46 84 38 00    	call   *0x388446(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261142:	48 8b b4 24 d0 00 00 	mov    0xd0(%rsp),%rsi
  261149:	00 
  26114a:	49 89 d8             	mov    %rbx,%r8
  26114d:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
  261152:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
  261157:	49 8b 47 10          	mov    0x10(%r15),%rax
  26115b:	48 39 c6             	cmp    %rax,%rsi
  26115e:	72 3d                	jb     26119d <<glass::engine::Watch>::print_utf8+0x124d>
  261160:	41 83 7f 28 ff       	cmpl   $0xffffffff,0x28(%r15)
  261165:	74 2e                	je     261195 <<glass::engine::Watch>::print_utf8+0x1245>
  261167:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  26116c:	48 8b 00             	mov    (%rax),%rax
  26116f:	48 85 c0             	test   %rax,%rax
  261172:	74 21                	je     261195 <<glass::engine::Watch>::print_utf8+0x1245>
  261174:	f0 48 ff 08          	lock decq (%rax)
  261178:	75 1b                	jne    261195 <<glass::engine::Watch>::print_utf8+0x1245>
  26117a:	48 8b 7c 24 78       	mov    0x78(%rsp),%rdi
  26117f:	4c 89 c3             	mov    %r8,%rbx
  261182:	ff 15 00 84 38 00    	call   *0x388400(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261188:	49 89 d8             	mov    %rbx,%r8
  26118b:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
  261190:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
  261195:	41 c7 47 28 ff ff ff 	movl   $0xffffffff,0x28(%r15)
  26119c:	ff 
  26119d:	49 8b 47 30          	mov    0x30(%r15),%rax
  2611a1:	48 8d 4b 01          	lea    0x1(%rbx),%rcx
  2611a5:	48 39 c1             	cmp    %rax,%rcx
  2611a8:	48 0f 47 c1          	cmova  %rcx,%rax
  2611ac:	49 8b 77 10          	mov    0x10(%r15),%rsi
  2611b0:	49 89 47 30          	mov    %rax,0x30(%r15)
  2611b4:	48 39 f3             	cmp    %rsi,%rbx
  2611b7:	0f 83 5c 0e 00 00    	jae    262019 <<glass::engine::Watch>::print_utf8+0x20c9>
  2611bd:	8b 74 24 0c          	mov    0xc(%rsp),%esi
  2611c1:	89 f0                	mov    %esi,%eax
  2611c3:	83 c8 20             	or     $0x20,%eax
  2611c6:	49 83 fc 02          	cmp    $0x2,%r12
  2611ca:	49 8b 4f 08          	mov    0x8(%r15),%rcx
  2611ce:	48 8d 14 5b          	lea    (%rbx,%rbx,2),%rdx
  2611d2:	48 8d 1c d1          	lea    (%rcx,%rdx,8),%rbx
  2611d6:	89 6c d1 10          	mov    %ebp,0x10(%rcx,%rdx,8)
  2611da:	8b 6c 24 58          	mov    0x58(%rsp),%ebp
  2611de:	89 6c d1 08          	mov    %ebp,0x8(%rcx,%rdx,8)
  2611e2:	0f 45 c6             	cmovne %esi,%eax
  2611e5:	8b b4 24 a0 00 00 00 	mov    0xa0(%rsp),%esi
  2611ec:	89 74 d1 0c          	mov    %esi,0xc(%rcx,%rdx,8)
  2611f0:	66 89 44 d1 14       	mov    %ax,0x14(%rcx,%rdx,8)
  2611f5:	48 8b 04 d1          	mov    (%rcx,%rdx,8),%rax
  2611f9:	48 85 c0             	test   %rax,%rax
  2611fc:	74 1a                	je     261218 <<glass::engine::Watch>::print_utf8+0x12c8>
  2611fe:	f0 48 ff 08          	lock decq (%rax)
  261202:	75 14                	jne    261218 <<glass::engine::Watch>::print_utf8+0x12c8>
  261204:	48 89 df             	mov    %rbx,%rdi
  261207:	4d 89 c7             	mov    %r8,%r15
  26120a:	ff 15 78 83 38 00    	call   *0x388378(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261210:	4d 89 f8             	mov    %r15,%r8
  261213:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
  261218:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  26121f:	49 83 fc 02          	cmp    $0x2,%r12
  261223:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  261228:	0f 85 2a 03 00 00    	jne    261558 <<glass::engine::Watch>::print_utf8+0x1608>
  26122e:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
  261233:	4d 8d 61 01          	lea    0x1(%r9),%r12
  261237:	49 8b 47 30          	mov    0x30(%r15),%rax
  26123b:	41 8b 4f 28          	mov    0x28(%r15),%ecx
  26123f:	49 39 c4             	cmp    %rax,%r12
  261242:	75 1f                	jne    261263 <<glass::engine::Watch>::print_utf8+0x1313>
  261244:	83 f9 ff             	cmp    $0xffffffff,%ecx
  261247:	74 1a                	je     261263 <<glass::engine::Watch>::print_utf8+0x1313>
  261249:	49 83 c1 02          	add    $0x2,%r9
  26124d:	4d 89 4f 30          	mov    %r9,0x30(%r15)
  261251:	49 8b 77 10          	mov    0x10(%r15),%rsi
  261255:	49 39 f4             	cmp    %rsi,%r12
  261258:	0f 82 a1 02 00 00    	jb     2614ff <<glass::engine::Watch>::print_utf8+0x15af>
  26125e:	e9 7b 06 00 00       	jmp    2618de <<glass::engine::Watch>::print_utf8+0x198e>
  261263:	83 f9 ff             	cmp    $0xffffffff,%ecx
  261266:	0f 84 73 02 00 00    	je     2614df <<glass::engine::Watch>::print_utf8+0x158f>
  26126c:	49 8b 4f 10          	mov    0x10(%r15),%rcx
  261270:	48 39 c1             	cmp    %rax,%rcx
  261273:	48 89 c7             	mov    %rax,%rdi
  261276:	48 0f 42 f9          	cmovb  %rcx,%rdi
  26127a:	4c 39 e1             	cmp    %r12,%rcx
  26127d:	4d 89 e2             	mov    %r12,%r10
  261280:	4c 0f 42 d1          	cmovb  %rcx,%r10
  261284:	48 8b 15 b5 83 38 00 	mov    0x3883b5(%rip),%rdx        # 5e9640 <_DYNAMIC+0x320>
  26128b:	0f b6 12             	movzbl (%rdx),%edx
  26128e:	84 d2                	test   %dl,%dl
  261290:	74 7a                	je     26130c <<glass::engine::Watch>::print_utf8+0x13bc>
  261292:	48 8b 15 df 83 38 00 	mov    0x3883df(%rip),%rdx        # 5e9678 <_DYNAMIC+0x358>
  261299:	4c 39 d0             	cmp    %r10,%rax
  26129c:	73 07                	jae    2612a5 <<glass::engine::Watch>::print_utf8+0x1355>
  26129e:	48 8b 15 db 83 38 00 	mov    0x3883db(%rip),%rdx        # 5e9680 <_DYNAMIC+0x360>
  2612a5:	f0 48 ff 42 28       	lock incq 0x28(%rdx)
  2612aa:	48 8b 15 a7 83 38 00 	mov    0x3883a7(%rip),%rdx        # 5e9658 <_DYNAMIC+0x338>
  2612b1:	f0 48 ff 02          	lock incq (%rdx)
  2612b5:	4c 89 d2             	mov    %r10,%rdx
  2612b8:	48 29 fa             	sub    %rdi,%rdx
  2612bb:	75 04                	jne    2612c1 <<glass::engine::Watch>::print_utf8+0x1371>
  2612bd:	31 f6                	xor    %esi,%esi
  2612bf:	eb 3f                	jmp    261300 <<glass::engine::Watch>::print_utf8+0x13b0>
  2612c1:	48 8b 35 98 83 38 00 	mov    0x388398(%rip),%rsi        # 5e9660 <_DYNAMIC+0x340>
  2612c8:	f0 48 01 16          	lock add %rdx,(%rsi)
  2612cc:	48 83 fa 05          	cmp    $0x5,%rdx
  2612d0:	73 0e                	jae    2612e0 <<glass::engine::Watch>::print_utf8+0x1390>
  2612d2:	48 8d 35 ef bd df ff 	lea    -0x204211(%rip),%rsi        # 5d0c8 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2612d9:	0f b6 74 32 ff       	movzbl -0x1(%rdx,%rsi,1),%esi
  2612de:	eb 20                	jmp    261300 <<glass::engine::Watch>::print_utf8+0x13b0>
  2612e0:	4c 8d 5a fb          	lea    -0x5(%rdx),%r11
  2612e4:	be 04 00 00 00       	mov    $0x4,%esi
  2612e9:	49 83 fb 04          	cmp    $0x4,%r11
  2612ed:	72 11                	jb     261300 <<glass::engine::Watch>::print_utf8+0x13b0>
  2612ef:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
  2612f3:	48 83 fa 08          	cmp    $0x8,%rdx
  2612f7:	be 06 00 00 00       	mov    $0x6,%esi
  2612fc:	48 83 de 00          	sbb    $0x0,%rsi
  261300:	48 8b 15 49 83 38 00 	mov    0x388349(%rip),%rdx        # 5e9650 <_DYNAMIC+0x330>
  261307:	f0 48 ff 04 f2       	lock incq (%rdx,%rsi,8)
  26130c:	4c 39 d0             	cmp    %r10,%rax
  26130f:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  261314:	0f 83 9e 01 00 00    	jae    2614b8 <<glass::engine::Watch>::print_utf8+0x1568>
  26131a:	4c 89 a4 24 d8 00 00 	mov    %r12,0xd8(%rsp)
  261321:	00 
  261322:	45 8b 4f 28          	mov    0x28(%r15),%r9d
  261326:	45 8b 5f 20          	mov    0x20(%r15),%r11d
  26132a:	41 8b 6f 24          	mov    0x24(%r15),%ebp
  26132e:	41 0f b7 47 2c       	movzwl 0x2c(%r15),%eax
  261333:	4d 8b 67 18          	mov    0x18(%r15),%r12
  261337:	4d 85 e4             	test   %r12,%r12
  26133a:	4c 89 a4 24 98 00 00 	mov    %r12,0x98(%rsp)
  261341:	00 
  261342:	66 89 44 24 68       	mov    %ax,0x68(%rsp)
  261347:	74 34                	je     26137d <<glass::engine::Watch>::print_utf8+0x142d>
  261349:	f0 49 ff 04 24       	lock incq (%r12)
  26134e:	0f 8e a6 0c 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  261354:	49 8b 57 10          	mov    0x10(%r15),%rdx
  261358:	44 89 4c 24 50       	mov    %r9d,0x50(%rsp)
  26135d:	44 89 5c 24 48       	mov    %r11d,0x48(%rsp)
  261362:	89 6c 24 4c          	mov    %ebp,0x4c(%rsp)
  261366:	66 89 44 24 54       	mov    %ax,0x54(%rsp)
  26136b:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
  261370:	49 39 d2             	cmp    %rdx,%r10
  261373:	4c 89 d6             	mov    %r10,%rsi
  261376:	76 20                	jbe    261398 <<glass::engine::Watch>::print_utf8+0x1448>
  261378:	e9 d5 0b 00 00       	jmp    261f52 <<glass::engine::Watch>::print_utf8+0x2002>
  26137d:	44 89 4c 24 50       	mov    %r9d,0x50(%rsp)
  261382:	44 89 5c 24 48       	mov    %r11d,0x48(%rsp)
  261387:	89 6c 24 4c          	mov    %ebp,0x4c(%rsp)
  26138b:	66 89 44 24 54       	mov    %ax,0x54(%rsp)
  261390:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
  261395:	4c 89 d6             	mov    %r10,%rsi
  261398:	48 89 bc 24 a8 00 00 	mov    %rdi,0xa8(%rsp)
  26139f:	00 
  2613a0:	48 8d 04 fd 00 00 00 	lea    0x0(,%rdi,8),%rax
  2613a7:	00 
  2613a8:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  2613ac:	49 8b 5f 08          	mov    0x8(%r15),%rbx
  2613b0:	48 01 c3             	add    %rax,%rbx
  2613b3:	48 89 b4 24 b8 00 00 	mov    %rsi,0xb8(%rsp)
  2613ba:	00 
  2613bb:	48 8d 0c f5 00 00 00 	lea    0x0(,%rsi,8),%rcx
  2613c2:	00 
  2613c3:	4c 8d 34 49          	lea    (%rcx,%rcx,2),%r14
  2613c7:	49 29 c6             	sub    %rax,%r14
  2613ca:	0f b7 4c 24 68       	movzwl 0x68(%rsp),%ecx
  2613cf:	89 ac 24 8c 00 00 00 	mov    %ebp,0x8c(%rsp)
  2613d6:	eb 24                	jmp    2613fc <<glass::engine::Watch>::print_utf8+0x14ac>
  2613d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  2613df:	00 
  2613e0:	4c 89 23             	mov    %r12,(%rbx)
  2613e3:	44 89 5b 08          	mov    %r11d,0x8(%rbx)
  2613e7:	89 6b 0c             	mov    %ebp,0xc(%rbx)
  2613ea:	44 89 4b 10          	mov    %r9d,0x10(%rbx)
  2613ee:	66 89 4b 14          	mov    %cx,0x14(%rbx)
  2613f2:	48 83 c3 18          	add    $0x18,%rbx
  2613f6:	49 83 c6 e8          	add    $0xffffffffffffffe8,%r14
  2613fa:	74 54                	je     261450 <<glass::engine::Watch>::print_utf8+0x1500>
  2613fc:	4d 85 e4             	test   %r12,%r12
  2613ff:	74 0b                	je     26140c <<glass::engine::Watch>::print_utf8+0x14bc>
  261401:	f0 49 ff 04 24       	lock incq (%r12)
  261406:	0f 8e ee 0b 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  26140c:	48 8b 03             	mov    (%rbx),%rax
  26140f:	48 85 c0             	test   %rax,%rax
  261412:	74 cc                	je     2613e0 <<glass::engine::Watch>::print_utf8+0x1490>
  261414:	f0 48 ff 08          	lock decq (%rax)
  261418:	75 c6                	jne    2613e0 <<glass::engine::Watch>::print_utf8+0x1490>
  26141a:	48 89 df             	mov    %rbx,%rdi
  26141d:	4d 89 c7             	mov    %r8,%r15
  261420:	44 89 cd             	mov    %r9d,%ebp
  261423:	45 89 dc             	mov    %r11d,%r12d
  261426:	ff 15 5c 81 38 00    	call   *0x38815c(%rip)        # 5e9588 <_DYNAMIC+0x268>
  26142c:	0f b7 4c 24 68       	movzwl 0x68(%rsp),%ecx
  261431:	45 89 e3             	mov    %r12d,%r11d
  261434:	4c 8b a4 24 98 00 00 	mov    0x98(%rsp),%r12
  26143b:	00 
  26143c:	41 89 e9             	mov    %ebp,%r9d
  26143f:	8b ac 24 8c 00 00 00 	mov    0x8c(%rsp),%ebp
  261446:	4d 89 f8             	mov    %r15,%r8
  261449:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
  26144e:	eb 90                	jmp    2613e0 <<glass::engine::Watch>::print_utf8+0x1490>
  261450:	48 8b 84 24 a8 00 00 	mov    0xa8(%rsp),%rax
  261457:	00 
  261458:	41 39 47 38          	cmp    %eax,0x38(%r15)
  26145c:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  261461:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  261466:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
  26146b:	76 04                	jbe    261471 <<glass::engine::Watch>::print_utf8+0x1521>
  26146d:	41 89 47 38          	mov    %eax,0x38(%r15)
  261471:	4d 85 e4             	test   %r12,%r12
  261474:	8b 6c 24 58          	mov    0x58(%rsp),%ebp
  261478:	4c 8b 94 24 b8 00 00 	mov    0xb8(%rsp),%r10
  26147f:	00 
  261480:	74 2a                	je     2614ac <<glass::engine::Watch>::print_utf8+0x155c>
  261482:	f0 49 ff 0c 24       	lock decq (%r12)
  261487:	75 23                	jne    2614ac <<glass::engine::Watch>::print_utf8+0x155c>
  261489:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  26148e:	4c 89 c3             	mov    %r8,%rbx
  261491:	ff 15 f1 80 38 00    	call   *0x3880f1(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261497:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  26149c:	49 89 d8             	mov    %rbx,%r8
  26149f:	4c 8b 94 24 b8 00 00 	mov    0xb8(%rsp),%r10
  2614a6:	00 
  2614a7:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
  2614ac:	49 8b 4f 10          	mov    0x10(%r15),%rcx
  2614b0:	4c 8b a4 24 d8 00 00 	mov    0xd8(%rsp),%r12
  2614b7:	00 
  2614b8:	49 39 ca             	cmp    %rcx,%r10
  2614bb:	72 22                	jb     2614df <<glass::engine::Watch>::print_utf8+0x158f>
  2614bd:	48 8b 7c 24 78       	mov    0x78(%rsp),%rdi
  2614c2:	4c 89 c3             	mov    %r8,%rbx
  2614c5:	e8 d6 a6 f4 ff       	call   1abba0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2614ca:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  2614cf:	49 89 d8             	mov    %rbx,%r8
  2614d2:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
  2614d7:	41 c7 47 28 ff ff ff 	movl   $0xffffffff,0x28(%r15)
  2614de:	ff 
  2614df:	49 8b 47 30          	mov    0x30(%r15),%rax
  2614e3:	49 83 c1 02          	add    $0x2,%r9
  2614e7:	49 39 c1             	cmp    %rax,%r9
  2614ea:	4c 0f 46 c8          	cmovbe %rax,%r9
  2614ee:	49 8b 77 10          	mov    0x10(%r15),%rsi
  2614f2:	4d 89 4f 30          	mov    %r9,0x30(%r15)
  2614f6:	49 39 f4             	cmp    %rsi,%r12
  2614f9:	0f 83 2a 0b 00 00    	jae    262029 <<glass::engine::Watch>::print_utf8+0x20d9>
  2614ff:	49 8b 47 08          	mov    0x8(%r15),%rax
  261503:	4b 8d 0c 64          	lea    (%r12,%r12,2),%rcx
  261507:	48 8d 1c c8          	lea    (%rax,%rcx,8),%rbx
  26150b:	c7 44 c8 10 20 00 00 	movl   $0x20,0x10(%rax,%rcx,8)
  261512:	00 
  261513:	89 6c c8 08          	mov    %ebp,0x8(%rax,%rcx,8)
  261517:	8b b4 24 a0 00 00 00 	mov    0xa0(%rsp),%esi
  26151e:	89 74 c8 0c          	mov    %esi,0xc(%rax,%rcx,8)
  261522:	8b 74 24 0c          	mov    0xc(%rsp),%esi
  261526:	83 ce 40             	or     $0x40,%esi
  261529:	66 89 74 c8 14       	mov    %si,0x14(%rax,%rcx,8)
  26152e:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
  261532:	48 85 c0             	test   %rax,%rax
  261535:	74 1a                	je     261551 <<glass::engine::Watch>::print_utf8+0x1601>
  261537:	f0 48 ff 08          	lock decq (%rax)
  26153b:	75 14                	jne    261551 <<glass::engine::Watch>::print_utf8+0x1601>
  26153d:	48 89 df             	mov    %rbx,%rdi
  261540:	4d 89 c7             	mov    %r8,%r15
  261543:	ff 15 3f 80 38 00    	call   *0x38803f(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261549:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  26154e:	4d 89 f8             	mov    %r15,%r8
  261551:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  261558:	48 8b 4c 24 70       	mov    0x70(%rsp),%rcx
  26155d:	48 3b 8c 24 90 00 00 	cmp    0x90(%rsp),%rcx
  261564:	00 
  261565:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  26156a:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  26156f:	72 07                	jb     261578 <<glass::engine::Watch>::print_utf8+0x1628>
  261571:	48 ff c9             	dec    %rcx
  261574:	c6 40 6c 01          	movb   $0x1,0x6c(%rax)
  261578:	48 89 48 40          	mov    %rcx,0x40(%rax)
  26157c:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
  261583:	00 
  261584:	49 ff 87 a0 00 00 00 	incq   0xa0(%r15)
  26158b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  261590:	4c 01 f2             	add    %r14,%rdx
  261593:	80 bc 24 80 00 00 00 	cmpb   $0x0,0x80(%rsp)
  26159a:	00 
  26159b:	0f 84 48 f5 ff ff    	je     260ae9 <<glass::engine::Watch>::print_utf8+0xb99>
  2615a1:	e9 5a ea ff ff       	jmp    260000 <<glass::engine::Watch>::print_utf8+0xb0>
  2615a6:	4c 89 c3             	mov    %r8,%rbx
  2615a9:	49 89 d6             	mov    %rdx,%r14
  2615ac:	e8 f1 8a f2 ff       	call   18a0a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2615b1:	4c 89 f2             	mov    %r14,%rdx
  2615b4:	49 89 d8             	mov    %rbx,%r8
  2615b7:	89 eb                	mov    %ebp,%ebx
  2615b9:	48 8b 35 30 af 38 00 	mov    0x38af30(%rip),%rsi        # 5ec4f0 <glass::engine::width_of::CACHE+0x8>
  2615c0:	48 39 de             	cmp    %rbx,%rsi
  2615c3:	0f 87 45 f7 ff ff    	ja     260d0e <<glass::engine::Watch>::print_utf8+0xdbe>
  2615c9:	e9 5a 09 00 00       	jmp    261f28 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2615ce:	49 81 bf a0 00 00 00 	cmpq   $0x400,0xa0(%r15)
  2615d5:	00 04 00 00 
  2615d9:	72 29                	jb     261604 <<glass::engine::Watch>::print_utf8+0x16b4>
  2615db:	4c 89 ff             	mov    %r15,%rdi
  2615de:	e8 bd 0d 00 00       	call   2623a0 <<glass::engine::Watch>::fold_sentinel>
  2615e3:	49 c7 87 a0 00 00 00 	movq   $0x0,0xa0(%r15)
  2615ea:	00 00 00 00 
  2615ee:	8b 05 0c af 38 00    	mov    0x38af0c(%rip),%eax        # 5ec500 <glass::engine::run_whole::ON>
  2615f4:	85 c0                	test   %eax,%eax
  2615f6:	74 16                	je     26160e <<glass::engine::Watch>::print_utf8+0x16be>
  2615f8:	e8 49 8b f2 ff       	call   18a146 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  2615fd:	4d 39 ee             	cmp    %r13,%r14
  261600:	74 11                	je     261613 <<glass::engine::Watch>::print_utf8+0x16c3>
  261602:	eb 3f                	jmp    261643 <<glass::engine::Watch>::print_utf8+0x16f3>
  261604:	8b 05 f6 ae 38 00    	mov    0x38aef6(%rip),%eax        # 5ec500 <glass::engine::run_whole::ON>
  26160a:	85 c0                	test   %eax,%eax
  26160c:	75 ea                	jne    2615f8 <<glass::engine::Watch>::print_utf8+0x16a8>
  26160e:	4d 39 ee             	cmp    %r13,%r14
  261611:	75 30                	jne    261643 <<glass::engine::Watch>::print_utf8+0x16f3>
  261613:	80 3d ea ae 38 00 00 	cmpb   $0x0,0x38aeea(%rip)        # 5ec504 <glass::engine::run_whole::ON+0x4>
  26161a:	74 27                	je     261643 <<glass::engine::Watch>::print_utf8+0x16f3>
  26161c:	83 fd ff             	cmp    $0xffffffff,%ebp
  26161f:	0f 84 c0 01 00 00    	je     2617e5 <<glass::engine::Watch>::print_utf8+0x1895>
  261625:	8d 45 e0             	lea    -0x20(%rbp),%eax
  261628:	83 f8 5f             	cmp    $0x5f,%eax
  26162b:	73 27                	jae    261654 <<glass::engine::Watch>::print_utf8+0x1704>
  26162d:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  261633:	80 7c 24 10 00       	cmpb   $0x0,0x10(%rsp)
  261638:	0f 85 e1 00 00 00    	jne    26171f <<glass::engine::Watch>::print_utf8+0x17cf>
  26163e:	e9 90 01 00 00       	jmp    2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  261643:	31 c0                	xor    %eax,%eax
  261645:	83 fd ff             	cmp    $0xffffffff,%ebp
  261648:	48 0f 44 d8          	cmove  %rax,%rbx
  26164c:	49 89 dd             	mov    %rbx,%r13
  26164f:	e9 91 01 00 00       	jmp    2617e5 <<glass::engine::Watch>::print_utf8+0x1895>
  261654:	80 bc 24 80 00 00 00 	cmpb   $0x0,0x80(%rsp)
  26165b:	00 
  26165c:	0f 84 71 01 00 00    	je     2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  261662:	8b 05 90 ae 38 00    	mov    0x38ae90(%rip),%eax        # 5ec4f8 <glass::engine::width_of::CACHE+0x10>
  261668:	85 c0                	test   %eax,%eax
  26166a:	0f 85 a1 08 00 00    	jne    261f11 <<glass::engine::Watch>::print_utf8+0x1fc1>
  261670:	89 eb                	mov    %ebp,%ebx
  261672:	48 8b 35 77 ae 38 00 	mov    0x38ae77(%rip),%rsi        # 5ec4f0 <glass::engine::width_of::CACHE+0x8>
  261679:	48 39 de             	cmp    %rbx,%rsi
  26167c:	0f 86 a6 08 00 00    	jbe    261f28 <<glass::engine::Watch>::print_utf8+0x1fd8>
  261682:	4c 8b 35 5f ae 38 00 	mov    0x38ae5f(%rip),%r14        # 5ec4e8 <glass::engine::width_of::CACHE>
  261689:	41 0f b6 04 1e       	movzbl (%r14,%rbx,1),%eax
  26168e:	44 0f b6 e8          	movzbl %al,%r13d
  261692:	45 84 ed             	test   %r13b,%r13b
  261695:	78 0b                	js     2616a2 <<glass::engine::Watch>::print_utf8+0x1752>
  261697:	b1 01                	mov    $0x1,%cl
  261699:	84 c9                	test   %cl,%cl
  26169b:	75 74                	jne    261711 <<glass::engine::Watch>::print_utf8+0x17c1>
  26169d:	e9 31 01 00 00       	jmp    2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  2616a2:	41 81 fd fe 00 00 00 	cmp    $0xfe,%r13d
  2616a9:	0f 84 24 01 00 00    	je     2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  2616af:	b0 fe                	mov    $0xfe,%al
  2616b1:	83 fd 7f             	cmp    $0x7f,%ebp
  2616b4:	73 36                	jae    2616ec <<glass::engine::Watch>::print_utf8+0x179c>
  2616b6:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  2616bc:	31 c9                	xor    %ecx,%ecx
  2616be:	eb 45                	jmp    261705 <<glass::engine::Watch>::print_utf8+0x17b5>
  2616c0:	b1 01                	mov    $0x1,%cl
  2616c2:	89 8c 24 80 00 00 00 	mov    %ecx,0x80(%rsp)
  2616c9:	80 78 68 00          	cmpb   $0x0,0x68(%rax)
  2616cd:	75 10                	jne    2616df <<glass::engine::Watch>::print_utf8+0x178f>
  2616cf:	80 78 69 00          	cmpb   $0x0,0x69(%rax)
  2616d3:	75 0a                	jne    2616df <<glass::engine::Watch>::print_utf8+0x178f>
  2616d5:	80 78 6a 00          	cmpb   $0x0,0x6a(%rax)
  2616d9:	0f 84 1f 02 00 00    	je     2618fe <<glass::engine::Watch>::print_utf8+0x19ae>
  2616df:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%rsp)
  2616e6:	00 
  2616e7:	e9 c2 e8 ff ff       	jmp    25ffae <<glass::engine::Watch>::print_utf8+0x5e>
  2616ec:	81 fd a0 00 00 00    	cmp    $0xa0,%ebp
  2616f2:	72 0f                	jb     261703 <<glass::engine::Watch>::print_utf8+0x17b3>
  2616f4:	89 ef                	mov    %ebp,%edi
  2616f6:	e8 85 4c 03 00       	call   296380 <unicode_width::tables::lookup_width>
  2616fb:	44 0f b6 e8          	movzbl %al,%r13d
  2616ff:	b1 01                	mov    $0x1,%cl
  261701:	eb 02                	jmp    261705 <<glass::engine::Watch>::print_utf8+0x17b5>
  261703:	31 c9                	xor    %ecx,%ecx
  261705:	41 88 04 1e          	mov    %al,(%r14,%rbx,1)
  261709:	84 c9                	test   %cl,%cl
  26170b:	0f 84 c2 00 00 00    	je     2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  261711:	49 8d 45 ff          	lea    -0x1(%r13),%rax
  261715:	48 83 f8 01          	cmp    $0x1,%rax
  261719:	0f 87 b4 00 00 00    	ja     2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  26171f:	4d 8b 77 78          	mov    0x78(%r15),%r14
  261723:	41 80 7e 6c 00       	cmpb   $0x0,0x6c(%r14)
  261728:	0f 85 a5 00 00 00    	jne    2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  26172e:	4d 8b 66 40          	mov    0x40(%r14),%r12
  261732:	4d 8b 86 a0 00 00 00 	mov    0xa0(%r14),%r8
  261739:	4b 8d 14 2c          	lea    (%r12,%r13,1),%rdx
  26173d:	4c 39 c2             	cmp    %r8,%rdx
  261740:	0f 87 8d 00 00 00    	ja     2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  261746:	41 8b 46 30          	mov    0x30(%r14),%eax
  26174a:	41 2b 46 48          	sub    0x48(%r14),%eax
  26174e:	48 98                	cltq
  261750:	49 8b 76 20          	mov    0x20(%r14),%rsi
  261754:	49 8b 4e 28          	mov    0x28(%r14),%rcx
  261758:	48 8d 3c 01          	lea    (%rcx,%rax,1),%rdi
  26175c:	48 ff cf             	dec    %rdi
  26175f:	31 c0                	xor    %eax,%eax
  261761:	48 39 f7             	cmp    %rsi,%rdi
  261764:	48 0f 43 c6          	cmovae %rsi,%rax
  261768:	48 29 c7             	sub    %rax,%rdi
  26176b:	48 39 f7             	cmp    %rsi,%rdi
  26176e:	0f 83 57 08 00 00    	jae    261fcb <<glass::engine::Watch>::print_utf8+0x207b>
  261774:	45 8b 56 58          	mov    0x58(%r14),%r10d
  261778:	45 8b 5e 5c          	mov    0x5c(%r14),%r11d
  26177c:	45 0f b7 4e 64       	movzwl 0x64(%r14),%r9d
  261781:	49 8b 46 18          	mov    0x18(%r14),%rax
  261785:	48 c1 e7 06          	shl    $0x6,%rdi
  261789:	48 8d 1c 38          	lea    (%rax,%rdi,1),%rbx
  26178d:	48 8d 0c 38          	lea    (%rax,%rdi,1),%rcx
  261791:	48 83 c1 18          	add    $0x18,%rcx
  261795:	48 89 8c 24 80 00 00 	mov    %rcx,0x80(%rsp)
  26179c:	00 
  26179d:	8b 44 38 28          	mov    0x28(%rax,%rdi,1),%eax
  2617a1:	83 f8 ff             	cmp    $0xffffffff,%eax
  2617a4:	74 0e                	je     2617b4 <<glass::engine::Watch>::print_utf8+0x1864>
  2617a6:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
  2617ad:	00 
  2617ae:	4c 3b 63 30          	cmp    0x30(%rbx),%r12
  2617b2:	73 19                	jae    2617cd <<glass::engine::Watch>::print_utf8+0x187d>
  2617b4:	48 8b 73 10          	mov    0x10(%rbx),%rsi
  2617b8:	49 39 f4             	cmp    %rsi,%r12
  2617bb:	0f 83 78 08 00 00    	jae    262039 <<glass::engine::Watch>::print_utf8+0x20e9>
  2617c1:	4b 8d 0c 64          	lea    (%r12,%r12,2),%rcx
  2617c5:	48 c1 e1 03          	shl    $0x3,%rcx
  2617c9:	48 03 4b 08          	add    0x8(%rbx),%rcx
  2617cd:	f6 41 14 60          	testb  $0x60,0x14(%rcx)
  2617d1:	74 27                	je     2617fa <<glass::engine::Watch>::print_utf8+0x18aa>
  2617d3:	4c 89 ff             	mov    %r15,%rdi
  2617d6:	89 ee                	mov    %ebp,%esi
  2617d8:	e8 d3 86 0d 00       	call   339eb0 <<glass::engine::Watch as vte::ansi::Handler>::input>
  2617dd:	4c 8b ac 24 c0 00 00 	mov    0xc0(%rsp),%r13
  2617e4:	00 
  2617e5:	4c 89 e8             	mov    %r13,%rax
  2617e8:	48 81 c4 18 01 00 00 	add    $0x118,%rsp
  2617ef:	5b                   	pop    %rbx
  2617f0:	41 5c                	pop    %r12
  2617f2:	41 5d                	pop    %r13
  2617f4:	41 5e                	pop    %r14
  2617f6:	41 5f                	pop    %r15
  2617f8:	5d                   	pop    %rbp
  2617f9:	c3                   	ret
  2617fa:	49 83 fd 02          	cmp    $0x2,%r13
  2617fe:	75 37                	jne    261837 <<glass::engine::Watch>::print_utf8+0x18e7>
  261800:	49 8d 7c 24 01       	lea    0x1(%r12),%rdi
  261805:	83 f8 ff             	cmp    $0xffffffff,%eax
  261808:	74 0e                	je     261818 <<glass::engine::Watch>::print_utf8+0x18c8>
  26180a:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
  261811:	00 
  261812:	48 3b 7b 30          	cmp    0x30(%rbx),%rdi
  261816:	73 19                	jae    261831 <<glass::engine::Watch>::print_utf8+0x18e1>
  261818:	48 8b 73 10          	mov    0x10(%rbx),%rsi
  26181c:	48 39 f7             	cmp    %rsi,%rdi
  26181f:	0f 83 d7 07 00 00    	jae    261ffc <<glass::engine::Watch>::print_utf8+0x20ac>
  261825:	48 8d 0c 7f          	lea    (%rdi,%rdi,2),%rcx
  261829:	48 c1 e1 03          	shl    $0x3,%rcx
  26182d:	48 03 4b 08          	add    0x8(%rbx),%rcx
  261831:	f6 41 14 60          	testb  $0x60,0x14(%rcx)
  261835:	75 9c                	jne    2617d3 <<glass::engine::Watch>::print_utf8+0x1883>
  261837:	44 89 5c 24 78       	mov    %r11d,0x78(%rsp)
  26183c:	44 89 54 24 28       	mov    %r10d,0x28(%rsp)
  261841:	44 89 4c 24 30       	mov    %r9d,0x30(%rsp)
  261846:	4c 89 44 24 58       	mov    %r8,0x58(%rsp)
  26184b:	48 89 94 24 a0 00 00 	mov    %rdx,0xa0(%rsp)
  261852:	00 
  261853:	44 39 63 38          	cmp    %r12d,0x38(%rbx)
  261857:	76 04                	jbe    26185d <<glass::engine::Watch>::print_utf8+0x190d>
  261859:	44 89 63 38          	mov    %r12d,0x38(%rbx)
  26185d:	83 f8 ff             	cmp    $0xffffffff,%eax
  261860:	0f 95 c1             	setne  %cl
  261863:	48 89 df             	mov    %rbx,%rdi
  261866:	48 8b 5b 30          	mov    0x30(%rbx),%rbx
  26186a:	49 39 dc             	cmp    %rbx,%r12
  26186d:	0f 94 c2             	sete   %dl
  261870:	84 d1                	test   %dl,%cl
  261872:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
  261877:	75 4c                	jne    2618c5 <<glass::engine::Watch>::print_utf8+0x1975>
  261879:	83 f8 ff             	cmp    $0xffffffff,%eax
  26187c:	0f 84 ad 02 00 00    	je     261b2f <<glass::engine::Watch>::print_utf8+0x1bdf>
  261882:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  261887:	4c 8b 78 10          	mov    0x10(%rax),%r15
  26188b:	49 39 df             	cmp    %rbx,%r15
  26188e:	48 89 d8             	mov    %rbx,%rax
  261891:	49 0f 42 c7          	cmovb  %r15,%rax
  261895:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  26189a:	4d 39 e7             	cmp    %r12,%r15
  26189d:	4c 89 e1             	mov    %r12,%rcx
  2618a0:	49 0f 42 cf          	cmovb  %r15,%rcx
  2618a4:	48 8b 05 95 7d 38 00 	mov    0x387d95(%rip),%rax        # 5e9640 <_DYNAMIC+0x320>
  2618ab:	0f b6 00             	movzbl (%rax),%eax
  2618ae:	84 c0                	test   %al,%al
  2618b0:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
  2618b5:	74 75                	je     26192c <<glass::engine::Watch>::print_utf8+0x19dc>
  2618b7:	48 39 cb             	cmp    %rcx,%rbx
  2618ba:	73 52                	jae    26190e <<glass::engine::Watch>::print_utf8+0x19be>
  2618bc:	48 8b 05 bd 7d 38 00 	mov    0x387dbd(%rip),%rax        # 5e9680 <_DYNAMIC+0x360>
  2618c3:	eb 50                	jmp    261915 <<glass::engine::Watch>::print_utf8+0x19c5>
  2618c5:	49 8d 44 24 01       	lea    0x1(%r12),%rax
  2618ca:	48 89 47 30          	mov    %rax,0x30(%rdi)
  2618ce:	48 8b 77 10          	mov    0x10(%rdi),%rsi
  2618d2:	49 39 f4             	cmp    %rsi,%r12
  2618d5:	48 89 fa             	mov    %rdi,%rdx
  2618d8:	0f 82 77 02 00 00    	jb     261b55 <<glass::engine::Watch>::print_utf8+0x1c05>
  2618de:	48 8d 15 43 fa 35 00 	lea    0x35fa43(%rip),%rdx        # 5c1328 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x156a8>
  2618e5:	4c 89 e7             	mov    %r12,%rdi
  2618e8:	ff 15 4a 7c 38 00    	call   *0x387c4a(%rip)        # 5e9538 <_DYNAMIC+0x218>
  2618ee:	48 8d 0d 8b f9 35 00 	lea    0x35f98b(%rip),%rcx        # 5c1280 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15600>
  2618f5:	4c 89 e7             	mov    %r12,%rdi
  2618f8:	ff 15 fa 7d 38 00    	call   *0x387dfa(%rip)        # 5e96f8 <_DYNAMIC+0x3d8>
  2618fe:	80 78 6b 00          	cmpb   $0x0,0x6b(%rax)
  261902:	0f 94 c0             	sete   %al
  261905:	89 44 24 10          	mov    %eax,0x10(%rsp)
  261909:	e9 a0 e6 ff ff       	jmp    25ffae <<glass::engine::Watch>::print_utf8+0x5e>
  26190e:	48 8b 05 63 7d 38 00 	mov    0x387d63(%rip),%rax        # 5e9678 <_DYNAMIC+0x358>
  261915:	f0 48 ff 40 28       	lock incq 0x28(%rax)
  26191a:	48 89 cf             	mov    %rcx,%rdi
  26191d:	48 2b 7c 24 10       	sub    0x10(%rsp),%rdi
  261922:	e8 e9 2f 09 00       	call   2f4910 <alacritty_terminal::grid::row::fill_census::note>
  261927:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  26192c:	48 39 cb             	cmp    %rcx,%rbx
  26192f:	0f 83 d4 01 00 00    	jae    261b09 <<glass::engine::Watch>::print_utf8+0x1bb9>
  261935:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  26193a:	8b 79 28             	mov    0x28(%rcx),%edi
  26193d:	44 8b 41 20          	mov    0x20(%rcx),%r8d
  261941:	44 8b 49 24          	mov    0x24(%rcx),%r9d
  261945:	44 0f b7 51 2c       	movzwl 0x2c(%rcx),%r10d
  26194a:	48 8b 71 18          	mov    0x18(%rcx),%rsi
  26194e:	48 85 f6             	test   %rsi,%rsi
  261951:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  261956:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  26195a:	44 89 44 24 60       	mov    %r8d,0x60(%rsp)
  26195f:	44 89 4c 24 70       	mov    %r9d,0x70(%rsp)
  261964:	66 44 89 94 24 90 00 	mov    %r10w,0x90(%rsp)
  26196b:	00 00 
  26196d:	0f 84 c3 00 00 00    	je     261a36 <<glass::engine::Watch>::print_utf8+0x1ae6>
  261973:	f0 48 ff 06          	lock incq (%rsi)
  261977:	0f 8e 7d 06 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  26197d:	48 8b 51 10          	mov    0x10(%rcx),%rdx
  261981:	89 7c 24 50          	mov    %edi,0x50(%rsp)
  261985:	44 89 44 24 48       	mov    %r8d,0x48(%rsp)
  26198a:	44 89 4c 24 4c       	mov    %r9d,0x4c(%rsp)
  26198f:	66 44 89 54 24 54    	mov    %r10w,0x54(%rsp)
  261995:	48 89 74 24 40       	mov    %rsi,0x40(%rsp)
  26199a:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
  26199f:	48 39 d6             	cmp    %rdx,%rsi
  2619a2:	0f 87 0f 06 00 00    	ja     261fb7 <<glass::engine::Watch>::print_utf8+0x2067>
  2619a8:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  2619ad:	48 8d 04 c5 00 00 00 	lea    0x0(,%rax,8),%rax
  2619b4:	00 
  2619b5:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  2619b9:	48 8b 59 08          	mov    0x8(%rcx),%rbx
  2619bd:	48 01 c3             	add    %rax,%rbx
  2619c0:	48 8d 0c f5 00 00 00 	lea    0x0(,%rsi,8),%rcx
  2619c7:	00 
  2619c8:	4c 8d 3c 49          	lea    (%rcx,%rcx,2),%r15
  2619cc:	49 29 c7             	sub    %rax,%r15
  2619cf:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
  2619d4:	eb 21                	jmp    2619f7 <<glass::engine::Watch>::print_utf8+0x1aa7>
  2619d6:	48 89 33             	mov    %rsi,(%rbx)
  2619d9:	44 89 43 08          	mov    %r8d,0x8(%rbx)
  2619dd:	44 89 4b 0c          	mov    %r9d,0xc(%rbx)
  2619e1:	89 7b 10             	mov    %edi,0x10(%rbx)
  2619e4:	66 44 89 53 14       	mov    %r10w,0x14(%rbx)
  2619e9:	48 83 c3 18          	add    $0x18,%rbx
  2619ed:	49 83 c7 e8          	add    $0xffffffffffffffe8,%r15
  2619f1:	0f 84 dc 00 00 00    	je     261ad3 <<glass::engine::Watch>::print_utf8+0x1b83>
  2619f7:	f0 48 ff 06          	lock incq (%rsi)
  2619fb:	0f 8e f9 05 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  261a01:	48 8b 03             	mov    (%rbx),%rax
  261a04:	48 85 c0             	test   %rax,%rax
  261a07:	74 cd                	je     2619d6 <<glass::engine::Watch>::print_utf8+0x1a86>
  261a09:	f0 48 ff 08          	lock decq (%rax)
  261a0d:	75 c7                	jne    2619d6 <<glass::engine::Watch>::print_utf8+0x1a86>
  261a0f:	48 89 df             	mov    %rbx,%rdi
  261a12:	ff 15 70 7b 38 00    	call   *0x387b70(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261a18:	44 0f b7 94 24 90 00 	movzwl 0x90(%rsp),%r10d
  261a1f:	00 00 
  261a21:	44 8b 4c 24 70       	mov    0x70(%rsp),%r9d
  261a26:	44 8b 44 24 60       	mov    0x60(%rsp),%r8d
  261a2b:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
  261a2f:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
  261a34:	eb a0                	jmp    2619d6 <<glass::engine::Watch>::print_utf8+0x1a86>
  261a36:	89 7c 24 50          	mov    %edi,0x50(%rsp)
  261a3a:	44 89 44 24 48       	mov    %r8d,0x48(%rsp)
  261a3f:	44 89 4c 24 4c       	mov    %r9d,0x4c(%rsp)
  261a44:	66 44 89 54 24 54    	mov    %r10w,0x54(%rsp)
  261a4a:	48 89 74 24 40       	mov    %rsi,0x40(%rsp)
  261a4f:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  261a54:	48 8d 04 c5 00 00 00 	lea    0x0(,%rax,8),%rax
  261a5b:	00 
  261a5c:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  261a60:	48 8b 59 08          	mov    0x8(%rcx),%rbx
  261a64:	48 01 c3             	add    %rax,%rbx
  261a67:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  261a6c:	48 8d 0c cd 00 00 00 	lea    0x0(,%rcx,8),%rcx
  261a73:	00 
  261a74:	4c 8d 3c 49          	lea    (%rcx,%rcx,2),%r15
  261a78:	49 29 c7             	sub    %rax,%r15
  261a7b:	eb 21                	jmp    261a9e <<glass::engine::Watch>::print_utf8+0x1b4e>
  261a7d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  261a84:	44 89 43 08          	mov    %r8d,0x8(%rbx)
  261a88:	44 89 4b 0c          	mov    %r9d,0xc(%rbx)
  261a8c:	89 7b 10             	mov    %edi,0x10(%rbx)
  261a8f:	66 44 89 53 14       	mov    %r10w,0x14(%rbx)
  261a94:	48 83 c3 18          	add    $0x18,%rbx
  261a98:	49 83 c7 e8          	add    $0xffffffffffffffe8,%r15
  261a9c:	74 35                	je     261ad3 <<glass::engine::Watch>::print_utf8+0x1b83>
  261a9e:	48 8b 03             	mov    (%rbx),%rax
  261aa1:	48 85 c0             	test   %rax,%rax
  261aa4:	74 d7                	je     261a7d <<glass::engine::Watch>::print_utf8+0x1b2d>
  261aa6:	f0 48 ff 08          	lock decq (%rax)
  261aaa:	75 d1                	jne    261a7d <<glass::engine::Watch>::print_utf8+0x1b2d>
  261aac:	48 89 df             	mov    %rbx,%rdi
  261aaf:	ff 15 d3 7a 38 00    	call   *0x387ad3(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261ab5:	44 0f b7 94 24 90 00 	movzwl 0x90(%rsp),%r10d
  261abc:	00 00 
  261abe:	44 8b 4c 24 70       	mov    0x70(%rsp),%r9d
  261ac3:	44 8b 44 24 60       	mov    0x60(%rsp),%r8d
  261ac8:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
  261acc:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
  261ad1:	eb aa                	jmp    261a7d <<glass::engine::Watch>::print_utf8+0x1b2d>
  261ad3:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
  261ad8:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  261add:	39 43 38             	cmp    %eax,0x38(%rbx)
  261ae0:	76 03                	jbe    261ae5 <<glass::engine::Watch>::print_utf8+0x1b95>
  261ae2:	89 43 38             	mov    %eax,0x38(%rbx)
  261ae5:	48 85 f6             	test   %rsi,%rsi
  261ae8:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  261aed:	74 16                	je     261b05 <<glass::engine::Watch>::print_utf8+0x1bb5>
  261aef:	f0 48 ff 0e          	lock decq (%rsi)
  261af3:	75 10                	jne    261b05 <<glass::engine::Watch>::print_utf8+0x1bb5>
  261af5:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  261afa:	ff 15 88 7a 38 00    	call   *0x387a88(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261b00:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  261b05:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
  261b09:	4c 39 f9             	cmp    %r15,%rcx
  261b0c:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
  261b13:	00 
  261b14:	72 19                	jb     261b2f <<glass::engine::Watch>::print_utf8+0x1bdf>
  261b16:	48 8b bc 24 80 00 00 	mov    0x80(%rsp),%rdi
  261b1d:	00 
  261b1e:	e8 7d a0 f4 ff       	call   1abba0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  261b23:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  261b28:	c7 40 28 ff ff ff ff 	movl   $0xffffffff,0x28(%rax)
  261b2f:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  261b34:	48 8b 42 30          	mov    0x30(%rdx),%rax
  261b38:	49 8d 4c 24 01       	lea    0x1(%r12),%rcx
  261b3d:	48 39 c1             	cmp    %rax,%rcx
  261b40:	48 0f 47 c1          	cmova  %rcx,%rax
  261b44:	48 8b 72 10          	mov    0x10(%rdx),%rsi
  261b48:	48 89 42 30          	mov    %rax,0x30(%rdx)
  261b4c:	49 39 f4             	cmp    %rsi,%r12
  261b4f:	0f 83 d4 04 00 00    	jae    262029 <<glass::engine::Watch>::print_utf8+0x20d9>
  261b55:	8b 74 24 30          	mov    0x30(%rsp),%esi
  261b59:	89 f0                	mov    %esi,%eax
  261b5b:	83 c8 20             	or     $0x20,%eax
  261b5e:	49 83 fd 02          	cmp    $0x2,%r13
  261b62:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  261b66:	4b 8d 14 64          	lea    (%r12,%r12,2),%rdx
  261b6a:	48 8d 1c d1          	lea    (%rcx,%rdx,8),%rbx
  261b6e:	89 6c d1 10          	mov    %ebp,0x10(%rcx,%rdx,8)
  261b72:	8b 7c 24 28          	mov    0x28(%rsp),%edi
  261b76:	89 7c d1 08          	mov    %edi,0x8(%rcx,%rdx,8)
  261b7a:	0f 45 c6             	cmovne %esi,%eax
  261b7d:	8b 74 24 78          	mov    0x78(%rsp),%esi
  261b81:	89 74 d1 0c          	mov    %esi,0xc(%rcx,%rdx,8)
  261b85:	66 89 44 d1 14       	mov    %ax,0x14(%rcx,%rdx,8)
  261b8a:	48 8b 04 d1          	mov    (%rcx,%rdx,8),%rax
  261b8e:	48 85 c0             	test   %rax,%rax
  261b91:	74 0f                	je     261ba2 <<glass::engine::Watch>::print_utf8+0x1c52>
  261b93:	f0 48 ff 08          	lock decq (%rax)
  261b97:	75 09                	jne    261ba2 <<glass::engine::Watch>::print_utf8+0x1c52>
  261b99:	48 89 df             	mov    %rbx,%rdi
  261b9c:	ff 15 e6 79 38 00    	call   *0x3879e6(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261ba2:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  261ba9:	49 83 fd 02          	cmp    $0x2,%r13
  261bad:	4c 8b ac 24 c0 00 00 	mov    0xc0(%rsp),%r13
  261bb4:	00 
  261bb5:	0f 85 28 03 00 00    	jne    261ee3 <<glass::engine::Watch>::print_utf8+0x1f93>
  261bbb:	49 8d 4c 24 01       	lea    0x1(%r12),%rcx
  261bc0:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  261bc5:	48 8b 58 30          	mov    0x30(%rax),%rbx
  261bc9:	8b 40 28             	mov    0x28(%rax),%eax
  261bcc:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
  261bd1:	48 39 d9             	cmp    %rbx,%rcx
  261bd4:	75 31                	jne    261c07 <<glass::engine::Watch>::print_utf8+0x1cb7>
  261bd6:	83 f8 ff             	cmp    $0xffffffff,%eax
  261bd9:	74 2c                	je     261c07 <<glass::engine::Watch>::print_utf8+0x1cb7>
  261bdb:	49 83 c4 02          	add    $0x2,%r12
  261bdf:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  261be4:	4c 89 61 30          	mov    %r12,0x30(%rcx)
  261be8:	48 8b 71 10          	mov    0x10(%rcx),%rsi
  261bec:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
  261bf1:	48 39 f7             	cmp    %rsi,%rdi
  261bf4:	0f 82 9a 02 00 00    	jb     261e94 <<glass::engine::Watch>::print_utf8+0x1f44>
  261bfa:	48 8d 15 27 f7 35 00 	lea    0x35f727(%rip),%rdx        # 5c1328 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x156a8>
  261c01:	ff 15 31 79 38 00    	call   *0x387931(%rip)        # 5e9538 <_DYNAMIC+0x218>
  261c07:	83 f8 ff             	cmp    $0xffffffff,%eax
  261c0a:	0f 84 5a 02 00 00    	je     261e6a <<glass::engine::Watch>::print_utf8+0x1f1a>
  261c10:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  261c15:	4c 8b 78 10          	mov    0x10(%rax),%r15
  261c19:	49 39 df             	cmp    %rbx,%r15
  261c1c:	48 89 d8             	mov    %rbx,%rax
  261c1f:	49 0f 42 c7          	cmovb  %r15,%rax
  261c23:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  261c28:	49 8d 4c 24 01       	lea    0x1(%r12),%rcx
  261c2d:	49 39 cf             	cmp    %rcx,%r15
  261c30:	49 0f 42 cf          	cmovb  %r15,%rcx
  261c34:	48 8b 05 05 7a 38 00 	mov    0x387a05(%rip),%rax        # 5e9640 <_DYNAMIC+0x320>
  261c3b:	0f b6 00             	movzbl (%rax),%eax
  261c3e:	84 c0                	test   %al,%al
  261c40:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
  261c45:	74 2c                	je     261c73 <<glass::engine::Watch>::print_utf8+0x1d23>
  261c47:	48 39 cb             	cmp    %rcx,%rbx
  261c4a:	73 09                	jae    261c55 <<glass::engine::Watch>::print_utf8+0x1d05>
  261c4c:	48 8b 05 2d 7a 38 00 	mov    0x387a2d(%rip),%rax        # 5e9680 <_DYNAMIC+0x360>
  261c53:	eb 07                	jmp    261c5c <<glass::engine::Watch>::print_utf8+0x1d0c>
  261c55:	48 8b 05 1c 7a 38 00 	mov    0x387a1c(%rip),%rax        # 5e9678 <_DYNAMIC+0x358>
  261c5c:	f0 48 ff 40 28       	lock incq 0x28(%rax)
  261c61:	48 89 cf             	mov    %rcx,%rdi
  261c64:	48 2b 7c 24 10       	sub    0x10(%rsp),%rdi
  261c69:	e8 a2 2c 09 00       	call   2f4910 <alacritty_terminal::grid::row::fill_census::note>
  261c6e:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  261c73:	48 39 cb             	cmp    %rcx,%rbx
  261c76:	0f 83 c8 01 00 00    	jae    261e44 <<glass::engine::Watch>::print_utf8+0x1ef4>
  261c7c:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  261c81:	8b 79 28             	mov    0x28(%rcx),%edi
  261c84:	44 8b 41 20          	mov    0x20(%rcx),%r8d
  261c88:	44 8b 49 24          	mov    0x24(%rcx),%r9d
  261c8c:	44 0f b7 51 2c       	movzwl 0x2c(%rcx),%r10d
  261c91:	4c 8b 79 18          	mov    0x18(%rcx),%r15
  261c95:	4d 85 ff             	test   %r15,%r15
  261c98:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  261c9c:	44 89 44 24 60       	mov    %r8d,0x60(%rsp)
  261ca1:	44 89 4c 24 70       	mov    %r9d,0x70(%rsp)
  261ca6:	66 44 89 94 24 90 00 	mov    %r10w,0x90(%rsp)
  261cad:	00 00 
  261caf:	0f 84 b9 00 00 00    	je     261d6e <<glass::engine::Watch>::print_utf8+0x1e1e>
  261cb5:	f0 49 ff 07          	lock incq (%r15)
  261cb9:	0f 8e 3b 03 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  261cbf:	48 8b 51 10          	mov    0x10(%rcx),%rdx
  261cc3:	89 7c 24 50          	mov    %edi,0x50(%rsp)
  261cc7:	44 89 44 24 48       	mov    %r8d,0x48(%rsp)
  261ccc:	44 89 4c 24 4c       	mov    %r9d,0x4c(%rsp)
  261cd1:	66 44 89 54 24 54    	mov    %r10w,0x54(%rsp)
  261cd7:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
  261cdc:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
  261ce1:	48 39 d6             	cmp    %rdx,%rsi
  261ce4:	0f 87 fe 02 00 00    	ja     261fe8 <<glass::engine::Watch>::print_utf8+0x2098>
  261cea:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  261cef:	48 8d 04 c5 00 00 00 	lea    0x0(,%rax,8),%rax
  261cf6:	00 
  261cf7:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  261cfb:	48 8b 59 08          	mov    0x8(%rcx),%rbx
  261cff:	48 01 c3             	add    %rax,%rbx
  261d02:	48 8d 0c f5 00 00 00 	lea    0x0(,%rsi,8),%rcx
  261d09:	00 
  261d0a:	4c 8d 2c 49          	lea    (%rcx,%rcx,2),%r13
  261d0e:	49 29 c5             	sub    %rax,%r13
  261d11:	eb 21                	jmp    261d34 <<glass::engine::Watch>::print_utf8+0x1de4>
  261d13:	4c 89 3b             	mov    %r15,(%rbx)
  261d16:	44 89 43 08          	mov    %r8d,0x8(%rbx)
  261d1a:	44 89 4b 0c          	mov    %r9d,0xc(%rbx)
  261d1e:	89 7b 10             	mov    %edi,0x10(%rbx)
  261d21:	66 44 89 53 14       	mov    %r10w,0x14(%rbx)
  261d26:	48 83 c3 18          	add    $0x18,%rbx
  261d2a:	49 83 c5 e8          	add    $0xffffffffffffffe8,%r13
  261d2e:	0f 84 d2 00 00 00    	je     261e06 <<glass::engine::Watch>::print_utf8+0x1eb6>
  261d34:	f0 49 ff 07          	lock incq (%r15)
  261d38:	0f 8e bc 02 00 00    	jle    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  261d3e:	48 8b 03             	mov    (%rbx),%rax
  261d41:	48 85 c0             	test   %rax,%rax
  261d44:	74 cd                	je     261d13 <<glass::engine::Watch>::print_utf8+0x1dc3>
  261d46:	f0 48 ff 08          	lock decq (%rax)
  261d4a:	75 c7                	jne    261d13 <<glass::engine::Watch>::print_utf8+0x1dc3>
  261d4c:	48 89 df             	mov    %rbx,%rdi
  261d4f:	ff 15 33 78 38 00    	call   *0x387833(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261d55:	44 0f b7 94 24 90 00 	movzwl 0x90(%rsp),%r10d
  261d5c:	00 00 
  261d5e:	44 8b 4c 24 70       	mov    0x70(%rsp),%r9d
  261d63:	44 8b 44 24 60       	mov    0x60(%rsp),%r8d
  261d68:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
  261d6c:	eb a5                	jmp    261d13 <<glass::engine::Watch>::print_utf8+0x1dc3>
  261d6e:	89 7c 24 50          	mov    %edi,0x50(%rsp)
  261d72:	44 89 44 24 48       	mov    %r8d,0x48(%rsp)
  261d77:	44 89 4c 24 4c       	mov    %r9d,0x4c(%rsp)
  261d7c:	66 44 89 54 24 54    	mov    %r10w,0x54(%rsp)
  261d82:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
  261d87:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  261d8c:	48 8d 04 c5 00 00 00 	lea    0x0(,%rax,8),%rax
  261d93:	00 
  261d94:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  261d98:	48 8b 59 08          	mov    0x8(%rcx),%rbx
  261d9c:	48 01 c3             	add    %rax,%rbx
  261d9f:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  261da4:	48 8d 0c cd 00 00 00 	lea    0x0(,%rcx,8),%rcx
  261dab:	00 
  261dac:	4c 8d 2c 49          	lea    (%rcx,%rcx,2),%r13
  261db0:	49 29 c5             	sub    %rax,%r13
  261db3:	eb 21                	jmp    261dd6 <<glass::engine::Watch>::print_utf8+0x1e86>
  261db5:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  261dbc:	44 89 43 08          	mov    %r8d,0x8(%rbx)
  261dc0:	44 89 4b 0c          	mov    %r9d,0xc(%rbx)
  261dc4:	89 7b 10             	mov    %edi,0x10(%rbx)
  261dc7:	66 44 89 53 14       	mov    %r10w,0x14(%rbx)
  261dcc:	48 83 c3 18          	add    $0x18,%rbx
  261dd0:	49 83 c5 e8          	add    $0xffffffffffffffe8,%r13
  261dd4:	74 30                	je     261e06 <<glass::engine::Watch>::print_utf8+0x1eb6>
  261dd6:	48 8b 03             	mov    (%rbx),%rax
  261dd9:	48 85 c0             	test   %rax,%rax
  261ddc:	74 d7                	je     261db5 <<glass::engine::Watch>::print_utf8+0x1e65>
  261dde:	f0 48 ff 08          	lock decq (%rax)
  261de2:	75 d1                	jne    261db5 <<glass::engine::Watch>::print_utf8+0x1e65>
  261de4:	48 89 df             	mov    %rbx,%rdi
  261de7:	ff 15 9b 77 38 00    	call   *0x38779b(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261ded:	44 0f b7 94 24 90 00 	movzwl 0x90(%rsp),%r10d
  261df4:	00 00 
  261df6:	44 8b 4c 24 70       	mov    0x70(%rsp),%r9d
  261dfb:	44 8b 44 24 60       	mov    0x60(%rsp),%r8d
  261e00:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
  261e04:	eb af                	jmp    261db5 <<glass::engine::Watch>::print_utf8+0x1e65>
  261e06:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
  261e0b:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  261e10:	39 43 38             	cmp    %eax,0x38(%rbx)
  261e13:	76 03                	jbe    261e18 <<glass::engine::Watch>::print_utf8+0x1ec8>
  261e15:	89 43 38             	mov    %eax,0x38(%rbx)
  261e18:	4d 85 ff             	test   %r15,%r15
  261e1b:	4c 8b ac 24 c0 00 00 	mov    0xc0(%rsp),%r13
  261e22:	00 
  261e23:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  261e28:	74 16                	je     261e40 <<glass::engine::Watch>::print_utf8+0x1ef0>
  261e2a:	f0 49 ff 0f          	lock decq (%r15)
  261e2e:	75 10                	jne    261e40 <<glass::engine::Watch>::print_utf8+0x1ef0>
  261e30:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  261e35:	ff 15 4d 77 38 00    	call   *0x38774d(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261e3b:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  261e40:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
  261e44:	4c 39 f9             	cmp    %r15,%rcx
  261e47:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
  261e4e:	00 
  261e4f:	72 19                	jb     261e6a <<glass::engine::Watch>::print_utf8+0x1f1a>
  261e51:	48 8b bc 24 80 00 00 	mov    0x80(%rsp),%rdi
  261e58:	00 
  261e59:	e8 42 9d f4 ff       	call   1abba0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  261e5e:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  261e63:	c7 40 28 ff ff ff ff 	movl   $0xffffffff,0x28(%rax)
  261e6a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  261e6f:	48 8b 41 30          	mov    0x30(%rcx),%rax
  261e73:	49 83 c4 02          	add    $0x2,%r12
  261e77:	49 39 c4             	cmp    %rax,%r12
  261e7a:	4c 0f 46 e0          	cmovbe %rax,%r12
  261e7e:	48 8b 71 10          	mov    0x10(%rcx),%rsi
  261e82:	4c 89 61 30          	mov    %r12,0x30(%rcx)
  261e86:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
  261e8b:	48 39 f7             	cmp    %rsi,%rdi
  261e8e:	0f 83 b5 01 00 00    	jae    262049 <<glass::engine::Watch>::print_utf8+0x20f9>
  261e94:	48 8b 41 08          	mov    0x8(%rcx),%rax
  261e98:	48 8d 0c 7f          	lea    (%rdi,%rdi,2),%rcx
  261e9c:	48 8d 1c c8          	lea    (%rax,%rcx,8),%rbx
  261ea0:	c7 44 c8 10 20 00 00 	movl   $0x20,0x10(%rax,%rcx,8)
  261ea7:	00 
  261ea8:	8b 54 24 28          	mov    0x28(%rsp),%edx
  261eac:	89 54 c8 08          	mov    %edx,0x8(%rax,%rcx,8)
  261eb0:	8b 54 24 78          	mov    0x78(%rsp),%edx
  261eb4:	89 54 c8 0c          	mov    %edx,0xc(%rax,%rcx,8)
  261eb8:	8b 54 24 30          	mov    0x30(%rsp),%edx
  261ebc:	83 ca 40             	or     $0x40,%edx
  261ebf:	66 89 54 c8 14       	mov    %dx,0x14(%rax,%rcx,8)
  261ec4:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
  261ec8:	48 85 c0             	test   %rax,%rax
  261ecb:	74 0f                	je     261edc <<glass::engine::Watch>::print_utf8+0x1f8c>
  261ecd:	f0 48 ff 08          	lock decq (%rax)
  261ed1:	75 09                	jne    261edc <<glass::engine::Watch>::print_utf8+0x1f8c>
  261ed3:	48 89 df             	mov    %rbx,%rdi
  261ed6:	ff 15 ac 76 38 00    	call   *0x3876ac(%rip)        # 5e9588 <_DYNAMIC+0x268>
  261edc:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  261ee3:	48 8b 84 24 a0 00 00 	mov    0xa0(%rsp),%rax
  261eea:	00 
  261eeb:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax
  261ef0:	72 08                	jb     261efa <<glass::engine::Watch>::print_utf8+0x1faa>
  261ef2:	48 ff c8             	dec    %rax
  261ef5:	41 c6 46 6c 01       	movb   $0x1,0x6c(%r14)
  261efa:	49 89 46 40          	mov    %rax,0x40(%r14)
  261efe:	49 ff 87 a0 00 00 00 	incq   0xa0(%r15)
  261f05:	41 89 af b0 00 00 00 	mov    %ebp,0xb0(%r15)
  261f0c:	e9 d4 f8 ff ff       	jmp    2617e5 <<glass::engine::Watch>::print_utf8+0x1895>
  261f11:	e8 8c 81 f2 ff       	call   18a0a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  261f16:	89 eb                	mov    %ebp,%ebx
  261f18:	48 8b 35 d1 a5 38 00 	mov    0x38a5d1(%rip),%rsi        # 5ec4f0 <glass::engine::width_of::CACHE+0x8>
  261f1f:	48 39 de             	cmp    %rbx,%rsi
  261f22:	0f 87 5a f7 ff ff    	ja     261682 <<glass::engine::Watch>::print_utf8+0x1732>
  261f28:	48 8d 15 69 13 36 00 	lea    0x361369(%rip),%rdx        # 5c3298 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17618>
  261f2f:	48 89 df             	mov    %rbx,%rdi
  261f32:	ff 15 00 76 38 00    	call   *0x387600(%rip)        # 5e9538 <_DYNAMIC+0x218>
  261f38:	48 8d 0d e9 e7 35 00 	lea    0x35e7e9(%rip),%rcx        # 5c0728 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14aa8>
  261f3f:	48 8b bc 24 a8 00 00 	mov    0xa8(%rsp),%rdi
  261f46:	00 
  261f47:	ff 15 ab 77 38 00    	call   *0x3877ab(%rip)        # 5e96f8 <_DYNAMIC+0x3d8>
  261f4d:	e9 a8 00 00 00       	jmp    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  261f52:	48 8d 0d cf e7 35 00 	lea    0x35e7cf(%rip),%rcx        # 5c0728 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14aa8>
  261f59:	ff 15 99 77 38 00    	call   *0x387799(%rip)        # 5e96f8 <_DYNAMIC+0x3d8>
  261f5f:	e9 96 00 00 00       	jmp    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  261f64:	48 8d 15 b5 ec 35 00 	lea    0x35ecb5(%rip),%rdx        # 5c0c20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fa0>
  261f6b:	ff 15 c7 75 38 00    	call   *0x3875c7(%rip)        # 5e9538 <_DYNAMIC+0x218>
  261f71:	48 8d 05 c0 ec 35 00 	lea    0x35ecc0(%rip),%rax        # 5c0c38 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fb8>
  261f78:	eb 1f                	jmp    261f99 <<glass::engine::Watch>::print_utf8+0x2049>
  261f7a:	48 8d 15 ff ec 35 00 	lea    0x35ecff(%rip),%rdx        # 5c0c80 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15000>
  261f81:	48 89 df             	mov    %rbx,%rdi
  261f84:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
  261f89:	ff 15 a9 75 38 00    	call   *0x3875a9(%rip)        # 5e9538 <_DYNAMIC+0x218>
  261f8f:	48 89 c3             	mov    %rax,%rbx
  261f92:	48 8d 05 b7 ec 35 00 	lea    0x35ecb7(%rip),%rax        # 5c0c50 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14fd0>
  261f99:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
  261fa0:	00 
  261fa1:	48 89 df             	mov    %rbx,%rdi
  261fa4:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
  261fa9:	48 8b 94 24 f0 00 00 	mov    0xf0(%rsp),%rdx
  261fb0:	00 
  261fb1:	ff 15 81 75 38 00    	call   *0x387581(%rip)        # 5e9538 <_DYNAMIC+0x218>
  261fb7:	48 8d 0d 6a e7 35 00 	lea    0x35e76a(%rip),%rcx        # 5c0728 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14aa8>
  261fbe:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  261fc3:	ff 15 2f 77 38 00    	call   *0x38772f(%rip)        # 5e96f8 <_DYNAMIC+0x3d8>
  261fc9:	eb 2f                	jmp    261ffa <<glass::engine::Watch>::print_utf8+0x20aa>
  261fcb:	48 8d 15 ce ed 35 00 	lea    0x35edce(%rip),%rdx        # 5c0da0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15120>
  261fd2:	ff 15 60 75 38 00    	call   *0x387560(%rip)        # 5e9538 <_DYNAMIC+0x218>
  261fd8:	48 8d 15 69 d2 34 00 	lea    0x34d269(%rip),%rdx        # 5af248 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35c8>
  261fdf:	48 89 df             	mov    %rbx,%rdi
  261fe2:	ff 15 50 75 38 00    	call   *0x387550(%rip)        # 5e9538 <_DYNAMIC+0x218>
  261fe8:	48 8d 0d 39 e7 35 00 	lea    0x35e739(%rip),%rcx        # 5c0728 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14aa8>
  261fef:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  261ff4:	ff 15 fe 76 38 00    	call   *0x3876fe(%rip)        # 5e96f8 <_DYNAMIC+0x3d8>
  261ffa:	0f 0b                	ud2
  261ffc:	48 8d 15 45 d2 34 00 	lea    0x34d245(%rip),%rdx        # 5af248 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35c8>
  262003:	ff 15 2f 75 38 00    	call   *0x38752f(%rip)        # 5e9538 <_DYNAMIC+0x218>
  262009:	48 8d 15 18 f3 35 00 	lea    0x35f318(%rip),%rdx        # 5c1328 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x156a8>
  262010:	48 89 df             	mov    %rbx,%rdi
  262013:	ff 15 1f 75 38 00    	call   *0x38751f(%rip)        # 5e9538 <_DYNAMIC+0x218>
  262019:	48 8d 15 f0 f2 35 00 	lea    0x35f2f0(%rip),%rdx        # 5c1310 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15690>
  262020:	48 89 df             	mov    %rbx,%rdi
  262023:	ff 15 0f 75 38 00    	call   *0x38750f(%rip)        # 5e9538 <_DYNAMIC+0x218>
  262029:	48 8d 15 e0 f2 35 00 	lea    0x35f2e0(%rip),%rdx        # 5c1310 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15690>
  262030:	4c 89 e7             	mov    %r12,%rdi
  262033:	ff 15 ff 74 38 00    	call   *0x3874ff(%rip)        # 5e9538 <_DYNAMIC+0x218>
  262039:	48 8d 15 08 d2 34 00 	lea    0x34d208(%rip),%rdx        # 5af248 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35c8>
  262040:	4c 89 e7             	mov    %r12,%rdi
  262043:	ff 15 ef 74 38 00    	call   *0x3874ef(%rip)        # 5e9538 <_DYNAMIC+0x218>
  262049:	48 8d 15 c0 f2 35 00 	lea    0x35f2c0(%rip),%rdx        # 5c1310 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15690>
  262050:	ff 15 e2 74 38 00    	call   *0x3874e2(%rip)        # 5e9538 <_DYNAMIC+0x218>
  262056:	48 89 c3             	mov    %rax,%rbx
  262059:	f0 49 ff 0f          	lock decq (%r15)
  26205d:	74 27                	je     262086 <<glass::engine::Watch>::print_utf8+0x2136>
  26205f:	eb 33                	jmp    262094 <<glass::engine::Watch>::print_utf8+0x2144>
  262061:	48 89 c3             	mov    %rax,%rbx
  262064:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
  262069:	eb 15                	jmp    262080 <<glass::engine::Watch>::print_utf8+0x2130>
  26206b:	48 89 c3             	mov    %rax,%rbx
  26206e:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  262075:	00 
  262076:	eb 08                	jmp    262080 <<glass::engine::Watch>::print_utf8+0x2130>
  262078:	48 89 c3             	mov    %rax,%rbx
  26207b:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  262080:	f0 48 ff 08          	lock decq (%rax)
  262084:	75 0e                	jne    262094 <<glass::engine::Watch>::print_utf8+0x2144>
  262086:	48 8b bc 24 10 01 00 	mov    0x110(%rsp),%rdi
  26208d:	00 
  26208e:	ff 15 f4 74 38 00    	call   *0x3874f4(%rip)        # 5e9588 <_DYNAMIC+0x268>
  262094:	48 89 df             	mov    %rbx,%rdi
  262097:	e8 d4 64 34 00       	call   5a8570 <_Unwind_Resume@plt>
  26209c:	cc                   	int3
  26209d:	cc                   	int3
  26209e:	cc                   	int3
  26209f:	cc                   	int3

