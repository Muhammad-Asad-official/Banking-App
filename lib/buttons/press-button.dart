import 'package:flutter/material.dart';

class PressButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loadingIcon;
  const PressButton({Key? key,
    required this.title,
    required this.onTap,
    this.loadingIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          width: 130,
          height: 40,


          child:  Center(child: loadingIcon ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 52),
            child: CircularProgressIndicator(strokeWidth: 3,color: Colors.white,),
          ) :
          Text(title,style: const TextStyle(color: Colors.white, fontSize: 15)
          )
          ),
      )
    );
  }
}
