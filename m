Return-Path: <tvb@able.be>
Received: from mail.able.be (gwb.able.be [194.78.97.254])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 85F2E1017081
	for <drbd-dev@lists.linbit.com>; Tue, 12 Mar 2013 11:29:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by gw-master.mechelen.vasco.com (Postfix) with ESMTP id 3FFDF181DF
	for <drbd-dev@lists.linbit.com>; Tue, 12 Mar 2013 11:29:02 +0100 (CET)
Received: from itsj.localnet (tvb.mechelen.vasco.com [10.32.64.113])
	by gw-master.mechelen.vasco.com (Postfix) with ESMTP id 240CD181D8
	for <drbd-dev@lists.linbit.com>; Tue, 12 Mar 2013 11:29:02 +0100 (CET)
From: Tijs Van Buggenhout <tvb@able.be>
To: drbd-dev@lists.linbit.com
Date: Tue, 12 Mar 2013 11:29:10 +0100
Message-ID: <6693492.FO78ceTEC3@itsj>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Drbd-dev] Only 63 characters maximum allowed for shared secret
	(and other string values)
Reply-To: Tijs Van Buggenhout <tvb@able.be>
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

Hi,

In the online users-guide manual (and man 8 drbdsetup) I can read the 
following for shared-secret keyword: "The shared secret used in peer 
authentication. May be up to 64 characters."

This seems to be inaccurate, as only 63 characters can be defined as valid 
value for the keyword, otherwise an error is raised. 64 bytes is the buffer 
size for the value of the keyword (drbd/linux/drbd.h:#define SHARED_SECRET_MAX 
64) but it needs to be null terminated, hence one character is lost..

(master.domain.be):~# drbdsetup connect drbd0 172.16.1.179 172.16.1.180 --
protocol C --cram-hmac-alg sha1 --shared-secret 
'012345678901234567890123456789012345678901234567890123456789012'
(master.domain.be):~# drbdsetup disconnect 172.16.1.179 172.16.1.180
(master.domain.be):~# drbdsetup connect drbd0 172.16.1.179 172.16.1.180 --
protocol C --cram-hmac-alg sha1 --shared-secret 
'0123456789012345678901234567890123456789012345678901234567890123'
drbd0: Failure: (126) UnknownMandatoryTag
additional info from kernel:
invalid attribute value
(master.domain.be):~# drbdsetup connect drbd0 172.16.1.179 172.16.1.180 --
protocol C --cram-hmac-alg sha1 --shared-secret 
'01234567890123456789012345678901234567890123456789012345678901234'
drbd0: Failure: (126) UnknownMandatoryTag
additional info from kernel:
invalid attribute value

A bit confusing though, as...

struct net_conf is defined in drbd/linux/drbd_genl.h

GENL_struct(DRBD_NLA_NET_CONF, 5, net_conf,
    __str_field_def(1,DRBD_GENLA_F_MANDATORY | DRBD_F_SENSITIVE,                                    
                    shared_secret,SHARED_SECRET_MAX)

but __str_field_def as defined in drbd/linux/genl_magic_struct.h reads :

#define __str_field_def(attr_nr, attr_flag, name, maxlen) \
        __str_field(attr_nr, attr_flag, name, maxlen)

which would make one believe SHARED_SECRET_MAX is actually the maximum length 
allowed for shared secret (SHARED_SECRET_MAX correspons with maxlen parameter 
of __str_field_def macro).

Also in the same file, __str_field macro is defined as:

#define __str_field(attr_nr, attr_flag, name, maxlen) \
        __array(attr_nr, attr_flag, name, NLA_NUL_STRING, char, maxlen, \
                        nla_strlcpy, nla_put, false)

where NLA_NUL_STRING is introduced as nla type for the field, meaning..

user/libgenl.h: *    NLA_NUL_STRING       Maximum length of string (excluding 
NUL)

.. which again implies that SHARED_SECRET_MAX would be the maximum length.

However in drbd/linux/genl_magic_struct.h the __array macro is defined as:

#define __array(attr_nr, attr_flag, name, nla_type, _type, maxlen,      \
                __get, __put, __is_signed)                              \
        [attr_nr] = { .type = nla_type,                                 \
                      .len = maxlen - (nla_type == NLA_NUL_STRING) },

the (max) length for the value of the field is decreased to (maxlen - 1) when 
nla_type equals NLA_NUL_STRING.

Also..

drbd/drbd_receiver.c:   char secret[SHARED_SECRET_MAX]; /* 64 byte */
drbd/drbd_receiver.c:   key_len = strlen(nc->shared_secret);
drbd/drbd_receiver.c:   memcpy(secret, nc->shared_secret, key_len);

and 

drbd/drbd_nl.c: ((char *)new_conf->shared_secret)[SHARED_SECRET_MAX-1] = 0;

require shared_secret to be null terminated, and max 63 bytes in length... 
Other fields like cram_hmac_alg, integrity_alg, verify_alg and csums_alg use 
the same boundary.

Did I misinterprete the manual? What is the intended behaviour?

Best regards,
Tijs
