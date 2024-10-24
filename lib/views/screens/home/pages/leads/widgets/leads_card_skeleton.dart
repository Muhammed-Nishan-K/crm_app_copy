import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildLeadCardSkeleton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Card(
      color: CRMAppColorPallete.transparent,
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Circle Avatar Skeleton
                FittedBox(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[700]!,
                    highlightColor: Colors.grey[600]!,
                    child: CircleAvatar(
                      radius: Screen.getWidth(context: context) * 0.05,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
    
                // Name and course skeleton
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name placeholder
                      Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[600]!,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(0.04*120)),
                          height: Screen.getWidth(context: context) * 0.04,
                          width: double.infinity,
                          
                        ),
                      ),
                      const SizedBox(height: 8.0),
    
                      // Course placeholder
                      Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[600]!,
                        child: Container(
                          height: Screen.getWidth(context: context) * 0.03,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(0.03*120)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Screen.getWidth(context: context)*0.05,),
                // Call Button placeholder
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    height: 35.0,
                    width: Screen.getWidth(context: context) * 0.2,
                    decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(0.05*120)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
    
            // Email placeholder
            Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[600]!,
              child: Container(
                height: 14.0,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(0.03*120)),
              ),
            ),
            const SizedBox(height: 4.0),
            
    
            // Phone placeholder
            Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[600]!,
              child: Container(
                height: 14.0,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(0.03*120)),
              ),
            ),
            const SizedBox(height: 12.0),
    
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dropdown placeholder
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    height: 35.0,
                    width: Screen.getWidth(context: context) * 0.3,
                    decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(0.05*120)),
                  ),
                ),
    
                // Call Button placeholder
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    height: 35.0,
                    width: Screen.getWidth(context: context) * 0.2,
                    decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(0.05*120)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
