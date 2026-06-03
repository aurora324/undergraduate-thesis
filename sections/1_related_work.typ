= 相关工作

== 视网膜血管分割

视网膜血管分割需要从眼底图像中提取血管像素，并将其与背景区域分离，为病变分析、血管形态测量和辅助诊断提供基础结果@staal2004ridge@gulshan2016development。传统方法通常依赖人工设计的图像处理算子，包括边缘检测、形态学处理、匹配滤波和阈值分割等。随着深度学习的发展，神经网络逐渐成为医学图像分割的主要技术路线，并在特征表达和复杂模式建模方面表现出更强能力@litjens2017survey@hesamian2019deep。

在深度学习分割模型中，编码器-解码器结构应用最为广泛。U-Net 利用跳跃连接把浅层细节与深层语义结合起来，较适合处理血管这类细长、分支多且边界不规则的目标。Attention U-Net@oktay2018attention 在跳跃连接中加入注意力门控，以抑制无关背景并突出目标区域；DenseNet@huang2017densely 和 ResNet@he2016deep 则通过密集连接或残差连接提升深层特征表达能力。此外，SegNet@badrinarayanan2017segnet、DeepLab@chen2017deeplab、PSPNet@zhao2017pyramid 以及采用空洞卷积的编码器-解码器结构@chen2018encoder 也被引入医学图像分割任务。Squeeze-and-Excitation 网络@hu2018squeeze 与 ECA-Net@wang2020eca 等通道注意力方法能够加强特征选择能力。不过，上述模型通常建立在训练集和测试集分布相近的假设上，当数据来自不同机构或设备时，性能下降仍较常见@hu2022domain。

#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 8pt,
    [
      #image("../images/Unet.png", width: 80%)
      #align(center)[(a) U-Net]
    ],
    [
      #image("../images/Attention unet.png", width: 115%)
      #align(center)[(b) Attention U-Net]
    ],
  ),
  caption: [典型编码器-解码器血管分割网络示意图。U-Net通过跳跃连接融合多尺度特征，Attention U-Net进一步在跳跃连接中加入注意力门控以突出目标区域。],
) <fig-unet-family>

@fig-unet-family 展示了 U-Net 及 Attention U-Net 的基本结构。编码器逐步压缩分辨率并提取语义信息，解码器通过上采样恢复像素级输出；跳跃连接用于补充边缘和细小分支等局部细节，注意力门控则进一步筛选与血管区域相关的特征。

== 域泛化方法

多源域泛化（Multi-source Domain Generalization）默认训练阶段能够获得多个来源的数据，并通过这些来源学习对域变化更稳定的特征@dou2019domain@li2018domain。常见技术路线包括域对抗训练、元学习和特征解耦。域对抗训练利用域判别器约束特征表示，使特征提取器生成更难区分来源的特征；生成对抗网络（GAN）@goodfellow2014generative 和图像到图像转换方法@isola2017image 则可模拟不同域之间的外观变化。元学习方法通过构造虚拟训练域和测试域，让模型学习在域变化下快速适应；特征解耦方法试图把域相关因素与任务相关因素分开。尽管这些方法具有一定效果，医学数据跨机构收集仍受到隐私、伦理和标注一致性的限制，因此多源设定在实际应用中并不总是可行。

@fig-domain-adversarial 概括了域对抗训练流程。图像先经过特征提取器得到中间表示，随后由标签预测器完成目标任务，并由域判别器判断特征来源。梯度反转层使特征提取器在优化主任务的同时削弱域可辨识信息，从而获得更接近域不变的表示。

#figure(
  image("../images/Domain adversary trainer.png", width: 80%),
  caption: [域对抗训练框架示意图。该框架包含三个主要组件：特征提取器（Feature Extractor）、标签预测器（Label Predictor）和域判别器（Domain Discriminator）。输入图像经过特征提取器得到特征表示，标签预测器基于特征进行类别预测（计算标签预测损失L_y），域判别器尝试区分特征来自源域还是目标域（计算域分类损失L_d）。通过梯度反转层（Gradient Reversal Layer），特征提取器学习到的特征既能够完成目标任务，又无法被域判别器区分来源，从而实现域不变特征学习。],
) <fig-domain-adversarial>

单源域泛化（Single-source Domain Generalization, SDG）进一步降低了对多源数据的要求，仅使用一个源域完成训练，并希望模型在未知目标域上仍具备可用性能@ouyang2022causality。现有 SDG 研究主要包括数据增强、正则化和特征扰动等方向。Mixup@zhang2018mixup、CutMix@yun2019cutmix、AutoAugment@cubuk2019autoaugment 以及 AugMix@hendrycks2020augmix 通过构造更多样的训练样本提升鲁棒性@inoue2019multi。MAML@finn2017model 和 Reptile@nichol2018first 从元学习角度模拟快速适应过程，联邦学习@mcmahan2017communication 则为隐私保护下的分布式训练提供可能。Dropout@nitish2014dropout、Batch Normalization 和 Label Smoothing 等正则化技术可缓解过拟合，特征扰动和对抗训练也有助于增强模型对分布变化的稳定性@zhang2016robust。

== 频域分析方法

傅里叶变换可以将图像表示为不同频率成分的组合，使研究者能够从频域角度分析图像内容。一般而言，低频成分更多反映整体亮度和大尺度结构，高频成分则与边缘、纹理和局部细节相关。在跨域视觉任务中，不同数据集的风格差异常常会体现在频谱分布上，其中振幅谱与成像风格关系较强，相位谱则更接近空间结构信息。

基于频谱差异的观察，已有研究提出了多种频域增强策略。FDA（Fourier Domain Adaptation）通过交换振幅谱生成具有目标域风格的训练样本@yang2020fda@xu2021fourier。傅里叶卷积网络利用快速傅里叶变换提升特征处理效率@chi2020fast，频率通道注意力则尝试加强模型对频率特征的选择能力@qin2021fcanet。Amplitude Perturbation 通过随机扰动振幅谱扩展训练分布@li2023frequency，Frequency Dropout 则通过随机丢弃部分频率成分减少模型对特定频带的依赖@li2024fd@li2024raffesdg。此外，自监督学习@li2023self@su2023rethinking 和多尺度域泛化方法@li2023generic@li2023enhancing 也被用于提升跨域性能。


@fig-fd-sdg 展示了 FD-SDG 的基本流程@li2024fd。该方法先将图像映射到频域，再对部分频率成分进行丢弃式增强，最后通过逆变换回到空间域并送入分割网络。该思路能够减少模型对固定频率模式的依赖，但随机丢弃并未显式区分结构关键频带和可增强频带。与之相关，CSCA 通过跨域注意力机制改善分割特征@shu2024csca，FedDG 则在联邦学习框架下研究域泛化问题@liu2021feddg。

#figure(
  image("../images/FD-SDG.png", width: 92%),
  caption: [FD-SDG频域增强方法示意图。该方法通过FFT将输入图像转换到频域，在频率域中进行随机丢弃或扰动，并通过逆FFT生成增强图像，再送入分割网络进行训练。],
) <fig-fd-sdg>

@fig-frequency-mixed 给出了频域混合增强的示意。该方法通过组合不同图像的频域信息生成风格变化更丰富的训练样本，从而提升模型对成像差异的适应能力。

总体而言，频域增强已经证明频谱扰动能够为跨域泛化提供有效信息，但现有方法对频带的选择仍不够精细。如果增强过程影响到血管边界或细小分支依赖的关键频率区域，分割结果可能受到损害；如果扰动幅度过小，又难以覆盖真实目标域中的风格变化。近期研究还从任务特定增强@zhao2022task、注意力特征建模@woo2018cbam、多视图学习@ou2022mvd 和人工智能驱动的频域适应@li2025aif 等角度分析域偏移问题。深度学习已广泛用于医学图像分析@owen2011retinal@zhang2023slide@zhang2024eemsnet，包括皮肤癌检测@esteva2017dermatologist 和胸部 X 光诊断@rajpurkar2017chexnet 等任务，这也说明提升模型跨域泛化能力对临床部署具有实际意义。

除卷积网络外，Transformer 也被用于视觉任务，并通过自注意力机制建模长距离依赖@dosovitskiy2021image。Vision Transformer 将图像切分为 patch 序列，再由 Transformer 编码器学习全局表示。频域学习方法则在计算效率和泛化建模两个方面显示出潜力@liu2020learning。与此同时，MoCo@he2020momentum 和 SimCLR@chen2020simple 等自监督方法通过对比学习获得更通用的视觉表征，为降低标注依赖和增强泛化能力提供了补充途径。

#figure(
  image("../images/Frequency Mixed.png", width: 92%),
  caption: [频域混合增强方法示意图。该方法在源域图像及其标注的基础上生成多种频域增强样本，并通过耦合分割网络共同优化分割结果。],
) <fig-frequency-mixed>

== 本章小结

本章从视网膜血管分割、域泛化和频域分析三个方面梳理了相关研究。现有分割网络在同分布数据上通常能够取得较好效果，但在跨设备、跨机构场景下仍容易受到域偏移影响。SDG 方法试图在数据来源有限的条件下提高模型稳健性，频域增强则为模拟跨域变化提供了可行思路。现有频域方法的不足主要在于缺少对频带重要性的显式建模，因此本文进一步提出频带重要性感知的随机频率滤波方法，以实现更可控的频域增强。
