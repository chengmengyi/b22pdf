import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22PrepareFreshEntryPromotionStoreUgpz {
  static bool b22ReadEnabledZang() {
    return b22GetStoragePiaj.read<bool>(
          B22StorageCatalogQugb.b22LoadNewLaunchAdAcou,
        ) ??
        true;
  }

  static Future<void> b22SaveEnabledHmfa(bool b22EnabledOfka) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22LoadNewLaunchAdAcou,
      b22EnabledOfka,
    );
  }
}
