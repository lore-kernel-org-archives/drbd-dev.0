Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Sun, 24 Sep 2006 11:35:44 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671039D46E3@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: crashes if role is changed to Secondary whilst
	disk state is Negotiating...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The specific crash I saw was due to this code in drbd_set_role; =
drbd_set_role calls drbd_al_to_on_disk_bm() if the new role is secondary =
and the disk state is not diskless -- there are transitory states =
between diskless and attached where this is not valid.

The specific lines of code are:

=A0=A0=A0=A0if(mdev->state.disk > Diskless && (new_role & Secondary)) {
=A0=A0=A0=A0=A0=A0=A0=A0drbd_al_to_on_disk_bm(mdev);
=A0=A0=A0=A0}

and the test should presumably be 'mdev->state.disk > Negotiating' - =
however, this routine presumably needs to use inc_local() to do this so =
I would propose the following:

	if ((new_role & Secondary) && inc_local(mdev)) {
		drbd_al_to_on_disk_bm(mdev);

		dec_local(mdev);
	}

Simon
