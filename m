Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6F5A81028A6D
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 16:03:49 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id c6so6705909wml.0
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 07:03:49 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id 11sm109564wmd.23.2019.06.12.07.03.47
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 12 Jun 2019 07:03:47 -0700 (PDT)
Date: Wed, 12 Jun 2019 16:03:45 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190612140345.GW5803@soda.linbit>
References: <59aa5c8c-7369-e987-4b7c-63490498570e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59aa5c8c-7369-e987-4b7c-63490498570e@gmail.com>
Subject: Re: [Drbd-dev] schedule_timeout() called without setting task state
 first
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

On Wed, Jun 05, 2019 at 09:59:30AM -0600, David Butterfield wrote:
> The logic in new_or_recycle_send_buffer_page() calls schedule_timeout() without first setting
> the task state.  This will merely yield the processor but not actually wait.  Is that intended?
> 
> In drbd_main.c:
> 968 static void new_or_recycle_send_buffer_page(struct drbd_send_buffer *sbuf)
> 969 {
> 970         while (1) {
> 971                 struct page *page;
> 972                 int count = page_count(sbuf->page);
> 973
> 974                 BUG_ON(count == 0);
> 975                 if (count == 1)
> 976                         goto have_page;
> 977
> 978                 page = alloc_page(GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN);
> 979                 if (page) {
> 980                         put_page(sbuf->page);
> 981                         sbuf->page = page;
> 982                         goto have_page;
> 983                 }
> 984
> 985                 //XXX Don't you need to set something like TASK_*INTERRUPTIBLE first?
> 986                 //XXX I think this just yields the processor but the thread remains runnable(?)
> 987                 schedule_timeout(HZ / 10);

was likely meant to be a schedule_timeout_uninterruptible(), yes.
Frequent typo, unfortunately.

	Lars

