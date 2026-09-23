import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_delete_documents_cinc/b22_removal_documents_page_haru.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_interface_brpn/b22_locale_chooser_page_bjtg.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_home_ivzz/b22_dashboard_page_uvio.dart';
import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_interface_swtj/b22_image_selection_wxeq/b22_picture_chooser_page_dtkp.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_interface_ypio/b22_entry_page_mbnh.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_interface_ypio/b22_open_ad_loading_qpmf/b22_launch_promotion_waiting_page_hnld.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_interface_ozan/b22_permission_uawu/b22_alert_access_page_xyvo.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_overlay_permission_dajf/b22_floating_layer_access_page_jvsw.dart';
import 'package:b22_document_workspace_kmzm/b22_preview_lzrw/b22_document_viewers_ucjg/b22_pdf_tlyq/b22_interface_rtpg/b22_pdf_reader_page_vylo.dart';
import 'package:b22_document_workspace_kmzm/b22_preview_lzrw/b22_document_viewers_ucjg/b22_word_bhyo/b22_interface_tnve/b22_text_document_reader_page_fbno.dart';
import 'package:b22_document_workspace_kmzm/b22_preview_lzrw/b22_document_viewers_ucjg/b22_excel_amzg/b22_interface_nitf/b22_spreadsheet_reader_page_qkot.dart';
import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_interface_swtj/b22_task_result_rbnx/b22_pdf_job_outcome_page_qmam.dart';
import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_interface_swtj/b22_task_progress_warm/b22_pdf_job_execution_page_owno.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_uninstall_feedback_ozkk/b22_removal_response_page_smxi.dart';
import 'package:get/get.dart';

abstract final class B22ApplicationDestinationsMcbk {
  static const String b22LauncherRouteFstc = '/startup';
  static const String b22OverlayPermissionRouteGvjt = '/open_overlay_access';
  static const String b22NotificationRouteOwvv = '/open_notice';
  static const String b22HomeRouteEdoo = '/dashboard';
  static const String b22DeleteFileRouteBsfx = '/remove_document';
  static const String b22ChooseLanguageRouteDfsy = '/select_locale';
  static const String b22PreviewPdfRouteLumo = '/viewer_pdf';
  static const String b22PreviewWordRouteDgsr = '/viewer_word';
  static const String b22PreviewExcelRouteZify = '/viewer_excel';
  static const String b22UninstallRouteSqjj = '/uninstall';
  static const String b22ImagesResultRouteZkhv = '/pictures_output';
  static const String b22ProcessWaitingRouteGtfb = '/task_progress';
  static const String b22ProcessResultRouteAjen = '/task_output';
  static const String b22OpenAdLoadingRouteQnvm = '/open_ad_loading';

  static final List<GetPage<dynamic>> b22PagesMdxd = [
    GetPage(name: b22LauncherRouteFstc, page: B22EntryPageAwcy.new),
    GetPage(
      name: b22OverlayPermissionRouteGvjt,
      page: B22FloatingLayerAccessPageIemy.new,
    ),
    GetPage(name: b22NotificationRouteOwvv, page: B22AlertAccessPageNwlv.new),
    GetPage(name: b22HomeRouteEdoo, page: B22DashboardPageLkpx.new),
    GetPage(
      name: b22DeleteFileRouteBsfx,
      page: B22RemovalDocumentsPageFvnv.new,
    ),
    GetPage(
      name: b22ChooseLanguageRouteDfsy,
      page: B22LocaleChooserPagePkgi.new,
    ),
    GetPage(name: b22PreviewPdfRouteLumo, page: B22PdfReaderPageFneh.new),
    GetPage(
      name: b22PreviewWordRouteDgsr,
      page: B22TextDocumentReaderPageBzae.new,
    ),
    GetPage(
      name: b22PreviewExcelRouteZify,
      page: B22SpreadsheetReaderPageFkwp.new,
    ),
    GetPage(name: b22UninstallRouteSqjj, page: B22RemovalResponsePageDhiz.new),
    GetPage(
      name: b22ImagesResultRouteZkhv,
      page: B22PictureChooserPageVaxe.new,
    ),
    GetPage(
      name: b22ProcessWaitingRouteGtfb,
      page: B22PdfJobExecutionPageNjsk.new,
    ),
    GetPage(
      name: b22ProcessResultRouteAjen,
      page: B22PdfJobOutcomePageGfpb.new,
    ),
    GetPage(
      name: b22OpenAdLoadingRouteQnvm,
      page: B22LaunchPromotionWaitingPageXbsa.new,
    ),
  ];
}
