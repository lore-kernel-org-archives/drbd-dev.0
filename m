Return-Path: <robert.altnoeder@linbit.com>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 467971011B9A
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jun 2019 12:22:13 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id v19so5086688wmj.5
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jun 2019 03:22:13 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:b121:699b:66ac:c10?
	([2001:858:107:1:b121:699b:66ac:c10])
	by smtp.gmail.com with ESMTPSA id x6sm2355968wru.0.2019.06.27.03.22.12
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Jun 2019 03:22:12 -0700 (PDT)
To: drbd-dev@lists.linbit.com
References: <alpine.LRH.2.11.1906210638010.3326@mx.ewheeler.net>
	<20190624154946.GU30528@soda.linbit>
	<alpine.LRH.2.11.1906261914150.1114@mx.ewheeler.net>
From: Robert Altnoeder <robert.altnoeder@linbit.com>
Message-ID: <27d9a6d5-6ee7-be44-8d46-2dc15d466307@linbit.com>
Date: Thu, 27 Jun 2019 12:22:11 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.11.1906261914150.1114@mx.ewheeler.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Drbd-dev] Checksum based resync block size
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

On 6/26/19 9:20 PM, Eric Wheeler wrote:
> On Mon, 24 Jun 2019, Lars Ellenberg wrote:
>
>> As our in-sync/out-of-sync bitmap tracks 4k blocks,
>> we want to compare 4k checkesums.
>>
>> Yes, that generates "a lot" of requests, and if these are not merged by
>> some IO scheduler on the lower layers, that may seriously suck.
>>
>> make_ov_request() is what generates the online-verify requests.
>>
>> What we potentially could do is issue the requests in larger chunks,
>> like (1 MiB) to the backends, then calculate and communicate the
>> checksum per each 4k, as well as the result.
> What if it were to calculate 1MiB chunks (configurable) and then 
> invalidate all 4k bitmap entries in that 1MiB range if the hash 
> mismatches?

Is your intention to reduce the number of packets with checksums that
are being sent, and/or the number of checksum comparisons for the same
amount of data?

Both could have a positive impact on performance, but the question is,
whether the difference is big enough to be relevant. On the other hand,
hashing more data per checksum increases the chance of hash collisions.

br,
Robert

