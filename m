Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id CE0341433C
	for <drbd-dev@lists.linbit.com>; Wed, 22 Sep 2004 15:18:30 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] GFS support in DRBD-0.8
Date: Wed, 22 Sep 2004 15:18:45 +0200
References: <200409211616.59305.philipp.reisner@linbit.com>
	<3+B6NrvPixc+6shooEioqTc=lge@web.de>
In-Reply-To: <3+B6NrvPixc+6shooEioqTc=lge@web.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1uXUBZwoCKVrvnI"
Message-Id: <200409221518.45324.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_1uXUBZwoCKVrvnI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

[...]
> >   Proposed Solution 1, using the order of a coordinator node:
> >
> >   Writes from the coordinator node are carried out, as they are
> >   carried out on the primary node in conventional DRBD. ( Write
> >   to disk and send to peer simultaniously. )
> >
> >   Writes from the other node are sent to the coordinator first,
> >   then the coordinator inserts a small "write now" packet into
> >   its stram of write packets.
> >   The node commits the write to its local IO subsystem as soon
> >   as it gets the "write-now" packet from the coordinator.
> >
> >   Note: With protocol C it does not matter which node is the
> >         coordinator from the performance viewpoint.
> >
> >   Proposed Solution 2, use ALs as distributed locks:
> >
> >   Only one node might mark an extent as active at a time. New
> >   packets are introduced to request the locking of an extent.
> > --snap--
> >
> > PS: I think that we do not need to use the AL extents as
> >     distributed locks.
>
> we don't need to, and it will probably be simpler to implement with S1.
> but S2 will most likely scale better as soon as we introduce more than
> two nodes, and maybe already whith only two nodes, since I expect GFS
> and similar systems to coordinate on the higher level already, so that
> typically (think of for example the per-node-journals) there won't be
> real concurrent access to the same area of the device.

DRBD-0.8 will strictly be 2 nodes. For the two node case it has
principal the same latency with protocol C 
 (see the attached PDF, N2 initiates the write, ... the path until 
  IO completion can be signalled is equally long.)

with S2 we have one packet less that travels over the wire per write
request, thus less interrupts less CPU load etc... more performace
in real live.

But with S2 a extent ping-pong will be *really* expensive. 

PS: You mentioned that you want to use an other term for 
    extent. Why ? The expression extent is used in LVM1 for
    the smalles unit of allocation by default 4M. 
    I think it is a good term for what we mean...

Ok, lets consider S2:
Why is it a good idea to unify the AL-extents and the lock-extents ?

pro: we already have AL-extents.
con: it is an other thing!

I think it would be wise to have an independent LRU cache for lock-extents

pro: other extent sizes possible.
pro: other cahce sizes possible.
pro: deleteion from cache (other node needs that extent) is cheap! no 
     meta-data update.
con: more code. (but LRU is already nicely abstraced anyway)

I am willing to agree on S2 as soon as I know that it will fit 
GFS's ussage patter. I tried to find a paper on the on-disk
layout of GFS, but was in a 30 minute seach not successfull....

> note that I think either way we need to get rid of the current scheme of
> "throttling" io in the tcp buffer by doing all network and disk io
> directly in the process context of the submitting process. we should
> instead have our own queue, with some maximum length, and let the worker
> do the work. yes this introduces more context switches.  but I really
> doubt that this is a performance problem on todays boxes.

Tell me one reason for this other than "I think we need..."

>
> I'd like to keep Primary, but introduce "active" as well, so we can have
> active Secondaries. a Primary is by definition always active.
>

So it would be Primary/Active ?? What is the difference between
an Active and an Primary node ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_1uXUBZwoCKVrvnI
Content-Type: application/pdf;
  name="GFS-mode-options.pdf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="GFS-mode-options.pdf"

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
305/pMJr3+o9/kiF176HmlDhfXlaOx69fl9z+2H3+cRw9prjZwvD9t2t4/PC8PlhN4qW/gvzr9f4
rKuzZkmflCntuXR83F2nYvfH3XUMdn/cHdc352fZEvqnyieO+cI987oOau7d542e85dvvHyd3Pjy
5vPLN9DLT4DuH1/1yzOvbOS1/Bj6wswrwnvl8cP2yzfDecVEr3Qb5esOO6/o5frFmP53/vXLM6/j
/dcsDf725Vv3OkV+jXLk67vZjxZf4effp10l0Cvc+/n1jxK7ypGrSe1Pfpa0LxJdP4h+8sPk/cD1
nveznyT9weH6lbSfvHu69dtP/a88Y/qZZanPH3T3NrbPgv6D7jbNOX703ez2SeFjSv+Tlnz1P7k3
FWPsHhM/J/vyxuVvKvefuPnb4chnlHQ+/6Yclz9ZyGkZs77i+a7uWfbflll/W/7kfldzTf9y/8nz
nX96JnCl2NfvL//Tduzz04bfW5G0jHnu6mbOY8Rcw/Tpqm7uBFtmjZUYa/PXZcx4vfb5vfE7f7t9
un6bv2u9N1ZXxE+KgBI/rm8Hvu19/VsC17/281srAM923X5q30PGT/8ee9vRy+X+L/W1grhc/wDZ
uOoj2vwx/NNT0Pfn2sef2nJe/3bEVWwsP9nvn5Y6dPwEHz+H5b8fr9co9f77fkAdP+F0kf714/8D
Kww/CmVuZHN0cmVhbQ0KZW5kb2JqDQoNCjIgMCBvYmoNCiAgODY0NA0KZW5kb2JqDQoNCjQgMCBv
YmoNCjw8IC9UeXBlIC9Gb250DQogICAvU3VidHlwZSAvVHlwZTENCiAgIC9CYXNlRm9udCAvSGVs
dmV0aWNhDQogICAvRW5jb2RpbmcgL1dpbkFuc2lFbmNvZGluZw0KPj4NCmVuZG9iag0KDQo1IDAg
b2JqDQo8PCAvRjEgNCAwIFINCiAgID4+DQplbmRvYmoNCg0KNiAwIG9iag0KPDwNCiAgIC9Gb250
IDUgMCBSDQogICAvUHJvY1NldCBbIC9QREYgXQ0KPj4NCmVuZG9iag0KDQo3IDAgb2JqDQo8PCAv
VHlwZSAvUGFnZQ0KICAgL1BhcmVudCAzIDAgUg0KICAgL1Jlc291cmNlcyA2IDAgUg0KICAgL01l
ZGlhQm94IFsgMCAwIDU5NSAyODMgXQ0KICAgL0NvbnRlbnRzIDEgMCBSDQo+Pg0KZW5kb2JqDQoN
CjMgMCBvYmoNCjw8IC9UeXBlIC9QYWdlcw0KICAgL1Jlc291cmNlcyA2IDAgUg0KICAgL01lZGlh
Qm94IFsgMCAwIDU5NSA4NDIgXQ0KICAgL0tpZHMgWyA3IDAgUg0KICAgICAgICAgICBdDQogICAv
Q291bnQgMQ0KPj4NCmVuZG9iag0KDQo4IDAgb2JqDQo8PCAvVHlwZSAvQ2F0YWxvZw0KICAgL1Bh
Z2VzIDMgMCBSDQo+Pg0KZW5kb2JqDQoNCjkgMCBvYmoNCjw8IC9DcmVhdG9yIDxGRUZGMDA0NDAw
NzIwMDYxMDA3Nz4NCi9Qcm9kdWNlciA8RkVGRjAwNEYwMDcwMDA2NTAwNkUwMDRGMDA2NjAwNjYw
MDY5MDA2MzAwNjUwMDJFMDA2RjAwNzIwMDY3MDAyMDAwMzEwMDJFMDAzMTAwMkUwMDMyPg0KL0Ny
ZWF0aW9uRGF0ZSAoRDoyMDA0MDkyMjE0NTE0MyswMicwMCcpDQo+Pg0KZW5kb2JqDQoNCnhyZWYN
CjAgMTANCjAwMDAwMDAwMDAgNjU1MzUgZg0KMDAwMDAwMDAxNyAwMDAwMCBuDQowMDAwMDA4NzQ2
IDAwMDAwIG4NCjAwMDAwMDkxMjEgMDAwMDAgbg0KMDAwMDAwODc3MyAwMDAwMCBuDQowMDAwMDA4
ODg4IDAwMDAwIG4NCjAwMDAwMDg5MjggMDAwMDAgbg0KMDAwMDAwODk5MyAwMDAwMCBuDQowMDAw
MDA5MjU3IDAwMDAwIG4NCjAwMDAwMDkzMTYgMDAwMDAgbg0KdHJhaWxlcg0KPDwgL1NpemUgMTAN
CiAgIC9Sb290IDggMCBSDQogICAvSW5mbyA5IDAgUg0KPj4NCnN0YXJ0eHJlZg0KOTUxNA0KJSVF
T0YNCg==

--Boundary-00=_1uXUBZwoCKVrvnI--
