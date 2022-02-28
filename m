Return-Path: <dan.carpenter@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EB7EA4201D4
	for <drbd-dev@lists.linbit.com>; Mon, 28 Feb 2022 13:28:45 +0100 (CET)
Date: Mon, 28 Feb 2022 14:24:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jakob Koschel <jakobkoschel@gmail.com>
Message-ID: <20220228112413.GA2812@kadam>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220228110822.491923-2-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228110822.491923-2-jakobkoschel@gmail.com>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
	amd-gfx@lists.freedesktop.org, samba-technical@lists.samba.org,
	linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
	linux-arch <linux-arch@vger.kernel.org>,
	linux-cifs@vger.kernel.org, kvm@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
	Jason Gunthorpe <jgg@ziepe.ca>, intel-wired-lan@lists.osuosl.org,
	kgdb-bugreport@lists.sourceforge.net,
	bcm-kernel-feedback-list@broadcom.com,
	linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Arnd Bergman <arnd@arndb.de>, linux-pm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	v9fs-developer@lists.sourceforge.net, linux-tegra@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-sgx@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	tipc-discussion@lists.sourceforge.net,
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [Drbd-dev] [PATCH 1/6] drivers: usb: remove usage of list
 iterator past the loop body
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

On Mon, Feb 28, 2022 at 12:08:17PM +0100, Jakob Koschel wrote:
> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
> index 9040a0561466..0fd0307bc07b 100644
> --- a/drivers/usb/gadget/udc/at91_udc.c
> +++ b/drivers/usb/gadget/udc/at91_udc.c
> @@ -150,13 +150,14 @@ static void proc_ep_show(struct seq_file *s, struct at91_ep *ep)
>  	if (list_empty (&ep->queue))
>  		seq_printf(s, "\t(queue empty)\n");
> 
> -	else list_for_each_entry (req, &ep->queue, queue) {
> -		unsigned	length = req->req.actual;
> +	else
> +		list_for_each_entry(req, &ep->queue, queue) {
> +			unsigned int	length = req->req.actual;
> 
> -		seq_printf(s, "\treq %p len %d/%d buf %p\n",
> -				&req->req, length,
> -				req->req.length, req->req.buf);
> -	}
> +			seq_printf(s, "\treq %p len %d/%d buf %p\n",
> +					&req->req, length,
> +					req->req.length, req->req.buf);
> +		}

Don't make unrelated white space changes.  It just makes the patch
harder to review.  As you're writing the patch make note of any
additional changes and do them later in a separate patch.

Also a multi-line indent gets curly braces for readability even though
it's not required by C.  And then both sides would get curly braces.

>  	spin_unlock_irqrestore(&udc->lock, flags);
>  }
> 
> @@ -226,7 +227,7 @@ static int proc_udc_show(struct seq_file *s, void *unused)
> 
>  	if (udc->enabled && udc->vbus) {
>  		proc_ep_show(s, &udc->ep[0]);
> -		list_for_each_entry (ep, &udc->gadget.ep_list, ep.ep_list) {
> +		list_for_each_entry(ep, &udc->gadget.ep_list, ep.ep_list) {

Another unrelated change.

>  			if (ep->ep.desc)
>  				proc_ep_show(s, ep);
>  		}


[ snip ]

> diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
> index 7c38057dcb4a..bb59200f1596 100644
> --- a/drivers/usb/gadget/udc/net2272.c
> +++ b/drivers/usb/gadget/udc/net2272.c
> @@ -926,7 +926,8 @@ static int
>  net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  {
>  	struct net2272_ep *ep;
> -	struct net2272_request *req;
> +	struct net2272_request *req = NULL;
> +	struct net2272_request *tmp;
>  	unsigned long flags;
>  	int stopped;
> 
> @@ -939,11 +940,13 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  	ep->stopped = 1;
> 
>  	/* make sure it's still queued on this endpoint */
> -	list_for_each_entry(req, &ep->queue, queue) {
> -		if (&req->req == _req)
> +	list_for_each_entry(tmp, &ep->queue, queue) {
> +		if (&tmp->req == _req) {
> +			req = tmp;
>  			break;
> +		}
>  	}
> -	if (&req->req != _req) {
> +	if (!req) {
>  		ep->stopped = stopped;
>  		spin_unlock_irqrestore(&ep->dev->lock, flags);
>  		return -EINVAL;
> @@ -954,7 +957,6 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  		dev_dbg(ep->dev->dev, "unlink (%s) pio\n", _ep->name);
>  		net2272_done(ep, req, -ECONNRESET);
>  	}
> -	req = NULL;

Another unrelated change.  These are all good changes but send them as
separate patches.

>  	ep->stopped = stopped;
> 
>  	spin_unlock_irqrestore(&ep->dev->lock, flags);

regards,
dan carpenter
