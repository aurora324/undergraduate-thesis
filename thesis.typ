#import "template/template.typ": *

// Select the active text language: Chinese(zh) or English(en)
#show: documentClass.with(lang: "zh")

#let info = (
  clc: "CLC",
    thesis_id: "20250328",
    confidentiality_level: "公开",
    udc: "UDC",
    title: ("面向单源域眼底图像的","频带重要性感知血管分割方法"),
    subtitle: "",
    author: "王禀钦",
    student_id: "12210723",
    department: "计算机科学与工程系",
    major: "计算机科学与技术",
    supervisor: "刘江 讲席教授",
    submit_date: datetime.today(),
)

#let info_en = (
  clc: "CLC",
    thesis_id: "20250328",
    udc: "UDC",
    title: ("Band Importance-Aware Vessel", "Segmentation for Single-Source"," Domain Generalization","in Retinal Fundus Images"),
    subtitle: "",
    author: "Bingqin Wang",
    student_id: "12210723",
    department: "Computer Science and Engineering",
    major: "Computer Science and Technology",
    supervisor: "Professor Jiang Liu",
    submit_date: datetime.today(),
)

#set page(numbering: none)

#cover(
  en: false,
  anonymous:false,
  info: info,
)

// #cover(
//   en: true,
//   anonymous:false,
//   info: info_en,
// )

#declare(
  en: false,
  anonymous: false,
  print_date: none
)

// Please disable EN declaration form to match Word template in Chinese
// Do this by commenting out the following invocation
// #declare(
//   en: true,
//   anonymous: false,
//   print_date: none
// )

#state("show-page-number", false).update(true)
#set page(numbering: "I")
#counter(page).update(1)

#let keywords_zh = (
  "视网膜图像",
  "血管分割",
  "单源域泛化",
  "频率丢失",
)

#let abstract_body_zh = [
单源域泛化（SDG）关注在只有一个源域可用的条件下训练模型，使其在未见目标域中仍保持稳定表现。在视网膜血管分割任务中，不同数据集之间常存在采集设备、病种构成、图像噪声和颜色分布等差异，这些因素会造成明显的域偏移。现有研究已表明域偏移会削弱分割模型的跨域性能，但其与频域特征变化之间的关系仍缺少充分分析。本文认为，数据集差异会在频谱分布中体现出来，并可能促使模型记忆源域特有的频率模式。针对这一问题，本文提出频带重要性感知随机频率滤波单源域泛化方法（BIRF-SDG）。该方法通过频带评分机制估计不同频率带对结构保持和分割性能的贡献，并优先保护与血管分割密切相关的关键频带；同时，引入加权随机频带滤波作为增强策略，在扩大训练分布的同时降低关键结构受损的风险。跨域眼底数据集上的对比实验和消融实验表明，BIRF-SDG 能够提升模型在未见目标域上的血管分割性能，并缓解域偏移带来的影响。
]

#let keywords_en = (
  "Retinal Image",
  "Vessel Segmentation",
  "Single-source Domain Generalization",
  "Frequency Dropout",
)

#let abstract_body_en = [
Single-source domain generalization (SDG) is used to improve model's performance on unseen target domains by utilizing data from one source domain, with a primary emphasis on alleviating the impact of domain shifts. In the context of retinal vessel segmentation, domain shifts often arise due to variations in datasets composition, such as discrepancies in disease prevalence and imaging noise levels. Despite their significance, the underlying mechanisms through which these shifts impact model performance remain insufficiently explored. In this paper, we hypothesize that dataset variations are reflected in the distributional differences of frequency-domain features, which can cause models to overfit to specific patterns within the source dataset. To address the problem, this paper proposes a novel SDG method, denoted as Band Importance Aware Random Frequency Filter based Single-source Domain Generalization (BIRF-SDG). This framework incorporates a band scoring mechanism designed to identify and preserve frequency bands that are critical for segmentation tasks, thereby preventing the loss of essential information in subsequent processes. Furthermore, we propose a random band filtering strategy as a data augmentation technique to improve the model's generalization across various domains. Extensive comparative experiments and ablation analyses on cross-domain retinal image datasets confirm that our method attains state-of-the-art performance, effectively addressing the challenges associated with domain shift in retinal vessel segmentation.
]

#abstract(
  show_title: true,
  prefer_en_header: false,
  en: false,
  anonymous: false,
  info_zh: info,
  info_en: info_en,
  keywords_zh: keywords_zh,
  keywords_en: keywords_en,
  body_zh: abstract_body_zh,
  body_en: abstract_body_en,
)

#content()

#set page(numbering: "1")
#counter(page).update(1)

#include "sections/0_introduction.typ"

#include "sections/1_related_work.typ"

#include "sections/2_methedology.typ"

#include "sections/3_experiments.typ"

#include "sections/4_conclusion.typ"

#set heading(numbering: none)

#references(show_both: true)

// #appendix(show_both: true)

// #include "sections/appendix.typ"

#acknowledgement(show_both: false)[
首先，感谢导师刘江教授在毕业论文完成过程中给予的指导。从选题确定、实验方案设计到论文修改，刘老师都提供了耐心而具体的建议，使我能够逐步厘清研究思路并完善论文内容。刘老师严谨负责的治学态度也让我深受启发。感谢课题组老师和同学们在研究讨论、实验推进和论文写作中给予的帮助，尤其感谢实验室师兄师姐提供的经验分享和技术支持。与大家的交流让我对医学图像分析和科研训练有了更深入的理解。同时，感谢南方科技大学计算机科学与工程系提供的学习环境和科研条件，也感谢学校图书馆、计算平台等资源对本研究的支持。最后，感谢家人和朋友在本科阶段给予的理解与鼓励。毕业设计的完成离不开上述帮助，也让我在独立思考、问题分析和持续改进方面获得了重要成长。
]
