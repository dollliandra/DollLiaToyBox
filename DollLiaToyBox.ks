'use strict';

//////////////////////////////////////////////////////
// DLSE - Doll.Lia's Spell Expansion                //
// Use DLSE_ as the prefix for any new content.     //
//////////////////////////////////////////////////////


// NOTE TO SELF:
// Please remember to increment this when you update your own mod!
// -Doll.Lia
let DLSE_VER = 0.3


/**************************************************************
 * DLSE - Mod Configuration Menu
 * 
 * Access these properties with KDModSettings["DLSEMCM"]["NAME"]
 *  > Return can be a boolean, range, etc. depending upon the type.
 * 
 * Names are handled in CSV with the prefix KDModButton
 **************************************************************/

// Cannot figure out line breaks in text keys any other way.
addTextKey("KDModButtonDLSEMCM_Header_Compatibility", "Options for mod compatibility:\n"
                                                    + " > If things break due to game updates\n"
                                                    + "   or other mods, try disabling these.");
addTextKey("KDModButtonDLSEMCM_Header_Experiments",    "Experimental options:\n"
                                                        + " > Some experimental ideas that are likely\n" 
                                                        + "   not balanced or tested enough.");  
addTextKey("KDModButtonDLSEMCM_Exp_BigArms",           ""
                                                        + " * Overwrites KDCanOffhand\n" 
                                                        + " * Overwrites KinkyDungeonCanUseWeapon");             
addTextKey("KDModButtonDLSEMCM_Exp_ShroudChanges",        " * Overwrites ShadowElementalEffect\n"
                                                        + " * Overwrites KDPlayerCastConditions[\"ShadowDance\"]\n" 
                                                        + " * Overwrites DamageMultInShadow");                                          

//region MCM
if (KDEventMapGeneric['afterModSettingsLoad'] != undefined) {
    KDEventMapGeneric['afterModSettingsLoad']["DLSEMCM"] = (e, data) => {
        // Sanity check to make sure KDModSettings is NOT null. 
        if (KDModSettings == null) { 
            KDModSettings = {} 
            console.log("KDModSettings was null!")
        };
        if (KDModConfigs != undefined) {
            KDModConfigs["DLSEMCM"] = [


                // NOTE - MCM is a 8x2 Grid of pages.
                // > Can use "spacers" (blank text entries) to move content around

                // {
                //     refvar: "DLSEMCM_Cute",
                //     type: "boolean",
                //     default: true,
                //     block: () => {return true}
                // },
                // Header for Weapons
                {refvar: "DLSEMCM_Header_Weapons",  type: "text"},
                // Enable/Disable New Weapons
                {refvar: "DLSEMCM_Shops",           type: "boolean", default: true, block: undefined},
                {refvar: "DLSEMCM_Whips",           type: "boolean", default: true, block: undefined},
                {refvar: "DLSEMCM_Halberds",        type: "boolean", default: true, block: undefined},

                {refvar: "DLSEMCM_Header_Spells",   type: "text"},
                // Enable/Disable Class Changes
                {refvar: "DLSEMCM_Classes",         type: "boolean", default: true, block: undefined},

                // Enable/Disable Spell School Changes
                {refvar: "DLSEMCM_Light",           type: "boolean", default: true, block: undefined},                
                {refvar: "DLSEMCM_Shadow",          type: "boolean", default: true, block: undefined},

                // Page 1, Column 2
                {refvar: "DLSEMCM_Spacer",          type: "text"},
                {refvar: "DLSEMCM_Colossals",       type: "boolean", default: true, block: undefined},
                {refvar: "DLSEMCM_ThrustingSwords", type: "boolean", default: true, block: undefined},
                {refvar: "DLSEMCM_Toys",            type: "boolean", default: true, block: undefined},
                {refvar: "DLSEMCM_Spacer",          type: "text"},
                {refvar: "DLSEMCM_Arcane",          type: "boolean", default: true, block: undefined},
                {refvar: "DLSEMCM_Spacer",          type: "text"},
                {refvar: "DLSEMCM_Spacer",          type: "text"},
                // Page 2
                // Header for Compatibility
                {refvar: "DLSEMCM_Header_Compatibility",    type: "text"},
                {refvar: "DLSEMCM_Perks_BigArms",           type: "boolean", default: true, block: undefined},
                {refvar: "DLSEMCM_ShroudChanges",           type: "boolean", default: true, block: undefined},
                {
                    refvar: "DLSEMCM_ClassicDarkblade", type: "boolean", default: false,
                    // This setting does nothing if Shadow is not enabled.  Block it to visually signify this.
                    block: () => {return !KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"]}
                },

                // Header for Experiments
                {refvar: "DLSEMCM_Header_Experiments", type: "text"},
                {
                    refvar: "DLSEMCM_ShadowSlashLegs", type: "boolean", default: false,
                    // This setting does nothing if Shadow is not enabled.  Block it to visually signify this.
                    block: () => {return !KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"]}
                },
                {refvar: "DLSEMCM_Spacer",              type: "text"},
                {refvar: "DLSEMCM_Spacer",              type: "text"},
                // Column 2
                {refvar: "DLSEMCM_Spacer",              type: "text"},
                {refvar: "DLSEMCM_Exp_BigArms",         type: "text"},
                {refvar: "DLSEMCM_Exp_ShroudChanges",   type: "text"},
                {refvar: "DLSEMCM_Spacer",              type: "text"},
                {refvar: "DLSEMCM_Spacer",              type: "text"},
                {refvar: "DLSEMCM_Spacer",              type: "text"},
                {refvar: "DLSEMCM_Spacer",              type: "text"},
                {refvar: "DLSEMCM_Spacer",              type: "text"},

                // Page 3

                // Example Range setting, kept here for future reference
                // {
                //     refvar: "DLSEMCM_Ex_Range",
                //     type: "range",
                //     rangelow: 0,
                //     rangehigh: 100,
                //     stepcount: 5,
                //     default: 50,
                //     block: undefined
                // },
            ]
        }
        let settingsobject = (KDModSettings.hasOwnProperty("DLSEMCM") == false) ? {} : Object.assign({}, KDModSettings["DLSEMCM"]);
        KDModConfigs["DLSEMCM"].forEach((option) => {
            if (settingsobject[option.refvar] == undefined) {
                settingsobject[option.refvar] = option.default
            }
        })
        KDModSettings["DLSEMCM"] = settingsobject;

        DLSE_MCM_Config()
    }
}

//  Trigger helper functions after the MCM is exited.
if (KDEventMapGeneric['afterModConfig'] != undefined) {
    KDEventMapGeneric['afterModConfig']["DLSEMCM"] = (e,  data) => {
        DLSE_MCM_Config()
    }
}

// Run all helper functions on game load OR post-MCM config.
////////////////////////////////////////////////////////////
function DLSE_MCM_Config(){
    DLSE_Loot();                // Configure Loot Tables based upon MCM settings
    DLSE_Shops();               // Configure Shops
    DLSE_Perks_BigArms();       // Configure a specific perk
    DLSE_ShroudFix();           // Configure Shroud/Smoke Bombs
    DLSE_Classes()              // Configure Class changes
    DLSE_Light();               // Spell Trees
    DLSE_Shadow();
    DLSE_Arcane();

    KDLoadPerks();              // Refresh the perks list so that things show up.

    KDRefreshSpellCache = true;
}

//////////////////////////////////////////////////////////////////
//              Modifying Loot Lists With MCM                   //
//////////////////////////////////////////////////////////////////
//region Loot
let DLSE_Whips_Init = false;        // Have we injected whips into the loot pools yet?
let DLSE_WhipsList = [              // Items to inject into the loot pools.
    "DLSE_Whip",
    "DLSE_WhipThorn",
    "DLSE_WhipIceQueen",
    "DLSE_WhipTentacle",
    "DLSE_WhipRose",
]
let DLSE_Halberds_Init = false;     // Have we injected whips into the loot pools yet?
let DLSE_HalberdsList = [           // Items to inject into the loot pools.
    "DLSE_Halberd",
    "DLSE_HalberdLabrys",
    "DLSE_HalberdRoyal",
]

let DLSE_Colossals_Init = false;    // Have we injected colosals into the loot pools yet?
let DLSE_ColossalsList = [          // Items to inject into the loot pools.
    "DLSE_ColossalSword",
]

let DLSE_ThrustingSwords_Init = false;       // Have we injected thrusting swords into the loot pools yet?
let DLSE_ThrustingSwordsList = [             // Items to inject into the loot pools.
    "DLSE_MagicEpee",
    "DLSE_FreezingPoint",
    "DLSE_FracturedVessel",
]

let DLSE_Toys_Init = false;       // Have we injected toys into the loot pools yet?
let DLSE_ToysList = [             // Items to inject into the loot pools.
    "DLSE_MaceInquisitor",
]

// Inject new items into the loot pools. The code is a bit sloppy.
function DLSE_Loot() {
    // Add weapon categories to the game in suitable places.
    // Whips
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Whips"] && !DLSE_Whips_Init){            // Add Whips to Loot IF they haven't been added yet.
        DLSE_Whips_Init = true;

        // Allow whips to appear in shops
        DLSE_WhipsList.forEach((item) => {KinkyDungeonWeapons[item].shop = true;})

        // Add Basic Whip into the CommonToy pool
        KDWeaponLootList.CommonToy["DLSE_Whip"] = 1;

        // Place Basic Whip in Chests
        KinkyDungeonLootTable.chest.push(
            {name: "DLSE_Whip", minLevel: 0, weight:1, weapon: "DLSE_Whip", noweapon: ["DLSE_Whip"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );

        // Place Thorn Whip in Chests
        KinkyDungeonLootTable.chest.push(
            {name: "DLSE_WhipThorn", minLevel: 0, weight:1, weapon: "DLSE_WhipThorn", noweapon: ["DLSE_WhipThorn"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );

        // Place Ice Queen's Kiss & Tentacle Lash in Caches
        KinkyDungeonLootTable.cache.push(
            {name: "DLSE_WhipIceQueen", minLevel: 2, weight:0.8, weapon: "DLSE_WhipIceQueen", noweapon: ["DLSE_WhipIceQueen"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );
        KinkyDungeonLootTable.cache.push(
            {name: "DLSE_WhipTentacle", minLevel: 2, weight:0.8, weapon: "DLSE_WhipTentacle", noweapon: ["DLSE_WhipTentacle"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );

        // Place Blooming Agony in Lesser Gold chests.
        KinkyDungeonLootTable.lessergold.push(
            {name: "DLSE_WhipRose", minLevel: 5, weight:0.66, weapon: "DLSE_WhipRose", noweapon: ["DLSE_WhipRose"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );

    // Else, remove them from the pool
    // > This comes up if you mess with saves, then edit the MCM
    }else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Whips"] && DLSE_Whips_Init){      // Remove Whips from Loot IF they have been added.

        // Disallow whips to appear in shops
        DLSE_WhipsList.forEach((item) => {KinkyDungeonWeapons[item].shop = false;})

        for(const item in KDWeaponLootList["CommonToy"]){
            if(DLSE_WhipsList.includes(item)){delete KDWeaponLootList["CommonToy"][item]};
        }
        Object.keys(KinkyDungeonLootTable).forEach(key => {
            KinkyDungeonLootTable[key] = KinkyDungeonLootTable[key].filter((lootItem) => {
                return !DLSE_WhipsList.includes(lootItem.name);
            });
        });
        DLSE_Whips_Init = false;
    }
    // Halberds
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Halberds"] && !DLSE_Halberds_Init){            // Add Halberds to Loot IF they haven't been added yet.
        DLSE_Halberds_Init = true;

        // Allow halberds to appear in shops
        DLSE_HalberdsList.forEach((item) => {KinkyDungeonWeapons[item].shop = true;})

        // Add Halberd to the CommonWeapon Pool
        KDWeaponLootList.CommonWeapon["DLSE_Halberd"] = 1;

        // Place Halberd in chests.
        KinkyDungeonLootTable.chest.push(
            {name: "DLSE_Halberd", minLevel: 0, weight:0.8, weapon: "DLSE_Halberd", noweapon: ["DLSE_Halberd"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );

        // Place the Silver Labrys in caches.
        KinkyDungeonLootTable.cache.push(
            {name: "DLSE_HalberdLabrys", minLevel: 3, weight:0.8, weapon: "DLSE_HalberdLabrys", noweapon: ["DLSE_HalberdLabrys"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );

        // Place Royal Halberd in lesser gold chests.
        KinkyDungeonLootTable.lessergold.push(
            {name: "DLSE_HalberdRoyal", minLevel: 5, weight:0.33, weapon: "DLSE_HalberdRoyal", noweapon: ["DLSE_HalberdRoyal"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );
    // Else, remove them from the pool
    // > This comes up if you mess with saves, then edit the MCM
    }else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Halberds"] && DLSE_Halberds_Init){      // Remove Halberds from Loot IF they have been added.
        // Disallow halberds to appear in shops
        DLSE_HalberdsList.forEach((item) => {KinkyDungeonWeapons[item].shop = false;})

        for(const item in KDWeaponLootList["CommonWeapon"]){
            if(DLSE_HalberdsList.includes(item)){delete KDWeaponLootList["CommonWeapon"][item]};
        }
        Object.keys(KinkyDungeonLootTable).forEach(key => {
            KinkyDungeonLootTable[key] = KinkyDungeonLootTable[key].filter((lootItem) => {
                return !DLSE_HalberdsList.includes(lootItem.name);
            });
        });
        DLSE_Halberds_Init = false;
    }
    // Colossal Weapons
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Colossals"] && !DLSE_Colossals_Init){            // Add Colossals to Loot IF they haven't been added yet.
        DLSE_Colossals_Init = true;

        // Allow halberds to appear in shops
        DLSE_ColossalsList.forEach((item) => {KinkyDungeonWeapons[item].shop = true;})

        // Add Colossals to common pool?  Unlikely.
        //KDWeaponLootList.CommonWeapon["DLSE_Halberd"] = 1;

        // Place Halberd in chests.
        // KinkyDungeonLootTable.chest.push(
        //     {name: "DLSE_Halberd", minLevel: 0, weight:0.8, weapon: "DLSE_Halberd", noweapon: ["DLSE_Halberd"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        // );

        // Place the Silver Labrys in caches.
        // KinkyDungeonLootTable.cache.push(
        //     {name: "DLSE_HalberdLabrys", minLevel: 3, weight:0.8, weapon: "DLSE_HalberdLabrys", noweapon: ["DLSE_HalberdLabrys"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        // );

        // Place Colossal Sword in lesser gold chests.
        KinkyDungeonLootTable.lessergold.push(
            {name: "DLSE_ColossalSword", minLevel: 5, weight:0.66, weapon: "DLSE_ColossalSword", noweapon: ["DLSE_ColossalSword"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );
    // Else, remove them from the pool
    // > This comes up if you mess with saves, then edit the MCM
    }else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Colossals"] && DLSE_Colossals_Init){      // Remove Halberds from Loot IF they have been added.
        // Disallow halberds to appear in shops
        DLSE_ColossalsList.forEach((item) => {KinkyDungeonWeapons[item].shop = false;})

        for(const item in KDWeaponLootList["CommonWeapon"]){
            if(DLSE_ColossalsList.includes(item)){delete KDWeaponLootList["CommonWeapon"][item]};
        }
        Object.keys(KinkyDungeonLootTable).forEach(key => {
            KinkyDungeonLootTable[key] = KinkyDungeonLootTable[key].filter((lootItem) => {
                return !DLSE_ColossalsList.includes(lootItem.name);
            });
        });
        DLSE_Colossals_Init = false;
    }
    // Thrusting Swords
    if(KDModSettings["DLSEMCM"]["DLSEMCM_ThrustingSwords"] && !DLSE_ThrustingSwords_Init){            // Add Thrusting Weapons to Loot IF they haven't been added yet.
        DLSE_ThrustingSwords_Init = true;

        // Allow thrusting swords to appear in shops?
        DLSE_ThrustingSwordsList.forEach((item) => {KinkyDungeonWeapons[item].shop = true;})

        // Cache Loot
        KinkyDungeonLootTable.cache.push(
            {name: "DLSE_FreezingPoint", minLevel: 3, weight:0.8, weapon: "DLSE_FreezingPoint", noweapon: ["DLSE_FreezingPoint"], message:"LootChestWeapon", messageColor:"lightblue", messageTime: 3, allFloors: true},
        );

        // Place Relics in (lesser?) gold chests with a very low weight and minlevel 5.
        KinkyDungeonLootTable.lessergold.push(
            {name: "DLSE_MagicEpee", minLevel: 3, weight:0.33, weapon: "DLSE_MagicEpee", message:"LootChestWeapon", messageColor:KDBaseLightBlue, messageTime: 3, allFloors: true, noweapon: ["DLSE_MagicEpee"]},
            {name: "DLSE_FracturedVessel", minLevel: 5, weight:0.33, weapon: "DLSE_FracturedVessel", noweapon: ["DLSE_FracturedVessel"], message:"LootChestWeapon", messageColor:"yellow", messageTime: 3, allFloors: true},
        );
    // Else, remove them from the pool
    // > This comes up if you mess with saves, then edit the MCM
    }else if(!KDModSettings["DLSEMCM"]["DLSEMCM_ThrustingSwords"] && DLSE_ThrustingSwords_Init){      // Remove Halberds from Loot IF they have been added.
        // Disallow halberds to appear in shops
        DLSE_ThrustingSwordsList.forEach((item) => {KinkyDungeonWeapons[item].shop = false;})

        for(const item in KDWeaponLootList["CommonWeapon"]){
            if(DLSE_ThrustingSwordsList.includes(item)){delete KDWeaponLootList["CommonWeapon"][item]};
        }
        /// Clean up the entire loot table
        Object.keys(KinkyDungeonLootTable).forEach(key => {
            KinkyDungeonLootTable[key] = KinkyDungeonLootTable[key].filter((lootItem) => {
                return !DLSE_ThrustingSwordsList.includes(lootItem.name);
            });
        });

        DLSE_ThrustingSwords_Init = false;
    }

    // Toys
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Toys"] && !DLSE_Toys_Init){            // Add Thrusting Weapons to Loot IF they haven't been added yet.
        DLSE_Toys_Init = true;

        // Allow toys to appear in shops?
        DLSE_ToysList.forEach((item) => {KinkyDungeonWeapons[item].shop = true;})

        // Place Toys
        KinkyDungeonLootTable.chest.push(
		    {name: "DLSE_MaceInquisitor", arousalMode: true, minLevel: 0, weight:0.5, weapon: "DLSE_MaceInquisitor", noweapon: ["DLSE_MaceInquisitor"], message:"LootChestWeapon", messageColor:KDBaseLightBlue, messageTime: 3, allFloors: true},
        );

    // Else, remove them from the pool
    // > This comes up if you mess with saves, then edit the MCM
    }else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Toys"] && DLSE_Toys_Init){      // Remove Halberds from Loot IF they have been added.
        // Disallow toys to appear in shops
        DLSE_ToysList.forEach((item) => {KinkyDungeonWeapons[item].shop = false;})

        for(const item in KDWeaponLootList["CommonWeapon"]){
            if(DLSE_ToysList.includes(item)){delete KDWeaponLootList["CommonWeapon"][item]};
        }
        Object.keys(KinkyDungeonLootTable).forEach(key => {
            KinkyDungeonLootTable[key] = KinkyDungeonLootTable[key].filter((lootItem) => {
                return !DLSE_ToysList.includes(lootItem.name);
            });
        });
        DLSE_Toys_Init = false;
    }
}

//////////////////////////////////////////////////////////////////
// Modifying The Shoppe With MCM                                //
//////////////////////////////////////////////////////////////////
//region Shoppe
let DLSE_Antique_Init = false;
let DLSE_Original_Antique = undefined;

function DLSE_Shops(){

    // Save the original shop
    if(!DLSE_Original_Antique){DLSE_Original_Antique = KDDialogue.AntiqueShop;}

    // Add the Leather Whip to the Antique Shop by Overwriting
    // > NOTE: This is a TERRIBLE, inextensible way to edit shops. But, the shops are very difficult to edit otherwise.
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Whips"] && KDModSettings["DLSEMCM"]["DLSEMCM_Shops"] && !DLSE_Antique_Init){
        DLSE_Antique_Init = true;
        KDDialogue.AntiqueShop = KDSaleShop("AntiqueShop", ["Sunglasses", "Snuffer", "SackOfSacks", "DLSE_Whip","Rope"], [], ["blacksmith"], 0.4, 2);
    }
    // Else restore the Antique Shop
    else if(DLSE_Antique_Init && (!KDModSettings["DLSEMCM"]["DLSEMCM_Shops"] || !KDModSettings["DLSEMCM"]["DLSEMCM_Whips"])){
        KDDialogue.AntiqueShop = DLSE_Original_Antique;
        DLSE_Antique_Init = false;
    }
}


//////////////////////////////////////////////////////////////////
//               Adding Class Spells w/MCM                      //
//////////////////////////////////////////////////////////////////
function DLSE_Classes(){

    // 4 lines per spell.
    // > Allows uniquely handling specific spells.

    // Rogue
    //////////////////////////
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Classes"] && !KinkyDungeonLearnableSpells[2][3].includes("DLSE_SilentAssassin")){// Add the spell if not already added
        KinkyDungeonLearnableSpells[2][3].splice((KinkyDungeonLearnableSpells[2][3].indexOf("RogueStudy")+1),0,"DLSE_SilentAssassin");}
    else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Classes"] && KinkyDungeonLearnableSpells[2][3].includes("DLSE_SilentAssassin")){// Remove the spell if already added
        KinkyDungeonLearnableSpells[2][3].splice((KinkyDungeonLearnableSpells[2][3].indexOf("DLSE_SilentAssassin")),1);}             


}

//////////////////////////////////////////////////////////////////
//                  Adding Spells w/MCM                         //
//////////////////////////////////////////////////////////////////
//region Spells
// Set Init bools, so we don't attempt to undo changes that we never made.
// > Otherwise, we might end up deleting things that we didn't mean to delete!
// > Alternatively, we might end up adding dupes of spells to the learnable list.
let DLSE_Light_Init = false;
let DLSE_Shadow_Init = false;
let DLSE_Darkblade_Init = false;    // SPECIFICALLY Darkblade
let ShadowSlashCastText = TextGet("KinkyDungeonSpellCastShadowSlash");

function DLSE_Light(){
    // Place Light Spells into Learnable Spells IF not already added.
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Light"] && !DLSE_Light_Init){
        DLSE_Light_Init = true;
        // Insert into the Spell List before Summmon Holy Orb.  Keeps it grouped with the rest of the Light spells.
        KinkyDungeonLearnableSpells[6][2].splice((KinkyDungeonLearnableSpells[6][2].indexOf("HolyOrb")),0,"DLSE_PurgingCross");
        KinkyDungeonLearnableSpells[6][2].splice((KinkyDungeonLearnableSpells[6][2].indexOf("HolyOrb")),0,"DLSE_LeapOfFaith");

        // Insert Light Passives before The Shadow Within.  Keeps it grouped with the rest of the Light spells.
        KinkyDungeonLearnableSpells[6][3].splice((KinkyDungeonLearnableSpells[6][3].indexOf("TheShadowWithin")),0,"DLSE_Guidance");
        KinkyDungeonLearnableSpells[6][3].splice((KinkyDungeonLearnableSpells[6][3].indexOf("TheShadowWithin")),0,"DLSE_Wrath");
    }
    // Remove Light Spells from Learnable Spells IF not already added.
    else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Light"] && DLSE_Light_Init){
        DLSE_Light_Init = false;

        // Remove all Light spells from their respective lists.
        KinkyDungeonLearnableSpells[6][2].splice((KinkyDungeonLearnableSpells[6][2].indexOf("DLSE_PurgingCross")),1);
        KinkyDungeonLearnableSpells[6][2].splice((KinkyDungeonLearnableSpells[6][2].indexOf("DLSE_LeapOfFaith")),1);
        KinkyDungeonLearnableSpells[6][3].splice((KinkyDungeonLearnableSpells[6][3].indexOf("DLSE_Guidance")),1);
        KinkyDungeonLearnableSpells[6][3].splice((KinkyDungeonLearnableSpells[6][3].indexOf("DLSE_Wrath")),1);
    }
}


function DLSE_Shadow(){
    // Place Shadow Spells into Learnable Spells IF not already added.
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"] && !DLSE_Shadow_Init){
        DLSE_Shadow_Init = true;
        // Insert new Shadow Spells
        KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("Dagger")+1),0,"DLSE_DaggerFan");
        KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("ShadowSlash")+1),0,"DLSE_ShadowSlashLv2");
        KinkyDungeonLearnableSpells[6][3].splice((KinkyDungeonLearnableSpells[6][3].indexOf("TheShadowWithin")+1),0,"DLSE_WickedEdges");
        
    }

    // MUST have Shadow and not reverted Darkblade to change Darkblade
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"] && !KDModSettings["DLSEMCM"]["DLSEMCM_ClassicDarkblade"] && !DLSE_Darkblade_Init){
        DLSE_Darkblade_Init = true;

        // Insert the new Darkblade and remove the old.
        KinkyDungeonLearnableSpells[6][3].splice((KinkyDungeonLearnableSpells[6][3].indexOf("TheShadowWithin")+1),0,"DLSE_Darkblade");
        KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("ShadowBlade")),1);

        // Find Shadow Slash and replace its prerequisite with the new Darkblade
        KinkyDungeonSpellList["Illusion"].find(spell => spell.name == "ShadowSlash").prerequisite = "DLSE_Darkblade";
    }
    
    // Remove Shadow Spells from Learnable Spells IF not already added.
    if(!KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"] && DLSE_Shadow_Init){
        DLSE_Shadow_Init = false;
        KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("DLSE_DaggerFan")),1);
        KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("DLSE_ShadowSlashLv2")),1);
        KinkyDungeonLearnableSpells[6][3].splice((KinkyDungeonLearnableSpells[6][3].indexOf("DLSE_WickedEdges")),1);
    }

    // Revert to classic Darkblade ONLY IF Darkblade was changed previously.
    if(KDModSettings["DLSEMCM"]["DLSEMCM_ClassicDarkblade"] && DLSE_Darkblade_Init
        || !KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"] && DLSE_Darkblade_Init
    ){
        DLSE_Darkblade_Init = false;

        // Replace Darkblade
        KinkyDungeonLearnableSpells[6][3].splice((KinkyDungeonLearnableSpells[6][3].indexOf("DLSE_Darkblade")),1);

        // If ShadowSlash is still an arms spell, put this before it.
        if(KinkyDungeonLearnableSpells[6][1].includes("ShadowSlash")){
            KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("ShadowSlash")),0,"ShadowBlade");
        // Else, put it before Dagger
        }else{
            KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("Dagger")),0,"ShadowBlade");
        }

        // Find Shadow Slash and replace its prerequisite with the old Darkblade
        KinkyDungeonSpellList["Illusion"].find(spell => spell.name == "ShadowSlash").prerequisite = "ShadowBlade";
    }


    // Shadow Slash for Legs
    // If Shadow Slash for Legs is enabled and Shadow Spells are enabled AND Shadow Slash has not been moved:
    // > Swap the component of Shadow Slash and move it.
    // This is messy.
    if(KDModSettings["DLSEMCM"]["DLSEMCM_ShadowSlashLegs"] && KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"] && KinkyDungeonLearnableSpells[6][1].includes("ShadowSlash")){
        // Remove ShadowSlash from Arms
        KinkyDungeonLearnableSpells[6][1].splice(KinkyDungeonLearnableSpells[6][1].indexOf("ShadowSlash"),1);
        KinkyDungeonLearnableSpells[6][1].splice(KinkyDungeonLearnableSpells[6][1].indexOf("DLSE_ShadowSlashLv2"),1);

        // Add ShadowSlash to Legs
        KinkyDungeonLearnableSpells[6][2].splice(KinkyDungeonLearnableSpells[6][2].indexOf("ShadowDance"),0,"ShadowSlash");
        KinkyDungeonLearnableSpells[6][2].splice(KinkyDungeonLearnableSpells[6][2].indexOf("ShadowDance"),0,"DLSE_ShadowSlashLv2");

        // Update components
        KinkyDungeonSpellList["Illusion"].find(spell => spell.name == "ShadowSlash").components = ["Legs"];
        KinkyDungeonSpellList["Illusion"].find(spell => spell.name == "DLSE_ShadowSlashLv2").components = ["Legs"];
        addTextKey("KinkyDungeonSpellCastShadowSlash", "You create a tear in space with a kick!");
    }
    // Undo changes if Legs is turned off AND ShadowSlash was moved.
    else if(!KDModSettings["DLSEMCM"]["DLSEMCM_ShadowSlashLegs"] && KinkyDungeonLearnableSpells[6][2].includes("ShadowSlash")){
        // Remove ShadowSlash from Legs
        KinkyDungeonLearnableSpells[6][2].splice(KinkyDungeonLearnableSpells[6][2].indexOf("ShadowSlash"),1);
        // If upcast exists, remove it.
        if(KinkyDungeonLearnableSpells[6][2].includes("DLSE_ShadowSlashLv2")){
            KinkyDungeonLearnableSpells[6][2].splice(KinkyDungeonLearnableSpells[6][2].indexOf("DLSE_ShadowSlashLv2"),1);
        }

        // Add ShadowSlash to Arms
        if(KDModSettings["DLSEMCM"]["DLSEMCM_ClassicDarkblade"]){
            KinkyDungeonLearnableSpells[6][1].splice(KinkyDungeonLearnableSpells[6][1].indexOf("ShadowBlade")+1,0,"ShadowSlash");
        }else{
            KinkyDungeonLearnableSpells[6][1].splice(KinkyDungeonLearnableSpells[6][1].indexOf("Dagger"),0,"ShadowSlash");
        }
        // If Shadow is enabled, add upcast to Arms
        if(KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"]){
            KinkyDungeonLearnableSpells[6][1].splice(KinkyDungeonLearnableSpells[6][1].indexOf("ShadowSlash")+1,0,"DLSE_ShadowSlashLv2");
        }

        // Revert components
        KinkyDungeonSpellList["Illusion"].find(spell => spell.name == "ShadowSlash").components = ["Arms"];
        KinkyDungeonSpellList["Illusion"].find(spell => spell.name == "DLSE_ShadowSlashLv2").components = ["Arms"];
        addTextKey("KinkyDungeonSpellCastShadowSlash", ShadowSlashCastText);
    }
}


// Following function is NOT used. Attempt to rewrite DLSE_Shadow without Init, but unsure if better
function DLSE_ShadowV2(){

    // 4 lines per spell.
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"] && !KinkyDungeonLearnableSpells[6][1].includes("DLSE_DaggerFan")){
        KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("Dagger")+1),0,"DLSE_DaggerFan");}  // Add the spell if not already added
    else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Shadow"] && KinkyDungeonLearnableSpells[6][1].includes("DLSE_DaggerFan")){
        KinkyDungeonLearnableSpells[6][1].splice((KinkyDungeonLearnableSpells[6][1].indexOf("DLSE_DaggerFan")),1);}             // Remove the spell if already added


}

// Following alternate strat.
function DLSE_Arcane(){

    // Hyperfocus after Sonar.
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Arcane"] && !KinkyDungeonLearnableSpells[6][0].includes("DLSE_Hyperfocus")){
        KinkyDungeonLearnableSpells[6][0].splice((KinkyDungeonLearnableSpells[6][0].indexOf("Sonar")+1),0,"DLSE_Hyperfocus");}  // Add the spell if not already added
    else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Arcane"] && KinkyDungeonLearnableSpells[6][0].includes("DLSE_Hyperfocus")){
        KinkyDungeonLearnableSpells[6][0].splice((KinkyDungeonLearnableSpells[6][0].indexOf("DLSE_Hyperfocus")),1);}             // Remove the spell if already added
    
    // Hyperfocus after Sonar.
    if(KDModSettings["DLSEMCM"]["DLSEMCM_Arcane"] && !KinkyDungeonLearnableSpells[6][0].includes("DLSE_Hyperfocus_Lv2")){
        KinkyDungeonLearnableSpells[6][0].splice((KinkyDungeonLearnableSpells[6][0].indexOf("Sonar")+2),0,"DLSE_Hyperfocus_Lv2");}  // Add the spell if not already added
    else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Arcane"] && KinkyDungeonLearnableSpells[6][0].includes("DLSE_Hyperfocus_Lv2")){
        KinkyDungeonLearnableSpells[6][0].splice((KinkyDungeonLearnableSpells[6][0].indexOf("DLSE_Hyperfocus_Lv2")),1);}             // Remove the spell if already added
}

//////////////////////////////////////////////////////////////////
// Overwriting Events so Shadow Spells work with Shroud         //
//  > Original data is preserved in an object, then restored    //
//     if the mod setting is deactivated later.                 //
//////////////////////////////////////////////////////////////////
//#region ShroudFix
// Save the original functions in here.
//  > Necessary to restore for mod compatibility purposes, as we overwrite these functions.
let DLSE_OriginalShroud = {
    initialized: false,
}

function DLSE_ShroudFix() {

    // Save the original values
    if(!DLSE_OriginalShroud.initialized){
        DLSE_OriginalShroud.initialized = true;
        DLSE_OriginalShroud.eventShadowSlash = KDEventMapBullet.bulletHitEnemy["ShadowSlash"];
        DLSE_OriginalShroud.eventDamageMultShadow = KDEventMapWeapon.beforePlayerAttack["DamageMultInShadow"];
        DLSE_OriginalShroud.eventShadowElemental = KDEventMapBuff.tick["ShadowElementalEffect"];
        DLSE_OriginalShroud.eventUnShadowElemental = KDEventMapBuff.tick["UnShadowElementalEffect"];
        DLSE_OriginalShroud.castCondShadowDance = KDPlayerCastConditions["ShadowDance"];
        DLSE_OriginalShroud.manaCostShadowDance = KDEventMapSpell.calcMultMana["TheShadowWithin"];
        DLSE_OriginalShroud.textKeyShroudDesc = TextGet("KinkyDungeonSpellDescriptionShroud");
        DLSE_OriginalShroud.textKeySmokeBombDesc2 = TextGet("KinkyDungeonInventoryItemSmokeBombDesc2");
    }

    if(KDModSettings["DLSEMCM"]["DLSEMCM_ShroudChanges"]){

        // Update textkeys for Shroud.
        // > Wanted to place this text data in the csv, but it wasn't loading properly when booting Kinky Dungeon.  Only post-MCM.
        addTextKey("KinkyDungeonSpellDescriptionShroud", "Creates a cloud for Duration turns that buffs evasion for all creatures. You are temporarily invisible for 8 turns after leaving. The cloud is treated as a shadowed location.");
        addTextKey("KinkyDungeonInventoryItemSmokeBombDesc2", "Creates a smoke screen lasting 8 turns. You are harder to see while inside the smoke. The cloud is treated as a shadowed location.");

        // 1.) Overwrite ShadowSlash Event (Spell - Shadow Slash)
        KDEventMapBullet.bulletHitEnemy["ShadowSlash"] = (_e, b, data) => {
            // Log the brightness to console for debug
            //console.log(KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y));
        
            // Gives the boost if standing in shadow OR if standing in a "darkarea" effect tile.
            if (b && !b.shadowBuff && data.enemy && ((KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y) < KDShadowThreshold) 
                || KDEffectTileTags(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y).darkarea)) {
                b.shadowBuff = true;
                if (b.bullet?.damage?.damage) b.bullet.damage.damage *= 1.5;
            }
        }
        
        // 2.) Overwrite DamageMultInShadow Event (Weapon - Shadow's Edge)
        KDEventMapWeapon.beforePlayerAttack["DamageMultInShadow"] = (e, _weapon, data) => {
            if (data.enemy && !data.miss && !data.disarm && data.Damage && data.Damage.damage) {
                if (data.enemy && data.enemy.hp > 0 && !KDHelpless(data.enemy)) {
                    if ((!e.chance || KDRandom() < e.chance) && (KinkyDungeonBrightnessGet(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y) <= 1.5 
                    || KinkyDungeonBrightnessGet(data.enemy.x, data.enemy.y) <= 1.5)                        // OR the target is in a low brightness tile
                    || KDEffectTileTags(KinkyDungeonPlayerEntity.x, KinkyDungeonPlayerEntity.y).darkarea    // OR the player is in a darkarea tile
                    || KDEffectTileTags(data.enemy.x, data.enemy.y).darkarea                                // OR the target is in a darkarea tile
                ) {
                        let dmgMult = e.power;
                        data.Damage.damage = data.Damage.damage * dmgMult;
        
                        if (e.energyCost) KinkyDungeonChangeCharge(- e.energyCost);
                        if (e.sfx) KinkyDungeonPlaySound(KinkyDungeonRootDirectory + "Audio/" + e.sfx + ".ogg", undefined, e.vol);
                    }
                }
            }
        }
        
        // 3.) Overwrite Cast Conditions of Shadow Dance so you can teleport to/from Shroud
        KDPlayerCastConditions["ShadowDance"] = (player, x, y) => {
            return (KinkyDungeonFlags.get("TheShadowWithin") || KinkyDungeonBrightnessGet(player.x, player.y) < KDShadowThreshold || KDNearbyEnemies(player.x, player.y, 1.5).some((en) => {return en.Enemy?.tags?.shadow;})
                    || KDEffectTileTags(player.x, player.y).darkarea)                               // Player is in a darkarea tile
                && (KinkyDungeonBrightnessGet(x, y) < KDShadowThreshold 
                    || KDNearbyEnemies(x, y, 1.5).some((en) => {return en.Enemy?.tags?.shadow;})    // Shadow enemy nearby
                    || KDEffectTileTags(x,y).darkarea                                               // Tile is tagged as darkarea
                );
        }
        
        // 4.) Overwrite (Un)ShadowElementalEffect so it deals double damage in "darkarea" tiles
        KDEventMapBuff.tick["ShadowElementalEffect"] = (e, buff, entity, _data) => {
            if ((KinkyDungeonBrightnessGet(entity.x, entity.y) <= KDShadowThreshold) 
                || KDEffectTileTags(entity.x, entity.y).darkarea) {         // OR if the entity is in a "darkarea" tile
                if (buff.duration > 0) {
                    if (entity.player) {
                        KinkyDungeonDealDamage({
                            type: e.damage,
                            damage: e.power,
                            time: e.time,
                            bind: e.bind,
                            distract: e.distract,
                            bindType: e.bindType,
                            addBind: e.addBind,
                            flags: ["BurningDamage"]
                        });
                    } else {
                        KinkyDungeonDamageEnemy(entity, {
                            type: e.damage,
                            damage: e.power,
                            time: e.time,
                            bind: e.bind,
                            distract: e.distract,
                            bindType: e.bindType,
                            addBind: e.addBind,
                            flags: ["BurningDamage"]
                        }, e.power < 1, true, undefined, undefined, undefined);
                    }
                }
            }
        }
        KDEventMapBuff.tick["UnShadowElementalEffect"] = (e, buff, entity, _data) => {
            if ((KinkyDungeonBrightnessGet(entity.x, entity.y) > KDShadowThreshold) 
                && !(KDEffectTileTags(entity.x, entity.y).darkarea)) {      // AND the entity is not in a "darkarea" tile
                if (buff.duration > 0) {
                    if (entity.player) {
                        KinkyDungeonDealDamage({
                            type: e.damage,
                            damage: e.power,
                            time: e.time,
                            bind: e.bind,
                            distract: e.distract,
                            bindType: e.bindType,
                            addBind: e.addBind,
                            flags: ["BurningDamage"]
                        });
                    } else {
                        KinkyDungeonDamageEnemy(entity, {
                            type: e.damage,
                            damage: e.power,
                            time: e.time,
                            bind: e.bind,
                            distract: e.distract,
                            bindType: e.bindType,
                            addBind: e.addBind,
                            flags: ["BurningDamage"]
                        }, false, true, undefined, undefined, undefined);
                    }
                }
            }
        }
        // 5.) Fix the cost of Shadow Dance while in "darkarea" tiles.
        KDEventMapSpell.calcMultMana["TheShadowWithin"] = (e, _spell, data) => {
            let player = KinkyDungeonPlayerEntity;
            if(KDEffectTileTags(player.x, player.y).darkarea){
                return;
            }
    
            if (data.spell?.name == "ShadowDance")
                if (!(KinkyDungeonBrightnessGet(player.x, player.y) < KDShadowThreshold || KDNearbyEnemies(player.x, player.y, 1.5).some((en) => { return en.Enemy?.tags?.shadow; })))
                    data.cost = Math.max(data.cost * e.mult);
        }
    }
    // Else, need to revert all changes made by the mod.
    //  > Restore the original data from the DLSE_OriginalShroud object.
    else{
        // If we stored functions, restore them.
        // If we didn't store anything, noting was overwritten - do nothing.
        if(DLSE_OriginalShroud.initialized){
            KDEventMapBullet.bulletHitEnemy["ShadowSlash"] = DLSE_OriginalShroud.eventShadowSlash;
            KDEventMapWeapon.beforePlayerAttack["DamageMultInShadow"] = DLSE_OriginalShroud.eventDamageMultShadow;
            KDPlayerCastConditions["ShadowDance"] = DLSE_OriginalShroud.castCondShadowDance;
            KDEventMapBuff.tick["ShadowElementalEffect"] = DLSE_OriginalShroud.eventShadowElemental;
            KDEventMapBuff.tick["UnShadowElementalEffect"] = DLSE_OriginalShroud.eventUnShadowElemental;
            KDEventMapSpell.calcMultMana["ShadowDance"] = DLSE_OriginalShroud.manaCostShadowDance;
            // Revert textkeys for Shroud.
            addTextKey("KinkyDungeonSpellDescriptionShroud", DLSE_OriginalShroud.textKeyShroudDesc);
            addTextKey("KinkyDungeonInventoryItemSmokeBombDesc2", DLSE_OriginalShroud.textKeySmokeBombDesc2);
        }
    }
}



//////////////////////////////////////////////////////
//                                                  //
//      //////////////////////////////////////      //
//      //     DollLia's Perks Expansion    //      //
//      //////////////////////////////////////      //
//                                                  //
//////////////////////////////////////////////////////
//region Perks

//////////////////////////////////////////////////////////////////
//                   Adding Perks w/MCM                         //
//////////////////////////////////////////////////////////////////


/*************************************************
 * Perk - Big Arms
 * 
 * "You can wield 2-handed weapons in one hand"
 * > Unfortunately, requires overwriting KDCanOffhand and KinkyDungeonCanUseWeapon
 * > Perk is handled individually because of this.
 * > Access the value with KinkyDungeonStatsChoice.get("DLSE_BigArms");
 *************************************************/

let DLSE_BigArms_Init = false;      // Have we enabled this perk yet?
let DLSE_BigArms_Storage = {        // Store the old functions here
    init: undefined,
}

//KDCategoriesStart.push({name: "DLSE_Perks", buffs: [], debuffs: [],},))

function DLSE_Perks_BigArms(){
    // Store the original function data for restoring later
    if(!DLSE_BigArms_Storage.init){
        DLSE_BigArms_Storage.init = true;
        DLSE_BigArms_Storage.KDCanOffhand = KDCanOffhand;                           // Store function
        DLSE_BigArms_Storage.KinkyDungeonCanUseWeapon = KinkyDungeonCanUseWeapon;   // Store function
    }

    if(KDModSettings["DLSEMCM"]["DLSEMCM_Perks_BigArms"] && !DLSE_BigArms_Init){
        DLSE_BigArms_Init = true;
        KinkyDungeonStatsPresets["DLSE_BigArms"] = {category: "Combat", id: "DLSE_BigArms", cost: 2}	// Add the perk to the menu
        // Overwrite KDCanOffhand to account for the perk
        KDCanOffhand = (item) => {
            let data = {
                item: item,
                is2handed: KDWeapon(item)?.clumsy,							// Unused
                is2handedPrimary: KinkyDungeonPlayerDamage?.clumsy,			// Unused
                // IF your main hand weapon is not 2H or you have Big Arms. AND the weapon has an off-hand effect.
                allowedOffhand: ((!KinkyDungeonPlayerDamage?.clumsy) || KinkyDungeonStatsChoice.get("DLSE_BigArms")) && KDWeapon(item)?.events?.some((e) => {
                    return e.offhand;
                }),
                canOffhand: false,
            };
        
            KinkyDungeonSendEvent("canOffhand", data);						// Class-based off-hand restrictions
        
            return data.item && data.canOffhand && data.allowedOffhand;
        }
        // Overwrite KinkyDungeonCanUseWeapon to account for the perk. (Using 2H in one hand)
        KinkyDungeonCanUseWeapon = (NoOverride, e, weapon) => {
            let flags = {
                HandsFree: false,
                clumsy: weapon?.clumsy,
                weapon: weapon,
            };
            if (!NoOverride)
                KinkyDungeonSendEvent("getWeapon", {event: e, flags: flags});
        
            return flags.HandsFree
                || weapon?.noHands
                || (!KinkyDungeonIsHandsBound(false, true)
                    // Weapon is not 2H OR you have the Big Arms perk.
                    && ((!KinkyDungeonStatsChoice.get("WeakGrip") && (!flags.clumsy || KinkyDungeonStatsChoice.get("DLSE_BigArms"))) || !KinkyDungeonIsArmsBound(false, true)));
        }
    }
    // Restore if changes were made
    else if(!KDModSettings["DLSEMCM"]["DLSEMCM_Perks_BigArms"] && DLSE_BigArms_Init){
        DLSE_BigArms_Init = false;
        delete KinkyDungeonStatsPresets["DLSE_BigArms"];
        KDCanOffhand = DLSE_BigArms_Storage.KDCanOffhand;
        KinkyDungeonCanUseWeapon = DLSE_BigArms_Storage.KinkyDungeonCanUseWeapon;
    }

}








//#region Initialize Save Data
/****************************************************************
 * Need to keep track of certain things.
 ****************************************************************/
KDAddEvent(KDEventMapGeneric, "afterNewGame", "DLSE_SaveData", (e, data) => {
    // Initialize data in the save file if necessary.
    DLSE_Init_ToyBoxSave();
});

KDAddEvent(KDEventMapGeneric, "afterLoadGame", "DLSE_SaveData", (e, data) => {
    // Initialize data in the save file.
    DLSE_Init_ToyBoxSave();
});

function DLSE_Init_ToyBoxSave(){

    // Initialize the GameData portion for DollLia's mods.
    if(!KDGameData?.DollLia){
        console.log("Created DollLia base gamedata.")
        KDGameData.DollLia = {}
    }
    // Initialize the GameData portion for DollLia's mods.
    if(!KDGameData.DollLia?.ToyBox){
        console.log("Created DollLia's Toy Box gamedata.")
        KDGameData.DollLia.ToyBox = {
            modVer:                 DLSE_VER,           // Important to track in case of potentially save-breaking changes. Can write code to fix.
            freezingPointLoaded:    false,              // Is Freezing Point loaded?
        }
    }else{
        // Verify Mod Version
        if(KDGameData.DollLia.ToyBox.modVer < DLSE_VER){
            console.log("Updating Mod Version from " + String(KDGameData.DollLia.ToyBox.modVer) + " to " + String(DLSE_VER))

            // Update the number.
            KinkyDungeonSendTextMessage(10, "Updated Toy Box from v" + String(KDGameData.DollLia.ToyBox.modVer) + " to v" + String(DLSE_VER) + "!", KDBaseCyan, 10);
            KDGameData.DollLia.ToyBox.modVer = DLSE_VER;
        // This should NEVER happen.
        }else if(KDGameData.DollLia.ToyBox.modVer > DLSE_VER){
            console.log("ERROR: Game save is from a later version of DollLia's Toy Box, please update!");
            KinkyDungeonSendTextMessage(10, "ERROR: Game save is from a later version of DollLia's Toy Box, please update the mod!", KDBaseRed, 10);
        }
    }
}








//#region Player Titles
//////////////////////////////////////////////////
// Player Titles! //
////////////////////
let DLSE_KDPlayerTitlesLive = false;
// Attempt to access the KDPlayerTitles variable.
// > If we're not in 5.5.1+, this will throw an exception.
try{
    KDPlayerTitles;                     // If player titles aren't live, this throws an exception.
    DLSE_KDPlayerTitlesLive = true;     // Otherwise, player titles are live
}catch(e){
    ;                                   // Just catch the exception gracefully.
}

if(DLSE_KDPlayerTitlesLive){
    KDPlayerTitles["DLSE_SpellMasteryLight"] = {
        "unlockCondition": () => {
            let reqspells = ['DLSE_PurgingCross', 'DLSE_LeapOfFaith', 'DLSE_Guidance', 'DLSE_Wrath']
            return (reqspells.every((sp) => KinkyDungeonSpells.map((t) => t.name).includes(sp))) // Checks if we have every single spell above
        },
        "priority": 2,
        "color": "#ffedc5",
        "titleActive": () => {
            return false;
        },
        "titleActivate": () => {
            return false;
        },
        "titleDeactivate": () => {
            return false;
        },
        "category": "DLSE_PlayerTitles",
        "icon": "None",
    },

    KDPlayerTitles["DLSE_SpellMasteryShadow"] = {
        "unlockCondition": () => {
            let reqspells = ['DLSE_DaggerFan', 'DLSE_ShadowSlashLv2', 'DLSE_WickedEdges',]
            if(!KDModSettings["DLSEMCM"]["DLSEMCM_ClassicDarkblade"]){
                reqspells.push("DLSE_Darkblade")
            }
            return (reqspells.every((sp) => KinkyDungeonSpells.map((t) => t.name).includes(sp))) // Checks if we have every single spell above
        },
        "priority": 2,
        "color": "#1e1d58",
        "titleActive": () => {
            return false;
        },
        "titleActivate": () => {
            return false;
        },
        "titleDeactivate": () => {
            return false;
        },
        "category": "DLSE_PlayerTitles",
        "icon": "None",
    },

    // Refresh Player Titles so everything shows up.
    KDPlayerTitlesRefreshCategories();
}