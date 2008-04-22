Return-Path: <azeez.ahamed@rediffmail.com>
Date: 22 Apr 2008 07:57:43 -0000
Message-ID: <20080422075743.16073.qmail@f5mail-236-217.rediffmail.com>
MIME-Version: 1.0
From: "Azeez Ahamed" <azeez.ahamed@rediffmail.com>
To: drbd-dev@lists.linbit.com
Content-type: multipart/alternative;
	boundary="Next_1208851063---0-202.137.236.217-16069"
Subject: [Drbd-dev] DRBD contribution
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


--Next_1208851063---0-202.137.236.217-16069
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 =0A>It is in our own intrest to make our bugzilla publically available,=0A=
>at least for read access. -- But I do not have the resources right=0A>now =
for that.=0A>=0A>And I think that will not be of much use for you, since to=
 work on the=0A>issues that are currently open in bugzilla you need to have=
 years=0A>of experience with kernel development, and need quite some time t=
o=0A>get familiarize yourself with the DRBD module code base.=0A>=0A>But I =
suggest that you select one of these tasks for you debut=0A>as DRBD contrib=
utor:=0A>=0A>   1 Implement an include statement for the config file in drb=
dadm.=0A>     So that one can have a /etc/drbd.d/res1.conf .... and a=0A>  =
   /etc/drbd.conf that only says "include /etc/drbd.d/*;"=0A>     [for DRBD=
-8.2]=0A>=0A>   2 Work on the spec file. The RPMs that get currently build=
=0A>     lack a dependency on the kernel they are built for. Add that=0A>  =
   dependency. PS: You have to take care that it works for RHEL=0A>     and=
 for SLES=0A>     [for DRBD-8.0 and will get propagated to 8.2 from there]=
=0A>=0A>   3 Change drbdadm so that it allows multiple "on" sections per=0A=
>     resource. -- One has to specify the peer he means on the=0A>     comm=
andline when use drbdadm connect.=0A>     [for DRBD-8.2]=0A>=0A>-Phil=0A=0A=
I need some clarification on the activities you suggested me to =0Adevelop.=
=0A=0A>   3 Change drbdadm so that it allows multiple "on" sections per=0A>=
     resource. -- One has to specify the peer he means on the=0A>     comma=
ndline when use drbdadm connect.=0A>     [for DRBD-8.2]=0A=0A  Here you are=
 looking for 1 to n node replication? When we use =0Adrbdadm connect comman=
d, it uses this command internally=0A=0Adrbdsetup /dev/drbd0 net 10.1.40.33=
:1234 10.1.40.41:1234 C --set-defaults --create-device=0A=0A  Do i need to =
modify drbdsetup command to support multiple nodes?=0APlease correct me if =
i am wrong.=0A=0A  =0A  Also, provide some details on the following activit=
y=0A=0A>   1 Implement an include statement for the config file in drbdadm.=
=0A>     So that one can have a /etc/drbd.d/res1.conf .... and a=0A>     /e=
tc/drbd.conf that only says "include /etc/drbd.d/*;"=0A>     [for DRBD-8.2]=
=0A>=0A=0AThanks,=0AAzeez
--Next_1208851063---0-202.137.236.217-16069
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A <BR>=0A&gt;It is in our own intrest to make our bugzilla publically =
available,<BR>=0A&gt;at least for read access. -- But I do not have the res=
ources right<BR>=0A&gt;now for that.<BR>=0A&gt;<BR>=0A&gt;And I think that =
will not be of much use for you, since to work on the<BR>=0A&gt;issues that=
 are currently open in bugzilla you need to have years<BR>=0A&gt;of experie=
nce with kernel development, and need quite some time to<BR>=0A&gt;get fami=
liarize yourself with the DRBD module code base.<BR>=0A&gt;<BR>=0A&gt;But I=
 suggest that you select one of these tasks for you debut<BR>=0A&gt;as DRBD=
 contributor:<BR>=0A&gt;<BR>=0A&gt;&nbsp;  1 Implement an include statement=
 for the config file in drbdadm.<BR>=0A&gt;&nbsp; &nbsp;  So that one can h=
ave a /etc/drbd.d/res1.conf .... and a<BR>=0A&gt;&nbsp; &nbsp;  /etc/drbd.c=
onf that only says &quot;include /etc/drbd.d/*;&quot;<BR>=0A&gt;&nbsp; &nbs=
p;  [for DRBD-8.2]<BR>=0A&gt;<BR>=0A&gt;&nbsp;  2 Work on the spec file. Th=
e RPMs that get currently build<BR>=0A&gt;&nbsp; &nbsp;  lack a dependency =
on the kernel they are built for. Add that<BR>=0A&gt;&nbsp; &nbsp;  depende=
ncy. PS: You have to take care that it works for RHEL<BR>=0A&gt;&nbsp; &nbs=
p;  and for SLES<BR>=0A&gt;&nbsp; &nbsp;  [for DRBD-8.0 and will get propag=
ated to 8.2 from there]<BR>=0A&gt;<BR>=0A&gt;&nbsp;  3 Change drbdadm so th=
at it allows multiple &quot;on&quot; sections per<BR>=0A&gt;&nbsp; &nbsp;  =
resource. -- One has to specify the peer he means on the<BR>=0A&gt;&nbsp; &=
nbsp;  commandline when use drbdadm connect.<BR>=0A&gt;&nbsp; &nbsp;  [for =
DRBD-8.2]<BR>=0A&gt;<BR>=0A&gt;-Phil<BR>=0A<BR>=0AI need some clarification=
 on the activities you suggested me to <BR>=0Adevelop.<BR>=0A<BR>=0A&gt;&nb=
sp;  3 Change drbdadm so that it allows multiple &quot;on&quot; sections pe=
r<BR>=0A&gt;&nbsp; &nbsp;  resource. -- One has to specify the peer he mean=
s on the<BR>=0A&gt;&nbsp; &nbsp;  commandline when use drbdadm connect.<BR>=
=0A&gt;&nbsp; &nbsp;  [for DRBD-8.2]<BR>=0A<BR>=0A&nbsp; Here you are looki=
ng for 1 to n node replication? When we use <BR>=0Adrbdadm connect command,=
 it uses this command internally<BR>=0A<BR>=0Adrbdsetup /dev/drbd0 net 10.1=
.40.33:1234 10.1.40.41:1234 C --set-defaults --create-device<BR>=0A<BR>=0A&=
nbsp; Do i need to modify drbdsetup command to support multiple nodes?<BR>=
=0APlease correct me if i am wrong.<BR>=0A<BR>=0A&nbsp; <BR>=0A&nbsp; Also,=
 provide some details on the following activity<BR>=0A<BR>=0A&gt;&nbsp;  1 =
Implement an include statement for the config file in drbdadm.<BR>=0A&gt;&n=
bsp; &nbsp;  So that one can have a /etc/drbd.d/res1.conf .... and a<BR>=0A=
&gt;&nbsp; &nbsp;  /etc/drbd.conf that only says &quot;include /etc/drbd.d/=
*;&quot;<BR>=0A&gt;&nbsp; &nbsp;  [for DRBD-8.2]<BR>=0A&gt;<BR>=0A<BR>=0ATh=
anks,<BR>=0AAzeez=0A</P>=0A<br><br>=0A<Table border=3D0 Width=3D644 Height=
=3D57 cellspacing=3D0 cellpadding=3D0 style=3D'font-family:Verdana;font-siz=
e:11px;line-height:15px;'><TR><td><img src =3D'http://imadworks.rediff.com/=
cgi-bin/AdWorks/adimage.cgi/2087310_2079844/creative_2087453.jpg'  alt=3D'J=
S RED'  border=3D0></td></TR></Table>
--Next_1208851063---0-202.137.236.217-16069--

