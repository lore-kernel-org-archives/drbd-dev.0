Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 464BA14315
	for <drbd-dev@lists.linbit.com>; Thu, 19 Aug 2004 11:15:43 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Date: Thu, 19 Aug 2004 11:15:41 +0200
References: <20040728080645.GB7918@tmathiasen> <200408182131.36198.philipp.reisner@linbit.com> <20040818225708.GY9601@marowsky-bree.de>
In-Reply-To: <20040818225708.GY9601@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408191115.42139.philipp.reisner@linbit.com>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

On Thursday 19 August 2004 00:57, Lars Marowsky-Bree wrote:
> On 2004-08-18T21:31:35,
>
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> > Regarding IOCTL interface. It changed from 0.7 to 0.7.1...
>
> Sigh.
>
> Then I'll either need to do some very serious patching or delay the
> whole update until the first service pack.
>
>

I will look into it, probabely it is easy to do... [I can not remeber
what we changed there...]

BTW: I thought that RPMs have dependencies too. Why is it not possible
     to express something like

     km_drbd-0.7.1 requires  >=  drbd-0.7.1 (user-package)

     in the dependencies of the kernel module package...

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
