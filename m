Return-Path: <lmb@suse.de>
Date: Mon, 4 Oct 2004 15:01:58 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Message-ID: <20041004130158.GP1542@marowsky-bree.de>
References: <200410041456.21841.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200410041456.21841.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-10-04T14:56:21, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> This is intended as food for thought on how we should design our
> support for shared disk file systems.

I'm still not sure what kind of special support you need. The only
guarantee you need to provide is that after a barrier all reads on all
nodes return the same data for those blocks affected by the flush.

The shared disk file system itself will take care of issueing
appropriate barrier and flushing the OS caches.

Am I missing something? ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

