import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:m_cart/screens/homescreen/search_scarren.dart';

import '../../Controller/Home_controller.dart';
import '../../common_widget/future_button.dart';
import '../../common_widget/home_button.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../services/firestore_services.dart';
import '../catagoryScreen/item_detail.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                focusNode: controller.searchFocusNode,
                enableSuggestions: true,
                onFieldSubmitted: (value) {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(
                      () => SearchScarren(
                        title: controller.searchController.text,
                      ),
                    );
                  }
                },      
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(
                    () {
                      if (controller
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(
                          () => SearchScarren(
                            title: controller.searchController.text,
                          ),
                        );
                      }
                    },
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                ),
              ),
            ),
            5.heightBox,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      height: 150,
                      itemCount: slidersList.length,
                      enlargeCenterPage: true,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                          height: 150,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homebutton(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todayDeal : flashsale,
                        ),
                      ),
                    ),
                    5.heightBox,
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      itemCount: secondslidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondslidersList[index],
                          fit: BoxFit.fill,
                          height: 150,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                              const EdgeInsets.symmetric(horizontal: 8),
                            )
                            .make();
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homebutton(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 3.5,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          title: index == 0
                              ? topCategories
                              : index == 1
                                  ? brand
                                  : topSellers,
                        ),
                      ),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                      icon: featuredImages1[index],
                                      title: featuredTitle1[index],
                                    ),
                                    10.heightBox,
                                    featuredButton(
                                      icon: featuredImages2[index],
                                      title: featuredTitle2[index],
                                    ),
                                  ],
                                )),
                      ),
                    ),
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          5.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreService.getAllFeaturedProduct(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    ),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Product"
                                      .text
                                      .white
                                      .make();
                                } else {
                                  var featuredProductdata = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featuredProductdata.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                              featuredProductdata[index]
                                                  ['p_imgs'][0],
                                              width: 150,
                                              height: 160,
                                              fit: BoxFit.contain),
                                          "${featuredProductdata[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          "${featuredProductdata[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .size(15)
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .make()
                                        ],
                                      )
                                          .box
                                          .white
                                          .margin(
                                            const EdgeInsets.symmetric(
                                                horizontal: 4),
                                          )
                                          .roundedSM
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(
                                        () {
                                          Get.to(() => Itemdetail(
                                                title:
                                                    "${featuredProductdata[index]['p_name']}",
                                                data:
                                                    featuredProductdata[index],
                                              ));
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      itemCount: secondslidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondslidersList[index],
                          fit: BoxFit.fill,
                          height: 150,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                              const EdgeInsets.symmetric(horizontal: 8),
                            )
                            .make();
                      },
                    ),
                    10.heightBox,
                    StreamBuilder(
                        stream: FirestoreService.getAllProduct(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              ),
                            );
                          } else {
                            var data = snapshot.data!.docs;
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 300,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.contain,
                                    ),
                                    2.heightBox,
                                    "${data[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .size(15)
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .make()
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(
                                      const EdgeInsets.symmetric(horizontal: 4),
                                    )
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(
                                  () {
                                    Get.to(() => Itemdetail(
                                          title: "${data[index]['p_name']}",
                                          data: data[index],
                                        ));
                                  },
                                );
                              },
                            );
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
