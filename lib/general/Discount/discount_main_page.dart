import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_calculator/widgets/common_widgets.dart';

class DiscountMainPage extends StatefulWidget {
  const DiscountMainPage({super.key});

  @override
  State<DiscountMainPage> createState() => _DiscountMainPageState();
}

class _DiscountMainPageState extends State<DiscountMainPage> {
  final _originalPriceController = TextEditingController();

  final _discountPercentageController = TextEditingController();

  final _amountSavedController = TextEditingController();

  final _finalPriceController = TextEditingController();

  final _style = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

  final FocusNode _originalPriceFocusNode = FocusNode();
  final FocusNode _discountPercentageFocusNode = FocusNode();
  final FocusNode _amountSavedFocusNode = FocusNode();
  final FocusNode _finalPriceFocusNode = FocusNode();
  bool _isClearingOutput = false;
  bool _lock = false;
  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  @override
  void dispose() {
    _originalPriceController.dispose();
    _discountPercentageController.dispose();
    _amountSavedController.dispose();
    _finalPriceController.dispose();
    _originalPriceFocusNode.dispose();
    _discountPercentageFocusNode.dispose();
    _amountSavedFocusNode.dispose();
    _finalPriceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Discount Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (_) => _calculateDiscount(),
              focusNode: _originalPriceFocusNode,
              controller: _originalPriceController,
              readOnly: true,
              decoration: InputDecoration(
                  label: Text("Original Price"), border: _style),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (_) => _calculateDiscount(),
              focusNode: _discountPercentageFocusNode,
              controller: _discountPercentageController,
              readOnly: true,
              decoration: InputDecoration(
                  label: Text("Discount Percentage"), border: _style),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (_) => _calculateDiscount(),
              focusNode: _amountSavedFocusNode,
              controller: _amountSavedController,
              readOnly: true,
              decoration:
                  InputDecoration(label: Text("Amount saved"), border: _style),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (_) => _calculateDiscount(),
              focusNode: _finalPriceFocusNode,
              controller: _finalPriceController,
              readOnly: true,
              decoration:
                  InputDecoration(label: Text("Final price"), border: _style),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  buildButton('7', 0.25, Colors.black, context,
                      () => _appendValues('7')),
                  buildButton('8', 0.25, Colors.black, context,
                      () => _appendValues('8')),
                  buildButton('9', 0.25, Colors.black, context,
                      () => _appendValues('9')),
                  buildButton(
                      'C', 0.25, Colors.orange, context, () => _clearOutput()),
                  buildButton('4', 0.25, Colors.black, context,
                      () => _appendValues('4')),
                  buildButton('5', 0.25, Colors.black, context,
                      () => _appendValues('5')),
                  buildButton('6', 0.25, Colors.black, context,
                      () => _appendValues('6')),
                  buildButton(
                      '⌫', 0.25, Colors.orange, context, () => _backSpace()),
                  buildButton('1', 0.25, Colors.black, context,
                      () => _appendValues('1')),
                  buildButton('2', 0.25, Colors.black, context,
                      () => _appendValues('2')),
                  buildButton('3', 0.25, Colors.black, context,
                      () => _appendValues('3')),
                  buildButton('=', 0.25, Colors.orange, context,
                      () => _calculateDiscount()),
                  buildButton('.', 0.25, Colors.black, context,
                      () => _appendValues('.')),
                  buildButton('0', 0.25, Colors.black, context,
                      () => _appendValues('0')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _appendValues(String value) {
    if (_originalPriceFocusNode.hasFocus) {
      setState(() {
        _originalPriceController.text += value;
      });
    } else if (_amountSavedFocusNode.hasFocus) {
      setState(() {
        _amountSavedController.text += value;
      });
    } else if (_discountPercentageFocusNode.hasFocus) {
      setState(() {
        _discountPercentageController.text += value;
      });
    } else if (_finalPriceFocusNode.hasFocus) {
      setState(() {
        _finalPriceController.text += value;
      });
    } else {
      setState(() {
        _originalPriceController.text += value;
      });
    }
  }

  void _clearOutput() {
    if (_originalPriceController.text.isNotEmpty &&
        _amountSavedController.text.isNotEmpty &&
        _finalPriceController.text.isNotEmpty &&
        _discountPercentageController.text.isNotEmpty) {
      _isClearingOutput = true;
      setState(() {
        _originalPriceController.clear();
        _amountSavedController.clear();
        _discountPercentageController.clear();
        _finalPriceController.clear();
      });
      _isClearingOutput = false;
      return;
    }
    if (_originalPriceFocusNode.hasFocus) {
      setState(() {
        _originalPriceController.clear();
      });
    } else if (_amountSavedFocusNode.hasFocus) {
      setState(() {
        _amountSavedController.clear();
      });
    } else if (_discountPercentageFocusNode.hasFocus) {
      setState(() {
        _discountPercentageController.clear();
      });
    } else if (_finalPriceFocusNode.hasFocus) {
      setState(() {
        _finalPriceController.clear();
      });
    } else {
      setState(() {
        _originalPriceController.clear();
      });
    }
  }

  void _backSpace() {
    if (_originalPriceFocusNode.hasFocus) {
      setState(() {
        String _txt = _originalPriceController.text;
        if (_txt.length == 1) {
          _clearOutput();
        }
        _originalPriceController.text = _txt.substring(0, _txt.length - 1);
      });
    } else if (_amountSavedFocusNode.hasFocus) {
      setState(() {
        String _txt = _amountSavedController.text;
        if (_txt.length == 1) {
          _clearOutput();
        }
        _amountSavedController.text = _amountSavedController.text
            .substring(0, _amountSavedController.text.length - 1);
      });
    } else if (_discountPercentageFocusNode.hasFocus) {
      setState(() {
        String _txt = _discountPercentageController.text;
        if (_txt.length == 1) {
          _clearOutput();
        }
        _discountPercentageController.text = _discountPercentageController.text
            .substring(0, _discountPercentageController.text.length - 1);
      });
    } else if (_finalPriceFocusNode.hasFocus) {
      setState(() {
        String _txt = _finalPriceController.text;
        if (_txt.length == 1) {
          _clearOutput();
        }
        _finalPriceController.text = _finalPriceController.text
            .substring(0, _finalPriceController.text.length - 1);
      });
    } else {
      setState(() {
        String _txt = _originalPriceController.text;
        _originalPriceController.text = _txt.substring(0, _txt.length - 1);
      });
    }
  }

  void _calculateDiscount() {
    if (_isClearingOutput || _lock) {
      return;
    }
    _lock = true;
    if ((_originalPriceController.text.isNotEmpty &&
            _finalPriceController.text.isNotEmpty) &&
        (_originalPriceController.text == _finalPriceController.text) &&
        (_originalPriceFocusNode.hasFocus || _finalPriceFocusNode.hasFocus)) {
      setState(() {
        _amountSavedController.text = '0.00';
        _discountPercentageController.text = '0.00';
      });
    }
    if (_originalPriceController.text.isNotEmpty &&
        _amountSavedController.text.isNotEmpty &&
        _discountPercentageController.text.isNotEmpty &&
        _finalPriceController.text.isNotEmpty) {
      if (_originalPriceFocusNode.hasFocus) {
        double originalPrice = double.tryParse(_originalPriceController.text)!;
        double discountPercentage =
            double.tryParse(_discountPercentageController.text)!;
        double amountSaved = double.tryParse(_amountSavedController.text)!;
        double finalPrice = double.tryParse(_finalPriceController.text)!;
        amountSaved = (originalPrice * discountPercentage) / 100;
        finalPrice = originalPrice - amountSaved;
        discountPercentage = (amountSaved / originalPrice) * 100;
        setState(() {
          _amountSavedController.text = amountSaved.toStringAsFixed(2);
          _finalPriceController.text = finalPrice.toStringAsFixed(2);

          _discountPercentageController.text =
              discountPercentage.toStringAsFixed(2);
        });
      }
      if (_discountPercentageFocusNode.hasFocus) {
        double originalPrice = double.tryParse(_originalPriceController.text)!;
        double discountPercentage =
            double.tryParse(_discountPercentageController.text)!;
        double amountSaved = double.tryParse(_amountSavedController.text)!;
        double finalPrice = double.tryParse(_finalPriceController.text)!;
        amountSaved = (originalPrice * discountPercentage) / 100;
        finalPrice = originalPrice - amountSaved;
        originalPrice = amountSaved / (discountPercentage / 100);
        setState(() {
          _amountSavedController.text = amountSaved.toStringAsFixed(2);
          _finalPriceController.text = finalPrice.toStringAsFixed(2);
          _originalPriceController.text = originalPrice.toStringAsFixed(2);
        });
      }
      if (_amountSavedFocusNode.hasFocus) {
        double originalPrice = double.tryParse(_originalPriceController.text)!;
        double discountPercentage =
            double.tryParse(_discountPercentageController.text)!;
        double amountSaved = double.tryParse(_amountSavedController.text)!;
        double finalPrice = double.tryParse(_finalPriceController.text)!;
        finalPrice = originalPrice - amountSaved;
        discountPercentage = (amountSaved / originalPrice) * 100;
        originalPrice = amountSaved / (discountPercentage / 100);
        setState(() {
          _finalPriceController.text = finalPrice.toStringAsFixed(2);
          _discountPercentageController.text =
              discountPercentage.toStringAsFixed(2);
          _originalPriceController.text = originalPrice.toStringAsFixed(2);
        });
      }
      if (_finalPriceFocusNode.hasFocus) {
        double originalPrice = double.tryParse(_originalPriceController.text)!;
        double discountPercentage =
            double.tryParse(_discountPercentageController.text)!;
        double amountSaved = double.tryParse(_amountSavedController.text)!;
        double finalPrice = double.tryParse(_finalPriceController.text)!;
        amountSaved = (originalPrice * discountPercentage) / 100;

        originalPrice = finalPrice + amountSaved;
        discountPercentage = (amountSaved / originalPrice) * 100;

        setState(() {
          _discountPercentageController.text =
              discountPercentage.toStringAsFixed(2);
          _amountSavedController.text = amountSaved.toStringAsFixed(2);
          _originalPriceController.text = originalPrice.toStringAsFixed(2);
        });
      }
      _lock = false;
      return;
    }
    double originalPrice =
        double.tryParse(_originalPriceController.text) ?? 0.0;
    double discountPercentage =
        double.tryParse(_discountPercentageController.text) ?? 0.0;
    double amountSaved = double.tryParse(_amountSavedController.text) ?? 0.0;
    double finalPrice = double.tryParse(_finalPriceController.text) ?? 0.0;

    if (originalPrice != 0.0 && discountPercentage != 0.0) {
      amountSaved = (originalPrice * discountPercentage) / 100;
      finalPrice = originalPrice - amountSaved;
      setState(() {
        _amountSavedController.text = amountSaved.toStringAsFixed(2);
        _finalPriceController.text = finalPrice.toStringAsFixed(2);
      });
    } else if (originalPrice != 0.0 && amountSaved != 0.0) {
      discountPercentage = (amountSaved / originalPrice) * 100;
      finalPrice = originalPrice - amountSaved;
      setState(() {
        _finalPriceController.text = finalPrice.toStringAsFixed(2);
        _discountPercentageController.text =
            discountPercentage.toStringAsFixed(2);
      });
    } else if (originalPrice != 0.0 && finalPrice != 0.0) {
      amountSaved = originalPrice - finalPrice;
      discountPercentage = (amountSaved / originalPrice) * 100;
      setState(() {
        _amountSavedController.text = amountSaved.toStringAsFixed(2);
        _discountPercentageController.text =
            discountPercentage.toStringAsFixed(2);
      });
    } else if (discountPercentage != 0.0 && amountSaved != 0.0) {
      originalPrice = amountSaved / (discountPercentage / 100);
      finalPrice = originalPrice - amountSaved;
      setState(() {
        _finalPriceController.text = finalPrice.toStringAsFixed(2);
        _originalPriceController.text = originalPrice.toStringAsFixed(2);
      });
    } else if (discountPercentage != 0.0 && finalPrice != 0.0) {
      originalPrice = finalPrice / (1 - discountPercentage / 100);
      amountSaved = originalPrice - finalPrice;
      setState(() {
        _amountSavedController.text = amountSaved.toStringAsFixed(2);
        _originalPriceController.text = originalPrice.toStringAsFixed(2);
      });
    } else if (amountSaved != 0.0 && finalPrice != 0.0) {
      originalPrice = finalPrice + amountSaved;
      discountPercentage = (amountSaved / originalPrice) * 100;
      setState(() {
        _originalPriceController.text = originalPrice.toStringAsFixed(2);
        _discountPercentageController.text =
            discountPercentage.toStringAsFixed(2);
      });
    }

    _lock = false;
  }

  void _addListeners() {
    _originalPriceController.addListener(_calculateDiscount);
    _discountPercentageController.addListener(_calculateDiscount);
    _amountSavedController.addListener(_calculateDiscount);
    _finalPriceController.addListener(_calculateDiscount);
  }

  // void _removeListeners() {
  //   _originalPriceController.removeListener(_calculateDiscount);
  //   _discountPercentageController.removeListener(_calculateDiscount);
  //   _amountSavedController.removeListener(_calculateDiscount);
  //   _finalPriceController.removeListener(_calculateDiscount);
  // }
}
