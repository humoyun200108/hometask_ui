import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hometask/models/user_model.dart';
import 'package:hometask/repository/user_repository.dart';

class Homeprovider extends ChangeNotifier {
  Homeprovider() {
    getUser();
  }
  UserRepository userRepository = UserRepository();
  String error = "";
  bool isLoading = false;
  Box<UserModel>? data;
  void getUser() async {
    isLoading = true;
    notifyListeners();
    await userRepository.getData().then((dynamic response) {
      if (response is Box<UserModel>) {
        isLoading = false;
        data = response;
        notifyListeners();
      } else {
        isLoading = false;
        error = response;
        notifyListeners();
      }
    });
  }

  void editElementTitle(int index, String newValue) async {
    await userRepository.editElement(index, newValue);
    notifyListeners();
  }

  void deleteElement(int index) async {
    await userRepository.deleteElement(index);
  }
}
