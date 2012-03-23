Return-Path: <florian.haas@hastexo.com>
Received: from mail-qa0-f54.google.com (mail-qa0-f54.google.com
	[209.85.216.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C7536106DCC6
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2012 11:14:27 +0100 (CET)
Received: by qao25 with SMTP id 25so936465qao.6
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2012 03:14:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120323100432.GH3743@barkeeper1-xen.linbit>
References: <1332420276-29946-1-git-send-email-florian@hastexo.com>
	<1332420276-29946-2-git-send-email-florian@hastexo.com>
	<20120323100432.GH3743@barkeeper1-xen.linbit>
Date: Fri, 23 Mar 2012 11:08:04 +0100
Message-ID: <CAPUexz_0+mzbbrVmyXq+yBxCdUpkmrh9tvWEKyBNcaxXMUVO7g@mail.gmail.com>
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH] udev rules file: skip if invoked for a
 subsystem other than block
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Mar 23, 2012 at 11:04 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:
> On Thu, Mar 22, 2012 at 01:44:36PM +0100, Florian Haas wrote:
>> ---
>> =C2=A0scripts/drbd.rules | =C2=A0 =C2=A04 ++++
>> =C2=A01 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/scripts/drbd.rules b/scripts/drbd.rules
>> index 080635f..18708b7 100644
>> --- a/scripts/drbd.rules
>> +++ b/scripts/drbd.rules
>> @@ -1,5 +1,7 @@
>> =C2=A0# This file contains the rules to create named DRBD devices.
>>
>> +SUBSYSTEM!=3D"block", GOTO=3D"drbd_end"
>
> I see what it does, and it probably is good practice,
> or at least "polite" to do so.
>
> Does this actually fix anything?
>
> Do you have seen other devices with kernel provided device names
> matching "drbd*" ?
>
> "What's the point?"
> Am I missing something?

http://lists.linbit.com/pipermail/drbd-dev/2011-November/002007.html

Florian

--=20
Need help with High Availability?
http://www.hastexo.com/now
