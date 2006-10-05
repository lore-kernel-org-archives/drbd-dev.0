Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 214002CF7976
	for <drbd-dev@lists.linbit.com>; Thu,  5 Oct 2006 10:51:04 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] local-io-error parse error in drbd.conf
Date: Thu, 5 Oct 2006 10:51:04 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C7F4@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C7F4@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610051051.05230.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 4. Oktober 2006 21:21 schrieb Montrose, Ernest:
> Hi,
> Is this configuration key word fully implemented yet?  It causes a parse
> error for now.
>

Hi Ernest,

I do not understand the question, I guess you mean:

  disk {
    on-io-error   detach;
  }

And drbdsetup tells us, that it will accept...

[root@wurzel:~]# drbdsetup help disk
USAGE:
 disk lower_dev meta_data_dev meta_data_index [{--size|-d} 0 ... 8587575296]
     [{--on-io-error|-e} pass_on call-local-io-error detach]
     [{--fencing|-f} dont-care resource-only resource-and-stonith]=20
[{--use-bmbv|-b}]

pass_on, call-local-io-error or detach as values for on-io-error.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
