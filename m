Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 27A722CE9331
	for <drbd-dev@lists.linbit.com>; Fri, 18 Aug 2006 15:20:05 +0200 (CEST)
Date: Fri, 18 Aug 2006 15:20:05 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20060818132005.GI7595@soda.linbit>
References: <546701173.20060818170326@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <546701173.20060818170326@yandex.ru>
Subject: [Drbd-dev] Re: BUG? incorrect percent calculate
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-18 17:03:26 +0400
\ Alexey Pushkin:
> Здравствуйте, .
> 
> cat </proc/drbd
> show 100% done, but it still syncing
> (build 2316)
> 
> "Screen-Shot":
> 
> version: 8.0pre4 (api:83/proto:82)
> SVN Revision: 2316 build by root@ajax-cluster-2.eab.ru, 2006-08-17 12:58:52
>  0: cs:SyncTarget st:Secondary/Primary ds:Inconsistent/UpToDate r---
>     ns:0 nr:1154172 dw:1154172 dr:0 al:0 bm:22 lo:0 pe:25 ua:0 ap:0
>         [===================>] sync'ed:100.0% (1136/254488)K
>         finish: 0:00:03 speed: 296 (188) K/sec
>         resync: used:1/7 hits:18795 misses:21 starving:0 dirty:0 changed:21
>         act_log: used:0/257 hits:0 misses:0 starving:0 dirty:0 changed:0

are you just complaining about 
(254488-1136)/254488 == 0.99553,
and that conventional rounding to one
decimal makes it 100.0 percent?

then: sorry, won't fix.
though, maybe, we could round down always.
but, what's the point?

or had you other issues, like
syncer not finishing properly
or something?

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
