import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signapp/newscreen.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Week 1",
      subtitle: "Learn ISL",
      event: "",
      img: "images/calendar.png");

  Items item2 = new Items(
    title: "Week 2",
    subtitle: "Learn ISL",
    event: "",
    img: "images/food.png",
  );
  Items item3 = new Items(
    title: "Week 3",
    subtitle: "Learn ISL",
    event: "",
    img: "images/map.png",
  );
  Items item4 = new Items(
    title: "Week 4",
    subtitle: "Learn ISL",
    event: "",
    img: "images/festival.png",
  );
  Items item5 = new Items(
    title: "Week 5",
    subtitle: "Learn ISL",
    event: "",
    img: "images/todo.png",
  );
  Items item6 = new Items(
    title: "Week 6",
    subtitle: "Learn ISL",
    event: "",
    img: "images/setting.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xFF743756;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return GestureDetector(
            onTap: () {
              if (data.title == "Week 1") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewScreen()), // Replace Week1Screen() with your desired screen
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(color),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(data.img, width: 42),
                  SizedBox(height: 14),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    data.event,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({required this.title, required this.subtitle, required this.event, required this.img});
}
