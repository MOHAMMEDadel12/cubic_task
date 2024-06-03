import 'package:cubic_task/core/local_storage/shared_preference.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';

abstract class SharedLocalDataSource {
  clearAllData();
}

class SharedLocalDataSourceImplementation implements SharedLocalDataSource {
  @override
  clearAllData() {
    SharedPreference.clearLocalStorage();
  }
}
