import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/component/constants.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/shop/categories.dart';
import 'package:shop/modules/shop/favorites.dart';
import 'package:shop/modules/shop/home.dart';
import 'package:shop/modules/shop/settings.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/shared/shop_cubit/shop_states.dart';
import 'package:shop/network/remote/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    Home(),
    Categories(),
    Favorites(),
    Settings(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    emit(ChangeBottomNavBarState());
  }

  ShopHomeModel homeModel;

  //TestModel testModel;
  Map<int, bool> favorites = {};

  void getHome() {
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = ShopHomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(("favorites true = ${favorites.toString()}"));
      print(homeModel.data.banners[0].image);
      emit(ShopSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategory() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print("Catrgories State = mo${categoriesModel.status}");
      print(categoriesModel.data.data[0]);
      emit(CategorySuccessfulState());
    }).catchError((onError) {
      print(onError.toString());
      emit(CategoryErrorState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void getFavorites(int productId) {
    favorites[productId] = !favorites[productId];

    emit(ChangeFavoritesState());

    DioHelper.postData(
            url: FAVORITES,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel.status)
        favorites[productId] = !favorites[productId];
      else
        getFav();
      print(value.data);
      emit(ChangeFavoritesSuccessfulState(changeFavoritesModel));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId];
      emit(ChangeFavoritesErrorState());
    });
  }

  FavoritesModel favoritesModel;

  void getFav() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print("Catrgories State = mo${categoriesModel.status}");
      print(categoriesModel.data.data[0]);
      emit(GetFavoritesSuccessfulState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetFavoritesErrorState());
    });
  }

  LoginModel loginModel;

  void getProfile() {
    emit(GetProfileLoadingState());
    DioHelper.getData(url: PROFILE, token: token)
        .then((value) {
          loginModel = LoginModel.fromJson(value.data);
          print(loginModel.data.name);
          emit(GetProfileSuccessfulState());
    })
        .catchError((onError) {
          print(onError.toString());
          emit(GetProfileErrorState());
    });
  }

  void updateProfile({@required String name,@required String email,@required String phone}){
    emit(UpdateProfileLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token,
    data: {
      'name':name,
      'email':email,
      'phone':phone,
    })
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data.name);
      emit(UpdateProfileSuccessfulState(loginModel));
    })
        .catchError((onError) {
      print(onError.toString());
      emit(UpdateProfileErrorState());
    });
  }
}
//
// DioHelper.getData(url: HOME,token: token).then((value) {
// homeModel = ShopHomeModel.fromJson(value.data);
// print("status from cubit${homeModel.status}");
// // print(homeModel.data.banners[0].image);
// emit(ShopSuccessfulState());
// }).catchError((onError){
// print(onError.toString());
// emit(ShopErrorState(onError.toString()));
// });
