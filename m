Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 10 Mar 2011 16:04:48 +0100
References: <201103091523.51815.philipp.reisner@linbit.com>
	<201103101310.39012.philipp.reisner@linbit.com>
	<4D78CF3A.7000408@kernel.dk>
In-Reply-To: <4D78CF3A.7000408@kernel.dk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201103101604.48775.philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD bits for 2.6.39
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 10. M=E4rz 2011, um 14:16:42 schrieb Jens Axboe:
> On 2011-03-10 13:10, Philipp Reisner wrote:
> > [...]
> >=20
> >> Now that I have your attention... Did you look at the plugging changes?
> >=20
> > You always have it :)
> > I looked at the changes, and I noticed that we no longer get the unplug
> > events.
> >=20
> >> As Christoph mentioned, you seem to be passing plugging information on
> >> the wire. What is the reason for that? With the on-stack plugging, the=
se
> >> events are not seen by the block device anymore.
> >=20
> > Imagine DRBD in synchronous mode (protocol C in DRBD speak) on an older
> > kernel. We mirror a write, in order to get the write-ack packet from the
> > peer, the peer needs to unplug as well. -> Send the unplug events via t=
he
> > wire.
> >=20
> > Now, it we would connect a current-head-of-git DRBD on one node to
> > a older one (which still needs unplug packets to respond quickly),
> > we would have a tar pit block device. (At least for single synchronous
> > writes)
> >=20
> > We are in brainstorming mode right now here.
> > One idea is to have a timer, that gets touched with every request we get
> > in, in case it expires, we send out a unplug event over the wire.
> >=20
> > But having the unplug events would be more elegant of course...
>=20
> The unplug is essentially the ->request_fn() being run now. So for older
> clients you could just always include an unplug even when you pulled
> whatever off the queue there is and sent it to the device.

DRBD is a bio-based device. I.e. we hook into the stack by having a
=2D>make_request_fn() function.=20
Are you saying that although we get the BIOs via a ->make_request_fn()
call also our ->request_fn() will be called when it is time to send=20
an unplug hint?
My expectation is, that as soon one uses his own ->make_request_fn()
=2D>request_fn() will never get called.

Best,
 Phil
=2D-=20
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
