Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4ECF01051881
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 13:54:28 +0200 (CEST)
Date: Tue, 26 Apr 2016 13:54:27 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <20160426115427.GB20950@soda.linbit>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: dev@openvswitch.org, sd@queasysnail.net, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	jhs@mojatatu.com, pshelar@nicira.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next 0/8] netlink: align attributes when
 needed (patchset #3)
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

On Tue, Apr 26, 2016 at 10:06:10AM +0200, Nicolas Dichtel wrote:
> 
> This is the continuation (series #3) of the work done to align netlink
> attributes when these attributes contain some 64-bit fields.
> 
> It's the last patchset from what I've seen.
> 
> The last user of nla_put_u64() is block/drbd. This module does not use
> standard netlink API (see all the stuff in include/linux/genl_magic_struct.h
> and include/linux/genl_magic_func.h). I didn't modify it because it's seems
> hard to do it whithout testing and fully understanding the context

Something like this should just work.

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index eecd19b..5715dac 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -80,7 +80,7 @@ extern void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void);
 			nla_get_u32, nla_put_u32, true)
 #define __u64_field(attr_nr, attr_flag, name)	\
 	__field(attr_nr, attr_flag, name, NLA_U64, __u64, \
-			nla_get_u64, nla_put_u64, false)
+			nla_get_u64, nla_put_u64_64bit_unspec, false)
 #define __str_field(attr_nr, attr_flag, name, maxlen) \
 	__array(attr_nr, attr_flag, name, NLA_NUL_STRING, char, maxlen, \
 			nla_strlcpy, nla_put, false)
diff --git a/include/net/netlink.h b/include/net/netlink.h
index e589cb3..38ba770 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -871,6 +871,18 @@ static inline int nla_put_u64_64bit(struct sk_buff *skb, int attrtype,
 }
 
 /**
+ * nla_put_u64_64bit_unspec - nla_put_u64_64bit() with padattr = 0
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @value: numeric value
+ */
+static inline int nla_put_u64_64bit_unspec(struct sk_buff *skb, int attrtype,
+				    u64 value)
+{
+	return nla_put_64bit(skb, attrtype, sizeof(u64), &value, NLA_UNSPEC);
+}
+
+/**
  * nla_put_be64 - Add a __be64 netlink attribute to a socket buffer and align it
  * @skb: socket buffer to add attribute to
  * @attrtype: attribute type

> (for
> example, why include/linux/drbd_genl.h is not part of uapi?).
> Any thoughts?

probably should be.

Thanks,

    Lars

