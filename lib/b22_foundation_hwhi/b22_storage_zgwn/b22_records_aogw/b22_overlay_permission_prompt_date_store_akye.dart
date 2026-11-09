import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22OverlayPermissionPromptDateStoreHqaz {
  static String b22ReadDateHmwc() {
    return b22GetStoragePiaj.read<String>(
          B22StorageCatalogQugb.b22OverlayPermissionPromptDateVxwe,
        ) ??
        '';
  }

  static Future<void> b22SaveDateJrko(String b22DateOasv) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22OverlayPermissionPromptDateVxwe,
      b22DateOasv,
    );
  }
}
