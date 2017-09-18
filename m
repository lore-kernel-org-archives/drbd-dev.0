Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com
	[209.85.128.177])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EBEBF1057FF0
	for <drbd-dev@lists.linbit.com>; Mon, 18 Sep 2017 11:52:43 +0200 (CEST)
Received: by mail-wr0-f177.google.com with SMTP id z39so5726290wrb.8
	for <drbd-dev@lists.linbit.com>; Mon, 18 Sep 2017 02:52:43 -0700 (PDT)
Date: Mon, 18 Sep 2017 11:47:05 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com,
	drbd-announce@lists.linbit.com
Message-ID: <20170918094705.GO62978@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] git.linbit.com/git.drbd.org are moving to
	github.com/LINBIT
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

Dear all,

please note that we are moving our public repositories to
github.com/LINBIT.

Fresh checkouts will work as expected (we already switched the
submodules). Old checkouts that use submodules (drbd-utils, drbd-9.0,
wdrbd9) will require a "git submodule sync".

The old repositories will be gone in 14 days from now, so please update
ASAP and report any problems, preferably on the drbd-user ML.

Regards, rck
-- 
Roland Kammerer
+43 1 817 82 92 - 70
roland.kammerer@linbit.com

LINBIT | Keeping the Digital World Running
DRBD – Corosync – Pacemaker

