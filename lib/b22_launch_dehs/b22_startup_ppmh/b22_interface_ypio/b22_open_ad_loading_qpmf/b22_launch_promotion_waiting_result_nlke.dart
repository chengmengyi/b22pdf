import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';

enum B22LaunchPromotionWaitingStatusBtpp { b22CacheReadyVwbr, b22CancelledOpfs }

class B22LaunchPromotionWaitingResultFqwa {
  const B22LaunchPromotionWaitingResultFqwa.ready({
    required this.b22SessionIdZcsg,
    required this.b22AdSceneAgkl,
    required this.b22AdPosIdIaul,
  }) : b22StatusFudz = B22LaunchPromotionWaitingStatusBtpp.b22CacheReadyVwbr,
       b22ReasonPrxj = 'cache_ready';

  const B22LaunchPromotionWaitingResultFqwa.cancelled({
    required this.b22SessionIdZcsg,
    required this.b22ReasonPrxj,
    this.b22AdSceneAgkl,
    this.b22AdPosIdIaul,
  }) : b22StatusFudz = B22LaunchPromotionWaitingStatusBtpp.b22CancelledOpfs;

  final int b22SessionIdZcsg;
  final B22LaunchPromotionWaitingStatusBtpp b22StatusFudz;
  final B22PromotionContextSuaj? b22AdSceneAgkl;
  final B22PromotionSlotZwla? b22AdPosIdIaul;
  final String b22ReasonPrxj;

  bool get b22CacheReadyXzpp =>
      b22StatusFudz == B22LaunchPromotionWaitingStatusBtpp.b22CacheReadyVwbr;
}
