= 相关工作

== 视网膜血管分割

视网膜血管分割是医学图像分析中的一个基础任务，其目的是从眼底图像中自动提取血管结构@staal2004ridge@gulshan2016development。传统的血管分割方法主要基于图像处理技术，如边缘检测、形态学操作和阈值分割等。近年来，深度学习方法在这一任务上取得了显著进展@litjens2017survey@hesamian2019deep。

卷积神经网络（CNN）在视网膜血管分割中得到了广泛应用。U-Net及其变体是目前最常用的架构，其编码器-解码器结构能够有效地捕获多尺度特征。Attention U-Net@oktay2018attention 引入了注意力机制来突出血管区域，DenseNet@huang2017densely 和 ResNet@he2016deep 等深层架构也被用于提高分割精度。此外，SegNet@badrinarayanan2017segnet、DeepLab@chen2017deeplab 和 PSPNet@zhao2017pyramid 等架构也被应用于医学图像分割任务。近年来，编码器-解码器结合空洞卷积的方法进一步提升了分割性能@chen2018encoder。Squeeze-and-Excitation网络@hu2018squeeze 和ECA-Net@wang2020eca 等注意力机制进一步增强了特征表达能力。然而，这些深度学习方法通常假设训练数据和测试数据来自相同的分布，当应用到不同来源的数据时，性能往往会显著下降。这一问题在医学图像领域尤为突出，因为不同医院、不同设备采集的图像存在显著差异@hu2022domain。

#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 8pt,
    [
      #image("../images/Unet.png", width: 100%)
      #align(center)[(a) U-Net]
    ],
    [
      #image("../images/Attention unet.png", width: 100%)
      #align(center)[(b) Attention U-Net]
    ],
  ),
  caption: [典型编码器-解码器血管分割网络示意图。U-Net通过跳跃连接融合多尺度特征，Attention U-Net进一步在跳跃连接中加入注意力门控以突出目标区域。],
) <fig-unet-family>

@fig-unet-family 展示了U-Net及其注意力变体的基本结构。编码器部分逐步下采样提取高层语义特征，解码器部分逐步上采样恢复空间分辨率，跳跃连接则将编码器特征直接传递到解码器，帮助恢复血管细节；注意力门控能够进一步抑制不相关区域的特征响应。

== 域泛化方法

多源域泛化（Multi-source Domain Generalization）利用多个源域数据来学习域不变特征@dou2019domain@li2018domain。典型的方法包括域对抗训练、元学习和特征解耦。域对抗训练通过对抗学习来提取域不变的特征表示，判别器试图区分不同域的特征，而特征提取器则努力欺骗判别器，从而学习到域不变的特征。生成对抗网络（GAN）@goodfellow2014generative 为域适应提供了强大的生成能力，而图像到图像的转换方法@isola2017image 则实现了跨域图像的风格迁移。元学习通过模拟域迁移来学习快速适应新域的能力，模型在多个源域上进行元训练，学习如何快速适应新的目标域。特征解耦将特征分解为域相关和域无关的组件，仅使用域无关的特征进行预测。然而，多源域泛化方法需要获取多个源域的数据，这在实际应用中往往是不现实的。

#figure(
  image("../images/Domain adversary trainer.png", width: 80%),
  caption: [域对抗训练框架示意图。该框架包含三个主要组件：特征提取器（Feature Extractor）、标签预测器（Label Predictor）和域判别器（Domain Discriminator）。输入图像经过特征提取器得到特征表示，标签预测器基于特征进行类别预测（计算标签预测损失L_y），域判别器尝试区分特征来自源域还是目标域（计算域分类损失L_d）。通过梯度反转层（Gradient Reversal Layer），特征提取器学习到的特征既能够完成目标任务，又无法被域判别器区分来源，从而实现域不变特征学习。],
) <fig-domain-adversarial>

@fig-domain-adversarial 展示了域对抗训练的基本框架。该框架包含三个主要组件：特征提取器、标签预测器和域判别器。特征提取器学习提取域不变特征，标签预测器基于提取的特征进行任务预测，域判别器则尝试区分特征来自哪个域。通过对抗训练，特征提取器学习到的特征既能够完成目标任务，又无法被域判别器区分来源，从而实现域泛化。

单源域泛化（Single-source Domain Generalization, SDG）仅利用单一源域数据来训练模型，使其能够泛化到未见过的目标域@ouyang2022causality。SDG方法主要包括数据增强方法、正则化方法和特征增强方法。数据增强方法通过对训练数据进行各种变换来增加数据多样性，例如Mixup@zhang2018mixup、CutMix@yun2019cutmix、AutoAugment@cubuk2019autoaugment 等方法可以生成多样化的训练样本@inoue2019multi。AugMix等高级增强技术进一步提高了模型的鲁棒性@hendrycks2020augmix。元学习方法如MAML@finn2017model 和Reptile@nichol2018first 通过学习如何学习，使模型能够快速适应新域。联邦学习@mcmahan2017communication 则提供了一种保护隐私的分布式训练范式。正则化方法通过添加正则化项来防止模型过拟合，例如Dropout@nitish2014dropout、Batch Normalization、Label Smoothing 等技术可以提高模型的泛化能力。特征增强方法通过对特征进行扰动或增强来提高鲁棒性，例如Feature Dropout、Adversarial Training等方法可以增强特征的泛化性@zhang2016robust。

== 频域分析方法

傅里叶变换是信号处理中的基础工具，它将图像从空间域转换到频域，揭示了图像的频率成分。在图像处理中，低频成分通常对应于图像的整体结构和轮廓，而高频成分则对应于细节和边缘信息。近年来，频域分析在计算机视觉任务中显示出巨大潜力，研究表明不同域之间的差异在频域中表现得更加明显，特别是振幅谱包含了图像的风格信息，而相位谱则包含了结构信息。

基于上述观察，研究者提出了多种频域增强方法。FDA（Fourier Domain Adaptation）通过交换源域和目标域图像的振幅谱来生成具有目标域风格的合成图像@yang2020fda，这种方法可以有效地减少域间差异@xu2021fourier。傅里叶卷积网络通过快速傅里叶变换加速特征提取@chi2020fast，而频率通道注意力机制则增强了模型对频率特征的感知能力@qin2021fcanet。Amplitude Perturbation通过对振幅谱进行随机扰动来增强数据多样性@li2023frequency，这种方法可以模拟不同域之间的风格变化。Frequency Dropout通过随机丢弃某些频率成分来增强模型的鲁棒性@li2024fd@li2024raffesdg，这种方法可以防止模型过度依赖特定的频率成分。近期研究还探索了自监督学习在域泛化中的应用@li2023self@su2023rethinking，以及多尺度域泛化方法@li2023generic@li2023enhancing。


@fig-fd-sdg 展示了FD-SDG方法的基本流程@li2024fd。该方法首先将图像转换到频域，然后对不同的频率带应用基于丢弃的增强策略，最后将增强后的频域特征转换回空间域进行分割。这种方法通过随机丢弃某些频率成分来增强模型的鲁棒性，但缺乏对频率成分的选择性处理。CSCA方法通过跨域注意力机制提升分割性能@shu2024csca，而FedDG则利用联邦学习进行域泛化@liu2021feddg。

#figure(
  image("../images/FD-SDG.png", width: 92%),
  caption: [FD-SDG频域增强方法示意图。该方法通过FFT将输入图像转换到频域，在频率域中进行随机丢弃或扰动，并通过逆FFT生成增强图像，再送入分割网络进行训练。],
) <fig-fd-sdg>

@fig-frequency-mixed 展示了频域混合增强方法的基本思想。该方法通过混合不同域图像的频域特征来生成具有多样化风格的训练样本，从而增强模型的泛化能力。

然而，这些方法通常对所有频率成分进行同等处理，缺乏选择性。过度增强可能导致关键结构信息的丢失，而增强不足则无法有效提高泛化能力。近期研究还探索了任务特定的数据增强策略@zhao2022task，以及基于注意力机制的特征增强方法@woo2018cbam。在医学图像分析中，深度学习方法已广泛应用于各类分割任务@owen2011retinal@zhang2023slide@zhang2024eemsnet。深度学习在皮肤癌检测@esteva2017dermatologist 和胸部X光诊断@rajpurkar2017chexnet 等任务中已达到专家水平。此外，多视图域泛化方法@ou2022mvd 和基于人工智能的频域方法@li2025aif 也为解决域偏移问题提供了新的思路。

近年来，Transformer架构在计算机视觉任务中展现出强大能力，通过自注意力机制捕获全局依赖关系@dosovitskiy2021image。Vision Transformer将图像分割为补丁序列，利用Transformer编码器进行特征提取，在多个基准数据集上取得了优异性能。此外，在频域中进行学习的方法也显示出潜力，通过在频率域中处理图像信息，可以提高模型的泛化能力和计算效率@liu2020learning。自监督学习方法如MoCo@he2020momentum 和SimCLR@chen2020simple 通过对比学习获得强大的特征表示能力。

#figure(
  image("../images/Frequency Mixed.png", width: 92%),
  caption: [频域混合增强方法示意图。该方法在源域图像及其标注的基础上生成多种频域增强样本，并通过耦合分割网络共同优化分割结果。],
) <fig-frequency-mixed>

== 本章小结

本章回顾了视网膜血管分割、域泛化和频域分析的相关工作。现有的深度学习方法在单一数据集上表现良好，但面临域偏移问题。单源域泛化方法通过数据增强和正则化技术来提高泛化能力，但现有方法缺乏对频率成分的选择性处理。频域增强方法显示了巨大潜力，但需要更精细的控制机制来平衡增强强度和结构保留。基于这些观察，本研究提出了一种频带重要性感知的随机频率滤波方法，旨在实现自适应的频域增强。
