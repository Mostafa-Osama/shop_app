
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/shared/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/shop_cubit/shop_states.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cat =ShopCubit.get(context).categoriesModel;
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: ListView.separated(itemBuilder: (context,index)=>catBuild(cat.data.data[index]),
              separatorBuilder:  (context,index)=> Divider(thickness: 1,color: Colors.grey,),
              itemCount: cat.data.data.length)
        );
      },

    );
  }
  Widget catBuild(DataModel model) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Image(
          height: 80,
          width: 80,
          fit: BoxFit.cover,
          image: NetworkImage(model.image),
        ),
        SizedBox(width: 10,),
        Text(model.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        Spacer(),
        IconButton(icon: Icon(Icons.arrow_forward),
            onPressed: ()
            {}),

      ],
    ),
  );
}


//https://student.valuxapps.com/storage/uploads/banners/1618341159Y9WmP.L_1617530477_GW-MB-Home_care-en.jpg