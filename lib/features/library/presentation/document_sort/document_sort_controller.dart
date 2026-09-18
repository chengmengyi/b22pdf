import 'package:b21pdf/core/analytics/analytics_event.dart';
import 'package:b21pdf/core/analytics/analytics_service.dart';
import 'package:b21pdf/core/presentation/base_controller.dart';
import 'package:b21pdf/core/navigation/app_navigator.dart';

enum SortType {
  dateNew(
    "Date",
    "Newest First"
  ),
  dateOld(
    "Date",
    "Oldest First"
  ),
  nameAZ(
    "Name",
    "A-Z"
  ),
  nameZA(
    "Name",
    "Z-A"
  );

  final String text;
  final String desc;
  const SortType(this.text,this.desc);
}

class DocumentSortController extends BaseController {
  final SortType selectedType;
  DocumentSortController({required this.selectedType});

  void onSortPressed(SortType type) {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.file_sort_change,
      parameters: {"sort_type": type.name},
    );
    AppNavigator.back<SortType>(result: type);
  }
}
