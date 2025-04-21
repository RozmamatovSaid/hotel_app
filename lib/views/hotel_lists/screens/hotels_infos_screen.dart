import 'package:flutter/material.dart';
import 'package:hotel_app/models/hotel_list_model.dart';
import 'package:hotel_app/viewmodels/hotel_lists_viewmodel.dart';
import 'package:hotel_app/views/hotel_lists/screens/this_hotel_infos_screen.dart';

class HotelsInfosScreen extends StatefulWidget {
  const HotelsInfosScreen({super.key});

  @override
  State<HotelsInfosScreen> createState() => _HotelsInfosScreenState();
}

class _HotelsInfosScreenState extends State<HotelsInfosScreen> {
  final HotelListsRemoteDatasource controller = HotelListsRemoteDatasource();
  List<Hotel> hotels = [];
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
        centerTitle: true,
        title: Text(
          'Hotel',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
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
                      horizontal: 30.0,
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final updatedHotel = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => HotelListScreen(hotel: hotel),
                          ),
                        );

                        if (updatedHotel != null) {
                          setState(() {
                            hotels[index] = updatedHotel;
                          });
                        }
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: hotel.image.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 300,
                                    margin: EdgeInsets.only(right: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        hotel.image[index],
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }

                                          return Container(
                                            color: Colors.grey[300],
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            color: Colors.grey,
                                            child: Center(
                                              child: Icon(
                                                Icons.broken_image,
                                                size: 40,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

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
