Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D048EC70
	for <drbd-dev@lists.linux.dev>; Fri, 25 Sep 2026 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331399; cv=none; b=iNi/6sbbLbFPeEOl7pjGVcUvE4FZedhTLYnboFRX5IY5gLSjfwUQfB82VSVhsg1y37qlNNq+CxjEgBXdF1ww4KZr9xKffLwwbXzE1aBHJb8Tj/SS4aOCfABdNgjRaCRCbDlLJ4/g9zkuoUdcscwgps4eJAQzHsWRJOjZms5eqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331399; c=relaxed/simple;
	bh=YbrV0Qg24twHDNRh/8QVg0MjJ9gjZTu1Gn87s7DlxHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTeLR5VEA+RKKxi0Lsg1Gfb17hlIiTPsfgDk5lZxKYFlOYIkuUVHtBEAaw5gAkAz1ovbjInUcpO+LYY4rG0TOGqGAXZDbvkcrfMqNTSEAHKHPnOP5YQL+8/s/FtaX1AauaWcWAtPwgZ2fEq2MPrtMK33lFKhGznndgvcNmPdXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=fAvY+OyL; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="fAvY+OyL"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af3a4f193so24900066b.3
        for <drbd-dev@lists.linux.dev>; Fri, 25 Sep 2026 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790331395; x=1790936195; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZxlAMRLwda5bquTbn9flql/bya9NHLrKq/m62L/vxlg=;
        b=fAvY+OyLG3Zs69AA3nmwgaC1rzgr0kZDVIbxwZwE2LSLtpxKmgqWR4wkkYHU8sSWVE
         pfcYnP14x+S1FpDavzud8PxAUBDFP+Yl8a1nl/EbbDBytcIOoD9eh8WD04Cf6kaDJtem
         b9MQdKokQKSU18haLSaddRwF2VLUQkMTfRtHZNuBH3y925NpQlUS5nlOeJyOfg3V71i/
         P43pWaurI1p2VD6/ekvxTzuZAnaNtqEUkWJvQVJ+iBbNEwFbHVVxVdg3v8bIBK8oLZgU
         Uq8ERotfBtR9/MVQXc6XPXpo/8zFAqNVzwovLAki9mcWJ7BX1y1/COFN+/XoIuD+Vj8m
         /miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790331395; x=1790936195;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxlAMRLwda5bquTbn9flql/bya9NHLrKq/m62L/vxlg=;
        b=GZRDpxA/s6kbZQeCn2UD/pGUUQiCpjMXePa+CQOzfKsystiVh/VILLvmsKTSoh5kOJ
         PUM6uCC9GpmT81iLn5PUBoY1I4C95+L2OQ4Zqp8GTClX3DRybybAjsmtXOHyX9ToTe2k
         LoGLU3k+Gv6bpreN3eMjD6SD5uAxcr8ahEY/Zmyh+/1i1KIgyGcicZSpSx+Fq5+9AWB0
         ypjqWemVKpwkoWNyjYpDjIv1wQjuMGzg0up89a6kz0og3+wwk6MMUhfH6gzHpL2KbhAh
         oGrzKMWYxshoeYNwt8OwDLe7K5oZOfV/92+rLBfFiIS/CTdWysQiS+/D+lJwXRszxphM
         QJjg==
X-Gm-Message-State: AFuF++nnVY+wgEjh3H6JDZ1uJWVkC0ulzdZoJ34Ykz7SkdTV1nCn120j
	LTiJ+FawbuVpoU3dGydbOSeCE0NN7gpwYj9GFUc/88KFLiYTOXErh/0klI0OwU+iqWlUHbqW6TT
	HuXF7vFg=
X-Gm-Gg: AYBFou0fwW8GBqBX4hU/JC2zbFCmcPqUY54orHEt/O6wflBO/Mn1ksxeLjIasG1BGri
	hq/l6308EIJDJVoPityehAr3YoiabTgqPZiTrnZj+Gda9xAy2qBAmASZ4jPxS6CGFfgXVR9PkTO
	ffO06+geqTY0aHic4aIkKh6c69sWYHjRHcFRKfRIBWI0ANHuz8POjEUSJLhtGOnmQC+ZnM+2Rcx
	lBwq40a/lWwV8Hqsm2FbL3KZwCZM97ZmSZLcjZnDMeRnQhx9IuEh6jRG4BxD/cRZ5nppdxJFxkh
	3oTLwjAiRj8ml5N2rYg25ihb9LL2hbfHy0CUHZDUQHGX957yQsXtJN3trcFSwS2cQLLfSW+ieND
	F9wP2W+nAE/F1ovUmDaH8ojkVL+9OZbacycEFrWZxo2RLGkQMUY/HNGVL+WJIFDh06tuhKje7PE
	u0PyySX1l0LYaSl4NCHQsyP+/f7S62dgSlicDl/EjufO7+3JDzL/yu4xPKd03R8Qc7S/54TmPDq
	USGFRZGRK2iPbMyTVuAdFH0C+jqpimuwMsQI4e0odSNHU0Y
X-Received: by 2002:a17:907:72d0:b0:c29:3a1b:ec8e with SMTP id a640c23a62f3a-c2ac241d7f9mr440730866b.3.1790331394970;
        Fri, 25 Sep 2026 03:16:34 -0700 (PDT)
Received: from ryzen9 (192-164-131-220.hdsl.highway.telekom.at. [192.164.131.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae77ff064sm92574966b.48.2026.09.25.03.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:16:34 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:16:32 +0200
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Cc: drbd-dev@lists.linux.dev
Subject: Re: [PATCH 2/2] drbd: send state before bitmap to avoid
 receive_bitmap race
Message-ID: <arZKAMlDmSWmzgSg@ryzen9>
References: <20260923060109.3208507-1-zhengbing.huang@easystack.cn>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923060109.3208507-1-zhengbing.huang@easystack.cn>

Hi Zhengbing,

Thanks for sending this.

I can reproduce the reordering itself in our simulator: when the
forced node handshakes on a P_STATE from its peer that still says
L_ESTABLISHED, its worker sends the bitmap before the receiver sends
the uuids and the P_STATE from that branch. But the peer does not drop
it. The forced node's P_STATE from drbd_set_role() is ahead of the
bitmap on the data socket, and the peer has CONSIDER_RESYNC set from
the promotion's commit. So it runs its own handshake on that P_STATE
and is L_WF_BITMAP_T before the bitmap arrives. I could not find an
interleaving of a 2-node forced promotion where the bitmap is dropped,
including with the peer diskless during the promotion and with a
concurrent pause-sync on either node.

So I suspect your case has a peer that does not run that handshake
itself. Can you tell me how you hit it?

- the sequence of commands, the node count, and which nodes were
  Inconsistent/UpToDate/diskless
- the DRBD version, and the agreed protocol version if it is older
  than 118
- the kernel log from both nodes around the "unexpected repl_state"
  message

The concern with the patch as it stands:

The uuids are deliberately sent before the state. Your new P_STATE
goes out from the worker before those uuids, so the peer may run its
handshake with stale uuids for us.

Best regads,
 Phil

Am Wed, Sep 23, 2026 at 02:01:09PM +0800 schrieb zhengbing.huang:
> When a node becomes SyncSource (L_WF_BITMAP_S), after_state_chg() on the
> worker thread queues the bitmap send while receive_state() on the receiver
> thread sends the P_STATE that lets the peer reach L_WF_BITMAP_T. These race,
> so the bitmap can arrive while the peer is still L_ESTABLISHED and get
> dropped in receive_bitmap(), logging "unexpected repl_state (Established) in
> receive_bitmap".
> 
> Send the current state synchronously before queueing the bitmap so the peer
> transitions to L_WF_BITMAP_T first.
> 
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_state.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> index 4ddb31cb8..65414a774 100644
> --- a/drbd/drbd_state.c
> +++ b/drbd/drbd_state.c
> @@ -4884,6 +4884,12 @@ static int w_after_state_change(struct drbd_work *w, int unused)
>  				 * it does no harm to resync a small amount of
>  				 * additional data. */
>  				drbd_set_pending_out_of_sync(peer_device);
> +				/* Tell the peer about our new state before sending the
> +				 * bitmap, so it can reach L_WF_BITMAP_T first. Otherwise
> +				 * the bitmap may arrive while the peer is still
> +				 * L_ESTABLISHED and get dropped in receive_bitmap().
> +				 */
> +				drbd_send_state(peer_device, new_state);
>  				/* ldev_safe: ref from extra_ldev_ref_for_after_state_chg() */
>  				drbd_queue_bitmap_io(device, &drbd_send_bitmap, NULL,
>  						"send_bitmap (WFBitMapS)",
> -- 
> 2.43.0
> 
> 
