import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';
import 'package:mm_proyecto_final/screens/notifications_screen.dart';
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

  bool get _isWater => _selectedTab == 0;

  Color get _activeColor => _isWater ? AppTheme.waterBlue : AppTheme.primaryGreen;

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final stats = controller.weeklyStats;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
            icon: Icon(
              Icons.notifications_outlined,
              color: isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimary,
            ),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const NotificationsScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOutCubic;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          Text(
            'Sigue tu hidratación e ingesta calórica a lo largo del tiempo.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E2721) : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildTab('Agua', 0, AppTheme.waterBlue, isDark),
                _buildTab('Nutrición', 1, AppTheme.primaryGreen, isDark),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _isWater
              ? _buildSummaryCard(
                  icon: Icons.water_drop,
                  label: 'Ingesta Promedio',
                  value: '2.4 Litros / Día',
                  badge: 'Esta Semana',
                  trend: '+0.2L desde la semana pasada',
                  trendColor: AppTheme.primaryGreen,
                  cardColor: isDark ? AppTheme.waterLightDark : const Color(0xFFEBF5FB),
                  isDark: isDark,
                )
              : _buildSummaryCard(
                  icon: Icons.local_fire_department,
                  label: 'Promedio Calórico',
                  value: '1,850 kcal / Día',
                  badge: 'Esta Semana',
                  trend: '-150 kcal desde la semana pasada',
                  trendColor: AppTheme.waterBlue,
                  cardColor: isDark ? const Color(0xFF162D20) : const Color(0xFFE8F8EE),
                  isDark: isDark,
                ),
          const SizedBox(height: 24),
          Text(
            _isWater ? 'TENDENCIA DE HIDRATACIÓN' : 'TENDENCIA CALÓRICA',
            style: theme.textTheme.labelLarge?.copyWith(
                  color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 12),
          InfoCard(
            child: CustomLineChart(
              data: _isWater
                  ? stats.waterTrend
                  : stats.caloriesTrend.map((e) => e.toDouble()).toList(),
              labels: const ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
              maxY: _isWater ? 3.5 : 2500,
              lineColor: _activeColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'CONSISTENCIA NUTRICIONAL',
            style: theme.textTheme.labelLarge?.copyWith(
                  color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 12),
          InfoCard(
            child: CustomBarChart(
              values: stats.nutritionConsistency,
              activeIndex: 3,
              activeColor: _activeColor,
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
                  style: theme.textTheme.labelLarge?.copyWith(
                        color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isWater
                      ? 'Normalmente consumes menos agua los fines de semana. Intenta configurar un recordatorio para los sábados por la tarde.'
                      : 'Tu ingesta de proteínas es baja los miércoles y domingos. Considera añadir una fuente de proteína en esas comidas.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: _isWater ? 'Configurar Recordatorio' : 'Ver Plan Nutricional',
                  icon: _isWater ? Icons.alarm : Icons.restaurant_menu,
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

  Widget _buildTab(String label, int index, Color activeColor, bool isDark) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String label,
    required String value,
    required String badge,
    required String trend,
    required Color trendColor,
    required Color cardColor,
    required bool isDark,
  }) {
    final theme = Theme.of(context);
    return InfoCard(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: _activeColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _activeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: _activeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
                  color: isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimary,
                ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.trending_up, color: trendColor, size: 16),
              const SizedBox(width: 4),
              Text(
                trend,
                style: theme.textTheme.bodyMedium?.copyWith(
                      color: trendColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
