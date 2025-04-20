import 'dart:convert';
import 'package:hotel_app/mehmonxona_royhatlari/models/mehmonxona_royhati_model.dart';
import 'package:http/http.dart' as http;

class HotelController {
  List<Hotel> hotels = [];

  Future<void> fetchHotels() async {
    final url = Uri.parse(
      'https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/admin/hotels.json',
    );
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;

    hotels =
        data.entries.map((entry) {
          final hotelId = entry.key;
          final hotelData = entry.value;
          return Hotel.fromJson(hotelData, hotelId);
        }).toList();
  }

  List<Hotel> getAllHotels() {
    return hotels;
  }

  Hotel getHotel(int index) {
    return hotels[index];
  }

  Future<void> addReview(String hotelId, String comment, int rating) async {
    final url = Uri.parse(
      "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/admin/hotels/$hotelId/review.json",
    );

    await http.post(
      url,
      body: json.encode({"comment": comment, "rating": rating}),
    );
  }
}
