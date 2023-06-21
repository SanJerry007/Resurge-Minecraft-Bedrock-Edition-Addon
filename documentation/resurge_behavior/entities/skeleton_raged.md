# skeleton_raged

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

### runtime_identifier

```json
minecraft:skeleton
```

### scripts—animate

|    名称    | 条件 | 备注 |
| :--------: | :--: | :--: |
| moon_stage |  ——  |  ——  |

### animations

|    名称    |                     内容                      |            备注            |
| :--------: | :-------------------------------------------: | :------------------------: |
| moon_stage | controller.animation.entity.normal.moon_stage | 根据不同月相，调用不同事件 |



## components

> 该部分内容基于骷髅(复生)修改。

### 生物标识(type_family|variant)

#### minecraft:type_family

```json
"skeleton_raged", "raged", "skeleton", "undead", "monster", "mob"
```



### 伤害与抵抗(health|attack)

#### minecraft:health

```json
"value": 48,
"max": 48
```



### 环境交互(break_blocks|shareables)



### 生成与掉落(equipment|loot|experience_reward)

#### minecraft:loot

```json
"table": "loot_tables/entities/skeleton.json"
```

#### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 14 + (query.equipment_count * Math.Random(1,6)) : Math.Random(0,1)"
```



### 寻路与移动(movement)

#### minecraft:navigation.fly

```json
"avoid_sun": false
```

#### minecraft:movement

```json
"value": 0.5
```

#### minecraft:underwater_movement

```json
"value": 0.2
```

#### minecraft:follow_range

```json
"value": 60,
"max": 60
```



### 行为系列(behavior)

#### minecraft:behavior.summon_entity

```json
"summon_choices": [
    {
        "particle_color": "#FF1CBBFF",
        "sequence": [
            {
                "entity_type": "resurge:silverfish_fossilized",
            }
        ]
    }
]
```

#### minecraft:behavior.hurt_by_target

**entity_types：**

| filters                                | 补充 |
| -------------------------------------- | ---- |
| 排除其它骷髅、女巫、节肢动物、狂暴生物 | ——   |

#### minecraft:behavior.nearest_attackable_target

```json
"persist_time": 5,
"within_radius": 60.0, //因定义了follow_range，此处实际无效
```

**entity_types：**

| filters                          | 补充            |
| -------------------------------- | --------------- |
| 任意其它玩家、友好生物、黑暗生物 | "max_dist": 40, |
| 任意其它悦灵、蜜蜂、海龟、狼     | "max_dist": 40, |

#### ~~minecraft:behavior.flee_sun~~



## component_groups

> 该部分由空白创建。

### 复生-满月变体

标记由满月夜晚转化而来的实体。

#### resurge:moon_variant

##### minecraft:variant

```json
"value": 1
```



### 复生-普通模式

普通状态下的各个属性，包含雷击反伤，攻击模式切换，方块破坏等。

#### resurge:normal_mode_controller

##### minecraft:mark_variant

```json
"value": 0 //标识普通状态
```

##### minecraft:environment_sensor

| filters    | event                      | target |
| ---------- | -------------------------- | ------ |
| 无远程武器 | resurge:normal_melee_mode  | ——     |
| 有远程武器 | resurge:normal_ranged_mode | ——     |

#### resurge:normal_melee_mode

##### minecraft:behavior.melee_attack

```json
"priority": 1,
"track_target": true,
"speed_multiplier": 1.0
```

##### minecraft:attack

```json
"damage": 7
```

##### minecraft:environment_sensor

| filters    | event                      | target |
| ---------- | -------------------------- | ------ |
| 有远程武器 | resurge:normal_ranged_mode | ——     |

#### resurge:normal_ranged_mode

##### minecraft:behavior.avoid_mob_type

```json
"priority": 0,
"avoid_target_xz": 24,
"avoid_target_y": 12,
"max_dist": 12,
"max_flee": 4,
"ignore_visibility": false
```

**entity_types：**

| filters                            | 补充           |
| ---------------------------------- | -------------- |
| 自身目标/玩家/友好生物/黑暗生物/狼 | "max_dist": 12 |

##### minecraft:behavior.ranged_attack

```json
"priority": 1,
"attack_interval_min": 0.8,
"attack_interval_max": 2.4,
"attack_radius": 40.0,
"speed_multiplier": 1.0,
"x_max_rotation": 60.0,
"y_max_head_rotation": 60.0
```

##### minecraft:shooter

```json
"def": "resurge:arrow_mob<resurge:skeleton_raged_arrow>"
```

##### minecraft:environment_sensor

| filters    | event                     | target |
| ---------- | ------------------------- | ------ |
| 无远程武器 | resurge:normal_melee_mode | ——     |

#### resurge:normal_break_blocks

| 类别               | 范围               |
| ------------------ | ------------------ |
| 怪物基础可破坏物品 | 排除 *<u>细雪</u>* |



### 复生-充能模式

充能状态下的各个属性，包含雷击反伤，攻击模式切换，方块破坏等。

#### resurge:power_mode_controller

##### minecraft:mark_variant

```json
"value": 1 //标识充能状态
```

##### minecraft:environment_sensor

| filters    | event                     | target |
| ---------- | ------------------------- | ------ |
| 无远程武器 | resurge:power_melee_mode  | ——     |
| 有远程武器 | resurge:power_ranged_mode | ——     |

##### minecraft:timer

```json
"looping": false,
"time": 16.0,
"time_down_event": {
    "event": "resurge:lost_power"
}
```

#### resurge:power_melee_mode

##### minecraft:behavior.melee_attack

```json
"priority": 1,
"track_target": true,
"speed_multiplier": 1.0,
"cooldown_time": 0.5
```

##### minecraft:attack

```json
"damage": 7
```

##### minecraft:environment_sensor

| filters    | event                     | target |
| ---------- | ------------------------- | ------ |
| 有远程武器 | resurge:power_ranged_mode | ——     |

#### resurge:power_ranged_mode

##### minecraft:behavior.avoid_mob_type

```json
"priority": 0,
"avoid_target_xz": 16,
"avoid_target_y": 8,
"max_dist": 8,
"max_flee": 4,
"ignore_visibility": false
```

**entity_types：**

| filters                            | 补充          |
| ---------------------------------- | ------------- |
| 自身目标/玩家/友好生物/黑暗生物/狼 | "max_dist": 8 |

##### minecraft:behavior.ranged_attack

```json
"priority": 1,
"attack_interval_min": 0.4,
"attack_interval_max": 1.2,
"attack_radius": 40.0,
"speed_multiplier": 1.0,
"x_max_rotation": 60.0,
"y_max_head_rotation": 60.0
```

##### minecraft:shooter

```json
"def": "resurge:arrow_mob<resurge:skeleton_raged_arrow>"
```

##### minecraft:environment_sensor

| filters    | event                    | target |
| ---------- | ------------------------ | ------ |
| 无远程武器 | resurge:power_melee_mode | ——     |

#### resurge:power_break_blocks

##### minecraft:break_blocks

| 类别               | 范围                           |
| ------------------ | ------------------------------ |
| 怪物基础可破坏物品 | 排除 *<u>细雪</u>*             |
| 工作类方块         | 方块(不重要)                   |
| 红石类物品         | <u>*绊线钩*</u>、<u>*活塞*</u> |
| 木质方块           | 所有                           |
| 硬度[0,1]的方块    | 所有                           |
| 硬度(1,2)的方块    | 所有                           |
| 硬度2的方块        | <u>*圆石*</u>、<u>*苔石*</u>   |
| 动物与植物类物品   | 方块、半实心方块               |
| 其它装饰性方块     | 方块、<u>*海龟蛋*</u>          |



### 复生-伤害检测器

提供恒定的摔落伤害免疫。

在受到闪电伤害时，免疫伤害并触发``resurge:has_power``事件。

根据不同月相阶段，在受到伤害时，以不同概率触发``resurge:has_power``事件。

根据自身状态，在受到生物攻击时，以不同概率触发``universal:lightning_bolt_attack``事件。

#### resurge:damage_stage0

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event             | target |
| ---------------- | ----------------- | ------ |
| 自身受到闪电伤害 | resurge:has_power | self   |

```json
"deals_damage": false
```

###### trigger 3

| filters                                                      | event             | target |
| ------------------------------------------------------------ | ----------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. 自身受到致命伤害，1/5概率<br />2. 自身受到非致命伤害，1/64概率 | resurge:has_power | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                           | target |
| ------------------------------------------------------------ | ------------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. mark_variant等于0，1/10概率<br />2. mark_variant等于1，1/5概率 | universal:lightning_bolt_attack | other  |

#### resurge:damage_stage1

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event             | target |
| ---------------- | ----------------- | ------ |
| 自身受到闪电伤害 | resurge:has_power | self   |

```json
"deals_damage": false
```

###### trigger 3

| filters                                                      | event             | target |
| ------------------------------------------------------------ | ----------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. 自身受到致命伤害，1/5概率<br />2. 自身受到非致命伤害，1/48概率 | resurge:has_power | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                           | target |
| ------------------------------------------------------------ | ------------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. mark_variant等于0，1/10概率<br />2. mark_variant等于1，1/5概率 | universal:lightning_bolt_attack | other  |

#### resurge:damage_stage2

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event             | target |
| ---------------- | ----------------- | ------ |
| 自身受到闪电伤害 | resurge:has_power | self   |

```json
"deals_damage": false
```

###### trigger 3

| filters                                                      | event             | target |
| ------------------------------------------------------------ | ----------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. 自身受到致命伤害，1/5概率<br />2. 自身受到非致命伤害，1/36概率 | resurge:has_power | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                           | target |
| ------------------------------------------------------------ | ------------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. mark_variant等于0，1/10概率<br />2. mark_variant等于1，1/5概率 | universal:lightning_bolt_attack | other  |

#### resurge:damage_stage3

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event             | target |
| ---------------- | ----------------- | ------ |
| 自身受到闪电伤害 | resurge:has_power | self   |

```json
"deals_damage": false
```

###### trigger 3

| filters                                                      | event             | target |
| ------------------------------------------------------------ | ----------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. 自身受到致命伤害，1/5概率<br />2. 自身受到非致命伤害，1/27概率 | resurge:has_power | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                           | target |
| ------------------------------------------------------------ | ------------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. mark_variant等于0，1/10概率<br />2. mark_variant等于1，1/5概率 | universal:lightning_bolt_attack | other  |

#### resurge:damage_stage4

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event             | target |
| ---------------- | ----------------- | ------ |
| 自身受到闪电伤害 | resurge:has_power | self   |

```json
"deals_damage": false
```

###### trigger 3

| filters                                                      | event             | target |
| ------------------------------------------------------------ | ----------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. 自身受到致命伤害，1/5概率<br />2. 自身受到非致命伤害，1/21概率 | resurge:has_power | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                           | target |
| ------------------------------------------------------------ | ------------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />下述中任意一条满足：<br />1. mark_variant等于0，1/10概率<br />2. mark_variant等于1，1/5概率 | universal:lightning_bolt_attack | other  |

#### 

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
"into": "minecraft:skeleton",
"preserve_equipment": true
```



## events

> 该部分由空白创建。

### 原版-生物生成

#### minecraft:entity_spawned

此事件为空。



### 复生-生物生成-满月变体

#### resurge:from_moon

添加了满月变体组件组的生成事件。

| 条件 | 添加组件组           | 移除组件组 | 执行命令 |
| :--: | :------------------- | :--------- | :------- |
|  ——  | resurge:moon_variant | ——         | ——       |



### 复生-充能检测

根据是否充能，启用不同模式的控制器组件组。

#### resurge:has_power

**全体额外条件：不具有``minecraft:timer``组件**

|   条件   | 添加组件组                    | 移除组件组                                                   | 执行命令                                                     |
| :------: | :---------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
|    ——    | resurge:power_mode_controller | resurge:normal_mode_controller<br />resurge:normal_melee_mode<br />resurge:normal_ranged_mode | effect @s absorption 16 3 false<br />effect @s resistance 16 0 false |
| 不在水下 | resurge:power_break_blocks    | resurge:normal_break_blocks                                  | ——                                                           |

#### resurge:lost_power

**全体额外条件：不具有``minecraft:timer``组件**

| 条件 | 添加组件组                                                   | 移除组件组                                                   | 执行命令 |
| :--: | :----------------------------------------------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:normal_mode_controller<br />resurge:normal_break_blocks | resurge:power_mode_controller<br />resurge:power_melee_mode<br />resurge:power_ranged_mode<br />resurge:power_break_blocks | ——       |



### 复生-普通模式-攻击方式切换

在普通模式下，进行近战与远程攻击方式的切换。

#### resurge:normal_melee_mode

| 条件 | 添加组件组                | 移除组件组                 | 执行命令 |
| :--: | :------------------------ | :------------------------- | :------- |
|  ——  | resurge:normal_melee_mode | resurge:normal_ranged_mode | ——       |

#### resurge:normal_ranged_mode

| 条件 | 添加组件组                 | 移除组件组                | 执行命令 |
| :--: | :------------------------- | :------------------------ | :------- |
|  ——  | resurge:normal_ranged_mode | resurge:normal_melee_mode | ——       |



### 复生-充能模式-攻击方式切换

在充能模式下，进行近战与远程攻击方式的切换。

#### resurge:power_melee_mode

| 条件 | 添加组件组               | 移除组件组                | 执行命令 |
| :--: | :----------------------- | :------------------------ | :------- |
|  ——  | resurge:power_melee_mode | resurge:power_ranged_mode | ——       |

#### resurge:power_ranged_mode

| 条件 | 添加组件组                | 移除组件组               | 执行命令 |
| :--: | :------------------------ | :----------------------- | :------- |
|  ——  | resurge:power_ranged_mode | resurge:power_melee_mode | ——       |



### 复生-月相阶段

根据不同月相，激活不同的伤害传感器。

根据是否为满月夜晚，激活或关闭平静计时器。

#### resurge:moon_stage0

|        条件         | 添加组件组                                                   | 移除组件组                                                   | 执行命令 |
| :-----------------: | :----------------------------------------------------------- | :----------------------------------------------------------- | :------- |
| ``is_variant``等于1 | resurge:normal_mode_controller<br />resurge:normal_break_blocks<br />resurge:moon_calm_timer | resurge:power_mode_controller<br />resurge:power_melee_mode<br />resurge:power_ranged_mode<br />resurge:power_break_blocks | ——       |
|         ——          | resurge:damage_stage0                                        | resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage3<br/>resurge:damage_stage4 | ——       |

#### resurge:moon_stage1

|        条件         | 添加组件组                                                   | 移除组件组                                                   | 执行命令 |
| :-----------------: | :----------------------------------------------------------- | :----------------------------------------------------------- | :------- |
| ``is_variant``等于1 | resurge:normal_mode_controller<br />resurge:normal_break_blocks<br />resurge:moon_calm_timer | resurge:power_mode_controller<br />resurge:power_melee_mode<br />resurge:power_ranged_mode<br />resurge:power_break_blocks | ——       |
|         ——          | resurge:damage_stage1                                        | resurge:damage_stage0<br/>resurge:damage_stage2<br/>resurge:damage_stage3<br/>resurge:damage_stage4 | ——       |

#### resurge:moon_stage2

|        条件         | 添加组件组                                                   | 移除组件组                                                   | 执行命令 |
| :-----------------: | :----------------------------------------------------------- | :----------------------------------------------------------- | :------- |
| ``is_variant``等于1 | resurge:normal_mode_controller<br />resurge:normal_break_blocks<br />resurge:moon_calm_timer | resurge:power_mode_controller<br />resurge:power_melee_mode<br />resurge:power_ranged_mode<br />resurge:power_break_blocks | ——       |
|         ——          | resurge:damage_stage2                                        | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage3<br/>resurge:damage_stage4 | ——       |

#### resurge:moon_stage3

|        条件         | 添加组件组                                                   | 移除组件组                                                   | 执行命令 |
| :-----------------: | :----------------------------------------------------------- | :----------------------------------------------------------- | :------- |
| ``is_variant``等于1 | resurge:normal_mode_controller<br />resurge:normal_break_blocks<br />resurge:moon_calm_timer | resurge:power_mode_controller<br />resurge:power_melee_mode<br />resurge:power_ranged_mode<br />resurge:power_break_blocks | ——       |
|         ——          | resurge:damage_stage3                                        | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage4 | ——       |

#### resurge:moon_stage4_day

|        条件         | 添加组件组                                                   | 移除组件组                                                   | 执行命令 |
| :-----------------: | :----------------------------------------------------------- | :----------------------------------------------------------- | :------- |
| ``is_variant``等于1 | resurge:normal_mode_controller<br />resurge:normal_break_blocks<br />resurge:moon_calm_timer | resurge:power_mode_controller<br />resurge:power_melee_mode<br />resurge:power_ranged_mode<br />resurge:power_break_blocks | ——       |
|         ——          | resurge:damage_stage4                                        | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage3 | ——       |

#### resurge:moon_stage4_night

|        条件         | 添加组件组              | 移除组件组                                                   | 执行命令 |
| :-----------------: | :---------------------- | :----------------------------------------------------------- | :------- |
| ``is_variant``等于1 | resurge:moon_calm_timer | ——                                                           | ——       |
|         ——          | resurge:damage_stage4   | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage3 | ——       |



### 复生-平静相关

控制自身平静。

#### resurge:rage

| 条件 | 添加组件组         | 移除组件组 | 执行命令 |
| :--: | :----------------- | :--------- | :------- |
|  ——  | resurge:adult_calm | ——         | ——       |



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













