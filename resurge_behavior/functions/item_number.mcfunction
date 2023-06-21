scoreboard objectives add world_statistics dummy 世界数据
scoreboard players set 掉落物数量 world_statistics 0
execute at @e[type=minecraft:item] run scoreboard players add 掉落物数量 world_statistics 1
scoreboard objectives setdisplay sidebar world_statistics ascending