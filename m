Return-Path: <arnd@arndb.de>
Received: from fhigh-b1-smtp.messagingengine.com
	(fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A9FDE162774
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 22:29:45 +0100 (CET)
MIME-Version: 1.0
Date: Wed, 18 Mar 2026 22:20:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Philipp Reisner" <philipp.reisner@linbit.com>,
	"Lars Ellenberg" <lars.ellenberg@linbit.com>,
	"Jens Axboe" <axboe@kernel.dk>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>
Message-Id: <74946481-4eb7-4d8d-b10a-881ebd84ee33@app.fastmail.com>
In-Reply-To: <6b696861-ac39-4a87-a2fa-ad47a75031c6@linbit.com>
References: <20260318104858.1868731-1-arnd@kernel.org>
	<20260318104858.1868731-2-arnd@kernel.org>
	<6b696861-ac39-4a87-a2fa-ad47a75031c6@linbit.com>
Subject: Re: [PATCH 2/2] drbd: select CONFIG_NET_HANDSHAKE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Eric Biggers <ebiggers@google.com>, Netdev <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Simon Horman <horms@kernel.org>, drbd-dev@lists.linbit.com
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

On Wed, Mar 18, 2026, at 22:16, Christoph B=C3=B6hmwalder wrote:
> Am 18.03.26 um 11:48 schrieb Arnd Bergmann:

>>  config NET_HANDSHAKE_KUNIT_TEST
>>  	tristate "KUnit tests for the handshake upcall mechanism" if !KUNIT=
_ALL_TESTS
>
> Thanks for the fix, I applied it to our drbd-next tree (which should e=
nd
> up in linux-next).
>
> I would prefer to squash these kinds of fixups to keep the history in
> our patch series clean.
> Arnd, does that work for you? How do you prefer we handle attribution?
>
> Unfortunately I couldn't really find a clear precedence pattern for
> this, how is this usually handled?

Whichever way works best for you. Some people care a lot about=20
attribution for bugfixes, but I generally prefer a clean history
myself.

     Arnd
