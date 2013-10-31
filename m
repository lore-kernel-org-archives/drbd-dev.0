Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8AA8F10583DF
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:59:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4E8F045C73F
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:59:35 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ek7ZVLGSIgww for <drbd-dev@lists.linbit.com>;
	Fri,  8 Nov 2013 15:59:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2FA5045CA36
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:59:35 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kbZW6drNDiCz for <drbd-dev@lists.linbit.com>;
	Fri,  8 Nov 2013 15:59:35 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0E4E345C73F
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:59:35 +0100 (CET)
Resent-Message-ID: <20131108145935.GK4144@soda.linbit>
Received: from server506.appriver.com (server506h.appriver.com [50.56.144.38])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C522210579C9
	for <drbd-dev@lists.linbit.com>; Thu, 31 Oct 2013 18:19:59 +0100 (CET)
MIME-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
From: Ed Cashin <ecashin@coraid.com>
In-Reply-To: <1383077896-4132-5-git-send-email-kmo@daterainc.com>
Date: Thu, 31 Oct 2013 13:14:48 -0400
Content-Transfer-Encoding: 7bit
Message-ID: <B60197FE-BC53-4EBA-8F78-02E4D9D31844@coraid.com>
References: <1383077896-4132-1-git-send-email-kmo@daterainc.com>
	<1383077896-4132-5-git-send-email-kmo@daterainc.com>
To: Kent Overstreet <kmo@daterainc.com>
Cc: Lars, Andreas, Mike Snitzer <snitzer@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	Joshua Morris <josh.h.morris@us.ibm.com>, "James E.J.
	Bottomley" <JBottomley@parallels.com>, hch@infradead.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mel Gorman <mgorman@suse.de>, Nitin Gupta <ngupta@vflare.org>,
	Len Brown <len.brown@intel.com>, Sage Weil <sage@inktank.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Joern Engel <joern@logfs.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Sunil Mushran <sunil.mushran@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Sadeh <yehuda@inktank.com>, Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Steven, Joe Perches <joe@perches.com>, Guo Chao <yan@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Kleikamp <shaggy@kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
	Pankaj Kumar <pankaj.km@samsung.com>, Matthew, dm-devel@redhat.com,
	KONISHI Ryusuke <konishi.ryusuke@lab.ntt.co.jp>,
	Alasdair Kergon <agk@redhat.com>, Ellenberg <drbd-dev@lists.linbit.com>,
	Namjae Jeon <namjae.jeon@samsung.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Jie Liu <jeff.liu@oracle.com>, Mark Fasheh <mfasheh@suse.com>,
	Chris, Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
	Asai Thambi S P <asamymuthupa@micron.com>,
	Prasad Joshi <prasadjoshi.linux@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, tj@kernel.org,
	Ben Myers <bpm@sgi.com>, Jerome Marchand <jmarchand@redhat.com>,
	Selvan Mani <smani@micron.com>, Theodore Ts'o <tytso@mit.edu>,
	Minchan Kim <minchan@kernel.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Mason <chris.mason@fusionio.com>, fanchaoting <fanchaoting@cn.fujitsu.com>,
	Jan Beulich <jbeulich@suse.com>, Jaegeuk Kim <jaegeuk.kim@samsung.com>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Andy Adamson <andros@netapp.com>, Ben Hutchings <ben@decadent.org.uk>,
	Dan Magenheimer <dan.magenheimer@oracle.com>,
	Nick Piggin <npiggin@kernel.dk>, Rostedt <rostedt@goodmis.org>,
	xfs@oss.sgi.com, Wilcox <willy@linux.intel.com>,
	ceph-devel@vger.kernel.org, Alex Elder <elder@inktank.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sam Bradshaw <sbradshaw@micron.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	=?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>,
	Ian Campbell <Ian.Campbell@citrix.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Neil Brown <neilb@suse.de>, Peng Tao <tao.peng@emc.com>,
	Dilger <adilger.kernel@dilger.ca>, Jiang Liu <jiang.liu@huawei.com>,
	Benny Halevy <bhalevy@tonian.com>, Yehuda,
	Molnar <mingo@redhat.com>, Boaz Harrosh <bharrosh@panasas.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>,
	Steven Whitehouse <swhiteho@redhat.com>, axboe@kernel.dk,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Becker <jlbec@evilplan.org>
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

On Oct 29, 2013, at 4:17 PM, Kent Overstreet wrote:

> Immutable biovecs are going to require an explicit iterator. To
> implement immutable bvecs, a later patch is going to add a bi_bvec_done
> member to this struct; for now, this patch effectively just renames
> things.

Ack.  These patches pass sanity-check testing, too, for aoe.

-- 
  Ed Cashin
  ecashin@coraid.com


