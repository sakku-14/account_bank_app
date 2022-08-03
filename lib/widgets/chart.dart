import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(recentTransactions[0].title),
            Text(recentTransactions[0].title),
            Text(recentTransactions[0].title),
            Text(recentTransactions[0].title),
            Text(recentTransactions[0].title),
            Text(recentTransactions[0].title),
            Text(recentTransactions[0].title),
          ],
        ),
      ),
    );
  }
}
