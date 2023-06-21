# entity.raged

> 以下内容仅适用于狂暴生物。

## random_hunt

在实体拥有目标时，根据月相的不同阶段，以不同概率进行猎杀。（猎杀技能控制器）

```mermaid
flowchart
	default <--> targeted
	stage0 <--> targeted
	stage1 <--> targeted
	stage2 <--> targeted
	stage3 <--> targeted
	stage4 <--> targeted
	stage0 --> default
	stage1 --> default
	stage2 --> default
	stage3 --> default
	stage4 --> default
	stage0 <--> update_rand_number
	stage1 <--> update_rand_number
	stage2 <--> update_rand_number
	stage3 <--> update_rand_number
	stage4 <--> update_rand_number
	stage0 <--> hunt
	stage1 <--> hunt
	stage2 <--> hunt
	stage3 <--> hunt
	stage4 <--> hunt
```



## full_moon_stage

根据是否为满月夜晚，控制狂暴生物的不同表现。

```mermaid
flowchart
	default <--> non_full_moon_night
	default <--> full_moon_night
```



# 附件

[(15条消息) markdown 画图_whatday的博客-CSDN博客_markdown 画图](https://blog.csdn.net/whatday/article/details/88655461)

### 空的流程图代码块

```mermaid
flowchart
	default
```





















