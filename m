Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A2B361055F43
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 066992BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:22 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2MS4QpsnGdAd for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DAE522BEE40
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:21 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YDN9E02z0ak8 for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:21 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id AD3A62BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:21 +0200 (CEST)
Resent-Message-ID: <20150911132021.GW3436@soda.linbit>
Message-ID: <55CC337A.1050608@suse.de>
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
To: Kent Overstreet <kent.overstreet@gmail.com>
References: <CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com>
	<1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<1438581502.26596.24.camel@hasee> <20150804113626.GA12682@lst.de>
	<1438754604.29731.31.camel@hasee>
	<20150807073001.GA17485@lst.de> <1438990806.24452.8.camel@ssi>
	<55C5C348.1070307@suse.de> <20150808090205.GA15061@kmo-pixel>
In-Reply-To: <20150808090205.GA15061@kmo-pixel>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@canonical.com>,
	Neil@redhat.com, device-mapper development <dm-devel@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Nitin Gupta <ngupta@vflare.org>,
	Ming Lin <ming.l@ssi.samsung.com>, Al@redhat.com,
	Oleg Drokin <oleg.drokin@intel.com>,
	Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v5 01/11] block: make
 generic_make_request handle arbitrarily sized bios
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
Date: Fri, 11 Sep 2015 13:22:37 -0000

On 08/08/2015 11:02 AM, Kent Overstreet wrote:
> On Sat, Aug 08, 2015 at 10:52:24AM +0200, Hannes Reinecke wrote:
>> Wouldn't it be easier to move both max_write_same_sectors and
>> max_discard sectors to 64 bit (ie to type sector_t) and be done with t=
he
>> overflow?
>> Seems to me this is far too much coding around self-imposed restrictio=
ns...
>=20
> It's bio->bi_iter.bi_size that would have to be increased to 64 bits. W=
hich I
> suppose wouldn't actually increase the size of struct bio (when sector_=
t is 64
> bits), since struct bvec_iter has padding right now...
>=20
Which I guess we should be doing anyway.
Devices are getting larger and larger, so in the long run in need to
be moved to 64 bits.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
