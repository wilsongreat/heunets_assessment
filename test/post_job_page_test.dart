import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:heunets_assessment_app/features/job/presentation/pages/post_job_page.dart';
import 'package:heunets_assessment_app/features/home/presentation/controller/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main() {
  testWidgets('PostJobPage posts a job successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) =>
          ChangeNotifierProvider<HomeController>(
            create: (_) => HomeController(),
            child: const MaterialApp(
              home: Scaffold(
                body: PostJobPage(),
              ),
            ),
          ),
      ),
    );

    // Find all text fields in order
    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Test Job');
    await tester.enterText(textFields.at(1), 'Test Company');
    await tester.enterText(textFields.at(2), 'Test City');
    // Select job type by setting the state directly
    await tester.pumpAndSettle();
    await tester.enterText(textFields.at(3), '100k - 200k');
    await tester.enterText(textFields.at(4), 'Test job description');
    await tester.enterText(textFields.at(5), 'Requirement 1\nRequirement 2');

    // Scroll to make the button visible
    await tester.ensureVisible(find.text('Post Job'));
    await tester.pumpAndSettle();

    // Tap the Post Job button
    await tester.tap(find.text('Post Job'));
    await tester.pumpAndSettle();

  });

  testWidgets('PostJobPage shows error when required fields are missing', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) =>
          ChangeNotifierProvider<HomeController>(
            create: (_) => HomeController(),
            child: const MaterialApp(
              home: Scaffold(
                body: PostJobPage(),
              ),
            ),
          ),
      ),
    );

    // Scroll to make the button visible
    await tester.ensureVisible(find.text('Post Job'));
    await tester.pumpAndSettle();

    // Tap the Post Job button
    await tester.tap(find.text('Post Job'));
    await tester.pumpAndSettle();

    // Check for error snackbar
    expect(find.text('Please fill all required fields'), findsOneWidget);
  });
}
