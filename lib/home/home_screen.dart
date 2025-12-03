import 'package:flutter/material.dart';
import 'package:quiz_app/model/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;


  void _answerQuestion(int selectedIndex) {
    setState(() {
      _selectedOptionIndex = selectedIndex;
    });
  }

  void _nextQuestion() {
    if (_selectedOptionIndex == null) {
      return;
    }

    if (_selectedOptionIndex != null) {
      if (_selectedOptionIndex ==
          questions[_currentQuestionIndex].correctOptionIndex) {
        _score++;
      }
    }

    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    bool isPassed = _score > 2;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Column(
          children: [
            Icon(
              isPassed ? Icons.check_circle : Icons.cancel,
              color: isPassed ? Colors.green : Colors.red,
              size: 60,
            ),
            const SizedBox(height: 10),
            Text(
              '${isPassed ? "Passed" : "Failed"} | Score is $_score',
              style: TextStyle(
                color: isPassed ? Colors.green : Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _currentQuestionIndex = 0;
              _score = 0;
              _selectedOptionIndex = null;
            });
            _pageController.jumpToPage(0);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Restart',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Simple Quiz App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Question ${_currentQuestionIndex + 1} / ${questions.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  question.text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: -25,
                            left: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                          ),
                          const Positioned(
                            left: -20,
                            top: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 20,
                            ),
                          ),
                          const Positioned(
                            right: -20,
                            top: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ...List.generate(question.options.length, (optIndex) {
                        final isSelected = _selectedOptionIndex == optIndex;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Center(
                            child: SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedOptionIndex = optIndex;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? Colors.orange
                                      : Colors.grey[300],
                                  foregroundColor: Colors.black,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  question.options[optIndex],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  _currentQuestionIndex == questions.length - 1
                      ? 'Submit'
                      : 'Next',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
