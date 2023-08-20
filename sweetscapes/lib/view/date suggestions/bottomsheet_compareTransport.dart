import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/components/routeComponent_Tile.dart';
import 'package:sweetscapes/res/components/secondary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/res/transport_directory.dart';
import 'package:sweetscapes/view/date%20suggestions/date_details_viewmodel.dart';
import 'package:sweetscapes/model/response/createPlan_response.dart'
    as createPlan_response;

class BottomSheetCompareTransport extends StatefulWidget {
  BottomSheetCompareTransport(this.model);

  final DateDetailsViewModel model;

  @override
  _BottomSheetCompareTransportState createState() =>
      _BottomSheetCompareTransportState();
}

class _BottomSheetCompareTransportState
    extends State<BottomSheetCompareTransport> {
  List<createPlan_response.Route> route = [];
  Map<String, bool> modes = {};
  int numberofPeople = 2;
  double travelAmount = 0;
  String selectedMode = "";

  void updateMode(String label) {
    setState(() {
      modes = Map.from(widget.model.modesOfTransport);
      if (label == "Bus") {
        route = widget.model.busTravel.route!;
      } else if (label == "Scooty") {
        route = widget.model.scootyTravel.route!;
      } else if (label == "Bike") {
        route = widget.model.bikeTravel.route!;
      } else if (label == "Mid-Size Car") {
        route = widget.model.midSizeCarTravel.route!;
      } else if (label == "SUV") {
        route = widget.model.suvTravel.route!;
      } else {
        route = widget.model.autoTravel.route!;
      }
    });
  }

  double updateBusTravelAmount() {
    double newBusPrice = 0;
    for (createPlan_response.Route routeComponent in route) {
      if (routeComponent.mode == 'bus') {
        newBusPrice =
            newBusPrice + (numberofPeople * routeComponent.price!.toDouble());
      } else if (routeComponent.mode == 'auto') {
        newBusPrice = newBusPrice +
            (numberofPeople / 5).ceilToDouble() * routeComponent.price!;
      }
    }
    return newBusPrice;
  }

  void updateTravelAmount() {
    if (selectedMode == "Bus") {
      travelAmount = updateBusTravelAmount();
    } else if (selectedMode == "Scooty") {
      travelAmount =
          (numberofPeople / 2).ceilToDouble() * widget.model.scootyTravelAmount;
    } else if (selectedMode == "Bike") {
      travelAmount =
          (numberofPeople / 2).ceilToDouble() * widget.model.bikeTravelAmount;
    } else if (selectedMode == "Mid-Size Car") {
      travelAmount = (numberofPeople / 5).ceilToDouble() *
          widget.model.midSizeTravelAmount;
    } else if (selectedMode == "SUV") {
      travelAmount =
          (numberofPeople / 7).ceilToDouble() * widget.model.suvTravelAmount;
    } else {
      travelAmount =
          (numberofPeople / 5).ceilToDouble() * widget.model.autoTravelAmount;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    route = [];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenheight * 0.95,
      child: (route.isEmpty)
          ? FutureBuilder(
              future: widget.model.compareTransport(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  route = snapshot.data!;
                  modes = Map.from(widget.model.modesOfTransport);
                  travelAmount = widget.model.totalTravelAmount;
                  selectedMode = widget.model.selectedModeOfTransport;
                  print(route.length);
                  return CompareTransportPage(
                      screenWidth, screenheight, context);
                }
                return Center(child: AppText(
              text: 'Not able to fetch route',
              size: 20,
              font: Fonts.TITLE,
              weight: FontWeight.w700,
              color: AppColor.black,
            ),);
              },
            )
          : CompareTransportPage(screenWidth, screenheight, context),
    );
  }

  Padding CompareTransportPage(
      double screenWidth, double screenheight, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: AppText(
              text: 'Select Transport',
              size: 24,
              font: Fonts.TITLE,
              weight: FontWeight.w700,
              color: AppColor.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 0, 24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: modes.entries.map((MapEntry<String, bool> entry) {
                  String label =
                      TransportDirectory().getTransportLabel(entry.key);
                  bool isSelected = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      shape: StadiumBorder(),
                      backgroundColor: AppColor.secondary,
                      selectedColor: AppColor.black,
                      label: Wrap(
                        spacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              TransportDirectory().getTransportIcon(entry.key),
                              color:
                                  isSelected ? AppColor.white : AppColor.black,
                            ),
                          ),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.subtitle,
                              fontWeight: FontWeight.w500,
                              color: (isSelected)
                                  ? AppColor.white
                                  : AppColor.black,
                              letterSpacing: 0.14,
                            ),
                          ),
                        ],
                      ),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        selectedMode = label;
                        widget.model.updateTransportMode(entry.key);
                        updateMode(label);
                        updateTravelAmount();
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: SizedBox(
                width: screenWidth,
                height: screenheight * 0.51,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ListView.builder(
                    itemCount: route.length,
                    itemBuilder: (context, index) => RouteComponentTile(
                      routeComponent: route[index],
                    ),
                  ),
                )),
          ),
          Container(
            color: Color(0xFFEFF3FE),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Travel Expense for ${numberofPeople}',
                        style: const TextStyle(
                          height: 20 / 14,
                          fontSize: 14,
                          fontFamily: AppFonts.title,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          letterSpacing: 0.17,
                        ),
                      ),
                      Text(
                        'View plan to see other expenses',
                        style: TextStyle(
                          height: 16 / 12,
                          fontSize: 12,
                          fontFamily: AppFonts.subtitle,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                          letterSpacing: 0.21,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\u20B9 ${travelAmount.toInt()}',
                    style: const TextStyle(
                      height: 20 / 14,
                      fontSize: 14,
                      fontFamily: AppFonts.title,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: AppColor.secondary,
            height: 4,
            thickness: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Number of People',
                  style: TextStyle(
                    height: 20 / 14,
                    fontSize: 14,
                    fontFamily: AppFonts.title,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: 0.17,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (numberofPeople > 1) {
                            numberofPeople--;
                            updateTravelAmount();
                          }
                        });
                      },
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColor.secondary,
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        numberofPeople.toString(),
                        style: const TextStyle(
                          height: 24 / 16,
                          fontSize: 16,
                          fontFamily: AppFonts.title,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                          letterSpacing: 0.16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          numberofPeople++;
                          updateTravelAmount();
                        });
                      },
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColor.secondary,
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SecondaryButton(
                      title: 'Back',
                      onPress: () {
                        Navigator.pop(context);
                      }),
                ),
                const SizedBox(
                  width: 9,
                ),
                Expanded(
                  child: PrimaryButton(
                      title: 'View Plan',
                      onPress: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
