Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 18 Aug 2009 22:50:26 +0200
References: <FF5EE638-446A-46F9-A920-7FBFD3B22959@computer.org>
In-Reply-To: <FF5EE638-446A-46F9-A920-7FBFD3B22959@computer.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908182250.26776.philipp.reisner@linbit.com>
Cc: Anthony D'Ambrosio <anthony_d@computer.org>
Subject: Re: [Drbd-dev] Fix for patch-kernl in scripts directory
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 31. Juli 2009 22:33:33 schrieb Anthony D'Ambrosio:
> Hi,
>
> I have been using DRBD for about 5 years now and think you folks have
> done some great work.  We recently have been working an a new base
> distribution of our OS and I ran into a problem while trying to build
> DRBD into a kernel.
[...]
> Please tell me if you need more, or if I should supply this type of
> information in the future in some other manner.
>
> Thanks for the excellent software - it works like a champ for us!
>

Hi Anthony,

Sorry about the unresponsiveness on drbd-dev. There is such so
low traffic on the list...

That patch-kernel method came out of focus. We aim to get
DRBD merged to Linux upstream with the 2.6.32 release.
You can track out integration work from here:

git://git.drbd.org/linux-2.6-drbd.git

-Phil
