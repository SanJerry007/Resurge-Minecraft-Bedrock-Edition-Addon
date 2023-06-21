# arrow

> 全部内容基于箭(原版)修改。

文档记录均为修改项，未修改的项或数据不会列出。

**同步游戏版本：**1.20.0.01

## description

特殊实体，为生物射出的箭。（这里主要添加了玩家射出的箭的属性）



## components



## component_groups

### 复生-玩家水云箭矢

#### resurge:player_water_arrow

##### minecraft:projectile

```json
"on_hit": {
    "impact_damage": {
        "damage": 1,
        "knockback": true,
        "semi_random_diff_damage": true,
        "destroy_on_hit": true,
        "max_critical_damage": 10,
        "min_critical_damage": 9,
        "power_multiplier": 0.97
    },
    "stick_in_ground": {
        "shake_time": 0.35
    },
    "arrow_effect": {}
},
"liquid_inertia": 0.99,
"hit_sound": "bow.hit",
"power": 5.0,
"gravity": 0.05,
"uncertainty_base": 1,
"uncertainty_multiplier": 0,
"anchor": 1,
"should_bounce": true,
"offset": [0, -0.1, 0]
```

#### resurge:player_water_levitation_arrow

##### minecraft:projectile

```json
"on_hit": {
    "impact_damage": {
        "damage": 1,
        "knockback": true,
        "semi_random_diff_damage": true,
        "destroy_on_hit": true,
        "max_critical_damage": 10,
        "min_critical_damage": 9,
        "power_multiplier": 0.97
    },
    "stick_in_ground": {
        "shake_time": 0.35
    },
    "arrow_effect": {},
    "mob_effect": {
        "effect": "levitation",
        "durationeasy": 200,
        "durationnormal": 200,
        "durationhard": 200,
        "amplifier": 0
    }
},
"liquid_inertia": 0.99,
"hit_sound": "bow.hit",
"power": 5.0,
"gravity": 0.05,
"uncertainty_base": 1,
"uncertainty_multiplier": 0,
"anchor": 1,
"should_bounce": true,
"offset": [0, -0.1, 0]
```



## events

### 原版-

| 权重 | 添加组件组 | 移除组件组 | 执行命令 |
| :--: | :--------- | :--------- | :------- |
|      |            |            |          |
|      |            |            |          |



### 复生-玩家水云箭矢

| 权重 | 添加组件组                            | 移除组件组 | 执行命令 |
| :--: | :------------------------------------ | :--------- | :------- |
|  90  | resurge:player_water_arrow            | ——         | ——       |
|  10  | resurge:player_water_levitation_arrow | ——         | ——       |


