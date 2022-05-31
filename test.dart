import 'dart:io';

Future<void> main() async {
  //Silinecek olan klasörlerin yolu.
  final myDir = Directory('../');
  final targetFile = '/pubspec.yaml';
  List<String> _pathList = [];

  try {
    final dir = myDir.list();

    await for (final FileSystemEntity i in dir) {
      if (i is Directory) {
        final checkFileIsExist = await File(i.path + targetFile).exists();
        if (checkFileIsExist) {
          _pathList.add(i.path);
          print('Dosya Mevcut');
        } else {
          print('Dosya Mevcut Değil');
        }
      }
    }

    print(_pathList);
  } catch (e) {}
}
