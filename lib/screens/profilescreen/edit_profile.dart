// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import '../../Controller/profile_controller.dart';
import '../../common_widget/bg_widget.dart';
import '../../common_widget/button.dart';
import '../../common_widget/custom_textfild.dart';
import '../../consts/consts.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgwidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgP2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.color(redColor).clip(Clip.antiAlias).make()
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      )
                        .box
                        .roundedFull
                        .color(redColor)
                        .clip(Clip.antiAlias)
                        .make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      )
                        .box
                        .roundedFull
                        .color(redColor)
                        .clip(Clip.antiAlias)
                        .make(),
            10.heightBox,
            ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textcolor: whiteColor,
                title: "change".toUpperCase()),
            const Divider(),
            10.heightBox,
            customTextFild(
              hint: namehint,
              ispass: false,
              title: name,
              controller: controller.nameController,
            ),
            10.heightBox,
            customTextFild(
              hint: passwordhint,
              ispass: true,
              title: oldPassword,
              controller: controller.oldpassController,
            ),
            10.heightBox,
            customTextFild(
              hint: passwordhint,
              ispass: true,
              title: newPassword,
              controller: controller.newpassController,
            ),
            20.heightBox,
            controller.isLoding.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isLoding(true);

                          //if user dosen't change image Url
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uplodeProfileImage();
                          } else {
                            controller.profileImgLink = data['imageUrl'];
                          }

                          //if old pass is match with database pass then only change in pass

                          if (data['password'] ==
                              controller.oldpassController.text) {
                            await controller.changeAuthpassword(
                              email: data['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text,
                            );
                            await controller.updateProfile(
                                imgUrl: controller.profileImgLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                            VxToast.show(context,
                                msg: "Updated",
                                bgColor: redColor,
                                textColor: whiteColor,
                                position: VxToastPosition.center);
                            controller.isLoding(false);
                          } else {
                            VxToast.show(context,
                                msg: "Wrong Old pass!!",
                                bgColor: redColor,
                                textColor: whiteColor,
                                position: VxToastPosition.center);
                            controller.isLoding(false);
                          }
                        },
                        textcolor: whiteColor,
                        title: "save".toUpperCase()),
                  ),
          ],
        )
            .box
            .white
            .shadowSm
            .roundedSM
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}
