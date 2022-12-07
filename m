Return-Path: <chaitanyak@nvidia.com>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
	(mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3D89442177D
	for <drbd-dev@lists.linbit.com>; Thu,  8 Dec 2022 01:48:52 +0100 (CET)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, Gulam Mohamed <gulam.mohamed@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date: Wed, 7 Dec 2022 23:17:12 +0000
Message-ID: <09be5cbe-9251-d28c-e91a-3f2e5e9e99f2@nvidia.com>
References: <20221207223204.22459-1-gulam.mohamed@oracle.com>
	<abaa2003-4ddf-5ef9-d62c-1708a214609d@kernel.dk>
In-Reply-To: <abaa2003-4ddf-5ef9-d62c-1708a214609d@kernel.dk>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <49B6173FD1ADDA4BAB931DDA7410A344@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"song@kernel.org" <song@kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"joe.jin@oracle.com" <joe.jin@oracle.com>,
	"kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
	"ngupta@vflare.org" <ngupta@vflare.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"colyli@suse.de" <colyli@suse.de>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"junxiao.bi@oracle.com" <junxiao.bi@oracle.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
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

T24gMTIvNy8yMiAxNTowOCwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gMTIvNy8yMiAzOjMyP1BN
LCBHdWxhbSBNb2hhbWVkIHdyb3RlOg0KPj4gQXMgcGVyIHRoZSByZXZpZXcgY29tbWVudCBmcm9t
IEplbnMgQXhib2UsIEkgYW0gcmUtc2VuZGluZyB0aGlzIHBhdGNoDQo+PiBhZ2FpbnN0ICJmb3It
Ni4yL2Jsb2NrIi4NCj4+DQo+Pg0KPj4gVXNlIGt0aW1lIHRvIGNoYW5nZSB0aGUgZ3JhbnVsYXJp
dHkgb2YgSU8gYWNjb3VudGluZyBpbiBibG9jayBsYXllciBmcm9tDQo+PiBtaWxsaS1zZWNvbmRz
IHRvIG5hbm8tc2Vjb25kcyB0byBnZXQgdGhlIHByb3BlciBsYXRlbmN5IHZhbHVlcyBmb3IgdGhl
DQo+PiBkZXZpY2VzIHdob3NlIGxhdGVuY3kgaXMgaW4gbWljcm8tc2Vjb25kcy4gQWZ0ZXIgY2hh
bmdpbmcgdGhlIGdyYW51bGFyaXR5DQo+PiB0byBuYW5vLXNlY29uZHMgdGhlIGlvc3RhdCBjb21t
YW5kLCB3aGljaCB3YXMgc2hvd2luZyBpbmNvcnJlY3QgdmFsdWVzIGZvcg0KPj4gJXV0aWwsIGlz
IG5vdyBzaG93aW5nIGNvcnJlY3QgdmFsdWVzLg0KPj4NCj4+IFdlIGRpZCBub3Qgd29yayBvbiB0
aGUgcGF0Y2ggdG8gZHJvcCB0aGUgbG9naWMgZm9yDQo+PiBTVEFUX1BSRUNJU0VfVElNRVNUQU1Q
UyB5ZXQuIFdpbGwgZG8gaXQgaWYgdGhpcyBwYXRjaCBpcyBvay4NCj4+DQo+PiBUaGUgaW9zdGF0
IGNvbW1hbmQgd2FzIHJ1biBhZnRlciBzdGFydGluZyB0aGUgZmlvIHdpdGggZm9sbG93aW5nIGNv
bW1hbmQNCj4+IG9uIGFuIE5WTUUgZGlzay4gRm9yIHRoZSBzYW1lIGZpbyBjb21tYW5kLCB0aGUg
aW9zdGF0ICV1dGlsIHdhcyBzaG93aW5nDQo+PiB+MTAwJSBmb3IgdGhlIGRpc2tzIHdob3NlIGxh
dGVuY2llcyBhcmUgaW4gdGhlIHJhbmdlIG9mIG1pY3Jvc2Vjb25kcy4NCj4+IFdpdGggdGhlIGtl
cm5lbCBjaGFuZ2VzIChncmFudWxhcml0eSB0byBuYW5vLXNlY29uZHMpLCB0aGUgJXV0aWwgd2Fz
DQo+PiBzaG93aW5nIGNvcnJlY3QgdmFsdWVzLiBGb2xsb3dpbmcgYXJlIHRoZSBkZXRhaWxzIG9m
IHRoZSB0ZXN0IGFuZCB0aGVpcg0KPj4gb3V0cHV0Og0KPiANCj4gTXkgZGVmYXVsdCBwZWFrIHRl
c3RpbmcgcnVucyBhdCAxMjJNIElPUFMuIFRoYXQncyBhbHNvIHRoZSBwZWFrIElPUFMgb2YNCj4g
dGhlIGRldmljZXMgY29tYmluZWQsIGFuZCB3aXRoIGlvc3RhdHMgZGlzYWJsZWQuIElmIEkgZW5h
YmxlZCBpb3N0YXRzLA0KPiB0aGVuIHRoZSBwZXJmb3JtYW5jZSBkcm9wcyB0byAxMTJNIElPUFMu
IEl0J3Mgbm8gbG9uZ2VyIGRldmljZSBsaW1pdGVkLA0KPiB0aGF0J3MgYSBkcm9wIG9mIGFib3V0
IDguMiUuDQo+IA0KDQpXb3csIGNsZWFybHkgbm90IGFjY2VwdGFibGUgdGhhdCdzIGV4YWN0bHkg
SSBhc2tlZCBmb3IgcGVyZg0KbnVtYmVycyA6KS4NCg0KLWNrDQoNCg==
