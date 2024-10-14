import 'package:flutter/material.dart';

class AddMoodPage extends StatefulWidget {
  const AddMoodPage({super.key, required this.title});

  final String title;

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: SizedBox(
              width: 60,
              height: 60,
              child: IconButton(
                onPressed: () {
                  // Add your action here
                  print("Profile Button was clicked");
                },
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFADAD),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 30,
                    color: Color(0xFFFDFFB6),
                  ),
                ),
                iconSize: 60,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: SizedBox(
              width: 60,
              height: 60,
              child: IconButton(
                onPressed: () {
                  // Add your action here
                  print("Settings Button was clicked");
                },
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFADAD),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.settings,
                    size: 30,
                    color: Color(0xFFFDFFB6),
                  ),
                ),
                iconSize: 60,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background
          Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                'How about your day ?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: 360,
                height: 500,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9EDF8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 55,
            left: 235,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(3.14),
              child: Container(
                width: 60,
                height: 100,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD9EDF8),
                  shape: StarBorder.polygon(
                    sides: 3,
                    pointRounding: 0.3,
                  ),
                ),
              ),
            ),
          ),

          // Bottom background
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFD9EDF8),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(200, 100),
                ),
              ),
            ),
          ),

          // Mood Options
          Positioned(
            top: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMoodOption(context, '😁', 'Great'),
                _buildMoodOption(context, '😊', 'Good'),
                _buildMoodOption(context, '😐', 'OK'),
                _buildMoodOption(context, '🙁', 'Bad'),
                _buildMoodOption(context, '😡', 'Sucks'),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildMoodOption(BuildContext context, String mood, String label) {
    return GestureDetector(
      onTap: () {
        // Pass the selected mood back to HomePage
        Navigator.pop(context, mood);
      },
      child: Column(
        children: [
          Text(mood, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
