import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../utilis/custoum_circular_progress_indicator.dart';
import 'make_resume_model.dart';
import 'make_resume_provider.dart';

class MakeResumeFormScreen extends StatefulWidget {
  @override
  _MakeResumeFormScreenState createState() => _MakeResumeFormScreenState();
}

class _MakeResumeFormScreenState extends State<MakeResumeFormScreen> {
  MakeResumeModel resume = MakeResumeModel();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MakeResumeProvider>(
        builder: (context, makeResumeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Resume Form'),
          actions: [
            makeResumeProvider.isLoading
                ? CustoumCircularIndi()
                : TextButton(
                    onPressed: () async {
                      // var status = await Permission.storage.status;
                      // if (!status.isGranted) {
                      //   status = await Permission.storage.request();
                      //   if (!status.isGranted) {
                      //     // The user did not grant the permission, handle it gracefully.
                      //     return;
                      //   }
                      // }
                      makeResumeProvider.getPDF(context);
                    },
                    child: Text("Get PDF")),
            makeResumeProvider.isLoading
                ? CustoumCircularIndi()
                : TextButton(
                    onPressed: () {
                      makeResumeProvider.submit(context);
                    },
                    child: Text("submit")),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: const [
                      Text('Personal Information'),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onFieldSubmitted: (String? value) {
                      print("------------------------" + value!);
                      // makeResumeProvider.resume.personalInfo = PersonalInfo(name: value);
                      makeResumeProvider.personalInfo!.name = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'email'),
                    onFieldSubmitted: (String? value) {
                      // makeResumeProvider.resume.personalInfo = PersonalInfo(email: value);
                      makeResumeProvider.personalInfo!.email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'phone'),
                    onFieldSubmitted: (String? value) {
                      //makeResumeProvider.resume.personalInfo = PersonalInfo(phone: value);
                      makeResumeProvider.personalInfo!.phone = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'address'),
                    onFieldSubmitted: (String? value) {
                      // makeResumeProvider.resume.personalInfo = PersonalInfo(address: value);
                      makeResumeProvider.personalInfo!.address = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'linkedIn'),
                    onFieldSubmitted: (String? value) {
                      //makeResumeProvider.resume.personalInfo = PersonalInfo(linkedIn: value);
                      makeResumeProvider.personalInfo!.linkedIn = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'github'),
                    onFieldSubmitted: (String? value) {
                      // makeResumeProvider.resume.personalInfo = PersonalInfo(github: value);
                      makeResumeProvider.personalInfo!.github = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'objective'),
                    onFieldSubmitted: (String? value) {
                      // makeResumeProvider.resume.personalInfo = PersonalInfo(github: value);
                      makeResumeProvider.objective = value;
                    },
                  ),

                  Row(
                    children: [
                      Text('Skills'),
                    ],
                  ),
                  Column(
                    children: makeResumeProvider.skillsList
                        .map((skills) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(skills),
                                    TextButton(
                                      child: Text('Remove'),
                                      onPressed: () =>
                                          makeResumeProvider.removeSkills(
                                              makeResumeProvider.skillsList
                                                  .indexOf(skills)),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                              //initialValue: skills,
                              decoration: InputDecoration(labelText: 'skills'),
                              onFieldSubmitted: (val) {
                                makeResumeProvider.addSkills(val!);
                                val = "";
                              }),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     TextButton(
                          //       child: Text('Add Skills'),
                          //       onPressed: () => makeResumeProvider.addSkills()
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),

                  Column(
                    children: makeResumeProvider.educationList
                        .map((education) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      initialValue: education.school,
                                      decoration:
                                          InputDecoration(labelText: 'School'),
                                      onFieldSubmitted: (val) =>
                                          education.school = val,
                                    ),
                                    TextFormField(
                                      initialValue: education.degree,
                                      decoration:
                                          InputDecoration(labelText: 'Degree'),
                                      onFieldSubmitted: (val) =>
                                          education.degree = val,
                                    ),
                                    TextFormField(
                                      initialValue: education.fieldOfStudy,
                                      decoration: InputDecoration(
                                          labelText: 'Field of Study'),
                                      onFieldSubmitted: (val) =>
                                          education.fieldOfStudy = val,
                                    ),
                                    TextButton(
                                      onPressed: () => makeResumeProvider
                                          .selectDate(context, education, true),
                                      child: Text(education.startDate == null
                                          ? 'Pick Start Date'
                                          : 'Start Date: ${education.startDate}'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          makeResumeProvider.selectDate(
                                              context, education, false),
                                      child: Text(education.endDate == null
                                          ? 'Pick End Date'
                                          : 'End Date: ${education.endDate}'),
                                    ),
                                    TextFormField(
                                      initialValue: education.description,
                                      decoration: InputDecoration(
                                          labelText: 'Description'),
                                      onFieldSubmitted: (val) =>
                                          education.description = val,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text('Remove'),
                                          onPressed: () => makeResumeProvider
                                              .removeEducation(
                                                  makeResumeProvider
                                                      .educationList
                                                      .indexOf(education)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Education'),
                      TextButton(
                        onPressed: () => makeResumeProvider.addEducation(),
                        child: Text('Add Education'),
                      ),
                    ],
                  ),

                  Column(
                    children: makeResumeProvider.experienceList
                        .map((experience) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      initialValue: experience.jobTitle,
                                      decoration: InputDecoration(
                                          labelText: 'JobTitle'),
                                      onFieldSubmitted: (val) =>
                                          experience.jobTitle = val,
                                    ),
                                    TextFormField(
                                      initialValue: experience.company,
                                      decoration:
                                          InputDecoration(labelText: 'company'),
                                      onFieldSubmitted: (val) =>
                                          experience.company = val,
                                    ),
                                    TextButton(
                                      onPressed: () => makeResumeProvider
                                          .selectExperienceDate(
                                              context, experience, true),
                                      child: Text(experience.startDate == null
                                          ? 'Pick Start Date'
                                          : 'Start Date: ${experience.startDate}'),
                                    ),
                                    TextButton(
                                      onPressed: () => makeResumeProvider
                                          .selectExperienceDate(
                                              context, experience, false),
                                      child: Text(experience.endDate == null
                                          ? 'Pick End Date'
                                          : 'End Date: ${experience.endDate}'),
                                    ),
                                    TextFormField(
                                      initialValue: experience.description,
                                      decoration: InputDecoration(
                                          labelText: 'Description'),
                                      onFieldSubmitted: (val) =>
                                          experience.description = val,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text('Remove'),
                                          onPressed: () => makeResumeProvider
                                              .removeExperience(
                                                  makeResumeProvider
                                                      .experienceList
                                                      .indexOf(experience)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Experience'),
                      TextButton(
                        onPressed: () => makeResumeProvider.addExperience(),
                        child: Text('Add Experience'),
                      ),
                    ],
                  ),

                  Column(
                    children: makeResumeProvider.languagesList
                        .map((languages) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      initialValue: languages.language,
                                      decoration: InputDecoration(
                                          labelText: 'Language'),
                                      onFieldSubmitted: (val) =>
                                          languages.language = val,
                                    ),
                                    TextFormField(
                                      initialValue: languages.proficiency,
                                      decoration: InputDecoration(
                                          labelText: 'Proficiency'),
                                      onFieldSubmitted: (val) =>
                                          languages.proficiency = val,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text('Remove'),
                                          onPressed: () => makeResumeProvider
                                              .removeLanguages(
                                                  makeResumeProvider
                                                      .languagesList
                                                      .indexOf(languages)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Languages'),
                      TextButton(
                        onPressed: () => makeResumeProvider.addLanguages(),
                        child: Text('Add Language'),
                      ),
                    ],
                  ),

                  Column(
                    children: makeResumeProvider.certificationsList
                        .map((certifications) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      initialValue: certifications.name,
                                      decoration:
                                          InputDecoration(labelText: 'Name'),
                                      onFieldSubmitted: (val) =>
                                          certifications.name = val,
                                    ),
                                    TextFormField(
                                      initialValue: certifications.issuer,
                                      decoration:
                                          InputDecoration(labelText: 'Issuer'),
                                      onFieldSubmitted: (val) =>
                                          certifications.issuer = val,
                                    ),
                                    TextButton(
                                      onPressed: () => makeResumeProvider
                                          .selectCertificationsDate(
                                              context, certifications),
                                      child: Text(certifications.date == null
                                          ? 'Date'
                                          : 'Date: ${certifications.date}'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text('Remove'),
                                          onPressed: () => makeResumeProvider
                                              .removeCertifications(
                                                  makeResumeProvider
                                                      .certificationsList
                                                      .indexOf(certifications)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Certifications'),
                      TextButton(
                        onPressed: () => makeResumeProvider.addCertifications(),
                        child: Text('Add Certifications'),
                      ),
                    ],
                  ),

                  Column(
                    children: makeResumeProvider.projectsList
                        .map((projects) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      initialValue: projects.name,
                                      decoration:
                                          InputDecoration(labelText: 'Name'),
                                      onFieldSubmitted: (val) =>
                                          projects.name = val,
                                    ),
                                    TextFormField(
                                      initialValue: projects.description,
                                      decoration: InputDecoration(
                                          labelText: 'Description'),
                                      onFieldSubmitted: (val) =>
                                          projects.description = val,
                                    ),
                                    TextFormField(
                                      initialValue: projects.link,
                                      decoration:
                                          InputDecoration(labelText: 'Link'),
                                      onFieldSubmitted: (val) =>
                                          projects.link = val,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text('Remove'),
                                          onPressed: () => makeResumeProvider
                                              .removeProjects(makeResumeProvider
                                                  .projectsList
                                                  .indexOf(projects)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Projects'),
                      TextButton(
                        onPressed: () => makeResumeProvider.addProjects(),
                        child: Text('Add Projects'),
                      ),
                    ],
                  ),

                  // SizedBox(height: 10,),
                  // Divider(),
                  // SizedBox(height: 10,),
                  //
                  // Row(
                  //   children: const [
                  //     Text('Resume objective'),
                  //   ],
                  // ),
                  // TextFormField(
                  //   decoration: InputDecoration(labelText: 'objective'),
                  //   onSaved: (String? value) {
                  //     makeResumeProvider.resume.objective = value;
                  //   },
                  // ),
                  // // Similarly add other fields
                  // SizedBox(height: 10,),
                  // Divider(),
                  // SizedBox(height: 10,),
                  // // Education
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Education'),
                  //     TextButton(
                  //       onPressed: () => makeResumeProvider.addField(makeResumeProvider.educationControllers),
                  //       child: Text('Add Education'),
                  //     ),
                  //   ],
                  // ),
                  // ...makeResumeProvider.getFields(makeResumeProvider.educationControllers, 'Education'),
                  // Divider(),
                  //
                  // // Experience
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Experience'),
                  //     TextButton(
                  //       onPressed: () => makeResumeProvider.addField(makeResumeProvider.experienceControllers),
                  //       child: Text('Add Experience'),
                  //     ),
                  //   ],
                  // ),
                  // ...makeResumeProvider.getFields(makeResumeProvider.experienceControllers, 'Experience'),
                  // Divider(),
                  //
                  // // skills
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Skills'),
                  //     TextButton(
                  //       onPressed: () => makeResumeProvider.addField(makeResumeProvider.experienceControllers),
                  //       child: Text('Add Skills'),
                  //     ),
                  //   ],
                  // ),
                  // ...makeResumeProvider.getFields(makeResumeProvider.skillsControllers, 'Skills'),
                  // Divider(),
                  //
                  // // Languages
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Languages'),
                  //     TextButton(
                  //       onPressed: () => makeResumeProvider.addField(makeResumeProvider.languagesControllers),
                  //       child: Text('Add Language'),
                  //     ),
                  //   ],
                  // ),
                  // ...makeResumeProvider.getFields(makeResumeProvider.languagesControllers, 'Languages'),
                  // Divider(),
                  //
                  // // Certifications
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Certifications'),
                  //     TextButton(
                  //       onPressed: () => makeResumeProvider.addField(makeResumeProvider.certificationsControllers),
                  //       child: Text('Add Certification'),
                  //     ),
                  //   ],
                  // ),
                  // ...makeResumeProvider.getFields(makeResumeProvider.certificationsControllers, 'Certifications'),
                  // Divider(),
                  //
                  // // References
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('References'),
                  //     TextButton(
                  //       onPressed: () => makeResumeProvider.addField(makeResumeProvider.referencesControllers),
                  //       child: Text('Add Reference'),
                  //     ),
                  //   ],
                  // ),
                  // ...makeResumeProvider.getFields(makeResumeProvider.referencesControllers, 'References'),
                  // Divider(),
                  //
                  // // Projects
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Projects'),
                  //     TextButton(
                  //       onPressed: () => makeResumeProvider.addField(makeResumeProvider.projectsControllers),
                  //       child: Text('Add Project'),
                  //     ),
                  //   ],
                  // ),
                  // ...makeResumeProvider.getFields(makeResumeProvider.projectsControllers, 'Projects'),
                  // Divider(),

                  // ElevatedButton(
                  //   onPressed: _saveForm,
                  //   child: Text('Submit'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     //print();
                  //     makeResumeProvider.justtest();
                  //   },
                  //   child: Text('Submit'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save details to model here

      print('Form saved');
    }
  }
}
