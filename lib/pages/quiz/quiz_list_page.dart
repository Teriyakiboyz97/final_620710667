import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_620710667/models/api_result.dart';
import 'package:final_620710667/models/quiz_item.dart';
import 'dart:convert';
import 'quiz_data.dart';
import 'quiz_details_page.dart';

class QuizListPage extends StatefulWidget {
  const QuizListPage({Key key}) : super(key: key);

  @override
  State<QuizListPage> createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: QuizData.list.length,
            itemBuilder: (context, index) => _buildListItem(context, index),
          ),
          if (_isLoading)
            const Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  _loadQuiz() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/quizzes');
    var response = await http.get(url, headers: {'id':'620710667'});
    setState(() {
      _isLoading = false;
    });

    var json = jsonDecode(response.body);
    var apiResult = ApiResult.fromJson(json);



    setState(() {
      QuizData.list = apiResult.data
          .map<quizItem>((item) => quizItem.fromJson(item))
          .toList();

    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    var foodItem = QuizData.list[index];

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: () {
          _handleClickItem(index);
        },
        child: Row(
          children: <Widget>[
            Image.network(
              foodItem.image,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          foodItem.word1,
                        ),
                        Text(
                          '${foodItem.word2.toString()} บาท',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleClickItem(int quizIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizDetailsPage(quizIndex: quizIndex)),
    );
  }
}