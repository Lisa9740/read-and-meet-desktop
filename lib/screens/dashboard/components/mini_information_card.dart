import 'package:provider/provider.dart';
import 'package:ram_admin/core/constants/color_constants.dart';
import 'package:ram_admin/models/daily_info_model.dart';

import 'package:ram_admin/responsive.dart';
import 'package:ram_admin/screens/dashboard/components/mini_information_widget.dart';
import 'package:ram_admin/screens/forms/input_form.dart';
import 'package:flutter/material.dart';

import '../../../core/providers/daily.info.provider.dart';
import '../../../core/providers/user.provider.dart';

class MiniInformation extends StatelessWidget {
  const MiniInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new FormMaterial();
                    },
                    fullscreenDialog: true));
              },
              icon: Icon(Icons.add),
              label: Text(
                "Add New",
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: InformationCard(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.2 : 1,
          ),
          tablet: InformationCard(),
          desktop: InformationCard(
            childAspectRatio: _size.width < 1400 ? 1.2 : 1.4,
          ),
        ),
      ],
    );
  }
}

class InformationCard extends StatelessWidget {
  InformationCard({
    Key? key,
    this.crossAxisCount = 5,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  List infos = [];

  Future<List> getDailyInfo(context) async {
    infos = await Provider.of<DailyInfoProvider>(context, listen: false).fetchDailyInfo(
        context);
    return infos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container();
        }
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: projectSnap.data!.length,
            itemBuilder: (context, index) {
              DailyInfoModel info = projectSnap.data![index];
              return MiniInformationWidget(dailyData: info);
            }
        );
      },
      future: getDailyInfo(context),
    );
  }
}