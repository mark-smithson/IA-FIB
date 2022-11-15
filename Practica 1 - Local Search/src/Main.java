import IA.Energia.Central;
import IA.Energia.Centrales;
import IA.Energia.Cliente;
import IA.Energia.Clientes;
import aima.search.framework.Problem;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.HillClimbingSearch;
import aima.search.informed.SimulatedAnnealingSearch;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.CommandLine;

import java.util.List;
import java.util.Objects;
import java.util.Properties;

public class Main {
    static String ALGORITHM_OPTION = "sa";
    static String INITIAL_SOLUTION_OPTION = "i";
    static String SEED_OPTION = "seed";
    static String NUM_CLIENTS_OPTION = "nc";
    static String NUM_CENTRALS_OPTION = "nC";
    static String PROP_CLIENTS_TYPE_XG_OPTION = "xg";
    static String PROP_CLIENTS_TYPE_MG_OPTION = "mg";
    static String PROP_CLIENTS_TYPE_G_OPTION = "g";
    static String PROP_CENTRALS_TYPE_A_OPTION = "a";
    static String PROP_CENTRALS_TYPE_B_OPTION = "b";
    static String PROP_CENTRALS_TYPE_C_OPTION = "c";
    static String PROP_CLIENTS_GUARANTEED_OPTION = "G";
    static String STEPS_OPTION = "s";
    static String STITER_OPTION = "S";
    static String K_OPTION = "k";
    static String LAMBDA_OPTION = "l";
    static String PENALTY_OPTION = "p";

    static String HEURISTIC_OPTION = "h";

    static String ALGORITHM_LONG_OPTION = "simulatedAnnealing";
    static String INITIAL_SOLUTION_LONG_OPTION = "initialSolution";
    static String SEED_LONG_OPTION = "seed";
    static String NUM_CLIENTS_LONG_OPTION = "numClients";
    static String NUM_CENTRALS_LONG_OPTION = "numCentrals";
    static String PROP_CLIENTS_TYPE_XG_LONG_OPTION = "propClientsTypeXG";
    static String PROP_CLIENTS_TYPE_MG_LONG_OPTION = "propClientsTypeMG";
    static String PROP_CLIENTS_TYPE_G_LONG_OPTION = "propClientsTypeG";
    static String PROP_CENTRALS_TYPE_A_LONG_OPTION = "propCentralsTypeA";
    static String PROP_CENTRALS_TYPE_B_LONG_OPTION = "propCentralsTypeB";
    static String PROP_CENTRALS_TYPE_C_LONG_OPTION = "propCentralsTypeC";
    static String PROP_CLIENTS_GUARANTEED_LONG_OPTION = "propClientsGuaranteed";
    static String STEPS_LONG_OPTION = "steps";
    static String STITER_LONG_OPTION = "stiter";
    static String K_LONG_OPTION = "k";
    static String LAMBDA_LONG_OPTION = "lambda";
    static String PENALTY_LONG_OPTION = "penalty";

    static String HEURISTIC_LONG_OPTION = "heuristic";
    static String ALGORITHM_DESCRIPTION = "Option to execute Simulated Annealing instead of Hill Climbing";
    static String INITIAL_SOLUTION_DESCRIPTION = """
            Initial solution options:
            0 = Allocates guaranteed clients without any type of sort
            1 = Allocates guaranteed clients using a uniform distribution
            2 = Allocates all clients using a uniform distribution
            3 = Allocates all clients by distance
            4 = Allocates all clients by consumption""";
    static String SEED_DESCRIPTION = "Seed";
    static String NUM_CLIENTS_DESCRIPTION = "Number of clients";
    static String NUM_CENTRALS_DESCRIPTION = "Number of centrals";
    static String PROP_CLIENTS_TYPE_XG_DESCRIPTION = "Proportion of clients type XG";
    static String PROP_CLIENTS_TYPE_MG_DESCRIPTION = "Proportion of clients type MG";
    static String PROP_CLIENTS_TYPE_G_DESCRIPTION = "Proportion of clients type G";
    static String PROP_CENTRALS_TYPE_A_DESCRIPTION = "Proportion of centrals type A";
    static String PROP_CENTRALS_TYPE_B_DESCRIPTION = "Proportion of centrals type B";
    static String PROP_CENTRALS_TYPE_C_DESCRIPTION = "Proportion of centrals type C";
    static String PROP_CLIENTS_GUARANTEED_DESCRIPTION = "Proportion of guaranteed clients";
    static String STEPS_DESCRIPTION = "Steps of Simulated Annealing";
    static String STITER_DESCRIPTION = "Stiter of Simulated Annealing";
    static String K_DESCRIPTION = "k of Simulated Annealing";
    static String LAMBDA_DESCRIPTION = "Lambda of Simulated Annealing";
    static String PENALTY_DESCRIPTION = "Penalty used for the fifth experiment";
    static String HEURISTIC_DESCRIPTION = "Heuristic selected for Hill Climbing";

    private static Option setOption(String option, String long_option, boolean hasArg, String description) {
        Option op = new Option(option, long_option, hasArg, description);
        op.setRequired(false);
        return op;
    }

    private static Options setOptions() {
        Options options = new Options();
        options.addOption(setOption(ALGORITHM_OPTION, ALGORITHM_LONG_OPTION, false, ALGORITHM_DESCRIPTION));
        options.addOption(setOption(INITIAL_SOLUTION_OPTION, INITIAL_SOLUTION_LONG_OPTION, true, INITIAL_SOLUTION_DESCRIPTION));
        options.addOption(setOption(SEED_OPTION, SEED_LONG_OPTION, true, SEED_DESCRIPTION));
        options.addOption(setOption(NUM_CLIENTS_OPTION, NUM_CLIENTS_LONG_OPTION, true, NUM_CLIENTS_DESCRIPTION));
        options.addOption(setOption(NUM_CENTRALS_OPTION, NUM_CENTRALS_LONG_OPTION, true, NUM_CENTRALS_DESCRIPTION));
        options.addOption(setOption(PROP_CLIENTS_TYPE_XG_OPTION, PROP_CLIENTS_TYPE_XG_LONG_OPTION, true, PROP_CLIENTS_TYPE_XG_DESCRIPTION));
        options.addOption(setOption(PROP_CLIENTS_TYPE_MG_OPTION, PROP_CLIENTS_TYPE_MG_LONG_OPTION, true, PROP_CLIENTS_TYPE_MG_DESCRIPTION));
        options.addOption(setOption(PROP_CLIENTS_TYPE_G_OPTION, PROP_CLIENTS_TYPE_G_LONG_OPTION, true, PROP_CLIENTS_TYPE_G_DESCRIPTION));
        options.addOption(setOption(PROP_CENTRALS_TYPE_A_OPTION, PROP_CENTRALS_TYPE_A_LONG_OPTION, true, PROP_CENTRALS_TYPE_A_DESCRIPTION));
        options.addOption(setOption(PROP_CENTRALS_TYPE_B_OPTION, PROP_CENTRALS_TYPE_B_LONG_OPTION, true, PROP_CENTRALS_TYPE_B_DESCRIPTION));
        options.addOption(setOption(PROP_CENTRALS_TYPE_C_OPTION, PROP_CENTRALS_TYPE_C_LONG_OPTION, true, PROP_CENTRALS_TYPE_C_DESCRIPTION));
        options.addOption(setOption(PROP_CLIENTS_GUARANTEED_OPTION, PROP_CLIENTS_GUARANTEED_LONG_OPTION, true, PROP_CLIENTS_GUARANTEED_DESCRIPTION));
        options.addOption(setOption(STEPS_OPTION, STEPS_LONG_OPTION, true, STEPS_DESCRIPTION));
        options.addOption(setOption(STITER_OPTION, STITER_LONG_OPTION, true, STITER_DESCRIPTION));
        options.addOption(setOption(K_OPTION, K_LONG_OPTION, true, K_DESCRIPTION));
        options.addOption(setOption(LAMBDA_OPTION, LAMBDA_LONG_OPTION, true, LAMBDA_DESCRIPTION));
        options.addOption(setOption(PENALTY_OPTION, PENALTY_LONG_OPTION, true, PENALTY_DESCRIPTION));
        options.addOption(setOption(HEURISTIC_OPTION, HEURISTIC_LONG_OPTION, true, HEURISTIC_DESCRIPTION));
        return options;
    }

    private static void printArgs(boolean hillClimbing, int initialSolution, int seed, int numClients, int numCentrals,
                                  double propClientsTypeXG, double propClientsTypeMG, double propClientsTypeG,
                                  double propCentralsTypeA, double propCentralsTypeB, double propCentralsTypeC,
                                  double propGuaranteedClients, int steps, int stiter, int k, double lambda,
                                  double penalty, int heuristic) {
        String algorithm = "Simulated Annealing";
        if (hillClimbing)
            algorithm = "Hill Climbing";
        System.out.println("Algorithm: " + algorithm);
        System.out.println("Initial solution: " + initialSolution);
        System.out.println(SEED_DESCRIPTION         + ": " + seed);
        System.out.println(NUM_CLIENTS_DESCRIPTION  + ": " + numClients);
        System.out.println(NUM_CENTRALS_DESCRIPTION + ": " + numCentrals);
        System.out.println(PROP_CLIENTS_TYPE_XG_DESCRIPTION + ": " + propClientsTypeXG);
        System.out.println(PROP_CLIENTS_TYPE_MG_DESCRIPTION + ": " + propClientsTypeMG);
        System.out.println(PROP_CLIENTS_TYPE_G_DESCRIPTION + ": " + propClientsTypeG);
        System.out.println(PROP_CENTRALS_TYPE_A_DESCRIPTION + ": " + propCentralsTypeA);
        System.out.println(PROP_CENTRALS_TYPE_B_DESCRIPTION + ": " + propCentralsTypeB);
        System.out.println(PROP_CENTRALS_TYPE_C_DESCRIPTION + ": " + propCentralsTypeC);
        System.out.println(PROP_CLIENTS_GUARANTEED_DESCRIPTION + ": " + propGuaranteedClients);
        System.out.println(STEPS_DESCRIPTION + ": " + steps);
        System.out.println(STITER_DESCRIPTION + ": " + stiter);
        System.out.println(K_DESCRIPTION + ": " + k);
        System.out.println(LAMBDA_DESCRIPTION + ": " + lambda);
        System.out.println(PENALTY_DESCRIPTION + ": " + penalty);
        System.out.println(HEURISTIC_DESCRIPTION + ": " + heuristic);
    }

    private static void printActions(List actions) {
        int counterA = 0;
        int counterE = 0;
        int counterM = 0;
        int counterS = 0;
        for (Object o : actions) {
            String action = (String) o;
            if (Objects.equals(action, "A\n"))
                counterA++;
            if (Objects.equals(action, "E\n"))
                counterE++;
            if (Objects.equals(action, "M\n"))
                counterM++;
            if (Objects.equals(action, "S\n"))
                counterS++;
        }
        System.out.println("Print actions:");
        System.out.println("A: " + counterA);
        System.out.println("E: " + counterE);
        System.out.println("M: " + counterM);
        System.out.println("S: " + counterS);
    }

    private static void printInstrumentation(Properties properties) {
        for (Object o : properties.keySet()) {
            String key = (String) o;
            String property = properties.getProperty(key);
            System.out.println(key + ": " + property);
        }
    }

    public static void printFinalState(State result) {
        System.out.println("Grafo estado final:");
        System.out.println("Centrales:");
        Centrales centrales = result.getCentrales();
        for (Central central : centrales) {
            System.out.println(central.getCoordX());
            System.out.println(central.getCoordY());
            System.out.println(central.getTipo());
        }

        System.out.println("Clientes:");

        Clientes clientes = result.getClientes();
        int i = 0;
        for (Cliente cliente : clientes) {
            System.out.println(cliente.getCoordX());
            System.out.println(cliente.getCoordY());
            System.out.println(cliente.getTipo());
            System.out.println(result.getCentralClient(i));
            i++;
        }
    }

    private static void printResult(State result, SearchAgent agent, Heuristic heuristic, double old_benef, boolean printActions) {
        printFinalState(result);
        if (printActions) printActions(agent.getActions());
        printInstrumentation(agent.getInstrumentation());
        System.out.println("Cost: " + (-heuristic.getHeuristicValue(result)) + ", clients: " + result.numClServed()
                + ", state: " + result + " Benefit: " + result.getBeneficio());

        System.out.println("DONE: OLD BENEF: " + old_benef + " AND NEW BENEF: " + result.getBeneficio());
    }

    private static void printResult2(State result, SearchAgent agent, Heuristic2 heuristic, double old_benef, boolean printActions) {
        printFinalState(result);
        if (printActions) printActions(agent.getActions());
        printInstrumentation(agent.getInstrumentation());

        System.out.println("Cost: " + (-heuristic.getHeuristicValue(result)) + ", clients: " + result.numClServed()
                + ", state: " + result + " Benefit: " + result.getBeneficio());

        System.out.println("DONE: OLD BENEF: " + old_benef + " AND NEW BENEF: " + result.getBeneficio());

        System.out.println("Max Granted Clients: " + result.getMaxnumCLG() + " Curr Granted Clients: " + result.getNumClG());

    }

    private static void executeHillClimbing(State initialState, int h) throws Exception {
        if (h == 0) {
            Heuristic heuristic = new Heuristic();
            Problem problem = new Problem(initialState, new SuccesorsHC(), new IsGoalState(), heuristic);
            Search search = new HillClimbingSearch();
            SearchAgent agent = new SearchAgent(problem, search);
            State result = (State) search.getGoalState();
            printResult(result, agent, heuristic, initialState.getBeneficio(), true);
        }
        else {
            Heuristic2 heuristic = new Heuristic2();
            Problem problem = new Problem(initialState, new SuccesorsHC(), new IsGoalState(), heuristic);
            Search search = new HillClimbingSearch();
            SearchAgent agent = new SearchAgent(problem, search);
            State result = (State) search.getGoalState();
            printResult2(result, agent, heuristic, initialState.getBeneficio(), true);
        }
    }

    private static void executeSimulatedAnnealing(State initialState, int steps, int stiter, int k, double lambda, int h) throws Exception {
        if (h == 0) {
            Heuristic heuristic = new Heuristic();
            Problem problem = new Problem(initialState, new SuccesorsSA(), new IsGoalState(), heuristic);
            SimulatedAnnealingSearch search = new SimulatedAnnealingSearch(steps, stiter, k, lambda);
            SearchAgent agent = new SearchAgent(problem, search);
            State result = (State) search.getGoalState();
            printResult(result, agent, heuristic, initialState.getBeneficio(), false);
        }
        else {
            Heuristic2 heuristic = new Heuristic2();
            Problem problem = new Problem(initialState, new SuccesorsSA(), new IsGoalState(), heuristic);
            SimulatedAnnealingSearch search = new SimulatedAnnealingSearch(steps, stiter, k, lambda);
            SearchAgent agent = new SearchAgent(problem, search);
            State result = (State) search.getGoalState();
            printResult2(result, agent, heuristic, initialState.getBeneficio(), false);
        }
    }

    public static void main(String[] args) throws Exception {
        boolean hillClimbing = true;
        int initialSolution = 4, seed = Utils.RAND_SEED, numClients = 100, numCentrals = 10;
        double propClientsTypeXG = 0.25, propClientsTypeMG = 0.3, propClientsTypeG = 0.45;
        double propCentralsTypeA = 0.125, propCentralsTypeB = 0.25, propCentralsTypeC = 0.625;
        double propGuaranteedClients = 0.75;
        int steps = 10000, stiter = 100, k = 25;
        double lambda = 0.01, penalty = 0.;
        int heuristic = 0;

        Options options = setOptions();
        HelpFormatter formatter = new HelpFormatter();
        CommandLineParser parser = new DefaultParser();
        CommandLine cmd;
        try {
            cmd = parser.parse(options, args);
            hillClimbing = !cmd.hasOption(ALGORITHM_OPTION);
            if (cmd.hasOption(INITIAL_SOLUTION_OPTION)) {
                initialSolution = Integer.parseInt(cmd.getOptionValue(INITIAL_SOLUTION_OPTION));
                if (initialSolution < 0 || initialSolution > 4) {
                    System.out.println("Initial solution is not between 0 and 4");
                    return;
                }
            }
            if (cmd.hasOption(SEED_OPTION))
                seed = Integer.parseInt(cmd.getOptionValue(SEED_OPTION));
            if (cmd.hasOption(NUM_CLIENTS_OPTION))
                numClients = Integer.parseInt(cmd.getOptionValue(NUM_CLIENTS_OPTION));
            if (cmd.hasOption(NUM_CENTRALS_OPTION))
                numCentrals = Integer.parseInt(cmd.getOptionValue(NUM_CENTRALS_OPTION));
            if (cmd.hasOption(PROP_CLIENTS_TYPE_XG_OPTION))
                propClientsTypeXG = Double.parseDouble(cmd.getOptionValue(PROP_CLIENTS_TYPE_XG_OPTION));
            if (cmd.hasOption(PROP_CLIENTS_TYPE_MG_OPTION))
                propClientsTypeMG = Double.parseDouble(cmd.getOptionValue(PROP_CLIENTS_TYPE_MG_OPTION));
            if (cmd.hasOption(PROP_CLIENTS_TYPE_G_OPTION))
                propClientsTypeG = Double.parseDouble(cmd.getOptionValue(PROP_CLIENTS_TYPE_G_OPTION));
            if (cmd.hasOption(PROP_CENTRALS_TYPE_A_OPTION))
                propCentralsTypeA = Double.parseDouble(cmd.getOptionValue(PROP_CENTRALS_TYPE_A_OPTION));
            if (cmd.hasOption(PROP_CENTRALS_TYPE_B_OPTION))
                propCentralsTypeB = Double.parseDouble(cmd.getOptionValue(PROP_CENTRALS_TYPE_B_OPTION));
            if (cmd.hasOption(PROP_CENTRALS_TYPE_C_OPTION))
                propCentralsTypeC = Double.parseDouble(cmd.getOptionValue(PROP_CENTRALS_TYPE_C_OPTION));
            if (cmd.hasOption(PROP_CLIENTS_GUARANTEED_OPTION))
                propGuaranteedClients = Double.parseDouble(cmd.getOptionValue(PROP_CLIENTS_GUARANTEED_OPTION));
            if (cmd.hasOption(STEPS_OPTION))
                steps = Integer.parseInt(cmd.getOptionValue(STEPS_OPTION));
            if (cmd.hasOption(STITER_OPTION))
                stiter = Integer.parseInt(cmd.getOptionValue(STITER_OPTION));
            if (cmd.hasOption(K_OPTION))
                k = Integer.parseInt(cmd.getOptionValue(K_OPTION));
            if (cmd.hasOption(LAMBDA_OPTION))
                lambda = Double.parseDouble(cmd.getOptionValue(LAMBDA_OPTION));
            if (cmd.hasOption(PENALTY_OPTION))
                penalty = Double.parseDouble(cmd.getOptionValue(PENALTY_OPTION));
            if (cmd.hasOption(HEURISTIC_OPTION))
                heuristic = Integer.parseInt(cmd.getOptionValue(HEURISTIC_OPTION));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            formatter.printHelp("User Profile Info", options);
            System.exit(1);
            return;
        }

        printArgs(hillClimbing, initialSolution, seed, numClients, numCentrals,
                propClientsTypeXG, propClientsTypeMG, propClientsTypeG, propCentralsTypeA, propCentralsTypeB, propCentralsTypeC,
                propGuaranteedClients, steps, stiter, k, lambda, penalty, heuristic);

        long start = System.nanoTime();     // Iniciamos temporizador

        int [] centrales = {(int) (numCentrals*propCentralsTypeA), (int) (numCentrals*propCentralsTypeB), (int) (numCentrals*propCentralsTypeC)};
        double [] clientes = {propClientsTypeXG, propClientsTypeMG, propClientsTypeG};
        State initialState = new State(seed, centrales, numClients, clientes, propGuaranteedClients, initialSolution, penalty, heuristic);

        if (hillClimbing)
            executeHillClimbing(initialState,heuristic);
        else
            executeSimulatedAnnealing(initialState, steps, stiter, k, lambda, heuristic);

        System.out.println("Elapsed time: " + ((System.nanoTime() - start)/1000000000.0) + " seconds");

    }
}
