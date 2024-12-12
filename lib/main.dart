import 'package:flutter/material.dart';
//Name : Joseph Nouhra.
//id : 52131020.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CourseRegistration(),
    );
  }
}

class Course {
  String name;
  int credits;
  bool selected;

  Course(this.name, this.credits, {this.selected = false});
}

class CourseRegistration extends StatefulWidget {
  @override
  State<CourseRegistration> createState() => _CourseRegistrationState();
}

class _CourseRegistrationState extends State<CourseRegistration> {
  final List<Course> courses = [
    Course("CSCI200", 3),
    Course("CSCI250", 4),
    Course("CSCI250Lab", 1),
    Course("CSCI300", 5),
    Course("CSCI350", 3),
  ];

  String resultMessage = "";
  Color messageColor = Colors.green;

  void calculateCredit() {
    int totalCredits = 0;

    for (var course in courses) {
      if (course.selected) {
        totalCredits += course.credits;
      }
    }

    if (totalCredits > 10) {
      resultMessage =
      "You cannot register for all these courses. The maximum number of credits you can take in a semester is 10, but your selected courses total $totalCredits credits.";
      messageColor = Colors.red;
    } else if (totalCredits == 10) {
      resultMessage = "You can register for these courses.";
      messageColor = Colors.green;
    } else {
      int remainingCredits = 10 - totalCredits;
      resultMessage =
      "You can register for these courses and still have the option to register for one more course worth $remainingCredits credits.";
      messageColor = Colors.redAccent;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Choose the courses you wish to register for:",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              var course = courses[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: course.selected,
                        onChanged: (value) {
                          setState(() {
                            course.selected = value ?? false;
                          });
                        },
                      ),
                      Text(
                        "${course.name} (${course.credits} credits)",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // Replacing ElevatedButton with IconButton
          Center(
            child: IconButton(
              onPressed: calculateCredit,
              icon: const Icon(Icons.shopping_cart, size: 40, color: Colors.blue),
              tooltip: 'Buy courses',
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              resultMessage,
              style: TextStyle(fontSize: 18, color: messageColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
