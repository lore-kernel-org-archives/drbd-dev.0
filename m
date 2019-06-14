Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3FD0B101AC67
	for <drbd-dev@lists.linbit.com>; Fri, 14 Jun 2019 12:02:01 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id r16so1834705wrl.11
	for <drbd-dev@lists.linbit.com>; Fri, 14 Jun 2019 03:02:01 -0700 (PDT)
Date: Fri, 14 Jun 2019 11:56:19 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190614095619.fwnu54aralozc3xv@rck.sh>
References: <CAFsC7=cjKn2XKdOrQHsB8XMUnRQom7wd8yxHbp2s0afZLZRqkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFsC7=cjKn2XKdOrQHsB8XMUnRQom7wd8yxHbp2s0afZLZRqkA@mail.gmail.com>
Cc: =?utf-8?B?6I6K5Yex5YKR?= <kcchuang.white@gmail.com>
Subject: Re: [Drbd-dev] drbd local replication usage problem
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

On Mon, Jun 10, 2019 at 08:20:22PM +0800, 莊凱傑 wrote:
> Hi drbd-dev,
> 
> It will be appreciated if you can give me some advice.
> I'm try to do local block device replication(vda vdb)

Great. That already exists, it is called RAID. If you try to do local
replication with DRBD, the answer is sorry, but no, you are doing it
wrong.

If you have any questions in the future, please send them to the
drbd-user ML. drbd-dev is for patch coordination only.

Regards, rck
