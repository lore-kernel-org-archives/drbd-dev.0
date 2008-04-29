Return-Path: <azeez.ahamed@rediffmail.com>
Date: 29 Apr 2008 11:19:46 -0000
Message-ID: <20080429111946.13238.qmail@f5mail-237-208.rediffmail.com>
MIME-Version: 1.0
From: "Azeez Ahamed" <azeez.ahamed@rediffmail.com>
To: drbd-dev@lists.linbit.com
Content-type: multipart/alternative;
	boundary="Next_1209467986---0-202.137.237.208-13217"
Subject: [Drbd-dev] Re: DRBD contribution
Reply-To: Azeez Ahamed <azeez.ahamed@rediffmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

 This is a multipart mime message


--Next_1209467986---0-202.137.237.208-13217
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Philipp,=0A=0A    Thanks for the inputs you provided. I have made a g=
ood progress=0Aon the patch you suggested me to develop. Before I submit th=
e code,=0Ai want to make sure your requirements are matched.=0A=0ASo far i =
have developed=0A   * Before only two 'on' sections per resource were allow=
ed. This=0A     information was available in res->me and res->peer. =0A    =
 Now, allowing multiple 'on' sections. As of now, no limit is =0A     provi=
ded. If you are looking for some limit for no. of peer=0A     host, then pl=
ease let me know. =0A=0A   * Added a new option in drbdadm command i.e. --p=
eer-host. =0A     # drbdadm=0A       =0A       OPTIONS:=0A        {--dry-ru=
n|-d}=0A        {--verbose|-v}=0A            ...=0A        {--sh-varname|-n=
} val=0A        {--peer-host|-h} val   =3D=3D=3D> new option added=0A=0A   =
  Syntax will be:=0A        drbdadm -h <peer-name> connect <resource>=0A   =
  Let me know if you want to change the option name.=0A=0A   * For selectin=
g the peer host, i have used the following logic=0A     =0A     If '-h <pee=
r-name>' option is specified, then searching the =0A     <peer-name> under =
<resource> in the config file. If found,=0A     then this <peer-name> is us=
ed as peer host. Otherwise, an=0A     error is displayed and drbdadm progra=
m exits.=0A=0A     If '-h <peer-name>' option is not specified, then peer n=
ame will=0A     be taken from the second 'on' section's name of that <resou=
rce>. =0A     In this case, only two 'on' sections will be there. During DR=
BD =0A     service start, as of now drbdadm is not called with new option =
=0A     i.e. -h <peer-name>.=0A=0A     In that case we need to change the d=
rbd script or use default =0A     <peer-name> for drbdadm command. In my ca=
se i am using second 'on'=0A     section's name as default <peer-name> for =
drbdadm command.=0A=0A     In both the cases(with/without -h option), it is=
 made sure that =0A     peer host name is not same as local host. Otherwise=
, an error is =0A     displayed and drbdadm program exits. =0A=0A=0APlease =
let me know if i am going in the right direction. Also,=0Ai will make sure =
that the signed License Agreement is sent to you=0Abefore i submit my code.=
=0A=0A    =0AThanks,=0AAzeez=0A=0AOn Tue, 22 Apr 2008 Philipp Reisner wrote=
 :=0A> > I need some clarification on the activities you suggested me to=0A=
> > develop.=0A> >=0A> > >   3 Change drbdadm so that it allows multiple "o=
n" sections per=0A> > >     resource. -- One has to specify the peer he mea=
ns on the=0A> > >     commandline when use drbdadm connect.=0A> > >     [fo=
r DRBD-8.2]=0A> >=0A> >   Here you are looking for 1 to n node replication?=
 When we use=0A> > drbdadm connect command, it uses this command internally=
=0A> >=0A> > drbdsetup /dev/drbd0 net 10.1.40.33:1234 10.1.40.41:1234 C --s=
et-defaults=0A> > --create-device=0A> >=0A> >   Do i need to modify drbdset=
up command to support multiple nodes?=0A> > Please correct me if i am wrong=
.=0A> >=0A>=0A>Hi Azeez,=0A>=0A>What I suggest is that the DRBD-driver and =
drbdsetup should stay as=0A>they are. I suggest that you modify drbdadm so =
that one can specify=0A>multiple on sections in a resource section.=0A>=0A>=
As the driver and drbdsetup are two nodes only, one will then have=0A>to se=
lect a peer node when calling drbdadm connect. So the command=0A>line synta=
x of drbdadm will have to change as well. Maybe=0A>=0A>drbdadm --to foo-nod=
e connect r0=0A>=0A>Phil=0A>--=0A>: Dipl-Ing Philipp Reisner               =
       Tel +43-1-8178292-50 :=0A>: LINBIT Information Technologies GmbH    =
      Fax +43-1-8178292-82 :=0A>: Vivenotgasse 48, 1120 Vienna, Austria    =
    http://www.linbit.com :=0A
--Next_1209467986---0-202.137.237.208-13217
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHello Philipp,<BR>=0A<BR>=0A&nbsp; &nbsp; Thanks for the inputs you p=
rovided. I have made a good progress<BR>=0Aon the patch you suggested me to=
 develop. Before I submit the code,<BR>=0Ai want to make sure your requirem=
ents are matched.<BR>=0A<BR>=0ASo far i have developed<BR>=0A&nbsp;  * Befo=
re only two 'on' sections per resource were allowed. This<BR>=0A&nbsp; &nbs=
p;  information was available in res-&gt;me and res-&gt;peer. <BR>=0A&nbsp;=
 &nbsp;  Now, allowing multiple 'on' sections. As of now, no limit is <BR>=
=0A&nbsp; &nbsp;  provided. If you are looking for some limit for no. of pe=
er<BR>=0A&nbsp; &nbsp;  host, then please let me know. <BR>=0A<BR>=0A&nbsp;=
  * Added a new option in drbdadm command i.e. --peer-host. <BR>=0A&nbsp; &=
nbsp;  # drbdadm<BR>=0A&nbsp; &nbsp; &nbsp;  <BR>=0A&nbsp; &nbsp; &nbsp;  O=
PTIONS:<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; {--dry-run|-d}<BR>=0A&nbsp; &nbsp=
; &nbsp; &nbsp; {--verbose|-v}<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; ...<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; {--sh-varname|-n} val<BR>=0A&nbsp=
; &nbsp; &nbsp; &nbsp; {--peer-host|-h} val&nbsp;  =3D=3D=3D&gt; new option=
 added<BR>=0A<BR>=0A&nbsp; &nbsp;  Syntax will be:<BR>=0A&nbsp; &nbsp; &nbs=
p; &nbsp; drbdadm -h &lt;peer-name&gt; connect &lt;resource&gt;<BR>=0A&nbsp=
; &nbsp;  Let me know if you want to change the option name.<BR>=0A<BR>=0A&=
nbsp;  * For selecting the peer host, i have used the following logic<BR>=
=0A&nbsp; &nbsp;  <BR>=0A&nbsp; &nbsp;  If '-h &lt;peer-name&gt;' option is=
 specified, then searching the <BR>=0A&nbsp; &nbsp;  &lt;peer-name&gt; unde=
r &lt;resource&gt; in the config file. If found,<BR>=0A&nbsp; &nbsp;  then =
this &lt;peer-name&gt; is used as peer host. Otherwise, an<BR>=0A&nbsp; &nb=
sp;  error is displayed and drbdadm program exits.<BR>=0A<BR>=0A&nbsp; &nbs=
p;  If '-h &lt;peer-name&gt;' option is not specified, then peer name will<=
BR>=0A&nbsp; &nbsp;  be taken from the second 'on' section's name of that &=
lt;resource&gt;. <BR>=0A&nbsp; &nbsp;  In this case, only two 'on' sections=
 will be there. During DRBD <BR>=0A&nbsp; &nbsp;  service start, as of now =
drbdadm is not called with new option <BR>=0A&nbsp; &nbsp;  i.e. -h &lt;pee=
r-name&gt;.<BR>=0A<BR>=0A&nbsp; &nbsp;  In that case we need to change the =
drbd script or use default <BR>=0A&nbsp; &nbsp;  &lt;peer-name&gt; for drbd=
adm command. In my case i am using second 'on'<BR>=0A&nbsp; &nbsp;  section=
's name as default &lt;peer-name&gt; for drbdadm command.<BR>=0A<BR>=0A&nbs=
p; &nbsp;  In both the cases(with/without -h option), it is made sure that =
<BR>=0A&nbsp; &nbsp;  peer host name is not same as local host. Otherwise, =
an error is <BR>=0A&nbsp; &nbsp;  displayed and drbdadm program exits. <BR>=
=0A<BR>=0A<BR>=0APlease let me know if i am going in the right direction. A=
lso,<BR>=0Ai will make sure that the signed License Agreement is sent to yo=
u<BR>=0Abefore i submit my code.<BR>=0A<BR>=0A&nbsp; &nbsp; <BR>=0AThanks,<=
BR>=0AAzeez<BR>=0A<BR>=0AOn Tue, 22 Apr 2008 Philipp Reisner wrote :<BR>=0A=
&gt; &gt; I need some clarification on the activities you suggested me to<B=
R>=0A&gt; &gt; develop.<BR>=0A&gt; &gt;<BR>=0A&gt; &gt; &gt;&nbsp;  3 Chang=
e drbdadm so that it allows multiple &quot;on&quot; sections per<BR>=0A&gt;=
 &gt; &gt;&nbsp; &nbsp;  resource. -- One has to specify the peer he means =
on the<BR>=0A&gt; &gt; &gt;&nbsp; &nbsp;  commandline when use drbdadm conn=
ect.<BR>=0A&gt; &gt; &gt;&nbsp; &nbsp;  [for DRBD-8.2]<BR>=0A&gt; &gt;<BR>=
=0A&gt; &gt;&nbsp;  Here you are looking for 1 to n node replication? When =
we use<BR>=0A&gt; &gt; drbdadm connect command, it uses this command intern=
ally<BR>=0A&gt; &gt;<BR>=0A&gt; &gt; drbdsetup /dev/drbd0 net 10.1.40.33:12=
34 10.1.40.41:1234 C --set-defaults<BR>=0A&gt; &gt; --create-device<BR>=0A&=
gt; &gt;<BR>=0A&gt; &gt;&nbsp;  Do i need to modify drbdsetup command to su=
pport multiple nodes?<BR>=0A&gt; &gt; Please correct me if i am wrong.<BR>=
=0A&gt; &gt;<BR>=0A&gt;<BR>=0A&gt;Hi Azeez,<BR>=0A&gt;<BR>=0A&gt;What I sug=
gest is that the DRBD-driver and drbdsetup should stay as<BR>=0A&gt;they ar=
e. I suggest that you modify drbdadm so that one can specify<BR>=0A&gt;mult=
iple on sections in a resource section.<BR>=0A&gt;<BR>=0A&gt;As the driver =
and drbdsetup are two nodes only, one will then have<BR>=0A&gt;to select a =
peer node when calling drbdadm connect. So the command<BR>=0A&gt;line synta=
x of drbdadm will have to change as well. Maybe<BR>=0A&gt;<BR>=0A&gt;drbdad=
m --to foo-node connect r0<BR>=0A&gt;<BR>=0A&gt;Phil<BR>=0A&gt;--<BR>=0A&gt=
;: Dipl-Ing Philipp Reisner&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; Tel +43-1-8178292-50 :<BR>=0A&gt;: LINBIT Info=
rmation Technologies GmbH&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Fax +43-1-81782=
92-82 :<BR>=0A&gt;: Vivenotgasse 48, 1120 Vienna, Austria&nbsp; &nbsp; &nbs=
p; &nbsp; http://www.linbit.com :<BR>=0A=0A</P>=0A<br><br>=0A<Table border=
=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=3D0 style=3D'font-=
family:Verdana;font-size:11px;line-height:15px;'><TR><td><img src =3D'http:=
//imadworks.rediff.com/cgi-bin/AdWorks/adimage.cgi/2087310_2079844/creative=
_2087453.jpg'  alt=3D'JS RED'  border=3D0></td></TR></Table>
--Next_1209467986---0-202.137.237.208-13217--

