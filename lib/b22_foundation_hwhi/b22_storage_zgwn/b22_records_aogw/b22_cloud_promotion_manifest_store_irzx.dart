import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22CloudPromotionManifestStoreNdmv {
  static String b22ReadConfigNutv() {
    return b22GetStoragePiaj.read<String>(
          B22StorageCatalogQugb.b22FirebaseAdConfigNtuf,
        ) ??
        '';
  }

  static Future<void> b22SaveConfigAilx(String b22ConfigTkop) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22FirebaseAdConfigNtuf,
      b22ConfigTkop,
    );
  }
}
