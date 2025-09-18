'use strict';
///////////////////////////////////////////////////////
//                                                   //
//      ///////////////////////////////////////      //
//      // DollLia's Arcane Spells Expansion //      //
//      ///////////////////////////////////////      //
//                                                   //
///////////////////////////////////////////////////////

// region Hyperfocus - Spells
/**********************************************************
 * Spell - Hyperfocus
 * > Cost - ???MP            > Prerequisite - Arcane Knowledge
 * > Components - ??? (Arms, strike a fancy pose or something? Or just NULL.)
 * 
 * Your next spell is guaranteed to crit.
 **********************************************************/
// Actual Spell on the Hotbar.  Uses the Toggle trick to cast without targeting
let DLSE_Hyperfocus = {
    name: "DLSE_Hyperfocus", prerequisite: "ApprenticeKnowledge", tags: ["buff", "utility", "knowledge"], school: "Illusion", 
    autoLearn: ["DLSE_Hyperfocus_Passive"],
    manacost: 3, defaultOff: true, time: 10, components: ["Verbal"], level:1, type:"passive",
    events: [
        {type: "DLSE_Hyperfocus", trigger: "toggleSpell", power: 12, time: 10},
    ]
}

// Actual Spell on the Hotbar.  Uses the Toggle trick to cast without targeting
let DLSE_Hyperfocus_Upcast = {
    name: "DLSE_Hyperfocus_Lv2", prerequisite: "DLSE_Hyperfocus", tags: ["buff", "utility", "knowledge"], school: "Illusion", 
    upcastFrom: "DLSE_Hyperfocus", upcastLevel: 1,
    manacost: 6, defaultOff: true, time: 10, components: ["Verbal"], level:1, type:"passive",
    events: [
        {type: "DLSE_Hyperfocus_Lv2", trigger: "toggleSpell", power: 12, time: 10},
    ]
}


// Invisible passive that handles tracking beforeCrit event
let DLSE_Hyperfocus_Passive = {
    name: "DLSE_Hyperfocus_Passive", manacost: 0, components: [], level:1, passive: true, type:"", onhit:"", time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert",
    hideLearned: true, hideWithout: "DLSE_Hyperfocus",
    events: [
        //{type: "DLSE_Hyperfocus_Passive", trigger: "playerCast", tags: ["arrowreplace"],},
        {type: "DLSE_Hyperfocus_Passive", trigger: "beforeCrit"},
        //{type: "DLSE_Hyperfocus_Passive", trigger: "duringCrit", mult: 1.5},
        {type: "DLSE_Hyperfocus_Passive", trigger: "launchBullet", power: 1,},
        {type: "DLSE_Hyperfocus_Passive_Static", trigger: "launchBullet", power: 1,},
    ]
}

// Dummy spell to roll miscast chances with. Spends mana on success.
let DLSE_HyperfocusTest = {
    name: "DLSE_HyperfocusTest", tags: ["knowledge", "aoe", "offense"], school: "Illusion", 
    components: ["Arms"], level:1, manacost: 4, 
    onhit:"", time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert", type:"passive",
}

// Add the spells to the spell lists.
KinkyDungeonSpellList["Illusion"].push(DLSE_Hyperfocus);
KinkyDungeonSpellList["Illusion"].push(DLSE_Hyperfocus_Upcast);
KinkyDungeonSpellList["Illusion"].push(DLSE_Hyperfocus_Passive);

// region Hyperfocus - Events
/******************************************
 * Hyperfocus - Toggle Events
 * CLick button, get spellcast, get buffed.
*******************************************/
// Event for when you click Hyperfocus, immediately triggering it.
KDEventMapSpell.toggleSpell["DLSE_Hyperfocus"] = (e, spell, data) => {
    if (data.spell?.name == spell?.name) {
        KinkyDungeonSpellChoicesToggle[data.index] = false;         // Toggle the spell back off.
        let player = KinkyDungeonPlayerEntity;                      // Save some keystrokes later.

        // Check for Spell Components & Mana Cost
        // > This handy function even outputs the correct errors to the player.
        if(KinkyDungeonHandleSpellCast(spell)){
            // Attempt to cast a Dummy spell, to roll miscast chances. Spends mana on success.
            let miscastTest = KinkyDungeonCastSpell(player.x,player.y,DLSE_HyperfocusTest,0,1).result;

            if(miscastTest!= "Miscast"){

                // Play the Spellcast line.  May not be correct priority or color.  Literally used an eyedrop tool for the hexcode.
                KinkyDungeonSendTextMessage(10, TextGet("KinkyDungeonSpellCastDLSE_Hyperfocus"), "#93a9ff", 1);

                // Play SFX
                KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/FireSpell.ogg", undefined,1);

                // Do actual spell stuff here!
                KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus_Lv2");            // Expire the others
                KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
                    id: "DLSE_Hyperfocus", 
                    type: "DLSE_Hyperfocus",
                    power: 1,
                    duration: e.time, 
                    aura: "#ff0000", 
                    //sfx: "FireSpell",
                });
                KDTriggerSpell(spell, data, false, true);    // "Trigger" the Spell.  Consumes Arcane Power, etc.
            }
            KinkyDungeonAdvanceTime(1);     // Advance time, as nothing has passed a turn!
        }
    }
}
// Event for when you click upcasted Hyperfocus, immediately triggering it.
KDEventMapSpell.toggleSpell["DLSE_Hyperfocus_Lv2"] = (e, spell, data) => {
    if (data.spell?.name == spell?.name) {
        KinkyDungeonSpellChoicesToggle[data.index] = false;         // Toggle the spell back off.
        let player = KinkyDungeonPlayerEntity;                      // Save some keystrokes later.

        // Check for Spell Components & Mana Cost
        // > This handy function even outputs the correct errors to the player.
        if(KinkyDungeonHandleSpellCast(spell)){
            // Attempt to cast a Dummy spell, to roll miscast chances. Spends mana on success.
            let miscastTest = KinkyDungeonCastSpell(player.x,player.y,DLSE_HyperfocusTest,0,1).result;
            if(miscastTest!= "Miscast"){
                // Play the SFX and Spellcast line.  May not be correct priority or color.  Literally used an eyedrop tool for the hexcode.
                KinkyDungeonSendTextMessage(10, TextGet("KinkyDungeonSpellCastDLSE_Hyperfocus_Lv2"), "#93a9ff", 1);
                KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/FireSpell.ogg", undefined,1);
                // Do actual spell stuff here!
                KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus");            // Expire the others
                KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
                    id: "DLSE_Hyperfocus_Lv2", 
                    type: "DLSE_Hyperfocus_Lv2",
                    power: 1,
                    duration: e.time, 
                    aura: "#ff0000", 
                    //sfx: "FireSpell",
                });
                KDTriggerSpell(spell, data, false, true);    // "Trigger" the Spell.  Consumes Arcane Power, etc.
            }
            KinkyDungeonAdvanceTime(1);     // Advance time, as nothing has passed a turn!
        }
    }
}

/******************************************
 * Hyperfocus - Spell Events
 * This spell is COMPLICATED!
*******************************************/
// playerCast event to catch when the player casts projectile spells.
// e - Event Data, spell - DLSE_Hyperfocus_Passive, data - the actual important stuff.
KDEventMapSpell.playerCast["DLSE_Hyperfocus_Passive"] = (e, spell, data) => {
    console.log("Data - Player Cast")
    console.log(data)
    if (data.bulletfired 
        //&& data.bulletfired.bullet?.spell?.tags?.some((t) => { return e.tags.includes(t); }) 
        && KDGameData.AncientEnergyLevel > (e.energyCost || 0)) {
        // data.bulletfired.bullet.spell = KinkyDungeonFindSpell(e.spell, true);
        // data.bulletfired.bullet.name = e.spell;
        if (data.bulletfired.bullet.damage) {
            data.bulletfired.bullet.damage.damage *= 2;
            if (e.power != undefined)
                data.bulletfired.bullet.damage.damage += e.power;
            if (e.damage != undefined)
                data.bulletfired.bullet.damage.type = e.damage;
            if (e.bind != undefined)
                data.bulletfired.bullet.damage.bind = e.bind;
            if (e.bindEff != undefined)
                data.bulletfired.bullet.damage.bindEff = e.bindEff;
            if (e.bindType != undefined)
                data.bulletfired.bullet.damage.bindType = e.bindType;
            if (e.addBind != undefined)
                data.bulletfired.bullet.damage.addBind = e.addBind;
            //data.bulletfired.bullet.damage.time = e.time;
        }
        // Unique to FireSpell

    }
}

// Event to force any spell to crit IF you have the buff.
KDEventMapSpell.beforeCrit["DLSE_Hyperfocus_Passive"] = (_e, _spell, data) => {
    console.log("Data - Before Crit:")
    console.log(data)
    if (data.faction == "Player" && data.spell
        && (!data.spell.tags?.includes("dot"))
        && (KDEntityHasBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus") || KDEntityHasBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus_Lv2"))) {
        data.forceCrit = true;

        // Set the buff's duration to 0, so that it expires after the turn ends.
        if(KinkyDungeonPlayerBuffs?.DLSE_Hyperfocus?.duration > 0){
            KinkyDungeonPlayerBuffs.DLSE_Hyperfocus.duration = 0;
        }
        if(KinkyDungeonPlayerBuffs?.DLSE_Hyperfocus_Lv2?.duration > 0){
            KinkyDungeonPlayerBuffs.DLSE_Hyperfocus_Lv2.duration = 0;
        }
    }
}

KDEventMapSpell.duringCrit["DLSE_Hyperfocus_Passive"] = (e, _spell, data) => {
    console.log("Data - During Crit:")
    console.log(data);
    if (data.dmg > 0 && data.critical && data.enemy
        //&& data.attacker?.player          // Prevents spells from super-critting
        && !data.attacker
        && !data.customCrit //&& KDHostile(data.enemy) 
        //&& !KDEnemyHasFlag(data.enemy, "RogueTarget")
        && KDEntityHasBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus_Lv2")
    ) {
        data.crit *= e.mult;
        data.bindcrit *= e.mult;
        //KinkyDungeonSetEnemyFlag(data.enemy, "RogueTarget", -1);
        KDDamageQueue.push({ floater: TextGet("KDRogueCritical"), Entity: data.enemy, Color: "#ff5555", Delay: data.Delay });
        data.customCrit = true;
    }
}




// New Attempt!
KDAddEvent(KDEventMapSpell, "launchBullet", "DLSE_Hyperfocus_Passive", (_e, spell, data) => {
    console.log(data);
    let id = "ev_" + _e.type + _e.original + spell.name;
    if (data.bullet
        && (data.b.vx || data.b.vy) // only moving projectiles
        && data.bullet.source == -1 && (!_e.original || !KDBulletHasFlag(data.b, id))
    ) {
        KDSetBulletInheritedFlag(data.b, id, true);
        if (data.bullet.damage) {
            data.b.bullet.damage.damage *= 1 + _e.power; // multiplies damage
        } else {
            if (data.b.bullet.dmgMult == undefined) data.b.bullet.dmgMult = 1;
            data.b.bullet.dmgMult *= 1 + _e.power; // multiplies damage
        }
    }
});


KDAddEvent(KDEventMapSpell, "launchBullet", "DLSE_Hyperfocus_Passive_Static", (_e, spell, data)  => {
    let id = "ev_" + _e.type + _e.original + spell.id;
    if (data.bullet
        && (!data.b.vx && !data.b.vy) // only static projectiles
        && data.bullet.source == -1 && (!_e.original || !KDBulletHasFlag(data.b, id))
    ) {
        KDSetBulletInheritedFlag(data.b, id, true);
        if (data.bullet.damage) {
            data.b.bullet.damage.damage *= 1 + _e.power; // multiplies damage
        } else {
            if (data.b.bullet.dmgMult == undefined) data.b.bullet.dmgMult = 1;
            data.b.bullet.dmgMult *= 1 + _e.power; // multiplies damage
        }
    }
});
