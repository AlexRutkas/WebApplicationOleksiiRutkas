package logic;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashChecker {
    public static boolean isSame(String message, String hash) {
        return hash.equals(getHash(message));
    }

    public static String getHash(String string) {
        if (string == null)
            return null;
        StringBuilder builder = new StringBuilder();
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] digest = md5.digest(string.getBytes());

            for (byte b: digest) {
                builder.append(String.format("%02x", b));
            }

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return builder.toString();
    }
}
