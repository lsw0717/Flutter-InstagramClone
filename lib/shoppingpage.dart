import 'package:flutter/material.dart';
import './style.dart' as style;

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
                constraints: BoxConstraints(maxWidth: 600, maxHeight: 600),
                width: double.infinity,
                //height: double.infinity,
                child: Image.network(
                    'https://pbs.twimg.com/media/FEVEgvLakAAj3i3?format=jpg&name=4096x4096')),
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
                      Text(
                        '100',
                        style: style.text1,
                      )
                    ],
                  ),
                  Text('글쓴이'),
                  Text('글내용')
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
