Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
	[209.85.166.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CB1C11028A66
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2019 09:29:21 +0200 (CEST)
Received: by mail-io1-f54.google.com with SMTP id n5so27447665ioc.7
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2019 00:29:21 -0700 (PDT)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>
References: <8ceba717-542f-5898-d5d4-890945a022fb@gmail.com>
	<20190612140615.GX5803@soda.linbit>
From: David Butterfield <dab21774@gmail.com>
Message-ID: <dc406c3e-a45b-a3d2-20ef-652736d7615d@gmail.com>
Date: Tue, 18 Jun 2019 01:29:17 -0600
MIME-Version: 1.0
In-Reply-To: <20190612140615.GX5803@soda.linbit>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] integer overflow in dagtag_newer_eq(0, 1ULL<<63)
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

On 6/12/19 8:06 AM, Lars Ellenberg wrote:
> On Wed, Jun 05, 2019 at 10:01:27AM -0600, David Butterfield wrote:
>> drbd_sender.c:maybe_send_unplug_remote() can assign (1ULL << 63) to unplug_dagtag_sector[i]:
>>
>> 1674                 connection->todo.unplug_dagtag_sector[connection->todo.unplug_slot] =
>> 1675                         connection->send.current_dagtag_sector + (1ULL << 63);
>>
>> Later it reaches dagtag_newer_eq(0, unplug_dagtag_sector[i]) which converts its arguments to
>> signed before subtracting.
>>
>> 272 #define dagtag_newer_eq(a,b)      \
>> 273         (typecheck(u64, a) && \
>> 274          typecheck(u64, b) && \
>> 275         ((s64)(a) - (s64)(b) >= 0))
>>
>> But (signed)(1ULL << 63) is the maximum negative integer, and the value of
>> (0 - (signed)(1ULL << 63)) cannot be represented.  So the subtraction ends in integer overflow.
>>
>> drbd_sender.c:1660:9: runtime error: signed integer overflow: 0 - -9223372036854775808 cannot be represented in type 'long i
> 
> I don't care ;-)
> but we can add in a -1, if it makes the world a better place

Or maybe start the dagtags out at one instead of zero.  This might appear as a
"low probability occurrence" due to requiring such specific numbers, but it always
happens because the two numbers are initialized that way.  I can observe the
overflow happen, but I don't understand well enough the meanings of the numbers
involved to know if it is harmful.

The question I haven't analyzed is whether the intent of the code gets carried
out properly when this overflow happens (which it does -- this was another libubsan
discovery).  I guess I'll try to do that now:

The (1<<63) appears intended to mean "larger than any other dagtag".  If that's
correct, then the plain meaning of "dagtag_newer_eq(0, 1<<63)" should lead to a
desired return of "false".  So if the dagtag_newer_eq() comparison returns false,
despite the overflow, then the overflow cannot be harmful.

What is actually returned by the comparison?  I think: the cast to signed changes
the meaning of (1<<63) from a big positive number to INT_MIN (-9223372036854775808).
Then the signed subtraction (0 - INT_MIN) overflows from INT_MAX+1 back to INT_MIN
again.  That leaves the result negative, which will cause the macro to return false.

So I think the macro will return the correct answer despite the overflow, and this
is one of those cases where the modulo arithmetic works out the right answer.
So probably nothing but libubsan will ever notice this.

Regards,
David Butterfield
