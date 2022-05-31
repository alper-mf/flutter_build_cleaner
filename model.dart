part of './flutter_builder_cleaner.dart';

class AppModel {
  AppModel._();

  //Klasör silmek için kullanılan method
  static Future<void> deleteDirectory(String index, String targetFolder) async {
    final willDeletePath = '$index/$targetFolder';
    final dir = Directory(index);
    var folderDir = dir.list();

    //Silinmek istenilen klasörün var olup, olmadığını kontrol eden boolean
    final checkPathIsExist = await Directory(willDeletePath).exists();

    //Silinmek istenilen klasörün var olup, olmadığını kontrol eden blok
    if (checkPathIsExist) {
      await for (final FileSystemEntity i in folderDir) {
        if (i is Directory && i.path == willDeletePath) {
          await i.delete(recursive: true);
          print('$targetFolder' + AppConst.isRemoved);
        }
      }
    } else {
      print(index + AppConst.isNotExist);
    }
  }
}
