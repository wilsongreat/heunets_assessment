import 'package:flutter/material.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/utils/gap.dart';
import 'package:heunets_assessment_app/core/widgets/custom_textfield.dart';
import 'package:heunets_assessment_app/core/widgets/custon_btn.dart';
import 'package:heunets_assessment_app/features/home/presentation/controller/home_controller.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_dropdown.dart';

class PostJobPage extends StatefulWidget {
  const PostJobPage({super.key});

  @override
  State<PostJobPage> createState() => _PostJobPageState();
}

class _PostJobPageState extends State<PostJobPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedJobType;

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryRangeController = TextEditingController();
  final TextEditingController jobDescriptionController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();

  @override
  void dispose() {
    jobTitleController.dispose();
    companyNameController.dispose();
    locationController.dispose();
    salaryRangeController.dispose();
    jobDescriptionController.dispose();
    requirementsController.dispose();
    super.dispose();
  }

  void _postJob() {
    if (_formKey.currentState!.validate() && selectedJobType != null) {
      final homeController = context.read<HomeController>();

      List<String> requirements = homeController.parseRequirements(
        requirementsController.text,
      );

      homeController.addJob(
        jobTitle: jobTitleController.text.trim(),
        companyName: companyNameController.text.trim(),
        location: locationController.text.trim(),
        jobType: selectedJobType!,
        salaryRange: salaryRangeController.text.trim(),
        jobDescription: jobDescriptionController.text.trim(),
        requirements: requirements,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Job posted successfully!'),
          backgroundColor: AppColors.primaryColor,
          duration: Duration(seconds: 2),
        ),
      );

      _clearForm();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  void _clearForm() {
    jobTitleController.clear();
    companyNameController.clear();
    locationController.clear();
    salaryRangeController.clear();
    jobDescriptionController.clear();
    requirementsController.clear();
    setState(() {
      selectedJobType = null;
    });
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text('Post a New Job', style: TextStyle(color: AppColors.White)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(20),
                  CustomTextField(
                    controller: jobTitleController,
                    label: 'Job Title',
                    hintText: 'e.g Senior Frontend Developer',
                    validator: (value) => _validateRequired(value, 'Job Title'),
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: companyNameController,
                    label: 'Company Name',
                    hintText: 'Your Company',
                    validator: (value) => _validateRequired(value, 'Company Name'),
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: locationController,
                    label: 'Location',
                    hintText: 'e.g San Francisco, CA',
                    validator: (value) => _validateRequired(value, 'Location'),
                  ),
                  Gap(20),
                  CustomDropdown<String>(
                    label: 'Job Type',
                    hintText: 'Select job type',
                    value: selectedJobType,
                    items: [
                      DropdownItem(value: 'Full-time', label: 'Full-time'),
                      DropdownItem(value: 'Part-time', label: 'Part-time'),
                      DropdownItem(value: 'Contract', label: 'Contract'),
                      DropdownItem(value: 'Internship', label: 'Internship'),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedJobType = value;
                      });
                    },
                    validator: (value) => value == null ? 'Please select a job type' : null,
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: salaryRangeController,
                    label: 'Salary Range',
                    hintText: r'e.g $100k - $200k',
                    validator: (value) => _validateRequired(value, 'Salary Range'),
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: jobDescriptionController,
                    label: 'Job Description',
                    hintText: 'Describe the roles, responsibilities and requirements',
                    maxLines: 10,
                    height: 150,
                    validator: (value) => _validateRequired(value, 'Job Description'),
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: requirementsController,
                    label: 'Requirements (one per line)',
                    hintText: '5+ years of experience\nStrong React skills\nExcellent communication',
                    maxLines: 10,
                    height: 100,
                    validator: (value) => _validateRequired(value, 'Requirements'),
                  ),
                  Gap(20),
                  CustomBtn(
                    onTap: _postJob,
                    text: 'Post Job',
                  ),
                  Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}