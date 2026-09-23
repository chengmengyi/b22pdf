import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22RecentPromotionDisplayTimestampStoreZobt {
  static int b22ReadTimeMgqm() {
    return b22GetStoragePiaj.read<int>(
          B22StorageCatalogQugb.b22LastAdShowTimeCdup,
        ) ??
        0;
  }

  static Future<void> b22SaveTimeWuxl({required int b22TimestampYivv}) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22LastAdShowTimeCdup,
      b22TimestampYivv,
    );
  }
}
