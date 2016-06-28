Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 113D91051881
	for <drbd-dev@lists.linbit.com>; Tue, 28 Jun 2016 12:24:49 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 28 Jun 2016 18:24:31 +0800
Message-Id: <1467109471-16112-1-git-send-email-nwang@suse.com>
Subject: [Drbd-dev] [PATCH] drbdadm: Fix segfault while starting stacked
	resource in DRBD9
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

  Happens in:
    adm_new_peer()
      argv[NA(argc)] = ssprintf("%s", conn->peer->node_id);
      conn->peer == 0x0

  Example config:
    resource r0-U {
      stacked-on-top-of r0 {
        address    192.168.122.5:7788;
      }
    }

The name of stacked host_info is set as all hosts's
name concatenate by '_'. Fail to find the fake hostname
in on_hosts list, which make peer of conn set to 0x0.

Signed-off-by: Nick Wang <nwang@suse.com>
---
 user/v9/drbdadm.h           |  1 +
 user/v9/drbdadm_postparse.c | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/user/v9/drbdadm.h b/user/v9/drbdadm.h
index 7b43417..a96bf68 100644
--- a/user/v9/drbdadm.h
+++ b/user/v9/drbdadm.h
@@ -388,6 +388,7 @@ extern void expand_common(void);
 extern void global_validate_maybe_expand_die_if_invalid(int expand, enum pp_flags flags);
 extern struct d_option *new_opt(char *name, char *value);
 extern int hostname_in_list(const char *name, struct names *names);
+extern bool hostnames_equal(const char *a, const char *b);
 extern char *_names_to_str(char* buffer, struct names *names);
 extern char *_names_to_str_c(char* buffer, struct names *names, char c);
 #define NAMES_STR_SIZE 255
diff --git a/user/v9/drbdadm_postparse.c b/user/v9/drbdadm_postparse.c
index 2bb1230..3beddca 100644
--- a/user/v9/drbdadm_postparse.c
+++ b/user/v9/drbdadm_postparse.c
@@ -98,6 +98,20 @@ void set_on_hosts_in_res(struct d_resource *res)
 	}
 }
 
+struct d_host_info *find_host_info_by_fakename(struct d_resource* res, char *name)
+{
+    struct d_host_info *host;
+    char *concat_name;
+
+    for_each_host(host, &res->all_hosts) {
+        concat_name = strdup(names_to_str_c(&host->on_hosts, '_'));
+        if (hostnames_equal(name, concat_name))
+            return host;
+    }
+
+    return NULL;
+}
+
 struct d_host_info *find_host_info_by_name(struct d_resource* res, char *name)
 {
 	struct d_host_info *host;
@@ -403,7 +417,11 @@ static void set_peer_in_connection(struct d_resource* res, struct connection *co
 			if (conn->peer) {
 				host_info = conn->peer;
 			} else {
-				host_info = find_host_info_by_name(res, candidate->name);
+				if (candidate->faked_hostname) {
+					host_info = find_host_info_by_fakename(res, candidate->name);
+				} else {
+					host_info = find_host_info_by_name(res, candidate->name);
+				}
 				conn->peer = host_info;
 			}
 			path->peer_address = candidate->address.addr ? &candidate->address : &host_info->address;
-- 
1.8.5.6

