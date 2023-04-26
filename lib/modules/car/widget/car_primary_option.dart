import 'package:flutter/material.dart';

class CarPrimaryOption extends StatelessWidget {
  const CarPrimaryOption({
    required this.icon,
    required this.title,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .125,
      child: Material(
        color: const Color(0xFFDEEDEC),
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(13),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .01,
              ),
              Expanded(
                child: Container(
                  width: size.height * .08,
                  height: size.height * .08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Icon(
                        icon,
                        color: const Color(0xFF189A93),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .0075,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: size.width * .0235,
                  fontFamily: 'YekanBakh-Regular',
                  color: const Color(0xFF565656),
                ),
              ),
              SizedBox(
                height: size.height * .0075,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
