String getArName(String enName) {
  switch (enName) {
    case 'Sunday':
      return "الأحد";
    case 'Monday':
      return "الإثنين";
    case 'Tuesday':
      return "الثلاثاء";
    case 'Wednesday':
      return "الأربعاء";
    case 'Thursday':
      return "الخميس";
    case 'Friday':
      return "الجمعة";
    case 'Saturday':
      return "السبت";
    default:
      return "";
  }
}
