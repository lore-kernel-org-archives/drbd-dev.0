Return-Path: <nwang@suse.com>
Received: from relay2.provo.novell.com (relay2.provo.novell.com
	[137.65.250.214])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 872581045C28
	for <drbd-dev@lists.linbit.com>; Fri,  6 Mar 2015 02:45:54 +0100 (CET)
Message-Id: <54F9776D020000700004B9CC@relay2.provo.novell.com>
Date: Thu, 05 Mar 2015 18:46:21 -0700
From: "Nick Wang" <nwang@suse.com>
To: <drbd-dev@lists.linbit.com>
References: <54F893C4020000700004B720@relay2.provo.novell.com>
	<54F9776D020000700004B9CC@relay2.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Cc: Lars Marowsky-Bree <lmb@suse.com>
Subject: [Drbd-dev] Querying the devel plan of speed up initial sync of new
 and empty devices
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

Hi,

DRBD is quite important and useful in SUSE HA product.
With the feedback from customer, the initial sync will took some time=20
even if no 'real' data has to be synced, especially with huge devices.
Although the DRBD device can be fully operational with performance=20
reduced before the initial synchronization has completed.

A method that can be used in SUSE HA 12 SP1 is under evaluation.=20
One draft idea is to set a "a zeroed device" flag in metadata when=20
using "drbdadm primary --force --<zeroed device flag> <res>",=20
then the secondary device can skip the data sync but zeroing the=20
device locally.

Comparing to the full sync, the data can be zerod without sync(only=20
metadata synced). And compare to only sync the metadata, there=20
is not necessary to the admin to guarantee all remote device are=20
zerod/new already.

Before starting to do it. I want to ask is there any plan of the similar=20=

feature in upstream? And if not, can i work on it for both upstream=20
and SUSE?

Since I am not an expert of DRBD yet like you, any suggestion or idea=20
will be appreciate and helpful. Thanks in advanced.

# Since DRBD9 GM is not ready yet, the first target of=20
development is drbd.8.4.x

Best regards,
Nick=20

