Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C607E1056F9F
	for <drbd-dev@lists.linbit.com>; Mon,  5 Feb 2018 10:09:25 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id f3so24316211wmc.1
	for <drbd-dev@lists.linbit.com>; Mon, 05 Feb 2018 01:09:25 -0800 (PST)
Date: Mon, 5 Feb 2018 10:03:41 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20180205090341.hpgwtjexskjuovcy@rck.sh>
References: <e2b1538d-2bcc-32ec-827a-69813e23390c@alteeve.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b1538d-2bcc-32ec-827a-69813e23390c@alteeve.ca>
Subject: Re: [Drbd-dev] drbd-utils won't build with '--without 84support'
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

On Sat, Feb 03, 2018 at 07:21:14PM -0500, Digimer wrote:
> On 3ce302afa9503ac8982757a93533555a7c0156b5;
> 
> rpmbuild -ba --without 84support drbd.spec

Thanks for reporting. There is already a patch floating around, this
will land/be fixed pretty soon...

> (Note also the bad date; Should be either 'Thu 21' or 'Fri 22'.

grrr, we need a "dch" for spec files (or somebody needs to tell us that
it already exists) ;-)

Thanks, rck
