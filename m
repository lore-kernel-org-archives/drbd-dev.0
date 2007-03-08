Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C761D0.259703EC"
Date: Thu, 8 Mar 2007 17:21:41 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C91C@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Split-brain if primary and syncTarget
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C761D0.259703EC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
We are seeing an issue with split brain if one node is syncing as
syncTarget while being Primary.
two node A and B.
* make B primary and the syncTarget
* Start a sync.
* ifdown eth1 to break communication
* ifup eth1.
* then on the node in standalone "drbdadm connect"
We get a split-brain.
=20
I think the  problem is that if we are primary and we lose contact from
the other side
we generate a new current UUID which causes a Split-Brain next time we
connect.
This only happens if we are the sync target and we are primary. Perhaps
we=20
should not generate a UUID if we were syncing when the disconnect
happen.
Below is a possible patch for this in after_state_ch():

Index: drbd/drbd_main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drbd/drbd_main.c    (revision 11592)
+++ drbd/drbd_main.c    (working copy)
@@ -901,7 +901,8 @@
                        mdev->p_uuid =3D NULL;
                }
                if (inc_local(mdev)) {
-                      if (ns.role =3D=3D Primary &&
mdev->bc->md.uuid[Bitmap] =3D=3D 0 ) {
+                      if (ns.role =3D=3D Primary &&
mdev->bc->md.uuid[Bitmap] =3D=3D 0 &&
+            os.conn < SyncSource ) {
                                /* Only do it if we have not yet done
it... */
                                drbd_uuid_new_current(mdev);
                        }
=20
=20

------_=_NextPart_001_01C761D0.259703EC
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C761A6.3C99B440">
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
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We are seeing an issue with split brain if one node =
is
syncing as <span class=3DSpellE>syncTarget</span> while being =
Primary.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D3 color=3Dblack
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;color:black'>two</span></font></span><font
color=3Dblack><span style=3D'color:black'> node A and B.<br>
* make B primary and the <span class=3DSpellE>syncTarget</span><br>
* Start <span class=3DGramE>a sync</span>.<br>
* <span class=3DSpellE><span class=3DGramE>ifdown</span></span> eth1 to =
break
communication<br>
* <span class=3DSpellE><span class=3DGramE>ifup</span></span> eth1.<br>
* <span class=3DGramE>then</span> on the node in standalone &quot;<span
class=3DSpellE>drbdadm</span> connect&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'>We get a =
split-brain.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'>I think <span class=3DGramE>the =
<span
style=3D'mso-spacerun:yes'>&nbsp;</span>problem</span> is that if we are =
primary
and we lose contact from the other side<br>
<span class=3DGramE>we</span> generate a new current UUID which causes a
Split-Brain next time we connect.<br>
This only happens if we are the sync target and we are primary. Perhaps =
<span
class=3DGramE>we <br>
should</span> not generate a UUID if we were syncing when the disconnect
happen.<br>
Below is a possible patch for this in <span =
class=3DSpellE>after_state_<span
class=3DGramE>ch</span></span><span =
class=3DGramE>(</span>):<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><br>
Index: <span class=3DSpellE>drbd/drbd_main.c</span><br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- <span class=3DSpellE><span =
class=3DGramE>drbd/drbd_main.c</span></span>&nbsp;
&nbsp; (revision 11592)<br>
+++ <span class=3DSpellE><span =
class=3DGramE>drbd/drbd_main.c</span></span>&nbsp;
&nbsp; (working copy)<br>
@@ -901<span class=3DGramE>,7</span> +901,8 @@<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; <span class=3DSpellE><span =
class=3DGramE>mdev</span></span>-&gt;<span
class=3DSpellE>p_uuid</span> =3D NULL;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span =
class=3DGramE>if</span>
(<span class=3DSpellE>inc_local</span>(<span =
class=3DSpellE>mdev</span>)) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; <span
class=3DGramE>if</span> (<span class=3DSpellE>ns.role</span> =3D=3D =
Primary &amp;&amp; <span
class=3DSpellE>mdev</span>-&gt;<span class=3DSpellE>bc</span>-&gt;<span
class=3DSpellE>md.uuid</span>[Bitmap] =3D=3D 0 ) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; <span
class=3DGramE>if</span> (<span class=3DSpellE>ns.role</span> =3D=3D =
Primary &amp;&amp; <span
class=3DSpellE>mdev</span>-&gt;<span class=3DSpellE>bc</span>-&gt;<span
class=3DSpellE>md.uuid</span>[Bitmap] =3D=3D 0 &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span =
class=3DSpellE>os.conn</span>
&lt; <span class=3DSpellE><span =
class=3DGramE>SyncSource</span></span><span
class=3DGramE> )</span> {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* <span class=3DGramE>Only</span> do =
it if we
have not yet done it... */<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span =
class=3DSpellE>drbd_uuid_new_<span
class=3DGramE>current</span></span><span class=3DGramE>(</span><span =
class=3DSpellE>mdev</span>);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C761D0.259703EC--
