import 'package:flutter/material.dart';
import 'package:lai_hock_chun_signup_flutter_exercise/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sign Up page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  //final String image_url = "https://image.pngaaa.com/24/968024-middle.png";
  bool isButtonEnabled = false;


  //Drop-down-value
  String dropdownvalue = 'Select Gender';
  List<String> items =  ['Select Gender','Male','Female','Prefer not to say'];

  var children;



 @override
  void dispose() {
    email.dispose();
    name.dispose();
    password.dispose();
    super.dispose();
  }
 

late bool _isFullyEntered = false;

  @override
  void initState() {
    super.initState();
    email.addListener(() {
      _isFullyEntered = _checkFullyEntered(email.text);
      setState((){});
    });
    name.addListener(() {
      _isFullyEntered = _checkFullyEntered(name.text);
      setState((){});
    });
    password.addListener(() {
      _isFullyEntered = _checkFullyEntered(password.text);
      setState((){});
    });

    autoLogIn();
  }

  bool _checkFullyEntered(String text){
    if(email.text == '') return false;
    if(name.text == '') return false;
    if(password.text == '') return false;
    if(dropdownvalue == 'Select Gender') return false;
    
    return true;
  }


   late bool isLoggedIn = false;
  
  late String emaillogin = '';



  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? emailId = prefs.getString('email');

    if (emailId != null) {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Mainpage()));
    }
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', '');

    setState(() {
      emaillogin = '';
      isLoggedIn = false;
    });
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emaillogin);

    setState(() {
      email.text = emaillogin;
      isLoggedIn = true;
    });

    email.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView (
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           
            Container(
            child: Text(
              'Welcome to Foxit',
              style: TextStyle(
                          color: Colors.brown.shade400,
                          fontWeight: FontWeight.bold,
                        
                          fontSize: 60),
            ),
            
            ),

            //Logo

            Container(
                  height: 240.0,
                  width: 240.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          '/home/lai/Besquare/3-Mobile-Dev/lai_hock_chun_signup_flutter_exercise/Foxit.png'),
                    fit: BoxFit.fill,
                  ),
                ),
            ),
            
            //Username

            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
             margin: EdgeInsets.all(16),
                  child: TextField(
              controller: name,
              maxLines: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name'),
              onSubmitted: (String value) => print(value),
            ),
            ),

          //Email

           Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
             margin: EdgeInsets.all(16),
                  child: TextField(
              controller: email,
              maxLines: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
              onSubmitted: (String value) => print(value),
            ),
            ),

            //Password
           
          Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  margin: EdgeInsets.all(16),
            child: TextField(
              controller: password,
              maxLines: 1,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
              onSubmitted: (String value) => print(value),
            ),
                
          ),
                
          //Gender

          Container(
                  // padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  // margin: EdgeInsets.all(16),
                  child: DropdownButton(
                      value: dropdownvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items:items.map((String items) {
                          return DropdownMenuItem(
                           value: items,
                           child: Text(items)
                       );
                  }
                  ).toList(),
                onChanged: (String? newValue){
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                  
                },
              ),
          ),

        
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: 
               ElevatedButton(
                 style: ButtonStyle(
                    foregroundColor: _isFullyEntered ? MaterialStateProperty.all<Color>(Colors.green) :MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    

                // onPressed: () {
                //                 isLoggedIn ? logout() : loginUser();                
                //               },


              onPressed:_isFullyEntered ? () {
                isLoggedIn ? logout() : loginUser(); 
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Mainpage()),
                      );
              } : null,
              child: Text('Submit', style: TextStyle(color: Colors.white),),
            ),
          ),
              ],
            ),
            ) ,
          
        ),
    );
  }
 

}
