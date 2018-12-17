Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 951A8103B4AA
	for <drbd-dev@lists.linbit.com>; Mon, 17 Dec 2018 18:29:42 +0100 (CET)
Received: by mail-io1-f66.google.com with SMTP id t24so10622013ioi.0
	for <drbd-dev@lists.linbit.com>; Mon, 17 Dec 2018 09:29:42 -0800 (PST)
To: Nathan Chancellor <natechancellor@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20181002171447.10765-1-natechancellor@gmail.com>
	<20181004200912.32348-1-natechancellor@gmail.com>
	<20181217172401.GA30635@flashbox>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
Date: Mon, 17 Dec 2018 10:29:38 -0700
MIME-Version: 1.0
In-Reply-To: <20181217172401.GA30635@flashbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: Avoid Clang warning about pointless
 switch statment
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

On 12/17/18 10:24 AM, Nathan Chancellor wrote:
> On Thu, Oct 04, 2018 at 01:09:13PM -0700, Nathan Chancellor wrote:
>> There are several warnings from Clang about no case statement matching
>> the constant 0:
>>
>> In file included from drivers/block/drbd/drbd_receiver.c:48:
>> In file included from drivers/block/drbd/drbd_int.h:48:
>> In file included from ./include/linux/drbd_genl_api.h:54:
>> In file included from ./include/linux/genl_magic_struct.h:236:
>> ./include/linux/drbd_genl.h:321:1: warning: no case matching constant
>> switch condition '0'
>> GENL_struct(DRBD_NLA_HELPER, 24, drbd_helper_info,
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/genl_magic_struct.h:220:10: note: expanded from macro
>> 'GENL_struct'
>>         switch (0) {
>>                 ^
>>
>> Silence this warning by adding a 'case 0:' statement. Additionally,
>> adjust the alignment of the statements in the ct_assert_unique macro to
>> avoid a checkpatch warning.
>>
>> This solution was originally sent by Arnd Bergmann with a default case
>> statement: https://lore.kernel.org/patchwork/patch/756723/
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/43
>> Suggested-by: Lars Ellenberg <lars.ellenberg@linbit.com>
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> ---
>>
>> Since this is not the same as Arnd's patch, I took authorship for it
>> while leaving a link to the original patch in the commit message. If
>> this is not how it should have been done, please let me know.
>>
>>  include/linux/genl_magic_struct.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
>> index 5972e4969197..eeae59d3ceb7 100644
>> --- a/include/linux/genl_magic_struct.h
>> +++ b/include/linux/genl_magic_struct.h
>> @@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
>>  {
>>  	switch (0) {
>>  #include GENL_MAGIC_INCLUDE_FILE
>> +	case 0:
>>  		;
>>  	}
>>  }
>> @@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
>>  {
>>  	switch (0) {
>>  #include GENL_MAGIC_INCLUDE_FILE
>> +	case 0:
>>  		;
>>  	}
>>  }
>> @@ -218,7 +220,8 @@ static inline void ct_assert_unique_top_level_attributes(void)
>>  static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
>>  {									\
>>  	switch (0) {							\
>> -		s_fields						\
>> +	s_fields							\
>> +	case 0:								\
>>  			;						\
>>  	}								\
>>  }
>> -- 
>> 2.19.0
>>
> 
> Hi Lars and Philipp,
> 
> Could you please make sure that this patch and the other one I sent make
> it into 4.21/5.0? I am not sure when you were planning on sending the
> pull request to Jens that you mentioned in the other thread but I've
> noticed most maintainers typically send their requests for the impending
> merge window around -rc7 or so and I wanted to make sure it was on your
> radar.

It needs to get here now, but drbd hasn't really sent anything in for
about a year, so I'm starting to doubt how maintained it is at this
point.

-- 
Jens Axboe

