import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';
import 'Home_controller.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var pinCodeController = TextEditingController();
  var phoneController = TextEditingController();
  var product = [];
  var india = "+91";
  var placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDEtails();

    await firestore.collection(oredersCollection).doc().set({
      'order_code': "1234567890",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().userName,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text.capitalizeFirst,
      'order_by_city': cityController.text.capitalizeFirst,
      'order_by_phone': phoneController.text,
      'order_by_PinCode': pinCodeController.text,
      'Shipping_method': "Home Delivery",
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'order_placed': true,
      'total_amount': totalAmount,
      'payment_method': "cash on delivery",
      'orders': FieldValue.arrayUnion(product),
    });
    placingOrder(false);
  }

  getProductDEtails() {
    product.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      product.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qtu': productSnapshot[i]['qtu'],
        'vender_id': productSnapshot[i]['vender_id'],
        'tprice': productSnapshot[i]['tprice'],
        'title': productSnapshot[i]['title'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
