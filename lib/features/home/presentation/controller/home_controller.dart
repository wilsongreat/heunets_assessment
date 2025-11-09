import 'package:flutter/cupertino.dart';
import 'package:heunets_assessment_app/features/job/data/model/job_application_model.dart';
import 'package:heunets_assessment_app/features/job/data/model/job_model.dart';

class HomeController extends ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  List<Job> sampleJobs = [
    Job(
      id: '1',
      title: 'Senior Frontend Developer',
      company: 'TechCorp Inc.',
      companyInitial: 'T',
      location: 'San Francisco, CA',
      jobType: 'Full-time',
      timePosted: '2 days ago',
      salaryRange: r'$120k - $160k',
      aboutRole: "We're looking for an experienced Frontend Developer to join our growing team. You'll be working on cutting-edge web applications using React and TypeScript.",
      requirements: [
        '5+ years of experience with React',
        'Strong TypeScript skills',
        'Experience with modern frontend tools',
        'Excellent communication skills',
      ],
      benefits: [
        'Health insurance',
        '401k matching',
        'Remote work',
        'Flexible hours',
      ],
    ),
    Job(
      id: '2',
      title: 'React Developer',
      company: 'StartupXYZ',
      companyInitial: 'S',
      location: 'Remote',
      jobType: 'Full-time',
      timePosted: '1 week ago',
      salaryRange: r'$100k - $140k',
      aboutRole: "Join our fast-paced startup as a React Developer. You'll be building user-facing features and working closely with our design team.",
      requirements: [
        '3+ years of React experience',
        'Proficiency in JavaScript/ES6+',
        'Experience with state management (Redux/Context)',
        'Understanding of RESTful APIs',
      ],
      benefits: [
        'Equity package',
        'Health insurance',
        'Flexible PTO',
        'Remote work',
      ],
    ),
    Job(
      id: '3',
      title: 'Full Stack Engineer',
      company: 'BigTech Co.',
      companyInitial: 'B',
      location: 'New York, NY',
      jobType: 'Full-time',
      timePosted: '3 days ago',
      salaryRange: r'$130k - $180k',
      aboutRole: "We're seeking a Full Stack Engineer to work on our core platform. You'll be involved in both frontend and backend development using modern technologies.",
      requirements: [
        'Experience with React and Node.js',
        'Database design and optimization',
        'API development and integration',
        'Cloud platforms (AWS/GCP)',
      ],
      benefits: [
        'Comprehensive health coverage',
        'Stock options',
        'Learning stipend',
        'Gym membership',
      ],
    ),
    Job(
      id: '4',
      title: 'UI/UX Designer',
      company: 'DesignStudio',
      companyInitial: 'D',
      location: 'Los Angeles, CA',
      jobType: 'Contract',
      timePosted: '5 days ago',
      salaryRange: r'$80k - $110k',
      aboutRole: "Looking for a creative UI/UX Designer to join our design team. You'll be responsible for creating intuitive and beautiful user experiences.",
      requirements: [
        'Proficiency in Figma and Adobe Creative Suite',
        'Strong portfolio of web and mobile designs',
        'Understanding of user-centered design principles',
        'Prototyping and wireframing skills',
      ],
      benefits: [
        'Creative freedom',
        'Latest design tools',
        'Flexible schedule',
        'Professional development',
      ],
    ),
    Job(
      id: '5',
      title: 'Backend Developer',
      company: 'CloudServices Inc.',
      companyInitial: 'C',
      location: 'Remote',
      jobType: 'Full-time',
      timePosted: '1 day ago',
      salaryRange: r'$110k - $150k',
      aboutRole: "Join our backend team to build scalable microservices and APIs. You'll work with cutting-edge cloud technologies and distributed systems.",
      requirements: [
        'Experience with Node.js or Python',
        'Microservices architecture',
        'Database management (SQL/NoSQL)',
        'Docker and Kubernetes',
      ],
      benefits: [
        'Remote-first culture',
        'Health and dental',
        'Unlimited PTO',
        'Tech stipend',
      ],
    ),
    Job(
      id: '6',
      title: 'Mobile Developer',
      company: 'AppMasters',
      companyInitial: 'A',
      location: 'Austin, TX',
      jobType: 'Full-time',
      timePosted: '4 days ago',
      salaryRange: r'$90k - $130k',
      aboutRole: "We're looking for a Mobile Developer to build and maintain our iOS and Android applications using React Native and Flutter.",
      requirements: [
        'Experience with React Native or Flutter',
        'Native iOS/Android development knowledge',
        'App Store and Play Store deployment',
        'Mobile UI/UX best practices',
      ],
      benefits: [
        'Health insurance',
        'Performance bonuses',
        'Conference attendance',
        'Work from home options',
      ],
    ),
  ];

  List<Job> get filteredJobs {
    if (_searchQuery.isEmpty) {
      return sampleJobs;
    }

    return sampleJobs.where((job) {
      final query = _searchQuery.toLowerCase();
      return job.title.toLowerCase().contains(query) ||
          job.company.toLowerCase().contains(query) ||
          job.location.toLowerCase().contains(query) ||
          job.jobType.toLowerCase().contains(query);
    }).toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }



  List<JobApplication> sampleApplications = [
    JobApplication(
      id: 'app_1',
      jobId: '1',
      jobTitle: 'Senior Frontend Developer',
      company: 'TechCorp Inc.',
      companyInitial: 'T',
      appliedDate: '3 days ago',
      status: ApplicationStatus.accepted,
    ),
    JobApplication(
      id: 'app_2',
      jobId: '2',
      jobTitle: 'React Developer',
      company: 'StartupXYZ',
      companyInitial: 'S',
      appliedDate: '1 week ago',
      status: ApplicationStatus.accepted,
    ),
    JobApplication(
      id: 'app_3',
      jobId: '3',
      jobTitle: 'Full Stack Engineer',
      company: 'BigTech Co.',
      companyInitial: 'B',
      appliedDate: '2 weeks ago',
      status: ApplicationStatus.pending,
    ),
    JobApplication(
      id: 'app_3',
      jobId: '3',
      jobTitle: 'Full Stack Engineer',
      company: 'BigTech Co.',
      companyInitial: 'B',
      appliedDate: '2 weeks ago',
      status: ApplicationStatus.rejected,
    ),
  ];


  void addJob({
    required String jobTitle,
    required String companyName,
    required String location,
    required String jobType,
    required String salaryRange,
    required String jobDescription,
    required List<String> requirements,
  }) {
    String newId = (sampleJobs.length + 1).toString();

    String companyInitial = companyName.isNotEmpty ? companyName[0].toUpperCase() : 'C';

    Job newJob = Job(
      id: newId,
      title: jobTitle,
      company: companyName,
      companyInitial: companyInitial,
      location: location,
      jobType: jobType,
      timePosted: 'Just now',
      salaryRange: salaryRange,
      aboutRole: jobDescription,
      requirements: requirements,
      benefits: [
        'Competitive salary',
        'Health insurance',
        'Flexible working hours',
        'Professional development',
      ],
    );

    sampleJobs.insert(0, newJob);

    notifyListeners();
  }

  List<String> parseRequirements(String requirementsText) {
    if (requirementsText.isEmpty) return [];

    return requirementsText
        .split('\n')
        .map((req) => req.trim())
        .where((req) => req.isNotEmpty)
        .toList();
  }


  void addJobApplication({
    required Job job,
    required String applicantName,
    required String applicantEmail,
    required String applicantPhone,
    String? coverLetter,
    String? resumeFileName,
  }) {
    String newApplicationId = 'app_${sampleApplications.length + 1}';

    JobApplication newApplication = JobApplication(
      id: newApplicationId,
      jobId: job.id,
      jobTitle: job.title,
      company: job.company,
      companyInitial: job.companyInitial,
      appliedDate: 'Just now',
      status: ApplicationStatus.pending,
    );

    sampleApplications.insert(0, newApplication);

    notifyListeners();

    if (resumeFileName != null) {
      debugPrint('Resume: $resumeFileName');
    }
  }

  bool hasAppliedToJob(String jobId) {
    return sampleApplications.any((app) => app.jobId == jobId);
  }

  JobApplication? getApplicationForJob(String jobId) {
    try {
      return sampleApplications.firstWhere((app) => app.jobId == jobId);
    } catch (e) {
      return null;
    }
  }
}