import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String title;
  final Function onIconTap;
  final bool autoLeading, white, padded;

  const AppBarWidget({
    Key key,
    this.title,
    this.autoLeading = true,
    this.white = true,
    this.padded = false,
    this.onIconTap,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(padded ? 115 : 56);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: padded ? 45 : 0),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, //Colors.blue, //
        centerTitle: true,
        automaticallyImplyLeading: autoLeading,
        leadingWidth: 70,
        leading: Offstage(
          offstage: !autoLeading,
          child: InkWell(
            onTap: () => Navigator.pop(context), //.pop(),
            child: Row(
              children: [
                Icon(Icons.chevron_left, size: 30, color: Colors.white),
                Text('Back', style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        title: Text(
          title ?? '',
          style: TextStyle(
            color: Colors.black87,
          ),
          // style: Theme.of(context).textTheme.headline2.copyWith(
          //       color: white
          //           ? Theme.of(context).accentColor
          //           : Theme.of(context).scaffoldBackgroundColor,
          //     ),
        ),
      ),
    );
  }
}
