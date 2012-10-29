Return-Path: <alessandro.bono@gmail.com>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0388E103B4B5
	for <drbd-dev@lists.linbit.com>; Mon, 29 Oct 2012 22:16:52 +0100 (CET)
Received: by mail-ee0-f54.google.com with SMTP id c50so3650130eek.27
	for <drbd-dev@lists.linbit.com>; Mon, 29 Oct 2012 14:16:52 -0700 (PDT)
Message-ID: <508EEC80.3020902@gmail.com>
Date: Mon, 29 Oct 2012 21:52:16 +0100
From: Alessandro Bono <alessandro.bono@gmail.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <k6e1m5$n09$1@ger.gmane.org> <20121029102233.GB18606@soda.linbit>
In-Reply-To: <20121029102233.GB18606@soda.linbit>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] fix %preun script in drbd-km.spec from 8.3 package
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 10/29/2012 11:22 AM, Lars Ellenberg wrote:
> On Fri, Oct 26, 2012 at 01:03:01PM +0000, Alessandro Bono wrote:
>> Hi
>>
>> %preun script in drbd-km.spec try to unload drbd.ko if present without check kernel version running
>> without this patch it's not possible to remove drbd-km package of old kernel
> ... unless you first unload the current DRBD module as well,
> or use rpm -e --noscript.
>
> Which in fact is intentional, to prevent people from "accidentally"
> uninstall a module package while the provided module is still in use
> (it may have been symlinked in place into some other kernel version
>   by some weak-module magic, or explicitly).
>
> But yes, it may be annoying at times.
>
> So maybe
> filename=$(modinfo -F filename drbd)
> filename=$(readlink "$filename")
> rpm -qf $filename
> and check if that is in fact the current package?
ok I cooked this patch
tested removing drbd for old and in use kernel on centos 6
please check readlink option, -e seems to me correct one but not sure

--- drbd-8.3.14/drbd-km.spec    2012-10-29 17:39:48.786446160 +0100
+++ drbd-8.3.14.my/drbd-km.spec 2012-10-29 21:50:20.470461556 +0100
@@ -80,10 +80,16 @@
  rm -rf %{buildroot}
                                                                                                                                                                                                                                          
  %preun %{krelver}
+filename=$(modinfo -F filename drbd)
+filename=$(readlink -e "$filename")
+drbdrpm=$(rpm -qf "$filename")
+arch=$(uname -i)
+if [ $drbdrpm = %{name}-%{krelver}-%{version}-%{release}.$arch ]; then
  lsmod | grep drbd > /dev/null 2>&1
  if [ $? -eq 0 ]; then
      rmmod drbd
  fi
+fi
                                                                                                                                                                                                                                          
  %post %{krelver}
  # hack for distribution kernel packages,



>> --- drbd-8.3.13/drbd-km.spec    2012-10-26 13:43:43.163366400 +0200
>> +++ drbd-8.3.13.my/drbd-km.spec 2012-10-26 13:44:33.368384889 +0200
>> @@ -80,10 +80,12 @@
>>   rm -rf %{buildroot}
>>
>>   %preun %{krelver}
>> +if [ 'uname -r' = %{kernelversion} ]; then
>>   lsmod | grep drbd > /dev/null 2>&1
>>   if [ $? -eq 0 ]; then
>>       rmmod drbd
>>   fi
>> +fi
>>
>>   %post %{krelver}
>>   # hack for distribution kernel packages,


-- 
Cordiali Saluti
Alessandro Bono

