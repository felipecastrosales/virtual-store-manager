import 'package:flutter/material.dart';
import 'image_source_sheet.dart';

class ImagesWidget extends FormField<List> {
  ImagesWidget({
    BuildContext context,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    color: Colors.white10,
                    child: Icon(
                      Icons.add_a_photo, color: Theme.of(context).accentColor),
                  ),
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ImageSourceSheet(
                        onImageSelected: (image) {
                          state.didChange(state.value..add(image));
                          Navigator.of(context).pop();                      
                        }
                      ),
                    );
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