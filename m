Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com
	[209.85.219.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D9F6E420167
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 11:11:04 +0200 (CEST)
Received: by mail-yb1-f179.google.com with SMTP id
	3f1490d57ef6-dfdb6122992so307276276.3
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 02:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 28 Jun 2024 11:10:52 +0200
Message-ID: <CADGDV=Xo6Z_K2R8vB7+7_jf0U_im0Nmy-xQ36AYh59qi45EvAQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] drbd_nl: dont allow detating to be inttrupted in
	waiting D_DETACHING to DISKLESS
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello Dongsheng,

First of all, thanks for contributing patches to us.
Please find my reply on the patch below the quote:

On Mon, Jun 24, 2024 at 7:52=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>
> In our network failure and drbd down testing, we found warning in dmesg a=
nd drbd down process into D state:
>
> "kernel: drbd /unregistered/ramtest3/0 drbd103: ASSERTION device->disk_st=
ate[NOW] =3D=3D D_FAILED || device->disk_state[NOW] =3D=3D D_DETACHING FAIL=
ED in go_diskless"
>
> the problem is the wait_event is inttruptable, it could be intrupted by s=
ignal and call drbd_cleanup_device before go_diskless()
>

In this case, I suggest improving the expression in the assertion.
Improving an assertion can also mean removing that assertion.

The wait_event_interruptible() is there for a reason. Think of a
backing disk that behaves like a tar pit=E2=80=94a backing device that no
longer finishes IO requests. You want a way to interrupt the drbdsetup
waiting in detach.

PS: A bit more elaborative commit messages are welcome.

best regards,
 Philipp
