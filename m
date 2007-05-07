Return-Path: <stf_xl@wp.pl>
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] [PATCH] dynamic creation/removal more then 256 drbd
	devices
Date: Mon, 7 May 2007 09:20:49 +0200
References: <200704271121.44336.stf_xl@wp.pl> <200705041336.33032.stf_xl@wp.pl>
	<200705041444.35189.philipp.reisner@linbit.com>
In-Reply-To: <200705041444.35189.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200705070920.49401.stf_xl@wp.pl>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Friday 04 May 2007 14:44, Philipp Reisner wrote:
> But in case I had an application that is in the need for
> many block devices (e.g. a farm of kvm or xen instances...)
> I would put a LVM VG on top of a singe DRBD device.
IMHO creating drbd on top lv's is more flexible then creating vg on top
of drbd, however this depend on overall system design and needs.  

> My question is more like: What was your motivation for doing
> this patch ?
Well, my boss want me to do it. My company provide linux based software to 
storage servers and some client wont it. 

-- 
Cheers
Stanislaw Gruszka
