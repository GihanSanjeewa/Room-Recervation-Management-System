package testing;

import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

import com.hotel.util.PasswordUtil;

public class RegisterTest {

    @Test
    void registerPassword_shouldNotBePlainText() {
        String password = "myPassword123";
        String hashedPassword = PasswordUtil.sha256(password);

        assertNotEquals(password, hashedPassword);
    }

    @Test
    void registerPassword_shouldHaveValue() {
        String password = "myPassword123";
        String hashedPassword = PasswordUtil.sha256(password);

        assertTrue(hashedPassword.length() > 0);
    }
}