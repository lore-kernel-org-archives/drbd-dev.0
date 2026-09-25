Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9AF417BD2
	for <drbd-dev@lists.linux.dev>; Fri, 25 Sep 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330131; cv=pass; b=jA3V32phlkhjx3effRzyJQafW12NHhEd6bqBxC+8nCLefEXt0PTiNUyYS9JYa54/9hJAIOJaooeBEmD70P6OHXmDMV2Jox+xx6mOusJ4Zoksw9q/D54KZOMTCqboiDMEGKiI+t1GXprH2NnfKVqWsgNGc1I33FfaTgSsy8F+/ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330131; c=relaxed/simple;
	bh=CD7LA+ZLxNbukG3Ymi4d50ne5xfI8H4s4ZBMPzxlZ7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoSax2OLeKU5oWm4B8LFA/5OLjI9d63G9VOk6lrmebq3//Elej+DwE+lYRwrV/pOR1I3r0E60XKNGK1liqjROjrv3Ybbtl5ev1ng7L5o5bjVfryyibaDO8hS2pymVC/ZVbv9UUttQmijk5a/WjRimrKlOL8dupra4iiHKCjh0Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=VLMReYdx; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="VLMReYdx"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c294ad260fdso112645366b.1
        for <drbd-dev@lists.linux.dev>; Fri, 25 Sep 2026 02:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790330127; cv=none;
        d=google.com; s=arc-20260327;
        b=J+3aCXqCWQhaaLBDwUL0nPjdkFpeO0HFUa8JRLUt3xS0ruqjN8LvAOENketNMyMiIh
         4vi65Q/9DMxLrYtXB6C/dtUyKa6Fq9Oswk9UlN5rvlu9cTdLzBS52MyNhCo4oyDzV+Ps
         j0mbELCAeUWM/ljApm4I83OlR5+1ck3c3PNRwNo9jxMLmfbqcCgsNW2l/bScHfje4lea
         j08W/TS+Hf0UgiLXKnO+ucX1Cmx9zjG56NqkwvCl+f2FDP+MCmm00ZEse8GgQikUmMLa
         xoFkRwGJZuoGKDay0apcJjzTtF3V+bmLbpFh1uHzTrAi22sEkzDRh64nYQAK2Ni/xizG
         gQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GaMqwFGgwLd6/ovaIWv1K5jt2XZn4CFqHWF7cqp132Y=;
        fh=0ji70OvZOw2q6ZEKVsL0sAJAuUsESQYqDpYDFnyl6zA=;
        b=G1EvLlljgeIGsje9/YMdrf4OkXiNNr+K0EkrsKfG3IeDW39EJWm83VQIQ5lXEqCQSd
         P1NLuK1D8fFddX0h/sPIZOykBewSJon3AgZoT4R8iRJYBhZaZgXdpbsN7wDYpJ5zaYLB
         2dC4dfcowf2AcfwcvILkONWcm1486gIysD+pIvnygLbYOu6GD23wJ66hCEbY/iJRNZpU
         ZUs115ZW2jKLqD2vK9h0Fu2+MgOlNiFVvN+y/L1tvUSlMiIZcgkhDMB6I0iqwsNC324X
         ys71nQUmEh7hpNgxypeQ2EEYqHnwA1mjpuFCMLzeesxgivhlGxaw7NQ97ZaCqPri5gMm
         Zc8w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790330127; x=1790934927; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GaMqwFGgwLd6/ovaIWv1K5jt2XZn4CFqHWF7cqp132Y=;
        b=VLMReYdxYgEIOESI4L1/B4CDFd2s7+5Vwm4Na4LzPKEWDS6rphakg0mmW1hC0vxYZB
         01+jhqCSAV6Hye44c2NJ0/2rbeJNJAJ7NaYJybx0KH/tL1lGVgw6EIOpzgZmK/AARHgB
         dEsW1+zdVWKh+fK9fkc7AQ8DYW9CmfQhkCoNqJIaihgyvJnsfjAxpyfhbfi+W3VeL2lM
         qG/ixz/Zxz7RK6DkBBdnoQchGgkDhg+0IqBfAK42mgJVw5jRCLZtfVqkUejHviarnnrW
         GZlAqGpJjh+yR3LuF6LJ/mNSDDhf7BG4knC1W6hPpPL8ELbPqcpq2v0BKRnNWtWnlCKc
         tJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790330127; x=1790934927;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GaMqwFGgwLd6/ovaIWv1K5jt2XZn4CFqHWF7cqp132Y=;
        b=vUMAPiy6PTOtNsjYY6EMrlvPOwB4NMC7PZba6/eDRhFSkNmiJGgBgyaCnpqRWGc7vI
         TaYFRK6g9Ld0PgrJDgBSipMXk4XCEWu43bGai4a+D/ws6FM5rdeY9VCUP77I+WSgILHB
         u4fkPh154CVr2ARU1kTqR3nIGXCIa+FkOvdpVv3+nbhVNi/tbWR4LI+zJWMbap7HGCgW
         597g+VbvnurVsMudpmNOvO7HnLEXBstm/euGVPKxV8lC3we0BzIBZR+sr3A9rhkot8bU
         PgcvWaj9E+1OnJGoiEDpcWs61l7tIn2WuQGP8via/Ts96VAEwoabH4o5rlo17DAKFzfA
         oIDA==
X-Gm-Message-State: AFuF++moV/WA0F7rVxzbCgk18HLkm6psOW8T1C/4jryuQYX6wO0oyQjP
	FrJ8ko3u3H8Yf+G0dgZhAwKSdiV2G5TiNW8OiaxZ3vRDOKdvbvqLHiHTgqg6Mmr7k4drTcfX7r3
	D6dpiWFb8pcHu/1jg+Tp0JRKi0XJPPbSseIccX2NvO7M7xpr6lJWNNWQ=
X-Gm-Gg: AYBFou1lSZjd9hxeaiPAGj4EI0r6DL4bKmoJDC/krc5JPfAv2hL6lLdwAyhjNecXwy9
	VsyU1na5U+jjeVGjFqFz28s3XUlZmM55toH6s/HFICkVi5Hr8amyQ5MlJrE7JZd3YlQAOiB2UGS
	bpJKhLhkKQuaurffdnJKpR1kXLUwAcG8Eq0uI1FxJNwK56ZaQbRkbDy4PMU3M3OE+wJOvroCA/5
	HIIFNH34j0DiLUahEAp63FZE+M6RJX6vcLPvl1rthGUZku8x5F/TAHz5eQ/njkcm9OLV6rSZ9Kg
	YThykOsX/JBBbJmhwPXYdfHy6FqqIjUtRnWjJBijqn+3djsVgQKhkyzn5x4M03ko0yK0
X-Received: by 2002:a17:907:7211:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c2ac21fa3ffmr467445966b.6.1790330127206; Fri, 25 Sep 2026
 02:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260923055939.3207539-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20260923055939.3207539-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 25 Sep 2026 11:55:15 +0200
X-Gm-Features: AclHuK8V2AShN8lzfD-zP4VNepPEUWesRrxufbmTApjLGipMxEFYti07-yIr8Zk
Message-ID: <CADGDV=XCYKFhMZwfCRvk5VsvKWyqRwFy1mFUKj0JrFAtc4yGQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drbd: fix CONSIDER_RESYNC race in receive_state
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Cc: drbd-dev@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Applied.


On Wed, Sep 23, 2026 at 8:10=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> receive_state() cleared CONSIDER_RESYNC unconditionally at its tail,
> even when the resync handshake block was skipped (e.g. UUIDS_RECEIVED
> not yet set or local disk below NEGOTIATING).  This could drop the
> flag set by drbd_set_role() for a forced primary, so the forced
> resync was never started.
>
> Consume the flag atomically with test_and_clear_bit() in the handshake
> block, and restore it if the state change is retried, so a concurrent
> set is never lost and a forced resync survives the retry loop.
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_receiver.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
> index f6a8d2217..039ba24d9 100644
> --- a/drbd/drbd_receiver.c
> +++ b/drbd/drbd_receiver.c
> @@ -9775,6 +9775,7 @@ static int receive_state(struct drbd_connection *co=
nnection, struct packet_info
>         enum drbd_disk_state peer_disk_state;
>         enum drbd_repl_state new_repl_state;
>         bool peer_was_resync_target, do_handshake =3D false;
> +       bool consumed_resync;
>         enum chg_state_flags begin_state_chg_flags =3D CS_VERBOSE | CS_WA=
IT_COMPLETE;
>         unsigned long irq_flags;
>         int rv;
> @@ -9821,6 +9822,7 @@ static int receive_state(struct drbd_connection *co=
nnection, struct packet_info
>         read_unlock_irq(&resource->state_rwlock);
>   retry:
>         new_repl_state =3D max_t(enum drbd_repl_state, old_peer_state.con=
n, L_OFF);
> +       consumed_resync =3D false;
>
>         /* If some other part of the code (ack_receiver thread, timeout)
>          * already decided to close the connection again,
> @@ -9944,7 +9946,8 @@ static int receive_state(struct drbd_connection *co=
nnection, struct packet_info
>                                         !test_bit(INITIAL_STATE_RECEIVED,=
 peer_device->flags);
>                 /* if we have both been inconsistent, and the peer has be=
en
>                  * forced to be UpToDate with --force */
> -               consider_resync |=3D test_bit(CONSIDER_RESYNC, peer_devic=
e->flags);
> +               consumed_resync =3D test_and_clear_bit(CONSIDER_RESYNC, &=
peer_device->flags);
> +               consider_resync |=3D consumed_resync;
>                 /* if we had been plain connected, and the admin requeste=
d to
>                  * start a sync by "invalidate" or "invalidate-remote" */
>                 consider_resync |=3D (old_peer_state.conn =3D=3D L_ESTABL=
ISHED &&
> @@ -10133,12 +10136,13 @@ static int receive_state(struct drbd_connection=
 *connection, struct packet_info
>
>         begin_state_change(resource, &irq_flags, begin_state_chg_flags);
>         if (old_peer_state.i !=3D drbd_get_peer_device_state(peer_device,=
 NOW).i) {
> +               if (consumed_resync)
> +                       set_bit(CONSIDER_RESYNC, &peer_device->flags);
>                 old_peer_state =3D drbd_get_peer_device_state(peer_device=
, NOW);
>                 abort_state_change_locked(resource);
>                 write_unlock_irq(&resource->state_rwlock);
>                 goto retry;
>         }
> -       clear_bit(CONSIDER_RESYNC, peer_device->flags);
>         if ((repl_is_sync_source(old_peer_state.conn) && new_repl_state =
=3D=3D L_WF_BITMAP_S) ||
>             (repl_is_sync_target(old_peer_state.conn) && new_repl_state =
=3D=3D L_WF_BITMAP_T)) {
>                 /* Re-entering the bitmap exchange is refused while that =
resync
> --
> 2.43.0
>
>
