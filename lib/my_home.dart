import 'package:depi_five/const.dart';
import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [_studentCard(), SizedBox(height: 20), _tableDetails()],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: .spaceAround,
          children: [
            _navItem(icon: Icons.home, label: "Home"),
            _navItem(icon: Icons.book, label: "Courses"),
            _navItem(icon: Icons.message, label: "Messages"),
            _navItem(icon: Icons.person, label: "Profile"),
          ],
        ),
      ),
    );
  }


  Widget _navItem({required IconData icon, required String label}) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey),
        Text(label),
      ],
    );
  }

  Container _tableDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _tableItem(icon: Icons.person, title: "Age", desc: "20"),
          _tableItem(icon: Icons.grade, title: "Univ", desc: "Cairo Univ"),
          _tableItem(
            icon: Icons.calendar_month,
            title: "Year",
            desc: "3th Year",
          ),
          _tableItem(
            icon: Icons.access_alarm,
            title: "Major",
            desc: "Computer Science",
          ),
          _tableItem(icon: Icons.person, title: "Age", desc: "20"),
          _tableItem(icon: Icons.person, title: "Age", desc: "20"),
          _tableItem(icon: Icons.person, title: "Age", desc: "20"),
          _tableItem(icon: Icons.person, title: "Age", desc: "20"),
        ],
      ),
    );
  }

  Widget _tableItem({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(.2),
              child: Icon(icon, color: Colors.blue),
            ),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 100),
            Text(desc, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Padding(padding: const EdgeInsets.only(left: 50.0), child: Divider()),
      ],
    );
  }

  Column _studentCard() {
    return Column(
      children: [
        CircleAvatar(radius: 50, backgroundImage: NetworkImage(image1)),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "Ahmed Mohamed",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Computer Science Student",
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      leading: Icon(Icons.menu, color: Colors.white),
      title: Text("Student Info", style: TextStyle(color: Colors.white)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.notifications_outlined, color: Colors.white),
        ),
      ],
    );
  }
}
