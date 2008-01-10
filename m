Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Crash in lru_cache.c
Date: Thu, 10 Jan 2008 15:31:02 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5AE95@EXNA.corp.stratus.com>
In-Reply-To: 20080110201943.GA15284@debian-etc-mailname
References: <342BAC0A5467384983B586A6B0B3767107C5AE45@EXNA.corp.stratus.com>
	20080110201943.GA15284@debian-etc-mailname
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > Dec  5 05:57:09 ------------[ cut here ]------------
> > Dec  5 05:57:09 kernel BUG at
> > /test_logs/builds/SuperNova/trunk/20071205-
> r21536/src/platform/drbd/src/
> > drbd/lru_cache.c:312!
>=20
> in what exact codebase do you see this?
> up to which point have you merged upstream drbd-8.0.git?
> what local patches are applied?
>=20

Yes - sorry... this is 8.0.4 plus a bunch of the fixes that are in 8.0.8
(but not all) plus a few more than T haven't submitted yet (but I will
once I wrestle git into submission); the specific change that exposes
this that I have pulled is the one to use the TL for Protocol C as well
as A and B -- however, I think this bug exists IF you are using A or B
without this fix.

> that would be in this code path:
>                 if (s & RQ_LOCAL_MASK) {
>                         if (inc_local_if_state(mdev,Failed)) {
>                                 drbd_al_complete_io(mdev,
req->sector);
>                                 dec_local(mdev);
>                         } else {
>                                 WARN("Should have called
> drbd_al_complete_io(, %llu), "
>                                      "but my Disk seems to have
> failed:(\n",
>                                      (unsigned long long)
req->sector);
>                         }
>                 }
>=20

Exactly.

> I don't see why there could possibly be requests in the tl
> that have (s & RQ_LOCAL_MASK) when there is no disk.

Because there WAS a disk when the request was issued - in fact, the
local write to disk completed successfully, but the request is still
sitting in the TL waiting for the next barrier to complete. Subsequent
to that but while the request is still in the TL, the local disk is
detached.

> other than that, what about
>=20
> 3. when attaching a disk,
>    suspend incoming requests and wait for the tl to become empty.
>    then attach, and resume.
>=20

I think this might work but only as a side effect -- if you look back to
the sequence I documented, you will see that there has to be a write
request to the same AL area after the disk is reattached - this is
because drbd_al_complete_io quietly ignores the case where no active AL
extent is found for the request being completed. You would also need to
trigger a barrier op in this case to force the TL to be flushed.


Simon
