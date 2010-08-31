Return-Path: <livewire@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C63F3108991F
	for <drbd-dev@lists.linbit.com>; Tue, 31 Aug 2010 15:18:40 +0200 (CEST)
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com
	[172.24.198.97]) by smtp-out.google.com with ESMTP id o7VDIddf027869
	for <drbd-dev@lists.linbit.com>; Tue, 31 Aug 2010 06:18:39 -0700
Received: from pwj10 (pwj10.prod.google.com [10.241.219.74])
	by wpaz33.hot.corp.google.com with ESMTP id o7VDIGYn003281
	for <drbd-dev@lists.linbit.com>; Tue, 31 Aug 2010 06:18:38 -0700
Received: by pwj10 with SMTP id 10so2540395pwj.39
	for <drbd-dev@lists.linbit.com>; Tue, 31 Aug 2010 06:18:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b338ba23c4a721b53876c40464e5daeb2fe0b14a.1279723469.git.livewire@google.com>
References: <b338ba23c4a721b53876c40464e5daeb2fe0b14a.1279723469.git.livewire@google.com>
From: Manuel Franceschini <livewire@google.com>
Date: Tue, 31 Aug 2010 15:18:17 +0200
Message-ID: <AANLkTikGtzfrttA18xebJcfthbHiXpMFdS=9zTCMAkiY@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH master] Fix bug in split_address() when
	handling IPv6 addresses
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,

On Wed, Jul 21, 2010 at 4:55 PM, Manuel Franceschini
<livewire@google.com> wrote:
>
> Signed-off-by: Manuel Franceschini <livewire@google.com>
> ---
>
> Hi all,
>
> this small patch fixes a bug when using "drbdsetup /dev/drbdX net" with
> IPv6 addresses without specifying a port number as in
> "ipv6:2001:db8::1".
>
> This patch relies, however, on a slighlty different syntax:
>
> $ drbdsetup /dev/drbdX net ipv6:[2001:db8::1] ipv6:[2001:db8::2]:7799 A
>
> The introduction of brackets is necessary, since there is no way to
> reliably separate the IPv6 address with the port number being optional.
>
> I'm happy for any feedback/suggestions.
>
>
> Cheers, Manuel.
>
>
> =A0user/drbdsetup.c | =A0 31 +++++++++++++++++++++++++------
> =A01 files changed, 25 insertions(+), 6 deletions(-)

Any feedback/update on this patch?


Thanks, Manuel.
