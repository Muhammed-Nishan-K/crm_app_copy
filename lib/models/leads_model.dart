class Lead {
  dynamic id;
  dynamic name;
  dynamic phone;
  dynamic college;
  dynamic course;
  dynamic email;
  dynamic status; // Nullable status

  Lead({
    this.id,
    this.name,
    this.phone,
    this.college,
    this.course,
    this.email,
    this.status,
  });

  // Factory constructor to create a Lead instance from a JSON object (Map)
  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      course: json['course'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      // status: json['status'] as String?,
      college: json['college'] ?? '',
    );
  }

  // Method to convert Lead instance to a JSON object (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'course': course,
      'email': email,
      'phone': phone,
      // 'status': status,
      'college':college,
    };
  }

  // Method to create a new Lead instance with an updated status
  Lead withStatus(String newStatus) {
    return Lead(
      id: id,
      name: name,
      course: course,
      email: email,
      phone: phone,
      // status: newStatus,
    );
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'Lead(id: $id, name: $name, course: $course, email: $email, phone: $phone, status: $status)';
  }
}
