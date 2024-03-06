// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychat_app/common/repositories/common_firebase_storage_repo.dart';
import 'package:mychat_app/common/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:mychat_app/models/group.dart' as model;

final groupRepositoryProvider = Provider(
  (ref) => GroupRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class GroupRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  GroupRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void createGroup(BuildContext context, String name, File profilePic,
      List<Contact> selectedContact) async {
    try {
      List<String> uids = [];
      for (int i = 0; i < selectedContact.length; i++) {
        var userCollection = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: selectedContact[i]
                  .phones[0]
                  .number
                  .replaceAll(
                    ' ',
                    '',
                  )
                  .replaceAll(
                    '-',
                    '',
                  ),
            )
            .get();
        print(selectedContact[i]
            .phones[0]
            .number
            .replaceAll(
              ' ',
              '',
            )
            .replaceAll(
              '-',
              '',
            ));
        userCollection.docs.forEach((doc) {
          print(doc.data());
        });
        print('Here asr');
        print(userCollection.docs.isNotEmpty && userCollection.docs[0].exists);
        print(userCollection.docs);
        if (userCollection.docs.isNotEmpty && userCollection.docs[0].exists) {
          uids.add(userCollection.docs[0].data()['uid']);
        }
      }

      var groupId = const Uuid().v1();

      String profileUrl =
          await ref.read(commonFirebaseStorageRepository).storeFileToFirebase(
                'group/$groupId',
                profilePic,
              );
      model.Group group = model.Group(
        senderId: auth.currentUser!.uid,
        name: name,
        groupId: groupId,
        lastMessage: '',
        groupPic: profileUrl,
        membersUid: [auth.currentUser!.uid, ...uids],
        timeSent: DateTime.now(),
      );

      await firestore.collection('groups').doc(groupId).set(group.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
