import '../consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).align(TextAlign.center).size(10).make(),
    ],
  )
      .box
      .white
      .height(70)
      .roundedSM
      .width(width)
      .padding(const EdgeInsets.all(4))
      .make();
}
