import 'package:flutter/material.dart';
import 'package:screen_util_test/modules/auth/login_page.dart';
import 'package:screen_util_test/modules/forgot_password/forgot_password_page.dart';
import 'package:screen_util_test/modules/scanner/scanner_selection_page.dart';
import 'package:screen_util_test/modules/shared/server_error/server_error_page.dart';



class IofRouter {
  static const String serverError = '/server-error';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String selectScanner = '/select-scanner';
  static const String settingsMenu = '/settings-menu';
  static const String companySettingsMenu = '/set-company-detail';
}

const String iofLandingPage = IofRouter.selectScanner;

var stmRoutes = <String, WidgetBuilder> {
  IofRouter.serverError: (context) => ServerErrorPage(),
  IofRouter.login: (context) => LoginPage(),
  IofRouter.forgotPassword: (context) => ForgotPasswordPage(),
  IofRouter.selectScanner: (context) => ScannerSelectionPage(),
  // IofRouter.settingsMenu: (context) => SettingsMenu(),
  // IofRouter.companySettingsMenu: (context) => SetCompanyDetailsPage(),

};