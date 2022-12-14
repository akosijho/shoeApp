import 'package:flutter/material.dart';
import 'package:flutter_shoe_app/app/app.router.dart';
import 'package:flutter_shoe_app/resources/assets/icons/svg_icons.dart';
import 'package:flutter_shoe_app/views/login/log_in_view_model.dart';
import 'package:flutter_shoe_app/views/widgets/circular_%20progress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        builder: (context, viewModel, child) {
          if (viewModel.isBusy) {
            return CircularProgress();
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Container(
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 34,
                            ),
                            Center(
                              child: Image.asset(
                                'lib/resources/assets/images/logo_shoes.jpg',
                                height: 129.0,
                                width: 127.0,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20),
                            ),
                            const Text(
                              'ShoeApp',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(24, 5, 16, 16),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(32)),
                              width: MediaQuery.of(context).size.width,
                              child: SizedBox(
                                width: 320,
                                height: 38,
                                child: TextFormField(
                                  controller: viewModel.emailFieldController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.mail),
                                    contentPadding:
                                        EdgeInsets.only(top: 4, left: 4),
                                    hintStyle: TextStyle(),
                                    hintText: "Email:",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(24, 5, 16, 16),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(32)),
                              width: MediaQuery.of(context).size.width,
                              child: SizedBox(
                                width: 320,
                                height: 38,
                                child: TextFormField(
                                  controller: viewModel.passwordFieldController,
                                  obscureText:
                                      viewModel.isObscure ? true : false,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: const Padding(
                                        padding:
                                            EdgeInsets.only(top: 0, right: 10),
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        viewModel.changeObscure();
                                      },
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(top: 4, left: 4),
                                    hintText: "Password:",
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            const Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: 20, bottom: 10),
                                  child: Text(
                                    'Forgot password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                )),
                            InkWell(
                              onTap: () {
                                viewModel.loginFields(
                                  viewModel.emailFieldController.text,
                                  viewModel.passwordFieldController.text,
                                );
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12)),
                                padding:
                                    const EdgeInsets.fromLTRB(50, 20, 50, 16),
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                    child: Text(
                                  'LOG IN',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                viewModel.navigationService.pushNamed(
                                    Routes.Register,
                                    arguments: LoginRegisterArguments());
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 0, right: 20),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            InkWell(
                              onTap: () {
                                viewModel.signInGoogle();
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4, left: 20),
                                        child: SvgPicture.asset(
                                            SvgIcons.googleIcon),
                                      ),
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'GOOGLE',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                viewModel.loginFacebook();
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(12)),
                                width: MediaQuery.of(context).size.width,
                                child: Stack(children: const [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 4, left: 20),
                                      child: Icon(Icons.facebook_rounded),
                                    ),
                                  ),
                                  Center(
                                      child: Text(
                                    'FACEBOOK',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ))
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
