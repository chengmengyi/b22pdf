import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:event_bus/event_bus.dart';

typedef B22ApplicationSignalListenerMkvp =
    void Function(B22ApplicationSignalXfvp event);

class B22ApplicationSignalHubQzvk {
  static final B22ApplicationSignalHubQzvk b22InstanceRsiv =
      B22ApplicationSignalHubQzvk();
  static B22ApplicationSignalHubQzvk get instance => b22InstanceRsiv;

  final EventBus b22EventBusXiqk = EventBus();

  void b22PublishQwoy(B22ApplicationSignalXfvp b22EventLqbf) {
    b22EventBusXiqk.fire(b22EventLqbf);
  }

  StreamSubscription<B22ApplicationSignalXfvp> b22SubscribeFbai({
    required B22ApplicationSignalListenerMkvp b22EventCallbackCxjl,
  }) {
    return b22EventBusXiqk.on<B22ApplicationSignalXfvp>().listen(
      b22EventCallbackCxjl,
    );
  }
}
