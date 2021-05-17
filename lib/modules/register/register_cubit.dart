import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/register/register_states.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/network/remote/end_point.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userRegister({@required String email,@required String password,@required String name,@required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          "name":name,
          "email": email,
          "password": password,
          "phone":phone,
        }).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));

    });
  }



  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changeValueVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility: Icons.visibility_off;
    emit(RegisterPasswordVisibilityState());
  }

}