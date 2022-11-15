import aima.search.framework.HeuristicFunction;

public class Heuristic2 implements HeuristicFunction {
    public double getHeuristicValue(Object state) {
        State st = (State) state;
        return -st.getBeneficio() + st.getPenalty()*(st.getMaxnumCLG() - st.getNumClG());
    }
}
