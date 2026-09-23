import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22RecentLaunchPromotionCloseTimestampVfuy {
  static int b22ReadTimeYbbo() {
    return b22GetStoragePiaj.read<int>(
          B22StorageCatalogQugb.b22LastOpenAdCloseTimeYpgd,
        ) ??
        0;
  }

  static Future<void> b22SaveTimeTnvx(int b22TimestampKyig) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22LastOpenAdCloseTimeYpgd,
      b22TimestampKyig,
    );
  }
}
