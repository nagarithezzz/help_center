class Incident {
  String id;
  String category;
  String subCategory;
  String status;
  String reporterId;
  String reporterEmailId;
  String reporterRole;
  String resolverId;
  String resolverGroup;
  String description;
  String resolverComments;
  String createUser;
  String createdDate;
  String modifiedDate;
  String modifiedUser;
  String fileName;
  String fileType;
  List<dynamic> fileContent;
  String alternateResolver;
  String additionalEmailId;
  String priority;
  String hostelRoomNumber;
  String hostelBlockName;
  String studentPhoneNumber;
  String incidentType;
  String reporterName;

  Incident({
    required this.id,
    required this.category,
    required this.subCategory,
    required this.status,
    required this.reporterId,
    required this.reporterEmailId,
    required this.reporterRole,
    required this.resolverId,
    required this.resolverGroup,
    required this.description,
    required this.resolverComments,
    required this.createUser,
    required this.createdDate,
    required this.modifiedDate,
    required this.modifiedUser,
    required this.fileName,
    required this.fileType,
    required this.fileContent,
    required this.alternateResolver,
    required this.additionalEmailId,
    required this.priority,
    required this.hostelRoomNumber,
    required this.hostelBlockName,
    required this.studentPhoneNumber,
    required this.incidentType,
    required this.reporterName,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    return Incident(
      id: json['id'],
      category: json['category'],
      subCategory: json['subCategory'],
      status: json['status'],
      reporterId: json['reporterId'],
      reporterEmailId: json['reporterEmailId'],
      reporterRole: json['reporterRole'],
      resolverId: json['resolverId'],
      resolverGroup: json['resolverGroup'],
      description: json['description'],
      resolverComments: json['resolverComments'],
      createUser: json['createUser'],
      createdDate: json['createdDate'],
      modifiedDate: json['modifiedDate'],
      modifiedUser: json['modifiedUser'],
      fileName: json['fileName'],
      fileType: json['fileType'],
      fileContent: json['fileContent'],
      alternateResolver: json['alternateResolver'],
      additionalEmailId: json['additionalEmailId'],
      priority: json['priority'],
      hostelRoomNumber: json['hostelRoomNumber'],
      hostelBlockName: json['hostelBlockName'],
      studentPhoneNumber: json['studentPhoneNumber'],
      incidentType: json['incidentType'],
      reporterName: json['reporterName'],
    );
  }
}
