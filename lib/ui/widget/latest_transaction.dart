import 'package:financial_tracker/common/utils/formatter.dart';
import 'package:flutter/material.dart';

class LatestTransaction extends StatelessWidget {
  final double transactionValue;
  final String transactionTitle;

  const LatestTransaction({
    super.key,
    required this.transactionValue,
    required this.transactionTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withValues(alpha: 0.7),
              colorScheme.secondary,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              transactionTitle,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            Row(
              children: [
                Text(
                  Formatter.formatCurrency(transactionValue),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: colorScheme.onSecondary.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_upward, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
