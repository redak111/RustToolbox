var StructItems = [
  {
    "name": "Wood",
    "health": 250,
    "decayTime": 3,
    "iconPath": "images/wood.png",
    "id": "damage_wall_wood"
  },
  {
    "name": "Stone",
    "health": 500,
    "decayTime": 5,
    "iconPath": "images/stone.png",
    "id": "damage_wall_stone"
  },
  {
    "name": "Metal",
    "health": 1000,
    "decayTime": 8,
    "iconPath": "images/metal_fragments.png",
    "id": "damage_wall_metal"
  },
  {
    "name": "Armor",
    "health": 2000,
    "decayTime": 12,
    "iconPath": "images/hqm.png",
    "id": "damage_wall_armor"
  },
  {
    "name": "Wooden Door",
    "health": 200,
    "decayTime": 3,
    "iconPath": "images/wood_door.png",
    "id": "damage_door_wood"
  },
  {
    "name": "Metal Door",
    "health": 250,
    "decayTime": 8,
    "iconPath": "images/metal_door.png",
    "id": "damage_door_metal"
  },
  {
    "name": "Garage Door",
    "health": 600,
    "decayTime": 8,
    "iconPath": "images/garage_door.png",
    "id": "damage_door_garage"
  },
  {
    "name": "Armored Door",
    "health": 1000,
    "decayTime": 12,
    "iconPath": "images/armored_door.png",
    "id": "damage_door_armored"
  },
  {
    "name": "Hatch",
    "health": 250,
    "decayTime": 8,
    "iconPath": "images/hatch.png",
    "id": "damage_door_hatch"
  },
  {
    "name": "HE Wooden Wall",
    "health": 500,
    "decayTime": 3,
    "iconPath": "images/he_wood_wall.png",
    "id": "damage_custom_heww"
  },
  {
    "name": "HE Stone Wall",
    "health": 500,
    "decayTime": 8,
    "iconPath": "images/he_stone_wall.png",
    "id": "damage_custom_hesw"
  }
];

var RaidItems = [
  {
    "name": "Rocket",
    "sulfur": 1400,
    "damage_wall_wood": 247.6,
    "damage_wall_stone": 137.6,
    "damage_wall_metal": 137.6,
    "damage_wall_armor": 137.6,
    "damage_door_wood": 550.4,
    "damage_door_metal": 220.4,
    "damage_door_garage": 220.4,
    "damage_door_armored": 220.4,
    "damage_door_hatch": 220.4,
    "damage_custom_heww": 247.6,
    "damage_custom_hesw": 137.6,
    "iconPath": "images/rocket.png"
  },
  {
    "name": "C4",
    "sulfur": 2200,
    "damage_wall_wood": 495.0,
    "damage_wall_stone": 275.0,
    "damage_wall_metal": 275.0,
    "damage_wall_armor": 275.0,
    "damage_door_wood": 1100.0,
    "damage_door_metal": 440.0,
    "damage_door_garage": 440.0,
    "damage_door_armored": 440.0,
    "damage_door_hatch": 440.0,
    "damage_custom_heww": 495.0,
    "damage_custom_hesw": 275.0,
    "iconPath": "images/c4.png"
  },
  {
    "name": "Satchel",
    "sulfur": 480,
    "damage_wall_wood": 91.5,
    "damage_wall_stone": 51.5,
    "damage_wall_metal": 43.5,
    "damage_wall_armor": 43.5,
    "damage_door_wood": 170.0,
    "damage_door_metal": 70.0,
    "damage_door_garage": 70.0,
    "damage_door_armored": 70.0,
    "damage_door_hatch": 70.0,
    "damage_custom_heww": 91.5,
    "damage_custom_hesw": 51.5,
    "iconPath": "images/satchel.png"
  },
  {
    "name": "Explosive Ammo",
    "sulfur": 25,
    "damage_wall_wood": 5.1,
    "damage_wall_stone": 2.7,
    "damage_wall_metal": 2.5,
    "damage_wall_armor": 2.5,
    "damage_door_wood": 7.7,
    "damage_door_metal": 4.0,
    "damage_door_garage": 4.0,
    "damage_door_armored": 4.0,
    "damage_door_hatch": 4.0,
    "damage_custom_heww": 5.1,
    "damage_custom_hesw": 2.7,
    "iconPath": "images/explosive.png"
  },
  {
    "name": "F1 Grenade",
    "sulfur": 60,
    "damage_wall_wood": 4.24,
    "damage_wall_stone": 2.75,
    "damage_wall_metal": 1.0,
    "damage_wall_armor": 1.0,
    "damage_door_wood": 5.0,
    "damage_door_metal": 5.0,
    "damage_door_garage": 5.0,
    "damage_door_armored": 5.0,
    "damage_door_hatch": 5.0,
    "damage_custom_heww": 4.24,
    "damage_custom_hesw": 2.75,
    "iconPath": "images/f1.png"
  },
  {
    "name": "Beancan",
    "sulfur": 120,
    "damage_wall_wood": 19.5,
    "damage_wall_stone": 11.0,
    "damage_wall_metal": 9.0,
    "damage_wall_armor": 9.0,
    "damage_door_wood": 35.0,
    "damage_door_metal": 14.5,
    "damage_door_garage": 14.5,
    "damage_door_armored": 14.5,
    "damage_door_hatch": 14.5,
    "damage_custom_heww": 19.5,
    "damage_custom_hesw": 11.0,
    "iconPath": "images/beancan.png"
  }
];

List<Map<String, Object>> GetStructItems() {
  return StructItems;
}

List<Map<String, Object>> GetRaidItems() {
  return RaidItems;
}
