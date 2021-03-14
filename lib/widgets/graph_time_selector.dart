import 'package:crypto_app/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphTimeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, days, child) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            (days.numberOfDays == '1')
                ? timeSelectorSelected('1D')
                : timeSelector('1D', '1', context),
            (days.numberOfDays == '7')
                ? timeSelectorSelected('1W')
                : timeSelector('1W', '7', context),
            (days.numberOfDays == '30')
                ? timeSelectorSelected('1M')
                : timeSelector('1M', '30', context),
            (days.numberOfDays == '90')
                ? timeSelectorSelected('3M')
                : timeSelector('3M', '90', context),
            (days.numberOfDays == '365')
                ? timeSelectorSelected('1Y')
                : timeSelector('1Y', '365', context),
            (days.numberOfDays == 'max')
                ? timeSelectorSelected('ALL')
                : timeSelector('ALL', 'max', context),
            // Expanded(child: TextButton(onPressed: () {}, child: Text('1W'))),
            // Expanded(child: TextButton(onPressed: () {}, child: Text('1M'))),
            // Expanded(child: TextButton(onPressed: () {}, child: Text('3M'))),
            // Expanded(child: TextButton(onPressed: () {}, child: Text('1Y'))),
            // Expanded(child: TextButton(onPressed: () {}, child: Text('ALL'))),
          ],
        ),
      );
    });
  }

  Widget timeSelector(
      String timeDisplay, String numberOfDays, BuildContext context) {
    return Expanded(
        child: TextButton(
            onPressed: () {
              Provider.of<Data>(context, listen: false)
                  .updatenNumberOfDays(numberOfDays);
            },
            child: Text(timeDisplay)));
  }

  Widget timeSelectorSelected(String timeDisplay) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            timeDisplay,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
