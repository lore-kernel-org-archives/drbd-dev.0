Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 26 Nov 2007 16:06:21 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [Drbd-dev] [DRBD][PATCH] drbd_bitfild_endian.patch
Message-ID: <20071126150621.GD14702@racke.local>
References: <474AF52C.6090409@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474AF52C.6090409@ru.mvista.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 26, 2007 at 04:32:44PM +0000, Maxim Uvarov wrote:
> Hello all,
> 
> We have found that drbd  state is passed incorrectly between machines  
> with different endianness.
> Attached patch fixes this problem by converting bitfild to int.
> 
> Replacing all bitfileds (both in kernel and userland) isn't safe way 
> (there are
> about hundred lines to replace). Maybe adding converter from bitfield to 
> int32
> is appropriate solution ? Then sending state we do 
> "drbd_state_to_int(state)"
> and then receive we restore state by "int_to_drbd_state(i)". only 9 lines of
> kernel code was changed (No need to change userspace). Additional 
> overhead is
> neglible.

right you are.
but how about this instead:

diff --git a/drbd/linux/drbd.h b/drbd/linux/drbd.h
index b6ea313..ecf3a27 100644
--- a/drbd/linux/drbd.h
+++ b/drbd/linux/drbd.h
@@ -28,6 +28,7 @@
 #include <linux/drbd_config.h>
 
 #include <asm/types.h>
+#include <asm/byteorder.h>
 
 #ifdef __KERNEL__
 #include <linux/types.h>
@@ -176,18 +177,39 @@ typedef enum {
 	disk_mask=15
 } drbd_disks_t;
 
+/* bitfields are not endian safe.
+ * pointed out by Maxim Uvarov <muvarov@ru.mvista.com>
+ * even though we transmit as "cpu_to_be32(state)",
+ * the offsets of the bitfields still need to be swapped
+ * on different endianess.
+ */
 typedef union {
 	struct {
-		unsigned role : 2 ;   // 3/4      primary/secondary/unknown
-		unsigned peer : 2 ;   // 3/4      primary/secondary/unknown
-		unsigned conn : 5 ;   // 17/32    cstates
-		unsigned disk : 4 ;   // 8/16     from Diskless to UpToDate
-		unsigned pdsk : 4 ;   // 8/16     from Diskless to UpToDate
-		unsigned susp : 1 ;   // 2/2      IO suspended  no/yes
-		unsigned aftr_isp : 1 ; // isp .. imposed sync pause
+#if defined(__LITTLE_ENDIAN)
+		unsigned role : 2 ;   /* 3/4      primary/secondary/unknown */
+		unsigned peer : 2 ;   /* 3/4      primary/secondary/unknown */
+		unsigned conn : 5 ;   /* 17/32    cstates */
+		unsigned disk : 4 ;   /* 8/16     from Diskless to UpToDate */
+		unsigned pdsk : 4 ;   /* 8/16     from Diskless to UpToDate */
+		unsigned susp : 1 ;   /* 2/2      IO suspended  no/yes */
+		unsigned aftr_isp : 1 ; /* isp .. imposed sync pause */
 		unsigned peer_isp : 1 ;
 		unsigned user_isp : 1 ;
-		unsigned _pad : 11;   // 0        unused
+		unsigned _pad : 11;   /* 0        unused */
+#elif defined(__BIG_ENDIAN)
+		unsigned _pad : 11;   /* 0        unused */
+		unsigned user_isp : 1 ;
+		unsigned peer_isp : 1 ;
+		unsigned aftr_isp : 1 ; /* isp .. imposed sync pause */
+		unsigned susp : 1 ;   /* 2/2      IO suspended  no/yes */
+		unsigned pdsk : 4 ;   /* 8/16     from Diskless to UpToDate */
+		unsigned disk : 4 ;   /* 8/16     from Diskless to UpToDate */
+		unsigned conn : 5 ;   /* 17/32    cstates */
+		unsigned peer : 2 ;   /* 3/4      primary/secondary/unknown */
+		unsigned role : 2 ;   /* 3/4      primary/secondary/unknown */
+#else
+# error "this endianess is not supported"
+#endif
 	};
 	unsigned int i;
 } drbd_state_t;


-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
