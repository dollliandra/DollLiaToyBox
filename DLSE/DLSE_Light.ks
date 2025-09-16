'use strict';
//////////////////////////////////////////////////////
//                                                  //
//      //////////////////////////////////////      //
//      // DollLia's Light Spells Expansion //      //
//      //////////////////////////////////////      //
//                                                  //
//////////////////////////////////////////////////////

/**********************************************************
 * Spell - Purging Cross
 * > Cost - 50MP            > Prerequisite - Blessing of Light
 * > Damage - 50 Holy       > Components - Legs
 * 
 * Casts a cross-shaped AoE centered on the player.
 * Inspired by the spell of the same name from Moonring.
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




/**********************************************************
 * Spell - Leap of Faith
 * > Cost - 40MP           > Prerequisite - Blessing of Light
 * > Components - Legs
 * 
 * Teleport to a tile that you can see. Become Blind for 15 turns.
 * Inspired by the spell of the same name from Moonring.
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






/**********************************************************
 * Spell - Halo
 * > Cost - 40MP           > Prerequisite - ???
 * > Components - Verbal
 * 
 * Deal damage in a 3x3 (5x5?) AoE, EXCEPT the center.
 **********************************************************/

let DLSE_Halo = {
    name: "EarthformRing", tags: ["light", "offense", "aoe"], landsfx: "Bones", school: "Illusion", manacost: 4, components: ["Verbal"], prerequisite: ["ApprenticeLight"],
    level:1, type:"hit", onhit:"aoe", 
    power: 2, delay: 1, range: 2.5, size: 1, aoe: 1.99, lifetime: 1, damage: "holy",
}




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