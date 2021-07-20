// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Localization Demo`
  String get title {
    return Intl.message(
      'Localization Demo',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Button`
  String get button {
    return Intl.message(
      'Button',
      name: 'button',
      desc: '',
      args: [],
    );
  }

  /// `This is the Drawer`
  String get drawer_tip {
    return Intl.message(
      'This is the Drawer',
      name: 'drawer_tip',
      desc: '',
      args: [],
    );
  }

  /// `Close Drawer 123`
  String get close_drawer {
    return Intl.message(
      'Close Drawer 123',
      name: 'close_drawer',
      desc: '',
      args: [],
    );
  }

  /// `Get`
  String get HomePage_ServiceIcon1 {
    return Intl.message(
      'Get',
      name: 'HomePage_ServiceIcon1',
      desc: '',
      args: [],
    );
  }

  /// `Free Shipping`
  String get HomePage_ServiceIcon2 {
    return Intl.message(
      'Free Shipping',
      name: 'HomePage_ServiceIcon2',
      desc: '',
      args: [],
    );
  }

  /// `30-Day Return`
  String get HomePage_ServiceIcon3 {
    return Intl.message(
      '30-Day Return',
      name: 'HomePage_ServiceIcon3',
      desc: '',
      args: [],
    );
  }

  /// `Recommend For You`
  String get HomePage_recommendTitle {
    return Intl.message(
      'Recommend For You',
      name: 'HomePage_recommendTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}