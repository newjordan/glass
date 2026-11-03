
/tmp/glass-i32-candidate-test:     file format elf64-x86-64


Disassembly of section .text:

00000000002929a0 <<alacritty_terminal::term::Term<glass::engine::Listener>>::terminal_attribute_cold>:
  2929a0:	sub    $0x78,%rsp
  2929a4:	mov    %rsi,%rax
  2929a7:	mov    %eax,(%rsp)
  2929aa:	mov    %rsi,%rcx
  2929ad:	shr    $0x20,%rcx
  2929b1:	mov    %cx,0x4(%rsp)
  2929b6:	cmp    $0x18,%ax
  2929ba:	ja     292abe <<alacritty_terminal::term::Term<glass::engine::Listener>>::terminal_attribute_cold+0x11e>
  2929c0:	mov    %rax,%rsi
  2929c3:	shr    $0x10,%rsi
  2929c7:	movzwl %ax,%eax
  2929ca:	lea    -0x222d15(%rip),%rcx        # 6fcbc <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x3b2b>
  2929d1:	movslq (%rcx,%rax,4),%rax
  2929d5:	add    %rcx,%rax
  2929d8:	jmp    *%rax
  2929da:	lea    0x50(%rdi),%rax
  2929de:	movb   $0x0,0x58(%rdi)
  2929e2:	movw   $0x100,0x5a(%rdi)
  2929e8:	movb   $0x0,0x5c(%rdi)
  2929ec:	movw   $0x101,0x5e(%rdi)
  2929f2:	movw   $0x0,0x64(%rdi)
  2929f8:	mov    %rax,%rdi
  2929fb:	mov    $0xff,%esi
  292a00:	add    $0x78,%rsp
  292a04:	jmp    *0x363ece(%rip)        # 5f68d8 <_DYNAMIC+0x2b8>
  292a0a:	andb   $0xfd,0x65(%rdi)
  292a0e:	add    $0x78,%rsp
  292a12:	ret
  292a13:	add    $0x50,%rdi
  292a17:	add    $0x78,%rsp
  292a1b:	jmp    *0x363eb7(%rip)        # 5f68d8 <_DYNAMIC+0x2b8>
  292a21:	andb   $0x7d,0x64(%rdi)
  292a25:	add    $0x78,%rsp
  292a29:	ret
  292a2a:	orb    $0x1,0x65(%rdi)
  292a2e:	add    $0x78,%rsp
  292a32:	ret
  292a33:	andb   $0xfd,0x64(%rdi)
  292a37:	add    $0x78,%rsp
  292a3b:	ret
  292a3c:	mov    %esi,0x58(%rdi)
  292a3f:	add    $0x78,%rsp
  292a43:	ret
  292a44:	orb    $0x80,0x64(%rdi)
  292a48:	add    $0x78,%rsp
  292a4c:	ret
  292a4d:	mov    $0xffff87f7,%eax
  292a52:	and    0x64(%rdi),%eax
  292a55:	or     $0x800,%eax
  292a5a:	mov    %ax,0x64(%rdi)
  292a5e:	add    $0x78,%rsp
  292a62:	ret
  292a63:	orb    $0x2,0x65(%rdi)
  292a67:	add    $0x78,%rsp
  292a6b:	ret
  292a6c:	orb    $0x2,0x64(%rdi)
  292a70:	add    $0x78,%rsp
  292a74:	ret
  292a75:	mov    $0xffff87f7,%eax
  292a7a:	and    0x64(%rdi),%eax
  292a7d:	or     $0x1000,%eax
  292a82:	mov    %ax,0x64(%rdi)
  292a86:	add    $0x78,%rsp
  292a8a:	ret
  292a8b:	mov    $0xffff87f7,%eax
  292a90:	and    0x64(%rdi),%eax
  292a93:	or     $0x2000,%eax
  292a98:	mov    %ax,0x64(%rdi)
  292a9c:	add    $0x78,%rsp
  292aa0:	ret
  292aa1:	andb   $0xfb,0x64(%rdi)
  292aa5:	add    $0x78,%rsp
  292aa9:	ret
  292aaa:	andw   $0x87f7,0x64(%rdi)
  292ab0:	add    $0x78,%rsp
  292ab4:	ret
  292ab5:	orb    $0x4,0x64(%rdi)
  292ab9:	add    $0x78,%rsp
  292abd:	ret
  292abe:	mov    0x36402b(%rip),%rax        # 5f6af0 <_DYNAMIC+0x4d0>
  292ac5:	mov    (%rax),%rax
  292ac8:	cmp    $0x3,%rax
  292acc:	jbe    292b8f <<alacritty_terminal::term::Term<glass::engine::Listener>>::terminal_attribute_cold+0x1ef>
  292ad2:	mov    %rsp,%rax
  292ad5:	mov    %rax,0x8(%rsp)
  292ada:	lea    0xabfff(%rip),%rax        # 33eae0 <<vte::ansi::Attr as core::fmt::Debug>::fmt>
  292ae1:	mov    %rax,0x10(%rsp)
  292ae6:	movq   $0x4,0x48(%rsp)
  292aef:	lea    -0x21ed8d(%rip),%rax        # 73d69 <anon.04d0bb88b76ccb7564c128a12c389749.87.llvm.954900376885760318+0x7bd8>
  292af6:	mov    %rax,0x50(%rsp)
  292afb:	movq   $0x18,0x58(%rsp)
  292b04:	lea    -0x23921c(%rip),%rcx        # 598ef <anon.c5caa36ea40248444d4f41ebfcdc6a20.30.llvm.15122887357243783873+0x158>
  292b0b:	mov    %rcx,0x68(%rsp)
  292b10:	lea    0x8(%rsp),%rcx
  292b15:	mov    %rcx,0x70(%rsp)
  292b1a:	movq   $0x0,0x18(%rsp)
  292b23:	mov    %rax,0x20(%rsp)
  292b28:	movq   $0x18,0x28(%rsp)
  292b31:	movq   $0x0,0x30(%rsp)
  292b3a:	lea    -0x24129d(%rip),%rax        # 518a4 <anon.48a94b4156a1895edfc227e0e61a21e6.7.llvm.774233506152284253+0x6a>
  292b41:	mov    %rax,0x38(%rsp)
  292b46:	movq   $0x29,0x40(%rsp)
  292b4f:	movabs $0x47600000001,%rax
  292b59:	mov    %rax,0x60(%rsp)
  292b5e:	mov    0x36a04b(%rip),%rax        # 5fcbb0 <log::STATE>
  292b65:	cmp    $0x2,%rax
  292b69:	lea    0x354038(%rip),%rax        # 5e6ba8 <anon.9d01c2521e6ce7ddd00230a5633940a7.11.llvm.13591961162351055884>
  292b70:	cmove  0x366d18(%rip),%rax        # 5f9890 <log::LOGGER>
  292b78:	lea    -0x1c7531(%rip),%rdi        # cb64e <log::logger::NOP>
  292b7f:	cmove  0x366d01(%rip),%rdi        # 5f9888 <log::LOGGER>
  292b87:	lea    0x18(%rsp),%rsi
  292b8c:	call   *0x20(%rax)
  292b8f:	add    $0x78,%rsp
  292b93:	ret
  292b94:	mov    $0xffff87f7,%eax
  292b99:	and    0x64(%rdi),%eax
  292b9c:	or     $0x8,%eax
  292b9f:	mov    %ax,0x64(%rdi)
  292ba3:	add    $0x78,%rsp
  292ba7:	ret
  292ba8:	orb    $0x1,0x64(%rdi)
  292bac:	add    $0x78,%rsp
  292bb0:	ret
  292bb1:	mov    $0xffff87f7,%eax
  292bb6:	and    0x64(%rdi),%eax
  292bb9:	or     $0x4000,%eax
  292bbe:	mov    %ax,0x64(%rdi)
  292bc2:	add    $0x78,%rsp
  292bc6:	ret
  292bc7:	andb   $0xfe,0x65(%rdi)
  292bcb:	add    $0x78,%rsp
  292bcf:	ret
  292bd0:	andb   $0xfe,0x64(%rdi)
  292bd4:	add    $0x78,%rsp
  292bd8:	ret
  292bd9:	mov    %esi,0x5c(%rdi)
  292bdc:	add    $0x78,%rsp
  292be0:	ret
