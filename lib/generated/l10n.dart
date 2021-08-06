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

  /// `Information`
  String get bottom_information_title {
    return Intl.message(
      'Information',
      name: 'bottom_information_title',
      desc: '',
      args: [],
    );
  }

  /// `About Homary,Reviews,Rewards Program,Privacy Policy,Terms & Conditions`
  String get bottom_information_list {
    return Intl.message(
      'About Homary,Reviews,Rewards Program,Privacy Policy,Terms & Conditions',
      name: 'bottom_information_list',
      desc: '',
      args: [],
    );
  }

  /// `Customer Service`
  String get bottom_customer_title {
    return Intl.message(
      'Customer Service',
      name: 'bottom_customer_title',
      desc: '',
      args: [],
    );
  }

  /// `Help & FAQs,Returns & Refunds,Shipping Guide,Financing`
  String get bottom_customer_list {
    return Intl.message(
      'Help & FAQs,Returns & Refunds,Shipping Guide,Financing',
      name: 'bottom_customer_list',
      desc: '',
      args: [],
    );
  }

  /// `B2B Programs`
  String get bottom_b2b_title {
    return Intl.message(
      'B2B Programs',
      name: 'bottom_b2b_title',
      desc: '',
      args: [],
    );
  }

  /// `Trade Program,Affiliate Program`
  String get bottom_b2b_list {
    return Intl.message(
      'Trade Program,Affiliate Program',
      name: 'bottom_b2b_list',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get bottom_contact_title {
    return Intl.message(
      'Contact Us',
      name: 'bottom_contact_title',
      desc: '',
      args: [],
    );
  }

  /// `Email us:|Call us:|Mail us:`
  String get bottom_contact_label {
    return Intl.message(
      'Email us:|Call us:|Mail us:',
      name: 'bottom_contact_label',
      desc: '',
      args: [],
    );
  }

  /// `service@homary.com|+1-888-903-3332 (toll-free within US)|4501 E Airport Dr. Unit B`
  String get bottom_contact_content {
    return Intl.message(
      'service@homary.com|+1-888-903-3332 (toll-free within US)|4501 E Airport Dr. Unit B',
      name: 'bottom_contact_content',
      desc: '',
      args: [],
    );
  }

  /// `service@b2b.homary.com (B2B inquiry)|24-hour Monday through Sunday|Ontario, California 91761 United States`
  String get bottom_contact_introduction {
    return Intl.message(
      'service@b2b.homary.com (B2B inquiry)|24-hour Monday through Sunday|Ontario, California 91761 United States',
      name: 'bottom_contact_introduction',
      desc: '',
      args: [],
    );
  }

  /// `LOG IN`
  String get login_signIn {
    return Intl.message(
      'LOG IN',
      name: 'login_signIn',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get login_email {
    return Intl.message(
      'Email Address',
      name: 'login_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_password {
    return Intl.message(
      'Password',
      name: 'login_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get login_emailError {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'login_emailError',
      desc: '',
      args: [],
    );
  }

  /// `Your password is incorrect.`
  String get login_passwordError {
    return Intl.message(
      'Your password is incorrect.',
      name: 'login_passwordError',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Your Password?`
  String get login_forget {
    return Intl.message(
      'Forgot Your Password?',
      name: 'login_forget',
      desc: '',
      args: [],
    );
  }

  /// `Quick Access With`
  String get login_quickAccessWith {
    return Intl.message(
      'Quick Access With',
      name: 'login_quickAccessWith',
      desc: '',
      args: [],
    );
  }

  /// `CREATE AN ACCOUNT`
  String get register_btn {
    return Intl.message(
      'CREATE AN ACCOUNT',
      name: 'register_btn',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get register_title {
    return Intl.message(
      'SIGN UP',
      name: 'register_title',
      desc: '',
      args: [],
    );
  }

  /// `Follow us to receive exclusive offers and our latest news`
  String get register_followTips {
    return Intl.message(
      'Follow us to receive exclusive offers and our latest news',
      name: 'register_followTips',
      desc: '',
      args: [],
    );
  }

  /// `By registering, you agree to our `
  String get register_agreeTips {
    return Intl.message(
      'By registering, you agree to our ',
      name: 'register_agreeTips',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Cookie Policy`
  String get register_privacy {
    return Intl.message(
      'Privacy & Cookie Policy',
      name: 'register_privacy',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get register_agreeTipsAnd {
    return Intl.message(
      ' and ',
      name: 'register_agreeTipsAnd',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions.`
  String get register_terms {
    return Intl.message(
      'Terms & Conditions.',
      name: 'register_terms',
      desc: '',
      args: [],
    );
  }

  /// `Password length should not be less than 8 characters, it need to include letters and numbers.`
  String get register_passwordError {
    return Intl.message(
      'Password length should not be less than 8 characters, it need to include letters and numbers.',
      name: 'register_passwordError',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetpassword_title {
    return Intl.message(
      'Reset Password',
      name: 'resetpassword_title',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get resetpassword_forget {
    return Intl.message(
      'Forgot Password',
      name: 'resetpassword_forget',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we will send you a link.`
  String get resetpassword_tip {
    return Intl.message(
      'Enter your email address and we will send you a link.',
      name: 'resetpassword_tip',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get resetpassword_continue {
    return Intl.message(
      'CONTINUE',
      name: 'resetpassword_continue',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Email`
  String get resetpassword_check {
    return Intl.message(
      'Check Your Email',
      name: 'resetpassword_check',
      desc: '',
      args: [],
    );
  }

  /// `We've sent a message to the email address `
  String get resetpassword_checkTip1 {
    return Intl.message(
      'We\'ve sent a message to the email address ',
      name: 'resetpassword_checkTip1',
      desc: '',
      args: [],
    );
  }

  /// ` you have on file with us. Please follow the instructions provided in the message to reset your password.`
  String get resetpassword_checkTip2 {
    return Intl.message(
      ' you have on file with us. Please follow the instructions provided in the message to reset your password.',
      name: 'resetpassword_checkTip2',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the mail from us?`
  String get resetpassword_remind1 {
    return Intl.message(
      'Didn\'t receive the mail from us?',
      name: 'resetpassword_remind1',
      desc: '',
      args: [],
    );
  }

  /// `Check your bulk or junk email folder.`
  String get resetpassword_remind2 {
    return Intl.message(
      'Check your bulk or junk email folder.',
      name: 'resetpassword_remind2',
      desc: '',
      args: [],
    );
  }

  /// `If you still can't find it, click `
  String get resetpassword_remind3 {
    return Intl.message(
      'If you still can\'t find it, click ',
      name: 'resetpassword_remind3',
      desc: '',
      args: [],
    );
  }

  /// `support center`
  String get resetpassword_supportCenter {
    return Intl.message(
      'support center',
      name: 'resetpassword_supportCenter',
      desc: '',
      args: [],
    );
  }

  /// ` for help`
  String get resetpassword_remind4 {
    return Intl.message(
      ' for help',
      name: 'resetpassword_remind4',
      desc: '',
      args: [],
    );
  }

  /// `HOME`
  String get resetpassword_Home {
    return Intl.message(
      'HOME',
      name: 'resetpassword_Home',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
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