import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              // onChanged: (val) => amountInput = val),
            ),
            FlatButton(
              onPressed: () {
                print(titleController.text);
                // print(amountInput);
              },
              child: Text(
                'ADD TRANSACTION',
                style: TextStyle(fontSize: 10),
              ),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
