Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com
	[209.85.219.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 44DA84201CD
	for <drbd-dev@lists.linbit.com>; Fri,  8 Dec 2023 09:18:12 +0100 (CET)
Received: by mail-yb1-f181.google.com with SMTP id
	3f1490d57ef6-daf26d84100so1955790276.3
	for <drbd-dev@lists.linbit.com>; Fri, 08 Dec 2023 00:18:12 -0800 (PST)
MIME-Version: 1.0
References: <CADGDV=WC7pD1qpNuCPYGgk99UFvfZ5rgZdf8vQcPat38R3GNkg@mail.gmail.com>
	<ABMASABYJKDksTjgo0yv8KrG.2.1701954877954.Hmail.zhengbing.huang@easystack.cn>
In-Reply-To: <ABMASABYJKDksTjgo0yv8KrG.2.1701954877954.Hmail.zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 8 Dec 2023 09:17:50 +0100
Message-ID: <CADGDV=W2LqOsuRJjow1wD0LdOnr8UqZOQGqsDnwZM7EBRWVYbQ@mail.gmail.com>
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

Hello Zhengbing,

You are right! Thank you for being so persistent.
Do you want to send a patch formatted with git send-email that fixes
the condition as you suggested in your e-mail from Nov 27?

Otherwise, I will commit it in your name on Monday.

best regards,
 Phil

On Thu, Dec 7, 2023 at 2:14=E2=80=AFPM =E9=BB=84=E6=AD=A3=E5=85=B5 <zhengbi=
ng.huang@easystack.cn> wrote:
>
>
> Hi Philipp,
>
> Under the new condition, if the value of susp_uuid is {true, true}, the c=
ondition returns true.
>
> -               if (create_new_uuid)
> +               /* When susp_uuid goes from true to false, we just create=
d a new
> +                * current-uuid, it is pointless to do this one more time
> +                */
> +               if (create_new_uuid && !(susp_uuid[OLD] && !susp_uuid[NEW=
]))
>                        set_bit(__NEW_CUR_UUID, &device->flags);
>
> if create_new_uuid is true, and susp_uuid is {true, true}, the condition =
is satisfied.
> __NEW_CUR_UUID will be set.
>
> best regards,
> Zhengbing
>
>
>
> From: Philipp Reisner <philipp.reisner@linbit.com>
> Date: 2023-12-07 13:35:28
> To:  "=E9=BB=84=E6=AD=A3=E5=85=B5" <zhengbing.huang@easystack.cn>
> Cc:  dongsheng.yang@easystack.cn,drbd-dev@lists.linbit.com,Lars Ellenberg=
 <lars.ellenberg@linbit.com>
> Subject: Re: Re: Re: [PATCH] drbd: when change susp_uuid[NEW] to true, ma=
ke sure susp_uuid[OLD] is false>Hello Zhengbing,
> >
> >no, I disagree. The code is good as it is since commit e31d63966fac73fc0=
00b.
> >
> >Here is my explanation:
> >
> >IO is frozen because the resource lost quorum. The user changes the conf=
ig
> >and reduces the quorum setting to 1.
> >
> >The regular sequence is:
> >
> >1. in sanitize_state()
> >   susp_uuid =3D { false, true }
> >   DRBD keeps the resource suspended longer.
> >
> >2. in finish_state_change()
> >   it sets __NEW_CUR_UUIC and that moves to NEW_CUR_UUID later.
> >
> >   in w_after_state_change()
> >3a when susp_uuid goes from false -> true then drbd_uuid_new_current()
> >3b Trigger another state change that sets susp_uuuid[NEW] back to false.
> >
> >1. sanitize_sate()    susp_uuid =3D { true, false }
> >2. in finish_state_change() nothing relevant happens
> >3a no positive edge on susp_uuid no NEW_CUR_UUID bit nothing happens
> >3b susp_uuid[NEW] =3D=3D false -> nothing happens
> >
> >
> >Now let us assume between 3a and 3b, another CPU does an unrelated
> >state change that usually triggers a new current uuid:
> >
> >CPU0:
> >1. in sanitize_state()
> >   susp_uuid =3D { false, true }
> >   DRBD keeps the resource suspended longer.
> >
> >2. in finish_state_change()
> >   it sets __NEW_CUR_UUIC and that moves to NEW_CUR_UUID later.
> >
> >   in w_after_state_change()
> >3a when susp_uuid goes from false -> true
> >   drbd_uuid_new_current()
> >
> >    CPU1:
> >    Here, another thread starts another unrelated state change
> >    that again wants to set NEW_CUR_UUID. But let us go into the details=
.
> >
> >    1. in sanitize_state() susp_uuid =3D { true, true }
> >    2. in finish_state_chanage() it does _NOT_ set __NEW_CUR_UUID
> >       because the condition only allows it, when we have a
> >       positive edge on susp_uuid (=3D susp_uuid =3D { false, true })
> >       But this time, it is susp_uuid =3D { true, true }. No edge.
> >       so __NEW_CUR_UUID stays 0 -> NEW_CUR_UUID stays 0
> >    3a nothing, since no NEW_CUR_UUID
> >    3b creates a state change to set susp_uuid[NEW] to false
> >
> >CPU: continues with w_after_state()
> >3b Trigger another state change that sets susp_uuuid[NEW] back to false.
> >   This is an "empty state change" as it is false and does nothing.
> >
> >
> >I think you have a mistake in your reasoning at T3.
> >
> >best regards,
> > Philipp
> >
> >On Mon, Nov 27, 2023 at 3:48=E2=80=AFPM =E9=BB=84=E6=AD=A3=E5=85=B5 <zhe=
ngbing.huang@easystack.cn> wrote:
> >>
> >> Hi Philipp,
> >>
> >>
> >> The third point about modification is that it may not cover all scenar=
ios.
> >>
> >> In w_after_state_change(), between generating the new current_uuid and
> >> clearing the susp_uuid, it is possible that another thread set the __N=
EW_CUR_UUID flag.
> >>
> >> The problem scenario is as follows:
> >>
> >> T1:
> >> begin_state_change()
> >> end_state_change()
> >>   __end_state_change()
> >>     ___end_state_change()
> >>     # susp_uuid value is {True, True}
> >>       T2: w_after_state_change()
> >>             drbd_uuid_new_current()
> >>
> >>                                                                       =
        T3:
> >>                                                                       =
              begin_state_change()
> >>                                                                       =
              # set __NEW_CUR_UUID flag
> >>                                                                       =
              end_state_change()
> >>
> >>             begin_state_change()
> >>             # set susp_uuid[NEW] =3D False
> >>             end_state_change()
> >>
> >> In the end, the NEW_CUR_UUID flag bit is generated and not cleaned up.
> >>
> >> Therefore, the third point about modification can be change to this:
> >>
> >> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> >> index e35150340..2101c0ebc 100644
> >> --- a/drbd/drbd_state.c
> >> +++ b/drbd/drbd_state.c
> >> @@ -2553,6 +2553,7 @@ static bool should_try_become_up_to_date(struct =
drbd_device *device, enum drbd_d
> >>  static void finish_state_change(struct drbd_resource *resource, const=
 char *tag)
> >>  {
> >>         enum drbd_role *role =3D resource->role;
> >> +       bool *susp_uuid =3D resource->susp_uuid;
> >>         struct drbd_device *device;
> >>         struct drbd_connection *connection;
> >>         bool starting_resync =3D false;
> >> @@ -2828,7 +2829,7 @@ static void finish_state_change(struct drbd_reso=
urce *resource, const char *tag)
> >>                 if (role[OLD] =3D=3D R_SECONDARY && role[NEW] =3D=3D R=
_PRIMARY)
> >>                         create_new_uuid =3D true;
> >>
> >> -               if (create_new_uuid)
> >> +               if (create_new_uuid && !susp_uuid[OLD])
> >>                         set_bit(__NEW_CUR_UUID, &device->flags);
> >>
> >>                 if (disk_state[NEW] !=3D D_NEGOTIATING && get_ldev_if_=
state(device, D_DETACHING)) {
> >>
> >> best regards,
> >> Zhengbing
> >>
> >>
> >>
> >>
> >>
> >> From: Philipp Reisner <philipp.reisner@linbit.com>
> >> Date: 2023-11-25 15:47:16
> >> To:  "=E9=BB=84=E6=AD=A3=E5=85=B5" <zhengbing.huang@easystack.cn>
> >> Cc:  dongsheng.yang@easystack.cn,drbd-dev@lists.linbit.com
> >> Subject: Re: Re: [PATCH] drbd: when change susp_uuid[NEW] to true, mak=
e sure susp_uuid[OLD] is false>Hi Zhengbing,
> >> >
> >> >Lars and I came up with this:
> >> >
> >> >commit e31d63966fac73fc000b584ccb2580016eccda17
> >> >Author: Philipp Reisner <philipp.reisner@linbit.com>
> >> >Date:   Thu Nov 23 06:31:28 2023 +0100
> >> >
> >> >   drbd: fix susp_uuid clearing
> >> >
> >> >   I introduced susp_uuid for keeping a resource longer suspended for
> >> >   writing a new current-uuid.
> >> >   But in the following scenario, it failed to clear the susp_uuid bi=
t:
> >> >
> >> >    1. The network connection between a primary and secondary node
> >> >       fails. The primary has the setting quorum=3D2. IO freezes on t=
he
> >> >       primary node.
> >> >
> >> >    2. The user changes the quorum setting from 2 to one. The primary
> >> >       node generates a new current-uuid and clears the susp_uuid bit=
 in
> >> >       a second state change.
> >> >
> >> >    3. If, during the second state change, another condition for crea=
ting
> >> >       a new current UUID evaluates to true, the code fails to clear =
the
> >> >       suspen_uuid bit.
> >> >
> >> >   Fixing this in three places:
> >> >    1. in sanitize_state(): Only set susp_uuid[NEW] if susp_uuid[OLD]
> >> >       was not set. That avoids it happening a second time after
> >> >       one iteration.
> >> >
> >> >    2. in w_after_state_chage(): Always end the cycle by setting clea=
ring
> >> >       susp_uuid[NEW] if it is set. (Independently of susp_uuid[OLD].
> >> >
> >> >    3. in finish_sate_change(): Do not set NEW_CUR_UUID again if we a=
re
> >> >       in this operation.
> >> >
> >> >   Strictly speaking, (2) is unnecessary after (1), but I also do it
> >> >   since it shortens the code. Also, (3) alone would fix the issue.
> >> >
> >> >   Fixes: d47f7456ab ("drbd: create new UUID before resuming IO upon
> >> >   regaining quorum")
> >> >
> >> >   Co-developed-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> >> >   Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> >> >
> >> >diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> >> >index e35150340..b884bb622 100644
> >> >--- a/drbd/drbd_state.c
> >> >+++ b/drbd/drbd_state.c
> >> >@@ -2353,7 +2353,8 @@ static void sanitize_state(struct drbd_resource=
 *resource)
> >> >       resource->susp_quorum[NEW] =3D
> >> >               resource->res_opts.on_no_quorum =3D=3D ONQ_SUSPEND_IO =
?
> >> >!resource_has_quorum : false;
> >> >
> >> >-       if (resource_is_suspended(resource, OLD) &&
> >> >!resource_is_suspended(resource, NEW)) {
> >> >+       if (!resource->susp_uuid[OLD] &&
> >> >+           resource_is_suspended(resource, OLD) &&
> >> >!resource_is_suspended(resource, NEW)) {
> >> >               idr_for_each_entry(&resource->devices, device, vnr) {
> >> >                       if (test_bit(NEW_CUR_UUID, &device->flags)) {
> >> >                               resource->susp_uuid[NEW] =3D true;
> >> >@@ -2553,6 +2554,7 @@ static bool should_try_become_up_to_date(struct
> >> >drbd_device *device, enum drbd_d
> >> >static void finish_state_change(struct drbd_resource *resource, const=
 char *tag)
> >> >{
> >> >       enum drbd_role *role =3D resource->role;
> >> >+       bool *susp_uuid =3D resource->susp_uuid;
> >> >       struct drbd_device *device;
> >> >       struct drbd_connection *connection;
> >> >       bool starting_resync =3D false;
> >> >@@ -2828,7 +2830,10 @@ static void finish_state_change(struct
> >> >drbd_resource *resource, const char *tag)
> >> >               if (role[OLD] =3D=3D R_SECONDARY && role[NEW] =3D=3D R=
_PRIMARY)
> >> >                       create_new_uuid =3D true;
> >> >
> >> >-               if (create_new_uuid)
> >> >+               /* When susp_uuid goes from true to false, we just cr=
eated a new
> >> >+                * current-uuid, it is pointless to do this one more =
time
> >> >+                */
> >> >+               if (create_new_uuid && !(susp_uuid[OLD] && !susp_uuid=
[NEW]))
> >> >                       set_bit(__NEW_CUR_UUID, &device->flags);
> >> >
> >> >               if (disk_state[NEW] !=3D D_NEGOTIATING &&
> >> >get_ldev_if_state(device, D_DETACHING)) {
> >> >@@ -4189,7 +4194,7 @@ static int w_after_state_change(struct drbd_wor=
k
> >> >*w, int unused)
> >> >                       still_connected =3D true;
> >> >       }
> >> >
> >> >-       if (!susp_uuid[OLD] && susp_uuid[NEW]) {
> >> >+       if (susp_uuid[NEW]) {
> >> >               unsigned long irq_flags;
> >> >
> >> >               begin_state_change(resource, &irq_flags, CS_VERBOSE);
> >> >
> >> >On Thu, Nov 23, 2023 at 9:48=E2=80=AFAM =E9=BB=84=E6=AD=A3=E5=85=B5 <=
zhengbing.huang@easystack.cn> wrote:
> >> >>
> >> >> Hi Philipp,
> >> >>
> >> >> Such modifications may cause new problems.
> >> >>
> >> >>  If, during the second state change,  the NEW_CUR_UUID flag was not=
 cleared.
> >> >>  clears the susp_uuid bit in a  thirdly state change.
> >> >>
> >> >> Eventually, it becomes an endless cycle.
> >> >>
> >> >> So, is it possible to add the following modifications=EF=BC=9A
> >> >>
> >> >> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> >> >> index 2fbd0b1..6bd6431 100644
> >> >> --- a/drbd/drbd_state.c
> >> >> +++ b/drbd/drbd_state.c
> >> >> @@ -3938,9 +3938,13 @@ static int w_after_state_change(struct drbd_=
work *w, int unused)
> >> >>                                 drbd_maybe_khelper(device, connecti=
on, "disconnected");
> >> >>                 }
> >> >>
> >> >> -               if (!susp_uuid[OLD] && susp_uuid[NEW] &&
> >> >> -                   test_and_clear_bit(NEW_CUR_UUID, &device->flags=
))
> >> >> -                       new_current_uuid =3D true;
> >> >> +               if (susp_uuid[NEW]) {
> >> >> +                       if (susp_uuid[OLD])
> >> >> +                               clear_bit(NEW_CUR_UUID, &device->fl=
ags);
> >> >> +                       else if (test_and_clear_bit(NEW_CUR_UUID, &=
device->flags))) {
> >> >> +                               new_curr_uuid =3D true;
> >> >> +                       }
> >> >> +               }
> >> >>
> >> >>                 if (new_current_uuid)
> >> >>                         drbd_uuid_new_current(device, false);
> >> >>
> >> >> best regards,
> >> >> Zhengbing
> >> >>
> >> >>
> >> >>
> >> >>
> >> >>
> >> >> From: Philipp Reisner <philipp.reisner@linbit.com>
> >> >> Date: 2023-11-23 14:06:30
> >> >> To:  "zhengbing.huang" <zhengbing.huang@easystack.cn>
> >> >> Cc:  drbd-dev@lists.linbit.com,joel.colledge@linbit.com
> >> >> Subject: Re: [PATCH] drbd: when change susp_uuid[NEW] to true, make=
 sure susp_uuid[OLD] is false>Hello Zhengbing,
> >> >> >
> >> >> >Thank you for pointing this out. I created a little bit different =
patch.
> >> >> >First, the sanitize_state() function should clean up the new state=
,
> >> >> >but I think it should never change the old state.
> >> >> >It can not rewrite history.
> >> >> >Second, we do not want to create two new current-uuids while I/O i=
s frozen.
> >> >> >
> >> >> >    drbd: fix susp_uuid clearing
> >> >> >
> >> >> >   I introduced susp_uuid for keeping a resource longer suspended =
for
> >> >> >   writing a new current-uuid.
> >> >> >   But in the following scenario, it failed to clear the susp_uuid=
 bit:
> >> >> >
> >> >> >    1. The network connection between a primary and secondary node
> >> >> >    fails. The primary has the setting quorum=3D2. IO freezes on t=
he
> >> >> >    primary node.
> >> >> >
> >> >> >    2. The user changes the quorum setting from 2 to one. The prim=
ary
> >> >> >    node generates a new current-uuid and clears the susp_uuid bit=
 in a
> >> >> >    second state change.
> >> >> >
> >> >> >    3. If, during the second state change, another condition for c=
reating
> >> >> >    a new current UUID evaluates to true, the code fails to clear =
the
> >> >> >    suspen_uuid bit.
> >> >> >
> >> >> >   The second attempt to create a new current-uuid gets ignored si=
nce it
> >> >> >   is pointless to create two current-uuids while I/O is frozen.
> >> >> >
> >> >> >   Fixes: d47f7456ab ("drbd: create new UUID before resuming IO up=
on
> >> >> >   regaining quorum")
> >> >> >
> >> >> >   Co-developed-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> >> >> >
> >> >> >diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> >> >> >index e35150340..316d3fd39 100644
> >> >> >--- a/drbd/drbd_state.c
> >> >> >+++ b/drbd/drbd_state.c
> >> >> >@@ -4189,7 +4189,7 @@ static int w_after_state_change(struct drbd_=
work
> >> >> >*w, int unused)
> >> >> >                       still_connected =3D true;
> >> >> >       }
> >> >> >
> >> >> >-       if (!susp_uuid[OLD] && susp_uuid[NEW]) {
> >> >> >+       if (susp_uuid[NEW]) {
> >> >> >               unsigned long irq_flags;
> >> >> >
> >> >> >               begin_state_change(resource, &irq_flags, CS_VERBOSE=
);
> >> >> >
> >> >> >
> >> >> >I give this to internal review for merging.
> >> >> >
> >> >> >best regards,
> >> >> > Philipp
> >> >> >
> >> >> >
> >> >> >On Wed, Nov 22, 2023 at 4:25=E2=80=AFAM zhengbing.huang
> >> >> ><zhengbing.huang@easystack.cn> wrote:
> >> >> >>
> >> >> >> The problem scenario is as follows:
> >> >> >>
> >> >> >> 1. drbd is built on two nodes, role is primary and secondary, qu=
orum is 2.
> >> >> >>    then drbd's network fails. IO will be suspended.
> >> >> >> 2. primary modify quorum to 1, during this state change,
> >> >> >>    drbd will set susp_uuid[NEW] to true and generate a new UUID.
> >> >> >> 3. then in w_after_state_change, start the second state change,
> >> >> >>    set susp_uuid[NEW] to false. but during the second state chan=
ge,
> >> >> >>    it's possible to find NEW_CUR_UUID flag was set by others.
> >> >> >>    then sanitize_state() will set susp_uuid[NEW] to true.
> >> >> >>
> >> >> >> Finally susp_uuid value is {true, true}, IO is frozen.
> >> >> >> And there is no way to set susp_uuid to false after that.
> >> >> >>
> >> >> >> So, while susp_uuid[NEW] is set to true, we want susp_uuid[OLD] =
to be false.
> >> >> >>
> >> >> >> Fixes: d47f7456ab ("drbd: create new UUID before resuming IO upo=
n regaining quorum")
> >> >> >> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> >> >> >> ---
> >> >> >>  drbd/drbd_state.c | 1 +
> >> >> >>  1 file changed, 1 insertion(+)
> >> >> >>
> >> >> >> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> >> >> >> index e35150340..0dedd2dae 100644
> >> >> >> --- a/drbd/drbd_state.c
> >> >> >> +++ b/drbd/drbd_state.c
> >> >> >> @@ -2356,6 +2356,7 @@ static void sanitize_state(struct drbd_res=
ource *resource)
> >> >> >>         if (resource_is_suspended(resource, OLD) && !resource_is=
_suspended(resource, NEW)) {
> >> >> >>                 idr_for_each_entry(&resource->devices, device, v=
nr) {
> >> >> >>                         if (test_bit(NEW_CUR_UUID, &device->flag=
s)) {
> >> >> >> +                               resource->susp_uuid[OLD] =3D fal=
se;
> >> >> >>                                 resource->susp_uuid[NEW] =3D tru=
e;
> >> >> >>                                 break;
> >> >> >>                         }
> >> >> >> --
> >> >> >> 2.17.1
> >> >> >>
> >> >>
> >> >>
> >>
> >>
>
>
