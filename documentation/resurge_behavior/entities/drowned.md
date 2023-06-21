# drowned

> 全部内容基于溺尸(原版)修改。

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

### scripts—animate

|     名称     | 条件 | 备注 |
| :----------: | :--: | :--: |
| wet_detector |  ——  |  ——  |
|  moon_stage  |  ——  |  ——  |

### animations

|     名称     |                      内容                       |                 备注                 |
| :----------: | :---------------------------------------------: | :----------------------------------: |
| wet_detector | controller.animation.entity.normal.wet_detector | 在雨中或水中时，获得属性与移速的改变 |
|  moon_stage  |  controller.animation.entity.normal.moon_stage  |      根据不同月相，调用不同事件      |



## components

### 生物标识(type_family|variant)

#### minecraft:type_family

```json
"drowned", "zombie", "undead", "monster", "mob"
```

#### minecraft:mark_variant

```json
"value": 0 //标识普通状态
```



### 伤害与抵抗(health|attack)

#### minecraft:health

```json
"value": 44,
"max": 44
```

#### minecraft:attack

```json
"damage": 5
```

#### ~~minecraft:hurt_on_condition~~

#### ~~minecraft:burns_in_daylight~~

#### minecraft:fire_immune



### 环境交互(break_blocks|shareables)

#### minecraft:break_blocks

| 类别               | 范围 |
| ------------------ | ---- |
| 怪物基础可破坏物品 | 所有 |

#### minecraft:annotation.break_door

```json
"break_time": 3
```

#### minecraft:shareables

##### items：

```json
{
    "item": "resurge:thunder_trident",
    "want_amount": 1,
    "surplus_amount": 1,
    "priority": 0
},
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
"table": "loot_tables/entities/drowned_equipment.json"
```

**slot_drop_chance:**

| slot                 | drop_chance |
| -------------------- | ----------- |
| slot.weapon.mainhand | 0.025       |
| slot.weapon.offhand  | 0.35        |

#### minecraft:loot

```json
"table": "loot_tables/entities/drowned.json"
```



### 寻路与移动(movement)

#### ~~minecraft:movement~~

#### ~~minecraft:underwater_movement~~

#### minecraft:movement.generic

```json
"max_turn": 60.0
```

#### minecraft:navigation.generic

```json
"can_walk_in_lava": true,
"can_breach": true,
"avoid_sun": false
```

#### minecraft:preferred_path

```json
"max_fall_blocks": 20
```

#### minecraft:follow_range

必须添加，否则实体在找到攻击目标后，若与目标的距离大于16，会出现丢失目标的情况

**表示跟随目标的距离，目标移动超出此距离时丢失目标，这里设置为最大索敌范围的1.5倍**

```json
"value": 48,
"max": 48
```



### 行为系列(behavior)

#### ~~minecraft:behavior.flee_sun~~

#### minecraft:behavior.equip_item

```json
"priority": 2,
```

#### minecraft:behavior.melee_attack

```json
"priority": 3,
"speed_multiplier": 1.0,
"track_target": true,
"reach_multiplier": 2.0,
"require_complete_path": false
```

#### minecraft:behavior.random_breach

```json
"priority": 5,
"interval": 20,
"xz_dist": 4,
"y_dist": 6,
"cooldown_time": 1
```

#### minecraft:behavior.pickup_items

```json
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

#### minecraft:behavior.hurt_by_target

```json
"alert_same_type": true,
```

**entity_types：**

| filters            | 补充 |
| ------------------ | ---- |
| 排除其它僵尸、女巫 | ——   |

#### minecraft:behavior.nearest_attackable_target

```json
"must_reach": false,
"must_see": false,
"must_see_forget_duration": 20.0,
"persist_time": 3,
"reselect_targets": true,
"within_radius": 48.0, //因定义了follow_range，此处实际无效
```

**entity_types：**

| filters                                | 补充                                  |
| -------------------------------------- | ------------------------------------- |
| 任意其它玩家、人类(除女巫)             | "max_dist": 32,<br/>"must_see": false |
| 任意其它友好生物，在雨中或者为夜晚     | "max_dist": 32,<br/>"must_see": false |
| 任意其它悦灵、蜜蜂、海龟、海豚、美西螈 | "max_dist": 32,<br/>"must_see": true  |



### 传感器与触发(sensor|trigger)

#### minecraft:environment_sensor

**triggers：**

| filters            | event                      | target |
| ------------------ | -------------------------- | ------ |
| 在岩浆中           | resurge:start_transforming | ——     |
| 手中持有雷霆三叉戟 | resurge:degrade_trident    | ——     |
| 手中持有三叉戟     | resurge:has_trident        | ——     |



### 其他(others)

#### minecraft:is_hidden_when_invisible



## component_groups

### 原版-破门

#### ~~minecraft:can_break_doors~~

##### ~~minecraft:annotation.break_door~~

移动至基本组件



### 原版-装备

#### ~~minecraft:ranged_equipment~~

##### ~~minecraft:equipment~~

#### ~~minecraft:melee_equipment~~

##### ~~minecraft:equipment~~

移动至基本组件



### 复生-转化尸壳

额外增加的功能，在岩浆中转化为尸壳。

#### resurge:look_to_start_husk_transformation

##### minecraft:environment_sensor

**triggers：**

| filters            | event                      | target |
| ------------------ | -------------------------- | ------ |
| 在岩浆中           | resurge:start_transforming | ——     |
| 手中持有雷霆三叉戟 | resurge:degrade_trident    | ——     |
| 手中持有三叉戟     | resurge:has_trident        | ——     |

#### resurge:start_husk_transformation

##### minecraft:environment_sensor

**triggers：**

| filters            | event                     | target |
| ------------------ | ------------------------- | ------ |
| 不在岩浆中         | resurge:stop_transforming | ——     |
| 手中持有雷霆三叉戟 | resurge:degrade_trident   | ——     |
| 手中持有三叉戟     | resurge:has_trident       | ——     |

##### minecraft:timer

```json
"looping": false,
"time": 30,
"time_down_event": {
    "event": "resurge:convert_to_husk"
}
```

#### resurge:convert_to_husk

##### minecraft:transformation

```json
"into": "minecraft:husk<minecraft:as_adult>",
"transformation_sound": "block.campfire.crackle",
"drop_equipment": false,
"delay": {
    "value": 15
}
```

##### minecraft:is_shaking

#### resurge:convert_to_baby_husk

##### minecraft:transformation

```json
"into": "minecraft:husk<minecraft:as_baby>",
"transformation_sound": "block.campfire.crackle",
"drop_equipment": false,
"delay": {
    "value": 15
}
```

##### minecraft:is_shaking

#### resurge:convert_to_baby_jockey_husk

##### minecraft:transformation

```json
"into": "minecraft:husk<resurge:as_baby_jockey>",
"transformation_sound": "block.campfire.crackle",
"drop_equipment": false,
"delay": {
    "value": 15
}
```

##### minecraft:is_shaking



### 原版加-生成类型

#### minecraft:baby_drowned

##### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 14 + (query.equipment_count * Math.Random(1,6)) : Math.Random(0,1)"
```

##### minecraft:movement

```json
"value": 0.48
```

##### minecraft:underwater_movement

```json
"value": 0.12
```

#### minecraft:adult_drowned

##### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 7 + (query.equipment_count * Math.Random(1,3)) : Math.Random(0,1)"
```

##### minecraft:movement

```json
"value": 0.32
```

##### minecraft:underwater_movement

```json
"value": 0.08
```

##### minecraft:rideable

```json
"seat_count": 1,
"family_types": ["zombie"],
"seats": {
    "position": [0.0, 1.1, -0.35],
    "lock_rider_rotation": 0
}
```

##### minecraft:behavior.mount_pathing

```json
"priority": 2,
"speed_multiplier": 0.8,
"target_dist": 0.0,
"track_target": true
```

##### ~~minecraft:loot~~

#### ~~minecraft:mode_switcher~~

##### ~~minecraft:target_nearby_sensor~~

组件组重做为``resurge:trident_mode_controller``。

#### resurge:jockey_drowned

##### minecraft:behavior.find_mount

```json
"priority": 1,
"within_radius": 16
```

新增的 jockey 类型溺尸，优先主动骑乘其他生物。



### 原版-攻击模式切换

#### ~~minecraft:ranged_mode~~

##### ~~minecraft:shooter~~

##### ~~minecraft:behavior.ranged_attack~~

组件组重做为``resurge:trident_ranged_mode``。

#### ~~minecraft:melee_mode~~

##### ~~minecraft:attack~~

##### ~~minecraft:behavior.melee_attack~~

##### ~~minecraft:equipment~~

组件组重做为``resurge:normal_mode_controller``与``resurge:trident_melee_mode``。



### 原版-寻路模式切换

#### minecraft:hunter_mode

##### minecraft:navigation.generic

```json
"can_walk_in_lava": true,
"can_breach": true,
"avoid_sun": false
```

#### minecraft:wander_mode

##### minecraft:navigation.generic

```json
"can_walk_in_lava": true,
"can_breach": true,
"avoid_sun": false
```



### 复生-攻击模式切换

在持有三叉戟时，根据目标距离自身距离切换近战与远程攻击。

在未持有三叉戟时，进行近战攻击。

#### resurge:normal_mode_controller

##### minecraft:behavior.melee_attack

```json
"priority": 3,
"speed_multiplier": 1.0,
"track_target": true,
"reach_multiplier": 2.0,
"require_complete_path": false
```

##### minecraft:environment_sensor

**triggers：**

| filters            | event                   | target |
| ------------------ | ----------------------- | ------ |
| 手中持有雷霆三叉戟 | resurge:degrade_trident | ——     |
| 手中持有三叉戟     | resurge:has_trident     | ——     |

#### resurge:trident_mode_controller

##### minecraft:target_nearby_sensor

|          | inside_range          | outside_range          |
| -------- | --------------------- | ---------------------- |
| **距离** | 4.0                   | 8.0                    |
| **事件** | resurge:trident_melee | resurge:trident_ranged |
| **目标** | self                  | self                   |

##### minecraft:environment_sensor

**triggers：**

| filters            | event                   | target |
| ------------------ | ----------------------- | ------ |
| 手中持有雷霆三叉戟 | resurge:degrade_trident | ——     |
| 手中未持有三叉戟   | resurge:lost_trident    | ——     |

#### resurge:trident_melee_mode

##### minecraft:behavior.melee_attack

```json
"priority": 3,
"speed_multiplier": 1.0,
"track_target": true,
"reach_multiplier": 3.0,
"require_complete_path": false
```

#### resurge:trident_ranged_mode

##### minecraft:shooter

```json
"def": "minecraft:thrown_trident"
```

##### minecraft:behavior.ranged_attack

```json
"priority": 3,
"attack_interval_min": 4.0,
"attack_interval_max": 6.0,
"attack_radius": 32.0,
"attack_radius_min": 6.0,
"burst_shots": 2,
"burst_interval": 0.6,
"speed_multiplier": 1.0,
"charge_charged_trigger": 0, //每个炮弹开始充能的间隔
"charge_shoot_trigger": 0, //每个炮弹的充能时间
"swing": true,
"x_max_rotation": 60.0,
"y_max_head_rotation": 60.0
```



### 复生-湿润属性

根据是否在雨中或水中，以及是否为成年个体，获得不同的移速与基础属性。

<u>**以下为干燥情况**。</u>

#### resurge:dry_property

##### minecraft:attack

```json
"damage": 5
```

#### resurge:dry_movement_baby

##### minecraft:movement

```json
"value": 0.408
```

##### minecraft:underwater_movement

```json
"value": 0.102
```

#### resurge:dry_movement_adult

##### minecraft:movement

```json
"value": 0.272
```

##### minecraft:underwater_movement

```json
"value": 0.068
```

<u>**以下为湿润情况**。</u>

#### resurge:wet_property

##### minecraft:attack

```json
"damage": 5,
"effect_name": "mining_fatigue",
"effect_duration": 30
```

##### minecraft:knockback_resistance

```json
"value": 0.16
```

#### resurge:wet_movement_baby

##### minecraft:movement

```json
"value": 0.48
```

##### minecraft:underwater_movement

```json
"value": 0.12
```

#### resurge:wet_movement_adult

##### minecraft:movement

```json
"value": 0.32
```

##### minecraft:underwater_movement

```json
"value": 0.08
```



### 复生-伤害检测器

根据不同月相阶段，在受到致命伤害时，以不同概率触发``resurge:random_select_rage``事件。

根据不同湿润程度，提供不同伤害减免（8% / 16%）。

#### resurge:damage_stage0

##### minecraft:damage_sensor

###### trigger 1

**on_damage：**

| filters          | event | target |
| ---------------- | ----- | ------ |
| 自身在雨中或水中 | ——    | ——     |

```json
"damage_multiplier": 0.84
```

###### trigger 2

```json
"damage_multiplier": 0.92
```

#### resurge:damage_stage1

##### minecraft:damage_sensor

###### trigger 1

**on_damage：**

| filters                                           | event                      | target |
| ------------------------------------------------- | -------------------------- | ------ |
| 自身受到致命伤害，1/32概率<br />mark_variant等于0 | resurge:random_select_rage | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 2

**on_damage：**

| filters          | event | target |
| ---------------- | ----- | ------ |
| 自身在雨中或水中 | ——    | ——     |

```json
"damage_multiplier": 0.84
```

###### trigger 3

```json
"damage_multiplier": 0.92
```

#### resurge:damage_stage2

##### minecraft:damage_sensor

###### trigger 1

**on_damage：**

| filters                                           | event                      | target |
| ------------------------------------------------- | -------------------------- | ------ |
| 自身受到致命伤害，1/16概率<br />mark_variant等于0 | resurge:random_select_rage | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 2

**on_damage：**

| filters          | event | target |
| ---------------- | ----- | ------ |
| 自身在雨中或水中 | ——    | ——     |

```json
"damage_multiplier": 0.84
```

###### trigger 3

```json
"damage_multiplier": 0.92
```

#### resurge:damage_stage3

##### minecraft:damage_sensor

###### trigger 1

**on_damage：**

| filters                                          | event                      | target |
| ------------------------------------------------ | -------------------------- | ------ |
| 自身受到致命伤害，1/8概率<br />mark_variant等于0 | resurge:random_select_rage | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 2

**on_damage：**

| filters          | event | target |
| ---------------- | ----- | ------ |
| 自身在雨中或水中 | ——    | ——     |

```json
"damage_multiplier": 0.84
```

###### trigger 3

```json
"damage_multiplier": 0.92
```

#### resurge:damage_stage4

##### minecraft:damage_sensor

###### trigger 1

**on_damage：**

| filters                                          | event                      | target |
| ------------------------------------------------ | -------------------------- | ------ |
| 自身受到致命伤害，1/4概率<br />mark_variant等于0 | resurge:random_select_rage | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 2

**on_damage：**

| filters          | event | target |
| ---------------- | ----- | ------ |
| 自身在雨中或水中 | ——    | ——     |

```json
"damage_multiplier": 0.84
```

###### trigger 3

```json
"damage_multiplier": 0.92
```



### 复生-发送狂暴事件

向其它目标发送狂暴事件，使其转化为狂暴形态。<!--综合概率考虑，每秒约使1.25只僵尸狂暴-->

同时自身随时间，每0.5秒受到2点伤害。

#### resurge:send_event

##### minecraft:mark_variant

```json
"value": 1 //标识逝者不休状态
```

##### minecraft:damage_over_time

```json
"damage_per_hurt": 2,
"time_between_hurt": 0.5
```

##### minecraft:behavior.send_event

```json
"priority": 0,
"event_choices": [
    {
        "min_activation_range": 0.0,
        "max_activation_range": 32.0,
        "cooldown_time": 0.0,
        "cast_duration": 0.2,
        "look_at_target": true,
        "weight": 233,
        "particle_color": "#FFFF0000",
        "start_sound_event": "ambient",
    }
]
```

**event_choices：**

| filters            | sequences—event     | sequences—sound_event |
| ------------------ | ------------------- | --------------------- |
| 其它僵尸，排除狂暴 | resurge:random_rage | ambient               |



### 复生-狂暴

转化为狂暴形态

#### resurge:adult_rage

##### minecraft:transformation

```json
"into": "resurge:drowned_raged<resurge:as_adult>"",
"preserve_equipment": true
```

#### resurge:baby_rage

##### minecraft:transformation

```json
"into": "resurge:drowned_raged<resurge:as_baby>",
"preserve_equipment": true
```

#### resurge:baby_rage

##### minecraft:transformation

```json
"into": "resurge:drowned_raged<resurge:as_baby_jockey>",
"preserve_equipment": true
```



### 复生-满月狂暴计时器

进入满月夜晚时启动计时器，在随机时间后触发满月狂暴事件，期间播放颤抖动画。

#### resurge:moon_rage_timer

##### minecraft:timer

```json
"looping": false,
"time": [0, 30],
"time_down_event": {
    "event": "resurge:moon_rage"
}
```

##### minecraft:is_shaking



### 复生-满月狂暴

转化为狂暴形态，附加额外变种标签，标识是由满月夜晚转化。

#### resurge:adult_moon_rage

##### minecraft:transformation

```json
"into": "resurge:drowned_raged<resurge:as_adult_moon>",
"preserve_equipment": true
```

#### resurge:baby_moon_rage

##### minecraft:transformation

```json
"into": "resurge:drowned_raged<resurge:as_baby_moon>",
"preserve_equipment": true
```

#### resurge:baby_moon_rage

##### minecraft:transformation

```json
"into": "resurge:drowned_raged<resurge:as_baby_jockey_moon>",
"preserve_equipment": true
```



## events

### 原版加-生物生成

#### minecraft:entity_spawned

##### 序列1

| 权重 | 添加组件组                                        | 移除组件组 | 执行命令 |
| :--: | :------------------------------------------------ | :--------- | :------- |
| 940  | minecraft:adult_drowned                           | ——         | ——       |
|  50  | minecraft:baby_drowned                            | ——         | ——       |
|  10  | minecraft:baby_drowned<br/>resurge:jockey_drowned | ——         | ——       |

##### ~~序列2~~

| ~~权重~~ | ~~添加组件组~~                | ~~移除组件组~~ | ~~执行命令~~ |
| :------: | :---------------------------- | :------------- | :----------- |
|  ~~10~~  | ~~minecraft:can_break_doors~~ | ~~——~~         | ~~——~~       |
|  ~~90~~  | ~~——~~                        | ~~——~~         | ~~——~~       |

该序列用于随机控制能否破门，此处进行了移除。

#### minecraft:as_adult

| 条件 | 添加组件组                                                   | 移除组件组 | 执行命令 |
| :--: | :----------------------------------------------------------- | :--------- | :------- |
|  ——  | minecraft:adult_drowned<br />~~minecraft:melee_mode~~<br />~~minecraft:melee_equipment~~ | ——         | ——       |

#### minecraft:as_baby

| 条件 | 添加组件组                                                   | 移除组件组 | 执行命令 |
| :--: | :----------------------------------------------------------- | :--------- | :------- |
|  ——  | minecraft:baby_drowned<br />~~minecraft:melee_mode~~<br />~~minecraft:melee_equipment~~ | ——         | ——       |

#### resurge:as_baby_jockey

| 条件 | 添加组件组                                        | 移除组件组 | 执行命令 |
| :--: | :------------------------------------------------ | :--------- | :------- |
|  ——  | minecraft:baby_drowned<br/>resurge:jockey_drowned | ——         | ——       |



### 复生-生物生成-三叉戟(测试用)

手中必定持有三叉戟的生成事件。

#### resurge:as_adult_trident

| 条件 | 添加组件组              | 移除组件组 | 执行命令                                                     |
| :--: | :---------------------- | :--------- | :----------------------------------------------------------- |
|  ——  | minecraft:adult_drowned | ——         | replaceitem entity @s slot.weapon.mainhand 0 destroy trident 1 0 |

#### resurge:as_baby_trident

| 条件 | 添加组件组             | 移除组件组 | 执行命令                                                     |
| :--: | :--------------------- | :--------- | :----------------------------------------------------------- |
|  ——  | minecraft:baby_drowned | ——         | replaceitem entity @s slot.weapon.mainhand 0 destroy trident 1 0 |

#### resurge:as_baby_jockey_trident

| 条件 | 添加组件组                                        | 移除组件组 | 执行命令                                                     |
| :--: | :------------------------------------------------ | :--------- | :----------------------------------------------------------- |
|  ——  | minecraft:baby_drowned<br/>resurge:jockey_drowned | ——         | replaceitem entity @s slot.weapon.mainhand 0 destroy trident 1 0 |



### 复生-转化尸壳

额外增加的功能，在岩浆中转化为尸壳。

#### resurge:start_transforming

|             条件              | 添加组件组                        | 移除组件组                                | 执行命令 |
| :---------------------------: | :-------------------------------- | :---------------------------------------- | :------- |
| 不具有``minecraft:timer``组件 | resurge:start_husk_transformation | resurge:look_to_start_husk_transformation | ——       |

#### resurge:stop_transforming

|             条件              | 添加组件组                        | 移除组件组                                | 执行命令 |
| :---------------------------: | :-------------------------------- | :---------------------------------------- | :------- |
| 不具有``minecraft:timer``组件 | resurge:start_husk_transformation | resurge:look_to_start_husk_transformation | ——       |

#### resurge:convert_to_husk

|                             条件                             | 添加组件组                          | 移除组件组                        | 执行命令 |
| :----------------------------------------------------------: | :---------------------------------- | :-------------------------------- | :------- |
|               不具有``minecraft:is_baby``组件                | resurge:convert_to_husk             | resurge:start_husk_transformation | ——       |
| 具有``minecraft:is_baby``组件<br />不具有``minecraft:behavior.find_mount``组件 | resurge:convert_to_baby_husk        | resurge:start_husk_transformation | ——       |
| 具有``minecraft:is_baby``组件<br />具有``minecraft:behavior.find_mount``组件 | resurge:convert_to_baby_jockey_husk | resurge:start_husk_transformation | ——       |



### 原版-攻击模式切换

#### ~~minecraft:switch_to_melee~~

事件重做为``resurge:trident_melee``。

#### ~~minecraft:switch_to_ranged~~~~

事件重做为``resurge:trident_ranged``。



### 复生-降级三叉戟

降级手中的雷霆三叉戟为三叉戟。

#### resurge:degrade_trident

| 条件 | 添加组件组 | 移除组件组 | 执行命令                                                     |
| :--: | :--------- | :--------- | :----------------------------------------------------------- |
|  ——  | ——         | ——         | replaceitem entity @s slot.weapon.mainhand 0 destroy trident 1 0<br />particle minecraft:cauldron_explosion_emitter ~~1~<br />particle minecraft:cauldron_explosion_emitter ~~1~<br />particle minecraft:cauldron_explosion_emitter ~~1~ |



### 复生-三叉戟检测

根据是否拥有三叉戟，激活不同的攻击模式控制器。

#### resurge:has_trident

| 条件 | 添加组件组                      | 移除组件组                     | 执行命令 |
| :--: | :------------------------------ | :----------------------------- | :------- |
|  ——  | resurge:trident_mode_controller | resurge:normal_mode_controller | ——       |

#### resurge:lost_trident

| 条件 | 添加组件组                     | 移除组件组                                                   | 执行命令 |
| :--: | :----------------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:normal_mode_controller | resurge:trident_mode_controller<br />resurge:trident_melee_mode<br />resurge:trident_ranged_mode | ——       |



### 复生-攻击模式切换

在拥有三叉戟时，根据目标距离自身距离，切换近战或远程攻击方式。

#### resurge:trident_melee

| 条件 | 添加组件组                 | 移除组件组                  | 执行命令 |
| :--: | :------------------------- | :-------------------------- | :------- |
|  ——  | resurge:trident_melee_mode | resurge:trident_ranged_mode | ——       |

#### resurge:trident_ranged

| 条件 | 添加组件组                  | 移除组件组                 | 执行命令 |
| :--: | :-------------------------- | :------------------------- | :------- |
|  ——  | resurge:trident_ranged_mode | resurge:trident_melee_mode | ——       |



### 复生-湿润属性

根据是否在雨中或水中，激活不同的基础属性与移速组件组。

#### resurge:become_dry

|              条件               | 添加组件组                 | 移除组件组                 | 执行命令 |
| :-----------------------------: | :------------------------- | :------------------------- | :------- |
|               ——                | resurge:dry_property       | resurge:wet_property       | ——       |
| 不具有``minecraft:is_baby``组件 | resurge:dry_movement_adult | resurge:wet_movement_adult | ——       |
|  具有``minecraft:is_baby``组件  | resurge:dry_movement_baby  | resurge:wet_movement_baby  | ——       |

#### resurge:become_wet

|              条件               | 添加组件组                 | 移除组件组                 | 执行命令 |
| :-----------------------------: | :------------------------- | :------------------------- | :------- |
|               ——                | resurge:wet_property       | resurge:dry_property       | ——       |
| 不具有``minecraft:is_baby``组件 | resurge:wet_movement_adult | resurge:dry_movement_adult | ——       |
|  具有``minecraft:is_baby``组件  | resurge:wet_movement_baby  | resurge:dry_movement_baby  | ——       |



### 复生-月相阶段

根据不同月相，激活不同的伤害传感器。

#### resurge:moon_stage0

| 条件 | 添加组件组            | 移除组件组                                                   | 执行命令 |
| :--: | :-------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:damage_stage0 | resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage3<br/>resurge:damage_stage4<br />resurge:moon_rage_timer | ——       |

#### resurge:moon_stage1

| 条件 | 添加组件组            | 移除组件组                                                   | 执行命令 |
| :--: | :-------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:damage_stage1 | resurge:damage_stage0<br/>resurge:damage_stage2<br/>resurge:damage_stage3<br/>resurge:damage_stage4<br />resurge:moon_rage_timer | ——       |

#### resurge:moon_stage2

| 条件 | 添加组件组            | 移除组件组                                                   | 执行命令 |
| :--: | :-------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:damage_stage2 | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage3<br/>resurge:damage_stage4<br />resurge:moon_rage_timer | ——       |

#### resurge:moon_stage3

| 条件 | 添加组件组            | 移除组件组                                                   | 执行命令 |
| :--: | :-------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:damage_stage3 | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage4<br />resurge:moon_rage_timer | ——       |

#### resurge:moon_stage4_day

| 条件 | 添加组件组            | 移除组件组                                                   | 执行命令 |
| :--: | :-------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:damage_stage4 | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage3<br />resurge:moon_rage_timer | ——       |

#### resurge:moon_stage4_night

##### 序列1 <!--主动关闭尸壳转换，以使用新的timer组件-->

| 条件 | 添加组件组                                | 移除组件组                        | 执行命令 |
| :--: | :---------------------------------------- | :-------------------------------- | :------- |
|  ——  | resurge:look_to_start_husk_transformation | resurge:start_husk_transformation | ——       |

##### 序列2

| 条件 | 添加组件组                                         | 移除组件组                                                   | 执行命令 |
| :--: | :------------------------------------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:damage_stage4<br />resurge:moon_rage_timer | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage3 | ——       |





### 复生-随机选择濒死效果

用于逝者不休技能，随机选择自身直接狂暴，或者向队友发送狂暴信号。

#### resurge:random_select_rage

##### 权重：60

|                             条件                             | 添加组件组               | 移除组件组 | 执行命令 |
| :----------------------------------------------------------: | :----------------------- | :--------- | :------- |
|               不具有``minecraft:is_baby``组件                | resurge:adult_rage       | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />不具有``minecraft:behavior.find_mount``组件 | resurge:baby_rage        | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />具有``minecraft:behavior.find_mount``组件 | resurge:baby_jockey_rage | ——         | ——       |

##### 权重：40

| 条件 | 添加组件组         | 移除组件组 | 执行命令                                                     |
| :--: | :----------------- | :--------- | :----------------------------------------------------------- |
|  ——  | resurge:send_event | ——         | effect @s resistance 600 3 false<br />effect @s weakness 600 1 false<br />effect @s slowness 600 1 false |



### 复生-狂暴相关

控制自身狂暴，有随机、必定、满月三种方式。

随机：用于其它生物向自身发送狂暴信号时进行判断。

#### resurge:random_rage

##### 权重：75

无事发生。

##### 权重：25

|                             条件                             | 添加组件组               | 移除组件组 | 执行命令 |
| :----------------------------------------------------------: | :----------------------- | :--------- | :------- |
|               不具有``minecraft:is_baby``组件                | resurge:adult_rage       | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />不具有``minecraft:behavior.find_mount``组件 | resurge:baby_rage        | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />具有``minecraft:behavior.find_mount``组件 | resurge:baby_jockey_rage | ——         | ——       |

#### resurge:rage

|                             条件                             | 添加组件组               | 移除组件组 | 执行命令 |
| :----------------------------------------------------------: | :----------------------- | :--------- | :------- |
|               不具有``minecraft:is_baby``组件                | resurge:adult_rage       | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />不具有``minecraft:behavior.find_mount``组件 | resurge:baby_rage        | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />具有``minecraft:behavior.find_mount``组件 | resurge:baby_jockey_rage | ——         | ——       |

#### resurge:moon_rage

|                             条件                             | 添加组件组                    | 移除组件组 | 执行命令 |
| :----------------------------------------------------------: | :---------------------------- | :--------- | :------- |
|               不具有``minecraft:is_baby``组件                | resurge:adult_moon_rage       | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />不具有``minecraft:behavior.find_mount``组件 | resurge:baby_moon_rage        | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />具有``minecraft:behavior.find_mount``组件 | resurge:baby_jockey_moon_rage | ——         | ——       |



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
