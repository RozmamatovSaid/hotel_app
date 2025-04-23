import 'package:flutter/material.dart';
import 'package:hotel_app/viewmodels/booking_viewmodel.dart';
import 'package:hotel_app/models/booking_model.dart' show BookingModel;
import 'package:hotel_app/views/booking/screens/payment_screen.dart';
import 'package:hotel_app/views/search_and_filter/widgets/carousel_slider_widget.dart';

class BookingScreen extends StatefulWidget {
  final String name;
  final List<String> images;
  final List<String> facilities;
  const BookingScreen({
    super.key,
    required this.name,
    required this.images,
    required this.facilities,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingViewModel viewModel = BookingViewModel();
  String selectedType = "Premium";
  int basePrice = 500;

  bool isPayment = false;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  final Map<String, bool> selectedFacilities = {
    "wifi": false,
    "nonushta": false,
    "tv": false,
    "basseyn": false,
  };
  final Map<String, int> facilityPrices = {
    "wifi": 10,
    "nonushta": 20,
    "tv": 5,
    "basseyn": 15,
  };

  @override
  void initState() {
    super.initState();
    for (var f in widget.facilities) {
      selectedFacilities.putIfAbsent(f, () => false);
      facilityPrices.putIfAbsent(f, () => 10);
    }
    getBookings();
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  int get totalPrice {
    int extras = 0;
    selectedFacilities.forEach((key, value) {
      if (value) {
        extras += facilityPrices[key] ?? 0;
      }
    });
    return basePrice + extras;
  }

  void handleBooking() async {
    List<String> facilities =
        selectedFacilities.entries
            .where((element) => element.value)
            .map((e) => e.key)
            .toList();

    int totalFacilityPrices = selectedFacilities.entries
        .where((element) => element.value)
        .fold(
          0,
          (previousValue, element) =>
              previousValue + (facilityPrices[element.key] ?? 0),
        );

    final success = await viewModel.makeBooking(
      userId: "user1",//user id
      booking: BookingModel(
        hotelName: widget.name,
        type: selectedType,
        startDate: selectedStartDate ?? DateTime.now(),
        endDate: selectedEndDate ?? DateTime.now(),
        facilities: facilities,
        images: widget.images,
        description: "5 yulduzli mehmonxona",
        totalPrice: totalPrice,
      ),
    );

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Band qilindi!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Xatolik yuz berdi')));
    }
  }

  Future<void> getBookings() async {
    await viewModel.getBookings("user1");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.images);
    return Scaffold(
      appBar: AppBar(title: Text("Xona Band Qilish"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSliderWidget(imageList: widget.images),

              DropdownButton<String>(
                value: selectedType,
                onChanged: (value) {
                  setState(() {
                    selectedType = value!;
                    basePrice =
                        selectedType == "Lux"
                            ? 600
                            : selectedType == "Standart"
                            ? 400
                            : 500;
                  });
                },
                items:
                    ["Standart", "Lux", "Premium"].map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
              ),

              ListTile(
                title: Text("Kirish sanasi"),
                subtitle: Text(
                  selectedStartDate != null
                      ? "${selectedStartDate!.day}/${selectedStartDate!.month}/${selectedStartDate!.year}"
                      : "Kirish sanasi tanlanmagan",
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final DateTime? pickStartDate = await showDatePicker(
                      initialDate: DateTime.now(),
                      context: context,
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2099),
                    );

                    if (pickStartDate != null &&
                        pickStartDate != selectedStartDate) {
                      setState(() {
                        selectedStartDate = pickStartDate;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_month, color: Color(0xFF0071FE)),
                ),
              ),

              ListTile(
                title: Text("Chiqish sanasi"),
                subtitle: Text(
                  selectedEndDate != null
                      ? "${selectedEndDate!.day}/${selectedEndDate!.month}/${selectedEndDate!.year}"
                      : "Chiqish sanasi tanlanmagan",
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final DateTime? pickEndDate = await showDatePicker(
                      initialDate: DateTime.now(),
                      context: context,
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2099),
                    );

                    if (pickEndDate != null && pickEndDate != selectedEndDate) {
                      setState(() {
                        selectedEndDate = pickEndDate;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_month, color: Color(0xFF0071FE)),
                ),
              ),

              ...widget.facilities.toSet().map((e) {
                return CheckboxListTile(
                  title: Text(
                    "${_capitalize(e)} (+\$${facilityPrices[e] ?? 0})",
                  ),
                  value: selectedFacilities[e],
                  onChanged: (value) {
                    setState(() {
                      selectedFacilities[e] = value!;
                    });
                  },
                );
              }),

              SizedBox(height: 20),
              Text(
                "Umumiy narx: \$$totalPrice",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {
                    isPayment = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()),
                    );
                    setState(() {});
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF0071FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),

                  child: Text(
                    "Payment",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: !isPayment ? null : handleBooking,
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF001529),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),

                  child: Text(
                    "Band qilish",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
