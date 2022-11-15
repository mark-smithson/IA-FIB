import aima.search.framework.GoalTest;

public class IsGoalState implements GoalTest {
    // solution will always be final and we want to optimize it to be better. Therefore, we always return false.
    public boolean isGoalState(Object o) {
        return false;
    }
}
