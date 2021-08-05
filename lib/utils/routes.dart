import 'package:flutter/material.dart';



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
  // IofRouter.serverError: (context) => ServerErrorPage(),
  // IofRouter.login: (context) => LoginPage(),
  // IofRouter.forgotPassword: (context) => ForgotPasswordPage(),
  // IofRouter.selectScanner: (context) => ScannerSelectionPage(),
  // IofRouter.settingsMenu: (context) => SettingsMenu(),
  // IofRouter.companySettingsMenu: (context) => SetCompanyDetailsPage(),

};