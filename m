Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6885B1055F5A
	for <drbd-dev@lists.linbit.com>; Tue, 12 Mar 2013 22:24:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 574251B4361
	for <drbd-dev@lists.linbit.com>; Tue, 12 Mar 2013 22:24:50 +0100 (CET)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D4DANRoMy7Y3 for <drbd-dev@lists.linbit.com>;
	Tue, 12 Mar 2013 22:24:50 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 3D0851B435C
	for <drbd-dev@lists.linbit.com>; Tue, 12 Mar 2013 22:24:50 +0100 (CET)
Date: Tue, 12 Mar 2013 22:24:50 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20130312212450.GB19508@soda.linbit>
References: <6693492.FO78ceTEC3@itsj>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6693492.FO78ceTEC3@itsj>
Subject: Re: [Drbd-dev] Only 63 characters maximum allowed for shared secret
 (and other string values)
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

On Tue, Mar 12, 2013 at 11:29:10AM +0100, Tijs Van Buggenhout wrote:
> Hi,
> 
> In the online users-guide manual (and man 8 drbdsetup) I can read the 
> following for shared-secret keyword: "The shared secret used in peer 
> authentication. May be up to 64 characters."
> 
> This seems to be inaccurate, as only 63 characters can be defined as valid 
> value for the keyword, otherwise an error is raised. 64 bytes is the buffer 
> size for the value of the keyword (drbd/linux/drbd.h:#define SHARED_SECRET_MAX 
> 64) but it needs to be null terminated, hence one character is lost..

Right.  So the documentation is off by one.

> which would make one believe SHARED_SECRET_MAX is actually the maximum length 
> allowed for shared secret (SHARED_SECRET_MAX correspons with maxlen parameter 
> of __str_field_def macro).

Maximum payload including terminating NUL.

> Also in the same file, __str_field macro is defined as:
> where NLA_NUL_STRING is introduced as nla type for the field, meaning..
> 
> user/libgenl.h: *    NLA_NUL_STRING       Maximum length of string (excluding 
> NUL)

exactly, but what is described there is the .len member of the policy struct.

> #define __array(attr_nr, attr_flag, name, nla_type, _type, maxlen,      \
>                 __get, __put, __is_signed)                              \
>         [attr_nr] = { .type = nla_type,                                 \
>                       .len = maxlen - (nla_type == NLA_NUL_STRING) },
> 
> the (max) length for the value of the field is decreased to (maxlen - 1) when 
> nla_type equals NLA_NUL_STRING.

Yep, to make the value of the .len attribute of the policy struct match,
so validate_nla() will validate it to be <= that *including* the
terminating NUL.

> Did I misinterprete the manual? What is the intended behaviour?

See linux kernel source tree,
lib/nlattr.c, validate_nla, case NLA_NUL_STRING.

It validates the payload of that nla to contain a terminating NUL,
and contain that within the first pt->len + 1 byte
in case the attrlen should happen to be larger, even,
possibly due to padding.

That "+ 1" is why there is the "- (nla_type == NLA_NUL_STRING)"
in our macro.


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
