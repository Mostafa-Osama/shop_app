import 'package:flutter/material.dart';
import 'package:shop/component/reusable.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/network/local/shared_preference.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({@required this.image,@required this.title,@required this.body});
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<BoardingModel> list =
  [
    BoardingModel(image: 'asset/images/a.png', title: 'Screen Title 1', body: 'Screen Body 1'),
    BoardingModel(image: 'asset/images/b.png', title: 'Screen Title 2', body: 'Screen Body 2'),
    BoardingModel(image: 'asset/images/c.png', title: 'Screen Title 3', body: 'Screen Body 3'),
  ];

  PageController boardingController = PageController();

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      print(value.toString());
      if (value){
        pushReplacementNavigator(context, LoginScreen());
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submit, child: Text('Skip',style: TextStyle(color: Colors.white),))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [

            Expanded(
              child: PageView.builder(itemBuilder: (context,index)=>buildBoardingItem(list[index]),
                itemCount: 3,
                controller: boardingController,
                onPageChanged: (int index){
                  if(index == list.length - 1){
                    setState(() {
                      isLast = true;
                      print('lastPage');
                    });
                  }else{
                    isLast = false;
                    print('not Last Page');
                  }

                },),
            ),

            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,  // PageController
                  count:  list.length,
                  effect:  WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 15,
                    dotWidth: 10,
                    spacing: 5,
                  ),  // your preferred effect
                ),
                Spacer(),


                FloatingActionButton(onPressed: (){
                  isLast? submit(): boardingController.nextPage(duration: Duration(milliseconds: 750), curve:Curves.bounceIn);
                },child: Icon(Icons.arrow_forward),)
              ],

            ),
          ],
        ),
      ),
    );
  }





  Widget buildBoardingItem(BoardingModel board)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${board.image}'),)),
      SizedBox(height: 20,),
      Text('${board.title}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      SizedBox(height: 20,),
      Text('${board.body}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
    ],
  );
}
