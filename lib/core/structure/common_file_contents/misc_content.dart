const String initWarning = '''
Project initialized using easy_init_cli.

ALERT!!! Do not delete this file !!!
if you delete this file then some commands won't work properly


If you wanted to change architecture pattern;
 > Remove all folders and files from lib folder.
 > Remove this file from root folder. 
 > Run 'easy init' command again''';

const navigationExtContent = '''
import 'package:flutter/material.dart';


extension AppNavigationExt on BuildContext {

  void push(Widget nextScreen) {
    Navigator.of(this).push(MaterialPageRoute(
      builder: (context) => nextScreen,
    ));
  }

  void pushReplacement(Widget nextScreen) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
      builder: (context) => nextScreen,
    ));
  }

  void pushAndRemoveUntil(Widget nextScreen) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => false,
    );
  }

  void popScreen() {
    Navigator.of(this).pop();
  }
}


''';

const dateExtContent = '''
import 'package:intl/intl.dart';

extension DateExt on DateTime {
  ///[hhMMa] will format DateTime to String in 'hh:mm:a'
  ///
  ///----------
  ///```
  /// //example
  ///final time=DateTime.now().hhMMa;
  ///print(time);//10:20 am
  ///```
  String get hhMMa => DateFormat('hh:mm a').format(this);

  ///[dMMMyOrTY] will convert DateTime to String in '12 May 2024' format
  ///or 'Today' or 'Yesterday' based on the date
  ///
  ///----------
  ///```
  /// //example
  ///final converted=DateTime.now().dMMMyOrTY;
  ///print(converted);//Today
  ///```
  String get dMMMyOrTY {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compDt = DateTime(year, month, day);
    final difference = today.difference(compDt).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('d MMM, y').format(this);
    }
  }

  ///[yyyyMmDdWithDash] will convert DateTime to String in "2024-05-05" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().yyyyMmDdWithDash;
  ///print(dateString);//2024-08-05
  ///```
  String get yyyyMmDdWithDash => DateFormat('yyyy-MM-dd').format(this);

  ///[yyyMmDdWithSlash] will convert DateTime to String in "2024/05/05" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().yyyyMmDdWithSlash;
  ///print(dateString);//2024/08/05
  ///```
  String get yyyMmDdWithSlash => DateFormat('yyyy/MM/dd').format(this);

  ///[formatAsDdMMMyyy] will convert DateTime to String in "10 Apr, 2024" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().formatAsDdMMMyyy;
  ///print(dateString);// 10 Apr, 2024
  ///```
  String get formatAsDdMMMyyy => DateFormat('d MMM, yyyy').format(this);
}

''';

const stringExtContent = '''

extension StringExt on String {
  /// [capitalize] will make first letter capital of a string
  /// ```
  ///  //example
  /// final str="hello world"
  /// final strConverted=str.capitalize
  /// print(strConverted);//Hello world
  /// ```
  String get capitalize =>
      isNotEmpty ? "\${this[0].toUpperCase()}\${substring(1)}" : "";
}
''';

const themeExtContent = '''
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// [TextThemeExt] - A custom extension on `BuildContext` to access
/// TextStyle easily with build context
extension TextThemeExt on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;

  TextStyle displayLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displayLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle displayMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displayMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle displaySmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displaySmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodyLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodyLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodyMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodyMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodySmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodySmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);
}


extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  ///
  ///[setThemeBasedColor] accepts two colors as parameters [darkThemeColor]
  ///and [lightThemeColor], if current app theme is Dark then [darkThemeColor]
  ///will return else [lightThemeColor] will return.
  ///```
  /// //Example
  /// ----------
  /// Container(
  ///   height:100,
  ///   width:100,
  ///   color:context.setThemeBasedColor(
  ///     darkThemeColor:Colors.white,
  ///     lightThemeColor:Colors.black,
  ///    ),
  ///   ),
  ///  // The color of container will be black if theme is Dark else white.
  /// ```
  Color? setThemeBasedColor(
      {required Color? darkThemeColor, required Color? lightThemeColor}) {
    bool isDarkTheme = Theme.of(this).brightness == Brightness.dark;
    if (isDarkTheme) {
      return darkThemeColor;
    } else {
      return lightThemeColor;
    }
  }

  AppColors? get appColors => Theme.of(this).extension<AppColors>();
}


''';

const numberExtContent = '''
import 'package:flutter/material.dart';

extension SpaceExt on num {
  SizedBox get verticalSpace => SizedBox(
        height: toDouble(),
      );
  SizedBox get horizontalSpace => SizedBox(
        width: toDouble(),
      );
}


''';

const extensionsContent = '''
export './date_ext.dart';
export './string_ext.dart';
export 'theme_ext.dart';
export './app_navigation_ext.dart';
export './number_ext.dart';
''';

const fcmServicesContent = '''
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmServices {
  //TODO:complete notification setup
  ///
  ///### init notification:
  /// call initNotifications() method to initialize notifications
  /// ```
  /// Example:
  /// Future<void> main()async{
  ///   await FcmServices.instance.initNotifications();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  ///  Warning:
  /// ----------------
  ///  - This code is just basic setup, you may need to add more
  ///    functionalities as per your requirement.
  ///  - FCM needs some setups in platform specific folders. You should do that
  ///    before using this code.
  ///  - The project should be connected with a firebase project and Cloud messaging
  ///    should be enabled in firebase.
  ///

  static FcmServices instance = FcmServices._internal();
  factory FcmServices() {
    return instance;
  }

  final firebaseMessaging = FirebaseMessaging.instance;
  final locaNotification = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    await _initFcm();
    await _initLocalNotifications();
  }

  Future<void> _initLocalNotifications() async {
    //Android settings
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); //TODO: change notification icon
    //IOS settings
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();
    //Initialization of local notification settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    locaNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        _handleMessage(message);
      },
    );
  }

  Future<void> _initFcm() async {
    //Sets the presentation options for Apple notifications when received in the foreground.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    //Showing notification when app in forground
    FirebaseMessaging.onMessage.listen(_showForgroundNotification);

    //Handle notification when app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);

    //Stream of event when open app from background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  ///To get FCM token for the firebase push notifications
  Future<String?> getFcmToken() async {
    final token = await firebaseMessaging.getToken();
    return token;
  }

  ///Handle messages
  void _handleMessage(RemoteMessage? message) {
    if (message != null) {
      //TODO: write code for handle message - Navigate to specific screen if needed
    }
  }

  ///handle forground message with local notifications
  Future<void> _showForgroundNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    locaNotification.show(
      message.hashCode,
      '\${message.notification?.title}',
      '\${message.notification?.body}',
      notificationDetails,
      payload: jsonEncode(message.toMap()),
    );
  }

  FcmServices._internal();
}

''';

const sharedPrefsServices = '''
import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsServices {
  ///TODO: modify the code as per the need
  ///
  /// ### initialize SharedPreferences
  /// ------------------------
  /// call initialize() method to initialize SharedPreferences instance
  ///
  /// ```
  /// Example:
  /// Future<void> main()async{
  ///   await SharedPrefsServices.instance.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///

  late SharedPreferences sharedPreferences;
  static SharedPrefsServices instance = SharedPrefsServices._internal();

  factory SharedPrefsServices() {
    return instance;
  }

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///------------------Sample  Set method--------------------------
  Future<bool> setValue(String token) async {
    return await sharedPreferences.setString(StorageKeys.key, token);
  }

  ///------------------Sample  Get methods-------------------------
  String? getValue() {
    return sharedPreferences.getString(StorageKeys.key);
  }

  Future<void> clearAll() async {
    await sharedPreferences.clear();
  }

  SharedPrefsServices._internal();
}

class StorageKeys {
  static const key = "key";
}

''';

const tokenHandler = '''
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';


class AuthTokens {
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expiryTime; // UTC DateTime when the access token expires

  AuthTokens({this.accessToken, this.refreshToken, this.expiryTime});

  // Check if both tokens are present
  bool get isValid => (accessToken != null && refreshToken != null);

  // Check if only the access token has expired.
  bool get isAccessTokenExpired {
    if (accessToken == null) {
      return true; // No access token means it's effectively expired/missing
    }
    // If expiryTime is null, we can't determine expiry, so consider it not expired
    // for this check, or adjust logic based on your API's behavior.
    return expiryTime != null && DateTime.now().toUtc().isAfter(expiryTime!);
  }

  @override
  String toString() {
    return 'AuthTokens('
        'accessToken: \${accessToken != null ? '****' : 'null'}, '
        'refreshToken: \${refreshToken != null ? '****' : 'null'}, '
        'expiryTime: \${expiryTime?.toIso8601String() ?? 'null'}'
        ')';
  }
}

// Manages the loading, saving, and in-memory caching of authentication tokens.
@lazySingleton
class TokenManager {
  // Use a singleton pattern to ensure only one instance of TokenManager exists.
  // This helps in centralizing token management.
  static final TokenManager instance = TokenManager._internal();

  factory TokenManager() {
    return instance;
  }

  TokenManager._internal();

  // The FlutterSecureStorage instance for secure persistence.
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Keys for storing tokens in secure storage.
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _expiryTimeKey = 'expiry_time'; // New key for expiry time

  // In-memory cache for the tokens.
  // This is where you'll store the tokens after the initial read.
  AuthTokens? _currentTokens;

  // Getter to access the current tokens from memory.
  AuthTokens? get currentTokens => _currentTokens;

  // Initializes the TokenManager by attempting to load tokens from secure storage.
  // This method should be called once, typically at app startup or when
  // your authentication service initializes.
  Future<void> initialize() async {
    _currentTokens = await _readTokensFromStorage();
  }

  // Reads the access and refresh tokens (and expiry time) from FlutterSecureStorage.
  // This operation is typically done only once during initialization.
  Future<AuthTokens> _readTokensFromStorage() async {
    try {
      final String? accessToken = await _secureStorage.read(
        key: _accessTokenKey,
      );
      final String? refreshToken = await _secureStorage.read(
        key: _refreshTokenKey,
      );
      final String? expiryTimeString = await _secureStorage.read(
        key: _expiryTimeKey,
      );

      DateTime? expiryTime;
      if (expiryTimeString != null) {
        try {
          expiryTime =
              DateTime.parse(expiryTimeString).toUtc(); // Parse and ensure UTC
        } catch (e) {
          rethrow;
        }
      }
      return AuthTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiryTime: expiryTime,
      );
    } catch (e) {
      return AuthTokens(); // Return empty tokens on error
    }
  }

  // Saves the given tokens (and expiry time) to FlutterSecureStorage and updates the in-memory cache.
  // This method should be called whenever new tokens are obtained (e.g., after login or refresh).
  Future<void> saveTokens(AuthTokens newTokens) async {
    _currentTokens = newTokens; // Update in-memory cache immediately
    try {
      if (newTokens.accessToken != null) {
        await _secureStorage.write(
          key: _accessTokenKey,
          value: newTokens.accessToken,
        );
      } else {
        await _secureStorage.delete(key: _accessTokenKey); // Clear if null
      }
      if (newTokens.refreshToken != null) {
        await _secureStorage.write(
          key: _refreshTokenKey,
          value: newTokens.refreshToken,
        );
      } else {
        await _secureStorage.delete(key: _refreshTokenKey); // Clear if null
      }
      if (newTokens.expiryTime != null) {
        // Store expiry time as ISO 8601 string (UTC)
        await _secureStorage.write(
          key: _expiryTimeKey,
          value: newTokens.expiryTime!.toIso8601String(),
        );
      } else {
        await _secureStorage.delete(key: _expiryTimeKey); // Clear if null
      }
    } catch (e) {
      rethrow;
    }
  }

  // This should be called on logout.
  Future<void> clearTokens() async {
    _currentTokens = null; // Clear in-memory cache
    try {
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await _secureStorage.delete(key: _expiryTimeKey); // Clear expiry time too
    } catch (e) {
      rethrow;
    }
  }
}
''';
