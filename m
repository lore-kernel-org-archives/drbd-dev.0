Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8C32E1062643
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jul 2009 19:10:14 +0200 (CEST)
Resent-Message-ID: <20090710171014.GA8052@barkeeper1-xen.linbit>
Received: from mx.fr.smartjog.net (fw.sj.tdf-pmm.net [91.197.165.186])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AFD1D10625A1
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jul 2009 17:31:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mx.fr.smartjog.net (Postfix) with ESMTP id 3203A5732B
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jul 2009 16:57:42 +0200 (CEST)
Received: from mx.fr.smartjog.net ([127.0.0.1])
	by localhost (mail.dmz-ext.fr.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4TVQmrOxnkZg for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jul 2009 16:57:37 +0200 (CEST)
Received: from [192.168.0.54] (swacquie.user.fr.lan [192.168.0.54])
	by mx.fr.smartjog.net (Postfix) with ESMTP id D8E115730B
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jul 2009 16:57:36 +0200 (CEST)
Message-ID: <4A5756E0.7070401@enix.org>
Date: Fri, 10 Jul 2009 16:57:36 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Wacquiez?= <sw@enix.org>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] Drbd handler interfering with drbd-setup only cmd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,


I just upgraded my setup to drbd 8.3 (from 8.0.14) and what I used to do
with drbdsetup don't work anymore.

I'm currently using drbd to do some kind of "hot replication" on the fly
; I wrote a bunch of script  (around dmsetup) that spawn some drbdsetup
and drbdmeta, let the data sync, and spawn some other to destroy the setup.

My problem is that as I don't use any config file, so when the drbd
driver try to call "drbdadm before-resync-target", it fail.

I think it's a regression ; as it's an unusual setup, it should be ok to
have a config option that desactivate this behavior. What do you think
about it ?



Wacquiez Sébastien

PS : please cc me on reply as I'm not subscribed to this mailing list
