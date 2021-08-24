import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// 缓存清理工具类
/// 1)获取缓存大小
/// 2)清除缓存
class CacheCleanUtil {
  ///获取缓存大小，已格式化成 xxM xxK
  static Future<String> getCacheSize() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    return _renderSize(value);
  }

  ///清理缓存
  static Future<void> cleanCache() async {
    Directory tempDir = await getTemporaryDirectory();
    final List<FileSystemEntity> children = tempDir.listSync();
    for (final FileSystemEntity child in children) {
      await child.delete(recursive: true);
    }
  }

  ///缓存路径
  static Future<String> cachePath() async {
    Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  static Future<double> _getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  ///格式化
  static String _renderSize(double value) {
    List<String> unitArr = []..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
}
