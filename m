Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id BC97B2E2E7B5
	for <drbd-dev@lists.linbit.com>; Mon,  6 Oct 2008 10:45:39 +0200 (CEST)
Date: Mon, 6 Oct 2008 10:45:39 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Compatibility with 2.6.27
Message-ID: <20081006084539.GB9810@soda.linbit>
References: <20081004204542.75781d17@titanium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081004204542.75781d17@titanium>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Oct 04, 2008 at 08:45:42PM +0200, Ante Karamatic wrote:
> Hi
> 
> In 2.6.27, CN_IDX 0x4 is taken by v86d. Since this ID is used by drbd
> also, in some cases (when vesafb is loaded) drbd can't be loaded into
> kernel and vice versa.

thanks.  we have known (and, unfortunately, ignored) that for a year
now, V86D was added last October.  guess we have to fix it now.

	Lars
