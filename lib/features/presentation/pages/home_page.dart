import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nasa_app_clean_architecture_tdd/features/presentation/pages/picture_page.dart';
import 'package:nasa_app_clean_architecture_tdd/features/presentation/widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: 'Nasa App'),
      body: ListView(
        children: [
          SvgPicture.asset(
            'assets/images/space.svg',
            height: size.height * 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF233C5C),
              ),
              onPressed: () async {
                var datePicked = await showDatePicker(
                  helpText: "Selecione uma data",
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1995, 06, 16),
                  lastDate: DateTime.now(),
                );
                if (datePicked != null) {
                  PicturePage.navigate(datePicked);
                }
              },
              child: const Text('Selecione uma Data'),
            ),
          )
        ],
      ),
    );
  }
}
