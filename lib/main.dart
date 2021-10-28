import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  bool isButtonEnabled = false;

  String dropdownvalue = 'Select Gender';
  List<String> items =  ['Select Gender','Male','Female','Prefer not to say'];

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
  }

  bool _checkFullyEntered(String text){
    if(email.text == '') return false;
    if(name.text == '') return false;
    if(password.text == '') return false;
    if(dropdownvalue == 'Select Gender') return false;
    
    return true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Welcome text
            Container(
            child: Text(
              'Welcome to Foxit',
              style: TextStyle(
                          color: Colors.brown.shade400,
                          fontWeight: FontWeight.w500,
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
              //color: _isFullyEntered ? Colors.grey : Colors.orange,
              child: 
             
               ElevatedButton(
                 style: ButtonStyle(
                    foregroundColor: _isFullyEntered ? MaterialStateProperty.all<Color>(Colors.red) :MaterialStateProperty.all<Color>(Colors.green),
                    ),
              onPressed:_isFullyEntered ? () {print("Sucessfully submited");} : null,
              child: Text('Submit'),
            ),
          ),
          ],
        ),
      ),
    );
  }
 

}
