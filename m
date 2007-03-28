Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C77186.B416E5AE"
Date: Wed, 28 Mar 2007 18:16:16 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C943@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: unexpected cstate (PausedSyncT) in receive_bitmap
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C77186.B416E5AE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are seeing a problem where during syncing the peer_isp bit ends up
getting set when it should not.
I cannot duplicate it but the log clearly shows why the problem
occurred.  Essentially, we never transitionsed
from PausedSyncS -> SyncSource as the volume resumed from a suspended
state.  But yet on the sync source we show
a completion of the sync.  The failure message then occurred on the sync
target.  Below is an *illustrated* version of the
log.  I hope I don't confuse things more:
=20
-------------------------SyncSource
side--------------------------------------------------------------------
-------
Mar 16 08:33:16 chobs kernel: drbd1: aftr_isp( 1 -> 0 )
Mar 16 08:33:16 chobs kernel: drbd1: conn( PausedSyncS -> SyncSource )
peer_isp( 1 -> 0 )
Mar 16 08:33:16 chobs kernel: drbd1: Syncer continues.
Mar 16 08:33:16 chobs kernel: drbd1: conn( SyncSource -> PausedSyncS )
aftr_isp( 0 -> 1 )
Mar 16 08:33:16 chobs kernel: drbd1: Resync suspended
Mar 16 08:33:16 chobs kernel: drbd1: peer_isp( 0 -> 1 )
Mar 16 08:33:16 chobs kernel: drbd1: aftr_isp( 1 -> 0 ) <<<<#####Should
have been peer_isp I think ######
##############Under normal operation the two lines would be seen But
they are NOT#################=20
#drbd1: conn( PausedSyncS -> SyncSource ) aftr_isp( 1 -> 0 )
#drbd1: Syncer continues.
############################### instead continue below ############
Mar 16 08:33:16 chobs kernel: drbd1: Resync done (total 1 sec; paused 0
sec; 356 K/sec) #### Are we really done here???
Mar 16 08:33:16 chobs kernel: drbd1:  uuid[History_start] now
FC98CEA3D33591C1
Mar 16 08:33:16 chobs kernel: drbd1:  uuid[Bitmap] now 0000000000000000
Mar 16 08:33:16 chobs kernel: drbd1: conn( PausedSyncS -> Connected )
pdsk( Inconsistent -> UpToDate ) ####!WE ARE GOING TO Conneceted from
PausedSyncS..So Same state!!!
#######!!!!!!! ABOVE state should have been conn( SyncSource ->
Connected ) pdsk( Inconsistent -> UpToDate )!!!!!
Mar 16 08:33:16 chobs kernel: drbd1: Writing meta data super block now.
Mar 16 08:33:16 chobs kernel: drbd1: drbd_sync_handshake:
Mar 16 08:33:16 chobs kernel: drbd1: self
269C54A410CF9CAB:0000000000000000:FC98CEA3D33591C1:2EFBE8CDF29C591F
Mar 16 08:33:16 chobs kernel: drbd1: peer
FC98CEA3D33591C0:0000000000000000:2EFBE8CDF29C591E:40519581F499C446
Mar 16 08:33:16 chobs kernel: drbd1: uuid_compare()=3D2 by rule 8

------------------------------Sync Target
side--------------------------------------------------
Mar 16 08:33:17 chobp kernel: drbd1: peer_isp( 1 -> 0 )
Mar 16 08:33:17 chobp kernel: drbd1: conn( PausedSyncT -> SyncTarget )
aftr_isp( 1 -> 0 )
Mar 16 08:33:17 chobp kernel: drbd1: Syncer continues.
Mar 16 08:33:17 chobp kernel: drbd1: conn( SyncTarget -> PausedSyncT )
aftr_isp( 0 -> 1 )  ### should have been peer_isp I think!!!
Mar 16 08:33:17 chobp kernel: drbd1: Resync suspended
Mar 16 08:33:17 chobp kernel: drbd1: peer_isp( 0 -> 1 ) <<<#### should
have been aftr_isp ########
Mar 16 08:33:17 chobp kernel: drbd1: peer_isp( 1 -> 0 ) <<<#### should
have been aftr_isp ########
#######The 3 lines below would be printed BUT DID NOT##############
#drbd1: conn( PausedSyncT -> SyncTarget ) peer_isp( 1 -> 0 )
#drbd1: Syncer continues.
#drbd1: Resync done (total 1 sec; paused 0 sec; 356 K/sec)
#################Instead got##############
Mar 16 08:33:17 chobp kernel: drbd1: unexpected cstate (PausedSyncT) in
receive_bitmap
=20

------_=_NextPart_001_01C77186.B416E5AE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C77165.2CB985E0">
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
font-family:Arial'>We are seeing a problem where during syncing the =
<span
class=3DSpellE>peer_isp</span> bit ends up getting set when it should =
not.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I cannot duplicate it but the log clearly shows why =
the
problem occurred. <span =
style=3D'mso-spacerun:yes'>&nbsp;</span>Essentially, we
never <span =
class=3DSpellE>transitionsed</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>from</span></font></span><fo=
nt
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> </span></font><span
class=3DSpellE><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;
font-family:Tahoma;color:black'>PausedSyncS</span></font></span><font =
size=3D1
color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'> -&gt; <span class=3DSpellE>SyncSource</span> as the volume =
resumed
from a suspended state. <span =
style=3D'mso-spacerun:yes'>&nbsp;</span>But yet on
the sync source we show<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D1 color=3Dblack =
face=3DTahoma><span
style=3D'font-size:9.0pt;font-family:Tahoma;color:black'>a</span></font><=
/span><font
size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'> completion of the sync. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>The failure message then =
occurred on the
sync target. <span style=3D'mso-spacerun:yes'>&nbsp;</span>Below is an =
*<b><span
style=3D'font-weight:bold'>illustrated</span></b>* version of =
the<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D1 color=3Dblack =
face=3DTahoma><span
style=3D'font-size:9.0pt;font-family:Tahoma;color:black'>log</span></font=
></span><font
size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'>.<span style=3D'mso-spacerun:yes'>&nbsp; </span>I hope I =
don&#8217;t
confuse things more:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>-------------------------<span
class=3DSpellE>SyncSource</span>
side---------------------------------------------------------------------=
------<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Mar 16 08:33:16 <span =
class=3DSpellE>chobs</span>
kernel: drbd1: <span class=3DSpellE>aftr_<span =
class=3DGramE>isp</span></span><span
class=3DGramE>(</span> 1 -&gt; 0 )<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE><span class=3DGramE>conn</span></span><span =
class=3DGramE>(</span> <span
class=3DSpellE>PausedSyncS</span> -&gt; <span =
class=3DSpellE>SyncSource</span> ) <span
class=3DSpellE>peer_isp</span>( 1 -&gt; 0 )<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE>Syncer</span> continues.<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE><span class=3DGramE>conn</span></span><span =
class=3DGramE>(</span> <span
class=3DSpellE>SyncSource</span> -&gt; <span =
class=3DSpellE>PausedSyncS</span> ) <span
class=3DSpellE>aftr_isp</span>( 0 -&gt; 1 )<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE>Resync</span> suspended<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE>peer_<span class=3DGramE>isp</span></span><span =
class=3DGramE>(</span>
0 -&gt; 1 )<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE>aftr_<span class=3DGramE>isp</span></span><span =
class=3DGramE>(</span>
1 -&gt; 0 ) &lt;&lt;&lt;&lt;#####Should have been <span =
class=3DSpellE>peer_isp</span>
I think ######<br>
##############Under normal operation the two lines would be seen But =
they are
NOT################<span class=3DGramE># <br>
#</span>drbd1: <span class=3DSpellE>conn</span>( <span =
class=3DSpellE>PausedSyncS</span>
-&gt; <span class=3DSpellE>SyncSource</span> ) <span =
class=3DSpellE>aftr_isp</span>(
1 -&gt; 0 )<br>
#drbd1: <span class=3DSpellE>Syncer</span> continues.<br>
############################### <span class=3DGramE>instead</span> =
continue below
############<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE>Resync</span> done (total 1 sec; paused 0 sec; 356 K/sec) =
#### Are
we really done here???<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1:&nbsp; =
<span
class=3DSpellE><span class=3DGramE>uuid</span></span><span =
class=3DGramE>[</span><span
class=3DSpellE>History_start</span>] now FC98CEA3D33591C1<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1:&nbsp; =
<span
class=3DSpellE><span class=3DGramE>uuid</span></span><span =
class=3DGramE>[</span>Bitmap]
now 0000000000000000<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE><span class=3DGramE>conn</span></span><span =
class=3DGramE>(</span> <span
class=3DSpellE>PausedSyncS</span> -&gt; Connected ) <span =
class=3DSpellE>pdsk</span>(
Inconsistent -&gt; <span class=3DSpellE>UpToDate</span> ) ####!WE ARE =
GOING TO <span
class=3DSpellE>Conneceted</span> from <span =
class=3DSpellE>PausedSyncS..So</span>
Same state!!!<br>
#######!!!!!!! ABOVE state should have been <span class=3DSpellE><span
class=3DGramE>conn</span></span><span class=3DGramE>(</span> <span =
class=3DSpellE>SyncSource</span>
-&gt; Connected ) <span class=3DSpellE>pdsk</span>( Inconsistent -&gt; =
<span
class=3DSpellE>UpToDate</span> )!!!!!<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: Writing =
<span
class=3DGramE>meta</span> data super block now.<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE>drbd_sync_handshake</span>:<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: self
269C54A410CF9CAB:0000000000000000:FC98CEA3D33591C1:2EFBE8CDF29C591F<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: peer
FC98CEA3D33591C0:0000000000000000:2EFBE8CDF29C591E:40519581F499C446<br>
Mar 16 08:33:16 <span class=3DSpellE>chobs</span> kernel: drbd1: <span
class=3DSpellE>uuid_<span class=3DGramE>compare</span></span><span =
class=3DGramE>(</span>)=3D2
by rule 8<br>
<br>
------------------------------Sync Target =
side--------------------------------------------------<br>
Mar 16 08:33:17 <span class=3DSpellE>chobp</span> kernel: drbd1: <span
class=3DSpellE>peer_<span class=3DGramE>isp</span></span><span =
class=3DGramE>(</span>
1 -&gt; 0 )<br>
Mar 16 08:33:17 <span class=3DSpellE>chobp</span> kernel: drbd1: <span
class=3DSpellE><span class=3DGramE>conn</span></span><span =
class=3DGramE>(</span> <span
class=3DSpellE>PausedSyncT</span> -&gt; <span =
class=3DSpellE>SyncTarget</span> ) <span
class=3DSpellE>aftr_isp</span>( 1 -&gt; 0 )<br>
Mar 16 08:33:17 <span class=3DSpellE>chobp</span> kernel: drbd1: <span
class=3DSpellE>Syncer</span> continues.<br>
Mar 16 08:33:17 <span class=3DSpellE>chobp</span> kernel: drbd1: <span
class=3DSpellE><span class=3DGramE>conn</span></span><span =
class=3DGramE>(</span> <span
class=3DSpellE>SyncTarget</span> -&gt; <span =
class=3DSpellE>PausedSyncT</span> ) <span
class=3DSpellE>aftr_isp</span>( 0 -&gt; 1 )&nbsp; ### should have been =
<span
class=3DSpellE>peer_isp</span> I think!!!<br>
Mar 16 08:33:17 <span class=3DSpellE>chobp</span> kernel: drbd1: <span
class=3DSpellE>Resync</span> suspended<br>
Mar 16 08:33:17 <span class=3DSpellE>chobp</span> kernel: drbd1: <span
class=3DSpellE>peer_<span class=3DGramE>isp</span></span><span =
class=3DGramE>(</span>
0 -&gt; 1 ) &lt;&lt;&lt;#### should have been <span =
class=3DSpellE>aftr_isp</span>
########<br>
Mar 16 08:33:17 <span class=3DSpellE>chobp</span> kernel: drbd1: <span
class=3DSpellE>peer_<span class=3DGramE>isp</span></span><span =
class=3DGramE>(</span>
1 -&gt; 0 ) &lt;&lt;&lt;#### should have been <span =
class=3DSpellE>aftr_isp</span>
########<br>
#######The 3 lines below would be printed BUT DID NOT##############<br>
#drbd1: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>PausedSyncT</span> -&gt; =
<span
class=3DSpellE>SyncTarget</span> ) <span class=3DSpellE>peer_isp</span>( =
1 -&gt; 0
)<br>
#drbd1: <span class=3DSpellE>Syncer</span> continues.<br>
#drbd1: <span class=3DSpellE>Resync</span> done (total 1 sec; paused 0 =
sec; 356
K/sec)<br>
#################Instead got##############<br>
Mar 16 08:33:17 <span class=3DSpellE>chobp</span> kernel: drbd1: =
unexpected <span
class=3DSpellE>cstate</span> (<span class=3DSpellE>PausedSyncT</span>) =
in <span
class=3DSpellE>receive_bitmap</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C77186.B416E5AE--
