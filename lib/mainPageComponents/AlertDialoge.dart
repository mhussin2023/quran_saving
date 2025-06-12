import 'package:flutter/material.dart';

class dialogClass {
  final BuildContext context;
  dialogClass(this.context);

  static  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              textAlign: TextAlign.center,
              'رجاء التأكيد'),
          content: Text(
            textAlign: TextAlign.center,
              'هل تريد حفظ بيانات الختمة'),
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [

        TextButton(
          child: Text('إلغاء'),
          onPressed: () {
            Navigator.of(context).pop('Cancel');
           // return 'Cancel';
          },
        ),
            TextButton(
              child: Text('نعم'),
              onPressed: () {
                Navigator.of(context).pop('Ok');
               // return 'Ok';
              },),
          ]

        );
      },

    );
  }

}