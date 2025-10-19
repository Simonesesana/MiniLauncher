import 'package:minilauncher/Packages/Contacts.dart';
import 'package:minilauncher/Packages/GlobalProperties/TextFieldDecoration.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectFavouriteContacts extends StatefulWidget {
  const SelectFavouriteContacts({Key? key}) : super(key: key);

  @override
  _SelectFavouriteContactsState createState() => _SelectFavouriteContactsState();
}

class _SelectFavouriteContactsState extends State<SelectFavouriteContacts> {

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

    /// Screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: preferences.selectedTheme.primaryColor,

      /// AppBar
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        backgroundColor: preferences.selectedTheme.textColor.withOpacity(0.1),

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)
            )
        ),

        title: Text(
          "Favourite contacts",
          style: GoogleFonts.montserrat(
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
              color: preferences.selectedTheme.textColor,
              fontSize: screenWidth / 20
          ),
        ),

        /// Back button
        leading: IconButton(
          color: preferences.selectedTheme.textColor,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 17,
            color: preferences.selectedTheme.textColor,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      /// App list
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(

          children: [

            /// Text field
            Padding(
              padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 5
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

                  decoration: searchBarTextFieldDecoration(screenWidth),
                ),
              ),
            ),

            /// Contacts list
            Flexible(
              child: ListView.builder(
                itemCount: Contacts.contacts.length,
                itemBuilder: (context, index){
                  return isSearched(Contacts.contacts[index].name)
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// Contact
                      SizedBox(
                        width: screenWidth - 100,
                        child: ListTile(

                          leading: CircleAvatar(
                            backgroundColor: preferences.selectedTheme.textColor.withOpacity(0.5),
                            child: Text(
                              Contacts.contacts[index].name.isNotEmpty
                                  ? Contacts.contacts[index].name[0].toUpperCase()
                                  : "",
                              style: GoogleFonts.montserrat(
                                  color: preferences.selectedTheme.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),
                            )
                          ),

                          title: Text(
                            Contacts.contacts[index].name,
                            style: GoogleFonts.montserrat(
                                color: preferences.selectedTheme.textColor,
                                fontSize: MediaQuery.of(context).size.width / 25
                            ),
                          ),
                          subtitle: Text(
                            Contacts.contacts[index].phoneNumber,
                            style: GoogleFonts.montserrat(
                                color: preferences.selectedTheme.textColor.withOpacity(0.7),
                                fontSize: MediaQuery.of(context).size.width / 30
                            ),
                          ),
                        ),
                      ),

                      /// Favourite button
                      IconButton(
                        onPressed: (){

                          /// Adds or removes app from favourite
                          if(isFavourite(Contacts.contacts[index].phoneNumber)) {
                            Contacts.removeFavouriteContact(Contacts.contacts[index].phoneNumber);
                          } else {
                            Contacts.addFavouriteContact(Contacts.contacts[index].name, Contacts.contacts[index].phoneNumber);
                          }

                          /// Updates interface
                          setState(() {});

                        },
                        icon: !isFavourite(Contacts.contacts[index].phoneNumber) ? Icon(
                            Icons.favorite_border_outlined,
                            color: preferences.selectedTheme.textColor
                        ) : Icon(
                            Icons.favorite,
                            color: preferences.selectedTheme.textColor
                        ),
                      )

                    ],
                  )
                      : const SizedBox();
                },
              ),
            ),

          ],
        ),
      ),

    );
  }
}
