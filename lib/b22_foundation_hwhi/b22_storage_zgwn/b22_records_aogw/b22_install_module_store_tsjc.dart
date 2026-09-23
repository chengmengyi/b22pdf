import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22InstallModuleStoreLldu {
  static bool b22ReadAddedHbyd() {
    return b22GetStoragePiaj.read<bool>(
          B22StorageCatalogQugb.b22AddWidgetZund,
        ) ??
        false;
  }

  static Future<void> b22SaveAddedPupj(bool b22AddedAwiv) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22AddWidgetZund,
      b22AddedAwiv,
    );
  }
}
