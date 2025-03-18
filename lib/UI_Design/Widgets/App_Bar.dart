import 'package:flutter/material.dart';

class App_Bar extends StatelessWidget implements PreferredSizeWidget {
  const App_Bar({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final textstyle = Theme
        .of(context)
        .textTheme;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            radius: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shishir', style: textstyle.bodyLarge?.copyWith(
                  color: Colors.white
              )),
              Text('AhmedShishir455@gmail.com',
                  style: textstyle.bodySmall?.copyWith(
                      color: Colors.white
                  ))
            ],
          )
        ],
      ),

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}