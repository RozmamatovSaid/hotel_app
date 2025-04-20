import 'package:flutter/material.dart';
import 'package:hotel_app/mehmonxona_royhatlari/controllers/mehmonxona_royhat_controlleri.dart';
import 'package:hotel_app/mehmonxona_royhatlari/models/mehmonxona_royhati_model.dart';

class MehmonxonaRoyhatlarScreen extends StatefulWidget {
  const MehmonxonaRoyhatlarScreen({super.key});

  @override
  State<MehmonxonaRoyhatlarScreen> createState() =>
      _MehmonxonaRoyhatlarScreenState();
}

class _MehmonxonaRoyhatlarScreenState extends State<MehmonxonaRoyhatlarScreen> {
  final HotelController controller = HotelController();

  int chooseRating = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchHotels().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final hotels = controller.getAllHotels();

    return Scaffold(
      appBar: AppBar(title: Text("Mehmonxonalar"), centerTitle: true),
      body:
          hotels.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: hotel.image.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 8),
                                  width: 280,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(hotel.image[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            hotel.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            hotel.description,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Narxi: \$${hotel.price}',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Reyting: ${hotel.rating}',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8),

                          Wrap(
                            spacing: 8,
                            children:
                                hotel.type
                                    .map((text) => Chip(label: Text(text)))
                                    .toList(),
                          ),
                          SizedBox(height: 8),

                          Wrap(
                            spacing: 8,
                            children:
                                hotel.facilities
                                    .map(
                                      (f) => Chip(
                                        backgroundColor: Colors.blue.shade50,
                                        label: Text(f),
                                      ),
                                    )
                                    .toList(),
                          ),
                          SizedBox(height: 12),

                          Text(
                            'Sharhlar:',
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
                                        int starValue = i + 1;
                                        return Icon(
                                          r.rating >= starValue
                                              ? Icons.star
                                              : r.rating >= starValue - 0.5
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

                          Divider(),

                          Text(
                            "Sharh yozish:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: "Fikringizni yozing...",
                            ),
                          ),
                          SizedBox(height: 8),

                          Row(
                            children: List.generate(5, (index) {
                              int value = (index + 1);
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

                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              if (commentController.text.isNotEmpty &&
                                  chooseRating > 0) {
                                final newComment = commentController.text;

                                await controller.addReview(
                                  hotel.id,
                                  newComment,
                                  chooseRating,
                                );

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
                            child: Text("Sharhni yuborish"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
