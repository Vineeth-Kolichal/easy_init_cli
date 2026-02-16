const String userModelContent = '''class UserRequest {
  final String? username;

  UserRequest({this.username});

  Map<String, dynamic> toJson() {
    return {'userName': username};
  }
}

class UserResponse {
  final String? message;
  final String? timestamp;
  final String? status;
  final ServerInfo? serverInfo;

  UserResponse({this.message, this.timestamp, this.status, this.serverInfo});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'],
      timestamp: json['timestamp'],
      status: json['status'],
      serverInfo: json['serverInfo'] != null
          ? ServerInfo.fromJson(json['serverInfo'])
          : null,
    );
  }
}

class ServerInfo {
  final String? platform;
  final double? uptime;

  ServerInfo({this.platform, this.uptime});

  factory ServerInfo.fromJson(Map<String, dynamic> json) {
    return ServerInfo(
      platform: json['platform'],
      uptime: (json['uptime'] as num?)?.toDouble(),
    );
  }
}
''';

const String cliDetailsModelContent = '''class CliDetailsResponse {
  final String? name;
  final String? latestVersion;
  final String? description;
  final String? homepage;
  final String? fetchedAt;

  CliDetailsResponse({
    this.name,
    this.latestVersion,
    this.description,
    this.homepage,
    this.fetchedAt,
  });

  factory CliDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CliDetailsResponse(
      name: json['name'],
      latestVersion: json['latestVersion'],
      description: json['description'],
      homepage: json['homepage'],
      fetchedAt: json['fetchedAt'],
    );
  }
}
''';

const String sampleDataSourceContent =
    '''import 'package:injectable/injectable.dart';
import '../../../../core/api_endpoints/api_endpoints.dart';
import '../../../../core/network/network_client.dart';
import '../../models/cli_details_model.dart';
import '../../models/user_model.dart';

abstract class SampleDataSource {
  Future<UserResponse> getUser(UserRequest request);
  Future<CliDetailsResponse> getCliDetails();
}

@LazySingleton(as: SampleDataSource)
@injectable
class SampleDataSourceImpl implements SampleDataSource {
  final NetworkClient client;

  SampleDataSourceImpl(this.client);

  @override
  Future<UserResponse> getUser(UserRequest request) async {
    try {
      final response = await client.post(
        path: ApiEndpoints.users,
        data: request.toJson(),
        requiresAuth: false,
      );
      return UserResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CliDetailsResponse> getCliDetails() async {
    try {
      final response = await client.get(
        path: ApiEndpoints.cliDetails,
        requiresAuth: false,
      );
      return CliDetailsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
''';

const String sampleRepositoryContent =
    '''import 'package:injectable/injectable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/network/network_exceptions.dart';

import '../../models/cli_details_model.dart';
import '../../models/user_model.dart';
import '../data_sources/sample_data_source.dart';

abstract class SampleRepository {
  Future<UserResponse> getUser(UserRequest request);
  Future<CliDetailsResponse> getCliDetails();
}

@LazySingleton(as: SampleRepository)
@injectable
class SampleRepositoryImpl implements SampleRepository {
  final SampleDataSource dataSource;

  SampleRepositoryImpl(this.dataSource);

  @override
  Future<UserResponse> getUser(UserRequest request) async {
    try {
      return await dataSource.getUser(request);
    } on CustomException catch (e) {
      throw Failure.apiRequestFailure(e.message);
    } catch (e) {
      throw Failure.unexpectedFailure("Something went wrong");
    }
  }

  @override
  Future<CliDetailsResponse> getCliDetails() async {
    try {
      return await dataSource.getCliDetails();
    } on CustomException catch (e) {
      throw Failure.apiRequestFailure(e.message);
    } catch (e) {
      throw Failure.unexpectedFailure("Something went wrong");
    }
  }
}
''';

const String sampleViewModelContent = '''import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../core/failures/failures.dart';
import '../models/cli_details_model.dart';
import '../models/user_model.dart';
import '../data/repositories/sample_repository_impl.dart';

@injectable
class SampleViewModel extends ChangeNotifier {
  final SampleRepository repository;

  SampleViewModel(this.repository);

  // User State
  UserResponse? _userResponse;
  UserResponse? get userResponse => _userResponse;

  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;

  String? _userError;
  String? get userError => _userError;

  // CLI Details State
  CliDetailsResponse? _cliDetails;
  CliDetailsResponse? get cliDetails => _cliDetails;

  bool _isCliLoading = false;
  bool get isCliLoading => _isCliLoading;

  String? _cliError;
  String? get cliError => _cliError;

  // Methods
  Future<void> fetchUser(String username) async {
    _isUserLoading = true;
    _userError = null;
    notifyListeners();

    try {
      final request = UserRequest(username: username);
      _userResponse = await repository.getUser(request);
    } on Failure catch (e) {
      _userError = e.error;
    } finally {
      _isUserLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCliDetails() async {
    _isCliLoading = true;
    _cliError = null;
    notifyListeners();

    try {
      _cliDetails = await repository.getCliDetails();
    } catch (e) {
      _cliError = e.toString();
    } finally {
      _isCliLoading = false;
      notifyListeners();
    }
  }

  void clearUserResponse() {
    _userResponse = null;
    notifyListeners();
  }
}
''';

const String headerSectionContent = '''import 'package:flutter/material.dart';
import '../../../../core/extensions/theme_ext.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: appColors?.primary?.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: appColors?.primary?.withValues(alpha: 0.3) ?? Colors.blue,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    appColors?.primary?.withValues(alpha: 0.3) ?? Colors.blue,
                blurRadius: 15,
                spreadRadius: -3,
              ),
            ],
          ),
          child: Icon(Icons.terminal, color: appColors?.primary, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          "easy_init_cli",
          style: context
              .headlineSmall(fontWeight: FontWeight.bold)
              .copyWith(letterSpacing: -0.5),
        ),
        const SizedBox(height: 4),
        Text(
          "PROJECT INITIALIZATION",
          style: context
              .labelSmall(
                color:
                    appColors?.primary?.withValues(alpha: 0.6) ?? Colors.grey,
                fontWeight: FontWeight.w500,
              )
              .copyWith(letterSpacing: 1.5),
        ),
      ],
    );
  }
}
''';

const String sampleScreenContent = '''import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/ui_utils/snack_bar.dart';
import '../../../../common/widgets/loading.dart';
import '../../models/user_model.dart';
import '../../../../core/theme/theme_service.dart';

import '../../../../common/widgets/generic_button.dart';
import '../../../../core/extensions/theme_ext.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../view_model/sample_view_model.dart';
import '../widgets/header_section.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  final TextEditingController _textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SampleViewModel>().fetchCliDetails();
    });
    final appColors = context.appColors;

    return Scaffold(
      body: Consumer<SampleViewModel>(
        builder: (context, sampleViewModel, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (sampleViewModel.userResponse != null) {
              _showGreetingDialog(context, sampleViewModel.userResponse!);
              sampleViewModel.clearUserResponse();
            }
            if (sampleViewModel.userError != null) {
              AppSnackBar.showSnackBar(
                context,
                message: sampleViewModel.userError!,
                isError: true,
              );
            }
            if (sampleViewModel.cliError != null) {
              AppSnackBar.showSnackBar(
                context,
                message: sampleViewModel.cliError!,
                isError: true,
              );
            }
          });
          return Loading(
            isLoading:
                sampleViewModel.isUserLoading || sampleViewModel.isCliLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Consumer<ThemeService>(
                                  builder: (context, themeService, child) {
                                    return IconButton(
                                      onPressed: () {
                                        themeService.toggleTheme();
                                      },
                                      icon: Icon(
                                        themeService.isDarkMode
                                            ? Icons.light_mode
                                            : Icons.dark_mode,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 64),
                              const HeaderSection(),

                              const SizedBox(height: 64),
                              CustomTextField(
                                controller: _textController,
                                hintText: "Enter Your Name",
                                label: "Developer Name",
                                primaryColor: appColors?.primary ?? Colors.blue,
                                onSurfaceColor:
                                    appColors?.primary ?? Colors.blue,
                                surfaceColor: Colors.transparent,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "This project is initialized with easy_init_cli. This sample feature demonstrates API call flow and UI styling. Once you understand the flow, you can remove this feature and start implementing your own.",
                                textAlign: TextAlign.center,
                                style: context.bodySmall(
                                  color: appColors?.subtext ?? Colors.grey,
                                ),
                              ),

                              // Bottom Actions
                            ],
                          ),
                        ),
                      ),
                    ),
                    GenericButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SampleViewModel>().fetchUser(
                            _textController.text,
                          );
                        }
                      },
                      text: "Get Started",
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'easy_init_cli : v\${sampleViewModel.cliDetails?.latestVersion ?? ''}',
                      style: context.bodySmall(color: appColors?.subtext),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  // ... Greeting helper methods
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  void _showGreetingDialog(BuildContext context, UserResponse data) {
    // ... dialog code
        final appColors = context.appColors;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appColors?.surfaceColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            _getGreeting(),
            style: context.headlineSmall(
              color: appColors?.primary ?? Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Message: \${data.message ?? 'No Message'}",
                style: context.bodyMedium(
                  color: appColors?.onSurface ?? Colors.black87,
                ),
              ),
              if (data.serverInfo != null) ...[
                const SizedBox(height: 8),
                Text(
                  "Server: \${data.serverInfo?.platform}",
                  style: context.labelSmall(
                    color: appColors?.subtext ?? Colors.grey,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: context.labelLarge(
                  color: appColors?.primary ?? Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
''';

const String snackBarContent = '''import 'package:flutter/material.dart';
import '../../core/extensions/theme_ext.dart';

class AppSnackBar {
  static void showSnackBar(
    BuildContext context, {
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    final appColors = context.appColors;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.bodyMedium(color: appColors?.kWhite ?? Colors.white),
        ),
        backgroundColor: isError
            ? (appColors?.errorRed ?? Colors.red)
            : Colors.green,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
''';
