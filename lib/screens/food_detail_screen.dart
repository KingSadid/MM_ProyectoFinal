import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';
import 'package:mm_proyecto_final/widgets/custom_button.dart';
import 'package:mm_proyecto_final/widgets/food_detail_header.dart';
import 'package:mm_proyecto_final/widgets/info_card.dart';
import 'package:mm_proyecto_final/widgets/macro_bars.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final food = MockData.featuredFood;

    return Scaffold(
      backgroundColor: AppTheme.backgroundMint,
      body: Stack(
        children: [
          Column(
            children: [
              FoodDetailHeader(imageUrl: food.imageUrl),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'ALMUERZO',
                            style: TextStyle(
                              color: AppTheme.darkGreen,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE4E1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${food.kcal} KCAL',
                            style: const TextStyle(
                              color: AppTheme.accentRed,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      food.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Una fuente de nutrientes que combina carbohidratos complejos, grasas saludables y proteínas de alta calidad. Perfectamente equilibrado para proporcionar energía sostenida y claridad mental durante toda la tarde.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.pie_chart_outline,
                                color: AppTheme.primaryGreen,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Perfil de Macronutrientes',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          MacroBars(macros: food.macros),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.9),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppTheme.textPrimary,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: CustomButton(
              text: 'Registrar en el Diario',
              icon: Icons.add,
              isPrimary: true,
              backgroundColor: AppTheme.darkGreen,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
