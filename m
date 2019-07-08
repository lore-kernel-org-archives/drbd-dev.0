Return-Path: <robert.altnoeder@linbit.com>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ADF2C1011BF7
	for <drbd-dev@lists.linbit.com>; Tue,  9 Jul 2019 01:39:14 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id n4so18963751wrs.3
	for <drbd-dev@lists.linbit.com>; Mon, 08 Jul 2019 16:39:14 -0700 (PDT)
Received: from
	2a02-8388-1601-4c80-d02f-9b4a-64d5-2e65.cable.dynamic.v6.surfer.at
	(2a02-8388-1601-4c80-d02f-9b4a-64d5-2e65.cable.dynamic.v6.surfer.at.
	[2a02:8388:1601:4c80:d02f:9b4a:64d5:2e65])
	by smtp.gmail.com with ESMTPSA id
	g19sm23356732wrb.52.2019.07.08.16.32.44
	for <drbd-dev@lists.linbit.com>
	(version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Jul 2019 16:32:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Robert Altnoeder <robert.altnoeder@linbit.com>
In-Reply-To: <bd96aeb1-ac7c-1da4-bebf-e4f28d0e0313@gmail.com>
Date: Tue, 9 Jul 2019 01:32:41 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <83233537-3C35-46FF-8E0A-1268F0B33278@linbit.com>
References: <bd96aeb1-ac7c-1da4-bebf-e4f28d0e0313@gmail.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] rcu_dereference() called when not under
	rcu_read_lock().
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

On 08 Jul 2019, at 19:50, David Butterfield <dab21774@gmail.com> wrote:
>=20
> It seems that in general rcu_dereference() is expected to be called =
under rcu_read_lock().

[=E2=80=A6]

> [04]   0x5684b7  adm_new_connection drbd_nl.c:3774
> [05]   0x569643  drbd_adm_new_peer drbd_nl.c:4070
>=20

[=E2=80=A6]

>=20
> [05]   0x546625  drbd_create_device drbd_main.c:3709
> [06]   0x570b85  drbd_adm_new_minor drbd_nl.c:5858

We=E2=80=99ll check, but I believe I remember those to be either =
initializers (no readers and writers yet) or updaters. The code probably =
does an rcu_assign_pointer() and then possibly a deallocation after =
synchronize_rcu(). The updaters are normally serialized with mutex locks =
(e.g. the resource=E2=80=99s conf_update), so they don=E2=80=99t race =
with each other.

br,
Robert

