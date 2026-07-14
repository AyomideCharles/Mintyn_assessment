import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpendChartCard extends StatefulWidget {
  const SpendChartCard({super.key});

  @override
  State<SpendChartCard> createState() => _SpendChartCardState();
}

class _SpendChartCardState extends State<SpendChartCard> {
  static const Color _accentBlue = Color(0xFF4B7BEC);

  final List<double> _values = [10, 22, 15, 24, 20, 34, 27, 30, 26, 40];
  final List<String> _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

  int? _touchedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF16161A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Total Spend',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '30\$',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _accentBlue),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Weekly',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.white12, height: 1),
          SizedBox(
            height: 320,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: LineChart(_buildChartData()),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _buildChartData() {
    final spots = List.generate(
      _values.length,
      (i) => FlSpot(i.toDouble(), _values[i]),
    );

    return LineChartData(
      minY: 0,
      maxY: _values.reduce((a, b) => a > b ? a : b) + 10,
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => Colors.white,
          tooltipBorderRadius: BorderRadius.circular(8),
          tooltipPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '\$${(spot.y * 122).toStringAsFixed(0)}',
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              );
            }).toList();
          },
        ),
        getTouchedSpotIndicator: (barData, indicators) {
          return indicators.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(color: Colors.white, strokeWidth: 1, dashArray: [4, 4]),
              FlDotData(
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(
                      radius: 6,
                      color: _accentBlue,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    ),
              ),
            );
          }).toList();
        },
        touchCallback: (event, response) {
          if (response?.lineBarSpots?.isNotEmpty ?? false) {
            setState(
              () => _touchedIndex = response!.lineBarSpots!.first.x.toInt(),
            );
          }
        },
      ),
      showingTooltipIndicators: _touchedIndex == null
          ? []
          : [
              ShowingTooltipIndicators([
                LineBarSpot(
                  _lineBarData(spots),
                  0,
                  spots[_touchedIndex!.clamp(0, spots.length - 1)],
                ),
              ]),
            ],
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: (spots.length / _months.length).ceilToDouble(),
            getTitlesWidget: (value, meta) {
              final monthIndex = (value / (spots.length / _months.length))
                  .round();
              if (monthIndex < 0 || monthIndex >= _months.length) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _months[monthIndex],
                  style: const TextStyle(color: Colors.white54, fontSize: 15),
                ),
              );
            },
          ),
        ),
      ),
      lineBarsData: [_lineBarData(spots)],
    );
  }

  LineChartBarData _lineBarData(List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      curveSmoothness: 0.35,
      color: _accentBlue,
      barWidth: 2,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_accentBlue.withOpacity(0.5), _accentBlue.withOpacity(0.0)],
        ),
      ),
    );
  }
}
