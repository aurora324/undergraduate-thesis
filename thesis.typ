#import "template/template.typ": *

// Select the active text language: Chinese(zh) or English(en)
#show: documentClass.with(lang: "zh")

#let info = (
  clc: "CLC",
    thesis_id: "20250328",
    confidentiality_level: "公开",
    udc: "UDC",
    title: ("面向单源域眼底图像的","频带重要性感知⾎管分割⽅法"),
    subtitle: "",
    author: "王禀钦",
    student_id: "12210723",
    department: "计算机科学与工程系",
    major: "计算机科学与技术",
    supervisor: "刘江",
    submit_date: datetime.today(),
)

#let info_en = (
  clc: "CLC",
    thesis_id: "20250328",
    udc: "UDC",
    title: ("BIRF-SDG: Band Importance","Aware Random Frequency Filter","Based Single-Source Domain","Generalization for Retinal","Vessel Segmentation"),
    subtitle: "",
    author: "Bingqin Wang",
    student_id: "12210723",
    department: "Computer Science and Engineering",
    major: "Computer Science and Technology",
    supervisor: "Jiang Liu",
    submit_date: datetime.today(),
)

#cover(
  en: false,
  anonymous:false,
  info: info,
)

#cover(
  en: true,
  anonymous:false,
  info: info_en,
)

#declare(
  en: false,
  anonymous: false,
  print_date: none
)

// Please disable EN declaration form to match Word template in Chinese
// Do this by commenting out the following invocation
#declare(
  en: true,
  anonymous: false,
  print_date: none
)

#set page(numbering: "I")
#counter(page).update(1)

#let keywords_zh = (
  "视网膜图像",
  "血管分割",
  "单源域泛化",
  "频率丢失",
)

#let abstract_body_zh = [
单源域泛化（SDG）旨在利用来自单一源域的数据来提升模型在未见目标域上的性能，其主要目标是减轻域偏移的影响。在视网膜血管分割领域，由于数据集组成的变化（例如疾病患病率和成像噪声水平的差异），域偏移常常发生。尽管域偏移影响显著，但其影响模型性能的潜在机制仍未得到充分研究。本文假设数据集的变化反映在频域特征的分布差异上，这会导致模型过度拟合源数据集中的特定模式。为了解决这个问题，本文提出了一种新的SDG方法，称为基于频带重要性感知随机频率滤波器的单源域泛化（BIRF-SDG）。该框架引入了一种频带评分机制，旨在识别和保留对分割任务至关重要的频带，从而防止在后续处理中丢失关键信息。此外，我们提出了一种随机带通滤波策略作为数据增强技术，以提高模型在不同域中的泛化能力。在跨域视网膜图像数据集上进行的大量对比实验和消融分析证实，我们的方法达到了目前最先进的性能，有效解决了视网膜血管分割中域偏移带来的挑战。
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

#acknowledgement(show_both: true)[
首先，我要衷心感谢我的导师刘江教授。从论文选题到实验设计，从理论推导到论文撰写，刘老师始终给予我悉心的指导和宝贵的建议。刘老师严谨的治学态度、深厚的学术造诣和对学生无私的关怀，让我受益匪浅，这将是我未来学术道路上的宝贵财富。感谢课题组的所有老师和同学们。特别感谢实验室的师兄师姐们在研究过程中给予的帮助和指导，感谢同门们在讨论中提供的启发和建议。与大家的交流让我开阔了视野，也收获了珍贵的友谊。感谢南方科技大学计算机科学与工程系提供的优质学习环境和科研资源。感谢学校图书馆和计算中心提供的便利条件，为本研究的顺利开展提供了有力保障。最后，我要特别感谢我自己。感谢自己在面对困难时的坚持，在无数个深夜里调试代码、修改论文的付出。感谢自己保持对科研的热情，不断学习和探索。这段毕设经历让我成长了许多，也让我更加坚定了未来的方向。再次感谢所有帮助过我的人！
]