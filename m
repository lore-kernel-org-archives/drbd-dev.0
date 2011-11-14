Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 14 Nov 2011 11:56:45 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: The Pacemaker cluster resource manager <pacemaker@oss.clusterlabs.org>,
	drbd-dev@lists.linbit.com
Message-ID: <20111114105645.GE11469@barkeeper1-xen.linbit>
References: <4EBF8022.6020202@hastexo.com>
	<CAEDLWG14f=WRw+NQ8gtVAd=Vs0QRgpZxxbxnE06MttCQ5iLGGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEDLWG14f=WRw+NQ8gtVAd=Vs0QRgpZxxbxnE06MttCQ5iLGGg@mail.gmail.com>
Subject: Re: [Drbd-dev] [Pacemaker] crm_attribute --quiet (was Fwd:
 [Linux-HA] Should This Worry Me?)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 14, 2011 at 09:51:46AM +1100, Andrew Beekhof wrote:
> > confused as to what the correct flag actually is. ocf:linbit:drbd (in
> > both 8.3 and 8.4) uses "-Q" whereas Pacemaker expects "-q" as of this
> > commit:
> >
> > commit c11ce5e9b0b13ead02b5fc4add928d7e7f95092e
> > Author: Andrew Beekhof <andrew@beekhof.net>
> > Date:   Tue Sep 22 17:29:38 2009 +0200
> >
> >    Medium: Tools: Use -q as the short form for --quiet (for consistency)
> >
> >    Mercurial revision: 7289e661e4923beee4b7b45bc85592564ccdc438
> >
> > Should ocf:linbit:drbd be using "-q"?
> 
> Correct.  Sorry about that.


-Q is still accepted, though.
As it is accepted for a larger range of crm_attribute versions,
I'll keep it for now.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
