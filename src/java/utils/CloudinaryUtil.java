package utils;

import com.cloudinary.Cloudinary;
import java.util.HashMap;
import java.util.Map;

public class CloudinaryUtil {

    private static final Cloudinary cloudinary;

    static {
        try {
            Map<String, String> config = new HashMap<>();
            config.put("cloud_name", "driazuszh");
            config.put("api_key", "889594262588419");
            config.put("api_secret", "xXI9xwRVZPdmDcujyBvbufci4_k");

            cloudinary = new Cloudinary(config);

            // Test configuration
            System.out.println("Cloudinary configuration initialized: " + cloudinary.config.toString());
        } catch (Exception e) {
            System.out.println("Error initializing Cloudinary: " + e.getMessage());
            throw e;
        }
    }

    public static Cloudinary getCloudinary() {
        return cloudinary;
    }
}
