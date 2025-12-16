import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}

