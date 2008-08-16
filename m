Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Huge latency issue with 8.2.6
Date: Sat, 16 Aug 2008 12:44:33 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41EEE9B7D@EXNA.corp.stratus.com>
In-Reply-To: 20080816152246.GA11083@racke
References: <DA0E7D869C862D4095C265233CD1D41EC3105F@EXNA.corp.stratus.com>
	20080816152246.GA11083@racke
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > Conclusion 2 -- the problem here has to do with the time is takes
the
> secondary to send the TCP ACK.
>=20
> in git on the way to 8.2.7, we added the TCP_NODELAY socket option,
>=20

I saw that and it's goodness BUT this controls the Nagle algorithm and
NOT the Ack Delay timer - you need (I believe) TCP_QUICKACK as well (or
a global change on the connection to lower the ack delay but I think
that would be bad - the nice thing about TCP_QUICKACK is that it's a one
time setting that causes pending acks to be sent right now but does not
change the normal ack delay).

Simon
