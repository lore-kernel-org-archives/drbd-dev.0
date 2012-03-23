Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8FB5C106DCC6
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2012 10:35:56 +0100 (CET)
Date: Fri, 23 Mar 2012 10:35:56 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20120323093556.GF3743@barkeeper1-xen.linbit>
References: <1332419419-29091-1-git-send-email-florian@hastexo.com>
	<1332419419-29091-2-git-send-email-florian@hastexo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1332419419-29091-2-git-send-email-florian@hastexo.com>
Subject: Re: [Drbd-dev] [PATCH 1/3] User's Guide: Fix incorrect
 configuration syntax for c-plan-ahead and friends
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Mar 22, 2012 at 01:30:17PM +0100, Florian Haas wrote:
> It's a disk option, not net. Which may be confusing, but
> we certainly don't alleviate that confusion by documenting
> it incorrectly here.

Is that so. :-/
Ok.

> ---
>  users-guide/administration.txt |    2 +-
>  users-guide/recent-changes.txt |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/users-guide/administration.txt b/users-guide/administration.txt
> index 6d383bf..9c36bad 100644
> --- a/users-guide/administration.txt
> +++ b/users-guide/administration.txt
> @@ -739,7 +739,7 @@ a deployment in conjunction with DRBD Proxy) is provided below:
>  [source,drbd]
>  ----------------------------
>  resource <resource> {
> -  net {
> +  disk {
>      c-plan-ahead 200;
>      c-max-rate 10M;
>      c-fill-target 15M;
> diff --git a/users-guide/recent-changes.txt b/users-guide/recent-changes.txt
> index f1a9765..3132fc6 100644
> --- a/users-guide/recent-changes.txt
> +++ b/users-guide/recent-changes.txt
> @@ -366,7 +366,7 @@ following configuration options:
>  [source,drbd]
>  ----------------------------
>  resource test {
> -  net {
> +  disk {
>      c-plan-ahead 20;
>      c-fill-target 50k;
>      c-min-rate 250k;
> -- 
> 1.7.5.4
> 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
