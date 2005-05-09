Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep15-int.chello.at (viefep15-int.chello.at [213.46.255.19])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2B5B525881
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2005 18:07:05 +0200 (CEST)
Received: from [192.168.0.21] (really [212.186.65.148])
	by viefep15-int.chello.at
	(InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
	id <20050509160704.LNDU4809.viefep15-int.chello.at@[192.168.0.21]>
	for <drbd-dev@lists.linbit.com>; Mon, 9 May 2005 18:07:04 +0200
Message-ID: <427F8AA8.8000407@wollmersdorfer.at>
Date: Mon, 09 May 2005 18:07:04 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.11 soon
References: <200505091030.00455.philipp.reisner@linbit.com>	<200505091058.42759.hug@abanet.ch>	<200505091137.01385.philipp.reisner@linbit.com>
	<LVlMtS7zpHS+KhTi1IqrJxc=lge@web.de>
In-Reply-To: <LVlMtS7zpHS+KhTi1IqrJxc=lge@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars Ellenberg wrote:

> hm.
> maybe it is easier to NOT generate a drbd-0.7.10 package, but a drbd-0.7
> paackage, so it can be updated to our 0.7.X releases without violating
> any package release policies?

At Debian a freeze is a freeze. There is no workaround. After a freeze 
and release of stable they only accept "security fixes".

The only question is, how serious the freeze is. AFAIR the last freeze 
was summer last year, targeting September for Release. Then the release 
was delayed to March ...

> mean, development is in 0.8, 0.7 is in "bugfix-only-mode" anyways.

Not all "bugfixes" are "security fixes".

IMHO the mainstream of users can live with 0.7.10.
If someone has special requirements, (s)he can
- install from Debian /unstable (or /testing after release)
- compile from tar/SVN
- request LINBIT services
- backport future releases to stable
- use another $distri

IMHO it's important for the popularity of DRBD to have the "pretty 
stable" 0.7.10 in Debian.

Helmut Wollmersdorfer

