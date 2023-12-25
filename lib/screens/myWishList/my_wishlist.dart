import 'package:cloud_firestore/cloud_firestore.dart';
import '../../consts/consts.dart';
import '../../services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.1,
        title:
            "My WishList".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreService.getWishList(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No WishList Yet!!"
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ListTile(
                              leading: Image.network(
                                data[index]['p_imgs'][0],
                                width: 60,
                                height: 70,
                                fit: BoxFit.fill,
                              ),
                              title: "${data[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              subtitle: "${data[index]['p_price']}"
                                  .numCurrency
                                  .text
                                  .size(15)
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                              trailing: const Icon(
                                Icons.favorite,
                                color: redColor,
                              ).onTap(() async {
                                await firestore
                                    .collection(productCollection)
                                    .doc(data[index].id)
                                    .set({
                                  'p_wishlist':
                                      FieldValue.arrayRemove([currentUser!.uid])
                                }, SetOptions(merge: true));
                              }),
                            ).box.outerShadowSm.white.make(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
