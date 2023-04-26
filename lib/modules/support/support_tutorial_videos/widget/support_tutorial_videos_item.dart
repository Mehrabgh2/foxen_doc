import 'package:flutter/material.dart';
import 'package:foxenapp/modules/support/support_tutorial_videos/widget/support_tutorial_video_player.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SupportTutorialVideosItem extends StatelessWidget {
  const SupportTutorialVideosItem({
    required this.title,
    required this.link,
    required this.description,
    required this.onPlay,
    required this.onDownload,
    required this.onCancelDownload,
    required this.downloadValue,
    super.key,
  });

  final String title;
  final String description;
  final String link;
  final VoidCallback onPlay;
  final VoidCallback onCancelDownload;
  final VoidCallback onDownload;
  final double downloadValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
        vertical: size.height * .015,
        horizontal: size.width * .02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Material(
                color: Colors.white,
                shadowColor: Colors.grey.withAlpha(100),
                elevation: 10,
                borderRadius: BorderRadius.circular(1000),
                child: InkWell(
                  onTap: onPlay,
                  borderRadius: BorderRadius.circular(1000),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: const Color(0xFF32769E),
                      size: size.height * .0225,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
              SizedBox(
                width: size.height * .0225 + 18,
                height: size.height * .0225 + 18,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SfRadialGauge(axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          startAngle: -90,
                          endAngle: 270,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Colors.transparent,
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                              value: downloadValue,
                              width: 0.1,
                              sizeUnit: GaugeSizeUnit.factor,
                              cornerStyle: CornerStyle.startCurve,
                              color: const Color(0xFF00a9b5),
                            ),
                          ],
                        )
                      ]),
                    ),
                    Positioned(
                      left: 3,
                      top: 3,
                      right: 3,
                      bottom: 3,
                      child: Material(
                        color: Colors.white,
                        shadowColor: Colors.grey.withAlpha(100),
                        elevation: 10,
                        borderRadius: BorderRadius.circular(1000),
                        child: InkWell(
                          onTap: downloadValue == 0
                              ? onDownload
                              : onCancelDownload,
                          borderRadius: BorderRadius.circular(1000),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              downloadValue == 0
                                  ? Icons.download_rounded
                                  : Icons.stop_rounded,
                              color: const Color(0xFF32769E),
                              size: size.height * .0225,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * .04,
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF565656),
                    fontSize: size.width * .029,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'YekanBakh-Regular',
                  ),
                ),
                SizedBox(
                  height: size.height * .005,
                ),
                Text(
                  description,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xFF828282),
                    fontSize: size.width * .0265,
                    fontFamily: 'YekanBakh-Regular',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
