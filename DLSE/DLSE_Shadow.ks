'use strict';

///////////////////////////////////////////////////////
//                                                   //
//      ///////////////////////////////////////      //
//      // DollLia's Shadow Spells Expansion //      //
//      ///////////////////////////////////////      //
//                                                   //
///////////////////////////////////////////////////////


/****************************************************************
 * Example Spell - Upcasted Shadow Dagger "Fanning Knives"
 * 
 * Overly-Commented example spell, to use as reference for later.
 ****************************************************************/

// Step 1.) Spell Code
// Dagger Fan Variant
// Currently 50 mana for 50 damage.
let DLSE_DaggerUpcast = {
    name: "DLSE_DaggerFan",                     // Name to pass to KinkyDungeonLearnableSpells
    prerequisite: "Dagger",                     // Prerequisite Spell
    upcastFrom: "Dagger", upcastLevel: 1,
    tags: ["aoe","bolt", "shadow", "offense"],        // Spell Tags - Necessary for filtering and some effects.
    sfx: "MagicSlash",                          // Cast Sound Effect
    school: "Illusion",                         // Spell School
    manacost: 3,                                // Mana Cost (This value is multiplied by 10)
    components: ["Arms"], 
    level:1, 
    type:"bolt", 
    projectileTargeting:true, 
    noDoubleHit: true, 
    piercing: true, 
    noTerrainHit: true,                         // Removes the VFX showing on piercing terrain
    onhit:"", 
    power: 2.5, 
    time: 0, 
    delay: 0, 
    range: 5, 
    damage: "cold", 
    speed: 2, 
    playerEffect: {name: "Damage"},

    // Tight Spread
    //shotgunCount: 4, shotgunDistance: 4, shotgunSpread: 1, shotgunSpeedBonus: 1,


    // Even Fan of Knives
    shotgunCount: 5,                            // Number of shotgun projectiles
    shotgunDistance: 6,                         // NO IDEA what this does
    shotgunSpread: .5,                          // 
    shotgunSpeedBonus: 1,                       // ???
    shotgunFan: true,                           // Makes it an even spread
    noUniqueHits: true,                         // Prevents targets from being hit by multiple daggers

    // Testing
    // hitevents: [
    //     {trigger: "bulletHitEnemy", type: "ShadowSlash"},
    // ],


}

// Step 2.) Push your spell into KinkyDungeonLearnableSpells[][]
/*************************************************************
 * First [] - Spell Category
 * 0 - ALL Spells               4 - Elements
 * 1 - Spell Categories         5 - Conjuration
 * 2 - Unique                   6 - Illusion
 * 3 - Upgrades
 * 
 * Second [] - Spell Component
 * 0 - Verbal                   2 - Legs
 * 1 - Arms                     3 - Passive
 */
// Push the name of the Spell into Illusion, in the Arms component section
// * NOTE: Using splice to put this upcast of Dagger after Dagger in the spell list.
//KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("Dagger")+1),0,"DLSE_DaggerFan");

// Step 3.) Push the Spell into KinkyDungeonSpellList, in the correct category.
KinkyDungeonSpellList["Illusion"].push(DLSE_DaggerUpcast);

// Step 4.) Add the following String Data entries to a CSV file, replacing <SPELLNAME> with the name of your spell above.
// * KinkyDungeonSpell<SPELLNAME>               // Name of the spell
// * KinkyDungeonSpellDescription<SPELLNAME>    // Description of the spell in Spellbook
// * KinkyDungeonSpellCast<SPELLNAME>           // Text displayed when you cast the spell

//Step 5.) Sprites
// * Spells/<SPELLNAME>.png                     // Sprite of the spell in your UI 
// * Bullets/<SPELLNAME.png                     // Sprite of the spell's projectile





/**********************************************************
 * Spell - Whirling Scythe
 * > Cost - 50MP            > Prerequisite - Blessing of Shadow
 * > Damage - 50 Shadow     > Components - Arms
 * 
 * Upcast your Shadow Slash to project it into the distance!
 **********************************************************/

// Hits immediately.
// > Has a bug where certain angles will make the blade take an extra turn to land.  Awkward.
let DLSE_ShadowSlashUpcast = {
    name: "DLSE_ShadowSlashLv2", 
    tags: ["aoe", "offense", "shadow"], 
    prerequisite: "ShadowSlash", 
    upcastFrom: "ShadowSlash", upcastLevel: 1,
    sfx: "Evil", school: "Illusion", manacost: 4.5, components: ["Arms"], level:1, 
    type:"bolt", projectileTargeting:true, piercing: true, noTerrainHit: true, noEnemyCollision: true, 
    onhit:"aoe", 
    power: 5, 
    delay: 0, // Does Nothing
    range: 3.99,                // Range at which the projectile expires and casts the burst
    minRange: 2.5,              // Changes the targeting area, to tell the player that this spell has a BIG minimum range
    aoe: 1.5, size: 3, lifetime:1, damage: "cold", speed: 3, time: 2,
    hitevents: [
        {trigger: "bulletHitEnemy", type: "ShadowSlash"},
    ],
    trailspawnaoe: 0, trailPower: 0, trailLifetime: 1, trailHit: "", trailDamage:"inert", trail:"lingering", trailChance: 1,
    bulletSpin: 0.5,    // Also makes the trail spin, odd.
    hitSpin: 1.5,       // Spin of On-Hit VFX
}
KinkyDungeonSpellList["Illusion"].push(DLSE_ShadowSlashUpcast);


/**********************************************************
 * Spell - Shadowblade
 * > Cost - 13MP                > Prerequisite - Blessing of Shadow
 * > Damage - 15/30 Shadow      > Components - Passive
 * 
 * Boosts damage of weapons, and cut power of tools.  2x effect if in Shadow.
 **********************************************************/

let DLSE_Darkblade = {
    name: "DLSE_Darkblade", tags: ["shadow", "struggle", "buff", "utility", "offense"], prerequisite: "ApprenticeShadow", 
    fx: "FireSpell", school: "Illusion", manacost: 1.3, components: [], level:1, type:"passive", 

    // ElementalEffect is duplicated for compatibility with Shadow's Edge.
    events: [
        {type: "DLSE_ElementalEffectShadowBonus", power: 1.5, damage: "cold", trigger: "playerAttack", dlse_mult: 2, prereq: "wepDamageType", kind: "melee",},
        {type: "DLSE_ElementalEffectShadowBonus", power: 1.5, damage: "cold", trigger: "playerAttack", dlse_mult: 2, prereq: "wepDamageType", kind: "cold",},
        // Unsure what multiplier is balanced.  1.25/1.5 seemed way too much, but was the Super Strength setting
        {type: "DLSE_ModifyStruggleInShadow", mult: 1.15, power: 0.1, StruggleType: "Cut", trigger: "beforeStruggleCalc", msg: "KinkyDungeonSpellDLSE_DarkbladeStruggle", dlse_mult: 1.3, dlse_power: 0.2},
    ],


}

//KDEventMapSpell.tick["DLSE_Darkblade"] = 



//{id: "Cutting2", type: "BoostCuttingMinimum", duration: 10, power: 0.8, player: true, enemies: false, tags: ["struggle", "allowCut"]}

//////////////////////////////////////////////////////////////////////////////////////
// Boost DLSE_Darkblade's effectiveness while the player is in Shadow.              //
//////////////////////////////////////////////////////////////////////////////////////

// bugfixing existing prereq
// TODO - Delete once PR is accepted
// KDPrereqs["wepDamageType"] = (_enemy, e, data) => {
//     switch (e.kind) {
//         case "melee": return KinkyDungeonMeleeDamageTypes.includes(KinkyDungeonPlayerDamage?.type);
//         case "magic": return !KinkyDungeonMeleeDamageTypes.includes(KinkyDungeonPlayerDamage?.type);
//     }
//     return data.damage?.type == e.kind;
// }

// Apply an extra damage to the attack, multiplied if you are in shadow
KDEventMapSpell.playerAttack["DLSE_ElementalEffectShadowBonus"] = (e, spell, data) => {
    if ((!data.bullet || e.bullet) && KinkyDungeonHasMana(e.cost != undefined ? e.cost : KinkyDungeonGetManaCost(spell, false, true)) && !data.miss && !data.disarm && data.targetX && data.targetY && data.enemy && KDHostile(data.enemy)
        // Require the use of a weapon, OR Brawler perk.
        && ((KinkyDungeonPlayerDamage.name && KinkyDungeonPlayerDamage.name != "Unarmed") || KinkyDungeonStatsChoice.get("Brawler"))){
        if (KDCheckPrereq(null, e.prereq, e, data)) {
            KDChangeMana(spell.name, "spell", "attack", -(e.cost != undefined ? e.cost : KinkyDungeonGetManaCost(spell, false, true)));
            KDTriggerSpell(spell, data, false, true);

            let shadowBladeDmg = e.power;
            // Double power if player is in shadow
            if ((!e.chance || KDRandom() < e.chance) && (KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y) <= 1.5)
                || KDEffectTileTags(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y).darkarea        
                || KinkyDungeonBrightnessGet(data.enemy.x, data.enemy.y) <= 1.5     // Or the enemy is in shadow
                || KDEffectTileTags(data.enemy.x, data.enemy.y).darkarea)           // Of the enemy is in a darkarea tile
            {
                shadowBladeDmg *= e.dlse_mult;
            }

            KinkyDungeonDamageEnemy(data.enemy, {
                type: e.damage,
                damage: shadowBladeDmg,//e.power,
                time: e.time,
                bind: e.bind,
                distract: e.distract,
                bindType: e.bindType,
                addBind: e.addBind,
                bindEff: e.bindEff,
            }, false, e.power < 0.5, undefined, undefined, KinkyDungeonPlayerEntity);
        }
    }
},
// Improve struggling while in shadow.
KDEventMapSpell.beforeStruggleCalc["DLSE_ModifyStruggleInShadow"] = (e, spell, data) => {
    console.log(data);
    if (KinkyDungeonHasMana(KinkyDungeonGetManaCost(spell, false, true)) && data.escapeChance != undefined && (!e.StruggleType || e.StruggleType == data.struggleType)) {
        if (!data.query) {
            KDChangeMana(spell.name, "spell", "struggle", -KinkyDungeonGetManaCost(spell, false, true));
            KDTriggerSpell(spell, data, false, true);
        }
        if ((!e.chance || KDRandom() < e.chance) && (KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y) <= 1.5)
            || KDEffectTileTags(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y).darkarea    // OR the player is in a darkarea tile
        ){
            if (e.mult && data.escapeChance > 0)
                data.escapeChance *= e.dlse_mult;
            if (e.power)
                data.escapeChance += e.dlse_power;
    
            if (!data.query)
                if (e.msg) {
                    KinkyDungeonSendTextMessage(10 * e.dlse_power, TextGet(e.msg), "lightgreen", 2);
                }
        }else{
            if (e.mult && data.escapeChance > 0)
                data.escapeChance *= e.mult;
            if (e.power)
                data.escapeChance += e.power;
    
            if (!data.query)
                if (e.msg) {
                    KinkyDungeonSendTextMessage(10 * e.power, TextGet(e.msg), "lightgreen", 2);
                }
        }

        // Let Darkblade counter magical restraints
        data.canCutMagic = true;
    }
}



// Insert into the Spell List
KinkyDungeonSpellList["Illusion"].push(DLSE_Darkblade);


// EXPERIMENTAL - May not keep.  It's a bit boring.
/**********************************************************
 * Spell - Wicked Edges
 * > Cost - NULL                    > Prerequisite - Blessing of Shadow
 * > Damage - 30-60 Shadow Bleed    > Components - Passive
 * 
 * Shadow damage inflicts a shadow bleed for 10 turns.
 * Tick damage is doubled in shadow.
 **********************************************************/
let DLSE_WickedEdges = {name: "DLSE_WickedEdges", tags: ["shadow", "offense"], prerequisite: "ApprenticeShadow", school: "Illusion", spellPointCost: 2, manacost: 0, components: [], level:1, passive: true, type:"", onhit:"", time: 0, delay: 0, range: 0, lifetime: 0, power: 0, damage: "inert", events: [
    {type: "DLSE_WickedEdges", trigger: "beforeDamageEnemy", damage: "cold"},
]}
KinkyDungeonSpellList["Illusion"].push(DLSE_WickedEdges);

KDEventMapSpell.beforeDamageEnemy["DLSE_WickedEdges"] = (e, _spell, data) => {
    if (data.enemy && (!data.flags || !data.flags.includes("BurningDamage")) && data.dmg > 0 && (!e.damage || e.damage == data.type)) {
        if ((!e.chance || KDRandom() < e.chance)) {
            KinkyDungeonApplyBuffToEntity(data.enemy, DLSE_WickedEdgesBuff);
        }
    }
}

let DLSE_WickedEdgesBuff = {
    id: "DLSE_WickedEdges", type: "event", 
    aura: "#6d0082", aurasprite: "AuraSeal", //noAuraColor: true, 
    power: 0.3, duration: 10, player: true, enemies: true, 
    events: [
        {trigger: 'tick', type: 'UnShadowElementalEffect', damage: "cold", power: 0.3},
        {trigger: 'tick', type: 'ShadowElementalEffect', damage: "cold", power: 0.6},
    ]
};



// EXPERIMENTAL
/**********************************************************
 * Spell - Shroud Redux
 * > Cost - NULL                    > Prerequisite - Blessing of Shadow
 * > Damage - 30-60 Shadow Bleed    > Components - Passive
 * 
 * Shadow damage inflicts a shadow bleed for 10 turns.
 * Tick damage is doubled in shadow.
 **********************************************************/
let DLSE_Shroud = {name: "DLSE_Shroud", prerequisite: "ApprenticeShadow", tags: ["aoe", "buff", "utility", "shroud", "defense"], sfx: "Fwoosh", school: "Illusion", manacost: 5, components: ["Verbal"], level:1, type:"inert",
    noise: 3.5,// Attracts some enemies
    buffs: [
        {id: "Shroud", type: "Evasion", power: 7.0, player: true, enemies: true, tags: ["darkness"], range: 1.5},
        {id: "Shroud2", aura: "#444488", type: "Sneak", power: 4.0, player: true, duration: 8, enemies: false, tags: ["darkness"], range: 1.5}
    ], onhit:"", time:8, aoe: 1.5, power: 0, delay: 8, range: 4.5, size: 3, damage: "",
    effectTileDurationModPre: 3, effectTilePre: {
        name: "DLSE_Void",
        duration: 8,
    }}

// Insert into the Spell List
// KinkyDungeonSpellList["Illusion"].push(DLSE_Shroud);
// KinkyDungeonLearnableSpells[6][0].push("DLSE_Shroud");


KDEffectTiles["DLSE_Void"] = {
    name: "DLSE_Void",
    duration: 2,
    priority: 4,
    tags: ["smoke", "brightnessblock", "darkarea", "wet", "visionblock"],
}

KDEffectTileTooltips['DLSE_Void'] = {
    color: "#4f2a9c",
    code: (tile, _x, _y, TooltipList) => {KDETileTooltipSimple(tile, TooltipList, "#5d33be");}
}