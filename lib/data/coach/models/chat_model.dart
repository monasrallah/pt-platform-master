class AllChatsModel {
  List<ChatModel> chats;

  AllChatsModel({required this.chats});

  factory AllChatsModel.fromJson(Map<String, dynamic> json) {
    print("test loginParams ${json}");
    List<ChatModel> all = [];
    for (var element in (json['chats'] as List<dynamic>)) {
      all.add(ChatModel.fromJson(element as Map<String, dynamic>));
    }
    return AllChatsModel(chats: all);
  }
}

class ChatModel {
 final int id;
 final int userId;
 final String ?username;
 final String? time;
 final int isAutoAccept;
 final String date;
 final  DateTime? deletedAt;
 final DateTime createdAt;
 final DateTime updatedAt;
 final CoachTimeReservationModel? coachTimeReservation;

  ChatModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.time,
    required this.isAutoAccept,
    required this.date,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.coachTimeReservation,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        userId: json["user_id"],
        username: json["username"]??"",
        time: json["time"]??"",
        isAutoAccept: json["is_auto_accept"],
        date: json["date"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        coachTimeReservation:
        json["coach_time_reservation_accept"]!= null? CoachTimeReservationModel.fromJson(json["coach_time_reservation_accept"]):null,
      );
}

class CoachTimeReservationModel {
  int id;
  int coachTimeId;
  int userId;
  String status;
  ZoomModel zoom;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  CoachTimeReservationModel({
    required this.id,
    required this.coachTimeId,
    required this.userId,
    required this.status,
    required this.zoom,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CoachTimeReservationModel.fromJson(Map<String, dynamic> json) =>
      CoachTimeReservationModel(
        id: json["id"],
        coachTimeId: json["coach_time_id"],
        userId: json["user_id"],
        status: json["status"],
        zoom: ZoomModel.fromJson(json["zoom"]),
        deletedAt: json["deleted_at"] != null
            ? DateTime.parse(json["deleted_at"])
            : null,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class ZoomModel {
  bool success;
  ZoomDataModel data;

  ZoomModel({
    required this.success,
    required this.data,
  });

  factory ZoomModel.fromJson(Map<String, dynamic> json) => ZoomModel(
        success: json["success"],
        data: ZoomDataModel.fromJson(json["data"]),
      );
}

class ZoomDataModel {
  String uuid;
  int id;
  String hostId;
  String hostEmail;
  String topic;
  int type;
  String status;
  DateTime startTime;
  int duration;
  String timezone;
  DateTime createdAt;
  String startUrl;
  String joinUrl;
  String password;
  String h323Password;
  String pstnPassword;
  String encryptedPassword;
  // Settings settings;
  bool preSchedule;

  ZoomDataModel({
    required this.uuid,
    required this.id,
    required this.hostId,
    required this.hostEmail,
    required this.topic,
    required this.type,
    required this.status,
    required this.startTime,
    required this.duration,
    required this.timezone,
    required this.createdAt,
    required this.startUrl,
    required this.joinUrl,
    required this.password,
    required this.h323Password,
    required this.pstnPassword,
    required this.encryptedPassword,
    // required this.settings,
    required this.preSchedule,
  });

  factory ZoomDataModel.fromJson(Map<String, dynamic> json) => ZoomDataModel(
        uuid: json["uuid"]??"",
        id: json["id"],
        hostId: json["host_id"],
        hostEmail: json["host_email"],
        topic: json["topic"],
        type: json["type"],
        status: json["status"],
        startTime: DateTime.parse(json["start_time"]),
        duration: json["duration"],
        timezone: json["timezone"],
        createdAt: DateTime.parse(json["created_at"]),
        startUrl: json["start_url"],
        joinUrl: json["join_url"],
        password: json["password"],
        h323Password: json["h323_password"],
        pstnPassword: json["pstn_password"],
        encryptedPassword: json["encrypted_password"],
        // settings: Settings.fromJson(json["settings"]),
        preSchedule: json["pre_schedule"],
      );
}

class Settings {
  bool hostVideo;
  bool participantVideo;
  bool cnMeeting;
  bool inMeeting;
  bool joinBeforeHost;
  int jbhTime;
  bool muteUponEntry;
  bool watermark;
  bool usePmi;
  int approvalType;
  String audio;
  String autoRecording;
  bool enforceLogin;
  String enforceLoginDomains;
  String alternativeHosts;
  bool alternativeHostUpdatePolls;
  bool closeRegistration;
  bool showShareButton;
  bool allowMultipleDevices;
  bool registrantsConfirmationEmail;
  bool waitingRoom;
  bool requestPermissionToUnmuteParticipants;
  bool registrantsEmailNotification;
  bool meetingAuthentication;
  String encryptionType;

  // ApprovedOrDeniedCountriesOrRegions approvedOrDeniedCountriesOrRegions;
  // ApprovedOrDeniedCountriesOrRegions breakoutRoom;
  bool internalMeeting;

  // ContinuousMeetingChat continuousMeetingChat;
  bool participantFocusedMeeting;
  bool pushChangeToCalendar;
  List<dynamic> resources;
  bool alternativeHostsEmailNotification;
  bool showJoinInfo;
  bool deviceTesting;
  bool focusMode;
  bool enableDedicatedGroupChat;
  bool privateMeeting;
  bool emailNotification;
  bool hostSaveVideoOrder;

  // ApprovedOrDeniedCountriesOrRegions signLanguageInterpretation;
  bool emailInAttendeeReport;

  Settings({
    required this.hostVideo,
    required this.participantVideo,
    required this.cnMeeting,
    required this.inMeeting,
    required this.joinBeforeHost,
    required this.jbhTime,
    required this.muteUponEntry,
    required this.watermark,
    required this.usePmi,
    required this.approvalType,
    required this.audio,
    required this.autoRecording,
    required this.enforceLogin,
    required this.enforceLoginDomains,
    required this.alternativeHosts,
    required this.alternativeHostUpdatePolls,
    required this.closeRegistration,
    required this.showShareButton,
    required this.allowMultipleDevices,
    required this.registrantsConfirmationEmail,
    required this.waitingRoom,
    required this.requestPermissionToUnmuteParticipants,
    required this.registrantsEmailNotification,
    required this.meetingAuthentication,
    required this.encryptionType,
    // required this.approvedOrDeniedCountriesOrRegions,
    // required this.breakoutRoom,
    required this.internalMeeting,
    // required this.continuousMeetingChat,
    required this.participantFocusedMeeting,
    required this.pushChangeToCalendar,
    required this.resources,
    required this.alternativeHostsEmailNotification,
    required this.showJoinInfo,
    required this.deviceTesting,
    required this.focusMode,
    required this.enableDedicatedGroupChat,
    required this.privateMeeting,
    required this.emailNotification,
    required this.hostSaveVideoOrder,
    // required this.signLanguageInterpretation,
    required this.emailInAttendeeReport,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        hostVideo: json["host_video"],
        participantVideo: json["participant_video"],
        cnMeeting: json["cn_meeting"],
        inMeeting: json["in_meeting"],
        joinBeforeHost: json["join_before_host"],
        jbhTime: json["jbh_time"],
        muteUponEntry: json["mute_upon_entry"],
        watermark: json["watermark"],
        usePmi: json["use_pmi"],
        approvalType: json["approval_type"],
        audio: json["audio"],
        autoRecording: json["auto_recording"],
        enforceLogin: json["enforce_login"],
        enforceLoginDomains: json["enforce_login_domains"],
        alternativeHosts: json["alternative_hosts"],
        alternativeHostUpdatePolls: json["alternative_host_update_polls"],
        closeRegistration: json["close_registration"],
        showShareButton: json["show_share_button"],
        allowMultipleDevices: json["allow_multiple_devices"],
        registrantsConfirmationEmail: json["registrants_confirmation_email"],
        waitingRoom: json["waiting_room"],
        requestPermissionToUnmuteParticipants:
            json["request_permission_to_unmute_participants"],
        registrantsEmailNotification: json["registrants_email_notification"],
        meetingAuthentication: json["meeting_authentication"],
        encryptionType: json["encryption_type"],
        // approvedOrDeniedCountriesOrRegions:
        //     ApprovedOrDeniedCountriesOrRegions.fromJson(
        //         json["approved_or_denied_countries_or_regions"]),
        // breakoutRoom:
        //     ApprovedOrDeniedCountriesOrRegions.fromJson(json["breakout_room"]),
        internalMeeting: json["internal_meeting"],
        // continuousMeetingChat:
        //     ContinuousMeetingChat.fromJson(json["continuous_meeting_chat"]),
        participantFocusedMeeting: json["participant_focused_meeting"],
        pushChangeToCalendar: json["push_change_to_calendar"],
        resources: List<dynamic>.from(json["resources"].map((x) => x)),
        alternativeHostsEmailNotification:
            json["alternative_hosts_email_notification"],
        showJoinInfo: json["show_join_info"],
        deviceTesting: json["device_testing"],
        focusMode: json["focus_mode"],
        enableDedicatedGroupChat: json["enable_dedicated_group_chat"],
        privateMeeting: json["private_meeting"],
        emailNotification: json["email_notification"],
        hostSaveVideoOrder: json["host_save_video_order"],
        // signLanguageInterpretation: ApprovedOrDeniedCountriesOrRegions.fromJson(
        //     json["sign_language_interpretation"]),
        emailInAttendeeReport: json["email_in_attendee_report"],
      );
}
