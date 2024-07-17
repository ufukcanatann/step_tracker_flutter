// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dropdown_menu.dart';
import 'statistics_page.dart';
import 'steps_page.dart';
import 'journey_data.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Lottie.asset('assets/welcome_animation.json'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Nereden",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 5),
                  AnimatedDropdownIstanbul(),
                  SizedBox(height: 20),
                  Text(
                    "Nereye",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 5),
                  AnimatedDropdownAnkara(),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 5.0),
                  child: JourneyCard(journey: journeys[index]),
                );
              },
              childCount: journeys.length,
            ),
          ),
        ],
      ),
    );
  }
}

class JourneyCard extends StatefulWidget {
  final Map<String, String> journey;

  JourneyCard({required this.journey});

  @override
  _JourneyCardState createState() => _JourneyCardState();
}

class _JourneyCardState extends State<JourneyCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
          shadowColor: Colors.grey.withOpacity(0.5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: widget.journey['image']!,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              widget.journey['image']!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.journey['name']!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.journey['route']!,
                              style: TextStyle(
                                fontSize: 11,
                                color: const Color.fromARGB(255, 76, 76, 76),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.journey['date']!,
                              style: TextStyle(
                                fontSize: 11,
                                color: const Color.fromARGB(255, 76, 76, 76),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.directions_car,
                              color: Colors.blue.shade800, size: 16),
                          SizedBox(width: 5),
                          Text(
                            widget.journey['plate']!,
                            style: TextStyle(
                              fontSize: 11,
                              color: const Color.fromARGB(255, 76, 76, 76),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.blue.shade800, size: 16),
                          SizedBox(width: 5),
                          Text(
                            widget.journey['rating']!,
                            style: TextStyle(
                              fontSize: 11,
                              color: const Color.fromARGB(255, 76, 76, 76),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.people,
                              color: Colors.blue.shade800, size: 16),
                          SizedBox(width: 5),
                          Text(
                            '${widget.journey['capacity']} kişi',
                            style: TextStyle(
                              fontSize: 11,
                              color: const Color.fromARGB(255, 76, 76, 76),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
