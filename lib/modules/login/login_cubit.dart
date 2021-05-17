




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/login/login_states.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/network/remote/end_point.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({@required String email,@required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {"email": email, "password": password}).then((value) {
          loginModel=LoginModel.fromJson(value.data);
          // print(loginModel.status);
          // print(loginModel.message);
          // print(loginModel.data.token);
          emit(LoginSuccessState(loginModel));
        }).catchError((error){
          print(error.toString());
          emit(LoginErrorState(error.toString()));
          
    });
  }



  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changeValueVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility: Icons.visibility_off;
    emit(LoginPasswordVisibilityState());
  }

}
