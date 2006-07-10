Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Minor fix to DRBD install target...
Date: Mon, 10 Jul 2006 11:40:33 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671031FB99F@EXNA.corp.stratus.com>
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

Yes - sorry, my mistake on the DRBD-8 build MODSUBDIR definition...

Simon


-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Lars Ellenberg
Sent: Monday, July 10, 2006 11:31 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] Minor fix to DRBD install target...

/ 2006-07-07 11:33:53 +0200
\ Philipp Reisner:
> Lars is the Makefile guru here, I leave these patches for him ...
> [ He is on Monday in the office again. ]

since we only target 2.6. with drbd 8, we can "hardcode" modsub dir.
no one seems to use lib/<ver>/block anymore anywhere.

--=20
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
