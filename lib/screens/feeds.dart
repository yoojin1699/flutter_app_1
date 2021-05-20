import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/stream_builder_wrapper.dart';
import 'package:flutter_application_1/utils/firebase.dart';
import 'package:flutter_application_1/model/post.dart';
import 'package:flutter_application_1/widgets/appbar_widget.dart';
import 'package:flutter_application_1/widgets/userpost.dart';

//헤헤 이거 필요없숨.
// time line 이 우리가 생각하는 feed 올라오는 곳.  
class Timeline extends StatelessWidget {
 final  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key가 필요 
      key: scaffoldKey,
      appBar: buildAppBar(context),
      body: ListView(
        // body 부분 
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          StreamBuilderWrapper(
            shrinkWrap: true,
            // 시간 순서 대로 정렬 
            stream: postRef.orderBy('timestamp', descending: true).snapshots(),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, DocumentSnapshot snapshot) {
              internetChecker();
              // post .dart 공부가 선행되어야 함 .! 
              //이게 포스트 불러 오는 것. 
             PostModel posts = PostModel.fromJson(snapshot.data());
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
           //       child: Posts(post: posts),
                // user 의 포스트 가져옴 -> userpost.dart 공부 
                child: UserPost(post: posts),
              );
            },
          ),
        ],
      ),
    );
  }

  internetChecker() async {
    // internet check 되었는지 확인 . 
    bool result = await DataConnectionChecker().hasConnection;
    if (result == false) {
      showInSnackBar('No Internet Connecton');
    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }
}
