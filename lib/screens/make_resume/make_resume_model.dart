class MakeResumeModel {
  PersonalInfo? personalInfo;
  String? objective;
  List<Education>? education;
  List<Experience>? experience;
  List<String>? skills;
  List<Languages>? languages;
  List<Certifications>? certifications;

  List<Projects>? projects;
  String? user;

  MakeResumeModel(
      {this.personalInfo,
        this.objective,
        this.education,
        this.experience,
        this.skills,
        this.languages,
        this.certifications,

        this.projects,
        this.user});

  MakeResumeModel.fromJson(Map<String, dynamic> json) {
    personalInfo = json['personalInfo'] != null
        ? new PersonalInfo.fromJson(json['personalInfo'])
        : null;
    objective = json['objective'];
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
    if (json['experience'] != null) {
      experience = <Experience>[];
      json['experience'].forEach((v) {
        experience!.add(new Experience.fromJson(v));
      });
    }
    skills = json['skills'].cast<String>();
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    if (json['certifications'] != null) {
      certifications = <Certifications>[];
      json['certifications'].forEach((v) {
        certifications!.add(new Certifications.fromJson(v));
      });
    }

    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personalInfo != null) {
      data['personalInfo'] = this.personalInfo!.toJson();
    }
    data['objective'] = this.objective;
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    if (this.experience != null) {
      data['experience'] = this.experience!.map((v) => v.toJson()).toList();
    }
    data['skills'] = this.skills;
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    if (this.certifications != null) {
      data['certifications'] =
          this.certifications!.map((v) => v.toJson()).toList();
    }

    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    data['user'] = this.user;
    return data;
  }
}

class PersonalInfo {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? linkedIn;
  String? github;

  PersonalInfo(
      {this.name,
        this.email,
        this.phone,
        this.address,
        this.linkedIn,
        this.github});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    linkedIn = json['linkedIn'];
    github = json['github'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['linkedIn'] = this.linkedIn;
    data['github'] = this.github;
    return data;
  }
}

class Education {
  String? school;
  String? degree;
  String? fieldOfStudy;
  String? startDate;
  String? endDate;
  String? description;

  Education(
      {this.school,
        this.degree,
        this.fieldOfStudy,
        this.startDate,
        this.endDate,
        this.description});

  Education.fromJson(Map<String, dynamic> json) {
    school = json['school'];
    degree = json['degree'];
    fieldOfStudy = json['fieldOfStudy'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['school'] = this.school;
    data['degree'] = this.degree;
    data['fieldOfStudy'] = this.fieldOfStudy;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    return data;
  }
}

class Experience {
  String? jobTitle;
  String? company;
  String? startDate;
  String? endDate;
  String? description;

  Experience(
      {this.jobTitle,
        this.company,
        this.startDate,
        this.endDate,
        this.description});

  Experience.fromJson(Map<String, dynamic> json) {
    jobTitle = json['jobTitle'];
    company = json['company'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobTitle'] = this.jobTitle;
    data['company'] = this.company;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    return data;
  }
}

class Languages {
  String? language;
  String? proficiency;

  Languages({this.language, this.proficiency});

  Languages.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    proficiency = json['proficiency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['proficiency'] = this.proficiency;
    return data;
  }
}

class Certifications {
  String? name;
  String? issuer;
  String? date;

  Certifications({this.name, this.issuer, this.date});

  Certifications.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    issuer = json['issuer'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['issuer'] = this.issuer;
    data['date'] = this.date;
    return data;
  }
}


class Projects {
  String? name;
  String? description;
  String? link;

  Projects({this.name, this.description, this.link});

  Projects.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['link'] = this.link;
    return data;
  }
}