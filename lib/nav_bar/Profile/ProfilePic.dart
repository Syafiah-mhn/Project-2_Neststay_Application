import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  static const IconData cameraAltRounded =
      IconData(0xf60b, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile2.png'),
              ),
              Positioned(
                right: -12,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      primary: const Color(0xFFF5F6F9),
                    ),
                    onPressed: () {},
                    child: Icon(cameraAltRounded, color: Colors.purple),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
