Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
	[209.85.166.53])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A9AF71028A76
	for <drbd-dev@lists.linbit.com>; Mon,  1 Jul 2019 00:58:36 +0200 (CEST)
Received: by mail-io1-f53.google.com with SMTP id j6so24489523ioa.5
	for <drbd-dev@lists.linbit.com>; Sun, 30 Jun 2019 15:58:36 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	e188sm10538897ioa.3.2019.06.30.15.58.34
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 30 Jun 2019 15:58:34 -0700 (PDT)
From: David Butterfield <dab21774@gmail.com>
To: drbd-dev@lists.linbit.com
Message-ID: <3b7dbdb2-3440-5b15-6da5-56e929afe1ff@gmail.com>
Date: Sun, 30 Jun 2019 16:58:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] netlink transmit padding contains uninitialized bytes
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

Valgrind reported uninitialized bytes being sent to a system call when transmitting a netlink
response generated using drbd_msg_sprintf_info() (formatting opener_info()).  (Valgrind catches
this when the emulated kernel transmit function makes a real system call to do the transmit.)

When sending a text reply over netlink, the string is formatted directly into an skb area which
is reserved "big enough", then gets "trimmed" back down after the length of the string is known.
The "trim" is to an "aligned" size, possibly leaving up to three "alignment padding" bytes in
the skb data after the end of the string. 

Those "alignment padding" bytes were never initialized after the skb space was allocated,
leading to a complaint from valgrind when the uninitialized bytes were passed to a system call
for transmission over the netlink.  

The change below initializes any "alignment padding" bytes to zero, and makes the valgrind
complaint go away.  (It could be rewritten to use fewer CPU cycles!)
    
diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 7c4f3654..6a66528e 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -163,6 +163,12 @@ static int drbd_msg_sprintf_info(struct sk_buff *skb, const char *fmt, ...)

        /* maybe: retry with larger reserve, if truncated */
        txt->nla_len = nla_attr_size(len+1);
+   
+       /* avoid transmitting uninitialized bytes */
+       ++len;
+       while (len < NLA_ALIGN(len))
+               *((char *)nla_data(txt) + len++) = '\0';
+
        nlmsg_trim(skb, (char*)txt + NLA_ALIGN(txt->nla_len));
        nla_nest_end(skb, nla);
