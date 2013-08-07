Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5E6941058E23
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:43:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 57CBD1B4386
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:43:42 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1wPPq3fxegYe for <drbd-dev@lists.linbit.com>;
	Fri,  9 Aug 2013 09:43:42 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 3C1471B4383
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:43:42 +0200 (CEST)
Resent-Message-ID: <20130809074342.GK10571@soda.linbit>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 588701058DFB
	for <drbd-dev@lists.linbit.com>; Wed,  7 Aug 2013 21:41:19 +0200 (CEST)
Date: Wed, 7 Aug 2013 21:04:53 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Kent Overstreet <kmo@daterainc.com>
Message-ID: <20130807190453.GL2978@katana>
References: <1375896905-6074-1-git-send-email-kmo@daterainc.com>
	<1375897579-8202-7-git-send-email-kmo@daterainc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p7S+EREVcBHk3zUG"
Content-Disposition: inline
In-Reply-To: <1375897579-8202-7-git-send-email-kmo@daterainc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Alon Levy <alevy@redhat.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Inki Dae <inki.dae@samsung.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Teigland <teigland@redhat.com>, Joel Becker <jlbec@evilplan.org>,
	Tim Gardner <tim.gardner@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
	Tejun Heo <tj@kernel.org>, Guo Chao <yan@linux.vnet.ibm.com>,
	akpm@linux-foundation.org, Andy Grover <agrover@redhat.com>,
	Dmitry Torokhov <dtor@vmware.com>, David Airlie <airlied@linux.ie>,
	Anil Gurumurthy <agurumur@brocade.com>, dm-devel@redhat.com,
	Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Eduardo Valentin <eduardo.valentin@ti.com>,
	Dave Airlie <airlied@redhat.com>, Chris Ball <cjb@laptop.org>,
	Hal Rosenstock <hal.rosenstock@gmail.com>, Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Mark Fasheh <mfasheh@suse.com>,
	Mike Marciniszyn <infinipath@intel.com>, Steve Wise <swise@chelsio.com>,
	Maarten Lankhorst <maarten.lankhorst@canonical.com>,
	Anton Vorontsov <cbou@mail.ru>, Kyungmin Park <kyungmin.park@samsung.com>,
	Dan Williams <djbw@fb.com>, James Smart <james.smart@emulex.com>,
	Jason Wang <jasowang@redhat.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Omar Ramirez Luna <omar.ramirez@copitl.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Christine Caulfield <ccaulfie@redhat.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Grant Likely <grant.likely@linaro.org>,
	Sasha Levin <sasha.levin@oracle.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Dan Magenheimer <dan.magenheimer@oracle.com>,
	Alex Dubov <oakad@yahoo.com>, Haggai Eran <haggaie@mellanox.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Tatyana Nikolova <Tatyana.E.Nikolova@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>, Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Kai =?iso-8859-15?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
	David Howells <dhowells@redhat.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
	Michel Lespinasse <walken@google.com>,
	Chas Williams <chas@cmf.nrl.navy.mil>,
	Joonyoung Shim <jy0922.shim@samsung.com>,
	Ingo Molnar <mingo@redhat.com>, Brian Paul <brianp@vmware.com>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Zhang Rui <rui.zhang@intel.com>, Roland Dreier <roland@kernel.org>,
	Erez Shitrit <erezsh@mellanox.co.il>,
	Vijaya Mohan Guvva <vmohan@brocade.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
	Samuel Ortiz <sameo@linux.intel.com>, Jens Axboe <axboe@kernel.dk>,
	Masanari Iida <standby24x7@gmail.com>, Willem Riede <osst@riede.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Drbd-dev] [PATCH 07/10] idr: Rename idr_alloc() ->
	idr_alloc_range()
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


--p7S+EREVcBHk3zUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2013 at 10:46:16AM -0700, Kent Overstreet wrote:
> Then also add an idr_alloc() wrapper, without the start/end arguments -
> for consistency with the ida interfaces.
>=20
> Signed-off-by: Kent Overstreet <kmo@daterainc.com>

For my taste, the motivation of the change could be described in a bit
more detail.


--p7S+EREVcBHk3zUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAppVAAoJEBQN5MwUoCm26uIQAId/2PeKqaXqsDETuLthraz3
dwvZ1p3zPc/6bjMcN6JktGNXo94oTw0oJjNg/sHnXNli7ttY4w74EC8XLV2fCjEm
WCC3M3LhjdnOR2+nqSVloT9rgEB5qXTLLAyVybtKL0wFhg5bKlDm+q1OPzd/SSgU
jg6ij73i0ExD+dqOZyfLfdm9J/5idRLmzFDZy4D9pBHelgPUKJZUQMKDxSQxbx96
hEffCHEdwHuEwErjWA/5oyMsNs7tSAy+9wFg3P2JlceAnZUrI7ycltpH9xLR5yld
jIpOqCYiKZYsWi7owo/xBLlV94xuq8wT3Td5uujGPhwV0pGQzmNuzDlPoAgapyhR
v0bDb/VU4hmioz4ntWMXztXAIxJtlRhQO/v61CMLvs8N45I+hjvuhtxo3xfmm+oh
dDtDCq+eY24kQUyBbJJAiLx289uvlGoK2hQYf3SkAaOWBHZE5Ce9DymmwHrzeMp7
8aTXNtR7iJvkspH8YD1AlogArJUZqx4UKJNvx3N0My8YVFt6ylXzWljkX9qKjWpB
e2teQ8gmBXLzTl1GTNgvcEQR01xMZMaDTSez7MMDfJhcNxWJwJ3YUpFObkgUjZ04
Cai5N1sq452yrxXhdb+soHT5E6H6LqZMgLwaRJSJ1xpx86k+C4aylMj1ER1iQt3Q
GZHEX5PzVgqKJmNFtqG/
=bg1e
-----END PGP SIGNATURE-----

--p7S+EREVcBHk3zUG--
