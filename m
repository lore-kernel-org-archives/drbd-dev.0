Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 88FE1105938B
	for <drbd-dev@lists.linbit.com>; Wed,  3 Nov 2010 18:24:59 +0100 (CET)
Date: Wed, 3 Nov 2010 18:24:59 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20101103172459.GF4767@barkeeper1-xen.linbit>
References: <20101103085515.16500maycqm4c2ub@groupware.intern.b1-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20101103085515.16500maycqm4c2ub@groupware.intern.b1-systems.de>
Subject: Re: [Drbd-dev] DRBD Resource Agent flaw when stopping
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Nov 03, 2010 at 08:55:15AM +0100, Uwe Grawert wrote:
> Hello,
> 
> in the OCF Resource Agent (ocf:linbit:drbd) is a flaw, when cleaning
> up a resource and stopping the resource afterwards. The resource
> agent returns a OCF_ERR_CONFIGURED which happens because of the
> following lines:
> 
> if [[ ${OCF_RESKEY_CRM_meta_notify_start_uname- NOT SET } = " NOT
> SET " ]]; then
> 	ocf_log err "you really should enable notify when using this RA"
> 	return $OCF_ERR_CONFIGURED
> fi
> 
> After a cleanup of a started resource the variable
> OCF_RESKEY_CRM_meta_notify_start_uname is empty. A simple and quick
> solution would be to add "stop" to the following block in a case
> switch:
> 
> case $__OCF_ACTION in
> monitor|validate-all)
> :;;
> 
> This is line 778 in the Resource Agent. In my opinion it does not
> make much sense to make the "is notify enabled" check when stopping
> a resource. Hence it seems reasonable to exclude a stop action from
> this check.
> 
> Is there something that speaks against it? If not, I will send a
> patch to this list.


Thanks,
but that should be fixed already:
http://git.drbd.org/?p=drbd-8.3.git;a=shortlog

Always first check git...

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
