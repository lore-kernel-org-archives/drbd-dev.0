Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 12 Mar 2009 11:41:23 +0100
References: <EAF41105EEA8E14BA54927856CEDEB3D01084707@300813ANEX2.global.avaya.com>
In-Reply-To: <EAF41105EEA8E14BA54927856CEDEB3D01084707@300813ANEX2.global.avaya.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200903121141.24095.philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] How to use dynamic tracing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 04 March 2009 20:08:51 Guo, Weiping (Jim) wrote:
> Hi All,
>
> I am new to drbd development. Just want to get my foot wet.
>
> One thing I would to do is turn on the tracing so that I may have a
> quicker way to understand drbd. I defined "ENABLE_DYNAMIC_TRACE" in the
> configuration file, but not sure how to use it.
>
> Any documents or suggestions are appreciated!
>

enum {
	TraceLvlAlways = 0,
	TraceLvlSummary,
	TraceLvlMetrics,
	TraceLvlAll,
	TraceLvlMax
};

enum {
	TraceTypePacket = 0x00000001,
	TraceTypeRq	= 0x00000002,
	TraceTypeUuid	= 0x00000004,
	TraceTypeResync = 0x00000008,
	TraceTypeEE	= 0x00000010,
	TraceTypeUnplug = 0x00000020,
	TraceTypeNl	= 0x00000040,
	TraceTypeALExts = 0x00000080,
	TraceTypeIntRq  = 0x00000100,
	TraceTypeMDIO   = 0x00000200,
	TraceTypeEpochs = 0x00000400,
};

echo 1 > /sys/module/drbd/parameters/trace_devs # Bitmask
echo 3 > /sys/module/drbd/parameters/trace_level
echo 4 > /sys/module/drbd/parameters/trace_type

Enables UUID traceing with full verbosity for /dev/drbd0.


-Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.


