import '../models/booking.dart';

class BookingService {
  static final List<Booking> _bookings = [];

  static List<Booking> getAllBookings() {
    return List.from(_bookings);
  }

  static List<Booking> getBookingsByStatus(String status) {
    return _bookings.where((booking) => booking.status == status).toList();
  }

  static Booking? createBooking(Booking booking) {
    try {
      _bookings.add(booking);
      return booking;
    } catch (e) {
      return null;
    }
  }

  static Booking? updateBookingStatus(String bookingId, String newStatus) {
    final index = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      final updatedBooking = _bookings[index].copyWith(status: newStatus);
      _bookings[index] = updatedBooking;
      return updatedBooking;
    }
    return null;
  }

  static bool deleteBooking(String bookingId) {
    final index = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      _bookings.removeAt(index);
      return true;
    }
    return false;
  }

  static Booking? getBookingById(String id) {
    try {
      return _bookings.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Booking> getBookingsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _bookings
        .where(
          (booking) =>
              booking.dateTime.isAfter(startDate) &&
              booking.dateTime.isBefore(endDate),
        )
        .toList();
  }
}
