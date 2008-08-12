Return-Path: <ciprich@linuxbox.cz>
Date: Tue, 12 Aug 2008 11:58:17 +0200
From: Nikola Ciprich <extmaillist@linuxbox.cz>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] too small timeout in drbdsetup
Message-ID: <20080812095817.GA31031@develbox.linuxbox.cz>
References: <87hcastmig.87fxqctmig@87ej5wtmig.message.id>
	<87y73cochw.87wsiwochw@87vdygochw.message.id>
	<200808051335.15444.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200808051335.15444.philipp.reisner@linbit.com>
Cc: nikola.ciprich@linuxbox.cz, drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Phillip,
we are experiencing this problem as well (also multiple DRBD devices operated
by heartbeat), so I also vote for either increasing timeout value, or making it optional :-)
thanks a lot!
nik

On Tue, Aug 05, 2008 at 01:35:15PM +0200, Philipp Reisner wrote:
> Am Montag, 4. August 2008 20:37:00 schrieb syrius.ml@no-log.org:
> > syrius.ml@no-log.org writes:
> > > Hi,
> > >
> > > as previously reported here
> > > http://thread.gmane.org/gmane.linux.kernel.drbd.devel/330 I also get
> > > the error message.
> > >
> > > looking at
> > > http://git.drbd.org/?p=drbd-8.0.git;a=blob;f=user/drbdsetup.c;h=0bca7c1c7
> > >73bcbd1c2ed6781062396ed15e77e9c;hb=HEAD#l1919 and
> > > http://git.drbd.org/?p=drbd-8.2.git;a=blob;f=user/drbdsetup.c;h=3868f1a18
> > >f4cda80cad5b0b05aa6f2348755dedd;hb=HEAD
> > >
> > > it seems the timeout is still too low (at least for me)
> > >
> > > I've fixed my problem by increasing the timeout to 5s.
> > >
> > > to reproduce the bug i was doing several drbdsetup disk one after the
> > > other in a script.
> > >
> > > (in fact the bug was first triggered by heartbeat drbd ocf script)
> > >
> > > Was do you thing would be the best change to make ?
> > > increase the timeout ?
> > > why not using NL_TIME (12000) as other drbd_calls ?
> >
> > Sorry to insist, 8.0.13 is on its way and you haven't answered about
> > this subject.
> > A lot of people have to make the change by hand and recompile,
> > distributions might add their own patch before releasing. Anyway what
> > do you think about this ?
> >
> 
> Hi,
> 
> You have an issue with that 500ms in that function, right ?
> 
> void ensure_drbd_driver_is_present(void)
> {
> 	struct drbd_tag_list *tl;
> 	char buffer[4096];
> 	int sk_nl, rr;
> 
> 	sk_nl = open_cn();
> 	/* Might print:
> 	   Missing privileges? You should run this as root.
> 	   Connector module not loaded? try 'modprobe cn'. */
> 	if (sk_nl < 0) exit(20);
> 
> 	tl = create_tag_list(2);
> 	add_tag(tl, TT_END, NULL, 0); // close the tag list
> 
> 	tl->drbd_p_header->packet_type = P_get_state;
> 	tl->drbd_p_header->drbd_minor = 0;
> 	tl->drbd_p_header->flags = 0;
> 
> 	rr = call_drbd(sk_nl, tl, (struct nlmsghdr*)buffer, 4096, 500);
> 	/* Might print: (after 500ms)
> 	   No response from the DRBD driver! Is the module loaded? */
> 	close_cn(sk_nl);
> 	if (rr == -2) exit(20);
> }
> 
> We do not experience any issue with the 500ms in our setups, as are reports
> about such an issue rather rare. Could you give a more details description
> about the conditions you trigger can trigger this ?
> 
> I guess we will add an option to drbdsetup then, and have it is setting
> in the globals section of drbd.conf. 
> 
> I do not want to inrecase it for all users, since is seems to affect only
> a very small part of our user base.
> 
> -Phil
> -- 
> : Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
> : LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
> : Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
> 

-- 
-------------------------------------
Nikola CIPRICH
LinuxBox.cz, s.r.o.
28. rijna 168, 709 01 Ostrava

tel.:   +420 596 603 142
fax:    +420 596 621 273
mobil:  +420 777 093 799
www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------
