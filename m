Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Modifying the usermode helper program executed by DRBD
Date: Fri, 29 Jun 2007 10:47:55 +0200
References: <342BAC0A5467384983B586A6B0B3767105DEC044@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767105DEC044@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706291047.55985.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 27 June 2007 21:12:56 Graham, Simon wrote:
> Currently, the DRBD driver is hardcoded to execute "/sbin/drbdadm" as
> the usermode helper program - this means that it is not possible to have
> drbdadm installed in a different location or to replace it with another
> program (such as a different front end to drbdsetup).
>
>
>
> To enable this, I've created a simple patch which adds a sysfs file
> /sys/module/drbd/parameters/usermode_helper which can be updated with
> the path to the executable to be run as the usermode helper - the
> default value of this is "/sbin/drbdadm" so the default behavior is
> unchanged.
>
>

Ack, it is in. Thanks!

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
