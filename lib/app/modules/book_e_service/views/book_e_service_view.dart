import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/book_e_service_controller.dart';

class BookEServiceView extends GetView<BookEServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Book the Service".tr,
            style: context.textTheme.headline6,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
        ),
        bottomNavigationBar: buildBlockButtonWidget(controller.booking.value),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              decoration: Ui.getBoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(child: Text("Your Addresses".tr, style: Get.textTheme.bodyText1)),
                      SizedBox(width: 4),
                      MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        onPressed: () {
                          Get.toNamed(Routes.SETTINGS_ADDRESS_PICKER);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          children: [
                            Text("New".tr, style: Get.textTheme.subtitle1),
                            Icon(
                              Icons.my_location,
                              color: Get.theme.colorScheme.secondary,
                              size: 20,
                            ),
                          ],
                        ),
                        elevation: 0,
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    if (controller.addresses.isEmpty) {
                      return TabBarLoadingWidget();
                    } else {
                      return TabBarWidget(
                        initialSelectedId: "0",
                        tag: 'addresses',
                        tabs: List.generate(controller.addresses.length, (index) {
                          final _address = controller.addresses.elementAt(index);
                          return ChipWidget(
                            tag: 'addresses',
                            text: _address.getDescription,
                            id: index,
                            onSelected: (id) {
                              Get.find<SettingsService>().address.value = _address;
                            },
                          );
                        }),
                      );
                    }
                  }),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.place_outlined, color: Get.theme.focusColor),
                      SizedBox(width: 15),
                      Expanded(
                        child: Obx(() {
                          return Text(controller.currentAddress?.address ?? "Loading...".tr, style: Get.textTheme.bodyText2);
                        }),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
            ),
            TextFieldWidget(
              onChanged: (input) => controller.booking.value.hint = input,
              hintText: "Is there anything else you would like us to know?".tr,
              labelText: "Hint".tr,
              iconData: Icons.description_outlined,
            ),
            Obx(() {
              return TextFieldWidget(
                onChanged: (input) => controller.booking.value.coupon.code = input,
                hintText: "COUPON01".tr,
                labelText: "Coupon Code".tr,
                errorText: controller.getValidationMessage(),
                iconData: Icons.confirmation_number_outlined,
                style: Get.textTheme.bodyText2.merge(TextStyle(color: controller.getValidationMessage() != null ? Colors.redAccent : Colors.green)),
                suffixIcon: MaterialButton(
                  onPressed: () {
                    controller.validateCoupon();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  color: Get.theme.focusColor.withOpacity(0.1),
                  child: Text("Apply".tr, style: Get.textTheme.bodyText1),
                  elevation: 0,
                ).marginSymmetric(vertical: 4),
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: Ui.getBoxDecoration(color: controller.getColor(!controller.scheduled.value)),
                child: Theme(
                  data: ThemeData(
                    toggleableActiveColor: Get.theme.primaryColor,
                  ),
                  child: RadioListTile(
                    value: false,
                    groupValue: controller.scheduled.value,
                    onChanged: (value) {
                      controller.toggleScheduled(value);
                    },
                    title: Text("As Soon as Possible".tr, style: controller.getTextTheme(!controller.scheduled.value)).paddingSymmetric(vertical: 20),
                  ),
                ),
              );
            }),
            Obx(() {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: Ui.getBoxDecoration(color: controller.getColor(controller.scheduled.value)),
                child: Theme(
                  data: ThemeData(
                    toggleableActiveColor: Get.theme.primaryColor,
                  ),
                  child: RadioListTile(
                    value: true,
                    groupValue: controller.scheduled.value,
                    onChanged: (value) {
                      controller.toggleScheduled(value);
                    },
                    title: Text("Schedule an Order".tr, style: controller.getTextTheme(controller.scheduled.value)).paddingSymmetric(vertical: 20),
                  ),
                ),
              );
            }),
            Obx(() {
              return AnimatedOpacity(
                opacity: controller.scheduled.value ? 1 : 0,
                duration: Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: controller.scheduled.value ? 20 : 0),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: controller.scheduled.value ? 20 : 0),
                  decoration: Ui.getBoxDecoration(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text("When would you like us to come to your address?".tr, style: Get.textTheme.bodyText1),
                          ),
                          SizedBox(width: 10),
                          MaterialButton(
                            elevation: 0,
                            onPressed: () {
                              controller.showMyDatePicker(context);
                            },
                            shape: StadiumBorder(),
                            color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                            child: Text("Select a Date".tr, style: Get.textTheme.subtitle1),
                          ),
                        ],
                      ),
                      Divider(thickness: 1.3, height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Text("At What's time you are free in your address?".tr, style: Get.textTheme.bodyText1),
                          ),
                          SizedBox(width: 10),
                          MaterialButton(
                            onPressed: () {
                              controller.showMyTimePicker(context);
                            },
                            shape: StadiumBorder(),
                            color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                            child: Text("Select a time".tr, style: Get.textTheme.subtitle1),
                            elevation: 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            Obx(() {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                transform: Matrix4.translationValues(0, controller.scheduled.value ? 0 : -110, 0),
                child: Obx(() {
                  return Column(
                    children: [
                      Text("Requested Service on".tr).paddingSymmetric(vertical: 20),
                      Text('${DateFormat.yMMMMEEEEd(Get.locale.toString()).format(controller.booking.value.bookingAt)}', style: Get.textTheme.headline5),
                      Text('${DateFormat('HH:mm', Get.locale.toString()).format(controller.booking.value.bookingAt)}', style: Get.textTheme.headline3),
                      SizedBox(height: 20)
                    ],
                  );
                }),
              );
            })
          ],
        ));
  }

  Widget buildBlockButtonWidget(Booking _booking) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
        ],
      ),
      child: Obx(() {
        return BlockButtonWidget(
          text: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Continue".tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline6.merge(
                    TextStyle(color: Get.theme.primaryColor),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Get.theme.primaryColor, size: 20)
            ],
          ),
          color: Get.theme.colorScheme.secondary,
          onPressed: (!(Get.find<SettingsService>().address.value?.isUnknown() ?? true))
              ? () async {
                  await Get.toNamed(Routes.BOOKING_SUMMARY);
                }
              : null,
        ).paddingOnly(right: 20, left: 20);
      }),
    );
  }
}
