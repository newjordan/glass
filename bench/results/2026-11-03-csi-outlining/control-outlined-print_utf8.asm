
/tmp/glass-i26-control-outlined-test:     file format elf64-x86-64


Disassembly of section .text:

0000000000262370 <<glass::engine::Watch>::print_utf8>:
  262370:	push   %rbp
  262371:	push   %r15
  262373:	push   %r14
  262375:	push   %r13
  262377:	push   %r12
  262379:	push   %rbx
  26237a:	sub    $0x118,%rsp
  262381:	mov    %rdx,%r13
  262384:	mov    %rdi,%r15
  262387:	cmpb   $0x1,0xbe(%rdi)
  26238e:	jne    2623bb <<glass::engine::Watch>::print_utf8+0x4b>
  262390:	cmpq   $0x0,0x38(%r15)
  262395:	jne    2623bb <<glass::engine::Watch>::print_utf8+0x4b>
  262397:	mov    0x78(%r15),%rax
  26239b:	testb  $0x4,0x6c5(%rax)
  2623a2:	jne    2623bb <<glass::engine::Watch>::print_utf8+0x4b>
  2623a4:	cmpq   $0x0,0x50(%rax)
  2623a9:	jne    2623bb <<glass::engine::Watch>::print_utf8+0x4b>
  2623ab:	movzwl 0x64(%rax),%ecx
  2623af:	test   $0x460,%ecx
  2623b5:	je     263ae0 <<glass::engine::Watch>::print_utf8+0x1770>
  2623bb:	movl   $0x0,0x10(%rsp)
  2623c3:	movl   $0x0,0x80(%rsp)
  2623ce:	mov    $0xffffffff,%r8d
  2623d4:	xor    %r14d,%r14d
  2623d7:	lea    0x36680a(%rip),%rax        # 5c8be8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15468>
  2623de:	mov    %rax,0xf0(%rsp)
  2623e6:	lea    0x40(%rsp),%rax
  2623eb:	mov    %rax,0x110(%rsp)
  2623f3:	xor    %edx,%edx
  2623f5:	mov    %r13,0xc0(%rsp)
  2623fd:	mov    %r15,0xc8(%rsp)
  262405:	mov    %rsi,0x18(%rsp)
  26240a:	cmpb   $0x0,0x80(%rsp)
  262412:	je     262f09 <<glass::engine::Watch>::print_utf8+0xb99>
  262418:	nopl   0x0(%rax,%rax,1)
  262420:	mov    0x78(%r15),%rbx
  262424:	cmpb   $0x0,0x6c(%rbx)
  262428:	jne    262f09 <<glass::engine::Watch>::print_utf8+0xb99>
  26242e:	mov    0x30(%rbx),%eax
  262431:	sub    0x48(%rbx),%eax
  262434:	cltq
  262436:	mov    0x20(%rbx),%rsi
  26243a:	mov    0x28(%rbx),%rcx
  26243e:	lea    (%rcx,%rax,1),%rdi
  262442:	dec    %rdi
  262445:	cmp    %rsi,%rdi
  262448:	mov    $0x0,%eax
  26244d:	cmovae %rsi,%rax
  262451:	sub    %rax,%rdi
  262454:	cmp    %rsi,%rdi
  262457:	jae    264384 <<glass::engine::Watch>::print_utf8+0x2014>
  26245d:	mov    0xa0(%rbx),%rax
  262464:	mov    %rax,0x38(%rsp)
  262469:	mov    0x40(%rbx),%r12
  26246d:	mov    0x58(%rbx),%eax
  262470:	mov    %eax,0x78(%rsp)
  262474:	mov    0x5c(%rbx),%eax
  262477:	mov    %eax,0xa0(%rsp)
  26247e:	movzwl 0x64(%rbx),%eax
  262482:	mov    %eax,0xc(%rsp)
  262486:	mov    0x18(%rbx),%rax
  26248a:	shl    $0x6,%rdi
  26248e:	lea    (%rax,%rdi,1),%rbp
  262492:	cmp    %r12d,0x38(%rax,%rdi,1)
  262497:	jbe    26249d <<glass::engine::Watch>::print_utf8+0x12d>
  262499:	mov    %r12d,0x38(%rbp)
  26249d:	mov    %rdx,0x28(%rsp)
  2624a2:	mov    0x28(%rbp),%r10d
  2624a6:	cmp    $0xffffffff,%r10d
  2624aa:	mov    %r12,0x60(%rsp)
  2624af:	je     262569 <<glass::engine::Watch>::print_utf8+0x1f9>
  2624b5:	mov    0x30(%rbp),%rax
  2624b9:	cmp    %rax,%r12
  2624bc:	mov    $0x0,%ecx
  2624c1:	cmovb  %rax,%rcx
  2624c5:	mov    %rcx,0x20(%rsp)
  2624ca:	movl   $0x20,0x108(%rsp)
  2624d5:	mov    0x78(%rsp),%ecx
  2624d9:	mov    %ecx,0x100(%rsp)
  2624e0:	mov    0xa0(%rsp),%ecx
  2624e7:	mov    %ecx,0x104(%rsp)
  2624ee:	mov    0xc(%rsp),%ecx
  2624f2:	mov    %cx,0x10c(%rsp)
  2624fa:	movq   $0x0,0xf8(%rsp)
  262506:	mov    0x10(%rbp),%rcx
  26250a:	cmp    %rax,%rcx
  26250d:	mov    %rax,%rdx
  262510:	cmovb  %rcx,%rdx
  262514:	mov    %rdx,0x68(%rsp)
  262519:	cmp    %r12,%rcx
  26251c:	mov    %r12,%r9
  26251f:	cmovb  %rcx,%r9
  262523:	mov    0x38f556(%rip),%rdx        # 5f1a80 <_DYNAMIC+0x320>
  26252a:	movzbl (%rdx),%edx
  26252d:	test   %dl,%dl
  26252f:	je     26260a <<glass::engine::Watch>::print_utf8+0x29a>
  262535:	mov    0x38f57c(%rip),%rdx        # 5f1ab8 <_DYNAMIC+0x358>
  26253c:	cmp    %r9,%rax
  26253f:	jae    262548 <<glass::engine::Watch>::print_utf8+0x1d8>
  262541:	mov    0x38f578(%rip),%rdx        # 5f1ac0 <_DYNAMIC+0x360>
  262548:	lock incq 0x28(%rdx)
  26254d:	mov    0x38f544(%rip),%rdx        # 5f1a98 <_DYNAMIC+0x338>
  262554:	lock incq (%rdx)
  262558:	mov    %r9,%rdx
  26255b:	sub    0x68(%rsp),%rdx
  262560:	jne    2625bf <<glass::engine::Watch>::print_utf8+0x24f>
  262562:	xor    %esi,%esi
  262564:	jmp    2625fe <<glass::engine::Watch>::print_utf8+0x28e>
  262569:	movl   $0x20,0x108(%rsp)
  262574:	mov    0x78(%rsp),%eax
  262578:	mov    %eax,0x100(%rsp)
  26257f:	mov    0xa0(%rsp),%eax
  262586:	mov    %eax,0x104(%rsp)
  26258d:	mov    0xc(%rsp),%eax
  262591:	mov    %ax,0x10c(%rsp)
  262599:	movq   $0x0,0xf8(%rsp)
  2625a5:	lea    0x30(%rbp),%rax
  2625a9:	mov    %rax,0xd8(%rsp)
  2625b1:	movq   $0xffffffffffffffff,0x20(%rsp)
  2625ba:	jmp    26279a <<glass::engine::Watch>::print_utf8+0x42a>
  2625bf:	mov    0x38f4da(%rip),%rsi        # 5f1aa0 <_DYNAMIC+0x340>
  2625c6:	lock add %rdx,(%rsi)
  2625ca:	cmp    $0x5,%rdx
  2625ce:	jae    2625de <<glass::engine::Watch>::print_utf8+0x26e>
  2625d0:	lea    -0x204abf(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2625d7:	movzbl -0x1(%rdx,%rsi,1),%esi
  2625dc:	jmp    2625fe <<glass::engine::Watch>::print_utf8+0x28e>
  2625de:	lea    -0x5(%rdx),%rdi
  2625e2:	mov    $0x4,%esi
  2625e7:	cmp    $0x4,%rdi
  2625eb:	jb     2625fe <<glass::engine::Watch>::print_utf8+0x28e>
  2625ed:	add    $0xfffffffffffffff7,%rdx
  2625f1:	cmp    $0x8,%rdx
  2625f5:	mov    $0x6,%esi
  2625fa:	sbb    $0x0,%rsi
  2625fe:	mov    0x38f48b(%rip),%rdx        # 5f1a90 <_DYNAMIC+0x330>
  262605:	lock incq (%rdx,%rsi,8)
  26260a:	cmp    %r9,%rax
  26260d:	mov    %r8,0x58(%rsp)
  262612:	jae    26275f <<glass::engine::Watch>::print_utf8+0x3ef>
  262618:	mov    %rbx,0x98(%rsp)
  262620:	mov    %r14,0x30(%rsp)
  262625:	mov    0x20(%rbp),%r13d
  262629:	mov    0x24(%rbp),%esi
  26262c:	movzwl 0x2c(%rbp),%edi
  262630:	mov    0x18(%rbp),%r12
  262634:	test   %r12,%r12
  262637:	je     262644 <<glass::engine::Watch>::print_utf8+0x2d4>
  262639:	lock incq (%r12)
  26263e:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  262644:	mov    %r10d,0x50(%rsp)
  262649:	mov    %r13d,0x48(%rsp)
  26264e:	mov    %esi,0x4c(%rsp)
  262652:	mov    %di,0x54(%rsp)
  262657:	mov    %r12,0x40(%rsp)
  26265c:	mov    0x68(%rsp),%rax
  262661:	lea    0x0(,%rax,8),%rax
  262669:	lea    (%rax,%rax,2),%rax
  26266d:	mov    %rbp,0xd0(%rsp)
  262675:	mov    0x8(%rbp),%rbx
  262679:	add    %rax,%rbx
  26267c:	lea    0x0(,%r9,8),%rcx
  262684:	lea    (%rcx,%rcx,2),%rbp
  262688:	sub    %rax,%rbp
  26268b:	mov    %esi,0x70(%rsp)
  26268f:	mov    %di,0x90(%rsp)
  262697:	jmp    2626bc <<glass::engine::Watch>::print_utf8+0x34c>
  262699:	nopl   0x0(%rax)
  2626a0:	mov    %r12,(%rbx)
  2626a3:	mov    %r13d,0x8(%rbx)
  2626a7:	mov    %esi,0xc(%rbx)
  2626aa:	mov    %r10d,0x10(%rbx)
  2626ae:	mov    %di,0x14(%rbx)
  2626b2:	add    $0x18,%rbx
  2626b6:	add    $0xffffffffffffffe8,%rbp
  2626ba:	je     262702 <<glass::engine::Watch>::print_utf8+0x392>
  2626bc:	test   %r12,%r12
  2626bf:	je     2626cc <<glass::engine::Watch>::print_utf8+0x35c>
  2626c1:	lock incq (%r12)
  2626c6:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  2626cc:	mov    (%rbx),%rax
  2626cf:	test   %rax,%rax
  2626d2:	je     2626a0 <<glass::engine::Watch>::print_utf8+0x330>
  2626d4:	lock decq (%rax)
  2626d8:	jne    2626a0 <<glass::engine::Watch>::print_utf8+0x330>
  2626da:	mov    %rbx,%rdi
  2626dd:	mov    %r9,%r14
  2626e0:	mov    %r10d,%r15d
  2626e3:	call   *0x38f2df(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  2626e9:	movzwl 0x90(%rsp),%edi
  2626f1:	mov    0x70(%rsp),%esi
  2626f5:	mov    %r15d,%r10d
  2626f8:	mov    %r14,%r9
  2626fb:	mov    0x58(%rsp),%r8
  262700:	jmp    2626a0 <<glass::engine::Watch>::print_utf8+0x330>
  262702:	mov    0xd0(%rsp),%rbp
  26270a:	mov    0x68(%rsp),%rax
  26270f:	cmp    %eax,0x38(%rbp)
  262712:	jbe    262717 <<glass::engine::Watch>::print_utf8+0x3a7>
  262714:	mov    %eax,0x38(%rbp)
  262717:	test   %r12,%r12
  26271a:	mov    0xc0(%rsp),%r13
  262722:	mov    0xc8(%rsp),%r15
  26272a:	mov    0x30(%rsp),%r14
  26272f:	mov    0x98(%rsp),%rbx
  262737:	je     262756 <<glass::engine::Watch>::print_utf8+0x3e6>
  262739:	lock decq (%r12)
  26273e:	jne    262756 <<glass::engine::Watch>::print_utf8+0x3e6>
  262740:	lea    0x40(%rsp),%rdi
  262745:	mov    %r9,%r12
  262748:	call   *0x38f27a(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  26274e:	mov    %r12,%r9
  262751:	mov    0x58(%rsp),%r8
  262756:	mov    0x10(%rbp),%rcx
  26275a:	mov    0x60(%rsp),%r12
  26275f:	lea    0x30(%rbp),%rax
  262763:	mov    %rax,0xd8(%rsp)
  26276b:	cmp    %rcx,%r9
  26276e:	jb     26279a <<glass::engine::Watch>::print_utf8+0x42a>
  262770:	cmpl   $0xffffffff,0x28(%rbp)
  262774:	je     262793 <<glass::engine::Watch>::print_utf8+0x423>
  262776:	lea    0x18(%rbp),%rdi
  26277a:	mov    (%rdi),%rax
  26277d:	test   %rax,%rax
  262780:	je     262793 <<glass::engine::Watch>::print_utf8+0x423>
  262782:	lock decq (%rax)
  262786:	jne    262793 <<glass::engine::Watch>::print_utf8+0x423>
  262788:	call   *0x38f23a(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  26278e:	mov    0x58(%rsp),%r8
  262793:	movl   $0xffffffff,0x28(%rbp)
  26279a:	mov    0x10(%rbp),%rdx
  26279e:	mov    0x30(%rbp),%rax
  2627a2:	cmp    %r12,%rdx
  2627a5:	mov    %r12,%rsi
  2627a8:	cmovb  %rdx,%rsi
  2627ac:	cmp    %rax,%rsi
  2627af:	cmova  %rsi,%rax
  2627b3:	mov    %rdx,%rcx
  2627b6:	mov    %rax,0x30(%rbp)
  2627ba:	sub    %r12,%rcx
  2627bd:	mov    %rcx,0x30(%rsp)
  2627c2:	jb     263d0e <<glass::engine::Watch>::print_utf8+0x199e>
  2627c8:	mov    0x28(%rsp),%rdx
  2627cd:	cmp    %r13,%rdx
  2627d0:	jae    262dd0 <<glass::engine::Watch>::print_utf8+0xa60>
  2627d6:	mov    %rbx,0x98(%rsp)
  2627de:	mov    %rbp,0xd0(%rsp)
  2627e6:	mov    0x8(%rbp),%rcx
  2627ea:	lea    (%r12,%r12,2),%rax
  2627ee:	mov    %rcx,0x70(%rsp)
  2627f3:	lea    (%rcx,%rax,8),%rax
  2627f7:	mov    %rax,0xb8(%rsp)
  2627ff:	mov    0xc(%rsp),%eax
  262803:	mov    %eax,%ecx
  262805:	or     $0x20,%ecx
  262808:	mov    %ecx,0x8c(%rsp)
  26280f:	or     $0x40,%eax
  262812:	mov    %eax,0xa8(%rsp)
  262819:	mov    $0x1,%al
  26281b:	mov    %eax,0x90(%rsp)
  262822:	xor    %r11d,%r11d
  262825:	xor    %edi,%edi
  262827:	mov    %r12,%rbx
  26282a:	mov    %r12,%r10
  26282d:	mov    0x18(%rsp),%rsi
  262832:	jmp    26289f <<glass::engine::Watch>::print_utf8+0x52f>
  262834:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  262840:	movq   $0x0,(%rbx)
  262847:	mov    0x78(%rsp),%eax
  26284b:	mov    %eax,0x8(%rbx)
  26284e:	mov    0xa0(%rsp),%eax
  262855:	mov    %eax,0xc(%rbx)
  262858:	movl   $0x20,0x10(%rbx)
  26285f:	mov    0xa8(%rsp),%eax
  262866:	mov    %ax,0x14(%rbx)
  26286a:	movl   $0x0,0x90(%rsp)
  262875:	xor    %r11d,%r11d
  262878:	cmp    0x38(%rsp),%r9
  26287d:	setae  %r11b
  262881:	mov    %r9,%r10
  262884:	sub    %r11,%r10
  262887:	inc    %rdi
  26288a:	mov    %r9,%rbx
  26288d:	add    %r15,%rdx
  262890:	mov    %ebp,%r8d
  262893:	mov    %r15,%r14
  262896:	cmp    %r13,%rdx
  262899:	jae    262ded <<glass::engine::Watch>::print_utf8+0xa7d>
  26289f:	mov    %rdx,%r15
  2628a2:	movzbl (%rsi,%rdx,1),%ebp
  2628a6:	test   %bpl,%bpl
  2628a9:	js     2628d0 <<glass::engine::Watch>::print_utf8+0x560>
  2628ab:	mov    $0x1,%edx
  2628b0:	lea    -0x7f(%rbp),%eax
  2628b3:	cmp    $0x21,%eax
  2628b6:	jae    262a38 <<glass::engine::Watch>::print_utf8+0x6c8>
  2628bc:	jmp    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2628c1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2628d0:	lea    0x3e(%rbp),%eax
  2628d3:	cmp    $0x1e,%al
  2628d5:	jae    262900 <<glass::engine::Watch>::print_utf8+0x590>
  2628d7:	lea    0x1(%r15),%rax
  2628db:	cmp    %r13,%rax
  2628de:	jae    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2628e4:	movzbl (%rsi,%rax,1),%eax
  2628e8:	cmp    $0xc0,%al
  2628ea:	jge    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2628f0:	and    $0x1f,%ebp
  2628f3:	shl    $0x6,%ebp
  2628f6:	mov    $0x2,%edx
  2628fb:	jmp    262a0b <<glass::engine::Watch>::print_utf8+0x69b>
  262900:	mov    %ebp,%eax
  262902:	and    $0xf0,%al
  262904:	cmp    $0xe0,%al
  262906:	jne    262920 <<glass::engine::Watch>::print_utf8+0x5b0>
  262908:	mov    $0xbf,%al
  26290a:	cmp    $0xe0,%ebp
  262910:	je     262943 <<glass::engine::Watch>::print_utf8+0x5d3>
  262912:	mov    $0x80,%cl
  262914:	cmp    $0xed,%ebp
  26291a:	jne    262945 <<glass::engine::Watch>::print_utf8+0x5d5>
  26291c:	mov    $0x9f,%al
  26291e:	jmp    262945 <<glass::engine::Watch>::print_utf8+0x5d5>
  262920:	lea    0x10(%rbp),%eax
  262923:	cmp    $0x5,%al
  262925:	jae    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  26292b:	mov    $0x80,%al
  26292d:	cmp    $0xf4,%ebp
  262933:	je     262997 <<glass::engine::Watch>::print_utf8+0x627>
  262935:	mov    $0xbf,%cl
  262937:	cmp    $0xf0,%ebp
  26293d:	jne    262999 <<glass::engine::Watch>::print_utf8+0x629>
  26293f:	mov    $0x90,%al
  262941:	jmp    262999 <<glass::engine::Watch>::print_utf8+0x629>
  262943:	mov    $0xa0,%cl
  262945:	lea    0x1(%r15),%rdx
  262949:	cmp    %r13,%rdx
  26294c:	jae    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  262952:	movzbl (%rsi,%rdx,1),%edx
  262956:	cmp    %dl,%cl
  262958:	ja     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  26295e:	cmp    %al,%dl
  262960:	ja     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  262966:	lea    0x2(%r15),%rax
  26296a:	cmp    %r13,%rax
  26296d:	jae    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  262973:	movzbl (%rsi,%rax,1),%eax
  262977:	cmp    $0xc0,%al
  262979:	jge    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  26297f:	movzbl %dl,%ecx
  262982:	and    $0x3f,%ecx
  262985:	shl    $0x6,%ecx
  262988:	and    $0xf,%ebp
  26298b:	shl    $0xc,%ebp
  26298e:	or     %ecx,%ebp
  262990:	mov    $0x3,%edx
  262995:	jmp    262a0b <<glass::engine::Watch>::print_utf8+0x69b>
  262997:	mov    $0x8f,%cl
  262999:	lea    0x1(%r15),%rdx
  26299d:	cmp    %r13,%rdx
  2629a0:	jae    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2629a6:	movzbl (%rsi,%rdx,1),%edx
  2629aa:	cmp    %dl,%al
  2629ac:	ja     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2629b2:	cmp    %cl,%dl
  2629b4:	ja     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2629ba:	lea    0x2(%r15),%rax
  2629be:	cmp    %r13,%rax
  2629c1:	jae    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2629c7:	movzbl (%rsi,%rax,1),%ecx
  2629cb:	cmp    $0xbf,%cl
  2629ce:	jg     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2629d4:	lea    0x3(%r15),%rax
  2629d8:	cmp    %r13,%rax
  2629db:	jae    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2629e1:	movzbl (%rsi,%rax,1),%eax
  2629e5:	cmp    $0xbf,%al
  2629e7:	jg     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  2629ed:	movzbl %dl,%edx
  2629f0:	and    $0x3f,%ecx
  2629f3:	shl    $0x6,%ecx
  2629f6:	and    $0x3f,%edx
  2629f9:	shl    $0xc,%edx
  2629fc:	and    $0x7,%ebp
  2629ff:	shl    $0x12,%ebp
  262a02:	or     %edx,%ebp
  262a04:	or     %ecx,%ebp
  262a06:	mov    $0x4,%edx
  262a0b:	mov    %ebp,%ecx
  262a0d:	xor    $0xd800,%ecx
  262a13:	add    $0xffef0000,%ecx
  262a19:	cmp    $0xffef0800,%ecx
  262a1f:	jb     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  262a25:	and    $0x3f,%al
  262a27:	movzbl %al,%eax
  262a2a:	or     %eax,%ebp
  262a2c:	lea    -0x7f(%rbp),%eax
  262a2f:	cmp    $0x21,%eax
  262a32:	jb     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  262a38:	cmp    $0xffffffff,%r8d
  262a3c:	je     262a60 <<glass::engine::Watch>::print_utf8+0x6f0>
  262a3e:	lea    -0x20(%r8),%eax
  262a42:	cmp    $0x5f,%eax
  262a45:	jae    262a70 <<glass::engine::Watch>::print_utf8+0x700>
  262a47:	mov    $0x1,%ecx
  262a4c:	cmpb   $0x0,0x10(%rsp)
  262a51:	jne    262b6b <<glass::engine::Watch>::print_utf8+0x7fb>
  262a57:	jmp    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  262a5c:	nopl   0x0(%rax)
  262a60:	mov    %rbx,%r9
  262a63:	jmp    26288d <<glass::engine::Watch>::print_utf8+0x51d>
  262a68:	nopl   0x0(%rax,%rax,1)
  262a70:	mov    %rbx,0x68(%rsp)
  262a75:	mov    0x391ebd(%rip),%eax        # 5f4938 <glass::engine::width_of::CACHE+0x10>
  262a7b:	test   %eax,%eax
  262a7d:	jne    262d5e <<glass::engine::Watch>::print_utf8+0x9ee>
  262a83:	mov    %r8d,%ebx
  262a86:	mov    0x391ea3(%rip),%rsi        # 5f4930 <glass::engine::width_of::CACHE+0x8>
  262a8d:	cmp    %rbx,%rsi
  262a90:	jbe    264348 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262a96:	mov    0x391e8b(%rip),%r12        # 5f4928 <glass::engine::width_of::CACHE>
  262a9d:	movzbl (%r12,%rbx,1),%eax
  262aa2:	movzbl %al,%ecx
  262aa5:	test   %cl,%cl
  262aa7:	mov    %rdx,0x28(%rsp)
  262aac:	js     262ac7 <<glass::engine::Watch>::print_utf8+0x757>
  262aae:	mov    $0x1,%dl
  262ab0:	mov    0x18(%rsp),%rsi
  262ab5:	test   %dl,%dl
  262ab7:	mov    0x68(%rsp),%rbx
  262abc:	jne    262b53 <<glass::engine::Watch>::print_utf8+0x7e3>
  262ac2:	jmp    262e4d <<glass::engine::Watch>::print_utf8+0xadd>
  262ac7:	cmp    $0xfe,%ecx
  262acd:	mov    0x18(%rsp),%rsi
  262ad2:	je     262e6d <<glass::engine::Watch>::print_utf8+0xafd>
  262ad8:	mov    $0xfe,%al
  262ada:	cmp    $0x7f,%r8d
  262ade:	jae    262ae9 <<glass::engine::Watch>::print_utf8+0x779>
  262ae0:	mov    $0x1,%ecx
  262ae5:	xor    %edx,%edx
  262ae7:	jmp    262b42 <<glass::engine::Watch>::print_utf8+0x7d2>
  262ae9:	cmp    $0xa0,%r8d
  262af0:	jb     262b40 <<glass::engine::Watch>::print_utf8+0x7d0>
  262af2:	mov    %rdi,0xb0(%rsp)
  262afa:	mov    %r8d,%edi
  262afd:	mov    %r8,0x58(%rsp)
  262b02:	mov    %r10,0xe8(%rsp)
  262b0a:	mov    %r11,0xe0(%rsp)
  262b12:	call   2987a0 <unicode_width::tables::lookup_width>
  262b17:	mov    0xe0(%rsp),%r11
  262b1f:	mov    0xe8(%rsp),%r10
  262b27:	mov    0xb0(%rsp),%rdi
  262b2f:	mov    0x58(%rsp),%r8
  262b34:	mov    0x18(%rsp),%rsi
  262b39:	movzbl %al,%ecx
  262b3c:	mov    $0x1,%dl
  262b3e:	jmp    262b42 <<glass::engine::Watch>::print_utf8+0x7d2>
  262b40:	xor    %edx,%edx
  262b42:	mov    %al,(%r12,%rbx,1)
  262b46:	test   %dl,%dl
  262b48:	mov    0x68(%rsp),%rbx
  262b4d:	je     262e4d <<glass::engine::Watch>::print_utf8+0xadd>
  262b53:	lea    -0x1(%rcx),%rax
  262b57:	cmp    $0x1,%rax
  262b5b:	mov    0x28(%rsp),%rdx
  262b60:	mov    0x60(%rsp),%r12
  262b65:	ja     262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  262b6b:	test   $0x1,%r11b
  262b6f:	jne    262ddc <<glass::engine::Watch>::print_utf8+0xa6c>
  262b75:	lea    (%rcx,%r10,1),%rax
  262b79:	cmp    0x38(%rsp),%rax
  262b7e:	ja     262de1 <<glass::engine::Watch>::print_utf8+0xa71>
  262b84:	mov    %rax,0x58(%rsp)
  262b89:	mov    %rbx,%r9
  262b8c:	mov    %r10,%rbx
  262b8f:	sub    %r12,%rbx
  262b92:	cmp    0x20(%rsp),%r10
  262b97:	jae    262c00 <<glass::engine::Watch>::print_utf8+0x890>
  262b99:	cmp    0x30(%rsp),%rbx
  262b9e:	mov    0x70(%rsp),%r11
  262ba3:	jae    264391 <<glass::engine::Watch>::print_utf8+0x2021>
  262ba9:	lea    (%r10,%r10,2),%rax
  262bad:	testb  $0x60,0x14(%r11,%rax,8)
  262bb3:	jne    262e48 <<glass::engine::Watch>::print_utf8+0xad8>
  262bb9:	lea    (%r11,%rax,8),%r12
  262bbd:	cmp    $0x2,%rcx
  262bc1:	jne    262c92 <<glass::engine::Watch>::print_utf8+0x922>
  262bc7:	lea    0x1(%rbx),%rax
  262bcb:	cmp    0x30(%rsp),%rax
  262bd0:	jae    2643af <<glass::engine::Watch>::print_utf8+0x203f>
  262bd6:	mov    %r14,%rcx
  262bd9:	lea    (%rax,%rax,2),%rax
  262bdd:	mov    $0x1,%r14b
  262be0:	mov    0xb8(%rsp),%r13
  262be8:	testb  $0x60,0x14(%r13,%rax,8)
  262bee:	mov    0x8c(%rsp),%r13d
  262bf6:	je     262c2e <<glass::engine::Watch>::print_utf8+0x8be>
  262bf8:	jmp    262e52 <<glass::engine::Watch>::print_utf8+0xae2>
  262bfd:	nopl   (%rax)
  262c00:	cmp    0x30(%rsp),%rbx
  262c05:	mov    0x70(%rsp),%r11
  262c0a:	jae    2643c1 <<glass::engine::Watch>::print_utf8+0x2051>
  262c10:	lea    (%r10,%r10,2),%rax
  262c14:	lea    (%r11,%rax,8),%r12
  262c18:	cmp    $0x2,%rcx
  262c1c:	sete   %r14b
  262c20:	mov    0xc(%rsp),%r13d
  262c25:	cmove  0x8c(%rsp),%r13d
  262c2e:	mov    (%r12),%rax
  262c32:	test   %rax,%rax
  262c35:	je     262cb0 <<glass::engine::Watch>::print_utf8+0x940>
  262c37:	lock decq (%rax)
  262c3b:	jne    262cb0 <<glass::engine::Watch>::print_utf8+0x940>
  262c3d:	mov    %rdi,0xb0(%rsp)
  262c45:	mov    %r12,%rdi
  262c48:	mov    %r15,0xe0(%rsp)
  262c50:	mov    %r8,%r15
  262c53:	mov    %rdx,0x28(%rsp)
  262c58:	mov    %r10,0xe8(%rsp)
  262c60:	call   *0x38ed62(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  262c66:	mov    0x70(%rsp),%r11
  262c6b:	mov    0xe8(%rsp),%r10
  262c73:	mov    0xb0(%rsp),%rdi
  262c7b:	mov    0x28(%rsp),%rdx
  262c80:	mov    %r15,%r8
  262c83:	mov    0xe0(%rsp),%r15
  262c8b:	mov    0x18(%rsp),%rsi
  262c90:	jmp    262cb0 <<glass::engine::Watch>::print_utf8+0x940>
  262c92:	xor    %r14d,%r14d
  262c95:	mov    0xc(%rsp),%r13d
  262c9a:	mov    (%r12),%rax
  262c9e:	test   %rax,%rax
  262ca1:	jne    262c37 <<glass::engine::Watch>::print_utf8+0x8c7>
  262ca3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262cb0:	lea    (%r10,%r10,2),%rax
  262cb4:	movq   $0x0,(%r12)
  262cbc:	mov    0x78(%rsp),%ecx
  262cc0:	mov    %ecx,0x8(%r11,%rax,8)
  262cc5:	mov    0xa0(%rsp),%ecx
  262ccc:	mov    %ecx,0xc(%r11,%rax,8)
  262cd1:	mov    %r13w,0x14(%r11,%rax,8)
  262cd7:	mov    %r8d,0x10(%r11,%rax,8)
  262cdc:	test   %r14b,%r14b
  262cdf:	mov    0xc0(%rsp),%r13
  262ce7:	mov    0x60(%rsp),%r12
  262cec:	mov    0x58(%rsp),%r9
  262cf1:	je     262875 <<glass::engine::Watch>::print_utf8+0x505>
  262cf7:	inc    %rbx
  262cfa:	cmp    0x30(%rsp),%rbx
  262cff:	jae    26439a <<glass::engine::Watch>::print_utf8+0x202a>
  262d05:	lea    (%rbx,%rbx,2),%rax
  262d09:	mov    0xb8(%rsp),%rcx
  262d11:	lea    (%rcx,%rax,8),%rbx
  262d15:	mov    (%rcx,%rax,8),%rax
  262d19:	test   %rax,%rax
  262d1c:	je     262840 <<glass::engine::Watch>::print_utf8+0x4d0>
  262d22:	lock decq (%rax)
  262d26:	jne    262840 <<glass::engine::Watch>::print_utf8+0x4d0>
  262d2c:	mov    %r15,%r13
  262d2f:	mov    %rdi,%r15
  262d32:	mov    %rbx,%rdi
  262d35:	mov    %rdx,%r14
  262d38:	call   *0x38ec8a(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  262d3e:	mov    0x58(%rsp),%r9
  262d43:	mov    %r15,%rdi
  262d46:	mov    %r13,%r15
  262d49:	mov    0xc0(%rsp),%r13
  262d51:	mov    %r14,%rdx
  262d54:	mov    0x18(%rsp),%rsi
  262d59:	jmp    262840 <<glass::engine::Watch>::print_utf8+0x4d0>
  262d5e:	mov    %r8,0x58(%rsp)
  262d63:	mov    %r15,0xe0(%rsp)
  262d6b:	mov    %rdx,%r15
  262d6e:	mov    %rdi,0xb0(%rsp)
  262d76:	mov    %r10,0xe8(%rsp)
  262d7e:	mov    %r11,%r12
  262d81:	call   18b9a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  262d86:	mov    %r12,%r11
  262d89:	mov    0xe8(%rsp),%r10
  262d91:	mov    0xb0(%rsp),%rdi
  262d99:	mov    %r15,%rdx
  262d9c:	mov    0xe0(%rsp),%r15
  262da4:	mov    0x58(%rsp),%r8
  262da9:	mov    %r8d,%ebx
  262dac:	mov    0x391b7d(%rip),%rsi        # 5f4930 <glass::engine::width_of::CACHE+0x8>
  262db3:	cmp    %rbx,%rsi
  262db6:	ja     262a96 <<glass::engine::Watch>::print_utf8+0x726>
  262dbc:	jmp    264348 <<glass::engine::Watch>::print_utf8+0x1fd8>
  262dc1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262dd0:	xor    %edi,%edi
  262dd2:	xor    %r11d,%r11d
  262dd5:	mov    0x18(%rsp),%rsi
  262dda:	jmp    262e34 <<glass::engine::Watch>::print_utf8+0xac4>
  262ddc:	mov    $0x1,%r11b
  262ddf:	jmp    262de4 <<glass::engine::Watch>::print_utf8+0xa74>
  262de1:	xor    %r11d,%r11d
  262de4:	mov    %rbx,%r9
  262de7:	mov    %r8d,%ebp
  262dea:	mov    %r15,%rdx
  262ded:	cmp    %r12,%r9
  262df0:	jbe    262e07 <<glass::engine::Watch>::print_utf8+0xa97>
  262df2:	mov    0xd8(%rsp),%rcx
  262dfa:	mov    (%rcx),%rax
  262dfd:	cmp    %rax,%r9
  262e00:	cmova  %r9,%rax
  262e04:	mov    %rax,(%rcx)
  262e07:	cmp    $0x8,%rdi
  262e0b:	setae  %al
  262e0e:	testb  $0x1,0x90(%rsp)
  262e16:	mov    0xc8(%rsp),%r15
  262e1e:	jne    262e22 <<glass::engine::Watch>::print_utf8+0xab2>
  262e20:	xor    %eax,%eax
  262e22:	test   %al,%al
  262e24:	jne    262e82 <<glass::engine::Watch>::print_utf8+0xb12>
  262e26:	mov    %r10,%r12
  262e29:	mov    %ebp,%r8d
  262e2c:	mov    0x98(%rsp),%rbx
  262e34:	mov    %r12,0x40(%rbx)
  262e38:	mov    %r11b,0x6c(%rbx)
  262e3c:	add    %rdi,0xa0(%r15)
  262e43:	jmp    262f09 <<glass::engine::Watch>::print_utf8+0xb99>
  262e48:	xor    %r11d,%r11d
  262e4b:	jmp    262de7 <<glass::engine::Watch>::print_utf8+0xa77>
  262e4d:	mov    %rbx,%r9
  262e50:	jmp    262e72 <<glass::engine::Watch>::print_utf8+0xb02>
  262e52:	xor    %r11d,%r11d
  262e55:	mov    %r8d,%ebp
  262e58:	mov    %r15,%rdx
  262e5b:	mov    0xc0(%rsp),%r13
  262e63:	mov    %rcx,%r14
  262e66:	mov    0x60(%rsp),%r12
  262e6b:	jmp    262ded <<glass::engine::Watch>::print_utf8+0xa7d>
  262e6d:	mov    0x68(%rsp),%r9
  262e72:	mov    %r8d,%ebp
  262e75:	mov    %r15,%rdx
  262e78:	mov    0x60(%rsp),%r12
  262e7d:	jmp    262ded <<glass::engine::Watch>::print_utf8+0xa7d>
  262e82:	mov    %rdx,0x28(%rsp)
  262e87:	movzbl %r11b,%edx
  262e8b:	add    %r10,%rdx
  262e8e:	mov    %rdi,0xb0(%rsp)
  262e96:	mov    0xd0(%rsp),%rdi
  262e9e:	mov    %r12,%rsi
  262ea1:	lea    0xf8(%rsp),%rcx
  262ea9:	mov    %r10,%r12
  262eac:	mov    %r11,%rbx
  262eaf:	call   2a1600 <glass::engine::note_uniform_span>
  262eb4:	mov    %rbx,%r11
  262eb7:	mov    0xb0(%rsp),%rdi
  262ebf:	mov    0x28(%rsp),%rdx
  262ec4:	mov    0x18(%rsp),%rsi
  262ec9:	jmp    262e29 <<glass::engine::Watch>::print_utf8+0xab9>
  262ece:	xchg   %ax,%ax
  262ed0:	mov    0xc8(%rsp),%r15
  262ed8:	mov    %r15,%rdi
  262edb:	mov    %ebp,%esi
  262edd:	mov    %r8,%rbx
  262ee0:	mov    %rdx,%r14
  262ee3:	call   33d350 <<glass::engine::Watch as vte::ansi::Handler>::input>
  262ee8:	mov    %r14,%rdx
  262eeb:	mov    %rbx,%r8
  262eee:	mov    0x18(%rsp),%rsi
  262ef3:	mov    0x30(%rsp),%r14
  262ef8:	add    %r14,%rdx
  262efb:	cmpb   $0x0,0x80(%rsp)
  262f03:	jne    262420 <<glass::engine::Watch>::print_utf8+0xb0>
  262f09:	mov    %r8d,%ebp
  262f0c:	mov    %r14,%rbx
  262f0f:	mov    %rdx,%r14
  262f12:	cmp    %r13,%rdx
  262f15:	jae    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262f1b:	movzbl (%rsi,%r14,1),%r8d
  262f20:	test   %r8b,%r8b
  262f23:	js     262f40 <<glass::engine::Watch>::print_utf8+0xbd0>
  262f25:	mov    $0x1,%edx
  262f2a:	lea    -0x7f(%r8),%eax
  262f2e:	cmp    $0x21,%eax
  262f31:	jae    2630c8 <<glass::engine::Watch>::print_utf8+0xd58>
  262f37:	jmp    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262f3c:	nopl   0x0(%rax)
  262f40:	lea    0x3e(%r8),%eax
  262f44:	cmp    $0x1e,%al
  262f46:	jae    262f80 <<glass::engine::Watch>::print_utf8+0xc10>
  262f48:	lea    0x1(%r14),%rax
  262f4c:	cmp    %r13,%rax
  262f4f:	jae    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262f55:	movzbl (%rsi,%rax,1),%eax
  262f59:	cmp    $0xc0,%al
  262f5b:	jge    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262f61:	and    $0x1f,%r8d
  262f65:	shl    $0x6,%r8d
  262f69:	mov    $0x2,%edx
  262f6e:	jmp    263098 <<glass::engine::Watch>::print_utf8+0xd28>
  262f73:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  262f80:	mov    %r8d,%eax
  262f83:	and    $0xf0,%al
  262f85:	cmp    $0xe0,%al
  262f87:	jne    262fa3 <<glass::engine::Watch>::print_utf8+0xc33>
  262f89:	mov    $0xbf,%al
  262f8b:	cmp    $0xe0,%r8d
  262f92:	je     262fc9 <<glass::engine::Watch>::print_utf8+0xc59>
  262f94:	mov    $0x80,%cl
  262f96:	cmp    $0xed,%r8d
  262f9d:	jne    262fcb <<glass::engine::Watch>::print_utf8+0xc5b>
  262f9f:	mov    $0x9f,%al
  262fa1:	jmp    262fcb <<glass::engine::Watch>::print_utf8+0xc5b>
  262fa3:	lea    0x10(%r8),%eax
  262fa7:	cmp    $0x5,%al
  262fa9:	jae    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262faf:	mov    $0x80,%al
  262fb1:	cmp    $0xf4,%r8d
  262fb8:	je     263020 <<glass::engine::Watch>::print_utf8+0xcb0>
  262fba:	mov    $0xbf,%cl
  262fbc:	cmp    $0xf0,%r8d
  262fc3:	jne    263022 <<glass::engine::Watch>::print_utf8+0xcb2>
  262fc5:	mov    $0x90,%al
  262fc7:	jmp    263022 <<glass::engine::Watch>::print_utf8+0xcb2>
  262fc9:	mov    $0xa0,%cl
  262fcb:	lea    0x1(%r14),%rdx
  262fcf:	cmp    %r13,%rdx
  262fd2:	jae    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262fd8:	movzbl (%rsi,%rdx,1),%edx
  262fdc:	cmp    %dl,%cl
  262fde:	ja     2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262fe4:	cmp    %al,%dl
  262fe6:	ja     2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262fec:	lea    0x2(%r14),%rax
  262ff0:	cmp    %r13,%rax
  262ff3:	jae    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  262ff9:	movzbl (%rsi,%rax,1),%eax
  262ffd:	cmp    $0xc0,%al
  262fff:	jge    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  263005:	movzbl %dl,%ecx
  263008:	and    $0x3f,%ecx
  26300b:	shl    $0x6,%ecx
  26300e:	and    $0xf,%r8d
  263012:	shl    $0xc,%r8d
  263016:	or     %ecx,%r8d
  263019:	mov    $0x3,%edx
  26301e:	jmp    263098 <<glass::engine::Watch>::print_utf8+0xd28>
  263020:	mov    $0x8f,%cl
  263022:	lea    0x1(%r14),%rdx
  263026:	cmp    %r13,%rdx
  263029:	jae    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  26302f:	movzbl (%rsi,%rdx,1),%edx
  263033:	cmp    %dl,%al
  263035:	ja     2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  26303b:	cmp    %cl,%dl
  26303d:	ja     2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  263043:	lea    0x2(%r14),%rax
  263047:	cmp    %r13,%rax
  26304a:	jae    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  263050:	movzbl (%rsi,%rax,1),%ecx
  263054:	cmp    $0xbf,%cl
  263057:	jg     2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  26305d:	lea    0x3(%r14),%rax
  263061:	cmp    %r13,%rax
  263064:	jae    2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  26306a:	movzbl (%rsi,%rax,1),%eax
  26306e:	cmp    $0xbf,%al
  263070:	jg     2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  263076:	movzbl %dl,%edx
  263079:	and    $0x3f,%ecx
  26307c:	shl    $0x6,%ecx
  26307f:	and    $0x3f,%edx
  263082:	shl    $0xc,%edx
  263085:	and    $0x7,%r8d
  263089:	shl    $0x12,%r8d
  26308d:	or     %edx,%r8d
  263090:	or     %ecx,%r8d
  263093:	mov    $0x4,%edx
  263098:	mov    %r8d,%ecx
  26309b:	xor    $0xd800,%ecx
  2630a1:	add    $0xffef0000,%ecx
  2630a7:	cmp    $0xffef0800,%ecx
  2630ad:	jb     2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  2630b3:	and    $0x3f,%al
  2630b5:	movzbl %al,%eax
  2630b8:	or     %eax,%r8d
  2630bb:	lea    -0x7f(%r8),%eax
  2630bf:	cmp    $0x21,%eax
  2630c2:	jb     2639ee <<glass::engine::Watch>::print_utf8+0x167e>
  2630c8:	cmp    $0xffffffff,%ebp
  2630cb:	je     2639b0 <<glass::engine::Watch>::print_utf8+0x1640>
  2630d1:	mov    %r14,0x30(%rsp)
  2630d6:	lea    -0x20(%rbp),%eax
  2630d9:	cmp    $0x5f,%eax
  2630dc:	jae    263100 <<glass::engine::Watch>::print_utf8+0xd90>
  2630de:	mov    $0x1,%r12d
  2630e4:	cmpb   $0x0,0x10(%rsp)
  2630e9:	je     262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  2630ef:	jmp    2631ac <<glass::engine::Watch>::print_utf8+0xe3c>
  2630f4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  263100:	cmpb   $0x0,0x80(%rsp)
  263108:	je     262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  26310e:	mov    0x391824(%rip),%eax        # 5f4938 <glass::engine::width_of::CACHE+0x10>
  263114:	test   %eax,%eax
  263116:	jne    2639c6 <<glass::engine::Watch>::print_utf8+0x1656>
  26311c:	mov    %ebp,%ebx
  26311e:	mov    0x39180b(%rip),%rsi        # 5f4930 <glass::engine::width_of::CACHE+0x8>
  263125:	cmp    %rbx,%rsi
  263128:	jbe    264348 <<glass::engine::Watch>::print_utf8+0x1fd8>
  26312e:	mov    0x3917f3(%rip),%r14        # 5f4928 <glass::engine::width_of::CACHE>
  263135:	movzbl (%r14,%rbx,1),%eax
  26313a:	movzbl %al,%r12d
  26313e:	test   %r12b,%r12b
  263141:	js     26314e <<glass::engine::Watch>::print_utf8+0xdde>
  263143:	mov    $0x1,%cl
  263145:	test   %cl,%cl
  263147:	jne    26319d <<glass::engine::Watch>::print_utf8+0xe2d>
  263149:	jmp    262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  26314e:	cmp    $0xfe,%r12d
  263155:	je     262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  26315b:	mov    $0xfe,%al
  26315d:	cmp    $0x7f,%ebp
  263160:	jae    26316c <<glass::engine::Watch>::print_utf8+0xdfc>
  263162:	mov    $0x1,%r12d
  263168:	xor    %ecx,%ecx
  26316a:	jmp    263191 <<glass::engine::Watch>::print_utf8+0xe21>
  26316c:	cmp    $0xa0,%ebp
  263172:	jb     26318f <<glass::engine::Watch>::print_utf8+0xe1f>
  263174:	mov    %ebp,%edi
  263176:	mov    %r8,%r15
  263179:	mov    %rdx,%r12
  26317c:	call   2987a0 <unicode_width::tables::lookup_width>
  263181:	mov    %r12,%rdx
  263184:	mov    %r15,%r8
  263187:	movzbl %al,%r12d
  26318b:	mov    $0x1,%cl
  26318d:	jmp    263191 <<glass::engine::Watch>::print_utf8+0xe21>
  26318f:	xor    %ecx,%ecx
  263191:	mov    %al,(%r14,%rbx,1)
  263195:	test   %cl,%cl
  263197:	je     262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  26319d:	lea    -0x1(%r12),%rax
  2631a2:	cmp    $0x1,%rax
  2631a6:	ja     262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  2631ac:	mov    0xc8(%rsp),%rax
  2631b4:	mov    0x78(%rax),%r9
  2631b8:	cmpb   $0x0,0x6c(%r9)
  2631bd:	jne    262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  2631c3:	mov    0x40(%r9),%rbx
  2631c7:	mov    0xa0(%r9),%r11
  2631ce:	lea    (%rbx,%r12,1),%r10
  2631d2:	cmp    %r11,%r10
  2631d5:	ja     262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  2631db:	mov    0x30(%r9),%eax
  2631df:	sub    0x48(%r9),%eax
  2631e3:	cltq
  2631e5:	mov    0x20(%r9),%rsi
  2631e9:	mov    0x28(%r9),%rcx
  2631ed:	lea    (%rcx,%rax,1),%rdi
  2631f1:	dec    %rdi
  2631f4:	cmp    %rsi,%rdi
  2631f7:	mov    $0x0,%eax
  2631fc:	cmovae %rsi,%rax
  263200:	sub    %rax,%rdi
  263203:	cmp    %rsi,%rdi
  263206:	jae    2643eb <<glass::engine::Watch>::print_utf8+0x207b>
  26320c:	mov    0x58(%r9),%eax
  263210:	mov    %eax,0x58(%rsp)
  263214:	mov    0x5c(%r9),%eax
  263218:	mov    %eax,0xa0(%rsp)
  26321f:	movzwl 0x64(%r9),%r14d
  263224:	mov    0x18(%r9),%rax
  263228:	shl    $0x6,%rdi
  26322c:	lea    (%rax,%rdi,1),%r15
  263230:	lea    (%rax,%rdi,1),%rcx
  263234:	add    $0x18,%rcx
  263238:	mov    %rcx,0x78(%rsp)
  26323d:	mov    0x28(%rax,%rdi,1),%eax
  263241:	cmp    $0xffffffff,%eax
  263244:	je     263251 <<glass::engine::Watch>::print_utf8+0xee1>
  263246:	mov    0x78(%rsp),%rcx
  26324b:	cmp    0x30(%r15),%rbx
  26324f:	jae    26326a <<glass::engine::Watch>::print_utf8+0xefa>
  263251:	mov    0x10(%r15),%rsi
  263255:	cmp    %rsi,%rbx
  263258:	jae    2643f8 <<glass::engine::Watch>::print_utf8+0x2088>
  26325e:	lea    (%rbx,%rbx,2),%rcx
  263262:	shl    $0x3,%rcx
  263266:	add    0x8(%r15),%rcx
  26326a:	testb  $0x60,0x14(%rcx)
  26326e:	jne    262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  263274:	cmp    $0x2,%r12
  263278:	jne    2632b1 <<glass::engine::Watch>::print_utf8+0xf41>
  26327a:	lea    0x1(%rbx),%rdi
  26327e:	cmp    $0xffffffff,%eax
  263281:	je     26328e <<glass::engine::Watch>::print_utf8+0xf1e>
  263283:	mov    0x78(%rsp),%rcx
  263288:	cmp    0x30(%r15),%rdi
  26328c:	jae    2632a7 <<glass::engine::Watch>::print_utf8+0xf37>
  26328e:	mov    0x10(%r15),%rsi
  263292:	cmp    %rsi,%rdi
  263295:	jae    26441c <<glass::engine::Watch>::print_utf8+0x20ac>
  26329b:	lea    (%rdi,%rdi,2),%rcx
  26329f:	shl    $0x3,%rcx
  2632a3:	add    0x8(%r15),%rcx
  2632a7:	testb  $0x60,0x14(%rcx)
  2632ab:	jne    262ed0 <<glass::engine::Watch>::print_utf8+0xb60>
  2632b1:	mov    %rdx,0x28(%rsp)
  2632b6:	cmp    %ebx,0x38(%r15)
  2632ba:	jbe    2632c0 <<glass::engine::Watch>::print_utf8+0xf50>
  2632bc:	mov    %ebx,0x38(%r15)
  2632c0:	mov    %r14d,0xc(%rsp)
  2632c5:	mov    %r11,0x90(%rsp)
  2632cd:	cmp    $0xffffffff,%eax
  2632d0:	setne  %dl
  2632d3:	mov    0x30(%r15),%rcx
  2632d7:	cmp    %rcx,%rbx
  2632da:	sete   %sil
  2632de:	test   %sil,%dl
  2632e1:	mov    %rbx,0x20(%rsp)
  2632e6:	mov    %r15,0x38(%rsp)
  2632eb:	mov    %r9,0x60(%rsp)
  2632f0:	mov    %r10,0x70(%rsp)
  2632f5:	jne    26336e <<glass::engine::Watch>::print_utf8+0xffe>
  2632f7:	cmp    $0xffffffff,%eax
  2632fa:	mov    0x30(%rsp),%r14
  2632ff:	je     2635bd <<glass::engine::Watch>::print_utf8+0x124d>
  263305:	mov    0x10(%r15),%rax
  263309:	cmp    %rcx,%rax
  26330c:	mov    %rcx,%rdx
  26330f:	cmovb  %rax,%rdx
  263313:	mov    %rdx,0xa8(%rsp)
  26331b:	cmp    %rbx,%rax
  26331e:	mov    %rbx,%rsi
  263321:	cmovb  %rax,%rsi
  263325:	mov    0x38e754(%rip),%rdx        # 5f1a80 <_DYNAMIC+0x320>
  26332c:	movzbl (%rdx),%edx
  26332f:	test   %dl,%dl
  263331:	je     2633db <<glass::engine::Watch>::print_utf8+0x106b>
  263337:	mov    0x38e77a(%rip),%rdx        # 5f1ab8 <_DYNAMIC+0x358>
  26333e:	mov    %rsi,%r11
  263341:	cmp    %rsi,%rcx
  263344:	jae    26334d <<glass::engine::Watch>::print_utf8+0xfdd>
  263346:	mov    0x38e773(%rip),%rdx        # 5f1ac0 <_DYNAMIC+0x360>
  26334d:	lock incq 0x28(%rdx)
  263352:	mov    0x38e73f(%rip),%rdx        # 5f1a98 <_DYNAMIC+0x338>
  263359:	lock incq (%rdx)
  26335d:	mov    %r11,%rdx
  263360:	sub    0xa8(%rsp),%rdx
  263368:	jne    26338d <<glass::engine::Watch>::print_utf8+0x101d>
  26336a:	xor    %esi,%esi
  26336c:	jmp    2633cc <<glass::engine::Watch>::print_utf8+0x105c>
  26336e:	lea    0x1(%rbx),%rax
  263372:	mov    %rax,0x30(%r15)
  263376:	mov    0x10(%r15),%rsi
  26337a:	cmp    %rsi,%rbx
  26337d:	mov    0x30(%rsp),%r14
  263382:	jb     2635dd <<glass::engine::Watch>::print_utf8+0x126d>
  263388:	jmp    264429 <<glass::engine::Watch>::print_utf8+0x20b9>
  26338d:	mov    0x38e70c(%rip),%rsi        # 5f1aa0 <_DYNAMIC+0x340>
  263394:	lock add %rdx,(%rsi)
  263398:	cmp    $0x5,%rdx
  26339c:	jae    2633ac <<glass::engine::Watch>::print_utf8+0x103c>
  26339e:	lea    -0x20588d(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2633a5:	movzbl -0x1(%rdx,%rsi,1),%esi
  2633aa:	jmp    2633cc <<glass::engine::Watch>::print_utf8+0x105c>
  2633ac:	lea    -0x5(%rdx),%rdi
  2633b0:	mov    $0x4,%esi
  2633b5:	cmp    $0x4,%rdi
  2633b9:	jb     2633cc <<glass::engine::Watch>::print_utf8+0x105c>
  2633bb:	add    $0xfffffffffffffff7,%rdx
  2633bf:	cmp    $0x8,%rdx
  2633c3:	mov    $0x6,%esi
  2633c8:	sbb    $0x0,%rsi
  2633cc:	mov    0x38e6bd(%rip),%rdx        # 5f1a90 <_DYNAMIC+0x330>
  2633d3:	lock incq (%rdx,%rsi,8)
  2633d8:	mov    %r11,%rsi
  2633db:	cmp    %rsi,%rcx
  2633de:	jae    26357b <<glass::engine::Watch>::print_utf8+0x120b>
  2633e4:	mov    0x28(%r15),%edi
  2633e8:	mov    0x20(%r15),%r10d
  2633ec:	mov    0x24(%r15),%r11d
  2633f0:	movzwl 0x2c(%r15),%ecx
  2633f5:	mov    0x18(%r15),%rax
  2633f9:	test   %rax,%rax
  2633fc:	mov    %rax,0x68(%rsp)
  263401:	je     263436 <<glass::engine::Watch>::print_utf8+0x10c6>
  263403:	lock incq (%rax)
  263407:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  26340d:	mov    0x10(%r15),%rdx
  263411:	mov    %edi,0x50(%rsp)
  263415:	mov    %r10d,0x48(%rsp)
  26341a:	mov    %r11d,0x4c(%rsp)
  26341f:	mov    %ecx,%r9d
  263422:	mov    %cx,0x54(%rsp)
  263427:	mov    %rax,0x40(%rsp)
  26342c:	cmp    %rdx,%rsi
  26342f:	jbe    263451 <<glass::engine::Watch>::print_utf8+0x10e1>
  263431:	jmp    264358 <<glass::engine::Watch>::print_utf8+0x1fe8>
  263436:	mov    %edi,0x50(%rsp)
  26343a:	mov    %r10d,0x48(%rsp)
  26343f:	mov    %r11d,0x4c(%rsp)
  263444:	mov    %cx,0x54(%rsp)
  263449:	mov    %rax,0x40(%rsp)
  26344e:	mov    %ecx,%r9d
  263451:	mov    0xa8(%rsp),%rax
  263459:	lea    0x0(,%rax,8),%rax
  263461:	lea    (%rax,%rax,2),%rax
  263465:	mov    0x8(%r15),%rbx
  263469:	add    %rax,%rbx
  26346c:	mov    %rsi,0xd0(%rsp)
  263474:	lea    0x0(,%rsi,8),%rcx
  26347c:	lea    (%rcx,%rcx,2),%r14
  263480:	sub    %rax,%r14
  263483:	mov    0x68(%rsp),%rcx
  263488:	mov    %edi,0x98(%rsp)
  26348f:	mov    %r10d,0x8c(%rsp)
  263497:	mov    %r11d,0xb8(%rsp)
  26349f:	mov    %r9w,0xd8(%rsp)
  2634a8:	jmp    2634cd <<glass::engine::Watch>::print_utf8+0x115d>
  2634aa:	nopw   0x0(%rax,%rax,1)
  2634b0:	mov    %rcx,(%rbx)
  2634b3:	mov    %r10d,0x8(%rbx)
  2634b7:	mov    %r11d,0xc(%rbx)
  2634bb:	mov    %edi,0x10(%rbx)
  2634be:	mov    %r9w,0x14(%rbx)
  2634c3:	add    $0x18,%rbx
  2634c7:	add    $0xffffffffffffffe8,%r14
  2634cb:	je     263525 <<glass::engine::Watch>::print_utf8+0x11b5>
  2634cd:	test   %rcx,%rcx
  2634d0:	je     2634dc <<glass::engine::Watch>::print_utf8+0x116c>
  2634d2:	lock incq (%rcx)
  2634d6:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  2634dc:	mov    (%rbx),%rax
  2634df:	test   %rax,%rax
  2634e2:	je     2634b0 <<glass::engine::Watch>::print_utf8+0x1140>
  2634e4:	lock decq (%rax)
  2634e8:	jne    2634b0 <<glass::engine::Watch>::print_utf8+0x1140>
  2634ea:	mov    %rbx,%rdi
  2634ed:	mov    %r8,%r15
  2634f0:	call   *0x38e4d2(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  2634f6:	movzwl 0xd8(%rsp),%r9d
  2634ff:	mov    0xb8(%rsp),%r11d
  263507:	mov    0x8c(%rsp),%r10d
  26350f:	mov    0x98(%rsp),%edi
  263516:	mov    0x68(%rsp),%rcx
  26351b:	mov    %r15,%r8
  26351e:	mov    0x38(%rsp),%r15
  263523:	jmp    2634b0 <<glass::engine::Watch>::print_utf8+0x1140>
  263525:	mov    0xa8(%rsp),%rax
  26352d:	cmp    %eax,0x38(%r15)
  263531:	mov    0x30(%rsp),%r14
  263536:	mov    0x20(%rsp),%rbx
  26353b:	jbe    263541 <<glass::engine::Watch>::print_utf8+0x11d1>
  26353d:	mov    %eax,0x38(%r15)
  263541:	test   %rcx,%rcx
  263544:	mov    0xd0(%rsp),%rsi
  26354c:	je     263577 <<glass::engine::Watch>::print_utf8+0x1207>
  26354e:	lock decq (%rcx)
  263552:	jne    263577 <<glass::engine::Watch>::print_utf8+0x1207>
  263554:	lea    0x40(%rsp),%rdi
  263559:	mov    %r8,%rbx
  26355c:	call   *0x38e466(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  263562:	mov    0xd0(%rsp),%rsi
  26356a:	mov    %rbx,%r8
  26356d:	mov    0x20(%rsp),%rbx
  263572:	mov    0x38(%rsp),%r15
  263577:	mov    0x10(%r15),%rax
  26357b:	cmp    %rax,%rsi
  26357e:	jb     2635bd <<glass::engine::Watch>::print_utf8+0x124d>
  263580:	cmpl   $0xffffffff,0x28(%r15)
  263585:	je     2635b5 <<glass::engine::Watch>::print_utf8+0x1245>
  263587:	mov    0x78(%rsp),%rax
  26358c:	mov    (%rax),%rax
  26358f:	test   %rax,%rax
  263592:	je     2635b5 <<glass::engine::Watch>::print_utf8+0x1245>
  263594:	lock decq (%rax)
  263598:	jne    2635b5 <<glass::engine::Watch>::print_utf8+0x1245>
  26359a:	mov    0x78(%rsp),%rdi
  26359f:	mov    %r8,%rbx
  2635a2:	call   *0x38e420(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  2635a8:	mov    %rbx,%r8
  2635ab:	mov    0x20(%rsp),%rbx
  2635b0:	mov    0x38(%rsp),%r15
  2635b5:	movl   $0xffffffff,0x28(%r15)
  2635bd:	mov    0x30(%r15),%rax
  2635c1:	lea    0x1(%rbx),%rcx
  2635c5:	cmp    %rax,%rcx
  2635c8:	cmova  %rcx,%rax
  2635cc:	mov    0x10(%r15),%rsi
  2635d0:	mov    %rax,0x30(%r15)
  2635d4:	cmp    %rsi,%rbx
  2635d7:	jae    264439 <<glass::engine::Watch>::print_utf8+0x20c9>
  2635dd:	mov    0xc(%rsp),%esi
  2635e1:	mov    %esi,%eax
  2635e3:	or     $0x20,%eax
  2635e6:	cmp    $0x2,%r12
  2635ea:	mov    0x8(%r15),%rcx
  2635ee:	lea    (%rbx,%rbx,2),%rdx
  2635f2:	lea    (%rcx,%rdx,8),%rbx
  2635f6:	mov    %ebp,0x10(%rcx,%rdx,8)
  2635fa:	mov    0x58(%rsp),%ebp
  2635fe:	mov    %ebp,0x8(%rcx,%rdx,8)
  263602:	cmovne %esi,%eax
  263605:	mov    0xa0(%rsp),%esi
  26360c:	mov    %esi,0xc(%rcx,%rdx,8)
  263610:	mov    %ax,0x14(%rcx,%rdx,8)
  263615:	mov    (%rcx,%rdx,8),%rax
  263619:	test   %rax,%rax
  26361c:	je     263638 <<glass::engine::Watch>::print_utf8+0x12c8>
  26361e:	lock decq (%rax)
  263622:	jne    263638 <<glass::engine::Watch>::print_utf8+0x12c8>
  263624:	mov    %rbx,%rdi
  263627:	mov    %r8,%r15
  26362a:	call   *0x38e398(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  263630:	mov    %r15,%r8
  263633:	mov    0x38(%rsp),%r15
  263638:	movq   $0x0,(%rbx)
  26363f:	cmp    $0x2,%r12
  263643:	mov    0x28(%rsp),%rdx
  263648:	jne    263978 <<glass::engine::Watch>::print_utf8+0x1608>
  26364e:	mov    0x20(%rsp),%r9
  263653:	lea    0x1(%r9),%r12
  263657:	mov    0x30(%r15),%rax
  26365b:	mov    0x28(%r15),%ecx
  26365f:	cmp    %rax,%r12
  263662:	jne    263683 <<glass::engine::Watch>::print_utf8+0x1313>
  263664:	cmp    $0xffffffff,%ecx
  263667:	je     263683 <<glass::engine::Watch>::print_utf8+0x1313>
  263669:	add    $0x2,%r9
  26366d:	mov    %r9,0x30(%r15)
  263671:	mov    0x10(%r15),%rsi
  263675:	cmp    %rsi,%r12
  263678:	jb     26391f <<glass::engine::Watch>::print_utf8+0x15af>
  26367e:	jmp    263cfe <<glass::engine::Watch>::print_utf8+0x198e>
  263683:	cmp    $0xffffffff,%ecx
  263686:	je     2638ff <<glass::engine::Watch>::print_utf8+0x158f>
  26368c:	mov    0x10(%r15),%rcx
  263690:	cmp    %rax,%rcx
  263693:	mov    %rax,%rdi
  263696:	cmovb  %rcx,%rdi
  26369a:	cmp    %r12,%rcx
  26369d:	mov    %r12,%r10
  2636a0:	cmovb  %rcx,%r10
  2636a4:	mov    0x38e3d5(%rip),%rdx        # 5f1a80 <_DYNAMIC+0x320>
  2636ab:	movzbl (%rdx),%edx
  2636ae:	test   %dl,%dl
  2636b0:	je     26372c <<glass::engine::Watch>::print_utf8+0x13bc>
  2636b2:	mov    0x38e3ff(%rip),%rdx        # 5f1ab8 <_DYNAMIC+0x358>
  2636b9:	cmp    %r10,%rax
  2636bc:	jae    2636c5 <<glass::engine::Watch>::print_utf8+0x1355>
  2636be:	mov    0x38e3fb(%rip),%rdx        # 5f1ac0 <_DYNAMIC+0x360>
  2636c5:	lock incq 0x28(%rdx)
  2636ca:	mov    0x38e3c7(%rip),%rdx        # 5f1a98 <_DYNAMIC+0x338>
  2636d1:	lock incq (%rdx)
  2636d5:	mov    %r10,%rdx
  2636d8:	sub    %rdi,%rdx
  2636db:	jne    2636e1 <<glass::engine::Watch>::print_utf8+0x1371>
  2636dd:	xor    %esi,%esi
  2636df:	jmp    263720 <<glass::engine::Watch>::print_utf8+0x13b0>
  2636e1:	mov    0x38e3b8(%rip),%rsi        # 5f1aa0 <_DYNAMIC+0x340>
  2636e8:	lock add %rdx,(%rsi)
  2636ec:	cmp    $0x5,%rdx
  2636f0:	jae    263700 <<glass::engine::Watch>::print_utf8+0x1390>
  2636f2:	lea    -0x205be1(%rip),%rsi        # 5db18 <anon.8034cc74746c0f700f1d2bb865899118.87.llvm.9621187620753702693+0xc0>
  2636f9:	movzbl -0x1(%rdx,%rsi,1),%esi
  2636fe:	jmp    263720 <<glass::engine::Watch>::print_utf8+0x13b0>
  263700:	lea    -0x5(%rdx),%r11
  263704:	mov    $0x4,%esi
  263709:	cmp    $0x4,%r11
  26370d:	jb     263720 <<glass::engine::Watch>::print_utf8+0x13b0>
  26370f:	add    $0xfffffffffffffff7,%rdx
  263713:	cmp    $0x8,%rdx
  263717:	mov    $0x6,%esi
  26371c:	sbb    $0x0,%rsi
  263720:	mov    0x38e369(%rip),%rdx        # 5f1a90 <_DYNAMIC+0x330>
  263727:	lock incq (%rdx,%rsi,8)
  26372c:	cmp    %r10,%rax
  26372f:	mov    0x28(%rsp),%rdx
  263734:	jae    2638d8 <<glass::engine::Watch>::print_utf8+0x1568>
  26373a:	mov    %r12,0xd8(%rsp)
  263742:	mov    0x28(%r15),%r9d
  263746:	mov    0x20(%r15),%r11d
  26374a:	mov    0x24(%r15),%ebp
  26374e:	movzwl 0x2c(%r15),%eax
  263753:	mov    0x18(%r15),%r12
  263757:	test   %r12,%r12
  26375a:	mov    %r12,0x98(%rsp)
  263762:	mov    %ax,0x68(%rsp)
  263767:	je     26379d <<glass::engine::Watch>::print_utf8+0x142d>
  263769:	lock incq (%r12)
  26376e:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  263774:	mov    0x10(%r15),%rdx
  263778:	mov    %r9d,0x50(%rsp)
  26377d:	mov    %r11d,0x48(%rsp)
  263782:	mov    %ebp,0x4c(%rsp)
  263786:	mov    %ax,0x54(%rsp)
  26378b:	mov    %r12,0x40(%rsp)
  263790:	cmp    %rdx,%r10
  263793:	mov    %r10,%rsi
  263796:	jbe    2637b8 <<glass::engine::Watch>::print_utf8+0x1448>
  263798:	jmp    264372 <<glass::engine::Watch>::print_utf8+0x2002>
  26379d:	mov    %r9d,0x50(%rsp)
  2637a2:	mov    %r11d,0x48(%rsp)
  2637a7:	mov    %ebp,0x4c(%rsp)
  2637ab:	mov    %ax,0x54(%rsp)
  2637b0:	mov    %r12,0x40(%rsp)
  2637b5:	mov    %r10,%rsi
  2637b8:	mov    %rdi,0xa8(%rsp)
  2637c0:	lea    0x0(,%rdi,8),%rax
  2637c8:	lea    (%rax,%rax,2),%rax
  2637cc:	mov    0x8(%r15),%rbx
  2637d0:	add    %rax,%rbx
  2637d3:	mov    %rsi,0xb8(%rsp)
  2637db:	lea    0x0(,%rsi,8),%rcx
  2637e3:	lea    (%rcx,%rcx,2),%r14
  2637e7:	sub    %rax,%r14
  2637ea:	movzwl 0x68(%rsp),%ecx
  2637ef:	mov    %ebp,0x8c(%rsp)
  2637f6:	jmp    26381c <<glass::engine::Watch>::print_utf8+0x14ac>
  2637f8:	nopl   0x0(%rax,%rax,1)
  263800:	mov    %r12,(%rbx)
  263803:	mov    %r11d,0x8(%rbx)
  263807:	mov    %ebp,0xc(%rbx)
  26380a:	mov    %r9d,0x10(%rbx)
  26380e:	mov    %cx,0x14(%rbx)
  263812:	add    $0x18,%rbx
  263816:	add    $0xffffffffffffffe8,%r14
  26381a:	je     263870 <<glass::engine::Watch>::print_utf8+0x1500>
  26381c:	test   %r12,%r12
  26381f:	je     26382c <<glass::engine::Watch>::print_utf8+0x14bc>
  263821:	lock incq (%r12)
  263826:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  26382c:	mov    (%rbx),%rax
  26382f:	test   %rax,%rax
  263832:	je     263800 <<glass::engine::Watch>::print_utf8+0x1490>
  263834:	lock decq (%rax)
  263838:	jne    263800 <<glass::engine::Watch>::print_utf8+0x1490>
  26383a:	mov    %rbx,%rdi
  26383d:	mov    %r8,%r15
  263840:	mov    %r9d,%ebp
  263843:	mov    %r11d,%r12d
  263846:	call   *0x38e17c(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  26384c:	movzwl 0x68(%rsp),%ecx
  263851:	mov    %r12d,%r11d
  263854:	mov    0x98(%rsp),%r12
  26385c:	mov    %ebp,%r9d
  26385f:	mov    0x8c(%rsp),%ebp
  263866:	mov    %r15,%r8
  263869:	mov    0x38(%rsp),%r15
  26386e:	jmp    263800 <<glass::engine::Watch>::print_utf8+0x1490>
  263870:	mov    0xa8(%rsp),%rax
  263878:	cmp    %eax,0x38(%r15)
  26387c:	mov    0x30(%rsp),%r14
  263881:	mov    0x28(%rsp),%rdx
  263886:	mov    0x20(%rsp),%r9
  26388b:	jbe    263891 <<glass::engine::Watch>::print_utf8+0x1521>
  26388d:	mov    %eax,0x38(%r15)
  263891:	test   %r12,%r12
  263894:	mov    0x58(%rsp),%ebp
  263898:	mov    0xb8(%rsp),%r10
  2638a0:	je     2638cc <<glass::engine::Watch>::print_utf8+0x155c>
  2638a2:	lock decq (%r12)
  2638a7:	jne    2638cc <<glass::engine::Watch>::print_utf8+0x155c>
  2638a9:	lea    0x40(%rsp),%rdi
  2638ae:	mov    %r8,%rbx
  2638b1:	call   *0x38e111(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  2638b7:	mov    0x28(%rsp),%rdx
  2638bc:	mov    %rbx,%r8
  2638bf:	mov    0xb8(%rsp),%r10
  2638c7:	mov    0x20(%rsp),%r9
  2638cc:	mov    0x10(%r15),%rcx
  2638d0:	mov    0xd8(%rsp),%r12
  2638d8:	cmp    %rcx,%r10
  2638db:	jb     2638ff <<glass::engine::Watch>::print_utf8+0x158f>
  2638dd:	mov    0x78(%rsp),%rdi
  2638e2:	mov    %r8,%rbx
  2638e5:	call   1ad4a0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  2638ea:	mov    0x28(%rsp),%rdx
  2638ef:	mov    %rbx,%r8
  2638f2:	mov    0x20(%rsp),%r9
  2638f7:	movl   $0xffffffff,0x28(%r15)
  2638ff:	mov    0x30(%r15),%rax
  263903:	add    $0x2,%r9
  263907:	cmp    %rax,%r9
  26390a:	cmovbe %rax,%r9
  26390e:	mov    0x10(%r15),%rsi
  263912:	mov    %r9,0x30(%r15)
  263916:	cmp    %rsi,%r12
  263919:	jae    264449 <<glass::engine::Watch>::print_utf8+0x20d9>
  26391f:	mov    0x8(%r15),%rax
  263923:	lea    (%r12,%r12,2),%rcx
  263927:	lea    (%rax,%rcx,8),%rbx
  26392b:	movl   $0x20,0x10(%rax,%rcx,8)
  263933:	mov    %ebp,0x8(%rax,%rcx,8)
  263937:	mov    0xa0(%rsp),%esi
  26393e:	mov    %esi,0xc(%rax,%rcx,8)
  263942:	mov    0xc(%rsp),%esi
  263946:	or     $0x40,%esi
  263949:	mov    %si,0x14(%rax,%rcx,8)
  26394e:	mov    (%rax,%rcx,8),%rax
  263952:	test   %rax,%rax
  263955:	je     263971 <<glass::engine::Watch>::print_utf8+0x1601>
  263957:	lock decq (%rax)
  26395b:	jne    263971 <<glass::engine::Watch>::print_utf8+0x1601>
  26395d:	mov    %rbx,%rdi
  263960:	mov    %r8,%r15
  263963:	call   *0x38e05f(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  263969:	mov    0x28(%rsp),%rdx
  26396e:	mov    %r15,%r8
  263971:	movq   $0x0,(%rbx)
  263978:	mov    0x70(%rsp),%rcx
  26397d:	cmp    0x90(%rsp),%rcx
  263985:	mov    0x18(%rsp),%rsi
  26398a:	mov    0x60(%rsp),%rax
  26398f:	jb     263998 <<glass::engine::Watch>::print_utf8+0x1628>
  263991:	dec    %rcx
  263994:	movb   $0x1,0x6c(%rax)
  263998:	mov    %rcx,0x40(%rax)
  26399c:	mov    0xc8(%rsp),%r15
  2639a4:	incq   0xa0(%r15)
  2639ab:	nopl   0x0(%rax,%rax,1)
  2639b0:	add    %r14,%rdx
  2639b3:	cmpb   $0x0,0x80(%rsp)
  2639bb:	je     262f09 <<glass::engine::Watch>::print_utf8+0xb99>
  2639c1:	jmp    262420 <<glass::engine::Watch>::print_utf8+0xb0>
  2639c6:	mov    %r8,%rbx
  2639c9:	mov    %rdx,%r14
  2639cc:	call   18b9a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  2639d1:	mov    %r14,%rdx
  2639d4:	mov    %rbx,%r8
  2639d7:	mov    %ebp,%ebx
  2639d9:	mov    0x390f50(%rip),%rsi        # 5f4930 <glass::engine::width_of::CACHE+0x8>
  2639e0:	cmp    %rbx,%rsi
  2639e3:	ja     26312e <<glass::engine::Watch>::print_utf8+0xdbe>
  2639e9:	jmp    264348 <<glass::engine::Watch>::print_utf8+0x1fd8>
  2639ee:	cmpq   $0x400,0xa0(%r15)
  2639f9:	jb     263a24 <<glass::engine::Watch>::print_utf8+0x16b4>
  2639fb:	mov    %r15,%rdi
  2639fe:	call   2647c0 <<glass::engine::Watch>::fold_sentinel>
  263a03:	movq   $0x0,0xa0(%r15)
  263a0e:	mov    0x390f2c(%rip),%eax        # 5f4940 <glass::engine::run_whole::ON>
  263a14:	test   %eax,%eax
  263a16:	je     263a2e <<glass::engine::Watch>::print_utf8+0x16be>
  263a18:	call   18ba46 <<std::sync::once_lock::OnceLock<bool>>::initialize::<<std::sync::once_lock::OnceLock<bool>>::get_or_init<glass::engine::run_whole::{closure#0}>::{closure#0}, !>>
  263a1d:	cmp    %r13,%r14
  263a20:	je     263a33 <<glass::engine::Watch>::print_utf8+0x16c3>
  263a22:	jmp    263a63 <<glass::engine::Watch>::print_utf8+0x16f3>
  263a24:	mov    0x390f16(%rip),%eax        # 5f4940 <glass::engine::run_whole::ON>
  263a2a:	test   %eax,%eax
  263a2c:	jne    263a18 <<glass::engine::Watch>::print_utf8+0x16a8>
  263a2e:	cmp    %r13,%r14
  263a31:	jne    263a63 <<glass::engine::Watch>::print_utf8+0x16f3>
  263a33:	cmpb   $0x0,0x390f0a(%rip)        # 5f4944 <glass::engine::run_whole::ON+0x4>
  263a3a:	je     263a63 <<glass::engine::Watch>::print_utf8+0x16f3>
  263a3c:	cmp    $0xffffffff,%ebp
  263a3f:	je     263c05 <<glass::engine::Watch>::print_utf8+0x1895>
  263a45:	lea    -0x20(%rbp),%eax
  263a48:	cmp    $0x5f,%eax
  263a4b:	jae    263a74 <<glass::engine::Watch>::print_utf8+0x1704>
  263a4d:	mov    $0x1,%r13d
  263a53:	cmpb   $0x0,0x10(%rsp)
  263a58:	jne    263b3f <<glass::engine::Watch>::print_utf8+0x17cf>
  263a5e:	jmp    263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263a63:	xor    %eax,%eax
  263a65:	cmp    $0xffffffff,%ebp
  263a68:	cmove  %rax,%rbx
  263a6c:	mov    %rbx,%r13
  263a6f:	jmp    263c05 <<glass::engine::Watch>::print_utf8+0x1895>
  263a74:	cmpb   $0x0,0x80(%rsp)
  263a7c:	je     263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263a82:	mov    0x390eb0(%rip),%eax        # 5f4938 <glass::engine::width_of::CACHE+0x10>
  263a88:	test   %eax,%eax
  263a8a:	jne    264331 <<glass::engine::Watch>::print_utf8+0x1fc1>
  263a90:	mov    %ebp,%ebx
  263a92:	mov    0x390e97(%rip),%rsi        # 5f4930 <glass::engine::width_of::CACHE+0x8>
  263a99:	cmp    %rbx,%rsi
  263a9c:	jbe    264348 <<glass::engine::Watch>::print_utf8+0x1fd8>
  263aa2:	mov    0x390e7f(%rip),%r14        # 5f4928 <glass::engine::width_of::CACHE>
  263aa9:	movzbl (%r14,%rbx,1),%eax
  263aae:	movzbl %al,%r13d
  263ab2:	test   %r13b,%r13b
  263ab5:	js     263ac2 <<glass::engine::Watch>::print_utf8+0x1752>
  263ab7:	mov    $0x1,%cl
  263ab9:	test   %cl,%cl
  263abb:	jne    263b31 <<glass::engine::Watch>::print_utf8+0x17c1>
  263abd:	jmp    263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263ac2:	cmp    $0xfe,%r13d
  263ac9:	je     263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263acf:	mov    $0xfe,%al
  263ad1:	cmp    $0x7f,%ebp
  263ad4:	jae    263b0c <<glass::engine::Watch>::print_utf8+0x179c>
  263ad6:	mov    $0x1,%r13d
  263adc:	xor    %ecx,%ecx
  263ade:	jmp    263b25 <<glass::engine::Watch>::print_utf8+0x17b5>
  263ae0:	mov    $0x1,%cl
  263ae2:	mov    %ecx,0x80(%rsp)
  263ae9:	cmpb   $0x0,0x68(%rax)
  263aed:	jne    263aff <<glass::engine::Watch>::print_utf8+0x178f>
  263aef:	cmpb   $0x0,0x69(%rax)
  263af3:	jne    263aff <<glass::engine::Watch>::print_utf8+0x178f>
  263af5:	cmpb   $0x0,0x6a(%rax)
  263af9:	je     263d1e <<glass::engine::Watch>::print_utf8+0x19ae>
  263aff:	movl   $0x0,0x10(%rsp)
  263b07:	jmp    2623ce <<glass::engine::Watch>::print_utf8+0x5e>
  263b0c:	cmp    $0xa0,%ebp
  263b12:	jb     263b23 <<glass::engine::Watch>::print_utf8+0x17b3>
  263b14:	mov    %ebp,%edi
  263b16:	call   2987a0 <unicode_width::tables::lookup_width>
  263b1b:	movzbl %al,%r13d
  263b1f:	mov    $0x1,%cl
  263b21:	jmp    263b25 <<glass::engine::Watch>::print_utf8+0x17b5>
  263b23:	xor    %ecx,%ecx
  263b25:	mov    %al,(%r14,%rbx,1)
  263b29:	test   %cl,%cl
  263b2b:	je     263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263b31:	lea    -0x1(%r13),%rax
  263b35:	cmp    $0x1,%rax
  263b39:	ja     263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263b3f:	mov    0x78(%r15),%r14
  263b43:	cmpb   $0x0,0x6c(%r14)
  263b48:	jne    263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263b4e:	mov    0x40(%r14),%r12
  263b52:	mov    0xa0(%r14),%r8
  263b59:	lea    (%r12,%r13,1),%rdx
  263b5d:	cmp    %r8,%rdx
  263b60:	ja     263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263b66:	mov    0x30(%r14),%eax
  263b6a:	sub    0x48(%r14),%eax
  263b6e:	cltq
  263b70:	mov    0x20(%r14),%rsi
  263b74:	mov    0x28(%r14),%rcx
  263b78:	lea    (%rcx,%rax,1),%rdi
  263b7c:	dec    %rdi
  263b7f:	xor    %eax,%eax
  263b81:	cmp    %rsi,%rdi
  263b84:	cmovae %rsi,%rax
  263b88:	sub    %rax,%rdi
  263b8b:	cmp    %rsi,%rdi
  263b8e:	jae    2643eb <<glass::engine::Watch>::print_utf8+0x207b>
  263b94:	mov    0x58(%r14),%r10d
  263b98:	mov    0x5c(%r14),%r11d
  263b9c:	movzwl 0x64(%r14),%r9d
  263ba1:	mov    0x18(%r14),%rax
  263ba5:	shl    $0x6,%rdi
  263ba9:	lea    (%rax,%rdi,1),%rbx
  263bad:	lea    (%rax,%rdi,1),%rcx
  263bb1:	add    $0x18,%rcx
  263bb5:	mov    %rcx,0x80(%rsp)
  263bbd:	mov    0x28(%rax,%rdi,1),%eax
  263bc1:	cmp    $0xffffffff,%eax
  263bc4:	je     263bd4 <<glass::engine::Watch>::print_utf8+0x1864>
  263bc6:	mov    0x80(%rsp),%rcx
  263bce:	cmp    0x30(%rbx),%r12
  263bd2:	jae    263bed <<glass::engine::Watch>::print_utf8+0x187d>
  263bd4:	mov    0x10(%rbx),%rsi
  263bd8:	cmp    %rsi,%r12
  263bdb:	jae    264459 <<glass::engine::Watch>::print_utf8+0x20e9>
  263be1:	lea    (%r12,%r12,2),%rcx
  263be5:	shl    $0x3,%rcx
  263be9:	add    0x8(%rbx),%rcx
  263bed:	testb  $0x60,0x14(%rcx)
  263bf1:	je     263c1a <<glass::engine::Watch>::print_utf8+0x18aa>
  263bf3:	mov    %r15,%rdi
  263bf6:	mov    %ebp,%esi
  263bf8:	call   33d350 <<glass::engine::Watch as vte::ansi::Handler>::input>
  263bfd:	mov    0xc0(%rsp),%r13
  263c05:	mov    %r13,%rax
  263c08:	add    $0x118,%rsp
  263c0f:	pop    %rbx
  263c10:	pop    %r12
  263c12:	pop    %r13
  263c14:	pop    %r14
  263c16:	pop    %r15
  263c18:	pop    %rbp
  263c19:	ret
  263c1a:	cmp    $0x2,%r13
  263c1e:	jne    263c57 <<glass::engine::Watch>::print_utf8+0x18e7>
  263c20:	lea    0x1(%r12),%rdi
  263c25:	cmp    $0xffffffff,%eax
  263c28:	je     263c38 <<glass::engine::Watch>::print_utf8+0x18c8>
  263c2a:	mov    0x80(%rsp),%rcx
  263c32:	cmp    0x30(%rbx),%rdi
  263c36:	jae    263c51 <<glass::engine::Watch>::print_utf8+0x18e1>
  263c38:	mov    0x10(%rbx),%rsi
  263c3c:	cmp    %rsi,%rdi
  263c3f:	jae    26441c <<glass::engine::Watch>::print_utf8+0x20ac>
  263c45:	lea    (%rdi,%rdi,2),%rcx
  263c49:	shl    $0x3,%rcx
  263c4d:	add    0x8(%rbx),%rcx
  263c51:	testb  $0x60,0x14(%rcx)
  263c55:	jne    263bf3 <<glass::engine::Watch>::print_utf8+0x1883>
  263c57:	mov    %r11d,0x78(%rsp)
  263c5c:	mov    %r10d,0x28(%rsp)
  263c61:	mov    %r9d,0x30(%rsp)
  263c66:	mov    %r8,0x58(%rsp)
  263c6b:	mov    %rdx,0xa0(%rsp)
  263c73:	cmp    %r12d,0x38(%rbx)
  263c77:	jbe    263c7d <<glass::engine::Watch>::print_utf8+0x190d>
  263c79:	mov    %r12d,0x38(%rbx)
  263c7d:	cmp    $0xffffffff,%eax
  263c80:	setne  %cl
  263c83:	mov    %rbx,%rdi
  263c86:	mov    0x30(%rbx),%rbx
  263c8a:	cmp    %rbx,%r12
  263c8d:	sete   %dl
  263c90:	test   %dl,%cl
  263c92:	mov    %rdi,0x18(%rsp)
  263c97:	jne    263ce5 <<glass::engine::Watch>::print_utf8+0x1975>
  263c99:	cmp    $0xffffffff,%eax
  263c9c:	je     263f4f <<glass::engine::Watch>::print_utf8+0x1bdf>
  263ca2:	mov    0x18(%rsp),%rax
  263ca7:	mov    0x10(%rax),%r15
  263cab:	cmp    %rbx,%r15
  263cae:	mov    %rbx,%rax
  263cb1:	cmovb  %r15,%rax
  263cb5:	mov    %rax,0x10(%rsp)
  263cba:	cmp    %r12,%r15
  263cbd:	mov    %r12,%rcx
  263cc0:	cmovb  %r15,%rcx
  263cc4:	mov    0x38ddb5(%rip),%rax        # 5f1a80 <_DYNAMIC+0x320>
  263ccb:	movzbl (%rax),%eax
  263cce:	test   %al,%al
  263cd0:	mov    %rcx,0x20(%rsp)
  263cd5:	je     263d4c <<glass::engine::Watch>::print_utf8+0x19dc>
  263cd7:	cmp    %rcx,%rbx
  263cda:	jae    263d2e <<glass::engine::Watch>::print_utf8+0x19be>
  263cdc:	mov    0x38dddd(%rip),%rax        # 5f1ac0 <_DYNAMIC+0x360>
  263ce3:	jmp    263d35 <<glass::engine::Watch>::print_utf8+0x19c5>
  263ce5:	lea    0x1(%r12),%rax
  263cea:	mov    %rax,0x30(%rdi)
  263cee:	mov    0x10(%rdi),%rsi
  263cf2:	cmp    %rsi,%r12
  263cf5:	mov    %rdi,%rdx
  263cf8:	jb     263f75 <<glass::engine::Watch>::print_utf8+0x1c05>
  263cfe:	lea    0x3655a3(%rip),%rdx        # 5c92a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  263d05:	mov    %r12,%rdi
  263d08:	call   *0x38dc6a(%rip)        # 5f1978 <_DYNAMIC+0x218>
  263d0e:	lea    0x3654eb(%rip),%rcx        # 5c9200 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15a80>
  263d15:	mov    %r12,%rdi
  263d18:	call   *0x38de1a(%rip)        # 5f1b38 <_DYNAMIC+0x3d8>
  263d1e:	cmpb   $0x0,0x6b(%rax)
  263d22:	sete   %al
  263d25:	mov    %eax,0x10(%rsp)
  263d29:	jmp    2623ce <<glass::engine::Watch>::print_utf8+0x5e>
  263d2e:	mov    0x38dd83(%rip),%rax        # 5f1ab8 <_DYNAMIC+0x358>
  263d35:	lock incq 0x28(%rax)
  263d3a:	mov    %rcx,%rdi
  263d3d:	sub    0x10(%rsp),%rdi
  263d42:	call   2f6f00 <alacritty_terminal::grid::row::fill_census::note>
  263d47:	mov    0x20(%rsp),%rcx
  263d4c:	cmp    %rcx,%rbx
  263d4f:	jae    263f29 <<glass::engine::Watch>::print_utf8+0x1bb9>
  263d55:	mov    0x18(%rsp),%rcx
  263d5a:	mov    0x28(%rcx),%edi
  263d5d:	mov    0x20(%rcx),%r8d
  263d61:	mov    0x24(%rcx),%r9d
  263d65:	movzwl 0x2c(%rcx),%r10d
  263d6a:	mov    0x18(%rcx),%rsi
  263d6e:	test   %rsi,%rsi
  263d71:	mov    %rsi,0x38(%rsp)
  263d76:	mov    %edi,0xc(%rsp)
  263d7a:	mov    %r8d,0x60(%rsp)
  263d7f:	mov    %r9d,0x70(%rsp)
  263d84:	mov    %r10w,0x90(%rsp)
  263d8d:	je     263e56 <<glass::engine::Watch>::print_utf8+0x1ae6>
  263d93:	lock incq (%rsi)
  263d97:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  263d9d:	mov    0x10(%rcx),%rdx
  263da1:	mov    %edi,0x50(%rsp)
  263da5:	mov    %r8d,0x48(%rsp)
  263daa:	mov    %r9d,0x4c(%rsp)
  263daf:	mov    %r10w,0x54(%rsp)
  263db5:	mov    %rsi,0x40(%rsp)
  263dba:	mov    0x20(%rsp),%rsi
  263dbf:	cmp    %rdx,%rsi
  263dc2:	ja     2643d7 <<glass::engine::Watch>::print_utf8+0x2067>
  263dc8:	mov    0x10(%rsp),%rax
  263dcd:	lea    0x0(,%rax,8),%rax
  263dd5:	lea    (%rax,%rax,2),%rax
  263dd9:	mov    0x8(%rcx),%rbx
  263ddd:	add    %rax,%rbx
  263de0:	lea    0x0(,%rsi,8),%rcx
  263de8:	lea    (%rcx,%rcx,2),%r15
  263dec:	sub    %rax,%r15
  263def:	mov    0x38(%rsp),%rsi
  263df4:	jmp    263e17 <<glass::engine::Watch>::print_utf8+0x1aa7>
  263df6:	mov    %rsi,(%rbx)
  263df9:	mov    %r8d,0x8(%rbx)
  263dfd:	mov    %r9d,0xc(%rbx)
  263e01:	mov    %edi,0x10(%rbx)
  263e04:	mov    %r10w,0x14(%rbx)
  263e09:	add    $0x18,%rbx
  263e0d:	add    $0xffffffffffffffe8,%r15
  263e11:	je     263ef3 <<glass::engine::Watch>::print_utf8+0x1b83>
  263e17:	lock incq (%rsi)
  263e1b:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  263e21:	mov    (%rbx),%rax
  263e24:	test   %rax,%rax
  263e27:	je     263df6 <<glass::engine::Watch>::print_utf8+0x1a86>
  263e29:	lock decq (%rax)
  263e2d:	jne    263df6 <<glass::engine::Watch>::print_utf8+0x1a86>
  263e2f:	mov    %rbx,%rdi
  263e32:	call   *0x38db90(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  263e38:	movzwl 0x90(%rsp),%r10d
  263e41:	mov    0x70(%rsp),%r9d
  263e46:	mov    0x60(%rsp),%r8d
  263e4b:	mov    0xc(%rsp),%edi
  263e4f:	mov    0x38(%rsp),%rsi
  263e54:	jmp    263df6 <<glass::engine::Watch>::print_utf8+0x1a86>
  263e56:	mov    %edi,0x50(%rsp)
  263e5a:	mov    %r8d,0x48(%rsp)
  263e5f:	mov    %r9d,0x4c(%rsp)
  263e64:	mov    %r10w,0x54(%rsp)
  263e6a:	mov    %rsi,0x40(%rsp)
  263e6f:	mov    0x10(%rsp),%rax
  263e74:	lea    0x0(,%rax,8),%rax
  263e7c:	lea    (%rax,%rax,2),%rax
  263e80:	mov    0x8(%rcx),%rbx
  263e84:	add    %rax,%rbx
  263e87:	mov    0x20(%rsp),%rcx
  263e8c:	lea    0x0(,%rcx,8),%rcx
  263e94:	lea    (%rcx,%rcx,2),%r15
  263e98:	sub    %rax,%r15
  263e9b:	jmp    263ebe <<glass::engine::Watch>::print_utf8+0x1b4e>
  263e9d:	movq   $0x0,(%rbx)
  263ea4:	mov    %r8d,0x8(%rbx)
  263ea8:	mov    %r9d,0xc(%rbx)
  263eac:	mov    %edi,0x10(%rbx)
  263eaf:	mov    %r10w,0x14(%rbx)
  263eb4:	add    $0x18,%rbx
  263eb8:	add    $0xffffffffffffffe8,%r15
  263ebc:	je     263ef3 <<glass::engine::Watch>::print_utf8+0x1b83>
  263ebe:	mov    (%rbx),%rax
  263ec1:	test   %rax,%rax
  263ec4:	je     263e9d <<glass::engine::Watch>::print_utf8+0x1b2d>
  263ec6:	lock decq (%rax)
  263eca:	jne    263e9d <<glass::engine::Watch>::print_utf8+0x1b2d>
  263ecc:	mov    %rbx,%rdi
  263ecf:	call   *0x38daf3(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  263ed5:	movzwl 0x90(%rsp),%r10d
  263ede:	mov    0x70(%rsp),%r9d
  263ee3:	mov    0x60(%rsp),%r8d
  263ee8:	mov    0xc(%rsp),%edi
  263eec:	mov    0x38(%rsp),%rsi
  263ef1:	jmp    263e9d <<glass::engine::Watch>::print_utf8+0x1b2d>
  263ef3:	mov    0x18(%rsp),%rbx
  263ef8:	mov    0x10(%rsp),%rax
  263efd:	cmp    %eax,0x38(%rbx)
  263f00:	jbe    263f05 <<glass::engine::Watch>::print_utf8+0x1b95>
  263f02:	mov    %eax,0x38(%rbx)
  263f05:	test   %rsi,%rsi
  263f08:	mov    0x20(%rsp),%rcx
  263f0d:	je     263f25 <<glass::engine::Watch>::print_utf8+0x1bb5>
  263f0f:	lock decq (%rsi)
  263f13:	jne    263f25 <<glass::engine::Watch>::print_utf8+0x1bb5>
  263f15:	lea    0x40(%rsp),%rdi
  263f1a:	call   *0x38daa8(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  263f20:	mov    0x20(%rsp),%rcx
  263f25:	mov    0x10(%rbx),%r15
  263f29:	cmp    %r15,%rcx
  263f2c:	mov    0xc8(%rsp),%r15
  263f34:	jb     263f4f <<glass::engine::Watch>::print_utf8+0x1bdf>
  263f36:	mov    0x80(%rsp),%rdi
  263f3e:	call   1ad4a0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  263f43:	mov    0x18(%rsp),%rax
  263f48:	movl   $0xffffffff,0x28(%rax)
  263f4f:	mov    0x18(%rsp),%rdx
  263f54:	mov    0x30(%rdx),%rax
  263f58:	lea    0x1(%r12),%rcx
  263f5d:	cmp    %rax,%rcx
  263f60:	cmova  %rcx,%rax
  263f64:	mov    0x10(%rdx),%rsi
  263f68:	mov    %rax,0x30(%rdx)
  263f6c:	cmp    %rsi,%r12
  263f6f:	jae    264449 <<glass::engine::Watch>::print_utf8+0x20d9>
  263f75:	mov    0x30(%rsp),%esi
  263f79:	mov    %esi,%eax
  263f7b:	or     $0x20,%eax
  263f7e:	cmp    $0x2,%r13
  263f82:	mov    0x8(%rdx),%rcx
  263f86:	lea    (%r12,%r12,2),%rdx
  263f8a:	lea    (%rcx,%rdx,8),%rbx
  263f8e:	mov    %ebp,0x10(%rcx,%rdx,8)
  263f92:	mov    0x28(%rsp),%edi
  263f96:	mov    %edi,0x8(%rcx,%rdx,8)
  263f9a:	cmovne %esi,%eax
  263f9d:	mov    0x78(%rsp),%esi
  263fa1:	mov    %esi,0xc(%rcx,%rdx,8)
  263fa5:	mov    %ax,0x14(%rcx,%rdx,8)
  263faa:	mov    (%rcx,%rdx,8),%rax
  263fae:	test   %rax,%rax
  263fb1:	je     263fc2 <<glass::engine::Watch>::print_utf8+0x1c52>
  263fb3:	lock decq (%rax)
  263fb7:	jne    263fc2 <<glass::engine::Watch>::print_utf8+0x1c52>
  263fb9:	mov    %rbx,%rdi
  263fbc:	call   *0x38da06(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  263fc2:	movq   $0x0,(%rbx)
  263fc9:	cmp    $0x2,%r13
  263fcd:	mov    0xc0(%rsp),%r13
  263fd5:	jne    264303 <<glass::engine::Watch>::print_utf8+0x1f93>
  263fdb:	lea    0x1(%r12),%rcx
  263fe0:	mov    0x18(%rsp),%rax
  263fe5:	mov    0x30(%rax),%rbx
  263fe9:	mov    0x28(%rax),%eax
  263fec:	mov    %rcx,0x38(%rsp)
  263ff1:	cmp    %rbx,%rcx
  263ff4:	jne    264027 <<glass::engine::Watch>::print_utf8+0x1cb7>
  263ff6:	cmp    $0xffffffff,%eax
  263ff9:	je     264027 <<glass::engine::Watch>::print_utf8+0x1cb7>
  263ffb:	add    $0x2,%r12
  263fff:	mov    0x18(%rsp),%rcx
  264004:	mov    %r12,0x30(%rcx)
  264008:	mov    0x10(%rcx),%rsi
  26400c:	mov    0x38(%rsp),%rdi
  264011:	cmp    %rsi,%rdi
  264014:	jb     2642b4 <<glass::engine::Watch>::print_utf8+0x1f44>
  26401a:	lea    0x365287(%rip),%rdx        # 5c92a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  264021:	call   *0x38d951(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264027:	cmp    $0xffffffff,%eax
  26402a:	je     26428a <<glass::engine::Watch>::print_utf8+0x1f1a>
  264030:	mov    0x18(%rsp),%rax
  264035:	mov    0x10(%rax),%r15
  264039:	cmp    %rbx,%r15
  26403c:	mov    %rbx,%rax
  26403f:	cmovb  %r15,%rax
  264043:	mov    %rax,0x10(%rsp)
  264048:	lea    0x1(%r12),%rcx
  26404d:	cmp    %rcx,%r15
  264050:	cmovb  %r15,%rcx
  264054:	mov    0x38da25(%rip),%rax        # 5f1a80 <_DYNAMIC+0x320>
  26405b:	movzbl (%rax),%eax
  26405e:	test   %al,%al
  264060:	mov    %rcx,0x20(%rsp)
  264065:	je     264093 <<glass::engine::Watch>::print_utf8+0x1d23>
  264067:	cmp    %rcx,%rbx
  26406a:	jae    264075 <<glass::engine::Watch>::print_utf8+0x1d05>
  26406c:	mov    0x38da4d(%rip),%rax        # 5f1ac0 <_DYNAMIC+0x360>
  264073:	jmp    26407c <<glass::engine::Watch>::print_utf8+0x1d0c>
  264075:	mov    0x38da3c(%rip),%rax        # 5f1ab8 <_DYNAMIC+0x358>
  26407c:	lock incq 0x28(%rax)
  264081:	mov    %rcx,%rdi
  264084:	sub    0x10(%rsp),%rdi
  264089:	call   2f6f00 <alacritty_terminal::grid::row::fill_census::note>
  26408e:	mov    0x20(%rsp),%rcx
  264093:	cmp    %rcx,%rbx
  264096:	jae    264264 <<glass::engine::Watch>::print_utf8+0x1ef4>
  26409c:	mov    0x18(%rsp),%rcx
  2640a1:	mov    0x28(%rcx),%edi
  2640a4:	mov    0x20(%rcx),%r8d
  2640a8:	mov    0x24(%rcx),%r9d
  2640ac:	movzwl 0x2c(%rcx),%r10d
  2640b1:	mov    0x18(%rcx),%r15
  2640b5:	test   %r15,%r15
  2640b8:	mov    %edi,0xc(%rsp)
  2640bc:	mov    %r8d,0x60(%rsp)
  2640c1:	mov    %r9d,0x70(%rsp)
  2640c6:	mov    %r10w,0x90(%rsp)
  2640cf:	je     26418e <<glass::engine::Watch>::print_utf8+0x1e1e>
  2640d5:	lock incq (%r15)
  2640d9:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  2640df:	mov    0x10(%rcx),%rdx
  2640e3:	mov    %edi,0x50(%rsp)
  2640e7:	mov    %r8d,0x48(%rsp)
  2640ec:	mov    %r9d,0x4c(%rsp)
  2640f1:	mov    %r10w,0x54(%rsp)
  2640f7:	mov    %r15,0x40(%rsp)
  2640fc:	mov    0x20(%rsp),%rsi
  264101:	cmp    %rdx,%rsi
  264104:	ja     264408 <<glass::engine::Watch>::print_utf8+0x2098>
  26410a:	mov    0x10(%rsp),%rax
  26410f:	lea    0x0(,%rax,8),%rax
  264117:	lea    (%rax,%rax,2),%rax
  26411b:	mov    0x8(%rcx),%rbx
  26411f:	add    %rax,%rbx
  264122:	lea    0x0(,%rsi,8),%rcx
  26412a:	lea    (%rcx,%rcx,2),%r13
  26412e:	sub    %rax,%r13
  264131:	jmp    264154 <<glass::engine::Watch>::print_utf8+0x1de4>
  264133:	mov    %r15,(%rbx)
  264136:	mov    %r8d,0x8(%rbx)
  26413a:	mov    %r9d,0xc(%rbx)
  26413e:	mov    %edi,0x10(%rbx)
  264141:	mov    %r10w,0x14(%rbx)
  264146:	add    $0x18,%rbx
  26414a:	add    $0xffffffffffffffe8,%r13
  26414e:	je     264226 <<glass::engine::Watch>::print_utf8+0x1eb6>
  264154:	lock incq (%r15)
  264158:	jle    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  26415e:	mov    (%rbx),%rax
  264161:	test   %rax,%rax
  264164:	je     264133 <<glass::engine::Watch>::print_utf8+0x1dc3>
  264166:	lock decq (%rax)
  26416a:	jne    264133 <<glass::engine::Watch>::print_utf8+0x1dc3>
  26416c:	mov    %rbx,%rdi
  26416f:	call   *0x38d853(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  264175:	movzwl 0x90(%rsp),%r10d
  26417e:	mov    0x70(%rsp),%r9d
  264183:	mov    0x60(%rsp),%r8d
  264188:	mov    0xc(%rsp),%edi
  26418c:	jmp    264133 <<glass::engine::Watch>::print_utf8+0x1dc3>
  26418e:	mov    %edi,0x50(%rsp)
  264192:	mov    %r8d,0x48(%rsp)
  264197:	mov    %r9d,0x4c(%rsp)
  26419c:	mov    %r10w,0x54(%rsp)
  2641a2:	mov    %r15,0x40(%rsp)
  2641a7:	mov    0x10(%rsp),%rax
  2641ac:	lea    0x0(,%rax,8),%rax
  2641b4:	lea    (%rax,%rax,2),%rax
  2641b8:	mov    0x8(%rcx),%rbx
  2641bc:	add    %rax,%rbx
  2641bf:	mov    0x20(%rsp),%rcx
  2641c4:	lea    0x0(,%rcx,8),%rcx
  2641cc:	lea    (%rcx,%rcx,2),%r13
  2641d0:	sub    %rax,%r13
  2641d3:	jmp    2641f6 <<glass::engine::Watch>::print_utf8+0x1e86>
  2641d5:	movq   $0x0,(%rbx)
  2641dc:	mov    %r8d,0x8(%rbx)
  2641e0:	mov    %r9d,0xc(%rbx)
  2641e4:	mov    %edi,0x10(%rbx)
  2641e7:	mov    %r10w,0x14(%rbx)
  2641ec:	add    $0x18,%rbx
  2641f0:	add    $0xffffffffffffffe8,%r13
  2641f4:	je     264226 <<glass::engine::Watch>::print_utf8+0x1eb6>
  2641f6:	mov    (%rbx),%rax
  2641f9:	test   %rax,%rax
  2641fc:	je     2641d5 <<glass::engine::Watch>::print_utf8+0x1e65>
  2641fe:	lock decq (%rax)
  264202:	jne    2641d5 <<glass::engine::Watch>::print_utf8+0x1e65>
  264204:	mov    %rbx,%rdi
  264207:	call   *0x38d7bb(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  26420d:	movzwl 0x90(%rsp),%r10d
  264216:	mov    0x70(%rsp),%r9d
  26421b:	mov    0x60(%rsp),%r8d
  264220:	mov    0xc(%rsp),%edi
  264224:	jmp    2641d5 <<glass::engine::Watch>::print_utf8+0x1e65>
  264226:	mov    0x18(%rsp),%rbx
  26422b:	mov    0x10(%rsp),%rax
  264230:	cmp    %eax,0x38(%rbx)
  264233:	jbe    264238 <<glass::engine::Watch>::print_utf8+0x1ec8>
  264235:	mov    %eax,0x38(%rbx)
  264238:	test   %r15,%r15
  26423b:	mov    0xc0(%rsp),%r13
  264243:	mov    0x20(%rsp),%rcx
  264248:	je     264260 <<glass::engine::Watch>::print_utf8+0x1ef0>
  26424a:	lock decq (%r15)
  26424e:	jne    264260 <<glass::engine::Watch>::print_utf8+0x1ef0>
  264250:	lea    0x40(%rsp),%rdi
  264255:	call   *0x38d76d(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  26425b:	mov    0x20(%rsp),%rcx
  264260:	mov    0x10(%rbx),%r15
  264264:	cmp    %r15,%rcx
  264267:	mov    0xc8(%rsp),%r15
  26426f:	jb     26428a <<glass::engine::Watch>::print_utf8+0x1f1a>
  264271:	mov    0x80(%rsp),%rdi
  264279:	call   1ad4a0 <core::ptr::drop_glue::<core::option::Option<alacritty_terminal::term::cell::Cell>>>
  26427e:	mov    0x18(%rsp),%rax
  264283:	movl   $0xffffffff,0x28(%rax)
  26428a:	mov    0x18(%rsp),%rcx
  26428f:	mov    0x30(%rcx),%rax
  264293:	add    $0x2,%r12
  264297:	cmp    %rax,%r12
  26429a:	cmovbe %rax,%r12
  26429e:	mov    0x10(%rcx),%rsi
  2642a2:	mov    %r12,0x30(%rcx)
  2642a6:	mov    0x38(%rsp),%rdi
  2642ab:	cmp    %rsi,%rdi
  2642ae:	jae    264469 <<glass::engine::Watch>::print_utf8+0x20f9>
  2642b4:	mov    0x8(%rcx),%rax
  2642b8:	lea    (%rdi,%rdi,2),%rcx
  2642bc:	lea    (%rax,%rcx,8),%rbx
  2642c0:	movl   $0x20,0x10(%rax,%rcx,8)
  2642c8:	mov    0x28(%rsp),%edx
  2642cc:	mov    %edx,0x8(%rax,%rcx,8)
  2642d0:	mov    0x78(%rsp),%edx
  2642d4:	mov    %edx,0xc(%rax,%rcx,8)
  2642d8:	mov    0x30(%rsp),%edx
  2642dc:	or     $0x40,%edx
  2642df:	mov    %dx,0x14(%rax,%rcx,8)
  2642e4:	mov    (%rax,%rcx,8),%rax
  2642e8:	test   %rax,%rax
  2642eb:	je     2642fc <<glass::engine::Watch>::print_utf8+0x1f8c>
  2642ed:	lock decq (%rax)
  2642f1:	jne    2642fc <<glass::engine::Watch>::print_utf8+0x1f8c>
  2642f3:	mov    %rbx,%rdi
  2642f6:	call   *0x38d6cc(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  2642fc:	movq   $0x0,(%rbx)
  264303:	mov    0xa0(%rsp),%rax
  26430b:	cmp    0x58(%rsp),%rax
  264310:	jb     26431a <<glass::engine::Watch>::print_utf8+0x1faa>
  264312:	dec    %rax
  264315:	movb   $0x1,0x6c(%r14)
  26431a:	mov    %rax,0x40(%r14)
  26431e:	incq   0xa0(%r15)
  264325:	mov    %ebp,0xb0(%r15)
  26432c:	jmp    263c05 <<glass::engine::Watch>::print_utf8+0x1895>
  264331:	call   18b9a2 <<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::initialize::<<std::sync::once_lock::OnceLock<alloc::boxed::Box<[core::sync::atomic::Atomic<i8>]>>>::get_or_init<glass::engine::width_of::{closure#0}>::{closure#0}, !>>
  264336:	mov    %ebp,%ebx
  264338:	mov    0x3905f1(%rip),%rsi        # 5f4930 <glass::engine::width_of::CACHE+0x8>
  26433f:	cmp    %rbx,%rsi
  264342:	ja     263aa2 <<glass::engine::Watch>::print_utf8+0x1732>
  264348:	lea    0x367161(%rip),%rdx        # 5cb4b0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x17d30>
  26434f:	mov    %rbx,%rdi
  264352:	call   *0x38d620(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264358:	lea    0x364349(%rip),%rcx        # 5c86a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  26435f:	mov    0xa8(%rsp),%rdi
  264367:	call   *0x38d7cb(%rip)        # 5f1b38 <_DYNAMIC+0x3d8>
  26436d:	jmp    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  264372:	lea    0x36432f(%rip),%rcx        # 5c86a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  264379:	call   *0x38d7b9(%rip)        # 5f1b38 <_DYNAMIC+0x3d8>
  26437f:	jmp    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  264384:	lea    0x364815(%rip),%rdx        # 5c8ba0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15420>
  26438b:	call   *0x38d5e7(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264391:	lea    0x364820(%rip),%rax        # 5c8bb8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15438>
  264398:	jmp    2643b9 <<glass::engine::Watch>::print_utf8+0x2049>
  26439a:	lea    0x36485f(%rip),%rdx        # 5c8c00 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15480>
  2643a1:	mov    %rbx,%rdi
  2643a4:	mov    0x30(%rsp),%rsi
  2643a9:	call   *0x38d5c9(%rip)        # 5f1978 <_DYNAMIC+0x218>
  2643af:	mov    %rax,%rbx
  2643b2:	lea    0x364817(%rip),%rax        # 5c8bd0 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15450>
  2643b9:	mov    %rax,0xf0(%rsp)
  2643c1:	mov    %rbx,%rdi
  2643c4:	mov    0x30(%rsp),%rsi
  2643c9:	mov    0xf0(%rsp),%rdx
  2643d1:	call   *0x38d5a1(%rip)        # 5f1978 <_DYNAMIC+0x218>
  2643d7:	lea    0x3642ca(%rip),%rcx        # 5c86a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  2643de:	mov    0x10(%rsp),%rdi
  2643e3:	call   *0x38d74f(%rip)        # 5f1b38 <_DYNAMIC+0x3d8>
  2643e9:	jmp    26441a <<glass::engine::Watch>::print_utf8+0x20aa>
  2643eb:	lea    0x36492e(%rip),%rdx        # 5c8d20 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x155a0>
  2643f2:	call   *0x38d580(%rip)        # 5f1978 <_DYNAMIC+0x218>
  2643f8:	lea    0x352969(%rip),%rdx        # 5b6d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  2643ff:	mov    %rbx,%rdi
  264402:	call   *0x38d570(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264408:	lea    0x364299(%rip),%rcx        # 5c86a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x14f28>
  26440f:	mov    0x10(%rsp),%rdi
  264414:	call   *0x38d71e(%rip)        # 5f1b38 <_DYNAMIC+0x3d8>
  26441a:	ud2
  26441c:	lea    0x352945(%rip),%rdx        # 5b6d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264423:	call   *0x38d54f(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264429:	lea    0x364e78(%rip),%rdx        # 5c92a8 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b28>
  264430:	mov    %rbx,%rdi
  264433:	call   *0x38d53f(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264439:	lea    0x364e50(%rip),%rdx        # 5c9290 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264440:	mov    %rbx,%rdi
  264443:	call   *0x38d52f(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264449:	lea    0x364e40(%rip),%rdx        # 5c9290 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264450:	mov    %r12,%rdi
  264453:	call   *0x38d51f(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264459:	lea    0x352908(%rip),%rdx        # 5b6d68 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x35e8>
  264460:	mov    %r12,%rdi
  264463:	call   *0x38d50f(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264469:	lea    0x364e20(%rip),%rdx        # 5c9290 <anon.b27937d07895f204e0f5bee69498325a.1812.llvm.14363597430436930651+0x15b10>
  264470:	call   *0x38d502(%rip)        # 5f1978 <_DYNAMIC+0x218>
  264476:	mov    %rax,%rbx
  264479:	lock decq (%r15)
  26447d:	je     2644a6 <<glass::engine::Watch>::print_utf8+0x2136>
  26447f:	jmp    2644b4 <<glass::engine::Watch>::print_utf8+0x2144>
  264481:	mov    %rax,%rbx
  264484:	mov    0x38(%rsp),%rax
  264489:	jmp    2644a0 <<glass::engine::Watch>::print_utf8+0x2130>
  26448b:	mov    %rax,%rbx
  26448e:	mov    0x98(%rsp),%rax
  264496:	jmp    2644a0 <<glass::engine::Watch>::print_utf8+0x2130>
  264498:	mov    %rax,%rbx
  26449b:	mov    0x68(%rsp),%rax
  2644a0:	lock decq (%rax)
  2644a4:	jne    2644b4 <<glass::engine::Watch>::print_utf8+0x2144>
  2644a6:	mov    0x110(%rsp),%rdi
  2644ae:	call   *0x38d514(%rip)        # 5f19c8 <_DYNAMIC+0x268>
  2644b4:	mov    %rbx,%rdi
  2644b7:	call   5b0070 <_Unwind_Resume@plt>
