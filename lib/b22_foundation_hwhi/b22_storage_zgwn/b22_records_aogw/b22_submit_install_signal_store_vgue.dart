import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22SubmitInstallSignalStoreKmvw {
  static bool b22ReadEnabledLrfs() {
    return b22GetStoragePiaj.read<bool>(
          B22StorageCatalogQugb.b22UploadInstallEventSypl,
        ) ??
        true;
  }

  static Future<void> b22SaveEnabledBllf(bool b22EnabledXkxn) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22UploadInstallEventSypl,
      b22EnabledXkxn,
    );
  }
}
