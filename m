Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C79282.9E540D4D"
Date: Wed, 9 May 2007 17:40:10 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F478EC@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: panic accessing NULL lru cache 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C79282.9E540D4D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We are seeing a panic in drbd_al_to_on_disk_bm()
=20
Below is the stack and a possible cause:
May  3 05:17:59 choip kernel: EIP is at drbd_al_to_on_disk_bm+0x18/0x470
[drbd]
May  3 05:17:59 choip kernel: eax: 00000000  ebx: ecbd013c  ecx:
00000000  edx: 00000000
May  3 05:17:59 choip kernel: esi: ecbd013c  edi: 00000001  ebp:
eb2b3ebc  esp: eb2b3e34
May  3 05:17:59 choip heartbeat: [5898]: info: standby: acquire [all]
resources from chois.sn.stratus.com
May  3 05:17:59 choip kernel: ds: 007b  es: 007b  ss: 0069
May  3 05:17:59 choip heartbeat: [13993]: info: acquire all HA resources
(standby).
May  3 05:17:59 choip kernel: Process drbd15_receiver (pid: 5758,
threadinfo=3Deb2b2000 task=3Dc591c030)
May  3 05:17:59 choip kernel: Stack: <0>00000000 e7d8fe98 eb2b3eaa
cabe263a eb2b3e78 ee238515 00001000 000000d0=20
May  3 05:17:59 choip kernel:        0000002c 0000009f 0000003c 00000004
000000d0 eb2b3e80 00000002 eb2b3e94=20
May  3 05:17:59 choip ResourceManager[14004]: info: Acquiring resource
group: choip.sn.stratus.com drbddisk::shared.fs
Filesystem::/dev/drbd15::/shared 134.111.32.220 httpd smd
May  3 05:17:59 choip kernel:        eb2b3e80 eb2b3ebc ee42533c 00000004
00000001 0000009f 00000000 00000016=20
May  3 05:17:59 choip kernel: Call Trace:
May  3 05:17:59 choip kernel:  [<c0105a01>] show_stack_log_lvl+0xa1/0xe0
May  3 05:17:59 choip ResourceManager[14004]: info: Running
/etc/ha.d/resource.d/drbddisk shared.fs start
May  3 05:17:59 choip kernel:  [<c0105bf1>] show_registers+0x181/0x200
May  3 05:17:59 choip kernel:  [<c0105e10>] die+0x100/0x1b0
May  3 05:17:59 choip kernel:  [<c01168f6>] do_page_fault+0x3c6/0x8c1
May  3 05:17:59 choip kernel:  [<c010565f>] error_code+0x2b/0x30
May  3 05:17:59 choip kernel:  [<ee41ad8e>] after_state_ch+0x77e/0xa70
[drbd]
May  3 05:17:59 choip kernel:  [<ee40e1b1>] receive_state+0x281/0x3c0
[drbd]
May  3 05:17:59 choip kernel:  [<ee40e8a2>] drbdd+0x42/0x170 [drbd]
May  3 05:17:59 choip kernel:  [<ee40fc05>] drbdd_init+0x1c5/0x210
[drbd]
May  3 05:17:59 choip kernel:  [<ee41b10c>] drbd_thread_setup+0x8c/0x100
[drbd]
May  3 05:17:59 choip kernel:  [<c0103485>]
kernel_thread_helper+0x5/0x10
May  3 05:17:59 choip kernel: Code: ff ff ff 8b 52 0c eb 94 8d 74 26 00
8d bc 27 00 00 00 00 55 89 e5 57 56 53 83 ec 7c c7 45 90 00 10 00 00 89
c3 8b 80 c0 03 00 00 <f0> 0f ba 68 28 01 19 d2 31 c0 85 d2 0f 94 c0 85
c0 75 76 fc b9=20
May  3 05:17:59 choip kernel:  <0>Fatal exception: panic in 5 seconds=20
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
OK ...wait_event() is a macro and lc_try_lock() is inline.
so....lc->flags below is likely where we died.
static inline int lc_try_lock(struct lru_cache* lc)
{
        return !test_and_set_bit(__LC_DIRTY,&lc->flags); =
<=3D=3D=3D=3D=3DI think
we are here!!!!!
}

Dump of assembler code for function drbd_al_to_on_disk_bm:
0x00013520 <drbd_al_to_on_disk_bm+0>:  push  %ebp
0x00013521 <drbd_al_to_on_disk_bm+1>:  mov    %esp,%ebp
0x00013523 <drbd_al_to_on_disk_bm+3>:  push  %edi
0x00013524 <drbd_al_to_on_disk_bm+4>:  push  %esi
0x00013525 <drbd_al_to_on_disk_bm+5>:  push  %ebx
0x00013526 <drbd_al_to_on_disk_bm+6>:  sub    $0x7c,%esp
0x00013529 <drbd_al_to_on_disk_bm+9>:  movl  $0x1000,0xffffff90(%ebp)
0x00013530 <drbd_al_to_on_disk_bm+16>:  mov    %eax,%ebx
0x00013532 <drbd_al_to_on_disk_bm+18>:  mov    0x3c0(%eax),%eax
<=3D=3D=3D=3D=3Ddead here!!!
0x00013538 <drbd_al_to_on_disk_bm+24>:  lock btsl $0x1,0x28(%eax)
0x0001353e <drbd_al_to_on_disk_bm+30>:  sbb    %edx,%edx
0x00013540 <drbd_al_to_on_disk_bm+32>:  xor    %eax,%eax
0x00013542 <drbd_al_to_on_disk_bm+34>:  test  %edx,%edx
0x00013544 <drbd_al_to_on_disk_bm+36>:  sete  %al
0x00013547 <drbd_al_to_on_disk_bm+39>:  test  %eax,%eax
0x00013549 <drbd_al_to_on_disk_bm+41>:  jne    0x135c1
<drbd_al_to_on_disk_bm+161>
0x0001354b <drbd_al_to_on_disk_bm+43>:  cld

Here is theory since I cannot reproduce at will.  It seems to me that on
the panic'ed node our disk had a fault=20
inserted. so we went diskless.  At that point we call after_state_ch()
and did this:
 if ( os.disk > Diskless && ns.disk =3D=3D Diskless ) {
                /* since inc_local() only works as long as
disk>=3DInconsistent,
                  and it is Diskless here, local_cnt can only go down,
it can
                  not increase... It will reach zero */
                wait_event(mdev->misc_wait,
!atomic_read(&mdev->local_cnt));

                drbd_free_bc(mdev->bc); mdev->bc =3D NULL;
                lc_free(mdev->resync);  mdev->resync =3D NULL;
                lc_free(mdev->act_log); mdev->act_log =3D NULL; //We =
free
things here!!!!
        }
So we freed the the lrucache.

But later, the peer got a fault inserted and entered diskless so we set
peer to Secondary .  The panic'ed node receives that state and call
after_state_ch() and did this:
    if( ns.pdsk < Inconsistent ) {
                /* Diskless Peer becomes primary */
                if (os.peer =3D=3D Secondary && ns.peer =3D=3D Primary ) =
{
                        drbd_uuid_new_current(mdev);
                }
                /* Diskless Peer becomes secondary */
                if (os.peer =3D=3D Primary && ns.peer =3D=3D Secondary ) =
{
                        drbd_al_to_on_disk_bm(mdev);=20
                }
        }
But the lc entry was freed by the time  we called
drbd_al_to_on_disk_bm().  If this is correct, I am still not sure
how to best fix this.
=20
Thanks
EM--
=20

------_=_NextPart_001_01C79282.9E540D4D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D672582021-09052007>We are =
seeing a=20
panic in <FONT face=3D"Times New Roman"=20
size=3D3>drbd_al_to_on_disk_bm()</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3D"Times New Roman" size=3D3><SPAN=20
class=3D672582021-09052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D672582021-09052007>Below is the stack and a =
possible=20
cause:</SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D672582021-09052007>May&nbsp; 3 05:17:59 choip =
kernel: EIP=20
is at drbd_al_to_on_disk_bm+0x18/0x470 [drbd]<BR>May&nbsp; 3 05:17:59 =
choip=20
kernel: eax: 00000000&nbsp; ebx: ecbd013c&nbsp; ecx: 00000000&nbsp; edx: =

00000000<BR>May&nbsp; 3 05:17:59 choip kernel: esi: ecbd013c&nbsp; edi:=20
00000001&nbsp; ebp: eb2b3ebc&nbsp; esp: eb2b3e34<BR>May&nbsp; 3 05:17:59 =
choip=20
heartbeat: [5898]: info: standby: acquire [all] resources from=20
chois.sn.stratus.com<BR>May&nbsp; 3 05:17:59 choip kernel: ds: =
007b&nbsp; es:=20
007b&nbsp; ss: 0069<BR>May&nbsp; 3 05:17:59 choip heartbeat: [13993]: =
info:=20
acquire all HA resources (standby).<BR>May&nbsp; 3 05:17:59 choip =
kernel:=20
Process drbd15_receiver (pid: 5758, threadinfo=3Deb2b2000=20
task=3Dc591c030)<BR>May&nbsp; 3 05:17:59 choip kernel: Stack: =
&lt;0&gt;00000000=20
e7d8fe98 eb2b3eaa cabe263a eb2b3e78 ee238515 00001000 000000d0 =
<BR>May&nbsp; 3=20
05:17:59 choip kernel:&nbsp; &nbsp; &nbsp; &nbsp; 0000002c 0000009f =
0000003c=20
00000004 000000d0 eb2b3e80 00000002 eb2b3e94 <BR>May&nbsp; 3 05:17:59 =
choip=20
ResourceManager[14004]: info: Acquiring resource group: =
choip.sn.stratus.com=20
drbddisk::shared.fs Filesystem::/dev/drbd15::/shared 134.111.32.220 =
httpd=20
smd<BR>May&nbsp; 3 05:17:59 choip kernel:&nbsp; &nbsp; &nbsp; &nbsp; =
eb2b3e80=20
eb2b3ebc ee42533c 00000004 00000001 0000009f 00000000 00000016 =
<BR>May&nbsp; 3=20
05:17:59 choip kernel: Call Trace:<BR>May&nbsp; 3 05:17:59 choip =
kernel:&nbsp;=20
[&lt;c0105a01&gt;] show_stack_log_lvl+0xa1/0xe0<BR>May&nbsp; 3 05:17:59 =
choip=20
ResourceManager[14004]: info: Running /etc/ha.d/resource.d/drbddisk =
shared.fs=20
start<BR>May&nbsp; 3 05:17:59 choip kernel:&nbsp; [&lt;c0105bf1&gt;]=20
show_registers+0x181/0x200<BR>May&nbsp; 3 05:17:59 choip kernel:&nbsp;=20
[&lt;c0105e10&gt;] die+0x100/0x1b0<BR>May&nbsp; 3 05:17:59 choip =
kernel:&nbsp;=20
[&lt;c01168f6&gt;] do_page_fault+0x3c6/0x8c1<BR>May&nbsp; 3 05:17:59 =
choip=20
kernel:&nbsp; [&lt;c010565f&gt;] error_code+0x2b/0x30<BR>May&nbsp; 3 =
05:17:59=20
choip kernel:&nbsp; [&lt;ee41ad8e&gt;] after_state_ch+0x77e/0xa70=20
[drbd]<BR>May&nbsp; 3 05:17:59 choip kernel:&nbsp; [&lt;ee40e1b1&gt;]=20
receive_state+0x281/0x3c0 [drbd]<BR>May&nbsp; 3 05:17:59 choip =
kernel:&nbsp;=20
[&lt;ee40e8a2&gt;] drbdd+0x42/0x170 [drbd]<BR>May&nbsp; 3 05:17:59 choip =

kernel:&nbsp; [&lt;ee40fc05&gt;] drbdd_init+0x1c5/0x210 =
[drbd]<BR>May&nbsp; 3=20
05:17:59 choip kernel:&nbsp; [&lt;ee41b10c&gt;] =
drbd_thread_setup+0x8c/0x100=20
[drbd]<BR>May&nbsp; 3 05:17:59 choip kernel:&nbsp; [&lt;c0103485&gt;]=20
kernel_thread_helper+0x5/0x10<BR>May&nbsp; 3 05:17:59 choip kernel: =
Code: ff ff=20
ff 8b 52 0c eb 94 8d 74 26 00 8d bc 27 00 00 00 00 55 89 e5 57 56 53 83 =
ec 7c c7=20
45 90 00 10 00 00 89 c3 8b 80 c0 03 00 00 &lt;f0&gt; 0f ba 68 28 01 19 =
d2 31 c0=20
85 d2 0f 94 c0 85 c0 75 76 fc b9 <BR>May&nbsp; 3 05:17:59 choip =
kernel:&nbsp;=20
&lt;0&gt;Fatal exception: panic in 5 seconds </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D672582021-09052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D672582021-09052007>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D672582021-09052007>OK ...wait_event() is a =
macro and=20
lc_try_lock() is inline. so....lc-&gt;flags below is likely where we=20
died.<BR>static inline int lc_try_lock(struct lru_cache* =
lc)<BR>{<BR>&nbsp;=20
&nbsp; &nbsp; &nbsp; return =
!test_and_set_bit(__LC_DIRTY,&amp;lc-&gt;flags);=20
&lt;=3D=3D=3D=3D=3DI think we are here!!!!!<BR>}<BR><BR>Dump of =
assembler code for=20
function drbd_al_to_on_disk_bm:<BR>0x00013520=20
&lt;drbd_al_to_on_disk_bm+0&gt;:&nbsp; push&nbsp; %ebp<BR>0x00013521=20
&lt;drbd_al_to_on_disk_bm+1&gt;:&nbsp; mov&nbsp; &nbsp; =
%esp,%ebp<BR>0x00013523=20
&lt;drbd_al_to_on_disk_bm+3&gt;:&nbsp; push&nbsp; %edi<BR>0x00013524=20
&lt;drbd_al_to_on_disk_bm+4&gt;:&nbsp; push&nbsp; %esi<BR>0x00013525=20
&lt;drbd_al_to_on_disk_bm+5&gt;:&nbsp; push&nbsp; %ebx<BR>0x00013526=20
&lt;drbd_al_to_on_disk_bm+6&gt;:&nbsp; sub&nbsp; &nbsp; =
$0x7c,%esp<BR>0x00013529=20
&lt;drbd_al_to_on_disk_bm+9&gt;:&nbsp; movl&nbsp;=20
$0x1000,0xffffff90(%ebp)<BR>0x00013530 =
&lt;drbd_al_to_on_disk_bm+16&gt;:&nbsp;=20
mov&nbsp; &nbsp; %eax,%ebx<BR>0x00013532 =
&lt;drbd_al_to_on_disk_bm+18&gt;:&nbsp;=20
mov&nbsp; &nbsp; 0x3c0(%eax),%eax &lt;=3D=3D=3D=3D=3Ddead =
here!!!<BR>0x00013538=20
&lt;drbd_al_to_on_disk_bm+24&gt;:&nbsp; lock btsl =
$0x1,0x28(%eax)<BR>0x0001353e=20
&lt;drbd_al_to_on_disk_bm+30&gt;:&nbsp; sbb&nbsp; &nbsp; =
%edx,%edx<BR>0x00013540=20
&lt;drbd_al_to_on_disk_bm+32&gt;:&nbsp; xor&nbsp; &nbsp; =
%eax,%eax<BR>0x00013542=20
&lt;drbd_al_to_on_disk_bm+34&gt;:&nbsp; test&nbsp; =
%edx,%edx<BR>0x00013544=20
&lt;drbd_al_to_on_disk_bm+36&gt;:&nbsp; sete&nbsp; %al<BR>0x00013547=20
&lt;drbd_al_to_on_disk_bm+39&gt;:&nbsp; test&nbsp; =
%eax,%eax<BR>0x00013549=20
&lt;drbd_al_to_on_disk_bm+41&gt;:&nbsp; jne&nbsp; &nbsp; 0x135c1=20
&lt;drbd_al_to_on_disk_bm+161&gt;<BR>0x0001354b=20
&lt;drbd_al_to_on_disk_bm+43&gt;:&nbsp; cld<BR></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D672582021-09052007>Here is theory since I =
cannot=20
reproduce at will.&nbsp; It seems to me that on the panic'ed node our =
disk had a=20
fault </SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D672582021-09052007>inserted. so we went =
diskless.&nbsp;=20
At that point we call after_state_ch() and did this:<BR>&nbsp;if ( =
os.disk &gt;=20
Diskless &amp;&amp; ns.disk =3D=3D Diskless ) {<BR>&nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; /* since inc_local() only works as long as=20
disk&gt;=3DInconsistent,<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; and it is Diskless here, local_cnt can only go down, it=20
can<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
not=20
increase... It will reach zero */<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; wait_event(mdev-&gt;misc_wait,=20
!atomic_read(&amp;mdev-&gt;local_cnt));<BR><BR>&nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; drbd_free_bc(mdev-&gt;bc); mdev-&gt;bc =3D=20
NULL;<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=20
lc_free(mdev-&gt;resync);&nbsp; mdev-&gt;resync =3D NULL;<BR>&nbsp; =
&nbsp; &nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lc_free(mdev-&gt;act_log); =
mdev-&gt;act_log =3D=20
NULL;&nbsp;//We free things=20
here!!!!<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>So we freed =
the the=20
lrucache.<BR><BR>But later, the peer got a&nbsp;fault inserted and =
entered=20
diskless so we set peer to Secondary .&nbsp; The panic'ed node receives =
that=20
state and call after_state_ch() and did this:<BR>&nbsp; &nbsp; if( =
ns.pdsk &lt;=20
Inconsistent ) {<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; /*=20
Diskless Peer becomes primary */<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; if (os.peer =3D=3D Secondary &amp;&amp; ns.peer =3D=3D =
Primary )=20
{<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; drbd_uuid_new_current(mdev);<BR>&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;=20
&nbsp; &nbsp; &nbsp; }<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; /* Diskless Peer becomes secondary */<BR>&nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; if (os.peer =3D=3D Primary &amp;&amp; =
ns.peer =3D=3D=20
Secondary ) {<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; &nbsp;=20
drbd_al_to_on_disk_bm(mdev);&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
}<BR>&nbsp; &nbsp; &nbsp; &nbsp; }<BR>But the lc entry was freed&nbsp;by =
the=20
time &nbsp;we called drbd_al_to_on_disk_bm().&nbsp; If this is correct, =
I am=20
still not sure</SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D672582021-09052007>how to best fix=20
this.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D672582021-09052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D672582021-09052007>Thanks</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D672582021-09052007>EM--</SPAN></FONT></DIV>
<DIV><FONT><SPAN=20
class=3D672582021-09052007>&nbsp;</DIV></SPAN></FONT></BODY></HTML>

------_=_NextPart_001_01C79282.9E540D4D--
