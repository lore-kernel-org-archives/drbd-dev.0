Return-Path: <btimby@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B752108714D
	for <drbd-dev@lists.linbit.com>; Thu, 27 May 2010 16:14:42 +0200 (CEST)
Received: by fxm18 with SMTP id 18so20519fxm.38
	for <drbd-dev@lists.linbit.com>; Thu, 27 May 2010 07:14:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100527090125.GC26213@soda.linbit>
References: <AANLkTim66dldWydThtZraIL6dqzVn0lxB1Q_chcOkkaa@mail.gmail.com>
	<20100527090125.GC26213@soda.linbit>
Date: Thu, 27 May 2010 10:14:42 -0400
Message-ID: <AANLkTimujV7rnDws-Mhvnba7nuIht2GyTC8pGCN63H9i@mail.gmail.com>
From: Ben Timby <btimby@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] DRBD + DM = EIO.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars, you rock! That fixes my problem. However...

I still get read error -5 warnings in my messages:

May 27 09:56:03 ragoon6 kernel: block drbd1: p read: error=3D-5
May 27 09:59:48 ragoon6 last message repeated 26 times
May 27 09:59:49 ragoon6 last message repeated 146 times

drbd_worker.c:
--
       BIO_ENDIO_FN_START;
        if (error)
                dev_warn(DEV, "p %s: error=3D%d\n",
                         bio_data_dir(bio) =3D=3D WRITE ? "write" : "read",=
 error);
        if (!error && !uptodate) {
                dev_warn(DEV, "p %s: setting error to -EIO\n",
                         bio_data_dir(bio) =3D=3D WRITE ? "write" : "read")=
;
                /* strange behavior of some lower level drivers...
                 * fail the request by clearing the uptodate flag,
                 * but do not return any error?! */
                error =3D -EIO;
        }
--

error =3D=3D -5 at the beginning of this block. At least in my kernel,
there is code in dm.c that translates a missing BIO_UPTODATE flag to
EIO. Judging by the similar code and comment, this was not always the
case?

Anyway, I can live with the warnings, but you might want to silence
them with another patch...

Thanks for your reply!

On Thu, May 27, 2010 at 5:01 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:
> You most likely hit
> http://git.drbd.org/?p=3Ddrbd-8.3.git;a=3Dcommitdiff;h=3D7fda00aacaf77225=
3167d4ddb1eaa847862d6332;hp=3D3d36021c59c09e2bf37b82204b0df556de03ec0d
>
> =A0:(
>
> What is missing from that commit message is that a "failed"
> (intentionally not served) READA will be considered
> a real local IO error and cause DRBD to detach.
>
> Hth,
