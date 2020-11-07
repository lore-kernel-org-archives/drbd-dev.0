Return-Path: <xjtuwjp@gmail.com>
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
	[209.85.167.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 92E374206D0
	for <drbd-dev@lists.linbit.com>; Sat,  7 Nov 2020 05:43:26 +0100 (CET)
Received: by mail-lf1-f66.google.com with SMTP id i6so4831242lfd.1
	for <drbd-dev@lists.linbit.com>; Fri, 06 Nov 2020 20:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20201106190337.1973127-1-hch@lst.de>
	<20201106190337.1973127-25-hch@lst.de>
In-Reply-To: <20201106190337.1973127-25-hch@lst.de>
From: Jack Wang <xjtuwjp@gmail.com>
Date: Sat, 7 Nov 2020 05:43:14 +0100
Message-ID: <CAD+HZHUaPLB0T2A3vAPq6gSr5gEGK3XLMSAmO0FLhkWaLzPBpg@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: multipart/alternative; boundary="0000000000003da75005b37cf8d6"
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
	xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Subject: Re: [Drbd-dev] [PATCH 24/24] block: unexport revalidate_disk_size
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

--0000000000003da75005b37cf8d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de>=E4=BA=8E2020=E5=B9=B411=E6=9C=886=E6=97=A5 =
=E5=91=A8=E4=BA=9420:15=E5=86=99=E9=81=93=EF=BC=9A

> revalidate_disk_size is not only called from set_capacity_and_notify,
> so drop the export.

s/not/now

>
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks!
Jack Wang

>
> ---
>  fs/block_dev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 66ebf594c97f47..d8664f5c1ff669 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1362,7 +1362,6 @@ void revalidate_disk_size(struct gendisk *disk, boo=
l
> verbose)
>                 bdput(bdev);
>         }
>  }
> -EXPORT_SYMBOL(revalidate_disk_size);
>
>  void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
>  {
> --
> 2.28.0
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>

--0000000000003da75005b37cf8d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de">hch@lst=
.de</a>&gt;=E4=BA=8E2020=E5=B9=B411=E6=9C=886=E6=97=A5 =E5=91=A8=E4=BA=9420=
:15=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;padding-left:1ex;border-left-color:rgb(204,204,204)">revalidate_disk_si=
ze is not only called from set_capacity_and_notify,<br>
so drop the export.</blockquote><div dir=3D"auto">s/not/now</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204=
,204)" dir=3D"auto"><br>
<br>
Signed-off-by: Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de" target=
=3D"_blank">hch@lst.de</a>&gt;</blockquote><div dir=3D"auto">Thanks!</div><=
div dir=3D"auto">Jack Wang</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padd=
ing-left:1ex;border-left-color:rgb(204,204,204)" dir=3D"auto"><br>
---<br>
=C2=A0fs/block_dev.c | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/fs/block_dev.c b/fs/block_dev.c<br>
index 66ebf594c97f47..d8664f5c1ff669 100644<br>
--- a/fs/block_dev.c<br>
+++ b/fs/block_dev.c<br>
@@ -1362,7 +1362,6 @@ void revalidate_disk_size(struct gendisk *disk, bool =
verbose)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bdput(bdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
-EXPORT_SYMBOL(revalidate_disk_size);<br>
<br>
=C2=A0void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)<b=
r>
=C2=A0{<br>
-- <br>
2.28.0<br>
<br>
<br>
_______________________________________________<br>
Linux-nvme mailing list<br>
<a href=3D"mailto:Linux-nvme@lists.infradead.org" target=3D"_blank">Linux-n=
vme@lists.infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-nvme" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.infradead.org/mailman/listinfo/li=
nux-nvme</a><br>
</blockquote></div></div>

--0000000000003da75005b37cf8d6--
