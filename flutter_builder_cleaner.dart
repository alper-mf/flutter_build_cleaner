import 'dart:io';
import './const.dart';
part 'model.dart';

Future<void> main() async {
  //
  print('\n');

  //Silinecek olan klasörlerin yolu.
  final myDir = Directory(AppConst.directory);

  //Temizlenmesi istenilen klasör adı.
  final targetFolder = AppConst.targetFolder;

  //Flutter projesi olup olmadığını kontrol ettiğimiz dosya.
  final targetFile = AppConst.targetFile;

  //Klasörlerin index ini almak için kullanılan int değer.
  int index = 0;

  //Klasörlerin adresini almak için kullanılan liste.
  List<String> _pathList = [];

  //İşlem yapan method.
  try {
    var dirList = myDir.list();
    //Bulunduğumuz path deki klasörlerin listesini alan döngü.
    await for (final FileSystemEntity i in dirList) {
      if (i is Directory) {
        final checkFileIsExist = await File(i.path + targetFile).exists();
        if (checkFileIsExist) {
          _pathList.add(i.path);
          print('     [$index] → ' + i.path);
          index++;
        }
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
          await AppModel.deleteDirectory(_pathList[n], targetFolder);
        } catch (e) {
          print(targetFolder + AppConst.targetFolderIsNotFound);
        }
      } else if (answer == 'e') {
        //Cevap eğer evet ise, projelerdeki hedef klasör temizleyen blok
        for (var i = 0; i < _pathList.length; i++) {
          await AppModel.deleteDirectory(_pathList[i], targetFolder);
        }
      } else {
        print(AppConst.wrongCommand);
      }
    }
  } catch (e) {
    print(e.toString());
  }
}
