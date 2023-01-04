import argparse
import random
import networkx as nx

# Throw an exception with a custom message
class Error(Exception):
    def __init__(self, message):
        self.message = message

def create_graph(nBases, seed):
    G = nx.connected_watts_strogatz_graph(nBases, 3, 0.5, seed=seed)
    bases = {
        'almacenes': [],
        'asentamientos': []
    }
    for i in range(nBases):
        if (i == nBases - 1) and (len(bases['almacenes']) == 0):
            bases['almacenes'].append(i)
        elif (i == nBases - 1) and (len(bases['asentamientos']) == 0):
            bases['asentamientos'].append(i)
        elif (round(random.random()) == 0):
            bases['almacenes'].append(i)
        else:
            bases['asentamientos'].append(i)

    return G, bases

def get_objects(rovers, petitions, bases):
    objects = '(:objects\n'
    # Add rovers
    objects += '    '
    for i in range(rovers):
        objects += 'r'+str(i) + ' '
    objects += '- rover\n'
    # Add stroes
    objects += '    '
    for i in bases['almacenes']:
        objects += 'b'+str(i) + ' '
    objects += '- almacen\n'
    # Add settlements
    objects += '    '
    for i in bases['asentamientos']:
        objects += 'b'+str(i) + ' '
    objects += '- asentamiento\n'
    # Add petitions
    objects += '    '
    for i in range(petitions):
        objects += 'p'+str(i) + ' '
    objects += '- peticion\n'
    objects += ')\n'

    return objects

def get_init(rovers, petitions, load, nBases, bases, G):
    # Distribute petitions and supplies
    actual_supplies = random.randint(0, load)
    actual_staff = load - actual_supplies
    petitions_supplies = random.randint(actual_supplies, petitions - actual_staff)
    petitions_staff = petitions - petitions_supplies
    
    init = '(:init\n' +\
            '    (= (peticiones-cerradas) 0)\n'
    # Add paths
    for i in range(nBases):
        for j in list(G[i]):
            if i < j:
                init += '    (camino b' + str(i) + ' b' + str(j) + ')\n'
    # Distribute supplies between stores
    m = len(bases['almacenes'])
    supplies_lst = [0] * m
    for i in range(actual_supplies):
        supplies_lst[random.randint(0, actual_supplies) % m] += 1
    # Add supplies
    j = 0
    for i in bases['almacenes']:
        init += '    (= (suministros-base b'+str(i) + ') ' + str(supplies_lst[j]) + ')\n'
        j += 1
    # Distribute staff between settlements
    m = len(bases['asentamientos'])
    staff_lst = [0] * m
    for i in range(actual_staff):
        staff_lst[random.randint(0, actual_staff) % m] += 1
    # Add supplies
    j = 0
    for i in bases['asentamientos']:
        init += '    (= (personal-base b'+str(i) + ') ' + str(staff_lst[j]) + ')\n'
        j += 1
    # Add rovers
    for i in range(rovers):
        r = 'r' + str(i)
        init += '    ' +\
            '(= (suministros-rover ' + r + ') 0) ' +\
            '(= (personal-rover ' + r + ') 0) ' +\
            '(estacionado ' + r + ' b' + str(random.randint(0, nBases-1)) + ')\n'
    # Add petitions
    for i in range(petitions_supplies):
        p = 'p' + str(i)
        init += '    '+\
            '(peticion-abierta ' + p + ' b' + str(random.choice(bases['asentamientos'])) + ') ' +\
            '(peticion-suministros ' + p + ')\n'
    for i in range(petitions_staff):
        p = 'p' + str(i + petitions_supplies)
        init += '    '+\
            '(peticion-abierta ' + p + ' b' + str(random.choice(bases['asentamientos'])) + ') ' +\
            '(peticion-personal ' + p + ')\n'
    init += ')\n'

    return init

def write_file(rovers, petitions, load, nBases, seed, 
                fuelFactor, problem):
    # Set the seed for random cases
    random.seed(seed)

    # Obtain connected graph and categorize bases
    G, bases = create_graph(nBases, seed)

    header = '(define (problem ' + problem + ') (:domain peticionador)\n'
    objects = get_objects(rovers, petitions, bases)
    init = get_init(rovers, petitions, load, nBases, bases, G)
    goal = '(:goal\n    (= (peticiones-cerradas) ' + str(load) + ')\n)\n'
    f = open(problem + ".pddl", "w")
    f.write(header + objects + init + goal + ')')
    f.close()


def main():
    parser = argparse.ArgumentParser()
    # Add an argument to the number of rovers
    parser.add_argument('--rovers', type=int, 
        help='Number of rovers', required=True)
    # Add an argument to the number of petitions
    parser.add_argument('--petitions', type=int, 
        help='Number of petitions', required=True)
    # Add an argument to the number of supplies/staff
    parser.add_argument('--load', type=int, 
        help='Number of staff/supplies', required=True)
    # Add an argument to the number of bases
    parser.add_argument('--bases', type=int, 
        help='Number of bases', required=True)
    # Add an argument to the seed for random generator
    parser.add_argument('--seed', type=int, 
        help='Seed of the graph', default=0)
    # Add an argument to the fuel factor
    parser.add_argument('--fuel', type=int, 
        help='Fuel factor to optimize', default=1)
    # Add an argument to the name of the problem
    parser.add_argument('--problem', type=str, 
        help='Name of the problem', required=True)
    
    # Parse the command-line arguments
    args = parser.parse_args()

    # Access the values of the arguments
    rovers = args.rovers
    petitions = args.petitions
    load = args.load
    bases = args.bases
    seed = args.seed
    fuel = args.fuel
    problem = args.problem

    if (rovers < 1):
        raise Error('The number of rovers must be greater than 0')
    if (petitions < 1):
        raise Error('The number of petittions must be greater than 0')
    if (load < 1):
        raise Error('The number of staff/supplies must be greater than 0')
    if (bases < 2):
        raise Error('The number of petittions must be at least 2')
    if (petitions < load):
        raise Error('Number of personal/stuff is creater than the number of petitions')
    if (fuel < 0):
        raise Error('The fuel factor must be a positive integer')

    write_file(rovers, petitions, load, bases, seed, fuel, problem)

if __name__ == '__main__':
    main()