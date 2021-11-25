Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
	[209.85.208.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BA5F94201D7
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2021 18:41:32 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id x15so28544720edv.1
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2021 09:41:32 -0800 (PST)
MIME-Version: 1.0
References: <3cbff170-582b-b6cf-0988-e0d0c9b47505@gmail.com>
	<3c0ffc75-0e0f-1701-267b-1bedb6481b79@gmail.com>
In-Reply-To: <3c0ffc75-0e0f-1701-267b-1bedb6481b79@gmail.com>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 25 Nov 2021 18:41:21 +0100
Message-ID: <CAGNP_+VoB=_c5f6LO_NQBfWLrLa=APR2Ajk+kt0XGWqCMp9EXw@mail.gmail.com>
To: Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] docs: admin-guide/blockdev: Use subgraphs in
	node-states-8.dot
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

Thanks for catching this, Akira.

Unfortunately, this fix causes the "node_states" and "peer_states"
graphs to be mixed up. I guess this happens because the same IDs are
used in each subgraph. The graphs should be separate.

On reflection, the digraph node_states can be removed entirely. It is
too basic to contain any useful information. In addition it references
"ioctl_set_state". The ioctl configuration interface for DRBD has long
been removed. In fact, it was never in the upstream version of DRBD.

Best regards,
Joel
