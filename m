Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
	[209.85.208.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 68B6C1608F4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 11:50:10 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
	4fb4d7f45d1cf-6431b0a1948so9418779a12.3
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 02:50:10 -0800 (PST)
Message-ID: <a7d484bf-4812-4367-8fca-575a56529c67@linbit.com>
Date: Tue, 18 Nov 2025 11:50:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] compat: make block_device_operations tests grsec
	compatible
To: Mathias Krause <minipli@grsecurity.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20251110125924.511384-1-minipli@grsecurity.net>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20251110125924.511384-1-minipli@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
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

Am 10.11.25 um 13:59 schrieb Mathias Krause:
> The grsecurity patch enforces that instances of certain types are always
> constified, with the help of a compiler plugin. One of these types is
> 'struct block_device_operations'. Code that tries to modify a such-typed
> object will cause compiler errors, leading to wrong results for the
> kernel compatibility tests.
> 
> Change these tests to do direct type compare tests instead of trying to
> modify the object, making them compatible with grsecurity kernels.
> 
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>

Thanks, applied: https://github.com/LINBIT/drbd/commit/376a2932bf8f44dd0a18bc70f3309f3e71e0d37d

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

