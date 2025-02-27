import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/learner/Screens/LearnerDashboard.dart';
import 'package:prokit_flutter/fullApps/learner/Screens/LearnerSignUp.dart';
import 'package:prokit_flutter/fullApps/learner/utils/LearnerColors.dart';
import 'package:prokit_flutter/fullApps/learner/utils/LearnerImages.dart';
import 'package:prokit_flutter/fullApps/learner/utils/LearnerStrings.dart';
import 'package:prokit_flutter/fullApps/learner/utils/LearnerWidget.dart';

import '../../../main.dart';

class LearnerLogin extends StatefulWidget {
  static String tag = '/LearnerModrenMedicine';

  @override
  _LearnerLoginState createState() => _LearnerLoginState();
}

class _LearnerLoginState extends State<LearnerLogin> {
  @override
  Widget build(BuildContext context) {
    var width = context.width();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: learner_colorPrimary),
                onPressed: () {
                  finish(context);
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: learner_white, width: 4),
                    ),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(learner_ic_Profile),
                      radius: width / 7,
                    ),
                  ),
                  32.height,
                  LearnerEditTextStyle(learner_hint_email, TextInputType.emailAddress, isPassword: false).paddingSymmetric(horizontal: 40),
                  16.height,
                  LearnerEditTextStyle(learner_hint_password, TextInputType.text, isPassword: true).paddingSymmetric(horizontal: 40),
                  48.height,
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 120,
                      alignment: Alignment.center,
                      child: LearnerButton(
                        onPressed: () {
                          LearnerDashboard().launch(context);
                        },
                        textContent: learner_lbl_enter,
                      ),
                    ),
                  ),
                  16.height,
                ],
              ),
            ).center(),
            64.height,
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(learner_lbl_don_t_joined_yet, style: boldTextStyle(color: appStore.textSecondaryColor)),
                  8.width,
                  Text(learner_lbl_join, style: boldTextStyle(color: learner_colorPrimary)),
                ],
              ).onTap(() {
                LearnerSignUp().launch(context);
              }),
            )
          ],
        ),
      ),
    );
  }
}
