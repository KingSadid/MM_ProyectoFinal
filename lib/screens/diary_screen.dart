import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';
import 'package:mm_proyecto_final/screens/food_detail_screen.dart';
import 'package:mm_proyecto_final/widgets/info_card.dart';
import 'package:mm_proyecto_final/widgets/meal_item.dart';
import 'package:mm_proyecto_final/widgets/progress_bar.dart';
import 'package:mm_proyecto_final/widgets/section_header.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final log = controller.todayLog;
    final meals = controller.meals;

    return Scaffold(
      backgroundColor: AppTheme.backgroundMint,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            InfoCard(
              child: Column(
                children: [
                  Text(
                    'Calorías Restantes',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${log.caloriesGoal - log.caloriesConsumed}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Meta: ${log.caloriesGoal}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ProgressBar(
                    current: log.caloriesConsumed.toDouble(),
                    max: log.caloriesGoal.toDouble(),
                    height: 8,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMacroColumn(
                        'Proteína',
                        log.proteinG,
                        log.proteinGoal,
                      ),
                      _buildMacroColumn(
                        'Carbohidratos',
                        log.carbsG,
                        log.carbsGoal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            for (final meal in meals) ...[
              SectionHeader(
                title: meal.type,
                trailing: meal.totalKcal > 0 ? '${meal.totalKcal} kcal' : null,
              ),
              if (meal.items.isNotEmpty)
                InfoCard(
                  child: Column(
                    children: meal.items.map((f) => MealItem(food: f)).toList(),
                  ),
                )
              else
                InfoCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const FoodDetailScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Registrar Cena'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FloatingActionButton.small(
                        heroTag: 'fab_${meal.type}',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const FoodDetailScreen(),
                            ),
                          );
                        },
                        backgroundColor: AppTheme.primaryGreen,
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroColumn(String label, double current, double goal) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          '${current.round()}g',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          '/${goal.round()}g',
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}
