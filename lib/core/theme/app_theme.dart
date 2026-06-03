// lib/core/theme/app_theme.dart
//
// StudySpark — Complete Material 3 theme configuration.
// Two themes: SparkLight (warm cream & violet) + SparkDark (deep navy & electric blue).
// Built on FlexColorScheme for advanced surface tinting and component overrides.

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// ─── Brand Colour Tokens ────────────────────────────────────────────────────
///
/// All raw hex values live here so the rest of the app only imports [AppColors].
abstract final class AppColors {
  // ── Primary (Electric Violet) ──
  static const primary = Color(0xFF6C4FF8);        // vibrant brand violet
  static const primaryContainer = Color(0xFFECE8FF);
  static const onPrimaryContainer = Color(0xFF1E004E);

  // ── Secondary (Sky Teal) ──
  static const secondary = Color(0xFF00BFAE);
  static const secondaryContainer = Color(0xFFD0F5F2);

  // ── Tertiary (Sunset Orange) ──
  static const tertiary = Color(0xFFFF6B3D);
  static const tertiaryContainer = Color(0xFFFFE5DA);

  // ── Error ──
  static const error = Color(0xFFE53935);

  // ── Surface (light) ──
  static const surfaceLight = Color(0xFFFAF8FF);
  static const backgroundLight = Color(0xFFF3F0FA);

  // ── Surface (dark) ──
  static const surfaceDark = Color(0xFF12101E);    // deep midnight
  static const backgroundDark = Color(0xFF0D0B17);

  // ── Neutrals ──
  static const neutral10 = Color(0xFF1A1625);
  static const neutral20 = Color(0xFF2D2840);
  static const neutral30 = Color(0xFF3F3A55);
  static const neutral60 = Color(0xFF8F8AAA);
  static const neutral90 = Color(0xFFE8E5F0);
  static const neutral99 = Color(0xFFFCFBFF);

  // ── Semantic / Chart Palette ──
  static const chartBlue   = Color(0xFF4C9DFF);
  static const chartGreen  = Color(0xFF2ED47A);
  static const chartAmber  = Color(0xFFFFB547);
  static const chartPink   = Color(0xFFFF6B9D);
  static const chartPurple = Color(0xFFAF7FFF);

  // ── Subject Tag Colors ──
  static const List<Color> subjectPalette = [
    Color(0xFF6C4FF8), // violet
    Color(0xFF00BFAE), // teal
    Color(0xFFFF6B3D), // orange
    Color(0xFF4C9DFF), // blue
    Color(0xFF2ED47A), // green
    Color(0xFFFFB547), // amber
    Color(0xFFFF6B9D), // pink
    Color(0xFFAF7FFF), // lavender
  ];
}

/// ─── Typography Scale ────────────────────────────────────────────────────────
///
/// Display/headline → Sora (geometric, modern)
/// Body/label       → DM Sans (highly legible)
abstract final class AppTypography {
  static TextTheme get textTheme {
    final sora = GoogleFonts.soraTextTheme();
    final dmSans = GoogleFonts.dmSansTextTheme();

    return TextTheme(
      // Display — splash screens, hero numbers
      displayLarge:  sora.displayLarge!.copyWith(
        fontSize: 57, fontWeight: FontWeight.w700, letterSpacing: -1.5,
      ),
      displayMedium: sora.displayMedium!.copyWith(
        fontSize: 45, fontWeight: FontWeight.w700, letterSpacing: -1,
      ),
      displaySmall:  sora.displaySmall!.copyWith(
        fontSize: 36, fontWeight: FontWeight.w600, letterSpacing: -0.5,
      ),
      // Headline — screen titles
      headlineLarge:  sora.headlineLarge!.copyWith(
        fontSize: 32, fontWeight: FontWeight.w700,
      ),
      headlineMedium: sora.headlineMedium!.copyWith(
        fontSize: 28, fontWeight: FontWeight.w600,
      ),
      headlineSmall:  sora.headlineSmall!.copyWith(
        fontSize: 24, fontWeight: FontWeight.w600,
      ),
      // Title — card titles, section headers
      titleLarge:  dmSans.titleLarge!.copyWith(
        fontSize: 22, fontWeight: FontWeight.w600,
      ),
      titleMedium: dmSans.titleMedium!.copyWith(
        fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.1,
      ),
      titleSmall:  dmSans.titleSmall!.copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1,
      ),
      // Body — default content text
      bodyLarge:  dmSans.bodyLarge!.copyWith(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15,
      ),
      bodyMedium: dmSans.bodyMedium!.copyWith(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25,
      ),
      bodySmall:  dmSans.bodySmall!.copyWith(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,
      ),
      // Label — buttons, chips, captions
      labelLarge:  dmSans.labelLarge!.copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1,
      ),
      labelMedium: dmSans.labelMedium!.copyWith(
        fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5,
      ),
      labelSmall:  dmSans.labelSmall!.copyWith(
        fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5,
      ),
    );
  }
}

/// ─── Component Shape Tokens ──────────────────────────────────────────────────
abstract final class AppShapes {
  static const extraSmall = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );
  static const small = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
  static const medium = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static const large = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );
  static const extraLarge = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(28)),
  );
  static const full = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
  );

  // Border-radius values for use in Container/ClipRRect
  static const r4  = BorderRadius.all(Radius.circular(4));
  static const r8  = BorderRadius.all(Radius.circular(8));
  static const r12 = BorderRadius.all(Radius.circular(12));
  static const r16 = BorderRadius.all(Radius.circular(16));
  static const r20 = BorderRadius.all(Radius.circular(20));
  static const r24 = BorderRadius.all(Radius.circular(24));
  static const r28 = BorderRadius.all(Radius.circular(28));
  static const r32 = BorderRadius.all(Radius.circular(32));
}

/// ─── Spacing System (8pt grid) ───────────────────────────────────────────────
abstract final class AppSpacing {
  static const double xs2 = 2;
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 12;
  static const double lg  = 16;
  static const double xl  = 20;
  static const double xl2 = 24;
  static const double xl3 = 32;
  static const double xl4 = 40;
  static const double xl5 = 48;
  static const double xl6 = 56;
  static const double xl7 = 64;

  // Screen horizontal padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets cardPadding   = EdgeInsets.all(16);
}

/// ─── Elevation / Shadow Tokens ───────────────────────────────────────────────
abstract final class AppShadows {
  static List<BoxShadow> sm(Color color) => [
    BoxShadow(color: color.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2)),
  ];

  static List<BoxShadow> md(Color color) => [
    BoxShadow(color: color.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 4)),
    BoxShadow(color: color.withOpacity(0.06), blurRadius: 6,  offset: const Offset(0, 1)),
  ];

  static List<BoxShadow> lg(Color color) => [
    BoxShadow(color: color.withOpacity(0.16), blurRadius: 32, offset: const Offset(0, 8)),
    BoxShadow(color: color.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 2)),
  ];

  static List<BoxShadow> glow(Color color) => [
    BoxShadow(color: color.withOpacity(0.35), blurRadius: 20, offset: Offset.zero),
    BoxShadow(color: color.withOpacity(0.15), blurRadius: 40, offset: Offset.zero),
  ];
}

/// ─── Animation Durations ─────────────────────────────────────────────────────
abstract final class AppDurations {
  static const fastest  = Duration(milliseconds: 100);
  static const fast     = Duration(milliseconds: 200);
  static const normal   = Duration(milliseconds: 300);
  static const slow     = Duration(milliseconds: 500);
  static const slowest  = Duration(milliseconds: 800);
}

/// ─── Main Theme Factory ──────────────────────────────────────────────────────
///
/// [AppTheme.light] and [AppTheme.dark] return fully configured [ThemeData].
/// Both are built with FlexColorScheme then post-processed with component-level
/// overrides for Cards, NavigationBar, FAB, InputDecoration, etc.
abstract final class AppTheme {
  // ── Light Theme ──────────────────────────────────────────────────────────
  static ThemeData get light {
    final base = FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary:          AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        secondary:        AppColors.secondary,
        secondaryContainer: AppColors.secondaryContainer,
        tertiary:         AppColors.tertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        appBarColor:      AppColors.surfaceLight,
        error:            AppColors.error,
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 9,
      useMaterial3: true,
      appBarStyle: FlexAppBarStyle.surface,
      scaffoldBackground: AppColors.backgroundLight,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      textTheme: AppTypography.textTheme,
      primaryTextTheme: AppTypography.textTheme,
      fontFamily: GoogleFonts.dmSans().fontFamily,
      typography: Typography.material2021(),
    );
    return _applyComponentThemes(base, isDark: false);
  }

  // ── Dark Theme ───────────────────────────────────────────────────────────
  static ThemeData get dark {
    final base = FlexThemeData.dark(
      colors: FlexSchemeColor(
        primary:          AppColors.primary,
        primaryContainer: AppColors.neutral20,
        secondary:        AppColors.secondary,
        secondaryContainer: const Color(0xFF004D47),
        tertiary:         AppColors.tertiary,
        tertiaryContainer: const Color(0xFF4D2010),
        appBarColor:      AppColors.surfaceDark,
        error:            AppColors.error,
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      useMaterial3: true,
      darkIsTrueBlack: false,
      appBarStyle: FlexAppBarStyle.surface,
      scaffoldBackground: AppColors.backgroundDark,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      textTheme: AppTypography.textTheme,
      primaryTextTheme: AppTypography.textTheme,
      fontFamily: GoogleFonts.dmSans().fontFamily,
      typography: Typography.material2021(),
    );
    return _applyComponentThemes(base, isDark: true);
  }

  // ── Component-level overrides ─────────────────────────────────────────────
  static ThemeData _applyComponentThemes(ThemeData base, {required bool isDark}) {
    final cs = base.colorScheme;

    return base.copyWith(
      // ── App Bar ──
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.textTheme.titleLarge!.copyWith(
          color: cs.onSurface, fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: cs.onSurface),
      ),

      // ── Card ──
      cardTheme: CardTheme(
        elevation: 0,
        shape: AppShapes.large,
        color: cs.surface,
        surfaceTintColor: cs.primary,
        margin: EdgeInsets.zero,
      ) as CardThemeData?,

      // ── Navigation Bar (bottom) ──
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 72,
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent,
        indicatorColor: cs.primaryContainer,
        indicatorShape: AppShapes.medium.copyWith(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final style = AppTypography.textTheme.labelSmall!;
          if (states.contains(WidgetState.selected)) {
            return style.copyWith(color: cs.primary, fontWeight: FontWeight.w700);
          }
          return style.copyWith(color: cs.onSurfaceVariant);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: cs.onPrimaryContainer, size: 24);
          }
          return IconThemeData(color: cs.onSurfaceVariant, size: 24);
        }),
      ),

      // ── Floating Action Button ──
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: AppShapes.extraLarge,
        extendedTextStyle: AppTypography.textTheme.labelLarge!.copyWith(
          color: cs.onPrimary, letterSpacing: 0.5,
        ),
      ),

      // ── Filled Button ──
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: AppShapes.medium,
          minimumSize: const Size(64, 48),
          textStyle: AppTypography.textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // ── Outlined Button ──
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: AppShapes.medium,
          minimumSize: const Size(64, 48),
          textStyle: AppTypography.textTheme.labelLarge,
          side: BorderSide(color: cs.outlineVariant),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // ── Text Button ──
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: AppShapes.medium,
          textStyle: AppTypography.textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),

      // ── Chip ──
      chipTheme: ChipThemeData(
        shape: AppShapes.full,
        elevation: 0,
        pressElevation: 0,
        labelStyle: AppTypography.textTheme.labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        backgroundColor: cs.surfaceContainerHighest,
        selectedColor: cs.primaryContainer,
        checkmarkColor: cs.primary,
      ),

      // ── Input Decoration ──
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? AppColors.neutral20.withOpacity(0.6)
            : AppColors.neutral90.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: AppShapes.r12,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppShapes.r12,
          borderSide: BorderSide(color: cs.outlineVariant.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppShapes.r12,
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppShapes.r12,
          borderSide: BorderSide(color: cs.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: AppTypography.textTheme.bodyMedium!.copyWith(color: cs.onSurfaceVariant),
        hintStyle: AppTypography.textTheme.bodyMedium!.copyWith(color: cs.onSurfaceVariant.withOpacity(0.6)),
        prefixIconColor: cs.onSurfaceVariant,
        suffixIconColor: cs.onSurfaceVariant,
      ),

      // ── Dialog ──
      dialogTheme: DialogTheme(
        elevation: 0,
        backgroundColor: cs.surface,
        surfaceTintColor: cs.primary,
        shape: AppShapes.extraLarge,
        titleTextStyle: AppTypography.textTheme.headlineSmall!.copyWith(
          color: cs.onSurface,
        ),
        contentTextStyle: AppTypography.textTheme.bodyMedium!.copyWith(
          color: cs.onSurfaceVariant,
        ),
      ) as DialogThemeData?,

      // ── Bottom Sheet ──
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        backgroundColor: cs.surface,
        surfaceTintColor: cs.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        modalBackgroundColor: cs.surface,
      ),

      // ── Snack Bar ──
      snackBarTheme: SnackBarThemeData(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: AppShapes.medium,
        backgroundColor: isDark ? AppColors.neutral20 : AppColors.neutral10,
        contentTextStyle: AppTypography.textTheme.bodyMedium!.copyWith(
          color: Colors.white,
        ),
        actionTextColor: AppColors.secondary,
      ),

      // ── Switch ──
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return cs.onPrimary;
          return cs.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return cs.primary;
          return cs.surfaceContainerHighest;
        }),
      ),

      // ── Divider ──
      dividerTheme: DividerThemeData(
        color: cs.outlineVariant.withOpacity(0.5),
        thickness: 1,
        space: 1,
      ),

      // ── Progress Indicator ──
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: cs.primary,
        linearTrackColor: cs.primaryContainer,
        circularTrackColor: cs.primaryContainer,
        linearMinHeight: 6,
        borderRadius: BorderRadius.circular(3),
      ),

      // ── List Tile ──
      listTileTheme: ListTileThemeData(
        shape: AppShapes.medium,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        titleTextStyle: AppTypography.textTheme.bodyLarge,
        subtitleTextStyle: AppTypography.textTheme.bodySmall!.copyWith(
          color: cs.onSurfaceVariant,
        ),
        leadingAndTrailingTextStyle: AppTypography.textTheme.labelMedium,
        iconColor: cs.onSurfaceVariant,
      ),

      // ── Tab Bar ──
      tabBarTheme: TabBarTheme(
        labelStyle: AppTypography.textTheme.labelLarge,
        unselectedLabelStyle: AppTypography.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        labelColor: cs.primary,
        unselectedLabelColor: cs.onSurfaceVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: cs.primary, width: 3),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
        ),
        overlayColor: WidgetStateProperty.all(cs.primary.withOpacity(0.08)),
      ) as TabBarThemeData?,
    );
  }

  // ── Helper: colorScheme seed-based gradient ─────────────────────────────
  static LinearGradient primaryGradient(ColorScheme cs) => LinearGradient(
    colors: [cs.primary, cs.tertiary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient surfaceGradient(ColorScheme cs, {bool isDark = false}) =>
      LinearGradient(
        colors: isDark
            ? [AppColors.surfaceDark, AppColors.backgroundDark]
            : [AppColors.surfaceLight, AppColors.backgroundLight],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
