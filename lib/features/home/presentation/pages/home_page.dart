import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/features/home/presentation/widgets/source_widget.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // This is the username with profile section
          Row(
            children: [
              //TODO: Updated this container to show user image or sample image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                height: 50,
                width: 50,
                child: Icon(Icons.person),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome", style: TextStyle(fontSize: 12)),
                  //TODO: Fetch username from the firebase using bloc
                  Text("A Likith Reddy", style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Balance", style: TextStyle(fontSize: 11)),
                  //TODO: Fetch total amount from the user using bloc
                  Text(
                    "₹54,300.43",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.visibility),
                iconSize: 28,
              ),
            ],
          ),
          SourceWidget(
            sources: [
              Source(
                sourceId: "1",
                name: "HDFC",
                money: Money.inRupees(43560.34),
              ),
              Source(
                sourceId: "2",
                name: "IOB",
                money: Money.inRupees(4350.34),
              ),
              Source(sourceId: "3", name: "Wallet", money: Money.inRupees(560)),
            ],
          ),
          // Row(
          //   children: [
          //     SourceWidget(
          //       sourceName: "IOB",
          //       accountBalance: 5200.75,
          //       cardColor: Colors.purpleAccent,
          //     ),
          //     SourceWidget(
          //       sourceName: "HDFC Bank",
          //       accountBalance: 45230.75,
          //       cardColor: Colors.deepPurple,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
