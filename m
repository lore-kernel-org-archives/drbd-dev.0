Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Panic in _drbd_send_page() again.
Date: Wed, 2 May 2007 10:06:44 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671056365AC@EXNA.corp.stratus.com>
In-Reply-To: 200705021122.56681.philipp.reisner@linbit.com
References: <BD7042533C2F8943A6A4257A9E31C45439C994@EXNA.corp.stratus.com>
	200705021122.56681.philipp.reisner@linbit.com
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> Hi Ernest,
>=20
> Could you run this through ksymoops, to get the code line
> disassembled ? -- This does not look like a well-known distri kernel,
> or is it ?
>=20
> -Phil

This is running 2.6.16.38 with Xen 3.0.4 patches -- it's way too late to
run ksymoops on this specific case (the system has long since moved on!)
However, looking at the disassembly for
_debd_send_page:

00003df0 <_drbd_send_page>:
    3df0:	55                   	push   %ebp
    3df1:	89 e5                	mov    %esp,%ebp
    3df3:	57                   	push   %edi
    3df4:	89 cf                	mov    %ecx,%edi
    3df6:	b9 00 e0 ff ff       	mov    $0xffffe000,%ecx
    3dfb:	56                   	push   %esi
    3dfc:	53                   	push   %ebx
    3dfd:	83 ec 24             	sub    $0x24,%esp
    3e00:	8b 75 08             	mov    0x8(%ebp),%esi
    3e03:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    3e06:	89 55 ec             	mov    %edx,0xffffffec(%ebp)
    3e09:	21 e1                	and    %esp,%ecx
    3e0b:	8b 41 18             	mov    0x18(%ecx),%eax
    3e0e:	89 45 e8             	mov    %eax,0xffffffe8(%ebp)
    3e11:	8b 02                	mov    (%edx),%eax
    3e13:	f6 c4 40             	test   $0x40,%ah
    3e16:	74 03                	je     3e1b
<_drbd_send_page+0x2b>
    3e18:	8b 52 0c             	mov    0xc(%edx),%edx
    3e1b:	8b 42 04             	mov    0x4(%edx),%eax
    3e1e:	40                   	inc    %eax
    3e1f:	85 c0                	test   %eax,%eax

send_page+0x21 is 3e11 - loading from %edx which is 2nd param, page;=20
this is attempting to read the flags field as part of the page_count()
macro call:

int _drbd_send_page(drbd_dev *mdev, struct page *page,
		    int offset, size_t size)
{
	mm_segment_t oldfs =3D get_fs();
	int sent,ok;
	int len   =3D size;

#ifdef SHOW_SENDPAGE_USAGE
...
#endif

	/* PARANOIA. if this ever triggers,
	 * something in the layers above us is really kaputt.
	 *one roundtrip later:
	 * doh. it triggered. so XFS _IS_ really kaputt ...
	 * oh well...
	 */
	if ( (page_count(page) < 1) || PageSlab(page) ) {
		/* e.g. XFS meta- & log-data is in slab pages, which
have a

The Oops message shows that edx is 0x6b6b6b6b which is the poison value
for
free memory when using CONFIG_SLAB_DEBUG -- as Ernest pointed out, this=20
means that we're using a bio that has already been freed...

This is very similar to a bunch of problems found previously where the
bio
was freed too early -- the big difference with this one is that we
turned
on CONFIG_SLAB_DEBUG which enabled poisoning of freed memory...

Simon
