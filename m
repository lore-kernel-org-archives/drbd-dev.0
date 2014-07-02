Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 26486101AC78
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 15:08:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1C8503D35CD
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 15:08:33 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NSha6_nUamDN for <drbd-dev@lists.linbit.com>;
	Wed,  2 Jul 2014 15:08:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F36C63D35DD
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 15:08:32 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id p7LrBegjg5LF for <drbd-dev@lists.linbit.com>;
	Wed,  2 Jul 2014 15:08:32 +0200 (CEST)
Received: from localhost (rck.rck.sh [78.142.181.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id CEA263D35CD
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 15:08:32 +0200 (CEST)
Date: Wed, 2 Jul 2014 15:08:32 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140702130832.GO28936@rck.sh>
References: <1403860568-11553-1-git-send-email-lwang@suse.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <1403860568-11553-1-git-send-email-lwang@suse.com>
Subject: Re: [Drbd-dev] [PATCH 1/1] fix drbd.rules to avoid start drbd fail
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2014 at 05:16:08PM +0800, Liuhua Wang wrote:
>   fix drbd.rules by removing NAME and adding a SYMLINK to kernel node for
>   the reason that when drbd configuration has a device name different from
>   kernel node, device name will not be created since renaming a kernel node
>   fails. So start drbd by pacemaker will fail.
> 
> Signed-off-by: Liuhua Wang <lwang@suse.com>
> ---
>  scripts/drbd.rules | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/drbd.rules b/scripts/drbd.rules
> index dbdfdba..3c967f0 100644
> --- a/scripts/drbd.rules
> +++ b/scripts/drbd.rules
> @@ -12,4 +12,6 @@
>  # having it as one single line avoids those problems.
>  #
>  # DO NOT WRAP THIS LINE
> -SUBSYSTEM=="block", KERNEL=="drbd*", IMPORT{program}="/usr/sbin/drbdadm sh-udev minor-%m", NAME="$env{DEVICE}", SYMLINK="$env{SYMLINK}"
> +SUBSYSTEM=="block", KERNEL=="drbd*", IMPORT{program}="/usr/sbin/drbdadm sh-udev minor-%m", SYMLINK="$env{SYMLINK}"
> +TEST!="$env{DEVICE}", SYMLINK+="$env{DEVICE}"
> +
> -- 
> 1.9.0

Hi Liuhua,

could you please test the attached drbd.rules and report if they also
fix your problem?

Kind regards, rck

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="drbd.rules"

# This file contains the rules to create named DRBD devices.

SUBSYSTEM!="block", GOTO="drbd_end"
KERNEL!="drbd*", GOTO="drbd_end"

IMPORT{program}="/usr/sbin/drbdadm sh-udev minor-%m"

NAME=="", ENV{DEVICE}!="", NAME="$env{DEVICE}"

# Use symlink from the environment if available
ENV{SYMLINK}!="", SYMLINK="$env{SYMLINK}", GOTO="drbd_end"

# Legacy rules for DRBD 8.3 & 8.4
ENV{DISK}!="", SYMLINK+="drbd/by-disk/$env{DISK}"
ENV{RESOURCE}!="", SYMLINK+="drbd/by-res/$env{RESOURCE}"

LABEL="drbd_end"

--u3/rZRmxL6MmkK24--
