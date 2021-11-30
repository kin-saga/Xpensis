import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:xpensis/providers/transactionListProvider.dart';
import 'package:xpensis/widgets/transactionList.dart';

import "./widgets/chart.dart";
import './widgets/newTransactionDialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionListProvider()),
      ],
      child: MaterialApp(
        title: "Xpensis",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void startNewTransactionDialog() {
    showModalBottomSheet(
      elevation: 6,
      //barrierColor: Theme.of(context).accentColor,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (BuildContext context) => NewTransactionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(
        '${MediaQuery.of(context).size.height} ${MediaQuery.of(context).size.width}');
    final portrait =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Xpensis"),
        ),
        elevation: 5,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: startNewTransactionDialog,
          ),
        ],
      ),
      body: portrait
          ? Column(
              children: [
                Chart(),
                TransactionList(),
              ],
            )
          : Row(
              children: [
                Chart(),
                TransactionList(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "add transaction",
        onPressed: startNewTransactionDialog,
      ),
    );
  }
}
