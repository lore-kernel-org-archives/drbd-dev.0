Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A0A4110518AC
	for <drbd-dev@lists.linbit.com>; Thu, 14 Mar 2013 13:26:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 8F7421B4368
	for <drbd-dev@lists.linbit.com>; Thu, 14 Mar 2013 13:26:49 +0100 (CET)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sws6wnXhrP18 for <drbd-dev@lists.linbit.com>;
	Thu, 14 Mar 2013 13:26:49 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 70CEE1B4361
	for <drbd-dev@lists.linbit.com>; Thu, 14 Mar 2013 13:26:49 +0100 (CET)
Resent-Message-ID: <20130314122649.GI19508@soda.linbit>
Received: from vm08-mail01.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6EC981017080
	for <drbd-dev@lists.linbit.com>; Thu, 14 Mar 2013 00:05:59 +0100 (CET)
Received: from lemass.alteeve.ca (199-7-156-150.eng.wind.ca [199.7.156.150])
	by vm08-mail01.alteeve.ca (Postfix) with ESMTPSA id D43192028E
	for <drbd-dev@lists.linbit.com>; Wed, 13 Mar 2013 19:05:55 -0400 (EDT)
Message-ID: <51410654.4070107@alteeve.ca>
Date: Wed, 13 Mar 2013 19:05:56 -0400
From: Madison Kelly <mkelly@alteeve.ca>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <1363183325-20384-1-git-send-email-holer@ics.muni.cz>
	<20130313195434.GF19508@soda.linbit>
In-Reply-To: <20130313195434.GF19508@soda.linbit>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH] scripts: Updated rhcs_fence script
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

On 03/13/2013 03:54 PM, Lars Ellenberg wrote:
> On Wed, Mar 13, 2013 at 03:02:05PM +0100, Vlastimil Holer wrote:
>> cman_tool option -f is obsolete in current RHEL 6.x.
>> Syntax for kill action allows only:
>>    -n <nodename>    The name of the node to kill (can specify multiple times)
>>
>> Although node is successfully fenced, rhcs_fence ends with failure
>> due to wrong $exit condition handling. Part of debug log:
>>    rhcs_fence: 253; DEBUG: fence node2.localdomain dev 0.0 agent fence_ipmilan result: success
>>    fence_node[28511]: fence node2.localdomain success
>>    rhcs_fence: 253; DEBUG: fence node2.localdomain success
>>    rhcs_fence: 267; DEBUG: Attempt to fence node: [node2.localdomain] exited with: [0]
>>    rhcs_fence: 272; Attempt to fence: [node2.localdomain] failed!
>>    kernel: d-con drbd0: helper command: /sbin/drbdadm fence-peer drbd0 exit code 1 (0x100)
>>    kernel: d-con drbd0: fence-peer helper broken, returned 1
>> ---
>>   scripts/rhcs_fence | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/rhcs_fence b/scripts/rhcs_fence
>> index ca53678..1294660 100644
>> --- a/scripts/rhcs_fence
>> +++ b/scripts/rhcs_fence
>> @@ -1,8 +1,8 @@
>>   #!/usr/bin/perl
>>   #
>>   # Author:   Digimer (digimer@alteeve.com)
>> -# Version:  0.2.4
>> -# Released: 2012-01-20
>> +# Version:  0.2.5
>> +# Released: 2013-03-13
>
> Nope, see upstream of that script:
> https://github.com/digimer/rhcs_fence/commits/master
>
>
>>   # License:  GPL v2+
>>   #
>>   # This program ties Linbit's DRBD into Red Hat's RHCS's fence daemon via the
>> @@ -266,7 +266,7 @@ sub kill_target
>>   	if ($conf->{sys}{debug}) { to_log($conf, 0, __LINE__, "DEBUG: Attempt to fence node: [$remote_node] exited with: [$sc_exit]"); }
>>
>>   	# Exit.
>> -	if (not $exit)
>> +	if ($exit)
>>   	{
>>   		if ($conf->{sys}{debug}) { to_log($conf, 1, __LINE__, "Attempt to fence: [$remote_node] failed!"); }
>>   	}
>
> That part has been fixed by the original Author already,
> in a better way. We just did not notice, and did not update the
> rhcs_fence as shipped with the DRBD source and package.
>
> But that one:
>
>> @@ -300,7 +300,7 @@ sub eject_target
>>   		# next.
>>   		if ($conf->{sys}{debug}) { to_log($conf, 0, __LINE__, "Target node: [$remote_node] is a cluster member, attempting to eject."); }
>>   		$sc=IO::Handle->new();
>> -		$shell_call="$conf->{path}{cman_tool} kill -f $remote_node";
>> +		$shell_call="$conf->{path}{cman_tool} kill -n $remote_node";
>
> digimer, what do you say?
>
>
>>   		if ($conf->{sys}{debug}) { to_log($conf, 0, __LINE__, "DEBUG: shell call: [$shell_call]"); }
>>   		open ($sc, "$shell_call 2>&1 |") or to_log($conf, 1, __LINE__, "Failed to call: [$sc], error was: $!");
>>   		while(<$sc>)
>> --
>> 1.8.1.4
>
>
> Thanks,
>
> 	Lars
>

Strike the delay, I've made the changes and pushed to github 
(https://github.com/digimer/rhcs_fence).

-- 
Alteeve's Niche!
Madison Kelly -  647-501-5200
https://alteeve.ca/
