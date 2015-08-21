Return-Path: <nwang@suse.com>
Received: from relay2.provo.novell.com (relay2.provo.novell.com
	[137.65.250.214])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 948791011B99
	for <drbd-dev@lists.linbit.com>; Fri, 21 Aug 2015 05:25:35 +0200 (CEST)
Message-Id: <55D70AD10200007000065BF8@relay2.provo.novell.com>
Date: Thu, 20 Aug 2015 21:26:09 -0600
From: "Nick Wang" <nwang@suse.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>
References: <1950665.2mvfrclfR5@fat-tyre>
	<1438855462-3757-1-git-send-email-nwang@suse.com>
	<1438855462-3757-2-git-send-email-nwang@suse.com>
	<20150818150319.GL19958@soda.linbit>
In-Reply-To: <20150818150319.GL19958@soda.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] =?utf-8?b?562U5aSN77yaIFJlOiBbUEFUQ0hdIGRyYmQ6IFN1cHBv?=
 =?utf-8?q?rt_zeroout_device_instead_of_initial_full_sync?=
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

Hi Lars,

> I still think this does not belong into the kernel at all.
> I may not yet have properly explained why.
>=20
   Thanks for your information.=20
   I tried blkdiscard on my test machine, but unfortunately the=20
underlying block device i used doesn't support discard...
(/sys/block/<dev>/queue/discard_max_bytes =3D=3D 0)
However, i think blkscard could work well for SSDs and=20
thinly-provisioned support storage as a workaround.

> This is a lot of stuff to add to the DRBD module,
> introducing write protocol incompatibility/protocol version bump.
>=20
> For no good reason.
>=20
  Yes, it is not a mandatory feature, more like a enhancement=20
"convenience patch" for some edge cases. User can choose=20
zeroout/discard devices via drbd tools, in case the storage
does not support discard, it will using zeroout instead of only=20
throw an "not support" error to output.

  Implement this function to drbd also help to sync the status=20
between nodes, convenience for auto deploy or monitor by admin.
Also have the possibility to implement a resume broken=20
zeroout/discard in future.

  And i can understand your concern and any decision, many thanks=20
for your and Philipp's help and review:)

Best regards,
Nick=20

