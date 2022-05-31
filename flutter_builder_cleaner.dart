import 'dart:io';
import './const.dart';

Future<void> main() async {
  //Silinecek olan klasörlerin yolu.
  final myDir = Directory('../');

  //Temizlenmesi istenilen klasör adı.
  final targetFolder = 'build';

  //Flutter projesi olup olmadığını kontrol ettiğimiz dosya.
  final targetFile = '/pubspec.yaml';

  //Klasörlerin index ini almak için kullanılan int değer.
  int index = 0;

  //Klasör silmek için kullanılan method
  Future<void> deleteDirectory([String? index]) async {
    final willDeletePath = '$index/$targetFolder';
    final dir = Directory(index!);
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

  //Klasörlerin adresini almak için kullanılan liste.
  List<String> _pathList = [];

  //İşlem yapan method.
  try {
    var dirList = myDir.list();
    //Bulunduğumuz path deki klasörlerin listesini alan döngü.
    await for (final FileSystemEntity i in dirList) {
      if (i is Directory) {
        final checkFileIsExist = await File(i.path + targetFile).exists();
        if (checkFileIsExist) _pathList.add(i.path);
        index++;
      }
    }

    if (_pathList.isNotEmpty) {
      //ASK
      print(AppConst.cleanBuildFoldersInAllProjects);

      //Konsoldan komut almak için kullanılan kısım.
      String? answer = stdin.readLineSync()!.toLowerCase();

      //Cevabın kontrol edildiği if blogu
      if (answer == 'h') {
        //Cevap eğer hayır ise, klasör seçilmesini isteye blok
        print(AppConst.whichDestinationFolderDoYouWantDelete);
        int? n = int.parse(stdin.readLineSync()!);
        try {
          await deleteDirectory(_pathList[n]);
        } catch (e) {
          print(targetFolder + AppConst.targetFolderIsNotFound);
        }
      } else if (answer == 'e') {
        //Cevap eğer evet ise, projelerdeki hedef klasör temizleyen blok
        for (var i = 0; i < _pathList.length; i++) {
          await deleteDirectory(_pathList[i]);
        }
      } else {
        print(AppConst.wrongCommand);
      }
    }
  } catch (e) {
    print(e.toString());
  }
}
