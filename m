Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Julia Lawall <julia@diku.dk>
Date: Mon, 17 May 2010 23:41:53 +0200
References: <Pine.LNX.4.64.1005132202040.6282@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1005132202040.6282@ask.diku.dk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005172341.53214.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 10/20] drivers/block/drbd: Use kzalloc
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag 13 Mai 2010 22:02:21 schrieb Julia Lawall:
> From: Julia Lawall <julia@diku.dk>
> 
> Use kzalloc rather than the combination of kmalloc and memset.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 

Hi Julia,

I applied the patch to our tree here. Will go upstream soon.

Best,
 Phil
