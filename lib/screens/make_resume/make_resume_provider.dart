import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../../utilis/api_service.dart';
import '../auth/auth_provider.dart';
import 'make_resume_model.dart';

class MakeResumeProvider with ChangeNotifier {

  MakeResumeModel resume = MakeResumeModel();

  bool isLoading = false;

  DateFormat _formatter = DateFormat('yyyy-MM-dd');

  PersonalInfo? personalInfo = PersonalInfo();

  final apiService = ApiService(baseUrl: 'https://resume-app-backend.onrender.com');

  String? objective;



  Future<void> submit(BuildContext context) async {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? user = await authProvider.myString;
    resume.personalInfo = personalInfo;
    resume.objective = objective;
    resume.education = _educationList;
    resume.experience = _experienceList;
    resume.skills = _skillsList;
    resume.languages = _languagesList;
    resume.certifications = _certificationsList;
    resume.projects = _projectsList;
    resume.user = user;

    isLoading = true;
    notifyListeners();

    apiService.post('/api/resume/add', resume.toJson()).then((data) {
      isLoading = false;
      print(data);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(data["message"])),
      // );

      notifyListeners();
    }).catchError((error) {
      print('Error: $error');
      isLoading = false;
    });

    //print(resume.user);
    notifyListeners();
  }

  List<Education> _educationList = [Education()];
  List<Education> get educationList => _educationList;
  void addEducation() {
    _educationList.add(Education());
    notifyListeners();
  }
  void removeEducation(int index) {
    _educationList.removeAt(index);
    notifyListeners();
  }
  Future<void> selectDate(BuildContext context, Education education, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isStartDate) {
        education.startDate = _formatter.format(picked);
      } else {
        education.endDate = _formatter.format(picked);
      }
      notifyListeners();
    }
  }



  List<Experience> _experienceList = [Experience()];
  List<Experience> get experienceList => _experienceList;
  void addExperience() {
    _experienceList.add(Experience());
    notifyListeners();
  }
  void removeExperience(int index) {
    _experienceList.removeAt(index);
    notifyListeners();
  }
  Future<void> selectExperienceDate(BuildContext context, Experience experience, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isStartDate) {
        experience.startDate = _formatter.format(picked);
      } else {
        experience.endDate = _formatter.format(picked);
      }
      notifyListeners();
    }
  }




  List<String> _skillsList = [];
  List<String> get skillsList => _skillsList;
  void addSkills(String skills) {
    _skillsList.add(skills);
    notifyListeners();
  }
  void removeSkills(int index) {
    _skillsList.removeAt(index);
    notifyListeners();
  }




  List<Languages> _languagesList = [Languages()];
  List<Languages> get languagesList => _languagesList;
  void addLanguages() {
    _languagesList.add(Languages());
    notifyListeners();
  }
  void removeLanguages(int index) {
    _languagesList.removeAt(index);
    notifyListeners();
  }




  List<Certifications> _certificationsList = [Certifications()];
  List<Certifications> get certificationsList => _certificationsList;
  void addCertifications() {
    _certificationsList.add(Certifications());
    notifyListeners();
  }
  void removeCertifications(int index) {
    _certificationsList.removeAt(index);
    notifyListeners();
  }
  Future<void> selectCertificationsDate(BuildContext context, Certifications certifications) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      certifications.date = _formatter.format(picked);
      notifyListeners();
    }
  }




  List<Projects> _projectsList = [Projects()];
  List<Projects> get projectsList => _projectsList;
  void addProjects() {
    _projectsList.add(Projects());
    notifyListeners();
  }
  void removeProjects(int index) {
    _projectsList.removeAt(index);
    notifyListeners();
  }



  Future<void> getPDF(BuildContext context)async{
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? user = await authProvider.myString;
    resume.personalInfo = personalInfo;
    resume.objective = objective;
    resume.education = _educationList;
    resume.experience = _experienceList;
    resume.skills = _skillsList;
    resume.languages = _languagesList;
    resume.certifications = _certificationsList;
    resume.projects = _projectsList;
    resume.user = user;
    await generateResumePDF(resume);
    notifyListeners();
  }



  Future<void> generateResumePDF(MakeResumeModel model) async {

    print("in ---------------------- pdf");
    isLoading = true;
    notifyListeners();

    final fontData = await rootBundle.load("assets/fonts/Nunito-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    final pdf = pw.Document();

    print("in pdf");
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(
                level: 0,
                child: pw.Text('Resume', style: pw.TextStyle(fontSize: 40, font: ttf))),
            pw.Header(level: 1, child: pw.Text('Personal Information', style: pw.TextStyle(font: ttf))),
            pw.Text('Name: ${model.personalInfo?.name}', style: pw.TextStyle(font: ttf)),
            pw.Text('Email: ${model.personalInfo?.email}', style: pw.TextStyle(font: ttf)),
            pw.Text('Phone: ${model.personalInfo?.phone}', style: pw.TextStyle(font: ttf)),
            // Add other fields with `style: pw.TextStyle(font: ttf)`

            // ... repeat for all other text ...
          ],
        ),
      ),
    );

    final directory = await getExternalStorageDirectory();
    final file = File("${directory!.path}/resume.pdf");
    await file.writeAsBytes(await pdf.save());
    print("out pdf");
    isLoading = false;
    OpenFile.open(file.path);
    notifyListeners();
  }

  void requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
}
