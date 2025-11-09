import 'package:flutter/material.dart';

enum ApplicationStatus {
  pending,
  completed,
  accepted,
  rejected,
}

class JobApplication {
  final String id;
  final String jobId;
  final String jobTitle;
  final String company;
  final String companyInitial;
  final String appliedDate;
  final ApplicationStatus status;
  final String? statusMessage;

  JobApplication({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.company,
    required this.companyInitial,
    required this.appliedDate,
    required this.status,
    this.statusMessage,
  });

  // Helper method to get status display text
  String get statusText {
    switch (status) {
      case ApplicationStatus.pending:
        return 'Pending';
      case ApplicationStatus.completed:
        return 'Completed';
      case ApplicationStatus.accepted:
        return 'Accepted';
      case ApplicationStatus.rejected:
        return 'Rejected';
    }
  }

  Color get statusColor {
    switch (status) {
      case ApplicationStatus.pending:
        return Colors.orange;
      case ApplicationStatus.completed:
        return Colors.purple;
      case ApplicationStatus.accepted:
        return Colors.green;
      case ApplicationStatus.rejected:
        return Colors.red;
    }
  }

  IconData get statusIcon {
    switch (status) {
      case ApplicationStatus.pending:
        return Icons.schedule;
      case ApplicationStatus.completed:
        return Icons.access_time;
      case ApplicationStatus.accepted:
        return Icons.check_circle;
      case ApplicationStatus.rejected:
        return Icons.cancel;
    }
  }

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'],
      jobId: json['jobId'],
      jobTitle: json['jobTitle'],
      company: json['company'],
      companyInitial: json['companyInitial'],
      appliedDate: json['appliedDate'],
      status: ApplicationStatus.values[json['status']],
      statusMessage: json['statusMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobId': jobId,
      'jobTitle': jobTitle,
      'company': company,
      'companyInitial': companyInitial,
      'appliedDate': appliedDate,
      'status': status.index,
      'statusMessage': statusMessage,
    };
  }
}