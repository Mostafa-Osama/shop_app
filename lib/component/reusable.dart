import 'package:flutter/material.dart';

void pushReplacementNavigator(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void pushNavigator(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

Widget defaultTextFormField(
    {@required TextEditingController controller,
      @required TextInputType type,
      Function onSubmit,
      Function onChange,
      Function onTap,
      bool isPassword = false,
      @required Function validate,
      @required String label,
      @required IconData prefix,
      IconData suffix,
      Function suffixPressed}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(icon: Icon(suffix), onPressed: suffixPressed),
      ),
    );


Widget defaultButton({@required Function function,
  @required String text,
  double width = double.infinity,
  double radius = 3.0}) => Container(
  width: width,
  height: 40,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
  ),
  child: ElevatedButton(child: Text(text),onPressed: function,),
);
