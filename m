Return-Path: <glass.su@suse.com>
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
	[209.85.208.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 758B042030C
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jul 2024 15:34:26 +0200 (CEST)
Received: by mail-lj1-f181.google.com with SMTP id
	38308e7fff4ca-2ef2fccca2cso43116421fa.1
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jul 2024 06:34:26 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [RFC PATCH 0/3] drbd.ocf support for OCF 1.1 standard
Date: Mon, 29 Jul 2024 21:34:07 +0800
Message-ID: <20240729133410.8332-1-glass.su@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lars.ellenberg@linbit.com
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

Hi, drbd maintainers
Here is a patchset which adds supports of drbd.ocf for OCF 1.1 standard.
The motivation is that SUSE's SLE16 will bring corosync3 and pacemaker
built without option '--enable-compat-2.0'. So drbd.ocf needs some
adaptations.

The first two patches are compatible with pacemaker even without option
"--enable-compat-2.0".
NOTE: The third patch changes roles "Master" "Slave" to "Promoted" "Unpromoted".
It breaks the compatibility of Pacemaker < 2.1.0.

The patchset was tested in my testbox only, non SUSE QE. I want to get your
suggestions first so make it RFC. Many thanks.


Su Yue (3):
  drbd.ocf: replace crm_master with ocf_promotion_score
  drbd.ocf: update regex of sed for new output from crm_resource
  drbd.ocf: update for OCF 1.1

 scripts/drbd.ocf | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

-- 
2.45.2

