
/tmp/glass-i29-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002a1520 <glass::engine::utf8_multibyte_at>:
  2a1520:	lea    0x3e(%rcx),%eax
  2a1523:	cmp    $0x1e,%al
  2a1525:	jae    2a1579 <glass::engine::utf8_multibyte_at+0x59>
  2a1527:	inc    %rdx
  2a152a:	mov    $0xffffffff,%eax
  2a152f:	cmp    %rsi,%rdx
  2a1532:	jae    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a1538:	movzbl (%rdi,%rdx,1),%edx
  2a153c:	cmp    $0xc0,%dl
  2a153f:	jge    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a1545:	and    $0x1f,%cl
  2a1548:	movzbl %cl,%eax
  2a154b:	shl    $0x6,%eax
  2a154e:	mov    $0x2,%ecx
  2a1553:	and    $0x3f,%dl
  2a1556:	movzbl %dl,%esi
  2a1559:	or     %eax,%esi
  2a155b:	xor    $0xd800,%eax
  2a1560:	add    $0xffef0000,%eax
  2a1565:	xor    %edx,%edx
  2a1567:	cmp    $0xffef0800,%eax
  2a156c:	cmovae %rcx,%rdx
  2a1570:	mov    $0xffffffff,%eax
  2a1575:	cmovae %esi,%eax
  2a1578:	ret
  2a1579:	mov    %ecx,%eax
  2a157b:	and    $0xf0,%al
  2a157d:	cmp    $0xe0,%al
  2a157f:	jne    2a15ac <glass::engine::utf8_multibyte_at+0x8c>
  2a1581:	mov    $0xbf,%r8b
  2a1584:	cmp    $0xe0,%cl
  2a1587:	je     2a15ec <glass::engine::utf8_multibyte_at+0xcc>
  2a1589:	movzbl %cl,%eax
  2a158c:	mov    $0x80,%r10b
  2a158f:	cmp    $0xed,%eax
  2a1594:	jne    2a1599 <glass::engine::utf8_multibyte_at+0x79>
  2a1596:	mov    $0x9f,%r8b
  2a1599:	lea    0x1(%rdx),%r9
  2a159d:	mov    $0xffffffff,%eax
  2a15a2:	cmp    %rsi,%r9
  2a15a5:	jb     2a1601 <glass::engine::utf8_multibyte_at+0xe1>
  2a15a7:	jmp    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a15ac:	lea    0x10(%rcx),%r8d
  2a15b0:	mov    $0xffffffff,%eax
  2a15b5:	cmp    $0x5,%r8b
  2a15b9:	jae    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a15bf:	mov    $0x80,%r9b
  2a15c2:	cmp    $0xf4,%cl
  2a15c5:	je     2a1655 <glass::engine::utf8_multibyte_at+0x135>
  2a15cb:	movzbl %cl,%r8d
  2a15cf:	mov    $0xbf,%r10b
  2a15d2:	cmp    $0xf0,%r8d
  2a15d9:	jne    2a15de <glass::engine::utf8_multibyte_at+0xbe>
  2a15db:	mov    $0x90,%r9b
  2a15de:	lea    0x1(%rdx),%r8
  2a15e2:	cmp    %rsi,%r8
  2a15e5:	jb     2a1661 <glass::engine::utf8_multibyte_at+0x141>
  2a15e7:	jmp    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a15ec:	mov    $0xa0,%r10b
  2a15ef:	lea    0x1(%rdx),%r9
  2a15f3:	mov    $0xffffffff,%eax
  2a15f8:	cmp    %rsi,%r9
  2a15fb:	jae    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a1601:	movzbl (%rdi,%r9,1),%r9d
  2a1606:	cmp    %r9b,%r10b
  2a1609:	seta   %r10b
  2a160d:	cmp    %r8b,%r9b
  2a1610:	seta   %r8b
  2a1614:	or     %r10b,%r8b
  2a1617:	jne    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a161d:	add    $0x2,%rdx
  2a1621:	cmp    %rsi,%rdx
  2a1624:	jae    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a162a:	movzbl (%rdi,%rdx,1),%edx
  2a162e:	cmp    $0xc0,%dl
  2a1631:	jge    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a1637:	and    $0x3f,%r9d
  2a163b:	shl    $0x6,%r9d
  2a163f:	and    $0xf,%cl
  2a1642:	movzbl %cl,%eax
  2a1645:	shl    $0xc,%eax
  2a1648:	or     %r9d,%eax
  2a164b:	mov    $0x3,%ecx
  2a1650:	jmp    2a1553 <glass::engine::utf8_multibyte_at+0x33>
  2a1655:	mov    $0x8f,%r10b
  2a1658:	lea    0x1(%rdx),%r8
  2a165c:	cmp    %rsi,%r8
  2a165f:	jae    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a1661:	movzbl (%rdi,%r8,1),%r8d
  2a1666:	cmp    %r8b,%r9b
  2a1669:	seta   %r9b
  2a166d:	cmp    %r10b,%r8b
  2a1670:	seta   %r10b
  2a1674:	or     %r9b,%r10b
  2a1677:	jne    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a1679:	lea    0x2(%rdx),%r9
  2a167d:	cmp    %rsi,%r9
  2a1680:	jae    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a1682:	movzbl (%rdi,%r9,1),%r9d
  2a1687:	cmp    $0xbf,%r9b
  2a168b:	jg     2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a168d:	add    $0x3,%rdx
  2a1691:	cmp    %rsi,%rdx
  2a1694:	jae    2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a1696:	movzbl (%rdi,%rdx,1),%edx
  2a169a:	cmp    $0xbf,%dl
  2a169d:	jg     2a16c8 <glass::engine::utf8_multibyte_at+0x1a8>
  2a169f:	and    $0x3f,%r9d
  2a16a3:	shl    $0x6,%r9d
  2a16a7:	and    $0x3f,%r8d
  2a16ab:	shl    $0xc,%r8d
  2a16af:	and    $0x7,%cl
  2a16b2:	movzbl %cl,%eax
  2a16b5:	shl    $0x12,%eax
  2a16b8:	or     %r8d,%eax
  2a16bb:	or     %r9d,%eax
  2a16be:	mov    $0x4,%ecx
  2a16c3:	jmp    2a1553 <glass::engine::utf8_multibyte_at+0x33>
  2a16c8:	xor    %edx,%edx
  2a16ca:	ret
