import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CarSpeedGauge extends StatelessWidget {
  const CarSpeedGauge({
    required this.value,
    super.key,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 200,
          showLabels: false,
          startAngle: 180,
          endAngle: 360,
          canScaleToFit: true,
          showLastLabel: true,
          interval: 25,
          labelFormat: '{value}%',
          labelsPosition: ElementsPosition.outside,
          minorTickStyle: const MinorTickStyle(
            length: 0.03,
            thickness: .5,
            color: Colors.black,
            lengthUnit: GaugeSizeUnit.factor,
          ),
          majorTickStyle: const MajorTickStyle(
            length: 0.1,
            thickness: .5,
            color: Colors.black,
            lengthUnit: GaugeSizeUnit.factor,
          ),
          minorTicksPerInterval: 2,
          tickOffset: 1.5,
          axisLabelStyle: const GaugeTextStyle(fontSize: 0),
          axisLineStyle: const AxisLineStyle(
            thickness: 1.5,
            color: Color(0xFf32769E),
          ),
          pointers: <GaugePointer>[
            NeedlePointer(
              value: value,
              needleStartWidth: .5,
              needleEndWidth: 2,
              needleLength: 0.7,
              needleColor: const Color(0xFF5B5746),
              knobStyle: const KnobStyle(
                knobRadius: 4,
                borderColor: Color(0xFF5B5746),
                color: Color(0xFFDCDACB),
                borderWidth: 1.5,
                sizeUnit: GaugeSizeUnit.logicalPixel,
              ),
              tailStyle: const TailStyle(
                color: Color(0xFF5B5746),
                width: 1.5,
                lengthUnit: GaugeSizeUnit.logicalPixel,
                length: 12,
              ),
            )
          ],
        ),
      ],
    );
  }
}
