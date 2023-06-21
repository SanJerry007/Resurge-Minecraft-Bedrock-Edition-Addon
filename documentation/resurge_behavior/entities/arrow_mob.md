# arrow_mob

> 全部内容由空白创建。

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

特殊实体，为非玩家生物射出的箭。

### runtime_identifier

```json
minecraft:arrow
```



## components

### 伤害与抵抗(health|attack)

#### minecraft:hurt_on_condition

**damage_conditions：**

| filters      | cause | damage_per_tick |
| ------------ | ----- | --------------- |
| 自身在岩浆中 | lava  | 4               |



### 其他(others)

#### minecraft:collision_box

```json
"width": 0.25,
"height": 0.25
```

#### minecraft:physics

#### minecraft:pushable

```json
"is_pushable": false,
"is_pushable_by_piston": true
```

#### minecraft:conditional_bandwidth_optimization

```json
"default_values": {
    "max_optimized_distance": 80.0,
    "max_dropped_ticks": 7,
    "use_motion_prediction_hints": true
}
```

#### minecraft:despawn

```json
"despawn_from_distance": {
    "max_distance": 128,
    "min_distance": 32
}
```



## component_groups

### 复生-默认箭矢

#### resurge:default_arrow

##### minecraft:projectile

```json
"on_hit": {
    "impact_damage": {
        "damage": [1, 6],
        "knockback": true,
        "semi_random_diff_damage": false,
        "destroy_on_hit": true
    },
    "stick_in_ground": {
        "shake_time": 0.35
    }
},
"hit_sound": "bow.hit",
"power": 2.0,
"gravity": 0.05,
"liquid_inertia": 0.6,
"uncertainty_base": 12,
"uncertainty_multiplier": 3,
"should_bounce": true,
"anchor": 1,
"offset": [0, 0, 0]
```



### 复生-水云箭矢

#### resurge:water_power_arrow

##### minecraft:projectile

```json
"on_hit": {
    "impact_damage": {
        "damage": [2, 8],
        "knockback": true,
        "semi_random_diff_damage": false,
        "destroy_on_hit": true
    },
    "stick_in_ground": {
        "shake_time": 0.35
    }
},
"hit_sound": "bow.hit",
"power": 3.0,
"gravity": 0.05,
"liquid_inertia": 0.99,
"uncertainty_base": 8,
"uncertainty_multiplier": 2,
"should_bounce": true,
"anchor": 1,
"offset": [0, 0, 0]
```

#### resurge:water_power_levitation_arrow

##### minecraft:projectile

```json
"on_hit": {
    "impact_damage": {
        "damage": [2, 8],
        "knockback": true,
        "semi_random_diff_damage": false,
        "destroy_on_hit": true
    },
    "stick_in_ground": {
        "shake_time": 0.35
    },
    "mob_effect": {
        "effect": "levitation",
        "durationeasy": 200,
        "durationnormal": 200,
        "durationhard": 200,
        "amplifier": 0
    }
},
"hit_sound": "bow.hit",
"power": 3.0,
"gravity": 0.05,
"liquid_inertia": 0.99,
"uncertainty_base": 8,
"uncertainty_multiplier": 2,
"should_bounce": true,
"anchor": 1,
"offset": [0, 0, 0]
```



## events

### 原版-生物生成

#### minecraft:entity_spawned

| 条件 | 添加组件组            | 移除组件组 | 执行命令 |
| :--: | :-------------------- | :--------- | :------- |
|  ——  | resurge:default_arrow | ——         | ——       |



### 复生-骷髅箭矢

骷髅与狂暴骷髅的箭矢。

#### resurge:skeleton_arrow

| 条件 | 添加组件组            | 移除组件组 | 执行命令 |
| :--: | :-------------------- | :--------- | :------- |
|  ——  | resurge:default_arrow | ——         | ——       |

#### resurge:skeleton_raged_arrow

| 权重 | 添加组件组                           | 移除组件组 | 执行命令 |
| :--: | :----------------------------------- | :--------- | :------- |
|  90  | resurge:water_power_arrow            | ——         | ——       |
|  10  | resurge:water_power_levitation_arrow | ——         | ——       |
