Return-Path: <rodrigo@corporacionlinux.cl>
Received: from corporacionlinux.cl (clinux.manquehue.net [200.74.167.169])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 11E9A142F8
	for <drbd-dev@lists.linbit.com>; Thu, 28 Oct 2004 14:21:20 +0200 (CEST)
Received: from hiroshi.corporacionlinux.cl (unknown [10.1.0.246])
	by corporacionlinux.cl (Postfix) with ESMTP id 814FE4175
	for <drbd-dev@lists.linbit.com>; Thu, 28 Oct 2004 09:11:03 -0300 (CLST)
From: "Rodrigo Henriquez M. - Corporacion Linux S.A."
	<rodrigo@corporacionlinux.cl>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain
Message-Id: <1098966061.27399.39.camel@localhost>
Mime-Version: 1.0
Date: Thu, 28 Oct 2004 09:21:01 -0300
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Regards.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi.

My name is Rodrigo. A chilean developer and a clustering fan.

I was talking with Philipp about to start to help on this 
project in some development tasks.

I already see the ROADMAP in http://svn.drbd.org/drbd/trunk/ROADMAP
and I would like to start with the most simple item:

----
3 Authenticate the peer upon connect by using a shared secret. 
  Configuration file syntax:  net { auth-secret "secret-word" }
  Using a challenge-response authentication within the new
  handshake.
----

It sounds fine for me as an initial task (tell me if I'm wrong).

I'm watching the code and I was wondering if exists documentation
about the DRBD internals to start to read.
 
Well, I hope to be a good contribution to this project and sorry
if from here I do too many questions :-)

Regards.

-- 
Rodrigo Henriquez M.		http://www.corporacionlinux.cl
Corporacion Linux S.A. 		Fonos: 02 2442988 - 02 2444250


