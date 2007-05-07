Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] dynamic creation/removal more then 256 drbd
	devices
Date: Mon, 7 May 2007 13:32:41 +0200
References: <200704271121.44336.stf_xl@wp.pl>
	<200705041444.35189.philipp.reisner@linbit.com>
	<200705070920.49401.stf_xl@wp.pl>
In-Reply-To: <200705070920.49401.stf_xl@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705071332.41836.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 07 May 2007 09:20:49 Stanislaw Gruszka wrote:
> On Friday 04 May 2007 14:44, Philipp Reisner wrote:
> > But in case I had an application that is in the need for
> > many block devices (e.g. a farm of kvm or xen instances...)
> > I would put a LVM VG on top of a singe DRBD device.
>
> IMHO creating drbd on top lv's is more flexible then creating vg on top
> of drbd, however this depend on overall system design and needs.
>
> > My question is more like: What was your motivation for doing
> > this patch ?
>
> Well, my boss want me to do it. My company provide linux based software to
> storage servers and some client wont it.

Hi Stanislaw,

I will review and commit your stuff to SVN soon after the 8.0.3 
release. I.e. you patch will probably be included in the 8.0.4 release.

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
