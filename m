Return-Path: <robert.altnoeder@linbit.com>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A856B1011BFC
	for <drbd-dev@lists.linbit.com>; Fri, 14 Jun 2019 11:56:15 +0200 (CEST)
Received: by mail-wm1-f65.google.com with SMTP id c6so1679552wml.0
	for <drbd-dev@lists.linbit.com>; Fri, 14 Jun 2019 02:56:15 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:2d96:e1e8:3a99:3414?
	([2001:858:107:1:2d96:e1e8:3a99:3414])
	by smtp.gmail.com with ESMTPSA id x8sm3425737wmc.5.2019.06.14.02.49.39
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 14 Jun 2019 02:49:39 -0700 (PDT)
To: drbd-dev@lists.linbit.com
References: <e9d5ec6e-30e9-9af1-06c3-bcf8b1d92068@gmail.com>
	<20190612141149.GA5803@soda.linbit>
From: Robert Altnoeder <robert.altnoeder@linbit.com>
Message-ID: <83e97127-9511-7899-e9e4-2b44a7932661@linbit.com>
Date: Fri, 14 Jun 2019 11:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190612141149.GA5803@soda.linbit>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Drbd-dev] avoid use of errno as a function parameter name
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

On 6/12/19 4:11 PM, Lars Ellenberg wrote:
> On Wed, Jun 05, 2019 at 10:14:19AM -0600, David Butterfield wrote:
>> Avoid use of errno as an argument name because it is allowed to be a macro such as
>>     # define errno (*__errno_location ())
> You do realize that we are kernel code...

I guess that's a request related to his fork of DRBD which was modified
to run in user mode.

@David:
Only changing errno to _errno to fix this is probaby not the best idea,
so if we're going to change this, then I'd rather use a new variable
name that does not even suggest being related to errno, otherwise
whoever sees it the next time might be tempted to change it back to errno.

While I'm at it, I am wondering a bit about the modification of DRBD to
run in usermode. It's not that I couldn't see a whole lot of reasons why
you'd want to do this, quite the opposite, but I believe it would make a
lot more sense if you did that on top of a true microkernel OS such as
e.g. Minix, seL4, Integrity or QNX. That might even turn the whole thing
into a very useful project, as such a port of DRBD might be interesting
for use in e.g. embedded systems running those OSs.

Cheers,
Robert

