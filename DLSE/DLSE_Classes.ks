'use strict'


//////////////////////////////////////////////////////////////////
// Silent Assassin                                              //
// Increase sneak by 30% if the player is completely gagged.    //
//////////////////////////////////////////////////////////////////
let DLSE_SilentAssassin = {
    name: "DLSE_SilentAssassin",
    tags: ["buff", "utility"], school: "Special", spellPointCost: 1, manacost: 0, components: [], level: 1, passive: true, type: "", onhit: "",
    time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert",
    events: [{type: "DLSE_SilentAssassin", trigger: "tick",}],
    classSpecific: "Rogue", prerequisite: "RogueTargets", hideWithout: "RogueTargets", // Rogue-exclusive
}

KDEventMapSpell.tick["DLSE_SilentAssassin"] = (e, spell, data) => {
    let sneakBuff = 0                           // Sneak buff is default to 0
    let spellCheck = {components: ["Verbal"]}   // Dummy spell to test Verbal component
    // Check if fully gagged
    if (KinkyDungeoCheckComponents(spellCheck).failed.length > 0) {
        sneakBuff = 1.3;
    }
    // Check if partially gagged
    // Length was acting strangely, so checking if Verbal is in it.
    else if(KinkyDungeoCheckComponentsPartial(spellCheck).includes("Verbal")){
        sneakBuff = 1.15;
    }
    // If we have a sneakBuff, apply it to the user.
    if(sneakBuff){
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
            id:         "DLSE_SilentAssassin",
            type:       "Sneak",
            power:      sneakBuff,
            duration:   1,
            infinite:   true,
            player:     true,
            enemies:    false,
            count:      1,
            events:     []
        }) 
    }
    // Else, expire it.
    else{
        KinkyDungeonExpireBuff(KinkyDungeonPlayerEntity, "DLSE_SilentAssassin");
    }
}
// Add to spell lists
KinkyDungeonSpellList["Special"].push(DLSE_SilentAssassin);
//KinkyDungeonLearnableSpells[2][3].push("DLSE_SilentAssassin")
//KinkyDungeonLearnableSpells[2][3].splice((KinkyDungeonLearnableSpells[2][3].indexOf("RogueStudy")+1),0,"DLSE_SilentAssassin");
