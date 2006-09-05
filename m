Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Tue, 5 Sep 2006 14:38:59 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038AF995@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 -- can access null mdev->bc pointer if local disk
	is not attached
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I've seen crashes where the code attempts to dereference a NULL mdev->bc
when there is no local disk attached - my reading of the code is that
the bc field should only be referenced after a successful call to
inc_local(mdev) (or equivalent such as inc_md_only()) - this is done in
most cases, but I've found several places where it is not (see
attached).

I can go ahead and submit patches based on calling inc_local() for most
of these but I wanted to check that this is indeed the correct solution.

Simon

=3D=3D=3D Locations I have found =3D=3D=3D

1. drbd_set_role, line 965:

		if ( ( ( mdev->state.conn < Connected ||
			 mdev->state.pdsk <=3D Attaching ) &&
		       mdev->bc->md.uuid[Bitmap] =3D=3D 0) || forced ) {
<<<=3D=3D=3D
			drbd_uuid_new_current(mdev);
		}

2. drbd_ioctl, case DRBD_IOCTL_SET_DISK_SIZE seems dodgy to me -- just
sets the size in mdev->bc; presumably
   an inc_local(mdev) should be done?

3. after_state_ch - several ones here, mostly probably OK (for example,
if ns.disk >=3DInconsistent
   which shouldn't happen unless you have local backing store). However,
there is one that is not -- line 988
   when we lose contact with the peer's copy of the data:

	/*  Lost contact to peer's copy of the data  */
	if ( os.pdsk > DUnknown && ns.pdsk <=3D DUnknown ) {
		if ( mdev->p_uuid ) {
			kfree(mdev->p_uuid);
			mdev->p_uuid =3D NULL;
		}
		if (ns.role =3D=3D Primary && mdev->bc->md.uuid[Bitmap] =3D=3D 0
) {
=09
^^^^^^^^^^^^^^^^^=3D=3D=3D=3D>>this has caused crashes
			/* Only do it if we have not yet done it... */
			INFO("Creating new current UUID\n");
			drbd_uuid_new_current(mdev);
		}

4. drbd_send_uuids is currently called from some places where
inc_local() has not been done -- I propose
   ensuring it is only called when it is safe.

5. receive_sync_uuid() -- there's no apparent check here and it calls
_drbd_uuid_set which dereferences mdev->bc.
   Not sure what is appropriate here???

6. drbd_end_req() line 109 -- tests mdev->bc->dc.on_io_error without
checking - maybe we cant get here, but
   it seems to me that if you are diskless locally and do a write _and_
the remote write fails you would end
   up here...

7. drbd_kick_lo() -- not clear that this cant be called sometimes when
we are diskless locally but perhaps
   I missed something.


