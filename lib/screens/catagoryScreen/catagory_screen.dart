import '../../Controller/productController.dart';
import '../../common_widget/bg_widget.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import 'catagory_details.dart';

class Catagoryscreen extends StatelessWidget {
  const Catagoryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgwidget(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: categories.text.fontFamily(bold).size(20).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 0,
            mainAxisExtent: 200,
          ),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  catagoriesimages[index],
                  width: 200,
                  height: 115,
                  fit: BoxFit.cover,
                ),
                10.heightBox,
                catagoriesList[index]
                    .text
                    .size(5)
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .make(),
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
                controller.getSubcategories(catagoriesList[index]);

                Get.to(() => CatagoryDetails(
                      title: catagoriesList[index],
                    ));
              },
            );
          },
        ),
      ),
    ));
  }
}
