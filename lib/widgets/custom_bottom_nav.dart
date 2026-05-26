import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF2C3E50) : const Color(0xFFE5E7EB),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItem(Icons.home_outlined, Icons.home_rounded, 'Inicio', 0, context),
            _buildItem(Icons.book_outlined, Icons.book_rounded, 'Diario', 1, context),
            _buildItem(Icons.trending_up_outlined, Icons.trending_up_rounded, 'Progreso', 2, context),
            _buildItem(Icons.person_outline_rounded, Icons.person_rounded, 'Perfil', 3, context),
            _buildItem(Icons.settings_outlined, Icons.settings_rounded, 'Ajustes', 4, context),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, IconData activeIcon, String label, int index, BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = currentIndex == index;
    final color = isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color ?? AppTheme.textSecondary;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isSelected ? activeIcon : icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
