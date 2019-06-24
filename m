Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 358181011BFF
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 17:35:45 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id r16so14377339wrl.11
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 08:35:45 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	n10sm10013260wrw.83.2019.06.24.08.35.44
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 24 Jun 2019 08:35:44 -0700 (PDT)
Date: Mon, 24 Jun 2019 17:35:42 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190624153542.GT30528@soda.linbit>
References: <f5c1cf53-0eb7-35ab-7fbb-cb64e5f16305@gmail.com>
	<cf05cd9c-687f-6264-0bc3-aefa90c91b3a@gmail.com>
	<CANr6vz8kxacCYSb38G464Y2c1xw1ZqZAddN45LTwEcnE_Y2dsA@mail.gmail.com>
	<7b015341-f9f7-e207-84d7-61ab8f0d5a7b@gmail.com>
	<74882b72-57a9-bc45-76af-0be4b11a5327@gmail.com>
	<20190612135805.GV5803@soda.linbit>
	<2f0bb666-e3bf-1f38-025a-910b7a37ac1e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f0bb666-e3bf-1f38-025a-910b7a37ac1e@gmail.com>
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

On Tue, Jun 18, 2019 at 12:16:45AM -0600, David Butterfield wrote:
> I should clarify that I observed the history_uuids misalignment as a runtime error from libubsan:
> 
> drbd_nl.c:5091:21: runtime error: store to misaligned address 0x7fc223ffd33c for type 'u64', which requires 8 byte alignment
> 0x7fc223ffd33c: note: pointer points here
>   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>               ^
> 
> 5076 static void device_to_statistics(struct device_statistics *s,
> 5077                                  struct drbd_device *device)
> ...
> 5090                 for (n = 0; n < ARRAY_SIZE(md->history_uuids); n++)
> 5091                         history_uuids[n] = md->history_uuids[n];
> 
> The history_uuids are declared with __bin_field() which does not appear to specify an alignment.
> It happens to follow a 32-bit field, so that's where it lands.
> >> 272         __bin_field(14, 0, history_uuids, HISTORY_UUIDS * sizeof(__u64))

Right, this comes out as a char[HISTORY_UUIDS * sizeof(__u64)],
and as such won't have an alignment... okay.

So maybe we should instead do memcpy?

diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index adeb04e4..f77df9da 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -5074,15 +5074,13 @@ static void device_to_statistics(struct device_statistics *s,
 	s->dev_upper_blocked = !may_inc_ap_bio(device);
 	if (get_ldev(device)) {
 		struct drbd_md *md = &device->ldev->md;
-		u64 *history_uuids = (u64 *)s->history_uuids;
 		struct request_queue *q;
 		int n;
 
 		spin_lock_irq(&md->uuid_lock);
 		s->dev_current_uuid = md->current_uuid;
 		BUILD_BUG_ON(sizeof(s->history_uuids) != sizeof(md->history_uuids));
-		for (n = 0; n < ARRAY_SIZE(md->history_uuids); n++)
-			history_uuids[n] = md->history_uuids[n];
+		memcpy(s->history_uuids, md->history_uuids, sizeof(s->history_uuids));
 		s->history_uuids_len = sizeof(s->history_uuids);
 		spin_unlock_irq(&md->uuid_lock);

Or come up with a "__u64_array()" field type,
that would add an __attribute__((aligned(8)))?
 
-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
