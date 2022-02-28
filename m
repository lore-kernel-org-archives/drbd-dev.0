Return-Path: <dan.carpenter@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8585F4201F2
	for <drbd-dev@lists.linbit.com>; Mon, 28 Feb 2022 14:15:46 +0100 (CET)
Date: Mon, 28 Feb 2022 16:13:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jakob Koschel <jakobkoschel@gmail.com>
Message-ID: <20220228131325.GC2794@kadam>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220228110822.491923-3-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228110822.491923-3-jakobkoschel@gmail.com>
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
Subject: Re: [Drbd-dev] [PATCH 2/6] treewide: remove using list iterator
 after loop body as a ptr
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

On Mon, Feb 28, 2022 at 12:08:18PM +0100, Jakob Koschel wrote:
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index 4ee578b181da..a8cbd90db9d2 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -1060,26 +1060,29 @@ EXPORT_SYMBOL(sas_port_get_phy);
>   * connected to a remote device is a port, so ports must be formed on
>   * all devices with phys if they're connected to anything.
>   */
> -void sas_port_add_phy(struct sas_port *port, struct sas_phy *phy)
> +void sas_port_add_phy(struct sas_port *port, struct sas_phy *_phy)

_phy is an unfortunate name.

>  {
>  	mutex_lock(&port->phy_list_mutex);
> -	if (unlikely(!list_empty(&phy->port_siblings))) {
> +	if (unlikely(!list_empty(&_phy->port_siblings))) {
>  		/* make sure we're already on this port */
> +		struct sas_phy *phy = NULL;

Maybe call this port_phy?

>  		struct sas_phy *tmp;
> 
>  		list_for_each_entry(tmp, &port->phy_list, port_siblings)
> -			if (tmp == phy)
> +			if (tmp == _phy) {
> +				phy = tmp;
>  				break;
> +			}
>  		/* If this trips, you added a phy that was already
>  		 * part of a different port */
> -		if (unlikely(tmp != phy)) {
> +		if (unlikely(!phy)) {
>  			dev_printk(KERN_ERR, &port->dev, "trying to add phy %s fails: it's already part of another port\n",
> -				   dev_name(&phy->dev));
> +				   dev_name(&_phy->dev));
>  			BUG();
>  		}
>  	} else {
> -		sas_port_create_link(port, phy);
> -		list_add_tail(&phy->port_siblings, &port->phy_list);
> +		sas_port_create_link(port, _phy);
> +		list_add_tail(&_phy->port_siblings, &port->phy_list);
>  		port->num_phys++;
>  	}
>  	mutex_unlock(&port->phy_list_mutex);

regards,
dan carpenter
