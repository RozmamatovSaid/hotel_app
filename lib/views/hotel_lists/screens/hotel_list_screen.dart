import 'package:flutter/material.dart';
import 'package:hotel_app/models/hotel_list_model.dart';
import 'package:hotel_app/viewmodels/hotel_lists_viewmodel.dart';
import 'package:hotel_app/views/profile/extension/space_extension.dart';

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  final HotelListsRemoteDatasource controller = HotelListsRemoteDatasource();
  final TextEditingController commentController = TextEditingController();

  Map<String, bool> reviewedHotels = {};
  int chooseRating = 0;

  @override
  void initState() {
    super.initState();
    controller.fetchHotels().then((_) {
      setState(() {});
    });
    loadReviewStatus();
  }

  @override
  Widget build(BuildContext context) {
    final hotels = controller.getAllHotels();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Hotels"), centerTitle: true),
      body:
          hotels.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  final hasReviewed = reviewedHotels[hotel.id] ?? false;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.w,
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hotel.image.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 280,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(hotel.image[i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F3F3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hotel.description,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Price: \$${hotel.price}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Rating: ${hotel.rating}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  children:
                                      hotel.type
                                          .map((t) => Chip(label: Text(t)))
                                          .toList(),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  children:
                                      hotel.facilities
                                          .map(
                                            (f) => Chip(
                                              backgroundColor:
                                                  Colors.blue.shade50,
                                              label: Text(f),
                                            ),
                                          )
                                          .toList(),
                                ),
                                12.h,
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_1280,q_80/lsci/db/PICTURES/CMS/126700/126753.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                12.h,

                                Text(
                                  'Comments:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Column(
                                  children:
                                      hotel.reviews.map((r) {
                                        return ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(r.comment),
                                          subtitle: Row(
                                            children: List.generate(5, (i) {
                                              final starValue = i + 1;
                                              return Icon(
                                                r.rating >= starValue
                                                    ? Icons.star
                                                    : r.rating >=
                                                        starValue - 0.5
                                                    ? Icons.star_half
                                                    : Icons.star_border,
                                                color: Colors.amber,
                                                size: 18,
                                              );
                                            }),
                                          ),
                                        );
                                      }).toList(),
                                ),
                                const Divider(),
                                if (!hasReviewed) ...[
                                  const Text(
                                    "Write Comment:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextField(
                                    controller: commentController,
                                    decoration: const InputDecoration(
                                      hintText: "Write your opinion....",
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: List.generate(5, (i) {
                                      final value = i + 1;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            chooseRating = value;
                                          });
                                        },
                                        child: Icon(
                                          chooseRating >= value
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (commentController.text.isNotEmpty &&
                                          chooseRating > 0) {
                                        final newComment =
                                            commentController.text;

                                        await controller.addReview(
                                          hotel.id,
                                          newComment,
                                          chooseRating,
                                        );

                                        await markHotelAsReviewed(hotel.id);

                                        setState(() {
                                          hotel.reviews.add(
                                            Review(
                                              comment: newComment,
                                              rating: chooseRating,
                                            ),
                                          );
                                          commentController.clear();
                                          chooseRating = 0;
                                        });
                                      }
                                    },
                                    child: const Text(
                                      "Send Comment",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ] else
                                  const Text(
                                    "You have already reviewed this hotel..",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
