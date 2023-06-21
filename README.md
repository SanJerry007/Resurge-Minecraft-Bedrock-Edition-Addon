# 复生 -- Minecraft基岩版附加包

[English](https://github.com/SanJerry007/Resurge-Minecraft-Bedrock-Edition-Addon/tree/main/README-en.md)     [中文](https://github.com/SanJerry007/Resurge-Minecraft-Bedrock-Edition-Addon/tree/main/README.md)

> 注意：附加包仍处于早期版本，部分特性可能会在更新中调整。
>
> 由于作者时间与精力有限，附加包更新频率不固定，请降低期待。

*复生*附加包旨在增加原版游戏的难度，为玩家提供紧张刺激的生存体验。

正如"复生"这个名称所示，该附加包的核心思想为使生物拥有"亡语"的能力。在生物在受到致命攻击后，会根据伤害类型与所处环境等情况作出不同的判定，其可能会以一种更强大的形态复活，也可能会召集周围的同类前来支援，或者只是单纯地给攻击者一个死亡反伤。

除此以外，该附加包也引入了生物形态转换的概念，不同生物会在不同的情况下转变为其他的变种（如狂暴、黑暗等），沿着转换的思想，附加包在未来会引入一个精彩的故事线，以此完善附加包中世界的背景故事。

**如果你有任何想法或者建议，欢迎和作者在issues中进行讨论！**

**体验附加包下的多人服务器，也可以加入作者的QQ群：610141436**


## 开发进度与未来规划

> 黑月是否嚎叫？
>
> 不在满月之时，
>
> 不在终末时刻，
>
> 不与火焰同行，
>
> **只在无月之时。**

### 1. 复生 -- 月神之怒 [进行中...]

月亮变得越发怪异，主世界生物也开始受之影响。

- 新增物种变体：狂暴生物
- 现有的敌对生物会得到全面增强（属性、技能、AI等）
- 现有主世界生物获得"亡语"
- 生物的功能性增强（生存中的价值提高）
- 更多的武器与防具
- 更多的物品与结构
- 敬请期待！

### 2. 复生 -- 终末时刻

月亮的影响渗透至末地

- 主题：末地更新
- 新增物种类型：末地生物
- 末地增加原住民
- 新的遗迹与生物

### 3. 复生 -- 与火同行

月亮的影响渗透至下界。

### 4. 复生 -- 黑月诅咒

主世界的地下传来奇怪的躁动。



## 文件结构

```python
-- resurge_behavior
  -- animation_controllers
  -- animations
  -- entities
  -- functions
  -- items
  -- loot_tables
  -- recipes
  -- scripts
  -- spawn_rules

-- resurge_resource
  -- animation_controllers
  -- animations
  -- attachables
  -- entity
  -- materials
  -- models
  -- render_controllers
  -- sounds
  -- texts
  -- textures

-- documentation # 整个附加包的文档，使用中文撰写，只记录了相比原版的改动部分
  -- resurge_behavior
    -- ... # 与上面的文件结构相同
  -- resurge_resource
    -- ... # 与上面的文件结构相同
```
