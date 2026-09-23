import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';

class B22EntryInputGateKjfv {
  B22EntryInputGateKjfv._();

  static final B22EntryInputGateKjfv b22InstanceHthn =
      B22EntryInputGateKjfv._();

  bool b22LauncherAliveKgxz = true;
  bool b22LauncherAdShownJoek = false;
  B22PromotionContextSuaj? b22PendingAdSceneUsaj;
  B22PromotionSlotZwla? b22PendingAdPosIdUdiy;

  bool get canHandleNotificationClick =>
      !b22LauncherAliveKgxz || b22LauncherAdShownJoek;

  void b22MarkLauncherStartedEvur() {
    b22LauncherAliveKgxz = true;
    b22LauncherAdShownJoek = false;
    b22ClearPendingAdQmiu();
  }

  void b22MarkLauncherAdWaitingYngv({
    required B22PromotionContextSuaj b22AdSceneJmez,
    required B22PromotionSlotZwla b22AdPosIdGbme,
  }) {
    b22LauncherAdShownJoek = false;
    b22PendingAdSceneUsaj = b22AdSceneJmez;
    b22PendingAdPosIdUdiy = b22AdPosIdGbme;
  }

  void b22MarkLauncherAdShownIfMatchedRacq({
    required B22PromotionContextSuaj b22AdSceneBptf,
    required B22PromotionSlotZwla b22AdPosIdLlho,
  }) {
    if (!b22LauncherAliveKgxz ||
        b22PendingAdSceneUsaj != b22AdSceneBptf ||
        b22PendingAdPosIdUdiy != b22AdPosIdLlho) {
      return;
    }
    b22LauncherAdShownJoek = true;
    b22ClearPendingAdQmiu();
  }

  void b22MarkLauncherAdNotShownPbqz() {
    b22LauncherAdShownJoek = false;
    b22ClearPendingAdQmiu();
  }

  void b22MarkLauncherClosedVsfc() {
    b22LauncherAliveKgxz = false;
    b22ClearPendingAdQmiu();
  }

  void b22ClearPendingAdQmiu() {
    b22PendingAdSceneUsaj = null;
    b22PendingAdPosIdUdiy = null;
  }
}
