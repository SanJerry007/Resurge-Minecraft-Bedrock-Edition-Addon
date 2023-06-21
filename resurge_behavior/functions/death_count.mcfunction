tag @a remove dead
tag @a[tag=!dead_over] add dead
tag @e[type=player] remove dead
execute as @a[tag=dead] run scoreboard players add @s death_count 1
tag @a[tag=dead] add dead_over
tag @e[type=player] remove dead_over