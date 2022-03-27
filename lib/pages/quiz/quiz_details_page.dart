import 'package:flutter/material.dart';
import 'quiz_data.dart';


class QuizDetailsPage extends StatefulWidget {
  final int quizIndex;

  const QuizDetailsPage({Key key, var this.quizIndex}) : super(key: key);

  @override
  State<QuizDetailsPage> createState() => _QuizDetailsPageState();
}

class _QuizDetailsPageState extends State<QuizDetailsPage> {
  int _quizIndex;

  @override
  void initState() {
    super.initState();
    _quizIndex = widget.quizIndex;
  }

  @override
  Widget build(BuildContext context) {
    var quizItem = QuizData.list[_quizIndex];

    return Scaffold(
      appBar: AppBar(title: Text('${quizItem.word1} ${quizItem.word2} บาท')),
      body: Stack(
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: 1.7,
                child: Image.network(
                  quizItem.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  quizItem.word2,
                ),
              ),
            ],
          ),
          if (_quizIndex > 0)
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => _handleClickButton(-1),
                  label: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('ก่อนหน้า'),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (_quizIndex < QuizData.list.length - 1)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () => _handleClickButton(1),
                    label: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('ถัดไป'),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('เมนู ${_quizIndex + 1}/${QuizData.list.length}'),
            ),
          ),
        ],
      ),
    );
  }

  // ปรับโค้ดใหม่ ไม่เหมือนที่สอนในคาบเรียน
  void _handleClickButton(int value) {
    final newIndex = _quizIndex + value;
    if (newIndex < 0 || newIndex > QuizData.list.length - 1) return;

    setState(() {
      _quizIndex += value;
    });
  }
}