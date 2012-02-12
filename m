Return-Path: <evdo.hsdpa@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1328852421-19678-59-git-send-email-amwang@redhat.com>
References: <1328852421-19678-1-git-send-email-amwang@redhat.com>
	<1328852421-19678-59-git-send-email-amwang@redhat.com>
Date: Sun, 12 Feb 2012 14:54:08 +0900
Message-ID: <CA+xKNSgdt7mc2NYTbprFspE54R_4T4PTzyGKyKESqBRyaNCPJg@mail.gmail.com>
From: Robert Kim App and Facebook Marketing <evdo.hsdpa@gmail.com>
To: Cong Wang <amwang@redhat.com>
Content-Type: multipart/alternative; boundary=00504501405a87c5ba04b8bdfde0
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 58/60] drbd: remove the second argument of
	k[un]map_atomic()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--00504501405a87c5ba04b8bdfde0
Content-Type: text/plain; charset=ISO-8859-1

Guys... in my email... the code really breaks up bad... is there a version
of the code without any line-breaks????

On Fri, Feb 10, 2012 at 2:40 PM, Cong Wang <amwang@redhat.com> wrote:

> Signed-off-by: Cong Wang <amwang@redhat.com>
> ---
>  drivers/block/drbd/drbd_bitmap.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_bitmap.c
> b/drivers/block/drbd/drbd_bitmap.c
> index 39de9ff..3030201 100644
> --- a/drivers/block/drbd/drbd_bitmap.c
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -289,7 +289,7 @@ static unsigned int bm_bit_to_page_idx(struct
> drbd_bitmap *b, u64 bitnr)
>        return page_nr;
>  }
>
> -static unsigned long *__bm_map_pidx(struct drbd_bitmap *b, unsigned int
> idx, const enum km_type km)
> +static unsigned long *__bm_map_pidx(struct drbd_bitmap *b, unsigned int
> idx)
>  {
>        struct page *page = b->bm_pages[idx];
>        return (unsigned long *) kmap_atomic(page);
> @@ -551,7 +551,7 @@ static unsigned long bm_count_bits(struct drbd_bitmap
> *b)
>        }
>        /* last (or only) page */
>        last_word = ((b->bm_bits - 1) & BITS_PER_PAGE_MASK) >> LN2_BPL;
> -       p_addr = __bm_map_pidx(b, idx, KM_USER0);
> +       p_addr = __bm_map_pidx(b, idx);
>        for (i = 0; i < last_word; i++)
>                bits += hweight_long(p_addr[i]);
>        p_addr[last_word] &= cpu_to_lel(mask);
> @@ -559,7 +559,7 @@ static unsigned long bm_count_bits(struct drbd_bitmap
> *b)
>        /* 32bit arch, may have an unused padding long */
>        if (BITS_PER_LONG == 32 && (last_word & 1) == 0)
>                p_addr[last_word+1] = 0;
> -       __bm_unmap(p_addr, KM_USER0);
> +       __bm_unmap(p_addr);
>        return bits;
>  }
>
> @@ -970,11 +970,11 @@ static void bm_page_io_async(struct bm_aio_ctx *ctx,
> int page_nr, int rw) __must
>                 * to use pre-allocated page pool */
>                void *src, *dest;
>                page = alloc_page(__GFP_HIGHMEM|__GFP_WAIT);
> -               dest = kmap_atomic(page, KM_USER0);
> -               src = kmap_atomic(b->bm_pages[page_nr], KM_USER1);
> +               dest = kmap_atomic(page);
> +               src = kmap_atomic(b->bm_pages[page_nr]);
>                memcpy(dest, src, PAGE_SIZE);
> -               kunmap_atomic(src, KM_USER1);
> -               kunmap_atomic(dest, KM_USER0);
> +               kunmap_atomic(src);
> +               kunmap_atomic(dest);
>                bm_store_page_idx(page, page_nr);
>        } else
>                page = b->bm_pages[page_nr];
> --
> 1.7.7.6
>
>
--
Robert Q Kim
eBook Programmer and iBooks Consultant
http://www.youtube.com/watch?v=INXa_eTlHWk
2611 S Coast Highway
San Diego, CA 92007
310 598 1606

--00504501405a87c5ba04b8bdfde0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Guys... in my email... the code really breaks up bad... is there a version =
of the code without any line-breaks????<br><br><div class=3D"gmail_quote">O=
n Fri, Feb 10, 2012 at 2:40 PM, Cong Wang <span dir=3D"ltr">&lt;<a href=3D"=
mailto:amwang@redhat.com">amwang@redhat.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Signed-off-by: Cong Wang &lt;<a href=3D"mail=
to:amwang@redhat.com">amwang@redhat.com</a>&gt;<br>
---<br>
=A0drivers/block/drbd/drbd_bitmap.c | =A0 14 +++++++-------<br>
=A01 files changed, 7 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bit=
map.c<br>
index 39de9ff..3030201 100644<br>
--- a/drivers/block/drbd/drbd_bitmap.c<br>
+++ b/drivers/block/drbd/drbd_bitmap.c<br>
@@ -289,7 +289,7 @@ static unsigned int bm_bit_to_page_idx(struct drbd_bitm=
ap *b, u64 bitnr)<br>
 =A0 =A0 =A0 =A0return page_nr;<br>
=A0}<br>
<br>
-static unsigned long *__bm_map_pidx(struct drbd_bitmap *b, unsigned int id=
x, const enum km_type km)<br>
+static unsigned long *__bm_map_pidx(struct drbd_bitmap *b, unsigned int id=
x)<br>
=A0{<br>
 =A0 =A0 =A0 =A0struct page *page =3D b-&gt;bm_pages[idx];<br>
 =A0 =A0 =A0 =A0return (unsigned long *) kmap_atomic(page);<br>
@@ -551,7 +551,7 @@ static unsigned long bm_count_bits(struct drbd_bitmap *=
b)<br>
 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0/* last (or only) page */<br>
 =A0 =A0 =A0 =A0last_word =3D ((b-&gt;bm_bits - 1) &amp; BITS_PER_PAGE_MASK=
) &gt;&gt; LN2_BPL;<br>
- =A0 =A0 =A0 p_addr =3D __bm_map_pidx(b, idx, KM_USER0);<br>
+ =A0 =A0 =A0 p_addr =3D __bm_map_pidx(b, idx);<br>
 =A0 =A0 =A0 =A0for (i =3D 0; i &lt; last_word; i++)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bits +=3D hweight_long(p_addr[i]);<br>
 =A0 =A0 =A0 =A0p_addr[last_word] &amp;=3D cpu_to_lel(mask);<br>
@@ -559,7 +559,7 @@ static unsigned long bm_count_bits(struct drbd_bitmap *=
b)<br>
 =A0 =A0 =A0 =A0/* 32bit arch, may have an unused padding long */<br>
 =A0 =A0 =A0 =A0if (BITS_PER_LONG =3D=3D 32 &amp;&amp; (last_word &amp; 1) =
=3D=3D 0)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p_addr[last_word+1] =3D 0;<br>
- =A0 =A0 =A0 __bm_unmap(p_addr, KM_USER0);<br>
+ =A0 =A0 =A0 __bm_unmap(p_addr);<br>
 =A0 =A0 =A0 =A0return bits;<br>
=A0}<br>
<br>
@@ -970,11 +970,11 @@ static void bm_page_io_async(struct bm_aio_ctx *ctx, =
int page_nr, int rw) __must<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * to use pre-allocated page pool */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *src, *dest;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0page =3D alloc_page(__GFP_HIGHMEM|__GFP_WAI=
T);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dest =3D kmap_atomic(page, KM_USER0);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 src =3D kmap_atomic(b-&gt;bm_pages[page_nr], =
KM_USER1);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dest =3D kmap_atomic(page);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 src =3D kmap_atomic(b-&gt;bm_pages[page_nr]);=
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy(dest, src, PAGE_SIZE);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap_atomic(src, KM_USER1);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap_atomic(dest, KM_USER0);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap_atomic(src);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap_atomic(dest);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bm_store_page_idx(page, page_nr);<br>
 =A0 =A0 =A0 =A0} else<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0page =3D b-&gt;bm_pages[page_nr];<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.7.6<br><br></font></span></blockquote></div><div><br></div>--=A0=A0<div=
>Robert Q Kim<br>eBook Programmer and iBooks Consultant=A0<br><a href=3D"ht=
tp://www.youtube.com/watch?v=3DINXa_eTlHWk">http://www.youtube.com/watch?v=
=3DINXa_eTlHWk</a>=A0<br>
2611 S Coast Highway<br>San Diego, CA 92007<br>310 598 1606

</div>

--00504501405a87c5ba04b8bdfde0--
