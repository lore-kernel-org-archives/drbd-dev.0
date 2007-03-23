Return-Path: <philipp.reisner@linbit.com>
Received: from amd.localdomain (chello080108092198.22.11.tuwien.teleweb.at
	[80.108.92.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3C6902E05217
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2007 17:24:53 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] OOPS...
Date: Fri, 23 Mar 2007 17:24:33 +0100
References: <200703211743.16391.philipp.reisner@linbit.com>
In-Reply-To: <200703211743.16391.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200703231724.33147.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 21. M=E4rz 2007 17:43 schrieb Philipp Reisner:

Just to "close" the issue ;)=20

Last actually spotted the bug!
Here is the patch, that fixes this issue:=20
http://lists.linbit.com/pipermail/drbd-cvs/2007-March/001493.html

=2DPhil
