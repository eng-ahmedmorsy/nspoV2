import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  // Private constructor
  RemoteConfigService._privateConstructor();

  // Singleton instance
  static final RemoteConfigService _instance = RemoteConfigService._privateConstructor();

  // Getter for the instance
  static RemoteConfigService get instance => _instance;

  // Variable to store the value
  late String apiURL;
  late String version;

  // Method to initialize and fetch the value
  Future<void> initialize() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 5),
    ));
    await remoteConfig.fetchAndActivate();

    apiURL = remoteConfig.getString('API_URL').trim();
    print(apiURL);
    print(apiURL);
    print(apiURL);
    print(apiURL);
    version = remoteConfig.getString('VERSION').trim();
  }
}
