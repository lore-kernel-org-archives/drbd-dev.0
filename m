Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: failed to complete sync due to receiving bitmap
	in unexpected cstate
Date: Tue, 19 Dec 2006 14:36:40 -0500
Message-ID: <342BAC0A5467384983B586A6B0B376710446462E@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	"Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

>=20
> My theory was that there is a timing window relative to moving from
the
> PauseSync{T|S} state such that one side can get there first and
restart
> syncing before the other side.
>=20

Not sure if you've had any thoughts on this, but I have a theory about
this that was sparked by the problem I found today where we can still be
in the PausedSyncX state when sync finishes...

If you recall, the problem was what the sync source side would get into
WFBitMapS and never exit and the target side would output:

unexpected cstate (PausedSyncT) in receive_bitmap

Here's my theory in a time sequence...

          Source                 Target
             |                      |
         <PausedSyncS>          <PausedSyncT>
             |                      |
       resync completes             |
             |                      |
          <Connected>               |
             |                      |
       high priority group          |
           finishes sync            |
         <aftr_isp->0>              |
             |                      |
     drbd_send_state                |
             |       ReportState    |
             +--------------------->|
             |     UUIDs            | ***Note UUIDs haven't been updated
here yet, so still look
             +<---------------------|    out of date
             |     ReportState      |
             +<---------------------|
             |                      |
        drbd_sync_handshake         |
          hg>1                      |
      <WFBitMapS>                   |
             |    Bitmap            |
             +--------------------->| *** get unexpected cstate message
plus never return bitmap
             |                      |
             |               Now we notice resync complete
             |                 <Connected>

Obviously this requires a lot of things to happen all together and
somewhat out of sequence, but I think it's feasible. As I see it, there
are actually several problems here:

1. When aftr_isp went to 0 we still initiated the resumption of resync
even though we are in Connected state
2. We ended up deciding to restart the resync because we got stale UUID
info from the target
3. The target side did not reply to the Bitmap leaving the source stuck
in WFBitmapS

I somehow don't think that putting a test for PausedSyncX in the
receive_bitmap() is the correct solution here but I'm not sure what
would be better... Any ideas?

Simon
