import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/screens/home_screen.dart';
import 'package:mm_proyecto_final/screens/diary_screen.dart';
import 'package:mm_proyecto_final/screens/progress_screen.dart';
import 'package:mm_proyecto_final/screens/profile_screen.dart';
import 'package:mm_proyecto_final/screens/settings_screen.dart';
import 'package:mm_proyecto_final/screens/splash_screen.dart';
import 'package:mm_proyecto_final/widgets/custom_bottom_nav.dart';

// MODELS

class MacroNutrients {
  final double protein;
  final double carbs;
  final double fats;

  const MacroNutrients({
    required this.protein,
    required this.carbs,
    required this.fats,
  });
}

class FoodItem {
  final String name;
  final String quantity;
  final int kcal;
  final String imageUrl;
  final MacroNutrients macros;

  const FoodItem({
    required this.name,
    required this.quantity,
    required this.kcal,
    required this.imageUrl,
    required this.macros,
  });
}

class MealSection {
  final String type;
  final List<FoodItem> items;
  final int totalKcal;

  const MealSection({
    required this.type,
    required this.items,
    required this.totalKcal,
  });
}

class User {
  final String name;
  final int age;
  final int heightCm;
  final double weightKg;
  final double goalWeightKg;
  final int dailyProteinGoal;
  final DateTime memberSince;
  final String avatarUrl;

  const User({
    required this.name,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.goalWeightKg,
    required this.dailyProteinGoal,
    required this.memberSince,
    required this.avatarUrl,
  });
}

class DailyLog {
  int caloriesConsumed;
  int caloriesGoal;
  double waterLiters;
  double waterGoal;
  double proteinG;
  double proteinGoal;
  double carbsG;
  double carbsGoal;

  DailyLog({
    required this.caloriesConsumed,
    required this.caloriesGoal,
    required this.waterLiters,
    required this.waterGoal,
    required this.proteinG,
    required this.proteinGoal,
    required this.carbsG,
    required this.carbsGoal,
  });
}

class WeeklyStats {
  final List<double> waterTrend;
  final List<int> nutritionConsistency;

  const WeeklyStats({
    required this.waterTrend,
    required this.nutritionConsistency,
  });
}

class AppSettings {
  bool waterReminders;
  bool darkMode;
  bool useOz;

  AppSettings({
    this.waterReminders = true,
    this.darkMode = false,
    this.useOz = false,
  });
}

// ============================================================
// MOCK DATA
// ============================================================

class MockData {
  static final User user = User(
    name: 'Michael Quintero',
    age: 28,
    heightCm: 170,
    weightKg: 65,
    goalWeightKg: 62,
    dailyProteinGoal: 120,
    memberSince: DateTime(2023),
    avatarUrl: 'https://i.pravatar.cc/300?img=11',
  );

  static final DailyLog dailyLog = DailyLog(
    caloriesConsumed: 1450,
    caloriesGoal: 2000,
    waterLiters: 1.8,
    waterGoal: 2.5,
    proteinG: 45,
    proteinGoal: 120,
    carbsG: 110,
    carbsGoal: 250,
  );

  static final List<MealSection> meals = [
    const MealSection(
      type: 'Desayuno',
      items: [
        FoodItem(
          name: 'Avena con Bayas',
          quantity: '1 bol (250g)',
          kcal: 210,
          imageUrl:
              'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=150&h=150&fit=crop',
          macros: MacroNutrients(protein: 6, carbs: 36, fats: 4),
        ),
        FoodItem(
          name: 'Café Solo',
          quantity: '1 taza (8 oz)',
          kcal: 5,
          imageUrl:
              'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=150&h=150&fit=crop',
          macros: MacroNutrients(protein: 0, carbs: 1, fats: 0),
        ),
      ],
      totalKcal: 350,
    ),
    const MealSection(
      type: 'Almuerzo',
      items: [
        FoodItem(
          name: 'Ensalada de Pollo a la Parrilla',
          quantity: '1 plato',
          kcal: 410,
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=150&h=150&fit=crop',
          macros: MacroNutrients(protein: 35, carbs: 12, fats: 18),
        ),
      ],
      totalKcal: 410,
    ),
    const MealSection(
      type: 'Cena',
      items: [],
      totalKcal: 0,
    ),
  ];

  static const WeeklyStats weeklyStats = WeeklyStats(
    waterTrend: [1.2, 1.8, 1.5, 2.5, 3.0, 2.4, 2.8],
    nutritionConsistency: [60, 80, 75, 90, 80, 50, 30],
  );

  static const FoodItem featuredFood = FoodItem(
    name: 'Bol de Granos con Aguacate y Camote Rostizado',
    quantity: '1 plato',
    kcal: 450,
    imageUrl:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&h=400&fit=crop',
    macros: MacroNutrients(protein: 28, carbs: 52, fats: 18),
  );
}

// ============================================================
// APP CONTROLLER
// ============================================================

class AppController extends ChangeNotifier {
  AppController() {
    _dailyLog = DailyLog(
      caloriesConsumed: MockData.dailyLog.caloriesConsumed,
      caloriesGoal: MockData.dailyLog.caloriesGoal,
      waterLiters: MockData.dailyLog.waterLiters,
      waterGoal: MockData.dailyLog.waterGoal,
      proteinG: MockData.dailyLog.proteinG,
      proteinGoal: MockData.dailyLog.proteinGoal,
      carbsG: MockData.dailyLog.carbsG,
      carbsGoal: MockData.dailyLog.carbsGoal,
    );
  }

  late DailyLog _dailyLog;
  final User _user = MockData.user;
  final List<MealSection> _meals = List<MealSection>.from(MockData.meals);
  final WeeklyStats _weeklyStats = MockData.weeklyStats;
  final AppSettings _settings = AppSettings();

  int _selectedNavIndex = 0;

  // Getters
  User get currentUser => _user;
  DailyLog get todayLog => _dailyLog;
  List<MealSection> get meals => _meals;
  WeeklyStats get weeklyStats => _weeklyStats;
  AppSettings get settings => _settings;
  int get selectedNavIndex => _selectedNavIndex;

  void navigateTo(int index) {
    if (_selectedNavIndex == index) return;
    _selectedNavIndex = index;
    notifyListeners();
  }

  void addWater(double amount) {
    _dailyLog.waterLiters = (_dailyLog.waterLiters + amount).clamp(0, 10);
    notifyListeners();
  }

  void toggleWaterReminders(bool value) {
    _settings.waterReminders = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _settings.darkMode = value;
    notifyListeners();
  }

  void toggleUnits(bool value) {
    _settings.useOz = value;
    notifyListeners();
  }
}

// ============================================================
// APP CONTROLLER SCOPE
// ============================================================

class AppControllerScope extends InheritedNotifier<AppController> {
  const AppControllerScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static AppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppControllerScope>();
    assert(scope != null, 'No AppControllerScope found in context');
    return scope!.notifier!;
  }
}

// ============================================================
// THEME
// ============================================================

class AppTheme {
  static const Color primaryGreen = Color(0xFF2ECC71);
  static const Color darkGreen = Color(0xFF1A8C4A);
  static const Color backgroundMint = Color(0xFFF0F9F4);
  static const Color cardWhite = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color waterBlue = Color(0xFF3498DB);
  static const Color waterLight = Color(0xFFEBF5FB);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color softGray = Color(0xFFF3F4F6);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundMint,
      primaryColor: primaryGreen,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: waterBlue,
        surface: cardWhite,
        error: accentRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          height: 1.2,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          height: 1.2,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: Color(0xFFE5E7EB)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardWhite,
        selectedItemColor: primaryGreen,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        elevation: 8,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE5E7EB),
        thickness: 1,
        space: 1,
      ),
    );
  }
}

// ============================================================
// MAIN APP
// ============================================================

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutritionism',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final AppController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AppController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppControllerScope(
      notifier: _controller,
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: AppTheme.backgroundMint,
            body: IndexedStack(
              index: _controller.selectedNavIndex,
              children: const [
                HomeScreen(),
                DiaryScreen(),
                ProgressScreen(),
                ProfileScreen(),
                SettingsScreen(),
              ],
            ),
            bottomNavigationBar: CustomBottomNav(
              currentIndex: _controller.selectedNavIndex,
              onTap: _controller.navigateTo,
            ),
          );
        },
      ),
    );
  }
}
