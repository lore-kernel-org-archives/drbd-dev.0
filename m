Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-065-089.arcor-ip.net
	[145.254.65.89])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A4EC514351
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 12:28:45 +0200 (CEST)
Date: Tue, 19 Oct 2004 12:09:50 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <89zVeflIzpji7xC+ripnD2w=lge@web.de>
References: <20041018221350.449853BE6D@garcon.linbit.com>
	<c44JehayvyHfw6kscYoJfLM=lge@web.de>
	<200410191135.04249.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200410191135.04249.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Re: [PATCH] drbdmeta und glib ...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-19 11:35:04 +0200
\ Philipp Reisner:
> On Tuesday 19 October 2004 08:41, you wrote:
> > mir gefällt nicht, dass du jetzt auch noch die glib mit reinziehen willst.
> > patch sieht hässlich aus, schau dir das ergebniss an.
> > bei der gelegenheit auch gleich whitespace und // -> /* */ :-)
> >
> > den rest hab ich nicht wirklich durchgelesen, das mach ich dann, wenns
> > fertig ist.
> > wie du dir das mit dem lock-file denkst musst du mir nochmal erklären...
> > und tut das nicht evtl. einfach ein fcntl lock, wenns schon sein muss?
> >
> 
> fcntl lock auf was ? Wenn das Modul nicht geladen ist, kann man
> das /dev/drbd ja nicht mal öffnen.

ok. so what exactly do you want to protect with that lock?
I thought of locking the physical device.

anycase, we probably should be able to identify which meta data block
belongs to which data storage area, independently of device nodes and
numbers.

	lge
