import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22ExitNotificationDelayStoreWmku {
  static int b22ReadZqjf() {
    return b22GetStoragePiaj.read<int>(
          B22StorageCatalogQugb.b22ExitNotificationDelayQjva,
        ) ??
        60;
  }

  static Future<void> b22SaveXcpr(int b22DelaySecondsGvta) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22ExitNotificationDelayQjva,
      b22DelaySecondsGvta,
    );
  }
}
