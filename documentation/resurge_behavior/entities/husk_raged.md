# husk_raged

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

### runtime_identifier

```json
minecraft:husk
```

### scripts—animate

|      名称       | 条件 | 备注 |
| :-------------: | :--: | :--: |
| desertification |  ——  |  ——  |
|  wet_detector   |  ——  |  ——  |
| biome_detector  |  ——  |  ——  |
|   random_hunt   |  ——  |  ——  |
| full_moon_stage |  ——  |  ——  |

### animations

|      名称       |                       内容                        |               备注               |
| :-------------: | :-----------------------------------------------: | :------------------------------: |
| desertification |       animation.entity.husk.desertification       |            沙漠化技能            |
|  wet_detector   |   controller.animation.entity.husk.wet_detector   |   在雨中或水中时，获得移速减益   |
| biome_detector  |  controller.animation.entity.husk.biome_detector  | 在沙漠与沙滩群系时，获得属性加成 |
|   random_hunt   |   controller.animation.entity.raged.random_hunt   | 根据不同月相，以不同概率进行猎杀 |
| full_moon_stage | controller.animation.entity.raged.full_moon_stage |    在满月夜晚结束时，恢复平静    |



## components

> 该部分基于尸壳(复生)修改。

### 生物标识(type_family|variant)

#### minecraft:type_family

```json
"husk_raged", "zombie_raged", "raged", "husk", "zombie", "undead", "monster", "mob"
```



### 伤害与抵抗(health|attack)

#### minecraft:health

```json
"value": 60,
"max": 60
```

#### minecraft:attack

```json
"damage": 7,
"effect_duration": 40
```

#### minecraft:knockback_resistance

```json
"value": 0.32
```



### 环境交互(break_blocks|shareables)

#### minecraft:break_blocks

| 类别               | 范围                   |
| ------------------ | ---------------------- |
| 怪物基础可破坏物品 | 所有                   |
| 动物与植物类物品   | 半实心方块、全透明方块 |
| 其它装饰性方块     | <u>*海龟蛋*</u>        |

#### minecraft:annotation.break_door

```json
"break_time": 1
```



### 生成与掉落(equipment|loot)

#### minecraft:equipment

```json
"table": "loot_tables/entities/zombie_equipment.json"
```

#### minecraft:loot

```json
"table": "loot_tables/entities/husk_raged.json"
```



### 寻路与移动(movement)

#### minecraft:follow_range

必须添加，否则实体在找到攻击目标后，若与目标的距离大于16，会出现丢失目标的情况

**表示跟随目标的距离，目标移动超出此距离时丢失目标，这里设置为最大索敌范围的1.5倍**

```json
"value": 60,
"max": 60
```



### 行为系列(behavior)

#### minecraft:behavior.hurt_by_target

**entity_types：**

| filters                      | 补充 |
| ---------------------------- | ---- |
| 排除其它僵尸、女巫、狂暴生物 | ——   |

#### minecraft:behavior.nearest_attackable_target

```json
"persist_time": 5,
"within_radius": 60.0, //因定义了follow_range，此处实际无效
```

**entity_types：**

| filters                                        | 补充                                  |
| ---------------------------------------------- | ------------------------------------- |
| 任意其它玩家、友好生物、人类(除女巫)、黑暗生物 | "max_dist": 40,<br/>"must_see": false |
| 任意其它悦灵、蜜蜂、海龟                       | "max_dist": 40,<br/>"must_see": true  |



### 传感器与触发(sensor|trigger)

#### ~~minecraft:environment_sensor~~

#### minecraft:damage_sensor

##### trigger 1

**on_damage：**

| filters              | event | target |
| -------------------- | ----- | ------ |
| 自身在沙漠或沙滩群系 | ——    | ——     |

```json
"damage_multiplier": 0.84
```

##### trigger 2

```json
"damage_multiplier": 0.92
```

#### minecraft:on_death

| filters             | event             | target |
| ------------------- | ----------------- | ------ |
| 月亮强度1.0，在夜晚 | resurge:moon_loot | self   |



## component_groups

> 该部分由空白创建。

### 复生-生成类型

#### resurge:husk_raged_baby

##### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 28 + (query.equipment_count * Math.Random(1,12)) : Math.Random(0,1)"
```

##### minecraft:is_baby

##### minecraft:scale

```json
"value": 0.53125
```

##### minecraft:movement

```json
"value": 0.6
```

#### resurge:husk_raged_adult

##### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 14 + (query.equipment_count * Math.Random(1,6)) : Math.Random(0,1)"
```

##### minecraft:scale

```json
"value": 1.0625
```

##### minecraft:movement

```json
"value": 0.4
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
"speed_multiplier": 1.0,
"target_dist": 0.0,
"track_target": true
```

#### resurge:husk_raged_jockey

##### minecraft:behavior.find_mount

```json
"priority": 1,
"within_radius": 16
```



### 复生-满月变体

标记由满月夜晚转化而来的实体。

#### resurge:moon_variant

##### minecraft:variant

```json
"value": 1
```



### 复生-湿润属性

根据是否在雨中或水中，以及是否为成年个体，获得不同的移速。

#### resurge:dry_movement_baby

##### minecraft:movement

```json
"value": 0.6
```

#### resurge:dry_movement_adult

##### minecraft:movement

```json
"value": 0.4
```

#### resurge:wet_movement_baby

##### minecraft:movement

```json
"value": 0.51
```

#### resurge:wet_movement_adult

##### minecraft:movement

```json
"value": 0.34
```



### 复生-群系&猎杀重叠属性

根据 是否在沙漠或沙滩群系 与 是否处于猎杀状态，提供4种不同的击退抗性。

#### resurge:out_biome_normal_knockback

##### minecraft:knockback_resistance

```json
"value": 0.32
```

#### resurge:out_biome_hunt_knockback

##### minecraft:knockback_resistance

```json
"value": 0.48
```

#### resurge:in_biome_normal_knockback

##### minecraft:knockback_resistance

```json
"value": 0.48
```

#### resurge:in_biome_hunt_knockback

##### minecraft:knockback_resistance

```json
"value": 0.64
```



### 复生-群系专属属性

根据是否在沙漠或沙滩群系，获得不同的基础属性。

#### resurge:out_biome_property

##### minecraft:attack

```json
"damage": 7,
"effect_name": "hunger",
"effect_duration": 40
```

#### resurge:in_biome_property

##### minecraft:attack

```json
"damage": 9,
"effect_name": "hunger",
"effect_duration": 60
```

##### minecraft:mob_effect

```json
"cooldown_time": 4.0,
"effect_range": 6,
"effect_time": 16,
"mob_effect": "weakness"
```

**entity_filter：**

| filters        | 补充 |
| -------------- | ---- |
| 自身的攻击目标 | ——   |



### 复生-猎杀专属属性

根据是否处于猎杀状态，获得不同的标识，以及方块破坏能力。

进入猎杀状态后，会额外触发一个计时器，以恢复普通状态。

#### resurge:normal_mark

##### minecraft:mark_variant

```json
"value": 0 //标识普通状态
```

#### resurge:normal_break_blocks

##### minecraft:break_blocks

| 类别               | 范围                   |
| ------------------ | ---------------------- |
| 怪物基础可破坏物品 | 所有                   |
| 动物与植物类物品   | 半实心方块、全透明方块 |
| 其它装饰性方块     | <u>*海龟蛋*</u>        |

#### resurge:hunt_mark

##### minecraft:mark_variant

```json
"value": 1 //标识猎杀状态
```

#### resurge:hunt_break_blocks

##### minecraft:break_blocks

| 类别               | 范围                           |
| ------------------ | ------------------------------ |
| 怪物基础可破坏物品 | 所有                           |
| 工作类方块         | 方块(不重要)                   |
| 红石类物品         | <u>*绊线钩*</u>、<u>*活塞*</u> |
| 木质方块           | 所有                           |
| 硬度[0,1]的方块    | 所有                           |
| 硬度(1,2)的方块    | 所有                           |
| 硬度2的方块        | <u>*圆石*</u>、<u>*苔石*</u>   |
| 动物与植物类物品   | 所有                           |
| 其它装饰性方块     | 方块、<u>*海龟蛋*</u>          |

#### resurge:hunt_timer

##### minecraft:timer

```json
"looping": false,
"time": 8.0,
"time_down_event": {
    "event": "resurge:normal_mode"
}
```



### 复生-平静计时器

离开满月夜晚时启动计时器，在随机时间后触发平静事件，期间播放颤抖动画。

#### resurge:moon_rage_timer

##### minecraft:timer

```json
"looping": false,
"time": [0, 30],
"time_down_event": {
    "event": "resurge:calm"
}
```

##### minecraft:is_shaking



### 复生-平静

转化回平静形态。

#### resurge:adult_calm

##### minecraft:transformation

```json
"into": "minecraft:husk<minecraft:as_adult>",
"preserve_equipment": true
```

#### resurge:baby_calm

##### minecraft:transformation

```json
"into": "minecraft:husk<minecraft:as_baby>",
"preserve_equipment": true
```

#### resurge:baby_jockey_calm

##### minecraft:transformation

```json
"into": "minecraft:husk<resurge:as_baby_jockey>",
"preserve_equipment": true
```



## events

> 该部分由空白创建。

### 复生-生物生成

#### minecraft:entity_spawned

| 权重 | 添加组件组                                                | 移除组件组 | 执行命令 |
| :--: | :-------------------------------------------------------- | :--------- | :------- |
| 940  | resurge:zombie_raged_adult                                | ——         | ——       |
|  50  | resurge:zombie_raged_baby                                 | ——         | ——       |
|  10  | resurge:zombie_raged_baby<br/>resurge:zombie_raged_jockey | ——         | ——       |

#### resurge:as_adult

| 条件 | 添加组件组                 | 移除组件组 | 执行命令 |
| :--: | :------------------------- | :--------- | :------- |
|  ——  | resurge:zombie_raged_adult | ——         | ——       |

#### resurge:as_baby

| 条件 | 添加组件组                | 移除组件组 | 执行命令 |
| :--: | :------------------------ | :--------- | :------- |
|  ——  | resurge:zombie_raged_baby | ——         | ——       |

#### resurge:as_baby_jockey

| 条件 | 添加组件组                                                | 移除组件组 | 执行命令 |
| :--: | :-------------------------------------------------------- | :--------- | :------- |
|  ——  | resurge:zombie_raged_baby<br/>resurge:zombie_raged_jockey | ——         | ——       |



### 复生-生物生成-满月变体

添加了满月变体组件组的生成事件。

#### resurge:as_adult_moon

| 条件 | 添加组件组                                           | 移除组件组 | 执行命令 |
| :--: | :--------------------------------------------------- | :--------- | :------- |
|  ——  | resurge:zombie_raged_adult<br />resurge:moon_variant | ——         | ——       |

#### resurge:as_baby_moon

| 条件 | 添加组件组                                          | 移除组件组 | 执行命令 |
| :--: | :-------------------------------------------------- | :--------- | :------- |
|  ——  | resurge:zombie_raged_baby<br />resurge:moon_variant | ——         | ——       |

#### resurge:as_baby_jockey_moon

| 条件 | 添加组件组                                                   | 移除组件组 | 执行命令 |
| :--: | :----------------------------------------------------------- | :--------- | :------- |
|  ——  | resurge:zombie_raged_baby<br/>resurge:zombie_raged_jockey<br />resurge:moon_variant | ——         | ——       |



### 复生-满月特殊掉落

生成满月的特殊掉落物。

#### resurge:moon_loot

| 条件 | 添加组件组 | 移除组件组 | 执行命令                                   |
| :--: | :--------- | :--------- | :----------------------------------------- |
|  ——  | ——         | ——         | loot spawn ~~~ loot \"specials/moon_loot\" |



### 复生-湿润属性

根据是否在雨中或水中，激活不同的移速组件组。

#### resurge:become_dry

|              条件               | 添加组件组                 | 移除组件组                 | 执行命令 |
| :-----------------------------: | :------------------------- | :------------------------- | :------- |
| 不具有``minecraft:is_baby``组件 | resurge:dry_movement_adult | resurge:wet_movement_adult | ——       |
|  具有``minecraft:is_baby``组件  | resurge:dry_movement_baby  | resurge:wet_movement_baby  | ——       |

#### resurge:become_wet

|              条件               | 添加组件组                 | 移除组件组                 | 执行命令 |
| :-----------------------------: | :------------------------- | :------------------------- | :------- |
| 不具有``minecraft:is_baby``组件 | resurge:wet_movement_adult | resurge:dry_movement_adult | ——       |
|  具有``minecraft:is_baby``组件  | resurge:wet_movement_baby  | resurge:dry_movement_baby  | ——       |



### 复生-群系属性

根据是否在沙漠或沙滩群系，激活不同的基础属性组件组。

#### resurge:out_biome

|           条件           | 添加组件组                         | 移除组件组                                                   | 执行命令 |
| :----------------------: | :--------------------------------- | :----------------------------------------------------------- | :------- |
|            ——            | resurge:out_biome_property         | resurge:in_biome_property                                    | ——       |
| ``is_mark_variant``等于0 | resurge:out_biome_normal_knockback | resurge:out_biome_hunt_knockback<br />resurge:in_biome_normal_knockback<br />resurge:in_biome_hunt_knockback | ——       |
| ``is_mark_variant``等于1 | resurge:out_biome_hunt_knockback   | resurge:out_biome_normal_knockback<br />resurge:in_biome_normal_knockback<br />resurge:in_biome_hunt_knockback | ——       |

#### resurge:in_biome

|           条件           | 添加组件组                        | 移除组件组                                                   | 执行命令 |
| :----------------------: | :-------------------------------- | :----------------------------------------------------------- | :------- |
|            ——            | resurge:in_biome_property         | resurge:out_biome_property                                   | ——       |
| ``is_mark_variant``等于0 | resurge:in_biome_normal_knockback | resurge:out_biome_normal_knockback<br />resurge:out_biome_hunt_knockback<br />resurge:in_biome_hunt_knockback | ——       |
| ``is_mark_variant``等于1 | resurge:in_biome_hunt_knockback   | resurge:out_biome_normal_knockback<br />resurge:out_biome_hunt_knockback<br />resurge:in_biome_normal_knockback | ——       |



### 复生-猎杀属性

根据是否处于猎杀状态，激活不同的基础属性组件组。

#### resurge:normal_mode

|        条件        | 添加组件组                                           | 移除组件组                                                   | 执行命令 |
| :----------------: | :--------------------------------------------------- | :----------------------------------------------------------- | :------- |
|         ——         | resurge:normal_mark<br />resurge:normal_break_blocks | resurge:hunt_mark<br />resurge:hunt_break_blocks<br />resurge:hunt_timer | ——       |
| 不在沙漠和沙滩群系 | resurge:out_biome_normal_knockback                   | resurge:out_biome_hunt_knockback<br />resurge:in_biome_normal_knockback<br />resurge:in_biome_hunt_knockback | ——       |
|  在沙漠或沙滩群系  | resurge:in_biome_normal_knockback                    | resurge:out_biome_normal_knockback<br />resurge:out_biome_hunt_knockback<br />resurge:in_biome_hunt_knockback | ——       |

#### resurge:hunt_mode

##### 全体额外条件：不具有``minecraft:timer``组件

|        条件        | 添加组件组                                | 移除组件组                                                   | 执行命令                                                     |
| :----------------: | :---------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
|         ——         | resurge:hunt_mark<br />resurge:hunt_timer | resurge:normal_mark                                          | effect @s absorption 8 3 false<br />effect @s resistance 8 0 false |
| 不在沙漠和沙滩群系 | resurge:out_biome_hunt_knockback          | resurge:out_biome_normal_knockback<br />resurge:in_biome_normal_knockback<br />resurge:in_biome_hunt_knockback | ——                                                           |
|  在沙漠或沙滩群系  | resurge:in_biome_hunt_knockback           | resurge:out_biome_normal_knockback<br />resurge:out_biome_hunt_knockback<br />resurge:in_biome_normal_knockback | ——                                                           |
|     不位于水下     | resurge:hunt_break_blocks                 | resurge:normal_break_blocks                                  | ——                                                           |



### 复生-月相阶段

根据是否为满月夜晚，激活或关闭平静计时器。

#### resurge:full_moon_night

|        条件         | 添加组件组 | 移除组件组              | 执行命令 |
| :-----------------: | :--------- | :---------------------- | :------- |
| ``is_variant``等于1 | ——         | resurge:moon_calm_timer | ——       |

#### resurge:non_full_moon_night

|                    条件                     | 添加组件组                                                   | 移除组件组                                                   | 执行命令 |
| :-----------------------------------------: | :----------------------------------------------------------- | :----------------------------------------------------------- | :------- |
|             ``is_variant``等于1             | resurge:normal_mark<br />resurge:normal_break_blocks<br />resurge:moon_calm_timer | resurge:hunt_mark<br />resurge:hunt_break_blocks<br />resurge:hunt_timer | ——       |
| ``is_variant``等于1<br />不在沙漠和沙滩群系 | resurge:out_biome_normal_knockback                           | resurge:out_biome_hunt_knockback<br />resurge:in_biome_normal_knockback<br />resurge:in_biome_hunt_knockback | ——       |
|  ``is_variant``等于1<br />在沙漠或沙滩群系  | resurge:in_biome_normal_knockback                            | resurge:out_biome_normal_knockback<br />resurge:out_biome_hunt_knockback<br />resurge:in_biome_hunt_knockback | ——       |



### 复生-平静相关

控制自身平静。

#### resurge:rage

|                             条件                             | 添加组件组               | 移除组件组 | 执行命令 |
| :----------------------------------------------------------: | :----------------------- | :--------- | :------- |
|               不具有``minecraft:is_baby``组件                | resurge:adult_calm       | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />不具有``minecraft:behavior.find_mount``组件 | resurge:baby_calm        | ——         | ——       |
| 具有``minecraft:is_baby``组件<br />具有``minecraft:behavior.find_mount``组件 | resurge:baby_jockey_calm | ——         | ——       |



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
