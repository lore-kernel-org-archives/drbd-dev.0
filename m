Return-Path: <philipp@hug.cx>
Received: from postman.abacus.ch (postman.abacus.ch [193.246.101.142])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 839C814331
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 16:36:18 +0200 (CEST)
Message-ID: <026001c4b5e8$f47e6220$532210ac@morpheus>
From: "Philipp Hug" <philipp@hug.cx>
To: <drbd-dev@lists.linbit.com>
Date: Tue, 19 Oct 2004 16:36:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: Cyril Bouthors <cyril@bouthors.org>, David Krovich <dkrovich@csee.wvu.edu>
Subject: [Drbd-dev] drbd kernel module makefile
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Is there a reason, why the drbd module Makefile calls "make module" from the 
kernel-source instead of just compiling itself with the header files from 
$(KDIR)/include?

this makes it quiet inconvient to use it with module-assistant (debian tool, to 
build kernel-modules from their source packages) because you need to have the 
complete source with correct config installed instead of just using the 
kernel-header modules...

in debian you can just do the following:
m-a install cloop

philipp 

