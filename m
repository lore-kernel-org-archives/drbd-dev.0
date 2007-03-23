Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd-8.0.1 add dependencies to Kconfig
Date: Fri, 23 Mar 2007 14:40:08 +0100
References: <45F82D67.2030105@ru.mvista.com>
In-Reply-To: <45F82D67.2030105@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200703231440.08564.philipp.reisner@linbit.com>
Cc: Maxim Uvarov <muvarov@ru.mvista.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 14. M=E4rz 2007 18:14 schrieb Maxim Uvarov:
> Hello all,
>
> I have suggestion to add dependencies on CRYPTO and CONNECTOR to the
> drbr patches
> to avoid compilation errors due to wrong configuration.
> What do you think about it? Patches for drbd-8.0.1 are bellow:
>
> Best regards,
> Max Uvarov.
>
>
> --- drbd/Kconfig        2006-11-20 23:05:03.000000000 +0300
> +++ drbd/Kconfig_new    2007-03-13 19:42:12.000000000 +0300
> @@ -5,6 +5,9 @@
>         tristate "DRBD Distributed replicated block device support"
>         select INET
>         select PROC_FS
> +       select CRYPTO
> +       select CRYPTO_HMAC
> +       select CONNECTOR
>         ---help---
>           Drbd is a block device which is designed to build high
> availability
>           clusters.  This is done by mirroring a whole block device via (a
>


The "select CONNECTOR" is already there, got in after 8.0.1 was released.
DRBD should actually compile without the Crypto stuff ( I have not
verified this in therecent time ). Then the shared secret based
connection authentification is simply not available.
>
> -ifndef CONFIG_CONNECTOR
> -       drbd-objs +=3D connector.o cn_queue.o
> -endif
> -
> obj-$(CONFIG_BLK_DEV_DRBD)     +=3D drbd.o


We will keep that part, because it is possible to use DRBD on=20
early Linux-2.6.x kernels that did not had the connector in the
main tree.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
