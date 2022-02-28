Return-Path: <akpm@linux-foundation.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9916B42006A
	for <drbd-dev@lists.linbit.com>;
	Mon, 28 Feb 2022 05:56:38 +0100 (CET)
Date: Sun, 27 Feb 2022 20:47:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "NeilBrown" <neilb@suse.de>
Message-Id: <20220227204728.b2eb5dd94ecc3e86912bacad@linux-foundation.org>
In-Reply-To: <164602251992.20161.9146570952337454229@noble.neil.brown.name>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>
	<164447147257.23354.2801426518649016278.stgit@noble.brown>
	<20220210122440.vqth5mwsqtv6vjpq@quack3.lan>
	<164453611721.27779.1299851963795418722@noble.neil.brown.name>
	<20220224182622.n7abfey3asszyq3x@quack3.lan>
	<164602251992.20161.9146570952337454229@noble.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	drbd-dev@lists.linbit.com, Paolo Valente <paolo.valente@linaro.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
	Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
	linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	ceph-devel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Wu Fengguang <fengguang.wu@intel.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [Drbd-dev] [PATCH 02/11] MM: document and polish read-ahead
	code.
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, 28 Feb 2022 15:28:39 +1100 "NeilBrown" <neilb@suse.de> wrote:

> When writing documentation the intent of the author is of some interest,
> but the behaviour of the code is paramount.

uh, er, ah, no.  The code describes the behaviour of the code.  The
comments are there to describe things other than the code's behaviour.
Things such as the author's intent.

Any deviation between the author's intent and the code's behaviour is
called a "bug", so it's pretty important to understand authorial
intent, no?

