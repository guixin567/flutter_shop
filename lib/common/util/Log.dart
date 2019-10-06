///日志工具类
class Log{
  static const bool isRelease = const bool.fromEnvironment("dart.vm.product");      //是否为生产环境

  static void d(Object message,{String tag = ""}){
    if(!isRelease) _print(tag, 'D -> ', message);
  }

  static void i(Object message,{String tag = ""}){
    if(!isRelease) _print(tag, 'I -> ', message);
  }

  static void w(Object message,{String tag = ""}){
    if(!isRelease) _print(tag, 'W -> ', message);
  }

  static void e(Object message,{String tag = ""}){
    if(!isRelease) _print(tag, 'E -> ', message);
  }


  /// 标签，级别，消息
  static void _print(String tag,String level,Object message){
    print(StringBuffer()
      ..write(level)
      ..write(tag ?? "")
      ..write(message)
      ..toString());
  }
}