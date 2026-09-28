Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24644E73DA
	for <drbd-dev@lists.linux.dev>; Mon, 28 Sep 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611435; cv=none; b=SHVvE6sifiedkMdr8lWuOSWH47MNPFAwfKTEHhaMlhkPQwKNDyORF/c+QVJh+0BOJDKXB9e1IP1vGs113akeyWEYIMNcJefvrFJhcADJx9kfI7ljq4iHHWfjNYKQUSNaVOWpBQ0XR7rT7EISk6RI4avEzV+RXcSjgPD56VqxWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611435; c=relaxed/simple;
	bh=Lm0BJ+pmlgzPzTew/OSuAZ8ddmksopK6/rHaEtTomBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI49kIV7UQHI8gRSVbwkahCDZl9DzWHTEHFl7oKlsnf5tGtKEIWxcbaAMoJMLvDzrWsyUiwB/8SNw0iPSrPKcxgs7eBNtSqOymzpssJsVHpeX97rRR/+h88AJtUeIoJjyePf+y2NXbnkgJcKDT7/KwCZjuRP7SAhuBzdB8+LacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=NZWVw/WT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="NZWVw/WT"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c294ad260fdso32017066b.1
        for <drbd-dev@lists.linux.dev>; Mon, 28 Sep 2026 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790611432; x=1791216232; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lm0BJ+pmlgzPzTew/OSuAZ8ddmksopK6/rHaEtTomBs=;
        b=NZWVw/WTorZRMq2+pYUHi35b6rzOiMH25iK8zR13OY7/9eOmvgUoWW7zj1c6G+yRz6
         VT2WaWzbmxpQf0iUcMeQ/xsZR8T2WunjTIllmre6DOimhexsCpzBapmWawXba6KlOWc6
         exa3hbnRNuZqFKhXbXN9iGwvq1hLqPUpIFWhPxSvbNJga6P8pAlWsS164PqIZk5DP3nZ
         oajTTNPzvy/zPtwoCpcR0Fo/FQ4ui7o6/GMfcJAIW2bo1PxLXEfMWfpJoTgjRkyRlrBn
         7TQ7L/ySdNcB8T3BBoHMkZq8aFIy2+exFY2Xglvt6r2nXRA+AzstU3bpNxCoSsPve0eQ
         Ct/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611432; x=1791216232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lm0BJ+pmlgzPzTew/OSuAZ8ddmksopK6/rHaEtTomBs=;
        b=T9pcL+PHexLbQnfPYYM/KDlI59qIPAqM052O+Q0M/mZCd6X9EW/Z8Tw1CXkJZF4XBX
         P7lKRznmiIwpljO74cRWHLec6obYhclBASDpdqaShXTFDoLZOubUi1ZZGgmYJA1EWogy
         AnqZRXEKbNpeXuhULj5MQvZ1s/UwrPs4TB5CFDzN5mQKDsD0qhg8fUoted3AN76U+KJn
         vmRiH5Z1roM5J6APwx82qkcxF2UnHiDN8P+8e2fDfsEPi6E9ghO4oF/ideqVPwrIIV9Q
         ke8rXxqLmRbHY0RnMT1goVIERMX1uC2FPRyIJu/44c2CYdR+o3bixcwtJD/rzJTYP2ox
         CXIA==
X-Gm-Message-State: AFuF++kdFsMVpdBGukvKy0MMs+7xg7TRn+MzCGSYiZ4sWtw5iGV53NFO
	CyAeRqxEpVB0CshNeupFb0TH0ynBHWPYiVlKwCj5l1oY+sp5Gop0Xv/d+fziP8Iy0jGpP5Xyyen
	8oyY0
X-Gm-Gg: AYBFou38OJUd7p1Lofp2AJM3ELrZ+XpPpk7ZEfOrGabzmn6wE+necrE1qLzdfpzxqvs
	g9KgIM198Uy03fdcN/FY4FAeVSQeyYO9pHoR7WaPeHdCjJsQZyxqUOBRvTeCCMjk///ViLs4+zg
	FA3/SfLUGHkrWPrAxlgw/Ow1nhb6JT4RpWeKdfLwFn/t+C1BUandpAt9mTBupYCAHXVrJCsZ36G
	el96xpvqGqnjcpGxTV6w8Yp/dANj8TiGwHSHMqtM0EAjHwPkDjXncplwUjOnLQQrIt7Lo7azYfH
	eFsXB3nISuvRRjdGE8xgqbNm2zAH3Ke8uTv+JGO0Q7fM/sUQ8MuXXwDuaCyBRwUm3OI/gZbokDl
	vAfPcuyBqjhxcrDfdAByHrfpox1sE5tjOB2PnRjNYmheqjM+N1qW/4xXWOthjxkkwB0kND7Cwq9
	R8iyJfjweVgrPGVZONF7hGRs2VwlmsOAJiqYuUIlnyR8LTq25XQLKZ3qXb6WFmemQ2eTT72hhrx
	sN54OHFWiU6Q24m4op2bd6aP4/hxRUq4nwJTkim8tJXcA==
X-Received: by 2002:a17:907:a68b:b0:c25:3e36:acc8 with SMTP id a640c23a62f3a-c2ac21f8f25mr1111294366b.4.1790611431784;
        Mon, 28 Sep 2026 09:03:51 -0700 (PDT)
Received: from fw13-phil (093111099180.atmpu0044.highway.a1.net. [93.111.99.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2de104355fsm145093166b.19.2026.09.28.09.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:03:51 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:03:49 +0200
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Amirhossein Rahimi <amh.rhimi@gmail.com>
Cc: drbd-dev@lists.linux.dev
Subject: Re: [BUG] DRBD 9.3.4: acknowledgement counter rewind and stalled
 resync after failover
Message-ID: <arqP5STzDsErl0KN@fw13-phil>
References: <CAFQ+Lwv41X=4BFLeWEdacOHowB5M6KojJ8fG90-U+sCNhLkWZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQ+Lwv41X=4BFLeWEdacOHowB5M6KojJ8fG90-U+sCNhLkWZg@mail.gmail.com>

Hello,

thank you for the careful report.

I can confirm the problem is real. We reproduced it in our lab and it now has
an automated regression test. Your diagnosis points at the right place: a write
that never gets a dagtag assigned can move the peer-acknowledgement tracking
backwards, after which the resync waits for a flush acknowledgement that is
never sent. That also explains why the data compared equal — nothing was
actually out of sync.

A fix is in review. We expect to have it available within the next few days,
and I will come back to you once it is merged.

Best regards,
Philipp
