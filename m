Return-Path: <lmb@suse.de>
Date: Mon, 24 Jan 2005 13:35:32 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
Subject: Re: [Drbd-dev] Re: drbd uses wrong API for struct bio
Message-ID: <20050124123532.GH5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<20050124082433.GB2820@suse.de>
	<41F4EADA.6080902@wollmersdorfer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41F4EADA.6080902@wollmersdorfer.at>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-01-24T13:32:26, Helmut Wollmersdorfer <helmut@wollmersdorfer.at> wrote:

> Is there any technical, organizational or sozial reason against an 
> integration into kernel.org?

Technical + political. The 0.7 branch is in no shape for integration
right now, and won't be because of the 2.4 compatibility cruft.

drbd-latest in SVN (0.8) is being cleaned up with that goal, but that
doesn't help the current code base much in this respect.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

