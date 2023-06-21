# zombie_villager

> 全部内容基于僵尸村民(原版)修改。

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

### scripts—animate

| 名称 | 条件 | 备注 |
| :--: | :--: | :--: |

### animations

| 名称 | 内容 | 备注 |
| :--: | :--: | :--: |



## components

### 生物标识(type_family|variant)

#### minecraft:type_family

```json
"zombie_villager", "zombie", "undead", "monster", "mob"
```

**注：**官方在此遗漏了type_family，导致小型村民转化为小型僵尸村民时，会丢失type类型。



### 伤害与抵抗(health|attack)

#### minecraft:health

```json
"value": 48,
"max": 48
```

#### minecraft:attack

```json
"damage": [1, 100],
"effect_name": "weakness",
"effect_duration": 30
```

#### ~~minecraft:burns_in_daylight~~



### 环境交互(break_blocks|shareables)

#### minecraft:break_blocks

| 类别               | 范围 |
| ------------------ | ---- |
| 怪物基础可破坏物品 | 所有 |

#### minecraft:annotation.break_door

```json
"break_time": 1
```

#### minecraft:shareables

**items：**

```json
{
    "item": "minecraft:trident",
    "want_amount": 1,
    "surplus_amount": 1,
    "priority": 0
}
```



### 生成与掉落(equipment|loot)

#### minecraft:equipment

```json
"table": "loot_tables/entities/zombie_equipment.json"
```

#### minecraft:loot

```json
"table": "loot_tables/entities/zombie.json"
```



### 寻路与移动(movement)

#### ~~minecraft:navigation.walk~~

#### minecraft:navigation.climb

```json
"is_amphibious": true,
"can_pass_doors": true,
"can_break_doors": true,
"avoid_sun": false
```

#### minecraft:jump.static

```json
"jump_power": 0.84
```

#### minecraft:preferred_path

```json
"max_fall_blocks": 20
```

#### minecraft:follow_range

```json
"value": 48,
"max": 48
```



### 行为系列(behavior)

#### minecraft:behavior.equip_item

```json
"priority": 2
```

#### minecraft:behavior.melee_attack

```json
"priority": 3,
"speed_multiplier": 1.0,
"track_target": true,
"reach_multiplier": 1.6
```

#### minecraft:behavior.pickup_items

```json
"priority": 6,
"max_dist": 6,
"goal_radius": 3,
"excluded_items": [
    "minecraft:glow_ink_sac",
    "minecraft:string",
    "minecraft:cactus",
    "minecraft:bamboo",
    "minecraft:sweet_berries",
    "minecraft:pointed_dripstone"
]
```

#### minecraft:behavior.random_stroll

```json
"priority": 7,
```

#### minecraft:behavior.look_at_player

```json
"priority": 8,
```

#### minecraft:behavior.random_look_around

```json
"priority": 9
```

#### minecraft:behavior.hurt_by_target

```json
"alert_same_type": true
```

**entity_types：**

| filters            | 补充 |
| ------------------ | ---- |
| 排除其它僵尸、女巫 | ——   |

#### minecraft:behavior.nearest_attackable_target

```json
"must_reach": false,
"must_see": false, //因filter内部进行了定义，此处实际无效
"must_see_forget_duration": 20.0,
"persist_time": 3,
"reselect_targets": true,
"within_radius": 48.0, //因定义了follow_range，此处实际无效
```

**entity_types：**

| filters                              | 补充                                  |
| ------------------------------------ | ------------------------------------- |
| 任意其它玩家、友好生物、人类(除女巫) | "max_dist": 32,<br/>"must_see": false |
| 任意其它悦灵、蜜蜂、海龟             | "max_dist": 32,<br/>"must_see": true  |



### 传感器与触发(sensor|trigger)

#### minecraft:damage_sensor

##### trigger 1

```json
"cause": "fall",
"damage_modifier": -4,
"damage_multiplier": 0.92
```

##### trigger 2

```json
"damage_multiplier": 0.92
```



### 其他(others)

#### minecraft:mob_effect

```json
"cooldown_time": 4.0,
"effect_range": 6,
"effect_time": 8,
"mob_effect": "slowness"
```

**entity_filter：**

| filters        | 补充 |
| -------------- | ---- |
| 自身的攻击目标 | ——   |



## component_groups

### 原版-破门

#### ~~minecraft:can_break_doors~~

##### ~~minecraft:annotation.break_door~~

移动至基本组件



### 原版-生成类型

#### baby

##### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 16 + (query.equipment_count * Math.Random(1,8)) : Math.Random(0,1)"
```

##### minecraft:movement

```json
"value": 0.24
```

#### adult

##### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 8 + (query.equipment_count * Math.Random(1,4)) : Math.Random(0,1)"
```

##### minecraft:movement

```json
"value": 0.16
```

##### minecraft:behavior.mount_pathing

```json
"speed_multiplier": 1.0
```

#### from_abandoned_village

##### ~~minecraft:navigation.walk~~

##### ~~minecraft:behavior.flee_sun~~

##### minecraft:navigation.climb

```json
"is_amphibious": true,
"can_pass_doors": true,
"can_open_doors": true,
"avoid_water": true,
"avoid_sun": false
```



### 原版-转化僵尸村民v2

#### become_zombie_villager_v2

##### minecraft:transformation

```json
"preserve_equipment": true
```



### 原版-转化村民

#### to_villager

##### minecraft:transformation

```json
"preserve_equipment": false
```



## events

### 原版加-生物生成

#### minecraft:entity_spawned

##### 序列1

**条件：**不具有``minecraft:variant``组件。

| 权重 | 添加组件组      | 移除组件组 | 执行命令 |
| :--: | :-------------- | :--------- | :------- |
| 940  | adult           | ——         | ——       |
|  50  | baby            | ——         | ——       |
|  10  | baby<br/>jockey | ——         | ——       |

##### 序列2

**条件：**不具有``minecraft:variant``组件。

该序列控制各个职业的变种，此处未作修改，因此省略。

##### ~~序列3~~

| ~~权重~~ | ~~添加组件组~~                | ~~移除组件组~~ | ~~执行命令~~ |
| :------: | :---------------------------- | :------------- | :----------- |
|  ~~10~~  | ~~minecraft:can_break_doors~~ | ~~——~~         | ~~——~~       |
|  ~~90~~  | ~~——~~                        | ~~——~~         | ~~——~~       |

该序列用于随机控制能否破门，此处进行了移除。



### 通用-召唤闪电

#### universal:lightning_bolt_attack

| 条件 | 添加组件组 | 移除组件组 | 执行命令              |
| :--: | :--------- | :--------- | :-------------------- |
|  ——  | ——         | ——         | summon lightning_bolt |



### 通用-真实伤害

#### universal:get_real_damage_1

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 1 none @s |

#### universal:get_real_damage_2

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 2 none @s |

#### universal:get_real_damage_3

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 3 none @s |

#### universal:get_real_damage_4

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 4 none @s |

#### universal:get_real_damage_5

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 5 none @s |

#### universal:get_real_damage_6

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 6 none @s |

#### universal:get_real_damage_7

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 7 none @s |

#### universal:get_real_damage_8

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 8 none @s |

#### universal:get_real_damage_9

| 条件 | 添加组件组 | 移除组件组 | 执行命令            |
| :--: | :--------- | :--------- | :------------------ |
|  ——  | ——         | ——         | damage @s 9 none @s |

#### universal:get_real_damage_10

| 条件 | 添加组件组 | 移除组件组 | 执行命令             |
| :--: | :--------- | :--------- | :------------------- |
|  ——  | ——         | ——         | damage @s 10 none @s |
