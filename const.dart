class AppConst {
  AppConst._();

  //Ana klasör yolu
  static const directory = '../';

  //Temizlenmesi istenilen klasör adı.
  static const targetFolder = 'build';

  //Flutter projesi olup olmadığını kontrol ettiğimiz dosya.
  static const targetFile = '/pubspec.yaml';

  ///[targetFolder] isimli projede build bulunamadı
  static const isNotExist = ' isimli projede build bulunamadı.';

  ///Listedeki bütün projelerin build kısımlarını temizlemek ister misiniz? Komut -> E & H
  static const cleanBuildFoldersInAllProjects =
      '\nListedeki bütün projelerin build kısımlarını temizlemek ister misiniz? Komut -> E & H';

  ///Hangi projedeki build i temizlemek istiyorsunuz?
  static const whichDestinationFolderDoYouWantDelete =
      'Hangi projedeki build i temizlemek istiyorsunuz?';

  ///[targetFolder] temizlendi.
  static const isRemoved = ' temizlendi.';

  ///[targetFolder] bulunamadı ya da başka bir hata oluştu.';
  static const targetFolderIsNotFound = '  bulunamadı ya da başka bir hata oluştu.';

  ///Hatalı komut girdiniz.
  static const wrongCommand = 'Hatalı komut girdiniz.';
}
