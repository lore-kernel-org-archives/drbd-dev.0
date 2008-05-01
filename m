Return-Path: <azeez.ahamed@rediffmail.com>
Date: 1 May 2008 08:42:29 -0000
Message-ID: <20080501084229.9197.qmail@f5mail-237-206.rediffmail.com>
MIME-Version: 1.0
From: "Azeez Ahamed" <azeez.ahamed@rediffmail.com>
To: drbd-dev@lists.linbit.com
Subject: Re: Re: [Drbd-dev] Re: DRBD contribution
Content-type: multipart/alternative;
	boundary="Next_1209631349---0-202.137.237.206-9188"
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


--Next_1209631349---0-202.137.237.206-9188
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=0A>Right. There should be no limit. The intention was to replace=0A>res->m=
e and res->peer by a list. I guess this is what you have=0A>done, right?=0A=
>=0AInitially, i thought of implementing this way. This would require=0Acha=
nges in the code at many places. So, I have implemented in different=0Away =
with minimal impact. Logic i followed is=0A=0A   1) Getting the value from =
the command line when -h <argument> is =0A      specified. It will be store=
d in "peer_host" global variable.=0A   2) Added a new function called "find=
_peer_host()" in drbdadm_main.c =0A      file. From adm_connect(), this new=
 function is called with =0A      res->all_hosts and "peer_host" as argumen=
ts to this new function.=0A      It will compare the "peer_host" value with=
 the hosts->name. If =0A      found,then returns the pointer to that host o=
therwise NULL.=0A   3) In adm_connect(), it is made sure that peer host wil=
l not be =0A      local host and if -h option is not specified on the comma=
nd line=0A      then the last 'on' section in the 'resource' is selected as=
 =0A      peer host. This logic can be improved by using DEFAULT keyword=0A=
      as you suggested below.=0A=0AFor reference, i will send the two files=
 (drbdadm_parser.c and=0Adrbdadm_main.c). Please go through the code and le=
t me know if i am=0Agoing wrong anywhere.=0A=0A>In case there is no '-h <pe=
er-name>' option on the command line _AND_=0A>there are only two 'on' secti=
ons _AND_ on of the one sections matches=0A>my own local host name, then th=
e peer is the other 'on' section.=0A>=0A This is taken care in my code.=0A=
=0A>In order to specify a default peer, there should be an additional=0A>ke=
yword. E.g. "default". That keyword might only be specified in=0A>two of th=
e 'on' sections.=0A>=0AI understood the above statement like this=0A=0A  on=
 node2 {=0A     device        /dev/drbd0;=0A     disk          /dev/loop0;=
=0A     address       10.1.40.37:1234;=0A     meta-disk     internal;=0A   =
  default-peer  yes;   ---> new parameter added=0A  }=0A=0AIs this way you =
are telling me to implement default peer host?=0A=0A=0A>I do not think it i=
s a good idea to make the default selection=0A>dependend on the order of th=
e sections in the config file, since=0A>we advise our users to use the same=
 config file on all nodes of=0A>the cluster.=0A>=0A=0AI think the above log=
ic what i told will take care this also.=0A=0AThanks,=0AAzeez=0A=0A
--Next_1209631349---0-202.137.237.206-9188
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A<BR>=0A&gt;Right. There should be no limit. The intention was to repl=
ace<BR>=0A&gt;res-&gt;me and res-&gt;peer by a list. I guess this is what y=
ou have<BR>=0A&gt;done, right?<BR>=0A&gt;<BR>=0AInitially, i thought of imp=
lementing this way. This would require<BR>=0Achanges in the code at many pl=
aces. So, I have implemented in different<BR>=0Away with minimal impact. Lo=
gic i followed is<BR>=0A<BR>=0A&nbsp;  1) Getting the value from the comman=
d line when -h &lt;argument&gt; is <BR>=0A&nbsp; &nbsp; &nbsp; specified. I=
t will be stored in &quot;peer_host&quot; global variable.<BR>=0A&nbsp;  2)=
 Added a new function called &quot;find_peer_host()&quot; in drbdadm_main.c=
 <BR>=0A&nbsp; &nbsp; &nbsp; file. From adm_connect(), this new function is=
 called with <BR>=0A&nbsp; &nbsp; &nbsp; res-&gt;all_hosts and &quot;peer_h=
ost&quot; as arguments to this new function.<BR>=0A&nbsp; &nbsp; &nbsp; It =
will compare the &quot;peer_host&quot; value with the hosts-&gt;name. If <B=
R>=0A&nbsp; &nbsp; &nbsp; found,then returns the pointer to that host other=
wise NULL.<BR>=0A&nbsp;  3) In adm_connect(), it is made sure that peer hos=
t will not be <BR>=0A&nbsp; &nbsp; &nbsp; local host and if -h option is no=
t specified on the command line<BR>=0A&nbsp; &nbsp; &nbsp; then the last 'o=
n' section in the 'resource' is selected as <BR>=0A&nbsp; &nbsp; &nbsp; pee=
r host. This logic can be improved by using DEFAULT keyword<BR>=0A&nbsp; &n=
bsp; &nbsp; as you suggested below.<BR>=0A<BR>=0AFor reference, i will send=
 the two files (drbdadm_parser.c and<BR>=0Adrbdadm_main.c). Please go throu=
gh the code and let me know if i am<BR>=0Agoing wrong anywhere.<BR>=0A<BR>=
=0A&gt;In case there is no '-h &lt;peer-name&gt;' option on the command lin=
e _AND_<BR>=0A&gt;there are only two 'on' sections _AND_ on of the one sect=
ions matches<BR>=0A&gt;my own local host name, then the peer is the other '=
on' section.<BR>=0A&gt;<BR>=0A This is taken care in my code.<BR>=0A<BR>=0A=
&gt;In order to specify a default peer, there should be an additional<BR>=
=0A&gt;keyword. E.g. &quot;default&quot;. That keyword might only be specif=
ied in<BR>=0A&gt;two of the 'on' sections.<BR>=0A&gt;<BR>=0AI understood th=
e above statement like this<BR>=0A<BR>=0A&nbsp; on node2 {<BR>=0A&nbsp; &nb=
sp;  device&nbsp; &nbsp; &nbsp; &nbsp; /dev/drbd0;<BR>=0A&nbsp; &nbsp;  dis=
k&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /dev/loop0;<BR>=0A&nbsp; &nbsp;  addres=
s&nbsp; &nbsp; &nbsp;  10.1.40.37:1234;<BR>=0A&nbsp; &nbsp;  meta-disk&nbsp=
; &nbsp;  internal;<BR>=0A&nbsp; &nbsp;  default-peer&nbsp; yes;&nbsp;  ---=
&gt; new parameter added<BR>=0A&nbsp; }<BR>=0A<BR>=0AIs this way you are te=
lling me to implement default peer host?<BR>=0A<BR>=0A<BR>=0A&gt;I do not t=
hink it is a good idea to make the default selection<BR>=0A&gt;dependend on=
 the order of the sections in the config file, since<BR>=0A&gt;we advise ou=
r users to use the same config file on all nodes of<BR>=0A&gt;the cluster.<=
BR>=0A&gt;<BR>=0A<BR>=0AI think the above logic what i told will take care =
this also.<BR>=0A<BR>=0AThanks,<BR>=0AAzeez<BR>=0A<BR>=0A=0A</P>=0A<br><br>=
=0A<Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=3D=
0 style=3D'font-family:Verdana;font-size:11px;line-height:15px;'><TR><td><a=
 href=3D'http://adworks.rediff.com/cgi-bin/AdWorks/click.cgi/www.rediff.com=
/signature-home.htm/1050715198@Middle5/2092210_2084731/2092364/1?PARTNER=3D=
3&OAS_QUERY=3Dnull' target=3Dnew ><img src =3D'http://imadworks.rediff.com/=
cgi-bin/AdWorks/adimage.cgi/2092210_2084731/creative_2092364.gif'  alt=3D'I=
PL'  border=3D0></a></td></TR></Table>
--Next_1209631349---0-202.137.237.206-9188--

