Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Date: Mon, 26 Sep 2005 11:39:54 +0200
References: <20050922132016.GE5593@marowsky-bree.de>
	<200509221524.22929.philipp.reisner@linbit.com>
	<20050923131614.GD25085@marowsky-bree.de>
In-Reply-To: <20050923131614.GD25085@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200509261139.55473.philipp.reisner@linbit.com>
Cc: drbd-user@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: [DRBD-user] Retrieving the inconsistent + local disk
	state
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 23. September 2005 15:16 schrieb Lars Marowsky-Bree:
> On 2005-09-22T15:24:22, Philipp Reisner <philipp.reisner@linbit.com> wrot=
e:
> > Could you describe in more detail what you going to do there?
> > Where can we find out more about the master/slave-support of heartbeat?
>
> BTW, an almost complete draft looks something like
> http://cvs.linux-ha.org/viewcvs/viewcvs.cgi/linux-ha/resources/OCF/drbd.i=
n?
>rev=3DHEAD&view=3Dmarkup
>
>

Hmm, ok I think I have a vague idea, what this is about. I will implement
a kind of "dstate" command... It will be ready at the time of Linux-Kongres=
s.

DRBD v8 only of course.

Will you be at the Kongress in Hamburg ?=20

=2DPhilpp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
