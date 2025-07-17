'use strict';

///////////////////////////////////////////////////////
//                                                   //
//      ///////////////////////////////////////      //
//      //     DLSE - Teasing Weapons        //      //
//      ///////////////////////////////////////      //
//                                                   //
///////////////////////////////////////////////////////

//region Teasing Weapons
/**************************************************
 * Inquisitor's Mace
 * 
 * Hier-tier toy that can deal grope damage OR charm damage (magic)
 *  > This lets you change the weapon from physical to magical.
 * Special Ability - Toggle On/Off
 *  > Change the damage that the weapon deals.
 **************************************************/
KinkyDungeonWeapons["DLSE_MaceInquisitor"] = {
    name: "DLSE_MaceInquisitor", damage: 2.5, chance: 1.0, staminacost: 3, type: "grope", unarmed: false, rarity: 4, shop: true, sfx: "RubberBolt",
    tags: ["toy"], noDamagePenalty: true,
    crit: 2,
    //angle: 0,
    playSelfBonus: 5,
    arousalMode: true,
    playSelfMsg: "KinkyDungeonPlaySelfDLSE_MaceInquisitor",
    playSelfSound: "Vibe",
    events: [
        //{type: "ElementalEffect", trigger: "playerAttack", power: 0, damage: "stun", time: 2, chance: 0.2},
        {type: "DLSE_ChangeDamageFlag", trigger: "beforePlayerAttack",
            DLSE_requiredFlag: "DLSE_MaceInquisitor_ON",
            DLSE_sfx: "Vibe",
            power: 2.0, damage: "charm"
        },
    ],
    special: {type: "spell", selfCast: true, spell: "DLSE_MaceInquisitor_Switch", requiresEnergy: false,}
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
    }
    else{
        KinkyDungeonSetFlag("DLSE_MaceInquisitor_ON", 0);
        // Do NOT play SFX here.
        KinkyDungeonSendTextMessage(10, TextGet("KDDLSE_MaceInquisitor_OFF"), KDBasePink, 2, true);
    }
}

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