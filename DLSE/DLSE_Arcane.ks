'use strict';
///////////////////////////////////////////////////////
//                                                   //
//      ///////////////////////////////////////      //
//      // DollLia's Arcane Spells Expansion //      //
//      ///////////////////////////////////////      //
//                                                   //
///////////////////////////////////////////////////////

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
    manacost: 4, defaultOff: true, time: 10, components: ["Arms"], level:1, type:"passive",
    events: [
        {type: "DLSE_Hyperfocus", trigger: "toggleSpell", power: 12, time: 10},
    ]
}



// TODO - Make this work if this exists later on
KDEventMapSpell.spellCast = {}


// Invisible passive that handles tracking beforeCrit event
let DLSE_Hyperfocus_Passive = {
    name: "DLSE_Hyperfocus_Passive", manacost: 0, components: [], level:1, passive: true, type:"", onhit:"", time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert",
    hideLearned: true, hideWithout: "DLSE_Hyperfocus",
    events: [
        //{type: "DLSE_Hyperfocus_Passive", trigger: "beforeCast"},
        {type: "DLSE_Hyperfocus_Passive", trigger: "beforeCrit"},
        {type: "DLSE_Hyperfocus_Passive", trigger: "duringCrit", mult: 1.5},
    ]
}

// Dummy spell to roll miscast chances with. Spends mana on success.
let DLSE_HyperfocusTest = {
    name: "DLSE_HyperfocusTest", tags: ["knowledge", "aoe", "offense"], school: "Illusion", 
    components: ["Arms"], level:1, manacost: 4, 
    onhit:"", time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert", type:"passive",
}

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

// NOTE - Detached from Hyperfocus_Passive, as it does nothing.
// _spell here is DLSE_Hyperfocus_Passive
KDEventMapSpell.beforeCast["DLSE_Hyperfocus_Passive"] = (_e, _spell, data) => {
//     console.log("Data - Before Cast")
//     console.log(data)
}

// Event to force any spell to crit IF you have the buff.
KDEventMapSpell.beforeCrit["DLSE_Hyperfocus_Passive"] = (_e, _spell, data) => {
    // console.log("Data - Before Crit:")
    // console.log(data)
    if (data.faction == "Player" && data.spell
        && (!data.spell.tags?.includes("dot"))
        && KDEntityHasBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus")) {
        data.forceCrit = true;
        data.meow = true;
        // Set the buff's duration to 0, so that it expires after the turn ends.
        if(KinkyDungeonPlayerBuffs.DLSE_Hyperfocus.duration > 0){
            KinkyDungeonPlayerBuffs.DLSE_Hyperfocus.duration = 0;
        }
    }
}

KDEventMapSpell.duringCrit["DLSE_Hyperfocus_Passive"] = (e, _spell, data) => {
    // console.log("Data - During Crit:")
    // console.log(data);
    if (data.dmg > 0 && data.critical && data.enemy
        //&& data.attacker?.player          // Prevents spells from super-critting
        && !data.attacker
        && !data.customCrit //&& KDHostile(data.enemy) 
        //&& !KDEnemyHasFlag(data.enemy, "RogueTarget")
        && KDEntityHasBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus")
    ) {
        data.crit *= e.mult;
        data.bindcrit *= e.mult;
        //KinkyDungeonSetEnemyFlag(data.enemy, "RogueTarget", -1);
        KDDamageQueue.push({ floater: TextGet("KDRogueCritical"), Entity: data.enemy, Color: "#ff5555", Delay: data.Delay });
        data.customCrit = true;
    }
}

KinkyDungeonSpellList["Illusion"].push(DLSE_Hyperfocus);
KinkyDungeonSpellList["Illusion"].push(DLSE_Hyperfocus_Passive);
KinkyDungeonLearnableSpells[6][1].push("DLSE_Hyperfocus");