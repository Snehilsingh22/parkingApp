import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AmmountScreen extends StatelessWidget {
  final String tappedValue;

  AmmountScreen({required this.tappedValue});

  final vehicleController = TextEditingController();
  final ammountController = TextEditingController();

  void dispose() {
    ammountController.dispose();
    vehicleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Set Ammount',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/doller.gif'),
              height: 200,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                initialValue: tappedValue,
                // controller: vehicleController,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 224, 169, 4)),
                  ),
                ),
                // controller: vehicleController,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: ammountController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    MdiIcons.currencyRupee,
                    color: Colors.amber,
                  ),
                  hintText: 'Enter an ammount',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 224, 169, 4)),
                  ),
                ),
                // controller: vehicleController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextButton(
                    onPressed: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.amber),
                      width: 250,
                      child: ListTile(
                        leading: Icon(
                          MdiIcons.check,
                          color: Colors.black,
                        ),
                        title: const Text('Set Ammount'),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
