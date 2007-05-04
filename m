Return-Path: <lars@linbit.com>
Date: Fri, 4 May 2007 15:34:11 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Panic in _drbd_send_page() again.
Message-ID: <20070504133411.GA14895@barkeeper1.linbit>
References: <BD7042533C2F8943A6A4257A9E31C45439C994@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B37671056365AC@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671056365AC@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, May 02, 2007 at 10:06:44AM -0400, Graham, Simon wrote:
> > Hi Ernest,
> > 
> > Could you run this through ksymoops, to get the code line
> > disassembled ? -- This does not look like a well-known distri kernel,
> > or is it ?
> > 
> > -Phil
> 
> This is running 2.6.16.38 with Xen 3.0.4 patches -- it's way too late to
> run ksymoops on this specific case (the system has long since moved on!)
> However, looking at the disassembly for
> _debd_send_page:


> send_page+0x21 is 3e11 - loading from %edx which is 2nd param, page; 
> this is attempting to read the flags field as part of the page_count()
> macro call:
> 
> int _drbd_send_page(drbd_dev *mdev, struct page *page,
> 		    int offset, size_t size)
> {
> 	mm_segment_t oldfs = get_fs();
> 	int sent,ok;
> 	int len   = size;
> 
> #ifdef SHOW_SENDPAGE_USAGE
> ...
> #endif
> 
> 	/* PARANOIA. if this ever triggers,
> 	 * something in the layers above us is really kaputt.
> 	 *one roundtrip later:
> 	 * doh. it triggered. so XFS _IS_ really kaputt ...
> 	 * oh well...
> 	 */
> 	if ( (page_count(page) < 1) || PageSlab(page) ) {
> 		/* e.g. XFS meta- & log-data is in slab pages, which
> have a
> 
> The Oops message shows that edx is 0x6b6b6b6b which is the poison
> value for free memory when using CONFIG_SLAB_DEBUG -- as Ernest
> pointed out, this means that we're using a bio that has already been
> freed...
> 
> This is very similar to a bunch of problems found previously where the
> bio was freed too early -- the big difference with this one is that we
> turned on CONFIG_SLAB_DEBUG which enabled poisoning of freed memory...

all pieces of information we have about this seem to indicate that the
xen block device code builds up its own bios, tries to be smart there...

and possibly outsmarts itself.

not that I'm too much into pointing fingers,
but I suggest to not only look at drbd, also look closely at the part of
xen that builds up the bios that then are submitted to drbd.
maybe they are not sufficiently initialized, or drbd has otherwise wrong
expectations about bios that do no longer hold true for the bios
submitted by xen.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
__
please use the "List-Reply" function of your email client.
