Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3E4112DADC31
	for <drbd-dev@lists.linbit.com>; Wed, 31 Jan 2007 18:27:11 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] any chance for a drbdmeta backport to 0.7?
Date: Wed, 31 Jan 2007 18:27:49 +0100
References: <200701311435.17357.philipp@hug.cx>
In-Reply-To: <200701311435.17357.philipp@hug.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701311827.49896.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 31. Januar 2007 14:35 schrieb Philipp Hug:
> Hello everyone,
>
> I got a bug report/feature request to implement a feature to delete
> existing metadata on a disk.
> This feature seems to be implemented in 0.8. Any chance this will be
> backported?
>
> See here: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=409161
>

Actually the drbdmeta, that is included in drbd-8.0.0 can deal
with drbd-0.7's metadata as well. It can also delete (actually
re-initialize) it.

I do not feel like including it into the 0.7 tarball...
This is left as exercise for someone else.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
