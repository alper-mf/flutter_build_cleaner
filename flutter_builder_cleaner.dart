import 'dart:io';
import './const.dart';

Future<void> main() async {
  //Bulunduğumuz klasörü alma.
  final myDir = Directory('./');
  //Temizlenmesi istenilen klasör adı.
  final targetFolder = 'sub_folder_2';
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
        if (i is Directory && i.path == willDeletePath) await i.delete();
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
        print('[$index] --> ${i.path}');
        if (i.path != '.git') _pathList.add(i.path);
        index++;
      }
    }

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
        print('$targetFolder' + AppConst.isRemoved);
      } catch (e) {
        print(targetFolder + AppConst.targetFolderIsNotFound);
      }
    } else if (answer == 'e') {
      //Cevap eğer evet ise, tüm projelerdeki hedef klasör temizleyen blok
      for (var i = 0; i < _pathList.length; i++) {
        await deleteDirectory(_pathList[i]);
      }
    } else {
      print(AppConst.wrongCommand);
    }
  } catch (e) {
    print(e.toString());
  }
}
