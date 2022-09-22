Return-Path: <cuigaosheng1@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 19C33421023
	for <drbd-dev@lists.linbit.com>;
	Thu, 22 Sep 2022 03:27:26 +0200 (CEST)
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20220920015216.782190-1-cuigaosheng1@huawei.com>
	<677922df-1674-a872-4bc6-e9c874ee4e46@linbit.com>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <4e781cdf-75c9-2cbb-acaf-9d3b5b6b5b58@huawei.com>
Date: Thu, 22 Sep 2022 09:27:23 +0800
MIME-Version: 1.0
In-Reply-To: <677922df-1674-a872-4bc6-e9c874ee4e46@linbit.com>
Content-Type: multipart/alternative;
	boundary="------------0A065A488ADB7A421004CE59"
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, lars.ellenberg@linbit.com,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/2] Remove orphan declarations for drbd
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--------------0A065A488ADB7A421004CE59
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

> PS: I think trivial fixes like this are important, but they also create
> additional maintenance burden. So if you have more of these in the
> future, maybe save them up and submit them all at once (maybe even in a
> single patch if they are related). Thanks!

Thanks for taking time to review these patches,I will try to submit such
patches all at once in the feature.Thanks for the reminder！

> Am 20.09.22 um 03:52 schrieb Gaosheng Cui:
>> This series contains a few cleanup patches, to remove a orphan
>> declaration which has been removed and some useless comments. Thanks!
>>
>> Gaosheng Cui (2):
>>    drbd: remove orphan _req_may_be_done() declaration
>>    block/drbd: remove useless comments in receive_DataReply()
>>
>>   drivers/block/drbd/drbd_receiver.c | 3 ---
>>   drivers/block/drbd/drbd_req.h      | 2 --
>>   2 files changed, 5 deletions(-)
>>
> Both patches look good to me, thanks.
>
> Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>
> PS: I think trivial fixes like this are important, but they also create
> additional maintenance burden. So if you have more of these in the
> future, maybe save them up and submit them all at once (maybe even in a
> single patch if they are related). Thanks!
>

--------------0A065A488ADB7A421004CE59
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">PS: I think trivial fixes like this are important, but they also create
additional maintenance burden. So if you have more of these in the
future, maybe save them up and submit them all at once (maybe even in a
single patch if they are related). Thanks!</pre>
      </blockquote>
    </p>
    <pre class="moz-quote-pre" wrap="">Thanks for taking time to review these patches,I will try to submit such
patches all at once in the feature.<span style="color: rgb(67, 67, 67); font-family: Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(252, 252, 254); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Thanks for the reminder！</span>
</pre>
    <blockquote type="cite"
      cite="mid:677922df-1674-a872-4bc6-e9c874ee4e46@linbit.com">
      <pre class="moz-quote-pre" wrap="">Am 20.09.22 um 03:52 schrieb Gaosheng Cui:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This series contains a few cleanup patches, to remove a orphan
declaration which has been removed and some useless comments. Thanks!

Gaosheng Cui (2):
  drbd: remove orphan _req_may_be_done() declaration
  block/drbd: remove useless comments in receive_DataReply()

 drivers/block/drbd/drbd_receiver.c | 3 ---
 drivers/block/drbd/drbd_req.h      | 2 --
 2 files changed, 5 deletions(-)

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Both patches look good to me, thanks.

Acked-by: Christoph Böhmwalder <a class="moz-txt-link-rfc2396E" href="mailto:christoph.boehmwalder@linbit.com">&lt;christoph.boehmwalder@linbit.com&gt;</a>

PS: I think trivial fixes like this are important, but they also create
additional maintenance burden. So if you have more of these in the
future, maybe save them up and submit them all at once (maybe even in a
single patch if they are related). Thanks!

</pre>
    </blockquote>
  </body>
</html>

--------------0A065A488ADB7A421004CE59--
