import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';

class MacroBars extends StatelessWidget {
  final MacroNutrients macros;

  const MacroBars({super.key, required this.macros});

  @override
  Widget build(BuildContext context) {
    final total = macros.protein + macros.carbs + macros.fats;
    final pPct = total == 0 ? 0.0 : macros.protein / total;
    final cPct = total == 0 ? 0.0 : macros.carbs / total;
    final fPct = total == 0 ? 0.0 : macros.fats / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              _buildSegment(pPct, AppTheme.primaryGreen),
              _buildSegment(cPct, AppTheme.waterBlue),
              _buildSegment(fPct, const Color(0xFFFFA07A)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildLegend('PROTEÍNA', macros.protein, AppTheme.primaryGreen),
            _buildLegend('CARBOS', macros.carbs, AppTheme.waterBlue),
            _buildLegend('GRASAS', macros.fats, const Color(0xFFFFA07A)),
          ],
        ),
      ],
    );
  }

  Widget _buildSegment(double pct, Color color) {
    return Expanded(
      flex: (pct * 1000).round(),
      child: Container(height: 12, color: color),
    );
  }

  Widget _buildLegend(String label, double value, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
            ),
            Text(
              '${value.round()}g',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
