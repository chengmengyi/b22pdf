import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_application_lexicon_evae.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_first_entry_origin_orchestrator_wwrf.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_active_entry_origin_orchestrator_jesm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:flutter_add_widget_plugins/flutter_add_widget_plugins.dart';

class B22QuickActionOrchestratorYmez {
  static final B22QuickActionOrchestratorYmez b22InstanceNlyg =
      B22QuickActionOrchestratorYmez();
  static B22QuickActionOrchestratorYmez get instance => b22InstanceNlyg;

  static const String b22UninstallTypeUwfu = 'uninstall';

  final QuickActions b22QuickActionsHtmg = const QuickActions();
  Future<void>? b22InitializeFutureGxpc;
  String? b22PendingTypeYbje;
  bool b22InitializedWfww = false;
  bool b22LauncherFinishedZcht = false;

  Future<void> b22InitializeKqab() {
    b22InitializeFutureGxpc ??= b22InitializeInternalDthm();
    return b22InitializeFutureGxpc!;
  }

  Future<void> b22InitializeInternalDthm() async {
    if (b22InitializedWfww) {
      return;
    }
    b22InitializedWfww = true;
    await b22QuickActionsHtmg.initialize((String b22ShortcutTypeMyuj) {
      if (!b22LauncherFinishedZcht) {
        b22PendingTypeYbje = b22ShortcutTypeMyuj;
        B22FirstEntryOriginOrchestratorJicy.instance
            .b22RecordShortcutLaunchTlej(b22ShortcutTypeMyuj);
        return;
      }
      B22ActiveEntryOriginOrchestratorIonc.instance.b22RecordShortcutLaunchUizb(
        b22ShortcutTypeMyuj,
      );
      unawaited(
        b22RouteShortcutWcdn(b22ShortcutTypeMyuj, b22FromColdStartWpvo: false),
      );
    });
    await b22UpdateShortcutsKket();
  }

  Future<bool> b22HandlePendingColdStartShortcutVffa() async {
    await b22InitializeKqab();
    b22LauncherFinishedZcht = true;
    final String? b22ShortcutTypePghs = b22PendingTypeYbje;
    b22PendingTypeYbje = null;
    if (b22ShortcutTypePghs == null || b22ShortcutTypePghs.isEmpty) {
      return false;
    }
    return b22RouteShortcutWcdn(
      b22ShortcutTypePghs,
      b22FromColdStartWpvo: true,
    );
  }

  Future<bool> b22RouteShortcutWcdn(
    String b22ShortcutTypeZxna, {
    required bool b22FromColdStartWpvo,
  }) async {
    if (b22ShortcutTypeZxna != b22UninstallTypeUwfu) {
      return false;
    }
    if (b22FromColdStartWpvo) {
      B22FirstEntryOriginOrchestratorJicy.instance.b22RecordShortcutLaunchTlej(
        b22ShortcutTypeZxna,
      );
      await B22ApplicationRouterJfva.b22ReplaceNamedGvtg(
        b22RouteNameSrbn: B22ApplicationDestinationsMcbk.b22UninstallRouteSqjj,
      );
    } else {
      await B22ApplicationRouterJfva.b22PushNamedWarf(
        b22RouteNameHlpz: B22ApplicationDestinationsMcbk.b22UninstallRouteSqjj,
      );
    }
    return true;
  }

  Future<void> b22UpdateShortcutsKket() async {
    final b22LocaleOnkr =
        B22ApplicationLexiconNofd.b22ResolveInitialLocaleYfpt();
    final String b22UninstallTitleGuae =
        B22ApplicationLexiconNofd.b22ResolveTextForLocaleJzsv(
          b22LocaleVfvb: b22LocaleOnkr,
          b22KeyDwnr: 'b22_uninstall_waqq',
        );
    await b22QuickActionsHtmg.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: b22UninstallTypeUwfu,
        localizedTitle: b22UninstallTitleGuae,
        icon: "uninstall_icon",
      ),
    ]);
  }
}
