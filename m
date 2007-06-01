Return-Path: <simgrxp@gmail.com>
Message-ID: <92ae63eb0706010525h8a5389bie68847f0e9f46413@mail.gmail.com>
Date: Fri, 1 Jun 2007 08:25:06 -0400
From: "Simon Graham" <simgrxp@gmail.com>
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5623_32482396.1180700706348"
Subject: [Drbd-dev] DRBD-8 Patch: dont bail at startup if errors occur
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

------=_Part_5623_32482396.1180700706348
Content-Type: multipart/alternative;
	boundary="----=_Part_5624_1030902.1180700706348"

------=_Part_5624_1030902.1180700706348
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The checked in version of the drbd init script will bail if any errors are
encountered - this means, for example, that if you experience a disk failure
(or removal), then reboot the system, NO DRBD devices will come up because
the startup will bail as soon as it encounters the problem with the failed
disk - what should happen is the bringup should continue and the DRBD
devices using the failed disk should end up Diskless - this is pretty
important in an HA environment.

The attached patch changes the startup script to continue when an error is
found.

Simon

------=_Part_5624_1030902.1180700706348
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The checked in version of the drbd init script will bail if any errors are encountered - this means, for example, that if you experience a disk failure (or removal), then reboot the system, NO DRBD devices will come up because the startup will bail as soon as it encounters the problem with the failed disk - what should happen is the bringup should continue and the DRBD devices using the failed disk should end up Diskless - this is pretty important in an HA environment. 
<br><br>The attached patch changes the startup script to continue when an error is found.<br><br>Simon 

------=_Part_5624_1030902.1180700706348--

------=_Part_5623_32482396.1180700706348
Content-Type: application/octet-stream; name=drbd-startup.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: 0.2.0.1
Content-Disposition: attachment; filename="drbd-startup.patch"

SW5kZXg6IHNuL3NjcmlwdHMvZHJiZAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBzbi9zY3JpcHRzL2RyYmQJKHJl
dmlzaW9uIDE0NTYxKQorKysgc24vc2NyaXB0cy9kcmJkCShyZXZpc2lvbiAxNDU2MikKQEAgLTYx
LDcgKzYxLDcgQEAKIAlmaQogCUlGUz0kSUZTX08KIAkkQ01EIHx8IHsKLQkgICAgZWNobyAtZSAi
XG5jbWQgJENNRCBmYWlsZWQhIjsgZXhpdCAyMAorCSAgICBlY2hvIC1lICJcbmNtZCAkQ01EIGZh
aWxlZCAtIGNvbnRpbnVpbmchXG4iCiAJfQogCUlGUz0kTkVXTElORQogICAgIGRvbmUK
------=_Part_5623_32482396.1180700706348--
