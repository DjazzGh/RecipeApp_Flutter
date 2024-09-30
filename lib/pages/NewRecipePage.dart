import 'package:flutter/material.dart';
import 'SaltyRecipePage.dart';
import 'SugaryRecipePage.dart';

class NewRecipePage extends StatelessWidget {
  const NewRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Category',
        style: TextStyle(
            color: Colors.white,
                fontSize: 25,
          fontWeight: FontWeight.bold,

        )),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,

      ),
      body: Center(
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90, bottom: 10),
            child: GestureDetector(
              onTap: () {
                // Navigate to the Salty recipe page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaltyRecipePage()),
                );
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Salt.png'),

                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 10, // Extends the shadow beyond the box
                      blurRadius: 7, // Blurs the shadow
                    ),
                  ],
                ),

              ),
            ),
            ),
             Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Salty',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust color if needed
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between widgets
      Padding(
        padding: const EdgeInsets.only(top:30,bottom: 10),
        child:GestureDetector(

              onTap: () {
                // Navigate to the Sugary recipe page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SugaryRecipePage()),
                );
              },
              child: Container(
                width: 200,
                height: 200,

                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/Sugar.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 10, // Extends the shadow beyond the box
                      blurRadius: 7, // Blurs the shadow
                    ),
                  ],
                ),

              ),
            ),
      ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Sugary',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust color if needed
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}