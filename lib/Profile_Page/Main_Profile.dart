import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 파일 사용을 위한 패키지
import 'package:get/get.dart';
import '../Camera_Page/Camera_Page.dart'; // CameraPage 파일 임포트
import '../User_Registration_Page/User_Registration.dart'; // UserRegistrationPage 파일 임포트
import 'Change_Profile.dart'; // Change_ProfilePage 파일 임포트
import '../Controllers/Profile/Main_Profile_Controller.dart'; // MainProfileController 임포트

class MainProfilePage extends StatelessWidget {
  const MainProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainProfileController>(
      init: MainProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
            elevation: 0, // 그림자 제거
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/Pencil.svg', // SVG 파일 경로
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  controller.toggleChange();
                },
              ),
              const SizedBox(width: 10), // 약간의 간격 추가
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // 텍스트를 위쪽에 배치
              children: [
                const SizedBox(height: 5), // 원하는 높이로 조절 가능
                const AdjustableText(
                  text: 'E.T.',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                const SizedBox(height: 14),
                const AdjustableText(
                  text: '아이트랙킹할 프로필을 추가해주세요.',
                  fontSize: 20,
                  color: Colors.black,
                ),
                Obx(() {
                  //이미지 표시 여부에 따라 이미지 위젯을 조건부 렌더링
                  if (controller.isImageVisible.value) {
                    return Transform.translate(
                      offset: const Offset(0, 57), // 텍스트 아래로 이동
                      child: SizedBox(
                        width: 300, // 원하는 너비로 조절
                        height: 300, // 원하는 높이로 조절
                        child: Image.asset(
                          'assets/Main_Profile.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Wrap(
                        spacing: 20.0, // 자식 요소 간의 수평 간격
                        runSpacing: 20.0, // 자식 요소 간의 수직 간격
                        children: List.generate(controller.chk.value, (index) {
                          return GestureDetector(
                            onTap: () => Get.to(() => const UserRegistrationPage()),
                            child: Container(
                              width: 150,
                              height: 170,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 130,
                                    height: 129,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      image: DecorationImage(
                                        image: AssetImage('assets/character${index + 1}.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: controller.isChange.value
                                        ? IconButton(
                                      onPressed: () {
                                        Get.to(() => const ChangeProfilePage());
                                      },
                                      icon: const Icon(Icons.edit, size: 30),
                                      color: Colors.white,
                                    )
                                        : Container(), // isChange가 false일 때 빈 컨테이너를 표시
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("캐릭터${index + 1}", textAlign: TextAlign.center)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }
                }),
                const Spacer(), // 빈 공간을 채워 버튼을 아래로 배치
                Padding(
                  padding: const EdgeInsets.all(16.0), // 버튼 주위에 여백 추가
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCAF4FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: () async {
                        final result = await Get.to(() => CameraPage(onProfileAdded: controller.addProfile));
                      },
                      child: const Text(
                        '프로필 추가하기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AdjustableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;

  const AdjustableText({
    required this.text,
    required this.fontSize,
    this.fontWeight,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      ),
    );
  }
}
