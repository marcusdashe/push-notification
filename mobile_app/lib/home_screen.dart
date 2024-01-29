import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String message = "";

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)!.settings.arguments;

    if(arguments != null){
      Map? pushArguments = arguments as Map;

      setState(() {
        message = pushArguments["message"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Center(
              child: Container(
                child: Text("Notification : $message"),
              ),
            ),
          ),
        )
    );
  }
}
