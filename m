Return-Path: <lmb@suse.de>
Date: Mon, 26 Sep 2005 12:22:43 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] Re: [DRBD-user] Retrieving the inconsistent + local
	disk state
Message-ID: <20050926102243.GA25748@marowsky-bree.de>
References: <20050922132016.GE5593@marowsky-bree.de>
	<200509221524.22929.philipp.reisner@linbit.com>
	<20050923131614.GD25085@marowsky-bree.de>
	<200509261139.55473.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200509261139.55473.philipp.reisner@linbit.com>
Cc: drbd-user@linbit.com, drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-09-26T11:39:54, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> > BTW, an almost complete draft looks something like
> > http://cvs.linux-ha.org/viewcvs/viewcvs.cgi/linux-ha/resources/OCF/drbd.in?
> >rev=HEAD&view=markup
> >
> Hmm, ok I think I have a vague idea, what this is about. I will implement
> a kind of "dstate" command... It will be ready at the time of Linux-Kongress.
> 
> DRBD v8 only of course.

Sounds good, I'm fine with 0.8 - however in that case I'll also need to
extend the script for handling several masters/primaries. Maybe I should
write it so that it'll work with both 0.7 as well as 0.8 (with slightly
better features, of course).

drbd 0.8 also has the "mark-as-outdated" command for the secondary,
right?

> Will you be at the Kongress in Hamburg ? 

Yes, I will, and I hope I can get Xen going on my laptop until then so I
can test drbd on the spot ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

