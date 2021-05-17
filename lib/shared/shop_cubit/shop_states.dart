import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ChangeBottomNavBarState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessfulState extends ShopStates {}

class ShopErrorState extends ShopStates {}

class CategorySuccessfulState extends ShopStates {}

class CategoryErrorState extends ShopStates {}

class ChangeFavoritesSuccessfulState extends ShopStates {
  final ChangeFavoritesModel model;

  ChangeFavoritesSuccessfulState(this.model);
}

class ChangeFavoritesState extends ShopStates {}

class ChangeFavoritesErrorState extends ShopStates {}

class GetFavoritesLoadingState extends ShopStates {}

class GetFavoritesSuccessfulState extends ShopStates {}

class  GetFavoritesErrorState extends ShopStates {}


class GetProfileLoadingState extends ShopStates {}

class GetProfileSuccessfulState extends ShopStates {}

class  GetProfileErrorState extends ShopStates {}

class UpdateProfileLoadingState extends ShopStates {}

class UpdateProfileSuccessfulState extends ShopStates {

  final LoginModel loginModel;

  UpdateProfileSuccessfulState(this.loginModel);
}

class  UpdateProfileErrorState extends ShopStates {}