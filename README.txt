
           _______________________________________________
          #============================================#  \
         /--------------------------------------------/ \  \
        #============================================# \ \  \
         \XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\ \ \ |
          \XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\ \ \|
           \XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\ \/
            \XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\/
             ((((O===============((((O===============((((O
            /|                                          /|
           //|  Kinky Dungeon - Doll.Lia's Toy Box     //|
          ///|                             v. 0.2     ///|
         ////|                _                      ////|
        #====+===============/O\====================#////|
        #--------------------\|/--------------------#////
        #-------------------------------------------#///
        #-------------------------------------------#//
        #-------------------------------------------#/
        #===========================================#

					~By Doll.Lia

#=================================#
#              About              #
#=================================#

Doll.Lia's Toy Box add new weapons and spells to Kinky Dungeon.

Ideally, the new additions are balanced, and fit nicely alongside
 the existing toys & tricks available in Kinky Dungeon.

See the Discord post for the full list of included content.


New Weapon Types:
------------------------
Whips - Pain damage weapons with a high damage and stamina cost.
 > Whips have a ranged attack that pulls your target in!

Halberds - Polearms that deal bonus damage at range 2.
 > Use the melee attack to push enemies back, and line it up!


New Spells:
-------------
Includes spells for the following schools:
 > Light  - New unique spells such as Purging Cross, and self-blind synergy.
 > Shadow - Upcasts for various spells.


Other Changes:
--------------
Smoke Bombs & Shroud count as shadow for the purposes of shadow spells/weapons.
 > This allows you to Shadow Dance into your Shroud, then deal bonus damage with Shadow Slash.


#=================================#
#              Notes              #
#=================================#

Mod Configuration Menu is included.
 > Has some important toggles if you ever run into mod conflicts.

If you are trying to add items via console, use the DLSE_ prefix.
 > DLSE stands for Doll.Lia's Spell Expansion.



#========================================#
#====    Potential Mod Conflicts     ====#
#========================================#

---
1.) Mods that modify the following events/cast conditions:
* KDEventMapBullet.bulletHitEnemy["ShadowSlash"]
* KDEventMapWeapon.beforePlayerAttack["DamageMultInShadow"]
* KDEventMapBuff.tick["ShadowElementalEffect"]
* KDEventMapBuff.tick["UnShadowElementalEffect"]
* KDPlayerCastConditions["ShadowDance"]

These changes are to enable Shadow spells and Shadow's Edge to work with casts of Shroud/Smoke Bomb.

The "Shroud/Smoke Bombs" setting in the MCM allows you to disable this feature for mod compatibility.

---
2.) Mods that modify the Antique Merchant's shop.
* If there's a better way for my mod to edit this, please let me know.
* Can disable my changes via MCM.

----
3.) Mods that modify the functions KDCanOffhand() or KinkyDungeonCanUseWeapon()
* These functions were changed to implement the Big Arms perk.
* Disable Big Arms perk in the MCM if you run into issues.

---
4.) Kinky Dungeon updates making changes to ANY of the aforementioned functions.
* I'll need to forward any such changes to the mod.
* Use the MCM to disable any offending options until I do so.












#=========================================#
#==  Kinky Dungeon - DollLia's Toy Box  ==#
#==       Credits & Attributions        ==#
#=========================================#


#================================#
#          Doll.Lia              #
#================================#

1.) Original Spritework
* Most sprites are made using the default Aseprite palette Rosy-42.
 > DLSE_Whip & Derivatives
 > DLSE_Purging Cross
 > DLSE_Wrath
 > DLSE_LeapOfFaith
 > DLSE_Darkblade
 > DLSE_ShadowSlashLv2 Sprite

2.) Derivative Spritework of Kinky Dungeon
 > DLSE_Dagger, DaggerFan
 > DLSE_ShadowSlashLv2 VFX

3.) Mod Code


NOTE:
* You may use my mod code to write your own mods for Kinky Dungeon.
* You may NOT use my spritework without permission.


#===================================#
#      Strait Laced Games LLC       #
#===================================#

1.) Kinky Dungeon Source Code

2.) Original Kinky Dungeon Sprites & SFX


#=================================#
#        Code Assistance          #
#=================================#

Thank you to the KD Community for being super helpful~

* Ada18980 - Fixed sprites not loading with Nearest enabled.
* Enraa - Boilerplate for the MCM Menu.


#=================================#
#             Audio               #
#=================================#

Most audio is used under the CC0 license (Public Domain). Exceptions are noted.

Various Sources Including:
* 512-sound-effects-8-bit-style
 > Author - SubspaceAudio
 > https://opengameart.org/content/512-sound-effects-8-bit-style
 > CC0 Public Domain
 > https://creativecommons.org/public-domain/cc0/

* 13_ice_explosion.wav
 > Edited - Spliced into DLSE_WhipIceQueen.ogg
 > Original Author - leohpaz
 > https://opengameart.org/content/8-magic-attacks
 > CC-BY 4.0
 > https://creativecommons.org/licenses/by/4.0/

* ice.wav
 > CC0 Public Domain
 > https://opengameart.org/content/ice-spells

* Kinky Dungeon
 > Whip.ogg        - Spliced into DLSE_WhipIceQueen.ogg
 > HeavySwing2.ogg - Spliced into DLSE_HeavySlash.ogg