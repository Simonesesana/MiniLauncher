import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Packages/Contacts.dart';
import 'package:minilauncher/Packages/GlobalProperties/TextFieldDecoration.dart';
import 'package:minilauncher/Pages/Home/Contacts/ContactItem.dart';
import 'package:minilauncher/Pages/Home/Contacts/FavouriteContacts.dart';
import 'package:minilauncher/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  /// Search bar text
  String searchText = "";

  /// This function determines if the contact is set as favourite
  bool isFavourite(String phoneNumber) {
    for(Contact contact in Contacts.favouriteContacts) {
      if(contact.phoneNumber == phoneNumber) {
        return true;
      }
    }
    return false;
  }

  /// This function determines if the contact is being searched in the search bar
  bool isSearched(String contactName) {

    if(searchText==""){
      return true;
    }

    if(contactName.toLowerCase().contains(searchText.toLowerCase())){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: preferences.selectedTheme.primaryColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
          child: Column(
            children: [

              // Favourite contact
              favouriteContacts(context),

              // Text field
              Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 5,
                    left: 10,
                    right: 10
                ),
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: TextField(
                    onChanged: (String value) {
                      setState(() {
                        searchText = value;
                      });
                    },

                    style: GoogleFonts.montserrat(
                        color: preferences.selectedTheme.textColor,
                        fontSize: MediaQuery.of(context).size.width / 25
                    ),

                    decoration: InputDecoration(

                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                        color: preferences.selectedTheme.textColor,
                      ),

                      contentPadding: EdgeInsets.zero,

                      // Hint text
                      hintText: "Search a contact",
                      hintStyle: GoogleFonts.montserrat(
                          letterSpacing: 0.5,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery.of(context).size.width / 25
                      ),

                      // Border decoration
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: preferences.selectedTheme.textColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 1,
                          color: preferences.selectedTheme.textColor,
                        ),
                      ),

                    ),
                  ),
                ),
              ),

              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Contacts.contacts.length,
                  itemBuilder: (context, index) {
                    return isSearched(Contacts.contacts[index].name) ? contactItem(
                        Contacts.contacts[index].name,
                        Contacts.contacts[index].phoneNumber,
                        MediaQuery.of(context).size.width) : Container();
                  },
                ),
              ),

            ],
          ),
        )
      ),

    );
  }
}
