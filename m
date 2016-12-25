Return-Path: <loyou85@gmail.com>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
	[209.85.214.68]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3B0D6105630C
	for <drbd-dev@lists.linbit.com>; Sun, 25 Dec 2016 17:04:59 +0100 (CET)
Received: by mail-it0-f68.google.com with SMTP id n68so29183055itn.3
	for <drbd-dev@lists.linbit.com>; Sun, 25 Dec 2016 08:04:59 -0800 (PST)
MIME-Version: 1.0
From: Feng Sun <loyou85@gmail.com>
Date: Sun, 25 Dec 2016 23:58:32 +0800
Message-ID: <CAAiCvkj-Z=vcp7MpOCRZwhrv_CLd2EmyvM=z=-6n54Ks1at8KQ@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=94eb2c08da883f91c405447db3d8
Subject: Re: [Drbd-dev] NULL pointer derefernce in 8.4.7-1 during
	drbd_destroy_connection()
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

--94eb2c08da883f91c405447db3d8
Content-Type: text/plain; charset=UTF-8

On Wed, 30 Mar 2016, Lars Ellenberg wrote:

>* On Wed, Mar 30, 2016 at 02:19:07AM +0000, Eric Wheeler wrote:
*>* > Hello all,
*>* >
*>* > We are getting kernel crashes in linux 4.1.20 with the drbd-8.4.git tree
*>* > at commit 3a6a769340ef93b1ba2792c6461250790795db49 .
*>* >
*>* > I don't see anything in the newer commits that addresses this issue so
*>* > I'm posting---but I'll try the latest commit in master, too, just in case.
*>* >
*>* > Please see the backtrace below.  I also included our global_common.conf
*>* > further down.  This is protocol A and the link is quite slow.  This NULL
*>* > ptr dereference appears to show up when the drbd kernel thread is blocked
*>* > for a long time.  It might happen at reconnect time because the
BUG didn't
*>* > show up until 13 seconds after the P_BARRIER error.
*>* >
*>* > The problem is pretty reproducable, so I can probably test patches.
*>* > Please let me know what I can do to help test.
*> >* DRBD logs of both peers leading up to the incident may be useful.*


*I have met same issue with 8.4.9, but I cannot reproduce this easily.can
you help to share about the reproduce steps? *

-- 

Neil

--94eb2c08da883f91c405447db3d8
Content-Type: text/html; charset=UTF-8

<div dir="ltr">
  

    
  
  <div bgcolor="#FFFFFF">
    <pre><blockquote type="cite"><pre>On Wed, 30 Mar 2016, Lars Ellenberg wrote:

&gt;<i> On Wed, Mar 30, 2016 at 02:19:07AM +0000, Eric Wheeler wrote:
</i>&gt;<i> &gt; Hello all,
</i>&gt;<i> &gt; 
</i>&gt;<i> &gt; We are getting kernel crashes in linux 4.1.20 with the drbd-8.4.git tree 
</i>&gt;<i> &gt; at commit 3a6a769340ef93b1ba2792c6461250<wbr>790795db49 .  
</i>&gt;<i> &gt; 
</i>&gt;<i> &gt; I don&#39;t see anything in the newer commits that addresses this issue so 
</i>&gt;<i> &gt; I&#39;m posting---but I&#39;ll try the latest commit in master, too, just in case.
</i>&gt;<i> &gt; 
</i>&gt;<i> &gt; Please see the backtrace below.  I also included our global_common.conf 
</i>&gt;<i> &gt; further down.  This is protocol A and the link is quite slow.  This NULL 
</i>&gt;<i> &gt; ptr dereference appears to show up when the drbd kernel thread is blocked 
</i>&gt;<i> &gt; for a long time.  It might happen at reconnect time because the BUG didn&#39;t 
</i>&gt;<i> &gt; show up until 13 seconds after the P_BARRIER error.
</i>&gt;<i> &gt; 
</i>&gt;<i> &gt; The problem is pretty reproducable, so I can probably test patches.  
</i>&gt;<i> &gt; Please let me know what I can do to help test.
</i>&gt;<i> 
</i>&gt;<i> DRBD logs of both peers leading up to the incident may be useful.</i></pre></blockquote><i><i>I have met same issue with 8.4.9, but I cannot reproduce this easily.<br>can you help to share about the reproduce steps? </i>

</i></pre>
    <pre class="gmail-m_4197581587400105513moz-signature" cols="72">-- 

Neil</pre>
  </div>

</div>

--94eb2c08da883f91c405447db3d8--
