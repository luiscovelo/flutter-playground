import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentsTransactions}) : super(key: key);

  final List<Transaction> recentsTransactions;

  List<Map<String, Object>> get _groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentsTransactions.length; i++) {
        bool sameDay = recentsTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentsTransactions[i].date.month == weekDay.month;
        bool sameYear = recentsTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentsTransactions[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return _groupedTransaction.fold(0.0, (sum, item) {
      final double value = double.tryParse(item['value'].toString()) ?? 0.0;
      return sum + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransaction.map((transaction) {
            final double value =
                double.tryParse(transaction['value'].toString()) ?? 0;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction['day'].toString(),
                value: value,
                percentage: _weekTotalValue > 0 ? value / _weekTotalValue : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
