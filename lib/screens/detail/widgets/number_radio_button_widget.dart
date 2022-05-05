import 'package:flutter/material.dart';

class NumberRadioButton extends StatefulWidget {
  NumberRadioButton({Key? key, required this.radioData, required this.callback})
      : super(key: key);

  final List<RadioModel> radioData;
  final Function(String) callback;

  @override
  State<NumberRadioButton> createState() => _NumberRadioButtonState();
}

class _NumberRadioButtonState extends State<NumberRadioButton> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.radioData.length,
      itemBuilder: (_, index) => GestureDetector(
        child: RadioItem(widget.radioData[index]),
        onTap: () => setState(() {
          for (var e in widget.radioData) {
            e.isSelected = false;
          }
          widget.radioData[index].isSelected = true;
          widget.callback(widget.radioData[index].buttonText);
        }),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  const RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            child: Center(
              child: Text(_item.buttonText,
                  style: TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
              border: Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.blueAccent : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}
