Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3905A1057315
	for <drbd-dev@lists.linbit.com>; Wed,  4 Apr 2018 12:38:41 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id r191so8958126wmg.4
	for <drbd-dev@lists.linbit.com>; Wed, 04 Apr 2018 03:38:41 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id s7sm3081448edh.29.2018.04.04.03.32.55
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 04 Apr 2018 03:32:55 -0700 (PDT)
Resent-Message-ID: <20180404103254.GC16420@soda.linbit>
Received: from sg2plout10-01.prod.sin2.secureserver.net
	(sg2plout10-01.prod.sin2.secureserver.net [182.50.145.4])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 025C51056F9E
	for <drbd-dev@lists.linbit.com>; Wed,  4 Apr 2018 09:12:12 +0200 (CEST)
To: drbd-dev@lists.linbit.com
References: <20161031105852.GC1382@soda.linbit>
From: Farhan Khan <farhan@pscome.com>
Message-ID: <aaa4fb1a-2659-9b88-3304-08660d012818@pscome.com>
Date: Wed, 4 Apr 2018 10:04:49 +0300
MIME-Version: 1.0
In-Reply-To: <20161031105852.GC1382@soda.linbit>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Drbd-dev] DRBD Bug Report : DRBD 9.0 after-resync-target not being
 called after resync / reconnect
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

Hello, I would like to report a bug:

Scenario:
- 2 nodes running as primary and secondary on CentOS 7.4 with pacemaker 
and corosync with dedicated link Gigabit link between nodes

Bug description and replication:
- Disconnect the link between nodes
      --> fence-peer is called and secondary node is correctly fenced
- Do not write any new data to primary while the link is broken
-Reconnect the link
      --> nodes reconnect and re-sync correctly
      --> after-resync-target is NOT called and location constraint remains

Further steps to manually trigger after-resync-target handler:
- wrote some data to primary
      --> correctly syncs with secondary
      --> after-resync-target is still not called

Temporary workaround:
- write a script to to write some data to primary node when it gets 
disconnected using something like  "dd if=/dev/zero of=speetest bs=64k 
count=1 conv=fdatasync"
      -->this triggers after-resync-target and location constraint is 
successfully removed

my config:
resource r0 {
     device               /dev/drbd0 minor 0;
     disk                 /dev/sda4;
     meta-disk            internal;
     on storage1 {
         node-id 0;
         address          ipv4 172.26.1.1:7790;
     }
     on storage2 {
         node-id 1;
         address          ipv4 172.26.1.2:7790;
     }
     net {
         protocol           C;
         sndbuf-size        0;
         max-buffers      8000;
         max-epoch-size   8000;
         after-sb-0pri    discard-least-changes;
         after-sb-1pri    discard-secondary;
         after-sb-2pri    call-pri-lost-after-sb;
         fencing          resource-only;
     }
     disk {
         md-flushes        no;
         al-extents       3833;
         resync-rate      90M;
         c-plan-ahead       2;
         c-fill-target     2M;
         c-max-rate       100M;
         c-min-rate       25M;
     }
     handlers {
         fence-peer       /usr/lib/drbd/crm-fence-peer.9.sh;
         after-resync-target /usr/lib/drbd/crm-unfence-peer.9.sh;
         pri-lost-after-sb /usr/lib/drbd/notify-pri-lost-after-sb.sh;
     }
}
