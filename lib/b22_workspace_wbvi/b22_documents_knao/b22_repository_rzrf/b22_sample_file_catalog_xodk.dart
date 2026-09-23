import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:path_provider/path_provider.dart';

class B22SampleFileCatalogQuns {
  B22SampleFileCatalogQuns._();

  static final B22SampleFileCatalogQuns b22InstanceWkwh =
      B22SampleFileCatalogQuns._();

  static const String b22DemoPdfAssetPathNfrk =
      'assets/b22_demo_library_kfgc/b22_reference_documents_abdz/b22_reference_document_mqcu.pdf';
  static const String b22DemoPdfFileNameKfli = 'PDF_Demo.pdf';
  static const String b22DemoDirectoryNameKrjb = 'demo_documents';

  FileToolsFileInfo? b22DemoPdfInfoJnmd;

  Future<FileToolsFileInfo?> b22LoadDemoDocumentGjsu() async {
    final FileToolsFileInfo? b22CachedInfoCwto = b22DemoPdfInfoJnmd;
    if (b22CachedInfoCwto != null &&
        File(b22CachedInfoCwto.path ?? '').existsSync()) {
      return b22CachedInfoCwto;
    }
    try {
      final File b22DemoFileQljm = await b22EnsureDemoPdfHqet();
      final FileStat b22FileStatXrgf = await b22DemoFileQljm.stat();
      b22DemoPdfInfoJnmd = FileToolsFileInfo(
        name: b22DemoPdfFileNameKfli,
        type: FileToolsDocumentType.pdf,
        updateTime: b22FileStatXrgf.modified.millisecondsSinceEpoch,
        size: b22FileStatXrgf.size,
        path: b22DemoFileQljm.path,
      );
      return b22DemoPdfInfoJnmd;
    } catch (_) {
      return null;
    }
  }

  Future<File> b22EnsureDemoPdfHqet() async {
    final Directory b22DocumentsDirectoryNeth =
        await getApplicationDocumentsDirectory();
    final Directory b22DemoDirectoryLrlz = Directory(
      '${b22DocumentsDirectoryNeth.path}/$b22DemoDirectoryNameKrjb',
    );
    if (!b22DemoDirectoryLrlz.existsSync()) {
      await b22DemoDirectoryLrlz.create(recursive: true);
    }
    final File b22DemoFileKsuq = File(
      '${b22DemoDirectoryLrlz.path}/$b22DemoPdfFileNameKfli',
    );
    if (b22DemoFileKsuq.existsSync()) {
      return b22DemoFileKsuq;
    }
    final ByteData b22DemoBytesUkri = await rootBundle.load(
      b22DemoPdfAssetPathNfrk,
    );
    await b22DemoFileKsuq.writeAsBytes(
      b22DemoBytesUkri.buffer.asUint8List(),
      flush: true,
    );
    return b22DemoFileKsuq;
  }
}
