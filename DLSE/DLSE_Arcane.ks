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
    autoLearn: ["DLSE_Hyperfocus2"],
    manacost: 4, defaultOff: true, time: 10, components: ["Arms"], level:1, type:"passive",
    events: [
        {type: "DLSE_Hyperfocus", trigger: "toggleSpell", power: 12, time: 10},
    ]
}

// Invisible passive that handles tracking beforeCrit event
let DLSE_Hyperfocus_Passive = {
    name: "DLSE_Hyperfocus2", manacost: 0, components: [], level:1, passive: true, type:"", onhit:"", time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert",
    hideLearned: true, hideWithout: "DLSE_Hyperfocus",
    events: [
        {type: "DLSE_Hyperfocus2", trigger: "beforeCast"},
        {type: "DLSE_Hyperfocus2", trigger: "beforeCrit"},
        {type: "DLSE_Hyperfocus2", trigger: "duringCrit", mult: 1.5},
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

// New attempt
KDEventMapSpell.beforeCast["DLSE_Hyperfocus2"] = (_e, _spell, data) => {
    data.flags["DLSE_Meow"] = true
    console.log("Data - Before Cast:")
    console.log(data)
    // if (data.spell && data.spell.tags?.includes("trapReducible") && data.channel) {
    //     data.channel = 0;
    // }
}

KDEventMapSpell.beforeCrit["DLSE_Hyperfocus2"] = (_e, _spell, data) => {
    console.log("Data - Before Crit:")
    console.log(data);
    if (data.faction == "Player" && data.spell && KDEntityHasBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus")) {
        data.forceCrit = true;
        //KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus");
    }
}

KDEventMapSpell.duringCrit["DLSE_Hyperfocus2"] = (e, _spell, data) => {
    console.log("Data - During Crit:")
    console.log(data);
    if (data.dmg > 0 && data.critical && data.enemy
        //&& data.attacker?.player          // Prevents spells from super-critting
        && !data.attacker
        && !data.customCrit && KDHostile(data.enemy) 
        //&& !KDEnemyHasFlag(data.enemy, "RogueTarget")
        && KDEntityHasBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus")
    ) {
        data.crit *= e.mult;
        data.bindcrit *= e.mult;
        //KinkyDungeonSetEnemyFlag(data.enemy, "RogueTarget", -1);
        KDDamageQueue.push({ floater: TextGet("KDRogueCritical"), Entity: data.enemy, Color: "#ff5555", Delay: data.Delay });
        data.customCrit = true;
        console.log(KinkyDungeonPlayerBuffs)
        //KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity, "DLSE_Hyperfocus");
        // shitty solution
        // TODO - Check if dur is 1, then don't do this or the expire buff.
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
            id: "DLSE_Hyperfocus", 
            type: "DLSE_Hyperfocus",
            power: 1,
            duration: 1, 
            aura: "#ff0000", 
            //sfx: "FireSpell",
        });
    }
}

// KinkyDungeonSpellList["Illusion"].push(DLSE_Hyperfocus);
// KinkyDungeonSpellList["Illusion"].push(DLSE_Hyperfocus_Passive);
// KinkyDungeonLearnableSpells[6][1].push("DLSE_Hyperfocus");