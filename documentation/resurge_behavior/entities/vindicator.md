# vindicator

> 全部内容基于卫道士(原版)修改。

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

### scripts—animate

| 名称 | 条件 | 备注 |
| :--: | :--: | :--: |

### animations

| 名称 | 内容 | 备注 |
| :--: | :--: | :--: |

### runtime_identifier



## components

### 生物标识(type_family|variant)

#### minecraft:type_family

```json
"vindicator", "human", "monster", "illager", "mob"
```

#### minecraft:variant

```json

```

#### minecraft:mark_variant

```json

```



### 伤害与抵抗(health|attack)

#### minecraft:health

```json

```

#### minecraft:attack

```json

```

#### minecraft:knockback_resistance

```json

```

#### minecraft:burns_in_daylight



### 环境交互(break_blocks|shareables)

#### minecraft:break_blocks

| 类别 | 范围 |
| ---- | ---- |
|      |      |

#### minecraft:annotation.break_door

```json

```

#### minecraft:shareables

**items：**

```json

```



### 生成与掉落(equipment|loot)

#### minecraft:equipment

```json

```

#### minecraft:loot

```json

```



### 寻路与移动(movement)

#### minecraft:movement.basic

```json

```

#### minecraft:navigation.walk

```json

```

#### minecraft:navigation.climb

```json

```

#### minecraft:preferred_path

```json

```

#### minecraft:follow_range

```json

```



### 行为系列(behavior)

#### minecraft:behavior.equip_item

```json

```

#### minecraft:behavior.melee_attack

```json

```

#### minecraft:behavior.stomp_turtle_egg

```json

```

#### minecraft:behavior.flee_sun

```json

```

#### minecraft:behavior.pickup_items

```json

```

#### minecraft:behavior.random_stroll

```json

```

#### minecraft:behavior.look_at_player

```json

```

#### minecraft:behavior.random_look_around

```json

```

#### minecraft:behavior.hurt_by_target

```json

```

**entity_types：**

| filters | 补充 |
| ------- | ---- |
|         |      |

#### minecraft:behavior.nearest_attackable_target

```json

```

**entity_types：**

| filters | 补充 |
| ------- | ---- |
|         |      |



### 传感器与触发(sensor|trigger)

#### minecraft:environment_sensor

```json

```

#### minecraft:damage_sensor

##### trigger 1

**on_damage：**

| filters | event | target |
| ------- | ----- | ------ |
|         |       |        |

```json

```

#### minecraft:on_death

| filters | event | target |
| ------- | ----- | ------ |
|         |       |        |



### 其他(others)

#### minecraft:is_hidden_when_invisible

#### minecraft:mob_effect

```json

```

**entity_filter：**

| filters | 补充 |
| ------- | ---- |
|         |      |



## component_groups

### 原版加-Johnny模式

#### minecraft:vindicator_johnny

##### minecraft:behavior.nearest_attackable_target

```json
"must_reach": false,
"must_see": false, //因filter内部进行了定义，此处实际无效
"must_see_forget_duration": 40.0,
"persist_time": 5,
"reselect_targets": true,
"within_radius": 80.0, //因定义了follow_range，此处实际无效
```

**entity_types：**

| filters            | 补充                                   |
| ------------------ | -------------------------------------- |
| 任意其它非劫掠生物 | "max_dist": 40,<br />"must_see": false |

##### minecraft:follow_range

```json
"value": 80,
"max": 80
```



### 原版加-正常模式

#### minecraft:default_targeting

##### minecraft:behavior.nearest_attackable_target

```json
"must_reach": false,
"must_see": false, //因filter内部进行了定义，此处实际无效
"must_see_forget_duration": 20.0,
"persist_time": 3,
"reselect_targets": true,
"within_radius": 64.0, //因定义了follow_range，此处实际无效
```

**entity_types：**

| filters                      | 补充                                   |
| ---------------------------- | -------------------------------------- |
| 任意其它玩家、村民、流浪商人 | "max_dist": 32,<br />"must_see": false |
| 任意其它友好生物、僵尸       | "max_dist": 32,<br />"must_see": true  |

##### minecraft:follow_range

```json
"value": 64,
"max": 64
```



### 复生-



## events

### 原版-

| 权重 | 添加组件组 | 移除组件组 | 执行命令 |
| :--: | :--------- | :--------- | :------- |
|      |            |            |          |
|      |            |            |          |



### 复生-

| 权重 | 添加组件组 | 移除组件组 | 执行命令 |
| :--: | :--------- | :--------- | :------- |
|      |            |            |          |
|      |            |            |          |





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
