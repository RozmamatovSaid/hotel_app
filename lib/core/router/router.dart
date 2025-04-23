import 'package:flutter/material.dart';
import 'package:hotel_app/core/router/routes.dart';
import 'package:hotel_app/views/booking/screens/booking_screen.dart';
import 'package:hotel_app/views/hotel_lists/screens/categories_hotel.dart';
import 'package:hotel_app/views/profile/screens/profile_screen.dart';
import 'package:hotel_app/views/register_screens/login_in_screen.dart';
import 'package:hotel_app/views/register_screens/sign_up_screen.dart';
import 'package:hotel_app/views/search_and_filter/screens/search_screen.dart';
import 'package:hotel_app/views/search_and_filter/screens/filter_screen.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> appRoutes = {
    AppRoutes.profile: (context) => ProfileScreen(),
    AppRoutes.searchScreen: (context) => SearchScreen(),
    AppRoutes.filter: (context) => FilterScreen(),
    AppRoutes.signUp: (context) => SignUpScreen(),
    AppRoutes.login: (context) => LoginInScreen(),
    AppRoutes.categories: (context) => CategoriesHotel(),
    // AppRoutes.booking: (context) => BookingScreen(),
  };
}
