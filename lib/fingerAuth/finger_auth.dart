import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:untitled4/welcom.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool isAuthenticated = await authenticate();

            if (isAuthenticated) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Welcome();
                  },
                ),
              );
            } else {
              Container();
            }
          },
          child: const Text('Click Here'),
        ),
      ),
    );
  }

  Future authenticate() async {
    final bool isBiometricsAvailable = await auth.isDeviceSupported();

    if (!isBiometricsAvailable) return false;

    try {
      return await auth.authenticate(
        localizedReason: 'Scan Fingerprint To Enter Vault',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return;
    }
  }
}
