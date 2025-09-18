'use strict';

///////////////////////////////////////////////////////
//                                                   //
//      ///////////////////////////////////////      //
//      //         DLSE - Weapons            //      //
//      ///////////////////////////////////////      //
//                                                   //
///////////////////////////////////////////////////////

//region Whips
/**************************************************
 * Leather Whip
 * 
 * Hier-tier toy that deals severe pain damage.
 * Special Ability - Whip Pull
 *  > A ranged attack that pulls your target in!
 *  > Costs Attack + Stamina cost, as you have to pull your victim in.
 **************************************************/
KinkyDungeonWeapons["DLSE_Whip"] = {
    name: "DLSE_Whip", damage: 3.5, chance: 1.0, staminacost: 3.5,
    tags: ["toy"],
    crit: 1.5, distract: 4, type: "pain", tease: true, unarmed: false, rarity: 2, shop: false, sfx: "Whip",
    angle: 0,                                   // Angle when rendered on player appearance (Telekinesis)

    // Make Ranged attacks! Whips are long.
    special: {type: "spell", spell: "DLSE_WhipPull", range: 3.99},
    //special: {type: "spell", spell: "Charge", range: 2.99},           // You can give a weapon Charge with this line of code, super neat!

    // Off-Hand effect. Might remove.
    events: [
        {type: "ElementalEffectStamCost", trigger: "playerAttack", power: 1, damage: "pain", offhand: true, offhandonly: true, cost: 0.8, sfx: "Whip"},
        // Whip VFX
        {type: "CastSpell", spell: "DLSE_WhipStrike", trigger: "playerAttack", requireEnergy: false},
    ],
}

// Whip Code
/////////////////
let DLSE_WhipStrike = {
    name: "DLSE_WhipStrike", tags: ["earth", "offense", "utility"], school: "Elements", components: [], level:1,
    type:"hit", onhit:"instant", power: 0, range: 3.99, size: 1, aoe: 0, damage: "inert",
}
KinkyDungeonSpellListEnemies.push(DLSE_WhipStrike);

// Spell cast by DLSE_Whip's Special
let DLSE_WhipPull = {
    name: "DLSE_WhipPull", tags: ["leather", "utility"], 
    //sfx: "Leather2", 
    school: "Conjure", manacost: 0, components: ["Arms"], level:1, noMiscast: true,
    type:"special", special: "DLSE_WhipPull",
    onhit:"", time:0, power: 1.0, range: 3.99, size: 1, damage: "chain",
    minRange: 1.99,
}
KinkyDungeonSpellListEnemies.push(DLSE_WhipPull);

// Clone of Elastic Grip, but costs SP similar to Charge.
KinkyDungeonSpellSpecials["DLSE_WhipPull"] = (spell, _data, targetX, targetY, tX, tY, entity, _enemy, _moveDirection, _bullet, _miscast, _faction, _cast, _selfCast) => {

    // Get the correct particle for the whip in use..
    let DLSE_Particle = "DLSE_Whip_PullHit";
    if(_data.targetingSpellWeapon.name === "DLSE_WhipIceQueen"){DLSE_Particle = "DLSE_WhipIceQueen_PullHit";}
    if(_data.targetingSpellWeapon.name === "DLSE_WhipTentacle"){DLSE_Particle = "ElasticGripHit";}
    if(_data.targetingSpellWeapon.name === "DLSE_WhipRose"){DLSE_Particle = "DLSE_WhipRose_PullHit";}

    // Need a proper cost, let's copy Charge!
    // TODO - Tell the player how much that they need?
    let cost = KDAttackCost().attackCost + KDSprintCost();
    if(!KinkyDungeonHasStamina(-cost)){
        KinkyDungeonSendTextMessage(8, TextGet("KDChargeFail_NoStamina"), "#ff5555", 1, true);
        return "Fail";
    }

    // Need a clear line to pull the enemy.
    if (!KinkyDungeonCheckPath(entity.x, entity.y, tX, tY, true, false)) {
        KinkyDungeonSendActionMessage(8, TextGet("KinkyDungeonSpellCastFail"+spell.name), "#ff5555", 1);
        return "Fail";
    }
    let en = KinkyDungeonEntityAt(targetX, targetY);
    if (en && !en.player) {
        if (!KDIsImmobile(en)) {
            if (_miscast) return "Miscast";


            // Attack?
            let result = KinkyDungeonLaunchAttack(en, 1);
            // If we interact with something instead, do nothing.
            if (result == "confirm" || result == "dialogue") {return "Fail";}
            // We strike the enemy!  Do cool stuff.
            if (result == "hit" || result == "capture") {


                // Do a bunch of complicated stuff that I copy/pasted.
                //  > Pulls your victim in.

                if (!en.player)
                    KinkyDungeonSendActionMessage(3, TextGet("KinkyDungeonSpellCast"+spell.name), "#88AAFF", 2 + (spell.channel ? spell.channel - 1 : 0));
                let dist = Math.min(KDistEuclidean(en.x - entity.x, en.y - entity.y),
                    Math.max(1, KDPushModifier(4, en))) + 0.01;
                let pullToX = entity.x;
                let pullToY = entity.y;

                KDCreateParticle(en.x, en.y, DLSE_Particle);//"DLSE_Whip_PullHit");
                
                let lastx = en.x;
                let lasty = en.y;

                for (let i = dist; i > 0; i -= 0.2499) {
                    if (KDistChebyshev(pullToX - en.x, pullToY - en.y) > 1.5) {
                        let newX = pullToX + Math.round((en.x - pullToX) * i / dist);
                        let newY = pullToY + Math.round((en.y - pullToY) * i / dist);
                        if (KinkyDungeonMovableTilesEnemy.includes(KinkyDungeonMapGet(newX, newY)) && KinkyDungeonNoEnemy(newX, newY, true)
                        && (KinkyDungeonCheckProjectileClearance(en.x, en.y, newX, newY))) {
                            KDMoveEntity(en, newX, newY, false, true, KDHostile(en));
                            if (en.x != lastx || en.y != lasty) {
                                lastx = en.x;
                                lasty = en.y;
                                KDCreateParticle(en.x, en.y, DLSE_Particle);//"DLSE_Whip_PullHit");
                            }
                            KinkyDungeonSetEnemyFlag(en, "takeFF", 2);
                        }
                    } else break;
                }


                if(_data.targetingSpellWeapon.name === "DLSE_Whip"){KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/Leather2.ogg", undefined, 1);}
                if(_data.targetingSpellWeapon.name === "DLSE_WhipThorn"){KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/Rope4.ogg", undefined, 1);}
                if(_data.targetingSpellWeapon.name === "DLSE_WhipIceQueen"){KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/Rubber2.ogg", undefined, 1);}
                if(_data.targetingSpellWeapon.name === "DLSE_WhipTentacle"){KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/Rubber2.ogg", undefined, 1);}

                KDChangeMana(spell.name, "spell", "cast", -KinkyDungeonGetManaCost(spell));
                KDCreateParticle(en.x, en.y, DLSE_Particle);//"DLSE_Whip_PullHit");

                // Pay the SP cost:
                // NOTE - If we make this spell into an ATTACK, we need to remove the attack cost.
                //KDChangeStamina(spell.name, "spell", "cast", cost);
                KDChangeStamina(spell.name, "spell", "cast", KDSprintCost());

                // Bonus damage
                // if (!en.player)
                //     KinkyDungeonDamageEnemy(en, {
                //         type: spell.damage,//"glue",
                //         damage: spell.power,
                //         time: spell.time,
                //         bind: spell.bind,
                //     }, false, true, undefined, undefined, entity);

                return "Cast";

            }
            // We whiffed.  Do nothing.
            else if (result == "miss") {
                KinkyDungeonSendTextMessage(8, TextGet("KDChargeFail_AttackMiss"), "#ff5555", 1, true);
            }
        } else return "Fail";
    } else return "Fail";
}


/**************************************************
 * Thorn Whip
 * 
 * Mid-tier bondage toy that deals pain/pierce damage.
 * Special Ability - Whip Pull
 *  > A ranged attack that pulls your target in!
 *  > Costs Attack + Stamina cost, as you have to pull your victim in.
 **************************************************/
KinkyDungeonWeapons["DLSE_WhipThorn"] = {
    name: "DLSE_WhipThorn", damage: 2.5, chance: 1.0, staminacost: 3,
    tags: ["toy", "bondage"],
    crit: 1.4, distract: 4, type: "pain", tease: true, unarmed: false, rarity: 2, shop: false, sfx: "Whip",
    angle: 0,                                   // Angle when rendered on player appearance (Telekinesis)

    // Applies vine bondage 
    // TODO - Consider making this exclusive to the special ability. You might need to pay charge/mana/SP for it.

    // TODO - Replace with Vine once it's fixed.
    bind: 2.5, 
    //bindEff: 1,                     // Should let it scale with damage bonuses?
    addBind: true, bindType: "Rope",//bindType: "Vine",

    // Make Ranged attacks! Whips are long.
    special: {type: "spell", spell: "DLSE_WhipPull", range: 3.99},

    events: [
        //{type: "ElementalEffect", trigger: "playerAttack", power: 1.0, damage: "pierce"},                       // Pierce Damage
        {type: "CastSpell", spell: "DLSE_WhipStrike", trigger: "playerAttack", requireEnergy: false},           // Whip crack VFX
    ],
}


/**************************************************
 * Tentacle Lash
 * 
 * Mid-tier bondage toy that deals grope damage and applies slime.
 * Special Ability - Whip Pull
 *  > A ranged attack that pulls your target in!
 *  > Costs Attack + Stamina cost, as you have to pull your victim in.
 **************************************************/
KinkyDungeonWeapons["DLSE_WhipTentacle"] = {
    name: "DLSE_WhipTentacle", damage: 2, chance: 1.25, staminacost: 3, noDamagePenalty: true,
    tags: ["toy", "bondage"],
    crit: 2, type: "grope", unarmed: false, rarity: 3, shop: false, sfx: "DLSE_WhipTentacle",
    angle: 0,                                   // Angle when rendered on player appearance (Telekinesis)
    //distract: 3,                              // Grope damage already does distraction?

    bind: 2.5, 
    //bindEff: 1,//1.2,                         // Really bad idea when the weapon has 200% crit modifier
    addBind: true, bindType: "Slime",

    // Make Ranged attacks! Whips are long.
    special: {type: "spell", spell: "DLSE_WhipPull", range: 4.99},

    events: [
        {type: "CastSpell", spell: "DLSE_WhipStrike", trigger: "playerAttack", requireEnergy: false},           // Whip crack VFX
    ],
}



/**************************************************
 * Ice Queen
 * 
 * Hier-tier toy that deals pain/ice damage.
 * Special Ability - Whip Pull
 *  > A ranged attack that pulls your target in!
 *  > Costs Attack + Stamina cost, as you have to pull your victim in.
 **************************************************/
KinkyDungeonWeapons["DLSE_WhipIceQueen"] = {
    name: "DLSE_WhipIceQueen", damage: 2, chance: 1.25, staminacost: 3.5,
    tags: ["illum","toy"],
    crit: 1.4, distract: 4, type: "pain", tease: true, unarmed: false, rarity: 4, shop: false, sfx: "DLSE_WhipIceQueen",
    magic: true,
    angle: 0,                                   // Angle when rendered on player appearance (Telekinesis)

    // Make Ranged attacks! Whips are long.
    special: {type: "spell", spell: "DLSE_WhipPull", range: 3.99},
    //special: {type: "spell", spell: "Charge", range: 2.99},           // You can give a weapon Charge with this line of code, super neat!

    // Off-Hand effect. Might remove.
    events: [
        {type: "ElementalEffect", trigger: "playerAttack", power: 2.0, damage: "frost"},                        // Ice Damage
        {type: "ElementalEffect", trigger: "playerAttack", power: 0, damage: "ice", time: 4, chance: 0.25},     // Chance to freeze
        {type: "CastSpell", spell: "DLSE_WhipStrike", trigger: "playerAttack", requireEnergy: false},           // Whip crack VFX
        {type: "WeaponLight", trigger: "getLights", power: 3, color: "#92e8c0"},                                // Glows blue
    ],
}



/**************************************************
 * Blooming Agony
 * 
 * High-tier bondage whip that deals pierce damage.
 * Special Ability - Whip Pull
 *  > A ranged attack that pulls your target in!
 *  > Costs Attack + Stamina cost, as you have to pull your victim in.
 **************************************************/
KinkyDungeonWeapons["DLSE_WhipRose"] = {
    name: "DLSE_WhipRose", damage: 4, chance: 1.0, staminacost: 4,
    tags: ["toy", "bondage"],
    crit: 1.5, distract: 4, type: "pierce", tease: true, unarmed: false, rarity: 5, shop: false, sfx: "Whip",
    angle: 0,                                   // Angle when rendered on player appearance (Telekinesis)

    // Applies vine bondage 
    // TODO - Consider making this exclusive to the special ability. You might need to pay charge/mana/SP for it.

    // TODO - Replace with Vine once it's fixed.
    bind: 4, 
    //bindEff: 1,                     // Should let it scale with damage bonuses?
    addBind: true, bindType: "Rope",//bindType: "Vine",

    // Make Ranged attacks! Whips are long.
    special: {type: "spell", spell: "DLSE_WhipPull", range: 4.99},

    events: [
        //{type: "ElementalEffect", trigger: "playerAttack", power: 1.0, damage: "pierce"},                       // Pierce Damage
        {type: "CastSpell", spell: "DLSE_WhipStrike", trigger: "playerAttack", requireEnergy: false},           // Whip crack VFX
    ],
}



//region Halberds
////////////////////////////////////////////////////////
//                                                    //
//      ////////////////////////////////////////      //
//      //         DLSE - Halberds            //      //
//      ////////////////////////////////////////      //
//                                                    //
////////////////////////////////////////////////////////
//
//  Polearms with a "sweet spot" of 2 range.
//  Low crit modifiers.
//  > You cannot usually crit with a sweet spot attack due to how critical attacks work.

/**************************************************
 * Halberd
 * 
 * Polearm that deals heavy slash damage at 2-range.
 * Special Ability - Hew
 *  > A ranged attack that deals full damage.
 **************************************************/
KinkyDungeonWeapons["DLSE_Halberd"] = {name: "DLSE_Halberd", damage: 5.5, chance: 1.0, staminacost: 4.5, type: "slash", unarmed: false, rarity: 2, shop: false,
    sfx: "DLSE_HeavySlash",                         // Strike with the blade
    tags: ["axe"],                                  // TBD - Not sure what tags suit best.
    crit: 1.2,                                      // Base crit rate.
    clumsy: true, 
    //heavy: true, 
    massive: true,       // It's so big...?
    angle: -0.48,                                   // Angle when rendered on player appearance (Telekinesis)
    cutBonus: 0.01,

    // Make Ranged attacks! Whips are long.
    special: {type: "spell", spell: "DLSE_HalberdHew"},

    // At short range, deal 1/3rd as crush damage, but knockback 1.
    events: [
        {type: "DLSE_KnockbackShortRange", trigger: "playerAttack", dist: 1, dlse_dist: 2,},
        {type: "DLSE_DamageMultShortRange", trigger: "beforePlayerAttack", dlse_dist: 2, power: 0.546, damage: "crush", dlse_replacesfx: "HeavySwing",},
        {type: "DLSE_ReduceCostShortRange", trigger: "beforePlayerLaunchAttack", dlse_dist: 2, dlse_mult: 0.66,},
    ],
};

/**************************************************
 * Silver Labrys
 * 
 * Polearm that deals massive slash damage.
 * Special Ability - Giant Swing
 **************************************************/
// Labrynth cosplay weapon
KinkyDungeonWeapons["DLSE_HalberdLabrys"] = {name: "DLSE_HalberdLabrys", damage: 6.5, chance: 1.2, staminacost: 5, type: "slash", unarmed: false, rarity: 4, shop: false,
    sfx: "HeavySwing",                         // Strike with the blade
    tags: ["axe"],                                  // TBD - Not sure what tags suit best.
    crit: 1.2,                                      // Base crit rate.
    clumsy: true, 
    //heavy: true,                                  // Princessy weapon should be less heavy.
    massive: true,                                  // Still massive, though.
    angle: -0.48,                                   // Angle when rendered on player appearance (Telekinesis)
    cutBonus: 0.05,

    // Strike in an arc.
    special: {type: "spell", spell: "DLSE_GiantSwing"},

    events: [
        {type: "DLSE_KnockbackShortRange", trigger: "playerAttack", dist: 1, dlse_dist: 2,},
        {type: "DLSE_DamageMultShortRange", trigger: "beforePlayerAttack", dlse_dist: 2, power: 0.538, damage: "crush", dlse_replacesfx: "HeavySwing",},
        {type: "DLSE_ReduceCostShortRange", trigger: "beforePlayerLaunchAttack", dlse_dist: 2, dlse_mult: 0.7,},
    ],
};

/**************************************************
 * Royal Halberd
 * 
 * Polearm that deals massive slash damage.
 * Special Ability - Heavy Swing
 *  > A ranged attack that deals full damage.
 **************************************************/
KinkyDungeonWeapons["DLSE_HalberdRoyal"] = {name: "DLSE_HalberdRoyal", damage: 8.0, chance: 1.0, staminacost: 7, type: "slash", unarmed: false, rarity: 5, shop: false,
    sfx: "DLSE_HeavySlash",                         // Strike with the blade
    tags: ["axe"],                                  // TBD - Not sure what tags suit best.
    crit: 1.2,                                      // Base crit rate.
    clumsy: true, heavy: true, massive: true,       // It's so big...?
    angle: -0.48,                                   // Angle when rendered on player appearance (Telekinesis)
    cutBonus: 0.05,

    // Make Ranged attacks! Whips are long.
    special: {type: "spell", spell: "DLSE_HalberdHew"},

    // At short range, deal 1/3rd as crush damage, but knockback 1.
    events: [
        {type: "DLSE_KnockbackShortRange", trigger: "playerAttack", dist: 1, dlse_dist: 2,},
        {type: "DLSE_DamageMultShortRange", trigger: "beforePlayerAttack", dlse_dist: 2, power: 0.4375, damage: "crush", dlse_replacesfx: "HeavySwing",},
        {type: "DLSE_ReduceCostShortRange", trigger: "beforePlayerLaunchAttack", dlse_dist: 2, dlse_mult: 0.5,},
    ],
};




//region Colossal Weapons
////////////////////////////////////////////////////////
//                                                    //
//      ////////////////////////////////////////      //
//      //         DLSE - Colossals           //      //
//      ////////////////////////////////////////      //
//                                                    //
////////////////////////////////////////////////////////
//
//  BIG weapons. You basically NEED Iron Blood and something else to manage these.

// Colossal Sword
// 100 Damage, 100 SP, 
KinkyDungeonWeapons["DLSE_ColossalSword"] = {name: "DLSE_ColossalSword",
    damage: 10, chance: 1.2, staminacost: 10, type: "slash", unarmed: false, rarity: 5, shop: false,
    cutBonus: 0.05,                                 // Should it be too awkward to cut with? Or even just dull?
    crit: 1.2,                                      // Base crit rate.
    clumsy: true, heavy: true, massive: true,       // As big as it gets.
	tags: ["sword"],
	sfx: "DLSE_HeavySlash",                         // Thwomp
    //angle: -0.48,                                 // Angle when rendered on player appearance (Telekinesis)

    // Strike in an arc.
    special: {type: "spell", spell: "DLSE_GiantSwingShort"},

    events: [
        // Casting a spell on hit is a potential solution to have VFX
        //{type: "CastSpell", spell: "Tremor", trigger: "playerAttack", requireEnergy: false},
        {type: "ElementalEffect", trigger: "playerAttack", power: 0, damage: "stun", time: 2},
        {type: "DLSE_KnockbackGiantSwing", trigger: "playerAttack", dist: 2},
    ]
}


//region Thrusting Swords
////////////////////////////////////////////////////////
//                                                    //
//      ////////////////////////////////////////      //
//      //     DLSE - Thrusting Swords        //      //
//      ////////////////////////////////////////      //
//                                                    //
////////////////////////////////////////////////////////
// Poke!

/**************************************************
 * Magic Epee
 * 
 * Magic-tier Thrusting Sword
 * Direct upgrade from the Foil.  (8/60 -> 20/70)
 **************************************************/
KinkyDungeonWeapons["DLSE_MagicEpee"] = {
    name: "DLSE_MagicEpee", damage: 2, chance: 2, staminacost: 2, type: "pierce", unarmed: false, rarity: 6, shop: false, sfx: "Miss",
    tags: ["sword"], magic: true,
    crit: 2.0,
    events: [
        {type: "ChangeDamageVulnerable", trigger: "beforePlayerAttack", power: 3.5, damage: "pierce"},
    ],
}

/**************************************************
 * Estoc
 * 
 * 2H Thrusting Sword
 * R1 deals solid poke, while R2 is a devastating slash.
 **************************************************/
KinkyDungeonWeapons["DLSE_Estoc"] = {name: "DLSE_Estoc", damage: 3, chance: 1, staminacost: 4.0, type: "pierce", unarmed: false, rarity: 4, shop: true, sfx: "LightSwing",
    tags: ["sword"],
    crit: 1.5,
    clumsy: true, 
    events: [
        {type: "ChangeDamageVulnerable", trigger: "beforePlayerAttack", power: 6.0, damage: "slash"},
        {type: "DLSE_SwapSFX", trigger: "beforePlayerAttack", prereq: "DLSE_NotVuln", replacesfx: "Miss",},
    ],
}

// Prereq to swap SFX for basic attack.
KDPrereqs["DLSE_NotVuln"] = (enemy, e, data) => {
    return (enemy.vulnerable == 0  &&  !KinkyDungeonFlags.get("DLSB_PerformingFlecheDisplacement"));
}




/**************************************************
 * Freezing Point
 * 
 * Elemental Thrusting Sword
 * Forms a frigid blade over 5 turns. Deals bonus damage with the blade formed.
 * Casts a weapon light when the blade is formed.
 * Special - Launch the blade, dealing Ice damage.  However, the sword is nerfed until it can reform.
 * 
 * I don't want to talk about how this weapon required SEVEN UNIQUE EVENTS and a prereq...
 **************************************************/

// Manually load the textures we need
// To assign texture afterwards - kdpixitex.set("Game/Items/DLSE_FreezingPoint.png", DLSE_FreezingPoint_FormedTex)
let DLSE_FreezingPoint_UnformedTex = null;
let DLSE_FreezingPoint_FormedTex = null;
KDAddEvent(KDEventMapGeneric, "afterModSettingsLoad", "DLSE_FreezingPointLoadTex", (e, data) => {
    let filepath = KDModFiles[KinkyDungeonRootDirectory + "Items/DLSE_FreezingPoint_Alt.png"];
    DLSE_FreezingPoint_FormedTex = KDTex(filepath, true);
    DLSE_FreezingPoint_UnformedTex = KDTex(KDModFiles[KinkyDungeonRootDirectory + "Items/DLSE_FreezingPoint.png"], true);
});
KDAddEvent(KDEventMapGeneric, "afterLoadGame", "DLSE_FreezingPointLoadGame", (e, data) => {
    if(KDGameData.DollLia?.ToyBox){
        // If weapopn is loaded, load the alternate sprite
        if(KDGameData.DollLia.ToyBox.freezingPointLoaded){
            kdpixitex.set("Game/Items/DLSE_FreezingPoint.png", DLSE_FreezingPoint_FormedTex);
        }else{
            kdpixitex.set("Game/Items/DLSE_FreezingPoint.png", DLSE_FreezingPoint_UnformedTex);
        }
    }
});
// Special Reload function for Freezing Point
KDAddEvent(KDEventMapWeapon, "tick", "DLSE_FreezingPointReload", (e, weapon, data) => {
    let player = data.player || KinkyDungeonPlayerEntity;
    if (KDGameData.SlowMoveTurns < 1 && (!e.prereq || !KDPrereqs[e.prereq] || KDPrereqs[e.prereq](player, e, data))) {
        let originalDuration = KinkyDungeonPlayerBuffs[weapon.name + "Load"]?.duration;
        let currentLoad = KDEntityBuffedStat(player, weapon.name + "Load") || 0;
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, {
            id: weapon.name + "Load",
            type: weapon.name + "Load",
            aura: e.color,
            auraSprite: "Reload",
            //buffSprite: true,
            power: Math.min(e.power, currentLoad + data.delta),
            duration: 7,
        });
        // Weapon is loaded
        if (currentLoad >= e.power) {
            if (originalDuration < 9000)
                KinkyDungeonInterruptSleep(); // End wait if we were reloading
            
            // Pay the energy cost, swap weapon sprite and play SFX.
            if(!KDGameData.DollLia.ToyBox.freezingPointLoaded){
                if (e.energyCost){KDChangeCharge(KinkyDungeonPlayerDamage?.name, "weapon", "tick", - e.energyCost);}
                kdpixitex.set("Game/Items/DLSE_FreezingPoint.png", DLSE_FreezingPoint_FormedTex);
                KDGameData.DollLia.ToyBox.freezingPointLoaded = true;
                KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/DLSE_SoftFreeze.ogg", undefined, 0.5);
            }
            KinkyDungeonPlayerBuffs[weapon.name + "Load"].aura = undefined;
            KinkyDungeonPlayerBuffs[weapon.name + "Load"].duration = 9999;

        // Weapon is still loading
        } else {
            KinkyDungeonPlayerBuffs[weapon.name + "Load"].aura = e.color;
            KinkyDungeonPlayerBuffs[weapon.name + "Load"].duration = 7;
            KinkyDungeonPlayerBuffs[weapon.name + "Load"].text = ">" + Math.round(e.power - currentLoad) + "<";
        }
    }
});
// Special Unload function for Freezing Point
KDAddEvent(KDEventMapWeapon, "playerCastSpecial", "DLSE_FreezingPointUnload", (e, weapon, data) => {
    let player = data.player || KinkyDungeonPlayerEntity;
    if (!e.prereq || !KDPrereqs[e.prereq] || KDPrereqs[e.prereq](player, e, data)) {
        let buff = KDEntityGetBuff(player, weapon.name + "Load");
        if (buff) {
            buff.power *= e.mult;
            buff.power += e.power;
            // Swap weapon sprite
            kdpixitex.set("Game/Items/DLSE_FreezingPoint.png", DLSE_FreezingPoint_UnformedTex);
            KDGameData.DollLia.ToyBox.freezingPointLoaded = false;
        }
    }
});
// Special WeaponLight Function
KDAddEvent(KDEventMapWeapon, "getLights", "DLSE_FPWeaponLight", (e, weapon, data) => {
    if(KDGameData.DollLia.ToyBox.freezingPointLoaded){
        data.lights.push({
            brightness: e.power, x: KinkyDungeonPlayerEntity.x, y: KinkyDungeonPlayerEntity.y,
            color: string2hex(e.color || KDBaseWhite)
        });
    }
});
// Special Elemental Damage on Vuln w/Prereq
KDAddEvent(KDEventMapWeapon, "playerAttack", "DLSE_ElementalEffectExtended", (e, weapon, data) => {
    console.log(data)
    console.log(e)
    if (data.enemy && !data.miss && !data.disarm) {
        if (!e.prereq || KDCheckPrereq(data.enemy, e.prereq)){
            if (data.enemy && (!e.chance || KDRandom() < e.chance) && data.enemy.hp > 0 && !KDHelpless(data.enemy)) {
                let damageDealt = e.power;
                if (data.enemy.vulnerable > 0
                    || (KinkyDungeonFlags.get("DLSB_PerformingFlecheDisplacement")  &&  e.isThrustingSword) // Tie into Spellblade Mod
                ) {
                    damageDealt = e.powerVuln;
                };
                KinkyDungeonDamageEnemy(data.enemy, {
                    type: e.damage,
                    crit: e.crit,
                    damage: damageDealt,
                    time: e.time,
                    bind: e.bind,
                    bindEff: e.bindEff,
                    distract: e.distract,
                    desireMult: e.desireMult,
                    distractEff: e.distractEff,
                    bindType: e.bindType,
                    addBind: e.addBind,
                }, false, e.power < 0.5, undefined, undefined, KinkyDungeonPlayerEntity, undefined, undefined, data.vulnConsumed);
                if (e.sfx) {
                    KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/" + e.sfx + ".ogg");
                }
            }
        }
    }
});
// Swap SFX on prereq
KDAddEvent(KDEventMapWeapon, "beforePlayerAttack", "DLSE_SwapSFX", (e, _weapon, data) => {
    if (data.enemy && !data.miss && !data.disarm && data.Damage && data.Damage.damage) {
        if (data.enemy && data.enemy.hp > 0 && !KDHelpless(data.enemy)) {
            if (!e.prereq || KDCheckPrereq(data.enemy, e.prereq)){
                data.Damage.sfx = e.replacesfx;
            }
        }
    }
});

KinkyDungeonWeapons["DLSE_FreezingPoint"] = {name: "DLSE_FreezingPoint",
    damage: 1, chance: 1.0, staminacost: 2.5, type: "pierce", unarmed: false, rarity: 6, shop: false, sfx: "Miss", magic: true,
    crit: 1.5,
    tags: ["illum", "sword"],
    events: [
        {type: "DLSE_ElementalEffectExtended", trigger: "playerAttack", power: 1.0, crit: 1.5, powerVuln: 4.0, time: 5, damage: "frost", prereq: "FPLoaded", isThrustingSword: true,},
        {type: "DLSE_SwapSFX", trigger: "beforePlayerAttack", prereq: "FPLoaded", replacesfx: "LesserFreeze",},
        {type: "DLSE_FPWeaponLight", trigger: "getLights", power: 3, color: "#92e8c0"},
        {type: "DLSE_FreezingPointReload", trigger: "tick", requireEnergy: true, energyCost: 0.03, power: 5, color: KDBaseWhite, prereq: "LightLoad"},
		{type: "DLSE_FreezingPointUnload", trigger: "playerCastSpecial", power: 0, mult: 0},
    ],

    // TODO - Special attack!
    special: {type: "spell", spell: "DLSE_FreezingPoint_Special", prereq: "FPLoaded", range: 6},
}

// Very simple prereq for the special attack
KDPrereqs["FPLoaded"] = (_enemy, _e, _data) => {
    return KDGameData.DollLia.ToyBox.freezingPointLoaded;
}


KinkyDungeonSpellListEnemies.push({
    name: "DLSE_FreezingPoint_Special", color: "#92e8c0", tags: ["ice", "bolt", "offense", "aoe"], sfx: "MagicSlash", hitsfx: "Freeze", school: "Elements", pierceEnemies: true,
    faction: "Player", noMiscast: true,
    staminacost: 3.5,
    noise: 4,
    manacost: 0, components: [], level:1, type:"bolt",
    bulletColor: 0x92e4e8, bulletLight: 4,
    hitColor: 0x92e4e8, hitLight: 7,
    effectTileDurationModTrail: 10, effectTileTrail: {
        name: "Ice",
        duration: 20,
    },
    projectileTargeting:true, onhit:"", time: 3,  power: 6, delay: 0, range: 10, damage: "frost", speed: 3, playerEffect: {name: "Damage"},
    events: [{type: "ElementalOnSlowOrBindOrDrench", trigger: "bulletHitEnemy", damage: "ice", time: 3, power: 0},]
});

/**************************************************
 * Fractured Vessel
 * 
 * Legendary-tier thrusting sword that deals water damage on vulnerable targets.
 * Applies the Drenched status to self and targets hit.
 * Special Ability - ???
 **************************************************/
KinkyDungeonWeapons["DLSE_FracturedVessel"] = {
    name: "DLSE_FracturedVessel", damage: 2.5, chance: 1.3, staminacost: 3.5, type: "pierce", unarmed: false, rarity: 9, shop: false, sfx: "LightSwing",
    magic: true,
    tags: ["sword"],
    crit: 1.5,
    events: [
        {type: "ChangeDamageVulnerable", trigger: "beforePlayerAttack", power: 5.0, damage: "soap"},
        {type: "DLSE_InfiniteBaths", trigger: "playerAttack", duration: 10},
        {type: "DLSE_InfiniteBaths", trigger: "tick",},//offhand: true},
    ],
    angle: 0,       // Sprite is not meant to be rotated.
}

// Apply KDDrenched to target on hit.
KDAddEvent(KDEventMapWeapon, "playerAttack", "DLSE_InfiniteBaths", (e, _weapon, data) => {
    if (data.enemy && !data.miss && !data.disarm) {
        if (data.enemy && (!e.chance || KDRandom() < e.chance) && data.enemy.hp > 0 && !KDHelpless(data.enemy)) {
            let changes = {};
            if (e.duration) changes.duration = e.duration;
            if (e.power) changes.power = e.power;
            KinkyDungeonApplyBuffToEntity(data.enemy, KDDrenched, changes);
            KinkyDungeonApplyBuffToEntity(data.enemy, KDDrenched2, changes);
            KinkyDungeonApplyBuffToEntity(data.enemy, KDDrenched3, changes);
        }
    }
});

// Apply KDDrenched infinitely to self while equipped
KDAddEvent(KDEventMapWeapon, "tick", "DLSE_InfiniteBaths", (e, _weapon, data) => {
    if(!KDEntityHasBuff(KinkyDungeonPlayerEntity,"Drenched")
        || (KDEntityHasBuff(KinkyDungeonPlayerEntity,"Drenched") && !KinkyDungeonPlayerBuffs.Drenched?.DLSE_InfiniteBaths)
    ){
        let changes = {
            infinite:               true,           // Buff is infinite while you have the weapon equipped.
            duration:               9999,           // Duration is 9999 for infinite buffs.
            DLSE_InfiniteBaths:     true,           // Label that this buff was modified by this weapon
        };
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, KDDrenched, changes);
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, KDDrenched2, changes);
        KinkyDungeonApplyBuffToEntity(KinkyDungeonPlayerEntity, KDDrenched3, changes);
    }
});

// Reduce KDDrenched from infinite to 5 turns when not equipped.
KDAddEvent(KDEventMapGeneric, "tick", "DLSE_InfiniteBaths", (e, data) => {
    if(KDEntityHasBuff(KinkyDungeonPlayerEntity,"Drenched")         // If the player is drenched, and...
        && KinkyDungeonPlayerBuffs.Drenched?.DLSE_InfiniteBaths     // ...the drenched buff was modified by the weapon
        && KinkyDungeonPlayerDamage.name != "DLSE_FracturedVessel"    // ...and the weapon is no longer equipped.
    ){
        for(const drenchedBuff of ["Drenched","Drenched2","Drenched3"]){
            KinkyDungeonPlayerBuffs[drenchedBuff].duration = 6;                     // Let buff expire in 5 turns
            KinkyDungeonPlayerBuffs[drenchedBuff].infinite = false;                 // Remove the infinite property
            delete KinkyDungeonPlayerBuffs[drenchedBuff].DLSE_InfiniteBaths;        // Clean up the property
        }
    }
});


//region Weapon Events
///////////////////////////////////////////////////////
//                                                   //
//      ///////////////////////////////////////      //
//      //     DLSE - Weapons Events         //      //
//      ///////////////////////////////////////      //
//                                                   //
///////////////////////////////////////////////////////

/******************************************************
 * Weapon Events
 * 
 * Had to write a few in order to implement the Halberd 
 *  and Whip.
 ******************************************************/

// Do something special IF your target is at e.dlse_dist range or farther. (Chebyshev Distance)
KDEventMapWeapon.beforePlayerAttack["DLSE_DamageMultLongRange"] = (e, _weapon, data) => {
    if (data.enemy && !data.miss && !data.disarm && data.Damage && data.Damage.damage) {
        if (data.enemy && data.enemy.hp > 0 && !KDHelpless(data.enemy)) {
            if ((!e.chance || KDRandom() < e.chance)        // Allow for chance on event to be applied
                // Compute Chebyshev distance, MUST be >= the threshold or it doesn't count.
                && KDistChebyshev(data.enemy.x - KinkyDungeonPlayerEntity.x, data.enemy.y - KinkyDungeonPlayerEntity.y) >= e.dlse_dist)
            {
                let dmgMult = e.power;
                data.Damage.damage = data.Damage.damage * dmgMult;
                if(e.damage) data.Damage.type = e.damage;                                                                   // Switch damage type if specified
                if (e.energyCost) KDChangeCharge(_weapon.name, "weapon", "attack", - e.energyCost);                         // Consume power if specified
                if (e.sfx) KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/" + e.sfx + ".ogg", undefined, e.vol);  // Play SFX if specified
                if (e.dlse_replacesfx) data.Damage.sfx = e.dlse_replacesfx;                                                 // Replace SFX if specified
            }
        }
    }
}

// Do something special IF your target is under e.dlse_dist range. (Chebyshev Distance)
KDEventMapWeapon.beforePlayerAttack["DLSE_DamageMultShortRange"] = (e, _weapon, data) => {
    if (data.enemy && !data.miss && !data.disarm && data.Damage && data.Damage.damage) {
        if (data.enemy && data.enemy.hp > 0 && !KDHelpless(data.enemy)) {
            if ((!e.chance || KDRandom() < e.chance)
                // Compute Chebyshev distance, MUST be < the threshold or it doesn't count.
                && KDistChebyshev(data.enemy.x - KinkyDungeonPlayerEntity.x, data.enemy.y - KinkyDungeonPlayerEntity.y) < e.dlse_dist)
            {
                let dmgMult = e.power;                                                                                      
                data.Damage.damage = data.Damage.damage * dmgMult;                                                          // Modify power
                if (e.damage) data.Damage.type = e.damage;                                                                  // Switch damage type if specified
                if (e.energyCost) KDChangeCharge(_weapon.name, "weapon", "attack", - e.energyCost);                         // Consume power if specified
                if (e.sfx) KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/" + e.sfx + ".ogg", undefined, e.vol);  // Play SFX if specified
                if (e.dlse_replacesfx) data.Damage.sfx = e.dlse_replacesfx;                                                 // Replace SFX if specified
            }
        }
    }
}

// Knockback ONLY if your target is under e.dlse_dist range. (Chebyshev Distance)
KDEventMapWeapon.playerAttack["DLSE_KnockbackShortRange"] =(e, _weapon, data) => {

    if (e.dist && data.enemy && data.targetX && data.targetY && !data.miss && !data.disarm && !KDHelpless(data.enemy)) {
        if (data.enemy.Enemy && !data.enemy.Enemy.tags.unflinching && !data.enemy.Enemy.tags.stunresist && !data.enemy.Enemy.tags.unstoppable && !data.enemy.Enemy.tags.noknockback && !KDIsImmobile(data.enemy)
            // AND if the target is within the specified range.
            && KDistChebyshev(data.enemy.x - KinkyDungeonPlayerEntity.x, data.enemy.y - KinkyDungeonPlayerEntity.y) < e.dlse_dist) {
            let newX = data.targetX + Math.round(e.dist * (data.targetX - KinkyDungeonPlayerEntity.x));
            let newY = data.targetY + Math.round(e.dist * (data.targetY - KinkyDungeonPlayerEntity.y));
            if (KinkyDungeonMovableTilesEnemy.includes(KinkyDungeonMapGet(newX, newY)) && KinkyDungeonNoEnemy(newX, newY, true)
                && (e.dist == 1 || KinkyDungeonCheckProjectileClearance(data.enemy.x, data.enemy.y, newX, newY, false))) {
                KDMoveEntity(data.enemy, newX, newY, false);

                KinkyDungeonSetEnemyFlag(data.enemy, "takeFF", 1);
            }
        }
    }
}

// Kinky Dungeon does not currently have "beforePlayerLaunchAttack" mapped to KDEventMapWeapon.
// Add the mapping, if it does not exist.
if(!KDEventMapWeapon.beforePlayerLaunchAttack){KDEventMapWeapon["beforePlayerLaunchAttack"] = {};}

// Reduce stamina cost if your target is within a certain range.
KDEventMapWeapon["beforePlayerLaunchAttack"]["DLSE_ReduceCostShortRange"] = (e, _spell, data) => {
    if ((!e.prereq || KDCheckPrereq(null, e.prereq, e, data))
    && KDistChebyshev(data.target.x - KinkyDungeonPlayerEntity.x, data.target.y - KinkyDungeonPlayerEntity.y) < e.dlse_dist
    && !KinkyDungeonFlags.get("DLSE_ReduceCostShortRange")) {
        data.attackCost *= e.dlse_mult;
        KinkyDungeonSetFlag("DLSE_ReduceCostShortRange", 1);       // Set the flag for 1 turn.
    }
}

/******************************************************
 * Royal Cleave
 * 
 * Strike a target at range with the full force of the polearm.
 ******************************************************/
// Spell cast a Royal Halberd's special:
let DLSE_HalberdHew = {
    name: "DLSE_HalberdHew", tags: ["leather", "utility"], 
    school: "Conjure", manacost: 0, components: ["Arms"], level:1, noMiscast: true,
    type:"special", special: "DLSE_HalberdHew",
    onhit:"", time:0, power: 1.0, range: 2.99, size: 1, damage: "chain",
    minRange: 1.99,
}
KinkyDungeonSpellListEnemies.push(DLSE_HalberdHew);

// Clone of Elastic Grip, but costs SP similar to Charge.
KinkyDungeonSpellSpecials["DLSE_HalberdHew"] = (spell, _data, targetX, targetY, tX, tY, entity, _enemy, _moveDirection, _bullet, _miscast, _faction, _cast, _selfCast) => {

    // Need a proper cost, let's copy Charge!
    let cost = KDAttackCost().attackCost + KDSprintCost();
    if(!KinkyDungeonHasStamina(-cost)){
        KinkyDungeonSendTextMessage(8, TextGet("KDChargeFail_NoStamina"), "#ff5555", 1, true);
        return "Fail";
    }

    // Need a clear line to strike the enemy.
    // > Current Spear implementation is cheating, it goes THROUGH walls???
    // > Apply this to Spears?
    if (!KinkyDungeonCheckPath(entity.x, entity.y, tX, tY, true, false)) {
        KinkyDungeonSendActionMessage(8, TextGet("KinkyDungeonSpellCastFail"+spell.name), "#ff5555", 1);
        return "Fail";
    }

    let en = KinkyDungeonEntityAt(targetX, targetY);
    if (en && !en.player) {
        if (_miscast) return "Miscast";

        let result = KinkyDungeonLaunchAttack(en, 1);                       // Launch an attack
        if (result == "confirm" || result == "dialogue") {return "Fail";}   // If we interact with something instead, do nothing.
        if (result == "hit" || result == "capture") {                       // We strike the enemy!  Do cool stuff.

            if (!en.player)
                KinkyDungeonSendActionMessage(3, TextGet("KinkyDungeonSpellCast"+spell.name), "#88AAFF", 2 + (spell.channel ? spell.channel - 1 : 0));

            // Pay an extra SP Cost?
            //KDChangeStamina(spell.name, "spell", "cast", KDSprintCost());

            return "Cast";
        }
        // We whiffed.  Do nothing.
        else if (result == "miss") {
            KinkyDungeonSendTextMessage(8, TextGet("KDChargeFail_AttackMiss"), "#ff5555", 1, true);
        }
    } else return "Fail";
}

/******************************************************
 * Giant Swing
 * 
 * Strike targets in an arc.  Clone of Telekinetic Slash with important changes.
 * > Conveniently, this applies the short range bonuses from the weapon.
 * 
 * Issues:
 * > Cannot trigger dialogue. Just accept the friendly fire, really.
 ******************************************************/

// Need a special AoE type for Giant Swing. NOTE - Not rigorously tested, but works for current purposes.
// bx, by - Target location (Static)
// xx, yy - Tested location
// ox, oy - Player location
KDAOETypes["DLSE_SlashChebyshev"] = (bx, by, xx, yy, rad, modifier = "", ox, oy) => {
    let dist = KDistChebyshev(ox-xx , oy-yy);       // Distance between player and tested location
    let dist2 = KDistChebyshev(ox-bx , oy-by);      // Distance between player and target location
    let dist3 = KDistEuclidean(xx-bx, yy-by);       // Distance between tested and target location
    // Special case to reduce aoe in melee
    if (ox == bx && yy == oy) return false;
    if (oy == by && xx == ox) return false;
    //Main case
    return (Math.abs(dist2-dist) < 0.49) 
            && (dist3 <= rad);                      // Limit the size of the AoE
}

// Spell attached to weapon
let DLSE_GiantSwing = {
    name: "DLSE_GiantSwing", //sfx: "FireSpell", // Let weapon SFX play instead
    manacost: 0, components: [], level:1, 
    noMiscast: true,                // Weapon swing - it rolls accuracy, not miscast.
    type:"special", special: "DLSE_GiantSwing_Mundane", aoetype: "DLSE_SlashChebyshev",//"slash", 
    aoe: 1,
    onhit:"", time:0, power: 1.0, size: 1, damage: "crush",
    minRange: 1.99, 
    range: 2.99,
}
KinkyDungeonSpellListEnemies.push(DLSE_GiantSwing);
// Spell attached to weapon
let DLSE_GiantSwingShort = {
    name: "DLSE_GiantSwingShort", //sfx: "FireSpell", // Let weapon SFX play instead
    manacost: 0, components: [], level:1, 
    noMiscast: true,                // Weapon swing - it rolls accuracy, not miscast.
    type:"special", special: "DLSE_GiantSwing_Mundane", aoetype: "DLSE_SlashChebyshev",//"slash", 
    aoe: 1,
    onhit:"", time:0, power: 1.0, size: 1, damage: "crush",
    //minRange: 1.99, 
    range: 1.99,
}
KinkyDungeonSpellListEnemies.push(DLSE_GiantSwingShort);


KDAddEvent(KDEventMapWeapon, "playerAttack", "DLSE_KnockbackGiantSwing", (e, _weapon, data) => {
    // Only work on Giant Swing
    if(KinkyDungeonFlags.get("DLSE_GiantSwinging")){
        if (e.dist && data.enemy && data.targetX && data.targetY && !data.miss && !data.disarm && !KDHelpless(data.enemy)) {
            if (data.enemy.Enemy
                && !data.enemy.Enemy.tags.noknockback
                && !KDIsImmobile(data.enemy)) {

                let dist = e.dist;
                if (data.enemy.Enemy.tags.unflinching || data.enemy.Enemy.tags.stunresist) {
                    dist -= 1;
                }
                if (data.enemy.Enemy.tags.unstoppable) {
                    dist -= 1;
                }

                for (let i = 0; i < dist; i++) {
                    let newX = Math.round(data.enemy.x + (data.enemy.x - KinkyDungeonPlayerEntity.x)
                        / KDistEuclidean(data.enemy.y - KinkyDungeonPlayerEntity.y, data.enemy.x - KinkyDungeonPlayerEntity.x)
                    );
                    let newY = Math.round(data.enemy.y + (data.enemy.y - KinkyDungeonPlayerEntity.y)
                        / KDistEuclidean(data.enemy.y - KinkyDungeonPlayerEntity.y, data.enemy.x - KinkyDungeonPlayerEntity.x)
                        );
                    if (KinkyDungeonMovableTilesEnemy.includes(KinkyDungeonMapGet(newX, newY))
                        && KinkyDungeonNoEnemy(newX, newY, true)) {
                        KDMoveEntity(data.enemy, newX, newY, false);
                        KinkyDungeonSetEnemyFlag(data.enemy, "takeFF", 1);
                        KinkyDungeonRemoveBuffsWithTag(data.enemy, ["displaceend"]);
                    }
                }
            }
        }
    }
});


// Spell special attached to above spell.
// > Meant for non-magical weapons.
KinkyDungeonSpellSpecials["DLSE_GiantSwing_Mundane"] = (spell, data, targetX, targetY, _tX, _tY, entity, _enemy, _moveDirection, _bullet, _miscast, _faction, _cast, _selfCast) => {

    // Need a proper cost, let's copy Charge!
    let halberdCost = KinkyDungeonPlayerDamage.name == "DLSE_ColossalSword" ? 2 * KDAttackCost().attackCost : KDAttackCost().attackCost;
    if(!KinkyDungeonHasStamina(-halberdCost)){
        KinkyDungeonSendTextMessage(8, TextGet("KDChargeFail_NoStamina"), "#ff5555", 1, true);
        return "Fail";
    }

    let tilesHit = [];
    for (let xx = -spell.aoe; xx <= spell.aoe; xx++) {
        for (let yy = -spell.aoe; yy <= spell.aoe; yy++) {
            if (AOECondition(targetX, targetY, targetX+xx, targetY+yy, spell.aoe, "DLSE_SlashChebyshev", entity.x, entity.y)) {
                tilesHit.push({x:targetX + xx, y:targetY+yy});
            }
        }
    }
    let hit = false;
    for (let tile of tilesHit) {
        let en = KinkyDungeonEnemyAt(tile.x, tile.y);
        if (en && !KDAllied(en) && !KDHelpless(en) && en.hp > 0) {
            if (_miscast) return "Miscast";
            if (!hit) {         // Change stamina ONCE and only once.
                //KDChangeMana(spell.name, "spell", "cast", -KinkyDungeonGetManaCost(spell));
                KDChangeStamina(spell.name, "spell", "cast", halberdCost);
            }
            KDTriggerSpell(spell, data, false, false);
            hit = true;
            KinkyDungeonSetFlag("DLSE_GiantSwinging", 1);
            let mod = (KinkyDungeonFlags.get("KineticMastery") ? 1.5 : 0) + KinkyDungeonGetBuffedStat(KinkyDungeonPlayerBuffs, "KinesisBase");
            let scaling = 0.9 * (KinkyDungeonMultiplicativeStat(-KinkyDungeonGetBuffedStat(KinkyDungeonPlayerBuffs, "KinesisScale")));
            let ad = {
                name: KinkyDungeonPlayerDamage.name,
                nodisarm: false,
                damage: spell.power + mod + KinkyDungeonPlayerDamage.damage * scaling,
                type: KinkyDungeonPlayerDamage.type,
                distract: KinkyDungeonPlayerDamage.distract,
                distractEff: KinkyDungeonPlayerDamage.distractEff,
                desireMult: KinkyDungeonPlayerDamage.desireMult,
                bind: KinkyDungeonPlayerDamage.bind,
                bindType: KinkyDungeonPlayerDamage.bindType,
                bindEff: KinkyDungeonPlayerDamage.bindEff,
                ignoreshield: KinkyDungeonPlayerDamage.ignoreshield,
                shield_crit: KinkyDungeonPlayerDamage.shield_crit, // Crit thru shield
                shield_stun: KinkyDungeonPlayerDamage.shield_stun, // stun thru shield
                shield_freeze: KinkyDungeonPlayerDamage.shield_freeze, // freeze thru shield
                shield_bind: KinkyDungeonPlayerDamage.shield_bind, // bind thru shield
                shield_snare: KinkyDungeonPlayerDamage.shield_snare, // snare thru shield
                shield_slow: KinkyDungeonPlayerDamage.shield_slow, // slow thru shield
                shield_distract: KinkyDungeonPlayerDamage.shield_distract, // Distract thru shield
                shield_vuln: KinkyDungeonPlayerDamage.shield_vuln, // Vuln thru shield
                boundBonus: KinkyDungeonPlayerDamage.boundBonus,
                novulnerable: KinkyDungeonPlayerDamage.novulnerable,
                tease: KinkyDungeonPlayerDamage.tease};
            data = {
                target: en,
                attackCost: 0.0, // Important
                attackCostOrig: 0.0,
                skipTurn: false,
                spellAttack: true,
                attackData: ad
            };
            if (KinkyDungeonPlayerDamage.stam50mult && KinkyDungeonStatMana/KinkyDungeonStatManaMax >= 0.50) {
                data.attackData.damage *= KinkyDungeonPlayerDamage.stam50mult;
            }
            KinkyDungeonSendEvent("beforePlayerLaunchAttack", data);

            // Attack the enemy, rolling your accuracy against their evasion.
            // > Significant change from Telekinetic Slash, which floors your hit chance at 100%.
            // NOTE: If you make a magical Halberd, need to set the fourth argument to True.  (IsMagic)
            KinkyDungeonAttackEnemy(en, data.attackData, KinkyDungeonGetEvasion(undefined, false, false, false));//Math.max(1, KinkyDungeonGetEvasion(undefined, false, false, false)));
        }
    }
    if (hit) {
        if (KinkyDungeonStatsChoice.has("BerserkerRage")) {
            KDChangeDistraction(spell.name, "spell", "cast", 0.7 + 0.5 * KinkyDungeonGetManaCost(spell), false, 0.33);
        }
        if (!KDEventData.shockwaves) KDEventData.shockwaves = [];
        KDEventData.shockwaves.push({
            x: targetX,
            y: targetY,
            radius: 1.5,
            sprite: "Particles/Slash.png",
        });
        KinkyDungeonSendActionMessage(3, TextGet("KinkyDungeonSpellCast"+spell.name), "#88AAFF", 2 + (spell.channel ? spell.channel - 1 : 0));
        return "Cast";
    }

    return "Fail";
}

//region stamPenType
///////////////////////////////////////////////////////
//                                                   //
//      ///////////////////////////////////////      //
//      //       DLSE - stamPenType          //      //
//      ///////////////////////////////////////      //
//                                                   //
///////////////////////////////////////////////////////

// This controls stamina penalties on swing.
// ISSUE - Could not figure out how to determine closeness to the enemy.

// Create our own.
// KDSTAMPENTYPE.DLSE_HeavyWeapon = {
//     onAttack: (data) => {
//         console.log(data);
//         // Reduce the stamina cost of the swing.
//         // NOTE: This will still show the "not enough stamina" warning, but you can still melee.
//         data.attackCost *= 0.5;
//     },

//     // TODO - Make this just copy from KDSTAMPENTYPE.Weapon
//     onEvasion: (data) => {
//         let perk = "Focused";
//         let focusStat = "WepDPAccPenalty";
//         let accPenMult = KinkyDungeonMultiplicativeStat(-KDEntityBuffedStat(KDPlayer(), focusStat)
//             + (KinkyDungeonStatsChoice.get(perk) ? 9 : 0))
//         let amount = 1;
//         let dist = KinkyDungeonStatDistraction / KinkyDungeonStatDistractionMax;
//         if (dist >= KDUnfocusedParams.ThreshMin) {
//             amount = (1 - accPenMult*KDUnfocusedParams.AmountMin)
//             + ((1 - accPenMult*KDUnfocusedParams.AmountMax) - (1 - accPenMult*KDUnfocusedParams.AmountMin))
//                 * (dist - KDUnfocusedParams.ThreshMin)
//             / (KDUnfocusedParams.ThreshMax - KDUnfocusedParams.ThreshMin);
//         }
//         if (amount != 1) data.hitmult *= amount;
//     },
// }