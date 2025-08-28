import 'package:flutter/material.dart';

class NotifecationWidgets extends StatelessWidget {
  const NotifecationWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFEEF8ED),
      ),
      child: Icon(Icons.notifications_outlined),
    );
  }
}
