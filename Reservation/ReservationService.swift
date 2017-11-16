//
//  ReservationReserveService.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/15/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//
import Foundation

typealias ReservationDateType = (year: Int, month: Int, day: Int, hours: Int, minutes: Int)

// Message service types
enum MessageServiceType: Int, Codable {
    case swedishMessage = 0
    case deepTissueMessage
    case hotStonyMessage
    case reflexology
    case triggerPointTherapy
    case gelManicure
    
    var name: String {
        switch self {
        case .swedishMessage:
            return "Swedish Message"
        case .deepTissueMessage:
            return "Deep Tissue Message"
        case .hotStonyMessage:
            return "Hot Stony Message"
        case .reflexology:
            return "Reflexology"
        case .triggerPointTherapy:
            return "Trigger Point Therapy"
        case .gelManicure:
            return "Gel Manicure"
        }
    }
}

// Reservation Error type
enum ReservationError: Error {
    case invalidDateError                       // Invalid Date
    case couldNotSaveError                      // Could Not Save Reservations because of Disk Error
    case couldNotLoadError                      // Could Not Load Reservations because of Disk Error
}

// Informaion about a single reservation
struct Reservation: Codable {
    var partySize: Int                          // # of people in the pary
    var serviceType: MessageServiceType         // message service type
    var date: Date                              // date of the reservation
}

class ReservationService {
    static var shared: ReservationService = ReservationService()
    
    let reservationsDataFileName = "Reservations.json"
    
    // date formatter for month and day string
    let monthAndDayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter
    }()
    
    // date formatter for time of day string
    let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter
    }()
    
    // list of all of the user's reservations
    var reservations: [Reservation]? = []
    
    // MARK: File
    
    // Initializer
    func loadSavedReservations() {
        do {
            try getReservationsFromDisk()
        }
        catch {
            if let _ = ReservationService.shared.makeTestReservation() {
                print("Made Test Reservation 1")
            }
            else {
                print("Error after makeTestReservation")
            }
            
            if let _ = ReservationService.shared.makeTestReservation() {
                print("Made Test Reservation 2")
            }
            else {
                print("Error after makeTestReservation")
            }
        }
    }

    // Get the application document's url.
    func getDocumentsURL() -> URL? {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            return nil
        }
    }
    
    // Get the reservation data url.
    func getReservationDataURL() -> URL? {
        if let url = getDocumentsURL() {
            return url.appendingPathComponent(reservationsDataFileName)
        } else {
            return nil
        }
    }
    
    // Save the list of reservations to disk.
    //
    // Throws a ReservationError.couldNotSaveRevervations error if
    // the reservations could nt be saved.
    func saveReservationsToDisk() throws {
        guard (reservations != nil) && reservations!.count > 0 else {
            return
        }
        guard let url = getReservationDataURL() else {
            throw ReservationError.couldNotSaveError
        }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(reservations)
            try data.write(to: url, options: [])
            print("Saved Reservations To Disk: \(reservations!.count)")
        } catch {
            throw ReservationError.couldNotSaveError
        }
    }
    
    func getReservationsFromDisk() throws  {
        guard let url = getReservationDataURL() else  {
            throw ReservationError.couldNotLoadError
        }
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url, options: [])
            self.reservations = try decoder.decode([Reservation].self, from: data)
            print("Loaded Reservations From Disk: \(reservations!.count)")
            print("Reservations: \(reservations)")
        } catch {
            print("Error Loaded Rservations!: \(error.localizedDescription)")
           throw ReservationError.couldNotLoadError
        }
    }
    
    // MARK: Date Utilities
    
    // get the month and day string from a date (for example: "Nov 12, 2017")
    func getMonthAndDayString(from date: Date) -> String {
        return monthAndDayFormatter.string(from:date)
    }
    
    // get the time string from a date (for example: "7:41 AM")
    func getTimeString(from date: Date) -> String {
        return timeFormatter.string(from:date)
    }
    
    // get the abbreviated month (for exmple: "Nov")
    func getDayOfMonthShortString(from date: Date) -> String {
        let unitFlags: Set<Calendar.Component> = [.month]
        let components = Calendar.current.dateComponents(unitFlags, from: date)
        if let month = components.month {
            switch month {
            case 1:
                return "Jan"
            case 2:
                return "Feb"
            case 3:
                return "Mar"
            case 4:
                return "Apr"
            case 5:
                return "May"
            case 6:
                return "June"
            case 7:
                return "July"
            case 8:
                return "Aug"
            case 9:
                return "Sept"
            case 10:
                return "Oct"
            case 11:
                return "Nov"
            case 12:
                return "Dec"
            default:
                // handle invalid month
                return ""
            }
        }
        else {
            return ""
        }
    }
    
    // Create a date using the year, month, day, hours, and minutes components
    // Parameters: year = current year, day = 1-31, hours = 0-23, minutes = 0-60
    func getDate(from reservationDate: ReservationDateType) throws -> Date {
        let secondsPerMinute = 60
        let secondsPerHour = secondsPerMinute * 60
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter
        }()
        
        let dateString = String(format: "%d/%d/%d", reservationDate.month, reservationDate.day, reservationDate.year)
        if let date = dateFormatter.date(from: dateString) {
            // get the date of the start of the specifed day
            let dateAtStartOfDay = Calendar.current.startOfDay(for: date)
            
            // compute the real time of day result by adding the hours and minutes
            // to the start of the day.
            let timeOffset: Double = Double(reservationDate.hours * secondsPerHour) + Double(reservationDate.minutes * secondsPerMinute)
            return dateAtStartOfDay.addingTimeInterval(timeOffset)
        }
        else {
            throw ReservationError.invalidDateError
        }
    }
    
    // MARK: Reservations
    
    // Make a new reservation with the date (using the year, month, day, hours, and minutes components)
    // Parameters: year = current year, day = 1-31, hours = 0-23, minutes = 0-60
    func makeReservation(serviceType: MessageServiceType, reservationDate: ReservationDateType,
                         partySize: Int = 1) throws -> Reservation {
        let reservationService = ReservationService.shared
        let date = try reservationService.getDate(from:reservationDate)
        let reservation = Reservation(partySize: partySize, serviceType: serviceType, date: date)
        return reservation
    }
    
    // MARK: Testing
    func makeTestReservation() -> Reservation? {
        let reservationDate: ReservationDateType = (year: 2016, month: 3, day: 26, hours: 10, minutes: 00)
        let reservationService = ReservationService.shared
        if let reservation = try? reservationService.makeReservation(serviceType: .gelManicure,
                                                                     reservationDate: reservationDate) {
            if reservations == nil {
                reservations = []
            }
            self.reservations!.append(reservation)
            do {
                try saveReservationsToDisk()
            }
            catch {
                return nil
            }
            return reservation
        }
        else {
            return nil
        }
    }
}




