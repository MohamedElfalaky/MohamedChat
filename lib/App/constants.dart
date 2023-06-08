import 'package:flutter/material.dart';

/// vars with fixed values
class Constants {
  /// colors
  static const Color secondAppColor = Color(0xFFFAB753);
  static const Color primaryAppColor = Color(0xFF0085A5);
  static const Color mainFontColor = Color(0xFF000816);
  static const Color fontHintColor = Color(0xFFB0B0B0);
  static const Color fontErrorColor = Color(0xFFB00020);
  static const Color fontSuccessColor = Color(0xFF00C853);
  static const Color fontWarningColor = Color(0xFFFFAB00);
  static const Color secondaryFontColor = Color(0xFF444444);
  static const Color prefixContainerColor = Color(0xFFEEEEEE);
  static const Color outLineColor = Color(0xFFBDBDBD);

  static const Color whiteAppColor = Color(0xFFFFFFFF);

  // fonts
  static const String mainFont = 'Cairo';

  static const TextStyle headerNavigationFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 18,
    color: mainFontColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle mainTitleFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 16,
    color: mainFontColor,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle mainTitleRegularFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 16,
    color: mainFontColor,
  );

  static const TextStyle secondaryTitleFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 14,
    color: mainFontColor,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle secondaryTitleRegularFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 14,
    color: mainFontColor,
  );
  static const TextStyle subtitleFont1 = TextStyle(
    fontFamily: mainFont,
    fontSize: 14,
    color: secondaryFontColor,
  );

  static const TextStyle subtitleFontBold = TextStyle(
    fontFamily: mainFont,
    fontSize: 12,
    color: mainFontColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 12,
    color: mainFontColor,
  );

  static const TextStyle subtitleRegularFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 12,
    color: secondaryFontColor,
  );

  static const TextStyle subtitleRegularFontHint = TextStyle(
    fontFamily: mainFont,
    fontSize: 12,
    color: fontHintColor,
  );

// TextFieldInputs
  static InputDecoration setTextInputDecoration(
      {Widget? prefixIcon,
      Widget? suffixIcon,
      Color? prefixColor,
      Color? suffixColor,
      Color? borderColor,
      Color? fillColor,
      bool? withPadding,
      String? hintText}) {
    return InputDecoration(
        errorStyle: Constants.subtitleFont1.copyWith(
          color: Colors.red,
        ),
        prefixIcon: withPadding == true
            ? Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 12, end: 6, top: 10, bottom: 10),
                child: prefixIcon,
              )
            : prefixIcon,
        prefixIconColor: prefixColor,
        suffixIconColor: suffixColor,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(4),
          child: suffixIcon,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: const OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(
            color: Color(0xff808488),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: mainFont,
          fontSize: 12,
          color: fontHintColor,
        ));
  }

// TextFieldInputs
  static InputDecoration setRegistrationTextInputDecoration(
      {Widget? prefixIcon,
      Widget? suffixIcon,
      Color? prefixColor,
      Color? suffixColor,
      Color? borderColor,
      Color? fillColor,
      bool? isParagraph,
      String? hintText}) {
    return InputDecoration(
        errorStyle: Constants.subtitleFont1.copyWith(
          color: Colors.red,
        ),
        prefixIcon: isParagraph == true
            ? SizedBox(
                height: 140,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 12, end: 6, top: 10, bottom: 10),
                      child: Container(
                        width: 30,
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    width: 1, color: Color(0xFFBDBDBD)))),
                        margin: const EdgeInsetsDirectional.only(end: 8),
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: prefixIcon,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 12, end: 6, top: 10, bottom: 10),
                child: Container(
                  width: 30,
                  decoration: const BoxDecoration(
                      border: Border(
                          left:
                              BorderSide(width: 1, color: Color(0xFFBDBDBD)))),
                  margin: const EdgeInsetsDirectional.only(end: 8),
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: prefixIcon,
                ),
              ),
        prefixIconColor: prefixColor,
        suffixIconColor: suffixColor,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(4),
          child: suffixIcon,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: const OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(
            color: Color(0xff808488),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: mainFont,
          fontSize: 12,
          color: fontHintColor,
        ));
  }

  /// strings

  /// integers

  // static final defaultPinTheme = PinTheme(
  //   width: 70,
  //   height: 70,
  //   textStyle: const TextStyle(
  //       fontSize: 20,
  //       color: Color.fromRGBO(30, 60, 87, 1),
  //       fontWeight: FontWeight.w600),
  //   decoration: BoxDecoration(
  //     border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
  //     borderRadius: BorderRadius.circular(20),
  //   ),
  // );

  // static final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  //   border: Border.all(color: const Color(0xFF0085A5)),
  //   borderRadius: BorderRadius.circular(20),
  // );

  // static final submittedPinTheme = defaultPinTheme.copyWith(
  //   decoration: defaultPinTheme.decoration!.copyWith(
  //     color: const Color.fromRGBO(234, 239, 243, 1),
  //   ),
  // );

  // static final errorPinTheme = defaultPinTheme.copyWith(
  //   decoration: defaultPinTheme.decoration!.copyWith(
  //     border: Border.all(color: Colors.red),
  //   ),
  // );
}
