Return-Path: <JAxboe@fusionio.com>
Received: from mx1.fusionio.com (mx1.fusionio.com [64.244.102.30])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 760611059369
	for <drbd-dev@lists.linbit.com>; Sun,  7 Nov 2010 13:00:53 +0100 (CET)
Message-ID: <4CD69163.1030407@fusionio.com>
Date: Sun, 7 Nov 2010 12:45:39 +0100
From: Jens Axboe <jaxboe@fusionio.com>
MIME-Version: 1.0
To: Mike Snitzer <snitzer@redhat.com>
References: <1288985241-3515-1-git-send-email-snitzer@redhat.com>
In-Reply-To: <1288985241-3515-1-git-send-email-snitzer@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Neil Brown <neilb@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH] block: read i_size with i_size_read()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2010-11-05 20:27, Mike Snitzer wrote:
> Convert direct reads of an inode's i_size to using i_size_read().
> 
> i_size_{read,write} use a seqcount to protect reads from accessing
> incomple writes.  Concurrent i_size_write()s require mutual exclussion
> to protect the seqcount that is used by i_size_{read,write}.  But
> i_size_read() callers do not need to use additional locking.

Thanks Mike, I'll queue this up.

-- 
Jens Axboe

