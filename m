Return-Path: <nwang@suse.com>
Received: from relay2.provo.novell.com (relay2.provo.novell.com
	[137.65.250.214])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6F28510003FC
	for <drbd-dev@lists.linbit.com>; Mon, 19 Oct 2015 02:00:24 +0200 (CEST)
Message-Id: <5624CD4302000070000537A6@relay2.provo.novell.com>
Date: Sun, 18 Oct 2015 18:00:19 -0600
From: "Nick Wang" <nwang@suse.com>
To: <lars.ellenberg@linbit.com>,<drbd-dev@lists.linbit.com>
References: <1444983195-12439-1-git-send-email-nwang@suse.com>
	<20151016113152.GS32439@soda.linbit>
In-Reply-To: <20151016113152.GS32439@soda.linbit>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartAB9CD483.2__="
Subject: [Drbd-dev] =?utf-8?b?562U5aSN77yaIFJlOiAgW1BBVENIXSBmaXggZmFpbHVy?=
 =?utf-8?q?e_with_new_bi=5Ferror_field_of_bio?=
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartAB9CD483.2__=
Content-Type: multipart/alternative; boundary="=__PartAB9CD483.3__="

--=__PartAB9CD483.3__=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Lars,

> >>> Lars Ellenberg <lars.ellenberg@linbit.com> 2015-10-16 下午 19:32 >>>
> On Fri, Oct 16, 2015 at 04:13:15PM +0800, Nick Wang wrote:
> > drbd fail to build with new bio structure and interface
> > after 4.3.0, see 4246a0b63bd8f56a1469b12eafeb875b1041a451
> 
> Yes.
> *out-of-tree* drbd, as is in public git right now, that is.
  Does the *out-of-tree* drbd also need to be updated? Since the "in-tree" 
drbd only need to take care the current kernel, the one "out-of-tree" 
should work with different kernel version with conditions.

> > CC: linux-kernel@vger.kernel.org
> 
> No reason to CC linux-kernel, they won't care for out-of-tree drivers.
> And the in-tree ones are adjusted to new infrastructure on-the-go,
> whenever infrastructure changes. So that's all been done already.

Got it.

Best regards,
Nick


--=__PartAB9CD483.3__=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<html><head><meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dutf-8"><META name=3D"Author" content=3D"Novell GroupWise =
WebAccess"><style type=3D"text/css"> =0Abody p =0A{ =0A	margin: 0px; =
=0A}=0A</style></head><body style=3D'font-family: Helvetica, Arial, =
sans-serif; font-size: 13px; '>Hi Lars,<br><br>&gt; &gt;&gt;&gt; Lars&nbsp;=
Ellenberg&nbsp;&lt;lars.ellenberg@linbit.com&gt; 2015-10-16 =E4=B8=8B=E5=8D=
=88 19:32 &gt;&gt;&gt;<br>&gt; On Fri, Oct 16, 2015 at 04:13:15PM +0800, =
Nick Wang wrote:<br>&gt; &gt; drbd fail to build with new bio structure =
and interface<br>&gt; &gt; after 4.3.0, see 4246a0b63bd8f56a1469b12eafeb875=
b1041a451<br>&gt; <br>&gt; Yes.<br>&gt; *out-of-tree* drbd, as is in =
public git right now, that is.<br>&nbsp; Does the *out-of-tree* drbd also =
need to be updated? Since the "in-tree" <br>drbd only need to take care =
the current kernel, the one "out-of-tree" <br>should work with different =
kernel version with conditions.<br><br>&gt; &gt; CC: linux-kernel@vger.kern=
el.org<br>&gt; <br>&gt; No reason to CC linux-kernel, they won't care for =
out-of-tree drivers.<br>&gt; And the in-tree ones are adjusted to new =
infrastructure on-the-go,<br>&gt; whenever infrastructure changes. So =
that's all been done already.<br><br>Got it.<br><br>Best regards,<br>Nick<b=
r></body></html>

--=__PartAB9CD483.3__=--

--=__PartAB9CD483.2__=--
