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
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //이미지 업로드 공간
            Container(
              width: 500,
              height: 400,
              color: Colors.white,
              child: Image.asset('assets/image.jpg'),
            ),
            //글씨 업로드 공간
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
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
            )
          ],
        );
      },
    );
  }
}
