Thank you for trying out this little project.

nhcustom is a (wip) application whose purpose is to modify the no-hats-bgum mod.
It looks for a configuration file named "config.txt" and executes the actions
specified in it.

DO NOT MOVE the .exe file out of this folder. It needs to be in the same
directory as the config file, the database file (database.txt), the input
folder and the output folder.

Source code isn't yet available, but it will be eventually.


================================================================================
You WILL see a certain number of cosmetics still appearing whith the mod created
by this program. This is because of the database, which is incomplete, but I'm
working on it.
================================================================================



==============
-DEPENDENCIES-
==============

This application is written in c# (Mono).

For Windows, it will most likely work out of the box (at least it did for me)
but I cannot guarantee it. if it doesn't, it is probably because you don't have
a .NET framework installed. See this link:
https://dotnet.microsoft.com/download/dotnet-framework

For Linux, no dependencies are required as the executable comes bundled with
every library it needs (explaining its big filesize). It was tested on
Ubuntu 20.04 and Fedora 32.



=================
-THE CONFIG FILE-
=================

Heads-up: The program is CASE-SENSITIVE. Be sure that you put the exact name
of what you want in the config file. Refer to the teamfortress wiki to get
the correct names of the cosmetics or anything else you want to include in it.

Anything in the config file is what you DON'T want to see in-game.
What you can specify in the configuration file (a list of every possible
entries is provided at the bottom of this text file):

The name of a hat (ex: Fancy Fedora)

An update (ex: Scream Fortress 2013)

An equip region (ex: Shoes)

A date (ex: 2015 or 2015/2016 or 2015-05-02/2016-09-10)
info: if you type something like "2015/2016" in the config file, the program
will interpret it as "2015-01-01 to 2016-12-31". use "2015" if you only want to
remove this year.

A class (ex: Demoman)

You can also tell the program to make exceptions for specific hats/updates/etc.
Just add a "!" at the beginning of the line. So if you wanted to remove every
hat from 2007 but keep the Fancy Fedora (came out it 2007), here's what you'd
write in the config file:

2007
!Fancy Fedora

Be aware that the program reads the config file line by line, so if you enter a
new line that affects the exceptions you made earlier, they will be canceled.

don't do this:
2007
!Fancy Fedora
2007/2008

Also: imagine you want to remove every cosmetics that the Scout can wear. You'd
think you only need to type "Scout" in the config file, but this isn't actually
true. The program will only remove hats that are "only" for the scout, leaving
a lot of multi-class cosmetics untouched. If you want to do this, append a "*"
to the class, like so:

Scout*

Now, the program will remove any cosmetics that can be worn by the scout, not
only scout exclusive ones. You would also want to remove all-class cosmetics,
as they don't refer to any class specifically in the database.

Something like this:

Scout*
All classes

(this is a limitation of the program. There is also no way to remove with a
single line cosmetics that are worn by multiple classes, say the Scout,
Soldier and Engineer, but that are not considered "all-class" cosmetics,
since they aren't worn by every class. You would need to type each of those
hats manually. Some improvements are needed here.)

Info: Appending a "*" also works with equip regions, but nothing else.

You can make comments in your config file. Add a "#" before any of them. ex:

#Here is a comment
2007 #You can also add them on the same line as a parameter
#Everything written after a "#" is ignored, so don't write parameters after one.



==================
-THE INPUT FOLDER-
==================

This is where you need to place a (UNCOMPILED, so not a .vpk file) version
of the mod. The program will search for files in it and copy them over the
output folder based on the instructions of the config file.

You can decompile the mod and place it in this folder, or you can download an
already decompiled and up to date version here:
https://github.com/Fedora31/no-hats-bgum/blob/master/nhm_source/mechbgum_no_hats_mod/no_hats_bgum.zip

Be sure the filepath is the same as this one:
input/models/...



===================
-THE OUTPUT FOLDER-
===================

The resulting mod will be placed in this folder. It is wiped clean everytime you
run the program, so make sure that you backup anything you want to keep. If the
output folder doesn't exist, it will be created automatically.

The resulting mod isn't compiled. Refer to these 2 videos to know how to compile
it to a VPK file and install it.

Windows: https://streamable.com/uav0li

Linux: https://streamable.com/vxchci




==============
-THE DATABASE-
==============

Every cosmetic is referenced in this file, alongside every class they are for,
every equip regions they occupy, with which update they came with, their release
date, and their filepath in the game. It's incomplete and is missing a lot of
filepaths, but it's complete enough to be tested. You don't need to contact me
about missing or wrong paths, I'm well aware of them ;D

The program doesn't contain hard-coded lists for updates, hats or anything, it
Scans the database for everything it needs. So I guess that if you add custom
entries to it, it should work. I haven't tested this though.



=========
-CONTACT-
=========

If you want to contact me about this program, You can reach me at this e-mail
address: pevhs@airmail.cc

You can also contact me through steam: https://steamcommunity.com/id/mranchois/



======================
-CONFIG FILES ENTRIES-
======================

Here's what you can put in the config file:

-UPDATES-

Fall Event 2013
Tough Break Update
Invasion Community Update
Australian Christmas
Scream Fortress 2018
Manniversary Update & Sale
Scream Fortress 2013
Jungle Inferno Update
Scream Fortress 2016
Summer Event 2013
Rainy Day Pack
Mayflower Pack
None (this is for cosmetics which didn't come out with an update)
Love & War Update
Smissmas 2013
Strongbox Pack
Mecha Update
Pyromania Update
Very Scary Halloween Special
Mann vs. Machine Update
Blue Moon Pack
Über Update
Scream Fortress 2014
Scream Fortress 2015
Mann-Conomy Update
Scream Fortress 2019
Australian Christmas 2011
Classless Update
Summer 2019 Pack
Smissmas 2017
Robotic Boogaloo
Sniper vs. Spy Update
First Workshop Content Pack
Japan Charity Bundle
Third Community Contribution Update
Summer Camp Sale
Smissmas 2014
Second Community Contribution Update
Smissmas 2016
End of the Line Update
Spectral Halloween Special
Smissmas 2018
Second Workshop Content Pack
Gun Mettle Update
Smissmas 2019
Scream Fortress Update
Invasion Update
Triad Pack
Manno-Technology Bundle
Replay Update
Dr. Grordbort's Victory Pack Update
Shogun Pack
Mac Update
Haunted Hallowe'en Special
119th Update
Scream Fortress VII
Limited Late Summer Pack
First Community Contribution Update
Two Cities Update
Meet Your Match Update
Scream Fortress 2020
Summer 2020 Pack

-EQUIP REGIONS-

Beard
Hat
Back
Grenades
Sleeves
Feet
Disconnected Floating Item
Belt
Coat
Right Shoulder
Head Replacement
Shirt
Face
None
Arm Tattoos
Left Shoulder
Arms
Head Skin
Medal
Pocket
Whole Head
Pants
Necklace
Lenses
Moustache and Eyepatch
Glasses
Bullets
Backpack
Hair
Head
Legs
Tail
Vest
Hands
Hip
Ears
Collar
Quiver
Medigun Accessories
Wings
Flair
Towel
Left Arm
Hip Pouch
Spikes
Headband
Pipe
Gloves
Cigar
Bandages
Zombie Body

-CLASSES-

Medic
Spy
Pyro
All classes
Engineer
Demoman
Heavy
Scout
Sniper
Soldier

-HATS-

The list would be too long if I included
all the hats here. Refer to the teamfortress
wiki to find the name of the hat you want to add.

-DATES-

Any date.
