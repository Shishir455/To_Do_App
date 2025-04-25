import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Stack UpdateProfile_Photo_Field(BuildContext context) {

  return Stack(
      children:[  Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),


        ),
        child:Row(
          children: [
            Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
                ),
                child: TextButton(onPressed: (){}

                , child: Text('Photo',style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green.shade900),))
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Add New Photo',style: Theme.of(context).textTheme.titleMedium,),
            )
          ],
        ) ,
      ),
      ] );
}