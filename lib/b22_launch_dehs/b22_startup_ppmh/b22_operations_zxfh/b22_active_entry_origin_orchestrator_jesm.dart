enum B22EntryOriginKindOxpi { notification, quickAction }

class B22EntryOriginTekr {
  const B22EntryOriginTekr({
    required this.b22TypeSskh,
    this.b22PayloadFpvt,
    this.b22QuickActionTypeGlgz,
  });

  final B22EntryOriginKindOxpi b22TypeSskh;
  final String? b22PayloadFpvt;
  final String? b22QuickActionTypeGlgz;
}

class B22ActiveEntryOriginOrchestratorIonc {
  B22ActiveEntryOriginOrchestratorIonc._();

  static final B22ActiveEntryOriginOrchestratorIonc b22InstanceRuid =
      B22ActiveEntryOriginOrchestratorIonc._();
  static B22ActiveEntryOriginOrchestratorIonc get instance => b22InstanceRuid;

  B22EntryOriginTekr? b22PendingSourceCjoq;

  void recordNotificationLaunch(String b22PayloadCvbn) {
    b22PendingSourceCjoq = B22EntryOriginTekr(
      b22TypeSskh: B22EntryOriginKindOxpi.notification,
      b22PayloadFpvt: b22PayloadCvbn,
    );
  }

  void b22RecordShortcutLaunchUizb(String b22ShortcutTypeLzzz) {
    b22PendingSourceCjoq = B22EntryOriginTekr(
      b22TypeSskh: B22EntryOriginKindOxpi.quickAction,
      b22QuickActionTypeGlgz: b22ShortcutTypeLzzz,
    );
  }

  B22EntryOriginTekr? b22ConsumeLaunchSourceHmhd() {
    final B22EntryOriginTekr? b22SourceWrpr = b22PendingSourceCjoq;
    b22PendingSourceCjoq = null;
    return b22SourceWrpr;
  }

  b22ClearXdnh() {
    b22PendingSourceCjoq = null;
  }
}
