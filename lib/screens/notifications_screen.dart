import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';
import 'package:mm_proyecto_final/widgets/custom_app_bar.dart';
import 'package:mm_proyecto_final/widgets/info_card.dart';

class NotificationItemData {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final String category; // 'nutrition', 'water', 'achievement', 'system'
  bool isRead;

  NotificationItemData({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.category,
    this.isRead = false,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationItemData> _notifications;
  String _selectedFilter = 'Todas';

  @override
  void initState() {
    super.initState();
    _notifications = [
      NotificationItemData(
        id: '1',
        title: '¡Meta de Agua Lograda!',
        message: '¡Excelente trabajo! Has completado el 100% de tu meta de hidratación diaria.',
        timeAgo: 'Hace 10 min',
        category: 'water',
        isRead: false,
      ),
      NotificationItemData(
        id: '2',
        title: 'Hora de Registrar tu Almuerzo',
        message: 'Mantén la constancia en tu diario. Registra tu almuerzo de hoy para no perder el progreso.',
        timeAgo: 'Hace 1 hora',
        category: 'nutrition',
        isRead: false,
      ),
      NotificationItemData(
        id: '3',
        title: 'Racha de 7 Días ',
        message: 'Has registrado todos tus alimentos durante una semana consecutiva. ¡Sigue así!',
        timeAgo: 'Hace 3 horas',
        category: 'achievement',
        isRead: true,
      ),
      NotificationItemData(
        id: '4',
        title: 'Recordatorio de Hidratación',
        message: 'Es momento de beber un vaso de agua (250ml) para mantener los niveles óptimos de energía.',
        timeAgo: 'Hace 5 horas',
        category: 'water',
        isRead: true,
      ),
      NotificationItemData(
        id: '5',
        title: 'Consejo Nutricional del Día',
        message: 'Los carbohidratos complejos de absorción lenta como la avena te darán energía por más tiempo.',
        timeAgo: 'Ayer',
        category: 'nutrition',
        isRead: true,
      ),
      NotificationItemData(
        id: '6',
        title: 'Actualización del Sistema',
        message: 'Se han optimizado las gráficas de progreso y se añadió la armoniosa transición de Modo Oscuro.',
        timeAgo: 'Hace 2 días',
        category: 'system',
        isRead: true,
      ),
    ];
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Todas las notificaciones marcadas como leídas'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppTheme.darkGreen,
      ),
    );
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((item) => item.id == id);
    });
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'water':
        return Icons.water_drop_outlined;
      case 'nutrition':
        return Icons.restaurant_outlined;
      case 'achievement':
        return Icons.emoji_events_outlined;
      case 'system':
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'water':
        return AppTheme.waterBlue;
      case 'nutrition':
        return AppTheme.primaryGreen;
      case 'achievement':
        return const Color(0xFFF39C12);
      case 'system':
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filteredNotifications = _notifications.where((n) {
      if (_selectedFilter == 'Todas') return true;
      if (_selectedFilter == 'Nutrición' && n.category == 'nutrition') return true;
      if (_selectedFilter == 'Agua' && n.category == 'water') return true;
      if (_selectedFilter == 'Logros' && n.category == 'achievement') return true;
      return false;
    }).toList();

    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        leading: CircleAvatar(
          backgroundColor: isDark ? const Color(0xFF1E2721) : AppTheme.softGray,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: 'Notificaciones',
        actions: [
          if (unreadCount > 0)
            IconButton(
              icon: Icon(Icons.done_all, color: theme.colorScheme.primary),
              tooltip: 'Marcar todo como leído',
              onPressed: _markAllAsRead,
            )
          else
            const SizedBox(width: 48),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: ['Todas', 'Nutrición', 'Agua', 'Logros'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : (isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimary),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selectedColor: theme.colorScheme.primary,
                    checkmarkColor: Colors.white,
                    backgroundColor: isDark ? const Color(0xFF1A231E) : Colors.white,
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : (isDark ? const Color(0xFF2C3E50) : const Color(0xFFE5E7EB)),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                );
              }).toList(),
            ),
          ),

          // Notifications List
          Expanded(
            child: filteredNotifications.isEmpty
                ? Center(
                    child: FadeInWidget(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E2721) : AppTheme.softGray,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.notifications_off_outlined,
                              size: 64,
                              color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Sin Notificaciones',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No tienes notificaciones en esta categoría.',
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final item = filteredNotifications[index];
                      return Padding(
                        key: ValueKey(item.id),
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Dismissible(
                          key: Key(item.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: AppTheme.accentRed,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
                          ),
                          onDismissed: (direction) {
                            _deleteNotification(item.id);
                          },
                          child: InfoCard(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category Icon
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(item.category).withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _getCategoryIcon(item.category),
                                    color: _getCategoryColor(item.category),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.title,
                                              style: theme.textTheme.titleMedium?.copyWith(
                                                fontWeight: item.isRead ? FontWeight.w600 : FontWeight.w800,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          if (!item.isRead)
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.primary,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.message,
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: item.isRead
                                              ? (isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary)
                                              : (isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimary),
                                          fontWeight: item.isRead ? FontWeight.w400 : FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.timeAgo,
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontSize: 11,
                                          color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Fade in animation helper for clean empty state
class FadeInWidget extends StatefulWidget {
  final Widget child;
  const FadeInWidget({super.key, required this.child});

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: widget.child,
    );
  }
}
