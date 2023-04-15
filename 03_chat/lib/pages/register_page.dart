import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/blue_button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  const RegisterPage({super.key});


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
                Logo(title: 'Register'),
                _Form(),
                Labels(route: 'login', accountText: 'Do you have one?', labelText: 'Access with your own',),
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
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>( context );

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput( 
            icon: Icons.perm_identity,
            placeholder: 'Name',
            textEditingController: nameCtrl,   
          ),
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
            textButton: 'Create account',
            onPressed: authService.authenticating ? null : () async {

              FocusScope.of(context).unfocus();
              final registerOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), pwdCtrl.text.trim());

              if ( registerOk == true && context.mounted ) {
                Navigator.pushReplacementNamed(context, 'users');
              } else {
                showAlert( context, 'Incorrect register', registerOk );
              }

            })
          
        ],
      ),
    );
  }
}

