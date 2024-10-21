import 'package:flutter/material.dart';

class DislikeButton extends StatefulWidget {
  DislikeButton({super.key});

  @override
  DislikeButtonState createState() => DislikeButtonState();
}

class DislikeButtonState extends State<DislikeButton> {
  bool _isDisliked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
        color: Colors.black, 
      ),
      onPressed: (){
        setState(() {
          _isDisliked = !_isDisliked;
        });
      },
    );
  }
}
