import 'package:easy_init_cli/commands/create_feature/create_feature.dart';
import 'package:recase/recase.dart';

String mvvmDataSourceContent = '''
import 'package:injectable/injectable.dart';
import '../../../../core/network/network_client.dart';

abstract class ${CreateFeature.featureName.pascalCase}DataSource {
  // Future<void> exampleMethod();
}

@LazySingleton(as: ${CreateFeature.featureName.pascalCase}DataSource)
@injectable
class ${CreateFeature.featureName.pascalCase}DataSourceImpl implements ${CreateFeature.featureName.pascalCase}DataSource {
  final NetworkClient client;

  ${CreateFeature.featureName.pascalCase}DataSourceImpl(this.client);

  // @override
  // Future<void> exampleMethod() async {
  //   // TODO: implement exampleMethod
  // }
}
''';

String mvvmRepositoryContent = '''
abstract class ${CreateFeature.featureName.pascalCase}Repository {
  // Future<void> exampleMethod();
}
''';

String mvvmRepoImplContent = '''
import 'package:injectable/injectable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/network/network_exceptions.dart';
import '../data_sources/${CreateFeature.featureName.snakeCase}_data_source.dart';
import 'package:dartz/dartz.dart';

import '${CreateFeature.featureName.snakeCase}_repository.dart';

@LazySingleton(as: ${CreateFeature.featureName.pascalCase}Repository)
@injectable
class ${CreateFeature.featureName.pascalCase}RepositoryImpl implements ${CreateFeature.featureName.pascalCase}Repository {
  final ${CreateFeature.featureName.pascalCase}DataSource dataSource;

  ${CreateFeature.featureName.pascalCase}RepositoryImpl(this.dataSource);


  // @override
  // Future<void> exampleMethod() async {
  //   try {
  //     await dataSource.exampleMethod();
  //   } on CustomException catch (e) {
  //     throw Failure.apiRequestFailure(e.message);
  //   } catch (e) {
  //     throw Failure.unexpectedFailure("Something went wrong");
  //   }
  // }
}
''';

String mvvmViewModelContent = '''
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../data/repositories/${CreateFeature.featureName.snakeCase}_repository.dart';

@injectable
class ${CreateFeature.featureName.pascalCase}ViewModel extends ChangeNotifier {
  final ${CreateFeature.featureName.pascalCase}Repository repository;

  ${CreateFeature.featureName.pascalCase}ViewModel(this.repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // Future<void> exampleMethod() async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();
  //   try {
  //     await repository.exampleMethod();
  //   } catch (e) {
  //     _error = e.toString();
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
''';

String mvvmScreenContent = '''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/${CreateFeature.featureName.snakeCase}_view_model.dart';
import '../../../../core/dependency_injection/config/configure_injection.dart';

class ${CreateFeature.featureName.pascalCase}Screen extends StatelessWidget {
  const ${CreateFeature.featureName.pascalCase}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<${CreateFeature.featureName.pascalCase}ViewModel>(),
      child: const Scaffold(
        body: Center(
          child: Text('${CreateFeature.featureName.pascalCase} Screen'),
        ),
      ),
    );
  }
}
''';

String mvvmModelContent = '''
class ${CreateFeature.featureName.pascalCase}Model {
  // final String id;
  // ${CreateFeature.featureName.pascalCase}Model({required this.id});
  
  // factory ${CreateFeature.featureName.pascalCase}Model.fromJson(Map<String, dynamic> json) {
  //   return ${CreateFeature.featureName.pascalCase}Model(id: json['id']);
  // }
  
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //   };
  // }
}
''';
