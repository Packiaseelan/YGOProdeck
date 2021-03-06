import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../widgets.dart';

class MolSearchBox extends StatelessWidget {
  final String hint;

  const MolSearchBox({Key key, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeSearch),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 1),
              blurRadius: 5,
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.search, color: Colors.black54),
            SizedBox(width: 10),
            AtmTextHeading2(text: hint),
          ],
        ),
      ),
    );
  }
}
