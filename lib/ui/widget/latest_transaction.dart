import 'package:financial_tracker/common/utils/formatter.dart';
import 'package:financial_tracker/domain/entity/transaction_entity.dart';
import 'package:flutter/material.dart';

class LatestTransaction extends StatelessWidget {
  final double transactionValue;
  final String transactionTitle;
  final TransactionType transactionType;

  const LatestTransaction({
    super.key,
    required this.transactionValue,
    required this.transactionTitle,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isIncome = transactionType == TransactionType.income;

    final icon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;
    final iconColor = isIncome ? Colors.green : Colors.red;

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
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  Formatter.formatCurrency(transactionValue),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: colorScheme.onSecondary.withValues(
                    alpha: 0.45,
                  ),
                  child: Icon(icon, size: 14, color: iconColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
