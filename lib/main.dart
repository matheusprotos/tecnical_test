import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_test/constants/http.constants.dart';
import 'package:flutter_interview_test/provider/rest_api_service.dart';

import 'interfaces/policy.dart';
import 'constants/app_constants.dart' as AppConstants;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final RestAPIProvider restAPIProvider = RestAPIProvider.getInstance;
  List<Policy> policies = [];

  @override
  void initState() {
    _loadPolicies();
    super.initState();
  }

  Future<void> _loadPolicies() async {
    try {
      Response<dynamic> policiesResponse = await restAPIProvider
          .getPolicies()
          .catchError((error) => throw error);

      if (policiesResponse.statusCode == HTTPConstants.OK) {
        List<dynamic> responsePolicies = policiesResponse.data;

        setState(() {
          policies = responsePolicies
              .map((dynamic policy) => Policy.fromJson(policy))
              .toList();
        });

        print(responsePolicies);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FLUTTER INTERVIEW TEST'),
        ),
        body: Column(
          children: [
            _logo(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: policies.length,
                itemBuilder: (BuildContext context, int index) =>
                    _policyItem(context, index))
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget _logo() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Image.asset(
          "assets/images/Youse.png",
        ),
      );

  Widget _policyItem(BuildContext context, int index) => Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Image.network(
                  policies[index].imageUrl,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Flexible(
                  child: Text(
                      '${policies[index].title} - ${policies[index].subtitle}'),
                ),
              ],
            ),
            subtitle: Text(policies[index].type),
          ),
          Divider(),
        ],
      );
}
