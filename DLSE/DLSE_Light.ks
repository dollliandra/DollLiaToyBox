'use strict';
//////////////////////////////////////////////////////
//                                                  //
//      //////////////////////////////////////      //
//      // DollLia's Light Spells Expansion //      //
//      //////////////////////////////////////      //
//                                                  //
//////////////////////////////////////////////////////

//#region Spell - Purging Cross
/**********************************************************
 * Spell - Purging Cross
 * > Cost - 50MP            > Prerequisite - Blessing of Light
 * > Damage - 50 Holy       > Components - Legs
 * 
 * Casts a cross-shaped AoE centered on the player.
 * Inspired by a spell from Moonring.
 **********************************************************/
// Actual Spell on the Hotbar.  Uses the Toggle trick to cast without targeting
let DLSE_PurgingCross = {
    name: "DLSE_PurgingCross", tags: ["light", "aoe", "offense"], school: "Illusion", 
    prerequisite: "ApprenticeLight", 
    components: ["Legs"], level:1, manacost: 4, 
    onhit:"", time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert",
    defaultOff: true, type:"passive",

    // Fire an event that actually handles the spellcasting.
    events: [
        {type: "DLSE_PurgingCross", trigger: "toggleSpell", cost: 5},
    ]
}

KinkyDungeonSpellList["Illusion"].push(DLSE_PurgingCross);

// Dummy spell to roll miscast chances with.
let DLSE_PurgingCross_Test = {
    name: "DLSE_PurgingCrossTest", tags: ["light", "aoe", "offense"], school: "Illusion", 
    components: ["Legs"], level:1, manacost: 4, 
    onhit:"", time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert", type:"passive",
}


// Attempting to re-write to no avail.
// let DLSE_PurgingCross_Test = {
//     name: "DLSE_PurgingCrossTest", tags: ["light", "aoe", "offense"], school: "Illusion", 
//     components: ["Legs"], level:1, manacost: 4, 
//     onhit:"lingering", time: 0, delay: 0, range: 0, lifetime: 0, power: 5, damage: "cold", type:"inert",

//     aoe: 3, aoetype: "cross",
// }



// Plays the on-hit graphic when passing through a target, causing graphical issues
// let DLSE_ConceptBeam = {
//     name: "DLSE_PurgingCrossBeam", tags: ["aoe", "offense", "shadow"], school: "Illusion", manacost: 0, components: [], level:1, 
//     type:"bolt", projectileTargeting:true, piercing: true, noTerrainHit: true, onhit:"aoe", 
//     power: 5, damage: "holy", delay: 0, //aoe: 0.5, //size: 1,
//     noEnemyCollision: false,

//     noUniqueHits: true,     // Fixes double-hit issues
//     //time: 2,    // Does nothing?

//     // Shoot a projectile that expires, playing a graphic at the end
//     range: 2.5, speed: 2, lifetime: 1,
//     trailspawnaoe: 0, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 1,
// }
// KinkyDungeonSpellList["Illusion"].push(DLSE_ConceptBeam);


// Graphics Spells
// This spell has complicated VFX to display.  I hope this doesn't have performance issues...
// N/E/S/W
let DLSE_CheeseBeamEast = {
    name: "DLSE_PurgingCrossBeam", tags: ["aoe", "offense", "shadow"], school: "Illusion", manacost: 0, components: [], level:1, 
    type:"bolt", projectileTargeting:true, piercing: false, noTerrainHit: false, onhit:"aoe", 
    power: 0, damage: "inert", delay: 0, //aoe: 0.5, //size: 1,
    noEnemyCollision: true, 

    noUniqueHits: true,     // Fixes double-hit issues
    //time: 2,    // Does nothing?

    // Shoot a projectile that expires, playing a graphic at the end
    range: 2.5, speed: 2, lifetime: 1,
    trailspawnaoe: 0, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 1,
    hitColor: 0xffee83, hitLight: 2,
}
let DLSE_CheeseBeamSouth = {
    name: "DLSE_PurgingCrossBeamSouth", tags: ["aoe", "offense", "shadow"], school: "Illusion", manacost: 0, components: [], level:1, 
    type:"bolt", projectileTargeting:true, piercing: false, noTerrainHit: false, onhit:"aoe", 
    power: 0, damage: "inert", delay: 0, //aoe: 0.5, //size: 1,
    noEnemyCollision: true,

    noUniqueHits: true,     // Fixes double-hit issues
    //time: 2,    // Does nothing?

    // Shoot a projectile that expires, playing a graphic at the end
    range: 2.5, speed: 2, lifetime: 1,
    trailspawnaoe: 0, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 1,
    hitColor: 0xffee83, hitLight: 2,
}
let DLSE_CheeseBeamWest = {
    name: "DLSE_PurgingCrossBeamWest", tags: ["aoe", "offense", "shadow"], school: "Illusion", manacost: 0, components: [], level:1, 
    type:"bolt", projectileTargeting:true, piercing: false, noTerrainHit: false, onhit:"aoe", 
    power: 0, damage: "inert", delay: 0, //aoe: 0.5, //size: 1,
    noEnemyCollision: true,

    noUniqueHits: true,     // Fixes double-hit issues
    //time: 2,    // Does nothing?

    // Shoot a projectile that expires, playing a graphic at the end
    range: 2.5, speed: 2, lifetime: 1,
    trailspawnaoe: 0, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 1,
    hitColor: 0xffee83, hitLight: 2,
}
let DLSE_CheeseBeamNorth = {
    name: "DLSE_PurgingCrossBeamNorth", tags: ["aoe", "offense", "shadow"], school: "Illusion", manacost: 0, components: [], level:1, 
    type:"bolt", projectileTargeting:true, piercing: false, noTerrainHit: false, onhit:"aoe", 
    power: 0, damage: "inert", delay: 0, //aoe: 0.5, //size: 1,
    noEnemyCollision: true,

    noUniqueHits: true,     // Fixes double-hit issues
    //time: 2,    // Does nothing?

    // Shoot a projectile that expires, playing a graphic at the end
    range: 2.5, speed: 2, lifetime: 1,
    trailspawnaoe: 0, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 1,
    hitColor: 0xffee83, hitLight: 2,
}
let DLSE_CheeseBeamCenter = {name: "DLSE_PC_Center", tags: [], school: "Illusion", manacost: 0, components: [], level:1, type:"hit", onhit:"instant", power: 0, range: 0, size: 1, lifetime: 1, aoe: 0, damage: "inert",
    hitColor: 0xffee83, hitLight: 2,
}

// Damage Spell - Shadow Dagger clone
// > Does NOT pierce walls.  Only enemies.
let DLSE_PurgingCrossDamageComp = {name: "DLSE_PurgingCrossDamageComp", tags: ["bolt", "shadow", "offense"], school: "Illusion", manacost: 0, components: [], level:1,
    type:"bolt", projectileTargeting:true, noDoubleHit: true, onhit:"", pierceEnemies: true,
    power: 4, time: 0, delay: 0, range: 3, damage: "holy", speed: 4
}

// Use an event on spell toggle to fire the actual spell
// > Code is built upon Magical Sight ("Analyze") and Desperate Struggle
KDEventMapSpell.toggleSpell["DLSE_PurgingCross"] = (e, spell, data) => {
    if (data.spell?.name == spell?.name) {                          // Sanity check of some sort?
        KinkyDungeonSpellChoicesToggle[data.index] = false;         // Toggle the spell back off.
        let player = KinkyDungeonPlayerEntity;                      // Save some keystrokes later.
        
        // Check for Spell Components & Mana Cost
        // > This handy function even outputs the correct errors to the player.
        if(KinkyDungeonHandleSpellCast(spell)){
            // Attempt to cast a Dummy spell, to roll miscast chances. Spends mana on success.
            let miscastTest = KinkyDungeonCastSpell(player.x,player.y,DLSE_PurgingCross_Test,0,1).result;

            if(miscastTest!= "Miscast"){

                // Play the Spellcast line.  May not be correct priority or color.  Literally used an eyedrop tool for the hexcode.
                KinkyDungeonSendTextMessage(10, TextGet("KinkyDungeonSpellCastDLSE_PurgingCross"), "#93a9ff", 1);

                KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/SciFiExplode.ogg", undefined, 0.3);//"Audio/Lightning.ogg");



                // Cast spell in all four cardinal directions.
                // I do not understand what all of these things do, but... it's working.

                KinkyDungeonCastSpell(
                    player.x+2,                     // targetX:number   - Target's X coordinate
                    player.y,                       // targetY:number   - Target's Y coordinate
                    DLSE_CheeseBeamEast,            // spell:spell      - Spell to cast
                    {x: player.x, y: player.y},     // enemy:entity     - It seems like more of a "Source Tile"
                    undefined,                      // player:any       - Boolean?
                    undefined,                      // bullet           - ???
                    "Player",                       // forceFaction     - Force faction to Player
                );
                // Repeat for the other three cardinal directions
                // There HAS to be a better solution than THIS.  This is embarrassing and I am SORRY.
                KinkyDungeonCastSpell(player.x-2,player.y,DLSE_CheeseBeamWest, { x: player.x, y: player.y }, undefined, undefined, "Player");
                KinkyDungeonCastSpell(player.x,player.y+2,DLSE_CheeseBeamSouth, { x: player.x, y: player.y }, undefined, undefined, "Player");
                KinkyDungeonCastSpell(player.x,player.y-2,DLSE_CheeseBeamNorth, { x: player.x, y: player.y }, undefined, undefined, "Player");
                KinkyDungeonCastSpell(player.x,player.y, DLSE_CheeseBeamCenter, { x: player.x, y: player.y }, undefined, undefined, "Player");

                // Fire the damage component as a separate spell, because of issues with graphics and hit delay.
                KinkyDungeonCastSpell(player.x+2,player.y,DLSE_PurgingCrossDamageComp, { x: player.x, y: player.y }, undefined, undefined, "Player");
                KinkyDungeonCastSpell(player.x-2,player.y,DLSE_PurgingCrossDamageComp, { x: player.x, y: player.y }, undefined, undefined, "Player");
                KinkyDungeonCastSpell(player.x,player.y+2,DLSE_PurgingCrossDamageComp, { x: player.x, y: player.y }, undefined, undefined, "Player");
                KinkyDungeonCastSpell(player.x,player.y-2,DLSE_PurgingCrossDamageComp, { x: player.x, y: player.y }, undefined, undefined, "Player");


                // TODO - Move this lower?  Unsure how it will behave with stacks.
                KDTriggerSpell(spell, data, false, true);                                       // "Trigger" the Spell.  Consumes Arcane Power, etc.
            }

            // Make time advance, as nothing we've done actually costs a turn.  This includes miscasts.
            KinkyDungeonAdvanceTime(1);
        }
    }
}



//#region Spell - Leap of Faith
/**********************************************************
 * Spell - Leap of Faith
 * > Cost - 40MP           > Prerequisite - Blessing of Light
 * > Components - Legs
 * 
 * Teleport to a tile that you can see. Become Blind for 15 turns.
 * Inspired by a spell from Moonring.
 **********************************************************/
let DLSE_LeapOfFaith = {
    name: "DLSE_LeapOfFaith", prerequisite: "ApprenticeLight", tags: ["light", "utility", "defense"], school: "Illusion", //sfx: "MagicSlash"
    // Probably need a cast condition to not cast on top of Shrines. Forward to Shadow Dance.
    //castCondition: "ShadowDance",
    manacost: 4, components: ["Legs"], requireLOS: true, noTargetEnemies: true, level:1, type:"hit", onhit:"teleport", delay: 0, lifetime:1, range: 3.9, damage: "",

    // Part of the cost of the spell is blinding yourself.
    playerEffect: {name: "DLSE_LOFBlind", time: 15},
}

// Effect to blind yourself when you cast the spell.
KDPlayerEffects["DLSE_LOFBlind"] = (_target, _damage, playerEffect, _spell, _faction, _bullet, _entity) => {
    let effect = false;
    if (Math.round(
        playerEffect.time * KinkyDungeonMultiplicativeStat(KinkyDungeonGetBuffedStat(KinkyDungeonPlayerBuffs, "lightDamageResist"))
    ) > 0) {
        if (!(KDEntityBuffedStat(KinkyDungeonPlayerEntity, "blindResist") > 0))
            KDGameData.visionAdjust = Math.min(1, (KDGameData.visionAdjust || 0) + 1.5);
        KinkyDungeonStatBlind = Math.max(KinkyDungeonStatBlind,
            Math.round(playerEffect.time * KinkyDungeonMultiplicativeStat(KDEntityBuffedStat(KinkyDungeonPlayerEntity, "blindResist"))));
        KinkyDungeonSendTextMessage(5, TextGet("KinkyDungeonBlindSelf"), "#ff5277", Math.round(
            playerEffect.time * KinkyDungeonMultiplicativeStat(KinkyDungeonGetBuffedStat(KinkyDungeonPlayerBuffs, "lightDamageResist"))
        ));
        effect = true;
    }

    return {sfx: "Teleport", effect: effect};
}

KinkyDungeonSpellList["Illusion"].push(DLSE_LeapOfFaith);




//#region Spell - Wrathful Smite
/**********************************************************
 * Spell - Wrathful Smite
 * > Prerequisite - ???
 * > Components - Passive
 * 
 * EXPENSIVE damage rider that does a ton of damage.
 * Need it to toggle off after use.
 **********************************************************/
let DLSE_Wrath = {
    name: "DLSE_Wrath", 
    tags: ["light", "aoe", "offense", "buff"], 
    prerequisite: "ApprenticeLight", sfx: "FireSpell", school: "Illusion", manacost: 3, components: [], level:1, type:"passive", power: 6,
    events: [{type: "DLSE_Wrath", trigger: "afterPlayerAttack"}],
    defaultOff: true,                   // Spell is too expensive to use willy-nilly
}

KinkyDungeonSpellList["Illusion"].push(DLSE_Wrath);

// Event
KDEventMapSpell.afterPlayerAttack["DLSE_Wrath"] = (_e, spell, data) => {
    console.log(data);

    // Seems to allow Brawler to trigger?  Happy with that.
    if (!data.bullet && KinkyDungeonPlayerDamage && ((KinkyDungeonPlayerDamage.name && KinkyDungeonPlayerDamage.name != "Unarmed") || KinkyDungeonStatsChoice.get("Brawler")) && KinkyDungeonHasMana(KinkyDungeonGetManaCost(spell, false, true)) && data.targetX && data.targetY && (data.enemy && KDHostile(data.enemy))) {
        KDChangeMana(spell.name, "spell", "attack", -KinkyDungeonGetManaCost(spell, false, true));


        // Cast a Shadow Slash clone two spaces north of the target.
        KinkyDungeonCastSpell(
            //data.targetX, data.targetY,               // Old version, ignores knockback
            data.enemy.x, data.enemy.y,                 // "Smart" version, tracking through knockback/pull
            DLSE_WrathStrike,
            //{ x: data.targetX, y: data.targetY-3 },   // Old version
            {x: data.enemy.x, y:data.enemy.y-3},        // "Smart" version, tracking through knockback/pull
            undefined, 
            undefined,
            "Player"
        );
        KDTriggerSpell(spell, data, false, true);
    }

    // TODO - Toggle OFF the spell, but it's not working T_T
    //KinkyDungeonSpellChoicesToggle[KinkyDungeonSpellIndex("DLSE_Wrath")] = false;

}

// Actual Wrath spell.
let DLSE_WrathStrike = {
    name: "DLSE_WrathStrike", tags: ["aoe", "offense", "light"], prerequisite: "DLSE_Wrath", sfx: "Evil", school: "Illusion", manacost: 3, components: ["Arms"], level:1, 
    type:"bolt", projectileTargeting:true, piercing: true, noTerrainHit: true, noEnemyCollision: true, onhit:"aoe", power: 6, delay: 0, range: 2.5, aoe: 0, size: 1, lifetime:1, damage: "holy", speed: 1, time: 2,
    //trailspawnaoe: 1.5, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 0.4

    // TODO - SFX
    landsfx: "DLSE_exp_short_hard6",//"DLSE_exp_short_hard6",//"Telekinesis",
}



//#region Spell - Flash Rework Idea
/**********************************************************
 * Spell - Light
 * > Prerequisite - Blessing of Light
 * > Components - Toggle
 * 
 * Reworking Light into a toggle.  I don't know if it's better,
 *  so it hasn't ever hit live yet.
 **********************************************************/
let DLSE_Light = {
    name: "DLSE_Light", prerequisite: "ApprenticeLight", tags: ["buff", "utility", "light"], school: "Illusion", manacost: 0.1, defaultOff: true, components: [], level:1, type:"passive", 
    events: [
        {type: "DLSE_Light", trigger: "getLights", power: 12, time: 1},
        {type: "DLSE_Light", trigger: "toggleSpell"},
        //{type: "Blindness", trigger: "calcStats", power: -1},
        //{type: "AccuracyBuff", trigger: "tick", power: 0.4},
    ]
}

KDEventMapSpell.toggleSpell["DLSE_Light"] = (_e, spell, data) => {
    if (data.spell?.name == spell?.name) {
        KinkyDungeonUpdateLightGrid = true;
    }
}

KDEventMapSpell.getLights["DLSE_Light"] = (e, spell, data) => {
    if (KinkyDungeonHasMana(KinkyDungeonGetManaCost(spell, false, true)) ){
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, { id: "Light", type: "Light", duration: 9999, infinite: true, aura: "#ffffff" });
        KinkyDungeonUpdateLightGrid = true;
        // Spend the 1MP cost, but only once during that turn. You can toggle it on/off and it won't spend any more until turn passes.
        if (data.update > 0 || !KinkyDungeonFlags.get("DLSE_Light")) {
            KDChangeMana(spell.name, "spell", "tick", -KinkyDungeonGetManaCost(spell, false, true));
            KDTriggerSpell(spell, data, false, true);
            KinkyDungeonSetFlag("DLSE_Light", 1);       // Set the flag for 1 turn.
        }
    }else{
        KinkyDungeonDisableSpell("DLSE_Light");
        KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity, "Light");
        return;
	}

    if (KinkyDungeonPlayerBuffs.Light && KinkyDungeonPlayerBuffs.Light.duration > 0) {
        data.lights.push({
            brightness: e.power, x: KinkyDungeonPlayerEntity.x, y: KinkyDungeonPlayerEntity.y,
            color: string2hex(e.color || "#ffffff")
        });
    } 
}

// DEBUG
//KinkyDungeonSpellList["Illusion"].push(DLSE_Light);
//KinkyDungeonLearnableSpells[6][3].push("DLSE_Light");




// region Waves of Light
/**********************************************************
 * Spell - Flash
 * > Prerequisite - Blessing of Light
 * > Components - Verbal
 * 
 * Reworking Flash into a more interesting spell.
 **********************************************************/

let RING_BULLETSPIN_1X1 = 0.5
let RING_BULLETSPIN_3X3 = 0.4
let RING_BULLETSPIN_5X5 = 0.2

let DLSE_FlashLv1 = {
    name: "DLSE_Flash", color: KDBaseWhite, prerequisite: "ApprenticeLight", tags: ["light", "utility", "aoe", "offense"], noise: 8, sfx: "MagicSlash",
    hitColor: 0xffff77, hitLight: 6,
    hitevents: [
        {type: "BlindAll", trigger: "bulletHitEnemy", time: 8},
    ],
    school: "Illusion", manacost: 4, components: ["Verbal"], level:1, type:"special", special: "DLSE_Flash", time: 0, delay: 1, power: 2, range: 2.5, size: 3, aoe: 1.5, lifetime: 1, damage: "holy", playerEffect: {name: "Blind", time: 4},
    aoetype: "DLSE_Ring",
    bulletSpin: RING_BULLETSPIN_3X3,
}

let DLSE_FlashLv2 = {
    name: "DLSE_GreaterFlash", color: KDBaseWhite, tags: ["light", "utility", "aoe", "offense"], prerequisite: "DLSE_Flash", spellPointCost: 1,
    upcastFrom: "DLSE_Flash", upcastLevel: 1,
    hitColor: 0xffff77, hitLight: 8,
    hitevents: [
        {type: "BlindAll", trigger: "bulletHitEnemy", time: 17},
    ],
    noise: 0, sfx: "MagicSlash", school: "Illusion", manacost: 5, components: ["Verbal"], level:1, type:"special", special: "DLSE_GreaterFlash", onhit:"aoe", time: 2, delay: 1, power: 2, range: 2.5, size: 3, aoe: 1.5, lifetime: 1, damage: "stun", playerEffect: {name: "Blind", time: 6}
}

let DLSE_FlashLv3 = {
    name: "DLSE_FocusedFlash", color: KDBaseWhite, tags: ["light", "utility", "aoe", "offense"], prerequisite: "DLSE_GreaterFlash", spellPointCost: 1,
    upcastFrom: "DLSE_Flash", upcastLevel: 2,
    hitColor: 0xffff77, hitLight: 8,
    hitevents: [
        {type: "BlindAll", trigger: "bulletHitEnemy", time: 17},
    ],
    noise: 0, 
    //sfx: "MagicSlash", 
    school: "Illusion", manacost: 7, components: ["Verbal"], level:1, type:"special", special: "DLSE_FocusedFlash", onhit:"aoe", time: 4, delay: 1, power: 2, range: 2.5, size: 3, aoe: 2.5, lifetime: 1, damage: "stun", playerEffect: {name: "Blind", time: 6}
}


// This event apparently didn't exist, so adding it quick.
KDAddEvent(KDEventMapBullet, "bulletHitEnemy", "DLSE_ElementalEffect", (e, b, data) => {
    if (data.enemy && !data.miss && !data.disarm) {
        if ((!e.chance || KDRandom() < e.chance) && data.enemy.hp > 0 && !KDHelpless(data.enemy)) {
            if (!e.prereq || KDCheckPrereq(data.enemy, e.prereq)) {
                KinkyDungeonDamageEnemy(data.enemy, {
                    type: e.damage,
                    damage: e.power,
                    time: e.time,
                    bind: e.bind,
                    distract: e.distract,
                    addBind: e.addBind,
                    bindType: e.bindType,
                }, false, e.power <= 0.1, undefined, undefined, KinkyDungeonPlayerEntity, undefined, undefined, data.vulnConsumed);
            }
        }
    }
});

// Strikes in a 3x3 ring after 1 turn
let DLSE_Flash_3x3Ring = {
    name: "DLSE_Flash_3x3",
    color: KDBaseWhite, prerequisite: "ApprenticeLight", tags: ["light", "utility", "aoe", "offense"], noise: 4, sfx: "MagicSlash",
    hitColor: 0xffff77, hitLight: 6,
    hitevents: [
        {type: "BlindAll", trigger: "bulletHitEnemy", time: 8},
    ],
    noMiscast: true,
    school: "Illusion", manacost: 0, components: [], level:1, type:"inert", onhit:"aoe", time: 0, delay: 1, power: 2, range: 2.5, size: 3, aoe: 1.5, lifetime: 1, damage: "holy", playerEffect: {name: "Blind", time: 4},
    aoetype: "DLSE_Ring",
    bulletSpin: RING_BULLETSPIN_3X3,
}

// Strikes instantly in a 1x1
let DLSE_GreaterFlash_1x1Ring = {
    name: "DLSE_Flash_1x1",
    color: KDBaseWhite, prerequisite: "ApprenticeLight", tags: ["light", "utility", "aoe", "offense"], noise: 2, sfx: "MagicSlash",
    hitColor: 0xffff77, hitLight: 4,
    hitevents: [
        {type: "BlindAll", trigger: "bulletHitEnemy", time: 17},
        
    ],
    events: [
        {type: "DLSE_ElementalEffect", trigger: "bulletHitEnemy", damage: "stun", power: 0, time: 2},
    ],
    noMiscast: true,
    school: "Illusion", manacost: 0, components: [], level:1, type:"hit", onhit:"instant", time: 0, delay: 0, power: 2, range: 2.5, size: 1, aoe: .99, lifetime: 1, damage: "holy", playerEffect: {name: "Blind", time: 6},
    aoetype: "DLSE_Ring",
    bulletSpin: RING_BULLETSPIN_1X1,
}
let DLSE_GreaterFlash_3x3Ring       = { ...DLSE_Flash_3x3Ring }
DLSE_GreaterFlash_3x3Ring.hitevents = [
                                        {type: "BlindAll", trigger: "bulletHitEnemy", time: 17},
                                        {type: "DLSE_ElementalEffect", trigger: "bulletHitEnemy", damage: "stun", power: 0, time: 2},
                                      ]

// Focused Flash
let DLSE_FocusedFlash_1x1Ring       = { ...DLSE_GreaterFlash_1x1Ring}
let DLSE_FocusedFlash_3x3Ring       = { ...DLSE_Flash_3x3Ring }
DLSE_FocusedFlash_3x3Ring.spellcast = {spell: "DLSE_Flash_5x5", target: "target", directional:false, offset: false};
DLSE_FocusedFlash_3x3Ring.hitevents = [
                                        {type: "BlindAll", trigger: "bulletHitEnemy", time: 31},
                                        {type: "DLSE_ElementalEffect", trigger: "bulletHitEnemy", damage: "stun", power: 0, time: 4},
                                      ]
DLSE_FocusedFlash_3x3Ring.noSprite  = true;  // FocusedFlash has a projectile-style sprite

// Strikes in a 5x5 ring after 1 turn
let DLSE_FocusedFlash_5x5Ring = {
    name: "DLSE_Flash_5x5",
    color: KDBaseWhite, prerequisite: "ApprenticeLight", tags: ["light", "utility", "aoe", "offense"], noise: 6, sfx: "MagicSlash",
    hitColor: 0xffff77, hitLight: 8,
    hitevents: [
        {type: "BlindAll", trigger: "bulletHitEnemy", time: 31},
        {type: "DLSE_ElementalEffect", trigger: "bulletHitEnemy", damage: "stun", power: 0, time: 4},
    ],
    noMiscast: true,
    school: "Illusion", manacost: 0, components: [], level:1, type:"inert", onhit:"aoe", time: 0, delay: 1, power: 2, range: 2.5, size: 5, aoe: 2.5, lifetime: 1, damage: "holy", playerEffect: {name: "Blind", time: 10},
    aoetype: "DLSE_Ring",
    bulletSpin: RING_BULLETSPIN_5X5,
    noSprite: true,// FocusedFlash has a projectile-style sprite
}
KinkyDungeonSpellListEnemies.push(DLSE_FocusedFlash_5x5Ring);



let DLSE_FlashStrike_1x1 = {
    name: "DLSE_Flash_1x1", tags: ["aoe", "offense", "light"], prerequisite: "DLSE_Wrath", sfx: "Evil", school: "Illusion", manacost: 3, components: ["Arms"], level:1, 
    type:"bolt", projectileTargeting:true, piercing: true, noTerrainHit: true, noEnemyCollision: true, onhit:"aoe", power: 0, delay: 0, range: 1.5, aoe: 0, size: 1, lifetime:1, damage: "holy", speed: 1, time: 0,
    //trailspawnaoe: 1.5, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 0.4
    bulletSpin: RING_BULLETSPIN_3X3,
    // TODO - SFX
    landsfx: "DLSE_SoftLight",//"DLSE_exp_short_hard6",//"Telekinesis",
    hideWarnings: true,
}
let DLSE_FlashStrike_3x3 = {
    name: "DLSE_Flash_3x3_Trans", tags: ["aoe", "offense", "light"], prerequisite: "DLSE_Wrath", sfx: "Evil", school: "Illusion", manacost: 3, components: ["Arms"], level:1, 
    type:"bolt", projectileTargeting:true, piercing: true, noTerrainHit: true, noEnemyCollision: true, onhit:"aoe", power: 0, delay: 0, range: 3.5, aoe: 0, size: 3, lifetime:1, damage: "holy", speed: 2, time: 0,
    //trailspawnaoe: 1.5, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 0.4
    bulletSpin: RING_BULLETSPIN_3X3,
    // TODO - SFX
    landsfx: "DLSE_SoftLight",//"DLSE_exp_short_hard6",//"Telekinesis",
    hideWarnings: true,
}
let DLSE_FlashStrike_5x5 = {
    name: "DLSE_Flash_5x5_Trans", tags: ["aoe", "offense", "light"], prerequisite: "DLSE_Wrath", sfx: "Evil", school: "Illusion", manacost: 3, components: ["Arms"], level:1, 
    type:"bolt", projectileTargeting:true, piercing: true, noTerrainHit: true, noEnemyCollision: true, onhit:"aoe", power: 0, delay: 0, range: 5.5, aoe: 0, size: 5, lifetime:1, damage: "holy", speed: 2, time: 0,
    //trailspawnaoe: 1.5, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 0.4
    bulletSpin: RING_BULLETSPIN_3X3,
    // TODO - SFX
    landsfx: "DLSE_SoftLight",//"DLSE_exp_short_hard6",//"Telekinesis",
    hideWarnings: true,
}


// Spell Specials for Waves of Light
KinkyDungeonSpellSpecials["DLSE_Flash"] = (spell, _data, targetX, targetY, _tX, _tY, _entity, _enemy, _moveDirection, _bullet, _miscast, _faction, _cast, _selfCast) =>  {
    if (_miscast) return "Miscast";
    //let rocks = [];
    //if (rocks.length == 0) return "Fail";

    // Cast spells at target 3x
    KinkyDungeonCastSpell(
        targetX,                        // targetX:number   - Target's X coordinate
        targetY,                        // targetY:number   - Target's Y coordinate
        DLSE_Flash_3x3Ring,             // spell:spell      - Spell to cast
        undefined,                      // enemy:entity     - It seems like more of a "Source Tile"
        undefined,                      // player:any       - Boolean?
        undefined,                      // bullet           - ???
        "Player",                       // forceFaction     - Force faction to Player
    );

    KinkyDungeonSendActionMessage(3, TextGet("KinkyDungeonSpellCast"+spell.name), "#88AAFF", 2 + (spell.channel ? spell.channel - 1 : 0));
}

KinkyDungeonSpellSpecials["DLSE_GreaterFlash"] = (spell, _data, targetX, targetY, _tX, _tY, _entity, _enemy, _moveDirection, _bullet, _miscast, _faction, _cast, _selfCast) =>  {
    if (_miscast) return "Miscast";
    //let rocks = [];
    //if (rocks.length == 0) return "Fail";

    // Cast spells at target 3x
    KinkyDungeonCastSpell(
        targetX,                        // targetX:number   - Target's X coordinate
        targetY,                        // targetY:number   - Target's Y coordinate
        DLSE_GreaterFlash_1x1Ring,             // spell:spell      - Spell to cast
        undefined,                      // enemy:entity     - It seems like more of a "Source Tile"
        undefined,                      // player:any       - Boolean?
        undefined,                      // bullet           - ???
        "Player",                       // forceFaction     - Force faction to Player
    );
    KinkyDungeonCastSpell(
        targetX,                        // targetX:number   - Target's X coordinate
        targetY,                        // targetY:number   - Target's Y coordinate
        DLSE_GreaterFlash_3x3Ring,             // spell:spell      - Spell to cast
        undefined,                      // enemy:entity     - It seems like more of a "Source Tile"
        undefined,                      // player:any       - Boolean?
        undefined,                      // bullet           - ???
        "Player",                       // forceFaction     - Force faction to Player
    );
   

    KinkyDungeonSendActionMessage(3, TextGet("KinkyDungeonSpellCast"+spell.name), "#88AAFF", 2 + (spell.channel ? spell.channel - 1 : 0));
}

KinkyDungeonSpellSpecials["DLSE_FocusedFlash"] = (spell, _data, targetX, targetY, _tX, _tY, _entity, _enemy, _moveDirection, _bullet, _miscast, _faction, _cast, _selfCast) =>  {
    if (_miscast) return "Miscast";
    //let rocks = [];
    //if (rocks.length == 0) return "Fail";

    // Cast spells at target 3x
    KinkyDungeonCastSpell(
        targetX,                        // targetX:number   - Target's X coordinate
        targetY,                        // targetY:number   - Target's Y coordinate
        DLSE_FocusedFlash_1x1Ring,             // spell:spell      - Spell to cast
        undefined,                      // enemy:entity     - It seems like more of a "Source Tile"
        undefined,                      // player:any       - Boolean?
        undefined,                      // bullet           - ???
        "Player",                       // forceFaction     - Force faction to Player
    );
    KinkyDungeonCastSpell(
        targetX,                        // targetX:number   - Target's X coordinate
        targetY,                        // targetY:number   - Target's Y coordinate
        DLSE_FocusedFlash_3x3Ring,      // spell:spell      - Spell to cast
        undefined,                      // enemy:entity     - It seems like more of a "Source Tile"
        undefined,                      // player:any       - Boolean?
        undefined,                      // bullet           - ???
        "Player",                       // forceFaction     - Force faction to Player
    );


    // Cast a Shadow Slash clone from north of the target.
    KinkyDungeonCastSpell(
        targetX, targetY,
        DLSE_FlashStrike_1x1,
        { x: targetX, y: targetY-2 },
        undefined, 
        undefined,
        "Player"
    );

    // Cast a Shadow Slash clone from north of the target.
    KinkyDungeonCastSpell(
        targetX, targetY,
        DLSE_FlashStrike_3x3,
        { x: targetX, y: targetY-4 },
        undefined, 
        undefined,
        "Player"
    );

    // Cast a Shadow Slash clone from north of the target.
    KinkyDungeonCastSpell(
        targetX, targetY,
        DLSE_FlashStrike_5x5,
        { x: targetX, y: targetY-6 },
        undefined, 
        undefined,
        "Player"
    );
   

    KinkyDungeonSendActionMessage(3, TextGet("KinkyDungeonSpellCast"+spell.name), "#88AAFF", 2 + (spell.channel ? spell.channel - 1 : 0));
}


KinkyDungeonSpellList["Illusion"].push(DLSE_FlashLv1);
KinkyDungeonSpellList["Illusion"].push(DLSE_FlashLv2);
KinkyDungeonSpellList["Illusion"].push(DLSE_FlashLv3);


// bx, by - Target location (Static)
// xx, yy - Tested location
// ox, oy - Player location
// Ring AOE Type - An AOE that is a 1-thickness ring.
KDAOETypes["DLSE_Ring"] = (bx, by, xx, yy, rad, modifier = "", ox, oy) => {
    return rad - 1  <=  KDistEuclidean(bx - xx, by - yy)  &&  KDistEuclidean(bx - xx, by - yy)  <=  rad;
}






//region Spell - Eye for an Eye
/*******************
 * Eye for an Eye
 * 
 * Deal blinding holy damage whenever you're attacked.
 */
let DLSE_Retribution = {
    name: "DLSE_Retribution",
    tags: ["light", "buff"],
    prerequisite: ["ApprenticeLight"],
    school: "Illusion",
    manacost: 1, components: [], level: 1,
    type: "passive", //passive: true, 
    time: 0,
    delay: 0, 
    range: 0, 
    lifetime: 0,
    power: 0,
    damage: "inert",
    events: [
        {trigger: "beforeAttack", type: "DLSE_Retribution_Spellcast", spell: "DLSE_Retribution_Flash", },//prereq: "hit-hostile"},
    ],
}
KinkyDungeonSpellList["Illusion"].push(DLSE_Retribution);


KDAddEvent(KDEventMapSpell, "beforeAttack", "DLSE_Retribution_Spellcast",  (e, spell, data) => {
    console.log(data);
    if (data.attacker
        && KinkyDungeonHasMana(KinkyDungeonGetManaCost(spell, false, true))
        && data.eventable
        && (!(e.prereq == "hit") || (!data.missed && data.hit))
        && (!(e.prereq == "hit-hostile") || (!data.missed && data.hit //&& !data.attacker.playWithPlayer
            // Player attacking = hostile?
            // Enemy attacking enemy? hostile
            && (data.attacker.player || !data.target.player || KinkyDungeonAggressive(data.attacker))))
    ) {
        KDChangeMana(spell.name,"spell", "cast", -KinkyDungeonGetManaCost(spell));
        KinkyDungeonCastSpell(data.attacker.x, data.attacker.y, KinkyDungeonFindSpell(e.spell, true), undefined, undefined, undefined, "Player");
        KDTriggerSpell(spell, data, false, true);
        if (e.requiredTag)
            KinkyDungeonTickBuffTag(KinkyDungeonPlayerEntity, e.requiredTag, 1);
    }
});

// Meow
let DLSE_Retribution_Flash = {
    allySpell: true, name: "DLSE_Retribution_Flash", manacost: 0, components: [], level:1, type:"hit", school: "Illusion",
    onhit:"instant", noTerrainHit: true, power: 2, delay: 1, range: 1.5, size: 1, aoe: 1.5, lifetime: 1, damage: "holy",
    events: [{type: "BlindAll", trigger: "bulletHitEnemy", time: 10}],
}
KinkyDungeonSpellListEnemies.push(DLSE_Retribution_Flash);



//#region Spell - Guidance
/**********************************************************
 * Spell - Divine Guidance
 * > Prerequisite - Blessing of Light
 * > Components - Passive
 * 
 * Gain Accuracy while blind.
 **********************************************************/
let DLSE_Guidance = {
    name: "DLSE_Guidance",
    tags: ["light", "utility"],
    prerequisite: ["ApprenticeLight"],
    school: "Illusion",
    manacost: 0, components: [], level: 1,
    type: "", onhit: "",
    passive: true, 
    time: 0,
    delay: 0, 
    range: 0, 
    lifetime: 0,
    power: 0,
    damage: "inert",
    events: [
        {
            type: "DLSE_Guidance",
            trigger: "tick",
        }
    ]
}

// Tick Event - Increases Accuracy While Blinded
// Currently 10% Accuracy per 1 Blind Level.  Max of 60% ACC when blind, which turns the debuff into a buff!
KDEventMapSpell.tick["DLSE_Guidance"] = (e, spell, data) => {
    let accPower = 0.1 * KinkyDungeonBlindLevel;

    //console.log(KinkyDungeonGetVisionRadius());       // Debugging purposes

    // If we are blind, apply the buff
    if (KinkyDungeonBlindLevel > 0) {
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
            id: "DLSE_Guidance",
            type: "Accuracy",
            power: accPower,
            duration: 1,
            //infinite: true,
            player: true,
            enemies: false,
            count: 1,
            events: []
        })       
    }
}


KinkyDungeonSpellList["Illusion"].push(DLSE_Guidance);