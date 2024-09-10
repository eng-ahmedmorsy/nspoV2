import 'package:local_auth/local_auth.dart';
// ···

class BiometricsService {
  static Future<bool> authenticate() async {

    try{
      final LocalAuthentication auth = LocalAuthentication();

      bool isDeviceSupported = await auth.isDeviceSupported();

      if (!isDeviceSupported) {
        return true;
      }

      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'من فضلك قم بتحقق من هويتك',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));

      return didAuthenticate;

    } catch (e) {
      return true;
    }

  }
}
