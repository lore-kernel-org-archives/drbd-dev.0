Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: DRBD contribution
Date: Wed, 30 Apr 2008 10:58:09 +0200
References: <20080429111946.13238.qmail@f5mail-237-208.rediffmail.com>
In-Reply-To: <20080429111946.13238.qmail@f5mail-237-208.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804301058.10126.philipp.reisner@linbit.com>
Cc: Azeez Ahamed <azeez.ahamed@rediffmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 29. April 2008 13:19:46 schrieb Azeez Ahamed:
> Hello Philipp,
>
>     Thanks for the inputs you provided. I have made a good progress
> on the patch you suggested me to develop. Before I submit the code,
> i want to make sure your requirements are matched.
>
> So far i have developed
>    * Before only two 'on' sections per resource were allowed. This
>      information was available in res->me and res->peer.
>      Now, allowing multiple 'on' sections. As of now, no limit is
>      provided. If you are looking for some limit for no. of peer
>      host, then please let me know.

Right. There should be no limit. The intention was to replace 
res->me and res->peer by a list. I guess this is what you have 
done, right?

>
>    * Added a new option in drbdadm command i.e. --peer-host.
>      # drbdadm
>
>        OPTIONS:
>         {--dry-run|-d}
>         {--verbose|-v}
>             ...
>         {--sh-varname|-n} val
>         {--peer-host|-h} val   ===> new option added
>
>      Syntax will be:
>         drbdadm -h <peer-name> connect <resource>
>      Let me know if you want to change the option name.
>

This is reasonable.

>    * For selecting the peer host, i have used the following logic
>
>      If '-h <peer-name>' option is specified, then searching the
>      <peer-name> under <resource> in the config file. If found,
>      then this <peer-name> is used as peer host. Otherwise, an
>      error is displayed and drbdadm program exits.
>
>      If '-h <peer-name>' option is not specified, then peer name will
>      be taken from the second 'on' section's name of that <resource>.
>      In this case, only two 'on' sections will be there. During DRBD
>      service start, as of now drbdadm is not called with new option
>      i.e. -h <peer-name>.
>

In case there is no '-h <peer-name>' option on the command line _AND_
there are only two 'on' sections _AND_ on of the one sections matches
my own local host name, then the peer is the other 'on' section.

With that logic drbdadm stays completely compatible to the current
calling semantics, as long as there are only two 'on' sections.

>      In that case we need to change the drbd script or use default
>      <peer-name> for drbdadm command. In my case i am using second 'on'
>      section's name as default <peer-name> for drbdadm command.
>
>      In both the cases(with/without -h option), it is made sure that
>      peer host name is not same as local host. Otherwise, an error is
>      displayed and drbdadm program exits.
>

In order to specify a default peer, there should be an additional 
keyword. E.g. "default". That keyword might only be specified in
two of the 'on' sections.

I do not think it is a good idea to make the default selection 
dependend on the order of the sections in the config file, since
we advise our users to use the same config file on all nodes of
the cluster.

The real intention of this feature is to deligate the peer selection
to heartbeat's OCF drbd agent. -- But that will be the next step, after
we have all the functionality in drbdadm in place.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
