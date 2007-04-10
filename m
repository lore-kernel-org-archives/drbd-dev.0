Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C77BB6.29B914B1"
Date: Tue, 10 Apr 2007 17:21:11 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C968@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: incomplete resync with extent not found,
	inactive extent errors
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C77BB6.29B914B1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
I have been chasing this issue that we have been seeing a lot with not
much success and unfortunately I have a few other drbd issues needing
investigation.  Essentially, resyncing seems to have problem completing
because the activity log and resync cache cannot be cleared successfully
for a long time at the end of resync session.  Here are some logs:
=20
On one node =3D=3D=3D=3D=3D=3D:
Apr  4 02:24:29 ellwood kernel: drbd1: Began resync as PausedSyncT (will
sync 13336132 KB [3334033 bits set]).
Apr  4 02:24:29 ellwood kernel: drbd1: Writing meta data super block
now.
Apr  4 02:32:52 ellwood kernel: drbd1: aftr_isp( 1 -> 0 )
Apr  4 02:32:52 ellwood kernel: drbd1: conn( PausedSyncT -> SyncTarget )
peer_isp( 1 -> 0 )
Apr  4 02:32:52 ellwood kernel: drbd1: Syncer continues.
Apr  4 02:34:04 ellwood kernel: drbd1: al_complete_io() called on
inactive extent 1532713819
Apr  4 02:39:06 ellwood kernel: drbd1: drbd_rs_complete_io() called, but
extent not found
Apr  4 02:39:06 ellwood kernel: drbd1: al_complete_io() called on
inactive extent 1532713819
Apr  4 02:40:37 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:07 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:07 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:07 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:08 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:08 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:08 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:09 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:09 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:31 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:31 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1
Apr  4 02:41:31 ellwood kernel: drbd1: Retrying drbd_rs_del_all() later.
refcnt=3D1

On the other node=3D=3D=3D=3D
Apr  4 02:24:47 jake kernel: drbd1: Began resync as PausedSyncS (will
sync 13336132 KB [3334033 bits set]).
Apr  4 02:24:47 jake kernel: drbd1: Writing meta data super block now.
Apr  4 02:32:52 jake kernel: drbd1: peer_isp( 1 -> 0 )
Apr  4 02:32:52 jake kernel: drbd1: conn( PausedSyncS -> SyncSource )
aftr_isp( 1 -> 0 )
Apr  4 02:32:52 jake kernel: drbd1: Syncer continues.
Apr  4 02:40:37 jake kernel: drbd1: Resync done (total 971 sec; paused
506 sec; 28676 K/sec)
Apr  4 02:40:37 jake kernel: drbd1:  uuid[History_start] now
356284033FC4539B
Apr  4 02:40:37 jake kernel: drbd1:  uuid[Bitmap] now 0000000000000000
Apr  4 02:40:37 jake kernel: drbd1: conn( SyncSource -> Connected )
pdsk( Inconsistent -> UpToDate )
Apr  4 02:40:37 jake kernel: drbd1: Writing meta data super block now.
=20
EM--

------_=_NextPart_001_01C77BB6.29B914B1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C77B94.A28B8FA0">
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
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseWord2002TableStyleRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-alt:"?l?r ?????????????????????????";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:1627421319 -2147483648 8 0 66047 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
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
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have been chasing this issue that we have been =
seeing a
lot with not much success and unfortunately I have a few other <span
class=3DSpellE>drbd</span> issues needing investigation. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>Essentially, <span =
class=3DSpellE>resyncing</span>
seems to have problem completing because the activity log and <span
class=3DSpellE>resync</span> cache cannot be cleared successfully for a =
long time
at the end of <span class=3DSpellE>resync</span> session. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>Here are some =
logs:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>On one node =
=3D=3D=3D=3D=3D=3D:<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:24:29 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Began <span class=3DSpellE>resync</span> as <span =
class=3DSpellE>PausedSyncT</span>
(will sync 13336132 KB [3334033 bits set]).<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:24:29 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Writing meta data super block now.<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:32:52 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: <span class=3DSpellE>aftr_isp</span>( 1 -&gt; 0 )<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:32:52 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: <span class=3DSpellE>conn</span>( <span =
class=3DSpellE>PausedSyncT</span>
-&gt; <span class=3DSpellE>SyncTarget</span> ) <span =
class=3DSpellE>peer_isp</span>(
1 -&gt; 0 )<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:32:52 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: <span class=3DSpellE>Syncer</span> continues.<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:34:04 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: <span class=3DSpellE>al_complete_io</span>() called on =
inactive
extent 1532713819<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:39:06 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: <span class=3DSpellE>drbd_rs_complete_io</span>() called, =
but
extent not found<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:39:06 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: <span class=3DSpellE>al_complete_io</span>() called on =
inactive
extent 1532713819<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:40:37 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:07 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:07 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:07 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:08 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:08 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:08 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:09 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:09 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:31 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:31 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:41:31 <span =
class=3DSpellE>ellwood</span>
kernel: drbd1: Retrying <span class=3DSpellE>drbd_rs_del_all</span>() =
later. <span
class=3DSpellE><span class=3DGramE>refcnt</span></span><span =
class=3DGramE>=3D</span>1<br>
<br>
On the other node=3D=3D=3D=3D<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:24:47 <span =
class=3DSpellE>jake</span>
kernel: drbd1: Began <span class=3DSpellE>resync</span> as <span =
class=3DSpellE>PausedSyncS</span>
(will sync 13336132 KB [3334033 bits set]).<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:24:47 <span =
class=3DSpellE>jake</span>
kernel: drbd1: Writing meta data super block now.<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:32:52 <span =
class=3DSpellE>jake</span>
kernel: drbd1: <span class=3DSpellE>peer_isp</span>( 1 -&gt; 0 )<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:32:52 <span =
class=3DSpellE>jake</span>
kernel: drbd1: <span class=3DSpellE>conn</span>( <span =
class=3DSpellE>PausedSyncS</span>
-&gt; <span class=3DSpellE>SyncSource</span> ) <span =
class=3DSpellE>aftr_isp</span>(
1 -&gt; 0 )<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:32:52 <span =
class=3DSpellE>jake</span>
kernel: drbd1: <span class=3DSpellE>Syncer</span> continues.<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:40:37 <span =
class=3DSpellE>jake</span>
kernel: drbd1: <span class=3DSpellE>Resync</span> done (total 971 sec; =
paused 506
sec; 28676 K/sec)<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:40:37 <span =
class=3DSpellE>jake</span>
kernel: drbd1:&nbsp; <span class=3DSpellE>uuid</span>[<span =
class=3DSpellE>History_start</span>]
now 356284033FC4539B<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:40:37 <span =
class=3DSpellE>jake</span>
kernel: drbd1:&nbsp; <span class=3DSpellE>uuid</span>[Bitmap] now
0000000000000000<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:40:37 <span =
class=3DSpellE>jake</span>
kernel: drbd1: <span class=3DSpellE>conn</span>( <span =
class=3DSpellE>SyncSource</span>
-&gt; Connected ) <span class=3DSpellE>pdsk</span>( Inconsistent -&gt; =
<span
class=3DSpellE>UpToDate</span> )<br>
Apr<span class=3DGramE>&nbsp; 4</span> 02:40:37 <span =
class=3DSpellE>jake</span>
kernel: drbd1: Writing meta data super block =
now.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>EM--</span></font><font size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_001_01C77BB6.29B914B1--
