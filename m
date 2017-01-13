Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DD9E41056468
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2017 07:16:23 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 13 Jan 2017 14:15:58 +0800
Message-Id: <1484288158-25952-1-git-send-email-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [PATCH] drbd-utils: Fix the default node id
	initialization when upgrade v8 to v9
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

Node id will be initialized as "0" in md_convert_08_to_09() when upgrading to drbd9 
(still using two nodes without changing configuration like expliciting set the node id). 
However, "0" is legal as a node id, which may cause an "ambiguous node id" error on certain 
node when starting the resource. It is more appropriate to use "-1" as the default node id 
when initializing meta data.
This issue can be reporduced on the drbd-utils-8.9.10.

Error happened when starting service after creating md in drbd9, command are as follow:
upgrade-2:~ # drbdadm create-md single
You want me to create a v09 style flexible-size internal meta data block.
There appears to be a v08 flexible-size internal meta data block
already in place on /dev/vdb5 at byte offset 1073737728

Valid v08 meta-data found, convert to v09?
[need to type 'yes' to confirm] yes

Writing meta data...
New drbd meta data block successfully created.

upgrade-2:~ # drbdadm up single
3: Failure: (119) No valid meta-data signature found.

    ==> Use 'drbdadm create-md res' to initialize meta-data area. <==

Command 'drbdsetup attach 3 /dev/vdb5 /dev/vdb5 internal --on-io-error=pass_on' terminated with exit code 10

upgrade-2:~ # drbdadm status single
single role:Secondary
  disk:Diskless
  upgrade-1 connection:StandAlone

Error log messages in node "upgrade-2":
drbd single/0 drbd3: ambiguous node id: meta-data: 0, config: 1

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 user/shared/drbdmeta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/user/shared/drbdmeta.c b/user/shared/drbdmeta.c
index 9a28984..e2a9606 100644
--- a/user/shared/drbdmeta.c
+++ b/user/shared/drbdmeta.c
@@ -3868,6 +3868,7 @@ void md_convert_08_to_09(struct format *cfg)
 
 	cfg->md.flags &= ~(MDF_CONNECTED_IND | MDF_FULL_SYNC | MDF_PEER_OUT_DATED);
 
+	cfg->md.node_id = -1;
 	cfg->md.magic = DRBD_MD_MAGIC_09;
 	re_initialize_md_offsets(cfg);
 
-- 
1.8.5.6

