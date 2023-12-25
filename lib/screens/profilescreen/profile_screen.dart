// ignore_for_file: use_build_context_synchronously
import 'package:get/get.dart';
import '../../Controller/auth_contollre.dart';
import '../../Controller/profile_controller.dart';
import '../../common_widget/bg_widget.dart';
import '../../common_widget/details_card_incart.dart';
import '../../consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../consts/list.dart';
import '../../services/firestore_services.dart';
import '../chatScreen/masseging_screen.dart';
import '../login_screen/login_screen.dart';
import '../myWishList/my_wishlist.dart';
import '../orderScreen/orders_screen.dart';
import 'edit_profile.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgwidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreService.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                      child: Scaffold(
                        body: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.edit,
                                  color: whiteColor,
                                ),
                              ).onTap(() {
                                controller.nameController.text = data['name'];

                                Get.to(() => EditProfileScreen(
                                      data: data,
                                    ));
                              }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  data['imageUrl'] == ''
                                      ? Image.asset(
                                          imgP2,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        )
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make()
                                      : Image.network(
                                          data['imageUrl'],
                                          width: 80,
                                          fit: BoxFit.cover,
                                        )
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make(),
                                  5.widthBox,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "${data['name']}"
                                            .text
                                            .white
                                            .fontFamily(semibold)
                                            .size(20)
                                            .make(),
                                        5.heightBox,
                                        "${data['email']}".text.white.make(),
                                      ],
                                    ),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: whiteColor,
                                      ),
                                    ),
                                    onPressed: () async {
                                      await Get.put(AuthController())
                                          .signoutMethod(context);
                                      Get.offAll(() => LoginScreen());
                                      VxToast.show(context,
                                          msg: loggedout, bgColor: redColor);
                                    },
                                    child: logout.text.white
                                        .fontFamily(semibold)
                                        .make(),
                                  )
                                ],
                              ),
                            ),
                            20.heightBox,
                            FutureBuilder(
                                future: FirestoreService.getCounts(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(whiteColor),
                                    );
                                  } else {
                                    var countData = snapshot.data;
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        detailsCard(
                                          count: countData[0].toString(),
                                          title: "In your cart",
                                          width: context.screenWidth / 3.4,
                                        ),
                                        detailsCard(
                                          count: countData[1].toString(),
                                          title: "In your wishlist",
                                          width: context.screenWidth / 3.4,
                                        ),
                                        detailsCard(
                                          count: countData[2].toString(),
                                          title: "Your orders",
                                          width: context.screenWidth / 3.4,
                                        ),
                                      ],
                                    );
                                  }
                                }),
                            ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const OrdersScreen());
                                        break;
                                      case 1:
                                        Get.to(() => const WishlistScreen());
                                        break;
                                      case 2:
                                        Get.to(() => const MessagesScreen());
                                        break;
                                    }
                                  },
                                  leading: Image.asset(
                                    profileButtonsIcon[index],
                                    width: 22,
                                  ),
                                  title: profileButtonsList[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: lightGrey,
                                );
                              },
                              itemCount: profileButtonsList.length,
                            )
                                .box
                                .white
                                .margin(const EdgeInsets.all(12))
                                .roundedSM
                                .shadowSm
                                .padding(
                                    const EdgeInsets.symmetric(horizontal: 16))
                                .make()
                                .box
                                .color(redColor)
                                .make(),
                          ],
                        ),
                      ),
                    );
                  }
                })));
  }
}
