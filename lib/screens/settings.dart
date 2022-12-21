import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:swara/screens/Settings/privacy_screen.dart';
import 'package:swara/screens/Settings/terms_&_conditions.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool vlue = true;
  bool music_notifctn = true;
  AssetsAudioPlayer audioplyr = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade800,
        body: SafeArea(
            child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//------------------------------(Space between tiltle text and settings field)----------------------------------------------------------------
              SizedBox(
                height: 10,
              ),
//---------------------------------(Title Page)----------------------------------------------------------------------------------------------
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ),
//------------------------------(Space between tiltle text and settings field)----------------------------------------------------------------
              SizedBox(
                height: 50,
              ),
//------------------------------(Notification text and Toggle button)------------------------------------------------------------------------------------------
              ListTile(
                title: Text(
                  'Notification',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                ),
                trailing: Switch.adaptive(
                    value: this.vlue,
                    thumbColor: MaterialStateProperty.all(Colors.white),
                    trackColor: MaterialStateProperty.all(Colors.white30),
                    onChanged: (value) {
                      setState(() {
                        audioplyr.showNotification = music_notifctn;
                        this.vlue = value;
                      });
                    }),
                onTap: () {},
              ),
//----------------------------(Terms And Conditions)---------------------------------------------------------------------------------------------------
              ListTile(
                title: Text(
                  'Terms And Conditiions',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditionsPage()));
                },
              ),
//----------------------------(Privacy Policy)---------------------------------------------------------------------------------------------------
              ListTile(
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PrivacyPolicyPage())));
                },
              ),
//----------------------------(About)---------------------------------------------------------------------------------------------------
              ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                onTap: () {
                  showAboutDialog(
                      context: context,
                      applicationName: 'Swara',
                      applicationVersion: "0.0.1",
                      applicationIcon: Image.asset(
                        "assets/Image/swaralogo.png",
                        height: 32,
                        width: 32,
                      ),
                      children: [
                        Text(
                          'Swara is an offline music player app which allows use to hear music from their storage and also do functions like add to favorites , create playlists , recently played , mostly played etc.',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'App developed by Prayag T K',
                        )
                      ]);
                },
              ),
//------------------------(Space between Settings fields and versions)-------------------------------------------------------------------
              SizedBox(
                height: 300,
              ),
//------------------------(Version Info.)------------------------------------------------------------------------------------------------
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Text(
                  'Version 0.0.1',
                  style: TextStyle(color: Colors.white24),
                ),
              )
            ],
          ),
        )));
  }
}
