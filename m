Return-Path: <Eduard.Guzovsky@stratus.com>
Received: from mailhub4.stratus.com (mailhub4.stratus.com [134.111.1.17])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9696D1058600
	for <drbd-dev@lists.linbit.com>; Wed, 12 May 2010 05:51:27 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 May 2010 23:50:54 -0400
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C99483AF@EXHQ.corp.stratus.com>
In-Reply-To: 20100503070855.GB772@soda.linbit
References: <BC2F8964429F14468EA0E6D6CF00E8C994839C@EXHQ.corp.stratus.com><BC2F8964429F14468EA0E6D6CF00E8C99483A1@EXHQ.corp.strat
	us.com> 20100503070855.GB772@soda.linbit
From: "Guzovsky, Eduard" <Eduard.Guzovsky@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] DRBD small synchronous writes performanceimprovements
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Lars,

My comments and a zero copy receive patch are inline.

Thanks,

-Ed

> -----Original Message-----
> From: drbd-dev-bounces@lists.linbit.com [mailto:drbd-dev-
> bounces@lists.linbit.com] On Behalf Of Lars Ellenberg
> Sent: Monday, May 03, 2010 3:09 AM
> To: drbd-dev@lists.linbit.com
> Subject: Re: [Drbd-dev] DRBD small synchronous writes
> performanceimprovements
>=20
> On Fri, Apr 30, 2010 at 06:11:13PM -0400, Guzovsky, Eduard wrote:
> > > > 3. We noticed that on the primary node it takes about 20us to
> > > > schedule DRBD worker thread that packages and sends write
request
> > > > to the secondary node. We think it would be better to send
request
> > > > to the secondary ASAP and only then continue with primary node
> > > > processing.  So I added "schedule()"  hack to
> > > > drbd_make_request_common() and raised the priority of the worker
> > > > thread. That reduced worker thread scheduling delay to about
7us.
> > > > I am not 100% if this hack is safe - would be very interested in
> > > > your opinion on it.
>=20
> > > What is your "cpu-mask" for the drbd threads?
> >
> > We do not specify affinity - any cpu is up for grabs.
>=20
> If you do not set cpu-mask with drbdsetup,
> DRBD kernel threads of one specific minor
> will pin themselves on the same single cpu.
>=20
> So maybe try: drbdsetup 0 syncer --cpu-mask ff

Ok, I did not realize that setting cpu affinity is the default behavior.


>=20
> > > > We were also considering implementation of "zero copy" receive
> > > > that should improve performance for 10Gig links - that is not
part
> > > > of the patch. The basic idea is to intercept incoming data
before
> > > > they get queued to the socket in the same way NFS and i-scsi
code
> > > > do it through tcp_read_sock() api.
> > >
> > > Yes. I recently suggested that as an enhancement for IET on the
> > > iscsit-target mailing list myself, though to get rid of an
additional
> > > memcopy they do for their "fileio" mode.
> > >
> > > I don't think it is that easy to adapt for DRBD (or their "block
io"
> > > mode), because:
> > >
> > > > Then drbd could convert sk_buff chain to bio, if alignment is
right,
> > >
> > > that is a big iff.
> > > I'm not at all sure how you want to achieve this.
> > > Usually the alignment will be just wrong.
> > >
> > > > and avoid expensive data copy. Do you plan to add something like
> > > > this into you future DRBD release so we do not have to do it
> > > > ourselves? ;-)
> > >
> > > Something like this should be very beneficial, but I don't see how
we
> > > can achieve the proper alignment of the data pages in the sk_buff.
> > >
> > > "native RDMA mode" for DRBD would be a nice thing to have, and
possibly
> > > solve this as well.  Maybe we find a feature sponsor for that ;-)
> > >
> >
> > Here is a plan for getting alignment right. I will assume usage of
the
> > Intel 82599 10Gig chip and the corresponding ixgbe driver.
> >
> > The nice thing about this chip and the driver is that by default
they
> > supports packet splitting. That means that Ethernet/TCP/IP header of
> > the incoming packet is received in one memory buffer, while the data
> > portion is received into another memory buffer. This second buffer
is
> > half-page (2KB) aligned. I guess they did not make it the whole page
> > aligned to reduce memory waste. Still, AFAIK that should more than
> > satisfy bio alignment requirements. Is it 512 bytes?
> >
> > We set interface mtu to 9000. Let's say DRBD does a 32KB write. DRBD
> > can control (or at least give a hint to TCP) how the whole request
> > should be "packetized" using MSG_MORE flag. DRBD Request Header is
> > sent as one packet (no MSG_MORE) flag. Then each even (counting from
> > 0) data page is sent with MSG_MORE flag, each odd data page is sent
> > without MSG_MORE flag. This should result in two data pages per
packet
> > transmits.
> >
> > I instrumented DRBD to do just that. I also instrumented ixgbe
driver
> > to dump skb with the received data on the secondary node. Here is
what
> > I got for a 32KB write.
> >
> >  skb 0xebc04c80 len 84 data_len 32 frags 1     <-- 52 bytes TCP/IP
header
> >   frag_page 0xc146ba40 offset 0 size 32        <-- 32 bytes
> Drbd_Data_Packet
> >
> >  skb 0xe362b0c0 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP
header
> >   frag_page 0xc146ba60 offset 2048 size 2048   <-- 8KB of data
> >   frag_page 0xc146baa0 offset 2048 size 2048
> >   frag_page 0xc146bac0 offset 0 size 2048
> >   frag_page 0xc146bae0 offset 2048 size 2048
> >
> >  skb 0xe35a9440 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP
header
> >   frag_page 0xc146bb00 offset 2048 size 2048   <-- 8KB of data
> >   frag_page 0xc146bb40 offset 2048 size 2048
> >   frag_page 0xc146bb60 offset 0 size 2048
> >   frag_page 0xc146bb80 offset 2048 size 2048
> >
> >  skb 0xe99ada80 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP
header
> >   frag_page 0xc146bbc0 offset 0 size 2048      <-- 8KB of data
> >   frag_page 0xc146bc00 offset 2048 size 2048
> >   frag_page 0xc146bc20 offset 0 size 2048
> >   frag_page 0xc146bc40 offset 2048 size 2048
> >
> >  skb 0xebc4c300 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP
header
> >   frag_page 0xc146bc60 offset 0 size 2048      <-- 8KB of data
> >   frag_page 0xc146bca0 offset 0 size 2048
> >   frag_page 0xc146bcc0 offset 0 size 2048
> >   frag_page 0xc146bce0 offset 2048 size 2048
> >
> > As you can see the data is 2KB aligned.
>=20
> So you suggest we could "sometimes" (maybe even "most of the time")
> get_page, assign to bvec, submit, and on completion adjust skb for the
> "recvmsg" that never happens.
> We'd still need the "slowpath" memcpy code for those fragments that
> happen to be not aligned.
> And we'd need ot convert DRBDs currently blocking network IO
> into something that uses the sk_*_callbacks directly.
>=20
> But yes, this seems to be possible.

After reading the code more closely, it looks to me that it is not
necessary to use the callbacks - tcp_read_sock() can be used
"synchronously" and can be mixed with regular sock_recvmsg(). I put
together a prototype implementation that integrates fastpath/slowpath
(see the patch below). It worked fine in my limited testing and pretty
much completely eliminated receive data coping for /dev/drbd0. This
prototype is just a proof of concept and not a "commercial strength"
code by any stretch (at the very least it needs to include signal
handling and use drbd memory pools for page allocation). But hopefully
it would be useful if you decide to include zero copy receive feature in
DRBD.

I also modified ixgbe 10Gig driver to do use 4KB aligned buffer instead
of 2KB. This further reduced the overhead, but it is not necessary - the
patch works with the original alignment.=20

>=20
> > > > +     /* give a worker thread a chance to pick up the request */
> > > > +	if (remote) {
> > > > +            if (!in_atomic())
> > > > +                    schedule();
> > >
> > > You may well drop the if (!in_atomic()),
> > > it cannot possibly be in atomic context there.
> >
> > if (!in_atomic()) is paranoia ;-)
>=20
> It there are several potentially sleeping functions called before from
> this context, so it probably had BUG()ed before if it was atomic.

Agree.

>=20
> > > Also, the immediately preceding spin_unlock_irq() is a pre-emption
> > > point.  So actually this should not even be necessary.
> >
> > It is necessary in our case - our kernel is compiled without
> > CONFIG_PREEMPT so threads are not preemptable in the kernel. So may
be
> > another drbd configuration option would be useful here.
> >
> > > > diff -aur src.orig/drbd/drbd_worker.c src/drbd/drbd_worker.c
> > > > --- src.orig/drbd/drbd_worker.c	2010-04-01 15:47:54.000000000
> > -0400
> > > > +++ src/drbd/drbd_worker.c	2010-04-26 18:25:17.000000000
-0400
> > > > @@ -1237,6 +1237,9 @@
> > > >
> > > >  	sprintf(current->comm, "drbd%d_worker",
mdev_to_minor(mdev));
> > > >
> > > > +	current->policy =3D SCHED_RR;  /* Make this a realtime
task! */
> > > > +	current->rt_priority =3D 2;    /* more important than all
other
> > > > tasks */
> > > > +
> > >
> > > Not sure about this.
> > > I don't really want to do crypto operations
> > > from a real time kernel thread.
> >
> > Sure, I agree. Though in our case we do not use crypto stuff. So how
> > about one more drbd configuration option? ;-)
>=20
> We'll talk this through.  But please try the mentioned drbdsetup
> cpu-mask stuff, that should make the drbd worker thread send the
request
> from an other cpu even while this context is still submitting it
locally.
>=20

Thanks, Lars. I tried your suggestion. It did not help on its own. But
when I combined it with making the worker thread run at real time
priority 2, scheduling delay was almost as small as with the schedule()
hack - one or two usecs worse. This hack might still be useful on a
single CPU systems.

---------------- zero copy receive patch

diff -awur src-a/drbd/drbd_int.h src-b/drbd/drbd_int.h
--- src-a/drbd/drbd_int.h	2010-05-05 13:59:18.000000000 -0400
+++ src-b/drbd/drbd_int.h	2010-05-05 14:13:04.000000000 -0400
@@ -752,11 +752,13 @@
 	__EE_CONFLICT_PENDING,
 	__EE_MAY_SET_IN_SYNC,
 	__EE_IS_BARRIER,
+        __EE_NON_DRBD_PAGE,
 };
 #define EE_CALL_AL_COMPLETE_IO (1<<__EE_CALL_AL_COMPLETE_IO)
 #define EE_CONFLICT_PENDING    (1<<__EE_CONFLICT_PENDING)
 #define EE_MAY_SET_IN_SYNC     (1<<__EE_MAY_SET_IN_SYNC)
 #define EE_IS_BARRIER          (1<<__EE_IS_BARRIER)
+#define EE_NON_DRBD_PAGE       (1<<__EE_NON_DRBD_PAGE)
=20
 /* global flag bits */
 enum {
diff -awur src-a/drbd/drbd_main.c src-b/drbd/drbd_main.c
--- src-a/drbd/drbd_main.c	2010-05-11 21:58:36.000000000 -0400
+++ src-b/drbd/drbd_main.c	2010-05-11 13:25:49.000000000 -0400
@@ -2174,7 +2174,8 @@
 {
 	struct bio_vec *bvec;
 	int i;
-        unsigned int len;
+        unsigned int togle =3D (flags & MSG_MORE) ? (flags & MSG_MORE) =
:
0;=20
+        unsigned int len =3D 0;
=20
 	__bio_for_each_segment(bvec, bio, i, 0) {
=20
@@ -2186,6 +2187,8 @@
 			return 0;
=20
 		blk_add_trace_generic(mdev->rq_queue, NULL, 0,
BLK_TA_GETRQ);
+                if (togle)
+                   flags ^=3D togle;
 	}
=20
 	return 1;
diff -awur src-a/drbd/drbd_receiver.c src-b/drbd/drbd_receiver.c
--- src-a/drbd/drbd_receiver.c	2010-05-05 13:59:18.000000000 -0400
+++ src-b/drbd/drbd_receiver.c	2010-05-11 21:54:01.000000000 -0400
@@ -314,6 +314,53 @@
 	return NULL;
 }
=20
+struct Tl_epoch_entry *drbd_alloc_zc_ee(struct drbd_conf *mdev,
+                                        u64 id,
+                                        sector_t sector,
+                                        unsigned int data_size,
+                                        gfp_t gfp_mask)
__must_hold(local)
+{
+	struct Tl_epoch_entry *e;
+	struct bio *bio;
+
+	e =3D mempool_alloc(drbd_ee_mempool, gfp_mask);
+	if (!e) {
+		ERR("alloc_zc_ee: Allocation of an EE failed\n");
+		return NULL;
+	}
+
+	bio =3D bio_alloc(GFP_KERNEL, div_ceil(data_size, 512));
+	if (!bio) {
+		ERR("alloc_zc_ee: Allocation of a bio failed\n");
+		goto fail1;
+	}
+
+	bio->bi_bdev =3D mdev->bc->backing_bdev;
+	bio->bi_sector =3D sector;
+	bio->bi_private =3D e;
+	e->mdev =3D mdev;
+	e->sector =3D sector;
+	/* e->size =3D bio->bi_size; */
+
+	e->private_bio =3D bio;
+	e->block_id =3D id;
+	INIT_HLIST_NODE(&e->colision);
+	e->epoch =3D NULL;
+	e->flags =3D EE_NON_DRBD_PAGE;
+
+	MTRACE(TraceTypeEE, TraceLvlAll,
+	       INFO("allocated EE sec=3D%llus size=3D%u ee=3D%p\n",
+		    (unsigned long long)sector, data_size, e);
+	       );
+
+	return e;
+
+ fail1:
+	mempool_free(e, drbd_ee_mempool);
+
+	return NULL;
+}
+
 void drbd_free_ee(struct drbd_conf *mdev, struct Tl_epoch_entry *e)
 {
 	struct bio *bio =3D e->private_bio;
@@ -326,6 +373,9 @@
 	       );
=20
 	__bio_for_each_segment(bvec, bio, i, 0) {
+                if (e->flags & EE_NON_DRBD_PAGE)=20
+                    __free_page(bvec->bv_page);
+                else=20
 		drbd_pp_free(mdev, bvec->bv_page);
 	}
=20
@@ -598,6 +648,184 @@
 	return rv;
 }
=20
+typedef struct _drbd_read_descriptor {
+        read_descriptor_t rd_desc;
+        int               rd_vcnt;
+        struct bio_vec    *rd_vec;
+} drbd_read_descriptor_t;=20
+
+#define DRBD_SKB_DATA_ALLIGNMENT (512)
+#define DRBD_DATA_ALIGNED(_x) (((_x) & (DRBD_SKB_DATA_ALLIGNMENT-1)) =
=3D=3D
0)
+
+static int drbd_tcp_data_recv(read_descriptor_t *rd_desc, struct
sk_buff *skb,=20
+                              unsigned int offset, size_t skb_len)
+{
+        drbd_read_descriptor_t *drbd_rd_desc =3D=20
+           (drbd_read_descriptor_t *)rd_desc;
+
+        struct skb_frag_struct *frag =3D &skb_shinfo(skb)->frags[0];
+        struct bio_vec  *bvec =3D
&drbd_rd_desc->rd_vec[drbd_rd_desc->rd_vcnt];
+        size_t ds =3D rd_desc->count - rd_desc->written;
+        size_t len =3D  min_t(size_t, ds, skb_len);
+        int    i, consumed =3D 0;
+
+        BUG_ON(offset >=3D skb->len);
+        BUG_ON(rd_desc->count <=3D rd_desc->written);
+
+        if (skb->h.th->fin || skb->h.th->rst || offset <
skb_headlen(skb))
+            goto done;
+
+        offset -=3D skb_headlen(skb);
+
+        if (!DRBD_DATA_ALIGNED(offset))
+            goto done;
+
+        /* find the fragment */
+        for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++, frag++) {
+
+            if (offset < frag->size)=20
+                break;
+            offset -=3D frag->size;
+        }
+
+        /* we'll optimize only "whole fragment consumption" case */
+        if (offset !=3D 0)
+            goto done;
+
+        for (;i < skb_shinfo(skb)->nr_frags && len > 0; i++, frag++) {
+
+            /* make sure the fragment is alligned */
+            if (!DRBD_DATA_ALIGNED(frag->size) ||=20
+                !DRBD_DATA_ALIGNED(frag->page_offset))
+                goto done;
+
+            ds =3D min_t(size_t, len, frag->size);
+
+            BUG_ON((consumed + ds) > skb_len);
+
+            /* check if the fragment is mergeable with the previous one
*/
+            if (drbd_rd_desc->rd_vcnt > 0) {
+
+                struct bio_vec *bvec_prev =3D bvec - 1;
+
+                if (bvec_prev->bv_page =3D=3D frag->page &&
+                    (bvec_prev->bv_offset + bvec_prev->bv_len) =3D=3D=20
+                    frag->page_offset) {
+
+                    bvec_prev->bv_len +=3D ds;
+                    consumed +=3D ds;
+
+                    continue;
+                }
+            }
+
+            /* consume the fragment */
+            get_page(frag->page);
+            bvec->bv_page =3D frag->page;
+            bvec->bv_len =3D ds;
+            bvec->bv_offset =3D frag->page_offset;
+
+            bvec++;
+            drbd_rd_desc->rd_vcnt++;
+            consumed +=3D ds;
+            len -=3D ds;
+        }
+       =20
+ done:
+        drbd_rd_desc->rd_desc.written +=3D consumed;
+
+        /* mark misalignment case */
+        if (consumed < len || rd_desc->count =3D=3D rd_desc->written)
+            drbd_rd_desc->rd_desc.count =3D 0;
+
+        return consumed;
+}
+
+STATIC int drbd_zc_recv(struct drbd_conf *mdev,=20
+                        drbd_read_descriptor_t *drbd_rd_desc, size_t
size)
+{
+	   int i, rc =3D 0, rr, ds =3D (int)size, rv =3D (int) size;
+
+        struct sock *sk =3D mdev->data.socket->sk;
+        struct page *page;
+
+	   drbd_rd_desc->rd_desc.count =3D size;
+	   drbd_rd_desc->rd_desc.arg.data =3D mdev;
+
+        /* try to get the data through tcp_read_sock first */
+
+        lock_sock(sk);
+
+        while (ds > 0) {
+
+            long timeo =3D sock_rcvtimeo(sk, 0);
+
+            if ((rc =3D sk_wait_data(sk, &timeo)) =3D=3D 0)
+                break;
+
+            read_lock(&sk->sk_callback_lock);
+            rc =3D tcp_read_sock(sk, &drbd_rd_desc->rd_desc,
drbd_tcp_data_recv);
+            read_unlock(&sk->sk_callback_lock);
+               =20
+            if (rc < 0) {
+                release_sock(sk);
+                drbd_force_state(mdev, NS(conn, BrokenPipe));
+                rv =3D -EIO;
+                goto done;
+            }
+
+            D_ASSERT(drbd_rd_desc->rd_desc.written <=3D size);
+
+            ds =3D size - drbd_rd_desc->rd_desc.written;
+           =20
+            if (ds > 0 && drbd_rd_desc->rd_desc.count =3D=3D 0)=20
+                break;
+        }
+
+        release_sock(sk);
+
+        /* get the rest of the data, if any, through regular
sock_recvmsg */
+        while(ds > 0) {
+
+            struct bio_vec *bvec =3D=20
+                &drbd_rd_desc->rd_vec[drbd_rd_desc->rd_vcnt];
+
+            if ((page =3D alloc_page(GFP_KERNEL)) =3D=3D NULL) {
+                rv =3D -ENOMEM;
+                goto done;
+            }
+
+            bvec->bv_page =3D page;
+            bvec->bv_len =3D min_t(int, ds, PAGE_SIZE);
+            bvec->bv_offset =3D 0;
+            drbd_rd_desc->rd_vcnt++;
+
+            rr =3D drbd_recv(mdev, kmap(page), bvec->bv_len);
+            kunmap(page);
+
+            if (rr !=3D min_t(int, ds, PAGE_SIZE)) {
+                   =20
+                drbd_WARN("short read receiving data: read %d expected
%d\n",
+                          rr, min_t(int, ds, PAGE_SIZE));
+                rv =3D -EIO;
+                goto done;
+            }
+
+            ds -=3D rr;
+        }
+
+ done:
+        if (rv < 0) {
+
+            /* free the pages pages */
+            for (i =3D 0; i < drbd_rd_desc->rd_vcnt; i++)=20
+                __free_page(drbd_rd_desc->rd_vec[i].bv_page);=20
+        }
+
+	return rv;
+}
+
+
 STATIC struct socket *drbd_try_connect(struct drbd_conf *mdev)
 {
 	const char *what;
@@ -1352,6 +1580,7 @@
 	int dgs, ds, i, rr;
 	void *dig_in =3D mdev->int_dig_in;
 	void *dig_vv =3D mdev->int_dig_vv;
+        int use_zc =3D (mdev->minor =3D=3D 0) ? 1 : 0;
=20
 	dgs =3D (mdev->agreed_pro_version >=3D 87 && mdev->integrity_r_tfm)
?
 		crypto_hash_digestsize(mdev->integrity_r_tfm) : 0;
@@ -1370,11 +1599,62 @@
 	ERR_IF(data_size &  0x1ff) return NULL;
 	ERR_IF(data_size >  DRBD_MAX_SEGMENT_SIZE) return NULL;
=20
+        if (use_zc)=20
+            e =3D drbd_alloc_zc_ee(mdev, id, sector, data_size,
GFP_KERNEL);
+        else
 	e =3D drbd_alloc_ee(mdev, id, sector, data_size, GFP_KERNEL);
 	if (!e)
 		return NULL;
 	bio =3D e->private_bio;
 	ds =3D data_size;
+
+        if (use_zc) {
+           =20
+            drbd_read_descriptor_t drbd_rd_desc;
+            int err =3D 0;
+
+            memset(&drbd_rd_desc, 0, sizeof(drbd_rd_desc));
+            drbd_rd_desc.rd_vec =3D bio->bi_io_vec;
+
+            if ((rr =3D drbd_zc_recv(mdev, &drbd_rd_desc, ds)) !=3D ds) =
{
+                drbd_free_ee(mdev, e);
+                drbd_WARN("short read receiving data: read %d expected
%d\n",
+                          rr, ds);
+                return NULL;
+            }
+
+            for (i =3D 0; i < drbd_rd_desc.rd_vcnt; i++) {
+               =20
+                struct bio_vec *bvec =3D &bio->bi_io_vec[i];
+                page =3D bvec->bv_page;
+
+                if (err) {
+                    __free_page(page);
+                }
+                else if (!bio_add_page(bio, page, bvec->bv_len,=20
+                                       bvec->bv_offset)) {
+
+                    ERR("alloc_ee: bio_add_page(s=3D%llu,"
+                        "data_size=3D%u,ds=3D%u) failed\n",
+                        (unsigned long long)sector, data_size, ds);
+                    __free_page(page);
+                    err =3D -1;
+                }
+                else {
+                    ds -=3D bvec->bv_len;
+                }
+            }
+
+            if (err) {
+                drbd_free_ee(mdev, e);
+                return NULL;
+            }
+
+            D_ASSERT(data_size =3D=3D bio->bi_size);
+
+            e->size =3D bio->bi_size;
+        }
+        else {
 	bio_for_each_segment(bvec, bio, i) {
 		page =3D bvec->bv_page;
 		rr =3D drbd_recv(mdev, kmap(page), min_t(int, ds,
PAGE_SIZE));
@@ -1387,6 +1667,7 @@
 		}
 		ds -=3D rr;
 	}
+        }
=20
 	if (dgs) {
 		drbd_csum(mdev, mdev->integrity_r_tfm, bio, dig_vv);
