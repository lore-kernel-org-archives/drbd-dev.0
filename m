Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E6F7810583BF
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:11:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D3B6245C84F
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:11:56 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3h-ZCKtY65pK for <drbd-dev@lists.linbit.com>;
	Fri,  8 Nov 2013 15:11:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B721D45C9BE
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:11:56 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BIceJcss9f8G for <drbd-dev@lists.linbit.com>;
	Fri,  8 Nov 2013 15:11:56 +0100 (CET)
Received: from fat-tyre.localnet (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 92C3545C84F
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:11:56 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 08 Nov 2013 15:11:56 +0100
Message-ID: <8941341.SgXKTi2gej@fat-tyre>
In-Reply-To: <20131108080125.GF4144@soda.linbit>
References: <005405fd01ac65c72fbe01f5b6e70daf@ugr.es>
	<20131108080125.GF4144@soda.linbit>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Drbd-dev] UDP multicast transport
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

> Hi there,
>=20
> Yes, I=B4m interested in making multicast protocol development, then =
I
> will study and define an algorithm.
>=20
> What I can do?
>=20
> Ra=FAl

Hi Ra=FAl,

We welcome such a contribution very much. We will help you
in the progress in answering questions and giving pointers.

But let me give you a warning as well:
 The DRBD code is complex, and kernel programming and debugging
 is hard. Plan for several month of your full attention for this task.
 If that is fine for you please read on.

* You need to base your work on the current drbd-9.0 development
  code.

* In case you are not used to GIT, make yourself familiar with this
  great tool. Understand what "rebase" means.

* Make yourself familiar with the DRBD code, make yourself familiar
  with using drbd-9.0 (deploy it in a least 3 virtual machines)

Then you may either do a=20
 a (prove of concept) first step, you may introduce UDP support
 as a new address family into the userland tools (drbdadm, drbdsetup).
 [Strictly speaking UDP is not a difference address family but a differ=
ent
 socket type]

 Get that to work in a network without packet loss.

 Develop ideas of how to deal with packet loss...

 Last step: Actually do multicasting for sending data packets.

or have some completely other approach

You will actually need to keep your work in a dedicated branch that you=

will need to rebase on the drbd-9.0 branch from time to time.

In case you work turns into something useful, we might be in the
position to merge your branch mid 2014.

Does this give you an idea?

PS: May I ask about your motivation for this effort?

Best,
 Phil
