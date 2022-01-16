import 'package:flutter/material.dart';
import './style.dart' as style;
import './homepage.dart' as homepage;
import './shoppingpage.dart' as shoppingpage;

void main() {
  runApp(MaterialApp(
    theme: style.theme, //style.dart의 theme변수 가져옴
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Instagram',
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () {},
            )
          ],
        ),
        body: [
          homepage.HomePage(),
          shoppingpage.ShoppingPage()
        ][tab], //왼쪽 리스트에서 오른쪽 리스트(tab)번째 인덱스 값을 리턴.
        //바텀 탭 바
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: tab, //현재 페이지의 인덱스를 state tab으로 설정.
          onTap: (i) {
            //i == 누른 버튼의 인덱스. 0부터 시작.
            setState(() {
              tab = i;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '홈',
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: '샵',
                activeIcon: Icon(Icons.shopping_bag))
          ],
        ));
  }
}
