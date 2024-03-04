import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './SettingsScreen.dart';
import '../services/ssh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Change the color here
        title: const Text('Button Example'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    SSH ssh = SSH();
                    await ssh.connectToLG();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Are you sure you want to reboot?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                ssh.rebootLG();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Reboot LG'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    SSH ssh = SSH();
                    await ssh.connectToLG();
                    await ssh.cleanKML();
                    await ssh.cleanSlaves();

                    SSHSession? sshSession = await ssh.flyToOrbit(41.6167, 0.6222, 2000, 45, 0);
                    if (sshSession != null) {
                      print('Going to Lleida');
                    }else{
                      print('Error going to Lleida');
                    }
                    //DONE
                  },
                  child: Text('Go to Lleida'),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    SSH ssh = SSH();
                    await ssh.connectToLG();
                    await ssh.orbitAtMyCity();
                    print("orbitando");
                    //DONE
                    // Future<void> _buildOrbit() async {
                    //   final lookAt = LookAtEntity(
                    //       lng: 0.6222, //ficar valors de la funcio go  to lleida
                    //       lat: 41.6167, //ficar valors de la funcio go  to lleida
                    //       range: '1500',
                    //       tilt: 45, //ficar valors de func go to lleida
                    //       heading: '0',
                    //       zoom: 15);  //ficar valors de func go to lleida
                    //   final orbit = OrbitEntity.buildOrbit(OrbitEntity.tag(lookAt));
                    //   await LGService.shared?.sendOrbit(orbit, "Orbit");
                    // }
                  },
                  child: Text('Orbit city'),
                ),
                SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () async {
                    SSH ssh = SSH();
                    await ssh.connectToLG();
                    await ssh.cleanKML();
                    await ssh.cleanSlaves();
                    await ssh.sendKMLToSlave();
                    print("printing name in display");
                   },
                  child: Text('Add Names'),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }

}