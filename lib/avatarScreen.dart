import 'package:flutter/material.dart';
import 'package:flutter_application_4/categoryScreen.dart';

class AvatarScreen extends StatefulWidget {
  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  int? _selectedAvatarIndex;
  late String name;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the arguments passed from the previous screen
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      name = args['name'];
    } else {
      // Handle the case where no arguments were passed
      name = 'Default Name'; // or some default value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 205, 204, 1),
        title: Text('Select Your Avatar'),
      ),
      body: Container(
        color: Color.fromRGBO(239, 205, 204, 1),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatarIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedAvatarIndex == index
                              ? Colors.blue
                              : Colors.transparent,
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/avatar_$index.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _selectedAvatarIndex == null
                  ? null
                  : () {
                      Navigator.pushNamed(
                        context,
                        '/category',
                        arguments: {
                          'name': name,
                          'selectedAvatarIndex': _selectedAvatarIndex,
                        },
                      );
                    },
              child: Text('Next', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 41, 107, 212)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
