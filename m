Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.177.71.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618654;
	b=U9qGG3KMoTPjBvZ01GJ1s1fpTuwqeddauc1O6Tr1TXAk3wjhMtdsbFvfdHPplxLkG4m1
	 xZTIL2eEe1N8qm9tJwG/Xj8vlTky7mYiDlQFcSy+gtaiwZmW6AJWBg4tHOL7uwxxLK7W3
	 DR5NRmd/lAGgnoclo48yxY1Ooj8cHgvseYYOfNHwyBd4qQFeTwGJrb0dKjDogaZ1ya7Ir
	 Di0XkyUyWMuh4bWzXjSRalq0X3cdQ2lW/NsaxIX9ID/vMe5G1QLd3Qj8BhFf1w9cMti7w
	 k04SVOItQ1X+cTSsbV6//LesuKoGVzHCWXZST612hPbdxPF9McJ57xP284BgXYShbsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618654;
	h=DMARC-Filter:Received:X-Virus-Scanned:X-Spam-Relay-Country:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:References;
	bh=6o8j3L864V8VP9tLvrvbuL14Ole+xHYPWpVM0g6Ogcw=;
	b=rbR8OZuIy/gKhyz6BXBzo/ojXeJoZJE4b0vFqztksCA5wpIVuD+nZ+0CN2q445dKvy2l
	 dDs0wIxImRt2iXGBT9FsI1071+ucNUDSTHXPqxW6KXEvBr9v5YzBNZpYuMPaQXv572ohn
	 j5498S6fGYZ6rckGln1ZVel3Mvmmdt52HKziAuhP8l1+dL6mwqJ/WjBWZFPPgXYsKpUlI
	 sSRpHGBuGsxPf9IgVdT3L6whVaS4VD3TwXsbWbWWA6kx8+LTuWDi0QlVo/YKY8QV3zXZv
	 UEa6BhG/5wPo8pH8GMC81r59nl93DosZ0gQ8G+65z7pV6LxyBbgtim88/PclnpN3T+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=let2.com;
	spf=pass smtp.mailfrom=let2.com;
	dkim=pass header.d=let2.com header.i=@let2.com header.a=rsa-sha256 header.s=mail header.b=pMEBX1uI;
	arc=none smtp.remote-ip=80.177.71.131
Received: from static-80-177-71-131.vodafonexdsl.co.uk (static-80-177-71-131.vodafonexdsl.co.uk [80.177.71.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92F606A881
	for <drbd-dev@lists.linux.dev>; Mon,  2 Nov 2026 11:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC92F606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=let2.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=let2.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=let2.com header.i=@let2.com header.a=rsa-sha256 header.s=mail header.b=pMEBX1uI
Received: from localhost (localhost [127.0.0.1])
	by static-80-177-71-131.vodafonexdsl.co.uk (Postfix) with ESMTP id A680525463;
	Mon, 02 Nov 2026 11:23:55 +0000 (GMT)
X-Virus-Scanned: amavis at let2.com
X-Spam-Relay-Country: 
Received: from static-80-177-71-131.vodafonexdsl.co.uk ([127.0.0.1])
 by localhost (let2.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2VXi56fsQP2; Mon,  2 Nov 2026 11:23:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=let2.com; s=mail;
	t=1793618635; bh=6o8j3L864V8VP9tLvrvbuL14Ole+xHYPWpVM0g6Ogcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pMEBX1uIgLDQLxA788yM4HPDjk7LDGZe9JRlIugM7vVzROQq1Pn3C0FHv38Ch74gM
	 NeCCNGRnExaAuadOI8AED29Vn2XHQVyNluoz3earPKBUQypEDlg7qpMpjDN2P8qDTv
	 OK9eQLzk4layniEi6q1jAHLaEUW65vd0p5by9eps=
Received: by static-80-177-71-131.vodafonexdsl.co.uk (Postfix, from userid 1000)
	id 35D1025462; Mon, 02 Nov 2026 11:23:55 +0000 (GMT)
Date: Mon, 2 Nov 2026 11:23:55 +0000
From: Dominic <dominic@let2.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linux.dev
Subject: Re: 9.3.4: resync after a crashed Primary misses blocks (silent
 divergence) if that node was promoted in place after being Secondary under
 another Primary
Message-ID: <auhyyxG1a7C_-3mU@let2.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGDV=VOZfZY0X0wMc6vWBBsnfTQQNxhRxAa_s=6phsrH1fXOQ@mail.gmail.com>
References: <auBG6pq0aKXwupY9@let2.com>
 <CADGDV=VOZfZY0X0wMc6vWBBsnfTQQNxhRxAa_s=6phsrH1fXOQ@mail.gmail.com>

Hi Phil,

Thank you for the quick and clear answer.

I re-ran our sequence on current master in the same two VMs:
git 0192e7af3 ("Merge drbd-9.2/793f90dff53c ..."), which contains
39d0a42c51a1 and cabad431fc02, built with "make" against
7.0.0-38-generic and installed in place of the 9.3.4 dkms module on
both nodes. drbd-utils is unchanged (9.35.0), and so is the
configuration (2 volumes, max-peers left at the default).

Results, with the same steps as in my report:

- Failing case (B Primary, write, demote, then in-place promotion of
  A), twice: the log still shows "Disabling local AL-updates
  (optimization)" while B is Primary. After A's crash and attach, A
  resyncs 28672 KB [7168 bits set] on volume 0 (9.3.4: 3072 bits), and
  the backing devices match on both volumes. Both runs passed.
- Control without the B Primary step: 6144 bits, match.

So the fix covers our exact sequence. On 9.3.4 it failed 3 times out
of 3; on master it passed 2 out of 2, plus the control.

For production we will keep promoting only after a fresh attach, and
move to the first release that carries the fix.

Best regards,
Dominic
