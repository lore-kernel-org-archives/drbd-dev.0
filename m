Return-Path: <zamf@dcs.gla.ac.uk>
Received: from mr1.dcs.gla.ac.uk (mr1.dcs.gla.ac.uk [130.209.249.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 56AB72E2716C
	for <drbd-dev@lists.linbit.com>; Wed, 11 Apr 2007 14:10:51 +0200 (CEST)
Received: from paraoa.dcs.gla.ac.uk ([130.209.253.109]:41985)
	by mr1.dcs.gla.ac.uk with esmtpa (Exim 4.42) id 1Hbbey-0003c3-9y
	for drbd-dev@lists.linbit.com; Wed, 11 Apr 2007 13:10:48 +0100
Message-ID: <461CD0EC.4040402@dcs.gla.ac.uk>
Date: Wed, 11 Apr 2007 13:13:32 +0100
From: Cristian Zamfir <zamf@dcs.gla.ac.uk>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] switching between protocols A and C
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Hi,

Would it be possible to switch from protocol A to C and vice versa 
without disconnecting (for instance detach, switch protocol and re-attach)?

This would be useful when alternating between two primaries (only 
protocol C can be used) and a primary/secondary configuration where 
protocol A may increase write throughput on the primary node.

Right now this behaviour does not seem to be supported but I am 
interested if you consider it could be implemented easily.

Thank you.

Cristian
