import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';
import 'package:mm_proyecto_final/widgets/custom_app_bar.dart';
import 'package:mm_proyecto_final/widgets/custom_bar_chart.dart';
import 'package:mm_proyecto_final/widgets/custom_button.dart';
import 'package:mm_proyecto_final/widgets/custom_line_chart.dart';
import 'package:mm_proyecto_final/widgets/info_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final stats = controller.weeklyStats;

    return Scaffold(
      backgroundColor: AppTheme.backgroundMint,
      appBar: const CustomAppBar(title: 'Resumen Semanal'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          Text(
            'Sigue tu hidratación e ingesta calórica a lo largo del tiempo.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [_buildTab('Agua', 0), _buildTab('Nutrición', 1)],
            ),
          ),
          const SizedBox(height: 20),
          InfoCard(
            color: const Color(0xFFEBF5FB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.water_drop,
                          color: AppTheme.waterBlue,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Ingesta Promedio',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.waterBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Esta Semana',
                        style: TextStyle(
                          color: AppTheme.waterBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '2.4 Litros / Día',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      color: AppTheme.primaryGreen,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+0.2L desde la semana pasada',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'TENDENCIA DE HIDRATACIÓN',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          InfoCard(
            child: CustomLineChart(
              data: stats.waterTrend,
              labels: const ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
              maxY: 3.5,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'CONSISTENCIA NUTRICIONAL',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          InfoCard(
            child: CustomBarChart(
              values: stats.nutritionConsistency,
              activeIndex: 3,
              labels: const ['L', 'M', 'M', 'J', 'V', 'S', 'D'],
            ),
          ),
          const SizedBox(height: 24),
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONSEJO CLAVE',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Normalmente consumes menos agua los fines de semana. Intenta configurar un recordatorio para los sábados por la tarde.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Configurar Recordatorio',
                  icon: Icons.alarm,
                  isPrimary: false,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
