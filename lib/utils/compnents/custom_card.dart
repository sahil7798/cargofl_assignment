import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  String img, img2, id;
  CustomCard({required this.img, required this.img2, required this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      // margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: ClipRRect(
                // clip the image to a circle
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            horizontalTitleGap: 5,
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              radius: 15,
              backgroundImage: NetworkImage(img2),
            ),
            title: Text(
              id,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
