Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 111ED1056484
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:37:34 +0100 (CET)
Message-Id: <58BE9B8A02000070000B26A9@prv-mh.provo.novell.com>
Date: Mon, 06 Mar 2017 20:37:46 -0700
From: "Nick Wang" <nwang@suse.com>
To: <drbd-dev@lists.linbit.com>,"Nick Wang" <NWang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
	<1488857279-29079-2-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-2-git-send-email-nwang@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Drbd-dev] [Patch v0 1/8] Remove bio_set_op_attrs
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

>>> On 2017-3-7 at 11:27, in message
<1488857279-29079-2-git-send-email-nwang@suse.com>, Nick Wang <nwang@suse.c=
om>
wrote:
>  #ifndef WRITE_FLUSH
>  #ifndef WRITE_SYNC
>  #error  FIXME WRITE_SYNC undefined??
    Maybe can define WRITE_SYNC to 0 in this case?
    #define WRITE_SYNC 0
>  #endif
>  #define WRITE_FLUSH       (WRITE_SYNC | DRBD_REQ_PREFLUSH)
>  #endif
> +#endif

Best regards,
Nick


