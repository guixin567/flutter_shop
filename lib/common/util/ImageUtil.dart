import 'package:flutter_jd/common/constant/RequestURL.dart';

class ImageUtil {
  ///图片地址可能不含有主机地址，进行组装
  static String getImageUrl(String imageUrl){
    return "$rootUrl$imageUrl".replaceAll("\\", "/");
  }
}