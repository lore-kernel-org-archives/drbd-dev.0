Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 87AF41028A6C
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 15:58:08 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id v14so17031481wrr.4
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 06:58:08 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id l190sm75427wml.25.2019.06.12.06.58.06
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 12 Jun 2019 06:58:07 -0700 (PDT)
Date: Wed, 12 Jun 2019 15:58:05 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190612135805.GV5803@soda.linbit>
References: <f5c1cf53-0eb7-35ab-7fbb-cb64e5f16305@gmail.com>
	<cf05cd9c-687f-6264-0bc3-aefa90c91b3a@gmail.com>
	<CANr6vz8kxacCYSb38G464Y2c1xw1ZqZAddN45LTwEcnE_Y2dsA@mail.gmail.com>
	<7b015341-f9f7-e207-84d7-61ab8f0d5a7b@gmail.com>
	<74882b72-57a9-bc45-76af-0be4b11a5327@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74882b72-57a9-bc45-76af-0be4b11a5327@gmail.com>
Subject: Re: [Drbd-dev] history uuids misaligned within device_statistics
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

On Wed, Jun 05, 2019 at 09:57:32AM -0600, David Butterfield wrote:
> While playing with DRBD I've noticed a few things I'll mention here.
> I already pointed out the problem that was most clearly a bug (indexing drbd_genl_ops by command number).
> I'll put most of these comments into separate e-mail messages to facilitate their separate dispositions.
> 
> Regards,
> David Butterfield
> -----
> 
> The history_uuids in the device_statistics are 64 bits wide, but they are defined as a
> __bin_field which does not align to a 64-bit boundary.  The history_uuids field follows a 32-bit
> field and is always 64-bit MIS-aligned.
> 
> This leads to a misaligned access at runtime during a "drbdsetup attach" command.  On x86 the 
> misaligned access will work (for non-atomic operations), but not as fast as an aligned access.
> Other architectures may produce a runtime fault.
> 
> In drbd_nl.c:
> 257 GENL_struct(DRBD_NLA_DEVICE_STATISTICS, 20, device_statistics,
> 258         __u64_field(1, 0, dev_size)  /* (sectors) */
> 259         __u64_field(2, 0, dev_read)  /* (sectors) */
> 260         __u64_field(3, 0, dev_write)  /* (sectors) */
> 261         __u64_field(4, 0, dev_al_writes)  /* activity log writes (count) */
> 262         __u64_field(5, 0, dev_bm_writes)  /*  bitmap writes  (count) */
> 263         __u32_field(6, 0, dev_upper_pending)  /* application requests in progress */
> 264         __u32_field(7, 0, dev_lower_pending)  /* backing device requests in progress */
> 265         __flg_field(8, 0, dev_upper_blocked)
> 266         __flg_field(9, 0, dev_lower_blocked)
> 267         __flg_field(10, 0, dev_al_suspended)  /* activity log suspended */
> 268         __u64_field(11, 0, dev_exposed_data_uuid)
> 269         __u64_field(12, 0, dev_current_uuid)
> 270         __u32_field(13, 0, dev_disk_flags)
> 271         //XXX This misaligns the 64-bit history_uuids, leading to misaligned CPU access
> 272         __bin_field(14, 0, history_uuids, HISTORY_UUIDS * sizeof(__u64))
> 273 )


I don't think this is "packed",
the compiler is free to align the actual struct however it feels like,
it may or may not have "padding" holes.

struct to skb and back is done by memcpy.

	Lars

