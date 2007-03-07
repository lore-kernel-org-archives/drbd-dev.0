Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	linux-kernel@vger.kernel.org
Date: Wed, 7 Mar 2007 12:26:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703071226.13088.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] connector: Bugfix for cn_call_callback()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Evgeniy,

When one stresses the connector code, with sending many messages
from userspace to kernel, one could get in the "unlikely()"
part in cn_call_callback().

There a new __cbq gets allocated, and a NULL pointer got assigned
to the callback by dereferencing __cbq. This is the bug. The right
thing is the dereference the original __cbq. Therefore the bugfix
is to use a new variable for the newly allocated __cbq. 

This is tested, and it fixes the issue.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

--- /usr/src/linux-2.6.20/drivers/connector/connector.c 2007-03-07 11:45:38.000000000 +0100
+++ /usr/src/linux-2.6.20-modified/drivers/connector/connector.c        2007-03-07 11:39:11.000000000 +0100
@@ -128,7 +128,7 @@
  */
 static int cn_call_callback(struct cn_msg *msg, void (*destruct_data)(void *), void *data)
 {
-       struct cn_callback_entry *__cbq;
+       struct cn_callback_entry *__cbq, *__new_cbq;
        struct cn_dev *dev = &cdev;
        int err = -ENODEV;

@@ -148,23 +148,23 @@
                        } else {
                                struct cn_callback_data *d;

-                               __cbq = kzalloc(sizeof(*__cbq), GFP_ATOMIC);
-                               if (__cbq) {
-                                       d = &__cbq->data;
+                               __new_cbq = kzalloc(sizeof(*__new_cbq), GFP_ATOMIC);
+                               if (__new_cbq) {
+                                       d = &__new_cbq->data;
                                        d->callback_priv = msg;
                                        d->callback = __cbq->data.callback;
                                        d->ddata = data;
                                        d->destruct_data = destruct_data;
-                                       d->free = __cbq;
+                                       d->free = __new_cbq;

-                                       INIT_WORK(&__cbq->work,
-                                                       &cn_queue_wrapper);
+                                       INIT_WORK(&__new_cbq->work,
+                                                 &cn_queue_wrapper);

                                        if (queue_work(dev->cbdev->cn_queue,
-                                                   &__cbq->work))
+                                                   &__new_cbq->work))
                                                err = 0;
                                        else {
-                                               kfree(__cbq);
+                                               kfree(__new_cbq);
                                                err = -EINVAL;
                                        }
                                } else


-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
