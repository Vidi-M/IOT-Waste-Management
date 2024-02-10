import 'package:flutter/material.dart';
import 'package:iot_app/pages/models/bin.dart';

class BinTile extends StatelessWidget {
  Bin bin;
  BinTile({super.key, required this.bin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          //bin pic
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(bin.img),
          ),

          //name
          Text(
            bin.name,
            style: TextStyle(color: Colors.grey[600]),
          ),

          //data
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bin.data),
              Text(bin.data),
            ],
          ),

          //map
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset(bin.maplogo),
          )
        ],
      ),
    );
  }
}
