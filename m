Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A43532D9D522
	for <drbd-dev@lists.linbit.com>; Wed, 20 Dec 2006 09:40:21 +0100 (CET)
Date: Wed, 20 Dec 2006 09:40:22 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] About the UUID
Message-ID: <20061220084022.GA8110@soda.linbit>
References: <4588E111.8090102@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4588E111.8090102@163.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-12-20 15:06:57 +0800
\ home_king:
> hi, Philipp.
> 
> Now drbd-0.8.x uses UUID instead of GC as the data-relationship-detection
> -tool, right? Its logic seems clearer than GC. However, I am confused
> about the UUID in the two-primaries-healedpartition scenario.
> 
> Given the original uuids below (both nodes are connected):
> P <5,0,0,0>      S <5,0,0,0>
> then, I plug out the wire of the primary node (disconnected):
> P <6,5,0,0>      S <5,0,0,0>
> I let the downgraded secondary become new primary, UUID should become:
> P <6,5,0,0>      S <6,5,0,0>

no. these small digits are only more readable examples.
our UUIDs are 63bit random numbers.
they may clash, and we have to fix that somewhen.
but that is not very likely.

we probably should change the example to read more like
head -c8 /dev/urandom | hd
<3cecd7aed66ff5ad,0,0,0>		<3cecd7aed66ff5ad,0,0,0>
<dc855810336641b6,3cecd7aed66ff5ad,0,0>	<3cecd7aed66ff5ad,0,0,0>
<dc855810336641b6,3cecd7aed66ff5ad,0,0>	<44dc24617bd63967,3cecd7aed66ff5ad,0,0>

to make this more obvious.

> BTW, I did not test such scenario, because I can't compile drbd-0.8.x
> in my RedHat AS4 distro.

works for me.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
