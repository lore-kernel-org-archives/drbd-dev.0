Return-Path: <lars.ellenberg@linbit.com>
Date: Tue, 21 Jul 2009 20:51:56 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20090721185156.GA10126@johann>
References: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
	<20090720224940.36da1ef8.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090720224940.36da1ef8.akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kyle Moffett <kyle@moffetthome.net>,
	Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	Bart Van Assche <bart.vanassche@gmail.com>,
	linux-next@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
	Jens Axboe <jens.axboe@oracle.com>,
	Dave Jones <davej@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/16] drbd: a block device for HA clusters
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Jul 20, 2009 at 10:49:40PM -0700, Andrew Morton wrote:
> On Mon,  6 Jul 2009 17:39:19 +0200 Philipp Reisner <philipp.reisner@linbit.com> wrote:
> > Patch set attached. Git tree available:
> > git pull git://git.drbd.org/linux-2.6-drbd.git drbd
> 
> I don't think I can be bothered reading all this again ;)  I trust that
> earlier review comments were suitably addressed.

To the best of my knowledge, we addressed all of them, yes.

> Please prepare a tree for inclusion in linux-next,
> send that off to Stephen

Ok, will do.
Stephen: expect an explicit linux-next merge request
within the next few days.

> and unless someone can identify reasons otherwise,
> send Linus a pull request for 2.6.32-rc1.

Thanks very much,

	Lars
