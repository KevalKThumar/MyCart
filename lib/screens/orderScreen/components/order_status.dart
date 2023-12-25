import '../../../consts/consts.dart';

Widget orderStatus({icon, color, title, bool? isDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    )
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      width: 120,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          isDone!
              ? const Icon(
                  Icons.done_all,
                  color: redColor,
                )
              : Container(),
        ],
      ),
    ),
  );
}
