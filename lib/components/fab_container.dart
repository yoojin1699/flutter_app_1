import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/posts/create_post.dart';
import 'package:flutter_application_1/widgets/appbar_widget.dart';
//import 'file:///C:/Users/success/social_media_app/lib/posts/create_post.dart';

class FabContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
       appBar: buildAppBar(context),
      body :  FlatButton(
          child: Text ("Make a post "),
          onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatePost()));
          }, 
        )
    );
  }

  /*chooseUpload(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(
                    'SELECT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.camera_on_rectangle,
                  size: 25.0,
                ),
                title: Text('Make a Post'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => CreatePost()));
                },
              ),
            ],
          ),
        );
      },
    );
  }*/
}
