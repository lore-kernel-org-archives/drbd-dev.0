Return-Path: <htejun@gmail.com>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
	[209.85.217.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BF72E103B4DA
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:30:08 +0200 (CEST)
Received: by lbbgk8 with SMTP id gk8so176475lbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:30:05 -0700 (PDT)
MIME-Version: 1.0
Sender: htejun@gmail.com
In-Reply-To: <20120809060640.GA9088@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-4-git-send-email-koverstreet@google.com>
	<20120808221129.GB6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809000711.GB7262@moria.home.lan>
	<20120809060019.GA2845@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809060640.GA9088@dhcp-172-18-216-138.mtv.corp.google.com>
Date: Wed, 8 Aug 2012 23:30:05 -0700
Message-ID: <CAOS58YOMRF9fssZV8nR1kB+o7qFsti8Kc43pCaX_aekt7sEwYA@mail.gmail.com>
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 03/12] block: Add bio_reset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Wed, Aug 8, 2012 at 11:06 PM, Kent Overstreet <koverstreet@google.com> wrote:
> On Wed, Aug 08, 2012 at 11:00:19PM -0700, Tejun Heo wrote:
>> Anyways, understood.  Can you *please* put some comment what bits are
>> being preserved across reset then?  Things like this aren't obvious at
>> all and need ample explanation.
>
> I did, in the header:
>
> #define BIO_RESET_BITS  12      /* Flags starting here get preserved by
> bio_reset() */
>
> Where the rest of the flags are defined, and near where BIO_RESET_BYTES
> are defined.

Yeah, I was hoping for the comment to note that the protected bits
include the pool index.

Thanks.

-- 
tejun
