Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
	[209.85.208.180])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9A1D342019F
	for <drbd-dev@lists.linbit.com>; Wed, 17 Apr 2024 11:57:44 +0200 (CEST)
Received: by mail-lj1-f180.google.com with SMTP id
	38308e7fff4ca-2db2f6cb312so5640031fa.2
	for <drbd-dev@lists.linbit.com>; Wed, 17 Apr 2024 02:57:44 -0700 (PDT)
Date: Wed, 17 Apr 2024 11:57:41 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Su Yue <glass.su@suse.com>
Subject: Re: [PATCH 2/2] crm-fence-peer.9.sh: use join of node_state to judge
	whether node is banned
Message-ID: <Zh+dFQrPLM6an2lk@grappa.linbit>
References: <20240303091259.5045-1-l@damenly.org>
	<20240303091259.5045-2-l@damenly.org>
	<C2F581E6-5D15-49E7-B944-B79B3C08F252@suse.com>
	<48A9DD72-39A4-4866-B858-E50A33299CEB@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48A9DD72-39A4-4866-B858-E50A33299CEB@suse.com>
Cc: philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
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

On Thu, Mar 14, 2024 at 11:18:22AM +0800, Su Yue wrote:
> 
> 
> > On Mar 7, 2024, at 10:54, Su Yue <glass.su@suse.com> wrote:
> > 
> > Hi, dear drbd folks
> >  Would you help review the patches for drbd-utils? Many thanks!
> > 
> Gentle ping.

So you apparently have some kind of test suite
excercising this fencing handler?

Thank you for making us aware, and for your patience.
Looks plausible.

	Lars

