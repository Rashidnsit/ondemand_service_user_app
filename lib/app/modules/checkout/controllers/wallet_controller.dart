import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../models/payment_model.dart';
import '../../../models/wallet_model.dart';
import '../../../repositories/payment_repository.dart';
import '../../bookings/controllers/bookings_controller.dart';
import '../../global_widgets/tab_bar_widget.dart';

class WalletController extends GetxController {
  PaymentRepository _paymentRepository;
  final payment = new Payment().obs;
  final booking = new Booking().obs;
  final wallet = new Wallet().obs;

  WalletController() {
    _paymentRepository = new PaymentRepository();
  }

  @override
  void onInit() {
    booking.value = Get.arguments['booking'] as Booking;
    wallet.value = Get.arguments['wallet'] as Wallet;
    payBooking();
    super.onInit();
  }

  Future payBooking() async {
    try {
      payment.value = await _paymentRepository.createWalletPayment(
        Booking(id: booking.value.id, payment: booking.value.payment),
        wallet.value,
      );
      if (payment.value != null && payment.value.hasData) {
        refreshBookings();
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  bool isLoading() {
    if (payment.value != null && !payment.value.hasData) {
      return true;
    }
    return false;
  }

  bool isDone() {
    if (payment.value != null && payment.value.hasData) {
      return true;
    }
    return false;
  }

  bool isFailed() {
    if (payment.value == null) {
      return true;
    }
    return false;
  }

  void refreshBookings() {
    Get.find<BookingsController>().currentStatus.value = Get.find<BookingsController>().getStatusByOrder(50).id;
    if (Get.isRegistered<TabBarController>(tag: 'bookings')) {
      Get.find<TabBarController>(tag: 'bookings').selectedId.value = Get.find<BookingsController>().getStatusByOrder(50).id;
    }
/*    Get.toNamed(Routes.CONFIRMATION, arguments: {
      'title': "Payment Confirmation".tr,
      'long_message': "Your payment is pending confirmation from the Service Provider".tr,
    });*/
  }
}
