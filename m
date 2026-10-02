Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD931716D
	for <drbd-dev@lists.linux.dev>; Fri,  2 Oct 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950053; cv=none; b=ZKVfEI6rUd9/rBfLH8Pk/RYyX4QHKtqFIY+e0eSi6gUd2kGidtp5dSisvyC2r230SHWKL2JRaDP6MG8/ePux6Troa+ujr3Qqyr62ElKRj6U4QWfvDt6s1eSwmOndGWmhqcIqR/9HrBf1Fn16chwO816LoGCX61nWKQB+z0292Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950053; c=relaxed/simple;
	bh=yfDvPO4H/mIRlRzgF1ehHxShRFO4ABWe5fq0yL3+cMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt7/MhVGyEbl0kIJGMocUfBouaKTZxaPgN2+0nTknIy30IynYFaponSTybxCHhTKR9PXBXpD9UVgPmo/quUhBS6IKR+RvpKp5HaoO6/TT69hbavuYcg4d0Bg2mPWaZgkS9Cgm8IzOAdK9H7SNhVy4UF/SdJiTG+Sj74xtcw2XVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBVhT5rw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBVhT5rw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790950048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
	b=WBVhT5rwOdZcRwMf62UJKbSAoR6AtfyRmasAtmZTvE6G/l8cN/+UJAjyxYsRovPsAsF9RJ
	HzpvUdOVuYAzKMc4n1RAiBwuu4y5ZCf4b4VpW6xoM389rocIOeS5rTAcL0JbD8zHduAj7I
	Ih1wrvqw7jCemc4OFehVzcPl/gs7Cg8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-ENCnU--oPUq3kGZQ6n84ug-1; Fri, 02 Oct 2026 10:07:20 -0400
X-MC-Unique: ENCnU--oPUq3kGZQ6n84ug-1
X-Mimecast-MFC-AGG-ID: ENCnU--oPUq3kGZQ6n84ug_1790950034
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a767a22ca6so385171fa.1
        for <drbd-dev@lists.linux.dev>; Fri, 02 Oct 2026 07:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950034; x=1791554834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        b=x2p84/OJoSHnfgqJT1+dUfy/mhkUaySJpO+c4aSJxDbszL72sWhunVSzwIMIgBnU0u
         4eYeKYaEDgj2DZyWMLXYpX5jqwNHfbzETO4CMLTSWoScZ+ppq48dnaK1fDHZNXi9NLJ/
         PtbnVMd9j/qns4RY3Ipg5klC2OsR7wwSeljD1lDgeAb3YeExdXU/5hTKccrgP1RVD1J+
         DMDW32+O585yOayofJdI8jhzgMrunzZ+LcoBmprMvj3ybqHW545jAGiE3hJR+LQkAcz9
         nj3wZnfQYLN9HbrVyRcIDMjVsY//0SzRcW6X2ibYrv/umj9rCyGti4gUenvQReIWUt/N
         POGw==
X-Forwarded-Encrypted: i=1; AKwUvByCTgcqCr80I39sRaAFQFhlo0joOjgq+WC/ES7pSDfvdC+NWGkJvlRij7E+ugZTHky78WjsgKNgGw==@lists.linux.dev
X-Gm-Message-State: AFq9FYISyZRPeJ8H8qJAGMjNJ0pPk7Altl4lDp1Mw2bRZbQZmjowi+Fo
	Vn/y9QaeHHCuP0Yu2V2HYz7xFkjCx14e2CgqfkdiJOLhYnmlTxWnFUROsHLXkybtb8pBg88yBtp
	Sc/Qm0oktVc3thVywLEOEiokh74rE2fS8UntAdnBY6ctYHVQ9OSqEjsLNUVm5wcYEHW6dLIMiIx
	HbInSWg/eWn8jswrhP3gYM3v3IegjrxPeI6EA=
X-Gm-Gg: AYBFou0YlmdDKpF1CvJnrBtmrl29iYuKH4zZwn1N0qBTfq19x5GCE/SUzY+i7PfPUJq
	pvfC3ep9hBzsZw1sqB1QnELN0AIZ4UsdAPbDBLC1wfpUVteIKjFeAdQ6FQSjLoCmKtRHFbQxonl
	XtV2CcjtTdMzwhZ5OLy7cFsejrzcgW/ILWoXUSgLQ6GQm45gXNnHiBzZ+E
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id 38308e7fff4ca-3a8877b72d8mr7514601fa.20.1790950033938;
        Fri, 02 Oct 2026 07:07:13 -0700 (PDT)
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id
 38308e7fff4ca-3a8877b72d8mr7514081fa.20.1790950033516; Fri, 02 Oct 2026
 07:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929071743.23624-2-edumazet@kernel.org> <179090395863.434549.3668493667259120759@kernel.org>
 <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
In-Reply-To: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 2 Oct 2026 10:07:01 -0400
X-Gm-Features: AclHuK_sfowi4LPKpSWl8IXP3uRNzWbqORQfvYROS9BqQto16BFcN8kPZWF14yQ
Message-ID: <CAK-6q+ga-MNEXgENToB2hLB9jzpsGMrz-1sOo7WQP5M-scnAxg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	edumazet@google.com, netdev@vger.kernel.org, teigland@redhat.com, 
	gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	guwen@linux.alibaba.com, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, achender@kernel.org, rds-devel@oss.oracle.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, drbd-dev@lists.linux.dev, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, ceph-devel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: asBGkpCSWyMlKKfYS2ajO33bao-bRA8-afxr5iVE9hQ_1790950034
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 2, 2026 at 4:33=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> On Fri, Oct 2, 2026 at 3:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] A TCP reset or TCP timeout while the connection is waiting for
> >   send space can stall the dlm connection permanently.
>
> I dunno if I want to spend time fixing all dlm bugs.
>
> It seems TCP changes are now stuck because ood pre-existing bugs in
> in-kernel-users.
>
> Sad.

I will take a look into it and cc netdev people.

Thanks.

- Alex

