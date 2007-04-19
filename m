Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C782CE.8D78D24C"
Date: Thu, 19 Apr 2007 18:03:25 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C983@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Sync hangs due to using freed ee
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C782CE.8D78D24C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,=20
This my second time actually reporting on this problem.  The first time
I did not
Have much info other then the logs but this time I think I understand a
bit more a bout the problem. =20
So here it is.
=20
Problem:
We are syncing and we are the sync target.
We submit a write io request and when it is done bio_endio calls
drbd_endio_write_sec()
When we access the sector field for the ee/bio in this routine it is
poisoned because we have
slab debugging turned on. The poison is 6d6d6d6d...This indicates that
we are freeing the ee
and then proceed to use it.
The symtom is that we get:
Apr 12 02:36:22  kernel: drbd1: drbd_rs_complete_io() called, but extent
not found
Apr 12 02:36:22  kernel: drbd1: al_complete_io() called on inactive
extent 1532713819

and we loop forever with:
Apr 12 02:43:19 ellwood kernel: drbd2: Retrying drbd_rs_del_all() later.
refcnt=3D1

Well a look at the code yields:
we add to the done_ee list in:
./src/drbd/drbd_receiver.c:    list_add_tail(&e->w.list,&mdev->done_ee);
./src/drbd/drbd_worker.c  :    list_add_tail(&e->w.list,&mdev->done_ee);

In ./src/drbd/drbd_receiver.c:receive_data() we add to the list and wake
up the asender and return.  We do
not attempt to use any ot the ee's after. So all maybe fine there.

However, in the ./src/drbd/drbd_worker.c:drbd_endio_write_sec() we add
to the list and then we call
drbd_rs_complete_io(mdev,e->sector)  and
drbd_al_complete_io(mdev,e->sector) Using the ee after it was placed on
the done list so it could
potentially be freed.  I suspect it is being freed in process_done_ee()
where drbd_free_ee is
called.

Instrumentation shows that the bio and ee are intact at the beginning of
drbd_endio_write_sec()
as shown in the log below:

Apr 19 17:28:12 godzilla kernel: drbd1: drbd_endio_write_sec: EM-- XX
BUG!! e->sector=3D7740398493674204011s cap_sector=3D10267584s
size=3D1802201963 bytes_done=3D32768  =
bio->bi_sector=3D774039849367420400

Apr 19 17:28:12 godzilla kernel:  [<c0105a67>] dump_stack+0x17/0x20
Apr 19 17:28:12 godzilla kernel:  [<ee2d0caf>]
drbd_endio_write_sec+0x16f/0x3a0 [drbd]
Apr 19 17:28:12 godzilla kernel:  [<c0177319>] bio_endio+0x59/0x90
Apr 19 17:28:12 godzilla kernel:  [<ee0ab2b9>] dec_pending+0x39/0x70
[dm_mod]
Apr 19 17:28:12 godzilla kernel:  [<ee0ab391>] clone_endio+0xa1/0xc0
[dm_mod]
Apr 19 17:28:12 godzilla kernel:  [<c0177319>] bio_endio+0x59/0x90
Apr 19 17:28:12 godzilla kernel:  [<c022638a>]
__end_that_request_first+0xba/0x330
Apr 19 17:28:12 godzilla kernel:  [<c0226618>]
end_that_request_chunk+0x8/0x10
Apr 19 17:28:12 godzilla kernel:  [<ee0209f5>]
scsi_end_request+0x25/0xe0 [scsi_mod]
Apr 19 17:28:12 godzilla kernel:  [<ee020c82>]
scsi_io_completion+0xd2/0x3c0 [scsi_mod]
Apr 19 17:28:12 godzilla kernel:  [<ee06a02a>] sd_rw_intr+0x14a/0x2c0
[sd_mod]
Notice the poisoned e->sector captured just before we call
drbd_rs_complete_io with it.
More importantly, notice the value of cap_sector which is what came out
of the kernel when
bio_endio called our callback.

What is the best way to fix this? Is it a matter of just moving
list_add_tail(&e->w.list,&mdev->done_ee);
to after we use e->sector?
=20
Thanks,
=20
EM--

------_=_NextPart_001_01C782CE.8D78D24C
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C782AD.065B0550">
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
font-family:Arial'>Hi all, <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This my second time actually reporting on this =
problem. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>The first time I did =
not<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Have much info other then the logs but this time I =
think I understand
a bit more a bout the problem.<span style=3D'mso-spacerun:yes'>&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>So here it is.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Problem:<br>
We are syncing and we are the sync target.<br>
We submit a write <span class=3DSpellE>io</span> request and when it is =
done <span
class=3DSpellE>bio_endio</span> calls <span =
class=3DSpellE>drbd_endio_write_<span
class=3DGramE>sec</span></span><span class=3DGramE>(</span>)<br>
When we access the sector field for the <span =
class=3DSpellE>ee</span>/bio in
this routine it is poisoned because we have<br>
<span class=3DGramE>slab</span> debugging turned on. The poison is
6d6d6d6d...This indicates that we are freeing the <span =
class=3DSpellE>ee</span><br>
<span class=3DGramE>and</span> then proceed to use it.<br>
The <span class=3DSpellE>symtom</span> is that we get:<br>
Apr 12 02:36:22<span class=3DGramE>&nbsp; kernel</span>: drbd1: <span
class=3DSpellE>drbd_rs_complete_io</span>() called, but extent not =
found<br>
Apr 12 02:36:22<span class=3DGramE>&nbsp; kernel</span>: drbd1: <span
class=3DSpellE>al_complete_io</span>() called on inactive extent =
1532713819<br>
<br>
<span class=3DGramE>and</span> we loop forever with:<br>
Apr 12 02:43:19 <span class=3DSpellE>ellwood</span> kernel: drbd2: =
Retrying <span
class=3DSpellE>drbd_rs_del_<span class=3DGramE>all</span></span><span =
class=3DGramE>(</span>)
later. <span class=3DSpellE><span =
class=3DGramE>refcnt</span></span><span
class=3DGramE>=3D</span>1<br>
<br>
Well a look at the code yields:<br>
<span class=3DGramE>we</span> add to the <span =
class=3DSpellE>done_ee</span> list
in:<br>
./<span class=3DSpellE>src/drbd/drbd_receiver.c</span>:&nbsp; &nbsp; =
<span
class=3DSpellE>list_add_<span class=3DGramE>tail</span></span><span =
class=3DGramE>(</span>&amp;e-&gt;<span
class=3DSpellE>w.list,&amp;mdev</span>-&gt;<span =
class=3DSpellE>done_ee</span>);<br>
./<span class=3DSpellE>src/drbd/drbd_<span =
class=3DGramE>worker.c</span></span><span
class=3DGramE>&nbsp; :</span>&nbsp; &nbsp; <span =
class=3DSpellE>list_add_tail</span>(&amp;e-&gt;<span
class=3DSpellE>w.list,&amp;mdev</span>-&gt;<span =
class=3DSpellE>done_ee</span>);<br>
<br>
In ./<span class=3DSpellE>src/drbd/drbd_receiver.c:receive_<span =
class=3DGramE>data</span></span><span
class=3DGramE>(</span>) we add to the list and wake up the <span =
class=3DSpellE>asender</span>
and return.&nbsp; We do<br>
<span class=3DGramE>not</span> attempt to use any <span =
class=3DSpellE>ot</span>
the <span class=3DSpellE>ee's</span> after. <span class=3DGramE>So all =
maybe fine
there.</span><br>
<br>
However, in the ./<span =
class=3DSpellE>src/drbd/drbd_worker.c:drbd_endio_write_<span
class=3DGramE>sec</span></span><span class=3DGramE>(</span>) we add to =
the list and
then we call<br>
<span class=3DSpellE>drbd_rs_complete_<span =
class=3DGramE>io</span></span><span
class=3DGramE>(</span><span =
class=3DSpellE>mdev,e</span>-&gt;sector)&nbsp; and<br>
<span class=3DSpellE>drbd_al_complete_<span =
class=3DGramE>io</span></span><span
class=3DGramE>(</span><span class=3DSpellE>mdev,e</span>-&gt;sector) =
Using the <span
class=3DSpellE>ee</span> after it was placed on the done list so it =
could<br>
<span class=3DGramE>potentially</span> be freed.&nbsp; I suspect it is =
being
freed in <span class=3DSpellE>process_done_<span =
class=3DGramE>ee</span></span><span
class=3DGramE>(</span>) where <span class=3DSpellE>drbd_free_ee</span> =
is<br>
<span class=3DGramE>called</span>.<br>
<br>
Instrumentation shows that the bio and <span class=3DSpellE>ee</span> =
are intact
at the beginning of <span class=3DSpellE>drbd_endio_write_<span =
class=3DGramE>sec</span></span><span
class=3DGramE>(</span>)<br>
<span class=3DGramE>as</span> shown in the log below:<br>
<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel: drbd1: =
<span
class=3DSpellE>drbd_endio_write_sec</span>: EM-- XX BUG!! <span =
class=3DGramE>e</span>-&gt;sector=3D7740398493674204011s
<span class=3DSpellE>cap_sector</span>=3D10267584s size=3D1802201963 =
<span
class=3DSpellE>bytes_done</span>=3D32768&nbsp; bio-&gt;<span =
class=3DSpellE>bi_sector</span>=3D774039849367420400<br>
<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;c0105a67&gt;] dump_stack+0x17/0x20<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;ee2d0caf&gt;] drbd_endio_write_sec+0x16f/0x3a0 [<span =
class=3DSpellE>drbd</span>]<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;c0177319&gt;] bio_endio+0x59/0x90<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;ee0ab2b9&gt;] dec_pending+0x39/0x70 [<span =
class=3DSpellE>dm_mod</span>]<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;ee0ab391&gt;] clone_endio+0xa1/0xc0 [<span =
class=3DSpellE>dm_mod</span>]<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;c0177319&gt;] bio_endio+0x59/0x90<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;c022638a&gt;] __end_that_request_first+0xba/0x330<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;c0226618&gt;] end_that_request_chunk+0x8/0x10<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;ee0209f5&gt;] scsi_end_request+0x25/0xe0 [<span =
class=3DSpellE>scsi_mod</span>]<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp;
[&lt;ee020c82&gt;] scsi_io_completion+0xd2/0x3c0 [<span =
class=3DSpellE>scsi_mod</span>]<br>
Apr 19 17:28:12 <span class=3DSpellE>godzilla</span> kernel:&nbsp; =
[&lt;ee06a02a&gt;]
sd_rw_intr+0x14a/0x2c0 [<span class=3DSpellE>sd_mod</span>]<br>
Notice the poisoned e-&gt;sector captured just before we call <span
class=3DSpellE>drbd_rs_complete_io</span> with it.<br>
More importantly, notice the value of <span =
class=3DSpellE>cap_sector</span>
which is what came out of the kernel when<br>
<span class=3DSpellE><span class=3DGramE>bio_endio</span></span> called =
our
callback.<br>
<br>
What is the best way to fix this? Is it a matter of just moving <span
class=3DSpellE>list_add_<span class=3DGramE>tail</span></span><span =
class=3DGramE>(</span>&amp;e-&gt;<span
class=3DSpellE>w.list,&amp;mdev</span>-&gt;<span =
class=3DSpellE>done_ee</span>);<br>
<span class=3DGramE>to</span> after we use =
e-&gt;sector?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Thanks,<o:p></o:p></span></font></p=
>

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

------_=_NextPart_001_01C782CE.8D78D24C--
