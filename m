Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 662EF101380B
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jun 2009 11:35:19 +0200 (CEST)
Resent-Message-ID: <20090623093519.GA9124@soda.linbit>
Received: from mail.carnet.hr (mail.CARNet.hr [161.53.123.6])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 83CB4101380B
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jun 2009 10:01:14 +0200 (CEST)
Date: Tue, 23 Jun 2009 10:01:09 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: drbd-dev@lists.linbit.com
Message-ID: <20090623080109.GF24077@gavran.carpriv.carnet.hr>
References: <200906121138.55945.philipp.reisner@linbit.com>
	<20090614035828.GA20436@soda.linbit>
	<20090615115856.GV15441@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090615115856.GV15441@gavran.carpriv.carnet.hr>
Cc: Tom Brown <wc-linbit.com@vmail.baremetal.com>,
	Ivars =?utf-8?B?U3RyYXpkacWGxaE=?= <ivars.strazdins@gmail.com>
Subject: Re: [Drbd-dev] possible FIX [Xen - DRBD issue / panic in
 skb_copy_bits]
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Jun 15, 2009 at 01:58:57PM +0200, Valentin Vidic wrote:
> I've reproduced the problem with Debian lenny versions of kernel (2.6.26)
> and DRBD (8.0.14). Unfortunately it seems the patches don't help. I've
> tried both and the ooops still happens: 

And here is the setup I used to reproduce the problem: two machines
(node1, node2) running Debian lenny with DRBD v8.0.14, Xen v3.2.1,
Heartbeat v2.1.4 and kernel v2.6.26-2-xen-amd64. On these nodes I have
two domU machines (child1, child2) running and managed by Hearbeat:

* node1: child1
* node2: child2

The problem is reproduced as follows:

* Turn on scatter-gather on dom0 machines: ethtool -K xenbr0 sg on
* Disconnect all DRBD devices on both nodes: drbdadm disconnect drbdX
* Connect all DRBD devices on both nodes: drbdadm connect drbdX
* Start some heavy disk IO in child1: dd if=/dev/zero of=/tmp/zero
* Force reboot the node2: reboot -f -n
* After some time Heartbeat starts child2 on node1
* Some seconds later kernel on node1 ooopses

It is not clear which of the DRBD devices causes the ooops but I couldn't
reproduce it with only child1 or child2. Also here is a DRBD config used
on these nodes:

resource drbd0 {
  protocol C;

  startup {
    wfc-timeout 60;
    degr-wfc-timeout 30;
  }

  disk {
    on-io-error detach;
    fencing resource-and-stonith;
  }

  net {
    allow-two-primaries;
    cram-hmac-alg sha1;
    shared-secret "somethinglong";
    after-sb-0pri discard-older-primary;
    after-sb-1pri consensus;
    after-sb-2pri disconnect;
  }

  handlers {
    outdate-peer /usr/local/sbin/hb2drbd;
  }

  on node1 {
    device     /dev/drbd0;
    disk       /dev/vg0/child1;
    address    1.2.3.4:7788;
    meta-disk  internal;
  }

  on node2 {
    device     /dev/drbd0;
    disk       /dev/vg0/child1;
    address    1.2.3.5:7788;
    meta-disk  internal;
  }
}

-- 
Valentin Vidic
Computer systems engineer
Computer and IT Systems and Services Department
Croatian Academic and Research Network - CARNet
Josipa Marohnica 5, HR-10000 Zagreb, Croatia
tel: +385 1 6661 714, fax. +385 1 6661 766
www.CARNet.hr
