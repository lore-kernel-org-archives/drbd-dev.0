Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary
	potential patch
Date: Thu, 16 Nov 2006 10:10:25 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C826@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C826@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200611161010.25785.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 7. November 2006 00:47 schrieb Montrose, Ernest:
> When running Primary/Primary if the Heartbeat connection goes down when
> we recover we always split brain.  Simon had an idea which I have
> implemented. He is on vacation  so this may not reflect his exact idea.
>
> Essentially with this change, we do not create a new current UUID on the
> node unless I/O is seen. This prevent Split-Brain mitigation when both
> nodes are primary but only one node is originating I/O and never the
> other.  He is only stand-by in that case.
>
> Take a look and let me know.

Hi Ernest,

I understand your reasoning, I see the patch, which I guess does=20
what you expect of it.

I do not want to do it that way for the following reasons:

 * It is only applicable in case you are using a 1-node filesystem
   on a primary-primary DRBD cluster.

   * I do not want users to do this. Because with this setup it is
     easily possible to mount the FS on both nodes concurrently.
     I want to protect the from themselfs ;)

   * Users using a 1-node filesystem should use DRBD withe=20
     primary and secondary role.

 * I rather want to fix DRBD's split brain recovery methods to deal
   with a cluster crash of a primary-primary cluster (actually this
   is item 41 in the ROADMAP file)

I have a few hours time today, I will work on this today...=20

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
