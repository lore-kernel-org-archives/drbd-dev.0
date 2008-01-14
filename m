Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id F1F7F2E0B3C0
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jan 2008 10:05:27 +0100 (CET)
Date: Mon, 14 Jan 2008 10:05:27 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD 8.0 PATCH] Update state processing so that
	after-state-change is always done in worker thread
Message-ID: <20080114090527.GH5715@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B3767107C5AF5E@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5AF5E@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jan 11, 2008 at 10:22:15AM -0500, Graham, Simon wrote:
> This patch updates the state processing so that the after state change
> processing is always done on the worker thread - my main motivation for
> this was to ensure that state change notifications are never re-ordered.
> 
> 
> This also involves the following:
> 1. starting the worker thread is done inline in drbd_set_state
> 2. the worker will be started whenever it is needed rather than
>    only when certain states are reached.
> 3. Marking the meta data dirty is done inline in drbd_set_state

this needs some time to get merged,
but has been on the list for a few weeks already.


-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
