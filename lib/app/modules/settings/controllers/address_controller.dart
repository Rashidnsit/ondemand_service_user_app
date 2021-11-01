import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../repositories/setting_repository.dart';
import '../../../services/auth_service.dart';

class AddressController extends GetxController {
  SettingRepository _settingRepository;
  final addresses = <Address>[].obs;

  AddressController() {
    _settingRepository = new SettingRepository();
  }

  @override
  void onInit() async {
    await refreshAddresses();
    super.onInit();
  }

  Future refreshAddresses({bool showMessage}) async {
    await getAddresses();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "List of addresses refreshed successfully".tr));
    }
  }

  Future getAddresses() async {
    try {
      if (Get.find<AuthService>().isAuth) {
        addresses.assignAll(await _settingRepository.getAddresses());
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
