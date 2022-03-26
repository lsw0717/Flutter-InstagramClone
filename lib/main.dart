import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; //toastmessage를 사용하기 위한 패키지
import 'package:http/http.dart' as http; //uri로 서버데이터 get을 위한 패키지
import 'dart:convert'; //JSON -> 일반자료형 변환을 도와주는 함수 모음집 패키지
import './style.dart' as style;
import './homepage.dart' as homepage;
import './shoppingpage.dart' as shoppingpage;

void main() {
  runApp(MaterialApp(
      theme: style.theme, //style.dart의 theme변수 가져옴
      debugShowCheckedModeBanner: false,
      home: MyApp() //멀티 페이지 이동을 할 때, home 대신 initialRoute를 사용하자.

      ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int tab = 0;
  var data = []; //서버 데이터 저장

//서버데이터 가져오기
  getData() async {
    //GET요청을 날려주고 변수에 서버에서 가져온 데이터를 남긴다.(JSON자료형)
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));

    //statuscolde == 200 == 성공 // 5xx 또는 6xx는 실패
    if (result.statusCode == 200) {
      //JSON 디코드 --> [{}]
      var result2 = jsonDecode((result.body));
      setState(() {
        data = result2;
        print(data);
      });
    } else {
      toastMessage('fail get server data');
      throw Exception('실패함 ㅅㄱ');
    }
  }

  //부모의 state인 data를 자식이 수정할 수 있게 하기위한 함수.
  addData(a) {
    setState(() {
      data.add(a);
    });
  }

  @override
  // 앱 시작시 최초 1회 실행
  void initState() {
    super.initState();
    // 앱 시작시 최초 1회 getData() 실행
    getData();
  }

//토스트 메시지
  void toastMessage(String a) {
    Fluttertoast.showToast(
        webPosition: "center",
        msg: a,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        fontSize: 20.0);
  }

//스낵바
  void snackBar(String a) {
    //스낵바 구현, scaffoldmessenger(모든 scaffold의 context를 가짐) 사용해서 구현(페이지 이동이 있어도 스낵바 유지 가능).
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        a,
        style: style.text1,
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          if (tab != 2) {
            setState(() {
              tab++;
            });
          } else if (tab == 2) {
            setState(() {
              tab = 0;
            });
          }
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Instagram',
        ),
        actions: [
          //navigator을 이용한 화면전환을 위한 버튼
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HiddenPage()));
              },
              icon: Icon(Icons.star_outline)),
          //toast메시지 구현 확인을 위한 버튼
          IconButton(
              onPressed: () {
                return toastMessage('clicked favorite');
              },
              icon: Icon(Icons.favorite_outline)),
          //스낵바 구현 확인을 위한 버튼
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              return snackBar('post is added');
            },
          ),
        ],
      ),
      body: [
        homepage.HomePage(),
        shoppingpage.ShoppingPage(),
        SettingPage(data: data, addData: addData)
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
              activeIcon: Icon(Icons.shopping_bag)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: '세팅',
              activeIcon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}

//세팅 페이지
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, this.data, this.addData}) : super(key: key);
  final data;
  final addData; //부모 클래스의 data state를 자식 클래스에서 변경하기 위해, 부모클래스에 data state를 수정하는 함수를 선언 후, 자식 클래스에 등록하여 함수를 이용해 부모 클래스의 state를 변경.

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var scroll = ScrollController(); //스크롤바의 위치를 감시하기위한 변수
  var scrollflag = 0; //스크롤 flag
  //데이터 추가 요청 함수.
  getMore() async {
    //GET요청을 날려주고 변수에 서버에서 가져온 데이터를 남긴다.(JSON자료형)
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/more1.json'));

    //statuscolde == 200 == 성공 // 5xx 또는 6xx는 실패
    if (result.statusCode == 200) {
      //JSON 디코드 --> [{}]
      var result2 = jsonDecode((result.body));
      //widget. 을 붙혀야 윗 클래스에 등록했던 변수들을 아랫 클래스에서 사용할 수 있다.
      widget.addData(result2);
    } else {
      throw Exception('실패함 ㅅㄱ');
    }
  }

  @override
  //settingpage가 처음 실행할 때 실행.
  void initState() {
    super.initState();
    //스크롤바를 감시하는 기능을 장착. listener을 장착.스크롤바의 위치가 변할때 마다 코드를 보내줌.
    scroll.addListener(() {
      //스크롤의 현재위치 == 현재 스크롤을 최대로 움직일 수 있는 위치 ==> 스크롤을 끝까지 내림.
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        //다음 함수 실행에 딜레이를 주는 함수.3초후 실행
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            scrollflag = 0; //scroll flag를 0으로 초기화한다.
          });
        });
        if (scrollflag == 0) {
          //만약 scroll flag가 0일때 true.
          getMore(); //추가 서버 데이터 get 하기.
          setState(() {
            scrollflag = 1; //scroll flag  = 1 로 set.
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //서버 data가 empty가 아닐 때
    if (widget.data.isNotEmpty) {
      return ListView.builder(
        controller: scroll, //스크롤바 위치를 감시하기위한 파라미터
        itemCount: widget.data.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              Container(
                  constraints: BoxConstraints(maxWidth: 600, maxHeight: 600),
                  width: double.infinity,
                  //이미지 데이터 삽입 부분
                  child: Image.network(widget.data[i]['image'])),
              //글쓰는 부분
              Container(
                //글쓰는 부분(크기)(공간)에 제한을 줌.(큰 디스플레이에서도 UI를 유지하도록)
                constraints: BoxConstraints(maxWidth: 600),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '좋아요',
                          style: style.text1,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //${변수}  =>  변수를 문자열로 출력함. ex) Text('하이${data[i]['likes']}하이')
                        Text(
                          '${widget.data[i]['likes']}',
                          style: style.text1,
                        )
                      ],
                    ),
                    //유저 이름 데이터 삽입
                    Text(widget.data[i]['user']),
                    //글 내용 데이터 삽입
                    Text(widget.data[i]['content'])
                  ],
                ),
              )
            ],
          );
        },
      );
    }
    //서버 data가 empty일 때
    else {
      return CircularProgressIndicator(); //로딩 이미지 모션(움짤)
    }
  }
}

//navigator로 페이지 전환을 위한 라우터(페이지)// 굳이 pop()을 위한 버튼 구현 안해도 됨(자동으로 구현이 되어 있음).
class HiddenPage extends StatelessWidget {
  const HiddenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HiddenPage',
          style: style.text1,
        ),
      ),
      //pop을 위한 버튼 구현 코드(하지만 자동으로 구현이 되기 때문에 굳이 따로 구현 안해도 됨)
      // body: Center(
      //   child: ElevatedButton(
      //     child: Text('back'),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
    );
  }
}
