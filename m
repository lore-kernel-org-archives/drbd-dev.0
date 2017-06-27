Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f182.google.com (mail-wr0-f182.google.com
	[209.85.128.182])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 032CD1057FED
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jun 2017 10:05:57 +0200 (CEST)
Received: by mail-wr0-f182.google.com with SMTP id 77so170301395wrb.1
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jun 2017 01:05:57 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	k86sm4994881wmi.16.2017.06.28.01.05.56
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Jun 2017 01:05:56 -0700 (PDT)
Resent-Message-ID: <20170628080554.GB26451@soda.linbit>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
	[209.85.214.51])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2A2C11057FDD
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jun 2017 01:55:55 +0200 (CEST)
Received: by mail-it0-f51.google.com with SMTP id b205so24842979itg.1
	for <drbd-dev@lists.linbit.com>; Tue, 27 Jun 2017 16:55:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170505071945.GB6818@rck.sh>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
	<1493928654-18768-4-git-send-email-Julia.Lawall@lip6.fr>
	<20170505071945.GB6818@rck.sh>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Jun 2017 16:49:52 -0700
Message-ID: <CAGXu5jKzvy2deqGYTjHh6z2SUcbneJmRr9hs0zoYsxyuiqfP9A@mail.gmail.com>
To: Roland Kammerer <roland.kammerer@linbit.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Cc: kernel-janitors@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/9] drbd: Drop unnecessary static
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

On Fri, May 5, 2017 at 12:19 AM, Roland Kammerer
<roland.kammerer@linbit.com> wrote:
> On Thu, May 04, 2017 at 10:10:48PM +0200, Julia Lawall wrote:
>> Drop static on a local variable, when the variable is initialized before
>> any use, on every possible execution path through the function.  The static
>> has no benefit, and dropping it reduces the code size.
>>
>> The semantic patch that fixes this problem is as follows:
>> (http://coccinelle.lip6.fr/)
>>
>> // <smpl>
>> @bad exists@
>> position p;
>> identifier x;
>> type T;
>> @@
>>
>> static T x@p;
>> ...
>> x = <+...x...+>
>>
>> @@
>> identifier x;
>> expression e;
>> type T;
>> position p != bad.p;
>> @@
>>
>> -static
>>  T x@p;
>>  ... when != x
>>      when strict
>> ?x = e;
>> // </smpl>
>>
>> The change in code size is indicates by the following output from the size
>> command.
>>
>> before:
>>    text    data     bss     dec     hex filename
>>   67299    2291    1056   70646   113f6 drivers/block/drbd/drbd_nl.o
>>
>> after:
>>    text    data     bss     dec     hex filename
>>   67283    2291    1056   70630   113e6 drivers/block/drbd/drbd_nl.o
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> ---
>>  drivers/block/drbd/drbd_nl.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
>> index 02255a0..ad0fcb4 100644
>> --- a/drivers/block/drbd/drbd_nl.c
>> +++ b/drivers/block/drbd/drbd_nl.c
>> @@ -2294,7 +2294,7 @@ static bool conn_ov_running(struct drbd_connection *connection)
>>  static enum drbd_ret_code
>>  check_net_options(struct drbd_connection *connection, struct net_conf *new_net_conf)
>>  {
>> -     static enum drbd_ret_code rv;
>> +     enum drbd_ret_code rv;
>>       struct drbd_peer_device *peer_device;
>>       int i;
>
> Yes, that already got dropped for drbd9 and is obviously correct for
> in-tree drbd8.
>
> Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
>
> Regards, rck

Which tree should this go through? Jens, I think yours?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
