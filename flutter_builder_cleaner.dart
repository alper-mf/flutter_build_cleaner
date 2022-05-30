import 'dart:io';

Future<void> main() async {
  //Bulunduğumuz klasörü alma.
  final myDir = Directory('./');

  //Klasörlerin index ini almak için kullanılan int değer.
  int index = 0;

  //İstenilen Klasörü Silme
  Future<void> deleteDirectory([String? index]) async {
    final willDeletePath = '$index/build';
    final dir = Directory(index!);
    var folderDir = dir.list();
    //Silinmek istenilen klasör var olup, olmadığına bakılan boolean
    final checkPathIsExist = await Directory(willDeletePath).exists();

    if (checkPathIsExist) {
      await for (final FileSystemEntity i in folderDir) {
        if (i is Directory && i.path == willDeletePath) await i.delete();
      }
    } else {
      print(index + ' isimli projede build bulunamadı');
    }
  }

  //Klasörlerin adresini almak için kullanılan liste.
  List<String> _pathList = [];

  //İşlem yapan method.
  try {
    var dirList = myDir.list();
    //Bulunduğumuz path deki klasörlerin listesini alan döngü.
    await for (final FileSystemEntity i in dirList) {
      if (i is Directory) {
        print('[$index] --> ${i.path}');
        _pathList.add(i.path);
        index++;
      }
    }
    print(
        '\nListedeki bütün projelerin build kısımlarını temizlemek ister misiniz? Komut -> E || H');

    //Konsoldan komut almak için kullanılan kısım.
    String? answer = stdin.readLineSync()!.toLowerCase();

    //Cevabın kontrol edildiği if blogu
    if (answer == 'h') {
      int? n = int.parse(stdin.readLineSync()!);
      await deleteDirectory(_pathList[n]);
    } else if (answer == 'e') {
      for (var i = 0; i < _pathList.length; i++) {
        await deleteDirectory(_pathList[i]);
      }
    } else {
      print('Hatalı komut girdiniz');
    }
  } catch (e) {
    print(e.toString());
  }
}
