Return-Path: <lars.ellenberg@linbit.com>
Received: from johann (chello212017090083.12.15.vie.surfer.at [212.17.90.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id E8BBD1011C0B
	for <drbd-dev@lists.linbit.com>; Tue, 21 Jul 2009 12:38:32 +0200 (CEST)
Resent-Message-ID: <20090721103832.GE7556@johann>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 99F211018D52
	for <drbd-dev@lists.linbit.com>; Tue, 21 Jul 2009 07:50:29 +0200 (CEST)
Date: Mon, 20 Jul 2009 22:49:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-Id: <20090720224940.36da1ef8.akpm@linux-foundation.org>
In-Reply-To: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
References: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Bart Van Assche <bart.vanassche@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>, Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-next@vger.kernel.org, Greg, Lars Marowsky-Bree <lmb@suse.de>,
	Jens Axboe <jens.axboe@oracle.com>, Dave Jones <davej@redhat.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Sam Ravnborg <sam@ravnborg.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/16] drbd: a block device for HA clusters
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon,  6 Jul 2009 17:39:19 +0200 Philipp Reisner <philipp.reisner@linbit.com> wrote:

> As the first bit of the DBRD patch already got upstream (see commit
> 10fc89d01a) it is time to get more of DRBD towards mainline.
> 
> Here is a post of drbd-8.3.2 for inclusion into linux-mm (or linux-next).
> 
> Patch set attached. Git tree available:
> git pull git://git.drbd.org/linux-2.6-drbd.git drbd

I don't think I can be bothered reading all this again ;)  I trust that
earlier review comments were suitably addressed.

Please prepare a tree for inclusion in linux-next, send that off to
Stephen and unless someone can identify reasons otherwise, send Linus a pull
request for 2.6.32-rc1.

