import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';
import 'package:mm_proyecto_final/widgets/custom_app_bar.dart';
import 'package:mm_proyecto_final/widgets/custom_button.dart';
import 'package:mm_proyecto_final/widgets/info_card.dart';
import 'package:mm_proyecto_final/widgets/progress_bar.dart';
import 'package:mm_proyecto_final/widgets/progress_ring.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final log = controller.todayLog;

    return Scaffold(
      backgroundColor: AppTheme.backgroundMint,
      appBar: CustomAppBar(
        leading: GestureDetector(
          onTap: () => controller.navigateTo(3),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(MockData.user.avatarUrl),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppTheme.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          InfoCard(
            color: const Color(0xFFEBF5FB),
            child: Column(
              children: [
                Text(
                  'Meta de Agua del Día',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                ProgressRing(
                  progress: log.waterLiters,
                  goal: log.waterGoal,
                  size: 160,
                  color: AppTheme.waterBlue,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.water_drop,
                        color: AppTheme.waterBlue,
                        size: 20,
                      ),
                      Text(
                        '${log.waterLiters.toStringAsFixed(1)}L',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: AppTheme.waterBlue,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        'DE META DE ${log.waterGoal.toStringAsFixed(1)}L',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Registrar Agua',
                  icon: Icons.add,
                  isPrimary: true,
                  backgroundColor: AppTheme.waterBlue.withValues(alpha: 0.15),
                  foregroundColor: AppTheme.waterBlue,
                  onPressed: () => controller.addWater(0.25),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: AppTheme.primaryGreen,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Calorías',
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
                        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'En Meta',
                        style: TextStyle(
                          color: AppTheme.darkGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${log.caloriesConsumed}',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: AppTheme.primaryGreen),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        'CONSUMIDAS',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 10),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${log.caloriesGoal}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        'META',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ProgressBar(
                  current: log.caloriesConsumed.toDouble(),
                  max: log.caloriesGoal.toDouble(),
                  height: 8,
                  foregroundColor: AppTheme.primaryGreen,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppTheme.waterBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Próxima Bebida',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '2:30 PM',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.waterBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Beber 250ml de agua',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.waterLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.waterBlue.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    'en 45 min',
                    style: TextStyle(
                      color: AppTheme.waterBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InfoCard(
                  onTap: () => controller.navigateTo(1),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.restaurant,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Registrar Comida',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InfoCard(
                  onTap: () => controller.navigateTo(3),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.waterBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.monitor_weight_outlined,
                          color: AppTheme.waterBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Actualizar Peso',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
