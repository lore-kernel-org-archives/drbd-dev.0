Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: ASSERT( mdev->bc->md.uuid[Bitmap] == 0 ) in
	drbd_main.c:drbd_uuid_new_current()
Date: Wed, 1 Aug 2007 17:07:50 +0200
References: <BD7042533C2F8943A6A4257A9E31C454F4799D@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F4799D@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708011707.51055.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 31 July 2007 23:18:05 Montrose, Ernest wrote:
> Hi all,
> We are seeing another problem that occurs with the following sequence of
> events:
> drbdadm secondary vm2.root.fs
> drbdadm detach vm2.root.fs
> drbdadm primary vm2.root.fs
> drbdadm secondary vm2.root.fs
> drbdadm primary vm2.root.fs <----- This causes the assert
> drbdadm attach vm2.root.fs  <------ This causes an instant Split brain
> but only because of the assert above.
>
> I think what's happening is that we are generating a new bitmap UUID
> every time the diskless peer goes Primary.
> I see no reason why we have to do this more then once.  I include a tiny
> patch to do it just one time.
>

You are absolutely right.

http://lists.linbit.com/pipermail/drbd-cvs/2007-August/001612.html

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
