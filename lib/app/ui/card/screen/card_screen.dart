import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thinkland_card/app/data/models/card_model.dart';
import 'package:thinkland_card/app/helper/custom.dart';
import 'package:thinkland_card/app/ui/card/widget/card_widget.dart';

import '../bloc/card_bloc/card_bloc.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _familyName = TextEditingController();
  final TextEditingController _cvc = TextEditingController();
  final TextEditingController _validty = TextEditingController();
  CardTypes cardType = CardTypes.humo;
  String? imagePath;
  bool assetImage = false;
  String? selectedPredefinedImage;
  Color? selectedColor;
  double scale = 1.0;
  Offset position = Offset.zero;

  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(GetCards());
    _name.addListener(() => setState(() {}));
    _familyName.addListener(() => setState(() {}));
    _cardNumber.addListener(() => setState(() {}));
    _cvc.addListener(() => setState(() {}));
    _validty.addListener(() => setState(() {}));
  }

  void _updateScale(double newScale) {
    // context.read<CardBloc>().add(EditCardScale(newScale));

    setState(() {
      scale = scale * newScale;
    });
    print("newScale::${scale}");
    print("newScale::${newScale}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text("My Cards", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                height: customHeight(context) * 0.25,
                width: customWidth(context),
                child: BlocBuilder<CardBloc, CardState>(
                  builder: (context, state) {
                    if (state is CardLoaded) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.cardList.length,
                        itemBuilder: (context, id) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CardWidget(card: state.cardList[id]),
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text("Add new Card", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text("Select card theme", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                height: customHeight(context) * 0.25,
                width: customWidth(context),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: defaultImages.length + 1,
                  itemBuilder: (context, id) {
                    if (id == 0) {
                      return Container(
                        alignment: Alignment.center,
                        height: customHeight(context) * 0.25,
                        width: customWidth(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: pickImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.amberAccent,
                                ),
                                alignment: Alignment.center,
                                height: 50,
                                width: 150,
                                child: const Text("Add custom image"),
                              ),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: _pickColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.orange,
                                ),
                                alignment: Alignment.center,
                                height: 50,
                                width: 150,
                                child: const Text("Add custom Color"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPredefinedImage = defaultImages[id - 1];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CardWidget(
                          card: CardModel(
                            cardNumber: "",
                            ownerFamilyName: "",
                            ownerName: "",
                            cardType: CardTypes.humo,
                            cvc: "",
                            validUntil: "",
                            predefinedImagePath: defaultImages[id - 1],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              selectedColor == null && selectedPredefinedImage == null
                  ? Container(
                      child: CardWidget(
                        onScaleUpdated: _updateScale,
                        card: CardModel(
                            scale: scale,
                            cardNumber: _cardNumber.text,
                            ownerFamilyName: _familyName.text,
                            ownerName: _name.text,
                            cardType: cardType,
                            cvc: _cvc.text,
                            validUntil: _validty.text,
                            predefinedImagePath: defaultImages.first),
                      ),
                    )
                  : Container(
                      child: CardWidget(
                        onScaleUpdated: _updateScale,
                        card: CardModel(
                            scale: scale,
                            cardNumber: _cardNumber.text,
                            ownerFamilyName: _familyName.text,
                            ownerName: _name.text,
                            cardType: cardType,
                            cvc: _cvc.text,
                            validUntil: _validty.text,
                            backgroundColor: selectedColor?.value.toString(),
                            predefinedImagePath: selectedPredefinedImage),
                      ),
                    ),
              const SizedBox(height: 20),
              _buildTextField("Card Owner Name", _name),
              _buildTextField("Family Name", _familyName),
              _buildTextField("Card Number", _cardNumber, keyboardType: TextInputType.number, limit: 16),
              _buildTextField("CVC", _cvc, keyboardType: TextInputType.number, limit: 3),
              _buildTextField("Valid Until (MM-YYYY)", _validty, keyboardType: TextInputType.datetime),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveCard,
                  child: const Text("Save Card", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedPredefinedImage = image.path;
        assetImage = true;
        selectedColor = null;
      });
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text, int? limit}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        inputFormatters: [LengthLimitingTextInputFormatter(limit)],
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  String _formatCardNumber(String number) {
    return number.replaceAllMapped(RegExp(r"\d{4}"), (match) => "${match.group(0)} ").trim();
  }

  bool _isValidDateFormat(String date) {
    final RegExp regExp = RegExp(r"^(0[1-9]|1[0-2])-(\d{4})$");
    return regExp.hasMatch(date);
  }

  void _saveCard() {
    if (_cardNumber.text.isEmpty || _name.text.isEmpty || _cvc.text.length != 3 || !_isValidDateFormat(_validty.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields correctly.")),
      );
      return;
    }

    final newCard = CardModel(
        ownerFamilyName: _familyName.text,
        ownerName: _name.text,
        cardNumber: _formatCardNumber(_cardNumber.text),
        cardType: cardType,
        cvc: _cvc.text,
        validUntil: _validty.text,
        scale: scale
        // predefinedImagePath: selectedPredefinedImage,
        // backgroundColor: '#${selectedColor.value.toRadixString(16).substring(2)}',
        );
    if (assetImage) {
      if (selectedPredefinedImage != null) {
        // defaultImages.insert(0, selectedPredefinedImage!);
      }
    } else if (selectedColor != null) {
      newCard.backgroundColor = "${selectedColor?.value}";
    } else {
      // defaultImages.shuffle();

      selectedPredefinedImage = defaultImages.first;
    }
    if (selectedPredefinedImage != null) {
      newCard.predefinedImagePath = selectedPredefinedImage;
    }
    _name.clear();
    _cardNumber.clear();
    _validty.clear();
    _cvc.clear();
    _familyName.clear();
    context.read<CardBloc>().add(AddCard(newCard));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Card added successfully!")),
    );
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor ??= Color(0xfec8f07),
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Select"),
              onPressed: () {
                Navigator.of(context).pop();
                selectedPredefinedImage = null;
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
