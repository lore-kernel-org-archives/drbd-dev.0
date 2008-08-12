Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8FC98.E816CAE7"
Date: Tue, 12 Aug 2008 12:31:42 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41EC3105F@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Huge latency issue with 8.2.6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8FC98.E816CAE7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We've been benchmarking DRBD 8.2.6 and have found that some specific =
benchmarks (SQL) have absolutely terrible performance (a factor of 100 =
worse than the non DRBD case - 30 transactions per second versus 3000). =
These issues go away when we power off the secondary system, so it seems =
likely that it's somehow related to the network component. After some =
analysis of network traces, we found the following:

1. When we are doing 30TPS, we're also doing about 30 1K writes/s - the =
conclusion here is
=A0  that one transaction needs 1 1K (2 block) write. This means we are =
seeing a write-to-write
=A0  time of around 33ms. To hit the 3000TPS mark, we'd need to be =
handling 3000 1K writes/s
=A0  which means a total write-to-write time of 333us

2. When we do a tcpdump on the node running the benchmark, we see the =
following DRBD protocol=20
 =A0 consistently:
=A0  . Node issues barrier + 1K write + unplug remote in a single packet
=A0  . Receives barrier ack on meta-data connection 30-130us later
=A0  . Receives Data ack on meta-data connection ~250us later (after =
original rq issued)
   . Receives TCP level ack on data connection 35-40ms later
=A0  . The next write is not sent on the wire for 35-40ms

3. tcpdump on the other node shows the time between sending the =
barrierack and sending the
 =A0 data ack is around 120us -- this is basically the disk write time.

Conclusion 1 -- network latency has nothing to do with the horrendous =
perf we are seeing. What's more, we are adding (250 - write_time)us to =
the overall time to write the block - it seems that the disk write time =
is of the order of 120us, so we are adding around 130us to the total =
write time -- this should lead us to a max possible TPS value around =
4000...

Conclusion 2 -- the problem here has to do with the time is takes the =
secondary to send the TCP ACK.

I should also note that we are running this system with GSO disabled -- =
this in turn means that the zero-copy writes done by DRBD actually turn =
into non-zc writes inside TCP (if you look at tcp_sendpage in tcp.c, you =
will see that zero-copy is disabled unless scatter gather is enabled and =
scatter gather is disabled if you don't have checksum offload enabled).

So, my theory is that the first write completes very quickly (around =
300us), then the app issues the second write which is passed to TCP BUT =
TCP does not send it because it is waiting for buffers to be free which =
doesn't happen until the TCP level ACK is received on the data =
connection. In addition, the data connection is basically unidirectional =
-- all the other DRBD protocol messages flow on the meta-data =
connection.

So, what we are running into here is the TCP ACK-Delay timer on the =
secondary node - since we never send any data from the secondary to the =
primary on this connection, we have to wait for the timer to expire =
before acknowledging the data.

I have prototyped a change that uses the TCP_QUICKACK socket option to =
force acks to be sent when the UnplugRemote message is received and this =
has made a huge difference - in our original tests (which, in the =
interests of full disclosure, were run against DRBD8.0) we saw the =
performance go from 30TPS to 1600+TPS.=20

Forcing the Ack to be sent when the UnplugRemote is received seems the =
right fix to me, but please comment... candidate git patch against the =
HEAD of 8.2 is attached.

Simon


------_=_NextPart_001_01C8FC98.E816CAE7
Content-Type: application/octet-stream;
	name="0001-Ensure-data-is-ACK-d-at-TCP-level-in-a-timely-fashio.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Ensure-data-is-ACK-d-at-TCP-level-in-a-timely-fashio.patch
Content-Disposition: attachment;
	filename="0001-Ensure-data-is-ACK-d-at-TCP-level-in-a-timely-fashio.patch"

RnJvbSBmZjY3NmI0NjlmYmExNzIyN2RmN2NiNmE4OGQzNjUyZjZjNGZjMDYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBQLiBHcmFoYW0gPFNpbW9uLkdyYWhhbUBzdHJhdHVz
LmNvbT4KRGF0ZTogTW9uLCAxMSBBdWcgMjAwOCAxMDoyNzowOCAtMDQwMApTdWJqZWN0OiBbUEFU
Q0hdIEVuc3VyZSBkYXRhIGlzIEFDSydkIGF0IFRDUCBsZXZlbCBpbiBhIHRpbWVseSBmYXNoaW9u
LgoKLS0tCiBkcmJkL2RyYmRfaW50LmggICAgICB8ICAgIDYgKysrKysrCiBkcmJkL2RyYmRfcmVj
ZWl2ZXIuYyB8ICAgIDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcmJkL2RyYmRfaW50LmggYi9kcmJkL2RyYmRfaW50
LmgKaW5kZXggNTc2YzcyYy4uNjhjNTQyNyAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX2ludC5oCisr
KyBiL2RyYmQvZHJiZF9pbnQuaApAQCAtMTUyMiw2ICsxNTIyLDEyIEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBkcmJkX3RjcF9mbHVzaChzdHJ1Y3Qgc29ja2V0ICpzb2NrKQogCXRjcF9zZXRzb2Nrb3B0
KHNvY2stPnNrLCBTT0xfVENQLCBUQ1BfQ09SSywgKGNoYXIgX191c2VyICopJnZhbCwgc2l6ZW9m
KHZhbCkgKTsKIH0KIAorc3RhdGljIGlubGluZSB2b2lkIGRyYmRfdGNwX3F1aWNrYWNrKHN0cnVj
dCBzb2NrZXQgKnNvY2spCit7CisJaW50IHZhbCA9IDE7CisJdGNwX3NldHNvY2tvcHQoc29jay0+
c2ssIFNPTF9UQ1AsIFRDUF9RVUlDS0FDSywgKGNoYXIqKSZ2YWwsIHNpemVvZih2YWwpICk7Cit9
CisKIC8qIGRyYmRfcHJvYy5jICovCiBleHRlcm4gc3RydWN0IHByb2NfZGlyX2VudHJ5ICpkcmJk
X3Byb2M7CiBleHRlcm4gc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBkcmJkX3Byb2NfZm9wczsKZGlm
ZiAtLWdpdCBhL2RyYmQvZHJiZF9yZWNlaXZlci5jIGIvZHJiZC9kcmJkX3JlY2VpdmVyLmMKaW5k
ZXggNzFlNzYwMS4uYzYxOWM3YSAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX3JlY2VpdmVyLmMKKysr
IGIvZHJiZC9kcmJkX3JlY2VpdmVyLmMKQEAgLTI3MzgsNiArMjczOCw5IEBAIFNUQVRJQyBpbnQg
cmVjZWl2ZV9VbnBsdWdSZW1vdGUoc3RydWN0IGRyYmRfY29uZiAqbWRldiwgc3RydWN0IERyYmRf
SGVhZGVyICpoKQogewogCWlmIChtZGV2LT5zdGF0ZS5kaXNrID49IEluY29uc2lzdGVudCkKIAkJ
ZHJiZF9raWNrX2xvKG1kZXYpOworCS8qIE1ha2Ugc3VyZSB3ZSd2ZSBhY2tlZCBhbGwgdGhlIFRD
UCBkYXRhIGFzc29jaWF0ZWQKKwkgICB3aXRoIHRoZSBkYXRhIHJlcXVlc3RzIGJlaW5nIHVucGx1
Z2dlZCAqLworCWRyYmRfdGNwX3F1aWNrYWNrKG1kZXYtPmRhdGEuc29ja2V0KTsKIAlyZXR1cm4g
VFJVRTsgLyogY2Fubm90IGZhaWwuICovCiB9CiAKLS0gCjEuNS40LnJjMQoK

------_=_NextPart_001_01C8FC98.E816CAE7--
