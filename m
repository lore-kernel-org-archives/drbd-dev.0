Return-Path: <prvs=6762db3dd=Chaitanya.Kulkarni@wdc.com>
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B1014205F3
	for <drbd-dev@lists.linbit.com>; Thu, 18 Feb 2021 02:35:21 +0100 (CET)
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Pavel Machek <pavel@ucw.cz>
Date: Thu, 18 Feb 2021 01:28:03 +0000
Message-ID: <BYAPR04MB49652FAADFDCAA3DF72DDEE186859@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
	<20210128071133.60335-30-chaitanya.kulkarni@wdc.com>
	<20210217220257.GA10791@amd>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "shaggy@kernel.org" <shaggy@kernel.org>,
	"jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"sergey.senozhatsky.work@gmail.com" <sergey.senozhatsky.work@gmail.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"len.brown@intel.com" <len.brown@intel.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "djwong@kernel.org" <djwong@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"alex.shi@linux.alibaba.com" <alex.shi@linux.alibaba.com>,
	"hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"mark@fasheh.com" <mark@fasheh.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"osandov@fb.com" <osandov@fb.com>,
	"ebiggers@kernel.org" <ebiggers@kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"ngupta@vflare.org" <ngupta@vflare.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"hare@suse.de" <hare@suse.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"tj@kernel.org" <tj@kernel.org>,
	"linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"jlbec@evilplan.org" <jlbec@evilplan.org>,
	"konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "tytso@mit.edu" <tytso@mit.edu>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"jth@kernel.org" <jth@kernel.org>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
	"roger.pau@citrix.com" <roger.pau@citrix.com>
Subject: Re: [Drbd-dev] [RFC PATCH 29/34] power/swap: use bio_new in
	hib_submit_io
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

On 2/17/21 14:03, Pavel Machek wrote:=0A=
> Hi!=0A=
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c=0A=
>> index c73f2e295167..e92e36c053a6 100644=0A=
>> --- a/kernel/power/swap.c=0A=
>> +++ b/kernel/power/swap.c=0A=
>> @@ -271,13 +271,12 @@ static int hib_submit_io(int op, int op_flags, pgo=
ff_t page_off, void *addr,=0A=
>>  		struct hib_bio_batch *hb)=0A=
>>  {=0A=
>>  	struct page *page =3D virt_to_page(addr);=0A=
>> +	sector_t sect =3D page_off * (PAGE_SIZE >> 9);=0A=
>>  	struct bio *bio;=0A=
>>  	int error =3D 0;=0A=
>>  =0A=
>> -	bio =3D bio_alloc(GFP_NOIO | __GFP_HIGH, 1);=0A=
>> -	bio->bi_iter.bi_sector =3D page_off * (PAGE_SIZE >> 9);=0A=
>> -	bio_set_dev(bio, hib_resume_bdev);=0A=
>> -	bio_set_op_attrs(bio, op, op_flags);=0A=
>> +	bio =3D bio_new(hib_resume_bdev, sect, op, op_flags, 1,=0A=
>> +		      GFP_NOIO | __GFP_HIGH);=0A=
>>  =0A=
> C function with 6 arguments... dunno. Old version looks comparable or=0A=
> even more readable...=0A=
>=0A=
> Best regards,=0A=
> 							Pavel=0A=
The library functions that are in the kernel tree which are used=0A=
in different file-systems and fabrics drivers do take 6 arguments.=0A=
=0A=
Plus what is the point of duplicating code for mandatory=0A=
parameters all over the kernel ?=0A=
=0A=
