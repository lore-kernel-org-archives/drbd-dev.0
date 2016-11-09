Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8210A1056478
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 16:22:14 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Kim, Sung-eun" <sekim@mantech.co.kr>
Date: Wed, 09 Nov 2016 16:22:13 +0100
Message-ID: <1565484.NMKH8Jh5PJ@fat-tyre>
In-Reply-To: <CAHRYDji-LUDdvOhzSfQi=kPzR9mS+xcRM4Juz8LWb7RZnAo41w@mail.gmail.com>
References: <CAHRYDji-LUDdvOhzSfQi=kPzR9mS+xcRM4Juz8LWb7RZnAo41w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: =?utf-8?B?Si5ILiwgSmluIExlZSAo7J207KeE7ZiEKQ==?= <jhlee@mantech.co.kr>,
	Windows DRBD <wdrbd@mantech.co.kr>,
	=?utf-8?B?67CV7ZiE7ISd?= <hspark@mantech.co.kr>,
	=?utf-8?B?67CV7ISx7ZmY?= <shpark@mantech.co.kr>,
	Philipp Marek <philipp.marek@linbit.com>, drbd-dev@lists.linbit.com,
	=?utf-8?B?67Cw7KKF66y0?= <jmbae@mantech.co.kr>
Subject: Re: [Drbd-dev] WDRBD 1.3.5 released (drbd9 modified by mantech)
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

Am Dienstag, 8. November 2016, 14:35:08 CET schrieb Kim, Sung-eun:
> Hi, Philipp
> 
> WDRBD 1.3.5 is released.
> 
> https://github.com/mantechnology/wdrbd/releases
> 
> 
> we have test and debugging wdrbd for a long time, and finally met WDRBD
> 1.3.5.
> 
> We have modified a drbd9 original source code, and a one big thing was
> changed from origin code. that is,
> 
> *- A Only Primary node can be SyncSource.*
> 
> we have met a many situation for a 1:N node test, in those there were
> problems. If sync direction is different with replication direction from
> each nodes, OOS remaining and replication Consistency issues was happened,
> and we cannot solve these.
> 

I see.
Would help if you could describe such a case, step by step.

> and we decided to restrict a sync direction.
> 
> you can check this below link,
> 
> https://github.com/mantechnology/wdrbd/commit/7cc1f27f915d604b0ebcd10761a722
> f5b6c7701c
> 



> 
> 
> Another things is Fast Sync(we call it).
> 
> Do you remember that we talks about a Fast initial Sync on a way to airport
> in Seoul?
> 
> finally, we make it this. (
> https://github.com/mantechnology/wdrbd/commit/28a484b2259002c92e578e2f84ee5a
> 88c72c1ac5 )

Interesting. I do not know if it possible to do a comparable thing
in Linux... We will have a look.

 
> and, you can check a source code modified by mantech in a below contents.
> we will wait for your opinion about MODIFIED_BY_MANTECH.
> 

It will take a bit. I try to do it somwhen next week
I.e. bevor November 18.

best regards,
 Phil

