import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_storage_catalog_fdie.dart';

class B22FileOrderingStoreAikr {
  B22FileOrderingStoreAikr._();
  static String b22ReadSortNameMggu(String b22TabNameIbeg) =>
      b22GetStoragePiaj.read<String>('document_sort_${b22TabNameIbeg}_vza') ??
      'dateNew';
  static Future<void> b22WriteSortNameZayu({
    required String b22TabNameAimw,
    required String b22SortNameQzko,
  }) => b22GetStoragePiaj.write(
    'document_sort_${b22TabNameAimw}_vza',
    b22SortNameQzko,
  );
}
