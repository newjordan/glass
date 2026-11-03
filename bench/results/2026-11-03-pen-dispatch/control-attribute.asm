
/tmp/glass-i32-control-test:     file format elf64-x86-64


Disassembly of section .text:

000000000034e510 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute>:
  34e510:	push   %r14
  34e512:	push   %rbx
  34e513:	sub    $0x78,%rsp
  34e517:	mov    %rdi,%rbx
  34e51a:	mov    %esi,(%rsp)
  34e51d:	mov    %rsi,%rax
  34e520:	shr    $0x20,%rax
  34e524:	mov    %ax,0x4(%rsp)
  34e529:	mov    0x2a7a00(%rip),%r14        # 5f5f30 <_DYNAMIC+0x4d0>
  34e530:	mov    (%r14),%rax
  34e533:	cmp    $0x5,%rax
  34e537:	jb     34e5fe <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0xee>
  34e53d:	mov    %rsp,%rax
  34e540:	mov    %rax,0x8(%rsp)
  34e545:	lea    -0x106bc(%rip),%rax        # 33de90 <<vte::ansi::Attr as core::fmt::Debug>::fmt>
  34e54c:	mov    %rax,0x10(%rsp)
  34e551:	movq   $0x5,0x48(%rsp)
  34e55a:	lea    -0x2da7f8(%rip),%rax        # 73d69 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x7bd8>
  34e561:	mov    %rax,0x50(%rsp)
  34e566:	movq   $0x18,0x58(%rsp)
  34e56f:	lea    -0x2f7676(%rip),%rcx        # 56f00 <anon.b1f4d9ab9a70b62acaac4b25f359f3f9.23.llvm.7200124262536369696+0x4f1>
  34e576:	mov    %rcx,0x68(%rsp)
  34e57b:	lea    0x8(%rsp),%rcx
  34e580:	mov    %rcx,0x70(%rsp)
  34e585:	movq   $0x0,0x18(%rsp)
  34e58e:	mov    %rax,0x20(%rsp)
  34e593:	movq   $0x18,0x28(%rsp)
  34e59c:	movq   $0x0,0x30(%rsp)
  34e5a5:	lea    -0x2fcd08(%rip),%rax        # 518a4 <anon.48a94b4156a1895edfc227e0e61a21e6.7.llvm.774233506152284253+0x6a>
  34e5ac:	mov    %rax,0x38(%rsp)
  34e5b1:	movq   $0x29,0x40(%rsp)
  34e5ba:	movabs $0x77c00000001,%rax
  34e5c4:	mov    %rax,0x60(%rsp)
  34e5c9:	mov    0x2ada20(%rip),%rax        # 5fbff0 <log::STATE>
  34e5d0:	cmp    $0x2,%rax
  34e5d4:	lea    0x297a0d(%rip),%rax        # 5e5fe8 <anon.9d01c2521e6ce7ddd00230a5633940a7.11.llvm.13591961162351055884>
  34e5db:	cmove  0x2aa6ed(%rip),%rax        # 5f8cd0 <log::LOGGER>
  34e5e3:	lea    -0x282f9c(%rip),%rdi        # cb64e <log::logger::NOP>
  34e5ea:	cmove  0x2aa6d6(%rip),%rdi        # 5f8cc8 <log::LOGGER>
  34e5f2:	lea    0x18(%rsp),%rsi
  34e5f7:	call   *0x20(%rax)
  34e5fa:	movzwl (%rsp),%esi
  34e5fe:	cmp    $0x18,%si
  34e602:	ja     34e715 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0x205>
  34e608:	movzwl %si,%eax
  34e60b:	lea    -0x2dcdd2(%rip),%rcx        # 71840 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x56af>
  34e612:	movslq (%rcx,%rax,4),%rax
  34e616:	add    %rcx,%rax
  34e619:	jmp    *%rax
  34e61b:	lea    0x50(%rbx),%rdi
  34e61f:	movb   $0x0,0x58(%rbx)
  34e623:	movw   $0x100,0x5a(%rbx)
  34e629:	movb   $0x0,0x5c(%rbx)
  34e62d:	movw   $0x101,0x5e(%rbx)
  34e633:	movw   $0x0,0x64(%rbx)
  34e639:	mov    $0xff,%esi
  34e63e:	jmp    34e654 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0x144>
  34e640:	andb   $0xfd,0x65(%rbx)
  34e644:	jmp    34e7e7 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0x2d7>
  34e649:	mov    0x2(%rsp),%esi
  34e64d:	add    $0x50,%rbx
  34e651:	mov    %rbx,%rdi
  34e654:	call   *0x2a76be(%rip)        # 5f5d18 <_DYNAMIC+0x2b8>
  34e65a:	add    $0x78,%rsp
  34e65e:	pop    %rbx
  34e65f:	pop    %r14
  34e661:	ret
  34e662:	andb   $0x7d,0x64(%rbx)
  34e666:	add    $0x78,%rsp
  34e66a:	pop    %rbx
  34e66b:	pop    %r14
  34e66d:	ret
  34e66e:	orb    $0x1,0x65(%rbx)
  34e672:	add    $0x78,%rsp
  34e676:	pop    %rbx
  34e677:	pop    %r14
  34e679:	ret
  34e67a:	andb   $0xfd,0x64(%rbx)
  34e67e:	add    $0x78,%rsp
  34e682:	pop    %rbx
  34e683:	pop    %r14
  34e685:	ret
  34e686:	mov    0x2(%rsp),%eax
  34e68a:	mov    %eax,0x58(%rbx)
  34e68d:	add    $0x78,%rsp
  34e691:	pop    %rbx
  34e692:	pop    %r14
  34e694:	ret
  34e695:	orb    $0x80,0x64(%rbx)
  34e699:	add    $0x78,%rsp
  34e69d:	pop    %rbx
  34e69e:	pop    %r14
  34e6a0:	ret
  34e6a1:	mov    $0xffff87f7,%eax
  34e6a6:	and    0x64(%rbx),%eax
  34e6a9:	or     $0x800,%eax
  34e6ae:	jmp    34e815 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0x305>
  34e6b3:	orb    $0x2,0x65(%rbx)
  34e6b7:	add    $0x78,%rsp
  34e6bb:	pop    %rbx
  34e6bc:	pop    %r14
  34e6be:	ret
  34e6bf:	orb    $0x2,0x64(%rbx)
  34e6c3:	add    $0x78,%rsp
  34e6c7:	pop    %rbx
  34e6c8:	pop    %r14
  34e6ca:	ret
  34e6cb:	mov    $0xffff87f7,%eax
  34e6d0:	and    0x64(%rbx),%eax
  34e6d3:	or     $0x1000,%eax
  34e6d8:	jmp    34e815 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0x305>
  34e6dd:	mov    $0xffff87f7,%eax
  34e6e2:	and    0x64(%rbx),%eax
  34e6e5:	or     $0x2000,%eax
  34e6ea:	jmp    34e815 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0x305>
  34e6ef:	andb   $0xfb,0x64(%rbx)
  34e6f3:	add    $0x78,%rsp
  34e6f7:	pop    %rbx
  34e6f8:	pop    %r14
  34e6fa:	ret
  34e6fb:	andw   $0x87f7,0x64(%rbx)
  34e701:	add    $0x78,%rsp
  34e705:	pop    %rbx
  34e706:	pop    %r14
  34e708:	ret
  34e709:	orb    $0x4,0x64(%rbx)
  34e70d:	add    $0x78,%rsp
  34e711:	pop    %rbx
  34e712:	pop    %r14
  34e714:	ret
  34e715:	mov    (%r14),%rax
  34e718:	cmp    $0x3,%rax
  34e71c:	jbe    34e7e7 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0x2d7>
  34e722:	mov    %rsp,%rax
  34e725:	mov    %rax,0x8(%rsp)
  34e72a:	lea    -0x108a1(%rip),%rax        # 33de90 <<vte::ansi::Attr as core::fmt::Debug>::fmt>
  34e731:	mov    %rax,0x10(%rsp)
  34e736:	movq   $0x4,0x48(%rsp)
  34e73f:	lea    -0x2da9dd(%rip),%rax        # 73d69 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x7bd8>
  34e746:	mov    %rax,0x50(%rsp)
  34e74b:	movq   $0x18,0x58(%rsp)
  34e754:	lea    -0x2f4c23(%rip),%rcx        # 59b38 <anon.c5caa36ea40248444d4f41ebfcdc6a20.30.llvm.15122887357243783873+0x3a1>
  34e75b:	mov    %rcx,0x68(%rsp)
  34e760:	lea    0x8(%rsp),%rcx
  34e765:	mov    %rcx,0x70(%rsp)
  34e76a:	movq   $0x0,0x18(%rsp)
  34e773:	mov    %rax,0x20(%rsp)
  34e778:	movq   $0x18,0x28(%rsp)
  34e781:	movq   $0x0,0x30(%rsp)
  34e78a:	lea    -0x2fceed(%rip),%rax        # 518a4 <anon.48a94b4156a1895edfc227e0e61a21e6.7.llvm.774233506152284253+0x6a>
  34e791:	mov    %rax,0x38(%rsp)
  34e796:	movq   $0x29,0x40(%rsp)
  34e79f:	movabs $0x7aa00000001,%rax
  34e7a9:	mov    %rax,0x60(%rsp)
  34e7ae:	mov    0x2ad83b(%rip),%rax        # 5fbff0 <log::STATE>
  34e7b5:	cmp    $0x2,%rax
  34e7b9:	lea    0x297828(%rip),%rax        # 5e5fe8 <anon.9d01c2521e6ce7ddd00230a5633940a7.11.llvm.13591961162351055884>
  34e7c0:	cmove  0x2aa508(%rip),%rax        # 5f8cd0 <log::LOGGER>
  34e7c8:	lea    -0x283181(%rip),%rdi        # cb64e <log::logger::NOP>
  34e7cf:	cmove  0x2aa4f1(%rip),%rdi        # 5f8cc8 <log::LOGGER>
  34e7d7:	lea    0x18(%rsp),%rsi
  34e7dc:	call   *0x20(%rax)
  34e7df:	add    $0x78,%rsp
  34e7e3:	pop    %rbx
  34e7e4:	pop    %r14
  34e7e6:	ret
  34e7e7:	add    $0x78,%rsp
  34e7eb:	pop    %rbx
  34e7ec:	pop    %r14
  34e7ee:	ret
  34e7ef:	mov    $0xffff87f7,%eax
  34e7f4:	and    0x64(%rbx),%eax
  34e7f7:	or     $0x8,%eax
  34e7fa:	jmp    34e815 <<alacritty_terminal::term::Term<glass::engine::Listener> as vte::ansi::Handler>::terminal_attribute+0x305>
  34e7fc:	orb    $0x1,0x64(%rbx)
  34e800:	add    $0x78,%rsp
  34e804:	pop    %rbx
  34e805:	pop    %r14
  34e807:	ret
  34e808:	mov    $0xffff87f7,%eax
  34e80d:	and    0x64(%rbx),%eax
  34e810:	or     $0x4000,%eax
  34e815:	mov    %ax,0x64(%rbx)
  34e819:	add    $0x78,%rsp
  34e81d:	pop    %rbx
  34e81e:	pop    %r14
  34e820:	ret
  34e821:	andb   $0xfe,0x65(%rbx)
  34e825:	add    $0x78,%rsp
  34e829:	pop    %rbx
  34e82a:	pop    %r14
  34e82c:	ret
  34e82d:	andb   $0xfe,0x64(%rbx)
  34e831:	add    $0x78,%rsp
  34e835:	pop    %rbx
  34e836:	pop    %r14
  34e838:	ret
  34e839:	mov    0x2(%rsp),%eax
  34e83d:	mov    %eax,0x5c(%rbx)
  34e840:	add    $0x78,%rsp
  34e844:	pop    %rbx
  34e845:	pop    %r14
  34e847:	ret
