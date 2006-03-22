Return-Path: <ldenel@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.196])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 62B7316AE1
	for <drbd-dev@lists.linbit.com>; Wed, 22 Mar 2006 19:46:16 +0100 (CET)
Received: by xproxy.gmail.com with SMTP id t13so196494wxc
	for <drbd-dev@lists.linbit.com>; Wed, 22 Mar 2006 10:46:15 -0800 (PST)
Message-ID: <6ed4c8790603221046w6fedd871p8786bc427eafd8b@mail.gmail.com>
Date: Wed, 22 Mar 2006 19:46:13 +0100
From: "Laurent Denel" <ldenel@gmail.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] freeze under postmark io bench
In-Reply-To: <20060311163505.GC3816@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ed4c8790602101017l48d1b24s9fd684c82998e34f@mail.gmail.com>
	<20060311163505.GC3816@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> please try with latest svn
>  svn co http://svn.drbd.org/drbd/branches/drbd-0.7
>
> I just checked in a one line change where we used GFP_KERNEL where we
> should have used GFP_NOIO...

Thanks a lot for the answer, I wondered if my bug report wasn't too
stupid to reach the mass audiences ;).

I've just tried today with kernel 2.6.16 (sorry for that kernel are
evolving fast here ;), if needed I can test with the 2.6.15.4 we had)
and Monday's latest svn.

Postmark 200k files creation completed successfully but the
transaction part crashed again the host. Could there be the same bug
elsewhere in the code ?

Cheers,
LD
