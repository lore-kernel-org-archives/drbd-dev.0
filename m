Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C76800.AA2039B5"
Date: Fri, 16 Mar 2007 15:24:06 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C92B@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Resync speed reporting not accurate
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76800.AA2039B5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are seeing a problem where  resyncing multiple drbd volumes
say r0,r1,r2 reports the wrong sync speed stats.  It seems to get worst
and worst.  So r0 would report 30meg/S, r1 19Meg/sec and r2 9Meg/sec.
These rates are not the true rates except for the first one. In reality,
all the volumes took the same time to resync and they have the same
size.
=20
The problem I think is that while one volume is Syncing the next volume
in=20
PauseSyncX get some activity and ends up calling __drbd_set_in_sync()=20
from the asender thread.  When this happens rs_mark_time gets reset as
well
as rs_mark_left.  To illustrate this the change below would force the
problem
to go away.  I am not sure this is the correct patch though:
=20
Index: drbd/drbd_actlog.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drbd/drbd_actlog.c  (revision 11975)
+++ drbd/drbd_actlog.c  (working copy)
@@ -960,10 +960,12 @@
                // we need the lock for drbd_try_clear_on_disk_bm
                if(jiffies - mdev->rs_mark_time > HZ*10) {
                        /* should be roling marks, but we estimate only
anyways. */
-                      if( mdev->rs_mark_left !=3D
drbd_bm_total_weight(mdev)) {
-                              mdev->rs_mark_time =3Djiffies;
-                              mdev->rs_mark_left
=3Ddrbd_bm_total_weight(mdev);
-                      }
+                      if( (mdev->rs_mark_left !=3D
drbd_bm_total_weight(mdev)) &&
+            mdev->state.conn !=3D PausedSyncT &&
+            mdev->state.conn !=3D PausedSyncS ) {
+            mdev->rs_mark_time =3Djiffies;
+            mdev->rs_mark_left =3Ddrbd_bm_total_weight(mdev);
+        }
                }
                if( inc_local_if_state(mdev,Attaching) ) {
=20
drbd_try_clear_on_disk_bm(mdev,sector,count,TRUE);
=20
=20
=20

------_=_NextPart_001_01C76800.AA2039B5
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C767DF.22E96EC0">
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
font-family:Arial'>We are seeing a problem <span class=3DGramE>where =
<span
style=3D'mso-spacerun:yes'>&nbsp;</span><span =
class=3DSpellE>resyncing</span></span>
multiple <span class=3DSpellE>drbd</span> =
volumes<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>say</span></font></span><fon=
t
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> r0,r1,r2 reports
the wrong sync speed stats.<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>It
seems to get worst<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>and</span></font></span><fon=
t
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> worst.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>So r0 would report 30meg/S, r1 =
19Meg/sec
and r2 9Meg/sec.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>These rates are not the true rates except for the =
first one.
In reality,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>all</span></font></span><fon=
t
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> the volumes
took the same time to <span class=3DSpellE>resync</span> and they have =
the same
size.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The problem I think is that while one volume is =
Syncing the
next volume in <o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>PauseSyncX</span></font></sp=
an><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> get some
activity and ends up calling __<span class=3DSpellE>drbd_set_in_<span
class=3DGramE>sync</span></span><span class=3DGramE>()</span> =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>from</span></font></span><fo=
nt
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> the <span
class=3DSpellE>asender</span> thread.<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>When this happens <span class=3DSpellE>rs_mark_time</span> gets =
reset as
well<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>as</span></font></span><font=
 size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>rs_mark_left</span>. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>To illustrate <span =
class=3DGramE>this the</span>
change below would force the problem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>to</span></font></span><font=
 size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> go =
away.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>I am not sure this is the =
correct patch
though:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Index: <span =
class=3DSpellE>drbd/drbd_actlog.c</span><br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- <span class=3DSpellE>drbd/drbd_actlog.c</span><span =
class=3DGramE>&nbsp; (</span>revision
11975)<br>
+++ <span class=3DSpellE>drbd/drbd_actlog.c</span><span =
class=3DGramE>&nbsp; (</span>working
copy)<br>
@@ -960<span class=3DGramE>,10</span> +960,12 @@<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // we need the =
lock for
<span class=3DSpellE>drbd_try_clear_on_disk_bm</span><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span =
class=3DGramE>if(</span>jiffies
- <span class=3DSpellE>mdev</span>-&gt;<span =
class=3DSpellE>rs_mark_time</span>
&gt; HZ*10) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; /* should be <span class=3DSpellE>roling</span> marks, but we =
estimate
only anyways. */<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; <span
class=3DGramE>if(</span> <span class=3DSpellE>mdev</span>-&gt;<span =
class=3DSpellE>rs_mark_left</span>
!=3D <span class=3DSpellE>drbd_bm_total_weight</span>(<span =
class=3DSpellE>mdev</span>))
{<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; <span class=3DSpellE><span =
class=3DGramE>mdev</span></span>-&gt;<span
class=3DSpellE>rs_mark_time</span> =3Djiffies;<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; <span class=3DSpellE><span =
class=3DGramE>mdev</span></span>-&gt;<span
class=3DSpellE>rs_mark_left</span> =3D<span =
class=3DSpellE>drbd_bm_total_weight</span>(<span
class=3DSpellE>mdev</span>);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; }<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; <span
class=3DGramE>if(</span> (<span class=3DSpellE>mdev</span>-&gt;<span =
class=3DSpellE>rs_mark_left</span>
!=3D <span class=3DSpellE>drbd_bm_total_weight</span>(<span =
class=3DSpellE>mdev</span>))
&amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class=3DSpellE><span
class=3DGramE>mdev</span></span>-&gt;<span =
class=3DSpellE>state.conn</span> !=3D <span
class=3DSpellE>PausedSyncT</span> &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span =
class=3DSpellE>mdev</span>-&gt;<span
class=3DSpellE><span class=3DGramE>state.conn</span></span><span =
class=3DGramE> !</span>=3D
<span class=3DSpellE>PausedSyncS</span> ) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class=3DSpellE><span
class=3DGramE>mdev</span></span>-&gt;<span =
class=3DSpellE>rs_mark_time</span>
=3Djiffies;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class=3DSpellE><span
class=3DGramE>mdev</span></span>-&gt;<span =
class=3DSpellE>rs_mark_left</span> =3D<span
class=3DSpellE>drbd_bm_total_weight</span>(<span =
class=3DSpellE>mdev</span>);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span =
class=3DGramE>if(</span>
<span class=3DSpellE>inc_local_if_state</span>(<span =
class=3DSpellE>mdev,Attaching</span>)
) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; <span class=3DSpellE>drbd_try_clear_on_disk_<span =
class=3DGramE>bm</span></span><span
class=3DGramE>(</span><span =
class=3DSpellE>mdev,sector,count,TRUE</span>);<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C76800.AA2039B5--
