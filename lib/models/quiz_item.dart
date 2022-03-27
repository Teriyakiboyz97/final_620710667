class quizItem {
  final String image;
  final String word1;
  final String word2;
  final String word3;
  final String word4;
 quizItem({
    var this.image,
    var this.word1,
    var this.word2,
    var this.word3,
    var this.word4,
  });

  factory quizItem.fromJson(Map<String, dynamic> json) {
    return quizItem(
      image: json['image'],
      word1: json['word1'],
      word2: json['word2'],
      word3: json['word3'],
      word4: json['word4'],
    );
  }

  quizItem.fromJson2(Map<String, dynamic> json, this.word4)
      : image = json['image'],
        word1 = json['word1'],
        word2 = json['word2'],
        word3 = json['word3'];


  @override
  String toString() {
    return '$image: $word1 ราคา $word2 บาท';
  }
}