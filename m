Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B8AF6142F2
	for <drbd-dev@lists.linbit.com>; Tue, 16 Nov 2004 15:09:58 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.6 release tomorrow...
Date: Tue, 16 Nov 2004 15:12:04 +0100
References: <200411152259.28960.philipp.reisner@linbit.com>
In-Reply-To: <200411152259.28960.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411161512.05023.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 15 November 2004 22:59, Philipp Reisner wrote:
> Hi,
>
> I will create the 0.7.6 tarball tomorrow (as long as nobody objects)
>
> What exactly should I put into debian/changelog ?
>

--snip--
drbd (0.7.6-0) unstable; urgency=low

  * New upstream release

 -- Philipp Reisner <phil@linbit.com>  Tue, 16 Nov 2004 14:59:00 +0200

drbd (0.7.5-2) unstable; urgency=low

  * debian/control: Added Conflict with drbd-util and drbd-module-source
  * debian/control.in.modules: Fixed description for kernel module
[...]
--snap--

Or should I replace the unstable with something else ?
You will replace thet -0 with a -1 before you upload it to debian, right ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
