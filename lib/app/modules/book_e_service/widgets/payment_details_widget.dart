/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../bookings/widgets/booking_row_widget.dart';

class PaymentDetailsWidget extends StatelessWidget {
  const PaymentDetailsWidget({
    Key key,
    @required Booking booking,
  })  : _booking = booking,
        super(key: key);

  final Booking _booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          BookingRowWidget(
            description: _booking.eService.name,
            child: Align(
              alignment: Alignment.centerRight,
              child: Ui.getPrice(_booking.eService.getPrice, style: Get.textTheme.subtitle2),
            ),
            hasDivider: true,
          ),
          Column(
            children: List.generate(_booking.options.length, (index) {
              var _option = _booking.options.elementAt(index);
              return BookingRowWidget(
                  description: _option.name,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Ui.getPrice(_option.price, style: Get.textTheme.bodyText1),
                  ),
                  hasDivider: (_booking.options.length - 1) == index);
            }),
          ),
          if (_booking.eService.priceUnit == 'fixed')
            BookingRowWidget(
                description: "Quantity".tr,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "x" + _booking.quantity.toString() + " " + _booking.eService.quantityUnit.tr,
                    style: Get.textTheme.bodyText2,
                  ),
                ),
                hasDivider: true),
          Column(
            children: List.generate(_booking.taxes.length, (index) {
              var _tax = _booking.taxes.elementAt(index);
              return BookingRowWidget(
                  description: _tax.name,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _tax.type == 'percent'
                        ? Text(_tax.value.toString() + '%', style: Get.textTheme.bodyText1)
                        : Ui.getPrice(
                            _tax.value,
                            style: Get.textTheme.bodyText1,
                          ),
                  ),
                  hasDivider: (_booking.taxes.length - 1) == index);
            }),
          ),
          BookingRowWidget(
            description: "Tax Amount".tr,
            child: Align(
              alignment: Alignment.centerRight,
              child: Ui.getPrice(_booking.getTaxesValue(), style: Get.textTheme.subtitle2),
            ),
            hasDivider: false,
          ),
          BookingRowWidget(
              description: "Subtotal".tr,
              child: Align(
                alignment: Alignment.centerRight,
                child: Ui.getPrice(_booking.getSubtotal(), style: Get.textTheme.subtitle2),
              ),
              hasDivider: true),
          if ((_booking.coupon?.discount ?? 0) > 0)
            BookingRowWidget(
                description: "Coupon".tr,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: [
                      Text(' - ', style: Get.textTheme.bodyText1),
                      Ui.getPrice(_booking.coupon.discount, style: Get.textTheme.bodyText1, unit: _booking.coupon.discountType == 'percent' ? "%" : null),
                    ],
                  ),
                ),
                hasDivider: true),
          BookingRowWidget(
            description: "Total Amount".tr,
            child: Align(
              alignment: Alignment.centerRight,
              child: Ui.getPrice(_booking.getTotal(), style: Get.textTheme.headline6),
            ),
          ),
        ],
      ),
    );
  }
}
