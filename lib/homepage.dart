import 'package:flutter/material.dart';
import './style.dart' as style;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, i) {
        return Column(
          children: [
            //이미지 업로드 공간
            Container(
                color: Colors.blueAccent,
                constraints: BoxConstraints(maxWidth: 600, maxHeight: 300),
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                    'https://pbs.twimg.com/media/FEVEgvLakAAj3i3?format=jpg&name=4096x4096')),
            //글씨 업로드 공간
            Container(
              color: Colors.amber,
              //글쓰는 부분(크기)(공간)에 제한을 줌.(큰 디스플레이에서도 UI를 유지하도록)
              constraints: BoxConstraints(maxWidth: 600),
              width: double.infinity,
              padding: EdgeInsets.all(20),
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
                      Text(
                        '100',
                        style: style.text1,
                      ),
                    ],
                  ),
                  Text('lsw_717'),
                  Text('1월 13일')
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
