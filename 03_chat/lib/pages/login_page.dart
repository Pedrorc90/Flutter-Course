import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/blue_button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: 'Messenger',),
                _Form(),
                Labels(route: 'register', accountText: 'No account?', labelText: 'Create one now!'),
                Text('Users conditions', style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      )
   );
  }
}



class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final authService = Provider.of<AuthService>( context );

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput( 
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textEditingController: emailCtrl,   
          ),
          CustomInput( 
            icon: Icons.lock_outline,
            placeholder: 'Password',
            textEditingController: pwdCtrl,   
            isPassword: true,
          ),
          BlueButton(
            textButton: 'Login',
            onPressed: authService.authenticating ? null : () async {

              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailCtrl.text.trim(), pwdCtrl.text.trim());

              if ( loginOk ) {
                //TODO: Connect to socket server
                if ( context.mounted ) Navigator.pushReplacementNamed(context, 'users');
              } else {
                if ( context.mounted ) showAlert( context, 'Incorrect Login', 'Review the credentials' );
              }

            })
          
        ],
      ),
    );
  }
}

