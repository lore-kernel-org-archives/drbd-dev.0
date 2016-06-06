Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A228110564B3
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9106E42031C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:56 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uVe2GPsVHOxP for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7504942031E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:56 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vI9nLsrD4sb7 for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:55 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8321D42031C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:55 +0200 (CEST)
Resent-Message-ID: <20160610114755.GH3235@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 410CB1056446
	for <drbd-dev@lists.linbit.com>; Mon,  6 Jun 2016 17:43:44 +0200 (CEST)
To: Mike Christie <mchristi@redhat.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	konrad.wilk@oracle.com, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
	target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	osd-dev@open-osd.org, xfs@oss.sgi.com, ocfs2-devel@oss.oracle.com
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
	<1465155145-10812-29-git-send-email-mchristi@redhat.com>
	<57551C57.5090507@suse.de> <57559973.1020105@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57559A20.10506@suse.de>
Date: Mon, 6 Jun 2016 17:43:28 +0200
MIME-Version: 1.0
In-Reply-To: <57559973.1020105@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH 28/45] target: use bio op accessors
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

On 06/06/2016 05:40 PM, Mike Christie wrote:
> On 06/06/2016 01:46 AM, Hannes Reinecke wrote:
>> On 06/05/2016 09:32 PM, mchristi@redhat.com wrote:
>>> From: Mike Christie <mchristi@redhat.com>
>>>
>>> Separate the op from the rq_flag_bits and have the target layer
>>> set/get the bio using bio_set_op_attrs/bio_op.
>>>
>>> Signed-off-by: Mike Christie <mchristi@redhat.com>
>>> ---
>>>   drivers/target/target_core_iblock.c | 29 ++++++++++++++------------=
---
>>>   drivers/target/target_core_pscsi.c  |  2 +-
>>>   2 files changed, 15 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/tar=
get_core_iblock.c
>>> index c25109c..22af12f 100644
>>> --- a/drivers/target/target_core_iblock.c
>>> +++ b/drivers/target/target_core_iblock.c
>> [ .. ]
>>> @@ -689,18 +690,15 @@ iblock_execute_rw(struct se_cmd *cmd, struct sc=
atterlist *sgl, u32 sgl_nents,
>>>   		 * Force writethrough using WRITE_FUA if a volatile write cache
>>>   		 * is not enabled, or if initiator set the Force Unit Access bit.
>>>   		 */
>>> +		op =3D REQ_OP_WRITE;
>>>   		if (test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {
>>>   			if (cmd->se_cmd_flags & SCF_FUA)
>>> -				rw =3D WRITE_FUA;
>>> +				op_flags =3D WRITE_FUA;
>>>   			else if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
>>> -				rw =3D WRITE_FUA;
>>> -			else
>>> -				rw =3D WRITE;
>>> -		} else {
>>> -			rw =3D WRITE;
>>> +				op_flags =3D WRITE_FUA;
>>>   		}
>> Wrong intendation.
>
> It should be ok. That line is for the QUEUE_FLAG_WC test. We end up wit=
h:
>
> op =3D REQ_OP_WRITE;
> if (test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {
> 	if (cmd->se_cmd_flags & SCF_FUA)
> 		op_flags =3D WRITE_FUA;
> 	else if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
> 		op_flags =3D WRITE_FUA;
> }
>
>
>
>
Indeed, you are correct.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
