Return-Path: <major@mhtx.net>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
	[209.85.214.181]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E2A5C1028A59
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jul 2015 15:11:14 +0200 (CEST)
Received: by obbop1 with SMTP id op1so5569807obb.2
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jul 2015 06:11:12 -0700 (PDT)
Received: from [192.168.80.2] (builder.mhtx.net. [23.253.241.163])
	by smtp.googlemail.com with ESMTPSA id
	ke3sm392391obb.28.2015.07.14.05.44.54 for <drbd-dev@lists.linbit.com>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Jul 2015 05:44:54 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: Major Hayden <major@mhtx.net>
Message-ID: <55A50445.70205@mhtx.net>
Date: Tue, 14 Jul 2015 07:44:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] drbdmanage and Python 3
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello there,

This is my first email to this list, so please let me know if this email is off-topic or belongs elsewhere!  I've been a DRBD user for several years and I maintain the drbd packages for Fedora.

I heard about drbdmanage and DRBD9 at a conference recently and I'm working to package drbdmanage on Fedora.  However, it appears that drbdmanage isn't ready to be run with Python 3 quite yet.  I found some print's without parentheses fairly quickly but I haven't taken a deep dive yet.

Would Python 3 support and fixes be welcomed for drbdmanage?  If so, would it make sense to send lots of patches to this list or send them somewhere else?

Thanks for reading this far!

- --
Major Hayden
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVpQRCAAoJEHNwUeDBAR+xKzgP/2CuACriw9T/3AkTwJb4m+QQ
e7ewFBcBH02jA9hIO8aC0v/k2TRatV0Zcw3he1I4c4LMjOzJGNbkH2xgpN2cqkeF
L7UMn2/UKrMz/OtcM8sGt4ealSpGY4zSnSL906buz/kC3iXwWS+GllAJnjbMpTHg
SKQeGgKPmC/iQWPUHAvTwSx/WufI4w0fVbrpAe0qgKuyPb3/7TzMK2lviG2NZQrQ
P+luiez1vAuW54Dg/cwS6yvoOLcUTu0jytZWU5O7Yceb+u1KN13W3Qs/q6E7Lu+T
41rbpIPFAWAjZDQnqCxKRHb55rLJQmQJANwzaOwgAXYOOqs7sLMlMkzhsUeqZG1K
UdXvQSgDgmV9fFyxvpHMWRWH1tsul0Qkg6lPUSiKqokm6LDV92KY+MNnx1MOn75d
eG9YCPwlZpbATqigp1/deE1/BR3gNIc+tyfR3oMRAgcc5lrlyXKI9zQxRtKpt6r3
UpCsSrKjsVNb5+aQumOe4Og7TeLjpA6zk5BPNpNT4CVqZkCTw48tanJMlBQoOE8/
fFjenlSRrlDun7OvTyq235TENjCV6/9nLDyNYhug3Her6HpSH+IDuG7CjyGfPyYE
ULNUz9amOjt2SwCmNMyZ/5ZacNW4Vtf5eMOH6jpG/PBQRcOEDejruy1QpH/SZ+PV
fnwJKgafhwei4PwOKzJ1
=a/Cz
-----END PGP SIGNATURE-----
