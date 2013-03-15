Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9862D1017081
	for <drbd-dev@lists.linbit.com>; Fri, 15 Mar 2013 10:26:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 8D6FA1B4361
	for <drbd-dev@lists.linbit.com>; Fri, 15 Mar 2013 10:26:26 +0100 (CET)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tcxYx0Wc1ZZD for <drbd-dev@lists.linbit.com>;
	Fri, 15 Mar 2013 10:26:26 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 7414C1B435C
	for <drbd-dev@lists.linbit.com>; Fri, 15 Mar 2013 10:26:26 +0100 (CET)
Date: Fri, 15 Mar 2013 10:26:26 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20130315092626.GB25782@soda.linbit>
References: <1363183325-20384-1-git-send-email-holer@ics.muni.cz>
	<20130313195434.GF19508@soda.linbit> <51410654.4070107@alteeve.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51410654.4070107@alteeve.ca>
Subject: Re: [Drbd-dev] [PATCH] scripts: Updated rhcs_fence script
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

On Wed, Mar 13, 2013 at 07:05:56PM -0400, Madison Kelly wrote:
> On 03/13/2013 03:54 PM, Lars Ellenberg wrote:
> >On Wed, Mar 13, 2013 at 03:02:05PM +0100, Vlastimil Holer wrote:
> >>cman_tool option -f is obsolete in current RHEL 6.x.
> >>Syntax for kill action allows only:
> >>   -n <nodename>    The name of the node to kill (can specify multiple times)

...

> Strike the delay, I've made the changes and pushed to github
> (https://github.com/digimer/rhcs_fence).

Thanks, will show up in the drbd repo shortly.

	Lars

