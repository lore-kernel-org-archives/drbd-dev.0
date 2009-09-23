Return-Path: <kyle@moffetthome.net>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1317110622C7
	for <drbd-dev@lists.linbit.com>; Wed, 23 Sep 2009 16:01:31 +0200 (CEST)
Received: by ewy10 with SMTP id 10so792921ewy.13
	for <drbd-dev@lists.linbit.com>; Wed, 23 Sep 2009 07:01:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090923115751.GA11820@infradead.org>
References: <20090921144308.GG8072@barkeeper1-xen.linbit>
	<20090921165252.04e335b1@infradead.org>
	<20090921165321.GJ8072@barkeeper1-xen.linbit>
	<20090922072617U.fujita.tomonori@lab.ntt.co.jp>
	<f73f7ab80909211751p4d797556lcce5e47c3241b5ef@mail.gmail.com>
	<20090923115751.GA11820@infradead.org>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Wed, 23 Sep 2009 10:01:09 -0400
Message-ID: <f73f7ab80909230701k438be273y1e363a9ef5579e4d@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: bart.vanassche@gmail.com, sam@ravnborg.org, neilb@suse.de, knikanth@suse.de,
	gregkh@suse.de, linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Mauelshagen@redhat.com, James.Bottomley@suse.de, lmb@suse.de,
	kosaki.motohiro@jp.fujitsu.com, jens.axboe@oracle.com,
	davej@redhat.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, arjan@infradead.org
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 23, 2009 at 07:57, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 21, 2009 at 08:51:32PM -0400, Kyle Moffett wrote:
>> You have to realize that this project is NOT a new one, it's been
>> around quite a decent number of years (since kernel 2.2-ish). =C2=A0Yes,
>> the ABI is unique and has its warts, but there are a lot of things
>> that depend on it.
>
> So? =C2=A0That's never been an argument. =C2=A0Quite contrary, we ignored=
 upstream
> for years and fucked up out of tree but please merge anyway is almost
> a counter-argument.

That's not what happened with DRBD at *all*.  It was a large project
that ignored upstream for a while yes... but recently they decided to
do things right and submitted all of their patches for review and
comments.  After a good number of review cycles during which they were
model citizens for making big necessary changes, nobody could find
anything technically wrong with the code.

Now people are asking the out-of-tree project to continue to maintain
their otherwise-perfectly-merge-ready patchset while also implementing
a bunch of MD/DM/RAID-integration code.  Meanwhile several of the
DM/MD RAID guys who *already* have their code upstream have not been
having much luck defining a usable userspace API for the proposed
integrated configuration model.

At the very least, the code is at the point where Greg KH could easily
merge it into staging:
  * The code is under GPLv2
  * The goal of the developers is to get it merged in the near future
  * It builds properly on x86
  * It's for a new feature (not an existing one)
  * There's a reliable point-of-contact for the code

The only thing missing is a list of exactly what still needs to be
fixed.  I see a lot of handwaving about "We want a new API", but
nobody defining what the requirements for that are.  If nobody can
figure that out yet, then I see no reason it shouldn't be mainline
mergeable; both Neil Brown and Jens Axboe seem to think this is ready
to merge as well.

Cheers,
Kyle Moffett
