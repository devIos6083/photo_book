/*
- Homescreen 선언하기
- _Homescreenstate선언하기
timer / pagecontroller 불러오기
initState -> timer는 2초
currentPage -> 현재 페이지 정수형으로
nextPage-> 현재 + 1
만약 4넘어가면 0
controller 동작하기

dispose -> 만약 빈게 아니라면 timer cancel 하지마
-> controller 버려

- 위젯 불러주기
scaffold -> Page view -> controller -> children -> map image -> fit -> list로
 */

import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      Duration(seconds: 2),
      (timer) {
        int currentPage = controller.page!.toInt();
        int nextPage = currentPage + 1;

        if (nextPage >= 4) {
          nextPage = 0;
        }
        controller.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  void disPose() {
    if (timer != null) {
      timer!.cancel();
    }

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [0, 1, 2, 3]
            .map(
              (e) => Image.asset(
                "assets/img/img$e.png",
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
