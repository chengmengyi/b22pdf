import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22PromotionToggleStoreYbdo {
  static String b22ReadConfigYgej() {
    return b22GetStoragePiaj.read<String>(
          B22StorageCatalogQugb.b22AdSwitchDmzd,
        ) ??
        '';
  }

  static Future<void> b22SaveConfigIcqw(String b22ConfigRldd) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22AdSwitchDmzd,
      b22ConfigRldd,
    );
  }
}
