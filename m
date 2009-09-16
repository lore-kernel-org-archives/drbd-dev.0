Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Wed, 16 Sep 2009 11:19:35 +0200
References: <200909151645.14256.philipp.reisner@linbit.com>
	<20090916094421.DB8F.A69D9226@jp.fujitsu.com>
In-Reply-To: <20090916094421.DB8F.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200909161119.36565.philipp.reisner@linbit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 16 September 2009 02:46:34 KOSAKI Motohiro wrote:
> > Hi Linus,
> >
> > Please pull
> > git://git.drbd.org/linux-2.6-drbd.git drbd
> >
> > DRBD is a shared-nothing, replicated block device. It is designed to
> > serve as a building block for high availability clusters and
> > in this context, is a "drop-in" replacement for shared storage.
> >
> > It has been discussed and reviewed on the list since March,
> > and Andrew has asked us to send a pull request for 2.6.32-rc1.
> >
> > Stephen added us to linux-next in July, and our most recent
> > build failure against Jens' 2.6.32-rc1 updates was ironed out this
> > morning. So it should be in fairly good shape.
>
> I'm sorry for my delayed pointing out.
> if anyone add new feature, its Kconfig default parameter should be N.
>
> but AFAIK, DRBD use M. I hope you change it. At least, typical desktop user
> don't use DRBD.
>
> Thanks.

Ok. I have changed the default to N.

-Phil

