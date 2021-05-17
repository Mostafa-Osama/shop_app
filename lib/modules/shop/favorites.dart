import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/shop_cubit/shop_states.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//ShopCubit.get(context).categoriesModel
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildFavItem(
                  ShopCubit.get(context).favoritesModel.data.data[index],
                  context),
              separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
              itemCount:
                  ShopCubit.get(context).favoritesModel.data.data.length),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget buildFavItem(FavoritesData model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product.image),
                  height: 120,
                  width: 120,
                  // fit: BoxFit.fill,
                ),
                if (model.product.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: Text(
                      "${model.product.discount}",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.2),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product.price}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.product.oldPrice != 0)
                        Text(
                          '${model.product.oldPrice}',
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
                            backgroundColor:
                            //  ShopCubit.get(context).favorites[model.id]
                            ShopCubit.get(context).favorites[model.product.id]
                                ? Colors.blue
                                : Colors.grey,
                            radius: 15,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )),
                        onPressed: () {
                          ShopCubit.get(context).getFavorites(model.product.id);
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
      ),
    );
  }
}


