Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175100;
	b=ZtyxOO/5RzViEabZg3wGBGYGnbwoEBXDaUfW2//A06MlEN+f28QTlFtib2ZZV1MMaxV4
	 qBsWe5ZBJdlQwRRID0SnVzDs698N1ji1XE+HkJpdL1O7nxVlCcvV6os0yVzEO45Pha670
	 bAYcXEkghN+EuG0EK8U983r6//wybEyr6As0ZHf+stpgjDaHsMUcc7rTgkNjZ6RPWo4vK
	 rBOFJMNTEHKvURYBX//YWmpUAILzQJEAMXcy4G2SyQSn+x0AIwCcUO9PmMlaoMfHeEZ4l
	 cjFzAwLXhDZZp1quL2YSmrHF0yBnpgD/pO+043fE9R/Q1Hzu/QaPbHBOUbXPQ1h7ShA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sdsG+eThRvcI9HCYyGBK10hDw1tWFZFbpCUEL03/hJY=;
	b=C7pzgByq41DTmna36TAfaSZhiUKrsz6JYQODF+FP1OqvZqri1MnIL28BWqir8gjwudhG
	 lgaTtRqdGHJJtGBEF1vU6Dv+TOwa8Jy2o08TcvoPr8FGlukevnKjHkQBjmCDpMIGSKp4W
	 V/bbhsOdMI9n7/kGC3A2E6xOEhfaB5vnoUZFyimlbkFgEvRy8vQupGbXykTkZVAcpY51O
	 Zk/HHTUCRePSPNwGYGuo11fVM6wL4DdfcL1KQXMH7q5pBLOMEreeQp+TMH7zcNCVJfUTV
	 fou5bVS2p52gjJoxCnwPl6N20Dj+Bt21kwmPqdOy5b6gy3QvEMj+q8zapyGzeIeiRGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NyX3fSy5;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB6606A338
	for <drbd-dev@lists.linux.dev>; Fri, 20 Nov 2026 11:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1DB6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NyX3fSy5
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f041f88577so4635265ad.1
        for <drbd-dev@lists.linux.dev>; Fri, 20 Nov 2026 03:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795175099; x=1795779899; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sdsG+eThRvcI9HCYyGBK10hDw1tWFZFbpCUEL03/hJY=;
        b=NyX3fSy5hPsYh68DntpE9gn5nX01AI18vgPFgyHwp2+t2Lz0cx+oLWPMARNVH9Slqs
         jMv6T50Kv/tK2FkOl/HTnClgXQoZ0iztiBzy0BI8bcmjVVtHO1mRbDpKbIrJw/xS72c+
         qNggvUJGWg88xOo3MKePH+NWzhXuRsjSyOx1WxVOwx2/uOxV5ORQM87Vd9Z32dVF6hoy
         VrAhmFDx4Nv+nvkdFMhl4adzxYxj8AbksRX+poiFGRhsjQnxRKNAgLyjz31AdVntYebZ
         wBDa2q3FezPbRRzW1uu7cDKl/fFUCiQhhC1rBdcCh16BTtLadTmRxUeJG/B92QefhE6D
         zDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795175099; x=1795779899;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdsG+eThRvcI9HCYyGBK10hDw1tWFZFbpCUEL03/hJY=;
        b=vMz14KjvewQi6/5Y+V+OXztRk6rcqIMiePVdWbWoDhbJm3R0hS0tGqiDs4d0MSZfy7
         QRSppn++J63bmibUcgSCuHXm7G+qjR76SmDu1agNJ1BpgVpXAzGDUDyQaN8I1qYhjKCP
         kXqUVAbQ9cYEueQ7FevTPImAL9G28NDtaiemwqQV7bJ42I1LwDsvYfTBCdPE4D2q+wO3
         HZU0apJxyUTjaxaPMVuNoSMVfwtx4pEKGINcToXnLg1s6bf1rIt9ym9o/1uoGDFCJDen
         uT+ayzqhFWNL/ApLc59lotnaskRFbB+dzfGXypyyXjQ3aa1D9ePCk5Zw8J7Rsvr6uqY0
         yItA==
X-Forwarded-Encrypted: i=1; AL+hErEF0zylQZ6ZvZm6zJyC0Be6ZtP6DzXiBhUDNLN5Qpdr1a7j7+mlwLlurifWuN1orjzZnyogd/ftJg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GZtdLQHV6NbuSd2RzTNJ2OTvndUAPKtGoO61b1KsJ+JssIX3X
	UzhNVLPev3+yPukQgkU5Eu/D3f2ONkQQQNQKaoCMPsJe3ySscm3zbt9ZKIPNCQJlAqM=
X-Gm-Gg: AZFdTZdfuD9zCDKq9RWABApXuyb2pl5zfplZG5fL2C0eq/F3fGi4tKJhX8oyuZys592
	QeM6hcJSlaQGX3tTnqC+zupIU3EPVvhFTAftF9thcn43mByVkf8GJQnk3EbkPvroolKfH5vHRnw
	bCIjB+IMYvwLi78xEbdkG4zK7/u5S7NTmvCxm7+BGjzr8KMXBGhdMTnaNNRNsXT7N+WMFY3YkyC
	OXimc6fpvGQBaIU9SAxjo8YseorhUwVu51Hhbbn9URNDAzbMJmag+LbWBaQtQrdNBMYro/6kfX0
	psTT3NZgJiC0GccFd3hrJk0pje1nIjpT6q6WCM/XYdg9E9Sh0ot1jUtd1E+dOZOWmCvAmwhCrc8
	wmXZf9qUiJaaujao+5oDiR9ZkiK52BODjpbYXDUljqhDlRUSOVnn6Vc6f8y8nwDiPouVjsQ2gOL
	dG7mp93l3HvlGRJFT8pMxj265GCUkSbo76kmesBIrhtS7+SKYUKpzP6pm1E82jI3/Y3WDoGIChF
	jzKHVL5EOgygkE5baFARQfQQbDfmAb2Y2RrPaSTyuainjcNddEDlfHhjmZHnR9QWXDq/507t8+I
	i19ZCDKGmXy2QuOc68yNRxndHJ31c/UcVJc62l+787li2KaiiONBcQHIsUSMOzV5zmD4u21I0fs
	fM6YnNpndFKksXhCWXtS8yK+Gs4zHjPbFbmRs
X-Received: by 2002:a17:903:2c50:b0:2e9:64b9:a330 with SMTP id d9443c01a7336-2f03f17d2ccmr29212195ad.11.1795175099419;
        Fri, 20 Nov 2026 03:44:59 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:8b25:951:ad8d:5cc1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1215e2sm13289485ad.63.2026.11.20.03.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:44:58 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: philipp.reisner@linbit.com
Cc: lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Fri, 20 Nov 2026 20:44:54 +0900
Message-ID: <20261120114454.3072690-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
References: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is superseded by v2:
  https://lore.kernel.org/all/20261006141509.521128-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee
