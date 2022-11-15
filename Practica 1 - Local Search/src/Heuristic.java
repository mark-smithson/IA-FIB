import aima.search.framework.HeuristicFunction;

public class Heuristic implements HeuristicFunction {
    public double getHeuristicValue(Object state) {
        State st = (State) state;

        return -st.getBeneficio();
    }
}
