# Template

> 

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

### runtime_identifier

```json

```

### scripts—animate

| 名称 | 条件 | 备注 |
| :--: | :--: | :--: |
|      |      |      |
|      |      |      |

### animations

| 名称 | 内容 | 备注 |
| :--: | :--: | :--: |
|      |      |      |
|      |      |      |



## components

### 生物标识(type_family|variant)

#### minecraft:type_family

```json

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



### 生成与掉落(equipment|loot|experience_reward)

#### minecraft:equipment

```json

```

#### minecraft:loot

```json

```

#### minecraft:experience_reward

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

### 原版-



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



## 附件

### 空的json代码块

```json

```



### 结构化组件

#### minecraft:equipment

```json

```

**slot_drop_chance:**

| slot | drop_chance |
| ---- | ----------- |
|      |             |
|      |             |

#### minecraft:damage_sensor

##### trigger 1

**on_damage：**

| filters | event | target |
| ------- | ----- | ------ |
|         |       |        |

```json

```

#### minecraft:target_nearby_sensor

|          | inside_range | outside_range |
| -------- | ------------ | ------------- |
| **距离** |              |               |
| **事件** |              |               |
| **目标** |              |               |

#### minecraft:follow_range

必须添加，否则实体在找到攻击目标后，若与目标的距离大于16，会出现丢失目标的情况

**表示跟随目标的距离，目标移动超出此距离时丢失目标，这里设置为最大索敌范围的1.5倍**

```json

```

#### minecraft:break_blocks

| 类别               | 范围 |
| ------------------ | ---- |
| 怪物基础可破坏物品 | 所有 |



### 内部数据

**entity_types：**

| filters | 补充 |
| ------- | ---- |
|         |      |

**triggers：**

| filters | event | target |
| ------- | ----- | ------ |
|         |       |        |

**event_choices：**

| filters | sequences—event | sequences—sound_event |
| ------- | --------------- | --------------------- |
|         |                 |                       |



### 事件

| 权重 | 添加组件组 | 移除组件组 | 执行命令 |
| :--: | :--------- | :--------- | :------- |
|      |            |            |          |
|      |            |            |          |

| 条件 | 添加组件组 | 移除组件组 | 执行命令 |
| :--: | :--------- | :--------- | :------- |
|      |            |            |          |
|      |            |            |          |

