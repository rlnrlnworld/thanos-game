import 'package:flutter/material.dart';
import 'package:thanos_game/dislike_button.dart';
import 'package:thanos_game/like_button.dart';

void main() {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3356710387.
  runApp(ThanosApp());
}

class ThanosApp extends StatefulWidget {
  @override
  State<ThanosApp> createState() => _ThanosAppState();
}

class _ThanosAppState extends State<ThanosApp> {
  bool _showThanos = false;
  bool _isClickable = true;
  bool _countDown_3 = false;
  bool _countDown_2 = false;
  bool _countDown_1 = false;
  bool _alert = false;

  Map<String, bool> _cardVisibility = {};

  // 참가자 이름 정보 변수
  List<String> _names = [
    "김지연",
    "신하경",
    "박영서",
    "김서현",
    "김정섭",
    "이성찬",
    "민희원",
    "장민서",
    "전예린",
    "진선명",
    "이창윤",
    "정은정",
    "송정민",
    "이가현",
    "이예진",
    "김현태",
    "이승현",
    "김주원",
    "정연우",
    "김민성",
    "정다진",
    "이지연",
    "배기옥",
    "신찬희"
  ];

  @override
  void initState() {
    super.initState();
    // 각 카드가 처음에 보여지도록 초기화
    for (var name in _names) {
      _cardVisibility[name] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Center(
              child: Text(
                'Thanos Game',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView(
                  // GridView 모양 설정
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 세로 줄 개수 설정
                    childAspectRatio: 1.5, // 가로와 세로 비율 설정
                  ),
                  children: [
                    // 이름과 삭제 버튼 추가
                    for (var name in _names) addCard(name),
                    addExtractCard(_controller)
                  ],
                ),
              ),
              if (_showThanos)
                Center(
                  child: Image.asset(
                    "assets/thanosSnap.gif",
                    width: 100,
                  ),
                ),
              if (_countDown_3) makeCountDown(3),
              if (_countDown_2) makeCountDown(2),
              if (_countDown_1) makeCountDown(1),
              if (_alert) makeAlert()
            ],
          ),
          floatingActionButton: floatingThanosButton(),
        ),
        theme: ThemeData(fontFamily: 'Pretendard'));
  }

  Center makeAlert() {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Icon(
                  //   Icons.not_interested,
                  //   color: Colors.red,
                  // ),
                  Container(
                    child: Image.asset("assets/alertThanos.png", width: 80),
                  ),
                  Text("인원이 1명일 땐,\n실행할 수 없어요!", textAlign: TextAlign.center, style: TextStyle(fontSize: 20,))
                ],
              ),
            )));
  }

  Center makeCountDown(num) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Image.asset(
          "assets/number_$num.png",
          width: 80,
        )),
      ),
    );
  }

  Card addExtractCard(TextEditingController _controller) {
    return Card(
        child: AbsorbPointer(
            absorbing: !_isClickable,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: "이름 입력",
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              setState(() {
                                // 새 이름 추가 및 초기화
                                _names.add(_controller.text);
                                _cardVisibility[_controller.text] =
                                    false; // 처음에는 투명하게 설정
                                _controller.clear();
                              });

                              // 애니메이션을 위해 짧은 시간 뒤 가시성을 true로 변경
                              Future.delayed(Duration(milliseconds: 100), () {
                                setState(() {
                                  _cardVisibility[_names.last] =
                                      true; // 새 카드 가시성을 true로 변경
                                });
                              });
                            }
                          },
                        )
                      ],
                    )))));
  }

  FloatingActionButton floatingThanosButton() {
    return FloatingActionButton(
      child: Image.asset("assets/thanos.png", width: 100),
      onPressed: () async {
        if (!_isClickable) {
          return;
        }
        if (_names.length > 1) {
          setState(() {
            _isClickable = false;
            _countDown_3 = true;
          });
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            _countDown_3 = false;
            _countDown_2 = true;
          });
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            _countDown_2 = false;
            _countDown_1 = true;
          });
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            _countDown_1 = false;
            _showThanos = true;
          });
          await Future.delayed(Duration(milliseconds: 2000));
          setState(() {
            _showThanos = false;
          });

          setState(() {
            final cnt = (_names.length / 2).toInt();
            List<String> removedNames = _names.take(cnt).toList();

            for (var name in removedNames) {
              _cardVisibility[name] = false;
            }
          });

          await Future.delayed(Duration(milliseconds: 500));
          setState(() {
            _names = _names
                .where((name) => _cardVisibility[name]!)
                .toList(); // 이미 사라진 카드는 남기지 않음
            _isClickable = true;
          });
        } else {
          setState(() {
            _alert = true;
          });
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            _alert = false;
          });
        }
      },
    );
  }

  Card addCard(String name) {
    return Card(
        child: AbsorbPointer(
            absorbing: !_isClickable,
            child: AnimatedOpacity(
              opacity: _cardVisibility[name]! ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              onEnd: () {
                if (!_cardVisibility[name]!)
                  setState(() {
                    _names.remove(name);
                    _cardVisibility.remove(name);
                  });
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(name),
                    deleteButton(name),
                  ],
                ),
              ),
            )));
  }

  IconButton deleteButton(String name) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.grey,
      ),
      onPressed: () {
        if (_names.length > 1) {
          // 카드의 visibility를 false로 설정해서 투명하게 만듭니다.
          setState(() {
            _cardVisibility[name] = false;
          });
        }
      },
    );
  }
}
