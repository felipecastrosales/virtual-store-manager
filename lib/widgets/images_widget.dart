import 'package:flutter/material.dart';

class ImagesWidget extends FormField<List> {
  
  ImagesWidget({
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator, 
    List initialValue,
    bool autoValidate = false, 
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    // ignore: deprecated_member_use
    autovalidate: autoValidate,
    builder: (state) {
      return Column(
        children: <Widget>[
          Container(
            height: 124,
            padding: EdgeInsets.all(8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: state.value.map<Widget>((imageList) {
                return Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    child: imageList is String  
                      ? Image.network(imageList, fit: BoxFit.cover) 
                      : Image.file(imageList, fit: BoxFit.cover),
                    onLongPress: (){
                      state.didChange(state.value..remove(imageList));
                    },
                  ), 
                );
              }).toList()..add(
                GestureDetector(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Icon(Icons.add_a_photo),
                  ),
                  onTap: (){

                  },
                ),
              ),
            ),
          ),
          state.hasError ? Text(
            state.errorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ) : Container(),
        ],
      );
    }
  );
}