Return-Path: <pryzby@telsasoft.com>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
	[209.85.223.175]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F40541019A36
	for <drbd-dev@lists.linbit.com>; Sat, 25 Apr 2015 04:23:32 +0200 (CEST)
Received: by iejt8 with SMTP id t8so95780125iej.2
	for <drbd-dev@lists.linbit.com>; Fri, 24 Apr 2015 19:23:31 -0700 (PDT)
Received: from pryzbyj (charmander.telsasoft.com. [50.244.222.1])
	by mx.google.com with ESMTPSA id fv2sm802126igb.22.2015.04.24.19.23.29
	for <drbd-dev@lists.linbit.com>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Apr 2015 19:23:29 -0700 (PDT)
Date: Fri, 24 Apr 2015 21:23:28 -0500
From: Justin Pryzby <pryzby@telsasoft.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150425022327.GA7011@telsasoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] ocfs2 doc missing score
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

Missing "INF:"

http://drbd.linbit.com/users-guide-8.4/s-ocfs2-pacemaker.html
order o_ocfs2 ms_drbd_ocfs2:promote cl_ocfs2mgmt:start cl_fs_ocfs2:start
colocation c_ocfs2 cl_fs_ocfs2 cl_ocfs2mgmt ms_drbd_ocfs2:Master
