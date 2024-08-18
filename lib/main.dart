import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'avatarScreen.dart';
import 'categoryScreen.dart';
import 'animal/animals.dart';
import 'color/colors.dart';
import 'family/family.dart';
import 'food/food.dart';
import 'fruit/fruits.dart';
import 'vegetable/vegetable.dart';
import 'job/jobs.dart';
import 'number/numbers.dart';
import 'body/body.dart';
import 'weather/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preschool English Learning',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/login': (context) => LoginScreen(),
        '/avatar': (context) => AvatarScreen(),
        '/category': (context) => CategoryScreen(),
        '/animals': (context) => AnimalsScreen(),
        '/colors': (context) => ColorsScreen(),
        '/family': (context) => FamilyScreen(),
        '/food': (context) => FoodScreen(),
        '/fruits': (context) => FruitsScreen(),
        '/jobs': (context) => JobsScreen(),
        '/numbers': (context) => NumbersScreen(),
        '/vegetables': (context) => VegetablesScreen(),
        '/body': (context) => BodyScreen(),
      },
    );
  }
}
