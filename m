Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E14810003D1
	for <drbd-dev@lists.linbit.com>; Fri, 27 Sep 2013 14:47:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 233D8444326
	for <drbd-dev@lists.linbit.com>; Fri, 27 Sep 2013 14:47:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cDxx7z-oAL4Q for <drbd-dev@lists.linbit.com>;
	Fri, 27 Sep 2013 14:47:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 01B4E44433C
	for <drbd-dev@lists.linbit.com>; Fri, 27 Sep 2013 14:47:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id unG2FbAdK5wB for <drbd-dev@lists.linbit.com>;
	Fri, 27 Sep 2013 14:47:48 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTP id BC61C444326
	for <drbd-dev@lists.linbit.com>; Fri, 27 Sep 2013 14:47:48 +0200 (CEST)
Date: Fri, 27 Sep 2013 14:47:48 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20130927124748.GD16596@soda.linbit>
References: <alpine.DEB.2.00.1309261150420.47088@ware.dreamhost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1309261150420.47088@ware.dreamhost.com>
Subject: Re: [Drbd-dev] DRBD Trim/discard
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

On Thu, Sep 26, 2013 at 12:01:40PM -0700, Eric Wheeler wrote:
> Hello all,
> 
> 
> We would like to run DRBD backed by thin-provisioned volumes (think
> ZFS or dm-thinp) which require discard support to dereference unused
> block allocations.  (I searched around for DRBD trim/discard support
> with little commentary except the reference [1] below which does not
> apply to our use case.)
> 
> 
> Is discard support on the roadmap?
> 
> What are the technical considerations for implementation?
> 
> I'm guessing this would be a relatively simple patch, just need to
> add a discard flag to the wire protocol and pass that to the backing
> device (after calculating the metadata offset, if any).
> 
> If you can comment on the desired implementation of such a feature
> and point me in the right direction I may be able to write a patch
> and test.
> 
> Any help you can offer would be greatly appreciated!

We are integrating DISCARD / TRIM support into our currently pending
DRBD 8.4.4 release, right now.
Code changes expected to be pushed with the RC2, latest early next week.

Thanks for testing and feedback,

Cheers,

	Lars

