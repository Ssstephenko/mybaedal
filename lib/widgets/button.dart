import 'package:baedalgeek/utils/callbacks.dart';
import 'package:flutter/material.dart';

/// 글자 버튼 리스트에서의 아이템 위젯.
class TextListButton {
  final String text;

  const TextListButton(this.text);

  Widget _toWidget({
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        elevation: 0,
        color: isSelected ? Colors.pink[50] : Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
            top: 2,
            bottom: 2,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}

/// 글자 버튼 리스트 위젯.
Widget textListButtonGroup({
  required int currentIndex,
  required List<TextListButton> children,
  required VoidKeyCallback<int> onChanged,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: List.generate(
      children.length,
      (i) {
        final child = children[i];
        return child._toWidget(
          isSelected: currentIndex == i,
          onPressed: () {
            currentIndex = i;
            onChanged(i);
          },
        );
      },
    ).toList(),
  );
}
