Return-Path: <pallair78@gmail.com>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
	[209.85.215.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9DA29105057A
	for <drbd-dev@lists.linbit.com>; Fri, 21 Dec 2012 21:21:27 +0100 (CET)
Received: by mail-la0-f42.google.com with SMTP id s15so5809608lag.15
	for <drbd-dev@lists.linbit.com>; Fri, 21 Dec 2012 12:21:26 -0800 (PST)
MIME-Version: 1.0
Sender: pallair78@gmail.com
In-Reply-To: <CALj=1wh+JA2m9nuhtS_+eyuvvK9GBaY+W2RYc71YPaxh1+PUhw@mail.gmail.com>
References: <CALj=1wh+JA2m9nuhtS_+eyuvvK9GBaY+W2RYc71YPaxh1+PUhw@mail.gmail.com>
Message-ID: <CALj=1whe16wjWO=DFgqPRz=uwxKQTnSOVNq=FM8RymF1aALVow@mail.gmail.com>
From: Pallai Roland <dap@magex.hu>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary=f46d042c6aed8645b504d1629712
Subject: [Drbd-dev] /usr/lib/drbd/crm-unfence-peer.sh: fencing rule leak?
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
Date: Fri, 21 Dec 2012 20:21:28 -0000

--f46d042c6aed8645b504d1629712
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have 3 remote sites in a Pacemaker cluster with quorum, 2 sites has
DRBD nodes (active-passive). There's one common communication path for
Corosync and DRBD. One site is preferred as primary. When the primary
node gets unclean shutdown, other site promoted as primary as
expected.
When the failed node reboots, it starts- and *immediately* promotes
DRBD as expected. Promoting may done before DRBD even connects so it
goes online with stale data sometimes - I'm using resource fencing
scripts to prevent this behavior.

Unfortunately there's a problem triggered by short network blackouts:
the unfencing script leaks random fencing rules that can prevent
failover on real outages later. I have a "high" token timeout in
corosync.conf (180s), thoose short blackouts are not detected by
Pacemaker at all.

Based on logs I tried to reconstruct what happens:

* nodeP: the preferred node
* nodeS: the secondary node (currently is the Pacemaker DC)
* nodeX: the quorum site (there are the clients)

1. network outage; nodeP and nodeX has the quorum
2. detected by both DRBD soon (PingAck timeout)
=> Case I:
3. nodeP: DRBD fence-peer script called and *finished* successfully
4. network restored
5. DRBD communication restored, Sync finished almost immediately
6. nodeS: crm-unfence-peer.sh called; $have_constraint in
drbd_peer_fencing() is false, so does nothing and exit [1]
7. nodeS: CIB gets replicated, the fencing rule appears in local CIB
=> Case II:
3. nodeP: DRBD fence-peer script called and *blocked* somewhere
4. network restored
5. DRBD communication restored, Sync finished almost immediately
6. nodeS: crm-unfence-peer.sh called; $have_constraint in
drbd_peer_fencing() is false, so does nothing and exit [1]
7. nodeP: crm-fence-peer.sh finished
8. nodeS: the fencing rule appears in local CIB

[1] http://git.drbd.org/gitweb.cgi?p=drbd-8.3.git;a=blob;f=scripts/crm-fence-peer.sh;h=dc776a3d1b7f313bcd315bef3029e841de7646cb;hb=HEAD#l298

Case II. only can happen when outage is short (< $dc_timeout), case I.
even when outage is longer but there are just a few bytes to Sync -
otherwise the cluster have time to "finalize" the local CIB.

Actually this is a race between the communication paths of DRBD and
Pacemaker so can be solved by separate the paths. Unfortunately I have
no possibility for that, this is a low cost SOHO project. Another
solution could be to call the unfence script on the primary node, but
drbd.conf's handlers does not support this AFAIK.
So I made a patch for /usr/lib/drbd/crm-unfence-peer.sh that fixed the
problem (attached), but I'm not sure if this is a proper solution,
please share your opinion.

The fencing is used only to prevent split-brain after unclean reboot
of the preferred node - if there's another solution for this, I can
drop resource fencing without drawbacks in this setup.

I'm using version 8.3.7 with Debian Squeeze.
(Or is it a drbd-user@ question..?)

--f46d042c6aed8645b504d1629712
Content-Type: application/octet-stream;
	name="crm-unfence-peer-wait_for_queued_request.diff"
Content-Disposition: attachment;
	filename="crm-unfence-peer-wait_for_queued_request.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hazr2mn31

LS0tIC91c3IvbGliL2RyYmQvY3JtLWZlbmNlLXBlZXIuc2h+CTIwMTItMTItMjEgMTg6MjI6MjUu
Njc0ODM5OTY1ICswMTAwDQorKysgL3Vzci9saWIvZHJiZC9jcm0tZmVuY2UtcGVlci5zaAkyMDEy
LTEyLTIxIDIxOjA2OjI2LjQ1MTMzOTMxMyArMDEwMA0KQEAgLTE5MCwxMSArMTkwLDEyIEBADQog
DQogCSMgaWYgSSBjYW5ub3QgcXVlcnkgdGhlIGxvY2FsIGNpYiwgZ2l2ZSB1cA0KIAlsb2NhbCBj
aWJfeG1sDQotCWNpYl94bWw9JChjaWJhZG1pbiAtUWwpIHx8IHJldHVybg0KLQlmZW5jZV9wZWVy
X2luaXQgfHwgcmV0dXJuDQogDQogCWNhc2UgJDEgaW4NCiAJZmVuY2UpDQorCQljaWJfeG1sPSQo
Y2liYWRtaW4gLVFsKSB8fCByZXR1cm4NCisJCWZlbmNlX3BlZXJfaW5pdCB8fCByZXR1cm4NCisN
CiAJCWlmIFtbICRmZW5jaW5nX2F0dHJpYnV0ZSA9ICIjdW5hbWUiIF1dOyB0aGVuDQogCQkJZmVu
Y2luZ192YWx1ZT0kSE9TVE5BTUUNCiAJCWVsaWYgISBmZW5jaW5nX3ZhbHVlPSQoY3JtX2F0dHJp
YnV0ZSAtUSAtdCBub2RlcyAtbiAkZmVuY2luZ19hdHRyaWJ1dGUgMj4vZGV2L251bGwpOyB0aGVu
DQpAQCAtMjYwLDEyICsyNjEsMzggQEANCiAJCXJldHVybiAkcmMNCiAJCTs7DQogCXVuZmVuY2Up
DQotCQlpZiBbWyAtbiAkaGF2ZV9jb25zdHJhaW50IF1dOyB0aGVuDQotCQkJIyByZW1vdmUgaXQg
YmFzZWQgb24gdGhhdCBpZA0KLQkJCWNpYmFkbWluIC1EIC1YICI8cnNjX2xvY2F0aW9uIHJzYz1c
IiRtYXN0ZXJfaWRcIiBpZD1cIiRpZF9wcmVmaXgtJG1hc3Rlcl9pZFwiLz4iDQotCQllbHNlDQot
CQkJcmV0dXJuIDANCi0JCWZpDQorCQl0cmllcz0wDQorCQl3aGlsZSA6OyBkbw0KKwkJCWNpYl94
bWw9JChjaWJhZG1pbiAtUWwpIHx8IHJldHVybg0KKwkJCWZlbmNlX3BlZXJfaW5pdCB8fCByZXR1
cm4NCisNCisJCQlpZiBbWyAtbiAkaGF2ZV9jb25zdHJhaW50IF1dOyB0aGVuDQorCQkJCWlmICgo
ICR0cmllcyA+IDAgKSkgOyB0aGVuDQorCQkJCQllY2hvIERFQlVHICJUaGVyZSB3YXMgcGVuZGlu
ZyBmZW5jaW5nIHJlcXVlc3QsIGZvdW5kIGFmdGVyICR7U0VDT05EU31zIg0KKwkJCQlmaQ0KKwkJ
CQkjIHJlbW92ZSBpdCBiYXNlZCBvbiB0aGF0IGlkDQorCQkJCWNpYmFkbWluIC1EIC1YICI8cnNj
X2xvY2F0aW9uIHJzYz1cIiRtYXN0ZXJfaWRcIiBpZD1cIiRpZF9wcmVmaXgtJG1hc3Rlcl9pZFwi
Lz4iDQorCQkJCWJyZWFrDQorCQkJZWxzZQ0KKwkJCQkjIE1ha2Ugc3VyZSB0aGUgZmVuY2luZyBy
ZXF1ZXN0IGFscmVhZHkgc29ydGVkIG91dDsNCisJCQkJIyAtIG9uIHNob3J0IG5ldHdvcmsgYmxh
Y2tvdXRzIChsZXNzIHRoYW4gJGRjX3RpbWVvdXQpIHRoZXJlIGNhbiBiZSBwZW5kaW5nIGZlbmNp
bmcNCisJCQkJIyByZXF1ZXN0cyBibG9ja2VkIGluIGNoZWNrX3BlZXJfbm9kZV9yZWFjaGFibGUo
KS4NCisJCQkJIyAtIG9uIGxvbmdlciBuZXR3b3JrIGJsYWNrb3V0cyBwZW5kaW5nIGZlbmNpbmcg
cmVxdWVzdHMgbWF5IGJlICJxdWV1ZWQiIGF0IERDJ3MgQ0lCLg0KKwkJCQkjIFdlIG11c3QgZ2l2
ZSB0aW1lIGZvciB0aGUgY2x1c3RlciB0byByZWZyZXNoIHRoZSBsb2NhbCBDSUIuDQorCQkJCSMg
VE9ETyBUaGlzIGxhdGVzdCBpc3N1ZSBtYXkgYmUgc29sdmVkIGJ5ICdjaWJhZG1pbiAtUSc/DQor
CQkJCSMNCisJCQkJIyBXZSBtdXN0IHNvcnQgb3V0IGFsbCBvZiB0aGVtIGJlZm9yZSB1bmZlbmNp
bmcuDQorCQkJCSMgVGhpcyBpc24ndCBhbiBpc3N1ZSBpZiB5b3UndmUgc2VwYXJhdGVkIGNvbW11
bmljYXRpb24gcGF0aHMgZm9yIGNsdXN0ZXIgJiBEUkJELg0KKw0KKwkJCQkjIGJhc2ggbWFnaWMg
JFNFQ09ORFMgaXMgc2Vjb25kcyBzaW5jZSBzaGVsbCBpbnZvY2F0aW9uLg0KKwkJCQlpZiAoKCAk
U0VDT05EUyA+ICRkY190aW1lb3V0ICsgMSApKSA7IHRoZW4NCisJCQkJCSMgTm93IGl0IGlzIHN1
cmU6IHRoZXJlIGlzIG5vIGFuZCB3YXMgbm90IHBlbmRpbmcgZmVuY2luZyByZXF1ZXN0DQorCQkJ
CQlyZXR1cm4gMA0KKwkJCQlmaQ0KKwkJCQlzbGVlcCAyDQorCQkJZmkNCisJCQl0cmllcz0kKCh0
cmllcyArIDEpKQ0KKwkJZG9uZQ0KIAllc2FjDQogfQ0KIA0K
--f46d042c6aed8645b504d1629712--
