import 'package:mobx/mobx.dart';
part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool isLoading = false;
  @observable
  int signUpIndex = 0;
  @action
  void setLoading(bool val) => isLoading = val;
}
