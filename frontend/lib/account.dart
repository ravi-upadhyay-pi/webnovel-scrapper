import 'package:grpc/grpc.dart';

import 'generated/user_account.pbgrpc.dart';

class UserAccountService {
  final userAccountClient = UserAccountClient(ClientChannel(""));
  String? token;

  Future<UserDetails?> getUserDetails() async {
    if (token == null) {
      return null;
    }
    return await userAccountClient
        .getUserDetails(AuthenticationToken(token: token));
  }

  void saveToken(String token) {
    this.token = token;
  }
}
