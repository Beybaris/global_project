import 'package:global_project/service/datasource/auth_datasource.dart';

class AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepository(this._dataSource);

  Future<void> signIn(String email, String password) async {
    return _dataSource.signIn(email, password);
  }
}
