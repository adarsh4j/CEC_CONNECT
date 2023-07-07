class Teacher {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phone;
  String? Class;
  String? Division;
  String? photoUrl;
  String? skill;
  String? sem;
  String? github;
  String? linkedin;

  Teacher({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.phone,
    this.Class,
    this.Division,
    this.photoUrl,
    this.skill,
    this.sem,
    this.github,
    this.linkedin,
  });

  factory Teacher.fromMap(map) {
    return Teacher(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        phone: map['phone'],
        Class: map['branch'],
        Division: map['division'],
        photoUrl: map['photoUrl'],
        skill: map['skill'],
        sem: map['sem'],
        linkedin: map['linkedin'],
        github: map['github']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phone': phone,
      'Class': Class,
      'Division': Division,
      'photoUrl': photoUrl,
      'skill': skill,
      'sem': sem,
      'linkedin': linkedin,
      'github': github,
    };
  }
}
