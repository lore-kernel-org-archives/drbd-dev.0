Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132A45C700
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302781; cv=none; b=KfZZ1urrVjCv8iNjtbIRgnleYOJNwwZISLfYiXUAsfeJKD3z/ZNHbOC4m2gKn6kKYDhTl2HeOAjoC0mdhKg7rZEA8KfOhTYAwRALyHSSZCZRRXXl9+vSEDl5lfjLNXuPu5Z5LIiVeISx0Asb0Okl05UPdBptzz44Ihda9k+e7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302781; c=relaxed/simple;
	bh=v4l2oT7XpoJJY95pECWl0GI0DGTnb5r8/h9YkRUhmzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYvv+RkrOJG67e78sNow1O1kq/ybag4QT7GKlz6Bslvl9plmQR0i3GnPhwck08UBk9aZoeZbEsRn39fNNewBOigloGeccjX1lvk1BoZqjB1ydjI1+c0BQMynjOiLlFqh/QzSax/Eg6ifHyzNUC2iId1B+hMh9m9alo1JTM5YfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=WxMhBty6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="WxMhBty6"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-487049569b6so725065f8f.1
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791302777; x=1791907577; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXaWhmFAy6cyrLqO6zX4eG/+lUuNb4r/xV4XwQ3HDVU=;
        b=WxMhBty60gwFQnhvafmxJRRz+LChpDWBdTFpgGb7nG48m9nK3e2eHKOYU1VgiQfAnO
         wE+KyyLboPtE/MJIvgf1TeJpH6oS0nvv03g4SVEXyWvjFHuaPDtc6XWjkUQpFkssMSSI
         8ch9CIz/ksGCLnEFfNddziatSwRaSHKStnHL8sLdwT9EzcQHL1De82wl6HBncKqDECBR
         RBZuNtmhhC8OWi8bruFbSpOfCiJ7L5eLXu+Stvu4d2DKHa/Knsgdj/n9ST1bOzNkcVZK
         Ub5Gr2O8Zyl3kgay8O4KIbqvYEqL1u1oC26wpiMZ0/K4USE439Z3fsvVFPYILfb1QuPk
         2gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791302777; x=1791907577;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXaWhmFAy6cyrLqO6zX4eG/+lUuNb4r/xV4XwQ3HDVU=;
        b=apxwZUZ6HCUUTSSzA2LZmZjMpvYARbEbPU3Ijbl2nO0d3DTV5+ie3aGT12KkVHSM56
         F/tyEQc475X4q9h1g/1Z/7iOkilQFz+fYVsy4YRpOqhw45lb15yZEdV1/qqzhSnXP/Zm
         zKMJvRGLtqImTVH9VUEO/jwv5QeEB6vNSu7VkKtqS4uOagbxjsbg/mU7DCfaNLvW0eD7
         SiZX0mGaAK0ZL0FbQel4BVPkapuRHZLUJv954xzxt03N2dlA/Xkp7qzVgc/fcefcBOml
         CZlYSuaW8xccnfYRXlm8KBpcVZJ8YZNrJzeynhZPMivDfroa44NviJDRX/E/t2ehE94N
         MwFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdzwF51pTcnU8E4vv+/TuTpwD6y7e5YOdtSEfX1MwKjhjqLnNze3YpdWKg/+riWGdMV04B9SgZyQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJZlVKh2v0qnws4PYQUcHMI57zfJEh84ymBLVAdXrH9W5FTF9L2
	Nnw6NifwdRq3m8vvFYtGx7DkkzAiFZ+nXNa7B9QKHxWs+KDwv0HmNZwHCzDPn5T52ctu3mxE2gg
	Q9CGKTm3xvQ==
X-Gm-Gg: AYBFou1WsmHCIAUaJJklNwWWY5JfKa8x6CMC7h/q+ha8tDn0YXcX/21U+LjxlY0jAr/
	nnKT3X2HoJfDePlrpz1S29B7tK2k8lw/XCIi/QrHK6pi/MQo3dfvUvYbTSsnQuV8TDK5gbek6rD
	SlHcKD84VRZn27odFjycSDBbnNG3zT6+Ze/tt7ROaa54NvlixzpDtxKhSCFTq2htUmfHcrkDCXm
	WEfwP1obpqxFzmydYXwqH20nD2FwvUdft1uT11f0KsfdApealI7lMyhBLILkJPnPGZhvbMlUPoN
	wZ4DFjUrfZU+CZEYHNBAtiyM20g6BYJSrZcH8kioNObPDnc2QAs2+iw/dcuvV25JdUF5DYIOVDo
	I9N15rOnse3Ds2wclSInyAvVdnu5/b0zTd97xg823FQraQOEIl/WxTxsHjUbqPPkR/Esanlw8v6
	zAyCxD81onCzNkX2SkWLetnzO3gM4bN0MDEGQfrnuemPZeVET24ImsUFLNpnTotWaCvlUg4qbJr
	jPARfjqU8na340fLga2HynVDh60a2dXFaf5n0OAZFfMoOxVWwVTDbXlOxv3F6RinA==
X-Received: by 2002:a05:6000:38d:b0:48b:a6:61b0 with SMTP id ffacd0b85a97d-48c6d1d9260mr3171130f8f.47.1791302777202;
        Tue, 06 Oct 2026 09:06:17 -0700 (PDT)
Received: from ?IPV6:2001:4bc9:b00f:d376:7c33:9a50:ef33:f391? ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2eeb6sm361132f8f.43.2026.10.06.09.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 09:06:16 -0700 (PDT)
Message-ID: <b6e99af8-994c-45c6-bc7d-8d1e6ba5f0a0@linbit.com>
Date: Tue, 6 Oct 2026 18:06:15 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] drbd: add the "drbd2" genl family
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
References: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
 <20261006154607.3936501-19-christoph.boehmwalder@linbit.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20261006154607.3936501-19-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/6/26 17:46, Christoph Böhmwalder wrote:
> DRBD 9's utilities need the multi-peer administration model that the
> version-1 wire cannot express: peers identified by node id, several
> paths per connection, per-peer-device options and statistics, and
> notifications for all of those. Rather than bump the "drbd" family
> and break every existing drbd-utils, add a second family, "drbd2",
> written as a YNL specification in Documentation/netlink/specs/ and
> following current generic netlink conventions: strict policies with
> ranges, nested objects, split do/dump ops, extended ACKs for errors,
> and a proper uapi header.
> 
> drbd2_nl_gen.[ch] and include/uapi/linux/drbd2.h are generated from
> the spec with tools/net/ynl and are not edited by hand.
> drbd_nl_drbd2.c is the struct drbd_nl_dialect adapter for the family.
> Both families are registered by the same driver and operate on the
> same objects; a resource created through either is visible through
> both, within what each wire format can express. drbd2 is always
> registered, so with DRBD_COMPAT_84=n it is the only family.
> 
> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> ---
>   Documentation/netlink/specs/drbd2.yaml | 2476 +++++++++++++++++++++++
>   drivers/block/drbd/Kconfig             |    6 +
>   drivers/block/drbd/Makefile            |    1 +
>   drivers/block/drbd/drbd2_nl_gen.c      |  748 +++++++
>   drivers/block/drbd/drbd2_nl_gen.h      |  107 +
>   drivers/block/drbd/drbd_nl_drbd2.c     | 2533 ++++++++++++++++++++++++
>   include/uapi/linux/drbd2.h             | 1012 ++++++++++
>   7 files changed, 6883 insertions(+)
>   create mode 100644 Documentation/netlink/specs/drbd2.yaml
>   create mode 100644 drivers/block/drbd/drbd2_nl_gen.c
>   create mode 100644 drivers/block/drbd/drbd2_nl_gen.h
>   create mode 100644 drivers/block/drbd/drbd_nl_drbd2.c
>   create mode 100644 include/uapi/linux/drbd2.h
Also CCing the YNL maintainers here. Original link:
https://lore.kernel.org/linux-block/20261006154607.3936501-19-christoph.boehmwalder@linbit.com/
