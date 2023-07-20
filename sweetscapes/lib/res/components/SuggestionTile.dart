import 'package:flutter/material.dart';

import '../enums/DateType.dart';
import '../functions/TextFieldDecoration.dart';

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({
    super.key,
    required this.dateType,
    required this.dateOverviewText,
    required this.datePrice,
    required this.onPressed,
  });

  final DateType dateType;
  final String dateOverviewText;
  final double datePrice;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.84,
            height: screenHeight * 0.03,
            decoration: BoxDecoration(
              color: (dateType == DateType.DINEOUT)
                  ? Color(0xFFFBB13C)
                  : (dateType == DateType.WORKSHOP)
                      ? Color(0xFF218380)
                      : Color(0xFFD81159),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  (dateType == DateType.DINEOUT)
                      ? 'DINE-OUT'
                      : (dateType == DateType.WORKSHOP)
                          ? 'WORKSHOP'
                          : 'OUTING',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    // color: Color(0xFF9E7305),
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onPressed(),
            child: Container(
              decoration: TextFieldDecoration.textFieldDecoration().copyWith(
                borderRadius: BorderRadius.circular(20),
              ),
              width: screenWidth,
              // height: screenHeight * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            dateOverviewText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 8),
                          child: Text(
                            '₹ $datePrice',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            width: screenWidth * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Image.asset(
                        (dateType == DateType.DINEOUT)
                            ? 'assets/images/dineout.png'
                            : (dateType == DateType.WORKSHOP)
                                ? 'assets/images/workshop.png'
                                : 'assets/images/outing.png',
                        fit: BoxFit.cover,
                        // color: Color.fromRGBO(255, 255, 255, 0.5),
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.84,
            height: screenHeight * 0.03,
            decoration: BoxDecoration(
              color: (dateType == DateType.DINEOUT)
                  ? Color(0xFFFBB13C)
                  : (dateType == DateType.WORKSHOP)
                      ? Color(0xFF218380)
                      : Color(0xFFD81159),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
