import IA.Energia.Central;
import IA.Energia.Centrales;
import IA.Energia.Cliente;
import IA.Energia.Clientes;
import java.util.*;

public class State {

    // Distancia de cada central con todos los clientes para todas las centrales
    static Float[][] dists;
    static int seed;
    static int [] n_centrales;
    static int n_clientes;
    static double [] prop_clientes;
    static double clientes_garant;
    static Centrales centrales;
    static Clientes clientes;
    static double penalty;
    static int h;
    static int MaxnumCLG;
    double [] CCanServe;
    Integer[] CLServed;
    double beneficio;
    int numClG;


    private void calculateDists() {
        dists = new Float[centrales.size()][clientes.size()];
        for (int i = 0; i < centrales.size(); i++) {
            for (int j = 0; j < clientes.size(); j++) {
                int cx = centrales.get(i).getCoordX();
                int cy = centrales.get(i).getCoordY();

                int clx = clientes.get(j).getCoordX();
                int cly = clientes.get(j).getCoordY();

                dists[i][j]=Utils.euclideanDistance(cx,cy,clx,cly);
            }
        }
    }
    private void calcularBenef() {
        beneficio = 0.0;
        for (int i = 0; i < CCanServe.length; ++i) {
            Central C = centrales.get(i);
            double prod = C.getProduccion() - CCanServe [i];

            // Serving
            if (prod > 0) {
                double benef_clients = 0.0;
                for (int cl = 0; cl < clientes.size(); ++cl) {
                    // client getting energy
                    if (CLServed[cl] == i) benef_clients += updateBenef(clientes.get(cl));
                }

                beneficio += benef_clients;

                if (C.getTipo() == 0) beneficio -= prod*Utils.CENTRAL_A_MARCHA_PROD + Utils.CENTRAL_A_MARCHA_BASE;
                else if (C.getTipo() == 1) beneficio -= prod*Utils.CENTRAL_B_MARCHA_PROD + Utils.CENTRAL_B_MARCHA_BASE;
                else beneficio -= prod*Utils.CENTRAL_C_MARCHA_PROD + Utils.CENTRAL_C_MARCHA_BASE;
            }

            // Not serving
            else {
                if (C.getTipo() == 0) beneficio -= Utils.CENTRAL_A_PARADA;
                else if (C.getTipo() == 1) beneficio -= Utils.CENTRAL_B_PARADA;
                else beneficio -= Utils.CENTRAL_C_PARADA;
            }
        }

        for (int i = 0; i < clientes.size(); i++) {
            if (CLServed[i] == -1 && clientes.get(i).getContrato() == 1) {
                beneficio -= Utils.CLIENTE_NO_GARANTIZADO_INDEM*clientes.get(i).getConsumo();
            }
        }
    }



    private double loss_dist(double dist) {
        if (dist <= 10.0) return 0.0;
        else if (dist > 10.0 && dist <= 25.0) return 0.1;
        else if (dist > 25.0 && dist <= 50.0) return 0.2;
        else if (dist > 50.0 && dist <= 75.0) return 0.4;
        else return 0.6;
    }

    /*
     * Actualiza los clientes para el estado inicial
     * */
    private void updateClientes(ArrayList<Integer> clientesAux) {
        for (int i = 0; i < centrales.size(); ++i) {
            for (Integer j : clientesAux) {
                Cliente cl = clientes.get(j);
                double dist = dists[i][j];
                double ld = loss_dist(dist);

                if (CCanServe[i] - (cl.getConsumo() + cl.getConsumo()*ld) >= 0 && CLServed[j] == -1) {
                    ++numClG;
                    double d= CCanServe[i]-(cl.getConsumo()+cl.getConsumo()*ld);
                    CCanServe[i]=d;
                    CLServed[j]=i;
                }
            }
        }
    }

    /*
     * 1 - Asignamos los clientes garantizados
     * */
    private void solucionInicialClientesGarantizados() {
        // Assign all granted service clients.
        for (int i = 0; i < centrales.size(); ++i) {
            for (int j = 0; j < clientes.size(); ++j) {
                Cliente cl = clientes.get(j);
                double dist = dists[i][j];
                double ld = loss_dist(dist);

                if (cl.getContrato() == 0 && CCanServe[i] - (cl.getConsumo() + cl.getConsumo()*ld) >= 0 && CLServed[j] == -1) {
                    ++numClG;
                    double d= CCanServe[i]-(cl.getConsumo()+cl.getConsumo()*ld);
                    CCanServe[i]=d;
                    CLServed[j]=i;
                }
            }
        }
    }

    // CUANDO SE EJECUTA CON EL SEED = 7221 prioriy SE QUEDA A 5 Y NO SALE DEL BUCLE PARA LOS DOS UNIFORMES
    //  HAY QUE MIRAR PORQUE ES
    //  EJECUTANDOLO CON EL INISOL = 0 SEED = 7221 DA QUE PUEDE ABASTECER A 917 CLIENTES.
    /*
     * 1 - Asignamos los clientes garantizados a las centrales de manera uniforme
     * */
    private void solucionInicialGarantizadosUniforme() {
        int priority = 0;

        for (Cliente cliente : clientes) {
            if (cliente.getContrato() == 0) ++priority;
        }

        while (priority > 0) {
            for (int i = 0; i < centrales.size(); ++i) {
                if (CCanServe[i] > 0) {
                    for (int j = 0; j < clientes.size(); ++j) {
                        if (clientes.get(j).getContrato() == 0) {
                            Cliente cl = clientes.get(j);
                            double dist = dists[i][j];
                            double ld = loss_dist(dist);
                            if (CCanServe[i] - (cl.getConsumo() + cl.getConsumo() * ld) >= 0 && CLServed[j] == -1) {
                                ++numClG;
                                double d= CCanServe[i]-(cl.getConsumo()+cl.getConsumo()*ld);
                                CCanServe[i]=d;
                                CLServed[j]=i;
                                --priority;
                                if (priority < 10)
                                    System.out.println(0);
                                break;
                            }

                        }
                    }
                }
            }
        }
    }

    /*
     * 1 - Asignamos los clientes garantizados a las centrales de manera uniforme
     * 2 - Asignamos los clientes no garantizados a las centrales de manera uniforme
     * */
    private void solucionInicialClientesUniforme() {
        int priority = 0;

        for (Cliente cliente : clientes) {
            if (cliente.getContrato() == 0) ++priority;
        }

        while (priority > 0) {
            for (int i = 0; i < centrales.size(); ++i) {
                if (CCanServe[i] > 0) {
                    for (int j = 0; j < clientes.size(); ++j) {
                        if (clientes.get(j).getContrato() == 0) {
                            Cliente cl = clientes.get(j);
                            double dist = dists[i][j];
                            double ld = loss_dist(dist);
                            if (CCanServe[i] - (cl.getConsumo() + cl.getConsumo() * ld) >= 0 && CLServed[j] == -1) {
                                ++numClG;
                                double d= CCanServe[i]-(cl.getConsumo()+cl.getConsumo()*ld);
                                CCanServe[i]=d;
                                CLServed[j]=i;
                                --priority;
                                break;
                            }

                        }
                    }
                }
            }
        }

        for (int i = 0; i < centrales.size(); ++i) {
            if (CCanServe[i] > 0) {
                for (int j = 0; j < clientes.size(); ++j) {
                    if (clientes.get(j).getContrato() == 1) {
                        Cliente cl = clientes.get(j);
                        double dist = dists[i][j];
                        double ld = loss_dist(dist);
                        if (CCanServe[i] - (cl.getConsumo() + cl.getConsumo() * ld) >= 0 && CLServed[j] == -1) {
                            double d= CCanServe[i]-(cl.getConsumo()+cl.getConsumo()*ld);
                            CCanServe[i]=d;
                            CLServed[j]=i;
                            break;
                        }

                    }
                }
            }
        }
    }

    /*
     * 1 - Ordenamos los clientes garantizados por consumo de mayor a menor
     * 2 - Vamos asignando estos clientes a las centrales según quepan
     * 3 - Ordenamos los clientes no garantizados por consumo de mayor a menor
     * 4 - Vamos asignando estos a las centrales hasta llenar todas las centrales o subministrar a todos los clientes.
     * */
    private void solucionInicialClientesOrdenados() {
        ArrayList<Integer> clientesGarantizados = new ArrayList<>();
        ArrayList<Integer> clientesNoGarantizados = new ArrayList<>();
        for (int i = 0; i < clientes.size(); i++) {
            if (clientes.get(i).getContrato() == 0)
                clientesGarantizados.add(i);
            else
                clientesNoGarantizados.add(i);
        }

        clientesGarantizados.sort((p1, p2) -> Double.compare(clientes.get(p2).getConsumo(), clientes.get(p1).getConsumo()));
        updateClientes(clientesGarantizados);

        clientesNoGarantizados.sort((p1, p2) -> Double.compare(clientes.get(p2).getConsumo(), clientes.get(p1).getConsumo()));
        updateClientes(clientesNoGarantizados);
    }

    /*
     * 1 - Asignamos los clientes garantizados a la central más cercana.
     * */
    private void solucionInicialGarantizadosPorDistancia() {
        ArrayList<Integer> clientesGarantizados = new ArrayList<>();
        for (int i = 0; i < clientes.size(); i++) {
            if (clientes.get(i).getContrato() == 0)
                clientesGarantizados.add(i);
        }

        for (Integer j : clientesGarantizados) {
            Cliente cl = clientes.get(j);
            double min = Double.POSITIVE_INFINITY;
            int x = 0;
            for (int i = 0; i < centrales.size(); i++) {
                double dist = dists[i][j];
                double ld = loss_dist(dist);
                if (dist < min && CCanServe[i] - (cl.getConsumo() + cl.getConsumo()*ld) >= 0 && CLServed[j] == -1) {
                    min = dist;
                    x = i;
                }
            }
            ++numClG;
            double ld = loss_dist(dists[x][j]);
            double d= CCanServe[x]-(cl.getConsumo()+cl.getConsumo()*ld);
            CCanServe[x]=d;
            CLServed[j]=x;
        }
    }


    public State(int seed, int [] n_centrales, int n_clientes, double [] prop_clientes, double clientes_garant, int solInicial, double penalty, int h) throws Exception {

        State.seed = seed;
        State.n_centrales = n_centrales;
        State.n_clientes = n_clientes;
        State.prop_clientes = prop_clientes;
        State.clientes_garant = clientes_garant;
        State.penalty = penalty;
        State.h = h;

        centrales = new Centrales(n_centrales, seed);
        clientes = new Clientes(n_clientes,prop_clientes,clientes_garant,seed);

        CCanServe = new double[centrales.size()];

        for (int i = 0; i < centrales.size(); ++i) {
            CCanServe[i] = centrales.get(i).getProduccion();
        }
        int n = 0;
        CLServed = new Integer[clientes.size()];
        for (int i = 0; i < clientes.size(); ++i) {
            if (clientes.get(i).getContrato() == 0) ++n;
            CLServed[i] = -1;
        }

        State.MaxnumCLG = n;

        calculateDists();
        numClG = 0;
        // generate first solution
        if (h == 0) {
            if (solInicial == 0)
                solucionInicialClientesGarantizados();
            else if (solInicial == 1)
                solucionInicialGarantizadosUniforme();
            else if (solInicial == 2)
                solucionInicialClientesUniforme();
            else if (solInicial == 3)
                solucionInicialClientesOrdenados();
            else if (solInicial == 4)
                solucionInicialGarantizadosPorDistancia();
        }
        calcularBenef();
    }

    public State(Centrales centrales, Clientes clientes, double[] CCanServe, Integer[] CLServed, double beneficio, int numClG) {
        State.centrales = centrales;
        State.clientes = clientes;

        this.CCanServe = new double[centrales.size()];
        System.arraycopy(CCanServe, 0, this.CCanServe, 0, centrales.size());

        this.CLServed = new Integer[clientes.size()];
        System.arraycopy(CLServed, 0, this.CLServed, 0, clientes.size());

        this.beneficio = beneficio;

        this.numClG = numClG;
    }

    public Centrales getCentrales() {
        return centrales;
    }

    public Clientes getClientes() {
        return clientes;
    }

    public double[] getCServing() {
        return CCanServe;
    }

    public Integer[] getCLServed() {
        return CLServed;
    }

    public double getBeneficio() {
        return beneficio;
    }

    public boolean CentralCanSubToClient(int cl, int C) {
        Cliente CL = clientes.get(cl);
        double dist = dists[C][cl];
        double ld = loss_dist(dist);

        return (CCanServe[C] - (CL.getConsumo() + CL.getConsumo()*ld) >= 0);
    }

    public void addClientToCentral(int cl, int C) {
        Cliente cProd = clientes.get(cl);
        Central CL = centrales.get(C);

        if (cProd.getContrato() == 0) ++numClG;

        boolean firstClient = (CL.getProduccion() - CCanServe[C]) < .1;

        double prod = CL.getProduccion() - CCanServe[C];

        double dist = dists[C][cl];
        double ld = loss_dist(dist);

        if (!firstClient) {
            if (CL.getTipo() == 0) beneficio += prod*Utils.CENTRAL_A_MARCHA_PROD + Utils.CENTRAL_A_MARCHA_BASE;
            else if (CL.getTipo() == 1) beneficio += prod*Utils.CENTRAL_B_MARCHA_PROD + Utils.CENTRAL_B_MARCHA_BASE;
            else beneficio += prod*Utils.CENTRAL_C_MARCHA_PROD + Utils.CENTRAL_C_MARCHA_BASE;
        }

        CCanServe[C]= CCanServe[C] - (cProd.getConsumo() + cProd.getConsumo()*ld);
        CLServed[cl]=C;

        prod = CL.getProduccion() - CCanServe[C];

        if (cProd.getContrato() == 1) beneficio += Utils.CLIENTE_NO_GARANTIZADO_INDEM*cProd.getConsumo();
        beneficio += updateBenef(cProd);

        if (CL.getTipo() == 0) beneficio -= prod*Utils.CENTRAL_A_MARCHA_PROD + Utils.CENTRAL_A_MARCHA_BASE;
        else if (CL.getTipo() == 1) beneficio -= prod*Utils.CENTRAL_B_MARCHA_PROD + Utils.CENTRAL_B_MARCHA_BASE;
        else beneficio -= prod*Utils.CENTRAL_C_MARCHA_PROD + Utils.CENTRAL_C_MARCHA_BASE;

        if (CL.getTipo() == 0) {
            if (firstClient) beneficio += Utils.CENTRAL_A_PARADA;
        }
        else if (CL.getTipo() == 1) {
            if (firstClient) beneficio += Utils.CENTRAL_B_PARADA;
        }
        else {
            if (firstClient) beneficio += Utils.CENTRAL_C_PARADA;
        }
    }

    public void removeClientToCentral(int cl, int C) {
        Cliente cProd = clientes.get(cl);
        Central CL = centrales.get(C);

        if (cProd.getContrato() == 0) --numClG;

        double prod = CL.getProduccion() - CCanServe[C];
        double dist = dists[C][cl];
        double ld = loss_dist(dist);

        if (CL.getTipo() == 0) beneficio += prod*Utils.CENTRAL_A_MARCHA_PROD + Utils.CENTRAL_A_MARCHA_BASE;
        else if (CL.getTipo() == 1) beneficio += prod*Utils.CENTRAL_B_MARCHA_PROD + Utils.CENTRAL_B_MARCHA_BASE;
        else beneficio += prod*Utils.CENTRAL_C_MARCHA_PROD + Utils.CENTRAL_C_MARCHA_BASE;

        CCanServe[C]= CCanServe[C] + (cProd.getConsumo() + cProd.getConsumo()*ld);
        CLServed[cl]=-1;

        prod = CL.getProduccion() - CCanServe[C];

        if (cProd.getContrato() == 1) beneficio -= Utils.CLIENTE_NO_GARANTIZADO_INDEM*cProd.getConsumo();
        beneficio -= updateBenef(cProd);

        boolean firstClient = (CL.getProduccion() - CCanServe[C]) < .1;

        if (CL.getTipo() == 0) {
            if (firstClient) beneficio -= Utils.CENTRAL_A_PARADA;
            else beneficio -= prod*Utils.CENTRAL_A_MARCHA_PROD + Utils.CENTRAL_A_MARCHA_BASE;
        }
        else if (CL.getTipo() == 1) {
            if (firstClient) beneficio -= Utils.CENTRAL_B_PARADA;
            else beneficio -= prod*Utils.CENTRAL_B_MARCHA_PROD + Utils.CENTRAL_B_MARCHA_BASE;
        }
        else {
            if (firstClient) beneficio -= Utils.CENTRAL_C_PARADA;
            else beneficio -= prod*Utils.CENTRAL_C_MARCHA_PROD + Utils.CENTRAL_C_MARCHA_BASE;
        }
    }

    public int getCentralClient(int cl) {
        return CLServed[cl];
    }

    public boolean canSwapBeMade(int cl1, int C1, int cl2, int C2) {
        Cliente CL1 = clientes.get(cl1);
        double dist1 = dists[C1][cl1];
        double ld1 = loss_dist(dist1);

        Cliente CL2 = clientes.get(cl2);
        double dist2 = dists[C2][cl2];
        double ld2 = loss_dist(dist2);

        double benef_removing_cl1 = CCanServe[C1] + (CL1.getConsumo() + CL1.getConsumo()*ld1);
        double benef_removing_cl2 = CCanServe[C2] + (CL2.getConsumo() + CL2.getConsumo()*ld2);

        return (benef_removing_cl1 - (CL2.getConsumo() + CL2.getConsumo()*ld2)) >= 0 && (benef_removing_cl2 - (CL1.getConsumo() + CL1.getConsumo()*ld1) >= 0);
    }

    public void move(int cl1, int C1, int C2) {
        this.removeClientToCentral(cl1,C1);
        this.addClientToCentral(cl1,C2);
        //swap cl1 & cl2 + calculate the new values
    }

    // pre: both clients are being supplied and cl1 != cl2 IMPLEMENT TO SWAP IF DISTANCES BETWEEN TWO ARE CLOSER THAN THE ONES THAT THEY ARE ALREADY ASSIGNED
    // post: we swap the centrals of the clients
    public void swapClients(int cl1, int C1, int cl2, int C2) {
        this.removeClientToCentral(cl1,C1);
        this.removeClientToCentral(cl2,C2);

        this.addClientToCentral(cl1,C2);
        this.addClientToCentral(cl2,C1);
    }

    public int numC() {
        return centrales.size();
    }

    public int numCl() {
        return clientes.size();
    }

    public int numClServed() {
        int count = 0;
        for (Integer integer : CLServed) {
            if (integer != -1) ++count;
        }
        return count;
    }

    public double getPenalty() {
        return penalty;
    }

    public int getNumClG() {
        return numClG;
    }

    public int getMaxnumCLG() {
        return  MaxnumCLG;
    }

    public boolean isClientServed(int cl) {
        return CLServed[cl] != -1;
    }

    public double updateBenef(Cliente c){
        if(c.getTipo()==0){
            if (c.getContrato()==0) return Utils.CLIENTE_XG_GARANTIZADO*c.getConsumo();
            else return Utils.CLIENTE_XG_NO_GARANTIZADO*c.getConsumo();
        }
        else if (c.getTipo()==1){
            if(c.getContrato()==0) return Utils.CLIENTE_MG_GARANTIZADO*c.getConsumo();
            else return Utils.CLIENTE_MG_NO_GARANTIZADO*c.getConsumo();
        }
        else{
            if(c.getContrato()==0) return Utils.CLIENTE_G_GARANTIZADO*c.getConsumo();
            else return Utils.CLIENTE_G_NO_GARANTIZADO*c.getConsumo();
        }
    }
}
