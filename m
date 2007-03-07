Return-Path: <komal@linsyssoft.com>
Received: from svr68.ehostpros.com (svr68.ehostpros.com [67.15.48.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9769D2E23452
	for <drbd-dev@lists.linbit.com>; Wed,  7 Mar 2007 13:41:54 +0100 (CET)
Subject: Re: [Drbd-dev] Compression in DRBD
From: komal <komal@linsyssoft.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
In-Reply-To: <200703071255.40086.philipp.reisner@linbit.com>
References: <1173262599.2536.25.camel@xenon>
	<200703071255.40086.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 07 Mar 2007 18:18:08 +0530
Message-Id: <1173271688.2536.37.camel@xenon>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, 2007-03-07 at 12:55 +0100, Philipp Reisner wrote:
> Am Mittwoch, 7. März 2007 11:16 schrieb komal:
> > Hi all,
> >           Bandwidth is an important issue in DRBD during replication of
> > data. If bandwidth is properly utilized then replication will be faster
> > and speed is what everyone needs.
> >         When bandwidth utilization comes into picture, compressing data
> > is what
> > is needed. Earlier discussions were going on to use vtun with a tcp
> > tunnel with zlib compression factor 9 or so to achieve compression.
> >         What about implementing compression in DRBD itself. Like using
> > zlib to
> > compress each packet and decompress it on receiver side in DRBD code
> > itself rather than using vtun and all. Wont it solve the purpose?
> >
> 
> Hi,
> 
> DRBD is a really complex piece of software, and I really do not want to
> duplicate anything that can get achieved on other levels.
> 
> Compression on the network can for sure be achieved by other means 
> (outside of DRBD).
> 
> -phil

Hi,

	But if we implement compression in DRBD itself we can have selective
compression. 
	By selective compression I mean is that we will compress only data
packets and not configuration packets (which reports status and
configuration) which cannot be achieved with other compression
techniques. 
	
Thanks and Regards,
Komal

