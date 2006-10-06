Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C69122D9E1F4
	for <drbd-dev@lists.linbit.com>; Fri,  6 Oct 2006 14:45:59 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] local-io-error parse error in drbd.conf
Date: Fri, 6 Oct 2006 14:45:55 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C7F5@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C7F5@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610061445.56259.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 5. Oktober 2006 15:03 schrieb Montrose, Ernest:
> Hi Phil,
> OK I was not very clear.  It was a little late in the day so forgive me.
> Here are the details:
>
> In /etc/drbd.conf I set:
> handlers{
> local-io-error "echo 0> /proc/sysrq-trigger; halt -f";
> }
>
> In disk I just have:
> Disk{
> on-io-error detach;
> }
>
> If I now do a "drbdadm -d state all" for example I get:
> /etc/drbd.conf:31: Parse eror: 'an option keyword' expected,
>  but got 'local-io-error'.
>
> It seems like the implementation is in the driver but not in drbdsetup(1).
>

Thanks, for pointing it out. I have just commited the missing implementaion.
See http://lists.linbit.com/pipermail/drbd-cvs/2006-October/001305.html

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
