import '../../../consts/consts.dart';

Widget orderPlaceDetails({data, title1, title2, detail1, detail2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$detail1".text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              "$title2".text.color(darkFontGrey).fontFamily(semibold).make(),
              "$detail2".text.color(fontGrey).make(),
            ],
          ),
        ),
      ],
    ),
  );
}
