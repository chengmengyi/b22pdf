import 'package:get/get.dart';

final class B22CoordinatorHolderHuqz<B22TBgpu extends GetxController> {
  B22CoordinatorHolderHuqz._(
    this.b22ControllerYaqk,
    this.b22TagYehi,
    this.b22OwnsRegistrationApke,
  );

  final B22TBgpu b22ControllerYaqk;
  final String? b22TagYehi;
  final bool b22OwnsRegistrationApke;

  static B22CoordinatorHolderHuqz<B22TPmjq>
  b22AcquireEhta<B22TPmjq extends GetxController>({
    required B22TPmjq Function() createController,
    String? b22TagCgsk,
    bool b22PermanentXbpd = false,
  }) {
    if (Get.isRegistered<B22TPmjq>(tag: b22TagCgsk)) {
      return B22CoordinatorHolderHuqz<B22TPmjq>._(
        Get.find<B22TPmjq>(tag: b22TagCgsk),
        b22TagCgsk,
        false,
      );
    }

    return B22CoordinatorHolderHuqz<B22TPmjq>._(
      Get.put<B22TPmjq>(
        createController(),
        tag: b22TagCgsk,
        permanent: b22PermanentXbpd,
      ),
      b22TagCgsk,
      !b22PermanentXbpd,
    );
  }

  void b22ReleaseLikm() {
    if (b22OwnsRegistrationApke &&
        Get.isRegistered<B22TBgpu>(tag: b22TagYehi)) {
      Get.delete<B22TBgpu>(tag: b22TagYehi);
    }
  }
}
