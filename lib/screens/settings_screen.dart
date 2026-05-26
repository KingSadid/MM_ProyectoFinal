import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';
import 'package:mm_proyecto_final/screens/splash_screen.dart';
import 'package:mm_proyecto_final/widgets/custom_app_bar.dart';
import 'package:mm_proyecto_final/widgets/info_card.dart';
import 'package:mm_proyecto_final/widgets/toggle_setting_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final settings = controller.settings;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CustomAppBar(title: 'Ajustes'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          Text(
            'Personaliza tu experiencia y preferencias.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PREFERENCIAS DE LA APP',
                  style: theme.textTheme.labelLarge?.copyWith(
                        color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                ),
                const Divider(height: 24),
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    return Column(
                      children: [
                        ToggleSettingItem(
                          icon: Icons.water_drop_outlined,
                          iconColor: AppTheme.waterBlue,
                          title: 'Recordatorios de Agua',
                          subtitle:
                              'Recibe notificaciones para mantenerte hidratado',
                          value: settings.waterReminders,
                          onChanged: controller.toggleWaterReminders,
                        ),
                        const Divider(height: 1),
                        ToggleSettingItem(
                          icon: Icons.dark_mode_outlined,
                          iconColor: isDark ? AppTheme.primaryGreen : const Color(0xFF6B7280),
                          title: 'Modo Oscuro',
                          subtitle: 'Cambiar a un tema más oscuro',
                          value: settings.darkMode,
                          onChanged: controller.toggleDarkMode,
                        ),
                        const Divider(height: 1),
                        ToggleSettingItem(
                          icon: Icons.scale_outlined,
                          iconColor: isDark ? AppTheme.waterBlue : const Color(0xFF6B7280),
                          title: 'Unidades (ml/oz)',
                          subtitle: 'Usar onzas en lugar de mililitros',
                          value: settings.useOz,
                          onChanged: controller.toggleUnits,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CUENTA',
                  style: theme.textTheme.labelLarge?.copyWith(
                        color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                ),
                const Divider(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.manage_accounts_outlined,
                      color: AppTheme.primaryGreen,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Gestionar Perfil',
                    style: TextStyle(
                      color: isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                  ),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.accentRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: AppTheme.accentRed,
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(color: AppTheme.accentRed),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
