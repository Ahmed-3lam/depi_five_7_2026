import 'package:depi_five/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessangerPage extends StatelessWidget {
  const MessangerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
          children: [
            _myAppbar(),
            SizedBox(height: 20),
            _searchBar(),

            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(image1),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _myAppbar() {
    return Row(
      children: [
        CircleAvatar(radius: 30, backgroundImage: NetworkImage(image1)),

        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "Chats",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(CupertinoIcons.camera),
        ),
        SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.edit),
        ),
      ],
    );
  }

  Container _searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search",
        ),
      ),
    );
  }
}
