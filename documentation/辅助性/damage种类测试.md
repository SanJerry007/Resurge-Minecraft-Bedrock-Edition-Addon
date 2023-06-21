# damage_sensor中的各个cause具体含义

[Entity Documentation - has_damage | Microsoft Docs](https://docs.microsoft.com/en-us/minecraft/creator/reference/content/entityreference/examples/filters/has_damage)

attack / entity_attack：近战攻击（玩家、生物都算）

projectile：投掷物攻击（玩家、生物都算）

contact：接触伤害（仙人掌）

sonic_boom：监守者的声波攻击



### 组件(组)

```json
"test:damage_type": {
    "minecraft:damage_sensor": {
        "triggers": [
            {
                "cause": "anvil",
                "on_damage": {
                    "event": "test:anvil"
                }
            },
            {
                "cause": "block_explosion",
                "on_damage": {
                    "event": "test:block_explosion"
                }
            },
            {
                "cause": "charging",
                "on_damage": {
                    "event": "test:charging"
                }
            },
            {
                "cause": "contact",
                "on_damage": {
                    "event": "test:contact"
                }
            },
            {
                "cause": "drowning",
                "on_damage": {
                    "event": "test:drowning"
                }
            },
            {
                "cause": "entity_attack",
                "on_damage": {
                    "event": "test:entity_attack"
                }
            },
            {
                "cause": "entity_explosion",
                "on_damage": {
                    "event": "test:entity_explosion"
                }
            },
            {
                "cause": "fall",
                "on_damage": {
                    "event": "test:fall"
                }
            },
            {
                "cause": "falling_block",
                "on_damage": {
                    "event": "test:falling_block"
                }
            },
            {
                "cause": "fire",
                "on_damage": {
                    "event": "test:fire"
                }
            },
            {
                "cause": "anvil",
                "on_damage": {
                    "event": "test:anvil"
                }
            },
            {
                "cause": "fire_tick",
                "on_damage": {
                    "event": "test:fire_tick"
                }
            },
            {
                "cause": "fireworks",
                "on_damage": {
                    "event": "test:fireworks"
                }
            },
            {
                "cause": "fly_into_wall",
                "on_damage": {
                    "event": "test:fly_into_wall"
                }
            },
            {
                "cause": "freezing",
                "on_damage": {
                    "event": "test:freezing"
                }
            },
            {
                "cause": "lava",
                "on_damage": {
                    "event": "test:lava"
                }
            },
            {
                "cause": "lightning",
                "on_damage": {
                    "event": "test:lightning"
                }
            },
            {
                "cause": "magic",
                "on_damage": {
                    "event": "test:magic"
                }
            },
            {
                "cause": "magma",
                "on_damage": {
                    "event": "test:magma"
                }
            },
            {
                "cause": "override",
                "on_damage": {
                    "event": "test:override"
                }
            },
            {
                "cause": "piston",
                "on_damage": {
                    "event": "test:piston"
                }
            },
            {
                "cause": "projectile",
                "on_damage": {
                    "event": "test:projectile"
                }
            },
            {
                "cause": "stalactite",
                "on_damage": {
                    "event": "test:stalactite"
                }
            },
            {
                "cause": "stalagmite",
                "on_damage": {
                    "event": "test:stalagmite"
                }
            },
            {
                "cause": "starve",
                "on_damage": {
                    "event": "test:starve"
                }
            },
            {
                "cause": "suffocation",
                "on_damage": {
                    "event": "test:suffocation"
                }
            },
            {
                "cause": "suicide",
                "on_damage": {
                    "event": "test:suicide"
                }
            },
            {
                "cause": "temperature",
                "on_damage": {
                    "event": "test:temperature"
                }
            },
            {
                "cause": "thorns",
                "on_damage": {
                    "event": "test:thorns"
                }
            },
            {
                "cause": "void",
                "on_damage": {
                    "event": "test:void"
                }
            },
            {
                "cause": "wither",
                "on_damage": {
                    "event": "test:wither"
                }
            },
            {
                "cause": "none",
                "on_damage": {
                    "event": "test:none"
                }
            },
            {
                "cause": "all",
                "on_damage": {
                    "event": "test:all"
                }
            }
        ]
    }
}
```



### 事件

```json
"test:all": {
    "run_command": {
        "command": ["say all"]
    }
},
"test:anvil": {
    "run_command": {
        "command": ["say anvil"]
    }
},
"test:block_explosion": {
    "run_command": {
        "command": ["say block_explosion"]
    }
},
"test:charging": {
    "run_command": {
        "command": ["say charging"]
    }
},
"test:contact": {
    "run_command": {
        "command": ["say contact"]
    }
},
"test:drowning": {
    "run_command": {
        "command": ["say drowning"]
    }
},
"test:entity_attack": {
    "run_command": {
        "command": ["say entity_attack"]
    }
},
"test:entity_explosion": {
    "run_command": {
        "command": ["say entity_explosion"]
    }
},
"test:fall": {
    "run_command": {
        "command": ["say fall"]
    }
},
"test:falling_block": {
    "run_command": {
        "command": ["say falling_block"]
    }
},
"test:fire": {
    "run_command": {
        "command": ["say fire"]
    }
},
"test:fire_tick": {
    "run_command": {
        "command": ["say fire_tick"]
    }
},
"test:fireworks": {
    "run_command": {
        "command": ["say fireworks"]
    }
},
"test:fly_into_wall": {
    "run_command": {
        "command": ["say fly_into_wall"]
    }
},
"test:freezing": {
    "run_command": {
        "command": ["say freezing"]
    }
},
"test:lava": {
    "run_command": {
        "command": ["say lava"]
    }
},
"test:lightning": {
    "run_command": {
        "command": ["say lightning"]
    }
},
"test:magic": {
    "run_command": {
        "command": ["say magic"]
    }
},
"test:magma": {
    "run_command": {
        "command": ["say magma"]
    }
},
"test:none": {
    "run_command": {
        "command": ["say none"]
    }
},
"test:override": {
    "run_command": {
        "command": ["say override"]
    }
},
"test:piston": {
    "run_command": {
        "command": ["say piston"]
    }
},
"test:projectile": {
    "run_command": {
        "command": ["say projectile"]
    }
},
"test:stalactite": {
    "run_command": {
        "command": ["say stalactite"]
    }
},
"test:stalagmite": {
    "run_command": {
        "command": ["say stalagmite"]
    }
},
"test:starve": {
    "run_command": {
        "command": ["say starve"]
    }
},
"test:suffocation": {
    "run_command": {
        "command": ["say suffocation"]
    }
},
"test:suicide": {
    "run_command": {
        "command": ["say suicide"]
    }
},
"test:temperature": {
    "run_command": {
        "command": ["say temperature"]
    }
},
"test:thorns": {
    "run_command": {
        "command": ["say thorns"]
    }
},
"test:void": {
    "run_command": {
        "command": ["say void"]
    }
},
"test:wither": {
    "run_command": {
        "command": ["say wither"]
    }
}
```
