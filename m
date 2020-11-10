Return-Path: <lists@alteeve.ca>
Received: from zimbra.alteeve.com (mail.alteeve.ca [65.39.153.71])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AFA4742062B
	for <drbd-dev@lists.linbit.com>; Tue, 10 Nov 2020 17:48:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.alteeve.com (Postfix) with ESMTP id E337813FD
	for <drbd-dev@lists.linbit.com>; Tue, 10 Nov 2020 11:41:13 -0500 (EST)
Received: from zimbra.alteeve.com ([127.0.0.1])
	by localhost (zimbra.alteeve.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8ze04s4yqP2S for <drbd-dev@lists.linbit.com>;
	Tue, 10 Nov 2020 11:41:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.alteeve.com (Postfix) with ESMTP id 4ACD4CC4
	for <drbd-dev@lists.linbit.com>; Tue, 10 Nov 2020 11:41:13 -0500 (EST)
Received: from zimbra.alteeve.com ([127.0.0.1])
	by localhost (zimbra.alteeve.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ax1HUV5iAPcf for <drbd-dev@lists.linbit.com>;
	Tue, 10 Nov 2020 11:41:13 -0500 (EST)
Received: from pulsar.alteeve.com (dhcp-108-168-17-168.cable.user.start.ca
	[108.168.17.168])
	by zimbra.alteeve.com (Postfix) with ESMTPSA id 1BB52589
	for <drbd-dev@lists.linbit.com>; Tue, 10 Nov 2020 11:41:13 -0500 (EST)
To: drbd-dev@lists.linbit.com
From: Digimer <lists@alteeve.ca>
Message-ID: <3e0af4f3-00fd-0aa3-93c6-eea48baccac6@alteeve.ca>
Date: Tue, 10 Nov 2020 11:41:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] Possible obscure bug
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,

  DRBD v8.4.11.

  We had a case where a client was upgrading from 1Gbps to 10Gbps NICs
for backing DRBD. The interface was an mode=3D1 (active/passive) bond, tw=
o
interfaces. We needed to switch one of the bonded interfaces to a new
physical NIC port. This is a process I've done countless times before,
but this was the first time I did it while DRBD was up on one node.

  We disconnected the peer that wasn't needed, so DRBD was running alone
on the active node. We 'ifdown sn_link1' (the name of the interface we
were about to change, which had been the active link). Confirmed with
/proc/net/bond/sn_bond1 (bond name) that the sn_link1 (interface) was
out of the bond and the bond was using 'sn_link2' (interface that was
not to be changed). We also confirmed that the ethX device that was
going to be moved over was also down.

  We updated /etc/udev/rules.d/70-persistent-net.rules to swap the MAC,
then did 'start_udev' to rename the interface. Normally this returns in
a couple seconds, but in this instance, it took a couple of minutes to
return. When it did, sn_link1 didn't exist anymore and the bond proc
file also showed that the interface hadn't come up.

  OK, so all this so far wasn't a big deal. The real concern was that
all of the VMs that were on LVs backed by DRBD acted like they lost
their hard drives. I was tail'ing syslog and there were no entries from
DRBD at all.

  I had to stop DRBD and reboot the node to recover. On reboot, the
interface (sn_link1) came up properly on the new NIC and DRBD started
normally.

  I fully understand "well don't do that" as a "fix", and I certainly
will not try this again.

  I'm writing this though as I think it might be an indication of a
deeper issue that might bite others in the future. It seems like DRBD
"held open" the interface under the bonded interface, despite the NIC
being down'ed. That DRBD totally stopped allowing disk access without
any log messages to indicate it hit a problem makes me thing this is not
a known failure condition.

  One more interesting tidbit;

  There's a single DRBD resource on this system, acting as a PV for a
clustered VG. Each VM gets an LV, and there's one additional LV for a
GFS2 partition. The gfs2 partition was not in use when the rename of the
interface was requested, and oddly enough, I _could_ write to it after.
So it seems like only parts that were in use hung, while parts that were
not.

  Writing this out, I also wonder if this might be an LVM issue, and not
a drbd issue?

  Any insight/feedback would be much appreciated. It was quite the
pantaloon soiling event, and I'd like to understand just what happened.

digimer

--=20
Digimer
Papers and Projects: https://alteeve.com/w/
"I am, somehow, less interested in the weight and convolutions of
Einstein=E2=80=99s brain than in the near certainty that people of equal =
talent
have lived and died in cotton fields and sweatshops." - Stephen Jay Gould
