Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D5BAC2DF6522
	for <drbd-dev@lists.linbit.com>; Thu, 12 Jul 2007 12:19:02 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Skipping initial sync of DRBD devices...
Date: Thu, 12 Jul 2007 12:19:01 +0200
References: <342BAC0A5467384983B586A6B0B3767105FCED4F@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767105FCED4F@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707121219.01782.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 11 July 2007 17:03:07 Graham, Simon wrote:
> I've been following the advice documented at
> http://drbd-plus.linbit.com/examples:skip-initial-sync to skip the
> initial sync of devices when you know that the first thing you will do
> is create a filesystem on the device and have run into a problem;
> although the initial sync is indeed skipped, I see this warning in the
> messages file:

I have updated the web-page to include information about drbd-8.0

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
