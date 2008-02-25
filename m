Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C877ED.5654AA86"
Date: Mon, 25 Feb 2008 15:31:01 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47ACB@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767108591DEC@EXNA.corp.stratus.com>
References: <342BAC0A5467384983B586A6B0B3767108591DEC@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] I/O can hang on primary synctarget after an io error.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C877ED.5654AA86
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are seeing an issue where I/O to a volume that received an I/O error
during re-sync as the sync target hangs. Looking at the logs it seems
that what's going on is that we are skipping a dec_local().  My theory
is that after_state_ch() is blocked forever waiting for local_cnt to be
0 as we are becoming Diskless.  So the worker will not do any work,
hence the hang I/O.  Here is the relevant logs:
=20
Feb 13 03:48:55 node0 kernel: drbd5: Began resync as SyncTarget (will
sync 1048508 KB [262127 bits set]).
Feb 13 03:48:55 node0 kernel: drbd5: Writing meta data super block now.
Feb 13 03:48:55 node0 kernel: drbd5: Creating new epoch in
drbd_try_rs_begin_io
Feb 13 03:48:55 node0 kernel: drbd5: ***Simulating Resync write failure
Feb 13 03:48:56 node0 kernel: drbd5: Resync aborted.
Feb 13 03:48:56 node0 kernel: drbd5: conn( SyncTarget -> Connected )
disk( Inconsistent -> Failed )
Feb 13 03:48:56 node0 kernel: drbd5: Local IO failed. Detaching...
Feb 13 03:48:56 node0 kernel: drbd5: disk( Failed -> Diskless )
Feb 13 03:48:56 node0 kernel: drbd5: Notified peer that my disk is
broken.
Feb 13 03:48:56 node0 kernel: drbd5: Can not write resync data to local
disk.
Feb 13 03:54:57 node0 kernel: drbd5: drbd_nl_disk_conf: mdev->bc not
NULL.
=20
Notice the last line of the log.  Our test environment must have tried
to do an "attach" so since local_cnt is not 0 we never freed the "bc".
=20
But from the "Can not write resync data to local disk." we can go to
drbd_endio_write_sec() and there we see a suspicious :
If(bio->bi_size) return 1;=20
We are supposed to do the dec_local at the end of drbd_endio_write
sec(). I am guessing that's where the problem is.  But I do not know why
bi_size would be greater then 0.  Is the fix simply to dec_local while
returning?
=20
BTW, the code below  inserts the fault in question but won't necessarily
make the hang happens:
=20
#!/bin/sh
echo inserting fault....
echo 0x4 >/sys/module/drbd/parameters/enable_faults
echo 0x20 >/sys/module/drbd/parameters/fault_devs
echo 5 > /sys/module/drbd/parameters/fault_rate
echo starting resync
sleep 5
drbdadm -c /etc/drbd.conf.avance invalidate drbd5.vol
echo done....
=20
Thanks,
=20
EM--

------_=_NextPart_001_01C877ED.5654AA86
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns=3D"http://www.w3.org/TR/REC-html40"
xmlns:ns2=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/"
xmlns:ns3=3D"http://schemas.openxmlformats.org/markup-compatibility/2006"=

xmlns:ns1=3D"http://schemas.microsoft.com/office/2004/12/omml"
xmlns:ns4=3D"http://schemas.openxmlformats.org/package/2006/relationships=
"
xmlns:ns5=3D"http://schemas.microsoft.com/exchange/services/2006/types"
xmlns:ns6=3D"http://schemas.microsoft.com/exchange/services/2006/messages=
">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C877C3.6D74D340">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--a:link
	{mso-style-priority:99;}
span.MSOHYPERLINK
	{mso-style-priority:99;}
a:visited
	{mso-style-priority:99;}
span.MSOHYPERLINKFOLLOWED
	{mso-style-priority:99;}

 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	mso-font-alt:"Times New Roman";
	mso-font-charset:0;
	mso-generic-font-family:auto;
	mso-font-pitch:auto;
	mso-font-signature:0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:Calibri;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal;
	mso-style-noshow:yes;
	font-family:Calibri;
	mso-ascii-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi =
all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>We are seeing an issue where I/O to =
a
volume that received an I/O error during re-sync as the sync target =
hangs. Looking
at the logs it seems that what&#8217;s going on is that we are skipping =
a <span
class=3DSpellE>dec_<span class=3DGramE>local</span></span><span =
class=3DGramE>(</span>).
<span style=3D'mso-spacerun:yes'>&nbsp;</span>My theory is that <span
class=3DSpellE>after_state_<span class=3DGramE>ch</span></span><span =
class=3DGramE>(</span>)
is blocked forever waiting for <span class=3DSpellE>local_cnt</span> to =
be 0 as
we are becoming Diskless. <span =
style=3D'mso-spacerun:yes'>&nbsp;</span>So the
worker will not do any work, hence the hang I/O. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>Here <span class=3DGramE>is the =
relevant logs</span>:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>Feb 13 =
03:48:55
node0 kernel: drbd5: Began <span class=3DSpellE>resync</span> as <span
class=3DSpellE>SyncTarget</span> (will sync 1048508 KB [262127 bits =
set]).<br>
Feb 13 03:48:55 node0 kernel: drbd5: Writing <span =
class=3DGramE>meta</span> data
super block now.<br>
Feb 13 03:48:55 node0 kernel: drbd5: Creating new epoch in <span =
class=3DSpellE>drbd_try_rs_begin_io</span><br>
Feb 13 03:48:55 node0 kernel: drbd5: ***Simulating <span =
class=3DSpellE>Resync</span>
write failure<br>
Feb 13 03:48:56 node0 kernel: drbd5: <span class=3DSpellE>Resync</span> =
aborted.<br>
Feb 13 03:48:56 node0 kernel: drbd5: <span class=3DSpellE><span =
class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>SyncTarget</span> -&gt; =
Connected )
disk( Inconsistent -&gt; Failed )<br>
Feb 13 03:48:56 node0 kernel: drbd5: Local IO failed. Detaching...<br>
Feb 13 03:48:56 node0 kernel: drbd5: <span class=3DGramE>disk(</span> =
Failed
-&gt; Diskless )<br>
Feb 13 03:48:56 node0 kernel: drbd5: Notified peer that my disk is =
broken.<br>
Feb 13 03:48:56 node0 kernel: drbd5: Can not write <span =
class=3DSpellE>resync</span>
data to local disk.<br>
Feb 13 03:54:57 node0 kernel: drbd5: <span =
class=3DSpellE>drbd_nl_disk_conf</span>:
<span class=3DSpellE>mdev</span>-&gt;<span class=3DSpellE><span =
class=3DGramE>bc</span></span>
not NULL.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:9.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Notice the last line of the log. =
<span
style=3D'mso-spacerun:yes'>&nbsp;</span>Our test environment must have =
tried to
do an &#8220;attach&#8221; so since <span =
class=3DSpellE>local_cnt</span> is not
0 we never freed the &#8220;<span =
class=3DSpellE>bc</span>&#8221;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>But from the =
&#8220;</span></font><font
size=3D1 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:9.0pt;font-family:
"Courier New";color:black'>Can not write <span =
class=3DSpellE>resync</span> data
to local disk.&#8221; </span></font><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>we can go to =
<span
class=3DSpellE>drbd_endio_write_<span =
class=3DGramE>sec</span></span><span
class=3DGramE>(</span>) and there we see a suspicious =
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>If(</span></font>=
</span><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'>bio-&gt;<span class=3DSpellE>bi_size</span>) return 1; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>We are supposed to do the <span
class=3DSpellE>dec_local</span> at the end of <span =
class=3DSpellE>drbd_endio_write</span>
<span class=3DGramE>sec(</span>). I am guessing that&#8217;s where the =
problem
is.<span style=3D'mso-spacerun:yes'>&nbsp; </span>But I do not know why =
<span
class=3DSpellE>bi_size</span> would be greater then 0. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>Is the fix simply to <span =
class=3DSpellE>dec_local</span>
while returning?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>BTW, the code <span =
class=3DGramE>below <span
style=3D'mso-spacerun:yes'>&nbsp;</span>inserts</span> the fault in =
question but
won&#8217;t necessarily make the hang =
happens:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D1 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:9.0pt;font-family:"Courier =
New";color:black'>#!/</span></font></span><font
size=3D1 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:9.0pt;font-family:
"Courier New";color:black'>bin/<span class=3DSpellE>sh</span><br>
<span class=3DGramE>echo</span> inserting fault....<br>
<span class=3DGramE>echo</span> 0x4 &gt;/sys/module/<span =
class=3DSpellE>drbd/parameters/enable_faults</span><br>
<span class=3DGramE>echo</span> 0x20 &gt;/sys/module/<span =
class=3DSpellE>drbd/parameters/fault_devs</span><br>
<span class=3DGramE>echo</span> 5 &gt; /sys/module/<span =
class=3DSpellE>drbd/parameters/fault_rate</span><br>
<span class=3DGramE>echo</span> starting <span =
class=3DSpellE>resync</span><br>
<span class=3DGramE>sleep</span> 5<br>
<span class=3DSpellE><span class=3DGramE>drbdadm</span></span> -c =
/etc/<span
class=3DSpellE>drbd.conf.avance</span> invalidate drbd5.vol<br>
<span class=3DGramE>echo</span> done....<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks,<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>EM--<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C877ED.5654AA86--
