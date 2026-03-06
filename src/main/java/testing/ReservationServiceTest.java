package testing;

import static org.junit.Assert.assertThrows;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.LocalDate;

import org.junit.jupiter.api.Test;

import com.hotel.service.ReservationService;

public class ReservationServiceTest {

    @Test
    public double calculateTotal(int nights, double pricePerNight) {
        if (nights <= 0 || pricePerNight < 0) {
            throw new IllegalArgumentException("Invalid reservation values");
        }
        return nights * pricePerNight;
    }
    
    
    @Test
    void validateDates_shouldReturnTrueForValidDates() {
        ReservationService service = new ReservationService();

        boolean result = service.validateDates(
            LocalDate.of(2026, 3, 10),
            LocalDate.of(2026, 3, 12)
        );

        assertTrue(result);
    }

    @Test
    void validateDates_shouldThrowExceptionWhenCheckoutBeforeCheckin() {
        ReservationService service = new ReservationService();

        assertThrows(IllegalArgumentException.class, () -> {
            service.validateDates(
                LocalDate.of(2026, 3, 12),
                LocalDate.of(2026, 3, 10)
            );
        });
    }
}