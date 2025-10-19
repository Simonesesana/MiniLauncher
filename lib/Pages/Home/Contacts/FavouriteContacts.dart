import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Packages/Contacts.dart';
import 'package:minilauncher/Pages/Home/Contacts/ContactItem.dart';
import 'package:minilauncher/main.dart';

Widget favouriteContacts(BuildContext context) {
  return Card(
    color: preferences.selectedTheme.textColor.withOpacity(0.2),
    child: Column(
      children: [

        // Title
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Favourite Contacts:",
              style: GoogleFonts.montserrat(
                  color: preferences.selectedTheme.textColor,
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),

        ListView.builder(
          shrinkWrap: true,
          itemCount: Contacts.favouriteContacts.length,
          itemBuilder: (context, index) {
            return contactItem(
                Contacts.favouriteContacts[index].name,
                Contacts.favouriteContacts[index].phoneNumber,
                MediaQuery.of(context).size.width
            );
          },
        ),
      ],
    ),
  );
}