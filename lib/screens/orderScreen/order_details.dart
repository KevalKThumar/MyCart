// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intl/intl.dart' as intl;

import '../../consts/consts.dart';
import 'components/order_placed_details.dart';
import 'components/order_status.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: redColor,
          title: "Order Details"
              .text
              .color(whiteColor)
              .fontFamily(semibold)
              .make()),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  orderStatus(
                    color: redColor,
                    icon: Icons.done,
                    title: "Order Placed",
                    isDone: data['order_placed'],
                  ),
                  orderStatus(
                    color: Colors.blue,
                    icon: Icons.thumb_up,
                    title: "Order Confirmed",
                    isDone: data['order_confirmed'],
                  ),
                  orderStatus(
                    color: Colors.yellow,
                    icon: Icons.car_repair,
                    title: "On Delivery",
                    isDone: data['order_on_delivery'],
                  ),
                  orderStatus(
                    color: Colors.purple,
                    icon: Icons.done_all,
                    title: "Delivered",
                    isDone: data['order_delivered'],
                  ),
                ],
              ).box.color(whiteColor).shadowSm.make(),
              5.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                    detail1: data['order_code'],
                    title1: "Order Code",
                    detail2: data['Shipping_method'],
                    title2: "Shipping",
                  ),
                  orderPlaceDetails(
                    detail1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    title1: "Order Date",
                    detail2: data['payment_method'],
                    title2: "Payment Method",
                  ),
                  orderPlaceDetails(
                    detail1: "Unpaid",
                    title1: "Payment Status",
                    detail2: "Order Placed",
                    title2: "Delivery Status",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.color(fontGrey).make(),
                            "${data['order_by_name']}"
                                .text
                                .color(fontGrey)
                                .make(),
                            "${data['order_by_email']}"
                                .text
                                .color(fontGrey)
                                .make(),
                            "${data['order_by_address']}"
                                .text
                                .color(fontGrey)
                                .make(),
                            "${data['order_by_state']}"
                                .text
                                .color(fontGrey)
                                .make(),
                            "${data['order_by_phone']}"
                                .text
                                .color(fontGrey)
                                .make(),
                            "${data['order_by_PinCode']}"
                                .text
                                .color(fontGrey)
                                .make(),
                          ],
                        ),
                        SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.color(fontGrey).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.color(whiteColor).shadowSm.make(),
              5.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  data['orders'].length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaceDetails(
                            title1: data['orders'][index]['title'],
                            title2: data['orders'][index]['tprice'],
                            detail2: "",
                            detail1:
                                "${data['orders'][index]['qtu']} x ${data['orders'][index]['tprice']}",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height: 20,
                              width: 30,
                              color: Color(data['orders'][index]['color']),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ).box.color(whiteColor).shadowSm.make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
