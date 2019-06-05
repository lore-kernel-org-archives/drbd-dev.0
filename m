Return-Path: <dab21774@gmail.com>
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com
	[209.85.166.175])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C6B811028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 18:01:33 +0200 (CEST)
Received: by mail-it1-f175.google.com with SMTP id h20so4284897itk.4
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 09:01:33 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	a129sm9382096ith.7.2019.06.05.09.01.31
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:01:32 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <8ceba717-542f-5898-d5d4-890945a022fb@gmail.com>
Date: Wed, 5 Jun 2019 10:01:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] integer overflow in dagtag_newer_eq(0, 1ULL<<63)
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

drbd_sender.c:maybe_send_unplug_remote() can assign (1ULL << 63) to unplug_dagtag_sector[i]:

1674                 connection->todo.unplug_dagtag_sector[connection->todo.unplug_slot] =
1675                         connection->send.current_dagtag_sector + (1ULL << 63);

Later it reaches dagtag_newer_eq(0, unplug_dagtag_sector[i]) which converts its arguments to
signed before subtracting.

272 #define dagtag_newer_eq(a,b)      \
273         (typecheck(u64, a) && \
274          typecheck(u64, b) && \
275         ((s64)(a) - (s64)(b) >= 0))

But (signed)(1ULL << 63) is the maximum negative integer, and the value of
(0 - (signed)(1ULL << 63)) cannot be represented.  So the subtraction ends in integer overflow.

drbd_sender.c:1660:9: runtime error: signed integer overflow: 0 - -9223372036854775808 cannot be represented in type 'long i

