import 'package:flutter/material.dart';
import '../util/app_theme.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    required this.value,
    required this.increase,
    required this.decrease,
    super.key,
  });

  final int value;
  final VoidCallback increase;
  final VoidCallback decrease;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppTheme.textFieldBackground,
      ),
      child: Row(
        children: [
          Material(
            color: const Color(0xFFBEE9E7),
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              onTap: decrease,
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: EdgeInsets.all(size.height * .005),
                child: Icon(
                  Icons.remove,
                  color: const Color(0xFF189A93),
                  size: size.height * .02,
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * .02,
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontFamily: 'YekanBakh-Regular',
              color: const Color(0xFF828282),
              fontSize: size.width * .035,
            ),
          ),
          SizedBox(
            width: size.width * .02,
          ),
          Material(
            color: const Color(0xFFBEE9E7),
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              onTap: increase,
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: EdgeInsets.all(size.height * .005),
                child: Icon(
                  Icons.add,
                  color: const Color(0xFF189A93),
                  size: size.height * .02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
