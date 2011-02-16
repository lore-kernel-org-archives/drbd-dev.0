Return-Path: <adam.kliment@virtualmaster.cz>
Received: from ns.chl.cz (ns.chl.cz [80.79.29.42])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 241DC1057599
	for <drbd-dev@lists.linbit.com>; Wed, 16 Feb 2011 11:58:11 +0100 (CET)
Message-ID: <4D5BA909.4090206@virtualmaster.cz>
Date: Wed, 16 Feb 2011 11:38:01 +0100
From: Adam Kliment <adam.kliment@virtualmaster.cz>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] announcing drbd ruby gem
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello DRBD developers,
   I'd like to present our prototype of drbd gem - ruby wrapper over 
drbdadm. Gem is available on rubygems [1] (gem install drbd) and source 
is placed on GitHub [2]. Please give as some feedback on GitHub issue 
tracker [3]. We will really appreciate all questoins, bug-reports, 
feature requests, tips and code reviews or hints for refactoring. Feel 
free to fork.
   Actually it is by-hand tested on Debian Etch, Ubuntu 8.04 and Ubuntu 
9.10 with the single version of DRBD: 8.3.7. We would like to conserve 
actual functionality with automated RSpec tests to assure compatibility 
for future versions of DRBD. Volunteers, maintainers and tips for this 
test suite are welcome! ;-)
Best regards
Adam Kliment

[1] https://rubygems.org/gems/drbd
[2] https://github.com/n1k/drbd
[3] https://github.com/n1k/drbd/issues

-- 
Virtualmaster
Karla Majera 93
252 31, Všenory
email: info@virtualmaster.cz
jabber: info@virtualmaster.cz
tel: +420.272049092
fax: +420.272048064
web: http://www.virtualmaster.cz

