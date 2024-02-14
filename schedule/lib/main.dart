import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule/custom_functions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bgColor = const Color(0xFF1F1F1F);
  final now = DateTime.now();
  final List<int> daysInCurrentMonth = getDaysInCurrentMonth();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: bgColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              // TOP - h77
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 20,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.face,
                      color: Colors.white,
                      size: 70,
                    ),
                    // if ('' == '')
                    //   Text(
                    //     "hello",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // TODAY - h93
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      // "monday 16".toUpperCase(),
                      "${DateFormat('EEEE').format(now)} ${now.day}"
                          .toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // DAYS
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "today ".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Icon(
                          Icons.circle,
                          color: Color(0xFFB12680),
                          size: 15,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        for (var item in daysInCurrentMonth)
                          item > now.day
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text(
                                    '$item',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              : const Text('')
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // SizedBox(
              //   height: 500,
              //   child: SingleChildScrollView(
              //       scrollDirection: Axis.vertical,
              //       child: Column(children: [
              //         for (int index in Iterable<int>.generate(100).toList())
              //           Text(
              //             '$index',
              //             style: const TextStyle(color: Colors.white),
              //           )
              //       ])),
              // ),
              // SCHEDULE CARDS
              SizedBox(
                height: MediaQuery.of(context).size.height - 230,
                child: const SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ScheduleCard(
                        titleName: 'design meeting',
                        time: ['11', '30', '12', '20'],
                        participants: ['alex', 'helena', 'nana', ''],
                        bgColor: Color(0xFFFEF754),
                      ),
                      ScheduleCard(
                        titleName: 'daily project',
                        time: ['11', '30', '12', '20'],
                        participants: ['me', 'richard', 'ciry', '+4'],
                        bgColor: Color(0xFF9C6BCE),
                      ),
                      ScheduleCard(
                        titleName: 'weekly planning',
                        time: ['11', '30', '12', '20'],
                        participants: ['den', 'nana', 'mark', ''],
                        bgColor: Color(0xFFBCEE4B),
                      ),
                      ScheduleCard(
                        titleName: 'weekly planning',
                        time: ['11', '30', '12', '20'],
                        participants: ['den', 'nana', 'mark', ''],
                        bgColor: Color(0xFFBCEE4B),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final List<String> time;
  final List<String> participants;
  final String titleName;
  final Color bgColor;

  const ScheduleCard({
    required this.titleName,
    required this.time,
    required this.participants,
    required this.bgColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      time[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time[1].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 24,
                      color: Colors.grey,
                    ),
                    Text(
                      time[2].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time[3].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  titleName.replaceAll(' ', '\n').toUpperCase(),
                  style: const TextStyle(
                    letterSpacing: 0,
                    height: 1,
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 70,
                ),
                Text(
                  // participants[index].toUpperCase(),

                  participants[0].toUpperCase(),
                  style: TextStyle(
                    color: participants[0].contains('me')
                        ? Colors.black
                        : Colors.black.withOpacity(0.3),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  // participants[index].toUpperCase(),
                  participants[1].toUpperCase(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  // participants[index].toUpperCase(),
                  participants[2].toUpperCase(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  // participants[index].toUpperCase(),
                  participants[3].toUpperCase(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
            // ListView(
            //   children: [for (var item in participants) Text(item)],
            // ),
            // Expanded(
            //   child: ListView.separated(
            //     scrollDirection: Axis.horizontal,
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 10,
            //       horizontal: 10,
            //     ),
            //     itemCount: participants.length,
            //     itemBuilder: (context, index) {
            //       return Text("$index");
            //     },
            //     //   return Row(
            //     //     children: [
            //     //       const SizedBox(
            //     //         width: 30,
            //     //       ),
            //     //       Text(
            //     //         // participants[index].toUpperCase(),
            //     //         'alex'.toUpperCase(),
            //     //         style: const TextStyle(
            //     //           fontSize: 14,
            //     //           fontWeight: FontWeight.w600,
            //     //         ),
            //     //       ),
            //     //     ],
            //     //   );
            //     // },
            //     separatorBuilder: (context, index) => const SizedBox(
            //       width: 40,
            //     ),
            //   ),
            // ),
            // Row(
            //   children: [
            //     const SizedBox(
            //       width: 50,
            //     ),
            //     ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: participants.length,
            //       itemBuilder: (context, index) {
            //         return Text('$index');
            //       },
            //     ),
            //     ListView.builder(
            //       itemCount: participants.length,
            //       itemBuilder: (context, index) {
            //         return Row(
            //           children: [
            //             const SizedBox(
            //               width: 30,
            //             ),
            //             Text(
            //               // participants[index].toUpperCase(),
            //               'alex'.toUpperCase(),
            //               style: const TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ],
            //         );
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
