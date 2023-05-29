import 'package:flutter/material.dart';
import 'package:meal_app/modules/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../1.1 dummy_data.dart';
import '../modules/meal.dart';

class MealProvider with ChangeNotifier {
  List<Meal> availabeMeals = DUMMY_MEALS;
  List<Meal> favouriteMeals = [];
  List<String> prefsMealId =[];
  List<Category> availabeCategory= [];
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegeterian': false,
    'vegan': false,
  };


  setFilters() async {
    availabeMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']==true && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose']==true && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegterian']==true && !meal.isVegetarian) {
        return false;
      }
      if (filters['vegan']==true && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    List<Category> ac = [];
    availabeMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        });
      });
    });
    availabeCategory = ac;

    notifyListeners();

    notifyListeners();

    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']??false);
    prefs.setBool('lactose', filters['lactose']??false);
    prefs.setBool( 'vegeterian', filters[ 'vegeterian']??false);
    prefs.setBool('vegan', filters['vegan']??false);
    prefs.clear();
  }
  void getDate () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten']= prefs.getBool('gluten') ?? false;
    filters['lactose'] =prefs.getBool('lactose') ?? false;
    filters[ 'vegeterian']= prefs.getBool( 'vegeterian') ?? false;
    filters['vegan']= prefs.getBool('vegan') ?? false ;
   prefsMealId= prefs.getStringList("prefsMealId") ?? [];
    for (var mealID in prefsMealId) {
      final existingIndex=favouriteMeals.indexWhere((meal) => meal.id==mealID);
      if(existingIndex<0)
      {
        favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealID));
      }

    }
    List<Meal> fm = [];
    favouriteMeals.forEach((favMeals) {
      availabeMeals.forEach((avMeals) {
        if(favMeals.id == avMeals.id) fm.add(favMeals);
      });
    });
    favouriteMeals = fm;

    notifyListeners();
  }


  Future<void> toggleFvourite(String mealID) async {
    SharedPreferences prefs=  await SharedPreferences.getInstance();

    final existingIndex=favouriteMeals.indexWhere((meal) => meal.id==mealID);
    if(existingIndex>=0)
    {
      favouriteMeals.removeAt(existingIndex);
      prefs.remove(mealID);
    }
    else {
      favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealID));
      prefsMealId.add(mealID);
    }

    notifyListeners();
     prefs = await SharedPreferences.getInstance();
    prefs.setStringList('prefsMealId', prefsMealId);
  }
  bool isFavourite(String mealID){
    return favouriteMeals.any((meal) => meal.id==mealID);
  }



}