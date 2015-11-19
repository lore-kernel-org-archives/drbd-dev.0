Return-Path: <tpoluri@mvista.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3095A10518AC
	for <drbd-dev@lists.linbit.com>; Thu, 19 Nov 2015 13:17:42 +0100 (CET)
Received: by wmww144 with SMTP id w144so236061311wmw.1
	for <drbd-dev@lists.linbit.com>; Thu, 19 Nov 2015 04:17:41 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 19 Nov 2015 17:40:23 +0530
Message-ID: <CAM8gD7WAmKjOFwPYMg-WSfa5426a9kqt-Qh7VWkwHKTB_pzGzA@mail.gmail.com>
From: Tejaswini Poluri <tpoluri@mvista.com>
To: drbd-dev-request@lists.linbit.com
Cc: drbd-dev@lists.linbit.com, drbd-dev-owner@lists.linbit.com
Content-Type: multipart/mixed; boundary=047d7bf10a9eb779440524e3a41a
Subject: [Drbd-dev] [PATCH 1/1] protocol_b_iscsi_timeout
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

--047d7bf10a9eb779440524e3a41a
Content-Type: multipart/alternative; boundary=047d7bf10a9eb7793f0524e3a418

--047d7bf10a9eb7793f0524e3a418
Content-Type: text/plain; charset=UTF-8

Hii,

We have come across a small bug while testing drbd-8.3.16 with iscsi. The
experiment we have done is:

*Primary* : Setup drbd using a loop device
dd if=/dev/zero of=/tmp/test/drbd_disk bs=4K count=6000
losetup /dev/loop0 /tmp/test/drbd_disk
mkfs -t ext3 -b 4096 /dev/loop0
resize2fs /dev/loop0 5143
sleep 2
modprobe drbd
hostname secondary
echo yes|drbdadm create-md r0
drbdadm up r0

*Secondary*:  iscsi disk /dev/sda.
iscsiadm -m discovery -t sendtargets -p 10.162.103.59
iscsiadm --mode node --targetname iqn.2014.04.com.example:storage_tej.lun2
-p 10.162.103.59 --login
mkfs -t ext3 -b 4096 /dev/sda
resize2fs /dev/sda 5143
sleep 2
mknod /dev/drbd0 b 147 0
hostname secondary
drbdadm create-md r0
drbdadm up r0

*Primary* -
drbdadm -- --overwrite-data-of-peer primary r0
After checking that both the disk states are Uptodate/Uptodate using cat
/proc/drbd , mounted the drbd disk and run the following script.
mount /dev/drbd0 mnt_dir/
./sync.sh
cat sync.sh
while true; do date | tee -a /home/root/mnt-dir/c.dat; echo -n A ; sync ;
echo -n B ; sleep 1 ; echo C ; done

with having following timeout values in drbd.conf
net {
    no-tcp-cork;
    timeout 10;
    ping-int 10;
    ping-timeout 5;
    ko-count 3;
  }


*Test case:*
While running the script, the network of iscsi secondary disk is made down
but the script continuous to run in Primary without recognizing its peer
disk is not up. This happens as the iscsi-disk has a tolerance of 120 sec
and only after which it says that the disk is failed. This delays the drbd
operation and synchronization. This happens only in Protocol B and not in
Protocol C because protocol c checks for WRITE_ACK which doesn't happen
when the disk is not up while the former checks for only RECV_ACK which
happens once the packet is received by peer.

The attached patch resolves the issue and is tested in drbd-8.3.16 and
would be useful for linux-kernel running 2.6 version.


Regards,
Tejaswini

--047d7bf10a9eb7793f0524e3a418
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hii,=C2=A0<div><br></div><div>We have come across a small =
bug while testing drbd-8.3.16 with iscsi. The experiment we have done is:</=
div><div><br></div><div><b>Primary</b> : Setup drbd using a loop device</di=
v><div><div>dd if=3D/dev/zero of=3D/tmp/test/drbd_disk bs=3D4K count=3D6000=
<br></div><div>losetup /dev/loop0 /tmp/test/drbd_disk</div><div>mkfs -t ext=
3 -b 4096 /dev/loop0</div><div>resize2fs /dev/loop0 5143</div><div>sleep 2<=
/div><div>modprobe drbd<br></div><div>hostname secondary<br></div><div>echo=
 yes|drbdadm create-md r0</div><div>drbdadm up r0</div></div><div><br></div=
><div><b>Secondary</b>: =C2=A0iscsi disk /dev/sda.<br></div><div><div>iscsi=
adm -m discovery -t sendtargets -p 10.162.103.59</div><div>iscsiadm --mode =
node --targetname iqn.2014.04.com.example:storage_tej.lun2 -p 10.162.103.59=
 --login</div></div><div><div>mkfs -t ext3 -b 4096 /dev/sda</div><div>resiz=
e2fs /dev/sda 5143</div><div>sleep 2</div><div>mknod /dev/drbd0 b 147 0</di=
v><div>hostname secondary</div><div>drbdadm create-md r0</div><div>drbdadm =
up r0</div></div><div><br></div><div><b>Primary</b> -</div><div>drbdadm -- =
--overwrite-data-of-peer primary r0</div><div>After checking that both the =
disk states are Uptodate/Uptodate using cat /proc/drbd , mounted the drbd d=
isk and run the following script.</div><div>mount /dev/drbd0 mnt_dir/</div>=
<div>./sync.sh</div><div>cat sync.sh<br></div><div>while true; do date | te=
e -a /home/root/mnt-dir/c.dat; echo -n A ; sync ; echo -n B ; sleep 1 ; ech=
o C ; done</div><div><br></div><div>with having following timeout values in=
 drbd.conf</div><div><div>net {</div><div>=C2=A0 =C2=A0 no-tcp-cork;</div><=
div>=C2=A0 =C2=A0 timeout 10;</div><div>=C2=A0 =C2=A0 ping-int 10;</div><di=
v>=C2=A0 =C2=A0 ping-timeout 5;</div><div>=C2=A0 =C2=A0 ko-count 3;</div><d=
iv>=C2=A0 }</div></div><div><br></div><div><br></div><div><b>Test case:</b>=
</div><div>While running the script, the network of iscsi secondary disk is=
 made down but the script continuous to run in Primary without recognizing =
its peer disk is not up. This happens as the iscsi-disk has a tolerance of =
120 sec and only after which it says that the disk is failed. This delays t=
he drbd operation and synchronization. This happens only in Protocol B and =
not in Protocol C because protocol c checks for WRITE_ACK which doesn&#39;t=
 happen when the disk is not up while the former checks for only RECV_ACK w=
hich happens once the packet is received by peer.=C2=A0</div><div><br></div=
><div>The attached patch resolves the issue and is tested in drbd-8.3.16 an=
d would be useful for linux-kernel running 2.6 version.</div><div><br></div=
><div><br></div><div>Regards,</div><div>Tejaswini</div><div><br></div><div>=
<br></div></div>

--047d7bf10a9eb7793f0524e3a418--

--047d7bf10a9eb779440524e3a41a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-drbd-Protocol-B-timeout-when-secondary-iscsid-disk-f.patch"
Content-Disposition: attachment;
	filename="0001-drbd-Protocol-B-timeout-when-secondary-iscsid-disk-f.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ih65hzhm0

RnJvbSBkNGFiMWY3NTAzMGIwOGI2Y2Y3NjAyYWU1MTY5YzVhZjgzMWZkOTczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUZWphc3dpbmkgUG9sdXJpIDx0cG9sdXJpQG12aXN0YS5jb20+
CkRhdGU6IFRodSwgMTkgTm92IDIwMTUgMTI6NTM6NTkgKzA1MzAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJiZDpQcm90b2NvbC1CLXRpbWVvdXQgd2hlbiBzZWNvbmRhcnkgaXNjc2lkIGRpc2sgZmFp
bHMKCkluIFByb3RvY29sIEIsIGFzIFJFQ1ZfQUNLIGlzIHRvIGJlIGRvbmUgd2l0aG91dCB3cml0
ZSBhdCBwZWVyLApoZW5jZSBldmVuIHdoZW4gc2Vjb25kYXJ5IGlzY3NpZCBkaXNrIGZhaWxzLCBS
UV9ORVRfUEVORElORyBpcyBjbGVhcmVkCmFuZCByZXF1ZXN0X3RpbWVyX2ZuIG5ldmVyIHRpbWVz
IG91dC4KClNvIHdoZW4gc2Vjb25kYXJ5IGlzY3NpZCBkaXNrIGZhaWxzIGluIHByb3RvIEIgd2Ug
Y2hlY2sgaW4gcHJpbWFyeQppZiB0aGVyZSBpcyBubyBiYXJyaWVyX2FjayByZWNlaXZlZCBmb3Ig
YSBjZXJ0YWluIHJlcXVlc3RzIChOT19CQVJSSUVSX0FDS19USFJFU0hPTEQpCmFuZCB0aGUgbmV0
d29yayBhcHBlYXJzIGZpbmUgKFJRX05FVF9PSykgYnV0IHRoZSByZXF1ZXN0IGlzIG5vdCBkb25l
ICghUlFfTkVUX0RPTkUpIHlldCBhbmQgd2UgdGltZW91dC4KClNpZ25lZC1vZmYtYnk6IFRlamFz
d2luaSBQb2x1cmkgPHRwb2x1cmlAbXZpc3RhLmNvbT4KLS0tCiBkcmJkL2RyYmRfcmVxLmMgfCAy
MyArKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcmJkL2RyYmRfcmVxLmMgYi9kcmJkL2Ry
YmRfcmVxLmMKaW5kZXggM2ExYzRhNS4uMTUzMjViOCAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX3Jl
cS5jCisrKyBiL2RyYmQvZHJiZF9yZXEuYwpAQCAtMTM0MCw2ICsxMzQwLDIyIEBAIGludCBkcmJk
X21lcmdlX2J2ZWMoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsCiAJfQogCXJldHVybiBsaW1pdDsK
IH0KKyNkZWZpbmUgTk9fQkFSUklFUl9BQ0tfVEhSRVNIT0xEIDUKK3N0YXRpYyBib29sIGlzX3Bl
ZXJfcmVxX3NlbnQoc3RydWN0IGRyYmRfcmVxdWVzdCAqcmVxLCBib29sIGlzX25vX2JhcnJpZXJf
YWNrKQoreworCWlmIChyZXEtPnJxX3N0YXRlICYgUlFfTkVUX1BFTkRJTkcpCisJCXJldHVybiB0
cnVlOworCisJLyogY2FzZTpQcm90b2NvbCBCLCBhcyByZWN2IGFjayBpcyBkb25lIHdpdGhvdXQg
d3JpdGUgYXQgcGVlciwKKwkgKiBSUV9ORVRfUEVORElORyBpcyBjbGVhcmVkLiBTbyB3aGVuIHBl
ZXIgZGlzayBlcnJvcnMgaGFwcGVuIHByb3RvIEIKKwkgKiB3ZSBjaGVjayBpZiB0aGVyZSBpcyBu
byBiYXJyaWVyX2FjayBmb3IgYSBjZXJ0YWluIHBlcmlvZCAmCisJICogdGhlIG5ldHdvcmsgYXBw
ZWFycyBmaW5lIGJ1dCB0aGUgcmVxdWVzdCBpcyBub3QgZG9uZSwgd2UgdGltZW91dCAqLworCWlm
IChpc19ub19iYXJyaWVyX2FjayAmJiAocmVxLT5ycV9zdGF0ZSAmIFJRX05FVF9PSykKKwkJCQkm
JiAhKHJlcS0+cnFfc3RhdGUgJiBSUV9ORVRfRE9ORSkpCisJCXJldHVybiB0cnVlOworCisJcmV0
dXJuIGZhbHNlOworfQogCiB2b2lkIHJlcXVlc3RfdGltZXJfZm4odW5zaWduZWQgbG9uZyBkYXRh
KQogewpAQCAtMTM0OCw2ICsxMzY0LDcgQEAgdm9pZCByZXF1ZXN0X3RpbWVyX2ZuKHVuc2lnbmVk
IGxvbmcgZGF0YSkKIAlzdHJ1Y3QgbGlzdF9oZWFkICpsZTsKIAl1bnNpZ25lZCBsb25nIGVudCA9
IDAsIGR0ID0gMCwgZXQsIG50OyAvKiBlZmZlY3RpdmUgdGltZW91dCA9IGtvX2NvdW50ICogdGlt
ZW91dCAqLwogCXVuc2lnbmVkIGxvbmcgbm93OworCWJvb2wgaXNfbm9fYmFycmllcl9hY2sgPSBm
YWxzZTsKIAogCWlmIChnZXRfbmV0X2NvbmYobWRldikpIHsKIAkJaWYgKG1kZXYtPnN0YXRlLmNv
bm4gPj0gQ19XRl9SRVBPUlRfUEFSQU1TKQpAQCAtMTM5Myw3ICsxNDEwLDExIEBAIHZvaWQgcmVx
dWVzdF90aW1lcl9mbih1bnNpZ25lZCBsb25nIGRhdGEpCiAJICogfjE5OCBkYXlzIHdpdGggMjUw
IEhaLCB3ZSBoYXZlIGEgd2luZG93IHdoZXJlIHRoZSB0aW1lb3V0IHdvdWxkIG5lZWQKIAkgKiB0
byBleHBpcmUgdHdpY2UgKHdvcnN0IGNhc2UpIHRvIGJlY29tZSBlZmZlY3RpdmUuIEdvb2QgZW5v
dWdoLgogCSAqLwotCWlmIChlbnQgJiYgcmVxLT5ycV9zdGF0ZSAmIFJRX05FVF9QRU5ESU5HICYm
CisJaXNfbm9fYmFycmllcl9hY2sgPQorCQltZGV2LT5uZXdlc3RfdGxlLT5icl9udW1iZXIgPiAo
bWRldi0+b2xkZXN0X3RsZS0+YnJfbnVtYmVyCisJCQkJCSsgTk9fQkFSUklFUl9BQ0tfVEhSRVNI
T0xEKSA/IDEgOiAwOworCisgICAgICAgaWYgKGVudCAmJiBpc19wZWVyX3JlcV9zZW50KHJlcSwg
aXNfbm9fYmFycmllcl9hY2spICYmCiAJCSB0aW1lX2FmdGVyKG5vdywgcmVxLT5zdGFydF90aW1l
ICsgZW50KSAmJgogCQkhdGltZV9pbl9yYW5nZShub3csIG1kZXYtPmxhc3RfcmVjb25uZWN0X2pp
ZiwgbWRldi0+bGFzdF9yZWNvbm5lY3RfamlmICsgZW50KSkgewogCQlkZXZfd2FybihERVYsICJS
ZW1vdGUgZmFpbGVkIHRvIGZpbmlzaCBhIHJlcXVlc3Qgd2l0aGluIGtvLWNvdW50ICogdGltZW91
dFxuIik7Ci0tIAoxLjkuMQoK
--047d7bf10a9eb779440524e3a41a--
