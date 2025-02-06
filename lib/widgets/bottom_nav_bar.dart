import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabels: false, // 선택된 라벨 숨기기
      showUnselectedLabels: false, // 선택되지 않은 라벨 숨기기
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.format_align_left), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '캘린더'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
      ],
    );
  }
}
