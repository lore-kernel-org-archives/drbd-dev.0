Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8: recent regression causing corruption andcrashes
Date: Fri, 11 Aug 2006 17:55:52 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103624FAA@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

After a lot of looking at the disassembly of the send-ack routines, I
think I've found it -- the new routines Philipp added do this:

static int _drbd_send_ack(drbd_dev *mdev, Drbd_Packet_Cmd cmd,=20
			  sector_t sector,
			  unsigned int blksize,
			  u64 block_id)
{...}

int drbd_send_ack(drbd_dev *mdev, Drbd_Packet_Cmd cmd, struct
Tl_epoch_entry *e)
{
	return _drbd_send_ack(mdev,cmd,
			      cpu_to_be64(drbd_ee_get_sector(e)),
			      cpu_to_be32(drbd_ee_get_size(e)),
			      e->block_id);
}

Now, if you build on a system that does NOT have CONFIG_LBD defined,
then the definition of sector_t is 'unsigned long' - i.e. 32-bits, to
the code above byte swaps the sector number as a u64, then truncates it
to 32-bits leaving JUST the byte-swapped upper portion, i.e. zero
_ALWAYS_.

I just checked my config and CONFIG_LBD is off -- I'm guessing it's
probably on for the tests you run?

I also think the fix is simply a matter of changing the definition of
_drbd_send_ack to be 'u64 sector' - I'm going to try this right now!

Simon

