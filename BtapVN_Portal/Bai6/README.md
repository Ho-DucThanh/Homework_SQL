# 1. Cấu trúc các bảng và cách tổ chức dữ liệu:

## Bảng EventAttendee (Liên kết giữa Event và Attendee):

- EventID: Khóa ngoại tham chiếu đến Event(EventID).
- AttendeeID: Khóa ngoại tham chiếu đến Attendee(AttendeeID).
- Primary Key: Kết hợp EventID và AttendeeID để đảm bảo không có bản ghi trùng lặp.

## Bảng EventSponsor (Liên kết giữa Event và Sponsor):

- EventID: Khóa ngoại tham chiếu đến Event(EventID).
- SponsorID: Khóa ngoại tham chiếu đến Sponsor(SponsorID).
- SponsorshipAmount: Số tiền tài trợ, thuộc tính bổ sung mô tả số tiền tài trợ cho từng sự kiện.
- Primary Key: Kết hợp EventID và SponsorID.

# 2. Giải thích cách các bảng liên kết hỗ trợ truy vấn dữ liệu:

## Để tìm các sự kiện mà một khách mời tham dự, có thể truy vấn từ bảng EventAttendee bằng cách tìm các EventID có AttendeeID cụ thể.

```bash
    SELECT e.EventID, e.EventName
    FROM Event e
    JOIN EventAttendee ea ON e.EventID = ea.EventID
    WHERE ea.AttendeeID = 'A001';
```

## Để tìm các nhà tài trợ của một sự kiện cụ thể, có thể truy vấn từ bảng EventSponsor bằng cách tìm các SponsorID có EventID cụ thể.

```bash
    SELECT s.SponsorID, s.SponsorName, es.SponsorshipAmount
    FROM Sponsor s
    JOIN EventSponsor es ON s.SponsorID = es.SponsorID
    WHERE es.EventID = 'E001';
```
