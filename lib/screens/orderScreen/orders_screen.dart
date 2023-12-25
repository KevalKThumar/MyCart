import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../services/firestore_services.dart';
import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: whiteColor),
        backgroundColor: redColor,
        title: "My Orders".text.color(whiteColor).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreService.getAllOrder(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No order Yet!!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .color(darkFontGrey)
                          .xl
                          .fontFamily(bold)
                          .make(),
                      title: data[index]['order_code']
                          .toString()
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: data[index]['total_amount']
                          .toString()
                          .numCurrency
                          .text
                          .fontFamily(bold)
                          .make(),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(() => OrdersDetails(
                                  data: data[index],
                                ));
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded)),
                    );
                  });
            }
          }),
    );
  }
}
