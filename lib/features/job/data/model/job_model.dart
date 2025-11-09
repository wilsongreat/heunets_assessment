class Job {
  final String id;
  final String title;
  final String company;
  final String companyInitial;
  final String location;
  final String jobType;
  final String timePosted;
  final String salaryRange;
  final String aboutRole;
  final List<String> requirements;
  final List<String> benefits;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.companyInitial,
    required this.location,
    required this.jobType,
    required this.timePosted,
    required this.salaryRange,
    required this.aboutRole,
    required this.requirements,
    required this.benefits,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      companyInitial: json['companyInitial'],
      location: json['location'],
      jobType: json['jobType'],
      timePosted: json['timePosted'],
      salaryRange: json['salaryRange'],
      aboutRole: json['aboutRole'],
      requirements: List<String>.from(json['requirements']),
      benefits: List<String>.from(json['benefits']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'companyInitial': companyInitial,
      'location': location,
      'jobType': jobType,
      'timePosted': timePosted,
      'salaryRange': salaryRange,
      'aboutRole': aboutRole,
      'requirements': requirements,
      'benefits': benefits,
    };
  }
}