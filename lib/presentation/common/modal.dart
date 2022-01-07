import 'package:flutter/material.dart';

class Modal {

  mainBottomSheet(BuildContext context, String description) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return new Container(
              //alignment: Alignment.center,
              height: 400,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          30),
                      topRight: Radius.circular(
                          30))),
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                appBar: new AppBar(
                  centerTitle: true,
                  title: new Text('Description', style: new TextStyle(
                    color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20
                      ),),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                          30)
                    ),
                  ),
                  elevation: 0,
                  automaticallyImplyLeading: false,
                ),
                body: new SingleChildScrollView(
                  child: new Column(
                    children: [
                      new Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: new Text(
                          description,
                          textAlign: TextAlign.justify,
                        )
                      )
                    ],
                  )
                )
              )
          );
        }
    );
  }
}