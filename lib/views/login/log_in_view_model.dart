// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_shoe_app/app/app.router.dart';
import 'package:flutter_shoe_app/core/services/api/api_service.dart';
import 'package:flutter_shoe_app/core/services/navigation/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../core/services/api/api_service.dart';
import '../application/application_view_model.dart';
import '../home/homepage_view.dart';

class LoginViewModel extends ChangeNotifier {
  bool isObscure = true;

  final NavigationService navigationService = locator<NavigationService>();

  void changeObscure() {
    isObscure = isObscure == false ? true : false;
    notifyListeners();
  }

  //handle google signin
  final ApiService apiService = locator<ApiService>();
  bool isLogged = false;

  Future<void> signInGoogle(BuildContext context) async {
    isLogged = false;
    notifyListeners();
    try {
      await apiService.googleSignIn();
      isLogged = true;
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return ViewModelBuilder<ApplicationViewModel>.reactive(
            disposeViewModel: false,
            viewModelBuilder: () => Provider.of<ApplicationViewModel>(context),
            builder: (context, viewModel, child) {
              return const HomepageView();
            });
      }));
    } catch (e) {
      // ScaffoldMessenger.of(Get.context!)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
      throw 'Logged Canceled by User';
    }
  }

  //route to homepage
  Future<void> toHomepage() async {
    await navigationService.pushNamed(Routes.HomepageView);
  }

  //facebook login
  Future<void> loginFacebook(BuildContext context) async {
    isLogged = false;
    notifyListeners();
    try {
      await apiService.facebookLogin();
      // toHomepage();
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return ViewModelBuilder<ApplicationViewModel>.reactive(
            disposeViewModel: false,
            viewModelBuilder: () => Provider.of<ApplicationViewModel>(context),
            builder: (context, viewModel, child) {
              return HomepageView();
            });
      }));
    } catch (e) {
      rethrow;
    }
  }

  //login with fields
  TextEditingController emailFieldController = TextEditingController(),
      passwordFieldController = TextEditingController();
  Future<void> loginFields(
      String email, String password, BuildContext context) async {
    try {
      await apiService.signInWithFields(email, password);
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return ViewModelBuilder<ApplicationViewModel>.reactive(
            disposeViewModel: false,
            viewModelBuilder: () => Provider.of<ApplicationViewModel>(context),
            builder: (context, viewModel, child) {
              return HomepageView();
            });
      }));
    } catch (e) {
      //rethrow;
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(
                'Invalid Login!',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              actions: [
                Center(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        const Color(0xff14FC24).withOpacity(0.7),
                      )),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Center(
                          child: Text(
                        'Got It!',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff1F2732)),
                      )),
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }
}
