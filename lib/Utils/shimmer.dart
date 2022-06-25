import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
 
  
  const ShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return buildShimmer();
      },
    );
  }
}

  Widget buildShimmer(){
    return ListTile(
      leading: ShimmerWidget.circular(width: 50,height: 50,),
      title: ShimmerWidget.rectangular(width: 10, height: 14),
      subtitle: ShimmerWidget.rectangular(width: 16, height: 14),
    );
  }

  class ShimmerWidget extends StatelessWidget {
    final double width;
    final double height;
    final ShapeBorder shapeBorder;
    
    const ShimmerWidget.rectangular({
      required this.width,
      required this.height
    }) : shapeBorder = const RoundedRectangleBorder();

    const ShimmerWidget.circular({
      required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder()
    });
  
    @override
    Widget build(BuildContext context) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
             color: Colors.grey,
             shape: shapeBorder
          ),
          
        ),
      );
    }
  }