Return-Path: <lars@linbit.com>
Date: Sat, 21 Jul 2007 16:24:08 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: lihua <lihuagzs@163.com>
Message-ID: <20070721142408.GB6130@mail.linbit.com>
References: <DreamMail__200941_89074845882@smtp.163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DreamMail__200941_89074845882@smtp.163.com>
Cc: drbd-dev <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Re: your mail
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jul 19, 2007 at 08:09:41PM +0800, lihua wrote:
> drbd-dev，
>     I have a Qs in function ensure_mdev in  drbd_nl.c
>     minor_to_mdev ensure mdev exist.
>     If it not exist ,we may create a device .Thus ,minor_table[nlp->drbd_minor] == NULL and mdev = NULL.
>     So :
> 
>             if(mdev){
>                 ......
>             } 
>     can't perform forever.
>     Is my mean right?
>                             2007-7月-日 

the inner part is only to avoid a race condition in case two commands
try to create the same device at the same time. it won't loop.


-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
