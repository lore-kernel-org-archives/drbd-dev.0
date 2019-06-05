Return-Path: <dab21774@gmail.com>
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com
	[209.85.166.178])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 382D61028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 17:57:35 +0200 (CEST)
Received: by mail-it1-f178.google.com with SMTP id l21so4277116ita.2
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 08:57:35 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191])
	by smtp.gmail.com with ESMTPSA id j9sm661519itk.23.2019.06.05.08.57.33
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 08:57:33 -0700 (PDT)
From: David Butterfield <dab21774@gmail.com>
To: drbd-dev@lists.linbit.com
References: <f5c1cf53-0eb7-35ab-7fbb-cb64e5f16305@gmail.com>
	<cf05cd9c-687f-6264-0bc3-aefa90c91b3a@gmail.com>
	<CANr6vz8kxacCYSb38G464Y2c1xw1ZqZAddN45LTwEcnE_Y2dsA@mail.gmail.com>
	<7b015341-f9f7-e207-84d7-61ab8f0d5a7b@gmail.com>
Message-ID: <74882b72-57a9-bc45-76af-0be4b11a5327@gmail.com>
Date: Wed, 5 Jun 2019 09:57:32 -0600
MIME-Version: 1.0
In-Reply-To: <7b015341-f9f7-e207-84d7-61ab8f0d5a7b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] history uuids misaligned within device_statistics
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

While playing with DRBD I've noticed a few things I'll mention here.
I already pointed out the problem that was most clearly a bug (indexing drbd_genl_ops by command number).
I'll put most of these comments into separate e-mail messages to facilitate their separate dispositions.

Regards,
David Butterfield
-----

The history_uuids in the device_statistics are 64 bits wide, but they are defined as a
__bin_field which does not align to a 64-bit boundary.  The history_uuids field follows a 32-bit
field and is always 64-bit MIS-aligned.

This leads to a misaligned access at runtime during a "drbdsetup attach" command.  On x86 the 
misaligned access will work (for non-atomic operations), but not as fast as an aligned access.
Other architectures may produce a runtime fault.

In drbd_nl.c:
257 GENL_struct(DRBD_NLA_DEVICE_STATISTICS, 20, device_statistics,
258         __u64_field(1, 0, dev_size)  /* (sectors) */
259         __u64_field(2, 0, dev_read)  /* (sectors) */
260         __u64_field(3, 0, dev_write)  /* (sectors) */
261         __u64_field(4, 0, dev_al_writes)  /* activity log writes (count) */
262         __u64_field(5, 0, dev_bm_writes)  /*  bitmap writes  (count) */
263         __u32_field(6, 0, dev_upper_pending)  /* application requests in progress */
264         __u32_field(7, 0, dev_lower_pending)  /* backing device requests in progress */
265         __flg_field(8, 0, dev_upper_blocked)
266         __flg_field(9, 0, dev_lower_blocked)
267         __flg_field(10, 0, dev_al_suspended)  /* activity log suspended */
268         __u64_field(11, 0, dev_exposed_data_uuid)
269         __u64_field(12, 0, dev_current_uuid)
270         __u32_field(13, 0, dev_disk_flags)
271         //XXX This misaligns the 64-bit history_uuids, leading to misaligned CPU access
272         __bin_field(14, 0, history_uuids, HISTORY_UUIDS * sizeof(__u64))
273 )

drbd_nl.c:5089:21: runtime error: store to misaligned address 0x7f82417efffc for type 'u64', which requires 8 byte alignment
0x7f82417efffc: note: pointer points here
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^
