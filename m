Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Running Protocol C with disk cache enabled
Date: Fri, 22 Jun 2007 16:09:39 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105DEBB08@EXNA.corp.stratus.com>
In-Reply-To: 200706222041.34776.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B3767105DEB765@EXNA.corp.stratus.com><20070621132606.GB22863@ogo.aicooma.com>
	200706222041.34776.philipp.reisner@linbit.com
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

BTW, regarding:

>  * The message would be: You no longer need good disk IO subsystems
>    that tell the operating system the truth. Go out and use the
>    cheapest RAID5 controllers with enormous on-controller memory,
>    without battery unit...
>=20

As I mentioned previously, I'm also concerned about the caching RAID
controller case but for a different reason - imagine the controller
actually fails; I'd like to be able to replace the controller and
restart the system and still have DRBD get the disks back in sync even
though there were changes cached only in the controller...

Again - it's possible the barrier support in Linux will be the solution,
I just don't know enough about it yet...

Simon
