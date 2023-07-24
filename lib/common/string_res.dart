import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'str_res_keys.dart';

class StringRes extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          SR.words: "字词",
          SR.custom: "自定义",
          SR.settings: "设置",
          SR.clickTwiceInSuccessionToExitTheApplication: "连续点击两次退出应用",
          SR.noNetwork: "没有网络",
          SR.clickToRetry: "点击重试",
        },
        'en_US': {
          SR.words: "Words",
          SR.custom: "custom",
          SR.settings: "Settings",
          SR.clickTwiceInSuccessionToExitTheApplication:
              "Click twice in succession to exit the application",
          SR.noNetwork: "No network",
          SR.clickToRetry: "Click to retry",
        }
      };
}
