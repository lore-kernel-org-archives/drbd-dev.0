Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8: <FOR REVIEW> dynamic tracing facility
Date: Tue, 26 Sep 2006 17:42:32 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671039D4C4D@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Philipp,

Just want to make sure I understand fully...

> I have two opinions about this:
>  * Good stuff, it is nice to have all this in place, although I would
>    also like to disable the whole tracing/dumping at compile time.
>=20
>  * On the other hand I am not sure if it could become obsolete by
>    the current rumours about a DTrace replacement on Linux
(SystemTrap)

I was not aware of DTrace but I have looked at SystemTap and decided it
doesn't really work -- we need some level of trace that is always turned
on (so we can diagnose field problems after the fact) combined with the
ability to enable more extensive tracing at will and I don't think
SystemTap will do both of these. To be honest I don't really like the
fact that the tracing definition is separate from the driver code
(probably the exact reason why other people like it=20
;-)

Also -- whilst there may be work afoot to add this to the kernel, we
need this now with the current kernel versions we are going to ship
product with - I know that printk's are perhaps not the best (especially
if you aren't careful about where to insert them) but they do provide
what is needed now.

>=20
> So, over all, I will accept a patch:
>  * That converts our current stuff over to such a tracing framework

Do you mean you want all the existing INFO/WARN/etc tracing to use this?

I did consider this but decided not to for a couple of reasons:
1. Lots of this trace should continue to always be printed -- I could
add
   an option to the framework that lets the caller specify 'always print
   this' but I'm not sure it adds value. However, I can see that there
is
   benefit in having ALL trace code wrapped in the new framework macros
  =20
2. I didn't want to include the overhead of testing trace types/levels
etc
   in every single place where a trace message is output - however, I
can=20
   certainly arrange for these to generate no code in the cases
   where the output should always be produced.

3. It would be a huge patch to change every single trace call in one go.

So, to be honest, I decided not to do this initially but just get a
framework
in place and then let you and Lars convert what you think needs it ;-)

Now - I can certainly change all of the existing trace calls to use the
new
TRACE/MTRACE macros if that's really what you want (btw, the existing
INFO/WARN/etc
macros wont go away, they will just be wrapped by the new trace call).

>  * Probably add event more tracing. (As you have done for UUIDs)

Can we leave adding this until later? It's rather difficult for me to
decide
all the possible extra tracing that is needed ;-)

>  * The tracing facility allowes to enable/disable different classes
>    of tracing information at run-time.

Something more than I have already done? The intent of the trace_types
parameter
is exactly this - to define the class(es) of output required.

if I convert the existing trace statements, I'll probably add one (maybe
two)
more trace types that cover the existing stuff and have it enabled by
default.

>  * But I would also like to disable it at completely at compile time.

Including the existing trace statements?
I'm OK with this, just checking that's what you want - the ability to
generate a driver with no tracing in it at all.

Thanks for your review,
Simon=20

