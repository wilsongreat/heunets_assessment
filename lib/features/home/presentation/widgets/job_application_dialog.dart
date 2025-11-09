import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/features/home/presentation/controller/home_controller.dart';
import 'package:heunets_assessment_app/features/job/data/model/job_model.dart';

class JobApplicationDialog extends StatefulWidget {
  final Job job;
  final VoidCallback? onSubmit;
  final HomeController homeController;

  const JobApplicationDialog({
    super.key,
    required this.job,
    this.onSubmit, required this.homeController,
  });

  @override
  State<JobApplicationDialog> createState() => _JobApplicationDialogState();
}

class _JobApplicationDialogState extends State<JobApplicationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _coverLetterController = TextEditingController();

  String? _selectedFileName;
  bool _showSuccess = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _coverLetterController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _selectedFileName = result.files.first.name;
        });
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }


  void _submitApplication() {
    if (_formKey.currentState!.validate()) {
      widget.homeController.addJobApplication(
        job: widget.job,
        applicantName: _fullNameController.text.trim(),
        applicantEmail: _emailController.text.trim(),
        applicantPhone: _phoneController.text.trim(),
        coverLetter: _coverLetterController.text.trim(),
        resumeFileName: _selectedFileName,
      );

      setState(() {
        _showSuccess = true;
      });
    }
  }

  void _closeDialog() {
    widget.onSubmit?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: _showSuccess ? _buildSuccessWidget() : _buildFormWidget(),
      ),
    );
  }

  Widget _buildFormWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apply for ${widget.job.title}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Fill in your details to apply for this position',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[600],
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      _buildTextField(
                        controller: _fullNameController,
                        hintText: 'Full Name',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      _buildTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      _buildTextField(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      _buildTextField(
                        controller: _coverLetterController,
                        hintText: 'Cover Letter (Optional)',
                        maxLines: 5,
                        isOptional: true,
                      ),
                      SizedBox(height: 16.h),

                      _buildFileUploadSection(),
                      SizedBox(height: 24.h),

                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: _submitApplication,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Submit Application',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
  }

 Widget _buildSuccessWidget() {
   return Padding(
     padding: EdgeInsets.all(20.r),
     child: Stack(
       children: [
         Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             SizedBox(height: 20.h),
             Icon(
               Icons.check_circle,
               color: AppColors.primaryColor,
               size: 60.sp,
             ),
             SizedBox(height: 16.h),
             Text(
               'Application Submitted Successfully!',
               style: TextStyle(
                 fontSize: 20.sp,
                 fontWeight: FontWeight.w600,
                 color: Colors.black,
               ),
               textAlign: TextAlign.center,
             ),
             SizedBox(height: 8.h),
             Text(
               'Your application for ${widget.job.title} has been submitted. We\'ll get back to you soon.',
               style: TextStyle(
                 fontSize: 14.sp,
                 color: Colors.grey[600],
               ),
               textAlign: TextAlign.center,
             ),
             SizedBox(height: 24.h),
             SizedBox(
               width: double.infinity,
               height: 50.h,
               child: ElevatedButton(
                 onPressed: _closeDialog,
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppColors.primaryColor,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12.r),
                   ),
                   elevation: 0,
                 ),
                 child: Text(
                   'Close',
                   style: TextStyle(
                     fontSize: 16.sp,
                     fontWeight: FontWeight.w600,
                     color: Colors.white,
                   ),
                 ),
               ),
             ),
           ],
         ),
         Positioned(
           top: 0,
           right: 0,
           child: GestureDetector(
             onTap: _closeDialog,
             child: Container(
               padding: EdgeInsets.all(8.r),
               child: Icon(
                 Icons.close,
                 color: Colors.grey[600],
                 size: 24.sp,
               ),
             ),
           ),
         ),
       ],
     ),
   );
 }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    bool isOptional = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: isOptional ? null : validator,
      style: TextStyle(
        fontSize: 16.sp,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.grey[500],
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.cyan, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
      ),
    );
  }

  Widget _buildFileUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // File upload button
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Choose file',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _selectedFileName ?? 'No file chosen',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: _selectedFileName != null
                          ? Colors.black87
                          : Colors.grey[500],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Upload your resume (PDF or DOC)',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}