package testing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import com.hotel.util.PasswordUtil;

public class LoginTest {

    @Test
    void loginPassword_shouldGenerateHash() {
        String password = "123456";
        String hashedPassword = PasswordUtil.sha256(password);

        assertNotNull(hashedPassword);
    }

    @Test
    void loginPassword_shouldMatchExpectedHash() {
        String password = "123456";
        String hash1 = PasswordUtil.sha256(password);
        String hash2 = PasswordUtil.sha256(password);

        assertEquals(hash1, hash2);
    }
}