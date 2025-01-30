import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thinkland_card/app/data/models/card_model.dart';
import 'package:thinkland_card/app/helper/custom.dart';

class CardWidget extends StatefulWidget {
  final CardModel card;
  final Function(double)? onScaleUpdated;
  CardWidget({super.key, required this.card, this.onScaleUpdated});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late double scale;

  @override
  void initState() {
    super.initState();
    scale = widget.card.scale ?? 1.0;
  }

  @override
  Widget build(BuildContext context) {
    String? imagePath = widget.card.customImagePath ?? widget.card.predefinedImagePath;
    String? bgColor = widget.card.backgroundColor;

    ImageProvider? backgroundImage;
    if (imagePath != null) {
      backgroundImage = widget.card.customImagePath != null ? FileImage(File(imagePath)) : AssetImage(imagePath) as ImageProvider;
    }
    return Container(
      decoration: BoxDecoration(
        color: (backgroundImage == null && bgColor != null) ? Color(int.parse(bgColor.replaceAll('#', '0xff'))) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      height: customHeight(context) * 0.25,
      width: customWidth(context) * 0.9,
      child: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              onInteractionEnd: (_) {
                print(scale);
                widget.onScaleUpdated!(scale);
              },
              onInteractionUpdate: (details) {
                setState(() {
                  scale = details.scale.clamp(1.0, 5.0);
                });
              },
              minScale: 1,
              maxScale: 5,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  decoration: BoxDecoration(
                    image: backgroundImage != null
                        ? DecorationImage(
                            image: backgroundImage,
                            fit: BoxFit.cover,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              widget.card.ownerName.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 20,
            child: Text(
              widget.card.ownerFamilyName.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Text(
              widget.card.cardNumber,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            child: Text(
              "Valid: ${widget.card.validUntil}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: Text(
              "CVC: ${widget.card.cvc}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
