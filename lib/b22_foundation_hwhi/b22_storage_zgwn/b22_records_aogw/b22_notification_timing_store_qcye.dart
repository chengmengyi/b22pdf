import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

abstract final class B22NotificationTimingStoreCzfr {
  static const String b22DefaultConfigRkvy =
      '{"all_push_cd":60,"local_interval":3600,"action_interval":600,'
      '"battery_changed":1200,"push_max_time":30,'
      '"push_max_broadcast":20,"push_refresh_1":2,'
      '"push_refresh_2":30,"push_clean":1,"push_clean_time":600}';

  static String b22ReadKsdx() {
    return b22GetStoragePiaj.read<String>(
          B22StorageCatalogQugb.b22NotificationTimingConfigYqfl,
        ) ??
        b22DefaultConfigRkvy;
  }

  static Future<void> b22SaveLwpf(String b22ConfigTqmc) {
    return b22GetStoragePiaj.write(
      B22StorageCatalogQugb.b22NotificationTimingConfigYqfl,
      b22ConfigTqmc,
    );
  }
}
