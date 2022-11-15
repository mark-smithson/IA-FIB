import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;
import java.util.List;

public class SuccesorsSA implements SuccessorFunction {

    private int getRandom(int max) {
        return (int) Math.floor(Math.random() * (max + 1) + 0);
    }

    private boolean canAdd(State state, int client, int central) {
        return !state.isClientServed(client) && state.CentralCanSubToClient(client, central);
    }

    private boolean canMove(State state, int client, int futureCentral) {
        if (state.isClientServed(client)) {
            int actualCentral = state.getCentralClient(client);
            if (actualCentral != futureCentral)
                return state.CentralCanSubToClient(client, futureCentral);
        }

        return false;
    }

    private boolean canSwap(State state, int client1, int client2) {
        if (client1 != client2 && state.isClientServed(client1) && state.isClientServed(client2)) {
            int central1 = state.getCentralClient(client1);
            int central2 = state.getCentralClient(client2);
            return (central1 != central2) && state.canSwapBeMade(client1, central1, client2, central2);
        }
        return false;
    }

    private State add(State actualState, int client, int central) {
        State added_state = new State(actualState.getCentrales(), actualState.getClientes(), actualState.getCServing(), actualState.getCLServed(), actualState.getBeneficio(), actualState.getNumClG());
        added_state.addClientToCentral(client, central);
        return added_state;
    }

    private State move(State actualState, int client, int futureCentral) {
        State moved_state = new State(actualState.getCentrales(), actualState.getClientes(), actualState.getCServing(), actualState.getCLServed(), actualState.getBeneficio(), actualState.getNumClG());
        int actualCentral = actualState.getCentralClient(client);
        moved_state.move(client, actualCentral, futureCentral);
        return moved_state;
    }

    private State swap(State actualState, int client1, int client2) {
        State swapped_state = new State(actualState.getCentrales(), actualState.getClientes(), actualState.getCServing(), actualState.getCLServed(), actualState.getBeneficio(), actualState.getNumClG());
        int central1 = actualState.getCentralClient(client1);
        int central2 = actualState.getCentralClient(client2);
        swapped_state.swapClients(client1, central1, client2, central2);
        return swapped_state;
    }


    @Override
    public List getSuccessors(Object object) {
        ArrayList<Successor> ret = new ArrayList<>();
        State actual_state = (State) object;

        boolean operationMade = false;
        while (!operationMade) {
            int randomOperation = getRandom(2);

            if (randomOperation == 0) {         // Add operation
                int client = getRandom(actual_state.numCl()-1);
                int central = getRandom(actual_state.numC()-1);
                if (canAdd(actual_state, client, central))
                    ret.add(new Successor("A" + "\n", add(actual_state, client, central)));
            } else if (randomOperation == 1) {  // Move operation
                int client = getRandom(actual_state.numCl()-1);
                int futureCentral = getRandom(actual_state.numC()-1);
                if (canMove(actual_state, client, futureCentral))
                    ret.add(new Successor("M" + "\n", move(actual_state, client, futureCentral)));
            } else {                            // Swap operation
                int client1 = getRandom(actual_state.numCl()-1);
                int client2 = getRandom(actual_state.numCl()-1);
                if (canSwap(actual_state, client1, client2))
                    ret.add(new Successor("S" + "\n", swap(actual_state, client1, client2)));
            }

            if (ret.size() > 0)
                operationMade = true;
        }

        return ret;
    }
}
