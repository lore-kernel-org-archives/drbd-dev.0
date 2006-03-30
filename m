Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] freeze under postmark io bench
Date: Thu, 30 Mar 2006 11:33:58 +0200
References: <6ed4c8790602101017l48d1b24s9fd684c82998e34f@mail.gmail.com>
	<6ed4c8790603230008t155b855djc4c77b5366357526@mail.gmail.com>
	<6ed4c8790603280833s4f7478b3r661d9dfc2ad073b0@mail.gmail.com>
In-Reply-To: <6ed4c8790603280833s4f7478b3r661d9dfc2ad073b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603301133.58712.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 28. M=E4rz 2006 18:33 schrieb Laurent Denel:
> Finally, I've been able to capture some traces when the host hangs,
> iLO remote access has been set up today. Hope this helps.
>

I do not think that this has anything to do with DRBD. In the call
graph is no single trace of DRBD, nor is it one of DRBD's kernel
threads.

I think that this report should go to the kernel-mailing list.

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
