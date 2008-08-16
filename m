Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Huge latency issue with 8.2.6
Date: Sat, 16 Aug 2008 15:35:30 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41EEE9B7E@EXNA.corp.stratus.com>
In-Reply-To: 20080816165518.GA15331@racke
References: <DA0E7D869C862D4095C265233CD1D41EC3105F@EXNA.corp.stratus.com><DA0E7D869C862D4095C265233CD1D41EEE9B7D@EXNA.corp.strat
	us.com> 20080816165518.GA15331@racke
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

> I had the impression that the NODELAY would imply QUICKACK behaviour,
> and together witht the CORK and UNCORK should do the trick.
> but I'm happy to be enlightened.
>=20

I had the same thought but I'm reasonably sure NODELAY only affects
sending data. I think the underlying cause of this is that the data
connection is basically unidirectional -- all replies to data received
go on the meta data connection. If, for example, the data-ack were sent
on the data connection, then the TCP ACK would be piggybacked and
NODELAY would do everything you need...

> will commit a slightly modified verion of your quickack soonish.

Thanks
Simon
