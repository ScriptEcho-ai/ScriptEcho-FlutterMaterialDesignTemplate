import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/food/model/FoodModel.dart';
import 'package:prokit_flutter/fullApps/food/utils/FoodColors.dart';
import 'package:prokit_flutter/fullApps/food/utils/FoodDataGenerator.dart';
import 'package:prokit_flutter/fullApps/food/utils/FoodString.dart';
import 'package:prokit_flutter/fullApps/food/utils/FoodWidget.dart';

import 'FoodDashboard.dart';

class FoodCreateAccount extends StatefulWidget {
  static String tag = '/FoodCreateAccount';

  @override
  FoodCreateAccountState createState() => FoodCreateAccountState();
}

class FoodCreateAccountState extends State<FoodCreateAccount> {
  late List<images> mList;

  @override
  void initState() {
    super.initState();
    mList = addUserPhotosData();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: width,
                alignment: Alignment.topLeft,
                // color: food_white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    finish(context);
                  },
                ),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food_lbl_create_your_account_and_nget_99_money, style: boldTextStyle(size: 24), maxLines: 2),
                  Text(food_lbl_its_s_super_quick, style: primaryTextStyle()),
                ],
              ).paddingOnly(left: 16, right: 16),
              SizedBox(height: 30.0),
              HorizontalList(
                itemCount: mList.length,
                padding: EdgeInsets.zero,
                runSpacing: 0,
                spacing: 0,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 16),
                    child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(mList[index].image), radius: 45),
                  );
                },
              ),
              SizedBox(height: 24),
              Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(color: context.cardColor, borderRadius: BorderRadius.circular(50), border: Border.all(color: food_colorPrimary)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16.0),
                          isDense: true,
                          hintText: food_hint_mobile_no,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          FoodDashboard().launch(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(14.0),
                          decoration: gradientBoxDecoration(radius: 50, gradientColor1: food_color_blue_gradient1, gradientColor2: food_color_blue_gradient2),
                          child: Icon(Icons.arrow_forward, color: food_white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
