# skeleton

> 全部内容基于骷髅(原版)修改。

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

### scripts—animate

|    名称    | 条件 | 备注 |
| :--------: | :--: | :--: |
| moon_stage |  ——  |  ——  |

### animations

|    名称    |                     内容                      |            备注            |
| :--------: | :-------------------------------------------: | :------------------------: |
| moon_stage | controller.animation.entity.normal.moon_stage | 根据不同月相，调用不同事件 |



## components

### 生物标识(type_family|variant)

#### minecraft:type_family

```json
"skeleton", "undead", "monster", "mob"
```



### 伤害与抵抗(health|attack)

#### minecraft:health

```json
"value": 36,
"max": 36
```

#### ~~minecraft:burns_in_daylight~~



### 环境交互(break_blocks|shareables)

#### minecraft:break_blocks

| 类别               | 范围               |
| ------------------ | ------------------ |
| 怪物基础可破坏物品 | 排除 *<u>细雪</u>* |

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



### 生成与掉落(equipment|loot|experience_reward)

#### minecraft:equipment

```json
"table": "loot_tables/entities/skeleton_gear.json",
"slot_drop_chance": [
    {
        "slot": "slot.weapon.mainhand",
        "drop_chance": 0.05
    }
]
```

#### minecraft:loot

```json
"table": "loot_tables/entities/skeleton_raged.json"
```

#### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 7 + (query.equipment_count * Math.Random(1,3)) : Math.Random(0,1)"
```



### 寻路与移动(movement)

#### ~~minecraft:navigation.walk~~

#### minecraft:movement.basic

```json
"max_turn": 60.0
```

#### minecraft:navigation.fly

```json
"is_amphibious": true,
"avoid_sun": true,
"avoid_water": true,
"can_swim": true,
"can_path_over_water": true
```

#### minecraft:friction_modifier

```json
"value": 1.0
```

#### minecraft:movement

```json
"value": 0.4
```

#### minecraft:underwater_movement

```json
"value": 0.16
```

#### minecraft:preferred_path

```json
"max_fall_blocks": 256
```

#### minecraft:follow_range

```json
"value": 48,
"max": 48
```

#### minecraft:floats_in_liquid

#### minecraft:can_fly



### 行为系列(behavior)

#### minecraft:behavior.summon_entity

```json
"priority": 0,
"summon_choices": [
    {
        "min_activation_range": 0.0,
        "max_activation_range": 12.0,
        "cooldown_time": 90.0,
        "weight": 1,
        "cast_duration": 1.6,
        "do_casting": true,
        "particle_color": "#FFE9E9E9",
        "start_sound_event": "cast.spell",
        "sequence": [
            {
                "shape": "circle",
                "target": "self",
                "base_delay": 1.0,
                "delay_per_summon": 0.2,
                "summon_cap": 6,
                "summon_cap_radius": 10.0,
                "entity_type": "minecraft:silverfish",
                "num_entities_spawned": 3,
                "entity_lifespan": 120,
                "size": 1.0
            }
        ]
    }
]
```

#### ~~minecraft:behavior.ranged_attack~~

#### minecraft:behavior.hurt_by_target

```json
"priority": 2,
"alert_same_type": true,
```

**entity_types：**

| filters                      | 补充 |
| ---------------------------- | ---- |
| 排除其它骷髅、女巫、节肢动物 | ——   |

#### minecraft:behavior.nearest_attackable_target

```json
"priority": 3,
"must_reach": false,
"must_see": false, //因filter内部进行了定义，此处实际无效
"must_see_forget_duration": 20.0,
"persist_time": 3,
"reselect_targets": true,
"within_radius": 48.0, //因定义了follow_range，此处实际无效
```

**entity_types：**

| filters                      | 补充                                  |
| ---------------------------- | ------------------------------------- |
| 任意其它玩家、友好生物       | "max_dist": 32,<br/>"must_see": false |
| 任意其它悦灵、蜜蜂、海龟、狼 | "max_dist": 32,<br/>"must_see": true  |

#### minecraft:behavior.flee_sun

```json
"priority": 3,
"speed_multiplier": 1.2
```

#### ~~minecraft:behavior.avoid_mob_type~~

#### minecraft:behavior.equip_item

```json
"priority": 4
```

#### minecraft:behavior.pickup_items

```json
"max_dist": 6,
"goal_radius": 3,
```



### 传感器与触发(sensor|trigger)

#### minecraft:environment_sensor

| filters    | event                      | target |
| ---------- | -------------------------- | ------ |
| 无远程武器 | resurge:normal_melee_mode  | ——     |
| 有远程武器 | resurge:normal_ranged_mode | ——     |



## component_groups

### 原版-转化流浪者

#### got_out_of_powder_snow_environment_sensor

##### minecraft:environment_sensor

| filters    | event                      | target |
| ---------- | -------------------------- | ------ |
| 无远程武器 | resurge:normal_melee_mode  | ——     |
| 有远程武器 | resurge:normal_ranged_mode | ——     |



### 原版-闪电免疫

#### ~~minecraft:lightning_immune~~

##### ~~minecraft:damage_sensor~~

移动至``复生-伤害检测器``的各个组件组中。



### 原版-攻击模式切换

#### ~~minecraft:ranged_attack~~

#### ~~minecraft:melee_attack~~

合并为``复生-普通攻击模式切换``组件组。



### 复生-普通攻击模式切换

在普通状态下，切换不同的近战与远程攻击方式。

#### resurge:normal_melee_mode

##### minecraft:mark_variant

```json
"value": 0 //标识普通状态
```

##### minecraft:behavior.melee_attack

```json
"priority": 1,
"track_target": true,
"speed_multiplier": 1.0
```

##### minecraft:attack

```json
"damage": 5
```

##### minecraft:environment_sensor

| filters    | event                      | target |
| ---------- | -------------------------- | ------ |
| 有远程武器 | resurge:normal_ranged_mode | ——     |
| 在细雪中   | got_in_powder_snow         | ——     |

#### resurge:normal_ranged_mode

##### minecraft:mark_variant

```json
"value": 0 //标识普通状态
```

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
"attack_interval_min": 0.8,
"attack_interval_max": 2.4,
"attack_radius": 32.0,
"speed_multiplier": 1.0,
"x_max_rotation": 60.0,
"y_max_head_rotation": 60.0
```

##### minecraft:shooter

```json
"def": "resurge:arrow_mob<resurge:skeleton_arrow>"
```

##### minecraft:environment_sensor

| filters    | event                     | target |
| ---------- | ------------------------- | ------ |
| 无远程武器 | resurge:normal_melee_mode | ——     |
| 在细雪中   | got_in_powder_snow        | ——     |



### 复生-死门属性

在死门状态下，自身攻速翻倍，受到伤害时 反击攻击者1点真实伤害。

同时自身随时间，每0.8秒受到1点伤害。

#### resurge:death_door_property

##### minecraft:mark_variant

```json
"value": 1 //标识死门状态
```

##### minecraft:damage_over_time

```json
"damage_per_hurt": 1,
"time_between_hurt": 0.8
```



### 复生-死门攻击模式切换

在死门状态下，切换不同的近战与远程攻击方式。

#### resurge:death_door_melee_attack

##### minecraft:behavior.melee_attack

```json
"priority": 1,
"track_target": true,
"speed_multiplier": 1.0,
"cooldown_time": 0.5
```

##### minecraft:attack

```json
"damage": 5
```

##### minecraft:environment_sensor

| filters    | event                          | target |
| ---------- | ------------------------------ | ------ |
| 有远程武器 | resurge:death_door_ranged_mode | ——     |

#### resurge:death_door_ranged_attack

##### minecraft:behavior.avoid_mob_type

```json
"priority": 0,
"avoid_target_xz": 12,
"avoid_target_y": 6,
"max_dist": 6,
"max_flee": 4,
"ignore_visibility": false
```

**entity_types：**

| filters                            | 补充          |
| ---------------------------------- | ------------- |
| 自身目标/玩家/友好生物/黑暗生物/狼 | "max_dist": 6 |

##### minecraft:behavior.ranged_attack

```json
"priority": 1,
"attack_interval_min": 0.4,
"attack_interval_max": 1.2,
"attack_radius": 20.0,
"speed_multiplier": 1.0,
"x_max_rotation": 60.0,
"y_max_head_rotation": 60.0
```

##### minecraft:shooter

```json
"def": "resurge:arrow_mob<resurge:skeleton_arrow>"
```

##### minecraft:environment_sensor

| filters    | event                         | target |
| ---------- | ----------------------------- | ------ |
| 无远程武器 | resurge:death_door_melee_mode | ——     |



### 复生-伤害检测器

提供恒定的摔落伤害免疫。

在受到闪电伤害时，免疫伤害并触发``resurge:rage``事件。

根据不同月相阶段，在受到致命伤害时，以不同概率触发``resurge:random_select_rage``事件。

在死门状态受到生物攻击时，概率触发``universal:get_real_damage_1``事件。

#### resurge:damage_stage0

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event        | target |
| ---------------- | ------------ | ------ |
| 自身受到闪电伤害 | resurge:rage | self   |

```json
"deals_damage": false
```

###### trigger 3

| filters                                                      | event                       | target |
| ------------------------------------------------------------ | --------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />mark_variant等于1 | universal:get_real_damage_1 | other  |

#### resurge:damage_stage1

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event        | target |
| ---------------- | ------------ | ------ |
| 自身受到闪电伤害 | resurge:rage | self   |

```json
"deals_damage": false
```

###### trigger 3

**on_damage：**

| filters                                           | event                      | target |
| ------------------------------------------------- | -------------------------- | ------ |
| 自身受到致命伤害，1/32概率<br />mark_variant等于0 | resurge:random_select_rage | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                       | target |
| ------------------------------------------------------------ | --------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />mark_variant等于1 | universal:get_real_damage_1 | other  |

#### resurge:damage_stage2

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event        | target |
| ---------------- | ------------ | ------ |
| 自身受到闪电伤害 | resurge:rage | self   |

```json
"deals_damage": false
```

###### trigger 3

**on_damage：**

| filters                                           | event                      | target |
| ------------------------------------------------- | -------------------------- | ------ |
| 自身受到致命伤害，1/16概率<br />mark_variant等于0 | resurge:random_select_rage | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                       | target |
| ------------------------------------------------------------ | --------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />mark_variant等于1 | universal:get_real_damage_1 | other  |

#### resurge:damage_stage3

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event        | target |
| ---------------- | ------------ | ------ |
| 自身受到闪电伤害 | resurge:rage | self   |

```json
"deals_damage": false
```

###### trigger 3

**on_damage：**

| filters                                          | event                      | target |
| ------------------------------------------------ | -------------------------- | ------ |
| 自身受到致命伤害，1/8概率<br />mark_variant等于0 | resurge:random_select_rage | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                       | target |
| ------------------------------------------------------------ | --------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />mark_variant等于1 | universal:get_real_damage_1 | other  |

#### resurge:damage_stage4

##### minecraft:damage_sensor

###### trigger 1

```json
"cause": "fall",
"deals_damage": false
```

###### trigger 2

**on_damage：**

| filters          | event        | target |
| ---------------- | ------------ | ------ |
| 自身受到闪电伤害 | resurge:rage | self   |

```json
"deals_damage": false
```

###### trigger 3

**on_damage：**

| filters                                          | event                      | target |
| ------------------------------------------------ | -------------------------- | ------ |
| 自身受到致命伤害，1/4概率<br />mark_variant等于0 | resurge:random_select_rage | self   |

```json
"damage_modifier": -10000 //此处使用减法将伤害降至0，以正常显示受伤动画
```

###### trigger 4

| filters                                                      | event                       | target |
| ------------------------------------------------------------ | --------------------------- | ------ |
| 受到``attack``/``magic``/``projectile``/``sonic_boom``伤害<br />mark_variant等于1 | universal:get_real_damage_1 | other  |



### 复生-狂暴

转化为狂暴形态。

#### resurge:rage

##### minecraft:transformation

```json
"into": "resurge:skeleton_raged",
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

#### resurge:moon_rage

##### minecraft:transformation

```json
"into": "resurge:skeleton_raged<resurge:from_moon>",
"preserve_equipment": true
```



## events

### 原版-生物生成

#### minecraft:entity_spawned

| 权重 | 添加组件组 | 移除组件组 | 执行命令 |
| :--: | :--------- | :--------- | :------- |
|  ——  | ——         | ——         | ——       |

此处全部删除留空。



### 原版-骷髅马陷阱

#### ~~minecraft:spring_trap~~

进行移除。



### 原版-攻击模式切换

#### ~~minecraft:melee_mode~~

#### ~~minecraft:ranged_mode~~

重做为``复生-普通攻击模式切换``事件。



### 复生-普通攻击模式切换

#### resurge:normal_melee_mode

| 条件 | 添加组件组                | 移除组件组                                                   | 执行命令 |
| :--: | :------------------------ | :----------------------------------------------------------- | :------- |
|  ——  | resurge:normal_melee_mode | resurge:normal_ranged_mode<br />got_out_of_powder_snow_environment_sensor | ——       |

#### resurge:normal_ranged_mode

| 条件 | 添加组件组                 | 移除组件组                                                   | 执行命令 |
| :--: | :------------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:normal_ranged_mode | resurge:normal_melee_mode<br />got_out_of_powder_snow_environment_sensor | ——       |



### 复生-死门攻击模式切换

#### resurge:death_door_melee_mode

| 条件 | 添加组件组                      | 移除组件组                                                   | 执行命令 |
| :--: | :------------------------------ | :----------------------------------------------------------- | :------- |
|  ——  | resurge:death_door_melee_attack | resurge:death_door_ranged_mode<br />in_powder_snow<br />got_out_of_powder_snow_environment_sensor | ——       |

#### resurge:death_door_ranged_mode

| 条件 | 添加组件组                       | 移除组件组                                                   | 执行命令 |
| :--: | :------------------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:death_door_ranged_attack | resurge:death_door_melee_mode<br />in_powder_snow<br />got_out_of_powder_snow_environment_sensor | ——       |



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
| :--: | :-------------------- | :----------------------------------------------------------- | -------- |
|  ——  | resurge:damage_stage4 | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage3<br />resurge:moon_rage_timer | ——       |

#### resurge:moon_stage4_night

##### 序列1 <!--主动关闭流浪者转换，以使用新的timer组件-->

| 条件 | 添加组件组 | 移除组件组     | 执行命令 |
| :--: | :--------- | :------------- | :------- |
|  ——  | ——         | in_powder_snow | ——       |

##### 序列2 <!--如果不在死门状态，添加细雪传感器-->

|                   条件                   | 添加组件组                                | 移除组件组 | 执行命令 |
| :--------------------------------------: | :---------------------------------------- | :--------- | :------- |
| 不具有``minecraft:damage_over_time``组件 | got_out_of_powder_snow_environment_sensor | ——         | ——       |

##### 序列3

| 条件 | 添加组件组                                         | 移除组件组                                                   | 执行命令 |
| :--: | :------------------------------------------------- | :----------------------------------------------------------- | :------- |
|  ——  | resurge:damage_stage4<br />resurge:moon_rage_timer | resurge:damage_stage0<br/>resurge:damage_stage1<br/>resurge:damage_stage2<br/>resurge:damage_stage3 | ——       |



### 复生-随机选择濒死效果

用于死门技能，随机选择自身直接狂暴，或者进入死门状态。

#### resurge:random_select_rage

##### 权重：60

| 权重 | 添加组件组   | 移除组件组 | 执行命令 |
| :--: | :----------- | :--------- | :------- |
|  ——  | resurge:rage | ——         | ——       |

##### 权重：40

|          条件          | 添加组件组                       | 移除组件组                                                   | 执行命令                                                     |
| :--------------------: | :------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
|  在水下 或 无远程武器  | resurge:death_door_melee_attack  | ——                                                           | ——                                                           |
| 不在水下 且 有远程武器 | resurge:death_door_ranged_attack | ——                                                           | ——                                                           |
|           ——           | resurge:death_door_property      | in_powder_snow<br />got_out_of_powder_snow_environment_sensor | effect @s resistance 600 3 false<br />effect @s speed 600 1 false |



### 复生-狂暴相关

控制自身狂暴，有随机、必定、满月三种方式。

随机：用于其它生物向自身发送狂暴信号时进行判断。

#### resurge:random_rage

| 权重 | 添加组件组   | 移除组件组 | 执行命令 |
| :--: | :----------- | :--------- | :------- |
|  75  | ——           | ——         | ——       |
|  25  | resurge:rage | ——         | ——       |

#### resurge:rage

| 条件 | 添加组件组   | 移除组件组 | 执行命令 |
| :--: | :----------- | :--------- | :------- |
|  ——  | resurge:rage | ——         | ——       |

#### resurge:moon_rage

| 条件 | 添加组件组        | 移除组件组 | 执行命令 |
| :--: | :---------------- | :--------- | :------- |
|  ——  | resurge:moon_rage | ——         | ——       |



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
