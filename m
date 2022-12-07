Return-Path: <chaitanyak@nvidia.com>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 566D042096D
	for <drbd-dev@lists.linbit.com>; Thu,  8 Dec 2022 01:36:40 +0100 (CET)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Date: Wed, 7 Dec 2022 23:02:38 +0000
Message-ID: <7a658866-c7b8-00de-ab82-4b8212cb2603@nvidia.com>
References: <20221207223204.22459-1-gulam.mohamed@oracle.com>
In-Reply-To: <20221207223204.22459-1-gulam.mohamed@oracle.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <80992709039F884A97659819F8B9D6A9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"song@kernel.org" <song@kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"joe.jin@oracle.com" <joe.jin@oracle.com>,
	"kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
	"ngupta@vflare.org" <ngupta@vflare.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"colyli@suse.de" <colyli@suse.de>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"junxiao.bi@oracle.com" <junxiao.bi@oracle.com>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>
Subject: Re: [Drbd-dev] [RFC for-6.2/block V2] block: Change the granularity
 of io ticks from ms to ns
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

T24gMTIvNy8yMiAxNDozMiwgR3VsYW0gTW9oYW1lZCB3cm90ZToNCj4gQXMgcGVyIHRoZSByZXZp
ZXcgY29tbWVudCBmcm9tIEplbnMgQXhib2UsIEkgYW0gcmUtc2VuZGluZyB0aGlzIHBhdGNoDQo+
IGFnYWluc3QgImZvci02LjIvYmxvY2siLg0KPiANCg0Kd2h5IGlzIHRoaXMgbWFya2VkIGFzIFJG
QyA/IGFyZSB5b3Ugd2FpdGluZyBmb3Igc29tZXRoaW5nIG1vcmUgdG8gZ2V0DQpyZXNvbHZlZCBz
byB0aGlzIGNhbiBiZSBtZXJnZWQgPw0KDQo+IA0KPiBVc2Uga3RpbWUgdG8gY2hhbmdlIHRoZSBn
cmFudWxhcml0eSBvZiBJTyBhY2NvdW50aW5nIGluIGJsb2NrIGxheWVyIGZyb20NCj4gbWlsbGkt
c2Vjb25kcyB0byBuYW5vLXNlY29uZHMgdG8gZ2V0IHRoZSBwcm9wZXIgbGF0ZW5jeSB2YWx1ZXMg
Zm9yIHRoZQ0KPiBkZXZpY2VzIHdob3NlIGxhdGVuY3kgaXMgaW4gbWljcm8tc2Vjb25kcy4gQWZ0
ZXIgY2hhbmdpbmcgdGhlIGdyYW51bGFyaXR5DQo+IHRvIG5hbm8tc2Vjb25kcyB0aGUgaW9zdGF0
IGNvbW1hbmQsIHdoaWNoIHdhcyBzaG93aW5nIGluY29ycmVjdCB2YWx1ZXMgZm9yDQo+ICV1dGls
LCBpcyBub3cgc2hvd2luZyBjb3JyZWN0IHZhbHVlcy4NCj4gDQo+IFdlIGRpZCBub3Qgd29yayBv
biB0aGUgcGF0Y2ggdG8gZHJvcCB0aGUgbG9naWMgZm9yDQo+IFNUQVRfUFJFQ0lTRV9USU1FU1RB
TVBTIHlldC4gV2lsbCBkbyBpdCBpZiB0aGlzIHBhdGNoIGlzIG9rLg0KPiANCj4gVGhlIGlvc3Rh
dCBjb21tYW5kIHdhcyBydW4gYWZ0ZXIgc3RhcnRpbmcgdGhlIGZpbyB3aXRoIGZvbGxvd2luZyBj
b21tYW5kDQo+IG9uIGFuIE5WTUUgZGlzay4gRm9yIHRoZSBzYW1lIGZpbyBjb21tYW5kLCB0aGUg
aW9zdGF0ICV1dGlsIHdhcyBzaG93aW5nDQo+IH4xMDAlIGZvciB0aGUgZGlza3Mgd2hvc2UgbGF0
ZW5jaWVzIGFyZSBpbiB0aGUgcmFuZ2Ugb2YgbWljcm9zZWNvbmRzLg0KPiBXaXRoIHRoZSBrZXJu
ZWwgY2hhbmdlcyAoZ3JhbnVsYXJpdHkgdG8gbmFuby1zZWNvbmRzKSwgdGhlICV1dGlsIHdhcw0K
PiBzaG93aW5nIGNvcnJlY3QgdmFsdWVzLiBGb2xsb3dpbmcgYXJlIHRoZSBkZXRhaWxzIG9mIHRo
ZSB0ZXN0IGFuZCB0aGVpcg0KPiBvdXRwdXQ6DQo+IA0KPiBmaW8gY29tbWFuZA0KPiAtLS0tLS0t
LS0tLQ0KPiBbZ2xvYmFsXQ0KPiBicz0xMjhLDQo+IGlvZGVwdGg9MQ0KPiBkaXJlY3Q9MQ0KPiBp
b2VuZ2luZT1saWJhaW8NCj4gZ3JvdXBfcmVwb3J0aW5nDQo+IHRpbWVfYmFzZWQNCj4gcnVudGlt
ZT05MA0KPiB0aGlua3RpbWU9MW1zDQo+IG51bWpvYnM9MQ0KPiBuYW1lPXJhdy13cml0ZQ0KPiBy
dz1yYW5kcncNCj4gaWdub3JlX2Vycm9yPUVJTzpFSU8NCj4gW2pvYjFdDQo+IGZpbGVuYW1lPS9k
ZXYvbnZtZTBuMQ0KPiANCj4gQ29ycmVjdCB2YWx1ZXMgYWZ0ZXIga2VybmVsIGNoYW5nZXM6DQo+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBpb3N0YXQgb3V0cHV0DQo+
IC0tLS0tLS0tLS0tLS0NCj4gaW9zdGF0IC1kIC9kZXYvbnZtZTBuMSAteCAxDQo+IA0KPiBEZXZp
Y2UgICAgICAgICAgICByX2F3YWl0IHdfYXdhaXQgYXF1LXN6IHJhcmVxLXN6IHdhcmVxLXN6ICBz
dmN0bSAgJXV0aWwNCj4gbnZtZTBuMSAgICAgICAgICAgICAgMC4wOCAgICAwLjA1ICAgMC4wNiAg
IDEyOC4wMCAgIDEyOC4wMCAgIDAuMDcgICA2LjUwDQo+IA0KPiBEZXZpY2UgICAgICAgICAgICBy
X2F3YWl0IHdfYXdhaXQgYXF1LXN6IHJhcmVxLXN6IHdhcmVxLXN6ICBzdmN0bSAgJXV0aWwNCj4g
bnZtZTBuMSAgICAgICAgICAgICAgMC4wOCAgICAwLjA2ICAgMC4wNiAgIDEyOC4wMCAgIDEyOC4w
MCAgIDAuMDcgICA2LjMwDQo+IA0KPiBEZXZpY2UgICAgICAgICAgICByX2F3YWl0IHdfYXdhaXQg
YXF1LXN6IHJhcmVxLXN6IHdhcmVxLXN6ICBzdmN0bSAgJXV0aWwNCj4gbnZtZTBuMSAgICAgICAg
ICAgICAgMC4wNiAgICAwLjA1ICAgMC4wNiAgIDEyOC4wMCAgIDEyOC4wMCAgIDAuMDYgICA1Ljcw
DQo+IA0KPiAgRnJvbSBmaW8NCj4gLS0tLS0tLS0NCj4gUmVhZCBMYXRlbmN5OiBjbGF0ICh1c2Vj
KTogbWluPTMyLCBtYXg9MjMzNSwgYXZnPTc5LjU0LCBzdGRldj0yOS45NQ0KPiBXcml0ZSBMYXRl
bmN5OiBjbGF0ICh1c2VjKTogbWluPTM4LCBtYXg9MTMwLCBhdmc9NTcuNzYsIHN0ZGV2PSAzLjI1
DQo+IA0KPiBWYWx1ZXMgYmVmb3JlIGtlcm5lbCBjaGFuZ2VzDQo+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCj4gaW9zdGF0IG91dHB1dA0KPiAtLS0tLS0tLS0tLS0tDQo+IA0KPiBpb3N0
YXQgLWQgL2Rldi9udm1lMG4xIC14IDENCj4gDQo+IERldmljZSAgICAgICAgICAgIHJfYXdhaXQg
d19hd2FpdCBhcXUtc3ogcmFyZXEtc3ogd2FyZXEtc3ogIHN2Y3RtICAldXRpbA0KPiBudm1lMG4x
ICAgICAgICAgICAgICAwLjA4ICAgIDAuMDYgICAwLjA2ICAgMTI4LjAwICAgMTI4LjAwICAgMS4w
NyAgOTcuNzANCj4gDQo+IERldmljZSAgICAgICAgICAgIHJfYXdhaXQgd19hd2FpdCBhcXUtc3og
cmFyZXEtc3ogd2FyZXEtc3ogIHN2Y3RtICAldXRpbA0KPiBudm1lMG4xICAgICAgICAgICAgICAw
LjA4ICAgIDAuMDYgICAwLjA2ICAgMTI4LjAwICAgMTI4LjAwICAgMS4wOCAgOTguODANCj4gDQo+
IERldmljZSAgICAgICAgICAgIHJfYXdhaXQgd19hd2FpdCBhcXUtc3ogcmFyZXEtc3ogd2FyZXEt
c3ogIHN2Y3RtICAldXRpbA0KPiBudm1lMG4xICAgICAgICAgICAgICAwLjA4ICAgIDAuMDUgICAw
LjA2ICAgMTI4LjAwICAgMTI4LjAwICAgMS4wNiAgOTcuMjANCj4gDQo+ICBGcm9tIGZpbw0KPiAt
LS0tLS0tLQ0KPiBSZWFkIExhdGVuY3k6IGNsYXQgKHVzZWMpOiBtaW49MzMsIG1heD00NjgsIGF2
Zz03OS41Niwgc3RkZXY9MjguMDQNCj4gV3JpdGUgTGF0ZW5jeTogY2xhdCAodXNlYyk6IG1pbj05
LCBtYXg9MTM5LCBhdmc9NTcuMTAsIHN0ZGV2PSAzLjc5DQo+IA0KPiBDaGFuZ2VzIGluIFYyOg0K
PiAxLiBDaGFuZ2VkIHRoZSB0cnlfY21weGNoZygpIHRvIHRyeV9jbXB4Y2hnNjQoKSBpbiBmdW5j
dGlvbg0KPiAgICAgdXBkYXRlX2lvX3RpY2tzKClhcyB0aGUgdmFsdWVzIGJlaW5nIGNvbXBhcmVk
IGFyZSB1NjQgd2hpY2ggd2FzIGdpdmluZw0KPiAgICAgYSBidWlsZCBlcnJvciBvbiBpMzg2IGFu
ZCBtaWNyb2JsYXplDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdWxhbSBNb2hhbWVkIDxndWxhbS5t
b2hhbWVkQG9yYWNsZS5jb20+DQo+IC0tLQ0KDQpJIGJlbGlldmUgaXQgaGFzIG5vIGVmZmVjdCBv
biB0aGUgb3ZlcmFsbCBwZXJmb3JtYW5jZSwgaWYgc28gSSdkDQpkb2N1bWVudCB0aGF0Lg0KDQpC
YXNlZCBvbiB0aGUgcXVhbnRpdGF0aXZlIGRhdGEgcHJlc2VudCBpbiB0aGUgY29tbWl0IGxvZyB0
aGlzDQpsb29rcyBnb29kIHRvIG1lLCBJIGJlbGlldmUgeW91IGRpZCBhdWRpdCBhbGwgZHJpdmVy
cyBhbmQgcGxhY2VzDQppbiB0aGUgYmxvY2sgbGF5ZXIuDQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg==
