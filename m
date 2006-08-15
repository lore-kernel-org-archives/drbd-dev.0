Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Aug 2006 14:55:52 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671036252C5@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 - crash due to NULL page* in drbd_send_page
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I've been seeing a fairly reproducible crash in _drbd_send_page due to a
NULL page pointer; my working theory is that somehow the bio is being
freed whilst it is still in use and I think I have some evidence of this
now -- I modified drbd_send_page to print out info on the request in
progress when the error occurs and have the following trace:

drbd1: data >>> Data (sector 1560250, id e7f15e10, seq b75, f 0)
drbd1: meta <<< WriteAck (sector 1560250, size 1000, id e7f15e10, seq
b75)
drbd1: in got_BlockAck:2796: ap_pending_cnt =3D -1 < 0 !
drbd1: Sector 1560250, id e7f15e10, seq b75

drbd1: drbd_send_zc_bio - NULL Page; bio eb49d380, bvec c07678fc
drbd1:     sector: 1560250, block_id: e7f15e10, seq b75
 [<c0105081>] show_trace+0x21/0x30
 [<c01051be>] dump_stack+0x1e/0x20
 [<f1291400>] _drbd_send_zc_bio+0x100/0x140 [drbd]
 [<f1291582>] drbd_send_dblock+0x142/0x230 [drbd]
 [<f127f8a6>] w_send_dblock+0x36/0x260 [drbd]
 [<f1280b16>] drbd_worker+0x186/0x4f7 [drbd]
 [<f128ffdd>] drbd_thread_setup+0x7d/0xe0 [drbd]
 [<c0102d85>] kernel_thread_helper+0x5/0x10
Unable to handle kernel NULL pointer dereference at virtual address
00000000

The trace of send data happens before the data is actually sent, so it
would seem here that we received the Ack before we finished sending the
data!!!!!

I searched back, and the specific block_id was recently used for a
request on a different device (not surprising) and the previous data
message on the drbd1 device had sequence number b74 as expected.

You will also note that we hit the assert failure re ap_pending_cnt when
processing the ack -- I think this is because w_send_dblock doesn't
increment ap_pending_cnt until drbd_send_dblock returns successfully, so
it's probably at zero at the moment the Ack is received...

I'm still debugging but I thought it would be useful to post what I've
found in case anyone has any bright ideas...
/simgr


