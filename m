Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] dynamic creation/removal more then 256 drbd
	devices
Date: Fri, 4 May 2007 14:44:34 +0200
References: <200704271121.44336.stf_xl@wp.pl>
	<200705041106.40989.philipp.reisner@linbit.com>
	<200705041336.33032.stf_xl@wp.pl>
In-Reply-To: <200705041336.33032.stf_xl@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705041444.35189.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 4. Mai 2007 13:36 schrieb Stanislaw Gruszka:
> On Friday 04 May 2007 11:06, Philipp Reisner wrote:
> > We are just looking at the patch and are wondering why one
> > would like to have more than 256 devices ?
>
> Philipp,
>
> With LVM it is possible to create many logical volumes.
> One may want to create a lot of (small) logical volumes and
> use them as backing devices for drbd for replication
> to some hosts with also a lot of logical volumes.
> Now drbd have flexible meta data so replication of
> small size block devices have sense. Someone may want to
> make replication on many small devices.


Yes of course.

But in case I had an application that is in the need for
many block devices (e.g. a farm of kvm or xen instances...)
I would put a LVM VG on top of a singe DRBD device.

My question is more like: What was your motivation for doing
this patch ?

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
