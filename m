Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Mon, 14 Aug 2006 13:28:11 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671036250EC@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: ap_pending_cnt maintenance
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In looking for the cause of hitting asserts that ap_pending_cnt is not
-ve, I think I've found one place where an extra decrement is done (not,
unfortunately the cause of my problem, but still wrong); in
make_request_common, when handling WRITE requests, if two-primaries are
allowed, the code checks for concurrent writes and fails the new one if
an existing remote write is in progress. Now, the increment for the
write being handled by this function isn't done until w_send_dblock runs
in the worker thread, so I don't think a decrement should be done when
the request is completed here...

Code:

			if (mdev->net_conf->two_primaries) {
				if(_ee_have_write(mdev,req)) { //
tl_add() here
					spin_unlock_irq(&mdev->tl_lock);

					WARN("Concurrent write! [DISCARD
L] sec=3D%lu\n",
					     (unsigned long)sector);
					dec_local(mdev);
					dec_ap_pending(mdev);	<<<<=3D=3D=3D=3D
I think this is incorrect!
					local=3D0;

					drbd_end_req(req, RQ_DRBD_DONE,
1, sector);
					if(b) kfree(b);
					return 0;
				}
			} else {
				_tl_add(mdev,req);
			}
			req->w.cb =3D  w_send_dblock;
			drbd_queue_work(&mdev->data.work, &req->w);

What do you think?
Simon

