Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 45A8B1056332
	for <drbd-dev@lists.linbit.com>; Wed,  1 Mar 2017 22:37:01 +0100 (CET)
Date: Wed, 1 Mar 2017 13:36:55 -0800 (PST)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
In-Reply-To: <20170301130614.GH10667@soda.linbit>
Message-ID: <alpine.LRH.2.11.1703011211010.6659@mail.ewheeler.net>
References: <alpine.LRH.2.11.1702281620050.16946@mail.ewheeler.net>
	<20170301130614.GH10667@soda.linbit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] BUG: NULL pointer dereference triggered by drbdsetup
 events2
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

On Wed, 1 Mar 2017, Lars Ellenberg wrote:

> On Tue, Feb 28, 2017 at 04:28:46PM -0800, Eric Wheeler wrote:
> > Hello all,
> > 
> > We found a relatively easy to reproduce bug that crashes the kernel. Start 
> > with all of the resources down and only the DRBD module loaded and run the 
> > following:
> > 
> > drbdadm up foo
> > drbdsetup events2 foo | true
> > drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
> > drbdadm up foo
> > 
> > The backtrace is below. The ls above simply illustrates the problem. After 
> > a down, the sysfs entry should not exist. The bug manifests because 
> > add_disk attempts to create the same sysfs entry but it cannot and fails 
> > up the stack. I have a feeling that the interface used by events2 is 
> > holding open a reference count after down so the sysfs entry is never 
> > removed.
> > 
> > We are piping into true because it fails quickly without reading any 
> > stdio, so perhaps the kernel is blocked trying to flush a buffer into 
> > userspace and never releases a resource count (speculation).
> > 
> > This was tested using the 4.10.1 kernel with userspace tools 
> > drbd-utils-8.9.4. I suspect this could be worked around in userspace, but 
> > it would be ideal if the kernel module could be fixed up to prevent a 
> > crash.
> > 
> > Please let me know if you need additional information or if I can provide 
> > any other testing.
> > 
> > Thank you for your help!
> 
> The "events2" part of drbd 8.4 was a "backport" from drbd 9.
> I found this apparently relevant commit in our DRBD 9 repo.
> 
> In our out-of-tree 8.4 code, we later dropped the .done parts again,
> for compat with RHEL 5, which is likely why this fix fell through.
> 
> I basically only re-diffed and compile-tested for current upstream kernel.
> Does this help already, or do we need to dig deeper?

Hi Lars,

Thank you for responding so quickly!

The events2 feature is neat, it allows us to prevent polling and provide 
better responsiveness in our infrastructure. We applied the patch and this 
is what we found:

It no longer crashes the kernel with a null pointer dereference, but now 
the drbdsetup calls never leave the kernel. The first time we ran the test 
case it worked fine, but the second time 'drbdadm down foo' hung. I 
checked the stack traces inside the kernel for each process that is hung 
and have also included the output of this test:


# This test succeeded
~]# drbdadm up foo
~]# drbdsetup events2 foo | true
~]# drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
ls: cannot access /sys/devices/virtual/bdi/147:7740: No such file or directory
~]# drbdadm up foo


# This test failed
~]# drbdsetup events2 foo | true
~]# drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
Command 'drbdsetup-84 down foo' did not terminate within 600 seconds
/sys/devices/virtual/bdi/147:7740
~]# drbdadm up foo
Command 'drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io' did not terminate within 5 seconds


The second test that failed left hung drbdsetup processes:

~]# ps ax |grep drbdsetup-84
 1579 pts/0    D      0:00 drbdsetup-84 down foo
 1585 ?        D      0:00 drbdsetup-84 role 7740
 1737 pts/0    D      0:00 drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io

These are the in-kernel stack traces for each pid:

##### 1579 pts/0    D+     0:00 drbdsetup-84 down foo
[root@hvtest2 ~]# cat /proc/1579/stack 
[<ffffffff81102a8c>] wait_rcu_gp+0x5c/0x80
[<ffffffff81106685>] synchronize_sched+0x45/0x60
[<ffffffffa02a8ca2>] adm_del_resource+0xf2/0x110 [drbd]
[<ffffffffa02ab5f3>] drbd_adm_down+0x233/0x240 [drbd]
[<ffffffff8161235d>] genl_family_rcv_msg+0x1cd/0x400
[<ffffffff81612621>] genl_rcv_msg+0x91/0xd0
[<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
[<ffffffff81611adc>] genl_rcv+0x2c/0x40
[<ffffffff81610a76>] netlink_unicast+0x106/0x210
[<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690
[<ffffffff815c036d>] sock_sendmsg+0x3d/0x50
[<ffffffff815c0405>] sock_write_iter+0x85/0xf0
[<ffffffff812257b1>] __vfs_write+0xd1/0x110
[<ffffffff81225e49>] vfs_write+0xa9/0x1b0
[<ffffffff81226cf5>] SyS_write+0x55/0xd0
[<ffffffff816fdb6e>] system_call_fastpath+0x12/0x71
[<ffffffffffffffff>] 0xffffffffffffffff

##### 1585 ?        D      0:00 drbdsetup-84 role 7740
~]# cat /proc/1585/stack
[<ffffffff81612658>] genl_rcv_msg+0xc8/0xd0
[<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
[<ffffffff81611adc>] genl_rcv+0x2c/0x40
[<ffffffff81610a76>] netlink_unicast+0x106/0x210
[<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690
[<ffffffff815c036d>] sock_sendmsg+0x3d/0x50
[<ffffffff815c0405>] sock_write_iter+0x85/0xf0
[<ffffffff812257b1>] __vfs_write+0xd1/0x110
[<ffffffff81225e49>] vfs_write+0xa9/0x1b0
[<ffffffff81226cf5>] SyS_write+0x55/0xd0
[<ffffffff816fdb6e>] system_call_fastpath+0x12/0x71
[<ffffffffffffffff>] 0xffffffffffffffff

##### 1737 pts/0    D      0:00 drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io
~]# cat /proc/1737/stack 
[<ffffffff81612658>] genl_rcv_msg+0xc8/0xd0
[<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
[<ffffffff81611adc>] genl_rcv+0x2c/0x40
[<ffffffff81610a76>] netlink_unicast+0x106/0x210
[<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690
[<ffffffff815c036d>] sock_sendmsg+0x3d/0x50
[<ffffffff815c0405>] sock_write_iter+0x85/0xf0
[<ffffffff812257b1>] __vfs_write+0xd1/0x110
[<ffffffff81225e49>] vfs_write+0xa9/0x1b0
[<ffffffff81226cf5>] SyS_write+0x55/0xd0
[<ffffffff816fdb6e>] system_call_fastpath+0x12/0x71
[<ffffffffffffffff>] 0xffffffffffffffff


Please let me know if you would like any additional information.

--
Eric Wheeler

> 
> Thanks,
> 	Lars
> 
> 
> commit 74635bbfbd03546f19ed015cec6e470062af44af
> Author: Lars Ellenberg <lars.ellenberg@linbit.com>
> Date:   Wed Jul 27 14:53:00 2016 +0200
> 
>     drbd: fix potential refcount leak, add missing drbd_adm_get_initial_state_done
>     
>     If some drbdsetup events2 / wait-* command aborts early,
>     or the netlink socket currently in .dumpit = drbd_adm_get_initial_state
>     is destroyed early for some other reason,
>     the cleanup code inside that .dumpit function would never run,
>     and we end up with a reference count leak.
>     
>     Move cleanup to .done = drbd_adm_get_initial_state_done.
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index f35db29..115b468 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -84,6 +84,7 @@ int drbd_adm_dump_connections_done(struct netlink_callback *cb);
>  int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb);
>  int drbd_adm_dump_peer_devices_done(struct netlink_callback *cb);
>  int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb);
> +int drbd_adm_get_initial_state_done(struct netlink_callback *cb);
>  
>  #include <linux/drbd_genl_api.h>
>  #include "drbd_nla.h"
> @@ -4932,6 +4933,21 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>  	return skb->len;
>  }
>  
> +int drbd_adm_get_initial_state_done(struct netlink_callback *cb)
> +{
> +	LIST_HEAD(head);
> +	if (cb->args[0]) {
> +		struct drbd_state_change *state_change =
> +			(struct drbd_state_change *)cb->args[0];
> +		cb->args[0] = 0;
> +
> +		/* connect list to head */
> +		list_add(&head, &state_change->list);
> +		free_state_changes(&head);
> +	}
> +	return 0;
> +}
> +
>  int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>  {
>  	struct drbd_resource *resource;
> @@ -4940,14 +4956,6 @@ int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>  	if (cb->args[5] >= 1) {
>  		if (cb->args[5] > 1)
>  			return get_initial_state(skb, cb);
> -		if (cb->args[0]) {
> -			struct drbd_state_change *state_change =
> -				(struct drbd_state_change *)cb->args[0];
> -
> -			/* connect list to head */
> -			list_add(&head, &state_change->list);
> -			free_state_changes(&head);
> -		}
>  		return 0;
>  	}
>  
> diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
> index c934d3a..aa9bf5d 100644
> --- a/include/linux/drbd_genl.h
> +++ b/include/linux/drbd_genl.h
> @@ -521,6 +521,7 @@ GENL_op(
>  	DRBD_ADM_GET_INITIAL_STATE, 38,
>  	GENL_op_init(
>  	        .dumpit = drbd_adm_get_initial_state,
> +	        .done = drbd_adm_get_initial_state_done,
>  	),
>  	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_GENLA_F_MANDATORY))
>  
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
> 
