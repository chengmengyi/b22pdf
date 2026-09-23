import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class B22FoundationCoordinatorXsba extends GetxController {
  StreamSubscription<B22ApplicationSignalXfvp>? b22EventSubscriptiondCkih;

  @override
  void onInit() {
    super.onInit();
    if (subscribesToAppEvents()) {
      b22EventSubscriptiondCkih = B22ApplicationSignalHubQzvk.instance
          .b22SubscribeFbai(b22EventCallbackCxjl: onAppEvent);
    }
  }

  bool subscribesToAppEvents() => false;

  void onAppEvent(B22ApplicationSignalXfvp event) {}

  @override
  void onClose() {
    if (subscribesToAppEvents()) {
      b22EventSubscriptiondCkih?.cancel();
      b22EventSubscriptiondCkih = null;
    }
    super.onClose();
  }
}
