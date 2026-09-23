import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:get/get.dart';

class B22RemovalDocumentsCoordinatorWqnn extends B22FoundationCoordinatorXsba {
  final List<FileToolsFileInfo> b22FilesKjqb = List<FileToolsFileInfo>.from(
    (Get.arguments?['files'] as List?) ?? const [],
  );
  final Set<String> b22SelectedPathsWufp = <String>{};
  bool get allSelected {
    final b22PathsBglg = b22FilesKjqb
        .map((b22FileQack) => b22FileQack.path)
        .whereType<String>()
        .toSet();
    return b22PathsBglg.isNotEmpty &&
        b22SelectedPathsWufp.containsAll(b22PathsBglg);
  }

  bool b22IsSelectedZzng(FileToolsFileInfo b22FileVjyg) =>
      b22SelectedPathsWufp.contains(b22FileVjyg.path);
  void b22OnItemPressedJgqk(FileToolsFileInfo b22FileTgqb) {
    final b22PathTgqt = b22FileTgqb.path;
    if (b22PathTgqt == null) return;
    b22SelectedPathsWufp.contains(b22PathTgqt)
        ? b22SelectedPathsWufp.remove(b22PathTgqt)
        : b22SelectedPathsWufp.add(b22PathTgqt);
    update();
  }

  void b22OnSelectAllPressedKxvd() {
    if (allSelected) {
      b22SelectedPathsWufp.clear();
    } else {
      b22SelectedPathsWufp.addAll(
        b22FilesKjqb.map((b22FileJoxm) => b22FileJoxm.path).whereType<String>(),
      );
    }
    update();
  }

  Future<void> b22OnDeletePressedVanr() async {
    if (b22SelectedPathsWufp.isEmpty) return;
    for (final b22PathIvkm in b22SelectedPathsWufp) {
      await FlutterPreviewFile.deleteFile(b22PathIvkm);
    }
    B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
      B22ApplicationSignalXfvp(
        b22TypeIafj: B22ApplicationSignalKindJiwh.b22FileListRefreshOivp,
      ),
    );
    B22ApplicationRouterJfva.b22BackCwkm();
  }

  String b22ResolveFileIconUnjz(
    FileToolsFileInfo b22FilePlje,
  ) => switch (b22FilePlje.type) {
    FileToolsDocumentType.pdf =>
      'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_pdf_badge_qmqd',
    FileToolsDocumentType.excel =>
      'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_spreadsheet_badge_zzbg',
    _ =>
      'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_document_badge_frgw',
  };
}
