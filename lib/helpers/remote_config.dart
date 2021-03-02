import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _URL = "base_url";

class RemoteConfigService {
  final RemoteConfig _remoteConfig;

  final defaults = <String, dynamic>{
    _URL: 'AppBase Url',
  };
  static RemoteConfigService _instance;

  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance =
          RemoteConfigService(remoteConfig: await RemoteConfig.instance);
    }
    return _instance;
  }

  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  String get getBaseUrl => _remoteConfig.getString(_URL);

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print('Remote config fetch throttled: $exception');
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch();
    await _remoteConfig.activateFetched();

    print('URL: $getBaseUrl');
  }
}
