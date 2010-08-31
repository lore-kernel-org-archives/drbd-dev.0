Return-Path: <evdo.hsdpa@gmail.com>
Received: from mail-qw0-f54.google.com (mail-qw0-f54.google.com
	[209.85.216.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 028C5106E0E8
	for <drbd-dev@lists.linbit.com>; Tue, 31 Aug 2010 20:17:32 +0200 (CEST)
Received: by qwg5 with SMTP id 5so61053qwg.27
	for <drbd-dev@lists.linbit.com>; Tue, 31 Aug 2010 11:17:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikGtzfrttA18xebJcfthbHiXpMFdS=9zTCMAkiY@mail.gmail.com>
References: <b338ba23c4a721b53876c40464e5daeb2fe0b14a.1279723469.git.livewire@google.com>
	<AANLkTikGtzfrttA18xebJcfthbHiXpMFdS=9zTCMAkiY@mail.gmail.com>
Date: Tue, 31 Aug 2010 11:08:47 -0700
Message-ID: <AANLkTi=8fDK15KeC7su7kjBWdYaWNmPvSCektKes7Kue@mail.gmail.com>
From: Robert Kim App and Facebook Marketing <evdo.hsdpa@gmail.com>
To: Manuel Franceschini <livewire@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: drbd-dev@lists.linbit.com
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

Manuel,

I also sent this post out to my twitter ... I'll let you know if
anything comes back!

On Tue, Aug 31, 2010 at 6:18 AM, Manuel Franceschini
<livewire@google.com> wrote:
> Hi all,
>
> On Wed, Jul 21, 2010 at 4:55 PM, Manuel Franceschini
> <livewire@google.com> wrote:
>>
>> Signed-off-by: Manuel Franceschini <livewire@google.com>
>> ---
>>
>> Hi all,
>>
>> this small patch fixes a bug when using "drbdsetup /dev/drbdX net" with
>> IPv6 addresses without specifying a port number as in
>> "ipv6:2001:db8::1".
>>
>> This patch relies, however, on a slighlty different syntax:
>>
>> $ drbdsetup /dev/drbdX net ipv6:[2001:db8::1] ipv6:[2001:db8::2]:7799 A
>>
>> The introduction of brackets is necessary, since there is no way to
>> reliably separate the IPv6 address with the port number being optional.
>>
>> I'm happy for any feedback/suggestions.
>>
>>
>> Cheers, Manuel.
>>
>>
>> =A0user/drbdsetup.c | =A0 31 +++++++++++++++++++++++++------
>> =A01 files changed, 25 insertions(+), 6 deletions(-)
>
> Any feedback/update on this patch?
>
>
> Thanks, Manuel.
>



--=20
Robert Q Kim
2611 S Coast Highway
San Diego, CA 92007
310 598 1606

My Latest Blog Post:
http://sparkah.com/2010/07/29/experienced-iphone-app-developer-los-angeles-=
how-to-tell-if-youre-going-to-get-burnt/
http://sparkah.com/2010/08/25/facebook-marketing-strategies-from-nyc-and-lo=
s-angeles-most-devious-minds-2/
