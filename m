Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 85B992DF6279
	for <drbd-dev@lists.linbit.com>; Mon, 17 Jul 2006 10:26:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Running drbdmeta non-interactively
Date: Mon, 17 Jul 2006 10:27:06 +0200
References: <342BAC0A5467384983B586A6B0B376710333A704@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B376710333A704@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200607171027.06855.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 14. Juli 2006 23:02 schrieb Graham, Simon:
> Currently, drbdmeta always prompts for confirmation before updating
> meta-data - this is fine for interactive use but if you want to
> initialize meta-data programmatically (as part of provisioning a box for
> example) it causes problems. I would propose adding a "-force" option to
> drbdmeta that overrides this and assumes a 'yes' answer to all
> questions.
>
> I have coded this and a patch for trunk is attached.
>
> Simon
>
>  <<drbdmeta-bug665.patch>>

Applied...

=2Dphil

=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
