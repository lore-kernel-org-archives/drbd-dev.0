Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com
	[209.85.219.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3C4F04201DD
	for <drbd-dev@lists.linbit.com>; Thu, 23 Nov 2023 07:06:42 +0100 (CET)
Received: by mail-yb1-f174.google.com with SMTP id
	3f1490d57ef6-db4422fff15so54076276.1
	for <drbd-dev@lists.linbit.com>; Wed, 22 Nov 2023 22:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20231122032510.24233-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20231122032510.24233-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu, 23 Nov 2023 06:06:30 +0000
Message-ID: <CADGDV=XMD+b6iNEVih7x4FN+PCzyj0VqgrgBhUwZff+G-2_d_w@mail.gmail.com>
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: when change susp_uuid[NEW] to true,
 make sure susp_uuid[OLD] is false
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

Hello Zhengbing,

Thank you for pointing this out. I created a little bit different patch.
First, the sanitize_state() function should clean up the new state,
but I think it should never change the old state.
It can not rewrite history.
Second, we do not want to create two new current-uuids while I/O is frozen.

    drbd: fix susp_uuid clearing

   I introduced susp_uuid for keeping a resource longer suspended for
   writing a new current-uuid.
   But in the following scenario, it failed to clear the susp_uuid bit:

    1. The network connection between a primary and secondary node
    fails. The primary has the setting quorum=3D2. IO freezes on the
    primary node.

    2. The user changes the quorum setting from 2 to one. The primary
    node generates a new current-uuid and clears the susp_uuid bit in a
    second state change.

    3. If, during the second state change, another condition for creating
    a new current UUID evaluates to true, the code fails to clear the
    suspen_uuid bit.

   The second attempt to create a new current-uuid gets ignored since it
   is pointless to create two current-uuids while I/O is frozen.

   Fixes: d47f7456ab ("drbd: create new UUID before resuming IO upon
   regaining quorum")

   Co-developed-by: zhengbing.huang <zhengbing.huang@easystack.cn>

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index e35150340..316d3fd39 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -4189,7 +4189,7 @@ static int w_after_state_change(struct drbd_work
*w, int unused)
                       still_connected =3D true;
       }

-       if (!susp_uuid[OLD] && susp_uuid[NEW]) {
+       if (susp_uuid[NEW]) {
               unsigned long irq_flags;

               begin_state_change(resource, &irq_flags, CS_VERBOSE);


I give this to internal review for merging.

best regards,
 Philipp


On Wed, Nov 22, 2023 at 4:25=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> The problem scenario is as follows:
>
> 1. drbd is built on two nodes, role is primary and secondary, quorum is 2=
.
>    then drbd's network fails. IO will be suspended.
> 2. primary modify quorum to 1, during this state change,
>    drbd will set susp_uuid[NEW] to true and generate a new UUID.
> 3. then in w_after_state_change, start the second state change,
>    set susp_uuid[NEW] to false. but during the second state change,
>    it's possible to find NEW_CUR_UUID flag was set by others.
>    then sanitize_state() will set susp_uuid[NEW] to true.
>
> Finally susp_uuid value is {true, true}, IO is frozen.
> And there is no way to set susp_uuid to false after that.
>
> So, while susp_uuid[NEW] is set to true, we want susp_uuid[OLD] to be fal=
se.
>
> Fixes: d47f7456ab ("drbd: create new UUID before resuming IO upon regaini=
ng quorum")
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_state.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> index e35150340..0dedd2dae 100644
> --- a/drbd/drbd_state.c
> +++ b/drbd/drbd_state.c
> @@ -2356,6 +2356,7 @@ static void sanitize_state(struct drbd_resource *re=
source)
>         if (resource_is_suspended(resource, OLD) && !resource_is_suspende=
d(resource, NEW)) {
>                 idr_for_each_entry(&resource->devices, device, vnr) {
>                         if (test_bit(NEW_CUR_UUID, &device->flags)) {
> +                               resource->susp_uuid[OLD] =3D false;
>                                 resource->susp_uuid[NEW] =3D true;
>                                 break;
>                         }
> --
> 2.17.1
>
