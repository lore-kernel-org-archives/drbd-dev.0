Return-Path: <ard@kwaak.net>
Date: Tue, 16 Jan 2007 11:37:49 +0100
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Message-ID: <20070116103749.GD9639@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
	<200701151806.20526.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701151806.20526.philipp.reisner@linbit.com>
From: Ard van Breemen <ard@kwaak.net>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,
On Mon, Jan 15, 2007 at 06:06:20PM +0100, Philipp Reisner wrote:
> Although I can not reproduce this crash here, I was able to trigger
> "LOGIC BUG" Messages, by finishing the resync by by application-IO...

I will try it.
It seems to happen if I do this:
- create a raidset at the primary, create a raidset at the
secondary.
- create the drbd device on top of that
- designate the primary primary.

After a while the secondary oopses.

-- 
begin  LOVE-LETTER-FOR-YOU.txt.vbs
I am a signature virus. Distribute me until the bitter
end
