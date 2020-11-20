import 'package:flutter/material.dart';
import 'add_size_dialog.dart';

class ProductSizes extends FormField<List> {
  ProductSizes({
    BuildContext context,
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
            onTap: () async {
              var size = await showDialog(
                context: context,
                builder: (context) => AddSizeDialog(),
              );
              if (size != null) {
                state.didChange(state.value..add(size));
              } 
            },
            child: Container(
              child: Text('+'),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: state.hasError ? Colors.red : const Color(0xFF06d6a0),
                  width: 3,
                )
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
