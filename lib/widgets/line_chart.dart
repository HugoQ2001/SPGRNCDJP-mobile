import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // Importa el paquete intl
import 'package:appmobiletestis/model/chart_data.dart'; // Asegúrate de que la ruta sea correcta

class LineChartWidget extends StatelessWidget {
  final List<PricePoint> points;

  const LineChartWidget({required this.points, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: AspectRatio(
        aspectRatio: 2,
        child: LineChart(LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1, // Establecer el intervalo de títulos a 4
                getTitlesWidget: (value, meta) {
                  final intIndex = (points.length - value.toInt() - 1); // Invertir el índice
                  if (intIndex < 0 || intIndex >= points.length) return const SizedBox.shrink();
                  final date = points[intIndex].date; // Obtener la fecha del índice invertido
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(DateFormat.MMM().format(date), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(value.toStringAsFixed(0), style: const TextStyle(fontSize: 12));
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
              isCurved: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          gridData: FlGridData(show: true, drawVerticalLine: true),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black),
              bottom: BorderSide(color: Colors.black),
              right: BorderSide.none,
              top: BorderSide.none,
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: const LineTouchTooltipData(tooltipBgColor: Colors.blueAccent),
            handleBuiltInTouches: true,
          ),
          minY: points.isNotEmpty ? points.map((point) => point.y).reduce((a, b) => a < b ? a : b) - 10 : 0, // Ajusta minY si points está vacío
        maxY: points.isNotEmpty ? points.map((point) => point.y).reduce((a, b) => a > b ? a : b) + 10 : 10,
        )),
      ),
    );
  }
}
