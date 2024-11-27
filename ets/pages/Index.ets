import { translateText } from '../services/apiService';

@Entry
@Component
struct Index {
  @State inputText: string = ''; // 输入文本
  @State translatedText: string = ''; // 翻译结果
  @State from: string = 'en'; // 默认源语言
  @State to: string = 'zh'; // 默认目标语言

  build() {
    RelativeContainer() {
      // 顶部文本
      Text("文本翻译")
        .fontSize(20)
        .id('TextTranslation')
        .padding({ top: 10, bottom: 10, left: 15, right: 15 })
        .alignSelf(ItemAlign.Start)
        .margin({ top: '5%', left: 0 })
        .backgroundColor('rgb(207, 222, 253)')
        .borderRadius({ topLeft: 0, topRight: 20, bottomLeft: 0, bottomRight: 20 })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })

      // 用户输入框
      TextInput({ placeholder: '请输入要翻译的文本...' })
        .id('TextInput1')
        .width('96%')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          top: { anchor: 'TextTranslation', align: VerticalAlign.Bottom }
        })
        .height('20%')
        .onChange((value) => this.inputText = value)
        .padding(10)
        .backgroundColor('rgb(173, 216, 230)')
        .margin('2%')

      // 源语言输入框
      TextInput({ placeholder: '请输入源语言（例如 en）' })
        .id('FromLanguage')
        .width('96%')
        .alignRules({
          top: { anchor: 'TextInput1', align: VerticalAlign.Bottom }
        })
        .onChange((value) => this.from = value)
        .padding(10)
        .margin('2%')
        .height('5%')

      // 目标语言输入框
      TextInput({ placeholder: '请输入目标语言（例如 zh）' })
        .id('ToLanguage')
        .width('80%')
        .alignRules({
          top: { anchor: 'FromLanguage', align: VerticalAlign.Bottom }
        })
        .onChange((value) => this.to = value)
        .padding(10)
        .width('96%')
        .margin('2%')
        .height('5%')

      // 翻译结果显示
      Text(this.translatedText)
        .id('TranslatedText')
        .padding(10)
        .fontSize(16)
        .alignRules({
          top: { anchor: 'ToLanguage', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .height('20%')
        .width('96%')
        .margin('2%')
        .backgroundColor('rgb(180, 255, 255)') // 浅青色填充颜色
        .margin({top:'10%'})

      Text('翻译结果')
        .id('Text1')
        .padding(10)
        .alignRules({
          bottom:{anchor:'TranslatedText',align:VerticalAlign.Top}
        })


      // 翻译按钮
      Button('翻译')
        .id('TranslateButton')
        .fontSize(18)
        .height(50)
        .backgroundColor('#4CAF50')
        .alignRules({
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(async () => {
          if (this.inputText.trim() === '') {
            this.translatedText = '请输入文本后再翻译！';
            return;
          }
          this.translatedText='正在等待服务返回结果';
          // 调用翻译接口，使用 from 和 to 动态替代
          this.translatedText = await translateText(this.inputText, this.from, this.to);
        })
        .padding(10)
        .width('30%')


    }
    .height('100%')
    .width('100%')

  }
}

