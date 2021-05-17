import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/component/reusable.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/shop/search/search_screen.dart';
import 'package:shop/network/local/shared_preference.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/shop_cubit/shop_states.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('ShopApp'),
            // actions: [
            //   IconButton(
            //       icon: Icon(Icons.search),
            //       onPressed: () {
            //         pushNavigator(context, Search());
            //       })
            // ],
          ),
          body: Center(
            child: cubit.widgetOptions.elementAt(cubit.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
                backgroundColor: Colors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Colors.pink,
              ),
            ],
            currentIndex: cubit.selectedIndex,
            // selectedItemColor: Colors.amber[800],
            type: BottomNavigationBarType.fixed,
            onTap: cubit.onItemTapped,
          ),
        );
      },
    );
  }
}
