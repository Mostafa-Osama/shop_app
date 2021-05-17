import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/component/constants.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/onboard_screen.dart';
import 'package:shop/network/local/shared_preference.dart';
import 'package:shop/network/remote/dio_helper.dart';

import 'package:shop/shared/cubit/bloc_observer.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  print('onBoarding = $onBoarding}');
  print('token = $token');




  if(onBoarding != null){
    if(token != null)
      widget = ShopApp();
    else {
      widget = LoginScreen();
     }
  }else{
    widget = OnBoarding();
  }



  runApp(MyApp(
    startWidget: widget,
  ));



}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:
    [
      BlocProvider(create: (context) => ShopCubit()..getHome()..getCategory()..getFav()..getProfile())
    ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: startWidget
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopApp'),
      ),
      body: Container(
        child: Text('Main',style: Theme.of(context).textTheme.bodyText1,),
      ),
    );
  }
}
