String apiEndpointContent = '''
class ApiEndpoints {
  static String baseUrl = "";
}
''';

String usecaseContent = '''
import 'package:dartz/dartz.dart';
import '../failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
''';
