Return-Path: <neilb@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3472D10579BD
	for <drbd-dev@lists.linbit.com>; Thu, 31 Oct 2013 04:43:55 +0100 (CET)
Date: Thu, 31 Oct 2013 14:29:36 +1100
From: NeilBrown <neilb@suse.de>
To: Kent Overstreet <kmo@daterainc.com>
Message-ID: <20131031142936.63727342@notabene.brown>
In-Reply-To: <1383077896-4132-5-git-send-email-kmo@daterainc.com>
References: <1383077896-4132-1-git-send-email-kmo@daterainc.com>
	<1383077896-4132-5-git-send-email-kmo@daterainc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/bF/+0261ZWlTgozZbA48+3r";
	protocol="application/pgp-signature"
Cc: Dave Kleikamp <shaggy@kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
	Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>,
	Jan Beulich <jbeulich@suse.com>, "Ed L. Cashin" <ecashin@coraid.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Selvan Mani <smani@micron.com>, Namjae Jeon <namjae.jeon@samsung.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Chris Mason <chris.mason@fusionio.com>, dm-devel@redhat.com,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	KONISHI Ryusuke <konishi.ryusuke@lab.ntt.co.jp>,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Nick Piggin <npiggin@kernel.dk>,
	Roger Pau =?UTF-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Joe Perches <joe@perches.com>, Mike Snitzer <snitzer@redhat.com>,
	Len Brown <len.brown@intel.com>,
	Minchan Kim <minchan@kernel.org>, Jie Liu <jeff.liu@oracle.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Steven Whitehouse <swhiteho@redhat.com>, hch@infradead.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Mel Gorman <mgorman@suse.de>, Boaz Harrosh <bharrosh@panasas.com>,
	Matthew Wilcox <willy@linux.intel.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Prasad Joshi <prasadjoshi.linux@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Alex Elder <elder@inktank.com>,
	Dan Magenheimer <dan.magenheimer@oracle.com>,
	Ian Campbell <Ian.Campbell@citrix.com>,
	Peng Tao <tao.peng@emc.com>, Sage Weil <sage@inktank.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Pankaj Kumar <pankaj.km@samsung.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Joern Engel <joern@logfs.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Steven Rostedt <rostedt@goodmis.org>, xfs@oss.sgi.com,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Ben Myers <bpm@sgi.com>, Jerome Marchand <jmarchand@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Adamson <andros@netapp.com>,
	Sam Bradshaw <sbradshaw@micron.com>, Jaegeuk Kim <jaegeuk.kim@samsung.com>,
	ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@inktank.com>,
	axboe@kernel.dk, Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sunil Mushran <sunil.mushran@gmail.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	Asai Thambi S P <asamymuthupa@micron.com>, linux-kernel@vger.kernel.org,
	fanchaoting <fanchaoting@cn.fujitsu.com>,
	Benny Halevy <bhalevy@tonian.com>, Jiang Liu <jiang.liu@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tj@kernel.org,
	linux390@de.ibm.com, Mark Fasheh <mfasheh@suse.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, Joel Becker <jlbec@evilplan.org>
Subject: Re: [Drbd-dev] [PATCH 04/23] block: Abstract out bvec iterator
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

--Sig_/bF/+0261ZWlTgozZbA48+3r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2013 13:17:57 -0700 Kent Overstreet <kmo@daterainc.com> wrot=
e:

> Immutable biovecs are going to require an explicit iterator. To
> implement immutable bvecs, a later patch is going to add a bi_bvec_done
> member to this struct; for now, this patch effectively just renames
> things.
>=20
> Signed-off-by: Kent Overstreet <kmo@daterainc.com>


> diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.=
txt
> index 8df5e8e..2101e71 100644
> --- a/Documentation/block/biodoc.txt
> +++ b/Documentation/block/biodoc.txt
> @@ -447,14 +447,13 @@ struct bio_vec {
>   * main unit of I/O for the block layer and lower layers (ie drivers)
>   */
>  struct bio {
> -       sector_t            bi_sector;
>         struct bio          *bi_next;    /* request queue link */
>         struct block_device *bi_bdev;	/* target device */
>         unsigned long       bi_flags;    /* status, command, etc */
>         unsigned long       bi_rw;       /* low bits: r/w, high: priority=
 */
> =20
>         unsigned int	bi_vcnt;     /* how may bio_vec's */
> -       unsigned int	bi_idx;		/* current index into bio_vec array */
> +       struct bvec_iter	bi_iter;	/* current index into bio_vec array */
> =20
>         unsigned int	bi_size;     /* total size in bytes */
>         unsigned short 	bi_phys_segments; /* segments after physaddr coal=
esce*/
> @@ -480,7 +479,7 @@ With this multipage bio design:
>  - Code that traverses the req list can find all the segments of a bio
>    by using rq_for_each_segment.  This handles the fact that a request
>    has multiple bios, each of which can have multiple segments.
> -- Drivers which can't process a large bio in one shot can use the bi_idx
> +- Drivers which can't process a large bio in one shot can use the bi_iter
>    field to keep track of the next bio_vec entry to process.
>    (e.g a 1MB bio_vec needs to be handled in max 128kB chunks for IDE)
>    [TBD: Should preferably also have a bi_voffset and bi_vlen to avoid mo=
difying
> @@ -589,7 +588,7 @@ driver should not modify these values. The block laye=
r sets up the
>  nr_sectors and current_nr_sectors fields (based on the corresponding
>  hard_xxx values and the number of bytes transferred) and updates it on
>  every transfer that invokes end_that_request_first. It does the same for=
 the
> -buffer, bio, bio->bi_idx fields too.
> +buffer, bio, bio->bi_iter fields too.
> =20
>  The buffer field is just a virtual address mapping of the current segment
>  of the i/o buffer in cases where the buffer resides in low-memory. For h=
igh

Would it make sense to add some details of "bvec_iter" to this document?

Or will that come later?

NeilBrown

--Sig_/bF/+0261ZWlTgozZbA48+3r
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUnHOoDnsnt1WYoG5AQKAog//cNxNO7n4EheLQg3FVtX4edv6npapiTlQ
IuJ8LixK5hK5kx0hDsPaK78n6ZLs3DADc6/d3HtLc33L90l2WhWUMm8SiJowacKu
HemHPkt/dmUGvCWL1eaoPA2TVAvrIELUCKaMjQOe6s1eAamthbINelirjFtBpj/p
bX6KyU/eYMiBrS0QqpXE0oeOnUj1qrC0Too9qCGA9wKL8SIOXB8fZ4+kxi9qyYZk
bShLMjvvkouYMq4wSnz9ZdekQIA0XjS8S8ui4idKXzwrXq23aJbJT/JTQ+tprXhN
Wa2N4bwo/EI36xIvGsqx1eu1rmOqmYbJNi8rNt9Sbr5CM9tioeq3wkUKOiRMQznx
NJnhkvzEhGZ/0IYp19HOSHCQooAE2gOltCHvv24MXks0BUT62w1KS2CKTY5BAsxU
42aEqOXN5XW6hsl1GUz2csJn9/U03s+ifJZn9DlrNvSen7eQfFXXvJeE29JUVtuO
i+/ePbxEbLNNGFDLH8qzTTSW+ikV034OljYBXUGtyJAwVzXIsP2kg4tfDAiSRhFk
l8qYT8jWHfiknCbn4E0pZd3gcfqBpdk2zNlf7y6PhlDGumP6PCcb5hlSYM7TZK/g
Y/xFRdI889P4aEIcePPVKYBcBFdcrj6SDvqp3S+G8MZgcvsQAv20MxqKPpESUVrT
CTs9IhepD+0=
=7uUB
-----END PGP SIGNATURE-----

--Sig_/bF/+0261ZWlTgozZbA48+3r--
