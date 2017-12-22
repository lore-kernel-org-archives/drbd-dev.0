Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 661A11057588
	for <drbd-dev@lists.linbit.com>; Fri, 22 Dec 2017 15:59:17 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id 9so22285985wme.4
	for <drbd-dev@lists.linbit.com>; Fri, 22 Dec 2017 06:59:17 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	g3sm15521677edi.11.2017.12.22.06.50.56
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 22 Dec 2017 06:50:57 -0800 (PST)
Date: Fri, 22 Dec 2017 15:50:52 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20171222145052.GE4939@soda.linbit>
References: <1513878810-6207-1-git-send-email-johannes@johannesthoma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513878810-6207-1-git-send-email-johannes@johannesthoma.com>
Subject: Re: [Drbd-dev] [PATCH] Fixed possible use after free in
 drbd_thread_setup
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

On Thu, Dec 21, 2017 at 06:53:30PM +0100, johannes@johannesthoma.com wrote:
> drbd_thread might already be freed when complete returns,

The lifetime of our "struct drbd_tread" thingies, which are embeded in
our struct drbd_resource and struct drbd_connection,
is different from the "running" time of the threads.

So no, this won't happen.

> hence we shouldn't access the drbd_thread object (thi)
> after calling complete().
> 
> I am not 100% sure if this creates any further races,

Moving that complete out of the spinlock would introduce
potential races between drbd_thread_setup, drbd_thread_start,
and _drbd_thread_stop, yes.

	Lars

