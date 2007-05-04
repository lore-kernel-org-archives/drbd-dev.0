Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] dynamic creation/removal more then 256 drbd
	devices
Date: Fri, 4 May 2007 11:06:40 +0200
References: <200704271121.44336.stf_xl@wp.pl>
In-Reply-To: <200704271121.44336.stf_xl@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705041106.40989.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 27. April 2007 11:21 schrieb Stanislaw Gruszka:
> Hallo,
>
> I did patch for dynamic creation/removal drbd devices.
> Drbd have already dynamic drbd creation, but no removal.
> Also my patch breaks limit of 256 drbd devices - linked list
> is used for keeping devices; minor_table is removed,
> idr structure form include/linux/idr.h is used instead.
> Please comment. Is there a chance it will be applied?
>
> Patch is divided into 2 parts: kernel and user space.

Hi Stanislaw,

We are just looking at the patch and are wondering why one
would like to have more than 256 devices ?


-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
