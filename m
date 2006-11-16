Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 420622DEACD6
	for <drbd-dev@lists.linbit.com>; Thu, 16 Nov 2006 11:11:58 +0100 (CET)
Resent-Message-ID: <20061116101159.GB7730@soda.linbit>
Received: from cancel.adviseo.net (cancel.adviseo.net [213.251.134.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 69FB52DF6547
	for <drbd-dev@lists.linbit.com>; Thu, 16 Nov 2006 10:06:59 +0100 (CET)
From: "Sylvain Coutant" <sco@adviseo.fr>
To: "'Philipp Reisner'" <philipp.reisner@linbit.com>,
	<drbd-dev@lists.linbit.com>
Subject: RE: [Drbd-dev] larger than 4tb volume status
Date: Thu, 16 Nov 2006 10:06:53 +0100
Message-ID: <002a01c7095e$8fa6d640$f1141351@SonyVAIO>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200611160947.06338.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

>  * Selling DRBD+ licenses

The web site doesn't make clear what is DRBD's current limitation, it states
:

- "single device is limited to 4 TB"
- "DRBD+ uses HIGHMEM[...]necessary in order to mirror over 4 TB in total
over all devices"


So, is it 4 TB total storage per node or 4 TB per drbd volume ? Is this
different for 32 bits and 64 bits systems ?


BR,
 
--
Sylvain Coutant



