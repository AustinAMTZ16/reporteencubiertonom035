import 'package:flutter/material.dart';
import 'package:reporteencubiertonom035/presentacion/view/widgets/complaint_widget.dart';
import 'package:reporteencubiertonom035/presentacion/view/widgets/forms/login_form.dart';
import 'package:reporteencubiertonom035/presentacion/view/widgets/welcome_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final _loginFormKey = GlobalKey<FormState>();
  bool _showWelcomeWidget = true;
  bool _quitWelcomeWidget = false;

  String _idEmpresa = "";
  //String _password = "";

//  double _width = 100;
  // double _height = 100;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false, // Añade esta línea
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: null),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: !_quitWelcomeWidget,
            child: AnimatedOpacity(
              opacity: _showWelcomeWidget ? 1.0 : 0.0,
              duration: const Duration(
                  milliseconds: 1200), // Ajusta la duración según desees
              child: WelcomeWidget(
                screenSize: deviceSize,
              ),
              onEnd: () => setState(() {
                _quitWelcomeWidget = true;
              }),
            ),
          ),
          Expanded(
            child: _formBasic(),
          ),
        ],
      ),
    );
  }

  PageView _formBasic() {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildPage(
            child: LoginForm(
              formKey: _loginFormKey,
              onValidData: ((value) {
                setState(() {
                  _showWelcomeWidget = false;
                  _idEmpresa = value;
                });
                _navigateToNextPage();
              }),
            ),
          );
        } else if (index == 1) {
          return ComplaintWidget(
            empresaId: _idEmpresa,
          );
        }
        return null;
      },
    );
  }

  Widget _buildPage({required Widget child}) {
    return SingleChildScrollView(
      child: child,
    );
  }

  void _navigateToNextPage() {
    FocusScope.of(context).unfocus();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
