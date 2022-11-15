import java.lang.Math;

public class Utils {

    // Constantes relacionadas con las centrales
    static int CENTRAL_A_PARADA = 15000;
    static int CENTRAL_B_PARADA = 5000;
    static int CENTRAL_C_PARADA = 1500;
    static int CENTRAL_A_MARCHA_PROD = 50;
    static int CENTRAL_B_MARCHA_PROD = 80;
    static int CENTRAL_C_MARCHA_PROD = 150;
    static int CENTRAL_A_MARCHA_BASE = 20000;
    static int CENTRAL_B_MARCHA_BASE = 10000;
    static int CENTRAL_C_MARCHA_BASE = 5000;

    // Constantes relacionadas con los clientes
    static int CLIENTE_XG_GARANTIZADO = 400;
    static int CLIENTE_XG_NO_GARANTIZADO = 300;
    static int CLIENTE_MG_GARANTIZADO = 500;
    static int CLIENTE_MG_NO_GARANTIZADO = 400;
    static int CLIENTE_G_GARANTIZADO = 600;
    static int CLIENTE_G_NO_GARANTIZADO = 500;

    static int CLIENTE_NO_GARANTIZADO_INDEM = 50;

    public static int RAND_SEED = (int) Math.floor(Math.random() * ( 10000 - 0 + 1) + 0);


    public static float euclideanDistance(int x1, int y1, int x2, int y2) {
        double x = x2 - x1;
        double y = y2 - y1;
        return (float) Math.sqrt(Math.pow(x,2) + Math.pow(y,2));
    }
}
