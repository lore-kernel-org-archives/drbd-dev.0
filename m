Return-Path: <Markus.Elfring@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8F2CC4202D0
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2023 15:37:01 +0200 (CEST)
Message-ID: <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
Date: Wed, 29 Mar 2023 15:36:59 +0200
MIME-Version: 1.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
	=?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: [Drbd-dev] [PATCH 0/3] lru_cache: Adjustments for lc_create()
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

Date: Wed, 29 Mar 2023 15:30:23 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Return directly after a failed kzalloc()
  Improve two size determinations
  Improve exception handling

 lib/lru_cache.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

=2D-
2.40.0

