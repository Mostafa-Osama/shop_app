import 'package:shop/component/reusable.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/network/local/shared_preference.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';

void logout(context){
  CacheHelper.removeData(key: 'token').then((value) {
    pushReplacementNavigator(context, LoginScreen());
    ShopCubit.get(context).selectedIndex = 0;
  });
}

String token = '';