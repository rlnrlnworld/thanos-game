import 'package:flutter/material.dart';

// 좋아요 버튼 클래스
class LikeButton extends StatefulWidget {
  LikeButton({super.key});

  @override
  LikeButtonState createState() => LikeButtonState();
}

// 좋아요 상태를 관리하는 클래스
class LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
        color: Colors.black,
      ),
      onPressed: () {
        // setState를 통해 상태 변하면 알림
        setState(() {
          _isLiked = !_isLiked; // 좋아요 상태 업데이트
        });
      },
    );
  }
}
