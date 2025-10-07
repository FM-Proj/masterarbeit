import 'package:flutter/material.dart';

import 'misc.dart';

class ViatoleaTheme {
  static ThemeData getTheme() {
    var textTheme = TextTheme()
        .apply(
          fontFamily: 'Causten',
          bodyColor: ViatoleaColors.blackberryBlue,
          displayColor: ViatoleaColors.blackberryBlue,
        )
        .copyWith(
          // HEADLINE
          headlineLarge: TextStyle(
            fontFamily: 'Nordic',
            color: ViatoleaColors.sageGreen,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Nordic',
            color: ViatoleaColors.sageGreen,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Nordic',
            color: ViatoleaColors.sageGreen,
          ),

          // TITLE
          titleLarge: TextStyle(
            fontFamily: 'Nordic',
            color: ViatoleaColors.sageGreen,
            fontSize: 25,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Nordic',
            color: ViatoleaColors.sageGreen,
            fontSize: 22,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Nordic',
            color: ViatoleaColors.sageGreen,
            fontSize: 17,
          ),

          // BODY
          bodyLarge: TextStyle(fontSize: 19),
          bodyMedium: TextStyle(fontSize: 17),
          bodySmall: TextStyle(fontSize: 15),

          // LABEL
          labelLarge: TextStyle(fontSize: 17),
          labelMedium: TextStyle(fontSize: 15),
          labelSmall: TextStyle(),
        );
    final colorScheme = ColorScheme(
      //seedColor: Color.fromRGBO(138, 197, 144, 1),
      primary: ViatoleaColors.sageGreen,
      onPrimary: ViatoleaColors.mintGreen,
      primaryContainer: Color.fromRGBO(226, 241, 227, 1.0),
      onPrimaryContainer: ViatoleaColors.pistachioGreen,
      secondary: ViatoleaColors.pistachioGreen,
      onSecondary: ViatoleaColors.mintGreen,
      surface: Color.fromRGBO(255, 255, 255, 1),
      tertiary: ViatoleaColors.citrusYellow,
      onTertiary: ViatoleaColors.white,
      tertiaryContainer: Color.fromRGBO(255, 246, 203, 1.0),
      onTertiaryContainer: ViatoleaColors.blackberryBlue,
      brightness: Brightness.light,
      error: ViatoleaColors.strawberryRed,
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      onError: ViatoleaColors.mintGreen,
      onSurface: ViatoleaColors.blackberryBlue,
      outline: ViatoleaColors.sageGreen,
    );

    return ThemeData(
      fontFamily: 'Causten',
      scaffoldBackgroundColor: ViatoleaColors.mintGreen,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        shape: Border(
          bottom: BorderSide(color: ViatoleaColors.blackberryBlue, width: 1),
        ),
        color: ViatoleaColors.mintGreen,
        titleTextStyle: textTheme.titleMedium,
        iconTheme: IconThemeData(color: ViatoleaColors.sageGreen),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            StadiumBorder(side: BorderSide(color: colorScheme.primary)),
          ),
        ),
      ),
      textTheme: textTheme,
      iconTheme: IconThemeData(color: ViatoleaColors.sageGreen),
      cardTheme: CardThemeData(
        color: ViatoleaColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.all(Radius.circular(Paddings.S)),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedLabelStyle: textTheme.labelSmall?.copyWith(fontSize: 11),
        selectedLabelStyle: textTheme.labelSmall?.copyWith(fontSize: 13),
        enableFeedback: true,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.tertiaryContainer,
        padding: EdgeInsets.all(Paddings.S),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Paddings.S),
            bottomRight: Radius.circular(Paddings.S),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: ViatoleaColors.white,
        titleTextStyle: textTheme.titleSmall,
        contentPadding: const EdgeInsets.symmetric(horizontal: Paddings.S),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.all(Radius.circular(Paddings.S)),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primaryContainer,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: textTheme.bodyMedium,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Paddings.S)),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Paddings.S)),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: Paddings.M),
        childrenPadding: const EdgeInsets.all(0),
        backgroundColor: colorScheme.surface,
      ),
      colorScheme: colorScheme,
    );
  }
}

extension ViatoleaColors on Colors {
  static Color get pistachioGreen => const Color.fromRGBO(138, 197, 144, 1);

  static Color get sageGreen => const Color.fromRGBO(110, 138, 106, 1);

  static Color get mintGreen => const Color.fromRGBO(241, 248, 242, 1);

  static Color get citrusYellow => const Color.fromRGBO(255, 221, 48, 1);

  static Color get strawberryRed => const Color.fromRGBO(234, 55, 68, 1);

  static Color get waterBlue => const Color.fromRGBO(120, 205, 251, 1);

  static Color get grapeDarkness => const Color.fromRGBO(75, 32, 44, 1);

  static Color get plumViolet => const Color.fromRGBO(107, 70, 94, 1);

  static Color get blackberryBlue => const Color.fromRGBO(29, 38, 43, 1);

  static Color get white => const Color.fromRGBO(255, 255, 255, 1);

  static Color get black => const Color.fromRGBO(0, 0, 0, 1);
}
