Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
	[209.85.218.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 78E211627A9
	for <drbd-dev@lists.linbit.com>; Fri, 19 Dec 2025 12:13:25 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
	a640c23a62f3a-b725ead5800so229068066b.1
	for <drbd-dev@lists.linbit.com>; Fri, 19 Dec 2025 03:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20251218130117.907395-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20251218130117.907395-1-zhengbing.huang@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Fri, 19 Dec 2025 12:13:12 +0100
Message-ID: <CAGNP_+UD+jHNEMcqk_kSSY5W85_bQe5t7Ud7WonuEeVE0Jd0Lg@mail.gmail.com>
Subject: Re: [PATCH v2] drbd: only send P_PEERS_IN_SYNC for up to 4 MiB in
	resync progress
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
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

> The solution is to ensure that P_PEERS_IN_SYNC within a range of 4 MiB is sent each time,
> and skip the sector where there is no reysnc.

This implementation causes some P_PEERS_IN_SYNC to be sent that are
not necessary. It is still an improvement compared the current
behavior, but it would be good to solve this cleanly while we are
working on this code.

In my test I cause the following sectors to be dirty:
offset 24568 sectors (== 12MiB - 4KiB), size 8 sectors
offset 40960 sectors (== 20MiB), size 8 sectors

I expect P_PEERS_IN_SYNC with offsets:
16384 sectors (== 8MiB)
40960 sectors (== 20MiB)

I observe P_PEERS_IN_SYNC with offsets:
0 sectors
16384 sectors (== 8MiB)
24576 sectors (== 12MiB)
40960 sectors (== 20MiB)

Perhaps the code would be simpler if you handle the case of
potentially calling drbd_queue_update_peers() for the previous
last_peers_in_sync_end position as a separate case?

> +       for (; peers_in_sync_end - peer_device->last_peers_in_sync_end >= PEERS_IN_SYNC_STEP_SECT; ) {

This could be written as a while loop, but maybe it will change anyway
with the suggestion above. Perhaps we don't need a loop at all.
update_peers_for_range() already handles splitting the range up in
4MiB chunks.

Please ensure that your patches pass the checks from the Linux
upstream checkpatch.pl. Some of the lines are too long in this patch.
I know that the current code does not always pass. We are cleaning it
up as we work on it.

Joel
