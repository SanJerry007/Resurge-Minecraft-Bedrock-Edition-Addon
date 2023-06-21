# zombie

> 全部内容基于僵尸(原版)修改。

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
"zombie", "undead", "monster", "mob"
```

#### minecraft:mark_variant

```json
"value": 0 //标识普通状态
```



### 伤害与抵抗(health|attack)

#### minecraft:health

```json
"value": 48,
"max": 48
```

#### minecraft:attack

```json
"damage": 6
```

#### minecraft:knockback_resistance

```json
"value": 0.64
```



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

#### minecraft:movement.basic

```json
"max_turn": 60.0
```

#### minecraft:navigation.climb

```json
"is_amphibious": true,
"can_pass_doors": true,
"can_walk": true,
"can_break_doors": true
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

#### minecraft:behavior.melee_attack

```json
"speed_multiplier": 1.0,
"track_target": true,
"reach_multiplier": 2.0
```

#### minecraft:behavior.flee_sun

```json
"priority": 5,
"speed_multiplier": 1.2
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
"alert_same_type": true
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

| filters                              | 补充                                  |
| ------------------------------------ | ------------------------------------- |
| 任意其它玩家、友好生物、人类(除女巫) | "max_dist": 32,<br/>"must_see": false |
| 任意其它悦灵、蜜蜂、海龟             | "max_dist": 32,<br/>"must_see": true  |



## component_groups

### 原版-装备

#### ~~minecraft:can_have_equipment~~

##### ~~minecraft:equipment~~

移动至基本组件



### 原版-破门

#### ~~minecraft:can_break_doors~~

##### ~~minecraft:annotation.break_door~~

移动至基本组件



### 原版加-转化溺尸

#### minecraft:convert_to_drowned

##### minecraft:transformation

```json
"drop_equipment": false
```

#### minecraft:convert_to_baby_drowned

##### minecraft:transformation

```json
"drop_equipment": false
```

#### resurge:convert_to_baby_jockey_drowned

##### minecraft:transformation

```json
"into": "minecraft:drowned<resurge:as_baby_jockey>",
"transformation_sound": "convert_to_drowned",
"drop_equipment": false,
"delay": {
    "value": 15
}
```

##### minecraft:is_shaking



### 原版-生成类型

#### minecraft:zombie_baby

##### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 10 + (query.equipment_count * Math.Random(1,6)) : Math.Random(0,1)"
```

##### minecraft:movement

```json
"value": 0.48
```

#### minecraft:zombie_adult

##### minecraft:experience_reward

```json
"on_death": "query.last_hit_by_player ? 5 + (query.equipment_count * Math.Random(1,3)) : Math.Random(0,1)"
```

##### minecraft:movement

```json
"value": 0.32
```

##### minecraft:behavior.mount_pathing

```json
"speed_multiplier": 0.8
```

#### minecraft:zombie_jockey

##### minecraft:behavior.find_mount

```json
"start_delay": 移除
"max_failed_attempts": 移除
```



### 复生-伤害检测器

根据不同月相阶段，在受到致命伤害时，以不同概率触发``resurge:random_select_rage``s事件。

提供恒定的8%伤害减免。

#### resurge:damage_stage0

##### minecraft:damage_sensor

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

转化为狂暴形态。

#### resurge:adult_rage

##### minecraft:transformation

```json
"into": "resurge:zombie_raged<resurge:as_adult>",
"preserve_equipment": true
```

#### resurge:baby_rage

##### minecraft:transformation

```json
"into": "resurge:zombie_raged<resurge:as_baby>",
"preserve_equipment": true
```

#### resurge:baby_jockey_rage

##### minecraft:transformation

```json
"into": "resurge:zombie_raged<resurge:as_baby_jockey>",
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
"into": "resurge:zombie_raged<resurge:as_adult_moon>",
"preserve_equipment": true
```

#### resurge:baby_moon_rage

##### minecraft:transformation

```json
"into": "resurge:zombie_raged<resurge:as_baby_moon>",
"preserve_equipment": true
```

#### resurge:baby_jockey_moon_rage

##### minecraft:transformation

```json
"into": "resurge:zombie_raged<resurge:as_baby_jockey_moon>",
"preserve_equipment": true
```



## events

### 原版加-生物生成

#### minecraft:entity_spawned

##### 序列1

| 权重 | 添加组件组                                        | 移除组件组 | 执行命令 |
| :--: | :------------------------------------------------ | :--------- | :------- |
| 940  | minecraft:zombie_adult                            | ——         | ——       |
|  50  | minecraft:zombie_baby                             | ——         | ——       |
|  10  | minecraft:zombie_baby<br/>minecraft:zombie_jockey | ——         | ——       |

##### ~~序列2~~

| ~~权重~~ | ~~添加组件组~~                | ~~移除组件组~~ | ~~执行命令~~ |
| :------: | :---------------------------- | :------------- | :----------- |
|  ~~10~~  | ~~minecraft:can_break_doors~~ | ~~——~~         | ~~——~~       |
|  ~~90~~  | ~~——~~                        | ~~——~~         | ~~——~~       |

该序列用于随机控制能否破门，此处进行了移除。

#### resurge:as_baby_jockey

| 条件 | 添加组件组                                        | 移除组件组 | 执行命令 |
| :--: | :------------------------------------------------ | :--------- | :------- |
|  ——  | minecraft:zombie_baby<br/>minecraft:zombie_jockey | ——         | ——       |



### 原版-转化溺尸

#### minecraft:start_transforming

|             条件              | 添加组件组                             | 移除组件组                                     | 执行命令 |
| :---------------------------: | :------------------------------------- | :--------------------------------------------- | :------- |
| 不具有``minecraft:timer``组件 | minecraft:start_drowned_transformation | minecraft:look_to_start_drowned_transformation | ——       |

#### minecraft:convert_to_drowned

|                             条件                             | 添加组件组                             | 移除组件组                             | 执行命令 |
| :----------------------------------------------------------: | :------------------------------------- | :------------------------------------- | :------- |
|               不具有``minecraft:is_baby``组件                | minecraft:convert_to_drowned           | minecraft:start_drowned_transformation | ——       |
| 具有``minecraft:is_baby``组件<br />不具有``minecraft:behavior.find_mount``组件 | minecraft:convert_to_baby_drowned      | minecraft:start_drowned_transformation | ——       |
| 具有``minecraft:is_baby``组件<br />具有``minecraft:behavior.find_mount``组件 | resurge:convert_to_baby_jockey_drowned | minecraft:start_drowned_transformation | ——       |



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

##### 序列1 <!--主动关闭溺尸转换，以使用新的timer组件-->

| 条件 | 添加组件组                                     | 移除组件组                             | 执行命令 |
| :--: | :--------------------------------------------- | :------------------------------------- | :------- |
|  ——  | minecraft:look_to_start_drowned_transformation | minecraft:start_drowned_transformation | ——       |

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
