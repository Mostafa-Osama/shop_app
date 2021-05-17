import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/component/constants.dart';
import 'package:shop/component/reusable.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/register/register_cubit.dart';
import 'package:shop/modules/register/register_states.dart';
import 'package:shop/network/local/shared_preference.dart';

class Register extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                pushReplacementNavigator(context, LoginScreen());
              });
            } else {
              print(state.loginModel.message);

              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'RegisterScreen',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Username must not be empty';
                              }
                            },
                            suffixPressed: () {},
                            label: 'Username',
                            prefix: Icons.person),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'email must not be empty';
                              }
                            },
                            suffixPressed: () {},
                            label: 'EmailAddress',
                            prefix: Icons.email),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Phone must not be empty';
                              }
                            },
                            suffixPressed: () {},
                            label: 'Phone',
                            prefix: Icons.phone),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Password must not be empty';
                              }
                            },
                            label: 'Password',
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              RegisterCubit.get(context).changeValueVisibility();
                            },
                            prefix: Icons.lock),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: ElevatedButton(
                              child: Text('Register'),
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text('Don\'t have an account?'),
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     TextButton(
                        //         onPressed: () {
                        //           pushNavigator(context, Register());
                        //         },
                        //         child: Text(
                        //           'REGISTER',
                        //           style: TextStyle(color: Colors.blue),
                        //         )),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
      //Scaffold(
    //   appBar: AppBar(
    //     title: Text('RegisterScreen'),
    //   ),
    //   body: Container(
    //     child:Text('Register Screen'),
    //   ),
    // );
  }
}
