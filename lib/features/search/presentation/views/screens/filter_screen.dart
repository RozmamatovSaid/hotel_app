import 'package:flutter/material.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/filter_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/filter_facilities.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/filter_price_textfield.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/text_item.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  FilterViewmodel viewmodel = FilterViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: TextItem(
          text: "Filter",
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextItem(
              text: "Facilities",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            FilterFacilities(),
            TextItem(
              text: "Rating",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            Consumer<FilterViewmodel>(
              builder:
                  (context, value, child) => Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        onPressed: () {
                          value.setSelectRating(index + 1);
                        },
                        icon: Icon(
                          index < value.selectRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
            ),
            TextItem(
              text: "Price Range",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            FilterPriceTextField(
            ),
          ],
        ),
      ),
    );
  }
}
