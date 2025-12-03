class Question {
  final String text;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });
}

final List<Question> questions = [
  Question(
    text: "Who is the owner of Flutter?",
    options: ["Nokia", "Samsung", "Google", "Apple"],
    correctOptionIndex: 2,
  ),
  Question(
    text: "Who is the owner of Iphone?",
    options: ["Microsoft", "Oppo", "Google", "Apple"],
    correctOptionIndex: 3,
  ),
  Question(
    text: "Youtube is _________ platform?",
    options: [
      "Music Sharing",
      "Video Sharing",
      "Live Streaming",
      "All of the above"
    ],
    correctOptionIndex: 1,
  ),
  Question(
    text: "Flutter uses _________ language?",
    options: ["Dart", "Java", "C++", "Python"],
    correctOptionIndex: 0,
  ),
];
