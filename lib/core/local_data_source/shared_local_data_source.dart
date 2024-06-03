import 'package:cubic_task/core/local_storage/shared_preference.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';

abstract class SharedLocalDataSource {
  /// Save Active Workspace ID In Local Storage
  Future<bool> saveActiveWorkspaceIDInLocalStorage(
      {required String activeWorkspaceID});



  clearAllData();
}

class SharedLocalDataSourceImplementation implements SharedLocalDataSource {
  /// Save Active Workspace ID In Local Storage
  @override
  Future<bool> saveActiveWorkspaceIDInLocalStorage(
      {required String activeWorkspaceID}) async {
    SharedText.activeWorkspaceID = activeWorkspaceID;
    return await SharedPreference.setActiveWorkspaceID(activeWorkspaceID);
  }



  @override
  clearAllData() {
    SharedPreference.clearLocalStorage();
  }
}
