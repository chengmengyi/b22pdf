import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22GuideCompletionStorePqaz {
  static bool b22ReadCompletedLwmc() {
    return b22GetStoragePiaj.read<bool>(
          B22StorageCatalogQugb.b22GuideCompletedAnzu,
        ) ??
        false;
  }

  static Future<void> b22SaveCompletedJtro(bool b22CompletedFqpa) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22GuideCompletedAnzu,
      b22CompletedFqpa,
    );
  }
}
