'use strict';

///////////////////////////////////////////////////////
//                                                   //
//      ///////////////////////////////////////      //
//      //     DLSE - Teasing Weapons        //      //
//      ///////////////////////////////////////      //
//                                                   //
///////////////////////////////////////////////////////

// Extend KDWeaponNoDamagePenalty to handle hybrid weapon/toy items.
let KDWeaponNoDamagePenalty_OLD = KDWeaponNoDamagePenalty;
KDWeaponNoDamagePenalty = (weapon) => {
    // If the weapon has a flag to determine damage penalty, check that first
    if(KDWeapon({name: weapon.name})?.noDamagePenalty_Flag){
        return KinkyDungeonFlags.get(KDWeapon({name: weapon.name})?.noDamagePenalty_Flag) !== undefined
    }
    // Otherwise, run the old function.
    else{return KDWeaponNoDamagePenalty_OLD(weapon);}
}




//region Teasing Weapons
/**************************************************
 * Inquisitor's Mace
 * 
 * Hier-tier toy that can deal crush damage OR charm damage (magic)
 *  > This lets you change the weapon from physical to magical.
 * Special Ability - Toggle On/Off
 *  > Change the damage that the weapon deals.
 **************************************************/
KinkyDungeonWeapons["DLSE_MaceInquisitor"] = {
    name: "DLSE_MaceInquisitor", damage: 3.0, chance: 1.0, staminacost: 3, type: "crush", unarmed: false, rarity: 4, shop: false, sfx: "HeavySwing",
    tags: ["toy"], noDamagePenalty: true,
    crit: 1.5,
    //angle: 0,
    playSelfBonus: 5,
    arousalMode: true,
    playSelfMsg: "KinkyDungeonPlaySelfDLSE_MaceInquisitor",
    playSelfSound: "Vibe",
    events: [
        {type: "DLSE_ElementalEffectExtended", trigger: "playerAttack", power: 0, damage: "stun", time: 2, chance: 0.25, prereq: "DLSE_MaceON"},
        {type: "DLSE_ChangeDamageFlag", trigger: "beforePlayerAttack",
            DLSE_requiredFlag: "DLSE_MaceInquisitor_ON",
            DLSE_sfx: "Vibe",
            power: 2.5, damage: "charm"
        },
    ],
    noDamagePenalty_Flag: "DLSE_MaceInquisitor_ON",     // Does not have a damage penalty IF this flag is set.
    special: {type: "spell", selfCast: true, spell: "DLSE_MaceInquisitor_Switch", requiresEnergy: false,}
}

// Very simple prereq for the special attack
KDPrereqs["DLSE_MaceON"] = (_enemy, _e, _data) => {
    console.log("checking")
    return KinkyDungeonFlags.get("DLSE_MaceInquisitor_ON") !== undefined;
}

// Spell used by the weapon to set a flag internally.
KinkyDungeonSpellListEnemies.push({
    name: "DLSE_MaceInquisitor_Switch", school: "Elements", manacost: 0, components: [], level:1, noMiscast: true, mustTarget: true,
    //sfx: "Vibe",          // SFX is handled elsewhere.
    type:"special", special: "DLSE_MaceInquisitor_SwitchSpecial",
    onhit:"", time:10, power: 3.0, range: 2, size: 1, damage: "",
})

// What happens when you push the button.
KinkyDungeonSpellSpecials["DLSE_MaceInquisitor_SwitchSpecial"] = () => {
    if(!KinkyDungeonFlags.get("DLSE_MaceInquisitor_ON")){
        KinkyDungeonSetFlag("DLSE_MaceInquisitor_ON", -1);
        // Play Vibe SFX here.
        KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/Vibe.ogg", undefined, 0.8);
        KinkyDungeonSendTextMessage(10, TextGet("KDDLSE_MaceInquisitor_ON"), KDBasePink, 2, true);
        addTextKey("KinkyDungeonSpecialDLSE_MaceInquisitor", TextGet("KinkyDungeonSpecialDLSE_MaceInquisitor_ON"));
    }
    else{
        KinkyDungeonSetFlag("DLSE_MaceInquisitor_ON", 0);
        // Do NOT play SFX here.
        KinkyDungeonSendTextMessage(10, TextGet("KDDLSE_MaceInquisitor_OFF"), KDBasePink, 2, true);
        addTextKey("KinkyDungeonSpecialDLSE_MaceInquisitor", TextGet("KinkyDungeonSpecialDLSE_MaceInquisitor_OFF"));
    }
}

// Handle setting correct text string on game load.
KDAddEvent(KDEventMapGeneric, "afterNewGame", "DLSE_MaceInquisitorNewGame", (e, data) => {
    addTextKey("KinkyDungeonSpecialDLSE_MaceInquisitor", TextGet("KinkyDungeonSpecialDLSE_MaceInquisitor_OFF"));
});

KDAddEvent(KDEventMapGeneric, "afterLoadGame", "DLSE_MaceInquisitorLoadGame", (e, data) => {
    if(KinkyDungeonFlags.get("DLSE_MaceInquisitor_ON") !== undefined){
        addTextKey("KinkyDungeonSpecialDLSE_MaceInquisitor", TextGet("KinkyDungeonSpecialDLSE_MaceInquisitor_ON"));
    }
    else{
        addTextKey("KinkyDungeonSpecialDLSE_MaceInquisitor", TextGet("KinkyDungeonSpecialDLSE_MaceInquisitor_OFF"));
    }
});

// Change the damage that a weapon does based upon a flag.
KDAddEvent(KDEventMapWeapon, "beforePlayerAttack", "DLSE_ChangeDamageFlag", (e, _weapon, data) => {
    if (data.enemy && !data.miss && !data.disarm && !KDHelpless(data.enemy) && data.Damage && data.Damage.damage > 0 && !data.enemy.Enemy.tags.nonvulnerable) {
        if (data.enemy && (!e.requiredTag || data.enemy.Enemy.tags[e.requiredTag]) && (!e.chance || KDRandom() < e.chance) && data.enemy.hp > 0) {
            // Check the flag.
            if (KinkyDungeonFlags.get(e.DLSE_requiredFlag)){
                data.Damage.damage                  = e.power;
                data.Damage.type                    = e.damage;
                data.Damage.time                    = e.time;
                data.Damage.bind                    = e.bind;
                if (e.DLSE_sfx) data.Damage.sfx     = e.DLSE_sfx;           // Replace SFX if specified
            }
        }
    }
});