import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;

public class SuccesorsHC implements SuccessorFunction {
    public ArrayList<Successor> getSuccessors(Object o) {
        ArrayList<Successor> ret = new ArrayList<>();
        State aux  = (State) o;
        State st = new State(aux.getCentrales(),aux.getClientes(),aux.getCServing(), aux.getCLServed(), aux.getBeneficio(),aux.getNumClG());

        for (int i = 0; i < st.numC(); ++i) {
            for (int j = 0; j < st.numCl(); ++j) {
                if (!st.isClientServed(j) && st.CentralCanSubToClient(j,i)) {
                    State op_add = new State(st.getCentrales(),st.getClientes(),st.getCServing(), st.getCLServed(), st.getBeneficio(), st.getNumClG());

                    op_add.addClientToCentral(j,i);
                    ret.add(new Successor("A" + "\n", op_add));
                }

                if (st.isClientServed(j)) {
                    int C = st.getCentralClient(j);
                    if (C != i) {
                        if (st.CentralCanSubToClient(j, i)) {
                            State op_move = new State(st.getCentrales(), st.getClientes(), st.getCServing(), st.getCLServed(), st.getBeneficio(), st.getNumClG());
                            op_move.move(j, C, i);
                            ret.add(new Successor("M" + "\n", op_move));
                        }
                    }
                }
            }
        }

        for (int i = 0; i < st.numCl(); ++i) {
            if (st.isClientServed(i)) {
                int C1 = st.getCentralClient(i);
                for (int j = i+1; j < st.numCl(); ++j) {
                    if (i != j && st.isClientServed(j)) {
                        int C2 = st.getCentralClient(j);
                        if (C2 != C1 && st.canSwapBeMade(i, C1, j, C2)) {
                            if (st.canSwapBeMade(i, C1, j, C2)) {
                                State op_swap = new State(st.getCentrales(), st.getClientes(), st.getCServing(), st.getCLServed(), st.getBeneficio(), st.getNumClG());

                                op_swap.swapClients(i, C1, j, C2);
                                ret.add(new Successor("S" + "\n", op_swap));
                            }
                        }
                    }
                }
            }
        }

        return ret;
    }
}