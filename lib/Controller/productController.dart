// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../consts/colors.dart';
import '../consts/consts.dart';
import '../model/categories_model.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;
  var subcat = [];
  getSubcategories(title) async {
    subcat.clear();
    var data =
        await rootBundle.loadString("lib/services/categories_model.json");
    var decoded = categoriesModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcatagory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totleQuantity, context) {
    if (quantity.value < totleQuantity) {
      quantity.value++;
    } else {
      VxToast.show(context,
          msg: "Out Of Stock".toUpperCase(),
          bgColor: redColor,
          position: VxToastPosition.center);
    }
  }

  decreaseQuantity(context) {
    if (quantity.value > 0) {
      quantity.value--;
    } else {
      VxToast.show(context,
          msg: "Quantity is not less\nthen zero".toUpperCase(),
          bgColor: redColor,
          position: VxToastPosition.center);
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, sellername, color, qtu, tprice, context, venderID}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'vender_id': venderID,
      'qtu': qtu,
      'tprice': tprice,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  addTOWishlist(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context,
        msg: "Add to Wishlist",
        bgColor: redColor,
        textColor: whiteColor,
        position: VxToastPosition.center);
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context,
        msg: "Remove to Wishlist",
        bgColor: redColor,
        textColor: whiteColor,
        position: VxToastPosition.center);
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
