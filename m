Return-Path: <lmb@suse.de>
Date: Thu, 27 Jan 2005 10:16:55 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch] __bio_clone() behaviour
Message-ID: <20050127091655.GI5511@marowsky-bree.de>
References: <20050126164612.GH5511@marowsky-bree.de>
	<200501270956.16709.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501270956.16709.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-01-27T09:56:16, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> This really gives me the feeling that I should not have done the 
> 0.7.9 release. --- The only one to blame is myself, who thought it 
> would be a nice idea to have the same release as SUSE.
> Bullshit -> The next release will only happen when I am convinced
> that the new release is necessary, and that it will not be a 
> disaster.

Yeah, that's probably a good idea. We're used to releasing patched
versions anyway ;-)

(The 0.7.9 we had picked up had to have it's version number (and only
the version number) patched back to 0.7.5; can't update the version
number in a released product, even if the rest of the code is the same.
That's political games for you. *sigh*)

> BTW, regarind this patch: We now modify someone else's BIO. 
>      Is this a good idea ?

Well, quite frankly, it is not entirely a good idea. However, it's as
sane as the other stuff drbd does with bios. It doesn't have any other
side effect beyond making the __bio_clone() call not misbehave.

The bi_max_vecs doesn't have any other uses in that scenario and it's
safe, but not sane ;-)

I checked with axboe and grepped the kernel source, and it's the best
work around we can do right now short of converting drbd to use the
"proper" APIs. Jens thinks the __bio_clone() call probably should be
unexported; the "real" API (bio_clone()) would have automatically done
the right thing, and in fact drbd seems to be the _only_ user of
__bio_clone() anywhere. Everyone else goes via bio_alloc(), bio_clone(),
bio_get/_put() et cetera.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

