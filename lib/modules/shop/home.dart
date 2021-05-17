import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/shop_cubit/shop_states.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ChangeFavoritesSuccessfulState)
          {
            if(!state.model.status){
              Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).homeModel != null &&
            ShopCubit.get(context).categoriesModel != null,
        builder: (context) => homeBuilder(ShopCubit.get(context).homeModel,
            ShopCubit.get(context).categoriesModel,context),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }
  Widget homeBuilder(ShopHomeModel model, CategoriesModel cmodel,context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1),
            items: model.data.banners.map((e) {
              return Column(
                children: [
                  Image(
                    image: NetworkImage('${e.image}'),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        categorybuilder(cmodel.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 20,
                    ),
                    itemCount: cmodel.data.data.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Products',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[250],
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 0.9 / 1.4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(model.data.products.length,
                      (index) => gridProduct(model.data.products[index],context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridProduct(ProductsModel model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 150,
              width: double.infinity,
              // fit: BoxFit.fill,
            ),
            if (model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: Text(
                  'Discount',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.2),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: CircleAvatar(
                        backgroundColor:ShopCubit.get(context).favorites[model.id] ? Colors.blue: Colors.grey ,
                        radius: 15,
                        child: Icon(Icons.favorite_border,color: Colors.white,)),
                    onPressed: () {
                      ShopCubit.get(context).getFavorites(model.id);
                    },
                    iconSize: 5,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget categorybuilder(DataModel data) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        fit: BoxFit.cover,
        height: 100,
        width: 100,
        image: NetworkImage(data.image),
      ),
      Container(
        child: Text(
          data.name,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        color: Colors.black.withOpacity(0.8),
        width: 100,
      ),
    ],
  );
}


//CategoriesModel model
