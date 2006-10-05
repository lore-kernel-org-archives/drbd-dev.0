Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] local-io-error parse error in drbd.conf
Date: Thu, 5 Oct 2006 09:03:50 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C7F5@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Phil,
OK I was not very clear.  It was a little late in the day so forgive me. =
Here are the details:

In /etc/drbd.conf I set:
handlers{
local-io-error "echo 0> /proc/sysrq-trigger; halt -f";
}

In disk I just have:
Disk{
on-io-error detach;
}

If I now do a "drbdadm -d state all" for example I get:
/etc/drbd.conf:31: Parse eror: 'an option keyword' expected,
 but got 'local-io-error'.

It seems like the implementation is in the driver but not in =
drbdsetup(1).

Thanks.

EM--
-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com] =
On Behalf Of Philipp Reisner
Sent: Thursday, October 05, 2006 4:51 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] local-io-error parse error in drbd.conf

Am Mittwoch, 4. Oktober 2006 21:21 schrieb Montrose, Ernest:
> Hi,
> Is this configuration key word fully implemented yet?  It causes a =
parse
> error for now.
>

Hi Ernest,

I do not understand the question, I guess you mean:

  disk {
    on-io-error   detach;
  }

And drbdsetup tells us, that it will accept...

[root@wurzel:~]# drbdsetup help disk
USAGE:
 disk lower_dev meta_data_dev meta_data_index [{--size|-d} 0 ... =
8587575296]
     [{--on-io-error|-e} pass_on call-local-io-error detach]
     [{--fencing|-f} dont-care resource-only resource-and-stonith]=20
[{--use-bmbv|-b}]

pass_on, call-local-io-error or detach as values for on-io-error.

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
