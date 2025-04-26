'use strict';

/******************************************************************
 * Load Assets with Nearest Enabled to fix the blurry sprite issue.
 * > Thanks to Ada for the KDTex() line of code <3
 *****************************************************************/
KDAddEvent(KDEventMapGeneric, "afterModSettingsLoad", "DLSE_SpriteNearestFix", (e, data) => {

    let DLSE_ItemsList = [
        "DLSE_Whip.png",
        "DLSE_WhipThorn.png",
        "DLSE_WhipTentacle.png",
        "DLSE_WhipIceQueen.png",
        "DLSE_WhipRose.png",
        "DLSE_Halberd.png",
        "DLSE_HalberdRoyal.png",
        "DLSE_HalberdLabrys.png",
    ]
    let DLSE_SpellsList = [
        // Light
        "DLSE_PurgingCross.png",
        "DLSE_LeapOfFaith.png",
        "DLSE_Wrath.png",
        // Shadow
        "Dagger.png",
        "DLSE_DaggerFan.png",
        "DLSE_ShadowSlashLv2.png",
        "DLSE_Darkblade.png",
    ]
    let DLSE_BulletsList = [

        "DLSE_Shroud.png",
        // Whips
        "DLSE_Whip_PullHit.png",
        "DLSE_WhipIceQueen_PullHit.png",
        "DLSE_WhipStrikeHit.png",
        "DLSE_WhipRose_PullHit.png",
        // Purging Cross is a MESS
        "DLSE_PC_CenterHit.png",
        "DLSE_PurgingCrossBeam.png",
        "DLSE_PurgingCrossBeamHit.png",
        "DLSE_PurgingCrossBeamTrailHit.png",
        "DLSE_PurgingCrossBeamSouthHit.png",
        "DLSE_PurgingCrossBeamSouthTrailHit.png",
        "DLSE_PurgingCrossBeamWestHit.png",
        "DLSE_PurgingCrossBeamTrailWestHit.png",
        "DLSE_PurgingCrossBeamNorthHit.png",
        "DLSE_PurgingCrossBeamTrailNorthHit.png",
        // Wrath
        "DLSE_WrathStrike.png",
        "DLSE_WrathStrikeHit.png",
        // Shadow
        "DLSE_DaggerFan.png",
        "DLSE_DaggerFanHit.png",
        "Dagger.png",
        "DLSE_ShadowSlashLv2.png",
        "DLSE_ShadowSlashLv2Hit.png",
        "DLSE_ShadowSlashLv2Trail.png",
        "DLSE_ShadowSlashLv2TrailHit.png",
    ]
    for (let dataFile of DLSE_ItemsList ) {
        KDTex(KDModFiles[KinkyDungeonRootDirectory + "Items/" + dataFile], true);
    }
    for (let dataFile of DLSE_SpellsList ) {
        KDTex(KDModFiles[KinkyDungeonRootDirectory + "Spells/" + dataFile], true);
    }
    for (let dataFile of DLSE_BulletsList ) {
        KDTex(KDModFiles[KinkyDungeonRootDirectory + "Bullets/" + dataFile], true);
    }
});