import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22AdClickDelayDhid {
  static int b22ReadUzvw() {
    return b22GetStoragePiaj.read<int>(B22StorageCatalogQugb.b22AdClickDelayDJeJO) ??
        15;
  }

  static Future<void> b22SaveOaaq({required int b22TimestampAvvh}) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22AdClickDelayDJeJO,
      b22TimestampAvvh,
    );
  }
}
