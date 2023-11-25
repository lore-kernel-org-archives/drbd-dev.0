Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com
	[209.85.219.175])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 193B7420211
	for <drbd-dev@lists.linbit.com>; Sat, 25 Nov 2023 08:47:29 +0100 (CET)
Received: by mail-yb1-f175.google.com with SMTP id
	3f1490d57ef6-db3a09e96daso2230701276.3
	for <drbd-dev@lists.linbit.com>; Fri, 24 Nov 2023 23:47:28 -0800 (PST)
MIME-Version: 1.0
References: <CADGDV=XMD+b6iNEVih7x4FN+PCzyj0VqgrgBhUwZff+G-2_d_w@mail.gmail.com>
	<AD6A8wCfJHnR*HQ37T48hqrF.2.1700729326235.Hmail.zhengbing.huang@easystack.cn>
In-Reply-To: <AD6A8wCfJHnR*HQ37T48hqrF.2.1700729326235.Hmail.zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Sat, 25 Nov 2023 08:47:16 +0100
Message-ID: <CADGDV=WnrjNrGHwxTHHcSMZ78FTRgmeai=3o_CwpxvmwsEy0zg@mail.gmail.com>
To: =?UTF-8?B?6buE5q2j5YW1?= <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: dongsheng.yang@easystack.cn, drbd-dev@lists.linbit.com
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

Hi Zhengbing,

Lars and I came up with this:

commit e31d63966fac73fc000b584ccb2580016eccda17
Author: Philipp Reisner <philipp.reisner@linbit.com>
Date:   Thu Nov 23 06:31:28 2023 +0100

   drbd: fix susp_uuid clearing

   I introduced susp_uuid for keeping a resource longer suspended for
   writing a new current-uuid.
   But in the following scenario, it failed to clear the susp_uuid bit:

    1. The network connection between a primary and secondary node
       fails. The primary has the setting quorum=3D2. IO freezes on the
       primary node.

    2. The user changes the quorum setting from 2 to one. The primary
       node generates a new current-uuid and clears the susp_uuid bit in
       a second state change.

    3. If, during the second state change, another condition for creating
       a new current UUID evaluates to true, the code fails to clear the
       suspen_uuid bit.

   Fixing this in three places:
    1. in sanitize_state(): Only set susp_uuid[NEW] if susp_uuid[OLD]
       was not set. That avoids it happening a second time after
       one iteration.

    2. in w_after_state_chage(): Always end the cycle by setting clearing
       susp_uuid[NEW] if it is set. (Independently of susp_uuid[OLD].

    3. in finish_sate_change(): Do not set NEW_CUR_UUID again if we are
       in this operation.

   Strictly speaking, (2) is unnecessary after (1), but I also do it
   since it shortens the code. Also, (3) alone would fix the issue.

   Fixes: d47f7456ab ("drbd: create new UUID before resuming IO upon
   regaining quorum")

   Co-developed-by: zhengbing.huang <zhengbing.huang@easystack.cn>
   Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index e35150340..b884bb622 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -2353,7 +2353,8 @@ static void sanitize_state(struct drbd_resource *reso=
urce)
       resource->susp_quorum[NEW] =3D
               resource->res_opts.on_no_quorum =3D=3D ONQ_SUSPEND_IO ?
!resource_has_quorum : false;

-       if (resource_is_suspended(resource, OLD) &&
!resource_is_suspended(resource, NEW)) {
+       if (!resource->susp_uuid[OLD] &&
+           resource_is_suspended(resource, OLD) &&
!resource_is_suspended(resource, NEW)) {
               idr_for_each_entry(&resource->devices, device, vnr) {
                       if (test_bit(NEW_CUR_UUID, &device->flags)) {
                               resource->susp_uuid[NEW] =3D true;
@@ -2553,6 +2554,7 @@ static bool should_try_become_up_to_date(struct
drbd_device *device, enum drbd_d
static void finish_state_change(struct drbd_resource *resource, const char =
*tag)
{
       enum drbd_role *role =3D resource->role;
+       bool *susp_uuid =3D resource->susp_uuid;
       struct drbd_device *device;
       struct drbd_connection *connection;
       bool starting_resync =3D false;
@@ -2828,7 +2830,10 @@ static void finish_state_change(struct
drbd_resource *resource, const char *tag)
               if (role[OLD] =3D=3D R_SECONDARY && role[NEW] =3D=3D R_PRIMA=
RY)
                       create_new_uuid =3D true;

-               if (create_new_uuid)
+               /* When susp_uuid goes from true to false, we just created =
a new
+                * current-uuid, it is pointless to do this one more time
+                */
+               if (create_new_uuid && !(susp_uuid[OLD] && !susp_uuid[NEW])=
)
                       set_bit(__NEW_CUR_UUID, &device->flags);

               if (disk_state[NEW] !=3D D_NEGOTIATING &&
get_ldev_if_state(device, D_DETACHING)) {
@@ -4189,7 +4194,7 @@ static int w_after_state_change(struct drbd_work
*w, int unused)
                       still_connected =3D true;
       }

-       if (!susp_uuid[OLD] && susp_uuid[NEW]) {
+       if (susp_uuid[NEW]) {
               unsigned long irq_flags;

               begin_state_change(resource, &irq_flags, CS_VERBOSE);

On Thu, Nov 23, 2023 at 9:48=E2=80=AFAM =E9=BB=84=E6=AD=A3=E5=85=B5 <zhengb=
ing.huang@easystack.cn> wrote:
>
> Hi Philipp,
>
> Such modifications may cause new problems.
>
>  If, during the second state change,  the NEW_CUR_UUID flag was not clear=
ed.
>  clears the susp_uuid bit in a  thirdly state change.
>
> Eventually, it becomes an endless cycle.
>
> So, is it possible to add the following modifications=EF=BC=9A
>
> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> index 2fbd0b1..6bd6431 100644
> --- a/drbd/drbd_state.c
> +++ b/drbd/drbd_state.c
> @@ -3938,9 +3938,13 @@ static int w_after_state_change(struct drbd_work *=
w, int unused)
>                                 drbd_maybe_khelper(device, connection, "d=
isconnected");
>                 }
>
> -               if (!susp_uuid[OLD] && susp_uuid[NEW] &&
> -                   test_and_clear_bit(NEW_CUR_UUID, &device->flags))
> -                       new_current_uuid =3D true;
> +               if (susp_uuid[NEW]) {
> +                       if (susp_uuid[OLD])
> +                               clear_bit(NEW_CUR_UUID, &device->flags);
> +                       else if (test_and_clear_bit(NEW_CUR_UUID, &device=
->flags))) {
> +                               new_curr_uuid =3D true;
> +                       }
> +               }
>
>                 if (new_current_uuid)
>                         drbd_uuid_new_current(device, false);
>
> best regards,
> Zhengbing
>
>
>
>
>
> From: Philipp Reisner <philipp.reisner@linbit.com>
> Date: 2023-11-23 14:06:30
> To:  "zhengbing.huang" <zhengbing.huang@easystack.cn>
> Cc:  drbd-dev@lists.linbit.com,joel.colledge@linbit.com
> Subject: Re: [PATCH] drbd: when change susp_uuid[NEW] to true, make sure =
susp_uuid[OLD] is false>Hello Zhengbing,
> >
> >Thank you for pointing this out. I created a little bit different patch.
> >First, the sanitize_state() function should clean up the new state,
> >but I think it should never change the old state.
> >It can not rewrite history.
> >Second, we do not want to create two new current-uuids while I/O is froz=
en.
> >
> >    drbd: fix susp_uuid clearing
> >
> >   I introduced susp_uuid for keeping a resource longer suspended for
> >   writing a new current-uuid.
> >   But in the following scenario, it failed to clear the susp_uuid bit:
> >
> >    1. The network connection between a primary and secondary node
> >    fails. The primary has the setting quorum=3D2. IO freezes on the
> >    primary node.
> >
> >    2. The user changes the quorum setting from 2 to one. The primary
> >    node generates a new current-uuid and clears the susp_uuid bit in a
> >    second state change.
> >
> >    3. If, during the second state change, another condition for creatin=
g
> >    a new current UUID evaluates to true, the code fails to clear the
> >    suspen_uuid bit.
> >
> >   The second attempt to create a new current-uuid gets ignored since it
> >   is pointless to create two current-uuids while I/O is frozen.
> >
> >   Fixes: d47f7456ab ("drbd: create new UUID before resuming IO upon
> >   regaining quorum")
> >
> >   Co-developed-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> >
> >diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> >index e35150340..316d3fd39 100644
> >--- a/drbd/drbd_state.c
> >+++ b/drbd/drbd_state.c
> >@@ -4189,7 +4189,7 @@ static int w_after_state_change(struct drbd_work
> >*w, int unused)
> >                       still_connected =3D true;
> >       }
> >
> >-       if (!susp_uuid[OLD] && susp_uuid[NEW]) {
> >+       if (susp_uuid[NEW]) {
> >               unsigned long irq_flags;
> >
> >               begin_state_change(resource, &irq_flags, CS_VERBOSE);
> >
> >
> >I give this to internal review for merging.
> >
> >best regards,
> > Philipp
> >
> >
> >On Wed, Nov 22, 2023 at 4:25=E2=80=AFAM zhengbing.huang
> ><zhengbing.huang@easystack.cn> wrote:
> >>
> >> The problem scenario is as follows:
> >>
> >> 1. drbd is built on two nodes, role is primary and secondary, quorum i=
s 2.
> >>    then drbd's network fails. IO will be suspended.
> >> 2. primary modify quorum to 1, during this state change,
> >>    drbd will set susp_uuid[NEW] to true and generate a new UUID.
> >> 3. then in w_after_state_change, start the second state change,
> >>    set susp_uuid[NEW] to false. but during the second state change,
> >>    it's possible to find NEW_CUR_UUID flag was set by others.
> >>    then sanitize_state() will set susp_uuid[NEW] to true.
> >>
> >> Finally susp_uuid value is {true, true}, IO is frozen.
> >> And there is no way to set susp_uuid to false after that.
> >>
> >> So, while susp_uuid[NEW] is set to true, we want susp_uuid[OLD] to be =
false.
> >>
> >> Fixes: d47f7456ab ("drbd: create new UUID before resuming IO upon rega=
ining quorum")
> >> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> >> ---
> >>  drbd/drbd_state.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> >> index e35150340..0dedd2dae 100644
> >> --- a/drbd/drbd_state.c
> >> +++ b/drbd/drbd_state.c
> >> @@ -2356,6 +2356,7 @@ static void sanitize_state(struct drbd_resource =
*resource)
> >>         if (resource_is_suspended(resource, OLD) && !resource_is_suspe=
nded(resource, NEW)) {
> >>                 idr_for_each_entry(&resource->devices, device, vnr) {
> >>                         if (test_bit(NEW_CUR_UUID, &device->flags)) {
> >> +                               resource->susp_uuid[OLD] =3D false;
> >>                                 resource->susp_uuid[NEW] =3D true;
> >>                                 break;
> >>                         }
> >> --
> >> 2.17.1
> >>
>
>
