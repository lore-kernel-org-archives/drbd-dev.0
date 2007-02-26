Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C759ED.563259A3"
Date: Mon, 26 Feb 2007 16:30:29 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C909@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Resync of device PauseSync state does not resume
	after an I/O error.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C759ED.563259A3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
Looks like what's going on is that on an I/O error during resync (on the
sync source), the io error handler set the new state to=20
"Connected" and after_state_ch() is not called but scheduled it seems.
Next time after_state_ch()
is called the conn state is "Connected" for both old and new and the
disk state is Diskless.
We do not cal resume_next_sg() for this combination of state.  Could it
be as simple as this patch?

Index: drbd/drbd_main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drbd/drbd_main.c    (revision 10812)
+++ drbd/drbd_main.c    (working copy)
@@ -1009,7 +1009,8 @@
        // A resync finished or aborted, wake paused devices...
        if ( (os.conn > Connected && ns.conn <=3D Connected) ||
            (os.peer_isp && !ns.peer_isp) ||
-            (os.user_isp && !ns.user_isp) ) {
+            (os.user_isp && !ns.user_isp) ||
+        (ns.conn <=3D Connected && ns.disk =3D=3D Diskless)) {
                resume_next_sg(mdev);
        }

------_=_NextPart_001_01C759ED.563259A3
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C759C3.6D4BAFC0">
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

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Hi =
all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Looks like what's going on is that =
on an
I/O error during <span class=3DSpellE>resync</span> (on the sync =
source), the <span
class=3DSpellE>io</span> error handler set the new state <span =
class=3DGramE>to <br>
&quot;</span>Connected&quot; and <span =
class=3DSpellE>after_state_ch</span>() is
not called but scheduled it seems. Next time <span =
class=3DSpellE>after_state_<span
class=3DGramE>ch</span></span><span class=3DGramE>(</span>)<br>
<span class=3DGramE>is</span> called the <span =
class=3DSpellE>conn</span> state is
&quot;Connected&quot; for both old and new and the disk state is =
Diskless.<br>
We do not cal <span class=3DSpellE>resume_next_<span =
class=3DGramE>sg</span></span><span
class=3DGramE>(</span>) for this combination of state.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Could it be as simple as this =
patch?<br>
<br>
Index: <span class=3DSpellE>drbd/drbd_main.c</span><br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- <span class=3DSpellE><span =
class=3DGramE>drbd/drbd_main.c</span></span>&nbsp;
&nbsp; (revision 10812)<br>
+++ <span class=3DSpellE><span =
class=3DGramE>drbd/drbd_main.c</span></span>&nbsp;
&nbsp; (working copy)<br>
@@ -1009<span class=3DGramE>,7</span> +1009,8 @@<br>
&nbsp; &nbsp; &nbsp; &nbsp; // A <span class=3DSpellE>resync</span> =
finished or
aborted, wake paused devices...<br>
&nbsp; &nbsp; &nbsp; &nbsp; <span class=3DGramE>if</span> ( (<span =
class=3DSpellE>os.conn</span>
&gt; Connected &amp;&amp; <span class=3DSpellE>ns.conn</span> &lt;=3D =
Connected) ||<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (<span =
class=3DSpellE>os.peer_isp</span>
&amp;<span class=3DGramE>&amp; !</span><span =
class=3DSpellE>ns.peer_isp</span>) ||<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (<span =
class=3DSpellE>os.user_isp</span>
&amp;<span class=3DGramE>&amp; !</span><span =
class=3DSpellE>ns.user_isp</span>) ) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (<span =
class=3DSpellE>os.user_isp</span>
&amp;<span class=3DGramE>&amp; !</span><span =
class=3DSpellE>ns.user_isp</span>) ||<br>
+&nbsp; &nbsp; &nbsp; &nbsp; (<span class=3DSpellE>ns.conn</span> =
&lt;=3D Connected
&amp;&amp; <span class=3DSpellE>ns.disk</span> =3D=3D Diskless)) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span =
class=3DSpellE>resume_next_<span
class=3DGramE>sg</span></span><span class=3DGramE>(</span><span =
class=3DSpellE>mdev</span>);<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C759ED.563259A3--
