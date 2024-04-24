import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/model/stats.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminDashboardController());
    controller.getStats();
    return Scaffold(
        backgroundColor: Color(0xFFC4DBF6),
        appBar: AppBar(
          backgroundColor: Color(0xFFC4DBF6),
          title: const Text('Admin Dashboard'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<AdminDashboardController>(
                init: AdminDashboardController(),
                builder: (controller) {
                  if (controller.stats == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var stats = controller.stats;
                  return RefreshIndicator(
                    onRefresh: () async {
                      // await Future.delayed(Duration(seconds: 5));
                      await controller.getStats();
                    },
                    child: GridView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        children: [
                          StatsCard(
                            label: 'Total Income',
                            icon: Icon(Icons.money),
                            isAmount: true,
                            value:
                                controller.stats?.totalIncome.toString() ?? '',
                          ),
                          StatsCard(
                            label: 'Total Users',
                            icon: Icon(Icons.person),
                            value:
                                controller.stats?.totalUsers.toString() ?? '',
                          ),
                          StatsCard(
                            label: 'Total Products',
                            value: controller.stats?.totalProducts.toString() ??
                                '',
                          ),
                          StatsCard(
                            label: 'Total Orders',
                            value:
                                controller.stats?.totalOrders.toString() ?? '',
                          )
                        ]),
                  );
                },
              ),
              Container(
                height: 30,
              ),
              MyButton(
                tittle: 'View Orders',
                onPressed: () {
                  Get.toNamed(Routes.ORDER);
                },
              ),
              MyPieChart(topCategories: controller.stats?.topCategories)
            ],
          ),
        ));
  }
}

class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final Icon? icon;
  final bool isAmount;
  final Color? color;
  const StatsCard(
      {super.key,
      required this.label,
      required this.value,
      this.isAmount = false,
      this.color,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 2,
            color: const Color.fromARGB(255, 99, 51, 51).withOpacity(0.2),
            offset: Offset(1, 1))
      ], color: color ?? Color(0xFF8590AA)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            (isAmount ? 'Rs.' : '') + value,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(187, 0, 0, 0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              icon ?? SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}

class MyPieChart extends StatelessWidget {
  final List<TopCategory>? topCategories;
  const MyPieChart({super.key, required this.topCategories});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      AppColors.contentColorBlue,
      AppColors.contentColorYellow,
      AppColors.contentColorPurple,
      AppColors.contentColorGreen,
      Colors.purpleAccent,
      Colors.orange,
    ];

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              // Indicator(
              //   color: AppColors.contentColorBlue,
              //   text: 'First',
              //   isSquare: true,
              // ),
              children: topCategories!
                  .map((e) => Indicator(
                        isSquare: true,
                        color: colors[topCategories!.indexOf(e)],
                        text: e.categoryTitle ?? '',
                      ))
                  .toList()),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> list = [];
    List<Color> colors = [
      AppColors.contentColorBlue,
      AppColors.contentColorYellow,
      AppColors.contentColorPurple,
      AppColors.contentColorGreen,
      Colors.purpleAccent,
      Colors.orange,
    ];

    list = topCategories!
        .map((e) => PieChartSectionData(
              color: colors[topCategories!.indexOf(e)],
              value: e.percentage!,
              title: '${e.percentage}%',
              radius: 80,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor1,
              ),
            ))
        .toList();
    return list;
    // return List.generate(4, (i) {
    //   const fontSize = 16.0;
    //   const radius = 50.0;
    //   const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    //   switch (i) {
    //     case 0:
    //       return PieChartSectionData(
    //         color: AppColors.contentColorBlue,
    //         value: 40,
    //         title: '40%',
    //         radius: radius,
    //         titleStyle: const TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: AppColors.mainTextColor1,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 1:
    //       return PieChartSectionData(
    //         color: AppColors.contentColorYellow,
    //         value: 30,
    //         title: '30%',
    //         radius: radius,
    //         titleStyle: const TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: AppColors.mainTextColor1,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 2:
    //       return PieChartSectionData(
    //         color: AppColors.contentColorPurple,
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: const TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: AppColors.mainTextColor1,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 3:
    //       return PieChartSectionData(
    //         color: AppColors.contentColorGreen,
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: const TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: AppColors.mainTextColor1,
    //           shadows: shadows,
    //         ),
    //       );
    //     default:
    //       throw Error();
    //   }
    // });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
