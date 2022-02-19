import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'dart:math';

// Providers
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';

// Screens
import '../default_screen.dart';





enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  // Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  Colors.red.shade700,
                  Colors.red.shade500
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[                 
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text(
                        'Tech Store',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline6?.color,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300
      )
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset( 0, -1.5),
      end: Offset( 0, 0)
    )
      .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear
      )
    );
    // _heightAnimation.addListener( () => setState( () {
    //   })
    // );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0
     )
      .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn
      )
    );
  }  // End of initState

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();    
    super.dispose();
  }

  void _showErrorDialog (
     String message 
    ) {
    String messageToShow;
    if( message == null ) {
      messageToShow = 'An Error Occured';
    } else {
      messageToShow = message;
    }
    showDialog(
      context: context,
      builder: ( ctx ) => AlertDialog(
        title: Text(
          messageToShow
        ),
        content: Text( message ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      )
    );
  }

  Future<void> _submit() async {
    print(' AuthScreen -> AuthCard -> Submit Button');
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    List<dynamic>? submitResponse;
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        submitResponse = await Provider.of<AuthProvider>(context, listen: false).signin(
          _authData['email']!,
          _authData['password']!
        );
      } else {
        // Sign user up
        submitResponse = await Provider.of<AuthProvider>(context, listen: false).signup(
          _authData['email']!,
          _authData['password']!
        );
      }
      print('authScreen -> submit -> token -> ');
      print(
        Provider.of<AuthProvider>(context, listen: false).token
      );
      if( submitResponse != null ) {
        // So there is an error
        _showErrorDialog(
          submitResponse[0]['msg'] as String
        );
      }
      if( Provider.of<AuthProvider>(context, listen: false).token != null  ) {
        Provider.of<AuthProvider>(context,listen: false).recordCredentialstoDevice(
          email: _authData['email']!,
          password: _authData['password']!
        );
        Navigator.of(context).pushReplacementNamed(
          DefaultScreen.routeName
        );
      }

    } catch (err) {
      print('AuthScreen -> Submit Button -> errors');
      print(err);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward(); // Starts animation
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse(); // Reverse animation
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child:  AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 320 : 260,
        // height: _heightAnimation.value.height,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),  
        child:  Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                },
                onSaved: (value) {
                  if ( value != null ) {
                    _authData['email'] = value;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {
                  if ( value != null ) 
                  _authData['password'] = value;
                },
              ),
              // if (_authMode == AuthMode.Signup)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                  maxHeight: _authMode == AuthMode.Signup ? 120 : 0
                ),
                curve: Curves.easeIn,
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    ),
                  ),
                ),
              ),
                
              SizedBox(
                height: 20,
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  child:
                      Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Theme.of(context).primaryTextTheme.button?.color,
                  ),
                ),
              TextButton(
                child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                onPressed: _switchAuthMode,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  primary: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),  
      ), 
    );
  }
}