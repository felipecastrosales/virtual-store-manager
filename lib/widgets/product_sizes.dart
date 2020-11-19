import 'package:flutter/material.dart';

class ProductSizes extends FormField<List> {
  ProductSizes({
    List initialValue,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
  }) : super(
    initialValue: initialValue,
    onSaved: onSaved,
    validator: validator,
    builder: (state) => SizedBox(
      height: 36,
      child: GridView(
        padding: EdgeInsets.symmetric(vertical: 4),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 8,
          childAspectRatio: 0.5,
        ),
        children: state.value.map((sizeValue) {
          return GestureDetector(
            onLongPress: () {
              state.didChange(state.value..remove(sizeValue));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: const Color(0xFF06d6a0),
                  width: 3,
                )
              ),
              child: Text(
                sizeValue,
                style: TextStyle(color: const Color(0xFF06d6a0)),
              ),
            ),
          );
        }).toList()..add(
          GestureDetector(
            onTap: (){

            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: const Color(0xFF06d6a0),
                  width: 3,
                )
              ),
              child: Text('+', style: TextStyle(color: const Color(0xFF06d6a0)),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
