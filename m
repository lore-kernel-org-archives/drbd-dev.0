Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3BDED1058E29
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:44:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 335EE1B4386
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:44:06 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJGY2+x2-RkC for <drbd-dev@lists.linbit.com>;
	Fri,  9 Aug 2013 09:44:06 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id D7DDB1B4383
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:44:05 +0200 (CEST)
Resent-Message-ID: <20130809074405.GO10571@soda.linbit>
Received: from server506.appriver.com (server506h.appriver.com [50.56.144.38])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E57FE1058E03
	for <drbd-dev@lists.linbit.com>; Thu,  8 Aug 2013 04:09:49 +0200 (CEST)
MIME-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
From: Ed Cashin <ecashin@coraid.com>
In-Reply-To: <1375912471-5106-5-git-send-email-kmo@daterainc.com>
Date: Wed, 7 Aug 2013 22:04:36 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <2D8F228B-65AE-4046-A910-6B354AF0058E@coraid.com>
References: <1375912471-5106-1-git-send-email-kmo@daterainc.com>
	<1375912471-5106-5-git-send-email-kmo@daterainc.com>
To: Kent Overstreet <kmo@daterainc.com>
Cc: Ingo, Mike Snitzer <snitzer@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	Joshua Morris <josh.h.morris@us.ibm.com>, "James E.J.
	Bottomley" <JBottomley@parallels.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mel Gorman <mgorman@suse.de>, Heiko,
	Nitin Gupta <ngupta@vflare.org>, Len Brown <len.brown@intel.com>,
	Sage Weil <sage@inktank.com>,
	Myklebust <Trond.Myklebust@netapp.com>, Engel <joern@logfs.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Sunil Mushran <sunil.mushran@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Yehuda Sadeh <yehuda@inktank.com>, Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Steven, Joe Perches <joe@perches.com>, Guo Chao <yan@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Kleikamp <shaggy@kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
	Pankaj Kumar <pankaj.km@samsung.com>, dm-devel@redhat.com,
	KONISHI Ryusuke <konishi.ryusuke@lab.ntt.co.jp>,
	Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Namjae Jeon <namjae.jeon@samsung.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Jie Liu <jeff.liu@oracle.com>, Asai Thambi S P <asamymuthupa@micron.com>,
	Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
	Mark Fasheh <mfasheh@suse.com>, Prasad Joshi <prasadjoshi.linux@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>,
	Ben Myers <bpm@sgi.com>, Jerome Marchand <jmarchand@redhat.com>,
	Mani <smani@micron.com>, Theodore Ts'o <tytso@mit.edu>,
	Minchan Kim <minchan@kernel.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Trond, Frederic Weisbecker <fweisbec@gmail.com>,
	Carstens <heiko.carstens@de.ibm.com>,
	Chris Mason <chris.mason@fusionio.com>,
	fanchaoting <fanchaoting@cn.fujitsu.com>, Jan Beulich <jbeulich@suse.com>,
	Jaegeuk Kim <jaegeuk.kim@samsung.com>, Joern,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Andy Adamson <andros@netapp.com>, Ben Hutchings <ben@decadent.org.uk>,
	Dan Magenheimer <dan.magenheimer@oracle.com>,
	Nick Piggin <npiggin@kernel.dk>, Rostedt <rostedt@goodmis.org>,
	xfs@oss.sgi.com, Matthew Wilcox <willy@linux.intel.com>,
	ceph-devel@vger.kernel.org, Alex Elder <elder@inktank.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sam Bradshaw <sbradshaw@micron.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-fsdevel@vger.kernel.org,
	=?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>,
	Ian Campbell <Ian.Campbell@citrix.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, neilb@suse.de,
	Peng Tao <tao.peng@emc.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Selvan,
	Jiang Liu <jiang.liu@huawei.com>,
	Benny Halevy <bhalevy@tonian.com>, Molnar <mingo@redhat.com>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-raid@vger.kernel.org, Whitehouse <swhiteho@redhat.com>,
	axboe@kernel.dk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Becker <jlbec@evilplan.org>
Subject: Re: [Drbd-dev] [PATCH 04/22] block: Abstract out bvec iterator
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

On Aug 7, 2013, at 5:54 PM, Kent Overstreet wrote:

> Immutable biovecs are going to require an explicit iterator. To
> implement immutable bvecs, a later patch is going to add a =
bi_bvec_done
> member to this struct; for now, this patch effectively just renames
> things.

Hi, Kent Overstreet.  Thanks for Cc'ing me and for the promising work.

Were you able to do sanity tests with aoe this time around?  Last time, =
basic I/O was not working with the immutable biovec patches applied.

Here is my 28 June email about my experiences with =
git://evilpiepirate.org/~kent/linux-bcache.git at that time.  It also =
includes information about creating an easy software-only aoe test =
environment.

  http://thread.gmane.org/gmane.linux.kernel/1505222/focus=3D1517924

--=20
  Ed Cashin
  ecashin@coraid.com


