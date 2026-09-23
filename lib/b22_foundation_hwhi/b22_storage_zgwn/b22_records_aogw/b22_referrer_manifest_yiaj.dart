import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

class B22ReferrerManifestJght {
  const B22ReferrerManifestJght._();

  static Future<void> b22SaveXqdi(String b22ConfigCviy) async {
    await b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22ReferrerConfigEexq,
      b22ConfigCviy,
    );
  }

  static String b22ReadAmbt() {
    return b22GetStoragePiaj.read<String>(
          B22StorageCatalogQugb.b22ReferrerConfigEexq,
        ) ??
        '';
  }
}
