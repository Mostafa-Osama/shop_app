import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/component/constants.dart';
import 'package:shop/component/reusable.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/shop_cubit/shop_states.dart';

class Settings extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).loginModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return Scaffold(
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).loginModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      if(state is UpdateProfileLoadingState)
                      LinearProgressIndicator(),
                      defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Phone must not be empty';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          function: () {
                            logout(context);
                          },
                          text: 'SignOut'),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              ShopCubit.get(context).updateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: 'Update Profile'),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
