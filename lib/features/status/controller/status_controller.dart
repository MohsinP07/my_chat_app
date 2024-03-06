import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychat_app/features/auth/controller/auth_controller.dart';
import 'package:mychat_app/features/status/repository/status_repository.dart';
import 'package:mychat_app/models/status_model.dart';

final statusControllerProvider = Provider((ref) {
  final statusRepository = ref.read(statusRepositoryProvider);
  return StatusController(
    statusRepository: statusRepository,
    ref: ref,
  );
});

class StatusController {
  final StatusRepository statusRepository;
  final ProviderRef ref;
  StatusController({
    required this.statusRepository,
    required this.ref,
  });

  Stream<List<Status>> viewStatus() {
    return statusRepository.getStatusesMap();
  }

  Stream<List<Status>> statusStream() {
    return statusRepository.getStatusStream();
  }

  Stream<List<Status>> viewStatusCurrentUser() {
    return statusRepository.getStatusesMapCurrentUser();
  }

  Stream<List<Status>> statusStreamCurrentUser() {
    return statusRepository.getStatusStreamCurrentUser();
  }

  void addStatus(File file, BuildContext context) {
    ref.watch(userDataAuthProvider).whenData((value) {
      statusRepository.uploadStatus(
        username: value!.name,
        profilePic: value.profilePic,
        phoneNumber: value.phoneNumber,
        statusImage: file,
        context: context,
      );
    });
  }

  Future<List<Status>> getStatus(BuildContext context) async {
    List<Status> statuses = await statusRepository.getStatus(context);
    return statuses;
  }
}
