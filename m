Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id CE4042DEAC78
	for <drbd-dev@lists.linbit.com>; Wed,  7 Mar 2007 12:55:40 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Compression in DRBD
Date: Wed, 7 Mar 2007 12:55:39 +0100
References: <1173262599.2536.25.camel@xenon>
In-Reply-To: <1173262599.2536.25.camel@xenon>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200703071255.40086.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 7. M=E4rz 2007 11:16 schrieb komal:
> Hi all,
>           Bandwidth is an important issue in DRBD during replication of
> data. If bandwidth is properly utilized then replication will be faster
> and speed is what everyone needs.
>         When bandwidth utilization comes into picture, compressing data
> is what
> is needed. Earlier discussions were going on to use vtun with a tcp
> tunnel with zlib compression factor 9 or so to achieve compression.
>         What about implementing compression in DRBD itself. Like using
> zlib to
> compress each packet and decompress it on receiver side in DRBD code
> itself rather than using vtun and all. Wont it solve the purpose?
>

Hi,

DRBD is a really complex piece of software, and I really do not want to
duplicate anything that can get achieved on other levels.

Compression on the network can for sure be achieved by other means=20
(outside of DRBD).

=2Dphil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
