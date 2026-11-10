import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22MediaReplacementStoreVzpt {
  static int b22ReadHncm() {
    return b22GetStoragePiaj.read<int>(
          B22StorageCatalogQugb.b22MediaReplacementConfigNwkh,
        ) ??
        1;
  }

  static Future<void> b22SaveQjrs(int b22ConfigAevm) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22MediaReplacementConfigNwkh,
      b22ConfigAevm,
    );
  }
}
