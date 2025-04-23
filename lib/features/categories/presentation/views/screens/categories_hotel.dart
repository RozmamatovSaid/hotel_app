import 'package:flutter/material.dart';
import 'package:hotel_app/features/categories/data/datasources/hotel_categories_datasources.dart';
import 'package:hotel_app/features/search/data/models/hotel_model.dart';
import 'package:hotel_app/features/categories/presentation/views/screens/category_info_hotel.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/carousel_slider_widget.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/search_delegate.dart';

class CategoriesHotel extends StatefulWidget {
  const CategoriesHotel({super.key});

  @override
  State<CategoriesHotel> createState() => _CategoriesHotelState();
}

class _CategoriesHotelState extends State<CategoriesHotel> {
  final HotelRemoteDatasource controller = HotelRemoteDatasource();

  List<HotelModel> hotels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHotels();
  }

  Future<void> loadHotels() async {
    await controller.fetchHotels();
    setState(() {
      hotels = controller.getAllHotels();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 20),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.withValues(alpha: 0.5),
              ),
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
            Text(
              'Hotels',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchViewDelegate());
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final updatedHotel = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => CategoryInfoHotel(hotel: hotel),
                          ),
                        );

                        if (updatedHotel != null) {
                          setState(() {
                            hotels[index] = updatedHotel;
                          });
                        }
                      },

                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.7),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSliderWidget(imageList: hotel.image),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 8,
                              ),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hotel.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      hotel.address,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      'Rating: ${hotel.rating.toStringAsFixed(1)} ⭐',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment(1, 1),
                                      child: Text(
                                        '\$${hotel.price}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
