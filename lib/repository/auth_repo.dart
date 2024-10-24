import 'package:crm_android/services/auth.services.dart';

class AuthRepo {
  final AuthServices authServices = AuthServices();

  Future<List> login({required String userId, required String password}) async {
    return await authServices.login(userId: userId, password: password);
  }
}
