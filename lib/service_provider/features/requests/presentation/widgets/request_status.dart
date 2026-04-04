enum RequestStatus {
  pending,
  accepted,
  rejected,
  completed,
  cancelled,
}

RequestStatus getStatusFromInt(int status) {
  switch (status) {
    case 1:
      return RequestStatus.pending;
    case 2:
      return RequestStatus.accepted;
    case 3:
      return RequestStatus.rejected;
    case 4:
      return RequestStatus.completed;
    case 5:
      return RequestStatus.cancelled;
    default:
      return RequestStatus.pending;
  }
}

String statusToArabic(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return "قيد المراجعة";
    case RequestStatus.accepted:
      return "تمت الموافقة";
    case RequestStatus.rejected:
      return "مرفوض";
    case RequestStatus.completed:
      return "مكتمل";
    case RequestStatus.cancelled:
      return "ملغي";
  }
}