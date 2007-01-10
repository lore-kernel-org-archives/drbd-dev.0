Return-Path: <ard@kwaak.net>
Date: Wed, 10 Jan 2007 21:17:15 +0100
From: Ard van Breemen <ard@kwaak.net>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] drbd 2.6.19 crypto changes
Message-ID: <20070110201715.GA15730@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<200701101723.47571.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701101723.47571.philipp.reisner@linbit.com>
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
On Wed, Jan 10, 2007 at 05:23:46PM +0100, Philipp Reisner wrote:
> Here is the result of my work, maybe you can test it with a new
> kernel ? -- I only tested it on an old kernel with the old
> API.

I will test it, since my patch did nothing with hmac(%s), and I
bumped my nose just now :-). (without authentication it works at
least ;-) ).

> My idea was to have wrappers that look like the new API for the
> old kernels, and make DRBD to use the new API in the DRBD code.

Good idea. I hoped my patch just would give you an idea like
that. But you were busy anyway ;-)

> PS: In case you test it, please post the outcome.

Yes. Tonight maybe...
