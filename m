Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 82BA81051881
	for <drbd-dev@lists.linbit.com>; Mon, 18 Apr 2016 15:41:57 +0200 (CEST)
Received: by mail-vk0-f51.google.com with SMTP id c4so220204805vkb.3
	for <drbd-dev@lists.linbit.com>; Mon, 18 Apr 2016 06:41:57 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 18 Apr 2016 22:41:55 +0900
Message-ID: <CAF6H8oFsPGK2Bts6M564Dn-B6LzSx5bFjNMko5Ez6waAjnqPHw@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a11436aae227ab70530c28609
Subject: Re: [Drbd-dev] [CASE-29] After re-connect,
 WFBitMapS-WFBitMapT status has sustained continuously and copy
 command hangs
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

--001a11436aae227ab70530c28609
Content-Type: text/plain; charset=UTF-8

Dear Phil,

We think it's some kind of deadlock situation.

During reconnecting, first BIO sets pending_bitmap_work.n to 1 and waits
for status until changing from WFBitMapS to SyncSource.
At this time, If another BIO exists, this second BIO waits until
pending_bitmap_work.n to zero at inc_ap_bio().
Because status is unchanged in WFBitMapS, pending_bitmap_work.n can not be
zero forever.

Why doesn't the status change from WFBitMapS to SyncSource for the first
BIO?

Thanks.

--001a11436aae227ab70530c28609
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Phil,<div><br></div><div>We think it&#39;s some kind =
of deadlock situation.</div><div><br>During reconnecting, first BIO sets pe=
nding_bitmap_work.n to 1 and waits for status until changing from WFBitMapS=
 to SyncSource.<br>At this time, If another BIO exists, this second BIO wai=
ts until pending_bitmap_work.n to zero at inc_ap_bio().<br>Because status i=
s unchanged in WFBitMapS, pending_bitmap_work.n can not be zero forever.</d=
iv><div><br>Why doesn&#39;t the status change from WFBitMapS to SyncSource =
for the first BIO?
</div><div><br></div><div>Thanks.</div><div><br></div><div><br></div></div>

--001a11436aae227ab70530c28609--
