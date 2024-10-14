import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'add_mood.dart';
import 'edit_mood.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, this.selectedMood})
      : super(key: key);

  final String title;
  final String? selectedMood;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  final Map<DateTime, String> _moodMap = {};

  @override
  void initState() {
    super.initState();
    if (widget.selectedMood != null) {
      setState(() {
        _moodMap[_selectedDay] = widget.selectedMood!;
      });
    }
  }

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
      body: Stack(children: [
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 15),

                // Yellow container with Month, Year
                Container(
                  width: 360,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDFFB6),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('MMMM, yyyy').format(_focusedDay),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // Blue container with calendar
                Container(
                  height: 390,
                  width: 360,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9EDF8),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Expanded(
                        child: TableCalendar(
                          focusedDay: _focusedDay,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          calendarFormat: _calendarFormat,
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            weekendStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay =
                                  selectedDay; // Make sure to set the selected day
                              _focusedDay = focusedDay;
                            });
                            // Navigate to the AddMoodPage when a day is selected
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EditMoodPage(title: ''),
                              ),
                            ).then((selectedMood) {
                              if (selectedMood != null) {
                                setState(() {
                                  _moodMap[selectedDay] =
                                      selectedMood; // Update mood map on mood selection
                                });
                              }
                            });
                          },
                          onFormatChanged: (format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          },
                          onPageChanged: (focusedDay) {
                            setState(() {
                              _focusedDay = focusedDay;
                            });
                          },
                          calendarBuilders: CalendarBuilders(
                            defaultBuilder: (context, day, focusedDay) {
                              String mood = _moodMap[day] ?? '';
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: mood.isNotEmpty
                                            ? getMoodColor(mood)
                                            : Colors.grey[300],
                                      ),
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          mood,
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      DateFormat('d').format(day),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            },
                            todayBuilder: (context, day, focusedDay) {
                              String mood = _moodMap[day] ?? '';

                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          mood,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      DateFormat('d').format(day),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            },
                            selectedBuilder: (context, day, focusedDay) {
                              return Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.red, width: 3),
                                  ),
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      _moodMap[day] ??
                                          DateFormat('d').format(day),
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          headerVisible: false,
                          headerStyle: const HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                          ),
                          rowHeight: 70,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Goal Mood container
                Container(
                  width: 360,
                  height: 139,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9EDF8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Goal Mood',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '800 points to next level',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 340,
                        height: 33,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 310,
                                height: 33,
                                decoration: ShapeDecoration(
                                  color: const Color(0x7FFDFFB6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 4,
                              top: 4,
                              child: Container(
                                width: 245,
                                height: 25,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFD6A5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon Widget
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 2),
                                    // Text Widget
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: '5200 ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '/ 6000',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 280,
                              top: 4,
                              child: Container(
                                width: 25,
                                height: 25,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 3),
                                decoration: ShapeDecoration(
                                  color: const Color(0x7FFF981F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '3',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 4,
                              top: 3.50,
                              child: Container(
                                width: 25,
                                height: 25,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 3),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFF981F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '2',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Container(
                //   height: 200,
                //   width: 360,
                //   decoration: const BoxDecoration(
                //     color: Color(0xFFD9EDF8),
                //     borderRadius: BorderRadius.vertical(
                //       top: Radius.circular(30),
                //       bottom: Radius.circular(30),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 15),
              ],
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
              borderRadius:
                  BorderRadius.vertical(top: Radius.elliptical(200, 100)),
            ),
          ),
        ),

        // Add button background
        Positioned(
          left: 0,
          bottom: 37,
          right: 0,
          child: Container(
            width: 125,
            height: 125,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Add button
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              // Navigate to AddMoodPage and wait for the selected mood result
              final selectedMood = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddMoodPage(
                    title: '',
                  ),
                ),
              );

              // After the user selects a mood, update the mood for the selected day
              if (selectedMood != null && _selectedDay != null) {
                // Check if _selectedDay is not null
                setState(() {
                  _moodMap[_selectedDay!] =
                      selectedMood; // Use ! to assert that _selectedDay is not null
                });
              }
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFDFFB6),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 70,
                  color: Color(0xFFFFD6A5),
                ),
              ),
            ),
          ),
        ),
      ]),
      backgroundColor: Colors.white,
    );
  }

  void showMoodSelectionDialog(DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select your mood'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _moodMap[selectedDay] = '😁'; // Great
                });
                Navigator.pop(context);
              },
              child: const Text('😁', style: TextStyle(fontSize: 40)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _moodMap[selectedDay] = '😊'; // Good
                });
                Navigator.pop(context);
              },
              child: const Text('😊', style: TextStyle(fontSize: 40)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _moodMap[selectedDay] = '😐'; // OK
                });
                Navigator.pop(context);
              },
              child: const Text('😐', style: TextStyle(fontSize: 40)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _moodMap[selectedDay] = '🙁'; // Not Good
                });
                Navigator.pop(context);
              },
              child: const Text('🙁', style: TextStyle(fontSize: 40)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _moodMap[selectedDay] = '😡'; // Bad
                });
                Navigator.pop(context);
              },
              child: const Text('😡', style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case 'Great':
        return const Color(0xFF4AAF57);
      case 'Good':
        return const Color(0xFF8BC255);
      case 'OK':
        return const Color(0xFFFFC02D);
      case 'Not Good':
        return const Color(0xFFFF981F);
      case 'Bad':
        return const Color(0xFFF54336);
      default:
        return Colors.grey;
    }
  }
}
