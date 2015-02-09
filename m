Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5060E100EBF0
	for <drbd-dev@lists.linbit.com>; Mon,  9 Feb 2015 15:52:19 +0100 (CET)
Date: Mon, 9 Feb 2015 15:52:16 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Imre Palik <imrep.amz@gmail.com>
Message-ID: <20150209145215.GA1325@soda.linbit>
References: <1423487138-6971-1-git-send-email-imrep.amz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423487138-6971-1-git-send-email-imrep.amz@gmail.com>
Cc: "Palik, Imre" <imrep@amazon.de>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: drbd service: specifying
 commands from /sbin/ with absolute path
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Feb 09, 2015 at 02:05:38PM +0100, Imre Palik wrote:
> From: "Palik, Imre" <imrep@amazon.de>
> 
> This change removes the dependance of the service on wether /sbin is
> in the path or not.

If you are NOT root,
this will not work anyways.

If you ARE root,
/sbin (or your local equivalent) is supposed to be in your path.

There are deployments out there
that have these tools not in /sbin but elsewhere. 

	Lars
