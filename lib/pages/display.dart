import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String pass;
  Display({@required this.pass});

  final TextStyle heading = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  final TextStyle body = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firestore.instance.document('registered/$pass').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Center(
                child: Text('Something went wrong! Try again.'),
              );
            if (!snapshot.data.exists)
              return Center(
                child: Text('User not registered!'),
              );
            return Padding(
              padding: const EdgeInsets.only(
                  top: 50.0, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        getImage(
                          context: context,
                          url: snapshot.data['photoUrl'],
                          name: snapshot.data['name'],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data['name'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data['email'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Transaction ID:',
                          style: heading,
                        ),
                        Text(
                          snapshot.data['txnId'] ?? '',
                          style: body,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Approval Reference Number:',
                          style: heading,
                        ),
                        Text(
                          snapshot.data['approvalRefNumber'] ?? '',
                          style: body,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Status:',
                          style: heading,
                        ),
                        Text(
                          snapshot.data['status'],
                          style: body,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget getImage({String url, String name, BuildContext context}) {
    if (url == null || url.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        height: 100,
        width: 100,
        child: Text(
          name[0],
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            url,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
