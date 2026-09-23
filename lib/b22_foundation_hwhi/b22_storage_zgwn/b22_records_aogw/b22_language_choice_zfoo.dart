import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

class B22LanguageChoiceDsdt {
  const B22LanguageChoiceDsdt._();

  static Future<void> b22SaveLanguageZcdq(String b22LanguageTagCmei) async {
    await b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22LanguageSelectedfjDhat,
      b22LanguageTagCmei,
    );
  }

  static String b22ReadLanguagePgwy() {
    return b22GetStoragePiaj.read<String>(
          B22StorageCatalogQugb.b22LanguageSelectedfjDhat,
        ) ??
        '';
  }
}
