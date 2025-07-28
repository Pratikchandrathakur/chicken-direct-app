import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the meat ordering application.
class AppTheme {
  AppTheme._();

  // Warm Professional Palette - Earth-toned colors for food industry trust
  static const Color primaryLight = Color(0xFF8B4513); // Warm brown
  static const Color primaryVariantLight = Color(0xFF654321); // Darker brown
  static const Color secondaryLight = Color(0xFFD2691E); // Supporting orange
  static const Color secondaryVariantLight =
      Color(0xFFB8860B); // Dark goldenrod
  static const Color accentLight = Color(0xFF228B22); // Forest green
  static const Color backgroundLight = Color(0xFFFAFAFA); // Soft off-white
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure white
  static const Color errorLight = Color(0xFFDC143C); // Clear crimson
  static const Color warningLight = Color(0xFFFF8C00); // Amber
  static const Color successLight = Color(0xFF32CD32); // Bright green
  static const Color textPrimaryLight = Color(0xFF2C2C2C); // Dark gray
  static const Color textSecondaryLight = Color(0xFF666666); // Medium gray

  static const Color primaryDark = Color(0xFFD2691E); // Orange for dark theme
  static const Color primaryVariantDark = Color(0xFF8B4513); // Brown variant
  static const Color secondaryDark = Color(0xFF228B22); // Forest green
  static const Color secondaryVariantDark = Color(0xFF32CD32); // Bright green
  static const Color accentDark = Color(0xFFD2691E); // Orange accent
  static const Color backgroundDark = Color(0xFF121212); // Dark background
  static const Color surfaceDark = Color(0xFF1E1E1E); // Dark surface
  static const Color errorDark = Color(0xFFFF6B6B); // Lighter red for dark
  static const Color warningDark = Color(0xFFFFB347); // Lighter amber
  static const Color successDark = Color(0xFF90EE90); // Light green
  static const Color textPrimaryDark = Color(0xFFE0E0E0); // Light gray
  static const Color textSecondaryDark = Color(0xFFB0B0B0); // Medium light gray

  // Card and dialog colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2D2D);
  static const Color dialogLight = Color(0xFFFFFFFF);
  static const Color dialogDark = Color(0xFF2D2D2D);

  // Shadow colors - Subtle elevation with maximum 4dp values
  static const Color shadowLight = Color(0x0F000000);
  static const Color shadowDark = Color(0x1FFFFFFF);

  // Divider colors - Minimal 1px borders
  static const Color dividerLight = Color(0x1F2C2C2C);
  static const Color dividerDark = Color(0x1FE0E0E0);

  /// Light theme with Contemporary Functional Minimalism
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryLight,
          onPrimary: Colors.white,
          primaryContainer: primaryVariantLight,
          onPrimaryContainer: Colors.white,
          secondary: secondaryLight,
          onSecondary: Colors.white,
          secondaryContainer: secondaryVariantLight,
          onSecondaryContainer: Colors.white,
          tertiary: accentLight,
          onTertiary: Colors.white,
          tertiaryContainer: accentLight.withValues(alpha: 0.1),
          onTertiaryContainer: accentLight,
          error: errorLight,
          onError: Colors.white,
          surface: surfaceLight,
          onSurface: textPrimaryLight,
          onSurfaceVariant: textSecondaryLight,
          outline: dividerLight,
          outlineVariant: dividerLight.withValues(alpha: 0.5),
          shadow: shadowLight,
          scrim: shadowLight,
          inverseSurface: surfaceDark,
          onInverseSurface: textPrimaryDark,
          inversePrimary: primaryDark),
      scaffoldBackgroundColor: backgroundLight,
      cardColor: cardLight,
      dividerColor: dividerLight,

      // AppBar theme for professional trust
      appBarTheme: AppBarTheme(
          backgroundColor: surfaceLight,
          foregroundColor: textPrimaryLight,
          elevation: 2.0,
          shadowColor: shadowLight,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textPrimaryLight)),

      // Card theme with subtle elevation
      cardTheme: CardTheme(
          color: cardLight,
          elevation: 2.0,
          shadowColor: shadowLight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation for mobile-first design
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceLight,
          selectedItemColor: primaryLight,
          unselectedItemColor: textSecondaryLight,
          elevation: 4.0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // Conditional Action Buttons - Dynamic FloatingActionButton
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: accentLight,
          foregroundColor: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes for mobile interaction
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: BorderSide(color: primaryLight, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w500))),

      // Typography with mobile-optimized fonts
      textTheme: _buildTextTheme(isLight: true),

      // Form elements with focused states and clear boundaries
      inputDecorationTheme: InputDecorationTheme(
          fillColor: surfaceLight,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: dividerLight, width: 1.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: dividerLight, width: 1.0)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: primaryLight, width: 2.0)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorLight, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorLight, width: 2.0)),
          labelStyle: GoogleFonts.inter(color: textSecondaryLight, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textSecondaryLight.withValues(alpha: 0.7), fontSize: 16, fontWeight: FontWeight.w400),
          prefixIconColor: textSecondaryLight,
          suffixIconColor: textSecondaryLight),

      // Interactive elements with haptic feedback support
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight;
        }
        return Colors.grey[300];
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight.withValues(alpha: 0.3);
        }
        return Colors.grey[200];
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return accentLight;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(Colors.white),
          side: BorderSide(color: dividerLight, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight;
        }
        return textSecondaryLight;
      })),

      // Progress indicators for loading states
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryLight, linearTrackColor: primaryLight.withValues(alpha: 0.2), circularTrackColor: primaryLight.withValues(alpha: 0.2)),

      // Quantity stepper integration
      sliderTheme: SliderThemeData(activeTrackColor: secondaryLight, thumbColor: secondaryLight, overlayColor: secondaryLight.withValues(alpha: 0.2), inactiveTrackColor: secondaryLight.withValues(alpha: 0.3), trackHeight: 4.0, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0)),

      // Tab navigation
      tabBarTheme: TabBarTheme(labelColor: primaryLight, unselectedLabelColor: textSecondaryLight, indicatorColor: primaryLight, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),

      // Tooltips for accessibility
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryLight.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8.0)), textStyle: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // Snackbar for notifications
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryLight, contentTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: secondaryLight, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),

      // Bottom sheet theme for adaptive bottom sheets
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: surfaceLight, elevation: 4.0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)))), dialogTheme: DialogThemeData(backgroundColor: dialogLight));

  /// Dark theme with warm professional palette adapted for dark mode
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryDark,
          onPrimary: Colors.black,
          primaryContainer: primaryVariantDark,
          onPrimaryContainer: Colors.white,
          secondary: secondaryDark,
          onSecondary: Colors.white,
          secondaryContainer: secondaryVariantDark,
          onSecondaryContainer: Colors.black,
          tertiary: accentDark,
          onTertiary: Colors.black,
          tertiaryContainer: accentDark.withValues(alpha: 0.2),
          onTertiaryContainer: accentDark,
          error: errorDark,
          onError: Colors.black,
          surface: surfaceDark,
          onSurface: textPrimaryDark,
          onSurfaceVariant: textSecondaryDark,
          outline: dividerDark,
          outlineVariant: dividerDark.withValues(alpha: 0.5),
          shadow: shadowDark,
          scrim: shadowDark,
          inverseSurface: surfaceLight,
          onInverseSurface: textPrimaryLight,
          inversePrimary: primaryLight),
      scaffoldBackgroundColor: backgroundDark,
      cardColor: cardDark,
      dividerColor: dividerDark,
      appBarTheme: AppBarTheme(
          backgroundColor: surfaceDark,
          foregroundColor: textPrimaryDark,
          elevation: 2.0,
          shadowColor: shadowDark,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textPrimaryDark)),
      cardTheme: CardTheme(
          color: cardDark,
          elevation: 2.0,
          shadowColor: shadowDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceDark,
          selectedItemColor: primaryDark,
          unselectedItemColor: textSecondaryDark,
          elevation: 4.0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: accentDark,
          foregroundColor: Colors.black,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: BorderSide(color: primaryDark, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w500))),
      textTheme: _buildTextTheme(isLight: false),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: surfaceDark,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: dividerDark, width: 1.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: dividerDark, width: 1.0)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: primaryDark, width: 2.0)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorDark, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorDark, width: 2.0)),
          labelStyle: GoogleFonts.inter(color: textSecondaryDark, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textSecondaryDark.withValues(alpha: 0.7), fontSize: 16, fontWeight: FontWeight.w400),
          prefixIconColor: textSecondaryDark,
          suffixIconColor: textSecondaryDark),
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark;
        }
        return Colors.grey[600];
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark.withValues(alpha: 0.3);
        }
        return Colors.grey[700];
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return accentDark;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(Colors.black),
          side: BorderSide(color: dividerDark, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark;
        }
        return textSecondaryDark;
      })),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryDark, linearTrackColor: primaryDark.withValues(alpha: 0.2), circularTrackColor: primaryDark.withValues(alpha: 0.2)),
      sliderTheme: SliderThemeData(activeTrackColor: secondaryDark, thumbColor: secondaryDark, overlayColor: secondaryDark.withValues(alpha: 0.2), inactiveTrackColor: secondaryDark.withValues(alpha: 0.3), trackHeight: 4.0, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0)),
      tabBarTheme: TabBarTheme(labelColor: primaryDark, unselectedLabelColor: textSecondaryDark, indicatorColor: primaryDark, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryDark.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8.0)), textStyle: GoogleFonts.inter(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryDark, contentTextStyle: GoogleFonts.inter(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: secondaryDark, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: surfaceDark, elevation: 4.0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)))), dialogTheme: DialogThemeData(backgroundColor: dialogDark));

  /// Helper method to build text theme with mobile-optimized typography
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textPrimary = isLight ? textPrimaryLight : textPrimaryDark;
    final Color textSecondary =
        isLight ? textSecondaryLight : textSecondaryDark;

    return TextTheme(
        // Headings: Inter (500, 600, 700) - Mobile readability for product names
        displayLarge: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: -0.5),
        displayMedium: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: -0.25),
        displaySmall: GoogleFonts.inter(
            fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),
        headlineLarge: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0.15),
        headlineMedium: GoogleFonts.inter(
            fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
        headlineSmall: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w500, color: textPrimary),
        titleLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0.15),
        titleMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.1),
        titleSmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.1),

        // Body: Inter (400, 500) - Optimized for product descriptions
        bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: 0.25,
            height: 1.5),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: 0.25,
            height: 1.4),
        bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textSecondary,
            letterSpacing: 0.4,
            height: 1.3),

        // Labels: Inter (400, 500) - For delivery details and pricing
        labelLarge: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.1),
        labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondary,
            letterSpacing: 0.5),
        labelSmall: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: textSecondary,
            letterSpacing: 0.5));
  }

  /// Helper method to get data text style for quantities and pricing
  static TextStyle getDataTextStyle({
    required bool isLight,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    final Color textColor = isLight ? textPrimaryLight : textPrimaryDark;
    return GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        letterSpacing: 0.25);
  }

  /// Helper method to get caption text style for small details
  static TextStyle getCaptionTextStyle({
    required bool isLight,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    final Color textColor = isLight ? textSecondaryLight : textSecondaryDark;
    return GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        letterSpacing: 0.4);
  }
}
